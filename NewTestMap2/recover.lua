    EXPArr = {}
	for i = 1, 100000 do
        local XI = 3
        if i>=10000 then
            XI = 10
        end
		EXPArr[i] = 10+((i-1)*(i*XI))
	end
--    mw2 = 10
--    mw = 6
--for i = 1, 100000 do
--	EXPArr[i] = mw2
--    mw2 = mw2+mw
--    mw=mw+6
--end

    function exp(lv)
        total = 0
        for i = 1, lv do
            total = total + EXPArr[i]
        end
        print("total : "..math.floor(total).."    32 : "..(math.floor(total%4294967296)).."   64 : "..math.floor(total/4294967296))
        return total

    end
    exp(100000)
    function zergling(total,zerglings)
        total = total+(zerglings*37500000)
        print("total : "..math.floor(total).."    32 : "..(math.floor(total%4294967296)).."   64 : "..math.floor(total/4294967296))
    end
    tt = exp(5050)
--    
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