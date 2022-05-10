VIndexAlloc = 0x800
CallIndexAlloc = 0x3000
CIndexAlloc = 0x1A00
SetCallOpen = 0
DeathTableDefNumber = 1
CVarPushArr = {}
CurCIndex = 0
CD_DefArr = {}
PrintString_Arr = {}
BGMArr = {}
VArrStackArr = {}
InitBGMP = 12
sindexAlloc = 0x700
ASM_MT={}
ASM_MT_Func={}
ASM_MT_Func.__add=_Add
ASM_MT_Func.__sub=_Sub
ASM_MT_Func.__mul=_Mul
ASM_MT_Func.__div=_Div
ASM_MT_Func.__unm=_Neg


function V(Index,Player,Next) -- metatable testfunc
	if Player == nil then
		Player = "X"
	end
	local X
	if Index >= 1 then
		if ASM_MT[Index] == nil then
			X = {Player,Index,Next,"V"}
			setmetatable(X,ASM_MT_Func)
			ASM_MT[Index] = X
		else
			X = ASM_MT[Index]
		end
	end
	return X
end

function PushErrorMsg(Message)
	return error(Message,1)
end

---@param Str? string
---@return string
function StrDesign(Str)
	return "\x07『 "..Str.." \x07』"
end
---@param Str? string
---@return string
function StrDesignX(Str)
	return "\x13\x07『 "..Str.." \x07』"
end
function RotatePlayer(Print,Players,RecoverCP)
	return CopyCpAction(Print,Players,RecoverCP)
end
function Simple_SetLoc(Location,LeftValue,UpValue,RightValue,DownValue)
	local LocID, Location = ConvertLocation(Location)
	local X = {}
	table.insert(X,SetMemory(0x58DC60+(20*LocID),SetTo,LeftValue))
	table.insert(X,SetMemory(0x58DC64+(20*LocID),SetTo,UpValue))
	table.insert(X,SetMemory(0x58DC68+(20*LocID),SetTo,RightValue))
	table.insert(X,SetMemory(0x58DC6C+(20*LocID),SetTo,DownValue))
	return X
end

function Simple_CalcLoc(Location,LeftValue,UpValue,RightValue,DownValue)
	local LocID, Location = ConvertLocation(Location)
	local X = {}
	table.insert(X,SetMemory(0x58DC60+(20*LocID),Add,LeftValue))
	table.insert(X,SetMemory(0x58DC64+(20*LocID),Add,UpValue))
	table.insert(X,SetMemory(0x58DC68+(20*LocID),Add,RightValue))
	table.insert(X,SetMemory(0x58DC6C+(20*LocID),Add,DownValue))
	return X
end

function Simple_CalcLocX(Player,Location,LeftValue,UpValue,RightValue,DownValue,PreserveFlag)
	local LocID, Location = ConvertLocation(Location)
	local X = {}
	table.insert(X,SetMemory(0x58DC60+(20*LocID),Add,LeftValue))
	table.insert(X,SetMemory(0x58DC64+(20*LocID),Add,UpValue))
	table.insert(X,SetMemory(0x58DC68+(20*LocID),Add,RightValue))
	table.insert(X,SetMemory(0x58DC6C+(20*LocID),Add,DownValue))
	DoActions(Player,X,PreserveFlag)
	return X
end

function Simple_SetLocX(Player,Location,LeftValue,UpValue,RightValue,DownValue,AddonTrigger) -- CtrigAsm 5.1
	local LocID, Location = ConvertLocation(Location)
	CDoActions(Player,{
		TSetMemory(0x58DC60+(20*LocID),SetTo,LeftValue),
		TSetMemory(0x58DC64+(20*LocID),SetTo,UpValue),
		TSetMemory(0x58DC68+(20*LocID),SetTo,RightValue),
		TSetMemory(0x58DC6C+(20*LocID),SetTo,DownValue),
		AddonTrigger
	})
end

function Simple_SetLoc2X(Player,Location,LeftValue,UpValue,RightValue,DownValue,AddonTrigger) -- CtrigAsm 5.1
	local LocID, Location = ConvertLocation(Location)
	CDoActions(Player,{
		TSetMemory(0x58DC60+(20*LocID),Add,LeftValue),
		TSetMemory(0x58DC64+(20*LocID),Add,UpValue),
		TSetMemory(0x58DC68+(20*LocID),Add,RightValue),
		TSetMemory(0x58DC6C+(20*LocID),Add,DownValue),
		AddonTrigger
	})
end

function DoActionsXI(PlayerID,Index,Actions,flag) -- CtrigAsm 5.1
	local X = {}
	if flag == nil then
		flag = {Preserved}
	else
		flag = nil
	end
	if Index == nil then
		Index = 0
	end
	Trigger {
		players = {PlayerID},
		conditions = {
			Label(Index);
		},
		actions = {
			Actions,
		},
		flag = {flag}
	}
end

function SetCallForward()
	return CallIndexAlloc
end

