P1=0
P2=1
P3=2
P4=3
P5=4
P6=5
P7=6
P8=7
P9=8
P10=9
P11=10
P12=11

CSetTo = 10
CAdd = 11
CSubtract = 12
AtLeast = 0
AtMost = 1
Exactly = 10
SetTo = 7
Add = 8
Subtract = 9

Above = 2
Below = 3
NotSame = 9

-- STR(X) ptr 고정 0x191943c8 --
-- TBL ptr 고정 0x19184660 --

CtrigInitArr = {}
for i = 1, 8 do
	CtrigInitArr[i] = {}
end

CJumpArr = {}
CJumpEndArr = {}
NJumpArr = {}
NJumpEndArr = {}
CIfArr = {}
CIfPArr = {}
CIfptr = 0
NIfArr = {}
NIfPArr = {}
NIfptr = 0
CWhileArr = {}
CWhilePArr = {}
CWhileptr = 0
NWhileArr = {}
NWhilePArr = {}
NWhileptr = 0
DWhileArr = {}
DWhilePArr = {}
DWhileptr = 0
CForArr = {}
CForPArr = {}
CForStep = {}
CForptr = 0
NIfXArr = {}
NIfXPArr = {}
NIfXptr = 0
CIfXArr = {}
CIfXPArr = {}
CIfXptr = 0
IndexAlloc = 0xE000 -- 0xE000 ~ 0xFF00 : If, While / 0xC000 ~ 0xD000 : Jump
FuncAlloc = 0xA000 -- 0xA000 ~ 0xBFFF : CMul, CDiv, CMod / CtrigFunc
VarXAlloc = 0xFF00 --  0xFF00 ~ 0xFFEF : Temp CVariable Alloc 
MAXVAlloc = 0xFF00
VarXReleaseLock = 0

LabelArr = {}

CRet = {0xFFF1,0xFFF2,0xFFF3,0xFFF4,0xFFF5,0xFFF6,0xFFF7,0xFFF8,0xFFF9,0xFFFA}

ForwardPoint = {}

PushTrigArr = {}
PushTrigStack = 0
PushCondArr = {}
PushCondStack = {}
PushActArr = {}
PushActStack = {}
CondStackCount = 0
StackArrptr = 0
CondLineArr = {}
ActLineArr = {}

FlagAlloc = 0 -- 0xFFF1 ~ 0xFFFA 의 CDeaths Code (0x0000FFF1 ~ 0x01DFFFFA)

EUDORPlayer = 0
EUDORFlag = 0

TTFCodeArr = {}
TTModeArr = {}
TTPushTrigArr = {}
TTPushCondArr = {}

TTPopTrigLock = 0
TPopTrigLock = 0

ORPushCondArr = {}
ORFCodeArr = {}
ORPopTrigLock = 0

STPushTrigArr = {}
STPopTrigLock = 0
RecoverCpValue = "X"
MoveCpValue = 0
CCArr = {}
CCPArr = {}
CCptr = 0

CForce1 = {0,0,0,0,0,0,0,0}
CForce2 = {0,0,0,0,0,0,0,0}
CForce3 = {0,0,0,0,0,0,0,0}
CForce4 = {0,0,0,0,0,0,0,0}
CAllPlayers = {0,0,0,0,0,0,0,0}

-- 맵 정보 입력 관련 함수 ---------------------------------------------------------------

function SetFixedPlayer(PlayerID)
	FixPlayer = PlayerID
end

function SetForces(defForce1,defForce2,defForce3,defForce4,defAllPlayers)
	for k, P in pairs(defForce1) do
		CForce1[P+1] = 1
	end

	for k, P in pairs(defForce2) do
		CForce2[P+1] = 1
	end

	for k, P in pairs(defForce3) do
		CForce3[P+1] = 1
	end

	for k, P in pairs(defForce4) do
		CForce4[P+1] = 1
	end

	for k, P in pairs(defAllPlayers) do
		CAllPlayers[P+1] = 1
	end
end

function PlayerConvert(PlayerID)
	local Temp = {}
	if type(PlayerID) == "number" or PlayerID == Force1 or PlayerID == Force2 or PlayerID == Force3 or PlayerID == Force4 or PlayerID == AllPlayers then
		PlayerID = {PlayerID}
	end
	
	local Input = {0,0,0,0,0,0,0,0}

	for k, P in pairs(PlayerID) do
		if P == Force1 then
			for i, v in pairs(CForce1) do
				if v == 1 then
					Input[i] = 1
				end
			end
		elseif P == Force2 then
			for i, v in pairs(CForce2) do
				if v == 1 then
					Input[i] = 1
				end
			end
		elseif P == Force3 then
			for i, v in pairs(CForce3) do
				if v == 1 then
					Input[i] = 1
				end
			end
		elseif P == Force4 then
			for i, v in pairs(CForce4) do
				if v == 1 then
					Input[i] = 1
				end
			end
		elseif P == AllPlayers then
			for i, v in pairs(CAllPlayers) do
				if v == 1 then
					Input[i] = 1
				end
			end
		else 
			Input[P+1] = 1
		end
	end

	for i = 1, 8 do
		if Input[i] == 1 then
			table.insert(Temp,i-1)
		end
	end

	return Temp
end

-- CtrigAsm 표준 환경 설치 함수 ---------------------------------------------------------

function StartCtrig()
	Trigger {
		players = {AllPlayers},
		conditions = {
			Label(0xFFFB);
		},
		actions = {
			SetNext(0xFFFB,0xFFFC);
		},
	}
	for i = 1, 10 do
		CVariable(AllPlayers,0xFFF0 + i)
	end
	Trigger {
		players = {AllPlayers},
		conditions = {
			Label(0xFFFC);
		},
		actions = {
			SetNext(0xFFFC,0xFFFD);
		},
	}
end

function EndCtrig()
	Trigger {
		players = {AllPlayers},
		conditions = { 
			Label(0xFFFD);
		},
		actions = {
		},
	}
	InitCtrig()
	Trigger {
		players = {AllPlayers},
		conditions = {
			Label(0xFFFE);
		},
		actions = {
			SetNext(0xFFFC,0xFFFC,1);
			SetNext(0xFFFD,0xFFFE);
			SetNext(0xFFFE,0xFFFF);
		},
	}
	for i = 0xFF00, MAXVAlloc do
		CVariable(AllPlayers,i)
	end
	Trigger { 
		players = {AllPlayers},
		conditions = {
			Label(0xFFFF);
		},
	}

end

-- 기본 내장 조건/액션 (.py) ------------------------------------------------------------

function Label(Index)
	local Label = Condition(0,0,Index,0,Exactly,0xFE,0,0x2) -- flag : 조건/액션 - 0x2 = Disabled
	if Index >= 1 then
		table.insert(LabelArr,Index)
	end
	return Label
end

function CtrigX(Player,Index,Address,Next,Type,Value,Mask)

	if Player == "X" then 
		Player = nil
	end
	if Index == "X" then 
		Index = nil
	end
	if Next == "X" then 
		Next = nil
	end
	if Mask == "X" then 
		Mask = nil
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
		Mflag = 1
	end

	local Nflag
	if Next == 0 or Next == nil then
		Nflag = 0
	elseif Next == 1 then 
		Nflag = 1
	else
		Nflag = 0
		Address = Address + 0x970*Next
	end

	local Cflag
	if Index == nil then
		Index = 0
		Cflag = 1
	else
		Cflag = 0
	end

	local Rflag
	Rflag = Pflag + 16*Nflag + 32*Mflag + 64*Cflag

	local ExCtrigX = Condition(Mask,Address/4,Value,Index,Type,0xFF,Rflag,0x10) -- #DefCond
	return ExCtrigX
end

function SetCtrigX(Player1,Index1,Address1,Next1,Type,Player2,Index2,Address2,EPD2,Next2,Mask)
	if Player1 == "X" then 
		Player1 = nil
	end
	if Index1 == "X" then 
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
	if Next2 == "X" then 
		Next2 = nil
	end
	if EPD2 == "X" then
		EPD2 = nil
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
		Nflag1 = 1
	else
		Nflag1 = 0
		Address1 = Address1 + 0x970*Next1
	end

	local Cflag1
	if Index1 == nil then
		Index1 = 0
		Cflag1 = 1
	else
		Cflag1 = 0
	end

	local Rflag1
	Rflag1 = Pflag1 + 16*Nflag1 + 32*Cflag1

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
		Nflag2 = 1
	else
		Nflag2 = 0
		Address2 = Address2 + 0x970*Next2
	end

	local Mflag2
	if Mask == nil then
		Mflag2 = 0
		Mask = 0
	else
		Mflag2 = 1
	end

	local Addr2
	if EPD2 == 0 or EPD2 == nil then
		Addr2 = Address2
		Eflag2 = 0
	else
		Addr2 = Address2/4
		Eflag2 = 1
	end

	local Cflag2
	if Index2 == nil then
		Index2 = 0
		Cflag2 = 1
	else
		Cflag2 = 0
	end

	local Rflag2
	Rflag2 = Pflag2 + 16*Nflag2 + 64*Mflag2 + 32*Eflag2 + 128*Cflag2

	local ExSetCtrigX = Action(Mask,Index1,Rflag1,Rflag2,Address1/4,Addr2,Index2,0xFF,Type,0x14) -- #DefAct
	return ExSetCtrigX
end

function SetCtrig1X(Player1,Index1,Address1,Next1,Type,Value,Mask)
	if Player1 == "X" then 
		Player1 = nil
	end
	if Index1 == "X" then 
		Index1 = nil
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
		Nflag1 = 1
	else
		Nflag1 = 0
		Address1 = Address1 + 0x970*Next1
	end

	local Cflag1
	if Index1 == nil then
		Index1 = 0
		Cflag1 = 1
	else
		Cflag1 = 0
	end

	local Rflag1
	Rflag1 = Pflag1 + 16*Nflag1 + 32*Cflag1

	local Mflag2
	if Mask == nil then
		Mflag2 = 0
		Mask = 0
	else
		Mflag2 = 1
	end

	Rflag2 = 64*Mflag2

	local ExSetCtrig1X = Action(Mask,Index1,Rflag1,Rflag2,Address1/4,Value,0,0xFF,Type,0x14)
	return ExSetCtrig1X
end

function SetCtrig2X(Offset,Type,Player2,Index2,Address2,EPD2,Next2,Mask)
	if Player2 == "X" then 
		Player2 = nil
	end
	if Index2 == "X" then 
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
		Nflag2 = 1
	else
		Nflag2 = 0
		Address2 = Address2 + 0x970*Next2
	end

	local Mflag2
	if Mask == nil then
		Mflag2 = 0
		Mask = 0
	else
		Mflag2 = 1
	end

	local Addr2
	if EPD2 == 0 or EPD2 == nil then
		Addr2 = Address2
		Eflag2 = 0
	else
		Addr2 = Address2/4
		Eflag2 = 1
	end

	local Cflag2
	if Index2 == nil then
		Index2 = 0
		Cflag2 = 1
	else
		Cflag2 = 0
	end

	local Rflag2
	Rflag2 = Pflag2 + 16*Nflag2 + 64*Mflag2 + 32*Eflag2 + 128*Cflag2

	local Offset2
	if Offset == "Cp" then
		Offset2 = 13
	else
		Offset2 = EPD(Offset)
	end

	local ExSetCtrig2X = Action(Mask,0,0,Rflag2,Offset2,Addr2,Index2,0xFF,Type,0x14)
	return ExSetCtrig2X
end

-- 오류 체크 기본 함수 ------------------------------------------------------------------

function ErrorCheck() -- Ctrig 문법 오류 점검 함수
	AllocCheck()
	LabelCheck()
	ControlCheck()
end

function AllocCheck()
	if IndexAlloc >= 0xFF00 then
		IndexAllocation_Overflow()
	end
	if FuncAlloc >= 0xBFF0 then
		FuncAllocation_Overflow()
	end
	if FlagAlloc >= 4800 then
		FlagAllocation_Overflow()
	end
	if VarXAlloc >= 0xFFF0 then
		VarXAllocation_Overflow()
	end
end

function LabelCheck() -- Label 중복 체크
	local C
	for i,key in pairs(LabelArr) do
		C = 0
		for j,v in pairs(LabelArr) do
			if v == key then
				C = C + 1
			end
		end
		if C >= 2 then
			
			
			_G["Label_duplicated! Current Label : 0x"..string.format("%X",LabelArr[i])]() -- push error msg
		end
		if key == 0xFFF0 then
			Prohibited_Label()
		end
	end
end

function ControlCheck() -- 제어문 입력 오류 체크
	for i, key in pairs(CJumpArr) do
		local X = nil
		for k, v in pairs(CJumpEndArr) do
			if v == key then
				X = 1
			end
		end
		if X == nil then
			CJumppair_missing()
		end
	end
	for i, key in pairs(NJumpArr) do
		local X = nil
		for k, v in pairs(NJumpEndArr) do
			if v == key then
				X = 1
			end
		end
		if X == nil then
			NJumppair_missing()
		end
	end

	for k, v in pairs(CIfArr) do
		if v ~= nil then
			CIfpair_missing()
		end
	end
	for k, v in pairs(NIfArr) do
		if v ~= nil then
			_G["NIfpair_missing! Current Label : 0x"..string.format("%X",NIfArr[k])]()
		end
	end
	for k, v in pairs(CWhileArr) do
		if v ~= nil then
			CWhilepair_missing()
		end
	end
	for k, v in pairs(NWhileArr) do
		if v ~= nil then
			NWhilepair_missing()
		end
	end
	for k, v in pairs(DWhileArr) do
		if v ~= nil then
			DoWhilepair_missing()
		end
	end
	for k, v in pairs(CForArr) do
		if v ~= nil then
			CForpair_missing()
		end
	end
	for k, v in pairs(CIfXArr) do
		if v ~= nil then
			CIfXpair_missing()
		end
	end
	for k, v in pairs(NIfXArr) do
		if v ~= nil then
			NIfXpair_missing()
		end
	end
end

-- 표준 입출력 및 변환 함수 -------------------------------------------------------------

function CAddr(Section,Line,Next) -- Convert (Data -> Mem_Address)
	if Line == "X" or Line == nil then
		Line = 1
	end
	Line = Line - 1
	local Offset

	if Section == "Prev" then
		Offset = 0
	end
	if Section == "Next" then
		Offset = 0x4
	end
	if Section == "Internal" then
		Offset = 0x948
	end

	if Section == "CMask" then
		Offset = 0x0
		Offset = Offset + 0x14 * Line + 0x8
	end
	if Section == "CEPD" then
		Offset = 0x4
		Offset = Offset + 0x14 * Line + 0x8
	end
	if Section == "CType" then
		Offset = 0xC
		Offset = Offset + 0x14 * Line + 0x8
	end
	if Section == "CValue" then
		Offset = 0x8
		Offset = Offset + 0x14 * Line + 0x8
	end
	if Section == "CFlag" then
		Offset = 0x10
		Offset = Offset + 0x14 * Line + 0x8
	end

	if Section == "Mask" then
		Offset = 0x0
		Offset = Offset + 0x20 * Line + 0x148
	end
	if Section == "Str" then
		Offset = 0x4
		Offset = Offset + 0x20 * Line + 0x148
	end
	if Section == "Wav" then
		Offset = 0x8
		Offset = Offset + 0x20 * Line + 0x148
	end
	if Section == "Time" then
		Offset = 0xC
		Offset = Offset + 0x20 * Line + 0x148
	end
	if Section == "EPD" then
		Offset = 0x10
		Offset = Offset + 0x20 * Line + 0x148
	end
	if Section == "Type" then
		Offset = 0x18
		Offset = Offset + 0x20 * Line + 0x148
	end
	if Section == "Value" then
		Offset = 0x14
		Offset = Offset + 0x20 * Line + 0x148
	end
	if Section == "Flag" then
		Offset = 0x1C
		Offset = Offset + 0x20 * Line + 0x148
	end

	if Next == nil or Next == "X" then
		Next = 0
	end

	local CAddress = Next * 0x970 + Offset
	return CAddress
end

function DtoA(Player,UnitId) -- Convert(Deaths -> OffSet)
 	local DtoA = 0x58A364 + 0x30 * ParseUnit(UnitId) + 0x4 * Player
 	return DtoA
end 

-- CIf : 2 / NIf : 3 / CWhile : 3 / NWhile : 4 / DoWhile : 2 / CFor : 4 / CIfX : 1* / NIfX : 1*
function Forward(Move) -- Return(Struct_Index)
	if Move == nil then
		Move = 0
	end
	local Forward = IndexAlloc + Move
	return Forward
end

function Struct(Type,Number) -- Convert(Data -> Forward_Move)
	local Struct
	if Type == "CIfX" or Type == "NIfX" then
		Struct = Number	* 2	
	elseif Type == "CIf" or Type == "DoWhile" then
		Struct = Number * 2
	elseif Type == "CWhile" or Type == "NIf" then
		Struct = Number * 3
	elseif Type == "NWhile" or Type == "CFor" then
		Struct = Number * 4
	end
	return Struct
end

function Ccode(Index,Line) -- Convert(Data -> N/CDeaths_Code)
	local Ccode = Line*0x10000 + Index
	return Ccode
end

-- "X" -> nil
-- Number -> Return(Constant Data) --
-- "Cp" -> Return(CurrentPlayer Data)

function V(Index,Player,Next) -- Return(Variable Data)
	if Player == nil then
		Player = "X"
	end
	return {Player,Index,Next,"V"}
end

function Vi(Index,Deviation,Player,Next) -- Return(Variable Data+) : T,TT Cond/Act 전용 / SetRecoverCp / Arr,VArr
	if Deviation == "X" or Deviation == nil then
		Deviation = 0
	end
	if Player == nil then
		Player = "X"
	end
	return {Player,Index,Next,"V",Deviation}
end

function X(Lua_Variable) -- Convert(Lua_Var -> Return(Variable Data))
	return {Lua_Variable[1],Lua_Variable[2],Lua_Variable[3],"V"}
end

function Mem(Player,Index,Address,Next,EPDflag) -- Return(Ctrig Memory Data)
	if Player == nil then
		Player = "X"
	end
	if EPDflag == "X" or EPDflag == nil or EPDflag == 0 then
		EPDflag = nil
	else
		EPDflag = 1
	end
	return {Player,Index,Address,Next,EPDflag}
end

function _Mem(Variable,Address,Next,EPDflag) -- Convert(Variable Data -> Ctrig Memory Data)
	if Variable[3] == nil then
		Variable[3] = 0
	end
	if EPDflag == "X" or EPDflag == nil or EPDflag == 0 then
		EPDflag = nil
	else
		EPDflag = 1
	end
	if Variable[4] ~= "V" then
		_Mem_InputData_Error()
	end
	if Address == "X" or Address == nil then
		Address = 0x15C
	end
	if Next == "X" or Next == nil then
		Next = 0
	end
	return {Variable[1],Variable[2],Address,Variable[3]+Next,EPDflag}
end

function Arr(Array,Index,Player) -- 1, V, _Mov(VArr()) 사용
	if type(Player) == "table" then
		Arr_InputData_Error()
	end
	if Player == nil then
		Player = "X"
	else
		Array[1] = Player
	end

	if type(Index) == "number" then
		return {Player,Array[2],(Index+(math.floor(Index/602))*2)*4,0}
	elseif Index[4] == "V" then
		local Temp = VarXAlloc
		local TempData = {"X",Temp,0,"A",Array}

		if Index[5] == nil then
			Index[5]= 0
		end

		table.insert(STPushTrigArr,{"Arr",{"X",Temp,0,"V"},Index})

		VarXAlloc = VarXAlloc + 1
		if VarXAlloc > MAXVAlloc then
			MAXVAlloc = VarXAlloc
		end
		return TempData
	else
		Arr_InputData_Error()
	end
end

function ArrX(Array,Index,Player) -- 1, V, _Mov(VArr()) 사용
	if type(Player) == "table" then
		ArrX_InputData_Error()
	end
	if Player == nil then
		Player = "X"
	else
		Array[1] = Player
	end

	if type(Index) == "number" then
		return {Player,Array[2],(Index+(math.floor(Index/602))*2)*4,0}
	elseif Index[4] == "V" then
		return {Index[1],Index[2],Index[3],"A",Array}
	else
		ArrX_InputData_Error()
	end
end

function ConvertArr(PlayerID,Dest,Source) -- V << (i+D)/301 -> V SetTo 0 0x1 -> V += Arr
	-- Dest = TempV, Source = Index, Operand = Arr / V << V 전용
	STPopTrigArr(PlayerID)
	if Source[4] == "VA" or Dest[4] == "VA" then
		ConvertArr_InputData_Error()
	end

	if Source[5] == nil then
		Source[5] = 0
	end
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(0);
		},
		actions = {
			SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,0);
			SetCtrig1X("X",CRet[1],0x15C,0,SetTo,Source[5]);
			SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
			SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Add*16777216,0xFF000000);
			SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
			CallLabelAlways(Source[1],Source[2],Source[3]);
		},
		flag = {Preserved}
	}

	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(FuncAlloc);
			CtrigX("X",CRet[1],0x15C,0,AtMost,601);
		},
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",FuncAlloc+1,0,0,0);
		},
		flag = {Preserved}
	}

	for i = 22, 0, -1 do
		local CBit = 2^i
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,602*CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,602*CBit);
					SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,2*CBit);
				},
				flag = {Preserved}
			}
	
	end

	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(FuncAlloc+1);
		},
		actions = {
			SetCtrigX("X",FuncAlloc,0x4,0,SetTo,"X",FuncAlloc,0,0,1);
			SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,Source[5]);
			SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
			SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Add*16777216,0xFF000000);
			SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
			CallLabelAlways(Source[1],Source[2],Source[3]);
		},
		flag = {Preserved}
	}
	FuncAlloc = FuncAlloc + 2
end

function GetVArray(Header)
	return {"X",Header[2],0,"V"}
end

function VArr(VArray,Index,Player) -- 1, V, _Mov(VArr()) 사용
	if type(Player) == "table" then
		VArr_InputData_Error()
	end
	if Player == nil then
		Player = "X"
	else
		VArray[1] = Player
	end
	
	if type(Index) == "number" then
		return {Player,VArray[2],Index,"V"}
	elseif Index[4] == "V" then
		local Temp = VarXAlloc
		local TempData = {"X",Temp,0,"VA",VArray,0,"X",Temp+1,0}

		if Index[5] == nil then
			Index[5] = 0
		end
		
		table.insert(STPushTrigArr,{"VArr",{"X",Temp,0,"V"},{"X",Temp+1,0,"V"},Index}) 

		VarXAlloc = VarXAlloc + 2
		if VarXAlloc > MAXVAlloc then
			MAXVAlloc = VarXAlloc
		end
		return TempData
	else
		VArr_InputData_Error()
	end
end

function VArrX(VArray,Index,Index4,Player) -- 1, V, _Mov(VArr()) 사용
	if type(Player) == "table" then
		VArrX_InputData_Error()
	end
	if Player == nil then
		Player = "X"
	else
		VArray[1] = Player
	end

	if type(Index) == "number" then
		return {Player,VArray[2],Index,"V"}
	elseif Index[4] == "V" and Index4[4] == "V" then
		if Index[5] == nil then
			Index[5] = 0
		end
		return {Index[1],Index[2],Index[3],"VA",VArray,Index[5]*604,Index4[1],Index4[2],Index4[3]}
	else
		VArrX_InputData_Error()
	end
end

function ConvertVArr(PlayerID,Dest,Dest4,Source) -- V << (i+D) * 604 -> V += Arr
	-- Dest = TempV, Source = Index, Operand = Arr / V << V 전용
	STPopTrigArr(PlayerID)
	if Source[4] == "VA" or Dest[4] == "VA" or Dest4[4] == "VA" then
		ConvertVArr_InputData_Error()
	end

	if Source[5] == nil then
		Source[5] = 0
	end
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(0);
		},
		actions = {
			SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Source[5]*604);
			SetCtrig1X(Dest4[1],Dest4[2],0x15C,Dest4[3],SetTo,Source[5]*2416);
		},
		flag = {Preserved}
	}

	for i = 0, 11 do
		local CBit = 2^i
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Source[1],Source[2],0x15C,Source[3],Exactly,CBit,CBit);
			},
			actions = {
				SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,CBit*604);
				SetCtrig1X(Dest4[1],Dest4[2],0x15C,Dest4[3],Add,CBit*2416);
			},
			flag = {Preserved}
		}
	end
end

function MovX(PlayerID,Dest,Source,Mode,Mask) -- V << VA / VA,A << V (Value) / 내부함수 (사용 권장X)
	--STPopTrigArr(PlayerID)
	if Mode == "X" or Mode == nil then
		Mode = SetTo
	end
	if Mask == "X" or Mask == nil then
		Mask = 0xFFFFFFFF
	end

	if Dest[4] == "V" and Source[4] == "VA" then -- Mov V, VA / {Index[1],Index[2],Index[3],"VA",VArray(VAPlayer,VAIndex,0),Index[5]}
		Trigger {--(CPRead)로 값 출력
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x15C,2,SetTo,Source[5][1],Source[5][2],0,0,Source[5][3]); 
					SetCtrig1X("X","X",0x15C,2,Add,Source[6]*4);

					SetCtrig2X(0x6509B0,SetTo,Source[5][1],Source[5][2],0,1,Source[5][3]); 
					SetMemory(0x6509B0,Add,Source[6]);

					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Add*16777216,0xFF000000);
					SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,EPD(0x6509B0)); 
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}

		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X(Source[7],Source[8],0x148,Source[9],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[7],Source[8],0x160,Source[9],SetTo,Add*16777216,0xFF000000);
					SetCtrigX(Source[7],Source[8],0x158,Source[9],SetTo,"X","X",0x15C,1,1); 
					CallLabelAlways(Source[7],Source[8],Source[9]);
				},
				flag = {Preserved}
			}

		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X","X",0x4,0,SetTo,0); -- SetCtrigX("X","X",0x4,0,SetTo,VA[1],VA[2],0,0,VA[3]);
					SetMemory(0x6509B0,Add,(0x158-0x0)/4);
					SetCtrig2X("Cp",SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);	-- SetCtrigX(VA[1],VA[2],0x158,VA[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
					SetMemory(0x6509B0,Add,(0x4-0x158)/4);
					SetCtrig2X("Cp",SetTo,"X","X",0,0,1); -- SetCtrigX(VA[1],VA[2],0x4,VA[3],SetTo,"X","X",0,0,1);
					SetMemory(0x6509B0,Add,(0x148-0x4)/4);
					SetDeaths(CurrentPlayer,SetTo,Mask,0); -- SetCtrig1X(VA[1],VA[2],0x148,VA[3],SetTo,0xFFFFFFFF);
					SetMemory(0x6509B0,Add,(0x160-0x148)/4);
					SetDeathsX(CurrentPlayer,SetTo,Mode*16777216,0,0xFF000000); -- SetCtrig1X(VA[1],VA[2],0x160,VA[3],SetTo,SetTo*16777216,0xFF000000);

				},
				flag = {Preserved}
			}

		RecoverCp(PlayerID)

		-- Ctrig->Ctrig->Ctrig Version : Cp사용 X
		--[[
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x158,3,SetTo,Source[5][1],Source[5][2],0x158,1,Source[5][3]); 
					SetCtrigX("X","X",0x17C,3,SetTo,Source[5][1],Source[5][2],0,0,Source[5][3]); 
					SetCtrigX("X","X",0x198,3,SetTo,Source[5][1],Source[5][2],0x4,1,Source[5][3]); 
					SetCtrig1X("X","X",0x158,3,Add,Source[6]);
					SetCtrig1X("X","X",0x17C,3,Add,Source[6]*4);
					SetCtrig1X("X","X",0x198,3,Add,Source[6]);
					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Add*16777216,0xFF000000);
					SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X","X",0x158,1,3); 
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}

		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X","X",0x198,1,2); 
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}

		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X(Source[7],Source[8],0x148,Source[9],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[7],Source[8],0x160,Source[9],SetTo,Add*16777216,0xFF000000);
					SetCtrigX(Source[7],Source[8],0x158,Source[9],SetTo,"X","X",0x17C,1,1); 
					CallLabelAlways(Source[7],Source[8],Source[9]);
				},
				flag = {Preserved}
			}

		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig2X(0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);	-- SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
					SetCtrig1X("X","X",0x4,0,SetTo,0); -- SetCtrigX("X","X",0x4,0,SetTo,Source[1],Source[2],0,0,Source[3]);
					SetCtrig2X(0,SetTo,"X","X",0,0,1); -- SetCtrigX(Source[1],Source[2],0x4,Source[3],SetTo,"X","X",0,0,1);
				},
				flag = {Preserved}
			}
			]]--
	elseif Dest[4] == "VA" and Source[4] == "V" then -- Mov VA, V 
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x15C,1,SetTo,Dest[5][1],Dest[5][2],0x15C,1,Dest[5][3]); 
					SetCtrig1X("X","X",0x15C,1,Add,Dest[6]);
					SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,Add*16777216,0xFF000000);
					SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X","X",0x15C,1,1);
					CallLabelAlways(Dest[1],Dest[2],Dest[3]);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,0); 
					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,Mask);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Mode*16777216,0xFF000000);
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}
	elseif Dest[4] == "A" and Source[4] == "V" then -- Mov A, V 
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x15C,1,SetTo,Dest[5][1],Dest[5][2],0,1,Dest[5][3]); 
					SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,Add*16777216,0xFF000000);
					SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X","X",0x15C,1,1); 
					CallLabelAlways(Dest[1],Dest[2],Dest[3]);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,0); 
					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,Mask);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Mode*16777216,0xFF000000);
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}
	else
		MovX_InputData_Error()
	end
end

function MovZ(PlayerID,Dest,Source,Address) -- V << VA_EPD, A_EPD / 내부함수 (사용 권장X)
	--STPopTrigArr(PlayerID)
	if Address == nil then
		Address = 0
	end
	if Dest[4] == "V" and Source[4] == "VA" then -- Mov V, VA_EPD / {Index[1],Index[2],Index[3],"VA",VArray(VAPlayer,VAIndex,0),Index[5]}
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Source[5][1],Source[5][2],Address,1,Source[5][3]); 
					SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,Source[6]);
					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Add*16777216,0xFF000000);
					SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]); 
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}
	elseif Dest[4] == "V" and Source[4] == "A" then -- Mov V, A_EPD / {Index[1],Index[2],Index[3],"A",Array(APlayer,AIndex,0)}
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Source[5][1],Source[5][2],0,1,Source[5][3]); 
					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Add*16777216,0xFF000000);
					SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]); 
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}
	else
		MovZ_InputData_Error()
	end
end

function TMem(PlayerID,Dest,Source,Address,Next,OffsetFlag) -- V << V_EPD/Offset, Mem_EPD/Offset, A_EPD/Offset, VA_EPD/Offset
	STPopTrigArr(PlayerID)
	if OffsetFlag == "X" or OffsetFlag == nil then
		OffsetFlag = 0
	end
	if Address == "X" or Address == nil then
		Address = 0x15C
	end
	if Next == "X" or Next == nil then
		Next = 0
	end

	if Dest[4] == "V" then
		if Source[4] == "V" then
			if Source[3] == nil or Source[3] == "X" then
				Source[3] = 0 
			end
			if OffsetFlag == 0 then
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Source[1],Source[2],Address,1,Source[3]+Next); 
					},
					flag = {Preserved}
				}
			else
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Source[1],Source[2],Address,0,Source[3]+Next); 
					},
					flag = {Preserved}
				}
			end
		elseif Source[4] == "A" then
			if OffsetFlag == 0 then
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Source[5][1],Source[5][2],0,1,Source[5][3]); 
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Add*16777216,0xFF000000);
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]); 
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
			else
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Source[5][1],Source[5][2],0,1,Source[5][3]); 
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Add*16777216,0xFF000000);
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]); 
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,1452249);
						SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,Add*16777216,0xFF000000);
						SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]); 
						CallLabelAlways(Dest[1],Dest[2],Dest[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,Add*16777216,0xFF000000);
						SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]); 
						CallLabelAlways(Dest[1],Dest[2],Dest[3]);
					},
					flag = {Preserved}
				}
			end
		elseif Source[4] == "VA" then
			if OffsetFlag == 0 then
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Source[5][1],Source[5][2],Address,1,Source[5][3]+Next); 
						SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,Source[6]);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Add*16777216,0xFF000000);
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]); 
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
			else
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Source[5][1],Source[5][2],Address,0,Source[5][3]+Next); 
						SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,Source[6]*4);
						SetCtrig1X(Source[7],Source[8],0x148,Source[9],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[7],Source[8],0x160,Source[9],SetTo,Add*16777216,0xFF000000);
						SetCtrigX(Source[7],Source[8],0x158,Source[9],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]); 
						CallLabelAlways(Source[7],Source[8],Source[9]);
					},
					flag = {Preserved}
				}
			end
		else
			if OffsetFlag == 0 then
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Source[1],Source[2],Source[3],1,Source[4]); 
					},
					flag = {Preserved}
				}
			else
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Source[1],Source[2],Source[3],0,Source[4]); 
					},
					flag = {Preserved}
				}
			end
		end
	else
		_TMem_InputData_Error()
	end
end

function CMovX(PlayerID,Dest,Source,Mode,Mask) -- V << VA / VA,A << V (Value)
	STPopTrigArr(PlayerID)
	if Mode == "X" or Mode == nil then
		Mode = SetTo
	end
	if Mask == "X" or Mask == nil then
		Mask = 0xFFFFFFFF
	end

	if type(Dest) == "number" and Source[4] == "VA" then -- Mov V, VA / {Index[1],Index[2],Index[3],"VA",VArray(VAPlayer,VAIndex,0),Index[5]}
		Trigger {--(CPRead)로 값 출력
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x15C,2,SetTo,Source[5][1],Source[5][2],0,0,Source[5][3]); 
					SetCtrig1X("X","X",0x15C,2,Add,Source[6]*4);

					SetCtrig2X(0x6509B0,SetTo,Source[5][1],Source[5][2],0,1,Source[5][3]); 
					SetMemory(0x6509B0,Add,Source[6]);

					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Add*16777216,0xFF000000);
					SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,EPD(0x6509B0)); 
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}

		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X(Source[7],Source[8],0x148,Source[9],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[7],Source[8],0x160,Source[9],SetTo,Add*16777216,0xFF000000);
					SetCtrigX(Source[7],Source[8],0x158,Source[9],SetTo,"X","X",0x15C,1,1); 
					CallLabelAlways(Source[7],Source[8],Source[9]);
				},
				flag = {Preserved}
			}

		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X","X",0x4,0,SetTo,0); -- SetCtrigX("X","X",0x4,0,SetTo,VA[1],VA[2],0,0,VA[3]);
					SetMemory(0x6509B0,Add,(0x158-0x0)/4);
					SetDeaths(CurrentPlayer,SetTo,EPD(Dest),0);	-- SetCtrigX(VA[1],VA[2],0x158,VA[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
					SetMemory(0x6509B0,Add,(0x4-0x158)/4);
					SetCtrig2X("Cp",SetTo,"X","X",0,0,1); -- SetCtrigX(VA[1],VA[2],0x4,VA[3],SetTo,"X","X",0,0,1);
					SetMemory(0x6509B0,Add,(0x148-0x4)/4);
					SetDeaths(CurrentPlayer,SetTo,Mask,0); -- SetCtrig1X(VA[1],VA[2],0x148,VA[3],SetTo,0xFFFFFFFF);
					SetMemory(0x6509B0,Add,(0x160-0x148)/4);
					SetDeathsX(CurrentPlayer,SetTo,Mode*16777216,0,0xFF000000); -- SetCtrig1X(VA[1],VA[2],0x160,VA[3],SetTo,SetTo*16777216,0xFF000000);

				},
				flag = {Preserved}
			}

		RecoverCp(PlayerID)
	elseif Dest[4] == "V" and Source[4] == "VA" then -- Mov V, VA / {Index[1],Index[2],Index[3],"VA",VArray(VAPlayer,VAIndex,0),Index[5]}
		Trigger {--(CPRead)로 값 출력
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x15C,2,SetTo,Source[5][1],Source[5][2],0,0,Source[5][3]); 
					SetCtrig1X("X","X",0x15C,2,Add,Source[6]*4);

					SetCtrig2X(0x6509B0,SetTo,Source[5][1],Source[5][2],0,1,Source[5][3]); 
					SetMemory(0x6509B0,Add,Source[6]);

					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Add*16777216,0xFF000000);
					SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,EPD(0x6509B0)); 
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}

		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X(Source[7],Source[8],0x148,Source[9],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[7],Source[8],0x160,Source[9],SetTo,Add*16777216,0xFF000000);
					SetCtrigX(Source[7],Source[8],0x158,Source[9],SetTo,"X","X",0x15C,1,1); 
					CallLabelAlways(Source[7],Source[8],Source[9]);
				},
				flag = {Preserved}
			}

		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X","X",0x4,0,SetTo,0); -- SetCtrigX("X","X",0x4,0,SetTo,VA[1],VA[2],0,0,VA[3]);
					SetMemory(0x6509B0,Add,(0x158-0x0)/4);
					SetCtrig2X("Cp",SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);	-- SetCtrigX(VA[1],VA[2],0x158,VA[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
					SetMemory(0x6509B0,Add,(0x4-0x158)/4);
					SetCtrig2X("Cp",SetTo,"X","X",0,0,1); -- SetCtrigX(VA[1],VA[2],0x4,VA[3],SetTo,"X","X",0,0,1);
					SetMemory(0x6509B0,Add,(0x148-0x4)/4);
					SetDeaths(CurrentPlayer,SetTo,Mask,0); -- SetCtrig1X(VA[1],VA[2],0x148,VA[3],SetTo,0xFFFFFFFF);
					SetMemory(0x6509B0,Add,(0x160-0x148)/4);
					SetDeathsX(CurrentPlayer,SetTo,Mode*16777216,0,0xFF000000); -- SetCtrig1X(VA[1],VA[2],0x160,VA[3],SetTo,SetTo*16777216,0xFF000000);

				},
				flag = {Preserved}
			}

		RecoverCp(PlayerID)
	elseif Dest[4] == "VA" then -- Mov VA, V 
		if type(Source) == "number" then
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x158,1,SetTo,Dest[5][1],Dest[5][2],0x15C,1,Dest[5][3]); 
					SetCtrig1X("X","X",0x158,1,Add,Dest[6]);
					SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,Add*16777216,0xFF000000);
					SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X","X",0x158,1,1);
					CallLabelAlways(Dest[1],Dest[2],Dest[3]);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetMemoryX(0,SetTo,Source,Mask); 
				},
				flag = {Preserved}
			}
		elseif Source[4] == "V" then
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x15C,1,SetTo,Dest[5][1],Dest[5][2],0x15C,1,Dest[5][3]); 
					SetCtrig1X("X","X",0x15C,1,Add,Dest[6]);
					SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,Add*16777216,0xFF000000);
					SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X","X",0x15C,1,1);
					CallLabelAlways(Dest[1],Dest[2],Dest[3]);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,0); 
					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,Mask);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Mode*16777216,0xFF000000);
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}
		end
	elseif Dest[4] == "A" then -- Mov A, V 
		if type(Source) == "number" then
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x158,1,SetTo,Dest[5][1],Dest[5][2],0,1,Dest[5][3]); 
					SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,Add*16777216,0xFF000000);
					SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X","X",0x158,1,1); 
					CallLabelAlways(Dest[1],Dest[2],Dest[3]);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetMemoryX(0,Mode,Source,Mask); 
				},
				flag = {Preserved}
			}
		elseif Source[4] == "V" then
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x15C,1,SetTo,Dest[5][1],Dest[5][2],0,1,Dest[5][3]); 
					SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,Add*16777216,0xFF000000);
					SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X","X",0x15C,1,1); 
					CallLabelAlways(Dest[1],Dest[2],Dest[3]);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,0); 
					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,Mask);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Mode*16777216,0xFF000000);
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}
		end
	else
		CMovX_InputData_Error()
	end
end

-- CurrentPlayer 관련 함수 / CunitCtrig -------------------------------------------------------------

function RecoverCp(PlayerID)
	if RecoverCpValue == "X" then	
		PlayerID = PlayerConvert(PlayerID)
		for k, P in pairs(PlayerID) do
			Trigger {
				players = {P},
				conditions = {
					Label(0);
				},
				actions = {
					SetMemory(0x6509B0,SetTo,P);
				},
				flag = {Preserved}
			}	
		end
	elseif type(RecoverCpValue) == "number" then
		Trigger {
				players = {PlayerID},
				conditions = {
					Label(0);
				},
				actions = {
					SetMemory(0x6509B0,SetTo,RecoverCpValue);
				},
				flag = {Preserved}
			}	
	elseif RecoverCpValue[4] == "V" then -- 변수입력 Vi 가능
		if RecoverCpValue[5] == nil then
			RecoverCpValue[5] = 0
		end
		Trigger {
				players = {PlayerID},
				conditions = {
					Label(0);
				},
				actions = {
					SetMemory(0x6509B0,SetTo,RecoverCpValue[5]);
					SetCtrig1X(RecoverCpValue[1],RecoverCpValue[2],0x158,RecoverCpValue[3],SetTo,EPD(0x6509B0));
					SetCtrig1X(RecoverCpValue[1],RecoverCpValue[2],0x148,RecoverCpValue[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(RecoverCpValue[1],RecoverCpValue[2],0x160,RecoverCpValue[3],SetTo,Add*16777216,0xFF000000);
					CallLabelAlways(RecoverCpValue[1],RecoverCpValue[2],RecoverCpValue[3]);
				},
				flag = {Preserved}
			}	
	end
end

function SetRecoverCp(Cp)
	if Cp == nil then
		Cp = "X"
	end
	RecoverCpValue = Cp
end

function MoveCp(Type,Value)
	local CpValue
	local CpRet
	if Type == nil then
		CpRet = MoveCpValue
	else
		if Type == Add then
			CpValue = Value/4
			MoveCpValue = MoveCpValue + Value
			CpRet = SetMemory(0x6509B0,Add,CpValue)
		elseif Type == Subtract then
			CpValue = (0-Value)/4
			MoveCpValue = MoveCpValue - Value
			CpRet = SetMemory(0x6509B0,Add,CpValue)
		elseif Type == SetTo then
			CpValue = (Value-MoveCpValue)/4
			MoveCpValue = Value
			CpRet = SetMemory(0x6509B0,Add,CpValue)
		elseif Type == "X" or Type == "Clear" then
			if Value == nil then
				Value = 0
			end
			MoveCpValue = Value
			CpRet = nil
		end
	end
	return CpRet
end

function SaveCp(PlayerID,Output,OffsetOutput)
	if OffsetOutput == "X" then
		OffsetOutput = nil
	end
	if Output == "X" then
		Output = nil
	end

	local CPRead1 = {}
	if Output[4] == "V" then
		table.insert(CPRead1,SetCtrig1X(Output[1],Output[2],0x15C,Output[3],SetTo,0))
	elseif Output[4] == "VA" then
		SaveCp_InputData_Error() 
	end
	if OffsetOutput ~= nil then
		if OffsetOutput[4] == "V" then
			table.insert(CPRead1,SetCtrig1X(OffsetOutput[1],OffsetOutput[2],0x15C,OffsetOutput[3],SetTo,0x58A364))
		elseif OffsetOutput[4] == "VA" then
			SaveCp_InputData_Error() 
		end
	end
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = { 
			Label(0);
		},
		actions = {
			CPRead1,
		},
		flag = {Preserved}
		
	}
	for i = 0, 31 do
		local CPRead2 = {}
		local CBit = 2^i
		if Output[4] == "V" then
			table.insert(CPRead2,SetCtrig1X(Output[1],Output[2],0x15C,Output[3],Add,CBit)) 
		elseif Output[4] == "VA" then
			SaveCp_InputData_Error() 
		end
		if OffsetOutput ~= nil then
			if OffsetOutput[4] == "V" and i <= 29 then
				table.insert(CPRead2,SetCtrig1X(OffsetOutput[1],OffsetOutput[2],0x15C,OffsetOutput[3],Add,CBit*4))
			elseif OffsetOutput[4] == "VA" then
				SaveCp_InputData_Error() 
			end
		end
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			   	MemoryX(0x6509B0,Exactly,CBit,CBit);
			},
			actions = {
				CPRead2,
			},
			flag = {Preserved}
		}
	end
end

function LoadCp(PlayerID,Cp)
	SetRecoverCp(Cp)
	RecoverCp(PlayerID)
end

function LoadCpX(PlayerID,Cp)
	local TempCp = RecoverCpValue
	SetRecoverCp(Cp)
	RecoverCp(PlayerID)
	SetRecoverCp(TempCp)
end

function CunitCtrig_Part1(PlayerID,Actions)
	Trigger { -- Cunit Ctrig Start
		players = {ParsePlayer(PlayerID)},
		conditions = { 
			Label(0);
		},
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",FuncAlloc+2,0,0,1); 
		},
		flag = {Preserved}
	}	
	Trigger { -- Cunit Calc Selector
		players = {ParsePlayer(PlayerID)},
		conditions = { 
			Label(FuncAlloc);
		},
		actions = {
			SetDeathsX(0,SetTo,0,0,0xFFFFFFFF); -- RecoverNext
			Actions,
		},
		flag = {Preserved}
	}	
	PlayerID = PlayerConvert(PlayerID)
	table.insert(CCArr, FuncAlloc)
	table.insert(CCPArr, PlayerID)
	CCptr = CCptr + 1
	FuncAlloc = FuncAlloc + 3
end
-- NJump Trig 삽입 부분 (조건만족시 Jump)
function CunitCtrig_Part2()
	PlayerID = CCPArr[CCptr]
	PlayerID = PlayerConvert(PlayerID)
	for k, P in pairs(PlayerID) do
		Trigger { -- Cunit Calc Last
			players = {P},
			conditions = { 
				Label(CCArr[CCptr]+1);
			},
		   	actions = {
				SetDeathsX(0,SetTo,0,0,0xFFFFFFFF); -- RecoverNext
				SetMemory(0x6509B0,SetTo,P); -- 루프를 돌릴 플레이어 값으로 맞추기 ( P1 = 0, P2 = 1, ... , P8 = 7 )
			},
			flag = {Preserved}
		}	
	end
end
-- Cunit 연산 트리거 삽입 부분 (Break/Clear로 Return)
function CunitCtrig_Part3(Conditions,Actions)
	PlayerID = CCPArr[CCptr]
	Trigger { -- Cunit Calc Start
		players = {ParsePlayer(PlayerID)},
		conditions = { 
			Label(CCArr[CCptr]+2);
		},
		flag = {Preserved}
	}	

	for i = 0 , 1699 do
		MoveCpValue = 0
		Trigger { -- Cunit Calc Main
			players = {ParsePlayer(PlayerID)},
			conditions = { 
				Label(0);
				Conditions,
			},
			actions = { 
				SetCtrigX("X","X",0x4,0,SetTo,"X",CCArr[CCptr],0,0,0);
				SetCtrigX("X",CCArr[CCptr]+1,0x4,0,SetTo,"X","X",0,0,1);
				SetCtrigX("X",CCArr[CCptr],0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",CCArr[CCptr],0x15C,0,SetTo,"X","X",0,0,1);
				SetMemory(0x6509B0,SetTo,161741 - 84 * i);
				Actions,
				},
			flag = {Preserved}
		}	
	end
	table.remove(CCArr,CCptr)
	table.remove(CCPArr,CCptr)
	CCptr = CCptr - 1
end

function CunitCtrig_Part3X()
	MoveCpValue = 0
	PlayerID = CCPArr[CCptr]
	Trigger { -- Cunit Calc Start
		players = {ParsePlayer(PlayerID)},
		conditions = { 
			Label(CCArr[CCptr]+2);
		},
		flag = {Preserved}
	}	
end

function CunitCtrig_Part4X(LoopIndex,Conditions,Actions)
	MoveCpValue = 0
	Trigger { -- Cunit Calc Main
		players = {ParsePlayer(PlayerID)},
		conditions = { 
			Label(0);
			Conditions,
		},
		actions = { 
			SetCtrigX("X","X",0x4,0,SetTo,"X",CCArr[CCptr],0,0,0);
			SetCtrigX("X",CCArr[CCptr]+1,0x4,0,SetTo,"X","X",0,0,1);
			SetCtrigX("X",CCArr[CCptr],0x158,0,SetTo,"X","X",0x4,1,0);
			SetCtrigX("X",CCArr[CCptr],0x15C,0,SetTo,"X","X",0,0,1);
			SetMemory(0x6509B0,SetTo,161741 - 84 * LoopIndex);
			Actions,
			},
		flag = {Preserved}
	}		
end

function CunitCtrig_End()
	table.remove(CCArr,CCptr)
	table.remove(CCPArr,CCptr)
	CCptr = CCptr - 1
end
	
function ClearCalc()
	PlayerID = CCPArr[CCptr]
	Trigger { -- Cunit Calc End
		players = {ParsePlayer(PlayerID)},
		conditions = { 
			Label(0);
		}, 
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",CCArr[CCptr]+1,0,0,0);
		},
		flag = {Preserved}
	}	
end

function BreakCalc(Conditions,Actions)	
	PlayerID = CCPArr[CCptr]
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
			SetCtrigX("X","X",0x4,0,SetTo,"X",CCArr[CCptr]+1,0,0,0);
			SetCtrigX("X",CCArr[CCptr]+1,0x158,0,SetTo,"X","X",0x4,1,0);
			SetCtrigX("X",CCArr[CCptr]+1,0x15C,0,SetTo,"X","X",0,0,1);
			Actions,
		},
		flag = {Preserved}
	}	
end

-- 변수/배열 선언/호출 함수 -----------------------------------------------------------------

function CVariable(Player,Index)
	Trigger {
				players = {ParsePlayer(Player)},
				conditions = {
					Label(Index);
				},
				actions = {
					SetDeathsX(0,SetTo,0,0,0xFFFFFFFF); -- Full Variable
					Disabled(SetDeathsX(0,SetTo,0,0,0xFFFFFFFF)); -- Recover Next
				},
				flag = {Preserved}
			}
end

function CVariable2(Player,Index,Offset,Type,Value,Mask)
	if Offset == "X" then 
		Offset = nil
	end
	if Type == "X" then 
		Type = nil
	end
	if Mask == "X" then 
		Mask = nil
	end


	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	if Offset == nil then
		Offset = 0x58A364
	end
	if Type == nil then
		Type = SetTo
	end
	Trigger {
				players = {ParsePlayer(Player)},
				conditions = {
					Label(Index);
				},
				actions = {
					SetDeathsX(EPD(Offset),Type,Value,0,Mask); -- Full Variable
					Disabled(SetDeathsX(0,SetTo,0,0,0xFFFFFFFF)); -- Recover Next
				},
				flag = {Preserved}
			}
end

function CallLabel1(Player,Index,Next)
	local X = {}
	table.insert(X,SetCtrigX("X","X",0x4,0,SetTo,Player,Index,0,0,Next))
	table.insert(X,SetCtrigX(Player,Index,0x4,Next,SetTo,"X","X",0,0,1))
	table.insert(X,SetCtrigX(Player,Index,0x178,Next,SetTo,"X","X",0x4,1,0))
	table.insert(X,SetCtrigX(Player,Index,0x17C,Next,SetTo,"X","X",0,0,1))
	table.insert(X,SetCtrig1X(Player,Index,0x184,Next,SetTo,0x0,0x2))
	return X
end

function CallLabel2(Player,Index,Next)
	local X = {}
	table.insert(X,SetCtrig1X(Player,Index,0x184,Next,SetTo,0x2,0x2))
	return X
end

function CallLabelAlways(Player,Index,Next)
	local X = {}
	table.insert(X,SetCtrigX("X","X",0x4,0,SetTo,Player,Index,0,0,Next))
	table.insert(X,SetCtrigX(Player,Index,0x4,Next,SetTo,"X","X",0,0,1))
	return X
end

function CallLabel1X(Variable)
	local Player = Variable[1]
	local Index = Variable[2]
	local Next = Variable[3]
	local X = {}
	table.insert(X,SetCtrigX("X","X",0x4,0,SetTo,Player,Index,0,0,Next))
	table.insert(X,SetCtrigX(Player,Index,0x4,Next,SetTo,"X","X",0,0,1))
	table.insert(X,SetCtrigX(Player,Index,0x178,Next,SetTo,"X","X",0x4,1,0))
	table.insert(X,SetCtrigX(Player,Index,0x17C,Next,SetTo,"X","X",0,0,1))
	table.insert(X,SetCtrig1X(Player,Index,0x184,Next,SetTo,0x0,0x2))
	return X
end

function CallLabel2X(Variable)
	local Player = Variable[1]
	local Index = Variable[2]
	local Next = Variable[3]
	local X = {}
	table.insert(X,SetCtrig1X(Player,Index,0x184,Next,SetTo,0x2,0x2))
	return X
end

function CallLabelAlwaysX(Variable)
	local Player = Variable[1]
	local Index = Variable[2]
	local Next = Variable[3]
	local X = {}
	table.insert(X,SetCtrigX("X","X",0x4,0,SetTo,Player,Index,0,0,Next))
	table.insert(X,SetCtrigX(Player,Index,0x4,Next,SetTo,"X","X",0,0,1))
	return X
end

function CallVariable(PlayerID,Player,Index,Next,Conditions,Actions)
		if Next == nil then
			Next = 0
		end
		if Conditions == nil or Conditions == "X" then
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					CallLabelAlways(Player,Index,Next);
					Actions,
				},
				flag = {Preserved}
			}
		else
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					Conditions,
				},
				actions = {
					CallLabel1(Player,Index,Next);
					Actions,
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					CallLabel2(Player,Index,Next);
				},
				flag = {Preserved}
			}
		end
end

function CallVariableX(PlayerID,Variable,Conditions,Actions)
		local Player = Variable[1]
		local Index = Variable[2]
		local Next = Variable[3]
		if Next == nil then
			Next = 0
		end
		if Conditions == nil or Conditions == "X" then
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					CallLabelAlways(Player,Index,Next);
					Actions,
				},
				flag = {Preserved}
			}
		else
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					Conditions,
				},
				actions = {
					CallLabel1(Player,Index,Next);
					Actions,
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					CallLabel2(Player,Index,Next);
				},
				flag = {Preserved}
			}
		end
end

function CDb(PlayerID,ByteSize)
	if bit32.band(ByteSize, 0xFFFFFFFF) >= 0x1000000 or ByteSize == 0 then
		Db_Size_Overflow()
	end
	return CArray(PlayerID,ByteSize/4)
end

function CArray(PlayerID,Size)
	if bit32.band(Size, 0xFFFFFFFF) >= 4096*602 or Size == 0 then
		Array_Size_Overflow()
	end

	local TNum = Size/602
	if Size%602 ~= 0 then
		TNum = TNum + 1
	end
	local Arrindex = FuncAlloc

	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(Arrindex);
		},
		flag = {Preserved}
	}

	for i = 2, TNum do 
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			flag = {Preserved}
		}
	end

	FuncAlloc = FuncAlloc + 1
	return {"X",Arrindex,0,0}
end

function CVArray(PlayerID,Size)
	if bit32.band(Size, 0xFFFFFFFF) >= 4096 or Size == 0 then
		VArray_Size_Overflow()
	end

	local VArrindex = FuncAlloc

	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(VArrindex);
		},
		actions = {
			SetDeathsX(0,SetTo,0,0,0xFFFFFFFF); -- Full Variable
			Disabled(SetDeathsX(0,SetTo,0,0,0xFFFFFFFF)); -- Recover Next
		},
		flag = {Preserved}
	}

	for i = 2, Size do 
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetDeathsX(0,SetTo,0,0,0xFFFFFFFF); -- Full Variable
				Disabled(SetDeathsX(0,SetTo,0,0,0xFFFFFFFF)); -- Recover Next
			},
			flag = {Preserved}
		}
	end

	FuncAlloc = FuncAlloc + 1
	return {"X",VArrindex,0,"V"}
end

-- DoActions류 함수 -------------------------------------------------------------------

function DoActions(PlayerID,Actions,flag)
	local X = {}
	if flag == nil then
		table.insert(X,PreserveTrigger())
	end
	Trigger {
		players = {ParsePlayer(PlayerID)},
		actions = {
			Actions,
			X,
		},
	}
end

function DoActions2(PlayerID,Actions,flag)
	local k = 1
	local Size = #Actions

	local Y = {}
	if flag == nil then
		table.insert(Y,PreserveTrigger())
	end

	while k <= Size do
		if Size - k + 1 >= 63 then
			local X = {}
			for i = 0, 62 do
				table.insert(X, Actions[k])
				k = k + 1
			end
			Trigger {
					players = {ParsePlayer(PlayerID)},
					actions = {
						X,
						Y,
					},
				}
		else
			local X = {}
			repeat
				table.insert(X, Actions[k])
				k = k + 1
			until k == Size + 1
			Trigger {
					players = {ParsePlayer(PlayerID)},
					actions = {
						X,
						Y,
					},
				}
		end
	end
end

function DoActionsX(PlayerID,Actions,flag)
	local X = {}
	if flag == nil then
		table.insert(X,PreserveTrigger())
	end
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(0);
		},
		actions = {
			Actions,
			X,
		},
	}
end

function DoActions2X(PlayerID,Actions,flag)
	local k = 1
	local Size = #Actions

	local Y = {}
	if flag == nil then
		table.insert(Y,PreserveTrigger())
	end

	while k <= Size do
		if Size - k + 1 >= 63 then
			local X = {}
			for i = 0, 62 do
				table.insert(X, Actions[k])
				k = k + 1
			end
			Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						X,
						Y,
					},
				}
		else
			local X = {}
			repeat
				table.insert(X, Actions[k])
				k = k + 1
			until k == Size + 1
			Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						X,
						Y,
					},
				}
		end
	end
end

function TriggerX(Player, Conditions, Actions, Flags)
	Trigger {
				players = {ParsePlayer(Player)},
				conditions = {
					Label(0);
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

function Trigger2(Player, Conditions, Actions, Flags)
	local k = 1
	local Size = #Actions

	while k <= Size do
		if Size - k + 1 >= 64 then
			local X = {}
			for i = 0, 63 do
				table.insert(X, Actions[k])
				k = k + 1
			end
			Trigger {
					players = {ParsePlayer(Player)},
					conditions = {
						Conditions,
					},
					actions = {
						X,
					},
					flag = {
						Flags,
					}
				}
		else
			local X = {}
			repeat
				table.insert(X, Actions[k])
				k = k + 1
			until k == Size + 1
			Trigger {
					players = {ParsePlayer(Player)},
					conditions = {
						Conditions,
					},
					actions = {
						X,
					},
					flag = {
						Flags,
					}
				}
		end
	end
end

function Trigger2X(Player, Conditions, Actions, Flags)
	local k = 1
	local Size = #Actions

	while k <= Size do
		if Size - k + 1 >= 64 then
			local X = {}
			for i = 0, 63 do
				table.insert(X, Actions[k])
				k = k + 1
			end
			Trigger {
					players = {ParsePlayer(Player)},
					conditions = {
						Label(0);
						Conditions,
					},
					actions = {
						X,
					},
					flag = {
						Flags,
					}
				}
		else
			local X = {}
			repeat
				table.insert(X, Actions[k])
				k = k + 1
			until k == Size + 1
			Trigger {
					players = {ParsePlayer(Player)},
					conditions = {
						Label(0);
						Conditions,
					},
					actions = {
						X,
					},
					flag = {
						Flags,
					}
				}
		end
	end
end

-- Ctrig 구조체 트리거 (T,TT 삽입 가능) --

function CDoActions(PlayerID,Actions,flag)

	STPopTrigArr(PlayerID)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID)

	local X = {}
	if flag == nil then
		table.insert(X,PreserveTrigger())
	end
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(0);
		},
		actions = {
			Actions,
			X,
		},
	}
end

function CTrigger(PlayerID, Conditions, Actions, Flags, Index)

	STPopTrigArr(PlayerID)
	ORPopCondArr(PlayerID)
	TTPopTrigArr(PlayerID)
	Conditions = PopCondArr(Conditions)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID)

	if Flags == 1 then
		Flags = {Preserved}
	end
	if Index == nil or Index == "X" then
		Index = 0 
	end

	Trigger {
				players = {ParsePlayer(PlayerID)},
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

-- Ctrig 파생 액션들 -------------------------------------------------------------------

function SetNext(Index1,Index2,Next)
	if Next == nil then
		Next = 0
	end
	local SetNext = SetCtrigX(nil,Index1,0x4,0,SetTo,nil,Index2,0x0,0,Next);
	return SetNext
end

function SetCJump(sIndex,Status,NewDest)
	local SetCJump 
	if NewDest == nil or NewDest == "X" then
		if Status == 1 or Status == "On" then
			SetCJump = SetNext(sIndex+0xC000,sIndex+0xD000,0)
		else
			SetCJump = SetNext(sIndex+0xC000,sIndex+0xC000,1)
		end
	else
		SetCJump = SetNext(sIndex+0xC000,NewDest,0)
	end
	return SetCJump
end

function VariableX(Player,Index,Section,Type,Value,Mask)
	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	local Addr
	if Section == "EPD" then
		Addr = 0x158
	elseif Section == "Type" then
		Addr = 0x160
		if Mask == nil then
			Mask = 0xFF000000
		end
	elseif Section == "Value" then
		Addr = 0x15C
	elseif Section == "Next" then
		Addr = 0x4
	elseif Section == "Mask" then
		Addr = 0x148
	elseif Section == "Flag" then
		Addr = 0x164
		if Mask == nil then
			Mask = 0xFF
		end
	end

	local VariableX = CtrigX(Player,Index,Addr,0,Type,Value,Mask)
	return VariableX
end

function SetVariableX(Player,Index,Section,Type,Value,Mask)
	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	local Addr
	if Section == "EPD" then
		Addr = 0x158
	elseif Section == "Type" then
		Addr = 0x160
		if Mask == nil then
			Mask = 0xFF000000
		end
	elseif Section == "Value" then
		Addr = 0x15C
	elseif Section == "Next" then
		Addr = 0x4
	elseif Section == "Mask" then
		Addr = 0x148
	elseif Section == "Flag" then
		Addr = 0x164
		if Mask == nil then
			Mask = 0xFF
		end
	end

	local SetVariableX = SetCtrig1X(Player,Index,Addr,0,Type,Value,Mask)
	return SetVariableX
end

function VArrayX(VArray,Section,Type,Value,Mask)
	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	local Addr
	if Section == "EPD" then
		Addr = 0x158
	elseif Section == "Type" then
		Addr = 0x160
		if Mask == nil then
			Mask = 0xFF000000
		end
	elseif Section == "Value" then
		Addr = 0x15C
	elseif Section == "Next" then
		Addr = 0x4
	elseif Section == "Mask" then
		Addr = 0x148
	elseif Section == "Flag" then
		Addr = 0x164
		if Mask == nil then
			Mask = 0xFF
		end
	end

	if VArray[4] ~= "V" then
		VArrayX_InputData_Error()
	end

	local VArrayX = CtrigX(VArray[1],VArray[2],Addr,VArray[3],Type,Value,Mask)
	return VArrayX
end

function SetVArrayX(VArray,Section,Type,Value,Mask)
	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	local Addr
	if Section == "EPD" then
		Addr = 0x158
	elseif Section == "Type" then
		Addr = 0x160
		if Mask == nil then
			Mask = 0xFF000000
		end
	elseif Section == "Value" then
		Addr = 0x15C
	elseif Section == "Next" then
		Addr = 0x4
	elseif Section == "Mask" then
		Addr = 0x148
	elseif Section == "Flag" then
		Addr = 0x164
		if Mask == nil then
			Mask = 0xFF
		end
	end

	if VArray[4] ~= "V" then
		SetVArrayX_InputData_Error()
	end

	local SetVArrayX = SetCtrig1X(VArray[1],VArray[2],Addr,VArray[3],Type,Value,Mask)
	return SetVArrayX
end

function MemX(Mem,Type,Value,Mask)
	if Mask == nil then
		Mask = 0xFFFFFFFF
	end

	if type(Mem[4]) == "string" then
		MemX_InputData_Error()
	end

	local MemX = CtrigX(Mem[1],Mem[2],Mem[3],Mem[4],Type,Value,Mask)
	return MemX
end

function SetMemX(Mem1,Type,Mem2,Mask)
	if Mask == nil then
		Mask = 0xFFFFFFFF
	end

	local SetMemX
	if type(Mem1) == "table" and type(Mem2) == "number" then
		SetMemX = SetCtrig1X(Mem1[1],Mem1[2],Mem1[3],Mem1[4],Type,Mem2,Mask)
	elseif type(Mem1) == "number" and type(Mem2) == "table" then
		SetMemX = SetCtrig2X(Mem1,Type,Mem2[1],Mem2[2],Mem2[3],Mem2[5],Mem2[4],Mask)
	elseif type(Mem1) == "table" and type(Mem2) == "table" then
		SetMemX = SetCtrigX(Mem1[1],Mem1[2],Mem1[3],Mem1[4],Type,Mem2[1],Mem2[2],Mem2[3],Mem2[5],Mem2[4],Mask)
	else
		SetMemX_InputData_Error()
	end
	
	return SetMemX
end

function CVar(Player,Index,Type,Value,Mask)
	return VariableX(Player,Index,"Value",Type,Value,Mask)
end

function SetCVar(Player,Index,Type,Value,Mask)
	return SetVariableX(Player,Index,"Value",Type,Value,Mask)
end

function CVAar(VArray,Type,Value,Mask)
	return VArrayX(VArray,"Value",Type,Value,Mask)
end

function SetCVAar(VArray,Type,Value,Mask)
	return SetVArrayX(VArray,"Value",Type,Value,Mask)
end

-- 확장 데스값 --

function _Ccode(Player,Code,EPDflag) -- Convert(CDeaths Data -> Ctrig Mem Data)
	if EPDflag == "X" or EPDflag == nil or EPDflag == 0 then
		EPDflag = nil
	else
		EPDflag = 1
	end
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)
	return {Player,Index,0x1C8+0x4*Line,0,EPDflag}
end

function _Ncode(Player,Code,EPDflag) -- Convert(NDeaths Data -> Ctrig Mem Data)
	if EPDflag == "X" or EPDflag == nil or EPDflag == 0 then
		EPDflag = nil
	else
		EPDflag = 1
	end
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)
	return {FixPlayer,Index,0x1C8+0x20*Line+0x4*Player,0,EPDflag}
end

function CDeathsX(Player,Type,Value,Code,Mask)
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)

	if Line >= 480 or Line < 0 then
		CDeathX_LineOverflow()
	end
	local CDeathsX = CtrigX(Player,Index,0x1C8+0x4*Line,0,Type,Value,Mask)
	return CDeathsX
end

function CDeaths(Player,Type,Value,Code)
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)

	if Line >= 480 or Line < 0 then
		CDeath_LineOverflow()
	end
	local CDeaths = CtrigX(Player,Index,0x1C8+0x4*Line,0,Type,Value)
	return CDeaths
end

function SetCDeathsX(Player,Type,Value,Code,Mask)
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)

	if Line >= 480 or Line < 0 then
		SetCDeathsX_LineOverflow()
	end
	local SetCDeathsX = SetCtrig1X(Player,Index,0x1C8+0x4*Line,0,Type,Value,Mask)
	return SetCDeathsX
end

function SetCDeaths(Player,Type,Value,Code)
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)

	if Line >= 480 or Line < 0 then
		SetCDeaths_LineOverflow()
	end
	local SetCDeaths = SetCtrig1X(Player,Index,0x1C8+0x4*Line,0,Type,Value)
	return SetCDeaths
end

function NDeathsX(Player,Type,Value,Code,Mask)
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)

	if Line >= 60 or Line < 0 then
		NDeathX_LineOverflow()
	end
	local NDeathsX = CtrigX(FixPlayer,Index,0x1C8+0x20*Line+0x4*Player,0,Type,Value,Mask)
	return NDeathsX
end

function NDeaths(Player,Type,Value,Code)
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)

	if Line >= 60 or Line < 0 then
		NDeath_LineOverflow()
	end
	local NDeaths = CtrigX(FixPlayer,Index,0x1C8+0x20*Line+0x4*Player,0,Type,Value)
	return NDeaths
end

function SetNDeathsX(Player,Type,Value,Code,Mask)
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)

	if Line >= 60 or Line < 0 then
		SetNDeathsX_LineOverflow()
	end
	local SetNDeathsX = SetCtrig1X(FixPlayer,Index,0x1C8+0x20*Line+0x4*Player,0,Type,Value,Mask)
	return SetNDeathsX
end

function SetNDeaths(Player,Type,Value,Code)
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)

	if Line >= 60 or Line < 0 then
		SetNDeaths_LineOverflow()
	end
	local SetNDeaths = SetCtrig1X(FixPlayer,Index,0x1C8+0x20*Line+0x4*Player,0,Type,Value)
	return SetNDeaths
end

-- 데이터 읽기 관련 함수 (Read) ---------------------------------------------------------

function SafeReadX(PlayerID,Input,Output,Mask,EPDRead) -- CRead 1 -> N 
	if type(Input) == "table" then
		if Input[4] == "VA" or Input[4] == "A" then
			SafeReadX_InputData_Error()
		end
	end
	if type(Output) == "number" then
		Output = {Output}
	end

	if Mask == "X" or Mask == nil then
		Mask = 0xFFFFFFFF
	end

	if EPDRead == "X" then
		EPDRead = nil
	end
	if EPDRead == nil then
		local EPDArr = {} 

		for k, v in pairs(Output) do
			if type(v) == "table" then
				if v[4] == "VA" or v[4] == "A" then
					SafeReadX_InputData_Error()
				end
			end
			if type(v) == "number" then 
				table.insert(EPDArr,SetMemoryX(v,SetTo,0,Mask))
			elseif v == "Cp" then
				table.insert(EPDArr,SetDeathsX(CurrentPlayer,SetTo,0,0,Mask))
			elseif v[4] == "V" then				
				table.insert(EPDArr,SetCtrig1X(v[1],v[2],0x15C,v[3],SetTo,0,Mask))
			else
				table.insert(EPDArr,SetCtrig1X(v[1],v[2],v[3],v[4],SetTo,0,Mask))
			end
		end
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
		   		 Label(0);
			},
			actions = {
				EPDArr,
			},
			flag = {Preserved}
		}

		for i = 0, 31 do
			local CBit = bit32.band(Mask, 2^i)
			if CBit == 2^i then
				local InputArr = {}
				local OutputArr = {}

				if type(Input) == "number" then 
					InputArr = {MemoryX(Input,Exactly,CBit,CBit)}
				elseif Input == "Cp" then
					InputArr = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
				elseif Input[4] == "V" then
					InputArr = {CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,CBit,CBit)}
				else
					InputArr = {CtrigX(Input[1],Input[2],Input[3],Input[4],Exactly,CBit,CBit)}
				end

				for k, v in pairs(Output) do
					if type(v) == "table" then
						if v[4] == "VA" or v[4] == "A" then
							SafeReadX_InputData_Error()
						end
					end
					if type(v) == "number" then 
						table.insert(OutputArr,SetMemoryX(v,SetTo,CBit,CBit))
					elseif v == "Cp" then
						table.insert(OutputArr,SetDeathsX(CurrentPlayer,SetTo,CBit,0,CBit))
					elseif v[4] == "V" then
						table.insert(OutputArr,SetCtrig1X(v[1],v[2],0x15C,v[3],SetTo,CBit,CBit))
					else
						table.insert(OutputArr,SetCtrig1X(v[1],v[2],v[3],v[4],SetTo,CBit,CBit))
					end
				end

				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
				   		 Label(0);
						 InputArr,
					},
					actions = {
						OutputArr,
					},
					flag = {Preserved}
				}
			end
		end
	else
		local EPDArr = {} 

		for k, v in pairs(Output) do
			if type(v) == "table" then
				if v[4] == "VA" or v[4] == "A" then
					SafeReadX_InputData_Error()
				end
			end
			if type(v) == "number" then 
				table.insert(EPDArr,SetMemory(v,SetTo,-1452249))
			elseif v == "Cp" then
				table.insert(EPDArr,SetDeaths(CurrentPlayer,SetTo,-1452249,0))
			elseif v[4] == "V" then				
				table.insert(EPDArr,SetCtrig1X(v[1],v[2],0x15C,v[3],SetTo,-1452249))
			else
				table.insert(EPDArr,SetCtrig1X(v[1],v[2],v[3],v[4],SetTo,-1452249))
			end
		end
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
		   		 Label(0);
			},
			actions = {
				EPDArr,
			},
			flag = {Preserved}
		}

		for i = 2, 31 do
			local CBit = bit32.band(Mask, 2^i)
			if CBit == 2^i then
				
				local InputArr = {}
				local OutputArr = {}
				local EBit = CBit / 4

				if type(Input) == "number" then 
					InputArr = {MemoryX(Input,Exactly,CBit,CBit)}
				elseif Input == "Cp" then
					InputArr = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
				elseif Input[4] == "V" then
					InputArr = {CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,CBit,CBit)}
				else
					InputArr = {CtrigX(Input[1],Input[2],Input[3],Input[4],Exactly,CBit,CBit)}
				end

				for k, v in pairs(Output) do
					if type(v) == "table" then
						if v[4] == "VA" or v[4] == "A" then
							SafeReadX_InputData_Error()
						end
					end
					if type(v) == "number" then 
						table.insert(OutputArr,SetMemory(v,Add,EBit))
					elseif v == "Cp" then
						table.insert(OutputArr,SetDeaths(CurrentPlayer,Add,EBit,0))
					elseif v[4] == "V" then
						table.insert(OutputArr,SetCtrig1X(v[1],v[2],0x15C,v[3],Add,EBit))
					else
						table.insert(OutputArr,SetCtrig1X(v[1],v[2],v[3],v[4],Add,EBit))
					end
				end

				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
				   		 Label(0);
						 InputArr,
					},
					actions = {
						OutputArr,
					},
					flag = {Preserved}
				}
			end
		end
	end
end

function UnitReadX(PlayerID,Player,UnitId,Loc,Output) -- Binary Bring/Command Read
	if type(Output) == "table" then
		if Output[4] == "VA" or Output[4] == "A" then
			UnitReadX_InputData_Error()
		end
	end
	if Output == nil or Output == "X" then
		Output = V(CRet[1],"X",0)
	end
	if Loc == "X" then
		Loc = nil
	end

	local UnitArr1 = {}

	local j = 1
	for i = 10, 0, -1 do
		table.insert(UnitArr1,SetCtrig1X("X","X",0x24,j,SetTo,2^i))
		j = j + 1
	end
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(0);
		},
		actions = {
			SetCtrig1X(Output[1],Output[2],0x15C,Output[3],SetTo,0);
			UnitArr1,
		},
		flag = {Preserved}
	}

	for i = 10, 0, -1 do
		local CBit = 2^i

		local UnitArr2 = {}
		if Loc == nil then
			table.insert(UnitArr2,Command(Player,AtLeast,2^i,UnitId))
		else 
			table.insert(UnitArr2,Bring(Player,AtLeast,2^i,UnitId,Loc))
		end

		local UnitArr3 = {}
		for j = 1, i do
			table.insert(UnitArr3,SetCtrig1X("X","X",0x24,j,Add,2^i))
		end

		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				UnitArr2,
			},
			actions = {
				SetCtrig1X(Output[1],Output[2],0x15C,Output[3],SetTo,2^i,2^i);
				UnitArr3,
			},
			flag = {Preserved}
		}

	end
	return Output
end

function ConvertReadX(PlayerID,Input,Output,Multiplier,Mask,UseCycle) -- 메모리 * 상수 or 메모리 / 상수(2의 제곱수)
	if type(Input) == "table" then
		if Input[4] == "VA" or Input[4] == "A" then
			ConvertReadX_InputData_Error()
		end
	end
	if type(Output) == "number" then
		Output = {Output}
	end

	if Mask == "X" or Mask == nil then
		Mask = 0xFFFFFFFF
	end

	if UseCycle == "X" or UseCycle == nil then
		UseCycle = 0
	end

	local ClearArr = {} 

	for k, v in pairs(Output) do
		if type(v) == "table" then
			if v[4] == "VA" or v[4] == "A" then
				ConvertReadX_InputData_Error()
			end
		end
		if type(v) == "number" then 
			table.insert(ClearArr,SetMemory(v,SetTo,0))
		elseif v == "Cp" then
			table.insert(ClearArr,SetDeaths(CurrentPlayer,SetTo,0,0))
		elseif v[4] == "V" then				
			table.insert(ClearArr,SetCtrig1X(v[1],v[2],0x15C,v[3],SetTo,0))
		else
			table.insert(ClearArr,SetCtrig1X(v[1],v[2],v[3],v[4],SetTo,0))
		end
	end
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
	   		 Label(0);
		},
		actions = {
			ClearArr,
		},
		flag = {Preserved}
	}

	local  Check = 0
	for i = 0, 31 do
		local CBit = bit32.band(Mask, 2^i)
		if CBit == 2^i then
			local InputArr = {}
			local OutputArr = {}
			local MBit = CBit * Multiplier

			if type(Input) == "number" then 
				InputArr = {MemoryX(Input,Exactly,CBit,CBit)}
			elseif Input == "Cp" then
				InputArr = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
			elseif Input[4] == "V" then
				InputArr = {CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,CBit,CBit)}
			else
				InputArr = {CtrigX(Input[1],Input[2],Input[3],Input[4],Exactly,CBit,CBit)}
			end

			for k, v in pairs(Output) do
				if type(v) == "table" then
					if v[4] == "VA" or v[4] == "A" then
						ConvertReadX_InputData_Error()
					end
				end
				if type(v) == "number" then 
					table.insert(OutputArr,SetMemory(v,Add,MBit))
				elseif v == "Cp" then
					table.insert(OutputArr,SetDeaths(CurrentPlayer,Add,MBit,0))
				elseif v[4] == "V" then
					table.insert(OutputArr,SetCtrig1X(v[1],v[2],0x15C,v[3],Add,MBit))
				else
					table.insert(OutputArr,SetCtrig1X(v[1],v[2],v[3],v[4],Add,MBit))
				end
			end
			if Check == 0 then
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
				   		 Label(0);
						 InputArr,
					},
					actions = {
						OutputArr,
					},
					flag = {Preserved}
				}
			end
			if bit32.band(CBit*Multiplier,0xFFFFFFFF) >= 0x80000000 and UseCycle == 0 then
				Check = 1
			end
		end
	end
end

-- 제어문 (if,Jump,While) 관련 함수 ----------------------------------------------------

function CJump(PlayerID,sIndex)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(sIndex+0xC000);
		},
		actions = {
	   		PreserveTrigger();
		},
	}
	PlayerID = PlayerConvert(PlayerID)
	for k, P in pairs(PlayerID) do
		table.insert(CtrigInitArr[P+1],SetNext(sIndex+0xC000,sIndex+0xD000))
	end
	table.insert(CJumpArr,sIndex)
end

function CJumpEnd(PlayerID,sIndex)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(sIndex+0xD000);
		},
		actions = {
	   		PreserveTrigger();
		},
	}
	table.insert(CJumpEndArr,sIndex)
end

function NJump(PlayerID,sIndex,Conditions,Actions)
	STPopTrigArr(PlayerID)
	ORPopCondArr(PlayerID)
	TTPopTrigArr(PlayerID)
	Conditions = PopCondArr(Conditions)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,1)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(sIndex+0xC000);
			Conditions,
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			Actions,
	   		PreserveTrigger();
		},
	}
	PlayerID = PlayerConvert(PlayerID)
	for k, P in pairs(PlayerID) do
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",sIndex+0xC000,0x158,0,SetTo,"X",sIndex+0xC000,0x4,1,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",sIndex+0xC000,0x15C,0,SetTo,"X",sIndex+0xD000,0x0,0,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",sIndex+0xD000,0x158,0,SetTo,"X",sIndex+0xC000,0x4,1,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",sIndex+0xD000,0x15C,0,SetTo,"X",sIndex+0xC000,0x0,0,1))
	end
	table.insert(NJumpArr,sIndex)
end
function NJumpEnd(PlayerID,sIndex,Actions_Always)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(sIndex+0xD000);
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			Actions_Always,
			PreserveTrigger();
		},
	}
	table.insert(NJumpEndArr,sIndex)
end

function CJumpX(PlayerID,sIndex)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(0);
		},
		actions = {
			SetNext("X",sIndex+0xD000);
	   		PreserveTrigger();
		},
	}
	table.insert(CJumpArr,sIndex)
end

function CJumpXEnd(PlayerID,sIndex)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(sIndex+0xD000);
		},
		actions = {
	   		PreserveTrigger();
		},
	}
	table.insert(CJumpEndArr,sIndex)
end

function NJumpX(PlayerID,sIndex,Conditions,Actions)
	STPopTrigArr(PlayerID)
	ORPopCondArr(PlayerID)
	TTPopTrigArr(PlayerID)
	Conditions = PopCondArr(Conditions)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,1)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(0);
			Conditions,
		},
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",sIndex+0xD000,0x0,0,0);
			SetCtrigX("X",sIndex+0xD000,0x158,0,SetTo,"X","X",0x4,1,0);
			SetCtrigX("X",sIndex+0xD000,0x15C,0,SetTo,"X","X",0x0,0,1);
			SetCtrig1X("X",sIndex+0xD000,0x2C,0,SetTo,0x0200,0x0200);
			Actions,
	   		PreserveTrigger();
		},
	}
	table.insert(NJumpArr,sIndex)
end
function NJumpXEnd(PlayerID,sIndex,Actions)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(sIndex+0xD000);
			Never();
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			SetCtrig1X("X",sIndex+0xD000,0x2C,0,SetTo,0x0000,0x0200);
			Actions,
			PreserveTrigger();
		},
	}
	table.insert(NJumpEndArr,sIndex)
end

function CIfOnce(PlayerID, Conditions, Actions) -- 1번만 실행
	STPopTrigArr(PlayerID)
	ORPopCondArr(PlayerID)
	TTPopTrigArr(PlayerID)
	Conditions = PopCondArr(Conditions)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,1)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc);
			Conditions,
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			Actions,
		},
	}
	PlayerID = PlayerConvert(PlayerID)
	table.insert(CIfArr, IndexAlloc)
	table.insert(CIfPArr, PlayerID)
	CIfptr = CIfptr + 1
	IndexAlloc = IndexAlloc + 0x2
end

function CIf(PlayerID, Conditions, Actions)
	STPopTrigArr(PlayerID)
	ORPopCondArr(PlayerID)
	TTPopTrigArr(PlayerID)
	Conditions = PopCondArr(Conditions)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,1)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc);
			Conditions,
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			Actions,
	   		PreserveTrigger();
		},
	}
	PlayerID = PlayerConvert(PlayerID)
	table.insert(CIfArr, IndexAlloc)
	table.insert(CIfPArr, PlayerID)
	CIfptr = CIfptr + 1
	IndexAlloc = IndexAlloc + 0x2
end

function CIfEnd(Actions_Always)
	local Index
	Index = CIfArr[CIfptr] + 1
	local PlayerID
	PlayerID = CIfPArr[CIfptr]
	table.remove(CIfArr,CIfptr)
	table.remove(CIfPArr,CIfptr)
	CIfptr = CIfptr - 1

	for k, P in pairs(PlayerID) do
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-1,0x4,0,SetTo,"X",Index,0x0,0,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-1,0x158,0,SetTo,"X",Index-1,0x4,1,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-1,0x15C,0,SetTo,"X",Index-1,0x0,0,1))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index,0x158,0,SetTo,"X",Index-1,0x4,1,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index,0x15C,0,SetTo,"X",Index,0x0,0,0))
	end
	
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(Index);
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			Actions_Always,
			PreserveTrigger();
		},
	}
end

function NIf(PlayerID, Conditions, Actions)
	STPopTrigArr(PlayerID)
	ORPopCondArr(PlayerID)
	TTPopTrigArr(PlayerID)
	Conditions = PopCondArr(Conditions)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,1)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc);
			Conditions,
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			Actions,
	   		PreserveTrigger();
		},
	}
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc+1);
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
	   		PreserveTrigger();
		},
	}
	PlayerID = PlayerConvert(PlayerID)
	table.insert(NIfArr, IndexAlloc)
	table.insert(NIfPArr, PlayerID)
	NIfptr = NIfptr + 1
	IndexAlloc = IndexAlloc + 0x3
end

function NIfEnd()
	local Index
	Index = NIfArr[NIfptr] + 2
	local PlayerID
	PlayerID = NIfPArr[NIfptr]
	table.remove(NIfArr,NIfptr)
	table.remove(NIfPArr,NIfptr)
	NIfptr = NIfptr - 1

	for k, P in pairs(PlayerID) do
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-2,0x4,0,SetTo,"X",Index,0x0,0,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-2,0x158,0,SetTo,"X",Index-2,0x4,1,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-2,0x15C,0,SetTo,"X",Index-1,0x0,0,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-1,0x158,0,SetTo,"X",Index-2,0x4,1,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-1,0x15C,0,SetTo,"X",Index,0x0,0,0))
	end
	
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(Index);
		},
		actions = {
			PreserveTrigger();
		},
	}
end

function CWhile(PlayerID, Conditions, Actions)
	STPopTrigArr(PlayerID)
	ORPopCondArr(PlayerID)
	TTPopTrigArr(PlayerID)
	Conditions = PopCondArr(Conditions)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,1)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc);
			Conditions,
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			Actions,
	   		PreserveTrigger();
		},
	}
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc+1);
		},
		actions = {
	   		PreserveTrigger();
		},
	}
	PlayerID = PlayerConvert(PlayerID)
	table.insert(CWhileArr, IndexAlloc)
	table.insert(CWhilePArr, PlayerID)
	CWhileptr = CWhileptr + 1
	IndexAlloc = IndexAlloc + 0x3
end

function CWhileEnd(Actions)
	local Index
	Index = CWhileArr[CWhileptr] + 2
	local PlayerID
	PlayerID = CWhilePArr[CWhileptr]
	table.remove(CWhileArr,CWhileptr)
	table.remove(CWhilePArr,CWhileptr)
	CWhileptr = CWhileptr - 1

	for k, P in pairs(PlayerID) do
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index,0x4,0,SetTo,"X",Index-2,0x0,0,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-1,0x4,0,SetTo,"X",Index,0x0,0,1))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-2,0x158,0,SetTo,"X",Index-2,0x4,1,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-2,0x15C,0,SetTo,"X",Index-1,0x0,0,1))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index,0x158,0,SetTo,"X",Index-2,0x4,1,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index,0x15C,0,SetTo,"X",Index-1,0x0,0,0))
	end
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(Index);
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			Actions,
			PreserveTrigger();
		},
	}
end

function CLoop(PlayerID,Repeat,Conditions,Actions)
	DoActionsX(PlayerID,SetCDeaths("X",SetTo,0,Ccode(IndexAlloc+1,0)))
	STPopTrigArr(PlayerID)
	ORPopCondArr(PlayerID)
	TTPopTrigArr(PlayerID)
	Conditions = PopCondArr(Conditions)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,2,1)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc);
			CDeaths("X",AtMost,Repeat-1,Ccode(IndexAlloc+1,0));
			Conditions,
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			SetCDeaths("X",Add,1,Ccode(IndexAlloc+1,0));
			Actions,
	   		PreserveTrigger();
		},
	}
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc+1);
		},
		actions = {
	   		PreserveTrigger();
		},
	}
	PlayerID = PlayerConvert(PlayerID)
	table.insert(CWhileArr, IndexAlloc)
	table.insert(CWhilePArr, PlayerID)
	CWhileptr = CWhileptr + 1
	IndexAlloc = IndexAlloc + 0x3
end

function NWhile(PlayerID, Conditions, Actions)
	STPopTrigArr(PlayerID)
	ORPopCondArr(PlayerID)
	TTPopTrigArr(PlayerID)
	Conditions = PopCondArr(Conditions)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,1)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc);
			Conditions,
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			Actions,
	   		PreserveTrigger();
		},
	}
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc+1);
		},
		actions = {
	   		PreserveTrigger();
		},
	}
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc+2);
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
	   		PreserveTrigger();
		},
	}
	PlayerID = PlayerConvert(PlayerID)
	table.insert(NWhileArr, IndexAlloc)
	table.insert(NWhilePArr, PlayerID)
	NWhileptr = NWhileptr + 1
	IndexAlloc = IndexAlloc + 0x4
end

function NWhileEnd(Actions)
	local Index
	Index = NWhileArr[NWhileptr] + 3
	local PlayerID
	PlayerID = NWhilePArr[NWhileptr]
	table.remove(NWhileArr,NWhileptr)
	table.remove(NWhilePArr,NWhileptr)
	NWhileptr = NWhileptr - 1

	for k, P in pairs(PlayerID) do
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index,0x4,0,SetTo,"X",Index-3,0x0,0,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-2,0x4,0,SetTo,"X",Index,0x0,0,1))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-3,0x158,0,SetTo,"X",Index-3,0x4,1,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-3,0x15C,0,SetTo,"X",Index-1,0x0,0,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-1,0x158,0,SetTo,"X",Index-3,0x4,1,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-1,0x15C,0,SetTo,"X",Index-2,0x0,0,0))
	end
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(Index);
		},
		actions = {
			Actions,
			PreserveTrigger();
		},
	}
end

function NLoop(PlayerID,Repeat,Conditions,Actions)
	DoActionsX(PlayerID,SetCDeaths("X",SetTo,0,Ccode(IndexAlloc+1,0)))
	STPopTrigArr(PlayerID)
	ORPopCondArr(PlayerID)
	TTPopTrigArr(PlayerID)
	Conditions = PopCondArr(Conditions)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,2,1)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc);
			CDeaths("X",AtMost,Repeat-1,Ccode(IndexAlloc+1,0));
			Conditions,
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			SetCDeaths("X",Add,1,Ccode(IndexAlloc+1,0));
			Actions,
	   		PreserveTrigger();
		},
	}
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc+1);
		},
		actions = {
	   		PreserveTrigger();
		},
	}
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc+2);
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
	   		PreserveTrigger();
		},
	}
	PlayerID = PlayerConvert(PlayerID)
	table.insert(NWhileArr, IndexAlloc)
	table.insert(NWhilePArr, PlayerID)
	NWhileptr = NWhileptr + 1
	IndexAlloc = IndexAlloc + 0x4
end

function DoWhile(PlayerID, Actions_Always)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc);
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			Actions_Always,
	   		PreserveTrigger();
		},
	}
	PlayerID = PlayerConvert(PlayerID)
	table.insert(DWhileArr, IndexAlloc)
	table.insert(DWhilePArr, PlayerID)
	DWhileptr = DWhileptr + 1
	IndexAlloc = IndexAlloc + 0x2
end

function DoWhileEnd(Loop_Conditions, Actions)
	local Index
	Index = DWhileArr[DWhileptr] + 1
	local PlayerID
	PlayerID = DWhilePArr[DWhileptr]
	table.remove(DWhileArr,DWhileptr)
	table.remove(DWhilePArr,DWhileptr)
	DWhileptr = DWhileptr - 1

	for k, P in pairs(PlayerID) do
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-1,0x158,0,SetTo,"X",Index,0x4,1,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-1,0x15C,0,SetTo,"X",Index,0x0,0,1))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index,0x158,0,SetTo,"X",Index,0x4,1,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index,0x15C,0,SetTo,"X",Index-1,0x0,0,0))
	end
	STPopTrigArr(PlayerID)
	ORPopCondArr(PlayerID)
	TTPopTrigArr(PlayerID)
	Conditions = PopCondArr(Loop_Conditions)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,1)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(Index);
			Loop_Conditions,
		},
		actions = {
		SetDeaths(0,SetTo,0,0);
			Actions,
			PreserveTrigger();
		},
	}
end

function CFor(PlayerID,Init,End,Step,Actions) -- DoWhile x CJump
	DoActionsX(PlayerID,SetVariableX("X",IndexAlloc+1,"Value",SetTo,Init)) -- Calc Init
	STPopTrigArr(PlayerID)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,1,1)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc);
			VariableX("X",IndexAlloc+1,"Value",Exactly,End); -- Calc Last
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			Actions,
	   		PreserveTrigger();
		},
	}
	CVariable(ParsePlayer(PlayerID),IndexAlloc+1)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc+2);
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
	   		PreserveTrigger();
		},
	}
	PlayerID = PlayerConvert(PlayerID)
	table.insert(CForArr, IndexAlloc)
	table.insert(CForPArr, PlayerID)
	table.insert(CForStep, Step)
	CForptr = CForptr + 1
	IndexAlloc = IndexAlloc + 0x4
end

function CForEnd(Actions)
	local Index
	Index = CForArr[CForptr] + 3
	local PlayerID
	PlayerID = CForPArr[CForptr]
	local Step
	Step = CForStep[CForptr]
	table.remove(CForArr,CForptr)
	table.remove(CForPArr,CForptr)
	table.remove(CForStep,CForptr)
	CForptr = CForptr - 1

	for k, P in pairs(PlayerID) do
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-3,0x4,0,SetTo,"X",Index-1,0x0,0,1))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-1,0x4,0,SetTo,"X",Index,0x0,0,1))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index,0x4,0,SetTo,"X",Index-3,0x0,0,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-3,0x158,0,SetTo,"X",Index-3,0x4,1,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-3,0x15C,0,SetTo,"X",Index-1,0x0,0,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-1,0x158,0,SetTo,"X",Index-3,0x4,1,0))
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",Index-1,0x15C,0,SetTo,"X",Index-1,0x0,0,1))
	end
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(Index);
		},
		actions = {
			SetVariableX("X",Index-2,"Value",Add,Step);
			Actions,
			PreserveTrigger();
		},
	}
end

function CForVariable(NestingLevel)
	if NestingLevel == nil or NestingLevel == "X" then
		NestingLevel = CForptr
	end
	local CForLabel = CForArr[NestingLevel] + 1
	return {"X",CForLabel,0,"V"}
end

function NIfX(PlayerID, Conditions, Actions)
	STPopTrigArr(PlayerID)
	ORPopCondArr(PlayerID)
	TTPopTrigArr(PlayerID)
	Conditions = PopCondArr(Conditions)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,1)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc);
			Conditions,
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			Actions,
	   		PreserveTrigger();
		},
	}
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(0);
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
	   		PreserveTrigger();
		},
	}
	local X = {}
	PlayerID = PlayerConvert(PlayerID)
	table.insert(X, IndexAlloc)
	table.insert(NIfXArr, X)
	table.insert(NIfXPArr, PlayerID)
	NIfXptr = NIfXptr + 1
	IndexAlloc = IndexAlloc + 0x2
end

function NElseIfX(Conditions, Actions)
	local PlayerID
	PlayerID = NIfXPArr[NIfXptr]
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(0);
		},
		flag = {Preserved}
	}
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc);
		},
		flag = {Preserved}
	}
	STPopTrigArr(PlayerID)
	ORPopCondArr(PlayerID)
	TTPopTrigArr(PlayerID)
	Conditions = PopCondArr(Conditions)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,1)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc+1);
			Conditions,
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			Actions,
	   		PreserveTrigger();
		},
	}
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(0);
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
	   		PreserveTrigger();
		},
	}
	table.insert(NIfXArr[NIfXptr],IndexAlloc+1)
	IndexAlloc = IndexAlloc + 0x2
end

function NElseX(Actions)
	local PlayerID
	PlayerID = NIfXPArr[NIfXptr]
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(0);
		},
		flag = {Preserved}
	}
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc);
		},
		flag = {Preserved}
	}
	STPopTrigArr(PlayerID)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,1)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc+1);
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			Actions,
	   		PreserveTrigger();
		},
	}
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(0);
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
	   		PreserveTrigger();
		},
	}
	table.insert(NIfXArr[NIfXptr],IndexAlloc+1)
	IndexAlloc = IndexAlloc + 0x2
end

function NIfXEnd()
	local PlayerID
	PlayerID = NIfXPArr[NIfXptr]
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(0);
		},
		flag = {Preserved}
	}
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc);
		},
		flag = {Preserved}
	}
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc+1);
		},
		actions = {
			PreserveTrigger();
		},
	}
	table.insert(NIfXArr[NIfXptr],IndexAlloc+1)
	IndexAlloc = IndexAlloc + 0x2

	for k, P in pairs(PlayerID) do
		local Size = 0
		for i, index in pairs(NIfXArr[NIfXptr]) do
			Size = Size + 1
		end
		for i = 1, Size-1 do
			table.insert(CtrigInitArr[P+1], SetCtrigX("X",NIfXArr[NIfXptr][i],0x4,0,SetTo,"X",NIfXArr[NIfXptr][i+1]-1,0x0,0,0))
			table.insert(CtrigInitArr[P+1], SetCtrigX("X",NIfXArr[NIfXptr][i+1]-1,0x4,-1,SetTo,"X",IndexAlloc-1,0x0,0,0))
			table.insert(CtrigInitArr[P+1], SetCtrigX("X",NIfXArr[NIfXptr][i],0x158,0,SetTo,"X",NIfXArr[NIfXptr][i],0x4,1,0))
			table.insert(CtrigInitArr[P+1], SetCtrigX("X",NIfXArr[NIfXptr][i],0x15C,0,SetTo,"X",NIfXArr[NIfXptr][i],0x0,0,1))
			table.insert(CtrigInitArr[P+1], SetCtrigX("X",NIfXArr[NIfXptr][i],0x158,1,SetTo,"X",NIfXArr[NIfXptr][i],0x4,1,0))
			table.insert(CtrigInitArr[P+1], SetCtrigX("X",NIfXArr[NIfXptr][i],0x15C,1,SetTo,"X",NIfXArr[NIfXptr][i+1]-1,0x0,0,0))
		end
	end

	table.remove(NIfXArr,NIfXptr)
	table.remove(NIfXPArr,NIfXptr)
	NIfXptr = NIfXptr - 1
end

function CIfX(PlayerID, Conditions, Actions)
	STPopTrigArr(PlayerID)
	ORPopCondArr(PlayerID)
	TTPopTrigArr(PlayerID)
	Conditions = PopCondArr(Conditions)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,3)

	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc);
			Conditions,
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			SetDeaths(0,SetTo,0,0);
			SetDeaths(0,SetTo,0,0);
			Actions,
	   		PreserveTrigger();
		},
	}
	local X = {}
	PlayerID = PlayerConvert(PlayerID)
	table.insert(X, IndexAlloc)
	table.insert(CIfXArr, X)
	table.insert(CIfXPArr, PlayerID)
	CIfXptr = CIfXptr + 1
	IndexAlloc = IndexAlloc + 0x2
end

function CElseIfX(Conditions, Actions)
	local PlayerID
	PlayerID = CIfXPArr[CIfXptr]
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(0);
		},
		flag = {Preserved}
	}
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc);
		},
		flag = {Preserved}
	}
	STPopTrigArr(PlayerID)
	ORPopCondArr(PlayerID)
	TTPopTrigArr(PlayerID)
	Conditions = PopCondArr(Conditions)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,3)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc+1);
			Conditions,
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			SetDeaths(0,SetTo,0,0);
			SetDeaths(0,SetTo,0,0);
			Actions,
	   		PreserveTrigger();
		},
	}
	table.insert(CIfXArr[CIfXptr],IndexAlloc+1)
	IndexAlloc = IndexAlloc + 0x2
end

function CElseX(Actions)
	local PlayerID
	PlayerID = CIfXPArr[CIfXptr]
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(0);
		},
		flag = {Preserved}
	}
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc);
		},
		flag = {Preserved}
	}
	STPopTrigArr(PlayerID)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,3)
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc+1);
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			SetDeaths(0,SetTo,0,0);
			SetDeaths(0,SetTo,0,0);
			Actions,
	   		PreserveTrigger();
		},
	}
	table.insert(CIfXArr[CIfXptr],IndexAlloc+1)
	IndexAlloc = IndexAlloc + 0x2
end

function CIfXEnd()
	local PlayerID
	PlayerID = CIfXPArr[CIfXptr]
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(0);
		},
		flag = {Preserved}
	}
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc);
		},
		flag = {Preserved}
	}
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(IndexAlloc+1);
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			PreserveTrigger();
		},
	}
	table.insert(CIfXArr[CIfXptr],IndexAlloc+1)
	IndexAlloc = IndexAlloc + 0x2

	for k, P in pairs(PlayerID) do
		local Size = 0
		for i, index in pairs(CIfXArr[CIfXptr]) do
			Size = Size + 1
		end
		for i = 1, Size-1 do
			table.insert(CtrigInitArr[P+1], SetCtrigX("X",CIfXArr[CIfXptr][i],0x4,0,SetTo,"X",CIfXArr[CIfXptr][i+1]-1,0x0,0,0))
			table.insert(CtrigInitArr[P+1], SetCtrigX("X",CIfXArr[CIfXptr][i+1]-1,0x4,-1,SetTo,"X",IndexAlloc-1,0x0,0,0))
			table.insert(CtrigInitArr[P+1], SetCtrigX("X",CIfXArr[CIfXptr][i],0x158,0,SetTo,"X",CIfXArr[CIfXptr][i],0x4,1,0))
			table.insert(CtrigInitArr[P+1], SetCtrigX("X",CIfXArr[CIfXptr][i],0x15C,0,SetTo,"X",CIfXArr[CIfXptr][i],0x0,0,1))
			table.insert(CtrigInitArr[P+1], SetCtrigX("X",CIfXArr[CIfXptr][i],0x178,0,SetTo,"X",IndexAlloc-1,0x158,1,0))
			table.insert(CtrigInitArr[P+1], SetCtrigX("X",CIfXArr[CIfXptr][i],0x17C,0,SetTo,"X",CIfXArr[CIfXptr][i],0x4,1,0))
			table.insert(CtrigInitArr[P+1], SetCtrigX("X",CIfXArr[CIfXptr][i],0x198,0,SetTo,"X",IndexAlloc-1,0x15C,1,0))
			table.insert(CtrigInitArr[P+1], SetCtrigX("X",CIfXArr[CIfXptr][i],0x19C,0,SetTo,"X",CIfXArr[CIfXptr][i+1]-1,0x0,0,0))
		end
	end

	table.remove(CIfXArr,CIfXptr)
	table.remove(CIfXPArr,CIfXptr)
	CIfXptr = CIfXptr - 1
end

-- 변수 삽입형 조건/액션 (T) ------------------------------------------------------------

function TCDeathsX(Player,Type,Value,Code,Mask)
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)

	if Line >= 480 or Line < 0 then
		TCDeathX_LineOverflow()
	end
	local TCDeathsX = TCtrigX(Player,Index,0x1C8+0x4*Line,0,Type,Value,Mask)
	return TCDeathsX
end

function TCDeaths(Player,Type,Value,Code)
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)

	if Line >= 480 or Line < 0 then
		TCDeath_LineOverflow()
	end
	local TCDeaths = TCtrigX(Player,Index,0x1C8+0x4*Line,0,Type,Value)
	return TCDeaths
end

function TSetCDeathsX(Player,Type,Value,Code,Mask)
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)

	if Line >= 480 or Line < 0 then
		TSetCDeathsX_LineOverflow()
	end
	local TSetCDeathsX = TSetCtrig1X(Player,Index,0x1C8+0x4*Line,0,Type,Value,Mask)
	return TSetCDeathsX
end

function TSetCDeaths(Player,Type,Value,Code)
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)

	if Line >= 480 or Line < 0 then
		TSetCDeaths_LineOverflow()
	end
	local TSetCDeaths = TSetCtrig1X(Player,Index,0x1C8+0x4*Line,0,Type,Value)
	return TSetCDeaths
end

function TNDeathsX(Player,Type,Value,Code,Mask)
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)

	if Line >= 60 or Line < 0 then
		TNDeathX_LineOverflow()
	end
	local TNDeathsX = TCtrigX(FixPlayer,Index,0x1C8+0x20*Line+0x4*Player,0,Type,Value,Mask)
	return TNDeathsX
end

function TNDeaths(Player,Type,Value,Code)
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)

	if Line >= 60 or Line < 0 then
		TNDeath_LineOverflow()
	end
	local TNDeaths = TCtrigX(FixPlayer,Index,0x1C8+0x20*Line+0x4*Player,0,Type,Value)
	return TNDeaths
end

function TSetNDeathsX(Player,Type,Value,Code,Mask)
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)

	if Line >= 60 or Line < 0 then
		TSetNDeathsX_LineOverflow()
	end
	local TSetNDeathsX = TSetCtrig1X(FixPlayer,Index,0x1C8+0x20*Line+0x4*Player,0,Type,Value,Mask)
	return TSetNDeathsX
end

function TSetNDeaths(Player,Type,Value,Code)
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)

	if Line >= 60 or Line < 0 then
		TSetNDeaths_LineOverflow()
	end
	local TSetNDeaths = TSetCtrig1X(FixPlayer,Index,0x1C8+0x20*Line+0x4*Player,0,Type,Value)
	return TSetNDeaths
end

function TVariableX(Player,Index,Section,Type,Value,Mask)
	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	local Addr
	if Section == "EPD" then
		Addr = 0x158
	elseif Section == "Type" then
		Addr = 0x160
		if Mask == nil then
			Mask = 0xFF000000
		end
	elseif Section == "Value" then
		Addr = 0x15C
	elseif Section == "Next" then
		Addr = 0x4
	elseif Section == "Mask" then
		Addr = 0x148
	elseif Section == "Flag" then
		Addr = 0x164
		if Mask == nil then
			Mask = 0xFF
		end
	end

	local TVariableX = TCtrigX(Player,Index,Addr,0,Type,Value,Mask)
	return TVariableX
end

function TSetVariableX(Player,Index,Section,Type,Value,Mask)
	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	local Addr
	if Section == "EPD" then
		Addr = 0x158
	elseif Section == "Type" then
		Addr = 0x160
		if Mask == nil then
			Mask = 0xFF000000
		end
	elseif Section == "Value" then
		Addr = 0x15C
	elseif Section == "Next" then
		Addr = 0x4
	elseif Section == "Mask" then
		Addr = 0x148
	elseif Section == "Flag" then
		Addr = 0x164
		if Mask == nil then
			Mask = 0xFF
		end
	end

	local TSetVariableX = TSetCtrig1X(Player,Index,Addr,0,Type,Value,Mask)
	return TSetVariableX
end

function TVArrayX(VArray,Section,Type,Value,Mask)
	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	local Addr
	if Section == "EPD" then
		Addr = 0x158
	elseif Section == "Type" then
		Addr = 0x160
		if Mask == nil then
			Mask = 0xFF000000
		end
	elseif Section == "Value" then
		Addr = 0x15C
	elseif Section == "Next" then
		Addr = 0x4
	elseif Section == "Mask" then
		Addr = 0x148
	elseif Section == "Flag" then
		Addr = 0x164
		if Mask == nil then
			Mask = 0xFF
		end
	end

	if VArray[4] ~= "V" then
		TVArrayX_InputData_Error()
	end

	local TVArrayX = TCtrigX(VArray[1],VArray[2],Addr,VArray[3],Type,Value,Mask)
	return TVArrayX
end

function TSetVArrayX(VArray,Section,Type,Value,Mask)
	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	local Addr
	if Section == "EPD" then
		Addr = 0x158
	elseif Section == "Type" then
		Addr = 0x160
		if Mask == nil then
			Mask = 0xFF000000
		end
	elseif Section == "Value" then
		Addr = 0x15C
	elseif Section == "Next" then
		Addr = 0x4
	elseif Section == "Mask" then
		Addr = 0x148
	elseif Section == "Flag" then
		Addr = 0x164
		if Mask == nil then
			Mask = 0xFF
		end
	end

	if VArray[4] ~= "V" then
		TSetVArrayX_InputData_Error()
	end

	local TSetVArrayX = TSetCtrig1X(VArray[1],VArray[2],Addr,VArray[3],Type,Value,Mask)
	return TSetVArrayX
end

function TCVar(Player,Index,Type,Value,Mask)
	return TVariableX(Player,Index,"Value",Type,Value,Mask)
end

function TSetCVar(Player,Index,Type,Value,Mask)
	return TSetVariableX(Player,Index,"Value",Type,Value,Mask)
end

function TCVAar(VArray,Type,Value,Mask)
	return TVArrayX(VArray,"Value",Type,Value,Mask)
end

function TSetCVAar(VArray,Type,Value,Mask)
	return TSetVArrayX(VArray,"Value",Type,Value,Mask)
end

function TSetCtrigX(Player1,Index1,Address1,Next1,Type,Player2,Index2,Address2,EPD2,Next2,Mask)
	return TSetMemoryX(Mem(Player1,Index1,Address1,Next1),Type,Mem(Player2,Index2,Address2,Next2,EPD2),Mask)
end

function TSetCtrig2X(Offset,Type,Player2,Index2,Address2,EPD2,Next2,Mask)
	return TSetMemoryX(Offset,Type,Mem(Player2,Index2,Address2,Next2,EPD2),Mask)
end

function TSetCtrig1X(Player1,Index1,Address1,Next1,Type,Value,Mask)
	return TSetMemoryX(Mem(Player1,Index1,Address1,Next1),Type,Value,Mask)
end

function TCtrigX(Player,Index,Address,Next,Type,Value,Mask)
	return TMemoryX(Mem(Player,Index,Address,Next),Type,Value,Mask)
end

function TDeaths(Player,Type,Value,UnitId)
	local PushLine = 0
	local TypeNum = 0

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x10,1,0),
					SetCtrig1X("X","X",0x10,0,SetTo,Value[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0xC,1,0),
					SetCtrig1X("X","X",0xC,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		else
			TypeNum = TypeNum + 1
		end	
	end

	local TDeaths
	if TypeNum == 0 then
		TDeaths = Deaths(Player,Type,Value,UnitId)
	elseif TypeNum == 1 then
		TDeaths = CtrigX(Player[1],Player[2],Player[3],Player[4],Type,Value) -- UnitId 무시
	end 
	table.insert(PushCondArr,TDeaths)
	table.insert(CondLineArr,PushLine)
	return "TCond"
end

function TSetDeaths(Player,Type,Value,UnitId)
	local PushLine = 0
	local TypeNum = 0

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x13C,1,0),
					SetCtrig1X("X","X",0x13C,0,SetTo,Value[5])}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		else
			TypeNum = TypeNum + 2
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		else
			TypeNum = TypeNum + 1
		end
	end

	local TSetDeaths
	if TypeNum == 0 then
		TSetDeaths = SetDeaths(Player,Type,Value,UnitId)
	elseif TypeNum == 1 then
		TSetDeaths = SetCtrig1X(Player[1],Player[2],Player[3],Player[4],Type,Value)
	elseif TypeNum == 2 then
		TSetDeaths = SetCtrig2X(Player,Type,Value[1],Value[2],Value[3],EPD2,Value[4])
	elseif TypeNum == 3 then
		TSetDeaths = SetCtrigX(Player[1],Player[2],Player[3],Player[4],Type,Value[1],Value[2],Value[3],Value[5],Value[4])
	end 
	table.insert(PushActArr,TSetDeaths)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TDeathsX(Player,Type,Value,UnitId,Mask)
	local PushLine = 0
	local TypeNum = 0
	if type(Mask) == "table" then
		if Mask[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Mask})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Mask = TempData
		end

		if Mask[4] == "V" then
			if Mask[5] == nil then
				Mask[5] = 0
			end
			local X = {CallLabelAlways(Mask[1],Mask[2],Mask[3]),
					SetCtrig1X(Mask[1],Mask[2],0x148,Mask[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Mask[1],Mask[2],0x160,Mask[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Mask[1],Mask[2],0x158,Mask[3],SetTo,"X","X",0x8,1,0),
					SetCtrig1X("X","X",0x8,0,SetTo,Mask[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Mask = 0
			PushLine = PushLine + 1
		end
	end

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x10,1,0),
					SetCtrig1X("X","X",0x10,0,SetTo,Value[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0xC,1,0),
					SetCtrig1X("X","X",0xC,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		else
			TypeNum = TypeNum + 1
		end	
	end

	local TDeathsX
	if TypeNum == 0  then
		TDeathsX = DeathsX(Player,Type,Value,UnitId,Mask)
	elseif TypeNum == 1 then
		TDeathsX = CtrigX(Player[1],Player[2],Player[3],Player[4],Type,Value,Mask) -- UnitId 무시
	end 
	table.insert(PushCondArr,TDeathsX)
	table.insert(CondLineArr,PushLine)
	return "TCond"
end

function TSetDeathsX(Player,Type,Value,UnitId,Mask)
	local PushLine = 0
	local TypeNum = 0
	if type(Mask) == "table" then
		if Mask[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Mask})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Mask = TempData
		end

		if Mask[4] == "V" then
			if Mask[5] == nil then
				Mask[5] = 0
			end
			local X = {CallLabelAlways(Mask[1],Mask[2],Mask[3]),
					SetCtrig1X(Mask[1],Mask[2],0x148,Mask[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Mask[1],Mask[2],0x160,Mask[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Mask[1],Mask[2],0x158,Mask[3],SetTo,"X","X",0x128,1,0),
					SetCtrig1X("X","X",0x128,0,SetTo,Mask[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Mask = 0
			PushLine = PushLine + 1
		end
	end

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x13C,1,0),
					SetCtrig1X("X","X",0x13C,0,SetTo,Value[5])}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		else
			TypeNum = TypeNum + 2
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		else
			TypeNum = TypeNum + 1
		end
	end

	local TSetDeathsX
	if TypeNum == 0 then
		TSetDeathsX = SetDeathsX(Player,Type,Value,UnitId,Mask)
	elseif TypeNum == 1 then
		TSetDeathsX = SetCtrig1X(Player[1],Player[2],Player[3],Player[4],Type,Value,Mask)
	elseif TypeNum == 2 then
		TSetDeathsX = SetCtrig2X(Player,Type,Value[1],Value[2],Value[3],Value[5],Value[4],Mask)
	elseif TypeNum == 3 then
		TSetDeathsX = SetCtrigX(Player[1],Player[2],Player[3],Player[4],Type,Value[1],Value[2],Value[3],Value[5],Value[4],Mask)
	end 
	table.insert(PushActArr,TSetDeathsX)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TMemory(Offset,Type,Value)
	local PushLine = 0
	local TypeNum = 0

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x10,1,0),
					SetCtrig1X("X","X",0x10,0,SetTo,Value[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		end
	end

	if type(Offset) == "table" then
		if Offset[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Offset})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Offset = TempData
		end

		if Offset[4] == "V" then
			if Offset[5] == nil then
				Offset[5] = 0
			end
			local X = {CallLabelAlways(Offset[1],Offset[2],Offset[3]),
					SetCtrig1X(Offset[1],Offset[2],0x148,Offset[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Offset[1],Offset[2],0x160,Offset[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Offset[1],Offset[2],0x158,Offset[3],SetTo,"X","X",0xC,1,0),
					SetCtrig1X("X","X",0xC,0,SetTo,Offset[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Offset = 0x58A364
			PushLine = PushLine + 1
		else
			TypeNum = TypeNum + 1
		end	
	end

	local TMemory
	if TypeNum == 0 then
		TMemory = Memory(Offset,Type,Value)
	elseif TypeNum == 1 then
		TMemory = CtrigX(Offset[1],Offset[2],Offset[3],Offset[4],Type,Value)
	end 
	table.insert(PushCondArr,TMemory)
	table.insert(CondLineArr,PushLine)
	return "TCond"
end

function TSetMemory(Offset,Type,Value)
	local PushLine = 0
	local TypeNum = 0

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x13C,1,0),
					SetCtrig1X("X","X",0x13C,0,SetTo,Value[5])}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		else
			TypeNum = TypeNum + 2
		end
	end

	if type(Offset) == "table" then
		if Offset[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Offset})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Offset = TempData
		end

		if Offset[4] == "V" then
			if Offset[5] == nil then
				Offset[5] = 0
			end
			local X = {CallLabelAlways(Offset[1],Offset[2],Offset[3]),
					SetCtrig1X(Offset[1],Offset[2],0x148,Offset[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Offset[1],Offset[2],0x160,Offset[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Offset[1],Offset[2],0x158,Offset[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Offset[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Offset = 0x58A364
			PushLine = PushLine + 1
		else
			TypeNum = TypeNum + 1
		end
	end

	local TSetMemory 
	if TypeNum == 0 then
		TSetMemory = SetMemory(Offset,Type,Value)
	elseif TypeNum == 1 then
		TSetMemory = SetCtrig1X(Offset[1],Offset[2],Offset[3],Offset[4],Type,Value)
	elseif TypeNum == 2 then
		TSetMemory = SetCtrig2X(Offset,Type,Value[1],Value[2],Value[3],Value[5],Value[4])
	elseif TypeNum == 3 then
		TSetMemory = SetCtrigX(Offset[1],Offset[2],Offset[3],Offset[4],Type,Value[1],Value[2],Value[3],Value[5],Value[4])
	end 
	table.insert(PushActArr,TSetMemory)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TMemoryX(Offset,Type,Value,Mask)
	local PushLine = 0
	local TypeNum = 0
	if type(Mask) == "table" then
		if Mask[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Mask})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Mask = TempData
		end

		if Mask[4] == "V" then
			if Mask[5] == nil then
				Mask[5] = 0
			end
			local X = {CallLabelAlways(Mask[1],Mask[2],Mask[3]),
					SetCtrig1X(Mask[1],Mask[2],0x148,Mask[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Mask[1],Mask[2],0x160,Mask[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Mask[1],Mask[2],0x158,Mask[3],SetTo,"X","X",0x8,1,0),
					SetCtrig1X("X","X",0x8,0,SetTo,Mask[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Mask = 0
			PushLine = PushLine + 1
		else
			TMemoryX_InputData_Error()
		end
	end

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x10,1,0),
					SetCtrig1X("X","X",0x10,0,SetTo,Value[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		else
			TMemoryX_InputData_Error()
		end
	end

	if type(Offset) == "table" then
		if Offset[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Offset})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Offset = TempData
		end

		if Offset[4] == "V" then
			if Offset[5] == nil then
				Offset[5] = 0
			end
			local X = {CallLabelAlways(Offset[1],Offset[2],Offset[3]),
					SetCtrig1X(Offset[1],Offset[2],0x148,Offset[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Offset[1],Offset[2],0x160,Offset[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Offset[1],Offset[2],0x158,Offset[3],SetTo,"X","X",0xC,1,0),
					SetCtrig1X("X","X",0xC,0,SetTo,Offset[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Offset = 0x58A364
			PushLine = PushLine + 1
		else -- Mem
			TypeNum = TypeNum + 1
		end	
	end

	local TMemoryX 
	if TypeNum == 0 then
		TMemoryX = MemoryX(Offset,Type,Value,Mask)
	elseif TypeNum == 1 then
		TMemoryX = CtrigX(Offset[1],Offset[2],Offset[3],Offset[4],Type,Value,Mask)
	end 
	table.insert(PushCondArr,TMemoryX)
	table.insert(CondLineArr,PushLine)
	return "TCond"
end

function TSetMemoryX(Offset,Type,Value,Mask)
	local PushLine = 0
	local TypeNum = 0
	if type(Mask) == "table" then
		if Mask[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Mask})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Mask = TempData
		end

		if Mask[4] == "V" then
			if Mask[5] == nil then
				Mask[5] = 0
			end
			local X = {CallLabelAlways(Mask[1],Mask[2],Mask[3]),
					SetCtrig1X(Mask[1],Mask[2],0x148,Mask[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Mask[1],Mask[2],0x160,Mask[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Mask[1],Mask[2],0x158,Mask[3],SetTo,"X","X",0x128,1,0),
					SetCtrig1X("X","X",0x128,0,SetTo,Mask[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Mask = 0
			PushLine = PushLine + 1
		else
			TSetMemoryX_InputData_Error()
		end
	end

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x13C,1,0),
					SetCtrig1X("X","X",0x13C,0,SetTo,Value[5])}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		else
			TypeNum = TypeNum + 2
		end
	end

	if type(Offset) == "table" then
		if Offset[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Offset})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Offset = TempData
		end

		if Offset[4] == "V" then
			if Offset[5] == nil then
				Offset[5] = 0
			end
			local X = {CallLabelAlways(Offset[1],Offset[2],Offset[3]),
					SetCtrig1X(Offset[1],Offset[2],0x148,Offset[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Offset[1],Offset[2],0x160,Offset[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Offset[1],Offset[2],0x158,Offset[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Offset[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Offset = 0x58A364
			PushLine = PushLine + 1
		else
			TypeNum = TypeNum + 1
		end
	end

	local TSetMemoryX
	if TypeNum == 0 then
		TSetMemoryX = SetMemoryX(Offset,Type,Value,Mask)
	elseif TypeNum == 1 then
		TSetMemoryX = SetCtrig1X(Offset[1],Offset[2],Offset[3],Offset[4],Type,Value,Mask)
	elseif TypeNum == 2 then
		TSetMemoryX = SetCtrig2X(Offset,Type,Value[1],Value[2],Value[3],Value[5],Value[4],Mask)
	elseif TypeNum == 3 then
		TSetMemoryX = SetCtrigX(Offset[1],Offset[2],Offset[3],Offset[4],Type,Value[1],Value[2],Value[3],Value[5],Value[4],Mask)
	end 
	table.insert(PushActArr,TSetMemoryX)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TCommand(Player,Type,Value,UnitId)
	local PushLine = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x14,1,0),
					SetCtrig1X("X","X",0x14,0,SetTo,UnitId[5],0xFFFF)}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			UnitId = 0
			PushLine = PushLine + 1
		end
	end

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x10,1,0),
					SetCtrig1X("X","X",0x10,0,SetTo,Value[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0xC,1,0),
					SetCtrig1X("X","X",0xC,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end	
	end

	local TCommand = Command(Player,Type,Value,UnitId)
	table.insert(PushCondArr,TCommand)
	table.insert(CondLineArr,PushLine)
	return "TCond"
end

function TBring(Player,Type,Value,UnitId,Location)
	local PushLine = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x14,1,0),
					SetCtrig1X("X","X",0x14,0,SetTo,UnitId[5],0xFFFF)}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			UnitId = 0
			PushLine = PushLine + 1
		end
	end

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x10,1,0),
					SetCtrig1X("X","X",0x10,0,SetTo,Value[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0xC,1,0),
					SetCtrig1X("X","X",0xC,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end	
	end

	local TBring = Bring(Player,Type,Value,UnitId,Location)
	table.insert(PushCondArr,TBring)
	table.insert(CondLineArr,PushLine)
	return "TCond"
end

function TAccumulate(Player,Type,Value,ResourceType)
	local PushLine = 0

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x10,1,0),
					SetCtrig1X("X","X",0x10,0,SetTo,Value[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0xC,1,0),
					SetCtrig1X("X","X",0xC,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end	
	end

	local TAccumulate = Accumulate(Player,Type,Value,ResourceType)
	table.insert(PushCondArr,TAccumulate)
	table.insert(CondLineArr,PushLine)
	return "TCond"
end

function TCountdownTimer(Type,Value)
	local PushLine = 0

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x10,1,0),
					SetCtrig1X("X","X",0x10,0,SetTo,Value[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		end
	end

	local TCountdownTimer = CountdownTimer(Type,Value)
	table.insert(PushCondArr,TCountdownTimer)
	table.insert(CondLineArr,PushLine)
	return "TCond"
end

function TElapsedTime(Type,Value)
	local PushLine = 0

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x10,1,0),
					SetCtrig1X("X","X",0x10,0,SetTo,Value[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		end
	end

	local TElapsedTime = ElapsedTime(Type,Value)
	table.insert(PushCondArr,TElapsedTime)
	table.insert(CondLineArr,PushLine)
	return "TCond"
end

function TKills(Player,Type,Value,UnitId)
	local PushLine = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x14,1,0),
					SetCtrig1X("X","X",0x14,0,SetTo,UnitId[5],0xFFFF)}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			UnitId = 0
			PushLine = PushLine + 1
		end
	end

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x10,1,0),
					SetCtrig1X("X","X",0x10,0,SetTo,Value[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0xC,1,0),
					SetCtrig1X("X","X",0xC,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end	
	end

	local TKills = Kills(Player,Type,Value,UnitId)
	table.insert(PushCondArr,TKills)
	table.insert(CondLineArr,PushLine)
	return "TCond"
end

function TScore(Player,ScoreType,Type,Value)
	local PushLine = 0

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x10,1,0),
					SetCtrig1X("X","X",0x10,0,SetTo,Value[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0xC,1,0),
					SetCtrig1X("X","X",0xC,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end	
	end

	local TScore = Score(Player,ScoreType,Type,Value)
	table.insert(PushCondArr,TScore)
	table.insert(CondLineArr,PushLine)
	return "TCond"
end

function TOpponents(Player,Type,Value)
	local PushLine = 0

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x10,1,0),
					SetCtrig1X("X","X",0x10,0,SetTo,Value[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0xC,1,0),
					SetCtrig1X("X","X",0xC,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end	
	end

	local TOpponents = Opponents(Player,Type,Value)
	table.insert(PushCondArr,TOpponents)
	table.insert(CondLineArr,PushLine)
	return "TCond"
end

function TCreateUnit(Amount,UnitId,Location,Player)
	local PushLine = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,UnitId[5],0xFFFF)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			UnitId = 0
			PushLine = PushLine + 1
		end
	end

	if type(Amount) == "table" then
		if Amount[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Amount})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Amount = TempData
		end

		if Amount[4] == "V" then
			if Amount[5] == nil then
				Amount[5] = 0
			end
			local X = {CallLabelAlways(Amount[1],Amount[2],Amount[3]),
					SetCtrig1X(Amount[1],Amount[2],0x148,Amount[3],SetTo,0xFF000000),
					SetCtrig1X(Amount[1],Amount[2],0x160,Amount[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Amount[1],Amount[2],0x158,Amount[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,Amount[5]*0x01000000,0xFF000000)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Amount = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end
	end

	local TCreateUnit = CreateUnit(Amount,UnitId,Location,Player)
	table.insert(PushActArr,TCreateUnit)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TCreateUnitWithProperties(Amount,UnitId,Location,Player,Property)
	local PushLine = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,UnitId[5],0xFFFF)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			UnitId = 0
			PushLine = PushLine + 1
		end
	end

	if type(Amount) == "table" then
		if Amount[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Amount})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Amount = TempData
		end

		if Amount[4] == "V" then
			if Amount[5] == nil then
				Amount[5] = 0
			end
			local X = {CallLabelAlways(Amount[1],Amount[2],Amount[3]),
					SetCtrig1X(Amount[1],Amount[2],0x148,Amount[3],SetTo,0xFF000000),
					SetCtrig1X(Amount[1],Amount[2],0x160,Amount[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Amount[1],Amount[2],0x158,Amount[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,Amount[5]*0x01000000,0xFF000000)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Amount = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end
	end

	local TCreateUnitWithProperties = CreateUnitWithProperties(Amount,UnitId,Location,Player,Property)
	table.insert(PushActArr,TCreateUnitWithProperties)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TKillUnit(UnitId,Player)
	local PushLine = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,UnitId[5],0xFFFF)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			UnitId = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end
	end

	local TKillUnit = KillUnit(UnitId,Player)
	table.insert(PushActArr,TKillUnit)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end


function TKillUnitAt(Amount,UnitId,Location,Player)
	local PushLine = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,UnitId[5],0xFFFF)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			UnitId = 0
			PushLine = PushLine + 1
		end
	end

	if type(Amount) == "table" then
		if Amount[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Amount})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Amount = TempData
		end

		if Amount[4] == "V" then
			if Amount[5] == nil then
				Amount[5] = 0
			end
			local X = {CallLabelAlways(Amount[1],Amount[2],Amount[3]),
					SetCtrig1X(Amount[1],Amount[2],0x148,Amount[3],SetTo,0xFF000000),
					SetCtrig1X(Amount[1],Amount[2],0x160,Amount[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Amount[1],Amount[2],0x158,Amount[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,Amount[5]*0x01000000,0xFF000000)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Amount = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end
	end

	local TKillUnitAt = KillUnitAt(Amount,UnitId,Location,Player)
	table.insert(PushActArr,TKillUnitAt)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end


function TRemoveUnit(UnitId,Player)
	local PushLine = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,UnitId[5],0xFFFF)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			UnitId = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end
	end

	local TRemoveUnit = RemoveUnit(UnitId,Player)
	table.insert(PushActArr,TRemoveUnit)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TRemoveUnitAt(Amount,UnitId,Location,Player)
	local PushLine = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,UnitId[5],0xFFFF)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			UnitId = 0
			PushLine = PushLine + 1
		end
	end

	if type(Amount) == "table" then
		if Amount[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Amount})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Amount = TempData
		end

		if Amount[4] == "V" then
			if Amount[5] == nil then
				Amount[5] = 0
			end
			local X = {CallLabelAlways(Amount[1],Amount[2],Amount[3]),
					SetCtrig1X(Amount[1],Amount[2],0x148,Amount[3],SetTo,0xFF000000),
					SetCtrig1X(Amount[1],Amount[2],0x160,Amount[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Amount[1],Amount[2],0x158,Amount[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,Amount[5]*0x01000000,0xFF000000)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Amount = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end
	end

	local TRemoveUnitAt = RemoveUnitAt(Amount,UnitId,Location,Player)
	table.insert(PushActArr,TRemoveUnitAt)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TGiveUnits(Amount,UnitId,Player,Location,NewPlayer)
	local PushLine = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,UnitId[5],0xFFFF)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			UnitId = 0
			PushLine = PushLine + 1
		end
	end

	if type(Amount) == "table" then
		if Amount[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Amount})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Amount = TempData
		end

		if Amount[4] == "V" then
			if Amount[5] == nil then
				Amount[5] = 0
			end
			local X = {CallLabelAlways(Amount[1],Amount[2],Amount[3]),
					SetCtrig1X(Amount[1],Amount[2],0x148,Amount[3],SetTo,0xFF000000),
					SetCtrig1X(Amount[1],Amount[2],0x160,Amount[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Amount[1],Amount[2],0x158,Amount[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,Amount[5]*0x01000000,0xFF000000)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Amount = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end
	end
	
	if type(NewPlayer) == "table" and NewPlayer[1] ~= nil then
		if NewPlayer[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,NewPlayer})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			NewPlayer = TempData
		end

		if NewPlayer[4] == "V" then
			if NewPlayer[5] == nil then
				NewPlayer[5] = 0
			end
			local X = {CallLabelAlways(NewPlayer[1],NewPlayer[2],NewPlayer[3]),
					SetCtrig1X(NewPlayer[1],NewPlayer[2],0x148,NewPlayer[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(NewPlayer[1],NewPlayer[2],0x160,NewPlayer[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(NewPlayer[1],NewPlayer[2],0x158,NewPlayer[3],SetTo,"X","X",0x13C,1,0),
					SetCtrig1X("X","X",0x13C,0,SetTo,NewPlayer[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			NewPlayer = 0
			PushLine = PushLine + 1
		end
	end

	local TGiveUnits = GiveUnits(Amount,UnitId,Player,Location,NewPlayer)
	table.insert(PushActArr,TGiveUnits)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TMoveUnit(Amount,UnitId,Player,StartLocation,DestLocation)
	local PushLine = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,UnitId[5],0xFFFF)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			UnitId = 0
			PushLine = PushLine + 1
		end
	end

	if type(Amount) == "table" then
		if Amount[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Amount})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Amount = TempData
		end

		if Amount[4] == "V" then
			if Amount[5] == nil then
				Amount[5] = 0
			end
			local X = {CallLabelAlways(Amount[1],Amount[2],Amount[3]),
					SetCtrig1X(Amount[1],Amount[2],0x148,Amount[3],SetTo,0xFF000000),
					SetCtrig1X(Amount[1],Amount[2],0x160,Amount[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Amount[1],Amount[2],0x158,Amount[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,Amount[5]*0x01000000,0xFF000000)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Amount = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end
	end
	
	local TMoveUnit = MoveUnit(Amount,UnitId,Player,StartLocation,DestLocation)
	table.insert(PushActArr,TMoveUnit)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TMoveLocation(Location,UnitId,Player,DestLocation)
	local PushLine = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,UnitId[5],0xFFFF)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			UnitId = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end
	end
	
	local TMoveLocation = MoveLocation(Location,UnitId,Player,DestLocation)
	table.insert(PushActArr,TMoveLocation)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TOrder(UnitId,Player,StartLocation,OrderType,DestLocation)
	local PushLine = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,UnitId[5],0xFFFF)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			UnitId = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end
	end
	
	local TOrder = Order(UnitId,Player,StartLocation,OrderType,DestLocation)
	table.insert(PushActArr,TOrder)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TModifyUnitEnergy(Amount,UnitId,Player,Location,Value)
	local PushLine = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,UnitId[5],0xFFFF)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			UnitId = 0
			PushLine = PushLine + 1
		end
	end

	if type(Amount) == "table" then
		if Amount[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Amount})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Amount = TempData
		end

		if Amount[4] == "V" then
			if Amount[5] == nil then
				Amount[5] = 0
			end
			local X = {CallLabelAlways(Amount[1],Amount[2],Amount[3]),
					SetCtrig1X(Amount[1],Amount[2],0x148,Amount[3],SetTo,0xFF000000),
					SetCtrig1X(Amount[1],Amount[2],0x160,Amount[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Amount[1],Amount[2],0x158,Amount[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,Amount[5]*0x01000000,0xFF000000)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Amount = 0
			PushLine = PushLine + 1
		end
	end

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x13C,1,0),
					SetCtrig1X("X","X",0x13C,0,SetTo,Value[5])}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end
	end

	local TModifyUnitEnergy = ModifyUnitEnergy(Amount,UnitId,Player,Location,Value)
	table.insert(PushActArr,TModifyUnitEnergy)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TModifyUnitHangarCount(Value,Amount,UnitId,Player,Location)
	local PushLine = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,UnitId[5],0xFFFF)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			UnitId = 0
			PushLine = PushLine + 1
		end
	end

	if type(Amount) == "table" then
		if Amount[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Amount})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Amount = TempData
		end

		if Amount[4] == "V" then
			if Amount[5] == nil then
				Amount[5] = 0
			end
			local X = {CallLabelAlways(Amount[1],Amount[2],Amount[3]),
					SetCtrig1X(Amount[1],Amount[2],0x148,Amount[3],SetTo,0xFF000000),
					SetCtrig1X(Amount[1],Amount[2],0x160,Amount[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Amount[1],Amount[2],0x158,Amount[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,Amount[5]*0x01000000,0xFF000000)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Amount = 0
			PushLine = PushLine + 1
		end
	end

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x13C,1,0),
					SetCtrig1X("X","X",0x13C,0,SetTo,Value[5])}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end
	end

	local TModifyUnitHangarCount = ModifyUnitHangarCount(Value,Amount,UnitId,Player,Location)
	table.insert(PushActArr,TModifyUnitHangarCount)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TModifyUnitHitPoints(Amount,UnitId,Player,Location,Value)
	local PushLine = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,UnitId[5],0xFFFF)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			UnitId = 0
			PushLine = PushLine + 1
		end
	end

	if type(Amount) == "table" then
		if Amount[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Amount})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Amount = TempData
		end

		if Amount[4] == "V" then
			if Amount[5] == nil then
				Amount[5] = 0
			end
			local X = {CallLabelAlways(Amount[1],Amount[2],Amount[3]),
					SetCtrig1X(Amount[1],Amount[2],0x148,Amount[3],SetTo,0xFF000000),
					SetCtrig1X(Amount[1],Amount[2],0x160,Amount[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Amount[1],Amount[2],0x158,Amount[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,Amount[5]*0x01000000,0xFF000000)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Amount = 0
			PushLine = PushLine + 1
		end
	end

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x13C,1,0),
					SetCtrig1X("X","X",0x13C,0,SetTo,Value[5])}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end
	end

	local TModifyUnitHitPoints = ModifyUnitHitPoints(Amount,UnitId,Player,Location,Value)
	table.insert(PushActArr,TModifyUnitHitPoints)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TModifyUnitResourceAmount(Amount,Player,Location,Value)
	local PushLine = 0

	if type(Amount) == "table" then
		if Amount[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Amount})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Amount = TempData
		end

		if Amount[4] == "V" then
			if Amount[5] == nil then
				Amount[5] = 0
			end
			local X = {CallLabelAlways(Amount[1],Amount[2],Amount[3]),
					SetCtrig1X(Amount[1],Amount[2],0x148,Amount[3],SetTo,0xFF000000),
					SetCtrig1X(Amount[1],Amount[2],0x160,Amount[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Amount[1],Amount[2],0x158,Amount[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,Amount[5]*0x01000000,0xFF000000)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Amount = 0
			PushLine = PushLine + 1
		end
	end

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x13C,1,0),
					SetCtrig1X("X","X",0x13C,0,SetTo,Value[5])}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end
	end

	local TModifyUnitResourceAmount = ModifyUnitResourceAmount(Amount,Player,Location,Value)
	table.insert(PushActArr,TModifyUnitResourceAmount)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TModifyUnitShields(Amount,UnitId,Player,Location,Value)
	local PushLine = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,UnitId[5],0xFFFF)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			UnitId = 0
			PushLine = PushLine + 1
		end
	end

	if type(Amount) == "table" then
		if Amount[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Amount})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Amount = TempData
		end

		if Amount[4] == "V" then
			if Amount[5] == nil then
				Amount[5] = 0
			end
			local X = {CallLabelAlways(Amount[1],Amount[2],Amount[3]),
					SetCtrig1X(Amount[1],Amount[2],0x148,Amount[3],SetTo,0xFF000000),
					SetCtrig1X(Amount[1],Amount[2],0x160,Amount[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Amount[1],Amount[2],0x158,Amount[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,Amount[5]*0x01000000,0xFF000000)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Amount = 0
			PushLine = PushLine + 1
		end
	end

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x13C,1,0),
					SetCtrig1X("X","X",0x13C,0,SetTo,Value[5])}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end
	end

	local TModifyUnitShields = ModifyUnitShields(Amount,UnitId,Player,Location,Value)
	table.insert(PushActArr,TModifyUnitShields)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TSetCountdownTimer(Type,Time)
	local PushLine = 0

	if type(Time) == "table" then
		if Time[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Time})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Time = TempData
		end

		if Time[4] == "V" then
			if Time[5] == nil then
				Time[5] = 0
			end
			local X = {CallLabelAlways(Time[1],Time[2],Time[3]),
					SetCtrig1X(Time[1],Time[2],0x148,Time[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Time[1],Time[2],0x160,Time[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Time[1],Time[2],0x158,Time[3],SetTo,"X","X",0x134,1,0),
					SetCtrig1X("X","X",0x134,0,SetTo,Time[5])}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Time = 0
			PushLine = PushLine + 1
		end
	end

	local TSetCountdownTimer = SetCountdownTimer(Type,Time)
	table.insert(PushActArr,TSetCountdownTimer)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TSetResources(Player,Type,Value,ResourceType)
	local PushLine = 0

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x13C,1,0),
					SetCtrig1X("X","X",0x13C,0,SetTo,Value[5])}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end
	end

	local TSetResources = SetResources(Player,Type,Value,ResourceType)
	table.insert(PushActArr,TSetResources)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TSetScore(Player,Type,Value,ScoreType)
	local PushLine = 0

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x13C,1,0),
					SetCtrig1X("X","X",0x13C,0,SetTo,Value[5])}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Value = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end
	end

	local TSetScore = SetScore(Player,Type,Value,ScoreType)
	table.insert(PushActArr,TSetScore)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TWait(Time)
	local PushLine = 0

	if type(Time) == "table" then
		if Time[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Time})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Time = TempData
		end

		if Time[4] == "V" then
			if Time[5] == nil then
				Time[5] = 0
			end
			local X = {CallLabelAlways(Time[1],Time[2],Time[3]),
					SetCtrig1X(Time[1],Time[2],0x148,Time[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Time[1],Time[2],0x160,Time[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Time[1],Time[2],0x158,Time[3],SetTo,"X","X",0x134,1,0),
					SetCtrig1X("X","X",0x134,0,SetTo,Time[5])}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Time = 0
			PushLine = PushLine + 1
		end
	end

	local TWait = Wait(Time)
	table.insert(PushActArr,TWait)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TSetDoodadState(State,UnitId,Player,Location)
	local PushLine = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,UnitId[5],0xFFFF)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			UnitId = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end
	end

	local TSetDoodadState = SetDoodadState(State,UnitId,Player,Location)
	table.insert(PushActArr,TSetDoodadState)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TSetInvincibility(State,UnitId,Player,Location)
	local PushLine = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x140,1,0),
					SetCtrig1X("X","X",0x140,0,SetTo,UnitId[5],0xFFFF)}
			
			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			UnitId = 0
			PushLine = PushLine + 1
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end
	end

	local TSetInvincibility = SetInvincibility(State,UnitId,Player,Location)
	table.insert(PushActArr,TSetInvincibility)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

function TSetAllianceStatus(Player,Status)
	local PushLine = 0

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x138,1,0),
					SetCtrig1X("X","X",0x138,0,SetTo,Player[5])}

			table.insert(PushTrigArr,X)
			PushTrigStack = PushTrigStack + 1
			Player = 0
			PushLine = PushLine + 1
		end
	end

	local TSetAllianceStatus = SetAllianceStatus(Player,Status)
	table.insert(PushActArr,TSetAllianceStatus)
	table.insert(ActLineArr,PushLine)
	return "TAct"
end

-- 특수 조건 관련 조건/함수 (EUD/TT) --------------------------------------------------------

function EUDORInit(PlayerID) -- Flag1 = CORInit(P1) -> CORCond(Flag1) -- 구 함수 / 실질 사용X
	local FIndex = FlagAlloc
	local FCode = FlagIndex(FIndex)

	EUDORPlayer = PlayerID
	EUDORFlag = FCode
	DoActionsX(PlayerID,SetCDeaths("X",SetTo,0,FCode))

	FlagAlloc = FlagAlloc + 1
	return FIndex
end

function EUDOR(AND_Conditions) -- {{<-And->}<-Or->{<-And->}<-Or->{<-And->}} -- 구 함수 / 실질 사용X
	CTrigger({EUDORPlayer},AND_Conditions,{SetCDeaths("X",SetTo,1,EUDORFlag)},{Preserved})
end

function EUDCond(FlagID) -- 구 함수 / 실질 사용X
	return CDeaths("X",Exactly,1,FlagIndex(FlagID))
end

function EUDCompare(PlayerID,Mode,TargetCond)  -- 구 함수 / 실질 사용X

	local FIndex
	if Mode == ">" or Mode == Above then
		FIndex = EUDAbove(PlayerID,TargetCond)
	elseif Mode == "<" or Mode == Below then
		FIndex = EUDBelow(PlayerID,TargetCond)
	elseif Mode == "!=" or Mode == NotSame then
		FIndex = EUDNotSame(PlayerID,TargetCond)
	else
		EUDCompare_TypeError()
	end
	return FIndex
end

function EUDNotSame(PlayerID,TargetCond) -- 구 함수 / 실질 사용X
	local FIndex = FlagAlloc
	local FCode = FlagIndex(FIndex)

	DoActionsX(PlayerID,{SetCDeaths("X",SetTo,1,FCode),SetCtrig1X("X","X",0x28,PushTrigStack+1,SetTo,Exactly*65536,0xFF0000)})
	CTrigger(PlayerID,{TargetCond},{SetCDeaths("X",SetTo,0,FCode)},{Preserved})

	FlagAlloc = FlagAlloc + 1
	return FIndex
end

function EUDAbove(PlayerID,TargetCond) -- 구 함수 / 실질 사용X
	local FIndex = FlagAlloc
	local FCode = FlagIndex(FIndex)

	DoActionsX(PlayerID,{SetCDeaths("X",SetTo,0,FCode),
						SetCtrigX("X","X",0x4,PushTrigStack+1,SetTo,"X","X",0x0,0,PushTrigStack+2),
						SetCtrig1X("X","X",0x15C,PushTrigStack+1,SetTo,1),
						SetCtrig1X("X","X",0x28,PushTrigStack+1,SetTo,AtLeast*65536,0xFF0000)})
	CTrigger(PlayerID,{TargetCond},{SetCDeaths("X",SetTo,1,FCode)},{Preserved})
	DoActionsX(PlayerID,{SetCtrigX("X","X",0x4,0,SetTo,"X","X",0x0,0,-1),
						SetCtrigX("X","X",0x4,-1,SetTo,"X","X",0x0,0,1),
						SetCtrig1X("X","X",0x15C,-1,SetTo,0),
						SetCtrig1X("X","X",0x28,-1,SetTo,Exactly*65536,0xFF0000)})

	FlagAlloc = FlagAlloc + 1
	return FIndex
end

function EUDBelow(PlayerID,TargetCond) -- 구 함수 / 실질 사용X
	local FIndex = FlagAlloc
	local FCode = FlagIndex(FIndex)

	DoActionsX(PlayerID,{SetCDeaths("X",SetTo,0,FCode),
						SetCtrigX("X","X",0x4,PushTrigStack+1,SetTo,"X","X",0x0,0,PushTrigStack+2),
						SetCtrig1X("X","X",0x15C,PushTrigStack+1,SetTo,1),
						SetCtrig1X("X","X",0x28,PushTrigStack+1,SetTo,AtMost*65536,0xFF0000)})
	CTrigger(PlayerID,{TargetCond},{SetCDeaths("X",SetTo,1,FCode)},{Preserved})
	DoActionsX(PlayerID,{SetCtrigX("X","X",0x4,0,SetTo,"X","X",0x0,0,-1),
						SetCtrigX("X","X",0x4,-1,SetTo,"X","X",0x0,0,1),
						SetCtrig1X("X","X",0x15C,-1,SetTo,0),
						SetCtrig1X("X","X",0x28,-1,SetTo,Exactly*65536,0xFF0000)})

	FlagAlloc = FlagAlloc + 1
	return FIndex
end

function TTOR(OR_Conditions)
	VarXReleaseLock = 1
	local FIndex = FlagAlloc
	local FCode = FlagIndex(FIndex)

	if type(OR_Conditions) ~= "table" then
		TTOR_InputData_Error()
	end 

	table.insert(ORPushCondArr,OR_Conditions)
	table.insert(ORFCodeArr,FCode)

	FlagAlloc = FlagAlloc + 1
	local TTOR = CDeaths("X",Exactly,1,FCode)
	return TTOR
end

function TTAND(AND_Conditions)
	if type(AND_Conditions) ~= "table" then
		TTAND_InputData_Error()
	end 
	local TTAND = {"AND"}
	table.insert(TTAND,AND_Conditions)
	return TTAND
end

function _TMemoryX(Offset,Type,Value,Mask)
	return {"T","MemoryX",Offset,Type,Value,Mask}
end

function _TMemory(Offset,Type,Value)
	return {"T","Memory",Offset,Type,Value}
end

function _TCVar(Player,Index,Type,Value,Mask)
	return {"T","CVar",Player,Index,Type,Value,Mask}
end

function _TCVAar(VArray,Type,Value,Mask)
	return {"T","CVAar",VArray,Type,Value,Mask}
end

function _TVariableX(Player,Index,Section,Type,Value,Mask)
	return {"T","VariableX",Player,Index,Section,Type,Value,Mask}
end

function _TVArrayX(VArray,Section,Type,Value,Mask)
	return {"T","VArrayX",VArray,Section,Type,Value,Mask}
end

function _TNDeathsX(Player,Type,Value,Code,Mask)
	return {"T","NDeathsX",Player,Type,Value,Code,Mask}
end

function _TNDeaths(Player,Type,Value,Code)
	return {"T","NDeaths",Player,Type,Value,Code}
end

function _TCDeathsX(Player,Type,Value,Code,Mask)
	return {"T","CDeathsX",Player,Type,Value,Code,Mask}
end

function _TCDeaths(Player,Type,Value,Code)
	return {"T","CDeaths",Player,Type,Value,Code}
end

function _TCtrigX(Player,Index,Address,Next,Type,Value,Mask)
	return {"T","CtrigX",Player,Index,Address,Next,Type,Value,Mask}
end

function _TDeaths(Player,Type,Value,UnitId)
	return {"T","Deaths",Player,Type,Value,UnitId}
end

function _TDeathsX(Player,Type,Value,UnitId,Mask)
	return {"T","DeathsX",Player,Type,Value,UnitId,Mask}
end

function _TCommand(Player,Type,Value,UnitId)
	return {"T","Command",Player,Type,Value,UnitId}
end

function _TBring(Player,Type,Value,UnitId,Location)
	return {"T","Bring",Player,Type,Value,UnitId,Location}
end

function _TAccumulate(Player,Type,Value,ResourceType)
	return {"T","Accumulate",Player,Type,Value,ResourceType}
end

function _TCountdownTimer(Type,Value)
	return {"T","CountdownTimer",Type,Value}
end

function _TElapsedTime(Type,Value)
	return {"T","ElapsedTime",Type,Value}
end

function _TKills(Player,Type,Value,UnitId)
	return {"T","Kills",Player,Type,Value,UnitId}
end

function _TScore(Player,ScoreType,Type,Value)
	return {"T","Score",Player,ScoreType,Type,Value}
end

function _TOpponents(Player,Type,Value)
	return {"T","Opponents",Player,Type,Value}
end

function _TTMemoryX(Offset,Type,Value,Mask)
	return {"TT","MemoryX",Offset,Type,Value,Mask}
end

function _TTMemory(Offset,Type,Value)
	return {"TT","Memory",Offset,Type,Value}
end

function _TTCVar(Player,Index,Type,Value,Mask)
	return {"TT","CVar",Player,Index,Type,Value,Mask}
end

function _TTCVAar(VArray,Type,Value,Mask)
	return {"TT","CVAar",VArray,Type,Value,Mask}
end

function _TTVariableX(Player,Index,Section,Type,Value,Mask)
	return {"TT","VariableX",Player,Index,Section,Type,Value,Mask}
end

function _TTVArrayX(VArray,Section,Type,Value,Mask)
	return {"TT","VArrayX",VArray,Section,Type,Value,Mask}
end

function _TTNDeathsX(Player,Type,Value,Code,Mask)
	return {"TT","NDeathsX",Player,Type,Value,Code,Mask}
end

function _TTNDeaths(Player,Type,Value,Code)
	return {"TT","NDeaths",Player,Type,Value,Code}
end

function _TTCDeathsX(Player,Type,Value,Code,Mask)
	return {"TT","CDeathsX",Player,Type,Value,Code,Mask}
end

function _TTCDeaths(Player,Type,Value,Code)
	return {"TT","CDeaths",Player,Type,Value,Code}
end

function _TTCtrigX(Player,Index,Address,Next,Type,Value,Mask)
	return {"TT","CtrigX",Player,Index,Address,Next,Type,Value,Mask}
end

function _TTDeaths(Player,Type,Value,UnitId)
	return {"TT","Deaths",Player,Type,Value,UnitId}
end

function _TTDeathsX(Player,Type,Value,UnitId,Mask)
	return {"TT","DeathsX",Player,Type,Value,UnitId,Mask}
end

function _TTCommand(Player,Type,Value,UnitId)
	return {"TT","Command",Player,Type,Value,UnitId}
end

function _TTBring(Player,Type,Value,UnitId,Location)
	return {"TT","Bring",Player,Type,Value,UnitId,Location}
end

function _TTAccumulate(Player,Type,Value,ResourceType)
	return {"TT","Accumulate",Player,Type,Value,ResourceType}
end

function _TTCountdownTimer(Type,Value)
	return {"TT","CountdownTimer",Type,Value}
end

function _TTElapsedTime(Type,Value)
	return {"TT","ElapsedTime",Type,Value}
end

function _TTKills(Player,Type,Value,UnitId)
	return {"TT","Kills",Player,Type,Value,UnitId}
end

function _TTScore(Player,ScoreType,Type,Value)
	return {"TT","Score",Player,ScoreType,Type,Value}
end

function _TTOpponents(Player,Type,Value)
	return {"TT","Opponents",Player,Type,Value}
end

-----------------------------------------------------------------

function TTCVar(Player,Index,Type,Value,Mask)
	return TTVariableX(Player,Index,"Value",Type,Value,Mask)
end

function TTCVAar(VArray,Type,Value,Mask)
	return TTVArrayX(VArray,"Value",Type,Value,Mask)
end

function TTVariableX(Player,Index,Section,Type,Value,Mask)
	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	local Addr
	if Section == "EPD" then
		Addr = 0x158
	elseif Section == "Type" then
		Addr = 0x160
		if Mask == nil then
			Mask = 0xFF000000
		end
	elseif Section == "Value" then
		Addr = 0x15C
	elseif Section == "Next" then
		Addr = 0x4
	elseif Section == "Mask" then
		Addr = 0x148
	elseif Section == "Flag" then
		Addr = 0x164
		if Mask == nil then
			Mask = 0xFF
		end
	end

	local TTVariableX = TTCtrigX(Player,Index,Addr,0,Type,Value,Mask)
	return TTVariableX
end

function TTVArrayX(VArray,Section,Type,Value,Mask)
	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	local Addr
	if Section == "EPD" then
		Addr = 0x158
	elseif Section == "Type" then
		Addr = 0x160
		if Mask == nil then
			Mask = 0xFF000000
		end
	elseif Section == "Value" then
		Addr = 0x15C
	elseif Section == "Next" then
		Addr = 0x4
	elseif Section == "Mask" then
		Addr = 0x148
	elseif Section == "Flag" then
		Addr = 0x164
		if Mask == nil then
			Mask = 0xFF
		end
	end

	if VArray[4] ~= "V" then
		TTVArrayX_InputData_Error()
	end

	local TTVArrayX = TTCtrigX(VArray[1],VArray[2],Addr,VArray[3],Type,Value,Mask)
	return TTVArrayX
end

function TTNDeathsX(Player,Type,Value,Code,Mask)
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)

	if Line >= 60 or Line < 0 then
		TTNDeathX_LineOverflow()
	end
	local TTNDeathsX = TTCtrigX(FixPlayer,Index,0x1C8+0x20*Line+0x4*Player,0,Type,Value,Mask)
	return TTNDeathsX
end

function TTNDeaths(Player,Type,Value,Code)
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)

	if Line >= 60 or Line < 0 then
		TTNDeath_LineOverflow()
	end
	local TTNDeaths = TTCtrigX(FixPlayer,Index,0x1C8+0x20*Line+0x4*Player,0,Type,Value)
	return TTNDeaths
end

function TTCDeathsX(Player,Type,Value,Code,Mask)
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)

	if Line >= 480 or Line < 0 then
		TTCDeathX_LineOverflow()
	end
	local TTCDeathsX = TTCtrigX(Player,Index,0x1C8+0x4*Line,0,Type,Value,Mask)
	return TTCDeathsX
end

function TTCDeaths(Player,Type,Value,Code)
	local Line = bit32.band(Code, 0xFFFF0000)/65536
	local Index = bit32.band(Code, 0xFFFF)

	if Line >= 480 or Line < 0 then
		TTCDeath_LineOverflow()
	end
	local TTCDeaths = TTCtrigX(Player,Index,0x1C8+0x4*Line,0,Type,Value)
	return TTCDeaths
end

function TTCtrigX(Player,Index,Address,Next,Type,Value,Mask)	
	return TTMemoryX(Mem(Player,Index,Address,Next),Type,Value,Mask)
end

function TTDeaths(Player,Type,Value,UnitId)
	local Mode
	if Type == ">" or Type == Above then
		Mode = 1
	elseif Type == "<" or Type == Below then
		Mode = 2
	elseif Type == "!=" or Type == NotSame then
		Mode = 0
	else
		TTDeaths_TypeError()
	end
	local TypeNum = 0
	local FIndex = FlagAlloc
	local FCode = FlagIndex(FIndex)
	local Y = {}
	local Z = 0
	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x24,1,0),
					SetCtrig1X("X","X",0x24,0,SetTo,Value[5])}
			Z = Z + 1
			table.insert(Y,X)
			Value = 0
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x20,1,0),
					SetCtrig1X("X","X",0x20,0,SetTo,Player[5])}
			Z = Z + 1
			table.insert(Y,X)
			Player = 0
		else
			TypeNum = 1
		end
	end

	local TTDeaths2
	if TypeNum == 0 then
		TTDeaths2 = Deaths(Player,Exactly,Value,UnitId)
	elseif TypeNum == 1 then
		TTDeaths2 = CtrigX(Player[1],Player[2],Player[3],Player[4],Exactly,Value)
	end 
	table.insert(TTPushTrigArr,Y)
	table.insert(TTPushCondArr,TTDeaths2)
	table.insert(TTFCodeArr,FCode)
	table.insert(TTModeArr,Mode)

	FlagAlloc = FlagAlloc + 1
	local TTDeaths = CDeaths("X",Exactly,1,FCode)
	return TTDeaths
end

function TTDeathsX(Player,Type,Value,UnitId,Mask)
	local Mode
	if Type == ">" or Type == Above then
		Mode = 1
	elseif Type == "<" or Type == Below then
		Mode = 2
	elseif Type == "!=" or Type == NotSame then
		Mode = 0
	else
		TTDeathsX_TypeError()
	end
	local TypeNum = 0
	local FIndex = FlagAlloc
	local FCode = FlagIndex(FIndex)
	local Y = {}
	local Z = 0
	if type(Mask) == "table" then
		if Mask[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Mask})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Mask = TempData
		end

		if Mask[4] == "V" then
			if Mask[5] == nil then
				Mask[5] = 0
			end
			local X = {CallLabelAlways(Mask[1],Mask[2],Mask[3]),
					SetCtrig1X(Mask[1],Mask[2],0x148,Mask[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Mask[1],Mask[2],0x160,Mask[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Mask[1],Mask[2],0x158,Mask[3],SetTo,"X","X",0x1C,1,0),
					SetCtrig1X("X","X",0x1C,0,SetTo,Mask[5])}
			Z = Z + 1
			table.insert(Y,X)
			Mask = 0
		end
	end

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x24,1,0),
					SetCtrig1X("X","X",0x24,0,SetTo,Value[5])}
			Z = Z + 1
			table.insert(Y,X)
			Value = 0
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x20,1,0),
					SetCtrig1X("X","X",0x20,0,SetTo,Player[5])}
			Z = Z + 1
			table.insert(Y,X)
			Player = 0
		else
			TypeNum = 1
		end
	end

	local TTDeaths2X
	if TypeNum == 0 then
		TTDeaths2X = DeathsX(Player,Exactly,Value,UnitId,Mask)
	elseif TypeNum == 1 then
		TTDeaths2X = CtrigX(Player[1],Player[2],Player[3],Player[4],Exactly,Value,Mask)
	end 
	table.insert(TTPushTrigArr,Y)
	table.insert(TTPushCondArr,TTDeaths2X)
	table.insert(TTFCodeArr,FCode)
	table.insert(TTModeArr,Mode)

	FlagAlloc = FlagAlloc + 1
	local TTDeathsX = CDeaths("X",Exactly,1,FCode)
	return TTDeathsX
end

function TTMemory(Offset,Type,Value)
	local Mode
	if Type == ">" or Type == Above then
		Mode = 1
	elseif Type == "<" or Type == Below then
		Mode = 2
	elseif Type == "!=" or Type == NotSame then
		Mode = 0
	else
		TTMemory_TypeError()
	end
	local TypeNum = 0
	local FIndex = FlagAlloc
	local FCode = FlagIndex(FIndex)
	local Y = {}
	local Z = 0

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x24,1,0),
					SetCtrig1X("X","X",0x24,0,SetTo,Value[5])}
			Z = Z + 1
			table.insert(Y,X)
			Value = 0
		end
	end

	if type(Offset) == "table" then
		if Offset[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Offset})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Offset = TempData
		end

		if Offset[4] == "V" then
			if Offset[5] == nil then
				Offset[5] = 0
			end
			local X = {CallLabelAlways(Offset[1],Offset[2],Offset[3]),
					SetCtrig1X(Offset[1],Offset[2],0x148,Offset[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Offset[1],Offset[2],0x160,Offset[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Offset[1],Offset[2],0x158,Offset[3],SetTo,"X","X",0x20,1,0),
					SetCtrig1X("X","X",0x20,0,SetTo,Offset[5])}
			Z = Z + 1
			table.insert(Y,X)
			Offset = 0x58A364
		else
			TypeNum = 1
		end
	end

	local TTMemory2
	if TypeNum == 0 then
		TTMemory2 = Memory(Offset,Exactly,Value)
	elseif TypeNum == 1 then
		TTMemory2 = CtrigX(Offset[1],Offset[2],Offset[3],Offset[4],Exactly,Value)
	end 
	table.insert(TTPushTrigArr,Y)
	table.insert(TTPushCondArr,TTMemory2)
	table.insert(TTFCodeArr,FCode)
	table.insert(TTModeArr,Mode)

	FlagAlloc = FlagAlloc + 1
	local TTMemory = CDeaths("X",Exactly,1,FCode)
	return TTMemory
end

function TTMemoryX(Offset,Type,Value,Mask)
	local Mode
	if Type == ">" or Type == Above then
		Mode = 1
	elseif Type == "<" or Type == Below then
		Mode = 2
	elseif Type == "!=" or Type == NotSame then
		Mode = 0
	else
		TTMemoryX_TypeError()
	end
	local TypeNum = 0
	local FIndex = FlagAlloc
	local FCode = FlagIndex(FIndex)
	local Y = {}
	local Z = 0
	if type(Mask) == "table" then
		if Mask[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Mask})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Mask = TempData
		end

		if Mask[4] == "V" then
			if Mask[5] == nil then
				Mask[5] = 0
			end
			local X = {CallLabelAlways(Mask[1],Mask[2],Mask[3]),
					SetCtrig1X(Mask[1],Mask[2],0x148,Mask[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Mask[1],Mask[2],0x160,Mask[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Mask[1],Mask[2],0x158,Mask[3],SetTo,"X","X",0x1C,1,0),
					SetCtrig1X("X","X",0x1C,0,SetTo,Mask[5])}
			Z = Z + 1
			table.insert(Y,X)
			Mask = 0
		end
	end

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x24,1,0),
					SetCtrig1X("X","X",0x24,0,SetTo,Value[5])}
			Z = Z + 1
			table.insert(Y,X)
			Value = 0
		end
	end

	if type(Offset) == "table" then
		if Offset[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Offset})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Offset = TempData
		end

		if Offset[4] == "V" then
			if Offset[5] == nil then
				Offset[5] = 0
			end
			local X = {CallLabelAlways(Offset[1],Offset[2],Offset[3]),
					SetCtrig1X(Offset[1],Offset[2],0x148,Offset[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Offset[1],Offset[2],0x160,Offset[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Offset[1],Offset[2],0x158,Offset[3],SetTo,"X","X",0x20,1,0),
					SetCtrig1X("X","X",0x20,0,SetTo,Offset[5])}
			Z = Z + 1
			table.insert(Y,X)
			Offset = 0x58A364
		else
			TypeNum = 1
		end
	end

	local TTMemory2X
	if TypeNum == 0 then
		TTMemory2X = MemoryX(Offset,Exactly,Value,Mask)
	elseif TypeNum == 1 then
		TTMemory2X = CtrigX(Offset[1],Offset[2],Offset[3],Offset[4],Exactly,Value,Mask)
	end 
	table.insert(TTPushTrigArr,Y)
	table.insert(TTPushCondArr,TTMemory2X)
	table.insert(TTFCodeArr,FCode)
	table.insert(TTModeArr,Mode)

	FlagAlloc = FlagAlloc + 1
	local TTMemoryX = CDeaths("X",Exactly,1,FCode)
	return TTMemoryX
end

function TTCommand(Player,Type,Value,UnitId)
	local Mode
	if Type == ">" or Type == Above then
		Mode = 1
	elseif Type == "<" or Type == Below then
		Mode = 2
	elseif Type == "!=" or Type == NotSame then
		Mode = 0
	else
		TTCommandX_TypeError()
	end

	local FIndex = FlagAlloc
	local FCode = FlagIndex(FIndex)
	local Y = {}
	local Z = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x28,1,0),
					SetCtrig1X("X","X",0x28,0,SetTo,UnitId[5],0xFFFF)}
			Z = Z + 1
			table.insert(Y,X)
			UnitId = 0
		end
	end

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x24,1,0),
					SetCtrig1X("X","X",0x24,0,SetTo,Value[5])}
			Z = Z + 1
			table.insert(Y,X)
			Value = 0
		end
	end

	if type(Player) == "table" and Player ~= CurrentPlayer then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x20,1,0),
					SetCtrig1X("X","X",0x20,0,SetTo,Player[5])}
			Z = Z + 1
			table.insert(Y,X)
			Player = 0
		end
	end

	table.insert(TTPushTrigArr,Y)
	table.insert(TTPushCondArr,Command(Player,Exactly,Value,UnitId))
	table.insert(TTFCodeArr,FCode)
	table.insert(TTModeArr,Mode)

	FlagAlloc = FlagAlloc + 1
	local TTCommandX = CDeaths("X",Exactly,1,FCode)
	return TTCommandX
end

function TTBring(Player,Type,Value,UnitId,Location)
	local Mode
	if Type == ">" or Type == Above then
		Mode = 1
	elseif Type == "<" or Type == Below then
		Mode = 2
	elseif Type == "!=" or Type == NotSame then
		Mode = 0
	else
		TTBringX_TypeError()
	end

	local FIndex = FlagAlloc
	local FCode = FlagIndex(FIndex)
	local Y = {}
	local Z = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x28,1,0),
					SetCtrig1X("X","X",0x28,0,SetTo,UnitId[5],0xFFFF)}
			Z = Z + 1
			table.insert(Y,X)
			UnitId = 0
		end
	end

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x24,1,0),
					SetCtrig1X("X","X",0x24,0,SetTo,Value[5])}
			Z = Z + 1
			table.insert(Y,X)
			Value = 0
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x20,1,0),
					SetCtrig1X("X","X",0x20,0,SetTo,Player[5])}
			Z = Z + 1
			table.insert(Y,X)
			Player = 0
		end
	end

	table.insert(TTPushTrigArr,Y)
	table.insert(TTPushCondArr,Bring(Player,Exactly,Value,UnitId,Location))
	table.insert(TTFCodeArr,FCode)
	table.insert(TTModeArr,Mode)

	FlagAlloc = FlagAlloc + 1
	local TTBringX = CDeaths("X",Exactly,1,FCode)
	return TTBringX
end

function TTAccumulate(Player,Type,Value,ResourceType)
	local Mode
	if Type == ">" or Type == Above then
		Mode = 1
	elseif Type == "<" or Type == Below then
		Mode = 2
	elseif Type == "!=" or Type == NotSame then
		Mode = 0
	else
		TTAccumulateX_TypeError()
	end

	local FIndex = FlagAlloc
	local FCode = FlagIndex(FIndex)
	local Y = {}
	local Z = 0

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x24,1,0),
					SetCtrig1X("X","X",0x24,0,SetTo,Value[5])}
			Z = Z + 1
			table.insert(Y,X)
			Value = 0
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x20,1,0),
					SetCtrig1X("X","X",0x20,0,SetTo,Player[5])}
			Z = Z + 1
			table.insert(Y,X)
			Player = 0
		end
	end

	table.insert(TTPushTrigArr,Y)
	table.insert(TTPushCondArr,Accumulate(Player,Exactly,Value,ResourceType))
	table.insert(TTFCodeArr,FCode)
	table.insert(TTModeArr,Mode)

	FlagAlloc = FlagAlloc + 1
	local TTAccumulateX = CDeaths("X",Exactly,1,FCode)
	return TTAccumulateX
end

function TTCountdownTimer(Type,Value)
	local Mode
	if Type == ">" or Type == Above then
		Mode = 1
	elseif Type == "<" or Type == Below then
		Mode = 2
	elseif Type == "!=" or Type == NotSame then
		Mode = 0
	else
		TTCountdownTimerX_TypeError()
	end

	local FIndex = FlagAlloc
	local FCode = FlagIndex(FIndex)
	local Y = {}
	local Z = 0

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x24,1,0),
					SetCtrig1X("X","X",0x24,0,SetTo,Value[5])}
			Z = Z + 1
			table.insert(Y,X)
			Value = 0
		end
	end

	table.insert(TTPushTrigArr,Y)
	table.insert(TTPushCondArr,CountdownTimer(Exactly,Value))
	table.insert(TTFCodeArr,FCode)
	table.insert(TTModeArr,Mode)

	FlagAlloc = FlagAlloc + 1
	local TTCountdownTimerX = CDeaths("X",Exactly,1,FCode)
	return TTCountdownTimerX
end

function TTElapsedTime(Type,Value)
	local Mode
	if Type == ">" or Type == Above then
		Mode = 1
	elseif Type == "<" or Type == Below then
		Mode = 2
	elseif Type == "!=" or Type == NotSame then
		Mode = 0
	else
		TTElapsedTimeX_TypeError()
	end

	local FIndex = FlagAlloc
	local FCode = FlagIndex(FIndex)
	local Y = {}
	local Z = 0

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x24,1,0),
					SetCtrig1X("X","X",0x24,0,SetTo,Value[5])}
			Z = Z + 1
			table.insert(Y,X)
			Value = 0
		end
	end

	table.insert(TTPushTrigArr,Y)
	table.insert(TTPushCondArr,ElapsedTime(Exactly,Value))
	table.insert(TTFCodeArr,FCode)
	table.insert(TTModeArr,Mode)

	FlagAlloc = FlagAlloc + 1
	local TTElapsedTimeX = CDeaths("X",Exactly,1,FCode)
	return TTElapsedTimeX
end

function TTKills(Player,Type,Value,UnitId)
	local Mode
	if Type == ">" or Type == Above then
		Mode = 1
	elseif Type == "<" or Type == Below then
		Mode = 2
	elseif Type == "!=" or Type == NotSame then
		Mode = 0
	else
		TTKillsX_TypeError()
	end

	local FIndex = FlagAlloc
	local FCode = FlagIndex(FIndex)
	local Y = {}
	local Z = 0

	if type(UnitId) == "table" then
		if UnitId[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,UnitId})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			UnitId = TempData
		end

		if UnitId[4] == "V" then
			if UnitId[5] == nil then
				UnitId[5] = 0
			end
			local X = {CallLabelAlways(UnitId[1],UnitId[2],UnitId[3]),
					SetCtrig1X(UnitId[1],UnitId[2],0x148,UnitId[3],SetTo,0xFFFF),
					SetCtrig1X(UnitId[1],UnitId[2],0x160,UnitId[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(UnitId[1],UnitId[2],0x158,UnitId[3],SetTo,"X","X",0x28,1,0),
					SetCtrig1X("X","X",0x28,0,SetTo,UnitId[5],0xFFFF)}
			Z = Z + 1
			table.insert(Y,X)
			UnitId = 0
		end
	end

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x24,1,0),
					SetCtrig1X("X","X",0x24,0,SetTo,Value[5])}
			Z = Z + 1
			table.insert(Y,X)
			Value = 0
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x20,1,0),
					SetCtrig1X("X","X",0x20,0,SetTo,Player[5])}
			Z = Z + 1
			table.insert(Y,X)
			Player = 0
		end
	end

	table.insert(TTPushTrigArr,Y)
	table.insert(TTPushCondArr,Kills(Player,Exactly,Value,UnitId))
	table.insert(TTFCodeArr,FCode)
	table.insert(TTModeArr,Mode)

	FlagAlloc = FlagAlloc + 1
	local TTKillsX = CDeaths("X",Exactly,1,FCode)
	return TTKillsX
end

function TTScore(Player,ScoreType,Type,Value)
	local Mode
	if Type == ">" or Type == Above then
		Mode = 1
	elseif Type == "<" or Type == Below then
		Mode = 2
	elseif Type == "!=" or Type == NotSame then
		Mode = 0
	else
		TTScoreX_TypeError()
	end

	local FIndex = FlagAlloc
	local FCode = FlagIndex(FIndex)
	local Y = {}
	local Z = 0

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x24,1,0),
					SetCtrig1X("X","X",0x24,0,SetTo,Value[5])}
			Z = Z + 1
			table.insert(Y,X)
			Value = 0
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x20,1,0),
					SetCtrig1X("X","X",0x20,0,SetTo,Player[5])}
			Z = Z + 1
			table.insert(Y,X)
			Player = 0
		end
	end

	table.insert(TTPushTrigArr,Y)
	table.insert(TTPushCondArr,Score(Player,ScoreType,Exactly,Value))
	table.insert(TTFCodeArr,FCode)
	table.insert(TTModeArr,Mode)

	FlagAlloc = FlagAlloc + 1
	local TTScoreX = CDeaths("X",Exactly,1,FCode)
	return TTScoreX
end

function TTOpponents(Player,Type,Value)
	local Mode
	if Type == ">" or Type == Above then
		Mode = 1
	elseif Type == "<" or Type == Below then
		Mode = 2
	elseif Type == "!=" or Type == NotSame then
		Mode = 0
	else
		TTOpponentsX_TypeError()
	end

	local FIndex = FlagAlloc
	local FCode = FlagIndex(FIndex)
	local Y = {}
	local Z = 0

	if type(Value) == "table" then
		if Value[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Value})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Value = TempData
		end

		if Value[4] == "V" then
			if Value[5] == nil then
				Value[5] = 0
			end
			local X = {CallLabelAlways(Value[1],Value[2],Value[3]),
					SetCtrig1X(Value[1],Value[2],0x148,Value[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Value[1],Value[2],0x160,Value[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Value[1],Value[2],0x158,Value[3],SetTo,"X","X",0x24,1,0),
					SetCtrig1X("X","X",0x24,0,SetTo,Value[5])}
			Z = Z + 1
			table.insert(Y,X)
			Value = 0
		end
	end

	if type(Player) == "table" and Player[1] ~= nil then
		if Player[4] == "VA" then
			local Temp = VarXAlloc
			local TempData = {"X",Temp,0,"V"}

			table.insert(STPushTrigArr,{"@MovX",TempData,Player})

			VarXAlloc = VarXAlloc + 1
			if VarXAlloc > MAXVAlloc then
				MAXVAlloc = VarXAlloc
			end
			Player = TempData
		end

		if Player[4] == "V" then
			if Player[5] == nil then
				Player[5] = 0
			end
			local X = {CallLabelAlways(Player[1],Player[2],Player[3]),
					SetCtrig1X(Player[1],Player[2],0x148,Player[3],SetTo,0xFFFFFFFF),
					SetCtrig1X(Player[1],Player[2],0x160,Player[3],SetTo,Add*16777216,0xFF000000),
					SetCtrigX(Player[1],Player[2],0x158,Player[3],SetTo,"X","X",0x20,1,0),
					SetCtrig1X("X","X",0x20,0,SetTo,Player[5])}
			Z = Z + 1
			table.insert(Y,X)
			Player = 0
		end
	end

	table.insert(TTPushTrigArr,Y)
	table.insert(TTPushCondArr,Opponents(Player,Exactly,Value))
	table.insert(TTFCodeArr,FCode)
	table.insert(TTModeArr,Mode)

	FlagAlloc = FlagAlloc + 1
	local TTOpponentsX = CDeaths("X",Exactly,1,FCode)
	return TTOpponentsX
end

-- 매크로 함수형 최종 연산 함수(C) ------------------------------------------------------

function CRead(PlayerID,Dest,Source,Deviation,Mask,EPDRead,Clear) -- f_maskread
	STPopTrigArr(PlayerID)
	if EPDRead == "X" then
		EPDRead = nil
	end
	if Mask == "X" then
		Mask = nil
	end
	if Deviation == "X" then
		Deviation = nil
	end

	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	if Deviation == nil then
		Deviation = 0
	end

	local Mask2 = Mask
	if Clear == 1 then
		Mask2 = 0xFFFFFFFF
	end

	Recover = 0
	CRead1 = {}
	CRead2 = {}
	CRead3 = {}

	if type(Source) == "table" and Source[4] == "VA" then
		local TempRet = {"X",CRet[7],0,"V"}
		MovX(PlayerID,TempRet,Source)
		Source = TempRet
	end
	if type(Source) == "table" and Source[4] == "A" then
		local TempRet = {"X",CRet[7],0,"V"}
		MovZ(PlayerID,TempRet,Source)
		Source = TempRet
	end
	local PDest
	if type(Dest) == "table" and Dest[4] == "VA" then
		PDest = Dest
		Dest = {"X",CRet[8],0,"V"}
	end
	if type(Dest) == "table" and Dest[4] == "A" then
		PDest = Dest
		Dest = {"X",CRet[8],0,"V"}
	end

	if EPDRead == nil then
		if type(Dest) == "number" then 
			if type(Source) == "number" then -- Read 0x58A364, 0x58A368 : 0x58A364 << 0x58A368 + D
					CRead1 = {SetMemoryX(Dest,SetTo,Deviation,Mask)}
			elseif Source == "Cp" then -- Read 0x58A364, Cp : 0x58A364 << Cp + D
					CRead1 = {SetMemoryX(Dest,SetTo,Deviation,Mask)}
			elseif Source[4] == "V" then -- Read 0x58A364, X : 0x58A364 << EPD(X) + D (CPRead)
					CRead1 = {SetMemoryX(Dest,SetTo,Deviation,Mask)}
					Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetMemory(0x6509B0,SetTo,0);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,EPD(0x6509B0));
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
					Recover = 1
			else -- Read 0x58A364, Mem : 0x58A364 << Mem + D
					CRead1 = {SetMemoryX(Dest,SetTo,Deviation,Mask)}
			end
		elseif Dest == "Cp" then
			if type(Source) == "number" then -- Read Cp, 0x58A368 : Cp << 0x58A368 + D
					CRead1 = {SetDeathsX(CurrentPlayer,SetTo,Deviation,0,Mask)}
			elseif Source == "Cp" then -- Read Cp, Cp : Cp << Cp + D / Cp중복
				CRead_InputData_Error()
			elseif Source[4] == "V" then -- Read Cp, X : Cp << EPD(X) + D (CPRead) / Cp중복
				CRead_InputData_Error()
			else -- Read Cp, Mem : Cp << Mem + D
					CRead1 = {SetDeathsX(CurrentPlayer,SetTo,Deviation,0,Mask)}
			end
		elseif Dest[4] == "V" then
			if type(Source) == "number" then -- Read X, 0x58A364 : X << 0x58A364 + D
					CRead1 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Deviation,Mask2)}
			elseif Source == "Cp" then  -- Read X, Cp : X << Cp + D
					CRead1 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Deviation,Mask2)}
			elseif Source[4] == "V" then -- Read X, Y : X << EPD(Y) + D (CPRead)
					CRead1 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Deviation,Mask2)}
					Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetMemory(0x6509B0,SetTo,0);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,EPD(0x6509B0));
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
					Recover = 1
			else -- Read X, Mem : X << Mem + D
					CRead1 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Deviation,Mask2)}
			end
		else 
			if type(Source) == "number" then -- Read Mem, 0x58A364 : Mem << 0x58A364 + D
					CRead1 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],SetTo,Deviation,Mask)}
			elseif Source == "Cp" then -- Read Mem, Cp : Mem << Cp + D
					CRead1 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],SetTo,Deviation,Mask)}
			elseif Source[4] == "V" then -- Read Mem, X : Mem << EPD(X) + D (CPRead)
					CRead1 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],SetTo,Deviation,Mask)}
					Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetMemory(0x6509B0,SetTo,0);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,EPD(0x6509B0));
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
					Recover = 1
			else -- Read Mem1, Mem2 : Mem1 << Mem2 + D
					CRead1 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],SetTo,Deviation,Mask)}
			end
		end

		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				CRead1,
			},
			flag = {Preserved}
		}
		for i = 0, 31 do
			local CBit = bit32.band(Mask, 2^i)
			if type(Dest) == "number" then 
				if type(Source) == "number" then -- Read 0x58A364, 0x58A368 : 0x58A364 << 0x58A368 + D
						CRead2 = {MemoryX(Source,Exactly,CBit,CBit)}
						CRead3 = {SetMemory(Dest,Add,CBit)}
				elseif Source == "Cp" then -- Read 0x58A364, Cp : 0x58A364 << Cp + D
						CRead2 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
						CRead3 = {SetMemory(Dest,Add,CBit)}
				elseif Source[4] == "V" then -- Read 0x58A364, X : 0x58A364 << EPD(X) + D (CPRead)
						CRead2 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
						CRead3 = {SetMemory(Dest,Add,CBit)}
						Recover = 1
				else -- Read 0x58A364, Mem : 0x58A364 << Mem + D
						CRead2 = {CtrigX(Source[1],Source[2],Source[3],Source[4],Exactly,CBit,CBit)}
						CRead3 = {SetMemory(Dest,Add,CBit)}
				end
			elseif Dest == "Cp" then
				if type(Source) == "number" then -- Read Cp, 0x58A368 : Cp << 0x58A368 + D
						CRead2 = {MemoryX(Source,Exactly,CBit,CBit)}
						CRead3 = {SetDeaths(CurrentPlayer,Add,CBit,0)}
				elseif Source == "Cp" then -- Read Cp, Cp : Cp << Cp + D / Cp중복
					CRead_InputData_Error()
				elseif Source[4] == "V" then -- Read Cp, X : Cp << EPD(X) + D (CPRead) / Cp중복
					CRead_InputData_Error()
				else -- Read Cp, Mem : Cp << Mem + D
						CRead2 = {CtrigX(Source[1],Source[2],Source[3],Source[4],Exactly,CBit,CBit)}
						CRead3 = {SetDeaths(CurrentPlayer,Add,CBit,0)}
				end
			elseif Dest[4] == "V" then
				if type(Source) == "number" then -- Read X, 0x58A364 : X << 0x58A364 + D
						CRead2 = {MemoryX(Source,Exactly,CBit,CBit)}
						CRead3 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,CBit)}
				elseif Source == "Cp" then  -- Read X, Cp : X << Cp + D
						CRead2 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
						CRead3 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,CBit)}
				elseif Source[4] == "V" then -- Read X, Y : X << EPD(Y) + D (CPRead)
						CRead2 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
						CRead3 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,CBit)}
						Recover = 1
				else -- Read X, Mem : X << Mem + D
						CRead2 = {CtrigX(Source[1],Source[2],Source[3],Source[4],Exactly,CBit,CBit)}
						CRead3 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,CBit)}
				end
			else 
				if type(Source) == "number" then -- Read Mem, 0x58A364 : Mem << 0x58A364 + D
						CRead2 = {MemoryX(Source,Exactly,CBit,CBit)}
						CRead3 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],Add,CBit)}
				elseif Source == "Cp" then -- Read Mem, Cp : Mem << Cp + D
						CRead2 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
						CRead3 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],Add,CBit)}
				elseif Source[4] == "V" then -- Read Mem, X : Mem << EPD(X) + D (CPRead)
						CRead2 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
						CRead3 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],Add,CBit)}
						Recover = 1
				else -- Read Mem1, Mem2 : Mem1 << Mem2 + D
						CRead2 = {CtrigX(Source[1],Source[2],Source[3],Source[4],Exactly,CBit,CBit)}
						CRead3 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],Add,CBit)}
				end
			end
			if CBit == 2^i then
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					   	CRead2,
					},
					actions = {
						CRead3,
					},
					flag = {Preserved}
				}
			end
		end
	else
		if type(Dest) == "number" then 
			if type(Source) == "number" then -- Read 0x58A364, 0x58A368 : 0x58A364 << 0x58A368 + D
					CRead1 = {SetMemory(Dest,SetTo,-1452249)}
			elseif Source == "Cp" then -- Read 0x58A364, Cp : 0x58A364 << Cp + D
					CRead1 = {SetMemory(Dest,SetTo,-1452249)}
			elseif Source[4] == "V" then -- Read 0x58A364, X : 0x58A364 << EPD(X) + D (CPRead)
					CRead1 = {SetMemoryX(Dest,SetTo,-1452249)}
					Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetMemory(0x6509B0,SetTo,0);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,EPD(0x6509B0));
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
					Recover = 1
			else -- Read 0x58A364, Mem : 0x58A364 << Mem + D
					CRead1 = {SetMemory(Dest,SetTo,-1452249)}
			end
		elseif Dest == "Cp" then
			if type(Source) == "number" then -- Read Cp, 0x58A368 : Cp << 0x58A368 + D
					CRead1 = {SetDeaths(CurrentPlayer,SetTo,-1452249,0)}
			elseif Source == "Cp" then -- Read Cp, Cp : Cp << Cp + D / Cp중복
				CRead_InputData_Error()
			elseif Source[4] == "V" then -- Read Cp, X : Cp << EPD(X) + D (CPRead) / Cp중복
				CRead_InputData_Error()
			else -- Read Cp, Mem : Cp << Mem + D
					CRead1 = {SetDeaths(CurrentPlayer,SetTo,-1452249,0)}
			end
		elseif Dest[4] == "V" then
			if type(Source) == "number" then -- Read X, 0x58A364 : X << 0x58A364 + D
					CRead1 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,-1452249)}
			elseif Source == "Cp" then  -- Read X, Cp : X << Cp + D
					CRead1 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,-1452249)}
			elseif Source[4] == "V" then -- Read X, Y : X << EPD(Y) + D (CPRead)
					CRead1 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,-1452249)}
					Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetMemory(0x6509B0,SetTo,0);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,EPD(0x6509B0));
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
					Recover = 1
			else -- Read X, Mem : X << Mem + D
					CRead1 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,-1452249)}
			end
		else 
			if type(Source) == "number" then -- Read Mem, 0x58A364 : Mem << 0x58A364 + D
					CRead1 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],SetTo,-1452249)}
			elseif Source == "Cp" then -- Read Mem, Cp : Mem << Cp + D
					CRead1 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],SetTo,-1452249)}
			elseif Source[4] == "V" then -- Read Mem, X : Mem << EPD(X) + D (CPRead)
					CRead1 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],SetTo,-1452249)}
					Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetMemory(0x6509B0,SetTo,0);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,EPD(0x6509B0));
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
					Recover = 1
			else -- Read Mem1, Mem2 : Mem1 << Mem2 + D
					CRead1 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],SetTo,-1452249)}
			end
		end
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				CRead1,
			},
			flag = {Preserved}
		}
		for i = 2, 31 do
			local CBit = bit32.band(Mask, 2^i)
			if type(Dest) == "number" then 
				if type(Source) == "number" then -- Read 0x58A364, 0x58A368 : 0x58A364 << 0x58A368 + D
						CRead2 = {MemoryX(Source,Exactly,CBit,CBit)}
						CRead3 = {SetMemory(Dest,Add,CBit/4)}
				elseif Source == "Cp" then -- Read 0x58A364, Cp : 0x58A364 << Cp + D
						CRead2 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
						CRead3 = {SetMemory(Dest,Add,CBit/4)}
				elseif Source[4] == "V" then -- Read 0x58A364, X : 0x58A364 << EPD(X) + D (CPRead)
						CRead2 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
						CRead3 = {SetMemory(Dest,Add,CBit/4)}
						Recover = 1
				else -- Read 0x58A364, Mem : 0x58A364 << Mem + D
						CRead2 = {CtrigX(Source[1],Source[2],Source[3],Source[4],Exactly,CBit,CBit)}
						CRead3 = {SetMemory(Dest,Add,CBit/4)}
				end
			elseif Dest == "Cp" then
				if type(Source) == "number" then -- Read Cp, 0x58A368 : Cp << 0x58A368 + D
						CRead2 = {MemoryX(Source,Exactly,CBit,CBit)}
						CRead3 = {SetDeaths(CurrentPlayer,Add,CBit/4,0)}
				elseif Source == "Cp" then -- Read Cp, Cp : Cp << Cp + D / Cp중복
					CRead_InputData_Error()
				elseif Source[4] == "V" then -- Read Cp, X : Cp << EPD(X) + D (CPRead) / Cp중복
					CRead_InputData_Error()
				else -- Read Cp, Mem : Cp << Mem + D
						CRead2 = {CtrigX(Source[1],Source[2],Source[3],Source[4],Exactly,CBit,CBit)}
						CRead3 = {SetDeaths(CurrentPlayer,Add,CBit/4,0)}
				end
			elseif Dest[4] == "V" then
				if type(Source) == "number" then -- Read X, 0x58A364 : X << 0x58A364 + D
						CRead2 = {MemoryX(Source,Exactly,CBit,CBit)}
						CRead3 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,CBit/4)}
				elseif Source == "Cp" then  -- Read X, Cp : X << Cp + D
						CRead2 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
						CRead3 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,CBit/4)}
				elseif Source[4] == "V" then -- Read X, Y : X << EPD(Y) + D (CPRead)
						CRead2 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
						CRead3 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,CBit/4)}
						Recover = 1
				else -- Read X, Mem : X << Mem + D
						CRead2 = {CtrigX(Source[1],Source[2],Source[3],Source[4],Exactly,CBit,CBit)}
						CRead3 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,CBit/4)}
				end
			else 
				if type(Source) == "number" then -- Read Mem, 0x58A364 : Mem << 0x58A364 + D
						CRead2 = {MemoryX(Source,Exactly,CBit,CBit)}
						CRead3 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],Add,CBit/4)}
				elseif Source == "Cp" then -- Read Mem, Cp : Mem << Cp + D
						CRead2 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
						CRead3 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],Add,CBit/4)}
				elseif Source[4] == "V" then -- Read Mem, X : Mem << EPD(X) + D (CPRead)
						CRead2 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
						CRead3 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],Add,CBit/4)}
						Recover = 1
				else -- Read Mem1, Mem2 : Mem1 << Mem2 + D
						CRead2 = {CtrigX(Source[1],Source[2],Source[3],Source[4],Exactly,CBit,CBit)}
						CRead3 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],Add,CBit/4)}
				end
			end
			if CBit == 2^i then
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					   	CRead2,
					},
					actions = {
						CRead3,
					},
					flag = {Preserved}
				}
			end
		end
	end

	if Recover == 1 then
		RecoverCp(PlayerID)
	end

	if PDest ~= nil then
		MovX(PlayerID,PDest,Dest)
	end
end

function CReadX(PlayerID,Dest,Source,Deviation,Mask,Multiplier,Clear) -- f_ConvertRead
	STPopTrigArr(PlayerID)
	if Mask == "X" then
		Mask = nil
	end
	if Deviation == "X" then
		Deviation = nil
	end
	if Multiplier == "X" then
		Multiplier = nil
	end

	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	if Deviation == nil then
		Deviation = 0
	end
	if Multiplier == nil then
		Multiplier = 1
	end

	local Mask2 = Mask
	if Clear == 1 then
		Mask2 = 0xFFFFFFFF
	end

	Recover = 0
	CRead1 = {}
	CRead2 = {}
	CRead3 = {}

	if type(Source) == "table" and Source[4] == "VA" then
		local TempRet = {"X",CRet[7],0,"V"}
		MovX(PlayerID,TempRet,Source)
		Source = TempRet
	end
	if type(Source) == "table" and Source[4] == "A" then
		local TempRet = {"X",CRet[7],0,"V"}
		MovZ(PlayerID,TempRet,Source)
		Source = TempRet
	end
	local PDest
	if type(Dest) == "table" and Dest[4] == "VA" then
		PDest = Dest
		Dest = {"X",CRet[8],0,"V"}
	end
	if type(Dest) == "table" and Dest[4] == "A" then
		PDest = Dest
		Dest = {"X",CRet[8],0,"V"}
	end

	if type(Dest) == "number" then 
		if type(Source) == "number" then -- Read 0x58A364, 0x58A368 : 0x58A364 << 0x58A368 + D
				CRead1 = {SetMemoryX(Dest,SetTo,Deviation,Mask)}
		elseif Source == "Cp" then -- Read 0x58A364, Cp : 0x58A364 << Cp + D
				CRead1 = {SetMemoryX(Dest,SetTo,Deviation,Mask)}
		elseif Source[4] == "V" then -- Read 0x58A364, X : 0x58A364 << EPD(X) + D (CPRead)
				CRead1 = {SetMemoryX(Dest,SetTo,Deviation,Mask)}
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetMemory(0x6509B0,SetTo,0);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,EPD(0x6509B0));
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
				Recover = 1
		else -- Read 0x58A364, Mem : 0x58A364 << Mem + D
				CRead1 = {SetMemoryX(Dest,SetTo,Deviation,Mask)}
		end
	elseif Dest == "Cp" then
		if type(Source) == "number" then -- Read Cp, 0x58A368 : Cp << 0x58A368 + D
				CRead1 = {SetDeathsX(CurrentPlayer,SetTo,Deviation,0,Mask)}
		elseif Source == "Cp" then -- Read Cp, Cp : Cp << Cp + D / Cp중복
			CRead_InputData_Error()
		elseif Source[4] == "V" then -- Read Cp, X : Cp << EPD(X) + D (CPRead) / Cp중복
			CRead_InputData_Error()
		else -- Read Cp, Mem : Cp << Mem + D
				CRead1 = {SetDeathsX(CurrentPlayer,SetTo,Deviation,0,Mask)}
		end
	elseif Dest[4] == "V" then
		if type(Source) == "number" then -- Read X, 0x58A364 : X << 0x58A364 + D
				CRead1 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Deviation,Mask2)}
		elseif Source == "Cp" then  -- Read X, Cp : X << Cp + D
				CRead1 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Deviation,Mask2)}
		elseif Source[4] == "V" then -- Read X, Y : X << EPD(Y) + D (CPRead)
				CRead1 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Deviation,Mask2)}
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetMemory(0x6509B0,SetTo,0);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,EPD(0x6509B0));
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
				Recover = 1
		else -- Read X, Mem : X << Mem + D
				CRead1 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Deviation,Mask2)}
		end
	else 
		if type(Source) == "number" then -- Read Mem, 0x58A364 : Mem << 0x58A364 + D
				CRead1 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],SetTo,Deviation,Mask)}
		elseif Source == "Cp" then -- Read Mem, Cp : Mem << Cp + D
				CRead1 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],SetTo,Deviation,Mask)}
		elseif Source[4] == "V" then -- Read Mem, X : Mem << EPD(X) + D (CPRead)
				CRead1 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],SetTo,Deviation,Mask)}
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetMemory(0x6509B0,SetTo,0);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,EPD(0x6509B0));
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
				Recover = 1
		else -- Read Mem1, Mem2 : Mem1 << Mem2 + D
				CRead1 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],SetTo,Deviation,Mask)}
		end
	end

	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(0);
		},
		actions = {
			CRead1,
		},
		flag = {Preserved}
	}
	local Check = 0
	for i = 0, 31 do
		local CBit = bit32.band(Mask, 2^i)
		if type(Dest) == "number" then 
			if type(Source) == "number" then -- Read 0x58A364, 0x58A368 : 0x58A364 << 0x58A368 + D
					CRead2 = {MemoryX(Source,Exactly,CBit,CBit)}
					CRead3 = {SetMemory(Dest,Add,CBit*Multiplier)}
			elseif Source == "Cp" then -- Read 0x58A364, Cp : 0x58A364 << Cp + D
					CRead2 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
					CRead3 = {SetMemory(Dest,Add,CBit*Multiplier)}
			elseif Source[4] == "V" then -- Read 0x58A364, X : 0x58A364 << EPD(X) + D (CPRead)
					CRead2 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
					CRead3 = {SetMemory(Dest,Add,CBit*Multiplier)}
					Recover = 1
			else -- Read 0x58A364, Mem : 0x58A364 << Mem + D
					CRead2 = {CtrigX(Source[1],Source[2],Source[3],Source[4],Exactly,CBit,CBit)}
					CRead3 = {SetMemory(Dest,Add,CBit*Multiplier)}
			end
		elseif Dest == "Cp" then
			if type(Source) == "number" then -- Read Cp, 0x58A368 : Cp << 0x58A368 + D
					CRead2 = {MemoryX(Source,Exactly,CBit,CBit)}
					CRead3 = {SetDeaths(CurrentPlayer,Add,CBit*Multiplier,0)}
			elseif Source == "Cp" then -- Read Cp, Cp : Cp << Cp + D / Cp중복
				CRead_InputData_Error()
			elseif Source[4] == "V" then -- Read Cp, X : Cp << EPD(X) + D (CPRead) / Cp중복
				CRead_InputData_Error()
			else -- Read Cp, Mem : Cp << Mem + D
					CRead2 = {CtrigX(Source[1],Source[2],Source[3],Source[4],Exactly,CBit,CBit)}
					CRead3 = {SetDeaths(CurrentPlayer,Add,CBit*Multiplier,0)}
			end
		elseif Dest[4] == "V" then
			if type(Source) == "number" then -- Read X, 0x58A364 : X << 0x58A364 + D
					CRead2 = {MemoryX(Source,Exactly,CBit,CBit)}
					CRead3 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,CBit*Multiplier)}
			elseif Source == "Cp" then  -- Read X, Cp : X << Cp + D
					CRead2 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
					CRead3 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,CBit*Multiplier)}
			elseif Source[4] == "V" then -- Read X, Y : X << EPD(Y) + D (CPRead)
					CRead2 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
					CRead3 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,CBit*Multiplier)}
					Recover = 1
			else -- Read X, Mem : X << Mem + D
					CRead2 = {CtrigX(Source[1],Source[2],Source[3],Source[4],Exactly,CBit,CBit)}
					CRead3 = {SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,CBit*Multiplier)}
			end
		else 
			if type(Source) == "number" then -- Read Mem, 0x58A364 : Mem << 0x58A364 + D
					CRead2 = {MemoryX(Source,Exactly,CBit,CBit)}
					CRead3 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],Add,CBit*Multiplier)}
			elseif Source == "Cp" then -- Read Mem, Cp : Mem << Cp + D
					CRead2 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
					CRead3 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],Add,CBit*Multiplier)}
			elseif Source[4] == "V" then -- Read Mem, X : Mem << EPD(X) + D (CPRead)
					CRead2 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
					CRead3 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],Add,CBit*Multiplier)}
					Recover = 1
			else -- Read Mem1, Mem2 : Mem1 << Mem2 + D
					CRead2 = {CtrigX(Source[1],Source[2],Source[3],Source[4],Exactly,CBit,CBit)}
					CRead3 = {SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],Add,CBit*Multiplier)}
			end
		end
		if CBit == 2^i and CBit*Multiplier >= 1 and Check == 0 then
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				   	CRead2,
				},
				actions = {
					CRead3,
				},
				flag = {Preserved}
			}
		end
		if bit32.band(CBit*Multiplier,0xFFFFFFFF) >= 0x80000000 then
			Check = 1
		end
	end

	if Recover == 1 then
		RecoverCp(PlayerID)
	end

	if PDest ~= nil then
		MovX(PlayerID,PDest,Dest)
	end
end

function CMov(PlayerID,Dest,Source,Deviation,Mask,Clear) -- <<
	STPopTrigArr(PlayerID)
	if Mask == "X" then
		Mask = nil
	end
	if Deviation == "X" then
		Deviation = nil
	end

	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	if Deviation == nil then
		Deviation = 0
	end

	local Mask2 = Mask
	if Clear == 1 then
		Mask2 = 0xFFFFFFFF
	end

	if type(Source) == "table" and Source[4] == "VA" then
		local TempRet = {"X",CRet[7],0,"V"}
		MovX(PlayerID,TempRet,Source)
		Source = TempRet
	end
	if type(Source) == "table" and Source[4] == "A" then
		CMov_InputData_Error()
	end
	local PDest
	if type(Dest) == "table" and Dest[4] == "VA" then
		PDest = Dest
		Dest = {"X",CRet[8],0,"V"}
	end
	if type(Dest) == "table" and Dest[4] == "A" then
		PDest = Dest
		Dest = {"X",CRet[8],0,"V"}
	end

	if type(Dest) == "number" then -- Mov 0x58A364, 1 : 0x58A364 << 1
		if type(Source) == "number" then
			Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetMemoryX(Dest,SetTo,Source,Mask);
					},
					flag = {Preserved}
				}
		elseif Source[4] == "V" then -- Mov 0x58A364, X : 0x58A364 << X + D
			Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetMemoryX(Dest,SetTo,Deviation,Mask);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,Mask);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Add*16777216,0xFF000000);
						SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,EPD(Dest));
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
		else
			CMov_InputData_Error()
		end
	elseif Dest == "Cp" then
		if type(Source) == "number" then -- Mov Cp, 1 : Cp << 1
			Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetDeathsX(CurrentPlayer,SetTo,Source,0,Mask);
					},
					flag = {Preserved}
				}
		elseif Source[4] == "V" then -- Mov Cp, X : Cp << X + D
			Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetDeathsX(CurrentPlayer,SetTo,Deviation,0,Mask);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,Mask);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Add*16777216,0xFF000000);
						SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,13);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
		else
			CMov_InputData_Error()
		end
	elseif Dest[4] == "V" then
		if type(Source) == "number" then -- Mov X, 1 : X << 1
			Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Source,Mask2);
					},
					flag = {Preserved}
				}
		elseif Source[4] == "V" then -- Mov X, Y : X << Y + D
			Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Deviation,Mask2);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,Mask);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Add*16777216,0xFF000000);
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
		else
			CMov_InputData_Error()
		end

	else 
		if type(Source) == "number" then -- Mov Mem 1 : Mem << 1
			Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],SetTo,Source,Mask);
					},
					flag = {Preserved}
				}
		elseif Source[4] == "V" then -- Mov Mem, X : Mem << X + D
			Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],SetTo,Deviation,Mask);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,Mask),
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Add*16777216,0xFF000000),
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],Dest[3],1,Dest[4]);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
		else
			CMov_InputData_Error()
		end

	end

	if PDest ~= nil then
		MovX(PlayerID,PDest,Dest)
	end
end

function CAdd(PlayerID,Dest,Source,Operand,Mask) -- +
	STPopTrigArr(PlayerID)
	if Mask == "X" then
		Mask = nil
	end

	if Mask == nil then
		Mask = 0xFFFFFFFF
	end

	if Operand == nil then
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CAdd_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[8],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			PDest = Dest
			Dest = {"X",CRet[8],0,"V"}
		end

		if type(Dest) == "number" then -- Add 0x58A364, 1 : 0x58A364 += 1
			if type(Source) == "number" then
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetMemory(Dest,Add,Source);
						},
						flag = {Preserved}
					}
			elseif Source[4] == "V" then -- Add 0x58A364, X : 0x58A364 += X
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Add*16777216,0xFF000000);
							SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,EPD(Dest));
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
			else
				CAdd_InputData_Error()
			end

		elseif Dest == "Cp" then
			if type(Source) == "number" then -- Add Cp, 1 : Cp += 1
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetDeaths(CurrentPlayer,Add,Source);
						},
						flag = {Preserved}
					}
			elseif Source[4] == "V" then -- Add Cp, X : Cp += X
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Add*16777216,0xFF000000);
							SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,13);
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
			else
				CAdd_InputData_Error()
			end

		elseif Dest[4] == "V" then
			if type(Source) == "number" then -- Add X, 1 : X += 1
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,Source);
						},
						flag = {Preserved}
					}
			elseif Source[4] == "V" then -- Add X, Y : X += Y
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Add*16777216,0xFF000000);
							SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
			else
				CAdd_InputData_Error()
			end

		else 
			if type(Source) == "number" then -- Add Mem, 1 : Mem += 1
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],Add,Source);
						},
						flag = {Preserved}
					}
			elseif Source[4] == "V" then -- Add Mem, X : Mem += X
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Add*16777216,0xFF000000);
							SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],Dest[3],1,Dest[4]);
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
			else
				CAdd_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	elseif Dest[4] == "V" or Dest[4] == "VA" then
		if type(Operand) == "table" and Operand[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Operand)
			Operand = TempRet
		end
		if type(Operand) == "table" and Operand[4] == "A" then
			CAdd_InputData_Error()
		end
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[8],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CAdd_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[9],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			PDest = Dest
			Dest = {"X",CRet[9],0,"V"}
		end

		if type(Source) == "number" then -- Add V, 0x58A364, 1 : V << 0x58A364 + 1 / Read필요
			if type(Operand) == "number" then
				CAdd_InputData_Error()
			elseif Operand[4] == "V" then -- Add V, 0x58A364, X : V << 0x58A364 + X / Read필요
				CAdd_InputData_Error()
			else
				CAdd_InputData_Error()
			end

		elseif Source == "Cp" then
			if type(Operand) == "number" then -- Add V, Cp, 1 : V << Cp + 1 / Read필요 
				CAdd_InputData_Error()
			elseif Operand[4] == "V" then -- Add V, Cp, X : V << Cp + X / Read필요 
				CAdd_InputData_Error()
			else
				CAdd_InputData_Error()
			end

		elseif Source[4] == "V" then
			if type(Operand) == "number" then -- Add V, X, 1 : V << X + 1
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Operand,Mask);
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,Mask);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Add*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
			elseif Operand[4] == "V" then -- Add V, X, Y : V << X + Y
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,Mask);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Operand[1],Operand[2],0x158,Operand[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X(Operand[1],Operand[2],0x148,Operand[3],SetTo,Mask);
						SetCtrig1X(Operand[1],Operand[2],0x160,Operand[3],SetTo,Add*16777216,0xFF000000);
						CallLabelAlways(Operand[1],Operand[2],Operand[3]);
					},
					flag = {Preserved}
				}
			else
				CAdd_InputData_Error()
			end

		else 
			if type(Operand) == "number" then -- Add V, Mem, 1 : V << Mem + 1 / Read필요
				CAdd_InputData_Error()
			elseif Operand[4] == "V" then -- Add V, Mem, X : V << Mem + X / Read필요
				CAdd_InputData_Error()
			else
				CAdd_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	else
		CAdd_InputData_Error()
	end
end

function CSub(PlayerID,Dest,Source,Operand,Mask) -- - (1 - 2 = 0)
	STPopTrigArr(PlayerID)
	if Mask == "X" then
		Mask = nil
	end

	if Mask == nil then
		Mask = 0xFFFFFFFF
	end

	if Operand == nil then
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CSub_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[8],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			PDest = Dest
			Dest = {"X",CRet[8],0,"V"}
		end
		if type(Dest) == "number" then -- Sub 0x58A364, 1 : 0x58A364 -= 1
			if type(Source) == "number" then
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetMemory(Dest,Subtract,Source);
						},
						flag = {Preserved}
					}
			elseif Source[4] == "V" then -- Sub 0x58A364, X : 0x58A364 -= X
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
							SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,EPD(Dest));
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
			else
				CSub_InputData_Error()
			end

		elseif Dest == "Cp" then
			if type(Source) == "number" then -- Sub Cp, 1 : Cp -= 1
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetDeaths(CurrentPlayer,Subtract,Source);
						},
						flag = {Preserved}
					}
			elseif Source[4] == "V" then -- Sub Cp, X : Cp -= X
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
							SetCtrig1X(Source[1],Source[2],0x158,Source[3],SetTo,13);
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
			else
				CSub_InputData_Error()
			end

		elseif Dest[4] == "V" then
			if type(Source) == "number" then -- Sub X, 1 : X -= 1
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Subtract,Source);
						},
						flag = {Preserved}
					}
			elseif Source[4] == "V" then -- Sub X, Y : X -= Y
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
							SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
			else
				CSub_InputData_Error()
			end

		else 
			if type(Source) == "number" then -- Sub Mem, 1 : Mem -= 1
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],Subtract,Source);
						},
						flag = {Preserved}
					}
			elseif Source[4] == "V" then -- Sub Mem, X : Mem -= X
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
							SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],Dest[3],1,Dest[4]);
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
			else
				CSub_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	elseif Dest[4] == "V" or Dest[4] == "VA" then
		if type(Operand) == "table" and Operand[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Operand)
			Operand = TempRet
		end
		if type(Operand) == "table" and Operand[4] == "A" then
			CSub_InputData_Error()
		end
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[8],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CSub_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[9],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			PDest = Dest
			Dest = {"X",CRet[9],0,"V"}
		end

		if type(Source) == "number" then -- Sub V, 0x58A364, 1 : V << 0x58A364 - 1 / Read필요
			if type(Operand) == "number" then
				CSub_InputData_Error()
			elseif Operand[4] == "V" then -- Sub V, 0x58A364, X : V << 0x58A364 - X / Read필요
				CSub_InputData_Error()
			else
				CSub_InputData_Error()
			end

		elseif Source == "Cp" then
			if type(Operand) == "number" then -- Sub V, Cp, 1 : V << Cp - 1 / Read필요 
				CSub_InputData_Error()
			elseif Operand[4] == "V" then -- Sub V, Cp, X : V << Cp - X / Read필요 
				CSub_InputData_Error()
			else
				CSub_InputData_Error()
			end

		elseif Source[4] == "V" then
			if type(Operand) == "number" then -- Sub V, X, 1 : V << X - 1
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,Mask);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Subtract,Operand,Mask);
					},
					flag = {Preserved}
				}
			elseif Operand[4] == "V" then -- Sub V, X, Y : V << X - Y
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,Mask);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Operand[1],Operand[2],0x158,Operand[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X(Operand[1],Operand[2],0x148,Operand[3],SetTo,Mask);
						SetCtrig1X(Operand[1],Operand[2],0x160,Operand[3],SetTo,Subtract*16777216,0xFF000000);
						CallLabelAlways(Operand[1],Operand[2],Operand[3]);
					},
					flag = {Preserved}
				}
			else
				CSub_InputData_Error()
			end

		else 
			if type(Operand) == "number" then -- Sub V, Mem, 1 : V << Mem - 1 / Read필요
				CSub_InputData_Error()
			elseif Operand[4] == "V" then -- Sub V, Mem, X : V << Mem - X / Read필요
				CSub_InputData_Error()
			else
				CSub_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	else
		CSub_InputData_Error()
	end
end

function CiSub(PlayerID,Dest,Source,Operand,Mask) -- - (1 - 2 = -1)
	STPopTrigArr(PlayerID)
	if Mask == "X" then
		Mask = nil
	end

	if Mask == nil then
		Mask = 0xFFFFFFFF
	end

	if Operand == nil then
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CiSub_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[8],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			PDest = Dest
			Dest = {"X",CRet[8],0,"V"}
		end
		if type(Dest) == "number" then -- iSub 0x58A364, 1 : 0x58A364 -= 1
			if type(Source) == "number" then
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetMemory(Dest,Add,0-Source);
						},
						flag = {Preserved}
					}
			elseif Source[4] == "V" then -- iSub 0x58A364, X : 0x58A364 -= X
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
							SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x15C,0,Add,1);
							SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x158,0,SetTo,EPD(Dest));
							CallLabelAlways("X",CRet[1],0);
						},
						flag = {Preserved}
					}
			else
				CiSub_InputData_Error()
			end

		elseif Dest == "Cp" then
			if type(Source) == "number" then -- iSub Cp, 1 : Cp -= 1
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetDeaths(CurrentPlayer,Add,0-Source);
						},
						flag = {Preserved}
					}
			elseif Source[4] == "V" then -- iSub Cp, X : Cp -= X
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
							SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x15C,0,Add,1);
							SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x158,0,SetTo,13);
							CallLabelAlways("X",CRet[1],0);
						},
						flag = {Preserved}
					}
			else
				CiSub_InputData_Error()
			end

		elseif Dest[4] == "V" then
			if type(Source) == "number" then -- iSub X, 1 : X -= 1
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,0-Source);
						},
						flag = {Preserved}
					}
			elseif Source[4] == "V" then -- iSub X, Y : X -= Y
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
							SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x15C,0,Add,1);
							SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
							SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							CallLabelAlways("X",CRet[1],0);
						},
						flag = {Preserved}
					}
			else
				CiSub_InputData_Error()
			end

		else 
			if type(Source) == "number" then -- iSub Mem, 1 : Mem -= 1
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],Add,0-Source);
						},
						flag = {Preserved}
					}
			elseif Source[4] == "V" then -- iSub Mem, X : Mem -= X
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
							SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x15C,0,Add,1);
							SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
							SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],Dest[3],1,Dest[4]);
							CallLabelAlways("X",CRet[1],0);
						},
						flag = {Preserved}
					}
			else
				CiSub_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	elseif Dest[4] == "V" or Dest[4] == "VA" then
		if type(Operand) == "table" and Operand[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Operand)
			Operand = TempRet
		end
		if type(Operand) == "table" and Operand[4] == "A" then
			CiSub_InputData_Error()
		end
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[8],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CiSub_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[9],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			PDest = Dest
			Dest = {"X",CRet[9],0,"V"}
		end
		if type(Source) == "number" then -- iSub V, 0x58A364, 1 : V << 0x58A364 - 1 / Read필요
			if type(Operand) == "number" then
				CiSub_InputData_Error()
			elseif Operand[4] == "V" then -- iSub V, 0x58A364, X : V << 0x58A364 - X / Read필요
				CiSub_InputData_Error()
			else
				CiSub_InputData_Error()
			end

		elseif Source == "Cp" then
			if type(Operand) == "number" then -- iSub V, Cp, 1 : V << Cp - 1 / Read필요 
				CiSub_InputData_Error()
			elseif Operand[4] == "V" then -- iSub V, Cp, X : V << Cp - X / Read필요 
				CiSub_InputData_Error()
			else
				CiSub_InputData_Error()
			end

		elseif Source[4] == "V" then
			if type(Operand) == "number" then -- iSub V, X, 1 : V << X - 1
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,Mask);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,0-Operand,Mask);
					},
					flag = {Preserved}
				}
			elseif Operand[4] == "V" then -- iSub V, X, Y : V << X - Y
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,Mask);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0xFFFFFFFF);
						SetCtrigX(Operand[1],Operand[2],0x158,Operand[3],SetTo,"X",CRet[1],0x15C,1,0);
						SetCtrig1X(Operand[1],Operand[2],0x148,Operand[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Operand[1],Operand[2],0x160,Operand[3],SetTo,Subtract*16777216,0xFF000000);
						CallLabelAlways(Operand[1],Operand[2],Operand[3]);
					},
					flag = {Preserved}
				}
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x15C,0,Add,1);
							SetCtrig1X("X",CRet[1],0x148,0,SetTo,Mask);
							SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
							SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							CallLabelAlways("X",CRet[1],0);
						},
						flag = {Preserved}
					}
			else
				CiSub_InputData_Error()
			end

		else 
			if type(Operand) == "number" then -- iSub V, Mem, 1 : V << Mem - 1 / Read필요
				CiSub_InputData_Error()
			elseif Operand[4] == "V" then -- iSub V, Mem, X : V << Mem - X / Read필요
				CiSub_InputData_Error()
			else
				CiSub_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	else
		CiSub_InputData_Error()
	end
end

function CNeg(PlayerID,Dest,Source,Mask) -- x-1
	STPopTrigArr(PlayerID)
	if Mask == "X" then
		Mask = nil
	end

	if Mask == nil then
		Mask = 0xFFFFFFFF
	end

	if Source == nil then
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[8],0,"V"}
			MovX(PlayerID,Dest,PDest)
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			CNeg_InputData_Error()
		end
		if type(Dest) == "number" then -- Neg 0x58A364 / Read필요
			CNeg_InputData_Error()
		elseif Dest == "Cp" then -- Neg Cp / Read필요
			CNeg_InputData_Error()
		elseif Dest[4] == "V" then -- Neg X : X << -X
			Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0xFFFFFFFF);
						SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,Subtract*16777216,0xFF000000);
						SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[1],0x15C,1,0);
						CallLabelAlways(Dest[1],Dest[2],Dest[3]);
					},
					flag = {Preserved}
				}
			Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,Add,1);
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
		else -- Neg Mem / Read필요
			CNeg_InputData_Error()
		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	elseif Dest[4] == "V" or Dest[4] == "VA" then
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CNeg_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[8],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			PDest = Dest
			Dest = {"X",CRet[8],0,"V"}
		end
		if type(Dest) == "number" then
			CNeg_InputData_Error()
		elseif Dest == "Cp" then
			CNeg_InputData_Error()
		elseif Dest[4] == "V" then
			if type(Source) == "number" then
				CNeg_InputData_Error()
			elseif Source[4] == "V" then -- Neg V, X : V << -X
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0xFFFFFFFF);
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x15C,0,Add,1);
							SetCtrig1X("X",CRet[1],0x148,0,SetTo,Mask);
							SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
							SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							CallLabelAlways("X",CRet[1],0);
						},
						flag = {Preserved}
					}
			else
				CNeg_InputData_Error()
			end
		else
			CNeg_InputData_Error()
		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	else
		CNeg_InputData_Error()
	end
end

function CMul(PlayerID,Dest,Source,Multiplier,Mask,BitLimit) -- *, Y만 Limit bit 제한 (메모리에 )
	STPopTrigArr(PlayerID)

	if Multiplier == "X" then
		Multiplier = nil
	end

	if Mask == "X" then
		Mask = nil
	end

	if Mask == nil then
		Mask = 0xFFFFFFFF
	end

	local  Bit = 0
	if BitLimit == nil or BitLimit == "X" then
		Bit = 31
	else
		while 2^Bit <= BitLimit and Bit <= 31 do
			Bit = Bit + 1
		end
		Bit = Bit - 1
	end

	local MulArr1 = {}
	local MulArr2 = {}
	local MulArr3 = {}
	local MulType = 0
	local MulType2 = 0
	local MulType3 = 0
	if Multiplier == nil then
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CMul_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[8],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			CMul_InputData_Error()
		end
		if type(Dest) == "number" then -- Mul 0x58A364, 1 : 0x58A364 *= 1
			if type(Source) == "number" then
				MulType2 = 1
			elseif Source[4] == "V" then -- Mul 0x58A364, X : 0x58A364 *= X / Read필요
				CMul_InputData_Error()
			else
				CMul_InputData_Error()
			end

		elseif Dest == "Cp" then
			if type(Source) == "number" then -- Mul Cp, 1 : Cp *= 1
				MulType2 = 2
			elseif Source[4] == "V" then -- Mul Cp, X : Cp *= X / Read필요
				CMul_InputData_Error()
			else
				CMul_InputData_Error()
			end

		elseif Dest[4] == "V" then
			if type(Source) == "number" then -- Mul X, 1 : X *= 1
				MulType2 = 3
			elseif Source[4] == "Cp" then -- Mul X, Cp : X *= Cp
				MulType = 1
				MulType3 = 1
			elseif Source[4] == "V" then -- Mul X, Y : X *= Y
				MulType = 1
				MulType3 = 2
			else -- Mul X, Mem : X *= Mem
				MulType = 1
				MulType3 = 3
			end

		else 
			if type(Source) == "number" then -- Mul Mem, 1 : Mem *= 1
				MulType2 = 4
			elseif Source[4] == "V" then -- Add Mem, X : Mem *= X / Read필요
				CMul_InputData_Error()
			else
				CMul_InputData_Error()
			end

		end

		if type(Source) == "number" then
			Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0);
					},
					flag = {Preserved}
				}
			local Block = 0
			for i = 0, Bit do
				local CBit = 2^i
				if MulType2 == 1 then
					MulArr1 = {MemoryX(Dest,Exactly,CBit,CBit)}
				elseif MulType2 == 2 then
					MulArr1 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
				elseif MulType2 == 3 then
					MulArr1 = {CtrigX(Dest[1],Dest[2],0x15C,Dest[3],Exactly,CBit,CBit)}
				elseif MulType2 == 4 then
					MulArr1 = {CtrigX(Dest[1],Dest[2],Dest[3],Dest[4],Exactly,CBit,CBit)}
				end
				if Block == 0 then
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
								MulArr1,
							},
							actions = {
								SetCtrig1X("X",CRet[1],0x15C,0,Add,Source*CBit);
							},
							flag = {Preserved}
						}
				end
				if  bit32.band(Source*CBit,0xFFFFFFFF) >= 0x80000000 then
					Block = 0 -- 나눗셈 : Block 필요 / 곱셈 : Block 불필요
				end
			end
			if MulType2 == 1 then
				MulArr2 = {SetCtrig1X("X",CRet[1],0x158,0,SetTo,EPD(Dest))}
			elseif MulType2 == 2 then
				MulArr2 = {SetCtrig1X("X",CRet[1],0x158,0,SetTo,13)}
			elseif MulType2 == 3 then
				MulArr2 = {SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3])}
			elseif MulType2 == 4 then
				MulArr2 = {SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],Dest[3],1,Dest[4])}
			end
			Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						MulArr2,
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
		end
		if MulType == 1 then
			if Dest == Source then
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[3],0x15C,1,0);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Source = {"X",CRet[3],0,"V"}
			end

			Trigger { 
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[1],0x15C,1,0);
						SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Dest[1],Dest[2],Dest[3]);
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
						SetCtrig1X("X",CRet[2],0x15C,0,SetTo,0);
						SetCtrigX("X",FuncAlloc,0x19C,1,SetTo,"X",FuncAlloc,0x0,0,2);
					},
					flag = {Preserved}
				}

			local ClearValue = {}
			for i = 0, Bit do
				table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x15C,(Bit+3)+i,SetTo,0))
			end

			Trigger { 
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(FuncAlloc);
					},
					actions = {
						ClearValue,
					},
					flag = {Preserved}
				}

			Trigger { -- local Var1 (1)
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[1],0x15C,1,0);
						SetCtrig1X("X",FuncAlloc,0x19C,1,Add,0x970);
						SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,2);
					},
					flag = {Preserved}
				}

			for i = 0, Bit do
				Trigger { -- (2 ~ Bit+2)
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",FuncAlloc,0x15C,1,(Bit+3)+i);
						SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,1);
					},
					flag = {Preserved}
				}
			end

			PlayerID = PlayerConvert(PlayerID)
			for k, P in pairs(PlayerID) do
				table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,0,SetTo,"X",FuncAlloc,0x0,0,2))
				for i = 1, (Bit+2) do
					table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,i,SetTo,"X",CRet[1],0x0,0,0))
				end
			end

			for i = 0, Bit do
				local CBit = 2^i

				if MulType3 == 1 then
					MulArr3 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
				elseif MulType3 == 2 then
					MulArr3 = {CtrigX(Source[1],Source[2],0x15C,Source[3],Exactly,CBit,CBit)}
				elseif MulType3 == 3 then
					MulArr3 = {CtrigX(Source[1],Source[2],Source[3],Source[4],Exactly,CBit,CBit)}
				end

				Trigger { -- (Bit+3 ~ 2*Bit+3)
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
						MulArr3,
					},
					actions = {
						SetCtrig1X("X",CRet[2],0x15C,0,Add,0);
					},
					flag = {Preserved}
				}
			end

			Trigger { -- 2*Bit + 4
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX("X",CRet[2],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X("X",CRet[2],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways("X",CRet[2],0);
					},
					flag = {Preserved}
				}

			FuncAlloc = FuncAlloc + 1
		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	elseif Dest[4] == "V" or Dest[4] == "VA" then
		if type(Multiplier) == "table" and Multiplier[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Multiplier)
			Multiplier = TempRet
		end
		if type(Multiplier) == "table" and Multiplier[4] == "A" then
			CMul_InputData_Error()
		end
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[8],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CMul_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[9],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			CMul_InputData_Error()
		end
		if type(Source) == "number" then -- Mul V, 0x58A364, 1 : V << 0x58A364 * 1 / Read필요
			if type(Multiplier) == "number" then
				CMul_InputData_Error()
			elseif Multiplier[4] == "V" then -- Mul V, 0x58A364, X : V << 0x58A364 * X / Read필요
				CMul_InputData_Error()
			else
				CMul_InputData_Error()
			end

		elseif Source == "Cp" then
			if type(Multiplier) == "number" then -- Mul V, Cp, 1 : V << Cp * 1 / Read필요 
				CMul_InputData_Error()
			elseif Multiplier[4] == "V" then -- Mul V, Cp, X : V << Cp * X / Read필요 
				CMul_InputData_Error()
			else
				CMul_InputData_Error()
			end

		elseif Source[4] == "V" then
			if type(Multiplier) == "number" then -- Mul V, X, 1 : V << X * 1
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0);
					},
					flag = {Preserved}
				}
				local Block = 0
				for i = 0, Bit do
					local CBit = 2^i
					if Block == 0 then
						Trigger {
								players = {ParsePlayer(PlayerID)},
								conditions = {
									Label(0);
									CtrigX(Source[1],Source[2],0x15C,Source[3],Exactly,CBit,CBit);
								},
								actions = {
									SetCtrig1X("X",CRet[1],0x15C,0,Add,Multiplier*CBit);
								},
								flag = {Preserved}
							}
					end
					if  bit32.band(Multiplier*CBit,0xFFFFFFFF) >= 0x80000000 then
						Block = 0 -- 나눗셈 : Block 필요 / 곱셈 : Block 불필요
					end
				end
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways("X",CRet[1],0);
						},
						flag = {Preserved}
					}

			elseif Multiplier == "Cp" then -- Mul V, X, Cp : V << X * Cp
				MulType = 1
				MulType3 = 1
			elseif Multiplier[4] == "V" then -- Mul V, X, Y : V << X * Y
				MulType = 1
				MulType3 = 2
			else -- Mul V, X, Mem : V << X * Mem
				MulType = 1
				MulType3 = 3
			end
			if MulType == 1 then
				if Source == Multiplier then
					Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[3],0x15C,1,0);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways(Source[1],Source[2],Source[3]);
						},
						flag = {Preserved}
					}
					Source = {"X",CRet[3],0,"V"}
				end

				Trigger { 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways(Source[1],Source[2],Source[3]);
							SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
							SetCtrig1X("X",CRet[2],0x15C,0,SetTo,0);
							SetCtrigX("X",FuncAlloc,0x19C,1,SetTo,"X",FuncAlloc,0x0,0,2);
						},
						flag = {Preserved}
					}

				local ClearValue = {}
				for i = 0, Bit do
					table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x15C,(Bit+3)+i,SetTo,0))
				end

				Trigger { 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(FuncAlloc);
						},
						actions = {
							ClearValue,
						},
						flag = {Preserved}
					}

				Trigger { -- local Var1 (1)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[1],0x15C,1,0);
							SetCtrig1X("X",FuncAlloc,0x19C,1,Add,0x970);
							SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,2);
						},
						flag = {Preserved}
					}

				for i = 0, Bit do
					Trigger { -- (2 ~ Bit+2)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",FuncAlloc,0x15C,1,(Bit+3)+i);
							SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,1);
						},
						flag = {Preserved}
					}
				end

				PlayerID = PlayerConvert(PlayerID)
				for k, P in pairs(PlayerID) do
					table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,0,SetTo,"X",FuncAlloc,0x0,0,2))
					for i = 1, (Bit+2) do
						table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,i,SetTo,"X",CRet[1],0x0,0,0))
					end
				end

				for i = 0, Bit do
					local CBit = 2^i

					if MulType3 == 1 then
						MulArr3 = {DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)}
					elseif MulType3 == 2 then
						MulArr3 = {CtrigX(Multiplier[1],Multiplier[2],0x15C,Multiplier[3],Exactly,CBit,CBit)}
					elseif MulType3 == 3 then
						MulArr3 = {CtrigX(Multiplier[1],Multiplier[2],Multiplier[3],Multiplier[4],Exactly,CBit,CBit)}
					end

					Trigger { -- (Bit+3 ~ 2*Bit+3)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
							MulArr3,
						},
						actions = {
							SetCtrig1X("X",CRet[2],0x15C,0,Add,0);
						},
						flag = {Preserved}
					}
				end

				Trigger { -- 2*Bit + 4
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[2],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							SetCtrig1X("X",CRet[2],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways("X",CRet[2],0);
						},
						flag = {Preserved}
					}

				FuncAlloc = FuncAlloc + 1
			end
		else 
			if type(Multiplier) == "number" then -- Mul V, Mem, 1 : V << Mem * 1 / Read필요
				CMul_InputData_Error()
			elseif Multiplier[4] == "V" then -- Mul V, Mem, X : V << Mem * X / Read필요
				CMul_InputData_Error()
			else
				CMul_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	else
		CMul_InputData_Error()
	end
end

function CDiv(PlayerID,Dest,Source,Divisor,Mask,BitLimit) -- /, X,Y 둘다 Limit bit 제한, 
	STPopTrigArr(PlayerID)

	if Divisor == "X" then
		Divisor = nil
	end

	if Mask == "X" then
		Mask = nil
	end

	if Mask == nil then
		Mask = 0xFFFFFFFF
	end

	local  Bit = 0
	if BitLimit == nil or BitLimit == "X" then
		Bit = 31
	else
		while 2^Bit <= BitLimit and Bit <= 31 do
			Bit = Bit + 1
		end
		Bit = Bit - 1
	end
	
	if Divisor == nil then
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CDiv_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[8],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			CDiv_InputData_Error()
		end

		if type(Dest) == "number" then -- Div 0x58A364, 1 : 0x58A364 /= 1 / Read필요
			if type(Source) == "number" then
				CDiv_InputData_Error()
			elseif Source[4] == "V" then -- Div 0x58A364, X : 0x58A364 /= X / Read필요
				CDiv_InputData_Error()
			else
				CDiv_InputData_Error()
			end

		elseif Dest == "Cp" then
			if type(Source) == "number" then -- Div Cp, 1 : Cp /= 1 / Read필요
				CDiv_InputData_Error()
			elseif Source[4] == "V" then -- Div Cp, X : Cp /= X / Read필요
				CDiv_InputData_Error()
			else
				CDiv_InputData_Error()
			end

		elseif Dest[4] == "V" then
			if type(Source) == "number" then -- Div X, 1 : X /= 1
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0);
						SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[2],0x15C,1,0);
						SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Dest[1],Dest[2],Dest[3]);
					},
					flag = {Preserved}
				}
				local Block = 0
				for i = 0, Bit do
					local CBit = 2^i
					if  bit32.band(Source*CBit,0xFFFFFFFF) >= 0x80000000 then
						Block = i
					end
				end
				for i = Block, 0, -1 do
					local CBit = 2^i
						Trigger {
								players = {ParsePlayer(PlayerID)},
								conditions = {
									Label(0);
									CtrigX("X",CRet[2],0x15C,0,AtLeast,Source*CBit);
								},
								actions = {
									SetCtrig1X("X",CRet[2],0x15C,0,Subtract,Source*CBit);
									SetCtrig1X("X",CRet[1],0x15C,0,Add,CBit);
								},
								flag = {Preserved}
							}
				end
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways("X",CRet[1],0);
						},
						flag = {Preserved}
					}
			elseif Source[4] == "V" then -- Div X, Y : X /= Y
				Trigger { -- Y -> CRet[1] Act#1 (-3)
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}

				Trigger { -- Y -> CRet[1] Act#2 (-2)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x17C,1,0);
							CallLabelAlways(Source[1],Source[2],Source[3]);
							SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x168,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[1],0x180,0,SetTo,Add*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x184,0,SetTo,0,0x2);
						},
						flag = {Preserved}
					}

				
				Trigger { -- X -> CRet[2] (-1)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[2],0x15C,1,0);
							SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways(Dest[1],Dest[2],Dest[3]);
							SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0); -- Clear Ret
							SetCtrigX("X",FuncAlloc,0x1BC,2,SetTo,"X",FuncAlloc,0x0,0,3); -- Init Var1 Act#4 Value
							SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2); --  Init Var2 -> Var1
						},
						flag = {Preserved}
					}

				local ClearValue = {}
				for i = 0, Bit do
					table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x24,(Bit+4)+i,SetTo,0))
					table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x15C,(Bit+4)+i,SetTo,0))
				end

				Trigger { -- Clear Value 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(FuncAlloc);
						},
						actions = {
							ClearValue,
						},
						flag = {Preserved}
					}


				Trigger { -- local Var2 (1)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
							CtrigX("X",CRet[1],0x15C,0,AtLeast,0x80000000);
						},
						actions = {
							SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2*Bit+4);
						},
						flag = {Preserved}
					}

				Trigger { -- local Var1 (2)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[1],0x15C,1,0);
							SetCtrigX("X",CRet[1],0x178,0,SetTo,"X",CRet[1],0x17C,1,0);
							SetCtrig1X("X",FuncAlloc,0x1BC,2,Add,0x970);
							SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,3);
						},
						flag = {Preserved}
					}

				for i = 0, Bit do
					Trigger { -- (3 ~ Bit+3)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",FuncAlloc,0x24,1,2*Bit+4-i);
							SetCtrigX("X",CRet[1],0x178,0,SetTo,"X",FuncAlloc,0x15C,1,2*Bit+4-i);
							SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,1);
							SetCtrigX("X",FuncAlloc,0x15C,1,SetTo,"X",FuncAlloc,0x0,0,2*Bit+4-i);
						},
						flag = {Preserved}
					}
				end

				PlayerID = PlayerConvert(PlayerID)
				for k, P in pairs(PlayerID) do
					table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,0,SetTo,"X",FuncAlloc,0x0,0,3)) --> Create Local Var
					for i = 2, (Bit+3) do
						table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,i,SetTo,"X",CRet[1],0x0,0,0)) -- -> VarX
					end
				end

				for i = 0, Bit do
					local CBit = 2^(Bit-i)
					Trigger { -- (Bit+4 ~ 2*Bit+4)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
							CtrigX("X",CRet[2],0x15C,0,AtLeast,0);
						},
						actions = {
							SetCtrig1X("X",CRet[2],0x15C,0,Subtract,0);
							SetCtrig1X("X",CRet[3],0x15C,0,Add,CBit);
						},
						flag = {Preserved}
					}
				end

				Trigger { -- 2*Bit + 5
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x178,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x180,0,SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x2,0x2);
							SetCtrigX("X",CRet[3],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							SetCtrig1X("X",CRet[3],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[3],0x160,0,SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways("X",CRet[3],0);
						},
						flag = {Preserved}
					}

				FuncAlloc = FuncAlloc + 1
			else
				CDiv_InputData_Error()
			end

		else 
			if type(Source) == "number" then -- Div Mem, 1 : Mem /= 1 / Read필요
				CDiv_InputData_Error()
			elseif Source[4] == "V" then -- Add Mem, X : Mem /= X / Read필요
				CDiv_InputData_Error()
			else
				CDiv_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	elseif Dest[4] == "V" or Dest[4] == "VA" then
		if type(Divisor) == "table" and Divisor[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Divisor)
			Divisor = TempRet
		end
		if type(Divisor) == "table" and Divisor[4] == "A" then
			CDiv_InputData_Error()
		end
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[8],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CDiv_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[9],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			CDiv_InputData_Error()
		end
		if type(Source) == "number" then -- Div V, 0x58A364, 1 : V << 0x58A364 / 1 / Read필요
			if type(Divisor) == "number" then
				CDiv_InputData_Error()
			elseif Divisor[4] == "V" then -- Div V, 0x58A364, X : V << 0x58A364 / X / Read필요
				CDiv_InputData_Error()
			else
				CDiv_InputData_Error()
			end

		elseif Source == "Cp" then
			if type(Divisor) == "number" then -- Div V, Cp, 1 : V << Cp / 1 / Read필요 
				CDiv_InputData_Error()
			elseif Divisor[4] == "V" then -- Div V, Cp, X : V << Cp / X / Read필요 
				CDiv_InputData_Error()
			else
				CDiv_InputData_Error()
			end

		elseif Source[4] == "V" then
			if type(Divisor) == "number" then -- Div V, X, 1 : V << X / 1
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0);
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[2],0x15C,1,0);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				local Block = 0
				for i = 0, Bit do
					local CBit = 2^i
					if  bit32.band(Divisor*CBit,0xFFFFFFFF) >= 0x80000000 then
						Block = i
					end
				end
				for i = Block, 0, -1 do
					local CBit = 2^i
						Trigger {
								players = {ParsePlayer(PlayerID)},
								conditions = {
									Label(0);
									CtrigX("X",CRet[2],0x15C,0,AtLeast,Divisor*CBit);
								},
								actions = {
									SetCtrig1X("X",CRet[2],0x15C,0,Subtract,Divisor*CBit);
									SetCtrig1X("X",CRet[1],0x15C,0,Add,CBit);
								},
								flag = {Preserved}
							}
				end
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways("X",CRet[1],0);
						},
						flag = {Preserved}
					}
			elseif Divisor[4] == "V" then -- Div V, X, Y : V << X / Y
				Trigger { -- Y -> CRet[1] Act#1 (-3)
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Divisor[1],Divisor[2],0x158,Divisor[3],SetTo,"X",CRet[1],0x15C,1,0);
						SetCtrig1X(Divisor[1],Divisor[2],0x148,Divisor[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Divisor[1],Divisor[2],0x160,Divisor[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Divisor[1],Divisor[2],Divisor[3]);
					},
					flag = {Preserved}
				}

				Trigger { -- Y -> CRet[1] Act#2 (-2)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX(Divisor[1],Divisor[2],0x158,Divisor[3],SetTo,"X",CRet[1],0x17C,1,0);
							CallLabelAlways(Divisor[1],Divisor[2],Divisor[3]);
							SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x168,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[1],0x180,0,SetTo,Add*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x184,0,SetTo,0,0x2);
						},
						flag = {Preserved}
					}

				
				Trigger { -- X -> CRet[2] (-1)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[2],0x15C,1,0);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways(Source[1],Source[2],Source[3]);
							SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0); -- Clear Ret
							SetCtrigX("X",FuncAlloc,0x1BC,2,SetTo,"X",FuncAlloc,0x0,0,3); -- Init Var1 Act#4 Value
							SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2); --  Init Var2 -> Var1
						},
						flag = {Preserved}
					}

				local ClearValue = {}
				for i = 0, Bit do
					table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x24,(Bit+4)+i,SetTo,0))
					table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x15C,(Bit+4)+i,SetTo,0))
				end

				Trigger { -- Clear Value 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(FuncAlloc);
						},
						actions = {
							ClearValue,
						},
						flag = {Preserved}
					}


				Trigger { -- local Var2 (1)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
							CtrigX("X",CRet[1],0x15C,0,AtLeast,0x80000000);
						},
						actions = {
							SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2*Bit+4);
						},
						flag = {Preserved}
					}

				Trigger { -- local Var1 (2)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[1],0x15C,1,0);
							SetCtrigX("X",CRet[1],0x178,0,SetTo,"X",CRet[1],0x17C,1,0);
							SetCtrig1X("X",FuncAlloc,0x1BC,2,Add,0x970);
							SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,3);
						},
						flag = {Preserved}
					}

				for i = 0, Bit do
					Trigger { -- (3 ~ Bit+3)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",FuncAlloc,0x24,1,2*Bit+4-i);
							SetCtrigX("X",CRet[1],0x178,0,SetTo,"X",FuncAlloc,0x15C,1,2*Bit+4-i);
							SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,1);
							SetCtrigX("X",FuncAlloc,0x15C,1,SetTo,"X",FuncAlloc,0x0,0,2*Bit+4-i);
						},
						flag = {Preserved}
					}
				end

				PlayerID = PlayerConvert(PlayerID)
				for k, P in pairs(PlayerID) do
					table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,0,SetTo,"X",FuncAlloc,0x0,0,3)) --> Create Local Var
					for i = 2, (Bit+3) do
						table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,i,SetTo,"X",CRet[1],0x0,0,0)) -- -> VarX
					end
				end

				for i = 0, Bit do
					local CBit = 2^(Bit-i)
					Trigger { -- (Bit+4 ~ 2*Bit+4)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
							CtrigX("X",CRet[2],0x15C,0,AtLeast,0);
						},
						actions = {
							SetCtrig1X("X",CRet[2],0x15C,0,Subtract,0);
							SetCtrig1X("X",CRet[3],0x15C,0,Add,CBit);
						},
						flag = {Preserved}
					}
				end

				Trigger { -- 2*Bit + 5
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x178,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x180,0,SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x2,0x2);
							SetCtrigX("X",CRet[3],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							SetCtrig1X("X",CRet[3],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[3],0x160,0,SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways("X",CRet[3],0);
						},
						flag = {Preserved}
					}

				FuncAlloc = FuncAlloc + 1
			else
				CDiv_InputData_Error()
			end

		else 
			if type(Divisor) == "number" then -- Div V, Mem, 1 : V << Mem v1 / Read필요
				CDiv_InputData_Error()
			elseif Divisor[4] == "V" then -- Div V, Mem, X : V << Mem / X / Read필요
				CDiv_InputData_Error()
			else
				CDiv_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	else
		CDiv_InputData_Error()
	end
end

function CMod(PlayerID,Dest,Source,Divisor,Mask,BitLimit) -- %, X,Y 둘다 Limit bit 제한
	STPopTrigArr(PlayerID)

	if Divisor == "X" then
		Divisor = nil
	end

	if Mask == "X" then
		Mask = nil
	end

	if Mask == nil then
		Mask = 0xFFFFFFFF
	end

	local  Bit = 0
	if BitLimit == nil or BitLimit == "X" then
		Bit = 31
	else
		while 2^Bit <= BitLimit and Bit <= 31 do
			Bit = Bit + 1
		end
		Bit = Bit - 1
	end
	
	if Divisor == nil then
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CMod_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[8],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			CMod_InputData_Error()
		end
		if type(Dest) == "number" then -- Mod 0x58A364, 1 : 0x58A364 %= 1 / Read필요
			if type(Source) == "number" then
				CMod_InputData_Error()
			elseif Source[4] == "V" then -- Mod 0x58A364, X : 0x58A364 %= X / Read필요
				CMod_InputData_Error()
			else
				CMod_InputData_Error()
			end

		elseif Dest == "Cp" then
			if type(Source) == "number" then -- Mod Cp, 1 : Cp %= 1 / Read필요
				CMod_InputData_Error()
			elseif Source[4] == "V" then -- Mod Cp, X : Cp %= X / Read필요
				CMod_InputData_Error()
			else
				CMod_InputData_Error()
			end

		elseif Dest[4] == "V" then
			if type(Source) == "number" then -- Mod X, 1 : X %= 1
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0);
						SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[2],0x15C,1,0);
						SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Dest[1],Dest[2],Dest[3]);
					},
					flag = {Preserved}
				}
				local Block = 0
				for i = 0, Bit do
					local CBit = 2^i
					if  bit32.band(Source*CBit,0xFFFFFFFF) >= 0x80000000 then
						Block = i
					end
				end
				for i = Block, 0, -1 do
					local CBit = 2^i
						Trigger {
								players = {ParsePlayer(PlayerID)},
								conditions = {
									Label(0);
									CtrigX("X",CRet[2],0x15C,0,AtLeast,Source*CBit);
								},
								actions = {
									SetCtrig1X("X",CRet[2],0x15C,0,Subtract,Source*CBit);
									SetCtrig1X("X",CRet[1],0x15C,0,Add,CBit);
								},
								flag = {Preserved}
							}
				end
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[2],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							SetCtrig1X("X",CRet[2],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways("X",CRet[2],0);
						},
						flag = {Preserved}
					}

			elseif Source[4] == "V" then -- Mod X, Y : X %= Y
				Trigger { -- Y -> CRet[1] Act#1 (-3)
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}

				Trigger { -- Y -> CRet[1] Act#2 (-2)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x17C,1,0);
							CallLabelAlways(Source[1],Source[2],Source[3]);
							SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x168,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[1],0x180,0,SetTo,Add*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x184,0,SetTo,0,0x2);
						},
						flag = {Preserved}
					}

				
				Trigger { -- X -> CRet[2] (-1)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[2],0x15C,1,0);
							SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways(Dest[1],Dest[2],Dest[3]);
							SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0); -- Clear Ret
							SetCtrigX("X",FuncAlloc,0x1BC,2,SetTo,"X",FuncAlloc,0x0,0,3); -- Init Var1 Act#4 Value
							SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2); --  Init Var2 -> Var1
						},
						flag = {Preserved}
					}

				local ClearValue = {}
				for i = 0, Bit do
					table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x24,(Bit+4)+i,SetTo,0))
					table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x15C,(Bit+4)+i,SetTo,0))
				end

				Trigger { -- Clear Value 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(FuncAlloc);
						},
						actions = {
							ClearValue,
						},
						flag = {Preserved}
					}


				Trigger { -- local Var2 (1)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
							CtrigX("X",CRet[1],0x15C,0,AtLeast,0x80000000);
						},
						actions = {
							SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2*Bit+4);
						},
						flag = {Preserved}
					}

				Trigger { -- local Var1 (2)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[1],0x15C,1,0);
							SetCtrigX("X",CRet[1],0x178,0,SetTo,"X",CRet[1],0x17C,1,0);
							SetCtrig1X("X",FuncAlloc,0x1BC,2,Add,0x970);
							SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,3);
						},
						flag = {Preserved}
					}

				for i = 0, Bit do
					Trigger { -- (3 ~ Bit+3)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",FuncAlloc,0x24,1,2*Bit+4-i);
							SetCtrigX("X",CRet[1],0x178,0,SetTo,"X",FuncAlloc,0x15C,1,2*Bit+4-i);
							SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,1);
							SetCtrigX("X",FuncAlloc,0x15C,1,SetTo,"X",FuncAlloc,0x0,0,2*Bit+4-i);
						},
						flag = {Preserved}
					}
				end

				PlayerID = PlayerConvert(PlayerID)
				for k, P in pairs(PlayerID) do
					table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,0,SetTo,"X",FuncAlloc,0x0,0,3)) --> Create Local Var
					for i = 2, (Bit+3) do
						table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,i,SetTo,"X",CRet[1],0x0,0,0)) -- -> VarX
					end
				end

				for i = 0, Bit do
					local CBit = 2^(Bit-i)
					Trigger { -- (Bit+4 ~ 2*Bit+4)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
							CtrigX("X",CRet[2],0x15C,0,AtLeast,0);
						},
						actions = {
							SetCtrig1X("X",CRet[2],0x15C,0,Subtract,0);
							SetCtrig1X("X",CRet[3],0x15C,0,Add,CBit);
						},
						flag = {Preserved}
					}
				end

				Trigger { -- 2*Bit + 5
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x178,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x180,0,SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x2,0x2);
							SetCtrigX("X",CRet[2],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							SetCtrig1X("X",CRet[2],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways("X",CRet[2],0);
						},
						flag = {Preserved}
					}


				FuncAlloc = FuncAlloc + 1
			else
				CMod_InputData_Error()
			end

		else 
			if type(Source) == "number" then -- Mod Mem, 1 : Mem %= 1 / Read필요
				CMod_InputData_Error()
			elseif Source[4] == "V" then -- Add Mem, X : Mem %= X / Read필요
				CMod_InputData_Error()
			else
				CMod_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	elseif Dest[4] == "V" or Dest[4] == "VA" then
		if type(Divisor) == "table" and Divisor[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Divisor)
			Divisor = TempRet
		end
		if type(Divisor) == "table" and Divisor[4] == "A" then
			CMod_InputData_Error()
		end
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[8],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CMod_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[9],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			CMod_InputData_Error()
		end
		if type(Source) == "number" then -- Mod V, 0x58A364, 1 : V << 0x58A364 % 1 / Read필요
			if type(Divisor) == "number" then
				CMod_InputData_Error()
			elseif Divisor[4] == "V" then -- Mod V, 0x58A364, X : V << 0x58A364 % X / Read필요
				CMod_InputData_Error()
			else
				CMod_InputData_Error()
			end

		elseif Source == "Cp" then
			if type(Divisor) == "number" then -- Mod V, Cp, 1 : V << Cp % 1 / Read필요 
				CMod_InputData_Error()
			elseif Divisor[4] == "V" then -- Mod V, Cp, X : V << Cp % X / Read필요 
				CMod_InputData_Error()
			else
				CMod_InputData_Error()
			end

		elseif Source[4] == "V" then
			if type(Divisor) == "number" then -- Mod V, X, 1 : V << X % 1
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0);
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[2],0x15C,1,0);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				local Block = 0
				for i = 0, Bit do
					local CBit = 2^i
					if  bit32.band(Divisor*CBit,0xFFFFFFFF) >= 0x80000000 then
						Block = i
					end
				end
				for i = Block, 0, -1 do
					local CBit = 2^i
						Trigger {
								players = {ParsePlayer(PlayerID)},
								conditions = {
									Label(0);
									CtrigX("X",CRet[2],0x15C,0,AtLeast,Divisor*CBit);
								},
								actions = {
									SetCtrig1X("X",CRet[2],0x15C,0,Subtract,Divisor*CBit);
									SetCtrig1X("X",CRet[1],0x15C,0,Add,CBit);
								},
								flag = {Preserved}
							}
				end
				Trigger {
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[2],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							SetCtrig1X("X",CRet[2],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways("X",CRet[2],0);
						},
						flag = {Preserved}
					}


			elseif Divisor[4] == "V" then -- Mod V, X, Y : V << X % Y
				Trigger { -- Y -> CRet[1] Act#1 (-3)
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Divisor[1],Divisor[2],0x158,Divisor[3],SetTo,"X",CRet[1],0x15C,1,0);
						SetCtrig1X(Divisor[1],Divisor[2],0x148,Divisor[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Divisor[1],Divisor[2],0x160,Divisor[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Divisor[1],Divisor[2],Divisor[3]);
					},
					flag = {Preserved}
				}

				Trigger { -- Y -> CRet[1] Act#2 (-2)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX(Divisor[1],Divisor[2],0x158,Divisor[3],SetTo,"X",CRet[1],0x17C,1,0);
							CallLabelAlways(Divisor[1],Divisor[2],Divisor[3]);
							SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x168,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[1],0x180,0,SetTo,Add*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x184,0,SetTo,0,0x2);
						},
						flag = {Preserved}
					}

				
				Trigger { -- X -> CRet[2] (-1)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[2],0x15C,1,0);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways(Source[1],Source[2],Source[3]);
							SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0); -- Clear Ret
							SetCtrigX("X",FuncAlloc,0x1BC,2,SetTo,"X",FuncAlloc,0x0,0,3); -- Init Var1 Act#4 Value
							SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2); --  Init Var2 -> Var1
						},
						flag = {Preserved}
					}

				local ClearValue = {}
				for i = 0, Bit do
					table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x24,(Bit+4)+i,SetTo,0))
					table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x15C,(Bit+4)+i,SetTo,0))
				end

				Trigger { -- Clear Value 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(FuncAlloc);
						},
						actions = {
							ClearValue,
						},
						flag = {Preserved}
					}


				Trigger { -- local Var2 (1)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
							CtrigX("X",CRet[1],0x15C,0,AtLeast,0x80000000);
						},
						actions = {
							SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2*Bit+4);
						},
						flag = {Preserved}
					}

				Trigger { -- local Var1 (2)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[1],0x15C,1,0);
							SetCtrigX("X",CRet[1],0x178,0,SetTo,"X",CRet[1],0x17C,1,0);
							SetCtrig1X("X",FuncAlloc,0x1BC,2,Add,0x970);
							SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,3);
						},
						flag = {Preserved}
					}

				for i = 0, Bit do
					Trigger { -- (3 ~ Bit+3)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",FuncAlloc,0x24,1,2*Bit+4-i);
							SetCtrigX("X",CRet[1],0x178,0,SetTo,"X",FuncAlloc,0x15C,1,2*Bit+4-i);
							SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,1);
							SetCtrigX("X",FuncAlloc,0x15C,1,SetTo,"X",FuncAlloc,0x0,0,2*Bit+4-i);
						},
						flag = {Preserved}
					}
				end

				PlayerID = PlayerConvert(PlayerID)
				for k, P in pairs(PlayerID) do
					table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,0,SetTo,"X",FuncAlloc,0x0,0,3)) --> Create Local Var
					for i = 2, (Bit+3) do
						table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,i,SetTo,"X",CRet[1],0x0,0,0)) -- -> VarX
					end
				end

				for i = 0, Bit do
					local CBit = 2^(Bit-i)
					Trigger { -- (Bit+4 ~ 2*Bit+4)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
							CtrigX("X",CRet[2],0x15C,0,AtLeast,0);
						},
						actions = {
							SetCtrig1X("X",CRet[2],0x15C,0,Subtract,0);
							SetCtrig1X("X",CRet[3],0x15C,0,Add,CBit);
						},
						flag = {Preserved}
					}
				end

				Trigger { -- 2*Bit + 5
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x178,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x180,0,SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x2,0x2);
							SetCtrigX("X",CRet[2],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							SetCtrig1X("X",CRet[2],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways("X",CRet[2],0);
						},
						flag = {Preserved}
					}

				FuncAlloc = FuncAlloc + 1
			else
				CMod_InputData_Error()
			end

		else 
			if type(Divisor) == "number" then -- Mod V, Mem, 1 : V << Mem % 1 / Read필요
				CMod_InputData_Error()
			elseif Divisor[4] == "V" then -- Mod V, Mem, X : V << Mem % X / Read필요
				CMod_InputData_Error()
			else
				CMod_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	else
		CMod_InputData_Error()
	end
end

function CiDiv(PlayerID,Dest,Source,Divisor,Mask,BitLimit) -- CDiv의 Signed 연산 | 10/-3 = -3 / -10/3 = -3 / -10/-3 = 3
	STPopTrigArr(PlayerID)

	if Divisor == "X" then
		Divisor = nil
	end

	if Mask == "X" then
		Mask = nil
	end

	if Mask == nil then
		Mask = 0xFFFFFFFF
	end

	local  Bit = 0
	if BitLimit == nil or BitLimit == "X" then
		Bit = 31
	else
		while 2^Bit <= BitLimit and Bit <= 31 do
			Bit = Bit + 1
		end
		Bit = Bit - 1
	end
	
	if Divisor == nil then
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CiDiv_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[8],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			CiDiv_InputData_Error()
		end
		if type(Dest) == "number" then -- iDiv 0x58A364, 1 : 0x58A364 /= 1 / Read필요
			if type(Source) == "number" then
				CiDiv_InputData_Error()
			elseif Source[4] == "V" then -- iDiv 0x58A364, X : 0x58A364 /= X / Read필요
				CiDiv_InputData_Error()
			else
				CiDiv_InputData_Error()
			end

		elseif Dest == "Cp" then
			if type(Source) == "number" then -- iDiv Cp, 1 : Cp /= 1 / Read필요
				CiDiv_InputData_Error()
			elseif Source[4] == "V" then -- iDiv Cp, X : Cp /= X / Read필요
				CiDiv_InputData_Error()
			else
				CiDiv_InputData_Error()
			end

		elseif Dest[4] == "V" then
			if type(Source) == "number" then -- iDiv X, 1 : X /= 1
				CIfX(PlayerID,CtrigX(Dest[1],Dest[2],0x15C,Dest[3],AtLeast,0x80000000))
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[5],0x15C,0,SetTo,1); -- Sflag
								SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0);
								SetCtrig1X("X",CRet[2],0x15C,0,SetTo,0xFFFFFFFF);
								SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[2],0x15C,1,0);
								SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
								SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,Subtract*16777216,0xFF000000);
								CallLabelAlways(Dest[1],Dest[2],Dest[3]);
							},
							flag = {Preserved}
						}
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[2],0x15C,0,Add,1);
							},
							flag = {Preserved}
						}
				CElseX()
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[5],0x15C,0,SetTo,0); -- Sflag
								SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0);
								SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[2],0x15C,1,0);
								SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
								SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
								CallLabelAlways(Dest[1],Dest[2],Dest[3]);
							},
							flag = {Preserved}
						}
				CIfXEnd()

				if bit32.band(Source,0xFFFFFFFF) >= 0x80000000 then
					Source = 0 - Source
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[5],0x15C,0,Add,1); -- Sflag
							},
							flag = {Preserved}
						}
				end
			
				local Block = 0
				for i = 0, Bit do
					local CBit = 2^i
					if  bit32.band(Source*CBit,0xFFFFFFFF) >= 0x80000000 then
						Block = i
					end
				end
				for i = Block, 0, -1 do
					local CBit = 2^i
						Trigger {
								players = {ParsePlayer(PlayerID)},
								conditions = {
									Label(0);
									CtrigX("X",CRet[2],0x15C,0,AtLeast,Source*CBit);
								},
								actions = {
									SetCtrig1X("X",CRet[2],0x15C,0,Subtract,Source*CBit);
									SetCtrig1X("X",CRet[1],0x15C,0,Add,CBit);
								},
								flag = {Preserved}
							}
				end
				CIfX(PlayerID,CtrigX("X",CRet[5],0x15C,0,Exactly,0x1,0x1)) -- Sflag == 1
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,0xFFFFFFFF,Mask);
								SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
								SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x160,0,SetTo,Subtract*16777216,0xFF000000);
								CallLabelAlways("X",CRet[1],0);
							},
							flag = {Preserved}
						}
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,1);
							},
							flag = {Preserved}
						}
				CElseX()
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
								SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
								CallLabelAlways("X",CRet[1],0);
							},
							flag = {Preserved}
						}
				CIfXEnd()
			elseif Source[4] == "V" then -- iDiv X, Y : X /= Y
				CIfX(PlayerID,CtrigX(Source[1],Source[2],0x15C,Source[3],AtLeast,0x80000000))
					Trigger { -- Y -> CRet[1] Act#1 
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[5],0x15C,0,SetTo,1); -- Sflag
								SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0xFFFFFFFF);
								SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
								SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
								SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
								CallLabelAlways(Source[1],Source[2],Source[3]);
							},
							flag = {Preserved}
						}

					Trigger { -- Y -> CRet[1] Act#2 
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x17C,1,0);
								CallLabelAlways(Source[1],Source[2],Source[3]);
								SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
								SetCtrig1X("X",CRet[1],0x168,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x180,0,SetTo,Add*16777216,0xFF000000);
								SetCtrig1X("X",CRet[1],0x184,0,SetTo,0,0x2);
							},
							flag = {Preserved}
						}
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[1],0x15C,0,Add,1);
								SetCtrig1X("X",CRet[1],0x17C,0,Add,1);
							},
							flag = {Preserved}
						}
				CElseX()
					Trigger { -- Y -> CRet[1] Act#1 
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[5],0x15C,0,SetTo,0); -- Sflag
								SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
								SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
								SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
								CallLabelAlways(Source[1],Source[2],Source[3]);
							},
							flag = {Preserved}
						}

					Trigger { -- Y -> CRet[1] Act#2 
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x17C,1,0);
								CallLabelAlways(Source[1],Source[2],Source[3]);
								SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
								SetCtrig1X("X",CRet[1],0x168,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x180,0,SetTo,Add*16777216,0xFF000000);
								SetCtrig1X("X",CRet[1],0x184,0,SetTo,0,0x2);
							},
							flag = {Preserved}
						}
				CIfXEnd()

				CIfX(PlayerID,CtrigX(Dest[1],Dest[2],0x15C,Dest[3],AtLeast,0x80000000))
					Trigger { -- X -> CRet[2] (-2)
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
							SetCtrig1X("X",CRet[5],0x15C,0,Add,1); -- Sflag
							SetCtrig1X("X",CRet[2],0x15C,0,SetTo,0xFFFFFFFF);
							SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[2],0x15C,1,0);
							SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,Subtract*16777216,0xFF000000);
							CallLabelAlways(Dest[1],Dest[2],Dest[3]);
							SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0); -- Clear Ret
							SetCtrigX("X",FuncAlloc,0x1BC,2,SetTo,"X",FuncAlloc,0x0,0,3); -- Init Var1 Act#4 Value
							SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2); --  Init Var2 -> Var1
							},
							flag = {Preserved}
						}
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[2],0x15C,0,Add,1);
							},
							flag = {Preserved}
						}
				CElseX()
					Trigger { -- X -> CRet[2] (-1)
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
							SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[2],0x15C,1,0);
							SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways(Dest[1],Dest[2],Dest[3]);
							SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0); -- Clear Ret
							SetCtrigX("X",FuncAlloc,0x1BC,2,SetTo,"X",FuncAlloc,0x0,0,3); -- Init Var1 Act#4 Value
							SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2); --  Init Var2 -> Var1
							},
							flag = {Preserved}
						}
				CIfXEnd()

				local ClearValue = {}
				for i = 0, Bit do
					table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x24,(Bit+4)+i,SetTo,0))
					table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x15C,(Bit+4)+i,SetTo,0))
				end

				Trigger { -- Clear Value 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(FuncAlloc);
						},
						actions = {
							ClearValue,
						},
						flag = {Preserved}
					}


				Trigger { -- local Var2 (1)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
							CtrigX("X",CRet[1],0x15C,0,AtLeast,0x80000000);
						},
						actions = {
							SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2*Bit+4);
						},
						flag = {Preserved}
					}

				Trigger { -- local Var1 (2)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[1],0x15C,1,0);
							SetCtrigX("X",CRet[1],0x178,0,SetTo,"X",CRet[1],0x17C,1,0);
							SetCtrig1X("X",FuncAlloc,0x1BC,2,Add,0x970);
							SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,3);
						},
						flag = {Preserved}
					}

				for i = 0, Bit do
					Trigger { -- (3 ~ Bit+3)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",FuncAlloc,0x24,1,2*Bit+4-i);
							SetCtrigX("X",CRet[1],0x178,0,SetTo,"X",FuncAlloc,0x15C,1,2*Bit+4-i);
							SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,1);
							SetCtrigX("X",FuncAlloc,0x15C,1,SetTo,"X",FuncAlloc,0x0,0,2*Bit+4-i);
						},
						flag = {Preserved}
					}
				end

				PlayerID = PlayerConvert(PlayerID)
				for k, P in pairs(PlayerID) do
					table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,0,SetTo,"X",FuncAlloc,0x0,0,3)) --> Create Local Var
					for i = 2, (Bit+3) do
						table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,i,SetTo,"X",CRet[1],0x0,0,0)) -- -> VarX
					end
				end

				for i = 0, Bit do
					local CBit = 2^(Bit-i)
					Trigger { -- (Bit+4 ~ 2*Bit+4)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
							CtrigX("X",CRet[2],0x15C,0,AtLeast,0);
						},
						actions = {
							SetCtrig1X("X",CRet[2],0x15C,0,Subtract,0);
							SetCtrig1X("X",CRet[3],0x15C,0,Add,CBit);
						},
						flag = {Preserved}
					}
				end

				CIfX(PlayerID,CtrigX("X",CRet[5],0x15C,0,Exactly,0x1,0x1)) -- Sflag == 1
					Trigger { 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x178,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x180,0,SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x2,0x2);
							SetCtrigX("X",CRet[3],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							SetCtrig1X("X",CRet[3],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[3],0x160,0,SetTo,Subtract*16777216,0xFF000000);
							CallLabelAlways("X",CRet[3],0);
							SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,0xFFFFFFFF);
						},
						flag = {Preserved}
					}
					Trigger { 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,1);
						},
						flag = {Preserved}
					}
					Trigger { -- X(<0)/0 -> 0x80000000
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
								CtrigX(Source[1],Source[2],0x15C,Source[3],Exactly,0x0);
							},
							actions = {
							SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,0x80000000);
							},
							flag = {Preserved}
						}
				CElseX()
					Trigger { 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x178,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x180,0,SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x2,0x2);
							SetCtrigX("X",CRet[3],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							SetCtrig1X("X",CRet[3],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[3],0x160,0,SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways("X",CRet[3],0);
						},
						flag = {Preserved}
					}
					Trigger { -- X(>=0)/0 -> 0x7FFFFFFF
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
								CtrigX(Source[1],Source[2],0x15C,Source[3],Exactly,0x0);
							},
							actions = {
							SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,0x7FFFFFFF);
							},
							flag = {Preserved}
						}
				CIfXEnd()

				FuncAlloc = FuncAlloc + 1
			else
				CiDiv_InputData_Error()
			end

		else 
			if type(Source) == "number" then -- iDiv Mem, 1 : Mem /= 1 / Read필요
				CiDiv_InputData_Error()
			elseif Source[4] == "V" then -- Add Mem, X : Mem /= X / Read필요
				CiDiv_InputData_Error()
			else
				CiDiv_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	elseif Dest[4] == "V" or Dest[4] == "VA" then
		if type(Divisor) == "table" and Divisor[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Divisor)
			Divisor = TempRet
		end
		if type(Divisor) == "table" and Divisor[4] == "A" then
			CiDiv_InputData_Error()
		end
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[8],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CiDiv_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[9],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			CiDiv_InputData_Error()
		end
		if type(Source) == "number" then -- iDiv V, 0x58A364, 1 : V << 0x58A364 / 1 / Read필요
			if type(Divisor) == "number" then
				CiDiv_InputData_Error()
			elseif Divisor[4] == "V" then -- iDiv V, 0x58A364, X : V << 0x58A364 / X / Read필요
				CiDiv_InputData_Error()
			else
				CiDiv_InputData_Error()
			end

		elseif Source == "Cp" then
			if type(Divisor) == "number" then -- iDiv V, Cp, 1 : V << Cp / 1 / Read필요 
				CiDiv_InputData_Error()
			elseif Divisor[4] == "V" then -- iDiv V, Cp, X : V << Cp / X / Read필요 
				CiDiv_InputData_Error()
			else
				CiDiv_InputData_Error()
			end

		elseif Source[4] == "V" then
			if type(Divisor) == "number" then -- iDiv V, X, 1 : V << X / 1
				CIfX(PlayerID,CtrigX(Source[1],Source[2],0x15C,Source[3],AtLeast,0x80000000))
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[5],0x15C,0,SetTo,1); -- Sflag
								SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0);
								SetCtrig1X("X",CRet[2],0x15C,0,SetTo,0xFFFFFFFF);
								SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[2],0x15C,1,0);
								SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
								SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
								CallLabelAlways(Source[1],Source[2],Source[3]);
							},
							flag = {Preserved}
						}
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[2],0x15C,0,Add,1);
							},
							flag = {Preserved}
						}
				CElseX()
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[5],0x15C,0,SetTo,0); -- Sflag
								SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0);
								SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[2],0x15C,1,0);
								SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
								SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
								CallLabelAlways(Source[1],Source[2],Source[3]);
							},
							flag = {Preserved}
						}
				CIfXEnd()

				if bit32.band(Divisor,0xFFFFFFFF) >= 0x80000000 then
					Divisor = 0 - Divisor
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[5],0x15C,0,Add,1); -- Sflag
							},
							flag = {Preserved}
						}
				end
				local Block = 0
				for i = 0, Bit do
					local CBit = 2^i
					if  bit32.band(Divisor*CBit,0xFFFFFFFF) >= 0x80000000 then
						Block = i
					end
				end
				for i = Block, 0, -1 do
					local CBit = 2^i
						Trigger {
								players = {ParsePlayer(PlayerID)},
								conditions = {
									Label(0);
									CtrigX("X",CRet[2],0x15C,0,AtLeast,Divisor*CBit);
								},
								actions = {
									SetCtrig1X("X",CRet[2],0x15C,0,Subtract,Divisor*CBit);
									SetCtrig1X("X",CRet[1],0x15C,0,Add,CBit);
								},
								flag = {Preserved}
							}
				end
				CIfX(PlayerID,CtrigX("X",CRet[5],0x15C,0,Exactly,0x1,0x1)) -- Sflag == 1
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,0xFFFFFFFF,Mask);
								SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
								SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x160,0,SetTo,Subtract*16777216,0xFF000000);
								CallLabelAlways("X",CRet[1],0);
							},
							flag = {Preserved}
						}
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,1);
							},
							flag = {Preserved}
						}
				CElseX()
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
								SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
								CallLabelAlways("X",CRet[1],0);
							},
							flag = {Preserved}
						}
				CIfXEnd()
			elseif Divisor[4] == "V" then -- iDiv V, X, Y : V << X / Y
				CIfX(PlayerID,CtrigX(Divisor[1],Divisor[2],0x15C,Divisor[3],AtLeast,0x80000000))
					Trigger { -- Y -> CRet[1] Act#1 
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[5],0x15C,0,SetTo,1); -- Sflag
								SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0xFFFFFFFF);
								SetCtrigX(Divisor[1],Divisor[2],0x158,Divisor[3],SetTo,"X",CRet[1],0x15C,1,0);
								SetCtrig1X(Divisor[1],Divisor[2],0x148,Divisor[3],SetTo,0xFFFFFFFF);
								SetCtrig1X(Divisor[1],Divisor[2],0x160,Divisor[3],SetTo,Subtract*16777216,0xFF000000);
								CallLabelAlways(Divisor[1],Divisor[2],Divisor[3]);
							},
							flag = {Preserved}
						}

					Trigger { -- Y -> CRet[1] Act#2 
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrigX(Divisor[1],Divisor[2],0x158,Divisor[3],SetTo,"X",CRet[1],0x17C,1,0);
								CallLabelAlways(Divisor[1],Divisor[2],Divisor[3]);
								SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
								SetCtrig1X("X",CRet[1],0x168,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x180,0,SetTo,Add*16777216,0xFF000000);
								SetCtrig1X("X",CRet[1],0x184,0,SetTo,0,0x2);
							},
							flag = {Preserved}
						}
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[1],0x15C,0,Add,1);
								SetCtrig1X("X",CRet[1],0x17C,0,Add,1);
							},
							flag = {Preserved}
						}
				CElseX()
					Trigger { -- Y -> CRet[1] Act#1 
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[5],0x15C,0,SetTo,0); -- Sflag
								SetCtrigX(Divisor[1],Divisor[2],0x158,Divisor[3],SetTo,"X",CRet[1],0x15C,1,0);
								SetCtrig1X(Divisor[1],Divisor[2],0x148,Divisor[3],SetTo,0xFFFFFFFF);
								SetCtrig1X(Divisor[1],Divisor[2],0x160,Divisor[3],SetTo,SetTo*16777216,0xFF000000);
								CallLabelAlways(Divisor[1],Divisor[2],Divisor[3]);
							},
							flag = {Preserved}
						}

					Trigger { -- Y -> CRet[1] Act#2 
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrigX(Divisor[1],Divisor[2],0x158,Divisor[3],SetTo,"X",CRet[1],0x17C,1,0);
								CallLabelAlways(Divisor[1],Divisor[2],Divisor[3]);
								SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
								SetCtrig1X("X",CRet[1],0x168,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x180,0,SetTo,Add*16777216,0xFF000000);
								SetCtrig1X("X",CRet[1],0x184,0,SetTo,0,0x2);
							},
							flag = {Preserved}
						}
				CIfXEnd()

				CIfX(PlayerID,CtrigX(Source[1],Source[2],0x15C,Source[3],AtLeast,0x80000000))
					Trigger { -- X -> CRet[2] (-2)
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
							SetCtrig1X("X",CRet[5],0x15C,0,Add,1); -- Sflag
							SetCtrig1X("X",CRet[2],0x15C,0,SetTo,0xFFFFFFFF);
							SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[2],0x15C,1,0);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
							CallLabelAlways(Source[1],Source[2],Source[3]);
							SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0); -- Clear Ret
							SetCtrigX("X",FuncAlloc,0x1BC,2,SetTo,"X",FuncAlloc,0x0,0,3); -- Init Var1 Act#4 Value
							SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2); --  Init Var2 -> Var1
							},
							flag = {Preserved}
						}
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[2],0x15C,0,Add,1);
							},
							flag = {Preserved}
						}
				CElseX()
					Trigger { -- X -> CRet[2] (-1)
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
							SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[2],0x15C,1,0);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways(Source[1],Source[2],Source[3]);
							SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0); -- Clear Ret
							SetCtrigX("X",FuncAlloc,0x1BC,2,SetTo,"X",FuncAlloc,0x0,0,3); -- Init Var1 Act#4 Value
							SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2); --  Init Var2 -> Var1
							},
							flag = {Preserved}
						}
				CIfXEnd()

				local ClearValue = {}
				for i = 0, Bit do
					table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x24,(Bit+4)+i,SetTo,0))
					table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x15C,(Bit+4)+i,SetTo,0))
				end

				Trigger { -- Clear Value 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(FuncAlloc);
						},
						actions = {
							ClearValue,
						},
						flag = {Preserved}
					}


				Trigger { -- local Var2 (1)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
							CtrigX("X",CRet[1],0x15C,0,AtLeast,0x80000000);
						},
						actions = {
							SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2*Bit+4);
						},
						flag = {Preserved}
					}

				Trigger { -- local Var1 (2)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[1],0x15C,1,0);
							SetCtrigX("X",CRet[1],0x178,0,SetTo,"X",CRet[1],0x17C,1,0);
							SetCtrig1X("X",FuncAlloc,0x1BC,2,Add,0x970);
							SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,3);
						},
						flag = {Preserved}
					}

				for i = 0, Bit do
					Trigger { -- (3 ~ Bit+3)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",FuncAlloc,0x24,1,2*Bit+4-i);
							SetCtrigX("X",CRet[1],0x178,0,SetTo,"X",FuncAlloc,0x15C,1,2*Bit+4-i);
							SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,1);
							SetCtrigX("X",FuncAlloc,0x15C,1,SetTo,"X",FuncAlloc,0x0,0,2*Bit+4-i);
						},
						flag = {Preserved}
					}
				end

				PlayerID = PlayerConvert(PlayerID)
				for k, P in pairs(PlayerID) do
					table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,0,SetTo,"X",FuncAlloc,0x0,0,3)) --> Create Local Var
					for i = 2, (Bit+3) do
						table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,i,SetTo,"X",CRet[1],0x0,0,0)) -- -> VarX
					end
				end

				for i = 0, Bit do
					local CBit = 2^(Bit-i)
					Trigger { -- (Bit+4 ~ 2*Bit+4)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
							CtrigX("X",CRet[2],0x15C,0,AtLeast,0);
						},
						actions = {
							SetCtrig1X("X",CRet[2],0x15C,0,Subtract,0);
							SetCtrig1X("X",CRet[3],0x15C,0,Add,CBit);
						},
						flag = {Preserved}
					}
				end

				CIfX(PlayerID,CtrigX("X",CRet[5],0x15C,0,Exactly,0x1,0x1)) -- Sflag == 1
					Trigger { 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x178,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x180,0,SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x2,0x2);
							SetCtrigX("X",CRet[3],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							SetCtrig1X("X",CRet[3],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[3],0x160,0,SetTo,Subtract*16777216,0xFF000000);
							CallLabelAlways("X",CRet[3],0);
							SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,0xFFFFFFFF);
						},
						flag = {Preserved}
					}
					Trigger { 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,1);
						},
						flag = {Preserved}
					}
				Trigger { -- X(<0)/0 -> 0x80000000
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
								CtrigX(Divisor[1],Divisor[2],0x15C,Divisor[3],Exactly,0x0);
							},
							actions = {
							SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,0x80000000);
							},
							flag = {Preserved}
						}
				CElseX()
					Trigger { 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x178,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x180,0,SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x2,0x2);
							SetCtrigX("X",CRet[3],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							SetCtrig1X("X",CRet[3],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[3],0x160,0,SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways("X",CRet[3],0);
						},
						flag = {Preserved}
					}
					Trigger { -- X(>=0)/0 -> 0x7FFFFFFF
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
								CtrigX(Divisor[1],Divisor[2],0x15C,Divisor[3],Exactly,0x0);
							},
							actions = {
							SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,0x7FFFFFFF);
							},
							flag = {Preserved}
						}
				CIfXEnd()

				FuncAlloc = FuncAlloc + 1
			else
				CiDiv_InputData_Error()
			end

		else 
			if type(Divisor) == "number" then -- iDiv V, Mem, 1 : V << Mem v1 / Read필요
				CiDiv_InputData_Error()
			elseif Divisor[4] == "V" then -- iDiv V, Mem, X : V << Mem / X / Read필요
				CiDiv_InputData_Error()
			else
				CiDiv_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	else
		CiDiv_InputData_Error()
	end
end

function CiMod(PlayerID,Dest,Source,Divisor,Mask,BitLimit) -- CMod의 Signed 연산 | 10%-3 = 1 / -10%3 = -1 / -10%-3 = -1 (C++방식)
	STPopTrigArr(PlayerID)

	if Divisor == "X" then
		Divisor = nil
	end

	if Mask == "X" then
		Mask = nil
	end

	if Mask == nil then
		Mask = 0xFFFFFFFF
	end

	local  Bit = 0
	if BitLimit == nil or BitLimit == "X" then
		Bit = 31
	else
		while 2^Bit <= BitLimit and Bit <= 31 do
			Bit = Bit + 1
		end
		Bit = Bit - 1
	end
	
	if Divisor == nil then
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CiMod_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[8],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			CiMod_InputData_Error()
		end
		if type(Dest) == "number" then -- iMod 0x58A364, 1 : 0x58A364 %= 1 / Read필요
			if type(Source) == "number" then
				CiMod_InputData_Error()
			elseif Source[4] == "V" then -- iMod 0x58A364, X : 0x58A364 %= X / Read필요
				CiMod_InputData_Error()
			else
				CiMod_InputData_Error()
			end

		elseif Dest == "Cp" then
			if type(Source) == "number" then -- iMod Cp, 1 : Cp %= 1 / Read필요
				CiMod_InputData_Error()
			elseif Source[4] == "V" then -- iMod Cp, X : Cp %= X / Read필요
				CiMod_InputData_Error()
			else
				CiMod_InputData_Error()
			end

		elseif Dest[4] == "V" then
			if type(Source) == "number" then -- iMod X, 1 : X %= 1
				CIfX(PlayerID,CtrigX(Dest[1],Dest[2],0x15C,Dest[3],AtLeast,0x80000000))
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[5],0x15C,0,SetTo,1); -- Sflag
								SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0);
								SetCtrig1X("X",CRet[2],0x15C,0,SetTo,0xFFFFFFFF);
								SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[2],0x15C,1,0);
								SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
								SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,Subtract*16777216,0xFF000000);
								CallLabelAlways(Dest[1],Dest[2],Dest[3]);
							},
							flag = {Preserved}
						}
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[2],0x15C,0,Add,1);
							},
							flag = {Preserved}
						}
				CElseX()
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[5],0x15C,0,SetTo,0); -- Sflag
								SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0);
								SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[2],0x15C,1,0);
								SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
								SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
								CallLabelAlways(Dest[1],Dest[2],Dest[3]);
							},
							flag = {Preserved}
						}
				CIfXEnd()

				if bit32.band(Source,0xFFFFFFFF) >= 0x80000000 then
					Source = 0 - Source
				end
				
				local Block = 0
				for i = 0, Bit do
					local CBit = 2^i
					if  bit32.band(Source*CBit,0xFFFFFFFF) >= 0x80000000 then
						Block = i
					end
				end
				for i = Block, 0, -1 do
					local CBit = 2^i
						Trigger {
								players = {ParsePlayer(PlayerID)},
								conditions = {
									Label(0);
									CtrigX("X",CRet[2],0x15C,0,AtLeast,Source*CBit);
								},
								actions = {
									SetCtrig1X("X",CRet[2],0x15C,0,Subtract,Source*CBit);
									SetCtrig1X("X",CRet[1],0x15C,0,Add,CBit);
								},
								flag = {Preserved}
							}
				end
				CIfX(PlayerID,CtrigX("X",CRet[5],0x15C,0,Exactly,0x1,0x1)) -- Sflag == 1
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,0xFFFFFFFF,Mask);
								SetCtrigX("X",CRet[2],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
								SetCtrig1X("X",CRet[2],0x148,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[2],0x160,0,SetTo,Subtract*16777216,0xFF000000);
								CallLabelAlways("X",CRet[2],0);
							},
							flag = {Preserved}
						}
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,1);
							},
							flag = {Preserved}
						}
				CElseX()
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrigX("X",CRet[2],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
								SetCtrig1X("X",CRet[2],0x148,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
								CallLabelAlways("X",CRet[2],0);
							},
							flag = {Preserved}
						}
				CIfXEnd()

			elseif Source[4] == "V" then -- iMod X, Y : X %= Y
				CIfX(PlayerID,CtrigX(Source[1],Source[2],0x15C,Source[3],AtLeast,0x80000000))
					Trigger { -- Y -> CRet[1] Act#1 
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0xFFFFFFFF);
								SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
								SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
								SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
								CallLabelAlways(Source[1],Source[2],Source[3]);
							},
							flag = {Preserved}
						}

					Trigger { -- Y -> CRet[1] Act#2 
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x17C,1,0);
								CallLabelAlways(Source[1],Source[2],Source[3]);
								SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
								SetCtrig1X("X",CRet[1],0x168,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x180,0,SetTo,Add*16777216,0xFF000000);
								SetCtrig1X("X",CRet[1],0x184,0,SetTo,0,0x2);
							},
							flag = {Preserved}
						}
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[1],0x15C,0,Add,1);
								SetCtrig1X("X",CRet[1],0x17C,0,Add,1);
							},
							flag = {Preserved}
						}
				CElseX()
					Trigger { -- Y -> CRet[1] Act#1 
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
								SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
								SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
								CallLabelAlways(Source[1],Source[2],Source[3]);
							},
							flag = {Preserved}
						}

					Trigger { -- Y -> CRet[1] Act#2 
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x17C,1,0);
								CallLabelAlways(Source[1],Source[2],Source[3]);
								SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
								SetCtrig1X("X",CRet[1],0x168,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x180,0,SetTo,Add*16777216,0xFF000000);
								SetCtrig1X("X",CRet[1],0x184,0,SetTo,0,0x2);
							},
							flag = {Preserved}
						}
				CIfXEnd()

				CIfX(PlayerID,CtrigX(Dest[1],Dest[2],0x15C,Dest[3],AtLeast,0x80000000))
					Trigger { -- X -> CRet[2] (-2)
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
							SetCtrig1X("X",CRet[5],0x15C,0,SetTo,1); -- Sflag
							SetCtrig1X("X",CRet[2],0x15C,0,SetTo,0xFFFFFFFF);
							SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[2],0x15C,1,0);
							SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,Subtract*16777216,0xFF000000);
							CallLabelAlways(Dest[1],Dest[2],Dest[3]);
							SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0); -- Clear Ret
							SetCtrigX("X",FuncAlloc,0x1BC,2,SetTo,"X",FuncAlloc,0x0,0,3); -- Init Var1 Act#4 Value
							SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2); --  Init Var2 -> Var1
							},
							flag = {Preserved}
						}
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[2],0x15C,0,Add,1);
							},
							flag = {Preserved}
						}
				CElseX()
					Trigger { -- X -> CRet[2] (-1)
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
							SetCtrig1X("X",CRet[5],0x15C,0,SetTo,0); -- Sflag
							SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[2],0x15C,1,0);
							SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways(Dest[1],Dest[2],Dest[3]);
							SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0); -- Clear Ret
							SetCtrigX("X",FuncAlloc,0x1BC,2,SetTo,"X",FuncAlloc,0x0,0,3); -- Init Var1 Act#4 Value
							SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2); --  Init Var2 -> Var1
							},
							flag = {Preserved}
						}
				CIfXEnd()

				local ClearValue = {}
				for i = 0, Bit do
					table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x24,(Bit+4)+i,SetTo,0))
					table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x15C,(Bit+4)+i,SetTo,0))
				end

				Trigger { -- Clear Value 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(FuncAlloc);
						},
						actions = {
							ClearValue,
						},
						flag = {Preserved}
					}


				Trigger { -- local Var2 (1)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
							CtrigX("X",CRet[1],0x15C,0,AtLeast,0x80000000);
						},
						actions = {
							SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2*Bit+4);
						},
						flag = {Preserved}
					}

				Trigger { -- local Var1 (2)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[1],0x15C,1,0);
							SetCtrigX("X",CRet[1],0x178,0,SetTo,"X",CRet[1],0x17C,1,0);
							SetCtrig1X("X",FuncAlloc,0x1BC,2,Add,0x970);
							SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,3);
						},
						flag = {Preserved}
					}

				for i = 0, Bit do
					Trigger { -- (3 ~ Bit+3)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",FuncAlloc,0x24,1,2*Bit+4-i);
							SetCtrigX("X",CRet[1],0x178,0,SetTo,"X",FuncAlloc,0x15C,1,2*Bit+4-i);
							SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,1);
							SetCtrigX("X",FuncAlloc,0x15C,1,SetTo,"X",FuncAlloc,0x0,0,2*Bit+4-i);
						},
						flag = {Preserved}
					}
				end

				PlayerID = PlayerConvert(PlayerID)
				for k, P in pairs(PlayerID) do
					table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,0,SetTo,"X",FuncAlloc,0x0,0,3)) --> Create Local Var
					for i = 2, (Bit+3) do
						table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,i,SetTo,"X",CRet[1],0x0,0,0)) -- -> VarX
					end
				end

				for i = 0, Bit do
					local CBit = 2^(Bit-i)
					Trigger { -- (Bit+4 ~ 2*Bit+4)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
							CtrigX("X",CRet[2],0x15C,0,AtLeast,0);
						},
						actions = {
							SetCtrig1X("X",CRet[2],0x15C,0,Subtract,0);
							SetCtrig1X("X",CRet[3],0x15C,0,Add,CBit);
						},
						flag = {Preserved}
					}
				end

				CIfX(PlayerID,CtrigX("X",CRet[5],0x15C,0,Exactly,0x1,0x1)) -- Sflag == 1
					Trigger { 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x178,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x180,0,SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x2,0x2);
							SetCtrigX("X",CRet[2],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							SetCtrig1X("X",CRet[2],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[2],0x160,0,SetTo,Subtract*16777216,0xFF000000);
							CallLabelAlways("X",CRet[2],0);
							SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,0xFFFFFFFF);
						},
						flag = {Preserved}
					}
					Trigger { 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,1);
						},
						flag = {Preserved}
					}
				CElseX()
					Trigger { 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x178,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x180,0,SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x2,0x2);
							SetCtrigX("X",CRet[2],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							SetCtrig1X("X",CRet[2],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways("X",CRet[2],0);
						},
						flag = {Preserved}
					}
				CIfXEnd()

				FuncAlloc = FuncAlloc + 1
			else
				CiMod_InputData_Error()
			end

		else 
			if type(Source) == "number" then -- iMod Mem, 1 : Mem %= 1 / Read필요
				CiMod_InputData_Error()
			elseif Source[4] == "V" then -- Add Mem, X : Mem %= X / Read필요
				CiMod_InputData_Error()
			else
				CiMod_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	elseif Dest[4] == "V" or Dest[4] == "VA" then
		if type(Divisor) == "table" and Divisor[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Divisor)
			Divisor = TempRet
		end
		if type(Divisor) == "table" and Divisor[4] == "A" then
			CiMod_InputData_Error()
		end
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[8],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CiMod_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[9],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			CiMod_InputData_Error()
		end
		if type(Source) == "number" then -- iMod V, 0x58A364, 1 : V << 0x58A364 % 1 / Read필요
			if type(Divisor) == "number" then
				CiMod_InputData_Error()
			elseif Divisor[4] == "V" then -- iMod V, 0x58A364, X : V << 0x58A364 % X / Read필요
				CiMod_InputData_Error()
			else
				CiMod_InputData_Error()
			end

		elseif Source == "Cp" then
			if type(Divisor) == "number" then -- iMod V, Cp, 1 : V << Cp % 1 / Read필요 
				CiMod_InputData_Error()
			elseif Divisor[4] == "V" then -- iMod V, Cp, X : V << Cp % X / Read필요 
				CiMod_InputData_Error()
			else
				CiMod_InputData_Error()
			end

		elseif Source[4] == "V" then
			if type(Divisor) == "number" then -- iMod V, X, 1 : V << X % 1
				CIfX(PlayerID,CtrigX(Source[1],Source[2],0x15C,Source[3],AtLeast,0x80000000))
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[5],0x15C,0,SetTo,1); -- Sflag
								SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0);
								SetCtrig1X("X",CRet[2],0x15C,0,SetTo,0xFFFFFFFF);
								SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[2],0x15C,1,0);
								SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
								SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
								CallLabelAlways(Source[1],Source[2],Source[3]);
							},
							flag = {Preserved}
						}
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[2],0x15C,0,Add,1);
							},
							flag = {Preserved}
						}
				CElseX()
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[5],0x15C,0,SetTo,0); -- Sflag
								SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0);
								SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[2],0x15C,1,0);
								SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
								SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
								CallLabelAlways(Source[1],Source[2],Source[3]);
							},
							flag = {Preserved}
						}
				CIfXEnd()

				if bit32.band(Divisor,0xFFFFFFFF) >= 0x80000000 then
					Divisor = 0 - Divisor
				end
				local Block = 0
				for i = 0, Bit do
					local CBit = 2^i
					if  bit32.band(Divisor*CBit,0xFFFFFFFF) >= 0x80000000 then
						Block = i
					end
				end
				for i = Block, 0, -1 do
					local CBit = 2^i
						Trigger {
								players = {ParsePlayer(PlayerID)},
								conditions = {
									Label(0);
									CtrigX("X",CRet[2],0x15C,0,AtLeast,Divisor*CBit);
								},
								actions = {
									SetCtrig1X("X",CRet[2],0x15C,0,Subtract,Divisor*CBit);
									SetCtrig1X("X",CRet[1],0x15C,0,Add,CBit);
								},
								flag = {Preserved}
							}
				end
				CIfX(PlayerID,CtrigX("X",CRet[5],0x15C,0,Exactly,0x1,0x1)) -- Sflag == 1
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,0xFFFFFFFF,Mask);
								SetCtrigX("X",CRet[2],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
								SetCtrig1X("X",CRet[2],0x148,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[2],0x160,0,SetTo,Subtract*16777216,0xFF000000);
								CallLabelAlways("X",CRet[2],0);
							},
							flag = {Preserved}
						}
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,1);
							},
							flag = {Preserved}
						}
				CElseX()
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrigX("X",CRet[2],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
								SetCtrig1X("X",CRet[2],0x148,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
								CallLabelAlways("X",CRet[2],0);
							},
							flag = {Preserved}
						}
				CIfXEnd()

			elseif Divisor[4] == "V" then -- iMod V, X, Y : V << X % Y
				CIfX(PlayerID,CtrigX(Divisor[1],Divisor[2],0x15C,Divisor[3],AtLeast,0x80000000))
					Trigger { -- Y -> CRet[1] Act#1 
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0xFFFFFFFF);
								SetCtrigX(Divisor[1],Divisor[2],0x158,Divisor[3],SetTo,"X",CRet[1],0x15C,1,0);
								SetCtrig1X(Divisor[1],Divisor[2],0x148,Divisor[3],SetTo,0xFFFFFFFF);
								SetCtrig1X(Divisor[1],Divisor[2],0x160,Divisor[3],SetTo,Subtract*16777216,0xFF000000);
								CallLabelAlways(Divisor[1],Divisor[2],Divisor[3]);
							},
							flag = {Preserved}
						}

					Trigger { -- Y -> CRet[1] Act#2 
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrigX(Divisor[1],Divisor[2],0x158,Divisor[3],SetTo,"X",CRet[1],0x17C,1,0);
								CallLabelAlways(Divisor[1],Divisor[2],Divisor[3]);
								SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
								SetCtrig1X("X",CRet[1],0x168,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x180,0,SetTo,Add*16777216,0xFF000000);
								SetCtrig1X("X",CRet[1],0x184,0,SetTo,0,0x2);
							},
							flag = {Preserved}
						}
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[1],0x15C,0,Add,1);
								SetCtrig1X("X",CRet[1],0x17C,0,Add,1);
							},
							flag = {Preserved}
						}
				CElseX()
					Trigger { -- Y -> CRet[1] Act#1 
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrigX(Divisor[1],Divisor[2],0x158,Divisor[3],SetTo,"X",CRet[1],0x15C,1,0);
								SetCtrig1X(Divisor[1],Divisor[2],0x148,Divisor[3],SetTo,0xFFFFFFFF);
								SetCtrig1X(Divisor[1],Divisor[2],0x160,Divisor[3],SetTo,SetTo*16777216,0xFF000000);
								CallLabelAlways(Divisor[1],Divisor[2],Divisor[3]);
							},
							flag = {Preserved}
						}

					Trigger { -- Y -> CRet[1] Act#2 
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrigX(Divisor[1],Divisor[2],0x158,Divisor[3],SetTo,"X",CRet[1],0x17C,1,0);
								CallLabelAlways(Divisor[1],Divisor[2],Divisor[3]);
								SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
								SetCtrig1X("X",CRet[1],0x168,0,SetTo,0xFFFFFFFF);
								SetCtrig1X("X",CRet[1],0x180,0,SetTo,Add*16777216,0xFF000000);
								SetCtrig1X("X",CRet[1],0x184,0,SetTo,0,0x2);
							},
							flag = {Preserved}
						}
				CIfXEnd()

				CIfX(PlayerID,CtrigX(Source[1],Source[2],0x15C,Source[3],AtLeast,0x80000000))
					Trigger { -- X -> CRet[2] (-2)
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
							SetCtrig1X("X",CRet[5],0x15C,0,SetTo,1); -- Sflag
							SetCtrig1X("X",CRet[2],0x15C,0,SetTo,0xFFFFFFFF);
							SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[2],0x15C,1,0);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
							CallLabelAlways(Source[1],Source[2],Source[3]);
							SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0); -- Clear Ret
							SetCtrigX("X",FuncAlloc,0x1BC,2,SetTo,"X",FuncAlloc,0x0,0,3); -- Init Var1 Act#4 Value
							SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2); --  Init Var2 -> Var1
							},
							flag = {Preserved}
						}
					Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								SetCtrig1X("X",CRet[2],0x15C,0,Add,1);
							},
							flag = {Preserved}
						}
				CElseX()
					Trigger { -- X -> CRet[2] (-1)
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
							SetCtrig1X("X",CRet[5],0x15C,0,SetTo,0); -- Sflag
							SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[2],0x15C,1,0);
							SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
							SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways(Source[1],Source[2],Source[3]);
							SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0); -- Clear Ret
							SetCtrigX("X",FuncAlloc,0x1BC,2,SetTo,"X",FuncAlloc,0x0,0,3); -- Init Var1 Act#4 Value
							SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2); --  Init Var2 -> Var1
							},
							flag = {Preserved}
						}
				CIfXEnd()

				local ClearValue = {}
				for i = 0, Bit do
					table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x24,(Bit+4)+i,SetTo,0))
					table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x15C,(Bit+4)+i,SetTo,0))
				end

				Trigger { -- Clear Value 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(FuncAlloc);
						},
						actions = {
							ClearValue,
						},
						flag = {Preserved}
					}


				Trigger { -- local Var2 (1)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
							CtrigX("X",CRet[1],0x15C,0,AtLeast,0x80000000);
						},
						actions = {
							SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2*Bit+4);
						},
						flag = {Preserved}
					}

				Trigger { -- local Var1 (2)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[1],0x15C,1,0);
							SetCtrigX("X",CRet[1],0x178,0,SetTo,"X",CRet[1],0x17C,1,0);
							SetCtrig1X("X",FuncAlloc,0x1BC,2,Add,0x970);
							SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,3);
						},
						flag = {Preserved}
					}

				for i = 0, Bit do
					Trigger { -- (3 ~ Bit+3)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",FuncAlloc,0x24,1,2*Bit+4-i);
							SetCtrigX("X",CRet[1],0x178,0,SetTo,"X",FuncAlloc,0x15C,1,2*Bit+4-i);
							SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,1);
							SetCtrigX("X",FuncAlloc,0x15C,1,SetTo,"X",FuncAlloc,0x0,0,2*Bit+4-i);
						},
						flag = {Preserved}
					}
				end

				PlayerID = PlayerConvert(PlayerID)
				for k, P in pairs(PlayerID) do
					table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,0,SetTo,"X",FuncAlloc,0x0,0,3)) --> Create Local Var
					for i = 2, (Bit+3) do
						table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,i,SetTo,"X",CRet[1],0x0,0,0)) -- -> VarX
					end
				end

				for i = 0, Bit do
					local CBit = 2^(Bit-i)
					Trigger { -- (Bit+4 ~ 2*Bit+4)
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
							CtrigX("X",CRet[2],0x15C,0,AtLeast,0);
						},
						actions = {
							SetCtrig1X("X",CRet[2],0x15C,0,Subtract,0);
							SetCtrig1X("X",CRet[3],0x15C,0,Add,CBit);
						},
						flag = {Preserved}
					}
				end

				CIfX(PlayerID,CtrigX("X",CRet[5],0x15C,0,Exactly,0x1,0x1)) -- Sflag == 1
					Trigger { 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x178,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x180,0,SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x2,0x2);
							SetCtrigX("X",CRet[2],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							SetCtrig1X("X",CRet[2],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[2],0x160,0,SetTo,Subtract*16777216,0xFF000000);
							CallLabelAlways("X",CRet[2],0);
							SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,0xFFFFFFFF);
						},
						flag = {Preserved}
					}
					Trigger { 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],Add,1);
						},
						flag = {Preserved}
					}
				CElseX()
					Trigger { 
						players = {ParsePlayer(PlayerID)},
						conditions = {
							Label(0);
						},
						actions = {
							SetCtrig1X("X",CRet[1],0x178,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0x0);
							SetCtrig1X("X",CRet[1],0x180,0,SetTo,SetTo*16777216,0xFF000000);
							SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x2,0x2);
							SetCtrigX("X",CRet[2],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
							SetCtrig1X("X",CRet[2],0x148,0,SetTo,0xFFFFFFFF);
							SetCtrig1X("X",CRet[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
							CallLabelAlways("X",CRet[2],0);
						},
						flag = {Preserved}
					}
				CIfXEnd()

				FuncAlloc = FuncAlloc + 1
			else
				CiMod_InputData_Error()
			end

		else 
			if type(Divisor) == "number" then -- iMod V, Mem, 1 : V << Mem % 1 / Read필요
				CiMod_InputData_Error()
			elseif Divisor[4] == "V" then -- iMod V, Mem, X : V << Mem % X / Read필요
				CiMod_InputData_Error()
			else
				CiMod_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	else
		CiMod_InputData_Error()
	end
end

function CNot(PlayerID,Dest,Source,Mask)
	STPopTrigArr(PlayerID)
	if Mask == "X" then
		Mask = nil
	end

	if Mask == nil then
		Mask = 0xFFFFFFFF
	end

	if Source == nil then
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[8],0,"V"}
			MovX(PlayerID,Dest,PDest)
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			CNot_InputData_Error()
		end

		if type(Dest) == "number" then -- Not 0x58A364 / Read필요
			CNot_InputData_Error()
		elseif Dest == "Cp" then -- Not Cp / Read필요
			CNot_InputData_Error()
		elseif Dest[4] == "V" then -- Not X : X << ~X
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[1],0x15C,1,0);
					SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,Subtract*16777216,0xFF000000);
					SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0xFFFFFFFF);
					CallLabelAlways(Dest[1],Dest[2],Dest[3]);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
					SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways("X",CRet[1],0);
				},
				flag = {Preserved}
			}
		else -- Neg Mem / Read필요
			CNot_InputData_Error()
		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	elseif Dest[4] == "V" or Dest[4] == "VA" then
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CNot_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[8],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			CNot_InputData_Error()
		end
		if type(Dest) == "number" then
			CNot_InputData_Error()
		elseif Dest == "Cp" then
			CNot_InputData_Error()
		elseif Dest[4] == "V" then
			if type(Source) == "number" then
				CNot_InputData_Error()
			elseif Source[4] == "V" then -- Not V, X : V << ~X
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,Mask);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
						SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,Mask);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
			else
				CNot_InputData_Error()
			end
		else
			CNot_InputData_Error()
		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	else
		CNot_InputData_Error()
	end
end

function COr(PlayerID,Dest,Source,Operand,Mask)
	STPopTrigArr(PlayerID)
	if Mask == "X" then
		Mask = nil
	end

	if Mask == nil then
		Mask = 0xFFFFFFFF
	end

	if Operand == nil then
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			COr_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[8],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			COr_InputData_Error()
		end
		if type(Dest) == "number" then -- Or 0x58A364, 1 : 0x58A364 |= 1
			if type(Source) == "number" then
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetMemoryX(Dest,SetTo,0xFFFFFFFF,Source);
					},
					flag = {Preserved}
				}
			elseif Source[4] == "V" then -- Or 0x58A364, X : 0x58A364 |= X
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x148,1,0);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						SetCtrig1X("X",CRet[1],0x158,0,SetTo,EPD(Dest));
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
			else
				COr_InputData_Error()
			end

		elseif Dest == "Cp" then
			if type(Source) == "number" then -- Or Cp, 1 : Cp |= 1
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetDeathsX(CurrentPlayer,SetTo,0xFFFFFFFF,0,Source);
					},
					flag = {Preserved}
				}
			elseif Source[4] == "V" then -- Or Cp, X : Cp |= X
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x148,1,0);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						SetCtrig1X("X",CRet[1],0x158,0,SetTo,13);
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
			else
				COr_InputData_Error()
			end

		elseif Dest[4] == "V" then
			if type(Source) == "number" then -- Or X, 1 : X |= 1
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,0xFFFFFFFF,Source);
					},
					flag = {Preserved}
				}
			elseif Source[4] == "V" then -- Or X, Y : X |= Y
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x148,1,0);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
			else
				COr_InputData_Error()
			end

		else 
			if type(Source) == "number" then -- Or Mem, 1 : Mem |= 1
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],SetTo,0xFFFFFFFF,Source);
					},
					flag = {Preserved}
				}
			elseif Source[4] == "V" then -- Or Mem, X : Mem |= X
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x148,1,0);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],Dest[3],1,Dest[4]);
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
			else
				COr_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	elseif Dest[4] == "V" or Dest[4] == "VA" then
		if type(Operand) == "table" and Operand[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Operand)
			Operand = TempRet
		end
		if type(Operand) == "table" and Operand[4] == "A" then
			COr_InputData_Error()
		end
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[8],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			COr_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[9],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			COr_InputData_Error()
		end

		if type(Source) == "number" then -- Or V, 0x58A364, 1 : V << 0x58A364 | 1 / Read필요
			if type(Operand) == "number" then
				COr_InputData_Error()
			elseif Operand[4] == "V" then -- Or V, 0x58A364, X : V << 0x58A364 | X / Read필요
				COr_InputData_Error()
			else
				COr_InputData_Error()
			end

		elseif Source == "Cp" then
			if type(Operand) == "number" then -- Or V, Cp, 1 : V << Cp | 1 / Read필요 
				COr_InputData_Error()
			elseif Operand[4] == "V" then -- Or V, Cp, X : V << Cp | X / Read필요 
				COr_InputData_Error()
			else
				COr_InputData_Error()
			end

		elseif Source[4] == "V" then
			if type(Operand) == "number" then -- Or V, X, 1 : V << X | 1
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,Mask);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,0xFFFFFFFF,Operand);
					},
					flag = {Preserved}
				}
			elseif Operand[4] == "V" then -- Or V, X, Y : V << X | Y
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,Mask);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Operand[1],Operand[2],0x158,Operand[3],SetTo,"X",CRet[1],0x148,1,0);
						SetCtrig1X(Operand[1],Operand[2],0x148,Operand[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Operand[1],Operand[2],0x160,Operand[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Operand[1],Operand[2],Operand[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
			else
				COr_InputData_Error()
			end

		else 
			if type(Operand) == "number" then -- Or V, Mem, 1 : V << Mem | 1 / Read필요
				COr_InputData_Error()
			elseif Operand[4] == "V" then -- Or V, Mem, X : V << Mem | X / Read필요
				COr_InputData_Error()
			else
				COr_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	else
		COr_InputData_Error()
	end
end

function CAnd(PlayerID,Dest,Source,Operand,Mask)
	STPopTrigArr(PlayerID)
	if Mask == "X" then
		Mask = nil
	end

	if Mask == nil then
		Mask = 0xFFFFFFFF
	end

	if Operand == nil then
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CAnd_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[8],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			CAnd_InputData_Error()
		end
		if type(Dest) == "number" then -- And 0x58A364, 1 : 0x58A364 &= 1
			if type(Source) == "number" then
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetMemoryX(Dest,SetTo,0,(0xFFFFFFFF-Source));
					},
					flag = {Preserved}
				}
			elseif Source[4] == "V" then -- And 0x58A364, X : 0x58A364 &= X
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x148,1,0);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						SetCtrig1X("X",CRet[1],0x158,0,SetTo,EPD(Dest));
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
			else
				CAnd_InputData_Error()
			end

		elseif Dest == "Cp" then
			if type(Source) == "number" then -- And Cp, 1 : Cp &= 1
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetDeathsX(CurrentPlayer,SetTo,0,0,(0xFFFFFFFF-Source));
					},
					flag = {Preserved}
				}
			elseif Source[4] == "V" then -- And Cp, X : Cp &= X
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x148,1,0);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						SetCtrig1X("X",CRet[1],0x158,0,SetTo,13);
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
			else
				CAnd_InputData_Error()
			end

		elseif Dest[4] == "V" then
			if type(Source) == "number" then -- And X, 1 : X &= 1
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,0,(0xFFFFFFFF-Source));
					},
					flag = {Preserved}
				}
			elseif Source[4] == "V" then -- And X, Y : X &= Y
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x148,1,0);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
			else
				CAnd_InputData_Error()
			end

		else 
			if type(Source) == "number" then -- And Mem, 1 : Mem &= 1
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X(Dest[1],Dest[2],Dest[3],Dest[4],SetTo,0,(0xFFFFFFFF-Source));
					},
					flag = {Preserved}
				}
			elseif Source[4] == "V" then -- And Mem, X : Mem &= X
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x148,1,0);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],Dest[3],1,Dest[4]);
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
			else
				CAnd_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	elseif Dest[4] == "V" or Dest[4] == "VA" then
		if type(Operand) == "table" and Operand[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Operand)
			Operand = TempRet
		end
		if type(Operand) == "table" and Operand[4] == "A" then
			CAnd_InputData_Error()
		end
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[8],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CAnd_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[9],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			CAnd_InputData_Error()
		end

		if type(Source) == "number" then -- And V, 0x58A364, 1 : V << 0x58A364 & 1 / Read필요
			if type(Operand) == "number" then
				CAnd_InputData_Error()
			elseif Operand[4] == "V" then -- And V, 0x58A364, X : V << 0x58A364 & X / Read필요
				CAnd_InputData_Error()
			else
				CAnd_InputData_Error()
			end

		elseif Source == "Cp" then
			if type(Operand) == "number" then -- And V, Cp, 1 : V << Cp & 1 / Read필요 
				CAnd_InputData_Error()
			elseif Operand[4] == "V" then -- And V, Cp, X : V << Cp & X / Read필요 
				CAnd_InputData_Error()
			else
				CAnd_InputData_Error()
			end

		elseif Source[4] == "V" then
			if type(Operand) == "number" then -- And V, X, 1 : V << X & 1
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,Mask);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,0,(0xFFFFFFFF-Operand));
					},
					flag = {Preserved}
				}
			elseif Operand[4] == "V" then -- And V, X, Y : V << X & Y
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,Mask);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrigX(Operand[1],Operand[2],0x158,Operand[3],SetTo,"X",CRet[1],0x148,1,0);
						SetCtrig1X(Operand[1],Operand[2],0x148,Operand[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Operand[1],Operand[2],0x160,Operand[3],SetTo,Subtract*16777216,0xFF000000);
						CallLabelAlways(Operand[1],Operand[2],Operand[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
			else
				CAnd_InputData_Error()
			end

		else 
			if type(Operand) == "number" then -- And V, Mem, 1 : V << Mem & 1 / Read필요
				CAnd_InputData_Error()
			elseif Operand[4] == "V" then -- And V, Mem, X : V << Mem & X / Read필요
				CAnd_InputData_Error()
			else
				CAnd_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	else
		CAnd_InputData_Error()
	end
end

function CXor(PlayerID,Dest,Source,Operand,Mask)
		STPopTrigArr(PlayerID)
	if Mask == "X" then
		Mask = nil
	end

	if Mask == nil then
		Mask = 0xFFFFFFFF
	end

	if Operand == nil then
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CXor_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[8],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			CXor_InputData_Error()
		end
		if type(Dest) == "number" then -- Xor 0x58A364, 1 : 0x58A364 ^= 1 / Read필요
			if type(Source) == "number" then
				CXor_InputData_Error()
			elseif Source[4] == "V" then -- Xor 0x58A364, X : 0x58A364 ^= X / Read필요
				CXor_InputData_Error()
			else
				CXor_InputData_Error()
			end

		elseif Dest == "Cp" then
			if type(Source) == "number" then -- Xor Cp, 1 : Cp ^= 1 / Read필요
				CXor_InputData_Error()
			elseif Source[4] == "V" then -- Xor Cp, X : Cp ^= X / Read필요
				CXor_InputData_Error()
			else
				CXor_InputData_Error()
			end

		elseif Dest[4] == "V" then
			if type(Source) == "number" then -- Xor X, 1 : X ^= 1
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[1],0x15C,1,0);
						SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Dest[1],Dest[2],Dest[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,0xFFFFFFFF,Source);
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0,(0xFFFFFFFF-Source));
						SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,Subtract*16777216,0xFF000000);
						CallLabelAlways("X",CRet[1],0);

					},
					flag = {Preserved}
				}
			elseif Source[4] == "V" then -- Xor X, Y : X ^= Y
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[1],0x15C,1,0);
						SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Dest[1],Dest[2],Dest[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[2],0x148,1,0);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[2],0x15C,0,SetTo,0xFFFFFFFF);
						SetCtrigX("X",CRet[2],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X("X",CRet[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways("X",CRet[2],0);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[2],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[2],0x148,1,0);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,Subtract*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[2],0x15C,0,SetTo,0);
						SetCtrigX("X",CRet[2],0x158,0,SetTo,"X",CRet[1],0x15C,1,0);
						SetCtrig1X("X",CRet[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways("X",CRet[2],0);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,Subtract*16777216,0xFF000000);
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
			else
				CXor_InputData_Error()
			end

		else 
			if type(Source) == "number" then -- Xor Mem, 1 : Mem ^= 1 / Read필요
				CXor_InputData_Error()
			elseif Source[4] == "V" then -- Xor Mem, X : Mem ^= X / Read필요
				CXor_InputData_Error()
			else
				CXor_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	elseif Dest[4] == "V" or Dest[4] == "VA" then
		if type(Operand) == "table" and Operand[4] == "VA" then
			local TempRet = {"X",CRet[7],0,"V"}
			MovX(PlayerID,TempRet,Operand)
			Operand = TempRet
		end
		if type(Operand) == "table" and Operand[4] == "A" then
			CXor_InputData_Error()
		end
		if type(Source) == "table" and Source[4] == "VA" then
			local TempRet = {"X",CRet[8],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		end
		if type(Source) == "table" and Source[4] == "A" then
			CXor_InputData_Error()
		end
		local PDest
		if type(Dest) == "table" and Dest[4] == "VA" then
			PDest = Dest
			Dest = {"X",CRet[9],0,"V"}
		end
		if type(Dest) == "table" and Dest[4] == "A" then
			CXor_InputData_Error()
		end
		if type(Source) == "number" then -- Xor V, 0x58A364, 1 : V << 0x58A364 ^ 1 / Read필요
			if type(Operand) == "number" then
				CXor_InputData_Error()
			elseif Operand[4] == "V" then -- Xor V, 0x58A364, X : V << 0x58A364 ^ X / Read필요
				CXor_InputData_Error()
			else
				CXor_InputData_Error()
			end

		elseif Source == "Cp" then
			if type(Operand) == "number" then -- Xor V, Cp, 1 : V << Cp ^ 1 / Read필요 
				CXor_InputData_Error()
			elseif Operand[4] == "V" then -- Xor V, Cp, X : V << Cp ^ X / Read필요 
				CXor_InputData_Error()
			else
				CXor_InputData_Error()
			end

		elseif Source[4] == "V" then
			if type(Operand) == "number" then -- Xor V, X, 1 : V << X ^ 1
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,Mask);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X(Dest[1],Dest[2],0x15C,Dest[3],SetTo,0xFFFFFFFF,Operand);
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0,(0xFFFFFFFF-Operand));
						SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,Mask);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,Subtract*16777216,0xFF000000);
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
			elseif Operand[4] == "V" then -- Xor V, X, Y : V << X ^ Y
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
						SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Source[1],Source[2],Source[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX(Operand[1],Operand[2],0x158,Operand[3],SetTo,"X",CRet[2],0x148,1,0);
						SetCtrig1X(Operand[1],Operand[2],0x148,Operand[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Operand[1],Operand[2],0x160,Operand[3],SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways(Operand[1],Operand[2],Operand[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[2],0x15C,0,SetTo,0xFFFFFFFF);
						SetCtrigX("X",CRet[2],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X("X",CRet[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways("X",CRet[2],0);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[2],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrigX(Operand[1],Operand[2],0x158,Operand[3],SetTo,"X",CRet[2],0x148,1,0);
						SetCtrig1X(Operand[1],Operand[2],0x148,Operand[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Operand[1],Operand[2],0x160,Operand[3],SetTo,Subtract*16777216,0xFF000000);
						CallLabelAlways(Operand[1],Operand[2],Operand[3]);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[2],0x15C,0,SetTo,0);
						SetCtrigX("X",CRet[2],0x158,0,SetTo,"X",CRet[1],0x15C,1,0);
						SetCtrig1X("X",CRet[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways("X",CRet[2],0);
					},
					flag = {Preserved}
				}
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX("X",CRet[1],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,Mask);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,Subtract*16777216,0xFF000000);
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
			else
				CXor_InputData_Error()
			end

		else 
			if type(Operand) == "number" then -- Xor V, Mem, 1 : V << Mem ^ 1 / Read필요
				CXor_InputData_Error()
			elseif Operand[4] == "V" then -- Xor V, Mem, X : V << Mem ^ X / Read필요
				CXor_InputData_Error()
			else
				CXor_InputData_Error()
			end

		end
		if PDest ~= nil then
			MovX(PlayerID,PDest,Dest)
		end
	else
		CXor_InputData_Error()
	end
end		


-- 함수 호출형 함수 정의 선언 (Include) -------------------------------------------------

function Include_CtrigPlib(Cycle,SeedSwitch,Flag)
	Include_DataTransfer(Flag)
	Include_ArithMetic()
	Include_MatheMatics(Cycle)
	Include_MiscFunctions(SeedSwitch)
end

FReadCall1 = 0
FEPDCall1 = 0
FReadCall2 = 0
FEPDCall2 = 0
FMEM = {}
FMEMCall0 = 0
FMEMCall1 = 0
FMEMCall2 = 0
FMEME = {}
FMEMECall1 = 0
FMEMECall2 = 0
FReadXCall0 = 0
FReadXCall1 = 0
FReadXCall2 = 0
FReadXCall3 = 0
FReadXCall4 = 0
FReadXCall5 = 0
FReadXCall6 = 0
FReadXCall7 = 0
FMOVE = {}
FMOVECall0 = 0
FMOVECall1 = 0
FMOVECall2 = 0
function Include_DataTransfer(Flag) -- f_Read / f_EPD / f_Memcpy
-- f_Read - Ret[1] : Input EPD / Ret[2] = Output / Ret[3] = EPD(Output)

	Trigger {
			players = {AllPlayers},
			conditions = {
				Label(FuncAlloc);
			},
			actions = {
				SetCtrig1X("X",CRet[2],0x15C,0,SetTo,0);
				SetCtrig1X("X",CRet[3],0x15C,0,SetTo,-1452249);
				SetCtrig1X("X",CRet[1],0x158,0,SetTo,EPD(0x6509B0));
				SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways("X",CRet[1],0);
			},
			flag = {Preserved}
		}
	

	for i = 0, 31 do
		local CBit = 2^i
		Trigger {
				players = {AllPlayers},
				conditions = {
					Label(0);
				   	DeathsX(CurrentPlayer,Exactly,CBit,0,CBit);
				},
				actions = {
				SetCtrig1X("X",CRet[2],0x15C,0,Add,CBit);
				SetCtrig1X("X",CRet[3],0x15C,0,Add,CBit/4);
				},
				flag = {Preserved}
			}
	end

	Trigger {
			players = {AllPlayers},
			conditions = {
				Label(FuncAlloc+1);
			},
			actions = {
			},
			flag = {Preserved}
		}

	FReadCall1 = FuncAlloc
	FReadCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

-- f_ReadX - Ret[1] : Input EPD / Ret[2] = Output / Ret[3] = EPD(Output)

	Trigger {
			players = {AllPlayers},
			conditions = {
				Label(FuncAlloc);
			},
			actions = {
				SetCtrig1X("X",CRet[1],0x158,0,SetTo,EPD(0x6509B0));
				SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways("X",CRet[1],0);
			},
			flag = {Preserved}
		}
	Trigger { -- 1
			players = {AllPlayers},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",CRet[2],0x15C,0,SetTo,0);
			},
			flag = {Preserved}
		}

	FReadXCall0 = FuncAlloc
	FuncAlloc = FuncAlloc + 1
	local XLabel

-- *16777216 (0 -> 3)
	for i = 0, 7 do
		if i == 0  then
			XLabel = FuncAlloc
		else
			XLabel = 0
		end
		local CBit = 2^i
		Trigger { 
				players = {AllPlayers},
				conditions = {
					Label(XLabel);
				   	DeathsX(CurrentPlayer,Exactly,CBit,0,CBit);
				},
				actions = {
				SetCtrig1X("X",CRet[2],0x15C,0,Add,CBit*16777216);
				},
				flag = {Preserved}
			}
	end
	FReadXCall1 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

-- *65536 (01 -> 23)
	for i = 0, 15 do
		if i == 0  then
			XLabel = FuncAlloc
		else
			XLabel = 0
		end
		local CBit = 2^i
		Trigger { 
				players = {AllPlayers},
				conditions = {
					Label(XLabel);
				   	DeathsX(CurrentPlayer,Exactly,CBit,0,CBit);
				},
				actions = {
				SetCtrig1X("X",CRet[2],0x15C,0,Add,CBit*65536);
				},
				flag = {Preserved}
			}
	end
	FReadXCall2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

-- *256 (012 -> 123)
	for i = 0, 23 do
		if i == 0  then
			XLabel = FuncAlloc
		else
			XLabel = 0
		end
		local CBit = 2^i
		Trigger { 
				players = {AllPlayers},
				conditions = {
					Label(XLabel);
				   	DeathsX(CurrentPlayer,Exactly,CBit,0,CBit);
				},
				actions = {
				SetCtrig1X("X",CRet[2],0x15C,0,Add,CBit*256);
				},
				flag = {Preserved}
			}
	end
	FReadXCall3 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

-- 1 (0123 -> 0123)
	for i = 0, 31 do
		if i == 0  then
			XLabel = FuncAlloc
		else
			XLabel = 0
		end
		local CBit = 2^i
		Trigger { 
				players = {AllPlayers},
				conditions = {
					Label(XLabel);
				   	DeathsX(CurrentPlayer,Exactly,CBit,0,CBit);
				},
				actions = {
				SetCtrig1X("X",CRet[2],0x15C,0,Add,CBit);
				},
				flag = {Preserved}
			}
	end
	FReadXCall4 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

-- /256 (123 -> 012)
	for i = 8, 31 do
		if i == 8  then
			XLabel = FuncAlloc
		else
			XLabel = 0
		end
		local CBit = 2^i
		Trigger { 
				players = {AllPlayers},
				conditions = {
					Label(XLabel);
				   	DeathsX(CurrentPlayer,Exactly,CBit,0,CBit);
				},
				actions = {
				SetCtrig1X("X",CRet[2],0x15C,0,Add,CBit/256);
				},
				flag = {Preserved}
			}
	end
	FReadXCall5 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

-- /65536 (23 -> 01)
	for i = 16, 31 do
		if i == 16  then
			XLabel = FuncAlloc
		else
			XLabel = 0
		end
		local CBit = 2^i
		Trigger { 
				players = {AllPlayers},
				conditions = {
					Label(XLabel);
				   	DeathsX(CurrentPlayer,Exactly,CBit,0,CBit);
				},
				actions = {
				SetCtrig1X("X",CRet[2],0x15C,0,Add,CBit/65536);
				},
				flag = {Preserved}
			}
	end
	FReadXCall6 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

-- /16777216 (3 -> 0)
	for i = 24, 31 do
		if i == 24  then
			XLabel = FuncAlloc
		else
			XLabel = 0
		end
		local CBit = 2^i
		Trigger { 
				players = {AllPlayers},
				conditions = {
					Label(XLabel);
				   	DeathsX(CurrentPlayer,Exactly,CBit,0,CBit);
				},
				actions = {
				SetCtrig1X("X",CRet[2],0x15C,0,Add,CBit/16777216);
				},
				flag = {Preserved}
			}
	end
	FReadXCall7 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

-- f_EPD - Ret[1] : Input X / Ret[2] = Output | Output = EPD(X)

	Trigger {
			players = {AllPlayers},
			conditions = {
				Label(FuncAlloc);
			},
			actions = {
				SetCtrig1X("X",CRet[2],0x15C,0,SetTo,-1452249);
			},
			flag = {Preserved}
		}

	for i = 2, 31 do
		local CBit = 2^i
		Trigger {
				players = {AllPlayers},
				conditions = {
					Label(0);
				   	CtrigX("X",CRet[1],0x15C,0,Exactly,CBit,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[2],0x15C,0,Add,CBit/4);
				},
				flag = {Preserved}
			}
	end

	Trigger {
			players = {AllPlayers},
			conditions = {
				Label(FuncAlloc+1);
			},
			actions = {
			},
			flag = {Preserved}
		}

	FEPDCall1 =	FuncAlloc
	FEPDCall2 =	FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

-- f_Movcpy(EPD) - Ret[1] : Input Dest / Ret[2] : Source Offset / Ret[3] = Size / Ret[4] << Init Mask

	for i = 0, 3 do
		CVariable(AllPlayers,FuncAlloc+i)
		table.insert(FMOVE,FuncAlloc+i)
	end
	FuncAlloc = FuncAlloc + 4

	Trigger {
		players = {AllPlayers},
		conditions = {
			Label(FuncAlloc);
		},
		flag = {Preserved}
	}
	FMOVECall0 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

	CDiv(AllPlayers,V(FMOVE[1]),4) 
	CMov(AllPlayers,V(FMOVE[4]),V(CRet[2]))

	Trigger {
				players = {AllPlayers},
				conditions = {
					Label(0);
					CVar("X",FMOVE[4],Exactly,0);
				},
				actions = {
					SetCVar("X",FMOVE[4],SetTo,0xFFFFFFFF);
					SetCVar("X",FMOVE[1],Add,0-1452249);
				},
				flag = {Preserved}
			}
	Trigger {
				players = {AllPlayers},
				conditions = {
					Label(0);
					CVar("X",FMOVE[4],Exactly,1);
				},
				actions = {
					SetCVar("X",FMOVE[4],SetTo,0xFFFFFF00);
					SetCVar("X",FMOVE[1],Add,0-1452249);
				},
				flag = {Preserved}
			}
	Trigger {
				players = {AllPlayers},
				conditions = {
					Label(0);
					CVar("X",FMOVE[4],Exactly,2);
				},
				actions = {
					SetCVar("X",FMOVE[4],SetTo,0xFFFF0000);
					SetCVar("X",FMOVE[1],Add,0-1452249);
				},
				flag = {Preserved}
			}
	Trigger {
				players = {AllPlayers},
				conditions = {
					Label(0);
					CVar("X",FMOVE[4],Exactly,3);
				},
				actions = {
					SetCVar("X",FMOVE[4],SetTo,0xFF000000);
					SetCVar("X",FMOVE[1],Add,0-1452249);
				},
				flag = {Preserved}
			}

	Trigger {
		players = {AllPlayers},
		conditions = {
			Label(FuncAlloc);
		},
		flag = {Preserved}
	}
	FMOVECall1 = FuncAlloc
	FuncAlloc = FuncAlloc + 1


	CIfX(AllPlayers,CVar("X",FMOVE[3],AtLeast,4),SetCVar("X",FMOVE[3],Subtract,4))

		Trigger {--(CPRead)로 값 출력 (A)
				players = {AllPlayers},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X",FMOVE[2],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",FMOVE[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
					SetCtrigX("X",FMOVE[2],0x158,0,SetTo,"X",FuncAlloc,0x15C,1,0); 
					CallLabelAlways("X",FMOVE[2],0);
				},
				flag = {Preserved}
			}

		Trigger {
				players = {AllPlayers},
				conditions = { -- (B)
					Label(0);
				},
				actions = {
					SetCtrig1X("X",FMOVE[1],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",FMOVE[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
					SetCtrigX("X",FMOVE[1],0x158,0,SetTo,"X",FuncAlloc,0x19C,1,0); 
					CallLabelAlways("X",FMOVE[1],0);
				},
				flag = {Preserved}
			}


		Trigger {
				players = {AllPlayers},
				conditions = { -- (C)
					Label(0);
				},
				actions = {
					SetCtrig1X("X",FMOVE[4],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",FMOVE[4],0x160,0,SetTo,SetTo*16777216,0xFF000000);
					SetCtrigX("X",FMOVE[4],0x158,0,SetTo,"X",FuncAlloc,0x21C,1,0); 
					CallLabelAlways("X",FMOVE[4],0);
				},
				flag = {Preserved}
			}

		Trigger {
				players = {AllPlayers},
				conditions = {
					Label(FuncAlloc);
				},
				actions = {
					SetCtrig1X("X","X",0x4,0,SetTo,0); -- SetCtrigX("X","X",0x4,0,SetTo,VA[1],VA[2],0,0,VA[3]); 0x0 (A)
					SetMemory(0x6509B0,Add,(0x158-0x0)/4);
					SetDeaths(CurrentPlayer,SetTo,0,0);	-- SetCtrig1X(VA[1],VA[2],0x158,VA[3],SetTo,EPD(Dest)); EPD 0x158 (B)
					SetMemory(0x6509B0,Add,(0x4-0x158)/4);
					SetCtrig2X("Cp",SetTo,"X","X",0,0,1); -- SetCtrigX(VA[1],VA[2],0x4,VA[3],SetTo,"X","X",0,0,1); EPD 0x4
					SetMemory(0x6509B0,Add,(0x148-0x4)/4);
					SetDeaths(CurrentPlayer,SetTo,0,0); -- SetCtrig1X(VA[1],VA[2],0x148,VA[3],SetTo,InitMask); EPD 0x148 (C)
					SetMemory(0x6509B0,Add,(0x160-0x148)/4);
					SetDeathsX(CurrentPlayer,SetTo,SetTo*16777216,0,0xFF000000); -- SetCtrig1X(VA[1],VA[2],0x160,VA[3],SetTo,SetTo*16777216,0xFF000000); EPD 0x160
					SetMemory(0x6509B0,Add,(0x0-0x160)/4);
					SetMemory(0x6509B0,Add,(0x970)/4);
					SetCVar("X",FMOVE[2],Add,0x970);
					SetCVar("X",FMOVE[1],Add,1);
				},
				flag = {Preserved}
			}
	CIfXEnd()
	FuncAlloc = FuncAlloc + 1

	Trigger {--(CPRead)로 값 출력 (A)
				players = {AllPlayers},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X",FMOVE[2],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",FMOVE[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
					SetCtrigX("X",FMOVE[2],0x158,0,SetTo,"X",FuncAlloc,0x15C,1,0); 
					CallLabelAlways("X",FMOVE[2],0);
				},
				flag = {Preserved}
			}

	Trigger {
				players = {AllPlayers},
				conditions = { -- (B)
					Label(0);
				},
				actions = {
					SetCtrig1X("X",FMOVE[1],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",FMOVE[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
					SetCtrigX("X",FMOVE[1],0x158,0,SetTo,"X",FuncAlloc,0x19C,1,0); 
					CallLabelAlways("X",FMOVE[1],0);
				},
				flag = {Preserved}
			}

	CWhile(AllPlayers,CVar("X",FMOVE[3],AtLeast,4),SetCVar("X",FMOVE[3],Subtract,4))
		Trigger {
				players = {AllPlayers},
				conditions = {
					Label(FuncAlloc);
				},
				actions = {
					SetCtrig1X("X","X",0x4,0,SetTo,0); -- SetCtrigX("X","X",0x4,0,SetTo,VA[1],VA[2],0,0,VA[3]); 0x0 (A)
					SetMemory(0x6509B0,Add,(0x158-0x0)/4);
					SetDeaths(CurrentPlayer,SetTo,0,0);	-- SetCtrig1X(VA[1],VA[2],0x158,VA[3],SetTo,EPD(Dest)); EPD 0x158 (B)
					SetMemory(0x6509B0,Add,(0x4-0x158)/4);
					SetCtrig2X("Cp",SetTo,"X","X",0,0,1); -- SetCtrigX(VA[1],VA[2],0x4,VA[3],SetTo,"X","X",0,0,1); EPD 0x4
					SetMemory(0x6509B0,Add,(0x148-0x4)/4);
					SetDeaths(CurrentPlayer,SetTo,0xFFFFFFFF,0); -- SetCtrig1X(VA[1],VA[2],0x148,VA[3],SetTo,0xFFFFFFFF); EPD 0x148 
					SetMemory(0x6509B0,Add,(0x160-0x148)/4);
					SetDeathsX(CurrentPlayer,SetTo,SetTo*16777216,0,0xFF000000); -- SetCtrig1X(VA[1],VA[2],0x160,VA[3],SetTo,SetTo*16777216,0xFF000000); EPD 0x160
					SetMemory(0x6509B0,Add,(0x0-0x160)/4);
					SetMemory(0x6509B0,Add,(0x970)/4);
					SetCVar("X",FMOVE[2],Add,0x970);
					SetCtrig1X("X",FuncAlloc,0x15C,0,Add,0x970);
					SetCVar("X",FMOVE[1],Add,1);
					SetCtrig1X("X",FuncAlloc,0x19C,0,Add,1);
				},
				flag = {Preserved}
			}
	CWhileEnd()
	FuncAlloc = FuncAlloc + 1

	CIfX(AllPlayers,CVar("X",FMOVE[3],Exactly,3))
		Trigger {--(CPRead)로 값 출력 (A)
				players = {AllPlayers},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X",FMOVE[2],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",FMOVE[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
					SetCtrigX("X",FMOVE[2],0x158,0,SetTo,"X",FuncAlloc,0x15C,1,0); 
					CallLabelAlways("X",FMOVE[2],0);
				},
				flag = {Preserved}
			}

		Trigger {
				players = {AllPlayers},
				conditions = { -- (B)
					Label(0);
				},
				actions = {
					SetCtrig1X("X",FMOVE[1],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",FMOVE[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
					SetCtrigX("X",FMOVE[1],0x158,0,SetTo,"X",FuncAlloc,0x19C,1,0); 
					CallLabelAlways("X",FMOVE[1],0);
				},
				flag = {Preserved}
			}
		Trigger {
				players = {AllPlayers},
				conditions = {
					Label(FuncAlloc);
				},
				actions = {
					SetCtrig1X("X","X",0x4,0,SetTo,0); -- SetCtrigX("X","X",0x4,0,SetTo,VA[1],VA[2],0,0,VA[3]); 0x0 (A)
					SetMemory(0x6509B0,Add,(0x158-0x0)/4);
					SetDeaths(CurrentPlayer,SetTo,0,0);	-- SetCtrig1X(VA[1],VA[2],0x158,VA[3],SetTo,EPD(Dest)); EPD 0x158 (B)
					SetMemory(0x6509B0,Add,(0x4-0x158)/4);
					SetCtrig2X("Cp",SetTo,"X","X",0,0,1); -- SetCtrigX(VA[1],VA[2],0x4,VA[3],SetTo,"X","X",0,0,1); EPD 0x4
					SetMemory(0x6509B0,Add,(0x148-0x4)/4);
					SetDeaths(CurrentPlayer,SetTo,0x00FFFFFF,0); -- SetCtrig1X(VA[1],VA[2],0x148,VA[3],SetTo,InitMask); EPD 0x148 (C)
					SetMemory(0x6509B0,Add,(0x160-0x148)/4);
					SetDeathsX(CurrentPlayer,SetTo,SetTo*16777216,0,0xFF000000); -- SetCtrig1X(VA[1],VA[2],0x160,VA[3],SetTo,SetTo*16777216,0xFF000000); EPD 0x160
					SetMemory(0x6509B0,Add,(0x0-0x160)/4);
				},
				flag = {Preserved}
			}
		FuncAlloc = FuncAlloc + 1
	CElseIfX(CVar("X",FMOVE[3],Exactly,2))
		Trigger {--(CPRead)로 값 출력 (A)
				players = {AllPlayers},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X",FMOVE[2],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",FMOVE[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
					SetCtrigX("X",FMOVE[2],0x158,0,SetTo,"X",FuncAlloc,0x15C,1,0); 
					CallLabelAlways("X",FMOVE[2],0);
				},
				flag = {Preserved}
			}

		Trigger {
				players = {AllPlayers},
				conditions = { -- (B)
					Label(0);
				},
				actions = {
					SetCtrig1X("X",FMOVE[1],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",FMOVE[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
					SetCtrigX("X",FMOVE[1],0x158,0,SetTo,"X",FuncAlloc,0x19C,1,0); 
					CallLabelAlways("X",FMOVE[1],0);
				},
				flag = {Preserved}
			}
		Trigger {
				players = {AllPlayers},
				conditions = {
					Label(FuncAlloc);
				},
				actions = {
					SetCtrig1X("X","X",0x4,0,SetTo,0); -- SetCtrigX("X","X",0x4,0,SetTo,VA[1],VA[2],0,0,VA[3]); 0x0 (A)
					SetMemory(0x6509B0,Add,(0x158-0x0)/4);
					SetDeaths(CurrentPlayer,SetTo,0,0);	-- SetCtrig1X(VA[1],VA[2],0x158,VA[3],SetTo,EPD(Dest)); EPD 0x158 (B)
					SetMemory(0x6509B0,Add,(0x4-0x158)/4);
					SetCtrig2X("Cp",SetTo,"X","X",0,0,1); -- SetCtrigX(VA[1],VA[2],0x4,VA[3],SetTo,"X","X",0,0,1); EPD 0x4
					SetMemory(0x6509B0,Add,(0x148-0x4)/4);
					SetDeaths(CurrentPlayer,SetTo,0x0000FFFF,0); -- SetCtrig1X(VA[1],VA[2],0x148,VA[3],SetTo,InitMask); EPD 0x148 (C)
					SetMemory(0x6509B0,Add,(0x160-0x148)/4);
					SetDeathsX(CurrentPlayer,SetTo,SetTo*16777216,0,0xFF000000); -- SetCtrig1X(VA[1],VA[2],0x160,VA[3],SetTo,SetTo*16777216,0xFF000000); EPD 0x160
					SetMemory(0x6509B0,Add,(0x0-0x160)/4);
				},
				flag = {Preserved}
			}
		FuncAlloc = FuncAlloc + 1
	CElseIfX(CVar("X",FMOVE[3],Exactly,1))
		Trigger {--(CPRead)로 값 출력 (A)
				players = {AllPlayers},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X",FMOVE[2],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",FMOVE[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
					SetCtrigX("X",FMOVE[2],0x158,0,SetTo,"X",FuncAlloc,0x15C,1,0); 
					CallLabelAlways("X",FMOVE[2],0);
				},
				flag = {Preserved}
			}

		Trigger {
				players = {AllPlayers},
				conditions = { -- (B)
					Label(0);
				},
				actions = {
					SetCtrig1X("X",FMOVE[1],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",FMOVE[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
					SetCtrigX("X",FMOVE[1],0x158,0,SetTo,"X",FuncAlloc,0x19C,1,0); 
					CallLabelAlways("X",FMOVE[1],0);
				},
				flag = {Preserved}
			}
		Trigger {
				players = {AllPlayers},
				conditions = {
					Label(FuncAlloc);
				},
				actions = {
					SetCtrig1X("X","X",0x4,0,SetTo,0); -- SetCtrigX("X","X",0x4,0,SetTo,VA[1],VA[2],0,0,VA[3]); 0x0 (A)
					SetMemory(0x6509B0,Add,(0x158-0x0)/4);
					SetDeaths(CurrentPlayer,SetTo,0,0);	-- SetCtrig1X(VA[1],VA[2],0x158,VA[3],SetTo,EPD(Dest)); EPD 0x158 (B)
					SetMemory(0x6509B0,Add,(0x4-0x158)/4);
					SetCtrig2X("Cp",SetTo,"X","X",0,0,1); -- SetCtrigX(VA[1],VA[2],0x4,VA[3],SetTo,"X","X",0,0,1); EPD 0x4
					SetMemory(0x6509B0,Add,(0x148-0x4)/4);
					SetDeaths(CurrentPlayer,SetTo,0x000000FF,0); -- SetCtrig1X(VA[1],VA[2],0x148,VA[3],SetTo,InitMask); EPD 0x148 (C)
					SetMemory(0x6509B0,Add,(0x160-0x148)/4);
					SetDeathsX(CurrentPlayer,SetTo,SetTo*16777216,0,0xFF000000); -- SetCtrig1X(VA[1],VA[2],0x160,VA[3],SetTo,SetTo*16777216,0xFF000000); EPD 0x160
					SetMemory(0x6509B0,Add,(0x0-0x160)/4);
				},
				flag = {Preserved}
			}
		FuncAlloc = FuncAlloc + 1
	CIfXEnd()

	Trigger {
		players = {AllPlayers},
		conditions = {
			Label(FuncAlloc);
		},
		flag = {Preserved}
	}
	FMOVECall2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1
-- f_MemcpyEPD - Ret[1] : Input Dest / Ret[2] = Source / Ret[3] = Size / Ret[4] = VAflag

	for i = 0, 3 do
		CVariable(AllPlayers,FuncAlloc+i)
		table.insert(FMEME,FuncAlloc+i)
	end
	FuncAlloc = FuncAlloc + 4

	Trigger {
		players = {AllPlayers},
		conditions = {
			Label(FuncAlloc);
		},
		flag = {Preserved}
	}
	FMEMECall1 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

	CWhile(AllPlayers, CVar("X",FMEME[3],AtLeast,4),SetCVar("X",FMEME[3],Subtract,4))
		CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEME[1]),SetTo,_ReadX(V(FMEME[2]),0xFFFFFFFF,1),0xFFFFFFFF)},{Preserved})
		DoActionsX(AllPlayers,{SetCVar("X",FMEME[2],Add,1)})
		Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEME[4],Exactly,0);},actions = {SetCVar("X",FMEME[1],Add,1)},flag = {Preserved}}
		Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEME[4],Exactly,1);},actions = {SetCVar("X",FMEME[1],Add,604)},flag = {Preserved}}
	CWhileEnd()
	CIfX(AllPlayers,CVar("X",FMEME[3],Exactly,3))
		CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEME[1]),SetTo,_ReadX(V(FMEME[2]),0x00FFFFFF,1),0x00FFFFFF)},{Preserved})
	CElseIfX(CVar("X",FMEME[3],Exactly,2))
		CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEME[1]),SetTo,_ReadX(V(FMEME[2]),0x0000FFFF,1),0x0000FFFF)},{Preserved})
	CElseIfX(CVar("X",FMEME[3],Exactly,1))
		CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEME[1]),SetTo,_ReadX(V(FMEME[2]),0x000000FF,1),0x000000FF)},{Preserved})
	CIfXEnd()

	Trigger {
		players = {AllPlayers},
		conditions = {
			Label(FuncAlloc);
		},
		flag = {Preserved}
	}
	FMEMECall2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

	if Flag ~= nil and Flag ~= "X" then
-- f_Memcpy - Ret[1] : Input Dest / Ret[2] = Source / Ret[3] = DestX / Ret[4] = SourceX / Ret[5] = Size
		for i = 0, 5 do
			CVariable(AllPlayers,FuncAlloc+i)
			table.insert(FMEM,FuncAlloc+i)
		end
		FuncAlloc = FuncAlloc + 6

		Trigger {
				players = {AllPlayers},
				conditions = {
					Label(FuncAlloc);
				},
				flag = {Preserved}
			}
		FMEMCall0 =	FuncAlloc
		FuncAlloc = FuncAlloc + 1

		
		CIfX(AllPlayers,CVar("X",FMEM[6],Exactly,0))
			CMod(AllPlayers,V(FMEM[3]),V(FMEM[1]),4)
			CMov(AllPlayers,V(FMEM[1]),V(CRet[1]))
			CiSub(AllPlayers,V(FMEM[1]),1452249)
		CIfXEnd()
		CMod(AllPlayers,V(FMEM[4]),V(FMEM[2]),4)
		CMov(AllPlayers,V(FMEM[2]),V(CRet[1]))
		CiSub(AllPlayers,V(FMEM[2]),1452249)

		Trigger {
				players = {AllPlayers},
				conditions = {
					Label(FuncAlloc);
				},
				flag = {Preserved}
			}
		FMEMCall1 =	FuncAlloc
		FuncAlloc = FuncAlloc + 1

		CIfX(AllPlayers,CVar("X",FMEM[3],AtLeast,4))
			CMod(AllPlayers,V(FMEM[3]),4)
			CAdd(AllPlayers,V(FMEM[1]),V(CRet[1]))
		CIfXEnd()

		CIfX(AllPlayers,CVar("X",FMEM[4],AtLeast,4))
			CMod(AllPlayers,V(FMEM[4]),4)
			CAdd(AllPlayers,V(FMEM[2]),V(CRet[1]))
		CIfXEnd()

		CIfX(AllPlayers,CVar("X",FMEM[3],Exactly,0))
			CIfX(AllPlayers,CVar("X",FMEM[4],Exactly,0))
				CWhile(AllPlayers, CVar("X",FMEM[5],AtLeast,4),SetCVar("X",FMEM[5],Subtract,4))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFFFFFFFF,1),0xFFFFFFFF)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
				CWhileEnd()
				CIfX(AllPlayers,CVar("X",FMEM[5],Exactly,3))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FFFFFF,1),0x00FFFFFF)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,2))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FFFF,1),0x0000FFFF)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,1))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,1),0x000000FF)},{Preserved})
				CIfXEnd()
			CElseIfX(CVar("X",FMEM[4],Exactly,1))
				CWhile(AllPlayers, CVar("X",FMEM[5],AtLeast,4),SetCVar("X",FMEM[5],Subtract,4))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFFFFFF00,1/256),0x00FFFFFF)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF,16777216),0xFF000000)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
				CWhileEnd()
				CIfX(AllPlayers,CVar("X",FMEM[5],Exactly,3))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFFFFFF00,1/256),0x00FFFFFF)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,2))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FFFF00,1/256),0x0000FFFF)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,1))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FF00,1/256),0x000000FF)},{Preserved})
				CIfXEnd()
			CElseIfX(CVar("X",FMEM[4],Exactly,2))
				CWhile(AllPlayers, CVar("X",FMEM[5],AtLeast,4),SetCVar("X",FMEM[5],Subtract,4))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFFFF0000,1/65536),0x0000FFFF)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FFFF,65536),0xFFFF0000)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
				CWhileEnd()
				CIfX(AllPlayers,CVar("X",FMEM[5],Exactly,3))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFFFF0000,1/65536),0x0000FFFF)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,65536),0x00FF00000)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,2))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFFFF0000,1/65536),0x0000FFFF)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,1))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FF0000,1/65536),0x000000FF)},{Preserved})
				CIfXEnd()
			CElseX()
				CWhile(AllPlayers, CVar("X",FMEM[5],AtLeast,4),SetCVar("X",FMEM[5],Subtract,4))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1/16777216),0x000000FF)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FFFFFF,256),0xFFFFFF00)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
				CWhileEnd()
				CIfX(AllPlayers,CVar("X",FMEM[5],Exactly,3))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1/16777216),0x000000FF)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FFFF,256),0x00FFFF000)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,2))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1/16777216),0x000000FF)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,256),0x0000FF000)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,1))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1/16777216),0x000000FF)},{Preserved})
				CIfXEnd()
			CIfXEnd()
		CElseIfX(CVar("X",FMEM[3],Exactly,1))
			CIfX(AllPlayers,CVar("X",FMEM[4],Exactly,0))
				CWhile(AllPlayers, CVar("X",FMEM[5],AtLeast,4),SetCVar("X",FMEM[5],Subtract,4))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FFFFFF,256),0xFFFFFF00)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1/16777216),0x000000FF)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
				CWhileEnd()
				CIfX(AllPlayers,CVar("X",FMEM[5],Exactly,3))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FFFFFF,256),0xFFFFFF00)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,2))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FFFF,256),0x00FFFF00)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,1))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,256),0x0000FF00)},{Preserved})
				CIfXEnd()
			CElseIfX(CVar("X",FMEM[4],Exactly,1))
				CWhile(AllPlayers, CVar("X",FMEM[5],AtLeast,4),SetCVar("X",FMEM[5],Subtract,4))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFFFFFF00,1),0xFFFFFF00)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,1),0x000000FF)},{Preserved})
				CWhileEnd()
				CIfX(AllPlayers,CVar("X",FMEM[5],Exactly,3))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFFFFFF00,1),0xFFFFFF00)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,2))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FFFF00,1),0x00FFFF00)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,1))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FF00,1),0x0000FF00)},{Preserved})
				CIfXEnd()
			CElseIfX(CVar("X",FMEM[4],Exactly,2))
				CWhile(AllPlayers, CVar("X",FMEM[5],AtLeast,4),SetCVar("X",FMEM[5],Subtract,4))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFFFF0000,1/256),0x00FFFF00)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,16777216),0xFF000000)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FF00,1/256),0x000000FF)},{Preserved})
				CWhileEnd()
				CIfX(AllPlayers,CVar("X",FMEM[5],Exactly,3))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFFFF0000,1/256),0x00FFFF00)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,16777216),0xFF000000)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,2))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFFFF0000,1/256),0x00FFFF00)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,1))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FF0000,1/256),0x0000FF00)},{Preserved})
				CIfXEnd()
			CElseX()
				CWhile(AllPlayers, CVar("X",FMEM[5],AtLeast,4),SetCVar("X",FMEM[5],Subtract,4))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1/65536),0x0000FF00)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FFFF,65536),0xFFFF0000)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FF0000,1/65536),0x000000FF)},{Preserved})
				CWhileEnd()
				CIfX(AllPlayers,CVar("X",FMEM[5],Exactly,3))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1/65536),0x0000FF00)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FFFF,65536),0xFFFF0000)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,2))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1/65536),0x0000FF00)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,65536),0x00FF0000)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,1))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1/65536),0x0000FF00)},{Preserved})
				CIfXEnd()
			CIfXEnd()
		CElseIfX(CVar("X",FMEM[3],Exactly,2))
			CIfX(AllPlayers,CVar("X",FMEM[4],Exactly,0))
				CWhile(AllPlayers, CVar("X",FMEM[5],AtLeast,4),SetCVar("X",FMEM[5],Subtract,4))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FFFF,65536),0xFFFF0000)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFFFF0000,1/65536),0x0000FFFF)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
				CWhileEnd()
				CIfX(AllPlayers,CVar("X",FMEM[5],Exactly,3))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FFFF,65536),0xFFFF0000)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FF0000,1/65536),0x000000FF)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,2))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FFFF,65536),0xFFFF0000)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,1))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,65536),0x00FF0000)},{Preserved})
				CIfXEnd()
			CElseIfX(CVar("X",FMEM[4],Exactly,1))
				CWhile(AllPlayers, CVar("X",FMEM[5],AtLeast,4),SetCVar("X",FMEM[5],Subtract,4))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FFFF00,256),0xFFFF0000)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1/16777216),0x000000FF)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,256),0x0000FF00)},{Preserved})
				CWhileEnd()
				CIfX(AllPlayers,CVar("X",FMEM[5],Exactly,3))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FFFF00,256),0xFFFF0000)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1/16777216),0x000000FF)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,2))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FFFF00,256),0xFFFF0000)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,1))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FF00,256),0x00FF0000)},{Preserved})
				CIfXEnd()
			CElseIfX(CVar("X",FMEM[4],Exactly,2))
				CWhile(AllPlayers, CVar("X",FMEM[5],AtLeast,4),SetCVar("X",FMEM[5],Subtract,4))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFFFF0000,1),0xFFFF0000)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FFFF,1),0x0000FFFF)},{Preserved})
				CWhileEnd()
				CIfX(AllPlayers,CVar("X",FMEM[5],Exactly,3))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFFFF0000,1),0xFFFF0000)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,1),0x000000FF)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,2))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFFFF0000,1),0xFFFF0000)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,1))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FF0000,1),0x00FF0000)},{Preserved})
				CIfXEnd()
			CElseX()
				CWhile(AllPlayers, CVar("X",FMEM[5],AtLeast,4),SetCVar("X",FMEM[5],Subtract,4))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1/256),0x00FF0000)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,16777216),0xFF000000)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FFFF00,1/256),0x0000FFFF)},{Preserved})
				CWhileEnd()
				CIfX(AllPlayers,CVar("X",FMEM[5],Exactly,3))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1/256),0x00FF0000)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,16777216),0xFF000000)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FF00,1/256),0x000000FF)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,2))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1/256),0x00FF0000)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,16777216),0xFF000000)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,1))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1/256),0x00FF0000)},{Preserved})
				CIfXEnd()
			CIfXEnd()
		CElseX()
			CIfX(AllPlayers,CVar("X",FMEM[4],Exactly,0))
				CWhile(AllPlayers, CVar("X",FMEM[5],AtLeast,4),SetCVar("X",FMEM[5],Subtract,4))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,16777216),0xFF000000)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFFFFFF00,1/256),0x00FFFFFF)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
				CWhileEnd()
				CIfX(AllPlayers,CVar("X",FMEM[5],Exactly,3))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,16777216),0xFF000000)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FFFF00,1/256),0x0000FFFF)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,2))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,16777216),0xFF000000)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FF00,1/256),0x000000FF)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,1))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,16777216),0xFF000000)},{Preserved})
				CIfXEnd()
			CElseIfX(CVar("X",FMEM[4],Exactly,1))
				CWhile(AllPlayers, CVar("X",FMEM[5],AtLeast,4),SetCVar("X",FMEM[5],Subtract,4))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FF00,65536),0xFF000000)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFFFF0000,1/65536),0x0000FFFF)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,65536),0x00FF0000)},{Preserved})
				CWhileEnd()
				CIfX(AllPlayers,CVar("X",FMEM[5],Exactly,3))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FF00,65536),0xFF000000)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFFFF0000,1/65536),0x0000FFFF)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,2))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FF00,65536),0xFF000000)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FF0000,1/65536),0x000000FF)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,1))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FF00,65536),0xFF000000)},{Preserved})
				CIfXEnd()
			CElseIfX(CVar("X",FMEM[4],Exactly,2))
				CWhile(AllPlayers, CVar("X",FMEM[5],AtLeast,4),SetCVar("X",FMEM[5],Subtract,4))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FF0000,256),0xFF000000)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1/16777216),0x000000FF)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FFFF,256),0x00FFFF00)},{Preserved})
				CWhileEnd()
				CIfX(AllPlayers,CVar("X",FMEM[5],Exactly,3))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FF0000,256),0xFF000000)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1/16777216),0x000000FF)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,256),0x0000FF00)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,2))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FF0000,256),0xFF000000)},{Preserved})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1/16777216),0x000000FF)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,1))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FF0000,256),0xFF000000)},{Preserved})
				CIfXEnd()
			CElseX()
				CWhile(AllPlayers, CVar("X",FMEM[5],AtLeast,4),SetCVar("X",FMEM[5],Subtract,4))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1),0xFF000000)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x00FFFFFF,1),0x00FFFFFF)},{Preserved})
				CWhileEnd()
				CIfX(AllPlayers,CVar("X",FMEM[5],Exactly,3))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1),0xFF000000)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x0000FFFF,1),0x0000FFFF)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,2))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1),0xFF000000)},{Preserved})
					DoActionsX(AllPlayers,{SetCVar("X",FMEM[2],Add,1)})
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,0);},actions = {SetCVar("X",FMEM[1],Add,1)},flag = {Preserved}}
					Trigger {players = {AllPlayers},conditions = {Label(0);CVar("X",FMEM[6],Exactly,1);},actions = {SetCVar("X",FMEM[1],Add,604)},flag = {Preserved}}
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0x000000FF,1),0x000000FF)},{Preserved})
				CElseIfX(CVar("X",FMEM[5],Exactly,1))
					CTrigger(AllPlayers, nil,{TSetMemoryX(V(FMEM[1]),SetTo,_ReadFX(V(FMEM[2]),0xFF000000,1),0xFF000000)},{Preserved})
				CIfXEnd()
			CIfXEnd()
		CIfXEnd()

		Trigger {
				players = {AllPlayers},
				conditions = {
					Label(FuncAlloc);
				},
				flag = {Preserved}
			}
		FMEMCall2 =	FuncAlloc
		FuncAlloc = FuncAlloc + 1
	end
end


FMULCall0 = 0
FMULCall1 = 0
FMULCall2 = 0
FDIVCall1 = 0
FDIVCall2 = 0
FDIVCall3 = 0
FMODCall1 = 0
FMODCall2 = 0
FMODCall3 = 0
FIDIVCall1 = 0
FIDIVCall2 = 0
FIDIVCall3 = 0
FIMODCall1 = 0
FIMODCall2 = 0
FIMODCall3 = 0
FABSCall1 = 0
FABSCall2 = 0
function Include_ArithMetic() -- f_Mul f_Div f_iDiv f_Mod f_iMod f_Abs
	-- f_MulX - Ret[1] : Input X / Ret[2] : Input Y / Ret[3] : Output | Ouput = X * Y (f_Mul 최적화 버젼)
	local Bit = 31

	Trigger {
		players = {AllPlayers},
		conditions = { -- X == 0
			Label(FuncAlloc);
			CtrigX("X",CRet[2],0x15C,0,Exactly,0);
		},
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",FuncAlloc+2,0,0,0); -- Skip Calc
			SetCtrigX("X",FuncAlloc+2,0x158,0,SetTo,"X","X",0x4,1,0); -- RecoverNext
			SetCtrigX("X",FuncAlloc+2,0x15C,0,SetTo,"X","X",0,0,1); -- RecoverNext
			SetCtrigX("X",FuncAlloc+2,0x178,0,SetTo,"X","X",0x4,1,0); -- RecoverNext
			SetCtrigX("X",FuncAlloc+2,0x17C,0,SetTo,"X","X",0,0,1); -- RecoverNext
			SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0);
		},
		flag = {Preserved}
	}

	for i = 31, 0, -1 do
		local CBit = 2^i
		Trigger { -- 1 ~ 32
			players = {AllPlayers},
			conditions = { -- X Max Bit Check
				Label(0);
				CtrigX("X",CRet[2],0x15C,0,AtLeast,CBit);
			},
			actions = {
				SetCtrigX("X","X",0x4,0,SetTo,"X",FuncAlloc+1,0,0,0); -- Jump Calc
				SetCtrigX("X",FuncAlloc+1,0x17C,i+2,SetTo,"X",FuncAlloc+1,0,0,65-i); -- Jump Calc
				SetCtrigX("X",FuncAlloc+2,0x158,0,SetTo,"X","X",0x4,1,0); -- RecoverNext
				SetCtrigX("X",FuncAlloc+2,0x15C,0,SetTo,"X","X",0,0,1); -- RecoverNext
				SetCtrigX("X",FuncAlloc+2,0x178,0,SetTo,"X",FuncAlloc+1,0x17C,1,i+2); -- RecoverNext
				SetCtrigX("X",FuncAlloc+2,0x17C,0,SetTo,"X",FuncAlloc+1,0,0,1); -- RecoverNext
				SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0);
			},
			flag = {Preserved}
		}
	end

	FMULCall0 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

	local ClearValue = {}
	for i = 0, 31 do
		table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x15C,34+i,SetTo,0))
	end

	Trigger { 
			players = {AllPlayers},
			conditions = {
				Label(FuncAlloc);
			},
			actions = {
				SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
				SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0);
				SetCtrigX("X",FuncAlloc,0x19C,1,SetTo,"X",FuncAlloc,0x0,0,2);
				ClearValue,
			},
			flag = {Preserved}
		}

	
	Trigger { -- local Var1 (1)
			players = {AllPlayers},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[1],0x15C,1,0);
				SetCtrig1X("X",FuncAlloc,0x19C,1,Add,0x970);
				SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,2);
			},
			flag = {Preserved}
		}

	for i = 0, 31 do
		Trigger { -- (2 ~ Bit+2) = 2 ~ 33
			players = {AllPlayers},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",FuncAlloc,0x15C,1,65-i);
				SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,1);
			},
			flag = {Preserved}
		}
	end

	local PlayerID = AllPlayers
	PlayerID = PlayerConvert(PlayerID)
	for k, P in pairs(PlayerID) do
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,0,SetTo,"X",FuncAlloc,0x0,0,2))
		for i = 1, 33 do
			table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,i,SetTo,"X",CRet[1],0x0,0,0))
		end
	end

	for i = 31, 0, -1 do
		local CBit = 2^i
		Trigger { -- (Bit+3 ~ 2*Bit+3) = 34 ~ 65
			players = {AllPlayers}, 
			conditions = {
				Label(0);
				CtrigX("X",CRet[2],0x15C,0,Exactly,CBit,CBit);
			},
			actions = {
				SetCtrig1X("X",CRet[3],0x15C,0,Add,0);
			},
			flag = {Preserved}
		}
	end

	Trigger {
			players = {AllPlayers},
			conditions = {
				Label(FuncAlloc+1);
			},
			actions = {
				SetDeaths(0,SetTo,0,0);
				SetDeaths(0,SetTo,0,0);
			},
			flag = {Preserved}
	}


	FMULCall1 = FuncAlloc
	FMULCall2 = FuncAlloc+1

	FuncAlloc = FuncAlloc + 2

--[[ 구 f_Mul (32bit CMul)
	local Bit = 31

	local ClearValue = {}
	for i = 0, Bit do
		table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x15C,(Bit+3)+i,SetTo,0))
	end

	Trigger { 
			players = {AllPlayers},
			conditions = {
				Label(FuncAlloc);
			},
			actions = {
				SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
				SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0);
				SetCtrigX("X",FuncAlloc,0x19C,1,SetTo,"X",FuncAlloc,0x0,0,2);
				ClearValue,
			},
			flag = {Preserved}
		}

	
	Trigger { -- local Var1 (1)
			players = {AllPlayers},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[1],0x15C,1,0);
				SetCtrig1X("X",FuncAlloc,0x19C,1,Add,0x970);
				SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,2);
			},
			flag = {Preserved}
		}

	for i = 0, Bit do
		Trigger { -- (2 ~ Bit+2)
			players = {AllPlayers},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",FuncAlloc,0x15C,1,(Bit+3)+i);
				SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,1);
			},
			flag = {Preserved}
		}
	end

	local PlayerID = AllPlayers
	PlayerID = PlayerConvert(PlayerID)
	for k, P in pairs(PlayerID) do
		table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,0,SetTo,"X",FuncAlloc,0x0,0,2))
		for i = 1, (Bit+2) do
			table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,i,SetTo,"X",CRet[1],0x0,0,0))
		end
	end

	for i = 0, Bit do
		local CBit = 2^i
		Trigger { -- (Bit+3 ~ 2*Bit+3)
			players = {AllPlayers},
			conditions = {
				Label(0);
				CtrigX("X",CRet[2],0x15C,0,Exactly,CBit,CBit);
			},
			actions = {
				SetCtrig1X("X",CRet[3],0x15C,0,Add,0);
			},
			flag = {Preserved}
		}
	end

	Trigger {
			players = {AllPlayers},
			conditions = {
				Label(FuncAlloc+1);
			},
			actions = {
			},
			flag = {Preserved}
	}


	FMULCall1 = FuncAlloc
	FMULCall2 = FuncAlloc+1

	FuncAlloc = FuncAlloc + 2
]]--
--------------------------------------------------------------------------------------------------------------------
	-- f_Div - Ret[1] : Input Y / Ret[2] : Input X / Ret[3] : Output | Ouput = X / Y or X % Y

------------------- f_iDiv Init ----------------------------------------------
		Trigger { 
			players = {AllPlayers},
				conditions = {
					Label(FuncAlloc); -- FIDIV1
				},
				actions = {
					SetCtrigX("X",FuncAlloc+5,0x4,0,SetTo,"X",FuncAlloc+6,0x0,0,0); -- 분기점 Next -> FIDIV2
					SetCtrig1X("X",CRet[6],0x15C,0,SetTo,0);
				},
				flag = {Preserved}
			}
		Trigger { 
			players = {AllPlayers},
				conditions = {
					Label(0); 
					CtrigX("X",CRet[1],0x15C,0,Exactly,0);
				},
				actions = {
					SetCtrig1X("X",CRet[6],0x15C,0,SetTo,1);
				},
				flag = {Preserved}
			}
		CIfX(AllPlayers,CtrigX("X",CRet[1],0x15C,0,AtLeast,0x80000000))
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[5],0x15C,0,SetTo,1); -- Sflag
						SetCtrig1X("X",CRet[4],0x15C,0,SetTo,0xFFFFFFFF);
						SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[4],0x15C,1,0);
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,Subtract*16777216,0xFF000000);
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[4],0x15C,0,Add,1);
						SetCtrigX("X",CRet[4],0x158,0,SetTo,"X",CRet[1],0x15C,1,0);
						SetCtrig1X("X",CRet[4],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[4],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways("X",CRet[4],0);
					},
					flag = {Preserved}
				}
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX("X",CRet[4],0x158,0,SetTo,"X",CRet[1],0x17C,1,0);
						CallLabelAlways("X",CRet[4],0);
					},
					flag = {Preserved}
				}
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
						SetCtrig1X("X",CRet[1],0x168,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x180,0,SetTo,Add*16777216,0xFF000000);
						SetCtrig1X("X",CRet[1],0x184,0,SetTo,0,0x2);
					},
					flag = {Preserved}
				}
		CElseX()
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[5],0x15C,0,SetTo,0); -- Sflag
						SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[1],0x17C,1,0);
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x0,0x2);
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
						SetCtrig1X("X",CRet[1],0x168,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x180,0,SetTo,Add*16777216,0xFF000000);
					},
					flag = {Preserved}
				}
		CIfXEnd()

		CIfX(AllPlayers,CtrigX("X",CRet[2],0x15C,0,AtLeast,0x80000000))
			Trigger { 
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
					SetCtrig1X("X",CRet[5],0x15C,0,Add,1); -- Sflag
					SetCtrig1X("X",CRet[4],0x15C,0,SetTo,0xFFFFFFFF);
					SetCtrigX("X",CRet[2],0x158,0,SetTo,"X",CRet[4],0x15C,1,0);
					SetCtrig1X("X",CRet[2],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",CRet[2],0x160,0,SetTo,Subtract*16777216,0xFF000000);
					CallLabelAlways("X",CRet[2],0);
					},
					flag = {Preserved}
				}
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[4],0x15C,0,Add,1);
						SetCtrigX("X",CRet[4],0x158,0,SetTo,"X",CRet[2],0x15C,1,0);
						SetCtrig1X("X",CRet[4],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[4],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways("X",CRet[4],0);
					},
					flag = {Preserved}
				}
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0); -- Clear Ret
						SetCtrigX("X",FuncAlloc+4,0x1BC,2,SetTo,"X",FuncAlloc+4,0x0,0,3); -- Init Var1 Act#4 Value
						SetCtrigX("X",FuncAlloc+4,0x4,1,SetTo,"X",FuncAlloc+4,0x0,0,2); --  Init Var2 -> Var1
					},
					flag = {Preserved}
				}
		CElseX()
			Trigger { 
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
					SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0); -- Clear Ret
					SetCtrigX("X",FuncAlloc+4,0x1BC,2,SetTo,"X",FuncAlloc+4,0x0,0,3); -- Init Var1 Act#4 Value
					SetCtrigX("X",FuncAlloc+4,0x4,1,SetTo,"X",FuncAlloc+4,0x0,0,2); --  Init Var2 -> Var1
					},
					flag = {Preserved}
				}
		CIfXEnd()

		Trigger { 
			players = {AllPlayers},
				conditions = {
					Label(0); -- FIDIV1
				},
				actions = {
					SetCtrigX("X","X",0x4,0,SetTo,"X",FuncAlloc+4,0x0,0,0); -- goto Div Calc Start
				},
				flag = {Preserved}
			}
	FIDIVCall1 = FuncAlloc
	FuncAlloc = FuncAlloc + 1
--------------------- f_iMod-------------------------------------------------------

		Trigger { 
			players = {AllPlayers},
				conditions = {
					Label(FuncAlloc); -- FIMOD1
				},
				actions = {
					SetCtrigX("X",FuncAlloc+4,0x4,0,SetTo,"X",FuncAlloc+7,0x0,0,0); -- 분기점 Next -> FIMOD2
				},
				flag = {Preserved}
			}

		CIfX(AllPlayers,CtrigX("X",CRet[1],0x15C,0,AtLeast,0x80000000))
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[4],0x15C,0,SetTo,0xFFFFFFFF);
						SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[4],0x15C,1,0);
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,Subtract*16777216,0xFF000000);
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[4],0x15C,0,Add,1);
						SetCtrigX("X",CRet[4],0x158,0,SetTo,"X",CRet[1],0x15C,1,0);
						SetCtrig1X("X",CRet[4],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[4],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways("X",CRet[4],0);
					},
					flag = {Preserved}
				}
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX("X",CRet[4],0x158,0,SetTo,"X",CRet[1],0x17C,1,0);
						CallLabelAlways("X",CRet[4],0);
					},
					flag = {Preserved}
				}
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
						SetCtrig1X("X",CRet[1],0x168,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x180,0,SetTo,Add*16777216,0xFF000000);
						SetCtrig1X("X",CRet[1],0x184,0,SetTo,0,0x2);
					},
					flag = {Preserved}
				}
		CElseX()
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[1],0x17C,1,0);
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x0,0x2);
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
						SetCtrig1X("X",CRet[1],0x168,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x180,0,SetTo,Add*16777216,0xFF000000);
					},
					flag = {Preserved}
				}
		CIfXEnd()

		CIfX(AllPlayers,CtrigX("X",CRet[2],0x15C,0,AtLeast,0x80000000))
			Trigger { 
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
					SetCtrig1X("X",CRet[5],0x15C,0,SetTo,1); -- Sflag
					SetCtrig1X("X",CRet[4],0x15C,0,SetTo,0xFFFFFFFF);
					SetCtrigX("X",CRet[2],0x158,0,SetTo,"X",CRet[4],0x15C,1,0);
					SetCtrig1X("X",CRet[2],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",CRet[2],0x160,0,SetTo,Subtract*16777216,0xFF000000);
					CallLabelAlways("X",CRet[2],0);
					},
					flag = {Preserved}
				}
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[4],0x15C,0,Add,1);
						SetCtrigX("X",CRet[4],0x158,0,SetTo,"X",CRet[2],0x15C,1,0);
						SetCtrig1X("X",CRet[4],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[4],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways("X",CRet[4],0);
					},
					flag = {Preserved}
				}
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0); -- Clear Ret
						SetCtrigX("X",FuncAlloc+3,0x1BC,2,SetTo,"X",FuncAlloc+3,0x0,0,3); -- Init Var1 Act#4 Value
						SetCtrigX("X",FuncAlloc+3,0x4,1,SetTo,"X",FuncAlloc+3,0x0,0,2); --  Init Var2 -> Var1
					},
					flag = {Preserved}
				}
		CElseX()
			Trigger { -- X -> CRet[2] (-1)
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
					SetCtrig1X("X",CRet[5],0x15C,0,SetTo,0); -- Sflag
					SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0); -- Clear Ret
					SetCtrigX("X",FuncAlloc+3,0x1BC,2,SetTo,"X",FuncAlloc+3,0x0,0,3); -- Init Var1 Act#4 Value
					SetCtrigX("X",FuncAlloc+3,0x4,1,SetTo,"X",FuncAlloc+3,0x0,0,2); --  Init Var2 -> Var1
					},
					flag = {Preserved}
				}
		CIfXEnd()

		Trigger { 
			players = {AllPlayers},
				conditions = {
					Label(0); 
				},
				actions = {
					SetCtrigX("X","X",0x4,0,SetTo,"X",FuncAlloc+3,0x0,0,0); -- goto Div Calc Start
				},
				flag = {Preserved}
			}

	FIMODCall1 = FuncAlloc
	FuncAlloc = FuncAlloc + 1
--------------------- f_Div-------------------------------------------------------

		Trigger { 
			players = {AllPlayers},
				conditions = {
					Label(FuncAlloc); -- FDIV1
				},
				actions = {
					SetCtrigX("X",FuncAlloc+3,0x4,0,SetTo,"X",FuncAlloc+8,0x0,0,0); -- 분기점 Next -> FDIV2
				},
				flag = {Preserved}
			}

		Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[1],0x17C,1,0);
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
		Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x0,0x2);
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
						SetCtrig1X("X",CRet[1],0x168,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x180,0,SetTo,Add*16777216,0xFF000000);
					},
					flag = {Preserved}
				}

		Trigger { 
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
					SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0); -- Clear Ret
					SetCtrigX("X",FuncAlloc+2,0x1BC,2,SetTo,"X",FuncAlloc+2,0x0,0,3); -- Init Var1 Act#4 Value
					SetCtrigX("X",FuncAlloc+2,0x4,1,SetTo,"X",FuncAlloc+2,0x0,0,2); --  Init Var2 -> Var1
					},
					flag = {Preserved}
				}

		Trigger { 
			players = {AllPlayers},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x4,0,SetTo,"X",FuncAlloc+2,0x0,0,0); -- goto Div Calc Start
				},
				flag = {Preserved}
			}

	FDIVCall1 = FuncAlloc
	FuncAlloc = FuncAlloc + 1
--------------------- f_Mod-------------------------------------------------------

		Trigger { 
			players = {AllPlayers},
				conditions = {
					Label(FuncAlloc); -- FMod1
				},
				actions = {
					SetCtrigX("X",FuncAlloc+2,0x4,0,SetTo,"X",FuncAlloc+9,0x0,0,0); -- 분기점 Next -> FMod2
				},
				flag = {Preserved}
			}

		Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[1],0x17C,1,0);
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
						CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
		Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x0,0x2);
						SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x160,0,SetTo,Add*16777216,0xFF000000);
						SetCtrig1X("X",CRet[1],0x168,0,SetTo,0xFFFFFFFF);
						SetCtrig1X("X",CRet[1],0x180,0,SetTo,Add*16777216,0xFF000000);
					},
					flag = {Preserved}
				}

		Trigger { 
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
					SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0); -- Clear Ret
					SetCtrigX("X",FuncAlloc+1,0x1BC,2,SetTo,"X",FuncAlloc+1,0x0,0,3); -- Init Var1 Act#4 Value
					SetCtrigX("X",FuncAlloc+1,0x4,1,SetTo,"X",FuncAlloc+1,0x0,0,2); --  Init Var2 -> Var1
					},
					flag = {Preserved}
				}

		Trigger { 
			players = {AllPlayers},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x4,0,SetTo,"X",FuncAlloc+1,0x0,0,0); -- goto Div Calc Start
				},
				flag = {Preserved}
			}

	FMODCall1 = FuncAlloc
	FuncAlloc = FuncAlloc + 1
---------------------------- Div Calc Start -------------------------------------------

		local ClearValue = {}
		for i = 0, Bit do
			table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x24,(Bit+4)+i,SetTo,0))
			table.insert(ClearValue,SetCtrig1X("X",FuncAlloc,0x15C,(Bit+4)+i,SetTo,0))
		end

		Trigger { -- Clear Value 
				players = {AllPlayers},
				conditions = {
					Label(FuncAlloc);
				},
				actions = {
					ClearValue,
				},
				flag = {Preserved}
			}


		Trigger { -- local Var2 (1)
				players = {AllPlayers},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,0x80000000);
				},
				actions = {
					SetCtrigX("X",FuncAlloc,0x4,1,SetTo,"X",FuncAlloc,0x0,0,2*Bit+4);
				},
				flag = {Preserved}
			}

		Trigger { -- local Var1 (2)
				players = {AllPlayers},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[1],0x15C,1,0);
					SetCtrigX("X",CRet[1],0x178,0,SetTo,"X",CRet[1],0x17C,1,0);
					SetCtrig1X("X",FuncAlloc,0x1BC,2,Add,0x970);
					SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,3);
				},
				flag = {Preserved}
			}

		for i = 0, Bit do
			Trigger { -- (3 ~ Bit+3)
				players = {AllPlayers},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",FuncAlloc,0x24,1,2*Bit+4-i);
					SetCtrigX("X",CRet[1],0x178,0,SetTo,"X",FuncAlloc,0x15C,1,2*Bit+4-i);
					SetCtrigX("X",CRet[1],0x4,0,SetTo,"X",FuncAlloc,0x0,0,1);
					SetCtrigX("X",FuncAlloc,0x15C,1,SetTo,"X",FuncAlloc,0x0,0,2*Bit+4-i);
				},
				flag = {Preserved}
			}
		end

		local PlayerID = AllPlayers
		PlayerID = PlayerConvert(PlayerID)
		for k, P in pairs(PlayerID) do
			table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,0,SetTo,"X",FuncAlloc,0x0,0,3)) --> Create Local Var
			for i = 2, (Bit+3) do
				table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,i,SetTo,"X",CRet[1],0x0,0,0)) -- -> VarX
			end
		end

		for i = 0, Bit do
			local CBit = 2^(Bit-i)
			Trigger { -- (Bit+4 ~ 2*Bit+4)
				players = {AllPlayers},
				conditions = {
					Label(0);
					CtrigX("X",CRet[2],0x15C,0,AtLeast,0);
				},
				actions = {
					SetCtrig1X("X",CRet[2],0x15C,0,Subtract,0);
					SetCtrig1X("X",CRet[3],0x15C,0,Add,CBit);
				},
				flag = {Preserved}
			}
		end

	FuncAlloc = FuncAlloc + 1
		Trigger { 
			players = {AllPlayers},
				conditions = {
					Label(FuncAlloc); -- 분기점
				},
				flag = {Preserved}
			}
	FuncAlloc = FuncAlloc + 1
----------------------------- Div Calc End ------------------------------------------------------

---------------------------- f_iDiv End ---------------------------------------------------------

		Trigger { 
			players = {AllPlayers},
				conditions = {
					Label(FuncAlloc); -- IDiv End Start
				},
				flag = {Preserved}
			}

		CIfX(AllPlayers,CtrigX("X",CRet[5],0x15C,0,Exactly,0x1,0x1)) -- Sflag == 1
			Trigger { 
				players = {AllPlayers},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x178,0,SetTo,0x0);
					SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0x0);
					SetCtrig1X("X",CRet[1],0x180,0,SetTo,SetTo*16777216,0xFF000000);
					SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x2,0x2);
					SetCtrigX("X",CRet[3],0x158,0,SetTo,"X",CRet[4],0x15C,1,0);
					SetCtrig1X("X",CRet[3],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",CRet[3],0x160,0,SetTo,Subtract*16777216,0xFF000000);
					CallLabelAlways("X",CRet[3],0);
					SetCtrig1X("X",CRet[4],0x15C,0,SetTo,0xFFFFFFFF);
				},
				flag = {Preserved}
			}
			Trigger { 
				players = {AllPlayers},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X",CRet[4],0x15C,0,Add,1);
					SetCtrigX("X",CRet[4],0x158,0,SetTo,"X",CRet[3],0x15C,1,0);
					SetCtrig1X("X",CRet[4],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",CRet[4],0x160,0,SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways("X",CRet[4],0);
				},
				flag = {Preserved}
			}
			Trigger { -- X(<0)/0 -> 0x80000000
					players = {AllPlayers},
					conditions = {
						Label(0);
						CtrigX("X",CRet[6],0x15C,0,Exactly,0x1);
					},
					actions = {
					SetCtrig1X("X",CRet[6],0x15C,0,SetTo,0);
					SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0x80000000);
					},
					flag = {Preserved}
				}
		CElseX()
			Trigger { 
				players = {AllPlayers},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x178,0,SetTo,0x0);
					SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0x0);
					SetCtrig1X("X",CRet[1],0x180,0,SetTo,SetTo*16777216,0xFF000000);
					SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x2,0x2);
				},
				flag = {Preserved}
			}
			Trigger { -- X(<0)/0 -> 0x80000000
					players = {AllPlayers},
					conditions = {
						Label(0);
						CtrigX("X",CRet[6],0x15C,0,Exactly,0x1);
					},
					actions = {
					SetCtrig1X("X",CRet[6],0x15C,0,SetTo,0);
					SetCtrig1X("X",CRet[3],0x15C,0,SetTo,0x7FFFFFFF);
					},
					flag = {Preserved}
				}
		CIfXEnd()
	
	FIDIVCall2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

		Trigger { 
			players = {AllPlayers},
				conditions = {
					Label(FuncAlloc); -- Exit Func
				},
				flag = {Preserved}
			}

	FIDIVCall3 = FuncAlloc
	FuncAlloc = FuncAlloc + 1


---------------------------- f_iMod End ---------------------------------------------------------

		Trigger { 
			players = {AllPlayers},
				conditions = {
					Label(FuncAlloc); -- IMod End Start
				},
				flag = {Preserved}
			}

		CIfX(AllPlayers,CtrigX("X",CRet[5],0x15C,0,Exactly,0x1,0x1)) -- Sflag == 1
			Trigger { 
				players = {AllPlayers},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X",CRet[2],0x158,0,SetTo,"X",CRet[4],0x15C,1,0);
					SetCtrig1X("X",CRet[2],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",CRet[2],0x160,0,SetTo,Subtract*16777216,0xFF000000);
					CallLabelAlways("X",CRet[2],0);
					SetCtrig1X("X",CRet[4],0x15C,0,SetTo,0xFFFFFFFF);
				},
				flag = {Preserved}
			}
			Trigger { 
				players = {AllPlayers},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X",CRet[4],0x15C,0,Add,1);
					SetCtrigX("X",CRet[4],0x158,0,SetTo,"X",CRet[2],0x15C,1,0);
					SetCtrig1X("X",CRet[4],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",CRet[4],0x160,0,SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways("X",CRet[4],0);
				},
				flag = {Preserved}
			}
			Trigger { 
				players = {AllPlayers},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x178,0,SetTo,0x0);
					SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0x0);
					SetCtrig1X("X",CRet[1],0x180,0,SetTo,SetTo*16777216,0xFF000000);
					SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x2,0x2);
				},
				flag = {Preserved}
			}
		CElseX()
			Trigger { 
				players = {AllPlayers},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x178,0,SetTo,0x0);
					SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0x0);
					SetCtrig1X("X",CRet[1],0x180,0,SetTo,SetTo*16777216,0xFF000000);
					SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x2,0x2);
				},
				flag = {Preserved}
			}
		CIfXEnd()
	
	FIMODCall2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

		Trigger { 
			players = {AllPlayers},
				conditions = {
					Label(FuncAlloc); -- Exit Func
				},
				flag = {Preserved}
			}

	FIMODCall3 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

---------------------------- f_Div End ---------------------------------------------------------

		Trigger { 
			players = {AllPlayers},
				conditions = {
					Label(FuncAlloc); -- Div End Start
				},
				flag = {Preserved}
			}

		Trigger { 
				players = {AllPlayers},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x178,0,SetTo,0x0);
					SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0x0);
					SetCtrig1X("X",CRet[1],0x180,0,SetTo,SetTo*16777216,0xFF000000);
					SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x2,0x2);
				},
				flag = {Preserved}
			}
	
	FDIVCall2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

		Trigger { 
			players = {AllPlayers},
				conditions = {
					Label(FuncAlloc); -- Exit Func
				},
				flag = {Preserved}
			}

	FDIVCall3 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

---------------------------- f_MOD End ---------------------------------------------------------

		Trigger { 
			players = {AllPlayers},
				conditions = {
					Label(FuncAlloc); -- Mod End Start
				},
				flag = {Preserved}
			}

			Trigger { 
				players = {AllPlayers},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x178,0,SetTo,0x0);
					SetCtrig1X("X",CRet[1],0x17C,0,SetTo,0x0);
					SetCtrig1X("X",CRet[1],0x180,0,SetTo,SetTo*16777216,0xFF000000);
					SetCtrig1X("X",CRet[1],0x184,0,SetTo,0x2,0x2);
				},
				flag = {Preserved}
			}

	FMODCall2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

		Trigger { 
			players = {AllPlayers},
				conditions = {
					Label(FuncAlloc); -- Exit Func
				},
				flag = {Preserved}
			}

	FMODCall3 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

		Trigger { 
			players = {AllPlayers},
				conditions = {
					Label(FuncAlloc); -- Exit Func
				},
				flag = {Preserved}
			}

		CIfX(AllPlayers,CtrigX("X",CRet[1],0x15C,0,AtLeast,0x80000000))
			Trigger { 
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
					SetCtrig1X("X",CRet[2],0x15C,0,SetTo,0xFFFFFFFF);
					SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[2],0x15C,1,0);
					SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",CRet[1],0x160,0,SetTo,Subtract*16777216,0xFF000000);
					CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[2],0x15C,0,Add,1); -- Clear Ret
					},
					flag = {Preserved}
				}
		CElseX()
			Trigger { 
					players = {AllPlayers},
					conditions = {
						Label(0);
					},
					actions = {
					SetCtrigX("X",CRet[1],0x158,0,SetTo,"X",CRet[2],0x15C,1,0);
					SetCtrig1X("X",CRet[1],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",CRet[1],0x160,0,SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways("X",CRet[1],0);
					},
					flag = {Preserved}
				}
		CIfXEnd()

		Trigger { 
			players = {AllPlayers},
				conditions = {
					Label(FuncAlloc+1); -- Exit Func
				},
				flag = {Preserved}
			}

	FABSCall1 = FuncAlloc
	FABSCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

end


FSQRTCall1 = 0
FSQRTCall2 = 0
FSQRT = {}
FLENGCall1 = 0
FLENGCall2 = 0
FLENG = {}
FATANCall1 = 0
FATANCall2 = 0
FATAN = {}
function Include_MatheMatics(Cycle) -- f_Sqrt / f_Lengthdir / f_Atan2 | Cycle = 2*pi, 4의 배수여야함
-- f_Sqrt - Ret[1] : Input Value / Ret[2] = Output | Ret = √X 

	CVariable(AllPlayers,FuncAlloc) -- Local Variable
	CVariable(AllPlayers,FuncAlloc+1)
	FSQRT = {FuncAlloc,FuncAlloc+1}
	FuncAlloc = FuncAlloc + 2

	Trigger {
		players = {AllPlayers},
		conditions = { -- X == 0
			Label(FuncAlloc);
			CtrigX("X",FSQRT[1],0x15C,0,Exactly,0);
		},
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",FuncAlloc+1,0,0,0); -- Skip Calc
			SetCtrig1X("X",FSQRT[2],0x15C,0,SetTo,0);
		},
		flag = {Preserved}
	}

	for i = 15, 0, -1 do
		local CBit = 2^i
		Trigger { -- 1 ~ 16
			players = {AllPlayers},
			conditions = { -- X Max Bit Check
				Label(0);
				CtrigX("X",FSQRT[1],0x15C,0,AtLeast,CBit^2);
			},
			actions = {
				SetCtrigX("X","X",0x4,0,SetTo,"X",FuncAlloc,0,0,17+2*(15-i)); -- Jump Calc
				SetCtrig1X("X",FSQRT[2],0x15C,0,SetTo,0);	
			},
			flag = {Preserved}
		}
	end

	for i = 15, 0, -1 do -- 17 ~ 47
		local CBit = 2^i
		Trigger { -- 17, 19, ~ 47
			players = {AllPlayers},
			conditions = { -- X^2 Binary Search
				Label(0);
				CtrigX("X",FSQRT[1],0x15C,0,AtLeast,CBit^2);
			},
			actions = {
				SetCtrig1X("X",FSQRT[2],0x15C,0,Add,CBit);
			},
			flag = {Preserved}
		}
		if i >= 1 then
			Trigger { -- 18, 20, ~ 46
				players = {AllPlayers},
				conditions = { -- Go X^2
					Label(0);
				},
				actions = {
					SetCtrig1X("X",CRet[3],0x15C,0,SetTo,CBit/2); -- Add CBit
					SetCtrig1X("X",CRet[4],0x15C,0,SetTo,CBit/2);
					SetCtrigX("X",FuncAlloc+3,0x4,1,SetTo,"X","X",0,0,1);
					SetCtrigX("X",FuncAlloc+3,0x15C,0,SetTo,"X","X",0x24,1,1);	
				},
				flag = {Preserved}
			}
		end
	end

	local PlayerID = AllPlayers
	PlayerID = PlayerConvert(PlayerID)
	for k, P in pairs(PlayerID) do
		for i = 18, 46, 2 do
			table.insert(CtrigInitArr[P+1], SetCtrigX("X",FuncAlloc,0x4,i,SetTo,"X",FuncAlloc+1,0x0,0,1)) -- -> X*X
		end
	end

	ClearJump1 = {}
	for i = 0, 16 do 
		table.insert(ClearJump1,SetCtrigX("X",FuncAlloc,0x4,i,SetTo,"X",FuncAlloc,0,0,i+1))
	end
	for i = 17, 47, 2 do 
		table.insert(ClearJump1,SetCtrig1X("X",FuncAlloc,0x24,i,SetTo, 2^(47-i) ))
	end

	Trigger {
		players = {AllPlayers},
		conditions = { -- Init Calc
			Label(FuncAlloc+1);
		},
		actions = {
			ClearJump1,
		},
		flag = {Preserved}
	}
	FSQRTCall1 = FuncAlloc
	FSQRTCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	Trigger { -- +1
		players = {AllPlayers},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FSQRT[2],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",FSQRT[2],0x160,0,SetTo,Add*16777216,0xFF000000);
				SetCtrigX("X",FSQRT[2],0x158,0,SetTo,"X",CRet[3],0x15C,1,0);
				CallLabelAlways("X",FSQRT[2],0);
			},
			flag = {Preserved}
		}
	Trigger { -- +2
		players = {AllPlayers},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FSQRT[2],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",FSQRT[2],0x160,0,SetTo,Add*16777216,0xFF000000);
				SetCtrigX("X",FSQRT[2],0x158,0,SetTo,"X",CRet[4],0x15C,1,0);
				CallLabelAlways("X",FSQRT[2],0);
			},
			flag = {Preserved}
		}

	CMul(AllPlayers,V(CRet[3]),V(CRet[4]),"X","X",0xFFFF)-- FuncAlloc + 1

	Trigger { 
		players = {AllPlayers},
			conditions = {
				Label(FuncAlloc);
			},
			actions = {
				SetCtrigX("X",CRet[3],0x158,0,SetTo,"X",FSQRTCall1,0x24,1,17);
				SetCtrig1X("X",CRet[3],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",CRet[3],0x160,0,SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways("X",CRet[3],0);
			},
			flag = {Preserved}
		}
	Trigger { 
		players = {AllPlayers},
			conditions = {
				Label(0);
			},
			flag = {Preserved}
		}
	FuncAlloc = FuncAlloc + 1

-- f_Lengthdir - Ret[1] : Input R  Ret[2] = Θ | Ret[3] = RCosΘ  Ret[4] = RSinΘ
	if Cycle == "X" or Cycle == nil then
		Cycle = 360
	end
	local Range = Cycle/4

	for i = 0, Range do
		Trigger {
				players = {AllPlayers},
				conditions = {
					Label(FuncAlloc+i);
				},
				actions = {
					SetDeathsX(0,SetTo,0x10000*math.sin(math.rad(i*90/Range)),0,0xFFFFFFFF); -- Full Variable
					Disabled(SetDeathsX(0,SetTo,0,0,0xFFFFFFFF)); -- Recover Next
				},
				flag = {Preserved}
			}
	end
	FLENGVA = GetVArray(V(FuncAlloc))
	FuncAlloc = FuncAlloc + Range + 1
	for i = 0, 7 do
		CVariable(AllPlayers,FuncAlloc+i) -- Local Variable
		table.insert(FLENG,FuncAlloc+i)
	end
	FuncAlloc = FuncAlloc + 8

	Trigger { 
		players = {AllPlayers},
		conditions = {
			Label(FuncAlloc);
		},
		flag = {Preserved}
	}

 	CIfX(AllPlayers,CVar("X",FLENG[2],AtLeast,Cycle))
		CiMod(AllPlayers,V(FLENG[2]),Cycle)
	CIfXEnd()

	CIfX(AllPlayers,CVar("X",FLENG[2],AtLeast,0x80000000))
		CAdd(AllPlayers,V(FLENG[2]),Cycle)
	CIfXEnd()

	-- FLENG[5] = Cos Signflag / FLENG[6] = Sin Signflag / FLENG[7] = Cos VAindex / FLENG[8] = Sin VAindex
	CIfX(AllPlayers,CVar("X",FLENG[2],AtMost,Range-1)) 
		DoActionsX(AllPlayers,{SetCVar("X",FLENG[5],SetTo,0),SetCVar("X",FLENG[6],SetTo,0)})
		CMov(AllPlayers,V(FLENG[8]),V(FLENG[2])) -- Sin.i << i
		CMov(AllPlayers,V(FLENG[7]),Range)
		CSub(AllPlayers,V(FLENG[7]),V(FLENG[2])) -- Cos.i << pi/2 - i
	CElseIfX(CVar("X",FLENG[2],AtMost,Range*2-1))
		DoActionsX(AllPlayers,{SetCVar("X",FLENG[5],SetTo,1),SetCVar("X",FLENG[6],SetTo,0)})
		CMov(AllPlayers,V(FLENG[8]),Range*2) -- Sin.i << pi - i
		CSub(AllPlayers,V(FLENG[8]),V(FLENG[2]))
		CMov(AllPlayers,V(FLENG[7]),V(FLENG[2])) -- Cos.i << i - pi/2
		CSub(AllPlayers,V(FLENG[7]),Range)
	CElseIfX(CVar("X",FLENG[2],AtMost,Range*3-1))
		DoActionsX(AllPlayers,{SetCVar("X",FLENG[5],SetTo,1),SetCVar("X",FLENG[6],SetTo,1)})
		CMov(AllPlayers,V(FLENG[8]),V(FLENG[2])) -- Sin.i << i - pi
		CSub(AllPlayers,V(FLENG[8]),Range*2)
		CMov(AllPlayers,V(FLENG[7]),Range*3) -- Cos.i << 3pi/2 - i
		CSub(AllPlayers,V(FLENG[7]),V(FLENG[2]))
	CElseX()
		DoActionsX(AllPlayers,{SetCVar("X",FLENG[5],SetTo,0),SetCVar("X",FLENG[6],SetTo,1)})
		CMov(AllPlayers,V(FLENG[8]),Range*4)
		CSub(AllPlayers,V(FLENG[8]),V(FLENG[2])) -- Sin.i << 2pi - i
		CMov(AllPlayers,V(FLENG[7]),V(FLENG[2]))
		CSub(AllPlayers,V(FLENG[7]),Range*3) -- Cos.i << i - 3pi/2
	CIfXEnd()

	CMov(AllPlayers,V(FLENG[4]),VArr(FLENGVA,V(FLENG[8])))
	CMov(AllPlayers,V(FLENG[3]),VArr(FLENGVA,V(FLENG[7])))

	f_Mul(AllPlayers,V(FLENG[4]),V(FLENG[1]))
	f_Mul(AllPlayers,V(FLENG[3]),V(FLENG[1]))

	CiDiv(AllPlayers,V(FLENG[4]),0x10000)
	CiDiv(AllPlayers,V(FLENG[3]),0x10000)

	CIfX(AllPlayers,CVar("X",FLENG[5],Exactly,1))
		CNeg(AllPlayers,V(FLENG[3]))
	CIfXEnd()

	CIfX(AllPlayers,CVar("X",FLENG[6],Exactly,1))
		CNeg(AllPlayers,V(FLENG[4]))
	CIfXEnd()

	Trigger { 
		players = {AllPlayers},
		conditions = {
			Label(FuncAlloc+1);
		},
		flag = {Preserved}
	}

	FLENGCall1 = FuncAlloc
	FLENGCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

-- f_Atan2 - Ret[1] : Input Y  Ret[2] = X | Ret[3] = Θ  
	for i = 0, 3 do
		CVariable(AllPlayers,FuncAlloc+i) -- Local Variable
		table.insert(FATAN,FuncAlloc+i)
	end
	FuncAlloc = FuncAlloc + 4

	Trigger { 
		players = {AllPlayers},
		conditions = {
			Label(FuncAlloc);
		},
		flag = {Preserved}
	}
	FATANCall1 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

	CIfX(AllPlayers,CVar("X",FATAN[1],AtLeast,0x80000000)) 
		CIfX(AllPlayers,CVar("X",FATAN[2],AtLeast,0x80000000)) -- 3사분면
			DoActionsX(AllPlayers,{SetCVar("X",FATAN[4],SetTo,3)}) -- Θ + pi
			CNeg(AllPlayers,V(FATAN[1]))
			CNeg(AllPlayers,V(FATAN[2]))
		CElseX() -- 4사분면
			DoActionsX(AllPlayers,{SetCVar("X",FATAN[4],SetTo,4)}) -- 2pi - Θ
			CNeg(AllPlayers,V(FATAN[1]))
		CIfXEnd()
	CElseX()
		CIfX(AllPlayers,CVar("X",FATAN[2],AtLeast,0x80000000)) -- 2사분면
			DoActionsX(AllPlayers,{SetCVar("X",FATAN[4],SetTo,2)}) -- pi - Θ
			CNeg(AllPlayers,V(FATAN[2]))
		CElseX() -- 1사분면
			DoActionsX(AllPlayers,{SetCVar("X",FATAN[4],SetTo,1)}) -- Θ
		CIfXEnd()
	CIfXEnd()

	CMul(AllPlayers,V(FATAN[1]),0x10000,"X","X",0xFFFFF)

	f_Div(AllPlayers,V(FATAN[1]),V(FATAN[2]))

	Trigger { 
		players = {AllPlayers},
		conditions = {
			Label(0);
			CVar("X",FATAN[1],AtMost,0x10000*math.tan(math.rad(1*90/8)));
		},
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",FuncAlloc,0,0,1);
			SetCtrigX("X",FuncAlloc+1,0x178,0,SetTo,"X","X",0x4,1,0);
			SetCtrigX("X",FuncAlloc+1,0x17C,0,SetTo,"X","X",0,0,1);
		},
		flag = {Preserved}
	}
	Trigger { 
		players = {AllPlayers},
		conditions = {
			Label(0);
			CVar("X",FATAN[1],AtMost,0x10000*math.tan(math.rad(2*90/8)));
		},
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",FuncAlloc,0,0,math.floor(Range/8));
			SetCtrigX("X",FuncAlloc+1,0x178,0,SetTo,"X","X",0x4,1,0);
			SetCtrigX("X",FuncAlloc+1,0x17C,0,SetTo,"X","X",0,0,1);
		},
		flag = {Preserved}
	}
	Trigger { 
		players = {AllPlayers},
		conditions = {
			Label(0);
			CVar("X",FATAN[1],AtMost,0x10000*math.tan(math.rad(3*90/8)));
		},
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",FuncAlloc,0,0,math.floor(2*Range/8));
			SetCtrigX("X",FuncAlloc+1,0x178,0,SetTo,"X","X",0x4,1,0);
			SetCtrigX("X",FuncAlloc+1,0x17C,0,SetTo,"X","X",0,0,1);
		},
		flag = {Preserved}
	}
	Trigger { 
		players = {AllPlayers},
		conditions = {
			Label(0);
			CVar("X",FATAN[1],AtMost,0x10000*math.tan(math.rad(4*90/8)));
		},
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",FuncAlloc,0,0,math.floor(3*Range/8));
			SetCtrigX("X",FuncAlloc+1,0x178,0,SetTo,"X","X",0x4,1,0);
			SetCtrigX("X",FuncAlloc+1,0x17C,0,SetTo,"X","X",0,0,1);
		},
		flag = {Preserved}
	}
	Trigger { 
		players = {AllPlayers},
		conditions = {
			Label(0);
			CVar("X",FATAN[1],AtMost,0x10000*math.tan(math.rad(5*90/8)));
		},
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",FuncAlloc,0,0,math.floor(4*Range/8));
			SetCtrigX("X",FuncAlloc+1,0x178,0,SetTo,"X","X",0x4,1,0);
			SetCtrigX("X",FuncAlloc+1,0x17C,0,SetTo,"X","X",0,0,1);
		},
		flag = {Preserved}
	}
	Trigger { 
		players = {AllPlayers},
		conditions = {
			Label(0);
			CVar("X",FATAN[1],AtMost,0x10000*math.tan(math.rad(6*90/8)));
		},
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",FuncAlloc,0,0,math.floor(5*Range/8));
			SetCtrigX("X",FuncAlloc+1,0x178,0,SetTo,"X","X",0x4,1,0);
			SetCtrigX("X",FuncAlloc+1,0x17C,0,SetTo,"X","X",0,0,1);
		},
		flag = {Preserved}
	}
	Trigger { 
		players = {AllPlayers},
		conditions = {
			Label(0);
			CVar("X",FATAN[1],AtMost,0x10000*math.tan(math.rad(7*90/8)));
		},
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",FuncAlloc,0,0,math.floor(6*Range/8));
			SetCtrigX("X",FuncAlloc+1,0x178,0,SetTo,"X","X",0x4,1,0);
			SetCtrigX("X",FuncAlloc+1,0x17C,0,SetTo,"X","X",0,0,1);
		},
		flag = {Preserved}
	}
	Trigger { 
		players = {AllPlayers},
		conditions = {
			Label(0);
		},
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",FuncAlloc,0,0,math.floor(7*Range/8));
			SetCtrigX("X",FuncAlloc+1,0x178,0,SetTo,"X","X",0x4,1,0);
			SetCtrigX("X",FuncAlloc+1,0x17C,0,SetTo,"X","X",0,0,1);
		},
		flag = {Preserved}
	}
	Trigger { 
		players = {AllPlayers},
		conditions = {
			Label(FuncAlloc);
		},
		flag = {Preserved}
	}
	FuncAlloc = FuncAlloc + 1
	for i = 0, Range-1 do
		Trigger { 
			players = {AllPlayers},
			conditions = {
				Label(0);
				CVar("X",FATAN[1],AtMost,0x10000*math.tan(math.rad(i*90/Range)));
			},
			actions = {
				SetCVar("X",FATAN[3],SetTo,i);
				SetCtrigX("X","X",0x4,0,SetTo,"X",FuncAlloc,0,0,0);
				SetCtrigX("X",FuncAlloc,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FuncAlloc,0x15C,0,SetTo,"X","X",0,0,1);
			},
			flag = {Preserved}
		}
	end
		Trigger { 
			players = {AllPlayers},
			conditions = {
				Label(0);
			},
			actions = {
				SetCVar("X",FATAN[3],SetTo,Range);
				SetCtrigX("X","X",0x4,0,SetTo,"X",FuncAlloc,0,0,0);
				SetCtrigX("X",FuncAlloc,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FuncAlloc,0x15C,0,SetTo,"X","X",0,0,1);
			},
			flag = {Preserved}
		}

	Trigger { 
		players = {AllPlayers},
		conditions = {
			Label(FuncAlloc);
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			SetDeaths(0,SetTo,0,0);
		},
		flag = {Preserved}
	}
	FuncAlloc = FuncAlloc + 1

	CIfX(AllPlayers,CVar("X",FATAN[4],Exactly,2))
		CMov(AllPlayers,V(FATAN[3]),_Sub(_Mov(Range*2),V(FATAN[3])))
	CElseIfX(CVar("X",FATAN[4],Exactly,3))
		CAdd(AllPlayers,V(FATAN[3]),Range*2)
	CElseIfX(CVar("X",FATAN[4],Exactly,4))
		CMov(AllPlayers,V(FATAN[3]),_Sub(_Mov(Range*4),V(FATAN[3])))
	CIfXEnd()

	Trigger { 
		players = {AllPlayers},
		conditions = {
			Label(FuncAlloc);
		},
		flag = {Preserved}
	}

	FATANCall2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1
end

FRAND = 0
FRANDCall1 = 0
FRANDCall2 = 0
FPSTR = {}
FPSTRCall1 = 0
FPSTRCall2 = 0
FPSTRX = {}
FPSTRXCall1 = 0
FPSTRXCall2 = 0
FPTBL = {}
FPTBLCall1 = 0
FPTBLCall2 = 0
function Include_MiscFunctions(SeedSwitch) -- f_Rand 
-- f_Rand - Ret[1] : Output  
	if SeedSwitch == "X" or nil then
		Need_SeedSwitch_Error()
	end

	CVariable(AllPlayers,FuncAlloc)
	FRAND = FuncAlloc
	FuncAlloc = FuncAlloc + 1

	Trigger { 
			players = {AllPlayers},
			conditions = {
				Label(FuncAlloc);
			},
			actions = {
				SetSwitch(SeedSwitch,Random);
				SetCVar("X",FRAND,SetTo,0);
			},
			flag = {Preserved}
		}
	for i = 31, 0, -1 do
		Trigger { 
			players = {AllPlayers},
			conditions = {
				Label(0);
				Switch(SeedSwitch,Set);
			},
			actions = {
				SetCVar("X",FRAND,Add,2^i);
			},
			flag = {Preserved}
		}
		if i ~= 0 then
			Trigger { 
				players = {AllPlayers},
				actions = {
					SetSwitch(SeedSwitch,Random);
				},
				flag = {Preserved}
			}
		end
	end
	Trigger { 
			players = {AllPlayers},
			conditions = {
				Label(FuncAlloc+1);
			},
			flag = {Preserved}
		}

	FRANDCall1 = FuncAlloc
	FRANDCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2
-- f_GetStrptr - Ret[1] : StringId  Ret[2] = Type | Ret[3] = Strptr  
	for i = 0, 2 do
		CVariable(AllPlayers,FuncAlloc+i) -- Local Variable
		table.insert(FPSTR,FuncAlloc+i)
	end
	FuncAlloc = FuncAlloc + 3

	Trigger { 
			players = {AllPlayers},
			conditions = {
				Label(FuncAlloc);
			},
			actions = {
				SetCVar("X",FPSTR[3],SetTo,0x191943C8);
				SetMemory(0x6509B0,SetTo,EPD(0x191943C8));
				SetCtrig1X("X",FPSTR[1],0x158,0,SetTo,EPD(0x6509B0));
				SetCtrig1X("X",FPSTR[1],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",FPSTR[1],0x160,0,SetTo,Add*16777216,0xFF000000);
				CallLabelAlways("X",FPSTR[1],0);
			},
			flag = {Preserved}
		}

	CIfX(AllPlayers,CVar("X",FPSTR[2],Exactly,0)) -- 0x0000FFFF
		for i = 0, 15 do
			local CBit = 2^i
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					   	DeathsX(CurrentPlayer,Exactly,CBit,0,CBit);
					},
					actions = {
						SetCtrig1X("X",FPSTR[3],0x15C,0,Add,CBit);
					},
					flag = {Preserved}
				}
		end
	CElseX()
		for i = 16, 31 do
			local CBit = 2^i
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					   	DeathsX(CurrentPlayer,Exactly,CBit,0,CBit);
					},
					actions = {
						SetCtrig1X("X",FPSTR[3],0x15C,0,Add,CBit/65536);
					},
					flag = {Preserved}
				}
		end
	CIfXEnd()

	Trigger { 
			players = {AllPlayers},
			conditions = {
				Label(FuncAlloc+1);
			},
			flag = {Preserved}
		}

	FPSTRCall1 = FuncAlloc
	FPSTRCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2
-- f_GetStrXptr - Ret[1] : StringId | Ret[2] = Strptr  
	for i = 0, 1 do
		CVariable(AllPlayers,FuncAlloc+i) -- Local Variable
		table.insert(FPSTRX,FuncAlloc+i)
	end
	FuncAlloc = FuncAlloc + 2

	Trigger { 
			players = {AllPlayers},
			conditions = {
				Label(FuncAlloc);
			},
			actions = {
				SetCVar("X",FPSTRX[2],SetTo,0x191943C8);
				SetMemory(0x6509B0,SetTo,EPD(0x191943C8));
				SetCtrig1X("X",FPSTRX[1],0x158,0,SetTo,EPD(0x6509B0));
				SetCtrig1X("X",FPSTRX[1],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",FPSTRX[1],0x160,0,SetTo,Add*16777216,0xFF000000);
				CallLabelAlways("X",FPSTRX[1],0);
			},
			flag = {Preserved}
		}

	for i = 0, 31 do
		local CBit = 2^i
		Trigger {
				players = {AllPlayers},
				conditions = {
					Label(0);
				   	DeathsX(CurrentPlayer,Exactly,CBit,0,CBit);
				},
				actions = {
					SetCtrig1X("X",FPSTRX[2],0x15C,0,Add,CBit);
				},
				flag = {Preserved}
			}
	end

	Trigger { 
			players = {AllPlayers},
			conditions = {
				Label(FuncAlloc+1);
			},
			flag = {Preserved}
		}

	FPSTRXCall1 = FuncAlloc
	FPSTRXCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2
-- f_GetTblptr - Ret[1] : Tbl Index  Ret[2] = Type | Ret[3] = Tblptr  
	for i = 0, 2 do
		CVariable(AllPlayers,FuncAlloc+i) -- Local Variable
		table.insert(FPTBL,FuncAlloc+i)
	end
	FuncAlloc = FuncAlloc + 3

	Trigger { 
			players = {AllPlayers},
			conditions = {
				Label(FuncAlloc);
			},
			actions = {
				SetCVar("X",FPTBL[3],SetTo,0x19184660);
				SetMemory(0x6509B0,SetTo,EPD(0x19184660));
				SetCtrig1X("X",FPTBL[1],0x158,0,SetTo,EPD(0x6509B0));
				SetCtrig1X("X",FPTBL[1],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",FPTBL[1],0x160,0,SetTo,Add*16777216,0xFF000000);
				CallLabelAlways("X",FPTBL[1],0);
			},
			flag = {Preserved}
		}

	CIfX(AllPlayers,CVar("X",FPTBL[2],Exactly,0)) -- 0x0000FFFF
		for i = 0, 15 do
			local CBit = 2^i
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					   	DeathsX(CurrentPlayer,Exactly,CBit,0,CBit);
					},
					actions = {
						SetCtrig1X("X",FPTBL[3],0x15C,0,Add,CBit);
					},
					flag = {Preserved}
				}
		end
	CElseX()
		for i = 16, 31 do
			local CBit = 2^i
			Trigger {
					players = {AllPlayers},
					conditions = {
						Label(0);
					   	DeathsX(CurrentPlayer,Exactly,CBit,0,CBit);
					},
					actions = {
						SetCtrig1X("X",FPTBL[3],0x15C,0,Add,CBit/65536);
					},
					flag = {Preserved}
				}
		end
	CIfXEnd()

	Trigger { 
			players = {AllPlayers},
			conditions = {
				Label(FuncAlloc+1);
			},
			flag = {Preserved}
		}

	FPTBLCall1 = FuncAlloc
	FPTBLCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2
end

-- 함수 호출형 최종 연산 함수 (f_) ------------------------------------------------------

function f_Movcpy(PlayerID,Dest,SourceVA,Size) -- VA index = 상수 (CPRead)
	STPopTrigArr(PlayerID)
	-- Input Data CRet[1] << Dest / CRet[2] << VAOffset / CRet[3] << Size (Offset)

	if type(Dest) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMOVE[1],0x15C,0,SetTo,Dest);
			},
			flag = {Preserved}
		}
	elseif Dest[4] == "VA" then
		local TempRet = {"X",FMOVE[1],0,"V"}
		MovX(PlayerID,TempRet,Dest)
		Dest = TempRet
	elseif Dest[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",FMOVE[1],0x15C,1,0);
				SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Dest[1],Dest[2],Dest[3]);
			},
			flag = {Preserved}
		}
	end

	if type(Size) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMOVE[3],0x15C,0,SetTo,Size);
			},
			flag = {Preserved}
		}
	elseif Size[4] == "VA" then
		local TempRet = {"X",FMOVE[3],0,"V"}
		MovX(PlayerID,TempRet,Size)
		Size = TempRet
	elseif Size[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Size[1],Size[2],0x158,Size[3],SetTo,"X",FMOVE[3],0x15C,1,0);
				SetCtrig1X(Size[1],Size[2],0x148,Size[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Size[1],Size[2],0x160,Size[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Size[1],Size[2],Size[3]);
			},
			flag = {Preserved}
		}
	end

	if SourceVA[4] == "V" then -- ※ MovX는 CPRead방식으로 Cp값 변경하므로 Cp값 자체를 전달하는 SourceVA인자는 맨 밑에 있어야함
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig2X(0x6509B0,SetTo,SourceVA[1],SourceVA[2],0,1,SourceVA[3]); -- VArray Header +0x0
				SetCtrigX("X",FMOVE[2],0x15C,0,SetTo,SourceVA[1],SourceVA[2],0,0,SourceVA[3]);
			},
			flag = {Preserved}
		}
	elseif SourceVA[4] == "VA" then
		local TempRet = {"X",FMOVE[2],0,"V"}
		TMem(PlayerID,TempRet,SourceVA,0,0,1)
		Trigger {--(CPRead)로 값 출력
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig2X(0x6509B0,SetTo,SourceVA[5][1],SourceVA[5][2],0,1,SourceVA[5][3]); 
					SetMemory(0x6509B0,Add,SourceVA[6]);
					SetCtrig1X(SourceVA[1],SourceVA[2],0x148,SourceVA[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(SourceVA[1],SourceVA[2],0x160,SourceVA[3],SetTo,Add*16777216,0xFF000000);
					SetCtrig1X(SourceVA[1],SourceVA[2],0x158,SourceVA[3],SetTo,EPD(0x6509B0)); 
					CallLabelAlways(SourceVA[1],SourceVA[2],SourceVA[3]);
				},
				flag = {Preserved}
		}
	end

	-- Call f_Movcpy
	Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x4,0,SetTo,"X",FMOVECall0,0x0,0,0);
					SetCtrigX("X",FMOVECall2,0x4,0,SetTo,"X","X",0x0,0,1);
				},
				flag = {Preserved}
			}
	if FMOVECall1 == 0 then
		Need_Include_DataTransfer()
	end

	RecoverCp(PlayerID)
end

function f_MovcpyEPD(PlayerID,Dest,SourceVA,Size,InitBytes) -- VA index = 상수 (CPRead)
	STPopTrigArr(PlayerID)
	-- Input Data CRet[1] << Dest / CRet[2] << VAOffset / CRet[3] << Size (EPD)

	local InitMask
	if InitBytes == "X" or InitBytes == nil then
		InitBytes = 0
	end
	if InitBytes == 0 then 
		InitMask = 0xFFFFFFFF
	elseif InitBytes == 1 then
		InitMask = 0xFFFFFF00
	elseif InitBytes == 2 then
		InitMask = 0xFFFF0000
	elseif InitBytes == 3 then
		InitMask = 0xFF000000
	else
		f_MovcpyEPD_InputData_Error()
	end

	if type(Dest) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMOVE[1],0x15C,0,SetTo,Dest);
			},
			flag = {Preserved}
		}
	elseif Dest[4] == "VA" then
		local TempRet = {"X",FMOVE[1],0,"V"}
		MovX(PlayerID,TempRet,Dest)
		Dest = TempRet
	elseif Dest[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",FMOVE[1],0x15C,1,0);
				SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Dest[1],Dest[2],Dest[3]);
			},
			flag = {Preserved}
		}
	end

	if type(Size) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMOVE[3],0x15C,0,SetTo,Size);
			},
			flag = {Preserved}
		}
	elseif Size[4] == "VA" then
		local TempRet = {"X",FMOVE[3],0,"V"}
		MovX(PlayerID,TempRet,Size)
		Size = TempRet
	elseif Size[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Size[1],Size[2],0x158,Size[3],SetTo,"X",FMOVE[3],0x15C,1,0);
				SetCtrig1X(Size[1],Size[2],0x148,Size[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Size[1],Size[2],0x160,Size[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Size[1],Size[2],Size[3]);
			},
			flag = {Preserved}
		}
	end

	if SourceVA[4] == "V" then -- ※ MovX는 CPRead방식으로 Cp값 변경하므로 Cp값 자체를 전달하는 SourceVA인자는 맨 밑에 있어야함
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig2X(0x6509B0,SetTo,SourceVA[1],SourceVA[2],0,1,SourceVA[3]); -- VArray Header +0x0
				SetCtrigX("X",FMOVE[2],0x15C,0,SetTo,SourceVA[1],SourceVA[2],0,0,SourceVA[3]);
				SetCtrig1X("X",FMOVE[4],0x15C,0,SetTo,InitMask);
			},
			flag = {Preserved}
		}
	elseif SourceVA[4] == "VA" then
		local TempRet = {"X",FMOVE[2],0,"V"}
		TMem(PlayerID,TempRet,SourceVA,0,0,1)
		Trigger {--(CPRead)로 값 출력
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X",FMOVE[4],0x15C,0,SetTo,InitMask);
					SetCtrig2X(0x6509B0,SetTo,SourceVA[5][1],SourceVA[5][2],0,1,SourceVA[5][3]); 
					SetMemory(0x6509B0,Add,SourceVA[6]);
					SetCtrig1X(SourceVA[1],SourceVA[2],0x148,SourceVA[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(SourceVA[1],SourceVA[2],0x160,SourceVA[3],SetTo,Add*16777216,0xFF000000);
					SetCtrig1X(SourceVA[1],SourceVA[2],0x158,SourceVA[3],SetTo,EPD(0x6509B0)); 
					CallLabelAlways(SourceVA[1],SourceVA[2],SourceVA[3]);
				},
				flag = {Preserved}
		}
	end
	-- Call f_MovcpyEPD
	Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x4,0,SetTo,"X",FMOVECall1,0x0,0,0);
					SetCtrigX("X",FMOVECall2,0x4,0,SetTo,"X","X",0x0,0,1);
				},
				flag = {Preserved}
			}
	if FMOVECall1 == 0 then
		Need_Include_DataTransfer()
	end

	RecoverCp(PlayerID)
end

function f_ReadcpyEPD(PlayerID,DestVA,Source,Size)
	STPopTrigArr(PlayerID)
	-- Input Data CRet[1] << DestVA / CRet[2] << Source / CRet[3] << Size (EPD)
		
	if DestVA[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX("X",FMEME[1],0x15C,0,SetTo,DestVA[1],DestVA[2],0x15C,1,DestVA[3]);
			},
			flag = {Preserved}
		}
	elseif DestVA[4] == "VA" then
		local TempRet = {"X",FMEME[1],0,"V"}
		MovZ(PlayerID,TempRet,DestVA,0x15C)
		DestVA = TempRet
	end

	if type(Source) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMEME[2],0x15C,0,SetTo,Source);
			},
			flag = {Preserved}
		}
	elseif Source[4] == "VA" then
		local TempRet = {"X",FMEME[2],0,"V"}
		MovX(PlayerID,TempRet,Source)
		Source = TempRet
	elseif Source[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",FMEME[2],0x15C,1,0);
				SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Source[1],Source[2],Source[3]);
			},
			flag = {Preserved}
		}
	end

	if type(Size) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMEME[3],0x15C,0,SetTo,Size);
			},
			flag = {Preserved}
		}
	elseif Size[4] == "VA" then
		local TempRet = {"X",FMEME[3],0,"V"}
		MovX(PlayerID,TempRet,Size)
		Size = TempRet
	elseif Size[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Size[1],Size[2],0x158,Size[3],SetTo,"X",FMEME[3],0x15C,1,0);
				SetCtrig1X(Size[1],Size[2],0x148,Size[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Size[1],Size[2],0x160,Size[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Size[1],Size[2],Size[3]);
			},
			flag = {Preserved}
		}
	end

	-- Call f_MemcpyEPD
	Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x4,0,SetTo,"X",FMEMECall1,0x0,0,0);
					SetCtrigX("X",FMEMECall2,0x4,0,SetTo,"X","X",0x0,0,1);
					SetCtrig1X("X",FMEME[4],0x15C,0,SetTo,1);
				},
				flag = {Preserved}
			}
	if FMEMECall1 == 0 then
		Need_Include_DataTransfer()
	end
end

function f_MemcpyEPD(PlayerID,Dest,Source,Size) 
	STPopTrigArr(PlayerID)
	-- Input Data CRet[1] << Dest / CRet[2] << Source / CRet[3] << Size (EPD)
	if type(Dest) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMEME[1],0x15C,0,SetTo,Dest);
			},
			flag = {Preserved}
		}
	elseif Dest[4] == "VA" then
		local TempRet = {"X",FMEME[1],0,"V"}
		MovX(PlayerID,TempRet,Dest)
		Dest = TempRet
	elseif Dest[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",FMEME[1],0x15C,1,0);
				SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Dest[1],Dest[2],Dest[3]);
			},
			flag = {Preserved}
		}
	end

	if type(Source) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMEME[2],0x15C,0,SetTo,Source);
			},
			flag = {Preserved}
		}
	elseif Source[4] == "VA" then
		local TempRet = {"X",FMEME[2],0,"V"}
		MovX(PlayerID,TempRet,Source)
		Source = TempRet
	elseif Source[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",FMEME[2],0x15C,1,0);
				SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Source[1],Source[2],Source[3]);
			},
			flag = {Preserved}
		}
	end

	if type(Size) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMEME[3],0x15C,0,SetTo,Size);
			},
			flag = {Preserved}
		}
	elseif Size[4] == "VA" then
		local TempRet = {"X",FMEME[3],0,"V"}
		MovX(PlayerID,TempRet,Size)
		Size = TempRet
	elseif Size[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Size[1],Size[2],0x158,Size[3],SetTo,"X",FMEME[3],0x15C,1,0);
				SetCtrig1X(Size[1],Size[2],0x148,Size[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Size[1],Size[2],0x160,Size[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Size[1],Size[2],Size[3]);
			},
			flag = {Preserved}
		}
	end

	-- Call f_MemcpyEPD
	Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x4,0,SetTo,"X",FMEMECall1,0x0,0,0);
					SetCtrigX("X",FMEMECall2,0x4,0,SetTo,"X","X",0x0,0,1);
					SetCtrig1X("X",FMEME[4],0x15C,0,SetTo,0);
				},
				flag = {Preserved}
			}
	if FMEMECall1 == 0 then
		Need_Include_DataTransfer()
	end
end

function f_Readcpy(PlayerID,DestVA,Source,Size,InitBytes) 
	STPopTrigArr(PlayerID)
	-- Input Data CRet[1] << Dest / CRet[2] << Source / CRet[3] << Size (Offset)

	if InitBytes == nil or InitBytes == "X" then
		InitBytes = 0
	end
	if InitBytes >= 4 then
		f_Readcpy_InputData_Error()
	end
	if DestVA[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX("X",FMEM[1],0x15C,0,SetTo,DestVA[1],DestVA[2],0x15C,1,DestVA[3]);
				SetCtrig1X("X",FMEM[3],0x15C,0,SetTo,InitBytes);
			},
			flag = {Preserved}
		}
	elseif DestVA[4] == "VA" then
		local TempRet = {"X",FMEME[1],0,"V"}
		MovZ(PlayerID,TempRet,DestVA,0x15C)
		DestVA = TempRet
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMEM[3],0x15C,0,SetTo,InitBytes);
			},
			flag = {Preserved}
		}
	end

	if type(Source) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMEM[2],0x15C,0,SetTo,Source);
			},
			flag = {Preserved}
		}
	elseif Source[4] == "VA" then
		local TempRet = {"X",FMEM[2],0,"V"}
		MovX(PlayerID,TempRet,Source)
		Source = TempRet
	elseif Source[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",FMEM[2],0x15C,1,0);
				SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Source[1],Source[2],Source[3]);
			},
			flag = {Preserved}
		}
	end

	if type(Size) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMEM[5],0x15C,0,SetTo,Size);
			},
			flag = {Preserved}
		}
	elseif Size[4] == "VA" then
		local TempRet = {"X",FMEM[5],0,"V"}
		MovX(PlayerID,TempRet,Size)
		Size = TempRet
	elseif Size[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Size[1],Size[2],0x158,Size[3],SetTo,"X",FMEM[5],0x15C,1,0);
				SetCtrig1X(Size[1],Size[2],0x148,Size[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Size[1],Size[2],0x160,Size[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Size[1],Size[2],Size[3]);
			},
			flag = {Preserved}
		}
	end

	-- Call f_Memcpy
	Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x4,0,SetTo,"X",FMEMCall0,0x0,0,0);
					SetCtrigX("X",FMEMCall2,0x4,0,SetTo,"X","X",0x0,0,1);
					SetCtrig1X("X",FMEM[6],0x15C,0,SetTo,1);
				},
				flag = {Preserved}
			}
	if FMEMCall1 == 0 then
		Need_Include_DataTransferX()
	end
end

function f_ReadcpyX(PlayerID,DestVA,Source,SourceX,Size,InitBytes) 
	STPopTrigArr(PlayerID)
	-- Input Data CRet[1] << Dest / CRet[2] << Source / CRet[3] << Size (Offset)
	if InitBytes == nil or InitBytes == "X" then
		InitBytes = 0
	end
	if InitBytes >= 4 then
		f_ReadcpyX_InputData_Error()
	end
	if DestVA[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX("X",FMEM[1],0x15C,0,SetTo,DestVA[1],DestVA[2],0x15C,1,DestVA[3]);
				SetCtrig1X("X",FMEM[3],0x15C,0,SetTo,InitBytes);
			},
			flag = {Preserved}
		}
	elseif DestVA[4] == "VA" then
		local TempRet = {"X",FMEME[1],0,"V"}
		MovZ(PlayerID,TempRet,DestVA,0x15C)
		DestVA = TempRet
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMEM[3],0x15C,0,SetTo,InitBytes);
			},
			flag = {Preserved}
		}
	end

	if type(Source) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMEM[2],0x15C,0,SetTo,Source);
			},
			flag = {Preserved}
		}
	elseif Source[4] == "VA" then
		local TempRet = {"X",FMEM[2],0,"V"}
		MovX(PlayerID,TempRet,Source)
		Source = TempRet
	elseif Source[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",FMEM[2],0x15C,1,0);
				SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Source[1],Source[2],Source[3]);
			},
			flag = {Preserved}
		}
	end

	if type(SourceX) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMEM[4],0x15C,0,SetTo,SourceX);
			},
			flag = {Preserved}
		}
	elseif SourceX[4] == "VA" then
		local TempRet = {"X",FMEM[4],0,"V"}
		MovX(PlayerID,TempRet,SourceX)
		SourceX = TempRet
	elseif SourceX[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(SourceX[1],SourceX[2],0x158,SourceX[3],SetTo,"X",FMEM[4],0x15C,1,0);
				SetCtrig1X(SourceX[1],SourceX[2],0x148,SourceX[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(SourceX[1],SourceX[2],0x160,SourceX[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(SourceX[1],SourceX[2],SourceX[3]);
			},
			flag = {Preserved}
		}
	end

	if type(Size) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMEM[5],0x15C,0,SetTo,Size);
			},
			flag = {Preserved}
		}
	elseif Size[4] == "VA" then
		local TempRet = {"X",FMEM[5],0,"V"}
		MovX(PlayerID,TempRet,Size)
		Size = TempRet
	elseif Size[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Size[1],Size[2],0x158,Size[3],SetTo,"X",FMEM[5],0x15C,1,0);
				SetCtrig1X(Size[1],Size[2],0x148,Size[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Size[1],Size[2],0x160,Size[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Size[1],Size[2],Size[3]);
			},
			flag = {Preserved}
		}
	end

	-- Call f_Memcpy
	Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x4,0,SetTo,"X",FMEMCall1,0x0,0,0);
					SetCtrigX("X",FMEMCall2,0x4,0,SetTo,"X","X",0x0,0,1);
					SetCtrig1X("X",FMEM[6],0x15C,0,SetTo,1);
				},
				flag = {Preserved}
			}
	if FMEMCall1 == 0 then
		Need_Include_DataTransferX()
	end
end

function f_Memcpy(PlayerID,Dest,Source,Size) 
	STPopTrigArr(PlayerID)
	-- Input Data CRet[1] << Dest / CRet[2] << Source / CRet[3] << Size (Offset)
	if type(Dest) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMEM[1],0x15C,0,SetTo,Dest);
			},
			flag = {Preserved}
		}
	elseif Dest[4] == "VA" then
		local TempRet = {"X",FMEM[1],0,"V"}
		MovX(PlayerID,TempRet,Dest)
		Dest = TempRet
	elseif Dest[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",FMEM[1],0x15C,1,0);
				SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Dest[1],Dest[2],Dest[3]);
			},
			flag = {Preserved}
		}
	end

	if type(Source) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMEM[2],0x15C,0,SetTo,Source);
			},
			flag = {Preserved}
		}
	elseif Source[4] == "VA" then
		local TempRet = {"X",FMEM[2],0,"V"}
		MovX(PlayerID,TempRet,Source)
		Source = TempRet
	elseif Source[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",FMEM[2],0x15C,1,0);
				SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Source[1],Source[2],Source[3]);
			},
			flag = {Preserved}
		}
	end

	if type(Size) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMEM[5],0x15C,0,SetTo,Size);
			},
			flag = {Preserved}
		}
	elseif Size[4] == "VA" then
		local TempRet = {"X",FMEM[5],0,"V"}
		MovX(PlayerID,TempRet,Size)
		Size = TempRet
	elseif Size[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Size[1],Size[2],0x158,Size[3],SetTo,"X",FMEM[5],0x15C,1,0);
				SetCtrig1X(Size[1],Size[2],0x148,Size[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Size[1],Size[2],0x160,Size[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Size[1],Size[2],Size[3]);
			},
			flag = {Preserved}
		}
	end

	-- Call f_Memcpy
	Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x4,0,SetTo,"X",FMEMCall0,0x0,0,0);
					SetCtrigX("X",FMEMCall2,0x4,0,SetTo,"X","X",0x0,0,1);
					SetCtrig1X("X",FMEM[6],0x15C,0,SetTo,0);
				},
				flag = {Preserved}
			}
	if FMEMCall1 == 0 then
		Need_Include_DataTransferX()
	end
end

function f_MemcpyX(PlayerID,Dest,DestX,Source,SourceX,Size) 
	STPopTrigArr(PlayerID)
	-- Input Data CRet[1] << Dest / CRet[2] << Source / CRet[3] << Size (Offset)
	if type(Dest) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMEM[1],0x15C,0,SetTo,Dest);
			},
			flag = {Preserved}
		}
	elseif Dest[4] == "VA" then
		local TempRet = {"X",FMEM[1],0,"V"}
		MovX(PlayerID,TempRet,Dest)
		Dest = TempRet
	elseif Dest[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",FMEM[1],0x15C,1,0);
				SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Dest[1],Dest[2],Dest[3]);
			},
			flag = {Preserved}
		}
	end

	if type(Source) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMEM[2],0x15C,0,SetTo,Source);
			},
			flag = {Preserved}
		}
	elseif Source[4] == "VA" then
		local TempRet = {"X",FMEM[2],0,"V"}
		MovX(PlayerID,TempRet,Source)
		Source = TempRet
	elseif Source[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",FMEM[2],0x15C,1,0);
				SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Source[1],Source[2],Source[3]);
			},
			flag = {Preserved}
		}
	end

	if type(DestX) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMEM[3],0x15C,0,SetTo,DestX);
			},
			flag = {Preserved}
		}
	elseif DestX[4] == "VA" then
		local TempRet = {"X",FMEM[3],0,"V"}
		MovX(PlayerID,TempRet,DestX)
		DestX = TempRet
	elseif DestX[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(DestX[1],DestX[2],0x158,DestX[3],SetTo,"X",FMEM[3],0x15C,1,0);
				SetCtrig1X(DestX[1],DestX[2],0x148,DestX[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(DestX[1],DestX[2],0x160,DestX[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(DestX[1],DestX[2],DestX[3]);
			},
			flag = {Preserved}
		}
	end

	if type(SourceX) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMEM[4],0x15C,0,SetTo,SourceX);
			},
			flag = {Preserved}
		}
	elseif SourceX[4] == "VA" then
		local TempRet = {"X",FMEM[4],0,"V"}
		MovX(PlayerID,TempRet,SourceX)
		SourceX = TempRet
	elseif SourceX[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(SourceX[1],SourceX[2],0x158,SourceX[3],SetTo,"X",FMEM[4],0x15C,1,0);
				SetCtrig1X(SourceX[1],SourceX[2],0x148,SourceX[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(SourceX[1],SourceX[2],0x160,SourceX[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(SourceX[1],SourceX[2],SourceX[3]);
			},
			flag = {Preserved}
		}
	end

	if type(Size) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FMEM[5],0x15C,0,SetTo,Size);
			},
			flag = {Preserved}
		}
	elseif Size[4] == "VA" then
		local TempRet = {"X",FMEM[5],0,"V"}
		MovX(PlayerID,TempRet,Size)
		Size = TempRet
	elseif Size[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Size[1],Size[2],0x158,Size[3],SetTo,"X",FMEM[5],0x15C,1,0);
				SetCtrig1X(Size[1],Size[2],0x148,Size[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Size[1],Size[2],0x160,Size[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Size[1],Size[2],Size[3]);
			},
			flag = {Preserved}
		}
	end

	-- Call f_Memcpy
	Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x4,0,SetTo,"X",FMEMCall1,0x0,0,0);
					SetCtrigX("X",FMEMCall2,0x4,0,SetTo,"X","X",0x0,0,1);
					SetCtrig1X("X",FMEM[6],0x15C,0,SetTo,0);
				},
				flag = {Preserved}
			}
	if FMEMCall1 == 0 then
		Need_Include_DataTransferX()
	end
end

-- Include MiscFunc

function f_GetTblptr(PlayerID,Output,TBLIndex)
	STPopTrigArr(PlayerID)

	-- Input Data CRet[1],CRet[2] << TBL Index
	Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FPTBL[1],0x15C,0,SetTo,TBLIndex/2);
				SetCtrig1X("X",FPTBL[2],0x15C,0,SetTo,TBLIndex%2);
			},
			flag = {Preserved}
		}
	
-- Call f_GetTBLptr
	if FPTBLCall1 == 0 then
		Need_Include_MiscFunc()
	end

	Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX("X","X",0x4,0,SetTo,"X",FPTBLCall1,0x0,0,0);
				SetCtrigX("X",FPTBLCall2,0x4,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	-- Output Data CRet[2] = Output 
	if Output[4] == "V" then
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
				SetCtrigX("X",FPTBL[3],0x158,0,SetTo,Output[1],Output[2],0x15C,1,Output[3]);
				SetCtrig1X("X",FPTBL[3],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",FPTBL[3],0x160,0,SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways("X",FPTBL[3],0);
				},
				flag = {Preserved}
			}
	elseif Output[4] == "VA" then
		local TempRet = {"X",FPTBL[3],0,"V"}
		MovX(PlayerID,Output,TempRet)
	end

	RecoverCp(PlayerID)
end

function f_GetStrXptr(PlayerID,Output,StringId)
	STPopTrigArr(PlayerID)

	-- Input Data CRet[1] << StringId
	StringKey = ParseString(StringId)
	Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				Disabled(DisplayText(StringKey,4));
				SetCtrig1X("X",FPSTRX[1],0x15C,0,SetTo,StringKey);
			},
			flag = {Preserved}
		}
	
-- Call f_GetStrXptr
	if FPSTRXCall1 == 0 then
		Need_Include_MiscFunc()
	end

	Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX("X","X",0x4,0,SetTo,"X",FPSTRXCall1,0x0,0,0);
				SetCtrigX("X",FPSTRXCall2,0x4,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	-- Output Data CRet[2] = Output 
	if Output[4] == "V" then
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
				SetCtrigX("X",FPSTRX[2],0x158,0,SetTo,Output[1],Output[2],0x15C,1,Output[3]);
				SetCtrig1X("X",FPSTRX[2],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",FPSTRX[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways("X",FPSTRX[2],0);
				},
				flag = {Preserved}
			}
	elseif Output[4] == "VA" then
		local TempRet = {"X",FPSTRX[2],0,"V"}
		MovX(PlayerID,Output,TempRet)
	end

	RecoverCp(PlayerID)
	return StringKey
end

function f_GetStrptr(PlayerID,Output,StringId)
	STPopTrigArr(PlayerID)

	-- Input Data CRet[1],CRet[2] << StringId
	StringKey = ParseString(StringId)
	Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				Disabled(DisplayText(StringKey,4));
				SetCtrig1X("X",FPSTR[1],0x15C,0,SetTo,StringKey/2);
				SetCtrig1X("X",FPSTR[2],0x15C,0,SetTo,StringKey%2);
			},
			flag = {Preserved}
		}
	
-- Call f_GetStrptr
	if FPSTRCall1 == 0 then
		Need_Include_MiscFunc()
	end

	Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX("X","X",0x4,0,SetTo,"X",FPSTRCall1,0x0,0,0);
				SetCtrigX("X",FPSTRCall2,0x4,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	-- Output Data CRet[3] = Output 
	if Output[4] == "V" then
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
				SetCtrigX("X",FPSTR[3],0x158,0,SetTo,Output[1],Output[2],0x15C,1,Output[3]);
				SetCtrig1X("X",FPSTR[3],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",FPSTR[3],0x160,0,SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways("X",FPSTR[3],0);
				},
				flag = {Preserved}
			}
	elseif Output[4] == "VA" then
		local TempRet = {"X",FPSTR[3],0,"V"}
		MovX(PlayerID,Output,TempRet)
	end

	RecoverCp(PlayerID)
	return StringKey
end

function f_Rand(PlayerID,Dest)
	STPopTrigArr(PlayerID)

-- Call f_Rand
	if FRANDCall1 == 0 then
		Need_Include_MiscFunc()
	end

	Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX("X","X",0x4,0,SetTo,"X",FRANDCall1,0x0,0,0);
				SetCtrigX("X",FRANDCall2,0x4,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

-- Output Data CRet[1] = Output 
	if Dest[4] == "V" then
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
				SetCtrigX("X",FRAND,0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
				SetCtrig1X("X",FRAND,0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",FRAND,0x160,0,SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways("X",FRAND,0);
				},
				flag = {Preserved}
			}
	elseif Dest[4] == "VA" then
		local TempRet = {"X",FRAND,0,"V"}
		MovX(PlayerID,Dest,TempRet)
	end
end

-- Include MatheMatics

function f_Atan2(PlayerID,DeltaY,DeltaX,AngleOutput) -- 0xFFFF8000 <= X, Y <= 0x7FFF (-32768~+32767)
	STPopTrigArr(PlayerID)
	-- Input Data CRet[1] << DeltaY
	if type(DeltaY) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FATAN[1],0x15C,0,SetTo,DeltaY);
			},
			flag = {Preserved}
		}
	elseif DeltaY[4] == "VA" then
		local TempRet = {"X",FATAN[1],0,"V"}
		MovX(PlayerID,TempRet,DeltaY)
		DeltaY = TempRet
	elseif DeltaY[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(DeltaY[1],DeltaY[2],0x158,DeltaY[3],SetTo,"X",FATAN[1],0x15C,1,0);
				SetCtrig1X(DeltaY[1],DeltaY[2],0x148,DeltaY[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(DeltaY[1],DeltaY[2],0x160,DeltaY[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(DeltaY[1],DeltaY[2],DeltaY[3]);
			},
			flag = {Preserved}
		}
	end

	-- Input Data CRet[2] << DeltaX 
	if type(DeltaX) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FATAN[2],0x15C,0,SetTo,DeltaX);
			},
			flag = {Preserved}
		}
	elseif DeltaX[4] == "VA" then
		local TempRet = {"X",FATAN[2],0,"V"}
		MovX(PlayerID,TempRet,DeltaX)
		DeltaX = TempRet
	elseif DeltaX[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(DeltaX[1],DeltaX[2],0x158,DeltaX[3],SetTo,"X",FATAN[2],0x15C,1,0);
				SetCtrig1X(DeltaX[1],DeltaX[2],0x148,DeltaX[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(DeltaX[1],DeltaX[2],0x160,DeltaX[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(DeltaX[1],DeltaX[2],DeltaX[3]);
			},
			flag = {Preserved}
		}
	end

-- Call f_Atan2
	if FATANCall1 == 0 then
		Need_Include_MatheMatics()
	end
	Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX("X","X",0x4,0,SetTo,"X",FATANCall1,0x0,0,0);
				SetCtrigX("X",FATANCall2,0x4,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

-- Output Data CRet[3] = AngleOutput 
	if AngleOutput[4] == "V" then
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
				SetCtrigX("X",FATAN[3],0x158,0,SetTo,AngleOutput[1],AngleOutput[2],0x15C,1,AngleOutput[3]);
				SetCtrig1X("X",FATAN[3],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",FATAN[3],0x160,0,SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways("X",FATAN[3],0);
				},
				flag = {Preserved}
			}
	elseif AngleOutput[4] == "VA" then
		local TempRet = {"X",FATAN[3],0,"V"}
		MovX(PlayerID,AngleOutput,TempRet)
	end
end

function f_Lengthdir(PlayerID,Radius,Angle,CosOutput,SinOutput) -- 0xFFFF8000 <= Radius <= 0x7FFF (-32768~+32767)
	STPopTrigArr(PlayerID)
	-- Input Data CRet[1] << Radius 

	if type(Radius) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FLENG[1],0x15C,0,SetTo,Radius);
			},
			flag = {Preserved}
		}
	elseif Radius[4] == "VA" then
		local TempRet = {"X",FLENG[1],0,"V"}
		MovX(PlayerID,TempRet,Radius)
		Radius = TempRet
	elseif Radius[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Radius[1],Radius[2],0x158,Radius[3],SetTo,"X",FLENG[1],0x15C,1,0);
				SetCtrig1X(Radius[1],Radius[2],0x148,Radius[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Radius[1],Radius[2],0x160,Radius[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Radius[1],Radius[2],Radius[3]);
			},
			flag = {Preserved}
		}
	end
	-- Input Data CRet[2] << Angle 
	if type(Angle) == "number" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X("X",FLENG[2],0x15C,0,SetTo,Angle);
			},
			flag = {Preserved}
		}
	elseif Angle[4] == "VA" then
		local TempRet = {"X",FLENG[2],0,"V"}
		MovX(PlayerID,TempRet,Angle)
		Angle = TempRet
	elseif Angle[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Angle[1],Angle[2],0x158,Angle[3],SetTo,"X",FLENG[2],0x15C,1,0);
				SetCtrig1X(Angle[1],Angle[2],0x148,Angle[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Angle[1],Angle[2],0x160,Angle[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Angle[1],Angle[2],Angle[3]);
			},
			flag = {Preserved}
		}
	end

-- Call f_Lengthdir
	if FLENGCall1 == 0 then
		Need_Include_MatheMatics()
	end
	Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX("X","X",0x4,0,SetTo,"X",FLENGCall1,0x0,0,0);
				SetCtrigX("X",FLENGCall2,0x4,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

-- Output Data CRet[3] = CosOutput 
	if CosOutput[4] == "V" then
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
				SetCtrigX("X",FLENG[3],0x158,0,SetTo,CosOutput[1],CosOutput[2],0x15C,1,CosOutput[3]);
				SetCtrig1X("X",FLENG[3],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",FLENG[3],0x160,0,SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways("X",FLENG[3],0);
				},
				flag = {Preserved}
			}
	elseif CosOutput[4] == "VA" then
		local TempRet = {"X",FLENG[3],0,"V"}
		MovX(PlayerID,CosOutput,TempRet)
	end
-- Output Data CRet[4] = SinOutput 
	if SinOutput[4] == "V" then
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
				SetCtrigX("X",FLENG[4],0x158,0,SetTo,SinOutput[1],SinOutput[2],0x15C,1,SinOutput[3]);
				SetCtrig1X("X",FLENG[4],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",FLENG[4],0x160,0,SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways("X",FLENG[4],0);
				},
				flag = {Preserved}
			}
	elseif SinOutput[4] == "VA" then
		local TempRet = {"X",FLENG[4],0,"V"}
		MovX(PlayerID,SinOutput,TempRet)
	end
end

function f_Sqrt(PlayerID,Dest,Source)
	STPopTrigArr(PlayerID)
	-- Input Data CRet[1] << X 

	if Source[4] == "VA" then
		local TempRet = {"X",FSQRT[1],0,"V"}
		MovX(PlayerID,TempRet,Source)
		Source = TempRet
	elseif Source[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",FSQRT[1],0x15C,1,0);
				SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Source[1],Source[2],Source[3]);
			},
			flag = {Preserved}
		}
	end

-- Call f_Sqrt
	if FSQRTCall1 == 0 then
		Need_Include_MatheMatics()
	end
	Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX("X","X",0x4,0,SetTo,"X",FSQRTCall1,0x0,0,0);
				SetCtrigX("X",FSQRTCall2,0x4,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

-- Output Data CRet[2] = Output 
	if Dest[4] == "V" then
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
				SetCtrigX("X",FSQRT[2],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
				SetCtrig1X("X",FSQRT[2],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",FSQRT[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways("X",FSQRT[2],0);
				},
				flag = {Preserved}
			}
	elseif Dest[4] == "VA" then
		local TempRet = {"X",FSQRT[2],0,"V"}
		MovX(PlayerID,Dest,TempRet)
	end
end

-- Include DataTransfer

function f_EPD(PlayerID,Dest,Source)
	STPopTrigArr(PlayerID)
	-- Input Data CRet[1] << X 

	if Source[4] == "VA" then
		local TempRet = {"X",CRet[1],0,"V"}
		MovX(PlayerID,TempRet,Source)
		Source = TempRet
	elseif Source[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
				SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Source[1],Source[2],Source[3]);
			},
			flag = {Preserved}
		}
	end

-- Call f_Read
	if FEPDCall1 == 0 then
		Need_Include_DataTransfer()
	end
	Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX("X","X",0x4,0,SetTo,"X",FEPDCall1,0x0,0,0);
				SetCtrigX("X",FEPDCall2,0x4,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

-- Output Data CRet[2] = Output 
	if Dest[4] == "V" then
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
				SetCtrigX("X",CRet[2],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
				SetCtrig1X("X",CRet[2],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",CRet[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways("X",CRet[2],0);
				},
				flag = {Preserved}
			}
	elseif Dest[4] == "VA" then
		local TempRet = {"X",CRet[2],0,"V"}
		MovX(PlayerID,Dest,TempRet)
	end
end

function f_Read(PlayerID,Input,Output,EPDOutput,Mask,Clear) -- (CPRead) 방식으로 읽음
	STPopTrigArr(PlayerID)
	if Mask == nil or Mask == "X" then
		Mask = 0xFFFFFFFF
	end
	if Output == "X" then
		Output = nil
	end
	if EPDOutput == "X" then
		EPDOutput = nil
	end

	-- Input Data CRet[1] << EPD 
	if type(Input) == "number" then
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,SetTo,EPD(Input));
				},
				flag = {Preserved}
			}
	elseif Input == "Cp" then
		f_Read_InputData_Error()
	elseif Input[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Input[1],Input[2],0x158,Input[3],SetTo,"X",CRet[1],0x15C,1,0);
				SetCtrig1X(Input[1],Input[2],0x148,Input[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Input[1],Input[2],0x160,Input[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Input[1],Input[2],Input[3]);
			},
			flag = {Preserved}
		}
	elseif Input[4] == "VA" then
		local TempRet = {"X",CRet[1],0,"V"}
		MovX(PlayerID,TempRet,Input)
		Input = TempRet
	elseif Input[4] == "A" then
		local TempRet = {"X",CRet[1],0,"V"}
		MovZ(PlayerID,TempRet,Input)
		Input = TempRet
	else
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX("X",CRet[1],0x15C,0,SetTo,Input[1],Input[2],Input[3],1,Input[4]);
			},
			flag = {Preserved}
		}
	end

	-- Call f_Read
	Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x4,0,SetTo,"X",FReadCall1,0x0,0,0);
					SetCtrigX("X",FReadCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				},
				flag = {Preserved}
			}
	if FReadCall1 == 0 then
		Need_Include_DataTransfer()
	end

	
	-- Output Data CRet[2] = Output
	local ClearAct = {}
	if Clear == 1 then
		ClearAct = {SetCtrig1X(Output[1],Output[2],0x15C,Output[3],SetTo,0)}
	end
	if Output ~= nil then
		if Output[4] == "V" then
			Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
					ClearAct,
					SetCtrigX("X",CRet[2],0x158,0,SetTo,Output[1],Output[2],0x15C,1,Output[3]);
					SetCtrig1X("X",CRet[2],0x148,0,SetTo,Mask);
					SetCtrig1X("X",CRet[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways("X",CRet[2],0);
					},
					flag = {Preserved}
				}
		elseif Output[4] == "VA" then
			local TempRet = {"X",CRet[2],0,"V"}
			MovX(PlayerID,Output,TempRet,SetTo,Mask)
		end
	end
	
	-- Output Data CRet[3] = EPD(Output)
	if EPDOutput ~= nil then
		if EPDOutput[4] == "V" then
			Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
					SetCtrigX("X",CRet[3],0x158,0,SetTo,EPDOutput[1],EPDOutput[2],0x15C,1,EPDOutput[3]);
					SetCtrig1X("X",CRet[3],0x148,0,SetTo,0xFFFFFFFF);
					SetCtrig1X("X",CRet[3],0x160,0,SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways("X",CRet[3],0);
					},
					flag = {Preserved}
				}
		elseif EPDOutput[4] == "VA" then
			local TempRet = {"X",CRet[3],0,"V"}
			MovX(PlayerID,EPDOutput,TempRet)
		end
	end
	
	-- Option : RecoverCp
	RecoverCp(PlayerID)
end


function f_ReadX(PlayerID,Input,Output,Multiplier,Mask,Clear) -- (CPRead) 방식으로 읽음
	STPopTrigArr(PlayerID)
	if Mask == nil or Mask == "X" then
		Mask = 0xFFFFFFFF
	end
	if Output == "X" then
		Output = nil
	end

	-- Input Data CRet[1] << EPD 
	if type(Input) == "number" then
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,SetTo,EPD(Input));
				},
				flag = {Preserved}
			}
	elseif Input == "Cp" then
		f_Read_InputData_Error()
	elseif Input[4] == "V" then
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX(Input[1],Input[2],0x158,Input[3],SetTo,"X",CRet[1],0x15C,1,0);
				SetCtrig1X(Input[1],Input[2],0x148,Input[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Input[1],Input[2],0x160,Input[3],SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways(Input[1],Input[2],Input[3]);
			},
			flag = {Preserved}
		}
	elseif Input[4] == "VA" then
		local TempRet = {"X",CRet[1],0,"V"}
		MovX(PlayerID,TempRet,Input)
		Input = TempRet
	elseif Input[4] == "A" then
		local TempRet = {"X",CRet[1],0,"V"}
		MovZ(PlayerID,TempRet,Input)
		Input = TempRet
	else
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX("X",CRet[1],0x15C,0,SetTo,Input[1],Input[2],Input[3],1,Input[4]);
			},
			flag = {Preserved}
		}
	end

	-- Call f_ReadX
	local NextAct = {}
	local NextAct2 = {}
	local Mask2
	if Multiplier == "X" or Multiplier == nil then
		f_ReadX_InputData_Error()
	elseif Multiplier == 16777216 then
		table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall1,0x0,0,0))
		table.insert(NextAct,SetCtrigX("X",FReadXCall1,0x4,7,SetTo,"X","X",0x0,0,1))
		Mask2 = bit32.band(Mask*16777216, 0xFFFFFFFF) 
	elseif Multiplier == 65536 then
		if bit32.band(Mask, 0xFFFF) == 0x00FF then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall2,0x0,0,0))
			table.insert(NextAct,SetCtrigX("X",FReadXCall2,0x4,7,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall2,0x4,7,SetTo,"X",FReadXCall2,0x0,0,7+1))
		elseif bit32.band(Mask, 0xFFFF) == 0xFF00 then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall2,0x0,0,8))
			table.insert(NextAct,SetCtrigX("X",FReadXCall2,0x4,15,SetTo,"X","X",0x0,0,1))
		else -- bit32.band(Mask, 0xFFFF) == 0xFFFF
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall2,0x0,0,0))
			table.insert(NextAct,SetCtrigX("X",FReadXCall2,0x4,15,SetTo,"X","X",0x0,0,1))
		end
		Mask2 = bit32.band(Mask*65536, 0xFFFFFFFF) 
	elseif Multiplier == 256 then
		if bit32.band(Mask, 0xFFFFFF) == 0x0000FF then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall3,0x0,0,0))
			table.insert(NextAct,SetCtrigX("X",FReadXCall3,0x4,7,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall3,0x4,7,SetTo,"X",FReadXCall3,0x0,0,7+1))
		elseif bit32.band(Mask, 0xFFFFFF) == 0x00FF00 then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall3,0x0,0,8))
			table.insert(NextAct,SetCtrigX("X",FReadXCall3,0x4,15,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall3,0x4,15,SetTo,"X",FReadXCall3,0x0,0,15+1))
		elseif bit32.band(Mask, 0xFFFFFF) == 0xFF0000 then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall3,0x0,0,16))
			table.insert(NextAct,SetCtrigX("X",FReadXCall3,0x4,23,SetTo,"X","X",0x0,0,1))
		elseif bit32.band(Mask, 0xFFFFFF) == 0x00FFFF then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall3,0x0,0,0))
			table.insert(NextAct,SetCtrigX("X",FReadXCall3,0x4,15,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall3,0x4,15,SetTo,"X",FReadXCall3,0x0,0,15+1))
		elseif bit32.band(Mask, 0xFFFFFF) == 0xFFFF00 then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall3,0x0,0,8))
			table.insert(NextAct,SetCtrigX("X",FReadXCall3,0x4,23,SetTo,"X","X",0x0,0,1))
		elseif bit32.band(Mask, 0xFFFFFF) == 0xFF00FF then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall3,0x0,0,0))
			table.insert(NextAct,SetCtrigX("X",FReadXCall3,0x4,7,SetTo,"X",FReadXCall3,0x0,0,16))
			table.insert(NextAct,SetCtrigX("X",FReadXCall3,0x4,23,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall3,0x4,7,SetTo,"X",FReadXCall3,0x0,0,7+1))
		else -- bit32.band(Mask, 0xFFFFFF) == 0xFFFFFF
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall3,0x0,0,0))
			table.insert(NextAct,SetCtrigX("X",FReadXCall3,0x4,23,SetTo,"X","X",0x0,0,1))
		end
		Mask2 = bit32.band(Mask*256, 0xFFFFFFFF) 
	elseif Multiplier == 1 then
		if bit32.band(Mask, 0xFFFFFFFF) == 0x000000FF then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall4,0x0,0,0))
			table.insert(NextAct,SetCtrigX("X",FReadXCall4,0x4,7,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall4,0x4,7,SetTo,"X",FReadXCall4,0x0,0,7+1))
		elseif bit32.band(Mask, 0xFFFFFFFF) == 0x0000FF00 then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall4,0x0,0,8))
			table.insert(NextAct,SetCtrigX("X",FReadXCall4,0x4,15,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall4,0x4,15,SetTo,"X",FReadXCall4,0x0,0,15+1))
		elseif bit32.band(Mask, 0xFFFFFFFF) == 0x00FF0000 then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall4,0x0,0,16))
			table.insert(NextAct,SetCtrigX("X",FReadXCall4,0x4,23,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall4,0x4,23,SetTo,"X",FReadXCall4,0x0,0,23+1))
		elseif bit32.band(Mask, 0xFFFFFFFF) == 0xFF000000 then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall4,0x0,0,24))
			table.insert(NextAct,SetCtrigX("X",FReadXCall4,0x4,31,SetTo,"X","X",0x0,0,1))
		elseif bit32.band(Mask, 0xFFFFFFFF) == 0x0000FFFF then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall4,0x0,0,0))
			table.insert(NextAct,SetCtrigX("X",FReadXCall4,0x4,15,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall4,0x4,15,SetTo,"X",FReadXCall4,0x0,0,15+1))
		elseif bit32.band(Mask, 0xFFFFFFFF) == 0x00FFFF00 then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall4,0x0,0,8))
			table.insert(NextAct,SetCtrigX("X",FReadXCall4,0x4,23,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall4,0x4,23,SetTo,"X",FReadXCall4,0x0,0,23+1))
		elseif bit32.band(Mask, 0xFFFFFFFF) == 0xFFFF0000 then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall4,0x0,0,16))
			table.insert(NextAct,SetCtrigX("X",FReadXCall4,0x4,31,SetTo,"X","X",0x0,0,1))
		elseif bit32.band(Mask, 0xFFFFFFFF) == 0x00FFFFFF then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall4,0x0,0,0))
			table.insert(NextAct,SetCtrigX("X",FReadXCall4,0x4,23,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall4,0x4,23,SetTo,"X",FReadXCall4,0x0,0,23+1))
		elseif bit32.band(Mask, 0xFFFFFFFF) == 0xFFFFFF00 then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall4,0x0,0,8))
			table.insert(NextAct,SetCtrigX("X",FReadXCall4,0x4,31,SetTo,"X","X",0x0,0,1))
		elseif bit32.band(Mask, 0xFFFFFFFF) == 0x00FF00FF then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall4,0x0,0,0))
			table.insert(NextAct,SetCtrigX("X",FReadXCall4,0x4,7,SetTo,"X",FReadXCall4,0x0,0,16))
			table.insert(NextAct,SetCtrigX("X",FReadXCall4,0x4,23,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall4,0x4,7,SetTo,"X",FReadXCall4,0x0,0,7+1))
		elseif bit32.band(Mask, 0xFFFFFFFF) == 0xFF00FF00 then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall4,0x0,0,8))
			table.insert(NextAct,SetCtrigX("X",FReadXCall4,0x4,15,SetTo,"X",FReadXCall4,0x0,0,24))
			table.insert(NextAct,SetCtrigX("X",FReadXCall4,0x4,31,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall4,0x4,15,SetTo,"X",FReadXCall4,0x0,0,15+1))
		elseif bit32.band(Mask, 0xFFFFFFFF) == 0xFF0000FF then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall4,0x0,0,0))
			table.insert(NextAct,SetCtrigX("X",FReadXCall4,0x4,7,SetTo,"X",FReadXCall4,0x0,0,24))
			table.insert(NextAct,SetCtrigX("X",FReadXCall4,0x4,31,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall4,0x4,7,SetTo,"X",FReadXCall4,0x0,0,7+1))
		elseif bit32.band(Mask, 0xFFFFFFFF) == 0xFF00FFFF then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall4,0x0,0,0))
			table.insert(NextAct,SetCtrigX("X",FReadXCall4,0x4,15,SetTo,"X",FReadXCall4,0x0,0,24))
			table.insert(NextAct,SetCtrigX("X",FReadXCall4,0x4,31,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall4,0x4,15,SetTo,"X",FReadXCall4,0x0,0,15+1))
		elseif bit32.band(Mask, 0xFFFFFFFF) == 0xFFFF00FF then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall4,0x0,0,0))
			table.insert(NextAct,SetCtrigX("X",FReadXCall4,0x4,7,SetTo,"X",FReadXCall4,0x0,0,16))
			table.insert(NextAct,SetCtrigX("X",FReadXCall4,0x4,31,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall4,0x4,7,SetTo,"X",FReadXCall4,0x0,0,7+1))
		else -- bit32.band(Mask, 0xFFFFFFFF) == 0xFFFFFFFF
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall4,0x0,0,0))
			table.insert(NextAct,SetCtrigX("X",FReadXCall4,0x4,31,SetTo,"X","X",0x0,0,1))
		end
		Mask2 = bit32.band(Mask, 0xFFFFFFFF) 
	elseif Multiplier == 1/256 then
		if bit32.band(Mask, 0xFFFFFF00) == 0x0000FF00 then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall5,0x0,0,0))
			table.insert(NextAct,SetCtrigX("X",FReadXCall5,0x4,7,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall5,0x4,7,SetTo,"X",FReadXCall5,0x0,0,7+1))
		elseif bit32.band(Mask, 0xFFFFFF00) == 0x00FF0000 then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall5,0x0,0,8))
			table.insert(NextAct,SetCtrigX("X",FReadXCall5,0x4,15,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall5,0x4,15,SetTo,"X",FReadXCall5,0x0,0,15+1))
		elseif bit32.band(Mask, 0xFFFFFF00) == 0xFF000000 then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall5,0x0,0,16))
			table.insert(NextAct,SetCtrigX("X",FReadXCall5,0x4,23,SetTo,"X","X",0x0,0,1))
		elseif bit32.band(Mask, 0xFFFFFF00) == 0x00FFFF00 then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall5,0x0,0,0))
			table.insert(NextAct,SetCtrigX("X",FReadXCall5,0x4,15,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall5,0x4,15,SetTo,"X",FReadXCall5,0x0,0,15+1))
		elseif bit32.band(Mask, 0xFFFFFF00) == 0xFFFF0000 then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall5,0x0,0,8))
			table.insert(NextAct,SetCtrigX("X",FReadXCall5,0x4,23,SetTo,"X","X",0x0,0,1))
		elseif bit32.band(Mask, 0xFFFFFF00) == 0xFF00FF00 then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall5,0x0,0,0))
			table.insert(NextAct,SetCtrigX("X",FReadXCall5,0x4,7,SetTo,"X",FReadXCall5,0x0,0,16))
			table.insert(NextAct,SetCtrigX("X",FReadXCall5,0x4,23,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall5,0x4,7,SetTo,"X",FReadXCall5,0x0,0,7+1))
		else -- bit32.band(Mask, 0xFFFFFF00) == 0xFFFFFF00
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall5,0x0,0,0))
			table.insert(NextAct,SetCtrigX("X",FReadXCall5,0x4,23,SetTo,"X","X",0x0,0,1))
		end
		Mask2 = bit32.band(Mask/256, 0xFFFFFFFF) 
	elseif Multiplier == 1/65536 then
		if bit32.band(Mask, 0xFFFF0000) == 0x00FF0000 then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall6,0x0,0,0))
			table.insert(NextAct,SetCtrigX("X",FReadXCall6,0x4,7,SetTo,"X","X",0x0,0,1))
			table.insert(NextAct2,SetCtrigX("X",FReadXCall6,0x4,7,SetTo,"X",FReadXCall6,0x0,0,7+1))
		elseif bit32.band(Mask, 0xFFFF0000) == 0xFF000000 then 
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall6,0x0,0,8))
			table.insert(NextAct,SetCtrigX("X",FReadXCall6,0x4,15,SetTo,"X","X",0x0,0,1))
		else -- bit32.band(Mask, 0xFFFF0000) == 0xFFFF0000
			table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall6,0x0,0,0))
			table.insert(NextAct,SetCtrigX("X",FReadXCall6,0x4,15,SetTo,"X","X",0x0,0,1))
		end
		Mask2 = bit32.band(Mask/65536, 0xFFFFFFFF) 
	elseif Multiplier == 1/16777216 then
		table.insert(NextAct,SetCtrigX("X",FReadXCall0,0x4,1,SetTo,"X",FReadXCall7,0x0,0,0))
		table.insert(NextAct,SetCtrigX("X",FReadXCall7,0x4,7,SetTo,"X","X",0x0,0,1))
		Mask2 = bit32.band(Mask/16777216, 0xFFFFFFFF) 
	else
		f_ReadX_InputData_Error()
	end

	Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x4,0,SetTo,"X",FReadXCall0,0x0,0,0);
					NextAct,
				},
				flag = {Preserved}
			}
	Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					NextAct2,
				},
				flag = {Preserved}
			}
	if FReadXCall0 == 0 then
		Need_Include_DataTransfer()
	end

	-- Output Data CRet[2] = Output
	local ClearAct = {}
	if Clear == 1 then
		ClearAct = {SetCtrig1X(Output[1],Output[2],0x15C,Output[3],SetTo,0)}
	end
	if Output ~= nil then
		if Output[4] == "V" then
			Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
					},
					actions = {
					ClearAct,
					SetCtrigX("X",CRet[2],0x158,0,SetTo,Output[1],Output[2],0x15C,1,Output[3]);
					SetCtrig1X("X",CRet[2],0x148,0,SetTo,Mask2);
					SetCtrig1X("X",CRet[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways("X",CRet[2],0);
					},
					flag = {Preserved}
				}
		elseif Output[4] == "VA" then
			local TempRet = {"X",CRet[2],0,"V"}
			MovX(PlayerID,Output,TempRet,SetTo,Mask2)
		end
	end
	

	-- Option : RecoverCp
	RecoverCp(PlayerID)
end

-- Include ArithMetic

function f_Abs(PlayerID,Dest,Source,Mask)
	STPopTrigArr(PlayerID)
	if Mask == nil or Mask == "X" then
		Mask = 0xFFFFFFFF
	end
	if Source == "X" then
		Source = nil
	end

	-- Input Data CRet[1] << X 
	local PDest = Dest
	if Source == nil then
		if Dest[4] == "VA" then
			local TempRet = {"X",CRet[1],0,"V"}
			MovX(PlayerID,TempRet,Dest)
			Dest = TempRet
		else
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[1],0x15C,1,0);
					SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Dest[1],Dest[2],Dest[3]);
				},
				flag = {Preserved}
			}
		end
	else
		if Source[4] == "VA" then
			local TempRet = {"X",CRet[1],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		else
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}
		end
	end

	-- Call f_Abs
	Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x4,0,SetTo,"X",FABSCall1,0x0,0,0);
					SetCtrigX("X",FABSCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				},
				flag = {Preserved}
			}
	if FABSCall1 == 0 then
		Need_Include_ArithMetic()
	end

	-- Output Data CRet[2] = Output

	if PDest[4] == "V" then
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
				SetCtrigX("X",CRet[2],0x158,0,SetTo,PDest[1],PDest[2],0x15C,1,PDest[3]);
				SetCtrig1X("X",CRet[2],0x148,0,SetTo,Mask);
				SetCtrig1X("X",CRet[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways("X",CRet[2],0);
				},
				flag = {Preserved}
			}
	elseif PDest[4] == "VA" then
		local TempRet = {"X",CRet[2],0,"V"}
		MovX(PlayerID,PDest,TempRet)
	end

end
function f_Mul(PlayerID,Dest,Source,Multiplier,Mask)
	STPopTrigArr(PlayerID)
	if Mask == nil or Mask == "X" then
		Mask = 0xFFFFFFFF
	end
	if Multiplier == "X" then
		Multiplier = nil
	end

	-- Input Data CRet[1] << X / CRet[2] << Y
		
	local PDest = Dest
	if Multiplier == nil then
		if Dest[4] == "VA" then
			local TempRet = {"X",CRet[1],0,"V"}
			MovX(PlayerID,TempRet,Dest)
			Dest = TempRet
		else
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[1],0x15C,1,0);
					SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Dest[1],Dest[2],Dest[3]);
				},
				flag = {Preserved}
			}
		end
		if Source[4] == "VA" then
			local TempRet = {"X",CRet[2],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		else
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[2],0x15C,1,0);
					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}
		end
	else
		if Source[4] == "VA" then
			local TempRet = {"X",CRet[1],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		else
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}
		end
		if Multiplier[4] == "VA" then
			local TempRet = {"X",CRet[2],0,"V"}
			MovX(PlayerID,TempRet,Multiplier)
			Multiplier = TempRet
		else
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Multiplier[1],Multiplier[2],0x158,Multiplier[3],SetTo,"X",CRet[2],0x15C,1,0);
					SetCtrig1X(Multiplier[1],Multiplier[2],0x148,Multiplier[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Multiplier[1],Multiplier[2],0x160,Multiplier[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Multiplier[1],Multiplier[2],Multiplier[3]);
				},
				flag = {Preserved}
			}
		end
	end

	-- Call f_Mul
	Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x4,0,SetTo,"X",FMULCall0,0x0,0,0);
					SetCtrigX("X",FMULCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				},
				flag = {Preserved}
			}
	if FMULCall1 == 0 then
		Need_Include_ArithMetic()
	end

	-- Output Data CRet[3] = Output

	if PDest[4] == "V" then
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
				SetCtrigX("X",CRet[3],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
				SetCtrig1X("X",CRet[3],0x148,0,SetTo,Mask);
				SetCtrig1X("X",CRet[3],0x160,0,SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways("X",CRet[3],0);
				},
				flag = {Preserved}
			}
	elseif PDest[4] == "VA" then
		local TempRet = {"X",CRet[3],0,"V"}
		MovX(PlayerID,PDest,TempRet)
	end

end


function f_Div(PlayerID,Dest,Source,Divisor,Mask)
	STPopTrigArr(PlayerID)
	if Mask == nil or Mask == "X" then
		Mask = 0xFFFFFFFF
	end
	if Divisor == "X" then
		Divisor = nil
	end

	-- Input Data CRet[1] << X / CRet[2] << Y

	local PDest = Dest
	if Divisor == nil then
		if Dest[4] == "VA" then
			local TempRet = {"X",CRet[2],0,"V"}
			MovX(PlayerID,TempRet,Dest)
			Dest = TempRet
		else
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[2],0x15C,1,0);
					SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Dest[1],Dest[2],Dest[3]);
				},
				flag = {Preserved}
			}
		end
		if Source[4] == "VA" then
			local TempRet = {"X",CRet[1],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		else
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}
		end
	else
		if Source[4] == "VA" then
			local TempRet = {"X",CRet[2],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		else
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[2],0x15C,1,0);
					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}
		end
		if Divisor[4] == "VA" then
			local TempRet = {"X",CRet[1],0,"V"}
			MovX(PlayerID,TempRet,Divisor)
			Divisor = TempRet
		else
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Divisor[1],Divisor[2],0x158,Divisor[3],SetTo,"X",CRet[1],0x15C,1,0);
					SetCtrig1X(Divisor[1],Divisor[2],0x148,Divisor[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Divisor[1],Divisor[2],0x160,Divisor[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Divisor[1],Divisor[2],Divisor[3]);
				},
				flag = {Preserved}
			}
		end
	end

	-- Call f_Div
	Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x4,0,SetTo,"X",FDIVCall1,0x0,0,0);
					SetCtrigX("X",FDIVCall3,0x4,0,SetTo,"X","X",0x0,0,1);
				},
				flag = {Preserved}
			}
	if FDIVCall1 == 0 then
		Need_Include_ArithMetic()
	end

	-- Output Data CRet[3] = Output
	if PDest[4] == "V" then
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
				SetCtrigX("X",CRet[3],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
				SetCtrig1X("X",CRet[3],0x148,0,SetTo,Mask);
				SetCtrig1X("X",CRet[3],0x160,0,SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways("X",CRet[3],0);
				},
				flag = {Preserved}
			}
	elseif PDest[4] == "VA" then
		local TempRet = {"X",CRet[3],0,"V"}
		MovX(PlayerID,PDest,TempRet)
	end

end

function f_Mod(PlayerID,Dest,Source,Divisor,Mask)
	STPopTrigArr(PlayerID)
	if Mask == nil or Mask == "X" then
		Mask = 0xFFFFFFFF
	end
	if Divisor == "X" then
		Divisor = nil
	end

	-- Input Data CRet[1] << X / CRet[2] << Y
	local PDest = Dest
	if Divisor == nil then
		if Dest[4] == "VA" then
			local TempRet = {"X",CRet[2],0,"V"}
			MovX(PlayerID,TempRet,Dest)
			Dest = TempRet
		else
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[2],0x15C,1,0);
					SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Dest[1],Dest[2],Dest[3]);
				},
				flag = {Preserved}
			}
		end
		if Source[4] == "VA" then
			local TempRet = {"X",CRet[1],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		else
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}
		end
	else
		if Source[4] == "VA" then
			local TempRet = {"X",CRet[2],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		else
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[2],0x15C,1,0);
					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}
		end
		if Divisor[4] == "VA" then
			local TempRet = {"X",CRet[1],0,"V"}
			MovX(PlayerID,TempRet,Divisor)
			Divisor = TempRet
		else
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Divisor[1],Divisor[2],0x158,Divisor[3],SetTo,"X",CRet[1],0x15C,1,0);
					SetCtrig1X(Divisor[1],Divisor[2],0x148,Divisor[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Divisor[1],Divisor[2],0x160,Divisor[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Divisor[1],Divisor[2],Divisor[3]);
				},
				flag = {Preserved}
			}
		end
	end

	-- Call f_Div
	Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x4,0,SetTo,"X",FMODCall1,0x0,0,0);
					SetCtrigX("X",FMODCall3,0x4,0,SetTo,"X","X",0x0,0,1);
				},
				flag = {Preserved}
			}
	if FMODCall1 == 0 then
		Need_Include_ArithMetic()
	end

	-- Output Data CRet[2] = Output
	if PDest[4] == "V" then
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
				SetCtrigX("X",CRet[2],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
				SetCtrig1X("X",CRet[2],0x148,0,SetTo,Mask);
				SetCtrig1X("X",CRet[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways("X",CRet[2],0);
				},
				flag = {Preserved}
			}
	elseif PDest[4] == "VA" then
		local TempRet = {"X",CRet[2],0,"V"}
		MovX(PlayerID,PDest,TempRet)
	end

end

function f_iDiv(PlayerID,Dest,Source,Divisor,Mask)
	STPopTrigArr(PlayerID)
	if Mask == nil or Mask == "X" then
		Mask = 0xFFFFFFFF
	end
	if Divisor == "X" then
		Divisor = nil
	end

	-- Input Data CRet[1] << X / CRet[2] << Y

	local PDest = Dest
	if Divisor == nil then
		if Dest[4] == "VA" then
			local TempRet = {"X",CRet[2],0,"V"}
			MovX(PlayerID,TempRet,Dest)
			Dest = TempRet
		else
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[2],0x15C,1,0);
					SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Dest[1],Dest[2],Dest[3]);
				},
				flag = {Preserved}
			}
		end
		if Source[4] == "VA" then
			local TempRet = {"X",CRet[1],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		else
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}
		end
	else
		if Source[4] == "VA" then
			local TempRet = {"X",CRet[2],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		else
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[2],0x15C,1,0);
					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}
		end
		if Divisor[4] == "VA" then
			local TempRet = {"X",CRet[1],0,"V"}
			MovX(PlayerID,TempRet,Divisor)
			Divisor = TempRet
		else
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Divisor[1],Divisor[2],0x158,Divisor[3],SetTo,"X",CRet[1],0x15C,1,0);
					SetCtrig1X(Divisor[1],Divisor[2],0x148,Divisor[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Divisor[1],Divisor[2],0x160,Divisor[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Divisor[1],Divisor[2],Divisor[3]);
				},
				flag = {Preserved}
			}
		end
	end

	-- Call f_Div
	Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x4,0,SetTo,"X",FIDIVCall1,0x0,0,0);
					SetCtrigX("X",FIDIVCall3,0x4,0,SetTo,"X","X",0x0,0,1);
				},
				flag = {Preserved}
			}
	if FIDIVCall1 == 0 then
		Need_Include_ArithMetic()
	end

	-- Output Data CRet[3] = Output
	if PDest[4] == "V" then
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
				SetCtrigX("X",CRet[3],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
				SetCtrig1X("X",CRet[3],0x148,0,SetTo,Mask);
				SetCtrig1X("X",CRet[3],0x160,0,SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways("X",CRet[3],0);
				},
				flag = {Preserved}
			}
	elseif PDest[4] == "VA" then
		local TempRet = {"X",CRet[3],0,"V"}
		MovX(PlayerID,PDest,TempRet)
	end

end

function f_iMod(PlayerID,Dest,Source,Divisor,Mask)
	STPopTrigArr(PlayerID)
	if Mask == nil or Mask == "X" then
		Mask = 0xFFFFFFFF
	end
	if Divisor == "X" then
		Divisor = nil
	end

	-- Input Data CRet[1] << X / CRet[2] << Y
	local PDest = Dest
	if Divisor == nil then
		if Dest[4] == "VA" then
			local TempRet = {"X",CRet[2],0,"V"}
			MovX(PlayerID,TempRet,Dest)
			Dest = TempRet
		else
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Dest[1],Dest[2],0x158,Dest[3],SetTo,"X",CRet[2],0x15C,1,0);
					SetCtrig1X(Dest[1],Dest[2],0x148,Dest[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Dest[1],Dest[2],0x160,Dest[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Dest[1],Dest[2],Dest[3]);
				},
				flag = {Preserved}
			}
		end
		if Source[4] == "VA" then
			local TempRet = {"X",CRet[1],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		else
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[1],0x15C,1,0);
					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}
		end
	else
		if Source[4] == "VA" then
			local TempRet = {"X",CRet[2],0,"V"}
			MovX(PlayerID,TempRet,Source)
			Source = TempRet
		else
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Source[1],Source[2],0x158,Source[3],SetTo,"X",CRet[2],0x15C,1,0);
					SetCtrig1X(Source[1],Source[2],0x148,Source[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Source[1],Source[2],0x160,Source[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Source[1],Source[2],Source[3]);
				},
				flag = {Preserved}
			}
		end
		if Divisor[4] == "VA" then
			local TempRet = {"X",CRet[1],0,"V"}
			MovX(PlayerID,TempRet,Divisor)
			Divisor = TempRet
		else
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX(Divisor[1],Divisor[2],0x158,Divisor[3],SetTo,"X",CRet[1],0x15C,1,0);
					SetCtrig1X(Divisor[1],Divisor[2],0x148,Divisor[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Divisor[1],Divisor[2],0x160,Divisor[3],SetTo,SetTo*16777216,0xFF000000);
					CallLabelAlways(Divisor[1],Divisor[2],Divisor[3]);
				},
				flag = {Preserved}
			}
		end
	end

	-- Call f_Div
	Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrigX("X","X",0x4,0,SetTo,"X",FIMODCall1,0x0,0,0);
					SetCtrigX("X",FIMODCall3,0x4,0,SetTo,"X","X",0x0,0,1);
				},
				flag = {Preserved}
			}
	if FIMODCall1 == 0 then
		Need_Include_ArithMetic()
	end

	-- Output Data CRet[2] = Output
	if PDest[4] == "V" then
		Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
				SetCtrigX("X",CRet[2],0x158,0,SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]);
				SetCtrig1X("X",CRet[2],0x148,0,SetTo,Mask);
				SetCtrig1X("X",CRet[2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
				CallLabelAlways("X",CRet[2],0);
				},
				flag = {Preserved}
			}
	elseif PDest[4] == "VA" then
		local TempRet = {"X",CRet[2],0,"V"}
		MovX(PlayerID,PDest,TempRet)
	end
end

-- 내부 트리거 생성 관련 함수 (직접 사용X) -----------------------------------------------

function ORPopCondArr(PlayerID)
	if ORPopTrigLock == 0 and ORPushCondArr[1] ~= nil then
		ORPopTrigLock = 1
		local TempArr = PushCondArr
		local TempArr2 = CondLineArr
		local TempArr3 = PushActArr
		local TempArr4 = ActLineArr
		local TempArr5 = STPushTrigArr
		local TempArr6 = PushTrigArr
		local TempArr7 = PushTrigStack
		local TTempArr = TTPushTrigArr
		local TTempArr2 = TTPushCondArr
		local TTempArr3 = TTFCodeArr
		local TTempArr4 = TTModeArr
		PushCondArr = {}
		CondLineArr = {}
		PushActArr = {}
		ActLineArr = {}
		STPushTrigArr = {}
		PushTrigArr = {}
		PushTrigStack = 0
		TTPushTrigArr = {}
		TTPushCondArr = {}
		TTFCodeArr = {}
		TTModeArr = {}

		for i, ORCond in pairs(ORPushCondArr) do
			DoActionsX(PlayerID,{SetCDeaths("X",SetTo,0,ORFCodeArr[i])})
			for k, v in pairs(ORCond) do
				if v[1] == "T" then -- T조건
					if v[2] == "MemoryX" then
						CTrigger(PlayerID,{TMemoryX(v[3],v[4],v[5],v[6])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "Memory" then
						CTrigger(PlayerID,{TMemory(v[3],v[4],v[5])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "CVar" then
						CTrigger(PlayerID,{TCVar(v[3],v[4],v[5],v[6],v[7])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "CVAar" then
						CTrigger(PlayerID,{TCVAar(v[3],v[4],v[5],v[6])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "VariableX" then
						CTrigger(PlayerID,{TVariableX(v[3],v[4],v[5],v[6],v[7],v[8])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "VArrayX" then
						CTrigger(PlayerID,{TVArrayX(v[3],v[4],v[5],v[6],v[7])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "NDeathsX" then
						CTrigger(PlayerID,{TNDeathsX(v[3],v[4],v[5],v[6],v[7])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "NDeaths" then
						CTrigger(PlayerID,{TNDeaths(v[3],v[4],v[5],v[6])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "CDeathsX" then
						CTrigger(PlayerID,{TCDeathsX(v[3],v[4],v[5],v[6],v[7])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "CDeaths" then
						CTrigger(PlayerID,{TCDeaths(v[3],v[4],v[5],v[6])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "CtrigX" then
						CTrigger(PlayerID,{TCtrigX(v[3],v[4],v[5],v[6],v[7],v[8],v[9])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "Deaths" then
						CTrigger(PlayerID,{TDeaths(v[3],v[4],v[5],v[6])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "DeathsX" then
						CTrigger(PlayerID,{TDeathsX(v[3],v[4],v[5],v[6],v[7])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "Command" then
						CTrigger(PlayerID,{TCommand(v[3],v[4],v[5],v[6])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "Bring" then
						CTrigger(PlayerID,{TBring(v[3],v[4],v[5],v[6],v[7])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "Accumulate" then
						CTrigger(PlayerID,{TAccumulate(v[3],v[4],v[5],v[6])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "CountdownTimer" then
						CTrigger(PlayerID,{TCountdownTimer(v[3],v[4])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "ElapsedTime" then
						CTrigger(PlayerID,{TElapsedTime(v[3],v[4])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "Kills" then
						CTrigger(PlayerID,{TKills(v[3],v[4],v[5],v[6])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "Score" then
						CTrigger(PlayerID,{TScore(v[3],v[4],v[5],v[6])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "Opponents" then
						CTrigger(PlayerID,{TOpponents(v[3],v[4],v[5])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					end
				elseif v[1] == "TT" then -- TT조건
					if v[2] == "MemoryX" then
						CTrigger(PlayerID,{TTMemoryX(v[3],v[4],v[5],v[6])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "Memory" then
						CTrigger(PlayerID,{TTMemory(v[3],v[4],v[5])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "CVar" then
						CTrigger(PlayerID,{TTCVar(v[3],v[4],v[5],v[6],v[7])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "CVAar" then
						CTrigger(PlayerID,{TTCVAar(v[3],v[4],v[5],v[6])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "VariableX" then
						CTrigger(PlayerID,{TTVariableX(v[3],v[4],v[5],v[6],v[7],v[8])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "VArrayX" then
						CTrigger(PlayerID,{TTVArrayX(v[3],v[4],v[5],v[6],v[7])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "NDeathsX" then
						CTrigger(PlayerID,{TTNDeathsX(v[3],v[4],v[5],v[6],v[7])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "NDeaths" then
						CTrigger(PlayerID,{TTNDeaths(v[3],v[4],v[5],v[6])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "CDeathsX" then
						CTrigger(PlayerID,{TTCDeathsX(v[3],v[4],v[5],v[6],v[7])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "CDeaths" then
						CTrigger(PlayerID,{TTCDeaths(v[3],v[4],v[5],v[6])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "CtrigX" then
						CTrigger(PlayerID,{TTCtrigX(v[3],v[4],v[5],v[6],v[7],v[8],v[9])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "Deaths" then
						CTrigger(PlayerID,{TTDeaths(v[3],v[4],v[5],v[6])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "DeathsX" then
						CTrigger(PlayerID,{TTDeathsX(v[3],v[4],v[5],v[6],v[7])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "Command" then
						CTrigger(PlayerID,{TTCommand(v[3],v[4],v[5],v[6])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "Bring" then
						CTrigger(PlayerID,{TTBring(v[3],v[4],v[5],v[6],v[7])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "Accumulate" then
						CTrigger(PlayerID,{TTAccumulate(v[3],v[4],v[5],v[6])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "CountdownTimer" then
						CTrigger(PlayerID,{TTCountdownTimer(v[3],v[4])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "ElapsedTime" then
						CTrigger(PlayerID,{TTElapsedTime(v[3],v[4])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "Kills" then
						CTrigger(PlayerID,{TTKills(v[3],v[4],v[5],v[6])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "Score" then
						CTrigger(PlayerID,{TTScore(v[3],v[4],v[5],v[6])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					elseif v[2] == "Opponents" then
						CTrigger(PlayerID,{TTOpponents(v[3],v[4],v[5])},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
					end
				elseif v[1] == "AND" then -- AND조건
					local ANDCond = {}
					for p, q in pairs(v[2]) do
						if q[1] == "T" then -- T조건
							if q[2] == "MemoryX" then
								table.insert(ANDCond,{TMemoryX(q[3],q[4],q[5],q[6])})
							elseif q[2] == "Memory" then
								table.insert(ANDCond,{TMemory(q[3],q[4],q[5])})
							elseif q[2] == "CVar" then
								table.insert(ANDCond,{TCVar(q[3],q[4],q[5],q[6],q[7])})
							elseif q[2] == "CVAar" then
								table.insert(ANDCond,{TCVAar(q[3],q[4],q[5],q[6])})
							elseif q[2] == "VariableX" then
								table.insert(ANDCond,{TVariableX(q[3],q[4],q[5],q[6],q[7],q[8])})
							elseif q[2] == "VArrayX" then
								table.insert(ANDCond,{TVArrayX(q[3],q[4],q[5],q[6],q[7])})
							elseif q[2] == "NDeathsX" then
								table.insert(ANDCond,{TNDeathsX(q[3],q[4],q[5],q[6],q[7])})
							elseif q[2] == "NDeaths" then
								table.insert(ANDCond,{TNDeaths(q[3],q[4],q[5],q[6])})
							elseif q[2] == "CDeathsX" then
								table.insert(ANDCond,{TCDeathsX(q[3],q[4],q[5],q[6],q[7])})
							elseif q[2] == "CDeaths" then
								table.insert(ANDCond,{TCDeaths(q[3],q[4],q[5],q[6])})
							elseif q[2] == "CtrigX" then
								table.insert(ANDCond,{TCtrigX(q[3],q[4],q[5],q[6],q[7],q[8],q[9])})
							elseif q[2] == "Deaths" then
								table.insert(ANDCond,{TDeaths(q[3],q[4],q[5],q[6])})
							elseif q[2] == "DeathsX" then
								table.insert(ANDCond,{TDeathsX(q[3],q[4],q[5],q[6],q[7])})
							elseif q[2] == "Command" then
								table.insert(ANDCond,{TCommand(q[3],q[4],q[5],q[6])})
							elseif q[2] == "Bring" then
								table.insert(ANDCond,{TBring(q[3],q[4],q[5],q[6],q[7])})
							elseif q[2] == "Accumulate" then
								table.insert(ANDCond,{TAccumulate(q[3],q[4],q[5],q[6])})
							elseif q[2] == "CountdownTimer" then
								table.insert(ANDCond,{TCountdownTimer(q[3],q[4])})
							elseif q[2] == "ElapsedTime" then
								table.insert(ANDCond,{TElapsedTime(q[3],q[4])})
							elseif q[2] == "Kills" then
								table.insert(ANDCond,{TKills(q[3],q[4],q[5],q[6])})
							elseif q[2] == "Score" then
								table.insert(ANDCond,{TScore(q[3],q[4],q[5],q[6])})
							elseif q[2] == "Opponents" then
								table.insert(ANDCond,{TOpponents(q[3],q[4],q[5])})
							end
						elseif q[1] == "TT" then -- TT조건
							if q[2] == "MemoryX" then
								table.insert(ANDCond,{TTMemoryX(q[3],q[4],q[5],q[6])})
							elseif q[2] == "Memory" then
								table.insert(ANDCond,{TTMemory(q[3],q[4],q[5])})
							elseif q[2] == "CVar" then
								table.insert(ANDCond,{TTCVar(q[3],q[4],q[5],q[6],q[7])})
							elseif q[2] == "CVAar" then
								table.insert(ANDCond,{TTCVAar(q[3],q[4],q[5],q[6])})
							elseif q[2] == "VariableX" then
								table.insert(ANDCond,{TTVariableX(q[3],q[4],q[5],q[6],q[7],q[8])})
							elseif q[2] == "VArrayX" then
								table.insert(ANDCond,{TTVArrayX(q[3],q[4],q[5],q[6],q[7])})
							elseif q[2] == "NDeathsX" then
								table.insert(ANDCond,{TTNDeathsX(q[3],q[4],q[5],q[6],q[7])})
							elseif q[2] == "NDeaths" then
								table.insert(ANDCond,{TTNDeaths(q[3],q[4],q[5],q[6])})
							elseif q[2] == "CDeathsX" then
								table.insert(ANDCond,{TTCDeathsX(q[3],q[4],q[5],q[6],q[7])})
							elseif q[2] == "CDeaths" then
								table.insert(ANDCond,{TTCDeaths(q[3],q[4],q[5],q[6])})
							elseif q[2] == "CtrigX" then
								table.insert(ANDCond,{TTCtrigX(q[3],q[4],q[5],q[6],q[7],q[8],q[9])})
							elseif q[2] == "Deaths" then
								table.insert(ANDCond,{TTDeaths(q[3],q[4],q[5],q[6])})
							elseif q[2] == "DeathsX" then
								table.insert(ANDCond,{TTDeathsX(q[3],q[4],q[5],q[6],q[7])})
							elseif q[2] == "Command" then
								table.insert(ANDCond,{TTCommand(q[3],q[4],q[5],q[6])})
							elseif q[2] == "Bring" then
								table.insert(ANDCond,{TTBring(q[3],q[4],q[5],q[6],q[7])})
							elseif q[2] == "Accumulate" then
								table.insert(ANDCond,{TTAccumulate(q[3],q[4],q[5],q[6])})
							elseif q[2] == "CountdownTimer" then
								table.insert(ANDCond,{TTCountdownTimer(q[3],q[4])})
							elseif q[2] == "ElapsedTime" then
								table.insert(ANDCond,{TTElapsedTime(q[3],q[4])})
							elseif q[2] == "Kills" then
								table.insert(ANDCond,{TTKills(q[3],q[4],q[5],q[6])})
							elseif q[2] == "Score" then
								table.insert(ANDCond,{TTScore(q[3],q[4],q[5],q[6])})
							elseif q[2] == "Opponents" then
								table.insert(ANDCond,{TTOpponents(q[3],q[4],q[5])})
							end
						else -- 일반 조건
							table.insert(ANDCond,{q})
						end
					end
					CTrigger(PlayerID,{ANDCond},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
				else -- 일반 조건
					CTrigger(PlayerID,{v},{SetCDeaths("X",SetTo,1,ORFCodeArr[i])},{Preserved})
				end
			end
		end

		PushCondArr = TempArr
		CondLineArr = TempArr2
		PushActArr = TempArr3
		ActLineArr = TempArr4
		STPushTrigArr = TempArr5
		PushTrigArr = TempArr6
		PushTrigStack = TempArr7
		TTPushTrigArr = TTempArr
		TTPushCondArr = TTempArr2
		TTFCodeArr = TTempArr3
		TTModeArr = TTempArr4
		ORPushCondArr = {}
		ORFCodeArr = {}
		ORPopTrigLock = 0

		VarXAlloc = 0xFF00
		VarXReleaseLock = 0
	end
end

function InitCtrig()
	for P = 1, 8 do

		local k = 1
		local Size = #CtrigInitArr[P]

		while k <= Size do
			if Size - k + 1 >= 64 then
				local X = {}
				for i = 0, 63 do
					table.insert(X, CtrigInitArr[P][k])
					k = k + 1
				end
				Trigger {
						players = {P-1},
						conditions = {
							Label(0);
						},
						actions = {
							X,
						},
					}
			else
				local X = {}
				repeat
					table.insert(X, CtrigInitArr[P][k])
					k = k + 1
				until k == Size + 1
				Trigger {
						players = {P-1},
						conditions = {
							Label(0);
						},
						actions = {
							X,
						},
					}
			end
		end
	end
end

function FlagIndex(FlagID)
	return (FlagID/480) + (FlagID%480)*0x10000 + 0x0000FFF1
end

function PopCondArr(Conditions)
	if TPopTrigLock == 0 then
		if Conditions ~= nil then
			StackArrptr = 0
			for i, Cond in pairs(Conditions) do
				if Cond == "TCond" then
					StackArrptr = StackArrptr + 1
					Conditions[i] = PushCondArr[StackArrptr]
					for k = 1, CondLineArr[StackArrptr] do
						table.insert(PushCondStack,i)
					end
				end
			end
			PushCondArr = {}
		end
	end
	return Conditions
end

function PopActArr(Actions)
	if TPopTrigLock == 0 then
		if Actions ~= nil then
			StackArrptr = 0
			for i, Act in pairs(Actions) do
				if Act == "TAct" then
					StackArrptr  = StackArrptr + 1
					Actions[i] = PushActArr[StackArrptr]
					for k = 1, ActLineArr[StackArrptr] do
						table.insert(PushActStack,i)
					end
				end
			end
			PushActArr = {}
		end
	end
	return Actions
end

function PopTrigArr(PlayerID,ActPushLine,CondPushLine)
	if TPopTrigLock == 0 then
		CondStackCount = 0
		for k, v in pairs(PushCondStack) do
			CondStackCount = CondStackCount + 1
		end

		for i, Act in pairs(PushTrigArr) do

			if CondPushLine == nil then
				CondPushLine = 0
			end
			if ActPushLine == nil then
				ActPushLine = 0
			end

			if Act[5][5] >= (0x128/4) then
				Act[4][6] = Act[4][6] + (ActPushLine + PushActStack[i-CondStackCount]) * (0x20/4)
				Act[5][5] = Act[5][5] + (ActPushLine + PushActStack[i-CondStackCount]) * (0x20/4)
			else 
				Act[4][6] = Act[4][6] + (CondPushLine + PushCondStack[i]) * (0x14/4)
				Act[5][5] = Act[5][5] + (CondPushLine + PushCondStack[i]) * (0x14/4)
			end

			Act[4][6] = Act[4][6] + (0x970/4) * PushTrigStack
			Act[5][5] = Act[5][5] + (0x970/4) * PushTrigStack

			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					Act,
				},
				flag = {Preserved}
			}

			PushTrigStack = PushTrigStack - 1
		end

		PushTrigArr = {}
		PushTrigStack = 0
		PushCondArr = {}
		PushCondStack = {}
		PushActArr = {}
		PushActStack = {}
		CondStackCount = 0
		StackArrptr = 0
		CondLineArr = {}
		ActLineArr = {}
	end
end

function TTPopTrigArr(PlayerID)

	if TTPopTrigLock == 0 then

		for i, TargetCond in pairs(TTPushCondArr) do
			local Size = 0
			if TTPushTrigArr[i] ~= nil then
				for k, v in pairs(TTPushTrigArr[i]) do
					Size = Size + 1
				end
			end
			local Stack = Size
			local FCode = TTFCodeArr[i]

			if TTModeArr[i] == 0 then
				DoActionsX(PlayerID,{SetCDeaths("X",SetTo,1,FCode),SetCtrig1X("X","X",0x28,Size+1,SetTo,Exactly*65536,0xFF0000)})

				if TTPushTrigArr[i] ~= nil then
					for j, Act in pairs(TTPushTrigArr[i]) do

						Act[4][6] = Act[4][6] + (0x970/4) * Stack
						Act[5][5] = Act[5][5] + (0x970/4) * Stack

						Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								Act,
							},
							flag = {Preserved}
						}

						Stack = Stack - 1
					end
				end

				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
						TargetCond,
					},
					actions = {
						SetCDeaths("X",SetTo,0,FCode);
					},
					flag = {Preserved}
				}
			elseif TTModeArr[i] == 1 then
				DoActionsX(PlayerID,{SetCDeaths("X",SetTo,0,FCode),
							SetCtrigX("X","X",0x4,Size+1,SetTo,"X","X",0x0,0,Size+2),
							SetCtrig1X("X","X",0x15C,Size+1,SetTo,1),
							SetCtrig1X("X","X",0x28,Size+1,SetTo,AtLeast*65536,0xFF0000)})

				if TTPushTrigArr[i] ~= nil then
					for j, Act in pairs(TTPushTrigArr[i]) do

						Act[4][6] = Act[4][6] + (0x970/4) * Stack
						Act[5][5] = Act[5][5] + (0x970/4) * Stack

						Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								Act,
							},
							flag = {Preserved}
						}

						Stack = Stack - 1
					end
				end
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
						TargetCond,
					},
					actions = {
						SetCDeaths("X",SetTo,1,FCode);
					},
					flag = {Preserved}
				}
				DoActionsX(PlayerID,{SetCtrigX("X","X",0x4,0,SetTo,"X","X",0x0,0,-1),
									SetCtrigX("X","X",0x4,-1,SetTo,"X","X",0x0,0,1),
									SetCtrig1X("X","X",0x15C,-1,SetTo,0),
									SetCtrig1X("X","X",0x28,-1,SetTo,Exactly*65536,0xFF0000)})
			elseif TTModeArr[i] == 2 then
				DoActionsX(PlayerID,{SetCDeaths("X",SetTo,0,FCode),
							SetCtrigX("X","X",0x4,Size+1,SetTo,"X","X",0x0,0,Size+2),
							SetCtrig1X("X","X",0x15C,Size+1,SetTo,1),
							SetCtrig1X("X","X",0x28,Size+1,SetTo,AtMost*65536,0xFF0000)})

				if TTPushTrigArr[i] ~= nil then
					for j, Act in pairs(TTPushTrigArr[i]) do

						Act[4][6] = Act[4][6] + (0x970/4) * Stack
						Act[5][5] = Act[5][5] + (0x970/4) * Stack

						Trigger {
							players = {ParsePlayer(PlayerID)},
							conditions = {
								Label(0);
							},
							actions = {
								Act,
							},
							flag = {Preserved}
						}

						Stack = Stack - 1
					end
				end
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
						TargetCond,
					},
					actions = {
						SetCDeaths("X",SetTo,1,FCode);
					},
					flag = {Preserved}
				}
				DoActionsX(PlayerID,{SetCtrigX("X","X",0x4,0,SetTo,"X","X",0x0,0,-1),
									SetCtrigX("X","X",0x4,-1,SetTo,"X","X",0x0,0,1),
									SetCtrig1X("X","X",0x15C,-1,SetTo,0),
									SetCtrig1X("X","X",0x28,-1,SetTo,Exactly*65536,0xFF0000)})

			end
		end

		TTFCodeArr = {}
		TTModeArr = {}
		TTPushTrigArr = {}
		TTPushCondArr = {}
	end
end

function STPopTrigArr(PlayerID)
	if STPopTrigLock == 0 and STPushTrigArr[1] ~= nil then
		STPopTrigLock = 1
		ORPopTrigLock = 1
		TTPopTrigLock = 1
		TPopTrigLock = 1
		--[[
		local VarXArr = {}
		for i = 0xFF00, VarXAlloc-1 do
			table.insert(VarXArr,SetCtrig1X("X",i,0x15C,0,SetTo,0))
		end
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				VarXArr,
			},
			flag = {Preserved}
		}
		]]--
		for k, v in pairs(STPushTrigArr) do
			if v[1] == "Mov" then
				CMov(PlayerID,v[2],v[3],0,v[4],1)
			elseif v[1] == "Read" then
				CRead(PlayerID,v[2],v[3],"X",v[4],"X",1)
			elseif v[1] == "EPDRead" then
				CRead(PlayerID,v[2],v[3],"X","X",1)
			elseif v[1] == "ReadX" then
				CReadX(PlayerID,v[2],v[3],"X",v[4],v[5],1)
			elseif v[1] == "ReadF" then
				f_Read(PlayerID,v[3],v[2],"X",v[4],1)
			elseif v[1] == "EPDReadF" then
				f_Read(PlayerID,v[3],"X",v[2],v[4])
				elseif v[1] == "ReadFX" then
				f_ReadX(PlayerID,v[3],v[2],v[5],v[4],1) 
			elseif v[1] == "EPD" then
				f_EPD(PlayerID,v[2],v[3])
			elseif v[1] == "Add" then
				CAdd(PlayerID,v[2],v[3],v[4])
			elseif v[1] == "Sub" then
				CSub(PlayerID,v[2],v[3],v[4])
			elseif v[1] == "iSub" then
				CiSub(PlayerID,v[2],v[3],v[4])
			elseif v[1] == "Neg" then
				CNeg(PlayerID,v[2],v[3])
			elseif v[1] == "MulC" then
				CMul(PlayerID,v[2],v[3],v[4])
			elseif v[1] == "MulV" then
				f_Mul(PlayerID,v[2],v[3],v[4])
			elseif v[1] == "DivC" then
				CDiv(PlayerID,v[2],v[3],v[4])
			elseif v[1] == "DivV" then
				f_Div(PlayerID,v[2],v[3],v[4])
			elseif v[1] == "iDivC" then
				CiDiv(PlayerID,v[2],v[3],v[4])
			elseif v[1] == "iDivV" then
				f_iDiv(PlayerID,v[2],v[3],v[4])
			elseif v[1] == "ModC" then
				CMod(PlayerID,v[2],v[3],v[4])
			elseif v[1] == "ModV" then
				f_Mod(PlayerID,v[2],v[3],v[4])
			elseif v[1] == "iModC" then
				CiMod(PlayerID,v[2],v[3],v[4])
			elseif v[1] == "iModV" then
				f_iMod(PlayerID,v[2],v[3],v[4])
			elseif v[1] == "Not" then
				CNot(PlayerID,v[2],v[3])
			elseif v[1] == "Or" then
				COr(PlayerID,v[2],v[3],v[4])
			elseif v[1] == "And" then
				CAnd(PlayerID,v[2],v[3],v[4])
			elseif v[1] == "Xor" then
				CXor(PlayerID,v[2],v[3],v[4])
			elseif v[1] == "Abs" then
				f_Abs(PlayerID,v[2],v[3])
			elseif v[1] == "Arr" then
				ConvertArr(PlayerID,v[2],v[3])
			elseif v[1] == "VArr" then
				ConvertVArr(PlayerID,v[2],v[3],v[4])
			elseif v[1] == "@MovZ" then
				MovZ(PlayerID,v[2],v[3])
			elseif v[1] == "@MovX" then
				MovX(PlayerID,v[2],v[3])
			elseif v[1] == "Sqrt" then
				f_Sqrt(PlayerID,v[2],v[3])
			elseif v[1] == "Rand" then
				f_Rand(PlayerID,v[2])
			elseif v[1] == "MovX" then
				MovX(PlayerID,v[2],v[3],v[4],v[5])
			elseif v[1] == "TMem" then
				TMem(PlayerID,v[2],v[3],v[4],v[5],v[6])
			else
				STPopTrig_Error()
			end
		end
		STPopTrigLock = 0
		ORPopTrigLock = 0
		TTPopTrigLock = 0
		TPopTrigLock = 0
	end
	STPushTrigArr = {}
	if VarXReleaseLock == 0 then
		VarXAlloc = 0xFF00
	end
end

function _TMem(Source,Address,Next,OffsetFlag)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	table.insert(STPushTrigArr,{"TMem",TempData,Source,Address,Next,OffsetFlag})

	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _MovX(Source,Mode,Mask)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	table.insert(STPushTrigArr,{"MovX",TempData,Source,Mode,Mask})

	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

-- 중간 연산 함수(_) -------------------------------------------------------------------

function _Mov(Source,Mask)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	if type(Source) == "number" then
		table.insert(STPushTrigArr,{"Mov",TempData,Source,Mask}) -- A << 1
	elseif Source == "Cp" then
		Mov_InputData_Error()
	elseif Source[4] == "V" then
		table.insert(STPushTrigArr,{"Mov",TempData,Source,Mask}) -- A << X
	elseif Source[4] == "VA" then
		table.insert(STPushTrigArr,{"Mov",TempData,Source,Mask}) -- A << VA
	elseif Source[4] == "A" then
		Mov_InputData_Error()
	else
		Mov_InputData_Error()
	end

	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _Read(Source,Mask)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	table.insert(STPushTrigArr,{"Read",TempData,Source,Mask}) -- A << 0x58A364, Cp, EPD(X), Mem

	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _ReadX(Source,Mask,Multiplier)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	table.insert(STPushTrigArr,{"ReadX",TempData,Source,Mask,Multiplier}) -- A << 0x58A364, Cp, EPD(X), Mem

	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _EPDRead(Source)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	table.insert(STPushTrigArr,{"EPDRead",TempData,Source}) -- A << EPD(0x58A364, Cp, EPD(X), Mem)

	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _ReadF(Source,Mask)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	table.insert(STPushTrigArr,{"ReadF",TempData,Source,Mask}) -- A << 0x58A364, Cp, EPD(X), Mem

	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _ReadFX(Source,Mask,Multiplier)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	table.insert(STPushTrigArr,{"ReadFX",TempData,Source,Mask,Multiplier}) -- A << 0x58A364, Cp, EPD(X), Mem

	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _EPDReadF(Source)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	table.insert(STPushTrigArr,{"EPDReadF",TempData,Source}) -- A << EPD(0x58A364, Cp, EPD(X), Mem)

	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _EPD(Source)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	if type(Source) == "number" then
		EPD_InputData_Error()
	elseif Source == "Cp" then
		EPD_InputData_Error()
	elseif Source[4] == "V" then
		table.insert(STPushTrigArr,{"EPD",TempData,Source}) -- A << EPD(V)
	elseif Source[4] == "VA" then
		table.insert(STPushTrigArr,{"EPD",TempData,Source}) -- A << EPD(VA) 
	elseif Source[4] == "A" then
		EPD_InputData_Error()
	else
		EPD_InputData_Error()
	end

	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _Add(Source,Operand)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	if type(Source) == "number" then
		Add_InputData_Error()
	elseif Source == "Cp" then
		Add_InputData_Error()
	elseif Source[4] == "V" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"Add",TempData,Source,Operand}) -- A << X + 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"Add",TempData,Source,Operand}) -- A << X + Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"Add",TempData,Source,Operand}) -- A << X + VA
		elseif Operand[4] == "A" then
			Add_InputData_Error()
		else
			Add_InputData_Error()
		end
	elseif Source[4] == "VA" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"Add",TempData,Source,Operand}) -- A << VA + 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"Add",TempData,Source,Operand}) -- A << VA + Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"Add",TempData,Source,Operand}) -- A << VA + VA
		elseif Operand[4] == "A" then
			Add_InputData_Error()
		else
			Add_InputData_Error()
		end
	elseif Source[4] == "A" then
		Add_InputData_Error()
	else
		Add_InputData_Error()
	end

	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _Sub(Source,Operand)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	if type(Source) == "number" then
		Sub_InputData_Error()
	elseif Source == "Cp" then
		Sub_InputData_Error()
	elseif Source[4] == "V" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"Sub",TempData,Source,Operand}) -- A << X - 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"Sub",TempData,Source,Operand}) -- A << X - Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"Sub",TempData,Source,Operand}) -- A << X - VA
		elseif Operand[4] == "A" then
			Sub_InputData_Error()
		else
			Sub_InputData_Error()
		end
	elseif Source[4] == "VA" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"Sub",TempData,Source,Operand}) -- A << VA - 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"Sub",TempData,Source,Operand}) -- A << VA - Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"Sub",TempData,Source,Operand}) -- A << VA - VA
		elseif Operand[4] == "A" then
			Sub_InputData_Error()
		else
			Sub_InputData_Error()
		end
	else
		Sub_InputData_Error()
	end
	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _iSub(Source,Operand)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	if type(Source) == "number" then
		iSub_InputData_Error()
	elseif Source == "Cp" then
		iSub_InputData_Error()
	elseif Source[4] == "V" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"iSub",TempData,Source,Operand}) -- A << X - 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"iSub",TempData,Source,Operand}) -- A << X - Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"iSub",TempData,Source,Operand}) -- A << X - VA
		elseif Operand[4] == "A" then
			iSub_InputData_Error()
		else
			iSub_InputData_Error()
		end
	elseif Source[4] == "VA" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"iSub",TempData,Source,Operand}) -- A << VA - 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"iSub",TempData,Source,Operand}) -- A << VA - Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"iSub",TempData,Source,Operand}) -- A << VA - VA
		elseif Operand[4] == "A" then
			iSub_InputData_Error()
		else
			iSub_InputData_Error()
		end
	else
		iSub_InputData_Error()
	end
	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _Neg(Source)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	if type(Source) == "number" then
		Neg_InputData_Error()
	elseif Source == "Cp" then
		Neg_InputData_Error()
	elseif Source[4] == "V" then
		table.insert(STPushTrigArr,{"Neg",TempData,Source}) -- A << -X 
	elseif Source[4] == "VA" then
		table.insert(STPushTrigArr,{"Neg",TempData,Source}) -- A << -VA 
	elseif Source[4] == "A" then
		Neg_InputData_Error()
	else
		Neg_InputData_Error()
	end
	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _Mul(Source,Operand)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	if type(Source) == "number" then
		Mul_InputData_Error()
	elseif Source == "Cp" then
		Mul_InputData_Error()
	elseif Source[4] == "V" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"MulC",TempData,Source,Operand}) -- A << X * 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"MulV",TempData,Source,Operand}) -- A << X * Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"MulV",TempData,Source,Operand}) -- A << X * VA
		elseif Operand[4] == "A" then
			Mul_InputData_Error()
		else
			Mul_InputData_Error()
		end
	elseif Source[4] == "VA" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"MulC",TempData,Source,Operand}) -- A << VA * 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"MulV",TempData,Source,Operand}) -- A << VA * Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"MulV",TempData,Source,Operand}) -- A << VA * VA
		elseif Operand[4] == "A" then
			Mul_InputData_Error()
		else
			Mul_InputData_Error()
		end
	else
		Mul_InputData_Error()
	end
	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _Div(Source,Operand)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	if type(Source) == "number" then
		Div_InputData_Error()
	elseif Source == "Cp" then
		Div_InputData_Error()
	elseif Source[4] == "V" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"DivC",TempData,Source,Operand}) -- A << X / 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"DivV",TempData,Source,Operand}) -- A << X / Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"DivV",TempData,Source,Operand}) -- A << X / VA
		elseif Operand[4] == "A" then
			Div_InputData_Error()
		else
			Div_InputData_Error()
		end
	elseif Source[4] == "VA" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"DivC",TempData,Source,Operand}) -- A << VA / 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"DivV",TempData,Source,Operand}) -- A << VA / Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"DivV",TempData,Source,Operand}) -- A << VA / VA
		elseif Operand[4] == "A" then
			Div_InputData_Error()
		else
			Div_InputData_Error()
		end
	else
		Div_InputData_Error()
	end
	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _iDiv(Source,Operand)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	if type(Source) == "number" then
		iDiv_InputData_Error()
	elseif Source == "Cp" then
		iDiv_InputData_Error()
	elseif Source[4] == "V" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"iDivC",TempData,Source,Operand}) -- A << X / 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"iDivV",TempData,Source,Operand}) -- A << X / Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"iDivV",TempData,Source,Operand}) -- A << X / VA
		elseif Operand[4] == "A" then
			iDiv_InputData_Error()
		else
			iDiv_InputData_Error()
		end
	elseif Source[4] == "VA" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"iDivC",TempData,Source,Operand}) -- A << VA / 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"iDivV",TempData,Source,Operand}) -- A << VA / Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"iDivV",TempData,Source,Operand}) -- A << VA / VA
		elseif Operand[4] == "A" then
			iDiv_InputData_Error()
		else
			iDiv_InputData_Error()
		end
	else
		iDiv_InputData_Error()
	end
	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _Mod(Source,Operand)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	if type(Source) == "number" then
		Mod_InputData_Error()
	elseif Source == "Cp" then
		Mod_InputData_Error()
	elseif Source[4] == "V" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"ModC",TempData,Source,Operand}) -- A << X % 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"ModV",TempData,Source,Operand}) -- A << X % Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"ModV",TempData,Source,Operand}) -- A << X % VA
		elseif Operand[4] == "A" then
			Mod_InputData_Error()
		else
			Mod_InputData_Error()
		end
	elseif Source[4] == "VA" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"ModC",TempData,Source,Operand}) -- A << VA % 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"ModV",TempData,Source,Operand}) -- A << VA % Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"ModV",TempData,Source,Operand}) -- A << VA % VA
		elseif Operand[4] == "A" then
			Mod_InputData_Error()
		else
			Mod_InputData_Error()
		end
	else
		Mod_InputData_Error()
	end
	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _iMod(Source,Operand)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	if type(Source) == "number" then
		iMod_InputData_Error()
	elseif Source == "Cp" then
		iMod_InputData_Error()
	elseif Source[4] == "V" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"iModC",TempData,Source,Operand}) -- A << X % 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"iModV",TempData,Source,Operand}) -- A << X % Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"iModV",TempData,Source,Operand}) -- A << X % VA
		elseif Operand[4] == "A" then
			iMod_InputData_Error()
		else
			iMod_InputData_Error()
		end
	elseif Source[4] == "VA" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"iModC",TempData,Source,Operand}) -- A << VA % 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"iModV",TempData,Source,Operand}) -- A << VA % Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"iModV",TempData,Source,Operand}) -- A << VA % VA
		elseif Operand[4] == "A" then
			iMod_InputData_Error()
		else
			iMod_InputData_Error()
		end
	else
		iMod_InputData_Error()
	end
	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _Not(Source)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	if type(Source) == "number" then
		Not_InputData_Error()
	elseif Source == "Cp" then
		Not_InputData_Error()
	elseif Source[4] == "V" then
		table.insert(STPushTrigArr,{"Not",TempData,Source}) -- A << ~X 
	elseif Source[4] == "VA" then
		table.insert(STPushTrigArr,{"Not",TempData,Source}) -- A << ~VA
	elseif Source[4] == "A" then
		Not_InputData_Error()
	else
		Not_InputData_Error()
	end
	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _Or(Source,Operand)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	if type(Source) == "number" then
		Or_InputData_Error()
	elseif Source == "Cp" then
		Or_InputData_Error()
	elseif Source[4] == "V" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"Or",TempData,Source,Operand}) -- A << X | 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"Or",TempData,Source,Operand}) -- A << X | Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"Or",TempData,Source,Operand}) -- A << X | VA
		elseif Operand[4] == "A" then
			Or_InputData_Error()
		else
			Or_InputData_Error()
		end
	elseif Source[4] == "VA" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"Or",TempData,Source,Operand}) -- A << VA | 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"Or",TempData,Source,Operand}) -- A << VA | Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"Or",TempData,Source,Operand}) -- A << VA | VA
		elseif Operand[4] == "A" then
			Or_InputData_Error()
		else
			Or_InputData_Error()
		end
	else
		Or_InputData_Error()
	end
	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _And(Source,Operand)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	if type(Source) == "number" then
		And_InputData_Error()
	elseif Source == "Cp" then
		And_InputData_Error()
	elseif Source[4] == "V" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"And",TempData,Source,Operand}) -- A << X & 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"And",TempData,Source,Operand}) -- A << X & Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"And",TempData,Source,Operand}) -- A << X & VA
		elseif Operand[4] == "A" then
			And_InputData_Error()
		else
			And_InputData_Error()
		end
	elseif Source[4] == "VA" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"And",TempData,Source,Operand}) -- A << VA & 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"And",TempData,Source,Operand}) -- A << VA & Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"And",TempData,Source,Operand}) -- A << VA & VA
		elseif Operand[4] == "A" then
			And_InputData_Error()
		else
			And_InputData_Error()
		end
	else
		And_InputData_Error()
	end
	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _Xor(Source,Operand)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	if type(Source) == "number" then
		Xor_InputData_Error()
	elseif Source == "Cp" then
		Xor_InputData_Error()
	elseif Source[4] == "V" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"Xor",TempData,Source,Operand}) -- A << X ^ 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"Xor",TempData,Source,Operand}) -- A << X ^ Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"Xor",TempData,Source,Operand}) -- A << X ^ VA
		elseif Operand[4] == "A" then
			Xor_InputData_Error()
		else
			Xor_InputData_Error()
		end
	elseif Source[4] == "VA" then
		if type(Operand) == "number" then
			table.insert(STPushTrigArr,{"Xor",TempData,Source,Operand}) -- A << VA ^ 1
		elseif Operand[4] == "V" then
			table.insert(STPushTrigArr,{"Xor",TempData,Source,Operand}) -- A << VA ^ Y
		elseif Operand[4] == "VA" then
			table.insert(STPushTrigArr,{"Xor",TempData,Source,Operand}) -- A << VA ^ VA
		elseif Operand[4] == "A" then
			Xor_InputData_Error()
		else
			Xor_InputData_Error()
		end
	else
		Xor_InputData_Error()
	end
	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _Abs(Source)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	if type(Source) == "number" then
		Abs_InputData_Error()
	elseif Source == "Cp" then
		Abs_InputData_Error()
	elseif Source[4] == "V" then
		table.insert(STPushTrigArr,{"Abs",TempData,Source}) -- A << |X|
	elseif Source[4] == "VA" then
		table.insert(STPushTrigArr,{"Abs",TempData,Source}) -- A << |VA|
	elseif Source[4] == "A" then
		Abs_InputData_Error()
	else
		Abs_InputData_Error()
	end
	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _Sqrt(Source)
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	if type(Source) == "number" then
		Sqrt_InputData_Error()
	elseif Source == "Cp" then
		Sqrt_InputData_Error()
	elseif Source[4] == "V" then
		table.insert(STPushTrigArr,{"Sqrt",TempData,Source}) -- A << √X
	elseif Source[4] == "VA" then
		table.insert(STPushTrigArr,{"Sqrt",TempData,Source}) -- A << √VA
	elseif Source[4] == "A" then
		Sqrt_InputData_Error()
	else
		Sqrt_InputData_Error()
	end
	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

function _Rand()
	local Temp = VarXAlloc
	local TempData = {"X",Temp,0,"V"}

	table.insert(STPushTrigArr,{"Rand",TempData}) 

	VarXAlloc = VarXAlloc + 1
	if VarXAlloc > MAXVAlloc then
		MAXVAlloc = VarXAlloc
	end
	return TempData
end

-- Misc 기타 함수들 ---------------------------------------------------------------------------------------------

function EUDTurbo(PlayerID)
	DoActions(PlayerID,SetMemory(0x6509A0,SetTo,0))
end

function Loc(LocationId,Direction,Type,Value)
	if type(LocationId) == "string" then
		LocationId = ParseLocation(LocationId)-1
	end
	if Direction == "L" then
		Direction = 0
	elseif Direction == "U" or Direction == 1 then
		Direction = 4
	elseif Direction == "R" or Direction == 2 then
		Direction = 8
	elseif Direction == "D" or Direction == 3 then
		Direction = 12
	end
	return Memory(0x58DC60+LocationId*0x14+Direction,Type,Value)
end

function LocX(LocationId,Direction,Type,Value,Mask)
	if type(LocationId) == "string" then
		LocationId = ParseLocation(LocationId)-1
	end
	if Direction == "L" then
		Direction = 0
	elseif Direction == "U" or Direction == 1 then
		Direction = 4
	elseif Direction == "R" or Direction == 2 then
		Direction = 8
	elseif Direction == "D" or Direction == 3 then
		Direction = 12
	end
	return MemoryX(0x58DC60+LocationId*0x14+Direction,Type,Value,Mask)
end

function SetLoc(LocationId,Direction,Type,Value)
	if type(LocationId) == "string" then
		LocationId = ParseLocation(LocationId)-1
	end
	if Direction == "L" then
		Direction = 0
	elseif Direction == "U" or Direction == 1 then
		Direction = 4
	elseif Direction == "R" or Direction == 2 then
		Direction = 8
	elseif Direction == "D" or Direction == 3 then
		Direction = 12
	end
	return SetMemory(0x58DC60+LocationId*0x14+Direction,Type,Value)
end

function SetLocX(LocationId,Direction,Type,Value,Mask)
	if type(LocationId) == "string" then
		LocationId = ParseLocation(LocationId)-1
	end
	if Direction == "L" then
		Direction = 0
	elseif Direction == "U" or Direction == 1 then
		Direction = 4
	elseif Direction == "R" or Direction == 2 then
		Direction = 8
	elseif Direction == "D" or Direction == 3 then
		Direction = 12
	end
	return SetMemoryX(0x58DC60+LocationId*0x14+Direction,Type,Value,Mask)
end

function _TTLoc(LocationId,Direction,Type,Value)
	if type(LocationId) == "string" then
		LocationId = ParseLocation(LocationId)-1
	end
	if Direction == "L" then
		Direction = 0
	elseif Direction == "U" or Direction == 1 then
		Direction = 4
	elseif Direction == "R" or Direction == 2 then
		Direction = 8
	elseif Direction == "D" or Direction == 3 then
		Direction = 12
	end
	return _TTMemory(0x58DC60+LocationId*0x14+Direction,Type,Value)
end

function _TTLocX(LocationId,Direction,Type,Value,Mask)
	if type(LocationId) == "string" then
		LocationId = ParseLocation(LocationId)-1
	end
	if Direction == "L" then
		Direction = 0
	elseif Direction == "U" or Direction == 1 then
		Direction = 4
	elseif Direction == "R" or Direction == 2 then
		Direction = 8
	elseif Direction == "D" or Direction == 3 then
		Direction = 12
	end
	return _TTMemoryX(0x58DC60+LocationId*0x14+Direction,Type,Value,Mask)
end

function _TLoc(LocationId,Direction,Type,Value)
	if type(LocationId) == "string" then
		LocationId = ParseLocation(LocationId)-1
	end
	if Direction == "L" then
		Direction = 0
	elseif Direction == "U" or Direction == 1 then
		Direction = 4
	elseif Direction == "R" or Direction == 2 then
		Direction = 8
	elseif Direction == "D" or Direction == 3 then
		Direction = 12
	end
	return _TMemory(0x58DC60+LocationId*0x14+Direction,Type,Value)
end

function _TLocX(LocationId,Direction,Type,Value,Mask)
	if type(LocationId) == "string" then
		LocationId = ParseLocation(LocationId)-1
	end
	if Direction == "L" then
		Direction = 0
	elseif Direction == "U" or Direction == 1 then
		Direction = 4
	elseif Direction == "R" or Direction == 2 then
		Direction = 8
	elseif Direction == "D" or Direction == 3 then
		Direction = 12
	end
	return _TMemoryX(0x58DC60+LocationId*0x14+Direction,Type,Value,Mask)
end


function TTLoc(LocationId,Direction,Type,Value)
	if type(LocationId) == "string" then
		LocationId = ParseLocation(LocationId)-1
	end
	if Direction == "L" then
		Direction = 0
	elseif Direction == "U" or Direction == 1 then
		Direction = 4
	elseif Direction == "R" or Direction == 2 then
		Direction = 8
	elseif Direction == "D" or Direction == 3 then
		Direction = 12
	end
	return TTMemory(0x58DC60+LocationId*0x14+Direction,Type,Value)
end

function TTLocX(LocationId,Direction,Type,Value,Mask)
	if type(LocationId) == "string" then
		LocationId = ParseLocation(LocationId)-1
	end
	if Direction == "L" then
		Direction = 0
	elseif Direction == "U" or Direction == 1 then
		Direction = 4
	elseif Direction == "R" or Direction == 2 then
		Direction = 8
	elseif Direction == "D" or Direction == 3 then
		Direction = 12
	end
	return TTMemoryX(0x58DC60+LocationId*0x14+Direction,Type,Value,Mask)
end

function TLoc(LocationId,Direction,Type,Value)
	if type(LocationId) == "string" then
		LocationId = ParseLocation(LocationId)-1
	end
	if Direction == "L" then
		Direction = 0
	elseif Direction == "U" or Direction == 1 then
		Direction = 4
	elseif Direction == "R" or Direction == 2 then
		Direction = 8
	elseif Direction == "D" or Direction == 3 then
		Direction = 12
	end
	return TMemory(0x58DC60+LocationId*0x14+Direction,Type,Value)
end

function TLocX(LocationId,Direction,Type,Value,Mask)
	if type(LocationId) == "string" then
		LocationId = ParseLocation(LocationId)-1
	end
	if Direction == "L" then
		Direction = 0
	elseif Direction == "U" or Direction == 1 then
		Direction = 4
	elseif Direction == "R" or Direction == 2 then
		Direction = 8
	elseif Direction == "D" or Direction == 3 then
		Direction = 12
	end
	return TMemoryX(0x58DC60+LocationId*0x14+Direction,Type,Value,Mask)
end

function TSetLoc(LocationId,Direction,Type,Value)
	if type(LocationId) == "string" then
		LocationId = ParseLocation(LocationId)-1
	end
	if Direction == "L" then
		Direction = 0
	elseif Direction == "U" or Direction == 1 then
		Direction = 4
	elseif Direction == "R" or Direction == 2 then
		Direction = 8
	elseif Direction == "D" or Direction == 3 then
		Direction = 12
	end
	return TSetMemory(0x58DC60+LocationId*0x14+Direction,Type,Value)
end

function TSetLocX(LocationId,Direction,Type,Value,Mask)
	if type(LocationId) == "string" then
		LocationId = ParseLocation(LocationId)-1
	end
	if Direction == "L" then
		Direction = 0
	elseif Direction == "U" or Direction == 1 then
		Direction = 4
	elseif Direction == "R" or Direction == 2 then
		Direction = 8
	elseif Direction == "D" or Direction == 3 then
		Direction = 12
	end
	return TSetMemoryX(0x58DC60+LocationId*0x14+Direction,Type,Value,Mask)
end

function MemoryW(Offset,Type,Value)
	local ret = bit32.band(Offset, 0xFFFFFFFF)%4
	if ret == 0 then
		Mask = 0xFFFF
	elseif ret == 2 then
		Mask = 0xFFFF0000
		Value = Value * 0x10000
	else
		MemoryW_InputData_Error()
	end
	return MemoryX(Offset-ret,Type,Value,Mask)
end

function SetMemoryW(Offset,Type,Value)
	local ret = bit32.band(Offset, 0xFFFFFFFF)%4
	if ret == 0 then
		Mask = 0xFFFF
	elseif ret == 2 then
		Mask = 0xFFFF0000
		Value = Value * 0x10000
	else
		SetMemoryW_InputData_Error()
	end
	return SetMemoryX(Offset-ret,Type,Value,Mask)
end

function MemoryB(Offset,Type,Value)
	local ret = bit32.band(Offset, 0xFFFFFFFF)%4
	if ret == 0 then
		Mask = 0xFF
	elseif ret == 1 then
		Mask = 0xFF00
		Value = Value * 0x100
	elseif ret == 2 then
		Mask = 0xFF0000
		Value = Value * 0x10000
	elseif ret == 3 then
		Mask = 0xFF000000
		Value = Value * 0x1000000
	end
	return MemoryX(Offset-ret,Type,Value,Mask)
end

function SetMemoryB(Offset,Type,Value)
	local ret = bit32.band(Offset, 0xFFFFFFFF)%4
	if ret == 0 then
		Mask = 0xFF
	elseif ret == 1 then
		Mask = 0xFF00
		Value = Value * 0x100
	elseif ret == 2 then
		Mask = 0xFF0000
		Value = Value * 0x10000
	elseif ret == 3 then
		Mask = 0xFF000000
		Value = Value * 0x1000000
	end
	return SetMemoryX(Offset-ret,Type,Value,Mask)
end

function _TTMemoryW(Offset,Type,Value)
	local ret = bit32.band(Offset, 0xFFFFFFFF)%4
	if ret == 0 then
		Mask = 0xFFFF
	elseif ret == 2 then
		Mask = 0xFFFF0000
		Value = Value * 0x10000
	else
		_TTMemoryW_InputData_Error()
	end
	return _TTMemoryX(Offset-ret,Type,Value,Mask)
end

function _TMemoryW(Offset,Type,Value)
	local ret = bit32.band(Offset, 0xFFFFFFFF)%4
	if ret == 0 then
		Mask = 0xFFFF
	elseif ret == 2 then
		Mask = 0xFFFF0000
		Value = Value * 0x10000
	else
		_TMemoryW_InputData_Error()
	end
	return _TMemoryX(Offset-ret,Type,Value,Mask)
end

function TTMemoryW(Offset,Type,Value)
	local ret = bit32.band(Offset, 0xFFFFFFFF)%4
	if ret == 0 then
		Mask = 0xFFFF
	elseif ret == 2 then
		Mask = 0xFFFF0000
		Value = Value * 0x10000
	else
		TTMemoryW_InputData_Error()
	end
	return TTMemoryX(Offset-ret,Type,Value,Mask)
end

function TMemoryW(Offset,Type,Value)
	local ret = bit32.band(Offset, 0xFFFFFFFF)%4
	if ret == 0 then
		Mask = 0xFFFF
	elseif ret == 2 then
		Mask = 0xFFFF0000
		Value = Value * 0x10000
	else
		TMemoryW_InputData_Error()
	end
	return TMemoryX(Offset-ret,Type,Value,Mask)
end

function TSetMemoryW(Offset,Type,Value)
	local ret = bit32.band(Offset, 0xFFFFFFFF)%4
	if ret == 0 then
		Mask = 0xFFFF
	elseif ret == 2 then
		Mask = 0xFFFF0000
		Value = Value * 0x10000
	else
		TSetMemoryW_InputData_Error()
	end
	return TSetMemoryX(Offset-ret,Type,Value,Mask)
end

function _TTMemoryB(Offset,Type,Value)
	local ret = bit32.band(Offset, 0xFFFFFFFF)%4
	if ret == 0 then
		Mask = 0xFF
	elseif ret == 1 then
		Mask = 0xFF00
		Value = Value * 0x100
	elseif ret == 2 then
		Mask = 0xFF0000
		Value = Value * 0x10000
	elseif ret == 3 then
		Mask = 0xFF000000
		Value = Value * 0x1000000
	end
	return _TTMemoryX(Offset-ret,Type,Value,Mask)
end

function _TMemoryB(Offset,Type,Value)
	local ret = bit32.band(Offset, 0xFFFFFFFF)%4
	if ret == 0 then
		Mask = 0xFF
	elseif ret == 1 then
		Mask = 0xFF00
		Value = Value * 0x100
	elseif ret == 2 then
		Mask = 0xFF0000
		Value = Value * 0x10000
	elseif ret == 3 then
		Mask = 0xFF000000
		Value = Value * 0x1000000
	end
	return _TMemoryX(Offset-ret,Type,Value,Mask)
end

function TTMemoryB(Offset,Type,Value)
	local ret = bit32.band(Offset, 0xFFFFFFFF)%4
	if ret == 0 then
		Mask = 0xFF
	elseif ret == 1 then
		Mask = 0xFF00
		Value = Value * 0x100
	elseif ret == 2 then
		Mask = 0xFF0000
		Value = Value * 0x10000
	elseif ret == 3 then
		Mask = 0xFF000000
		Value = Value * 0x1000000
	end
	return TTMemoryX(Offset-ret,Type,Value,Mask)
end

function TMemoryB(Offset,Type,Value)
	local ret = bit32.band(Offset, 0xFFFFFFFF)%4
	if ret == 0 then
		Mask = 0xFF
	elseif ret == 1 then
		Mask = 0xFF00
		Value = Value * 0x100
	elseif ret == 2 then
		Mask = 0xFF0000
		Value = Value * 0x10000
	elseif ret == 3 then
		Mask = 0xFF000000
		Value = Value * 0x1000000
	end
	return TMemoryX(Offset-ret,Type,Value,Mask)
end

function TSetMemoryB(Offset,Type,Value)
	local ret = bit32.band(Offset, 0xFFFFFFFF)%4
	if ret == 0 then
		Mask = 0xFF
	elseif ret == 1 then
		Mask = 0xFF00
		Value = Value * 0x100
	elseif ret == 2 then
		Mask = 0xFF0000
		Value = Value * 0x10000
	elseif ret == 3 then
		Mask = 0xFF000000
		Value = Value * 0x1000000
	end
	return TSetMemoryX(Offset-ret,Type,Value,Mask)
end


PlayerCheckOffset = 0
function Enable_PlayerCheck(Offset)
	if Offset == nil or Offset == "X" then
		Offset = 0x58F44C
	end
	PlayerCheckOffset = Offset
	DoActions(AllPlayers,{SetMemory(Offset,SetTo,0)})

	for i = 0, 7 do
		Trigger {
			players = {AllPlayers},
			conditions = {
				MemoryX(0x57EEE8 + 36*i,AtLeast,0x1,0xFF);
				MemoryX(0x57EEE8 + 36*i,AtMost,0x2,0xFF);
			},
			actions = {
				SetMemoryX(Offset,SetTo,2^i,2^i);
			},
			flag = {Preserved}
		}
	end
end

function PlayerCheck(Player,Status)
	if PlayerCheckOffset == 0 then
		Need_Enable_PlayerCheck()
	end
	if Player >= 8  or Player < 0 then
		PlayerCheck_InputData_Error()
	end
	if Status == "X" or Status == 0 then
		Status = 0
	else
		Status = 2^Player
	end
	return MemoryX(PlayerCheckOffset,Exactly,Status,2^Player)
end

function NoAirCollisionX(PlayerID)

	f_Read(PlayerID,0x6D5CD8,"X",V(FuncAlloc))

	CVariable2(PlayerID,FuncAlloc,0x6509B0,SetTo,0)

	FuncAlloc = FuncAlloc + 1
	local RephArr = {}
	for i = 0, 609 do
		table.insert(RephArr,SetDeaths(CurrentPlayer,SetTo,0,i))
	end
	for j = 0, 1 do
		table.insert(RephArr,SetMemory(0x6509B0,Add,1))
		for i = 0, 609 do
			table.insert(RephArr,SetDeaths(CurrentPlayer,SetTo,0,i))
		end
	end
	for j = 0, 8 do
		table.insert(RephArr,SetMemory(0x6509B0,Add,1))
		for i = 0, 608 do
			table.insert(RephArr,SetDeaths(CurrentPlayer,SetTo,0,i))
		end
	end
	table.insert(RephArr,SetMemory(0x6509B0,SetTo,PlayerID))

	DoActions2(PlayerID,RephArr)

end

function Print_13(PlayerID,DisplayPlayer,String)
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
		DoActionsX(PlayerID,{SetMemory(0x628438,SetTo,0),X,print_utf8(12, 0,"								"),Y})
		CVariable2(PlayerID,FuncAlloc,0x628438,SetTo,0)
	CIfEnd()
	FuncAlloc = FuncAlloc + 1
end

function GetPlayerName(PlayerID,TargetPlayer,OutputVA,InitBytes) -- VA[1~5] 사용
	if InitBytes == nil then
		InitBytes = 0
	end
	GetNameVArr = GetVArray(OutputVA)
	DoActionsX(PlayerID,{SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3],SetTo,0x0D0D0D0D),
		SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D),
		SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D),
		SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D),
		SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo,0x0D0D0D0D)})
	if InitBytes == 0 then
		for i = 0, 3 do
			f_ReadX(PlayerID,0x57EEE8 + 0x24*TargetPlayer+0x4*i,VArr(GetNameVArr,0+i),1/16777216,0xFF000000) -- 3->0
			f_ReadX(PlayerID,0x57EEEC + 0x24*TargetPlayer+0x4*i,VArr(GetNameVArr,0+i),256,0xFFFFFF) -- 012 -> 123
		end
	elseif InitBytes == 1 then
		for i = 0, 3 do
			f_ReadX(PlayerID,0x57EEE8 + 0x24*TargetPlayer+0x4*i,VArr(GetNameVArr,0+i),1/65536,0xFF000000) -- 3->1
			f_ReadX(PlayerID,0x57EEEC + 0x24*TargetPlayer+0x4*i,VArr(GetNameVArr,0+i),65536,0xFFFF) -- 01 -> 23
			f_ReadX(PlayerID,0x57EEEC + 0x24*TargetPlayer+0x4*i,VArr(GetNameVArr,1+i),1/65536,0xFF0000) -- 2->0
		end
	elseif InitBytes == 2 then
		for i = 0, 3 do
			f_ReadX(PlayerID,0x57EEE8 + 0x24*TargetPlayer+0x4*i,VArr(GetNameVArr,0+i),1/256,0xFF000000) -- 3->2
			f_ReadX(PlayerID,0x57EEEC + 0x24*TargetPlayer+0x4*i,VArr(GetNameVArr,0+i),16777216,0xFF) -- 0 -> 3
			f_ReadX(PlayerID,0x57EEEC + 0x24*TargetPlayer+0x4*i,VArr(GetNameVArr,1+i),1/256,0xFFFF00) -- 12->01
		end
	elseif InitBytes == 3 then
		for i = 0, 3 do
			f_ReadX(PlayerID,0x57EEE8 + 0x24*TargetPlayer+0x4*i,VArr(GetNameVArr,0+i),1,0xFF000000) -- 3->3
			f_ReadX(PlayerID,0x57EEEC + 0x24*TargetPlayer+0x4*i,VArr(GetNameVArr,1+i),1,0xFFFFFF) -- 012 -> 012
		end
	end
end

function ItoX(PlayerID,Input,OutputVA,Color) -- VA[0~3]
	if Color == nil or Color == "X" or Color == 0 then
 		Color = 0x0D
 	end
 	if type(Color) == "number" then
 		local TempColor = Color
 		Color = {}
 		for i = 1, 4 do
 			table.insert(Color,TempColor)
 		end
	end
	for i = 1, 4 do
		if Color[i] == nil or Color[i] == "X" or Color[i] == 0 then
			Color[i] = 0xD
		end
	end

	if type(OutputVA[4]) == "string" and OutputVA[4] ~= "X" then -- VArray 0 ~ 3 / 1234 -> １２３４

		DoActionsX(PlayerID,{SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3],SetTo,0x60BCEF00+Color[1]),
			SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x60BCEF00+Color[2]),
			SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x60BCEF00+Color[3]),
			SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x60BCEF00+Color[4])})

		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x60*1,0xFF);
				CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x7E*1,0xFF);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3],SetTo,0x20BD0000,0xFFFF0000);
			},
			flag = {Preserved}
		}
		for i = 7, 0, -1 do -- 1 -> １
 			CBit = 2^i 
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,CBit,CBit);
				},
				actions = {
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3],Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
		end
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,0x5C*1,0xFF);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3],SetTo,0xA6BFEF00,0xFFFFFF00);
			},
			flag = {Preserved}
		}
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,0x20*0x1,0xFF);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3],SetTo,0x8080E300,0xFFFFFF00);
			},
			flag = {Preserved}
		}
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x1F*1,0xFF);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3],SetTo,0x0D0D0D00,0xFFFFFF00);
			},
			flag = {Preserved}
		}
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x7F*1,0xFF);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3],SetTo,0x0D0D0D00,0xFFFFFF00);
			},
			flag = {Preserved}
		}

		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x60*0x100,0xFF00);
				CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x7E*0x100,0xFF00);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x20BD0000,0xFFFF0000);
			},
			flag = {Preserved}
		}
		for i = 15, 8, -1 do -- 2 -> ２
 			CBit = 2^i 
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,CBit,CBit);
				},
				actions = {
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,Add,2^i*0x010000);
				},
				flag = {Preserved}
			}
		end
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x60*0x100,0xFF00);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x00BD0000,0x00FF0000);
			},
			flag = {Preserved}
		}
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,0x5C*0x100,0xFF00);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0xA6BFEF00,0xFFFFFF00);
			},
			flag = {Preserved}
		}
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,0x20*0x100,0xFF00);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x8080E300,0xFFFFFF00);
			},
			flag = {Preserved}
		}
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x1F*0x100,0xFF00);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D00,0xFFFFFF00);
			},
			flag = {Preserved}
		}
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x7F*0x100,0xFF00);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D00,0xFFFFFF00);
			},
			flag = {Preserved}
		}


		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x60*0x10000,0xFF0000);
				CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x7E*0x10000,0xFF0000);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x20BD0000,0xFFFF0000);
			},
			flag = {Preserved}
		}
		for i = 23, 16, -1 do -- 3 -> ３
 			CBit = 2^i 
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,CBit,CBit);
				},
				actions = {
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,Add,2^i*0x0100);
				},
				flag = {Preserved}
			}
		end
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x60*0x10000,0xFF0000);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x00BD0000,0x00FF0000);
			},
			flag = {Preserved}
		}
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,0x5C*0x10000,0xFF0000);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0xA6BFEF00,0xFFFFFF00);
			},
			flag = {Preserved}
		}
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,0x20*0x10000,0xFF0000);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x8080E300,0xFFFFFF00);
			},
			flag = {Preserved}
		}
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x1F*0x10000,0xFF0000);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D00,0xFFFFFF00);
			},
			flag = {Preserved}
		}
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x7F*0x10000,0xFF0000);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D00,0xFFFFFF00);
			},
			flag = {Preserved}
		}


		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x60*0x1000000,0xFF000000);
				CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x7E*0x1000000,0xFF000000);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x20BD0000,0xFFFF0000);
			},
			flag = {Preserved}
		}
		for i = 31, 24, -1 do -- 4 -> ４
 			CBit = 2^i 
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,CBit,CBit);
				},
				actions = {
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,Add,2^i*0x01);
				},
				flag = {Preserved}
			}
		end
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x60*0x1000000,0xFF000000);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x00BD0000,0x00FF0000);
			},
			flag = {Preserved}
		}
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,0x5C*0x1000000,0xFF000000);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0xA6BFEF00,0xFFFFFF00);
			},
			flag = {Preserved}
		}
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,0x20*0x1000000,0xFF000000);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x8080E300,0xFFFFFF00);
			},
			flag = {Preserved}
		}
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x1F*0x1000000,0xFF000000);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D00,0xFFFFFF00);
			},
			flag = {Preserved}
		}
		Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
				CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x7F*0x1000000,0xFF000000);
			},
			actions = {
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D00,0xFFFFFF00);
			},
			flag = {Preserved}
		}

	else -- 선택 1234->１２３４
		if OutputVA[1] ~= nil or OutputVA[1] ~= "X" then
			DoActionsX(PlayerID,{SetCtrig1X(OutputVA[1][1],OutputVA[1][2],0x15C,OutputVA[1][3],SetTo,0x60BCEF00+Color[1])})

			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x60*1,0xFF);
					CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x7E*1,0xFF);
				},
				actions = {
					SetCtrig1X(OutputVA[1][1],OutputVA[1][2],0x15C,OutputVA[1][3],SetTo,0x20BD0000,0xFFFF0000);
				},
				flag = {Preserved}
			}
			for i = 7, 0, -1 do -- 1 -> １
	 			CBit = 2^i 
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
						CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,CBit,CBit);
					},
					actions = {
						SetCtrig1X(OutputVA[1][1],OutputVA[1][2],0x15C,OutputVA[1][3],Add,2^i*0x01000000);
					},
					flag = {Preserved}
				}
			end
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,0x5C*1,0xFF);
				},
				actions = {
					SetCtrig1X(OutputVA[1][1],OutputVA[1][2],0x15C,OutputVA[1][3],SetTo,0xA6BFEF00,0xFFFFFF00);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,0x20*0x1,0xFF);
				},
				actions = {
					SetCtrig1X(OutputVA[1][1],OutputVA[1][2],0x15C,OutputVA[1][3],SetTo,0x8080E300,0xFFFFFF00);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x1F*0x1,0xFF);
				},
				actions = {
					SetCtrig1X(OutputVA[1][1],OutputVA[1][2],0x15C,OutputVA[1][3],SetTo,0x0D0D0D00,0xFFFFFF00);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x7F*0x1,0xFF);
				},
				actions = {
					SetCtrig1X(OutputVA[1][1],OutputVA[1][2],0x15C,OutputVA[1][3],SetTo,0x0D0D0D00,0xFFFFFF00);
				},
				flag = {Preserved}
			}
		end

		if OutputVA[2] ~= nil or OutputVA[2] ~= "X" then
			DoActionsX(PlayerID,{SetCtrig1X(OutputVA[2][1],OutputVA[2][2],0x15C,OutputVA[2][3],SetTo,0x60BCEF00+Color[2])})

			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x60*0x100,0xFF00);
					CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x7E*0x100,0xFF00);
				},
				actions = {
					SetCtrig1X(OutputVA[2][1],OutputVA[2][2],0x15C,OutputVA[2][3],SetTo,0x20BD0000,0xFFFF0000);
				},
				flag = {Preserved}
			}
			for i = 15, 8, -1 do -- 1 -> １
	 			CBit = 2^i 
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
						CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,CBit,CBit);
					},
					actions = {
						SetCtrig1X(OutputVA[2][1],OutputVA[2][2],0x15C,OutputVA[2][3],Add,2^i*0x010000);
					},
					flag = {Preserved}
				}
			end
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,0x5C*0x100,0xFF00);
				},
				actions = {
					SetCtrig1X(OutputVA[2][1],OutputVA[2][2],0x15C,OutputVA[2][3],SetTo,0xA6BFEF00,0xFFFFFF00);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,0x20*0x100,0xFF00);
				},
				actions = {
					SetCtrig1X(OutputVA[2][1],OutputVA[2][2],0x15C,OutputVA[2][3],SetTo,0x8080E300,0xFFFFFF00);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x1F*0x100,0xFF00);
				},
				actions = {
					SetCtrig1X(OutputVA[2][1],OutputVA[2][2],0x15C,OutputVA[2][3],SetTo,0x0D0D0D00,0xFFFFFF00);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x7F*0x100,0xFF00);
				},
				actions = {
					SetCtrig1X(OutputVA[2][1],OutputVA[2][2],0x15C,OutputVA[2][3],SetTo,0x0D0D0D00,0xFFFFFF00);
				},
				flag = {Preserved}
			}
		end

		if OutputVA[3] ~= nil or OutputVA[3] ~= "X" then
			DoActionsX(PlayerID,{SetCtrig1X(OutputVA[3][1],OutputVA[3][2],0x15C,OutputVA[3][3],SetTo,0x60BCEF00+Color[3])})

			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x60*0x10000,0xFF0000);
					CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x7E*0x10000,0xFF0000);
				},
				actions = {
					SetCtrig1X(OutputVA[3][1],OutputVA[3][2],0x15C,OutputVA[3][3],SetTo,0x20BD0000,0xFFFF0000);
				},
				flag = {Preserved}
			}
			for i = 23, 16, -1 do -- 1 -> １
	 			CBit = 2^i 
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
						CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,CBit,CBit);
					},
					actions = {
						SetCtrig1X(OutputVA[3][1],OutputVA[3][2],0x15C,OutputVA[3][3],Add,2^i*0x0100);
					},
					flag = {Preserved}
				}
			end
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,0x5C*0x10000,0xFF0000);
				},
				actions = {
					SetCtrig1X(OutputVA[3][1],OutputVA[3][2],0x15C,OutputVA[3][3],SetTo,0xA6BFEF00,0xFFFFFF00);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,0x20*0x10000,0xFF0000);
				},
				actions = {
					SetCtrig1X(OutputVA[3][1],OutputVA[3][2],0x15C,OutputVA[3][3],SetTo,0x8080E300,0xFFFFFF00);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x1F*0x10000,0xFF0000);
				},
				actions = {
					SetCtrig1X(OutputVA[3][1],OutputVA[3][2],0x15C,OutputVA[3][3],SetTo,0x0D0D0D00,0xFFFFFF00);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x7F*0x10000,0xFF0000);
				},
				actions = {
					SetCtrig1X(OutputVA[3][1],OutputVA[3][2],0x15C,OutputVA[3][3],SetTo,0x0D0D0D00,0xFFFFFF00);
				},
				flag = {Preserved}
			}
		end

		if OutputVA[4] ~= nil or OutputVA[4] ~= "X" then
			DoActionsX(PlayerID,{SetCtrig1X(OutputVA[4][1],OutputVA[4][2],0x15C,OutputVA[4][3],SetTo,0x60BCEF00+Color[4])})

			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x60*0x1000000,0xFF000000);
					CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x7E*0x1000000,0xFF000000);
				},
				actions = {
					SetCtrig1X(OutputVA[4][1],OutputVA[4][2],0x15C,OutputVA[4][3],SetTo,0x20BD0000,0xFFFF0000);
				},
				flag = {Preserved}
			}
			for i = 31, 24, -1 do -- 1 -> １
	 			CBit = 2^i 
				Trigger {
					players = {ParsePlayer(PlayerID)},
					conditions = {
						Label(0);
						CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,CBit,CBit);
					},
					actions = {
						SetCtrig1X(OutputVA[4][1],OutputVA[4][2],0x15C,OutputVA[4][3],Add,2^i*0x01);
					},
					flag = {Preserved}
				}
			end
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,0x5C*0x1000000,0xFF000000);
				},
				actions = {
					SetCtrig1X(OutputVA[4][1],OutputVA[4][2],0x15C,OutputVA[4][3],SetTo,0xA6BFEF00,0xFFFFFF00);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],Exactly,0x20*0x1000000,0xFF000000);
				},
				actions = {
					SetCtrig1X(OutputVA[4][1],OutputVA[4][2],0x15C,OutputVA[4][3],SetTo,0x8080E300,0xFFFFFF00);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x1F*0x1000000,0xFF000000);
				},
				actions = {
					SetCtrig1X(OutputVA[4][1],OutputVA[4][2],0x15C,OutputVA[4][3],SetTo,0x0D0D0D00,0xFFFFFF00);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x7F*0x1000000,0xFF000000);
				},
				actions = {
					SetCtrig1X(OutputVA[4][1],OutputVA[4][2],0x15C,OutputVA[4][3],SetTo,0x0D0D0D00,0xFFFFFF00);
				},
				flag = {Preserved}
			}
		end
	end
end

function ItoName(PlayerID,TargetPlayer,OutputVA,Color) -- VA[0~4]
	if Color == nil or Color == "X" or Color == 0 then
 		Color = 0x0D
 	end
	GetNameVArr = GetVArray(OutputVA)
	DoActionsX(PlayerID,{SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3],SetTo,0x000D0D0D + Color*0x01000000),
		SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D),
		SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D),
		SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D),
		SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo,0x0D0D0D0D)})
	for i = 0, 3 do
		f_ReadX(PlayerID,0x57EEE8 + 0x24*TargetPlayer+0x4*i,VArr(GetNameVArr,1+i),1/16777216,0xFF000000) -- 3->0
		f_ReadX(PlayerID,0x57EEEC + 0x24*TargetPlayer+0x4*i,VArr(GetNameVArr,1+i),256,0xFFFFFF) -- 012 -> 123
	end
end

function ItoDec(PlayerID,Input,OutputVA,ZeroMode,Color,Sign,DigitMax,DigitMin) -- VA index = 상수 / Int -> Dec VA[0~3]
	STPopTrigArr(PlayerID)
-- B = 0x20, C = ColorCod, S = Sign, 0~9 = Number, X = 0x0D
-- ZeroMode : 0 표시 방법 선택 / 0 (0) / Space (1) / 0x0D (2)
-- Color : 컬러코드 추가 / 0x01 ~ 0x1F (기본 0x0D)
-- Sign : 부호 추가 / 부호없음 (0) / 부호추가(1) / 부호추가 +Space (2)
-- DigitMax : 시작 자리수 (기본 10) / DigitMin : 끝 자리수 (기본1)
 	if Sign == nil or Sign == "X" then
 		Sign = 0
 	end
 	if Color == nil or Color == "X" or Color == 0 then
 		Color = 0x0D
 	end
 	if ZeroMode == nil or ZeroMode == "X" then
 		ZeroMode = 0
 	end
 	if ZeroMode == 0 then
 		ZeroMode = 0x30
 	elseif ZeroMode == 1 then
 		ZeroMode = 0x20
 	elseif ZeroMode == 2 then
 		ZeroMode = 0x0D
 	end
 	if DigitMax == nil or DigitMax == "X" then
 		DigitMax = 10
 	end
 	if DigitMin == nil or DigitMin == "X" then
 		DigitMin = 1
 	end

 	local X = {}
 	if Sign == 0 then
	 	Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X(Input[1],Input[2],0x148,Input[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Input[1],Input[2],0x160,Input[3],SetTo,SetTo*16777216,0xFF000000);
				SetCtrigX(Input[1],Input[2],0x158,Input[3],SetTo,"X",CRet[1],0x15C,1,0);
				CallLabelAlways(Input[1],Input[2],Input[3]);
			},
			flag = {Preserved}
		}
	else
		CIfX(PlayerID, CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x7FFFFFFF))
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X(Input[1],Input[2],0x148,Input[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Input[1],Input[2],0x160,Input[3],SetTo,SetTo*16777216,0xFF000000);
					SetCtrigX(Input[1],Input[2],0x158,Input[3],SetTo,"X",CRet[1],0x15C,1,0);
					CallLabelAlways(Input[1],Input[2],Input[3]);
				},
				flag = {Preserved}
			}
		CElseX()
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0xFFFFFFFF);
					SetCtrig1X(Input[1],Input[2],0x148,Input[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Input[1],Input[2],0x160,Input[3],SetTo,Subtract*16777216,0xFF000000);
					SetCtrigX(Input[1],Input[2],0x158,Input[3],SetTo,"X",CRet[1],0x15C,1,0);
					CallLabelAlways(Input[1],Input[2],Input[3]);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Add,1);
				},
				flag = {Preserved}
			}
		CIfXEnd()
	end
 	-- XXXX[0] 90SC[1] 5678[2] 1234[3] / CXXX[0] 90BS[1] 5678[2] 1234[3]
 	if Sign == 0 then
	 	DoActionsX(PlayerID,{SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3],SetTo,0x0D0D0D0D),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x30*0x01010000 + 0x00000D00 + Color*0x00000001),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x30*0x01010101),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x30*0x01010101)})
	 elseif Sign == 1 then
	 	DoActionsX(PlayerID,{SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3],SetTo,0x0D0D0D0D),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x30*0x01010000 + 0x00000D00 + Color*0x00000001),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x30*0x01010101),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x30*0x01010101)})
	 	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x7FFFFFFF);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x00002B00,0x0000FF00)},flag = {Preserved}}
	 	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x80000000);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x00002D00,0x0000FF00)},flag = {Preserved}}
	 elseif Sign == 2 then
	 	DoActionsX(PlayerID,{SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3],SetTo,0x000D0D0D + Color * 0x01000000),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x30*0x01010000 + 0x0000200D),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x30*0x01010101),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x30*0x01010101)})
	 	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x7FFFFFFF);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0000002B,0x000000FF)},flag = {Preserved}}
	 	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x80000000);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0000002D,0x000000FF)},flag = {Preserved}}
	 end

	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,999999999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x00010000*ZeroMode,0x00FF0000)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,99999999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x01000000*ZeroMode,0xFF000000)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,9999999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x00000001*ZeroMode,0x000000FF)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,999999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x00000100*ZeroMode,0x0000FF00)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,99999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x00010000*ZeroMode,0x00FF0000)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,9999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x01000000*ZeroMode,0xFF000000)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x00000001*ZeroMode,0x000000FF)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,99);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x00000100*ZeroMode,0x0000FF00)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,9);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x00010000*ZeroMode,0x00FF0000)},flag = {Preserved}}
	 	
 	for i = 2, 0, -1 do
 			CBit = 2^i * 1000000000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,Add,2^i*0x010000);
				},
				flag = {Preserved}
			}
	end

	for i = 3, 0, -1 do
 			CBit = 2^i * 100000000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end

	for i = 3, 0, -1 do
 			CBit = 2^i * 10000000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,Add,2^i*0x00000001);
				},
				flag = {Preserved}
			}
	end

	for i = 3, 0, -1 do
 			CBit = 2^i * 1000000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,Add,2^i*0x0100);
				},
				flag = {Preserved}
			}
	end

	for i = 3, 0, -1 do
 			CBit = 2^i * 100000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,Add,2^i*0x010000);
				},
				flag = {Preserved}
			}
	end

	for i = 3, 0, -1 do
 			CBit = 2^i * 10000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end

	for i = 3, 0, -1 do
 			CBit = 2^i * 1000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,Add,2^i*0x01);
				},
				flag = {Preserved}
			}
	end

	for i = 3, 0, -1 do
 			CBit = 2^i * 100
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,Add,2^i*0x0100);
				},
				flag = {Preserved}
			}
	end

	for i = 3, 0, -1 do
 			CBit = 2^i * 10
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,Add,2^i*0x010000);
				},
				flag = {Preserved}
			}
	end

	for i = 3, 0, -1 do
 			CBit = 2^i * 1
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end

	if DigitMax == 9 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0x00FF0000))
	 elseif DigitMax == 8 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFF0000))
	 elseif DigitMax == 7 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFF0000))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0x000000FF))
	 elseif DigitMax == 6 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFF0000))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0x0000FFFF))
	 elseif DigitMax == 5 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFF0000))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0x00FFFFFF))
	 elseif DigitMax == 4 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFF0000))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFFFF))
	 elseif DigitMax == 3 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFF0000))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFFFF))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0x000000FF))
	 elseif DigitMax == 2 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFF0000))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFFFF))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0x0000FFFF))
	 elseif DigitMax == 1 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFF0000))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFFFF))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0x00FFFFFF))
	 end

	 if DigitMin == 2 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFF000000))
	 elseif DigitMin == 3 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFF0000))
	 elseif DigitMin == 4 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMin == 5 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFFFF))
	 elseif DigitMin == 6 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFFFF))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFF000000))
	 elseif DigitMin == 7 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFFFF))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFF0000))
	 elseif DigitMin == 8 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFFFF))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMin == 9 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFFFF))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFFFF))
	 elseif DigitMin == 10 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFFFF))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFFFF))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFF000000))
	 end
	 DoActionsX(PlayerID,X)
end

function ItoHex(PlayerID,Input,OutputVA,ZeroMode,Color,Case,DigitMax,DigitMin) -- VA index = 상수 / Int -> Hex VA[0~2]
	STPopTrigArr(PlayerID)
-- B = 0x20, C = ColorCod, 1~8 = Number, X = 0x0D
-- ZeroMode : 0 표시 방법 선택 / 0 (0) / Space (1) / 0x0D (2)
-- Color : 컬러코드 추가 / 0x01 ~ 0x1F (기본 0x0D)
-- DigitMax : 시작 자리수 (기본 8) / DigitMin : 끝 자리수 (기본1)
-- Case : 대소문자 / 대문자(0) / 소문자(1)
	if Case == nil or Case == "X" then
		Case = 0
	end
	if Case == 0 then
		Case = 0x7
	elseif Case == 1 then
		Case = 0x27
	end
 	if Color == nil or Color == "X" or Color == 0 then
 		Color = 0x0D
 	end
 	if ZeroMode == nil or ZeroMode == "X" then
 		ZeroMode = 0
 	end
 	if ZeroMode == 0 then
 		ZeroMode = 0x30
 	elseif ZeroMode == 1 then
 		ZeroMode = 0x20
 	elseif ZeroMode == 2 then
 		ZeroMode = 0x0D
 	end
 	if DigitMax == nil or DigitMax == "X" then
 		DigitMax = 8
 	end
 	if DigitMin == nil or DigitMin == "X" then
 		DigitMin = 1
 	end

 	local X = {}
 	Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X(Input[1],Input[2],0x148,Input[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Input[1],Input[2],0x160,Input[3],SetTo,SetTo*16777216,0xFF000000);
				SetCtrigX(Input[1],Input[2],0x158,Input[3],SetTo,"X",CRet[1],0x15C,1,0);
				CallLabelAlways(Input[1],Input[2],Input[3]);
			},
			flag = {Preserved}
		}

 	-- CXXX[0] 5678[1] 1234[2]
 	DoActionsX(PlayerID,{SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3],SetTo,0x000D0D0D + Color*0x01000000),
			SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x30*0x01010101),
			SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x30*0x01010101)})

	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,0xFFFFFFF);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x00000001*ZeroMode,0x000000FF)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,0xFFFFFF);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x00000100*ZeroMode,0x0000FF00)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,0xFFFFF);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x00010000*ZeroMode,0x00FF0000)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,0xFFFF);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x01000000*ZeroMode,0xFF000000)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,0xFFF);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x00000001*ZeroMode,0x000000FF)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,0xFF);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x00000100*ZeroMode,0x0000FF00)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,0xF);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x00010000*ZeroMode,0x00FF0000)},flag = {Preserved}}
	 	
	for i = 3, 0, -1 do
 			CBit = 2^i * 0x10000000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,Add,2^i*0x00000001);
				},
				flag = {Preserved}
			}
	end
	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,AtLeast,0xA,0x0000000F);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,Add,0x00000001*Case)},flag = {Preserved}}
	for i = 3, 0, -1 do
 			CBit = 2^i * 0x1000000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,Add,2^i*0x0100);
				},
				flag = {Preserved}
			}
	end
	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,AtLeast,0xA00,0x00000F00);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,Add,0x00000100*Case)},flag = {Preserved}}
	for i = 3, 0, -1 do
 			CBit = 2^i * 0x100000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,Add,2^i*0x010000);
				},
				flag = {Preserved}
			}
	end
	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,AtLeast,0xA0000,0x000F0000);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,Add,0x00010000*Case)},flag = {Preserved}}
	for i = 3, 0, -1 do
 			CBit = 2^i * 0x10000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end
	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,AtLeast,0xA000000,0x0F000000);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,Add,0x01000000*Case)},flag = {Preserved}}
	for i = 3, 0, -1 do
 			CBit = 2^i * 0x1000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,Add,2^i*0x01);
				},
				flag = {Preserved}
			}
	end
	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,AtLeast,0xA,0x0000000F);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,Add,0x00000001*Case)},flag = {Preserved}}
	for i = 3, 0, -1 do
 			CBit = 2^i * 0x100
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,Add,2^i*0x0100);
				},
				flag = {Preserved}
			}
	end
	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,AtLeast,0xA00,0x00000F00);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,Add,0x00000100*Case)},flag = {Preserved}}
	for i = 3, 0, -1 do
 			CBit = 2^i * 0x10
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,Add,2^i*0x010000);
				},
				flag = {Preserved}
			}
	end
	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,AtLeast,0xA0000,0x000F0000);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,Add,0x00010000*Case)},flag = {Preserved}}
	for i = 3, 0, -1 do
 			CBit = 2^i * 0x1
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end
	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,AtLeast,0xA000000,0x0F000000);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,Add,0x01000000*Case)},flag = {Preserved}}
	if DigitMax == 7 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0x000000FF))
	 elseif DigitMax == 6 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0x0000FFFF))
	 elseif DigitMax == 5 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0x00FFFFFF))
	 elseif DigitMax == 4 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFFFFFF))
	 elseif DigitMax == 3 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFFFFFF))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0x000000FF))
	 elseif DigitMax == 2 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFFFFFF))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0x0000FFFF))
	 elseif DigitMax == 1 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFFFFFF))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0x00FFFFFF))
	 end

	 if DigitMin == 2 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFF000000))
	 elseif DigitMin == 3 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFF0000))
	 elseif DigitMin == 4 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMin == 5 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFFFF))
	 elseif DigitMin == 6 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFFFF))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFF000000))
	 elseif DigitMin == 7 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFFFF))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFF0000))
	 elseif DigitMin == 8 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFFFF))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 end
	 DoActionsX(PlayerID,X)
end
--[[ 3Bytes Code
0x90BCEF00 ~ 0x99BCEF00 : ０１２３４５６７８９
0x8BBCEF00 : ＋
0x8DBCEF00 : －
0x8080E300 : 　(Space)
0xA1BCEF00 ~ 0xBABCEF00 : Ａ～Ｚ
0x78BDEF00 ~ 0x93BDEF00 : ａ～ｚ
]]--
function ItoDecX(PlayerID,Input,OutputVA,ZeroMode,Color,Sign,DigitMax,DigitMin) -- VA index = 상수 / Int -> DecX VA[0~11] 
	STPopTrigArr(PlayerID)
-- B = 0x20, C = ColorCod, S = Sign, 0~9 = Number, X = 0x0D
-- ZeroMode : 0 표시 방법 선택 / 0 (0) / Space (1) / 0x0D (2)
-- Color : 컬러코드 추가 / 0x01 ~ 0x1F (기본 0x0D) : 맨뒤부터 적용
-- Sign : 부호 추가 / 부호없음 (0) / 부호추가(1) / 부호추가 +Space (2)
-- DigitMax : 시작 자리수 (기본 10) / DigitMin : 끝 자리수 (기본1)
 	if Sign == nil or Sign == "X" then
 		Sign = 0
 	end
 	if Color == nil or Color == "X" or Color == 0 then
 		Color = 0x0D
 	end
 	if type(Color) == "number" then
 		local TempColor = Color
 		Color = {}
 		for i = 1, 11 do
 			table.insert(Color,TempColor)
 		end
	end
	for i = 1, 11 do
		if Color[i] == nil or Color[i] == "X" or Color[i] == 0 then
			Color[i] = 0xD
		end
	end
 	if ZeroMode == nil or ZeroMode == "X" then
 		ZeroMode = 0
 	end
 	if ZeroMode == 0 then
 		ZeroMode = 0x90BCEF00
 	elseif ZeroMode == 1 then
 		ZeroMode = 0x8080E300
 	elseif ZeroMode == 2 then
 		ZeroMode = 0x0D0D0D00
 	end
 	if DigitMax == nil or DigitMax == "X" then
 		DigitMax = 10
 	end
 	if DigitMin == nil or DigitMin == "X" then
 		DigitMin = 1
 	end

 	local X = {}
 	if Sign == 0 then
	 	Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X(Input[1],Input[2],0x148,Input[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Input[1],Input[2],0x160,Input[3],SetTo,SetTo*16777216,0xFF000000);
				SetCtrigX(Input[1],Input[2],0x158,Input[3],SetTo,"X",CRet[1],0x15C,1,0);
				CallLabelAlways(Input[1],Input[2],Input[3]);
			},
			flag = {Preserved}
		}
	else
		CIfX(PlayerID, CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x7FFFFFFF))
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X(Input[1],Input[2],0x148,Input[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Input[1],Input[2],0x160,Input[3],SetTo,SetTo*16777216,0xFF000000);
					SetCtrigX(Input[1],Input[2],0x158,Input[3],SetTo,"X",CRet[1],0x15C,1,0);
					CallLabelAlways(Input[1],Input[2],Input[3]);
				},
				flag = {Preserved}
			}
		CElseX()
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0xFFFFFFFF);
					SetCtrig1X(Input[1],Input[2],0x148,Input[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Input[1],Input[2],0x160,Input[3],SetTo,Subtract*16777216,0xFF000000);
					SetCtrigX(Input[1],Input[2],0x158,Input[3],SetTo,"X",CRet[1],0x15C,1,0);
					CallLabelAlways(Input[1],Input[2],Input[3]);
				},
				flag = {Preserved}
			}
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Add,1);
				},
				flag = {Preserved}
			}
		CIfXEnd()
	end
	
	-- CXXX[0] BS-S[1] 0-0C[2] 9-9C[3] 8-8C[4] 7-7C[5] 6-6C[6] 5-5C[7] 4-4C[8] 3-3C[9] 2-2C[10] 1-1C[11] Sign == 2
 	-- XXXX[0] S-SC[1] 0-0C[2] 9-9C[3] 8-8C[4] 7-7C[5] 6-6C[6] 5-5C[7] 4-4C[8] 3-3C[9] 2-2C[10] 1-1C[11] Sign == 1
 	-- XXXX[0] XXXC[1] 0-0C[2] 9-9C[3] 8-8C[4] 7-7C[5] 6-6C[6] 5-5C[7] 4-4C[8] 3-3C[9] 2-2C[10] 1-1C[11] Sign == 0
 	if Sign == 0 then
	 	DoActionsX(PlayerID,{
	 			SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+0,SetTo, 0x0D0D0D0D),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo, 0x0D0D0D00+Color[11]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo, 0x90BCEF00+Color[10]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo, 0x90BCEF00+Color[9]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo, 0x90BCEF00+Color[8]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo, 0x90BCEF00+Color[7]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo, 0x90BCEF00+Color[6]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo, 0x90BCEF00+Color[5]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo, 0x90BCEF00+Color[4]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+9,SetTo, 0x90BCEF00+Color[3]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+10,SetTo,0x90BCEF00+Color[2]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+11,SetTo,0x90BCEF00+Color[1])})
	 elseif Sign == 1 then
	 	DoActionsX(PlayerID,{
	 			SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+0,SetTo, 0x0D0D0D0D),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo, 0x0D0D0D00+Color[11]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo, 0x90BCEF00+Color[10]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo, 0x90BCEF00+Color[9]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo, 0x90BCEF00+Color[8]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo, 0x90BCEF00+Color[7]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo, 0x90BCEF00+Color[6]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo, 0x90BCEF00+Color[5]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo, 0x90BCEF00+Color[4]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+9,SetTo, 0x90BCEF00+Color[3]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+10,SetTo,0x90BCEF00+Color[2]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+11,SetTo,0x90BCEF00+Color[1])})
	 	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x7FFFFFFF);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x8BBCEF00,0xFFFFFF00)},flag = {Preserved}}
	 	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x80000000);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x8DBCEF00,0xFFFFFF00)},flag = {Preserved}}
	 elseif Sign == 2 then
	 	DoActionsX(PlayerID,{
	 			SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+0,SetTo, 0x000D0D0D+Color[11]*0x01000000),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo, 0x200D0D0D),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo, 0x90BCEF00+Color[10]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo, 0x90BCEF00+Color[9]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo, 0x90BCEF00+Color[8]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo, 0x90BCEF00+Color[7]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo, 0x90BCEF00+Color[6]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo, 0x90BCEF00+Color[5]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo, 0x90BCEF00+Color[4]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+9,SetTo, 0x90BCEF00+Color[3]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+10,SetTo,0x90BCEF00+Color[2]),
				SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+11,SetTo,0x90BCEF00+Color[1])})
	 	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x7FFFFFFF);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x008BBCEF,0x00FFFFFF)},flag = {Preserved}}
	 	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x80000000);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x008DBCEF,0x00FFFFFF)},flag = {Preserved}}
	 end
	
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,999999999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,ZeroMode,0xFFFFFF00)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,99999999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,ZeroMode,0xFFFFFF00)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,9999999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo,ZeroMode,0xFFFFFF00)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,999999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo,ZeroMode,0xFFFFFF00)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,99999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo,ZeroMode,0xFFFFFF00)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,9999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo,ZeroMode,0xFFFFFF00)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo,ZeroMode,0xFFFFFF00)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,99);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+9,SetTo,ZeroMode,0xFFFFFF00)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,9);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+10,SetTo,ZeroMode,0xFFFFFF00)},flag = {Preserved}}
	
 	for i = 2, 0, -1 do
 			CBit = 2^i * 1000000000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end

	for i = 3, 0, -1 do
 			CBit = 2^i * 100000000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end

	for i = 3, 0, -1 do
 			CBit = 2^i * 10000000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end

	for i = 3, 0, -1 do
 			CBit = 2^i * 1000000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end

	for i = 3, 0, -1 do
 			CBit = 2^i * 100000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end

	for i = 3, 0, -1 do
 			CBit = 2^i * 10000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end

	for i = 3, 0, -1 do
 			CBit = 2^i * 1000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end

	for i = 3, 0, -1 do
 			CBit = 2^i * 100
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+9,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end

	for i = 3, 0, -1 do
 			CBit = 2^i * 10
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+10,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end

	for i = 3, 0, -1 do
 			CBit = 2^i * 1
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+11,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end

	if DigitMax == 9 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMax == 8 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMax == 7 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMax == 6 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMax == 5 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMax == 4 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMax == 3 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMax == 2 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+9,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMax == 1 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+9,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+10,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 end

	 if DigitMin == 2 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+11,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMin == 3 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+11,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+10,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMin == 4 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+11,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+10,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+9,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMin == 5 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+11,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+10,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+9,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMin == 6 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+11,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+10,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+9,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMin == 7 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+11,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+10,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+9,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMin == 8 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+11,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+10,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+9,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMin == 9 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+11,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+10,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+9,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMin == 10 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+11,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+10,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+9,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 end
	 DoActionsX(PlayerID,X)
end

function ItoHexX(PlayerID,Input,OutputVA,ZeroMode,Color,Case,DigitMax,DigitMin) -- VA index = 상수 / Int -> DecX VA[0~8] 
	STPopTrigArr(PlayerID)
-- B = 0x20, C = ColorCod,  1~8 = Number, X = 0x0D
-- ZeroMode : 0 표시 방법 선택 / 0 (0) / Space (1) / 0x0D (2)
-- Color : 컬러코드 추가 / 0x01 ~ 0x1F (기본 0x0D) : 맨뒤부터 적용
-- Case : 대소문자 / 대문자(0) / 소문자(1)
-- DigitMax : 시작 자리수 (기본 10) / DigitMin : 끝 자리수 (기본1)
 	if Case == nil or Case == "X" then
 		Case = 0
 	end
 	if Case == 0 then
		Case = 0x07000000
	elseif Case == 1 then
		Case = 0xE7010000
	end
 	if Color == nil or Color == "X" or Color == 0 then
 		Color = 0x0D
 	end
 	if type(Color) == "number" then
 		local TempColor = Color
 		Color = {}
 		for i = 1, 8 do
 			table.insert(Color,TempColor)
 		end
	end
	for i = 1, 8 do
		if Color[i] == nil or Color[i] == "X" or Color[i] == 0 then
			Color[i] = 0xD
		end
	end
 	if ZeroMode == nil or ZeroMode == "X" then
 		ZeroMode = 0
 	end
 	if ZeroMode == 0 then
 		ZeroMode = 0x90BCEF00
 	elseif ZeroMode == 1 then
 		ZeroMode = 0x8080E300
 	elseif ZeroMode == 2 then
 		ZeroMode = 0x0D0D0D00
 	end
 	if DigitMax == nil or DigitMax == "X" then
 		DigitMax = 8
 	end
 	if DigitMin == nil or DigitMin == "X" then
 		DigitMin = 1
 	end

 	local X = {}
 	Trigger {
			players = {ParsePlayer(PlayerID)},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrig1X(Input[1],Input[2],0x148,Input[3],SetTo,0xFFFFFFFF);
				SetCtrig1X(Input[1],Input[2],0x160,Input[3],SetTo,SetTo*16777216,0xFF000000);
				SetCtrigX(Input[1],Input[2],0x158,Input[3],SetTo,"X",CRet[1],0x15C,1,0);
				CallLabelAlways(Input[1],Input[2],Input[3]);
			},
			flag = {Preserved}
		}

	-- XXXX[0] 8-8C[1] 7-7C[2] 6-6C[3] 5-5C[4] 4-4C[5] 3-3C[6] 2-2C[7] 1-1C[8]
	 DoActionsX(PlayerID,{
	 		SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+0,SetTo, 0x0D0D0D0D),
			SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo, 0x90BCEF00+Color[8]),
			SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo, 0x90BCEF00+Color[7]),
			SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo, 0x90BCEF00+Color[6]),
			SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo, 0x90BCEF00+Color[5]),
			SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo, 0x90BCEF00+Color[4]),
			SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo, 0x90BCEF00+Color[3]),
			SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo, 0x90BCEF00+Color[2]),
			SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo, 0x90BCEF00+Color[1])})
	
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,0xFFFFFFF);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,ZeroMode,0xFFFFFF00)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,0xFFFFFF);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,ZeroMode,0xFFFFFF00)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,0xFFFFF);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,ZeroMode,0xFFFFFF00)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,0xFFFF);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo,ZeroMode,0xFFFFFF00)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,0xFFF);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo,ZeroMode,0xFFFFFF00)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,0xFF);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo,ZeroMode,0xFFFFFF00)},flag = {Preserved}}
	 Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,0xF);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo,ZeroMode,0xFFFFFF00)},flag = {Preserved}}
	
	for i = 3, 0, -1 do
 			CBit = 2^i * 0x10000000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end
	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,AtLeast,0x0A000000,0x0F000000);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,Add,Case)},flag = {Preserved}}
	for i = 3, 0, -1 do
 			CBit = 2^i * 0x1000000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end
	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,AtLeast,0x0A000000,0x0F000000);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,Add,Case)},flag = {Preserved}}
	for i = 3, 0, -1 do
 			CBit = 2^i * 0x100000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end
	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,AtLeast,0x0A000000,0x0F000000);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,Add,Case)},flag = {Preserved}}
	for i = 3, 0, -1 do
 			CBit = 2^i * 0x10000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end
	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,AtLeast,0x0A000000,0x0F000000);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,Add,Case)},flag = {Preserved}}
	for i = 3, 0, -1 do
 			CBit = 2^i * 0x1000
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end
	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,AtLeast,0x0A000000,0x0F000000);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,Add,Case)},flag = {Preserved}}
	for i = 3, 0, -1 do
 			CBit = 2^i * 0x100
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end
	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,AtLeast,0x0A000000,0x0F000000);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,Add,Case)},flag = {Preserved}}
	for i = 3, 0, -1 do
 			CBit = 2^i * 0x10
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end
	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,AtLeast,0x0A000000,0x0F000000);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,Add,Case)},flag = {Preserved}}
	for i = 3, 0, -1 do
 			CBit = 2^i * 0x1
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Label(0);
					CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
				},
				actions = {
					SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,Add,2^i*0x01000000);
				},
				flag = {Preserved}
			}
	end
	Trigger {players = {ParsePlayer(PlayerID)},conditions = {Label(0);CtrigX(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,AtLeast,0x0A000000,0x0F000000);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,Add,Case)},flag = {Preserved}}
	if DigitMax == 7 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMax == 6 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMax == 5 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMax == 4 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMax == 3 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMax == 2 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMax == 1 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 end

	 if DigitMin == 2 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMin == 3 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMin == 4 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMin == 5 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMin == 6 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMin == 7 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 elseif DigitMin == 8 then
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+8,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+7,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+6,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+5,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+4,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 	table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFF00))
	 end
	 DoActionsX(PlayerID,X)
end













