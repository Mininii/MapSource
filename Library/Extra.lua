function NGetThisptr(PlayerID,Bag,Dest) -- return 1st Data Addr, Dest = Offset/V/Mem
    local Box = {}
    if type(Dest) == "number" then
        table.insert(Box,SetCtrig1X(Bag[6][1],Bag[6][2],0x158,Bag[6][3],SetTo,EPD(Dest)))
    elseif Dest[4] == "V" then
        table.insert(Box,SetCtrigX(Bag[6][1],Bag[6][2],0x158,Bag[6][3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]))
    else
        table.insert(Box,SetCtrigX(Bag[6][1],Bag[6][2],0x158,Bag[6][3],SetTo,Dest[1],Dest[2],Dest[3],1,Dest[4]))
    end

	Trigger {
		players = {PlayerID},
		conditions = {
			Label(0);
		},
		actions = {
            Box;
            SetCtrig1X(Bag[6][1],Bag[6][2],0x180,Bag[6][3],SetTo,0x000000,0xFF0000); -- disable 2nd Act
			SetCtrigX("X","X",0x4,0,SetTo,Bag[6][1],Bag[6][2],0x0,0,Bag[6][3]); -- call Iptr1
			SetCtrigX(Bag[6][1],Bag[6][2],0x4,Bag[6][3],SetTo,"X","X",0x0,0,1);
		},
		flag = {Preserved}
	}

    Trigger {
		players = {PlayerID},
		conditions = {
			Label(0);
		},
		actions = {
			SetCtrig1X(Bag[6][1],Bag[6][2],0x180,Bag[6][3],SetTo,0x2D0000,0xFF0000); -- recover 2nd Act
		},
		flag = {Preserved}
	}
end

function NGetThisidx(PlayerID,Bag,Thisptr,Dest) -- return this's idx in NBagLoop, Dest = Offset/V/Mem, Thisptr = V
	f_Div(FP,Dest,_Sub(Thisptr,_TMem(Mem(Bag[1][1],Bag[1][2],0x15C,1,1),nil,nil,0)),604)
end

function NGetLastptr(PlayerID,Bag,Dest) -- return Last Data Addr, Dest = Offset/V/Mem
    local Box = {}
    if type(Dest) == "number" then
        table.insert(Box,SetCtrig1X(Bag[2][1],Bag[2][2],0x158,Bag[2][3],SetTo,EPD(Dest)))
    elseif Dest[4] == "V" then
        table.insert(Box,SetCtrigX(Bag[2][1],Bag[2][2],0x158,Bag[2][3],SetTo,Dest[1],Dest[2],0x15C,1,Dest[3]))
    else
        table.insert(Box,SetCtrigX(Bag[2][1],Bag[2][2],0x158,Bag[2][3],SetTo,Dest[1],Dest[2],Dest[3],1,Dest[4]))
    end

	Trigger {
		players = {PlayerID},
		conditions = {
			Label(0);
		},
		actions = {
            Box;
            SetCtrig1X(Bag[2][1],Bag[2][2],0x180,Bag[2][3],SetTo,0x000000,0xFF0000); -- disable 2nd Act
			SetCtrigX("X","X",0x4,0,SetTo,Bag[2][1],Bag[2][2],0x0,0,Bag[2][3]); -- call Nptr1
			SetCtrigX(Bag[2][1],Bag[2][2],0x4,Bag[2][3],SetTo,"X","X",0x0,0,1);
		},
		flag = {Preserved}
	}

    Trigger {
		players = {PlayerID},
		conditions = {
			Label(0);
		},
		actions = {
			SetCtrig1X(Bag[2][1],Bag[2][2],0x180,Bag[2][3],SetTo,0x2D0000,0xFF0000); -- recover 2nd Act
		},
		flag = {Preserved}
	}
end

function NGetLastidx(PlayerID,Bag,Lastptr,Dest) -- return Last idx in NBagLoop, Dest = Offset/V/Mem, Lastptr = V
	f_Div(FP,Dest,_Sub(Lastptr,_TMem(Mem(Bag[1][1],Bag[1][2],0x15C,1,1),nil,nil,0)),604)
end

function _PTR(Source) -- V << V
	return _Add(_lShift2(Source,2),0x58A364)
end

function TSetCp(Number)
	return TSetMemory(0x6509B0,SetTo,Number)
end

function AddCp(Number)
	return SetMemory(0x6509B0,Add,Number)
end

function TAddCp(Number)
	return TSetMemory(0x6509B0,Add,Number)
end

