function onInit_EUD()

	Shape8126 = {{496, 2176},{1520, 5792}}
	Shape8116 = {{1792, 5840},{1216, 5712},{1504, 6096}}
	Shape8122 = {{224, 1680},{1088, 1936},{928, 2448},{320, 2416},{608, 2960},{256, 2736},{576, 6416},{192, 5296},{608, 5840}}
	Shape8127 = {{240, 3008},{1968, 6912},{944, 6400}}
	Shape8174 = {{400, 5488},{1744, 2384}}
    Shape8131 = {{1024, 688},{448, 1296},{1664, 880},{1664, 1296},{448, 848},{1280, 7472},{1024, 7760},{544, 7536}}
	Shape8132 = {{160, 752},{1888, 752},{672, 304},{1376, 304},{1088, 6992},{704, 7312},{1664, 7312},{384, 7120}}
	Shape8133 = {{256,400},{1760, 400},{1920, 7696},{1728, 7760},{1536, 7824},{1344, 7888},{128, 7696},{320, 7760},{512, 7824},{704, 7888}}
	Shape8106 = {{1024, 5968},{1920, 6128},{1376, 5424},{224, 6896},{256, 7376},{1600, 6896},{1440, 1680}}
	Shape8113 = {{608, 2064},{160, 2064},{640, 1712},{640, 2640},{128, 3280}}
	Shape8114 = {{1792, 5392},{1280, 6320},{768, 5584}}
	Shape8147 = {{1936, 8016}}
	Shape8150 = {{1824, 4800},{1504, 4960},{1184, 4800},{1504, 4640},{1184, 5120},{1184, 4480},{864, 5280},{544, 5120},{864, 4960},{224, 4960},{544, 4800},{864, 4640},{224, 4640},{544, 4480},{864, 4320},{224, 4320},{544, 4160}}
	Shape8151 = {{64, 48},{1984, 48}}
	Shape8152 = {{1024, 48},{1008, 8032}}
	Shape8154 = {{1376, 3728},{1440, 2480}}
	Shape8160 = {{1760, 3312},{1824, 2576},{1088, 2896},{1792, 1680}}
	Shape8167 = {{1792, 4112},{1440, 2832},{1632, 2128}}
	Shape8168 = {{288, 3792}}
	Shape8175 = {{144, 8000}}
	Shape8190 = {{1776, 3728}}
	Shape8200 = {{1888, 2928},{96, 4112},{1024, 7568}}
	Shape8201 = {{688, 3776}}
	Shape8148 = {{1136,7280},{1024,368}}
	BuildPlaceArr = {
		{0,131,380000,65535},
		{0,132,380000,65535},
		{0,133,380000,65535},
		{0,126,3500000,65535},
		{0,116,1000000,65535},
		{0,122,1000000,65535},
		{0,130,1000000,65535},
		{0,127,3500000,65535},
		{0,174,3500000,65535},
		{0,106,1000000,65535},
		{0,113,1000000,65535},
		{0,114,1000000,65535},
		{0,147,6500000,65535},
		{0,150,15000,15000},
		{0,151,650000,65535},
		{0,152,6500000,65535},
		{0,154,1000000,65535},
		{0,160,1000000,65535},
		{0,167,1000000,65535},
		{0,168,650000,65535},
		{0,175,6500000,65535},
		{0,190,6500000,65535},
		{0,200,1000000,65535},
		{0,201,650000,65535},
		{0,148,1000000,65535}
	}
	UnitRepIndex2 = CreateVar(FP)
	CIfOnce(FP,{ElapsedTime(AtLeast, 3)}) --AfterOnPluginExec
	local AfterPatchExec = {}
	local NonClockArr = {131,132,133,113,114,116,160,167}
	for j,k in pairs(BuildPlaceArr) do
		local BID = k[2]
		PatchInsert(SetMemoryB(0x57F27C + (5 * 228) + BID,SetTo,0))
		PatchInsert(SetMemoryB(0x57F27C + (6 * 228) + BID,SetTo,0))
		PatchInsert(SetMemoryB(0x57F27C + (7 * 228) + BID,SetTo,0))
		SetUnitsDatX(BID,{HP=k[3],Shield=k[4],AdvFlag={0,0x80000}})
		table.insert(AfterPatchExec,SetMemoryX(0x664080 + (BID*4),SetTo,0,0x8000))
		--table.insert(AfterPatchExec,SetMemoryB(0x6637A0+(BID),SetTo,0xA))
		--if BID~=131 and BID~=132 and BID~=133 then
		--table.insert(AfterPatchExec,SetMemoryX(0x664080 + (BID*4),SetTo,0,1))
		--end
		


	end
	--for j,k in pairs(NonClockArr) do
	--	SetUnitsDatX(k,{SightRange = 0})
	--end
	RepPlayerID = CreateVar(FP)
	CunitHP = CreateVar(FP)
	CWhile(FP, {CV(UnitRepIndex,1,AtLeast)})
	f_Read(FP, ArrX(UnitPosArr,UnitRepIndex2), CPos)
	f_Read(FP, ArrX(UnitHPArr,UnitRepIndex2), CunitHP)
	f_Read(FP, ArrX(UnitIDArr,UnitRepIndex2), RepHeroIndex)
	f_Read(FP, ArrX(PlayerIDArr,UnitRepIndex2), RepPlayerID)
	Convert_CPosXY()
	Simple_SetLocX(FP, 0, CPosX, CPosY, CPosX, CPosY)
	
	DoActions(FP, {
		SetMemoryB(0x6644F8+4,SetTo,158),
		SetMemoryB(0x6644F8+6,SetTo,200),
		SetMemoryB(0x6C9858+158,SetTo,2),
		SetMemory(0x66EC48+(541*4), SetTo, 91),
		SetMemory(0x66EC48+(956*4), SetTo, 91),
	})


	CIf(FP,{Memory(0x628438, AtLeast, 1)})
	f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
	CMov(FP,CunitIndex,_Div(_Sub(Nextptrs,19025),_Mov(84)))
	CDoActions(FP, {
		TSetMemory(_Add(RepHeroIndex,EPDF(0x662860)) ,SetTo,1+65536),
		TCreateUnit(1, RepHeroIndex, 1, RepPlayerID),
		TSetMemoryX(_Add(Nextptrs,9),SetTo,0,0xFF0000),
		Set_EXCC2(DUnitCalc,CunitIndex,1,SetTo,1),
		Set_EXCC2(DUnitCalc,CunitIndex,2,SetTo,CunitHP),
	})
	CIfEnd()
	condbox = {}
	for j,k in pairs(BuildPlaceArr) do
		table.insert(condbox,CV(RepHeroIndex,k[2]))
	end
	CIf(FP,CV(RepHeroIndex,150),{AddCD(ChryCcode,1)})
	
		CMov(FP, ArrX(OverMePosX,CunitHP), CPosX)
		CMov(FP, ArrX(OverMePosY,CunitHP), CPosY)

	CIfEnd()
	
	CIf(FP,{CV(RepHeroIndex,133),CV(CunitHP,3,AtLeast),CV(CunitHP,12,AtMost)},{})
	CDoActions(FP, {
		TSetMemoryX(_Add(Nextptrs,55),SetTo,0xB00,0xB00),
		TSetMemoryX(_Add(Nextptrs,57),SetTo,0,0xFFFFFFFF),
		TSetMemoryX(_Add(Nextptrs,37),SetTo,0,0xFF0000),})
	

	CIfEnd()
	
	CTrigger(FP,{CV(RepHeroIndex,201)},{TSetMemoryX(_Add(Nextptrs,55),SetTo,0x04000000,0x04000000)},{preserved})--오버미코쿤 무적

	CIf(FP,{TTOR(condbox)},{AddCD(GunCcode,1)})--블라인드 맥일놈들(건작일경우)
		CDoActions(FP, {TSetMemoryX(_Add(Nextptrs,72), SetTo, 0xFF000000, 0xFF000000)})
	CIfEnd()
	DoActions(FP, {
		SetMemoryB(0x6644F8+4,SetTo,76),
		SetMemoryB(0x6644F8+6,SetTo,83),
		SetMemoryB(0x6C9858+158,SetTo,0),
		SetMemory(0x66EC48+(956*4), SetTo, 377),
		SetMemory(0x66EC48+(541*4), SetTo, 247),
	})
	CAdd(FP,UnitRepIndex2,1)
	CSub(FP,UnitRepIndex,1)
	CWhileEnd()
	

	
	DoActions2X(FP, AfterPatchExec,1)
	CIfEnd()
	if DLC_Project == 1 then
		for i = 0, 4 do
			
			PatchInsert(SetMemoryB(0x58D088 + 17+(i*46),SetTo,24))
			PatchInsert(SetMemoryB(0x58D088 + 21+(i*46),SetTo,9))
			PatchInsert(SetMemoryB(0x58D088 + 22+(i*46),SetTo,5))
			PatchInsert(SetMemoryB(0x58D088 + 23+(i*46),SetTo,3))
			--PatchInsert(SetMemoryB(0x58D088 + 43+(i*46),SetTo,1))
			PatchInsert(SetMemoryB(0x58D088 + 43+(i*46),SetTo,0))
			PatchInsert(SetMemoryB(0x58D2B0 + 17+(i*46),SetTo,0))
			PatchInsert(SetMemoryB(0x58D2B0 + 21+(i*46),SetTo,0))
			PatchInsert(SetMemoryB(0x58D2B0 + 22+(i*46),SetTo,0))
			PatchInsert(SetMemoryB(0x58D2B0 + 23+(i*46),SetTo,0))
			PatchInsert(SetMemoryB(0x58D2B0 + 43+(i*46),SetTo,0))
		end
	end

	for i = 0, 227 do
	SetUnitsDatX(i,{AdvFlag={0x200000,0x200000},Armor=0})--모든 유닛을 마법사로, 아머를 0으로
	end
	--SetUnitsDatX(130,{GroupFlag=0x11})--그룹플래그
	--SetUnitsDatX(131,{GroupFlag=0x11})--그룹플래그
	--SetUnitsDatX(132,{GroupFlag=0x11})--그룹플래그
	--SetUnitsDatX(133,{GroupFlag=0x11})--그룹플래그
	SetUnitsDatX(162,{AdvFlag={0x400200,0x480200},BdDimX=1,BdDimY=1})--포토 파일런 불필요
	for j,k in pairs({89,90,93,94,95,96}) do
		SetUnitsDatX(k, {HumanInitAct = 2,
		ComputerInitAct = 2,
		AttackOrder = 10,
		AttackMoveOrder = 2,
		IdleOrder = 2,
		RClickAct = 1,SizeL=3,SizeU=3,SizeR=3,SizeD=3})
		
	end

	--if TestStart == 1 then
	--	SetUnitsDatX(0,{HP=9999})--테스트
	--	SetUnitsDatX(20,{HP=9999})--테스트
	--	SetWeaponsDatX(0, {DmgBase=1000})--테스트
	--	SetWeaponsDatX(1, {DmgBase=2000})--테스트
	--end
	SetUnitsDatX(84,{SizeL = 1, SizeU = 1, SizeR = 1, SizeD = 1})--이펙트유닛 크기 1로 조정
	SetUnitsDatX(72,{SizeL = 1, SizeU = 1, SizeR = 1, SizeD = 1})--이펙트유닛 크기 1로 조정
	SetUnitsDatX(1,{SizeL = 1, SizeU = 1, SizeR = 1, SizeD = 1,})--이펙트유닛 크기 1로 조정

	for i = 0, 227 do
		SetUnitsDatX(i,{AdvFlag={0,0x4000}})--모든유닛 로보틱 제거
	end
	SetUnitsDatX(38, {BuildTime=15})
	SetUnitsDatX(37, {BuildTime=15})
	SetUnitsDatX(39, {BuildTime=15})
	SetUnitsDatX(43, {BuildTime=15})
	SetUnitsDatX(44, {BuildTime=15})


	if TestStart == 1 then--배속조정기능 테스트모드 한정w
		SetUnitsDatX(63,{Playerable = 2, Reqptr=5,SuppCost=0,MinCost=0,GasCost=0,BuildTime=1})--배속 조정 유닛
		SetUnitsDatX(62,{Playerable = 2, Reqptr=5,SuppCost=0,MinCost=0,GasCost=0,BuildTime=1})--배속 조정 유닛
	end
	SetUnitsDatX(74,{Playerable = 2, Reqptr=5,SuppCost=0,MinCost=0,GasCost=0,BuildTime=1})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(32,{Playerable = 2, Reqptr=5,SuppCost=1})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(12,{Playerable = 2, Reqptr=5,SuppCost=0,MinCost=0,GasCost=0,BuildTime=1})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(20,{Playerable = 2, Reqptr=5,SuppCost=1})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(5,{Playerable = 2, Reqptr=5,MinCost=0,GasCost=0})--플레이어만 사용가능, 요구조건을 무조건?으로
	if DLC_Project == 1 then
		if X4_Mode == 1 then
			SetUnitsDatX(125,{Playerable = 2, HP=167772,MinCost=2000,BuildTime=15,Reqptr=271,AdvFlag={0x4000+0x8000,0x4000+0x8000}})--플레이어만 사용가능, 요구조건을 무조건?으로
		else
			SetUnitsDatX(125,{Playerable = 2, HP=45000,MinCost=2000,BuildTime=15,Reqptr=271,AdvFlag={0x4000+0x8000,0x4000+0x8000}})--플레이어만 사용가능, 요구조건을 무조건?으로
		end
		SetUnitsDatX(32,{SizeL = 8, SizeU = 7, SizeR = 4, SizeD = 11,Class=17,HP=3000,MinCost=0,SuppCost=1,AdvFlag={0x4000,0x4000},SeekRange=6})--플레이어만 사용가능, 요구조건을 무조건?으로
		SetUnitsDatX(20,{SizeL = 8, SizeU = 7, SizeR = 4, SizeD = 11,Class=17,HP=6000,Shield = 3000,SuppCost=1,MinCost=0,AdvFlag={0x4000,0x4000},SeekRange=7})--플레이어만 사용가능, 요구조건을 무조건?으로
		SetUnitsDatX(10,{SizeL = 8, SizeU = 7, SizeR = 4, SizeD = 11,Class=94,HP=15000,Shield = 15000,MinCost=0,SuppCost=1,AdvFlag={0x4000,0x4000}})--플레이어만 사용가능, 요구조건을 무조건?으로
		for i =0,4 do
			SetUnitsDatX(MarID[i+1],{SizeL = 8, SizeU = 7, SizeR = 4, SizeD = 11,Class=94,HP=20000,Shield=20000,SuppCost=1,MinCost=0,AdvFlag={0x4000+0x8000,0x4000+0x8000}})--플레이어만 사용가능, 요구조건을 무조건?으로
		end
		SetWeaponsDatX(0, {TargetFlag = 0x020 + 1 + 2,DamageType=3,RangeMax = 6*32,DmgBase = NMBaseAtk,DmgFactor=NMFactorAtk,ObjectNum = 2})--파벳 베이스 : 투사체를 두개로
		if X4_Mode == 1 then
			SetWeaponsDatX(1, {TargetFlag = 0x020 + 1 + 2,DamageType=3,RangeMax = 7*32,DmgBase = HMBaseAtk,DmgFactor=HMFactorAtk,Splash={5,10,15}})
		else
			SetWeaponsDatX(1, {TargetFlag = 0x020 + 1 + 2,DamageType=3,RangeMax = 7*32,DmgBase = HMBaseAtk,DmgFactor=HMFactorAtk})
		end
		SetWeaponsDatX(2, {TargetFlag = 0x020 + 1 + 2,DamageType=3,RangeMax = 7*32,DmgBase = SMBaseAtk,DmgFactor=SMFactorAtk,ObjectNum = 2,Splash={3,5,7}})--파벳 베이스 : 투사체를 두개로
		SetWeaponsDatX(3, {TargetFlag = 0x020 + 1 + 2,DamageType=3,RangeMax = 7*32,DmgBase = RMBaseAtk,DmgFactor=RMFactorAtk,Splash={20,40,60}})
		SetUnitsDatX(82,{Playerable = 2, Reqptr=5,SuppCost=1,MinCost=NMCost,GasCost=0,BuildTime=1})--바로뽑기. 리스펙트처럼 노말일경우 스마, 하드일경우 영마두개
		SetUnitsDatX(8,{Playerable = 2, Reqptr=5,SuppCost=1,MinCost=NMCost+HMCost,GasCost=0,BuildTime=1})--바로뽑기. 리스펙트처럼 노말일경우 스마, 하드일경우 영마두개
		SetUnitsDatX(7,{Playerable = 2, Reqptr=5,SuppCost=1,MinCost=0,GasCost=0,BuildTime=1})--플레이어만 사용가능, 요구조건을 무조건?으로
		SetWeaponsDatX(119, {TargetFlag = 0x020	 + 1 + 2 + 0x10,DamageType=3,RangeMax = 7*32,DmgBase = SMSkillBaseAtk,DmgFactor=SMSkillFactorAtk,Splash={3,3,3}})
		SetWeaponsDatX(120, {TargetFlag = 0x020 + 1 + 2,DamageType=3,RangeMax = 7*32,DmgBase = RMSkillBaseAtk,DmgFactor=RMSkillFactorAtk})
		SetWeaponsDatX(121, {TargetFlag = 0x020 + 1 + 2 + 0x10,DamageType=3,RangeMax = 7*32,DmgBase = SMSkillBaseAtk2,DmgFactor=SMSkillFactorAtk2,Splash={5,10,15}})
		SetWeaponsDatX(122, {TargetFlag = 0x020 + 1 + 2 + 0x10,DamageType=3,RangeMax = 7*32,DmgBase = SMSkillBaseAtk3,DmgFactor=SMSkillFactorAtk3,Splash={10,20,30}})
		








	else
		SetUnitsDatX(125,{Playerable = 2, HP=9000,MinCost=2000,BuildTime=15,Reqptr=271,AdvFlag={0x4000+0x8000,0x4000+0x8000}})--플레이어만 사용가능, 요구조건을 무조건?으로
		SetUnitsDatX(32,{SizeL = 8, SizeU = 7, SizeR = 4, SizeD = 11,Class=17,HP=1500,MinCost=0,SuppCost=1,AdvFlag={0x4000,0x4000}})--플레이어만 사용가능, 요구조건을 무조건?으로
		SetUnitsDatX(20,{SizeL = 8, SizeU = 7, SizeR = 4, SizeD = 11,Class=17,HP=3000,Shield = 1000,SuppCost=1,MinCost=0,AdvFlag={0x4000,0x4000}})--플레이어만 사용가능, 요구조건을 무조건?으로
		SetUnitsDatX(10,{SizeL = 8, SizeU = 7, SizeR = 4, SizeD = 11,Class=17,HP=6000,MinCost=0,SuppCost=1,AdvFlag={0x4000,0x4000}})--플레이어만 사용가능, 요구조건을 무조건?으로
		for i =0,4 do
			SetUnitsDatX(MarID[i+1],{SizeL = 8, SizeU = 7, SizeR = 4, SizeD = 11,Class=17,HP=5000,Shield=2500,SuppCost=1,MinCost=0,AdvFlag={0x4000+0x8000,0x4000+0x8000}})--플레이어만 사용가능, 요구조건을 무조건?으로
		end
		SetWeaponsDatX(0, {TargetFlag = 0x020 + 1 + 2,DamageType=3,RangeMax = 5*32,DmgBase = NMBaseAtk,DmgFactor=NMFactorAtk,ObjectNum = 2})--파벳 베이스 : 투사체를 두개로
		SetWeaponsDatX(1, {TargetFlag = 0x020 + 1 + 2,DamageType=3,RangeMax = 6*32,DmgBase = HMBaseAtk,DmgFactor=HMFactorAtk})
		SetWeaponsDatX(2, {TargetFlag = 0x020 + 1 + 2,DamageType=3,RangeMax = 7*32,DmgBase = SMBaseAtk,DmgFactor=SMFactorAtk,ObjectNum = 2})--파벳 베이스 : 투사체를 두개로
		SetWeaponsDatX(3, {TargetFlag = 0x020 + 1 + 2,DamageType=3,RangeMax = 7*32,DmgBase = RMBaseAtk,DmgFactor=RMFactorAtk,Splash={10,20,30}})
		SetUnitsDatX(82,{Playerable = 2, Reqptr=5,SuppCost=1,MinCost=NMCost,GasCost=0,BuildTime=1})--바로뽑기. 리스펙트처럼 노말일경우 스마, 하드일경우 영마두개
		SetUnitsDatX(8,{Playerable = 2, Reqptr=5,SuppCost=1,MinCost=NMCost+HMCost+SMCost,GasCost=0,BuildTime=1})--바로뽑기. 리스펙트처럼 노말일경우 스마, 하드일경우 영마두개
		SetUnitsDatX(7,{Playerable = 2, Reqptr=5,SuppCost=1,MinCost=NMCost+HMCost+SMCost+RMCost,GasCost=0,BuildTime=1})--플레이어만 사용가능, 요구조건을 무조건?으로
	end
	SetUnitsDatX(0,{Playerable = 2, Reqptr=5,SuppCost=1,BuildTime=1})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(1,{Playerable = 2, Reqptr=5,SuppCost=1})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(19,{Playerable = 2, Reqptr=5,SuppCost=0,MinCost=60000,GasCost=0,BuildTime=1})--별의 보호막?
	SetUnitsDatX(109,{HP=500,MinCost=500,BuildTime=15,AdvFlag={0x8000,0x8000}})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(124,{HP=1500,MinCost=1000,BuildTime=15,AdvFlag={0x8000,0x8000}})--플레이어만 사용가능, 요구조건을 무조건?으로

	SetUnitsDatX(72,{Playerable = 2, Reqptr=5,SuppCost=0,MinCost=0,GasCost=0,BuildTime=1})--플레이어만 사용가능, 요구조건을 무조건?으로
	for j,k in pairs(MedicTrig) do
		SetUnitsDatX(k,{Playerable = 2, Reqptr=5, MinCost=150+((j-1)*50),GasCost=0,BuildTime = MedicTick[j],SuppCost = 0,RdySnd=999})--플레이어만 사용가능, 요구조건을 무조건?으로
	end
	for j,k in pairs(GiveUnitID) do
		SetUnitsDatX(k,{Playerable = 2, Reqptr=5, MinCost=0,GasCost=0,BuildTime = 1,SuppCost = 0})--플레이어만 사용가능, 요구조건을 무조건?으로
		table.insert(PatchArr,SetMemoryB(0x57F27C + ((j-1) * 228) + k,SetTo,0))
	end
	for j,k in pairs(BanToken) do
		SetUnitsDatX(k,{Playerable = 2, Reqptr=5, MinCost=0,GasCost=0,BuildTime = 1,SuppCost = 0})--플레이어만 사용가능, 요구조건을 무조건?으로
	end
	SetUnitsDatX(3,{Playerable = 2, Reqptr=5, MinCost=0,GasCost=0,BuildTime = 1,SuppCost = 0})--플레이어만 사용가능, 요구조건을 무조건?으로
	SetUnitsDatX(83,{Playerable = 2, Reqptr=5, MinCost=0,GasCost=0,BuildTime = 1,SuppCost = 0})--플레이어만 사용가능, 요구조건을 무조건?으로
	for j, k in pairs({37,38,39,41,43,44,45,46,47}) do
		SetUnitsDatX(k,{MinCost=0,GasCost=0,BuildTime=15})--저그유닛설정
	end


	
	for i = 0, 7 do
		table.insert(PatchArr,SetMemory(0x5821A4 + (i*4),SetTo,QueueMaxUnit*2))
		table.insert(PatchArr,SetMemory(0x582144 + (i*4),SetTo,QueueMaxUnit*2))
	end
	for i = 1, 5 do
		table.insert(PatchArr,SetMemoryB(0x57F27C + ((i-1) * 228) + BanToken[i],SetTo,0))
	end
	for i = 5, 7 do
		table.insert(PatchArr,SetMemoryB(0x58CE24 + (i * 24) + 15,SetTo,0))
		table.insert(PatchArr,SetMemoryB(0x58CF44 + (i * 24) + 15,SetTo,0))
	end
	
	table.insert(PatchArr,SetMemoryB(0x58CE24 + (5 * 24) + 19,SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x58CE24 + (5 * 24) + 22,SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x58F050 + (5 * 20) + (31-20),SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x58CF44 + (5 * 24) + 19,SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x58CF44 + (5 * 24) + 22,SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x58F140 + (5 * 20) + (31-20),SetTo,0))
	
	
	
	
	
	
	


	SetUnitsDatX(115,{AdvFlag={1612709889,0xFFFFFFFF},BdDimX=1,BdDimY=1})--강퇴건물세팅
	SetUnitsDatX(107,{AdvFlag={1612709889,0xFFFFFFFF},BdDimX=1,BdDimY=1})--강퇴건물세팅

	CIfOnce(FP)
	for i = 0, 4 do
		CIf(FP,{LocalPlayerID(i)})
		DisplayPrintTbl(1391,{"z\x02\x07。\x18˙\x0F+\x1C˚\x19 \x07자동 \x0F회복 \x04업그레이드 (\x1F",HealCost[i+1]," Ore\x04) \x11(\x07",HealUpgrade[i+1],"\x04/\x1C5\x11) \x04(\x03Z\x04) \x1C。\x0F+\x18.\x07˚\n\x07업그레이드 단계\x04마다 \x0F회복\x1F속도\x04가 점점 빨라집니다."})
		DisplayPrintTbl(1390,{"x\x02\x07。\x18˙\x0F+\x1C˚\x19 부활의 가호 \x04업그레이드 (\x1F",RebirthCost[i+1]," Ore\x04) \x11(\x07",RebirthUp[i+1],"\x04/\x1C3\x11) \x04(\x03X\x04) \x1C。\x0F+\x18.\x07˚\n\x041회 : \x18S\x04pecial \x18M\x04arine \x19부활 적용\n\x042회 : \x19R\x04espect \x19M\x04arine \x19부활 적용\n\x043회 : \x07쿨타임\x04이 \x1F5분에서 3분으로 단축\x04됨"})
		DisplayPrintTbl(1387,{"q\x02\x07。\x18˙\x0F+\x1C˚\x19 \x18S\x04pecial \x18M\x04arine \x1F특수 \x04업그레이드 (\x1F",SMSkillCost[i+1]," Ore\x04) \x11(\x07",SMUp[i+1],"\x04/\x1C24\x11) \x04(\x03Q\x04)\x1C。\x0F+\x18.\x07˚"})
		DisplayPrintTbl(1388,{"w\x02\x07。\x18˙\x0F+\x1C˚\x19 \x19R\x04espect \x19M\x04arine \x1F특수 \x04업그레이드 (\x1F",RMSkillCost[i+1]," Ore\x04) \x11(\x07",RMUp[i+1],"\x04/\x1C9\x11) \x04(\x03W\x04) \x1C。\x0F+\x18.\x07˚"})
		--DisplayPrintTbl(1389,"c\x02\x07。\x18˙\x0F+\x1C˚\x1A 무적의 가호 \x04업그레이드 (\x1F1500000 Ore\x04) \x11(MAX 1) \x04(\x03C\x04) \x1C。\x0F+\x18.\x07˚\n\x16일정한 주기\x04마다 \x1A무적상태\x04가 적용됩니다. ")
		CIfEnd()
	end

	f_Read(FP,0x512684,LCP)
	DoActions2(FP, PatchArr)
	DoActions2(FP, PatchArr2)
	LimitX = CreateCcode()
	LimitT = CreateCcodeArr(7)
	LimitC = CreateCcode()
	TriggerX(FP, {}, {Simple_SetLoc(0, 320,992-(64), 320,992-(64)),CreateUnit(1, 145, 11, FP),
	CreateUnit(1, 120, 42, P6),GiveUnits(All, 120, P6, 42, P9)})
	for i = 0, 4 do
		DoActions(FP, {
			SetMemoryB(0x58D088+(46*i)+0,SetTo,255),
			SetMemoryB(0x58D088+(46*i)+7,SetTo,255),
			SetMemoryB(0x58D088+(46*i)+15,SetTo,255),
			SetMemoryB(0x58D088+(46*i)+18,SetTo,1),
			SetMemoryB(0x58D088+(46*i)+19,SetTo,1),
			SetMemoryB(0x58D088+(46*i)+20,SetTo,1),
			GiveUnits(1, 111, P12, 4, i),
            GiveUnits(1, 125, P12, 2, i),
            Simple_CalcLoc(3, 0, 64, 0, 64),
			SetCp(i),
			SetAllianceStatus(P12, Enemy),SetCp(FP)

		},1)
		TriggerX(FP, {HumanCheck(i, 1)}, {SetCVar(FP,SetPlayers[2],Add,1),Simple_SetLoc(0, 320,992+(64*i), 320,992+(64*i)),CreateUnit(1, 107, 1, i),Simple_CalcLoc(0, 64, 0, 64, 0),
		CreateUnit(1, 115, 34+i, i),GiveUnits(All, 115, i, 34+i, P9)})
	end
	for i = 4, 0,-1 do
		DoActions(FP, {
            GiveUnits(1, 125, P12, 3, i),
		},1)
		TriggerX(FP, {HumanCheck(i, 0)}, {RemoveUnit(111, i),RemoveUnit(125, i),RemoveUnit(122, i),RemoveUnit(145, i)})
	end
	
	
	
