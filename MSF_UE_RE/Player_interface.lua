function PlayerInterface()
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
	local MultiHold = Create_VTable(7,nil,FP)
	local MultiStop = Create_VTable(7,nil,FP)
	local AtkExceed = Create_VTable(7,80,FP)
	local HPExceed = Create_VTable(7,7,FP)	
	local ShUp = Create_VTable(7,nil,FP)	
	local ShPoint = Create_VTable(7,nil,FP)	
	local AtkUpgradeMaskRetArr,AtkUpgradePtrArr,NormalUpgradeMaskRetArr,
	NormalUpgradePtrArr,DefUpgradeMaskRetArr,DefUpgradePtrArr,AtkFactorMaskRetArr,
	AtkFactorPtrArr,DefFactorMaskRetArr,DefFactorPtrArr,MarShMaskRetArr,MarShPtrArr = CreateTables(12)
	local SelUID = CreateVar(FP)
	local BarRally = CreateVarArr(7,FP)
	local MulCon = CreateVarArr(7,FP)
	local ExchangeP = CreateVar(FP)
	local DelayMedic = Create_CCTable(7)
	local ShUsed = Create_CCTable(7)
	local OldAvStat = Create_VTable(7,nil,FP)
	local MenuPtr = Create_VTable(7,nil,FP)
	local NewMaxScore = Create_VTable(7,nil,FP)
	
	local MarCreate = Create_CCTable(7)
	local MarCreate2 = Create_CCTable(7)
	local UpSELemit = Create_CCTable(7)
	local NukeCool = CreateCcodeArr(7)
	local TempStat = CreateVar(FP)
	local TempStat2 = CreateVar(FP)
	local TempGiveV = CreateVar(FP)
	local TempGivePV = CreateVar(FP)
	local GiveVA = CreateVArray(FP,7)
	local ArmorT3 = CreateCcodeArr(7)
	local ShopSw = CreateCcodeArr(7)

	
	local NsW = CreateCcode()
	
	

	--스탯
	local Nukes = CreateVarArr(7,FP)
	
	local MultiStimPack = CreateVarArr(7,FP)
	MarACMaskRetArr = {}
	MarACPtrArr = {}
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
		table.insert(MarShMaskRetArr,(0x660E00 + (MarID[i+1]*2))%4)
		table.insert(MarShPtrArr,0x660E00 + (MarID[i+1]*2) - (MarShMaskRetArr[i+1]))
		table.insert(MarACMaskRetArr,(0x662DB8 + MarID[i+1])%4)
		table.insert(MarACPtrArr,0x662DB8 + MarID[i+1] - MarACMaskRetArr[i+1])
	end

	local InsertKey = {}
	InsertKey[1] = "\x13\x04이 맵은 각 플레이마다 \x0710레벨 단위로 플레이가 가능하며 \n\x13\x08게임 종료 \x04이후 \x1F다음 게임\x04에서 \x07이어하기\x04를 통한 도전이 가능합니다.\n\x13\x04당신의 한계를 시험해 보세요! \x07이론적으로 제한 없는 단계와 업그레이드\x04를 제공합니다.\n\x13\x04255 업그레이드 완료 시 \x1F0으로 리셋 후 마린 공격력이 그대로 전승됩니다.\n\x13\x04Normal Marine + \x1F25000 Ore \x04= \x1FExCeed Marine\n\x13\x04조합소는 중앙 수정 광산이 있는곳으로 가시면 됩니다.\n\x13\x04PgUp, PgDn 키로 설명서 페이지를 바꿀 수 있습니다.\n\x13\x04――――――――――――――――――――――――― Page 1/3 ―――――――――――――――――――――――――\n\x13\x17ＣＬＯＳＥ　：　ＤＥＬＥＴＥ　ＫＥＹ"
	InsertKey[2] = "\x13\x04\x1CSCArchive \x04설명 (문의는 마공카를 찾아주세요.)\n\x13\x04현재 저장가능 데이터는 \x11최고기록(Level, Score)\x04과 \x19스탯 포인트 \x04입니다. 그외 \x08저장 불가능합니다.\n\x13\x04스탯 포인트로 다양한 보조 아이템을 사용할 수 있습니다.\n\x13\x07단, \x0F32Bit 환경 \x04스타크래프트에서만 이용하실 수 있으며\n\x13\x07 데이터 로드는 \x1D게임 시작 전\x04에만 가능합니다.\n\x13\x04데이터를 불러오지 못했다면 게임 재시작을 권장드립니다.\n\x13\x07데이터 저장\x04은 매 스테이지 클리어마다 \x07자동저장됩니다. \x04또는 \x18수동저장 \x04가능합니다.\n\x13\x04――――――――――――――――――――――――― Page 2/3 ―――――――――――――――――――――――――\n\x13\x17ＣＬＯＳＥ　：　ＤＥＬＥＴＥ　ＫＥＹ"
	InsertKey[3] = "\n\n\n\n\x13\x07구버전 데이터 관련 설명\n\x13\x04구버전의 스탯포인트는 \x1F크리스탈\x04에서 확인 가능하며 환전률은 1:10000 입니다. \n\x13\x04@칭호 1, 2, 3, 4 등의 명령어로 구버전 레벨, 권한에 따라 부여되는 칭호를 사용할 수 있습니다.\n\x13\x04자세한 칭호 부여 레벨 목록은 마공카에서 확인해주시기 바랍니다.\n\x13\x04――――――――――――――――――――――――― Page 3/3 ―――――――――――――――――――――――――\n\x13\x17ＣＬＯＳＥ　：　ＤＥＬＥＴＥ　ＫＥＹ"
	local InsertPage = CreateCcode()
	local KeyToggle = CreateCcode()
	--


	for i = 0, 6 do
		TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x6509B0,SetTo,i)},{preserved})
	end

	Trigger2X(FP,{Switch("Switch 242",Set);MemoryX(0x596A38, Exactly, 0x00000100,0x100),CDeaths(FP,Exactly,0,KeyToggle),CDeaths(FP,AtMost,1,InsertPage)},{SetCDeaths(FP,Add,1,InsertPage),SetCDeaths(FP,SetTo,1,DeleteToggle),SetCDeaths(FP,SetTo,1,KeyToggle)},{preserved})
	Trigger2X(FP,{Switch("Switch 242",Set);MemoryX(0x596A38, Exactly, 0x00010000,0x10000),CDeaths(FP,Exactly,0,KeyToggle)},{SetCDeaths(FP,Subtract,1,InsertPage),SetCDeaths(FP,SetTo,1,DeleteToggle),SetCDeaths(FP,SetTo,1,KeyToggle)},{preserved})
	Trigger2X(FP,{Switch("Switch 242",Set);Memory(0x596A44, Exactly, 0x00000100),CDeaths(FP,Exactly,0,KeyToggle)},{SetCDeaths(FP,SetTo,1,DeleteToggle),SetCDeaths(FP,SetTo,1,KeyToggle)},{preserved})
	for i = 0, 2 do
	Trigger2X(FP,{CDeaths(FP,Exactly,i,InsertPage),CDeaths(FP,Exactly,1,DeleteToggle)},{DisplayText(InsertKey[i+1],4)},{preserved})
	end

	Trigger2X(FP,{Memory(0x596A38, Exactly, 0),Memory(0x596A44, Exactly, 0),CDeaths(FP,Exactly,1,KeyToggle)},{SetCDeaths(FP,SetTo,0,KeyToggle)},{preserved})
	
	Trigger2X(FP,{Memory(0x596A44, Exactly, 65536)},{SetCDeaths(FP,SetTo,0,DeleteToggle),DisplayText(string.rep("\n", 20),4)},{preserved})
	CIfX(FP,{Switch("Switch 242", Set)})

	 
	
	
		TempVT = CreateVarArr(7,FP)
		for i = 0, 6 do
		CIf(FP,{LocalPlayerID(i)},{SetMemory(0x6509B0,SetTo,FP)}) -- 스테이터스 전송=
		CMov(FP,TempVT[1],NewAvStat[i+1])
		CMov(FP,TempVT[2],NewStat[i+1])
		CMov(FP,TempVT[3],NewMaxLevel[i+1])
		CMov(FP,TempVT[4],NewMaxScore[i+1])
		CIfEnd({SetMemory(0x6509B0,SetTo,FP)})
		end
		local iStrInit = def_sIndex()
		CJump(FP,iStrInit)
		local Str1, Str1a, Str1s = SaveiStrArr(FP,MakeiStrVoid(54))
		local iStr1 = GetiStrId(FP,MakeiStrWord(MakeiStrVoid(54).."\r\n",2)..MakeiStrVoid(56)) 

		local StatusT1 = "\x10【 \x08M\x04ax \x0FL\x04evel : 000 \x04/ \x08M\x04ax \x18S\x04core : 0000000000 \x10】"
		local StatusT2 = "\x10【 \x07사용가능 / \x08최대 \07스탯 포인트 \x04: 0000000000 \x04/ 0000000000 \x10】"
		local StatusT3 = "\x10【 \x1FE\x04xchange \x07R\x04ate : 0000\x18% \x10】"
		CJumpEnd(FP,iStrInit)


		for i = 0, 6 do
			TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x6509B0,SetTo,i)},{preserved})
		end

	function StatusInterface() --
	local PlayerID = CAPrintPlayerID 
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,StatusT1,nil,0) 
	CA__ItoCustom(SVA1(Str1,13),TempVT[3],nil,nil,{10,3},1,"\x0D",nil,0x1F)--"\x1F0"
	CA__ItoCustom(SVA1(Str1,31),TempVT[4],nil,nil,{10,10},1,"\x0D",nil,0x07)--"\x070"
	CA__InputVA(56*0,Str1,Str1s,nil,56*0,56*1-3)

	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,StatusT2,nil,0) 
	CA__ItoCustom(SVA1(Str1,20),TempVT[1],nil,nil,{10,10},1,"\x0D",nil,0x04)--"\x040"
	CA__ItoCustom(SVA1(Str1,33),TempVT[2],nil,nil,{10,10},1,"\x0D",nil,0x08)--"\x080"
	CA__InputVA(56*1,Str1,Str1s,nil,56*1,56*2-3)
	
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,StatusT3,nil,0) 
	CA__ItoCustom(SVA1(Str1,17),ExchangeRate,nil,nil,{10,4},1,"\x0D",nil,0x1F)--"\x1F0"
	CA__InputVA(56*2,Str1,Str1s,nil,56*2,56*3-3)
	
	
	end 
	CAPrint(iStr1,{Force1},{1,0,0,0,1,3,0,0},"StatusInterface",FP) --



	CIfXEnd()





	for i = 0, 6 do -- 각플레이어
		DoActions(FP,SetMemory(0x6509B0,SetTo,FP)) -- CP 복구 
		DoActions(FP,SetMemory(0x6509B0,SetTo,i)) -- CP 복구 
		Trigger2(i, {Switch("Switch 242",Set);Deaths(i,Exactly,0,18)}, {SetDeaths(i, SetTo, 1, 18)}) -- 맵 맥스레벨+10 = 비정상 데이터
		Trigger2(i, {Deaths(i,AtLeast,1000000,35)}, {SetDeaths(i, SetTo, 1, 149)}) -- 스탯백만이상 = 비정상 데이터
		Trigger2(i, {Deaths(i,AtLeast,10000,6)}, {SetDeaths(i, SetTo, 1, 149)}) -- 구레벨 1만이상 = 비정상 데이터
		Trigger2(i, {Deaths(i,AtLeast,LvLimit+10,18)}, {SetDeaths(i, SetTo, 1, 149)}) -- 맵 맥스레벨+10 = 비정상 데이터
		


		Trigger2(i,{Deaths(i,AtLeast,1,149),LocalPlayerID(i)},{
			PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
			DisplayText("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
			DisplayText("\x13\x07『 \x04채널 A10 을 방문하여 제작자에게 문의해주시기 바랍니다.\x07 』",4);
			SetCtrigX("X",0xFFFD,0x4,0,SetTo,"X",0xFFFD,0x0,0,1); -- ExitDrop
			SetMemory(0xCDDDCDDC,SetTo,1);
		})
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
					CDeaths(FP,AtLeast,5,BanToken[i+1]);Memory(0x512684, Exactly, i)
					
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
				Memory(0x57f0f0+(i*4),AtLeast,0x7FFFFFFF);
			},
			actions = {
				SetResources(i,SetTo,0x7FFFFFFF-1,Ore);
				PreserveTrigger();
			},
		}
		MC = {65,67}
		for j, k in pairs(MC) do
			local X = {}
			local Y = {}
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
					Y;
					PreserveTrigger();
				},
			}
		end
		KeyCP = i

		
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
		Trigger2(i,{Memory(0x582294+(4*i),AtLeast,1)},{SetMemory(0x582294+(4*i),Subtract,1)},{preserved})
		TriggerX(i,{Deaths(i,Exactly,0,OPConsole),Deaths(i,AtLeast,1,F9),Deaths(i,Exactly,0,B),Deaths(i,Exactly,0,CPConsole)},{SetDeaths(i,SetTo,1,CPConsole),SetDeaths(i,SetTo,0,F9),SetCDeaths(FP,SetTo,0,FuncT[i+1])},{preserved})
		TriggerX(i,{Deaths(i,Exactly,0,OPConsole),Deaths(i,AtLeast,1,F9),Deaths(i,Exactly,0,B),Deaths(i,Exactly,1,CPConsole)},{SetDeaths(i,SetTo,0,CPConsole),SetDeaths(i,SetTo,0,F9),SetCDeaths(FP,SetTo,0,FuncT[i+1])},{preserved})
		CIf(FP,{HumanCheck(i,1),Deaths(i,AtLeast,1,CPConsole)},{TSetCDeaths(FP,Add,Dt,FuncT[i+1])}) -- 스탯창 인터페이스 Deaths 100~149
			KeyInput(219,{CDeaths(FP,AtMost,0,GivePChange[i+1]),LocalPlayerID(i)},{print_utf8(12,0,"\x07『 \x04숫자키를 눌러 \x1F기부 플레이어\x04를 선택해주세요. \x07』")},1,1)
			KeyInput(219,{CDeaths(FP,AtMost,0,GivePChange[i+1])},{SetCDeaths(FP,SetTo,1,GivePChange[i+1]),SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15)},1)
			
			for j = 0, 6 do
				if i==j then 
					KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,1),LocalPlayerID(i)},{print_utf8(12,0,"\x07『 "..PlayerString[j+1].."\x04은(는) 자기 자신입니다. 자기 자신에게는 기부할 수 없습니다. \x07』")},1,1)
					KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,1)},{SetCDeaths(FP,SetTo,0,GivePChange[i+1]);SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15),},1)

				else 
				KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,1),LocalPlayerID(i)},{print_utf8(12,0,"\x07『 \x1F기부 플레이어\x04가"..PlayerString[j+1].."\x04으로 설정되었습니다. 금액을 입력해주세요. (최대 830만)\x07』")},1,1)
				KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,1)},{SetCDeaths(FP,SetTo,0,GivePChange[i+1]);SetDeaths(i,SetTo,j+1,151),SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15)},1)
				end

				KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,0),LocalPlayerID(i)},{print_utf8(12,0,"\x07『 "..PlayerString[j+1].."\x04이(가) 존재하지 않습니다. \x07』")},1,1)
				KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,0)},{SetCDeaths(FP,SetTo,0,GivePChange[i+1]);SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15)},1)
				TriggerX(FP,{Deaths(i,Exactly,j+1,151),HumanCheck(j,0)},{SetDeaths(i,SetTo,0,151)},{preserved})
			end
			CIfX(FP,{HumanCheck(i,1),Deaths(i,AtLeast,1,150),Deaths(i,AtMost,8320000,150),Deaths(i,AtLeast,1,151)},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15);})

				f_Read(FP,0x58A364+(48*150)+(4*i),TempGiveV)
				f_Read(FP,0x58A364+(48*151)+(4*i),TempGivePV)


				CIfX(FP,{TAccumulate(i,AtLeast,TempGiveV,Ore)},{TSetResources(_Sub(TempGivePV,1),Add,TempGiveV,Ore),TSetResources(i,Subtract,TempGiveV,Ore)})
					ItoDec(FP,TempGiveV,VArr(GiveVA,0),2,0x1F,0)
					_0DPatchX(FP,GiveVA,6)

					CIf(FP,{LocalPlayerID(i)})
					
					f_Memcpy(FP,0x640B60 + (12 * 218),_TMem(Arr(GiveTReset[3],0),"X","X",1),GiveTReset[2])
					f_Memcpy(FP,0x640B60 + (12 * 218),_TMem(Arr(GiveSendT[3],0),"X","X",1),GiveSendT[2])
					for j = 1, 7 do
					CIf(FP,CVar(FP,TempGivePV[2],Exactly,j))
					f_Movcpy(FP,0x640B60 + (12 * 218)+GiveSendT[2],VArr(Names[j],0),4*6)
					CIfEnd()
					end
					f_Memcpy(FP,0x640B60 + (12 * 218)+GiveSendT[2]+(4*6),_TMem(Arr(GiveT2[3],0),"X","X",1),GiveT2[2])
					f_Movcpy(FP,0x640B60 + (12 * 218)+GiveSendT[2]+(4*6)+GiveT2[2],VArr(GiveVA,0),4*5)
					f_Memcpy(FP,0x640B60 + (12 * 218)+GiveSendT[2]+(4*6)+GiveT2[2]+(4*5),_TMem(Arr(GiveSendT2[3],0),"X","X",1),GiveSendT2[2])
					CIfEnd()
					CIf(FP,{TMemory(0x512684,Exactly,_Sub(TempGivePV,1))})
					
					f_Memcpy(FP,GiveStrPtr,_TMem(Arr(GiveTReset[3],0),"X","X",1),GiveTReset[2])

					f_Memcpy(FP,GiveStrPtr,_TMem(Arr(GiveReciveT[3],0),"X","X",1),GiveReciveT[2])
					f_Movcpy(FP,_Add(GiveStrPtr,GiveReciveT[2]),VArr(Names[i+1],0),4*6)
					f_Memcpy(FP,_Add(GiveStrPtr,GiveReciveT[2]+(4*6)),_TMem(Arr(GiveT2[3],0),"X","X",1),GiveT2[2])
					f_Movcpy(FP,_Add(GiveStrPtr,GiveReciveT[2]+(4*6)+GiveT2[2]),VArr(GiveVA,0),4*5)
					f_Memcpy(FP,_Add(GiveStrPtr,GiveReciveT[2]+(4*6)+GiveT2[2]+(4*5)),_TMem(Arr(GiveReciveT2[3],0),"X","X",1),GiveReciveT2[2])
					CDoActions(FP,{TSetMemory(0x6509B0,SetTo,_Sub(TempGivePV,1)),DisplayText("\x0D\x0D\x0DGive".._0D,4)})

					f_Memcpy(FP,GiveStrPtr,_TMem(Arr(GiveTReset[3],0),"X","X",1),GiveTReset[2])
					CIfEnd()
				CElseX({SetMemory(0x6509B0,SetTo,i)})
				CallTriggerX(FP,Call_Print13[i+1])
				TriggerX(FP,{LocalPlayerID(i)},{print_utf8(12,0,"\x07『 \x04잔액이 부족합니다. \x07』")},{preserved})

				CIfXEnd()
			DoActions(FP,SetMemory(0x6509B0,SetTo,i))
			CElseIfX({Deaths(i,AtLeast,1,150),Deaths(i,AtMost,8320000,150),Deaths(i,AtMost,0,151)},{SetDeaths(i,SetTo,150,15)})
			CallTriggerX(FP,Call_Print13[i+1])
			TriggerX(FP,{LocalPlayerID(i)},{print_utf8(12,0,"\x07『 \x1F기부 플레이어\x04가 설정되지 않았습니다. \x07』")},{preserved})
			CIfXEnd()
			DoActions(FP,SetMemory(0x6509B0,SetTo,i))
			TriggerX(FP,{Deaths(i,AtLeast,1,150)},{SetCDeaths(FP,SetTo,0,FuncT[i+1])},{preserved})
			TriggerX(FP,{Deaths(i,AtMost,0,15),Memory(0x512684,Exactly,i)},{SetCDeaths(FP,SetTo,0,DeleteToggle),
				print_utf8(12,0,"\x07[ \x1F미네랄 \x03기부방법 \x041. 물결버튼(～)누른 후 숫자버튼으로 플레이어 선택 2. 숫자를 채팅창에 입력.(최대 830만) ESC : 닫기\x07 ]")
			},{preserved}) -- 13번줄 프린트 트리거 플레이어가 FP인 이유는 트리거 순서가 1P부터 8P까지 실행되기 때문. i로 하게될 경우 이게 씹히고 위에있는 CText가 보이게 된다. 


		--CPConsole
		TriggerX(FP,{CDeaths(FP,AtLeast,15*1000,FuncT[i+1])},{SetDeaths(i,SetTo,0,CPConsole),SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetCDeaths(FP,SetTo,0,GivePChange[i+1]);SetDeaths(i,SetTo,0,151),},{preserved})
		TriggerX(FP,{Deaths(i,AtLeast,1,ESC)},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,0,CPConsole),SetCDeaths(FP,SetTo,0,GivePChange[i+1]);SetDeaths(i,SetTo,0,151)},{preserved})
		CIfEnd(SetMemory(0x6509B0,SetTo,i))
		Trigger2(i,{Deaths(i,AtMost,0,14),Deaths(i,AtLeast,1,197)},{SetDeaths(i,SetTo,1,14)},{preserved})
			DoActions(i,{
				SetMemoryB(0x57F27C+(228*i)+MedicTrig[1],SetTo,0),
				SetMemoryB(0x57F27C+(228*i)+MedicTrig[2],SetTo,0),
				SetMemoryB(0x57F27C+(228*i)+MedicTrig[3],SetTo,0),
				SetMemoryB(0x57F27C+(228*i)+MedicTrig[4],SetTo,0),
			})
			for j = 0, 3 do
				TriggerX(i,{CDeaths(FP,Exactly,j,DelayMedic[i+1]),CD(TestMode,0)},{SetMemoryB(0x57F27C+(228*i)+MedicTrig[j+1],SetTo,1)},{preserved})
				TriggerX(i,{CD(TestMode,1)},{SetMemoryB(0x57F27C+(228*i)+70,SetTo,1)},{preserved})
			
			TriggerX(i,{Command(i,AtLeast,1,72),CDeaths(FP,Exactly,j,DelayMedic[i+1])},{
				DisplayText(DelayMedicT[j+1],4),
				SetCDeaths(FP,Add,1,DelayMedic[i+1]),
				GiveUnits(All,72,i,"Anywhere",P12),
				RemoveUnitAt(1,72,"Anywhere",P12)},{preserved})
			end
			TriggerX(i,{CDeaths(FP,AtLeast,4,DelayMedic[i+1])},{SetCDeaths(FP,Subtract,4,DelayMedic[i+1])},{preserved})
			Trigger2(i,{DeathsX(i,Exactly,0,12,0xFF000000);Command(i,AtLeast,1,22);},{
				GiveUnits(All,22,i,"Anywhere",P12);
				RemoveUnitAt(All,22,"Anywhere",P12);
				DisplayText("\x07『 \x1CBGM\x04을 듣지 않습니다. \x07』",4);
				SetDeathsX(i,SetTo,1*16777216,12,0xFF000000);
			},{preserved})

			Trigger2(i,{DeathsX(i,Exactly,1*16777216,12,0xFF000000);Command(i,AtLeast,1,22);},{
				GiveUnits(All,22,i,"Anywhere",P12);
				RemoveUnitAt(All,22,"Anywhere",P12);
				DisplayText("\x07『 \x1CBGM\x04을 듣습니다. \x07』",4);
				SetDeathsX(i,SetTo,0*16777216,12,0xFF000000);
			},{preserved})

			Trigger2X(i,{CDeaths(FP,Exactly,0,HeroPointNotice[i+1]);Command(i,AtLeast,1,29);},{
				GiveUnits(All,29,i,"Anywhere",P12);
				RemoveUnitAt(All,29,"Anywhere",P12);
				DisplayText("\x07『 \x1F영작 알림소리\x04를 듣지 않습니다. \x07』",4);
				SetCDeaths(FP,SetTo,1,HeroPointNotice[i+1]);
			},{preserved})

			Trigger2X(i,{CDeaths(FP,Exactly,1,HeroPointNotice[i+1]);Command(i,AtLeast,1,29);},{
				GiveUnits(All,29,i,"Anywhere",P12);
				RemoveUnitAt(All,29,"Anywhere",P12);
				DisplayText("\x07『 \x1F영작 알림소리\x04를 듣습니다. \x07』",4);
				SetCDeaths(FP,SetTo,0,HeroPointNotice[i+1]);
			},{preserved})
			if Limit == 1 then
			TriggerX(i,{Command(i,AtLeast,1,70);},{
				GiveUnits(All,70,i,"Anywhere",P12);
				RemoveUnitAt(All,70,"Anywhere",P12);
				DisplayText("\x07『 \x03TESTMODE OP \x04: \x1C모든 유닛\x04에 \x1D자율공격명령 \x04을 내립니다. (\x0FJunk Yard Dog\x04) \x07』",4);
				SetDeaths(i,SetTo,1,70);
				SetCDeaths(FP,Add,1,CUnitFlag);
			},{preserved})
			end

		UnitLimit(i,7,25,"SCV는",500)
		UnitLimit(i,125,15,"벙커는",8000)
		UnitLimit(i,124,15,"터렛은",4000)
		


		CIfX(FP,HumanCheck(i,1)) -- FP가 관리하는 시스템 부분 트리거. 각플레이어가 있을경우 실행된다.


		--SCA 데이터 변동시 갱신
		CIfX(FP,{TTDeaths(i,">",OldStat[i+1],4)})
			f_Read(FP,0x58A364+(48*4)+(4*i),TempStat)
			CSub(FP,TempStat2,TempStat,OldStat[i+1])
			CMov(FP,OldStat[i+1],TempStat)
			CAdd(FP,OldAvStat[i+1],TempStat2)
		CElseIfX(TTDeaths(i,"<",OldStat[i+1],4))
			CDoActions(FP,{TSetDeaths(i,SetTo,OldStat[i+1],4)})
		CIfXEnd()
		CIfX(FP,{TTDeaths(i,">",NewStat[i+1],35)})
			f_Read(FP,0x58A364+(48*35)+(4*i),TempStat)
			CSub(FP,TempStat2,TempStat,NewStat[i+1])
			CMov(FP,NewStat[i+1],TempStat)
			CAdd(FP,NewAvStat[i+1],TempStat2)
		CElseIfX(TTDeaths(i,"<",NewStat[i+1],35))
			CDoActions(FP,{TSetDeaths(i,SetTo,NewStat[i+1],35)})
		CIfXEnd()
		
		function SCA_DeathToV(Dest,SourceUnit,TargetPlayer)
			CIfX(FP,{TTDeaths(TargetPlayer,">",Dest,SourceUnit)})
				f_Read(FP,0x58A364+(48*SourceUnit)+(4*TargetPlayer),TempStat)
				CMov(FP,Dest,TempStat)
			CElseIfX(TTDeaths(TargetPlayer,"<",Dest,SourceUnit))
				CDoActions(FP,{TSetDeaths(TargetPlayer,SetTo,Dest,SourceUnit)})
			CIfXEnd()
		end
		SCA_DeathToV(OldMaxLevel[i+1],6,i)
		SCA_DeathToV(NewMaxLevel[i+1],18,i)
		SCA_DeathToV(OldMaxScore[i+1],24,i)
		SCA_DeathToV(NewMaxScore[i+1],36,i)
		SCA_DeathToV(UsedOldP[i+1],37,i)
		
		CIf(FP,{Bring(i,AtLeast,1,28,64)},{
			RemoveUnitAt(1,28,"Anywhere",i),
		})
		CIfX(FP,{TMemory(_Mem(_ReadF(0x5821D4 + (4*i))),AtLeast,_ReadF(0x582204 + (4*i)))})
			TriggerX(FP,{Accumulate(i,AtLeast,30000*3,Ore),Deaths(i,AtLeast,36,126)},{
				SetMemory(0x6509B0,SetTo,i),
				DisplayText("\x07『 \x1F광물\x04을 소모하여 \x1FExceeD \x1BM\x04arine 을 \x073기 \x19소환\x04하였습니다. - \x1F90,000 O r e \x07』",4),
				SetMemory(0x6509B0,SetTo,FP),
				SetResources(i,Subtract,30000*3,Ore);
				SetCDeaths(FP,Add,3,MarCreate[i+1]),
			},{preserved})
			Trigger { -- 조합 조건 안됨
				players = {FP},
				conditions = {
				Deaths(i,AtMost,35,126);
			},
			  actions = {
				SetMemory(0x6509B0,SetTo,i),
				DisplayText("\x07『 \x1FExceeD \x1BM\x04arine \x073기 \x19빠른 소환\x04 조건이 맞지 않습니다. (조건 - \x1FExceeD \x1BM\x04arine \x0436기 조합) \x07』",4);
				SetMemory(0x6509B0,SetTo,FP),
				PreserveTrigger();
			},
		}
		    Trigger { -- 조합 조건 안됨
		    players = {FP},
		    conditions = {
			Accumulate(i,AtMost,(30000*3)-1,Ore),
			Deaths(i,AtLeast,36,126),
		},
		  actions = {
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07『 \x1FExceeD \x1BM\x04arine \x073기 \x19빠른 소환\x04 조건이 맞지 않습니다. (조건 - \x1F90,000 Ore 보유) \x07』",4);
			SetMemory(0x6509B0,SetTo,FP),
			PreserveTrigger();
			},
	  	}
		CElseX({
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07『 \x1FExceeD \x1BM\x04arine \x073기 \x19빠른 소환\x04 조건이 맞지 않습니다. (조건 - 인구수 만족) \x07』",4);
			SetMemory(0x6509B0,SetTo,FP),
		})
		
		CIfXEnd()
		CIfEnd()

		Trigger { -- 조합 영웅마린
			players = {FP},
			conditions = {
				Label(0);
				--Bring(FP,AtLeast,1,173,10);
				Bring(i,AtLeast,1,10,10);
				Accumulate(i,AtLeast,25000,Ore);
				Accumulate(i,AtMost,0x7FFFFFFF,Ore);
			},
			actions = {
				SetMemory(0x6509B0,SetTo,i),
				DisplayText("\x07『 \x1F광물\x04을 소모하여 \x04Norma Marine을 \x1FExceeD \x1BM\x04arine으로 \x19변환\x04하였습니다. - \x1F25,000 O r e \x07』",4);
				SetMemory(0x6509B0,SetTo,FP),
				SetDeaths(i,Add,1,126),
				ModifyUnitEnergy(1,10,i,10,0);
				SetResources(i,Subtract,25000,Ore);
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
		},{preserved})
		CIf(FP,{TTMemory(_Add(BarrackPtr[i+1],62),NotSame,BarRally[i+1])}) --배럭랠리 갱신
			f_Read(FP,_Add(BarrackPtr[i+1],62),BarRally[i+1])
			CIf(FP,{Memory(0x628438,AtLeast,1),CVar(FP,Nukes[i+1][2],AtLeast,1),CDeaths(FP,AtMost,0,NukeCool[1+i])},{SetCVar(FP,Nukes[i+1][2],Subtract,1),SetCDeaths(FP,SetTo,10,NukeCool[i+1])}) -- 배럭랠리 갱신중 핵이 장전되어있을경우 또는 캔낫이아닐경우
				Convert_CPosXY(BarRally[i+1])
				DoActionsX(FP,SetCDeaths(FP,Add,10,NsW))
				CWhile(FP,CDeaths(FP,AtLeast,1,NsW),SetCDeaths(FP,Subtract,1,NsW))
				CreateBullet(211,20,0,CPosX,CPosY,i)
				CWhileEnd()
				CreateBullet(205,20,0,CPosX,CPosY,i)
				Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
				TriggerX(FP,{CDeaths(FP,AtMost,2,SoundLimit[i+1])},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsHit00.wav")},HumanPlayers,FP),SetCDeaths(FP,Add,1,SoundLimit[i+1])},{preserved})
				DoActions2(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0D"..PlayerString[i+1].."Nuke".._0D,4),MinimapPing(1)},HumanPlayers,FP)})
			CIfEnd()
		CIfEnd()
		CWhile(FP,{CDeaths(FP,AtLeast,1,MarCreate[i+1]),Memory(0x628438,AtLeast,1)},SetCDeaths(FP,Subtract,1,MarCreate[i+1]))
		
			CIfX(FP,{TMemory(_Mem(_ReadF(0x5821D4 + (4*i))),AtLeast,_ReadF(0x582204 + (4*i)))})
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			DoActions(FP,CreateUnitWithProperties(1,MarID[i+1],2+i,i,{energy = 100}))
			CIf(FP,{TTCVar(FP,BarPos[i+1][2],NotSame,BarRally[i+1]),CVar(FP,BarRally[i+1][2],AtLeast,1),TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
				CDoActions(FP,{TSetDeathsX(_Add(Nextptrs,19),SetTo,6*256,0,0xFF00),
				TSetDeaths(_Add(Nextptrs,22),SetTo,BarRally[i+1],0)})
			CIfEnd()
			CElseX({SetResources(i,Add,30000,Ore)})
			CIfXEnd()
			CMov(FP,0x6509B0,FP)
		CWhileEnd()
		
		CIf(FP,{CDeaths(FP,AtLeast,1,MarCreate2[i+1]),Memory(0x628438,AtLeast,1)},SetCDeaths(FP,Subtract,1,MarCreate2[i+1]))
		CIfX(FP,{TMemory(_Mem(_ReadF(0x5821D4 + (4*i))),AtLeast,_ReadF(0x582204 + (4*i)))})
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			DoActions(FP,CreateUnitWithProperties(1,10,2+i,i,{energy = 100}))
			CIf(FP,{TTCVar(FP,BarPos[i+1][2],NotSame,BarRally[i+1]),CVar(FP,BarRally[i+1][2],AtLeast,1),TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
				CDoActions(FP,{TSetDeathsX(_Add(Nextptrs,19),SetTo,6*256,0,0xFF00),
				TSetDeaths(_Add(Nextptrs,22),SetTo,BarRally[i+1],0)})
			CIfEnd()
			CElseX({SetResources(i,Add,5000,Ore)})
			CIfXEnd()
			CMov(FP,0x6509B0,FP)
		CIfEnd()
		
		local MedicTrigJump = def_sIndex()
		
		for j = 1, 4 do
			NJumpX(FP,MedicTrigJump,{CDeaths(FP,Exactly,j-1,DelayMedic[i+1]),Bring(i,AtLeast,1,MedicTrig[j],64)})
		end
			NJumpX(FP,MedicTrigJump,{CD(TestMode,1)})
			NIf(FP,Never())
				NJumpXEnd(FP,MedicTrigJump)
					DoActionsX(FP,{
						RemoveUnit(MedicTrig[1],i),
						RemoveUnit(MedicTrig[2],i),
						RemoveUnit(MedicTrig[3],i),
						RemoveUnit(MedicTrig[4],i),
						ModifyUnitHitPoints(All,"Men",i,"Anywhere",100),
						ModifyUnitHitPoints(All,"Buildings",i,"Anywhere",100),
						ModifyUnitShields(All,"Men",i,"Anywhere",100),
						ModifyUnitShields(All,"Buildings",i,"Anywhere",100),
						SetDeaths(i, SetTo, 1, 34);
						SetCD(CUnitFlag,1)
					})
			NIfEnd()
		
		CIfX(FP,{CV(AtkExceed[i+1],AtkUpCompCount[i+1],AtLeast)})
		NIf(FP,MemoryB(0x58D2B0+(46*i)+18,Exactly,4)) -- 공업 255회
			CDoActions(FP,{
				SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(AtkUpgradePtrArr[i+1])),
				SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^AtkUpgradeMaskRetArr[i+1]),
				TSetCVar(FP,UpgradeFactor[2],SetTo,AtkFactorV[i+1]),
				SetCVar(FP,UpgradeCP[2],SetTo,i),
				SetCVar(FP,UpgradeMax[2],SetTo,255),
				SetMemoryB(0x58D2B0+(46*i)+18,SetTo,3)})
			CallTrigger(FP,OneClickUpgrade)
		NIfEnd()
		NIf(FP,MemoryB(0x58D2B0+(46*i)+17,Exactly,4)) -- 공업 10회
			CDoActions(FP,{
				SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(AtkUpgradePtrArr[i+1])),
				SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^AtkUpgradeMaskRetArr[i+1]),
				TSetCVar(FP,UpgradeFactor[2],SetTo,AtkFactorV[i+1]),
				SetCVar(FP,UpgradeCP[2],SetTo,i),
				SetCVar(FP,UpgradeMax[2],SetTo,10),
				SetMemoryB(0x58D2B0+(46*i)+17,SetTo,3)})
			CallTrigger(FP,OneClickUpgrade)
		NIfEnd()
		DoActions(FP, {
			SetMemoryB(0x58D2B0+(46*i)+18,SetTo,3),
			SetMemoryB(0x58D2B0+(46*i)+17,SetTo,3),
		})
		CElseX({
			SetMemoryB(0x58D2B0+(46*i)+18,SetTo,2),
			SetMemoryB(0x58D2B0+(46*i)+17,SetTo,2),
		})
		CIfXEnd()

		CIfX(FP,{CV(HPExceed[i+1],DefUpCompCount[i+1],AtLeast)})
		NIf(FP,MemoryB(0x58D2B0+(46*i)+19,Exactly,4)) -- 체업 255회
			CDoActions(FP,{
				SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(DefUpgradePtrArr[i+1])),
				SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^DefUpgradeMaskRetArr[i+1]),
				TSetCVar(FP,UpgradeFactor[2],SetTo,DefFactorV[i+1]),
				SetCVar(FP,UpgradeCP[2],SetTo,i),
				SetCVar(FP,UpgradeMax[2],SetTo,255),
				SetMemoryB(0x58D2B0+(46*i)+19,SetTo,3)})
			CallTrigger(FP,OneClickUpgrade)
		NIfEnd()
		NIf(FP,MemoryB(0x58D2B0+(46*i)+20,Exactly,4)) -- 체업 10회
			CDoActions(FP,{
				SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(DefUpgradePtrArr[i+1])),
				SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^DefUpgradeMaskRetArr[i+1]),
				TSetCVar(FP,UpgradeFactor[2],SetTo,DefFactorV[i+1]),
				SetCVar(FP,UpgradeCP[2],SetTo,i),
				SetCVar(FP,UpgradeMax[2],SetTo,10),
				SetMemoryB(0x58D2B0+(46*i)+20,SetTo,3)})
			CallTrigger(FP,OneClickUpgrade)
		NIfEnd()
		DoActions(FP, {
			SetMemoryB(0x58D2B0+(46*i)+19,SetTo,3),
			SetMemoryB(0x58D2B0+(46*i)+20,SetTo,3),
		})
		CElseX({
			SetMemoryB(0x58D2B0+(46*i)+19,SetTo,2),
			SetMemoryB(0x58D2B0+(46*i)+20,SetTo,2),
		})
		CIfXEnd()
		
		CIf(FP,{MemoryX(AtkUpgradePtrArr[i+1],AtLeast,255*(256^AtkUpgradeMaskRetArr[i+1]),255*(256^AtkUpgradeMaskRetArr[i+1]))},{SetMemoryX(AtkUpgradePtrArr[i+1],SetTo,0*(256^AtkUpgradeMaskRetArr[i+1]),255*(256^AtkUpgradeMaskRetArr[i+1]))})
		DoActionsX(FP,{
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x13\x04！！！　\x1C공격력 업그레이드\x04가 255를 넘어 한계를 돌파합니다.\x04　！！！\n\x13\x04！！！　\x07업그레이드를 \x040으로 재설정하고 \x17공격력 수치가 전승\x04되었습니다.\x04　！！！",4),
			SetMemory(0x6509B0,SetTo,FP),
			SetMemoryW(0x656EB0 + (MarWep[i+1]*2),Add,MarDamageFactor*255),
			SetCVar(FP,AtkUpCompCount[i+1][2],Add,1),
		})
		TriggerX(FP,{CDeaths(FP,AtMost,0,UpSELemit[i+1])},{SetMemory(0x6509B0,SetTo,i),PlayWAV("staredit\\wav\\LimitBreak.ogg"),SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,Add,100,UpSELemit[i+1])},{preserved})
		TriggerX(FP,{CVar(FP,AtkUpCompCount[i+1][2],AtLeast,6)},{SetCVar(FP,AtkFactorV[i+1][2],Add,1)},{preserved})--CVar(FP,AtkUpCompCount[i+1][2],AtLeast,151)
			DoActions(FP,{SetMemoryB(0x58F32C + (59 - 46)+ 15*i,Add,1)})
			TriggerX(FP,{CVar(FP,AtkFactorV[i+1][2],AtLeast,255)},{SetMemoryB(0x58F32C + (59 - 46)+ 15*i,SetTo,255)},{preserved})
		CIfEnd()
		--CIf(FP,CD(TestMode,1))
		--mtttest = CreateVar2(FP,nil,nil,123456789)
		--mtttest2 = CreateVar2(FP,nil,nil,123456789)
		--CMov(FP,0x57f0f0,mtttest+mtttest2)
		--CIfEnd()
		CIf(FP,{MemoryX(DefUpgradePtrArr[i+1],AtLeast,255*(256^DefUpgradeMaskRetArr[i+1]),255*(256^DefUpgradeMaskRetArr[i+1]))},{SetMemoryX(DefUpgradePtrArr[i+1],SetTo,0*(256^DefUpgradeMaskRetArr[i+1]),255*(256^DefUpgradeMaskRetArr[i+1]))})
		DoActionsX(FP,{
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x13\x04！！！　\x08체력 업그레이드\x04가 255를 넘어 한계를 돌파합니다.\x04　！！！\n\x13\x04！！！　\x07업그레이드를 \x040으로 재설정하고 \x17체력 수치가 전승\x04되었습니다.\x04　！！！",4),
			SetMemory(0x6509B0,SetTo,FP),
			--SetCVar(FP,DefFactorV[i+1][2],Add,1),
			SetCVar(FP,MarMaxHP[i+1][2],Add,10000*256),
			SetCVar(FP,DefUpCompCount[i+1][2],Add,1),
		})
		TriggerX(FP,{CDeaths(FP,AtMost,0,UpSELemit[i+1])},{SetMemory(0x6509B0,SetTo,i),PlayWAV("staredit\\wav\\LimitBreak.ogg"),SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,Add,100,UpSELemit[i+1])},{preserved})
		TriggerX(FP,{CVar(FP,DefUpCompCount[i+1][2],AtLeast,7)},{SetCVar(FP,DefFactorV[i+1][2],Add,11)},{preserved})--CVar(FP,DefUpCompCount[i+1][2],AtLeast,51)
		CIfEnd()
		if Limit == 1 then
		CIf(FP,CD(TestMode,1))
		CMov(FP,0x57f120,DefUpCompCount[i+1],100000000)
		CIfEnd()
		end
		DoActionsX(FP,{SetCVar(FP,CurrentHP[i+1][2],SetTo,0)})-- 체력값 초기화
		for Bit = 0, 7 do
		TriggerX(FP,{MemoryX(DefUpgradePtrArr[i+1],AtLeast,(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]),(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]))},
			{SetCVar(FP,CurrentHP[i+1][2],Add,10008*(2^Bit))},{preserved})
		end
		CMov(FP,MarHP[i+1],_Add(CurrentHP[i+1],MarMaxHP[i+1]))
		
		CIfX(FP,CVar(FP,AtkUpCompCount[i+1][2],AtMost,0)) -- 업그레이드 컴플리트 카운트(255업 찍은 횟수)가 0일 경우.
			DoActions(FP,{SetMemoryX(NormalUpgradePtrArr[i+1],SetTo,0*(256^NormalUpgradeMaskRetArr[i+1]),255*(256^NormalUpgradeMaskRetArr[i+1]))})
			for Bit = 0, 7 do
			Trigger2(FP,{MemoryX(AtkUpgradePtrArr[i+1],AtLeast,(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]),(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]))},
				{SetMemoryX(NormalUpgradePtrArr[i+1],Add,(2^Bit)*(256^NormalUpgradeMaskRetArr[i+1]),(2^Bit)*(256^NormalUpgradeMaskRetArr[i+1]))},{preserved})
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
		
		TriggerX(FP,{CVar(FP,MarHP[i+1][2],AtLeast,2560000*256)},{
			SetMemoryB(0x58D088 + (i * 46) + i+8,SetTo,0),
			SetMemoryB(0x58D088 + (i * 46) + 19,SetTo,0),
			SetMemoryB(0x58D088 + (i * 46) + 20,SetTo,0),
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07[ \x04밸런스 문제로 인해 더이상 체업 못해요 죄송합니다............................. \x07]",4),
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
			SetMemory(0x6509B0,SetTo,FP)
		})
		

		CIf(FP,{Memory(0x628438,AtLeast,1),Bring(i,AtMost,0,128,64)})
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			CMov(FP,MenuPtr[i+1],Nextptrs)
			DoActions(FP,CreateUnitWithProperties(1,128,2+i,i,{energy = 100}))
			CDoActions(FP,{
				TSetMemory(_Add(Nextptrs,0x98/4),SetTo,0 + 228*65536);
				TSetMemory(_Add(Nextptrs,0x9C/4),SetTo,228 + 228*65536);
				TSetMemoryX(_Add(Nextptrs,55),SetTo,0xA00000,0xA00000);
			})
		CIfEnd()

	
