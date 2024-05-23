﻿
--DatEdit
PatchArr = {}
PatchArr2 = {}
PatchArrPrsv = {}

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
				if SType == 2 then -- 2 == Only Player
					PatchInsert(SetMemoryB(0x57F27C + (0 * 228) + UnitID,SetTo,1))
					PatchInsert(SetMemoryB(0x57F27C + (1 * 228) + UnitID,SetTo,1))
					PatchInsert(SetMemoryB(0x57F27C + (2 * 228) + UnitID,SetTo,1))
					PatchInsert(SetMemoryB(0x57F27C + (3 * 228) + UnitID,SetTo,1))
					PatchInsert(SetMemoryB(0x57F27C + (4 * 228) + UnitID,SetTo,1))
					PatchInsert(SetMemoryB(0x57F27C + (5 * 228) + UnitID,SetTo,1))
					PatchInsert(SetMemoryB(0x57F27C + (6 * 228) + UnitID,SetTo,1))
					PatchInsert(SetMemoryB(0x57F27C + (7 * 228) + UnitID,SetTo,0))
				else
					PatchInsert(SetMemoryB(0x57F27C + (0 * 228) + UnitID,SetTo,SType))
					PatchInsert(SetMemoryB(0x57F27C + (1 * 228) + UnitID,SetTo,SType))
					PatchInsert(SetMemoryB(0x57F27C + (2 * 228) + UnitID,SetTo,SType))
					PatchInsert(SetMemoryB(0x57F27C + (3 * 228) + UnitID,SetTo,SType))
					PatchInsert(SetMemoryB(0x57F27C + (4 * 228) + UnitID,SetTo,SType))
					PatchInsert(SetMemoryB(0x57F27C + (5 * 228) + UnitID,SetTo,SType))
					PatchInsert(SetMemoryB(0x57F27C + (6 * 228) + UnitID,SetTo,SType))
					PatchInsert(SetMemoryB(0x57F27C + (7 * 228) + UnitID,SetTo,SType))
				end

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
			elseif j== "ComputerAI" then
				PatchInsert(SetMemoryB(0x660178+(UnitID),SetTo,k))--ComputerAI
			elseif j == "GroupFlag" then
				PatchInsert(SetMemoryB(0x6637A0+(UnitID),SetTo,k))--Group
				
			else
				
				PushErrorMsg("Wrong Property Name Detected!! : "..j)
			end
			
		end
	end
end


function CreateUnitQueue()
	
	local G_CA_Nextptrs = CreateVar(FP)
	local TempUID = CreateVar(FP)
	local TempPID = CreateVar(FP)
	local TempType = CreateVar(FP)
	if Limit == 1 then
--		CIf(FP,{CD(TestMode,1)})
--		--DisplayPrintEr(0,{"\x07『 \x03TESTMODE OP \x04: CreateUnitQueuePtr : ",CreateUnitQueuePtr," || CreateUnitQueuePtr2 : ",CreateUnitQueuePtr2," \x07』"})
--		local TestV = CreateVar()
--		CMov(FP,TestV,0)
--		CFor(FP, 19025+19, 19025+19 + (84*1700), 84)
--			local CI = CForVariable()
--			CTrigger(FP, {TMemoryX(CI,AtLeast,1*256,0xFF00)}, {AddV(TestV,1)},1)
--		CForEnd()
		--DisplayPrintEr(0,{"\x07『 \x03TESTMODE OP \x04: CUnit Count : ",TestV," \x07』"})--

