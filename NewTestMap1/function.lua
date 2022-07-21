
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
function Install_UnitCount(Player)
	count = CreateVar(FP)
	local ExUArr={5,30,17,3,23,25}
	local countT=CreateVarArr(6, FP)
	function Cast_UnitCount()
		UnitReadX(Player,AllPlayers,229,64,count)
		for j,k in pairs(ExUArr) do
			UnitReadX(Player,AllPlayers,k,nil,countT[j])
			CAdd(Player,count,countT[j])
		end
	end
end


function TriggerX(Player, Conditions, Actions, Flags, Index)
	if Index == nil then
		Index = 0
	end
	if type(Conditions[1])=="table" then
		for j,k in pairs(Conditions) do
			if type(k)=="string" then
				PushErrorMsg("DoActions2X Input Error")
			end
		end
	end
	if type(Actions[1])=="table" then
		for j,k in pairs(Actions) do
			if type(k)=="string" then
				PushErrorMsg("DoActions2X Input Error")
			end
		end
	end

	Trigger {
				players = {Player},
				conditions = {
					Label(Index);
					Conditions,
				},
				actions = {
					Actions,
				},
				flag = {
					Flags,
				}
			}
end


function DoActionsX(PlayerID,Actions,Flags,Index)
	if Index == nil then
		Index = 0
	end
	if Flags == nil then
		Flags = {preserved}
	elseif Flags == 1 then
		Flags = {}
	end
	if type(Actions[1])=="table" then
		for j,k in pairs(Actions) do
			if type(k)=="string" then
				PushErrorMsg("DoActions2X Input Error")
			end
		end
	end
	Trigger {
		players = {PlayerID},
		conditions = {
			Label(Index);
		},
		actions = {
			Actions,
		},
		flag = {
			Flags,
		},
	}
end

function DoActions2X(PlayerID,Actions,Flags)
	if type(Actions[1])=="table" then
		for j,k in pairs(Actions) do
			if type(k)=="string" then
				PushErrorMsg("DoActions2X Input Error")
			end
		end
	end
	local k = 1
	local Size = #Actions

	if Flags == nil then
		Flags = {preserved}
	elseif Flags == 1 then
		Flags = {}
	end

	local Act = {}
	for i = 1, Size do
		if type(Actions[i][1]) == "table" and #Actions[i][1] == 10 then
			for j = 1, #Actions[i] do
				table.insert(Act,Actions[i][j])
			end
		else
			table.insert(Act,Actions[i])
		end
	end
	Size = #Act

	while k <= Size do
		if Size - k + 1 >= 64 then
			local X = {}
			for i = 0, 63 do
				table.insert(X, Act[k])
				k = k + 1
			end
			Trigger {
					players = {PlayerID},
					conditions = {
						Label(0);
					},
					actions = {
						X,
					},
					flag = {
						Flags,
					},
				}
		else
			local X = {}
			repeat
				table.insert(X, Act[k])
				k = k + 1
			until k == Size + 1
			Trigger {
					players = {PlayerID},
					conditions = {
						Label(0);
					},
					actions = {
						X,
					},
					flag = {
						Flags,
					},
				}
		end
	end
end



function LocalPlayerID(Player,Type)
	if Type == nil then
		Type = Exactly
	end
	if Player == nil then
		return {Memory(0x512684,AtLeast,0),Memory(0x512684,AtMost,7)}
	else
		if Player == "Ob1" then
			Player = 128
		elseif Player == "Ob2" then
			Player = 129
		elseif Player == "Ob3" then
			Player = 130
		elseif Player == "Ob4" then
			Player = 131
		end
		return Memory(0x512684,Type,Player)
	end
end










function SetWeaponGrp(WepID,FlingyID,SpriteID,ImageID,IscriptID)
	PatchInsert(SetMemory(0x656CA8+(WepID *4),SetTo,FlingyID))
	PatchInsert(SetMemoryW(0x6CA318+(FlingyID *2),SetTo,SpriteID))
	PatchInsert(SetMemoryW(0x666160+(SpriteID*2),SetTo,ImageID))
	PatchInsert(SetMemory(0x66EC48+(ImageID*4),SetTo,IscriptID))
