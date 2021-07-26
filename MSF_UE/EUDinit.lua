
PatchArr = {}
PatchArrPrsv = {}
CTrigPatchTable = {}
function SetToUnitDef(UnitID,Value)
table.insert(PatchArr,SetMemoryB(0x65FEC8 + UnitID,SetTo,Value))
end

function UnitSizePatch(UnitID,Value)
table.insert(PatchArr,SetMemory(0x6617C8 + (UnitID*8),SetTo,(Value)+(Value*65536)))
table.insert(PatchArr,SetMemory(0x6617CC + (UnitID*8),SetTo,(Value)+(Value*65536)))
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

function UnitEnable(UnitID)
table.insert(PatchArrPrsv,SetMemoryW(0x660A70 + (UnitID *2),SetTo,5))
table.insert(PatchArr,SetMemoryB(0x57F27C + (7 * 228) + UnitID,SetTo,0))
table.insert(PatchArr,SetMemoryW(0x65FD00 + (UnitID *2),SetTo,0))
table.insert(PatchArr,SetMemoryW(0x663888 + (UnitID *2),SetTo,0))
table.insert(PatchArr,SetMemoryW(0x660428 + (UnitID *2),SetTo,1))
table.insert(PatchArr,SetMemoryB(0x663CE8 + UnitID,SetTo,0))
end
function UnitEnable2(UnitID)
table.insert(PatchArrPrsv,SetMemoryW(0x660A70 + (UnitID *2),SetTo,5))
table.insert(PatchArr,SetMemoryB(0x57F27C + (7 * 228) + UnitID,SetTo,0))
table.insert(PatchArr,SetMemoryB(0x663CE8 + UnitID,SetTo,0))
end

function UnitEnable3(UnitID,Tick)
table.insert(PatchArrPrsv,SetMemoryW(0x660A70 + (UnitID *2),SetTo,5))
table.insert(PatchArr,SetMemoryW(0x660428 + (UnitID *2),SetTo,Tick))
table.insert(PatchArr,SetMemoryB(0x57F27C + (7 * 228) + UnitID,SetTo,0))
table.insert(PatchArr,SetMemoryB(0x663CE8 + UnitID,SetTo,0))
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
table.insert(PatchArr,SetMemoryW(0x663C10+(UnitID*2), SetTo, 415))
table.insert(PatchArr,SetMemoryW(0x661440+(UnitID*2), SetTo, 418))
table.insert(PatchArr,SetMemoryW(0x65FFB0+(UnitID*2), SetTo, 411))
table.insert(PatchArr,SetMemoryW(0x662BF0+(UnitID*2), SetTo, 414))
table.insert(PatchArr,SetMemoryW(0x663B38+(UnitID*2), SetTo, 407))
table.insert(PatchArr,SetMemoryW(0x661EE8+(UnitID*2), SetTo, 410))
table.insert(PatchArr,SetMemoryB(0x6644F8 + UnitID, SetTo, 78))
table.insert(PatchArr,SetMemoryW(0x662F88+(UnitID*2), SetTo, 13))
end

function SetUnitClassType(UnitID,Type)
	if Type == 1 then 
		Class = 198
	else
		Class = 197
	end
	table.insert(PatchArr,SetMemoryB(0x6637A0 + UnitID,SetTo,0x02+0x08))
	table.insert(PatchArr,SetMemoryB(0x663DD0 + UnitID,SetTo,Class))
end