--		CIfEnd()
	end
	TriggerX(FP, {CV(count,1500,AtMost),CV(CreateUnitQueueNum,0)}, {
		SetInvincibility(Disable, 131, FP, 64),
		SetInvincibility(Disable, 132, FP, 64),
		SetInvincibility(Disable, 133, FP, 64),
		SetInvincibility(Disable, 150, FP, 64),
		SetInvincibility(Disable, 148, FP, 64),
	},{preserved})
	TriggerX(FP, {CV(count,1501,AtLeast)}, {
		SetInvincibility(Enable, 131, FP, 64),
		SetInvincibility(Enable, 132, FP, 64),
		SetInvincibility(Enable, 133, FP, 64),
		SetInvincibility(Enable, 150, FP, 64),
		SetInvincibility(Enable, 148, FP, 64),
	},{preserved})
	TriggerX(FP, {CV(CreateUnitQueueNum,1,AtLeast)}, {
		SetInvincibility(Enable, 131, FP, 64),
		SetInvincibility(Enable, 132, FP, 64),
		SetInvincibility(Enable, 133, FP, 64),
		SetInvincibility(Enable, 150, FP, 64),
		SetInvincibility(Enable, 148, FP, 64),
	},{preserved})
	NWhile(FP,{CV(count,1500,AtMost),Memory(0x628438,AtLeast,1),CV(CreateUnitQueueNum,1,AtLeast)},{})
	f_Read(FP,0x628438,"X",G_CA_Nextptrs,0xFFFFFF)
	f_SHRead(FP, _Add(CreateUnitQueueXPosArr,CreateUnitQueuePtr2), CPosX)
	f_SHRead(FP, _Add(CreateUnitQueueYPosArr,CreateUnitQueuePtr2), CPosY)
	f_SHRead(FP, _Add(CreateUnitQueueUIDArr,CreateUnitQueuePtr2), TempUID)
	f_SHRead(FP, _Add(CreateUnitQueuePIDArr,CreateUnitQueuePtr2), TempPID)
	f_SHRead(FP, _Add(CreateUnitQueueTypeArr,CreateUnitQueuePtr2), TempType)
	CDoActions(FP, {
		TSetMemory(_Add(CreateUnitQueueXPosArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueueYPosArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueueUIDArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueuePIDArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueueTypeArr,CreateUnitQueuePtr2), SetTo, 0)
	})
	DoActionsX(FP,{AddV(CreateUnitQueuePtr2,1),SubV(CreateUnitQueueNum,1)})
	TriggerX(FP, {CV(CreateUnitQueuePtr2,200000,AtLeast)},{SetV(CreateUnitQueuePtr2,0)},{preserved})





	NIf(FP,{CV(TempUID,1,AtLeast),CV(TempUID,226,AtMost)})
	local CRLID = CreateVar(FP)

	
	DoActions(FP,{SetSwitch(RandSwitch1,Random),SetSwitch(RandSwitch2,Random)})
	
	local LocIndex = FuncAlloc
		for i = 0, 3 do
            if i == 0 then RS1 = Cleared RS2=Cleared end
            if i == 1 then RS1 = Set RS2=Cleared end
            if i == 2 then RS1 = Cleared RS2=Set end
            if i == 3 then RS1 = Set RS2=Set end
            TriggerX(FP,{Switch(RandSwitch1,RS1),Switch(RandSwitch2,RS2)},{SetCtrig1X("X",FuncAlloc,CAddr("Mask",1),nil,SetTo,14+i),SetCtrig1X("X",FuncAlloc+1,CAddr("Mask",1),nil,SetTo,14+i)},{preserved})
        end
		TriggerX(FP,{CVar(FP,TempPID[2],Exactly,0xFFFFFFFF)},{SetCVar(FP,TempPID[2],SetTo,7)},{preserved})
		CTrigger(FP,{TTCVar(FP,TempType[2],NotSame,2)},{TCreateUnitWithProperties(1,TempUID,1,TempPID,{energy = 100})},1,LocIndex)
        CTrigger(FP,{CVar(FP,TempType[2],Exactly,2)},{TCreateUnitWithProperties(1,TempUID,1,TempPID,{energy = 100, burrowed = true})},1,LocIndex+1)
		FuncAlloc=FuncAlloc+2
		Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)

		CIf(FP,{TMemoryX(_Add(G_CA_Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
		
		--CIf(FP,{TTOR({CV(TempUID,25),CV(TempUID,30)})})
		--CDoActions(FP,{
		--	TSetDeathsX(_Add(G_CA_Nextptrs,72),SetTo,0xFF*256,0,0xFF00),TSetMemoryX(_Add(G_CA_Nextptrs,68), SetTo, 600,0xFFFF)})
		--CIfEnd()

		f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
		Convert_CPosXY()
		Simple_SetLocX(FP,71,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(71,-4,-4,4,4)})

        CTrigger(FP,{},{TMoveUnit(1,TempUID,Force2,72,1)},{preserved})
			CIfX(FP,CVar(FP,TempType[2],Exactly,0))
				f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
				Convert_CPosXY()
				Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
				CTrigger(FP, {}, {TOrder(TempUID, Force2, 1, Attack, DefaultAttackLocV);}, {preserved})

			CElseIfX(CVar(FP,TempType[2],Exactly,1))
			
			f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CTrigger(FP, {}, {TOrder(TempUID, Force2, 1, Attack, DefaultAttackLocV);}, {preserved})
			CDoActions(FP,{
				TSetMemory(_Add(G_CA_Nextptrs,2), SetTo, _Div(_ReadF(_Add(TempUID,EPD(0x662350))),2)),
			})

			CElseIfX(CVar(FP,TempType[2],Exactly,187))
				CDoActions(FP,{
					TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
				})

			CElseIfX(CVar(FP,TempType[2],Exactly,189))
			CDoActions(FP,{
				TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
				TCreateUnitWithProperties(1,84,1,TempPID,{energy = 100}),TRemoveUnit(84,TempPID)
			})
			CElseIfX(CVar(FP,TempType[2],Exactly,190))
				f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
				Convert_CPosXY()
				Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
				CDoActions(FP,{TSetMemory(_Add(G_CA_Nextptrs,13),SetTo,1920)})
				CDoActions(FP,{
					TOrder(TempUID, Force2, 1, Attack, DefaultAttackLocV);
					TSetDeathsX(_Add(G_CA_Nextptrs,72),SetTo,0xFF*256,0,0xFF00),
					TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0xA00000,0xA00000),
					
				})
			CElseIfX(CVar(FP,TempType[2],Exactly,32))
			CDoActions(FP,{
				TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
				TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0x04000000,0x04000000),
				TSetMemoryX(_Add(G_CA_Nextptrs,8), SetTo, 127*65536,0xFF0000),
				TSetDeaths(_Add(G_CA_Nextptrs,13),SetTo,20000,0),
				TSetDeathsX(_Add(G_CA_Nextptrs,18),SetTo,4000,0,0xFFFF)})

			CElseIfX(CVar(FP,TempType[2],Exactly,188))
				--CIfX(FP,CVar(FP,HondonMode[2],AtMost,0))
				TempSpeedVar = f_CRandNum(8000)
				CDoActions(FP,{
					TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0xA00000,0xA00000),
					TSetDeaths(_Add(G_CA_Nextptrs,13),SetTo,_Add(TempSpeedVar,500),0),
					TSetDeathsX(_Add(G_CA_Nextptrs,18),SetTo,_Add(TempSpeedVar,500),0,0xFFFF)})
				--CElseX()
				--CDoActions(FP,{
				--	TSetDeaths(_Add(G_CA_Nextptrs,13),SetTo,12000,0),
				--	TSetDeathsX(_Add(G_CA_Nextptrs,18),SetTo,4000,0,0xFFFF)})
				--CIfXEnd()
				CDoActions(FP,{
					TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
					TSetMemory(_Add(G_CA_Nextptrs,2), SetTo, _Div(_ReadF(_Add(TempUID,EPD(0x662350))),2)),
				})

				CElseIfX(CVar(FP,TempType[2],Exactly,191))

				--CIfX(FP,CVar(FP,HondonMode[2],AtMost,0))
				CDoActions(FP,{
					TSetDeaths(_Add(G_CA_Nextptrs,13),SetTo,4000,0),
					TSetDeathsX(_Add(G_CA_Nextptrs,18),SetTo,4000,0,0xFFFF)})
				--CElseX()
				--CDoActions(FP,{
				--	TSetDeaths(_Add(G_CA_Nextptrs,13),SetTo,12000,0),
				--	TSetDeathsX(_Add(G_CA_Nextptrs,18),SetTo,4000,0,0xFFFF)})
				--CIfXEnd()
				CDoActions(FP,{
					TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
				})
			CElseIfX(CVar(FP,TempType[2],Exactly,18))
			
			f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
				CTrigger(FP, {}, {TOrder(TempUID, Force2, 1, Attack, DefaultAttackLocV);}, {preserved})
			local RandVar = CreateVar(FP)
			CMov(FP,RandVar,0)
			for i = 0, 6 do
				DoActions(FP, {SetSwitch(RandSwitch1, Random)})
				TriggerX(FP, {HumanCheck(i, 1),Switch(RandSwitch1, Set)}, {SetVX(RandVar,2^i,2^i)}, {preserved})
			end
			CTrigger(FP,{CD(GMode,1),},{
				TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0x100,0x100); -- 클로킹
				TSetMemoryX(_Add(G_CA_Nextptrs,57),SetTo,RandVar,0xFF); -- 현재건작 유저 인식
				TSetMemoryX(_Add(G_CA_Nextptrs,73),SetTo,_Mul(RandVar,256),0xFF00); -- 현재건작 유저 인식
				TSetMemoryX(_Add(G_CA_Nextptrs,72),SetTo,255*256,0xFF00); -- 어그로풀림 방지 ( 페러사이트 )
				TSetMemoryX(_Add(G_CA_Nextptrs,72),SetTo,255*16777216,0xFF000000); -- Blind ( 개별건작유닛 계급설정 )
				TSetMemoryX(_Add(G_CA_Nextptrs,35),SetTo,1,0xFF); -- 개별건작 표식
				TSetMemoryX(_Add(G_CA_Nextptrs,35),SetTo,1*256,0xFF00);
				TSetMemoryX(_Add(G_CA_Nextptrs,70),SetTo,48*16777216,0xFF000000); -- 개별건작 타이머

			},{preserved})


			CElseIfX(CVar(FP,TempType[2],Exactly,147))
			f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CDoActions(FP,{
				TOrder(TempUID, Force2, 1, Attack, 23);
				TSetMemory(_Add(G_CA_Nextptrs,13),SetTo,128),
				TSetMemoryX(_Add(G_CA_Nextptrs,18),SetTo,128,0xFFFF),
				TSetDeathsX(_Add(G_CA_Nextptrs,72),SetTo,0xFF*256,0,0xFF00),
				TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0xA00000,0xA00000),
				CreateUnit(1,84,1,FP),KillUnit(84,FP)
			})

			CElseIfX(CVar(FP,TempType[2],Exactly,3))
				CDoActions(FP,{
					TSetDeathsX(_Add(G_CA_Nextptrs,72),SetTo,0xFF*256,0,0xFF00)})
			CElseIfX(CVar(FP,TempType[2],Exactly,84))
			CDoActions(FP,{
				TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0xA00000,0xA00000),KillUnit(84,FP)
			})

			CElseIfX(CVar(FP,TempType[2],Exactly,201))
			f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CDoActions(FP,{
				TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
				TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0x04000000,0x04000000),
				TOrder(TempUID, Force2, 1, Move, 36);
			})
			CElseIfX(CVar(FP,TempType[2],Exactly,202))
			f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CTrigger(FP, {}, {TOrder(TempUID, Force2, 1, Attack, DefaultAttackLocV);}, {preserved})
			
			CMov(FP,CunitIndex,_Div(_Sub(G_CA_Nextptrs,19025),_Mov(84)))
			CDoActions(FP, {Set_EXCC2(DUnitCalc,CunitIndex,1,SetTo,1)})

			CElseIfX(CVar(FP,TempType[2],Exactly,2))
			CElseX()
				DoActions(FP,RotatePlayer({DisplayTextX("\x07『 \x08ERROR : \x04잘못된 RepeatType이 입력되었습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』",4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP))
			CIfXEnd()
			--Simple_SetLocX(FP,0,G_CA_BackupX,G_CA_BackupY,G_CA_BackupX,G_CA_BackupY,{Simple_CalcLoc(0,-4,-4,4,4)})
			--CDoActions(FP,{TOrder(TempUID,Force2,72,Attack,1)})
			
		CIfEnd()



	Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)




	



	NIfEnd()

	NWhileEnd()
	
FixText(FP, 1)
DisplayPrint(HumanPlayers,{"\x07『 \x04CreateUnit\x07Queue \x04: ",CreateUnitQueueNum," / \x08200,000 \x07』"})
FixText(FP, 2)
end





function SetUnitAbility(UnitID,WepID,HP,Shield,Cooldown,Damage,ObjNum,RangeMax,SeekRange,Point,Text,KillPoint,QueueScript,QueueScript2)--QueueScript{FlingyID,SpriteID,ImageID,Color(Option)}
	local TempWID = WepID
	local TempWID2 = 130
	if UnitPointArr == nil then UnitPointArr = {} end
	if UnitPointArr2 == nil then UnitPointArr2 = {} end
	if QueueScriptArr == nil then QueueScriptArr = {} end
	if QueueScriptArr2 == nil then QueueScriptArr2 = {} end
	if Point~=nil then
		table.insert(UnitPointArr, {UnitID,Point,Text})
	end
	if QueueScript ~= nil then
		if type(QueueScript)~="table" then PushErrorMsg("QueueScript InputData Error")end
		table.insert(QueueScriptArr, {UnitID,table.unpack(QueueScript)})
		
	end
	table.insert(UnitPointArr2, UnitID)

	if UnitID == 62 then TempWID2 = WepID end
	if UnitID == 98 then TempWID2 = WepID end
	if UnitID == 86 then TempWID2 = WepID end
	if 
	UnitID == 3 or 
	UnitID == 5 or 
	UnitID == 17 or 
	UnitID == 23 or 
	UnitID == 25 or 
	UnitID == 30 then TempWID = 130 
	if QueueScript~=nil then
		if QueueScript2 ~= nil then--텡크류 유닛
				
			if type(QueueScript2)~="table" then PushErrorMsg("QueueScript InputData Error")end
			table.insert(QueueScriptArr2, {UnitID+1,table.unpack(QueueScript2)})
			
		end
	end
	SetUnitsDatX(UnitID+1, {GroundWeapon=WepID,AirWeapon=TempWID2})
	end
	local Size = 4
	if UnitID == 74 or UnitID == 75 then
		Size = nil
	end
	SetUnitsDatX(UnitID, {AdvFlag={0x40,0x40},ComputerAI=3,HP=HP,Shield=Shield,GroundWeapon=TempWID,AirWeapon=TempWID2,SeekRange = SeekRange,KillScore=KillPoint,SizeL=Size,SizeU=Size,SizeR=Size,SizeD=Size
})
if ObjNum == nil then ObjNum = 1 end
SetWeaponsDatX(WepID,{Cooldown = Cooldown,DmgBase=Damage,RangeMax=RangeMax,ObjectNum=ObjNum,Splash=false,DmgFactor=0})


end


function Include_G_CA_Library(DefaultAttackLoc,StartIndex,Size_of_G_CA_Arr)
	if CPos == nil then PushErrorMsg("Need_Include_Conv_CPosXY") end
	if FP == nil then PushErrorMsg("Need_Define_Fixed_Player ( ex : FP = P8 )") end
	if GLocC == nil then PushErrorMsg("Need_Install_GetCLoc") end
	if TempRandRet == nil then PushErrorMsg("Need_Include_CRandNum") end
	if STRCTRIGASM == 1 then
		CA2ArrX = f_GetVArrptr(FP,1700)
		CA2ArrY = f_GetVArrptr(FP,1700)
		CA2ArrZ = f_GetVArrptr(FP,1700)
	else
		CA2ArrX = CreateVArr(1700,FP)
		CA2ArrY = CreateVArr(1700,FP)
		CA2ArrZ = CreateVArr(1700,FP)
	end

	function CAPlot2(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CAfunc,PlayerID,Condition,PerAction,Preserve,CAfunc2)
		if Shape == nil then
			PushErrorMsg("CS_InputError")
		end
	
		if Preserve == 0 then
			Preserve = nil
		end
	
		local LocId = Location
		if type(LocId) == "string" then
			LocId = ParseLocation(LocId)-1
		elseif type(LocId) == "number" then
			Location = Location + 1
		end
		local LocL = 0x58DC60+0x14*LocId
		local LocU = 0x58DC64+0x14*LocId
		local LocR = 0x58DC68+0x14*LocId
		local LocD = 0x58DC6C+0x14*LocId
	
		local CA = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
		local CA2 = {}
		local CB = {}
	
		local TempAct = {}
		local PlotArrX = CA2ArrX
		local PlotArrY = CA2ArrY
		CJump(PlayerID,CAPlotJumpAlloc)
			if type(Shape[1]) ~= "number" then
				for i = 1, #Shape do
					table.insert(TempAct,{})
					for j = 1, Shape[i][1] do
						table.insert(TempAct[i],SetCVAar(VArr(PlotArrX,j),SetTo,Shape[i][j+1][1]))
						table.insert(TempAct[i],SetCVAar(VArr(PlotArrY,j),SetTo,Shape[i][j+1][2]))
					end
					table.insert(TempAct[i],SetCVar("X",CA[1],SetTo,0))
					table.insert(TempAct[i],SetCVar("X",CA[10],SetTo,Shape[i][1]))
				end
			else
				for i = 1, Shape[1] do
					table.insert(TempAct,SetCVAar(VArr(PlotArrX,i),SetTo,Shape[i+1][1]))
					table.insert(TempAct,SetCVAar(VArr(PlotArrY,i),SetTo,Shape[i+1][2]))
				end
				table.insert(TempAct,SetCVar("X",CA[1],SetTo,0))
				table.insert(TempAct,SetCVar("X",CA[10],SetTo,Shape[1]))
			end
			if type(Preset[1]) == "number" then
				CVariable2(PlayerID,CAPlotVarAlloc+0,"X",SetTo,Preset[1]) -- Shape Select (고정) [1]
			else
				CVariable(PlayerID,CAPlotVarAlloc+0) -- Shape Select (고정)
			end
			CVariable(PlayerID,CAPlotVarAlloc+1) -- Delay Timer (가변) [2]
			if type(Preset[3]) == "number" then
				CVariable2(PlayerID,CAPlotVarAlloc+2,"X",SetTo,Preset[3]) -- Delay Adder (고정) [3]
			else
				CVariable(PlayerID,CAPlotVarAlloc+2) -- Delay Adder (고정)
			end
			CVariable(PlayerID,CAPlotVarAlloc+3) -- Loop Counter (가변) [4]
			if type(Preset[5]) == "number" then
				CVariable2(PlayerID,CAPlotVarAlloc+4,"X",SetTo,Preset[5]) -- Loop Limit (고정) [5]
			else
				CVariable(PlayerID,CAPlotVarAlloc+4) -- Loop Limit (고정)
			end
			CVariable2(PlayerID,CAPlotVarAlloc+5,"X",SetTo,1) -- Current index (가변) [6]
			-------- Preset Limit --------------------------------
			CVariable(PlayerID,CAPlotVarAlloc+6) -- Temp Index
			CVariable(PlayerID,CAPlotVarAlloc+7) -- Temp X
			CVariable(PlayerID,CAPlotVarAlloc+8) -- Temp Y
			CVariable(PlayerID,CAPlotVarAlloc+9) -- Temp Sizemax
			CAPlotVarAlloc = CAPlotVarAlloc + 10
			CVariable(PlayerID,CAPlotVarAlloc)
			CVariable(PlayerID,CAPlotVarAlloc+1)
			CVariable(PlayerID,CAPlotVarAlloc+2)
			CVariable(PlayerID,CAPlotVarAlloc+3)
			CA2 = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3}
			CAPlotVarAlloc = CAPlotVarAlloc + 4
			CVariable2(PlayerID,CAPlotVarAlloc+0,"X",SetTo,PerUnit*16777216)
			CVariable2(PlayerID,CAPlotVarAlloc+1,"X",SetTo,UnitId)
			CVariable2(PlayerID,CAPlotVarAlloc+2,"X",SetTo,Owner)
			CVariable(PlayerID,CAPlotVarAlloc+3)
			CVariable(PlayerID,CAPlotVarAlloc+4)
			CVariable(PlayerID,CAPlotVarAlloc+5)
			CVariable(PlayerID,CAPlotVarAlloc+6)
			CVariable(PlayerID,CAPlotVarAlloc+7)
			CVariable(PlayerID,CAPlotVarAlloc+8)
			CVariable(PlayerID,CAPlotVarAlloc+9)
			CB = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
			CAPlotVarAlloc = CAPlotVarAlloc + 3
		CJumpEnd(PlayerID,CAPlotJumpAlloc)
		CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	
		if type(Preset[1]) ~= "number" then
			CMov(PlayerID,V(CA[1]),Preset[1])
		end
		if type(Preset[2]) ~= "number" then
			CMov(PlayerID,V(CA[2]),Preset[2])
		end
		if type(Preset[3]) ~= "number" then
			CMov(PlayerID,V(CA[3]),Preset[3])
		end
		if type(Preset[4]) ~= "number" then
			CMov(PlayerID,V(CA[4]),Preset[4])
		end
		if type(Preset[5]) ~= "number" then
			CMov(PlayerID,V(CA[5]),Preset[5])
		end
		if type(Preset[6]) ~= "number" then
			CMov(PlayerID,V(CA[6]),Preset[6])
		end
		if Preset[7] ~= nil then
			CMov(PlayerID,V(CB[1]),Preset[7])
		end
		if Preset[8] ~= nil then
			CMov(PlayerID,V(CB[2]),Preset[8])
		end
		if Preset[9] ~= nil then
			CMov(PlayerID,V(CB[3]),Preset[9])
		end
	
		CIf(PlayerID,CVar("X",CA[1],AtLeast,1))
			if type(Shape[1]) ~= "number" then
				for i = 1, #Shape do
					Trigger2X(PlayerID,CVar("X",CA[1],Exactly,i),TempAct[i],{preserved})
				end
			else
				DoActions2X(PlayerID,TempAct)
			end
		CIfEnd()
	
		NWhile(PlayerID,{CVar("X",CA[2],Exactly,0),Condition})
			NIfX(PlayerID,{TCVar("X",CA[4],AtMost,Vi(CA[5],-1)),TCVar("X",CA[6],AtMost,V(CA[10]))})
				CMovX(PlayerID,V(CA[8]),VArr(PlotArrX,V(CA[6])),nil,0xFFFFFFFF,nil,1)
				CMovX(PlayerID,V(CA[9]),VArr(PlotArrY,V(CA[6])),nil,0xFFFFFFFF,nil,1)
		-------------------------------------------------------------------------
				CAPlotDataArr = {CAPlotVarAlloc-17,CAPlotVarAlloc-16,CAPlotVarAlloc-15,CAPlotVarAlloc-14,CAPlotVarAlloc-13,CAPlotVarAlloc-12,CAPlotVarAlloc-11,CAPlotVarAlloc-10,CAPlotVarAlloc-9,CAPlotVarAlloc-8,CAPlotVarAlloc-7,CAPlotVarAlloc-6,CAPlotVarAlloc-5,CAPlotVarAlloc-4}
				CAPlotPlayerID = PlayerID
				CAPlotCreateArr = {CAPlotVarAlloc-3,CAPlotVarAlloc-2,CAPlotVarAlloc-1,CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6}
				CAPlotVarAlloc = CAPlotVarAlloc + 7
				if CAfunc ~= nil then
					_G[CAfunc]()
				end
				NJump(PlayerID,CAPlotJumpAlloc,CVar("X",CB[10],AtLeast,1),{SetCVar("X",CB[10],SetTo,0),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1)})
		-------------------------------------------------------------------------
				if CenterXY == nil then
					f_Read(PlayerID,LocL,V(CA2[1]),"X",0xFFFFFFFF,1)
					f_Read(PlayerID,LocR,V(CA2[2]),"X",0xFFFFFFFF,1)
					f_Read(PlayerID,LocU,V(CA2[3]),"X",0xFFFFFFFF,1)
					f_Read(PlayerID,LocD,V(CA2[4]),"X",0xFFFFFFFF,1)
	
					CAdd(PlayerID,V(CA[8]),_iDiv(_Add(V(CA2[1]),V(CA2[2])),2))
					CAdd(PlayerID,V(CA[9]),_iDiv(_Add(V(CA2[3]),V(CA2[4])),2))
				else
					CAdd(PlayerID,V(CA[8]),CenterXY[1])
					CAdd(PlayerID,V(CA[9]),CenterXY[2])
				end
	
				CMov(PlayerID,LocL,V(CA[8]),-PlotSize)
				CMov(PlayerID,LocR,V(CA[8]),PlotSize)
				CMov(PlayerID,LocU,V(CA[9]),-PlotSize)
				CMov(PlayerID,LocD,V(CA[9]),PlotSize)
				CDoActions(PlayerID,{TCreateUnit(V(CB[1]),V(CB[2]),Location,V(CB[3])),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1),PerAction})
				if CAfunc2 ~= nil then
					_G[CAfunc2]()
				end
				if CenterXY == nil then
					CMov(PlayerID,LocL,V(CA2[1]))
					CMov(PlayerID,LocR,V(CA2[2]))
					CMov(PlayerID,LocU,V(CA2[3]))
					CMov(PlayerID,LocD,V(CA2[4]))
				end
				NJumpEnd(PlayerID,CAPlotJumpAlloc)
				CAPlotJumpAlloc = CAPlotJumpAlloc + 1
			NElseX()
				CDoActions(PlayerID,{TSetCVar("X",CA[2],SetTo,V(CA[3])),SetCVar("X",CA[4],SetTo,0)})
				CJump(PlayerID,CAPlotJumpAlloc)
			NIfXEnd()
		NWhileEnd()
		CJumpEnd(PlayerID,CAPlotJumpAlloc)
		CAPlotJumpAlloc = CAPlotJumpAlloc + 1
		DoActionsX(PlayerID,SetCVar("X",CA[2],Subtract,1))
		if Preserve ~= nil then
			if type(Preserve) == "number" then
				CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},SetCVar("X",CA[6],SetTo,1),{preserved})
			else
				CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},{SetCVar("X",CA[6],SetTo,1),Preserve},{preserved})
			end
		end
		local Ret = {CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3]}
		CAPlotCreateArr = {}
		CAPlotDataArr = {}
		CAPlotPlayerID = {}
		return Ret
	end
	function CXPlot2(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CXfunc,PlayerID,Condition,PerAction,Preserve,CXfunc2)
		if Shape == nil then
			PushErrorMsg("CX_InputError")
		end
	
		if Preserve == 0 then
			Preserve = nil
		end
	
		local LocId = Location
		if type(LocId) == "string" then
			LocId = ParseLocation(LocId)-1
		elseif type(LocId) == "number" then
			Location = Location + 1
		end
		local LocL = 0x58DC60+0x14*LocId
		local LocU = 0x58DC64+0x14*LocId
		local LocR = 0x58DC68+0x14*LocId
		local LocD = 0x58DC6C+0x14*LocId
	
		local CA = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
		local CA2 = {}
		local CB = {}
	
		local TempAct = {}
		local PlotArrX = CA2ArrX
		local PlotArrY = CA2ArrY
		local PlotArrZ = CA2ArrZ
		CJump(PlayerID,CAPlotJumpAlloc)
			if type(Shape[1]) ~= "number" then
				for i = 1, #Shape do
					table.insert(TempAct,{})
					for j = 1, Shape[i][1] do
						table.insert(TempAct[i],SetCVAar(VArr(PlotArrX,j),SetTo,Shape[i][j+1][1]))
						table.insert(TempAct[i],SetCVAar(VArr(PlotArrY,j),SetTo,Shape[i][j+1][2]))
						table.insert(TempAct[i],SetCVAar(VArr(PlotArrZ,j),SetTo,Shape[i][j+1][3]))
					end
					table.insert(TempAct[i],SetCVar("X",CA[1],SetTo,0))
					table.insert(TempAct[i],SetCVar("X",CA[10],SetTo,Shape[i][1]))
				end
			else
				for i = 1, Shape[1] do
					table.insert(TempAct,SetCVAar(VArr(PlotArrX,i),SetTo,Shape[i+1][1]))
					table.insert(TempAct,SetCVAar(VArr(PlotArrY,i),SetTo,Shape[i+1][2]))
					table.insert(TempAct,SetCVAar(VArr(PlotArrZ,i),SetTo,Shape[i+1][3]))
				end
				table.insert(TempAct,SetCVar("X",CA[1],SetTo,0))
				table.insert(TempAct,SetCVar("X",CA[10],SetTo,Shape[1]))
			end
			if type(Preset[1]) == "number" then
				CVariable2(PlayerID,CAPlotVarAlloc+0,"X",SetTo,Preset[1]) -- Shape Select (고정) [1]
			else
				CVariable(PlayerID,CAPlotVarAlloc+0) -- Shape Select (고정)
			end
			CVariable(PlayerID,CAPlotVarAlloc+1) -- Delay Timer (가변) [2]
			if type(Preset[3]) == "number" then
				CVariable2(PlayerID,CAPlotVarAlloc+2,"X",SetTo,Preset[3]) -- Delay Adder (고정) [3]
			else
				CVariable(PlayerID,CAPlotVarAlloc+2) -- Delay Adder (고정)
			end
			CVariable(PlayerID,CAPlotVarAlloc+3) -- Loop Counter (가변) [4]
			if type(Preset[5]) == "number" then
				CVariable2(PlayerID,CAPlotVarAlloc+4,"X",SetTo,Preset[5]) -- Loop Limit (고정) [5]
			else
				CVariable(PlayerID,CAPlotVarAlloc+4) -- Loop Limit (고정)
			end
			CVariable2(PlayerID,CAPlotVarAlloc+5,"X",SetTo,1) -- Current index (가변) [6]
			-------- Preset Limit --------------------------------
			CVariable(PlayerID,CAPlotVarAlloc+6) -- Temp Index
			CVariable(PlayerID,CAPlotVarAlloc+7) -- Temp X
			CVariable(PlayerID,CAPlotVarAlloc+8) -- Temp Y
			CVariable(PlayerID,CAPlotVarAlloc+9) -- Temp Sizemax
			CAPlotVarAlloc = CAPlotVarAlloc + 10
			CVariable(PlayerID,CAPlotVarAlloc) -- Temp Z
			CVariable(PlayerID,CAPlotVarAlloc+1)
			CVariable(PlayerID,CAPlotVarAlloc+2)
			CVariable(PlayerID,CAPlotVarAlloc+3)
			CA2 = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3}
			CAPlotVarAlloc = CAPlotVarAlloc + 4
			CVariable2(PlayerID,CAPlotVarAlloc+0,"X",SetTo,PerUnit*16777216)
			CVariable2(PlayerID,CAPlotVarAlloc+1,"X",SetTo,UnitId)
			CVariable2(PlayerID,CAPlotVarAlloc+2,"X",SetTo,Owner)
			CVariable(PlayerID,CAPlotVarAlloc+3)
			CVariable(PlayerID,CAPlotVarAlloc+4)
			CVariable(PlayerID,CAPlotVarAlloc+5)
			CVariable(PlayerID,CAPlotVarAlloc+6)
			CVariable(PlayerID,CAPlotVarAlloc+7)
			CVariable(PlayerID,CAPlotVarAlloc+8)
			CVariable(PlayerID,CAPlotVarAlloc+9)
			CB = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
			CAPlotVarAlloc = CAPlotVarAlloc + 3
		CJumpEnd(PlayerID,CAPlotJumpAlloc)
		CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	
		if type(Preset[1]) ~= "number" then
			CMov(PlayerID,V(CA[1]),Preset[1])
		end
		if type(Preset[2]) ~= "number" then
			CMov(PlayerID,V(CA[2]),Preset[2])
		end
		if type(Preset[3]) ~= "number" then
			CMov(PlayerID,V(CA[3]),Preset[3])
		end
		if type(Preset[4]) ~= "number" then
			CMov(PlayerID,V(CA[4]),Preset[4])
		end
		if type(Preset[5]) ~= "number" then
			CMov(PlayerID,V(CA[5]),Preset[5])
		end
		if type(Preset[6]) ~= "number" then
			CMov(PlayerID,V(CA[6]),Preset[6])
		end
		if Preset[7] ~= nil then
			CMov(PlayerID,V(CB[1]),Preset[7])
		end
		if Preset[8] ~= nil then
			CMov(PlayerID,V(CB[2]),Preset[8])
		end
		if Preset[9] ~= nil then
			CMov(PlayerID,V(CB[3]),Preset[9])
		end
	
		CIf(PlayerID,CVar("X",CA[1],AtLeast,1))
			if type(Shape[1]) ~= "number" then
				for i = 1, #Shape do
					Trigger2X(PlayerID,CVar("X",CA[1],Exactly,i),TempAct[i],{preserved})
				end
			else
				DoActions2X(PlayerID,TempAct)
			end
		CIfEnd()
	
		NWhile(PlayerID,{CVar("X",CA[2],Exactly,0),Condition})
			NIfX(PlayerID,{TCVar("X",CA[4],AtMost,Vi(CA[5],-1)),TCVar("X",CA[6],AtMost,V(CA[10]))})
				CMovX(PlayerID,V(CA[8]),VArr(PlotArrX,V(CA[6])),nil,0xFFFFFFFF,nil,1)
				CMovX(PlayerID,V(CA[9]),VArr(PlotArrY,V(CA[6])),nil,0xFFFFFFFF,nil,1)
				CMovX(PlayerID,V(CA2[1]),VArr(PlotArrZ,V(CA[6])),nil,0xFFFFFFFF,nil,1)
		-------------------------------------------------------------------------
				CAPlotDataArr = {CAPlotVarAlloc-17,CAPlotVarAlloc-16,CAPlotVarAlloc-15,CAPlotVarAlloc-14,CAPlotVarAlloc-13,CAPlotVarAlloc-12,CAPlotVarAlloc-11,CAPlotVarAlloc-10,CAPlotVarAlloc-9,CAPlotVarAlloc-8,CAPlotVarAlloc-7,CAPlotVarAlloc-6,CAPlotVarAlloc-5,CAPlotVarAlloc-4}
				CAPlotPlayerID = PlayerID
				CAPlotCreateArr = {CAPlotVarAlloc-3,CAPlotVarAlloc-2,CAPlotVarAlloc-1,CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6}
				CAPlotVarAlloc = CAPlotVarAlloc + 7
				if CXfunc ~= nil then
					_G[CXfunc]() -- Z좌표는 여기서 CX_ 함수에 의해 X,Y좌표값에 영향을 미침
				end
				NJump(PlayerID,CAPlotJumpAlloc,CVar("X",CB[10],AtLeast,1),{SetCVar("X",CB[10],SetTo,0),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1)})
		-------------------------------------------------------------------------
				if CenterXY == nil then
					f_Read(PlayerID,LocL,V(CA2[1]),"X",0xFFFFFFFF,1)
					f_Read(PlayerID,LocR,V(CA2[2]),"X",0xFFFFFFFF,1)
					f_Read(PlayerID,LocU,V(CA2[3]),"X",0xFFFFFFFF,1)
					f_Read(PlayerID,LocD,V(CA2[4]),"X",0xFFFFFFFF,1)
	
					CAdd(PlayerID,V(CA[8]),_iDiv(_Add(V(CA2[1]),V(CA2[2])),2))
					CAdd(PlayerID,V(CA[9]),_iDiv(_Add(V(CA2[3]),V(CA2[4])),2))
				else
					CAdd(PlayerID,V(CA[8]),CenterXY[1])
					CAdd(PlayerID,V(CA[9]),CenterXY[2])
				end
	
				CMov(PlayerID,LocL,V(CA[8]),-PlotSize)
				CMov(PlayerID,LocR,V(CA[8]),PlotSize)
				CMov(PlayerID,LocU,V(CA[9]),-PlotSize)
				CMov(PlayerID,LocD,V(CA[9]),PlotSize)
				CDoActions(PlayerID,{TCreateUnit(V(CB[1]),V(CB[2]),Location,V(CB[3])),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1),PerAction})
				if CXfunc2 ~= nil then
					_G[CXfunc2]() -- Z좌표는 여기서 CX_ 함수에 의해 X,Y좌표값에 영향을 미침
				end
				if CenterXY == nil then
					CMov(PlayerID,LocL,V(CA2[1]))
					CMov(PlayerID,LocR,V(CA2[2]))
					CMov(PlayerID,LocU,V(CA2[3]))
					CMov(PlayerID,LocD,V(CA2[4]))
				end
				NJumpEnd(PlayerID,CAPlotJumpAlloc)
				CAPlotJumpAlloc = CAPlotJumpAlloc + 1
			NElseX()
				CDoActions(PlayerID,{TSetCVar("X",CA[2],SetTo,V(CA[3])),SetCVar("X",CA[4],SetTo,0)})
				CJump(PlayerID,CAPlotJumpAlloc)
			NIfXEnd()
		NWhileEnd()
		CJumpEnd(PlayerID,CAPlotJumpAlloc)
		CAPlotJumpAlloc = CAPlotJumpAlloc + 1
		DoActionsX(PlayerID,SetCVar("X",CA[2],Subtract,1))
		if Preserve ~= nil then
			if type(Preserve) == "number" then
				CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},SetCVar("X",CA[6],SetTo,1),{preserved})
			else
				CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},{SetCVar("X",CA[6],SetTo,1),Preserve},{preserved})
			end
		end
		local Ret = {CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3]}
		CAPlotCreateArr = {}
		CAPlotDataArr = {}
		CAPlotPlayerID = {}
		return Ret
	end
	

	if DefaultAttackLoc == nil then
		PushErrorMsg("G_CA_DefaultXY_InputData_Error")
	end
