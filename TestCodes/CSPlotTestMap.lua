
Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
EXTLUA = "dir \""..Curdir.."\\MapSource\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
	if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "Loader.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\Library\\"..dir))
		InitEXTLua()
	end
end
PatchStack = {}
function UnitSizePatch(UnitID,Value,Table)
	table.insert(Table,SetMemory(0x6617C8 + (UnitID*8),SetTo,(Value)+(Value*65536)))
	table.insert(Table,SetMemory(0x6617CC + (UnitID*8),SetTo,(Value)+(Value*65536)))
end
for i = 0, 227 do
	UnitSizePatch(i,1,PatchStack)
end
function Simple_SetLoc(LocID,LeftValue,UpValue,RightValue,DownValue,Table)
	if Table == nil then
		local X = {}
		table.insert(X,SetMemory(0x58DC60+(20*LocID),SetTo,LeftValue))
		table.insert(X,SetMemory(0x58DC64+(20*LocID),SetTo,UpValue))
		table.insert(X,SetMemory(0x58DC68+(20*LocID),SetTo,RightValue))
		table.insert(X,SetMemory(0x58DC6C+(20*LocID),SetTo,DownValue))
		return X
	else
		table.insert(Table,SetMemory(0x58DC60+(20*LocID),SetTo,LeftValue))
		table.insert(Table,SetMemory(0x58DC64+(20*LocID),SetTo,UpValue))
		table.insert(Table,SetMemory(0x58DC68+(20*LocID),SetTo,RightValue))
		table.insert(Table,SetMemory(0x58DC6C+(20*LocID),SetTo,DownValue))
	end
end
for j = 0, 7 do
	for i = 0, 7 do
		Simple_SetLoc((64 + i)+(j*8),(512+(1024*i))-320,(512+(1024*j))-320,512+(1024*i)+320,512+(1024*j)+320,PatchStack)
	end
end

DoActions2(P1,PatchStack,1)

function ConvertLocation(Location)
	local TempLocID = Location
	if type(Location) == "string" then
		TempLocID = ParseLocation(Location)-1
	elseif type(Location) == "number" then
		TempLocID = Location
		Location = Location+1
	end
	return TempLocID, Location
end
--CC_LF = CS_FillPathXY(CSMakePath({896,224},{1344,704},{1120,1664}),0,32,32)
--CC_RF = CS_FillPathXY(CSMakePath({2176,224},{1728,704},{1952,1664}),0,32,32)
GC1 = CS_MoveXY(CS_RatioXY(CSMakeCircle(40,3000,0,41,1),0.5,1),48*32,96*32)
C1 = CSMakeCircle(8,60,0,441,169)
S1 = CSMakePolygon(4,45,45,13,0)
S2 = CS_MoveXY(S1,700,0)
M1 = CS_Merge(S2,C1,1,0)
SS1 = CS_KaleidoscopeX(M1,20,0,0) --- Å«¹ÙÄû--

C2 = CSMakeCircle(8,45,0,122,50)
S3 = CSMakeLineX(3,70,0,35,15)
SS2 = CS_Merge(S3,C2,1,0) --- ÀÛÀº¹ÙÄû--

MM = CS_Merge(SS1,SS2,1,0)
SS3 = CS_RemoveStack(MM,5,0) -------20°³ Åé´Ï¹ÙÄû--

function S1_Vector(X,Y) return {X+Y,X-Y} end--

WheelA = CS_Vector2D(SS3,1,"S1_Vector")--




CSPlot(CSMakeLine(4,72,45,49,1),P1,"Protoss Carrier","Location 13",nil,1,60,P1) -- À¯´Ö »ý¼º