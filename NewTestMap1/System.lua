function System()
	BGMTimer = CreateVar(FP)
	BGMType = CreateVar(FP)
	BGMOnOff=CreateCcode()
	ObCcode1 = CreateCcode()
	GameStart = CreateCcode()
	GameStart2 = CreateCcode()
	CurrentOP = CreateVar(FP)
	EffBGMV = CreateVar(FP)
	EffBGMVRecive = CreateVar(FP)
	local Dx,Dy,Dv,Du,DtP = CreateVariables(5)
	PattT=CreateCcodeArr(50)
	MoveOrder=CreateCcode()
	SuiOrderCancel=CreateCcode()
	
	DoActionsX(FP,{
		--AddV(CA_Eff_Rat,15);
		AddV(CA_Eff_XY,1);
		AddV(CA_Eff_YZ,2);
		AddV(CA_Eff_ZX,3);
	})
	DoActions(FP, {RemoveUnit(219, FP),RemoveUnit("Protoss Zealot", FP),KillUnit("Any unit", P12),
	--ModifyUnitShields(All, ZealotUIDArr[1][1], FP, 64, 100),
	--ModifyUnitShields(All, ZealotUIDArr[2][1], FP, 64, 100),
	--ModifyUnitShields(All, ZealotUIDArr[3][1], FP, 64, 100),
	--ModifyUnitShields(All, ZealotUIDArr[4][1], FP, 64, 100),
	--ModifyUnitShields(All, ZealotUIDArr[5][1], FP, 64, 100),
	SetInvincibility(Disable, ZealotUIDArr[1][1], Force2, 64),
	SetInvincibility(Disable, ZealotUIDArr[2][1], Force2, 64),
	SetInvincibility(Disable, ZealotUIDArr[3][1], Force2, 64),
	SetInvincibility(Disable, ZealotUIDArr[4][1], Force2, 64),
	SetInvincibility(Disable, ZealotUIDArr[5][1], Force2, 64),
})

	f_Read(FP,0x51CE8C,Dx)
	CiSub(FP,Dy,_Mov(0xFFFFFFFF),Dx)
	CiSub(FP,DtP,Dy,Du)
	CMov(FP,Dv,DtP) 
	CMov(FP,Du,Dy)
	CTrigger(FP,{CD(GameStart2,1)},{AddV(EffBGMV,DtP)},1)

	
    CIfX(FP,Never()) -- 상위플레이어 단락 시작
	for i = 0, 3 do
        CElseIfX(HumanCheck(i,1),{SetCVar(FP,CurrentOP[2],SetTo,i)})
		SendArr = {
			1260,--1
			8840,--2
			9780,--3
			10730,--4
			11680,--5
			12630,--6
			13570,--7
			14520,--8
			15470,--9
			16420,--10
			17360,--11
			18310,--12
			19260,--13
			20210,--14
			21150,--15
			22100,--16
			23050,--17
			24000,--18
			24940,--19
			25890,--20
			26840,------------21
			27780,--22
			28730,--23
			29680,--24
			
			31570,--25
			32520,
			33470,
			34420,
			35360,
			36310,
			37260,--31
			39150,--32
			40150,--33
			41050,--34
			42000,--35
			42940,--36
			43890,--37
			44840,--38
			45780,
			46730,
			47680,
			48630,
			49570,------------------------
			50520,
			51470,
			52420,
			53360,----47
			54310,--48
			55260,
			55570,
			55890,
			56210,
			57470,
			57630,
			57780,
			57940,
			58100,
			59360,
			59680,
			60000,

			61260,
			61420,
			61570,
			61730,
			61890,
			62520,
			62840,
			63150,
			63470,
			63780,

			64730,
			64890,
			65050,
			65210,
			65360,
			65520,
			65680,
			66150,
			66630,
			66940,
			67260,
			67570, ---
			68050,
			68210, ---84
			68520,
			68840,
			69150,-- 87
			69470, --88
			70420,
			71360,
			72310,
			73260,--92
			73570,
			73890,
			74210,
			74520,
			74840,
			75150,
			76100,--99
			76340,
			76570,
			76810,
			77050,--103
			77680,
			78000,
			78310,
			78630,
			78940,
			79260,
			79570,
			79890,
			80520,
			80840,--113
			81780,--114
			82420,
			82730,
			83680,
			84630,---118
			85570,
			86520,
			87470,
			88420,
			89360,
			90310,
			91260,--125



		}
		DoActions(FP,{SetMemory(0x58F500,SetTo,0)})
		for j, k in pairs(SendArr) do
			--if k == 69150 then PushErrorMsg(j) end
			TriggerX(FP,{CV(EffBGMV,k,AtLeast)},{SetMemory(0x58F500, SetTo, j)})
		end
		
		CIf(FP,{Memory(0x58A364+(48*181)+(4*i), AtLeast, 1)})
        f_Read(FP,0x58A364+(48*181)+(4*i),EffBGMVRecive) -- MSQC val Recive. 181
		DoActions(FP, {SetMemory(0x58A364+(48*181)+(4*i),SetTo,0)})
		CIfEnd()
	end
    CIfXEnd()
	
Warp1 = {}
for i=0, 15 do
   table.insert(Warp1,CSMakeCircle(6+(6*i),32+(32*i),0,7+(6*i),1))
