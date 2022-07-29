function SetWave()
	local WaveT2 = CreateCcode()
	TriggerX(FP, {Switch("Switch 240",Set)}, {AddV(WaveT,1),AddCD(WaveT2,1)},{preserved})
	TriggerX(FP,{CVar(FP,WaveT[2],AtLeast,60*24)},{SetCVar(FP,WaveT[2],Subtract,60*24),SetSwitch(WaveSwitch,Set)},{preserved})
	
	CIf(FP,{CDeaths(FP,AtMost,0,ReplaceDelayT),Switch(WaveSwitch,Set),CVar(FP,Time[2],AtLeast,600*1000)})
		DoActions(FP,{Simple_SetLoc(0,1536,4480,1536,4480)})
		f_TempRepeat(56,25)
		f_TempRepeat(104,15)
		f_TempRepeat(48,7)
		f_TempRepeat(51,15)
		f_TempRepeat(54,15)
		f_TempRepeat(53,15)

		CIf(FP,{CVar(FP,LevelT[2],AtLeast,4),CVar(FP,LevelT[2],AtMost,6)})
		DoActions(FP,{Simple_SetLoc(0,1088,4608,1088,4608)})
			f_TempRepeat(77,5)
			f_TempRepeat(78,5)
			f_TempRepeat(88,10)

			DoActions(FP,{Simple_SetLoc(0,1984,4608,1984,4608)})
			f_TempRepeat(19,5)
			f_TempRepeat(17,5)
			f_TempRepeat(21,10)

		CIfEnd()
		CIf(FP,CVar(FP,LevelT[2],AtLeast,7))
			DoActions(FP,{Simple_SetLoc(0,1088,4608,1088,4608)})
			f_TempRepeat(75,30)
			f_TempRepeat(29,11)
			DoActions(FP,{Simple_SetLoc(0,1984,4608,1984,4608)})
			f_TempRepeat(76,30)
			f_TempRepeat(29,11)

		CIfEnd()
	CIfEnd()
	DoActions(FP,SetSwitch(WaveSwitch,Clear))
	

	CIf(FP,{CDeaths(FP,AtMost,0,ReplaceDelayT),CD(WaveT2,30*24,AtLeast),CVar(FP,Time[2],AtMost,(600*1000)-1)},{SetCD(WaveT2,0)})
		DoActions(FP,{Simple_SetLoc(0,1536,4480,1536,4480)})

		CIf(FP,{CVar(FP,Time[2],AtMost,(90*1000)-1)})
		f_TempRepeat(37,15)
		f_TempRepeat(38,10)
		CIfEnd()

		CIf(FP,{CVar(FP,Time[2],AtLeast,(60*1000)-1)})
		f_TempRepeat(38,10)
		CIfEnd()

		CIf(FP,{CVar(FP,Time[2],AtLeast,(90*1000)-1)})
		f_TempRepeat(37,15)
		f_TempRepeat(38,5)
		f_TempRepeat(39,5)
		f_TempRepeat(43,9)
		CIfEnd()

		CIf(FP,{CVar(FP,Time[2],AtLeast,(180*1000)-1)})
		f_TempRepeat(44,10)
		CIfEnd()

		CIf(FP,{CVar(FP,Time[2],AtLeast,(420*1000)-1)})
		f_TempRepeat(62,6)
		CIfEnd()
	CIfEnd()

end
