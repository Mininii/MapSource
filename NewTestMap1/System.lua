function System()
	BGMTimer = CreateVar(FP)
	BGMType = CreateVar(FP)
	BGMOnOff=CreateCcode()
	ObCcode1 = CreateCcode()
	GameStart = CreateCcode()
	CIfX(FP,{Memory(0x596A44, Exactly, 65536),CD(ObCcode1,0)})
	CTrigger(FP,{CD(BGMOnOff,0),CD(ObCcode1,0)},{SetCD(BGMOnOff,1),SetCD(ObCcode1,1),
	TSetMemory(0x6509B0,SetTo,LocalPlayerV),PlayWAV("staredit\\wav\\button3.wav"),DisplayText(StrDesign("\x04Turn \x08Off \x04BGM."),4),SetCp(FP)},1)
	CTrigger(FP,{CD(BGMOnOff,1),CD(ObCcode1,0)},{SetCD(BGMOnOff,0),SetCD(ObCcode1,1),
	TSetMemory(0x6509B0,SetTo,LocalPlayerV),PlayWAV("staredit\\wav\\button3.wav"),DisplayText(StrDesign("\x04Turn \x07On \x04BGM."),4),SetCp(FP)},1)
	CElseIfX({Memory(0x596A44, Exactly, 65536)},SetCD(ObCcode1,1))
	CElseX(SetCD(ObCcode1,0))
	CIfXEnd()
	DoActions(FP,{SetCp(FP),
	RunAIScript(P1VON),
	RunAIScript(P2VON),
	RunAIScript(P3VON),
	RunAIScript(P4VON),
	RunAIScript(P5VON),
	RunAIScript(P6VON),
	RunAIScript(P7VON),
})


	TriggerX(FP,{CD(GameStart,1),CD(BGMOnOff,0)},{SetV(BGMType,1)},{preserved})
	TriggerX(FP,{CD(GameStart,1),CD(BGMOnOff,1)},{SetV(BGMType,0)},{preserved})

	IBGM_EPD(FP, {P1,P2,P3,P4,P5,P6,P7,P9,P10,P11,P12}, BGMType, {
		{1,"staredit\\wav\\BGMFile.ogg",165*1000}
	})
	
	Cast_UnitCount()
	DoActions(FP,ModifyUnitHangarCount(5, All, 83, Force1, 64))
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
		CreateUnit(1,"Terran Beacon",3,FP),
		CreateUnit(1,"Protoss Beacon",5,FP),
		CreateUnit(1,"Zerg Beacon",4,FP),
		CreateUnitWithProperties(1,"Terran Civilian",2,Force1,{invincible = true}),
		SetCD(BCFlag,1),
		SetCountdownTimer(SetTo, 210);
	},1)
	
	DoActions2X(FP, {
		RotatePlayer({RunAIScript(P8VON),
		SetMissionObjectivesX("\x13\x07Delete \x04Key : \x04BGM \x07On\x04/\08Off\n\x13\x07All \x04Unit \x0FLoad \x04Bunker(\x08Terran Only\x04) : \x07F12 \x04Key");
	}, MapPlayers, FP);
		RotatePlayer({DisplayTextX("\x13\x1F100 \x04Billion Zealots\n\x13\x04- Made by \x08GALAXY_BURST \x04-\n\n\x13\x1FSTRCtrig \x04Assembler \x07v5.4\x04 \x04in Used \x19(つ>ㅅ<)つ\n\x13\x04Please select your Race\n\x13\x04And \x07PLEASE READ \x04Mission Objectives (F10 + J)", 4),PlayWAVX("sound\\Protoss\\Advisor\\PAdUpd01.WAV"),PlayWAVX("sound\\Misc\\UTmWht00.WAV")}, HumanPlayers, FP)
	}, 1)
	CIf(FP,{CD(BCFlag,1),Bring(Force1,AtLeast,1,"Terran Civilian",64)})
	
	for i = 0, 7 do
		TriggerX(FP,{Bring(i,AtLeast,1,"Terran Civilian",5)},{KillUnitAt(All, "Terran Civilian", 64, i),CreateUnit(1, "Protoss Probe", 2, i)},{preserved})
		TriggerX(FP,{Bring(i,AtLeast,1,"Terran Civilian",3)},{KillUnitAt(All, "Terran Civilian", 64, i),CreateUnit(1, "Terran SCV", 2, i),SetDeaths(i,SetTo,1,210)},{preserved})
		TriggerX(FP,{Bring(i,AtLeast,1,"Terran Civilian",4)},{KillUnitAt(All, "Terran Civilian", 64, i),CreateUnit(1, "Zerg Drone", 2, i)},{preserved})
	end
	CIfEnd()
	TriggerX(FP,{CountdownTimer(AtMost, 1)},{SetCD(BCFlag,0),SetCD(GameStart,1)})
	TriggerX(FP, {CountdownTimer(AtMost, 200),Bring(Force1,AtMost,0,"Terran Civilian",64)},{SetCD(BCFlag,0)})
	TriggerX(FP,{CD(BCFlag,0)},{
		RemoveUnit("Terran Beacon", FP),
		RemoveUnit("Zerg Beacon", FP),
		RemoveUnit("Protoss Beacon", FP),
		RemoveUnit("Terran Civilian", AllPlayers)})
	
	DoActions(FP, {RemoveUnit(219, FP),KillUnit("Any unit", P12),
	--ModifyUnitShields(All, ZealotUIDArr[1][1], FP, 64, 100),
	--ModifyUnitShields(All, ZealotUIDArr[2][1], FP, 64, 100),
	--ModifyUnitShields(All, ZealotUIDArr[3][1], FP, 64, 100),
	--ModifyUnitShields(All, ZealotUIDArr[4][1], FP, 64, 100),
	--ModifyUnitShields(All, ZealotUIDArr[5][1], FP, 64, 100),
	SetInvincibility(Disable, ZealotUIDArr[1][1], FP, 64),
	SetInvincibility(Disable, ZealotUIDArr[2][1], FP, 64),
	SetInvincibility(Disable, ZealotUIDArr[3][1], FP, 64),
	SetInvincibility(Disable, ZealotUIDArr[4][1], FP, 64),
	SetInvincibility(Disable, ZealotUIDArr[5][1], FP, 64),
})


