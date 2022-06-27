function System()
	Cast_UnitCount()
	DoActions(FP,{SetResources(AllPlayers,SetTo,0x44444444,OreandGas)},1)
	for i = 1, 5 do
	UnitReadX(FP, FP, ZealotUIDArr[i][1], 64, 	ZcountT[i])
	end
	CMov(FP,Zcount,0)
	CAdd(FP,Zcount,ZcountT[1])
	CAdd(FP,Zcount,ZcountT[2])
	CAdd(FP,Zcount,ZcountT[3])
	CAdd(FP,Zcount,ZcountT[4])
	CAdd(FP,Zcount,ZcountT[5])
	DoActionsX(FP, {
		CreateUnit(1,"Terran Beacon","T",FP),
		CreateUnit(1,"Protoss Beacon","P",FP),
		CreateUnit(1,"Zerg Beacon","Z",FP),
		CreateUnitWithProperties(1,"Terran Civilian","Center",Force1,{invincible = true}),
		SetCD(BCFlag,1),
		SetCountdownTimer(SetTo, 210);
	},1)
	
	DoActions2X(FP, {
		RotatePlayer({RunAIScript(P8VON)}, MapPlayers, FP);
		RotatePlayer({DisplayTextX("\x13\x1F100 \x04Billion Zealots\n\x13\x04- Made by \x08GALAXY_BURST \x04-\n\n\x13\x1FSTRCtrig \x04Assembler \x07v5.4\x04 \x04in Used \x19(つ>ㅅ<)つ\n\n\x13\x04Please select your Race\n", 4),PlayWAVX("sound\\Protoss\\Advisor\\PAdUpd01.WAV"),PlayWAVX("sound\\Misc\\UTmWht00.WAV")}, HumanPlayers, FP)
	}, 1)
	CIf(FP,{CD(BCFlag,1),Bring(Force1,AtLeast,1,"Terran Civilian",64)})
	
	for i = 0, 7 do
		TriggerX(FP,{Bring(i,AtLeast,1,"Terran Civilian","P")},{KillUnitAt(All, "Terran Civilian", 64, i),CreateUnit(1, "Protoss Probe", "Center", i)},{preserved})
		TriggerX(FP,{Bring(i,AtLeast,1,"Terran Civilian","T")},{KillUnitAt(All, "Terran Civilian", 64, i),CreateUnit(1, "Terran SCV", "Center", i)},{preserved})
		TriggerX(FP,{Bring(i,AtLeast,1,"Terran Civilian","Z")},{KillUnitAt(All, "Terran Civilian", 64, i),CreateUnit(1, "Zerg Drone", "Center", i)},{preserved})
	end
	CIfEnd()
	GameStart = CreateCcode()
	TriggerX(FP,{CountdownTimer(AtMost, 1)},{SetCD(BCFlag,0),SetCD(GameStart,1)})
	TriggerX(FP, {CountdownTimer(AtMost, 200),Bring(Force1,AtMost,0,"Terran Civilian",64)},{SetCD(BCFlag,0)})
	TriggerX(FP,{CD(BCFlag,0)},{
		RemoveUnit("Terran Beacon", FP),
		RemoveUnit("Zerg Beacon", FP),
		RemoveUnit("Protoss Beacon", FP),
		RemoveUnit("Terran Civilian", AllPlayers)})
	
	DoActions(FP, {RemoveUnit(204, FP),RemoveUnit("Any unit", P12),ModifyUnitShields(All, "Men", FP, 64, 100)})

	
	function CA_3DAcc(Time,Type,XY,YZ,ZX)
		TriggerX(FP,{CV(CA_Eff_Rat,Time,Type)},{
			AddV(CA_Eff_XY,XY);
			AddV(CA_Eff_YZ,YZ);
			AddV(CA_Eff_ZX,ZX);
		},{preserved})
	end

	DoActionsX(FP,{
		--AddV(CA_Eff_Rat,15);
		AddV(CA_Eff_XY,1);
		AddV(CA_Eff_YZ,1);
		AddV(CA_Eff_ZX,1);
	})
	Trigger2X(FP, {CD(GameStart,1),Bring(Force1, AtMost, 0, "Any unit", 7)},{RotatePlayer({DisplayTextX("\x08Game Over")}, HumanPlayers, FP),RotatePlayer({Defeat()}, MapPlayers, FP)})
	--CA_3DAcc(32840,AtLeast,2,2,2)
	CA_3DAcc(112420,AtLeast,2,1,1)
	CA_3DAcc(142730,AtLeast,3,1,1)
	CA_3DAcc(186000,AtLeast,4,1,1)
	CA_3DAcc(186000+28000,AtLeast,5,1,1)
	CA_3DAcc(186000+67000,AtLeast,6,1,1)
	CA_3DAcc(186000+138000,AtLeast,10,1,1)
	CA_Eff_Mode = CreateCcode()
	GameTime = CreateCcode()
	CMov(FP,0x57f120,CA_Eff_Rat)
	TriggerX(FP,{CD(CA_Eff_Mode,1),CV(CA_Eff_Rat,80000,AtMost)},{SetCD(CA_Eff_Mode,0)},{preserved})
	TriggerX(FP,{CD(CA_Eff_Mode,0),CV(CA_Eff_Rat,372000,AtLeast)},{SetCD(CA_Eff_Mode,1)},{preserved})
	TriggerX(FP,{CD(CA_Eff_Mode,1),CD(GameStart,1)},{SubV(CA_Eff_Rat,120)},{preserved})
	TriggerX(FP,{CD(CA_Eff_Mode,0),CD(GameStart,1)},{AddV(CA_Eff_Rat,120)},{preserved})
	TriggerX(FP,{CD(GameStart,1)},{AddCD(GameTime,1)},{preserved})
	ZSVar2=CreateVar(FP)
	ZSVar3=CreateVar(FP)
	ZSVar = CreateVar(FP)
	Waves = {1,2,5,10,20,30,50,100,120,130,150,200,300,500,1000,1200,2000,3000,5000,8000,10000,13800,27600,56900,130000,280000,870000,1900000,2890000,5000000,10000000}
	for j, k in pairs(Waves) do
		Trigger2X(FP,{CD(GameStart,1),CD(GameTime,(j-1)*(90*24),AtLeast)},{SetV(ZSVar,k),RotatePlayer({DisplayTextX("\x04[Wave "..j.."] : "..(k*24).." Zealot/s",4)}, HumanPlayers, FP)})
	end
	CTrigger(FP,{CD(GameStart,1)},{AddV(ZSVar2,ZSVar)},1)
	TriggerX(FP,{CV(ZSVar2,100000000,AtLeast)},{AddV(ZSVar3,1),SubV(ZSVar2, 100000000)},{preserved})
