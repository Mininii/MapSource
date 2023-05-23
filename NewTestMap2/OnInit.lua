function onInit_EUD()


	
	SetWeaponsDatX(103,{Behavior=1,Splash=false})
	SetWeaponsDatX(25,{Behavior=2,Splash=false})
	SetWeaponsDatX(26,{Behavior=2,Splash=false})
	SetUnitsDatX(62, {AirWeapon=104})
	SetUnitsDatX(40, {Graphic=200})
	--SetWeaponsDatX(104,{Behavior=1,Splash=false})
	


	SetUnitsDatX(127, {BdDimX=1,BdDimY=1,SizeL=1,SizeU=1,SizeR=1,SizeD=1,HP=8320000,Armor = 0,StarEditFlag=0x1C7})
	SetUnitsDatX(190, {BdDimX=1,BdDimY=1,SizeL=1,SizeU=1,SizeR=1,SizeD=1,HP=8320000,Armor = 0,StarEditFlag=0x1C7})
	SetUnitsDatX(173, {BdDimX=1,BdDimY=1,SizeL=1,SizeU=1,SizeR=1,SizeD=1,HP=8320000,Armor = 0,StarEditFlag=0x1C7})
	for j,k in pairs(BossArr) do
		local addprop = {}
		SetUnitsDatX(k[1], {BdDimX=1,BdDimY=1,SizeL=1,SizeU=1,SizeR=1,SizeD=1,
		HP=8320000,Armor = 0,StarEditFlag=0x1C7,AdvFlag={0,0x38008004},GroundWeapon=117,AirWeapon=130,Class=193,GroupFlag=0xA,DefUpType=60,Shield=false,Height=4,
		HumanInitAct = 23,
		ComputerInitAct = 23,
		AttackOrder = 23,
		AttackMoveOrder = 23,
		IdleOrder = 23,
		RClickAct = 0,
		
	})--보스건물 세팅
	end
	for j,k in pairs(PBossArr) do
		SetUnitsDatX(k[1], {BdDimX=1,BdDimY=1,SizeL=1,SizeU=1,SizeR=1,SizeD=1,
		HP=8320000,Armor = 0,StarEditFlag=0x1C7,AdvFlag={0,0x38008005},GroundWeapon=117,AirWeapon=130,Class=193,GroupFlag=0xA,DefUpType=60,Shield=false,Height=4,
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
for i = 0, 25 do
	SetUnitsDatX(i, {Reqptr=5,MinCost=0,GasCost=0,SuppCost=0})
end

for i = 0, 227 do
	SetUnitsDatX(i, {AdvFlag={0,0x4},Height=4})
end

SetUnitsDatX(77, {DefType= 0})
SetUnitsDatX(104, {DefType= 0})
SetUnitsDatX(102, {DefType= 0})
flingyarr = {4,8,9,14,15,46,45,47,49,73,74,75,77,78,82,84,200}
for j,k in pairs(flingyarr) do
table.insert(PatchArr, SetMemoryB(0x6C9858 + k,SetTo,1))
end
	for i = 0, 6 do
		SetPersonalUnit(PersonalUIDArr[i+1],PersonalWIDArr[i+1],255,0,3250,57,1489,0xA)
	end
	
	PatchInput()

	if Limit==1 then
		CIfOnce(FP,nil,{SetMemory(0x5124F0,SetTo,TestSpeedNum)}) -- 테스트모드 최대배속
	else
		CIfOnce(FP,nil,{SetMemory(0x5124F0,SetTo,13)}) -- 기본 3배속
	end
iTblJump = def_sIndex()
	CJump(FP,iTblJump)
	iStrSize6 = GetiStrSize(0,"\x07『 \x0D\x0D\x0D\x0D\x0D\x0D단. "..MakeiStrVoid(20).." \x07』\x0D\x0D\x0D\x0D\x0D")

	S5 = MakeiTblString(PersonalUIDArr[1]+1,"None",'None',MakeiStrLetter("\x0D",iStrSize6+5),"Base",1) -- 단축키없음
	PMariTbl = {}
	for i = 0, 6 do
		PMariTbl[i+1] = GetiTblId(FP,PersonalUIDArr[i+1]+1,S5) 
	end
	MarStr = {}
	MarStra = {}
	MarStrs = {}
	for i = 0, 6 do
		MarStr[i+1], MarStra[i+1], MarStrs[i+1] = SaveiStrArr(FP,"\x07『 \x0D\x0D\x0D\x0D\x0D\x0D단. "..MakeiStrVoid(20).." \x07』\x0D\x0D\x0D\x0D\x0D")
	end
	CJumpEnd(FP,iTblJump)

	
	for i = 0, 6 do
		CS__ItoName(FP, SVA1(MarStr[i+1],13), i, nil, "\x0D", ColorCode[i+1])
	
		CS__InputVA(FP,PMariTbl[i+1],0,MarStr[i+1],MarStrs[i+1],nil,0,MarStrs[i+1]-3)
	
	
	end
	



	--CFor(FP,19025,19025+(84*1699),84) --치트 검사 배열에 모든 유닛 첫 등록
	--CI = CForVariable()
	--CMov(FP,Nextptrs,CI)
	----CallTrigger(FP, Call_CTInputUID)
	--CForEnd()
	DoActions2(FP, {
		RotatePlayer({SetMissionObjectivesX("\x13\x04건물을 \x08공격\x04하며 \x03많은 돈\x04을 벌고 유닛을 강화하여 \x07DPS\x04를 강화합시다! \n\x13\x04설명서는 B,N,M키, 각종 정보는 L,K,P 키로 확인 가능합니다.\n\n\x13\x17[SCA]\x04수동 저장은 \x08F9 키 \x04입니다.\n\n\x13\x04Creator - GALAXY_BURST\n\x13\x08혼자하기 힘들다면? \x07디스코드로 오세요!\n\x13\x04https://discord.gg/Tgsb6BbRgN")},Force1,FP)
	})

	DoActionsX(FP,{SetCDeaths(FP,SetTo,Limit,LimitX),SetCDeaths(FP,SetTo,TestStart,TestMode),RemoveUnit(188, AllPlayers)}) -- Limit설정

	T_YY = 2023
	T_MM = 05
	T_DD = 25
	T_HH = 00

	GlobalTime = os.time{year=T_YY, month=T_MM, day=T_DD, hour=T_HH }
	--PushErrorMsg(GlobalTime)
	if TestStart == 0 and Limit == 1 then
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
				SetCDeaths(FP,SetTo,1,LimitM[Player+1]);
				
			}
		}
	end
	for i = 0, 6 do -- 내부 관리자 판별 트리거
		InputTesterID(i,"GALAXY_BURST")
		InputTesterID(i,"Azusawa_Kohane")
		--InputTesterID(i,"_Mininii")
		--InputTesterID(i,"RonaRonaChan")
	end
	

	
	Trigger2X(FP, {
		CDeaths(FP,Exactly,1,LimitX);
		CDeaths(FP,Exactly,0,LimitC);}, {
			RotatePlayer({
				DisplayExtText(StrDesignX("\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.").."\n"..StrDesignX("\x04실행 방지 코드 0x32223223 작동."),4);
			Defeat();
			},Force1,FP);
			Defeat();
			SetMemory(0xCDDDCDDC,SetTo,1);})
	if TestStart == 0 then
		
