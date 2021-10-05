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
function f_TempRepeatX(UnitID,Number,Condition,Type)
	if Type == nil then Type = 0 end
	CDoActions(FP,{TSetCVar(FP,Gun_TempSpawnSet1[2],SetTo,UnitID),TSetCVar(FP,Repeat_TempV[2],SetTo,Number),SetCVar(FP,RepeatType[2],SetTo,Type)})
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
			CIf(FP,DeathsX(CurrentPlayer,Exactly,index,0,0xFF),SetScore(Force1,Add,Point,Kills))
			for i = 0, 6 do
				TriggerX(FP,{CDeaths(FP,Exactly,0,HeroPointNotice[i+1])},{
					SetMemory(0x6509B0,SetTo,i),
					DisplayText(CT,4);
					SetMemory(0x6509B0,SetTo,FP),
				},{Preserved})
				TriggerX(FP,{CDeaths(FP,AtMost,2,SoundLimit[i+1]),CDeaths(FP,Exactly,0,HeroPointNotice[i+1])},{
					SetMemory(0x6509B0,SetTo,i),
					PlayWAV("staredit\\wav\\HeroKill.ogg"),PlayWAV("staredit\\wav\\HeroKill.ogg");DisplayText(CT,4);
					SetMemory(0x6509B0,SetTo,FP),
					SetCDeaths(FP,Add,1,SoundLimit[i+1]),
				},{Preserved})
			end
			CIfEnd()
			

			f_LoadCp()
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
					SetScore(j-1,Add,50,Custom);
					SetCVar(FP,ExScore[j][2],Add,-50);
				})
				for k = 0, 6 do
					TriggerX(FP,{CDeaths(FP,AtMost,4,SoundLimit[k])},{SetMemory(0x6509B0,SetTo,i),PlayWAV("staredit\\wav\\die_se.ogg"),SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,Add,1,SoundLimit[k])},{Preserved})
				end
				f_MemCpy(FP,HTextStrPtr,_TMem(Arr(HTextStrReset[3],0),"X","X",1),HTextStrReset[2])
				f_LoadCp()
			CIfEnd()
		end
		DoActions(FP,MoveCp(Add,6*4))
	CIfEnd()
	
	CIf(FP,DeathsX(CurrentPlayer,Exactly,12,0,0xFF))
		DoActions(FP,MoveCp(Subtract,6*4))
		for j = 1, 7 do
			CIf(FP,DeathsX(CurrentPlayer,Exactly,j-1,0,0xFF))
				f_SaveCp()
				Install_CText1(HTextStrPtr,Str12,Str03,Names[j])
				DoActionsX(FP,{
					RotatePlayer({DisplayTextX(HTextStr,4)},HumanPlayers,FP);
					SetScore(j-1,Add,10000,Custom);
					SetCVar(FP,ExScore[j][2],Add,-10000);
				})
				for k = 0, 6 do
					TriggerX(FP,{CDeaths(FP,AtMost,4,SoundLimit[k])},{SetMemory(0x6509B0,SetTo,i),PlayWAV("staredit\\wav\\die_se.ogg"),SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,Add,1,SoundLimit[k])},{Preserved})
				end
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
					SetScore(j-1,Add,500,Custom);
					SetCVar(FP,ExScore[j][2],Add,-500);
				})
				for k = 0, 6 do
					TriggerX(FP,{CDeaths(FP,AtMost,4,SoundLimit[k])},{SetMemory(0x6509B0,SetTo,i),PlayWAV("staredit\\wav\\die_se.ogg"),SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,Add,1,SoundLimit[k])},{Preserved})
				end
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
	AddBGM(2,"staredit\\wav\\BGM3_1.ogg",35*1000,{5,6})
	AddBGM(3,"staredit\\wav\\BGM3_2.ogg",63*1000,{5,6})
	AddBGM(4,"staredit\\wav\\BGM3_3.ogg",62*1000,{5,6})
	AddBGM(5,"staredit\\wav\\BGM3_4.ogg",66*1000,{5,6})
	AddBGM(2,"staredit\\wav\\BGM4_1.ogg",48*1000,{7,8})
	AddBGM(3,"staredit\\wav\\BGM4_2.ogg",60*1000,{7,8})
	AddBGM(4,"staredit\\wav\\BGM4_3.ogg",52*1000,{7,8})
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
	DoActionsX(FP,SetCVar(FP,RandW[2],SetTo,100),1)
	CWhile(FP,CVar(FP,RandW[2],AtLeast,1),SetCVar(FP,RandW[2],Subtract,1))
		Check_Spawn = def_sIndex()
		NJumpXEnd(FP,Check_Spawn)
		f_Mod(FP,HPosX,_Rand(),_Mov(3072))
		f_Mod(FP,HPosY,_Rand(),_Mov(6144))
		NJumpX(FP,Check_Spawn,{CVar(FP,HPosX[2],AtLeast,320),CVar(FP,HPosX[2],AtMost,2752),CVar(FP,HPosY[2],AtLeast,4480)}) -- 좌표설정 실패, 다시
		Simple_SetLocX(FP,0,HPosX,HPosY,HPosX,HPosY,Simple_CalcLoc(0,-64,-64,64,64))
		Check_Cannot = def_sIndex()
		NJumpX(FP,Check_Cannot,{Memory(0x628438,Exactly,0)}) -- 캔낫. 강제캔슬
		CMov(FP,RandW2,6)
		CMov(FP,HeroID,VArr(HeroVArr,_Mod(_Rand(),_Mov(#HeroArr))))
		NWhile(FP,CVar(FP,RandW2[2],AtLeast,1),SetCVar(FP,RandW2[2],Subtract,1))
			NJumpX(FP,Check_Cannot,{Memory(0x628438,Exactly,0)}) -- 캔낫. 강제캔슬
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			CDoActions(FP,{TCreateUnitWithProperties(1,HeroID,1,P8,{energy = 100})})
			NIfX(FP,{TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)}) -- 소환 성공 여부 
				CMov(FP,CunitIndex,_Div(_Sub(Nextptrs,19025),_Mov(84)))
				--CTrigger(FP,{CVar(FP,Level[2],AtMost,10)},{TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(CC_Header,((0x20*8)/4))),SetTo,1)},1) -- 10레벨 이하는 영작포인트 적용됨
				CTrigger(FP,{},{TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(CC_Header,((0x20*8)/4))),SetTo,1)},1) -- 
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

