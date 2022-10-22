function Interface()
	local Money = CreateWarArr(7,FP)
	local TotalExp = CreateWarArr(7,FP)
	local MoneyLoc = CreateWar(FP)
	local ExpLoc = CreateWar(FP)
	local TotalExpLoc = CreateWar(FP)
	local IncomeMax = CreateVarArr2(7,12,FP)
	local Income = CreateVarArr(7,FP)
	local IncomeMaxLoc = CreateVar(FP)
	local IncomeLoc = CreateVar(FP)
	local TotalEPer = CreateVarArr(7,FP)--총 강화확률(기본 1강)
	local TotalEPer2 = CreateVarArr(7,FP)--총 강화확률(+2강)
	local TotalEPer3 = CreateVarArr(7,FP)--총 강화확률(+3강)
	local AutoBuyCode = CreateCcodeArr(7)

	function AutoBuy(CP,LvUniit,Cost)--Cost==String
		CIf(FP,{Memory(0x628438,AtLeast,1),CD(AutoBuyCode[CP+1],LvUniit)})
			CIf(FP, {TNWar(Money[CP+1],AtLeast,Cost)})
				f_LSub(FP, Money[CP+1], Money[CP+1], Cost)
				CreateUnitStacked({}, 1, LevelUnitArr[LvUniit][2], 43+CP, CP)
			CIfEnd()
		CIfEnd()
		
	end
for i = 0, 6 do -- 각플레이어
	CIf(FP,{HumanCheck(i,1)})
	UnitReadX(FP, i, "Men", 65+i, Income[i+1])
	if TestStart == 1 then
		f_LAdd(FP, PEXP[i+1], PEXP[i+1], "1")
		f_LMul(FP, PEXP[i+1], PEXP[i+1], "2")
		f_LAdd(FP, TotalExp[i+1], TotalExp[i+1], "1")
		f_LMul(FP, TotalExp[i+1], TotalExp[i+1], "2")
	end

	CreateUnitStacked(nil,1, 88, 36+i, i, nil, 1)--기본유닛지급

	DPSBuilding(i,DpsLV1[i+1],nil,{Ore},Money[i+1])
	DPSBuilding(i,DpsLV2[i+1],1000,{Gas},Money[i+1])




	CTrigger(FP,{TBring(i, AtMost, _Sub(IncomeMax[i+1],1), "Men", 65)},{MoveUnit(1, "Men", i, 15+i, 22+i),},1)
	DoActions(FP,{
		MoveUnit(1, "Men", i, 29+i, 36+i),
		MoveUnit(1, "Factories", i, 22+i, 57+i),
	})




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
	TriggerX(FP, {LocalPlayerID(i)}, {print_utf8(12,0,StrDesign("\x08ERROR \x04: 보유 유닛수가 너무 많아 유닛 구입을 할 수 없습니다.\x08 (최대 200기)"))},{preserved})
	
	CIfXEnd()



	BringJumpCcode = CreateCcode()
	CIf(FP,{Bring(i,AtLeast,1,"Men",8+i)},{SetCD(BringJumpCcode,0)}) --  유닛 강화시도하기
	CMov(FP,GEper,TotalEPer[i+1])
	CMov(FP,GEper2,TotalEPer2[i+1])
	CMov(FP,GEper3,TotalEPer3[i+1])
	for j = #LevelUnitArr-1, 1, -1 do
		local LV = LevelUnitArr[j][1]
		local UID = LevelUnitArr[j][2]
		local Per = LevelUnitArr[j][3]
		local EXP = LevelUnitArr[j][4]
		CallTriggerX(FP, Call_Enchant, {Bring(i,AtLeast,1,UID,8+i)}, {KillUnitAt(1, UID, 8+i, i),SetV(EExp,EXP),SetV(ELevel,LV-1),SetV(UEper,Per),SetV(ECP,i),SetCD(BringJumpCcode,1)})

	end
	CIfEnd()
	--강화성공한 유닛 생성하기(캔낫씹힘방지)
	for j, k in pairs(LevelUnitArr) do
		CreateUnitStacked({Memory(0x628438,AtLeast,1),CVAar(VArr(GetUnitVArr[i+1], k[1]-1), AtLeast, 1)}, 1, k[2], 50+i, i, {SetCVAar(VArr(GetUnitVArr[i+1], k[1]-1), Subtract, 1)})
	end


	CIf(FP,LocalPlayerID(i)) -- CAPrint에 전송할 값들
	f_LMov(FP,MoneyLoc,Money[i+1])
	CMov(FP,IncomeLoc,Income[i+1])
	CMov(FP,IncomeMaxLoc,IncomeMax[i+1])
	f_LMov(FP,ExpLoc,PEXP[i+1])
	f_LMov(FP,TotalExpLoc,TotalExp[i+1])
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
CS__InputVA(FP,iTbl1,0,TStr1,TStr1s,nil,0,TStr1s)
CIfXEnd()