--	Call_CA_Effect = SetCallForward()
	if TestMode == 1 then
		DoActions(FP, {Simple_SetLoc(0,3000,3000,3000,3000),
		CreateUnit(1,ZealotUIDArr[1][1],1,FP),
		CreateUnit(1,ZealotUIDArr[2][1],1,FP),
		CreateUnit(1,ZealotUIDArr[3][1],1,FP),
		CreateUnit(1,ZealotUIDArr[4][1],1,FP),
		CreateUnit(1,ZealotUIDArr[5][1],1,FP),
	},1)
		
	end
NextPoint= CreateVarArr(5, FP)
	DoActionsX(FP, {
		SetV(NextPoint[1],1),
		SetV(NextPoint[2],1),
		SetV(NextPoint[3],1),
		SetV(NextPoint[4],1),
		SetV(NextPoint[5],1),
	},1)
	function CA_Eff()
		local CA = CAPlotDataArr
		local CB = CAPlotCreateArr
		local PlayerID = CAPlotPlayerID
		CA_RatioXY(CA_Eff_Rat,186000/3,CA_Eff_Rat,186000/3)
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

		CreateEffUnitA({CVar("X",CA[6],Exactly,1);},13,15)
		CreateEffUnitA({CVar("X",CA[6],Exactly,2);},14,15)
		CreateEffUnitA({CVar("X",CA[6],Exactly,3);},15,15)
		CreateEffUnitA({CVar("X",CA[6],Exactly,4);},16,15)
		CreateEffUnitA({CVar("X",CA[6],Exactly,5);},17,15)
		CreateEffUnitA({CVar("X",CA[6],Exactly,6);},18,15)
		CreateEffUnitA({CVar("X",CA[6],Exactly,7);},19,15)
		CreateEffUnitA({CVar("X",CA[6],Exactly,8);},20,15)

		for j = 1, #ZealotUIDArr-1 do
			CZNJ=def_sIndex()
			NJumpEnd(FP,CZNJ)
			NIf(FP,{TCVar("X",CA[6],Exactly,NextPoint[j]);CVar("X",CA[6],AtMost,8);Memory(0x628438,AtLeast,1),CV(Zcount,700,AtMost),CD(GameStart,1),CV(ZSVar2,  100^(j-1),AtLeast)},{SubV(ZSVar2,100^(j-1)),AddV(NextPoint[j],1)})
				f_Read(FP, 0x628438, nil, Nextptrs)
				CDoActions(FP, {
					SetMemoryB(0x669E28+151, SetTo, ZealotUIDArr[j][3]);
					CreateUnitWithProperties(1,ZealotUIDArr[j][1],1,FP,{energy = 100}),
					SetMemoryB(0x669E28+151, SetTo, 0);

				TSetDeaths(_Add(Nextptrs,13),SetTo,ZealotUIDArr[j][2],0),
				TSetDeathsX(_Add(Nextptrs,18),SetTo,ZealotUIDArr[j][2],0,0xFFFF),
				TSetMemoryX(_Add(Nextptrs,8),SetTo,127*65536,0xFF0000),
				TSetMemoryX(_Add(Nextptrs,9),SetTo,0,0xFF000000),
				TSetMemoryX(_Add(Nextptrs,55),SetTo,0xA00000,0xA00000),
			})
			NJump(FP,CZNJ,{CV(NextPoint[j],8,AtMost)})
			NIfEnd()
			TriggerX(FP,{CV(NextPoint[j],9,AtLeast)},{SetV(NextPoint[j],1)},{preserved})
		end
		CZNJ=def_sIndex()
		NJumpEnd(FP,CZNJ)
		NIf(FP,{TCVar("X",CA[6],Exactly,NextPoint[5]),Memory(0x628438,AtLeast,1),CV(Zcount,700,AtMost),CD(GameStart,1),CV(ZSVar3,  1,AtLeast)},{SubV(ZSVar3,1),AddV(NextPoint[5],1)})
			f_Read(FP, 0x628438, nil, Nextptrs)
			CDoActions(FP, {
				SetMemoryB(0x669E28+151, SetTo, ZealotUIDArr[5][3]);
				CreateUnitWithProperties(1,ZealotUIDArr[5][1],1,FP,{energy = 100}),
				SetMemoryB(0x669E28+151, SetTo, 0);
			TSetDeaths(_Add(Nextptrs,13),SetTo,ZealotUIDArr[5][2],0),
			TSetDeathsX(_Add(Nextptrs,18),SetTo,ZealotUIDArr[5][2],0,0xFFFF),
			TSetMemoryX(_Add(Nextptrs,8),SetTo,127*65536,0xFF0000),
			TSetMemoryX(_Add(Nextptrs,9),SetTo,0,0xFF000000),
			TSetMemoryX(_Add(Nextptrs,55),SetTo,0xA00000,0xA00000),
		})

		NJump(FP,CZNJ,{CV(NextPoint[5],8,AtMost)})
		NIfEnd()
		TriggerX(FP,{CV(NextPoint[5],9,AtLeast)},{SetV(NextPoint[5],1)},{preserved})


		CIfEnd({SetMemory(0x66EC48+(4*936), SetTo, 409),SetMemoryB(0x669E28+936, SetTo, 9);})
		CA_CP = CreateVar(FP)
		CIf(FP,{CV(CA_Create,1,AtLeast)},{SetSwitch(RandSwitch,Random),SetSwitch(RandSwitch2,Random)})

		CIfEnd()
		
	end
		CAPlot(CSMakePolygon(8,256,0,9,1),FP,nilunit,0,{SHLX,SHLY},1,16,{1,0,0,0,9999,1},"CA_Eff",FP,nil,nil,{SetV(CA_Create,0)})
		AIT=CreateCcode()
		DoActionsX(FP, AddCD(AIT,1))
		TriggerX(FP,{CD(AIT,4,AtLeast)},{SetCD(AIT,0)},{preserved})
		TriggerX(FP,{CD(GameStart,1),CD(AIT,0)},{SetCp(FP),RunAIScript("Send All Units on Random Suicide Missions")},{preserved})


		local KillReadTemp = CreateVar(FP)
		local KillCalcTemp = CreateWar(FP)

		for j=1, 5 do
			CIf(FP,Deaths(FP,AtLeast,1,ZealotUIDArr[j][1]))
				f_Read(FP, 0x58A364+(ZealotUIDArr[j][1]*48)+(FP*4), KillReadTemp)
				if j==1 then
					f_LMov(FP,KillCalcTemp,{KillReadTemp,0},nil,nil,1)
				else
					f_LMul(FP,KillCalcTemp, {KillReadTemp,0}, {100^(j-1),0})
				end
				f_LMov(FP,KillW,_LAdd(KillW,KillCalcTemp))
				DoActions(FP,{SetDeaths(FP, SetTo, 0, ZealotUIDArr[j][1])})
			CIfEnd()
		end
	

WinCD=CreateCcode()
CTrigger(FP,{TTCWar(FP,KillW[2],AtLeast,"100000000000")},{
	SetCD(WinCD,1);
})
Trigger2X(FP,{CD(WinCD,1)},{
	RotatePlayer({DisplayTextX("\x13\x04You Are \x1F100 \x04Billion Zealots \x08SLAYER\n\n\x13\x08C \x0EO \x1FN \x11G \x1DR \x1BA \x17T \x16U \x18L \x10A \x0FT \x1CI \x04O \x07N\n\n\x13\x04- Made by \x08GALAXY_BURST \x04-\n\n\x13\x1FSTRCtrig \x04Assembler \x07v5.4\x04 \x04in Used \x19(つ>ㅅ<)つ\n", 4),PlayWAVX("sound\\Misc\\UTmWht00.WAV"),PlayWAVX("sound\\Misc\\UTmWht00.WAV"),PlayWAVX("sound\\Misc\\UTmWht00.WAV")}, HumanPlayers, FP);
	RotatePlayer({Victory()}, MapPlayers, FP);
})
end