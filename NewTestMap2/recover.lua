
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
    
for i = 1, 300001 do
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

local Fileptr = io.open("C:\\Temp\\expdata1.txt", "wb")
local Fileptr2 = io.open("C:\\Temp\\expdata_dp1.txt", "wb")
for i = 1, 300001 do
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
    Fileptr:write(i.."  "..ex.."      32 : "..bit32.band((math.floor(ex%4294967296)), 0xFFFFFFFF).."     64 : "..bit32.band(math.floor(ex/4294967296), 0xFFFFFFFF).."\n")
    Fileptr2:write(i.."  "..to.."      32 : "..bit32.band((math.floor(to%4294967296)), 0xFFFFFFFF).."     64 : "..bit32.band(math.floor(to/4294967296), 0xFFFFFFFF).."\n")

end
io.close(Fileptr)
io.close(Fileptr2)

function SigmaT(max,Func)
	local t={}
	for i = 1, max do
		t[i] = Func(i)
	end
	return t
end

function SigmaDPT(max,Func)
	local t={0}
	for i = 1, max do
		t[i+1] = t[i]+Func(i)
	end
	return t
end

SaveFileArr(EXPArr4,4,"expdata")
SaveFileArr(EXPArr4_2,4,"expdata_dp")
function CreateCostDataFile(Max,SFunc,FileName)
    Max= Max+1
    local t = SigmaT(Max,SFunc)
    local dpt = SigmaDPT(Max,SFunc)
    local CostArr4 = {}
    local CostArr4_2 = {}

    local Fileptr = io.open("C:\\Temp\\"..FileName..".txt", "wb")
    local Fileptr2 = io.open("C:\\Temp\\"..FileName.."_dp.txt", "wb")
    for i = 1, Max do
        local idx = (i-1)*4
        CostArr4[idx+1] = (math.floor(t[i]%4294967296))
        CostArr4[idx+2] = math.floor(t[i]/4294967296)
        CostArr4[idx+3] = 0
        CostArr4[idx+4] = 0
        CostArr4_2[idx+1] = (math.floor(dpt[i]%4294967296))
        CostArr4_2[idx+2] = math.floor(dpt[i]/4294967296)
        CostArr4_2[idx+3] = 0
        CostArr4_2[idx+4] = 0
        Fileptr:write(i.." - 32 : "..math.floor(t[i]%4294967296).."    64 : "..math.floor(t[i]/4294967296).. "\n")
        Fileptr2:write(i.." - 32 : "..math.floor(dpt[i]%4294967296).."    64 : "..math.floor(dpt[i]/4294967296).. "\n")
    end
    SaveFileArr(CostArr4,4,FileName.."")
    SaveFileArr(CostArr4_2,4,FileName.."_dp")
    io.close(Fileptr)
    io.close(Fileptr2)


end



Cost_FXPer44 = CreateCostDataFile(100,function(n) return 1+((n-1)*(n*1)) end,"FXPer44")
Cost_FXPer45 = CreateCostDataFile(100,function(n) return 1+((n-1)*(n*4)) end,"FXPer45")
Cost_FXPer46 = CreateCostDataFile(100,function(n) return 1+((n-1)*(n*7)) end,"FXPer46")
Cost_FXPer47 = CreateCostDataFile(100,function(n) return 1+((n-1)*(n*10)) end,"FXPer47")
Cost_FXPer48 = CreateCostDataFile(1000,function(n) return 1+((n-1)*(n*12)) end,"FXPer48")
Cost_FMEPer = CreateCostDataFile(350,function(n) return 100+((n-1)*(n*1)*n) end,"FMEPer")
Cost_FIncm = CreateCostDataFile(200,function(n) return 1+((n-1)*(n*3)) end,"FIncm")
Cost_FSEXP = CreateCostDataFile(1000,function(n) return (2*n) end,"FSEXP")
Cost_FBrSh = CreateCostDataFile(200,function(n) return 100+((n-1)*(n*3)*n) end,"FBrSh")
Cost_FMin = CreateCostDataFile(200,function(n) return 10000+((n-1)*(162*n)) end,"FMin")

Cost_FAcc = CreateCostDataFile(10, function(n) return 50000000+((n-1)*50000000*n) end, "FAcc")--유료전용 촉진
Cost_FAcc2 = CreateCostDataFile(10, function(n) return 200000000+((n-1)*75000000*n) end, "FAcc2")--무료전용 촉진
Cost_FBrSh2 = CreateCostDataFile(1000,function(n) return 8000000+((n-1)*(n)*n) end,"FBrSh2")--수호의 보석
Cost_FMEPer = CreateCostDataFile(150,function(n) return 40000000+((n-1)*(n*250)*n) end,"FMEPer2")--진 궁극


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

function leafyear(i)
    if i % 4 == 0 then    --           # 4로 나누어 떨어지는지 확인
        if i % 100 == 0 then   --      # 100으로 나누어 떨어지는지 확인
            if i % 400 == 0 then    -- # 400으로 나누어 떨어지는지 확인
                return true
            end    --# 4, 100, 400으로 나누어 떨어지면 윤년
        else
            return true -- # 4로 나누어 떨어지고, 100으로 나누어 떨어지지 않으면 윤년
        end
    end
    return false
end
local Fileptr = io.open("C:\\Temp\\yeararr.txt", "wb")
    YearArr = {0}
    tot = 0
    for i = 1, 99999 do
        if leafyear(i) == true then
            tot = tot+ 366
            YearArr[i+1] = tot
        else
            tot = tot+ 365
            YearArr[i+1] = tot
        end
        Fileptr:write(i.."  "..tot.."\n")
    end

    SaveFileArr(YearArr,4,"YearData")
    io.close(Fileptr)
    


    --print("total : "..math.floor(total).."    32 : "..(math.floor(total%4294967296)).."   64 : "..math.floor(total/4294967296))
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