if TestStart == 1 then
	DoActionsX(FP,{SetSwitch("Switch 254", Set)}) -- Limit설정
end
if Limit == 1 then
	DoActionsX(FP,{SetSwitch("Switch 253", Set)}) -- Limit설정
end
	DoActionsX(FP,{SetCDeaths(FP,SetTo,Limit,LimitX),SetCDeaths(FP,SetTo,TestStart,TestMode),SetInvincibility(Disable, 188, P12, 64),SetInvincibility(Disable, 176, P12, 64),SetInvincibility(Disable, 177, P12, 64),SetInvincibility(Disable, 178, P12, 64),}) -- Limit설정
	function InputTesterID(Player,ID,Num)
		if Limit == 1 then
			
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				isname(Player,ID);
				CDeaths(FP,AtLeast,1,LimitX);
			},
			actions = {
				SetCDeaths(FP,SetTo,1,LimitC);
				SetCDeaths(FP,SetTo,1,LimitT[Player+1]);
				SetDeaths(Player, SetTo, Num, 217);--217번 데스값을 특정숫자로
				
			}
		}
	else
		
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				isname(Player,ID);
				--CDeaths(FP,AtLeast,1,LimitX);
			},
			actions = {
				SetCDeaths(FP,SetTo,1,LimitC);
				SetCDeaths(FP,SetTo,1,LimitT[Player+1]);
				SetDeaths(Player, SetTo, Num, 217);--217번 데스값을 특정숫자로
				
				
			}
		}
		end
	end
	function InputSubtitleID(Player,ID,Num)
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				isname(Player,ID);
				--CDeaths(FP,AtLeast,1,LimitX);
			},
			actions = {
				SetDeaths(Player, SetTo, Num, 217);--217번 데스값을 특정숫자로
				
				
			}
		}
	end

		for i = 0, 7 do -- 정버아닌데 플레이어중 해당하는 닉네임 없으면 겜튕김
			InputTesterID(i,"GALAXY_BURST",1) --Creator 칭호
			InputTesterID(i,"Natori_sana",2) --名取さな 칭호 및 사망 닉네임 효과
			InputSubtitleID(i,"Standible",5) --SC 솔플클리어자 칭호
			InputSubtitleID(i,"Mejiro_McQueen",6) --SC 솔플클리어자 칭호
			InputSubtitleID(i,"Zahirsm",7) --SC 솔플클리어자 칭호
			InputSubtitleID(i,"marine_T_T",3) --SC 솔플클리어자 칭호
			InputSubtitleID(i,"lptime106",3) --SC 솔플클리어자 칭호
			InputSubtitleID(i,"TurtlePunch",3) --SC 솔플클리어자 칭호
			InputSubtitleID(i,"Ask",3) --SC 솔플클리어자 칭호
			InputSubtitleID(i,"HereticSentinel",4) --SC 솔플클리어자 칭호
			InputSubtitleID(i,"ARTANlS",4) --SC 솔플클리어자 칭호
		end
		
	T_YY = 2024
	T_MM = 09
	T_DD = 06
	T_HH = 00
	GlobalTime = os.time{year=T_YY, month=T_MM, day=T_DD, hour=T_HH }
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
	
		Trigger2X(FP, {
			CDeaths(FP,Exactly,1,LimitX);
			CDeaths(FP,Exactly,0,LimitC);}, {
				RotatePlayer({
					DisplayTextX(StrDesignX("\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.").."\n"..StrDesignX("\x04실행 방지 코드 0x32223223 작동."),4);
				Defeat();
				},HumanPlayers,FP);
				Defeat();
				SetMemory(0xCDDDCDDC,SetTo,1);})

				
				
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
		SetMemory(0xCDDDCDDC,SetTo,1);
	}
}
for i = 0, 4 do
	Trigger { -- 게임오버
		players = {FP},
		conditions = {
			MemoryX(0x57EEE8 + 36*i,Exactly,1,0xFF);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x1B사람 슬롯 변경이 감지되었습니다. 컴퓨터 넣지마세요.\n\x13\x04실행 방지 코드 0x32223223 작동.",4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetCtrigX("X",0xFFFD,0x4,0,SetTo,"X",0xFFFD,0x0,0,1); -- ExitDrop
			SetMemory(0xCDDDCDDC,SetTo,1);
		}
	}
