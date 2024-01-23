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
	CIf(FP,{Memory(0x628438, AtLeast, 1)},{SetCD(TBLFlag,1)})--
		f_Read(FP, 0x628438, nil, Nextptrs)
		CDoActions(FP, {TCreateUnitWithProperties(1,SUnitID,SLocation,SPlayer,{energy=100}),
			TSetDeaths(_Add(Nextptrs,13),SetTo,4000,0),
			TSetDeathsX(_Add(Nextptrs,18),SetTo,4000,0,0xFFFF),
			TSetMemoryX(_Add(Nextptrs,8),SetTo,127*65536,0xFF0000),
			TSetMemoryX(_Add(Nextptrs,55),SetTo,0xA00000,0xA00000),
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
AutoOp = CreateCcode()
if Limit == 1 then
	--DisplayPrint(GCP, {EnchCost})
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
	CIf(FP,CD(AutoOp,0))
		DisplayPrint(GCP,{"\x12\x07『 \x04강화에 \x07성공\x04하였습니다!. \x17",EnchNum,"강 \x04→ \x07",EnchNum2,"강 \x07』"})
	CIfEnd()
CElseIfX({TNVar(GetEPer, AtLeast, E2Range[1]),TNVar(GetEPer, AtMost, E2Range[2])},SetV(Result,2))--유지
	CIf(FP,CD(AutoOp,0))
		DisplayPrint(GCP,{"\x12\x07『 \x04강화에 \x08실패\x04하였습니다!. \x07강화 \x04단계가 \x10유지됩니다. \x07』"})
	CIfEnd()

CElseIfX({TNVar(GetEPer, AtLeast, E3Range[1]),TNVar(GetEPer, AtMost, E3Range[2])},SetV(Result,3))--하락
	CIf(FP,CD(AutoOp,0))
		DisplayPrint(GCP,{"\x12\x07『 \x04강화에 \x08실패\x04하였습니다!. \x17",EnchNum,"강 \x04→ \x08",EnchNum3,"강 \x07』"})
	CIfEnd()
CElseX(SetV(Result,4))--실패
	CIf(FP,CD(AutoOp,0))
		DisplayPrint(GCP,{"\x12\x07『 \x04강화에 \x08실패\x04하여 \x08단계가 초기화 되었습니다.. \x07』"})
	CIfEnd()
CIfXEnd()
CElseX()
	CIf(FP,CD(AutoOp,0))
		DisplayPrint(GCP,{"\x12\x07『 \x04잔액이 부족합니다. \x03",EnchMoney," \x04/ \x1F",EnchCost," \x07』"})
	CIfEnd()
CIfXEnd()
VtoPV(EnchMoney,iv.Money)

SetCallEnd()

Call_SCA_DataSaveAll = SetCallForward()
PlayerV = CreateVar(FP)
SetCall(FP)
CAdd(FP,PlayerV,_Mul(GCP,500),SCA_DataPtrV)
for j,k in pairs(SCA_DataArr) do
	SCA_DataSaveG(PlayerV,k[1],k[2])
end

SetCallEnd()
Call_SCA_DataLoadAll = SetCallForward()
SetCall(FP)
CAdd(FP,PlayerV,_Mul(GCP,500),SCA_DataPtrV)
for j,k in pairs(SCA_DataArr) do
	SCA_DataLoadG(PlayerV,k[1],k[2],k[3])
end

SetCallEnd()
Call_SCA_DataLoadSetTo = SetCallForward()
SetCall(FP)
CAdd(FP,PlayerV,_Mul(GCP,500),SCA_DataPtrV)
for j,k in pairs(SCA_DataArr) do
	SCA_DataLoadG(PlayerV,k[1],k[2],k[3],AtLeast,1,SetTo)
end
SetCallEnd()
Call_SCA_DataLoadAdd = SetCallForward()
SetCall(FP)
CAdd(FP,PlayerV,_Mul(GCP,500),SCA_DataPtrV)

for j,k in pairs(SCA_DataArr) do
	SCA_DataLoadG(PlayerV,k[1],k[2],k[3],AtLeast,1,Add)
end
SetCallEnd()



Call_CT = SetCallForward()
SetCall(FP)

CTPEXP = CreateWar(FP)
CTPLevel = CreateVar(FP)
CTStatP = CreateVar(FP)
CTStatP2 = CreateVar(FP)
CTCurEXP = CreateWar(FP)
CTTotalExp = CreateWar(FP)
CTLIndex = CreateVar(FP)
CT_PrevLMulW = CreateWar(FP)
CT_NextLMulW = CreateWar(FP)
CTMaxExp = CreateWar(FP)


ConvertLArr(FP, CTLIndex, _Add(CTPLevel, 150), 8)--151 포커스
f_LRead(FP, LArrX({EXPArr_dp},CTLIndex), CTCurEXP, nil, 1)
ConvertLArr(FP, CTLIndex, _Add(CTPLevel, 151), 8)--151 포커스
f_LRead(FP, LArrX({EXPArr_dp},CTLIndex), CTTotalExp, nil, 1)
f_LRead(FP, LArrX({EXPArr_dp},151+LevelLimit), CTMaxExp, nil, 1)
DoActionsX(FP,{SetCDX(iv.StatTest,16,16)})
CTrigger(FP,{TTNWar(CTPEXP, AtLeast, CTCurEXP),TTNWar(CTPEXP, AtMost, CTTotalExp)},{SetCDX(iv.StatTest,0,16)},1)
--CTrigger(FP,{TTNWar(CTPEXP, AtLeast, CTMaxExp)},{SetCDX(iv.StatTest,32,32)},1)
if Limit == 1 then
--	DisplayPrint(iv.LCP, {"\x13\x04CTPEXP : ",CTPEXP,"   CTCurEXP : ",CTCurEXP,"   CTTotalExp : ",CTTotalExp})
end
--CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_TotalEPer[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_TotalEPer)))
--CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_TotalEPerEx[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_TotalEPerEx)))
--CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_TotalEPerEx2[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_TotalEPerEx2)))
--CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_TotalEPerEx3[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_TotalEPerEx3)))
--CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_TotalEPer2[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_TotalEPer2)))
--CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_TotalEPer3[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_TotalEPer3)))
--CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_TotalEPer4[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_TotalEPer4)))
--CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_TotalEPer4X[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_TotalEPer4X)))
--CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_BreakShield[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_BreakShield)))
--CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_BreakShield2[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_BreakShield2)))
--CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_XEPer44[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_XEPer44)))
--CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_XEPer45[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_XEPer45)))
--CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_XEPer46[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_XEPer46)))
--CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_XEPer47[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_XEPer47)))
--CAdd(FP,iv.CTStatP2,_Mul(VArrX(GetVArray(iv.Stat_BossSTic[1], 7), VArrI, VArrI4),_Mov(Cost_Stat_BossSTic)))
--CAdd(FP,iv.CTStatP2,_Mul(VArrX(GetVArray(iv.Stat_LV3Incm[1], 7), VArrI, VArrI4),_Mov(Cost_Stat_LV3Incm)))
--CAdd(FP,iv.CTStatP2,_Mul(VArrX(GetVArray(iv.Stat_Upgrade[1], 7), VArrI, VArrI4),_Mov(Cost_Stat_Upgrade)))
--CAdd(FP,iv.CTStatP2,_Mul(VArrX(GetVArray(iv.Stat_BossLVUP[1], 7), VArrI, VArrI4),_Mov(Cost_Stat_BossLVUP)))


