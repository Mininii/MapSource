
function init()
	
	--Balance
	AtkFactor = 15
	DefFactor = 20
	SuFactor = 200
	MarCost = 10000
	GMCost = 30000
	NeCost = 30000
	TeCost = 50000
	SuCost = 500000
	HPointFactor = 20
	ExRate = 0
	EasyEx1P = 110
	HDEx1P = 120
	BurEx1P = 140
	GunLimit = 1450

	--System
	GiveRate2 = {1000, 5000, 10000, 50000,100000,500000}  
	SpeedV = {0x2A,0x24,0x20,0x1D,0x19,0x15,0x11,0xC,0x8,0x4,0x1}
	ColorCode = {0x08,0x0E,0x0F,0x10,0x11,0x15,0x16}
	HumanPlayers = {0,1,2,3,4,5,6,P9,P10,P11,P12}
	MapPlayers = {0,1,2,3,4,5,6}
	ObPlayers = {P9,P10,P11,P12}
	MedicTrig = {34,9,5,10}
	EXCC_Forward = 0x2FFF
	
	CC_Header = CreateVar(FP)
	ObEff = 84
	nilunit = 181
	ZergGndUArr = {51,53,54,48,104}
	HondonFlingyArr = {88,73,72,176,4,188,187,49,40,45,38,44,43,37,46,47,191,15,8,14,1,5,12,11,7,13,0,2,9,41,190,115,74,81,186}

	F12 =202
	ESC =199
	Tab =214

	Str12 = CreateCText(FP,"\x12\x07『 \x0d\x0d\x0d\x0d\x0d\x0d\x0d")
	Str22 = CreateCText(FP,"\x04 미네랄을 소비하여 총 \x0d\x0d\x0d\x0d\x0d\x0d")
	Str23 = CreateCText(FP,"\x04 \x04회 업그레이드를 완료하였습니다. \x07』\x0d\x0d\x0d\x0d\x0d\x0d")
	Str24 = CreateCText(FP,"\x07』\x0d\x0d\x0d\x0d\x0d\x0d")
	
	f_GunT = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: f_Gun Suspend 성공. f_Gun 실행자 : ")
	f_GunErrT = CreateCText(FP,"\x07『 \x08ERROR \x04: G_CAPlot Not Found. f_Gun 실행자 : ")
	f_GunFuncT = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: G_CAPlot Suspended. f_Gun 실행자 : ")
	f_GunSendT = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: f_GunSend 성공. f_Gun 실행자 : ")
	f_GunSendT2 = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: 성공한 f_GunSend의 EXCunit Number : ")
	f_GunSendErrT = CreateCText(FP,"\x07『 \x08ERROR \x04: G_CAPlot Send Failed. f_Gun 실행자 : ")
	f_RepeatErr = "\x07『 \x08ERROR : \x04f_Repeat에서 문제가 발생했습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
	f_RepeatErr2 = "\x07『 \x08ERROR : \x04Set_Repeat에서 잘못된 UnitID(0)을 입력받았습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
	G_SendErrT = "\x07『 \x08ERROR : \x04f_Gun의 목록이 가득 차 G_Send를 실행할 수 없습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
	f_ReplaceErrT = "\x07『 \x08ERROR : \x04캔낫으로 인해 f_Replace를 실행할 수 없습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
	f_RepeatTypeErr = "\x07『 \x08ERROR : \x04잘못된 RepeatType이 입력되었습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
	

	_0D = string.rep("\x0D",200) 
	HTextStr = _0D
	GiveUnitID = {64,65,66,67,61,63,68}
	BanToken = {84,69,70,60,71,98}
	XSpeed = {"\x15#X0.5","\x05#X1.0","\x0E#X1.5","\x0F#X2.0","\x18#X2.5","\x10#X3.0","\x11#X3.5","\x08#X4.0","\x1C#X4.5","\x1F#X5.0","\x08#X_MAX"}
	PlayerString = {"\x08P1","\x0EP2","\x0FP3","\x10P4","\x11P5","\x15P6","\x16P7"} 
	P = {"\x081인","\x0E2인","\x0F3인","\x104인","\x115인","\x156인","\x167인"}
	P8VOFF = "Turn OFF Shared Vision for Player 8"
	P8VON = "Turn ON Shared Vision for Player 8"
	JYD = "Set Unit Order To: Junk Yard Dog" 
	DelayMedicT = {
		"\x1E▶ \x1D예약메딕\x04을 \x1B2Tick\x04으로 변경합니다. - \x1F300 Ore\x1E ◀",
		"\x1E▶ \x1D예약메딕\x04을 \x1B3Tick\x04으로 변경합니다. - \x1F350 Ore\x1E ◀",
		"\x1E▶ \x1D예약메딕\x04을 \x1B4Tick\x04으로 변경합니다. - \x1F400 Ore\x1E ◀",
		"\x1E▶ \x1D예약메딕\x04을 \x1B비활성화(1Tick)\x04하였습니다. - \x1F250 Ore\x1E ◀"}

	GiveRateT = {"\x07『 \x04기부금액 단위가 \x1F5000 Ore\x04 \x04로 변경되었습니다.\x07 』",
	"\x07『 \x04기부금액 단위가 \x1F10000 Ore \x04로 변경되었습니다.\x07 』",
	"\x07『 \x04기부금액 단위가 \x1F50000 Ore \x04로 변경되었습니다.\x07 』",
	"\x07『 \x04기부금액 단위가 \x1F100000 Ore \x04로 변경되었습니다.\x07 』",
	"\x07『 \x04기부금액 단위가 \x1F500000 Ore \x04로 변경되었습니다.\x07 』",
	"\x07『 \x04기부금액 단위가 \x1F1000 Ore \x04로 변경되었습니다.\x07 』"}

	--Gun_SVA = CreateSVArr(16,64,FP)
	--G_CA_SVA = CreateSVArr(16,64,FP)
	EXCunitTemp = CreateVarArr(10,FP)
	MaxHPBackUp = CreateArr(228,FP)
	BdDimArr = CreateArr(228,FP)
	f_GunNum = CreateVar(FP)
	Actived_Gun = CreateVar(FP)
	SoundLimitT = CreateCcode()
	SoundLimit = CreateCcode()
	TestMode = CreateCcode()
	BackupCp = CreateVar(FP)
	CPosX,CPosY,CPos = CreateVars(3,FP)
	count,count1,count2,count3 = CreateVars(4,FP)
	Gun_Type = CreateVar(FP)
	CurCunitI = CreateVar(FP)
	G_TempH = CreateVar(FP)
	G_TempW = CreateVar(FP)
	CunitP = CreateVar(FP)
	NextPtrs = CreateVar(FP)
	G_InputH = CreateVar(FP)
	CA2ArrX = CreateVArr(1700,FP)
	CA2ArrY = CreateVArr(1700,FP)
	CA2ArrZ = CreateVArr(10,FP)
	BanCode = CreateCcodeArr(6)
	DelayMedic = CreateCcodeArr(7)
	GiveRate = CreateCcodeArr(7)
	UnitDataPtr = EPDF(0x5967EC-(1700*4))
	--UnitDataPtrVoid = f_GetVoidptr(FP,1700*12)
    SpeedVar = CreateVar2(FP,nil,nil,4)
    CurrentSpeed = CreateVar(FP)
	ZergGndVArr = CreateVArray(FP,#ZergGndUArr)
	TempRandRet,InputMaxRand,Oprnd = CreateVars(3,FP)
	Gun_TempSpawnSet1,Repeat_TempV,RepeatType = CreateVars(3,FP)
	Var_InputCVar = {}
	Var_Lines = 55
	Var_TempTable = CreateVarArr(Var_Lines,FP)
	for i = 1, Var_Lines do
		table.insert(Var_InputCVar,SetCVar(FP,Var_TempTable[i][2],SetTo,0))
	end

	f_GunSendStrPtr,f_GunSendStrPtr2,G_CA_StrPtr,G_CA_StrPtr2,G_CA_StrPtr3,f_GunStrPtr,UPCompStrPtr = CreateVars(7,FP)
	
	RepHeroIndex,Gun_LV,CunitHP,CunitIndex = CreateVars(4,FP)

	local CurrentUID = CreateVar(FP)
	local VRet = CreateVar(FP)
	local VRet2 = CreateVar(FP)
	local VRet3 = CreateVar(FP)
	local VRet4 = CreateVar(FP)
	local ArrID = CreateVar(FP)
	function onInit_EUD()
		CIfOnce(FP)
		GiveT = {}
		for i = 6, 0, -1 do
			table.insert(GiveT,GiveUnits(1, 107, P12, 64, i))
			table.insert(GiveT,GiveUnits(1, 111, P12, 64, i))
		end
		table.insert(GiveT,Simple_SetLoc(0,3802,182,3802+1,182+1))
		for i = 0, 6 do
		table.insert(GiveT,GiveUnits(2, 125, P12, 1, i))
		table.insert(GiveT,Simple_CalcLoc(0,0,32,0,32))
		end
		DoActions(FP,GiveT)
		for i = 0, 6 do
		Trigger2(FP,{PlayerCheck(i,0)},{RemoveUnit(125,i),RemoveUnit(107,i),RemoveUnit(111,i)})
		end
	
		PatchArrPrsv = {}	
		PatchArr = {}

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
			for i = 34, 99 do
			EnermyNonBionic(i)
			end
			for i =0, 56 do
			SetTo0UnitDef(i)
			end
			
			for i = 37, 47 do
			ZergCreateSpeedPatch(i)
			end
			for i = 131, 149 do
			ZergCreateSpeedPatch(i)
			end
			
			for i = 1, 6 do
			UnitEnable(BanToken[i])
			end
			for i=1,7 do
			UnitEnable(GiveUnitID[i])
			end
			for i = 35,57 do
			ZergDefTypePatch(i)
			end
			for i = 131,152 do
			ZergDefTypePatch(i)
			end
			ZergDefTypePatch(59)
			ZergDefTypePatch(62)
			ZergDefTypePatch(103)
			ZergDefTypePatch(104)
			ZergDefTypePatch(186)
			UnitEnable(72)
			UnitEnable(83)
			UnitEnable(3)
			UnitEnable(8)
			UnitEnable(54)
			UnitEnable(53)
			UnitEnable(48)
			UnitEnable(52)
			UnitEnable(49)
			UnitEnable2(9)
			UnitEnable2(0)
			UnitEnable2(1)
			UnitEnable2(7)
			UnitEnable2(2)
			UnitEnable2(32)
			UnitEnable2(34)
			UnitEnable2(72)
			UnitEnable2(72)
			SetUnitClass(0)
			SetUnitClass(16)
			SetUnitClass(68)
			SetUnitClass(23)
			SetUnitClass(74)
			SetUnitClass(11)
			SetUnitClass(5)
			SetUnitClass(12)
			SetUnitClass(186)
			
			function UnitEnable3(UnitID,Tick)
				table.insert(PatchArrPrsv,SetMemoryW(0x660A70 + (UnitID *2),SetTo,5))
				table.insert(PatchArr,SetMemoryW(0x660428 + (UnitID *2),SetTo,Tick))
				table.insert(PatchArr,SetMemoryB(0x57F27C + (7 * 228) + UnitID,SetTo,0))
				table.insert(PatchArr,SetMemoryB(0x663CE8 + UnitID,SetTo,0))
			end
			function SetUnitCost(UnitID,Cost)
				table.insert(PatchArr,SetMemoryW(0x65FD00+(UnitID*2), SetTo, 0))
				table.insert(PatchArr,SetMemoryW(0x663888+(UnitID*2), SetTo, Cost))
				end
			for i = 1, 4 do
				UnitEnable3(MedicTrig[i],i)
				SetUnitCost(MedicTrig[i],200+(i*50))
			end

			table.insert(PatchArr,SetMemoryX(0x6638C8, SetTo, MarCost,0xFFFF))
			table.insert(PatchArr,SetMemoryX(0x66388C, SetTo, MarCost+GMCost,0xFFFF))
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
				table.insert(HondonPatchArr, SetMemory(0x6C9EF8 + (FlingyID*4),SetTo,18000))
			end
			
			
			
			HondonPatch(75)
			HondonPatch(82)
			HondonPatch(70) -- 배틀
			HondonPatch(80)
			for j, k in pairs(HondonFlingyArr) do
				HondonPatch(k)
			end
			
			for i = 37,57 do
			unitSizePatch(i,3)
			end
			for i = 60,81 do
			unitSizePatch(i,5)
			end
			unitSizePatch(103,5)
			unitSizePatch(3,5)
			unitSizePatch(5,1)
			unitSizePatch(10,5)
			unitSizePatch(15,5)
			unitSizePatch(17,5)
			unitSizePatch(19,5)
			unitSizePatch(25,5)
			unitSizePatch(32,4)
			unitSizePatch(87,5)
			unitSizePatch(89,5)
			
			Trigger { -- 퍼센트 데미지 세팅, 버튼셋
				players = {FP},
				actions = {
					SetMemory(0x515B88,SetTo,256);---------크기 0
					SetMemory(0x515B8C,SetTo,256);---------크기 1
					SetMemory(0x515B90,SetTo,256);---------크기 2
					SetMemory(0x515B94,SetTo,256);---------크기 3
					SetMemory(0x515B98,SetTo,256);---------크기 4
					SetMemory(0x515B9C,SetTo,256);---------크기 5
					SetMemory(0x515BA0,SetTo,256);---------크기 6
					SetMemory(0x515BA4,SetTo,256);---------크기 7
					SetMemory(0x515BA8,SetTo,256);---------크기 8
					SetMemory(0x515BAC,SetTo,256);---------크기 9
					SetMemory(0x515BB0,SetTo,256);
					SetMemory(0x515BB4,SetTo,256);
					SetMemory(0x515BB8,SetTo,256+256);
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
				table.insert(CtrigInitArr[FP],SetVArrayX(VArr(ZergGndVArr,i-1),"Value",SetTo,ZergGndUArr[i]))
			end
--			for i = 0, 6 do
--				table.insert(PatchArr,SetMemory(0x5821A4 + (4*i),SetTo,GunLimit*2))
--				table.insert(PatchArr,SetMemory(0x582144 + (4*i),SetTo,GunLimit*2))
--			end
			if TestStart == 1 then
				DoActionsX(FP,{SetCDeaths(FP,SetTo,1,TestMode),RotatePlayer({RunAIScript(P8VON)},MapPlayers,FP)})
			end
			f_GetStrXptr(FP,UPCompStrPtr,"\x0D\x0D\x0DUPC".._0D)
			f_GetStrXptr(FP,f_GunStrPtr,"\x0D\x0D\x0Df_Gun".._0D)
			f_GetStrXptr(FP,G_CA_StrPtr,"\x0D\x0D\x0DG_CA_Err".._0D)
			f_GetStrXptr(FP,G_CA_StrPtr2,"\x0D\x0D\x0DG_CA_Func".._0D)
			f_GetStrXptr(FP,G_CA_StrPtr3,"\x0D\x0D\x0DG_CA_SendError".._0D)
			f_GetStrXptr(FP,f_GunSendStrPtr,"\x0D\x0D\x0Df_GunSend".._0D)
			f_GetStrXptr(FP,f_GunSendStrPtr2,"\x0D\x0D\x0Df_GunSend2".._0D)
			table.insert(CtrigInitArr[FP],SetCtrigX(FP,CC_Header[2],0x15C,0,SetTo,FP,EXCC_Forward,0x15C,1,2))--{"X",EXCC_Forward,0x15C,1,2}--CC_Header
			table.insert(CtrigInitArr[FP],SetCtrigX(FP,G_InputH[2],0x15C,0,SetTo,FP,0x500,0x15C,1,0))--{"X",0x500,0x15C,1,0}--G_InputH
	
			
			
	
			--TMem(FP,UnitDataPtr,UnitDataPtrVoid)
			f_Memcpy(FP,UPCompStrPtr,_TMem(Arr(Str12[3],0),"X","X",1),Str12[2])
			--f_Memcpy(FP,_Add(UPCompStrPtr,Str12[2]-3),_TMem(Arr(UpCompTxt,0),"X","X",1),5*4)
			f_Memcpy(FP,_Add(UPCompStrPtr,Str12[2]+20),_TMem(Arr(Str22[3],0),"X","X",1),Str22[2])
			--f_Memcpy(FP,_Add(UPCompStrPtr,Str12[2]-3+20+Str22[2]-3),_TMem(Arr(UpCompRet,0),"X","X",1),5*4)
			f_Memcpy(FP,_Add(UPCompStrPtr,Str12[2]+20+Str22[2]-3+20),_TMem(Arr(Str23[3],0),"X","X",1),Str23[2])
		
			f_Memcpy(FP,f_GunStrPtr,_TMem(Arr(f_GunT[3],0),"X","X",1),f_GunT[2])
			f_Memcpy(FP,G_CA_StrPtr,_TMem(Arr(f_GunErrT[3],0),"X","X",1),f_GunErrT[2])
			f_Memcpy(FP,G_CA_StrPtr2,_TMem(Arr(f_GunFuncT[3],0),"X","X",1),f_GunFuncT[2])
			f_Memcpy(FP,f_GunSendStrPtr,_TMem(Arr(f_GunSendT[3],0),"X","X",1),f_GunSendT[2])
			f_Memcpy(FP,f_GunSendStrPtr2,_TMem(Arr(f_GunSendT2[3],0),"X","X",1),f_GunSendT2[2])
			f_Memcpy(FP,G_CA_StrPtr3,_TMem(Arr(f_GunSendErrT[3],0),"X","X",1),f_GunSendErrT[2])
		
			f_Memcpy(FP,_Add(f_GunStrPtr,f_GunT[2]+20),_TMem(Arr(Str24[3],0),"X","X",1),Str24[2])
			DoActions2(FP,PatchArr)

	
			
			
			--TMem(FP,UnitDataPtr,UnitDataPtrVoid)
			CMov(FP,CurrentUID,0)
			CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227)) --  모든 유닛의 스패셜 어빌리티 플래그 설정
			TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,58)},{SetCVar(FP,CurrentUID[2],Add,1)},{Preserved}) -- 아 발키리 좀 저리가요
			TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,nilunit)},{SetCVar(FP,CurrentUID[2],Add,1)},{Preserved}) -- Cantina = nil
			TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,4)},{SetCVar(FP,CurrentUID[2],Add,1)},{Preserved}) -- Unit Turret
			TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,6)},{SetCVar(FP,CurrentUID[2],Add,1)},{Preserved}) -- Unit Turret
			TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,18)},{SetCVar(FP,CurrentUID[2],Add,1)},{Preserved}) -- Unit Turret
			TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,24)},{SetCVar(FP,CurrentUID[2],Add,1)},{Preserved}) -- Unit Turret
			TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,26)},{SetCVar(FP,CurrentUID[2],Add,1)},{Preserved}) -- Unit Turret
			TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,31)},{SetCVar(FP,CurrentUID[2],Add,1)},{Preserved}) -- Unit Turret
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
			
		CMov(FP,0x6509B0,19025+19)
		CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
			CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,Exactly,7,0,0xFF)})
				-- 유닛정보를 길이 8바이트의 데이터 배열에 저장함
				-- 0xYYYYXXXX 0xLLIIPPUU
				-- X = 좌표 X, Y = 좌표 Y, L = 유닛 식별자, I = 무적 플래그, P = 플레이어ID, U = 유닛ID
				f_SaveCp()
				CIf(FP,{TTOR({
					TTMemory(_Add(BackupCp,6),NotSame,4),
					TTMemory(_Add(BackupCp,6),NotSame,6),
					TTMemory(_Add(BackupCp,6),NotSame,18),
					TTMemory(_Add(BackupCp,6),NotSame,24),
					TTMemory(_Add(BackupCp,6),NotSame,26),
					TTMemory(_Add(BackupCp,6),NotSame,31),
					TTMemory(_Add(BackupCp,6),NotSame,58),
					TTMemory(_Add(BackupCp,6),NotSame,35)})}) -- 일부 제외 유닛
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
					--	--TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(CC_Header,((0x20*8)/4))),SetTo,1),
					--	TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),CC_Header),SetTo,Gun_LV)})
				CIfEnd()
				f_LoadCp()
			CIfEnd()
			CAdd(FP,0x6509B0,84)
		CWhileEnd()
		CMov(FP,0x6509B0,FP)
	
		CMov(FP,CurrentUID,0)
		CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227))
		TriggerX(FP,{TTOR({TTMemory(_Add(BackupCp,6),NotSame,58),TTMemory(_Add(BackupCp,6),NotSame,nilunit)})},{SetCVar(FP,CurrentUID[2],Add,1)},{Preserved}) -- 발키리 나가
		CDoActions(FP,{
			TModifyUnitEnergy(All,CurrentUID,P8,64,0),
			TRemoveUnit(CurrentUID,P8)})
		CAdd(FP,CurrentUID,1)
		CWhileEnd()
		CDoActions(FP,{KillUnit(35,P8)})
		CIfEnd(SetMemory(0x6509B0,SetTo,FP)) -- OnPluginStart End
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
		CMov(FP,0x6509B0,UnitDataPtr)
		CWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0)) -- 배열에서 데이터가 발견되지 않을때까지 순환한다.
			f_SaveCp()
		--	CIf(FP,{TDeathsX(_Add(BackupCP,1),Exactly,TestCheck,0,0xFF)})
			CallTrigger(FP,f_Replace)-- 데이터화 한 유닛 재배치하는 코드
		--	CIfEnd()
			CAdd(FP,0x6509B0,2)
		CWhileEnd()
		CMov(FP,0x6509B0,FP)
		--CIfEnd()
		DoActions(P8,SetResources(Force1,SetTo,0,Gas),1)
		if TestStart == 1 then
			DoActions(P8,SetResources(Force1,SetTo,0x66666666,Ore),1)
		end
		CMov(FP,CurrentUID,0)
		CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227))
		TriggerX(FP,{TTOR({TTMemory(_Add(BackupCp,6),NotSame,58),TTMemory(_Add(BackupCp,6),NotSame,nilunit)})},{SetCVar(FP,CurrentUID[2],Add,1)},{Preserved}) -- 발키리 나가
		CMov(FP,VRet2,CurrentUID,EPD(0x662860)) --BdDim
		ConvertArr(FP,ArrID,CurrentUID)
		CDoActions(FP,{TSetMemory(VRet2,SetTo,_ReadF(ArrX(BdDimArr,ArrID)))})
		CAdd(FP,CurrentUID,1)
		CWhileEnd()
		
		CIfEnd()
	end
end