function CIfShop(CP,ID,Cost,ContentStr,DisContentStr,Conditions,Actions)
	CIf(FP,{TMemory(_Add(MenuPtr[CP+1],0x98/4),Exactly,0 + ID*65536)})
	CurShopCost = Cost
	CurShopCP = CP
	CurShopCond = Conditions
	CallTrigger(FP,Call_Print13[CP+1])
	TriggerX(FP,{CVar(FP,NewAvStat[CP+1][2],AtLeast,Cost),CDeaths(FP,AtMost,0,ShopSw[CP+1]),LocalPlayerID(CP),Conditions},{print_utf8(12,0,ContentStr)},{preserved})
	TriggerX(FP,{CVar(FP,NewAvStat[CP+1][2],AtLeast,Cost),CDeaths(FP,AtMost,0,ShopSw[CP+1]),Conditions},{SetCVar(FP,NewAvStat[CP+1][2],Subtract,Cost),SetDeaths(CP,SetTo,150,15),SetCDeaths(FP,SetTo,1,ShopSw[CP+1]),SetCp(CP),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg"),SetCp(FP),Actions},{preserved})	-- 포인트가 충분할 경우

	TriggerX(FP,{CVar(FP,NewAvStat[CP+1][2],AtMost,Cost-1),CDeaths(FP,AtMost,0,ShopSw[CP+1]),LocalPlayerID(CP)},{print_utf8(12,0,DisContentStr)},{preserved})
	TriggerX(FP,{CVar(FP,NewAvStat[CP+1][2],AtMost,Cost-1),CDeaths(FP,AtMost,0,ShopSw[CP+1])},{SetDeaths(CP,SetTo,150,15),SetCDeaths(FP,SetTo,1,ShopSw[CP+1]),SetCp(CP),PlayWAV("staredit\\wav\\FailSE.ogg"),SetCp(FP)},{preserved})	-- 포인트가 충분하지 않을 경우
end
ShopTempV = CreateVar(FP)
function CIfShopOld(CP,ID,Cost,ContentStr,DisContentStr,Conditions,Actions)
	CIf(FP,{TMemory(_Add(MenuPtr[CP+1],0x98/4),Exactly,0 + ID*65536)})
	CurShopCost = Cost
	CurShopCP = CP
	CurShopCond = Conditions
	
	
	CallTrigger(FP,Call_Print13[CP+1])
	CMov(FP,ShopTempV,_Sub(OldAvStat[i+1],_Mul(UsedOldP[i+1],P_ExcOldP)),nil,nil,1)
	CTrigger(FP,{CVar(FP,ShopTempV[2],AtLeast,Cost),CDeaths(FP,AtMost,0,ShopSw[CP+1]),LocalPlayerID(CP),Conditions},{print_utf8(12,0,ContentStr)},{preserved})
	CTrigger(FP,{CVar(FP,ShopTempV[2],AtLeast,Cost),CDeaths(FP,AtMost,0,ShopSw[CP+1]),Conditions},{SetCVar(FP, UsedOldP[i+1][2], Add, 1),SetDeaths(CP,Add,1,37),SetDeaths(CP,SetTo,150,15),SetCDeaths(FP,SetTo,1,ShopSw[CP+1]),SetCp(CP),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg"),SetCp(FP),Actions},{preserved})	-- 포인트가 충분할 경우

	CTrigger(FP,{CVar(FP,ShopTempV[2],AtMost,Cost),CDeaths(FP,AtMost,0,ShopSw[CP+1]),LocalPlayerID(CP)},{print_utf8(12,0,DisContentStr)},{preserved})
	CTrigger(FP,{CVar(FP,ShopTempV[2],AtMost,Cost),CDeaths(FP,AtMost,0,ShopSw[CP+1])},{SetDeaths(CP,SetTo,150,15),SetCDeaths(FP,SetTo,1,ShopSw[CP+1]),SetCp(CP),PlayWAV("staredit\\wav\\FailSE.ogg"),SetCp(FP)},{preserved})	-- 포인트가 충분하지 않을 경우
end
		CIf(FP,CVar(FP,MenuPtr[i+1][2],AtLeast,1))
		for m = 0, 0 do
		CIfShop(i,41+m,0,"\x07[ \x08뉴클리어\x04가 \x07장전\x04되었습니다. (사용법 : 배럭으로 우클릭) \x07]","\x07[ \x04더 이상 \x08뉴클리어\x04를 사용할 수 없습니다. \x07]",{CVar(FP,NukesUsage[i+1][2],AtLeast,1),CVar(FP,Nukes[i+1][2],AtMost,0)},{SetCVar(FP,NukesUsage[i+1][2],Subtract,1),SetCVar(FP,Nukes[i+1][2],Add,1),SetCp(i),PlayWAV("sound\\Terran\\Advisor\\TAdUpd07.WAV"),SetCp(FP)})
		
		CIfEnd()
		end
		CIfShop(i,42,P_StimCost,"\x07[ \x07구입 성공, \x1B원격 스팀팩 \x04기능을 사용할 수 있습니다. \x07]","\x07[ \x08포인트가 부족합니다 \x07]",{CVar(FP,MultiStimPack[i+1][2],AtMost,0)},{SetCVar(FP,MultiStimPack[i+1][2],SetTo,1)})
		CIfEnd()
		CIfShop(i,43,P_MultiStopCost,"\x07[ \x07구입 성공, \x07멀티 스탑 \x04기능을 사용할 수 있습니다. \x07]","\x07[ \x08포인트가 부족합니다 \x07]",{CVar(FP,MultiHold[i+1][2],AtMost,0)},{SetCVar(FP,MultiHold[i+1][2],SetTo,1)})
		CIfEnd()
		CIfShop(i,44,P_MultiHoldCost,"\x07[ \x07구입 성공, \x07멀티 홀드 \x04기능을 사용할 수 있습니다. \x07]","\x07[ \x08포인트가 부족합니다 \x07]",{CVar(FP,MultiStop[i+1][2],AtMost,0)},{SetCVar(FP,MultiStop[i+1][2],SetTo,1)})
		CIfEnd()
		CIfShopOld(i,45,P_ExcOldP,"\x07[ \x07구입 성공, \x1B구버전 포인트\x04가 전환되었습니다. \x07]","\x07[ \x08포인트가 부족합니다 \x07]",nil,{SetDeaths(i, Add, 1, 35)})
		CIfEnd()
		CIfShop(i,46,P_AtkExceed,"\x07[ \x07구입 성공, \x17ATK \x04업그레이드 \x1F한계\x04가 돌파되었습니다. \x07]","\x07[ \x08포인트가 부족합니다 \x07]",{CV(AtkExceed[i+1],255,AtMost)},AddV(AtkExceed[i+1],1))
		CIfEnd()
		CIfShop(i,47,P_HPExceed,"\x07[ \x07구입 성공, \x08HP \x04업그레이드 \x1F한계\x04가 돌파되었습니다. \x07]","\x07[ \x08포인트가 부족합니다 \x07]",{CV(HPExceed[i+1],255,AtMost)},AddV(HPExceed[i+1],1))
		CIfEnd()
		CIfShop(i,48,P_ShUpgrade,"\x07[ \x07구입 성공, \x1C쉴드 \x04업그레이드가 완료되었습니다. \x07]","\x07[ \x08포인트가 부족합니다 \x07]",{CV(ShUp[i+1],54,AtMost)},{AddV(ShUp[i+1],1),SetMemoryW(0x660E00+(MarID[i+1]*2),Add,1000)})
		CIfEnd()

		
		CDoActions(FP,{
			TSetMemory(_Add(MenuPtr[i+1],0x98/4),SetTo,0 + 228*65536);
			TSetMemory(_Add(MenuPtr[i+1],0x9C/4),SetTo,228 + 228*65536);
			TSetMemoryX(_Add(MenuPtr[i+1],0xA0/4),SetTo,228,0xFFFF);
			SetCDeaths(FP,SetTo,0,ShopSw[i+1])})
		CIfEnd()
		TriggerX(FP,CV(AtkExceed[i+1],255+1,AtLeast),{SetMemoryB(0x57F27C+(228*i)+46,SetTo,0)},{preserved})
		TriggerX(FP,CV(HPExceed[i+1],255+1,AtLeast),{SetMemoryB(0x57F27C+(228*i)+47,SetTo,0)},{preserved})
		TriggerX(FP,CV(ShUp[i+1],54+1,AtLeast),{SetMemoryB(0x57F27C+(228*i)+48,SetTo,0)},{preserved})
		ItemT = {
			{Nukes[i+1],{41},1},
			{MultiStimPack[i+1],{42},1},
			{MultiHold[i+1],{43},1},
			{MultiStop[i+1],{44},1},
			{MultiStimPack[i+1],{71}},
			{MultiHold[i+1],{65}},
			{MultiStop[i+1],{67}},
		}
		for j, k in pairs(ItemT) do
			local X = {}
			local Y = {}
			for l, m in pairs(k[2]) do
				if k[3] == nil then
					table.insert(X,SetMemoryB(0x57F27C+(228*i)+m,SetTo,1))
					table.insert(Y,SetMemoryB(0x57F27C+(228*i)+m,SetTo,0))
				else
					table.insert(X,SetMemoryB(0x57F27C+(228*i)+m,SetTo,0))
					table.insert(Y,SetMemoryB(0x57F27C+(228*i)+m,SetTo,1))
				end
			end
			TriggerX(FP,{CVar(FP,k[1][2],AtLeast,1)},X,{preserved})
			TriggerX(FP,{CVar(FP,k[1][2],AtMost,0)},Y,{preserved})
		end

		 -- 업글시 돈 증가량 변수와 동기화. TT조건을 이용해 값이 변화할때만 연산함
		CIf(FP,{TTCVar(FP,MarHP[i+1][2],"!=",MarHP2[i+1])})
			CMov(FP,MarHP2[i+1],MarHP[i+1])
			CMov(FP,0x662350 + (MarID[i+1]*4),MarHP2[i+1])
			--CMov(FP,0x515BB0+(i*4),_Div(_ReadF(0x662350 + (MarID[i+1]*4)),_Mov(1000)))
		CIfEnd()
		
		CIf(FP,Score(i,Kills,AtLeast,1000))
			CMov(FP,ExchangeP,_Div(_ReadF(0x581F04+(i*4)),_Mov(1000)))
			CAdd(FP,{FP,ExScore[i+1][2],nil,"V"},_Div(_ReadF(0x581F04+(i*4)),_Mov(1000)))
			CMov(FP,0x581F04+(i*4),_Mod(_ReadF(0x581F04+(i*4)),_Mov(1000)))
			CAdd(FP,0x57F0F0+(i*4),_Mul(_Mul(ExchangeP,_Mov(10)),{FP,ExchangeRate[2],nil,"V"}))
			CMov(FP,ExchangeP,0)
		CIfEnd()

		CMov(FP,0x582174+(4*i),count)
		CAdd(FP,0x582174+(4*i),count)
		
		if Limit == 1 then 
			CIfX(FP, CD(TestMode,1))
			CElseX()
			CMov(FP,0x57f120+(4*i),ExScore[i+1])
			CIfXEnd()
			--CMov(FP,0x57f120+(4*i),Actived_Gun)
		else
			CMov(FP,0x57f120+(4*i),ExScore[i+1])
		end
		Trigger2(FP,{Memory(0x57f120+(4*i),AtLeast,0x80000000)},{SetMemory(0x57f120+(4*i),SetTo,0)},{preserved}) -- 가스 마이너스 방지
		
		CIfX(FP,Memory(0x582294+(4*i),AtLeast,1001))
		
			Trigger { -- 보호막 가동
				players = {FP},
				conditions = {
					Label(0);
				},
				actions = {
					ModifyUnitShields(All,"Any unit",i,"Anywhere",100);
					--SetMemoryX(0x664080 + (MarID[i+1]*4),SetTo,0x8000,0x8000);
					PreserveTrigger();
				},
			}
		CElseX()
			--DoActions(FP,{SetMemoryW(0x660E00 + (MarID[i+1]*2),SetTo,1000)})
			TriggerX(FP,{CDeaths(FP,AtMost,0,isSingle)},{SetMemoryX(0x664080 + (MarID[i+1]*4),SetTo,0,0x8000);},{preserved})
		CIfXEnd()
		DoActionsX(FP,{SetCDeaths(FP,Subtract,1,UpSELemit[i+1]),SetCDeaths(FP,Subtract,1,NukeCool[i+1]),SetDeaths(i,Subtract,1,15),SetCDeaths(FP,Subtract,1,ArmorT3[i+1])})
		CElseX()
			DoActions(FP,{SetDeaths(i,SetTo,0,12)}) -- 각플레이어가 존재하지 않을 경우 각플레이어의 브금타이머 0으로 고정 
			TriggerX(FP,{Deaths(i,AtLeast,1,227)},{SetDeaths(i,SetTo,0,227),SetCDeaths(FP,Add,100,PExitFlag)}) -- 나갔을 경우 1회에 한해 인구수 계산기 작동
		CIfXEnd()
	end
	DoActions(FP,{SetDeaths(9,SetTo,0,12),SetDeaths(10,SetTo,0,12),SetDeaths(11,SetTo,0,12),SetDeaths(12,SetTo,0,12)}) -- 각플레이어가 존재하지 않을 경우 각플레이어의 브금타이머 0으로 고정 
	
	local TempPos = CreateVar(FP)

	CIf(FP,CDeaths(FP,AtLeast,1,CUnitFlag)) -- 원격스팀 외 기능들
		for i = 0, 6 do
			GetLocCenter(73+i,CPosX,CPosY)
			CMov(FP,MulCon[i+1],_Add(CPosX,_Mul(CPosY,_Mov(0x10000))))
		end
		CMov(FP,0x6509B0,19025+19)
		CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
			CIf(FP,{DeathsX(CurrentPlayer,AtMost,6,0,0xFF),DeathsX(CurrentPlayer,AtLeast,256,0,0xFF00)})
			for i = 0, 6 do
			CIf(FP,{DeathsX(CurrentPlayer,Exactly,i,0,0xFF)})
			Trigger {
				players = {FP},
				conditions = {
					Deaths(i,AtLeast,1,71);
				},
				actions = {
					SetMemory(0x6509B0,Add,50);
					SetDeathsX(CurrentPlayer,SetTo,30*256,0,0xFF00);
					SetMemory(0x6509B0,Subtract,50);
					PreserveTrigger();
				}
			}
			f_SaveCp()
			local ValCancle = def_sIndex()
			NJumpX(FP,ValCancle,{TMemory(_Add(BackupCp,6),Exactly,58)})
			NJumpX(FP,ValCancle,{TMemoryX(BackupCp,Exactly,5*256,0xFF00)})
			CTrigger(FP,{Deaths(i,AtLeast,1,65)}, -- Stop
			{TSetDeathsX(BackupCp,SetTo,1*256,0,0xFF00)},{preserved})
			CIf(FP,{Deaths(i,AtLeast,1,67)}) -- Hold
				f_Read(FP,_Sub(BackupCp,9),TempPos)
				CDoActions(FP,{TSetDeaths(_Add(BackupCp,4),SetTo,0,0),TSetDeathsX(BackupCp,SetTo,107*256,0,0xFF00),TSetDeaths(_Sub(BackupCp,13),SetTo,TempPos,0),TSetDeaths(_Add(BackupCp,3),SetTo,TempPos,0),TSetDeaths(_Sub(BackupCp,15),SetTo,TempPos,0)})
			CIfEnd()
			CIf(FP,{Deaths(i,AtLeast,1,66)}) -- Attack
				CDoActions(FP,{TSetDeaths(_Add(BackupCp,4),SetTo,0,0),TSetDeathsX(BackupCp,SetTo,14*256,0,0xFF00),TSetDeaths(_Sub(BackupCp,13),SetTo,MulCon[i+1],0),TSetDeaths(_Add(BackupCp,3),SetTo,MulCon[i+1],0),TSetDeaths(_Sub(BackupCp,15),SetTo,MulCon[i+1],0)})
			CIfEnd()
			CIf(FP,{Deaths(i,AtLeast,1,34)}) -- Heal
				CTrigger(FP, {TMemory(_Add(BackupCp,6),Exactly,MarID[i+1])}, {TSetMemory(_Sub(BackupCp,17), SetTo, MarHP[i+1])}, 1)
			CIfEnd()
			CIf(FP,{Deaths(i,AtLeast,1,70)}) -- JYD
				f_Read(FP,_Sub(BackupCp,9),TempPos)
				CDoActions(FP,{TSetDeaths(_Add(BackupCp,4),SetTo,0,0),TSetDeathsX(BackupCp,SetTo,187*256,0,0xFF00),TSetDeaths(_Sub(BackupCp,13),SetTo,TempPos,0),TSetDeaths(_Add(BackupCp,3),SetTo,TempPos,0),TSetDeaths(_Sub(BackupCp,15),SetTo,TempPos,0)})
			CIfEnd()
			NJumpXEnd(FP,ValCancle)
			f_LoadCp()
			CIfEnd()
			end
			CIfEnd()
			CAdd(FP,0x6509B0,84)
		CWhileEnd()
		CMov(FP,0x6509B0,FP)
		DoActionsX(FP,{SetDeaths(Force1,SetTo,0,71),SetDeaths(Force1,SetTo,0,64),SetDeaths(Force1,SetTo,0,65),SetDeaths(Force1,SetTo,0,66),SetDeaths(Force1,SetTo,0,67),SetDeaths(Force1,SetTo,0,70),SetDeaths(Force1,SetTo,0,34),SetCDeaths(FP,SetTo,0,CUnitFlag)})
	CIfEnd()
	local HealT = CreateCcode()
	DoActionsX(FP,{SetCDeaths(FP,Add,1,HealT)})
	CIf(FP,CDeaths(FP,AtLeast,50,HealT),SetCDeaths(FP,SetTo,0,HealT))
	for i = 0, 6 do
		Trigger2(FP,{HumanCheck(i,1)},{
			ModifyUnitHitPoints(All,MarID[1],Force1,i+2,100),
			ModifyUnitShields(All,MarID[1],Force1,i+2,100),
			ModifyUnitHitPoints(All,MarID[2],Force1,i+2,100),
			ModifyUnitShields(All,MarID[2],Force1,i+2,100),
			ModifyUnitHitPoints(All,MarID[3],Force1,i+2,100),
			ModifyUnitShields(All,MarID[3],Force1,i+2,100),
			ModifyUnitHitPoints(All,MarID[4],Force1,i+2,100),
			ModifyUnitShields(All,MarID[4],Force1,i+2,100),
			ModifyUnitHitPoints(All,MarID[5],Force1,i+2,100),
			ModifyUnitShields(All,MarID[5],Force1,i+2,100),
			ModifyUnitHitPoints(All,MarID[6],Force1,i+2,100),
			ModifyUnitShields(All,MarID[6],Force1,i+2,100),
			ModifyUnitHitPoints(All,MarID[7],Force1,i+2,100),
			ModifyUnitShields(All,MarID[7],Force1,i+2,100),
			ModifyUnitHitPoints(All,10,Force1,i+2,100),
			ModifyUnitShields(All,10,Force1,i+2,100),
			ModifyUnitHitPoints(All,7,Force1,i+2,100),
			ModifyUnitShields(All,7,Force1,i+2,100),
			ModifyUnitHitPoints(All,"Buildings",Force1,i+2,100),
			ModifyUnitShields(All,"Buildings",Force1,i+2,100)},{preserved})
	end
	CIfEnd()

--	Trigger2(FP,{Bring(FP,AtMost,0,147,64)},{ModifyUnitShields(All,"Men",Force1,64,0)},{preserved})
	CIf(FP,{CDeaths(FP,Exactly,0,isSingle),CVar(FP,InputPoint[2],AtLeast,1000)})
	CAdd(FP,OutputPoint,_Div(InputPoint,_Mov(1000)))
	f_Mod(FP,InputPoint,_Mov(1000))
	CIfEnd()
    CallTriggerX(FP,Call_ScorePrint,{CDeaths(FP,AtLeast,1,ScorePrint)},{SetCDeaths(FP,SetTo,0,ScorePrint),SetCDeaths(FP,SetTo,0,isDBossClear)})
	
	CIf(FP,{Memory(0x6284B8 ,AtLeast,1),Memory(0x6284B8 + 4,AtMost,0)}) -- 체력표기
	SelPTR,SelEPD,SelSh,SelPl,SelMaxHP,PercentCalc = CreateVariables(7)
	SelWepT =CreateVar(FP)
	SelHPV =CreateVar(FP)
	SelHPW =CreateWar(FP)
	
	CMov(FP,SelPl,0)
	CMov(FP,SelUID,0)
	CMov(FP,SelSh,0)
	f_Read(FP,0x6284B8,SelPTR,SelEPD)
	f_Read(FP,_Add(SelEPD,2),SelHPV)
	f_Read(FP,_Add(SelEPD,19),SelPl,"X",0xFF)
	f_Read(FP,_Add(SelEPD,25),SelUID,"X",0xFF)
	f_Read(FP,_Add(SelEPD,24),SelSh,"X",0xFFFFFF)
	CMov(FP,CunitIndex,_Div(_Sub(SelEPD,19025),_Mov(84)))
	CMov(FP,SelMaxHP,_ReadF(_Add(SelUID,_Mov(EPD(0x662350)))))
	f_Div(FP,SelHPV,_Mov(256))
	
	CIf(FP, {Cond_EXCC2(LHPCunit,CunitIndex,0,AtLeast,1)})
	local TempV1 = CreateVar(FP)
	local TempV2 = CreateVar(FP)
	local TempW2 = CreateWar(FP)
	local TempW3 = CreateWar(FP)
	f_Read(FP, _Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(LHPCunit[3],((0x20*1)/4))), TempV1)
	f_Read(FP, _Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(LHPCunit[3],((0x20*2)/4))), TempV2)
	f_LMov(FP, TempW2, {TempV1, TempV2}, nil,nil,1)
	f_LDiv(FP,TempW3, TempW2, _LMov(256))
	f_LMov(FP, {TempV1, TempV2}, TempW3, nil,nil,1)
	CAdd(FP,SelHPV,TempV1)
	CIfEnd()
	f_Div(FP,SelSh,_Mov(256))
	f_Div(FP,SelMaxHP,_Mov(256))
	CMov(FP,PercentCalc,_Div(_Mul(SelHPV,3),SelMaxHP))
	CIf(FP,{CV(SelUID,128)}) -- 상점 디스플레이
	PointTamp = CreateVar(FP)
	AtkExceedTemp = CreateVar(FP)
	HPExceedTemp = CreateVar(FP)
		for i = 0, 6 do
			CIf(FP,{CV(SelPl,i)})
			CTrigger(FP, {}, {TSetCVar(FP,PointTamp[2],SetTo,_Sub(OldAvStat[i+1],_Mul(UsedOldP[i+1],_Mov(P_ExcOldP))))}, 1)
			CMov(FP,AtkExceedTemp,AtkExceed[i+1])
			CMov(FP,HPExceedTemp,HPExceed[i+1])

			CIfEnd()
		end
		CS__ItoCustom(FP,SVA1(Str5,16),PointTamp,nil,nil,10,1,nil,"\x070",0x07,{0,1,2,3,4,5,6,7,8,9})
		CS__ItoCustom(FP,SVA1(Str6,16),AtkExceedTemp,nil,nil,{10,3},1,nil,"\x070",0x1D)
		CS__ItoCustom(FP,SVA1(Str7,15),HPExceedTemp,nil,nil,{10,3},1,nil,"\x070",0x1D)
		
	CS__InputVA(FP,iTbl4,0,Str5,Str5s,nil,0,Str5s)
	CS__InputVA(FP,iTbl5,0,Str6,Str6s,nil,0,Str6s)
	CS__InputVA(FP,iTbl6,0,Str7,Str7s,nil,0,Str7s)


	CIfEnd()
	CIf(FP,{CV(SelUID,111)})
	NukesTmp = CreateVar(FP)
		for i = 0, 6 do
			CTrigger(FP, CV(SelPl,i), {TSetCVar(FP,NukesTmp[2],SetTo,NukesUsage[i+1])}, 1)
		end
		CS__ItoCustom(FP,SVA1(Str4,10),NukesTmp,nil,nil,10,1,nil,"\x080",0x08,{0,1,2,3,4,5,6,7,8,9})
		--DoActionsX(FP,SetCSVA1(SVA1(Str4,Str4s-1),SetTo,0,0xFFFFFFFF))
		CS__InputVA(FP,iTbl3,0,Str4,Str4s,nil,0,Str4s)
	CIfEnd()
	DTypeArr3 ={69,30,13}
DTypeCondArr = {
	CVar(FP, SelUID, Exactly, 121),
	CVar(FP, SelUID, Exactly, 186),
	CVar(FP, SelUID, Exactly, 84),
}
for j, k in pairs(DTypeArr3) do
	table.insert(DTypeCondArr,CVar(FP, SelUID, Exactly, k))
end
	
	local CurUID = CreateVar(FP)
	CIf(FP,{TTCVar(FP, CurUID[2], NotSame, SelUID)})
	CMov(FP,CurUID,SelUID)
	CS__SetValue(FP, Str3, MakeiStrVoid(20), 0xFFFFFFFF,23)
	CIf(FP,{TMemoryX(_Add(SelUID,EPDF(0x664080)),Exactly,0x00,0x01)})
	CIf(FP,{CV(SelPl,7)})
		CIfX(FP, {TTOR(DTypeCondArr)
		})
			CS__SetValue(FP, Str3, "\x08Destroy T\x04ype", 0xFFFFFFFF,23)
		CElseX()
		local SelWepID = CreateVar(FP)
		local SelTmpUID = CreateVar(FP)
		CMov(FP,SelTmpUID,SelUID)

		TriggerX(FP,CV(SelUID,5),SetV(SelTmpUID,6),{preserved})
		TriggerX(FP,CV(SelUID,23),SetV(SelTmpUID,24),{preserved})
		TriggerX(FP,CV(SelUID,25),SetV(SelTmpUID,26),{preserved})
		TriggerX(FP,CV(SelUID,30),SetV(SelTmpUID,31),{preserved})
		TriggerX(FP,CV(SelUID,3),SetV(SelTmpUID,4),{preserved})
		TriggerX(FP,CV(SelUID,17),SetV(SelTmpUID,18),{preserved})
		CMov(FP,SelWepID,0)
		CMov(FP,SelWepID,Act_BRead(_Add(SelTmpUID,0x6636B8)))
			CIfX(FP,{TBread(_Add(SelWepID,0x657258), Exactly, 0)})--N
				CS__SetValue(FP, Str3, "\x1DNormal T\x04ype", 0xFFFFFFFF,23)
			CElseIfX({TBread(_Add(SelWepID,0x657258), Exactly, 2)})--%
				CS__SetValue(FP, Str3, "\x1FSolidity T\x04ype", 0xFFFFFFFF,23)
			CIfXEnd()

		CIfXEnd()

	CIfEnd()
	CIfEnd()
	CIfEnd()



	
	CS__ItoCustom(FP,SVA1(Str3,0),SelHPV,nil,0xFFFF0000,{10,9},1,nil,"0",nil,{0,1,2,3,4,5,6,7,8,9})
	CS__ItoCustom(FP,SVA1(Str3,0),SelSh,nil,0xFFFF0000,{10,5},1,{"\x0D","\x0D","\x0D","0","0"},nil,nil,{25-12,26-12,27-12,28-12,30-12})
	TBLN1T = {}
	TBLN2T = {}
	TBLN1T1 = {}
	TBLN1T2 = {}
	TBLN1T3 = {}
	for i = 0, 9 do
--			table.insert(TBLN1T, SetCSVA1(SVA1(Str3,i),SetTo,0x07,0xFF))
--			table.insert(TBLN2T, SetCSVA1(SVA1(Str3,i),SetTo,0x07,0xFF))
		table.insert(TBLN1T1, SetCSVA1(SVA1(Str3,i),SetTo,0x07,0xFF))
		table.insert(TBLN1T2, SetCSVA1(SVA1(Str3,i),SetTo,0x17,0xFF))
		table.insert(TBLN1T3, SetCSVA1(SVA1(Str3,i),SetTo,0x08,0xFF))
	end
	for i = 0, 3 do
		table.insert(TBLN1T, SetCSVA1(SVA1(Str3,25+i-12),SetTo,0x1C,0xFF))
		table.insert(TBLN2T, SetCSVA1(SVA1(Str3,25+i-12),SetTo,0x1F,0xFF))
	end
	table.insert(TBLN1T, SetCSVA1(SVA1(Str3,30-12),SetTo,0x1C,0xFF))
	table.insert(TBLN2T, SetCSVA1(SVA1(Str3,30-12),SetTo,0x1F,0xFF))

	TriggerX(FP,{CV(PercentCalc,2,AtLeast)},TBLN1T1,{preserved})
	TriggerX(FP,{CV(PercentCalc,1)},TBLN1T2,{preserved})
	TriggerX(FP,{CV(PercentCalc,0)},TBLN1T3,{preserved})

	DoActionsX(FP,TBLN1T)
	CS__InputVA(FP,iTbl1,0,Str3,Str3s,nil,0,Str3s)
	DoActionsX(FP,TBLN2T)
	CS__InputVA(FP,iTbl2,0,Str3,Str3s,nil,0,Str3s)

	CIfEnd()


--	CIfOnce(FP,{Memory(EvCheckPtr,AtLeast,2)})
--	DoActions(FP,{CopyCpAction({DisplayTextX("\t\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x1F！！！　ＥＶＥＮＴ　！！！\n\n\n\x13\x1F이벤트\x04가 감지되었습니다.\n\x13\x07스탯 포인트 획득량\x04이 일정배율 \x1F증가\x04하였습니다.\n\n\n\x13\x1F！！！　ＥＶＥＮＴ　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4),
--	PlayWAVX("staredit\\wav\\LimitBreak.ogg"),PlayWAVX("staredit\\wav\\LimitBreak.ogg"),},HumanPlayers,FP)})
--	CMov(FP,MulPoint,_ReadF(EvCheckPtr))
--	CIfEnd()
end