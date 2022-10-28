function onInit_EUD()


	
	SetWeaponsDatX(103,{Behavior=1,Splash=false})
	SetWeaponsDatX(25,{Behavior=2,Splash=false})
	SetWeaponsDatX(26,{Behavior=2,Splash=false})
	SetUnitsDatX(62, {AirWeapon=104})
	SetUnitsDatX(40, {Graphic=200})
	--SetWeaponsDatX(104,{Behavior=1,Splash=false})


	SetUnitsDatX(127, {BdDimX=1,BdDimY=1,SizeL=1,SizeU=1,SizeR=1,SizeD=1,HP=8320000,Armor = 0,StarEditFlag=0x1C7})
	SetUnitsDatX(190, {BdDimX=1,BdDimY=1,SizeL=1,SizeU=1,SizeR=1,SizeD=1,HP=8320000,Armor = 0,StarEditFlag=0x1C7})
	
	for j,k in pairs({128,92,91}) do--상점, 설정유닛용
		SetUnitsDatX(k, {AdvFlag={0x20000000,0x20000000},HumanInitAct=23,ComputerInitAct=23,AttackOrder=23,AttackMoveOrder=23,IdleOrder=23,StarEditFlag=0x1C7})
		
	end
	DoActions(AllPlayers, {SetAllianceStatus(Force1, Ally),
	RunAIScript(P1VON),
	RunAIScript(P2VON),
	RunAIScript(P3VON),
	RunAIScript(P4VON),
	RunAIScript(P5VON),
	RunAIScript(P6VON),
	RunAIScript(P7VON),
	RunAIScript(P8VON),
})	
	for i = 0, 24 do
		SetUnitsDatX(i, {Reqptr=5,MinCost=0,GasCost=0,SuppCost=0})
	end
	
	
	
	
	PatchInput()

	if TestStart == 1 then
		CIfOnce(FP,nil,{SetMemory(0x5124F0,SetTo,1)}) -- 테스트모드 최대배속
	else
		CIfOnce(FP,nil,{SetMemory(0x5124F0,SetTo,0x15)}) -- 기본 3배속
	end

	DoActionsX(FP,{SetCDeaths(FP,SetTo,Limit,LimitX),SetCDeaths(FP,SetTo,TestStart,TestMode),}) -- Limit설정

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
	for i = 0, 6 do -- 내부 테스터 유저 트리거
		InputTesterID(i,"GALAXY_BURST")
		InputTesterID(i,"_Mininii")
		InputTesterID(i,"RonaRonaChan")
	end
	

	
	Trigger2X(FP, {
		CDeaths(FP,Exactly,1,LimitX);
		CDeaths(FP,Exactly,0,LimitC);}, {
			RotatePlayer({
				DisplayTextX(StrDesignX("\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.").."\n"..StrDesignX("\x04실행 방지 코드 0x32223223 작동."),4);
			Defeat();
			},Force1,FP);
			Defeat();
			SetMemory(0xCDDDCDDC,SetTo,1);})
	Trigger2X(FP, {Memory(0x51CE84,AtLeast,1001);}, {
		RotatePlayer({
			DisplayTextX(StrDesignX("\x1B방 제목에서 배속 옵션을 제거해 주십시오.").."\n"..StrDesignX("\x1B또는 게임 반응속도(턴레이트)를 최대로 올려주십시오.").."\n"..StrDesignX("\x04실행 방지 코드 0x32223223 작동."),4);
		Defeat();
		},Force1,FP);
		Defeat();
		SetMemory(0xCDDDCDDC,SetTo,1);})
	



	DoActions(FP,{SetMemory(LimitVerPtr,SetTo,LimitVer)})
	for i = 0, 6 do
		
	CIf(FP,{HumanCheck(i,1)})


	
		
	f_Read(FP, 0x628438, nil, Nextptrs)
	CDoActions(FP, {TSetNVar(TestShop[i+1], SetTo, Nextptrs),CreateUnit(1,128,1+i,i)})
	f_Read(FP, 0x628438, nil, Nextptrs)
	CDoActions(FP, {TSetNVar(DpsLV1[i+1], SetTo, _Add(Nextptrs,2)),CreateUnit(1,127,57+i,FP)})
	DoActions(FP, {SetLoc("Location "..(57+i),"U",Add,13*32),SetLoc("Location "..(57+i),"D",Add,13*32)})
	
	f_Read(FP, 0x628438, nil, Nextptrs)
	CDoActions(FP, {TSetNVar(DpsLV2[i+1], SetTo, _Add(Nextptrs,2)),CreateUnit(1,190,57+i,FP)})
	DoActions(FP, {SetLoc("Location "..(57+i),"L",Add,6*32),SetLoc("Location "..(57+i),"R",Add,6*32)})



	DoActions(FP, {SetLoc("Location "..(1+i),"L",Subtract,10*32),SetLoc("Location "..(1+i),"R",Subtract,11*32)})
	f_Read(FP, 0x628438, nil, Nextptrs)
	CDoActions(FP, {TSetNVar(SettingUnit1[i+1], SetTo, Nextptrs),CreateUnit(1,91,1+i,i)})
	DoActions(FP, {SetLoc("Location "..(1+i),"L",Add,2*32),SetLoc("Location "..(1+i),"R",Add,2*32)})
	f_Read(FP, 0x628438, nil, Nextptrs)
	CDoActions(FP, {TSetNVar(SettingUnit2[i+1], SetTo, Nextptrs),CreateUnit(1,92,1+i,i)})

	CIfEnd()

	end
	
	if TestStart == 1 then -- 테스트용 결과 출력
		f_GetStrXptr(FP,ETestStrPtr1,"\x0D\x0D\x0DET1".._0D)
		f_GetStrXptr(FP,ETestStrPtr2,"\x0D\x0D\x0DET2".._0D)
		f_GetStrXptr(FP,ETestStrPtr3,"\x0D\x0D\x0DET3".._0D)
		f_Memcpy(FP,ETestStrPtr1,_TMem(Arr(ETestTxt1[3],0),"X","X",1),ETestTxt1[2])
		f_Memcpy(FP,ETestStrPtr2,_TMem(Arr(ETestTxt2[3],0),"X","X",1),ETestTxt2[2])
		f_Memcpy(FP,ETestStrPtr3,_TMem(Arr(ETestTxt3[3],0),"X","X",1),ETestTxt3[2])

			
	end
	


	CIfEnd()

	
end

