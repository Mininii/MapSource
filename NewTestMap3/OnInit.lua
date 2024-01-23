function onInit_EUD()
	if Limit==1 then
		CIfOnce(FP,nil,{SetMemory(0x5124F0,SetTo,TestSpeedNum)}) -- 테스트모드 최대배속
	else
		CIfOnce(FP,nil,{SetMemory(0x5124F0,SetTo,0x1D)}) -- 기본 2배속
	end
	--DPSBuilding
	SetUnitsDatX(127, {BdDimX=1,BdDimY=1,SizeL=1,SizeU=1,SizeR=1,SizeD=1,HP=8320000,Armor = 0,StarEditFlag=0x1C7})
	SetUnitsDatX(190, {BdDimX=1,BdDimY=1,SizeL=1,SizeU=1,SizeR=1,SizeD=1,HP=8320000,Armor = 0,StarEditFlag=0x1C7})
	SetUnitsDatX(173, {BdDimX=1,BdDimY=1,SizeL=1,SizeU=1,SizeR=1,SizeD=1,HP=8320000,Armor = 0,StarEditFlag=0x1C7})


	--Effect Unit
	SetUnitsDatX(84, {BdDimX=1,BdDimY=1,SizeL=1,SizeU=1,SizeR=1,SizeD=1,HP=8320000,AdvFlag={0x4,0x4+0x80},Height=12})
	SetUnitsDatX(50, {BdDimX=1,BdDimY=1,SizeL=1,SizeU=1,SizeR=1,SizeD=1,HP=8320000,AdvFlag={0x4,0x4+0x80},Height=12})
	SetUnitsDatX(49, {BdDimX=1,BdDimY=1,SizeL=1,SizeU=1,SizeR=1,SizeD=1,HP=8320000,AdvFlag={0x4,0x4+0x80},Height=12,Graphic=86})

	for i = 0, 25 do
		SetUnitsDatX(i, {Reqptr=5,MinCost=0,GasCost=0,SuppCost=0})
	end
	
flingyarr = {4,8,9,14,15,46,45,47,49,73,74,75,77,78,82,84,200}
for j,k in pairs(flingyarr) do
table.insert(PatchArr, SetMemoryB(0x6C9858 + k,SetTo,1))
end
	PatchInput()


	
	DoActionsX(FP,{SetCDeaths(FP,SetTo,Limit,LimitX),SetCDeaths(FP,SetTo,TestStart,TestMode),RemoveUnit(188, AllPlayers)}) -- Limit설정

	T_YY = 2023
	T_MM = 06
	T_DD = 06
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
	for i = 0, 7 do -- 내부 관리자 판별 트리거
		InputTesterID(i,"GALAXY_BURST")
		InputTesterID(i,"Azusawa_Kohane")
		--InputTesterID(i,"_Mininii")
		InputTesterID(i,"RonaRonaChan")
	end
	

	DoActions(FP,{SetMemory(LimitVerPtr,SetTo,LimitVer)})
	
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
		
