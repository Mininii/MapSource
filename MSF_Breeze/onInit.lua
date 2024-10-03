function onInit_EUD()
	-- 바로 위에 StartCtrig() 있어야함 --
-- 첫 번째 플레이어가 P1일 경우 (아닐경우 P1을 다른 플레이어로 바꿔야함)
	UnitRepIndex2 = CreateVar(FP)
	CIfOnce(FP,{CV(UnitRepIndex,1,AtLeast),ElapsedTime(AtLeast, 3)})
	RepPlayerID = CreateVar(FP)
	CWhile(FP, {CV(UnitRepIndex,1,AtLeast)})
	f_Read(FP, ArrX(UnitPosArr,UnitRepIndex2), CPos)
	f_Read(FP, ArrX(UnitIDArr,UnitRepIndex2), RepHeroIndex)
	f_Read(FP, ArrX(PlayerIDArr,UnitRepIndex2), RepPlayerID)
	if X2_Mode == 1 then
		X2_Hero_Execute = CreateCcode()
		DoActionsX(FP, {SetCD(X2_Hero_Execute,1)})
		for j,k in pairs(UnitPointArr) do
			CTrigger(FP, {CV(RepHeroIndex,k[1])}, {SetCD(X2_Hero_Execute, 4)},{preserved})
		end
	end
	Convert_CPosXY()
	Simple_SetLocX(FP, 0, CPosX, CPosY, CPosX, CPosY)
	
	if X2_Mode == 1 then
	CWhile(FP, {CD(X2_Hero_Execute,1,AtLeast)}, {SubCD(X2_Hero_Execute, 1)})
	end
	CIf(FP,{Memory(0x628438, AtLeast, 1)})
	f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
	CMov(FP,CunitIndex,_Div(_Sub(Nextptrs,19025),_Mov(84)))
	CDoActions(FP, {TCreateUnit(1, RepHeroIndex, 1, RepPlayerID),Set_EXCC2(DUnitCalc,CunitIndex,1,SetTo,1)})
	CIfEnd()
	if X2_Mode == 1 then
	CWhileEnd()
	end
	CAdd(FP,UnitRepIndex2,1)
	CSub(FP,UnitRepIndex,1)
	CWhileEnd()
	CIfEnd()


	for i = 0, 227 do
	SetUnitsDatX(i,{AdvFlag={0x200000,0x200000}})--모든 유닛을 마법사로
	end
	SetUnitsDatX(130,{GroupFlag=0x11})--그룹플래그
	SetUnitsDatX(131,{GroupFlag=0x11})--그룹플래그
	SetUnitsDatX(132,{GroupFlag=0x11})--그룹플래그
	SetUnitsDatX(133,{GroupFlag=0x11})--그룹플래그
	SetUnitsDatX(162,{AdvFlag={0x400200,0x480200},BdDimX=1,BdDimY=1})--포토 파일런 불필요
	for j,k in pairs({89,90,93,94,95,96}) do
		SetUnitsDatX(k, {HumanInitAct = 2,
		ComputerInitAct = 2,
		AttackOrder = 10,
		AttackMoveOrder = 2,
		IdleOrder = 2,
		RClickAct = 1,SizeL=3,SizeU=3,SizeR=3,SizeD=3})
		
	end

	--if TestStart == 1 then
	--	SetUnitsDatX(0,{HP=9999})--테스트
	--	SetUnitsDatX(20,{HP=9999})--테스트
	--	SetWeaponsDatX(0, {DmgBase=1000})--테스트
	--	SetWeaponsDatX(1, {DmgBase=2000})--테스트
	--end
	SetUnitsDatX(84,{SizeL = 1, SizeU = 1, SizeR = 1, SizeD = 1})--이펙트유닛 크기 1로 조정
	SetUnitsDatX(72,{SizeL = 1, SizeU = 1, SizeR = 1, SizeD = 1})--이펙트유닛 크기 1로 조정
	SetUnitsDatX(1,{SizeL = 1, SizeU = 1, SizeR = 1, SizeD = 1,})--이펙트유닛 크기 1로 조정

	if EVFMode == 1 then
		for i = 0, 227 do
			SetUnitsDatX(i,{AdvFlag={0,0x4000}})--모든유닛 로보틱 제거
		end
		
		if X2_Mode == 1 then
			SetUnitsDatX(0,{HP = 2222,Shield = 777,MinCost=8500,AdvFlag={0x4000,0x4000}})--플레이어만 사용가능, 요구조건을 무조건?으로
			SetUnitsDatX(20,{HP = 7322,Shield = 1777,MinCost=50000,AdvFlag={0x4000,0x4000}})--플레이어만 사용가능, 요구조건을 무조건?으로
			SetWeaponsDatX(0, {TargetFlag = 0x020 + 1 + 2,DmgBase = 45,DmgFactor=3*2})
			SetWeaponsDatX(1, {TargetFlag = 0x020 + 1 + 2,DmgBase = 75,DmgFactor=7*2,Splash={7,14,21},FlingyID=150})
		else
			SetUnitsDatX(0,{Shield = 2000,MinCost=8500,AdvFlag={0x4000,0x4000}})--플레이어만 사용가능, 요구조건을 무조건?으로
			SetUnitsDatX(20,{Shield = 7322,MinCost=50000,AdvFlag={0x4000,0x4000}})--플레이어만 사용가능, 요구조건을 무조건?으로
			SetWeaponsDatX(0, {TargetFlag = 0x020 + 1 + 2,DmgBase = 45,DmgFactor=3})
			SetWeaponsDatX(1, {TargetFlag = 0x020 + 1 + 2,DmgBase = 75,DmgFactor=7,Splash={7,14,21},FlingyID=150})
		end
		

	end
	BSh = nil
	if X2_Mode == 1 then BSh = 5000 end
	SetUnitsDatX(32,{Playerable = 2, Reqptr=5,SuppCost=0})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(20,{Playerable = 2, Reqptr=5,SuppCost=0})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(8,{Playerable = 2, Reqptr=5,SuppCost=0,MinCost=9000*6,GasCost=0,BuildTime=1})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(7,{Playerable = 2, Reqptr=5,SuppCost=0})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(0,{Playerable = 2, Reqptr=5,SuppCost=0})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(1,{Playerable = 2, Reqptr=5,SuppCost=0})--플레이어만 사용가능, 요구조건을 무조건?으로


	
	SetUnitsDatX(28,{Playerable = 2, Reqptr=5,SuppCost=0,MinCost=0,GasCost=0,BuildTime=1})--스탑버튼
	SetUnitsDatX(27,{Playerable = 2, Reqptr=5,SuppCost=0,MinCost=0,GasCost=0,BuildTime=1})--홀드버튼
	SetUnitsDatX(29,{Playerable = 2, Reqptr=5,SuppCost=0,MinCost=0,GasCost=0,BuildTime=1})--어택버튼



	SetUnitsDatX(19,{Playerable = 2, Reqptr=5,SuppCost=0,MinCost=0,GasCost=0,BuildTime=1})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(125,{HP=5000,Shield = BSh,MinCost=2000,BuildTime=15,Reqptr=271,AdvFlag={0x8000,0x8000}})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(109,{HP=500,MinCost=500,BuildTime=15,AdvFlag={0x8000,0x8000}})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(124,{HP=1500,MinCost=1000,BuildTime=15,AdvFlag={0x8000,0x8000}})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(111,{AdvFlag={0x8000,0x8000}})--플레이어만 사용가능, 요구조건을 무조건?으로

	SetUnitsDatX(72,{Playerable = 2, Reqptr=5,SuppCost=0,MinCost=0,GasCost=0,BuildTime=1})--플레이어만 사용가능, 요구조건을 무조건?으로
	for j,k in pairs(MedicTrig) do
		SetUnitsDatX(k,{Playerable = 2, Reqptr=5, MinCost=150+((j-1)*50),GasCost=0,BuildTime = MedicTick[j],SuppCost = 0,RdySnd=999})--플레이어만 사용가능, 요구조건을 무조건?으로
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
	LimitX = CreateCcode()
	LimitT = CreateCcodeArr(7)
	LimitC = CreateCcode()
	for i = 0, 6 do
		DoActions(FP, {
			GiveUnits(1, 111, P12, 64, i),
			GiveUnits(1, 122, P12, 64, i),
			GiveUnits(1, 125, P12, 64, i),
		},1)
		if X2_Map== 1 then
		TriggerX(FP, {HumanCheck(i, 1)}, {SetCVar(FP,SetPlayers[2],Add,1),Simple_SetLoc(0, (1344+32+(i*64))*2,160*2, (1344+32+(i*64))*2,160*2),CreateUnit(1, 107, 1, i)})

		else
		TriggerX(FP, {HumanCheck(i, 1)}, {SetCVar(FP,SetPlayers[2],Add,1),
		Simple_SetLoc(0, 1344+(i*64),160, 1344+(i*64),160),
		CreateUnit(1, 107, 1, i),
		Simple_SetLoc(0, 1344+(i*64),96, 1344+(i*64),96),
		CreateUnit(1, 113, 1, i),
	})

		end
		TriggerX(FP, {HumanCheck(i, 0)}, {RemoveUnit(111, i),RemoveUnit(125, i),RemoveUnit(122, i)})
	end
	
	
