function PlayerInterface()
	local MarCreate = Create_CCTable(7)
	local MarCreate2 = Create_CCTable(7)
	local UpSELemit = Create_CCTable(7)
	local AtkFactorV = Create_VTable(7,AtkFactor,FP)
	local DefFactorV = Create_VTable(7,DefFactor,FP)
	local AtkFactorV2 = Create_VTable(7,nil,FP)
	local DefFactorV2 = Create_VTable(7,nil,FP)
	local MarHP = Create_VTable(7,nil,FP)
	local MarHP2 = Create_VTable(7,nil,FP)
	local DefUpCompCount = Create_VTable(7,nil,FP)
	local AtkUpCompCount = Create_VTable(7,nil,FP)
	local CurrentHP = Create_VTable(7,nil,FP)
	local MarMaxHP = Create_VTable(7,10000*256,FP)
	local AtkUpgradeMaskRetArr,AtkUpgradePtrArr,NormalUpgradeMaskRetArr,
	NormalUpgradePtrArr,DefUpgradeMaskRetArr,DefUpgradePtrArr,AtkFactorMaskRetArr,
	AtkFactorPtrArr,DefFactorMaskRetArr,DefFactorPtrArr,MarShMaskRetArr,MarShPtrArr = CreateTables(12)
	local SelPTR,SelEPD,SelHP,SelSh,SelPl,SelMaxHP = CreateVariables(6)
	local SelUID = CreateVar(FP)
	local BarRally = CreateVarArr(7,FP)
	local MulCon = CreateVarArr(7,FP)
	local ExchangeP = CreateVar(FP)
	local MarTempSh = CreateVar(FP)
	local DelayMedic = Create_CCTable(7)
	local ShUsed = Create_CCTable(7)
	local GiveRate = Create_CCTable(7)
	local OrderCool = CreateCCodeArr(7)
	local AvailableStat = Create_VTable(7,nil,FP)
	local CurrentStat = Create_VTable(7,nil,FP)
	local MaxLevel = Create_VTable(7,nil,FP)
	local MaxScore = Create_VTable(7,nil,FP)
	

	--����
	local Nukes = CreateVarArr(7,FP)
	local Supply = {}
	for i = 1, 7 do
		Supply[i] = CreateVar2(FP,nil,nil,48)
	end
	local MultiCommand = CreateCcodeArr(7)
	local MultiStimPack = CreateCcodeArr(7)
	local TeamEnchant = CreateCcode()
	
	for i = 0, 6 do
		table.insert(AtkUpgradeMaskRetArr,(0x58D2B0+(i*46)+0+i)%4)
		table.insert(AtkUpgradePtrArr,0x58D2B0+(i*46)+0+i - AtkUpgradeMaskRetArr[i+1])
		table.insert(NormalUpgradeMaskRetArr,(0x58D2B0+(i*46)+7)%4)
		table.insert(NormalUpgradePtrArr,0x58D2B0+(i*46)+7 - NormalUpgradeMaskRetArr[i+1])
		table.insert(DefUpgradeMaskRetArr,(0x58D2B0+(i*46)+8+i)%4)
		table.insert(DefUpgradePtrArr,0x58D2B0+(i*46)+8+i - DefUpgradeMaskRetArr[i+1])
		table.insert(AtkFactorMaskRetArr,(0x6559C0+((i)*2))%4)
		table.insert(AtkFactorPtrArr,0x6559C0+((i)*2) - AtkFactorMaskRetArr[i+1])
		table.insert(DefFactorMaskRetArr,(0x6559C0+((i+8)*2))%4)
		table.insert(DefFactorPtrArr,0x6559C0+((i+8)*2) - DefFactorMaskRetArr[i+1])
		table.insert(MarShMaskRetArr,(0x660E00 + (MariD[i+1]*2))%4)
		table.insert(MarShPtrArr,0x660E00 + (MariD[i+1]*2) - (MarShMaskRetArr[i+1]))
	end

	local InsertKey = {}
	InsertKey[1] = "\x13\x04����������������������������������������������������������������������������������������������������������������\n\x13\x04�� ���� Ŭ������ ������ ������ \n\x13\x08���� ���� \x04�� \x1F�޼��� �ܰ�\x04�� \x07���ھ�(����)\x04�� ������ ������ ��Ÿ���ϴ�.\n\x13\x04����� �Ѱ踦 ������ ������!\n\x13\x07�̷������� ���� ���� �ܰ�� ���׷��̵�\x04�� �����մϴ�.\n\x13\x04255 ���׷��̵� �Ϸ� �� \x1F0���� ���� �� ���� ���ݷ��� �״�� ���µ˴ϴ�.\n\x13\x04Normal Marine + \x1F25000 Ore \x04= \x1FExCeed Marine\n\x13\x04���ռҴ� �߾� ���� ������ �ִ°����� ���ø� �˴ϴ�.\n\x13\x04PgUp, PgDn Ű�� ���� �������� �ٲ� �� �ֽ��ϴ�.\n\x13\x04�������������������������������������������������� Page 1/3 ��������������������������������������������������\n\x13\x17�ạ̃ϣӣš������ģţ̣ţԣš��ˣţ�"
	InsertKey[2] = "\x13\x04����������������������������������������������������������������������������������������������������������������\n\x13\x04\x1CS C Archive \x04����\n\x13\x04���� ������ �����Ǵ� �׸��� \x11�ְ���(Level, Score)\x04�� \x19���� ����Ʈ \x04�Դϴ�.\n\x13\x04�׿� \x1F�̳׶�\x04, \x17���׷��̵� ��ġ\x04, \x1B���� �� \x04���� \x08������ �Ұ����մϴ�.\n\x13\x04���� ����Ʈ�� �پ��� �̷ο� ȿ���� ���� �� �ֽ��ϴ�.\n\x13\x07��, \x0F32Bit ȯ�� \x04��Ÿũ����Ʈ������ �̿��Ͻ� �� ������\n\x13\x07 ������ �ε�� \x1D1 Level \x04�������������� �����մϴ�.\n\x13\x04�����͸� �ҷ����� ���ߴٸ� ���� ������� ����帳�ϴ�.\n\x13\x07������ ����\x04�� �� �������� Ŭ����� \x07�ڵ�����˴ϴ�. \x04�Ǵ� \x18�������� \x04�����մϴ�.\n\x13\x04�������������������������������������������������� Page 2/3 ��������������������������������������������������\n\x13\x17�ạ̃ϣӣš������ģţ̣ţԣš��ˣţ�"
	InsertKey[3] = "\x13\x04����������������������������������������������������������������������������������������������������������������\n\x13\x04��������Ʈ ������ ������ ���۳��̵��� ���� �޶����ϴ�.\n\x13\x04\x0E�ţ���\x04 = ������X \x0F�Σ�����\x04 = +3\n\x13\x04\x08�ȣ���\x04 = +6 \x10�ɣ�����\x04 = +9\n\x13\x04���� ������ Ŭ������ ���������� ��ġ�� �ջ�Ǿ� �������ϴ�.\n\x13\x04\n\x13\x04Ex) 8�������� Ŭ���� + \x08�ȣ���\x04���̵� = 8 + 6 = +14 ����\n\x13\x04\n\x13\x04��, ���� ���̵����� ������ ���� �� ���� ��������Ʈ�� ���� �� �ֽ��ϴ�.\n\x13\x04�������������������������������������������������� Page 3/3 ��������������������������������������������������\n\x13\x17�ạ̃ϣӣš������ģţ̣ţԣš��ˣţ�"
	local InsertPage = CreateCcode()
	local KeyToggle = CreateCcode()
	CMov(FP,0x6509B0,LocalPV)
	TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,CPConsole)},{},{Preserved})
	CIfX(FP,{Deaths(CurrentPlayer,Exactly,0,CPConsole)})
	Trigger2X(FP,{MemoryX(0x596A38, Exactly, 0x00000100,0x100),CDeaths(FP,Exactly,0,KeyToggle)},{SetCDeaths(FP,Add,1,InsertPage),SetCDeaths(FP,SetTo,1,DeleteToggle),SetCDeaths(FP,SetTo,1,KeyToggle)},{Preserved})
	Trigger2X(FP,{MemoryX(0x596A38, Exactly, 0x00010000,0x10000),CDeaths(FP,Exactly,0,KeyToggle)},{SetCDeaths(FP,Subtract,1,InsertPage),SetCDeaths(FP,SetTo,1,DeleteToggle),SetCDeaths(FP,SetTo,1,KeyToggle)},{Preserved})
	Trigger2X(FP,{Memory(0x596A44, Exactly, 0x00000100),CDeaths(FP,Exactly,0,KeyToggle)},{SetCDeaths(FP,SetTo,1,DeleteToggle),SetCDeaths(FP,SetTo,1,KeyToggle)},{Preserved})
	for i = 0, 2 do
	Trigger2X(FP,{CDeaths(FP,Exactly,i,InsertPage),CDeaths(FP,Exactly,1,DeleteToggle)},{DisplayText(InsertKey[i+1],4)},{Preserved})
	end
	CElseX(SetCDeaths(FP,SetTo,0,DeleteToggle)) -- ���罺�� �� ���
	local AvailableStatVA = CreateVarray(FP,7)
	local CurrentStatVA = CreateVarray(FP,7)
	local MaxLevelVA = CreateVarray(FP,7)
	local MaxScoreVA = CreateVarray(FP,7)
	local SupplyVA = CreateVarray(FP,7)
	local NukesVA = CreateVarray(FP,7)
	local SuppMaxVA = CreateVarray(FP,7)
	local LocalCcode_Stim = CreateCcode()
	local LocalCcode_Multi = CreateCcode()
		DoActionsX(FP,{SetCDeaths(FP,SetTo,0,LocalCcode_Stim),SetCDeaths(FP,SetTo,0,LocalCcode_Multi)})
		for i = 0, 6 do
		CIf(FP,{LocalPlayerID(i)},{SetMemory(0x6509B0,SetTo,FP)}) -- �������ͽ� ����
		ItoDec(FP,AvailableStat[i+1],VArr(AvailableStatVA,0),2,nil,2)
		ItoDec(FP,CurrentStat[i+1],VArr(CurrentStatVA,0),2,nil,2)
		ItoDec(FP,MaxLevel[i+1],VArr(MaxLevelVA,0),2,0x1F,2)
		ItoDec(FP,MaxScore[i+1],VArr(MaxScoreVA,0),2,0x07,2)
		ItoDec(FP,Supply[i+1],VArr(SupplyVA,0),2,nil,2)
		ItoDec(FP,Nukes[i+1],VArr(NukesVA,0),2,nil,2)
		ItoDec(FP,SuppMax,VArr(SuppMaxVA,0),2,nil,2)
		TriggerX(FP,{CDeaths(FP,AtLeast,1,MultiStimPack[i+1])},{SetCDeaths(FP,SetTo,1,LocalCcode_Stim)},{Preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,1,MultiCommand[i+1])},{SetCDeaths(FP,SetTo,1,LocalCcode_Multi)},{Preserved})
		CIfEnd()
		end

		_0DPatchX(FP,AvailableStatVA,6)
		_0DPatchX(FP,CurrentStatVA,6)
		_0DPatchX(FP,MaxLevelVA,6)
		_0DPatchX(FP,MaxScoreVA,6)
		_0DPatchX(FP,SupplyVA,6)
		_0DPatchX(FP,NukesVA,6)
		_0DPatchX(FP,SuppMaxVA,6)
		f_Movcpy(FP,_Add(StatusStrPtr1,StatPT[2]),VArr(AvailableStatVA,0),5*4)
		f_Movcpy(FP,_Add(StatusStrPtr1,StatPT[2]+DBossT2[2]+(5*4)),VArr(CurrentStatVA,0),5*4)

		f_Movcpy(FP,_Add(HiScoreStrPtr,HiScoreT1[2]),VArr(MaxLevelVA,0),5*4)
		f_Movcpy(FP,_Add(HiScoreStrPtr,HiScoreT1[2]+HiScoreT2[2]+(5*4)),VArr(MaxScoreVA,0),5*4)

		
		f_Movcpy(FP,_Add(NukeStrPtr,NukeT[2]),VArr(NukesVA,0),5*4)
		f_Movcpy(FP,_Add(SupplyStrPtr,SupplyT[2]),VArr(SupplyVA,0),5*4)
		f_Movcpy(FP,_Add(SupplyStrPtr,SupplyT[2]+(5*4)+SupplyT2[2]),VArr(SuppMaxVA,0),5*4)


		CMov(FP,0x6509B0,LocalPV)--CP ���÷� ��ȯ

		
		
		DoActions(FP,{DisplayText(string.rep("\n", 20),4),
		DisplayText("\x0D\x0D\x0DHiSc".._0D,4),
		DisplayText("\x0D\x0D\x0DUStat".._0D,4),
		DisplayText("\n\n\x13\x07�� \x1F100�� �̳׶� \x04����(Q) \x1F(Cost:4) \x07��",4), -- �̳׶� ����
		DisplayText("\x0D\x0D\x0DNuke".._0D,4),
		DisplayText("\x0D\x0D\x0DSupp".._0D,4),
	})
	TriggerX(FP,{CDeaths(FP,Exactly,0,LocalCcode_Stim)},{DisplayText("\n\n\x13\x07�� \x13\x1B���� ������ \x04����(R) \x1F(Cost:20) \x07��",4)},{Preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,1,LocalCcode_Stim)},{DisplayText("\n\n\x13\x07�� \x13\x1B���� ������ \x04����(R) \x1F(Cost:20) \x03���� �Ϸ�! \x07��",4)},{Preserved})
	TriggerX(FP,{CDeaths(FP,Exactly,0,LocalCcode_Multi)},{DisplayText("\n\n\x13\x07�� \x13\x1D��Ƽ \x1BĿ�ǵ� \x04����(T) \x1F(Cost:20) \x07��",4)},{Preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,1,LocalCcode_Multi)},{DisplayText("\n\n\x13\x07�� \x13\x1D��Ƽ \x1BĿ�ǵ� \x04����(T) \x1F(Cost:20) \x03���� �Ϸ�! \x07��",4)},{Preserved})
	TriggerX(FP,{CDeaths(FP,Exactly,0,TeamEnchant)},{DisplayText("\n\n\x13\x07�� \x13\x04Normal Marine \x1B��ȭ \x04����(Y) \x1F(Cost:30) \x07��",4)},{Preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,1,TeamEnchant)},{DisplayText("\n\n\x13\x07�� \x13\x04Normal Marine \x1B��ȭ \x04����(Y) \x1F(Cost:30) \x03���� �Ϸ�! \x07��",4)},{Preserved})

		Trigger2X(FP,{MemoryX(0x596A38, Exactly, 0x00000100,0x100),CDeaths(FP,Exactly,0,KeyToggle)},{SetCDeaths(FP,SetTo,1,KeyToggle),PlayWAV("sound\\Misc\\Buzz.wav"),
			PlayWAV("sound\\Misc\\Buzz.wav"),
			print_utf8(12,0,"\x07�� \x1F��� ON \x04���¿����� ����� �� ���� ����Դϴ�. \x03ESC\x04�� ���� ����� OFF���ּ���. \x07��"),SetDeaths(CurrentPlayer,SetTo,150,15);},{Preserved})
		Trigger2X(FP,{MemoryX(0x596A38, Exactly, 0x00010000,0x10000),CDeaths(FP,Exactly,0,KeyToggle)},{SetCDeaths(FP,SetTo,1,KeyToggle),PlayWAV("sound\\Misc\\Buzz.wav"),
			PlayWAV("sound\\Misc\\Buzz.wav"),
			print_utf8(12,0,"\x07�� \x1F��� ON \x04���¿����� ����� �� ���� ����Դϴ�. \x03ESC\x04�� ���� ����� OFF���ּ���. \x07��"),SetDeaths(CurrentPlayer,SetTo,150,15);},{Preserved})
		Trigger2X(FP,{Memory(0x596A44, Exactly, 0x00000100),CDeaths(FP,Exactly,0,KeyToggle)},{SetCDeaths(FP,SetTo,1,KeyToggle),PlayWAV("sound\\Misc\\Buzz.wav"),
			PlayWAV("sound\\Misc\\Buzz.wav"),
			print_utf8(12,0,"\x07�� \x1F��� ON \x04���¿����� ����� �� ���� ����Դϴ�. \x03ESC\x04�� ���� ����� OFF���ּ���. \x07��"),SetDeaths(CurrentPlayer,SetTo,150,15);},{Preserved})

	CIfXEnd()
	Trigger2X(FP,{Memory(0x596A38, Exactly, 0),Memory(0x596A44, Exactly, 0),CDeaths(FP,Exactly,1,KeyToggle)},{SetCDeaths(FP,SetTo,0,KeyToggle)},{Preserved})
	
	Trigger2X(FP,{Memory(0x596A44, Exactly, 65536)},{SetCDeaths(FP,SetTo,0,DeleteToggle),DisplayText(string.rep("\n", 20),4)},{Preserved})

	DoActions(FP,SetMemory(0x6509B0,SetTo,FP)) -- CP ���� 


	for i = 0, 6 do -- ���÷��̾�
		if i ~= 0 then --����Ʈ���Ŵ� 1�÷��̾� ����
		Trigger { -- ����
			players = {i},
			conditions = {
				Label(0);
				CDeaths(FP,AtLeast,5,BanToken[i+1]);
			},
			actions = {
				RotatePlayer({DisplayTextX("\x07�� \x04"..PlayerString[i+1].."\x04�� ����ó���� �Ϸ�Ǿ����ϴ�.\x07 ��",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i);
				},
			}
			Trigger { -- ���� ���
				players = {i},
				conditions = {
					Label(0);
					CDeaths(FP,AtLeast,5,BanToken[i+1]);Memory(0x57F1B0, Exactly, i)
					
				},
				actions = {
					PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
					PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
					PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					SetMemory(0xCDDDCDDC,SetTo,1);
					
					},
				}
		end
		
		Trigger { -- �̳׶� ���̳ʽ� ����
			players = {i},
			conditions = {
				Accumulate(i,AtLeast,0x80000000,ore)
			},
			actions = {
				SetResources(i,SetTo,0x7FFFFFFF,ore);
				PreserveTrigger();
			},
		}
		
		for k = 64, 67 do
			local X = {}
			if k == 64 or k == 66 then
				X = {SetCDeaths(FP,Add,100,OrderCool[i+1])}
			else
				X = nil
			end
			Trigger { -- ��ư ���
				players = {i},
				conditions = {
					Label(0);
					Bring(i,AtLeast,1,k,64);
				},
				actions = {
					SetDeaths(i,SetTo,1,k);
					RemoveUnitAt(1,k,"Anywhere",i);
					SetCDeaths(FP,Add,1,CUnitFlag);
					X;
					PreserveTrigger();
				},
			}
		end
		
		TriggerX(i,{CVar(FP,AtkUpCompCount[i+1][2],AtLeast,10)},{
				DisplayText(string.rep("\n", 20),4);
				DisplayText("\x13\x04"..string.rep("��", 56),4);
				DisplayText("\x13\x0F�ӣˣɣ̡̣��գΣ̣ϣãˣţ�",0);
				DisplayText("\n",4);
				DisplayText("\x13\x1B���� ������ \x04�� �����ϼ̽��ϴ�.\n\x13\x04�������� \x1B���� ������\x04�� ����� �� �ֽ��ϴ�.",0);
				DisplayText("\n",4);
				DisplayText("\x13\x0F�ӣˣɣ̡̣��գΣ̣ϣãˣţ�",0);
				DisplayText("\x13\x04"..string.rep("��", 56),4);
				SetMemoryB(0x57F27C+(228*i)+71,SetTo,1);
				PlayWAV("staredit\\wav\\Unlock.ogg");
				PlayWAV("staredit\\wav\\Unlock.ogg");
				PlayWAV("staredit\\wav\\Unlock.ogg");
		})
		
		Trigger { -- ������
			players = {i},
			conditions = {
				Label(0);
				Bring(i,AtLeast,1,71,64);
			},
			actions = {
				SetDeaths(i,Add,1,71);
				RemoveUnitAt(1,71,"Anywhere",i);
				DisplayText("\x07�� \x04���� \x1B������\x04����� ����մϴ�.\x07 ��",4);
				SetCDeaths(FP,Add,1,CUnitFlag);
				PreserveTrigger();
			},
		}
		
		CIf(i,Bring(i,AtLeast,1,19,64))
		Trigger { -- ��ȣ�� ����
			players = {i},
			conditions = {
				Label(0);
				Memory(0x582294+(4*i),AtLeast,1);
				Memory(0x582294+(4*i),AtMost,1000);
				Bring(i,AtLeast,1,19,64);
			},
			actions = {
				SetResources(i,Add,65000,Ore);
				RemoveUnitAt(1,19,"Anywhere",i);
				DisplayText("\x07�� \x04���� \x1C���� ��ȣ��\x04�� ��Ÿ�����Դϴ�. �ڿ� ��ȯ + \x1F65000 Ore\x07��",4);
				PlayWAV("sound\\Misc\\PError.WAV");
				PlayWAV("sound\\Misc\\PError.WAV");
				PreserveTrigger();
			},
		}
		Trigger { -- ��ȣ�� ����
			players = {i},
			conditions = {
				Label(0);
				Memory(0x582294+(4*i),AtLeast,1001);
				Bring(i,AtLeast,1,19,64);
			},
			actions = {
				SetResources(i,Add,65000,Ore);
				RemoveUnitAt(1,19,"Anywhere",i);
				DisplayText("\x07�� \x04�̹� \x1C���� ��ȣ��\x04�� ������Դϴ�. �ڿ� ��ȯ + \x1F65000 Ore\x07��",4);
				PlayWAV("sound\\Misc\\PError.WAV");
				PlayWAV("sound\\Misc\\PError.WAV");
				PreserveTrigger();
			},
		}
		
		Trigger { -- ��ȣ�� ����
			players = {i},
			conditions = {
				Label(0);
				Memory(0x582294+(4*i),AtMost,0);
				Bring(i,AtLeast,1,19,64);
			},
			actions = {
				SetMemory(0x582294+(4*i),SetTo,2000);
				RemoveUnitAt(1,19,"Anywhere",i);
				RotatePlayer({DisplayTextX("\x0D\x0D\x0D"..PlayerString[i+1].."shd".._0D,4),PlayWAVX("staredit\\wav\\shield_use.ogg")},HumanPlayers,i);
				SetCDeaths(FP,SetTo,1,ShUsed[i+1]);
				PreserveTrigger();
			},
		}
		CIfEnd()
		Trigger { -- ��ȣ�� ����
			players = {i},
			conditions = {
				Label(0);
				Memory(0x582294+(4*i),Exactly,1000);
			},
			actions = {
				DisplayText("\x07�� \x1C���� ��ȣ��\x04 ����� ����Ǿ����ϴ�. \x07��",4);
				PlayWAV("staredit\\wav\\GMode.ogg");
				PlayWAV("staredit\\wav\\GMode.ogg");
				PreserveTrigger();
			},
		}
		Trigger { -- ��ȣ�� ����
			players = {i},
			conditions = {
				Label(0);
				CDeaths(FP,AtLeast,1,ShUsed[i+1]);
				Memory(0x582294+(4*i),Exactly,0);
			},
			actions = {
				DisplayText("\x07�� \x1C���� ��ȣ��\x04 ��Ÿ���� ����Ǿ����ϴ�. \x07��",4);
				PlayWAV("staredit\\wav\\GMode.ogg");
				PlayWAV("staredit\\wav\\GMode.ogg");
				SetCDeaths(FP,SetTo,0,ShUsed[i+1]);
				PreserveTrigger();
			},
		}
		for j = 1, 5 do
		Trigger { -- ��ȣ�� ���
			players = {i},
			conditions = {
				Label(0);
				Memory(0x582294+(4*i),Exactly,50*j+(1000));
			},
			actions = {
				DisplayText("\x07�� \x1C���� ��ȣ��\x04�� "..j.."�� ���ҽ��ϴ�. \x07��",4);
				PlayWAV("staredit\\wav\\sel_m.ogg");
				PlayWAV("staredit\\wav\\sel_m.ogg");
				PreserveTrigger();
			},
		}
		end
		for j = 1, 5 do
		Trigger { -- ��ȣ�� ��Ÿ��
			players = {i},
			conditions = {
				Label(0);
				Memory(0x582294+(4*i),Exactly,50*j);
			},
			actions = {
				DisplayText("\x07�� \x1C���� ��ȣ��\x04 ��Ÿ���� "..j.."�� ���ҽ��ϴ�. \x07��",4);
				PlayWAV("staredit\\wav\\sel_m.ogg");
				PlayWAV("staredit\\wav\\sel_m.ogg");
				PreserveTrigger();
			},
		}
		end
		
		
		
		Trigger2(i,{Memory(0x582294+(4*i),AtLeast,1)},{SetMemory(0x582294+(4*i),Subtract,1)},{Preserved})
		
		CIf(FP,{Deaths(i,AtLeast,1,CPConsole)},{SetMemory(0x6509B0,SetTo,i)}) -- ����â �������̽� Deaths 190~199
			TriggerX(FP,{Deaths(i,AtMost,0,15),Memory(0x57F1B0,Exactly,i)},{SetCDeaths(FP,SetTo,0,DeleteToggle),
				print_utf8(12,0,"\x07[ \x1F���, \x19����â\04�� �����ֽ��ϴ�. ESC : �ݱ�\x07 ]")
			},{Preserved}) -- 13���� ����Ʈ Ʈ���� �÷��̾ FP�� ������ Ʈ���� ������ 1P���� 8P���� ����Ǳ� ����. i�� �ϰԵ� ��� �̰� ������ �����ִ� CText�� ���̰� �ȴ�. 
			--���� ������ ���� PlayWAV("staredit\\wav\\BuySE.ogg");
			--���� ���н� ���� PlayWAV("staredit\\wav\\FailSE.ogg");
		
			KeyInput(190--[[Q]],{CVar(FP,AvailableStat[i+1][2],AtLeast,1)},{SetCVar(FP,AvailableStat[i+1][2],Subtract,1),SetResources(i,Add,1000000,Ore),print_utf8(12,0,"\x07[ \x07���� ����, \x04�̳׶��� \x1F1,000,000 \x04�����Ͽ����ϴ�. \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --�̳׶�
			KeyInput(191--[[W]],{CVar(FP,AvailableStat[i+1][2],AtLeast,1)},{SetCVar(FP,AvailableStat[i+1][2],Subtract,1),SetCVar(FP,Nukes[i+1][2],Add,1),print_utf8(12,0,"\x07[ \x07���� ����, \x08��Ŭ����\x04�� �����Ǿ����ϴ�. \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --��
			KeyInput(190--[[Q]],{CVar(FP,AvailableStat[i+1][2],AtMost,0)},{print_utf8(12,0,"\x07[ \x08����Ʈ�� �����մϴ� \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --�̳׶�
			KeyInput(191--[[W]],{CVar(FP,AvailableStat[i+1][2],AtMost,0)},{print_utf8(12,0,"\x07[ \x08����Ʈ�� �����մϴ� \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --��
			CIf(FP,{Deaths(CurrentPlayer,AtLeast,1,192)})
				CIfX(FP,{CVar(FP,AvailableStat[i+1][2],AtLeast,1)},{SetCVar(FP,AvailableStat[i+1][2],Subtract,1),SetCVar(FP,Supply[i+1][2],Add,6),print_utf8(12,0,"\x07[ \x07���� ����, \x04�α����� \x073 \x04�����Ͽ����ϴ�. \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");})
				CElseX()
					CTrigger(FP,{TCVar(FP,Supply[i+1][2],AtLeast,_Sub(SuppMax,_Mov(1)))},{print_utf8(12,0,"\x07[ \x08���� ����, \x04�� �ִ� �α����� �� á���ϴ�. \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1)
					TriggerX(FP,{CVar(FP,AvailableStat[i+1][2],AtMost,0)},{print_utf8(12,0,"\x07[ \x08����Ʈ�� �����մϴ� \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},{Preserved})
				CIfXEnd()
			CIfEnd()
			KeyInput(193--[[R]],{CDeaths(FP,AtLeast,1,MultiStimPack[i+1])},{print_utf8(12,0,"\x07[ \x08�̹� ���ԵǾ����ϴ�. \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --��ƼĿ��
			KeyInput(194--[[T]],{CDeaths(FP,AtLeast,1,MultiCommand[i+1])},{print_utf8(12,0,"\x07[ \x08�̹� ���ԵǾ����ϴ�. \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --���ݽ���
			KeyInput(195--[[Y]],{CDeaths(FP,AtLeast,1,TeamEnchant)},{print_utf8(12,0,"\x07[ \x08�̹� ���ԵǾ����ϴ�. \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --�ϸ���ȭ

			KeyInput(193--[[R]],{CVar(FP,AvailableStat[i+1][2],AtLeast,20),CDeaths(FP,AtMost,0,MultiStimPack[i+1])},{SetCDeaths(FP,SetTo,1,MultiStimPack[i+1]),print_utf8(12,0,"\x07[ \x07���� ����, \x1B���� ������ \x04����� ����� �� �ֽ��ϴ�. \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --��ƼĿ��
			KeyInput(194--[[T]],{CVar(FP,AvailableStat[i+1][2],AtLeast,20),CDeaths(FP,AtMost,0,MultiCommand[i+1])},{SetCDeaths(FP,SetTo,1,MultiCommand[i+1]),print_utf8(12,0,"\x07[ \x07���� ����, \x1D��Ƽ \x1BĿ�ǵ� \x04����� ����� �� �ֽ��ϴ�. \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --���ݽ���
			KeyInput(195--[[Y]],{CVar(FP,AvailableStat[i+1][2],AtLeast,30),CDeaths(FP,AtMost,0,TeamEnchant)},{SetCDeaths(FP,SetTo,1,TeamEnchant),print_utf8(12,0,"\x07[ \x07���� ����, \x04������\x04Normal Marine\x04�� \x1B��ȭ \x04�Ǿ����ϴ�. \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --�ϸ���ȭ

			KeyInput(193--[[R]],{CVar(FP,AvailableStat[i+1][2],AtLeast,19),CDeaths(FP,AtMost,0,MultiStimPack[i+1])},{print_utf8(12,0,"\x07[ \x08����Ʈ�� �����մϴ� \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --��ƼĿ��
			KeyInput(194--[[T]],{CVar(FP,AvailableStat[i+1][2],AtLeast,19),CDeaths(FP,AtMost,0,MultiCommand[i+1])},{print_utf8(12,0,"\x07[ \x08����Ʈ�� �����մϴ� \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --���ݽ���
			KeyInput(195--[[Y]],{CVar(FP,AvailableStat[i+1][2],AtLeast,29),CDeaths(FP,AtMost,0,TeamEnchant)},{print_utf8(12,0,"\x07[ \x08����Ʈ�� �����մϴ� \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --�ϸ���ȭ
			
			
		CifEnd()
		TriggerX(i,{Deaths(CurrentPlayer,Exactly,0,OPConsole),Deaths(CurrentPlayer,AtLeast,1,F9),Deaths(CurrentPlayer,Exactly,0,B),Deaths(CurrentPlayer,Exactly,0,CPConsole)},{SetDeaths(CurrentPlayer,SetTo,1,CPConsole),SetDeaths(CurrentPlayer,SetTo,0,F9)},{Preserved})
		TriggerX(i,{Deaths(CurrentPlayer,Exactly,0,OPConsole),Deaths(CurrentPlayer,AtLeast,1,F9),Deaths(CurrentPlayer,Exactly,0,B),Deaths(CurrentPlayer,Exactly,1,CPConsole)},{SetDeaths(CurrentPlayer,SetTo,0,CPConsole),SetDeaths(CurrentPlayer,SetTo,0,F9)},{Preserved})
		--CPConsole
		CIfX(i,{Deaths(CurrentPlayer,AtLeast,1,CPConsole)},SetCDeaths(FP,Add,1,FuncT[i+1]))
		TriggerX(i,{CDeaths(FP,AtLeast,30*24,FuncT[i+1])},{SetDeaths(CurrentPlayer,SetTo,0,CPConsole),SetCDeaths(FP,SetTo,0,FuncT[i+1])},{Preserved})
		
		GiveRateT = {"\x07�� \x04��αݾ� ������ \x1F5000 Ore\x04 \x04�� ����Ǿ����ϴ�.\x07 ��",
		"\x07�� \x04��αݾ� ������ \x1F10000 Ore \x04�� ����Ǿ����ϴ�.\x07 ��",
		"\x07�� \x04��αݾ� ������ \x1F50000 Ore \x04�� ����Ǿ����ϴ�.\x07 ��",
		"\x07�� \x04��αݾ� ������ \x1F100000 Ore \x04�� ����Ǿ����ϴ�.\x07 ��",
		"\x07�� \x04��αݾ� ������ \x1F500000 Ore \x04�� ����Ǿ����ϴ�.\x07 ��",
		"\x07�� \x04��αݾ� ������ \x1F1000 Ore \x04�� ����Ǿ����ϴ�.\x07 ��"}
		for k = 0, 5 do
		Trigger { -- ��� �ݾ� ����
			players = {i},
			conditions = {
				Label(0);
				CDeaths(FP,Exactly,k,GiveRate[i+1]);
				Deaths(CurrentPlayer,AtLeast,1,219)
			},
			actions = {
				SetDeaths(CurrentPlayer,SetTo,0,219);
				DisplayText(GiveRateT[k+1],4);
				SetCDeaths(FP,Add,1,GiveRate[i+1]);
				SetCDeaths(FP,SetTo,0,FuncT[i+1]);
				PreserveTrigger();
				},
		}
		end
		TriggerX(i,{CDeaths(FP,AtLeast,6,GiveRate[i+1])},{SetCDeaths(FP,Subtract,6,GiveRate[i+1])},{Preserved})
		
		for j=0, 6 do
			if i==j then
				Trigger { -- �� ��� �ý���
					players = {i},
					conditions = {
						Deaths(i,AtLeast,1,j+212);
					},
					actions = {
						SetDeaths(i,SetTo,0,j+212);
						DisplayText("\x07�� "..PlayerString[j+1].."\x04��(��) �ڱ� �ڽ��Դϴ�. �ڱ� �ڽſ��Դ� ����� �� �����ϴ�. \x07��",4);
						SetCDeaths(FP,SetTo,0,FuncT[i+1]);
						PreserveTrigger();
					},
				}
			else
				for k=0, 5 do
					Trigger { -- �� ��� �ý���
						players = {i},
						conditions = {
							Label(0);
							Deaths(i,AtLeast,1,j+212);
							PlayerCheck(i,1);
							CDeaths(FP,Exactly,k,GiveRate[i+1]);
							Accumulate(i,AtMost,GiveRate2[k+1],Ore);
						},
						actions = {
							SetDeaths(i,SetTo,0,j+212);
							DisplayText("\x07�� \x04�ܾ��� �����մϴ�. \x07��",4);
							SetCDeaths(FP,SetTo,0,FuncT[i+1]);
							PreserveTrigger();
						},
					}
					Trigger { -- �� ��� �ý���
						players = {i},
						conditions = {
							Label(0);
							Deaths(i,AtLeast,1,j+212);
							PlayerCheck(j,1);
							CDeaths(FP,Exactly,k,GiveRate[i+1]);
							Accumulate(i,AtLeast,GiveRate2[k+1],Ore);
							Accumulate(i,AtMost,0x7FFFFFFF,Ore);
						},
						actions = {
							SetDeaths(i,SetTo,0,j+212);
							SetResources(i,Subtract,GiveRate2[k+1],Ore);
							SetResources(j,Add,GiveRate2[k+1],Ore);
							DisplayText("\x07�� "..PlayerString[j+1].."\x04���� \x1F"..GiveRate2[k+1].." Ore\x04�� ����Ͽ����ϴ�. \x07��",4);
							SetMemory(0x6509B0,SetTo,j);
							DisplayText("\x12\x07��"..PlayerString[i+1].."\x04���� \x1F"..GiveRate2[k+1].." Ore\x04�� ��ι޾ҽ��ϴ�.\x02 \x07��",4);
							SetMemory(0x6509B0,SetTo,i);
							SetCDeaths(FP,SetTo,0,FuncT[i+1]);
							PreserveTrigger();
						},
					}
				end
				Trigger { -- �� ��� �ý���
					players = {i},
					conditions = {
						Label(0);
						Deaths(i,AtLeast,1,j+212);
						PlayerCheck(j,0);
					},
					actions = {
						SetDeaths(i,SetTo,0,j+212);
						DisplayText("\x07�� "..PlayerString[j+1].."\x04��(��) �������� �ʽ��ϴ�. \x07��",4);
						SetCDeaths(FP,SetTo,0,FuncT[i+1]);
						PreserveTrigger();
					},
				}
			end 
		end 
		
			TriggerX(i,{Deaths(CurrentPlayer,AtLeast,1,ESC)},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(CurrentPlayer,SetTo,0,CPConsole)},{Preserved})
			CIfXEnd()
		
			DoActions(i,{
				SetMemoryB(0x57F27C+(228*i)+MedicTrig[1],SetTo,0),
				SetMemoryB(0x57F27C+(228*i)+MedicTrig[2],SetTo,0),
				SetMemoryB(0x57F27C+(228*i)+MedicTrig[3],SetTo,0),
				SetMemoryB(0x57F27C+(228*i)+MedicTrig[4],SetTo,0),
			})
			for j = 0, 3 do
			TriggerX(i,{CDeaths(FP,Exactly,j,DelayMedic[i+1])},{SetMemoryB(0x57F27C+(228*i)+MedicTrig[j+1],SetTo,1)},{Preserved})
			TriggerX(i,{Command(i,AtLeast,1,72),CDeaths(FP,Exactly,j,DelayMedic[i+1])},{
				DisplayText(DelayMedicT[j+1],4),
				SetCDeaths(FP,Add,1,DelayMedic[i+1]),
				GiveUnits(All,72,i,"Anywhere",P12),
				RemoveUnitAt(1,72,"Anywhere",P12)},{Preserved})
			end
			TriggerX(i,{CDeaths(FP,AtLeast,4,DelayMedic[i+1])},{SetCDeaths(FP,Subtract,4,DelayMedic[i+1])},{Preserved})
		
			Trigger2(i,{DeathsX(i,Exactly,0,440,0xFF000000);Command(i,AtLeast,1,22);},{
				GiveUnits(All,22,i,"Anywhere",P12);
				RemoveUnitAt(All,22,"Anywhere",P12);
				DisplayText("\x07�� \x1CBGM\x04�� ���� �ʽ��ϴ�. \x07��",4);
				SetDeathsX(i,SetTo,1*16777216,440,0xFF000000);
			},{Preserved})

			Trigger2(i,{DeathsX(i,Exactly,1*16777216,440,0xFF000000);Command(i,AtLeast,1,22);},{
				GiveUnits(All,22,i,"Anywhere",P12);
				RemoveUnitAt(All,22,"Anywhere",P12);
				DisplayText("\x07�� \x1CBGM\x04�� ����ϴ�. \x07��",4);
				SetDeathsX(i,SetTo,0*16777216,440,0xFF000000);
			},{Preserved})

			TriggerX(i,{Command(i,AtLeast,1,70);},{
				GiveUnits(All,70,i,"Anywhere",P12);
				RemoveUnitAt(All,70,"Anywhere",P12);
				DisplayText("\x07�� \x1C��� ����\x04�� \x1D�������ݸ�� \x04�� �����ϴ�. (\x0FJunk Yard Dog\x04) \x07��",4);
				SetDeaths(i,SetTo,1,70);
				SetCDeaths(FP,Add,1,CUnitFlag);
				SetCDeaths(FP,Add,100,OrderCool[i+1]);
			},{Preserved})
			

		UnitLimit(i,7,50,"SCV��",500)
		UnitLimit(i,125,8,"��Ŀ��",8000)
		UnitLimit(i,124,15,"�ͷ���",4000)
		




		CIfX(FP,PlayerCheck(i,1)) -- FP�� �����ϴ� �ý��� �κ� Ʈ����. ���÷��̾ ������� ����ȴ�.
		--SCA ������ ������ ����
		local TempStat = CreateVar(FP)
		local TempStat2 = CreateVar(FP)
		CIf(FP,{TTDeaths(i,NotSame,CurrentStat[i+1],4)})
			f_Read(FP,0x58A364+(48*4)+(4*i),TempStat)
			CSub(FP,TempStat2,TempStat,CurrentStat[i+1])
			CMov(FP,CurrentStat[i+1],TempStat)
			CAdd(FP,AvailableStat[i+1],TempStat2)
		CIfEnd()
		CIf(FP,{TTDeaths(i,NotSame,MaxLevel[i+1],6)})
			f_Read(FP,0x58A364+(48*6)+(4*i),TempStat)
			CMov(FP,MaxLevel[i+1],TempStat)
		CIfEnd()
		CIf(FP,{TTDeaths(i,NotSame,MaxScore[i+1],24)})
			f_Read(FP,0x58A364+(48*24)+(4*i),TempStat)
			CMov(FP,MaxScore[i+1],TempStat)
		CIfEnd()

		CIf(FP,{Deaths(i,AtLeast,36,126),Bring(i,AtLeast,1,12,64)})
			TriggerX(FP,{Bring(i,AtLeast,1,12,64)},{
				SetMemory(0x6509B0,SetTo,i),
				DisplayText("\x07�� \x1F����\x04�� �Ҹ��Ͽ� \x1FExceeD \x1BM\x04arine �� \x19��ȯ\x04�Ͽ����ϴ�. - \x1F30,000 O r e \x07��",4),
				SetMemory(0x6509B0,SetTo,FP),
				RemoveUnitAt(1,12,"Anywhere",i),
				SetCDeaths(FP,Add,1,MarCreate[i+1]),
				SetMemory(0x582324+(12*12)+(i*4),SetTo,0),
				SetMemory(0x584DE4+(12*12)+(i*4),SetTo,0),
			},{Preserved})
		CIfEnd()
		
		  Trigger { -- ���� ���� �ȵ�
			players = {i},
			conditions = {
				Deaths(i,AtMost,35,126);
				Bring(i,AtLeast,1,12,64);
			},
			actions = {
				SetResources(i,Add,30000,ore);
				RemoveUnitAt(1,12,"Anywhere",i);
				DisplayText("\x07�� \x1FExceeD \x1BM\x04arine \x19���� ��ȯ\x04 ������ ���� �ʽ��ϴ�. (���� - \x1FExceeD \x1BM\x04arine \x0436�� ����) �ڿ� ��ȯ + \x1F30,000 O r e \x07��",4);
				PreserveTrigger();
			},
		}
		
		Trigger { -- ���� ��������
			players = {FP},
			conditions = {
				Label(0);
				Bring(FP,AtLeast,1,173,10);
				Bring(i,AtLeast,1,10,10);
				Accumulate(i,AtLeast,25000,Ore);
				Accumulate(i,AtMost,0x7FFFFFFF,Ore);
			},
			actions = {
				SetMemory(0x6509B0,SetTo,i),
				DisplayText("\x07�� \x1F����\x04�� �Ҹ��Ͽ� \x04Norma Marine�� \x1FExceeD \x1BM\x04arine���� \x19��ȯ\x04�Ͽ����ϴ�. - \x1F25,000 O r e \x07��",4);
				SetMemory(0x6509B0,SetTo,FP),
				SetDeaths(i,add,1,126),
				ModifyUnitEnergy(1,10,i,10,0);
				SetResources(i,Subtract,25000,ore);
				RemoveUnitAt(1,10,10,i);
				SetCDeaths(FP,Add,1,MarCreate[i+1]),
				PreserveTrigger();
			},
		}
		
		
		TriggerX(FP,{Bring(i,AtLeast,1,15,64)},{
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07�� \x1F����\x04�� �Ҹ��Ͽ� Normal Marine �� \x19��ȯ\x04�Ͽ����ϴ�. - \x1F5,000 O r e \x07��",4),
			SetMemory(0x6509B0,SetTo,FP),
			RemoveUnitAt(1,15,"Anywhere",i),
			SetCDeaths(FP,Add,1,MarCreate2[i+1]),
			SetMemory(0x582324+(12*12)+(i*4),SetTo,0),
			SetMemory(0x584DE4+(12*12)+(i*4),SetTo,0),
		},{Preserved})
		
		CIf(FP,{CDeaths(FP,AtLeast,1,MarCreate[i+1]),Memory(0x628438,AtLeast,1)},SetCDeaths(FP,Subtract,1,MarCreate[i+1]))
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			f_Read(FP,_Add(BarrackPtr[i+1],62),BarRally[i+1])
			DoActions(FP,CreateUnitWithProperties(1,MarID[i+1],2+i,i,{energy = 100}))
			CIf(FP,{TTCVar(FP,BarPos[i+1][2],NotSame,BarRally[i+1]),CVar(FP,BarRally[i+1][2],AtLeast,1),TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
				CDoActions(FP,{TSetDeathsX(_Add(Nextptrs,19),SetTo,6*256,0,0xFF00),
				TSetDeaths(_Add(Nextptrs,22),SetTo,BarRally[i+1],0)})
			CIfEnd()
			CMov(FP,0x6509B0,FP)
		CIfEnd()
		
		CIf(FP,{CDeaths(FP,AtLeast,1,MarCreate2[i+1]),Memory(0x628438,AtLeast,1)},SetCDeaths(FP,Subtract,1,MarCreate2[i+1]))
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			f_Read(FP,_Add(BarrackPtr[i+1],62),BarRally[i+1])
			DoActions(FP,CreateUnitWithProperties(1,10,2+i,i,{energy = 100}))
			CIf(FP,{TTCVar(FP,BarPos[i+1][2],NotSame,BarRally[i+1]),CVar(FP,BarRally[i+1][2],AtLeast,1),TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
				CDoActions(FP,{TSetDeathsX(_Add(Nextptrs,19),SetTo,6*256,0,0xFF00),
				TSetDeaths(_Add(Nextptrs,22),SetTo,BarRally[i+1],0)})
			CIfEnd()
			CMov(FP,0x6509B0,FP)
		CIfEnd()
		local MedicTrigJump = def_sIndex()
		for j = 1, 4 do
			NJumpX(FP,MedicTrigJump,{CDeaths(FP,Exactly,j-1,DelayMedic[i+1]),Bring(i,AtLeast,1,MedicTrig[j],64)})
		end

			NIf(FP,Never())
				NJumpXEnd(FP,MedicTrigJump)
					DoActions(FP,{
						RemoveUnit(MedicTrig[1],i),
						RemoveUnit(MedicTrig[2],i),
						RemoveUnit(MedicTrig[3],i),
						RemoveUnit(MedicTrig[4],i),
						ModifyUnitHitPoints(All,"Men",i,"Anywhere",100),
						ModifyUnitHitPoints(All,"Buildings",i,"Anywhere",100),
						ModifyUnitShields(All,"Men",i,"Anywhere",100),
						ModifyUnitShields(All,"Buildings",i,"Anywhere",100)
					})
					TriggerX(FP,{CVar(FP,LevelT2[2],AtLeast,3),Bring(FP, AtMost, 0, 147, 64)},{
						ModifyUnitShields(All,"Men",i,"Anywhere",0),
						ModifyUnitShields(All,"Buildings",i,"Anywhere",0)},{Preserved})
			NIfEnd()
		
		
		NIf(FP,MemoryB(0x58D2B0+(46*i)+18,AtLeast,1)) -- ���� 255ȸ
			CDoActions(FP,{
				SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(AtkUpgradePtrArr[i+1])),
				SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^AtkUpgradeMaskRetArr[i+1]),
				TSetCVar(FP,UpgradeFactor[2],SetTo,AtkFactorV[i+1]),
				SetCVar(FP,UpgradeCP[2],SetTo,i),
				SetCVar(FP,UpgradeMax[2],SetTo,255),
				SetMemoryB(0x58D2B0+(46*i)+18,SetTo,0)})
			CallTrigger(FP,OneClickUpgrade)
		NIfEnd()
		NIf(FP,MemoryB(0x58D2B0+(46*i)+17,AtLeast,1)) -- ���� 10ȸ
			CDoActions(FP,{
				SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(AtkUpgradePtrArr[i+1])),
				SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^AtkUpgradeMaskRetArr[i+1]),
				TSetCVar(FP,UpgradeFactor[2],SetTo,AtkFactorV[i+1]),
				SetCVar(FP,UpgradeCP[2],SetTo,i),
				SetCVar(FP,UpgradeMax[2],SetTo,10),
				SetMemoryB(0x58D2B0+(46*i)+17,SetTo,0)})
			CallTrigger(FP,OneClickUpgrade)
		NIfEnd()
		NIf(FP,MemoryB(0x58D2B0+(46*i)+19,AtLeast,1)) -- ü�� 255ȸ
			CDoActions(FP,{
				SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(DefUpgradePtrArr[i+1])),
				SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^DefUpgradeMaskRetArr[i+1]),
				TSetCVar(FP,UpgradeFactor[2],SetTo,DefFactorV[i+1]),
				SetCVar(FP,UpgradeCP[2],SetTo,i),
				SetCVar(FP,UpgradeMax[2],SetTo,255),
				SetMemoryB(0x58D2B0+(46*i)+19,SetTo,0)})
			CallTrigger(FP,OneClickUpgrade)
		NIfEnd()
		NIf(FP,MemoryB(0x58D2B0+(46*i)+20,AtLeast,1)) -- ü�� 10ȸ
			CDoActions(FP,{
				SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(DefUpgradePtrArr[i+1])),
				SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^DefUpgradeMaskRetArr[i+1]),
				TSetCVar(FP,UpgradeFactor[2],SetTo,DefFactorV[i+1]),
				SetCVar(FP,UpgradeCP[2],SetTo,i),
				SetCVar(FP,UpgradeMax[2],SetTo,10),
				SetMemoryB(0x58D2B0+(46*i)+20,SetTo,0)})
			CallTrigger(FP,OneClickUpgrade)
		NIfEnd()
		
		CIf(FP,{MemoryX(AtkUpgradePtrArr[i+1],AtLeast,255*(256^AtkUpgradeMaskRetArr[i+1]),255*(256^AtkUpgradeMaskRetArr[i+1]))},{SetMemoryX(AtkUpgradePtrArr[i+1],SetTo,0*(256^AtkUpgradeMaskRetArr[i+1]),255*(256^AtkUpgradeMaskRetArr[i+1]))})
		DoActionsX(FP,{
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x13\x04��������\x1C���ݷ� ���׷��̵�\x04�� 255�� �Ѿ� �Ѱ踦 �����մϴ�.\x04��������\n\x13\x04��������\x07���׷��̵带 \x040���� �缳���ϰ� \x17���ݷ� ��ġ�� ����\x04�Ǿ����ϴ�.\x04��������",4),
			SetMemory(0x6509B0,SetTo,FP),
			SetMemoryW(0x656EB0 + (MarWep[i+1]*2),Add,MarDamageFactor*255),
			SetCVar(FP,AtkUpCompCount[i+1][2],Add,1),
		})
		TriggerX(FP,{CDeaths(FP,AtMost,0,UpSELemit[i+1])},{SetMemory(0x6509B0,SetTo,i),PlayWAV("staredit\\wav\\LimitBreak.ogg"),PlayWAV("staredit\\wav\\LimitBreak.ogg"),PlayWAV("staredit\\wav\\LimitBreak.ogg"),PlayWAV("staredit\\wav\\LimitBreak.ogg"),SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,Add,100,UpSELemit[i+1])},{Preserved})
		TriggerX(FP,{CVar(FP,AtkUpCompCount[i+1][2],AtLeast,151)},{SetCVar(FP,AtkFactorV[i+1][2],Add,1)},{Preserved})
		CIfEnd()
		
		CIf(FP,{MemoryX(DefUpgradePtrArr[i+1],AtLeast,255*(256^DefUpgradeMaskRetArr[i+1]),255*(256^DefUpgradeMaskRetArr[i+1]))},{SetMemoryX(DefUpgradePtrArr[i+1],SetTo,0*(256^DefUpgradeMaskRetArr[i+1]),255*(256^DefUpgradeMaskRetArr[i+1]))})
		DoActionsX(FP,{
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x13\x04��������\x08ü�� ���׷��̵�\x04�� 255�� �Ѿ� �Ѱ踦 �����մϴ�.\x04��������\n\x13\x04��������\x07���׷��̵带 \x040���� �缳���ϰ� \x17ü�� ��ġ�� ����\x04�Ǿ����ϴ�.\x04��������",4),
			SetMemory(0x6509B0,SetTo,FP),
			--SetCVar(FP,DefFactorV[i+1][2],Add,1),
			SetCVar(FP,MarMaxHP[i+1][2],Add,2000*256),
			SetCVar(FP,DefUpCompCount[i+1][2],Add,1),
		})
		TriggerX(FP,{CDeaths(FP,AtMost,0,UpSELemit[i+1])},{SetMemory(0x6509B0,SetTo,i),PlayWAV("staredit\\wav\\LimitBreak.ogg"),PlayWAV("staredit\\wav\\LimitBreak.ogg"),PlayWAV("staredit\\wav\\LimitBreak.ogg"),PlayWAV("staredit\\wav\\LimitBreak.ogg"),SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,Add,100,UpSELemit[i+1])},{Preserved})
		TriggerX(FP,{CVar(FP,DefUpCompCount[i+1][2],AtLeast,51)},{SetCVar(FP,DefFactorV[i+1][2],Add,1)},{Preserved})
		CIfEnd()

		DoActionsX(FP,{SetCVar(FP,CurrentHP[i+1][2],SetTo,0)})-- ü�°� �ʱ�ȭ
		for Bit = 0, 7 do
		TriggerX(FP,{MemoryX(DefUpgradePtrArr[i+1],AtLeast,(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]),(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]))},
			{SetCVar(FP,CurrentHP[i+1][2],Add,2008*(2^Bit))},{Preserved})
		end
		CMov(FP,MarHP[i+1],_Add(CurrentHP[i+1],MarMaxHP[i+1]))
		
		CIfX(FP,CVar(FP,AtkUpCompCount[i+1][2],AtMost,0)) -- ���׷��̵� ���ø�Ʈ ī��Ʈ(255�� ���� Ƚ��)�� 0�� ���.
			DoActions(FP,{SetMemoryX(NormalUpgradePtrArr[i+1],SetTo,0*(256^NormalUpgradeMaskRetArr[i+1]),255*(256^NormalUpgradeMaskRetArr[i+1]))})
			for Bit = 0, 7 do
			Trigger2(FP,{MemoryX(AtkUpgradePtrArr[i+1],AtLeast,(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]),(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]))},
				{SetMemoryX(NormalUpgradePtrArr[i+1],Add,(2^Bit)*(256^NormalUpgradeMaskRetArr[i+1]),(2^Bit)*(256^NormalUpgradeMaskRetArr[i+1]))},{Preserved})
			end
		CElseX() -- ��������ī��Ʈ 1 �̻��̸� �ϸ����� 255�� ������!
			DoActions(FP,SetMemoryX(NormalUpgradePtrArr[i+1],SetTo,255*(256^NormalUpgradeMaskRetArr[i+1]),255*(256^NormalUpgradeMaskRetArr[i+1])),1)
		CIfXEnd()
		
		CIf(FP,{TTCVar(FP,DefFactorV2[i+1][2],NotSame,DefFactorV[i+1])})
			CDoActions(FP,{TSetMemoryX(DefFactorPtrArr[i+1],SetTo,_Mul(DefFactorV[i+1],_Mov(256^DefFactorMaskRetArr[i+1])),255*(256^DefFactorMaskRetArr[i+1]))})
			CMov(FP,DefFactorV2[i+1],DefFactorV[i+1])
		CIfEnd()
		
		CIf(FP,{TTCVar(FP,AtkFactorV2[i+1][2],NotSame,AtkFactorV[i+1])})
			CDoActions(FP,{TSetMemoryX(AtkFactorPtrArr[i+1],SetTo,_Mul(AtkFactorV[i+1],_Mov(256^AtkFactorMaskRetArr[i+1])),255*(256^AtkFactorMaskRetArr[i+1]))})
			CMov(FP,AtkFactorV2[i+1],AtkFactorV[i+1])
		CIfEnd()
		
		TriggerX(FP,{CVar(FP,AtkFactorV[i+1][2],AtLeast,255)},{SetMemoryB(0x58D088 + (i * 46) + i,SetTo,0),
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\n\n\n\x13\x04������������������������������������������������������������������������������������������������������������\n\x13\x04��������\x03�Σϣԣɣã�\x04��������\n\x14\n\x14\n\x13\x1C���ݷ� ���׷��̵�\x04�� �������� 255�� �Ѿ����ϴ�.\n\x13\x04�������ʹ� \x1C��Ŭ�� ���׷��̵�\x04�� ���� ���׷��̵� ���ּ���.\n\n\x14\n\x13\x04��������\x03�Σϣԣɣã�\x04��������\n\x13\x04������������������������������������������������������������������������������������������������������������",4),
			PlayWAV("staredit\\wav\\button3.wav"),
			SetMemory(0x6509B0,SetTo,FP)
		})
		TriggerX(FP,{CVar(FP,DefFactorV[i+1][2],AtLeast,255)},{SetMemoryB(0x58D088 + (i * 46) + i+8,SetTo,0),
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\n\n\n\x13\x04������������������������������������������������������������������������������������������������������������\n\x13\x04��������\x03�Σϣԣɣã�\x04��������\n\x14\n\x14\n\x13\x08ü�� ���׷��̵�\x04�� �������� 255�� �Ѿ����ϴ�.\n\x13\x04�������ʹ� \x1C��Ŭ�� ���׷��̵�\x04�� ���� ���׷��̵� ���ּ���.\n\n\x14\n\x13\x04��������\x03�Σϣԣɣã�\x04��������\n\x13\x04������������������������������������������������������������������������������������������������������������",4),
			PlayWAV("staredit\\wav\\button3.wav"),
			SetMemory(0x6509B0,SetTo,FP)
		})
		
		TriggerX(FP,{CVar(FP,MarHP[i+1][2],AtLeast,160000*256)},{SetMemoryB(0x58D088 + (i * 46) + i+8,SetTo,0),SetMemoryB(0x58D088 + (i * 46) + 19,SetTo,0),SetMemoryB(0x58D088 + (i * 46) + 20,SetTo,0),
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07[ \x08ü��\x04�� 16�� �Ѿ�� \x1F%�۵�\x04 �ý��� �ڻ쳪�� ���̻� ü�� ���ؿ� �˼��մϴ�............................. \x07]",4),
			PlayWAV("staredit\\wav\\TT.ogg"),
			PlayWAV("staredit\\wav\\TT.ogg"),
			PlayWAV("staredit\\wav\\TT.ogg"),
			PlayWAV("staredit\\wav\\TT.ogg"),
			PlayWAV("staredit\\wav\\TT.ogg"),
			PlayWAV("staredit\\wav\\TT.ogg"),
			SetMemory(0x6509B0,SetTo,FP)
		})
		TriggerX(FP,{MemoryW(0x656EB0 + (MarWep[i+1]*2),AtLeast,65535-(MarDamageFactor*255))},{
			SetMemoryB(0x58D088 + (i * 46) + i,SetTo,0),
			SetMemoryB(0x58D088 + (i * 46) + 17,SetTo,0),
			SetMemoryB(0x58D088 + (i * 46) + 18,SetTo,0),
			SetMemoryW(0x656EB0 + (MarWep[i+1]*2),SetTo,65535),
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07[ \x1C���ݷ�\x04�� �ý��ۻ� �Ѱ�� ���̻� ���� ���ؿ� �˼��մϴ�............................. \x07]",4),
			PlayWAV("staredit\\wav\\TT.ogg"),
			PlayWAV("staredit\\wav\\TT.ogg"),
			PlayWAV("staredit\\wav\\TT.ogg"),
			PlayWAV("staredit\\wav\\TT.ogg"),
			PlayWAV("staredit\\wav\\TT.ogg"),
			PlayWAV("staredit\\wav\\TT.ogg"),
			SetMemory(0x6509B0,SetTo,FP)
		})
		DoActionsX(FP,{SetCDeaths(FP,Subtract,1,UpSELemit[i+1]),SetCDeaths(FP,Subtract,1,OrderCool[i+1]),SetDeaths(i,Subtract,1,15)})
		
		
		
		 -- ���۽� �� ������ ������ ����ȭ. TT������ �̿��� ���� ��ȭ�Ҷ��� ������
		
		
		
		CIf(FP,{TTCVar(FP,MarHP[i+1][2],"!=",MarHP2[i+1])})
			CMov(FP,MarHP2[i+1],MarHP[i+1])
			CMov(FP,0x662350 + (MarID[i+1]*4),MarHP2[i+1])
			CMov(FP,0x515BB0+(i*4),_Div(_ReadF(0x662350 + (MarID[i+1]*4)),_Mov(1000)))
		CIfEnd()
		CIf(FP,{Memory(0x6284E8+(0x30*i) ,AtLeast,1),Memory(0x6284E8+(0x30*i) + 4,AtMost,0),Memory(0x57F1B0, Exactly, i)})
			f_Read(FP,0x6284E8+(0x30*i),SelPTR,SelEPD)
			CDoActions(FP,{TSetMemory(SelOPEPD,Add,1)})
			f_Read(FP,_Add(SelEPD,2),SelHP)
			f_Read(FP,_Add(SelEPD,19),SelPl,"X",0xFF)
			f_Read(FP,_Add(SelEPD,25),SelUID,"X",0xFF)
			f_Read(FP,_Add(SelEPD,24),SelSh,"X",0xFFFFFF)
			CMov(FP,SelMaxHP,_Div(_ReadF(_Add(SelUID,_Mov(EPD(0x662350)))),_Mov(256)))
			CTrigger(FP,{CVar(FP,SelPl[2],Exactly,7),CVar(FP,B1_H[2],AtLeast,1)},{TSetCVar(FP,SelHP[2],Add,B1_K)},1)
			f_Div(FP,SelHP,_Mov(256))
			f_Div(FP,SelSh,_Mov(256))
			CDoActions(FP,{TSetMemory(SelHPEPD,SetTo,SelHP),TSetMemory(MarHPEPD,SetTo,SelMaxHP),TSetMemory(SelShEPD,SetTo,SelSh)})
		CIfEnd()
		
		CIf(FP,Score(i,Kills,AtLeast,1000))
			CMov(FP,ExchangeP,_Div(_ReadF(0x581F04+(i*4)),_Mov(1000)))
			CAdd(FP,{FP,ExScore[i+1][2],nil,"V"},_Div(_ReadF(0x581F04+(i*4)),_Mov(1000)))
			CMov(FP,0x581F04+(i*4),_Mod(_ReadF(0x581F04+(i*4)),_Mov(1000)))
			CAdd(FP,0x57F0F0+(i*4),_Mul(_Mul(ExchangeP,_Mov(10)),{FP,ExchangeRate[2],nil,"V"}))
			CMov(FP,ExchangeP,0)
		CIfEnd()
		DoActions(FP,SetDeaths(i,Subtract,1,111))

		CMov(FP,0x582174+(4*i),count)
		CAdd(FP,0x582174+(4*i),count)
		CMov(FP,0x57f120+(4*i),ExScore[i+1])
		Trigger2(FP,{Memory(0x57f120+(4*i),AtLeast,0x80000000)},{SetMemory(0x57f120+(4*i),SetTo,0)},{Preserved}) -- ���� ���̳ʽ� ����
		
		CIfX(FP,Memory(0x582294+(4*i),AtLeast,1001))
			CIfX(FP,Bring(FP,AtLeast,1,147,64))
			f_Div(FP,MarTempSh,MarHP[i+1],_Mov(512))
			CIfX(FP,CVar(FP,MarTempSh[2],AtMost,65535))
				CDoActions(FP,{TSetMemoryX(MarShPtrArr[i+1],SetTo,_Mul(MarTempSh,_Mov(256^MarShMaskRetArr[i+1])),65535*(256^MarShMaskRetArr[i+1]))})
			CElseX()
				DoActions(FP,{SetMemoryW(0x660E00 + (MarID[i+1]*2),SetTo,65535)})
			CIfXEnd()
			CElseX()
			DoActions(FP,{SetMemoryW(0x660E00 + (MarID[i+1]*2),SetTo,1000)})
			CIfXEnd()
			Trigger { -- ��ȣ�� ����
				players = {FP},
				conditions = {
					Label(0);
				},
				actions = {
					ModifyUnitShields(All,"Any unit",i,"Anywhere",100);
					SetMemoryX(0x664080 + (MarID[i+1]*4),SetTo,0x8000,0x8000);
					PreserveTrigger();
				},
			}

			TriggerX(FP,{CVar(FP,LevelT2[2],AtLeast,3),Bring(FP, AtMost, 0, 147, 64)},{
				ModifyUnitShields(All,"Any unit",i,"Anywhere",0);},{Preserved})
		CElseX()
			DoActions(FP,{SetMemoryW(0x660E00 + (MarID[i+1]*2),SetTo,1000)})
			TriggerX(FP,{CDeaths(FP,AtMost,0,isSingle)},{SetMemoryX(0x664080 + (MarID[i+1]*4),SetTo,0,0x8000);},{Preserved})
		CIfXEnd()
		local OrderCooltime = {}
		local OrderCooltimeRecover = {}
		table.insert(OrderCooltime,SetMemoryB(0x57F27C+(228*i)+64,SetTo,0)) -- 9, 34 Ȱ��ȭ�ϰ� ��Ȱ��ȭ�� ���� �ε���
		table.insert(OrderCooltime,SetMemoryB(0x57F27C+(228*i)+66,SetTo,0)) -- 9, 34 Ȱ��ȭ�ϰ� ��Ȱ��ȭ�� ���� �ε���
		table.insert(OrderCooltime,SetMemoryB(0x57F27C+(228*i)+70,SetTo,0)) -- 9, 34 Ȱ��ȭ�ϰ� ��Ȱ��ȭ�� ���� �ε���
		table.insert(OrderCooltimeRecover,SetMemoryB(0x57F27C+(228*i)+64,SetTo,1)) -- 9, 34 Ȱ��ȭ�ϰ� ��Ȱ��ȭ�� ���� �ε���
		table.insert(OrderCooltimeRecover,SetMemoryB(0x57F27C+(228*i)+66,SetTo,1)) -- 9, 34 Ȱ��ȭ�ϰ� ��Ȱ��ȭ�� ���� �ε���
		table.insert(OrderCooltimeRecover,SetMemoryB(0x57F27C+(228*i)+70,SetTo,1)) -- 9, 34 Ȱ��ȭ�ϰ� ��Ȱ��ȭ�� ���� �ε���
		TriggerX(FP,{CVar(FP,Level[2],AtLeast,11),CDeaths(FP,AtLeast,1,OrderCool[i+1])},{OrderCooltime},{Preserved})
		TriggerX(FP,{CVar(FP,Level[2],AtLeast,11),CDeaths(FP,Exactly,0,OrderCool[i+1])},{OrderCooltimeRecover},{Preserved})

		CElseX()
			DoActions(FP,{SetDeaths(i,SetTo,0,440)}) -- ���÷��̾ �������� ���� ��� ���÷��̾��� ���Ÿ�̸� 0���� ���� 
			TriggerX(FP,{Deaths(i,AtLeast,1,227)},{SetDeaths(i,SetTo,0,227),SetCDeaths(FP,Add,100,PExitFlag)}) -- ������ ��� 1ȸ�� ���� �α��� ���� �۵�
		CIfXEnd()
	end
	local TempPos = CreateVar(FP)
	CIf(FP,CDeaths(FP,AtLeast,1,CUnitFlag)) -- ���ݽ��� �� ��ɵ�
		for i = 0, 6 do
			GetLocCenter(73+i,CPosX,CPosY)
			CMov(FP,MulCon[i+1],_Add(CPosX,_Mul(CPosY,_Mov(0x10000))))
		end
		CMov(FP,0x6509B0,19025+19)
		CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
			CIf(FP,{DeathsX(CurrentPlayer,AtMost,6,0,0xFF),DeathsX(CurrentPlayer,AtLeast,256,0,0xFF00)})
			f_SaveCp()
			for i = 0, 6 do
			CIf(FP,{DeathsX(CurrentPlayer,Exactly,i,0,0xFF)})
			Trigger {
				players = {FP},
				conditions = {
					Deaths(i,AtLeast,1,71);
				},
				actions = {
					MoveCp(Add,50*4);
					SetDeathsX(CurrentPlayer,SetTo,255*256,0,0xFF00);
					MoveCp(Subtract,50*4);
					PreserveTrigger();
				}
			}
			f_SaveCp()
			local ValCancle = def_sIndex()
			NJump(FP,ValCancle,{TMemory(_Add(BackupCP,6),Exactly,58)})
			CTrigger(FP,{Deaths(i,AtLeast,1,65)}, -- Stop
			{TSetDeathsX(BackupCP,SetTo,1*256,0,0xFF00)},{Preserved})
			CIf(FP,{Deaths(i,AtLeast,1,67)}) -- Hold
				f_Read(FP,_Sub(BackupCP,9),TempPos)
				CDoActions(FP,{TSetDeaths(_Add(BackupCP,4),SetTo,0,0),TSetDeathsX(BackupCP,SetTo,107*256,0,0xFF00),TSetDeaths(_Sub(BackupCP,13),SetTo,TempPos,0),TSetDeaths(_Add(BackupCP,3),SetTo,TempPos,0),TSetDeaths(_Sub(BackupCP,15),SetTo,TempPos,0)})
			CIfEnd()
			CIf(FP,{Deaths(i,AtLeast,1,64)}) -- Move
				CDoActions(FP,{TSetDeaths(_Add(BackupCP,4),SetTo,0,0),TSetDeathsX(BackupCP,SetTo,6*256,0,0xFF00),TSetDeaths(_Sub(BackupCP,13),SetTo,MulCon[i+1],0),TSetDeaths(_Add(BackupCP,3),SetTo,MulCon[i+1],0),TSetDeaths(_Sub(BackupCP,15),SetTo,MulCon[i+1],0)})
			CIfEnd()
			CIf(FP,{Deaths(i,AtLeast,1,66)}) -- Attack
				CDoActions(FP,{TSetDeaths(_Add(BackupCP,4),SetTo,0,0),TSetDeathsX(BackupCP,SetTo,14*256,0,0xFF00),TSetDeaths(_Sub(BackupCP,13),SetTo,MulCon[i+1],0),TSetDeaths(_Add(BackupCP,3),SetTo,MulCon[i+1],0),TSetDeaths(_Sub(BackupCP,15),SetTo,MulCon[i+1],0)})
			CIfEnd()
			CIf(FP,{Deaths(i,AtLeast,1,70)}) -- JYD
				f_Read(FP,_Sub(BackupCP,9),TempPos)
				CDoActions(FP,{TSetDeaths(_Add(BackupCP,4),SetTo,0,0),TSetDeathsX(BackupCP,SetTo,187*256,0,0xFF00),TSetDeaths(_Sub(BackupCP,13),SetTo,TempPos,0),TSetDeaths(_Add(BackupCP,3),SetTo,TempPos,0),TSetDeaths(_Sub(BackupCP,15),SetTo,TempPos,0)})
			CIfEnd()
			NJumpEnd(FP,ValCancle)
			f_LoadCp()
			CIfEnd()
			end
			CIfEnd()
			CAdd(FP,0x6509B0,84)
		CWhileEnd()
		CMov(FP,0x6509B0,FP)
		DoActionsX(FP,{SetDeaths(Force1,SetTo,0,71),SetDeaths(Force1,SetTo,0,64),SetDeaths(Force1,SetTo,0,65),SetDeaths(Force1,SetTo,0,66),SetDeaths(Force1,SetTo,0,67),SetDeaths(Force1,SetTo,0,70),SetCDeaths(FP,SetTo,0,CUnitFlag)})
	CIfEnd()
	local HealT = CreateCCode()
	DoActionsX(FP,{SetCDeaths(FP,Add,1,HealT)})
	CIf(FP,CDeaths(FP,AtLeast,50,HealT),SetCDeaths(FP,SetTo,0,HealT))
	for i = 0, 6 do
		Trigger2(FP,{PlayerCheck(i,1)},{ModifyUnitHitPoints(All,"Men",Force1,i+2,100),ModifyUnitHitPoints(All,"Buildings",Force1,i+2,100),ModifyUnitShields(All,"Men",Force1,i+2,100),ModifyUnitShields(All,"Buildings",Force1,i+2,100)},{Preserved})
	end
	CIfEnd()
--	Trigger2(FP,{Bring(FP,AtMost,0,147,64)},{ModifyUnitShields(All,"Men",Force1,64,0)},{Preserved})
	CIf(FP,{CDeaths(FP,Exactly,0,isSingle),CVar(FP,InputPoint[2],AtLeast,1000)})
	CAdd(FP,OutputPoint,_Div(InputPoint,_Mov(1000)))
	f_Mod(FP,InputPoint,_Mov(1000))
	CIfEnd()
    CallTriggerX(FP,Call_ScorePrint,{CDeaths(FP,AtLeast,1,ScorePrint)},{SetCDeaths(FP,SetTo,0,ScorePrint),SetCDeaths(FP,SetTo,0,isDBossClear)})
end