function SetCall(Player) -- CtrigAsm 5.1
	SetCallPlayer = Player
	Trigger {
		players = {SetCallPlayer},
		conditions = {
			Label(CallIndexAlloc);
		},
		actions = {
		},
		flag = {Preserved}
	}
	CallIndexAlloc = CallIndexAlloc + 1
	if SetCallOpen == 0 then
		SetCallOpen = 1
	else
		PushErrorMsg("SetCall_Already_Open")
	end
end

function SetCallEnd() -- CtrigAsm 5.1
	Trigger {
		players = {SetCallPlayer},
		conditions = {
			Label(CallIndexAlloc);
		},
		actions = {
			SetDeathsX(0,SetTo,0,0,0xFFFFFFFF); -- Recover Next
			SetCtrig1X("X","X",0x164,0,SetTo,0x2,0x2);
		},
		flag = {Preserved}
	}
	CallIndexAlloc = CallIndexAlloc + 1
	if SetCallOpen == 1 then
		SetCallOpen = 0
	else
		PushErrorMsg("SetCall_Not_Open")
	end
end

function CallTriggerA(Index,AddonTrigger) -- CtrigAsm 5.1
	return {SetNext("X",Index,0),SetNext(Index+1,"X",1),AddonTrigger}
end
function CallTrigger(Player,Index,AddonTrigger) -- CtrigAsm 5.1
	local X = {SetNext("X",Index,0),SetNext(Index+1,"X",1)}
	DoActionsX(Player,{AddonTrigger,X})
end

function CallTriggerX(Player,Index,Condition,AddonTrigger,Flags) -- CtrigAsm 5.1
	local Y
	if Flags == nil then Y = {Preserved} elseif Flags == "X" or Flags == 1 then Y = {} else PushErrorMsg("CallTriggerX_FlagError") end
	local X = {SetNext("X",Index,0),SetNext(Index+1,"X",1)}
	table.insert(X,SetCtrigX("X",Index+1,0x158,0,SetTo,"X","X",0x4,1,0))
	table.insert(X,SetCtrigX("X",Index+1,0x15C,0,SetTo,"X","X",0,0,1))
	table.insert(X,SetCtrig1X("X",Index+1,0x164,0,SetTo,0x0,0x2))
	TriggerX(Player,Condition,{AddonTrigger,X},Y)
end
HumanCheckOffset = 0
function Enable_HumanCheck(Offset)
	if Offset == nil or Offset == "X" then
		Offset = 0x58D740+(20*60)
	end
	HumanCheckOffset = Offset
	DoActions(AllPlayers,{FSetMemory(Offset,SetTo,0)})

	for i = 0, 7 do
		Trigger {
			players = {AllPlayers},
			conditions = {
				FMemoryX(0x57EEE8 + 36*i,Exactly,0x2,0xFF);
			},
			actions = {
				FSetMemoryX(Offset,SetTo,2^i,2^i);
			},
			flag = {Preserved}
		}
	end
end

function HumanCheck(Player,Status)
	if HumanCheckOffset == 0 then
		Need_Enable_HumanCheck()
	end
	if Player >= 8  or Player < 0 then
		HumanCheck_InputData_Error()
	end
	if Status == "X" or Status == 0 then
		Status = 0
	else
		Status = 2^Player
	end
	return FMemoryX(HumanCheckOffset,Exactly,Status,2^Player)
end
function SetNextTrigger(Index,AddonTrigger)
	local X = {SetNext("X",Index,0),SetNext(Index+1,"X",1),AddonTrigger}
	return X
end
function SetNextForward(AddonTrigger)
	local X = {SetNext("X",CallIndexAlloc,0),SetNext(CallIndexAlloc+1,"X",1),AddonTrigger}
	return X
end
function SetCallErrorCheck() -- CtrigAsm 5.1
	if SetCallOpen == 1 then
		PushErrorMsg("SetCall_Already_Open")
	end
end

function FindError()
	CAdd(FP,0x57f120,1)
end




function CreateVArray(Player,Size)
	return CreateVArr(Size,Player)
end
function CreateCArray(Player,Size)
	return CreateArr(Size,Player)
end


function CreateCText(Player,Text) -- CtrigAsm 5.1
	local X = {}
	local StrSize = GetStrSize(0,Text)
	if (StrSize)/4>601 then PushErrorMsg("StrSize_OverFlow") end
	table.insert(X,Text)
	table.insert(X,StrSize)
	table.insert(X,CreateCArray(Player,((StrSize)/4)+1))
	local Z = print_utf8A(X[3],0, Text)
	for j, k in pairs(Z) do
		table.insert(CtrigInitArr[Player+1],k)
	end
	return X
end



