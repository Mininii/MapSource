PatchArr = {}
PatchArrPrsv = {}
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

function UnitEnable2(UnitID)
table.insert(PatchArrPrsv,SetMemoryW(0x660A70 + (UnitID *2),SetTo,5))
table.insert(PatchArr,SetMemoryB(0x57F27C + (6 * 228) + UnitID,SetTo,0))
table.insert(PatchArr,SetMemoryB(0x57F27C + (7 * 228) + UnitID,SetTo,0))
table.insert(PatchArr,SetMemoryB(0x663CE8 + UnitID,SetTo,0))
end

CMov(FP,CurrentUID,0)
CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227)) -- if Advanced Flags = Building then Building Dimensions SetTo 1x1
CTrigger(FP,{TDeathsX(_Add(CurrentUID,EPD(0x664080)),Exactly,0x1,0,0x1)},{TSetDeaths(_Add(CurrentUID,EPD(0x662860)),SetTo,65537,0)},1)
CAdd(FP,CurrentUID,1)
CWhileEnd()
CMov(FP,CurrentUID,0)

for i = 0, 227 do
SetToUnitDef(i,0)
DefTypePatch(i,9)
end

for i = 0, 6 do
	DefTypePatch(MarID[i+1],i)
	SetUnitClass(MarID[i+1],199)
	
end

for i = 37,52 do
UnitSizePatch(i,3)
end


Trigger { -- 퍼센트 데미지 세팅
	players = {P6},
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
		SetMemory(0x515BB0,SetTo,256);---------크기 0 진동형
		SetMemory(0x515BB4,SetTo,256);---------크기 1 진동형
		SetMemory(0x515BB8,SetTo,256);---------크기 2 진동형
		SetMemory(0x515BBC,SetTo,256);---------크기 3 진동형
		SetMemory(0x515BC0,SetTo,256);---------크기 4 진동형
		SetMemory(0x515BC4,SetTo,256);---------크기 5 진동형
		SetMemory(0x515BC8,SetTo,256);---------크기 6 진동형
		SetMemory(0x515BCC,SetTo,256);---------크기 7 진동형
		SetMemory(0x515BD0,SetTo,256);---------크기 8 진동형
		SetMemory(0x515BD4,SetTo,256);---------크기 9 진동형
	},
}
DoActions2(FP,PatchArr,1)