f_RepeatTypeErr = "\x07『 \x08ERROR : \x04잘못된 RepeatType이 입력되었습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
f_RepeatErr = "\x07『 \x08ERROR : \x04f_Repeat에서 문제가 발생했습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
f_RepeatErr2 = "\x07『 \x08ERROR : \x04Set_Repeat에서 잘못된 UnitID(0)을 입력받았습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
f_GunSendErrT = "\x07『 \x08ERROR \x04: G_CA_SpawnSet 목록이 가득 차 데이터를 입력하지 못했습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
G_CA_PosErr = "\x07『 \x03CAUCTION : \x04생성 좌표가 맵 밖을 벗어났습니다.\x07 』"
f_GunFuncT = "\x07『 \x03TESTMODE OP \x04: G_CAPlot Suspended. \x07』"
f_GunSpawnSet = "\x07『 \x03TESTMODE OP \x04: G_CAPlot SpawnSet Initiation. \x07』"
f_GunErrT = "\x07『 \x08ERROR \x04: G_CAPlot Not Found. \x07』"
local Gun_TempSpawnSet1 = CreateVar(FP)
local Spawn_TempW = CreateVar(FP)
local RepeatType = CreateVar(FP)
local G_CA_Nextptrs = CreateVar(FP)
local Repeat_TempV = CreateVar(FP)
local CreatePlayer = CreateVar(FP)
local CA_Repeat_Check = CreateCcode()
local TRepeatX,TRepeatY = CreateVars(2,FP)