--		if Limit == 1 then
--			local TempVV = CreateVar(FP)
--			f_Read(FP,0x51CE84,TempVV)
--			DisplayPrint(AllPlayers, {"\x13\x040x51CE84 : ",TempVV})
--		end
--		CTrigger(FP,{TTMemory(0x51CE84,NotSame,1000)},{
--			RotatePlayer({
--				DisplayExtText(StrDesignX("\x1B방 제목에서 배속 옵션을 제거하거나 게임 반응속도(턴레이트)를 최대로 올려주십시오.").."\n"..StrDesignX("\x1B또한 이 맵은 배틀넷에서만 플레이 가능합니다. 배틀넷에서 진행해 주십시오."),4);
--			},Force1,FP);
--			SetMemory(0xCDDDCDDC,SetTo,1);},1)
			
	end
	if TestStart == 0 then
		for i = 0, 6 do
			Trigger { -- 게임오버
				players = {FP},
				conditions = {
					Label(0);
					MemoryX(0x57EEE8 + 36*i,Exactly,1,0xFF);
				},
				actions = {
					RotatePlayer({
					DisplayExtText("\x13\x1B사람 슬롯 변경이 감지되었습니다. 컴퓨터 넣지마세요.\n\x13\x04실행 방지 코드 0x32223223 작동.",4);
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
			Label(0);
			MemoryX(0x57EEE8 + 36*7,Exactly,0,0xFF);
		},
		actions = {
			RotatePlayer({
			DisplayExtText("\x13\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.\n\x13\x04실행 방지 코드 0x32223223 작동.",4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDC,SetTo,1);
		}
	}
	Trigger { -- 게임오버
		players = {FP},
		conditions = {
			Label(0);
			MemoryX(0x57EEE8 + 36*7,Exactly,2,0xFF);
		},
		actions = {
			RotatePlayer({
			DisplayExtText("\x13\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.\n\x13\x04실행 방지 코드 0x32223223 작동.",4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDC,SetTo,1);
		}
	}
	Trigger { -- 게임오버
		players = {FP},
		conditions = {
			Label(0);
			MemoryX(0x57EEE0 + (36*7)+8,AtLeast,1*256,0xFF00);
		},
		actions = {
			RotatePlayer({
			DisplayExtText("\x13\x1B컴퓨터 종족 변경이 감지되었습니다. 다시 시작해주세요.\n\x13\x04실행 방지 코드 0x32223223 작동.",4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDC,SetTo,1);
		}
	}

	Trigger2X(FP,{},{RotatePlayer({
		DisplayTextX(
			StrDesignX("\x04건물을 \x08공격\x04하여 \x03많은 돈\x04을 벌고 유닛을 강화하여 \x07DPS\x04를 강화합시다!")..
			"\n"..StrDesignX("\x04설명서는 B,N,M키로 확인 가능합니다.")..
			"\n"..StrDesignX("\x17[SCA]\x04수동 저장은 \x08F9 키 \x04입니다.")..
			"\n"..StrDesignX("\x04Creator - GALAXY_BURST")..
			"\n"..StrDesignX("\x1FSTRCtrig \x04Assembler \x07v5.4\x04 \x04in Used \x19(つ>ㅅ<)つ"),4),
		PlayWAVX("sound\\Misc\\TRescue.wav"),PlayWAVX("sound\\Misc\\TRescue.wav"),PlayWAVX("sound\\Misc\\TRescue.wav")},HumanPlayers,FP)})
	
		if Limit == 1 then
			Trigger2X(FP,{Memory(0x6D0F38,AtMost,GlobalTime);},{RotatePlayer({DisplayExtText("\x13\x04현재 \x07테스트 버전\x04을 이용중입니다.\n\x13\x07테스트에 협조해주셔서 감사합니다. \n\x13\x04테스트맵 이용 가능 기간은 "..T_YY.."년 "..T_MM.."월 "..T_DD.."일 "..T_HH.."시 까지입니다.")},HumanPlayers,FP)})
			Trigger2X(FP,{Memory(0x6D0F38,AtLeast,GlobalTime);},{RotatePlayer({DisplayExtText("\x13\x04현재 \x07테스트 버전\x04을 이용중입니다.\n\x13\x07테스트에 협조해주셔서 감사합니다. \n\x13\x04테스트맵 이용 가능 기간은 종료되었으나 제작자가 게임에 참여중이므로 맵 실행 가능합니다..")},HumanPlayers,FP)})
		
		end
	DoActions(FP,{SetMemory(LimitVerPtr,SetTo,LimitVer)})
	f_GetTblptr(FP, Etbl, 1438)
	for i = 0, 6 do
		
	CIf(FP,{HumanCheck(i,1)},{})


	ItoName(FP,i,VArr(Names[i+1],0),ColorCode[i+1])
	
		
	f_Read(FP, 0x628438, ShopPtr[i+1], Nextptrs)
	CDoActions(FP, {TSetNVar(TestShop[i+1], SetTo, Nextptrs),CreateUnit(1,128,1+i,i)})
	
	--CallTrigger(FP, Call_CTInputUID)
	f_Read(FP, 0x628438, nil, Nextptrs)
	CDoActions(FP, {TSetNVar(DpsLV1[i+1], SetTo, _Add(Nextptrs,2)),CreateUnit(1,127,57+i,FP)})
	--CallTrigger(FP, Call_CTInputUID)
	DoActions(FP, {SetLoc("Location "..(57+i),"U",Add,13*32),SetLoc("Location "..(57+i),"D",Add,13*32)})
	f_Read(FP, 0x628438, nil, Nextptrs)
	CDoActions(FP, {TSetNVar(DpsLV2[i+1], SetTo, _Add(Nextptrs,2)),CreateUnit(1,190,57+i,FP)})
	--CallTrigger(FP, Call_CTInputUID)
	DoActions(FP, {SetLoc("Location "..(57+i),"L",Add,6*32),SetLoc("Location "..(57+i),"R",Add,6*32)})
	f_Read(FP, 0x628438, nil, Nextptrs)
	CDoActions(FP, {TSetNVar(DpsLV3[i+1], SetTo, _Add(Nextptrs,2)),CreateUnit(1,173,137+i,FP)})
	--CallTrigger(FP, Call_CTInputUID)



	DoActions(FP, {SetLoc("Location "..(1+i),"L",Subtract,10*32),SetLoc("Location "..(1+i),"R",Subtract,11*32)})
	f_Read(FP, 0x628438, nil, Nextptrs)
	CDoActions(FP, {TSetNVar(SettingUnit1[i+1], SetTo, Nextptrs),CreateUnit(1,91,1+i,i)})
	--CallTrigger(FP, Call_CTInputUID)

	DoActions(FP, {SetLoc("Location "..(1+i),"L",Add,2*32),SetLoc("Location "..(1+i),"R",Add,2*32)})
	f_Read(FP, 0x628438, nil, Nextptrs)
	CDoActions(FP, {TSetNVar(SettingUnit2[i+1], SetTo, Nextptrs),CreateUnit(1,92,1+i,i)})
	--CallTrigger(FP, Call_CTInputUID)
	DoActions(FP, {Simple_SetLoc("Location "..(1+i), PlayerPosArr2[i+1][1], PlayerPosArr2[i+1][2], PlayerPosArr2[i+1][1], PlayerPosArr2[i+1][2])})
	f_Read(FP, 0x628438, nil, Nextptrs)
	CDoActions(FP, {TSetNVar(TestShop2[i+1], SetTo, Nextptrs),CreateUnit(1,217,1+i,i)})
	DoActions(FP, {Simple_SetLoc("Location "..(1+i), PlayerPosArr[i+1][1], PlayerPosArr[i+1][2], PlayerPosArr[i+1][1], PlayerPosArr[i+1][2])})
	f_Read(FP, 0x628438, nil, Nextptrs)
	CDoActions(FP, {TSetNVar(SettingUnit3[i+1], SetTo, Nextptrs),CreateUnit(1,129,1+i,i)})
	--CallTrigger(FP, Call_CTInputUID)
	DoActions(FP, {SetLoc("Location "..(1+i),"L",Add,2*32),SetLoc("Location "..(1+i),"R",Add,2*32)})
	f_Read(FP, 0x628438, nil, Nextptrs)
	CDoActions(FP, {TSetNVar(SettingUnit4[i+1], SetTo, Nextptrs),CreateUnit(1,219,1+i,i)})
	--CallTrigger(FP, Call_CTInputUID)
	DoActions(FP, {Simple_SetLoc("Location "..(1+i), PlayerPosArr[i+1][1]-(8*32)+16, PlayerPosArr[i+1][2]+(1680), PlayerPosArr[i+1][1]-(8*32)+16, PlayerPosArr[i+1][2]+(1680))})
	f_Read(FP, 0x628438, nil, Nextptrs)
	
	CDoActions(FP, {TSetNVar(ShopUnit[i+1], SetTo, Nextptrs),CreateUnit(1, 15, 116, i),TSetMemoryX(_Add(Nextptrs,55), SetTo, 0xA00000,0xA00000)})
	--CallTrigger(FP, Call_CTInputUID)
	DoActions(FP, {SetLoc("Location "..(80+i),"U",Subtract,64),SetLoc("Location "..(80+i),"D",Subtract,64)})
	

	CIfEnd()

	end
	local LocSet = 0
	for j, k in pairs(LevelUnitArr) do
		CreateUnitStacked({}, 1, k[2], 87, nil, FP, {SetLoc("Location 87", "L", Add, 64),SetLoc("Location 87", "R", Add, 64)}, 1)

		LocSet = LocSet+1
		if LocSet == 10 then LocSet=0 DoActions(FP, {SetLoc("Location 87","U",Add,64),SetLoc("Location 87","D",Add,64),SetLoc("Location 87", "L", Subtract, 64*10),SetLoc("Location 87", "R", Subtract, 64*10)}) end
	end

	
	CFor(FP, 0, 1700, 1)
	CT_UID = CreateVar(FP)
	CT_PID = CreateVar(FP)
	CI = CForVariable()
	f_Read(FP, _Add(_Mul(CI,84),19025+25), CT_UID, nil, 0xFF,1)
	f_Read(FP, _Add(_Mul(CI,84),19025+19), CT_PID, nil, 0xFF,1)
	CDoActions(FP, {Set_EXCC2X(CT_Cunit,CI,0,SetTo,CT_UID,0xFF)})
	CDoActions(FP, {Set_EXCC2X(CT_Cunit,CI,2,SetTo,CT_PID,0xFF)})
	CForEnd()


	
	DoActionsX(FP,SetCtrig2X(SCA.ArrPtr, SetTo, "X",SCA.DataOffsetArr[2],0,1,0, nil))--배열 시작점 저장
--
	CIfEnd()
	CIfOnce(FP, {Memory(SCA.ArrPtr,Exactly,0)})
	for j,k in pairs(SCA.DataPtrArr) do
		CMov(FP,k,_ReadF(ArrX(SCA.DataOffsetArr, j-1)),nil,nil,1)
	end

	CIfEnd()

	
end

