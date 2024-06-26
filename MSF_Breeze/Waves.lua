
function Waves()
	local WaveT = CreateCcodeArr(7)
	local WaveS = CreateCcodeArr(7)
function ElapsedTimeX(Comparison, Time)
	return Memory(0x58D6F8 ,Comparison, Time)
end
function SetWave(Condition,WaveC,XYTable,NUTable)
	
	CIf(FP,Condition,{AddCD(WaveC,1)})
		CIf(FP,CD(WaveC,700,AtLeast),SetCD(WaveC,0))
		for j, k in pairs(NUTable) do
			f_TempRepeat({},k[1],k[2],nil,FP,XYTable)
		end
		CIfEnd()
	CIfEnd()
end


function CIfGunWave(GunID,LocID,TimerMax,BGMTypes)
	local GunCcode = CreateCcode()
	TriggerX(FP, CommandLeastAt(GunID,LocID), {SetCD(GunCcode,1),SetV(BGMType,BGMTypes)})--RotatePlayer({DisplayTextX("\x13GunID : "..GunID.."    LocID : "..LocID)}, HumanPlayers, FP)
	CIf(FP,{CD(GunCcode,1,AtLeast),CD(GunCcode,TimerMax,AtMost)},{AddCD(GunCcode,1)})
		GetLocCenter(LocID-1, G_CA_X, G_CA_Y)
	return GunCcode
end

function CIfGunWave2(GunID,LocID,TimerMax,BGMTypes)
	local GunCcode = CreateCcode()
	TriggerX(FP, Bring(P12, AtMost, 0, GunID, LocID), {SetCD(GunCcode,1),SetV(BGMType,BGMTypes)})--RotatePlayer({DisplayTextX("\x13GunID : "..GunID.."    LocID : "..LocID)}, HumanPlayers, FP)
	CIf(FP,{CD(GunCcode,1,AtLeast),CD(GunCcode,TimerMax,AtMost)},{AddCD(GunCcode,1)})
		GetLocCenter(LocID-1, G_CA_X, G_CA_Y)
	return GunCcode
end

function SetTT(LocID,Unitargs,G_CA_args) -- 개별영침
	local TTC = CreateCcode()
	for i = 0, 6 do
		Trigger2X(i, {CD(GMode,1),Bring(i, AtLeast, 1, "Men", LocID)}, {AddCD(TTC,1),RotatePlayer({MinimapPing(LocID),DisplayTextX(StrDesignX(PlayerString[i+1].." \x04가 \x08적의 영역\x04을 \x03침범\x04했습니다.."), 4)}, HumanPlayers, i)})
	end
	CIf(FP,{CD(TTC,1,AtLeast)},{SubCD(TTC, 1)})
		GetLocCenter(LocID-1, G_CA_X, G_CA_Y)
		for j,k in pairs(Unitargs) do
			f_TempRepeat({},k[1],k[2],nil,FP)
		end
		if G_CA_args then
		for j,k in pairs(G_CA_args) do
			G_CA_SetSpawn({},table.unpack(k))
		end
		end
		DoActions2(FP, {RotatePlayer({PlayWAVX("staredit\\wav\\warn2.ogg"),PlayWAVX("staredit\\wav\\warn2.ogg"),PlayWAVX("staredit\\wav\\warn2.ogg")},HumanPlayers,FP)})
		
		CIfEnd()
end
function SetTTX(SLoc,Locs,Unitargs,G_CA_args) -- 개별영침 n구간중 1개만 인식되면 사라짐
	local TTC = CreateCcode()
	local LTTC = CreateCcode()
	for i = 0, 6 do
		for j,k in pairs(Locs) do
			Trigger2X(i, {CD(GMode,1),CDeaths(i, AtMost, 0, LTTC),Bring(i, AtLeast, 1, "Men", k)}, {AddCD(TTC,1),SetCDeaths(i, Add, 1, LTTC),RotatePlayer({MinimapPing(SLoc),DisplayTextX(StrDesignX(PlayerString[i+1].." \x04가 \x08적의 영역\x04을 \x03침범\x04했습니다.."), 4)}, HumanPlayers, i)})
		end
	end
	CIf(FP,{CD(TTC,1,AtLeast)},{SubCD(TTC, 1)})
		GetLocCenter(SLoc-1, G_CA_X, G_CA_Y)
		for j,k in pairs(Unitargs) do
			f_TempRepeat({},k[1],k[2],nil,FP)
		end
		if G_CA_args then
		for j,k in pairs(G_CA_args) do
			G_CA_SetSpawn({},table.unpack(k))
		end
		end
		DoActions2(FP, {RotatePlayer({PlayWAVX("staredit\\wav\\warn2.ogg"),PlayWAVX("staredit\\wav\\warn2.ogg"),PlayWAVX("staredit\\wav\\warn2.ogg")},HumanPlayers,FP)})
	CIfEnd()
end
--Sample
--{G_CA_CUTable, G_CA_SNTable, G_CA_SLTable, "MAX", 1, nil, FP, 1}
--G_CA_SetSpawn({CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},"ACAS",{"L00_1_164F"},"MAX")
--G_CA_SetSpawn({Gun_Line(5,Exactly,0)},ZergUnit1,{P_4,S_5},{4,2})

