function System()
	DoActions(FP, RemoveUnit(204, FP))
	--CMov(FP,CA_Eff_Rat,Var_TempTable[11])

	--function CA_3DAcc(Time,XY,YZ,ZX)
	--	TriggerX(FP,{Gun_Line(8,AtLeast,Time)},{
	--		Gun_SetLine(11,Add,XY),
	--		Gun_SetLine(12,Add,YZ),
	--		Gun_SetLine(13,Add,ZX),
	--	},{preserved})
	--end

	--CA_3DAcc(32840,1,1,1)
	--CA_3DAcc(80210,2,1,0)
	--CA_3DAcc(112420,2,1,1)
	--CA_3DAcc(142730,2,1,1)

CA_Eff_Rat = CreateVar2(FP,nil,nil,80000)
CA_Eff_XY = CreateVar(FP)
CA_Eff_YZ = CreateVar(FP)
CA_Eff_ZX = CreateVar(FP)
DoActionsX(FP,{
	AddV(CA_Eff_Rat,15);
	AddV(CA_Eff_XY,1);
	AddV(CA_Eff_YZ,1);
	AddV(CA_Eff_ZX,1);
})
SHLX = CreateVar2(FP,nil,nil,2048)
SHLY = CreateVar2(FP,nil,nil,2048)
CA_Create = CreateVar(FP)
	Call_CA_Effect = SetCallForward()
	function CA_Eff()
		local CA = CAPlotDataArr
		local CB = CAPlotCreateArr
		local PlayerID = CAPlotPlayerID
		CA_RatioXY(CA_Eff_Rat,186000,CA_Eff_Rat,186000)
		CA_Rotate3D(CA_Eff_XY,CA_Eff_YZ,CA_Eff_ZX)
		CMov(FP,CPosX,_Add(V(CA[8]),SHLX))
		CMov(FP,CPosY,_Add(V(CA[9]),SHLY))
		Simple_SetLocX(FP,"Location 1",CPosX,CPosY,CPosX,CPosY,Simple_CalcLoc(0,-32,-32,32,32))
		
		CIf(FP,{CV(CA_Create,0)},{
	})
	DoActions(FP, {SetMemoryW(0x666462, SetTo, 936),--Substructure Opening Hole Image SetTo 936(WarpGate Overlay)
		SetMemory(0x66EC48+(4*936), SetTo, 131),})--WarpGate Overlay Script SetTo 131(Nuclear Missile)
		


		function CreateEffUnitA(Condition,Height,Color)
			TriggerX(FP,Condition,{{
				SetMemoryB(0x66321C, SetTo, Height); -- 높이
				SetMemoryB(0x669E28+936, SetTo, Color); -- 색상
				CreateUnitWithProperties(1,204,1,FP,{energy = 100})
			}},{preserved})
		end

		CreateEffUnitA({CVar("X",CA[6],Exactly,1);},13,6)
		CreateEffUnitA({CVar("X",CA[6],Exactly,1);},14,17)
		CreateEffUnitA({CVar("X",CA[6],Exactly,2);},14,13)
		CreateEffUnitA({CVar("X",CA[6],Exactly,3);},15,16)
		CreateEffUnitA({CVar("X",CA[6],Exactly,4);},16,9)
		CreateEffUnitA({CVar("X",CA[6],Exactly,5);},17,17)
		CreateEffUnitA({CVar("X",CA[6],Exactly,6);},18,13)
		CreateEffUnitA({CVar("X",CA[6],Exactly,7);},19,9)
		CreateEffUnitA({CVar("X",CA[6],Exactly,8);},20,16)

		CIfEnd({SetMemory(0x66EC48+(4*936), SetTo, 409),SetMemoryB(0x669E28+936, SetTo, 9);})
		CA_CP = CreateVar(FP)
		CIf(FP,{CV(CA_Create,1,AtLeast)},{SetSwitch(RandSwitch,Random),SetSwitch(RandSwitch2,Random)})

		CIfEnd()
		
	end
		CAPlot(CSMakePolygon(8,256,0,9,1),FP,nilunit,0,{SHLX,SHLY},1,16,{1,0,0,0,9999,1},"CA_Eff",FP,nil,nil,{SetV(CA_Create,0)})
end