function print_utf8A(Array,pos, string)
    local ret = {}
    local dst = pos*4
    if type(string) == "string" then
        local str = string
        local n = 1
        if dst % 4 >= 1 then
            for i = 1, dst % 4 do str = '\x0d'..str end
        end
        local t = cp949_to_utf8(str)
        while n <= #t do
			
            ret[#ret+1] = SetMemX(Arr(Array,(dst - dst % 4 +n-1)/4),SetTo,_dw(t, n))
            n = n + 4
        end
    elseif type(string) == "number" then
        PushErrorMsg("print_utf8A_InputError")
    end
    return ret
end





function CreateCCodeSet(Variables)
	for i = 1, #Variables do

		for j = 1, #Variables do
			if i ~= j then
				if Variables[i] == Variables[j] then
					_G["VarName_Duplicated! VarName : "..Variables[i]]()
				end
			end
		end

		_G[Variables[i]] = CreateCcode()
	end
end
function CreateNCodeSet(Variables)
	for i = 1, #Variables do

		for j = 1, #Variables do
			if i ~= j then
				if Variables[i] == Variables[j] then
					_G["VarName_Duplicated! VarName : "..Variables[i]]()
				end
			end
		end

		_G[Variables[i]] = CreateNcode()
	end
end
function CreateVariableSet(Variables,Player)
	for i = 1, #Variables do
		for j = 1, #Variables do
			if i ~= j then
				if Variables[i] == Variables[j] then
					_G["VarName_Duplicated! VarName : "..Variables[i]]()
				end
			end
		end
		_G[Variables[i]] = CreateVar(Player)
	end
end
function CreateTableSet(Variables)
	local X = Variables
	for i = 1, #Variables do
		for j = 1, #Variables do
			if i ~= j then
				if Variables[i] == Variables[j] then
					_G["VarName_Duplicated! VarName : "..Variables[i]]()
				end
			end
		end
		_G[Variables[i]] = {}
	end
end

function CreateTables(vars)
	local V = {}
	for i = 1, vars do
		table.insert( V,{})
	end
	return table.unpack(V)
end
function CreateVariables(vars,Player)
	if Player == nil then Player = FP end
	return CreateVars(vars,Player)
end
function Create_VTable(Number,InitVar,Player)
	if Player == nil then Player = FP end
	local X = {}
	for i = 1, Number do
		table.insert(X,CreateVar3(Player,InitVar,nil,nil))
	end
	return X
end
function Create_CCTable(Number)
	return CreateCcodeArr(Number)
end
function Create_VArrTable(Number,Size,Player)
	if Player == nil then Player = FP end
	return CreateVArrArr(Number,Size,Player)
end

function Overflow_HP_System(Player,Cunit_HPV,HP_K,HP_P)
    CIf(Player,CVar(Player,Cunit_HPV[2],AtLeast,1))
    	CDoActions(Player,{TSetMemory(Cunit_HPV,SetTo,8000000*256)},1)
        CIf(Player,{TMemory(Cunit_HPV,AtMost,4000000*256),CVar(Player,HP_K[2],AtLeast,1)})
            CIfX(Player,{CVar(Player,HP_K[2],AtLeast,4000001)})
                CDoActions(Player,{TSetMemory(Cunit_HPV,Add,4000000*256)})
                CSub(Player,HP_K,4000000)
                if type(HP_P) == "table" then
                	CAdd(Player,HP_P,1)
            	end
                CElseIfX({CVar(Player,HP_K[2],AtMost,4000000)})
                CDoActions(Player,{TSetMemory(Cunit_HPV,Add,_Mul(HP_K,256))})
                CMov(Player,HP_K,0)
                if type(HP_P) == "table" then
                	CAdd(Player,HP_P,1)
            	end
            CIfXEnd()
        CIfEnd()
        CTrigger(Player,{TMemoryX(_Add(Cunit_HPV,17),Exactly,0,0xFF00)},{SetCVar(Player,Cunit_HPV[2],SetTo,0)},1)
    CIfEnd()
end

function Overflow_HP_SystemX(Player,Cunit_HPV,HP_K,HP_K2,HP_P)
    CIf(Player,CVar(Player,Cunit_HPV[2],AtLeast,1))
    	CDoActions(Player,{TSetMemory(Cunit_HPV,SetTo,8000000*256)},1)
        CIf(Player,{TMemory(Cunit_HPV,AtMost,4000000*256),CVar(Player,HP_K[2],AtLeast,1)})
            CIfX(Player,{CVar(Player,HP_K[2],AtLeast,4000001)})
                CDoActions(Player,{TSetMemory(Cunit_HPV,Add,4000000*256)})
                CSub(Player,HP_K,4000000)
                if type(HP_P) == "table" then
                	CAdd(Player,HP_P,1)
            	end
                CElseIfX({CVar(Player,HP_K[2],AtMost,4000000)})
                CDoActions(Player,{TSetMemory(Cunit_HPV,Add,_Mul(HP_K,256))})
                CMov(Player,HP_K,0)
                if type(HP_P) == "table" then
                	CAdd(Player,HP_P,1)
            	end
            CIfXEnd()
        CIfEnd()
        TriggerX(Player,{CVar(Player,HP_K[2],AtMost,1000000000),CVar(Player,HP_K2[2],AtLeast,1)},
        	{SetCVar(Player,HP_K[2],Add,1000000000),SetCVar(Player,HP_K2[2],Subtract,1)},{Preserved})
        TriggerX(Player,{CVar(Player,HP_K[2],AtLeast,2000000000)},
        	{SetCVar(Player,HP_K[2],Subtract,1000000000),SetCVar(Player,HP_K2[2],Add,1)},{Preserved})
        CTrigger(Player,{TMemoryX(_Add(Cunit_HPV,17),Exactly,0,0xFF00)},{SetCVar(Player,Cunit_HPV[2],SetTo,0)},1)
    CIfEnd()
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

function PlotSizeCalc(Points,SizeofPolygon)
	local X = 1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2))
	return X
