function f_SaveCp()
	CallTrigger(FP,SaveCp_CallIndex,nil)
end
function f_LoadCp()
	CallTrigger(FP,LoadCp_CallIndex,nil)
end

function f_Repeat(Line)
	TriggerX(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,0)},{SetCVar(FP,Var_TempTable[Line][2],SetTo,0)},{Preserved})
	CIf(FP,CVar(FP,Var_TempTable[Line][2],AtLeast,1))
		CMov(FP,Spawn_TempW,Var_TempTable[Line])
		CallTrigger(FP,Call_Repeat)
		CDoActions(FP,{TSetMemory(_Add(G_TempH,((Line-1)*0x20)/4),SetTo,Spawn_TempW)})
	CIfEnd()
end

function f_TempRepeat(UnitID,Number,Condition,Type)
	if Type == nil then Type = 0 end
	CallTriggerX(FP,Set_Repeat,Condition,{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,UnitID),SetCVar(FP,Repeat_TempV[2],SetTo,Number),SetCVar(FP,RepeatType[2],SetTo,Type)})
end
function f_TempRepeatX(UnitID,Number,Condition)
	CDoActions(FP,{TSetCVar(FP,Gun_TempSpawnSet1[2],SetTo,UnitID),TSetCVar(FP,Repeat_TempV[2],SetTo,Number)})
	CallTriggerX(FP,Set_Repeat,Condition)
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
function Install_CText1(StrPtr,CText1,CText2,PlayerVArr)

	f_MemCpy(FP,StrPtr,_TMem(Arr(CText1[3],0),"X","X",1),CText1[2]-3)
	f_MovCpy(FP,_Add(StrPtr,CText1[2]),VArr(PlayerVArr,0),4*6)
	f_MemCpy(FP,_Add(StrPtr,CText1[2]+(4*6)+3),_TMem(Arr(CText2[3],0),"X","X",1),CText2[2])

end


function CreateHeroPointArr(Index,Point,Name,Type) --  영작 유닛 설정 함수
	local TextType1 = "을(를) 처치하였다...! "
	local TextType2 = "를 획득하였다...! "
	local Name2
	if Type == 1 then
		Name2 = TextType1
	elseif Type == 2 then
		Name2 = TextType2
	
	elseif Type == nil then
		Name2 = nil
	else
		Need_Input_TextType()
	end
	local Text = "\x13\x04"..Name..""..Name2.."\x1F+ "..Point.." \x1CPoint \x07Get!"
	local X = {}
	table.insert(X,Text)
	table.insert(X,Index)
	table.insert(X,Point) -- HPoint
	table.insert(HeroPointArr,X)