end
--DatEdit

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
			else
				PushErrorMsg("Wrong Property Name Detected!! : "..j)
			end
		end
	end

end

function SetZealotUnit(UnitID,HP,Shield,WepID,WepDamage,ClockingFlag,HighSpeed,Color,ForPlayer,LHPStr)

	PatchInsert2(SetMemoryB(0x662180 + UnitID,SetTo,0))
	PatchInsert2(SetMemoryB(0x6644F8+UnitID,SetTo,49)) -- Graphic
	PatchInsert2(SetMemoryB(0x662098+UnitID,SetTo,1))--RClickAct
	PatchInsert2(SetMemoryB(0x662268+UnitID,SetTo,2))--Human InitAct
	PatchInsert2(SetMemoryB(0x662EA0+UnitID,SetTo,2))--Computer InitAct
	PatchInsert2(SetMemoryB(0x663320+UnitID,SetTo,10))--AttackOrder
	PatchInsert2(SetMemoryB(0x663A50+UnitID,SetTo,2))--AttackMoveOrder
	PatchInsert2(SetMemoryB(0x664898+UnitID,SetTo,2))--IdleOrder
	if ClockingFlag == 1 then
		PatchInsert2(SetMemoryX(0x664080 + (UnitID*4),SetTo,402653184+4194816,0xFFFFFFFF))
	else
		PatchInsert2(SetMemoryX(0x664080 + (UnitID*4),SetTo,402653184,0xFFFFFFFF))
	end
	PatchInsert2(SetMemoryB(0x65FEC8 + UnitID,SetTo,0)) -- Armor
	if HP>=8320000 then
		PatchInsert2(SetMemory(0x662350 + (UnitID*4),SetTo,8320000*256)) -- HP
	else
		PatchInsert2(SetMemory(0x662350 + (UnitID*4),SetTo,HP*256)) -- HP
	end
	PatchInsert2(SetMemoryW(0x660E00 + (UnitID *2), SetTo, Shield))--Shield
	PatchInsert2(SetMemoryB(0x6647B0 + UnitID,SetTo,1))--ShieldUsage
	PatchInsert2(SetMemoryB(0x6637A0+UnitID,SetTo,4)) -- GroupFlag
	PatchInsert2(SetMemoryW(0x663408+(UnitID *2),SetTo,0))--BuildScore
	PatchInsert2(SetMemoryW(0x663EB8+(UnitID *2),SetTo,0))--KillScore
	PatchInsert2(SetMemoryB(0x662DB8+UnitID,SetTo,3)) -- SeekRange
	PatchInsert2(SetMemoryB(0x663238+UnitID,SetTo,7)) -- SightRange
	PatchInsert2(SetMemoryB(0x660FC8+UnitID,SetTo,0x41))--MovementFlag
	PatchInsert2(SetMemoryW(0x662F88+(UnitID *2),SetTo,40)) --Portrait
	PatchInsert2(SetMemory(0x662860 + (UnitID*4),SetTo,23+(27*65536))) -- 건설크기
	PatchInsert2(SetMemoryB(0x6616E0+UnitID,SetTo,130))--AirWeapon
	PatchInsert2(SetMemoryB(0x6636B8+UnitID,SetTo,WepID)) -- GndWeapon
	PatchInsert2(SetMemory(0x6617C8 + (UnitID*8),SetTo,(2)+(2*65536))) --Size
	PatchInsert2(SetMemory(0x6617CC + (UnitID*8),SetTo,(2)+(2*65536))) --Size
	PatchInsert2(SetMemoryB(0x663150+UnitID,SetTo,4))--Elevation
	PatchInsert2(SetMemoryB(0x6605F0+UnitID,SetTo,32)) -- StartDirection
	PatchInsert2(SetMemory(0x657470+(WepID *4),SetTo,32)) -- 사거리
	PatchInsert2(SetMemory(0x656CA8+(WepID *4),SetTo,0)) -- 그래픽
	PatchInsert2(SetMemoryW(0x656EB0+(WepID *2),SetTo,WepDamage)) -- 공격력
	PatchInsert2(SetMemoryW(0x657678+(WepID *2),SetTo,0)) -- 추가공격력
	PatchInsert2(SetMemoryW(0x6572E0+(WepID *2),SetTo,283)) -- 이름
	PatchInsert2(SetMemoryW(0x656780+(WepID *2),SetTo,353)) -- 아이콘
	PatchInsert2(SetMemoryB(0x656670+WepID,SetTo,5)) -- 공격유닛에서나옴
	PatchInsert2(SetMemoryB(0x656FB8+WepID,SetTo,1)) -- 공속
	PatchInsert2(SetMemoryB(0x6564E0+WepID,SetTo,2)) -- 투사체수
	table.insert(ZealotUIDArr,{UnitID,HighSpeed,Color,ForPlayer,WepDamage*2,HP,LHPStr})
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
					end
				else
					PatchInsert(SetMemoryB(0x6647B0 + UnitID,SetTo,1))
					PatchInsert(SetMemoryW(0x660E00 + (UnitID *2), SetTo, k))
				end
			elseif j=="BdDimX"  then
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
			elseif j=="isHero" then
				if type(k)=="boolean" then
					if k==true then
						table.insert(HeroArr,UnitID)
					end
				else
					PushErrorMsg("isHero TypeError")
				end
			elseif j=="Reqptr" then
				PatchInsertPrsv(SetMemoryW(0x660A70+(UnitID*2), SetTo, k))
			elseif j== "SeekRange" then
				PatchInsert(SetMemoryB(0x662DB8+UnitID,SetTo,k)) -- SeekRange
			elseif j== "Graphic" then
				PatchInsert(SetMemoryB(0x6644F8+UnitID,SetTo,k)) -- Graphic
			else
				PushErrorMsg("Wrong Property Name Detected!! : "..j)
			end
			
		end
	end
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
	PatchInsert(SetMemoryB(0x58D088+(Upgrade)+(46*4),SetTo,Value)) -- 최대업글렙
	PatchInsert(SetMemoryB(0x58D088+(Upgrade)+(46*5),SetTo,Value)) -- 최대업글렙
	PatchInsert(SetMemoryB(0x58D088+(Upgrade)+(46*6),SetTo,Value)) -- 최대업글렙
	PatchInsert(SetMemoryB(0x58D088+(Upgrade)+(46*7),SetTo,Value)) -- 최대업글렙
