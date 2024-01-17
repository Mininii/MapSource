function Data()
	PVWArr = {}
	VWArr = {}
	SCA_DataArr = {}
	LocalDataArr = {}
	
	iv.PStatVer = CreateDataPV("PStatVer",1)
	iv.PLevel = CreateDataPV("PLevel",2,nil,1)
	iv.PLevel2 = CreateDataPV("PLevel2",3,nil,1)
	iv.StatP = CreateDataPV("StatP",4,nil,5)
	iv.Money = CreateDataPW("Money",{99,100})
	iv.PEXP = CreateDataPW("PEXP",{101,102})
	iv.CurEXP = CreateDataPW("CurEXP",{103,104})
	iv.TotalExp = CreateDataPW("TotalExp",{105,106})

	iv.MapMakerFlag = CreateDataPV("MapMakerFlag", 322)
	iv.TesterFlag = CreateDataPV("MapMakerFlag", 323)


	iv.BuildMul1 = CreateDataPW("BuildMul1",nil,nil,1)
	iv.TempO = CreateDataPW("TempO")
	iv.Money2 = CreateDataPV("Money2")
	iv.CUnitT = CreateDataV("CUnitT")
	iv.BanFlag = CreateDataPV("BanFlag")--SCA.BanFlag 
	iv.BanFlag2 = CreateDataPV("BanFlag2")--SCA.BanFlag2 
	iv.BanFlag3 = CreateDataPV("BanFlag3")--SCA.BanFlag3 
	iv.BanFlag4 = CreateDataPV("BanFlag4")--SCA.BanFlag4 
	iv.BanFlag5 = CreateDataPV("BanFlag5")--SCA.BanFlag5 
	iv.BanFlag6 = CreateDataPV("BanFlag6")--SCA.BanFlag6 
	iv.BanFlag7 = CreateDataPV("BanFlag7")--SCA.BanFlag7 
	iv.BanFlag8 = CreateDataPV("BanFlag8")--SCA.BanFlag8 
	BPArr = {iv.BanFlag,iv.BanFlag2,iv.BanFlag3,iv.BanFlag4,iv.BanFlag5,iv.BanFlag6,iv.BanFlag7,iv.BanFlag8}
	
end