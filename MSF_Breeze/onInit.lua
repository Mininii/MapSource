function onInit_EUD()
	-- 바로 위에 StartCtrig() 있어야함 --
MarCur = CreateVar()
MarPrev = CreateVar()
MarValue = CreateVar()
-- 첫 번째 플레이어가 P1일 경우 (아닐경우 P1을 다른 플레이어로 바꿔야함)
CRead(P1,MarCur,0x58A364) 
CSub(P1,MarValue,MarCur,MarPrev) -- P1MarValue에 추가된 마린 데스값을 저장함




	for i = 0, 227 do
	SetUnitsDatX(i,{AdvFlag={0x200000,0x200000}})--모든 유닛을 마법사로
	end
	SetUnitsDatX(162,{AdvFlag={0,0x80000}})--포토 파일런 불필요

	if TestStart == 1 then
		SetUnitsDatX(0,{HP=9999})--테스트
		SetUnitsDatX(20,{HP=9999})--테스트
		SetWeaponsDatX(0, {DmgBase=1000})--테스트
		SetWeaponsDatX(1, {DmgBase=2000})--테스트
	
	end


	SetUnitsDatX(32,{Playerable = 2, Reqptr=5,SuppCost=0})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(7,{Playerable = 2, Reqptr=5,SuppCost=0})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(0,{Playerable = 2, Reqptr=5,SuppCost=0})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(125,{HP=3500,MinCost=2000,BuildTime=15,Reqptr=271,AdvFlag={0x8000,0x8000}})--플레이어만 사용가능, 요구조건을 무조건?으로
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
	--NPA5(FP,0x6D5A30,FArr(TBLFile,0),TBLFiles)
	CunitIndex = CreateVar(FP)
	RepHeroIndex = CreateVar(FP)
	CFor(FP,19025,19025+(84*1700),84)
	CI = CForVariable()
	condbox = {}
	for j,k in pairs(UnitPointArr) do
		table.insert(condbox,CV(RepHeroIndex,k[1]))
	end
	
	f_Read(FP,_Add(CI,25),RepHeroIndex)
	CIf(FP,{TTOR(condbox)})
	CDoActions(FP,{Set_EXCC2(DUnitCalc,CunitIndex,1,SetTo,1)})
	CIfEnd()
	CAdd(FP,CunitIndex,1)
	CForEnd()
	CIfEnd()
	table.insert(PatchArrPrsv, RemoveUnitAt(All, "Dark Swarm", 2, AllPlayers))
	
	


	DoActions2(AllPlayers, PatchArrPrsv)
	DoActions2(AllPlayers, {
		ModifyUnitEnergy(All, "Any unit", AllPlayers, "Anywhere", 100),
		ModifyUnitHitPoints(All, "Any unit", AllPlayers, "Anywhere", 100),
		ModifyUnitShields(All, "Any unit", AllPlayers, "Anywhere", 100)
	},1)
	
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