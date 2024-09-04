
function Install_CallTriggers()
    
GiveAlarm = SetCallForward()
GivePrevP = CreateVar(FP)
GiveNextP = CreateVar(FP)
GiveMin = CreateVar(FP)
SetCall(FP)
DisplayPrint(GivePrevP, {"\x07『 ",PName(GiveNextP),"\x04에게 \x1F",GiveMin," Ore\x04를 기부하였습니다. \x07』"})
DisplayPrint(GiveNextP, {"\x12\x07『 ",PName(GivePrevP),"\x04에게 \x1F",GiveMin," Ore\x04를 기부받았습니다.\x02 \x07』"})
SetCallEnd()


function CreateBPtrRetArr(MaxPlayer,Ptr,Multiplier)
	local X = {}
	local Y = {}
	for i = 0, MaxPlayer do
		table.insert(X,(Ptr+(i*Multiplier))%4)
		table.insert(Y,(Ptr+(i*Multiplier))-X[i+1])
	end
	return X,Y
end

TempMul_254,TempMul_255,TempMul_1,TempFactor = CreateVars(4,FP)
UpgradeCP,TempUpgradePtr,TempUpgradeMaskRet,UpgradeMax,UpResearched,UpCost,UpCompleted = CreateVariables(8)
UpMaster = CreateCcode()

TempUpgradeLimPtr = CreateVar(FP)
TempUpgradeLimMaskRet = CreateVar(FP)
UpLimit = CreateVar(FP)
UpCount = CreateVar(FP)

AtkUpgradeMaskRetArr, AtkUpgradePtrArr = CreateBPtrRetArr(7,0x58D2B0+7,46)
HPUpgradeMaskRetArr, HPUpgradePtrArr = CreateBPtrRetArr(7,0x58D2B0,46)
AtkUpgradeMaskLimRetArr, AtkUpgradeLimPtrArr = CreateBPtrRetArr(7,0x58D088+7,46)
HPUpgradeMaskLimRetArr, HPUpgradeLimPtrArr = CreateBPtrRetArr(7,0x58D088,46)
ShUpgradeMaskRetArr, ShUpgradePtrArr = CreateBPtrRetArr(7,0x58D2B0+15,46)
ShUpgradeMaskLimRetArr, ShUpgradeLimPtrArr = CreateBPtrRetArr(7,0x58D088+15,46)

