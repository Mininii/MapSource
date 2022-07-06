function init()
	PatchArr = {}
	PatchArrPrsv={}
	ZealotUIDArr = {}
	for i = 0, 19 do
		PatchInsert(SetMemory(0x515B88+(i*4),SetTo,256))--퍼센트 데미지 세팅
	end
	--DatEdit
	PatchInsert(SetMemoryX(0x6640BC, SetTo, 4,4)) -- 시민 공중유닛, 스캐럽으로 외형전환
	PatchInsert(SetMemory(0x664504, Subtract, 385875968)) -- 시민 공중유닛, 스캐럽으로 외형전환
	PatchInsert(SetMemory(0x6C9908, Subtract, 512)) -- Substructure Opening Hole
	PatchInsert(SetMemory(0x6C9DD8, Add, 65536)) -- Substructure Opening Hole
	PatchInsert(SetMemory(0x6C9ED0, Add, 20480)) -- Substructure Opening Hole
	PatchInsert(SetMemory(0x6CA1BC, Add, 1)) -- Substructure Opening Hole


	for i = 0, 7 do
		PatchInsert(SetMemory(0x5821A4 + (i*4),SetTo,800))--인구수 400 설정
		PatchInsert(SetMemory(0x582234 + (i*4),SetTo,800))--인구수 400 설정
		PatchInsert(SetMemory(0x5822C4 + (i*4),SetTo,800))--인구수 400 설정
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
		if TestMode==1 then
			if k~=15 then
				SetUpgradeInit(k,255)
			end
		else
			SetUpgradeInit(k,3)
		end
	end

	function TechAvailable(Player,TechID,Type)
		if TechID >= 0 and TechID <= 23 then
			PatchInsert(SetMemoryB(0x58CE24+(Player*24)+ TechID,SetTo,Type))--SC Tech 0~23
		else
			PatchInsert(SetMemoryB(0x58F050+(Player*20)+ TechID-24,SetTo,Type))--BW Tech 24~43
		end
	end
	
	

	for i = 0, 227 do
		local BTime = 10
		if i==106 or i==124 or i==125 then
			BTime = 10
		end
		SetUnitsDatX(i, {BuildTime=BTime,AdvFlag={0x4000,0x4000+0x20000+0x80000},StarEditFlag=0x1C7,DefType=0})
		--모든 유닛(딱딱이, 사용불가유닛 제외) 로보틱 부여, 크립, 파일런 필요X
	end

	for j,k in pairs({85,144,84,108,159,47,47}) do -- 비사용 유닛
		SetUnitsDatX(k, {Playerable=false})
	end
	for j, k in pairs({1,8,12,14,28,29}) do -- 비사용 마법
		for i = 0, 6 do
			TechAvailable(i,k,0)
		end
	end

	for i = 0, 116 do
		SetWeaponsDatX(i, {TargetFlag=0x020 + 1 + 2})
	end
	for j, k in pairs({6,27,28,50,51,54,84,103,100}) do -- 일방형 스플래시로 설정
		SetWeaponsDatX(k, {Splash=true})
	end
	for j,k in pairs({131,132,133,106,154,156,109,42,57}) do--서플공급량
		SetUnitsDatX(k,{SuppProv=250})
	end
	for j,k in pairs({131,132,133,106,154,156,109,162,124,143,144,146,125}) do -- 건설크기
		SetUnitsDatX(k, {BdDimX=1,BdDimY=1})
	end
	TBuildingArr = {106,107,108,109,110,111,112,113,114,115,116,117,118,120,122,123,124,125}
	PBuildingArr = {154,155,156,157,159,160,162,163,164,165,166,167,169,170,171,172}
	ZBuildingArr = {130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,146,149}
	for j, k in pairs(TBuildingArr) do
		SetUnitsDatX(k, {DefUpType=2})--건물 방업설정
	end
	for j, k in pairs(PBuildingArr) do
		SetUnitsDatX(k, {DefUpType=6})--건물 방업설정
	end
	for j, k in pairs(ZBuildingArr) do
		SetUnitsDatX(k, {DefUpType=4})--건물 방업설정
	end

	--Balance

	SetUnitsDatX(219, {AdvFlag={536870916, 0xFFFFFFFF},SizeL=1,SizeU=1,SizeR=1,SizeD=1,BdDimX=1,BdDimY=1,HumanInitAct=23,ComputerInitAct=23,AttackOrder=23,AttackMoveOrder=23,IdleOrder=23})--이펙트유닛
	SetUnitsDatX("Terran Missile Turret", {MinCost=75*10,SuppCost=10,HP=1500,GroundWeapon=29,AirWeapon=130})
	SetUnitsDatX("Terran Bunker", {SpaceProv=8})
	SetUnitsDatX("Terran SCV", {SpaceReq=2})
	SetWeaponsDatX(29, {DmgBase=20*10,DmgFactor=120,UpgradeType=8})-- Terran Missile Turret
	SetUnitsDatX("Zerg Creep Colony", {MinCost=75*10,SuppCost=10,HP=2500})
	SetUnitsDatX("Zerg Sunken Colony", {MinCost=50*10,SuppCost=10,HP=2000})
	SetWeaponsDatX(53, {DmgBase=40*10,DmgFactor=250,UpgradeType=11}) -- Zerg Sunken Colony
	SetWeaponsDatX(0, {DmgBase=35,DmgFactor=30}) --Terran Marine
	SetUnitsDatX("Terran Firebat", {MinCost=100,GasCost=50,SuppCost=2,HP=540})
	SetWeaponsDatX(25, {DmgBase=32,DmgFactor=25}) -- Terran Firebat
	SetUnitsDatX("Terran Ghost", {MinCost=50,GasCost=75*2,SuppCost=2,HP=60})
	SetWeaponsDatX(2, {DmgBase=100,DmgFactor=55}) --Terran Ghost
	SetWeaponsDatX(11, {DmgBase=160,DmgFactor=104}) --Terran Siege Tank
	SetWeaponsDatX(27, {DmgBase=80,DmgFactor=30,Cooldown=20}) --Terran Siege Tank Mode
	SetWeaponsDatX(4, {DmgBase=70,DmgFactor=65}) --Terran Vulture
	SetWeaponsDatX(7, {DmgBase=45,DmgFactor=45}) --Terran Goliath
	SetWeaponsDatX(16, {DmgBase=50,DmgFactor=40}) --Terran Wraith
	SetWeaponsDatX(34, {DmgBase=65535,TargetFlag=0x020 + 1 + 2+ 0x040}) --Irradiate
	SetWeaponsDatX(33, {DmgBase=65535,Splash={64,64,64},TargetFlag=0x020 + 1 + 2+ 0x040}) --EMP
	SetWeaponsDatX(19, {DmgBase=250,DmgFactor=130}) --Terran Battlecruiser
	SetUnitsDatX("Terran Valkyrie", {GroundWeapon=103})
	SetWeaponsDatX(103, {TargetFlag=0x020 + 1 + 2,DmgBase=12,DmgFactor=15}) --Terran Valkyrie

	
	SetWeaponsDatX(64, {DmgBase=33,DmgFactor=40}) --Protoss Zealot
	SetWeaponsDatX(66, {DmgBase=50,DmgFactor=75}) --Protoss Dragoon
	SetWeaponsDatX(84, {DmgBase=17500}) --PSI Storm
	SetWeaponsDatX(111, {DmgBase=100,DmgFactor=120}) --Protoss Dark Templar
	SetWeaponsDatX(70, {DmgBase=65,DmgFactor=35,RangeMax=110}) --Protoss Archon
	SetUnitsDatX("Protoss Reaver", {GroundWeapon=115,RClickAct=1,HumanInitAct=2,ComputerInitAct=2,AttackOrder=10,AttackMoveOrder=2,IdleOrder=2})
	SetWeaponsDatX(115, {RangeMax=32*8,DmgBase=37,DmgFactor=19,Splash={20,40,60},TargetFlag=0x020 + 1 + 2,ObjectNum=1,UpgradeType=35,IconType=314}) -- Protoss Reaver
	SetWeaponsDatX(73, {DmgBase=25,DmgFactor=55}) --Protoss Scout
	SetWeaponsDatX(79, {DmgBase=7,DmgFactor=20}) --Protoss Carrier
	SetWeaponsDatX(77, {DmgBase=35,DmgFactor=200}) --Protoss Arbiter
	SetUnitsDatX("Protoss Corsair", {GroundWeapon=100})
	SetWeaponsDatX(100, {DmgBase=7,DmgFactor=15,TargetFlag=0x020 + 1 + 2}) --Protoss Corsair
	SetUnitsDatX("Protoss Photon Cannon", {MinCost=150*3,SuppCost=3,HP=400,Shield=400})
	SetWeaponsDatX(81, {DmgBase=95,DmgFactor=54,UpgradeType=13}) -- Protoss Photon Cannon
	SetWeaponsDatX(80, {DmgBase=95,DmgFactor=54,UpgradeType=13}) -- Protoss Photon Cannon



	SetUnitsDatX("Zerg Zergling", {MinCost=200,GasCost=50,SuppCost=2,HP=350})
	SetWeaponsDatX(35, {DmgBase=50,DmgFactor=56}) -- Zerg Zergling
	SetWeaponsDatX(38, {DmgBase=38,DmgFactor=40}) -- Zerg Hydralisk
	SetWeaponsDatX(109, {DmgBase=60,DmgFactor=17,RangeMax=224}) -- Zerg Lurker
	SetWeaponsDatX(48, {DmgBase=28,DmgFactor=32}) -- Zerg Mutalisk
	SetWeaponsDatX(46, {DmgBase=70,DmgFactor=80}) -- Zerg Guardian
	SetUnitsDatX("Zerg Devourer", {GroundWeapon=104})
	SetWeaponsDatX(104, {DmgBase=200,DmgFactor=200,TargetFlag=0x020 + 1 + 2}) -- Zerg Devourer
	SetUnitsDatX("Zerg Defiler", {GroundWeapon=50})
	SetWeaponsDatX(50, {DmgBase=12,DmgFactor=25,TargetFlag=0x020 + 1 + 2,Splash={10,15,20}}) -- Zerg Defiler
	SetWeaponsDatX(39, {DmgBase=125,DmgFactor=170}) -- Zerg Ultralisk

	
	


	SetUnitsDatX(20, {Reqptr=2,isHero=true,RdySnd=421,HP=350,Shield=250,MinCost=25000,GasCost=15000,SuppCost=6,BuildTime=85})
	SetWeaponsDatX(1, {Cooldown=1,DmgBase=1250,DmgFactor=28,Splash={15,35,55}}) -- Jim Raynor
	SetWeaponGrp(1,173,416,963,231)
	PatchInsert(SetMemoryB(0x669E28+963, SetTo, 16)) --짐레이너 공격 할루시네이션으로
	SetUnitsDatX(10, {Reqptr=75,isHero=true,HP=560,Shield=750,MinCost=15000,GasCost=30000,SuppCost=10,BuildTime=85,SeekRange=5})
	SetWeaponsDatX(26, {Cooldown=1,DmgBase=650,DmgFactor=40,Splash={15,20,25},RangeMax=32*5,FlingyID=145,Behavior=1}) -- Gui Montag
	SetUnitsDatX(100, {Reqptr=8,isHero=true,RdySnd=229,HP=100,Shield=255,MinCost=10000,GasCost=40000,SuppCost=12,BuildTime=85,SeekRange=128})
	SetWeaponsDatX(116, {Cooldown=1,DmgBase=1200,DmgFactor=125,RangeMax=128*32}) -- Alexei Stukov
	SetUnitsDatX(19, {Reqptr=16,isHero=true,RdySnd=421,HP=300,Shield=450,MinCost=27000,GasCost=27000,SuppCost=8,BuildTime=85})
	SetWeaponsDatX(5, {Cooldown=1,DmgBase=670,DmgFactor=120}) --Jim Raynor Vulture
	SetUnitsDatX(13, {AdvFlag={0x20000004,0x20000004},SeekRange=7})
	SetWeaponsDatX(6, {DmgBase=0,DmgFactor=257,ObjectNum=2,UpgradeType=8,Splash={512,512,512}}) --Spider Mine

	
	SetUnitsDatX(23, {Reqptr=29,isHero=true,RdySnd=431,HP=400,Shield=256,MinCost=30000,GasCost=30000,SuppCost=15,BuildTime=85})
	SetUnitsDatX(25, {isHero=true,RdySnd=431,HP=400,Shield=256,MinCost=30000,GasCost=30000,SuppCost=15,BuildTime=85})
	SetWeaponsDatX(12, {Cooldown=1,DmgBase=800,DmgFactor=75,Splash={10,25,40},FlingyID=150,IconType=336}) --Edmund Duke Tank
	SetWeaponsDatX(28, {Cooldown=1,DmgBase=300,DmgFactor=35,Splash={64,96,128},IconType=311,WepName=258,RangeMin=0,Behavior=1,FlingyID=151}) --Edmund Duke SiegeMode
	--SetWeaponGrp(28,174,267,318,246)
	SetFlingySpeed(151,8533)--이엠피 탄환 속도 최대로
	SetUnitsDatX(17, {Reqptr=22,isHero=true,HP=1000,Shield=500,MinCost=60000,GasCost=60000,SuppCost=60,BuildTime=170,AdvFlag={0x00000080,0x00000080}})
	SetWeaponsDatX(9, {Cooldown=1,DmgBase=250,DmgFactor=100}) --Alan Schezar

	SetUnitsDatX(21, {Reqptr=43,isHero=true,MinCost=21000,GasCost=21000,SuppCost=4,BuildTime=85})
	SetWeaponsDatX(18, {Cooldown=1,DmgBase=5000,DmgFactor=120,Behavior=2}) --Tom Kazansky
	SetUnitsDatX(28, {Reqptr=66,isHero=true,RdySnd=421,MinCost=50000,GasCost=50000,SuppCost=30,BuildTime=85,SeekRange=9})
	SetWeaponsDatX(23, {Cooldown=1,DmgBase=250,DmgFactor=34,Splash={10,25,40},FlingyID=158,RangeMax=32*9,Behavior=9}) --Hyperion
	SetFlingySpeed(158,4800)--야마토 탄환 속도 
	PatchInsert(SetMemory(0x66EC48+(4*541), SetTo, 395))--야마토 럴커탄막으로
	
	




	--



	SetUnitsDatX(194, {BdDimX=1,BdDimY=1})--비콘
	SetUnitsDatX(195, {BdDimX=1,BdDimY=1})--비콘
	SetUnitsDatX(196, {BdDimX=1,BdDimY=1})--비콘



	SetZealotUnit(89,20,30,117,8,nil,1400,0) -- 1
	SetZealotUnit(90,1600,500,118,40,nil,2000,10) -- 100 
	SetZealotUnit(93,179000,3500,119,65,nil,2350,16) -- 10000
	SetZealotUnit(95,1280000,15000,120,120,nil,2700,13) -- 1000000
	SetZealotUnit(96,8320000,65535,121,255,nil,3500,15) -- 100000000
	SetUnitsDatX(nilunit, {StarEditFlag=0})--공백유닛,QC유닛처리
	SetUnitsDatX(84, {StarEditFlag=0})--공백유닛,QC유닛처리
	PatchInsertPrsv(SetMemoryW(0x660A70+(125*2),SetTo,287))--8벙
	
	PatchInsert(LeaderBoardScore(Custom,"Level"))
	PatchInsert(LeaderBoardComputerPlayers(Disable))

	DoActions2(FP,PatchArr,1)
	DoActions2(AllPlayers,PatchArrPrsv)
	CIfOnce(FP)
	NPA5(FP,0x6D5A30,FArr(TBLFile,0),TBLFiles)
	CDoActions(FP, {
		TSetMemory(0x5187EC, SetTo, FArr(btnptr0,0)),
		TSetMemory(0x5187E8, SetTo, 6),
		TSetMemory(0x518990, SetTo, FArr(btnptr35,0)),
		TSetMemory(0x51898C, SetTo, 9),
		TSetMemory(0x518AC8, SetTo, FArr(btnptr61,0)),
		TSetMemory(0x518AC4, SetTo, 5),
		TSetMemory(0x518B40, SetTo, FArr(btnptr71,0)),
		TSetMemory(0x518B3C, SetTo, 6),
		TSetMemory(0x518BB8, SetTo, FArr(btnptr81,0)),
		TSetMemory(0x518BB4, SetTo, 6),
		TSetMemory(0x518D20, SetTo, FArr(btnptr111,0)),
		TSetMemory(0x518D1C, SetTo, 14),
		TSetMemory(0x518D38, SetTo, FArr(btnptr113,0)),
		TSetMemory(0x518D34, SetTo, 15),
		TSetMemory(0x518D44, SetTo, FArr(btnptr114,0)),
		TSetMemory(0x518D40, SetTo, 15),
		TSetMemory(0x518E40, SetTo, FArr(btnptr135,0)),
		TSetMemory(0x518E3C, SetTo, 6),
		TSetMemory(0x518E4C, SetTo, FArr(btnptr136,0)),
		TSetMemory(0x518E48, SetTo, 6),
		TSetMemory(0x518E58, SetTo, FArr(btnptr137,0)),
		TSetMemory(0x518E54, SetTo, 5),
		TSetMemory(0x518E64, SetTo, FArr(btnptr138,0)),
		TSetMemory(0x518E60, SetTo, 6),
		TSetMemory(0x518E7C, SetTo, FArr(btnptr140,0)),
		TSetMemory(0x518E78, SetTo, 4),
		TSetMemory(0x518E88, SetTo, FArr(btnptr141,0)),
		TSetMemory(0x518E84, SetTo, 5),
		TSetMemory(0x518E94, SetTo, FArr(btnptr142,0)),
		TSetMemory(0x518E90, SetTo, 4),
		TSetMemory(0x518F30, SetTo, FArr(btnptr155,0)),
		TSetMemory(0x518F2C, SetTo, 7),
		TSetMemory(0x518F6C, SetTo, FArr(btnptr160,0)),
		TSetMemory(0x518F68, SetTo, 10),
		TSetMemory(0x518FC0, SetTo, FArr(btnptr167,0)),
		TSetMemory(0x518FBC, SetTo, 8)
	})
	for j,k in pairs({0,1,2,3,5,7,8,9,10,11,12,16,17,18,19,20,21,22,23,25,27,28,29,30,32,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,86,87,88,97,98,99,100,102,103,104}) do
		CallTrigger(FP,Call_UnitSizePatch,{SetV(UIndex,k*2)})
	end
	f_Read(FP, 0x512684, LocalPlayerV)
	CIfEnd()
end