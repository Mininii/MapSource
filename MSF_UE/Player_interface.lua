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
	

	--스탯
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
	InsertKey[1] = "\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04이 맵은 클리어의 개념이 없으며 \n\x13\x08게임 오버 \x04시 \x1F달성한 단계\x04와 \x07스코어(가스)\x04가 게임의 성과를 나타냅니다.\n\x13\x04당신의 한계를 시험해 보세요!\n\x13\x07이론적으로 제한 없는 단계와 업그레이드\x04를 제공합니다.\n\x13\x04255 업그레이드 완료 시 \x1F0으로 리셋 후 마린 공격력이 그대로 전승됩니다.\n\x13\x04Normal Marine + \x1F25000 Ore \x04= \x1FExCeed Marine\n\x13\x04조합소는 중앙 수정 광산이 있는곳으로 가시면 됩니다.\n\x13\x04PgUp, PgDn 키로 설명서 페이지를 바꿀 수 있습니다.\n\x13\x04――――――――――――――――――――――――― Page 1/3 ―――――――――――――――――――――――――\n\x13\x17ＣＬＯＳＥ　：　ＤＥＬＥＴＥ　ＫＥＹ"
	InsertKey[2] = "\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04\x1CS C Archive \x04설명\n\x13\x04현재 저장이 지원되는 항목은 \x11최고기록(Level, Score)\x04과 \x19스탯 포인트 \x04입니다.\n\x13\x04그외 \x1F미네랄\x04, \x17업그레이드 수치\x04, \x1B마린 수 \x04등은 \x08저장이 불가능합니다.\n\x13\x04스탯 포인트로 다양한 이로운 효과를 얻을 수 있습니다.\n\x13\x07단, \x0F32Bit 환경 \x04스타크래프트에서만 이용하실 수 있으며\n\x13\x07 데이터 로드는 \x1D1 Level \x04스테이지에서만 가능합니다.\n\x13\x04데이터를 불러오지 못했다면 게임 재시작을 권장드립니다.\n\x13\x07데이터 저장\x04은 매 스테이지 클리어마다 \x07자동저장됩니다. \x04또는 \x18수동저장 \x04가능합니다.\n\x13\x04――――――――――――――――――――――――― Page 2/3 ―――――――――――――――――――――――――\n\x13\x17ＣＬＯＳＥ　：　ＤＥＬＥＴＥ　ＫＥＹ"
	InsertKey[3] = "\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04스탯포인트 증가량 공식은 시작난이도에 따라 달라집니다.\n\x13\x04\x0EＥａｓｙ\x04 = 증가량X \x0FＮｏｒｍａｌ\x04 = +3\n\x13\x04\x08Ｈａｒｄ\x04 = +6 \x10Ｉｎｓａｎｅ\x04 = +9\n\x13\x04위의 값에서 클리어한 스테이지의 수치가 합산되어 더해집니다.\n\x13\x04\n\x13\x04Ex) 8스테이지 클리어 + \x08Ｈａｒｄ\x04난이도 = 8 + 6 = +14 증가\n\x13\x04\n\x13\x04즉, 높은 난이도에서 시작할 수록 더 많은 스탯포인트를 얻을 수 있습니다.\n\x13\x04――――――――――――――――――――――――― Page 3/3 ―――――――――――――――――――――――――\n\x13\x17ＣＬＯＳＥ　：　ＤＥＬＥＴＥ　ＫＥＹ"
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
	CElseX(SetCDeaths(FP,SetTo,0,DeleteToggle)) -- 현재스탯 등 출력
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
		CIf(FP,{LocalPlayerID(i)},{SetMemory(0x6509B0,SetTo,FP)}) -- 스테이터스 전송
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


		CMov(FP,0x6509B0,LocalPV)--CP 로컬로 전환

		
		
		DoActions(FP,{DisplayText(string.rep("\n", 20),4),
		DisplayText("\x0D\x0D\x0DHiSc".._0D,4),
		DisplayText("\x0D\x0D\x0DUStat".._0D,4),
		DisplayText("\n\n\x13\x07『 \x1F100만 미네랄 \x04구입(Q) \x1F(Cost:4) \x07』",4), -- 미네랄 구입
		DisplayText("\x0D\x0D\x0DNuke".._0D,4),
		DisplayText("\x0D\x0D\x0DSupp".._0D,4),
	})
	TriggerX(FP,{CDeaths(FP,Exactly,0,LocalCcode_Stim)},{DisplayText("\n\n\x13\x07『 \x13\x1B원격 스팀팩 \x04구입(R) \x1F(Cost:20) \x07』",4)},{Preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,1,LocalCcode_Stim)},{DisplayText("\n\n\x13\x07『 \x13\x1B원격 스팀팩 \x04구입(R) \x1F(Cost:20) \x03구입 완료! \x07』",4)},{Preserved})
	TriggerX(FP,{CDeaths(FP,Exactly,0,LocalCcode_Multi)},{DisplayText("\n\n\x13\x07『 \x13\x1D멀티 \x1B커맨드 \x04구입(T) \x1F(Cost:20) \x07』",4)},{Preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,1,LocalCcode_Multi)},{DisplayText("\n\n\x13\x07『 \x13\x1D멀티 \x1B커맨드 \x04구입(T) \x1F(Cost:20) \x03구입 완료! \x07』",4)},{Preserved})
	TriggerX(FP,{CDeaths(FP,Exactly,0,TeamEnchant)},{DisplayText("\n\n\x13\x07『 \x13\x04Normal Marine \x1B강화 \x04구입(Y) \x1F(Cost:30) \x07』",4)},{Preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,1,TeamEnchant)},{DisplayText("\n\n\x13\x07『 \x13\x04Normal Marine \x1B강화 \x04구입(Y) \x1F(Cost:30) \x03구입 완료! \x07』",4)},{Preserved})

		Trigger2X(FP,{MemoryX(0x596A38, Exactly, 0x00000100,0x100),CDeaths(FP,Exactly,0,KeyToggle)},{SetCDeaths(FP,SetTo,1,KeyToggle),PlayWAV("sound\\Misc\\Buzz.wav"),
			PlayWAV("sound\\Misc\\Buzz.wav"),
			print_utf8(12,0,"\x07『 \x1F기부 ON \x04상태에서는 사용할 수 없는 기능입니다. \x03ESC\x04를 눌러 기능을 OFF해주세요. \x07』"),SetDeaths(CurrentPlayer,SetTo,150,15);},{Preserved})
		Trigger2X(FP,{MemoryX(0x596A38, Exactly, 0x00010000,0x10000),CDeaths(FP,Exactly,0,KeyToggle)},{SetCDeaths(FP,SetTo,1,KeyToggle),PlayWAV("sound\\Misc\\Buzz.wav"),
			PlayWAV("sound\\Misc\\Buzz.wav"),
			print_utf8(12,0,"\x07『 \x1F기부 ON \x04상태에서는 사용할 수 없는 기능입니다. \x03ESC\x04를 눌러 기능을 OFF해주세요. \x07』"),SetDeaths(CurrentPlayer,SetTo,150,15);},{Preserved})
		Trigger2X(FP,{Memory(0x596A44, Exactly, 0x00000100),CDeaths(FP,Exactly,0,KeyToggle)},{SetCDeaths(FP,SetTo,1,KeyToggle),PlayWAV("sound\\Misc\\Buzz.wav"),
			PlayWAV("sound\\Misc\\Buzz.wav"),
			print_utf8(12,0,"\x07『 \x1F기부 ON \x04상태에서는 사용할 수 없는 기능입니다. \x03ESC\x04를 눌러 기능을 OFF해주세요. \x07』"),SetDeaths(CurrentPlayer,SetTo,150,15);},{Preserved})

	CIfXEnd()
	Trigger2X(FP,{Memory(0x596A38, Exactly, 0),Memory(0x596A44, Exactly, 0),CDeaths(FP,Exactly,1,KeyToggle)},{SetCDeaths(FP,SetTo,0,KeyToggle)},{Preserved})
	
	Trigger2X(FP,{Memory(0x596A44, Exactly, 65536)},{SetCDeaths(FP,SetTo,0,DeleteToggle),DisplayText(string.rep("\n", 20),4)},{Preserved})

	DoActions(FP,SetMemory(0x6509B0,SetTo,FP)) -- CP 복구 


	for i = 0, 6 do -- 각플레이어
		if i ~= 0 then --강퇴트리거는 1플레이어 제외
		Trigger { -- 강퇴
			players = {i},
			conditions = {
				Label(0);
				CDeaths(FP,AtLeast,5,BanToken[i+1]);
			},
			actions = {
				RotatePlayer({DisplayTextX("\x07『 \x04"..PlayerString[i+1].."\x04의 강퇴처리가 완료되었습니다.\x07 』",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i);
				},
			}
			Trigger { -- 강퇴 드랍
				players = {i},
				conditions = {
					Label(0);
					CDeaths(FP,AtLeast,5,BanToken[i+1]);Memory(0x57F1B0, Exactly, i)
					
				},
				actions = {
					PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
					PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
					PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					SetMemory(0xCDDDCDDC,SetTo,1);
					
					},
				}
		end
		
		Trigger { -- 미네랄 마이너스 방지
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
			Trigger { -- 버튼 기능
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
				DisplayText("\x13\x04"..string.rep("―", 56),4);
				DisplayText("\x13\x0FＳＫＩＬＬ　ＵＮＬＯＣＫＥＤ",0);
				DisplayText("\n",4);
				DisplayText("\x13\x1B원격 스팀팩 \x04을 구입하셨습니다.\n\x13\x04이제부터 \x1B원격 스팀팩\x04을 사용할 수 있습니다.",0);
				DisplayText("\n",4);
				DisplayText("\x13\x0FＳＫＩＬＬ　ＵＮＬＯＣＫＥＤ",0);
				DisplayText("\x13\x04"..string.rep("―", 56),4);
				SetMemoryB(0x57F27C+(228*i)+71,SetTo,1);
				PlayWAV("staredit\\wav\\Unlock.ogg");
				PlayWAV("staredit\\wav\\Unlock.ogg");
				PlayWAV("staredit\\wav\\Unlock.ogg");
		})
		
		Trigger { -- 스팀팩
			players = {i},
			conditions = {
				Label(0);
				Bring(i,AtLeast,1,71,64);
			},
			actions = {
				SetDeaths(i,Add,1,71);
				RemoveUnitAt(1,71,"Anywhere",i);
				DisplayText("\x07『 \x04원격 \x1B스팀팩\x04기능을 사용합니다.\x07 』",4);
				SetCDeaths(FP,Add,1,CUnitFlag);
				PreserveTrigger();
			},
		}
		
		CIf(i,Bring(i,AtLeast,1,19,64))
		Trigger { -- 보호막 가동
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
				DisplayText("\x07『 \x04현재 \x1C수정 보호막\x04이 쿨타임중입니다. 자원 반환 + \x1F65000 Ore\x07』",4);
				PlayWAV("sound\\Misc\\PError.WAV");
				PlayWAV("sound\\Misc\\PError.WAV");
				PreserveTrigger();
			},
		}
		Trigger { -- 보호막 가동
			players = {i},
			conditions = {
				Label(0);
				Memory(0x582294+(4*i),AtLeast,1001);
				Bring(i,AtLeast,1,19,64);
			},
			actions = {
				SetResources(i,Add,65000,Ore);
				RemoveUnitAt(1,19,"Anywhere",i);
				DisplayText("\x07『 \x04이미 \x1C수정 보호막\x04을 사용중입니다. 자원 반환 + \x1F65000 Ore\x07』",4);
				PlayWAV("sound\\Misc\\PError.WAV");
				PlayWAV("sound\\Misc\\PError.WAV");
				PreserveTrigger();
			},
		}
		
		Trigger { -- 보호막 가동
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
		Trigger { -- 보호막 가동
			players = {i},
			conditions = {
				Label(0);
				Memory(0x582294+(4*i),Exactly,1000);
			},
			actions = {
				DisplayText("\x07『 \x1C수정 보호막\x04 사용이 종료되었습니다. \x07』",4);
				PlayWAV("staredit\\wav\\GMode.ogg");
				PlayWAV("staredit\\wav\\GMode.ogg");
				PreserveTrigger();
			},
		}
		Trigger { -- 보호막 가동
			players = {i},
			conditions = {
				Label(0);
				CDeaths(FP,AtLeast,1,ShUsed[i+1]);
				Memory(0x582294+(4*i),Exactly,0);
			},
			actions = {
				DisplayText("\x07『 \x1C수정 보호막\x04 쿨타임이 종료되었습니다. \x07』",4);
				PlayWAV("staredit\\wav\\GMode.ogg");
				PlayWAV("staredit\\wav\\GMode.ogg");
				SetCDeaths(FP,SetTo,0,ShUsed[i+1]);
				PreserveTrigger();
			},
		}
		for j = 1, 5 do
		Trigger { -- 보호막 사용
			players = {i},
			conditions = {
				Label(0);
				Memory(0x582294+(4*i),Exactly,50*j+(1000));
			},
			actions = {
				DisplayText("\x07『 \x1C수정 보호막\x04이 "..j.."초 남았습니다. \x07』",4);
				PlayWAV("staredit\\wav\\sel_m.ogg");
				PlayWAV("staredit\\wav\\sel_m.ogg");
				PreserveTrigger();
			},
		}
		end
		for j = 1, 5 do
		Trigger { -- 보호막 쿨타임
			players = {i},
			conditions = {
				Label(0);
				Memory(0x582294+(4*i),Exactly,50*j);
			},
			actions = {
				DisplayText("\x07『 \x1C수정 보호막\x04 쿨타임이 "..j.."초 남았습니다. \x07』",4);
				PlayWAV("staredit\\wav\\sel_m.ogg");
				PlayWAV("staredit\\wav\\sel_m.ogg");
				PreserveTrigger();
			},
		}
		end
		
		
		
		Trigger2(i,{Memory(0x582294+(4*i),AtLeast,1)},{SetMemory(0x582294+(4*i),Subtract,1)},{Preserved})
		
		CIf(FP,{Deaths(i,AtLeast,1,CPConsole)},{SetMemory(0x6509B0,SetTo,i)}) -- 스탯창 인터페이스 Deaths 190~199
			TriggerX(FP,{Deaths(i,AtMost,0,15),Memory(0x57F1B0,Exactly,i)},{SetCDeaths(FP,SetTo,0,DeleteToggle),
				print_utf8(12,0,"\x07[ \x1F기부, \x19스탯창\04이 켜져있습니다. ESC : 닫기\x07 ]")
			},{Preserved}) -- 13번줄 프린트 트리거 플레이어가 FP인 이유는 트리거 순서가 1P부터 8P까지 실행되기 때문. i로 하게될 경우 이게 씹히고 위에있는 CText가 보이게 된다. 
			--구입 성공시 사운드 PlayWAV("staredit\\wav\\BuySE.ogg");
			--구입 실패시 사운드 PlayWAV("staredit\\wav\\FailSE.ogg");
		
			KeyInput(190--[[Q]],{CVar(FP,AvailableStat[i+1][2],AtLeast,1)},{SetCVar(FP,AvailableStat[i+1][2],Subtract,1),SetResources(i,Add,1000000,Ore),print_utf8(12,0,"\x07[ \x07구입 성공, \x04미네랄이 \x1F1,000,000 \x04증가하였습니다. \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --미네랄
			KeyInput(191--[[W]],{CVar(FP,AvailableStat[i+1][2],AtLeast,1)},{SetCVar(FP,AvailableStat[i+1][2],Subtract,1),SetCVar(FP,Nukes[i+1][2],Add,1),print_utf8(12,0,"\x07[ \x07구입 성공, \x08뉴클리어\x04가 장전되었습니다. \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --핵
			KeyInput(190--[[Q]],{CVar(FP,AvailableStat[i+1][2],AtMost,0)},{print_utf8(12,0,"\x07[ \x08포인트가 부족합니다 \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --미네랄
			KeyInput(191--[[W]],{CVar(FP,AvailableStat[i+1][2],AtMost,0)},{print_utf8(12,0,"\x07[ \x08포인트가 부족합니다 \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --핵
			CIf(FP,{Deaths(CurrentPlayer,AtLeast,1,192)})
				CIfX(FP,{CVar(FP,AvailableStat[i+1][2],AtLeast,1)},{SetCVar(FP,AvailableStat[i+1][2],Subtract,1),SetCVar(FP,Supply[i+1][2],Add,6),print_utf8(12,0,"\x07[ \x07구입 성공, \x04인구수가 \x073 \x04증가하였습니다. \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");})
				CElseX()
					CTrigger(FP,{TCVar(FP,Supply[i+1][2],AtLeast,_Sub(SuppMax,_Mov(1)))},{print_utf8(12,0,"\x07[ \x08구입 실패, \x04맵 최대 인구수가 꽉 찼습니다. \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1)
					TriggerX(FP,{CVar(FP,AvailableStat[i+1][2],AtMost,0)},{print_utf8(12,0,"\x07[ \x08포인트가 부족합니다 \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},{Preserved})
				CIfXEnd()
			CIfEnd()
			KeyInput(193--[[R]],{CDeaths(FP,AtLeast,1,MultiStimPack[i+1])},{print_utf8(12,0,"\x07[ \x08이미 구입되었습니다. \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --멀티커맨
			KeyInput(194--[[T]],{CDeaths(FP,AtLeast,1,MultiCommand[i+1])},{print_utf8(12,0,"\x07[ \x08이미 구입되었습니다. \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --원격스팀
			KeyInput(195--[[Y]],{CDeaths(FP,AtLeast,1,TeamEnchant)},{print_utf8(12,0,"\x07[ \x08이미 구입되었습니다. \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --일마강화

			KeyInput(193--[[R]],{CVar(FP,AvailableStat[i+1][2],AtLeast,20),CDeaths(FP,AtMost,0,MultiStimPack[i+1])},{SetCDeaths(FP,SetTo,1,MultiStimPack[i+1]),print_utf8(12,0,"\x07[ \x07구입 성공, \x1B원격 스팀팩 \x04기능을 사용할 수 있습니다. \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --멀티커맨
			KeyInput(194--[[T]],{CVar(FP,AvailableStat[i+1][2],AtLeast,20),CDeaths(FP,AtMost,0,MultiCommand[i+1])},{SetCDeaths(FP,SetTo,1,MultiCommand[i+1]),print_utf8(12,0,"\x07[ \x07구입 성공, \x1D멀티 \x1B커맨드 \x04기능을 사용할 수 있습니다. \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --원격스팀
			KeyInput(195--[[Y]],{CVar(FP,AvailableStat[i+1][2],AtLeast,30),CDeaths(FP,AtMost,0,TeamEnchant)},{SetCDeaths(FP,SetTo,1,TeamEnchant),print_utf8(12,0,"\x07[ \x07구입 성공, \x04팀원의\x04Normal Marine\x04이 \x1B강화 \x04되었습니다. \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --일마강화

			KeyInput(193--[[R]],{CVar(FP,AvailableStat[i+1][2],AtLeast,19),CDeaths(FP,AtMost,0,MultiStimPack[i+1])},{print_utf8(12,0,"\x07[ \x08포인트가 부족합니다 \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --멀티커맨
			KeyInput(194--[[T]],{CVar(FP,AvailableStat[i+1][2],AtLeast,19),CDeaths(FP,AtMost,0,MultiCommand[i+1])},{print_utf8(12,0,"\x07[ \x08포인트가 부족합니다 \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --원격스팀
			KeyInput(195--[[Y]],{CVar(FP,AvailableStat[i+1][2],AtLeast,29),CDeaths(FP,AtMost,0,TeamEnchant)},{print_utf8(12,0,"\x07[ \x08포인트가 부족합니다 \x07]"),SetDeaths(CurrentPlayer,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --일마강화
			
			
		CifEnd()
		TriggerX(i,{Deaths(CurrentPlayer,Exactly,0,OPConsole),Deaths(CurrentPlayer,AtLeast,1,F9),Deaths(CurrentPlayer,Exactly,0,B),Deaths(CurrentPlayer,Exactly,0,CPConsole)},{SetDeaths(CurrentPlayer,SetTo,1,CPConsole),SetDeaths(CurrentPlayer,SetTo,0,F9)},{Preserved})
		TriggerX(i,{Deaths(CurrentPlayer,Exactly,0,OPConsole),Deaths(CurrentPlayer,AtLeast,1,F9),Deaths(CurrentPlayer,Exactly,0,B),Deaths(CurrentPlayer,Exactly,1,CPConsole)},{SetDeaths(CurrentPlayer,SetTo,0,CPConsole),SetDeaths(CurrentPlayer,SetTo,0,F9)},{Preserved})
		--CPConsole
		CIfX(i,{Deaths(CurrentPlayer,AtLeast,1,CPConsole)},SetCDeaths(FP,Add,1,FuncT[i+1]))
		TriggerX(i,{CDeaths(FP,AtLeast,30*24,FuncT[i+1])},{SetDeaths(CurrentPlayer,SetTo,0,CPConsole),SetCDeaths(FP,SetTo,0,FuncT[i+1])},{Preserved})
		
		GiveRateT = {"\x07『 \x04기부금액 단위가 \x1F5000 Ore\x04 \x04로 변경되었습니다.\x07 』",
		"\x07『 \x04기부금액 단위가 \x1F10000 Ore \x04로 변경되었습니다.\x07 』",
		"\x07『 \x04기부금액 단위가 \x1F50000 Ore \x04로 변경되었습니다.\x07 』",
		"\x07『 \x04기부금액 단위가 \x1F100000 Ore \x04로 변경되었습니다.\x07 』",
		"\x07『 \x04기부금액 단위가 \x1F500000 Ore \x04로 변경되었습니다.\x07 』",
		"\x07『 \x04기부금액 단위가 \x1F1000 Ore \x04로 변경되었습니다.\x07 』"}
		for k = 0, 5 do
		Trigger { -- 기부 금액 변경
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
				Trigger { -- 돈 기부 시스템
					players = {i},
					conditions = {
						Deaths(i,AtLeast,1,j+212);
					},
					actions = {
						SetDeaths(i,SetTo,0,j+212);
						DisplayText("\x07『 "..PlayerString[j+1].."\x04은(는) 자기 자신입니다. 자기 자신에게는 기부할 수 없습니다. \x07』",4);
						SetCDeaths(FP,SetTo,0,FuncT[i+1]);
						PreserveTrigger();
					},
				}
			else
				for k=0, 5 do
					Trigger { -- 돈 기부 시스템
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
							DisplayText("\x07『 \x04잔액이 부족합니다. \x07』",4);
							SetCDeaths(FP,SetTo,0,FuncT[i+1]);
							PreserveTrigger();
						},
					}
					Trigger { -- 돈 기부 시스템
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
							DisplayText("\x07『 "..PlayerString[j+1].."\x04에게 \x1F"..GiveRate2[k+1].." Ore\x04를 기부하였습니다. \x07』",4);
							SetMemory(0x6509B0,SetTo,j);
							DisplayText("\x12\x07『"..PlayerString[i+1].."\x04에게 \x1F"..GiveRate2[k+1].." Ore\x04를 기부받았습니다.\x02 \x07』",4);
							SetMemory(0x6509B0,SetTo,i);
							SetCDeaths(FP,SetTo,0,FuncT[i+1]);
							PreserveTrigger();
						},
					}
				end
				Trigger { -- 돈 기부 시스템
					players = {i},
					conditions = {
						Label(0);
						Deaths(i,AtLeast,1,j+212);
						PlayerCheck(j,0);
					},
					actions = {
						SetDeaths(i,SetTo,0,j+212);
						DisplayText("\x07『 "..PlayerString[j+1].."\x04이(가) 존재하지 않습니다. \x07』",4);
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
				DisplayText("\x07『 \x1CBGM\x04을 듣지 않습니다. \x07』",4);
				SetDeathsX(i,SetTo,1*16777216,440,0xFF000000);
			},{Preserved})

			Trigger2(i,{DeathsX(i,Exactly,1*16777216,440,0xFF000000);Command(i,AtLeast,1,22);},{
				GiveUnits(All,22,i,"Anywhere",P12);
				RemoveUnitAt(All,22,"Anywhere",P12);
				DisplayText("\x07『 \x1CBGM\x04을 듣습니다. \x07』",4);
				SetDeathsX(i,SetTo,0*16777216,440,0xFF000000);
			},{Preserved})

			TriggerX(i,{Command(i,AtLeast,1,70);},{
				GiveUnits(All,70,i,"Anywhere",P12);
				RemoveUnitAt(All,70,"Anywhere",P12);
				DisplayText("\x07『 \x1C모든 유닛\x04에 \x1D자율공격명령 \x04을 내립니다. (\x0FJunk Yard Dog\x04) \x07』",4);
				SetDeaths(i,SetTo,1,70);
				SetCDeaths(FP,Add,1,CUnitFlag);
				SetCDeaths(FP,Add,100,OrderCool[i+1]);
			},{Preserved})
			

		UnitLimit(i,7,50,"SCV는",500)
		UnitLimit(i,125,8,"벙커는",8000)
		UnitLimit(i,124,15,"터렛은",4000)
		




		CIfX(FP,PlayerCheck(i,1)) -- FP가 관리하는 시스템 부분 트리거. 각플레이어가 있을경우 실행된다.
		--SCA 데이터 변동시 갱신
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
				DisplayText("\x07『 \x1F광물\x04을 소모하여 \x1FExceeD \x1BM\x04arine 을 \x19소환\x04하였습니다. - \x1F30,000 O r e \x07』",4),
				SetMemory(0x6509B0,SetTo,FP),
				RemoveUnitAt(1,12,"Anywhere",i),
				SetCDeaths(FP,Add,1,MarCreate[i+1]),
				SetMemory(0x582324+(12*12)+(i*4),SetTo,0),
				SetMemory(0x584DE4+(12*12)+(i*4),SetTo,0),
			},{Preserved})
		CIfEnd()
		
		  Trigger { -- 조합 조건 안됨
			players = {i},
			conditions = {
				Deaths(i,AtMost,35,126);
				Bring(i,AtLeast,1,12,64);
			},
			actions = {
				SetResources(i,Add,30000,ore);
				RemoveUnitAt(1,12,"Anywhere",i);
				DisplayText("\x07『 \x1FExceeD \x1BM\x04arine \x19빠른 소환\x04 조건이 맞지 않습니다. (조건 - \x1FExceeD \x1BM\x04arine \x0436기 조합) 자원 반환 + \x1F30,000 O r e \x07』",4);
				PreserveTrigger();
			},
		}
		
		Trigger { -- 조합 영웅마린
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
				DisplayText("\x07『 \x1F광물\x04을 소모하여 \x04Norma Marine을 \x1FExceeD \x1BM\x04arine으로 \x19변환\x04하였습니다. - \x1F25,000 O r e \x07』",4);
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
			DisplayText("\x07『 \x1F광물\x04을 소모하여 Normal Marine 을 \x19소환\x04하였습니다. - \x1F5,000 O r e \x07』",4),
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
		
		
		NIf(FP,MemoryB(0x58D2B0+(46*i)+18,AtLeast,1)) -- 공업 255회
			CDoActions(FP,{
				SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(AtkUpgradePtrArr[i+1])),
				SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^AtkUpgradeMaskRetArr[i+1]),
				TSetCVar(FP,UpgradeFactor[2],SetTo,AtkFactorV[i+1]),
				SetCVar(FP,UpgradeCP[2],SetTo,i),
				SetCVar(FP,UpgradeMax[2],SetTo,255),
				SetMemoryB(0x58D2B0+(46*i)+18,SetTo,0)})
			CallTrigger(FP,OneClickUpgrade)
		NIfEnd()
		NIf(FP,MemoryB(0x58D2B0+(46*i)+17,AtLeast,1)) -- 공업 10회
			CDoActions(FP,{
				SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(AtkUpgradePtrArr[i+1])),
				SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^AtkUpgradeMaskRetArr[i+1]),
				TSetCVar(FP,UpgradeFactor[2],SetTo,AtkFactorV[i+1]),
				SetCVar(FP,UpgradeCP[2],SetTo,i),
				SetCVar(FP,UpgradeMax[2],SetTo,10),
				SetMemoryB(0x58D2B0+(46*i)+17,SetTo,0)})
			CallTrigger(FP,OneClickUpgrade)
		NIfEnd()
		NIf(FP,MemoryB(0x58D2B0+(46*i)+19,AtLeast,1)) -- 체업 255회
			CDoActions(FP,{
				SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(DefUpgradePtrArr[i+1])),
				SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^DefUpgradeMaskRetArr[i+1]),
				TSetCVar(FP,UpgradeFactor[2],SetTo,DefFactorV[i+1]),
				SetCVar(FP,UpgradeCP[2],SetTo,i),
				SetCVar(FP,UpgradeMax[2],SetTo,255),
				SetMemoryB(0x58D2B0+(46*i)+19,SetTo,0)})
			CallTrigger(FP,OneClickUpgrade)
		NIfEnd()
		NIf(FP,MemoryB(0x58D2B0+(46*i)+20,AtLeast,1)) -- 체업 10회
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
			DisplayText("\x13\x04！！！　\x1C공격력 업그레이드\x04가 255를 넘어 한계를 돌파합니다.\x04　！！！\n\x13\x04！！！　\x07업그레이드를 \x040으로 재설정하고 \x17공격력 수치가 전승\x04되었습니다.\x04　！！！",4),
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
			DisplayText("\x13\x04！！！　\x08체력 업그레이드\x04가 255를 넘어 한계를 돌파합니다.\x04　！！！\n\x13\x04！！！　\x07업그레이드를 \x040으로 재설정하고 \x17체력 수치가 전승\x04되었습니다.\x04　！！！",4),
			SetMemory(0x6509B0,SetTo,FP),
			--SetCVar(FP,DefFactorV[i+1][2],Add,1),
			SetCVar(FP,MarMaxHP[i+1][2],Add,2000*256),
			SetCVar(FP,DefUpCompCount[i+1][2],Add,1),
		})
		TriggerX(FP,{CDeaths(FP,AtMost,0,UpSELemit[i+1])},{SetMemory(0x6509B0,SetTo,i),PlayWAV("staredit\\wav\\LimitBreak.ogg"),PlayWAV("staredit\\wav\\LimitBreak.ogg"),PlayWAV("staredit\\wav\\LimitBreak.ogg"),PlayWAV("staredit\\wav\\LimitBreak.ogg"),SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,Add,100,UpSELemit[i+1])},{Preserved})
		TriggerX(FP,{CVar(FP,DefUpCompCount[i+1][2],AtLeast,51)},{SetCVar(FP,DefFactorV[i+1][2],Add,1)},{Preserved})
		CIfEnd()

		DoActionsX(FP,{SetCVar(FP,CurrentHP[i+1][2],SetTo,0)})-- 체력값 초기화
		for Bit = 0, 7 do
		TriggerX(FP,{MemoryX(DefUpgradePtrArr[i+1],AtLeast,(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]),(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]))},
			{SetCVar(FP,CurrentHP[i+1][2],Add,2008*(2^Bit))},{Preserved})
		end
		CMov(FP,MarHP[i+1],_Add(CurrentHP[i+1],MarMaxHP[i+1]))
		
		CIfX(FP,CVar(FP,AtkUpCompCount[i+1][2],AtMost,0)) -- 업그레이드 컴플리트 카운트(255업 찍은 횟수)가 0일 경우.
			DoActions(FP,{SetMemoryX(NormalUpgradePtrArr[i+1],SetTo,0*(256^NormalUpgradeMaskRetArr[i+1]),255*(256^NormalUpgradeMaskRetArr[i+1]))})
			for Bit = 0, 7 do
			Trigger2(FP,{MemoryX(AtkUpgradePtrArr[i+1],AtLeast,(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]),(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]))},
				{SetMemoryX(NormalUpgradePtrArr[i+1],Add,(2^Bit)*(256^NormalUpgradeMaskRetArr[i+1]),(2^Bit)*(256^NormalUpgradeMaskRetArr[i+1]))},{Preserved})
			end
		CElseX() -- 업글컴플카운트 1 이상이면 일마공업 255로 고정됨!
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
			DisplayText("\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x03ＮＯＴＩＣＥ\x04　！！！\n\x14\n\x14\n\x13\x1C공격력 업그레이드\x04의 증가량이 255를 넘었습니다.\n\x13\x04이제부터는 \x1C원클릭 업그레이드\x04를 통해 업그레이드 해주세요.\n\n\x14\n\x13\x04！！！　\x03ＮＯＴＩＣＥ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4),
			PlayWAV("staredit\\wav\\button3.wav"),
			SetMemory(0x6509B0,SetTo,FP)
		})
		TriggerX(FP,{CVar(FP,DefFactorV[i+1][2],AtLeast,255)},{SetMemoryB(0x58D088 + (i * 46) + i+8,SetTo,0),
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x03ＮＯＴＩＣＥ\x04　！！！\n\x14\n\x14\n\x13\x08체력 업그레이드\x04의 증가량이 255를 넘었습니다.\n\x13\x04이제부터는 \x1C원클릭 업그레이드\x04를 통해 업그레이드 해주세요.\n\n\x14\n\x13\x04！！！　\x03ＮＯＴＩＣＥ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4),
			PlayWAV("staredit\\wav\\button3.wav"),
			SetMemory(0x6509B0,SetTo,FP)
		})
		
		TriggerX(FP,{CVar(FP,MarHP[i+1][2],AtLeast,160000*256)},{SetMemoryB(0x58D088 + (i * 46) + i+8,SetTo,0),SetMemoryB(0x58D088 + (i * 46) + 19,SetTo,0),SetMemoryB(0x58D088 + (i * 46) + 20,SetTo,0),
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07[ \x08체력\x04이 16만 넘어가면 \x1F%퍼뎀\x04 시스템 박살나서 더이상 체업 못해요 죄송합니다............................. \x07]",4),
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
			DisplayText("\x07[ \x1C공격력\x04이 시스템상 한계라서 더이상 공업 못해요 죄송합니다............................. \x07]",4),
			PlayWAV("staredit\\wav\\TT.ogg"),
			PlayWAV("staredit\\wav\\TT.ogg"),
			PlayWAV("staredit\\wav\\TT.ogg"),
			PlayWAV("staredit\\wav\\TT.ogg"),
			PlayWAV("staredit\\wav\\TT.ogg"),
			PlayWAV("staredit\\wav\\TT.ogg"),
			SetMemory(0x6509B0,SetTo,FP)
		})
		DoActionsX(FP,{SetCDeaths(FP,Subtract,1,UpSELemit[i+1]),SetCDeaths(FP,Subtract,1,OrderCool[i+1]),SetDeaths(i,Subtract,1,15)})
		
		
		
		 -- 업글시 돈 증가량 변수와 동기화. TT조건을 이용해 값이 변화할때만 연산함
		
		
		
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
		Trigger2(FP,{Memory(0x57f120+(4*i),AtLeast,0x80000000)},{SetMemory(0x57f120+(4*i),SetTo,0)},{Preserved}) -- 가스 마이너스 방지
		
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
			Trigger { -- 보호막 가동
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
		table.insert(OrderCooltime,SetMemoryB(0x57F27C+(228*i)+64,SetTo,0)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
		table.insert(OrderCooltime,SetMemoryB(0x57F27C+(228*i)+66,SetTo,0)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
		table.insert(OrderCooltime,SetMemoryB(0x57F27C+(228*i)+70,SetTo,0)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
		table.insert(OrderCooltimeRecover,SetMemoryB(0x57F27C+(228*i)+64,SetTo,1)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
		table.insert(OrderCooltimeRecover,SetMemoryB(0x57F27C+(228*i)+66,SetTo,1)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
		table.insert(OrderCooltimeRecover,SetMemoryB(0x57F27C+(228*i)+70,SetTo,1)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
		TriggerX(FP,{CVar(FP,Level[2],AtLeast,11),CDeaths(FP,AtLeast,1,OrderCool[i+1])},{OrderCooltime},{Preserved})
		TriggerX(FP,{CVar(FP,Level[2],AtLeast,11),CDeaths(FP,Exactly,0,OrderCool[i+1])},{OrderCooltimeRecover},{Preserved})

		CElseX()
			DoActions(FP,{SetDeaths(i,SetTo,0,440)}) -- 각플레이어가 존재하지 않을 경우 각플레이어의 브금타이머 0으로 고정 
			TriggerX(FP,{Deaths(i,AtLeast,1,227)},{SetDeaths(i,SetTo,0,227),SetCDeaths(FP,Add,100,PExitFlag)}) -- 나갔을 경우 1회에 한해 인구수 계산기 작동
		CIfXEnd()
	end
	local TempPos = CreateVar(FP)
	CIf(FP,CDeaths(FP,AtLeast,1,CUnitFlag)) -- 원격스팀 외 기능들
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