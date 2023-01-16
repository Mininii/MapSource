    EXPArr = {}
	for i = 1, 10000 do
		EXPArr[i] = 10+(10*(i-1)*(i*0.3))
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
    tt = exp(3703)
    
    print("total : "..math.floor(total).."    32 : "..(math.floor(total%4294967296)).."   64 : "..math.floor(total/4294967296))

    --복구가 완료됐지만 게임중일시 복구가 안되어있을수있습니다. 확인바랍니다