function KeyInput(Key,Conditions,Actions,PreserveFlag,CutFlag)
	X = {}
	Y = SetDeaths(CurrentPlayer,SetTo,0,Key)
	if CutFlag == 1 then Y = {} end
	if PreserveFlag == 1 then
		X = {Preserved}
	end
	TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,Key),Conditions},{Y,Actions},X)
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
function Print13_Preserve()
	local Print13 = CreateCCode()
		CIf(FP,CDeaths(FP,Exactly,0,Print13),SetCDeaths(FP,Add,88,Print13))
			for i = 0, 6 do
				CallTriggerX(FP,Call_Print13[i+1],{PlayerCheck(i,1),Deaths(i,AtMost,0,15)})
			end
		CIfEnd()
		for i = 0, 6 do
			CIf(FP,PlayerCheck(i,1))
			for j = 0, 5 do
			CallTriggerX(FP,Call_Print13[i+1],{Deaths(i,AtLeast,1,190+j)})
			end
			CIfEnd()
		end
		
		DoActionsX(FP,SetCDeaths(FP,Subtract,1,Print13))
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


function GunBreak(GName,Point,Flag)
	local Text = "\n\n\n\x13- \x0E- \x0F-\x11 Ｓｔｒｕｃｔｕｒｅ \x04－ "..GName.." \x04 파괴!! \x1F+ "..Point.." P t s \x11- \x0E- \x0F-\n"
	if Flag == 1 then
		DoActions(FP,{
			RotatePlayer({DisplayTextX(Text,4)},HumanPlayers,FP);
			SetScore(Force1,Add,Point,Kills);
	
		})
	else
		DoActions(FP,{
			RotatePlayer({DisplayTextX(Text,4),PlayWAVX("staredit\\wav\\SpeedMessage.wav")},HumanPlayers,FP);
			SetScore(Force1,Add,Point,Kills);
	
		})
	end
end
function Gun_DoSuspend()
	return TSetMemory(_Add(G_TempH,(54*0x20)/4),Add,1)
end


function f_CRandNum(Max,Operand,Condition)
	if Operand == nil then Operand = 0 end
	local RandRet = TempRandRet
	CallTriggerX(FP,CRandNum,Condition,{SetCVar(FP,InputMaxRand[2],SetTo,Max),SetCVar(FP,Oprnd[2],SetTo,Operand)})
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


function SetCVar(Player,Index,Type,Value,Mask)
	if type(Index) == "table" and Index[4] == "V" then
		Index = Index[2]
	end
	return SetVariableX(Player,Index,"Value",Type,Value,Mask)
end

function CVar(Player,Index,Type,Value,Mask)
	if type(Index) == "table" and Index[4] == "V" then
		Index = Index[2]
	end
	return VariableX(Player,Index,"Value",Type,Value,Mask)
end


	

