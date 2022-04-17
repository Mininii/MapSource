function f_SaveCp()
	CallTrigger(FP,SaveCp_CallIndex,nil)
end
function f_LoadCp()
	CallTrigger(FP,LoadCp_CallIndex,nil)
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

	f_Memcpy(FP,StrPtr,_TMem(Arr(CText1[3],0),"X","X",1),CText1[2])
	f_Movcpy(FP,_Add(StrPtr,CText1[2]),VArr(PlayerVArr,0),4*6)
	f_Memcpy(FP,_Add(StrPtr,CText1[2]+(4*6)),_TMem(Arr(CText2[3],0),"X","X",1),CText2[2])

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
		PushErrorMsg("Need_Input_TextType")
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
				},{preserved})
				TriggerX(FP,{CDeaths(FP,AtMost,2,SoundLimit[i+1]),CDeaths(FP,Exactly,0,HeroPointNotice[i+1])},{
					SetMemory(0x6509B0,SetTo,i),
					PlayWAV("staredit\\wav\\HeroKill.ogg"),PlayWAV("staredit\\wav\\HeroKill.ogg");
					SetMemory(0x6509B0,SetTo,FP),
					SetCDeaths(FP,Add,1,SoundLimit[i+1]),
				},{preserved})
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
					TriggerX(FP,{CDeaths(FP,AtMost,4,SoundLimit[k+1])},{SetMemory(0x6509B0,SetTo,k),PlayWAV("staredit\\wav\\die_se.ogg"),SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,Add,1,SoundLimit[k+1])},{preserved})
				end
				f_Memcpy(FP,HTextStrPtr,_TMem(Arr(HTextStrReset[3],0),"X","X",1),HTextStrReset[2])
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
					SetScore(j-1,Add,1000,Custom);
					SetCVar(FP,ExScore[j][2],Add,-1000);
				})
				for k = 0, 6 do
					TriggerX(FP,{CDeaths(FP,AtMost,4,SoundLimit[k+1])},{SetMemory(0x6509B0,SetTo,k),PlayWAV("staredit\\wav\\die_se.ogg"),SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,Add,1,SoundLimit[k+1])},{preserved})
				end
				f_Memcpy(FP,HTextStrPtr,_TMem(Arr(HTextStrReset[3],0),"X","X",1),HTextStrReset[2])
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
					TriggerX(FP,{CDeaths(FP,AtMost,4,SoundLimit[k+1])},{SetMemory(0x6509B0,SetTo,k),PlayWAV("staredit\\wav\\die_se.ogg"),SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,Add,1,SoundLimit[k+1])},{preserved})
				end
				f_Memcpy(FP,HTextStrPtr,_TMem(Arr(HTextStrReset[3],0),"X","X",1),HTextStrReset[2])
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
	AddBGM(2,"staredit\\wav\\BGM2_1.ogg",43*1000,{3,4})
	AddBGM(3,"staredit\\wav\\BGM2_2.ogg",67*1000,{3,4})
	AddBGM(4,"staredit\\wav\\BGM2_3.ogg",58*1000,{3,4})
	AddBGM(5,"staredit\\wav\\BGM2_4.ogg",73*1000,{3,4})
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
	
	CIf(FP,{CVar(FP,ReserveBGM[2],AtLeast,1),DeathsX(AllPlayers,AtMost,0,12,0xFFFFFF)})
		CMov(FP,BGMTypeV,ReserveBGM)
		CMov(FP,ReserveBGM,0)
		TriggerX(FP,{Bring(FP,AtLeast,1,87,64)},{SetCVar(FP,BGMTypeV[2],SetTo,roka7BGM),SetCVar(FP,ReserveBGM[2],SetTo,roka7BGM)},{preserved})
		TriggerX(FP,{Bring(FP,AtLeast,1,68,64)},{SetCVar(FP,BGMTypeV[2],SetTo,IdenBGM),SetCVar(FP,ReserveBGM[2],SetTo,IdenBGM)},{preserved})
		TriggerX(FP,{Bring(FP,AtLeast,1,15,64)},{SetCVar(FP,BGMTypeV[2],SetTo,Akasha),SetCVar(FP,ReserveBGM[2],SetTo,Akasha)},{preserved})
		TriggerX(FP,{Bring(FP,AtLeast,1,74,64)},{SetCVar(FP,BGMTypeV[2],SetTo,DLBossBGM),SetCVar(FP,ReserveBGM[2],SetTo,DLBossBGM)},{preserved})
	CIfEnd()
	Install_BGMSystem(FP,6,BGMTypeV,12,1)
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
				CTrigger(FP,{},{Set_EXCC2(DUnitCalc, CunitIndex, 8, SetTo,1)},1) -- 
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
	local X = {}
	local Y = {}
	if CutFlag ~= 1 then 
		Y = {SetDeaths(KeyCP,SetTo,0,Key)}
	end
	if PreserveFlag == 1 then
		X = {preserved}
	end
	TriggerX(FP,{Deaths(KeyCP,AtLeast,1,Key),Conditions},{Y,Actions},X)
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
	local Print13 = CreateCcode()
		CIf(FP,CDeaths(FP,Exactly,0,Print13),SetCDeaths(FP,Add,88,Print13))
			for i = 0, 6 do
				CallTriggerX(FP,Call_Print13[i+1],{HumanCheck(i,1),Deaths(i,AtMost,0,15)})
			end
		CIfEnd()
		for i = 0, 6 do
			CIf(FP,{HumanCheck(i,1),Deaths(i,AtMost,0,202)})
			for j = 0, 12 do
			CallTriggerX(FP,Call_Print13[i+1],{Switch("Switch 240",Set);Deaths(i,AtLeast,1,100+j)})
			end
			CallTriggerX(FP,Call_Print13[i+1],{Switch("Switch 240",Set);Deaths(i,AtLeast,1,114)})