CA_Repeat_X = CreateVar(FP)
CA_Repeat_Y = CreateVar(FP)
G_CA_BackupX = CreateVar(FP)
G_CA_BackupY = CreateVar(FP)
G_CA_X = CreateVar(FP)
G_CA_Y = CreateVar(FP)
Call_Repeat = SetCallForward()
SetCall(FP)
DefaultAttackLocV = CreateVar(FP)
CWhile(FP,{CVar(FP,Spawn_TempW[2],AtLeast,1)})
	CMov(FP,DefaultAttackLocV,DefaultAttackLoc)
	TriggerX(FP,{Command(FP,AtLeast,1,94)},{SetV(DefaultAttackLocV,49)},{preserved})
		QueueX = CreateVar(FP)
		QueueY = CreateVar(FP)
		CIf(FP,{CDeaths(FP,Exactly,0,CA_Repeat_Check)})
		CIfX(FP,{CVar(FP,TRepeatX[2],AtMost,0x7FFFFFFF-5)})

			Simple_SetLocX(FP,0,TRepeatX,TRepeatY,TRepeatX,TRepeatY)
			CMov(FP,QueueX,TRepeatX)
			CMov(FP,QueueY,TRepeatY)

		CElseIfX(CVar(FP,TRepeatX[2],AtLeast,0x80000000-5))
		Simple_SetLocX(FP,0,G_CA_X,G_CA_Y,G_CA_X,G_CA_Y)
		CMov(FP,QueueX,G_CA_X)
		CMov(FP,QueueY,G_CA_Y)

		CIfXEnd()
		CIfEnd()


		CIf(FP,{CD(CA_Repeat_Check,1)})
		f_SHRead(FP, 0x58DC60, QueueX)
		f_SHRead(FP, 0x58DC64, QueueY)
		CMov(FP, CA_Repeat_X,QueueX)
		CMov(FP, CA_Repeat_Y,QueueY)
		CIfEnd()

		--DisplayPrint(HumanPlayers, {"Queue Executed. X : ",QueueX,"  Y : ",QueueY,"  UID : ",Gun_TempSpawnSet1})
	CDoActions(FP,{
		TSetMemory(_Add(CreateUnitQueueXPosArr,CreateUnitQueuePtr),SetTo,QueueX),
		TSetMemory(_Add(CreateUnitQueueYPosArr,CreateUnitQueuePtr),SetTo,QueueY),
		TSetMemory(_Add(CreateUnitQueueUIDArr,CreateUnitQueuePtr),SetTo,_Mov(Gun_TempSpawnSet1,0xFF)),
		TSetMemory(_Add(CreateUnitQueuePIDArr,CreateUnitQueuePtr),SetTo,CreatePlayer),
		TSetMemory(_Add(CreateUnitQueueTypeArr,CreateUnitQueuePtr),SetTo,RepeatType),
	})
	DoActionsX(FP,{AddV(CreateUnitQueueNum,1),AddV(CreateUnitQueuePtr,1)})
	TriggerX(FP, {CV(CreateUnitQueuePtr,200000,AtLeast)},{SetV(CreateUnitQueuePtr,0),},{preserved})




		
		CIf(FP,{CDeaths(FP,Exactly,0,CA_Repeat_Check)})
			CIfX(FP,{CVar(FP,TRepeatX[2],AtMost,0x7FFFFFFF-5)})
				Simple_SetLocX(FP,0,TRepeatX,TRepeatY,TRepeatX,TRepeatY)
			CElseIfX(CVar(FP,TRepeatX[2],AtLeast,0x80000000-5))
				Simple_SetLocX(FP,0,G_CA_X,G_CA_Y,G_CA_X,G_CA_Y)
			CElseX()
				Simple_SetLocX(FP,0,3712,288,3712,288)
			CIfXEnd()
		CIfEnd()
		