-- function CAfunc(Table) local CA = CAPlotDataArr -- Custom Code Section -- end
function CAPlot2(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CAfunc,PlayerID,Condition,PerAction,Preserve,CAfunc2)
	if Shape == nil then
		CS_InputError()
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
				Trigger2X(PlayerID,CVar("X",CA[1],Exactly,i),TempAct[i],{Preserved})
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
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},SetCVar("X",CA[6],SetTo,1),{Preserved})
		else
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},{SetCVar("X",CA[6],SetTo,1),Preserve},{Preserved})
		end
	end
	local Ret = {CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3]}
	CAPlotCreateArr = {}
	CAPlotDataArr = {}
	CAPlotPlayerID = {}
	return Ret
end
	function G_CAPlot(ShapeTable)
		local X = {}
		local Y = {}
		if type(ShapeTable) == "table" then
			for i = 1, #ShapeTable do
				if type(ShapeTable[i]) ~= "string" then
					G_CAPlot_InputData_Error()
				else
					ShapeTable[i] = _G[ShapeTable[i]]
				end
			end
		elseif type(ShapeTable) ~= "string" then
			G_CAPlot_InputData_Error()
		else
			table.insert( X,ShapeTable)
			ShapeTable = _G[ShapeTable]
		end
		local G_CA_CallIndex = SetCallForward()
		Another_CAPlot_Shape = G_CA_IndexAlloc
		local CA = CAPlotForward()
		SetCall(FP)
		CMov(FP,CA_TempUID,G_CA_Main[1],nil,0xFF)
		CMov(FP,V(CA[1]),G_CA_Main[2],nil,0xFF)
		CMov(FP,V(CA[6]),G_CA_Main[3])

		CIfX(FP,CVar(FP,G_CA_Main[5][2],AtMost,0))
		if type(ShapeTable[1]) == "number" then
			CTrigger(FP,{},{SetCVar(FP,CA[5],SetTo,(ShapeTable[1]/50)+1)},1)
		else
			for j, k in pairs(ShapeTable) do
				CTrigger(FP,{CVar(FP,G_CA_Main[2][2],Exactly,j,0xFF)},{SetCVar(FP,CA[5],SetTo,(k[1]/50)+1)},1)
				table.insert(Y,tostring(j))
			end
		end
		CElseX()
			CMov(FP,V(CA[5]),G_CA_Main[5])
		CIfXEnd()

		CAPlot(ShapeTable,FP,nilunit,0,{0,0},1,32,{0,0,0,0,0,1},nil,FP,nil,nil,{SetCDeaths(FP,Add,1,CA_Suspend)},"CA_Repeat")
		CDoActions(FP,{TSetCVar(FP,G_CA_Main[3][2],SetTo,V(CA[6]))})
		SetCallEnd()
		G_CA_IndexAlloc = G_CA_IndexAlloc + 1
		table.insert(G_CA_CallStack,G_CA_CallIndex)
	end

	function CXPlot2(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CXfunc,PlayerID,Condition,PerAction,Preserve,CXfunc2)
		if Shape == nil then
			CX_InputError()
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
					Trigger2X(PlayerID,CVar("X",CA[1],Exactly,i),TempAct[i],{Preserved})
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
				CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},SetCVar("X",CA[6],SetTo,1),{Preserved})
			else
				CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},{SetCVar("X",CA[6],SetTo,1),Preserve},{Preserved})
			end
		end
		local Ret = {CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3]}
		CAPlotCreateArr = {}
		CAPlotDataArr = {}
		CAPlotPlayerID = {}
		return Ret
	end
	
function CunitCtrig_Part4_EX(LoopIndex,Conditions,Actions,ExCunitArr)
	MoveCpValue = 0
	local X = {}
	for k, v in pairs(ExCunitArr) do
		table.insert(X,SetCVar("X",v[2],SetTo,0))
	end
	Trigger { -- Cunit Calc Main
		players = {ParsePlayer(PlayerID)},
		conditions = { 
			Label(0);
			Conditions,
		},
		actions = {
			X,
			SetCtrigX("X","X",0x4,0,SetTo,"X",CCArr[CCptr],0,0,0);
			SetCtrigX("X",CCArr[CCptr]+1,0x4,0,SetTo,"X","X",0,0,1);
			SetCtrigX("X",CCArr[CCptr],0x158,0,SetTo,"X","X",0x4,1,0);
			SetCtrigX("X",CCArr[CCptr],0x15C,0,SetTo,"X","X",0,0,1);
			SetMemory(0x6509B0,SetTo,19025 + 84 * LoopIndex);
			Actions,
			},
		flag = {Preserved}
	}		
end