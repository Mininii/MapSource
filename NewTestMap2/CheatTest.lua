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
		for j,k in pairs(VWArr2) do
			local VW = k[1]
			local TrapVW = k[2]
			TrapKey = CheatTestX(AllPlayers, VW,TrapVW, (j+#VWArr+#PVWArr)-1,nil,k[3])
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

MemoryCT = CreateCcode()
--error(#MCTCondArr)
DoActionsX(FP,{SetCD(MemoryCT,0),})
if Limit==1 then
	MCTCondArr[1] = Memory(0x5124F0, Exactly, TestSpeedNum)
end--
condnum = 0
condptr = 0
condarr = {}
for j,k in pairs(MCTCondArr) do
	if condnum == 0 then table.insert(condarr,{}) condptr = condptr + 1 end
	table.insert(condarr[condptr],k)
	condnum = condnum + 1
	if condnum == 15 then condnum = 0 end
end--
for j,k in pairs(condarr) do
	TriggerX(FP, k, {AddCD(MemoryCT,1),SetCp(0)}, {preserved})
end
--error(#condarr)--
if TestStart == 1 then
	CTrigger(FP,{
		CD(MemoryCT,#condarr-1,AtMost)
	},{RotatePlayer({
		DisplayExtText("MemoryCT", 4);},Force1,FP)},{preserved})
	else----
		TriggerX(FP,{CD(MemoryCT,#condarr-1,AtMost)},{RotatePlayer({
			PlayWAVX("sound\\Protoss\\ARCHON\\PArDth00.WAV");
			DisplayExtText("m\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다.\x07 』",4);},Force1,FP),SetMemory(0xCDDDCDDC,SetTo,1);})
	end
	--


for j,k in pairs(VWArr) do
	local VW = k[1]
	local TrapVW = k[2]
	if TrapVW[4] == "V" then
		CXor(FP, TrapVW,VW, CT_GNextRandV)
		CMov(FP, VW, TrapVW)
	else
		f_LXor(FP, TrapVW,VW, CT_GNextRandW)
		f_LMov(FP, VW, TrapVW)
	end

end

for j,k in pairs(VWArr2) do
	local VW = k[1]
	local TrapVW = k[2]
	if TrapVW[4] == "V" then
		CXor(FP, TrapVW,VW, CT_GNextRandV)
		CMov(FP, VW, TrapVW)
	else
		f_LXor(FP, TrapVW,VW, CT_GNextRandW)
		f_LMov(FP, VW, TrapVW)
	end

end


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