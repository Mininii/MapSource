VIndexAlloc = 0x800
CallIndexAlloc = 0x2000
CIndexAlloc = 0x1000
SetCallOpen = 0
DeathTableDefNumber = 1
CVarPushArr = {}
CurCIndex = 0
CD_DefArr = {}
PrintString_Arr = {}
BGMArr = {}
VArrStackArr = {}
InitBGMP = 12
VoidInit = 0x590000
sindexAlloc = 0x000
sindex_FuncAlloc = 0x700

function DisplayTextX(Text,AlwaysDisplay)
	return {"DisplayText",Text,AlwaysDisplay}
end
function PlayWAVX(WAVFile)
	return {"PlayWAV",WAVFile}
end
function RotatePlayer(Print,Players,RecoverCP)
	local Y = {}
	if type(Players) == "number" then
		temp = {Players}
		Players = temp
	end
	for j, y in pairs(Players) do
		table.insert(Y,SetMemory(0x6509B0, SetTo, y))
		for k, x in pairs(Print) do
			if x[1] == "DisplayText" then
				table.insert(Y,DisplayText(x[2],x[3]))	
			elseif x[1] == "PlayWAV" then
				table.insert(Y,PlayWAV(x[2]))	
			else 
				table.insert(Y,x)
			end
		end
	end
	table.insert(Y,SetMemory(0x6509B0, SetTo, RecoverCP))
	return Y
end
function Simple_SetLoc(LocID,LeftValue,UpValue,RightValue,DownValue)
	local X = {}
	table.insert(X,SetMemory(0x58DC60+(20*LocID),SetTo,LeftValue))
	table.insert(X,SetMemory(0x58DC64+(20*LocID),SetTo,UpValue))
	table.insert(X,SetMemory(0x58DC68+(20*LocID),SetTo,RightValue))
	table.insert(X,SetMemory(0x58DC6C+(20*LocID),SetTo,DownValue))
	return X
end

function Simple_CalcLoc(LocID,LeftValue,UpValue,RightValue,DownValue)
	local X = {}
	table.insert(X,SetMemory(0x58DC60+(20*LocID),Add,LeftValue))
	table.insert(X,SetMemory(0x58DC64+(20*LocID),Add,UpValue))
	table.insert(X,SetMemory(0x58DC68+(20*LocID),Add,RightValue))
	table.insert(X,SetMemory(0x58DC6C+(20*LocID),Add,DownValue))
	return X
end

function Simple_CalcLocX(Player,LocID,LeftValue,UpValue,RightValue,DownValue,PreserveFlag)
	local X = {}
	table.insert(X,SetMemory(0x58DC60+(20*LocID),Add,LeftValue))
	table.insert(X,SetMemory(0x58DC64+(20*LocID),Add,UpValue))
	table.insert(X,SetMemory(0x58DC68+(20*LocID),Add,RightValue))
	table.insert(X,SetMemory(0x58DC6C+(20*LocID),Add,DownValue))
	DoActions(Player,X,PreserveFlag)
	return X
end

function Simple_SetLocX(Player,LocID,LeftValue,UpValue,RightValue,DownValue,AddonTrigger) -- CtrigAsm 5.1
	CDoActions(Player,{
		TSetMemory(0x58DC60+(20*LocID),SetTo,LeftValue),
		TSetMemory(0x58DC64+(20*LocID),SetTo,UpValue),
		TSetMemory(0x58DC68+(20*LocID),SetTo,RightValue),
		TSetMemory(0x58DC6C+(20*LocID),SetTo,DownValue),
		AddonTrigger
	})
end

function DoActionsXI(PlayerID,Index,Actions,flag) -- CtrigAsm 5.1
	local X = {}
	if flag == nil then
		flags = {Preserved}
	else
		flags = nil
	end
	if Index == nil then
		Index = 0
	end
	Trigger {
		players = {ParsePlayer(PlayerID)},
		conditions = {
			Label(Index);
		},
		actions = {
			Actions,
		},
		flag = {flags}
	}
end

function SetCallForward()
	return CallIndexAlloc
end

