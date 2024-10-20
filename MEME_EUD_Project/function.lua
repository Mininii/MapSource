
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

PatchArr = {}
PatchArr2 = {}
PatchArrPrsv = {}

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

function Include_G_CB_Library(DefaultAttackLoc,StartIndex,Size_of_G_CB_Arr)
	
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
	if DefaultAttackLoc == nil then
		PushErrorMsg("G_CB_DefaultXY_InputData_Error")
	end
f_RepeatTypeErr = "\x07『 \x08ERROR : \x04잘못된 RepeatType이 입력되었습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
f_RepeatErr = "\x07『 \x08ERROR : \x04f_Repeat에서 문제가 발생했습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
f_RepeatErr2 = "\x07『 \x08ERROR : \x04Set_Repeat에서 잘못된 UnitID(0)을 입력받았습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
f_GunSendErrT = "\x07『 \x08ERROR \x04: G_CB_SpawnSet 목록이 가득 차 데이터를 입력하지 못했습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
G_CB_PosErr = "\x07『 \x03CAUCTION : \x04생성 좌표가 맵 밖을 벗어났습니다.\x07 』"
f_GunFuncT = "\x07『 \x03TESTMODE OP \x04: G_CBPlot Suspended. \x07』"
f_GunFuncT2 = "\x07『 \x03TESTMODE OP \x04: G_CBPlot All Suspended. \x07』"
f_GunSpawnSet = "\x07『 \x03TESTMODE OP \x04: G_CBPlot SpawnSet Initiation. \x07』"
f_GunErrT = "\x07『 \x08ERROR \x04: G_CBPlot Not Found. \x07』"
local Gun_TempSpawnSet1 = CreateVar(FP)
local Spawn_TempW = CreateVar(FP)
local RepeatType = CreateVar(FP)
local Repeat_EffID = CreateVar(FP)
local Repeat_OrderX = CreateVar(FP)
local Repeat_OrderY = CreateVar(FP)
local Repeat_OrderType = CreateVar(FP)


G_CB_Nextptrs = CreateVar(FP)
G_CB_NextptrsP = CreateVar(FP)
local Repeat_TempV = CreateVar(FP)
local CreatePlayer = CreateVar(FP)
local CA_Repeat_Check = CreateCcode()
local TRepeatX,TRepeatY = CreateVars(2,FP)
local NQOption = CreateVar(FP)
CA_Repeat_X = CreateVar(FP)
CA_Repeat_Y = CreateVar(FP)
G_CB_BackupX = CreateVar(FP)
G_CB_BackupY = CreateVar(FP)
G_CB_X = CreateVar(FP)
G_CB_Y = CreateVar(FP)
G_CB_XDis = CreateVar(FP)
G_CB_YDis = CreateVar(FP)
G_CB_Eff = CreateVar(FP)
G_CB_ColorMem = CreateVar(FP)
G_CB_Color = CreateVar(FP)
G_CB_ColorMask = CreateVar(FP)

