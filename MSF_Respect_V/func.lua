
--DatEdit
PatchArr = {}
PatchArr2 = {}
PatchArrPrsv = {}

StrD={
	"\x07。\x18˙\x0F+\x1C˚ "," \x1C。\x0F+\x18.\x07˚"
}
---@param Str? string
---@return string
function StrDesign(Str)
	return "\x07。\x18˙\x0F+\x1C˚ "..Str.." \x1C。\x0F+\x18.\x07˚"
end
---@param Str? string
---@return string
function StrDesignX(Str)
	return "\x13\x07。\x18˙\x0F+\x1C˚ "..Str.." \x1C。\x0F+\x18.\x07˚"
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
			elseif j=="DamageType" then
				PatchInsert(SetMemoryB(0x657258 + WepID, SetTo, k))
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
					PatchInsert(SetMemoryB(0x57F27C + (5 * 228) + UnitID,SetTo,0))
					PatchInsert(SetMemoryB(0x57F27C + (6 * 228) + UnitID,SetTo,0))
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
				
			elseif j=="Armor"  then
				PatchInsert(SetMemoryB(0x65FEC8 + UnitID,SetTo,k)) -- 아머
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
			elseif j=="Class"  then
				PatchInsert(SetMemoryB(0x663DD0+(UnitID),SetTo,k))
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
			elseif j=="Reqptr" then -- 지원되지 않음. 뎡디터에서 직접 고칠것
				--PatchInsertPrsv(SetMemoryW(0x660A70+(UnitID*2), SetTo, k))
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
			elseif j== "SightRange" then
				PatchInsert(SetMemoryB(0x663238+(UnitID),SetTo,k))--SightRange
				
			else
				
				PushErrorMsg("Wrong Property Name Detected!! : "..j)
			end
			
		end
	end
end