end
function InstallHeroPoint() -- CreateHeroPointArr에서 전송받은 영웅 포인트 정보 설치 함수. CunitCtrig 단락에 포함됨.
	for i = 1, #HeroPointArr do
		local CT = HeroPointArr[i][1]
		local index = HeroPointArr[i][2]
		local Point = HeroPointArr[i][3]
			Trigger2(FP,{DeathsX(CurrentPlayer,Exactly,index,0,0xFF)},{
				SetScore(Force1,Add,Point,Kills);
				RotatePlayer({DisplayTextX(CT,4)},HumanPlayers,FP);
			},{Preserved})
			f_LoadCp()
			TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,index,0,0xFF),CDeaths(FP,AtMost,2,SoundLimit)},{
				RotatePlayer({PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg")},HumanPlayers,FP);
				SetCDeaths(FP,Add,1,SoundLimit),
			},{Preserved})
	end
end

function Install_DeathNotice()
	CIf(FP,DeathsX(CurrentPlayer,Exactly,10,0,0xFF))
		DoActions(FP,MoveCp(Subtract,6*4))
		for j = 1, 7 do
			CIf(FP,DeathsX(CurrentPlayer,Exactly,j-1,0,0xFF))
				f_SaveCp()
				Install_CText1(HTextStrPtr,Str12,Str01,Names[j])
				DoActionsX(FP,{
					RotatePlayer({DisplayTextX(HTextStr,4)},HumanPlayers,FP);
					SetScore(j-1,Add,1,Custom);
					SetCVar(FP,ExScore[j][2],Add,-50);
				})
				TriggerX(FP,{CDeaths(FP,AtMost,4,SoundLimit)},{RotatePlayer({PlayWAVX("staredit\\wav\\die_se.ogg")},HumanPlayers,FP),SetCDeaths(FP,Add,1,SoundLimit)},{Preserved})
				f_MemCpy(FP,HTextStrPtr,_TMem(Arr(HTextStrReset[3],0),"X","X",1),HTextStrReset[2])
				f_LoadCp()
			CIfEnd()
		end

		DoActions(FP,MoveCp(Add,6*4))
	CIfEnd()
	for j = 1, 7 do
	CIf(FP,DeathsX(CurrentPlayer,Exactly,MarID[j],0,0xFF))
		DoActions(FP,MoveCp(Subtract,6*4))
			CIf(FP,DeathsX(CurrentPlayer,Exactly,j-1,0,0xFF))
				f_SaveCp()
				Install_CText1(HTextStrPtr,Str12,Str02,Names[j])
				DoActionsX(FP,{
					RotatePlayer({DisplayTextX(HTextStr,4)},HumanPlayers,FP);
					SetScore(j-1,Add,1,Custom);
					SetCVar(FP,ExScore[j][2],Add,-500);
				})
				TriggerX(FP,{CDeaths(FP,AtMost,4,SoundLimit)},{RotatePlayer({PlayWAVX("staredit\\wav\\die_se.ogg")},HumanPlayers,FP),SetCDeaths(FP,Add,1,SoundLimit)},{Preserved})
				f_MemCpy(FP,HTextStrPtr,_TMem(Arr(HTextStrReset[3],0),"X","X",1),HTextStrReset[2])
				f_LoadCp()
			CIfEnd()
		DoActions(FP,MoveCp(Add,6*4))
CIfEnd()
end
end

function f_GSend(UnitID,Actions)
CallTriggerX(FP,G_Send,{DeathsX(CurrentPlayer,Exactly,UnitID,0,0xFF)},Actions)
end
function BGMManager()
	AddBGM(1,"staredit\\wav\\GRAVITY_OP.ogg",94*1000,{1,5})
	AddBGM(1,"staredit\\wav\\ExceedOP.ogg",99000,{6,10})
	AddBGM(2,"staredit\\wav\\BGM1_1.ogg",42*1000,{1,2})
	AddBGM(3,"staredit\\wav\\BGM1_2.ogg",47*1000,{1,2})
	AddBGM(4,"staredit\\wav\\BGM1_3.ogg",60*1000,{1,2})
	AddBGM(5,"staredit\\wav\\BGM1_4.ogg",60*1000,{1,2})
	AddBGM(2,"staredit\\wav\\BGM2_1.ogg",47*1000,{3,4})
	AddBGM(3,"staredit\\wav\\BGM2_2.ogg",60*1000,{3,4})
	AddBGM(4,"staredit\\wav\\BGM2_3.ogg",52230,{3,4})
	AddBGM(5,"staredit\\wav\\BGM2_4.ogg",58780,{3,4})
	AddBGM(2,"staredit\\wav\\BGM3_1.ogg",64*1000,{5,6})
	AddBGM(3,"staredit\\wav\\BGM3_2.ogg",63*1000,{5,6})
	AddBGM(4,"staredit\\wav\\BGM3_3.ogg",60*1000,{5,6})
	AddBGM(5,"staredit\\wav\\BGM3_4.ogg",71*1000,{5,6})
	AddBGM(2,"staredit\\wav\\BGM4_1.ogg",48*1000,{7,8})
	AddBGM(3,"staredit\\wav\\BGM4_2.ogg",53*1000,{7,8})
	AddBGM(4,"staredit\\wav\\BGM4_3.ogg",45*1000,{7,8})
	AddBGM(5,"staredit\\wav\\BGM4_4.ogg",53*1000,{7,8})
	AddBGM(2,"staredit\\wav\\BGM5_1.ogg",49*1000,{9,10})
	AddBGM(3,"staredit\\wav\\BGM5_2.ogg",48*1000,{9,10})
	AddBGM(4,"staredit\\wav\\BGM5_3.ogg",50*1000,{9,10})
	AddBGM(5,"staredit\\wav\\BGM5_4.ogg",59*1000,{9,10})

	
	roka7BGM = AddBGM(8,"staredit\\wav\\roka7boss.ogg",197*1000)
	IdenBGM = AddBGM(9,"staredit\\wav\\JinjinZzara.ogg",220*1000)
	Akasha = AddBGM(10,"staredit\\wav\\Akasha.ogg",262*1000)
	DLBossBGM = AddBGM(11,"staredit\\wav\\Lanterns.ogg",231*1000)
	
	CIf(FP,{CVar(FP,ReserveBGM[2],AtLeast,1),DeathsX(AllPlayers,AtMost,0,440,0xFFFFFF)})
		CMov(FP,BGMTypeV,ReserveBGM)
		CMov(FP,ReserveBGM,0)
		TriggerX(FP,{Bring(FP,AtLeast,1,87,64)},{SetCVar(FP,BGMTypeV[2],SetTo,roka7BGM),SetCVar(FP,ReserveBGM[2],SetTo,roka7BGM)},{Preserved})
		TriggerX(FP,{Bring(FP,AtLeast,1,68,64)},{SetCVar(FP,BGMTypeV[2],SetTo,IdenBGM),SetCVar(FP,ReserveBGM[2],SetTo,IdenBGM)},{Preserved})
		TriggerX(FP,{Bring(FP,AtLeast,1,15,64)},{SetCVar(FP,BGMTypeV[2],SetTo,Akasha),SetCVar(FP,ReserveBGM[2],SetTo,Akasha)},{Preserved})
		TriggerX(FP,{Bring(FP,AtLeast,1,74,64)},{SetCVar(FP,BGMTypeV[2],SetTo,DLBossBGM),SetCVar(FP,ReserveBGM[2],SetTo,DLBossBGM)},{Preserved})
	CIfEnd()
	Install_BGMSystem(FP,6,BGMTypeV)
end


function Install_RandPlaceHero()
	local RandW2 = CreateVar(FP)
	local HeroID = CreateVar(FP)
	local HPosX,HPosY = CreateVariables(2)
	DoActionsX(FP,SetCVar(FP,RandW[2],SetTo,40),1)
	CWhile(FP,CVar(FP,RandW[2],AtLeast,1),SetCVar(FP,RandW[2],Subtract,1))
		Check_Spawn = def_sIndex()
		NJumpXEnd(FP,Check_Spawn)
		f_Mod(FP,HPosX,_Rand(),_Mov(3072))
		f_Mod(FP,HPosY,_Rand(),_Mov(6144))
		NJumpX(FP,Check_Spawn,{CVar(FP,HPosX[2],AtLeast,320),CVar(FP,HPosX[2],AtMost,2752),CVar(FP,HPosY[2],AtLeast,5408)}) -- 좌표설정 실패, 다시
		Simple_SetLocX(FP,0,HPosX,HPosY,HPosX,HPosY,Simple_CalcLoc(0,-64,-64,64,64))
		Check_Cannot = def_sIndex()
		NJumpX(FP,Check_Cannot,{Memory(0x628438,Exactly,0)}) -- 캔낫. 강제캔슬
		CMov(FP,RandW2,6)
		CMov(FP,HeroID,VArr(HeroVArr,_Mod(_Rand(),_Mov(#HeroArr))))
		NWhile(FP,CVar(FP,RandW2[2],AtLeast,1),SetCVar(FP,RandW2[2],Subtract,1))
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			CDoActions(FP,{TCreateUnitWithProperties(1,HeroID,1,P8,{energy = 100})})
			NIfX(FP,{TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)}) -- 소환 성공 여부 
				CMov(FP,CunitIndex,_Div(_Sub(Nextptrs,19025),_Mov(84)))
				CTrigger(FP,{CVar(FP,Level[2],AtMost,10)},{TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(CC_Header,((0x20*8)/4))),SetTo,1)},1) -- 10레벨 이하는 영작포인트 적용됨
				f_Mod(FP,BiteCalc,HeroID,_Mov(2),0xFF)
				f_Read(FP,_Add(_Div(HeroID,_Mov(2)),_Mov(EPD(0x663EB8))),UnitPoint)
				NIfX(FP,{CVar(FP,BiteCalc[2],AtLeast,1)})
				CDiv(FP,UnitPoint,65536)
				NElseX()
				CMod(FP,UnitPoint,65536)
				NIfXEnd()
				CAdd(FP,InputPoint,UnitPoint)
				NElseX()
				NJumpX(FP,Check_Spawn) -- 소환실패, 다시
			NIfXEnd()
		NWhileEnd()
		NJumpXEnd(FP,Check_Cannot)
	CWhileEnd()
end


function Print13_NumSet(Ptr,Ptr2,DivNum,Mask)
	for i = 3, 0, -1 do
		Trigger {
			players = {FP},
			conditions = {
				Memory(Ptr,AtLeast,(2^i)*DivNum);
			},
			actions = {
				SetMemoryX(Ptr2,SetTo,(2^i)*Mask,2^i*Mask);
				SetMemory(Ptr,Subtract,(2^i)*DivNum);
				PreserveTrigger();
			}
		}
	end
end


function ValToTimeX(VIndex,DestPtr,DivNum,DestPlace)
	for i = 6, 0, -1 do
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				CVar(FP,VIndex,AtLeast,(2^i)*DivNum)
			},
			actions = {
				SetMemory(DestPtr,Add,(2^i)*DestPlace);
				SetCVar(FP,VIndex,Subtract,(2^i)*DivNum);
				PreserveTrigger();
			}
		}
	end