G_CB_Shapes = {}
G_CB_ShapeIndexAlloc = 1
G_CB_RotateV = CreateVar(FP)
Call_RepeatOption = SetCallForward()
SetCall(FP)
RBX = CreateVar(FP)
RBY = CreateVar(FP)
RUID = CreateVar(FP)
RPID = CreateVar(FP)
RType = CreateVar(FP)
RPtr = CreateVar(FP)
RPtrP = CreateVar(FP)
RLocV = CreateVar(FP)
QueueOX = CreateVar(FP)
QueueOY = CreateVar(FP)
CIf(FP,{TMemoryX(_Add(RPtr,40),AtLeast,150*16777216,0xFF000000)})
		
		--CIf(FP,{TTOR({CV(RUID,25),CV(RUID,30)})})
		--CDoActions(FP,{
		--	TSetDeathsX(_Add(RPtr,72),SetTo,0xFF*256,0,0xFF00),TSetMemoryX(_Add(RPtr,68), SetTo, 600,0xFFFF)})
		--CIfEnd()
		--local CunitIndex2 = CreateVar(FP)
		--CMov(FP,CunitIndex,_Div(_Sub(RPtr,19025),_Mov(84)))
		--f_Mul(FP,CunitIndex2, CunitIndex, 0x970/4)
		--CDoActions(FP, {
		--	TSetMemoryX(_Add(RPtr,9),SetTo,0,0xFF0000),
		--	TSetMemory(_Add(CunitIndex2,_Add(UnivCunit[3],((0x20*4)/4))),SetTo, 0),
		--	TSetMemory(_Add(CunitIndex2,_Add(UnivCunit[3],((0x20*5)/4))),SetTo, 0),
		--	TSetMemory(_Add(CunitIndex2,_Add(UnivCunit[3],((0x20*2)/4))),SetTo, 0),
		--	TSetMemory(_Add(CunitIndex2,_Add(UnivCunit[3],((0x20*8)/4))),SetTo, 0),
		--	TSetMemory(_Add(CunitIndex2,_Add(UnivCunit[3],((0x20*9)/4))),SetTo, 0),
		--	TSetMemory(_Add(CunitIndex2,_Add(UnivCunit[3],((0x20*10)/4))),SetTo, 0),
		--})



		f_Read(FP,_Add(RPtr,10),CPos)
		Convert_CPosXY()
		RTypeDupeCheck = {}
		RTypeKey = {}
		function CElseIfX_AddRepeatType(TypeNum,TypeString)
			if RTypeDupeCheck[TypeNum] == nil then 
				if TypeString ~=nil then
					RTypeDupeCheck[TypeNum] = TypeString
					RTypeKey[TypeString] = TypeNum
				else
					RTypeDupeCheck[TypeNum] = true
				end
			 else PushErrorMsg("RepeatTypeNum_Duplicated") end
			 CElseIfX({CVar(FP,RType[2],Exactly,TypeNum)})
		end
		
		function CElseIfX_AddRepeatType_LR(TypeNumL,TypeNumR,TypeString)
			
			for i = TypeNumL,TypeNumR,1 do
				if RTypeDupeCheck[i] == nil then 
					if TypeString ~=nil then
						RTypeDupeCheck[i] = TypeString[i-TypeNumL+1]
						RTypeKey[TypeString] = i
					else
						RTypeDupeCheck[i] = true
					end
				 else PushErrorMsg("RepeatTypeNum_Duplicated") end
				
			end
			CElseIfX({CVar(FP,RType[2],AtLeast,TypeNumL),CVar(FP,RType[2],AtMost,TypeNumR)})
		end

		CIf(FP,{CV(RUID,82)}) -- 캐리어 인터셉터 1기만 충전
		f_Read(FP,_Add(RPtr,10),CPos)
		Convert_CPosXY()
		Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
		CDoActions(FP,{TModifyUnitHangarCount(1, 1, 82, RPID, 1)})
		CIfEnd()
			CIfX(FP,CVar(FP,RType[2],Exactly,0))
				f_Read(FP,_Add(RPtr,10),CPos)
				Convert_CPosXY()
				Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
				CTrigger(FP, {CV(Repeat_OrderType,0)}, {TOrder(RUID, RPID, 1, Attack, RLocV);}, {preserved})
				CDoActions(FP,{TSetMemoryX(_Add(RPtr,8),SetTo,127*65536,0xFF0000),})
                
			CElseIfX(CVar(FP,RType[2],Exactly,2))
			CElseIfX_AddRepeatType(3,"KillUnit")
			CDoActions(FP,{TKillUnit(RUID, RPID)})
			CElseIfX_AddRepeatType(5,"RemoveTimer")
			CDoActions(FP,{TSetMemoryX(_Add(RPtr,68),SetTo,250,0xFFFF)})
			CElseIfX_AddRepeatType(6,"Nothing")
			CElseIfX_AddRepeatType(7,"Patrol_Center")
			f_Read(FP,_Add(RPtr,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			Simple_SetLocX(FP,130,G_CB_BackupX,G_CB_BackupY,G_CB_BackupX,G_CB_BackupY,{Simple_CalcLoc(130,-4,-4,4,4)})
			CTrigger(FP, {CV(Repeat_OrderType,0)}, {TOrder(RUID, RPID, 1, Attack, 131);}, {preserved})
			CDoActions(FP,{TSetMemoryX(_Add(RPtr,8),SetTo,127*65536,0xFF0000),})
			CElseX()
				DoActions(FP,RotatePlayer({DisplayTextX("\x07『 \x08ERROR : \x04잘못된 RepeatType이 입력되었습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』",4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP))
			CIfXEnd()

			CIf(FP,{CV(Repeat_OrderType,1,AtLeast)})
			f_Read(FP,_Add(RPtr,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			Simple_SetLocX(FP,130,Repeat_OrderX,Repeat_OrderY,Repeat_OrderX,Repeat_OrderY,{Simple_CalcLoc(130,-4,-4,4,4)})
			CTrigger(FP, {CV(Repeat_OrderType,1)}, {TOrder(RUID,RPID,1,Attack,131)}, {preserved})
			CTrigger(FP, {CV(Repeat_OrderType,2)}, {TOrder(RUID,RPID,1,Patrol,131)}, {preserved})
			CTrigger(FP, {CV(Repeat_OrderType,3)}, {TOrder(RUID,RPID,1,Move,131)}, {preserved})

			CIfEnd()
			


			--Simple_SetLocX(FP,0,G_CB_BackupX,G_CB_BackupY,G_CB_BackupX,G_CB_BackupY,{Simple_CalcLoc(0,-4,-4,4,4)})
			--CDoActions(FP,{TOrder(RUID,RPID,72,Attack,1)})
			
		CIfEnd()
SetCallEnd()



Call_Repeat = SetCallForward()
SetCall(FP)
DefaultAttackLocV = CreateVar(FP)
CWhile(FP,{CVar(FP,Spawn_TempW[2],AtLeast,1)})
	CMov(FP,DefaultAttackLocV,DefaultAttackLoc)
		QueueX = CreateVar(FP)
		QueueY = CreateVar(FP)
		CIf(FP,{CDeaths(FP,Exactly,0,CA_Repeat_Check)})


		CIfX(FP,{CVar(FP,TRepeatX[2],AtMost,0x7FFFFFFF-5)})

			Simple_SetLocX(FP,0,TRepeatX,TRepeatY,TRepeatX,TRepeatY)
			CMov(FP,QueueX,TRepeatX)
			CMov(FP,QueueY,TRepeatY)

		CElseIfX(CVar(FP,TRepeatX[2],AtLeast,0x80000000-5))
		Simple_SetLocX(FP,0,G_CB_X,G_CB_Y,G_CB_X,G_CB_Y)
		CMov(FP,QueueX,G_CB_X)
		CMov(FP,QueueY,G_CB_Y)
		CElseIfX(CVar(FP,TRepeatY[2],Exactly,0x32223222))
		TGetLocCenter(TRepeatX, G_CB_X, G_CB_Y)
		Simple_SetLocX(FP,0,G_CB_X,G_CB_Y,G_CB_X,G_CB_Y)

		CIfXEnd()

		
		CIfEnd()


		CIf(FP,{CD(CA_Repeat_Check,1)})
		f_SHRead(FP, 0x58DC60, QueueX)
		f_SHRead(FP, 0x58DC64, QueueY)
		CMov(FP, CA_Repeat_X,QueueX)
		CMov(FP, CA_Repeat_Y,QueueY)
		CIfEnd()

		
		NIf(FP,{CV(Gun_TempSpawnSet1,0,AtLeast),CV(Gun_TempSpawnSet1,226,AtMost)})
		local CRLID = CreateVar(FP)

		
		NIfX(FP, {CV(Gun_TempSpawnSet1,33)})
		SendEff = CreateVarArr(4, FP)
		CIf(FP,{CV(SendEff[2],0x7FFFFFFF,AtMost)})
		f_Read(FP,SendEff[1],SendEff[4])
		CDoActions(FP,{
			TSetMemoryX(SendEff[1],SetTo,SendEff[2],SendEff[3]); --컬러
		})
		CIfEnd()
		CTrigger(FP,{},{TSetMemoryX(0x666458, SetTo, Repeat_EffID,0xFFFF),TCreateUnitWithProperties(1,Gun_TempSpawnSet1,1,CreatePlayer,{energy = 100}),TKillUnit(Gun_TempSpawnSet1, CreatePlayer),SetMemoryX(0x666458, SetTo, 546,0xFFFF)},1)
		
		CIf(FP,{CV(SendEff[2],0x7FFFFFFF,AtMost)})
		CDoActions(FP,{
			TSetMemoryX(SendEff[1],SetTo,SendEff[4],SendEff[3]); --컬러 복구
		})
		CIfEnd()
		CIf(FP,CV(RepeatType,44))-- 44번 RepeatType 특수패턴
			Simple_CalcLocX(FP, 0, -192, -192, 192, 192)
			DoActions(FP, {SetInvincibility(Enable, "Men", Force1, 1)})
			Simple_CalcLocX(FP, 0, 192, 192, -192, -192)
		CIfEnd()
		NElseX()
		NIf(FP,{Memory(0x628438,AtLeast,1)})


		
		DoActions(FP, {SetMemory(0x66EC48+(239*4), SetTo, 6)})
		f_Read(FP,0x628438,G_CB_NextptrsP,G_CB_Nextptrs,0xFFFFFF)
		TriggerX(FP,{CVar(FP,CreatePlayer[2],Exactly,0xFFFFFFFF)},{SetCVar(FP,CreatePlayer[2],SetTo,7)},{preserved})
		CTrigger(FP,{TTCVar(FP,RepeatType[2],NotSame,2)},{TCreateUnitWithProperties(1,Gun_TempSpawnSet1,1,CreatePlayer,{energy = 100})},1)
		CTrigger(FP,{CVar(FP,RepeatType[2],Exactly,2)},{TCreateUnitWithProperties(1,Gun_TempSpawnSet1,1,CreatePlayer,{energy = 100, burrowed = true})},1)
		DoActions(FP, {SetMemory(0x66EC48+(239*4), SetTo, 78)})
		FuncAlloc=FuncAlloc+2
		Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
		CMov(FP,QueueOX,CPosX)
		CMov(FP,QueueOY,CPosY)
		CMov(FP,RUID,Gun_TempSpawnSet1)
		CMov(FP,RPID,CreatePlayer)
		CMov(FP,RType,RepeatType)
		CMov(FP,RPtr,G_CB_Nextptrs)
		CMov(FP,RPtrP,G_CB_NextptrsP)
		CMov(FP,RLocV,DefaultAttackLocV)
		CallTrigger(FP, Call_RepeatOption)
		NIfEnd()
		NIfXEnd()



		NIfEnd()


		
		CIf(FP,{CDeaths(FP,Exactly,0,CA_Repeat_Check)})
			CIfX(FP,{CVar(FP,TRepeatX[2],AtMost,0x7FFFFFFF-5)})
				Simple_SetLocX(FP,0,TRepeatX,TRepeatY,TRepeatX,TRepeatY)
			CElseIfX(CVar(FP,TRepeatX[2],AtLeast,0x80000000-5))
				Simple_SetLocX(FP,0,G_CB_X,G_CB_Y,G_CB_X,G_CB_Y)
			CElseIfX(CVar(FP,TRepeatY[2],Exactly,0x32223222))
				TGetLocCenter(TRepeatX, G_CB_X, G_CB_Y)
				Simple_SetLocX(FP,0,G_CB_X,G_CB_Y,G_CB_X,G_CB_Y)
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
function f_TempRepeat(Condition,UnitID,Number,Type,Owner,CenterXY,Flags,NQOp)
	
	if type(UnitID) == "string" then
		UnitID = ParseUnit(UnitID)
	end

	if Owner == nil then Owner = 0xFFFFFFFF end
	if NQOp == nil then NQOp = 0 end
	if Type == nil then Type = 0 
	elseif type(Type) == "string" then
		Type = RTypeKey[Type]
	end
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
	elseif type(CenterXY) == "number" or  type(CenterXY) == "string" then -- Location Mode
		local Temp,EditorLocNum = ConvertLocation(CenterXY)
		SetX = Temp+1 -- LocationID
		SetY = 0x32223222 -- LocationMode Flag
	
	else
		PushErrorMsg("TRepeat_CenterXY_Error")
	end
	CallTriggerX(FP,Set_Repeat,Condition,{
		SetCDeaths(FP,SetTo,0,CA_Repeat_Check),
		SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,UnitID),
		SetCVar(FP,Repeat_TempV[2],SetTo,Number),
		SetCVar(FP,RepeatType[2],SetTo,Type),
		SetCVar(FP,CreatePlayer[2],SetTo,Owner),
		SetCVar(FP,TRepeatX[2],SetTo,SetX),
		SetCVar(FP,TRepeatY[2],SetTo,SetY),
		SetCVar(FP,NQOption[2],SetTo,NQOp),
	},Flags)

end

function f_TempRepeatX(Condition,UnitID,Number,Type,Owner,CenterXY,Flags,NQOp)
	if Owner == nil then Owner = 0xFFFFFFFF end
	if NQOp == nil then NQOp = 0 end
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
	elseif type(CenterXY) == "number" or  type(CenterXY) == "string" then -- Location Mode
		local Temp,EditorLocNum = ConvertLocation(CenterXY)
		SetX = Temp+2 -- LocationID
		SetY = 0x32223222 -- LocationMode Flag
	

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
		SetCVar(FP,CreatePlayer[2],SetTo,Owner),
		SetCVar(FP,NQOption[2],SetTo,NQOp),})
	CallTriggerX(FP,Set_Repeat,Condition,nil,Flags)
end
Set_Repeat = SetCallForward()
SetCall(FP)
--TriggerX(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,0)},{RotatePlayer({DisplayTextX(f_RepeatErr2,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP),SetCVar(FP,Repeat_TempV[2],SetTo,0)},{preserved})
TriggerX(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,256)},{SetCVar(FP,Repeat_TempV[2],SetTo,0)},{preserved})
CIf(FP,CVar(FP,Repeat_TempV[2],AtLeast,1))
	CMov(FP,Spawn_TempW,Repeat_TempV)
	CMov(FP,Repeat_TempV,0)
	CallTrigger(FP,Call_Repeat)
	CMov(FP,Spawn_TempW,0)
CIfEnd()
SetCallEnd()

local G_CB_LineV = CreateVar(FP)
local G_CB_CUTV = CreateVar(FP)
local G_CB_SNTV = CreateVarArr(4,FP)
local G_CB_DLTV = CreateVarArr(4,FP)
local G_CB_FNTV = CreateVar(FP)
local G_CB_LMTV = CreateVar(FP)
local G_CB_RPTV = CreateVar(FP)
local G_CB_CPTV = CreateVar(FP)
local G_CB_SZTV = CreateVar(FP)
local G_CB_RTTV = CreateVarArr(4,FP)
local G_CB_XPos = CreateVar(FP)
local G_CB_YPos = CreateVar(FP)
local G_CB_OrderXPos = CreateVar(FP)
local G_CB_OrderYPos = CreateVar(FP)
local G_CB_OrderAct = CreateVar(FP)
local G_CB_NQOption =CreateVar(FP)
local SL_TempV = Create_VTable(4)
local SL_Ret = CreateVar(FP)
local Write_SpawnSet_Jump = def_sIndex()
local G_CB_Arr_IndexAlloc = StartIndex
local G_CB_InputCVar = {}
local G_CB_Lines = 55
local G_CB_TempTable = CreateVarArr(G_CB_Lines,FP)
local G_CB_TempH = CreateVar(FP)
local G_CB_Num = CreateVar(FP)
for i = 1, G_CB_Lines do
	table.insert(G_CB_InputCVar,SetCVar(FP,G_CB_TempTable[i][2],SetTo,0))
end
local G_CB_InputH = CreateVar(FP)
local G_CB_LineTemp = CreateVar(FP)


table.insert(CtrigInitArr[FP+1],SetCtrigX(FP,G_CB_InputH[2],0x15C,0,SetTo,FP,StartIndex,0x15C,1,0))

Write_SpawnSet = SetCallForward()
SetCall(FP)
UnitIDV1,UnitIDV2,UnitIDV3,UnitIDV4 = CreateVars(4,FP)
local PatchCondArr = {UnitIDV1,UnitIDV2,UnitIDV3,UnitIDV4}
for i = 221, 224 do
	CTrigger(FP,{CVar(FP,G_CB_CUTV[2],Exactly,i,0xFF)},{TSetCVar(FP,G_CB_CUTV[2],SetTo,PatchCondArr[i-220],0xFF)},1)
	CIf(FP,{CVar(FP,G_CB_CUTV[2],Exactly,i*0x100,0xFF00)})
		CTrigger(FP,{},{TSetCVar(FP,G_CB_CUTV[2],SetTo,_Mul(PatchCondArr[i-220],_Mov(0x100)),0xFF00)},1)
	CIfEnd()
	CIf(FP,{CVar(FP,G_CB_CUTV[2],Exactly,i*0x10000,0xFF0000)})
		CTrigger(FP,{},{TSetCVar(FP,G_CB_CUTV[2],SetTo,_Mul(PatchCondArr[i-220],_Mov(0x10000)),0xFF0000)},1)
	CIfEnd()
	CIf(FP,{CVar(FP,G_CB_CUTV[2],Exactly,i*0x1000000,0xFF000000)})
		CTrigger(FP,{},{TSetCVar(FP,G_CB_CUTV[2],SetTo,_Mul(PatchCondArr[i-220],_Mov(0x1000000)),0xFF000000)},1)
	CIfEnd()
end
if Limit == 1 then
TriggerX(FP,{CD(TestMode,1)},{RotatePlayer({DisplayTextX(f_GunSpawnSet,4)},HumanPlayers,FP)})
end
CMov(FP,G_CB_LineV,0)
CJumpEnd(FP,Write_SpawnSet_Jump)

CAdd(FP,G_CB_LineTemp,G_CB_LineV,G_CB_InputH)
NIfX(FP,{TMemory(G_CB_LineTemp,AtMost,0)})

--[[
	Line 0 = UnitID 1Byte
	Line 1 = PrefuncID 1Byte
	Line 2 = CBPlot Index 4Byte
	Line 3 = Current Delay Time 4Byte
	Line 4 = Loop Limit 1Byte
	Line 5 = RepeatType 1Byte
	Line 6 = ??? 
	Line 9 = CreatePlayer 1Byte
	Line 10 = ShapeSize 1Byte (100=100%)
	Line 11 = Use Queue Option 1Byte
	Line 12 SelectShapeNumber1 4Byte
	Line 13 SelectShapeNumber2 4Byte
	Line 14 SelectShapeNumber3 4Byte
	Line 15 SelectShapeNumber4 4Byte
	Line 16 Set Delay Timer 1 4Byte
	Line 17 Set Delay Timer 2 4Byte
	Line 18 Set Delay Timer 3 4Byte
	Line 19 Set Delay Timer 4 4Byte
]]


CDoActions(FP,{
	TSetMemory(_Add(G_CB_LineTemp,0*(0x20/4)),SetTo,G_CB_CUTV),
	TSetMemory(_Add(G_CB_LineTemp,1*(0x20/4)),SetTo,G_CB_FNTV),
	TSetMemory(_Add(G_CB_LineTemp,2*(0x20/4)),SetTo,0),
	TSetMemory(_Add(G_CB_LineTemp,3*(0x20/4)),SetTo,0),--현재딜레이
	TSetMemory(_Add(G_CB_LineTemp,4*(0x20/4)),SetTo,G_CB_LMTV),
	TSetMemory(_Add(G_CB_LineTemp,5*(0x20/4)),SetTo,G_CB_RPTV),
	TSetMemory(_Add(G_CB_LineTemp,6*(0x20/4)),SetTo,0),
	TSetMemory(_Add(G_CB_LineTemp,9*(0x20/4)),SetTo,G_CB_CPTV),
	TSetMemory(_Add(G_CB_LineTemp,10*(0x20/4)),SetTo,G_CB_SZTV),
	TSetMemory(_Add(G_CB_LineTemp,11*(0x20/4)),SetTo,G_CB_NQOption),
	TSetMemory(_Add(G_CB_LineTemp,12*(0x20/4)),SetTo,G_CB_SNTV[1]),
	TSetMemory(_Add(G_CB_LineTemp,13*(0x20/4)),SetTo,G_CB_SNTV[2]),
	TSetMemory(_Add(G_CB_LineTemp,14*(0x20/4)),SetTo,G_CB_SNTV[3]),
	TSetMemory(_Add(G_CB_LineTemp,15*(0x20/4)),SetTo,G_CB_SNTV[4]),
	TSetMemory(_Add(G_CB_LineTemp,16*(0x20/4)),SetTo,G_CB_DLTV[1]),
	TSetMemory(_Add(G_CB_LineTemp,17*(0x20/4)),SetTo,G_CB_DLTV[2]),
	TSetMemory(_Add(G_CB_LineTemp,18*(0x20/4)),SetTo,G_CB_DLTV[3]),
	TSetMemory(_Add(G_CB_LineTemp,19*(0x20/4)),SetTo,G_CB_DLTV[4]),
	TSetMemory(_Add(G_CB_LineTemp,20*(0x20/4)),SetTo,G_CB_RTTV[1]),
	TSetMemory(_Add(G_CB_LineTemp,21*(0x20/4)),SetTo,G_CB_RTTV[2]),
	TSetMemory(_Add(G_CB_LineTemp,22*(0x20/4)),SetTo,G_CB_RTTV[3]),
	TSetMemory(_Add(G_CB_LineTemp,23*(0x20/4)),SetTo,G_CB_RTTV[4]),
	TSetMemory(_Add(G_CB_LineTemp,24*(0x20/4)),SetTo,G_CB_XDis),
	TSetMemory(_Add(G_CB_LineTemp,25*(0x20/4)),SetTo,G_CB_YDis),
	TSetMemory(_Add(G_CB_LineTemp,26*(0x20/4)),SetTo,G_CB_Eff),
	TSetMemory(_Add(G_CB_LineTemp,27*(0x20/4)),SetTo,G_CB_ColorMem),
	TSetMemory(_Add(G_CB_LineTemp,28*(0x20/4)),SetTo,G_CB_Color),
	TSetMemory(_Add(G_CB_LineTemp,29*(0x20/4)),SetTo,G_CB_ColorMask),
	


	

})


CIf(FP,{CV(G_CB_OrderAct,1,AtLeast)})--OrderAct 인자가 있을 경우(RepeatType의 기본 오더를 모두 무시)

CDoActions(FP,{
	TSetMemory(_Add(G_CB_LineTemp,32*(0x20/4)),SetTo,G_CB_OrderAct),
})
CIfX(FP,{CVar(FP,G_CB_OrderXPos[2],AtMost,0x80000000-1),CVar(FP,G_CB_OrderYPos[2],AtMost,0x80000000-1)}) -- 좌표가 정해져 있을 경우
CDoActions(FP,{
	TSetMemory(_Add(G_CB_LineTemp,30*(0x20/4)),SetTo,G_CB_OrderXPos),
	TSetMemory(_Add(G_CB_LineTemp,31*(0x20/4)),SetTo,G_CB_OrderYPos)
})
CElseIfX({CVar(FP,G_CB_OrderXPos[2],AtLeast,0x80000000),CVar(FP,G_CB_OrderXPos[2],AtLeast,0x80000000)}) -- 로케이션 중심 모드

CSub(FP,G_CB_OrderXPos,0x80000001)
CSub(FP,G_CB_OrderYPos,0x80000001)
local G_CB_OrderXPosCalc = CreateVar(FP)
local G_CB_OrderYPosCalc = CreateVar(FP)
TGetLocCenter(G_CB_OrderXPos, G_CB_OrderXPosCalc, G_CB_OrderYPosCalc)
CDoActions(FP,{
	TSetMemory(_Add(G_CB_LineTemp,30*(0x20/4)),SetTo,G_CB_OrderXPosCalc),
	TSetMemory(_Add(G_CB_LineTemp,31*(0x20/4)),SetTo,G_CB_OrderYPosCalc)
})


CElseX() -- 아무것도 정해져있지 않을 경우 위 설정을 무시한다.
CDoActions(FP,{
	TSetMemory(_Add(G_CB_LineTemp,30*(0x20/4)),SetTo,0),
	TSetMemory(_Add(G_CB_LineTemp,31*(0x20/4)),SetTo,0),
	TSetMemory(_Add(G_CB_LineTemp,32*(0x20/4)),SetTo,0),
})
CIfXEnd()
CIfEnd()

CIfX(FP,{CVar(FP,G_CB_XPos[2],Exactly,0xFFFFFFFF),CVar(FP,G_CB_YPos[2],Exactly,0xFFFFFFFF)}) -- G_CB_X,Y에 저장된것 기준(미사용이나 내부코드로 보존)
CDoActions(FP,{
	TSetMemory(_Add(G_CB_LineTemp,7*(0x20/4)),SetTo,G_CB_X),
	TSetMemory(_Add(G_CB_LineTemp,8*(0x20/4)),SetTo,G_CB_Y)
})
CElseIfX({CVar(FP,G_CB_XPos[2],AtLeast,0x80000000),CVar(FP,G_CB_YPos[2],AtLeast,0x80000000)}) -- 로케이션 중심 모드
CSub(FP,G_CB_XPos,0x80000001)
CSub(FP,G_CB_YPos,0x80000001)
TGetLocCenter(G_CB_XPos, G_CB_X, G_CB_Y)
CDoActions(FP,{
	TSetMemory(_Add(G_CB_LineTemp,7*(0x20/4)),SetTo,G_CB_X),
	TSetMemory(_Add(G_CB_LineTemp,8*(0x20/4)),SetTo,G_CB_Y)
})
CElseX()--좌표 중심 모드
CDoActions(FP,{
	TSetMemory(_Add(G_CB_LineTemp,7*(0x20/4)),SetTo,G_CB_XPos),
	TSetMemory(_Add(G_CB_LineTemp,8*(0x20/4)),SetTo,G_CB_YPos)
})
CIfXEnd()

NElseIfX({CVar(FP,G_CB_LineV[2],AtMost,((0x970/4)*Size_of_G_CB_Arr-2))})
CAdd(FP,G_CB_LineV,0x970/4)
CJump(FP,Write_SpawnSet_Jump)
NElseX()

DoActions(FP,{RotatePlayer({DisplayTextX(f_GunSendErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})

NIfXEnd()
SetCallEnd()










local CA_TempUID = CreateVar(FP)
local CA_Suspend = CreateCcode()

Call_CA_Repeat = SetCallForward()
SetCall(FP)
TriggerX(FP,{CVar(FP,CA_TempUID[2],AtLeast,221)},{SetCVar(FP,CA_TempUID[2],SetTo,0)},{preserved})
DoActionsX(FP,{SetCDeaths(FP,SetTo,1,CA_Repeat_Check)})
CMov(FP,Gun_TempSpawnSet1,CA_TempUID)
CMov(FP,Repeat_TempV,1)
TriggerX(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,94),CVar(FP,Repeat_TempV[2],Exactly,4)},{SetCVar(FP,Repeat_TempV[2],SetTo,1)},{preserved}) -- 도형건작 옵저버 1개 제한

CMov(FP,RepeatType,G_CB_TempTable[6],nil,0xFF)
CMov(FP,CreatePlayer,G_CB_TempTable[10],nil,0xFF)
--NQOption
CallTrigger(FP,Set_Repeat)
SetCallEnd()

local G_CB_Launch = CreateCcode()

function CA_Func1()
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local SizeTemp = CreateVar(FP)
	CIf(FP,{TTCVar(FP,G_CB_TempTable[11][2],NotSame,100,0xFF)})
		CMov(FP, SizeTemp, G_CB_TempTable[11], nil, 0xFF, 1)
		CA_RatioXY(SizeTemp, 100, SizeTemp, 100)
	CIfEnd()

	CIf(FP,{CV(G_CB_TempTable[21],1,AtLeast)})
		CIfX(FP,{CV(G_CB_TempTable[21],0xFFFFFFFF)})
			CA_Rotate(G_CB_RotateV)
		CElseX()
			CA_Rotate(G_CB_TempTable[21])
		CIfXEnd()
	CIfEnd()
	local CX = CreateVar(FP)
	local CY = CreateVar(FP)
	CA_MoveXY(G_CB_TempTable[25], G_CB_TempTable[26])
	CAdd(FP,CX,V(CA[8]),G_CB_TempTable[8])
	CAdd(FP,CY,V(CA[9]),G_CB_TempTable[9])
    
	--CallTrigger(FP,Call_CA_Repeat,{SetCDeaths(FP,SetTo,1,G_CB_Launch)})
	CIfX(FP,{CVar(FP,CX[2],AtMost,32*128),CVar(FP,CY[2],AtMost,32*128)})
    Simple_SetLocX(FP,0,CX,CY,CX,CY)
	CallTrigger(FP,Call_CA_Repeat,{SetCDeaths(FP,SetTo,1,G_CB_Launch)})
	if Limit == 1 then
		CElseX({SetCDeaths(FP,SetTo,1,G_CB_Launch),})--RotatePlayer({DisplayTextX(G_CB_PosErr,4)},HumanPlayers,FP)
	else
		CElseX({SetCDeaths(FP,SetTo,1,G_CB_Launch)})--RotatePlayer({DisplayTextX(G_CB_PosErr,4)},HumanPlayers,FP)
	end
	CIfXEnd()


end

local Ret = CreateVar(FP)
local CalcX, CalcY = CreateVars(2, FP)
local CalcA = CreateVar(FP)
local FncRand = CreateVar(FP)
CFunc1 = InitCFunc(FP)
Para = CFunc(CFunc1)
CIfX(FP, {CV(FncRand,0)})
local NG = CreateVar(FP)
CiSub(FP,Ret,_Add(_iMul(Para[1],CalcX),_iMul(Para[2],CalcY)),100)
CIf(FP,{CV(NG,1),CV(Ret,0x80000000,AtLeast)})
CNeg(FP,Ret)
CIfEnd()

CElseIfX({CV(FncRand,1)})--SortR
CMov(FP,Ret,_Sqrt(_Add(_Square(Para[1]),_Square(Para[2]))))
CElseIfX({CV(FncRand,2)})--SortA
local RetAbs= CreateVar(FP)

CMov(FP,RetAbs,_Abs(_Atan2(Para[2],Para[1])))
CAdd(FP,Ret,RetAbs,CalcA)
CMod(FP,Ret,360)

CIfXEnd()
CFuncReturn({Ret})
CFuncEnd()

CFunc2 = InitCFunc(FP)
Para = CFunc(CFunc2)--
CMov(FP,Ret,_Sqrt(_Add(_Square(Para[1]),_Square(Para[2]))))
CFuncReturn({Ret})
CFuncEnd()

function G_CB_Prefunc()
	
function CB_initTCopy()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	local FXAddrT = {}
	local FYAddrT = {}
	CBPlotFXArr = f_GetVoidptr(PlayerID,#FX+1)
	CBPlotFYArr = f_GetVoidptr(PlayerID,#FY+1)
	CBPlotFYArr = f_GetVoidptr(PlayerID,#FY+1)
	CBPlotFNum = f_GetVoidptr(PlayerID,#Num+1)
	for i = 1, #FX do
		table.insert(CtrigInitArr[PlayerID+1],SetCtrigX(PlayerID,CBPlotFXArr[2],(i*4)+2416,0, SetTo, PlayerID, FX[i][2], 2416, 1, 0))
	end
	for i = 1, #FY do
		table.insert(CtrigInitArr[PlayerID+1],SetCtrigX(PlayerID,CBPlotFYArr[2],(i*4)+2416,0, SetTo, PlayerID, FY[i][2], 2416, 1, 0))
	end
	for i = 1, #Num do
		table.insert(CtrigInitArr[PlayerID+1],SetCtrig1X(PlayerID,CBPlotFNum[2],(i*4)+2416,0, SetTo, Num[i]))
	end
	CBPlotNumHeader = CreateVar(PlayerID)
	table.insert(CtrigInitArr[PlayerID+1],SetCtrigX(PlayerID,CBPlotNumHeader[2],0x15C,0, SetTo, PlayerID, CA[7], 0x15C, 1, 0))
end

function CB_TCopy(Shape,RetShape)
	FCBCOPYCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		PushErrorMsg("Need_Include_CBPaint")
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)
	local LShNextV = CreateVar(PlayerID)
	local LRShNextV2 = CreateVar(PlayerID)
	if type(Shape) == "number" then
		CMov(PlayerID,LShNextV,Shape*(0x970/4))
	else
	CMul(PlayerID,LShNextV,Shape,(0x970/4))
	end
	if type(RetShape) == "number" then
		CMov(PlayerID,LRShNextV2,RetShape*(0x970/4))
	else
	CMul(PlayerID,LRShNextV2,RetShape,(0x970/4))
	end
	f_SHRead(PlayerID,_Add(CBPlotNumHeader,LShNextV),CV[2])
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {preserved}
		}

	CMov(PlayerID,CV[5],_Read(FArr(CBPlotFXArr,Shape)))
	CMov(PlayerID,CV[6],_Read(FArr(CBPlotFYArr,Shape)))
	 CMov(PlayerID,CV[7],_Read(FArr(CBPlotFXArr,RetShape)))
	CMov(PlayerID,CV[8],_Read(FArr(CBPlotFYArr,RetShape)))
	if type(RetShape) == "number" then
		CDoActions(PlayerID,{SetV(CV[4],_SHRead(FArr(CBPlotFNum,RetShape-1)))})
	else
		CDoActions(PlayerID,{SetV(CV[4],_SHRead(FArr(CBPlotFNum,_Sub(RetShape,1))))})
	end
	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBCOPYCall1,0x0,0,0);
				SetCtrigX("X",FCBCOPYCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBCOPYCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBCOPYCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {preserved}
		}
	CDoActions(PlayerID,{TSetMemory(_Add(CBPlotNumHeader,LRShNextV2),SetTo,CV[1])})
end


local CA = CAPlotDataArr
local CB = CAPlotCreateArr
local TempFunc = CreateVar(FP)
local TempFunc2 = CreateVar(FP)

CB_PrfcInit = def_sIndex()
CJump(FP,CB_PrfcInit)
	CB_initTCopy()
CJumpEnd(FP,CB_PrfcInit)





function CB_RandSort()
		
	CMov(FP,CalcX,_Mod(_Rand(),200),-100)
	CMov(FP,CalcY,_Mod(_Rand(),200),-100)
	CMov(FP,CalcA,_Mod(_Rand(),360))
	DoActions(FP,SetSwitch(RandSwitch1,Random))
	TriggerX(FP,Switch(RandSwitch1,Cleared),{SetV(NG,1)},{preserved})
	TriggerX(FP,Switch(RandSwitch1,Set),{SetV(NG,0)},{preserved})

	RandRet = f_CRandNum(2)
	DirRand = CreateVar(FP)
	CMov(FP,DirRand,RandRet)
	RandRet = f_CRandNum(3)
	CMov(FP,FncRand,RandRet)
	if TestStart == 1 then
		--DisplayPrint(HumanPlayers, {"DirRand : ",DirRand,"  FncRand : ",FncRand})
	end
	CB_Sort(CFunc1, DirRand, STSize+2, EndRetShape)
	CurShNum = CreateVar(FP)
	CB_GetNumber(EndRetShape, CurShNum)
	if TestStart == 1 then

	--DisplayPrint(HumanPlayers, {"Calc "..(STSize+2).." to "..EndRetShape.." DirRand : ",DirRand,"  FncRand : ",FncRand,"   CurShNum : ",CurShNum})
	end
	

end

function CB_MarNumFill()
	local MarNum = CreateVars(FP)
	--Simple_SetLocX(FP, 200, G_CB_TempTable[8],G_CB_TempTable[9],G_CB_TempTable[8],G_CB_TempTable[9],{Simple_CalcLoc(200, -32*15, -32*15, 32*15, 32*15),KillUnitAt(All, nilunit, 201, FP)})
	--최대값 32 최소값 2
	--최대값기준 마린 480마리
	--local Xm, Ym = CreateVars(2, FP)
	--CB_GetXmin(G_CB_Shapes[TemConnect][2], Xm)
	--CB_GetYmin(G_CB_Shapes[TemConnect][2], Ym)
	--UnitReadX(FP, Force1, "Men", 201, MarNum)
	--TriggerX(FP, {CV(MarNum,480,AtLeast)}, {SetV(MarNum,480)},{preserved})
	--local SizeV = CreateVar(FP)
	--CSub(FP,SizeV, _Mov(128+16+32), _Div(MarNum,5))
	
	--CB_Fill(Xm, Ym, SizeV, SizeV,32,32, STSize+2)
	--CB_CropPath(G_CB_Shapes[TemConnect][2],0,STSize+2,STSize+3)
	RandRet = f_CRandNum(2)
	CMov(FP,DirRand,RandRet)
	CB_Sort(CFunc2,DirRand,STSize+2,EndRetShape)


end
	G_CB_PrefuncArr = {
		{1,"CB_RandSort"},
		{2,"CB_MarNumFill"},
	} --{index,funcname}



	
	
	CIfX(FP,{CVX(G_CB_TempTable[2],1,0xFF,AtLeast)})
	CB_TCopy(V(CA[1]),STSize+2)
	--DisplayPrint(HumanPlayers, {"ShapeData ",V(CA[1])," to "..(STSize+2).." TempFunc : ",G_CB_TempTable[2]})
	for j, k in pairs(G_CB_PrefuncArr) do
		CIf(FP,CVX(G_CB_TempTable[2],k[1],0xFF))
			_G[k[2]]()
		CIfEnd()
	end
	local TempRetShape = CreateVar(FP)
	CMov(FP,TempRetShape,G_CB_Num,EndRetShape)
	CB_TCopy(EndRetShape,TempRetShape)
	CMov(FP,V(CA[1]),G_CB_Num,EndRetShape)
	CMov(FP,G_CB_TempTable[13],G_CB_Num,EndRetShape)
	--DisplayPrint(HumanPlayers, {"ShapeData "..EndRetShape.." to ",V(CA[1])," G_CB_TempTable[13] : ",G_CB_TempTable[13]})

	CIf(FP,CVX(G_CB_TempTable[5],0,0xFF))
	local RetNum = CreateVar(FP)
	CB_GetNumber(EndRetShape, RetNum)
	CMov(FP,G_CB_TempTable[5],_Div(RetNum,50),1,0xFF,1)
	CMov(FP,V(CA[5]),G_CB_TempTable[5],nil,0xFF,1)

	CIfEnd()

	CIfXEnd()

	
	CIfX(FP,CVar(FP,G_CB_TempTable[5][2],AtMost,0,0xFF)) -- LoopLimit
	for j, k in pairs(Z) do
		CTrigger(FP,{CVar(FP,G_CB_TempTable[13][2],Exactly,j,0xFF)},{SetCVar(FP,G_CB_TempTable[5][2],SetTo,(k[1]/50)+1)},1)
	end
		CMov(FP,V(CA[5]),G_CB_TempTable[5],nil,0xFF,1)
	CElseX()
		CMov(FP,V(CA[5]),G_CB_TempTable[5],nil,0xFF,1)
	CIfXEnd()
	CMov(FP,G_CB_TempTable[2],0,nil,0xFF)


end

--[[
	Line 0 = UnitID 1Byte
	Line 1 = PrefuncID 1Byte
	Line 2 = CBPlot Index 4Byte
	Line 3 = Current Delay Time 4Byte
	Line 4 = Loop Limit 1Byte
	Line 5 = RepeatType 1Byte
	Line 6 = ??? 
	Line 9 = CreatePlayer 1Byte
	Line 10 = ShapeSize 1Byte (100=100%)
	Line 11 = Use Queue Option 1Byte
	Line 12 SelectShapeNumber1 4Byte
	Line 13 SelectShapeNumber2 4Byte
	Line 14 SelectShapeNumber3 4Byte
	Line 15 SelectShapeNumber4 4Byte
	Line 16 Set Delay Timer 1 4Byte
	Line 17 Set Delay Timer 2 4Byte
	Line 18 Set Delay Timer 3 4Byte
	Line 19 Set Delay Timer 4 4Byte
]]


G_CB_ShNm = 0
local Call_G_CBPlot = CreateCallIndex()
function G_CBPlot()
		Z = {}
		local c = 0
		for j,k in pairs(G_CB_Shapes) do
			Z[k[2]] = k[1]
			c=c+1
			G_CB_ShNm = G_CB_ShNm+1
		end

		
	if type(Z) ~= "table" then
		PushErrorMsg("ShapeData_Input_Error")
	end
	local Y = {}
	local X = {}
	local L = {}
	for j, k in pairs(Z) do
		Y[j] = k
		if L[j] ~= nil then
			X[j] = L[j]
		else
			X[j] = CS_TMakeAuto(k)
		end
	end
	STSize = #Y
	table.insert(Z,CS_InputVoid(1699))
	table.insert(Z,CS_InputVoid(1699))
	table.insert(Z,CS_InputVoid(1699))
	for i = 1, Size_of_G_CB_Arr do
		table.insert(Z,CS_InputVoid(1699))
	end


	EndRetShape = STSize+3 -- 최종 연산 ShapeNum




	local CA = CAPlotForward()
	SetCall2(FP,Call_G_CBPlot)
	CTrigger(FP, {CV(G_CB_TempTable[17],0)}, {SetV(G_CB_TempTable[4],0),SetV(V(CA[3]),0)},1)
	CMov(FP,CA_TempUID,G_CB_TempTable[1],nil,0xFF) -- UnitID
	CMov(FP,V(CA[1]),G_CB_TempTable[13]) -- ShapeIndex
	CMov(FP,V(CA[3]),G_CB_TempTable[17]) -- SetDelayTimer
	CMov(FP,V(CA[2]),G_CB_TempTable[4]) -- CurDelayTimer
	CMov(FP,Repeat_EffID,G_CB_TempTable[27])--EFFID
	CMov(FP,SendEff[1],G_CB_TempTable[28])--EFFID
	CMov(FP,SendEff[2],G_CB_TempTable[29])--EFFID
	CMov(FP,SendEff[3],G_CB_TempTable[30])--EFFID
	CMov(FP,Repeat_OrderX,G_CB_TempTable[31])--OrderX
	CMov(FP,Repeat_OrderY,G_CB_TempTable[32])--OrderY
	CMov(FP,Repeat_OrderType,G_CB_TempTable[33])--OrderType
	
	
	
	--DisplayPrint(HumanPlayers, {
	--	"   G_CB_TempTable[1] : ",G_CB_TempTable[1],--Line 0 = UnitID 1Byte
	--	"   G_CB_TempTable[2] : ",G_CB_TempTable[2],--Line 1 = PrefuncID 1Byte
	--	"   G_CB_TempTable[3] : ",G_CB_TempTable[3],--Line 2 = CBPlot Index 4Byte
	--	"   G_CB_TempTable[4] : ",G_CB_TempTable[4],--Line 3 = Current Delay Time 4Byte
	--	"   G_CB_TempTable[5] : ",G_CB_TempTable[5],--Line 4 = Loop Limit 1Byte
	--	"   G_CB_TempTable[6] : ",G_CB_TempTable[6],--Line 5 = RepeatType 1Byte
	--	"   G_CB_TempTable[7] : ",G_CB_TempTable[7],--Line 6 = ??? 
	--	"   G_CB_TempTable[8] : ",G_CB_TempTable[8],--.
	--	"   G_CB_TempTable[9] : ",G_CB_TempTable[9],--.
	--	"   G_CB_TempTable[10] : ",G_CB_TempTable[10],--Line 9 = CreatePlayer 1Byte
	--	"   G_CB_TempTable[11] : ",G_CB_TempTable[11],--Line 10 = ShapeSize 1Byte (100=100%)
	--	"   G_CB_TempTable[12] : ",G_CB_TempTable[12],--Line 11 = Use Queue Option 1Byte
	--	"   G_CB_TempTable[13] : ",G_CB_TempTable[13],--Line 12 SelectShapeNumber1 4Byte
	--	"   G_CB_TempTable[14] : ",G_CB_TempTable[14],--Line 13 SelectShapeNumber2 4Byte
	--	"   G_CB_TempTable[15] : ",G_CB_TempTable[15],--Line 14 SelectShapeNumber3 4Byte
	--	"   G_CB_TempTable[16] : ",G_CB_TempTable[16],--Line 15 SelectShapeNumber4 4Byte
	--	"   G_CB_TempTable[17] : ",G_CB_TempTable[17],--Line 16 Set Delay Timer 1 4Byte
	--	"   G_CB_TempTable[18] : ",G_CB_TempTable[18],--Line 17 Set Delay Timer 2 4Byte
	--	"   G_CB_TempTable[19] : ",G_CB_TempTable[19],--Line 18 Set Delay Timer 3 4Byte
	--	"   G_CB_TempTable[20] : ",G_CB_TempTable[20],--Line 19 Set Delay Timer 4 4Byte
	--})

	CMov(FP,V(CA[6]),G_CB_TempTable[3]) -- CBPlot Index
    CMov(FP,NQOption,G_CB_TempTable[12],nil,0xFF,1) -- QueueOption
	CMov(FP,V(CA[5]),G_CB_TempTable[5],nil,0xFF,1)
	CMov(FP,G_CB_BackupX,G_CB_TempTable[8])
	CMov(FP,G_CB_BackupY,G_CB_TempTable[9])
    CBPlot(Z, nil, FP,nilunit, 0, {G_CB_TempTable[8],G_CB_TempTable[9]}, 1,32,{0,0,0,0,0,1}, "CA_Func1", "G_CB_Prefunc", FP, nil,nil,{SetCDeaths(FP,Add,1,CA_Suspend)})
    CTrigger(FP, {TTNVar(V(CA[2]), NotSame, G_CB_TempTable[4])}, {SetCDeaths(FP,SetTo,1,G_CB_Launch)},{preserved})
	if TestStart == 1 then
		--CIf(FP,{CD(CA_Suspend,1)})
		
		--DisplayPrint(HumanPlayers, {
		--	"   G_CB_TempTable[1] : ",G_CB_TempTable[1],--Line 0 = UnitID 1Byte
		--	"   G_CB_TempTable[2] : ",G_CB_TempTable[2],--Line 1 = PrefuncID 1Byte
		--	"   G_CB_TempTable[3] : ",G_CB_TempTable[3],--Line 2 = CBPlot Index 4Byte
		--	"   G_CB_TempTable[4] : ",G_CB_TempTable[4],--Line 3 = Current Delay Time 4Byte
		--	"   G_CB_TempTable[5] : ",G_CB_TempTable[5],--Line 4 = Loop Limit 1Byte
		--	"   G_CB_TempTable[6] : ",G_CB_TempTable[6],--Line 5 = RepeatType 1Byte
		--	"   G_CB_TempTable[7] : ",G_CB_TempTable[7],--Line 6 = ??? 
		--	"   G_CB_TempTable[8] : ",G_CB_TempTable[8],--.
		--	"   G_CB_TempTable[9] : ",G_CB_TempTable[9],--.
		--	"   G_CB_TempTable[10] : ",G_CB_TempTable[10],--Line 9 = CreatePlayer 1Byte
		--	"   G_CB_TempTable[11] : ",G_CB_TempTable[11],--Line 10 = ShapeSize 1Byte (100=100%)
		--	"   G_CB_TempTable[12] : ",G_CB_TempTable[12],--Line 11 = Use Queue Option 1Byte
		--	"   G_CB_TempTable[13] : ",G_CB_TempTable[13],--Line 12 SelectShapeNumber1 4Byte
		--	"   G_CB_TempTable[14] : ",G_CB_TempTable[14],--Line 13 SelectShapeNumber2 4Byte
		--	"   G_CB_TempTable[15] : ",G_CB_TempTable[15],--Line 14 SelectShapeNumber3 4Byte
		--	"   G_CB_TempTable[16] : ",G_CB_TempTable[16],--Line 15 SelectShapeNumber4 4Byte
		--	"   G_CB_TempTable[17] : ",G_CB_TempTable[17],--Line 16 Set Delay Timer 1 4Byte
		--	"   G_CB_TempTable[18] : ",G_CB_TempTable[18],--Line 17 Set Delay Timer 2 4Byte
		--	"   G_CB_TempTable[19] : ",G_CB_TempTable[19],--Line 18 Set Delay Timer 3 4Byte
		--	"   G_CB_TempTable[20] : ",G_CB_TempTable[20],--Line 19 Set Delay Timer 4 4Byte
		--})

			--DisplayPrint(HumanPlayers, {"CA[6] : ",V(CA[6])})
		--CIfEnd()
	end
	CDoActions(FP,{TSetCVar(FP,G_CB_TempTable[3][2],SetTo,V(CA[6])),TSetCVar(FP,G_CB_TempTable[4][2],SetTo,V(CA[2]))})

    
	SetCallEnd2()
end

function T_to_ByteBuffer(Table)
	local VMode = 0
	for j,k in pairs(Table) do
		if type(k) == "table" then--V가 한개라도 있을경우 VMode On
			if k[4] == "V" then
				VMode = 1
				G_CBPlotTOption = 1
			else
				PushErrorMsg("Table_InputData_Error")
			end
		end
	end
	if VMode == 0 then
		local ByteValue = 0
		if type(Table) == "table" then
			local ret = 0
			if #Table >= 5 then
				PushErrorMsg("BiteStack_is_Over_5")
			end
			for i, j in pairs(Table) do
				if type(j) == "string" then
					ByteValue = ByteValue + ParseUnit(j)*(256^ret)
				else
				ByteValue = ByteValue + j*(256^ret)
				end
				ret = ret + 1
			end
			Table = ByteValue
		end
		return ByteValue
	else
		local ByteValue = 0
		local TempV = CreateVar(FP)
		if type(Table) == "table" then
			local ret = 0
			if #Table >= 5 then
				PushErrorMsg("BiteStack_is_Over_5")
			end
			for i, j in pairs(Table) do
				if type(j) == "table" and j[4]== "V" then
					if i~= 1 then
						CAdd(FP,TempV,_lShift(j, (i-1)*8))
					else
						ByteValue = ByteValue + j*(256^ret)
					end
					
				elseif type(j) == "number" then
					ByteValue = ByteValue + j*(256^ret)
				else
					PushErrorMsg("Table_InputData_Error")
				end
				ret = ret + 1
			end
		end
		if ByteValue >= 1 then
			CAdd(FP,TempV,ByteValue)
		end
		return TempV
	end
end


function G_CB_SetSpawn(Condition,G_CB_CUTable,G_CB_SNTable,G_CB_SLTable,G_CB_LMTable,G_CB_RepeatType,G_CB_SizeTable,CenterXY,G_CB_OwnerTable,PreserveFlag,G_CB_NQOpTable)
    local G_CB_ShapeTable = {}
	if G_CB_SizeTable == nil then G_CB_SizeTable = 100 end
	if G_CB_NQOpTable == nil then G_CB_NQOpTable = 0 end
	if G_CB_RepeatType == nil then G_CB_RepeatType = 0 end
	local G_CB_FNTable = {}
	if type(G_CB_SNTable) == "string" then
		G_CB_SNTable = {G_CB_SNTable,G_CB_SNTable,G_CB_SNTable,G_CB_SNTable}
    elseif type(G_CB_SNTable[1]) == "table"  then
        if type(G_CB_SNTable[1][1]) == "number" then
            G_CB_SNTable = {G_CB_SNTable,G_CB_SNTable,G_CB_SNTable,G_CB_SNTable}
        end
	elseif G_CB_SNTable == nil then
		PushErrorMsg("G_CB_SetSpawn_Inputdata_Error")
	end

	if type(G_CB_SLTable) ~= "table" then
		G_CB_SLTable = {G_CB_SLTable,G_CB_SLTable,G_CB_SLTable,G_CB_SLTable}
	elseif G_CB_SLTable == nil then
		PushErrorMsg("G_CB_SetSpawn_Inputdata_Error")
	end
    for j,k in pairs(G_CB_SNTable) do
        if k == "ACAS" then
            G_CB_ShapeTable[j] = _G[G_CB_SLTable[j]]
        else
            G_CB_ShapeTable[j] = k[G_CB_SLTable[j]+1]
			G_CB_FNTable[j] = 1
        end
    end
	if #G_CB_FNTable == 0 then G_CB_FNTable = nil end


    G_CB_SetSpawnX(Condition,G_CB_CUTable,G_CB_ShapeTable,G_CB_LMTable,G_CB_RepeatType,nil,G_CB_SizeTable,G_CB_FNTable,CenterXY,G_CB_OwnerTable,PreserveFlag,G_CB_NQOpTable)
end



function G_CB_SetSpawnX(Condition,G_CB_CUTable,G_CB_ShapeTable,G_CB_LMTable,G_CB_RepeatType,G_CB_Delay,G_CB_SizeTable,G_CB_FNTable,CenterXY,G_CB_OwnerTable,PreserveFlag,G_CB_NQOpTable)

	G_CB_TSetSpawn(Condition,G_CB_CUTable,G_CB_ShapeTable,PreserveFlag,{
		LMTable = G_CB_LMTable,
		RepeatType = G_CB_RepeatType,
		Delay = G_CB_Delay,
		SizeTable = G_CB_SizeTable,
		FNTable = G_CB_FNTable,
		OwnerTable = G_CB_OwnerTable,
		NQOpTable = G_CB_NQOpTable,
		CenterXY = CenterXY,
	})


end

function G_CB_TScanEff(Condition,G_CB_ShapeTable,CenterXY,ScanEffID,PreserveFlag,Property,Color)
	local x = {}
	for j,k in pairs(G_CB_ShapeTable) do
		table.insert(x,33)
	end
	local PP = Property
	if PP == nil then PP={} end
	PP["EffID"] = ScanEffID

	if Color ~= nil then
		local ret2 = 0x669E28+ScanEffID
		local ret = bit32.band(ret2, 0xFFFFFFFF)%4
		local Mask = 0
		if ret == 0 then
			Mask = 0xFF
		elseif ret == 1 then
			Mask = 0xFF00
			Color = Color * 0x100
		elseif ret == 2 then
			Mask = 0xFF0000
			Color = Color * 0x10000
		elseif ret == 3 then
			Mask = 0xFF000000
			Color = Color * 0x1000000
		end
		ret2 = ret2 - ret
		
		PP["EffColorMem"] = EPDF(ret2)
		PP["EffColor"] = Color
		PP["EffColorMask"] = Mask
	end

	G_CB_TSetSpawn(Condition,x,G_CB_ShapeTable,P6,CenterXY,PreserveFlag,PP)
	--P6, UID 33 고정
end
function G_CB_TSetSpawn(Condition,G_CB_CUTable,G_CB_ShapeTable,OwnerTable,CenterXY,PreserveFlag,G_CB_Property)
	--LM == nil then LM = 255
	if type(G_CB_CUTable) ~= "table" then
		PushErrorMsg("G_CB_SetSpawn_Inputdata_Error")
	end
	
	if type(G_CB_ShapeTable[1]) == "number" then
		G_CB_ShapeTable = {G_CB_ShapeTable,G_CB_ShapeTable,G_CB_ShapeTable,G_CB_ShapeTable}
	elseif G_CB_ShapeTable == nil then
		PushErrorMsg("G_CB_SetSpawn_Inputdata_Error")
	end

	G_CBPlotTOption = 0
	local X = {}
	if type(G_CB_ShapeTable[1]) == "table" then
		if #G_CB_ShapeTable >= 5 then
			PushErrorMsg("BiteStack_is_Over_5")
		end
		for i = 1, 4 do
			if G_CB_ShapeTable[i] ~= nil then
				
                if G_CB_Shapes[G_CB_ShapeTable[i]] == nil then
                    G_CB_Shapes[G_CB_ShapeTable[i]] = {G_CB_ShapeTable[i],G_CB_ShapeIndexAlloc}
                    G_CB_ShapeIndexAlloc = G_CB_ShapeIndexAlloc + 1
                end
                G_CB_ShapeTable[i] = G_CB_Shapes[G_CB_ShapeTable[i]][2]
				
            else
                G_CB_ShapeTable[i] = 0
            end
		end
	else
		PushErrorMsg("G_CB_SLTable_InputData_Error")
	end



	local G_CB_LMTable = {{G_CB_LMTV,0}}
	local G_CB_Delay = {
		{G_CB_DLTV[1],0},
		{G_CB_DLTV[2],0},
		{G_CB_DLTV[3],0},
		{G_CB_DLTV[4],0},
	}
	local G_CB_Rotate = {
		{G_CB_RTTV[1],0},
		{G_CB_RTTV[2],0},
		{G_CB_RTTV[3],0},
		{G_CB_RTTV[4],0},
	}
	local G_CB_SizeTable = {{G_CB_SZTV,T_to_ByteBuffer({100,100,100,100})}}
	local G_CB_FNTable = {{G_CB_FNTV,T_to_ByteBuffer({0,0,0,0})}}
	local G_CB_NQOpTable = {{G_CB_NQOption,T_to_ByteBuffer({0,0,0,0})}}
	local G_CB_RepeatType = {{G_CB_RPTV,T_to_ByteBuffer({0,0,0,0})}}
	local G_CB_CenterXY = {{G_CB_XPos,0xFFFFFFFF},{G_CB_YPos,0xFFFFFFFF}} 
	local G_CB_CenterDis = {{G_CB_XDis,0},{G_CB_YDis,0}}
	local G_CB_EffID = {{G_CB_Eff,0}}
	local G_CB_EffColorMem = {{G_CB_ColorMem,0}}
	local G_CB_EffColor = {{G_CB_Color,0xFFFFFFFF}}
	local G_CB_EffColorMask = {{G_CB_ColorMask,0}}
	local G_CB_OrderXY = {{G_CB_OrderXPos,0xFFFFFFFF},{G_CB_OrderYPos,0xFFFFFFFF},{G_CB_OrderAct,0}} 
	
		


	if type(CenterXY) == "number" then
		local Temp,EditorLocNum = ConvertLocation(CenterXY)
		G_CB_CenterXY = {{G_CB_XPos,EditorLocNum+0x80000000},{G_CB_YPos,EditorLocNum+0x80000000}} -- 로케이션 모드
	elseif type(CenterXY) == "string" then
		local Temp,EditorLocNum = ConvertLocation(CenterXY)
		G_CB_CenterXY = {{G_CB_XPos,Temp+2+0x80000000},{G_CB_YPos,Temp+2+0x80000000}} -- 로케이션 모드

	elseif type(CenterXY)== "table" then
		if #CenterXY ~= 2 then PushErrorMsg("CenterXY_TableError") else 
			G_CB_CenterXY = {{G_CB_XPos,CenterXY[1]},{G_CB_YPos,CenterXY[2]}} -- 좌표 모드
		end
	end 
	local G_CB_OwnerTable = {{G_CB_CPTV,T_to_ByteBuffer({FP,FP,FP,FP})}}
	if type(OwnerTable) == "number" then
		G_CB_OwnerTable = {{G_CB_CPTV,T_to_ByteBuffer({OwnerTable,OwnerTable,OwnerTable,OwnerTable})}}
	elseif type(OwnerTable) == "table" then
		G_CB_OwnerTable = {{G_CB_CPTV,T_to_ByteBuffer(OwnerTable)}}
	end
	if G_CB_Property then
		
	for j,k in pairs(G_CB_Property) do
		if j == "LMTable" then
			if k == "MAX" then
				G_CB_LMTable = {{G_CB_LMTV,-1}}
			elseif type(k) == "table" and k[4]~="V" then
				G_CBPlotTOption = 1
				G_CB_LMTable = {{G_CB_LMTV,T_to_ByteBuffer(k)}}
			else
				G_CB_LMTable = {{G_CB_LMTV,T_to_ByteBuffer({k,k,k,k})}}
			end
		elseif j == "Delay" then
			--_G[k]()
			if type(k) == "table" and k[4]~="V" then
				G_CBPlotTOption = 1
				for o, p in pairs(k) do
					G_CB_Delay[o] = {G_CB_DLTV[o],p}
				end
			else
				G_CB_Delay = {
					{G_CB_DLTV[1],k},
					{G_CB_DLTV[2],k},
					{G_CB_DLTV[3],k},
					{G_CB_DLTV[4],k},
				}
			end



			
		elseif j == "SizeTable" then
			if type(k) == "table" and k[4]~="V" then
				G_CBPlotTOption = 1
				G_CB_SizeTable = {{G_CB_SZTV,T_to_ByteBuffer(k)}}
			else
				G_CB_SizeTable = {{G_CB_SZTV,T_to_ByteBuffer({k,k,k,k})}}
			end
		elseif j == "EffID" then
			if type(k) == "table" and k[4]~="V" then
				G_CBPlotTOption = 1
				G_CB_EffID = {{G_CB_Eff,k}}
			else
				G_CB_EffID = {{G_CB_Eff,k}}
			end
		elseif j == "EffColorMem" then
			if type(k) == "table" and k[4]~="V" then
				G_CBPlotTOption = 1
				G_CB_EffColorMem = {{G_CB_ColorMem,k}}
			else
				G_CB_EffColorMem = {{G_CB_ColorMem,k}}
			end
		elseif j == "EffColor" then
			if type(k) == "table" and k[4]~="V" then
				G_CBPlotTOption = 1
				G_CB_EffColor = {{G_CB_Color,k}}
			else
				G_CB_EffColor = {{G_CB_Color,k}}
			end
		elseif j == "EffColorMask" then
			if type(k) == "table" and k[4]~="V" then
				G_CBPlotTOption = 1
				G_CB_EffColorMask = {{G_CB_ColorMask,k}}
			else
				G_CB_EffColorMask = {{G_CB_ColorMask,k}}
			end

			
			
		elseif j == "Order" then
			local OrderNum=0
			if type(k) ~= "table" then PushErrorMsg("OrderTable_TypeError") end
			if #k==3 then--{OrderType,X,Y}
			
				if k[1]==Attack then OrderNum = 1 elseif k[1]==Patrol then OrderNum = 2 elseif k[1]==Move then OrderNum=3 else PushErrorMsg("OrderTable_TypeError") end
				G_CB_OrderXY = {{G_CB_OrderXPos,k[2]},{G_CB_OrderYPos,k[3]},{G_CB_OrderAct,OrderNum}} 

			elseif #k==2 then--{OrderType,LocationId}
				local Temp,EditorLocNum = ConvertLocation(k[2])
				if k[1]==Attack then OrderNum = 1 elseif k[1]==Patrol then OrderNum = 2 elseif k[1]==Move then OrderNum=3 else PushErrorMsg("OrderTable_TypeError") end
				G_CB_OrderXY = {{G_CB_OrderXPos,Temp+2+0x80000000},{G_CB_OrderYPos,Temp+2+0x80000000},{G_CB_OrderAct,OrderNum}} 

			else PushErrorMsg("OrderTable_Error")
			end





		elseif j == "FNTable" then
			if type(k) == "table" and k[4]~="V" then
				G_CBPlotTOption = 1
				G_CB_FNTable = {{G_CB_FNTV,T_to_ByteBuffer(k)}}
			else
				G_CB_FNTable = {{G_CB_FNTV,T_to_ByteBuffer({k,k,k,k})}}
			end
		elseif j == "NQOpTable" then
			if type(k) == "table" and k[4]~="V" then
				G_CBPlotTOption = 1
				G_CB_NQOpTable = {{G_CB_NQOption,T_to_ByteBuffer(k)}}
			else
				G_CB_NQOpTable = {{G_CB_NQOption,T_to_ByteBuffer({k,k,k,k})}}
			end
		elseif j == "RepeatType" then

			if type(k) == "table" and k[4]~="V" then
				G_CBPlotTOption = 1
				local RT = {}
				for o,p in pairs(k) do
					local retP
					if type(p) == "string" then
						retP = RTypeKey[p]
					else
						retP = p
					end
					RT[o] = retP
				end
				G_CB_RepeatType = {{G_CB_RPTV,T_to_ByteBuffer(RT)}}
			else
				local retP
				if type(k) == "string" then
					retP = RTypeKey[k]
				else
					retP = k
				end
				G_CB_RepeatType = {{G_CB_RPTV,T_to_ByteBuffer({retP,retP,retP,retP})}}
			end
		elseif j == "DistanceXY" then
			if #k ~= 2 then PushErrorMsg("DistanceXY_TableError") else 
				G_CB_CenterDis = {{G_CB_XDis,k[1]},{G_CB_YDis,k[2]}}
			end
			
		elseif j == "RotateTable" then
			if type(k) == "table" and k[4]=="V" then
				G_CBPlotTOption = 1
				G_CB_Rotate = {
					{G_CB_RTTV[1],k},
					{G_CB_RTTV[2],k},
					{G_CB_RTTV[3],k},
					{G_CB_RTTV[4],k},
				}
			elseif type(k) == "string" and k=="Main" then
				G_CB_Rotate = {
					{G_CB_RTTV[1],0xFFFFFFFF},
					{G_CB_RTTV[2],0xFFFFFFFF},
					{G_CB_RTTV[3],0xFFFFFFFF},
					{G_CB_RTTV[4],0xFFFFFFFF},
				}
			else
				G_CB_Rotate = {
					{G_CB_RTTV[1],k},
					{G_CB_RTTV[2],k},
					{G_CB_RTTV[3],k},
					{G_CB_RTTV[4],k},
				}
			end
		else PushErrorMsg("Wrong Property Name : "..j)
		end
	end
	end
	if G_CBPlotTOption == 0 then
		local Act = {
		SetCVar(FP,G_CB_CUTV[2],SetTo,T_to_ByteBuffer(G_CB_CUTable)),
		SetCVar(FP,G_CB_SNTV[1][2],SetTo,G_CB_ShapeTable[1]),
		SetCVar(FP,G_CB_SNTV[2][2],SetTo,G_CB_ShapeTable[2]),
		SetCVar(FP,G_CB_SNTV[3][2],SetTo,G_CB_ShapeTable[3]),
		SetCVar(FP,G_CB_SNTV[4][2],SetTo,G_CB_ShapeTable[4]),
		}
		AutoSetV(Act,G_CB_LMTable)
		AutoSetV(Act,G_CB_Delay)
		AutoSetV(Act,G_CB_SizeTable)
		AutoSetV(Act,G_CB_FNTable)
		AutoSetV(Act,G_CB_NQOpTable)
		AutoSetV(Act,G_CB_RepeatType)
		AutoSetV(Act,G_CB_CenterXY)
		AutoSetV(Act,G_CB_CenterDis)
		AutoSetV(Act,G_CB_EffID)
		AutoSetV(Act,G_CB_EffColorMem)
		AutoSetV(Act,G_CB_EffColor)
		AutoSetV(Act,G_CB_EffColorMask)
		AutoSetV(Act,G_CB_OrderXY)
		


		AutoSetV(Act,G_CB_OwnerTable)
		AutoSetV(Act,G_CB_Rotate)
		CallTriggerX(FP,Write_SpawnSet,Condition,Act,PreserveFlag)
	else
		local Act = {
		TSetCVar(FP,G_CB_CUTV[2],SetTo,T_to_ByteBuffer(G_CB_CUTable)),
		TSetCVar(FP,G_CB_SNTV[1][2],SetTo,G_CB_ShapeTable[1]),
		TSetCVar(FP,G_CB_SNTV[2][2],SetTo,G_CB_ShapeTable[2]),
		TSetCVar(FP,G_CB_SNTV[3][2],SetTo,G_CB_ShapeTable[3]),
		TSetCVar(FP,G_CB_SNTV[4][2],SetTo,G_CB_ShapeTable[4]),
		}
		TAutoSetV(Act,G_CB_LMTable)
		TAutoSetV(Act,G_CB_Delay)
		TAutoSetV(Act,G_CB_SizeTable)
		TAutoSetV(Act,G_CB_FNTable)
		TAutoSetV(Act,G_CB_NQOpTable)
		TAutoSetV(Act,G_CB_RepeatType)
		TAutoSetV(Act,G_CB_CenterXY)
		TAutoSetV(Act,G_CB_CenterDis)
		TAutoSetV(Act,G_CB_OwnerTable)
		TAutoSetV(Act,G_CB_Rotate)
		TAutoSetV(Act,G_CB_EffID)
		TAutoSetV(Act,G_CB_EffColorMem)
		TAutoSetV(Act,G_CB_EffColor)
		TAutoSetV(Act,G_CB_OrderXY)
		TAutoSetV(Act,G_CB_EffColorMask)
		CDoActions(FP, Act,PreserveFlag)
		CallTriggerX(FP,Write_SpawnSet,Condition,nil,PreserveFlag)

	end
end
function AutoSetV(ActT,T)
	
for j,k in pairs(T) do
	table.insert(ActT, SetCVar(FP, k[1][2], SetTo, k[2]))
end

end
function TAutoSetV(ActT,T)
	
for j,k in pairs(T) do
	table.insert(ActT, TSetCVar(FP, k[1][2], SetTo, k[2]))
end

end
--[[
	Line 0 = UnitID 1Byte
	Line 1 = PrefuncID 1Byte
	Line 2 = CBPlot Index 4Byte
	Line 3 = Current Delay Time 4Byte
	Line 4 = Loop Limit 1Byte
	Line 5 = RepeatType 1Byte
	Line 6 = ??? 
	Line 9 = CreatePlayer 1Byte
	Line 10 = ShapeSize 1Byte (100=100%)
	Line 11 = Use Queue Option 1Byte
	Line 12 SelectShapeNumber1 4Byte
	Line 13 SelectShapeNumber2 4Byte
	Line 14 SelectShapeNumber3 4Byte
	Line 15 SelectShapeNumber4 4Byte
	Line 16 Set Delay Timer 1 4Byte
	Line 17 Set Delay Timer 2 4Byte
	Line 18 Set Delay Timer 3 4Byte
	Line 19 Set Delay Timer 4 4Byte
]]

Call_G_CB = SetCallForward()
SetCall(FP)
    CIfX(FP,CVar(FP,G_CB_TempTable[1][2],AtLeast,1,0xFF))
		--DisplayPrint(HumanPlayers, {G_CB_TempTable[5]})
        CallTrigger(FP,Call_G_CBPlot)
        CIfX(FP,{CDeaths(FP,AtLeast,1,G_CB_Launch),CDeaths(FP,AtMost,0,CA_Suspend)})
            CDoActions(FP,{
                TSetMemoryX(Vi(G_CB_TempH[2],0*(0x20/4)),SetTo,G_CB_TempTable[1],0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],1*(0x20/4)),SetTo,G_CB_TempTable[2],0xFF),
                TSetMemory(Vi(G_CB_TempH[2],2*(0x20/4)),SetTo,G_CB_TempTable[3]),
                TSetMemory(Vi(G_CB_TempH[2],3*(0x20/4)),SetTo,G_CB_TempTable[4]),
                TSetMemoryX(Vi(G_CB_TempH[2],4*(0x20/4)),SetTo,G_CB_TempTable[5],0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],5*(0x20/4)),SetTo,G_CB_TempTable[6],0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],6*(0x20/4)),SetTo,G_CB_TempTable[7],0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],9*(0x20/4)),SetTo,G_CB_TempTable[10],0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],10*(0x20/4)),SetTo,G_CB_TempTable[11],0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],11*(0x20/4)),SetTo,G_CB_TempTable[12],0xFF),
                TSetMemory(Vi(G_CB_TempH[2],12*(0x20/4)),SetTo,G_CB_TempTable[13]),
                
            })
            

        CElseIfX({CDeaths(FP,AtLeast,1,G_CB_Launch),CDeaths(FP,AtLeast,1,CA_Suspend)})
        CDoActions(FP,{
            TSetMemoryX(Vi(G_CB_TempH[2],0*(0x20/4)),SetTo,0,0xFF),
            TSetMemoryX(Vi(G_CB_TempH[2],1*(0x20/4)),SetTo,0,0xFF),
            TSetMemory(Vi(G_CB_TempH[2],2*(0x20/4)),SetTo,0),
            TSetMemory(Vi(G_CB_TempH[2],3*(0x20/4)),SetTo,0),
            TSetMemoryX(Vi(G_CB_TempH[2],4*(0x20/4)),SetTo,0,0xFF),
            TSetMemoryX(Vi(G_CB_TempH[2],5*(0x20/4)),SetTo,0,0xFF),
            TSetMemoryX(Vi(G_CB_TempH[2],6*(0x20/4)),SetTo,0,0xFF),
            TSetMemoryX(Vi(G_CB_TempH[2],9*(0x20/4)),SetTo,0,0xFF),
            TSetMemoryX(Vi(G_CB_TempH[2],10*(0x20/4)),SetTo,0,0xFF),
            TSetMemoryX(Vi(G_CB_TempH[2],11*(0x20/4)),SetTo,0,0xFF),
			TSetMemory(Vi(G_CB_TempH[2],12*(0x20/4)),SetTo,0),
			TSetMemory(Vi(G_CB_TempH[2],16*(0x20/4)),SetTo,0),
			TSetMemory(Vi(G_CB_TempH[2],20*(0x20/4)),SetTo,0),
        })
        CIf(FP,{TMemory(Vi(G_CB_TempH[2],0*(0x20/4)), Exactly, 0)})--G_CBPlot 데이터에 유닛아이디가 존재하지 않을경우 배열을 전부 초기화한다.
        local TActArr = {}
        for arr = 1, G_CB_Lines do
            if arr == 3 then
                table.insert(TActArr, TSetMemory(Vi(G_CB_TempH[2],(arr-1)*(0x20/4)), SetTo, 1))
            else
                table.insert(TActArr, TSetMemory(Vi(G_CB_TempH[2],(arr-1)*(0x20/4)), SetTo, 0))
            end
        end
        CDoActions(FP, TActArr)
        if TestStart == 1 then
        --DoActions(FP,{RotatePlayer({DisplayTextX(f_GunFuncT2,4)},HumanPlayers,FP)})
        end
        CIfEnd()
        if TestStart == 1 then
        --DoActions(FP,{RotatePlayer({DisplayTextX(f_GunFuncT,4)},HumanPlayers,FP)})
        end
        CElseX()
            DoActions(FP,{RotatePlayer({DisplayTextX(f_GunErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
			if TestStart == 1 then
        	DisplayPrint(HumanPlayers, {
        		"   G_CB_TempTable[1] : ",G_CB_TempTable[1],--Line 0 = UnitID 1Byte
        		"   G_CB_TempTable[2] : ",G_CB_TempTable[2],--Line 1 = PrefuncID 1Byte
        		"   G_CB_TempTable[3] : ",G_CB_TempTable[3],--Line 2 = CBPlot Index 4Byte
        		"   G_CB_TempTable[4] : ",G_CB_TempTable[4],--Line 3 = Current Delay Time 4Byte
        		"   G_CB_TempTable[5] : ",G_CB_TempTable[5],--Line 4 = Loop Limit 1Byte
        		"   G_CB_TempTable[6] : ",G_CB_TempTable[6],--Line 5 = RepeatType 1Byte
        		"   G_CB_TempTable[7] : ",G_CB_TempTable[7],--Line 6 = ??? 
        		"   G_CB_TempTable[8] : ",G_CB_TempTable[8],--.
        		"   G_CB_TempTable[9] : ",G_CB_TempTable[9],--.
        		"   G_CB_TempTable[10] : ",G_CB_TempTable[10],--Line 9 = CreatePlayer 1Byte
        		"   G_CB_TempTable[11] : ",G_CB_TempTable[11],--Line 10 = ShapeSize 1Byte (100=100%)
        		"   G_CB_TempTable[12] : ",G_CB_TempTable[12],--Line 11 = Use Queue Option 1Byte
        		"   G_CB_TempTable[13] : ",G_CB_TempTable[13],--Line 12 SelectShapeNumber1 4Byte
        		"   G_CB_TempTable[14] : ",G_CB_TempTable[14],--Line 13 SelectShapeNumber2 4Byte
        		"   G_CB_TempTable[15] : ",G_CB_TempTable[15],--Line 14 SelectShapeNumber3 4Byte
        		"   G_CB_TempTable[16] : ",G_CB_TempTable[16],--Line 15 SelectShapeNumber4 4Byte
        		"   G_CB_TempTable[17] : ",G_CB_TempTable[17],--Line 16 Set Delay Timer 1 4Byte
        		"   G_CB_TempTable[18] : ",G_CB_TempTable[18],--Line 17 Set Delay Timer 2 4Byte
        		"   G_CB_TempTable[19] : ",G_CB_TempTable[19],--Line 18 Set Delay Timer 3 4Byte
        		"   G_CB_TempTable[20] : ",G_CB_TempTable[20],--Line 19 Set Delay Timer 4 4Byte
        	})

        	end
            CDoActions(FP,{
                TSetMemoryX(Vi(G_CB_TempH[2],0*(0x20/4)),SetTo,0,0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],1*(0x20/4)),SetTo,0,0xFF),
                TSetMemory(Vi(G_CB_TempH[2],2*(0x20/4)),SetTo,0),
                TSetMemory(Vi(G_CB_TempH[2],3*(0x20/4)),SetTo,0),
                TSetMemoryX(Vi(G_CB_TempH[2],4*(0x20/4)),SetTo,0,0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],5*(0x20/4)),SetTo,0,0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],6*(0x20/4)),SetTo,0,0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],9*(0x20/4)),SetTo,0,0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],10*(0x20/4)),SetTo,0,0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],11*(0x20/4)),SetTo,0,0xFF),
				TSetMemory(Vi(G_CB_TempH[2],12*(0x20/4)),SetTo,0),
				TSetMemory(Vi(G_CB_TempH[2],16*(0x20/4)),SetTo,0),
				TSetMemory(Vi(G_CB_TempH[2],20*(0x20/4)),SetTo,0),
            })
            CIf(FP,{TMemory(Vi(G_CB_TempH[2],0*(0x20/4)), Exactly, 0)})--G_CBPlot 데이터에 유닛아이디가 존재하지 않을경우 배열을 전부 초기화한다.
            local TActArr = {}
            for arr = 1, G_CB_Lines do
                if arr == 3 then
                    table.insert(TActArr, TSetMemory(Vi(G_CB_TempH[2],(arr-1)*(0x20/4)), SetTo, 1))
                else
                    table.insert(TActArr, TSetMemory(Vi(G_CB_TempH[2],(arr-1)*(0x20/4)), SetTo, 0))
                end
            end
            CDoActions(FP, TActArr)
            if TestStart == 1 then
            --DoActions(FP,{RotatePlayer({DisplayTextX(f_GunFuncT2,4)},HumanPlayers,FP)})
            end
            CIfEnd()
        CIfXEnd()
    CElseIfX({CVar(FP,G_CB_TempTable[1][2],AtMost,0,0xFF),CVar(FP,G_CB_TempTable[1][2],AtLeast,1)})
        CDoActions(FP,{

        TSetMemory(Vi(G_CB_TempH[2],0*(0x20/4)),SetTo,_rShift(G_CB_TempTable[1],8)),
        TSetMemory(Vi(G_CB_TempH[2],1*(0x20/4)),SetTo,_rShift(G_CB_TempTable[2],8)),
        TSetMemory(Vi(G_CB_TempH[2],2*(0x20/4)),SetTo,0),
        TSetMemory(Vi(G_CB_TempH[2],3*(0x20/4)),SetTo,0),
        TSetMemory(Vi(G_CB_TempH[2],4*(0x20/4)),SetTo,_rShift(G_CB_TempTable[5],8)),
        TSetMemory(Vi(G_CB_TempH[2],5*(0x20/4)),SetTo,_rShift(G_CB_TempTable[6],8)),
        TSetMemory(Vi(G_CB_TempH[2],6*(0x20/4)),SetTo,_rShift(G_CB_TempTable[7],8)),
        TSetMemory(Vi(G_CB_TempH[2],9*(0x20/4)),SetTo,_rShift(G_CB_TempTable[10],8)),
        TSetMemory(Vi(G_CB_TempH[2],10*(0x20/4)),SetTo,_rShift(G_CB_TempTable[11],8)),
        TSetMemory(Vi(G_CB_TempH[2],11*(0x20/4)),SetTo,_rShift(G_CB_TempTable[12],8)),
		TSetMemory(Vi(G_CB_TempH[2],12*(0x20/4)),SetTo,G_CB_TempTable[14]),
		TSetMemory(Vi(G_CB_TempH[2],13*(0x20/4)),SetTo,G_CB_TempTable[15]),
		TSetMemory(Vi(G_CB_TempH[2],14*(0x20/4)),SetTo,G_CB_TempTable[16]),
		TSetMemory(Vi(G_CB_TempH[2],15*(0x20/4)),SetTo,0),
		TSetMemory(Vi(G_CB_TempH[2],16*(0x20/4)),SetTo,G_CB_TempTable[18]),
		TSetMemory(Vi(G_CB_TempH[2],17*(0x20/4)),SetTo,G_CB_TempTable[19]),
		TSetMemory(Vi(G_CB_TempH[2],18*(0x20/4)),SetTo,G_CB_TempTable[20]),
		TSetMemory(Vi(G_CB_TempH[2],19*(0x20/4)),SetTo,0),
		TSetMemory(Vi(G_CB_TempH[2],20*(0x20/4)),SetTo,G_CB_TempTable[22]),
		TSetMemory(Vi(G_CB_TempH[2],21*(0x20/4)),SetTo,G_CB_TempTable[23]),
		TSetMemory(Vi(G_CB_TempH[2],22*(0x20/4)),SetTo,G_CB_TempTable[24]),
		TSetMemory(Vi(G_CB_TempH[2],23*(0x20/4)),SetTo,0),
    })
    CIfXEnd()
    DoActionsX(FP,{SetCDeaths(FP,SetTo,0,CA_Suspend),SetCDeaths(FP,SetTo,0,G_CB_Launch)})
