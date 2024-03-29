
function init()
	
	local CurrentUID = CreateVar(FP)
	local VRet = CreateVar(FP)
	local VRet2 = CreateVar(FP)
	local VRet3 = CreateVar(FP)
	local VRet4 = CreateVar(FP)
	local ArrID = CreateVar(FP)
	function onInit_EUD()
		CIfOnce(FP)
		SelHPEPD,MarHPEPD,SelShEPD,SelOPEPD = CreateVars(4)
		
		f_Read(FP,0x590000,"X",SelHPEPD) -- 플립에서 전송받은 플립 변수 주소를 V에 입력
		f_Read(FP,0x590004,"X",MarHPEPD) -- 플립에서 전송받은 플립 변수 주소를 V에 입력
		f_Read(FP,0x590008,"X",SelShEPD) -- 플립에서 전송받은 플립 변수 주소를 V에 입력
		f_Read(FP,0x59000C,"X",SelOPEPD) -- 플립에서 전송받은 플립 변수 주소를 V에 입력
		GiveT = {}
		for i = 6, 0, -1 do
			table.insert(GiveT,GiveUnits(1, 107, P12, 64, i))
			table.insert(GiveT,GiveUnits(1, 111, P12, 64, i))
		end
		if X2_Mode == 1 then
			table.insert(GiveT,Simple_SetLoc(0,7237,370,7374,400))
		else
			table.insert(GiveT,Simple_SetLoc(0,3634,182,3634+1,182+1))
		end
		for i = 0, 6 do
		if X2_Mode == 1 then
			table.insert(GiveT,GiveUnits(4, 125, P12, 1, i))
			table.insert(GiveT,Simple_CalcLoc(0,0,32*2,0,32*2))
		else
			table.insert(GiveT,GiveUnits(2, 125, P12, 1, i))
			table.insert(GiveT,Simple_CalcLoc(0,0,32,0,32))
		end
		end
		DoActions(FP,GiveT)
		PatchArrPrsv = {}	
		PatchArr = {}
		for i = 0, 6 do
		Trigger2(FP,{HumanCheck(i,0)},{RemoveUnit(125,i),RemoveUnit(107,i),RemoveUnit(111,i)})
		table.insert(PatchArr,SetMemoryB(0x57F27C + (i * 228) + 50,SetTo,0))
		table.insert(PatchArr,SetMemoryB(0x57F27C + (i * 228) + 51,SetTo,0))
		table.insert(PatchArr,SetMemoryB(0x57F27C + (i * 228) + 53,SetTo,0))
		table.insert(PatchArr,SetMemoryB(0x57F27C + (i * 228) + 54,SetTo,0))
		table.insert(PatchArr,SetMemoryB(0x57F27C + (i * 228) + 1,SetTo,0))

		
		end
		for j = 176,178 do
			table.insert(PatchArr,SetInvincibility(Disable, j, P12, 64))
			table.insert(PatchArr,SetMemory(0x662350+(j*4),SetTo,322*256))
			
		end

		function SetUnitAdvFlag(UnitID,Value,Mask)
			table.insert(PatchArr,SetMemoryX(0x664080 + (UnitID*4),SetTo,Value,Mask))
		end
		function SetZergGroupFlags(UnitID)
			table.insert(PatchArr,SetMemoryB(0x6637A0 + (UnitID),SetTo,0x01+0x08+0x20))
			end
			for i = 37, 57 do
			SetZergGroupFlags(i)
			end
			SetZergGroupFlags(62)
			SetZergGroupFlags(103)
			SetZergGroupFlags(104)
			function UnitEnable(UnitID)
			table.insert(PatchArrPrsv,SetMemoryW(0x660A70 + (UnitID *2),SetTo,5))
			
			table.insert(PatchArr,SetMemoryB(0x57F27C + (7 * 228) + UnitID,SetTo,0))
			table.insert(PatchArr,SetMemoryW(0x65FD00 + (UnitID *2),SetTo,0))
			table.insert(PatchArr,SetMemoryW(0x663888 + (UnitID *2),SetTo,0))
			table.insert(PatchArr,SetMemoryW(0x660428 + (UnitID *2),SetTo,1))
			table.insert(PatchArr,SetMemoryB(0x663CE8 + UnitID,SetTo,0))
			end
			
	function UnitEnableX(UnitID,MinCost,GasCost,BuildTime,SuppCost)
		table.insert(PatchArrPrsv,SetMemoryW(0x660A70 + (UnitID *2),SetTo,5))
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
			function SetUnitClass(UnitID)
				if type(UnitID) == "string" then
					UnitID = ParseUnit(UnitID)
				end
			table.insert(PatchArr,SetMemoryB(0x6637A0 + UnitID,SetTo,0x02+0x08))
			table.insert(PatchArr,SetMemoryB(0x663DD0 + UnitID,SetTo,199))
			end
		
			for i=0,6 do
			table.insert(PatchArr,SetMemoryB(0x57F27C + (i * 228) + GiveUnitID[i+1],SetTo,0))
			end
			for i=0,5 do
			table.insert(PatchArr,SetMemoryB(0x57F27C + ((i+1) * 228) + BanToken[i+1],SetTo,0))
			end
			function UnitEnable2(UnitID)
			table.insert(PatchArrPrsv,SetMemoryW(0x660A70 + (UnitID *2),SetTo,5))
			
			table.insert(PatchArr,SetMemoryB(0x57F27C + (7 * 228) + UnitID,SetTo,0))
			table.insert(PatchArr,SetMemoryB(0x663CE8 + UnitID,SetTo,0))
			end
			for i=0,55 do
			table.insert(PatchArr,SetMemory(0x662180 + 4*i,SetTo,0))
			end
			for i=0,32 do
			table.insert(PatchArr,SetMemory(0x657258 + 4*i,SetTo,0))
			end
			table.insert(PatchArr,SetMemoryB(0x657258 + 129,SetTo,0))
			table.insert(PatchArr,SetMemoryB(0x657258 + 117,SetTo,2))
			function ZergDefTypePatch(UnitID)
			table.insert(PatchArr,SetMemoryB(0x662180 + UnitID,SetTo,2))
			end
			function Force1DefTypePatch(UnitID)
			table.insert(PatchArr,SetMemoryB(0x662180 + UnitID,SetTo,1))
			end
			function ZergCreateSpeedPatch(UnitID)
			table.insert(PatchArr,SetMemoryW(0x660428 + (UnitID*2),SetTo,30))
			end
			function WeaponDefIgnore(UnitID)
			table.insert(PatchArr,SetMemoryB(0x657258 + (UnitID),SetTo,4))
			end
			
			function SetTo0UnitDef(Index)
			table.insert(PatchArr,SetMemory(0x65FEC8 + (Index*4),SetTo,0))
			end
			function EnermyNonBionic(Index)
			table.insert(PatchArr,SetMemoryX(0x664080 + (Index*4),SetTo,0,0x10000))
			end
			function UnitSizePatch(Index,Value)
			table.insert(PatchArr,SetMemory(0x6617C8 + (Index*8),SetTo,(Value)+(Value*65536)))
			table.insert(PatchArr,SetMemory(0x6617CC + (Index*8),SetTo,(Value)+(Value*65536)))
			end
			
			function SetToUnitDef(UnitID,Value)
				table.insert(PatchArr,SetMemoryB(0x65FEC8 + UnitID,SetTo,Value))
			end
			function DefTypePatch(UnitID,Value)
			table.insert(PatchArr,SetMemoryB(0x662180 + UnitID,SetTo,Value))
			end
		
			function WeaponTypePatch(WeaponID,Value)
			table.insert(PatchArr,SetMemoryB(0x657258 + WeaponID,SetTo,Value))
			end
			for i = 0, 227 do
				DefTypePatch(i,0) -- 방어타입 전부 0으로 설정
				SetToUnitDef(i,0) -- 방어력 전부 0으로 설정 
				SetUnitAdvFlag(i,0,0x4000) -- 모든유닛 어드밴스드 플래그 중 로보틱 전부제거
			end
			for i = 0, 129 do
				WeaponTypePatch(i,0) -- 무기 타입 전부 0으로 설정
			end
			WeaponTypePatch(27,1) -- 아덴시즈
			WeaponTypePatch(84,4) -- 스톰
			PUnitR = {0,1,16,20,100,7,125,124,60,12,99}
			HiddenHPMPatchArr = {}
			for j, k in pairs(PUnitR) do
				SetUnitAdvFlag(k,0x4000,0x4004)--공중제거 + 로보틱 적용
				table.insert(HiddenHPMPatchArr,SetMemoryX(0x664080 + (k*4),SetTo,0x80,0x80)) -- 히든모드 체젠 적용
				if k ~= 125 then
					SetUnitClass(k)
				end
			end
			
			
			for i = 1, 6 do
			UnitEnable(BanToken[i])
			end
			for i=1,7 do
			UnitEnable(GiveUnitID[i])
			end
			
			UnitEnable(72)
			UnitEnable(83)
			UnitEnable(3)
			UnitEnable(8)
			UnitEnable(50)
			UnitEnable(51)
			UnitEnable(52)
			UnitEnable(53)
			UnitEnable(54)
			UnitEnable(48)
			UnitEnable(52)
			UnitEnable(49)
			
			
			if X2_Mode == 1 then
				UnitEnableX(2,1000,nil,1,nil)
				UnitEnableX(0,NMCost,nil,1,nil)
				UnitEnableX(32,NMCost,nil,1,nil)
				UnitEnableX(1,0,nil,1)
			else
				UnitEnableX(2,1000,nil,3,nil)
				UnitEnableX(0,NMCost,nil,4,nil)
				UnitEnableX(32,NMCost,nil,4,nil)
				UnitEnableX(1,0,nil,12)
			end
			UnitEnableX(7,500)
			UnitEnableX(125,5000)
			UnitEnableX(124,2000)
			for i = 1, 4 do
				UnitEnableX(MedicTrig[i],200+(i*50),nil,i,nil)
			end
			
			
			table.insert(PatchArr,SetMemoryX(0x6559CC, SetTo, AtkFactor*65536,0xFFFF0000))
			table.insert(PatchArr,SetMemoryX(0x6559C0, SetTo, DefFactor,0xFFFF))
			table.insert(PatchArr,SetMemoryX(0x6559DC, SetTo, SuFactor,0xFFFF))
			
			
			HondonPatchArr = {}
			function HondonPatch(FlingyID,TunRad)
				if TunRad ~= nil then
				table.insert(HondonPatchArr, SetMemoryB(0x6C9E20 + FlingyID,SetTo,TunRad))
				else 
					table.insert(HondonPatchArr, SetMemoryB(0x6C9E20 + FlingyID,SetTo,40))
				end
				table.insert(HondonPatchArr, SetMemoryB(0x6C9858 + FlingyID,SetTo,0))
				table.insert(HondonPatchArr, SetMemory(0x6C9930 + (FlingyID*4),SetTo,0))
				table.insert(HondonPatchArr, SetMemoryW(0x6C9C78 + (FlingyID*2),SetTo,4000))
				table.insert(HondonPatchArr, SetMemory(0x6C9EF8 + (FlingyID*4),SetTo,20000))
			end
			
			table.insert( HondonPatchArr,SetMemory(0x656A18+(4*28), SetTo, 0)) -- 듀크최소사거리
			table.insert( HondonPatchArr,SetMemoryW(0x656EB0+(27*2), SetTo, 4800)) -- 아덴시즈공
			table.insert( HondonPatchArr,SetMemoryW(0x656EB0+(28*2), SetTo, 627)) -- 듀크공
			table.insert( HondonPatchArr,SetMemoryB(0x656FB8+27, SetTo, 1))
			table.insert( HondonPatchArr,SetMemoryB(0x656FB8+28, SetTo, 1))
			table.insert( HondonPatchArr,SetMemoryW(0x656888+(6*2), SetTo, 8192))
			table.insert( HondonPatchArr,SetMemoryW(0x6570C8+(6*2), SetTo, 8192))
			table.insert( HondonPatchArr,SetMemoryW(0x657780+(6*2), SetTo, 8192))
			table.insert( HondonPatchArr,SetMemory(0x515B9C, SetTo, 64))
			table.insert( HondonPatchArr,SetMemory(0x515BA0, SetTo, 64))
			table.insert( HondonPatchArr,SetMemory(0x515BA4, SetTo, 64))
			table.insert( HondonPatchArr,SetMemory(0x515BA8, SetTo, 64))
			table.insert( HondonPatchArr,SetMemory(0x515BAC, SetTo, 64))
			
			
			
			HondonPatch(75)
			HondonPatch(82)
			HondonPatch(70) -- 배틀
			HondonPatch(80)
			for j, k in pairs(HondonFlingyArr) do
				HondonPatch(k)
			end
			
			
			Trigger { -- 퍼센트 데미지 세팅, 버튼셋
				players = {FP},
				actions = {	                    
					SetMemory(0x515B88,SetTo,256);
                    SetMemory(0x515B8C,SetTo,256);
                    SetMemory(0x515B90,SetTo,256);
                    SetMemory(0x515B94,SetTo,256);
                    SetMemory(0x515B98,SetTo,256);
                    SetMemory(0x515B9C,SetTo,128);
                    SetMemory(0x515BA0,SetTo,128);
                    SetMemory(0x515BA4,SetTo,128);
                    SetMemory(0x515BA8,SetTo,128);
                    SetMemory(0x515BAC,SetTo,128);
                    SetMemory(0x515BB0,SetTo,256);
                    SetMemory(0x515BB4,SetTo,256);
                    SetMemory(0x515BB8,SetTo,256);
                    SetMemory(0x515BBC,SetTo,256);
                    SetMemory(0x515BC0,SetTo,256);
                    SetMemory(0x515BC4,SetTo,256);
                    SetMemory(0x515BC8,SetTo,256);
                    SetMemory(0x515BCC,SetTo,256);
                    SetMemory(0x515BD0,SetTo,256);
                    SetMemory(0x515BD4,SetTo,256);        
					--SetMemory(0x5188AC, SetTo, 5339096);
					--SetMemory(0x518C9C, SetTo, 5339096);		
					--SetMemory(0x5188A8, SetTo, 6);
					--SetMemory(0x518C98, SetTo, 6);
				},
				}

				
			for i = 1, #ZergGndUArr do
				table.insert(CtrigInitArr[FP+1],SetVArrayX(VArr(ZergGndVArr,i-1),"Value",SetTo,ZergGndUArr[i]))
			end
			
			if RMode == 1 then
				for j,k in pairs(ZergGndUArr) do
				SetUnitsDat2X(PatchArr,k,{SizeL=4,SizeU=4,SizeR=4,SizeD=4})
				end
			end
			if Limit == 1 then
				SetUnitsDat2X(PatchArr,60,{Graphic=80})
				SetWeaponsDatX(PatchArr,120,{FlingyID=206,Behavior=2})
				--158
				--206

				for j,k in pairs(ZergGndUArr) do
					--SetUnitsDat2X(PatchArr,k,{Height=12,AdvFlag={4,4}})

				end
				
			end
			--SetUnitsDat2X(PatchArr,13,{AdvFlag={4,4}}) 

			--SetUnitsDat2X(PatchArr,25,{AdvFlag={4,4}})
			--SetUnitsDat2X(PatchArr,30,{AdvFlag={4,4}})
