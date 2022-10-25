function Interface()
	local Money = CreateWarArr(7,FP)
	local Credit = CreateWarArr(7,FP)
	local TotalExp = CreateWarArr2(7,"10",FP)
	local CurEXP = CreateWarArr(7,FP)
	local MoneyLoc = CreateWar(FP)
	local CredLoc = CreateWar(FP)
	local ExpLoc = CreateVar(FP)
	local TotalExpLoc = CreateVar(FP)
	local IncomeMax = CreateVarArr2(7,12,FP)
	local PLevel = CreateVarArr2(7,1,FP)
	local Income = CreateVarArr(7,FP)
	local IncomeMaxLoc = CreateVar(FP)
	local IncomeLoc = CreateVar(FP)
	local LevelLoc = CreateVar(FP)
	local TotalEPer = CreateVarArr(7,FP)--총 강화확률(기본 1강)
	local TotalEPer2 = CreateVarArr(7,FP)--총 강화확률(+2강)
	local TotalEPer3 = CreateVarArr(7,FP)--총 강화확률(+3강)
	
	local TotalEPerLoc = CreateVar(FP)
	local TotalEPer2Loc = CreateVar(FP)
	local TotalEPer3Loc = CreateVar(FP)

	local AutoBuyCode = CreateCcodeArr(7)
	local StatP = CreateVarArr(7,FP)
	local StatPLoc = CreateVar(FP)
	local StatEff = CreateCcodeArr(7)
	local StatEffT2 = CreateCcodeArr(7)
	local StatEffLoc = CreateCcode()

	local TempReadV = CreateVar(FP)


	local InterfaceNum = CreateVarArr(7,FP)
	local InterfaceNumLoc = CreateVar(FP)


	function AutoBuy(CP,LvUniit,Cost)--Cost==String
		CIf(FP,{Memory(0x628438,AtLeast,1),CD(AutoBuyCode[CP+1],LvUniit)})
			CIf(FP, {TTNWar(Money[CP+1],AtLeast,Cost)})
				f_LSub(FP, Money[CP+1], Money[CP+1], Cost)
				CreateUnitStacked({}, 1, LevelUnitArr[LvUniit][2], 43+CP,nil, CP)
			CIfEnd()
		CIfEnd()
		
	end
