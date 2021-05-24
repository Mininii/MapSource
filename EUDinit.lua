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

for i = 1, #HeroArr do
	
	table.insert(CTrigPatchTable,SetVArrayX(VArr(HeroVArr,i-1),"Value",SetTo,HeroArr[i]))
end
DoActionsX(FP,CTrigPatchTable,1)
VRet = CreateVar()
VRet2 = CreateVar()
VRet3 = CreateVar()
VRet4 = CreateVar()
CMov(FP,CurrentUID,0)
CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227)) --  모든 유닛의 스패셜 어빌리티 플래그 설정
TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,58)},{SetCVar(FP,CurrentUID[2],Add,1)},{Preserved}) -- 아 발키리 좀 저리가요
CMov(FP,VRet,CurrentUID,EPD(0x664080))
CMov(FP,VRet2,CurrentUID,EPD(0x662860))

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

for i = 0, 129 do
WeaponTypePatch(i,0) -- 무기 타입 전부 0으로 설정(방갈림 방지)
end
WeaponTypePatch(5,2) -- 무기 타입 퍼딜
WeaponTypePatch(21,2) -- 무기 타입 퍼딜
WeaponTypePatch(100,2) -- 무기 타입 퍼딜
WeaponTypePatch(85,2) -- 무기 타입 퍼딜
SetUnitClassType(19,1)
SetUnitClassType(29,1)
SetUnitClassType(98,1)
SetUnitClassType(75,1)

SetUnitClassType(77)
SetUnitClassType(78)
SetUnitClassType(28)
SetUnitClassType(17)
SetUnitClassType(21)
SetUnitClassType(86)
SetUnitClassType(88)
SetUnitClassType(25)
SetUnitClassType(76)
SetUnitClassType(79)
SetUnitClassType(220)
SetUnitClassType(150)

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
table.insert(PatchArr,SetMemory(0x582234 + (4*i),SetTo,2400))
table.insert(PatchArr,SetMemory(0x5821D4 + (4*i),SetTo,2400))
table.insert(PatchArr,SetMemoryB(0x6566F8 + (MarWep[i+1]),SetTo,3))
table.insert(PatchArr,SetMemoryW(0x656888 + (MarWep[i+1]*2),SetTo,5))
table.insert(PatchArr,SetMemoryW(0x6570C8 + (MarWep[i+1]*2),SetTo,10))
table.insert(PatchArr,SetMemoryW(0x657780 + (MarWep[i+1]*2),SetTo,15))
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
	table.insert(PatchArr,SetMemoryB(0x6616E0 + MarID[i+1],SetTo,MarWep[i+1]))
	table.insert(PatchArr,SetMemoryB(0x6636B8 + MarID[i+1],SetTo,MarWep[i+1]))
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

--UnitSizePatch(39,10) -- 저그 유닛 크기 10*10 설정
--UnitSizePatch(45,10) -- 저그 유닛 크기 10*10 설정
--UnitSizePatch(44,10) -- 저그 유닛 크기 10*10 설정
--UnitSizePatch(48,10) -- 저그 유닛 크기 10*10 설정
--UnitSizePatch(49,10) -- 저그 유닛 크기 10*10 설정
--UnitSizePatch(56,10) -- 저그 유닛 크기 10*10 설정
--UnitSizePatch(55,10) -- 저그 유닛 크기 10*10 설정
UnitSizePatch(11,1)
for i = 220, 227 do
	DefTypePatch(i,9)
end
	DefTypePatch(7,9)
	DefTypePatch(150,9)


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
		SetMemoryX(0x581DAC,SetTo,128*65536,0xFF0000), --P8컬러
		SetMemoryX(0x581DDC,SetTo,128*256,0xFF00); --P8 미니맵
	},
}
DoActions2(FP,PatchArr,1) -- 위에서 받은 테이블 정보를 한번에 쏘는것

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

DoActionsX(FP,{SetCDeaths(FP,SetTo,Limit,LimitX),SetCDeaths(FP,SetTo,TestStart,TestMode)}) -- Limit설정
TriggerX(FP,{CDeaths(FP,AtLeast,1,TestMode)},{RotatePlayer({RunAIScript("Turn ON Shared Vision for Player 8")},MapPlayers,FP)})
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


Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,1,LimitX);
		CDeaths(FP,Exactly,0,LimitC);
		
	},
	actions = {
		RotatePlayer({
		DisplayTextX("\x13\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.",4);
		Defeat();
		},HumanPlayers,FP);
	}
}
