
function Waves()
	local WaveT = CreateCcodeArr(7)
	local WaveS = CreateCcodeArr(7)
function ElapsedTimeX(Comparison, Time)
	return Memory(0x58D6F8 ,Comparison, Time)
end
function SetWave(Condition,WaveC,XYTable,NUTable)
	
	CIf(FP,Condition,{AddCD(WaveC,1)})
		CIf(FP,CD(WaveC,250,AtLeast),SetCD(WaveC,0))
		for j, k in pairs(NUTable) do
			f_TempRepeat({},k[1],k[2],nil,FP,XYTable)
		end
		CIfEnd()
	CIfEnd()
end
	TriggerX(FP,{Bring(FP, AtMost, 0, 130, 5)},{SetCD(WaveS[1],1),SetInvincibility(Disable, 151, FP, 8),SetInvincibility(Disable, 151, FP, 9)})
	TriggerX(FP,{Bring(FP, AtMost, 0, 151, 8)},{SetCD(WaveS[2],1),SetInvincibility(Disable, 201, FP, 10)})
	TriggerX(FP,{Bring(FP, AtMost, 0, 151, 9)},{SetCD(WaveS[3],1),SetInvincibility(Disable, 201, FP, 11)})
	TriggerX(FP,{Bring(FP, AtMost, 0, 201, 10)},{SetCD(WaveS[4],1),SetInvincibility(Disable, 152, FP, 12)})
	TriggerX(FP,{Bring(FP, AtMost, 0, 201, 11)},{SetCD(WaveS[5],1),SetInvincibility(Disable, 152, FP, 13)})
	TriggerX(FP,{Bring(FP, AtMost, 0, 152, 12)},{SetCD(WaveS[6],1)})
	TriggerX(FP,{Bring(FP, AtMost, 0, 152, 13)},{SetCD(WaveS[7],1)})
	TriggerX(FP,{CD(WaveS[6],1),CD(WaveS[7],1)},{SetInvincibility(Disable, 147, FP, 64)})
	SetWave({CD(WaveS[1],0)},WaveT[1],{1536,1088},{{40,15}})
	SetWave({CD(WaveS[1],1),CD(WaveS[2],0)},WaveT[2],{576,1024},{{37,10},{38,7}})
	SetWave({CD(WaveS[1],1),CD(WaveS[3],0)},WaveT[3],{2496,1024},{{37,10},{38,7}})
	SetWave({CD(WaveS[2],1),CD(WaveS[4],0)},WaveT[4],{1152,1568},{{38,10},{39,4},{43,9}})
	SetWave({CD(WaveS[3],1),CD(WaveS[5],0)},WaveT[5],{1920,1568},{{38,10},{39,4},{43,9}})
	SetWave({CD(WaveS[4],1),CD(WaveS[6],0)},WaveT[6],{1280,1872},{{44,25}})
	SetWave({CD(WaveS[5],1),CD(WaveS[7],0)},WaveT[7],{1792,1872},{{44,25}})
	
end