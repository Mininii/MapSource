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
    --������ �Ϸ�Ǿ����ϴ�. ������ ���� �������� ��� ���嵥���Ͱ� ��������Ƿ� ������ ���� �ʽ��ϴ�. Ȯ�κ�Ź�帳�ϴ�.