end

function SetUpgradeInit(Upgrade,Value)
	PatchInsert(SetMemoryB(0x58D2B0+(Upgrade)+(46*0),SetTo,Value)) -- 최대업글렙
	PatchInsert(SetMemoryB(0x58D2B0+(Upgrade)+(46*1),SetTo,Value)) -- 최대업글렙
	PatchInsert(SetMemoryB(0x58D2B0+(Upgrade)+(46*2),SetTo,Value)) -- 최대업글렙
	PatchInsert(SetMemoryB(0x58D2B0+(Upgrade)+(46*3),SetTo,Value)) -- 최대업글렙
	PatchInsert(SetMemoryB(0x58D2B0+(Upgrade)+(46*4),SetTo,Value)) -- 최대업글렙
	PatchInsert(SetMemoryB(0x58D2B0+(Upgrade)+(46*5),SetTo,Value)) -- 최대업글렙
	PatchInsert(SetMemoryB(0x58D2B0+(Upgrade)+(46*6),SetTo,Value)) -- 최대업글렙
	PatchInsert(SetMemoryB(0x58D2B0+(Upgrade)+(46*7),SetTo,Value)) -- 최대업글렙
end


function SetFlingySpeed(FID,Value)
	PatchInsert(SetMemory(0x6C9EF8+(4*FID),SetTo,Value))--최고속도
	PatchInsert(SetMemoryW(0x6C9C78+(2*FID),SetTo,Value))--가속도
end