end
for i = 5, 7 do
	
Trigger { -- 게임오버
players = {FP},
conditions = {
	MemoryX(0x57EEE8 + 36*i,Exactly,0,0xFF);
},
actions = {
	RotatePlayer({
	DisplayTextX("\x13\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.\n\x13\x04실행 방지 코드 0x32223223 작동.",4);
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
	DisplayTextX("\x13\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.\n\x13\x04실행 방지 코드 0x32223223 작동.",4);
	Defeat();
	},HumanPlayers,FP);
	Defeat();
	SetMemory(0xCDDDCDDC,SetTo,1);
}
}
end

Trigger { -- 게임오버
	players = {FP},
	conditions = {
		MemoryX(0x57EEE0 + (36*5)+8,AtMost,1*256,0xFF00);
	},
	actions = {
		RotatePlayer({
		DisplayTextX("\x13\x1B컴퓨터 종족 변경이 감지되었습니다. 다시 시작해주세요.\n\x13\x04실행 방지 코드 0x32223223 작동.",4);
		Defeat();
		},HumanPlayers,FP);
		Defeat();
		SetMemory(0xCDDDCDDC,SetTo,1);
	}
}
Trigger { -- 게임오버
	players = {FP},
	conditions = {
		MemoryX(0x57EEE0 + (36*6)+8,AtLeast,1*256,0xFF00);
	},
	actions = {
		RotatePlayer({
		DisplayTextX("\x13\x1B컴퓨터 종족 변경이 감지되었습니다. 다시 시작해주세요.\n\x13\x04실행 방지 코드 0x32223223 작동.",4);
		Defeat();
		},HumanPlayers,FP);
		Defeat();
		SetMemory(0xCDDDCDDC,SetTo,1);
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
		SetMemory(0xCDDDCDDC,SetTo,1);
	}
}

	Trigger { -- 혹시 싱글이신가요?
		players = {FP},
		conditions = {
			Label(0);
			Memory(0x57F0B4, Exactly, 0);
	},
		actions = {
			--SetCDeaths(FP,SetTo,1,isSingle);
				RotatePlayer({
				DisplayTextX("\x13\x04싱글플레이로는 플레이할 수 없습니다. 멀티플레이로 시작해주세요.\n\x13\x04실행 방지 코드 0x32223223 작동.",4);
				Defeat();
				},HumanPlayers,FP);
				Defeat();
				SetMemory(0xCDDDCDDC,SetTo,1);
	},
	}



	if TestStart == 1 then
		DoActionsX(FP, {SetCD(TestMode,1),--SetResources(Force1, Add, 66666666, Ore),
		AddV(CTMin[1],66666666),
		AddV(CTMin[2],66666666),
		AddV(CTMin[3],66666666),
		AddV(CTMin[4],66666666),
		AddV(CTMin[5],66666666),
		AddV(CTMin[6],66666666),
		AddV(CTMin[7],66666666),})
		--for i = 0, 4 do
		--	DoActions(FP, {CreateUnit(1, MarID[i+1], 5, P1)}, 1)--리마
		--end
		--DoActions(FP, {CreateUnit(1, 32, 5, P1)}, 1)--일마
		--DoActions(FP, {CreateUnit(1, 20, 5, P1)}, 1)--영마
		--DoActions(FP, {CreateUnit(1, 10, 5, P1)}, 1)--스마
		--DoActions(FP, {CreateUnit(1, 15, 5, P1)}, 1)--스마
		--DoActions(FP, {CreateUnit(1, 84, 5, P1)}, 1)--스마
		--DoActions(FP, {CreateUnit(1, 63, 5, P1)}, 1)--스마
	--
	end
	DoActions2(FP, {	
	SetMemory(0x5124F0,SetTo,0x1D),SetResources(FP, Add, 10000000, OreAndGas),SetCp(FP)})
	--NPA5(FP,0x6D5A30,FArr(TBLFile,0),TBLFiles)

	