function CreateUnitQueue()
	
	local QueueUID = CreateVar(FP)
	local QueuePID = CreateVar(FP)
	local QueueType = CreateVar(FP)
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
	NWhile(FP,{CV(count,QueueMaxUnit,AtMost),Memory(0x628438,AtLeast,1),CV(CreateUnitQueueNum,1,AtLeast)},{})
	local BKX, BKY = CreateVars(2, FP)
	f_Read(FP,0x628438,NextptrsP,Nextptrs,0xFFFFFF)
	f_SHRead(FP, _Add(CreateUnitQueueXPosArr,CreateUnitQueuePtr2), CPosX)
	f_SHRead(FP, _Add(CreateUnitQueueYPosArr,CreateUnitQueuePtr2), CPosY)
	f_SHRead(FP, _Add(CreateUnitQueueUIDArr,CreateUnitQueuePtr2), QueueUID)
	f_SHRead(FP, _Add(CreateUnitQueuePIDArr,CreateUnitQueuePtr2), QueuePID)
	f_SHRead(FP, _Add(CreateUnitQueueTypeArr,CreateUnitQueuePtr2), QueueType)
	f_SHRead(FP, _Add(CreateUnitQueueBakXPosArr,CreateUnitQueuePtr2), BKX)
	f_SHRead(FP, _Add(CreateUnitQueueBakYPosArr,CreateUnitQueuePtr2), BKY)
	CDoActions(FP, {
		TSetMemory(_Add(CreateUnitQueueXPosArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueueYPosArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueueUIDArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueuePIDArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueueTypeArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueueBakXPosArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueueBakYPosArr,CreateUnitQueuePtr2), SetTo, 0),

	})

	
	


	DoActionsX(FP,{AddV(CreateUnitQueuePtr2,1),SubV(CreateUnitQueueNum,1)})
	TriggerX(FP, {CV(CreateUnitQueuePtr2,QueueMaxSize,AtLeast)},{SetV(CreateUnitQueuePtr2,0)},{preserved})





	NIf(FP,{CV(QueueUID,0,AtLeast),CV(QueueUID,226,AtMost)})
	local CRLID = CreateVar(FP)

	
	DoActions(FP,{SetSwitch(RandSwitch1,Random),SetSwitch(RandSwitch2,Random)})
	
	local LocIndex = FuncAlloc
		for i = 0, 3 do
            if i == 0 then RS1 = Cleared RS2=Cleared end
            if i == 1 then RS1 = Set RS2=Cleared end
            if i == 2 then RS1 = Cleared RS2=Set end
            if i == 3 then RS1 = Set RS2=Set end
            TriggerX(FP,{Switch(RandSwitch1,RS1),Switch(RandSwitch2,RS2)},{SetCtrig1X("X",FuncAlloc,CAddr("Mask",1),nil,SetTo,16+i),SetCtrig1X("X",FuncAlloc+1,CAddr("Mask",1),nil,SetTo,16+i)},{preserved})
        end
	CDoActions(FP, {
		SetMemoryB(0x6644F8+4,SetTo,158),
		SetMemoryB(0x6644F8+6,SetTo,200),
		SetMemoryB(0x6C9858+158,SetTo,2),
		SetMemory(0x66EC48+(541*4), SetTo, 91),
		SetMemory(0x66EC48+(956*4), SetTo, 91),
		TSetMemory(_Add(QueueUID,EPDF(0x662860)) ,SetTo,1+65536),
	})
		TriggerX(FP,{CVar(FP,QueuePID[2],Exactly,0xFFFFFFFF)},{SetCVar(FP,QueuePID[2],SetTo,7)},{preserved})
		TriggerX(FP,{CV(QueueType,129),CV(QueueUID,68)},{SetMemoryX(0x664080 + (68*4),SetTo,4,4),SetMemoryB(0x663150 + (68),SetTo,12)},{preserved})
		CTrigger(FP,{TTCVar(FP,QueueType[2],NotSame,2)},{TCreateUnitWithProperties(1,QueueUID,1,QueuePID,{energy = 100})},1,LocIndex)
        CTrigger(FP,{CVar(FP,QueueType[2],Exactly,2)},{TCreateUnitWithProperties(1,QueueUID,1,QueuePID,{energy = 100, burrowed = true})},1,LocIndex+1)
		TriggerX(FP,{CV(QueueType,129),CV(QueueUID,68)},{SetMemoryX(0x664080 + (68*4),SetTo,0,4),SetMemoryB(0x663150 + (68),SetTo,4)},{preserved})
	DoActions(FP, {
		SetMemoryB(0x6644F8+4,SetTo,76),
		SetMemoryB(0x6644F8+6,SetTo,83),
		SetMemoryB(0x6C9858+158,SetTo,0),
		SetMemory(0x66EC48+(956*4), SetTo, 377),
		SetMemory(0x66EC48+(541*4), SetTo, 247),
	})
		FuncAlloc=FuncAlloc+2
		Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
		CMov(FP,QueueOX,CPosX)
		CMov(FP,QueueOY,CPosY)
		CMov(FP,RUID,QueueUID)
		CMov(FP,RPID,QueuePID)
		CMov(FP,RType,QueueType)
		CMov(FP,RPtr,Nextptrs)
		CMov(FP,RPtrP,NextptrsP)
		CMov(FP,RLocV,DefaultAttackLocV)
		CMov(FP, RBX, BKX)
		CMov(FP, RBY, BKY)
		

		CallTrigger(FP, Call_RepeatOption)
		if TestStart == 1 then
			local RKillScore = CreateVar(FP)
			local RKillScoreTotal = CreateVar(FP)
			local RKillScoreP = CreateVar(FP)
			RKillScoreMin = CreateVar(FP)
			CMov(FP,RKillScore,0)
			f_WreadX(FP, 0x663EB8, QueueUID, RKillScore)
			for j,k in pairs(KillPointArr) do
				TriggerX(FP, {CV(QueueUID,k[1])},AddV(RKillScore,k[2]), {preserved})
			end	
			CAdd(FP,RKillScoreTotal,RKillScore)
			CIf(FP,{CV(RKillScoreTotal,1000,AtLeast)})
			CMov(FP,RKillScoreP,_Div(RKillScoreTotal,_Mov(1000)))
			CMod(FP,RKillScoreTotal,1000)
			CAdd(FP,RKillScoreMin,_Mul(_Mul(RKillScoreP,_Mov(10)),ExRate))
			CIfEnd()


		end



	Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)




	



	NIfEnd()

	NWhileEnd()
	if TestStart == 1 then
		DisplayPrintEr(MapPlayers, {"RKillScoreMin : ",RKillScoreMin})
	end
	
	TriggerX(FP, {CV(count,QueueMaxUnit,AtMost),CV(CreateUnitQueueNum,0)}, {
		SetInvincibility(Disable, 131, FP, 64),
		SetInvincibility(Disable, 132, FP, 64),
		SetInvincibility(Disable, 133, FP, 64),
		SetInvincibility(Disable, 122, FP, 64),
		SetInvincibility(Disable, 113, FP, 64),
		SetInvincibility(Disable, 114, FP, 64),
		SetInvincibility(Disable, 160, FP, 64),
		SetInvincibility(Disable, 167, FP, 64),
		SetInvincibility(Disable, 154, FP, 64),
		SetInvincibility(Disable, 116, FP, 64),
	},{preserved})
	TriggerX(FP, {CV(count,QueueMaxUnit+1,AtLeast)}, {
		SetInvincibility(Enable, 131, FP, 64),
		SetInvincibility(Enable, 132, FP, 64),
		SetInvincibility(Enable, 133, FP, 64),
		SetInvincibility(Enable, 122, FP, 64),
		SetInvincibility(Enable, 113, FP, 64),
		SetInvincibility(Enable, 114, FP, 64),
		SetInvincibility(Enable, 160, FP, 64),
		SetInvincibility(Enable, 167, FP, 64),
		SetInvincibility(Enable, 154, FP, 64),
		SetInvincibility(Enable, 116, FP, 64),
	},{preserved})
	TriggerX(FP, {CV(CreateUnitQueueNum,1,AtLeast)}, {
		SetInvincibility(Enable, 131, FP, 64),
		SetInvincibility(Enable, 132, FP, 64),
		SetInvincibility(Enable, 133, FP, 64),
		SetInvincibility(Enable, 122, FP, 64),
		SetInvincibility(Enable, 113, FP, 64),
		SetInvincibility(Enable, 114, FP, 64),
		SetInvincibility(Enable, 160, FP, 64),
		SetInvincibility(Enable, 167, FP, 64),
		SetInvincibility(Enable, 154, FP, 64),
		SetInvincibility(Enable, 116, FP, 64),

	},{preserved})