SetCallEnd()
local Actived_G_CB = CreateVar(FP)
function Create_G_CB_Arr()
	if G_CB_Arr_IndexAlloc ~= StartIndex then PushErrorMsg("Already_G_CB_Arr_Created") end
	CMov(FP,Actived_G_CB,0)
	for i = 0, Size_of_G_CB_Arr-1 do
		CTrigger(FP, {CVar("X","X",AtLeast,1)}, {
			G_CB_InputCVar,
			SetCtrigX("X",G_CB_TempH[2],0x15C,0,SetTo,"X","X",0x15C,1,0),
			SetCVar(FP,G_CB_Num[2],SetTo,i+1),
			SetCVar(FP,Actived_G_CB[2],Add,1),
			SetNext("X",Call_G_CB,0),SetNext(Call_G_CB+1,"X",1), -- Call f_Gun
			SetCtrigX("X",Call_G_CB+1,0x158,0,SetTo,"X","X",0x4,1,0), -- RecoverNext
			SetCtrigX("X",Call_G_CB+1,0x15C,0,SetTo,"X","X",0,0,1), -- RecoverNext
			SetCtrig1X("X",Call_G_CB+1,0x164,0,SetTo,0x0,0x2) -- RecoverNext
		}, 1, G_CB_Arr_IndexAlloc)
		G_CB_Arr_IndexAlloc = G_CB_Arr_IndexAlloc + 1
	end
	--CMov(FP,0x57f0f0,Actived_G_CB)
end

end
    
