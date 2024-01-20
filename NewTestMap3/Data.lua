function Data()
	PVWArr = {}
	VWArr = {}
	SCA_DataArr = {}
	LocalDataArr = {}
	iv.PStatVer = CreateDataPV("PStatVer",1)
	iv.PLevel,iv.LevelLoc = CreateDataPV("PLevel",2,1,1)
	iv.PLevel2 = CreateDataPV("PLevel2",3,nil,1)
	iv.StatP,iv.StatPLoc = CreateDataPV("StatP",4,1,5)
	iv.PEXP = CreateDataPW("PEXP",{101,102})
	iv.CurEXP = CreateDataPW("CurEXP",{103,104})
	iv.TotalExp = CreateDataPW("TotalExp",{105,106},nil,"1")
	iv.Credit,iv.CredLoc = CreateDataPW("PEXP",{107,108},1)
	
	

	iv.Money,iv.MoneyLoc = CreateDataPW("Money",nil,1)
	iv.Money2 = CreateDataPV("Money2")

	iv.BuildMul1 = CreateDataPW("BuildMul1",nil,nil,1)
	iv.TempO = CreateDataPW("TempO")
	iv.CUnitT = CreateDataV("CUnitT")
	iv.BanFlag = CreateDataPV("BanFlag",401)--SCA.BanFlag 
	iv.BanFlag2 = CreateDataPV("BanFlag2",402)--SCA.BanFlag2 
	iv.BanFlag3 = CreateDataPV("BanFlag3",403)--SCA.BanFlag3 
	iv.BanFlag4 = CreateDataPV("BanFlag4",404)--SCA.BanFlag4 
	iv.BanFlag5 = CreateDataPV("BanFlag5",405)--SCA.BanFlag5 
	iv.BanFlag6 = CreateDataPV("BanFlag6",406)--SCA.BanFlag6 
	iv.BanFlag7 = CreateDataPV("BanFlag7",407)--SCA.BanFlag7 
	iv.BanFlag8 = CreateDataPV("BanFlag8",408)--SCA.BanFlag8 
	BPArr = {iv.BanFlag,iv.BanFlag2,iv.BanFlag3,iv.BanFlag4,iv.BanFlag5,iv.BanFlag6,iv.BanFlag7,iv.BanFlag8}


	
	iv.MapMakerFlag = CreateDataPV("MapMakerFlag", 322)
	iv.TesterFlag = CreateDataPV("TesterFlag", 323)




	
	iv.StatEff = CreateCcodeArr(8) -- 레벨업 이펙트
	iv.TotalExpLoc = CreateWar(FP)
	iv.ExpLoc = CreateWar(FP)
	iv.StatEffLoc = CreateCcode()
	
	
end