SetCallEnd()


SCA_cp = CreateVar(FP)
function SCA_DataReset(cp,cond,Act) -- 슬롯 불러오기 or 저장전 데이터 초기화를 위한 함수
	CallTriggerX(FP, Call_DataReset, cond, {SetV(SCA_cp,cp),Act})
	
end
Call_DataReset = SetCallForward()
SetCall(FP)
local Pl = CreateVar(FP)
CAdd(FP,Pl,_Mul(SCA_cp,500),SCA_DataPtrV)
for j,k in pairs(SCA_DataArr) do
	local Destptr = k[2]
	local Player = SCA_cp
	local Source = k[1][1]--1P기준
if Source[4]=="V" then
	CDoActions(FP, {TSetMemory(_Add(Pl,Destptr), SetTo, 0)})
elseif Source[4]=="W" then
	if #Destptr~=2 then PushErrorMsg("SCA_Destptr_Inputdata_Error") end
	CDoActions(FP, {
		TSetMemory(_Add(Pl,Destptr[1]), SetTo, 0),
		TSetMemory(_Add(Pl,Destptr[2]), SetTo, 0)
	})
else
	PushErrorMsg("SCA_Source_Inputdata_Error")
end

end
SetCallEnd()


	
Call_SetEPerStr = SetCallForward()
SetCall(FP)
EVarArr1 = CreateVarArr(6, FP)
GEVar = CreateVar(FP)
EVarArr2 = {EVarArr1[1],EVarArr1[2],EVarArr1[3]}
EVarArr3 = {EVarArr1[4],EVarArr1[5],EVarArr1[6]}

for i = 1, 6 do
	Byte_NumSet(GEVar,EVarArr1[i],10^(6-i),1,0x30)
end
SetEPerStr(EVarArr1)

SetCallEnd()

Call_SetEPerStr2 = SetCallForward()
SetCall(FP)
EVarArr1_2 = CreateVarArr(6, FP)
GEVar_2 = CreateVar(FP)
EVarArr2_2 = {EVarArr1_2[1],EVarArr1_2[2],EVarArr1_2[3]}
EVarArr3_2 = {EVarArr1_2[4],EVarArr1_2[5],EVarArr1_2[6]}

for i = 1, 6 do
	Byte_NumSet(GEVar_2,EVarArr1_2[i],10^(6-i),1,0x30)
