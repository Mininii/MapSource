function Install_CallTriggers()
    Call_UnitSizePatch = SetCallForward()
    SetCall(FP)
        UIndex = CreateVar(FP)
        TempT= CreateVarArr(2, FP)
        TempT2= CreateVarArr(2, FP)
        TempT3= CreateVarArr(4, FP)
        CMov(FP,TempT2[1],UIndex,EPD(0x6617C8))
        CMov(FP,TempT2[2],UIndex,EPD(0x6617CC))
        f_Read(FP,TempT2[1],TempT[1])
        f_Read(FP,TempT2[2],TempT[2])
        CMov(FP,TempT3[1],TempT[1],nil,0xFFFF)
        CMov(FP,TempT3[2],TempT[2],nil,0xFFFF)
        CMov(FP,TempT3[3],TempT[1],nil,0xFFFF0000)
        CMov(FP,TempT3[4],TempT[2],nil,0xFFFF0000)
        f_Div(FP,TempT3[1],2)
        f_Div(FP,TempT3[2],2)
        f_Div(FP,TempT3[3],65536)
        f_Div(FP,TempT3[4],65536)
        f_Div(FP,TempT3[3],2)
        f_Div(FP,TempT3[4],2)
        CTrigger(FP,{CVar(FP,TempT3[1][2],AtMost,0,0xFFFF)},{AddV(TempT3[1],1)},1)
        CTrigger(FP,{CVar(FP,TempT3[2][2],AtMost,0,0xFFFF)},{AddV(TempT3[2],1)},1)
        CTrigger(FP,{CVar(FP,TempT3[3][2],AtMost,0,0xFFFF)},{AddV(TempT3[3],1)},1)
        CTrigger(FP,{CVar(FP,TempT3[4][2],AtMost,0,0xFFFF)},{AddV(TempT3[4],1)},1)
        CDoActions(FP, {
            TSetMemory(TempT2[1],SetTo,_Add(TempT3[1],_Mul(TempT3[3],65536))),
            TSetMemory(TempT2[2],SetTo,_Add(TempT3[2],_Mul(TempT3[4],65536))),
        })
    SetCallEnd()
    ZSpawnCallTable = {}
    for i = 1, #ZealotUIDArr do
        table.insert(ZSpawnCallTable,SetCallForward())
        SetCall(FP)
            CIf(FP,Memory(0x628438, AtLeast, 1))
				f_Read(FP, 0x628438, nil, Nextptrs)
				CDoActions(FP, {
					SetMemoryB(0x669E28+151, SetTo, ZealotUIDArr[i][3]);
					CreateUnitWithProperties(1,ZealotUIDArr[i][1],1,ZealotUIDArr[i][4],{energy = 100}),
					SetMemoryB(0x669E28+151, SetTo, 0);

				TSetDeaths(_Add(Nextptrs,13),SetTo,ZealotUIDArr[i][2],0),
				TSetDeathsX(_Add(Nextptrs,18),SetTo,ZealotUIDArr[i][2],0,0xFFFF),
				TSetMemoryX(_Add(Nextptrs,8),SetTo,127*65536,0xFF0000),
				TSetMemoryX(_Add(Nextptrs,9),SetTo,0,0xFF000000),
				TSetMemoryX(_Add(Nextptrs,55),SetTo,0xA00000,0xA00000),
				TSetDeathsX(_Add(Nextptrs,72),SetTo,0xFF*256,0,0xFF00),
			})
			CMov(FP,CunitIndex,_Div(_Sub(Nextptrs,19025),_Mov(84)))
			if ZealotUIDArr[i][6]>8320000 then
				
				
				local TempV1 = CreateVar(FP)
				local TempV2 = CreateVar(FP)
				f_LMov(FP, {TempV1,TempV2}, _LSub(ZealotUIDArr[i][7],tostring(8320000*256)), nil, nil, 1)
					CDoActions(FP, {
						Set_EXCC2(LHPCunit, CunitIndex, 0, SetTo,1),
						Set_EXCC2(LHPCunit, CunitIndex, 1, SetTo,TempV1),
						Set_EXCC2(LHPCunit, CunitIndex, 2, SetTo,TempV2),
				})
			else
				CDoActions(FP, {
					Set_EXCC2(LHPCunit, CunitIndex, 0, SetTo,0),
					Set_EXCC2(LHPCunit, CunitIndex, 1, SetTo,0),
					Set_EXCC2(LHPCunit, CunitIndex, 2, SetTo,0),
			})


			end
            CIfEnd()
        SetCallEnd()
    end
end