end
Warp1 = CS_CropXY(CS_OverlapX(table.unpack(Warp1)),{-2048,2048},{-2048,2048})
	ObEffCA = CAPlotForward()
	function ObEffCAFunc()
		local CA = CAPlotDataArr
		local CB = CAPlotCreateArr
		local PlayerID = CAPlotPlayerID
		CA_Rotate3D(CA_Eff_XY,CA_Eff_YZ,CA_Eff_ZX)
		--CMov(FP,CPosX,V(CA[8]),2048)
		--CMov(FP,CPosY,V(CA[9]),2048)
		--Simple_SetLocX(FP,"Location 1",CPosX,CPosY,CPosX,CPosY,Simple_CalcLoc(0,-32,-32,32,32))
        --CallTriggerX(FP,ZSpawnCallTable[1],{})
		
	end
	 CAPlot(Warp1, FP, 94, 0, {2048,2048}, 1, 32, {1,0,0,0,15,#Warp1}, "ObEffCAFunc", FP, {CD(PattT[1],1)}, {GiveUnits(All,94,FP,64,P12)})
	
	
	CIf(FP,{CD(GameStart2,1),CD(PattT[1],0)})
	TriggerX(FP,{CV(EffBGMVRecive,1)},{SetCD(PattT[1],1),SetV(V(ObEffCA[6]),1),SetMinimapColor(P8, SetTo, 53),SetPlayerColor(P8, SetTo, 53)})
	Trigger2X(FP,{CD(PattT[1],0)},{RemoveUnit(ZealotUIDArr[1][1], ZealotUIDArr[2][4])},{preserved})
	P1V=CreateVar(FP)
	
	CFor(FP,0,360,4)
	CI=CForVariable()
	f_Lengthdir(FP, _Sub(_Mov(2000),P1V), CI, CPosX, CPosY)
	Simple_SetLocX(FP, 0, CPosX, CPosY ,CPosX, CPosY,Simple_CalcLoc(0, 2048, 2048, 2048, 2048))
	CDoActions(FP, {SetV(SpawnOptionV,_Mul(_Add(CI,1),50))})
	CallTriggerX(FP,ZSpawnCallTable[1],{},{})
	CForEnd()
	CAdd(FP,P1V,36)
	CIfEnd()
	TriggerX(FP,{CV(EffBGMVRecive,2)},{SetV(V(ObEffCA[6]),1),SetMinimapColor(P8, SetTo, 128),SetPlayerColor(P8, SetTo, 128)})
	
	
	PattPT = {7,6,5,7,6,5,4}
	for i = 0, 6 do
		CallTriggerX(FP, Call_CAPlot, {CV(EffBGMVRecive,2+i)}, {
			SetV(CARX,2000),
			SetV(CARY,2000),
			SetV(CARo,10*i),
			SetV(ShNm,1),
			SetV(CA_ZUID,1),
			SetV(CA_SpawnOptionV,6000),
			SetV(CA_SpawnOptionV2,PattPT[i+1])
		}, 1)
	end
	TriggerX(FP,{CV(EffBGMVRecive,9)},{SetCD(PattT[2],1),SetV(V(ObEffCA[6]),1),SetMinimapColor(P8, SetTo, 129),SetPlayerColor(P8, SetTo, 129)})
	CIf(FP,{CD(GameStart2,1),CD(PattT[2],1)})
	TriggerX(FP,{CV(EffBGMVRecive,10)},{SetCD(PattT[2],0)})
	Trigger2X(FP,{CD(PattT[2],1)},{RemoveUnit(ZealotUIDArr[2][1], ZealotUIDArr[2][4])},{preserved})
	P1V=CreateVar(FP)
	
	CFor(FP,0,360,4)
	CI=CForVariable()
	f_Lengthdir(FP, _Sub(_Mov(2000),P1V), CI, CPosX, CPosY)
	Simple_SetLocX(FP, 0, CPosX, CPosY ,CPosX, CPosY,Simple_CalcLoc(0, 2048, 2048, 2048, 2048))
	CDoActions(FP, {SetV(SpawnOptionV,_Mul(_Add(CI,1),50))})
	CallTriggerX(FP,ZSpawnCallTable[2],{},{})
	CForEnd()
	CAdd(FP,P1V,36)
	CIfEnd()

	CSPlot(CSMakeCircle(90, 2048-64, 0, 91, 1), P5, 128, 0, {2048,2048}, 1, 32, FP, {Label(),CV(EffBGMVRecive,10)})
	PattPT = {7,6,5,7,6,5,7,6,5,7,6,5,7,6,5,7,6,5}
	for i = 10, 24 do
		CallTriggerX(FP, Call_CAPlot, {CV(EffBGMVRecive,i)}, {
			SetV(CARX,2000),
			SetV(CARY,2000),
			SetV(CARo,24*(i-10)),
			SetV(ShNm,2),
			SetV(CA_ZUID,1),
			SetV(CA_SpawnOptionV,4000),
			SetV(CA_SpawnOptionV2,PattPT[i-9])
		}, 1)
	end
	TriggerX(FP,{CV(EffBGMVRecive,24)},{KillUnit(128,P5)})

	TriggerX(FP,{CV(EffBGMVRecive,21)},{SetV(V(ObEffCA[6]),1),SetMinimapColor(P8, SetTo, 199),SetPlayerColor(P8, SetTo, 199)})
	TriggerX(FP,{CV(EffBGMVRecive,24)},{SetCD(PattT[3],1)})

	TriggerX(FP,{CV(EffBGMVRecive,25)},{SetCD(SuiOrderCancel,1),SetCD(MoveOrder,1)})


	PattPT = {7,6,5,7,6,5}
	for i = 0, 5 do
		CallTriggerX(FP, Call_CAPlot, {CV(EffBGMVRecive,25+i)}, {
			SetV(CARX,2000),
			SetV(CARY,2000),
			SetV(CARo,0),
			SetV(ShNm,3),
			SetV(CA_ZUID,2),
			SetV(CA_SpawnOptionV,12000),
			SetCD(CAXYRand,1),
			SetV(CA_SpawnOptionV2,PattPT[i+1])
		}, 1)
	end
	TriggerX(FP,{CV(EffBGMVRecive,31)},{SetCD(MoveOrder,0),RotatePlayer({RunAIScriptAt(JYD,64)}, {P5,P6,P7,P8},FP)})
	TriggerX(FP,{CV(EffBGMVRecive,32)},{SetV(V(ObEffCA[6]),1),SetCD(SuiOrderCancel,0),SetCD(MoveOrder,0)})




	CSPlot(CSMakeCircle(90, 2048-64, 0, 91, 1), P5, 128, 0, {2048,2048}, 1, 32, FP, {Label(),CV(EffBGMVRecive,32)})
	PattPT = {7,6,5,7,6,5,7,6,5,7,6,5,7,6,5,7,6,5}
	for i = 0, 14 do
		CallTriggerX(FP, Call_CAPlot, {CV(EffBGMVRecive,32+i)}, {
			SetV(CARX,2000),
			SetV(CARY,2000),
			SetV(CARo,(360-(24*(i-10)))+96),
			SetV(ShNm,2),
			SetV(CA_ZUID,2),
			SetV(CA_SpawnOptionV,4000),
			SetV(CA_SpawnOptionV2,PattPT[i+1])
		}, 1)
	end
	TriggerX(FP,{CV(EffBGMVRecive,43)},{SetV(V(ObEffCA[6]),1),SetMinimapColor(P8, SetTo, 129),SetPlayerColor(P8, SetTo, 129)})

	TriggerX(FP,{CV(EffBGMVRecive,47)},{KillUnit(128,P5)})
	for i = 1, 4 do
		CallTriggerX(FP, Call_CAPlot, {CV(EffBGMVRecive,47)}, {
			SetV(CARX,2000),
			SetV(CARY,2000),
			SetV(CARo,0),
			SetV(ShNm,4),
			SetV(CA_ZUID,2),
			SetV(CA_SpawnOptionV,3000+(i*1200)),
			SetV(CA_SpawnOptionV2,4)
		}, 1)
	end

	TriggerX(FP,{CV(EffBGMVRecive,48)},{SetCD(PattT[4],1)})
	TriggerX(FP,{CV(EffBGMVRecive,88)},{SetCD(PattT[4],0),SetCD(PattT[5],1)})
	TriggerX(FP,{CV(EffBGMVRecive,89)},{SetCD(PattT[4],0),SetCD(PattT[6],1)})
	CallTriggerX(FP, Call_CAPlot, {CD(PattT[4],1)}, {
		SetV(CARX,2000),
		SetV(CARY,2000),
		SetV(CARo,0),
		SetV(ShNm,5),
		SetV(CA_ZUID,2),
		SetV(CA_SpawnOptionV,6500),
		SetV(CA_SpawnOptionV2,7),
		SetV(CA_SpawnOptionV3,1)
	})
	


PattPT = {4,5,6,7,4,5,6,7,4,5,6,7,4,5,6,7,4,5,6,7,4,5,6,7,4,5,6,7,4,5,6,7,4,5,6,7,4,5,6,7,4,5,6,7,4,5,6,7,4,5,6,7,4,5,6,7,4,5,6,7,4,5,6,7,4,5,6,7,4,5,6,7,4,5,6,7,4,5,6,7,4,5,6,7}
	
for i = 0,39 do
	if i~= 36 then
		CallTriggerX(FP, Call_CAPlot, {CV(EffBGMVRecive,48+i)}, {
			SetV(CARX,2000),
			SetV(CARY,2000),
			SetV(CARo,0),
			SetV(ShNm,5),
			SetV(CA_ZUID,2),
			SetV(CA_SpawnOptionV,6500),
			SetV(CA_SpawnOptionV2,PattPT[i+1]),
			SetV(CA_SpawnOptionV3,1),
			SetV(CA_SpawnOptionV4,1)
		},1)
	end
end

LI = CreateVar(FP)
LI2 = CreateVar(FP)
TriggerX(FP,{CV(EffBGMVRecive,90)},{SetV(LI,0)})
TriggerX(FP,{CV(EffBGMVRecive,91)},{SetV(LI2,0)})
TriggerX(FP,{CV(EffBGMVRecive,114)},{SetV(LI,0)})
TriggerX(FP,{CV(EffBGMVRecive,113)},{SetV(LI2,0)})
CIf(FP,{CD(PattT[5],1),CV(LI,360,AtMost)},{AddV(LI,15)})
CFor(FP, 0, 2000, 200)
CI=CForVariable()
f_Lengthdir(FP, CI, LI, CPosX, CPosY)
Simple_SetLocX(FP, 0, CPosX, CPosY ,CPosX, CPosY,Simple_CalcLoc(0, 2048, 2048, 2048, 2048))
CallTriggerX(FP,ZSpawnCallTable[2],{},{SetV(SpawnOptionV,7500)})
CForEnd()
CIfEnd()
CIf(FP,{CD(PattT[6],1),CV(LI2,360,AtMost)},{AddV(LI2,15)})
CFor(FP, 0, 2000, 200)
CI=CForVariable()
f_Lengthdir(FP, CI, _Sub(_Mov(360),LI2), CPosX, CPosY)
Simple_SetLocX(FP, 0, CPosX, CPosY ,CPosX, CPosY,Simple_CalcLoc(0, 2048, 2048, 2048, 2048))
CallTriggerX(FP,ZSpawnCallTable[2],{},{SetV(SpawnOptionV,7500)})
CForEnd()
CIfEnd()

PattPT = {7,6,5,7,6,5,4}
for i = 0, 6 do
	CallTriggerX(FP, Call_CAPlot, {CV(EffBGMVRecive,92+i)}, {
		SetV(CARX,2000),
		SetV(CARY,2000),
		SetV(CARo,0),
		SetV(ShNm,6),
		SetV(CA_ZUID,2),
		SetV(CA_SpawnOptionV,8000),
		SetCD(CAXYRand,1),
		SetV(CA_SpawnOptionV2,PattPT[i+1])
	}, 1)
end
PattPT = {7,6,5,4}
for i = 0, 3 do
	CallTriggerX(FP, Call_CAPlot, {CV(EffBGMVRecive,99+i)}, {
		SetV(CARX,4000),
		SetV(CARY,4000),
		SetV(CARo,0),
		SetV(ShNm,7),
		SetV(CA_ZUID,2),
		SetV(CA_SpawnOptionV,3000+(3000*i)),
		SetCD(CAXYRand,1),
		SetV(CA_SpawnOptionV2,PattPT[i+1])
	}, 1)
end
TriggerX(FP,{CV(EffBGMVRecive,99)},{SetCD(SuiOrderCancel,1),SetCD(MoveOrder,1)})
TriggerX(FP,{CV(EffBGMVRecive,103)},{SetCD(SuiOrderCancel,0),SetCD(MoveOrder,0),SetCD(PattT[4],1)})

TriggerX(FP,{CV(EffBGMVRecive,118)},{SetCD(PattT[4],0)})
PattPT = {7,6,5,4,7,6,5,4,7,6,5,4,7,6,5,4}

for i = 0, 15 do
	
	CallTriggerX(FP, Call_CAPlot, {CV(EffBGMVRecive,103+i)}, {
		SetV(CARX,2000),
		SetV(CARY,2000),
		SetV(CARo,0),
		SetV(ShNm,5),
		SetV(CA_ZUID,2),
		SetV(CA_SpawnOptionV,6000),
		SetV(CA_SpawnOptionV2,PattPT[i+1]),
		SetV(CA_SpawnOptionV3,1),
		SetV(CA_SpawnOptionV4,1)
	},1)
end
	
CSPlot(CSMakeCircle(90, 2048-64, 0, 91, 1), P5, 128, 0, {2048,2048}, 1, 32, FP, {Label(),CV(EffBGMVRecive,118)})

PattPT = {7,6,5,4,7,6,5,4}
PattPT2 = {4,5,6,7,4,5,6,7}
for i = 0, 6 do
	CallTriggerX(FP, Call_CAPlot, {CV(EffBGMVRecive,118+i)}, {
		SetV(CARX,2000),
		SetV(CARY,2000),
		SetV(CARo,25*i),
		SetV(ShNm,2),
		SetV(CA_ZUID,2),
		SetV(CA_SpawnOptionV,6000),
		SetV(CA_SpawnOptionV2,PattPT[i+1])
	}, 1)
	CallTriggerX(FP, Call_CAPlot, {CV(EffBGMVRecive,118+i)}, {
		SetV(CARX,2000),
		SetV(CARY,2000),
		SetV(CARo,(25*i)+180),
		SetV(ShNm,2),
		SetV(CA_ZUID,2),
		SetV(CA_SpawnOptionV,6000),
		SetV(CA_SpawnOptionV2,PattPT2[i+1])
	}, 1)
end
TriggerX(FP,{CV(EffBGMVRecive,125)},{KillUnit(128,P5),SetCD(GameStart,1),SetV(V(ObEffCA[6]),1),
SetMinimapColor(P8, SetTo, 0),
SetPlayerColor(P8, SetTo, 0),})

	for i = 0, 7 do
		DoActions(i,{SetCp(i),
		RunAIScript(P1VON),
		RunAIScript(P2VON),
		RunAIScript(P3VON),
		RunAIScript(P4VON),
		RunAIScript(P5VON),
		RunAIScript(P6VON),
		RunAIScript(P7VON),
		RunAIScript(P8VON),
	})
	end




	CIfX(FP,{Memory(0x596A44, Exactly, 65536),CD(ObCcode1,0)})
	CTrigger(FP,{CD(BGMOnOff,0),CD(ObCcode1,0)},{SetCD(BGMOnOff,1),SetCD(ObCcode1,1),
	TSetMemory(0x6509B0,SetTo,LocalPlayerV),PlayWAV("staredit\\wav\\button3.wav"),DisplayText(StrDesign("\x04Turn \x08Off \x04BGM."),4),SetCp(FP)},1)
	CTrigger(FP,{CD(BGMOnOff,1),CD(ObCcode1,0)},{SetCD(BGMOnOff,0),SetCD(ObCcode1,1),
	TSetMemory(0x6509B0,SetTo,LocalPlayerV),PlayWAV("staredit\\wav\\button3.wav"),DisplayText(StrDesign("\x04Turn \x07On \x04BGM."),4),SetCp(FP)},1)
	CElseIfX({Memory(0x596A44, Exactly, 65536)},SetCD(ObCcode1,1))
	CElseX(SetCD(ObCcode1,0))
	CIfXEnd()


	TriggerX(FP,{CD(GameStart2,1)},{SetV(BGMType,2)},{preserved})
	TriggerX(FP,{CD(GameStart,1),CD(BGMOnOff,0)},{SetV(BGMType,1)},{preserved})
	TriggerX(FP,{CD(GameStart,1),CD(BGMOnOff,1)},{SetV(BGMType,0)},{preserved})

	IBGM_EPD(FP, {P1,P2,P3,P4,P9,P10,P11,P12}, BGMType, {
		{1,"staredit\\wav\\BGMFile.ogg",165*1000},
		{2,"staredit\\wav\\BGMFile2.ogg",93*1000}
	})
	
	Cast_UnitCount()
	DoActions(FP,{ModifyUnitHangarCount(5, All, 81, Force1, 64),ModifyUnitHangarCount(4, All, 82, Force1, 64)})
	for i = 1, 5 do
	UnitReadX(FP, ZealotUIDArr[i][4], ZealotUIDArr[i][1], 64, 	ZcountT[i])
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
	
	for i = 0, 3 do
		if TestMode == 1 then
			TriggerX(FP,{Bring(i,AtLeast,1,"Terran Civilian",5)},{SetMemory(0x582264+(4*i),Add,50),KillUnitAt(All, "Terran Civilian", 64, i),CreateUnit(1, "Protoss Probe", 2, i),SetMemoryB(0x58D2B0+(15)+(46*i),SetTo,255)},{preserved})
		else
			TriggerX(FP,{Bring(i,AtLeast,1,"Terran Civilian",5)},{SetMemory(0x582264+(4*i),Add,50),KillUnitAt(All, "Terran Civilian", 64, i),CreateUnit(1, "Protoss Probe", 2, i)},{preserved})
		end
		
		TriggerX(FP,{Bring(i,AtLeast,1,"Terran Civilian",3)},{SetMemory(0x5821D4+(4*i),Add,50),KillUnitAt(All, "Terran Civilian", 64, i),CreateUnit(1, "Terran SCV", 2, i),SetDeaths(i,SetTo,1,210)},{preserved})
		TriggerX(FP,{Bring(i,AtLeast,1,"Terran Civilian",4)},{SetMemory(0x582144+(4*i),Add,50),KillUnitAt(All, "Terran Civilian", 64, i),CreateUnit(1, "Zerg Drone", 2, i)},{preserved})
	end
	CIfEnd()
	TriggerX(FP,{CountdownTimer(AtMost, 1)},{SetCD(BCFlag,0),SetCD(GameStart2,1)})
	TriggerX(FP, {CountdownTimer(AtMost, 200),Bring(Force1,AtMost,0,"Terran Civilian",64)},{SetCD(BCFlag,0)})
	TriggerX(FP,{CD(BCFlag,0)},{
		RemoveUnit("Terran Beacon", AllPlayers),
		RemoveUnit("Zerg Beacon", AllPlayers),
		RemoveUnit("Protoss Beacon", AllPlayers),
		RemoveUnit("Terran Civilian", AllPlayers)})
	

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
			SetDeathsX(CurrentPlayer,SetTo,3,0,0xFF),
			SetMemory(0x6509B0, Subtract, 27),
			SetDeaths(CurrentPlayer,SetTo,0,0),
			SetDeathsX(CurrentPlayer,SetTo,0,1,0xFF00),
			SetMemory(0x6509B0, Add, 4)
		}
	elseif k == 17 then

		LocAct={
			SetMemory(0x6509B0, Subtract, 4),
			SetDeaths(CurrentPlayer,SetTo,0,0),
			SetDeathsX(CurrentPlayer,SetTo,0,1,0xFF00),
			SetMemory(0x6509B0, Add, 4)
		}
	elseif k == 48 or k == 75 or k == 146 or k == 17 or k == 18 then
		
		LocAct={
			SetMemory(0x6509B0, Subtract, 4),
			SetDeaths(CurrentPlayer,SetTo,0,0),
			SetDeathsX(CurrentPlayer,SetTo,0,1,0xFF00),
			SetMemory(0x6509B0, Add, 4)
		}
		local TorrSkillEPD = CreateVar(FP)
		local TorrSkillUID = CreateVar(FP)
		local TorrSkillP = CreateVar(FP)
		CIf(FP,{DeathsX(CurrentPlayer, Exactly, k, 0, 0xFF)},{SetMemory(0x6509B0, Subtract, 4),})
			CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFFFFFF00)},{SetDeathsX(CurrentPlayer,SetTo,0*256,0,0xFFFFFF00)})
				f_SaveCp()
					if k ==17 or k ==18 then
						DoActions(FP,{SetSwitch(RandSwitch,Random),SetSwitch(RandSwitch2,Random)})
						CIf(FP,{Switch(RandSwitch, Set),Switch(RandSwitch2, Set)})
					end
					CIf(FP,{TMemory(_Add(BackupCp,2), AtLeast, 1)})
						CMov(FP,TorrSkillP,_Read(_Sub(BackupCp,2)),nil,0xFF,1)
						f_Read(FP, _Add(BackupCp,2), nil, TorrSkillEPD)
						CMov(FP,TorrSkillUID,_Read(_Add(TorrSkillEPD,25)),nil,0xFF,1)
						CMov(FP,CunitIndex,_Div(_Sub(TorrSkillEPD,19025),_Mov(84)))
						CDoActions(FP, {
							Set_EXCC2(LHPCunit, CunitIndex, 0, SetTo,0),
							Set_EXCC2(LHPCunit, CunitIndex, 1, SetTo,0),
							Set_EXCC2(LHPCunit, CunitIndex, 2, SetTo,0),
							TSetMemoryX(_Add(TorrSkillEPD,19), SetTo, 0, 0xFF00)
						})
						f_Read(FP,_Add(TorrSkillEPD,10),CPos)
						Convert_CPosXY()
						Simple_SetLocX(FP,0, CPosX, CPosY, CPosX, CPosY)
						CDoActions(FP, {TCreateUnit(1,"Zerg Scourge",1,TorrSkillP),TKillUnit("Zerg Scourge",TorrSkillP)})
						for z = 1, #ZealotUIDArr do
							CTrigger(FP,{CV(TorrSkillUID,ZealotUIDArr[z][1])},{TSetKills(TorrSkillP, Add, 1, ZealotUIDArr[z][1])},1)
						end
					CIfEnd()
					if k ==17 or k ==18 then
						CIfEnd()
					end
				f_LoadCp()
			CIfEnd()
			DoActions(FP,{SetMemory(0x6509B0, Add, 4)})
		CIfEnd()
	elseif k == 81 then
		LocAct={
			SetMemory(0x6509B0, Subtract, 4),
			SetDeaths(CurrentPlayer,SetTo,0,0),
			SetDeathsX(CurrentPlayer,SetTo,0,1,0xFF00),
			SetMemory(0x6509B0, Add, 28),
			SetDeaths(CurrentPlayer,SetTo,0,0),
			SetMemory(0x6509B0, Subtract, 24)
		}
	elseif k == 73 then
		LocAct={
			SetMemory(0x6509B0, Subtract, 4),
			SetDeaths(CurrentPlayer,SetTo,0,0),
			SetDeathsX(CurrentPlayer,SetTo,0,1,0xFF00),
			SetMemory(0x6509B0, Subtract, 13),
			SetDeathsX(CurrentPlayer,SetTo,127*65536,0,0xFF0000),
			SetMemory(0x6509B0, Add, 17),
		}
	end
