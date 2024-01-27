
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
--Sample
--{G_CA_CUTable, G_CA_SNTable, G_CA_SLTable, "MAX", 1, nil, FP, 1}
--G_CA_SetSpawn({CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},"ACAS",{"L00_1_164F"},"MAX")
--G_CA_SetSpawn({Gun_Line(5,Exactly,0)},ZergUnit1,{P_4,S_5},{4,2})

function GunWave(GunID,LocID,NUTable,BGMTypes,G_CA_args)
	local GunCcode = CreateCcode()
	local CountMax = 0
	local NUTableCnt = 0
	local G_CA_argsCnt = 0
	if G_CA_args then
		G_CA_argsCnt = #G_CA_args
	end

	CountMax = math.max(CountMax, #NUTable, G_CA_argsCnt)
	TriggerX(FP, CommandLeastAt(GunID,LocID), {SetCD(GunCcode,1),SetV(BGMType,BGMTypes)})
	CIf(FP,{CD(GunCcode,1,AtLeast),CD(GunCcode,480*CountMax,AtMost)},{AddCD(GunCcode,1)})
		GetLocCenter(LocID-1, G_CA_X, G_CA_Y)
		local NUCArr = {}
		
		if G_CA_args then
		for j,k in pairs(G_CA_args) do
			G_CA_SetSpawn({CD(GunCcode,2+(480*(j-1)))},{84},k[2],k[3],"MAX",nil,nil,nil,FP,1)
		end
		end
		for j, k in pairs(NUTable) do
			local NUCcode = CreateCcode()
			table.insert(NUCArr,SetCD(NUCcode,0))
			f_TempRepeatX({CD(NUCcode,48,AtLeast),CD(NUCcode,48+k[2]-1,AtMost)},k[1],1,nil,FP)
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
	
	GunWave(132,20,{{38,10},{39,15},{39,10},{43,16},{44,9}},3,{{{77,56}, P_3, 2, "MAX", nil, nil, nil, FP, 1},{{77,56}, P_5, 2, "MAX", nil, nil, nil, FP, 1}})
	GunWave(132,21,{{38,10},{39,15},{39,10},{43,16},{44,9}},3,{{{78,56}, P_3, 2, "MAX", nil, nil, nil, FP, 1},{{78,56}, P_5, 2, "MAX", nil, nil, nil, FP, 1}})

	GunWave(132,41,{{38,10},{39,15},{39,10},{43,16},{44,9}},3,{{{17,56}, P_4, 2, "MAX", nil, nil, nil, FP, 1},{{17,56}, P_5, 2, "MAX", nil, nil, nil, FP, 1}})
	GunWave(132,42,{{38,10},{39,15},{39,10},{43,16},{44,9}},3,{{{19,56}, P_3, 2, "MAX", nil, nil, nil, FP, 1},{{19,56}, P_4, 2, "MAX", nil, nil, nil, FP, 1}})

	GunWave(133,22,{{38,25},{39,15},{44,25}},4,{{{10,21}, P_5, 2, "MAX", nil, nil, nil, FP, 1},{{10,21}, P_4, 3, "MAX", nil, nil, nil, FP, 1}})
	GunWave(133,23,{{38,25},{39,15},{44,25}},4,{{{78,88}, P_3, 3, "MAX", nil, nil, nil, FP, 1},{{78,88}, P_4, 3, "MAX", nil, nil, nil, FP, 1}})

	GunWave(131,24,{{54,20},{53,15}},2,{{{53,56}, P_5, 2, "MAX", nil, nil, nil, FP, 1},{{48,56}, P_4, 3, "MAX", nil, nil, nil, FP, 1}})
	GunWave(131,25,{{54,20},{53,15}},2,{{{53,56}, P_5, 2, "MAX", nil, nil, nil, FP, 1},{{48,56}, P_4, 3, "MAX", nil, nil, nil, FP, 1}})

	GunWave(132,26,{{53,20},{54,15},{48,20},{54,16}},3,{{{56,86,77}, {P_5,P_6,P_5}, {4,1,2}, "MAX", nil, nil, nil, FP, 1},{{56,86,77}, {P_5,P_6,P_4}, {4,1,2}, "MAX", nil, nil, nil, FP, 1}})
	GunWave(132,27,{{53,20},{54,15},{48,20},{54,16}},3,{{{56,86,78}, {P_5,P_6,P_5}, {4,1,2}, "MAX", nil, nil, nil, FP, 1},{{56,86,78}, {P_5,P_6,P_4}, {4,1,2}, "MAX", nil, nil, nil, FP, 1}})
	GunWave(133,28,{{53,25},{21,15},{48,15},{55,25}},4,{{{25,56,53,48}, {P_5,P_5,P_6,P_7}, {1,3,3,3}, "MAX", nil, nil, nil, FP, 1},{{25,56,53,48}, {P_5,P_5,P_6,P_7}, {1,3,3,3}, "MAX", nil, nil, nil, FP, 1}})
	GunWave(133,29,{{53,25},{21,15},{48,15},{55,25}},4,{{{25,56,53,48}, {P_5,P_5,P_6,P_7}, {1,3,3,3}, "MAX", nil, nil, nil, FP, 1},{{25,56,53,48}, {P_5,P_5,P_6,P_7}, {1,3,3,3}, "MAX", nil, nil, nil, FP, 1}})
	GunWave(133,30,{{53,25},{48,15},{55,25}},4)
	GunWave(133,31,{{53,25},{48,15},{55,25}},4)
	GunWave(133,32,{{53,25},{48,15},{55,25}},4)
	GunWave(133,33,{{53,25},{48,15},{55,25}},4)
	GunWave(133,43,{{53,25},{48,15},{55,25}},4)
	GunWave(133,44,{{53,25},{48,15},{55,25}},4)
	GunWave(148,34,{{53,20},{54,30},{48,15},{55,25}},5,{{{25,28}, "ACAS", "LOverM", "MAX", nil, nil, nil, FP, 1},{{25,28}, "ACAS", "LOverM", "MAX", nil, nil, nil, FP, 1}})
	GunWave(148,35,{{53,20},{54,30},{48,15},{55,25}},5,{{{25,28}, "ACAS", "ROverM", "MAX", nil, nil, nil, FP, 1},{{25,28}, "ACAS", "ROverM", "MAX", nil, nil, nil, FP, 1}})
	
	




	GunWave(150,36,{{51,3},{104,5},{56,25},{53,15},{54,20}},5)
	GunWave(150,37,{{51,3},{104,5},{56,25},{53,15},{54,20}},5)
	GunWave(150,38,{{51,3},{104,5},{56,25},{53,15},{54,20}},5)
	GunWave(150,39,{{51,3},{104,5},{56,25},{53,15},{54,20}},5)
	GunWave(150,40,{{51,3},{104,5},{56,25},{53,15},{54,20}},5)
	TCC=CIfGunWave(168,46,1505,5)
	local NR = CreateCcode()
	DoActionsX(FP,{AddCD(NR,1)})
	f_TempRepeat({}, 88, 1, 201, FP)
	f_TempRepeat({}, 21, 1, 201, FP)
	CIf(FP,{CD(NR,10,AtLeast)},SubCD(NR,10))
	f_TempRepeat({}, 29, 1, 201, FP,{1536,896})
	f_TempRepeat({}, 29, 1, 201, FP,{1696,768})
	f_TempRepeat({}, 29, 1, 201, FP,{1376,768})
	f_TempRepeat({}, 29, 1, 201, FP,{1536,672})
	CIfEnd()
	DoActions(FP, {Order(88, FP, 46, Move, 46),Order(21, FP, 46, Move, 46),Order(29, FP, 46, Move, 46),})
	TriggerX(FP, {CD(TCC,250)}, {SetCD(TCC,999999),SetCp(FP),RunAIScriptAt(JYD, 46),SetInvincibility(Disable, "Men", FP, 46)})
	CIfEnd()
	--TriggerX(FP, {}, {}, {preserved})
	Trigger2(FP, {Deaths(FP, AtLeast, 1, 131)}, {SetDeaths(FP, Subtract, 1, 131),SetScore(Force1, Add, 25000, Kills),RotatePlayer({DisplayTextX(StrDesignX("\x07부화장 파괴! \x1F+ 25,000 Pts"),4)}, HumanPlayers, FP)}, {preserved})
	Trigger2(FP, {Deaths(FP, AtLeast, 1, 132)}, {SetDeaths(FP, Subtract, 1, 132),SetScore(Force1, Add, 35000, Kills),RotatePlayer({DisplayTextX(StrDesignX("\x07번식지 파괴! \x1F+ 35,000 Pts"),4)}, HumanPlayers, FP)}, {preserved})
	Trigger2(FP, {Deaths(FP, AtLeast, 1, 133)}, {SetDeaths(FP, Subtract, 1, 133),SetScore(Force1, Add, 50000, Kills),RotatePlayer({DisplayTextX(StrDesignX("\x07군락 파괴! \x1F+ 50,000 Pts"),4)}, HumanPlayers, FP)}, {preserved})
	Trigger2(FP, {Deaths(FP, AtLeast, 1, 148)}, {SetDeaths(FP, Subtract, 1, 148),SetScore(Force1, Add, 80000, Kills),RotatePlayer({DisplayTextX(StrDesignX("\x07초월체 파괴! \x1F+ 80,000 Pts"),4)}, HumanPlayers, FP)}, {preserved})
	Trigger2(FP, {Deaths(FP, AtLeast, 1, 150)}, {SetDeaths(FP, Subtract, 1, 150),SetScore(Force1, Add, 50000, Kills),RotatePlayer({DisplayTextX(StrDesignX("\x07다 자란 번데기 파괴! \x1F+ 50,000 Pts"),4)}, HumanPlayers, FP)}, {preserved})
	Trigger2(FP, {Deaths(FP, AtLeast, 1, 168)}, {SetDeaths(FP, Subtract, 1, 168),SetScore(Force1, Add, 100000, Kills),RotatePlayer({DisplayTextX(StrDesignX("\x07정지장 파괴! \x1F+ 100,000 Pts"),4)}, HumanPlayers, FP)}, {preserved})


	Trigger2X(FP,{Bring(FP, AtMost, 0, 130, 5)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04감염된 사령부 파괴! + 100,000 Pts"),4),DisplayTextX(StrDesignX("\x04이제부터 더 강력한 몬스터가 출현합니다."),4),DisplayTextX(StrDesignX("\x04중앙 \x03정지장 \x07무적 해제."),4),MinimapPing(46)}, HumanPlayers, FP),SetScore(Force1, Add, 100000, Kills),SetCD(WaveS[1],1),SetInvincibility(Disable, 151, FP, 8),SetInvincibility(Disable, 168, FP, 46),SetInvincibility(Disable, 151, FP, 9),Order("Any unit", FP, 64, Attack, 2)})
	Trigger2X(FP,{Bring(FP, AtMost, 0, 151, 8)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04정신체 파괴! + 50,000 Pts"),4),DisplayTextX(StrDesignX("\x04이제부터 더 강력한 몬스터가 출현합니다."),4)}, HumanPlayers, FP),SetScore(Force1, Add, 50000, Kills),SetCD(WaveS[2],1),SetInvincibility(Disable, 201, FP, 10)})
	Trigger2X(FP,{Bring(FP, AtMost, 0, 151, 9)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04정신체 파괴! + 50,000 Pts"),4),DisplayTextX(StrDesignX("\x04이제부터 더 강력한 몬스터가 출현합니다."),4)}, HumanPlayers, FP),SetScore(Force1, Add, 50000, Kills),SetCD(WaveS[3],1),SetInvincibility(Disable, 201, FP, 11)})
	Trigger2X(FP,{Bring(FP, AtMost, 0, 201, 10)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04초월체 고치 파괴! + 80,000 Pts"),4),DisplayTextX(StrDesignX("\x04이제부터 더 강력한 몬스터가 출현합니다."),4)}, HumanPlayers, FP),SetScore(Force1, Add, 80000, Kills),SetCD(WaveS[4],1),SetInvincibility(Disable, 152, FP, 12)})
	Trigger2X(FP,{Bring(FP, AtMost, 0, 201, 11)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04초월체 고치 파괴! + 80,000 Pts"),4),DisplayTextX(StrDesignX("\x04이제부터 더 강력한 몬스터가 출현합니다."),4)}, HumanPlayers, FP),SetScore(Force1, Add, 80000, Kills),SetCD(WaveS[5],1),SetInvincibility(Disable, 152, FP, 13)})
	Trigger2X(FP,{Bring(FP, AtMost, 0, 152, 12)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04정신체 다고스 파괴! + 100,000 Pts"),4),DisplayTextX(StrDesignX("\x04감염된 듀란과 케리건을 처치하십시오!"),4)}, HumanPlayers, FP),SetScore(Force1, Add, 100000, Kills),SetCD(WaveS[6],1)})
	Trigger2X(FP,{Bring(FP, AtMost, 0, 152, 13)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04정신체 다고스 파괴! + 100,000 Pts"),4),DisplayTextX(StrDesignX("\x04감염된 듀란과 케리건을 처치하십시오!"),4)}, HumanPlayers, FP),SetScore(Force1, Add, 100000, Kills),SetCD(WaveS[7],1)})
	Trigger2X(FP,{},{SetInvincibility(Enable, 147, FP, 64)},{preserved})
	Trigger2X(FP,{CD(WaveS[6],1),CD(WaveS[7],1),Bring(FP,AtMost,0,51,64),Bring(FP,AtMost,0,104,64),CD(TCC,999999,AtLeast),Bring(FP,AtMost,1,"Buildings",64)},{SetInvincibility(Disable, 147, FP, 64)},{preserved})
	SetWave({CD(WaveS[1],0)},WaveT[1],{1536,1088},{{40,15},{37,10}})
	SetWave({CD(WaveS[1],1),CD(WaveS[2],0)},WaveT[2],{576,1024},{{38,13},{39,9},{43,4},{44,5}})
	SetWave({CD(WaveS[1],1),CD(WaveS[3],0)},WaveT[3],{2496,1024},{{38,13},{39,9},{43,4},{44,5}})
	SetWave({CD(WaveS[2],1),CD(WaveS[4],0)},WaveT[4],{1152,1568},{{50,5},{54,15},{53,10},{48,5},{55,9}})
	SetWave({CD(WaveS[3],1),CD(WaveS[5],0)},WaveT[5],{1920,1568},{{50,5},{54,15},{53,10},{48,5},{55,9}})
	SetWave({CD(WaveS[4],1),CD(WaveS[6],0)},WaveT[6],{1280,1872},{{56,25}})
	SetWave({CD(WaveS[5],1),CD(WaveS[7],0)},WaveT[7],{1792,1872},{{56,25}})
	
	f_TempRepeat({CD(WaveS[6],1)},51,15,nil,FP,{1280,1968},1)
	f_TempRepeat({CD(WaveS[6],1)},104,15,nil,FP,{1280,1968},1)
	f_TempRepeat({CD(WaveS[7],1)},51,15,nil,FP,{1792,1968},1)
	f_TempRepeat({CD(WaveS[7],1)},104,15,nil,FP,{1792,1968},1)
	WinCcode = CreateCcode()
	Trigger2X(FP,{Bring(FP, AtMost, 0, 147, 64)},{RotatePlayer({DisplayTextX(StrDesignX("\x04그렇게 우리는 모든 괴물들을 처치하고 집으로 돌아갔다."), 4),DisplayTextX(StrDesignX("\x04Victory!!!"), 4)}, MapPlayers,FP),AddCD(WinCcode,1)})
	TriggerX(FP,{CD(WinCcode,1,AtLeast)},{AddCD(WinCcode,1)},{preserved})
	Trigger2X(FP,{CD(WinCcode,150,AtLeast)},{RotatePlayer({Victory()}, MapPlayers,FP)})

	Create_G_CA_Arr()
end