function TLocalPlayerID(Player,Type)
	if Type == nil then
		Type = Exactly
	end
	if Player == "Ob1" then
		Player = 128
	elseif Player == "Ob2" then
		Player = 129
	elseif Player == "Ob3" then
		Player = 130
	elseif Player == "Ob4" then
		Player = 131
	end
	return TMemory(0x512684,Type,Player)
end

function MemoryBX(Offset,Type,Value,Mask)
	local ret = bit32.band(Offset, 0xFFFFFFFF)%4
	if ret == 0 then
		Mask = Mask * 0x1
	elseif ret == 1 then
		Mask = Mask * 0x100
		Value = Value * 0x100
	elseif ret == 2 then
		Mask = Mask * 0x10000
		Value = Value * 0x10000
	elseif ret == 3 then
		Mask = Mask * 0x1000000
		Value = Value * 0x1000000
	end
	return FMemoryX(Offset-ret,Type,Value,Mask)
end

function SetMemoryBX(Offset,Type,Value,Mask)
	local ret = bit32.band(Offset, 0xFFFFFFFF)%4
	if ret == 0 then
		Mask = Mask * 0x1
	elseif ret == 1 then
		Mask = Mask * 0x100
		Value = Value * 0x100
	elseif ret == 2 then
		Mask = Mask * 0x10000
		Value = Value * 0x10000
	elseif ret == 3 then
		Mask = Mask * 0x1000000
		Value = Value * 0x1000000
	end
	return FSetMemoryX(Offset-ret,Type,Value,Mask)
end

function MemoryWX(Offset,Type,Value,Mask)
	local ret = bit32.band(Offset, 0xFFFFFFFF)%4
	if ret == 0 then
		Mask = Mask * 0x1
	elseif ret == 2 then
		Mask = Mask * 0x10000
		Value = Value * 0x10000
	else
		MemoryWX_InputData_Error()
	end
	return FMemoryX(Offset-ret,Type,Value,Mask)
end

function SetMemoryWX(Offset,Type,Value,Mask)
	local ret = bit32.band(Offset, 0xFFFFFFFF)%4
	if ret == 0 then
		Mask = Mask * 0x1
	elseif ret == 2 then
		Mask = Mask * 0x10000
		Value = Value * 0x10000
	else
		SetMemoryWX_InputData_Error()
	end
	return FSetMemoryX(Offset-ret,Type,Value,Mask)
end

