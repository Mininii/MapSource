
function Install_BackupCP(Player)
	BackupCp = CreateVar(Player)
	SaveCp_CallIndex = SetCallForward()
	SetCall(Player)
		SaveCp(Player,BackupCp)
	SetCallEnd()

	LoadCp_CallIndex = SetCallForward()
	SetCall(Player)
		LoadCp(Player,BackupCp)
		SetRecoverCp()
	SetCallEnd()

	function f_SaveCp()
		CallTrigger(Player,SaveCp_CallIndex,nil)
	end
	function f_LoadCp()
		CallTrigger(Player,LoadCp_CallIndex,nil)
	end
end

function TestSet(val)
	if val == 1 then 
		Limit = 1
		TestStart = 0
	elseif val == 2 then
		Limit = 1
		TestStart = 1
	else
		Limit = 0
		TestStart = 0
	end
end
function PatchInit()
PatchArr={}
PatchArr2={}
PatchArrPrsv={}
end
function PatchInput()
	DoActions2(FP,PatchArr,1)
	DoActions2(FP,PatchArr2,1)
	DoActions2(AllPlayers,PatchArrPrsv)
end

function PatchInsert(Act)
	table.insert(PatchArr,Act)
end
function PatchInsert2(Act)
	table.insert(PatchArr2,Act)
end
function PatchInsertPrsv(Act)
	table.insert(PatchArrPrsv,Act)
end

function SetUnitsDatX(UnitID,Property)
	if type(UnitID) == "string" then
		UnitID = ParseUnit(UnitID) -- 스트링으로 유닛이름 입력가능
	end
	if UnitID>=228 then PushErrorMsg("UnitID Index Overflow") end
	if type(Property)~= "table" then
		PushErrorMsg("Property Inputdata Error")
	else
		for j,k in pairs(Property) do
			if j=="MinCost" then
				PatchInsert(SetMemoryW(0x663888 + (UnitID *2),SetTo,k)) -- 미네랄
			elseif j=="Playerable" then
				local SType
				if type(k)=="boolean" then
					if k == true then
						SType=1
					else
						SType=0
					end
				else
					SType=k
				end
				PatchInsert(SetMemoryB(0x57F27C + (0 * 228) + UnitID,SetTo,SType))
				PatchInsert(SetMemoryB(0x57F27C + (1 * 228) + UnitID,SetTo,SType))
				PatchInsert(SetMemoryB(0x57F27C + (2 * 228) + UnitID,SetTo,SType))
				PatchInsert(SetMemoryB(0x57F27C + (3 * 228) + UnitID,SetTo,SType))
				PatchInsert(SetMemoryB(0x57F27C + (4 * 228) + UnitID,SetTo,SType))
				PatchInsert(SetMemoryB(0x57F27C + (5 * 228) + UnitID,SetTo,SType))
				PatchInsert(SetMemoryB(0x57F27C + (6 * 228) + UnitID,SetTo,SType))
				PatchInsert(SetMemoryB(0x57F27C + (7 * 228) + UnitID,SetTo,SType))
			elseif j=="GasCost"  then
				PatchInsert(SetMemoryW(0x65FD00 + (UnitID *2),SetTo,k)) -- 가스
			elseif j=="BuildTime"  then
				PatchInsert(SetMemoryW(0x660428 + (UnitID *2),SetTo,k)) -- 생산속도
			elseif j=="SuppCost"  then
				PatchInsert(SetMemoryB(0x663CE8 + UnitID,SetTo,k*2)) -- 서플
			elseif j=="HP"  then
				PatchInsert(SetMemory(0x662350 + (UnitID*4),SetTo,k*256))
			elseif j=="Shield"  then
				if type(k)=="boolean" then
					if k == true then
						PatchInsert(SetMemoryB(0x6647B0 + UnitID,SetTo,1))
					else
						PatchInsert(SetMemoryB(0x6647B0 + UnitID,SetTo,0))
						PatchInsert(SetMemoryW(0x660E00 + (UnitID *2), SetTo, 0))
					end
				else
					PatchInsert(SetMemoryB(0x6647B0 + UnitID,SetTo,1))
					PatchInsert(SetMemoryW(0x660E00 + (UnitID *2), SetTo, k))
				end
			elseif j=="Armor" then
				PatchInsert(SetMemoryB(0x65FEC8 + (UnitID),SetTo,k)) -- 방어력
			elseif j=="GroupFlag" then
				PatchInsert(SetMemoryB(0x6637A0 + (UnitID),SetTo,k)) -- 그룹
			elseif j=="Height" then
				PatchInsert(SetMemoryB(0x663150 + (UnitID),SetTo,k)) -- 건설크기
			elseif j=="BdDimX" then
				PatchInsert(SetMemoryX(0x662860 + (UnitID*4),SetTo,k,0xFFFF)) -- 건설크기
			elseif j=="BdDimY" then
				PatchInsert(SetMemoryX(0x662860 + (UnitID*4),SetTo,k*65536,0xFFFF0000)) -- 건설크기
			elseif j=="SizeL" then
				PatchInsert(SetMemoryX(0x6617C8 + (UnitID*8),SetTo,(k),0xFFFF))
			elseif j=="SizeU" then
				PatchInsert(SetMemoryX(0x6617C8 + (UnitID*8),SetTo,(k*65536),0xFFFF0000))
			elseif j=="SizeR" then
				PatchInsert(SetMemoryX(0x6617CC + (UnitID*8),SetTo,(k),0xFFFF))
			elseif j=="SizeD" then
				PatchInsert(SetMemoryX(0x6617CC + (UnitID*8),SetTo,(k*65536),0xFFFF0000))
			elseif j=="SuppProv" then
				PatchInsert(SetMemoryB(0x6646C8+UnitID,SetTo,Property.SuppProv)) -- 서플공급량
			elseif j=="AdvFlag" then
				if type(k)~= "table" or #k~=2 then
					PushErrorMsg("AdvFlag Inputdata Error")
				end
				PatchInsert(SetMemoryX(0x664080 + (UnitID*4),SetTo,k[1],k[2]))
			elseif j=="DefType" then
				PatchInsert(SetMemoryB(0x662180 + UnitID,SetTo,k))
			elseif j=="DefUpType" then
				PatchInsert(SetMemoryB(0x6635D0 + UnitID,SetTo,k))
			elseif j=="StarEditFlag"  then
				PatchInsert(SetMemoryW(0x661518+(UnitID*2),SetTo,k))
			elseif j=="Class"  then
				PatchInsert(SetMemoryB(0x663DD0+(UnitID),SetTo,k))

			elseif j=="AirWeapon"  then
				PatchInsert(SetMemoryB(0x6616E0+UnitID,SetTo,k))
			elseif j=="GroundWeapon"  then
				PatchInsert(SetMemoryB(0x6636B8+UnitID,SetTo,k))
				
			elseif j=="SpaceProv"  then
				PatchInsert(SetMemoryB(0x660988+(UnitID*1),SetTo,k))
			elseif j=="SpaceReq"  then
			PatchInsert(SetMemoryB(0x664410+(UnitID*1),SetTo,k))
			elseif j=="RClickAct" then
				PatchInsert(SetMemoryB(0x662098+UnitID,SetTo,k))--RClickAct
			elseif j=="HumanInitAct" then
				PatchInsert(SetMemoryB(0x662268+UnitID,SetTo,k))--HumanInitAct
			elseif j=="ComputerInitAct" then
				PatchInsert(SetMemoryB(0x662EA0+UnitID,SetTo,k))--ComputerInitAct
			elseif j=="AttackOrder" then
				PatchInsert(SetMemoryB(0x663320+UnitID,SetTo,k))--AttackOrder
			elseif j=="AttackMoveOrder" then
				PatchInsert(SetMemoryB(0x663A50+UnitID,SetTo,k))--AttackMoveOrder
			elseif j=="IdleOrder" then
				PatchInsert(SetMemoryB(0x664898+UnitID,SetTo,k))--IdleOrder
			elseif j=="RdySnd" then
				PatchInsert(SetMemoryW(0x661FC0+(UnitID*2),SetTo,k))
			elseif j=="WhatSndInit" then
				PatchInsert(SetMemoryW(0x662BF0+(UnitID*2),SetTo,k))
			elseif j=="WhatSndEnd" then
				PatchInsert(SetMemoryW(0x65FFB0+(UnitID*2),SetTo,k))
			elseif j=="YesInit" then
				if UnitID>=106 then PushErrorMsg("UnitID Index Overflow") end
				PatchInsert(SetMemoryW(0x663C10+(UnitID*2),SetTo,k))
			elseif j=="YesEnd" then
				if UnitID>=106 then PushErrorMsg("UnitID Index Overflow") end
				PatchInsert(SetMemoryW(0x661440+(UnitID*2),SetTo,k))
			elseif j=="PissedInit" then
				if UnitID>=106 then PushErrorMsg("UnitID Index Overflow") end
				PatchInsert(SetMemoryW(0x663B38+(UnitID*2),SetTo,k))
			elseif j=="PissedEnd" then
				if UnitID>=106 then PushErrorMsg("UnitID Index Overflow") end
				PatchInsert(SetMemoryW(0x661EE8+(UnitID*2),SetTo,k))
			elseif j=="Reqptr" then
				PatchInsertPrsv(SetMemoryW(0x660A70+(UnitID*2), SetTo, k))
			elseif j== "SeekRange" then
				PatchInsert(SetMemoryB(0x662DB8+UnitID,SetTo,k)) -- SeekRange
			elseif j== "Graphic" then
				PatchInsert(SetMemoryB(0x6644F8+UnitID,SetTo,k)) -- Graphic
			elseif j== "BuildScore" then
				PatchInsert(SetMemoryW(0x663408+(UnitID *2),SetTo,k))--BuildScore
			elseif j== "KillScore" then
				PatchInsert(SetMemoryW(0x663EB8+(UnitID *2),SetTo,k))--KillScore
			else
				PushErrorMsg("Wrong Property Name Detected!! : "..j)
			end
			
		end
	end