end
function AddBGM(BGMTypeNum,WavFile,Value,StyleFlag)
	local X = {}
	if type(BGMTypeNum) ~= "number" then
		PushErrorMsg("BGMTypeNum_InputData_Error")
	end
	if type(WavFile) ~= "string" then
		PushErrorMsg("WavFile_InputData_Error")
	end
	if type(Value) ~= "number" then
		PushErrorMsg("Value_InputData_Error")
	end

	table.insert(X,BGMTypeNum)
	table.insert(X,WavFile)
	table.insert(X,Value)
	if StyleFlag ~= nil then
		table.insert(X,StyleFlag)
	end
	table.insert(BGMArr,X)
	return BGMTypeNum
end

function Install_BGMSystem(Player,MaxPlayers,BGMTypeV,DeathUnit,ObConFlag)
	if InitBGMP == 12 then
	InitBGMP = Player
	else
		PushErrorMsg("already_Installed_BGMSystem")
	end
	if ObConFlag ~= nil then
		ObCcode1 = CreateCcode()
		ObCcode2 = CreateCcode()

for i = 128, 131 do
	CIf(InitBGMP,{LocalPlayerID(i)})
	CIfX(InitBGMP,{Memory(0x596A44, Exactly, 65536),CD(ObCcode1,0)})
	TriggerX(InitBGMP,{CD(ObCcode2,0),CD(ObCcode1,0)},{SetCD(ObCcode2,1),SetCD(ObCcode1,1),SetCp(i),PlayWAV("staredit\\wav\\button3.wav"),DisplayText(StrDesign("\x04관전자 브금을 Off했습니다."),4),SetCp(InitBGMP)},{Preserved})
	TriggerX(InitBGMP,{CD(ObCcode2,1),CD(ObCcode1,0)},{SetCD(ObCcode2,0),SetCD(ObCcode1,1),SetCp(i),PlayWAV("staredit\\wav\\button3.wav"),DisplayText(StrDesign("\x04관전자 브금을 On했습니다."),4),SetCp(InitBGMP)},{Preserved})
	CElseIfX({Memory(0x596A44, Exactly, 65536)},SetCD(ObCcode1,1))
	CElseX(SetCD(ObCcode1,0))
	CIfXEnd()
	CIfEnd()
	end
end

if #BGMArr == 0 then
	PushErrorMsg("BGM_List_does_not_exist")
end
CIf(InitBGMP,CVar(InitBGMP,BGMTypeV[2],AtLeast,1))
CMov(InitBGMP,0x6509B0,0)
CWhile(InitBGMP,Memory(0x6509B0,AtMost,MaxPlayers))
CIfX(InitBGMP,Deaths(CurrentPlayer,AtMost,0,DeathUnit))
	for i = 1, #BGMArr do
		local X = {}
		if #BGMArr[i] == 4 then
			table.insert(X,CVar(InitBGMP,LevelT[2],AtLeast,BGMArr[i][4][1]))
			table.insert(X,CVar(InitBGMP,LevelT[2],AtMost,BGMArr[i][4][2]))
		end
		Trigger { -- 브금?????? j??
			players = {InitBGMP},
			conditions = {
				Label(0);
				CVar(InitBGMP,BGMTypeV[2],Exactly,BGMArr[i][1]);
				X;
			},
				actions = {
				PlayWAV(BGMArr[i][2]);
				PlayWAV(BGMArr[i][2]);
				SetDeathsX(CurrentPlayer,SetTo,BGMArr[i][3],DeathUnit,0xFFFFFF);
				PreserveTrigger();
			},
		}
	end