function NReset(PlayerID,Header) -- Deque 추가
	if Header[4] == "Stack" then
		local Stack = Header
		local Number = Stack[1][5]
		local Box0 = {SetCtrigX(Stack[3][1],Stack[3][2],0x15C,Stack[3][3],SetTo,Stack[1][1],Stack[1][2],0x0,0,0),
						SetCtrigX(Stack[3][1],Stack[3][2],0x178,Stack[3][3],SetTo,Stack[1][1],Stack[1][2],0x4,1,0)}
		for i = 1, Number do
			table.insert(Box0,SetCtrigX(Stack[2][1],Stack[2][2],0x15C+0x40*(i-1),Stack[2][3],SetTo,Stack[1][1],Stack[1][2],0x15C+0x40*(i-1),1,0))
			table.insert(Box0,SetCtrigX(Stack[2][1],Stack[2][2],0x178+0x40*(i-1),Stack[2][3],SetTo,Stack[1][1],Stack[1][2],0x15C+0x40*(i-1),1,0))
			table.insert(Box0,SetCtrigX(Stack[3][1],Stack[3][2],0x198+0x20*(i-1),Stack[3][3],SetTo,Stack[1][1],Stack[1][2],0x158+0x40*(i-1),1,0))
		end
		DoActions2X(PlayerID,Box0)
	elseif Header[4] == "Queue" then
		local Queue = Header
		local Number = Queue[1][5]
		local Box0 = {SetCtrig1X(Queue[2][1],Queue[2][2],0x30,Queue[2][3],SetTo,0),
						SetCtrig1X(Queue[3][1],Queue[3][2],0x30,Queue[3][3],SetTo,0),
						SetCtrigX(Queue[3][1],Queue[3][2],0x15C,Queue[3][3],SetTo,Queue[1][1],Queue[1][2],0x0,0,0),
						SetCtrigX(Queue[3][1],Queue[3][2],0x178,Queue[3][3],SetTo,Queue[1][1],Queue[1][2],0x4,1,0)}
		for i = 1, Number do
			table.insert(Box0,SetCtrigX(Queue[2][1],Queue[2][2],0x15C+0x40*(i-1),Queue[2][3],SetTo,Queue[1][1],Queue[1][2],0x15C+0x40*(i-1),1,0))
			table.insert(Box0,SetCtrigX(Queue[2][1],Queue[2][2],0x178+0x40*(i-1),Queue[2][3],SetTo,Queue[1][1],Queue[1][2],0x15C+0x40*(i-1),1,0))
			table.insert(Box0,SetCtrigX(Queue[3][1],Queue[3][2],0x198+0x20*(i-1),Queue[3][3],SetTo,Queue[1][1],Queue[1][2],0x158+0x40*(i-1),1,0))
		end
		DoActions2X(PlayerID,Box0)
	elseif Header[4] == "Bag" then
		local Bag = Header
		local Number = Bag[1][5]
		local Box0 = {SetCtrig1X(Bag[2][1],Bag[2][2],0x30,Bag[2][3],SetTo,0),
						SetCtrigX(Bag[3][1],Bag[3][2],0x15C,Bag[3][3],SetTo,Bag[1][1],Bag[1][2],0x0,0,0),
						SetCtrigX(Bag[3][1],Bag[3][2],0x178,Bag[3][3],SetTo,Bag[1][1],Bag[1][2],0x4,1,0)}
		for i = 1, Number do
			table.insert(Box0,SetCtrigX(Bag[2][1],Bag[2][2],0x15C+0x40*(i-1),Bag[2][3],SetTo,Bag[1][1],Bag[1][2],0x15C+0x40*(i-1),1,0))
			table.insert(Box0,SetCtrigX(Bag[2][1],Bag[2][2],0x178+0x40*(i-1),Bag[2][3],SetTo,Bag[1][1],Bag[1][2],0x15C+0x40*(i-1),1,0))
			table.insert(Box0,SetCtrigX(Bag[3][1],Bag[3][2],0x198+0x20*(i-1),Bag[3][3],SetTo,Bag[1][1],Bag[1][2],0x158+0x40*(i-1),1,0))
		end
		DoActions2X(PlayerID,Box0)
	elseif Header[4] == "Deque" then
		local Deque = Header
		local Number = Deque[1][5]
		local Box0 = {
						SetCtrig1X(Deque[2][1],Deque[2][2],0x30,Deque[2][3],SetTo,0),
						SetCtrig1X(Deque[3][1],Deque[3][2],0x30,Deque[3][3],SetTo,0),
						SetCtrigX(Deque[3][1],Deque[3][2],0x15C,Deque[3][3],SetTo,Deque[1][1],Deque[1][2],0x0,0,0),
						SetCtrigX(Deque[3][1],Deque[3][2],0x178,Deque[3][3],SetTo,Deque[1][1],Deque[1][2],0x4,1,0),
						SetCtrig1X(Deque[5][1],Deque[5][2],0x30,Deque[5][3],SetTo,0),
						SetCtrig1X(Deque[6][1],Deque[6][2],0x30,Deque[6][3],SetTo,0),
						SetCtrigX(Deque[6][1],Deque[6][2],0x15C,Deque[6][3],SetTo,Deque[1][1],Deque[1][2],0x0,0,0),
						SetCtrigX(Deque[6][1],Deque[6][2],0x178,Deque[6][3],SetTo,Deque[1][1],Deque[1][2],0x4,1,0)
					}
		for i = 1, Number do
			table.insert(Box0,SetCtrigX(Deque[2][1],Deque[2][2],0x15C+0x40*(i-1),Deque[2][3],SetTo,Deque[1][1],Deque[1][2],0x15C+0x40*(i-1),1,0))
			table.insert(Box0,SetCtrigX(Deque[2][1],Deque[2][2],0x178+0x40*(i-1),Deque[2][3],SetTo,Deque[1][1],Deque[1][2],0x15C+0x40*(i-1),1,0))
			table.insert(Box0,SetCtrigX(Deque[3][1],Deque[3][2],0x198+0x20*(i-1),Deque[3][3],SetTo,Deque[1][1],Deque[1][2],0x158+0x40*(i-1),1,0))
			table.insert(Box0,SetCtrigX(Deque[5][1],Deque[5][2],0x15C+0x40*(i-1),Deque[5][3],SetTo,Deque[1][1],Deque[1][2],0x15C+0x40*(i-1),1,0))
			table.insert(Box0,SetCtrigX(Deque[5][1],Deque[5][2],0x178+0x40*(i-1),Deque[5][3],SetTo,Deque[1][1],Deque[1][2],0x15C+0x40*(i-1),1,0))
			table.insert(Box0,SetCtrigX(Deque[6][1],Deque[6][2],0x198+0x20*(i-1),Deque[6][3],SetTo,Deque[1][1],Deque[1][2],0x158+0x40*(i-1),1,0))
		end
		DoActions2X(PlayerID,Box0)
	else
		NReset_InputData_Error()
	end