end

function SetWeaponsDatX(WepID,Property)
	if type(Property)~= "table" then
		PushErrorMsg("Property Inputdata Error")
	else
		for j,k in pairs(Property) do
			if j=="DmgBase" then
				PatchInsert(SetMemoryW(0x656EB0+(WepID *2),SetTo,k)) -- 공격력
			elseif j=="DmgFactor" then
				PatchInsert(SetMemoryW(0x657678+(WepID *2),SetTo,k)) -- 추가공격력
			elseif j=="Cooldown" then
				PatchInsert(SetMemoryB(0x656FB8+(WepID *1),SetTo,k)) -- 공속
			elseif j=="Splash" then
				if type(k)=="boolean" then
					if k == true then
						PatchInsert(SetMemoryB(0x6566F8+WepID,SetTo,3)) -- 스플타입(일방형)
					else
						PatchInsert(SetMemoryB(0x6566F8+WepID,SetTo,1)) -- 스플타입(스플없음)
					end
				elseif type(k)~="table" or #k~=3 then
					PushErrorMsg("Splash Inputdata Error")
				else
					PatchInsert(SetMemoryB(0x6566F8+WepID,SetTo,3)) -- 스플타입(일방형)
					PatchInsert(SetMemoryW(0x656888+(WepID*2),SetTo,k[1])) --스플 안
					PatchInsert(SetMemoryW(0x6570C8+(WepID*2),SetTo,k[2])) --스플 중
					PatchInsert(SetMemoryW(0x657780+(WepID*2),SetTo,k[3])) --스플 밖
				end
			elseif j=="RangeMin" then
				PatchInsert(SetMemory(0x656A18+(WepID *4),SetTo,k)) -- 사거리 최소
			elseif j=="RangeMax" then
				PatchInsert(SetMemory(0x657470+(WepID *4),SetTo,k)) -- 사거리 최대
			elseif j=="TargetFlag" then
				PatchInsert(SetMemoryW(0x657998 + (WepID*2), SetTo, k))
			elseif j=="UpgradeType" then
				PatchInsert(SetMemoryB(0x6571D0 + WepID, SetTo, k))
			elseif j=="ObjectNum" then
				PatchInsert(SetMemoryB(0x6564E0+WepID,SetTo,k)) -- 투사체수
			elseif j=="IconType" then
				PatchInsert(SetMemoryW(0x656780+(WepID *2),SetTo,k)) -- 아이콘
			elseif j== "Behavior" then
				PatchInsert(SetMemoryB(0x656670+WepID,SetTo,k))
			elseif j== "LaunchX" then
				PatchInsert(SetMemoryB(0x657910+WepID,SetTo,k))
			elseif j== "LaunchY" then
				PatchInsert(SetMemoryB(0x656C20+WepID,SetTo,k))
			elseif j== "LaunchSpin" then
				PatchInsert(SetMemoryB(0x657888+WepID,SetTo,k))
			elseif j== "AttackAngle" then
				PatchInsert(SetMemoryB(0x656990+WepID,SetTo,k))
			elseif j== "RemoveAfter" then
				PatchInsert(SetMemoryB(0x657040+WepID,SetTo,k))
			elseif j== "FlingyID" then
				PatchInsert(SetMemory(0x656CA8+(WepID *4),SetTo,k))
			elseif j== "WepName" then
				PatchInsert(SetMemoryW(0x6572E0+(WepID *2),SetTo,k)) -- 이름
			elseif j== "DmgType" then
				PatchInsert(SetMemoryB(0x657258+(WepID),SetTo,k)) -- 
				
			else
				PushErrorMsg("Wrong Property Name Detected!! : "..j)
			end
		end
	end

