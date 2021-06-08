Curdir=io.popen"cd":read'*l'
EXTLUA = "dir \""..Curdir.."\\Map4Source\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" then
		InitEXTLua = assert(loadfile("Map4Source\\Library\\"..dir))
		InitEXTLua()
     end
end

Curdir=io.popen"cd":read'*l'
EXTLUA = "dir \""..Curdir.."\\Map4Source\\MSF_UE\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" then
		InitEXTLua = assert(loadfile("Map4Source\\MSF_UE\\"..dir))
		InitEXTLua()
     end
end

Curdir=io.popen"cd":read'*l'
EXTLUA = "dir \""..Curdir.."\\Map4Source\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir == "main.lua" then
		InitEXTLua = assert(loadfile("Map4Source\\"..dir))
		InitEXTLua()
     end
end

