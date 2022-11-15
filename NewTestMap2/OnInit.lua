function onInit_EUD()


	
	SetWeaponsDatX(103,{Behavior=1,Splash=false})
	SetWeaponsDatX(25,{Behavior=2,Splash=false})
	SetWeaponsDatX(26,{Behavior=2,Splash=false})
	SetUnitsDatX(62, {AirWeapon=104})
	SetUnitsDatX(40, {Graphic=200})
	--SetWeaponsDatX(104,{Behavior=1,Splash=false})
	


	SetUnitsDatX(127, {BdDimX=1,BdDimY=1,SizeL=1,SizeU=1,SizeR=1,SizeD=1,HP=8320000,Armor = 0,StarEditFlag=0x1C7})
	SetUnitsDatX(190, {BdDimX=1,BdDimY=1,SizeL=1,SizeU=1,SizeR=1,SizeD=1,HP=8320000,Armor = 0,StarEditFlag=0x1C7})
	for j,k in pairs(BossArr) do
		SetUnitsDatX(k[1], {BdDimX=1,BdDimY=1,SizeL=1,SizeU=1,SizeR=1,SizeD=1,
		HP=8320000,Armor = 0,StarEditFlag=0x1C7,AdvFlag={0,0x38008004},GroundWeapon=117,AirWeapon=130,Class=193,GroupFlag=0xA,DefUpType=60,Shield=false,Height=4,
		HumanInitAct = 23,
		ComputerInitAct = 23,
		AttackOrder = 23,
		AttackMoveOrder = 23,
		IdleOrder = 23,
		RClickAct = 0
	})--보스건물 세팅
	end
	for j,k in pairs({128,91,92,129,219}) do
		SetUnitsDatX(k, {GroupFlag=0x0})
	end
	for j,k in pairs({128,92,91}) do--상점, 설정유닛용
		SetUnitsDatX(k, {AdvFlag={0x20000000,0x20000000},HumanInitAct=23,ComputerInitAct=23,AttackOrder=23,AttackMoveOrder=23,IdleOrder=23,StarEditFlag=0x1C7,})
		
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
		CIfOnce(FP,nil,{SetMemory(0x5124F0,SetTo,0x15)}) -- 테스트모드 최대배속
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
				SetDeaths(Player, SetTo, 1, 100); -- 맵제작자 플래그
				
			}
		}
	end
	function InputTesterID2(Player,ID)
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
	for i = 0, 6 do -- 내부 관리자 판별 트리거
		InputTesterID(i,"GALAXY_BURST")
		InputTesterID(i,"_Mininii")
		InputTesterID(i,"RonaRonaChan")
		InputTesterID(i,"Azusawa_Kohane")
		InputTesterID2(i,"rhegb")
		InputTesterID2(i,"Hybrid)_GOD60")
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
	if TestStart == 0 then
	Trigger2X(FP, {Memory(0x51CE84,AtLeast,1001);}, {
		RotatePlayer({
			DisplayTextX(StrDesignX("\x1B방 제목에서 배속 옵션을 제거해 주십시오.").."\n"..StrDesignX("\x1B또는 게임 반응속도(턴레이트)를 최대로 올려주십시오.").."\n"..StrDesignX("\x04실행 방지 코드 0x32223223 작동."),4);
		Defeat();
		},Force1,FP);
		Defeat();
		SetMemory(0xCDDDCDDC,SetTo,1);})
	end
	if TestStart == 0 then
		for i = 0, 6 do
			Trigger { -- 게임오버
				players = {FP},
				conditions = {
					MemoryX(0x57EEE8 + 36*i,Exactly,1,0xFF);
				},
				actions = {
					RotatePlayer({
					DisplayTextX("\x13\x1B사람 슬롯 변경이 감지되었습니다. 컴퓨터 넣지마세요.\n\x13\x04실행 방지 코드 0x32223223 작동.",4);
					Defeat();
					},HumanPlayers,FP);
					Defeat();
					SetCtrigX("X",0xFFFD,0x4,0,SetTo,"X",0xFFFD,0x0,0,1); -- ExitDrop
					SetMemory(0xCDDDCDDC,SetTo,1);
				}
			}
		end
	end

		Trigger { -- 게임오버
		players = {FP},
		conditions = {
			MemoryX(0x57EEE8 + 36*7,Exactly,0,0xFF);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.\n\x13\x04실행 방지 코드 0x32223223 작동.",4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDC,SetTo,1);
		}
	}
	Trigger { -- 게임오버
		players = {FP},
		conditions = {
			MemoryX(0x57EEE8 + 36*7,Exactly,2,0xFF);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.\n\x13\x04실행 방지 코드 0x32223223 작동.",4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDC,SetTo,1);
		}
	}
	Trigger { -- 게임오버
		players = {FP},
		conditions = {
			MemoryX(0x57EEE0 + (36*7)+8,AtLeast,1*256,0xFF00);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x1B컴퓨터 종족 변경이 감지되었습니다. 다시 시작해주세요.\n\x13\x04실행 방지 코드 0x32223223 작동.",4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDC,SetTo,1);
		}
	}

	DoActions(FP,{SetMemory(LimitVerPtr,SetTo,LimitVer)})
	f_GetTblptr(FP, Etbl, 1438)
	for i = 0, 6 do
		
	CIf(FP,{HumanCheck(i,1)},{})


	ItoName(FP,i,VArr(Names[i+1],0),ColorCode[i+1])
	
		
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
	DoActions(FP, {SetLoc("Location "..(1+i),"L",Add,2*32),SetLoc("Location "..(1+i),"R",Add,2*32)})
	f_Read(FP, 0x628438, nil, Nextptrs)
	CDoActions(FP, {TSetNVar(SettingUnit3[i+1], SetTo, Nextptrs),CreateUnit(1,129,1+i,i)})
	DoActions(FP, {SetLoc("Location "..(1+i),"L",Add,2*32),SetLoc("Location "..(1+i),"R",Add,2*32)})
	f_Read(FP, 0x628438, nil, Nextptrs)
	CDoActions(FP, {TSetNVar(SettingUnit4[i+1], SetTo, Nextptrs),CreateUnit(1,219,1+i,i)})

	f_Read(FP, 0x628438, nil, Nextptrs)
	
	CDoActions(FP, {TSetNVar(ShopUnit[i+1], SetTo, Nextptrs),CreateUnit(1, 15, 116, i)})


	CIfEnd()

	end
	local LocSet = 0
	for j, k in pairs(LevelUnitArr) do
		CreateUnitStacked({}, 1, k[2], 87, nil, FP, {SetLoc("Location 87", "L", Add, 64),SetLoc("Location 87", "R", Add, 64)}, 1)

		LocSet = LocSet+1
		if LocSet == 10 then LocSet=0 DoActions(FP, {SetLoc("Location 87","U",Add,64),SetLoc("Location 87","D",Add,64),SetLoc("Location 87", "L", Subtract, 64*10),SetLoc("Location 87", "R", Subtract, 64*10)}) end
	end
	
	CIfEnd()

	
end

