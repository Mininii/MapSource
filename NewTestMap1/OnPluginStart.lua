function init()
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

	for j,k in pairs({144,84,108,159,47,47}) do -- 비사용 유닛
		SetUnitsDatX(k, {Playerable=false})
	end
	for j, k in pairs({1,8,12,14,18,28,29}) do -- 비사용 마법
		for i = 0, 6 do
			TechAvailable(i,k,0)
		end
	end

	for i = 0, 116 do
		SetWeaponsDatX(i, {TargetFlag=0x020 + 1 + 2+ 0x040})
	end
	for j, k in pairs({6,27,28,50,51,54,84,103,100}) do -- 일방형 스플래시로 설정
		SetWeaponsDatX(k, {Splash=true})
	end
	for j,k in pairs({131,132,133,106,154,156,109,42,57}) do--서플공급량
		SetUnitsDatX(k,{SuppProv=250})
	end
	for j,k in pairs({131,132,133,106,154,156,109,162,124,143,144,146,125}) do -- 건설크기
		local SuCo = 1
		if k == 109 or k == 156 then
			SuCo = 0
		end
		SetUnitsDatX(k, {BdDimX=1,BdDimY=1,SuppCost=SuCo})
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
	SetUnitsDatX("Terran Missile Turret", {MinCost=75*10,SuppCost=10,HP=1750,GroundWeapon=29,AirWeapon=130})
	SetUnitsDatX("Terran Bunker", {SpaceProv=8,HP=2000,MinCost=10000})
	SetUnitsDatX("Terran SCV", {SpaceReq=2})
	SetWeaponsDatX(29, {Cooldown=1,DmgBase=20*10,DmgFactor=120,UpgradeType=8,Behavior=2})-- Terran Missile Turret
	SetUnitsDatX("Zerg Creep Colony", {MinCost=75*10,SuppCost=10,HP=2000})
	SetUnitsDatX("Zerg Sunken Colony", {MinCost=50*10,SuppCost=10,HP=1500})
	SetWeaponsDatX(53, {DmgBase=65535,DmgFactor=0}) -- Zerg Sunken Colony
	SetWeaponsDatX(0, {DmgBase=35,DmgFactor=120}) --Terran Marine
	SetUnitsDatX("Terran Firebat", {MinCost=100,GasCost=50,SuppCost=2,HP=200})
	SetWeaponsDatX(25, {DmgBase=32,DmgFactor=80}) -- Terran Firebat
	SetUnitsDatX("Terran Ghost", {MinCost=50,GasCost=75*2,SuppCost=2,HP=60})
	SetWeaponsDatX(2, {DmgBase=100,DmgFactor=250}) --Terran Ghost
	SetWeaponsDatX(11, {DmgBase=160,DmgFactor=250}) --Terran Siege Tank
	SetWeaponsDatX(27, {DmgBase=80,DmgFactor=120,Cooldown=20}) --Terran Siege Tank Mode
	SetWeaponsDatX(4, {DmgBase=70,DmgFactor=190}) --Terran Vulture
	SetWeaponsDatX(7, {DmgBase=45,DmgFactor=140}) --Terran Goliath
	SetWeaponsDatX(16, {DmgBase=50,DmgFactor=100,ObjectNum=2}) --Terran Wraith
	SetWeaponsDatX(34, {DmgBase=65535}) --Irradiate
	SetWeaponsDatX(33, {DmgBase=65535,Splash={64,64,64}}) --EMP
	SetWeaponsDatX(19, {DmgBase=250,DmgFactor=256}) --Terran Battlecruiser
	SetUnitsDatX("Terran Valkyrie", {GroundWeapon=103})
	SetWeaponsDatX(103, {DmgBase=700,DmgFactor=65,Cooldown=15}) --Terran Valkyrie

	
	SetUnitsDatX("Protoss Zealot", {HP=120,Shield=100})
	SetWeaponsDatX(64, {DmgBase=500,DmgFactor=127}) --Protoss Zealot
	SetWeaponsDatX(66, {DmgBase=1000,DmgFactor=127,ObjectNum=2}) --Protoss Dragoon
	SetWeaponsDatX(84, {DmgBase=65535}) --PSI Storm
	SetWeaponsDatX(111, {DmgBase=1000,DmgFactor=250,Cooldown=1}) --Protoss Dark Templar
	SetUnitsDatX("Protoss Archon", {SeekRange=4})
	SetWeaponsDatX(70, {DmgBase=65,DmgFactor=95,ObjectNum=2,RangeMax=32*4}) --Protoss Archon
	SetUnitsDatX("Protoss Reaver", {GroundWeapon=115,RClickAct=1,HumanInitAct=2,ComputerInitAct=2,AttackOrder=10,AttackMoveOrder=2,IdleOrder=2})
	SetWeaponsDatX(115, {RangeMax=32*8,Cooldown=15,DmgBase=750,DmgFactor=130,Splash={20,40,60},ObjectNum=1,UpgradeType=35,IconType=314}) -- Protoss Reaver
	SetWeaponsDatX(73, {DmgBase=1200,DmgFactor=127,ObjectNum=2,Cooldown=1}) --Protoss Scout
	SetWeaponsDatX(77, {DmgBase=2000,DmgFactor=200,Cooldown=1}) --Protoss Arbiter
	SetUnitsDatX("Protoss Corsair", {GroundWeapon=100})
	SetWeaponsDatX(100, {DmgBase=500,DmgFactor=67}) --Protoss Corsair
	SetUnitsDatX("Protoss Photon Cannon", {MinCost=150*3,SuppCost=3,HP=350,Shield=250})
	SetWeaponsDatX(81, {DmgBase=10000,DmgFactor=127,ObjectNum=2,Cooldown=1,UpgradeType=13,Behavior=2}) -- Protoss Photon Cannon
	SetWeaponsDatX(80, {DmgBase=10000,DmgFactor=127,ObjectNum=2,Cooldown=1,UpgradeType=13,Behavior=2}) -- Protoss Photon Cannon



	SetUnitsDatX("Zerg Zergling", {MinCost=200,GasCost=50,SuppCost=2,HP=350})
	SetWeaponsDatX(35, {DmgBase=250,DmgFactor=256}) -- Zerg Zergling
	SetWeaponsDatX(38, {DmgBase=38,DmgFactor=127,ObjectNum=2}) -- Zerg Hydralisk
	SetWeaponsDatX(109, {DmgBase=60,DmgFactor=90,RangeMax=224,ObjectNum=2}) -- Zerg Lurker
	SetWeaponsDatX(48, {DmgBase=1000,DmgFactor=127,ObjectNum=2}) -- Zerg Mutalisk
	SetWeaponsDatX(46, {DmgBase=250,DmgFactor=127,ObjectNum=2,Splash={10,20,30}}) -- Zerg Guardian
	SetUnitsDatX("Zerg Devourer", {GroundWeapon=104})
	SetWeaponsDatX(104, {DmgBase=25000,DmgFactor=100,ObjectNum=2,Cooldown=1}) -- Zerg Devourer
	SetUnitsDatX("Zerg Defiler", {GroundWeapon=50,SeekRange=7})
	SetWeaponsDatX(50, {DmgBase=12,DmgFactor=127,ObjectNum=2,Splash={10,15,20},RangeMax=7*32}) -- Zerg Defiler
	SetWeaponsDatX(39, {DmgBase=30000,DmgFactor=127}) -- Zerg Ultralisk

	
	


	SetUnitsDatX(20, {Reqptr=2,isHero=true,RdySnd=421,HP=350,Shield=250,MinCost=25000,GasCost=15000,SuppCost=5,BuildTime=35})
	SetWeaponsDatX(1, {Cooldown=1,DmgBase=12700,DmgFactor=127,Splash={20,46,68},FlingyID=204,ObjectNum=2}) -- Jim Raynor--7틱
	--SetWeaponGrp(1,173,416,963,231)
	PatchInsert(SetMemoryB(0x669E28+963, SetTo, 16)) --짐레이너 공격 할루시네이션으로
	SetUnitsDatX(10, {Reqptr=75,isHero=true,HP=560,Shield=750,MinCost=15000,GasCost=30000,SuppCost=8,BuildTime=35,SeekRange=3})
	SetWeaponsDatX(26, {Cooldown=1,DmgBase=6500,DmgFactor=127,Splash={15,20,25},RangeMax=32*3,FlingyID=145,Behavior=1}) -- Gui Montag --3.33..틱
	SetUnitsDatX(100, {Reqptr=8,isHero=true,RdySnd=229,HP=100,Shield=255,MinCost=10000,GasCost=40000,SuppCost=10,BuildTime=35,SeekRange=128})
	SetWeaponsDatX(116, {Cooldown=1,DmgBase=32767,ObjectNum=2,DmgFactor=128,RangeMax=128*32}) -- Alexei Stukov -- 2틱
	SetUnitsDatX(19, {Reqptr=16,isHero=true,RdySnd=421,HP=300,Shield=450,MinCost=27000,GasCost=27000,SuppCost=12,BuildTime=35})
	SetWeaponsDatX(5, {Cooldown=1,DmgBase=32767,DmgFactor=127,ObjectNum=2}) --Jim Raynor Vulture
	SetUnitsDatX(13, {AdvFlag={0x20000004,0x20000004},SeekRange=9})
	SetWeaponsDatX(6, {DmgBase=65535,DmgFactor=0,ObjectNum=2,Splash={8192,8192,8192}}) --Spider Mine

	
	SetUnitsDatX(23, {Reqptr=29,isHero=true,RdySnd=431,HP=400,Shield=450,MinCost=30000,GasCost=30000,SuppCost=9,BuildTime=35})
	SetUnitsDatX(25, {isHero=true,RdySnd=431,HP=400,Shield=450,MinCost=30000,GasCost=30000,SuppCost=9,BuildTime=35})
	SetWeaponsDatX(12, {Cooldown=1,DmgBase=60000,DmgFactor=127,Splash={10,25,40},FlingyID=150,IconType=336,ObjectNum=2}) --Edmund Duke Tank -- 3틱
	SetWeaponsDatX(28, {Cooldown=1,DmgBase=20000,DmgFactor=100,Splash={96,128,192},IconType=241,WepName=259,RangeMin=0,Behavior=1,FlingyID=151,ObjectNum=2}) --Edmund Duke SiegeMode--4틱
	SetFlingySpeed(151,8533)--이엠피 탄환 속도 최대로
	SetUnitsDatX(17, {Reqptr=22,isHero=true,HP=250,Shield=1200,MinCost=30000,GasCost=60000,SuppCost=15,BuildTime=170,AdvFlag={0x00000080,0x00000080}})
	SetUnitsDatX(18, {isHero=true})
	SetWeaponsDatX(9, {Cooldown=1,DmgBase=32767,DmgFactor=128,ObjectNum=2}) --Alan Schezar -- 5틱 1/4 즉사

	SetUnitsDatX(21, {Reqptr=43,isHero=true,MinCost=21000,GasCost=21000,SuppCost=13,BuildTime=35})
	SetWeaponsDatX(18, {Cooldown=1,DmgBase=10000,ObjectNum=2,DmgFactor=120,Behavior=2,Splash={10,15,20}}) --Tom Kazansky -- 1틱
	SetUnitsDatX(28, {Reqptr=66,isHero=true,RdySnd=421,MinCost=50000,GasCost=50000,SuppCost=21,BuildTime=35,SeekRange=12})
	SetWeaponsDatX(23, {Cooldown=1,DmgBase=40000,ObjectNum=2,DmgFactor=127,Splash={40,40,40},FlingyID=158,RangeMax=32*12,Behavior=9}) --Hyperion
	SetFlingySpeed(158,4800)--야마토 탄환 속도 
	PatchInsert(SetMemory(0x66EC48+(4*541), SetTo, 395))--야마토 스크립트 럴커탄막으로



	
	SetUnitsDatX(77, {Reqptr=183,isHero=true,RdySnd=694,HP=500,Shield=4,MinCost=25000,GasCost=12500,SuppCost=5,BuildTime=35})
	SetWeaponsDatX(65, {Cooldown=1,DmgBase=32767,DmgFactor=128}) --Fenix Z -- 3.5틱 스플불가
	SetUnitsDatX(78, {Reqptr=187,isHero=true,RdySnd=682,HP=350,Shield=2,MinCost=30000,GasCost=25000,SuppCost=8,BuildTime=35})
	SetWeaponsDatX(67, {Cooldown=1,ObjectNum=2,DmgBase=35000,DmgFactor=127,Splash={5,10,15},Behavior=8}) --Fenix D  -- 3틱
	SetUnitsDatX(79, {Reqptr=192,isHero=true,RdySnd=715,HP=250,Shield=2,MinCost=10000,GasCost=35000,SuppCost=10,BuildTime=35,SeekRange=9})
	SetWeaponsDatX(69, {Cooldown=1,DmgBase=8500,DmgFactor=120,ObjectNum=2,Splash={10,20,30},RangeMax=9*32}) --Tassadar -- 5틱
	SetUnitsDatX(75, {Reqptr=246,isHero=true,RdySnd=744,HP=800,Shield=3,MinCost=25000,GasCost=40000,SuppCost=25,BuildTime=35,SeekRange=7})
	SetWeaponsDatX(85, {DmgBase=65535,DmgFactor=0,RangeMax=7*32}) --Zeratul -- 10틱 즉사
	SetUnitsDatX(81, {Reqptr=223,isHero=true,HP=250,Shield=3,MinCost=35000,GasCost=35000,SuppCost=30,BuildTime=35,AdvFlag={4+0x20000000 ,4+0x20000000 }})
	SetUnitsDatX(85, {AdvFlag={4,4}})
	SetWeaponsDatX(82, {DmgBase=2500,DmgFactor=120,Splash={64,96,128}}) --Warbringer Scarab -- 1틱
	--SetUnitsDatX(76, {Reqptr=223,isHero=true,HP=350,Shield=6,MinCost=25000,GasCost=50000,SuppCost=10,BuildTime=35})
	SetUnitsDatX(63, {Reqptr=223,SeekRange=5,isHero=true,HP=600,Shield=6,MinCost=45000,GasCost=45000,SuppCost=25,BuildTime=35,GroundWeapon=71,RClickAct=1,HumanInitAct=2,ComputerInitAct=2,AttackOrder=10,AttackMoveOrder=2,IdleOrder=2})
	SetWeaponsDatX(71, {Cooldown=1,ObjectNum=2,DmgBase=27000,DmgFactor=127,RangeMax=5*32,Splash={30,30,30}}) --Tassadar/Zeratul -- 2틱
	
	SetUnitsDatX(88, {Reqptr=201,isHero=true,RdySnd=1130,MinCost=30000,GasCost=30000,SuppCost=10,BuildTime=35,AirWeapon=114})
	SetWeaponsDatX(114, {Cooldown=1,DmgBase=15000,DmgFactor=120,Splash={10,20,30},ObjectNum=2}) --Artanis -- 5틱
	SetWeaponGrp(114,174,132,4,231)
	PatchInsert(SetMemoryB(0x669E28+4, SetTo, 16)) --알타 공격 할루시네이션으로

	SetUnitsDatX(82, {Reqptr=210,isHero=true,RdySnd=703,MinCost=60000,GasCost=60000,SuppCost=25,BuildTime=35})
	SetUnitsDatX(73, {isHero=true,RClickAct=1,HumanInitAct=2,ComputerInitAct=2,AttackOrder=10,AttackMoveOrder=2,IdleOrder=2})
	SetWeaponsDatX(79, {Cooldown=1,DmgBase=7500,DmgFactor=85,Splash={7,14,20}}) --Gantrithor Interceptor -- 2틱*8 = 0.25틱

	PatchInsert(SetMemory(0x66EC48+(4*522), SetTo, 247))--펄스캐논 스크립트 야마토건으로



	SetUnitsDatX(54, {Reqptr=106,isHero=true,HP=750,Shield=400,MinCost=7500,GasCost=7500,SuppCost=4,BuildTime=35})
	SetWeaponsDatX(36, {Cooldown=1,DmgBase=32767,DmgFactor=127}) --Devouring One -- 5틱 스플불가
	SetUnitsDatX(53, {Reqptr=111,isHero=true,HP=250,Shield=500,MinCost=40000,GasCost=21000,SuppCost=10,BuildTime=35})
	SetWeaponsDatX(39, {Cooldown=1,ObjectNum=2,DmgBase=230,DmgFactor=65,Splash={35,35,35},FlingyID=203,Behavior=9,WepName=1239,IconType=382,RangeMax=224}) --Hunter Killer 3틱
	
	SetUnitsDatX(55, {Reqptr=129,isHero=true,MinCost=25000,GasCost=25000,SuppCost=10,BuildTime=35})
	SetWeaponsDatX(49, {Cooldown=1,ObjectNum=2,DmgBase=32767,DmgFactor=127}) --Kukulza M -- 1틱
	SetUnitsDatX(56, {Reqptr=129,isHero=true,MinCost=40000,GasCost=40000,SuppCost=20,BuildTime=35})
	SetWeaponsDatX(47, {Cooldown=1,DmgBase=9000,DmgFactor=90,Splash={5,10,15}}) --Kukulza G -- 1틱
	SetUnitsDatX(52, {Reqptr=147,isHero=true,HP=150,Shield=500,MinCost=35000,GasCost=35000,SuppCost=20,BuildTime=35,SeekRange=7,GroundWeapon=51})
	SetWeaponsDatX(51, {Cooldown=1,DmgBase=3500,DmgFactor=127,FlingyID=168,Behavior=2,Splash={20,40,60},RangeMax=7*32}) --Unclean One -- 1틱
	SetUnitsDatX(48, {Reqptr=116,isHero=true,HP=700,Shield=500,MinCost=30000,GasCost=60000,SuppCost=20,BuildTime=170,SeekRange=6})
	SetWeaponsDatX(41, {DmgBase=65535,DmgFactor=0,RangeMax=32*6}) --Torrasque -- 15틱 즉사
	PatchInsert2(SetMemoryB(0x65FEC8 + 48,SetTo,255)) -- Armor
	--SetWeaponGrp(51,175,132,4,231)


	

	SetUnitsDatX(94, {Graphic=50,SizeL=1,SizeU=1,SizeR=1,SizeD=1})


	



	SetUnitsDatX(194, {BdDimX=1,BdDimY=1})--비콘
	SetUnitsDatX(195, {BdDimX=1,BdDimY=1})--비콘
	SetUnitsDatX(196, {BdDimX=1,BdDimY=1})--비콘



	SetUnitsDatX(nilunit, {StarEditFlag=0})--공백유닛,QC유닛처리
	SetUnitsDatX(84, {StarEditFlag=0})--공백유닛,QC유닛처리
	PatchInsertPrsv(SetMemoryW(0x660A70+(125*2),SetTo,287))--8벙
	
	PatchInsert(LeaderBoardScore(Custom,"Level"))
	PatchInsert(LeaderBoardComputerPlayers(Disable))

	DoActions2(FP,PatchArr,1)
	DoActions2(FP,PatchArr2,1)
	DoActions2(AllPlayers,PatchArrPrsv)
	CIfOnce(FP)
	NPA5(FP,0x6D5A30,FArr(TBLFile,0),TBLFiles)
	DoActions(FP, {
		SetMinimapColor(P8, SetTo, 128),
		SetPlayerColor(P8, SetTo, 128),
	})	


	CDoActions(FP, {
		TSetMemory(0x518990, SetTo, btnptr35),
		TSetMemory(0x51898C, SetTo, 9),
		TSetMemory(0x5189F0, SetTo, btnptr43),
		TSetMemory(0x5189EC, SetTo, 7),
		TSetMemory(0x518A14, SetTo, btnptr46),
		TSetMemory(0x518A10, SetTo, 7),
		TSetMemory(0x518A5C, SetTo, btnptr52),
		TSetMemory(0x518A58, SetTo, 7),
		TSetMemory(0x518AC8, SetTo, btnptr61),
		TSetMemory(0x518AC4, SetTo, 5),
		TSetMemory(0x518AE0, SetTo, btnptr63),
		TSetMemory(0x518ADC, SetTo, 8),
		TSetMemory(0x518B40, SetTo, btnptr71),
		TSetMemory(0x518B3C, SetTo, 6),
		TSetMemory(0x518BD0, SetTo, btnptr83),
		TSetMemory(0x518BCC, SetTo, 5),
		TSetMemory(0x518D20, SetTo, btnptr111),
		TSetMemory(0x518D1C, SetTo, 14),
		TSetMemory(0x518D38, SetTo, btnptr113),
		TSetMemory(0x518D34, SetTo, 15),
		TSetMemory(0x518D44, SetTo, btnptr114),
		TSetMemory(0x518D40, SetTo, 14),
		TSetMemory(0x518D8C, SetTo, btnptr120),
		TSetMemory(0x518D88, SetTo, 5),
		TSetMemory(0x518F30, SetTo, btnptr155),
		TSetMemory(0x518F2C, SetTo, 7),
		TSetMemory(0x518F6C, SetTo, btnptr160),
		TSetMemory(0x518F68, SetTo, 10),
		TSetMemory(0x518FA8, SetTo, btnptr165),
		TSetMemory(0x518FA4, SetTo, 6),
		TSetMemory(0x518FC0, SetTo, btnptr167),
		TSetMemory(0x518FBC, SetTo, 8),
		TSetMemory(0x518FD8, SetTo, btnptr169),
		TSetMemory(0x518FD4, SetTo, 6),
		TSetMemory(0x518FE4, SetTo, btnptr170),
		TSetMemory(0x518FE0, SetTo, 4),
		TSetMemory(0x519158, SetTo, btnptr201),
		TSetMemory(0x519154, SetTo, 7),
        TSetMemory(0x518B58, SetTo, btnptr73),
        TSetMemory(0x518B54, SetTo, 5),

	})
	for j,k in pairs({0,1,2,3,5,7,8,9,10,11,12,16,17,18,19,20,21,22,23,25,27,28,29,30,32,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,86,87,88,97,98,99,100,102,103,104}) do
		CallTrigger(FP,Call_UnitSizePatch,{SetV(UIndex,k*2)})
	end
	f_Read(FP, 0x512684, LocalPlayerV)
	f_GetTblptr(FP,iTbl1[1],iTbl1[2]) 
	f_InitiTblptr(FP,iTbl1[1],iTbl1[1],iTbl1[3],iTbl1[2])

	


	CIfEnd()
end