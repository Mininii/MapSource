--[[ ===========================================================================
     MapSource 공통 부트스트랩

     PC 마다 다른 경로를 여기 한 곳에서만 관리한다.  각 맵의 main.lua 는
     맨 위의 고정된 부트스트랩 블록으로 이 파일을 찾아 부르기만 하고,
     그 블록은 어느 PC 에서도 고칠 필요가 없다.

     예전 방식(각 main.lua 상단의 "-- to DeskTop : Curdir=..." 주석을 PC 마다
     손으로 갈아 끼우는 것)은 파일이 11개라 PC 를 옮길 때마다 11번 고쳐야 했고,
     리눅스 헤드리스(tepc)에서는 아예 풀어 줄 GUI 가 없어 컴파일이 멈췄다.

     제공하는 것:

       Curdir       MapSource 를 담고 있는 디렉터리 (구분자로 끝난다)
       MS_Root      Curdir .. "MapSource" .. MS_Sep
       MS_IsPosix   리눅스 헤드리스면 true
       MS_Sep       "/" 또는 "\"
       MS_LoadDir   디렉터리의 .lua 를 순서대로 로드
       MS_ListLua   로드는 하지 않고 이름만

     경로를 못 찾을 때 (새 PC, 특이한 위치):

       그 PC 의 환경변수 MAPSOURCE_CURDIR 에 MapSource 의 부모 디렉터리를 넣는다.
       PC 당 한 번 설정하면 11개 맵과 리눅스/Windows 양쪽이 전부 그것을 본다.
       소스는 한 줄도 안 고친다.

     MapSource/local.lua 가 있으면 마지막에 실행된다 (git 에 안 올라간다).
     PyDir 처럼 이 PC 에서만 쓰는 값을 거기 둘 수 있다.
     ======================================================================== ]]

MS_IsPosix = (package.config:sub(1, 1) == "/")
MS_Sep     = MS_IsPosix and "/" or "\\"

-- basescript 가 _G 에 __index 를 걸어 "정의되지 않은 전역을 읽는 것" 자체를
-- 에러로 만든다.  그냥 `X == nil` 로 쓰면 그 자리에서 죽으므로 rawget 을 쓴다.
-- 같은 metatable 의 __newindex 가 키를 소문자로 눕히므로 소문자로 찾아야 한다.
local function global(name) return rawget(_G, name:lower()) end

local function exists(path)
	local f = io.open(path, "r")
	if f then f:close() return true end
	return false
end

-- 후보 c 아래에 MapSource 가 실제로 있는지.  디렉터리가 아니라 이 파일 자신을
-- 찾는다 — 리눅스의 io.open 은 디렉터리도 열어 주기 때문에 파일로 확인해야 한다.
local function isroot(c)
	if not c or c == "" then return false end
	if c:sub(-1) ~= "/" and c:sub(-1) ~= "\\" then c = c .. MS_Sep end
	return exists(c .. "MapSource" .. MS_Sep .. "Bootstrap.lua") and c or false
end

