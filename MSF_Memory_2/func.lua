
function StrDesign(Str)
	return "\x07·\x11·\x08·\x07【 "..Str.." \x07】\x08·\x11·\x07·"
end
function StrDesignX(Str)
	return "\x13\x07·\x11·\x08·\x07【 "..Str.." \x07】\x08·\x11·\x07·"
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
		local EXCunit_Reset = {} -- 필요시 리셋시키기 위한 테이블
		for i = 1, #EXCunitTemp do
			table.insert(EXCunit_Reset,SetCtrig1X("X","X",CAddr("Value",i-1,0),0,SetTo,0))
		end
		return {Player,Index,HeaderV,EXCunitTemp,EXCUnitArr,EXCunit_Reset}
	else
		return {Player,Index,HeaderV,EXCunitTemp,EXCUnitArr}
	end
end
function Set_EXCC2(EXCC_init,CurUnitIndex,Line,Type,Value) -- EXCC단락 외부에서 값을 쓰고싶을때. 무조건 T액션, 너무많이 쓸 경우 성능 하락 우려 있음
	return TSetMemory(_Add(_Mul(CurUnitIndex,_Mov(0x970/4)),_Add(EXCC_init[3],((0x20*Line)/4))),Type,Value)
end

function Set_EXCC(Line,Type,Value) -- EXCC단락 내부에서 값을 쓰고싶을때. 무조건 T액션, TempVar에서는 값이 변동하지 않으므로 TempVar값과 함께 변경시켜줘야됨
	return {TSetMemory(_Add(EXCC_TempHeader,((0x20*Line)/4)),Type,Value),SetV(EXCC_TempVarArr[Line+1],Value,Type)}
end

function Cond_EXCC(Line,Type,Value) -- EXCC단락 내부에서 값을 검사하고 싶을때.
	return CV(EXCC_TempVarArr[Line+1],Value,Type)
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
		flag = {Preserved}
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
		flag = {Preserved}
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
				SetMemory(0x6509B0,SetTo,P); -- 루프를 돌릴 플레이어 값으로 맞추기 ( P1 = 0, P2 = 1, ... , P8 = 7 )
			},
			flag = {Preserved}
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
		flag = {Preserved}
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
		flag = {Preserved}
	}		
end

	
function EXCC_ClearCalc()
	PlayerID = EXCC_Player
	Trigger { -- Cunit Calc End
		players = {ParsePlayer(PlayerID)},
		conditions = { 
			Label(0);
		}, 
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",EXCC_Index+1,0,0,0);
		},
		flag = {Preserved}
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
		flag = {Preserved}
	}	
end

function EXCC_End()
	EXCC_Index = nil
	EXCC_Player = nil
	EXCC_initArr = {}
	EXCC_TempHeader = nil
end
	



function Include_Conv_CPosXY(Player)
	CPos,CPosX,CPosY = CreateVars(3,Player)
	Call_CPosXY = SetCallForward()
	SetCall(Player)
	CMov(Player,CPosX,CPos,0,0XFFFF)
	CMov(Player,CPosY,CPos,0,0XFFFF0000)
	f_Div(Player,CPosY,_Mov(0x10000))
	SetCallEnd()
	function Convert_CPosXY(Value)
		if Value ~= nil then
			CDoActions(Player,{
				TSetCVar(Player,CPos[2],SetTo,Value),
				SetNext("X",Call_CPosXY,0),SetNext(Call_CPosXY+1,"X",1)
			})
		else
			CallTrigger(Player,Call_CPosXY)
		end
		return CPosX,CPosY
	end
end
function Include_CRandNum(Player)
	TempRandRet = CreateVar(Player)
	Oprnd = CreateVar(Player)
	InputMaxRand = CreateVar(Player)
CRandNum = SetCallForward()
SetCall(Player)
f_Rand(Player,TempRandRet)
f_Mod(Player,TempRandRet,InputMaxRand)
CAdd(Player,TempRandRet,Oprnd)
SetCallEnd()
function f_CRandNum(Max,Operand,Condition)
	if Operand == nil then Operand = 0 end
	local RandRet = TempRandRet
	CallTriggerX(Player,CRandNum,Condition,{SetCVar(Player,InputMaxRand[2],SetTo,Max),SetCVar(Player,Oprnd[2],SetTo,Operand)})
	return RandRet
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


function UnitLimit(Player,UID,Limit,Text,ReturnResources)
	Trigger {
		players = {Player},
		conditions = {
			Bring(Player,AtLeast,Limit+1,UID,64);
			},
		
		actions = {
			KillUnitAt(1,UID,"Anywhere",Player);
			DisplayText(StrDesign("\x04"..Text.." "..Limit.."기를 넘어서 소지할 수 없습니다. \x1C자원 반환 \x1F+ "..ReturnResources.." Ore\x07"),4);
			SetResources(Player,Add,ReturnResources,Ore);
			PreserveTrigger();
		},
	}
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
		CTrigger(Player,{PlayerCheck(i,1)},{TSetDeathsX(i,Subtract,MSQC_Recives,12,0xFFFFFF)},1) -- 브금타이머
		CTrigger(Player,{PlayerCheck(i,0)},{SetDeaths(i,SetTo,0,12)},1) -- 브금타이머
	end
	CDoActions(Player,{TSetDeathsX(Player,Subtract,MSQC_Recives,12,0xFFFFFF),SetDeathsX(Player,SetTo,0,12,0xFF000000),SetDeaths(8,SetTo,0,12),SetDeaths(9,SetTo,0,12),SetDeaths(10,SetTo,0,12),SetDeaths(11,SetTo,0,12)}) -- 브금타이머
