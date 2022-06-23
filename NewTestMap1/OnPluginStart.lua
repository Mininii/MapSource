function init()
	PatchArr={}
	PatchArrPrsv={}
	function PatchInsert(Act)
		table.insert(PatchArr,Act)
	end
	function PatchInsertPrsv(Act)
		table.insert(PatchArrPrsv,Act)
	end
	function SetUnitAdvFlag(UnitID,Value,Mask)
	PatchInsert(SetMemoryX(0x664080 + (UnitID*4),SetTo,Value,Mask))
	end

	function DefTypePatch(UnitID,Value)
	PatchInsert(SetMemoryB(0x662180 + UnitID,SetTo,Value))
	end
	function SetWepTargetFlags(WeaponID,Value)
	PatchInsert(SetMemoryW(0x657998 + (WeaponID*2), SetTo, Value))
	end
	
	function SetUnitsDat(UnitID,MinCost,GasCost,BuildTime,SuppCost,SuppProv,Playerable)
		if Playerable ~=nil then
			PatchInsert(SetMemoryB(0x57F27C + (0 * 228) + UnitID,SetTo,0))
			PatchInsert(SetMemoryB(0x57F27C + (1 * 228) + UnitID,SetTo,0))
			PatchInsert(SetMemoryB(0x57F27C + (2 * 228) + UnitID,SetTo,0))
			PatchInsert(SetMemoryB(0x57F27C + (3 * 228) + UnitID,SetTo,0))
			PatchInsert(SetMemoryB(0x57F27C + (4 * 228) + UnitID,SetTo,0))
			PatchInsert(SetMemoryB(0x57F27C + (5 * 228) + UnitID,SetTo,0))
			PatchInsert(SetMemoryB(0x57F27C + (6 * 228) + UnitID,SetTo,0))
			PatchInsert(SetMemoryB(0x57F27C + (7 * 228) + UnitID,SetTo,0))
		end
		if SuppProv~=nil then
			PatchInsert(SetMemoryB(0x6646C8+UnitID,SetTo,SuppProv)) -- 서플공급량
		end
		
		if MinCost ~= nil then
		PatchInsert(SetMemoryW(0x663888 + (UnitID *2),SetTo,MinCost)) -- 미네랄
		end
		if GasCost ~= nil then
		PatchInsert(SetMemoryW(0x65FD00 + (UnitID *2),SetTo,GasCost)) -- 가스
		end
		if BuildTime ~= nil then
		PatchInsert(SetMemoryW(0x660428 + (UnitID *2),SetTo,BuildTime)) -- 생산속도
		end
		if SuppCost ~= nil then
		PatchInsert(SetMemoryB(0x663CE8 + UnitID,SetTo,SuppCost)) -- 서플
		end

	end
	function SetBuildingDim(UnitID,X,Y)
		PatchInsert(SetMemory(0x662860 + (UnitID*4),SetTo,X+(Y*65536))) -- 건설크기
		
	end

Trigger { -- 퍼센트 데미지 세팅
players = {P8},
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
	SetMemory(0x515BB0,SetTo,256);--0
	SetMemory(0x515BB4,SetTo,256);--1
	SetMemory(0x515BB8,SetTo,256);--2
	SetMemory(0x515BBC,SetTo,256);--3
	SetMemory(0x515BC0,SetTo,256);--4
	SetMemory(0x515BC4,SetTo,256);--5
	SetMemory(0x515BC8,SetTo,256);--6
	SetMemory(0x515BCC,SetTo,256);--7
	SetMemory(0x515BD0,SetTo,256);--8
	SetMemory(0x515BD4,SetTo,256);--9
	SetMemory(0x6616B0, SetTo, 2097615);
	SetMemory(0x6643B0, SetTo, 536870916);
	SetMemory(0x666460, SetTo, 32965359);-- 204번유닛 이펙트유닛으로 사용
	
},
}
DoActions(FP,ModifyUnitHangarCount(5, All, 83, Force1, 64) )
for i = 0, 7 do
	PatchInsert(SetMemory(0x5821A4 + (i*4),SetTo,800))--9
	PatchInsert(SetMemory(0x582234 + (i*4),SetTo,800))--9
	PatchInsert(SetMemory(0x5822C4 + (i*4),SetTo,800))--9