FixText(FP, 1)
TriggerX(FP,{CV(CreateUnitQueuePenaltyLock,0),CV(CreateUnitQueueNum,0),},{SubV(CreateUnitQueuePenaltyT,2)},{preserved})
TriggerX(FP,{CV(CreateUnitQueuePenaltyLock,0),CV(CreateUnitQueueNum,1,AtLeast)},{AddV(CreateUnitQueuePenaltyT,10)},{preserved})
TriggerX(FP,{CV(CreateUnitQueuePenaltyLock,0),CV(CreateUnitQueueNum,500,AtLeast)},{AddV(CreateUnitQueuePenaltyT,10)},{preserved})
TriggerX(FP,{CV(CreateUnitQueuePenaltyLock,0),CV(CreateUnitQueueNum,1000,AtLeast)},{AddV(CreateUnitQueuePenaltyT,10)},{preserved})
TriggerX(FP,{CV(CreateUnitQueuePenaltyLock,0),CV(CreateUnitQueueNum,QueueMaxSize,AtLeast)},{RotatePlayer({Defeat()}, Force1, FP)},{preserved})

if DLC_Project == 1 then
--	CIf(FP,{CV(CreateUnitQueuePenaltyT,4800,AtLeast),CD(GMode,3)})
--	CFor(FP,0,1700,1)--

--	local NX,NY = CreateVars(2,FP)
--	f_Lengthdir(FP, _Mod(_Rand(), 32*10), _Mod(_Rand(), 360), NX,NY)
--	Simple_SetLocX(FP, 0, NX,NY,NX,NY,{Simple_CalcLoc(0, 1024,1088,1024,1088)})
--	DoActions(FP, {
--		MoveUnit(1, 25, Force2, 39, 1),
--		MoveUnit(1, 30, Force2, 39, 1),})
--	
--	CMov(FP,NX,f_CRandNum(2048-64, 32))
--	CMov(FP,NY,f_CRandNum(2048-64, 32))
--	Simple_SetLocX(FP, 0, NX,NY,NX,NY)
--	DoActions(FP, {MoveUnit(1, "Men", Force2, 39, 1)})
--	CForEnd()
--	DoActions2(FP,{Simple_SetLoc(0, 0, 0, 2048, 2048),Order("Men", Force2, 1, Attack, 6)})
--	CIfEnd()
end
Trigger2X(FP,{CV(CreateUnitQueuePenaltyT,4800,AtLeast)},{RotatePlayer({
	PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
	PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
	PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
	PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV"),
	PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV"),
	},HumanPlayers,FP),SetV(CreateUnitQueuePenaltyT,0),AddV(CreateUnitQueuePenaltyAct,1),},{preserved})


