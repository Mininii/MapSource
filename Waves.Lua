function SetWave()


TriggerX(FP,{CVar(FP,WaveT[2],AtLeast,60*1000)},{SetCVar(FP,WaveT[2],Subtract,60*1000),SetSwitch(WaveSwitch,Set)},{Preserved})
CIf(FP,{Switch(WaveSwitch,Set),CVar(FP,Time[2],AtLeast,180*1000)},SetSwitch(WaveSwitch,Clear))
DoActions(FP,{Simple_SetLoc(0,1536,4480,1536,4480)})
f_TempRepeat(56,25)
f_TempRepeat(104,15)
f_TempRepeat(48,7)
f_TempRepeat(51,15)
f_TempRepeat(54,15)
f_TempRepeat(53,15)

CIf(FP,CVar(FP,Level[2],AtLeast,11))
DoActions(FP,{Simple_SetLoc(0,1088,4608,1088,4608)})
f_TempRepeat(77,15)
f_TempRepeat(78,15)
f_TempRepeat(88,30)

DoActions(FP,{Simple_SetLoc(0,1984,4608,1984,4608)})
f_TempRepeat(19,15)
f_TempRepeat(17,15)
f_TempRepeat(21,30)


CIfEnd()
CIf(FP,CVar(FP,Level[2],AtLeast,21))
DoActions(FP,{Simple_SetLoc(0,1088,4608,1088,4608)})
f_TempRepeat(75,30)
f_TempRepeat(29,11)
DoActions(FP,{Simple_SetLoc(0,1984,4608,1984,4608)})
f_TempRepeat(76,30)
f_TempRepeat(29,11)

CIfEnd()

CIfEnd()

end