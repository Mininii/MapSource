
local Strchar = string.char
local b32band = bit32.band
local b32rshift = bit32.rshift
local tconcat = table.concat
function dwwrite(dword)
	return Strchar(b32band(dword,0xFF),b32rshift(b32band(dword,0xFF00),8),b32rshift(b32band(dword,0xFF0000),16),b32rshift(b32band(dword,0xFF000000),24))
end

function SaveFileArr(FileArray,ElementSize,FileName)
	local FilePath = FileName
	local Fileptr = io.open("C:\\Temp\\"..FilePath, "wb")
    assert(Fileptr~=nil, FilePath.." Can't be Open!")

	local FileSTR = ""
	local STRLength = 0
    for i = 1, #FileArray do
    	if ElementSize == 1 then
	    	FileSTR = FileSTR .. string.char(FileArray[i])
	    	STRLength = STRLength + 1
	    elseif ElementSize == 2 then
	    	FileSTR = FileSTR .. string.char(bit32.band(FileArray[i], 0xFF),bit32.rshift(bit32.band(FileArray[i], 0xFF00),8))
	    	STRLength = STRLength + 2
	    elseif ElementSize == 3 then
	    	FileSTR = FileSTR .. string.char(bit32.band(FileArray[i], 0xFF),bit32.rshift(bit32.band(FileArray[i], 0xFF00),8),bit32.rshift(bit32.band(FileArray[i], 0xFF0000),16))
	    	STRLength = STRLength + 3
	    elseif ElementSize == 4 then
	    	FileSTR = FileSTR .. string.char(bit32.band(FileArray[i], 0xFF),bit32.rshift(bit32.band(FileArray[i], 0xFF00),8),bit32.rshift(bit32.band(FileArray[i], 0xFF0000),16),bit32.rshift(bit32.band(FileArray[i], 0xFF000000),24))
	    	STRLength = STRLength + 4
	    else
	    	SaveFileArr_InputData_Error()
		end
		if STRLength >= 4096 then
    		Fileptr:write(FileSTR)
    		STRLength = 0
    		FileSTR = ""
    	end
    end
    if STRLength >= 1 then
    	Fileptr:write(FileSTR)
    end
    local size = Fileptr:seek("end")
	io.close(Fileptr)
	return size
end

EXPArr = {}
--	for i = 1, 100000 do
--        local XI = 3
--		EXPArr[i] = 10+((i-1)*(i*XI))
--	end
    mw2 = 10
    mw = 0
    mw3 = 6
    cci=0
    
for i = 1, 200001 do
   -- if 0xFFFFFFFFFFFFFFFF
	EXPArr[i] = mw2
    mw=mw+mw3
    mw2=mw2+mw
    cci = cci + 1
    if i >50000 and cci>=10 then
        mw3 = mw3+1
        cci = 0
    end
end
EXPArr4 = {}--일반
EXPArr4_2 = {0,0,0,0}--dp
to = 0
for i = 1, 200001 do
    local ex = EXPArr[i]
    to = to + ex
    local idx = (i-1)*4
    local idx2 = (i)*4
    EXPArr4[idx+1] = (math.floor(ex%4294967296))
    EXPArr4[idx+2] = math.floor(ex/4294967296)
    EXPArr4[idx+3] = 0
    EXPArr4[idx+4] = 0
    EXPArr4_2[idx2+1] = (math.floor(to%4294967296))
    EXPArr4_2[idx2+2] = math.floor(to/4294967296)
    EXPArr4_2[idx2+3] = 0
    EXPArr4_2[idx2+4] = 0
end





SaveFileArr(EXPArr4,4,"expdata")
SaveFileArr(EXPArr4_2,4,"expdata_dp")

    function exp(lv)
        total = 0
        for i = 1, lv do
            if EXPArr[i]>0x7FFFFFFFFFFFFFFF-total then
                error("overflow. i = "..i)
            else
                total = total + EXPArr[i]
            end
        end
        print("total : "..math.floor(total).."    32 : "..(math.floor(total%4294967296)).."   64 : "..math.floor(total/4294967296))
        return total

    end
    exp(200000)
    function zergling(total,zerglings)
        total = total+(zerglings*37500000)
        print("total : "..math.floor(total).."    32 : "..(math.floor(total%4294967296)).."   64 : "..math.floor(total/4294967296))
    end
    EXPArr2 = {}
    for i = 1, 100000 do
        EXPArr2[i] = 10+(10*(i-1)*(i*0.3))
    end
--    
    function exp2(lv)
        total = 0
        for i = 1, lv do
            total = total + EXPArr2[i]
        end
        print("total : "..math.floor(total).."    32 : "..(math.floor(total%4294967296)).."   64 : "..math.floor(total/4294967296))
        return total

    end

    exp2(100000)
--    print("total : "..math.floor(total).."    32 : "..(math.floor(total%4294967296)).."   64 : "..math.floor(total/4294967296))
    --print(EXPArr[20000])
    --복구가 완료되었습니다. 하지만 현재 게임중일 경우 저장데이터가 덮어써지므로 복구가 되지 않습니다. 확인부탁드립니다.
--    math.randomseed( os.time() )
--    function RandTest(n)
--        local t = {0,0,0,0,0,0,0,0,0,0}
--        local t2={0,0,0,0,0,0,0,0,0,0}
--        for i = 1, n do
--            local k = bit32.band(math.random(0xFFFFFFFF),0xFFFFFFFF)
--            local ptr = (((k)%10000)//1000)+1 -- 강화성공여부
--            local ptr2 = (((bit32.rshift(k,16))%10000)//1000)+1 -- 유지 성공 실패여부
--            --print(k,ptr,ptr2)
--            t[ptr] = t[ptr]+1
--            t2[ptr2] = t2[ptr2]+1
--        end        
--        print("강화 실패, 성공값")
--        for j,k in pairs(t) do
--            print(((j-1)*1000).."~"..tostring(j*1000).." : "..k)
--        end
--        print("유지 성공, 실패값")
--        for j,k in pairs(t2) do
--            print(((j-1)*1000).."~"..tostring(j*1000).." : "..k)
--        end
--    end
    --RandTest(500000)	