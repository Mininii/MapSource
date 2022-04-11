---------------------------------------------------------------------------------
-- Copyright (c) 2014 trgk(phu54321@naver.com)
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
---------------------------------------------------------------------------------

function EPD(offset)
    return (offset - 0x58A364) / 4
end

function Memory(offset, comparison, number)
    assert(offset % 4 == 0, "[Memory] Offset should be divisible by 4")

    if 0x58A364 <= offset and offset <= 0x58A364 + 48 * 65536 then
        local eud_player, eud_unit
        eud_player = (offset - 0x58A364) / 4 % 12
        eud_unit = ((offset - 0x58A364) / 4 - eud_player) / 12
        return Deaths(eud_player, comparison, number, eud_unit)
    end
    
    return Deaths(EPD(offset), comparison, number, 0)
end

function SetMemory(offset, modtype, number)
    assert(offset % 4 == 0, "[SetMemory] Offset should be divisible by 4")

    -- If offset is in normal deaths / eud range, use it.
    if 0x58A364 <= offset and offset <= 0x58A364 + 48 * 65536 then
        local eud_player, eud_unit
        eud_player = (offset - 0x58A364) / 4 % 12
        eud_unit = ((offset - 0x58A364) / 4 - eud_player) / 12
        return SetDeaths(eud_player, modtype, number, eud_unit)
    else  -- Use EPD
	return SetDeaths(EPD(offset), modtype, number, 0)
    end
end
function MemoryX(offset, comparison, number,Mask)
    assert(offset % 4 == 0, "[Memory] Offset should be divisible by 4")

    if 0x58A364 <= offset and offset <= 0x58A364 + 48 * 65536 then
        local eud_player, eud_unit
        eud_player = (offset - 0x58A364) / 4 % 12
        eud_unit = ((offset - 0x58A364) / 4 - eud_player) / 12
        return Deaths(eud_player, comparison, number, eud_unit)
    end
    
    return DeathsX(EPD(offset), comparison, number, 0,Mask)
end

function SetMemoryX(offset, modtype, number,Mask)
    assert(offset % 4 == 0, "[SetMemory] Offset should be divisible by 4")

    -- If offset is in normal deaths / eud range, use it.
    if 0x58A364 <= offset and offset <= 0x58A364 + 48 * 65536 then
        local eud_player, eud_unit
        eud_player = (offset - 0x58A364) / 4 % 12
        eud_unit = ((offset - 0x58A364) / 4 - eud_player) / 12
        return SetDeaths(eud_player, modtype, number, eud_unit)
    else  -- Use EPD
	return SetDeathsX(EPD(offset), modtype, number, 0,Mask)
    end
end

----------------------------------------------------------