function IBGM_EPD(PlayerID,TargetPlayer,Input,WAVData,AlertWav) -- {{1,"1.Wav",Length1},{2,"2.Wav",Length2},...,{N,"N.Wav",LengthN}}
	STPopTrigArr(PlayerID)	
	local Arr = CreateVarArr(3,PlayerID) -- Temp / ΔT / Delay 

	f_Read(PlayerID,0x51CE8C,Arr[1])

	CNeg(PlayerID,Arr[1])

	f_Diff(PlayerID,Arr[2],Arr[1],nil,nil,nil,1)

	CSub(PlayerID,Arr[3],Arr[2])

	local Cond1, Act1, Cond2
	if type(Input) == "number" then
		Cond1 = Memory(Input,AtLeast,1)
		Act1 = SetMemory(Input,SetTo,0)
	elseif Input[4] == "V" then
		Cond1 = NVar(Input,AtLeast,1)
		Act1 = SetNVar(Input,SetTo,0)
	else
		Cond1 = CtrigX(Input[1],Input[2],Input[3],Input[4],AtLeast,1)
		Act1 = SetCtrig1X(Input[1],Input[2],Input[3],Input[4],SetTo,0)
	end

	CIfX(PlayerID,{NVar(Arr[3],Exactly,0),Cond1})
		for k, v in pairs(WAVData) do
			if type(Input) == "number" then
				Cond2 = Memory(Input,Exactly,v[1])
			elseif Input[4] == "V" then
				Cond2 = NVar(Input,Exactly,v[1])
			else
				Cond2 = CtrigX(Input[1],Input[2],Input[3],Input[4],Exactly,v[1])
			end
			Trigger {players = {PlayerID},
				conditions = {
					Label(0);
					Cond2;
				},
				actions = {
					Act1;
					CopyCpActionX({PlayWAVX(v[2]),PlayWAVX(v[2])},TargetPlayer);
					SetNVar(Arr[3],Add,v[3]);
				},
				flag = {preserved}
			}
		end
	CElseIfX({NVar(Arr[3],AtLeast,1),Cond1},Act1)
		if AlertWav ~= nil then
			Trigger {players = {PlayerID},
				conditions = {
					Label(0);
				},
				actions = {
					CopyCpActionX({PlayWAVX(AlertWav)},TargetPlayer);
				},
				flag = {preserved}
			}
		end
	CIfXEnd()
end

function UnitLimit(Player,UID,Limit)
	Trigger {
		players = {Player},
		conditions = {
			Bring(Player,AtLeast,Limit+1,UID,64);
			},
		
		actions = {
			KillUnitAt(1,UID,"Anywhere",Player);
			PreserveTrigger();
		},
	}
end


function GetiTblId(PlayerId,TBLIndex,Size)
	local V = CreateVar(PlayerId)
	table.insert(iTBLIndexArr,{TBLIndex,PlayerId,V,Size})
	return {V,TBLIndex,Size}
end


function Install_EXCC(Player,ArrSize,ResetFlag) -- 확장 구조오프셋 단락 전용 배열 구성하기
	local HeaderV = CreateVar(Player) -- 헤더가 저장된 V
	local EXCunitTemp = CreateVarArr(ArrSize,Player) -- 구조오프셋 확장 변수 TempV
	local Index = FuncAlloc -- FuncAlloc에서 라벨 받아옴
	FuncAlloc = FuncAlloc + 3
	table.insert(CtrigInitArr[Player+1],SetCtrigX(Player,HeaderV[2],0x15C,0,SetTo,Player,Index+2,0x15C,1,1))--{"X",EXCC_Forward,0x15C,1,2}--CC_Header
	local EXCUnitArr = {}
	for k, v in pairs(EXCunitTemp) do
		table.insert(EXCUnitArr,SetCVar("X",v[2],SetTo,0))
	end

	if ResetFlag ~= nil then
		if type(ResetFlag) == "number" then
			local EXCunit_Reset = {} -- 필요시 리셋 또는 값 조정 테이블
			for i = 1, #EXCunitTemp do
				table.insert(EXCunit_Reset,SetCtrig1X("X","X",CAddr("Value",i,0),0,SetTo,0))
			end
			return {Player,Index,HeaderV,EXCunitTemp,EXCUnitArr,EXCunit_Reset}
		elseif type(ResetFlag) == "table" then
			local EXCunit_Reset = {} -- 필요시 리셋 또는 값 조정 테이블(타이머or값초기화 등)
			for i = 1, #EXCunitTemp do
				if ResetFlag[i]~= nil then
					if type(ResetFlag[i]) == "table" then
						local X = ResetFlag[i]
						local RFValue = X[1]
						local RFType
						local RFMask
						if X[2] == nil then
							RFType = SetTo
						else
							RFType = X[2]
						end
						if X[3] == nil then
							RFMask = 0xFFFFFFFF
						else
							RFMask = X[3]
						end

						table.insert(EXCunit_Reset,SetCtrig1X("X","X",CAddr("Value",i,0),0,RFType,RFValue,RFMask))
					else
						PushErrorMsg("ResetFlag_Inputdata_Error")
					end
				end
			end
			return {Player,Index,HeaderV,EXCunitTemp,EXCUnitArr,EXCunit_Reset}
		end
	else
		return {Player,Index,HeaderV,EXCunitTemp,EXCUnitArr}
	end
