
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
		UnitID = ParseUnit(UnitID) -- ��Ʈ������ �����̸� �Է°���
	end
	if UnitID>=228 then PushErrorMsg("UnitID Index Overflow") end
	if type(Property)~= "table" then
		PushErrorMsg("Property Inputdata Error")
	else
		for j,k in pairs(Property) do
			if j=="MinCost" then
				PatchInsert(SetMemoryW(0x663888 + (UnitID *2),SetTo,k)) -- �̳׶�
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
				PatchInsert(SetMemoryW(0x65FD00 + (UnitID *2),SetTo,k)) -- ����
			elseif j=="BuildTime"  then
				PatchInsert(SetMemoryW(0x660428 + (UnitID *2),SetTo,k)) -- ����ӵ�
			elseif j=="SuppCost"  then
				PatchInsert(SetMemoryB(0x663CE8 + UnitID,SetTo,k*2)) -- ����
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
			elseif j=="Armor" then
				PatchInsert(SetMemoryB(0x65FEC8 + (UnitID),SetTo,k)) -- ����
			elseif j=="GroupFlag" then
				PatchInsert(SetMemoryB(0x6637A0 + (UnitID),SetTo,k)) -- �׷�
			elseif j=="Height" then
				PatchInsert(SetMemoryB(0x663150 + (UnitID),SetTo,k)) -- �Ǽ�ũ��
			elseif j=="BdDimX" then
				PatchInsert(SetMemoryX(0x662860 + (UnitID*4),SetTo,k,0xFFFF)) -- �Ǽ�ũ��
			elseif j=="BdDimY" then
				PatchInsert(SetMemoryX(0x662860 + (UnitID*4),SetTo,k*65536,0xFFFF0000)) -- �Ǽ�ũ��
			elseif j=="SizeL" then
				PatchInsert(SetMemoryX(0x6617C8 + (UnitID*8),SetTo,(k),0xFFFF))
			elseif j=="SizeU" then
				PatchInsert(SetMemoryX(0x6617C8 + (UnitID*8),SetTo,(k*65536),0xFFFF0000))
			elseif j=="SizeR" then
				PatchInsert(SetMemoryX(0x6617CC + (UnitID*8),SetTo,(k),0xFFFF))
			elseif j=="SizeD" then
				PatchInsert(SetMemoryX(0x6617CC + (UnitID*8),SetTo,(k*65536),0xFFFF0000))
			elseif j=="SuppProv" then
				PatchInsert(SetMemoryB(0x6646C8+UnitID,SetTo,Property.SuppProv)) -- ���ð��޷�
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
				PatchInsert(SetMemoryW(0x656EB0+(WepID *2),SetTo,k)) -- ���ݷ�
			elseif j=="DmgFactor" then
				PatchInsert(SetMemoryW(0x657678+(WepID *2),SetTo,k)) -- �߰����ݷ�
			elseif j=="Cooldown" then
				PatchInsert(SetMemoryB(0x656FB8+(WepID *1),SetTo,k)) -- ����
			elseif j=="Splash" then
				if type(k)=="boolean" then
					if k == true then
						PatchInsert(SetMemoryB(0x6566F8+WepID,SetTo,3)) -- ����Ÿ��(�Ϲ���)
					else
						PatchInsert(SetMemoryB(0x6566F8+WepID,SetTo,1)) -- ����Ÿ��(���þ���)
					end
				elseif type(k)~="table" or #k~=3 then
					PushErrorMsg("Splash Inputdata Error")
				else
					PatchInsert(SetMemoryB(0x6566F8+WepID,SetTo,3)) -- ����Ÿ��(�Ϲ���)
					PatchInsert(SetMemoryW(0x656888+(WepID*2),SetTo,k[1])) --���� ��
					PatchInsert(SetMemoryW(0x6570C8+(WepID*2),SetTo,k[2])) --���� ��
					PatchInsert(SetMemoryW(0x657780+(WepID*2),SetTo,k[3])) --���� ��
				end
			elseif j=="RangeMin" then
				PatchInsert(SetMemory(0x656A18+(WepID *4),SetTo,k)) -- ��Ÿ� �ּ�
			elseif j=="RangeMax" then
				PatchInsert(SetMemory(0x657470+(WepID *4),SetTo,k)) -- ��Ÿ� �ִ�
			elseif j=="TargetFlag" then
				PatchInsert(SetMemoryW(0x657998 + (WepID*2), SetTo, k))
			elseif j=="UpgradeType" then
				PatchInsert(SetMemoryB(0x6571D0 + WepID, SetTo, k))
			elseif j=="ObjectNum" then
				PatchInsert(SetMemoryB(0x6564E0+WepID,SetTo,k)) -- ����ü��
			elseif j=="IconType" then
				PatchInsert(SetMemoryW(0x656780+(WepID *2),SetTo,k)) -- ������
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
				PatchInsert(SetMemoryW(0x6572E0+(WepID *2),SetTo,k)) -- �̸�
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