--			CallTriggerX(FP,Call_Print13[i+1],{Switch("Switch 240",Set);Deaths(i,AtLeast,1,150)})
			
			for j = 0, 6 do
				CallTriggerX(FP,Call_Print13[i+1],{CDeaths(FP,AtLeast,1,GivePChange[i+1]),Switch("Switch 240",Set);Deaths(i,AtLeast,1,212+j)})
			end
			CallTriggerX(FP,Call_Print13[i+1],{CDeaths(FP,AtMost,0,GivePChange[i+1]),Switch("Switch 240",Set);Deaths(i,AtLeast,1,219)})
			
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
			PushErrorMsg("OPtion_NT_InputData_Error")
		end
	end


	for i = 0, MaxPlayer do
		CTrigger(Player,{HumanCheck(i,1)},{TSetDeathsX(i,Subtract,MSQC_Recives,12,0xFFFFFF)},1) -- 브금타이머
	end
	CDoActions(Player,{TSetDeathsX(Player,Subtract,MSQC_Recives,12,0xFFFFFF),SetDeathsX(Player,SetTo,0,12,0xFF000000)}) -- 브금타이머
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

function DoHumanCheck()
	
	DoActionsX(FP,{SetCDeaths(FP,SetTo,0,PCheck),SetCVar(FP,PCheckV[2],SetTo,0)})
	for i = 0, 6 do
		TriggerX(FP,{HumanCheck(i,1)},{SetCDeaths(FP,Add,1,PCheck),SetCVar(FP,PCheckV[2],Add,1)},{preserved})
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
	return Gun_SetLine(54,SetTo,1)
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
	return SetCVar(FP,Var_TempTable[Line+1][2],Type,Value,Mask)
end



function Gun_SetLineX(Line,Type,Value,Mask)
	return TSetCVar(FP,Var_TempTable[Line+1][2],Type,Value,Mask)
end

function Gun_Line(Line,Type,Value,Mask)
	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	return CVar(FP,Var_TempTable[Line+1][2],Type,Value,Mask)
end

function LvT(Type,Value)
	return CVar(FP,LevelT[2],Type,Value)
end
function NormalTurboSet(Player,DeathUnitID)
	local NTUID = DeathUnitID
	DoActions(Player,SetDeaths(Player,Add,1,DeathUnitID))
	Trigger2(Player,{Deaths(Player,AtLeast,2,DeathUnitID)},{SetDeaths(Player,SetTo,0,DeathUnitID)},{preserved})
	
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
		flag = {preserved}
	}		
end


	--0x590004~0x591FE4 PEUD Area UnitID : 494~664
StartPEUDValue = 494
function CreatePEUD()
	if StartPEUDValue >= 665 then PushErrorMsg("PEUD Has OverFlowed") end
	local Ret = StartPEUDValue
	StartPEUDValue = StartPEUDValue+1
	return Ret
end



function Include_G_CB_Library(StartIndex,G_CB_ArrSize,G_CB_Lines,DefCenterXYV,TRefeatXYV,ShapeTable,LoopMaxTable)
	if FP == nil then PushErrorMsg("Need_Define_Fixed_Player ( ex : FP = P8 )") end
local f_RepeatTypeErr = "\x07『 \x08ERROR : \x04잘못된 RepeatType이 입력되었습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
local f_RepeatErr = "\x07『 \x08ERROR : \x04f_Repeat에서 문제가 발생했습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
local f_RepeatErr2 = "\x07『 \x08ERROR : \x04Call_Repeat에서 잘못된 UnitID(0)을 입력받았습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
local f_GunSendErrT = "\x07『 \x08ERROR \x04: G_CB_SpawnSet 목록이 가득 차 데이터를 입력하지 못했습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
local G_CB_PosErr = "\x07『 \x03CAUCTION : \x04생성 좌표가 맵 밖을 벗어났습니다.\x07 』"
local f_GunErrT = "\x07『 \x08ERROR \x04: G_CBPlot Not Found. \x07』"
local f_GunErrT2 = "\x07『 \x08ERROR \x04: G_CBPlot Suspend Error. \x07』"
local f_GunFuncT = "\x07『 \x03TESTMODE OP \x04: G_CBPlot Suspended. \x07』"
local f_GunFuncT2 = "\x07『 \x03TESTMODE OP \x04: G_CBPlot Sended. \x07』"
local Repeat_UnitIDV = CreateVar(FP)
local RepeatType = CreateVar(FP)
local G_CB_Nextptrs = CreateVar(FP)
local Spawn_TempW = CreateVar(FP)
local CreatePlayer = CreateVar(FP)
local G_CB_LineV = CreateVar(FP)
local G_CB_CUTV = CreateVar(FP)
local G_CB_SNTV = CreateVarArr(4,FP)
local G_CB_DLTV = CreateVar(FP)
local G_CB_LMTV = CreateVar(FP)
local G_CB_RPTV = CreateVar(FP)
local G_CB_Owner = CreateVar(FP)
local G_CB_EffType = CreateVar(FP)
local G_CB_XPos = CreateVar(FP)
local G_CB_YPos = CreateVar(FP)
local G_CB_FNTV = CreateVar(FP)
local TRepeatX = TRefeatXYV[1]
local TRepeatY = TRefeatXYV[2]
local G_CB_CenterX = DefCenterXYV[1]
local G_CB_CenterY = DefCenterXYV[2]

local G_CB_UnitIndex = CreateVar(FP)
local Write_SpawnSet_Jump = def_sIndex()
local G_CB_Arr_IndexAlloc = StartIndex
local G_CB_TempTable = CreateVarArr(G_CB_Lines,FP)
local G_CB_InputH = CreateVar(FP)
local G_CB_InputCVar = {}
for i = 1, G_CB_Lines do
	table.insert(G_CB_InputCVar,SetCVar(FP,G_CB_TempTable[i][2],SetTo,0))