BreakCalc({DeathsX(CurrentPlayer, Exactly, k, 0, 0xFF)},LocAct)
table.insert(HeroShieldArr,ModifyUnitShields(All, k, Force1, 64, 100))
end
BreakCalc({DeathsX(CurrentPlayer, Exactly, 162, 0, 0xFF)},{--캐논
	SetMemory(0x6509B0, Subtract, 4),
	SetDeaths(CurrentPlayer,SetTo,0,0),
	SetDeathsX(CurrentPlayer,SetTo,0,1,0xFF00),
	SetMemory(0x6509B0, Add, 4)
})
BreakCalc({DeathsX(CurrentPlayer, Exactly, 124, 0, 0xFF)},{--터렛
	SetMemory(0x6509B0, Subtract, 4),
	SetDeaths(CurrentPlayer,SetTo,0,0),
	SetDeathsX(CurrentPlayer,SetTo,0,1,0xFF00),
	SetMemory(0x6509B0, Add, 4)
})
BreakCalc({DeathsX(CurrentPlayer, Exactly, 146, 0, 0xFF)},{--성큰
	SetMemory(0x6509B0, Subtract, 4),
	SetDeaths(CurrentPlayer,SetTo,0,0),
	SetDeathsX(CurrentPlayer,SetTo,0,1,0xFF00),
	SetMemory(0x6509B0, Add, 4)
})
BreakCalc({DeathsX(CurrentPlayer, Exactly, 35, 0, 0xFF)})
BreakCalc({DeathsX(CurrentPlayer, Exactly, 143, 0, 0xFF)})
BreakCalc({DeathsX(CurrentPlayer, Exactly, 41, 0, 0xFF)})
BreakCalc({DeathsX(CurrentPlayer, Exactly, 36, 0, 0xFF)})
BreakCalc({DeathsX(CurrentPlayer, Exactly, 59, 0, 0xFF)})
BreakCalc({DeathsX(CurrentPlayer, AtLeast, 131, 0, 0xFF),DeathsX(CurrentPlayer, AtMost, 133, 0, 0xFF)},{SetMemory(0x6509B0, Add, 25),SetDeathsX(CurrentPlayer,SetTo,0*65536,0,0xFF0000)})

