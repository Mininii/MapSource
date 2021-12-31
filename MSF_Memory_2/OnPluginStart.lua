function init() -- 맵 실행시 1회 실행 트리거
	
	PatchArr = {}
	PatchArrPrsv = {}
	CTrigPatchTable = {}
	function SetToUnitDef(UnitID,Value)
	table.insert(PatchArr,SetMemoryB(0x65FEC8 + UnitID,SetTo,Value))
	end

	function UnitSizePatch(UnitID,L,U,R,D)
	table.insert(PatchArr,SetMemory(0x6617C8 + (UnitID*8),SetTo,(L)+(U*65536)))
	table.insert(PatchArr,SetMemory(0x6617CC + (UnitID*8),SetTo,(R)+(D*65536)))
	end

	function SetUnitClass(UnitID,Value)
	table.insert(PatchArr,SetMemoryB(0x663DD0 + UnitID,SetTo,Value))
	end

	function DefTypePatch(UnitID,Value)
	table.insert(PatchArr,SetMemoryB(0x662180 + UnitID,SetTo,Value))
	end

	function SetShield(UnitID)
	table.insert(PatchArr,SetMemoryW(0x660E00 + (UnitID *2), SetTo, 1000))
	table.insert(PatchArr,SetMemoryB(0x6647B0 + (UnitID), SetTo, 255))
	end

	function UnitEnable(UnitID,MinCost,GasCost,BuildTime,SuppCost)
	table.insert(PatchArrPrsv,SetMemoryW(0x660A70 + (UnitID *2),SetTo,5))
	table.insert(PatchArr,SetMemoryB(0x57F27C + (4 * 228) + UnitID,SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x57F27C + (5 * 228) + UnitID,SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x57F27C + (6 * 228) + UnitID,SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x57F27C + (7 * 228) + UnitID,SetTo,0))
	if MinCost ~= nil then
	table.insert(PatchArr,SetMemoryW(0x663888 + (UnitID *2),SetTo,MinCost)) -- 미네랄
	else
	table.insert(PatchArr,SetMemoryW(0x663888 + (UnitID *2),SetTo,0)) -- 미네랄
	end
	if GasCost ~= nil then
	table.insert(PatchArr,SetMemoryW(0x65FD00 + (UnitID *2),SetTo,GasCost)) -- 가스
	else
	table.insert(PatchArr,SetMemoryW(0x65FD00 + (UnitID *2),SetTo,0)) -- 가스
	end
	if BuildTime ~= nil then
	table.insert(PatchArr,SetMemoryW(0x660428 + (UnitID *2),SetTo,BuildTime)) -- 생산속도
	else
	table.insert(PatchArr,SetMemoryW(0x660428 + (UnitID *2),SetTo,1)) -- 생산속도
	end
	if SuppCost ~= nil then
	table.insert(PatchArr,SetMemoryB(0x663CE8 + UnitID,SetTo,SuppCost)) -- 서플
	else
	table.insert(PatchArr,SetMemoryB(0x663CE8 + UnitID,SetTo,0)) -- 서플
	end

	end
	function SetUnitDefUpType(UnitID,Value)
	table.insert(PatchArr,SetMemoryB(0x6635D0 + UnitID,SetTo,Value))
	end

	function SetUnitAdvFlag(UnitID,Value,Mask)
	table.insert(PatchArr,SetMemoryX(0x664080 + (UnitID*4),SetTo,Value,Mask))
	end


	function SetWepTargetFlags(WeaponID,Value)
	table.insert(PatchArr,SetMemoryW(0x657998 + (WeaponID*2), SetTo, Value))
	end

	function WeaponTypePatch(WeaponID,Value)
	table.insert(PatchArr,SetMemoryB(0x657258 + WeaponID,SetTo,Value))
	end


	function SetWepUpType(WeaponID,Value)
	table.insert(PatchArr,SetMemoryB(0x6571D0 + WeaponID, SetTo, Value))
	end

	function SetUnitCost(UnitID,Cost)
	table.insert(PatchArr,SetMemoryW(0x65FD00+(UnitID*2), SetTo, 0))
	table.insert(PatchArr,SetMemoryW(0x663888+(UnitID*2), SetTo, Cost))
	end

	function SetUnitGrpToMarine(UnitID) -- 플레이어 마린에게만 적용하는것
	table.insert(PatchArr,SetMemoryW(0x661FC0+(UnitID*2), SetTo, 0))
	table.insert(PatchArr,SetMemoryW(0x663C10+(UnitID*2), SetTo, 466))
	table.insert(PatchArr,SetMemoryW(0x661440+(UnitID*2), SetTo, 469))
	table.insert(PatchArr,SetMemoryW(0x65FFB0+(UnitID*2), SetTo, 462))
	table.insert(PatchArr,SetMemoryW(0x662BF0+(UnitID*2), SetTo, 465))
	table.insert(PatchArr,SetMemoryW(0x663B38+(UnitID*2), SetTo, 457))
	table.insert(PatchArr,SetMemoryW(0x661EE8+(UnitID*2), SetTo, 461))
	table.insert(PatchArr,SetMemoryB(0x6644F8 + UnitID, SetTo, 77))
	table.insert(PatchArr,SetMemoryW(0x662F88+(UnitID*2), SetTo, 12))
	end

	function SetGroupFlags(UnitID,Value)
		table.insert(PatchArr,SetMemoryB(0x6637A0 + (UnitID),SetTo,Value))
	end
	for j, k in pairs(HeroPointArr) do
		SetGroupFlags(k[2],0xA)
		if k[4] == 1 then
			SetUnitClass(k[2],162) -- 퍼뎀유닛
		else
			SetUnitClass(k[2],161) -- 일반유닛
		end
		
	end
	SetGroupFlags(15,0x9)
	table.insert(PatchArr,SetMemoryB(0x57F27C + (1 * 228) + BanToken[1],SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x57F27C + (2 * 228) + BanToken[1],SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x57F27C + (2 * 228) + BanToken[2],SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x57F27C + (3 * 228) + BanToken[1],SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x57F27C + (3 * 228) + BanToken[2],SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x57F27C + (3 * 228) + BanToken[3],SetTo,0))
	for i = 0, 227 do
	SetUnitDefUpType(i,60) -- 방업 적용 방지
	SetToUnitDef(i,0) -- 방어력 전부 0으로 설정 
	DefTypePatch(i,7) -- 방어타입 전부 7로 설정
	SetUnitAdvFlag(i,0,0x4000) -- 모든유닛 어드밴스드 플래그 중 로보틱 전부제거
	end
	for i = 0, 129 do
	WeaponTypePatch(i,0) -- 무기 타입 전부 0으로 설정(방갈림 방지)
	end
	PerWepArr = {8,12,27}
	for j, k in pairs(PerWepArr) do
		WeaponTypePatch(k,2)
	end
	for i = 63, 70 do
		UnitEnable(i) -- 원격스팀팩
	end
	
	for i=0,3 do
		table.insert(PatchArr,SetMemoryB(0x57F27C + (i * 228) + GiveUnitID[i+1],SetTo,0))
	end
	UnitEnable(71) -- 원격스팀팩
	UnitEnable(2) -- 자환
	UnitEnable(19,25000) -- 수정보호막
	UnitEnable(8,9000,nil,5,2) -- 마린
	UnitEnable(7,500) -- SCV
	
	UnitEnable(125,8000)
	UnitEnable(124,4000)
	UnitEnable(109,1000)
	UnitEnable(22) -- 브금
	UnitEnable(72) -- 예약메딕
	UnitEnable(60)
	UnitEnable(62)
	UnitEnable(61)
	for i = 1, 4 do
		UnitEnable(MedicTrig[i],25+(i*25),nil,i) -- 메딕
		DefTypePatch(MarID[i],i-1) -- 마린의 방어타입을 P1부터 차례대로 배분
		SetShield(MarID[i]) -- 마린 쉴드 설정. 쉴드 활성화 + 쉴드 1000 설정
		UnitSizePatch(MarID[i],7,10,7,11) -- 마린 크기 설정
		UnitEnable(MarID[i],9000,nil,5,2)
		SetUnitGrpToMarine(MarID[i]) -- 마린 그래픽 전부 마린으로 설정
		SetUnitAdvFlag(MarID[i],0x4000,0x4000) -- 플레이어 마린에 로보틱 부여
		SetWepTargetFlags(MarWep[i],0x020 + 1 + 2) -- 플레이어 마린 공격 비 로보틱 설정
		--SetWepUpType(MarWep[i],i-1) -- 플레이어 마린무기에 각각 다른 공업 적용
		
		
		table.insert(PatchArr,SetMemoryW(0x656EB0 + (MarWep[i]*2),SetTo,MarAtk)) -- 기본공격력
		table.insert(PatchArr,SetMemoryW(0x657678 + (MarWep[i]*2),SetTo,MarAtkFactor)) -- 추가공격력
		table.insert(PatchArr,SetMemoryB(0x6616E0 + MarID[i],SetTo,MarWep[i])) -- 지상무기
		table.insert(PatchArr,SetMemoryB(0x6636B8 + MarID[i],SetTo,MarWep[i])) -- 공중무기
	end

	--UnitEnable2(71)
	--UnitEnable2(19)

	
	
	table.insert(PatchArr,SetMemory(0x657A9C,SetTo,0)) -- 화면꺼트리기
	DoActions2(FP,PatchArr,1)
	DoActions2(Force1,PatchArrPrsv)
	DoActions2X(FP,CTrigPatchTable,1)
	CIfOnce(FP)
	
	for i = 0, 3 do
	ItoName(FP,i,VArr(Names[i+1],0),ColorCode[i+1])
	f_GetTblptr(FP,MarTblPtr[i+1],MarID[i+1]+1)
	_0DPatchforVArr(FP,Names[i+1],4)
	Install_CText1(MarTblPtr[i+1],Str12,Str02[i+1],Names[i+1])
	end

	f_GetTblptr(FP,NMDMGTblPtr,1463)
	f_GetTblptr(FP,PerDMGTblPtr,1464)
	f_GetTblptr(FP,AtkCondTblPtr,1413)
	f_GetTblptr(FP,HPCondTblPtr,1414)
	f_GetStrXptr(FP,HTextStrPtr,HTextStr)
	f_Memcpy(FP,AtkCondTblPtr,_TMem(Arr(AtkCondT[3],0),"X","X",1),AtkCondT[2])
	f_Memcpy(FP,HPCondTblPtr,_TMem(Arr(HPCondT[3],0),"X","X",1),HPCondT[2])
	ItoDec(FP,_Add(Level,1),VArr(LVVA,0),2,nil,0)--렙
	f_Movcpy(FP,_Add(AtkCondTblPtr,AtkCondT[2]),VArr(LVVA,0),4*4)
	f_Movcpy(FP,_Add(HPCondTblPtr,HPCondT[2]),VArr(LVVA,0),4*4)

	f_Memcpy(FP,_Add(NMDMGTblPtr,(4*4)),_TMem(Arr(ClassInfo1[3],0),"X","X",1),ClassInfo1[2])
	f_Memcpy(FP,_Add(NMDMGTblPtr,(4*8)+ClassInfo1[2]),_TMem(Arr(ClassInfo2[3],0),"X","X",1),ClassInfo2[2])
	f_Memcpy(FP,_Add(NMDMGTblPtr,(4*12)+ClassInfo1[2]+ClassInfo2[2]),_TMem(Arr(ClassInfo3[3],0),"X","X",1),ClassInfo3[2])
	f_Memcpy(FP,_Add(NMDMGTblPtr,(4*16)+ClassInfo1[2]+ClassInfo2[2]+ClassInfo3[2]),_TMem(Arr(ClassInfo4[3],0),"X","X",1),ClassInfo4[2])
	
	f_Memcpy(FP,_Add(PerDMGTblPtr,(4*4)),_TMem(Arr(ClassInfo1[3],0),"X","X",1),ClassInfo1[2])
	f_Memcpy(FP,_Add(PerDMGTblPtr,(4*8)+ClassInfo1[2]),_TMem(Arr(ClassInfo2[3],0),"X","X",1),ClassInfo2[2])
	f_Memcpy(FP,_Add(PerDMGTblPtr,(4*12)+ClassInfo1[2]+ClassInfo2[2]),_TMem(Arr(ClassInfo3[3],0),"X","X",1),ClassInfo3[2])
	f_Memcpy(FP,_Add(PerDMGTblPtr,(4*16)+ClassInfo1[2]+ClassInfo2[2]+ClassInfo3[2]),_TMem(Arr(ClassInfo6[3],0),"X","X",1),ClassInfo6[2])
	f_Memcpy(FP,_Add(PerDMGTblPtr,(4*20)+ClassInfo1[2]+ClassInfo2[2]+ClassInfo3[2]+ClassInfo6[2]),_TMem(Arr(ClassInfo5[3],0),"X","X",1),ClassInfo5[2])
	

	DoActionsX(FP,{SetCDeaths(FP,SetTo,Limit,LimitX),SetCDeaths(FP,SetTo,TestStart,TestMode)}) -- Limit설정
	if Limit == 1 then
		DoActions(FP,{SetSwitch("Switch 253",Set)})
	end

	for i = 0, 3 do -- 정버아닌데 플레이어중 해당하는 닉네임 없으면 겜튕김
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			isname(i,"GALAXY_BURST");
			CDeaths(FP,AtLeast,1,LimitX);
		},
		actions = {
			SetCDeaths(FP,SetTo,1,LimitC);
			
		}
	}
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			isname(i,"_Mininii");
			CDeaths(FP,AtLeast,1,LimitX);
		},
		actions = {
			SetCDeaths(FP,SetTo,1,LimitC);
			
		}
	}
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			isname(i,"RonaRonaChan");
			CDeaths(FP,AtLeast,1,LimitX);
		},
		actions = {
			SetCDeaths(FP,SetTo,1,LimitC);
			
		}
	}
	end

	T_YY = 2021
	T_MM = 12
	T_DD = 02
	T_HH = 00
	function PushErrorMsg(Message)
		_G["\n"..Message.."\n"]() 
	end
	GlobalTime = os.time{year=T_YY, month=T_MM, day=T_DD, hour=T_HH }
	--PushErrorMsg(GlobalTime)
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
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,Exactly,1,LimitX);
			CDeaths(FP,Exactly,0,LimitC);
			
		},
		actions = {
			RotatePlayer({
				DisplayTextX(StrDesignX("\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.").."\n"..StrDesignX("\x04실행 방지 코드 0x32223223 작동."),4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDC,SetTo,1);
		}
	}
	
	Trigger { -- 배속방지
		players = {FP},
		conditions = {
			Memory(0x51CE84,AtLeast,1001);
		},
		actions = {
			RotatePlayer({
				DisplayTextX(StrDesignX("\x1B방 제목에서 배속 옵션을 제거해 주십시오.").."\n"..StrDesignX("\x1B또는 게임 반응속도(턴레이트)를 최대로 올려주십시오.").."\n"..StrDesignX("\x04실행 방지 코드 0x32223223 작동."),4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDC,SetTo,1);
		}
	}


	for i = 4, 7 do
		Trigger { -- 게임오버
			players = {FP},
			conditions = {
				MemoryX(0x57EEE8 + 36*i,Exactly,0,0xFF);
			},
			actions = {
				RotatePlayer({
				DisplayTextX(StrDesignX("\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.").."\n"..StrDesignX("\x04실행 방지 코드 0x32223223 작동."),4);
				Defeat();
				},HumanPlayers,FP);
				Defeat();
				SetMemory(0xCDDDCDDC,SetTo,1);
			}
		}
		Trigger { -- 게임오버
			players = {FP},
			conditions = {
				MemoryX(0x57EEE8 + 36*i,Exactly,2,0xFF);
			},
			actions = {
				RotatePlayer({
					DisplayTextX(StrDesignX("\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.").."\n"..StrDesignX("\x04실행 방지 코드 0x32223223 작동."),4);
				Defeat();
				},HumanPlayers,FP);
				Defeat();
				SetMemory(0xCDDDCDDC,SetTo,1);
			}
		}
		Trigger { -- 게임오버
			players = {FP},
			conditions = {
				MemoryX(0x57EEE0 + (36*i)+8,AtLeast,1*256,0xFF00);
			},
			actions = {
				RotatePlayer({
					DisplayTextX("\x13"..StrDesign("\x1B컴퓨터 종족 변경이 감지되었습니다. 다시 시작해주세요.\n\x13\x04실행 방지 코드 0x32223223 작동."),4);
				Defeat();
				},HumanPlayers,FP);
				Defeat();
				SetMemory(0xCDDDCDDC,SetTo,1);
			}
		}
	end


	local StarEditAvFlag = CreateVar(FP)
	local GroupFlagsPtr = CreateVar(FP)
	local ShieldAvPtr = CreateVar(FP)
	local ShieldAmPtr = CreateVar(FP)
	local WepTypePtr = CreateVar(FP)
	local SeekRangePtr = CreateVar(FP)
	local SeekRange = CreateVar(FP)
	local WepLength = CreateVar(FP)
	local TargetFlagPtr = CreateVar(FP)
	local MaskRet1 = CreateVar(FP)
	local MaskRet3 = CreateVar(FP)
	local MaskRet2 = CreateVar(FP)
	local MaskRet4 = CreateVar(FP)
	local MaskRet5 = CreateVar(FP)
	local MaskRet6 = CreateVar(FP)
	local MaskRet7 = CreateVar(FP)
	local MaskRet8 = CreateVar(FP)
	local DivNum4 = CreateVar(FP)
	local DivNum2 = CreateVar(FP)
	local DivNum2_2 = CreateVar(FP)
	local DivNum4_2 = CreateVar(FP)
	
	CMov(FP,CurrentUID,0)
	CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227)) --  모든 유닛 전처리
	local Rep_Jump1 = def_sIndex()
	for j, k in pairs(Replace_JumpUnitArr) do
		NJumpX(FP,Rep_Jump1,{CVar(FP,CurrentUID[2],Exactly,k)})
	end

	f_Mod(FP,MaskRet1,CurrentUID,4)
	CMov(FP,MaskRet2,f_Sqrd(256,MaskRet1))
	f_Mod(FP,MaskRet3,CurrentUID,2)
	CMov(FP,MaskRet4,f_Sqrd(65536,MaskRet3))
	f_Div(FP,DivNum2,CurrentUID,_Mov(2))
	f_Div(FP,DivNum4,CurrentUID,_Mov(4))


	CMov(FP,SpecialAdvFlagPtr,CurrentUID,EPDF(0x664080)) -- SpecialAdvFlag
	CMov(FP,BdDimPtr,CurrentUID,EPDF(0x662860)) --BdDim
	

	CMov(FP,GroupFlagsPtr,DivNum4,EPDF(0x6637A0)) --GroupFlags
	CMov(FP,ShieldAvPtr,DivNum4,EPDF(0x6647B0)) --Has Shield
	CMov(FP,ShieldAmPtr,DivNum2,EPDF(0x660E00)) --Shield Amount
    CMov(FP,StarEditAvFlag,_Mul(CurrentUID,2),0x661518)
	

	local Temp1 = CreateVar(FP)
	local Temp2 = CreateVar(FP)
	f_Mul(FP,Temp1,MaskRet2,0x20)
	f_Mul(FP,Temp2,MaskRet2,0x9)

	ConvertArr(FP,ArrID,CurrentUID)
	CMov(FP,ArrX(BdDimArr,ArrID),_ReadF(BdDimPtr))
	f_Read(FP,_Add(CurrentUID,EPDF(0x662350)),ArrX(MaxHPBackUp,ArrID))
	CTrigger(FP,{TDeathsX(GroupFlagsPtr,Exactly,Temp2,0,Temp2)},{TSetMemoryX(GroupFlagsPtr,SetTo,Temp1,Temp1)},1) -- if Group ==Zerg And Unit then Set Group Factories
	CTrigger(FP,{TDeathsX(SpecialAdvFlagPtr,Exactly,0x1,0,0x1)},{TSetDeaths(BdDimPtr,SetTo,65537,0),TSetMemoryX(GroupFlagsPtr,SetTo,0,Temp1)},1) -- if Advanced Flags = Building then Building Dimensions SetTo 1x1, Remove Factories Flag
	CDoActions(FP,{TSetDeathsX(SpecialAdvFlagPtr,SetTo,0x200000,0,0x200000),}) -- All Unit SetTo Spellcaster
    Act_TSetMemoryW(StarEditAvFlag,SetTo,0x1C7,0x1C7)
--    CTrigger(FP,{CVar(FP,MaskRet3[2],Exactly,0)},{TSetDeathsX(StarEditAvFlag,SetTo,0x1C7,0,0x1C7)},1) -- Set All Units StarEdit Av Flags
--    CTrigger(FP,{CVar(FP,MaskRet3[2],Exactly,1)},{TSetDeathsX(StarEditAvFlag,SetTo,0x1C7*0x10000,0,0x1C7*0x10000)},1) -- Set All Units StarEdit Av Flags
	CTrigger(FP,{TMemoryX(ShieldAvPtr,Exactly,0,_Mul(MaskRet2,255))},{TSetDeathsX(ShieldAmPtr,SetTo,0,0,_Mul(MaskRet4,65535))},1) -- if Has Shield == 0 then Shield Amount = 0

	

	
	DoActionsX(FP,SetCD(BFlag,2))

	
	local SelClass = Act_BRead(_Add(CurrentUID,0x6637A0))

	CTrigger(FP,{CVar(FP,SelClass[2],Exactly,162)},{SetCD(BFlag,1)},1)
	local SelWepID = Act_BRead(_Add(CurrentUID,0x6636B8))



	NJumpX(FP,Rep_Jump1,CV(SelWepID,130))
	f_Mod(FP,MaskRet5,SelWepID,4)
	CMov(FP,MaskRet6,f_Sqrd(256,MaskRet5))
	f_Mod(FP,MaskRet7,SelWepID,2)
	CMov(FP,MaskRet8,f_Sqrd(65536,MaskRet7))
	f_Div(FP,DivNum2_2,SelWepID,_Mov(2))
	f_Div(FP,DivNum4_2,SelWepID,_Mov(4))


	CMov(FP,WepTypePtr,DivNum4_2,EPDF(0x657258))
	CTrigger(FP,{CD(BFlag,1)},{TSetMemoryX(WepTypePtr,SetTo,_Mul(MaskRet6,2),_Mul(MaskRet6,255))},1)
    CMov(FP,TargetFlagPtr,_Mul(SelWepID,2),0x657998)
    Act_TSetMemoryW(TargetFlagPtr,SetTo,3,3)

--	f_Read(FP,_Add(SelWepID,EPDF(0x657470)),WepLength)
--	CMov(FP,SeekRange,_Div(WepLength,32))
--	CMov(FP,0x57f120,SeekRange)--

--	CMov(FP,SeekRangePtr,DivNum4,EPDF(0x662DB8))
--	
--	CTrigger(FP,{},{TSetMemoryX(SeekRangePtr,SetTo,_Mul(MaskRet2,SeekRange),_Mul(MaskRet2,255))},1)
	
	
	NJumpXEnd(FP,Rep_Jump1)
	CAdd(FP,CurrentUID,1)
	CWhileEnd()
	CMov(FP,CurrentUID,0)






	
	

	
CMov(FP,0x6509B0,19025+19)
CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
	CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,Exactly,4,0,0xFF)})
		-- 유닛정보를 길이 8바이트의 데이터 배열에 저장함
		-- 0xYYYYXXXX 0xLLIIPPUU
		-- X = 좌표 X, Y = 좌표 Y, L = 유닛 식별자, I = 무적 플래그, P = 플레이어ID, U = 유닛ID
		CAdd(FP,0x6509B0,6)
		
		local Rep_Jump4 = def_sIndex()
		for j, k in pairs(Replace_JumpUnitArr) do
			NJumpX(FP,Rep_Jump4,{DeathsX(CurrentPlayer,Exactly,k,0,0xFF)})
		end
		CSub(FP,0x6509B0,6)
		f_SaveCp()
			f_Read(FP,_Sub(BackupCp,9),CPos)
			f_Read(FP,_Sub(BackupCp,17),CunitHP)
			f_Read(FP,BackupCp,CunitP,"X",0xFF)
			f_Div(FP,CunitHP,_Mov(256))
			f_Read(FP,_Add(BackupCp,6),RepHeroIndex)
			CMov(FP,Gun_LV,0)
			CTrigger(FP,{TTOR({
				CVar(FP,RepHeroIndex[2],Exactly,133),
				CVar(FP,RepHeroIndex[2],Exactly,132),
				CVar(FP,RepHeroIndex[2],Exactly,131)})},{TSetCVar(FP,Gun_LV[2],SetTo,CunitHP)},1)
			CMov(FP,CunitIndex,_Div(_Sub(BackupCp,19025+19),_Mov(84)))
			CMov(FP,0x6509B0,UnitDataPtr)
			NWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0))
			CAdd(FP,0x6509B0,2)
			NWhileEnd()
			CDoActions(FP,{
				TSetDeaths(CurrentPlayer,SetTo,CPos,0),
				SetMemory(0x6509B0,Add,1),
				TSetDeathsX(CurrentPlayer,SetTo,RepHeroIndex,0,0xFF),
				TSetDeathsX(CurrentPlayer,SetTo,_Mul(CunitP,_Mov(0x100)),0,0xFF00),
				TSetDeathsX(CurrentPlayer,SetTo,_Mul(Gun_LV,_Mov(0x1000000)),0,0xFF000000),
				})
				CTrigger(FP,{TMemoryX(_Add(BackupCp,36),Exactly,0x04000000,0x04000000)},{SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0x10000)},1) -- 0x10000 무적플래그
			--CDoActions(FP,{
			--	--TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(DUnitCalc[3],((0x20*8)/4))),SetTo,1),
			--	TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),DUnitCalc[3]),SetTo,Gun_LV)})
		f_LoadCp()
		CAdd(FP,0x6509B0,6)
		NJumpXEnd(FP,Rep_Jump4)
		CSub(FP,0x6509B0,6)
	CIfEnd()
	CAdd(FP,0x6509B0,84)
