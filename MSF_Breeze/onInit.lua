function onInit_EUD()
	-- 바로 위에 StartCtrig() 있어야함 --
MarCur = CreateVar()
MarPrev = CreateVar()
MarValue = CreateVar()
-- 첫 번째 플레이어가 P1일 경우 (아닐경우 P1을 다른 플레이어로 바꿔야함)
CRead(P1,MarCur,0x58A364) 
CSub(P1,MarValue,MarCur,MarPrev) -- P1MarValue에 추가된 마린 데스값을 저장함
CRead(P1,MarPrev,0x58A364) 








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
	for j, k in pairs({37,38,39,41,43,44,45,46,47}) do
		SetUnitsDatX(k,{MinCost=0,GasCost=0,BuildTime=15})--저그유닛설정
	end


	
	for i = 0, 7 do
		table.insert(PatchArr,SetMemory(0x5821A4 + (i*4),SetTo,1500*2))
		table.insert(PatchArr,SetMemory(0x582144 + (i*4),SetTo,1500*2))
	end
	for i = 1, 6 do
		for j=i,1,-1 do
			table.insert(PatchArr,SetMemoryB(0x57F27C + (i * 228) + BanToken[j],SetTo,0))
		end
		
	end
	SetUnitsDatX(115,{AdvFlag={1677721601,0xFFFFFFFF},BdDimX=1,BdDimY=1})--강퇴건물세팅

	CIfOnce(FP)
	local LimitX = CreateCcode()
	local LimitC = CreateCcode()
	DoActionsX(FP,{SetCDeaths(FP,SetTo,Limit,LimitX),SetCDeaths(FP,SetTo,TestStart,TestMode)}) -- Limit설정
	function InputTesterID(Player,ID)
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				isname(Player,ID);
				CDeaths(FP,AtLeast,1,LimitX);
			},
			actions = {
				SetCDeaths(FP,SetTo,1,LimitC);
				
			}
		}
	end
		for i = 0, 7 do -- 정버아닌데 플레이어중 해당하는 닉네임 없으면 겜튕김
			InputTesterID(i,"GALAXY_BURST") 
			InputTesterID(i,"RonaRonaTTang") 
		end
		
	
		Trigger2X(FP, {
			CDeaths(FP,Exactly,1,LimitX);
			CDeaths(FP,Exactly,0,LimitC);}, {
				RotatePlayer({
					DisplayTextX(StrDesignX("\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.").."\n"..StrDesignX("\x04실행 방지 코드 0x32223223 작동."),4);
				Defeat();
				},HumanPlayers,FP);
				Defeat();
				SetMemory(0xCDDDCDDC,SetTo,1);})
	DoActions2(FP, PatchArr)
	DoActions2(FP, PatchArr2)
	if TestStart == 1 then
		DoActionsX(FP, {SetResources(Force1, Add, 66666666, Ore),SetCD(TestMode,1)})
	
	end
	DoActions(FP, {CreateUnit(1, 115, 7, FP),SetMemory(0x5124F0,SetTo,0x1D),SetResources(FP, Add, 10000000, OreAndGas),SetResources(Force1, Add, 500, Ore),SetCp(FP),RunAIScriptAt("Expansion Zerg Campaign Insane","AI"),RunAIScriptAt("Value This Area Higher",2)})
	NPA5(FP,0x6D5A30,FArr(TBLFile,0),TBLFiles)

	
	for i = 0, 6 do
		ItoName(FP,i,VArr(Names[i+1],0),ColorCode[i+1])
		_0DPatchforVArr(FP,Names[i+1],6)
		for j = 1, 4 do
			f_GetStrXptr(FP,NMStrPtrArr[j][i+1],"\x0D\x0D\x0D"..ColorCode[i+1].."NM"..(j).._0D)
			f_GetStrXptr(FP,HMStrPtrArr[j][i+1],"\x0D\x0D\x0D"..ColorCode[i+1].."HM"..(j).._0D)
			Install_CText1(NMStrPtrArr[j][i+1],Str00,_G["Str0"..j],Names[i+1])
			Install_CText1(HMStrPtrArr[j][i+1],Str00,_G["Str0"..(j+4)],Names[i+1])
			
		end
	end


	
	CIfEnd()
	table.insert(PatchArrPrsv, SetCp(FP))
	table.insert(PatchArrPrsv, RemoveUnitAt(All, "Dark Swarm", 2, AllPlayers))
	table.insert(PatchArrPrsv, SetMemory(0x6562F8, SetTo, 1179664))
	
	


	DoActions2(FP, PatchArrPrsv)
	
	Trigger {
		players = {FP},
		conditions = {  
			Command(FP,AtLeast,10,42);
			
		},
		actions = {
			KillUnit(42,FP);
			PreserveTrigger();
			
		},
	}

end