BreakCalc({},{SetMemory(0x6509B0,Subtract,16),SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000)})

CunitCtrig_Part2()
CunitCtrig_Part3X()
for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
CunitCtrig_Part4X(i,{
	DeathsX(EPDF(0x628298-0x150*i+(19*4)),AtLeast,1*256,0,0xFF00),
	DeathsX(EPDF(0x628298-0x150*i+(19*4)),AtMost,3,0,0xFF),
	DeathsX(EPDF(0x628298-0x150*i+(9*4)),AtMost,0,0,0xFF0000),
--	DeathsX(EPDF(0x628298-0x150*i+(0x54)),AtLeast,1*256,0,0xFF00),
},
{MoveCp(Add,25*4)})
end
CunitCtrig_End()


for i = 0, 1699 do
	Trigger2(FP,{
		DeathsX(19025+(84*i)+19,Exactly,0*256,0,0xFF00),
		DeathsX(19025+(84*i)+9,Exactly,1*65536,0,0xFF0000),
	},
	{
		SetDeathsX(19025+(84*i)+9,SetTo,0,0,0xFF0000);

		},{preserved})
end




    
EXCC_Part1(LHPCunit)
f_SaveCp()
local ReadHP = CreateVar(FP)
local TempV1 = CreateVar(FP)
local TempV2 = CreateVar(FP)
local TempW = CreateWar(FP)
local TempW2 = CreateWar(FP)
local TempW3 = CreateWar(FP)
local TempW4 = CreateWar(FP)
local TempW5 = CreateWar(FP)
local VoidV = CreateVar(FP)