OneClickUpgrade = SetCallForward()
UpResultFlag = CreateCcode()--1 = 성공실패여부
MinCostBase = CreateVar(FP)
MinCostFactor = CreateVar(FP)
UpgradeFlag = CreateVar(FP)
SetCall(FP) 
--0x655740 미네랄 코스트 베이스 2바이트
--0x6559C0 미네랄 코스트 증가량 2바이트
	CIfX(FP,{CV(UpgradeFlag,1)})
	f_WreadX(FP, 0x655740, 7, MinCostBase)
	f_WreadX(FP, 0x6559C0, 7, MinCostFactor)
	CElseIfX({CV(UpgradeFlag,2)})

	f_WreadX(FP, 0x655740, 0, MinCostBase)
	f_WreadX(FP, 0x6559C0, 0, MinCostFactor)
	CElseIfX({CV(UpgradeFlag,3)})
	f_WreadX(FP, 0x655740, 15, MinCostBase)
	f_WreadX(FP, 0x6559C0, 15, MinCostFactor)
	CIfXEnd()


	f_Read(FP,TempUpgradePtr,UpResearched)
	f_Read(FP,TempUpgradeLimPtr,UpLimit)
	CIf(FP,CVar(FP,TempUpgradeLimMaskRet[2],AtMost,256^2))
		CMod(FP,UpLimit,_Mul(TempUpgradeLimMaskRet,_Mov(256)))
	CIfEnd()
	CIf(FP,CVar(FP,TempUpgradeMaskRet[2],AtMost,256^2))
		CMod(FP,UpResearched,_Mul(TempUpgradeMaskRet,_Mov(256)))
	CIfEnd()
	CDiv(FP,UpResearched,TempUpgradeMaskRet)
	CDiv(FP,UpLimit,TempUpgradeLimMaskRet)
	f_Mul(FP,TempMul_254,TempUpgradeMaskRet,_Mov(254))
	f_Mul(FP,TempMul_255,TempUpgradeMaskRet,_Mov(255))
	f_Mul(FP,TempMul_1,TempUpgradeMaskRet,_Mov(1))
	CMov(FP,0x6509B0,UpgradeCP)
	OCU_Jump = def_sIndex()
	CJumpEnd(FP,OCU_Jump)
	CAdd(FP,TempFactor,_Mul(UpResearched,MinCostFactor),MinCostBase)
	NWhile(FP,{
		TCVar(FP,UpResearched[2],AtMost,_Sub(UpLimit,1)),
		TAccumulate(CurrentPlayer,AtLeast,TempFactor,Ore),
		TMemoryX(TempUpgradePtr,AtMost,TempMul_254,TempMul_255)
	})
	for i = 0, 6 do
		CTrigger(FP, {CV(UpgradeCP,i)}, {SubV(CTMin[i+1],TempFactor)}, {preserved})
	end
		CDoActions(FP,{
			TSetCVar(FP,UpCost[2],Add,TempFactor),
			TSetResources(CurrentPlayer,Subtract,TempFactor,Ore),
			
			SetCVar(FP,UpResearched[2],Add,1),
			SetCVar(FP,UpCompleted[2],Add,1),
			SetCVar(FP, UpCount[2], Add, 1);
			--TSetCVar(FP,UpCost[2],Add,TempFactor),
			TSetMemoryX(TempUpgradePtr,Add,TempMul_1,TempMul_255);
			SetCD(UpResultFlag, 1);
		})
	--DisplayPrint(UpgradeCP, {"\x12\x07『 \x1FUpCount : ",UpCount,"  UpResearched : ",UpResearched,"  UpCompleted : ",UpCompleted," \x07』"})

		CJump(FP,OCU_Jump)
	NWhileEnd()
	CIfX(FP,{CD(UpResultFlag,1)})
	
	DisplayPrint(UpgradeCP, {"\x12\x07『 \x1F",UpCost," \x04미네랄을 소비하여 총 \x19",UpCompleted," \x04회 업그레이드를 완료하였습니다. \x07』"})
	--DisplayPrint(HumanPlayers, {"\x12\x07『 \x1FUpgradeCP : ",UpgradeCP," \x07』"})

	if Limit == 1 then 
	DisplayPrint(UpgradeCP, {"\x12\x07『 \x03TESTMODE OP \x04: 원클릭 업그레이드 테스트 문구  \x07』"})
	DisplayPrint(UpgradeCP, {"\x12\x07『 \x04업글 리미트 : \x1F",UpLimit,"\x04 업글 횟수 : \x1F",UpCount,"  \x07』"})
	DisplayPrint(UpgradeCP, {"\x12\x07『 \x04미네랄 베이스 가격 : \x1F",MinCostBase,"\x04 미네랄 증가량 가격 : \x1F",MinCostFactor,"  \x07』"})
	ResultMinCostBase = CreateVar(FP)
	CAdd(FP,ResultMinCostBase,_Mul(UpResearched,MinCostFactor),MinCostBase)
	DisplayPrint(UpgradeCP, {"\x12\x07『 \x04업글 완료 후 가격 : \x1F",ResultMinCostBase,"  \x07』"})

	end
	CTrigger(FP,{TCVar(FP,UpLimit[2],Exactly,UpResearched)},{
		TSetMemory(0x6509B0,SetTo,UpgradeCP),
		DisplayText("\x12\x07『 \x04업그레이드가 모두 완료되었습니다. \x07』",4),
		SetMemory(0x6509B0,SetTo,FP),SetCD(UpMaster,1)
	},{preserved})
	CElseX()
	CTrigger(FP,{TCVar(FP,UpLimit[2],Exactly,UpResearched)},{
		TSetMemory(0x6509B0,SetTo,UpgradeCP),
		DisplayText("\x12\x07『 \x04이미 업그레이드가 모두 완료되었습니다. \x07』",4),
		SetMemory(0x6509B0,SetTo,FP),SetCD(UpMaster,1)
	},{preserved})
	CTrigger(FP,{TTCVar(FP,UpLimit[2],NotSame,UpResearched),CVar(FP,UpCompleted[2],Exactly,0)},{
		TSetMemory(0x6509B0,SetTo,UpgradeCP),
		DisplayText("\x12\x07『 \x04잔액이 부족합니다. \x07』",4),
		SetMemory(0x6509B0,SetTo,FP)
	},{preserved})
	CIfXEnd()
	DoActionsX(FP,{
		SetCVar(FP,TempUpgradeMaskRet[2],SetTo,0),
		SetCVar(FP,TempUpgradePtr[2],SetTo,0),
		SetCVar(FP,UpResearched[2],SetTo,0),
		SetCVar(FP,UpLimit[2],SetTo,0), 
		SetCVar(FP,UpCount[2],SetTo,0), 
		SetCVar(FP,UpCost[2],SetTo,0),
		SetCVar(FP,UpCompleted[2],SetTo,0)
	})
SetCallEnd()


BX = CreateVar(FP)
BY = CreateVar(FP)
BIDV = CreateVar(FP)
BIndexV = CreateVar(FP)
Call_PlaceIndexedBuild = SetCallForward()
SetCall(FP)
Simple_SetLocX(FP, 0, BX, BY, BX, BY)