--Queue



		CIf(FP,{CD(CA_Repeat_Check,1),CV(Spawn_TempW,2,AtLeast)})
		Simple_SetLocX(FP,0,CA_Repeat_X,CA_Repeat_Y,CA_Repeat_X,CA_Repeat_Y)
		CIfEnd()

	CSub(FP,Spawn_TempW,1)
CWhileEnd()
CMov(FP,RepeatType,0)
SetCallEnd()
function f_TempRepeat(Condition,UnitID,Number,Type,Owner,CenterXY,Flags)
	if Owner == nil then Owner = 0xFFFFFFFF end
	
	if Type == nil then Type = 0 end
	local SetX = 0 
	local SetY = 0
	if type(CenterXY) == "table" then
		SetX = CenterXY[1]
		SetY = CenterXY[2]
	elseif CenterXY == nil then
		SetX = 0xFFFFFFFF
		SetY = 0xFFFFFFFF

	elseif CenterXY == "CG" then
		SetX = 0x80000000
		SetY = 0x80000000
	else
		PushErrorMsg("TRepeat_CenterXY_Error")
	end
	if X2_Mode == 1 then
		if SetX == 0xFFFFFFFF then
			for i =0, 3 do
				CallTriggerX(FP,Set_Repeat,Condition,{
					SetCDeaths(FP,SetTo,0,CA_Repeat_Check),
					SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,UnitID),
					SetCVar(FP,Repeat_TempV[2],SetTo,Number),
					SetCVar(FP,RepeatType[2],SetTo,Type),
					SetCVar(FP,CreatePlayer[2],SetTo,Owner),
					SetCVar(FP,TRepeatX[2],SetTo,SetX-i),
					SetCVar(FP,TRepeatY[2],SetTo,SetY-i),
				},Flags)
			end

		elseif SetX == 0x80000000 then
			for i =0, 3 do
				CallTriggerX(FP,Set_Repeat,Condition,{
					SetCDeaths(FP,SetTo,0,CA_Repeat_Check),
					SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,UnitID),
					SetCVar(FP,Repeat_TempV[2],SetTo,Number),
					SetCVar(FP,RepeatType[2],SetTo,Type),
					SetCVar(FP,CreatePlayer[2],SetTo,Owner),
					SetCVar(FP,TRepeatX[2],SetTo,SetX-i),
					SetCVar(FP,TRepeatY[2],SetTo,SetY-i),
				},Flags)
			end
		else
			for i =0, 3 do
				CallTriggerX(FP,Set_Repeat,Condition,{
					SetCDeaths(FP,SetTo,0,CA_Repeat_Check),
					SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,UnitID),
					SetCVar(FP,Repeat_TempV[2],SetTo,Number),
					SetCVar(FP,RepeatType[2],SetTo,Type),
					SetCVar(FP,CreatePlayer[2],SetTo,Owner),
					SetCVar(FP,TRepeatX[2],SetTo,SetX+X2_XYArr[i+1][1]),
					SetCVar(FP,TRepeatY[2],SetTo,SetY+X2_XYArr[i+1][2]),
				},Flags)
			end

		end
	else
		CallTriggerX(FP,Set_Repeat,Condition,{
			SetCDeaths(FP,SetTo,0,CA_Repeat_Check),
			SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,UnitID),
			SetCVar(FP,Repeat_TempV[2],SetTo,Number),
			SetCVar(FP,RepeatType[2],SetTo,Type),
			SetCVar(FP,CreatePlayer[2],SetTo,Owner),
			SetCVar(FP,TRepeatX[2],SetTo,SetX),
			SetCVar(FP,TRepeatY[2],SetTo,SetY),
		},Flags)
	end

end

function f_TempRepeatX(Condition,UnitID,Number,Type,Owner,CenterXY)
	if Owner == nil then Owner = 0xFFFFFFFF end
	if Type == nil then Type = 0 end
	local SetX = 0 
	local SetY = 0
	if CenterXY == nil then 
		SetX = 0xFFFFFFFF
		SetY = 0xFFFFFFFF
	elseif type(CenterXY) == "table" then
		SetX = CenterXY[1]
		SetY = CenterXY[2]
	elseif CenterXY == "CG" then
		SetX = 0x80000000
		SetY = 0x80000000
	else
		PushErrorMsg("TRepeat_CenterXY_Error")
	end
	CDoActions(FP,{
		TSetCVar(FP,Gun_TempSpawnSet1[2],SetTo,UnitID),
		TSetCVar(FP,Repeat_TempV[2],SetTo,Number),
		TSetCVar(FP,TRepeatX[2],SetTo,SetX),
		TSetCVar(FP,TRepeatY[2],SetTo,SetY),
		SetCVar(FP,RepeatType[2],SetTo,Type),
		SetCDeaths(FP,SetTo,0,CA_Repeat_Check),
		SetCVar(FP,CreatePlayer[2],SetTo,Owner)})
	CallTriggerX(FP,Set_Repeat,Condition)
end
Set_Repeat = SetCallForward()
SetCall(FP)
TriggerX(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,0)},{RotatePlayer({DisplayTextX(f_RepeatErr2,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP),SetCVar(FP,Repeat_TempV[2],SetTo,0)},{preserved})
TriggerX(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,256)},{SetCVar(FP,Repeat_TempV[2],SetTo,0)},{preserved})
CIf(FP,CVar(FP,Repeat_TempV[2],AtLeast,1))
	CMov(FP,Spawn_TempW,Repeat_TempV)
	CMov(FP,Repeat_TempV,0)
	CallTrigger(FP,Call_Repeat)
	CMov(FP,Spawn_TempW,0)
CIfEnd()
SetCallEnd()

local G_CA_LineV = CreateVar(FP)
local G_CA_CUTV = CreateVar(FP)
local G_CA_SNTV = CreateVar(FP)
local G_CA_LMTV = CreateVar(FP)
local G_CA_RPTV = CreateVar(FP)
local G_CA_CTTV = CreateVar(FP)
local G_CA_CPTV = CreateVar(FP)
local G_CA_SZTV = CreateVar(FP)
local G_CA_XPos = CreateVar(FP)
local G_CA_YPos = CreateVar(FP)
local SL_TempV = Create_VTable(4)
local SL_Ret = CreateVar(FP)

local Write_SpawnSet_Jump = def_sIndex()
local G_CA_Arr_IndexAlloc = StartIndex
local G_CA_InputCVar = {}
local G_CA_Lines = 55
local G_CA_TempTable = CreateVarArr(G_CA_Lines,FP)
local G_CA_TempH = CreateVar(FP)
local G_CA_Num = CreateVar(FP)
for i = 1, G_CA_Lines do
	table.insert(G_CA_InputCVar,SetCVar(FP,G_CA_TempTable[i][2],SetTo,0))
end
local G_CA_InputH = CreateVar(FP)
local G_CA_LineTemp = CreateVar(FP)


Call_SLCalc = SetCallForward()
SetCall(FP)
CMov(FP,SL_Ret,0)
for i = 1, 4 do
	CIfX(FP,CVar(FP,SL_TempV[i][2],AtMost,255))
		local RandRet = f_CRandNum(12,1)
		CAdd(FP,SL_TempV[i],RandRet)
		f_Mul(FP,SL_Ret,SL_TempV[i],_Mov(256^(i-1)),0xFF*(256^(i-1)))
	CElseIfX(CVar(FP,SL_TempV[i][2],AtLeast,257))
		CSub(FP,SL_TempV[i],256)
		f_Mul(FP,SL_Ret,SL_TempV[i],_Mov(256^(i-1)),0xFF*(256^(i-1)))
	CElseX()
		CMov(FP,SL_Ret,SL_TempV[i],0,0xFF*(256^(i-1)))
	CIfXEnd()
end
SetCallEnd()

table.insert(CtrigInitArr[FP+1],SetCtrigX(FP,G_CA_InputH[2],0x15C,0,SetTo,FP,StartIndex,0x15C,1,0))

Write_SpawnSet = SetCallForward()
SetCall(FP)
CallTrigger(FP,Call_SLCalc)
UnitIDV1,UnitIDV2,UnitIDV3,UnitIDV4 = CreateVars(4,FP)
local PatchCondArr = {UnitIDV1,UnitIDV2,UnitIDV3,UnitIDV4}
for i = 221, 224 do
	CTrigger(FP,{CVar(FP,G_CA_CUTV[2],Exactly,i,0xFF)},{TSetCVar(FP,G_CA_CUTV[2],SetTo,PatchCondArr[i-220],0xFF)},1)
	CIf(FP,{CVar(FP,G_CA_CUTV[2],Exactly,i*0x100,0xFF00)})
		CTrigger(FP,{},{TSetCVar(FP,G_CA_CUTV[2],SetTo,_Mul(PatchCondArr[i-220],_Mov(0x100)),0xFF00)},1)
	CIfEnd()
	CIf(FP,{CVar(FP,G_CA_CUTV[2],Exactly,i*0x10000,0xFF0000)})
		CTrigger(FP,{},{TSetCVar(FP,G_CA_CUTV[2],SetTo,_Mul(PatchCondArr[i-220],_Mov(0x10000)),0xFF0000)},1)
	CIfEnd()
	CIf(FP,{CVar(FP,G_CA_CUTV[2],Exactly,i*0x1000000,0xFF000000)})
		CTrigger(FP,{},{TSetCVar(FP,G_CA_CUTV[2],SetTo,_Mul(PatchCondArr[i-220],_Mov(0x1000000)),0xFF000000)},1)
	CIfEnd()
end
if Limit == 1 then
TriggerX(FP,{CD(TestMode,1)},{RotatePlayer({DisplayTextX(f_GunSpawnSet,4)},HumanPlayers,FP)})
end
CMov(FP,G_CA_LineV,0)
CJumpEnd(FP,Write_SpawnSet_Jump)

