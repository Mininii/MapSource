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
			DisplayTextX("\x13\x04"..string.rep("��", 56),4);
			DisplayTextX("\n\n"..string.rep("   ", i).."\x1F== \x04����Ű��� \x08�գ�̣���� \x1C�ţ������ \x1F==\n\n\n\n\n",4);
			DisplayTextX("\x13\x04"..string.rep("��", 56),4);
			DisplayTextX("\n\n",4);
			},HumanPlayers,FP);
		})
	end
	
	TriggerX(FP,{CDeaths(FP,AtLeast,100,IntroT)},{
		RotatePlayer({
		DisplayTextX("\x13\x04"..string.rep("��", 56),4);
		DisplayTextX("\n\n"..string.rep("   ", 20).."\x1F== \x04����Ű��� \x08�գ�̣���� \x1C�ţ������ \x1F==\n"..string.rep("   ", 20).."\x02"..VerText.."\n"..string.rep("   ", 20).."\x1FCtrig \x04Assembler \x07v5.3\x04 \x04in Used \x19(��>��<)��\n\n\n",4);
		DisplayTextX("\x13\x04"..string.rep("��", 56),4);
		DisplayTextX(string.rep("   ", 20).."\x03Made \x06by \x04GALAXY_BURST\n\n",4);
		},HumanPlayers,FP);
	})
	
	TriggerX(FP,{CDeaths(FP,AtLeast,150+(48*1),IntroT)},{
		RotatePlayer({
		DisplayTextX("\x13\x04"..string.rep("��", 56),4);
		DisplayTextX("\n\n"..string.rep("   ", 20).."\x1F== \x04����Ű��� \x08�գ�̣���� \x1C�ţ������ \x1F==\n"..string.rep("   ", 20).."\x02"..VerText.."\n"..string.rep("   ", 20).."\x1FCtrig \x04Assembler \x07v5.3\x04 \x04in Used \x19(��>��<)��\n"..string.rep("   ", 20).."\x043�� �� �����մϴ�.\n\n",4);
		DisplayTextX("\x13\x04"..string.rep("��", 56),4);
		DisplayTextX(string.rep("   ", 20).."\x03Made \x06by \x04GALAXY_BURST\n\n",4);
		},HumanPlayers,FP);
		SetCDeaths(FP,Add,1,countdownSound);
	})
	
	TriggerX(FP,{CDeaths(FP,AtLeast,150+(48*2),IntroT)},{
		RotatePlayer({
		DisplayTextX("\x13\x04"..string.rep("��", 56),4);
		DisplayTextX("\n\n"..string.rep("   ", 20).."\x1F== \x04����Ű��� \x08�գ�̣���� \x1C�ţ������ \x1F==\n"..string.rep("   ", 20).."\x02"..VerText.."\n"..string.rep("   ", 20).."\x1FCtrig \x04Assembler \x07v5.3\x04 \x04in Used \x19(��>��<)��\n"..string.rep("   ", 20).."\x042�� �� �����մϴ�.\n\n",4);
		DisplayTextX("\x13\x04"..string.rep("��", 56),4);
		DisplayTextX(string.rep("   ", 20).."\x03Made \x06by \x04GALAXY_BURST\n\n",4);
		},HumanPlayers,FP);
		SetCDeaths(FP,Add,1,countdownSound);
	})
	TriggerX(FP,{CDeaths(FP,AtLeast,150+(48*3),IntroT)},{
		RotatePlayer({
		DisplayTextX("\x13\x04"..string.rep("��", 56),4);
		DisplayTextX("\n\n"..string.rep("   ", 20).."\x1F== \x04����Ű��� \x08�գ�̣���� \x1C�ţ������ \x1F==\n"..string.rep("   ", 20).."\x02"..VerText.."\n"..string.rep("   ", 20).."\x1FCtrig \x04Assembler \x07v5.3\x04 \x04in Used \x19(��>��<)��\n"..string.rep("   ", 20).."\x041�� �� �����մϴ�.\n\n",4);
		DisplayTextX("\x13\x04"..string.rep("��", 56),4);
		DisplayTextX(string.rep("   ", 20).."\x03Made \x06by \x04GALAXY_BURST\n\n",4);
		},HumanPlayers,FP);
		SetCDeaths(FP,Add,1,countdownSound);
	})
	
	TriggerX(FP,{CDeaths(FP,AtLeast,150+(48*4),IntroT)},{
		RotatePlayer({
		DisplayTextX("\x13\x04"..string.rep("��", 56),4);
		DisplayTextX("\n\n\n\n\n\n\n",4);
		DisplayTextX("\x13\x04"..string.rep("��", 56),4);
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
	TriggerX(FP,{CDeaths(FP,AtLeast,150+(48*4),IntroT),CVar(FP,Diff[2],Exactly,i)},{SetResources(Force1,Add,50000*i,ore),SetMemoryW(0x656EB0, Add, 500*i)})
	end
	TriggerX(FP,{CDeaths(FP,AtMost,(150+(48*4))-1,IntroT),CDeaths(FP,Exactly,0,isSingle)},{CV1},{Preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,150+(48*4),IntroT),CDeaths(FP,Exactly,0,isSingle)},{CV2})
	local InsertKey = "\x13\x04����������������������������������������������������������������������������������������������������������������\n\x13\x04�� ���� Ŭ������ ������ ������ \n\x13\x08���� ���� \x04�� \x1F�޼��� �ܰ�\x04�� \x07���ھ�(����)\x04�� ������ ������ ��Ÿ���ϴ�.\n\x13\x04����� �Ѱ踦 ������ ������!\n\x13\x07�̷������� ���� ���� �ܰ�� ���׷��̵�\x04�� �����մϴ�.\n\x13\x04255 ���׷��̵� �Ϸ� �� \x1F0���� ���� �� ���� ���ݷ��� �״�� ���µ˴ϴ�.\n\x13\x04��, ���� ���� \x17�α����� ����\x04�˴ϴ�.(�ο����� ���� �޶���)\n\x13\x04Normal Marine + \x1F25000 Ore \x04= \x1FExCeed Marine\n\x13\x04���ռҴ� �߾� ���� ������ �ִ°����� ���ø� �˴ϴ�.\n\x13\x04����������������������������������������������������������������������������������������������������������������\n\x13\x17�ạ̃ϣӣš������ģţ̣ţԣš��ˣţ�"

	local Formation = "\n\n\n\n\n\n\x13\x04������������������������������������������������������������������������������������������������������������\n\x14\n\x14\n\x13\x07C\x04ustom \x07P\x04lib \x1FLock \x17Protector \x07v1.0 \x04in Used. \x19(��>��<)�� \n\x13\x1FThanks \x04to \x1BNinfia\n\x13\x04�� ������ �� ��� \x07�������� ���� ���Ĺ���\x04�Դϴ�. \n\x13\x04���� �������� �� ���� �̽��� �������ּ���.\n\x14\n\n\x13\x04������������������������������������������������������������������������������������������������������������"
	TriggerX(FP,{CDeaths(FP,AtLeast,30*48,IntroT)},{RotatePlayer({DisplayTextX(Formation,4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,FP)})
	TriggerX(FP,{CDeaths(FP,AtLeast,30*48,IntroT),CDeaths(FP,AtMost,30*52,IntroT)},{CopyCpAction({MinimapPing(10)},HumanPlayers,FP)},{Preserved})
	CIfEnd()
	Trigger2(Force1,{Memory(0x596A44, Exactly, 0x00000100)},{DisplayText(InsertKey,4)},{Preserved})
	Trigger2(Force1,{Memory(0x596A44, Exactly, 65536)},{DisplayText(string.rep("\n", 20),4)},{Preserved})
end