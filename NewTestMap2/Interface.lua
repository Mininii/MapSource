function Interface()
	local ShopSw = CreateCcodeArr(7)
	local TestDpsV = CreateVarArr(7,FP)
	local TestDpsDest = CreateVarArr(7,FP)
	local Money = CreateWarArr(7,FP)
	local MoneyLoc = CreateWar(FP)

	
function CIfBtnFunc(CP,ID,ContentStr,DisContentStr,Conditions,Actions)
	CIf(FP,{TMemory(_Add(MenuPtrData[CP+1],0x98/4),Exactly,0 + ID*65536)})
	CurShopCP = CP
	CurShopCond = Conditions
	CallTrigger(FP,Call_Print13[CP+1])
	CTrigger(FP,{CDeaths(FP,AtMost,0,ShopSw[CP+1]),LocalPlayerID(CP),Conditions},{print_utf8(12,0,ContentStr)},{preserved})
	CTrigger(FP,{CDeaths(FP,AtMost,0,ShopSw[CP+1]),Conditions},{SetCDeaths(FP,SetTo,1,ShopSw[CP+1]),SetCp(CP),PlayWAV("staredit\\wav\\BuySE.ogg");SetCp(FP),Actions},{preserved})	-- 조건이 만족할 경우
	CTrigger(FP,{CDeaths(FP,AtMost,0,ShopSw[CP+1]),LocalPlayerID(CP)},{print_utf8(12,0,DisContentStr)},{preserved})
	CTrigger(FP,{CDeaths(FP,AtMost,0,ShopSw[CP+1])},{SetCDeaths(FP,SetTo,1,ShopSw[CP+1]),SetCp(CP),PlayWAV("staredit\\wav\\FailSE.ogg"),SetCp(FP)},{preserved})	-- 조건이 만족하지 않을 경우
end

function BtnSetInit(CP,MenuPtr)
	CIf(FP,{CVar(FP,MenuPtr[CP+1][2],AtLeast,19025),CVar(FP,MenuPtr[CP+1][2],AtMost,19025+(1699*84))})
	CIf(FP,{TMemory(_Add(MenuPtr[CP+1],0x98/4),AtMost,0 + 227*65536)})
	MenuPtrData = MenuPtr
	MenuPtrPlayer = CP
	
end

function BtnSetEnd()
	CIfEnd()--ShopEnd
	CDoActions(FP,{
		TSetMemory(_Add(MenuPtrData[MenuPtrPlayer+1],0x98/4),SetTo,0 + 228*65536);
		TSetMemory(_Add(MenuPtrData[MenuPtrPlayer+1],0x9C/4),SetTo,228 + 228*65536);
		TSetMemoryX(_Add(MenuPtrData[MenuPtrPlayer+1],0xA0/4),SetTo,228,0xFFFF);
		SetCDeaths(FP,SetTo,0,ShopSw[MenuPtrPlayer+1])})
	CIfEnd()
	MenuPtrData = nil
	MenuPtrPlayer = nil
end




for i = 0, 6 do -- 각플레이어
	CIf(FP,{HumanCheck(i,1)})
	for j,k in pairs(LevelUnitArr) do
		CreateUnitStacked(nil,6, k[2], 36+i, i, nil, 1)--테스트용
		
	end



	DPS = CreateVarArr(24, FP)
	TotalDPS = CreateVar(FP)
	DPSCheck = CreateCcode()
	CIf(FP,{CV(TestDps[i+1],19025,AtLeast)},{AddCD(DPSCheck,1)})


	f_Read(FP, TestDps[i+1], TestDpsV[i+1])
	--f_Diff(FP,TestDpsDest[i+1],TestDpsV[i+1],nil,0,2)
	CMov(FP,TestDpsDest[i+1],_Sub(_Mov(8320000*256),TestDpsV[i+1]))
	CrShift(FP, TestDpsDest[i+1], 8)


	CTrigger(FP,{TMemory(TestDps[i+1],AtMost,8319999*256)},{TSetMemory(TestDps[i+1],SetTo,8320000*256)},1)
	CMov(FP,TotalDPS,0)
	for j = 1, 24 do
		CTrigger(FP, {CD(DPSCheck,j)},{TSetNVar(DPS[j], SetTo, TestDpsDest[i+1])},1)
		CAdd(FP,TotalDPS,DPS[j])
	end
	CDoActions(FP,{TSetResources(i, SetTo, TotalDPS, Ore)})
	

	TriggerX(FP,{CD(DPSCheck,24,AtLeast)},{SetCD(DPSCheck,0)},{preserved})

	CIf(FP,{CV(TestDpsDest[i+1],1,AtLeast)})
	f_LAdd(FP,Money[i+1],Money[i+1],{TestDpsDest[i+1],0})
	CIfEnd()
	
	CIfEnd()


	DoActions(FP,{
		MoveUnit(All, "Men", i, 15+i, 22+i),
		MoveUnit(All, "Men", i, 29+i, 36+i),
	})




	BtnSetInit(i,TestShop)
	CIfBtnFunc(i,0,"테스트버튼","테스트버튼1")
	CIfEnd()

	BtnSetEnd()




	CIf(FP,{Bring(i,AtLeast,1,"Men",8+i)})

	CIfEnd()
	CIf(FP,LocalPlayerID(i))
	f_LMov(FP,MoneyLoc,Money[i+1])
	CIfEnd()

	CIfEnd()
end




function TEST() 
	local PlayerID = CAPrintPlayerID 
	--local Data = {{{0,9},{"０",{0x1000000}}}} 
	CA__SetValue(Str1,"\x07보유금액 \x04:  12\x04,123\x04,123\x04,123\x04,123\x04,123\x04,123 \x05원",nil,1)
	CA__lItoCustom(SVA1(Str1,8),MoneyLoc,nil,nil,10,1,nil,{"\x1F\x0D","\x08\x0D","\x040"},{0x04,0x04,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x02,0x02,0x2,0x1E,0x1E,0x1E,0x05,0x05,0x05}
	,{0,1,3,4,5,7,8,9,11,12,13,15,16,17,19,20,21,23,24,25},nil,{0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0}})
	CA__InputVA(56*0,Str1,Str1s,nil,56*0,56*1-3)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	
	function CS__InputTA(Player,Condition,SVA1,Value,Mask,Flag)
		if Flag == nil then Flag = {preserved} elseif Flag == 1 then Flag = {} end
		TriggerX(Player,Condition,{SetCSVA1(SVA1,SetTo,Value,Mask)},Flag)
	end
	
	
	end 
	CAPrint(iStr1,{Force1},{1,0,0,0,1,3,0,0},"TEST",FP,{}) 

	
end