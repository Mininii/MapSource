function CT_Prev()
	--error(#VWArr+#PVWArr+#VWArr2)
	CMov(FP,CT_GNextRandV,_Mod(_Rand(),12858519))
	f_LMov(FP,CT_GNextRandW,_LMod(_LRand(), {12532858,12532858}))
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
	


end
function CT_PrevCP(i)
	CMov(FP,CT_NextRandV[i+1],_Mod(_Rand(),12858519))
	f_LMov(FP,CT_NextRandW[i+1],_LMod(_LRand(), {12532858,12532858}))
	
	CIf(FP, LocalPlayerID(i))
	for j,k in pairs(PVWArr) do
		local VW = k[1][i+1]
		local TrapVW = k[2][i+1]
		TrapKey = CheatTestX(i, VW,TrapVW, j+(#VWArr)-1,1,k[3])

	end
	CIfEnd()
end
function CT_Next()
	
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
	else
		f_LXor(FP, TrapVW,VW, CT_GNextRandW)
	end

end

for j,k in pairs(VWArr2) do
	local VW = k[1]
	local TrapVW = k[2]
	if TrapVW[4] == "V" then
		CXor(FP, TrapVW,VW, CT_GNextRandV)
	else
		f_LXor(FP, TrapVW,VW, CT_GNextRandW)
	end

end
	CMov(FP,CT_GPrevRandV,CT_GNextRandV)
	f_LMov(FP,CT_GPrevRandW,CT_GNextRandW)
	for i = 0, 6 do
		CIf(FP, {HumanCheck(i,1),LocalPlayerID(i)})
		for j,k in pairs(PVWArr) do
			local VW = k[1][i+1]
			local TrapVW = k[2][i+1]
			if TrapVW[4] == "V" then
				CXor(FP, TrapVW,VW, CT_NextRandV[i+1])
			else
				f_LXor(FP, TrapVW,VW, CT_NextRandW[i+1])
			end
	
		end
		CMov(FP,CT_PrevRandV[i+1],CT_NextRandV[i+1])
		f_LMov(FP,CT_PrevRandW[i+1],CT_NextRandW[i+1])
		CIfEnd()
	end
end