--		if Limit == 1 then
--			local TempVV = CreateVar(FP)
--			f_Read(FP,0x51CE84,TempVV)
--			DisplayPrint(AllPlayers, {"\x13\x040x51CE84 : ",TempVV})
--		end
--		CTrigger(FP,{TTMemory(0x51CE84,NotSame,1000)},{
--			RotatePlayer({
--				DisplayText(StrDesignX("\x1B방 제목에서 배속 옵션을 제거하거나 게임 반응속도(턴레이트)를 최대로 올려주십시오.").."\n"..StrDesignX("\x1B또한 이 맵은 배틀넷에서만 플레이 가능합니다. 배틀넷에서 진행해 주십시오."),4);
--			},Force1,FP);
--			SetMemory(0xCDDDCDDC,SetTo,1);},1)
			
	end
	if TestStart == 0 then
		for i = 0, 7 do
			Trigger { -- 게임오버
				players = {FP},
				conditions = {
					Label(0);
					MemoryX(0x57EEE8 + 36*i,Exactly,1,0xFF);
				},
				actions = {
					RotatePlayer({
						DisplayTextX("\x13\x1B사람 슬롯 변경이 감지되었습니다. 컴퓨터 넣지마세요.\n\x13\x04실행 방지 코드 0x32223223 작동.",4);
					Defeat();
					},Force1,FP);
					Defeat();
					SetCtrigX("X",0xFFFD,0x4,0,SetTo,"X",0xFFFD,0x0,0,1); -- ExitDrop
					SetMemory(0xCDDDCDDC,SetTo,1);
				}
			}
		end
	end

	if Limit == 1 then
		Trigger2X(FP,{Memory(0x6D0F38,AtMost,GlobalTime);},{RotatePlayer({DisplayTextX("\x13\x04현재 \x07테스트 버전\x04을 이용중입니다.\n\x13\x07테스트에 협조해주셔서 감사합니다. \n\x13\x04테스트맵 이용 가능 기간은 "..T_YY.."년 "..T_MM.."월 "..T_DD.."일 "..T_HH.."시 까지입니다.")},HumanPlayers,FP)})
		Trigger2X(FP,{Memory(0x6D0F38,AtLeast,GlobalTime);},{RotatePlayer({DisplayTextX("\x13\x04현재 \x07테스트 버전\x04을 이용중입니다.\n\x13\x07테스트에 협조해주셔서 감사합니다. \n\x13\x04테스트맵 이용 가능 기간은 종료되었으나 제작자가 게임에 참여중이므로 맵 실행 가능합니다..")},HumanPlayers,FP)})
	
	end
	

	CrystalPosUID = {
		816,1520,2224,2928,3632,4336,5040,5744
	}--PosY = 176+(i*32)
	MR = {144 ,{256, 256},{768, 256},{1280, 256},{1792, 256},{2304, 256},{2816, 256},{3328, 256},{3840, 256},{4352, 256},{4864, 256},{5376, 256},{5888, 256},{256, 768},{768, 768},{1280, 768},{1792, 768},{2304, 768},{2816, 768},{3328, 768},{3840, 768},{4352, 768},{4864, 768},{5376, 768},{5888, 768},{256, 1280},{768, 1280},{1280, 1280},{1792, 1280},{2304, 1280},{2816, 1280},{3328, 1280},{3840, 1280},{4352, 1280},{4864, 1280},{5376, 1280},{5888, 1280},{256, 1792},{768, 1792},{1280, 1792},{1792, 1792},{2304, 1792},{2816, 1792},{3328, 1792},{3840, 1792},{4352, 1792},{4864, 1792},{5376, 1792},{5888, 1792},{256, 2304},{768, 2304},{1280, 2304},{1792, 2304},{2304, 2304},{2816, 2304},{3328, 2304},{3840, 2304},{4352, 2304},{4864, 2304},{5376, 2304},{5888, 2304},{256, 2816},{768, 2816},{1280, 2816},{1792, 2816},{2304, 2816},{2816, 2816},{3328, 2816},{3840, 2816},{4352, 2816},{4864, 2816},{5376, 2816},{5888, 2816},{256, 3328},{768, 3328},{1280, 3328},{1792, 3328},{2304, 3328},{2816, 3328},{3328, 3328},{3840, 3328},{4352, 3328},{4864, 3328},{5376, 3328},{5888, 3328},{256, 3840},{768, 3840},{1280, 3840},{1792, 3840},{2304, 3840},{2816, 3840},{3328, 3840},{3840, 3840},{4352, 3840},{4864, 3840},{5376, 3840},{5888, 3840},{256, 4352},{768, 4352},{1280, 4352},{1792, 4352},{2304, 4352},{2816, 4352},{3328, 4352},{3840, 4352},{4352, 4352},{4864, 4352},{5376, 4352},{5888, 4352},{256, 4864},{768, 4864},{1280, 4864},{1792, 4864},{2304, 4864},{2816, 4864},{3328, 4864},{3840, 4864},{4352, 4864},{4864, 4864},{5376, 4864},{5888, 4864},{256, 5376},{768, 5376},{1280, 5376},{1792, 5376},{2304, 5376},{2816, 5376},{3328, 5376},{3840, 5376},{4352, 5376},{4864, 5376},{5376, 5376},{5888, 5376},{256, 5888},{768, 5888},{1280, 5888},{1792, 5888},{2304, 5888},{2816, 5888},{3328, 5888},{3840, 5888},{4352, 5888},{4864, 5888},{5376, 5888},{5888, 5888}}

	CSPlot(MR, FP, 101, 0, {0,0}, 1, 32, FP) -- 맵 리벌러 설치
	for i = 0, 7 do
		CIf(FP,{HumanCheck(i, 1)})
		f_Read(FP, 0x628438, nil, Nextptrs)
		CDoActions(FP, {TSetNVar(DpsLV1[i+1], SetTo, _Add(Nextptrs,2)),CreateUnit(1,127,2+i,FP),GiveUnits(All, 127, FP, 2+i, P9)})
		f_Read(FP, 0x628438, nil, Nextptrs)
		Simple_SetLocX(FP, 0, CrystalPosUID[i+1], 176+((0)*32), CrystalPosUID[i+1], 176+((0)*32))
		CDoActions(FP, {TSetNVar(SettingUnit1[i+1], SetTo, Nextptrs),CreateUnit(1,129,1,i)})
		CIfEnd()
	end

	CFor(FP, 0, 1700, 1)
	CI = CForVariable()
	CT_UID = CreateVar(FP)
	CT_PID = CreateVar(FP)
	f_Read(FP, _Add(_Mul(CI,84),19025+25),CT_UID)
	f_Read(FP, _Add(_Mul(CI,84),19025+19),CT_PID)
	CDoActions(FP, {Set_EXCC2X(CT_Cunit,CI,0,SetTo,CT_UID,0xFF)})
	CDoActions(FP, {Set_EXCC2X(CT_Cunit,CI,2,SetTo,CT_PID,0xFF)})
	
	CIf(FP,{CVX(CT_UID,101,0xFF)})
	CDoActions(FP,{TSetMemoryX(_Add(_Mul(CI,84),19025+72), SetTo, 0xFF00,0xFF00)})
	CIfEnd()
	CForEnd()
	f_Read(FP, SCA_DataPtr, nil, SCA_DataPtrV)


	function f_CreateTblptr(Player,TBLNum)
		local ret = CreateVar(Player)
		f_GetTblptr(Player, ret, TBLNum)
		return ret
	end
	
	f_GetTblptr(FP, Etbl, 334)
	AtkInfoTbl = f_CreateTblptr(FP,1469)

	CIfEnd()
end