CunitCtrig_Part1(FP)
HeroShieldArr={}
for j,k in pairs(HeroArr) do
	local LocAct={
		SetMemory(0x6509B0, Subtract, 4),
		SetDeaths(CurrentPlayer,SetTo,0,0),
		SetDeathsX(CurrentPlayer,SetTo,0,1,0xFF00),
		SetMemory(0x6509B0, Add, 4)
	}
	if k==19 then
		LocAct={
			SetMemory(0x6509B0, Add, 23),
			SetDeathsX(CurrentPlayer,SetTo,255,0,0xFF),
			SetMemory(0x6509B0, Subtract, 27),
			SetDeaths(CurrentPlayer,SetTo,0,0),
			SetDeathsX(CurrentPlayer,SetTo,0,1,0xFF00),
			SetMemory(0x6509B0, Add, 4)
		}
	elseif k == 17 then
		LocAct={
			SetMemory(0x6509B0, Subtract, 23),
			SetDeaths(CurrentPlayer,Add,1*256,0),
			SetMemory(0x6509B0, Add, 19),
			SetDeaths(CurrentPlayer,SetTo,0,0),
			SetDeathsX(CurrentPlayer,SetTo,0,1,0xFF00),
			SetMemory(0x6509B0, Add, 4)
		}
	end