f_Read(FP, BackupCp, ReadHP)

f_LMov(FP, TempW, {EXCC_TempVarArr[2],EXCC_TempVarArr[3]}, nil, nil, 1)
f_LMov(FP, TempW2, {ReadHP,VoidV}, nil, nil, 1)


f_LAdd(FP, TempW3, TempW, TempW2)

CIfX(FP, {TTCWar(FP, TempW3[2], AtLeast, tostring(8320000*256))})

	f_LSub(FP, TempW4, _LMov(tostring(8320000*256)), TempW2)
	f_LSub(FP, TempW5, TempW, TempW4)


	f_LMov(FP, {EXCC_TempVarArr[2],EXCC_TempVarArr[3]},TempW5, nil, nil, 1)
CDoActions(FP, {
	TSetMemory(BackupCp, SetTo, 8320000*256),
	Set_EXCCX(0, SetTo, 1),
	Set_EXCCX(1, SetTo, EXCC_TempVarArr[2]),
	Set_EXCCX(2, SetTo, EXCC_TempVarArr[3]),
})
CElseX()
	f_LMov(FP, {TempV1,TempV2}, TempW, nil, nil, 1)
	CDoActions(FP, {
		TSetMemory(BackupCp, Add, TempV1),
		Set_EXCCX(0, SetTo, 0),
		Set_EXCCX(1, SetTo, 0),
		Set_EXCCX(2, SetTo, 0),
	})