end
function Set_EXCC2(EXCC_init,CUnitIndex,Line,Type,Value) -- EXCC단락 외부에서 값을 쓰고싶을때. 무조건 T액션, 너무많이 쓸 경우 성능 하락 우려 있음
	return TSetMemory(_Add(_Mul(CUnitIndex,_Mov(0x970/4)),_Add(EXCC_init[3],((0x20*Line)/4))),Type,Value)
end
function Set_EXCC2X(EXCC_init,CUnitIndex,Line,Type,Value,Mask) -- EXCC단락 외부에서 값을 쓰고싶을때. 무조건 T액션, 너무많이 쓸 경우 성능 하락 우려 있음
	return TSetMemoryX(_Add(_Mul(CUnitIndex,_Mov(0x970/4)),_Add(EXCC_init[3],((0x20*Line)/4))),Type,Value,Mask)
end

function Set_EXCC(Line,Type,Value) -- EXCC단락 내부에서 값을 쓰고싶을때. 실제값 X
	return SetV(EXCC_TempVarArr[Line+1],Value,Type)
end
function Set_EXCCX(Line,Type,Value,Mask) -- EXCC단락 내부에서 값을 쓰고싶을때. 실제값
	if Mask == nil then Mask = 0xFFFFFFFF end
	return TSetMemoryX(_Add(EXCC_TempHeader,((0x20*Line)/4)),Type,Value,Mask)
end


function Cond_EXCC(Line,Type,Value,Mask) -- EXCC단락 내부에서 값을 검사하고 싶을때.
	return CVar(FP,EXCC_TempVarArr[Line+1][2],Type,Value,Mask)
end
function Cond_EXCC2(EXCC_init,CUnitIndex,Line,Type,Value) -- EXCC단락 외부에서 값을 검사하고 싶을때.
	return TMemory(_Add(_Mul(CUnitIndex,_Mov(0x970/4)),_Add(EXCC_init[3],((0x20*Line)/4))),Type,Value)
end
function _Cond_EXCC2(EXCC_init,CUnitIndex,Line,Type,Value) -- EXCC단락 외부에서 값을 검사하고 싶을때. TTOR전용
	return _TMemory(_Add(_Mul(CUnitIndex,_Mov(0x970/4)),_Add(EXCC_init[3],((0x20*Line)/4))),Type,Value)
end
EXCC_initArr = {}
function EXCC_Part1(EXCC_init,Actions)
	if #EXCC_initArr ~= 0 then
		PushErrorMsg("EXCCinitArr_Already_Loading")
	end
	EXCC_initArr = EXCC_init
	EXCC_Player = EXCC_initArr[1]
	EXCC_Index = EXCC_initArr[2]
	EXCC_TempVarArr = EXCC_initArr[4]
	PlayerID = EXCC_Player
	EXCC_TempHeader = CreateVar(EXCC_Player)
	PlayerID = PlayerConvert(PlayerID)
	Trigger { -- Cunit Ctrig Start
		players = {PlayerID},
		conditions = { 
			Label(0);
		},
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",EXCC_Index+2,0,0,1); 
		},
		flag = {preserved}
	}	
	Trigger { -- Cunit Calc Selector
		players = {PlayerID},
		conditions = { 
			Label(EXCC_Index);
		},
		actions = {
			SetDeathsX(0,SetTo,0,0,0xFFFFFFFF); -- RecoverNext
			Actions,
		},
		flag = {preserved}
	}	
	