end

function NJumpX(PlayerID,sIndex,Conditions,Actions,UnPack) -- bug fixed
	if UnPack == 1 then
		if Conditions ~= nil then
		for k, v in pairs(Conditions) do
			local Temp = CunPack(v)
			Conditions[k] = Temp
		end
	end
		if Actions ~= nil then
		for k, v in pairs(Actions) do
			local Temp = CunPack(v)
			Actions[k] = Temp
		end
	end
	end
	Conditions = __FlattenCCond(Conditions)
	Actions = __FlattenCAct(Actions)

	STPopTrigArr(PlayerID)
	_TPopCondArr(PlayerID)
	ORPopCondArr(PlayerID)
	TTPopTrigArr(PlayerID)
	Conditions = PopCondArr(Conditions)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,4) -- ActPushLine : 1 -> 4
	Trigger {
		players = {PlayerID},
		conditions = {
			Label(0);
			Conditions,
		},
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",sIndex+JumpEndAlloc,0x0,0,0);
			SetCtrigX("X",sIndex+JumpEndAlloc,0x158,0,SetTo,"X","X",0x4,1,0);
			SetCtrigX("X",sIndex+JumpEndAlloc,0x15C,0,SetTo,"X","X",0x0,0,1);
			SetCtrig1X("X",sIndex+JumpEndAlloc,0x2C,0,SetTo,0x0200,0x0200);
			Actions,
	   		PreserveTrigger();
		},
	}
	table.insert(NJumpArr,sIndex)
end

function FindSDLocal(PlayerID,Location,Output,Preserve)
	local UnitId = 202
	if type(Location) == "table" then
		UnitId = Location[2]
		Location = Location[1]
	end

	local Box = {}
    local Box2 = {}
    if type(Output) == "number" then
    	table.insert(Box,SetMemory(Output,SetTo,0))
    	table.insert(Box2,SetMemory(Output,SetTo,1))
    elseif Output[4] == "V" then
    	table.insert(Box,SetCtrig1X(Output[1],Output[2],0x15C,Output[3],SetTo,0))
    	table.insert(Box2,SetCtrig1X(Output[1],Output[2],0x15C,Output[3],SetTo,1))
    else
    	table.insert(Box,SetCtrig1X(Output[1],Output[2],Output[3],Output[4],SetTo,0))
    	table.insert(Box2,SetCtrig1X(Output[1],Output[2],Output[3],Output[4],SetTo,1))
    end
    if Preserve == 0 then
    	CIfOnce(PlayerID)
    end
    f_Read(PlayerID,0x62848C,V(NRet[5])) -- 화면 x좌표
    f_Read(PlayerID,0x6284A8,V(NRet[6])) -- 화면 y좌표
	f_Read(PlayerID,0x512684,V(NRet[7]))

    CDoActions(PlayerID,{
    SetLoc(Location,0,SetTo,0);
    SetLoc(Location,4,SetTo,0);
    SetLoc(Location,8,SetTo,0);
    SetLoc(Location,12,SetTo,0);
    TSetCp(V(NRet[7]));
    TMoveLocation(Location, UnitId, V(NRet[7]), "Anywhere"), -- 로케이션 크기는 0,0
    CenterView(Location),
    Box,
    })
    
    f_Read(PlayerID,_Loc(Location,0),V(NRet[1])) -- 로케이션의 x좌표
    f_Read(PlayerID,0x62848C,V(NRet[2])) -- 화면의 x좌표
    f_Read(PlayerID,_Loc(Location,4),V(NRet[3])) -- 로케이션의 y좌표
    f_Read(PlayerID,0x6284A8,V(NRet[4])) -- 화면의 y좌표
    
    CTrigger(PlayerID,{TCVar("X",NRet[1],Exactly,Vi(NRet[2],320))},Box2,{Preserved}) -- 로케이션과 화면의 좌표 차이가 320이면

    CAdd(PlayerID,V(NRet[5]),V(NRet[1]))
    CSub(PlayerID,V(NRet[5]),V(NRet[2]))
    CAdd(PlayerID,V(NRet[6]),V(NRet[3]))
    CSub(PlayerID,V(NRet[6]),V(NRet[4]))

    CDoActions(PlayerID,{
    TSetLoc(Location,0,SetTo,V(NRet[5]));
    TSetLoc(Location,4,SetTo,V(NRet[6]));
    TSetLoc(Location,8,SetTo,V(NRet[5]));
    TSetLoc(Location,12,SetTo,V(NRet[6]));
    TSetCp(V(NRet[7]));
    CenterView(Location),
    })

    RecoverCp(PlayerID)
    if Preserve == 0 then
    	CIfEnd()
    end

    -- 센터뷰 화면좌표로 복구