if TestStart == 1 then
	DoActionsX(FP,{SetSwitch("Switch 254", Set)}) -- Limit설정
end
if Limit == 1 then
	DoActionsX(FP,{SetSwitch("Switch 253", Set)}) -- Limit설정
end
	DoActionsX(FP,{SetCDeaths(FP,SetTo,Limit,LimitX),SetCDeaths(FP,SetTo,TestStart,TestMode),SetInvincibility(Disable, 176, P12, 64),SetInvincibility(Disable, 177, P12, 64),SetInvincibility(Disable, 178, P12, 64),}) -- Limit설정
	function InputTesterID(Player,ID)
		if Limit == 1 then
			
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				isname(Player,ID);
				CDeaths(FP,AtLeast,1,LimitX);
			},
			actions = {
				SetCDeaths(FP,SetTo,1,LimitC);
				SetCDeaths(FP,SetTo,1,LimitT[Player+1]);
				
			}
		}
	else
		
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				isname(Player,ID);
				--CDeaths(FP,AtLeast,1,LimitX);
			},
			actions = {
				SetCDeaths(FP,SetTo,1,LimitC);
				SetCDeaths(FP,SetTo,1,LimitT[Player+1]);
				
				
			}
		}
		end
	end

		for i = 0, 7 do -- 정버아닌데 플레이어중 해당하는 닉네임 없으면 겜튕김
			InputTesterID(i,"GALAXY_BURST") 
			InputTesterID(i,"Natori_sana") 
		end
		
	T_YY = 2024
	T_MM = 01
	T_DD = 28
	T_HH = 00
	GlobalTime = os.time{year=T_YY, month=T_MM, day=T_DD, hour=T_HH }
	if Limit == 1 then
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				Memory(0x6D0F38,AtMost,GlobalTime);
	
			},
			actions = {
				SetCDeaths(FP,SetTo,1,LimitC);
				
			}
		}
        
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
		DoActionsX(FP, {SetResources(Force1, Add, 66666666, Ore),SetCD(TestMode,1),
		AddV(CTMin[1],66666666),
		AddV(CTMin[2],66666666),
		AddV(CTMin[3],66666666),
		AddV(CTMin[4],66666666),
		AddV(CTMin[5],66666666),
		AddV(CTMin[6],66666666),
		AddV(CTMin[7],66666666),})
	
	end
	DoActions2(FP, {	
		SetMemoryB(0x57F27C + (0 * 228) + 20,SetTo,0),
		SetMemoryB(0x57F27C + (1 * 228) + 20,SetTo,0),
		SetMemoryB(0x57F27C + (2 * 228) + 20,SetTo,0),
		SetMemoryB(0x57F27C + (3 * 228) + 20,SetTo,0),
		SetMemoryB(0x57F27C + (4 * 228) + 20,SetTo,0),
		SetMemoryB(0x57F27C + (5 * 228) + 20,SetTo,0),
		SetMemoryB(0x57F27C + (6 * 228) + 20,SetTo,0),
		SetMemoryB(0x57F27C + (0 * 228) + 8,SetTo,0),
		SetMemoryB(0x57F27C + (1 * 228) + 8,SetTo,0),
		SetMemoryB(0x57F27C + (2 * 228) + 8,SetTo,0),
		SetMemoryB(0x57F27C + (3 * 228) + 8,SetTo,0),
		SetMemoryB(0x57F27C + (4 * 228) + 8,SetTo,0),
		SetMemoryB(0x57F27C + (5 * 228) + 8,SetTo,0),
		SetMemoryB(0x57F27C + (6 * 228) + 8,SetTo,0),
	CreateUnit(1, 115, 7, FP),SetMemory(0x5124F0,SetTo,0x1D),SetResources(FP, Add, 10000000, OreAndGas),SetCp(FP)})
	--NPA5(FP,0x6D5A30,FArr(TBLFile,0),TBLFiles)



	CFor(FP,19025,19025+(84*1700),84)
	CI = CForVariable()
	
	condbox = {}
	for j,k in pairs(UnitPointArr2) do
		table.insert(condbox,CV(RepHeroIndex,k))
	end
	
	f_Read(FP,_Add(CI,25),RepHeroIndex,nil,0xFF,1)
	f_Read(FP,_Add(CI,19),PlayerV,nil,0xFF,1)
	


	CIf(FP,{CV(RepHeroIndex,173)})
	CDoActions(FP, {TSetMemory(_Add(CI,2), SetTo, 8380000*256)})
	CIfEnd()

	CIf(FP,{CV(RepHeroIndex,111)})
	for i = 0,6 do
		CIf(FP,CVX(PlayerV,i,0xFF))
		CMov(FP,BarPos[i+1],CI)
		--DisplayPrint(HumanPlayers, {"배럭 등록 완료"})
		CIfEnd()
	end
	
	CIfEnd()
	
	CIf(FP,{CV(RepHeroIndex,113)}) -- 팩토리 포인터
	for i = 0,6 do
		CIf(FP,CVX(PlayerV,i,0xFF))
		CMov(FP,FacPos[i+1],CI)
		--DisplayPrint(HumanPlayers, {"배럭 등록 완료"})
		CIfEnd()
	end
	CIfEnd()
	CIf(FP,{TTOR(condbox)})
	f_Read(FP,_Add(CI,10),CPos)
	CMov(FP,ArrX(UnitPosArr,UnitRepIndex),CPos)
	CMov(FP,ArrX(UnitIDArr,UnitRepIndex),RepHeroIndex,nil,0xFF,1)
	CMov(FP,ArrX(PlayerIDArr,UnitRepIndex),PlayerV,nil,0xFF,1)
	--CDoActions(FP,{Set_EXCC2(DUnitCalc,CunitIndex,1,SetTo,1)})
	CAdd(FP,UnitRepIndex,1)
	CIfEnd()
	CAdd(FP,CunitIndex,1)
	CForEnd()
	removebox = {}
	for j,k in pairs(UnitPointArr2) do
		table.insert(removebox,ModifyUnitEnergy(All, k, AllPlayers, 64, 0))
		table.insert(removebox,RemoveUnit(k, AllPlayers))
	end

	DoActions2(FP, removebox)

	CIfEnd()
	table.insert(PatchArrPrsv, KillUnitAt(All, "Dark Swarm", 64, AllPlayers))
	
	


	DoActions2(AllPlayers, PatchArrPrsv)
	DoActions2(AllPlayers, {
		ModifyUnitEnergy(All, "Any unit", AllPlayers, "Anywhere", 100),
		ModifyUnitHitPoints(All, "Any unit", Force1, "Anywhere", 100),
		ModifyUnitHitPoints(All, "Any unit", Force2, "Anywhere", 100),
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
	CanAct = {}

	for i = 0, 6 do
		table.insert(CanAct,SetMemory(0x582264 + (i*4),SetTo,3*2))
		table.insert(CanAct,SetMemory(0x5822C4 + (i*4),SetTo,3*2))
	end

	CanAct2 = {}

	for i = 0, 6 do
		table.insert(CanAct2,SetMemory(0x582264 + (i*4),SetTo,0))
		table.insert(CanAct2,SetMemory(0x5822C4 + (i*4),SetTo,0))
	end

	TriggerX(FP, {CD(UTAGECcode,0)}, CanAct, {preserved})
	TriggerX(FP, {CD(UTAGECcode,1)}, CanAct2, {preserved})
	CIf(FP, CD(GMode,1))
	CMov(FP,CunitIndex,0)
	GunSel = CreateVar(FP)
	CMov(FP,0x6509B0,19025+25)
	CIf(FP,{CV(GunSel,9,AtMost)})
		CFor(FP, 19025, 19025+(84*1700), 84)
		CI = CForVariable()

		CIf(FP,{CV(GunSel,10,AtMost),TTOR({
			DeathsX(CurrentPlayer,Exactly,134,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,135,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,136,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,137,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,138,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,139,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,140,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,141,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,142,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,149,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,176,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,177,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,178,0,0xFF),
		})})
		RandV = f_CRandNum(100000, 0)
		CIf(FP, {CV(RandV,500,AtMost),TMemoryX(_Add(CI,9), Exactly, 0,0xFF0000)})
		
		if Limit == 1 then
		CIf(FP,{CD(TestMode,1)})
		f_SaveCp()
		f_Read(FP, _Add(CI,10), CPos, nil, nil, 1)
		Convert_CPosXY()
		f_Read(FP, 0x628438, nil, Nextptrs)
		Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
		CDoActions(FP, {CreateUnit(1,84,1,FP),GiveUnits(All, 84, FP, 1, P9),TSetMemory(_Add(Nextptrs,2), SetTo, _Mul(GunSel,256))})
		f_LoadCp()
		CIfEnd()
		end


		CAdd(FP,GunSel,1)
		CDoActions(FP,  {TSetMemoryX(_Add(CI,9), SetTo, 1*65536,0xFF0000),Set_EXCC2(DUnitCalc, CunitIndex, 2, SetTo, GunSel)})
		CIfEnd()

		CIfEnd()









		CAdd(FP,0x6509B0,84)
		CAdd(FP,CunitIndex,1)
		CForEnd()
	CIfEnd()
	CIfEnd()

end