CIf(FP,{Memory(0x628438, AtLeast, 1)})
f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
CMov(FP,CunitIndex,_Div(_Sub(Nextptrs,19025),_Mov(84)))

CDoActions(FP, {
	TSetMemory(_Add(BIDV,EPDF(0x662860)) ,SetTo,1+65536),
	TCreateUnitWithProperties(1, BIDV, 1, P8, {energy = 100}),
	Set_EXCC2(DUnitCalc,CunitIndex,1,SetTo,1),
	Set_EXCC2(DUnitCalc,CunitIndex,2,SetTo,BIndexV),
})
CIfEnd()
SetCallEnd()

Call_MarCr=SetCallForward()
MID = CreateVar(FP)
MPID = CreateVar(FP)
MHP = CreateVar(FP)
MPosX = CreateVar(FP)
MPosY = CreateVar(FP)
SetCall(FP)
CIf(FP, {Memory(0x628438, AtLeast, 1)},{
	SetSwitch(RandSwitch1, Random),
	SetSwitch(RandSwitch2, Random)})
f_Read(FP, 0x628438, nil, Nextptrs)
f_Div(FP,CunitIndex,_Sub(Nextptrs,19025),_Mov(84))

DoActions(FP, {
	SetMemory(0x66EC48+(33*4), SetTo, 70),
	
})

for y = 0, 3 do
	if y == 0 then RS1 = Cleared RS2=Cleared end
	if y == 1 then RS1 = Set RS2=Cleared end
	if y == 2 then RS1 = Cleared RS2=Set end
	if y == 3 then RS1 = Set RS2=Set end
	CTrigger(FP, {Switch(RandSwitch1,RS1),Switch(RandSwitch2,RS2)}, {TCreateUnitWithProperties(1, MID, 16+y, MPID,{energy = 100})}, {preserved})
end

DoActions(FP, {
	SetMemory(0x66EC48+(33*4), SetTo, 20),
})

CIf(FP,{TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)},{TSetDeathsX(_Add(Nextptrs,9),SetTo,0,0,0xFF0000)})
f_Read(FP,_Add(Nextptrs,10),CPos)
Convert_CPosXY()
Simple_SetLocX(FP,0, CPosX,CPosY,CPosX,CPosY)
Simple_SetLocX(FP,200, MPosX,MPosY,MPosX,MPosY)
CDoActions(FP, {TOrder(MID,MPID,1,Move,6),TMoveUnit(1, MID, MPID, 1, 201)})
--CIfX(FP, {TMemory(_Add(Nextptrs,3), AtLeast, 1)})
--f_Read(FP, _Add(Nextptrs,3), nil, CSPtr)
--CElseX()
--CMov(FP,CSPtr,-2)
--CIfXEnd()
CDoActions(FP, {
Set_EXCC2(UnivCunit, CunitIndex, 1, SetTo, 24*5);
Set_EXCC2(UnivCunit, CunitIndex, 2, SetTo, 0);
Set_EXCC2(UnivCunit, CunitIndex, 3, SetTo, 0);
Set_EXCC2(UnivCunit, CunitIndex, 4, SetTo, 0);
Set_EXCC2(UnivCunit, CunitIndex, 8, SetTo, 0);
Set_EXCC2(UnivCunit, CunitIndex, 9, SetTo, _Mul(MPID, 65536));
Set_EXCC2(UnivCunit, CunitIndex, 10, SetTo, MHP);
})

CIf(FP,{TTOR({
	CV(MID,10),
	CV(MID,MarID[1]),
	CV(MID,MarID[2]),
	CV(MID,MarID[3]),
	CV(MID,MarID[4]),
	CV(MID,MarID[5]),
})})
for i = 0, 4 do
	CIf(FP,{CV(MPID,i)})
		CIf(FP,{CV(MID,10)})
			CMov(FP,SMPtr[i+1],Nextptrs)
		CIfEnd()
		CIf(FP,{CV(MID,MarID[i+1])})
			CMov(FP,RMPtr[i+1],Nextptrs)
		CIfEnd()
	CIfEnd()
end

CIfEnd()




CIfEnd()
CIfEnd()


SetCallEnd()

CallTombTrig =SetCallForward()
TPL = CreateVar(FP)
TUID = CreateVar(FP)
SetCall(FP)
f_Read(FP,_Sub(BackupCp,15),CPos)
Convert_CPosXY()
Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)

CIf(FP,{Memory(0x628438, AtLeast, 1)})
f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
CMov(FP,CunitIndex,_Div(_Sub(Nextptrs,19025),_Mov(84)))
CDoActions(FP, {
	TCreateUnitWithProperties(1, 215, 1, TPL, {energy = 100}),
	Set_EXCC2(DUnitCalc,CunitIndex,4,SetTo,TUID),
})
CIfEnd()


SetCallEnd()
end