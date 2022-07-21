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
    SpawnOptionV = CreateVar(FP)
    SpawnOptionV2 = CreateVar(FP)
    for i = 1, #ZealotUIDArr do
        table.insert(ZSpawnCallTable,SetCallForward())
        SetCall(FP)
            CIf(FP,Memory(0x628438, AtLeast, 1))
				f_Read(FP, 0x628438, nil, Nextptrs)
                TriggerX(FP,{CV(SpawnOptionV2,0)},{SetV(SpawnOptionV2,ZealotUIDArr[i][4])},{preserved})
				CDoActions(FP, {
					SetMemoryB(0x669E28+151, SetTo, ZealotUIDArr[i][3]);
					TCreateUnitWithProperties(1,ZealotUIDArr[i][1],1,SpawnOptionV2,{energy = 100}),
					SetMemoryB(0x669E28+151, SetTo, 0);

				TSetDeaths(_Add(Nextptrs,13),SetTo,ZealotUIDArr[i][2],0),
				TSetDeathsX(_Add(Nextptrs,18),SetTo,ZealotUIDArr[i][2],0,0xFFFF),
				TSetMemoryX(_Add(Nextptrs,8),SetTo,127*65536,0xFF0000),
				TSetMemoryX(_Add(Nextptrs,9),SetTo,0,0xFF000000),
				TSetMemoryX(_Add(Nextptrs,55),SetTo,0xA00000,0xA00000),
				TSetDeathsX(_Add(Nextptrs,72),SetTo,0xFF*256,0,0xFF00),
			})
            CTrigger(FP,{CV(SpawnOptionV,1,AtLeast)},{
                TSetDeaths(_Add(Nextptrs,13),SetTo,SpawnOptionV,0),
				TSetDeathsX(_Add(Nextptrs,18),SetTo,SpawnOptionV,0,0xFFFF),
            },1)
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
            DoActionsX(FP,{SetV(SpawnOptionV,0),SetV(SpawnOptionV2,0)})
        SetCallEnd()
    end

    Call_CAPlot = SetCallForward()
    CACX = CreateVar2(FP, nil, nil, 2048)
    CACY = CreateVar2(FP, nil, nil, 2048)
    ZPX,ZPY=CreateVars(2,FP)
    CARX,CARY,CARo = CreateVars(3,FP)
    CA_ZUID = CreateVar(FP)
    ShNm = CreateVar(FP)
    CAXYRand = CreateCcode()
    CA_SpawnOptionV= CreateVar(FP)
    CA_SpawnOptionV2 = CreateVar(FP)
    CA_SpawnOptionV3 = CreateVar(FP)
    CA_SpawnOptionV4 = CreateVar(FP)
    function CAFunc()
		local CA = CAPlotDataArr
		local CB = CAPlotCreateArr
		local PlayerID = CAPlotPlayerID
        CA_RatioXY(CARX, 2000, CARY, 2000)
        CA_Rotate(CARo)
        CIf(FP, {CV(CA_SpawnOptionV3,1)})
            CA_Rotate3D(CA_Eff_XY, CA_Eff_YZ, CA_Eff_ZX)
        CIfEnd()

		CAdd(FP,CPosX,V(CA[8]),CACX)
		CAdd(FP,CPosY,V(CA[9]),CACY)
        CTrigger(FP,{CV(CA_SpawnOptionV,1,AtLeast)},{SetV(SpawnOptionV,CA_SpawnOptionV)},1)
        CTrigger(FP,{CV(CA_SpawnOptionV2,1,AtLeast)},{SetV(SpawnOptionV2,CA_SpawnOptionV2)},1)
		Simple_SetLocX(FP,"Location 1",CPosX,CPosY,CPosX,CPosY,Simple_CalcLoc(0,-32,-32,32,32))
        for j, k in pairs(ZealotUIDArr) do
            CallTriggerX(FP,ZSpawnCallTable[j],CV(CA_ZUID,j))
        end
        CIf(FP, {CV(ShNm,5),CV(CA_SpawnOptionV4,1)})
            CFor(FP, 0, 360, 30)
            CI = CForVariable()
            f_Lengthdir(FP, 400, CI, ZPX, ZPY)
            CAdd(FP,ZPX,CPosX)
            CAdd(FP,ZPY,CPosY)
            Simple_SetLocX(FP,"Location 1",ZPX,ZPY,ZPX,ZPY,Simple_CalcLoc(0,-32,-32,32,32))

            CTrigger(FP,{CV(CA_SpawnOptionV,1,AtLeast)},{SetV(SpawnOptionV,CA_SpawnOptionV)},1)
            CTrigger(FP,{CV(CA_SpawnOptionV2,1,AtLeast)},{SetV(SpawnOptionV2,CA_SpawnOptionV2)},1)
            for j, k in pairs(ZealotUIDArr) do
                CallTriggerX(FP,ZSpawnCallTable[j],CV(CA_ZUID,j))
            end

            CForEnd()

        CIfEnd()

        
    end
    SetCall(FP)
    local ShapeData = {
        CSMakePolygon(6, 72, 0, PlotSizeCalc(6,13), PlotSizeCalc(6,12)),
        CSMakeLine(1, 32, 0, (2048/32)-1, 0),
        CSMakeSpiral(6,0.2,0.9,32,0,(12*7)+1,0),
        CSMakeCircle(90, 2048-64, 0, 91, 1),
        CSMakeCircle(2, 1500-64, 0, 3, 1),
        CSMakeStar(5,120,150,180,PlotSizeCalc(5*2,2),0),
        CSMakeTornado(6,48,12,4,1)
    }
    CIf(FP,CD(CAXYRand,1),SetCD(CAXYRand,0))
    CMov(FP,CACX,f_CRandNum(2000, 1000,{}))
    CMov(FP,CACY,f_CRandNum(2000, 1000,{}))
    
    CIfEnd()
    CAPlot(ShapeData, FP, 181, 0, {CACX,CACY}, 1, 32, {ShNm,0,0,0,9999,1}, "CAFunc", FP, {}, {}, 1)
    CMov(FP,CACX,2048)
    CMov(FP,CACY,2048)
    CMov(FP,CA_SpawnOptionV,0)
    CMov(FP,CA_SpawnOptionV2,0)
    CMov(FP,CA_SpawnOptionV3,0)
    CMov(FP,CA_SpawnOptionV4,0)
    SetCallEnd()
end