function SetCall(Player) -- CtrigAsm 5.1
	SetCallPlayer = Player
	Trigger {
		players = {ParsePlayer(SetCallPlayer)},
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
		SetCall_Already_Open()
	end
end

function SetCallEnd() -- CtrigAsm 5.1
	Trigger {
		players = {ParsePlayer(SetCallPlayer)},
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
		SetCall_Not_Open()
	end
end

function CallTrigger(Player,Index,AddonTrigger) -- CtrigAsm 5.1
	local X = {SetNext("X",Index,0),SetNext(Index+1,"X",1)}
	DoActionsX(Player,{AddonTrigger,X})
end

function CallTriggerX(Player,Index,Condition,AddonTrigger) -- CtrigAsm 5.1
	local X = {SetNext("X",Index,0),SetNext(Index+1,"X",1)}
	table.insert(X,SetCtrigX("X",Index+1,0x158,0,SetTo,"X","X",0x4,1,0))
	table.insert(X,SetCtrigX("X",Index+1,0x15C,0,SetTo,"X","X",0,0,1))
	table.insert(X,SetCtrig1X("X",Index+1,0x164,0,SetTo,0x0,0x2))
	TriggerX(Player,Condition,{AddonTrigger,X},{Preserved})
end

function SetCallErrorCheck() -- CtrigAsm 5.1
	if SetCallOpen == 1 then
		SetCall_Already_Open()
	end
end

function FindError()
	CAdd(FP,0x57f120,1)
end

function DefineDeathTable(Index) -- CtrigAsm 5.1
	local X = {Index,0}
	table.insert(CVarPushArr,Index)
	table.insert(CD_DefArr,X)
	local Ret = DeathTableDefNumber
	DeathTableDefNumber = DeathTableDefNumber + 1
	return Ret
end

function CreateCCode() -- CtrigAsm 5.1
	if CurCIndex == 0 then
		CurCIndex = DefineDeathTable(CIndexAlloc)
		CIndexAlloc = CIndexAlloc + 1
	end
	if CD_DefArr[CurCIndex][2] >= 480 or CD_DefArr[CurCIndex][2] < 0 then
		CurCIndex = DefineDeathTable(CIndexAlloc)
		CIndexAlloc = CIndexAlloc + 1
	end
	CD_DefArr[CurCIndex][2] = CD_DefArr[CurCIndex][2] + 1
	return Ccode(CD_DefArr[CurCIndex][1],CD_DefArr[CurCIndex][2]-1)
end

function CreateVar(InitVal) -- CtrigAsm 5.1
	VIndexAlloc = VIndexAlloc + 1
	if InitVal ~= nil then
		local X = {VIndexAlloc,InitVal}
		table.insert(CVarPushArr,X)
	else
		table.insert(CVarPushArr,VIndexAlloc)
	end
	return V(VIndexAlloc)
end

function CreateIndex() -- CtrigAsm 5.1
	VIndexAlloc = VIndexAlloc + 1
	table.insert(CVarPushArr,VIndexAlloc)
	return VIndexAlloc
end

function CVariable3(Player,Index,Offset,Type,Player2,Index2,Address2,EPD2,Next2,Mask)
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
					SetCtrig2X(Offset,Type,Player2,Index2,Address2,EPD2,Next2,Mask); -- Input Value Ctirg Offset 
					Disabled(SetDeathsX(0,SetTo,0,0,0xFFFFFFFF)); -- Recover Next
				},
				flag = {Preserved}
			}
end

function InstallCVariable() -- CtrigAsm 5.1
	if #CVarPushArr >= 1 then
		for i = 1, #CVarPushArr do
			if type(CVarPushArr[i]) == "table" then
				if type(CVarPushArr[i][2]) == "number" then
					CVariable2(AllPlayers,CVarPushArr[i][1],nil,nil,CVarPushArr[i][2])
				elseif type(CVarPushArr[i][2]) == "table" then
					CVariable3(AllPlayers,CVarPushArr[i][1],nil,nil,CVarPushArr[i][2][1],CVarPushArr[i][2][2],CVarPushArr[i][2][3],CVarPushArr[i][2][4],CVarPushArr[i][2][5])
				else
					InstallCVariable_InputData_Error()
				end
			else
				CVariable(AllPlayers,CVarPushArr[i])
			end
		end
	end
end


function CArray2(PlayerID,Size,Index)
	if bit32.band(Size, 0xFFFFFFFF) >= 4096*602 or Size == 0 then
		Array_Size_Overflow()
	end

	local TNum = Size/602
	if Size%602 ~= 0 then
		TNum = TNum + 1
	end
	local Arrindex = Index

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
end

function CVArray2(PlayerID,Size,Index)
	if bit32.band(Size, 0xFFFFFFFF) >= 4096 or Size == 0 then
		VArray_Size_Overflow()
	end

	local VArrindex = Index

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

	
end


function CreateVarray(Player,Size)
	local X = {}
	local Ret = FuncAlloc
	table.insert(X,"VArr")
	table.insert(X,Player)
	table.insert(X,Size)
	table.insert(X,Ret)
	table.insert(VArrStackArr,X)
	FuncAlloc = FuncAlloc + 1
	return {"X",Ret,0,"V"}
