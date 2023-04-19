-- EXTLua Unlimited Loader for Tep v2.0 Made by Ninfia

-- Curdir="scmdraft 설치경로(\를\\로 바꿔야함)"
--dofile(Curdir.."/Loader.lua")<- Tep v2.0 맨위에 입력후 사용
__StringArray = {} __UPUSCheckArray = {}
__VoidCondArr = {} -- 20bytes
__VoidActArr = {} -- 32bytes
local Strchar = string.char
local b32band = bit32.band
local b32rshift = bit32.rshift
local tconcat = table.concat
CurTrigCnt = 0
CurTrigTotal = 0
function __InitTrigger()
	__TRIGChkptr:write("TRIG\0\0\0\0") -- Header

	local VC = ""
	for i = 1, 16 do
		VC = VC .. "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
		table.insert(__VoidCondArr,VC)
	end

	local VA = ""
	for i = 1, 64 do
		VA = VA .. "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
		table.insert(__VoidActArr,VA)
	end

	for i = 1, 64 do
		table.insert(__UPUSCheckArray,0)
	end
end

local TI=1
local TRIGStr = {}
local function bwrite(byte)
	TRIGStr[TI] = Strchar(byte)
	TI=TI+1
end
local function wwrite(word)
	TRIGStr[TI] = Strchar(b32band(word,0xFF),b32rshift(b32band(word,0xFF00),8))
	TI=TI+1
end
local function dwwrite(dword)
	TRIGStr[TI] = Strchar(b32band(dword,0xFF),b32rshift(b32band(dword,0xFF00),8),b32rshift(b32band(dword,0xFF0000),16),b32rshift(b32band(dword,0xFF000000),24))
	TI=TI+1
