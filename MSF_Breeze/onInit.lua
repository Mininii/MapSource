function onInit_EUD()
	SetUnitsDatX(32,{Playerable = 2, Reqptr=5,SuppCost=0})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(7,{Playerable = 2, Reqptr=5,SuppCost=0})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(0,{Playerable = 2, Reqptr=5,SuppCost=0})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(125,{HP=2000,MinCost=2000,BuildTime=15})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(109,{HP=500,MinCost=500,BuildTime=15})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(124,{HP=1500,MinCost=1000,BuildTime=15})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(72,{Playerable = 2, Reqptr=5,SuppCost=0,MinCost=0,GasCost=0,BuildTime=1})--플레이어만 사용가능, 요구조건을 무조건?으로
	for j,k in pairs(MedicTrig) do
		SetUnitsDatX(k,{Playerable = 2, Reqptr=5, MinCost=150+(j*50),GasCost=0,BuildTime = j,SuppCost = 0,RdySnd=999})--플레이어만 사용가능, 요구조건을 무조건?으로
	end
	for j,k in pairs(GiveUnitID) do
		SetUnitsDatX(k,{Playerable = 2, Reqptr=5, MinCost=0,GasCost=0,BuildTime = 1,SuppCost = 0})--플레이어만 사용가능, 요구조건을 무조건?으로
		table.insert(PatchArr,SetMemoryB(0x57F27C + ((j-1) * 228) + k,SetTo,0))
	end
	for j,k in pairs(BanToken) do
		SetUnitsDatX(k,{Playerable = 2, Reqptr=5, MinCost=0,GasCost=0,BuildTime = 1,SuppCost = 0})--플레이어만 사용가능, 요구조건을 무조건?으로
	end
	SetUnitsDatX(3,{Playerable = 2, Reqptr=5, MinCost=0,GasCost=0,BuildTime = 1,SuppCost = 0})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(83,{Playerable = 2, Reqptr=5, MinCost=0,GasCost=0,BuildTime = 1,SuppCost = 0})--플레이어만 사용가능, 요구조건을 무조건?으로
	
	
	for i = 1, 6 do
		for j=i,1,-1 do
			table.insert(PatchArr,SetMemoryB(0x57F27C + (i * 228) + BanToken[j],SetTo,0))
		end
		
	end
	SetUnitsDatX(115,{AdvFlag={1677721601,0xFFFFFFFF},BdDimX=1,BdDimY=1})--강퇴건물세팅

	CIfOnce(FP)
	DoActions2(FP, PatchArr)
	DoActions2(FP, PatchArr2)
	if TestStart == 1 then
		DoActionsX(FP, {SetResources(Force1, Add, 66666666, Ore),SetCD(TestMode,1)})
	
	end
	DoActions(FP, {CreateUnit(1, 115, 7, FP),SetMemory(0x5124F0,SetTo,0x1D),SetResources(Force1, Add, 500, Ore),SetCp(FP),RunAIScriptAt("Expansion Zerg Campaign Insane","AI"),RunAIScriptAt("Value This Area Higher",2)})
	NPA5(FP,0x6D5A30,FArr(TBLFile,0),TBLFiles)
	
	CIfEnd()
	DoActions2(FP, PatchArrPrsv)
end