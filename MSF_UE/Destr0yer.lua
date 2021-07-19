function Install_Destr0yer()
	
local Lyrics = {
	{"\x12\x04Ladies and Gentlemen",2,222},
	{"\x12\x07Let's start",5,0},
	{"\x12\x04Only is in Memories",8,0},
	{"\x12\x08Tonight.",12,333},
	{"\x13\x04I wonder why things have happened.\n\x13\x04왜 이런 일들이 일어났는지 궁금해.",60-3,0},
	{"\x13\x04Could you imagine the world is boring?\n\x13\x04이 세상은 따분한 걸, 넌 알고 있니?",68-3,0},
	{"\x13\x04Stereotype\n\x13\x04고정관념",76-3,0},
	{"\x13\x04Sham\n\x13\x04엉터리",78-3,444},
	{"\x13\x04Brain Freeze\n\x13\x04브레인 프리즈",79-3,444},
	{"\x13\x04Collusion\n\x13\x04공모",80-3,222},
	{"\x13\x04Mental block\n\x13\x04정신적 블록",82-3,333},
	{"\x13\x04The world is fading.\n\x13\x04세계는 사라져 가고,",83-3,222},
	{"\x13\x04I know the fate.\n\x13\x04그 운명은 난 알고 있어.",86-3,333},
	{"\x13\x04The world is fading.\n\x13\x04세계는 사라지고,",88-3,444},
	{"\x13\x04I know the fate.\n\x13\x04나는 그 운명을 아는걸.",90-3,444},
	{"\x13\x04I know all of you.\n\x13\x04나는 너희를 모두 아는데,",91-3,0},
	{"\x13\x04Have you, you, followed me?\n\x13\x04너희는, 너희는 날 쫓아오기라도 했니?",95-3,444},
	{"\x13\x04Me in your mind is the dream.\n\x13\x04너희 마음 속의 나는 꿈인걸.",99-3,0},
	{"\x13\x04The dream of the past.\n\x13\x04과거의 꿈.",105-3,333},
	{"\x13\x04So I would forget you.\n\x13\x04난 너희를 잊을테니,",107-3,0},
	{"\x13\x04Let you forget me.\n\x13\x04너희도 날 잊어줘.",111-3,0},
	{"\x13\x04'Cause I'm \"Destroyer\"\n\x13\x04나는 \"파괴자\"이니까.",115-3,333},
	{"\x13\x04I kill us all.\n\x13\x04다 끝장내겠어.",138-3,0},
	{"\x13\x04It's the only way.\n\x13\x04이 길 뿐이야.",151-3,333},
	{"\x13\x04It's over.\n\x13\x04다 끝났어.",153-3,0},
	{"\x13\x04I will kill.\n\x13\x04끝장내겠어.",159-3,333},
	{"\x13\x04I will destroy the world.\n\x13\x04내가 세상을 파괴하겠어.",161-3,333},
	{"\x13\x04No matter what you do, I don't stop.\n\x13\x04너희가 뭐래도, 멈추지 않아.",165-3,500},
	{"\x13\x04I'm the only one who's right.\n\x13\x04나만이 진리이기에.",168-3,0},
	{"\x13\x04I will kill.\n\x13\x04끝장내겠어.",175-3,333},
	{"\x13\x04I will destroy the world.\n\x13\x04내가 세상을 파괴하겠어.",177-3,444},
	{"\x13\x04No matter what you do, I don't stop.\n\x13\x04너희가 뭐래도, 멈추지 않아.",181-3,500},
	{"\x13\x04It is what it is.\n\x13\x04뭐 어쩌겠어.",184-3,0},
	{"\x13\x04It is what it is.\n\x13\x04원래 이랬는걸.",188-3,0},
	{"\x13\x04It is not. It's not my fault.\n\x13\x04아냐. 내 잘못이 아냐.",192-3,0},
	}
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
	RecoverCp(FP)
	local LyricsCCode = {}
	for j, k in pairs(Lyrics) do
		local TempCcode = CreateCCode()
		table.insert(LyricsCCode,TempCcode)
		Trigger { -- 상시브금
			players = {FP},
			conditions = {
				Label(0);
				CDeaths(FP,AtMost,0,TempCcode);
				DeathsX(CurrentPlayer,Exactly,k[2],BGMLength,0xFFFFFF);
				DeathsX(CurrentPlayer,AtMost,k[3],BGMVar,0xFFFFFF);
			},
			actions = {
				RotatePlayer({DisplayTextX(k[1],4)},HumanPlayers,FP);
				SetCDeaths(FP,Add,1,TempCcode);
				PreserveTrigger();
				},
			}
	end
	for i = 0, #BGMArr-1 do
		Trigger { -- 상시브금
			players = {FP},
			conditions = {
				DeathsX(CurrentPlayer,Exactly,i,BGMLength,0xFFFFFF);
				DeathsX(CurrentPlayer,AtMost,0,BGMVar,0xFFFFFF);
			},
			actions = {
				RotatePlayer({PlayWAVX(BGMArr[i+1]);PlayWAVX(BGMArr[i+1]);},HumanPlayers,FP);
				SetDeathsX(CurrentPlayer,Add,Length,BGMVar,0xFFFFFF);
				SetDeathsX(CurrentPlayer,Add,1,BGMLength,0xFFFFFF);
				PreserveTrigger();
				},
			}
	end
	CIfEnd()
	local CBulletT = CreateCCode()
--	CIf(FP,CDeaths(FP,AtMost,0,CBulletT),SetCDeaths(FP,Add,7,CBulletT))
--	GetLocCenter(63,CPosX,CPosY)
--	for i = 0, 7 do
--	CreateBullet(208,20,i*32,CPosX,CPosY)
--	end
--	CIfEnd()
	DoActionsX(FP,SetCDeaths(FP,Subtract,1,CBulletT))
	--SetMemoryX(0x663788, SetTo, ,0xFF);
	--staredit\wav\LV10_001.ogg -- 272

end