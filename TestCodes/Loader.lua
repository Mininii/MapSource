

Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
EXTLUA = "dir \""..Curdir.."\\Map4Source\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "Loader.lua" then
		InitEXTLua = assert(loadfile(Curdir.."Map4Source\\Library\\"..dir))
		InitEXTLua()
     end
end
EXTLUA = "dir \""..Curdir.."\\Map4Source\\MSF_UE\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "Loader.lua" then
		InitEXTLua = assert(loadfile(Curdir.."Map4Source\\MSF_UE\\"..dir))
		InitEXTLua()
     end
end
EXTLUA = "dir \""..Curdir.."\\Map4Source\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir == "main.lua" then
		InitEXTLua = assert(loadfile(Curdir.."Map4Source\\"..dir))
		InitEXTLua()
     end
end