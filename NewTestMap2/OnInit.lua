function onInit_EUD()
	PatchInit()
	function SetUnitAbility(UnitID,WepID,Cooldown,Damage,DamageFactor,UpgradeID,ObjNum)
		SetUnitsDatX(UnitID, {Reqptr=5,MinCost=0,GasCost=0,SuppCost=0,Height=4,AdvFlag={0+0x20000000,4+8+0x20000000},GroundWeapon=WepID,AirWeapon=130,DefUpType=60,SeekRange=7,GroupFlag=0xA,
		HumanInitAct = 2,
		ComputerInitAct = 2,
		AttackOrder = 10,
		AttackMoveOrder = 2,
		IdleOrder = 2,
		RClickAct = 1,
	})
	if ObjNum~=nil then
		SetWeaponsDatX(WepID,{Cooldown = Cooldown,DmgBase=Damage,DmgFactor=DamageFactor,UpgradeType=UpgradeID,RangeMax=4*32,DmgType=3,TargetFlag=2,ObjectNum=ObjNum})
	else
		SetWeaponsDatX(WepID,{Cooldown = Cooldown,DmgBase=Damage,DmgFactor=DamageFactor,UpgradeType=UpgradeID,RangeMax=4*32,DmgType=3,TargetFlag=2})
	end
	end
	function SetUnitAbilityT(UnitID,WepID,Cooldown,Damage,DamageFactor,UpgradeID,ObjNum)
		SetUnitsDatX(UnitID, {Reqptr=5,MinCost=0,GasCost=0,SuppCost=0,Height=4,AdvFlag={0+0x20000000,4+8+0x20000000},DefUpType=60,SeekRange=7,GroupFlag=0xA,
		HumanInitAct = 2,
		ComputerInitAct = 2,
		AttackOrder = 10,
		AttackMoveOrder = 2,
		IdleOrder = 2,
		RClickAct = 1,
	})
	if ObjNum~=nil then
		SetWeaponsDatX(WepID,{Cooldown = Cooldown,DmgBase=Damage,DmgFactor=DamageFactor,UpgradeType=UpgradeID,RangeMax=4*32,DmgType=3,TargetFlag=2,ObjectNum=ObjNum})
	else
		SetWeaponsDatX(WepID,{Cooldown = Cooldown,DmgBase=Damage,DmgFactor=DamageFactor,UpgradeType=UpgradeID,RangeMax=4*32,DmgType=3,TargetFlag=2})
	end
	end
	LevelUnitArr = {}
	GetUnitArr = {}
	function InputLevelUnit(Level,Per,UnitID,WepID,Cooldown,Damage,DamageFactor,UpgradeID,ifTType,ObjNum)
		if ifTType ~= nil then
			SetUnitAbilityT(UnitID,WepID,Cooldown,Damage,DamageFactor,UpgradeID,ObjNum)
		else
			SetUnitAbility(UnitID,WepID,Cooldown,Damage,DamageFactor,UpgradeID,ObjNum)
		end
		table.insert(LevelUnitArr,{Level,UnitID,Per})
		table.insert(GetUnitArr,CreateVarArr(7, FP))
	end
	InputLevelUnit(1,75000,0,0,24*1,1,0,60)--마린
	InputLevelUnit(2,75000,1,2,24*3,10,1,59)--고스트
	InputLevelUnit(3,75000,2,4,24*3,20,2,59)--벌쳐
	InputLevelUnit(4,75000,7,13,24*2,20,2,59)--에씨비
	InputLevelUnit(5,65000,8,16,24*2,30,3,59)--레이스
	InputLevelUnit(6,65000,5,11,24*2,50,5,59,1)--탱크
	InputLevelUnit(7,65000,3,7,24*2,80,8,59,1)--골럇
	InputLevelUnit(8,65000,32,25,24*3,60,6,59)--파벳 3타
	InputLevelUnit(9,60000,58,103,24*2,80,8,59)--발키리 2타
	InputLevelUnit(10,60000,12,19,24*2,250,25,59)--배틀



	InputLevelUnit(11,55000,65,64,24*3,250,25,59)--질럿 2타
	InputLevelUnit(12,55000,66,66,24*2,400,40,59)--드라군
	InputLevelUnit(13,50000,67,68,24*2,550,55,59)--하템
	InputLevelUnit(14,50000,61,111,24*3,1000,100,59)--닥템
	InputLevelUnit(15,45000,83,115,24*3,1300,130,59,nil,1)--리버
	InputLevelUnit(16,45000,70,73,24*2,1000,100,59)--스카웃
	InputLevelUnit(17,40000,60,100,24*2,1300,130,59)--커세어
	InputLevelUnit(18,40000,71,77,24*2,1800,180,59)--아비터


	
	InputLevelUnit(19,50000,37,35,12,600,60,59)--저글링
	InputLevelUnit(20,50000,38,38,24,2000,200,59)--히드라
	InputLevelUnit(21,45000,43,48,24,2700,270,59)--뮤탈
	InputLevelUnit(22,45000,44,46,24*2,7000,700,59)--가디언
	InputLevelUnit(23,40000,62,104,24*4,20000,2000,59)--디바우러
	InputLevelUnit(24,40000,39,40,24*2,13000,1300,59)--울트라
	InputLevelUnit(25,35000,46,50,24*2,18000,1800,59)--디파



	InputLevelUnit(25+1,35000,20,1,24*1,10,1,60)--마린
	InputLevelUnit(25+2,30000,16,3,24*2,30,3,59)--고스트
	InputLevelUnit(25+3,30000,19,5,24*1,20,2,59)--벌쳐
	InputLevelUnit(25+4,25000,7,13,24*2,20,2,59)--에씨비
	InputLevelUnit(25+5,25000,8,16,24*2,30,3,59)--레이스
	InputLevelUnit(25+6,20000,5,11,24*2,50,5,59,1)--탱크
	InputLevelUnit(25+7,20000,3,7,24*2,80,8,59,1)--골럇
	InputLevelUnit(25+8,15000,32,25,24*3,60,6,59)--파벳 3타
	InputLevelUnit(25+9,15000,58,103,24*2,80,8,59)--발키리 2타
	InputLevelUnit(25+10,10000,12,19,24*2,250,25,59)--배틀



	InputLevelUnit(25+11,10000,65,64,24*3,250,25,59)--질럿 2타
	InputLevelUnit(25+12,8000,66,66,24*2,400,40,59)--드라군
	InputLevelUnit(25+13,8000,67,68,24*2,550,55,59)--하템
	InputLevelUnit(25+14,6000,61,111,24*3,1000,100,59)--닥템
	InputLevelUnit(25+15,6000,83,115,24*3,1300,130,59,nil,1)--리버
	InputLevelUnit(25+16,4000,70,73,24*2,1000,100,59)--스카웃
	InputLevelUnit(25+17,4000,60,100,24*2,1300,130,59)--커세어
	InputLevelUnit(25+18,3000,71,77,24*2,1800,180,59)--아비터


	
	InputLevelUnit(25+19,3000,37,35,12,600,60,59)--저글링
	InputLevelUnit(25+20,2000,38,38,24,2000,200,59)--히드라
	InputLevelUnit(25+21,2000,43,48,24,2700,270,59)--뮤탈
	InputLevelUnit(25+22,1000,44,46,24*2,7000,700,59)--가디언
	InputLevelUnit(25+23,1000,62,104,24*4,20000,2000,59)--디바우러
	InputLevelUnit(25+24,500,39,40,24*2,13000,1300,59)--울트라
	InputLevelUnit(25+25,500,46,50,24*2,18000,1800,59)--디파


	SetWeaponsDatX(103,{Behavior=1,Splash=false})
	SetWeaponsDatX(25,{Behavior=1,Splash=false})
	SetUnitsDatX(62, {AirWeapon=104})
	--SetWeaponsDatX(104,{Behavior=1,Splash=false})


	SetUnitsDatX(127, {BdDimX=1,BdDimY=1,HP=8320000,Armor = 0})
	
	
	SetUnitsDatX(128, {HumanInitAct=23,ComputerInitAct=23,AttackOrder=23,AttackMoveOrder=23,IdleOrder=23})
	DoActions(AllPlayers, {SetAllianceStatus(Force1, Ally),
	RunAIScript(P1VON),
	RunAIScript(P2VON),
	RunAIScript(P3VON),
	RunAIScript(P4VON),
	RunAIScript(P5VON),
	RunAIScript(P6VON),
	RunAIScript(P7VON),
	RunAIScript(P8VON),
})
	
	
	
	
	
	PatchInput()

	
	CIfOnce(FP,nil,{SetMemory(0x5124F0,SetTo,0x15)}) -- 기본 3배속
	DoActions(FP,{SetMemory(LimitVerPtr,SetTo,LimitVer)})
	for i = 0, 6 do
		
	CIf(FP,{HumanCheck(i,1)})
		
	f_Read(FP, 0x628438, nil, Nextptrs)
	CDoActions(FP, {TSetNVar(TestShop[i+1], SetTo, Nextptrs),CreateUnit(1,128,1+i,i)})

	f_Read(FP, 0x628438, nil, Nextptrs)
	CDoActions(FP, {TSetNVar(TestDps[i+1], SetTo, _Add(Nextptrs,2)),CreateUnit(1,127,57+i,FP)})
	


	CIfEnd()

	end
	CIfEnd()

	
end

