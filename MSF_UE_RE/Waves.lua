function SetWave()
TriggerX(FP,{CVar(FP,WaveT[2],AtLeast,60*1000)},{SetCVar(FP,WaveT[2],Subtract,60*1000),SetSwitch(WaveSwitch,Set)},{preserved})
  
CIf(FP,{ElapsedTime(AtLeast, 5*60),CDeaths(FP,AtMost,0,ReplaceDelayT),Switch(WaveSwitch,Set),CVar(FP,Time[2],AtLeast,180*1000)},{SetResources(Force1,Add,500,Ore)})
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

end