DisplayPrint(HumanPlayers,{"\x07『 \x04CreateUnit\x07Queue \x04: ",CreateUnitQueueNum," || \x08P\x04enalty \x08T\x04imer : \x08",CreateUnitQueuePenaltyT," \x04/ \x034800 \x07』"})
TriggerX(FP,{LocalPlayerID(128);Memory(0x68C144,AtLeast,1);},{SetMemory(0x68C144,SetTo,2);SetCp(128),DisplayText("\x07『 \x03관전 상태\x04에서도 \x11플레이어\x04에게 \x07채팅을 보낼 수 있습니다. \x07』", 4),SetCp(FP)},{preserved})
TriggerX(FP,{LocalPlayerID(129);Memory(0x68C144,AtLeast,1);},{SetMemory(0x68C144,SetTo,2);SetCp(129),DisplayText("\x07『 \x03관전 상태\x04에서도 \x11플레이어\x04에게 \x07채팅을 보낼 수 있습니다. \x07』", 4),SetCp(FP)},{preserved})
TriggerX(FP,{LocalPlayerID(130);Memory(0x68C144,AtLeast,1);},{SetMemory(0x68C144,SetTo,2);SetCp(130),DisplayText("\x07『 \x03관전 상태\x04에서도 \x11플레이어\x04에게 \x07채팅을 보낼 수 있습니다. \x07』", 4),SetCp(FP)},{preserved})
TriggerX(FP,{LocalPlayerID(131);Memory(0x68C144,AtLeast,1);},{SetMemory(0x68C144,SetTo,2);SetCp(131),DisplayText("\x07『 \x03관전 상태\x04에서도 \x11플레이어\x04에게 \x07채팅을 보낼 수 있습니다. \x07』", 4),SetCp(FP)},{preserved})
if DLC_Project == 1 then
CIf(FP,{LocalPlayerID(0, AtLeast),LocalPlayerID(4, AtMost)})
for i = 0, 4 do

	CIf(FP,{LocalPlayerID(i),CV(RebirthUp[i+1],1,AtLeast)})
		local SS = CreateVar(FP)
		local RS = CreateVar(FP)
		CIfX(FP,{CV(RebirthUp[i+1],3)})
		f_Div(FP, SS, SMRebirthT[i+1], 1000*2)
		f_Div(FP, RS, RMRebirthT[i+1], 1000*2)
		CElseX()
		f_Div(FP, SS, SMRebirthT[i+1], 1000)
		f_Div(FP, RS, RMRebirthT[i+1], 1000)
		CIfXEnd()
		DisplayPrint(i, {"\x07『 \x19부활 \x1F남은 시간 \x04: \x18",SS," \x1F초\x04, \x19",RS, " \x1F초\x07 』"})
	CIfEnd()

end


CIfEnd()
end

FixText(FP, 2)
end