for i = 0, 6 do -- 각플레이어
	CIf(FP,{HumanCheck(i,1)})
	UnitReadX(FP, i, "Men", 65+i, Income[i+1])
	if TestStart == 1 then
		--f_LAdd(FP, PEXP[i+1], PEXP[i+1], "1")
		--f_LMul(FP, PEXP[i+1], PEXP[i+1], "2")
		--f_LAdd(FP, TotalExp[i+1], TotalExp[i+1], "1")
		--f_LMul(FP, TotalExp[i+1], TotalExp[i+1], "2")
	end

	
	NIf(FP,{TTNWar(PEXP[i+1],AtLeast,TotalExp[i+1]),CV(PLevel[i+1],9999,AtMost)},{AddV(PLevel[i+1],1),SetCD(StatEffT2[i+1],0),SetCD(StatEff[i+1],1)})

	f_Read(FP,FArr(EXPArr,_Sub(PLevel[i+1],1)),TempReadV,nil,nil,1)
	f_LAdd(FP, TotalExp[i+1], TotalExp[i+1], {TempReadV,0})
	f_Read(FP,FArr(EXPArr,_Sub(PLevel[i+1],2)),TempReadV,nil,nil,1)
	f_LAdd(FP, CurEXP[i+1], CurEXP[i+1], {TempReadV,0})
	CAdd(FP,StatP[i+1],5)
	CallTrigger(FP,Call_Print13[i+1])
	TriggerX(FP, {LocalPlayerID(i)}, {print_utf8(12,0,StrDesign("\x1F레벨이 올랐습니다! \x17O 키\x04를 눌러 \x07능력치\x04를 설정해주세요."))}, {preserved})
		
	NIfEnd()
	DoActionsX(FP, {AddCD(StatEffT2[i+1],1)})
	TriggerX(FP,{CD(StatEffT2[i+1],500,AtLeast)},{SetCD(StatEff[i+1],0)},{preserved})


	CreateUnitStacked(nil,1, 88, 36+i,15+i, i, nil, 1)--기본유닛지급

	DPSBuilding(i,DpsLV1[i+1],nil,{Ore},Money[i+1])
	DPSBuilding(i,DpsLV2[i+1],1000,{Gas},Money[i+1])




	CTrigger(FP,{TBring(i, AtMost, _Sub(IncomeMax[i+1],1), "Men", 65)},{MoveUnit(1, "Men", i, 15+i, 22+i),},1)
	DoActions(FP,{
		MoveUnit(1, "Men", i, 29+i, 36+i),
		MoveUnit(1, "Factories", i, 22+i, 57+i),
	})



	--강화성공한 유닛 생성하기(캔낫씹힘방지)
	for j, k in pairs(LevelUnitArr) do
		CreateUnitStacked({Memory(0x628438,AtLeast,1),CVAar(VArr(GetUnitVArr[i+1], k[1]-1), AtLeast, 1)}, 1, k[2], 50+i,36+i, i, {SetCVAar(VArr(GetUnitVArr[i+1], k[1]-1), Subtract, 1)})
	end


	BtnSetInit(i,TestShop) -- 유닛 자동구매기
		for j, k in pairs(AutoBuyArr) do
			CIfBtnFunc(i,j-1,StrDesign("\x06"..k[1].."강 \x04유닛 \x1B자동구입 \x08OFF"),StrDesign("\x06"..k[1].."강 \x04유닛 \x1B자동구입 \x07ON"),CD(AutoBuyCode[i+1],k[1]),SetCD(AutoBuyCode[i+1],0),SetCD(AutoBuyCode[i+1],k[1]))
			CIfEnd()
		end
	
		CIfBtnFunc(i,24,StrDesign("\x04유닛 \x1B자동구입 \x08OFF"),StrDesign("\x04유닛 \x1B자동구입 \x07OFF"),nil,SetCD(AutoBuyCode[i+1],0),SetCD(AutoBuyCode[i+1],0))
		CIfEnd()
	BtnSetEnd()

	BtnSetInit(i,SettingUnit1) -- 1~25강유닛 자동강화 설정

	for j = 1, 25 do
		CIfBtnFunc(i,j-1,StrDesign("\x06"..j.."강 \x04유닛 \x1B자동강화 \x07ON"),StrDesign("\x06"..j.."강 \x04유닛 \x1B자동강화 \x08OFF"),CD(AutoEnchArr[j][i+1],0),SetCD(AutoEnchArr[j][i+1],1),SetCD(AutoEnchArr[j][i+1],0))
	
		CIfEnd()
	end
	BtnSetEnd()

	BtnSetInit(i,SettingUnit2) -- 26~39유닛 자동강화 설정

	for j = 26, 39 do
		CIfBtnFunc(i,j-26,StrDesign("\x06"..j.."강 \x04유닛 \x1B자동강화 \x07ON"),StrDesign("\x06"..j.."강 \x04유닛 \x1B자동강화 \x08OFF"),CD(AutoEnchArr[j][i+1],0),SetCD(AutoEnchArr[j][i+1],1),SetCD(AutoEnchArr[j][i+1],0))
	
		CIfEnd()
	end
	BtnSetEnd()

	for j, k in pairs(LevelUnitArr) do
		TriggerX(FP, {Command(i,AtLeast,1,k[2])}, {SetCD(AutoEnchArr2[j][i+1],1)})
		CIf(FP,CD(AutoEnchArr[j][i+1],1))
			
		CallTriggerX(FP,Call_Print13[i+1],{CD(AutoEnchArr[j][i+1],1),CD(AutoEnchArr2[j][i+1],0)})
		TriggerX(FP, {CD(AutoEnchArr[j][i+1],1),CD(AutoEnchArr2[j][i+1],0),LocalPlayerID(i)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: 최소 1회 이상 해당 유닛의 강화를 성공해야합니다."))}, {preserved})
		TriggerX(FP, {CD(AutoEnchArr[j][i+1],1),CD(AutoEnchArr2[j][i+1],0)}, {SetCD(AutoEnchArr[j][i+1],0)}, {preserved})
		TriggerX(FP, {CD(AutoEnchArr[j][i+1],1)}, {Order(k[2], i, 36+i, Move, 8+i)}, {preserved})
		CIfEnd()
	end
	CIfX(FP, {Command(i,AtMost,199,"Men"),CD(AutoBuyCode[i+1],1,AtLeast)}) -- 자동구매 관리
	for j, k in pairs(AutoBuyArr) do
		AutoBuy(i,k[1],k[2])
	end
	CElseIfX({Command(i,AtLeast,200,"Men")})
	CallTrigger(FP,Call_Print13[i+1])
	TriggerX(FP, {LocalPlayerID(i)}, {print_utf8(12,0,StrDesign("\x08ERROR \x04: 보유 유닛수가 너무 많아 유닛 구입할 수 없습니다.\x08 (최대 200기)"))},{preserved})
	
	CIfXEnd()
	


	BringJumpCcode = CreateCcode()
	CIf(FP,{Bring(i,AtLeast,1,"Men",8+i)},{SetCD(BringJumpCcode,0)}) --  유닛 강화시도하기
	CMov(FP,GEper,TotalEPer[i+1])
	CMov(FP,GEper2,TotalEPer2[i+1])
	CMov(FP,GEper3,TotalEPer3[i+1])
	for j = #LevelUnitArr, 1, -1 do
		local LV = LevelUnitArr[j][1]
		local UID = LevelUnitArr[j][2]
		local Per = LevelUnitArr[j][3]
		local EXP = LevelUnitArr[j][4]
		if j == #LevelUnitArr then
			CIf(FP,{Bring(i,AtLeast,1,UID,8+i)},{KillUnitAt(1, UID, 8+i, i),})
			f_LAdd(FP, PEXP[i+1], PEXP[i+1], tostring(EXP))
			CIfEnd()
		else
			CallTriggerX(FP, Call_Enchant, {Bring(i,AtLeast,1,UID,8+i)}, {KillUnitAt(1, UID, 8+i, i),SetV(EExp,EXP),SetV(ELevel,LV-1),SetV(UEper,Per),SetV(ECP,i),SetCD(BringJumpCcode,1)})
		end
	end

	
	CIfEnd()
	DoActionsX(FP, {SetCp(i),SetCDeaths(FP,SetTo,0,ShopKey[i+1])})--키인식부 시작
	TriggerX(FP, {CV(InterfaceNum[i+1],0),MSQC_KeyInput(i,"O")}, {SetV(InterfaceNum[i+1],1)},{preserved})
	CIfX(FP,{CV(InterfaceNum[i+1],1,AtLeast)},{SetCp(i),CenterView(72),SetCp(FP)})
	KeyFunc(i,"1",{
		{{CV(StatP[i+1],5,AtLeast),CV(IncomeMax[i+1],47,AtMost)},{SubV(StatP[i+1],5),AddV(IncomeMax[i+1],1)},StrDesign("\x1B사냥터 최대 유닛수가 증가하였습니다.")},
		{{CV(IncomeMax[i+1],48,AtLeast)},{},StrDesign("\x08ERROR \x04: 더 이상 최대 유닛수를 늘릴 수 없습니다.")},
		{{CV(StatP[i+1],4,AtMost)},{},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
	})
	KeyFunc(i,"2",{
		{{CV(StatP[i+1],5,AtLeast),CV(TotalEPer[i+1],9999,AtMost)},{SubV(StatP[i+1],5),AddV(TotalEPer[i+1],100)},StrDesign("\x07총 \x08강화 확률\x04이 증가하였습니다.")},
		{{CV(TotalEPer[i+1],10000,AtLeast)},{},StrDesign("\x08ERROR \x04: 더 이상 \x07총 \x08강화 확률\x04을 올릴 수 없습니다.")},
		{{CV(StatP[i+1],4,AtMost)},{},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
	})
	TriggerX(FP, {MSQC_KeyInput(i,"ESC")}, {SetV(InterfaceNum[i+1],0),SetCp(i),DisplayText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", 4),CenterView(36+i)},{preserved})
	CIfXEnd()
	DoActions(FP, SetCp(FP))--키인식부 종료

	CIf(FP,LocalPlayerID(i),{SetCD(StatEffLoc,0)}) -- CAPrint에 전송할 값들
	CMov(FP,TotalEPerLoc,TotalEPer[i+1])
	CMov(FP,TotalEPer2Loc,TotalEPer2[i+1])
	CMov(FP,TotalEPer3Loc,TotalEPer3[i+1])
	f_LMov(FP,MoneyLoc,Money[i+1])
	f_LMov(FP,CredLoc,Credit[i+1])
	CMov(FP,IncomeLoc,Income[i+1])
	CMov(FP,IncomeMaxLoc,IncomeMax[i+1])
	f_Cast(FP,{ExpLoc,0},_LSub(PEXP[i+1], CurEXP[i+1]))
	f_Cast(FP,{TotalExpLoc,0},_LSub(TotalExp[i+1], CurEXP[i+1]))
	CMov(FP,LevelLoc,PLevel[i+1])
	CMov(FP,StatPLoc,StatP[i+1])
	CMov(FP,InterfaceNumLoc,InterfaceNum[i+1])
	TriggerX(FP,{CD(StatEff[i+1],1)},{SetCD(StatEffLoc,1)},{preserved})
	CIfEnd()
	
	CIfEnd()
end


local iStrinit = def_sIndex()
CJump(FP, iStrinit)
t01 = "\x07확률 \x04: \x0D000.000\x08%\x0D\x0D"
t02 = "\x08!!! \x1F최 강 유 닛 \x08!!!"
iStrSize1 = GetiStrSize(0,t01)
S1 = MakeiTblString(1495,"None",'None',MakeiStrLetter("\x0D",iStrSize1+5),"Base",1) -- 단축키없음
iTbl1 = GetiTblId(FP,1495,S1) --NMDMG
TStr1, TStr1a, TStr1s = SaveiStrArr(FP,t01)
TStr2, TStr2a, TStr2s = SaveiStrArr(FP,t02)
SelEPD,SelPer,SelUID,SelMaxHP,SelI = CreateVars(5,FP)
CJumpEnd(FP, iStrinit)


CIf(FP,{Memory(0x6284B8 ,AtLeast,1),Memory(0x6284B8 + 4,AtMost,0)}) -- 클릭유닛인식(로컬)
f_Read(FP,0x6284B8,nil,SelEPD)
CMov(FP,SelUID,_Read(_Add(SelEPD,25)),nil,0xFF,1)

CaseJump = def_sIndex()
for j, k in pairs(LevelUnitArr) do
	NIf(FP,{CV(SelUID,k[2])})
	CMov(FP,SelPer,k[3])
	CJumpX(FP,CaseJump)
	NIfEnd()
end
CJumpXEnd(FP, CaseJump)

CIfX(FP,{CV(SelUID,LevelUnitArr[#LevelUnitArr][2])})--최강유닛일경우
CS__InputVA(FP,iTbl1,0,TStr2,TStr2s,nil,0,TStr2s)
CElseX()--그외
CS__ItoCustom(FP,SVA1(TStr1,5),SelPer,nil,nil,{10,6},1,nil,"\x080",0x08,{0,1,2,4,5,6})
CIfX(FP,{
	CSVA1(SVA1(TStr1,5+4), Exactly, string.byte("0")*0x1000000, 0xFF000000),
	CSVA1(SVA1(TStr1,5+5), Exactly, string.byte("0")*0x1000000, 0xFF000000),
	CSVA1(SVA1(TStr1,5+6), Exactly, string.byte("0")*0x1000000, 0xFF000000),
},{
	SetCSVA1(SVA1(TStr1,5+3),SetTo,0x0D*0x1000000,0xFF000000),
	SetCSVA1(SVA1(TStr1,5+4),SetTo,0x0D*0x1000000,0xFF000000),
	SetCSVA1(SVA1(TStr1,5+5),SetTo,0x0D*0x1000000,0xFF000000),
	SetCSVA1(SVA1(TStr1,5+6),SetTo,0x0D*0x1000000,0xFF000000),
})
CElseIfX({
	CSVA1(SVA1(TStr1,5+5), Exactly, string.byte("0")*0x1000000, 0xFF000000),
	CSVA1(SVA1(TStr1,5+6), Exactly, string.byte("0")*0x1000000, 0xFF000000),
},{
	SetCSVA1(SVA1(TStr1,5+5),SetTo,0x0D*0x1000000,0xFF000000),
	SetCSVA1(SVA1(TStr1,5+6),SetTo,0x0D*0x1000000,0xFF000000),
})
CElseIfX({
	CSVA1(SVA1(TStr1,5+6), Exactly, string.byte("0")*0x1000000, 0xFF000000),
},{
	SetCSVA1(SVA1(TStr1,5+6),SetTo,0x0D*0x1000000,0xFF000000),
})
CIfXEnd()



CS__InputVA(FP,iTbl1,0,TStr1,TStr1s,nil,0,TStr1s)
CIfXEnd()

CIfEnd()

function TEST() 
	local PlayerID = CAPrintPlayerID 
	local LVData = {{{0,9},{"０",{0x1000000}}}} 
	local StatEffT = CreateCcode()
	local InterfaceNumLoc2 = CreateCcode()
	DoActionsX(FP,AddCD(StatEffT,1))
	CA__SetValue(Str1,"\x07보유금액 \x04:  12\x04,123\x04,123\x04,123\x04,123\x04,123\x04,123 \x04원\x12\x07사냥터\x04 \x0D\x0D\x0D / \x0D\x0D\x0D\x0D\x0D",nil,1)
	--43
	--49
	CS__ItoCustom(FP,SVA1(Str1,42),IncomeLoc,nil,nil,{10,2},1,nil,"\x1B0",0x1B,{0,1})
	CS__ItoCustom(FP,SVA1(Str1,48),IncomeMaxLoc,nil,nil,{10,2},1,nil,"\x190",0x19,{0,1})
	CA__lItoCustom(SVA1(Str1,8),MoneyLoc,nil,nil,10,1,nil,{"\x1F\x0D","\x08\x0D","\x040"},{0x04,0x04,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x02,0x02,0x2,0x1E,0x1E,0x1E,0x04,0x04,0x04}
	,{0,1,3,4,5,7,8,9,11,12,13,15,16,17,19,20,21,23,24,25},nil,{0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0}})
	CA__InputVA(56*0,Str1,Str1s,nil,56*0,56*1-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x07ＬＶ．\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x04－\x0FＥＸＰ\x04：",nil,1)
	
	CS__ItoCustom(FP,SVA1(Str1,4),LevelLoc,nil,nil,{10,5},1,nil,"\x1B0",0x1B,nil, LVData)
	CIfX(FP,{KeyPress("TAB", "Down")})--수치표기
	CA__ItoCustom(SVA1(Str1,16),ExpLoc,nil,nil,10,nil,nil,"\x040",{0x1F,0x1E,0x1E,0x1E,0x07,0x07,0x07,0x10,0x10,0x10})
	CA__Input(MakeiStrData("\x08／",1),SVA1(Str1,28))
	CA__ItoCustom(SVA1(Str1,30),TotalExpLoc,nil,nil,10,nil,nil,"\x040",{0x1F,0x1E,0x1E,0x1E,0x07,0x07,0x07,0x10,0x10,0x10})
	CElseX()--퍼센트표기
	local CurExpTmp = CreateVar(FP)
	CIfX(FP,{CV(LevelLoc,9999,AtMost)})
	f_Mul(FP,CurExpTmp,ExpLoc,20)
	f_Div(FP,CurExpTmp,TotalExpLoc)
	CElseX({SetV(CurExpTmp,20)})
	CIfXEnd()
	CA__SetValue(Str1,"\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x17 (TAB - 세부값)",nil,16)
	function CS__InputTA(Player,Condition,SVA1,Value,Mask,Flag)
		if Flag == nil then Flag = {preserved} elseif Flag == 1 then Flag = {} end
		TriggerX(Player,Condition,{SetCSVA1(SVA1,SetTo,Value,Mask)},Flag)
	end
	for i = 0, 19 do
		CS__InputTA(FP,{CV(CurExpTmp,i+1,AtLeast)},SVA1(Str1,16+i),0x07,0xFF)
	end
	CIfXEnd()
	TriggerX(FP,{CD(StatEffLoc,1),CD(StatEffT,1,AtLeast)},{SetCD(StatEffT,0),SetCSVA1(SVA1(Str1,0),SetTo,0x04,0xFF),SetCSVA1(SVA1(Str1,1),SetTo,0x04,0xFF),SetCSVA1(SVA1(Str1,2),SetTo,0x04,0xFF)},{preserved})
	CA__InputVA(56*1,Str1,Str1s,nil,56*1,56*2-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x12크레딧 \x04:  12\x04,123\x04,123\x04,123\x04,123\x04,123\x04,123",nil,1)
	CA__lItoCustom(SVA1(Str1,8),CredLoc,nil,nil,10,1,nil,{"\x1F\x0D","\x08\x0D","\x040"},{0x04,0x04,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x02,0x02,0x2,0x1E,0x1E,0x1E,0x05,0x05,0x05}
	,{0,1,3,4,5,7,8,9,11,12,13,15,16,17,19,20,21,23,24,25},nil,{0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0}})
	CA__InputVA(56*2,Str1,Str1s,nil,56*2,56*3-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 

	CIfX(FP,{CV(InterfaceNumLoc,1)},{SetCD(InterfaceNumLoc2,0)}) -- 상점 페이지 제어
	
	CA__SetValue(Str1,"\x07능력치 \x04설정. \x10숫자키\x04를 눌러 \x07업그레이드. \x08나가기:ESC\x12\x1C보유 포인트 :\x07 ",nil,1)
	CA__ItoCustom(SVA1(Str1,41),StatPLoc,nil,nil,{10,5},nil,nil,"\x040")
	CA__InputVA(56*3,Str1,Str1s,nil,56*3,56*4-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x071. \x07사냥터 \x1F최대 유닛수 \x04증가\x17(최대 48) - \x1F5 Point\x12\x04 \x0D\x0D\x0D\x0D\x0D / \x1948",nil,1)
	CS__ItoCustom(FP,SVA1(Str1,36),IncomeMaxLoc,nil,nil,{10,2},1,nil,"\x1B0",0x1B,{0,1})
	CA__InputVA(56*4,Str1,Str1s,nil,56*4,56*5-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x072. \x07총 \x08강화확률 \x04증가 \x0F+0.1%p \x04- \x1F1 Point\x12\x04 \x0D00.000 %p",nil,1)
	CS__ItoCustom(FP,SVA1(Str1,32),TotalEPerLoc,nil,nil,{10,5},1,nil,"\x0F0",0x0F,{0,1,3,4,5},nil,{})
	CS__InputTA(FP,CV(TotalEPerLoc,999,AtMost),SVA1(Str1,33),string.byte("0")*0x1000000, 0xFF000000)
	CS__InputTA(FP,CV(TotalEPerLoc,99,AtMost),SVA1(Str1,35),string.byte("0")*0x1000000, 0xFF000000)
	CS__InputTA(FP,CV(TotalEPerLoc,9,AtMost),SVA1(Str1,36),string.byte("0")*0x1000000, 0xFF000000)
	CS__InputTA(FP,CV(TotalEPerLoc,0,AtMost),SVA1(Str1,37),string.byte("0")*0x1000000, 0xFF000000)
	CA__InputVA(56*5,Str1,Str1s,nil,56*5,56*6-2)

	
	for i = 3, 11 do
		CA__SetMemoryX((56*i)-1,0x0A0D0D0D,0xFFFFFFFF,1)
	end

	CElseX()--표기할 상점 페이지가 없을시
	CIf(FP,{CD(InterfaceNumLoc2,0)},{SetCD(InterfaceNumLoc2,1)})
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__InputVA(56*3,Str1,Str1s,nil,56*3,56*4-2)
	CA__InputVA(56*4,Str1,Str1s,nil,56*4,56*5-2)	
	for i = 3, 11 do
		CA__SetMemoryX((56*i)-1,0x0D0D0D0D,0xFFFFFFFF,1)
	end
	CIfEnd()



	CIfXEnd()




	
	end 
	CAPrint(iStr1,{Force1},{1,0,0,0,1,3,0,0},"TEST",FP,{}) 

	TriggerX(FP, {CD(TBLFlag,0)}, {CreateUnit(1,94,64,FP),RemoveUnit(94,FP)}, {preserved})--tbl상시갱신용. CreateUnitStacked 사용시 발동안함
	DoActionsX(FP, {SetCD(TBLFlag,0)})
	TriggerX(FP, ElapsedTime(AtLeast,180*1.5), {RemoveUnit(88,AllPlayers)}) -- 3분뒤 사라지는 기본유닛

	if TestStart == 1 then -- 관리자 콘솔 일단비공유데이터(방갈됨)
		L = CreateVar()
		CIfOnce(FP)
		GetPlayerLength(FP,P1,L)
		CIfEnd()
		N = CreateVar()
		local CU = CreateCcodeArr(40)
		local CUCool = CreateCcodeArr(40)
		SLoopN(FP,11,Always(),{SetNVar(N,Add,218)},{SetNVar(N,SetTo,0x640B63-218),TSetNVar(N,Add,L)})
		for i = 1, 40 do
			f_bytecmp(FP,{CU[i]},N,_byteConvert(GetStrArr(0,"@"..i.."강")),GetStrSize(0,"@"..i.."강"))
		end

		SLoopNEnd()
		CUCoolT = {}
		for i = 1, 40 do
			CreateUnitStacked({CDeaths(FP,AtLeast,1,CU[i]),CDeaths(FP,AtMost,0,CUCool[i])}, 1, LevelUnitArr[i][2], 36, nil, P1, {SetCDeaths(FP,SetTo,0,CU[i]),SetCDeaths(FP,SetTo,24*30,CUCool[i])})
			CUCoolT[i] = SubCD(CUCool[i],1)
		end
		DoActions2X(FP,CUCoolT)

	end
	
end