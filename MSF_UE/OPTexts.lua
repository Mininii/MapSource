function OPText()
	CIf(AllPlayers,{CDeaths(FP,AtMost,(30*48)+3,IntroT)})
	if TestStart == 1 then
		--DoActionsX(FP,{SetCDeaths(FP,Add,150+(48*4)-2,IntroT)},1)
	end
	for i = 0, 19 do
		local OPOprand = 0
		if i == 0 then
			OPOprand = 1
		end
		TriggerX(FP,{CDeaths(FP,AtLeast,(i*5) + OPOprand,IntroT)},{
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
		DisplayTextX("\n\n"..string.rep("   ", 20).."\x1F== \x04마린키우기 \x08ＵｎＬｉｍｉＴ \x1CＥｘｃｅｅＤ \x1F==\n"..string.rep("   ", 20).."\x02"..VerText.."\n"..string.rep("   ", 20).."\x1FSTRCtrig \x04Assembler \x07v5.4\x04 \x04in Used \x19(つ>ㅅ<)つ\n\n\n",4);
		DisplayTextX("\x13\x04"..string.rep("―", 56),4);
		DisplayTextX(string.rep("   ", 20).."\x03Made \x06by \x04GALAXY_BURST\n\n",4);
		},HumanPlayers,FP);
	})
	
	TriggerX(FP,{CDeaths(FP,AtLeast,150+(48*1),IntroT)},{
		RotatePlayer({
		DisplayTextX("\x13\x04"..string.rep("―", 56),4);
		DisplayTextX("\n\n"..string.rep("   ", 20).."\x1F== \x04마린키우기 \x08ＵｎＬｉｍｉＴ \x1CＥｘｃｅｅＤ \x1F==\n"..string.rep("   ", 20).."\x02"..VerText.."\n"..string.rep("   ", 20).."\x1FSTRCtrig \x04Assembler \x07v5.4\x04 \x04in Used \x19(つ>ㅅ<)つ\n"..string.rep("   ", 20).."\x043초 후 시작합니다.\n\n",4);
		DisplayTextX("\x13\x04"..string.rep("―", 56),4);
		DisplayTextX(string.rep("   ", 20).."\x03Made \x06by \x04GALAXY_BURST\n\n",4);
		},HumanPlayers,FP);
		SetCDeaths(FP,Add,1,countdownSound);
	})
	
	TriggerX(FP,{CDeaths(FP,AtLeast,150+(48*2),IntroT)},{
		RotatePlayer({
		DisplayTextX("\x13\x04"..string.rep("―", 56),4);
		DisplayTextX("\n\n"..string.rep("   ", 20).."\x1F== \x04마린키우기 \x08ＵｎＬｉｍｉＴ \x1CＥｘｃｅｅＤ \x1F==\n"..string.rep("   ", 20).."\x02"..VerText.."\n"..string.rep("   ", 20).."\x1FSTRCtrig \x04Assembler \x07v5.4\x04 \x04in Used \x19(つ>ㅅ<)つ\n"..string.rep("   ", 20).."\x042초 후 시작합니다.\n\n",4);
		DisplayTextX("\x13\x04"..string.rep("―", 56),4);
		DisplayTextX(string.rep("   ", 20).."\x03Made \x06by \x04GALAXY_BURST\n\n",4);
		},HumanPlayers,FP);
		SetCDeaths(FP,Add,1,countdownSound);
	})
	TriggerX(FP,{CDeaths(FP,AtLeast,150+(48*3),IntroT)},{
		RotatePlayer({
		DisplayTextX("\x13\x04"..string.rep("―", 56),4);
		DisplayTextX("\n\n"..string.rep("   ", 20).."\x1F== \x04마린키우기 \x08ＵｎＬｉｍｉＴ \x1CＥｘｃｅｅＤ \x1F==\n"..string.rep("   ", 20).."\x02"..VerText.."\n"..string.rep("   ", 20).."\x1FSTRCtrig \x04Assembler \x07v5.4\x04 \x04in Used \x19(つ>ㅅ<)つ\n"..string.rep("   ", 20).."\x041초 후 시작합니다.\n\n",4);
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
	TriggerX(i,{CDeaths(FP,AtLeast,150+(48*4),IntroT)},{CreateUnitWithProperties(4,10,2+i,i,{energy = 100}),SetResources(i,Add,30000,Ore)})
	for j = 1, 3 do
	TriggerX(i,{CDeaths(FP,AtLeast,150+(48*4),IntroT),CVar(FP,Diff[2],Exactly,j)},{CreateUnitWithProperties(4*j,10,2+i,i,{energy = 100})})
	end
	end
	for i = 1, 3 do
	TriggerX(FP,{CDeaths(FP,AtLeast,150+(48*4),IntroT),CVar(FP,Diff[2],Exactly,i)},{SetResources(Force1,Add,50000*i,Ore),SetMemoryW(0x656EB0, Add, 500*i)})
	end
	TriggerX(FP,{CDeaths(FP,AtMost,(150+(48*4))-1,IntroT),CDeaths(FP,Exactly,0,isSingle)},{CV1},{preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,150+(48*4),IntroT),CDeaths(FP,Exactly,0,isSingle)},{CV2})

	--local Formation = "\n\n\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x14\n\x14\n\x13\x07C\x04ustom \x07P\x04lib \x1FLock \x17Protector \x07v1.0 \x04in Used. \x19(つ>ㅅ<)つ \n\x13\x1FThanks \x04to \x1BNinfia\n\x13\x04이 문구가 뜰 경우 \x07정식버전\x04입니다. \n\x13\x04무단 수정맵을 주의해주세요.\n\x14\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
	local Formation = "\t\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\n\x13\x04처음하시는 분들은 Insert키 숙지 필수입니다. 꼭 확인하세요\n\n\x13\x04처음하시는 분들은 Insert키 숙지 필수입니다. 꼭 확인하세요\n\n\x13\x04처음하시는 분들은 Insert키 숙지 필수입니다. 꼭 확인하세요\n\n\x13\x04처음하시는 분들은 Insert키 숙지 필수입니다. 꼭 확인하세요\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
	TriggerX(FP,{CDeaths(FP,AtLeast,30*48,IntroT)},{RotatePlayer({DisplayTextX(Formation,4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,FP)})
	--TriggerX(FP,{CDeaths(FP,AtLeast,30*48,IntroT),CDeaths(FP,AtMost,30*52,IntroT)},{CopyCpAction({MinimapPing(10)},HumanPlayers,FP)},{preserved})
	CIfEnd()
end