DoActionsX(FP, { -- 기타 시작시 1회실행 트리거
	SetInvincibility(Disable, 176, P8, 64);
	SetInvincibility(Disable, 177, P8, 64);
	SetInvincibility(Disable, 178, P8, 64);
	--AddCD(GunCcode,#Shape8148);
	--AddCD(GunCcode,#Shape8131);
	--AddCD(GunCcode,#Shape8132);
	--AddCD(GunCcode,#Shape8133);
	--AddCD(GunCcode,#Shape8122);
	--AddCD(GunCcode,#Shape8113);
	--AddCD(GunCcode,#Shape8114);
	--AddCD(GunCcode,#Shape8160);
	--AddCD(GunCcode,#Shape8167);
	--AddCD(GunCcode,#Shape8154);
	--AddCD(GunCcode,#Shape8116);--건작들 갯수 입력(무적해제 컨디션)
},1)

CbyteConvert(FP,VArr(HVA3,0),GetStrArr(0,"\x0D\x0D!H")) 


	CFor(FP,19025,19025+(84*1700),84)
	CI = CForVariable()
	condbox = {}
	for j,k in pairs(UnitPointArr2) do
		table.insert(condbox,CV(RepHeroIndex,k))
	end
	for j,k in pairs(BuildPlaceArr) do
		table.insert(condbox,CV(RepHeroIndex,k[2]))
	end
	
	f_Read(FP,_Add(CI,25),RepHeroIndex,nil,0xFF,1)
	f_Read(FP,_Add(CI,19),PlayerV,nil,0xFF,1)

	CIf(FP,{CV(RepHeroIndex,111)})
	for i = 0,6 do
		CIf(FP,CVX(PlayerV,i,0xFF))
		CMov(FP,BarPos[i+1],CI)
		--DisplayPrint(HumanPlayers, {"배럭 등록 완료"})
		CIfEnd()
	end
	
	CIfEnd()
	CIf(FP,{TTOR(condbox)})
	f_Read(FP,_Add(CI,10),CPos)
	f_Read(FP,_Add(CI,2),CunitHP)
	f_Div(FP,CunitHP,_Mov(256))
	CMov(FP,ArrX(UnitHPArr,UnitRepIndex),_Sub(CunitHP,50))
	CMov(FP,ArrX(UnitPosArr,UnitRepIndex),CPos)
	CMov(FP,ArrX(UnitIDArr,UnitRepIndex),RepHeroIndex,nil,0xFF,1)
	CMov(FP,ArrX(PlayerIDArr,UnitRepIndex),PlayerV,nil,0xFF,1)
	
	CAdd(FP,UnitRepIndex,1)
	CIfEnd()
	CAdd(FP,CunitIndex,1)
	CForEnd()
	
	
	removebox = {}
	for j,k in pairs(UnitPointArr2) do
		table.insert(removebox,ModifyUnitEnergy(All, k, AllPlayers, 64, 0))
		table.insert(removebox,RemoveUnit(k, AllPlayers))
	end

	for j,k in pairs(BuildPlaceArr) do
		table.insert(removebox,ModifyUnitEnergy(All, k[2], AllPlayers, 64, 0))
		table.insert(removebox,RemoveUnit(k[2], AllPlayers))
	end

	DoActions2(FP, removebox)
	CIfEnd()--OnPluginStartEnd
	--table.insert(PatchArrPrsv, KillUnitAt(All, "Dark Swarm", 64, AllPlayers))
	
	

	-- P6 255
	-- P7 42
	-- P8 128

	DoActions2(AllPlayers, PatchArrPrsv)
	if DLC_Project==1 then
		DoActions2(FP, {
			SetPlayerColor(P6, SetTo, 255);
			SetPlayerColor(P7, SetTo, 42);
			SetPlayerColor(P8, SetTo, 109);
			SetMinimapColor(P6, SetTo, 255),
			SetMinimapColor(P7, SetTo, 42),
			SetMinimapColor(P8, SetTo, 109),
			ModifyUnitEnergy(All, "Any unit", AllPlayers, "Anywhere", 100),
			ModifyUnitHitPoints(All, "Any unit", Force1, "Anywhere", 100),
			ModifyUnitHitPoints(All, "Any unit", Force2, "Anywhere", 100),
			ModifyUnitShields(All, "Any unit", AllPlayers, "Anywhere", 100)
		},1)
	else
		DoActions2(FP, {
			SetPlayerColor(P6, SetTo, 255);
			SetPlayerColor(P7, SetTo, 42);
			SetPlayerColor(P8, SetTo, 128);
			SetMinimapColor(P6, SetTo, 255),
			SetMinimapColor(P7, SetTo, 42),
			SetMinimapColor(P8, SetTo, 128),
			ModifyUnitEnergy(All, "Any unit", AllPlayers, "Anywhere", 100),
			ModifyUnitHitPoints(All, "Any unit", Force1, "Anywhere", 100),
			ModifyUnitHitPoints(All, "Any unit", Force2, "Anywhere", 100),
			ModifyUnitShields(All, "Any unit", AllPlayers, "Anywhere", 100)
		},1)
	end
	
	DoActions(FP, {Simple_SetLoc(0, 1344, 7888, 1344, 7888),
	CreateUnit(1, 133, 1, P7),	CreateUnit(1, 132, 1, P7),	CreateUnit(1, 131, 1, P7),
	Simple_SetLoc(0, 704, 7888, 704, 7888),
	CreateUnit(1, 133, 1, P7),	CreateUnit(1, 132, 1, P7),	CreateUnit(1, 131, 1, P7),
},1)

	HeroTestMode = 1
	if HeroTestMode == 1 then
		for j,k in pairs(UnitPointArr) do
			--f_TempRepeat({}, k[1], 1, 2, FP, {1600,4352+(j*32)}, 1)
		end
	end


end