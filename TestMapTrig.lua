
Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
EXTLUA = "dir \""..Curdir.."\\Map4Source\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "Loader.lua" then
		InitEXTLua = assert(loadfile(Curdir.."Map4Source\\Library\\"..dir))
		InitEXTLua()
     end
end
FP = P2
--↓ Tep에 그대로 붙여넣기 -----------------------------------------------------------------
SetForces({P1},{P2},{},{},{P1,P2})
SetFixedPlayer(P1)
StartCtrig()
--↓ 이곳에 예제를 붙여넣기 -----------------------------------------------------------------

function GetStrArr(cp949flag,String,Null)
	if type(String) == "number" then
		String = DecodeString(String)
	end
	local Size = 0
	local Arr = {}
	if Null == nil then
		Null = 0
	else
		Null = 1
	end
	if cp949flag == "X" or cp949flag == nil or cp949flag == 0 then -- utf8 Size
		if Null == 0 then
			Arr = cp949_to_utf8(String)
			table.remove(Arr,#Arr)
		else
			Arr = cp949_to_utf8(String)
		end
	else -- cp949 Size
		for i = 1, #String do
			table.insert(Arr,string.byte(String,i))
		end
		if Null ~= 0 then
			table.insert(Arr,0)
		end
	end
	return Arr
end




function PushValueMsg(...)
	local Message = "\n"
	local arg = table.pack(...)
	for k = 1, arg.n do
		if type(arg[k]) == "string" then
			Message = Message..arg[k].."\n"
		elseif type(arg[k]) == "table" then
			if type(arg[k][1]) == "table" then
				for i = 1, #arg[k][1] do
					if type(arg[k][1][i]) == "string" then
						Message = Message..arg[k][1][i].."  "
					elseif type(arg[k][1][i]) == "number" then
						if arg[k][2] == "X" or arg[k][2] == "x" then
							Message = Message..string.format("%X",arg[k][1][i]).."  "
						elseif arg[k][2] == "F" or arg[k][2] == "f"  then
							Message = Message..string.format("%f",arg[k][1][i]).."  "
						else
							Message = Message..string.format("%d",math.floor(arg[k][1][i])).."  "
						end
					elseif arg[k][1][i] == nil then
						Message = Message.."nil".."  "
					elseif type(arg[k][1][i]) == "table" then
						Message = Message.."table".."  "
					else
						PushValueMsg_InputError()
					end
				end
				Message = Message.."\n"
			elseif arg[k][2] == "X" or arg[k][2] == "x" then
				Message = Message..string.format("%X",arg[k][1]).."\n"
			elseif arg[k][2] == "F" or arg[k][2] == "f"  then
				Message = Message..string.format("%f",arg[k][1]).."\n"
			else
				Message = Message..string.format("%d",math.floor(arg[k][1])).."\n"
			end
		elseif type(arg[k]) == "number" then
			Message = Message..string.format("%d",math.floor(arg[k])).."\n"
		elseif arg[k] == nil then
			Message = Message.."nil".."\n"
		else
			PushValueMsg_InputError()
		end 
	end
	_G["\n"..Message.."\n"]() 
end


CJump(AllPlayers,0)
Include_CtrigPlib(360,"Switch 100",1)
dofile(Curdir.."Map4Source/TestGlobal.lua")
Text1 = TestGlobal()
TText2 = "가나다라"
Text2 = CreateCText(FP,TText2)
PushValueMsg({GetStrArr(0,TText2),"X"})
CJumpEnd(AllPlayers,0)
CIfOnce(FP)
Print_All_CTextString(FP)
CIfEnd()
_0D = string.rep( "\x0d", 200 )
Str1 = "1".._0D
Str2 = "2".._0D
StrPtr1 = CreateVar()
StrPtr2 = CreateVar()
f_GetStrXptr(FP,StrPtr1,Str1)
f_GetStrXptr(FP,StrPtr2,Str2)
f_MemCpy(FP,StrPtr1,_TMem(Arr(Text1[3],0),"X","X",1),Text1[2])
f_MemCpy(FP,StrPtr2,_TMem(Arr(Text2[3],0),"X","X",1),Text2[2])
DoActions(FP,{RotatePlayer({DisplayTextX(Str1,4)},{0,128,129,130,131},FP)})
DoActions(FP,{RotatePlayer({DisplayTextX(Str2,4)},{0,128,129,130,131},FP)})

CJump(AllPlayers,1)
InstallCVariable()
CJumpEnd(AllPlayers,1)
--↑ 이곳에 예제를 붙여넣기 -----------------------------------------------------------------
EUDTurbo(P1)
EndCtrig()
ErrorCheck()
--↑ Tep에 그대로 붙여넣기 -----------------------------------------------------------------