CAdd(FP,G_CA_LineTemp,G_CA_LineV,G_CA_InputH)
NIfX(FP,{TMemory(G_CA_LineTemp,AtMost,0)})
CDoActions(FP,{
	TSetMemory(_Add(G_CA_LineTemp,0*(0x20/4)),SetTo,G_CA_CUTV),
	TSetMemory(_Add(G_CA_LineTemp,1*(0x20/4)),SetTo,SL_Ret),
	TSetMemory(_Add(G_CA_LineTemp,2*(0x20/4)),SetTo,1),
	TSetMemory(_Add(G_CA_LineTemp,3*(0x20/4)),SetTo,G_CA_SNTV),
	TSetMemory(_Add(G_CA_LineTemp,4*(0x20/4)),SetTo,G_CA_LMTV),
	TSetMemory(_Add(G_CA_LineTemp,5*(0x20/4)),SetTo,G_CA_RPTV),
	TSetMemory(_Add(G_CA_LineTemp,6*(0x20/4)),SetTo,G_CA_CTTV),
	TSetMemory(_Add(G_CA_LineTemp,9*(0x20/4)),SetTo,G_CA_CPTV),
	TSetMemory(_Add(G_CA_LineTemp,10*(0x20/4)),SetTo,G_CA_SZTV),
})
CIfX(FP,{CVar(FP,G_CA_XPos[2],Exactly,0xFFFFFFFF),CVar(FP,G_CA_YPos[2],Exactly,0xFFFFFFFF)})
CDoActions(FP,{
	TSetMemory(_Add(G_CA_LineTemp,7*(0x20/4)),SetTo,G_CA_X),
	TSetMemory(_Add(G_CA_LineTemp,8*(0x20/4)),SetTo,G_CA_Y)
})
CElseX()
CDoActions(FP,{
	TSetMemory(_Add(G_CA_LineTemp,7*(0x20/4)),SetTo,G_CA_XPos),
	TSetMemory(_Add(G_CA_LineTemp,8*(0x20/4)),SetTo,G_CA_YPos)
})
CIfXEnd()

NElseIfX({CVar(FP,G_CA_LineV[2],AtMost,((0x970/4)*Size_of_G_CA_Arr-2))})
CAdd(FP,G_CA_LineV,0x970/4)
CJump(FP,Write_SpawnSet_Jump)
NElseX()