CIfXEnd()


f_LoadCp()
EXCC_ClearCalc()
EXCC_Part2()
EXCC_Part3X()

for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
EXCC_Part4X(i,{
	
	CVar("X", "X", AtLeast, 1);
	Deaths(19025+(84*i)+2,AtMost,(8320000*256)-256,0),
	DeathsX(19025+(84*i)+19,AtLeast,1*256,0,0xFF00),
	DeathsX(19025+(84*i)+19,AtLeast,4,0,0xFF),
},
{
	SetCVar(FP,CurCunitI[2],SetTo,i),
	SetCVar(FP, BackupCp[2], SetTo, 19025+(84*i)+2);
	MoveCp(Add,2*4),
})--
end
EXCC_End()






CMov(FP,0x6509B0,FP)
	function CA_3DAcc(Time,Type,XY,YZ,ZX)
		TriggerX(FP,{CV(CA_Eff_Rat,Time,Type)},{
			--AddV(CA_Eff_XY,XY);
			AddV(CA_Eff_YZ,YZ);
			AddV(CA_Eff_ZX,ZX);
		},{preserved})
	end

	Trigger2X(FP, {CD(GameStart,1),Bring(Force1, AtMost, 0, "Any unit", 7)},{RotatePlayer({DisplayTextX("\x08Game Over")}, HumanPlayers, FP),RotatePlayer({Defeat()}, MapPlayers, FP)})
	Trigger2X(FP, {CD(GameStart2,1),CD(GameStart,0),Bring(Force1, AtMost, 0, "Any unit", 7)},{RotatePlayer({DisplayTextX("\x08Game Over")}, HumanPlayers, FP),RotatePlayer({Defeat()}, MapPlayers, FP)})
	--CA_3DAcc(32840,AtLeast,2,2,2)
	--CA_3DAcc(112420,AtLeast,2,1,1)
	--CA_3DAcc(142730,AtLeast,3,1,1)
	--CA_3DAcc(186000,AtLeast,4,1,1)
	--CA_3DAcc(186000+28000,AtLeast,5,1,1)
	--CA_3DAcc(186000+67000,AtLeast,6,1,1)
	--CA_3DAcc(186000+138000,AtLeast,10,1,1)
ColorMode = CreateCcode()
ColorCcode = CreateCcode()
ColorT = CreateCcode()

for i = 0, 9 do
	TriggerX(FP,{CD(ColorCcode,i)},{
		SetPlayerColor(P6, SetTo, 182+i),
		SetMinimapColor(P6, SetTo, 182+i),
	},{preserved})
end
DoActionsX(FP, {SubCD(ColorT,1)})
TriggerX(FP,{CD(ColorMode,1),CD(ColorT,0)},{SubCD(ColorCcode,1),SetCD(ColorT,7)},{preserved})
TriggerX(FP,{CD(ColorMode,0),CD(ColorT,0)},{AddCD(ColorCcode,1),SetCD(ColorT,7)},{preserved})
TriggerX(FP,{CD(ColorMode,1),CD(ColorCcode,0,AtMost)},{SetCD(ColorMode,0)},{preserved})
TriggerX(FP,{CD(ColorMode,0),CD(ColorCcode,9,AtLeast)},{SetCD(ColorMode,1)},{preserved})


