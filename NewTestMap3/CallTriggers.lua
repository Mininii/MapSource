function Install_CallTriggers()
CreateStackedUnit = SetCallForward()
SUnitID = CreateVar(FP)
SLocation = CreateVar(FP)
DLocation = CreateVar(FP)
SPlayer = CreateVar(FP)
SAmount = CreateVar(FP)
SetCall(FP)
	CTrigger(FP,{CV(SPlayer,0x7FFFFFFF)},{SetV(SPlayer,GCP)},{preserved})
	CTrigger(FP,{CV(SLocation,0x7FFFFFFF,AtLeast)},{SubV(SLocation,0x7FFFFFFF),AddV(SLocation,GCP)},{preserved})
	CTrigger(FP,{CV(DLocation,0x7FFFFFFF,AtLeast)},{SubV(DLocation,0x7FFFFFFF),AddV(DLocation,GCP)},{preserved})
	

	CWhile(FP,{CV(SAmount,1,AtLeast)},{SubV(SAmount,1)})
	TriggerX(FP, {CV(SUnitID,16)}, {SetMemoryB(0x669E28+237, SetTo, 0)}, {preserved})
	TriggerX(FP, {CV(SUnitID,78)}, {SetMemoryB(0x669E28+237, SetTo, 16)}, {preserved})
	CIf(FP,{Memory(0x628438, AtLeast, 1)},{})--SetCD(TBLFlag,1)
		f_Read(FP, 0x628438, nil, Nextptrs)
		CDoActions(FP, {TCreateUnit(1,SUnitID,SLocation,SPlayer),
			TSetDeaths(_Add(Nextptrs,13),SetTo,4000,0),
			TSetDeathsX(_Add(Nextptrs,18),SetTo,4000,0,0xFFFF),
			TSetMemoryX(_Add(Nextptrs,8),SetTo,127*65536,0xFF0000),
			--TSetMemoryX(_Add(Nextptrs,55),SetTo,0xA00000,0xA00000),
		})
		--local NBTemp = CreateVar(FP)
		--NBagLoop(FP,NBagArr,{NBTemp})

		--CMov(FP,0x6509B0,NBTemp,19)
		--NIf(FP,{DeathsX(CurrentPlayer, Exactly, 0, 0, 0xFF00)})
		--	NRemove(FP,NBagArr)
		--NIfEnd()

		--NBagLoopEnd()
		CMov(FP,0x6509B0,FP)
		
		NAppend(FP, NBagArr, Nextptrs)
		--CTrigger(FP,{},{TSetMemoryX(_Add(Nextptrs,9),SetTo,0,0xFF000000),},1)
		CSub(FP,CurCunitI,Nextptrs,19025)
		CDiv(FP,CurCunitI,84)
		local TempV = CreateVar(FP)
		CMov(FP,TempV,_Add(_Mul(CurCunitI,0x970/4),_Add(CT_Cunit[3],((0x20*0)/4))))
		CDoActions(FP, {
			TSetMemory(TempV,SetTo,_Xor(CT_GNextRandV,SUnitID)),
			TSetMemory(_Add(TempV,0x20/4),SetTo,CT_GNextRandV),
			TSetMemory(_Add(TempV,0x40/4),SetTo,_Xor(CT_GNextRandV,SPlayer)),})
		CTSUPtr = CreateVar(FP)
		CTSUID = CreateVar(FP)
			--DisplayPrint(Force1, {"\x13\x04CTSUPtr : ",SUnitID})--
		CIf(FP,{TTOR({
			CV(SUnitID,5),
			CV(SUnitID,23),
			CV(SUnitID,30),
			CV(SUnitID,3),
			CV(SUnitID,17),
		})})
			f_Read(FP, _Add(Nextptrs, 28), nil, CTSUPtr)
					--DisplayPrint(Force1, {"\x13\x04CTSUPtr : ",CTSUPtr})--
			CIf(FP,{CV(CTSUPtr,19025,AtLeast),CV(CTSUPtr,19025+(84*1699),AtMost)})
				f_Read(FP, _Add(CTSUPtr, 25), CTSUID, nil, 0xFF, 1)
					--DisplayPrint(Force1, {"\x13\x04CTSUID : ",CTSUID})--
				CSub(FP,CurCunitI,CTSUPtr,19025)
				CDiv(FP,CurCunitI,84)
				CMov(FP,TempV,_Add(_Mul(CurCunitI,0x970/4),_Add(CT_Cunit[3],((0x20*0)/4))))
				CDoActions(FP, {
					TSetMemory(TempV,SetTo,_Xor(CT_GNextRandV,CTSUID)),
					TSetMemory(_Add(TempV,0x20/4),SetTo,CT_GNextRandV),
					TSetMemory(_Add(TempV,0x40/4),SetTo,_Xor(CT_GNextRandV,SPlayer)),
				})
			CIfEnd()

		CIfEnd()
		--CallTrigger(FP, Call_CTInputUID)
	CIfEnd()
	CWhileEnd()
	CTrigger(FP, {CV(DLocation,1,AtLeast)}, {TOrder(SUnitID, SPlayer, SLocation, Move, DLocation)},1)