TriggerX(FP,{DeathsX(CurrentPlayer, Exactly, k, 0, 0xFF)},LocAct,{preserved})
table.insert(HeroShieldArr,ModifyUnitShields(All, k, Force1, 64, 100))
end
ClearCalc()
CunitCtrig_Part2()
CunitCtrig_Part3X()
for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
CunitCtrig_Part4X(i,{
	DeathsX(EPDF(0x628298-0x150*i+(19*4)),AtLeast,1*256,0,0xFF00),
	DeathsX(EPDF(0x628298-0x150*i+(19*4)),AtMost,6,0,0xFF),
--	DeathsX(EPDF(0x628298-0x150*i+(0x54)),AtLeast,1*256,0,0xFF00),
},
{MoveCp(Add,25*4)})
end
CunitCtrig_End()
CMov(FP,0x6509B0,FP)
	function CA_3DAcc(Time,Type,XY,YZ,ZX)
		TriggerX(FP,{CV(CA_Eff_Rat,Time,Type)},{
			--AddV(CA_Eff_XY,XY);
			AddV(CA_Eff_YZ,YZ);
			AddV(CA_Eff_ZX,ZX);
		},{preserved})
	end

	DoActionsX(FP,{
		--AddV(CA_Eff_Rat,15);
		AddV(CA_Eff_XY,1);
		AddV(CA_Eff_YZ,2);
		AddV(CA_Eff_ZX,2);
	})
	Trigger2X(FP, {CD(GameStart,1),Bring(Force1, AtMost, 0, "Any unit", 7)},{RotatePlayer({DisplayTextX("\x08Game Over")}, HumanPlayers, FP),RotatePlayer({Defeat()}, MapPlayers, FP)})
	--CA_3DAcc(32840,AtLeast,2,2,2)
	--CA_3DAcc(112420,AtLeast,2,1,1)
	--CA_3DAcc(142730,AtLeast,3,1,1)
	--CA_3DAcc(186000,AtLeast,4,1,1)
	--CA_3DAcc(186000+28000,AtLeast,5,1,1)
	--CA_3DAcc(186000+67000,AtLeast,6,1,1)
	--CA_3DAcc(186000+138000,AtLeast,10,1,1)
	CA_Eff_Mode = CreateCcode()
	GameTime = CreateCcode()
	CA_XY_Mode = CreateCcode()
	CA_XY_Var = CreateVar(FP)
	CAdd(FP,CA_Eff_XY,1)
	CAdd(FP,CA_Eff_XY,_Div(CA_XY_Var,100))
	TriggerX(FP,{CD(CA_XY_Mode,1),CV(CA_XY_Var,0,AtMost)},{SetCD(CA_XY_Mode,0)},{preserved})
	TriggerX(FP,{CD(CA_XY_Mode,0),CV(CA_XY_Var,3500,AtLeast)},{SetCD(CA_XY_Mode,1)},{preserved})
	TriggerX(FP,{CD(CA_XY_Mode,1),CD(GameStart,1)},{SubV(CA_XY_Var,1)},{preserved})
	TriggerX(FP,{CD(CA_XY_Mode,0),CD(GameStart,1)},{AddV(CA_XY_Var,1)},{preserved})


	TriggerX(FP,{CD(CA_Eff_Mode,1),CV(CA_Eff_Rat,20000,AtMost)},{SetCD(CA_Eff_Mode,0)},{preserved})
	TriggerX(FP,{CD(CA_Eff_Mode,0),CV(CA_Eff_Rat,372000,AtLeast)},{SetCD(CA_Eff_Mode,1)},{preserved})
	TriggerX(FP,{CD(CA_Eff_Mode,1),CD(GameStart,1)},{SubV(CA_Eff_Rat,120)},{preserved})
	TriggerX(FP,{CD(CA_Eff_Mode,0),CD(GameStart,1)},{AddV(CA_Eff_Rat,120)},{preserved})
	TriggerX(FP,{CD(GameStart,1)},{AddCD(GameTime,1)},{preserved})
	ZSVar2=CreateVar(FP)
	ZSVar3=CreateVar(FP)
	ZSVar = CreateVar(FP)
	Waves = {10,20,30,50,100,350,700,1400,2800,5600,13000,19000,28000,46000,80000,175000,280000,400000,730000,1000000,1600000,2700000,3800000,5000000,6790000,8500000,13800000,20000000,29000000,35600000,50000000,66666666,78000000,100000000,127650000,200150000,376800000,500000000,695600000,832479000,1000000000}
	for j, k in pairs(Waves) do
		if j==#Waves then
			Trigger2X(FP,{CD(GameStart,1),CD(GameTime,(j-1)*(35*24),AtLeast)},{SetV(ZSVar,k),RotatePlayer({DisplayTextX("\x04[Wave "..j.."(End)] : "..(k*24).." Zealot/s",4)}, HumanPlayers, FP)})
		else
			Trigger2X(FP,{CD(GameStart,1),CD(GameTime,(j-1)*(35*24),AtLeast)},{SetV(ZSVar,k),RotatePlayer({DisplayTextX("\x04[Wave "..j.."] : "..(k*24).." Zealot/s",4)}, HumanPlayers, FP)})
		end
		end
	CTrigger(FP,{CD(GameStart,1)},{AddV(ZSVar2,ZSVar)},1)
	CIf(FP,{CV(ZSVar2,100000000,AtLeast)})
		CAdd(FP,ZSVar3,_Div(ZSVar2,100000000))
		f_Mod(FP,ZSVar2,100000000)
	CIfEnd()