CWhileEnd()
CMov(FP,0x6509B0,FP)

CMov(FP,CurrentUID,0)
CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227))
local Rep_Jump2 = def_sIndex()
for j, k in pairs(Replace_JumpUnitArr) do
	NJumpX(FP,Rep_Jump2,{CVar(FP,CurrentUID[2],Exactly,k)})
end
CDoActions(FP,{
	TModifyUnitEnergy(All,CurrentUID,P5,64,0),
	TRemoveUnit(CurrentUID,P5)})
NJumpXEnd(FP,Rep_Jump2)
CAdd(FP,CurrentUID,1)
CWhileEnd()
CDoActions(FP,{KillUnit(35,P5)})
TriggerX(FP,{},{RotatePlayer({RunAIScript(P8VON),RunAIScript(P7VON),RunAIScript(P6VON),RunAIScript(P5VON)},MapPlayers,FP)})
CIfEnd({SetMemory(0x6509B0,SetTo,FP)}) -- OnPluginStart End
end
function init_Start() -- 게임 시작시 1회 실행 트리거
	CIfOnce(FP)
	
	CWhile(FP,CDeaths(FP,AtMost,3,CurPlace))
	CMov(FP,0x6509B0,UnitDataPtr)
	CWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0)) -- 배열에서 데이터가 발견되지 않을때까지 순환한다.
	--	CIf(FP,{TDeathsX(_Add(BackupCP,1),Exactly,TestCheck,0,0xFF)})
		CallTrigger(FP,f_Replace)-- 데이터화 한 유닛 재배치하는 코드
	--	CIfEnd()
		CAdd(FP,0x6509B0,2)
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
	DoActionsX(FP,{SetCDeaths(FP,Add,1,CurPlace)})
	CWhileEnd()
	--CIfEnd()
	DoActions(P8,SetResources(Force1,SetTo,0,Gas),1)
	CMov(FP,CurrentUID,0)
	CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227))
	local Rep_Jump3 = def_sIndex()
	for j, k in pairs(Replace_JumpUnitArr) do
		NJumpX(FP,Rep_Jump3,{CVar(FP,CurrentUID[2],Exactly,k)})
	end
	CMov(FP,BdDimPtr,CurrentUID,EPDF(0x662860)) --BdDim
	CMov(FP,SpecialAdvFlagPtr,CurrentUID,EPDF(0x664080)) -- SpecialAdvFlag
