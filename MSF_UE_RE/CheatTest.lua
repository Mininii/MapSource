function CT_Prev()
	--PushErrorMsg(#VWArr.." "..#VWArr2.." "..#PVWArr)
	--error(#VWArr+#PVWArr+#VWArr2)
	CMov(FP,CT_GNextRandV,_Rand())
	f_LMov(FP,CT_GNextRandW,_LRand())
--	if Limit == 0 then
		for j,k in pairs(VWArr) do
			local VW = k[1]
			local TrapVW = k[2]
			TrapKey = CheatTestX(AllPlayers, VW,TrapVW, j-1,nil,k[3])
	
		end
	
	--end

end
function CT_PrevCP()
	VArrL,VArrL4 = CreateVars(2, FP)
	WArrL,WArrL4 = CreateWars(2, FP)
	GV,TrapGV = CreateVars(2, FP)
	GW,TrapGW = CreateWars(2, FP)
	for i = 0,6 do --ConvertVArr
		TriggerX(FP, {LocalPlayerID(i)}, {SetV(VArrL,604*i),SetV(VArrL4,2416*i),SetNWar(WArrL, SetTo, {604*i,604*i}),SetNWar(WArrL4, SetTo, {2416*i,2416*i}),},{preserved})
	end

	
	--if Limit == 0 then
		for j,k in pairs(PVWArr) do
			local VW = k[1]
			local TrapVW = k[2]
			TrapKey = CheatTest2X(GCP, VW,TrapVW, j+(#VWArr)-1,1,k[3])
	
		end
	--end
end
function CT_Next()
	
--if Limit == 0 then



	for j,k in pairs(PVWArr) do
		local VW = k[1]
		local TrapVW = k[2]
		if TrapVW[1][4] == "V" then
			CMovX(FP,GV,VArrX(GetVArray(VW[1], 7), VArrL, VArrL4),nil,nil,nil,1)
			CXor(FP,GV, CT_GNextRandV)
			CMovX(FP,VArrX(GetVArray(VW[1], 7), VArrL, VArrL4),GV,nil,nil,nil,1)
			CMovX(FP,VArrX(GetVArray(TrapVW[1], 7), VArrL, VArrL4),GV,nil,nil,nil,1)

		else
			f_LMovX(FP,GW,WArrX(GetWArray(VW[1], 7), WArrL, WArrL4),nil,nil,nil,1)
			f_LXor(FP, GW,GW, CT_GNextRandW)
			f_LMovX(FP,WArrX(GetWArray(VW[1], 7), WArrL, WArrL4),GW,nil,nil,nil,1)
			f_LMovX(FP,WArrX(GetWArray(TrapVW[1], 7), WArrL, WArrL4),GW,nil,nil,nil,1)
		end

	end

--end
	CMov(FP,CT_GPrevRandV,CT_GNextRandV)
	f_LMov(FP,CT_GPrevRandW,CT_GNextRandW)
end