end
table.insert(CtrigInitArr[FP+1],SetCtrigX(FP,G_CB_InputH[2],0x15C,0,SetTo,FP,StartIndex,0x15C,1,0))
local G_CB_TempH = CreateVar(FP)
local G_CB_Num = CreateVar(FP)
local G_CB_LineTemp = CreateVar(FP)
local CB_Repeat_Check = CreateCcode()
local Repeat_X = CreateVar(FP)
local Repeat_Y = CreateVar(FP)
local G_CB_WSTestStrPtr = CreateVar(FP)
local G_CB_WSTestVA = CreateVArr(5,FP)



local CheckTemp = CreateVar(FP)
local isScore = CreateCcode()
local Call_Repeat = SetCallForward()
SetCall(FP)
--RandZ = 227
--CIfX(FP,CVar(FP,Repeat_UnitIDV[2],Exactly,RandZ,0xFF))
--local RetRand = f_CRandNum(#ZergGndUArr,0)
--CMovX(FP,Repeat_UnitIDV,VArr(ZergGndVArr,RetRand),nil,0xFF)
--CIfXEnd()
CWhile(FP,{Memory(0x628438,AtLeast,1),CVar(FP,Spawn_TempW[2],AtLeast,1)})
	CIf(FP,{TTOR({CVar(FP,RepeatType[2],Exactly,0),CVar(FP,RepeatType[2],Exactly,4)})})
		local Gun_Order = def_sIndex()
		CJumpXEnd(FP,Gun_Order)
		f_Mod(FP,Gun_TempRand,_Rand(),_Mov(7))
		for i = 0, 6 do
			NIf(FP,{CVar(FP,Gun_TempRand[2],Exactly,i),HumanCheck(i,0)})
				CJumpX(FP,Gun_Order)
			NIfEnd()
		end
		CIf(FP,CDeaths(FP,AtLeast,1,PCheck))
		for i = 0, 6 do
			CIf(FP,{CVar(FP,BarrackPtr[i+1][2],AtLeast,1),CVar(FP,Gun_TempRand[2],Exactly,i)})
				CMov(FP,TempBarPos,BarPos[i+1])
			CIfEnd()
		end
		CIfEnd()
	CIfEnd()
	-- MoveUnitLoc = 1
	-- DefAttackLoc = 89
	-- DefCreateLoc = 90
	f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
	CSub(FP,CheckTemp,Nextptrs,19025)
	f_Mod(FP,CheckTemp,_Mov(84))
	local f_Repeat_ErrorCheck = def_sIndex()
	NJump(FP,f_Repeat_ErrorCheck,{CVar(FP,CheckTemp[2],AtLeast,1)},RotatePlayer({DisplayTextX(f_RepeatErr,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP))
	
	f_Lengthdir(FP,_Mod(_Rand(),24*32),_Mod(_Rand(),360),CPosX,CPosY)
	CDiv(FP,CPosY,2)
	Simple_SetLocX(FP,89,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(89,1536,4480,1536,4480)})
	CDoActions(FP,{
		TCreateUnitWithProperties(1,Repeat_UnitIDV,90,P8,{energy = 100}),
--		TModifyUnitEnergy(All,Repeat_UnitIDV,P8,1,100);
	})
	

	CIf(FP,{TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
	
		f_Read(FP,_Add(Nextptrs,10),CPos) -- 생성유닛 위치 불러오기
		Convert_CPosXY()
		Simple_SetLocX(FP,89,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(89,-4,-4,4,4)})
		CDoActions(FP,{TMoveUnit(1,Repeat_UnitIDV,FP,90,1)})
		f_Read(FP,_Add(Nextptrs,10),CPos) -- 생성유닛 위치 불러오기
		Convert_CPosXY()
		Simple_SetLocX(FP,89,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(89,-4,-4,4,4)})

		CIfX(FP,CVar(FP,RepeatType[2],Exactly,0),SetCDeaths(FP,SetTo,1,isScore))
		
			CMov(FP,CPos,TempBarPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,88,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(88,-4,-4,4,4)})
			CDoActions(FP,{TOrder(Repeat_UnitIDV,FP,90,Attack,89)})
		CElseIfX(CVar(FP,RepeatType[2],Exactly,4),SetCDeaths(FP,SetTo,1,isScore)) -- 겹효과 부여+어택

			CMov(FP,CPos,TempBarPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,88,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(88,-4,-4,4,4)})
			CDoActions(FP,{TOrder(Repeat_UnitIDV,FP,90,Attack,89),TSetDeathsX(_Add(Nextptrs,55),SetTo,0xA00000,0,0xA00000)})


		CElseIfX(CVar(FP,RepeatType[2],Exactly,187),SetCDeaths(FP,SetTo,1,isScore))
			CDoActions(FP,{TSetDeathsX(_Add(Nextptrs,19),SetTo,187*256,0,0xFF00),})
		CElseIfX(CVar(FP,RepeatType[2],Exactly,1),SetCDeaths(FP,SetTo,1,isScore))
			f_Read(FP,_Add(Nextptrs,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,59,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(59,-32,-32,32,32)})
			CDoActions(FP,{
				TSetInvincibility(Enable,Repeat_UnitIDV,FP,60),TGiveUnits(1,Repeat_UnitIDV,P8,60,P9),TSetDeathsX(_Add(Nextptrs,72),SetTo,0xFF*256,0,0xFF00),TSetDeathsX(_Add(Nextptrs,55),SetTo,0xA00000,0,0xA00000),CreateUnit(1,ObEff,60,FP),KillUnit(ObEff, FP)
			})
		CElseIfX(CVar(FP,RepeatType[2],Exactly,3),SetCDeaths(FP,SetTo,1,isScore))
		CElseIfX(CVar(FP,RepeatType[2],Exactly,5),SetCDeaths(FP,SetTo,0,isScore)) -- 루카스보스로 어택명령, 공중 충돌판정 삭제 루카스보스 전용 RepeatType
		TriggerX(FP,CVar(FP,Repeat_UnitIDV[2],Exactly,80),{KillUnitAt(All,"Edmund Duke (Siege Mode)",1,FP)},{preserved})
		GetLocCenter("Boss",CPosX,CPosY)
		Simple_SetLocX(FP,88,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(88,-4,-4,4,4)})
		CDoActions(FP,{TOrder(Repeat_UnitIDV,FP,90,Attack,89),TSetDeathsX(_Add(Nextptrs,55),SetTo,0xA00000,0,0xA00000)})
		CTrigger(FP,{CVar(FP,Repeat_UnitIDV[2],Exactly,27)},{TSetDeathsX(_Add(Nextptrs,55),SetTo,0x04000000,0,0x04000000)},1)

		CElseIfX(CVar(FP,RepeatType[2],Exactly,2),SetCDeaths(FP,SetTo,0,isScore)) -- 루카스보스로 어택명령, 루카스보스 전용 RepeatType
		TriggerX(FP,CVar(FP,Repeat_UnitIDV[2],Exactly,80),{KillUnitAt(All,"Edmund Duke (Siege Mode)",1,FP)},{preserved})
		GetLocCenter("Boss",CPosX,CPosY)
		Simple_SetLocX(FP,88,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(88,-4,-4,4,4)})
		CDoActions(FP,{TOrder(Repeat_UnitIDV,FP,90,Attack,89)})
		CTrigger(FP,{CVar(FP,Repeat_UnitIDV[2],Exactly,27)},{TSetDeathsX(_Add(Nextptrs,55),SetTo,0x04000000,0,0x04000000)},1)
		CElseX(SetCDeaths(FP,SetTo,0,isScore))
			DoActions(FP,RotatePlayer({DisplayTextX(f_RepeatTypeErr,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP))
		CIfXEnd()
		CIf(FP,CDeaths(FP,AtLeast,1,isScore))
			f_Mod(FP,BiteCalc,Repeat_UnitIDV,_Mov(2),0xFF)
			f_Read(FP,_Add(_Div(Repeat_UnitIDV,_Mov(2)),_Mov(EPD(0x663EB8))),UnitPoint)
			NIfX(FP,{CVar(FP,BiteCalc[2],AtLeast,1)})
			CDiv(FP,UnitPoint,65536)
			NElseX()
			CMod(FP,UnitPoint,65536)
			NIfXEnd()
			CAdd(FP,InputPoint,UnitPoint)
		CIfEnd()
		
	CIfEnd()
	NJumpEnd(FP,f_Repeat_ErrorCheck)
	CSub(FP,Spawn_TempW,1)
CWhileEnd()
CMov(FP,RepeatType,0)
SetCallEnd()


function f_TempRepeat(UnitID,Number,Condition,Type,Owner,CenterXY)
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
	else
		PushErrorMsg("TRepeat_CenterXY_Error")
	end
	

	CallTriggerX(FP,Call_Repeat,Condition,{
		SetCDeaths(FP,SetTo,0,CB_Repeat_Check),
		SetCVar(FP,Repeat_UnitIDV[2],SetTo,UnitID),
		SetCVar(FP,Spawn_TempW[2],SetTo,Number),
		SetCVar(FP,RepeatType[2],SetTo,Type),
		SetCVar(FP,CreatePlayer[2],SetTo,Owner),
		SetCVar(FP,TRepeatX[2],SetTo,SetX),
		SetCVar(FP,TRepeatY[2],SetTo,SetY),
	})
end

function f_TempRepeatX(UnitID,Number,Condition,Type,Owner,CenterXY)
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
	else
		PushErrorMsg("TRepeat_CenterXY_Error")
	end
	CDoActions(FP,{
		TSetCVar(FP,Repeat_UnitIDV[2],SetTo,UnitID),
		TSetCVar(FP,Spawn_TempW[2],SetTo,Number),
		TSetCVar(FP,TRepeatX[2],SetTo,SetX),
		TSetCVar(FP,TRepeatY[2],SetTo,SetY),
		SetCVar(FP,RepeatType[2],SetTo,Type),
		SetCDeaths(FP,SetTo,0,CB_Repeat_Check),
		SetCVar(FP,CreatePlayer[2],SetTo,Owner)})
	CallTriggerX(FP,Call_Repeat,Condition)
end

function f_TempRepeat2X(Condition,UnitID,Number,EffType,Owner,CenterXY,Flags)
	if Owner == nil then Owner = 0xFFFFFFFF
	elseif Owner == "CP" then Owner = 0x7FFFFFFF end
	if Type == nil then Type = 0 end
	local SetXY = {}
	if CenterXY == nil then 
		SetXY = {
		SetCVar(FP,TRepeatX[2],SetTo,0xFFFFFFFF),
		SetCVar(FP,TRepeatY[2],SetTo,0xFFFFFFFF),
		}
	elseif type(CenterXY) == "table" then
		SetXY = {
		SetCVar(FP,TRepeatX[2],SetTo,CenterXY[1]),
		SetCVar(FP,TRepeatY[2],SetTo,CenterXY[2]),
		}
	elseif CenterXY ~= "X" then 
		PushErrorMsg("TRepeat_CenterXY_Error")
	end
	CDoActions(FP,{
		TSetCVar(FP,Repeat_UnitIDV[2],SetTo,UnitID),
		TSetCVar(FP,Spawn_TempW[2],SetTo,Number),
		SetXY,
		SetCVar(FP,RepeatType[2],SetTo,100),
		SetCDeaths(FP,SetTo,0,CB_Repeat_Check),
		SetCVar(FP,G_CB_TempTable[15][2],SetTo,EffType),
		SetCVar(FP,G_CB_TempTable[17][2],SetTo,Flags),
		SetCVar(FP,CreatePlayer[2],SetTo,Owner)})
	CallTriggerX(FP,Call_Repeat,Condition)
end





Write_SpawnSet = SetCallForward()
SetCall(FP)


-- Line0 = UnitIDTable 0xFF
-- Line1 = RepeatTypeTable 0xFF
-- Line2 = G_CB_FNTableTable 0xFF
-- Line3 = ShapeNumberTable1
-- Line4 = ShapeNumberTable2
-- Line5 = ShapeNumberTable3
-- Line6 = ShapeNumberTable4
-- Line7 = XPos
-- Line8 = YPos
-- Line9 = CA[5],0xFF 루프 리미트 (트리거 순환당 소환할 유닛 수 / k입력시 CA[4] : 0~k-1까지 루프함) 
-- Line10 = CA[2] 남은 대기 시간 (Tick 단위 / 0일때 유닛 소환) 
-- Line11 = CA[3] 소환후 대기시간 증가량 (Tick 단위/ k입력시 1회 루프후 대기시간 k추가()
-- Line12 = CA[6] 데이터 인덱스 (k입력시 Shape[k+1]의 데이터를 출력함



CMov(FP,G_CB_LineV,0)
CJumpEnd(FP,Write_SpawnSet_Jump)

CAdd(FP,G_CB_LineTemp,G_CB_LineV,G_CB_InputH)
NIfX(FP,{TMemory(G_CB_LineTemp,AtMost,0)})

		TriggerX(FP,{},{RotatePlayer({DisplayTextX(f_GunFuncT2,4)},HumanPlayers,FP)},{preserved})
_0D = string.rep("\x0D",200)
if Limit == 1 then
	--	CIf(FP,CD(TestMode,1))
--		TriggerX(FP,{},{RotatePlayer({DisplayTextX(f_GunFuncT2,4)},HumanPlayers,FP)},{preserved})
--		ItoDec(FP,G_CB_CUTV,VArr(G_CB_WSTestVA,0),0,nil,0)
--		f_Movcpy(FP,G_CB_WSTestStrPtr,VArr(G_CB_WSTestVA,0),4*4)
--		TriggerX(FP,{},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CB_WS".._0D,4)},HumanPlayers,FP)},{preserved})
--		ItoDec(FP,G_CB_RPTV,VArr(G_CB_WSTestVA,0),0,nil,0)
--		f_Movcpy(FP,G_CB_WSTestStrPtr,VArr(G_CB_WSTestVA,0),4*4)
--		TriggerX(FP,{},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CB_WS".._0D,4)},HumanPlayers,FP)},{preserved})
--		ItoDec(FP,G_CB_FNTV,VArr(G_CB_WSTestVA,0),0,nil,0)
--		f_Movcpy(FP,G_CB_WSTestStrPtr,VArr(G_CB_WSTestVA,0),4*4)
--		TriggerX(FP,{},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CB_WS".._0D,4)},HumanPlayers,FP)},{preserved})
--		ItoDec(FP,G_CB_SNTV[1],VArr(G_CB_WSTestVA,0),0,nil,0)
--		f_Movcpy(FP,G_CB_WSTestStrPtr,VArr(G_CB_WSTestVA,0),4*4)
--		TriggerX(FP,{},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CB_WS".._0D,4)},HumanPlayers,FP)},{preserved})
--		ItoDec(FP,G_CB_LMTV,VArr(G_CB_WSTestVA,0),0,nil,0)
--		f_Movcpy(FP,G_CB_WSTestStrPtr,VArr(G_CB_WSTestVA,0),4*4)
--		TriggerX(FP,{},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CB_WS".._0D,4)},HumanPlayers,FP)},{preserved})
	--	CIfEnd()
	
	end
CDoActions(FP,{
	TSetMemory(_Add(G_CB_LineTemp,0*(0x20/4)),SetTo,G_CB_CUTV),
	TSetMemory(_Add(G_CB_LineTemp,1*(0x20/4)),SetTo,G_CB_RPTV),
	TSetMemory(_Add(G_CB_LineTemp,2*(0x20/4)),SetTo,G_CB_FNTV),
	TSetMemory(_Add(G_CB_LineTemp,3*(0x20/4)),SetTo,G_CB_SNTV[1]),
	TSetMemory(_Add(G_CB_LineTemp,4*(0x20/4)),SetTo,G_CB_SNTV[2]),
	TSetMemory(_Add(G_CB_LineTemp,5*(0x20/4)),SetTo,G_CB_SNTV[3]),
	TSetMemory(_Add(G_CB_LineTemp,6*(0x20/4)),SetTo,G_CB_SNTV[4]),
	TSetMemory(_Add(G_CB_LineTemp,9*(0x20/4)),SetTo,G_CB_LMTV),
	TSetMemory(_Add(G_CB_LineTemp,10*(0x20/4)),SetTo,0),
	TSetMemory(_Add(G_CB_LineTemp,11*(0x20/4)),SetTo,G_CB_DLTV),
	TSetMemory(_Add(G_CB_LineTemp,12*(0x20/4)),SetTo,0),
	
	
})
CIfX(FP,{CVar(FP,G_CB_XPos[2],Exactly,0xFFFFFFFF),CVar(FP,G_CB_YPos[2],Exactly,0xFFFFFFFF)})
CDoActions(FP,{
	TSetMemory(_Add(G_CB_LineTemp,7*(0x20/4)),SetTo,G_CB_CenterX),
	TSetMemory(_Add(G_CB_LineTemp,8*(0x20/4)),SetTo,G_CB_CenterY)
})
CElseX()
CDoActions(FP,{
	TSetMemory(_Add(G_CB_LineTemp,7*(0x20/4)),SetTo,G_CB_XPos),
	TSetMemory(_Add(G_CB_LineTemp,8*(0x20/4)),SetTo,G_CB_YPos)
})
CIfXEnd()
NElseIfX({CVar(FP,G_CB_LineV[2],AtMost,((0x970/4)*G_CB_ArrSize-2))})
CAdd(FP,G_CB_LineV,0x970/4)
CJump(FP,Write_SpawnSet_Jump)
NElseX()

DoActions(FP,{RotatePlayer({DisplayTextX(f_GunSendErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})

NIfXEnd()
SetCallEnd()










local G_CB_Suspend = CreateCcode()


local G_CB_Launch = CreateCcode()
function G_CB_Func()
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local TempFunc = CreateVar(FP)
	
	CMov(FP,TempFunc,G_CB_TempTable[3],nil,0xFF,1)

	CIf(FP,{CV(TempFunc,1,AtLeast),CV(TempFunc,8,AtMost)})
		
		INumJump = def_sIndex()
		for j = 3, 8 do
			for i = 1, 8 do
			NJumpX(FP,INumJump,{CV(V(CA[10]),_G["P_"..j][1]),CV(TempFunc,i)},{SetV(V(CA[10]),PlotSizeCalc(j,i))})
			end
			for i = 1, 4 do
			NJumpX(FP,INumJump,{CV(V(CA[10]),_G["S_"..j][1]),CV(TempFunc,i)},{SetV(V(CA[10]),PlotSizeCalc(j*2,i))})
			end
		end
		NJumpEnd(FP, INumJump)
		for i = 1, 8 do
			CIf(FP,CV(TempFunc,i))
				CA_RatioXY(5000-(350*i), 1000, 5000-(350*i), 1000)
			CIfEnd()
		end
	CIfEnd()
	
	CIf(FP,CVar(FP,G_CB_TempTable[10][2],AtMost,0,0xFF))
	local TempLM = CreateVar(FP)
		f_Div(FP,TempLM,V(CA[10]),50)
		CMov(FP,G_CB_TempTable[10],TempLM,1,0xFF)
	CIfEnd()

	CAdd(FP,Repeat_X,V(CA[8]),G_CB_TempTable[8])
	CAdd(FP,Repeat_Y,V(CA[9]),G_CB_TempTable[9])
	CMov(FP,0x58DC60,Repeat_X)
	CMov(FP,0x58DC64,Repeat_Y)
	CMov(FP,0x58DC68,Repeat_X)
	CMov(FP,0x58DC6C,Repeat_Y)
	CMov(FP,Repeat_UnitIDV,G_CB_TempTable[1],nil,0xFF,1)
	CMov(FP,RepeatType,G_CB_TempTable[2],nil,0xFF,1)
	CMov(FP,Spawn_TempW,1)
	CallTrigger(FP,Call_Repeat,{SetCDeaths(FP,SetTo,1,CB_Repeat_Check)})
	
end
G_CB_ShapeTable = {}


-- Line0 = UnitIDTable 0xFF
-- Line1 = RepeatTypeTable 0xFF
-- Line2 = G_CB_FNTable 0xFF
-- Line3 = ShapeNumberTable1
-- Line4 = ShapeNumberTable2
-- Line5 = ShapeNumberTable3
-- Line6 = ShapeNumberTable4
-- Line7 = XPos
-- Line8 = YPos
-- Line9 = CA[5],0xFF 루프 리미트 (트리거 순환당 소환할 유닛 수 / k입력시 CA[4] : 0~k-1까지 루프함) 
-- Line10 = CA[2] 남은 대기 시간 (Tick 단위 / 0일때 유닛 소환) 
-- Line11 = CA[3] 소환후 대기시간 증가량 (Tick 단위/ k입력시 1회 루프후 대기시간 k추가()
-- Line12 = CA[6] 데이터 인덱스 (k입력시 Shape[k+1]의 데이터를 출력함


	if type(ShapeTable) ~= "table" then
		PushErrorMsg("ShapeData_Input_Error")
	end
	local Y = {}
	local X = {}
	for j, k in pairs(ShapeTable) do
		if type(k) ~= "string" then
			PushErrorMsg("ShapeData_Input_Error")
		end
		Y[j] = _G[k]
		G_CB_ShapeTable[j] = k
		if LoopMaxTable[j] ~= nil then
			X[j] = LoopMaxTable[j]
		else
			X[j] = CS_TMakeAuto(_G[k])
		end
	end


	Load_CBPlot = SetCallForward()
	local CA = CAPlotForward()
	SetCall(FP)
	DoActionsX(FP,{SetCDeaths(FP,SetTo,1,G_CB_Launch)})
	CMov(FP,V(CA[1]),G_CB_TempTable[4])
	CMov(FP,V(CA[2]),G_CB_TempTable[11])
	CMov(FP,V(CA[3]),G_CB_TempTable[12])
	CMov(FP,V(CA[6]),G_CB_TempTable[13])
	CMov(FP,V(CA[5]),G_CB_TempTable[10],nil,0xFF,1)
	TriggerX(FP, {CVar(FP,G_CB_TempTable[10][2],AtMost,0,0xFF)}, {SetV(V(CA[5]),1)}, {preserved})


	CBPlot(Y,nil,FP,nilunit,0,{G_CB_TempTable[8],G_CB_TempTable[9]},1,32,{0,0,0,0,0,1},"G_CB_Func",nil,FP,nil,nil,{SetCDeaths(FP,Add,1,G_CB_Suspend)}) 
	CDoActions(FP,{TSetCVar(FP,G_CB_TempTable[13][2],SetTo,V(CA[6])),TSetCVar(FP,G_CB_TempTable[11][2],SetTo,V(CA[2]))})
	--CMov(FP,0x57f0f0,V(CA[6]))
	--CMov(FP,0x57f120,V(CA[10]))
	DoActions(FP,{DisplayText("asdafsa",1)})
	SetCallEnd()


function T_to_BiteBuffer(Table)
	local BiteValue = 0
	if type(Table) == "table" then
		local ret = 0
		if #Table >= 5 then
			PushErrorMsg("BiteStack_is_Over_5")
		end
		for i, j in pairs(Table) do
			BiteValue = BiteValue + j*(256^ret)
			ret = ret + 1
		end
		Table = BiteValue
	end
	return BiteValue
end



function G_CB_SetSpawn(Condition,G_CB_CUTable,G_CB_SNTable,G_CB_LMTable,G_CB_RPTable,G_CB_FNTable,Delay,CenterXY,Owner,PreserveFlag)
	if type(G_CB_CUTable) ~= "table" then
		PushErrorMsg("G_CB_SetSpawn_Inputdata_Error")
	end
	local X = {}
	if type(G_CB_SNTable) == "table" then
		if #G_CB_SNTable >= 5 then
			PushErrorMsg("BiteStack_is_Over_5")
		end
		for i = 1, 4 do
			if G_CB_SNTable[i] ~= nil then
				if type(G_CB_SNTable[i]) == "string" then
					local G_CB_ShapeTable_Check = ""
					for j, k in pairs(G_CB_ShapeTable) do
						if G_CB_SNTable[i] == k then
							table.insert(X,SetCVar(FP,G_CB_SNTV[i][2],SetTo,j))
							G_CB_ShapeTable_Check = "OK"
						end
					end
					if G_CB_ShapeTable_Check ~= "OK" then
						PushErrorMsg("G_CA_SetSpawn_String_Shape_NotFound")
					end
				else
					PushErrorMsg("G_CB_SNTable_InputData_Error")
				end
			else
				table.insert(X,SetCVar(FP,G_CB_SNTV[i][2],SetTo,0))
			end
		end
	elseif type(G_CB_SNTable) == "string" then
		local G_CB_ShapeTable_Check = ""
		for j, k in pairs(G_CB_ShapeTable) do
			if G_CB_SNTable == k then
				table.insert(X,SetCVar(FP,G_CB_SNTV[1][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[2][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[3][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[4][2],SetTo,j))
				G_CB_ShapeTable_Check = "OK"
			end
		end
		if G_CB_ShapeTable_Check ~= "OK" then
			PushErrorMsg("G_CA_SetSpawn_String_Shape_NotFound")
		end
	else
		PushErrorMsg("G_CB_SNTable_InputData_Error")
	end
	if type(G_CB_FNTable) ~= "table" then
		G_CB_FNTable = {G_CB_FNTable,G_CB_FNTable,G_CB_FNTable,G_CB_FNTable}
	elseif G_CB_FNTable == nil then 
		G_CB_FNTable = {0,0,0,0}
	end
	if type(G_CB_RPTable) ~= "table" then
		G_CB_RPTable = {G_CB_RPTable,G_CB_RPTable,G_CB_RPTable,G_CB_RPTable}
	elseif G_CB_RPTable == nil then 
		PushErrorMsg("G_CB_SetSpawn_Inputdata_Error")
	end
	
	local LMRet = 0
	if G_CB_LMTable == "MAX" then
		LMRet = T_to_BiteBuffer({255,255,255,255})
	elseif type(G_CB_LMTable) == "table" then
		LMRet = T_to_BiteBuffer(G_CB_LMTable)
	elseif type(G_CB_LMTable) == "number" then
		LMRet = T_to_BiteBuffer({G_CB_LMTable,G_CB_LMTable,G_CB_LMTable,G_CB_LMTable})
	else
		LMRet = T_to_BiteBuffer({0,0,0,0})
	end
	local Y = {}
	if CenterXY == nil then 
		table.insert(Y,SetCVar(FP,G_CB_XPos[2],SetTo,0xFFFFFFFF))
		table.insert(Y,SetCVar(FP,G_CB_YPos[2],SetTo,0xFFFFFFFF))
	elseif type(CenterXY) == "table" then
		table.insert(Y,SetCVar(FP,G_CB_XPos[2],SetTo,CenterXY[1]))
		table.insert(Y,SetCVar(FP,G_CB_YPos[2],SetTo,CenterXY[2]))
	else
		PushErrorMsg("G_CB_SetSpawn_CenterXY_Inputdata_Error")
	end
	if Owner == nil then Owner = 0xFFFFFFFF end
	if Delay == nil then Delay = 0 end
	CallTriggerX(FP,Write_SpawnSet,Condition,{
		SetCVar(FP,G_CB_CUTV[2],SetTo,T_to_BiteBuffer(G_CB_CUTable)),
		X,
		
		SetCVar(FP,G_CB_DLTV[2],SetTo,Delay),
		SetCVar(FP,G_CB_LMTV[2],SetTo,LMRet),
		SetCVar(FP,G_CB_RPTV[2],SetTo,T_to_BiteBuffer(G_CB_RPTable)),Y,
		SetCVar(FP,G_CB_Owner[2],SetTo,Owner),
		SetCVar(FP,G_CB_FNTV[2],SetTo,T_to_BiteBuffer(G_CB_FNTable)),
		SetCVar(FP,G_CB_EffType[2],SetTo,0),
		
	},PreserveFlag)
end


-- Line0 = UnitIDTable 0xFF
-- Line1 = RepeatTypeTable 0xFF
-- Line2 = G_CB_FNTableTable 0xFF
-- Line3 = ShapeNumberTable1
-- Line4 = ShapeNumberTable2
-- Line5 = ShapeNumberTable3
-- Line6 = ShapeNumberTable4
-- Line7 = XPos
-- Line8 = YPos
-- Line9 = CA[5],0xFF 루프 리미트 (트리거 순환당 소환할 유닛 수 / k입력시 CA[4] : 0~k-1까지 루프함) 
-- Line10 = CA[2] 남은 대기 시간 (Tick 단위 / 0일때 유닛 소환) 
-- Line11 = CA[3] 소환후 대기시간 증가량 (Tick 단위/ k입력시 1회 루프후 대기시간 k추가()
-- Line12 = CA[6] 데이터 인덱스 (k입력시 Shape[k+1]의 데이터를 출력함

	Call_G_CB = SetCallForward()
	SetCall(FP)
		CIfX(FP,CVar(FP,G_CB_TempTable[1][2],AtLeast,1,0xFF))
			CallTrigger(FP,Load_CBPlot)
			CIfX(FP,{CDeaths(FP,AtLeast,1,G_CB_Launch),CDeaths(FP,AtLeast,1,G_CB_Suspend)})
			CDiv(FP,G_CB_TempTable[1],256)
			CDiv(FP,G_CB_TempTable[2],256)
			CDiv(FP,G_CB_TempTable[3],256)
			CMov(FP,G_CB_TempTable[4],G_CB_TempTable[5])
			CMov(FP,G_CB_TempTable[5],G_CB_TempTable[6])
			CMov(FP,G_CB_TempTable[6],G_CB_TempTable[7])
			CDiv(FP,G_CB_TempTable[10],256)
			CMov(FP,G_CB_TempTable[7],0)
			CMov(FP,G_CB_TempTable[11],0)
			CMov(FP,G_CB_TempTable[12],0)
			CMov(FP,G_CB_TempTable[13],0)
			if Limit == 1 then
				TriggerX(FP,{},{RotatePlayer({DisplayTextX(f_GunFuncT,4)},HumanPlayers,FP)},{preserved}) --CD(TestMode,1)
			end
			CElseIfX({CDeaths(FP,AtLeast,1,G_CB_Launch),CDeaths(FP,AtLeast,0,G_CB_Suspend)})
			CElseX()
			if Limit == 1 then
				TriggerX(FP,{},{RotatePlayer({DisplayTextX(f_GunErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)},{preserved})
			end
			
			local G_CB_InputCAct = {}
			for i = 1, G_CB_Lines do
				table.insert(G_CB_InputCAct,SetNVar(G_CB_TempTable[i],SetTo,0))
			end
				CDoActions(FP,G_CB_InputCAct)
			CIfXEnd()
		CElseIfX(CVar(FP,G_CB_TempTable[1][2],AtLeast,1))
		CDiv(FP,G_CB_TempTable[1],256)
		CDiv(FP,G_CB_TempTable[2],256)
		CDiv(FP,G_CB_TempTable[3],256)
		CMov(FP,G_CB_TempTable[4],G_CB_TempTable[5])
		CMov(FP,G_CB_TempTable[5],G_CB_TempTable[6])
		CMov(FP,G_CB_TempTable[6],G_CB_TempTable[7])
		CDiv(FP,G_CB_TempTable[10],256)
		CMov(FP,G_CB_TempTable[7],0)
		CMov(FP,G_CB_TempTable[11],0)
		CMov(FP,G_CB_TempTable[12],0)
		CMov(FP,G_CB_TempTable[13],0)
		if Limit == 1 then
			TriggerX(FP,{},{RotatePlayer({DisplayTextX(f_GunErrT2,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)},{preserved})
		end

		CIfXEnd()

		local G_CB_InputCAct = {}
		for i = 1, G_CB_Lines do
			table.insert(G_CB_InputCAct,TSetMemory(Vi(G_CB_TempH[2],(i-1)*(0x20/4)),SetTo,G_CB_TempTable[i]))
		end
		CDoActions(FP,G_CB_InputCAct)
		DoActionsX(FP,{SetCDeaths(FP,SetTo,0,G_CB_Suspend),SetCDeaths(FP,SetTo,0,G_CB_Launch)})
	SetCallEnd()
Actived_G_CB = CreateVar(FP)
function Create_G_CB_Arr()
	if G_CB_Arr_IndexAlloc ~= StartIndex then PushErrorMsg("Already_G_CB_Arr_Created") end
	CMov(FP,Actived_G_CB,0)
	for i = 0, G_CB_ArrSize-1 do
		CTrigger(FP, {CVar("X","X",AtLeast,1),Memory(0x628438,AtLeast,1)}, {
			G_CB_InputCVar,
			SetCtrigX("X",G_CB_TempH[2],0x15C,0,SetTo,"X","X",0x15C,1,0),
			SetCVar(FP,G_CB_Num[2],SetTo,i),
			SetCVar(FP,Actived_G_CB[2],Add,1),
			SetNext("X",Call_G_CB,0),SetNext(Call_G_CB+1,"X",1), -- Call f_Gun
			SetCtrigX("X",Call_G_CB+1,0x158,0,SetTo,"X","X",0x4,1,0), -- RecoverNext
			SetCtrigX("X",Call_G_CB+1,0x15C,0,SetTo,"X","X",0,0,1), -- RecoverNext
			SetCtrig1X("X",Call_G_CB+1,0x164,0,SetTo,0x0,0x2) -- RecoverNext
		}, 1, G_CB_Arr_IndexAlloc)
		G_CB_Arr_IndexAlloc = G_CB_Arr_IndexAlloc + 1
	end
end


	function G_CB_init()

		f_GetStrXptr(FP,G_CB_WSTestStrPtr,"\x0D\x0D\x0DG_CB_WS".._0D)

	end

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
		players = {ParsePlayer(PlayerID)},
		conditions = { 
			Label(0);
		},
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",EXCC_Index+2,0,0,1); 
		},
		flag = {preserved}
	}	
	Trigger { -- Cunit Calc Selector
		players = {ParsePlayer(PlayerID)},
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
		players = {ParsePlayer(PlayerID)},
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
		players = {ParsePlayer(PlayerID)},
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
		players = {ParsePlayer(PlayerID)},
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
		players = {ParsePlayer(PlayerID)},
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
	