--	CTrigger(FP,{TDeathsX(SpecialAdvFlagPtr,Exactly,0x1,0,0x1)},{TSetMemoryX(SpecialAdvFlagPtr,SetTo,0,1)},1) -- if Advanced Flags = Building then Building = 0
	ConvertArr(FP,ArrID,CurrentUID)
	CDoActions(FP,{TSetMemory(BdDimPtr,SetTo,_ReadF(ArrX(BdDimArr,ArrID)))})
	NJumpEnd(FP,Rep_Jump3)
	CAdd(FP,CurrentUID,1)
	CWhileEnd()
	
	for i = 0, 3 do
		DoActions(i+4,{
			SetInvincibility(Disable,"Mineral Field (Type 1)",AllPlayers,"Anywhere");
			SetInvincibility(Disable,"Mineral Field (Type 2)",AllPlayers,"Anywhere");
			SetInvincibility(Disable,"Mineral Field (Type 3)",AllPlayers,"Anywhere");
			GiveUnits(All,"Mineral Field (Type 1)",P12,6+i,i);
			GiveUnits(All,"Mineral Field (Type 2)",P12,6+i,i);
			GiveUnits(All,"Mineral Field (Type 3)",P12,6+i,i);
			RunAIScript("Turn ON Shared Vision for Player 5");
			RunAIScript("Turn ON Shared Vision for Player 6");
			RunAIScript("Turn ON Shared Vision for Player 7");
			RunAIScript("Turn ON Shared Vision for Player 8");
			SetResources(CurrentPlayer,SetTo,10000000,OreAndGas);
			--SetMemory(0x582144 + (4 * (i+4)),SetTo,1600);
			--SetMemory(0x5821A4 + (4 * (i+4)),SetTo,1600);
			RunAIScriptAt("Expansion Zerg Campaign Insane",6+i);
			ModifyUnitEnergy(All,"Any unit",i,"Anywhere",100);
			RunAIScriptAt("Value This Area Higher",2+i),ModifyUnitResourceAmount(All,P12,64,65535)},1)
	end

	CIfEnd({SetMemoryX(0x664080 + (162*4),SetTo,0,1)})
end

