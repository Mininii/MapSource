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

	-- ����� ���������� ������ �迭���� �ҷ��� �� ���ġ
	-- 0xYYYYXXXX 0xLLIIPPUU
	-- X = ��ǥ X, Y = ��ǥ Y, L = ���� �ĺ���, I = ���� �÷���, P = �÷��̾�ID, U = ����ID
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
		NIfX(FP,Memory(0x628438,AtLeast,1)) -- ĵ��üũ.
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
		
		CTrigger(FP,{CVar(FP,UDataTemp[2][2],Exactly,0x10000,0x10000)},{TSetMemoryX(_Add(Nextptrs,55),SetTo,0x04000000,0x04000000)},1) -- �����÷��� 1�ϰ�� �������·� �ٲ�
		if X2_Mode == 1 then
			NJumpX(FP,X2_Jump,{CV(RepHeroIndex,104,AtMost),CD(X2_Hero,0,AtMost)},{AddCD(X2_Hero,1)})
		end
		CAdd(FP,UnitDataPtr,1)
		CJump(FP,FRJump)
		NElseX()
		f_ReplaceErrT = "\x07�� \x08ERROR : \x04ĵ������ ���� f_Replace�� ������ �� �����ϴ�! ��ũ�������� �����ڿ��� �������ּ���!\x07 ��"
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
		NIfX(FP,Memory(0x628438,AtLeast,1)) -- ĵ��üũ.
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
		
		CTrigger(FP,{TMemoryX(_Add(BackupCP,1),Exactly,0x10000,0x10000)},{TSetMemoryX(_Add(Nextptrs,55),SetTo,0x04000000,0x04000000)},1) -- �����÷��� 1�ϰ�� �������·� �ٲ�
		f_LoadCp()
		if X2_Mode == 1 then
			NJumpX(FP,X2_Jump,{CV(RepHeroIndex,104,AtMost),CD(X2_Hero,0,AtMost)},{AddCD(X2_Hero,1)})
		end
		NElseX()
		f_ReplaceErrT = "\x07�� \x08ERROR : \x04ĵ������ ���� f_Replace�� ������ �� �����ϴ�! ��ũ�������� �����ڿ��� �������ּ���!\x07 ��"
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
		DisplayText("\x12\x07�� \x04�ܾ��� �����մϴ�. \x07��",4),
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
local RerollSeedSwitch = {}
for i = 0, 63 do
	table.insert(RerollSeedSwitch,SetSwitch("Switch 100", Random))
