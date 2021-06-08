
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

CJump(AllPlayers,0)
Include_CtrigPlib(360,"Switch 100",1)
dofile(Curdir.."Map4Source/TestGlobal.lua")
Text1 = TestGlobal()
Text2 = CreateCText(FP,"일이삼니니가나다라마바사아자차카타파하")
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