ColorMode = CreateCcode()
ColorCcode = CreateCcode()
ColorT = CreateCcode()

for i = 0, 9 do
	TriggerX(FP,{CD(ColorCcode,i)},{
		SetPlayerColor(P5, SetTo, 169+i),
		SetMinimapColor(P5, SetTo, 169+i),
	},{preserved})
end
DoActionsX(FP, {SubCD(ColorT,1)})
TriggerX(FP,{CD(ColorMode,1),CD(ColorT,0)},{SubCD(ColorCcode,1),SetCD(ColorT,5)},{preserved})
TriggerX(FP,{CD(ColorMode,0),CD(ColorT,0)},{AddCD(ColorCcode,1),SetCD(ColorT,5)},{preserved})
TriggerX(FP,{CD(ColorMode,1),CD(ColorCcode,0,AtMost)},{SetCD(ColorMode,0)},{preserved})
TriggerX(FP,{CD(ColorMode,0),CD(ColorCcode,9,AtLeast)},{SetCD(ColorMode,1)},{preserved})



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

	TriggerX(FP,{CD(PattT[3],1)},{SubV(CA_Eff_Rat,5000)})
	TriggerX(FP,{CD(CA_Eff_Mode,1),CV(CA_Eff_Rat,20000,AtMost)},{SetCD(CA_Eff_Mode,0)},{preserved})
	TriggerX(FP,{CD(CA_Eff_Mode,0),CV(CA_Eff_Rat,372000,AtLeast)},{SetCD(CA_Eff_Mode,1)},{preserved})
	TriggerX(FP,{CD(CA_Eff_Mode,1),CD(GameStart,1)},{SubV(CA_Eff_Rat,120)},{preserved})
	TriggerX(FP,{CD(CA_Eff_Mode,0),CD(GameStart,1)},{AddV(CA_Eff_Rat,120)},{preserved})
	TriggerX(FP,{CD(GameStart,1)},{AddCD(GameTime,1)},{preserved})
	ZSVar2=CreateVar(FP)
	ZSVar3=CreateVar(FP)
	ZSVar = CreateVar(FP)

	Waves = {}
	for i = 3, 52 do
		Waves[i-2]=i*i*i*i*i
		if i == 25+2 then break end
	end
	for j, k in pairs(Waves) do
		local WStr = tostring(k*24)
		if #WStr>3 and 6>=#WStr then
			WStr = string.sub(WStr,1,#WStr-3)..","..string.sub(WStr,#WStr-2,#WStr)
		elseif  #WStr>6 and 9>=#WStr then
			WStr = string.sub(WStr,1,#WStr-6)..","..string.sub(WStr,#WStr-5,#WStr-3)..","..string.sub(WStr,#WStr-2,#WStr)
		elseif  #WStr>9 and 12>=#WStr then
			WStr = string.sub(WStr,1,#WStr-9)..","..string.sub(WStr,#WStr-8,#WStr-6)..","..string.sub(WStr,#WStr-5,#WStr-3)..","..string.sub(WStr,#WStr-2,#WStr)
		end
		if j==#Waves then
			Trigger2X(FP,{CD(GameStart,1),CD(GameTime,(j-1)*(50*24),AtLeast)},{SetV(ZSVar,k),RotatePlayer({DisplayTextX("\x04[Wave "..j.."(End)] : "..WStr.." Zealot/s",4)}, HumanPlayers, FP)})
		else
			Trigger2X(FP,{CD(GameStart,1),CD(GameTime,(j-1)*(50*24),AtLeast)},{SetV(ZSVar,k),RotatePlayer({DisplayTextX("\x04[Wave "..j.."] : "..WStr.." Zealot/s",4)}, HumanPlayers, FP)})
		end
		end
	CTrigger(FP,{CD(GameStart,1)},{AddV(ZSVar2,ZSVar)},1)
	CIf(FP,{CV(ZSVar2,1000000000,AtLeast)})
		CAdd(FP,ZSVar3,_Div(ZSVar2,100000000))
		f_Mod(FP,ZSVar2,100000000)
	CIfEnd()
--	Call_CA_Effect = SetCallForward()
	if TestMode == 1 then
		--for i = 0, 255 do
		--	TriggerX(FP,{CD(TestCD,i)},{SetResources(P1, SetTo, i, Gas),SetCountdownTimer(SetTo, 60),
		--		SetMinimapColor(P8, SetTo, i),
		--		SetPlayerColor(P8, SetTo, i)},{preserved})
		--end
	--CMov(FP,0x57f120,CA_Eff_Rat)
		--f_LMov(FP,KillW,_LAdd(KillW,"1000000000"))
		DoActions(FP,{SetResources(AllPlayers,SetTo,0x44444444,OreAndGas),},1)--SetCountdownTimer(SetTo, 30)
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
		


		function CreateEffUnitA(Condition,Height,Color,ForPlayer)
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

		

		for j = 1, #ZealotUIDArr do
			CZNJ=def_sIndex()
			NJumpEnd(FP,CZNJ)
			local BrCond = CV(ZSVar2,  100^(j)-1,AtMost)
			if j == 4 then BrCond = nil end
			if j == 5 then
				NIf(FP,{TCVar("X",CA[6],Exactly,NextPoint[5]),Memory(0x628438,AtLeast,1),CV(count,1500,AtMost),CV(Zcount,700,AtMost),CD(GameStart,1),CV(ZSVar3,  1,AtLeast)},{SubV(ZSVar3,1),AddV(NextPoint[5],1)})
			else
				NIf(FP,{CV(ZSVar3,  0,AtMost),TCVar("X",CA[6],Exactly,NextPoint[j]);CVar("X",CA[6],AtMost,8);Memory(0x628438,AtLeast,1),CV(count,1500,AtMost),CV(Zcount,700,AtMost),CD(GameStart,1),CV(ZSVar2,  100^(j-1),AtLeast),BrCond},{SubV(ZSVar2,100^(j-1)),AddV(NextPoint[j],1)})
			end
				CallTrigger(FP,ZSpawnCallTable[j])
				NJump(FP,CZNJ,{CV(NextPoint[j],8,AtMost)})
			NIfEnd()
			TriggerX(FP,{CV(NextPoint[j],9,AtLeast)},{SetV(NextPoint[j],1)},{preserved})
		end


		CIfEnd()
		CA_CP = CreateVar(FP)
		CIf(FP,{CV(CA_Create,1,AtLeast)},{SetSwitch(RandSwitch,Random),SetSwitch(RandSwitch2,Random)})

		CIfEnd()
		
	end
	
		CAPlot(CSMakeStar(4, 180, 256, 0, 9, 1),FP,nilunit,0,{SHLX,SHLY},1,16,{1,0,0,0,9999,1},"CA_Eff",FP,nil,nil,{SetV(CA_Create,0)})
		AIT=CreateCcode()
		DoActionsX(FP, AddCD(AIT,1))
		TriggerX(FP,{CD(AIT,4,AtLeast)},{SetCD(AIT,0)},{preserved})
		TriggerX(FP,{CD(GameStart2,1),CD(SuiOrderCancel,0),CD(PattT[1],1),CD(AIT,0)},{RotatePlayer({
			RunAIScript("Clear Previous Combat Data"),
			RunAIScript("Send All Units on Random Suicide Missions")}, {P5,P6,P7,P8}, FP)
			},{preserved})
		TriggerX(FP,{CD(MoveOrder,1)},{Order("Any unit",Force2,64,Move,64)},{preserved})
	local SelATK = CreateVar(FP)
	SelEPD,SelHP,SelSh,SelMaxHP,PercentCalc = CreateVars(5,FP)
	SelWep = CreateVar(FP)
	SelUID = CreateVar(FP)
			
	CIf(FP,{Memory(0x6284B8 ,AtLeast,1),Memory(0x6284B8 + 4,AtMost,0)})
	f_Read(FP,0x6284B8,nil,SelEPD)
	f_Read(FP,_Add(SelEPD,25),SelUID,"X",0xFF)
	f_Read(FP,_Add(SelEPD,2),SelHP)
	f_Read(FP,_Add(SelEPD,24),SelSh,"X",0xFFFFFF)
	f_Div(FP,SelHP,_Mov(256))
	f_Div(FP,SelSh,_Mov(256))
	CMov(FP,SelATK,0)
	CMov(FP,SelMaxHP,0)
--	CMov(FP,SelMaxHP,_ReadF(_Add(SelUID,_Mov(EPD(0x662350)))))
	for i = 1, 5 do
		TriggerX(FP,{CV(SelUID,ZealotUIDArr[i][1])},{SetV(SelMaxHP,ZealotUIDArr[i][6])},{preserved})
	end
	CMov(FP,CunitIndex,_Div(_Sub(SelEPD,19025),_Mov(84)))
	
	CIf(FP, {Cond_EXCC2(LHPCunit,CunitIndex,0,AtLeast,1)})
	local TempV1 = CreateVar(FP)
	local TempV2 = CreateVar(FP)
	local TempW2 = CreateWar(FP)
	local TempW3 = CreateWar(FP)
	local TempV = CreateVar(FP)
	CMul(FP,TempV, CunitIndex, 0x970/4)
	CAdd(FP,TempV,LHPCunit[3])
	f_Read(FP, _Add(TempV,(0x20*1)/4), TempV1)
	f_Read(FP, _Add(TempV,(0x20*2)/4), TempV2)
	f_LMov(FP, TempW2, {TempV1, TempV2}, nil,nil,1)
	f_LDiv(FP,TempW3, TempW2, _LMov("256"))
	f_LMov(FP, {TempV1, TempV2}, TempW3, nil,nil,1)
	CAdd(FP,SelHP,TempV1)
	CIfEnd()
	local TmpCalcW = CreateWar(FP)

	f_LAdd(FP,TmpCalcW,{SelHP,0},_LAdd({SelHP,0}, {SelHP,0}))

	f_Cast(FP, {PercentCalc,0}, _LDiv(TmpCalcW, {SelMaxHP,0}))
	TBLN1T1 = {}
	TBLN1T2 = {}
	TBLN1T3 = {}
	for i = 0, 11 do
--			table.insert(TBLN1T, SetCSVA1(SVA1(Str3,i),SetTo,0x07,0xFF))
--			table.insert(TBLN2T, SetCSVA1(SVA1(Str3,i),SetTo,0x07,0xFF))
		table.insert(TBLN1T1, SetCSVA1(SVA1(TblStr1,i),SetTo,0x07,0xFF))
		table.insert(TBLN1T2, SetCSVA1(SVA1(TblStr1,i),SetTo,0x17,0xFF))
		table.insert(TBLN1T3, SetCSVA1(SVA1(TblStr1,i),SetTo,0x08,0xFF))
	end


	for i = 1, 5 do
		TriggerX(FP,{CV(SelUID,ZealotUIDArr[i][1])},{SetV(SelATK,ZealotUIDArr[i][5])},{preserved})
	end
	CS__SetValue(FP, TblStr1, " 000,000,000 \x04(00000\x0D\x04) - 00000  \x1BＤｍｇ")
	TriggerX(FP,{CV(SelHP,999,AtMost)},{SetCSVA1(SVA1(TblStr1,8),SetTo,0x0D0D0D0D,0xFFFFFFFF)},{preserved})
	TriggerX(FP,{CV(SelHP,999999,AtMost)},{SetCSVA1(SVA1(TblStr1,4),SetTo,0x0D0D0D0D,0xFFFFFFFF)},{preserved})
	CS__ItoCustom(FP,SVA1(TblStr1,0),SelHP,nil,nil,{10,9},1,nil,{"\x0D","\x0D","\x080"},0x08,{0,1,2,4,5,6,8,9,10},nil)
	CS__ItoCustom(FP,SVA1(TblStr1,14),SelSh,nil,nil,{10,5},1,nil,"\x1C0",0x1C,{0,1,2,3,4})
	CS__ItoCustom(FP,SVA1(TblStr1,24),SelATK,nil,nil,{10,5},1,nil,"\x1B0",0x1B,{0,1,2,3,4})
	TriggerX(FP,{CV(PercentCalc,2,AtLeast)},TBLN1T1,{preserved})
	TriggerX(FP,{CV(PercentCalc,1)},TBLN1T2,{preserved})
	TriggerX(FP,{CV(PercentCalc,0)},TBLN1T3,{preserved})
	CS__InputVA(FP,iTbl1,0,TblStr1,TblStr1s,nil,0,TblStr1s)
	CIfEnd()



DoActions(FP,HeroShieldArr)
end