CElseX()
Trigger { -- 브금????????? ??????
	players = {InitBGMP},
		actions = {
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PreserveTrigger();
	},
}
CIfXEnd()
CAdd(InitBGMP,0x6509B0,1)
CWhileEnd()
CAdd(InitBGMP,0x6509B0,InitBGMP)
CIfX(InitBGMP,Deaths(InitBGMP,AtMost,0,DeathUnit))
	for i = 1, #BGMArr do
		local X = {}
		if #BGMArr[i] == 4 then
			table.insert(X,CVar(InitBGMP,LevelT[2],AtLeast,BGMArr[i][4][1]))
			table.insert(X,CVar(InitBGMP,LevelT[2],AtMost,BGMArr[i][4][2]))
		end

		if ObConFlag~=nil then
			Trigger { -- 브금?????? j??
				players = {InitBGMP},
				conditions = {
					Label(0);
					CVar(InitBGMP,BGMTypeV[2],Exactly,BGMArr[i][1]);
					CDeaths(InitBGMP,AtMost,0,ObCcode2);
					X;
				},
					actions = {
					RotatePlayer({
						PlayWAVX(BGMArr[i][2]),
						PlayWAVX(BGMArr[i][2])
					},{P9,P10,P11,P12},InitBGMP);
					PreserveTrigger();
				},
			}
			Trigger { -- 브금?????? j??
				players = {InitBGMP},
				conditions = {
					Label(0);
					CVar(InitBGMP,BGMTypeV[2],Exactly,BGMArr[i][1]);
					CDeaths(InitBGMP,Exactly,1,ObCcode2);
					X;
				},
					actions = {
					RotatePlayer({PlayWAVX("staredit\\wav\\BGM_Skip.ogg"),PlayWAVX("staredit\\wav\\BGM_Skip.ogg"),PlayWAVX("staredit\\wav\\BGM_Skip.ogg"),PlayWAVX("staredit\\wav\\BGM_Skip.ogg"),PlayWAVX("staredit\\wav\\BGM_Skip.ogg")},{P9,P10,P11,P12},InitBGMP);
					PreserveTrigger();
				},
			}
			Trigger { -- 브금?????? j??
				players = {InitBGMP},
				conditions = {
					Label(0);
					CVar(InitBGMP,BGMTypeV[2],Exactly,BGMArr[i][1]);
					X;
				},
					actions = {
						SetDeathsX(InitBGMP,SetTo,BGMArr[i][3],DeathUnit,0xFFFFFF);
					PreserveTrigger();
				},
			}

		else
			Trigger { -- 브금?????? j??
				players = {InitBGMP},
				conditions = {
					Label(0);
					CVar(InitBGMP,BGMTypeV[2],Exactly,BGMArr[i][1]);
					X;
				},
					actions = {
					RotatePlayer({
						PlayWAVX(BGMArr[i][2]),
						PlayWAVX(BGMArr[i][2])
					},{P9,P10,P11,P12},InitBGMP);
					SetDeathsX(InitBGMP,SetTo,BGMArr[i][3],DeathUnit,0xFFFFFF);
					PreserveTrigger();
				},
			}
		end
		

	end
CElseX()
Trigger { -- 브금????????? ?????? ????????
	players = {InitBGMP},
	conditions = {
	},
		actions = {
		RotatePlayer({PlayWAVX("staredit\\wav\\BGM_Skip.ogg"),PlayWAVX("staredit\\wav\\BGM_Skip.ogg"),PlayWAVX("staredit\\wav\\BGM_Skip.ogg"),PlayWAVX("staredit\\wav\\BGM_Skip.ogg"),PlayWAVX("staredit\\wav\\BGM_Skip.ogg")},{P9,P10,P11,P12},InitBGMP);
		PreserveTrigger();
	},
}
CIfXEnd()
DoActionsX(InitBGMP,{SetCVar(InitBGMP,BGMTypeV[2],SetTo,0)})
CIfEnd()
end


--Dx,Dy,Du,DtP,Dv = CreateVariables(5)
function IBGM_EPD(Player,MaxPlayer,Option_NT,BGMDeathsT)
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
			CMov(FP,Option_NT[1],DtP)
		CIfEnd()
		CIf(FP,{NTCond()})
			CAdd(FP,Option_NT[2],DtP,Option_NT[1])
		CIfEnd()
		else
			PushErrorMsg("OPtion_NT_InputData_Error")
		end
	end

	for j, k in pairs(BGMDeathsT) do
		for i = 0, MaxPlayer do
			CTrigger(Player,{HumanCheck(i,1)},{TSetDeathsX(i,Subtract,DtP,k,0xFFFFFF)},1) -- 브금타이머
			CTrigger(Player,{HumanCheck(i,0)},{SetDeaths(i,SetTo,0,k)},1) -- 브금타이머
		end
		CDoActions(Player,{TSetDeathsX(Player,Subtract,DtP,k,0xFFFFFF),
		SetDeathsX(Player,SetTo,0,k,0xFF000000),
		SetDeaths(8,SetTo,0,k),SetDeaths(9,SetTo,0,k),SetDeaths(10,SetTo,0,k),SetDeaths(11,SetTo,0,k)}) -- 브금타이머
	end
end

