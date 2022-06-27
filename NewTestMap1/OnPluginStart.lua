function init()
	PatchArr={}
	PatchArrPrsv={}
	ZealotUIDArr = {}
	function SetZealotUnit(UnitID,HP,Shield,WepID,WepDamage,ClockingFlag,HighSpeed,Color)
		PatchInsert(SetMemoryB(0x6644F8+UnitID,SetTo,49))
		PatchInsert(SetMemoryB(0x662098+UnitID,SetTo,1))
		PatchInsert(SetMemoryB(0x662268+UnitID,SetTo,2))
		PatchInsert(SetMemoryB(0x662EA0+UnitID,SetTo,2))
		PatchInsert(SetMemoryB(0x663320+UnitID,SetTo,10))
		PatchInsert(SetMemoryB(0x663A50+UnitID,SetTo,2))
		PatchInsert(SetMemoryB(0x664898+UnitID,SetTo,2))
		if ClockingFlag == 1 then
			PatchInsert(SetMemoryX(0x664080 + (UnitID*4),SetTo,402653184+4194816,0xFFFFFFFF))
		else
			PatchInsert(SetMemoryX(0x664080 + (UnitID*4),SetTo,402653184,0xFFFFFFFF))
		end
		PatchInsert(SetMemoryB(0x65FEC8 + UnitID,SetTo,0))
		PatchInsert(SetMemory(0x662350 + (UnitID*4),SetTo,HP*256))
		PatchInsert(SetMemoryW(0x660E00 + (UnitID *2), SetTo, Shield))
		PatchInsert(SetMemoryB(0x6647B0 + UnitID,SetTo,1))
		PatchInsert(SetMemoryB(0x6637A0+UnitID,SetTo,4))
		PatchInsert(SetMemoryW(0x663408+(UnitID *2),SetTo,0))
		PatchInsert(SetMemoryW(0x663EB8+(UnitID *2),SetTo,0))
		PatchInsert(SetMemoryB(0x662DB8+UnitID,SetTo,3))
		PatchInsert(SetMemoryB(0x663238+UnitID,SetTo,7))
		PatchInsert(SetMemoryB(0x660FC8+UnitID,SetTo,0x41))
		PatchInsert(SetMemoryW(0x662F88+(UnitID *2),SetTo,40))
		PatchInsert(SetMemory(0x662860 + (UnitID*4),SetTo,23+(27*65536))) -- 건설크기
		PatchInsert(SetMemoryB(0x6616E0+UnitID,SetTo,130))
		PatchInsert(SetMemoryB(0x6636B8+UnitID,SetTo,WepID))
		PatchInsert(SetMemory(0x6617C8 + (UnitID*8),SetTo,(2)+(2*65536)))
		PatchInsert(SetMemory(0x6617CC + (UnitID*8),SetTo,(2)+(2*65536)))
		PatchInsert(SetMemoryB(0x663150+UnitID,SetTo,4))
		PatchInsert(SetMemoryB(0x6605F0+UnitID,SetTo,32))
		PatchInsert(SetMemory(0x657470+(WepID *4),SetTo,32)) -- 사거리
		PatchInsert(SetMemory(0x656CA8+(WepID *4),SetTo,0)) -- 그래픽
		PatchInsert(SetMemoryW(0x656EB0+(WepID *2),SetTo,WepDamage)) -- 공격력
		PatchInsert(SetMemoryW(0x657678+(WepID *2),SetTo,0)) -- 추가공격력
		PatchInsert(SetMemoryW(0x6572E0+(WepID *2),SetTo,283)) -- 이름
		PatchInsert(SetMemoryW(0x656780+(WepID *2),SetTo,353)) -- 아이콘
		PatchInsert(SetMemoryB(0x656670+WepID,SetTo,5)) -- 공격유닛에서나옴
		PatchInsert(SetMemoryB(0x656FB8+WepID,SetTo,30)) -- 공속
		PatchInsert(SetMemoryB(0x6564E0+WepID,SetTo,2)) -- 투사체수
		table.insert(ZealotUIDArr,{UnitID,HighSpeed,Color})
	end

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
	
	function SetUnitsDat(UnitID,MinCost,GasCost,BuildTime,SuppCost,SuppProv,Playerable,HP,Shield)
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
		PatchInsert(SetMemoryB(0x663CE8 + UnitID,SetTo,SuppCost*2)) -- 서플
		end
		if HP ~= nil then 
		PatchInsert(SetMemory(0x662350 + (UnitID*4),SetTo,HP*256))
		end
		if Shield ~= nil then 
		PatchInsert(SetMemoryW(0x660E00 + (UnitID *2), SetTo, Shield))
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
		if i~=85 and i~=144 and i~=84 and i~=108 then
		SetUnitAdvFlag(i,0x4000,0x4000+0x20000+0x80000) -- 모든 유닛(딱딱이, 사용불가유닛 제외) 로보틱 부여, 크립, 파일런 필요X
		if i==106 or i==124 then
			SetUnitsDat(i,nil,nil,7)
		else
			SetUnitsDat(i,nil,nil,5)
		end
		else
		end
	end

	UnusedUnitArr = {85,144,84,108,159}
	for j,k in pairs(UnusedUnitArr) do
		SetUnitAdvFlag(k,0,0x4000) -- 모든 유닛(딱딱이, 사용불가유닛 제외) 로보틱 부여, 크립, 파일런 필요X
		SetUnitsDat(k,nil,nil,nil,nil,nil,1)
	end

	for i = 0, 116 do
		SetWepTargetFlags(i,0x020 + 1 + 2) -- 모든 유닛 공격 비 로보틱 설정(117이상제외)
	end
	SplashArr = {6,27,28,50,51,54,84,103,100}
	for j, k in pairs(SplashArr) do
		PatchInsert(SetMemoryB(0x6566F8+k,SetTo,3))
	end
	SuppProvArr = {131,132,133,106,154,156,109,42,57}
	BdDImArr = {131,132,133,106,154,156,109,162,124,143,144,146,125}
	for j,k in pairs(SuppProvArr) do
		SetUnitsDat(k,nil,nil,nil,nil,250)
	end
	for j,k in pairs(BdDImArr) do
		SetBuildingDim(k,1,1)
	end
	function SetUnitDefUpType(UnitID,Value)
	table.insert(PatchArr,SetMemoryB(0x6635D0 + UnitID,SetTo,Value))
	end
	TBuildingArr = {106,107,108,109,110,111,112,113,114,115,116,117,118,120,122,123,124,125}
	PBuildingArr = {154,155,156,157,159,160,162,163,164,165,166,167,169,170,171,172}
	ZBuildingArr = {130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,146,149}

	function SetWepUpType(WeaponID,Value)
		table.insert(PatchArr,SetMemoryB(0x6571D0 + WeaponID, SetTo, Value))
		end
	for j, k in pairs(TBuildingArr) do
		SetUnitDefUpType(k, 2)
	end
	for j, k in pairs(PBuildingArr) do
		SetUnitDefUpType(k, 6)
	end
	for j, k in pairs(ZBuildingArr) do
		SetUnitDefUpType(k, 4)
	end


	SetUnitAdvFlag(204, 536870916, 0xFFFFFFFF) -- 이펙트유닛
	UnitSizePatch(204,1,1,1,1) -- 이펙트유닛
	SetBuildingDim(204, 1, 1) -- 이펙트유닛
	SetUnitsDat(124,75*10,nil,nil,10,nil,nil,1500)
	PatchInsert(SetMemoryW(0x656EB0+(29 *2),SetTo,20*10)) -- 공격력
	PatchInsert(SetMemoryW(0x657678+(29 *2),SetTo,120)) -- 추가공격력
	PatchInsert(SetMemoryB(0x6616E0+124,SetTo,130))
	PatchInsert(SetMemoryB(0x6636B8+124,SetTo,29))
	SetUnitsDat(143,75*10,nil,nil,10,nil,nil,2500)
	SetUnitsDat(146,50*10,nil,nil,10,nil,nil,2000)
	PatchInsert(SetMemoryW(0x656EB0+(53 *2),SetTo,40*10)) -- 공격력
	PatchInsert(SetMemoryW(0x657678+(53 *2),SetTo,200)) -- 추가공격력
	SetUnitsDat(0,50*2,nil,nil,2,nil,nil,85)
	PatchInsert(SetMemoryW(0x656EB0+(0 *2),SetTo,12)) -- 공격력
	PatchInsert(SetMemoryW(0x657678+(0 *2),SetTo,5)) -- 추가공격력
	SetUnitsDat(162,150*3,nil,nil,3,nil,nil,400,400)
	PatchInsert(SetMemoryW(0x656EB0+(80 *2),SetTo,60)) -- 공격력
	PatchInsert(SetMemoryW(0x657678+(80 *2),SetTo,7)) -- 추가공격력
	PatchInsert(SetMemoryW(0x656EB0+(81 *2),SetTo,60)) -- 공격력
	PatchInsert(SetMemoryW(0x657678+(81 *2),SetTo,7)) -- 추가공격력
	SetWepUpType(29,8)
	SetWepUpType(53,11)
	SetWepUpType(80,13)
	SetWepUpType(81,13)
	SetBuildingDim(194,1,1)
	SetBuildingDim(195,1,1)
	SetBuildingDim(196,1,1)

	SetZealotUnit(89,20,30,117,8,nil,900,0) -- 1
	SetZealotUnit(90,1600,500,118,40,nil,1300,10) -- 100 
	SetZealotUnit(93,179000,3500,119,65,nil,1700,16) -- 10000
	SetZealotUnit(95,1280000,15000,120,120,nil,2300,13) -- 1000000
	SetZealotUnit(96,8320000,65535,121,255,nil,3000,15) -- 100000000

	DoActions2(AllPlayers,PatchArr,1)
	DoActions2(AllPlayers,PatchArrPrsv)
	DoActions2(FP,{--EUD Editor 1
		SetMemoryX(0x6640BC, SetTo, 4,4); -- 시민 공중유닛, 스캐럽으로 외형전환
		SetMemory(0x664504, Subtract, 385875968); -- 시민 공중유닛, 스캐럽으로 외형전환

		SetMemory(0x6C9908, Subtract, 512); -- Substructure Opening Hole
		SetMemory(0x6C9DD8, Add, 65536); -- Substructure Opening Hole
		SetMemory(0x6C9ED0, Add, 20480); -- Substructure Opening Hole
		SetMemory(0x6CA1BC, Add, 1); -- Substructure Opening Hole
	},1)
end