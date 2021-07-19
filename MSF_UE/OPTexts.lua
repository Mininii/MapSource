function OPText()
	if TestStart == 1 then
		DoActionsX(FP,{SetCDeaths(FP,Add,150+(48*4),IntroT)},1)
	end
	for i = 0, 19 do
		TriggerX(FP,{CDeaths(FP,AtLeast,i*5,IntroT)},{
			RotatePlayer({
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX("\n\n"..string.rep("   ", i).."\x1F== \x04마린키우기 \x08ＵｎＬｉｍｉＴ \x1CＥｘｃｅｅＤ \x1F==\n\n\n\n\n",4);
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX("\n\n",4);
			},HumanPlayers,FP);
		})
	end
	
	TriggerX(FP,{CDeaths(FP,AtLeast,100,IntroT)},{
		RotatePlayer({
		DisplayTextX("\x13\x04"..string.rep("―", 56),4);
		DisplayTextX("\n\n"..string.rep("   ", 20).."\x1F== \x04마린키우기 \x08ＵｎＬｉｍｉＴ \x1CＥｘｃｅｅＤ \x1F==\n"..string.rep("   ", 20).."\x02"..VerText.."\n"..string.rep("   ", 20).."\x1FCtrig \x04Assembler \x07v5.3T\x04 \x04in Used \x19(つ>ㅅ<)つ\n\n\n",4);
		DisplayTextX("\x13\x04"..string.rep("―", 56),4);
		DisplayTextX(string.rep("   ", 20).."\x03Made \x06by \x04GALAXY_BURST\n\n",4);
		},HumanPlayers,FP);
	})
	
	TriggerX(FP,{CDeaths(FP,AtLeast,150+(48*1),IntroT)},{
		RotatePlayer({
		DisplayTextX("\x13\x04"..string.rep("―", 56),4);
		DisplayTextX("\n\n"..string.rep("   ", 20).."\x1F== \x04마린키우기 \x08ＵｎＬｉｍｉＴ \x1CＥｘｃｅｅＤ \x1F==\n"..string.rep("   ", 20).."\x02"..VerText.."\n"..string.rep("   ", 20).."\x1FCtrig \x04Assembler \x07v5.3T\x04 \x04in Used \x19(つ>ㅅ<)つ\n"..string.rep("   ", 20).."\x043초 후 시작합니다.\n\n",4);
		DisplayTextX("\x13\x04"..string.rep("―", 56),4);
		DisplayTextX(string.rep("   ", 20).."\x03Made \x06by \x04GALAXY_BURST\n\n",4);
		},HumanPlayers,FP);
		SetCDeaths(FP,Add,1,countdownSound);
	})
	
	TriggerX(FP,{CDeaths(FP,AtLeast,150+(48*2),IntroT)},{
		RotatePlayer({
		DisplayTextX("\x13\x04"..string.rep("―", 56),4);
		DisplayTextX("\n\n"..string.rep("   ", 20).."\x1F== \x04마린키우기 \x08ＵｎＬｉｍｉＴ \x1CＥｘｃｅｅＤ \x1F==\n"..string.rep("   ", 20).."\x02"..VerText.."\n"..string.rep("   ", 20).."\x1FCtrig \x04Assembler \x07v5.3T\x04 \x04in Used \x19(つ>ㅅ<)つ\n"..string.rep("   ", 20).."\x042초 후 시작합니다.\n\n",4);
		DisplayTextX("\x13\x04"..string.rep("―", 56),4);
		DisplayTextX(string.rep("   ", 20).."\x03Made \x06by \x04GALAXY_BURST\n\n",4);
		},HumanPlayers,FP);
		SetCDeaths(FP,Add,1,countdownSound);
	})
	TriggerX(FP,{CDeaths(FP,AtLeast,150+(48*3),IntroT)},{
		RotatePlayer({
		DisplayTextX("\x13\x04"..string.rep("―", 56),4);
		DisplayTextX("\n\n"..string.rep("   ", 20).."\x1F== \x04마린키우기 \x08ＵｎＬｉｍｉＴ \x1CＥｘｃｅｅＤ \x1F==\n"..string.rep("   ", 20).."\x02"..VerText.."\n"..string.rep("   ", 20).."\x1FCtrig \x04Assembler \x07v5.3T\x04 \x04in Used \x19(つ>ㅅ<)つ\n"..string.rep("   ", 20).."\x041초 후 시작합니다.\n\n",4);
		DisplayTextX("\x13\x04"..string.rep("―", 56),4);
		DisplayTextX(string.rep("   ", 20).."\x03Made \x06by \x04GALAXY_BURST\n\n",4);
		},HumanPlayers,FP);
		SetCDeaths(FP,Add,1,countdownSound);
	})
	
	TriggerX(FP,{CDeaths(FP,AtLeast,150+(48*4),IntroT)},{
		RotatePlayer({
		DisplayTextX("\x13\x04"..string.rep("―", 56),4);
		DisplayTextX("\n\n\n\n\n\n\n",4);
		DisplayTextX("\x13\x04"..string.rep("―", 56),4);
		DisplayTextX("\n\n",4);
		},HumanPlayers,FP);
	})
	TriggerX(FP,{CDeaths(FP,AtLeast,150+(48*4),IntroT)},{
		RotatePlayer({
		PlayWAVX("sound\\glue\\bnetclick.wav");
		PlayWAVX("sound\\glue\\bnetclick.wav");
		PlayWAVX("sound\\glue\\bnetclick.wav");
		PlayWAVX("sound\\glue\\bnetclick.wav");
		},HumanPlayers,FP);
	})
	local CV1, CV2 = {}, {}
	for i = 0, 6 do
	table.insert(CV1,SetMemory(0x6509B0,SetTo,i))
	table.insert(CV1,CenterView("Anywhere"))
	table.insert(CV2,SetMemory(0x6509B0,SetTo,i))
	table.insert(CV2,CenterView(2+i))
	TriggerX(i,{CDeaths(FP,AtLeast,150+(48*4),IntroT)},{CreateUnitWithProperties(4,10,2+i,i,{energy = 100}),SetResources(i,Add,15000,Ore)})
	end
	TriggerX(FP,{CDeaths(FP,AtMost,(150+(48*4))-1,IntroT)},{CV1},{Preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,150+(48*4),IntroT)},{CV2})
	local InsertKey = "\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04이 맵은 클리어의 개념이 없으며 \n\x13\x08게임 오버 \x04시 \x1F달성한 단계\x04와 \x07스코어(가스)\x04가 게임의 성과를 나타냅니다.\n\x13\x04당신의 한계를 시험해 보세요!\n\x13\x07이론적으로 제한 없는 단계와 업그레이드\x04를 제공합니다.\n\x13\x04255 업그레이드 완료 시 \x1F0으로 리셋 후 마린 공격력이 그대로 전승됩니다.\n\x13\x04단, 마린 수는 \x17인구수로 제한\x04됩니다.(인원수에 따라 달라짐)\n\x13\x04Normal Marine + \x1F25000 Ore \x04= \x1FExCeed Marine\n\x13\x04조합소는 중앙 수정 광산이 있는곳으로 가시면 됩니다.\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x17ＣＬＯＳＥ　：　ＤＥＬＥＴＥ　ＫＥＹ"
	Trigger2(Force1,{Memory(0x596A44, Exactly, 0x00000100)},{DisplayText(InsertKey,4)},{Preserved})
	Trigger2(Force1,{Memory(0x596A44, Exactly, 65536)},{DisplayText(string.rep("\n", 20),4)},{Preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,30*48,IntroT)},{RotatePlayer({DisplayTextX(InsertKey,4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,FP)})
end