SetCallEnd()
function CreateUnitStacked(Condition,Amount,UnitID,Location,DestLocation,Player,AddTrig,Preserved)
	if DestLocation == nil then DestLocation = 0 end
	CallTriggerX(FP, CreateStackedUnit, Condition, {
		SetNVar(SAmount,SetTo,Amount),
		SetNVar(SUnitID,SetTo,UnitID),
		SetNVar(SLocation,SetTo,Location),
		SetNVar(DLocation,SetTo,DestLocation),
		SetNVar(SPlayer,SetTo,Player),AddTrig
	}, Preserved)
end

function CreateUnitStackedCp(Condition,Amount,UnitID,Location,DestLocation,AddTrig,Preserved)
	if DestLocation == nil then DestLocation = 0 else DestLocation = DestLocation+0x7FFFFFFF end
	CallTriggerX(FP, CreateStackedUnit, Condition, {
		SetNVar(SAmount,SetTo,Amount),
		SetNVar(SUnitID,SetTo,UnitID),
		SetNVar(SLocation,SetTo,Location+0x7FFFFFFF),
		SetNVar(DLocation,SetTo,DestLocation),
		SetNVar(SPlayer,SetTo,0x7FFFFFFF),AddTrig
	}, Preserved)
end

EnchNum = CreateVar(FP)
EnchNum2 = CreateVar(FP)
EnchNum3 = CreateVar(FP)
EnchMoney = CreateWar(FP)
EnchCost = CreateWar(FP)
Result = CreateVar(FP)
Call_Ench = SetCallForward()
SetCall(FP)
E4Range = CreateVarArr(2, FP)
E3Range = CreateVarArr(2, FP)
E2Range = CreateVarArr(2, FP)
E1Range = CreateVarArr(2, FP)
PVtoV(iv.Money, EnchMoney)
CMov(FP,EnchNum2,EnchNum,1)
CMov(FP,EnchNum3,EnchNum,-1)
if Limit == 1 then
	DisplayPrint(GCP, {EnchCost})
end
CIfX(FP, {TTNWar(EnchMoney,AtLeast,EnchCost)}, {})
f_LSub(FP, EnchMoney, EnchMoney, EnchCost)
GetEPer = f_CRandNum(100000) -- 랜덤 난수 생성. GetEPer 사용 종료까지 재생성 금지

if Limit == 1 then
DisplayPrint(GCP,{"\x04출력된 난수 : ",GetEPer})
DisplayPrint(GCP,{"\x1F계산된 성공 확률 : ",E1Range[1]," \x04~ ",E1Range[2]})
DisplayPrint(GCP,{"\x1F계산된 유지 확률 : ",E2Range[1]," \x04~ ",E2Range[2]})
DisplayPrint(GCP,{"\x1F계산된 하락 확률 : ",E3Range[1]," \x04~ ",E3Range[2]})
DisplayPrint(GCP,{"\x1F계산된 파괴 확률 : ",E4Range[1]," \x04~ ",E4Range[2]})
end


CIfX(FP,{TNVar(GetEPer, AtLeast, E1Range[1]),TNVar(GetEPer, AtMost, E1Range[2])},SetV(Result,1))--성공
DisplayPrint(GCP,{"\x13\x07『 \x04강화에 \x07성공\x04하였습니다!. \x17",EnchNum,"강 \x04→ \x07",EnchNum2,"강 \x07』"})

CElseIfX({TNVar(GetEPer, AtLeast, E2Range[1]),TNVar(GetEPer, AtMost, E2Range[2])},SetV(Result,2))--유지
DisplayPrint(GCP,{"\x13\x07『 \x04강화에 \x08실패\x04하였습니다!. \x07강화 \x04단계가 \x10유지됩니다. \x07』"})

CElseIfX({TNVar(GetEPer, AtLeast, E3Range[1]),TNVar(GetEPer, AtMost, E3Range[2])},SetV(Result,3))--하락
DisplayPrint(GCP,{"\x13\x07『 \x04강화에 \x08실패\x04하였습니다!. \x17",EnchNum,"강 \x04→ \x08",EnchNum3,"강 \x07』"})

CElseX(SetV(Result,4))--실패
DisplayPrint(GCP,{"\x13\x07『 \x04강화에 \x08실패\x04하여 \x08유닛이 파괴되었습니다.. \x07』"})
CIfXEnd()

CElseX()
DisplayPrint(GCP,{StrDesignX("\x04잔액이 부족하여 강화할 수 없습니다.")})
CIfXEnd()
VtoPV(EnchMoney,iv.Money)

SetCallEnd()

end