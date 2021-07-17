function Install_Destr0yer()
	local BGMArr = {}
	for i = 1, 272 do
		if i <= 9 then
			table.insert(BGMArr,"staredit\\wav\\LV10_00"..i..".ogg")
		elseif i >= 10 and i<= 99 then
			table.insert(BGMArr,"staredit\\wav\\LV10_0"..i..".ogg")
		else
			table.insert(BGMArr,"staredit\\wav\\LV10_"..i..".ogg")
		end
	end
	local BGMLength = 439
	local BGMVar = 440
	local Length = 666
	CIf(FP,Bring(FP,AtLeast,1,186,64))
	SetRecoverCp()
	RecoverCp(AllPlayers)
for i = 0, #BGMArr-1 do
	Trigger { -- 상시브금
		players = {Force1},
		conditions = {
			DeathsX(CurrentPlayer,Exactly,i,BGMLength,0xFFFFFF);
			DeathsX(CurrentPlayer,AtMost,0,BGMVar,0xFFFFFF);
		},
		actions = {
			PlayWAV(BGMArr[i+1]); 
			PlayWAV(BGMArr[i+1]); 
			SetDeathsX(CurrentPlayer,Add,Length,BGMVar,0xFFFFFF);
			SetDeathsX(CurrentPlayer,Add,1,BGMLength,0xFFFFFF);
			PreserveTrigger();
			
			},
		}
	Trigger { -- 상시브금
		players = {FP},
		conditions = {
			DeathsX(CurrentPlayer,Exactly,i,BGMLength,0xFFFFFF);
			DeathsX(CurrentPlayer,AtMost,0,BGMVar,0xFFFFFF);
		},
		actions = {
			RotatePlayer({PlayWAVX(BGMArr[i+1]);PlayWAVX(BGMArr[i+1]);},ObPlayers,FP);
			SetDeathsX(CurrentPlayer,Add,Length,BGMVar,0xFFFFFF);
			SetDeathsX(CurrentPlayer,Add,1,BGMLength,0xFFFFFF);
			PreserveTrigger();
			
			},
		}
	end
	CIfEnd()
--	local TestCC = CreateCCode()
--	CIf(FP,CDeaths(FP,AtMost,0,TestCC),SetCDeaths(FP,Add,7,TestCC))
--	GetLocCenter(63,CPosX,CPosY)
--	for i = 0, 7 do
--	CreateBullet(208,20,i*32,CPosX,CPosY)
--	end
--	CIfEnd()
--	DoActionsX(FP,SetCDeaths(FP,Subtract,1,TestCC))
	--SetMemoryX(0x663788, SetTo, ,0xFF);
	--staredit\wav\LV10_001.ogg -- 272
end