end

function EPDToPtr(EPD)
	return 0x58A364+(EPD*4)
end

function KetInput(Key,Conditions,Actions,PreserveFlag)
	X = {}
	if PreserveFlag == 1 then
		X = {Preserved}
	end
	TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,Key),Conditions},{SetDeaths(CurrentPlayer,SetTo,0,Key),Actions},X)
end

function Print13_Preserve()
	local Print13 = CreateCCode()
	CIf(FP,{Memory(0x628438, AtLeast, 1)})
		CIf(FP,CDeaths(FP,Exactly,0,Print13),SetCDeaths(FP,Add,88,Print13))
			Print_13(FP,{P1,P2,P3,P4,P5,P6,P7},nil)
		CIfEnd()
		DoActionsX(FP,SetCDeaths(FP,Subtract,1,Print13))
	CIfEnd()
end


function IBGM_EPDX(Player,MaxPlayer,MSQC_Recives,Option_NT)
	local Dx,Dy,Dv,Du,DtP = CreateVariables(5)
	
	f_Read(Player,0x51CE8C,Dx)
	CiSub(Player,Dy,_Mov(0xFFFFFFFF),Dx)
	CiSub(Player,DtP,Dy,Du)
	CMov(Player,Dv,DtP) 
	CMov(Player,0x58F500,DtP) -- MSQC val Send. 180
	CMov(Player,Du,Dy)
	

	if Option_NT ~= nil then
		if type(Option_NT) == "table" then
		CIf(FP,{NTCond2()})
			CMov(FP,Option_NT[1],MSQC_Recives)
		CIfEnd()
		CIf(FP,{NTCond()})
			CAdd(FP,Option_NT[2],MSQC_Recives,Option_NT[1])
		CIfEnd()
		else
			OPtion_NT_InputData_Error()
		end
	end


	for i = 0, MaxPlayer do
		CTrigger(Player,{PlayerCheck(i,1)},{TSetDeathsX(i,Subtract,MSQC_Recives,440,0xFFFFFF)},1) -- 브금타이머
	end
	CDoActions(Player,{TSetDeathsX(Player,Subtract,MSQC_Recives,440,0xFFFFFF)}) -- 브금타이머
