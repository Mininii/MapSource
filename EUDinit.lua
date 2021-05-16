PatchArr = {}
PatchArrPrsv = {}


function CunitCtrig_Part4X2(LoopIndex,Conditions,Actions)
	MoveCpValue = 0
	Trigger { -- Cunit Calc Main
		players = {ParsePlayer(PlayerID)},
		conditions = { 
			Label(0);
			Conditions,
		},
		actions = { 
			SetCtrigX("X","X",0x4,0,SetTo,"X",CCArr[CCptr],0,0,0);
			SetCtrigX("X",CCArr[CCptr]+1,0x4,0,SetTo,"X","X",0,0,1);
			SetCtrigX("X",CCArr[CCptr],0x158,0,SetTo,"X","X",0x4,1,0);
			SetCtrigX("X",CCArr[CCptr],0x15C,0,SetTo,"X","X",0,0,1);
			SetMemory(0x6509B0,SetTo,19025 + 84 * LoopIndex);
			Actions,
			},
		flag = {Preserved}
	}		
end

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

function WeaponTypePatch(WeaponID,Value)
table.insert(PatchArr,SetMemoryB(0x657258 + WeaponID,SetTo,Value))
end
function SetUnitCost(UnitID,Cost)
table.insert(PatchArr,SetMemoryW(0x65FD00+(UnitID*2), SetTo, 0))
table.insert(PatchArr,SetMemoryW(0x663888+(UnitID*2), SetTo, Cost))
end
VRet = CreateVar()
VRet2 = CreateVar()
CMov(FP,CurrentUID,0)
CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227)) --  모든 유닛의 스패셜 어빌리티 플래그 설정
--TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,58)},{SetCVar(FP,CurrentUID[2],Add,1)},{Preserved}) -- 아 발키리 좀 저리가요
CMov(FP,VRet,CurrentUID,EPD(0x664080))
CMov(FP,VRet2,CurrentUID,EPD(0x662860))
CTrigger(FP,{TDeathsX(VRet,Exactly,0x1,0,0x1)},{TSetDeaths(VRet2,SetTo,65537,0)},1) -- if Advanced Flags = Building then Building Dimensions SetTo 1x1
CDoActions(FP,{TSetDeathsX(VRet,SetTo,0x200000,0,0x200000)}) -- All Unit SetTo Spellcaster
CAdd(FP,CurrentUID,1)
CWhileEnd()
CMov(FP,CurrentUID,0)

for i = 0, 227 do
SetToUnitDef(i,0) -- 방어력 전부 0으로 설정 
DefTypePatch(i,9) -- 방어타입 전부 9로 설정
end

for i = 0, 129 do
WeaponTypePatch(i,0) -- 무기 타입 전부 0으로 설정(방갈림 방지)
end



for i = 0, 6 do
	DefTypePatch(MarID[i+1],i) -- 마린의 방어타입을 P1부터 P7까지 차례대로 배분
	SetUnitClass(MarID[i+1],199) -- 마린 계급설정. 체력보이게 하기 위함
	SetShield(MarID[i+1]) -- 마린 쉴드 설정. 쉴드 활성화 + 쉴드 1000 설정
	UnitSizePatch(MarID[i+1],8) -- 마린 크기 8*8 설정
	UnitEnable2(MarID[i+1])
end
	UnitEnable2(15)
	UnitEnable2(12)
for i = 1, 4 do
	UnitEnable3(MedicTrig[i],i)
	SetUnitCost(MedicTrig[i],200+(i*50))
end

for i = 37,52 do
UnitSizePatch(i,3) -- 저그 유닛 크기 3*3 설정
end


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
		SetMemory(0x515BAC,SetTo,256);---------크기 9 일반형
		SetMemory(0x515BB0,SetTo,256);---------크기 0 진동형 P1
		SetMemory(0x515BB4,SetTo,256);---------크기 1 진동형 P2
		SetMemory(0x515BB8,SetTo,256);---------크기 2 진동형 P3
		SetMemory(0x515BBC,SetTo,256);---------크기 3 진동형 P4
		SetMemory(0x515BC0,SetTo,256);---------크기 4 진동형 P5
		SetMemory(0x515BC4,SetTo,256);---------크기 5 진동형 P6
		SetMemory(0x515BC8,SetTo,256);---------크기 6 진동형 P7
		SetMemory(0x515BCC,SetTo,256);---------크기 7 진동형 Civil
		SetMemory(0x515BD0,SetTo,256);---------크기 8 진동형 SCV
		SetMemory(0x515BD4,SetTo,256);---------크기 9 진동형	Bunker? Turret? 적?
	},
}
DoActions2(FP,PatchArr,1) -- 위에서 받은 테이블 정보를 한번에 쏘는것

TriggerX(FP,nil,{SetCDeaths(FP,SetTo,Limit,LimitX)}) -- Limit설정

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