--{1,"staredit\\wav\\BrOP.ogg",188*1000},
--{2,"staredit\\wav\\BGM1_1.ogg",45*1000},
--{3,"staredit\\wav\\BGM1_2.ogg",45*1000},
--{4,"staredit\\wav\\BGM2_1.ogg",45*1000},
--{5,"staredit\\wav\\BGM2_2.ogg",45*1000},
--{6,"staredit\\wav\\BGM3_1.ogg",42*1000},
--{7,"staredit\\wav\\BGM3_2.ogg",42*1000},
--{8,"staredit\\wav\\MB.ogg",37*1000},
BGM1S = CreateCcode()
BGM2S = CreateCcode()
BGM3S = CreateCcode()
function GunWave(GunID,LocID,NUTable,BGMTypes,G_CA_args)
	local GunCcode = CreateCcode()
	local EnableMLocCcode = CreateCcode()
	local CurGunP = CreateVar(FP)
	local CountMax = 0
	local NUTableCnt = 0
	local G_CA_argsCnt = 0
	if G_CA_args then
		G_CA_argsCnt = #G_CA_args
	end

	CountMax = math.max(CountMax, #NUTable, G_CA_argsCnt)
	TriggerX(FP, CommandLeastAt(GunID,LocID), {SetCD(GunCcode,1)})
	CIf(FP,{CD(GunCcode,1,AtLeast),CD(GunCcode,480*CountMax,AtMost)},{AddCD(GunCcode,1),SetSwitch(RandSwitch1,Random),})
		CIfOnce(FP)
		for i = 0, 6 do
			CTrigger(FP, {TTOR({CD(GMode,1),CD(UTAGECcode,1,AtLeast)}),Kills(i, AtLeast, 1, GunID)}, {SetV(CurGunP,i),SetKills(i, Subtract, 1, GunID)})
		end
		CIfEnd()
		DoActionsX(FP, SetV(BGMType,BGMTypes), 1)
		GetLocCenter(LocID-1, G_CA_X, G_CA_Y)
		
		if GunID == 150 or GunID == 148 then
			CTrigger(FP, {CD(GMode,1),CD(GunCcode,480,AtLeast)}, {SetCD(EnableMLocCcode,1)})
			CTrigger(FP, {CD(UTAGECcode,1,AtLeast)}, {SetCD(EnableMLocCcode,1)})
		else
			CTrigger(FP, {TTOR({CD(GMode,1),CD(UTAGECcode,1,AtLeast)})}, {SetCD(EnableMLocCcode,1)})
		end
		CIf(FP, {TTOR({CD(GMode,1),CD(UTAGECcode,1,AtLeast)}),CD(EnableMLocCcode,1)})
		for i = 0, 6 do
			CTrigger(FP, {CV(CurGunP,i)}, {SetV(G_CA_X,PPosX[i+1]),SetV(G_CA_Y,PPosY[i+1])},{preserved})
		end
		CIfEnd()
		
		
		
		local NUCArr = {}
		
		if G_CA_args then
		for j,k in pairs(G_CA_args) do
			G_CA_SetSpawn({CD(GunCcode,2+(480*(j-1)))},{84},k[2],k[3],"MAX",nil,nil,nil,FP,1)
		end
		end
		for j, k in pairs(NUTable) do
			local NUCcode = CreateCcode()
			table.insert(NUCArr,SetCD(NUCcode,0))
			f_TempRepeat({CD(NUCcode,48,AtLeast),CD(NUCcode,48+k[2]-1,AtMost)},k[1],1,nil,FP)
			DoActionsX(FP,{AddCD(NUCcode)})
		end
		if G_CA_args then
		for j,k in pairs(G_CA_args) do
			G_CA_SetSpawn({CD(GunCcode,48+((j-1)*480),AtLeast)},table.unpack(k))
		end
		end
		TriggerX(FP,{CD(GunCcode,480,AtLeast)},NUCArr)
	CIfEnd({SetCp(FP)})
	
end
	DoActions(FP,{SetCp(FP),KillUnit(84, FP)})

	
	--SetUnitAbility(19,5,5600,false,nil,333,1,nil,nil,38000,"짐 레이너 (V)")
	--SetUnitAbility(17,9,3800,false,nil,250,1,nil,nil,25000,"앨런 세자르")
	--SetUnitAbility(21,18,2800,false,nil,200,1,nil,nil,22000,"톰 카잔스키")
	--SetUnitAbility(28,23,4000,false,nil,600,1,nil,nil,45000,"히페리온")
	--SetUnitAbility(23,12,40000,false,nil,3000,1,nil,nil,150000,"에드먼드 듀크 (Tank)")
	--SetUnitAbility(25,28,2100,false,nil,740,1,nil,nil,30000,"에드먼드 듀크 (Siege)")
	--SetUnitAbility(10,26,7000,false,nil,490,1,nil,nil,60000,"구이 몬타그")
	--SetUnitAbility(77,65,2200,1750,nil,350,1,nil,nil,30000,"피닉스 (Z)")
	--SetUnitAbility(78,67,1600,2800,nil,400,1,nil,nil,27000,"피닉스 (D)")
	--SetUnitAbility(88,114,1500,1800,nil,220,1,nil,nil,27000,"아르타니스")
	--SetUnitAbility(76,71,500,4000,nil,450,1,nil,nil,40000,"테사다르 / 제라툴")
	--SetUnitAbility(86,78,2500,1500,nil,600,1,nil,nil,35000,"다니모스")
	--SetUnitAbility(79,69,5600,4400,nil,400,1,nil,nil,50000,"테사다르")
	--SetUnitAbility(75,85,25000,4500,nil,1050,1,nil,nil,100000,"제라툴")
	--SetUnitAbility(98,100,3500,1200,nil,300,1,nil,nil,45000,"라자갈")
	--SetUnitAbility(162,80,5000,5000,nil,650,1,nil,nil,45000,"광자포")

	
	GunWave(131,18,{{38,20},{39,15},{43,25},{40,15}},2,{{{54,55}, P_5, 2, "MAX", nil, nil, nil, FP, 1},{{53,55}, P_4, 3, "MAX", nil, nil, nil, FP, 1}})
	GunWave(131,19,{{38,20},{39,15},{43,25},{40,15}},2,{{{54,55}, P_5, 2, "MAX", nil, nil, nil, FP, 1},{{53,55}, P_4, 3, "MAX", nil, nil, nil, FP, 1}})
	
	GunWave(132,20,{{38,10},{39,15},{39,10},{43,16},{44,9}},2,{{{77,56}, P_3, 2, "MAX", nil, nil, nil, FP, 1},{{77,56}, P_5, 2, "MAX", nil, nil, nil, FP, 1}})
	GunWave(132,21,{{38,10},{39,15},{39,10},{43,16},{44,9}},2,{{{78,56}, P_3, 2, "MAX", nil, nil, nil, FP, 1},{{78,56}, P_5, 2, "MAX", nil, nil, nil, FP, 1}})

	GunWave(132,41,{{38,10},{39,15},{39,10},{43,16},{44,9}},2,{{{17,56}, P_4, 2, "MAX", nil, nil, nil, FP, 1},{{17,56}, P_5, 2, "MAX", nil, nil, nil, FP, 1}})
	GunWave(132,42,{{38,10},{39,15},{39,10},{43,16},{44,9}},2,{{{19,56}, P_3, 2, "MAX", nil, nil, nil, FP, 1},{{19,56}, P_4, 2, "MAX", nil, nil, nil, FP, 1}})


	GunWave(131,24,{{54,20},{53,15}},2,{{{53,56}, P_5, 2, "MAX", nil, nil, nil, FP, 1},{{48,56}, P_4, 3, "MAX", nil, nil, nil, FP, 1}})
	GunWave(131,25,{{54,20},{53,15}},2,{{{53,56}, P_5, 2, "MAX", nil, nil, nil, FP, 1},{{48,56}, P_4, 3, "MAX", nil, nil, nil, FP, 1}})

	GunWave(132,26,{{53,20},{54,15},{48,20},{54,16}},2,{{{56,86,77}, {P_5,P_6,P_5}, {4,1,2}, "MAX", nil, nil, nil, FP, 1},{{56,86,77}, {P_5,P_6,P_4}, {4,1,2}, "MAX", nil, nil, nil, FP, 1}})
	GunWave(132,27,{{53,20},{54,15},{48,20},{54,16}},2,{{{56,86,78}, {P_5,P_6,P_5}, {4,1,2}, "MAX", nil, nil, nil, FP, 1},{{56,86,78}, {P_5,P_6,P_4}, {4,1,2}, "MAX", nil, nil, nil, FP, 1}})
	CIfX(FP,{CD(GMode,0)})

	GunWave(133,22,{{38,25},{39,15},{44,25}},3,{{{10,21}, P_5, 2, 0, nil, nil, nil, FP, 1},{{10,21}, P_4, 3, 0, nil, nil, nil, FP, 1}})
	GunWave(133,23,{{38,25},{39,15},{44,25}},3,{{{78,88}, P_3, 3, 0, nil, nil, nil, FP, 1},{{78,88}, P_4, 3, 0, nil, nil, nil, FP, 1}})
	GunWave(133,28,{{53,25},{21,15},{48,15},{55,25}},3,{{{25,56,53,48}, {P_5,P_5,P_6,P_7}, {1,3,3,3}, 0, nil, nil, nil, FP, 1},{{25,56,53,48}, {P_5,P_5,P_6,P_7}, {1,3,3,3}, 0, nil, nil, nil, FP, 1}})
	GunWave(133,29,{{53,25},{21,15},{48,15},{55,25}},3,{{{25,56,53,48}, {P_5,P_5,P_6,P_7}, {1,3,3,3}, 0, nil, nil, nil, FP, 1},{{25,56,53,48}, {P_5,P_5,P_6,P_7}, {1,3,3,3}, 0, nil, nil, nil, FP, 1}})
	GunWave(133,30,{{53,25},{48,15},{55,25}},3,{{{25,19,55,29}, {S_6,P_6,P_6,P_4}, {1,2,3,2}, 0, nil, nil, nil, FP, 1},{{25,19,55,29}, {S_8,P_6,P_6,P_4}, {1,2,3,2}, 0, nil, nil, nil, FP, 1}})
	GunWave(133,31,{{53,25},{48,15},{55,25}},3,{{{25,17,55,29}, {S_6,P_6,P_6,P_4}, {1,2,3,2}, 0, nil, nil, nil, FP, 1},{{25,17,55,29}, {S_8,P_6,P_6,P_4}, {1,2,3,2}, 0, nil, nil, nil, FP, 1}})
	GunWave(133,32,{{53,25},{48,15},{55,25}},3,{{{25,10,28,53}, {S_6,P_5,P_6,P_7}, {1,2,3,3}, 0, nil, nil, nil, FP, 1},{{25,10,28,53}, {S_8,P_5,P_6,P_7}, {1,2,3,3}, 0, nil, nil, nil, FP, 1}})
	GunWave(133,33,{{53,25},{48,15},{55,25}},3,{{{25,23,28,53}, {S_6,P_5,P_6,P_7}, {1,1,3,3}, 0, nil, nil, nil, FP, 1},{{25,23,28,53}, {S_8,P_5,P_6,P_7}, {1,1,3,3}, 0, nil, nil, nil, FP, 1}})
	GunWave(133,43,{{53,25},{48,15},{55,25}},3,{{{98,79,56,48}, {P_6,P_5,P_6,P_7}, {2,3,3,3}, 0, nil, nil, nil, FP, 1},{{98,79,56,48}, {P_8,P_5,P_6,P_7}, {2,3,3,3}, 0, nil, nil, nil, FP, 1}})
	GunWave(133,44,{{53,25},{48,15},{55,25}},3,{{{98,75,56,48}, {P_6,P_8,P_6,P_7}, {2,1,3,3}, 0, nil, nil, nil, FP, 1},{{98,75,56,48}, {P_8,P_8,P_6,P_7}, {2,1,3,3}, 0, nil, nil, nil, FP, 1}})
	GunWave(148,34,{{53,20},{54,30},{48,15},{55,25}},4,{{{25,28}, "ACAS", "LOverM", "MAX", nil, nil, nil, FP, 1},{{25,28}, "ACAS", "LOverM", "MAX", nil, nil, nil, FP, 1}})
	GunWave(148,35,{{53,20},{54,30},{48,15},{55,25}},4,{{{25,28}, "ACAS", "ROverM", "MAX", nil, nil, nil, FP, 1},{{25,28}, "ACAS", "ROverM", "MAX", nil, nil, nil, FP, 1}})

	GunWave(150,36,{{51,15},{104,15},{56,25},{53,15},{54,20}},4,{{{98}, S_6, 1, "MAX", nil, nil, nil, FP, 1},{{98}, S_6, 1, "MAX", nil, nil, nil, FP, 1}})
	GunWave(150,37,{{51,15},{104,15},{56,25},{53,15},{54,20}},4,{{{98}, S_6, 1, "MAX", nil, nil, nil, FP, 1},{{98}, S_6, 1, "MAX", nil, nil, nil, FP, 1}})
	GunWave(150,38,{{51,15},{104,15},{56,25},{53,15},{54,20}},4,{{{98,29}, S_5, 1, "MAX", nil, nil, nil, FP, 1},{{98,29}, S_5, 1, "MAX", nil, nil, nil, FP, 1}}) -- 중보건물. 따로 안넣어도됨
	GunWave(150,39,{{51,15},{104,15},{56,25},{53,15},{54,20}},4,{{{29}, S_6, 1, "MAX", nil, nil, nil, FP, 1},{{29}, S_6, 1, "MAX", nil, nil, nil, FP, 1}})
	GunWave(150,40,{{51,15},{104,15},{56,25},{53,15},{54,20}},4,{{{29}, S_6, 1, "MAX", nil, nil, nil, FP, 1},{{29}, S_6, 1, "MAX", nil, nil, nil, FP, 1}})

	CElseX()
	--SetTT(LocID,Unitargs)
	SetTTX(8,{8,50,51},{{88,15},{21,15}})
	SetTTX(9,{9,52,53},{{88,15},{21,15}})
	SetTT(54,{{25,15},{28,15}})
	SetTT(55,{{25,15},{28,15}})
	SetTT(73,{{25,30}},{{{29}, S_8, 0, "MAX", nil, nil, nil, FP}})
	SetTT(74,{{25,30}},{{{29}, S_8, 0, "MAX", nil, nil, nil, FP}})
	SetTT(56,{{23,5}},{{{88,21,76,17}, {P_6,S_6,P_4,S_4}, {3,1,3,1}, "MAX", nil, nil, nil, FP}})

	GunWave(133,22,{{38,25},{39,15},{44,25}},3,{{{10,21,17}, {P_5,S_5,P_6}, {4,1,3}, 5, nil, nil, nil, FP, 1},{{10,21,17}, {P_4,S_5,S_4}, {3,2,1}, 5, nil, nil, nil, FP, 1}})
	GunWave(133,23,{{38,25},{39,15},{44,25}},3,{{{78,88,77}, {P_3,S_5,P_6}, {4,1,5}, 5, nil, nil, nil, FP, 1},{{78,88,77}, {P_4,S_5,P_6}, {5,2,6}, 5, nil, nil, nil, FP, 1}})
	GunWave(133,28,{{53,25},{21,15},{48,15},{55,25}},3,{{{25,56,53,48}, {P_8,P_5,P_6,P_7}, {4,6,3,3}, "MAX", nil, nil, nil, FP, 1},{{25,56,53,48}, {P_8,P_5,P_6,P_7}, {4,6,3,3}, "MAX", nil, nil, nil, FP, 1}})
	GunWave(133,29,{{53,25},{21,15},{48,15},{55,25}},3,{{{25,56,53,48}, {P_8,P_5,P_6,P_7}, {4,6,3,3}, "MAX", nil, nil, nil, FP, 1},{{25,56,53,48}, {P_8,P_5,P_6,P_7}, {4,6,3,3}, "MAX", nil, nil, nil, FP, 1}})
	GunWave(133,30,{{53,25},{48,15},{55,25}},3,{{{25,19,77,29}, {S_6,P_6,P_6,P_5}, {1,2,3,1}, 10, nil, nil, nil, FP, 1},{{25,19,77,29}, {S_8,P_6,P_6,P_6}, {1,2,3,1}, 10, nil, nil, nil, FP, 1}})
	GunWave(133,31,{{53,25},{48,15},{55,25}},3,{{{25,17,78,29}, {S_6,P_6,P_6,P_5}, {1,2,3,1}, 10, nil, nil, nil, FP, 1},{{25,17,78,29}, {S_8,P_6,P_6,P_6}, {1,2,3,1}, 10, nil, nil, nil, FP, 1}})
	GunWave(133,32,{{53,25},{48,15},{55,25}},3,{{{25,10,17,28}, {S_6,P_5,P_6,P_7}, {1,2,3,3}, 10, nil, nil, nil, FP, 1},{{25,10,17,28}, {S_8,P_5,P_6,P_7}, {1,2,3,3}, 10, nil, nil, nil, FP, 1}})
	GunWave(133,33,{{53,25},{48,15},{55,25}},3,{{{25,23,19,28}, {S_6,P_5,P_6,P_7}, {1,1,3,3}, 10, nil, nil, nil, FP, 1},{{25,23,19,28}, {S_8,P_5,P_6,P_7}, {1,1,3,3}, 10, nil, nil, nil, FP, 1}})
	GunWave(133,43,{{53,25},{48,15},{55,25}},3,{{{98,79,56,77}, {P_6,P_5,P_6,P_7}, {2,3,3,4}, 10, nil, nil, nil, FP, 1},{{98,79,56,77}, {P_8,P_5,P_6,P_7}, {2,3,3,4}, 10, nil, nil, nil, FP, 1}})
	GunWave(133,44,{{53,25},{48,15},{55,25}},3,{{{98,79,56,78}, {P_6,P_8,P_6,P_7}, {2,1,3,4}, 10, nil, nil, nil, FP, 1},{{98,75,56,78}, {P_8,P_8,P_6,P_7}, {2,1,3,4}, 10, nil, nil, nil, FP, 1}})
	GunWave(148,34,{{53,20},{54,30},{48,15},{55,25}},4,{{{25,29}, "ACAS", {"LOvPF","LOverM"}, "MAX", nil, nil, nil, FP, 1},{{25,29}, "ACAS", {"LOvPF","LOverM"}, "MAX", nil, nil, nil, FP, 1}})
	GunWave(148,35,{{53,20},{54,30},{48,15},{55,25}},4,{{{25,29}, "ACAS", {"ROvPF","ROverM"}, "MAX", nil, nil, nil, FP, 1},{{25,29}, "ACAS", {"ROvPF","ROverM"}, "MAX", nil, nil, nil, FP, 1}})
	
	GunWave(150,36,{{51,15},{104,15},{56,25},{53,15},{54,20}},4,{{{98,79}, "ACAS", "Chry1", "MAX", nil, nil, nil, FP, 1},{{98,79}, "ACAS", "Chry1", "MAX", nil, nil, nil, FP, 1}})
	GunWave(150,37,{{51,15},{104,15},{56,25},{53,15},{54,20}},4,{{{98,79}, "ACAS", "Chry2", "MAX", nil, nil, nil, FP, 1},{{98,79}, "ACAS", "Chry2", "MAX", nil, nil, nil, FP, 1}})
	GunWave(150,38,{{51,15},{104,15},{56,25},{53,15},{54,20}},4,{{{98,29,79,17}, "ACAS", "Chry3", "MAX", nil, nil, nil, FP, 1},{{98,29,79,17}, "ACAS", "Chry3", "MAX", nil, nil, nil, FP, 1}}) -- 중보건물. 따로 안넣어도됨
	GunWave(150,39,{{51,15},{104,15},{56,25},{53,15},{54,20}},4,{{{29,17}, "ACAS", "Chry4", "MAX", nil, nil, nil, FP, 1},{{29,17}, "ACAS", "Chry4", "MAX", nil, nil, nil, FP, 1}})
	GunWave(150,40,{{51,15},{104,15},{56,25},{53,15},{54,20}},4,{{{29,17}, "ACAS", "Chry5", "MAX", nil, nil, nil, FP, 1},{{29,17}, "ACAS", "Chry5", "MAX", nil, nil, nil, FP, 1}})
	
	CIfXEnd()
	--PlayWAVX("staredit\\wav\\Glass.wav")

--	FRM=CIfGunWave2(173,5,1005)
--	CFor(FP, 0, 360, 90)
--	local CI = CForVariable()
--	FNA = CreateVar(FP)
--	f_Lengthdir(FP, _Add(CI,FNA), 250, CPosX, CPosY)
--	Simple_SetLocX(FP, 0, _Add(CPosX,1536),_Add(CPosY,1088),_Add(CPosX,1536),_Add(CPosY,1088))
--	DoActions(FP, {CreateUnit(1, 84, 1, FP),KillUnit(84, FP)})
--	CForEnd()
--	G_CA_SetSpawn({CD(FRM,0,AtLeast)}, {29}, "ACAS", "Form", "MAX", 18, nil, {0,0}, FP, 1)
--	G_CA_SetSpawn({CD(FRM,500,AtLeast)}, {162}, "ACAS", "Form", "MAX", 18, nil, {0,0}, FP, 1)
--	G_CA_SetSpawn({CD(FRM,1000,AtLeast)}, {30}, "ACAS", "Form", "MAX", 18, nil, {0,0}, FP, 1)
--	TriggerX(FP, {CD(FRM,0,AtLeast)}, {RotatePlayer({PlayWAVX("staredit\\wav\\glass.wav"),PlayWAVX("staredit\\wav\\glass.wav"),PlayWAVX("staredit\\wav\\glass.wav")}, HumanPlayers, FP)})
--	TriggerX(FP, {CD(FRM,500,AtLeast)}, {RotatePlayer({PlayWAVX("staredit\\wav\\glass.wav"),PlayWAVX("staredit\\wav\\glass.wav"),PlayWAVX("staredit\\wav\\glass.wav")}, HumanPlayers, FP)})
--	TriggerX(FP, {CD(FRM,1000,AtLeast)}, {RotatePlayer({PlayWAVX("staredit\\wav\\glass.wav"),PlayWAVX("staredit\\wav\\glass.wav"),PlayWAVX("staredit\\wav\\glass.wav")}, HumanPlayers, FP)})
--	CAdd(FP,FNA,1)
--	CIfEnd()
	TCC=CIfGunWave(168,46,1505,5)
	local NR = CreateCcode()
	GunCcode = CreateCcode()
	CurGunP = CreateVar(FP)
	DoActionsX(FP,{AddCD(NR,1)})
	CIfX(FP,{CD(GMode,0)})
	CAdd(FP,G_CA_X,CPosX)
	CAdd(FP,G_CA_Y,CPosY)
	f_TempRepeat({}, 88, 1, 201, FP)
	f_TempRepeat({}, 21, 1, 201, FP)
	CIf(FP,{CD(NR,10,AtLeast)},SubCD(NR,10))
	if X2_Map ==1 then
		f_TempRepeat({}, 29, 1, 201, FP,{1536*2,896*2})
		f_TempRepeat({}, 29, 1, 201, FP,{1696*2,768*2})
		f_TempRepeat({}, 29, 1, 201, FP,{1376*2,768*2})
		f_TempRepeat({}, 29, 1, 201, FP,{1536*2,672*2})
	else
	
		f_TempRepeat({}, 29, 1, 201, FP,{1536,896})
		f_TempRepeat({}, 29, 1, 201, FP,{1696,768})
		f_TempRepeat({}, 29, 1, 201, FP,{1376,768})
		f_TempRepeat({}, 29, 1, 201, FP,{1536,672})
		
	end
	CIfEnd()
	CElseX()
	CAdd(FP,G_CA_X,CPosX)
	CAdd(FP,G_CA_Y,CPosY)
	f_TempRepeat({}, 88, 1, 32, FP)
	f_TempRepeat({}, 21, 1, 32, FP)
	CIf(FP,{CD(NR,10,AtLeast)},SubCD(NR,10))
	if X2_Map ==1 then
		f_TempRepeat({}, 29, 1, 32, FP,{1536*2,896*2})
		f_TempRepeat({}, 29, 1, 32, FP,{1696*2,768*2})
		f_TempRepeat({}, 29, 1, 32, FP,{1376*2,768*2})
		f_TempRepeat({}, 29, 1, 32, FP,{1536*2,672*2})
	else
		f_TempRepeat({}, 29, 1, 32, FP,{1536,896})
		f_TempRepeat({}, 29, 1, 32, FP,{1696,768})
		f_TempRepeat({}, 29, 1, 32, FP,{1376,768})
		f_TempRepeat({}, 29, 1, 32, FP,{1536,672})
	end
	CIfEnd()

	CIfXEnd()
	
	for i = 0, 6 do
		TriggerX(FP, {CD(GMode,1),Kills(i, AtLeast, 1, 168)}, {SetV(CurGunP,i),SetKills(i, Subtract, 1, 168)})
	end

	for i = 0, 6 do
		CTrigger(FP, {CD(GMode,1),CV(CurGunP,i)}, {SetV(G_CA_X,PPosX[i+1]),SetV(G_CA_Y,PPosY[i+1])},{preserved})
	end
	NA = CreateVar(FP)
	f_Lengthdir(FP, 128, NA, CPosX, CPosY)
	CAdd(FP,NA,15)
	Simple_SetLocX(FP,0, _Add(G_CA_X,CPosX), _Add(G_CA_Y,CPosY), _Add(G_CA_X,CPosX), _Add(G_CA_Y,CPosY))
	CTrigger(FP, {CD(GMode,0)}, {Order(88, FP, 46, Move, 46),Order(21, FP, 46, Move, 46),Order(29, FP, 46, Move, 46)},{preserved})
	CTrigger(FP, {CD(GMode,1)}, {TOrder(88, FP, 64, Move, 1),TOrder(21, FP, 64, Move, 1),TOrder(29, FP, 64, Move, 1)},{preserved})


	TriggerX(FP, {CD(TCC,250),CD(GMode,0)}, {SetCD(TCC,999999),SetCp(FP),RunAIScriptAt(JYD, 46),SetInvincibility(Disable, "Men", FP, 64)})
	CIfOnce(FP,{CD(TCC,250),CD(GMode,1)})
		CFor(FP, 19025, 19025+(84*1700), 84)
		CI = CForVariable()
			CTrigger(FP, {TTOR({
				_TMemoryX(_Add(CI,25), Exactly, 88,0xFF),_TMemoryX(_Add(CI,25), Exactly, 21,0xFF),_TMemoryX(_Add(CI,25), Exactly, 29,0xFF),
			})}, {TSetMemoryX(_Add(CI,19), SetTo, 187*256, 0xFF00),
			TSetDeathsX(_Add(CI,18),SetTo,4000,0,0xFFFF)}, {preserved})
		CForEnd()
	CIfEnd()
	TriggerX(FP, {CD(TCC,250),CD(GMode,1)}, {SetCD(TCC,999999),SetCp(FP),RunAIScriptAt(JYD, 46),SetInvincibility(Disable, "Men", FP, 64)})
	CIf(FP,{CD(UTAGECcode,1,AtLeast),CD(TCC,999999,AtLeast)})
	CIfX(FP,{CD(GMode,0)})
	if X2_Map == 1 then
		f_TempRepeat({}, 88, 50, 188, FP,{1536*2,896*2})
		f_TempRepeat({}, 88, 50, 188, FP,{1696*2,768*2})
		f_TempRepeat({}, 88, 50, 188, FP,{1376*2,768*2})
		f_TempRepeat({}, 88, 50, 188, FP,{1536*2,672*2})
		f_TempRepeat({}, 21, 50, 188, FP,{1536*2,896*2})
		f_TempRepeat({}, 21, 50, 188, FP,{1696*2,768*2})
		f_TempRepeat({}, 21, 50, 188, FP,{1376*2,768*2})
		f_TempRepeat({}, 21, 50, 188, FP,{1536*2,672*2})
	else
		f_TempRepeat({}, 88, 50, 188, FP,{1536,896})
		f_TempRepeat({}, 88, 50, 188, FP,{1696,768})
		f_TempRepeat({}, 88, 50, 188, FP,{1376,768})
		f_TempRepeat({}, 88, 50, 188, FP,{1536,672})
		f_TempRepeat({}, 21, 50, 188, FP,{1536,896})
		f_TempRepeat({}, 21, 50, 188, FP,{1696,768})
		f_TempRepeat({}, 21, 50, 188, FP,{1376,768})
		f_TempRepeat({}, 21, 50, 188, FP,{1536,672})
	end
	CElseX()

	CAdd(FP,G_CA_X,CPosX)
	CAdd(FP,G_CA_Y,CPosY)
	
	if X2_Map == 1 then
		f_TempRepeat({}, 88, 1000, 188, FP)
		f_TempRepeat({}, 21, 1000, 188, FP)
	else
		if X2_Mode == 1 then
			f_TempRepeat({}, 88, 1000, 188, FP)
			f_TempRepeat({}, 21, 1000, 188, FP)
		else
			f_TempRepeat({}, 88, 300, 188, FP)
			f_TempRepeat({}, 21, 300, 188, FP)
		end
	end
	CIfXEnd()
	CIfEnd()
	CIfEnd()
	--TriggerX(FP, {}, {}, {preserved})
	Trigger2(FP, {Deaths(FP, AtLeast, 1, 131)}, {SetDeaths(FP, Subtract, 1, 131),SetScore(Force1, Add, 25000, Kills),RotatePlayer({DisplayTextX(StrDesignX("\x07부화장 파괴! \x1F+ 25,000 Pts"),4)}, HumanPlayers, FP)}, {preserved})
	Trigger2(FP, {Deaths(FP, AtLeast, 1, 132)}, {SetDeaths(FP, Subtract, 1, 132),SetScore(Force1, Add, 35000, Kills),RotatePlayer({DisplayTextX(StrDesignX("\x07번식지 파괴! \x1F+ 35,000 Pts"),4)}, HumanPlayers, FP)}, {preserved})
	Trigger2(FP, {Deaths(FP, AtLeast, 1, 133)}, {SetDeaths(FP, Subtract, 1, 133),SetScore(Force1, Add, 50000, Kills),RotatePlayer({DisplayTextX(StrDesignX("\x07군락 파괴! \x1F+ 50,000 Pts"),4)}, HumanPlayers, FP)}, {preserved})
	Trigger2(FP, {Deaths(FP, AtLeast, 1, 148)}, {SetDeaths(FP, Subtract, 1, 148),SetScore(Force1, Add, 80000, Kills),RotatePlayer({DisplayTextX(StrDesignX("\x07초월체 파괴! \x1F+ 80,000 Pts"),4)}, HumanPlayers, FP)}, {preserved})
	Trigger2(FP, {Deaths(FP, AtLeast, 1, 150)}, {SetDeaths(FP, Subtract, 1, 150),SetScore(Force1, Add, 50000, Kills),RotatePlayer({DisplayTextX(StrDesignX("\x07다 자란 번데기 파괴! \x1F+ 50,000 Pts"),4)}, HumanPlayers, FP)}, {preserved})
	Trigger2(FP, {Deaths(FP, AtLeast, 1, 168)}, {SetDeaths(FP, Subtract, 1, 168),SetScore(Force1, Add, 100000, Kills),RotatePlayer({DisplayTextX(StrDesignX("\x07정지장 파괴! \x1F+ 100,000 Pts"),4)}, HumanPlayers, FP)}, {preserved})
	Trigger2(FP, {Deaths(P12, AtLeast, 1, 173)}, {SetScore(Force1, Add, 1000000, Kills),RotatePlayer({DisplayTextX(StrDesignX("\x07조합소 파괴! \x1F+ 1,000,000 Pts"),4)}, HumanPlayers, FP)})

	G_CA_SetSpawn({Deaths(P12, AtLeast, 1, 173)}, {30}, "ACAS", "Form", "MAX", 18, nil, {0,0}, FP, 1)

	TriggerX(FP, {Deaths(P12, AtLeast, 1, 173)}, {RotatePlayer({PlayWAVX("staredit\\wav\\glass.wav"),PlayWAVX("staredit\\wav\\glass.wav"),PlayWAVX("staredit\\wav\\glass.wav")}, HumanPlayers, FP)})

	Trigger2X(FP,{Bring(FP, AtMost, 0, 130, 5)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04감염된 사령부 파괴! + 100,000 Pts"),4),DisplayTextX(StrDesignX("\x04이제부터 더 강력한 몬스터가 출현합니다."),4),DisplayTextX(StrDesignX("\x04중앙 \x03정지장 \x07무적 해제, \x03영웅마린 \x11바로뽑기 \x07해금"),4),MinimapPing(46)}, HumanPlayers, FP),SetScore(Force1, Add, 100000, Kills),SetCD(WaveS[1],1),SetInvincibility(Disable, 151, FP, 8),SetInvincibility(Disable, 168, FP, 46),SetInvincibility(Disable, 151, FP, 9),Order("Any unit", FP, 64, Attack, 2),
	SetMemoryB(0x57F27C + (0 * 228) + 20,SetTo,1),
	SetMemoryB(0x57F27C + (1 * 228) + 20,SetTo,1),
	SetMemoryB(0x57F27C + (2 * 228) + 20,SetTo,1),
	SetMemoryB(0x57F27C + (3 * 228) + 20,SetTo,1),
	SetMemoryB(0x57F27C + (4 * 228) + 20,SetTo,1),
	SetMemoryB(0x57F27C + (5 * 228) + 20,SetTo,1),
	SetMemoryB(0x57F27C + (6 * 228) + 20,SetTo,1),
	SetMemoryB(0x57F27C + (0 * 228) + 8,SetTo,1),
	SetMemoryB(0x57F27C + (1 * 228) + 8,SetTo,1),
	SetMemoryB(0x57F27C + (2 * 228) + 8,SetTo,1),
	SetMemoryB(0x57F27C + (3 * 228) + 8,SetTo,1),
	SetMemoryB(0x57F27C + (4 * 228) + 8,SetTo,1),
	SetMemoryB(0x57F27C + (5 * 228) + 8,SetTo,1),
	SetMemoryB(0x57F27C + (6 * 228) + 8,SetTo,1),
	})
	MB5 = CreateCcode()
	Trigger2X(FP,{Bring(FP, AtMost, 0, 151, 8)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04정신체 파괴! + 50,000 Pts"),4),DisplayTextX(StrDesignX("\x04이제부터 더 강력한 몬스터가 출현합니다."),4)}, HumanPlayers, FP),SetV(BGMType,5),SetScore(Force1, Add, 50000, Kills),SetCD(WaveS[2],1)})
	Trigger2X(FP,{Bring(FP, AtMost, 0, 151, 9)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04정신체 파괴! + 50,000 Pts"),4),DisplayTextX(StrDesignX("\x04이제부터 더 강력한 몬스터가 출현합니다."),4)}, HumanPlayers, FP),SetV(BGMType,5),SetScore(Force1, Add, 50000, Kills),SetCD(WaveS[3],1)})
	Trigger2X(FP,{Bring(FP, AtMost, 0, 201, 10)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04초월체 고치 파괴! + 80,000 Pts"),4),DisplayTextX(StrDesignX("\x04이제부터 더 강력한 몬스터가 출현합니다."),4)}, HumanPlayers, FP),SetV(BGMType,5),SetScore(Force1, Add, 80000, Kills),SetCD(WaveS[4],1)})
	Trigger2X(FP,{Bring(FP, AtMost, 0, 201, 11)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04초월체 고치 파괴! + 80,000 Pts"),4),DisplayTextX(StrDesignX("\x04이제부터 더 강력한 몬스터가 출현합니다."),4)}, HumanPlayers, FP),SetV(BGMType,5),SetScore(Force1, Add, 80000, Kills),SetCD(WaveS[5],1)})
	Trigger2X(FP,{Bring(FP, AtMost, 0, 152, 12)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04정신체 다고스 파괴! + 100,000 Pts"),4),DisplayTextX(StrDesignX("\x04감염된 듀란과 케리건을 처치하십시오!"),4)}, HumanPlayers, FP),SetV(BGMType,5),SetScore(Force1, Add, 100000, Kills),SetCD(WaveS[6],1)})
	Trigger2X(FP,{Bring(FP, AtMost, 0, 152, 13)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04정신체 다고스 파괴! + 100,000 Pts"),4),DisplayTextX(StrDesignX("\x04감염된 듀란과 케리건을 처치하십시오!"),4)}, HumanPlayers, FP),SetV(BGMType,5),SetScore(Force1, Add, 100000, Kills),SetCD(WaveS[7],1)})
	Trigger2X(FP,{},{SetInvincibility(Enable, 147, FP, 64)},{preserved})
	
	Trigger2X(FP,{CD(TCC,999999,AtLeast)},{SetInvincibility(Disable, "Men", FP, 64)},{preserved})

	if X2_Map ==1  then
	f_TempRepeat({CD(WaveS[6],1)},51,30,nil,FP,{1280*2,1968*2},1)
	f_TempRepeat({CD(WaveS[6],1)},104,30,nil,FP,{1280*2,1968*2},1)
	f_TempRepeat({CD(WaveS[7],1)},51,30,nil,FP,{1792*2,1968*2},1)
	f_TempRepeat({CD(WaveS[7],1)},104,30,nil,FP,{1792*2,1968*2},1)
	else
	f_TempRepeat({CD(WaveS[6],1)},51,30,nil,FP,{1280,1968},1)
	f_TempRepeat({CD(WaveS[6],1)},104,30,nil,FP,{1280,1968},1)
	f_TempRepeat({CD(WaveS[7],1)},51,30,nil,FP,{1792,1968},1)
	f_TempRepeat({CD(WaveS[7],1)},104,30,nil,FP,{1792,1968},1)
	end

	Trigger2X(FP,{CD(WaveS[6],1),CD(WaveS[7],1),Bring(FP,AtMost,0,51,64),Bring(FP,AtMost,0,104,64),CD(TCC,999999,AtLeast)},{SetCD(MB5,1)})
	if X2_Map == 1 then
		SetWave({CD(WaveS[1],0)},WaveT[1],{1536*2,1088*2},{{40,15},{37,10}})
		SetWave({CD(WaveS[1],1),CD(WaveS[2],0)},WaveT[2],{576*2,1024*2},{{38,2},{39,2},{43,1},{44,1}})
		SetWave({CD(WaveS[1],1),CD(WaveS[3],0)},WaveT[3],{2496*2,1024*2},{{38,4},{39,2},{43,1},{44,1}})
		SetWave({CD(WaveS[2],1),CD(WaveS[4],0)},WaveT[4],{1152*2,1568*2},{{50,1},{54,2},{53,2},{48,1},{55,2}})
		SetWave({CD(WaveS[3],1),CD(WaveS[5],0)},WaveT[5],{1920*2,1568*2},{{50,1},{54,2},{53,2},{48,1},{55,2}})
		SetWave({CD(WaveS[4],1),CD(WaveS[6],0)},WaveT[6],{1280*2,1872*2},{{56,5}})
		SetWave({CD(WaveS[5],1),CD(WaveS[7],0)},WaveT[7],{1792*2,1872*2},{{56,5}})
	else
		SetWave({CD(WaveS[1],0)},WaveT[1],{1536,1088},{{40,15},{37,10}})
		SetWave({CD(WaveS[1],1),CD(WaveS[2],0)},WaveT[2],{576,1024},{{38,13},{39,9},{43,4},{44,5}})
		SetWave({CD(WaveS[1],1),CD(WaveS[3],0)},WaveT[3],{2496,1024},{{38,13},{39,9},{43,4},{44,5}})
		SetWave({CD(WaveS[2],1),CD(WaveS[4],0)},WaveT[4],{1152,1568},{{50,5},{54,15},{53,10},{48,5},{55,9}})
		SetWave({CD(WaveS[3],1),CD(WaveS[5],0)},WaveT[5],{1920,1568},{{50,5},{54,15},{53,10},{48,5},{55,9}})
		SetWave({CD(WaveS[4],1),CD(WaveS[6],0)},WaveT[6],{1280,1872},{{56,25}})
		SetWave({CD(WaveS[5],1),CD(WaveS[7],0)},WaveT[7],{1792,1872},{{56,25}})
	end
	
	WinCcode = CreateCcode()
	
	TriggerX(FP,{CD(WinCcode,1,AtLeast)},{AddCD(WinCcode,1)},{preserved})
	Trigger2X(FP,{CD(WinCcode,150,AtLeast)},{RotatePlayer({Victory()}, MapPlayers,FP)})
	Trigger2X(FP,{CD(WinCcode,1,AtLeast)},{RotatePlayer({DisplayTextX(StrDesignX("\x04그렇게 우리는 \x08지옥같은 산들바람\x04의 원흉인 \x03카카루\x04를 제거하고 집으로 돌아갔다."), 4),DisplayTextX(StrDesignX("\x04Victory!!!"), 4)}, HumanPlayers,FP),})
	Trigger2X(FP,{CD(WinCcode,1,AtLeast),CD(GMode,0)},{RotatePlayer({DisplayTextX(StrDesignX("\x04플레이한 난이도 : 노말 X2"), 4)}, HumanPlayers,FP),})
	Trigger2X(FP,{CD(WinCcode,1,AtLeast),CD(GMode,1)},{RotatePlayer({DisplayTextX(StrDesignX("\x04플레이한 난이도 : \x11프로페셔널 X2"), 4)}, HumanPlayers,FP),})
	Trigger2X(FP,{CD(WinCcode,1,AtLeast),CD(UTAGECcode,1,AtLeast)},{RotatePlayer({DisplayTextX(StrDesignX("연회장 모드 적용됨"), 4)}, HumanPlayers,FP),})

	
	--WaveS[2] 라그나사우르
	--WaveS[3] 라이나돈
	--WaveS[4] 우르사돈
	--WaveS[5] 벤갈라스
	--MB5 다고스 두개이후 스캔티드
	--
	CIfOnce(FP, {Memory(0x628438, AtLeast, 1),CD(WaveS[2],1)},{})
	for i = 0, 6 do
			TriggerX(FP,{Kills(i,AtLeast,1,151)},{
				SetNVar(VFlagB[1],SetTo,2^i);
				SetNVar(VFlag256B[1],SetTo,(2^i)*256);
				SetKills(i,SetTo,0,151);
			},{preserved})
	end 


	f_Read(FP, 0x628438, nil, MBPtr[1])


	DoActions(FP, {CreateUnit(1, 95, 8, FP),RotatePlayer({DisplayTextX(StrDesignX("\x04중간보스 \x03라그나사우르 \x08출현!!!"), 4)}, HumanPlayers, FP)})
	if X2_Mode == 1 then
		CTrigger(FP, {}, {TSetMemory(_Add(MBPtr[1],2),SetTo,8320000*256)})
	end
	CIfEnd()


	CIf(FP,{Command(FP,AtLeast,1,95),CV(MBPtr[1],1,AtLeast)},{Simple_SetLoc(0, 0, 0, 0, 0),MoveLocation(49, 95, FP, 64),MoveLocation(1, 95, FP, 64)})
	
	CTrigger(FP,{CD(GMode,1),CV(VTimerB[1],1000,AtMost)},{
		TSetMemoryX(Vi(MBPtr[1][2],55),SetTo,0x100,0x100); -- 클로킹
		TSetMemoryX(Vi(MBPtr[1][2],57),SetTo,VFlagB[1],0xFF); -- 현재건작 유저 인식
		TSetMemoryX(Vi(MBPtr[1][2],73),SetTo,VFlag256B[1],0xFF00); -- 현재건작 유저 인식
		TSetMemoryX(Vi(MBPtr[1][2],72),SetTo,255*256,0xFF00); -- 어그로풀림 방지 ( 페러사이트 )
		TSetMemoryX(Vi(MBPtr[1][2],72),SetTo,255*16777216,0xFF000000); -- Blind ( 개별건작유닛 계급설정 )
		TSetMemoryX(Vi(MBPtr[1][2],35),SetTo,1,0xFF); -- 개별건작 표식
		TSetMemoryX(Vi(MBPtr[1][2],35),SetTo,1*256,0xFF00);
		AddV(VTimerB[1],1)
	},{preserved})
	CTrigger(FP,{CD(GMode,1),CV(VTimerB[1],1001,AtLeast)},{
		TSetMemoryX(Vi(MBPtr[1][2],72),SetTo,0*256,0xFF00);  -- Disable Parasite Flag
		TSetMemoryX(Vi(MBPtr[1][2],72),SetTo,0*16777216,0xFF000000);  -- Disable Blind
		TSetMemoryX(Vi(MBPtr[1][2],55),SetTo,0,0x100); -- 클로킹
		TSetMemoryX(Vi(MBPtr[1][2],57),SetTo,0xFF,0xFF); -- 현재건작 유저 인식
	},{preserved})



	MBPtC = CreateCcode()
	DoActionsX(FP, {SubCD(MBPtC,1)})
	CIf(FP,{CD(MBPtC,0)},{AddCD(MBPtC,120)})
	GetLocCenter(48, G_CA_X, G_CA_Y)
	f_TempRepeat({},13,10,nil,FP)
	f_TempRepeat({},50,10,nil,FP)
	CIfEnd()
	CIfEnd()


	CIfOnce(FP, {Memory(0x628438, AtLeast, 1),CD(WaveS[3],1)})
	
	for i = 0, 6 do
		TriggerX(FP,{Kills(i,AtLeast,1,151)},{
			SetNVar(VFlagB[2],SetTo,2^i);
			SetNVar(VFlag256B[2],SetTo,(2^i)*256);
			SetKills(i,SetTo,0,151);
		},{preserved})
end 
	f_Read(FP, 0x628438, nil, MBPtr[2])
	DoActions(FP, {CreateUnit(1, 89, 9, FP),RotatePlayer({DisplayTextX(StrDesignX("\x04중간보스 \x03라이나돈 \x08출현!!!"), 4)}, HumanPlayers, FP)})
	CIfEnd()

	CIf(FP,{Command(FP,AtLeast,1,89),CV(MBPtr[2],1,AtLeast)},{Simple_SetLoc(0, 0, 0, 0, 0),MoveLocation(1, 89, FP, 64)})
	
	CTrigger(FP,{CD(GMode,1),CV(VTimerB[2],1000,AtMost)},{
		TSetMemoryX(Vi(MBPtr[2][2],55),SetTo,0x100,0x100); -- 클로킹
		TSetMemoryX(Vi(MBPtr[2][2],57),SetTo,VFlagB[2],0xFF); -- 현재건작 유저 인식
		TSetMemoryX(Vi(MBPtr[2][2],73),SetTo,VFlag256B[2],0xFF00); -- 현재건작 유저 인식
		TSetMemoryX(Vi(MBPtr[2][2],72),SetTo,255*256,0xFF00); -- 어그로풀림 방지 ( 페러사이트 )
		TSetMemoryX(Vi(MBPtr[2][2],72),SetTo,255*16777216,0xFF000000); -- Blind ( 개별건작유닛 계급설정 )
		TSetMemoryX(Vi(MBPtr[2][2],35),SetTo,1,0xFF); -- 개별건작 표식
		TSetMemoryX(Vi(MBPtr[2][2],35),SetTo,1*256,0xFF00);
		AddV(VTimerB[2],1)
	},{preserved})
	CTrigger(FP,{CD(GMode,1),CV(VTimerB[2],1001,AtLeast)},{
		TSetMemoryX(Vi(MBPtr[2][2],72),SetTo,0*256,0xFF00);  -- Disable Parasite Flag
		TSetMemoryX(Vi(MBPtr[2][2],72),SetTo,0*16777216,0xFF000000);  -- Disable Blind
		TSetMemoryX(Vi(MBPtr[2][2],55),SetTo,0,0x100); -- 클로킹
		TSetMemoryX(Vi(MBPtr[2][2],57),SetTo,0xFF,0xFF); -- 현재건작 유저 인식
	},{preserved})


	if X2_Mode ==1 then
		if EVFMode == 1 then
			for i = 9,1,-1 do
				CTrigger(FP, {TMemory(_Add(MBPtr[2],2),AtMost,(100*i)*256)}, {CreateUnit(10, 84, 1, FP),KillUnit(84, FP),CreateUnitWithProperties(12, 74, 1, FP,{invincible = true})})
			end
		else
			for i = 14,1,-1 do
				CTrigger(FP, {TMemory(_Add(MBPtr[2],2),AtMost,(100*i)*256)}, {CreateUnit(10, 84, 1, FP),KillUnit(84, FP),CreateUnitWithProperties(12, 74, 1, FP,{invincible = true})})
			end
		end
	else
		if EVFMode == 1 then
			for i = 9,1,-1 do
				CTrigger(FP, {TMemory(_Add(MBPtr[2],2),AtMost,(100*i)*256)}, {CreateUnit(10, 84, 1, FP),KillUnit(84, FP),CreateUnitWithProperties(3, 74, 1, FP,{invincible = true})})
			end
		else
			for i = 14,1,-1 do
				CTrigger(FP, {TMemory(_Add(MBPtr[2],2),AtMost,(100*i)*256)}, {CreateUnit(10, 84, 1, FP),KillUnit(84, FP),CreateUnitWithProperties(3, 74, 1, FP,{invincible = true})})
			end
		end
	end
	CIfEnd()

	CIfOnce(FP, {Memory(0x628438, AtLeast, 1),CD(WaveS[4],1)})
	
	for i = 0, 6 do
		TriggerX(FP,{Kills(i,AtLeast,1,201)},{
			SetNVar(VFlagB[3],SetTo,2^i);
			SetNVar(VFlag256B[3],SetTo,(2^i)*256);
			SetKills(i,SetTo,0,201);
		},{preserved})
end 
	f_Read(FP, 0x628438, nil, MBPtr[3])
	DoActions(FP, {CreateUnit(1, 96, 10, FP),RotatePlayer({DisplayTextX(StrDesignX("\x04중간보스 \x03우르사돈 \x08출현!!!"), 4)}, HumanPlayers, FP)})
	if X2_Mode == 1 then
		CTrigger(FP, {}, {TSetMemory(_Add(MBPtr[3],2),SetTo,8320000*256)})
	end
	CIfEnd()


	CIf(FP,{Command(FP,AtLeast,1,96),CV(MBPtr[3],1,AtLeast)},{Simple_SetLoc(0, 0, 0, 0, 0),MoveLocation(49, 96, FP, 64),MoveLocation(1, 96, FP, 64)})
	
	CTrigger(FP,{CD(GMode,1),CV(VTimerB[3],1000,AtMost)},{
		TSetMemoryX(Vi(MBPtr[3][2],55),SetTo,0x100,0x100); -- 클로킹
		TSetMemoryX(Vi(MBPtr[3][2],57),SetTo,VFlagB[3],0xFF); -- 현재건작 유저 인식
		TSetMemoryX(Vi(MBPtr[3][2],73),SetTo,VFlag256B[3],0xFF00); -- 현재건작 유저 인식
		TSetMemoryX(Vi(MBPtr[3][2],72),SetTo,255*256,0xFF00); -- 어그로풀림 방지 ( 페러사이트 )
		TSetMemoryX(Vi(MBPtr[3][2],72),SetTo,255*16777216,0xFF000000); -- Blind ( 개별건작유닛 계급설정 )
		TSetMemoryX(Vi(MBPtr[3][2],35),SetTo,1,0xFF); -- 개별건작 표식
		TSetMemoryX(Vi(MBPtr[3][2],35),SetTo,1*256,0xFF00);
		AddV(VTimerB[3],1)
	},{preserved})
	CTrigger(FP,{CD(GMode,1),CV(VTimerB[3],1001,AtLeast)},{
		TSetMemoryX(Vi(MBPtr[3][2],72),SetTo,0*256,0xFF00);  -- Disable Parasite Flag
		TSetMemoryX(Vi(MBPtr[3][2],72),SetTo,0*16777216,0xFF000000);  -- Disable Blind
		TSetMemoryX(Vi(MBPtr[3][2],55),SetTo,0,0x100); -- 클로킹
		TSetMemoryX(Vi(MBPtr[3][2],57),SetTo,0xFF,0xFF); -- 현재건작 유저 인식
	},{preserved})
	GetLocCenter(48, G_CA_X, G_CA_Y)
	MBPtC = CreateCcode()
	DoActionsX(FP, {SubCD(MBPtC,1)})
	CIf(FP,{CD(MBPtC,0)},{AddCD(MBPtC,10),{RemoveUnit(1, FP)}})
		G_CA_SetSpawn({}, {1}, "ACAS", "Poly", "MAX", nil, nil, nil, FP)
	CIfEnd()
	CIfEnd()

	

	CIfOnce(FP, {Memory(0x628438, AtLeast, 1),CD(WaveS[5],1)})
	
	for i = 0, 6 do
		TriggerX(FP,{Kills(i,AtLeast,1,201)},{
			SetNVar(VFlagB[4],SetTo,2^i);
			SetNVar(VFlag256B[4],SetTo,(2^i)*256);
			SetKills(i,SetTo,0,201);
		},{preserved})
end 
	f_Read(FP, 0x628438, nil, MBPtr[4])
	DoActions(FP, {CreateUnit(1, 90, 11, FP),RotatePlayer({DisplayTextX(StrDesignX("\x04중간보스 \x03벤갈라스 \x08출현!!!"), 4)}, HumanPlayers, FP)})
	if X2_Mode == 1 then
		CTrigger(FP, {}, {TSetMemory(_Add(MBPtr[4],2),SetTo,8320000*256)})
	end
	CIfEnd()

	

	CIf(FP,{Command(FP,AtLeast,1,90),CV(MBPtr[4],1,AtLeast)},{Simple_SetLoc(0, 0, 0, 0, 0),MoveLocation(49, 90, FP, 64),MoveLocation(1, 90, FP, 64)})

	CTrigger(FP,{CD(GMode,1),CV(VTimerB[4],1000,AtMost)},{
		TSetMemoryX(Vi(MBPtr[4][2],55),SetTo,0x100,0x100); -- 클로킹
		TSetMemoryX(Vi(MBPtr[4][2],57),SetTo,VFlagB[4],0xFF); -- 현재건작 유저 인식
		TSetMemoryX(Vi(MBPtr[4][2],73),SetTo,VFlag256B[4],0xFF00); -- 현재건작 유저 인식
		TSetMemoryX(Vi(MBPtr[4][2],72),SetTo,255*256,0xFF00); -- 어그로풀림 방지 ( 페러사이트 )
		TSetMemoryX(Vi(MBPtr[4][2],72),SetTo,255*16777216,0xFF000000); -- Blind ( 개별건작유닛 계급설정 )
		TSetMemoryX(Vi(MBPtr[4][2],35),SetTo,1,0xFF); -- 개별건작 표식
		TSetMemoryX(Vi(MBPtr[4][2],35),SetTo,1*256,0xFF00);
		AddV(VTimerB[4],1)
	},{preserved})
	CTrigger(FP,{CD(GMode,1),CV(VTimerB[4],1001,AtLeast)},{
		TSetMemoryX(Vi(MBPtr[4][2],72),SetTo,0*256,0xFF00);  -- Disable Parasite Flag
		TSetMemoryX(Vi(MBPtr[4][2],72),SetTo,0*16777216,0xFF000000);  -- Disable Blind
		TSetMemoryX(Vi(MBPtr[4][2],55),SetTo,0,0x100); -- 클로킹
		TSetMemoryX(Vi(MBPtr[4][2],57),SetTo,0xFF,0xFF); -- 현재건작 유저 인식
	},{preserved})
	CIfEnd()


	CIfOnce(FP, {Memory(0x628438, AtLeast, 1),CD(MB5,1)})
	
	for i = 0, 6 do
		TriggerX(FP,{Kills(i,AtLeast,1,152)},{
			SetNVar(VFlagB[5],SetTo,2^i,2^i);
			SetNVar(VFlag256B[5],SetTo,(2^i)*256,(2^i)*256);
			SetKills(i,SetTo,0,152);
		},{preserved})
	end 
	f_Read(FP, 0x628438, nil, MBPtr[5])
	DoActions(FP, {CreateUnit(1, 93, 48, FP),RotatePlayer({DisplayTextX(StrDesignX("\x04중간보스 \x03스캔티드 \x08출현!!!"), 4)}, HumanPlayers, FP)})
	if X2_Mode == 1 then
		CTrigger(FP, {}, {TSetMemory(_Add(MBPtr[5],2),SetTo,4000000*256)})
	end
	CIfEnd()
	

	CIf(FP,{Command(FP,AtLeast,1,93),CV(MBPtr[5],1,AtLeast)},{Simple_SetLoc(0, 0, 0, 0, 0),MoveLocation(49, 93, FP, 64),MoveLocation(1, 93, FP, 64)})

	CTrigger(FP,{CD(GMode,1),CV(VTimerB[5],1000,AtMost)},{
		TSetMemoryX(Vi(MBPtr[5][2],55),SetTo,0x100,0x100); -- 클로킹
		TSetMemoryX(Vi(MBPtr[5][2],57),SetTo,VFlagB[5],0xFF); -- 현재건작 유저 인식
		TSetMemoryX(Vi(MBPtr[5][2],73),SetTo,VFlag256B[5],0xFF00); -- 현재건작 유저 인식
		TSetMemoryX(Vi(MBPtr[5][2],72),SetTo,255*256,0xFF00); -- 어그로풀림 방지 ( 페러사이트 )
		TSetMemoryX(Vi(MBPtr[5][2],72),SetTo,255*16777216,0xFF000000); -- Blind ( 개별건작유닛 계급설정 )
		TSetMemoryX(Vi(MBPtr[5][2],35),SetTo,1,0xFF); -- 개별건작 표식
		TSetMemoryX(Vi(MBPtr[5][2],35),SetTo,1*256,0xFF00);
		AddV(VTimerB[5],1)
	},{preserved})
	CTrigger(FP,{CD(GMode,1),CV(VTimerB[5],1001,AtLeast)},{
		TSetMemoryX(Vi(MBPtr[5][2],72),SetTo,0*256,0xFF00);  -- Disable Parasite Flag
		TSetMemoryX(Vi(MBPtr[5][2],72),SetTo,0*16777216,0xFF000000);  -- Disable Blind
		TSetMemoryX(Vi(MBPtr[5][2],55),SetTo,0,0x100); -- 클로킹
		TSetMemoryX(Vi(MBPtr[5][2],57),SetTo,0xFF,0xFF); -- 현재건작 유저 인식
	},{preserved})
	CIfEnd()


	TriggerX(FP, {Deaths(FP, AtLeast, 1, 95)}, {SetInvincibility(Disable, 201, FP, 10),RotatePlayer({PlayWAVX("staredit\\wav\\Bosskill.ogg"),PlayWAVX("staredit\\wav\\Bosskill.ogg"),PlayWAVX("staredit\\wav\\Bosskill.ogg"),DisplayTextX(StrDesignX("\x04중간보스 \x03라그나사우르 \x07처치!!! \x1F+ 500,000 Pts"), 4)}, HumanPlayers, FP),SetScore(Force1, Add, 500000, Kills)})
	TriggerX(FP, {Deaths(FP, AtLeast, 1, 89)}, {SetInvincibility(Disable, 201, FP, 11),RotatePlayer({PlayWAVX("staredit\\wav\\Bosskill.ogg"),PlayWAVX("staredit\\wav\\Bosskill.ogg"),PlayWAVX("staredit\\wav\\Bosskill.ogg"),DisplayTextX(StrDesignX("\x04중간보스 \x03라이나돈 \x07처치!!! \x1F+ 500,000 Pts"), 4)}, HumanPlayers, FP),SetScore(Force1, Add, 500000, Kills),KillUnit(74, FP)})
	TriggerX(FP, {Deaths(FP, AtLeast, 1, 96)}, {SetInvincibility(Disable, 152, FP, 12),RotatePlayer({PlayWAVX("staredit\\wav\\Bosskill.ogg"),PlayWAVX("staredit\\wav\\Bosskill.ogg"),PlayWAVX("staredit\\wav\\Bosskill.ogg"),DisplayTextX(StrDesignX("\x04중간보스 \x03우르사돈 \x07처치!!! \x1F+ 500,000 Pts"), 4)}, HumanPlayers, FP),SetScore(Force1, Add, 500000, Kills)})
	TriggerX(FP, {Deaths(FP, AtLeast, 1, 90)}, {SetInvincibility(Disable, 152, FP, 13),RotatePlayer({PlayWAVX("staredit\\wav\\Bosskill.ogg"),PlayWAVX("staredit\\wav\\Bosskill.ogg"),PlayWAVX("staredit\\wav\\Bosskill.ogg"),DisplayTextX(StrDesignX("\x04중간보스 \x03벤갈라스 \x07처치!!! \x1F+ 500,000 Pts"), 4)}, HumanPlayers, FP),SetScore(Force1, Add, 500000, Kills)})
	TriggerX(FP, {Deaths(FP, AtLeast, 1, 93)}, {RotatePlayer({PlayWAVX("staredit\\wav\\Bosskill.ogg"),PlayWAVX("staredit\\wav\\Bosskill.ogg"),PlayWAVX("staredit\\wav\\Bosskill.ogg"),DisplayTextX(StrDesignX("\x04중간보스 \x03스캔티드 \x07처치!!! \x1F+ 500,000 Pts"), 4)}, HumanPlayers, FP),KillUnit(190, P12),SetScore(Force1, Add, 500000, Kills)})
	TriggerX(FP, {Deaths(FP, AtLeast, 1, 90)}, {KillUnit(91, FP)},{preserved})
	
	TriggerX(FP, {Deaths(FP, AtLeast, 1, 93),Bring(FP,AtMost,1,"Buildings",64)}, {SetInvincibility(Disable, 147, FP, 64)},{preserved})
	TriggerX(FP, {Deaths(FP, AtLeast, 1, 96)}, {RemoveUnit(1, FP)},{preserved})
	
	--라그나사우르 : 주기적으로 자폭맨, 마인 생성
	--라이나돈 : 독립적 3000대(1500) 100대당 무적다크 1기 생성
	--우르사돈 : 안보이는 뿅뿅 스킬 계속 발사
	--밴갈라스 : 개빠른 평타로 뗴움

	--스캔티드 : 광범위 화염평타로 떼움


	CIfOnce(FP,{Bring(FP, AtMost, 0, 147, 64),Memory(0x628438, AtLeast, 1),},{SetDeathsX(Force1, Add, 100, 12, 0xFFFFFF),SetCD(BossStart,1),Order("Any unit", FP, 64, Attack, 47)})

	for i = 0, 6 do
		TriggerX(FP,{Kills(i,AtLeast,1,147)},{
			SetNVar(VFlagB[6],SetTo,2^i,2^i);
			SetNVar(VFlag256B[6],SetTo,(2^i)*256,(2^i)*256);
			SetKills(i,SetTo,0,147);
		},{preserved})
	end 
	BossPtr = CreateVar(FP)
	f_Read(FP, 0x628438, nil, BossPtr)
	DoActions(FP, {CreateUnit(1, 94, 47, FP)})
	if TestStart == 1 then
		DoActions(FP, {Order(94, FP, 64, Attack, 2)})
		
	end
	CIfEnd()
	NR = CreateVar(FP)
	CIf(FP,{Command(FP,AtLeast,1,94),CV(BossPtr,1,AtLeast)},{Simple_SetLoc(0, 0, 0, 0, 0),MoveLocation(1, 94, FP, 64),MoveLocation(49, 94, FP, 64)})
	if X2_Map == 1 then
		DoActions2(FP, {
			Simple_SetLoc(13, 1088*2, 1952*2, 1088*2, 1952*2),
			Simple_SetLoc(14, 1248*2, 1888*2, 1248*2, 1888*2),
			Simple_SetLoc(15, 1792*2, 1888*2, 1792*2, 1888*2),
			Simple_SetLoc(16, 1952*2, 1952*2, 1952*2, 1952*2)
		}, 1)
	else
		DoActions2(FP, {
			Simple_SetLoc(13, 1088, 1952, 1088, 1952),
			Simple_SetLoc(14, 1248, 1888, 1248, 1888),
			Simple_SetLoc(15, 1792, 1888, 1792, 1888),
			Simple_SetLoc(16, 1952, 1952, 1952, 1952)
		}, 1)
	end
	NoAirCollisionX(FP)
	DoActionsX(FP, {SetV(NR,164)}, 1)
	NSw = CreateCcode()
	GetLocCenter(48, G_CA_X, G_CA_Y)
	NA = CreateVar(FP)
	f_Lengthdir(FP, NR, NA, CPosX, CPosY)
	CAdd(FP,CPosX,G_CA_X)
	CAdd(FP,CPosY,G_CA_Y)
	Simple_SetLocX(FP, 0, CPosX, CPosY, CPosX, CPosY)
	DoActions(FP, {CreateUnitWithProperties(1, 84, 1, FP,{hallucinated=true})})
	f_Lengthdir(FP, NR, _Add(NA,60), CPosX, CPosY)
	CAdd(FP,CPosX,G_CA_X)
	CAdd(FP,CPosY,G_CA_Y)
	Simple_SetLocX(FP, 0, CPosX, CPosY, CPosX, CPosY)
	DoActions(FP, {CreateUnitWithProperties(1, 84, 1, FP,{hallucinated=true})})
	f_Lengthdir(FP, NR, _Add(NA,120), CPosX, CPosY)
	CAdd(FP,CPosX,G_CA_X)
	CAdd(FP,CPosY,G_CA_Y)
	Simple_SetLocX(FP, 0, CPosX, CPosY, CPosX, CPosY)
	DoActions(FP, {CreateUnitWithProperties(1, 84, 1, FP,{hallucinated=true})})
	f_Lengthdir(FP, NR, _Add(NA,180), CPosX, CPosY)
	CAdd(FP,CPosX,G_CA_X)
	CAdd(FP,CPosY,G_CA_Y)
	Simple_SetLocX(FP, 0, CPosX, CPosY, CPosX, CPosY)
	DoActions(FP, {CreateUnitWithProperties(1, 84, 1, FP,{hallucinated=true})})
	f_Lengthdir(FP, NR, _Add(NA,240), CPosX, CPosY)
	CAdd(FP,CPosX,G_CA_X)
	CAdd(FP,CPosY,G_CA_Y)
	Simple_SetLocX(FP, 0, CPosX, CPosY, CPosX, CPosY)
	DoActions(FP, {CreateUnitWithProperties(1, 84, 1, FP,{hallucinated=true})})
	f_Lengthdir(FP, NR, _Add(NA,300), CPosX, CPosY)
	CAdd(FP,CPosX,G_CA_X)
	CAdd(FP,CPosY,G_CA_Y)
	Simple_SetLocX(FP, 0, CPosX, CPosY, CPosX, CPosY)
	DoActions(FP, {CreateUnitWithProperties(1, 84, 1, FP,{hallucinated=true})})
	CiSub(FP,NA,2)

	TriggerX(FP, {CV(NR,164,AtLeast)}, {SetCD(NSw,0)}, {preserved})
	TriggerX(FP, {CV(NR,64,AtMost)}, {SetCD(NSw,1)}, {preserved})
	
	TriggerX(FP, {CD(NSw,0)}, {AddV(NR,-2)}, {preserved})
	TriggerX(FP, {CD(NSw,1)}, {AddV(NR,2)}, {preserved})
	
	CPt = CreateCcodeArr(7)
	CPt2 = CreateCcodeArr(7)
	CT = CreateCcode()
	CTrigger(FP, {CD(GMode,1)}, {SubCD(CT,1)},{preserved})
	DoActionsX(FP, {SubCD(CT,1)})
	TriggerX(FP,{CD(CPt[7],0),CD(CT,0)}, {SetInvincibility(Disable, 94, FP, 64)},{preserved})
	CIf(FP,{TMemory(_Add(BossPtr,2),AtMost,2500000*256),CD(GMode,1)},{MoveLocation(49, 94, FP, 64)})
	GetLocCenter(48, G_CA_X, G_CA_Y)
	CPC= CreateCcode()
	TriggerX(FP, {CD(CT,50,AtMost),CD(CT,1,AtLeast)}, {Order("Any unit", FP, 64, Move, 49)},{preserved})
	TriggerX(FP, {CD(CT,0,AtMost),CD(CPC,0,AtMost)}, {SetCD(CPC,1),Order("Any unit", FP, 64, Attack, 49)},{preserved})

	CIfEnd()
	CTrigger(FP, {TMemory(_Add(BossPtr,2),AtMost,7500000*256)}, {SetV(VTimerB[6],0),SetCD(CPt2[1],1),SetCD(CPC,0),AddCD(CT,50),SetInvincibility(Enable, 94, FP, 64)})
	CTrigger(FP, {TMemory(_Add(BossPtr,2),AtMost,7000000*256)}, {SetV(VTimerB[6],0),SetCD(CPt[1],1),SetCD(CPC,0),AddCD(CT,50),SetInvincibility(Enable, 94, FP, 64)})
	CTrigger(FP, {TMemory(_Add(BossPtr,2),AtMost,6500000*256)}, {SetV(VTimerB[6],0),SetCD(CPt2[2],1),SetCD(CPC,0),AddCD(CT,50),SetInvincibility(Enable, 94, FP, 64)})
	CTrigger(FP, {TMemory(_Add(BossPtr,2),AtMost,6000000*256)}, {SetV(VTimerB[6],0),SetCD(CPt[2],1),SetCD(CPC,0),AddCD(CT,50),SetInvincibility(Enable, 94, FP, 64)})
	CTrigger(FP, {TMemory(_Add(BossPtr,2),AtMost,5500000*256)}, {SetV(VTimerB[6],0),SetCD(CPt2[3],1),SetCD(CPC,0),AddCD(CT,50),SetInvincibility(Enable, 94, FP, 64)})
	CTrigger(FP, {TMemory(_Add(BossPtr,2),AtMost,5000000*256)}, {SetV(VTimerB[6],0),SetCD(CPt[3],1),SetCD(CPC,0),AddCD(CT,50),SetInvincibility(Enable, 94, FP, 64)})
	CTrigger(FP, {TMemory(_Add(BossPtr,2),AtMost,4500000*256)}, {SetV(VTimerB[6],0),SetCD(CPt2[4],1),SetCD(CPC,0),AddCD(CT,50),SetInvincibility(Enable, 94, FP, 64)})
	CTrigger(FP, {TMemory(_Add(BossPtr,2),AtMost,4000000*256)}, {SetV(VTimerB[6],0),SetCD(CPt[4],1),SetCD(CPC,0),AddCD(CT,50),SetInvincibility(Enable, 94, FP, 64)})
	CTrigger(FP, {TMemory(_Add(BossPtr,2),AtMost,3500000*256)}, {SetV(VTimerB[6],0),SetCD(CPt2[5],1),SetCD(CPC,0),AddCD(CT,50),SetInvincibility(Enable, 94, FP, 64)})
	CTrigger(FP, {TMemory(_Add(BossPtr,2),AtMost,3000000*256)}, {SetV(VTimerB[6],0),SetCD(CPt[5],1),SetCD(CPC,0),AddCD(CT,50),SetInvincibility(Enable, 94, FP, 64)})
	CTrigger(FP, {TMemory(_Add(BossPtr,2),AtMost,2500000*256)}, {SetV(VTimerB[6],0),SetCD(CPt2[6],1),SetCD(CPC,0),AddCD(CT,50),SetInvincibility(Enable, 94, FP, 64)})
	CTrigger(FP, {TMemory(_Add(BossPtr,2),AtMost,2000000*256)}, {SetV(VTimerB[6],0),SetCD(CPt[6],1),SetCD(CPC,0),AddCD(CT,50),SetInvincibility(Enable, 94, FP, 64)})
	CTrigger(FP, {TMemory(_Add(BossPtr,2),AtMost,1500000*256)}, {SetV(VTimerB[6],0),SetCD(CPt2[7],1),SetCD(CPC,0),AddCD(CT,50),SetInvincibility(Enable, 94, FP, 64)})
	CTrigger(FP, {TMemory(_Add(BossPtr,2),AtMost,1000000*256)}, {SetV(VTimerB[6],0),SetCD(CPt[7],1),SetCD(CPC,0),AddCD(CT,500000),SetInvincibility(Enable, "Any unit", AllPlayers, 64),SetDeaths(FP, SetTo, 1, 94),TSetMemory(_Add(BossPtr,2), SetTo, 1000000*256)},{preserved})
	if TestStart == 0 then
		CTrigger(FP, {CD(GMode,1),TMemory(_Add(BossPtr,2),AtMost,1500000*256),Bring(FP, AtLeast, 11, "Any unit", 64)}, {SetInvincibility(Enable, 94, FP, 64)},{preserved})
		
	end
	FBT = CreateCcode()
	CTrigger(FP, {TMemory(_Add(BossPtr,2),AtMost,1500000*256),CV(CreateUnitQueueNum,1,AtLeast)}, {SetInvincibility(Enable, 94, FP, 64)},{preserved})

	CTrigger(FP, {TMemory(_Add(BossPtr,2),AtMost,1500000*256),Bring(FP, AtMost, 200, "Any unit", 64),CD(FBT,0)}, {MoveUnit(All, "Men", FP, 64, 49),SetCD(FBT, 400)},{preserved})
	DoActionsX(FP, {SubCD(FBT, 1)})
	CIf(FP,CD(GMode,1))
	CunitCtrig_Part1(FP)
	MoveCp("X",70*4)
	NJumpX(FP,0x303,Deaths(CurrentPlayer,AtLeast,1*16777216,0)) -- GunTimer
	
	DoActions(FP,{ -- GunTimer Exactly 0
		MoveCp(Add,2*4);
		SetDeathsX(CurrentPlayer,SetTo,0*256,0,0xFF00); -- Disable Parasite Flag
		SetDeathsX(CurrentPlayer,SetTo,0*16777216,0,0xFF000000); -- Disable Blind
		MoveCp(Subtract,37*4);
		SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF); -- Unused 0x8C
		MoveCp(Add,20*4);
		SetDeathsX(CurrentPlayer,SetTo,0,0,0x100); -- Unused 0x8C

		MoveCp(Add,2*4);
		SetDeathsX(CurrentPlayer,SetTo,0xFF,0,0xFF); -- Unused 0x8C

		MoveCp(Add,15*4);
	})
	
	ClearCalc()
	NJumpXEnd(FP,0x303) -- If GunTimer AtLeast 1 (Arrival Point)
	
	DoActions(FP,MoveCp(Add,3*4)) -- Unused Timer
	
	for i = 0, 6 do -- If VFlag256 == 2^5, Set P6
	Trigger2(FP,{DeathsX(CurrentPlayer,Exactly,256*(2^i),0,256*(2^i))},{
		MoveCp(Subtract,16*4);
		SetDeathsX(CurrentPlayer,SetTo,2^i,0,2^i);
		MoveCp(Add,16*4)},{Preserved})
	end
	
	ClearCalc()
	CunitCtrig_Part2()
	CunitCtrig_Part3X()
	for i = 0, 1699 do
	CunitCtrig_Part4X(i,{
		DeathsX(EPDF(0x628298-0x150*i+(35*4)),Exactly,1,0,0xFF); -- EPD 35 Unused 0x8C
	},
	{
		SetDeathsX(EPDF(0x628298-0x150*i+(57*4)),SetTo,0,0,0xFF); -- 
		SetDeathsX(EPDF(0x628298-0x150*i+(55*4)),SetTo,0x100,0,0x100); -- 
		MoveCp(Add,70*4)})
	end
	CunitCtrig_End()
	CIfEnd()
	CIfOnce(FP,{CV(NR,64,AtMost)},{Simple_SetLoc(0, 0, 0, 0, 0),Simple_SetLoc(48, 0, 0, 16*32, 16*32),MoveLocation(1, 94, FP, 64),MoveLocation(49, 94, FP, 64)})
	GetLocCenter(48, G_CA_X, G_CA_Y)
		G_CA_SetSpawn({}, {88,77}, Cir, 4, "MAX", 18, nil, nil, FP, 1)
		DoActions(FP, {Order("Any unit", FP, 64, Attack, 49)})
	CIfEnd()
	CIfOnce(FP,{CD(CPt2[1],1)},{Simple_SetLoc(0, 0, 0, 0, 0),Simple_SetLoc(48, 0, 0, 16*32, 16*32),MoveLocation(1, 94, FP, 64),MoveLocation(49, 94, FP, 64)})
	GetLocCenter(48, G_CA_X, G_CA_Y)
		G_CA_SetSpawn({}, {21,17}, Cir, 3, "MAX", 18, nil, nil, FP, 1)
		DoActions(FP, {Order("Any unit", FP, 64, Attack, 49)})
	CIfEnd()
	CIfOnce(FP,{CD(CPt[1],1)},{Simple_SetLoc(0, 0, 0, 0, 0),Simple_SetLoc(48, 0, 0, 16*32, 16*32),MoveLocation(1, 94, FP, 64),MoveLocation(49, 94, FP, 64)})
	GetLocCenter(48, G_CA_X, G_CA_Y)
		G_CA_SetSpawn({}, {28,78}, Cir, 3, "MAX", 18, nil, nil, FP, 1)
		DoActions(FP, {Order("Any unit", FP, 64, Attack, 49)})
	CIfEnd()
	CIfOnce(FP,{CD(CPt2[2],1)},{Simple_SetLoc(0, 0, 0, 0, 0),Simple_SetLoc(48, 0, 0, 16*32, 16*32),MoveLocation(1, 94, FP, 64),MoveLocation(49, 94, FP, 64)})
	GetLocCenter(48, G_CA_X, G_CA_Y)
		G_CA_SetSpawn({}, {21,76}, Cir, 3, "MAX", 18, nil, nil, FP, 1)
		DoActions(FP, {Order("Any unit", FP, 64, Attack, 49)})
	CIfEnd()
	CIfOnce(FP,{CD(CPt[2],1)},{Simple_SetLoc(0, 0, 0, 0, 0),Simple_SetLoc(48, 0, 0, 16*32, 16*32),MoveLocation(1, 94, FP, 64),MoveLocation(49, 94, FP, 64)})
	GetLocCenter(48, G_CA_X, G_CA_Y)
		G_CA_SetSpawn({}, {88,78}, Cir, 4, "MAX", 18, nil, nil, FP, 1)
		DoActions(FP, {Order("Any unit", FP, 64, Attack, 49)})
	CIfEnd()
	CIfOnce(FP,{CD(CPt2[3],1)},{Simple_SetLoc(0, 0, 0, 0, 0),Simple_SetLoc(48, 0, 0, 16*32, 16*32),MoveLocation(1, 94, FP, 64),MoveLocation(49, 94, FP, 64)})
	GetLocCenter(48, G_CA_X, G_CA_Y)
		G_CA_SetSpawn({}, {88,17}, Cir, 3, "MAX", 18, nil, nil, FP, 1)
		DoActions(FP, {Order("Any unit", FP, 64, Attack, 49)})
	CIfEnd()
	CIfOnce(FP,{CD(CPt[3],1)},{Simple_SetLoc(0, 0, 0, 0, 0),Simple_SetLoc(48, 0, 0, 16*32, 16*32),MoveLocation(1, 94, FP, 64),MoveLocation(49, 94, FP, 64)})
	GetLocCenter(48, G_CA_X, G_CA_Y)
		G_CA_SetSpawn({}, {21,19}, Cir, 4, "MAX", 18, nil, nil, FP, 1)
		DoActions(FP, {Order("Any unit", FP, 64, Attack, 49)})
	CIfEnd()
	CIfOnce(FP,{CD(CPt2[4],1)},{Simple_SetLoc(0, 0, 0, 0, 0),Simple_SetLoc(48, 0, 0, 16*32, 16*32),MoveLocation(1, 94, FP, 64),MoveLocation(49, 94, FP, 64)})
	GetLocCenter(48, G_CA_X, G_CA_Y)
		G_CA_SetSpawn({}, {86,17}, Cir, 3, "MAX", 18, nil, nil, FP, 1)
		DoActions(FP, {Order("Any unit", FP, 64, Attack, 49)})
	CIfEnd()
	CIfOnce(FP,{CD(CPt[4],1)},{Simple_SetLoc(0, 0, 0, 0, 0),Simple_SetLoc(48, 0, 0, 16*32, 16*32),MoveLocation(1, 94, FP, 64),MoveLocation(49, 94, FP, 64)})
	GetLocCenter(48, G_CA_X, G_CA_Y)
		G_CA_SetSpawn({}, {28,25}, Cir, 3, "MAX", 18, nil, nil, FP, 1)
		DoActions(FP, {Order("Any unit", FP, 64, Attack, 49)})
	CIfEnd()
	CIfOnce(FP,{CD(CPt2[5],1)},{Simple_SetLoc(0, 0, 0, 0, 0),Simple_SetLoc(48, 0, 0, 16*32, 16*32),MoveLocation(1, 94, FP, 64),MoveLocation(49, 94, FP, 64)})
	GetLocCenter(48, G_CA_X, G_CA_Y)
		G_CA_SetSpawn({}, {29,75}, Cir, 1, "MAX", 18, nil, nil, FP, 1)
		G_CA_SetSpawn({}, {21,19}, Cir, 4, "MAX", 18, nil, nil, FP, 1)
		DoActions(FP, {Order("Any unit", FP, 64, Attack, 49)})
	CIfEnd()
	CIfOnce(FP,{CD(CPt[5],1)},{Simple_SetLoc(0, 0, 0, 0, 0),Simple_SetLoc(48, 0, 0, 16*32, 16*32),MoveLocation(1, 94, FP, 64),MoveLocation(49, 94, FP, 64)})
	GetLocCenter(48, G_CA_X, G_CA_Y)
		G_CA_SetSpawn({}, {29,10}, Cir, 2, "MAX", 18, nil, nil, FP, 1)
		DoActions(FP, {Order("Any unit", FP, 64, Attack, 49)})
	CIfEnd()
	CIfOnce(FP,{CD(CPt2[6],1)},{Simple_SetLoc(0, 0, 0, 0, 0),Simple_SetLoc(48, 0, 0, 16*32, 16*32),MoveLocation(1, 94, FP, 64),MoveLocation(49, 94, FP, 64)})
	GetLocCenter(48, G_CA_X, G_CA_Y)
		G_CA_SetSpawn({}, {29,78}, Cir, 3, "MAX", nil, nil, nil, FP, 1)
		DoActions(FP, {Order("Any unit", FP, 64, Attack, 49)})
	CIfEnd()
	CIfOnce(FP,{CD(CPt[6],1)},{Simple_SetLoc(0, 0, 0, 0, 0),Simple_SetLoc(48, 0, 0, 16*32, 16*32),MoveLocation(1, 94, FP, 64),MoveLocation(49, 94, FP, 64)})
	GetLocCenter(48, G_CA_X, G_CA_Y)
		G_CA_SetSpawn({}, {98,79}, Cir, 4, "MAX", nil, nil, nil, FP, 1)
		DoActions(FP, {Order("Any unit", FP, 64, Attack, 49)})
	CIfEnd()
	CIfOnce(FP,{CD(CPt2[7],1)},{Simple_SetLoc(0, 0, 0, 0, 0),Simple_SetLoc(48, 0, 0, 16*32, 16*32),MoveLocation(1, 94, FP, 64),MoveLocation(49, 94, FP, 64)})
	GetLocCenter(48, G_CA_X, G_CA_Y)
		G_CA_SetSpawn({}, {29,23}, Cir, 1, "MAX", nil, nil, nil, FP, 1)
		G_CA_SetSpawn({}, {19,86}, Cir, 4, "MAX", nil, nil, nil, FP, 1)
		DoActions(FP, {Order("Any unit", FP, 64, Attack, 49)})
	CIfEnd()
	


	CIfEnd()


	CIf(FP,{CD(BossStart,1)},{SetMemory(0x590000, SetTo, 0)})
	PCheckV = CreateVar(FP)
	WinCheck = CreateVar(FP)
	CMov(FP,PCheckV,0)
		TriggerX(FP, {Deaths(FP, AtLeast, 1, 94)}, {},{preserved})
		CMov(FP,WinCheck,0)
	for i = 0, 6 do
		CIf(FP,{HumanCheck(i, 1)},{AddV(PCheckV,1)})
		CDoActions(FP, {TSetDeathsX(i, Subtract, Dt, 12,0xFFFFFF)})
		for j = 1, 16 do
			BGMNum = j
			if BGMNum <= 9 then BGMNum = "0"..BGMNum end
			TriggerX(FP,{Deaths(FP, AtMost, 0, 94),DeathsX(i, AtMost, 100, 12,0xFFFFFF),DeathsX(i, AtMost, 0, 12,0xFF000000),Deaths(i, Exactly, j-1, 13)},{SetDeaths(i, Add, 1, 13),SetDeathsX(i, Add, 1500, 12, 0xFFFFFF),SetCp(i),PlayWAV("staredit\\wav\\Boss_0"..BGMNum..".ogg"),PlayWAV("staredit\\wav\\Boss_0"..BGMNum..".ogg")},{preserved})
		
		end
		TriggerX(FP, Deaths(i, AtLeast, 16, 13), {SetDeaths(i, Subtract, 16, 13)}, {preserved})
		TriggerX(FP, {Deaths(FP, AtLeast, 1, 94),DeathsX(i, AtMost, 100, 12,0xFFFFFF)}, {SetDeathsX(i, Add, 1500, 12,0xFFFFFF),SetCp(i),PlayWAV("staredit\\wav\\BossEnd.ogg"),PlayWAV("staredit\\wav\\BossEnd.ogg"),PlayWAV("staredit\\wav\\BossEnd.ogg")})
		TriggerX(FP, {Deaths(FP, AtLeast, 1, 94),DeathsX(i, AtMost, 100, 12,0xFFFFFF)}, {SetMemory(0x590000, SetTo, 1),},{preserved})
		TriggerX(FP, {Deaths(FP, AtLeast, 1, 94),Deaths(i, AtLeast, 1, 14)}, {AddV(WinCheck,1)},{preserved})
		DoActions(FP, {SetDeaths(i, SetTo, 0, 14)})
		CIfEnd()
	end
	for i = 0, 6 do
	TriggerX(FP, {CD(CPt[7],1),CV(WinCheck,i+1),CV(PCheckV,i+1)}, {AddCD(WinCcode,1),KillUnit("Any unit", FP)})
	end


	CIfEnd()
	Create_G_CA_Arr()
end