function onInit_EUD()
	local LimitX, LimitC = CreateCCodes(2)
	local ShTStrPtr = Create_VTable(7)
	CIfOnce(FP,nil,{SetCVar(FP,CurrentSpeed[2],SetTo,4),SeTMemory(0x5124F0,SetTo,SpeedV[4])}) -- OnPluginStart
	f_Read(FP,0x58F500,"X",SelHPEPD) -- 플립에서 전송받은 플립 변수 주소를 V에 입력
	f_Read(FP,0x58F504,"X",MarHPEPD) -- 플립에서 전송받은 플립 변수 주소를 V에 입력
	f_Read(FP,0x58F508,"X",SelShEPD) -- 플립에서 전송받은 플립 변수 주소를 V에 입력
	f_Read(FP,0x58F50C,"X",SelOPEPD) -- 플립에서 전송받은 플립 변수 주소를 V에 입력
	f_Read(FP,0x58F510,"X",UnitDataPtr) -- 플립에서 전송받은 플립 변수 주소를 V에 입력
	f_Read(FP,0x58F528,"X",B_5_C) -- 플립에서 전송받은 플립 변수 주소를 V에 입력
	f_Read(FP,0x58F532,"X",XY_ArrHeader) -- 플립에서 전송받은 플립 변수 주소를 V에 입력
	f_Read(FP,0x58F55C,"X",B_Id_C) -- 플립에서 전송받은 플립 변수 주소를 V에 입력
	
	for i = 1, #HeroArr do
		table.insert(CTrigPatchTable,SetVArrayX(VArr(HeroVArr,i-1),"Value",SetTo,HeroArr[i]))
	end
	for i = 1, #ZergGndUArr do
		table.insert(CTrigPatchTable,SetVArrayX(VArr(ZergGndVArr,i-1),"Value",SetTo,ZergGndUArr[i]))
	end

	DoActionsX(FP,CTrigPatchTable,1)
	local VRet = CreateVar(FP)
	local VRet2 = CreateVar(FP)
	local VRet3 = CreateVar(FP)
	local VRet4 = CreateVar(FP)
	local CurrentUID = CreateVar(FP)
	CMov(FP,CurrentUID,0)
	CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227)) --  모든 유닛의 스패셜 어빌리티 플래그 설정
	TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,58)},{SetCVar(FP,CurrentUID[2],Add,1)},{Preserved}) -- 아 발키리 좀 저리가요
	TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,181)},{SetCVar(FP,CurrentUID[2],Add,1)},{Preserved}) -- Cantina = nil
	CMov(FP,VRet,CurrentUID,EPD(0x664080))
	CMov(FP,VRet2,CurrentUID,EPD(0x662860))

	f_Read(FP,_Add(CurrentUID,EPD(0x662350)),VArr(MaxHPBackUp,CurrentUID))


	f_Mod(FP,VRet3,CurrentUID,_Mov(2))
	f_Div(FP,VRet4,CurrentUID,_Mov(2))

	CTrigger(FP,{TDeathsX(VRet,Exactly,0x1,0,0x1)},{TSetDeaths(VRet2,SetTo,65537,0)},1) -- if Advanced Flags = Building then Building Dimensions SetTo 1x1
	CDoActions(FP,{TSetDeathsX(VRet,SetTo,0x200000,0,0x200000),}) -- All Unit SetTo Spellcaster
	CTrigger(FP,{CVar(FP,VRet3[2],Exactly,0)},{TSetDeathsX(_Add(VRet4,EPD(0x661518)),SetTo,0x1C7,0,0x1C7)},1) -- Set All Units StarEdit Av Flags
	CTrigger(FP,{CVar(FP,VRet3[2],Exactly,1)},{TSetDeathsX(_Add(VRet4,EPD(0x661518)),SetTo,0x1C7*0x10000,0,0x1C7*0x10000)},1) -- Set All Units StarEdit Av Flags
	CAdd(FP,CurrentUID,1)
	CWhileEnd()
	CMov(FP,CurrentUID,0)

	for i = 0, 227 do
	SetUnitDefUpType(i,60) -- 방업 적용 방지
	SetToUnitDef(i,0) -- 방어력 전부 0으로 설정 
	DefTypePatch(i,7) -- 방어타입 전부 7로 설정
	SetUnitAdvFlag(i,0,0x4000) -- 모든유닛 어드밴스드 플래그 중 로보틱 전부제거
	end
	UnitEnable2(71)
	UnitEnable2(19)

	for i = 0, 129 do
	WeaponTypePatch(i,0) -- 무기 타입 전부 0으로 설정(방갈림 방지)
	end
	WeaponTypePatch(5,2) -- 무기 타입 퍼딜
	WeaponTypePatch(21,2) -- 무기 타입 퍼딜
	WeaponTypePatch(100,2) -- 무기 타입 퍼딜
	WeaponTypePatch(85,2) -- 무기 타입 퍼딜
	WeaponTypePatch(68,2) -- 무기 타입 퍼딜
	WeaponTypePatch(70,2) -- 무기 타입 퍼딜
	WeaponTypePatch(124,2) -- 무기 타입 퍼딜
	WeaponTypePatch(89,2) -- 무기 타입 퍼딜
	WeaponTypePatch(6,2) -- 무기 타입 퍼딜
	WeaponTypePatch(126,2) -- 무기 타입 퍼딜
	WeaponTypePatch(127,2) -- 무기 타입 퍼딜
	WeaponTypePatch(86,2) -- 무기 타입 퍼딜
	WeaponTypePatch(110,2) -- 무기 타입 퍼딜
	WeaponTypePatch(128,2) -- 무기 타입 퍼딜
	SetUnitClassType(19,1)
	SetUnitClassType(29,1)
	SetUnitClassType(98,1)
	SetUnitClassType(75,1)
	SetUnitClassType(87,1)
	SetUnitClassType(68,1)
	SetUnitClassType(84,1)
	SetUnitClassType(81,1)
	SetUnitClassType(23,1)
	SetUnitClassType(74,1)
	SetUnitClassType(74,1)
	SetUnitClassType(57,1)

	SetUnitClassType(47)
	SetUnitClassType(77)
	SetUnitClassType(78)
	SetUnitClassType(28)
	SetUnitClassType(17)
	SetUnitClassType(21)
	SetUnitClassType(27)
	SetUnitClassType(86)
	SetUnitClassType(88)
	SetUnitClassType(80)
	SetUnitClassType(25)
	SetUnitClassType(76)
	SetUnitClassType(79)
	SetUnitClassType(220)
	SetUnitClassType(150)