WepDupCheck = {}
KillPointArr = {}
ParseUnitNameT = {}
function SetUnitAbility(UnitID,WepID,DmgType,HP,Shield,Cooldown,Damage,Splash,ObjNum,RangeMax,SeekRange,Point,Text,KillPoint)--QueueScript{FlingyID,SpriteID,ImageID,Color(Option)}
	local TempWID = WepID
	local TempWID2 = 130
	local LClass = 1350--~1355
	ParseUnitNameT[Text] = UnitID
	if Shield == nil then Shield = false end

	if WepID~=70 then -- 70번 제로무기 겹쳐도됨
		if WepDupCheck[WepID] == nil then
			WepDupCheck[WepID] = true
		else PushErrorMsg("WepID Duplicated")
		end
	end
	
	local ColorCode = 0
	--DmgType 1 폭발 2 진동 3 일반 4 방무 5 위험타입 = 일반형
	--1394,1395,1396,1397
	if DmgType == 1 then
		ColorCode = 0x11
		LClass = 94
	elseif DmgType == 2 then
		ColorCode = 0x1D
		LClass = 94
	elseif DmgType == 3 then
		ColorCode = 0x1B
		LClass = 94
	elseif DmgType == 4 then
		ColorCode = 0x1F
		LClass = 94
	elseif DmgType == 5 then
		ColorCode = 0x08
		LClass = 95
	else PushErrorMsg("Unit DamageType Error")
	end
	local StrArr = {}
	local StrArr2 = {}
	
	for i in string.gmatch(Text, "%S+") do
		table.insert(StrArr, i)
	end
	for j,k in pairs(StrArr) do
		table.insert(StrArr2, S_to_EmS(string.char(ColorCode)..string.sub(k, 1, 1)..string.char(0x04)..string.sub(k, 2, #k)).." ")
	end
	local StrRet = ""
	for j,k in pairs(StrArr2) do
		StrRet = StrRet..k
	end

	if UnitPointArr == nil then UnitPointArr = {} end
	if UnitPointArr2 == nil then UnitPointArr2 = {} end
	--if QueueScriptArr == nil then QueueScriptArr = {} end
	--if QueueScriptArr2 == nil then QueueScriptArr2 = {} end
	if Point~=nil then
		table.insert(UnitPointArr, {UnitID,Point,StrRet})
	end
	--if QueueScript ~= nil then
	--	if type(QueueScript)~="table" then PushErrorMsg("QueueScript InputData Error")end
	--	table.insert(QueueScriptArr, {UnitID,table.unpack(QueueScript)})
	--	
	--end
	table.insert(UnitPointArr2, UnitID)

	if UnitID == 62 then TempWID2 = WepID end
	if UnitID == 98 then TempWID2 = WepID end
	if UnitID == 86 then TempWID2 = WepID end
	if UnitID == 124 then TempWID2 = WepID end
	if 
	UnitID == 3 or 
	UnitID == 5 or 
	UnitID == 17 or 
	UnitID == 23 or 
	UnitID == 25 or 
	UnitID == 30 then TempWID = 130 
	--if QueueScript~=nil then
	--	if QueueScript2 ~= nil then--텡크류 유닛
	--			
	--		if type(QueueScript2)~="table" then PushErrorMsg("QueueScript InputData Error")end
	--		table.insert(QueueScriptArr2, {UnitID+1,table.unpack(QueueScript2)})
	--		
	--	end
	--end
	SetUnitsDatX(UnitID+1, {GroundWeapon=WepID,AirWeapon=TempWID2})
	end
	local Size = 6
	
	if KillPoint>= 65536 then
		table.insert(KillPointArr,{UnitID,KillPoint,StrRet})
		KillPoint = 0
	end
	SetUnitsDatX(UnitID, {Class=LClass,GroupFlag=0xA,SuppCost=0,AdvFlag={0x40,0x40+0x8000},StarEditFlag=0x1C7,ComputerAI=3,HP=HP,Shield=Shield,GroundWeapon=TempWID,AirWeapon=TempWID2,SeekRange = SeekRange,KillScore=KillPoint,SizeL=Size,SizeU=Size,SizeR=Size,SizeD=Size
})
if ObjNum == nil then ObjNum = 1 end
if DmgType == 5 then DmgType = 3 end
SetWeaponsDatX(WepID,{DamageType = DmgType, Cooldown = Cooldown,DmgBase=Damage,RangeMax=RangeMax,ObjectNum=ObjNum,Splash=Splash,DmgFactor=Damage/10,UpgradeType=59})


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
			PushErrorMsg("Prohibited_Label")
		end
	end
	for k, v in pairs(LabelUseArr) do
		if k~=nil and C[k]== nil then
			_G["Undefined Label! Current Label : 0x"..string.format("%X",k)]() -- push error msg
		end
		
	end
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
			if type(v[2]) == "table" then
				local WAVs = CreateCcodeArr(12)
					for j, k in pairs(TargetPlayer) do
						local Pl = k
						if Pl == P9 then Pl = 128
						elseif Pl == P10 then Pl = 129
						elseif Pl == P11 then Pl = 130
						elseif Pl == P12 then Pl = 131 end
						
					for o,p in pairs(v[2]) do
							Trigger {players = {PlayerID},
								conditions = {
									Label(0);
									CD(WAVs[j],o-1);
									Cond2;
									LocalPlayerID(Pl);
									DeathsX(k,Exactly,0*16777216,12,0xFF000000);
								},
								actions = {
									AddCD(WAVs[j], 1);
									Act1;
									SetCp(Pl);
									PlayWAV(p);
									PlayWAV(p);
									SetCp(PlayerID);
									SetNVar(Arr[3],Add,v[3]);
								},
								flag = {preserved}
							}
						end
						TriggerX(PlayerID, {CD(WAVs[j],#v[2],AtLeast)}, {SetCD(WAVs[j], 0);},{preserved})
					end

			else
				for j, k in pairs(TargetPlayer) do
					local Pl = k
					if Pl == P9 then Pl = 128
					elseif Pl == P10 then Pl = 129
					elseif Pl == P11 then Pl = 130
					elseif Pl == P12 then Pl = 131 end
					
					Trigger {players = {PlayerID},
						conditions = {
							Label(0);
							Cond2;
							LocalPlayerID(Pl);
							DeathsX(k,Exactly,0*16777216,12,0xFF000000);
						},
						actions = {
							Act1;
							SetCp(Pl);
							PlayWAV(v[2]);
							PlayWAV(v[2]);
							SetCp(PlayerID);
							SetNVar(Arr[3],Add,v[3]);
						},
						flag = {preserved}
					}
				end
			end
		end
	DoActionsX(FP, Act1)
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
	return Arr[2]
end

function UnitButton(Player,UnitID,Condition,Actions)
	Trigger { 
		players = {FP},
		conditions = {
			Label(0);
			Command(Player,AtLeast,1,UnitID);
			Condition
		},
		actions = {
			ModifyUnitEnergy(All,UnitID,Player,64,0);
			GiveUnits(All,UnitID,Player,"Anywhere",11);
			RemoveUnitAt(All,UnitID,"Anywhere",11);
			Actions;
			PreserveTrigger();
			},
	}
end



function S_to_EmS(Str)
	local X={}
	for i = 1, #Str do
		local Check = string.byte(string.sub(Str,i,i),1)
		if Check<=0x20 or Check==string.byte(" ",1) then
			table.insert(X,string.sub(Str,i,i))
		else	
			if Check>=97 and Check<=97+26 then
				table.insert(X,string.char(239,189,32+string.byte(string.sub(Str,i,i),1)))
			else
				table.insert(X,string.char(239,188,96+string.byte(string.sub(Str,i,i),1)))
			end
		end
		--239,188,96+n
	end
	return table.concat(X),X
end
function N_to_EmN(Num)
	if type(Num) ~= "string" then Num = tostring(Num) end
	T,X = S_to_EmS(Num)
	local LoopCount = 0
	for i = #X, 1, -1 do
		LoopCount = LoopCount+1
		if LoopCount>=3 and i~=1 then
			LoopCount = LoopCount - 3
			table.insert(X,i,",")
		end
	end
	return table.concat(X)
end

function Conv_HStr(Str)
	return S_to_EmS(Convert_StrCode(Str))
end


function Convert_StrCode(Str)
	for i = 1, #Str do
		if string.sub(Str,i,i) == "<" then
			for j= i, #Str do
				if string.sub(Str,j,j) == ">" then
					local Str1 = string.sub(Str,1,i-1)
					local Str2 = string.sub(Str,j+1,#Str)
					local Code = string.sub(Str,i+1,j-1)
					Str = Str1..string.char(tonumber(Code,16))..Str2
				break end
				if j == #Str then PushErrorMsg("StrCode_EndPos_NotFound") end
			end
		end
	end
	return Str
end

function Getdebugmsg(infonum)
	local file1 = debug.getinfo(infonum).source
	local DebugMsg = string.sub(file1, #file1-13, #file1)..":"..debug.getinfo(infonum).currentline.." in global "..debug.getinfo(infonum).name
	return DebugMsg
end


function TimerToggle(Time)--Time 초 마다 0, 1 왔다갔다하는거
	local TCC = CreateCcode()
	local TCC2 = CreateCcode()
	DoActionsX(FP, {AddCD(TCC,1)})
	TriggerX(FP, {CD(TCC,Time,AtLeast),CD(TCC2,0)}, {SetCD(TCC,0),SetCD(TCC2,1)},{preserved})
	TriggerX(FP, {CD(TCC,Time,AtLeast),CD(TCC2,1)}, {SetCD(TCC,0),SetCD(TCC2,0)},{preserved})
	return TCC2
	
end