end

function ObDisplay()
	local TempT = CreateVar(FP)
	CMov(FP,0x582144+(4*7),0)
	CMov(FP,0x5821A4+(4*7),0)
	CMov(FP,0x582174+(4*7),count)
	CAdd(FP,0x582174+(4*7),count)
	CMov(FP,0x57F120+(4*7),Level)
	CMov(FP,TempT,Time)
	
	CMov(FP,0x57F0F0+(4*7),0)
	ValToTimeX(TempT[2],0x57F0F0+(4*7),3600000,10000)
	ValToTimeX(TempT[2],0x57F0F0+(4*7),60000,100)
	ValToTimeX(TempT[2],0x57F0F0+(4*7),1000,1)
end

function DoPlayerCheck()
	
	DoActionsX(FP,{SetCDeaths(FP,SetTo,0,PCheck),SetCVar(FP,PCheckV[2],SetTo,0)})
	for i = 0, 6 do
		TriggerX(FP,{PlayerCheck(i,1)},{SetCDeaths(FP,Add,1,PCheck),SetCVar(FP,PCheckV[2],Add,1)},{Preserved})
	end
end

function UnitLimit(Player,UID,Limit,Text,ReturnResources)
	Trigger {
		players = {Player},
		conditions = {
			Bring(Player,AtLeast,Limit+1,UID,64);
			},
		
		actions = {
			KillUnitAt(1,UID,"Anywhere",Player);
			DisplayText("\x07『 \x04"..Text.." "..Limit.."기를 넘어서 소지할 수 없습니다. \x1C자원 반환 \x1F+ "..ReturnResources.." Ore\x07 』",4);
			SetResources(Player,Add,ReturnResources,Ore);
			PreserveTrigger();
		},
	}
