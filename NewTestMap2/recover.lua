    EXPArr = {}
	for i = 1, 50000 do
        local XI = 3
        if i >=40000 then XI = 10000
    elseif i >=30000 then XI = 1000
    elseif i >=20000 then XI = 100
    elseif i >=10000 then XI = 10
        end
		EXPArr[i] = 10+((i-1)*(i*XI))
	end

    function exp(lv)
        total = 0
        for i = 1, lv do
            total = total + EXPArr[i]
        end
        print("total : "..math.floor(total).."    32 : "..(math.floor(total%4294967296)).."   64 : "..math.floor(total/4294967296))
        return total

    end

    
    function zergling(total,zerglings)
        total = total+(zerglings*37500000)
        print("total : "..math.floor(total).."    32 : "..(math.floor(total%4294967296)).."   64 : "..math.floor(total/4294967296))
    end
    tt = exp(8811)
--    
--    print("total : "..math.floor(total).."    32 : "..(math.floor(total%4294967296)).."   64 : "..math.floor(total/4294967296))
    --print(EXPArr[20000])
    --복구가 완료되었습니다. 하지만 현재 게임중일 경우 저장데이터가 덮어써지므로 복구가 되지 않습니다. 확인부탁드립니다.