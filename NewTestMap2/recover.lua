    EXPArr = {}
--	for i = 1, 100000 do
--        local XI = 3
--		EXPArr[i] = 10+((i-1)*(i*XI))
--	end
    mw2 = 10
    mw = 0
    mw3 = 6
    cci=0
    
for i = 1, 200000 do
   -- if 0xFFFFFFFFFFFFFFFF
	EXPArr[i] = mw2
    mw2=mw2+mw
    mw=mw+mw3
    cci = cci + 1
    if i >50000 and cci>=10 then
        mw3 = mw3+1
        cci = 0
    end
end

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