end
-- 
MinGachaRand = f_CRandNum(100000)
local MGAmount = {20000,100000,500000,2000000,10000000}
local MGPerX = {0,50000,35000,13000,1500,500}
local TotalGPer = 0
local MGT = {
	StrDesignX("\x1F�̳׶� �ڽ�\x04�� �����Ͽ� 50.0% Ȯ���� \x1F 20,000 �̳׶�\x04�� \x07������ϴ�..."),
	StrDesignX("\x1F�̳׶� �ڽ�\x04�� �����Ͽ� 35.0% Ȯ���� \x1F 100,000 �̳׶�\x04�� \x07������ϴ�."),
	StrDesignX("\x1F�̳׶� �ڽ�\x04�� �����Ͽ� 13.0% Ȯ���� \x1F 500,000 �̳׶�\x04�� \x07������ϴ�."),
	StrDesignX("\x1F�̳׶� �ڽ�\x04�� �����Ͽ� 1.5% Ȯ���� \x1F 2,000,000 �̳׶�\x04�� \x07������ϴ�. \x04���ϵ帳�ϴ�!"),
	StrDesignX("\x1F�̳׶� �ڽ�\x04�� �����Ͽ� 0.5% Ȯ���� \x1F 10,000,000 �̳׶�\x04�� \x07������ϴ�. \x04���ϵ帳�ϴ�!"),
}
local errt = ""
for j,k in pairs(MGAmount) do
	local WAVRet = PlayWAV("staredit\\wav\\MMinus.wav")
	TotalGPer = TotalGPer+MGPerX[j]
	errt = errt..TotalGPer.."  "..MGPerX[j+1]-1+TotalGPer.."\n"
	if j == 1 then WAVRet = PlayWAV("staredit\\wav\\MPlus.wav") end
	if j == 5 then WAVRet = PlayWAV("staredit\\wav\\button3.wav") end
	if j == 4 then
		for p = 0, 6 do
			Trigger2X(FP,{VRange(MinGachaRand, TotalGPer, MGPerX[j+1]-1+TotalGPer),CV(MinGachaP,p)}, {RotatePlayer({DisplayTextX("\x13\x04"..string.rep("=",50).."\n\n\n"..StrDesignX(PlayerString[p+1].."\x04�� \x1F�̳׶� �ڽ�\x04���� 1.5% Ȯ���� \x1F2,000,000 �̳׶�\x04�� ������ϴ�. ���ϵ帳�ϴ�!!!!").."\n\n\n\x13\x04"..string.rep("=",50), 4),PlayWAVX("staredit\\wav\\clear2.ogg"),PlayWAVX("staredit\\wav\\clear2.ogg"),PlayWAVX("staredit\\wav\\clear2.ogg")}, HumanPlayers, FP)}, {preserved})
		end
	end
	if j == 5 then
		for p = 0, 6 do
			Trigger2X(FP,{VRange(MinGachaRand, TotalGPer, MGPerX[j+1]-1+TotalGPer),CV(MinGachaP,p)}, {RotatePlayer({DisplayTextX("\x13\x04"..string.rep("=",50).."\n\n\n"..StrDesignX(PlayerString[p+1].."\x04�� \x1F�̳׶� �ڽ�\x04���� 0.5% Ȯ���� \x1F10,000,000 �̳׶�\x04�� ������ϴ�. ���ϵ帳�ϴ�!!!!").."\n\n\n\x13\x04"..string.rep("=",50), 4),PlayWAVX("staredit\\wav\\Clear3.ogg"),PlayWAVX("staredit\\wav\\Clear3.ogg"),PlayWAVX("staredit\\wav\\Clear3.ogg")}, HumanPlayers, FP)}, {preserved})
		end
	end
	CTrigger(FP,{VRange(MinGachaRand, TotalGPer, MGPerX[j+1]-1+TotalGPer)}, {TSetMemory(0x6509B0, SetTo, MinGachaP),TSetResources(MinGachaP, Add, MGAmount[j], Ore),WAVRet,DisplayText(MGT[j], 4)}, {preserved})

	DoActions2X(FP, RerollSeedSwitch)
end
--PushErrorMsg(errt)
SetCallEnd()
MarGachaP = CreateVar(FP)
MarGacha = SetCallForward()
ELevel = CreateVar(FP)
SetCall(FP)
MinGachaRand = f_CRandNum(100000)
local MarGPer = {100000,50000,35000,10000,3500,1000,490,10}--�ϸ� ���� ���� �׺�� �׶� ���۳�� ���̻�
local MarGPerX = {0,65000,20000,8900,4100,1700,250,50}--�ϸ� ���� ���� �׺�� �׶� ���۳�� ���̻�
local TotalGPer = 0
local MarGUID = {0,20,100,16,99,12,60}--�ϸ� ���� ���� �׺�� �׶� ���۳�� ���̻�
-- �������� �׶���� ����, 3�� ��ĥ��� �������� 1��� ��ȯ����
local MGT = {
	StrDesign("\x0465.00% Ȯ���� Marine \x04�� \x07������ϴ�."),
	StrDesign("\x0420.00% Ȯ���� \x1BH \x04Marine \x04�� \x07������ϴ�."),
	StrDesign("\x048.90% Ȯ���� \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine \x04�� \x07������ϴ�."),
	StrDesign("\x044.10% Ȯ���� \x11��\x07��\x1F��\x1C��\x17��\x11�� \x04�� \x07������ϴ�. \x11���ϵ帳�ϴ�!"),
	StrDesign("\x041.70% Ȯ���� \x10��\x07��\x0F�ң�\x1F�� \x04�� \x07������ϴ�. \x11���ϵ帳�ϴ�!"),
	StrDesign("\x040.25% Ȯ���� \x07��\x1F��\x1C��\x0E��\x0F��\x10��\x17��\x11��\x08�� \x04��\x07������ϴ�. \x11���ϵ帳�ϴ�!"),
	StrDesign("\x040.05% Ȯ���� \x11��\x1F��\x1B��\x16��\x10��\x1D�� \x04��\x07������ϴ�. \x11���ϵ帳�ϴ�!"),
}


