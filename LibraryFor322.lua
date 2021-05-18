VIndexAlloc = 0x800
CallIndexAlloc = 0x2000
StrPtrAlloc = 0x1000
SetCallOpen = 0
DeathTableDefNumber = 1
CVariableIndexTable = {}
DeathTableDefArr = {}
PrintString_Arr = {}
BGMArr = {}
InitBGMP = 0
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
	CDoActions(Player,{AddonTrigger,X})
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
	table.insert(CVariableIndexTable,Index)
	table.insert(DeathTableDefArr,X)
	local Ret = DeathTableDefNumber
	DeathTableDefNumber = DeathTableDefNumber + 1
	return Ret
end

function CreateCCode(CCodeDefNmber) -- CtrigAsm 5.1
	if DeathTableDefArr[CCodeDefNmber][2] >= 480 or DeathTableDefArr[CCodeDefNmber][2] < 0 then
		CreateCCode_LineOverflow()
	end
	DeathTableDefArr[CCodeDefNmber][2] = DeathTableDefArr[CCodeDefNmber][2] + 1
	return Ccode(DeathTableDefArr[CCodeDefNmber][1],DeathTableDefArr[CCodeDefNmber][2]-1)
end

function CreateVar(InitVal) -- CtrigAsm 5.1
	VIndexAlloc = VIndexAlloc + 1
	if InitVal ~= nil then
	local X = {VIndexAlloc,InitVal}
		table.insert(CVariableIndexTable,X)
	else
		table.insert(CVariableIndexTable,VIndexAlloc)
	end
	return V(VIndexAlloc)
end

function CreateIndex() -- CtrigAsm 5.1
	VIndexAlloc = VIndexAlloc + 1
	table.insert(CVariableIndexTable,VIndexAlloc)
	return VIndexAlloc
end

function CreateStrPtr() -- CtrigAsm 5.1
	table.insert(CVariableIndexTable,StrPtrAlloc)
	local Ret = StrPtrAlloc
	StrPtrAlloc = StrPtrAlloc+1
	return Ret
end

function InstallCVariable() -- CtrigAsm 5.1
	for i = 1, #CVariableIndexTable do
		if type(CVariableIndexTable[i]) == "table" then
			CVariable2(AllPlayers,CVariableIndexTable[i][1],nil,nil,CVariableIndexTable[i][2])
		else
			CVariable(AllPlayers,CVariableIndexTable[i])
		end
	end
end


function CreateCText(Player,Text) -- CtrigAsm 5.1
	local X = {}
	table.insert(X,Text)
	table.insert(X,GetStrSize(0,Text))
	table.insert(X,CArray(Player,50))
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

function _0DPatchforVArr(Player,VArrName,VArrLength) -- CtrigAsm 5.1
for j=0, VArrLength do
for k=0, 3 do
TriggerX(Player,{VArrayX(VArr(VArrName,j),"Value",Exactly,0,255*(256^k))},{
SetVArrayX(VArr(VArrName,j),"Value",SetTo,(256^k)*0x0D,255*(256^k))})
end
end
end


function CreateCCodeSet(CCodeIndex,Variables)
	for i = 1, #Variables do

		for j = 1, #Variables do
			if i ~= j then
				if Variables[i] == Variables[j] then
					_G["VarName_Duplicated! VarName : "..Variables[i]]()
				end
			end
		end

		_G[Variables[i]] = CreateCCode(CCodeIndex)
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
function AddBGM(BGMTypeNum,WavFile,Value)
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
	table.insert(BGMArr,X)
end

function Install_BGMSystem(Player,MaxPlayers,Init)
if InitBGMP == 0 then
InitBGMP = ParsePlayer(Player)
else
	already_Installed_BGMSystem()
end
BGMType = CreateVar(Init)
CIf(InitBGMP,CVar(InitBGMP,BGMType[2],AtLeast,1))
CMov(InitBGMP,0x6509B0,0)
CWhile(InitBGMP,Memory(0x6509B0,AtMost,MaxPlayers))
CIfX(InitBGMP,Deaths(CurrentPlayer,AtMost,0,440))
InstallBGM_Player()
CElseX()
Trigger { -- 브금재생시 스킵
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
InstallBGM_Observer()
CElseX()
Trigger { -- 브금재생시 스킵 관전자
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
function InstallBGM_Player()
	for i = 1, #BGMArr do
		Trigger { -- 브금재생 j번
			players = {InitBGMP},
			conditions = {
				Label(0);
				CVar(InitBGMP,BGMType[2],Exactly,BGMArr[i][1]);
			},
				actions = {
				PlayWAV(BGMArr[i][2]);
				PlayWAV(BGMArr[i][2]);
				SetDeaths(CurrentPlayer,SetTo,BGMArr[i][3],440,0xFFFFFF);
				PreserveTrigger();
			},
		}
	end
end

function InstallBGM_Observer()
	for i = 1, #BGMArr do
		Trigger { -- 브금재생 j번
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
				SetDeaths(InitBGMP,SetTo,BGMArr[i][3],440,0xFFFFFF);
				PreserveTrigger();
			},
		}
	end
end


function IBGM_EPD(Player,MaxPlayer)
f_Read(Player,0x51CE8C,Dx)
CiSub(Player,Dy,_Mov(0xFFFFFFFF),Dx)
CiSub(Player,DtP,Dy,Du)
CMov(Player,Dv,DtP)
CMov(Player,0x58F500,DtP) -- MSQC val Send. 180
CMov(Player,Du,Dy)

for i = 0, MaxPlayer do
CDoActions(Player,{TSetDeathsX(i,Subtract,DtP,440,0xFFFFFF)}) -- 브금타이머
end
end