end


function GunBreak(GName,Point)
	local Text = "\n\n\n\x13- \x0E- \x0F-\x11 Ｓｔｒｕｃｔｕｒｅ \x04－ "..GName.." \x04 파괴!! \x1F+ "..Point.." P t s \x11- \x0E- \x0F-\n"
	DoActions(FP,{
		RotatePlayer({DisplayTextX(Text,4),PlayWAVX("staredit\\wav\\SpeedMessage.wav"),PlayWAVX("staredit\\wav\\SpeedMessage.wav"),PlayWAVX("staredit\\wav\\SpeedMessage.wav")},HumanPlayers,FP);
		SetScore(Force1,Add,Point,Kills);
	})
end
function Gun_DoSuspend()
	return TSetMemory(_Add(G_TempH,(54*0x20)/4),Add,1)
end


function f_CRandNum(Max,Operand)
	if Operand == nil then Operand = 0 end
	local RandRet = TempRandRet
	CallTrigger(FP,CRandNum,{SetCVar(FP,InputMaxRand[2],SetTo,Max),SetCVar(FP,Oprnd[2],SetTo,Operand)})
	return RandRet
end

function Gun_SetLine(Line,Type,Value,Mask)
	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	return TSetMemoryX(_Add(G_TempH,(Line*0x20)/4),Type,Value,Mask)
end


function Gun_SetLineX(Line,Type,Value)
	return TSetMemory(_Add(G_TempH,_Mul(Line,_Mov(0x20/4))),Type,Value)
end

function Gun_Line(Line,Type,Value,Mask)
	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	return CVar(FP,Var_TempTable[Line+1][2],Type,Value,Mask)
end

function Create_SortTable(Shape)
	local X = {}
	if type(Shape[1]) == "number" then
		table.insert(X,CS_SortX(Shape,0))
		table.insert(X,CS_SortX(Shape,1))
		table.insert(X,CS_SortY(Shape,0))
		table.insert(X,CS_SortY(Shape,1))
		table.insert(X,CS_SortR(Shape,0))
		table.insert(X,CS_SortR(Shape,1))
		table.insert(X,CS_SortA(Shape,0))
		table.insert(X,CS_SortA(Shape,1))
		table.insert(X,CS_DoubleSortRA(Shape,32,0,0))
		table.insert(X,CS_DoubleSortRA(Shape,32,0,1))
		table.insert(X,CS_DoubleSortRA(Shape,32,1,0))
		table.insert(X,CS_DoubleSortRA(Shape,32,1,1))
	else
		for j, k in pairs(Shape) do
			table.insert(X,CS_SortX(k,0))
			table.insert(X,CS_SortX(k,1))
			table.insert(X,CS_SortY(k,0))
			table.insert(X,CS_SortY(k,1))
			table.insert(X,CS_SortR(k,0))
			table.insert(X,CS_SortR(k,1))
			table.insert(X,CS_SortA(k,0))
			table.insert(X,CS_SortA(k,1))
			table.insert(X,CS_DoubleSortRA(k,32,0,0))
			table.insert(X,CS_DoubleSortRA(k,32,0,1))
			table.insert(X,CS_DoubleSortRA(k,32,1,0))
			table.insert(X,CS_DoubleSortRA(k,32,1,1))
		end

	end
	return X
