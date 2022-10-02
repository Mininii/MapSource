
function Waves()
	local WaveT = CreateCcodeArr(7)
	local WaveS = CreateCcodeArr(7)
function ElapsedTimeX(Comparison, Time)
	return Memory(0x58D6F8 ,Comparison, Time)
end
function SetWave(Condition,WaveC,XYTable,NUTable)
	
	CIf(FP,Condition,{AddCD(WaveC,1)})
		CIf(FP,CD(WaveC,250,AtLeast),SetCD(WaveC,0))
		for j, k in pairs(NUTable) do
			f_TempRepeat({},k[1],k[2],nil,FP,XYTable)
		end
		CIfEnd()
	CIfEnd()
end

function GunWave(GunID,LocID,NUTable,BGMTypes)
	local GunCcode = CreateCcode()
	TriggerX(FP, CommandLeastAt(GunID,LocID), {SetCD(GunCcode,1)})
	CIf(FP,{CD(GunCcode,1,AtLeast),CD(GunCcode,960,AtMost)},{AddCD(GunCcode,1)})
		GetLocCenter(LocID-1, CPosX, CPosY)
		DoActionsX(FP, {SetV(BGMType,BGMTypes)}, 1)
		local NUCArr = {}
		for j, k in pairs(NUTable) do
			local NUCcode = CreateCcode()
			table.insert(NUCArr,SetCD(NUCcode,0))
			f_TempRepeatX({CD(NUCcode,k[2]-1,AtMost)},k[1],1,nil,FP,{CPosX,CPosY})
			DoActionsX(FP,{AddCD(NUCcode)})
		end
		TriggerX(FP,{CD(GunCcode,480,AtLeast)},NUCArr)
	CIfEnd({SetCp(FP)})
	
