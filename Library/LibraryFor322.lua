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




function CreateVarray(Player,Size)
	return CreateVArr(Size,Player)
end
function CreateCarray(Player,Size)
	return CreateArr(Size,Player)
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
function CreateNCodeSet(Variables)
	for i = 1, #Variables do

		for j = 1, #Variables do
			if i ~= j then
				if Variables[i] == Variables[j] then
					_G["VarName_Duplicated! VarName : "..Variables[i]]()
				end
			end
		end

		_G[Variables[i]] = CreateNCode()
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
		table.insert(X,CreateVar2(InitVar,Player,nil,nil))
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
	return BGMTypeNum
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
		local X = {}
		if #BGMArr[i] == 4 then
			table.insert(X,CVar(FP,LevelT[2],AtLeast,BGMArr[i][4][1]))
			table.insert(X,CVar(FP,LevelT[2],AtMost,BGMArr[i][4][2]))
		end
		Trigger { -- 브금?????? j??
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
Trigger { -- 브금????????? ??????
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
		local X = {}
		if #BGMArr[i] == 4 then
			table.insert(X,CVar(FP,LevelT[2],AtLeast,BGMArr[i][4][1]))
			table.insert(X,CVar(FP,LevelT[2],AtMost,BGMArr[i][4][2]))
		end
		Trigger { -- 브금?????? j??
			players = {InitBGMP},
			conditions = {
				Label(0);
				CVar(InitBGMP,BGMType[2],Exactly,BGMArr[i][1]);
				X;
			},
				actions = {
				RotatePlayer({
					PlayWAVX(BGMArr[i][2]),
					PlayWAVX(BGMArr[i][2])
				},{P9,P10,P11,P12},InitBGMP);
				SetDeathsX(InitBGMP,SetTo,BGMArr[i][3],440,0xFFFFFF);
				PreserveTrigger();
			},
		}
	end
CElseX()
Trigger { -- 브금????????? ?????? ????????
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


--Dx,Dy,Du,DtP,Dv = CreateVariables(5)
function IBGM_EPD(Player,MaxPlayer)
	f_Read(Player,0x51CE8C,Dx)
	CiSub(Player,Dy,_Mov(0xFFFFFFFF),Dx)
	CiSub(Player,DtP,Dy,Du)
	CMov(Player,Dv,DtP) 
	CMov(Player,0x58F500,DtP) -- MSQC val Send. 180
	CMov(Player,Du,Dy)
	for i = 0, MaxPlayer do
	CDoActions(Player,{TSetDeathsX(i,Subtract,DtP,440,0xFFFFFF)}) -- 브금????????
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
	elseif Type(Location) == "number" then
		TempLocID = Location
		Location = Location+1
	end
	return TempLocID, Location
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

TempV_0D = CreateVar()
TempV_0D2 = CreateVar()