function Enable_HideErrorMessage(Player)
	for i = 0, 10 do
		if i%2 == 0 then
		Trigger {
			players = {Player},
			conditions = {
				Memory(0x640B60+0xDA*i, Exactly, 0xEABDB2EA);
				Memory(0x640B64+0xDA*i, Exactly, 0x203AA0B3);	
			},
			actions = {
				SetMemory(0x640B60+0xDA*i,SetTo,0);
				PreserveTrigger();
			}
		}
		Trigger {
			players = {Player},
			conditions = {
				Memory(0x640B60+0xDA*i, Exactly, 0x4E524157);
				Memory(0x640B64+0xDA*i, Exactly, 0x3A474E49);	
			},
			actions = {
				SetMemory(0x640B60+0xDA*i,SetTo,0);
				PreserveTrigger();
			}
		}
		else
		Trigger {
			players = {Player},
			conditions = {
				MemoryX(0x640B5E + 0xDA*i, Exactly, 0xB2EA0000,0xFFFF0000);
				Memory(0x640B62 + 0xDA*i, Exactly, 0xA0B3EABD);	
				MemoryX(0x640B66 + 0xDA*i, Exactly, 0x203A,0xFFFF);
			},
			actions = {
				SetMemory(0x640B5E + 0xDA*i,SetTo,0);
				PreserveTrigger();
			}
		}
		Trigger {
			players = {Player},
			conditions = {
				MemoryX(0x640B5E + 0xDA*i, Exactly, 0x41570000,0xFFFF0000);
				Memory(0x640B62 + 0xDA*i, Exactly, 0x4E494E52);	
				MemoryX(0x640B66 + 0xDA*i, Exactly, 0x00003A47,0xFFFF);
			},
			actions = {
				SetMemory(0x640B5E + 0xDA*i,SetTo,0);
				PreserveTrigger();
			}
		}
		end
	end
end

function def_sIndex()
	local X = sindexAlloc
	sindexAlloc = sindexAlloc + 1
	return X
end

function _0DPatchforVArr(Player,VArrName,VArrLength) -- CtrigAsm 5.1
for j=0, VArrLength do
for k=0, 3 do
TriggerX(Player,{VArrayX(VArr(VArrName,j),"Value",Exactly,0,255*(256^k))},{
SetVArrayX(VArr(VArrName,j),"Value",SetTo,(256^k)*0x0D,255*(256^k))})
end
end
end



function _0DPatchX(Player,VArrName,VArrLength) -- CtrigAsm 5.1
	CMov(Player,TempV_0D,0)
	NWhile(Player,CVar(Player,TempV_0D[2],AtMost,VArrLength-1))
	TMem(Player,TempV_0D2,VArr(VArrName,TempV_0D))
	for k=0, 3 do
		CTrigger(Player,{TMemoryX(TempV_0D2,Exactly,0,255*(256^k))},{
		TSetMemoryX(TempV_0D2,SetTo,(256^k)*0x0D,255*(256^k))
		},1)
	end
	CAdd(Player,TempV_0D,1)
	NWhileEnd()
end

function ConvertLocation(Location) -- 로케이션 인덱스 변환함수. TempLocID는 0부터 시작, Location은 1부터 시작하는 인덱스를 반환함. 문자열 입력 가능
	local TempLocID = Location
	if type(Location) == "string" then
		TempLocID = ParseLocation(Location)-1
	elseif type(Location) == "number" then
		TempLocID = Location
		Location = Location+1
	end
	return TempLocID, Location
end