--	Call_CA_Effect = SetCallForward()
	if TestMode == 1 then
		
	CMov(FP,0x57f120,CA_Eff_Rat)
		--f_LMov(FP,KillW,_LAdd(KillW,"1000000000"))
		DoActions(FP,{SetResources(AllPlayers,SetTo,0x44444444,OreAndGas)},1)
	--	DoActions(FP, {Simple_SetLoc(0,3000,3000,3000,3000),
	--	CreateUnit(1,ZealotUIDArr[1][1],1,FP),
	--	CreateUnit(1,ZealotUIDArr[2][1],1,FP),
	--	CreateUnit(1,ZealotUIDArr[3][1],1,FP),
	--	CreateUnit(1,ZealotUIDArr[4][1],1,FP),
	--	CreateUnit(1,ZealotUIDArr[5][1],1,FP),
	--},1)
		
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
	DoActions(FP, {
		--0x666160+(2*)
		--SetMemoryW(0x666462, SetTo, 396),--Substructure Opening Hole Image SetTo 396(Khaydarin Crystal)
		SetMemory(0x66EC48+(4*396), SetTo, 131),})--Khaydarin Crystal Script SetTo 131(Nuclear Missile)
		


		function CreateEffUnitA(Condition,Height,Color)
			TriggerX(FP,Condition,{{
				SetMemoryB(0x66321C, SetTo, Height); -- 높이
				SetMemoryB(0x669E28+396, SetTo, Color); -- 색상
				CreateUnitWithProperties(1,219,1,FP,{energy = 100})
			}},{preserved})
		end

		CreateEffUnitA({CVar("X",CA[6],Exactly,1);},13,15)
		CreateEffUnitA({CVar("X",CA[6],Exactly,2);},14,16)
		CreateEffUnitA({CVar("X",CA[6],Exactly,3);},15,13)
		CreateEffUnitA({CVar("X",CA[6],Exactly,4);},16,17)
		CreateEffUnitA({CVar("X",CA[6],Exactly,5);},17,15)
		CreateEffUnitA({CVar("X",CA[6],Exactly,6);},18,16)
		CreateEffUnitA({CVar("X",CA[6],Exactly,7);},19,13)
		CreateEffUnitA({CVar("X",CA[6],Exactly,8);},20,17)

		for j = 1, #ZealotUIDArr-1 do
			CZNJ=def_sIndex()
			NJumpEnd(FP,CZNJ)
			NIf(FP,{CV(ZSVar3,  0,AtMost),TCVar("X",CA[6],Exactly,NextPoint[j]);CVar("X",CA[6],AtMost,8);Memory(0x628438,AtLeast,1),CV(Zcount,700,AtMost),CD(GameStart,1),CV(ZSVar2,  100^(j-1),AtLeast)},{SubV(ZSVar2,100^(j-1)),AddV(NextPoint[j],1)})
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
	
DoActions(FP,HeroShieldArr)
WinCD=CreateCcode()
CTrigger(FP,{TTCWar(FP,KillW[2],AtLeast,"1000000000000")},{
	SetCD(WinCD,1);
	KillUnit("Any unit",FP);
})
Trigger2X(FP,{CD(WinCD,1)},{
	RotatePlayer({DisplayTextX("\x13\x04You Are \x1F100 \x04Billion Zealots \x08SLAYER\n\n\x13\x08C \x0EO \x1FN \x11G \x1DR \x1BA \x17T \x16U \x18L \x10A \x0FT \x1CI \x04O \x07N \x0BS\n\n\x13\x04- Made by \x08GALAXY_BURST \x04-\n\n\x13\x1FSTRCtrig \x04Assembler \x07v5.4\x04 \x04in Used \x19(つ>ㅅ<)つ\n", 4),PlayWAVX("sound\\Misc\\UTmWht00.WAV"),PlayWAVX("sound\\Misc\\UTmWht00.WAV"),PlayWAVX("sound\\Misc\\UTmWht00.WAV")}, HumanPlayers, FP);
	RotatePlayer({Victory()}, MapPlayers, FP);
})
end