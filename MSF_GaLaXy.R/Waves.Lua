function Waves()
	CIf(FP,Switch("Switch 201",Set))
	--ElapsedTimeX(Comparison, Time)
	WaveXYArr = {{3552,160},{3872,160},{3552,416},{3872,416}}
	
	function CallSet(Time,CUTable,TimerFlag)
		if TimerFlag==1 then
			for i = 1,5 do
				TriggerX(FP,{CD(GMode,1),ElapsedTimeX(Exactly,Time-(i*2))},{RotatePlayer({DisplayTextX("\x13\x04"..i.."초 남았습니다.",4)},HumanPlayers,FP),SetCD(ButtonSound,1)})
			end
		end
		Trigger2X(FP,{ElapsedTimeX(Exactly,Time)},{
			SetMemoryX(0x666458, SetTo, 391,0xFFFF),
			Simple_SetLoc(0,WaveXYArr[1][1],WaveXYArr[1][2],WaveXYArr[1][1],WaveXYArr[1][2]),CreateUnit(1,33,0,FP),CreateUnit(1,84,0,FP),
			Simple_SetLoc(0,WaveXYArr[2][1],WaveXYArr[2][2],WaveXYArr[2][1],WaveXYArr[2][2]),CreateUnit(1,33,0,FP),CreateUnit(1,84,0,FP),
			Simple_SetLoc(0,WaveXYArr[3][1],WaveXYArr[3][2],WaveXYArr[3][1],WaveXYArr[3][2]),CreateUnit(1,33,0,FP),CreateUnit(1,84,0,FP),
			Simple_SetLoc(0,WaveXYArr[4][1],WaveXYArr[4][2],WaveXYArr[4][1],WaveXYArr[4][2]),CreateUnit(1,33,0,FP),CreateUnit(1,84,0,FP),RemoveUnit(33,FP),KillUnit(84,FP),
			SetMemoryX(0x666458, SetTo, 546,0xFFFF),SetCD(NoticeCD,1)
		})
		for j, k in pairs(CUTable) do
			for i = 1, 4 do
			f_TempRepeat(ElapsedTimeX(Exactly,Time),k[1],k[2],nil,nil,WaveXYArr[i],1)
			end
		end
	end

	CallSet(90,{{48,5},{55,9},{54,5},{53,5}},1)
	CallSet(255,{{48,7},{56,9},{51,5},{104,5}},1)
	CallSet(455,{{48,9},{56,25},{51,10},{104,15}},1)
	CIf(FP,{CD(GMode,2)})
		CallSet(265,{{77,3}})
		CallSet(620,{{25,6}})
		CallSet(900,{{78,5}})
		CallSet(1159,{{29,6}})
	CIfEnd()
	CIf(FP,{CD(GMode,2)})
		CallSet(290,{{77,10}})
		CallSet(600,{{78,15}})
		CallSet(802,{{25,15},{30,5}})
		CallSet(1000,{{13,25},{88,15}})
	CIfEnd()
	for i = 1, 10 do
		CallSet(1250*i,{
			{29,4},{88,5},{21,5},{17,3},{77,3},{78,3},
		},1)
		
	end
	
	local WaveT = CreateCcode()
	local WaveT2 = CreateCcode()
	local DGDeath = CreateCcode()
	local WarpDeath = CreateCcode()
	Trigger2X(FP,{CommandLeastAt(189,20)},{AddCD(WarpDeath,1),SetScore(Force1,Add,500000,Kills),AddV(ExRateV,20),RotatePlayer({DisplayTextX("\n\n\n\n\n\x13\x08！ ！ ！ \x04적의 생산기지 \x18Warp Gate\x04를 파괴하였다!\x17 + 500000 P t s, \x1F+ 2.0% Exchange Rate\x08 ！ ！ ！\n\n",4),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav")},HumanPlayers,FP)})
	
	CIf(FP,{ElapsedTimeX(AtMost,60*60),CD(WarpDeath,0)},{AddCD(WaveT,1)})
		f_TempRepeat({CD(WaveT,3000,AtLeast),ElapsedTimeX(AtMost,600)},54,15,nil,FP,{432,688})
		f_TempRepeat({CD(WaveT,3000,AtLeast),ElapsedTimeX(AtMost,600)},53,15,nil,FP,{432,688})
		f_TempRepeat({CD(WaveT,3000,AtLeast),ElapsedTimeX(AtMost,600)},55,25,nil,FP,{432,688})
		f_TempRepeat({CD(WaveT,3000,AtLeast),ElapsedTimeX(AtLeast,600)},48,10,nil,FP,{432,688})
		f_TempRepeat({CD(WaveT,3000,AtLeast),ElapsedTimeX(AtLeast,600)},104,10,nil,FP,{432,688})
		f_TempRepeat({CD(WaveT,3000,AtLeast),ElapsedTimeX(AtLeast,600)},51,15,nil,FP,{432,688})
		f_TempRepeat({CD(WaveT,3000,AtLeast),ElapsedTimeX(AtLeast,600)},56,25,nil,FP,{432,688})

		TriggerX(FP,{CD(WaveT,3000,AtLeast)},{SetCD(WaveT,0)},{Preserved})
	CIfEnd()
	
	Trigger2X(FP,{CommandLeastAt(152,18)},{AddCD(DGDeath,1),SetScore(Force1,Add,100000,Kills),SetInvincibility(Disable,152,FP,19),RotatePlayer({DisplayTextX("\n\n\n\n\n\x13\x08！ ！ ！ \x04적의 생산기지 \x18Daggoth\x04를 파괴하였다!\x17 + 100000 P t s\x08 ！ ！ ！\n\n",4),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav")},HumanPlayers,FP)})
	Trigger2X(FP,{CommandLeastAt(152,19)},{AddCD(DGDeath,1),SetScore(Force1,Add,100000,Kills),RotatePlayer({DisplayTextX("\n\n\n\n\n\x13\x08！ ！ ！ \x04적의 생산기지 \x18Daggoth\x04를 파괴하였다!\x17 + 100000 P t s\x08 ！ ！ ！\n\n",4),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav")},HumanPlayers,FP)})

	CIf(FP,{ElapsedTimeX(AtMost,60*60),CD(DGDeath,1,AtMost)},{AddCD(WaveT2,1)})
		f_TempRepeat({CD(DGDeath,0),CD(WaveT2,500,AtLeast)},37,7,nil,FP,{3360,272})
		f_TempRepeat({CD(DGDeath,0),CD(WaveT2,500,AtLeast)},38,7,nil,FP,{3360,272})
		f_TempRepeat({CD(DGDeath,0),CD(WaveT2,500,AtLeast)},40,15,nil,FP,{3360,272})
		f_TempRepeat({CD(DGDeath,1),CD(WaveT2,500,AtLeast)},54,10,nil,FP,{352,1856})
		f_TempRepeat({CD(DGDeath,1),CD(WaveT2,500,AtLeast)},53,10,nil,FP,{352,1856})
		f_TempRepeat({CD(DGDeath,1),CD(WaveT2,500,AtLeast)},48,10,nil,FP,{352,1856})
	TriggerX(FP,{CD(WaveT2,500,AtLeast)},{SetCD(WaveT2,0)},{Preserved})
	CIfEnd()
	CIfEnd()
end