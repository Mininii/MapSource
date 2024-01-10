function Interface()
	for i = 0, 7 do
		CIf(FP,{HumanCheck(i, 1)})
		DisplayPrint(i, {"내돈 : ",iv.Money[i+1]})
		DPSBuilding(i,DpsLV1[i+1],nil,iv.BuildMul1[i+1],{iv.TempO[i+1]},iv.Money[i+1])
		
		--Debug_DPSBuilding(DpsLV1[i+1],127,95+i)
		CIfEnd()
	end
end