end

	function SetTechTime(Tech,Value)
		PatchInsert(SetMemoryW(0x6563D8+(Tech*2),SetTo,Value)) -- 업글시간
	end
	function SetUpgradeTime(Upgrade,Value)
		PatchInsert(SetMemoryW(0x655940+(Upgrade*2),SetTo,Value)) -- 업글시간(증가량)
		PatchInsert(SetMemoryW(0x655B80+(Upgrade*2),SetTo,Value)) -- 업글시간(베이스)
	end
	function SetUpgradeMax(Upgrade,Value)
		PatchInsert(SetMemoryB(0x655700+(Upgrade),SetTo,Value)) -- 최대업글렙
		PatchInsert(SetMemoryB(0x58D088+(Upgrade)+(46*0),SetTo,Value)) -- 최대업글렙
		PatchInsert(SetMemoryB(0x58D088+(Upgrade)+(46*1),SetTo,Value)) -- 최대업글렙
		PatchInsert(SetMemoryB(0x58D088+(Upgrade)+(46*2),SetTo,Value)) -- 최대업글렙
		PatchInsert(SetMemoryB(0x58D088+(Upgrade)+(46*3),SetTo,Value)) -- 최대업글렙
		
	end
	
	function UnitSizePatch(UnitID,L,U,R,D)
		table.insert(PatchArr,SetMemory(0x6617C8 + (UnitID*8),SetTo,(L)+(U*65536)))
		table.insert(PatchArr,SetMemory(0x6617CC + (UnitID*8),SetTo,(R)+(D*65536)))
		end

	function SetStarEditFlag(UnitID,Value)
		PatchInsert(SetMemoryW(0x661518+(UnitID*2),SetTo,Value))
	end
	for i = 0, 43 do -- 테크업글속도0
		SetTechTime(i,0)
	end
	for i = 0, 60 do
		SetUpgradeTime(i,0)
	end
	UpMaxArr = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,35}
	for j, k in pairs(UpMaxArr) do
		SetUpgradeMax(k,255)
	end
	
	for i = 0, 227 do
		if i~=nilunit then
			SetStarEditFlag(i, 0x1C7)--전부트리거생성가능
		end

		DefTypePatch(i,0) -- 방어타입 전부 0으로 설정
		SetUnitAdvFlag(i,0,0x4000) -- 모든유닛 어드밴스드 플래그 중 로보틱 전부제거
		if i~=85 and i~=108 then
		SetUnitAdvFlag(i,0x4000,0x4000+0x20000+0x80000) -- 모든 유닛(딱딱이, 사용불가유닛 제외) 로보틱 부여, 크립, 파일런 필요X
		if i==106 then
			SetUnitsDat(i,nil,nil,7)
		else
			SetUnitsDat(i,nil,nil,5)
		end
		else
			SetUnitAdvFlag(i,0,0x4000) -- 모든 유닛(딱딱이, 사용불가유닛 제외) 로보틱 부여, 크립, 파일런 필요X
			SetUnitsDat(i,nil,nil,nil,nil,nil,1)
		end
	end
	for i = 0, 129 do
		SetWepTargetFlags(i,0x020 + 1 + 2) -- 모든 유닛 공격 비 로보틱 설정
	end
	SplashArr = {6,27,28,50,51,54,84,103,100}
	for j, k in pairs(SplashArr) do
		PatchInsert(SetMemoryB(0x6566F8+k,SetTo,3))
	end
	SuppProvArr = {131,132,133,106,154,156,109,42,57}
	BdDImArr = {131,132,133,106,154,156,109,162,124,143,144,146,125}
	for j,k in pairs(SuppProvArr) do
		SetUnitsDat(k,nil,nil,nil,nil,50)
	end
	for j,k in pairs(BdDImArr) do
		SetBuildingDim(k,1,1)
	end
	SetUnitAdvFlag(204, 536870916, 0xFFFFFFFF)
	UnitSizePatch(204,1,1,1,1)
	SetBuildingDim(204, 1, 1)

	DoActions2(AllPlayers,PatchArr,1)
	DoActions2(AllPlayers,PatchArrPrsv)
	DoActions2(FP,{--EUD Editor 1
		SetMemoryX(0x6640BC, SetTo, 4,4); -- 시민 공중유닛, 스캐럽으로 외형전환
		SetMemory(0x664504, Subtract, 385875968); -- 시민 공중유닛, 스캐럽으로 외형전환

		SetMemory(0x6C9908, Subtract, 512); -- Substructure Opening Hole
		SetMemory(0x6C9DD8, Add, 65536); -- Substructure Opening Hole
		SetMemory(0x6C9ED0, Add, 20480); -- Substructure Opening Hole
		SetMemory(0x6CA1BC, Add, 1); -- Substructure Opening Hole
	})
end