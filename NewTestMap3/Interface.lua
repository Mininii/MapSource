function Interface()
	it_jump = def_sIndex()
	CJump(FP, it_jump)
	it_Call = SetCallForward()
	SetCall(FP)
	

	CIf(FP,{TMemory(0x512684,Exactly,GCP)})
	FixText(FP, 1)
	CIfEnd()
	DisplayPrint(GCP, {"내돈 : ",PVtoV(iv.Money)})
	CIf(FP,{TMemory(0x512684,Exactly,GCP)})
	FixText(FP, 2)
	CIfEnd()
	DPSBuildingX(GCP,DpsLV1,nil,iv.BuildMul1,{iv.TempO,Ore},iv.Money,iv.Money2)
	Debug_DPSBuildingX(DpsLV1,127,95)
	SetCallEnd()
	CJumpEnd(FP, it_jump)

	for i = 0, 7 do
		CallTriggerX(FP,it_Call, {HumanCheck(i, 1)},{SetV(GCP,i),SetNWar(GCPW,SetTo,tostring(i)),SetV(VArrI,604*i),SetV(VArrI4,2416*i),SetNWar(WArrI, SetTo, {604*i,604*i}),SetNWar(WArrI4, SetTo, {2416*i,2416*i})})

		CreateUnitStackedCp({HumanCheck(i, 1)}, 12, 0, 34, nil,nil,1)
	end
end