end
function CreateCarray(Player,Size)
	local X = {}
	local Ret = FuncAlloc
	table.insert(X,"Arr")
	table.insert(X,Player)
	table.insert(X,Size)
	table.insert(X,Ret)
	table.insert(VArrStackArr,X)
	FuncAlloc = FuncAlloc + 1
	return {"X",Ret,0,0}
end
function InstallCVArrStack()
	if #VArrStackArr >= 1 then
		for j, k in pairs(VArrStackArr) do
			if k[1] == "VArr" then
				CVArray2(k[2],k[3],k[4])
			end
			if k[1] == "Arr" then
				CArray2(k[2],k[3],k[4])
			end
		end
	end
end
function Install_AllObject()
	local ObjectSpace = def_sIndex()
	CJump(FP,ObjectSpace) -- ±âÅ¸ init ÁöÁ¤°ø°£
	InstallCVariable()
	InstallCVArrStack()
	CJumpEnd(FP,ObjectSpace)
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

function CreateCText(Player,Text) -- CtrigAsm 5.1
	local X = {}
	local StrSize = GetStrSize(0,Text)
	table.insert(X,Text)
	table.insert(X,StrSize)
	table.insert(X,CreateCarray(Player,StrSize))
	local Y = {}
	table.insert(Y,X[3])
	table.insert(Y,X[1])
	table.insert(PrintString_Arr,Y)
	return X
end


function Print_All_CTextString(Player) -- CtrigAsm 5.1
	for i = 1, #PrintString_Arr do
		Print_String(Player,_TMem(Arr(PrintString_Arr[i][1],0)),PrintString_Arr[i][2],0)
	end
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

		_G[Variables[i]] = CreateCCode()
	end
end
function CreateVariableSet(Variables)
	for i = 1, #Variables do
		for j = 1, #Variables do
			if i ~= j then
				if Variables[i] == Variables[j] then
					_G["VarName_Duplicated! VarName : "..Variables[i]]()
				end
			end
		end
		_G[Variables[i]] = CreateVar()
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
function CreateCCodes(vars)
	local V = {}
	for i = 1, vars do
		table.insert( V,CreateCCode())
	end
	return table.unpack(V)
end
function CreateVariables(vars)
	local V = {}
	for i = 1, vars do
		table.insert( V,CreateVar())
	end
	return table.unpack(V)
end
function Create_VTable(Number,InitVar)
	local X = {}
	for i = 1, Number do
		table.insert(X,CreateVar(InitVar))
	end
	return X
end
function Create_CCTable(Number)
	local X = {}
	for i = 1, Number do
		table.insert(X,CreateCCode())
	end
	return X
end
function Create_VArrTable(Number,Size)
	local X = {}
	for i = 1, Number do
		table.insert(X,CreateVarray(FP,Size))
	end
	return X
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
            CifXEnd()
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
            CifXEnd()
        CIfEnd()
        TriggerX(Player,{CVar(Player,HP_K[2],AtMost,1000000000),CVar(Player,HP_K2[2],AtLeast,1)},
        	{SetCVar(Player,HP_K[2],Add,1000000000),SetCVar(Player,HP_K2[2],Subtract,1)},{Preserved})
        TriggerX(Player,{CVar(Player,HP_K[2],AtLeast,2000000000)},
        	{SetCVar(Player,HP_K[2],Subtract,1000000000),SetCVar(Player,HP_K2[2],Add,1)},{Preserved})
        CTrigger(Player,{TMemoryX(_Add(Cunit_HPV,17),Exactly,0,0xFF00)},{SetCVar(Player,Cunit_HPV[2],SetTo,0)},1)
    CIfEnd()
end


function PlotSizeCalc(Points,SizeofPolygon)
	local X = 1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2))
	return X
end
function AddBGM(BGMTypeNum,WavFile,Value,StyleFlag)
	local X = {}
	if type(BGMTypeNum) ~= "number" then
		BGMTypeNum_InputData_Error()
	end
	if type(WavFile) ~= "string" then
		WavFile_InputData_Error()
	end
	if type(Value) ~= "number" then
		Value_InputData_Error()
	end

	table.insert(X,BGMTypeNum)
	table.insert(X,WavFile)
	table.insert(X,Value)
	if StyleFlag ~= nil then
		table.insert(X,StyleFlag)
	end
	table.insert(BGMArr,X)
end