end
	DoActions(FP,SetCp(FP))

	
	GunWave(131,18,{{38,20},{39,15},{43,25},{40,15}},2)
	GunWave(131,19,{{38,20},{39,15},{43,25},{40,15}},2)
	
	GunWave(132,20,{{38,10},{39,15},{39,10},{43,16},{44,9}},3)
	GunWave(132,21,{{38,10},{39,15},{39,10},{43,16},{44,9}},3)

	GunWave(133,22,{{38,25},{39,15},{44,25}},4)
	GunWave(133,23,{{38,25},{39,15},{44,25}},4)

	GunWave(131,24,{{54,20},{53,15}},4)
	GunWave(131,25,{{54,20},{53,15}},4)

	GunWave(132,26,{{53,10},{54,15},{48,10},{54,16},{55,9}},3)
	GunWave(132,27,{{53,10},{54,15},{48,10},{54,16},{55,9}},3)
	for i = 28, 33 do
		GunWave(133,i,{{53,25},{48,15},{55,25}},4)
	end
	GunWave(148,34,{{53,20},{54,30},{48,15},{55,25}},3)
	GunWave(148,35,{{53,20},{54,30},{48,15},{55,25}},3)

	for i = 36, 40 do
		GunWave(150,i,{{51,3},{104,5},{56,25},{53,15},{54,20}},4)
	end
	--TriggerX(FP, {}, {}, {preserved})
	Trigger2(FP, {Deaths(FP, AtLeast, 1, 131)}, {SetDeaths(FP, Subtract, 1, 131),SetScore(Force1, Add, 10000, Kills),RotatePlayer({DisplayTextX(StrDesignX("\x07부화장 파괴! \x1F+ 10,000 Pts"),4)}, HumanPlayers, FP)}, {preserved})
	Trigger2(FP, {Deaths(FP, AtLeast, 1, 132)}, {SetDeaths(FP, Subtract, 1, 132),SetScore(Force1, Add, 20000, Kills),RotatePlayer({DisplayTextX(StrDesignX("\x07번식지 파괴! \x1F+ 20,000 Pts"),4)}, HumanPlayers, FP)}, {preserved})
	Trigger2(FP, {Deaths(FP, AtLeast, 1, 133)}, {SetDeaths(FP, Subtract, 1, 133),SetScore(Force1, Add, 30000, Kills),RotatePlayer({DisplayTextX(StrDesignX("\x07군락 파괴! \x1F+ 30,000 Pts"),4)}, HumanPlayers, FP)}, {preserved})
	Trigger2(FP, {Deaths(FP, AtLeast, 1, 148)}, {SetDeaths(FP, Subtract, 1, 148),SetScore(Force1, Add, 60000, Kills),RotatePlayer({DisplayTextX(StrDesignX("\x07초월체 파괴! \x1F+ 60,000 Pts"),4)}, HumanPlayers, FP)}, {preserved})
	Trigger2(FP, {Deaths(FP, AtLeast, 1, 150)}, {SetDeaths(FP, Subtract, 1, 150),SetScore(Force1, Add, 40000, Kills),RotatePlayer({DisplayTextX(StrDesignX("\x07다 자란 번데기 파괴! \x1F+ 40,000 Pts"),4)}, HumanPlayers, FP)}, {preserved})


	Trigger2X(FP,{Bring(FP, AtMost, 0, 130, 5)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04감염된 사령부 파괴! + 100,000 Pts"),4),DisplayTextX(StrDesignX("\x04이제부터 더 강력한 몬스터가 출현합니다."),4)}, HumanPlayers, FP),SetScore(Force1, Add, 100000, Kills),SetCD(WaveS[1],1),SetInvincibility(Disable, 151, FP, 8),SetInvincibility(Disable, 151, FP, 9)})
	Trigger2X(FP,{Bring(FP, AtMost, 0, 151, 8)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04정신체 파괴! + 50,000 Pts"),4),DisplayTextX(StrDesignX("\x04이제부터 더 강력한 몬스터가 출현합니다."),4)}, HumanPlayers, FP),SetScore(Force1, Add, 50000, Kills),SetCD(WaveS[2],1),SetInvincibility(Disable, 201, FP, 10)})
	Trigger2X(FP,{Bring(FP, AtMost, 0, 151, 9)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04정신체 파괴! + 50,000 Pts"),4),DisplayTextX(StrDesignX("\x04이제부터 더 강력한 몬스터가 출현합니다."),4)}, HumanPlayers, FP),SetScore(Force1, Add, 50000, Kills),SetCD(WaveS[3],1),SetInvincibility(Disable, 201, FP, 11)})
	Trigger2X(FP,{Bring(FP, AtMost, 0, 201, 10)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04초월체 고치 파괴! + 80,000 Pts"),4),DisplayTextX(StrDesignX("\x04이제부터 더 강력한 몬스터가 출현합니다."),4)}, HumanPlayers, FP),SetScore(Force1, Add, 80000, Kills),SetCD(WaveS[4],1),SetInvincibility(Disable, 152, FP, 12)})
	Trigger2X(FP,{Bring(FP, AtMost, 0, 201, 11)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04초월체 고치 파괴! + 80,000 Pts"),4),DisplayTextX(StrDesignX("\x04이제부터 더 강력한 몬스터가 출현합니다."),4)}, HumanPlayers, FP),SetScore(Force1, Add, 80000, Kills),SetCD(WaveS[5],1),SetInvincibility(Disable, 152, FP, 13)})
	Trigger2X(FP,{Bring(FP, AtMost, 0, 152, 12)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04정신체 다고스 파괴! + 100,000 Pts"),4),DisplayTextX(StrDesignX("\x04감염된 듀란과 케리건을 처치하십시오!"),4)}, HumanPlayers, FP),SetScore(Force1, Add, 100000, Kills),SetCD(WaveS[6],1)})
	Trigger2X(FP,{Bring(FP, AtMost, 0, 152, 13)},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),PlayWAVX("sound\\Bullet\\TNsFir00.wav"),DisplayTextX(StrDesignX("\x04정신체 다고스 파괴! + 100,000 Pts"),4),DisplayTextX(StrDesignX("\x04감염된 듀란과 케리건을 처치하십시오!"),4)}, HumanPlayers, FP),SetScore(Force1, Add, 100000, Kills),SetCD(WaveS[7],1)})
	Trigger2X(FP,{},{SetInvincibility(Enable, 147, FP, 64)},{preserved})
	Trigger2X(FP,{CD(WaveS[6],1),CD(WaveS[7],1),Bring(FP,AtMost,0,51,64),Bring(FP,AtMost,0,104,64),Bring(FP,AtMost,1,"Buildings",64)},{SetInvincibility(Disable, 147, FP, 64)},{preserved})
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
	Trigger2X(FP,{Bring(FP, AtMost, 0, 147, 64)},{RotatePlayer({DisplayTextX(StrDesignX("\x04그렇게 우리는 모든 괴물들을 처치하고 집으로 돌아갔다."), 4),DisplayTextX(StrDesignX("\x04Victory!!!"), 4),Victory()}, MapPlayers,FP)})
	
end