end

function iStrColorFillX(ColorCode,String)
	ColorCode = string.char(ColorCode)
	local Str = ""
    local ret = {}
	for i = 1, #String do
		table.insert(ret,string.byte(String,i))
	end

	local i = 1
    while true do
		local v = ret[i]
		if v == 0x0 then
            Str = Str..string.char(v)
			break
		elseif (v>=0x20 and v<=0x7F) or (v>=0x9 and v<=0xD) or (v>=0x12 and v<=0x13) then -- 1byte
			if i == 1 then
				Str = Str..ColorCode..string.char(v)
			else
				local u = ret[i-1]
				if (u >= 0x1 and u <= 0x8) or (u >= 0xE and u <= 0x11) or (u >= 0x14 and u <= 0x1F) then -- ColorCode
					Str = Str..string.char(v)
				else
					Str = Str..ColorCode..string.char(v)
				end
			end
			i = i+1
		elseif v >= 0xE0 then -- 3byte
			local w = ret[i+1]
			local x = ret[i+2]
			if i == 1 then
				Str = Str..ColorCode..string.char(v)..string.char(w)..string.char(x)
			else
				local u = ret[i-1]
				if (u >= 0x1 and u <= 0x8) or (u >= 0xE and u <= 0x11) or (u >= 0x14 and u <= 0x1F) then -- ColorCode
					Str = Str..string.char(v)..string.char(w)..string.char(x)
				else
					Str = Str..ColorCode..string.char(v)..string.char(w)..string.char(x)
				end
			end
			i = i+3
		elseif v >= 0x80 then -- 2byte
			local w = ret[i+1]
			if i == 1 then
				Str = Str..ColorCode..string.char(v)..string.char(w)
			else
				local u = ret[i-1]
				if (u >= 0x1 and u <= 0x8) or (u >= 0xE and u <= 0x11) or (u >= 0x14 and u <= 0x1F) then -- ColorCode
					Str = Str..string.char(v)..string.char(w)
				else
					Str = Str..ColorCode..string.char(v)..string.char(w)
				end
			end
			i = i+2
		else -- Colorcode
			Str = Str..string.char(v)
			i = i+1
		end
		if i > #ret then break end
	end

	return Str
end

function MakeString(String)
    local Str = ""
    for k, v in pairs(String) do
        Str = Str..v
    end
    return Str
end

function check_utf8X_Add(line, offset, string)
    local ret = {}
    local dst = 0x640B60 + line * 218 + offset
    if type(string) == "string" then
        local str = string
        local n = 1
        if dst % 4 >= 1 then
            for i = 1, dst % 4 do str = '\0'..str end
        end
        local t 
        if TEP30Flag == 1 then
			t = {}
			str:gsub(".",function(c) table.insert(t,string.byte(c)) end)
			table.insert(t,0)
		else
			t = cp949_to_utf8(str)
		end
        while n <= #t do
			local val = _dw(t, n)
			local Mask = 0
			if val%0x100 > 1 then 
				Mask = Mask + 0xFF
			end
			if (val/0x100)%0x100 > 1 then
				Mask = Mask + 0xFF00
			end
			if (val/0x10000)%0x100 > 1 then
				Mask = Mask + 0xFF0000
			end
			if (val/0x1000000)%0x100 > 1 then
				Mask = Mask + 0xFF000000
			end
			if Mask > 1 then
				ret[#ret+1] = MemoryX(dst - dst % 4 +n-1, Exactly, val, Mask)
			end
            n = n + 4
        end
    elseif type(string) == "number" then
		local Mask = 0
		if string%0x100 > 1 then 
			Mask = Mask + 0xFF
		end
		if (string/0x100)%0x100 > 1 then
			Mask = Mask + 0xFF00
		end
		if (string/0x10000)%0x100 > 1 then
			Mask = Mask + 0xFF0000
		end
		if (string/0x1000000)%0x100 > 1 then
			Mask = Mask + 0xFF000000
		end
		if Mask > 1 then
			ret[#ret+1] = MemoryX(dst - dst % 4, Exactly, string, Mask)
		end
    end
    return ret
end

function isObserverPlayer()
	return Memory(0x512684, AtLeast, 128);
end

function isNotObserverPlayer()
	return Memory(0x512684, AtMost, 7);
end