function Install_BGMSystem(Player,MaxPlayers,BGMType)
if InitBGMP == 12 then
InitBGMP = ParsePlayer(Player)
else
	already_Installed_BGMSystem()
end
if #BGMArr == 0 then
	BGM_List_does_not_exist()
end
CIf(InitBGMP,CVar(InitBGMP,BGMType[2],AtLeast,1))
CMov(InitBGMP,0x6509B0,0)
CWhile(InitBGMP,Memory(0x6509B0,AtMost,MaxPlayers))
CIfX(InitBGMP,Deaths(CurrentPlayer,AtMost,0,440))
	for i = 1, #BGMArr do
		local X = nil
		if #BGMArr[i] == 4 then
			X = Deaths(CurrentPlayer,Exactly,BGMArr[i][4],444)
		end
		Trigger { -- ë¸Œê¸ˆ?ž¬?ƒ jë²?
			players = {InitBGMP},
			conditions = {
				Label(0);
				CVar(InitBGMP,BGMType[2],Exactly,BGMArr[i][1]);
				X;
			},
				actions = {
				PlayWAV(BGMArr[i][2]);
				PlayWAV(BGMArr[i][2]);
				SetDeathsX(CurrentPlayer,SetTo,BGMArr[i][3],440,0xFFFFFF);
				PreserveTrigger();
			},
		}
	end
CElseX()
Trigger { -- ë¸Œê¸ˆ?ž¬?ƒ?‹œ ?Š¤?‚µ
	players = {InitBGMP},
		actions = {
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
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
CIfX(InitBGMP,Deaths(InitBGMP,AtMost,0,440))
	for i = 1, #BGMArr do
		Trigger { -- ë¸Œê¸ˆ?ž¬?ƒ jë²?
			players = {InitBGMP},
			conditions = {
				Label(0);
				CVar(InitBGMP,BGMType[2],Exactly,BGMArr[i][1]);
				
			},
				actions = {
				RotatePlayer({
					PlayWAVX(BGMArr[i][2]),
					PlayWAVX(BGMArr[i][2])
				},{128,129,130,131},InitBGMP);
				SetDeathsX(InitBGMP,SetTo,BGMArr[i][3],440,0xFFFFFF);
				PreserveTrigger();
			},
		}
	end
CElseX()
Trigger { -- ë¸Œê¸ˆ?ž¬?ƒ?‹œ ?Š¤?‚µ ê´?? „?ž
	players = {InitBGMP},
	conditions = {
	},
		actions = {
		RotatePlayer({PlayWAVX("staredit\\wav\\BGM_Skip.ogg"),PlayWAVX("staredit\\wav\\BGM_Skip.ogg"),PlayWAVX("staredit\\wav\\BGM_Skip.ogg"),PlayWAVX("staredit\\wav\\BGM_Skip.ogg"),PlayWAVX("staredit\\wav\\BGM_Skip.ogg")},{128,129,130,131},InitBGMP);
		PreserveTrigger();
	},
}
CIfXEnd()
DoActionsX(InitBGMP,{SetCVar(InitBGMP,BGMType[2],SetTo,0)})
CIfEnd()
end


function IBGM_EPD(Player,MaxPlayer)
	f_Read(Player,0x51CE8C,Dx)
	CiSub(Player,Dy,_Mov(0xFFFFFFFF),Dx)
	CiSub(Player,DtP,Dy,Du)
	CMov(Player,Dv,DtP) 
	CMov(Player,0x58F500,DtP) -- MSQC val Send. 180
	CMov(Player,Du,Dy)
	for i = 0, MaxPlayer do
	CDoActions(Player,{TSetDeathsX(i,Subtract,DtP,440,0xFFFFFF)}) -- ë¸Œê¸ˆ????´ë¨?
	end
end

function VoidAlloc(Size)--1EPD(4bite)
	local X = EPD(VoidInit)
	VoidInit = VoidInit + (Size*4)
	if VoidInit >= 0x5967E0 then
		VoidSize_OverFlow()
	end
	return X
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

function CreateJungal(UIDTable,CUTable,Player)
	if type(CUTable) == "table" then
		local X = CUTable
	else
		CUTable_InputData_Error()
	end

	if type(UIDTable) == "table" then
		local Y = CUTable
	else
		CUTable_InputData_Error()
	end

	if #UIDTable % #CUTable ~= 0 then
		CUTable_InputData_Error()
	end
	if #CUTable % #UIDTable ~= 0 then
		CUTable_InputData_Error()
	end
	local A = #UIDTable
	local B = #CUTable
	if A <= B then
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



TempV_0D = CreateVar()
TempV_0D2 = CreateVar()
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