
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

Call_RepeatOption = SetCallForward()
SetCall(FP)
RUID = CreateVar(FP)
RPID = CreateVar(FP)
RType = CreateVar(FP)
RPtr = CreateVar(FP)
RLocV = CreateVar(FP)
CIf(FP,{TMemoryX(_Add(RPtr,40),AtLeast,150*16777216,0xFF000000)})
		
		--CIf(FP,{TTOR({CV(RUID,25),CV(RUID,30)})})
		--CDoActions(FP,{
		--	TSetDeathsX(_Add(RPtr,72),SetTo,0xFF*256,0,0xFF00),TSetMemoryX(_Add(RPtr,68), SetTo, 600,0xFFFF)})
		--CIfEnd()

		f_Read(FP,_Add(RPtr,10),CPos)
		Convert_CPosXY()
		Simple_SetLocX(FP,71,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(71,-4,-4,4,4)})

        CTrigger(FP,{},{TMoveUnit(1,RUID,Force2,72,1)},{preserved})
			CIfX(FP,CVar(FP,RType[2],Exactly,0))
				f_Read(FP,_Add(RPtr,10),CPos)
				Convert_CPosXY()
				Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
				CTrigger(FP, {}, {TOrder(RUID, Force2, 1, Attack, RLocV);}, {preserved})

			CElseIfX(CVar(FP,RType[2],Exactly,1))
			
			f_Read(FP,_Add(RPtr,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CTrigger(FP, {}, {TOrder(RUID, Force2, 1, Attack, RLocV);}, {preserved})
			CDoActions(FP,{
				TSetMemory(_Add(RPtr,2), SetTo, _Div(_ReadF(_Add(RUID,EPD(0x662350))),2)),
			})

			CElseIfX(CVar(FP,RType[2],Exactly,187))
				CDoActions(FP,{
					TSetDeathsX(_Add(RPtr,19),SetTo,187*256,0,0xFF00),
				})

			CElseIfX(CVar(FP,RType[2],Exactly,189))
			CDoActions(FP,{
				TSetDeathsX(_Add(RPtr,19),SetTo,187*256,0,0xFF00),
				TCreateUnitWithProperties(1,84,1,RPID,{energy = 100}),TRemoveUnit(84,RPID)
			})
			CElseIfX(CVar(FP,RType[2],Exactly,190))
				f_Read(FP,_Add(RPtr,10),CPos)
				Convert_CPosXY()
				Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
				CDoActions(FP,{TSetMemory(_Add(RPtr,13),SetTo,1920)})
				CDoActions(FP,{
					TOrder(RUID, Force2, 1, Attack, RLocV);
					TSetDeathsX(_Add(RPtr,72),SetTo,0xFF*256,0,0xFF00),
					TSetMemoryX(_Add(RPtr,55),SetTo,0xA00000,0xA00000),
					
				})
			CElseIfX(CVar(FP,RType[2],Exactly,32))
			CDoActions(FP,{
				TSetDeathsX(_Add(RPtr,19),SetTo,187*256,0,0xFF00),
				TSetMemoryX(_Add(RPtr,55),SetTo,0x04000000,0x04000000),
				TSetMemoryX(_Add(RPtr,8), SetTo, 127*65536,0xFF0000),
				TSetDeaths(_Add(RPtr,13),SetTo,20000,0),
				TSetDeathsX(_Add(RPtr,18),SetTo,4000,0,0xFFFF)})

			CElseIfX(CVar(FP,RType[2],Exactly,188))
				--CIfX(FP,CVar(FP,HondonMode[2],AtMost,0))
				TempSpeedVar = f_CRandNum(8000)
				CDoActions(FP,{
					TSetMemoryX(_Add(RPtr,55),SetTo,0xA00000,0xA00000),
					TSetDeaths(_Add(RPtr,13),SetTo,_Add(TempSpeedVar,500),0),
					TSetDeathsX(_Add(RPtr,18),SetTo,_Add(TempSpeedVar,500),0,0xFFFF)})
				--CElseX()
				--CDoActions(FP,{
				--	TSetDeaths(_Add(RPtr,13),SetTo,12000,0),
				--	TSetDeathsX(_Add(RPtr,18),SetTo,4000,0,0xFFFF)})
				--CIfXEnd()
				CDoActions(FP,{
					TSetDeathsX(_Add(RPtr,19),SetTo,187*256,0,0xFF00),
					TSetMemory(_Add(RPtr,2), SetTo, _Div(_ReadF(_Add(RUID,EPD(0x662350))),2)),
				})

				CElseIfX(CVar(FP,RType[2],Exactly,191))

				--CIfX(FP,CVar(FP,HondonMode[2],AtMost,0))
				CDoActions(FP,{
					TSetDeaths(_Add(RPtr,13),SetTo,4000,0),
					TSetDeathsX(_Add(RPtr,18),SetTo,4000,0,0xFFFF)})
				--CElseX()
				--CDoActions(FP,{
				--	TSetDeaths(_Add(RPtr,13),SetTo,12000,0),
				--	TSetDeathsX(_Add(RPtr,18),SetTo,4000,0,0xFFFF)})
				--CIfXEnd()
				CDoActions(FP,{
					TSetDeathsX(_Add(RPtr,19),SetTo,187*256,0,0xFF00),
				})

			CElseIfX(CVar(FP,RType[2],Exactly,147))
			f_Read(FP,_Add(RPtr,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CDoActions(FP,{
				TOrder(RUID, Force2, 1, Attack, 23);
				TSetMemory(_Add(RPtr,13),SetTo,128),
				TSetMemoryX(_Add(RPtr,18),SetTo,128,0xFFFF),
				TSetDeathsX(_Add(RPtr,72),SetTo,0xFF*256,0,0xFF00),
				TSetMemoryX(_Add(RPtr,55),SetTo,0xA00000,0xA00000),
				CreateUnit(1,84,1,FP),KillUnit(84,FP)
			})

			CElseIfX(CVar(FP,RType[2],Exactly,3))
				CDoActions(FP,{
					TSetDeathsX(_Add(RPtr,72),SetTo,0xFF*256,0,0xFF00)})
			CElseIfX(CVar(FP,RType[2],Exactly,84))
			CDoActions(FP,{
				TSetMemoryX(_Add(RPtr,55),SetTo,0xA00000,0xA00000),KillUnit(84,FP)
			})

			CElseIfX(CVar(FP,RType[2],Exactly,130))
			f_Read(FP,_Add(RPtr,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			local SRet = CreateVar(FP)
			CiSub(FP,CPosX,16*64)
			CiSub(FP,CPosY,16*256)
			f_Sqrt(FP, SRet, _Div(_Add(_Square(CPosX),_Square(CPosY)),_Mov(5)))
			
			CDoActions(FP, {TSetMemoryX(_Add(RPtr,8),SetTo,127*65536,0xFF0000),
			TSetMemory(_Add(RPtr,13),SetTo,SRet),
			TSetMemoryX(_Add(RPtr,18),SetTo,SRet,0xFFFF),})
			Convert_CPosXY()


			CNeg(FP,CPosX)
			CAdd(FP,CPosX,32*64)
			CNeg(FP,CPosY)
			CAdd(FP,CPosY,32*256)
			Simple_SetLocX(FP,20,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			



			CDoActions(FP, {TOrder(RUID, Force2, 1, Patrol, 21);})

			

			CElseIfX(CVar(FP,RType[2],Exactly,201))
			f_Read(FP,_Add(RPtr,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CDoActions(FP,{
				TSetDeathsX(_Add(RPtr,19),SetTo,187*256,0,0xFF00),
				TSetMemoryX(_Add(RPtr,55),SetTo,0x04000000,0x04000000),
				TOrder(RUID, Force2, 1, Move, 36);
			})
			CElseIfX(CVar(FP,RType[2],Exactly,202))
			f_Read(FP,_Add(RPtr,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CTrigger(FP, {}, {TOrder(RUID, Force2, 1, Attack, RLocV);}, {preserved})
			
			CMov(FP,CunitIndex,_Div(_Sub(RPtr,19025),_Mov(84)))
			CDoActions(FP, {Set_EXCC2(DUnitCalc,CunitIndex,1,SetTo,1)})

			CElseIfX(CVar(FP,RType[2],Exactly,2))
			CElseX()
				DoActions(FP,RotatePlayer({DisplayTextX("\x07『 \x08ERROR : \x04잘못된 RepeatType이 입력되었습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』",4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP))
			CIfXEnd()
			--Simple_SetLocX(FP,0,G_CA_BackupX,G_CA_BackupY,G_CA_BackupX,G_CA_BackupY,{Simple_CalcLoc(0,-4,-4,4,4)})
			--CDoActions(FP,{TOrder(RUID,Force2,72,Attack,1)})
			
		CIfEnd()
SetCallEnd()

end