end
function Print_13_2(PlayerID,DisplayPlayer,String)
	local X = {}
	local Y = {}
	PlayerID = PlayerConvert(PlayerID)
	if type(DisplayPlayer) == "number" then
		temp = {DisplayPlayer}
		DisplayPlayer = temp
	end
	for k, P in pairs(DisplayPlayer) do
		table.insert(X,CreateUnit(1,0,"Anywhere",P))
	end
	if String ~= nil then
		table.insert(Y,print_utf8(12, 0, String))
	end
	CIf(PlayerID,Memory(0x628438,AtLeast,1))
		f_ReadX(PlayerID,0x628438,V(FuncAlloc),1,0xFFFFFF)
		DoActionsX(PlayerID,{SetMemory(0x628438,SetTo,0),X,Y})
		CVariable2(PlayerID,FuncAlloc,0x628438,SetTo,0)
	CIfEnd()
	FuncAlloc = FuncAlloc + 1
end
function Print_13X(PlayerID,TargetPlayer,String)
	local Y = {}
	if String ~= nil then
		table.insert(Y,print_utf8(12, 0, String))
	end
	CIf(PlayerID,Memory(0x628438,AtLeast,1))
		f_ReadX(PlayerID,0x628438,V(FuncAlloc),1,0xFFFFFF)
		CDoActions(PlayerID,{SetMemory(0x628438,SetTo,0),TCreateUnit(1,0,"Anywhere",TargetPlayer),Y})
		CVariable2(PlayerID,FuncAlloc,0x628438,SetTo,0)
	CIfEnd()
	FuncAlloc = FuncAlloc + 1
end

function SetUnitAbility(UnitID,WepID,Cooldown,Damage,DamageFactor,UpgradeID,ObjNum,WeaponName,DefType)
	if DefType == nil then DefType = 0 end
	SetUnitsDatX(UnitID, {Shield=false,MinCost=0,GasCost=0,SuppCost=0,Height=4,AdvFlag={0+0x20000000,4+8+0x20000000},GroundWeapon=WepID,AirWeapon=130,DefUpType=DefType,SeekRange=7,GroupFlag=0xA,
	HumanInitAct = 2,
	ComputerInitAct = 2,
	AttackOrder = 10,
	AttackMoveOrder = 2,
	IdleOrder = 2,
	RClickAct = 1,SizeL=1,SizeU=1,SizeR=1,SizeD=1
})
if ObjNum~=nil then
	SetWeaponsDatX(WepID,{WepName=WeaponName,Cooldown = Cooldown,DmgBase=Damage,DmgFactor=DamageFactor,UpgradeType=UpgradeID,RangeMax=4*32,DmgType=3,TargetFlag=2,ObjectNum=ObjNum})
else
	SetWeaponsDatX(WepID,{WepName=WeaponName,Cooldown = Cooldown,DmgBase=Damage,DmgFactor=DamageFactor,UpgradeType=UpgradeID,RangeMax=4*32,DmgType=3,TargetFlag=2})
end
end
function SetUnitAbilityT(UnitID,WepID,Cooldown,Damage,DamageFactor,UpgradeID,ObjNum,WeaponName)
	SetUnitsDatX(UnitID, {Shield=false,MinCost=0,GasCost=0,SuppCost=0,Height=4,AdvFlag={0+0x20000000,4+8+0x20000000},DefUpType=0,SeekRange=7,GroupFlag=0xA,
	HumanInitAct = 2,
	ComputerInitAct = 2,
	AttackOrder = 10,
	AttackMoveOrder = 2,
	IdleOrder = 2,
	RClickAct = 1,SizeL=1,SizeU=1,SizeR=1,SizeD=1
})

if ObjNum~=nil then
	SetWeaponsDatX(WepID,{WepName=WeaponName,Cooldown = Cooldown,DmgBase=Damage,DmgFactor=DamageFactor,UpgradeType=UpgradeID,RangeMax=4*32,DmgType=3,TargetFlag=2,ObjectNum=ObjNum})
else
	SetWeaponsDatX(WepID,{WepName=WeaponName,Cooldown = Cooldown,DmgBase=Damage,DmgFactor=DamageFactor,UpgradeType=UpgradeID,RangeMax=4*32,DmgType=3,TargetFlag=2})
