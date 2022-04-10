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
	CTrigger(FP,{CVar(FP,Dt[2],AtMost,2500)},{Gun_SetLineX(4,Add,Dt)},1)

	
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
		if TestStart == 1 then
			ItoDec(FP,f_GunNum,VArr(f_GunNumT,0),2,0x1F,0)
			_0DPatchX(FP,f_GunNumT,5)
			f_Movcpy(FP,_Add(f_GunStrPtr,f_GunT[2]),VArr(f_GunNumT,0),5*4)
			DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0Df_Gun".._0D,4)},HumanPlayers,FP)})
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
		TSetMemory(_Add(G_TempV,3*(0x20/4)),SetTo,EXCunitTemp[1]),
		TSetMemory(_Add(G_TempV,53*(0x20/4)),SetTo,Gun_Type),
	})
	
	if TestStart == 1 then
	ItoDec(FP,G_CA,VArr(f_GunNumT,0),2,0x1F,0)
	_0DPatchX(FP,f_GunNumT,5)
	f_Movcpy(FP,_Add(f_GunSendStrPtr,f_GunSendT[2]),VArr(f_GunNumT,0),5*4)
	DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0Df_GunSend".._0D,4)},HumanPlayers,FP)})
	end
	CElseX()
	DoActions(FP,{RotatePlayer({DisplayTextX(G_SendErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
	CIfXEnd()
	f_LoadCp()
SetCallEnd()
UnitIDV = CreateVar(FP)
TempLvHP = CreateVar(FP)
TempLvHP2 = CreateVar(FP)
MultiplierV = CreateVar(FP)
TempLvHP_L = CreateWar(FP)
TempLvHP_L2 = CreateWar(FP)
TempLvHP_L3 = CreateWar(FP)
HPMul = CreateVar(FP)
f_SetLvHP = SetCallForward()
SetCall(FP)

		f_LMul(FP,TempLvHP_L,{VArr(MaxHPBackUp,UnitIDV),0},{_Mul(MultiplierV,_Sub(Level,_Mov(1))),0})
		CMov(FP,HPMul,_Sub(_Mov(256),TotalAHP))
		f_LMul(FP,TempLvHP_L2,_LDiv(TempLvHP_L,"256"),{HPMul,0})
		TriggerX(FP,{CWar(FP,TempLvHP_L2[2],AtLeast,"2129920000")},{SetCWar(FP,TempLvHP_L2[2],SetTo,"2129920000")},{Preserved})
		TriggerX(FP,{CWar(FP,TempLvHP_L2[2],AtMost,"255")},{SetCWar(FP,TempLvHP_L2[2],SetTo,"256")},{Preserved})
		f_Cast(FP,{TempLvHP2,0},TempLvHP_L2) 
		
		CIfX(FP,{TMemory(_Mem(_Add(TempLvHP2,TempLvHP)),AtLeast,8320000*256)})
			CDoActions(FP,{TSetMemory(_Add(UnitIDV,EPD(0x662350)),SetTo,8320000*256)})
		CElseX()
			CDoActions(FP,{TSetMemory(_Add(UnitIDV,EPD(0x662350)),SetTo,_Add(TempLvHP2,TempLvHP))})
		CIfXEnd()
SetCallEnd()

f_Replace = SetCallForward()
SetCall(FP)
	CIfX(FP,Memory(0x628438,AtLeast,1))
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
	CDoActions(FP,{
		TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(CC_Header,((0x20*8)/4))),SetTo,1),
		TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),CC_Header),SetTo,Gun_LV)})
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
	CTrigger(FP,{TMemoryX(_Add(BackupCP,1),Exactly,0x10000,0x10000)},{TSetMemoryX(_Add(Nextptrs,55),SetTo,0x04000000,0x04000000)},1) -- 무적플래그 1일경우 무적상태로 바꿈
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
	CMov(FP,CurArr,0)
	CWhile(FP,CVar(FP,CurArr[2],AtMost,999))
	CDoActions(FP,{
		TSetMemory(_Add(XY_ArrHeader,CurArr),SetTo,0)
	})
	CAdd(FP,CurArr,1)
	CWhileEnd()
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
		CifEnd()
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

	
	local VoidResetTable = {}
	for i = 0, 2000 do
	table.insert(VoidResetTable,(SetVoid(i,SetTo,0)))
	end
	Call_VoidReset = SetCallForward()
	SetCall(FP)
		DoActions2(FP,VoidResetTable)
	SetCallEnd()

	Call_ScorePrint = SetCallForward()
	SetCall(FP)
	
		local ExScoreVA = Create_VArrTable(7,13)
		local ExScoreP = Create_VTable(7)
		local TotalScoreVA = CreateVArray(FP,7)
		local DBossScoreVA = CreateVArray(FP,7)
		TxtSkip = Str10[2] + GetStrSize(0,"\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x04 : \x1F\x0d\x0d\x0d\x0d\x0d\x0d") + (4*6)
		for i = 1, 7 do
			if TestStart == 1 then
				TriggerX(FP,{CVar(FP,ExScore[i],AtLeast,0x80000000)},{SetCVar(FP,ExScore[i],SetTo,0)},{Preserved})
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
					CIfX(FP,{CVar(FP,ExScore[i+1][2],AtMost,0x7FFFFFFF)})
					
					CIfX(FP,{CVar(FP,SetPlayers[2],Exactly,1)})
					CMov(FP,ReadScore,0)
					CElseX()
					f_Div(FP,ReadScore,ExScore[i+1],1000)
					CIfXEnd()
					CElseX()
					CMov(FP,ReadScore,0)
					CIfXEnd()
					if Limit == 1 then
						f_Mul(FP,ReadScore,_Mov(2))
					end
					CIf(FP,CVar(FP,MulPoint[2],AtLeast,1))
						f_Mul(FP,ReadScore,MulPoint)
					CIfEnd()
					CDoActions(FP,{TSetDeaths(i,Add,ReadScore,4),SetDeaths(i,SetTo,1,14)})
					CTrigger(FP,{TDeaths(i,AtMost,ExScore[i+1],24),CVar(FP,ExScore[i+1][2],AtMost,0x7FFFFFFF)},{TSetDeaths(i,SetTo,ExScore[i+1],24),SetMemory(0x6509B0,SetTo,i),
					DisplayText("\x13\x1F!!!ＮＥＷ ＲＥＣＯＲＤ \x07～ 킬 스코어 기록갱신! ～ \x1FＮＥＷ ＲＥＣＯＲＤ !!!",4),
					PlayWAV("staredit\\wav\\LimitBreak.ogg"),
					PlayWAV("staredit\\wav\\LimitBreak.ogg"),
					PlayWAV("staredit\\wav\\LimitBreak.ogg"),
					SetMemory(0x6509B0,SetTo,FP)},1)
					GetPVA = CreateVArray(FP,13)
					ItoDecX(FP,ReadScore,VArr(GetPVA,0),2,0x7,2)
					_0DPatchX(FP,GetPVA,12)
					CIfX(FP,CVar(FP,SetPlayers[2],AtLeast,2))
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
if TestStart == 1 then
	CIf(FP,CDeaths(FP,AtLeast,0,isDBossClear),{SetCDeaths(FP,SetTo,0,isDBossClear),SetCVar(FP,OutputPoint[2],SetTo,0)})
else
	CIf(FP,CDeaths(FP,AtLeast,1,isDBossClear),SetCDeaths(FP,SetTo,0,isDBossClear))
end
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

end