function Install_TMemoryBW(PlayerID)
	local OffsetV = CreateVar(PlayerID)
	local MaskRetV = CreateVar(PlayerID)
	local BWTypeV = CreateVar(PlayerID)
	local TypeV = CreateVar(PlayerID)
	local RetV = CreateVar(PlayerID)
	local EPDRetV = CreateVar(PlayerID)
	local ValueV = CreateVar(PlayerID)
	local MaskV = CreateVar(PlayerID)
	local MaskV2 = CreateVar(PlayerID)


	Call_MemoryCalc = SetCallForward()
	SetCall(PlayerID)
		CiSub(PlayerID,OffsetV,0x58A364)
		f_iMod(PlayerID,MaskRetV,OffsetV,4)
		f_iDiv(PlayerID,OffsetV,4)
		CIf(PlayerID,{CVar(PlayerID,MaskRetV[2],AtLeast,0x80000000)})
			CNeg(PlayerID,MaskRetV)
		CIfEnd()
		CIfX(PlayerID,{CVar(PlayerID,BWTypeV[2],Exactly,1)}) -- B
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,0)},{SetCVar(PlayerID,MaskV[2],SetTo,1)},1)
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,1)},{SetCVar(PlayerID,MaskV[2],SetTo,256)},1)
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,2)},{SetCVar(PlayerID,MaskV[2],SetTo,65536)},1)
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,3)},{SetCVar(PlayerID,MaskV[2],SetTo,16777216)},1)
			f_Mul(PlayerID,ValueV,MaskV)
			CIfX(PlayerID,CVar(PlayerID,MaskV2[2],Exactly,0xFFFFFFFF))
			f_Mul(PlayerID,MaskV,255)
			CElseX()
			f_Mul(PlayerID,MaskV,MaskV2)
			CIfXEnd()
		CElseX() -- W
			
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,0)},{SetCVar(PlayerID,MaskV[2],SetTo,1)},1)
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,2)},{SetCVar(PlayerID,MaskV[2],SetTo,65536)},1)
			f_Mul(PlayerID,ValueV,MaskV)
			CIfX(PlayerID,CVar(PlayerID,MaskV2[2],Exactly,0xFFFFFFFF))
			f_Mul(PlayerID,MaskV,65535)
			CElseX()
			f_Mul(PlayerID,MaskV,MaskV2)
			CIfXEnd()
		CIfXEnd()
		CIfX(PlayerID,{CVar(PlayerID,TypeV[2],Exactly,SetTo)})
			CDoActions(PlayerID,{TSetMemoryX(OffsetV,SetTo,ValueV,MaskV)})
		CElseIfX({CVar(PlayerID,TypeV[2],Exactly,Add)})
			CDoActions(PlayerID,{TSetMemoryX(OffsetV,Add,ValueV,MaskV)})
		CElseIfX({CVar(PlayerID,TypeV[2],Exactly,Subtract)})
			CDoActions(PlayerID,{TSetMemoryX(OffsetV,Subtract,ValueV,MaskV)})
		CIfXEnd()
	SetCallEnd()
	Call_ReadCalc = SetCallForward()
	SetCall(PlayerID)
		CiSub(PlayerID,OffsetV,0x58A364)
		f_iMod(PlayerID,MaskRetV,OffsetV,4)
		f_iDiv(PlayerID,OffsetV,4)
		CIf(PlayerID,{CVar(PlayerID,MaskRetV[2],AtLeast,0x80000000)})
			CNeg(PlayerID,MaskRetV)
		CIfEnd()
		f_Read(PlayerID,OffsetV,RetV)
		CIfX(PlayerID,{CVar(PlayerID,BWTypeV[2],Exactly,1)}) -- B
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,0)},{SetCVar(PlayerID,MaskV[2],SetTo,1),SetCVar(PlayerID,MaskV2[2],SetTo,256)},1)
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,1)},{SetCVar(PlayerID,MaskV[2],SetTo,256),SetCVar(PlayerID,MaskV2[2],SetTo,65536)},1)
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,2)},{SetCVar(PlayerID,MaskV[2],SetTo,65536),SetCVar(PlayerID,MaskV2[2],SetTo,16777216)},1)
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,3)},{SetCVar(PlayerID,MaskV[2],SetTo,16777216),SetCVar(PlayerID,MaskV2[2],SetTo,0)},1)
		CElseX() -- W
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,0)},{SetCVar(PlayerID,MaskV[2],SetTo,1),SetCVar(PlayerID,MaskV2[2],SetTo,65536)},1)
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,2)},{SetCVar(PlayerID,MaskV[2],SetTo,65536),SetCVar(PlayerID,MaskV2[2],SetTo,0)},1)
		CIfXEnd()
		f_Mod(PlayerID,RetV,MaskV2)
		f_Div(PlayerID,RetV,MaskV)
		CIf(FP,CVar(PlayerID,MaskV2[2],AtLeast,1))
		CIfEnd()
	SetCallEnd()

	function Act_TSetMemoryB(Offset,Type,Value,Mask)
		if Mask == nil then Mask = 0xFFFFFFFF end
		CDoActions(PlayerID,{
			TSetCVar(PlayerID,OffsetV[2],SetTo,Offset),
			TSetCVar(PlayerID,TypeV[2],SetTo,Type),
			TSetCVar(PlayerID,ValueV[2],SetTo,Value),
			TSetCVar(PlayerID,MaskV2[2],SetTo,Mask),
			SetCVar(PlayerID,BWTypeV[2],SetTo,1),
			
		})
		CallTrigger(PlayerID,Call_MemoryCalc,{})
	end	
	function Act_TSetMemoryW(Offset,Type,Value,Mask)
		if Mask == nil then Mask = 0xFFFFFFFF end
		CDoActions(PlayerID,{
			TSetCVar(PlayerID,OffsetV[2],SetTo,Offset),
			TSetCVar(PlayerID,TypeV[2],SetTo,Type),
			TSetCVar(PlayerID,ValueV[2],SetTo,Value),
			TSetCVar(PlayerID,MaskV2[2],SetTo,Mask),
			SetCVar(PlayerID,BWTypeV[2],SetTo,0),
			
		})
		CallTrigger(PlayerID,Call_MemoryCalc,{})
	end
	function Act_BRead(Offset)
		CDoActions(PlayerID,{
			TSetCVar(PlayerID,OffsetV[2],SetTo,Offset),
			SetCVar(PlayerID,BWTypeV[2],SetTo,1),
			
		})
		CallTrigger(PlayerID,Call_ReadCalc,{})
		return RetV
	end
	function Act_WRead(Offset)
		CDoActions(PlayerID,{
			TSetCVar(PlayerID,OffsetV[2],SetTo,Offset),
			SetCVar(PlayerID,BWTypeV[2],SetTo,0),
			
		})
		CallTrigger(PlayerID,Call_ReadCalc,{})
		return RetV
	end

	
end

