EXPArr = {}
	for i = 1, 10000 do
		EXPArr[i] = 10+(10*(i-1)*(i*0.3))
	end

    function exp(lv)
        total = 0
        for i = 1, lv do
            total = total + EXPArr[i]
        end
        print("32 : "..(total%4294967296).."   64 : "..total/4294967296)
    end

    --exp(2225)

    --������ �Ϸ������ �������Ͻ� ������ �ȵǾ��������ֽ��ϴ�. Ȯ�ιٶ��ϴ