local function candidates()
	local list = {}
	local function add(c) if type(c) == "string" and c ~= "" then list[#list + 1] = c end end

	-- 1. 명시적 지정이 언제나 이긴다.
	add(os.getenv("MAPSOURCE_CURDIR"))
	-- 2. 이미 누가 정해 뒀으면 (맵 안의 트리거 스크립트, 예전 방식) 존중한다.
	add(global("Curdir"))
	-- 3. 홈 디렉터리의 흔한 자리.
	local home = os.getenv("USERPROFILE") or os.getenv("HOME")
	if home then
		add(home .. MS_Sep .. "Documents")
		add(home .. MS_Sep .. "Desktop")
		add(home .. MS_Sep .. "OneDrive" .. MS_Sep .. "Documents")
		add(home)
	end
	-- 4. 작업 디렉터리와 그 위쪽.  ScmDraft2 옆에 MapSource 를 두는 PC 가 여기서 걸린다.
	local p = io.popen(MS_IsPosix and "pwd" or "cd")
	if p then
		local cwd = p:read("*l")
		p:close()
		while cwd and cwd ~= "" do
			add(cwd)
			cwd = cwd:match("^(.*)[/\\][^/\\]+$")
		end
	end

	return list
end

do
	local found
	for _, c in ipairs(candidates()) do
		found = isroot(c)
		if found then break end
	end
	if not found then
		error("MapSource 를 찾지 못했다.  이 PC 의 환경변수 MAPSOURCE_CURDIR 에 "
		   .. "MapSource 의 부모 디렉터리를 넣을 것.")
	end
	Curdir  = found
	MS_Root = found .. "MapSource" .. MS_Sep
end

--[[ 디렉터리의 .lua 를 나열한다.  로드 순서 = 실행 순서라 정렬이 곧 의미다.

     Windows `dir /b` 와 리눅스 `ls` 는 정렬 규칙이 다르다.  실측:

       Library/  dir /b : CSMakeSpiral.lua 가 CS_Addon.lua 보다 앞
                 ls     : 뒤바뀜

     즉 Windows 는 (1) 대소문자를 무시하고 (2) '_' 를 글자보다 뒤로 보낸다.
     셸 출력 순서를 그대로 믿으면 같은 소스가 OS 마다 다른 맵을 낸다.
     그래서 POSIX 에서만 직접 정렬해 dir /b 순서를 재현한다.  Windows 경로는
     예전 그대로 두어(정렬 안 함) 현재 산출물이 한 바이트도 바뀌지 않게 한다.

     io.popen 은 셸로 직행하므로 tepc 의 --wrap=fopen 경로 정규화를 안 거친다.
     역슬래시를 직접 눕혀야 하는 이유다.                                     ]]
function MS_ListLua(path, skip)
	path = path:gsub("[/\\]+$", "")
	if MS_IsPosix then path = path:gsub("\\", "/") end

	local cmd = MS_IsPosix and ("ls -1 \"" .. path .. "\"")
	                        or  ("dir \"" .. path .. "\" /b")
	local names, p = {}, assert(io.popen(cmd))
	for name in p:lines() do
		if name:match "%.[Ll][Uu][Aa]$" and not (skip and skip[name]) then
			names[#names + 1] = name
		end
	end
	p:close()

	if MS_IsPosix then
		-- dir /b 흉내: 소문자로 접고 '_' 를 0x7F 로 올려 뒤로 민다.
		local function key(s) return (s:lower():gsub("_", "\127")) end
		table.sort(names, function(a, b)
			local ka, kb = key(a), key(b)
			if ka ~= kb then return ka < kb end
			return a < b
		end)
	end
	return names
end

-- skip 은 파일 이름 집합이다.  예: MS_LoadDir(dir, {["main.lua"] = true})
function MS_LoadDir(path, skip)
	local base = path:gsub("[/\\]+$", "") .. MS_Sep
	for _, name in ipairs(MS_ListLua(path, skip)) do
		InitEXTLua = assert(loadfile(base .. name))
		InitEXTLua()
	end
end

-- 헤드리스에서 --cflag 1(loaderscript)로 컴파일하면 EndCtrig 이 부르는
-- __CheckDirSetting__ 이 맵 디렉터리가 설정돼 있기를 요구한다.  GUI 에서는
-- 각 맵의 __MapDirSetting 주석을 풀어 쓰던 자리다.  Windows GUI 경로는
-- 건드리지 않으려고 POSIX 에서만, 그리고 아직 안 잡혀 있을 때만 부른다.
if MS_IsPosix then
	__MapDirSetting(os.getenv("MAPSOURCE_MAPDIR") or "C:\\euddraft0.9.2.0")
end

-- 이 PC 에서만 쓰는 값 (PyDir 등).  git 에 안 올라간다.
if exists(MS_Root .. "local.lua") then dofile(MS_Root .. "local.lua") end