function Install_GetCLoc(TriggerPlayer,TempLoc,TempUnit) -- TempLoc = 안쓰거나 자주 바뀌는 로케이션, TempUnit = 안쓰는 유닛. Unused 가능 아마?
	GLocC = 1
	local TempLocID, TempLoc = ConvertLocation(TempLoc)
	local PlayerID = TriggerPlayer
	local RetX = CreateVar(TriggerPlayer)
	local RetY = CreateVar(TriggerPlayer)
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

function CreateVar3(PlayerID,Value,Offset,Type,Mask)
	CreateVarXAlloc = CreateVarXAlloc + 1
	if CreateVarXAlloc > CreateMaxVAlloc then
		PushErrorMsg("CreateVariable_IndexAllocation_Overflow")
	end
	if PlayerID == nil then
		PlayerID = AllPlayers
	end
	table.insert(CreateVarPArr,{"V2",PlayerID,Offset,Type,Value,Mask})
	return V(CreateVarXAlloc)
end

function Include_CRandNum(Player)

	TempRandRet = CreateVar(Player)
	InputMaxRand = CreateVar(Player)
	Oprnd = CreateVar(Player)
	function f_CRandNum(Max,Operand,Condition)
		if Operand == nil then Operand = 0 end
		local RandRet = TempRandRet
		CallTriggerX(Player,CRandNum,Condition,{SetCVar(Player,InputMaxRand[2],SetTo,Max),SetCVar(Player,Oprnd[2],SetTo,Operand)})
		return RandRet
	end
	CRandNum = SetCallForward()
	SetCall(Player)
	f_Rand(Player,TempRandRet)
	f_Mod(Player,TempRandRet,InputMaxRand)
	CAdd(Player,TempRandRet,Oprnd)
	SetCallEnd()

end

TempV_0D = CreateVar()
TempV_0D2 = CreateVar()

function Install_f_Sqrd(Player)
	local LoopCcode = CreateCcode()
	local DestV = CreateVar(Player)
	local SqV = CreateVar(Player)
	Call_f_Sqrd = SetCallForward()
	SetCall(Player)
	CIfX(Player,CDeaths(Player,AtLeast,2,LoopCcode))
	CWhile(Player,CDeaths(Player,AtLeast,2,LoopCcode))
		f_Mul(Player,DestV,SqV)
	CWhileEnd(SetCDeaths(Player,Subtract,1,LoopCcode))
	CElseIfX({CDeaths(Player,Exactly,0,LoopCcode)})
		CMov(Player,DestV,1)
	CIfXEnd()
	SetCallEnd()
	function f_Sqrd(Dest,Sqrd)
		CDoActions(Player,{TSetCVar(Player,DestV[2],SetTo,Dest),TSetCVar(Player,SqV[2],SetTo,Dest),TSetCDeaths(Player,SetTo,Sqrd,LoopCcode)})
		CallTrigger(Player,Call_f_Sqrd)
		return DestV
	end
end


function DoActions(PlayerID,Actions,Flags)
	if Flags == nil then
		Flags = {Preserved}
	elseif Flags == 1 then
		Flags = {}
	end
	Trigger {
		players = {PlayerID},
		actions = {
			Actions,
		},
		flag = {
			Flags,
		},
	}
end

function DoActions2(PlayerID,Actions,Flags)
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

function DoActionsX(PlayerID,Actions,Flags,Index)
	if Index == nil then
		Index = 0
	end
	if Flags == nil then
		Flags = {Preserved}
	elseif Flags == 1 then
		Flags = {}
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


function CDoActions(PlayerID,Actions,Flags,Index)
	-- Actions = PatchAct(Actions)

	STPopTrigArr(PlayerID)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID)

	if Flags == nil then
		Flags = {Preserved}
	elseif Flags == 1 then
		Flags = {}
	end

	if Index == nil or Index == "X" then
		Index = 0
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
		}
	}
end



function Include_Conv_CPosXY(Player)
	CPos,CPosDeviation,CPosX,CPosY = CreateVars(4,Player)
	Call_CPosXY = SetCallForward()
	SetCall(Player)
	CMov(Player,CPosX,CPos,0,0XFFFF,1)
	CMov(Player,CPosY,CPos,0,0XFFFF0000,1)
	f_Div(Player,CPosY,_Mov(0x10000))
	CIf(FP,CVar(FP,CPosDeviation[2],AtLeast,1))
		CAdd(FP,CPosX,CPosDeviation)
		CAdd(FP,CPosY,CPosDeviation)
	CIfEnd()
	SetCallEnd()
	function Convert_CPosXY(Value,Deviation)
		if Deviation == nil then 
			Deviation = 0
		end
		if Value ~= nil then
			CDoActions(Player,{
				TSetCVar(Player,CPos[2],SetTo,Value),SetCVar(Player,CPosDeviation[2],SetTo,Deviation),
				SetNext("X",Call_CPosXY,0),SetNext(Call_CPosXY+1,"X",1)
			})
		else
			CallTrigger(Player,Call_CPosXY)
		end
		return CPosX,CPosY
	end
end