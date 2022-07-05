
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
	count,count1,count2,count3 = CreateVars(4,FP)
	function Cast_UnitCount()
		UnitReadX(Player,AllPlayers,229,64,count)
		UnitReadX(Player,AllPlayers,17,nil,count1)
		UnitReadX(Player,AllPlayers,23,nil,count2)
		UnitReadX(Player,AllPlayers,25,nil,count3)
		CAdd(Player,count,count1)
		CAdd(Player,count,count2)
		CAdd(Player,count,count3)
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
		Flags = {Preserved}
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
		Flags = {Preserved}
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
			else
				PushErrorMsg("Wrong Property Name Detected!! : "..j)
			end
		end
	end

end

function SetZealotUnit(UnitID,HP,Shield,WepID,WepDamage,ClockingFlag,HighSpeed,Color)

	PatchInsert(SetMemoryB(0x662180 + UnitID,SetTo,0))
	PatchInsert(SetMemoryB(0x6644F8+UnitID,SetTo,49)) -- Graphic
	PatchInsert(SetMemoryB(0x662098+UnitID,SetTo,1))--RClickAct
	PatchInsert(SetMemoryB(0x662268+UnitID,SetTo,2))--Human InitAct
	PatchInsert(SetMemoryB(0x662EA0+UnitID,SetTo,2))--Computer InitAct
	PatchInsert(SetMemoryB(0x663320+UnitID,SetTo,10))--AttackOrder
	PatchInsert(SetMemoryB(0x663A50+UnitID,SetTo,2))--AttackMoveOrder
	PatchInsert(SetMemoryB(0x664898+UnitID,SetTo,2))--IdleOrder
	if ClockingFlag == 1 then
		PatchInsert(SetMemoryX(0x664080 + (UnitID*4),SetTo,402653184+4194816,0xFFFFFFFF))
	else
		PatchInsert(SetMemoryX(0x664080 + (UnitID*4),SetTo,402653184,0xFFFFFFFF))
	end
	PatchInsert(SetMemoryB(0x65FEC8 + UnitID,SetTo,0)) -- Armor
	PatchInsert(SetMemory(0x662350 + (UnitID*4),SetTo,HP*256)) -- HP
	PatchInsert(SetMemoryW(0x660E00 + (UnitID *2), SetTo, Shield))--Shield
	PatchInsert(SetMemoryB(0x6647B0 + UnitID,SetTo,1))--ShieldUsage
	PatchInsert(SetMemoryB(0x6637A0+UnitID,SetTo,4)) -- GroupFlag
	PatchInsert(SetMemoryW(0x663408+(UnitID *2),SetTo,0))--BuildScore
	PatchInsert(SetMemoryW(0x663EB8+(UnitID *2),SetTo,0))--KillScore
	PatchInsert(SetMemoryB(0x662DB8+UnitID,SetTo,3)) -- SeekRange
	PatchInsert(SetMemoryB(0x663238+UnitID,SetTo,7)) -- SightRange
	PatchInsert(SetMemoryB(0x660FC8+UnitID,SetTo,0x41))--MovementFlag
	PatchInsert(SetMemoryW(0x662F88+(UnitID *2),SetTo,40)) --Portrait
	PatchInsert(SetMemory(0x662860 + (UnitID*4),SetTo,23+(27*65536))) -- 건설크기
	PatchInsert(SetMemoryB(0x6616E0+UnitID,SetTo,130))--AirWeapon
	PatchInsert(SetMemoryB(0x6636B8+UnitID,SetTo,WepID)) -- GndWeapon
	PatchInsert(SetMemory(0x6617C8 + (UnitID*8),SetTo,(2)+(2*65536))) --Size
	PatchInsert(SetMemory(0x6617CC + (UnitID*8),SetTo,(2)+(2*65536))) --Size
	PatchInsert(SetMemoryB(0x663150+UnitID,SetTo,4))--Elevation
	PatchInsert(SetMemoryB(0x6605F0+UnitID,SetTo,32)) -- StartDirection
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


function SetUnitsDatX(UnitID,Property)
	if type(UnitID) == "string" then
		UnitID = ParseUnit(UnitID) -- 스트링으로 유닛이름 입력가능
	end
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
					CopyCpActionX({PlayWAVX(v[2])},TargetPlayer);
					SetNVar(Arr[3],Add,v[3]);
				},
				flag = {Preserved}
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
				flag = {Preserved}
			}
		end
	CIfXEnd()
end