CIfEnd()

function TEST() 
	local PlayerID = CAPrintPlayerID 
	--local Data = {{{0,9},{"０",{0x1000000}}}} 
	CA__SetValue(Str1,"\x07보유금액 \x04:  12\x04,123\x04,123\x04,123\x04,123\x04,123\x04,123 \x04원\x12\x07사냥터\x04 \x0D\x0D\x0D / \x0D\x0D\x0D\x0D\x0D",nil,1)
	--43
	--49
	CS__ItoCustom(FP,SVA1(Str1,42),IncomeLoc,nil,nil,{10,2},1,nil,"\x1B0",0x1B,{0,1})
	CS__ItoCustom(FP,SVA1(Str1,48),IncomeMaxLoc,nil,nil,{10,2},1,nil,"\x190",0x19,{0,1})
	CA__lItoCustom(SVA1(Str1,8),MoneyLoc,nil,nil,10,1,nil,{"\x1F\x0D","\x08\x0D","\x040"},{0x04,0x04,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x02,0x02,0x2,0x1E,0x1E,0x1E,0x04,0x04,0x04}
	,{0,1,3,4,5,7,8,9,11,12,13,15,16,17,19,20,21,23,24,25},nil,{0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0}})
	CA__InputVA(56*0,Str1,Str1s,nil,56*0,56*1-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x0FＥＸＰ\x04：",nil,1)
	CA__lItoCustom(SVA1(Str1,5),ExpLoc,nil,nil,10,nil,nil,"\x040",{0x1F,0x1F,0x1E,0x1E,0x1E,0x07,0x07,0x07,0x10,0x10,0x10,0x17,0x17,0x17,0x11,0x11,0x11,0x1C,0x1C,0x1C})
	CA__Input(MakeiStrData("\x08／",1),SVA1(Str1,27))
	CA__lItoCustom(SVA1(Str1,29),TotalExpLoc,nil,nil,10,nil,nil,"\x040",{0x1F,0x1F,0x1E,0x1E,0x1E,0x07,0x07,0x07,0x10,0x10,0x10,0x17,0x17,0x17,0x11,0x11,0x11,0x1C,0x1C,0x1C})
	
	
	CA__InputVA(56*1,Str1,Str1s,nil,56*1,56*2-2)

	
	function CS__InputTA(Player,Condition,SVA1,Value,Mask,Flag)
		if Flag == nil then Flag = {preserved} elseif Flag == 1 then Flag = {} end
		TriggerX(Player,Condition,{SetCSVA1(SVA1,SetTo,Value,Mask)},Flag)
	end
	
	
	end 
	CAPrint(iStr1,{Force1},{1,0,0,0,1,3,0,0},"TEST",FP,{}) 
	TriggerX(FP, {CD(TBLFlag,0)}, {CreateUnit(1,94,64,FP),RemoveUnit(94,FP)}, {preserved})--tbl상시갱신용. CreateUnitStacked 사용시 발동안함
	DoActionsX(FP, {SetCD(TBLFlag,0)})
	TriggerX(FP, ElapsedTime(AtLeast,240), {RemoveUnit(88,AllPlayers)}) -- 3분뒤 사라지는 기본유닛
	
end