end
-- NJump Trig 삽입 부분 (조건만족시 Jump)
function EXCC_Part2()
	PlayerID = EXCC_Player
	PlayerID = PlayerConvert(PlayerID)
	for k, P in pairs(PlayerID) do
		Trigger { -- Cunit Calc Last
			players = {P},
			conditions = { 
				Label(EXCC_Index+1);
			},
		   	actions = {
				SetDeathsX(0,SetTo,0,0,0xFFFFFFFF); -- RecoverNext
				SetMemory(0x6509B0,SetTo,P);
			},
			flag = {preserved}
		}	
	end
end
function EXCC_Part3X()
	MoveCpValue = 0
	PlayerID = EXCC_Player
	Trigger { -- Cunit Calc Start
		players = {PlayerID},
		conditions = { 
			Label(EXCC_Index+2);
		},
		flag = {preserved}
	}	
end

function EXCC_Part4X(LoopIndex,Conditions,Actions)
	MoveCpValue = 0
	PlayerID = EXCC_Player
	Trigger { -- Cunit Calc Main
		players = {PlayerID},
		conditions = { 
			Label(0);
			Conditions,
		},
		actions = { 
		EXCC_initArr[5],
		SetCtrigX("X","X",0x4,0,SetTo,"X",EXCC_Index,0,0,0);
		SetCtrigX("X",EXCC_Index+1,0x4,0,SetTo,"X","X",0,0,1);
		SetCtrigX("X",EXCC_Index,0x158,0,SetTo,"X","X",0x4,1,0);
		SetCtrigX("X",EXCC_Index,0x15C,0,SetTo,"X","X",0,0,1);
		SetCtrigX("X",EXCC_TempHeader[2],0x15C,0,SetTo,"X","X",0x15C,1,0),
		SetMemory(0x6509B0,SetTo,19025 + (84 * LoopIndex));
		Actions,
		EXCC_initArr[6]
			},
		flag = {preserved}
	}		
end

	
function EXCC_ClearCalc(Actions)
	PlayerID = EXCC_Player
	Trigger { -- Cunit Calc End
		players = {PlayerID},
		conditions = { 
			Label(0);
		}, 
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",EXCC_Index+1,0,0,0);
			Actions
		},
		flag = {preserved}
	}	
end

function EXCC_BreakCalc(Conditions,Actions)	
	PlayerID = EXCC_Player
	STPopTrigArr(PlayerID)
	TTPopTrigArr(PlayerID)
	Conditions = PopCondArr(Conditions)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,3)

	Trigger { -- Cunit Calc Break
		players = {PlayerID},
		conditions = { 
			Label(0);
			Conditions,
		}, 
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",EXCC_Index+1,0,0,0);
			SetCtrigX("X",EXCC_Index+1,0x158,0,SetTo,"X","X",0x4,1,0);
			SetCtrigX("X",EXCC_Index+1,0x15C,0,SetTo,"X","X",0,0,1);
			Actions,
		},
		flag = {preserved}
	}	
end

function EXCC_End()
	EXCC_Index = nil
	EXCC_Player = nil
	EXCC_initArr = {}
	EXCC_TempHeader = nil
end
	

function CS_OverlapShape(Shape,...)
	local RetShape = Shape

	local arg = table.pack(...)
	for k = 1, arg.n do
		RetShape[1] = RetShape[1] + arg[k][1]
		for i = 1, arg[k][1] do
			table.insert(RetShape,{arg[k][i+1][1],arg[k][i+1][2]})
		end
	end
	return RetShape	
end
function CSMakeTornado(Point,Radius,Angle,Numner,Outside,StartNumber)
	local Shape = {0}
	if StartNumber == nil then StartNumber = 1 end
	for i = StartNumber, Numner do
		CS_OverlapShape(Shape,CSMakePolygon(Point,i*Radius,i*Angle,Point+1,0))
	end
	if Outside~=nil then
		return CS_Rotate((CS_OverlapShape(Shape,CSMakePolygon(Point,Radius,Numner*Angle,PlotSizeCalc(Point,Numner),PlotSizeCalc(Point,Numner-1)))),-Numner*Angle)
	else
		return Shape
	end
end