end



function T_to_BiteBuffer(Table)
	local BiteValue = 0
	if type(Table) == "table" then
		local ret = 0
		if #Table >= 5 then
			BiteStack_is_Over_5()
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
function LvT(Type,Value)
	return CVar(FP,LevelT[2],Type,Value)
end
function NormalTurboSet(Player,DeathUnitID)
	local NTUID = DeathUnitID
	DoActions(Player,SetDeaths(Player,Add,1,DeathUnitID))
	Trigger2(Player,{Deaths(Player,AtLeast,2,DeathUnitID)},{SetDeaths(Player,SetTo,0,DeathUnitID)},{Preserved})
	
	function NTCond()
		return Deaths(Player,Exactly,1,NTUID)
	end
	function NTCond2()
		return Deaths(Player,Exactly,0,NTUID)
	end
end
function Install_GetCLoc(TriggerPlayer,TempLoc,TempUnit) -- TempLoc = 안쓰거나 자주 바뀌는 로케이션, TempUnit = 안쓰는 유닛. Unused 가능 아마?
	local TempLocID, TempLoc = ConvertLocation(TempLoc)
	local PlayerID = TriggerPlayer
	local RetX = CreateVar(FP)
	local RetY = CreateVar(FP)
	local Call_GetCLoc = SetCallForward()
	SetCall(PlayerID)
	f_Read(PlayerID,0x58DC60+0x14*TempLocID,RetX,"X",0xFFFFFFFF)
	f_Read(PlayerID,0x58DC64+0x14*TempLocID,RetY,"X",0xFFFFFFFF)
	SetCallEnd()
 
	function GetLocCenter(Location,DestX,DestY)
		
		local Location2, Location = ConvertLocation(Location)

		CallTrigger(PlayerID,Call_GetCLoc,{Simple_SetLoc(TempLocID,0,0,0,0),MoveLocation(TempLoc, TempUnit, PlayerID, Location)})
		CMov(PlayerID,DestX,RetX)
		CMov(PlayerID,DestY,RetY)
	end
	function SetLocCenter(Location,DestLocation)
		local Location2, Location = ConvertLocation(Location)
		CallTrigger(PlayerID,Call_GetCLoc,{Simple_SetLoc(TempLocID,0,0,0,0),MoveLocation(TempLoc, TempUnit, PlayerID, Location)})
		
		local DestLocId, DestLocation = ConvertLocation(DestLocation)

		Simple_SetLocX(PlayerID,DestLocId,RetX,RetY,RetX,RetY)
	end
	function SetLocCenter2(Location) -- TempLoc를 Location으로 이동시키기만 함. Call이 필요없음. TempLoc만 사용해도 될 경우 이걸 써도 됨
	
		local Location2, Location = ConvertLocation(Location)
		DoActions(PlayerID,{Simple_SetLoc(TempLocID,0,0,0,0),MoveLocation(TempLoc, TempUnit, PlayerID, Location)})
	end
end

function CArrSizeConvert(Size)
	local TNum = Size/602
	if Size%602 ~= 0 then
		TNum = TNum + 1
	end
	return TNum
end
function Convert_CPosXY(Value)
	if Value ~= nil then
	CDoActions(FP,{
		TSetCVar(FP,CPos[2],SetTo,Value),
		SetNext("X",Call_CPosXY,0),SetNext(Call_CPosXY+1,"X",1)
	})
	else
		CallTrigger(FP,Call_CPosXY)
	end
	return CPosX,CPosY
end