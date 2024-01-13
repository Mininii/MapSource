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
	iv.CUnitT,ct.CUnitT = CreateDataV("CUnitT")
	iv.BanFlag,ct.BanFlag = CreateDataPV("BanFlag5")--SCA.BanFlag 
	iv.BanFlag2,ct.BanFlag2 = CreateDataPV("BanFlag6")--SCA.BanFlag2 
	iv.BanFlag3,ct.BanFlag3 = CreateDataPV("BanFlag7")--SCA.BanFlag3 
	iv.BanFlag4,ct.BanFlag4 = CreateDataPV("BanFlag8")--SCA.BanFlag4 
	iv.BanFlag5,ct.BanFlag5 = CreateDataPV("BanFlag5")--SCA.BanFlag5 
	iv.BanFlag6,ct.BanFlag6 = CreateDataPV("BanFlag6")--SCA.BanFlag6 
	iv.BanFlag7,ct.BanFlag7 = CreateDataPV("BanFlag7")--SCA.BanFlag7 
	iv.BanFlag8,ct.BanFlag8 = CreateDataPV("BanFlag8")--SCA.BanFlag8 
	BPArr = {iv.BanFlag,iv.BanFlag2,iv.BanFlag3,iv.BanFlag4,iv.BanFlag5,iv.BanFlag6,iv.BanFlag7,iv.BanFlag8}
	
end