--			for i = 0, 6 do
--				table.insert(PatchArr,SetMemory(0x5821A4 + (4*i),SetTo,GunLimit*2))
--				table.insert(PatchArr,SetMemory(0x582144 + (4*i),SetTo,GunLimit*2))
--			end

			DoActionsX(FP,{SetCDeaths(FP,SetTo,Limit,LimitX),SetCDeaths(FP,SetTo,TestStart,TestMode)}) -- Limit설정

			
	T_YY = 2024
	T_MM = 01
	T_DD = 25
	T_HH = 01
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
				SetCD(Emer_EscapeC[Player+1],1);
				
			}
		}
	end
		for i = 0, 6 do -- 정버아닌데 플레이어중 해당하는 닉네임 없으면 겜튕김
			InputTesterID(i,"GALAXY_BURST")
			InputTesterID(i,"_Mininii")
			InputTesterID(i,"RonaRonaChan")
			InputTesterID(i,"RonaRonaTTang")
			InputTesterID(i,"Azusawa_Kohane")
			
			
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


	for i = 7, 7 do
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



	if STRCTRIGASM == 1 then
		TMem(FP,UnitNamePtr,UnitNamePtrVoid,nil,nil,1)
	end
	if Limit == 1 then
		DoActions(FP,{SetSwitch("Switch 254",Set)})
		DoActions(FP,{RotatePlayer({DisplayTextX(StrDesignX("\x04현재 "..#G_CAPlot_Shape_InputTable.."개의 도형 데이터가 입력되었습니다."),4)},HumanPlayers,FP)})
		Trigger2(FP,{},{RotatePlayer({DisplayTextX("\x13\x04현재 \x07테스트 버전\x04을 이용중입니다.\n\x13\x07테스트에 협조해주셔서 감사합니다. \n\x13\x04테스트맵 이용 가능 기간은 "..T_YY.."년 "..T_MM.."월 "..T_DD.."일 "..T_HH.."시 까지입니다."),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,FP)})
	end

	
	for i = 0, 6 do
		TriggerX(FP,{HumanCheck(i,1)},{SetCVar(FP,SetPlayers[2],Add,1)})
	end
			CFor(FP,0,600,1)
				local CI = CForVariable()
				local TempArrI = CreateVar(FP)
				ConvertArr(FP,TempArrI,CI)
				for i = 0, 13 do
				CMov(FP,Arr(HactLinkArr[i+1],TempArrI),0)
				CMov(FP,Arr(LairLinkArr[i+1],TempArrI),0)
				end
			CForEnd()
	
			f_GetStrXptr(FP,UPCompStrPtr,"\x0D\x0D\x0DUPC".._0D)
			f_GetStrXptr(FP,f_GunStrPtr,"\x0D\x0D\x0Df_Gun".._0D)
			f_GetStrXptr(FP,G_CA_StrPtr,"\x0D\x0D\x0DG_CA_Err".._0D)
			f_GetStrXptr(FP,G_CA_StrPtr2,"\x0D\x0D\x0DG_CA_Func".._0D)
			f_GetStrXptr(FP,G_CA_StrPtr3,"\x0D\x0D\x0DG_CA_SendError".._0D)
			f_GetStrXptr(FP,f_GunSendStrPtr,"\x0D\x0D\x0Df_GunSend".._0D)
			f_GetStrXptr(FP,f_GunSendStrPtr2,"\x0D\x0D\x0Df_GunSend2".._0D)
			f_GetStrXptr(FP,HiddenModeStrPtr,"HD".._0D)
			--table.insert(CtrigInitArr[FP],SetCtrigX(FP,CC_Header[2],0x15C,0,SetTo,FP,EXCC_Forward,0x15C,1,2))--{"X",EXCC_Forward,0x15C,1,2}--CC_Header
			--table.insert(CtrigInitArr[FP],SetCtrigX(FP,G_InputH[2],0x15C,0,SetTo,FP,0x500,0x15C,1,0))--{"X",0x500,0x15C,1,0}--G_InputH
	
			f_GetStrXptr(FP,MinGachaPStrPtr,"\x0D\x0D\x0DMGaP".._0D)
			f_GetStrXptr(FP,MinGachaMStrPtr,"\x0D\x0D\x0DMGaM".._0D)
			
			f_Memcpy(FP,MinGachaPStrPtr,_TMem(Arr(MGPStr1[3],0),"X","X",1),MGPStr1[2])
			f_Memcpy(FP,_Add(MinGachaPStrPtr,MGPStr1[2]+0x40),_TMem(Arr(MGPStr2[3],0),"X","X",1),MGPStr2[2])
			f_Memcpy(FP,MinGachaMStrPtr,_TMem(Arr(MGPStr1[3],0),"X","X",1),MGPStr1[2])
			f_Memcpy(FP,_Add(MinGachaMStrPtr,MGPStr1[2]+0x40),_TMem(Arr(MGPStr3[3],0),"X","X",1),MGPStr3[2])
			
			
			
	
			f_GetStrXptr(FP,HeroTxtStrPtr,"\x0D\x0D\x0DHK".._0D)
			f_Memcpy(FP,HeroTxtStrPtr,_TMem(Arr(Str19[3],0),"X","X",1),Str19[2])
			
			f_Memcpy(FP,_Add(HeroTxtStrPtr,Str19[2]+0x40),_TMem(Arr(Str20[3],0),"X","X",1),Str20[2])
			
			f_Memcpy(FP,_Add(HeroTxtStrPtr,Str19[2]+0x40+Str20[2]+16),_TMem(Arr(Str21[3],0),"X","X",1),Str21[2])
			f_Memcpy(FP,UPCompStrPtr,_TMem(Arr(Str12[3],0),"X","X",1),Str12[2])
			--f_Memcpy(FP,_Add(UPCompStrPtr,Str12[2]-3),_TMem(Arr(UpCompTxt,0),"X","X",1),5*4)
			f_Memcpy(FP,_Add(UPCompStrPtr,Str12[2]+20),_TMem(Arr(Str22[3],0),"X","X",1),Str22[2])
			--f_Memcpy(FP,_Add(UPCompStrPtr,Str12[2]-3+20+Str22[2]-3),_TMem(Arr(UpCompRet,0),"X","X",1),5*4)
			f_Memcpy(FP,_Add(UPCompStrPtr,Str12[2]+20+Str22[2]-3+20),_TMem(Arr(Str23[3],0),"X","X",1),Str23[2])

			for i = 0, 6 do
				ItoName(FP,i,VArr(Names[i+1],0),ColorCode[i+1])
				_0DPatchforVArr(FP,Names[i+1],6)
				f_GetStrXptr(FP,NMStrPtr[i+1],"\x0D\x0D\x0D"..ColorCode[i+1].."NM".._0D)
				f_GetStrXptr(FP,HMStrPtr[i+1],"\x0D\x0D\x0D"..ColorCode[i+1].."HM".._0D)
				f_GetStrXptr(FP,GMStrPtr[i+1],"\x0D\x0D\x0D"..ColorCode[i+1].."GM".._0D)
				f_GetStrXptr(FP,NBStrPtr[i+1],"\x0D\x0D\x0D"..ColorCode[i+1].."NB".._0D)
				f_GetStrXptr(FP,SVStrPtr[i+1],"\x0D\x0D\x0D"..ColorCode[i+1].."SV".._0D)
				f_GetStrXptr(FP,TRStrPtr[i+1],"\x0D\x0D\x0D"..ColorCode[i+1].."TR".._0D)
				f_GetStrXptr(FP,SNStrPtr[i+1],"\x0D\x0D\x0D"..ColorCode[i+1].."SN".._0D)
				f_GetStrXptr(FP,QSStrPtr[i+1],"\x0D\x0D\x0D"..ColorCode[i+1].."QS".._0D)
				Install_CText1(NMStrPtr[i+1],Str00,Str01,Names[i+1])
				Install_CText1(HMStrPtr[i+1],Str00,Str02,Names[i+1])
				Install_CText1(GMStrPtr[i+1],Str00,Str03,Names[i+1])
				Install_CText1(NBStrPtr[i+1],Str00,Str04,Names[i+1])
				Install_CText1(SVStrPtr[i+1],Str00,Str05,Names[i+1])
				Install_CText1(TRStrPtr[i+1],Str00,TeText,Names[i+1])
				Install_CText1(SNStrPtr[i+1],Str00,SuText,Names[i+1])
				Install_CText1(QSStrPtr[i+1],Str00,QuaText,Names[i+1])
			end
			G_init()
			table.insert(PatchArr,ModifyUnitHitPoints(All,125,AllPlayers,64,100))
			table.insert(PatchArrPrsv,SetMemoryW(0x660B68 + (125 *2),SetTo,271)) -- 8벙
			DoActions2(FP,PatchArr)
			tblAdrrArr = CreateArr(227,FP)
			for i = 0, 227 do
				
				f_GetTblptr(FP,Arr(tblAdrrArr,i),i+1)
			end
			UTbl_27 = CreateCText(FP,"\x04쥬림 \x11거대 \x06골렘")
			UTbl_61 = CreateCText(FP,"\x04쥬림 \x06산맥의 \x11수호자")
			UTbl_68 = CreateCText(FP,"\x07쥬림 \x06산맥의 \x11왕")
			CMov(FP,CurrentUID,0)
			CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227)) --  모든 유닛의 스패셜 어빌리티 플래그 설정

			local tblAdrr = CreateVar(FP)
			local tblAdrrPtr = CreateVar(FP)
			local CurUNamePtr = CreateVar(FP)
			local CurUNameEPD = CreateVar(FP)
			CAdd(FP,CurUNamePtr,_Mul(CurrentUID,0x40),UnitNamePtr)
			CMov(FP,CurUNameEPD,_EPD(CurUNamePtr))
			ConvertArr(FP,tblAdrrPtr,CurrentUID)
			CMov(FP,tblAdrr,_ReadF(ArrX(tblAdrrArr,tblAdrrPtr)))
			CIfX(FP,CV(CurrentUID,27))
			f_Memcpy(FP,CurUNamePtr,_TMem(Arr(UTbl_27[3],0),"X","X",1),UTbl_27[2])
			CElseIfX(CV(CurrentUID,61))
			f_Memcpy(FP,CurUNamePtr,_TMem(Arr(UTbl_61[3],0),"X","X",1),UTbl_61[2])
			CElseIfX(CV(CurrentUID,68))
			f_Memcpy(FP,CurUNamePtr,_TMem(Arr(UTbl_68[3],0),"X","X",1),UTbl_68[2])
			CElseX()
			f_Memcpy(FP,CurUNamePtr,tblAdrr,0x40)
			CIfXEnd()
			local TblCheckCD = CreateCcode()
			DoActionsX(FP,{SetCD(TblCheckCD,0)})
			CFor(FP,0,16,1)
			Ci = CForVariable()
			for i = 0, 3 do
				CTrigger(FP,{TMemoryX(_Add(CurUNameEPD,Ci),Exactly,0,0xFF*(256^i))},{
					TSetMemoryX(_Add(CurUNameEPD,Ci),SetTo,0x0D*(256^i),0xFF*(256^i)),SetCD(TblCheckCD,1)
				},1)
				CTrigger(FP,{CD(TblCheckCD,1)},{
					TSetMemoryX(_Add(CurUNameEPD,Ci),SetTo,0x0D*(256^i),0xFF*(256^i))
				},1)
			end
			CForEnd()

			CAdd(FP,CurrentUID,1)
			CWhileEnd()
			CMov(FP,CurrentUID,0)
			CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227)) --  모든 유닛의 스패셜 어빌리티 플래그 설정

			TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,58)},{SetCVar(FP,CurrentUID[2],Add,1)},{preserved}) -- 아 발키리 좀 저리가요
			TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,nilunit)},{SetCVar(FP,CurrentUID[2],Add,1)},{preserved}) -- Cantina = nil
			TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,4)},{SetCVar(FP,CurrentUID[2],Add,1)},{preserved}) -- Unit Turret
			TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,6)},{SetCVar(FP,CurrentUID[2],Add,1)},{preserved}) -- Unit Turret
			TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,18)},{SetCVar(FP,CurrentUID[2],Add,1)},{preserved}) -- Unit Turret
			TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,24)},{SetCVar(FP,CurrentUID[2],Add,1)},{preserved}) -- Unit Turret
			TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,26)},{SetCVar(FP,CurrentUID[2],Add,1)},{preserved}) -- Unit Turret
			TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,31)},{SetCVar(FP,CurrentUID[2],Add,1)},{preserved}) -- Unit Turret
			CMov(FP,VRet,CurrentUID,EPD(0x664080)) -- SpecialAdvFlag
			CMov(FP,VRet2,CurrentUID,EPD(0x662860)) --BdDim
			ConvertArr(FP,ArrID,CurrentUID)
			CMov(FP,ArrX(BdDimArr,ArrID),_ReadF(VRet2))
			f_Read(FP,_Add(CurrentUID,EPD(0x662350)),ArrX(MaxHPBackUp,ArrID))
		
		
		
			f_Mod(FP,VRet3,CurrentUID,_Mov(2))
			f_Div(FP,VRet4,CurrentUID,_Mov(2))
		
			CTrigger(FP,{TDeathsX(VRet,Exactly,0x1,0,0x1)},{TSetDeaths(VRet2,SetTo,65537,0)},1) -- if Advanced Flags = Building then Building Dimensions SetTo 1x1
			CDoActions(FP,{TSetDeathsX(VRet,SetTo,0x200000,0,0x200000),}) -- All Unit SetTo Spellcaster
			CTrigger(FP,{CVar(FP,VRet3[2],Exactly,0)},{TSetDeathsX(_Add(VRet4,EPD(0x661518)),SetTo,0x1C7,0,0x1C7)},1) -- Set All Units StarEdit Av Flags
			CTrigger(FP,{CVar(FP,VRet3[2],Exactly,1)},{TSetDeathsX(_Add(VRet4,EPD(0x661518)),SetTo,0x1C7*0x10000,0,0x1C7*0x10000)},1) -- Set All Units StarEdit Av Flags
			CAdd(FP,CurrentUID,1)
			CWhileEnd()
			CMov(FP,CurrentUID,0)
		DoActions(FP,{KillUnit(35,FP)})
		CMov(FP,0x6509B0,19025+19)
		CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
			CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,Exactly,7,0,0xFF)})
				-- 유닛정보를 길이 8바이트의 데이터 배열에 저장함
				-- 0xYYYYXXXX 0xLLIIPPUU
				-- X = 좌표 X, Y = 좌표 Y, L = 유닛 식별자, I = 무적 플래그, P = 플레이어ID, U = 유닛ID

				JumpUnitsIndex = def_sIndex()
				JumpUID = {4,6,18,24,26,31,58,35}
				CAdd(FP,0x6509B0,6)
				for j,k in pairs(JumpUID) do
					NJumpX(FP,JumpUnitsIndex,DeathsX(CurrentPlayer,Exactly,k,0,0xFF))
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
					CVar(FP,RepHeroIndex[2],Exactly,168),
					CVar(FP,RepHeroIndex[2],Exactly,148),
					CVar(FP,RepHeroIndex[2],Exactly,131)})},{TSetCVar(FP,Gun_LV[2],SetTo,CunitHP)},1)
				CMov(FP,CunitIndex,_Div(_Sub(BackupCp,19025+19),_Mov(84)))
				CMovX(FP,FArr(UnitDataVoid[1],UnitDataPtr),CPos) 
				CMovX(FP,FArr(UnitDataVoid[2],UnitDataPtr),RepHeroIndex,nil,0xFF) 
				CMovX(FP,FArr(UnitDataVoid[2],UnitDataPtr),_Mul(CunitP,_Mov(0x100)),nil,0xFF00) 
				CMovX(FP,FArr(UnitDataVoid[2],UnitDataPtr),_Mul(Gun_LV,_Mov(0x1000000)),nil,0xFF000000) 
				CIf(FP,{TMemoryX(_Add(BackupCp,36),Exactly,0x04000000,0x04000000)})
				CMovX(FP,FArr(UnitDataVoid[2],UnitDataPtr),1*65536,nil,0x10000) 
				CIfEnd()
				--CDoActions(FP,{
				--	--TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(CC_Header,((0x20*8)/4))),SetTo,1),
				--	TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),CC_Header),SetTo,Gun_LV)})
				CAdd(FP,UnitDataPtr,1)
				f_LoadCp()
				CAdd(FP,0x6509B0,6)
				NJumpXEnd(FP,JumpUnitsIndex)
				CSub(FP,0x6509B0,6)
			CIfEnd()
			CAdd(FP,0x6509B0,84)
		CWhileEnd()
		CMov(FP,0x6509B0,FP)
	
		CMov(FP,CurrentUID,0)
		CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227))
			JumpUnitsIndex = def_sIndex()
			for j,k in pairs(JumpUID) do
				NJumpX(FP,JumpUnitsIndex,CV(CurrentUID,k))
			end
			
			CDoActions(FP,{
				TModifyUnitEnergy(All,CurrentUID,P8,64,0),
				TRemoveUnit(CurrentUID,P8)})
			NJumpXEnd(FP,JumpUnitsIndex)
			CAdd(FP,CurrentUID,1)
		CWhileEnd()
		CDoActions(FP,{KillUnit(35,P8)})
		CIfEnd({SetMemory(0x6509B0,SetTo,FP),SetInvincibility(Disable, 176, P12, 64),SetInvincibility(Disable, 177, P12, 64),SetInvincibility(Disable, 178, P12, 64)}) -- OnPluginStart End
		CMov(FP,0x6509B0,FP)
	end
	
	function onInit_EUD2()
		CIfOnce(FP) -- 게임 시작 직전 실행됨. 게임설정 완료 후에 실행된다는 조건을 추가해야함
		--TestCheck = CreateVar(FP)
		--TestPush = CreateCcode()
		--TestT = CreateCcode()
		--CAdd(FP,_Ccode(FP,TestT),1)
		--for i = 0, 227 do
		--	TriggerX(FP,{CDeaths(FP,AtLeast,i*40,TestT)},{CopyCpAction({DisplayTextX("\x13\x04"..i.."번 유닛을 배치합니다.",4)},HumanPlayers,FP),SetCVar(FP,TestCheck[2],SetTo,i),SetCDeaths(FP,SetTo,1,TestPush)})
		--end
		--CIf(FP,CDeaths(FP,AtLeast,1,TestPush),SetCDeaths(FP,SetTo,0,TestPush))
		
		
		CMov(FP,UnitDataPtr,0)
		CallCFuncX(FP,f_ReplaceX)
		
		DoActions(P8,SetResources(Force1,SetTo,0,Gas),1)
		CMov(FP,CurrentUID,0)
		CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227))
			JumpUnitsIndex = def_sIndex()
			for j,k in pairs(JumpUID) do
				NJumpX(FP,JumpUnitsIndex,CV(CurrentUID,k))
			end
			CMov(FP,VRet2,CurrentUID,EPD(0x662860)) --BdDim
			ConvertArr(FP,ArrID,CurrentUID)
			CDoActions(FP,{TSetMemory(VRet2,SetTo,_ReadF(ArrX(BdDimArr,ArrID)))})
			NJumpXEnd(FP,JumpUnitsIndex)
			CAdd(FP,CurrentUID,1)
		CWhileEnd()
		DoActions(FP,{ModifyUnitHitPoints(All,10,FP,22,20)})
		CIfEnd()
	end
end