end
end
function PushLevelUnit(Level,Per,Exp,UnitID,WepID,Cooldown,Damage,UpgradeID,ifTType,ObjNum)
	local WepName = {}
	WepName[1] = 1446
	WepName[12] = 1445
	WepName[24] = 1444
	WepName[48] = 1443
	WepName[72] = 1442

	if ifTType ~= nil then
		SetUnitAbilityT(UnitID,WepID,Cooldown,Damage,Damage/10,UpgradeID,ObjNum,WepName[Cooldown])
	else
		SetUnitAbility(UnitID,WepID,Cooldown,Damage,Damage/10,UpgradeID,ObjNum,WepName[Cooldown])
	end
	if Level>=26 and Level<=40 then
		SetUnitsDatX(UnitID, {GroupFlag=0xA+0x20})--Factories
	end
	SetUnitsDatX(UnitID, {Class=193})
	table.insert(LevelUnitArr,{Level,UnitID,Per,Exp})
	AutoEnchArr = CreateArr(7*#LevelUnitArr, FP)
	--AutoEnchArr2 = CreateArr(7*#LevelUnitArr, FP)
	table.insert(AutoEnchArr2,CreateCcodeArr(7))
	AutoSellArr = CreateArr(7*#LevelUnitArr, FP)
	
	
end
function PopLevelUnit()
	LevelDataArr = CreateArr(#LevelUnitArr, FP)
	BuyDataArr = CreateArr(#AutoBuyArr,FP)
	BuyDataWArr = CreateWArr(#AutoBuyArr,FP)
	for j,k in pairs(LevelUnitArr) do
		table.insert(CtrigInitArr[FP+1],SetMemX(Arr(LevelDataArr,j-1),SetTo,k[2]))
	end
	
	for j,k in pairs(AutoBuyArr) do
		table.insert(CtrigInitArr[FP+1],SetMemX(Arr(BuyDataArr,j-1),SetTo,k[1]))
		--table.insert(CtrigInitArr[FP+1],SetCWAar(WArr(BuyDataWArr,j-1),SetTo,k[2]))
	end
	SetUnitsDatX(LevelUnitArr[#LevelUnitArr][2], {DefUpType=60}) -- 최강유닛 강화확률 감추기

	GetUnitVArr = CreateVArrArr(7, #LevelUnitArr, FP)
end

function CIfKeyFunc(CP,Key,ContentStr,DisContentStr,Conditions,CondActions,DisCondActions)
	CIf(FP,{MSQC_KeyInput(CP, Key)})
	CallTrigger(FP,Call_Print13[CP+1])
	CTrigger(FP,{CDeaths(FP,AtMost,0,ShopKey[CP+1]),LocalPlayerID(CP),Conditions},{print_utf8(12,0,ContentStr)},{preserved})
	CTrigger(FP,{CDeaths(FP,AtMost,0,ShopKey[CP+1]),Conditions},{SetCDeaths(FP,SetTo,1,ShopKey[CP+1]),CondActions},{preserved})	-- 조건이 만족할 경우
	CTrigger(FP,{CDeaths(FP,AtMost,0,ShopKey[CP+1]),LocalPlayerID(CP)},{print_utf8(12,0,DisContentStr)},{preserved})
	CTrigger(FP,{CDeaths(FP,AtMost,0,ShopKey[CP+1])},{SetCDeaths(FP,SetTo,1,ShopKey[CP+1]),DisCondActions},{preserved})	-- 조건이 만족하지 않을 경우
end
function KeyFunc(CP,Key,ContentArgs) --{{1차조건배열,액션배열,출력할텍스트},...}
	CIf(FP,{MSQC_KeyInput(CP, Key)})
	for o,p in pairs(ContentArgs) do
		if o == 1 then
			CIfX(FP,p[1],p[2])
		else
			if p[1]~=nil then
				CElseIfX(p[1], p[2])
			else
				CElseX(p[2])
			end
		end
		CallTrigger(FP,Call_Print13[CP+1])
		TriggerX(FP, {LocalPlayerID(CP)},print_utf8(12,0,p[3]) ,{preserved})

	end
	CIfXEnd()
	CIfEnd()
	

end
function CIfBtnFunc(CP,ID,ContentStr,DisContentStr,Conditions,CondActions,DisCondActions)
	CIf(FP,{TMemory(_Add(MenuPtrData[CP+1],0x98/4),Exactly,0 + ID*65536)})
	CurShopCP = CP
	CurShopCond = Conditions
	CallTrigger(FP,Call_Print13[CP+1])
	CTrigger(FP,{CDeaths(FP,AtMost,0,ShopSw[CP+1]),LocalPlayerID(CP),Conditions},{print_utf8(12,0,ContentStr)},{preserved})
	CTrigger(FP,{CDeaths(FP,AtMost,0,ShopSw[CP+1]),Conditions},{SetCDeaths(FP,SetTo,1,ShopSw[CP+1]),CondActions},{preserved})	-- 조건이 만족할 경우
	CTrigger(FP,{CDeaths(FP,AtMost,0,ShopSw[CP+1]),LocalPlayerID(CP)},{print_utf8(12,0,DisContentStr)},{preserved})
	CTrigger(FP,{CDeaths(FP,AtMost,0,ShopSw[CP+1])},{SetCDeaths(FP,SetTo,1,ShopSw[CP+1]),DisCondActions},{preserved})	-- 조건이 만족하지 않을 경우
end

function BtnSetInit(CP,MenuPtr)
	CIf(FP,{CVar(FP,MenuPtr[CP+1][2],AtLeast,19025),CVar(FP,MenuPtr[CP+1][2],AtMost,19025+(1699*84))})
	CIf(FP,{TMemory(_Add(MenuPtr[CP+1],0x98/4),AtMost,0 + 227*65536)})
	MenuPtrData = MenuPtr
	MenuPtrPlayer = CP
	
end

function BtnSetEnd()
	CIfEnd()--ShopEnd
	CDoActions(FP,{
		TSetMemory(_Add(MenuPtrData[MenuPtrPlayer+1],0x98/4),SetTo,0 + 228*65536);
		TSetMemory(_Add(MenuPtrData[MenuPtrPlayer+1],0x9C/4),SetTo,228 + 228*65536);
		TSetMemoryX(_Add(MenuPtrData[MenuPtrPlayer+1],0xA0/4),SetTo,228,0xFFFF);
		SetCDeaths(FP,SetTo,0,ShopSw[MenuPtrPlayer+1])})
	CIfEnd()
	MenuPtrData = nil
	MenuPtrPlayer = nil
end


function DPSBuilding(CP,UnitPtr,Multiplier,MultiplierV,TotalDPSDest,MoneyV)
	local DPSArr = CreateVArr(96, FP)
	local VArrI = CreateVar(FP)
	local VArrI4 = CreateVar(FP)
	local TotalDPS = CreateVar(FP)
	local TotalDPS2 = CreateVar(FP)
	local DPSCheckV = CreateVar(FP)
	local DpsDest = CreateVar(FP)
	local GetMoney = CreateWar(FP)
	local DPSCheck = CreateCcode()
	local DPSCheck2 = CreateVar(FP)
	local ResetCheck = CreateCcode()
	CIfX(FP,{CV(UnitPtr,19025,AtLeast)},{AddCD(DPSCheck,1),SetCD(ResetCheck,0)})
	TriggerX(FP,{CV(DPSCheck2,96,AtLeast)},{SetV(DPSCheck2,0)},{preserved})

	CIfX(FP,{TMemory(UnitPtr,AtMost,8319999*256)})
	f_Read(FP, UnitPtr, DPSCheckV)
	CMov(FP,DpsDest,_Sub(_Mov(8320000*256),DPSCheckV))
	CTrigger(FP,{},{TSetMemory(UnitPtr,SetTo,8320000*256)},1)
	CrShift(FP, DpsDest, 8)
	CElseX()
	CMov(FP,DpsDest,0)
	CIfXEnd()


	
	ConvertVArr(FP,VArrI,VArrI4,DPSCheck2,96)
	CAdd(FP,TotalDPS,DpsDest)
	CSub(FP,TotalDPS,VArrX(DPSArr, VArrI, VArrI4))
	CMovX(FP,VArrX(DPSArr, VArrI, VArrI4),DpsDest,SetTo,nil,nil,1)
	CIfX(FP,{CV(TotalDPS,4,AtLeast)})
	f_Div(FP, TotalDPS2,TotalDPS,4)
	CElseX()
	CMov(FP,TotalDPS2,0)
	CIfXEnd()
	--CMov(FP,TotalDPS,0)
	--for j = 1, 24 do
	--	CTrigger(FP, {CD(DPSCheck,j)},{TSetNVar(DPS[j], SetTo, DpsDest)},1)
	--	CAdd(FP,TotalDPS,DPS[j])
	--end



	if type(TotalDPSDest) == "table" then
		for j,k in pairs(TotalDPSDest) do
			if type(k) == "number" then
				CDoActions(FP,{TSetMemory(k, SetTo, TotalDPS2)})
			elseif k[4] == "W" then
				f_LMov(FP,k,{TotalDPS2,0})
			elseif k[4] == "V" then
				CMov(FP,k,TotalDPS2)
			elseif k == Ore or k == Gas then
				CDoActions(FP,{TSetResources(CP, SetTo, TotalDPS2, k)})
			elseif k == nil then return nil
			else
				PushErrorMsg("TotalDPSDest InputError")
			end 
		end
	elseif type(TotalDPSDest) == "number" then
		CDoActions(FP,{TSetMemory(TotalDPSDest, SetTo, TotalDPS2)})
	elseif TotalDPSDest[4] == "W" then
		CMov(FP,TotalDPSDest,TotalDPS2)
		f_LMov(FP,TotalDPSDest,{TotalDPS2,0})
	elseif TotalDPSDest[4] == "V" then
		CMov(FP,TotalDPSDest,TotalDPS2)
	elseif TotalDPSDest == Ore or TotalDPSDest == Gas then
		CDoActions(FP,{TSetResources(CP, SetTo, TotalDPS2, TotalDPSDest)})
	elseif TotalDPSDest == nil then return nil
	else
		PushErrorMsg("TotalDPSDest InputError")
	end 


	
	DoActionsX(FP,{AddV(DPSCheck2,1)})
	--TriggerX(FP,{CD(DPSCheck,24,AtLeast)},{SetCD(DPSCheck,0)},{preserved})
		CIf(FP,{CV(DpsDest,1,AtLeast)})
		if MoneyV ~= nil then
			if Multiplier ~=  nil then
				
				f_LMov(FP, GetMoney, _LMul({DpsDest,0}, Multiplier), nil, nil, 1)
			else
				f_LMov(FP, GetMoney,{DpsDest,0},nil,nil,1)
			end
			if MultiplierV ~= nil then
				f_LMul(FP, GetMoney,GetMoney, {MultiplierV,0})
			end
			f_LAdd(FP,MoneyV,MoneyV,GetMoney)
		end

		CIfEnd()
	CIf(FP,{TMemoryX(_Add(UnitPtr,17), Exactly, 0, 0xFF00)},{SetV(UnitPtr,0)})
	local ResetArr = {}
	for nn = 0, #DPSArr-1 do
	table.insert(ResetArr,SetCVAar(VArr(DPSArr,nn), SetTo, 0))
	end
	table.insert(ResetArr,SetV(VArrI,0))
	table.insert(ResetArr,SetV(VArrI4,0))
	table.insert(ResetArr,SetV(TotalDPS,0))
	table.insert(ResetArr,SetV(TotalDPS2,0))
	table.insert(ResetArr,SetV(DPSCheckV,0))
	table.insert(ResetArr,SetV(DpsDest,0))
	table.insert(ResetArr,SetV(DPSCheck2,0))
	table.insert(ResetArr,SetCD(DPSCheck,0))
	table.insert(ResetArr,SetNWar(GetMoney, SetTo,"0"))

	if type(TotalDPSDest) == "table" then
		for j,k in pairs(TotalDPSDest) do
			if type(k) == "number" then
				table.insert(ResetArr,SetMemory(k, SetTo, 0))
			elseif k[4] == "W" then
				table.insert(ResetArr,SetNWar(k,SetTo,"0"))
			elseif k[4] == "V" then
				table.insert(ResetArr,SetV(k, 0))
			elseif k == Ore or k == Gas then
				table.insert(ResetArr,SetResources(CP, SetTo, 0, k))
			elseif k == nil then return nil
			else
				PushErrorMsg("TotalDPSDest InputError")
			end 
		end
	elseif type(TotalDPSDest) == "number" then
		table.insert(ResetArr,SetMemory(TotalDPSDest, SetTo, 0))
	elseif TotalDPSDest[4] == "V" then
		table.insert(ResetArr,SetV(TotalDPSDest,0))
	elseif TotalDPSDest == Ore or TotalDPSDest == Gas then
		table.insert(ResetArr,SetResources(CP, SetTo, 0, TotalDPSDest))
	elseif TotalDPSDest == nil then return nil
	else
		PushErrorMsg("TotalDPSDest InputError")
	end 
	DoActions2X(FP, ResetArr)

	CIfEnd()
	CElseIfX({CD(ResetCheck,0)}, {SetCD(ResetCheck,1)})
	DoActions2X(FP, ResetArr)

	CIfXEnd()
end

function Debug_DPSBuilding(UnitPtrDest,BuildingID,BuildingLoc)
	CIf(FP,{CV(UnitPtrDest,0),Memory(0x628438, AtLeast, 1)})
	f_Read(FP, 0x628438, nil, Nextptrs)
	CDoActions(FP, {TSetNVar(UnitPtrDest, SetTo, _Add(Nextptrs,2)),CreateUnit(1,BuildingID,BuildingLoc,FP)})

	CIfEnd()

end
function MSQC_KeySet(KeyName,DeathUnit,KeyNum) -- 키인식용 데스값 등록
	if KeyNum == nil then KeyNum = 1 end
	MSQC_KeyArr[KeyName] = {DeathUnit,KeyNum}
end

function MSQC_KeyInput(Player,KeyName) -- 키인식용 조건
	return Deaths(Player, Exactly, MSQC_KeyArr[KeyName][2], MSQC_KeyArr[KeyName][1])
end
function MSQC_ExportEdsTxt()
	
	os.execute("mkdir " .. "MSQC")
	local CSfile = io.open(FileDirectory .. "exmap1" .. ".txt", "w")
	io.output(CSfile)
	io.write("[MSQC]\n")
	for j,k in pairs(MSQC_KeyArr) do
		io.write(j.." = "..k[1]..","..k[2].."\n")
	end
	io.close(CSfile)
	
end

function CreateBPtrRetArr(MaxPlayer,Ptr,Multiplier)
	local X = {}
	local Y = {}
	for i = 0, MaxPlayer do
		table.insert(X,(Ptr+(i*Multiplier))%4)
		table.insert(Y,(Ptr+(i*Multiplier))-X[i+1])
	end
	return X,Y
end

function CIf_KeyFunc(KeyName)
	local KeyToggle = CreateCcode()
	TriggerX(FP, {KeyPress(KeyName, "Up")}, {SetCD(KeyToggle,0)}, {preserved})
	CIf(FP,{KeyPress(KeyName, "Down"),CD(KeyToggle,0)},{SetCD(KeyToggle,1)})
end
function KeyToggleFunc(KeyName)
	local KeyToggle = CreateCcode()
	local KeyToggle2 = CreateCcode()
	TriggerX(FP, {KeyPress(KeyName, "Up")}, {SetCD(KeyToggle,0)}, {preserved})
	TriggerX(FP, {KeyPress(KeyName, "Down"),CD(KeyToggle,0),CD(KeyToggle2,0)},{SetCD(KeyToggle,1),SetCD(KeyToggle2,1)}, {preserved})
	TriggerX(FP, {KeyPress(KeyName, "Down"),CD(KeyToggle,0),CD(KeyToggle2,1)},{SetCD(KeyToggle,1),SetCD(KeyToggle2,0)}, {preserved})
	return KeyToggle2,KeyToggle
end

function ToggleFunc(CondArr,Mode)
	local KeyToggle = CreateCcode()
	local KeyToggle2 = CreateCcode()
	if Mode ~= nil then
		DoActionsX(FP,{SetCD(KeyToggle,0)})
		TriggerX(FP, {CondArr[1],CD(KeyToggle2,1)}, {SetCD(KeyToggle2,0),SetCD(KeyToggle,1)}, {preserved})
		TriggerX(FP, {CondArr[2]}, {SetCD(KeyToggle2,1)}, {preserved})
	else
		DoActionsX(FP,{SetCD(KeyToggle,0)})
		TriggerX(FP, {CondArr[2],CD(KeyToggle2,0)}, {SetCD(KeyToggle2,1),SetCD(KeyToggle,1)}, {preserved})
		TriggerX(FP, {CondArr[1]}, {SetCD(KeyToggle2,0)}, {preserved})
	end

	return KeyToggle2,KeyToggle
end
function KeyToggleOnce(KeyName)
	local KeyToggle = CreateCcode()
	local KeyToggle2 = CreateCcode()
	DoActionsX(FP, {SetCD(KeyToggle2,0)})
	TriggerX(FP, {KeyPress(KeyName, "Up")}, {SetCD(KeyToggle,0)}, {preserved})
	TriggerX(FP, {KeyPress(KeyName, "Down"),CD(KeyToggle,0),CD(KeyToggle2,0)},{SetCD(KeyToggle,1),SetCD(KeyToggle2,1)}, {preserved})
	return KeyToggle
end

function CS__InputTA(Player,Condition,SVA1,Value,Mask,Flag)
	if Flag == nil then Flag = {preserved} elseif Flag == 1 then Flag = {} end
	TriggerX(Player,Condition,{SetCSVA1(SVA1,SetTo,Value,Mask)},Flag)
end
function DisplayPrint(TargetPlayers,arg)
	if TargetPlayers == CurrentPlayer or TargetPlayers == "CP" then
		f_SaveCp()
	end

	local BSize = 0
	for j,k in pairs(arg) do -- StrSizeCalc
		if type(k) == "string" then
			local CT = GetStrSize(0,k)
			BSize=BSize+CT
		elseif type(k)=="table" and k[1] == "PVA" then -- PNameVArr 우회전용
			BSize = BSize+(4*5)
		elseif type(k)=="table" and k[4]=="V" then
			BSize=BSize+(4*4)
		elseif type(k)=="table" and k[1][4]=="V" then -- VarArr일 경우
			BSize = BSize+#k
		elseif type(k)=="number" then -- 상수index V 입력, string.char 구현용. 맨앞 0xFF영역만 사용
			BSize=BSize+1
		else
			PushErrorMsg("Print_Inputdata_Error")
		end
	end
	
	local StrT = "\x0D\x0D\x0DSI"..dp.StrXIndex..string.rep("\x0D", BSize+3)
	local RetV = CreateVar(FP)
	local Dev = 0
	table.insert(dp.StrXKeyArr,{RetV,StrT})
	dp.StrXIndex=dp.StrXIndex+1
	for j,k in pairs(arg) do
		if type(k) == "string" then
			local CT = CreateCText(FP,k)
			table.insert(dp.StrXPatchArr,{RetV,Dev,CT})
			Dev=Dev+CT[2]
		elseif type(k)=="table" and k[1] == "PVA" then -- PNameVArr 우회전용
			if k[2] == "LocalPlayerID" then
				table.insert(dp.StrXPNameArr,{RetV,Dev,dp.LPNameVArr})
			else
				table.insert(dp.StrXPNameArr,{RetV,Dev,dp.PNameVArrArr[k[2]]})
			end
			Dev=Dev+(4*5)
		elseif type(k)=="table" and k[4]=="V" then
			CMov(FP,dp.publicItoDecV,k)
			CallTrigger(FP,dp.Call_IToDec)
			f_Movcpy(FP,_Add(RetV,Dev),VArr(dp.publicItoDecVArr,0),4*4)
			Dev=Dev+(4*4)
		elseif type(k)=="table" and k[1][4]=="V" then -- VarArr일 경우
			for o,p in pairs(k) do
				CDoActions(FP,{TBwrite(_Add(RetV,Dev),SetTo,p)})
				Dev=Dev+(1)
			end

		elseif type(k)=="number" then -- 상수index V 입력, string.char 구현용. 맨앞 0xFF영역만 사용
			CDoActions(FP,{TBwrite(_Add(RetV,Dev),SetTo,V(k))})
			Dev=Dev+(1)

		else
			PushErrorMsg("Print_Inputdata_Error")
		end
	end
	if TargetPlayers==CurrentPlayer or TargetPlayers=="CP" then
		CDoActions(FP,{TSetMemory(0x6509B0,SetTo,BackupCp),DisplayText(StrT,4)})
	elseif type(TargetPlayers)=="table" and TargetPlayers[4]=="V" then
		CDoActions(FP,{TSetMemory(0x6509B0,SetTo,TargetPlayers),DisplayText(StrT,4)})

	else
		DoActions2(FP,{RotatePlayer({DisplayText(StrT,4)},TargetPlayers,FP)})
	end
end

function print_utf8_2(line, offset, string)
    local ret = {}
    local dst = 0x640B60 + line * 218 + offset
	
    if type(string) == "string" then
        local str = string
        local n = 1
        if dst % 4 >= 1 then
            for i = 1, dst % 4 do str = '\x0d'..str end
        end
        local t = cp949_to_utf8(str)
        while n <= #t do
			
            ret[#ret+1] = SetMemory(dst - dst % 4 +n-1, SetTo, _dw(t, n))
            n = n + 4
        end
    elseif type(string) == "number" then
        PushErrorMsg("print_utf8_InputError")
    end
    return ret
end


function DisplayPrintEr(TargetPlayer,arg)
	local Dev = 0
	local RetAct = {}
	local ItoDecKey = {}
	local ItoNameKey = {}
	local VCharKey = {}
	


	for j,k in pairs(arg) do
		if type(k) == "string" then
			local Strl = GetStrSize(0,k)
			if Strl%4~=0 then k=string.rep("\x0D", (4-Strl%4))..k Strl=Strl+(4-Strl%4) end
			table.insert(RetAct,print_utf8_2(12, Dev, k))
			
			Dev=Dev+Strl
		elseif type(k)=="table" and k[1] == "PVA" then -- PNameVArr 우회전용
			table.insert(ItoNameKey,{k[2],Dev})
			Dev=Dev+(4*5)
		elseif type(k)=="table" and k[4]=="V" then
			table.insert(RetAct,print_utf8_2(12, Dev, string.rep("\x0D", 16)))
			--V,Dev
			table.insert(ItoDecKey,{k,Dev})
			Dev=Dev+(4*4)
		elseif type(k)=="number" then -- 상수index V 입력, string.char 구현용. 맨앞 0xFF영역만 사용
			table.insert(RetAct,print_utf8_2(12, Dev, string.rep("\x0D", 1)))
			table.insert(VCharKey,{k,Dev})
			Dev=Dev+(1)

		else
			PushErrorMsg("Print_Inputdata_Error")
		end
	end
	if type(TargetPlayer) == "table" and TargetPlayer[4] == "V" then
		Print_13X(FP, TargetPlayer)
	else
		CallTrigger(FP, Call_Print13[TargetPlayer+1])
	end
	CIf(FP, {TMemory(0x512684,Exactly,TargetPlayer)})
	DoActions2(FP, RetAct)
	for j,p in pairs(ItoDecKey) do
		local k = p[1]
		CMov(FP,dp.publicItoDecV,k)
		CallTrigger(FP,dp.Call_IToDec)
		f_Movcpy(FP,0x640B60 + (12 * 218)+p[2],VArr(dp.publicItoDecVArr,0),4*4)
	end
	for j,p in pairs(ItoNameKey) do
		local k = p[1]
		if k == "LocalPlayerID" then
			f_Movcpy(FP,0x640B60 + (12 * 218)+p[2],VArr(dp.LPNameVArr,0),4*5)
		else
			f_Movcpy(FP,0x640B60 + (12 * 218)+p[2],VArr(dp.PNameVArrArr[k],0),4*5)
		end
	end
	for j,p in pairs(VCharKey) do
		CDoActions(FP,{TBwrite(0x640B60+p[2],SetTo,V(p[1]))})
	end
	
	CIfEnd()

end
function init_StrX()
	for k, v in pairs(dp.StrXKeyArr) do
		f_GetStrXptr(FP,v[1],v[2])
	end
	for k, v in pairs(dp.StrXPatchArr) do -- STRXPtr,Deviation,CTextData
		if v[2]==0 then
			f_Memcpy(FP,v[1],_TMem(Arr(v[3][3],0),"X","X",1),v[3][2])
		else
			f_Memcpy(FP,_Add(v[1],v[2]),_TMem(Arr(v[3][3],0),"X","X",1),v[3][2])
		end
	end

	for k, v in pairs(dp.StrXPNameArr) do -- STRXPtr,Deviation,PNameVArr
		f_Movcpy(FP,_Add(v[1],v[2]),VArr(v[3],0),4*5)
	end

end
function init_Setting()
	CJump(FP, dp.CustominitJump)
	for i = 0, 6 do
		ItoName(FP,i,VArr(dp.PNameVArrArr[i+1],0),ColorCode[i+1])
		_0DPatchforVArr(FP,dp.PNameVArrArr[i+1],4)

		if dp.LocOption ~=nil then
			CIf(FP,{LocalPlayerID(i)})--로컬
			ItoName(FP,i,VArr(dp.LPNameVArr,0),ColorCode[i+1])
			_0DPatchforVArr(FP,dp.LPNameVArr,4)
			CIfEnd()
		end
	end

	init_StrX()
	
	DoActionsX(FP,{SetNext(dp.initTrigIndex, dp.initTrigIndex,1),SetNext("X", dp.initTrigIndex,1)},1,dp.lastTrigIndex)--RecoverNext

	local SCJump = def_sIndex()
	CJump(FP,SCJump)
	SetCall2(FP, dp.Call_IToDec)
	ItoDec(FP,dp.publicItoDecV,VArr(dp.publicItoDecVArr,0),2,nil,0)
	SetCallEnd2()
	CJumpEnd(FP,SCJump)
	CJumpEnd(FP, dp.CustominitJump)
end

function Start_init(LocOption)
	dp={}
	dp.LocOption = LocOption
	if dp.LocOption ~=nil then
		dp.LPNameVArr = CreateVArr(5,FP)
	end
	dp.ColorCode = {0x08,0x0E,0x0F,0x10,0x11,0x15,0x16}
	dp.PNameVArrArr = CreateVArrArr(7, 5, FP)
	dp.CustominitJump = def_sIndex()
	dp.initTrigIndex = FuncAlloc
	FuncAlloc=FuncAlloc+1
	dp.lastTrigIndex = FuncAlloc
	FuncAlloc=FuncAlloc+1
	dp.StrXKeyArr = {}
	dp.StrXPatchArr = {}
	dp.StrXPNameArr = {}
	dp.StrXIndex = 0
	dp.publicItoDecVArr =CreateVArr(4,FP)
	dp.publicItoDecV = CreateVar(FP)
	dp.Call_IToDec = CreateCallIndex()
	
function _0DPatchforVArr(Player,VArrName,VArrLength) -- CtrigAsm 5.1
	for j=0, VArrLength do
		for k=0, 3 do
		TriggerX(Player,{VArrayX(VArr(VArrName,j),"Value",Exactly,0,255*(256^k))},{
		SetVArrayX(VArr(VArrName,j),"Value",SetTo,(256^k)*0x0D,255*(256^k))})
		end
	end
end
function PName(Player) -- "LocalPlayerID" = LocalPName
	return {"PVA",Player}
end
	DoActionsX(FP, {SetNext("X", dp.CustominitJump+JumpStartAlloc,1),SetNext(dp.lastTrigIndex, "X",1)}, 1,dp.initTrigIndex)
end
function dwread_epd(Ptr,EPDFlag) -- v=EPD
	local RetV= CreateVar(FP)
	if EPDFlag == 1 then
		f_Read(FP,Ptr,nil,RetV,nil,1)
	else
		f_Read(FP,Ptr,RetV,nil,nil,1)
	end
	return RetV
end

function VRange(Var,Left,Right)
	return {CV(Var,Left,AtLeast),CV(Var,Right,AtMost)}
	
end

function Byte_NumSet(Var,DestVar,DivNum,Mask,DestInitVar,NBit)
	if DestInitVar==nil then DestInitVar=0 end
	CMov(FP,DestVar,DestInitVar)
	if NBit==nil then NBit=3 end
	for i = NBit, 0, -1 do
		TriggerX(FP,{NVar(Var,AtLeast,(2^i)*DivNum)},{SetNVar(Var,Subtract,(2^i)*DivNum),SetNVar(DestVar, Add, (2^i)*Mask)},{preserved})
	end
end

function SetEPerStr(VarArr)
	TriggerX(FP,{CV(VarArr[1],0x30,AtMost)},{SetV(VarArr[1],0x0D)},{preserved})
	TriggerX(FP,{CV(VarArr[1],0x30,AtMost),CV(VarArr[2],0x30,AtMost)},{SetV(VarArr[2],0x0D)},{preserved})
	TriggerX(FP,{CV(VarArr[6],0x30,AtMost)},{SetV(VarArr[6],0x0D)},{preserved})
	TriggerX(FP,{CV(VarArr[6],0x30,AtMost),CV(VarArr[5],0x30,AtMost)},{SetV(VarArr[5],0x0D)},{preserved})
	
end
local MLT = {}
for i = 1, 11 do
	MLT[i] = 112+((i-1)*16)
end
function MLine(Var,Line)--1~11
	return {CV(Var,MLT[Line],AtLeast),CV(Var,MLT[Line]+12,AtMost)}
end


function AutoBuy(CP,LvUniit,Cost)--Cost==String
	CIf(FP,{Memory(0x628438,AtLeast,1),CV(iv.AutoBuyCode[CP+1],LvUniit)})
		CIf(FP, {TTNWar(iv.Money[CP+1],AtLeast,Cost)})
			f_LSub(FP, iv.Money[CP+1], iv.Money[CP+1], Cost)
			CreateUnitStacked({}, 1, LevelUnitArr[LvUniit][2], 43+CP,nil, CP)
		CIfEnd()
	CIfEnd()
end
--
--function HumanCheck(Player,Status)
--	if Status == 1 then return nil else return Never() end
--end