local errt = ""
for j = 1, #MarGPerX-1 do
	WAVRet = PlayWAV("staredit\\wav\\button3.wav")
	TotalGPer = TotalGPer+MarGPerX[j]
	if j == 4 or j == 5 then WAVRet = PlayWAV("staredit\\wav\\seeya.ogg") end
	if j == 6 or j == 7 then WAVRet = PlayWAV("staredit\\wav\\button3.wav") end
	errt = errt..TotalGPer.."  "..MarGPerX[j+1]-1+TotalGPer.."\n"
	if j == 6 then
		for p = 0, 6 do
			Trigger2X(FP,{VRange(MinGachaRand, TotalGPer,MarGPerX[j+1]-1+TotalGPer),CV(MarGachaP,p)}, {RotatePlayer({DisplayTextX("\x13\x04"..string.rep("=",50).."\n\n\n"..StrDesignX(PlayerString[p+1].."\x04�� 0.25% Ȯ���� \x07��\x1F��\x1C��\x0E��\x0F��\x10��\x17��\x11��\x08�� \x04��\x07 ������ϴ�. \x11���ϵ帳�ϴ�!!!!").."\n\n\n\x13\x04"..string.rep("=",50), 4),PlayWAVX("staredit\\wav\\clear2.ogg"),PlayWAVX("staredit\\wav\\clear2.ogg"),PlayWAVX("staredit\\wav\\clear2.ogg"),PlayWAVX("staredit\\wav\\clear2.ogg")}, HumanPlayers, FP),
		}, {preserved})
		end
	end
	if j == 7 then
		for p = 0, 6 do
			Trigger2X(FP,{VRange(MinGachaRand, TotalGPer,MarGPerX[j+1]-1+TotalGPer),CV(MarGachaP,p)}, {RotatePlayer({DisplayTextX("\x13\x04"..string.rep("=",50).."\n\n\n"..StrDesignX(PlayerString[p+1].."\x04�� 0.05% Ȯ���� \x11��\x1F��\x1B��\x16��\x10��\x1D�� \x04��\x07 ������ϴ�. \x11���ϵ帳�ϴ�!!!!").."\n\n\n\x13\x04"..string.rep("=",50), 4),PlayWAVX("staredit\\wav\\Clear3.ogg"),PlayWAVX("staredit\\wav\\Clear3.ogg"),PlayWAVX("staredit\\wav\\Clear3.ogg"),PlayWAVX("staredit\\wav\\Clear3.ogg")}, HumanPlayers, FP),
		}, {preserved})
		end
	end
	CTrigger(FP,{VRange(MinGachaRand, TotalGPer,MarGPerX[j+1]-1+TotalGPer)}, {TSetMemory(0x6509B0, SetTo, MarGachaP),SetV(ELevel,j-1),WAVRet,DisplayText(MGT[j], 4)}, {preserved})
	DoActions2X(FP, RerollSeedSwitch)
	

end
--PushErrorMsg(errt)
TotalGPer = TotalGPer+MarGPerX[8]
--PushErrorMsg(TotalGPer)
for p = 0, 6 do
	CIf(FP,{CV(MarGachaP,p)})
		CMovX(FP,VArr(MarCreateVArr[p+1], ELevel),1,Add)
	CIfEnd()
end



SetCallEnd()

Call_Print13 = {}
for i = 0, 6 do
Call_Print13[i+1] = SetCallForward()
SetCall(FP)
	Print_13_2(FP,{i},nil)
SetCallEnd()
end
end