--roka7
function EffUnitPatch(UnitID)
	table.insert(PatchArr,SetMemoryB(0x6616E0 + UnitID,SetTo,130))
	table.insert(PatchArr,SetMemoryB(0x663238 + UnitID,SetTo,11)) -- 시야
	UnitSizePatch(UnitID,1)
end
EffUnitPatch(203)
EffUnitPatch(204)
EffUnitPatch(205)
EffUnitPatch(206)
EffUnitPatch(207)
EffUnitPatch(208)
EffUnitPatch(209)
EffUnitPatch(210)
EffUnitPatch(94)
UnitSizePatch(84,1)
UnitSizePatch(60,1)

-------
		table.insert(PatchArr,SetMemoryB(0x6564E0 + 21,SetTo,2))
	--0~6 공업용??
	--8~14 방업용??

		

	for i = 0, 6 do
	table.insert(PatchArr,SetMemoryW(0x655AC0 + (i*2),SetTo,288)) -- 아이콘
	table.insert(PatchArr,SetMemoryW(0x655A40 + (i*2),SetTo,418)) -- 이름
	table.insert(PatchArr,SetMemoryW(0x655700 + (i*2),SetTo,255)) -- 맥스레벨
	table.insert(PatchArr,SetMemoryW(0x655740 + (i*2),SetTo,0)) -- 미네랄베이스
	table.insert(PatchArr,SetMemoryW(0x6557C0 + (i*2),SetTo,0)) -- 가스증가량 
	table.insert(PatchArr,SetMemoryW(0x655840 + (i*2),SetTo,0)) -- 가스베이스
	table.insert(PatchArr,SetMemoryW(0x655940 + (i*2),SetTo,0)) -- 시간증가량
	table.insert(PatchArr,SetMemoryW(0x655B80 + (i*2),SetTo,0)) -- 시간베이스
	table.insert(PatchArr,SetMemoryW(0x6559C0 + (i*2),SetTo,AtkFactor)) -- 미네랄 증가량 중요함 
	table.insert(PatchArr,SetMemoryB(0x655BFC + (i),SetTo,1)) -- 종족(1바이트)

	table.insert(PatchArr,SetMemoryW(0x655AC0 + ((8+i)*2),SetTo,377)) -- 아이콘
	table.insert(PatchArr,SetMemoryW(0x655A40 + ((8+i)*2),SetTo,426)) -- 이름
	table.insert(PatchArr,SetMemoryW(0x655700 + ((8+i)*2),SetTo,255)) -- 맥스레벨
	table.insert(PatchArr,SetMemoryW(0x655740 + ((8+i)*2),SetTo,0)) -- 미네랄베이스
	table.insert(PatchArr,SetMemoryW(0x6557C0 + ((8+i)*2),SetTo,0)) -- 가스증가량 
	table.insert(PatchArr,SetMemoryW(0x655840 + ((8+i)*2),SetTo,0)) -- 가스베이스
	table.insert(PatchArr,SetMemoryW(0x655940 + ((8+i)*2),SetTo,0)) -- 시간증가량
	table.insert(PatchArr,SetMemoryW(0x655B80 + ((8+i)*2),SetTo,0)) -- 시간베이스
	table.insert(PatchArr,SetMemoryW(0x6559C0 + ((8+i)*2),SetTo,DefFactor)) -- 미네랄 증가량 중요함 
	table.insert(PatchArr,SetMemoryB(0x655BFC + ((8+i)),SetTo,1)) -- 종족(1바이트)
	--table.insert(PatchArrPrsv,SetMemoryW(0x6558C0 + (i*2),SetTo,5)) --요구사항
	--table.insert(PatchArrPrsv,SetMemoryW(0x6558C0 + ((8+i)*2),SetTo,5)) --요구사항


	end

	table.insert(PatchArr,SetMemoryW(0x655AC0 + (17*2),SetTo,289)) -- 아이콘
	table.insert(PatchArr,SetMemoryW(0x655AC0 + (18*2),SetTo,290)) -- 아이콘
	table.insert(PatchArr,SetMemoryW(0x655AC0 + (19*2),SetTo,291)) -- 아이콘
	table.insert(PatchArr,SetMemoryW(0x655AC0 + (20*2),SetTo,293)) -- 아이콘
	table.insert(PatchArr,SetMemoryW(0x655A40 + (17*2),SetTo,419)) -- 이름
	table.insert(PatchArr,SetMemoryW(0x655A40 + (18*2),SetTo,420)) -- 이름
	table.insert(PatchArr,SetMemoryW(0x655A40 + (19*2),SetTo,413)) -- 이름
	table.insert(PatchArr,SetMemoryW(0x655A40 + (20*2),SetTo,412)) -- 이름
	for i = 17, 20 do
	table.insert(PatchArr,SetMemoryW(0x655700 + (i*2),SetTo,255)) -- 맥스레벨
	table.insert(PatchArr,SetMemoryW(0x655740 + (i*2),SetTo,0)) -- 미네랄베이스
	table.insert(PatchArr,SetMemoryW(0x6557C0 + (i*2),SetTo,0)) -- 가스증가량 
	table.insert(PatchArr,SetMemoryW(0x655840 + (i*2),SetTo,0)) -- 가스베이스
	table.insert(PatchArr,SetMemoryW(0x655940 + (i*2),SetTo,0)) -- 시간증가량
	table.insert(PatchArr,SetMemoryW(0x655B80 + (i*2),SetTo,0)) -- 시간베이스
	table.insert(PatchArr,SetMemoryW(0x6559C0 + (i*2),SetTo,0)) -- 미네랄 증가량 중요함 
	table.insert(PatchArr,SetMemoryB(0x655BFC + (i),SetTo,1)) -- 종족(1바이트)
	--table.insert(PatchArrPrsv,SetMemoryW(0x6558C0 + (i*2),SetTo,5)) --요구사항

	for j = 0, 6 do
	table.insert(PatchArr,SetMemoryB(0x58D088 + (j * 46) + i,SetTo,255))
	end
	end

	table.insert(PatchArr,SetMemoryB(0x6647B0 + (17), SetTo, 255))
	table.insert(PatchArr,SetMemoryB(0x6647B0 + (21), SetTo, 255))
	table.insert(PatchArr,SetMemoryB(0x6647B0 + (29), SetTo, 255))

	for i = 0, 6 do
	table.insert(PatchArr,SetMemory(0x5821A4 + (4*i),SetTo,GunLimit*2))
	table.insert(PatchArr,SetMemory(0x582144 + (4*i),SetTo,GunLimit*2))
	table.insert(PatchArr,SetMemory(0x5822C4 + (4*i),SetTo,1000))
	table.insert(PatchArr,SetMemory(0x582264 + (4*i),SetTo,1000))
	table.insert(PatchArr,SetMemoryB(0x6566F8 + (MarWep[i+1]),SetTo,3))
	table.insert(PatchArr,SetMemoryW(0x656888 + (MarWep[i+1]*2),SetTo,5))
	table.insert(PatchArr,SetMemoryW(0x6570C8 + (MarWep[i+1]*2),SetTo,15))
	table.insert(PatchArr,SetMemoryW(0x657780 + (MarWep[i+1]*2),SetTo,30))
	table.insert(PatchArr,SetMemoryB(0x58D088 + (i * 46) + i,SetTo,255))
	table.insert(PatchArr,SetMemoryB(0x58D088 + (i * 46) + i+8,SetTo,255))

		DefTypePatch(MarID[i+1],i) -- 마린의 방어타입을 P1부터 P7까지 차례대로 배분
		SetUnitClass(MarID[i+1],199) -- 마린 계급설정. 체력보이게 하기 위함
		SetShield(MarID[i+1]) -- 마린 쉴드 설정. 쉴드 활성화 + 쉴드 1000 설정
		UnitSizePatch(MarID[i+1],5) -- 마린 크기 5*5 설정
		UnitEnable2(MarID[i+1])
		SetUnitGrpToMarine(MarID[i+1]) -- 마린 그래픽 전부 마린으로 설정
		SetUnitAdvFlag(MarID[i+1],0x4000,0x4000) -- 플레이어 마린에 로보틱 부여

		SetWepTargetFlags(MarWep[i+1],0x020 + 1 + 2) -- 플레이어 마린 공격 비 로보틱 설정
		SetWepUpType(MarWep[i+1],0+i) -- 플레이어 마린무기에 각각 다른 공업 적용
		
		table.insert(PatchArr,SetMemoryW(0x656EB0 + (MarWep[i+1]*2),SetTo,MarDamageAmount)) -- 기본공격력
		table.insert(PatchArr,SetMemoryW(0x657678 + (MarWep[i+1]*2),SetTo,MarDamageFactor)) -- 추가공격력
		table.insert(PatchArr,SetMemoryB(0x6564E0 + MarWep[i+1],SetTo,2))
		table.insert(PatchArr,SetMemoryB(0x6616E0 + MarID[i+1],SetTo,MarWep[i+1])) -- 지상무기
		table.insert(PatchArr,SetMemoryB(0x6636B8 + MarID[i+1],SetTo,MarWep[i+1])) -- 공중무기
		table.insert(PatchArr,SetMemoryB(0x662DB8 + MarID[i+1],SetTo,6)) -- 부가사거리
		table.insert(PatchArr,SetMemoryB(0x663238 + MarID[i+1],SetTo,11)) -- 시야
		table.insert(PatchArr,SetMemory(0x657470 + (MarWep[i+1]*4) ,SetTo,192))
	end

		table.insert(PatchArr,SetMemoryB(0x6564E0,SetTo,2))
		table.insert(PatchArr,SetMemoryW(0x656EB0,SetTo,NMarDamageAmount)) -- 기본공격력
		table.insert(PatchArr,SetMemoryW(0x657678,SetTo,NMarDamageFactor)) -- 추가공격력

		UnitEnable2(15)
		UnitEnable2(12)
		UnitEnable2(7)
		UnitEnable2(1)
	for i = 1, 4 do
		UnitEnable3(MedicTrig[i],i)
		SetUnitCost(MedicTrig[i],200+(i*50))
	end
	UnitEnable(72)
	UnitEnable(22)
	UnitEnable(70)
	for i = 0, 6 do
		table.insert(PatchArr,SetMemoryB(0x663CE8 + MarID[i+1],SetTo,2))
	end
		table.insert(PatchArr,SetMemoryB(0x663CE8 + 12,SetTo,2))
		table.insert(PatchArr,SetMemoryB(0x663CE8 + 10,SetTo,2))
		table.insert(PatchArr,SetMemoryB(0x663CE8 + 15,SetTo,2))

	for i = 2, 116 do
	SetWepUpType(i,3)
	end

	UnitSizePatch(39,10) -- 저그 유닛 크기 10*10 설정
	UnitSizePatch(45,10) -- 저그 유닛 크기 10*10 설정
	UnitSizePatch(44,10) -- 저그 유닛 크기 10*10 설정
	UnitSizePatch(48,10) -- 저그 유닛 크기 10*10 설정
	UnitSizePatch(49,10) -- 저그 유닛 크기 10*10 설정
	UnitSizePatch(56,10) -- 저그 유닛 크기 10*10 설정
	UnitSizePatch(55,10) -- 저그 유닛 크기 10*10 설정
	UnitSizePatch(53,10) -- 저그 유닛 크기 10*10 설정
	UnitSizePatch(57,10) -- 저그 유닛 크기 10*10 설정
	UnitSizePatch(11,1)
	UnitSizePatch(63,5)

	for j, k in pairs(HeroArr) do
		if k ~= 86 then
		UnitSizePatch(k,10)
		end
	end

	for i = 220, 227 do
		DefTypePatch(i,9)
	end
		DefTypePatch(15,9)
		DefTypePatch(68,9)
		DefTypePatch(7,9)
		DefTypePatch(87,9)
		DefTypePatch(150,9)
		DefTypePatch(74,9)
		DefTypePatch(186,9)


	Trigger { -- 퍼센트 데미지 세팅
		players = {P8},
		actions = {
			SetMemory(0x515B88,SetTo,256);---------크기 0 일반형
			SetMemory(0x515B8C,SetTo,256);---------크기 1 일반형
			SetMemory(0x515B90,SetTo,256);---------크기 2 일반형
			SetMemory(0x515B94,SetTo,256);---------크기 3 일반형
			SetMemory(0x515B98,SetTo,256);---------크기 4 일반형
			SetMemory(0x515B9C,SetTo,256);---------크기 5 일반형
			SetMemory(0x515BA0,SetTo,256);---------크기 6 일반형
			SetMemory(0x515BA4,SetTo,256);---------크기 7 일반형
			SetMemory(0x515BA8,SetTo,256);---------크기 8 일반형
			SetMemory(0x515BAC,SetTo,0);---------크기 9 일반형 보너스 자원류 딜 무조건 1로 들어가게 설정할것. 
			SetMemory(0x515BB0,SetTo,256);---------크기 0 진동형 P1 익시드 마린
			SetMemory(0x515BB4,SetTo,256);---------크기 1 진동형 P2 익시드 마린
			SetMemory(0x515BB8,SetTo,256);---------크기 2 진동형 P3 익시드 마린
			SetMemory(0x515BBC,SetTo,256);---------크기 3 진동형 P4 익시드 마린
			SetMemory(0x515BC0,SetTo,256);---------크기 4 진동형 P5 익시드 마린
			SetMemory(0x515BC4,SetTo,256);---------크기 5 진동형 P6 익시드 마린
			SetMemory(0x515BC8,SetTo,256);---------크기 6 진동형 P7 익시드 마린
			SetMemory(0x515BCC,SetTo,256*2);---------크기 7 진동형 일반마린
			SetMemory(0x515BD0,SetTo,256*8);---------크기 8 진동형 벙커 터렛 등으로 쓸듯
			SetMemory(0x515BD4,SetTo,256);---------크기 9 진동형	SCV, 진동형 퍼뎀유닛한텐 죽음 ㅅㄱ
			SetMemoryX(0x581DAC,SetTo,128*65536,0xFF0000), --P8컬러f
			SetMemoryX(0x581DDC,SetTo,128*256,0xFF00); --P8 미니맵
		},
	}
	DoActions2(FP,PatchArr,1) -- 위에서 받은 테이블 정보를 한번에 쏘는것
	local SetPlayers = CreateVar(FP)
	for i = 0, 6 do
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			Command(i,AtLeast,1,111);
			},
		actions = {
			SetCVar(FP,SetPlayers[2],Add,1);
			}
	}
	end

	for k = 1, 7 do
		Trigger { -- 미션 오브젝트, 환전률 셋팅
			players = {Force1},
			conditions = {
				Label(0);
				CVar(FP,SetPlayers[2],Exactly,k);
			},
			actions = {
				SetMissionObjectives("\x13\x1F===================================\n\x13\n\x13\x04마린키우기 \x1FＵｍＬｉｍｉｔ ＥｘｃｅｅＤ\n\x13"..P[k].." \x07플레이중입니다. \x0F환전률 : \x04"..Ex1[k].."%\n\n\x13\x1F===================================");
				SetCVar(FP,ExchangeRate[2],SetTo,Ex1[k]);
				
			},
		}
	end
	
	DoActionsX(FP,{SetCDeaths(FP,SetTo,Limit,LimitX),SetCDeaths(FP,SetTo,TestStart,TestMode)}) -- Limit설정
	if TestStart == 1 then
		DoActions(FP,SetSwitch("Switch 230",Set))
	end

	for i = 0, 6 do -- 정버아닌데 플레이어중 해당하는 닉네임 없으면 겜튕김
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
			isname(i,"UnusedTypeGB");
			CDeaths(FP,AtLeast,1,LimitX);
		},
		actions = {
			SetCDeaths(FP,SetTo,1,LimitC);
			
		}
	}
	end

	YY = 2021
	MM = 7
	DD = 26
	HH = 00
	function PushErrorMsg(Message)
		_G["\n"..Message.."\n"]() 
	end
	
	GlobalTime = os.time{year=YY, month=MM, day=DD, hour=HH }
	--PushErrorMsg(GlobalTime)
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

	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,Exactly,1,LimitX);
			CDeaths(FP,Exactly,0,LimitC);
			
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요. \n\x13\x04실행 방지 코드 0x32223223 작동.",4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDD,SetTo,1);
		}
	}
	
	Trigger { -- 배속방지
		players = {FP},
		conditions = {
			Memory(0x51CE84,AtLeast,1001);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x1B방 제목에서 배속 옵션을 제거해 주십시오. \n\x13\x1B또는 게임 반응속도(턴레이트)를 최대로 올려주십시오.\n\x13\x04실행 방지 코드 0x32223223 작동.",4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDD,SetTo,1);
		}
	}
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
			SetMemory(0xCDDDCDDD,SetTo,1);
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
			SetMemory(0xCDDDCDDD,SetTo,1);
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
			SetMemory(0xCDDDCDDD,SetTo,1);
		}
	}
	--		Trigger { -- 싱글플 불가능 맵
	--			players = {FP},
	--			conditions = {
	--				Memory(0x57F0B4, Exactly, 0);
	--		},
	--			actions = {
	--				RotatePlayer({
	--				DisplayTextX("\x13\x04싱글플레이로는 플레이할 수 없습니다. 멀티플레이로 시작해주세요.\n\x13\x04실행 방지 코드 0x32223223 작동.",4);
	--				Defeat();
	--				},HumanPlayers,FP);
	--				Defeat();
	--				SetMemory(0xCDDDCDDD,SetTo,1);
	--		},
	--		}
	--	
		Trigger { -- 혹시 싱글이신가요?
			players = {FP},
			conditions = {
				Label(0);
				Memory(0x57F0B4, Exactly, 0);
		},
			actions = {
				SetCDeaths(FP,SetTo,1,isSingle);
		},
		}
	--	
	CIf(FP,CDeaths(FP,AtLeast,1,isSingle))
		DoActions(FP,{
			SetMemoryX(0x581DAC,SetTo,254*65536,0xFF0000), --P8컬러f
			SetMemoryX(0x581DDC,SetTo,254*256,0xFF00); --P8 미니맵
		})
	CIfEnd()
	DoActionsX(FP,SetCDeaths(FP,SetTo,200,PExitFlag))


	for i = 0, 6 do
	ItoName(FP,i,VArr(Names[i+1],0),ColorCode[i+1])
	_0DPatchX(FP,Names[i+1],7)
	end

	f_GetStrXptr(FP,UPCompStrPtr,"\x0D\x0D\x0DUPC".._0D)
	f_GetStrXptr(FP,f_GunStrPtr,"\x0D\x0D\x0Df_Gun".._0D)
	f_GetStrXptr(FP,G_CA_StrPtr,"\x0D\x0D\x0DG_CA_Err".._0D)
	f_GetStrXptr(FP,G_CA_StrPtr2,"\x0D\x0D\x0DG_CA_Func".._0D)


	
	f_GetStrXptr(FP,f_GunSendStrPtr,"\x0D\x0D\x0Df_GunSend".._0D)
	f_GetStrXptr(FP,HTextStrPtr,HTextStr)
	for i = 0, 6 do
	f_GetStrXptr(FP,ShTStrPtr[i+1],"\x0D\x0D\x0D"..PlayerString[i+1].."shd".._0D)
	f_GetStrXptr(FP,PScoreSTrPtr[i+1],"\x0D\x0D\x0D"..PlayerString[i+1].."Score".._0D)
	end
	f_GetStrXptr(FP,DBoss_PrintScore,"\x0D\x0D\x0DDBossSC".._0D)
	f_GetStrXptr(FP,DBoss_PrintScore2,"\x0D\x0D\x0DDBossDMG".._0D)


	Print_All_CTextString(FP)
	f_MemCpy(FP,UPCompStrPtr,_TMem(Arr(Str12[3],0),"X","X",1),Str12[2])
	--f_MemCpy(FP,_Add(UPCompStrPtr,Str12[2]-3),_TMem(Arr(UpCompTxt,0),"X","X",1),5*4)
	f_MemCpy(FP,_Add(UPCompStrPtr,Str12[2]+20),_TMem(Arr(Str22[3],0),"X","X",1),Str22[2])
	--f_MemCpy(FP,_Add(UPCompStrPtr,Str12[2]-3+20+Str22[2]-3),_TMem(Arr(UpCompRet,0),"X","X",1),5*4)
	f_MemCpy(FP,_Add(UPCompStrPtr,Str12[2]+20+Str22[2]-3+20),_TMem(Arr(Str23[3],0),"X","X",1),Str23[2])

	f_MemCpy(FP,f_GunStrPtr,_TMem(Arr(f_GunT[3],0),"X","X",1),f_GunT[2])
	f_MemCpy(FP,G_CA_StrPtr,_TMem(Arr(f_GunErrT[3],0),"X","X",1),f_GunErrT[2])
	f_MemCpy(FP,G_CA_StrPtr2,_TMem(Arr(f_GunFuncT[3],0),"X","X",1),f_GunFuncT[2])
	f_MemCpy(FP,f_GunSendStrPtr,_TMem(Arr(f_GunSendT[3],0),"X","X",1),f_GunSendT[2])

	f_MemCpy(FP,_Add(f_GunStrPtr,f_GunT[2]+20),_TMem(Arr(Str24[3],0),"X","X",1),Str24[2])

	for i = 1, 7 do
	Install_CText1(PScoreSTrPtr[i],Str10,Str18,Names[i])
	Install_CText1(ShTStrPtr[i],Str12,Str13,Names[i])
	end


	DoActions(FP,{GiveUnits(1,133,P8,11,0),GiveUnits(1,133,P8,12,1),GiveUnits(1,133,P8,13,2)})
	CMov(FP,0x6509B0,19025+19)
	CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
		CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,AtMost,7,0,0xFF)})
			f_SaveCp()
			-- 유닛정보를 길이 8바이트의 데이터 배열에 저장함
			-- 0xYYYYXXXX 0xLLIIPPUU
			-- X = 좌표 X, Y = 좌표 Y, L = 유닛 식별자, I = 무적 플래그, P = 플레이어ID, U = 유닛ID
			CIf(FP,{TTMemory(_Add(BackupCp,6),NotSame,58)}) -- 발키리 저리가
				f_Read(FP,_Sub(BackupCp,9),CPos)
				f_Read(FP,BackupCp,CunitP,"X",0xFF)
				f_Read(FP,_Add(BackupCp,6),RepHeroIndex)
				CMov(FP,Gun_LV,0)
				CIf(FP,CVar(FP,RepHeroIndex[2],Exactly,133))
				TriggerX(FP,{CVar(FP,CunitP[2],Exactly,0)},{SetCVar(FP,Gun_LV[2],SetTo,1)},{Preserved})
				TriggerX(FP,{CVar(FP,CunitP[2],Exactly,1)},{SetCVar(FP,Gun_LV[2],SetTo,2)},{Preserved})
				TriggerX(FP,{CVar(FP,CunitP[2],Exactly,2)},{SetCVar(FP,Gun_LV[2],SetTo,3)},{Preserved})
				DoActionsX(FP,SetCVar(FP,CunitP[2],SetTo,7))
				CIfEnd()
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

			CIfEnd()
			f_LoadCp()
		CIfEnd()
		CAdd(FP,0x6509B0,84)
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
	DoActions(FP,{GiveUnits(1,133,0,11,P8),GiveUnits(1,133,1,12,P8),GiveUnits(1,133,2,13,P8)})
	CMov(FP,RepHeroIndex,0)
	CWhile(FP,CVar(FP,RepHeroIndex[2],AtMost,227))
	TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,58)},{SetCVar(FP,RepHeroIndex[2],Add,1)},{Preserved}) -- 발키리 나가
	CDoActions(FP,{TModifyUnitEnergy(All,RepHeroIndex,AllPlayers,64,0),TRemoveUnit(RepHeroIndex,AllPlayers),TRemoveUnit(RepHeroIndex,P9),TRemoveUnit(RepHeroIndex,P10),TRemoveUnit(RepHeroIndex,P11),TRemoveUnit(RepHeroIndex,P12)})
	CAdd(FP,RepHeroIndex,1)
	CWhileEnd()
	f_ArrReset()
	CIfEnd(SetMemory(0x6509B0,SetTo,FP)) -- OnPluginStart End
end

function onInit_EUD2()
	CIfOnce(FP)
	CMov(FP,0x6509B0,UnitDataPtr)
	CWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0))
		CallTrigger(FP,f_Replace)-- 데이터화 한 유닛 재배치하는 코드
		CAdd(FP,0x6509B0,2)
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
	CIfEnd()
end