DoActions(FP,{RotatePlayer({DisplayTextX(f_GunSendErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})

NIfXEnd()
SetCallEnd()










local CA_TempUID = CreateVar(FP)
local CA_Suspend = CreateCcode()
local G_CA_Temp = Create_VTable(11)

Call_CA_Repeat = SetCallForward()
SetCall(FP)
TriggerX(FP,{CVar(FP,CA_TempUID[2],AtLeast,221)},{SetCVar(FP,CA_TempUID[2],SetTo,0)},{preserved})
DoActionsX(FP,{SetCDeaths(FP,SetTo,1,CA_Repeat_Check)})
CMov(FP,Gun_TempSpawnSet1,CA_TempUID)
CMov(FP,Repeat_TempV,1)
TriggerX(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,84),CVar(FP,Repeat_TempV[2],Exactly,4)},{SetCVar(FP,Repeat_TempV[2],SetTo,1)},{preserved}) -- 도형건작 옵저버 1개 제한

CMov(FP,RepeatType,G_CA_Temp[6],nil,0xFF)
CMov(FP,CreatePlayer,G_CA_Temp[10])
CallTrigger(FP,Set_Repeat)
SetCallEnd()

local G_CA_Launch = CreateCcode()
function CA_Repeat()
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	
	CallTrigger(FP,Call_CA_Repeat,{SetCDeaths(FP,SetTo,1,G_CA_Launch)})
	--CIfX(FP,{CVar(FP,CA[8],AtMost,4096),CVar(FP,CA[9],AtMost,4096)})
	--CallTrigger(FP,Call_CA_Repeat,{SetCDeaths(FP,SetTo,1,G_CA_Launch)})
	--if Limit == 1 then
	--	CElseX({SetCDeaths(FP,SetTo,1,G_CA_Launch),RotatePlayer({DisplayTextX(G_CA_PosErr,4)},HumanPlayers,FP)})--
	--else
	--	CElseX({SetCDeaths(FP,SetTo,1,G_CA_Launch)})--RotatePlayer({DisplayTextX(G_CA_PosErr,4)},HumanPlayers,FP)
	--end
	--CIfXEnd()
end

function CA_Func1()
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local SizeTemp = CreateVar(FP)
	CIf(FP,{TTCVar(FP,G_CA_Temp[11][2],NotSame,100,0xFF)})
		CMov(FP, SizeTemp, G_CA_Temp[11], nil, 0xFF, 1)
		CA_RatioXY(SizeTemp, 100, SizeTemp, 100)
	CIfEnd()
end
local G_CA_CallStack = {}
local G_CA_IndexAlloc = 1
function G_CAPlot(ShapeTable,X2Option)
	local G_CA_CallIndex = SetCallForward()
	local Ret = G_CA_IndexAlloc
	local CA = CAPlotForward()
	SetCall(FP)
	CMov(FP,CA_TempUID,G_CA_Temp[1],nil,0xFF)
	CMov(FP,V(CA[1]),G_CA_Temp[2],nil,0xFF)
	CMov(FP,V(CA[6]),G_CA_Temp[3])
	CIfX(FP,CVar(FP,G_CA_Temp[5][2],AtMost,0))
		if type(ShapeTable[1]) == "number" then
			DoActionsX(FP,{SetCVar(FP,CA[1],SetTo,1,0xFF),SetCVar(FP,CA[5],SetTo,(ShapeTable[1]/50)+1)})
		elseif type(ShapeTable) == "table" then
			for j, k in pairs(ShapeTable) do
				CTrigger(FP,{CVar(FP,G_CA_Temp[2][2],Exactly,j,0xFF)},{SetCVar(FP,CA[5],SetTo,(k[1]/50)+1)},1)
			end
		else
			PushErrorMsg("G_CAPlot_InputData_Error")
		end
	CElseX()
		CMov(FP,V(CA[5]),G_CA_Temp[5])
	CIfXEnd()
	CMov(FP,G_CA_BackupX,G_CA_TempTable[8])
	CMov(FP,G_CA_BackupY,G_CA_TempTable[9])
	CAPlot2(ShapeTable,FP,nilunit,0,{G_CA_TempTable[8],G_CA_TempTable[9]},1,32,{0,0,0,0,0,1},"CA_Func1",FP,nil,nil,{SetCDeaths(FP,Add,1,CA_Suspend)},"CA_Repeat")
	CDoActions(FP,{TSetCVar(FP,G_CA_Temp[3][2],SetTo,V(CA[6]))})
	SetCallEnd()
	G_CA_IndexAlloc = G_CA_IndexAlloc + 1
	table.insert(G_CA_CallStack,{G_CA_CallIndex,X2Option})
	return Ret
end
G_CA2_ShapeTable = {}
function G_CAPlot2(ShapeTable,X2Option)
	if type(ShapeTable) ~= "table" then
		PushErrorMsg("ShapeData_Input_Error")
	end
	local Y = {}
	for j, k in pairs(ShapeTable) do
		if type(k) ~= "string" then
			PushErrorMsg("ShapeData_Input_Error")
		end
		table.insert(Y,_G[k])
		table.insert(G_CA2_ShapeTable,k)
	end


	local G_CA_CallIndex = SetCallForward()
	Another_CAPlot_Shape = G_CA_IndexAlloc
	local CA = CAPlotForward()
	local X = {}
	SetCall(FP)
	CMov(FP,CA_TempUID,G_CA_Temp[1],nil,0xFF)
	CMov(FP,V(CA[1]),G_CA_Temp[2],nil,0xFF)
	CMov(FP,V(CA[6]),G_CA_Temp[3])
	CIfX(FP,CVar(FP,G_CA_Temp[5][2],AtMost,0))
		for j, k in pairs(Y) do
			CTrigger(FP,{CVar(FP,G_CA_Temp[2][2],Exactly,j,0xFF)},{SetCVar(FP,CA[5],SetTo,(k[1]/50)+1)},1)
		end
	CElseX()
		CMov(FP,V(CA[5]),G_CA_Temp[5])
	CIfXEnd()
	CMov(FP,G_CA_BackupX,G_CA_TempTable[8])
	CMov(FP,G_CA_BackupY,G_CA_TempTable[9])
	
	CAPlot2(Y,FP,nilunit,0,{G_CA_TempTable[8],G_CA_TempTable[9]},1,32,{0,0,0,0,0,1},"CA_Func1",FP,nil,nil,{SetCDeaths(FP,Add,1,CA_Suspend)},"CA_Repeat")
	CDoActions(FP,{TSetCVar(FP,G_CA_Temp[3][2],SetTo,V(CA[6]))})
	SetCallEnd()
	G_CA_IndexAlloc = G_CA_IndexAlloc + 1
	table.insert(G_CA_CallStack,{G_CA_CallIndex,X2Option})
end



function T_to_BiteBuffer(Table)
	local BiteValue = 0
	if type(Table) == "table" then
		local ret = 0
		if #Table >= 5 then
			PushErrorMsg("BiteStack_is_Over_5")
		end
		for i, j in pairs(Table) do
			if type(j) == "string" and j =="ACAS" then
				BiteValue = BiteValue + Another_CAPlot_Shape*(256^ret)
			else
			BiteValue = BiteValue + j*(256^ret)
			end
			ret = ret + 1
		end
		Table = BiteValue
	end
	return BiteValue
end

function G_CA_SetSpawn(Condition,G_CA_CUTable,G_CA_SNTable,G_CA_SLTable,G_CA_LMTable,G_CA_RepeatType,G_CA_SizeTable,CenterXY,Owner,PreserveFlag)
	if G_CA_SizeTable == nil then G_CA_SizeTable = 100 end


	if type(G_CA_CUTable) ~= "table" then
		PushErrorMsg("G_CA_SetSpawn_Inputdata_Error")
	end

	if type(G_CA_SizeTable) ~= "table" then
		G_CA_SizeTable = {G_CA_SizeTable,G_CA_SizeTable,G_CA_SizeTable,G_CA_SizeTable}
	end
	
	if type(G_CA_SNTable) ~= "table" then
		G_CA_SNTable = {G_CA_SNTable,G_CA_SNTable,G_CA_SNTable,G_CA_SNTable}
	elseif G_CA_SNTable == nil then 
		PushErrorMsg("G_CA_SetSpawn_Inputdata_Error")
	end
	if type(G_CA_SLTable) ~= "table" then
		G_CA_SLTable = {G_CA_SLTable,G_CA_SLTable,G_CA_SLTable,G_CA_SLTable}
	elseif G_CA_SLTable == nil then
		PushErrorMsg("G_CA_SetSpawn_Inputdata_Error")
	end
	if type(G_CA_RepeatType) ~= "table" then
		G_CA_RepeatType = {G_CA_RepeatType,G_CA_RepeatType,G_CA_RepeatType,G_CA_RepeatType}
	end
	
	local X = {}
	if type(G_CA_SLTable) == "table" then
		if #G_CA_SLTable >= 5 then
			PushErrorMsg("BiteStack_is_Over_5")
		end
		for i = 1, 4 do
			if G_CA_SLTable[i] ~= nil then
				if type(G_CA_SLTable[i]) == "number" then
					table.insert(X,SetCVar(FP,SL_TempV[i][2],SetTo,12*G_CA_SLTable[i]))
				elseif type(G_CA_SLTable[i]) == "string" then
					local G_CA2_ShapeTable_Check = ""
					for j, k in pairs(G_CA2_ShapeTable) do
						if G_CA_SLTable[i] == k then
							table.insert(X,SetCVar(FP,SL_TempV[i][2],SetTo,256+j))
							G_CA2_ShapeTable_Check = "OK"
						end
					end
					if G_CA2_ShapeTable_Check ~= "OK" then
						PushErrorMsg("G_CA_SetSpawn_String_Shape_NotFound")
					end
				else
					PushErrorMsg("G_CA_SLTable_InputData_Error")
				end
			else
				table.insert(X,SetCVar(FP,SL_TempV[i][2],SetTo,256))
			end
		end
	else
		PushErrorMsg("G_CA_SLTable_InputData_Error")
	end
	local LMRet = 0
	if G_CA_LMTable == "MAX" then
		LMRet = T_to_BiteBuffer({255,255,255,255})
	elseif type(G_CA_LMTable) == "table" then
		LMRet = T_to_BiteBuffer(G_CA_LMTable)
	elseif type(G_CA_LMTable) == "number" then
		local NumRet = G_CA_LMTable
		LMRet = T_to_BiteBuffer({NumRet,NumRet,NumRet,NumRet})
	end
	local Y = {}
	if CenterXY == nil then 
		table.insert(Y,SetCVar(FP,G_CA_XPos[2],SetTo,0xFFFFFFFF))
		table.insert(Y,SetCVar(FP,G_CA_YPos[2],SetTo,0xFFFFFFFF))
	elseif type(CenterXY) == "table" then
		table.insert(Y,SetCVar(FP,G_CA_XPos[2],SetTo,CenterXY[1]))
		table.insert(Y,SetCVar(FP,G_CA_YPos[2],SetTo,CenterXY[2]))
	else
		PushErrorMsg("G_CA_SetSpawn_CenterXY_Inputdata_Error")
	end
	if Owner == nil then
		Owner = 0xFFFFFFFF
	end
	CallTriggerX(FP,Write_SpawnSet,Condition,{
		SetCVar(FP,G_CA_CUTV[2],SetTo,T_to_BiteBuffer(G_CA_CUTable)),X,
		SetCVar(FP,G_CA_SNTV[2],SetTo,T_to_BiteBuffer(G_CA_SNTable)),
		SetCVar(FP,G_CA_LMTV[2],SetTo,LMRet),
		SetCVar(FP,G_CA_RPTV[2],SetTo,T_to_BiteBuffer(G_CA_RepeatType)),
		SetCVar(FP,G_CA_SZTV[2],SetTo,T_to_BiteBuffer(G_CA_SizeTable)),Y,
		SetCVar(FP,G_CA_CPTV[2],SetTo,Owner),
	},PreserveFlag)
end

function Install_Load_CAPlot()
	Load_CAPlot_Shape = SetCallForward()
	SetCall(FP)

	for j, k in pairs(G_CA_CallStack) do
		CallTriggerX(FP,k[1],{CVar(FP,G_CA_Temp[4][2],Exactly,j,0xFF)},{})
	end
	SetCallEnd()
end




function Install_Call_G_CA()
	Call_G_CA = SetCallForward()
	SetCall(FP)
		CIfX(FP,CVar(FP,G_CA_TempTable[1][2],AtLeast,1,0xFF))
			CDoActions(FP,{
				TSetCVar(FP,G_CA_Temp[1][2],SetTo,G_CA_TempTable[1],0xFF),
				TSetCVar(FP,G_CA_Temp[2][2],SetTo,G_CA_TempTable[2],0xFF),
				TSetCVar(FP,G_CA_Temp[3][2],SetTo,G_CA_TempTable[3]),
				TSetCVar(FP,G_CA_Temp[4][2],SetTo,G_CA_TempTable[4],0xFF),
				TSetCVar(FP,G_CA_Temp[5][2],SetTo,G_CA_TempTable[5],0xFF),
				TSetCVar(FP,G_CA_Temp[6][2],SetTo,G_CA_TempTable[6],0xFF),
				TSetCVar(FP,G_CA_Temp[7][2],SetTo,G_CA_TempTable[7],0xFF),
				TSetCVar(FP,G_CA_Temp[8][2],SetTo,G_CA_TempTable[8]),
				TSetCVar(FP,G_CA_Temp[9][2],SetTo,G_CA_TempTable[9]),
				TSetCVar(FP,G_CA_Temp[10][2],SetTo,G_CA_TempTable[10]),
				TSetCVar(FP,G_CA_Temp[11][2],SetTo,G_CA_TempTable[11],0xFF),
			})
			CallTrigger(FP,Load_CAPlot_Shape)
			CIfX(FP,{CDeaths(FP,AtLeast,1,G_CA_Launch),CDeaths(FP,AtMost,0,CA_Suspend)})
				CDoActions(FP,{
					TSetMemoryX(Vi(G_CA_TempH[2],0*(0x20/4)),SetTo,G_CA_Temp[1],0xFF),
					TSetMemoryX(Vi(G_CA_TempH[2],1*(0x20/4)),SetTo,G_CA_Temp[2],0xFF),
					TSetMemory(Vi(G_CA_TempH[2],2*(0x20/4)),SetTo,G_CA_Temp[3]),
					TSetMemoryX(Vi(G_CA_TempH[2],3*(0x20/4)),SetTo,G_CA_Temp[4],0xFF),
					TSetMemoryX(Vi(G_CA_TempH[2],4*(0x20/4)),SetTo,G_CA_Temp[5],0xFF),
					TSetMemoryX(Vi(G_CA_TempH[2],5*(0x20/4)),SetTo,G_CA_Temp[6],0xFF),
					TSetMemoryX(Vi(G_CA_TempH[2],6*(0x20/4)),SetTo,G_CA_Temp[7],0xFF),
					TSetMemoryX(Vi(G_CA_TempH[2],10*(0x20/4)),SetTo,G_CA_Temp[11],0xFF),
				})
			CElseIfX({CDeaths(FP,AtLeast,1,G_CA_Launch),CDeaths(FP,AtLeast,1,CA_Suspend)})
			CDoActions(FP,{
				TSetMemoryX(Vi(G_CA_TempH[2],0*(0x20/4)),SetTo,0,0xFF),
				TSetMemoryX(Vi(G_CA_TempH[2],1*(0x20/4)),SetTo,0,0xFF),
				TSetMemory(Vi(G_CA_TempH[2],2*(0x20/4)),SetTo,1),
				TSetMemoryX(Vi(G_CA_TempH[2],3*(0x20/4)),SetTo,0,0xFF),
				TSetMemoryX(Vi(G_CA_TempH[2],4*(0x20/4)),SetTo,0,0xFF),
				TSetMemoryX(Vi(G_CA_TempH[2],5*(0x20/4)),SetTo,0,0xFF),
				TSetMemoryX(Vi(G_CA_TempH[2],6*(0x20/4)),SetTo,0,0xFF),
				TSetMemoryX(Vi(G_CA_TempH[2],10*(0x20/4)),SetTo,0,0xFF),
			})
			if TestStart == 1 then
			DoActions(FP,{RotatePlayer({DisplayTextX(f_GunFuncT,4)},HumanPlayers,FP)})
			end
			CElseX()
			if TestStart == 1 then
				DoActions(FP,{RotatePlayer({DisplayTextX(f_GunErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
			end
			
				CDoActions(FP,{
					TSetMemoryX(Vi(G_CA_TempH[2],0*(0x20/4)),SetTo,0,0xFF),
					TSetMemoryX(Vi(G_CA_TempH[2],1*(0x20/4)),SetTo,0,0xFF),
					TSetMemory(Vi(G_CA_TempH[2],2*(0x20/4)),SetTo,1),
					TSetMemoryX(Vi(G_CA_TempH[2],3*(0x20/4)),SetTo,0,0xFF),
					TSetMemoryX(Vi(G_CA_TempH[2],4*(0x20/4)),SetTo,0,0xFF),
					TSetMemoryX(Vi(G_CA_TempH[2],5*(0x20/4)),SetTo,0,0xFF),
					TSetMemoryX(Vi(G_CA_TempH[2],6*(0x20/4)),SetTo,0,0xFF),
					TSetMemoryX(Vi(G_CA_TempH[2],10*(0x20/4)),SetTo,0,0xFF),
				})
			CIfXEnd()
		CElseIfX({CVar(FP,G_CA_TempTable[1][2],AtMost,0,0xFF),CVar(FP,G_CA_TempTable[1][2],AtLeast,1)})
			CDoActions(FP,{
			TSetMemory(Vi(G_CA_TempH[2],0*(0x20/4)),SetTo,_Div(G_CA_TempTable[1],_Mov(256))),
			TSetMemory(Vi(G_CA_TempH[2],1*(0x20/4)),SetTo,_Div(G_CA_TempTable[2],_Mov(256))),
			TSetMemory(Vi(G_CA_TempH[2],2*(0x20/4)),SetTo,1),
			TSetMemory(Vi(G_CA_TempH[2],3*(0x20/4)),SetTo,_Div(G_CA_TempTable[4],_Mov(256))),
			TSetMemory(Vi(G_CA_TempH[2],4*(0x20/4)),SetTo,_Div(G_CA_TempTable[5],_Mov(256))),
			TSetMemory(Vi(G_CA_TempH[2],5*(0x20/4)),SetTo,_Div(G_CA_TempTable[6],_Mov(256))),
			TSetMemory(Vi(G_CA_TempH[2],6*(0x20/4)),SetTo,_Div(G_CA_TempTable[7],_Mov(256))),
			TSetMemory(Vi(G_CA_TempH[2],10*(0x20/4)),SetTo,_Div(G_CA_TempTable[11],_Mov(256))),
		})
		CIfXEnd()
		DoActionsX(FP,{SetCDeaths(FP,SetTo,0,CA_Suspend),SetCDeaths(FP,SetTo,0,G_CA_Launch)})
	SetCallEnd()
end
local Actived_G_CA = CreateVar(FP)
function Create_G_CA_Arr()
	if G_CA_Arr_IndexAlloc ~= StartIndex then PushErrorMsg("Already_G_CA_Arr_Created") end
	CMov(FP,Actived_G_CA,0)
	for i = 0, Size_of_G_CA_Arr-1 do
		CTrigger(FP, {CVar("X","X",AtLeast,1)}, {
			G_CA_InputCVar,
			SetCtrigX("X",G_CA_TempH[2],0x15C,0,SetTo,"X","X",0x15C,1,0),
			SetCVar(FP,G_CA_Num[2],SetTo,i),
			SetCVar(FP,Actived_G_CA[2],Add,1),
			SetNext("X",Call_G_CA,0),SetNext(Call_G_CA+1,"X",1), -- Call f_Gun
			SetCtrigX("X",Call_G_CA+1,0x158,0,SetTo,"X","X",0x4,1,0), -- RecoverNext
			SetCtrigX("X",Call_G_CA+1,0x15C,0,SetTo,"X","X",0,0,1), -- RecoverNext
			SetCtrig1X("X",Call_G_CA+1,0x164,0,SetTo,0x0,0x2) -- RecoverNext
		}, 1, G_CA_Arr_IndexAlloc)
		G_CA_Arr_IndexAlloc = G_CA_Arr_IndexAlloc + 1
	end
	--CMov(FP,0x57f0f0,Actived_G_CA)
end


	function G_CA_Lib_ErrorCheck()
		if Load_CAPlot_Shape == nil then PushErrorMsg("Need_Install_Load_CAPlot") end
	end
end

function SetUnitAbility(UnitID,WepID,HP,Shield,Cooldown,Damage,ObjNum,RangeMax,SeekRange,Point,Text,KillPoint)
	local TempWID = WepID
	local TempWID2 = 130
	if Point~=nil then
		table.insert(UnitPointArr, {UnitID,Point,Text})
	end
	table.insert(UnitPointArr2, UnitID)

	if UnitID == 62 then TempWID2 = WepID end
	if UnitID == 98 then TempWID2 = WepID end
	if UnitID == 86 then TempWID2 = WepID end
	if 
	UnitID == 3 or 
	UnitID == 5 or 
	UnitID == 17 or 
	UnitID == 23 or 
	UnitID == 25 or 
	UnitID == 30 then TempWID = 130 
	SetUnitsDatX(UnitID+1, {GroundWeapon=WepID,AirWeapon=TempWID2})
	end
	local Size = 4
	if UnitID == 74 or UnitID == 75 then
		Size = nil
	end
	SetUnitsDatX(UnitID, {AdvFlag={0x40,0x40},ComputerAI=3,HP=HP,Shield=Shield,GroundWeapon=TempWID,AirWeapon=TempWID2,SeekRange = SeekRange,KillScore=KillPoint,SizeL=Size,SizeU=Size,SizeR=Size,SizeD=Size
})
if ObjNum == nil then ObjNum = 1 end
SetWeaponsDatX(WepID,{Cooldown = Cooldown,DmgBase=Damage,RangeMax=RangeMax,ObjectNum=ObjNum,Splash=false,DmgFactor=0})


end



LabelUseArr = {}

function CtrigX(Player,Index,Address,Next,Type,Value,Mask)
	if Player == "X" then 
		Player = nil
	end
	if Index == "X" then 
		Index = nil
	end
	if Index == 0 then 
		Index = nil
	end
	if Next == "X" then 
		Next = nil
	end
	if Mask == "X" then 
		Mask = nil
	end
	if Index ~= nil and LabelUseArr[Index]==nil then
		LabelUseArr[Index] = true
	end


	local Pflag
	if Player == nil then
		Pflag = 0
	else
		if Player >= 0 and Player <= 7 then
			Pflag = Player + 1
		else
			Pflag = 0
		end
	end

	local Mflag
	if Mask == nil then
		Mflag = 0
		Mask = 0
	else
		--Mflag = 32 (Rflag)
		Mflag = 0x80
	end

	local Nflag
	if Next == 0 or Next == nil then
		Nflag = 0
	elseif Next == 1 then 
		Nflag = 16
	else
		Nflag = 0
		Address = Address + 0x970*Next
	end

	local Cflag
	if Index == nil then
		Index = 0
		Cflag = 64
	else
		Cflag = 0
	end

	local Xflag = 0
	if Index >= 0x10000 then
		Index = Index - 0x10000
		Xflag = 128
	end

	local Rflag
	Rflag = Pflag + Nflag + Cflag + Xflag

	local ExCtrigX = Condition(Mask,Address/4,Value,Index,Type,0xFF,Rflag,0x10+Mflag) -- #DefCond
	return ExCtrigX
end

function SetCtrigX(Player1,Index1,Address1,Next1,Type,Player2,Index2,Address2,EPD2,Next2,Mask)
	if Player1 == "X" then 
		Player1 = nil
	end
	if Index1 == "X" then 
		Index1 = nil
	end
	if Index1 == 0 then 
		Index1 = nil
	end
	if Next1 == "X" then 
		Next1 = nil
	end
	if Player2 == "X" then 
		Player2 = nil
	end
	if Index2 == "X" then 
		Index2 = nil
	end
	if Index2 == 0 then 
		Index2 = nil
	end
	if Next2 == "X" then 
		Next2 = nil
	end
	if EPD2 == "X" then
		EPD2 = nil
	end
	if Mask == "X" then 
		Mask = nil
	end

	if Index1~=nil and LabelUseArr[Index1]==nil then
		LabelUseArr[Index1] = true
	end
	if Index2~=nil and LabelUseArr[Index2]==nil then
		LabelUseArr[Index2] = true
	end

	local Pflag1
	if Player1 == nil then
		Pflag1 = 0
	else
		if Player1 >= 0 and Player1 <= 7 then
			Pflag1 = Player1 + 1
		else
			Pflag1 = 0
		end
	end

	local Nflag1
	if Next1 == 0 or Next1 == nil then
		Nflag1 = 0
	elseif Next1 == 1 then 
		Nflag1 = 16
	else
		Nflag1 = 0
		Address1 = Address1 + 0x970*Next1
	end

	local Cflag1
	if Index1 == nil then
		Index1 = 0
		Cflag1 = 32
	else
		Cflag1 = 0
	end

	local Xflag1 = 0
	if Index1 >= 0x10000 then
		Index1 = Index1 - 0x10000
		Xflag1 = 64
	end

	local Pflag2
	if Player2 == nil then
		Pflag2 = 0
	else
		if Player2 >= 0 and Player2 <= 7 then
			Pflag2 = Player2 + 1
		else
			Pflag2 = 0
		end
	end

	local Nflag2
	if Next2 == 0 or Next2 == nil then
		Nflag2 = 0
	elseif Next2 == 1 then 
		Nflag2 = 16
	else
		Nflag2 = 0
		Address2 = Address2 + 0x970*Next2
	end

	local Mflag2
	if Mask == nil then
		Mflag2 = 0
		Mask = 0
	else
		--Mflag2 = 64 (Rflag2)
		Mflag2 = 0x80
	end

	local Addr2
	if EPD2 == 0 or EPD2 == nil then
		Addr2 = Address2
		Eflag2 = 0
	else
		Addr2 = Address2/4
		Eflag2 = 32
	end

	local Cflag2
	if Index2 == nil then
		Index2 = 0
		Cflag2 = 128
	else
		Cflag2 = 0
	end

	local Xflag2 = 0
	if Index2 >= 0x10000 then
		Index2 = Index2 - 0x10000
		Xflag2 = 128
	end

	local Rflag1
	Rflag1 = Pflag1 + Nflag1 + Cflag1 + Xflag1 + Xflag2
	local Rflag2
	Rflag2 = Pflag2 + Nflag2 + Eflag2 + Cflag2

	local ExSetCtrigX = Action(Mask,Index1,Rflag1,Rflag2,Address1/4,Addr2,Index2,0x5,Type,0x14+Mflag2) -- #DefAct (PauseGame = 0x5)
	return ExSetCtrigX
end

function SetCtrig1X(Player1,Index1,Address1,Next1,Type,Value,Mask)
	if Player1 == "X" then 
		Player1 = nil
	end
	if Index1 == "X" then 
		Index1 = nil
	end
	if Index1 == 0 then 
		Index1 = nil
	end
	if Index1 ~= nil and LabelUseArr[Index1]==nil then
		LabelUseArr[Index1] = true
	end
	if Next1 == "X" then 
		Next1 = nil
	end
	if Mask == "X" then 
		Mask = nil
	end

	local Pflag1
	if Player1 == nil then
		Pflag1 = 0
	else
		if Player1 >= 0 and Player1 <= 7 then
			Pflag1 = Player1 + 1
		else
			Pflag1 = 0
		end
	end

	local Nflag1
	if Next1 == 0 or Next1 == nil then
		Nflag1 = 0
	elseif Next1 == 1 then 
		Nflag1 = 16
	else
		Nflag1 = 0
		Address1 = Address1 + 0x970*Next1
	end

	local Cflag1
	if Index1 == nil then
		Index1 = 0
		Cflag1 = 32
	else
		Cflag1 = 0
	end

	local Xflag1 = 0
	if Index1 >= 0x10000 then
		Index1 = Index1 - 0x10000
		Xflag1 = 64
	end

	local Rflag1
	Rflag1 = Pflag1 + Nflag1 + Cflag1 + Xflag1

	local Mflag2
	if Mask == nil then
		Mflag2 = 0
		Mask = 0
	else
		--Mflag2 = 64 (Rflag2)
		Mflag2 = 0x80
	end

	local ExSetCtrig1X = Action(Mask,Index1,Rflag1,0,Address1/4,Value,0,0x5,Type,0x14+Mflag2) -- (PauseGame = 0x5)
	return ExSetCtrig1X
end

function SetCtrig2X(Offset,Type,Player2,Index2,Address2,EPD2,Next2,Mask)
	if Player2 == "X" then 
		Player2 = nil
	end
	if Index2 == "X" then 
		Index2 = nil
	end
	if Index2 == 0 then 
		Index2 = nil
	end
	if Next2 == "X" then 
		Next2 = nil
	end
	if EPD2 == "X" then
		EPD2 = nil
	end
	if Mask == "X" then 
		Mask = nil
	end
	if Index2 ~=nil and LabelUseArr[Index2]==nil then
		LabelUseArr[Index2] = true
	end

	local Pflag2
	if Player2 == nil then
		Pflag2 = 0
	else
		if Player2 >= 0 and Player2 <= 7 then
			Pflag2 = Player2 + 1
		else
			Pflag2 = 0
		end
	end

	local Nflag2
	if Next2 == 0 or Next2 == nil then
		Nflag2 = 0
	elseif Next2 == 1 then 
		Nflag2 = 16
	else
		Nflag2 = 0
		Address2 = Address2 + 0x970*Next2
	end

	local Mflag2
	if Mask == nil then
		Mflag2 = 0
		Mask = 0
	else
		--Mflag2 = 64 (Rflag2)
		Mflag2 = 0x80
	end

	local Addr2
	if EPD2 == 0 or EPD2 == nil then
		Addr2 = Address2
		Eflag2 = 0
	else
		Addr2 = Address2/4
		Eflag2 = 32
	end

	local Cflag2
	if Index2 == nil then
		Index2 = 0
		Cflag2 = 128
	else
		Cflag2 = 0
	end

	local Xflag2 = 0
	if Index2 >= 0x10000 then
		Index2 = Index2 - 0x10000
		Xflag2 = 128
	end

	local Rflag1
	Rflag1 = Xflag2
	local Rflag2
	Rflag2 = Pflag2 + Nflag2 + Eflag2 + Cflag2

	local Offset2
	if Offset == "Cp" then
		Offset2 = 13
	else
		Offset2 = EPD(Offset)
	end

	local ExSetCtrig2X = Action(Mask,0,Rflag1,Rflag2,Offset2,Addr2,Index2,0x5,Type,0x14+Mflag2) -- (PauseGame = 0x5)
	return ExSetCtrig2X
end


function LabelUseCheck() -- Label 사용 체크
	local C = {}
	for k,v in pairs(LabelArr) do
		if v ~= 0xFFE0 then
			if not C[v] then
				C[v] = true
			end
		else
			Prohibited_Label()
		end
	end
	for k, v in pairs(LabelUseArr) do
		if k~=nil and C[k]== nil then
			_G["Undefined Label! Current Label : 0x"..string.format("%X",k)]() -- push error msg
		end
		
	end
end