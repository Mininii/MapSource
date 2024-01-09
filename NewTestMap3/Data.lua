function Data()
	iv = {}
	ct = {}
	PVWArr = {}
	VWArr = {}
	SCA_DataArr = {}
	LocalDataArr = {}
	
	iv.Money,ct.Money = CreateDataPW("Money")
	iv.BuildMul1,ct.BuildMul1 = CreateDataPW("BuildMul1",nil,nil,1)
	iv.TempO,ct.TempO = CreateDataPW("TempO")
	iv.Money2,ct.Money2 = CreateDataPV("Money2")
end