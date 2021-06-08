function log2(x)
    return math.log(x) / math.log(2)
end

function lshift(x, by)  -- bit32 free, Lua 5.2, 5.3 compatible lshift
    if log2(x) + by < 31 then
        return x * 2 ^ by
    else
        return 2147483648 + (x - 2 ^ math.floor(log2(x))) * 2 ^ by
    end
end

function s2b(Str, Start)
    local ret = 0
    for i = 0, 3 do
        if string.len(Str) >= Start + i then
            ret = ret + lshift(string.byte(Str, Start+i), 8*i)
        end
    end
    return ret
end

function isname(player, name)
    local p = ParsePlayer(player)
    local t = {}
    t[#t+1] = Memory(0x57EEE8 + 36 * p, AtLeast, lshift(string.byte(name, 1), 24))
    t[#t+1] = Memory(0x57EEE8 + 36 * p, AtMost, lshift(string.byte(name, 1), 24) + 16777215)
    for i = 2, string.len(name), 4 do
        t[#t+1] = Memory(0x57EEE8 + 36 * p + (i+2), Exactly, s2b(name, i))
    end
    return t
end

function setname(player, Type, Race, Force, name)
    local p = ParsePlayer(player)
    local t = {}
        function EncodeType(x)
            if string.lower(x) == "inactive" then
                return 0
            elseif string.lower(x) == "computer" then
                return 1
            elseif string.lower(x) == "human" then
                return 2
            elseif string.lower(x) == "rescuable" then
                return 3
            elseif string.lower(x) == "neutral" then
                return 7
            else
                return x
            end
        end
        function EncodeRace(x)
            if string.lower(x) == "zerg" or string.lower(x) == "z" then
                return 0
            elseif string.lower(x) == "terran" or string.lower(x) == "t" then
                return 1
            elseif string.lower(x) == "protoss" or string.lower(x) == "p" then
                return 2
            else
                return x
            end
        end
    t[#t+1] = SetMemory(0x57EEE8 + 36 * p, SetTo, EncodeType(Type) + EncodeRace(Race)*256 + Force*65536 + string.byte(name, 1)*16777216)
    for i = 2, string.len(name), 4 do
        t[#t+1] = SetMemory(0x57EEE8 + 36 * p + (i+2), SetTo, s2b(name, i))
    end
    return t
end
--[[
RegisterSetDeathsHook(function(Player, Modifier, Number, Unit)
    local offset = bit32.band((0x58A364 + (Player + Unit * 12) * 4), 0xFFFFFFFF)
    local base = 0x57EEE0
    local size = 11
    local byte = 36
    local ID = 0
    local right = 0
    local left = 0
    if base <= offset and offset <= base + size * byte then
        if Number < 0 then
            Number = Number + 4294967296
        end
        ID = math.floor((offset - base) / byte)

        local p = DecodePlayer(ID)
        local structure = (offset - base) % byte
        right = Number % 65536
        left = (Number - right) / 65536

        if structure == 0x00 then
            return "SetHumanID(" .. p .. "," .. Number .. "); "
        elseif structure == 0x04 then
            return "SetStormID(" .. p .. "," .. Number .. "); "
        elseif structure == 0x08 then
                function DecodeType(x)
                    if x == 0 then
                        return "Inactive"
                    elseif x == 1 then
                        return "Computer"
                    elseif x == 2 then
                        return "Human"
                    elseif x == 3 then
                        return "Rescuable"
                    elseif x == 7 then
                        return "Neutral"
                    else
                        return x
                    end
                end
                function DecodeRace(x)
                    if x == 0 then
                        return "Zerg"
                    elseif x == 1 then
                        return "Terran"
                    elseif x == 2 then
                        return "Protoss"
                    else
                        return x
                    end
                end
            local b0 = Number % 256
            local b1 = math.floor((Number % 65536) / 256)
            local b2 = math.floor((Number % 16777216) / 65536)
            local b3 = math.floor(Number / 16777216)
            return "setname(".. p .. ", 타입=" .. DecodeType(b0) .. ", 종족=" .. DecodeRace(b1) .. ", 포스=" .. b2 .. ', 첫글자="' .. string.char(b3) .. '"); '
        else
            local letter = structure - 10
            local b = {}
            b[#b+1] = Number % 256
            b[#b+1] = math.floor((Number % 65536) / 256)
            b[#b+1] = math.floor((Number % 16777216) / 65536)
            b[#b+1] = math.floor(Number / 16777216)
            local name = ""
            for i = 1, 4 do
                if b[i] >= 1 then
                    name = name .. string.char(b[i])
                end
            end
            return "setname[" .. letter .. "](" .. p .. ', "' .. name .. '"); '
        end
    end
end, 100)
RegisterDeathsHook(function(Player, Modifier, Number, Unit)
    local offset = bit32.band((0x58A364 + (Player + Unit * 12) * 4), 0xFFFFFFFF)
    local base = 0x57EEE0
    local size = 11
    local byte = 36
    local ID = 0
    local right = 0
    local left = 0
    if base <= offset and offset <= base + size * byte then
        if Number < 0 then
            Number = Number + 4294967296
        end
        ID = math.floor((offset - base) / byte)

        local p = DecodePlayer(ID)
        local structure = (offset - base) % byte
        right = Number % 65536
        left = (Number - right) / 65536

        if structure == 0x00 then
            return "HumanID(" .. p .. "," .. Number .. "); "
        elseif structure == 0x04 then
            return "StormID(" .. p .. "," .. Number .. "); "
        elseif structure == 0x08 then
            function DecodeRace(x)
                if x == 0 then
                    return "Zerg"
                elseif x == 1 then
                    return "Terran"
                elseif x == 2 then
                    return "Protoss"
                else
                    return x
                end
            end
            function DecodeType(x)
                if x == 0 then
                    return "Inactive"
                elseif x == 1 then
                    return "Computer"
                elseif x == 2 then
                    return "Human"
                elseif x == 3 then
                    return "Rescuable"
                elseif x == 7 then
                    return "Neutral"
                else
                    return x
                end
            end
            local b0 = Number % 256
            local b1 = math.floor((Number % 65536) / 256)
            local b2 = math.floor((Number % 16777216) / 65536)
            local b3 = math.floor(Number / 16777216)
            return "isname(".. p .. ", 타입=" .. DecodeType(b0) .. ", 종족=" .. DecodeRace(b1) .. ", 포스=" .. b2 .. ', 첫글자="' .. string.char(b3) .. '"); '
        else
            local letter = structure - 10
            local b = {}
            b[#b+1] = Number % 256
            b[#b+1] = math.floor((Number % 65536) / 256)
            b[#b+1] = math.floor((Number % 16777216) / 65536)
            b[#b+1] = math.floor(Number / 16777216)
            local name = ""
            for i = 1, 4 do
                if b[i] >= 1 then
                    name = name .. string.char(b[i])
                end
            end
            return "isname[" .. letter .. "](" .. p .. ', "' .. name .. '"); '
        end
    end
end, 100)
]]