end
SetEPerStr(EVarArr1_2)

SetCallEnd()

G_Btnptr = CreateVar(FP)
G_BtnFnm = CreateVar(FP)
G_PushBtnm = CreateVar(FP)


Call_BtnFnc = SetCallForward()


SetCall(FP)
PUnitCurLevel = CreateVarArr2(8,0xFFFFFFFF,FP)
CIf(FP,{CVar(FP,G_Btnptr[2],AtLeast,19025),CVar(FP,G_Btnptr[2],AtMost,19025+(1699*84))})
	CIf(FP,{TMemory(_Add(G_Btnptr,0x98/4),AtMost,0 + 227*65536)}) -- 버튼 눌럿을경우
	
		--Print_13X(FP,GCP)

		f_Read(FP,_Add(G_Btnptr,0x98/4),G_PushBtnm)
		CrShift(FP,G_PushBtnm,16)

		CIfX(FP,{Never()})
		--CElseIfX({CV(G_BtnFnm,1)})
			--local AutoBuyVArr = GetVArray(iv.AutoBuyCode[1], 8)
			--local AutoBuyVArr2 = GetVArray(iv.AutoBuyCode2[1], 8)
			--local GetABData = CreateVar(FP)

		CElseIfX({CV(G_BtnFnm,1)})--자동강화
			local GetArrNum = CreateVar(FP)
			local TxtColor = CreateVar(FP)
			f_Mul(FP, GetArrNum, G_PushBtnm, 8)
			CAdd(FP,GetArrNum,GCP)

			DoActionsX(FP,{SetV(TxtColor,0x06),AddV(G_PushBtnm,1)})
			TriggerX(FP, {CV(G_PushBtnm,26,AtLeast)}, SetV(TxtColor,0x0F), {preserved})

			CIf(FP,{CV(G_BtnFnm,1)})
				CIfX(FP,{TMemory(_TMem(ArrX(AutoEnchArr2,GetArrNum)),Exactly,0)})
				DisplayPrint(GCP, {StrDesign("\x08ERROR \x04: 최소 1회 이상 해당 유닛의 강화를 성공해야합니다."),})
				CTrigger(FP, {}, {TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP)}, {preserved})		
				CElseX()
				CIfX(FP,{TMemory(_TMem(ArrX(AutoEnchArr,GetArrNum)),Exactly,0)})
				DisplayPrint(GCP, {"\x07『 ",TxtColor[2],G_PushBtnm,"강 \x04유닛 \x1B자동강화 \x07ON \04(강화 우선 적용됨) \x07』",})
					CMovX(FP,ArrX(AutoEnchArr,GetArrNum),1)
				CElseX()
				DisplayPrint(GCP, {"\x07『 ",TxtColor[2],G_PushBtnm,"강 \x04유닛 \x1B자동강화 \x08OFF \04(강화 우선 적용됨) \x07』",})
					CMovX(FP,ArrX(AutoEnchArr,GetArrNum),0)
				CIfXEnd()
				CIfXEnd()

			CIfEnd()
			--CIf(FP,{CV(G_BtnFnm,4,AtLeast),CV(G_BtnFnm,5,AtMost)})
			--	CIfX(FP,{TMemory(_TMem(ArrX(AutoEnchArr2,GetArrNum)),Exactly,0)})
			--	DisplayPrintEr(GCP, {StrDesign("\x08ERROR \x04: 최소 1회 이상 해당 유닛의 강화를 성공해야합니다."),})
			--	CTrigger(FP, {}, {TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP)}, {preserved})		
			--	CElseX()
			--	CIfX(FP,{TMemory(_TMem(ArrX(AutoSellArr,GetArrNum)),Exactly,0)})
			--	
			--	DisplayPrintEr(GCP, {"\x07『 ",TxtColor[2],G_PushBtnm,"강 \x04유닛 \x07자동판매 \x07ON \04(강화 우선 적용됨) \x07』",})
			--		
			--		CMovX(FP,ArrX(AutoSellArr,GetArrNum),1)

			--	CElseX()
			--	
			--	DisplayPrintEr(GCP, {"\x07『 ",TxtColor[2],G_PushBtnm,"강 \x04유닛 \x07자동판매 \x08OFF \04(강화 우선 적용됨) \x07』",})

			--		CMovX(FP,ArrX(AutoSellArr,GetArrNum),0)
			--	CIfXEnd()
		CIfXEnd()

			--CIfEnd()

	CIfEnd()--ShopEnd
	CDoActions(FP,{
		TSetMemory(_Add(G_Btnptr,0x98/4),SetTo,0 + 228*65536);
		TSetMemory(_Add(G_Btnptr,0x9C/4),SetTo,228 + 228*65536);
		TSetMemoryX(_Add(G_Btnptr,0xA0/4),SetTo,228,0xFFFF)})
CIfEnd()


	
SetCallEnd()

end