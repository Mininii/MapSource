function Waves()
	CIf(FP,Switch("Switch 201",Set))
	--ElapsedTimeX(Comparison, Time)
	if X2_Mode == 1 then
		CallXYArr = {{3552*2,160*2},{3872*2,160*2},{3552*2,416*2},{3872*2,416*2}}
	else
		CallXYArr = {{3552,160},{3872,160},{3552,416},{3872,416}}
	end
	
	function CallSet(Time,CUTable,TimerFlag,NoticeFlag)
		if TimerFlag==1 then
			for i = 1,5 do
				TriggerX(FP,{CD(GMode,1),ElapsedTimeX(Exactly,Time-(i*2))},{RotatePlayer({DisplayTextX("\x13\x04"..i.."초 남았습니다.",4)},HumanPlayers,FP),SetCD(ButtonSound,1)})
			end
		end
		local Y
		if NoticeFlag == 1 then Y = SetCD(NoticeCD,1) else Y =nil end
		Trigger2X(FP,{ElapsedTimeX(Exactly,Time)},{
			SetMemoryX(0x666458, SetTo, 391,0xFFFF),
			Simple_SetLoc(0,CallXYArr[1][1],CallXYArr[1][2],CallXYArr[1][1],CallXYArr[1][2]),CreateUnit(1,33,1,FP),CreateUnit(1,84,1,FP),
			Simple_SetLoc(0,CallXYArr[2][1],CallXYArr[2][2],CallXYArr[2][1],CallXYArr[2][2]),CreateUnit(1,33,1,FP),CreateUnit(1,84,1,FP),
			Simple_SetLoc(0,CallXYArr[3][1],CallXYArr[3][2],CallXYArr[3][1],CallXYArr[3][2]),CreateUnit(1,33,1,FP),CreateUnit(1,84,1,FP),
			Simple_SetLoc(0,CallXYArr[4][1],CallXYArr[4][2],CallXYArr[4][1],CallXYArr[4][2]),CreateUnit(1,33,1,FP),CreateUnit(1,84,1,FP),RemoveUnit(33,FP),KillUnit(84,FP),
			SetMemoryX(0x666458, SetTo, 546,0xFFFF),Y
		})
		for j, k in pairs(CUTable) do
			for i = 1, 4 do
			f_TempRepeat(ElapsedTimeX(Exactly,Time),k[1],k[2],nil,nil,CallXYArr[i],1)
			end
		end
	end

	CallSet(180,{{48,3},{55,4},{54,3},{53,3}},1,1)
	CallSet(427,{{48,7},{56,9},{51,5},{104,5}},1,1)
	CallSet(852,{{51,25},{56,25}},1,1)
	CallSet(1290,{{51,25},{56,25}},1,1)
	CallSet(1580,{{51,25},{56,25}},1,1)
	CIf(FP,{CD(GMode,2)})
		CallSet(365,{{77,3}})
		CallSet(620,{{25,6}})
		CallSet(900,{{78,5}})
		CallSet(1159,{{29,6}})
	CIfEnd()
	CIf(FP,{CD(GMode,3)})
		CallSet(390,{{77,10}})
		CallSet(700,{{78,15}})
		CallSet(900,{{25,15},{30,5}})
		CallSet(1000,{{13,25},{88,15}})
		CallSet(1250,{{27,11},{19,30}})
		CallSet(1680,{{76,35},{88,40}})
		CallSet(2370,{{17,30},{102,1}})
		CallSet(2800,{{10,40},{29,11}})
		CallSet(3200,{{79,50},{80,10}})
	CIfEnd()
	for i = 1, 10 do
		CallSet(1850*i,{
			{28,4},{88,5},{21,5},{17,3},{77,3},{78,3},
		},1,1)
		
	end
	
	local WaveT = CreateCcode()
	local WaveT2 = CreateCcode()
	local DGDeath = CreateCcode()
	local WarpDeath = CreateCcode()
	Trigger2X(FP,{CommandLeastAt(189,20)},{AddCD(WarpDeath,1),SetScore(Force1,Add,500000,Kills),AddV(ExRateV,50),RotatePlayer({DisplayTextX("\n\n\n\n\n\x13\x08！ ！ ！ \x04적의 생산기지 \x18Warp Gate\x04를 파괴하였다!\x17 + 500000 P t s, \x1F+ 5.0% Exchange Rate\x08 ！ ！ ！\n\n",4),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav")},HumanPlayers,FP)})
	
	CIf(FP,{ElapsedTimeX(AtMost,60*120),CD(WarpDeath,0)},{AddCD(WaveT,1)})
		CIf(FP,CD(WaveT,3000,AtLeast),SetCD(WaveT,0))
		if X2_Mode == 1 then
			DG1XY = {432*2,688*2}
		else
			DG1XY = {432,688}
		end

		f_TempRepeat({ElapsedTimeX(AtLeast,1200)},61,1,nil,FP,DG1XY,1)
		f_TempRepeat({ElapsedTimeX(AtLeast,1800),CD(GMode,2,AtLeast)},68,1,nil,FP,DG1XY,1)
		f_TempRepeat({ElapsedTimeX(AtLeast,2400),CD(GMode,2,AtLeast)},102,1,nil,FP,DG1XY,1)
		f_TempRepeat({ElapsedTimeX(AtMost,600)},54,15,nil,FP,DG1XY)
		f_TempRepeat({ElapsedTimeX(AtMost,600)},53,15,nil,FP,DG1XY)
		f_TempRepeat({ElapsedTimeX(AtMost,600)},55,25,nil,FP,DG1XY)
		f_TempRepeat({ElapsedTimeX(AtLeast,600)},48,10,nil,FP,DG1XY)
		f_TempRepeat({ElapsedTimeX(AtLeast,600)},104,10,nil,FP,DG1XY)
		f_TempRepeat({ElapsedTimeX(AtLeast,600)},51,15,nil,FP,DG1XY)
		CIfEnd()
	CIfEnd()
	
	Trigger2X(FP,{CommandLeastAt(152,18)},{AddCD(DGDeath,1),SetScore(Force1,Add,100000,Kills),SetInvincibility(Disable,152,FP,19),RotatePlayer({DisplayTextX("\n\n\n\n\n\x13\x08！ ！ ！ \x04적의 생산기지 \x18Daggoth\x04를 파괴하였다!\x17 + 100000 P t s\x08 ！ ！ ！\n\n",4),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav")},HumanPlayers,FP)})
	Trigger2X(FP,{CommandLeastAt(152,19)},{AddCD(DGDeath,1),SetScore(Force1,Add,100000,Kills),RotatePlayer({DisplayTextX("\n\n\n\n\n\x13\x08！ ！ ！ \x04적의 생산기지 \x18Daggoth\x04를 파괴하였다!\x17 + 100000 P t s\x08 ！ ！ ！\n\n",4),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav")},HumanPlayers,FP)})

	CIf(FP,{ElapsedTimeX(AtMost,60*120),CD(DGDeath,1,AtMost)},{AddCD(WaveT2,1)})
	TriggerX(FP,{Bring(FP, AtLeast, 1, 48, 32)},{MoveUnit(1, 48, FP, 32, 2),MoveUnit(1, 48, FP, 32, 12),MoveUnit(1, 48, FP, 32, 13),Order(48,FP,38,Attack,4)},{preserved})
	TriggerX(FP,{Bring(FP, AtLeast, 1, 53, 32)},{MoveUnit(1, 53, FP, 32, 2),MoveUnit(1, 53, FP, 32, 12),MoveUnit(1, 53, FP, 32, 13),Order(53,FP,38,Attack,4)},{preserved})
	TriggerX(FP,{Bring(FP, AtLeast, 1, 54, 32)},{MoveUnit(1, 54, FP, 32, 2),MoveUnit(1, 54, FP, 32, 12),MoveUnit(1, 54, FP, 32, 13),Order(54,FP,38,Attack,4)},{preserved})
		CIf(FP,CD(WaveT2,250,AtLeast),SetCD(WaveT2,0))
		if X2_Mode == 1 then
			DG1XY2 = {3360*2,272*2}
			DG1XY3 = {352*2,1856*2}
		else
			DG1XY2 = {3360,272}
			DG1XY3 = {352,1856}
		end
		f_TempRepeat({CD(DGDeath,0)},37,7,nil,FP,DG1XY2)
		f_TempRepeat({CD(DGDeath,0)},38,7,nil,FP,DG1XY2)
		f_TempRepeat({CD(DGDeath,0)},40,15,nil,FP,DG1XY2)
		f_TempRepeat({CD(DGDeath,1)},54,10,nil,FP,DG1XY3)
		f_TempRepeat({CD(DGDeath,1)},53,10,nil,FP,DG1XY3)
		f_TempRepeat({CD(DGDeath,1)},48,10,nil,FP,DG1XY3)
		CIfEnd()
	CIfEnd()
	CIfEnd()
	TTArr= {28,29,30,31,40,33,34,35}
	TTCUTable = {
		{
			{53,10},{54,15}
		},
		{
			{56,25},{51,15},{104,15}
		},
		{
			{56,25},{51,15},{104,15}
		},
		{
			{56,25},{51,15},{104,15}
		},
		{
			{79,9},{88,9}
		},
		{
			{28,11},{19,25}
		},
		{
			{79,9},{88,9}
		},
		{
			{53,10},{54,15}
		},
	}
	CIf(FP,{CD(GMode,2,AtLeast)})
	for j, k in pairs(TTCUTable) do
		CIfOnce(FP,Bring(Force1,AtLeast,1,"Men",TTArr[j]))
		DoActions2(FP,{RotatePlayer({DisplayTextX("\x13\x04누군가가 \x08적의 \x07영역\x04을 침범하였습니다."),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav")},HumanPlayers,FP)})
		GetLocCenter(TTArr[j]-1,G_CA_X,G_CA_Y)
		for l, m in pairs(k) do
			f_TempRepeat(nil,m[1],m[2],nil,nil,"CG",1)
		end
		CIfEnd()
	end
	CIfEnd()
end