end

function AddCD(Code,Value)

	if FP == nil then PushErrorMsg("FP Player not defined") end
	if type(Value) == "number" then
		return SetCDeaths(FP,Add,Value,Code)
	else
		return TSetCDeaths(FP,Add,Value,Code)
	end
end
function SubCD(Code,Value)
	if FP == nil then PushErrorMsg("FP Player not defined") end
	if type(Value) == "number" then
		return SetCDeaths(FP,Subtract,Value,Code)
	else
		return TSetCDeaths(FP,Subtract,Value,Code)
	end
end
function SetCD(Code,Value)
	if FP == nil then PushErrorMsg("FP Player not defined") end
	if type(Value) == "number" then
		return SetCDeaths(FP,SetTo,Value,Code)
	else
		return TSetCDeaths(FP,SetTo,Value,Code)
	end
end
function AddV(V,Value)
	if FP == nil then PushErrorMsg("FP Player not defined") end
	if type(Value) == "number" then
		return SetCVar(FP,V[2],Add,Value)
	else
		return TSetCVar(FP,V[2],Add,Value)
	end
end
function SubV(V,Value)
	if FP == nil then PushErrorMsg("FP Player not defined") end
	if type(Value) == "number" then
		return SetCVar(FP,V[2],Subtract,Value)
	else
		return TSetCVar(FP,V[2],Subtract,Value)
	end
end
function SetV(V,Value,Type)
	if Type == nil then Type = SetTo end
	if FP == nil then PushErrorMsg("FP Player not defined") end
	if type(Value) == "number" then
		return SetCVar(FP,V[2],Type,Value)
	else
		return TSetCVar(FP,V[2],Type,Value)
	end
end
function CD(Code,Value,Type)
	if Type == nil then Type = Exactly end
	if FP == nil then PushErrorMsg("FP Player not defined") end
	if type(Value) == "number" then
		return CDeaths(FP,Type,Value,Code)
	else
		return TCDeaths(FP,Type,Value,Code)
	end
	
end
function CV(V,Value,Type)
	if Type == nil then Type = Exactly end
	if FP == nil then PushErrorMsg("FP Player not defined") end
	if type(Value) == "number" then
		return CVar(FP,V[2],Type,Value)
	else
		return TCVar(FP,V[2],Type,Value)
	end
	
end


function Print13_NumSetC(Ptr,Ptr2,DivNum,Mask)
	for i = 3, 0, -1 do
		Trigger {
			players = {FP},
			conditions = {
				Label();

				CDeaths(FP,AtLeast,(2^i)*DivNum,Ptr);
			},
			actions = {
				SetMemoryX(Ptr2,SetTo,(2^i)*Mask,2^i*Mask);
				SetCDeaths(FP,Subtract,(2^i)*DivNum,Ptr);
				PreserveTrigger();
			}
		}
	end
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

function S_to_EmS(Str)
	local X={}
	for i = 1, #Str do
		local Check = string.byte(string.sub(Str,i,i),1)
		if Check>=0x20 or Check~=string.byte(" ",1) then
			table.insert(X,string.char(163,128+string.byte(string.sub(Str,i,i),1)))
		else	
			table.insert(X,string.sub(Str,i,i))
		end
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
	return "\x07【 "..S_to_EmS(Convert_StrCode(Str)).." \x07】"
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
HeroPointArr = {}
function CreateHeroPointArr(Index,Name,Point,Type) --  영작 유닛 설정 함수
	local TextType1 = " 을(를) 처치하였습니다. "
	local TextType2 = " 를 획득하였습니다. "
	local Name2
	if Type == 1 then
		Name2 = TextType1
	elseif Type == 2 then
		Name2 = TextType2
	
	elseif Type == nil then
		Name2 = TextType1
	else
		PushErrorMsg("Need_Input_TextType")
	end
	local Text = StrDesignX("\x10기억\x04의 "..Name..""..Name2.."\x1F＋ "..N_to_EmN(Point).." \x1FＰｔｓ")
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
			DoActions(FP,{RotatePlayer({DisplayTextX(CT,4);},HumanPlayers,FP)})
			TriggerX(FP,{CDeaths(FP,AtMost,5,SoundLimit)},{RotatePlayer({PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg");},HumanPlayers,FP),
			SetCDeaths(FP,Add,1,SoundLimit),
		})
			f_LoadCp()
			CIfEnd()
			

	end
end