end
function Trigger(args)
	TI=1
	TRIGStr = {}

	local CCount = 16 
	if args.conditions then
		args.conditions = FlattenList(args.conditions)
		CCount = 16-#args.conditions
		for k, v in pairs(args.conditions) do
			dwwrite(v[1])
			dwwrite(v[2])
			dwwrite(v[3])
			wwrite(v[4])
			bwrite(v[5])
			bwrite(v[6])
			bwrite(v[7])
			if v["disabled"] == true then v[8] = bit32.bor(v[8],0x2) end
			if v[8] >= 0x80 then
				bwrite(b32band(v[8],0x7F))
				TRIGStr[TI] = "SC"
				TI=TI+1
			else
				bwrite(v[8])
				TRIGStr[TI] = "\0\0"
				TI=TI+1
			end
		end
	end
	if CCount > 0 then
		TRIGStr[TI] = __VoidCondArr[CCount]
		TI=TI+1
	end

	local ACount = 64
	if args.actions then
		args.actions = FlattenList(args.actions)
		ACount = 64-#args.actions
		for k, v in pairs(args.actions) do
			dwwrite(v[1])
			dwwrite(v[2])
			dwwrite(v[3])
			dwwrite(v[4])
			dwwrite(v[5])
			dwwrite(v[6])
			wwrite(v[7])
			bwrite(v[8])
			bwrite(v[9])
			if v["disabled"] == true then v[10] = bit32.bor(v[10],0x2) end
			if v[10] >= 0x80 then
				bwrite(b32band(v[10],0x7F))
				TRIGStr[TI] = "\0SC"
				TI=TI+1
			else
				bwrite(v[10])
				TRIGStr[TI] = "\0\0\0"
				TI=TI+1
			end
		end
	end
	if ACount > 0 then
		TRIGStr[TI] = __VoidActArr[ACount]
		TI=TI+1
	end

	if args.flag then
		args.flag = FlattenList(args.flag)
		local Preserved_Check, Disabled_Check = 0, 0
		for k, v in pairs(args.flag) do
			if v == Preserved then
				Preserved_Check = 1
			elseif v == Disabled then
				Disabled_Check = 1
			end
		end
		if Preserved_Check == 1 and Disabled_Check == 1 then
			TRIGStr[TI] = "\x0C\0\0\0"
			TI=TI+1
		elseif Preserved_Check == 0 and Disabled_Check == 1 then
			TRIGStr[TI] = "\x08\0\0\0"
			TI=TI+1
		elseif Preserved_Check == 1 and Disabled_Check == 0 then
			TRIGStr[TI] = "\x04\0\0\0"
			TI=TI+1
		else
			TRIGStr[TI] = "\0\0\0\0"
			TI=TI+1
		end
	else
		TRIGStr[TI] = "\0\0\0\0"
		TI=TI+1
	end

	if args.players then
		args.players = FlattenList(args.players)
		local VP = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} -- P1~P12 "13~17" All F1~F4 
		for k, v in pairs(args.players) do
			if type(v) == "number" then
				VP[v+1] = 1
			elseif v == AllPlayers then
				VP[18] = 1
			elseif v == Force1 then
				VP[19] = 1
			elseif v == Force2 then
				VP[20] = 1
			elseif v == Force3 then
				VP[21] = 1
			elseif v == Force4 then
				VP[22] = 1
			end
		end

		for i = 1, 17 do
			if VP[i] == 1 then
				TRIGStr[TI] = "\x01"
				TI=TI+1
			else
				TRIGStr[TI] = "\0"
				TI=TI+1
			end
		end
		--TRIGStr[TI] = "\0\0\0\0\0"
		--TI=TI+1
		for i = 18, 22 do
			if VP[i] == 1 then
				TRIGStr[TI] = "\x01"
				TI=TI+1
			else
				TRIGStr[TI] = "\0"
				TI=TI+1
			end
		end
		TRIGStr[TI] = "\0\0\0\0\0\0"
		TI=TI+1
		local TrigStr2 = tconcat(TRIGStr)
		assert(#TrigStr2==0x960, "TRIG Size Not Correct. Current Size : "..#TrigStr2)
		__TRIGChkptr:write(TrigStr2)
	end
	
	args.callerLine = debug.getinfo(2).currentline
	CurTrigCnt = CurTrigCnt + 1
	CurTrigTotal = CurTrigTotal + 1 
end

function __Trigger(args)
	if args.players then
		args.players = FlattenList(args.players)
	end

	if args.conditions then
		args.conditions = FlattenList(args.conditions)
	end

	if args.actions then
		args.actions = FlattenList(args.actions)
	end

	if args.flag then
		args.flag = FlattenList(args.flag)
	end

	__internal__AddTrigger(args)
end

function Transmission(Unit, Where, WAVName, TimeModifier, Time, Text, AlwaysDisplay)
	if AlwaysDisplay == nil then
		AlwaysDisplay = 4
	end

	Unit = ParseUnit(Unit)
	Where = ParseLocation(Where)
	WAVName = ParseString(WAVName)
	TimeModifier = ParseModifier(TimeModifier)
	Text = ParseString(Text)

	table.insert(__StringArray,WAVName)
	table.insert(__StringArray,Text)

	return Action(Where, Text, WAVName, 0, 0, Time, Unit, 7, TimeModifier, AlwaysDisplay)
end

function PlayWAV(WAVName)
	WAVName = ParseString(WAVName)

	table.insert(__StringArray,WAVName)

	return Action(0, 0, WAVName, 0, 0, 0, 0, 8, 0, 4)
end

function DisplayText(Text, AlwaysDisplay)
	if AlwaysDisplay == nil then AlwaysDisplay = 4 end
	Text = ParseString(Text)

	table.insert(__StringArray,Text)

	return Action(0, Text, 0, 0, 0, 0, 0, 9, 0, AlwaysDisplay)
end

function SetMissionObjectives(Text)
	Text = ParseString(Text)

	table.insert(__StringArray,Text)

	return Action(0, Text, 0, 0, 0, 0, 0, 12, 0, 4)
end

function LeaderBoardControl(Unit, Label)
	Unit = ParseUnit(Unit)
	Label = ParseString(Label)

	table.insert(__StringArray,Label)

	return Action(0, Label, 0, 0, 0, 0, Unit, 17, 0, 20)
end

function LeaderBoardControlAt(Unit, Location, Label)
	Unit = ParseUnit(Unit)
	Location = ParseLocation(Location)
	Label = ParseString(Label)

	table.insert(__StringArray,Label)

	return Action(Location, Label, 0, 0, 0, 0, Unit, 18, 0, 20)
end

function LeaderBoardResources(ResourceType, Label)
	ResourceType = ParseResource(ResourceType)
	Label = ParseString(Label)

	table.insert(__StringArray,Label)

	return Action(0, Label, 0, 0, 0, 0, ResourceType, 19, 0, 4)
end

function LeaderBoardKills(Unit, Label)
	Unit = ParseUnit(Unit)
	Label = ParseString(Label)

	table.insert(__StringArray,Label)

	return Action(0, Label, 0, 0, 0, 0, Unit, 20, 0, 20)
end


function LeaderBoardScore(ScoreType, Label)
	ScoreType = ParseScore(ScoreType)
	Label = ParseString(Label)

	table.insert(__StringArray,Label)

	return Action(0, Label, 0, 0, 0, 0, ScoreType, 21, 0, 4)
end

function LeaderBoardGoalControl(Goal, Unit, Label)
	Unit = ParseUnit(Unit)
	Label = ParseString(Label)

	table.insert(__StringArray,Label)

	return Action(0, Label, 0, 0, 0, Goal, Unit, 33, 0, 20)
end

function LeaderBoardGoalControlAt(Goal, Unit, Location, Label)
	Unit = ParseUnit(Unit)
	Location = ParseLocation(Location)
	Label = ParseString(Label)

	table.insert(__StringArray,Label)

	return Action(Location, Label, 0, 0, 0, Goal, Unit, 34, 0, 20)
end

function LeaderBoardGoalResources(Goal, ResourceType, Label)
	ResourceType = ParseResource(ResourceType)
	Label = ParseString(Label)

	table.insert(__StringArray,Label)

	return Action(0, Label, 0, 0, 0, Goal, ResourceType, 35, 0, 4)
end

function LeaderBoardGoalKills(Goal, Unit, Label)
	Unit = ParseUnit(Unit)
	Label = ParseString(Label)

	table.insert(__StringArray,Label)

	return Action(0, Label, 0, 0, 0, Goal, Unit, 36, 0, 20)
end

function LeaderBoardGoalScore(Goal, ScoreType, Label)
	ScoreType = ParseScore(ScoreType)
	Label = ParseString(Label)

	table.insert(__StringArray,Label)

	return Action(0, Label, 0, 0, 0, Goal, ScoreType, 37, 0, 4)
end

function SetNextScenario(ScenarioName)
	ScenarioName = ParseString(ScenarioName)

	table.insert(__StringArray,ScenarioName)

	return Action(0, ScenarioName, 0, 0, 0, 0, 0, 41, 0, 4)
end

function Comment(Text)
	Text = ParseString(Text)

	table.insert(__StringArray,Text)

	return Action(0, Text, 0, 0, 0, 0, 0, 47, 0, 4)
end

function CreateUnitWithProperties(Count, Unit, Where, Player, Properties)
	Unit = ParseUnit(Unit)
	Where = ParseLocation(Where)
	Player = ParsePlayer(Player)
	Properties = ParseProperty(Properties)

	__UPUSCheckArray[Properties] = 1

	return Action(Where, 0, 0, 0, Player, Properties, Unit, 11, Count, 28)
end

function __Comment(Text)
	Text = ParseString(Text)
	return Action(0, Text, 0, 0, 0, 0, 0, 47, 0, 4)
end

function __DoActions2(PlayerID,Actions,Flags)
	local k = 1
	local Size = #Actions

	if Flags == nil then
		Flags = {disabled}
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
			__Trigger {
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
			__Trigger {
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
function __PopStringArray()
	TI=1
	TRIGStr = {}
	dwwrite(__TRIGChkptr:seek("end")-8)
	__TRIGChkptr:seek("set",4)
	local TrigStr2 = tconcat(TRIGStr)
	__TRIGChkptr:write(TrigStr2)

	local ActArr = {}
	for k, v in pairs(__StringArray) do
		table.insert(ActArr,__Comment(v))
	end
	for k, v in pairs(__UPUSCheckArray) do
		if v == 1 then
			table.insert(ActArr,Action(0, 0, 0, 0, 0, k, 0, 11, 0, 28))
		end
	end
	__DoActions2(12,ActArr)
end

function StartSTRCtrig()
    if BatMode ~= 0 then
        local Batptr = io.open(Mapdir..".bat", "w")
        if BatMode == 1 then
	        Batptr:write("STRCtrigAssembler.exe \""..Mapdir..".scx\"")
	    else 
	    	Batptr:write("STRCtrigAssembler_nopause.exe \""..Mapdir..".scx\"")
	    end
        io.close(Batptr)

        __Trigger {
            players = {AllPlayers},
            conditions = {
                Disabled(Condition(0, 0, 0, 0, 10, 253, 0, 2));
            },
            flag = {preserved},
        }
    end
end

function EndSTRCtrig()
    if BatMode ~= 0 then
        __Trigger { 
            players = {AllPlayers},
            conditions = {
                Disabled(Condition(0, 0, 0, 0, 10, 252, 0, 2));
            },
            flag = {preserved},
        }
    end
end

__InitTrigger()

function __LoadLuaFiles(Path)
    for dir in io.popen("dir \""..Path.."\" /b"):lines() do
        if dir:match "%.[Ll][Uu][Aa]$" and (dir ~= "Loader2X.lua" and dir ~= "LoaderX.lua" and dir ~= "Loader2.lua" and dir ~= "Loader.lua") then
            InitEXTLua = assert(loadfile(Path..dir))
            InitEXTLua()
        elseif (dir ~= "Loader2X.lua" and dir ~= "LoaderX.lua" and dir ~= "Loader2.lua" and dir ~= "Loader.lua") then
            __LoadLuaFiles(Path..dir.."\\")
        end
    end
end


function __LoadLuaFilesX(Path)
    for dir in io.popen("dir \""..Path.."\" /b"):lines() do
        if dir:match "%.[Ll][Uu][Aa]$" and not(dir:match "[Mm][Aa][Ii][Nn].[Ll][Uu][Aa]") then
            InitSUBLua = assert(loadfile(Path..dir))
            InitSUBLua()
        elseif not(dir:match "[Mm][Aa][Ii][Nn].[Ll][Uu][Aa]") then
            __LoadLuaFilesX(Path..dir.."\\")
        end
    end
end


--↑ 외부루아 불러오기----------------------------------------------------------------------------------------------------------------------