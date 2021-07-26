function PlayerInterface()
	local MarCreate = Create_CCTable(7)
	local MarCreate2 = Create_CCTable(7)
	local AtkFactorV = Create_VTable(7,AtkFactor)
	local DefFactorV = Create_VTable(7,DefFactor)
	local AtkFactorV2 = Create_VTable(7)
	local DefFactorV2 = Create_VTable(7)
	local MarHP = Create_VTable(7)
	local MarHP2 = Create_VTable(7)
	local DefUpCompCount = Create_VTable(7)
	local AtkUpCompCount = Create_VTable(7)
	local CurrentHP = Create_VTable(7)
	local MarMaxHP = Create_VTable(7,2000*256)
	local AtkUpgradeMaskRetArr,AtkUpgradePtrArr,NormalUpgradeMaskRetArr,
	NormalUpgradePtrArr,DefUpgradeMaskRetArr,DefUpgradePtrArr,AtkFactorMaskRetArr,
	AtkFactorPtrArr,DefFactorMaskRetArr,DefFactorPtrArr,MarShMaskRetArr,MarShPtrArr = CreateTables(12)
	local SelPTR,SelEPD,SelHP,SelSh,SelPl,SelMaxHP = CreateVariables(6)
	local SelUID = CreateVar(FP)
	local BarRally = CreateVar(FP)
	local ExchangeP = CreateVar(FP)
	local MarTempSh = CreateVar(FP)
	local DelayMedic = Create_CCTable(7)
	local ShUsed = Create_CCTable(7)
	local GiveRate = Create_CCTable(7)
	
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
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				DisplayText("\x07『 \x04당신은 강되당했습니다.\x07 』",4);
				Defeat();
				},
			}
		end
		
		
		TriggerX(i,{CVar(FP,AtkUpCompCount[i+1][2],AtLeast,10)},{
				DisplayText(string.rep("\n", 20),4);
				DisplayText("\x13\x04"..string.rep("―", 56),4);
				DisplayText("\x13\x0FＳＫＩＬＬ　ＵＮＬＯＣＫＥＤ",0);
				DisplayText("\n",4);
				DisplayText("\x13\x03공격력 \x04업그레이드를 10회 완료하였습니다.\n\x13\x04이제부터 \x1B원격 스팀팩\x04을 사용할 수 있습니다.",0);
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
		
		TriggerX(FP,{Deaths(i,AtLeast,1,CPConsole),Memory(0x57F1B0,Exactly,i)},{
			print_utf8(12,0,"\x07[ \x1F기부모드 ON. \x04숫자키를 눌러 기부하세요. 기부단위변경 : ~키, ESC : 닫기\x07 ]")
		},{Preserved}) -- 13번줄 프린트 트리거 플레이어가 FP인 이유는 트리거 순서가 1P부터 8P까지 실행되기 때문. i로 하게될 경우 이게 씹히고 위에있는 CText가 보이게 된다. 
		
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

			Trigger2(i,{Deaths(i,Exactly,0,444);Command(i,AtLeast,1,70);},{
				GiveUnits(All,70,i,"Anywhere",P12);
				RemoveUnitAt(All,70,"Anywhere",P12);
				DisplayText("\x07『 \x1Dhatchery \x1CBGM\x04을 변경합니다 (\x0F검열버전\x04). \x07』",4);
				SetDeaths(i,SetTo,1,444);
			},{Preserved})
			
			Trigger2(i,{Deaths(i,Exactly,1,444);Command(i,AtLeast,1,70);},{
				GiveUnits(All,70,i,"Anywhere",P12);
				RemoveUnitAt(All,70,"Anywhere",P12);
				DisplayText("\x07『 \x1Dhatchery \x1CBGM\x04을 변경합니다 (\x0F기존버전\x04). \x07』",4);
				SetDeaths(i,SetTo,0,444);
			},{Preserved})

		UnitLimit(i,7,5,"SCV는",500)
		UnitLimit(i,125,8,"벙커는",8000)
		UnitLimit(i,124,15,"터렛은",4000)
		




		CIfX(FP,PlayerCheck(i,1)) -- FP가 관리하는 시스템 부분 트리거. 각플레이어가 있을경우 실행된다.
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
			f_Read(FP,_Add(BarrackPtr[i+1],62),BarRally)
			DoActions(FP,CreateUnitWithProperties(1,MarID[i+1],2+i,i,{energy = 100}))
			CIf(FP,{TTCVar(FP,BarPos[i+1][2],NotSame,BarRally),CVar(FP,BarRally[2],AtLeast,1),TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
				CDoActions(FP,{TSetDeathsX(_Add(Nextptrs,19),SetTo,6*256,0,0xFF00),
				TSetDeaths(_Add(Nextptrs,22),SetTo,BarRally,0)})
			CIfEnd()
			CMov(FP,0x6509B0,FP)
		CIfEnd()
		
		CIf(FP,{CDeaths(FP,AtLeast,1,MarCreate2[i+1]),Memory(0x628438,AtLeast,1)},SetCDeaths(FP,Subtract,1,MarCreate2[i+1]))
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			f_Read(FP,_Add(BarrackPtr[i+1],62),BarRally)
			DoActions(FP,CreateUnitWithProperties(1,10,2+i,i,{energy = 100}))
			CIf(FP,{TTCVar(FP,BarPos[i+1][2],NotSame,BarRally),CVar(FP,BarRally[2],AtLeast,1),TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
				CDoActions(FP,{TSetDeathsX(_Add(Nextptrs,19),SetTo,6*256,0,0xFF00),
				TSetDeaths(_Add(Nextptrs,22),SetTo,BarRally,0)})
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
						ModifyUnitShields(All,"Buildings",i,"Anywhere",100),
					})
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
			PlayWAV("staredit\\wav\\LimitBreak.ogg"),PlayWAV("staredit\\wav\\LimitBreak.ogg"),PlayWAV("staredit\\wav\\LimitBreak.ogg"),PlayWAV("staredit\\wav\\LimitBreak.ogg"),
			SetMemory(0x6509B0,SetTo,FP),
			SetMemoryW(0x656EB0 + (MarWep[i+1]*2),Add,MarDamageFactor*255),
			SetCVar(FP,AtkUpCompCount[i+1][2],Add,1),
		})
		TriggerX(FP,{CVar(FP,AtkUpCompCount[i+1][2],AtLeast,151)},{SetCVar(FP,AtkFactorV[i+1][2],Add,1)},{Preserved})
		CIfEnd()
		
		CIf(FP,{MemoryX(DefUpgradePtrArr[i+1],AtLeast,255*(256^DefUpgradeMaskRetArr[i+1]),255*(256^DefUpgradeMaskRetArr[i+1]))},{SetMemoryX(DefUpgradePtrArr[i+1],SetTo,0*(256^DefUpgradeMaskRetArr[i+1]),255*(256^DefUpgradeMaskRetArr[i+1]))})
		DoActionsX(FP,{
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x13\x04！！！　\x08체력 업그레이드\x04가 255를 넘어 한계를 돌파합니다.\x04　！！！\n\x13\x04！！！　\x07업그레이드를 \x040으로 재설정하고 \x17체력 수치가 전승\x04되었습니다.\x04　！！！",4),
			PlayWAV("staredit\\wav\\LimitBreak.ogg"),PlayWAV("staredit\\wav\\LimitBreak.ogg"),PlayWAV("staredit\\wav\\LimitBreak.ogg"),PlayWAV("staredit\\wav\\LimitBreak.ogg"),
			SetMemory(0x6509B0,SetTo,FP),
			--SetCVar(FP,DefFactorV[i+1][2],Add,1),
			SetCVar(FP,MarMaxHP[i+1][2],Add,2000*256),
			SetCVar(FP,DefUpCompCount[i+1][2],Add,1),
		})
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
		TriggerX(FP,{MemoryW(0x656EB0 + (MarWep[i+1]*2),AtLeast,65535-(MarDamageFactor*255))},{SetMemoryB(0x58D088 + (i * 46) + i,SetTo,0),SetMemoryB(0x58D088 + (i * 46) + 17,SetTo,0),SetMemoryB(0x58D088 + (i * 46) + 18,SetTo,0),
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
		
		ExC_Cond = def_sIndex()
		NJump(FP,ExC_Cond,{Bring(i,AtMost,0,"Men",9)})
		CIf(FP,Score(i,Kills,AtLeast,1000))
			CMov(FP,ExchangeP,_Div(_ReadF(0x581F04+(i*4)),_Mov(1000)))
			CAdd(FP,{FP,ExScore[i+1][2],nil,"V"},_Div(_ReadF(0x581F04+(i*4)),_Mov(1000)))
			CMov(FP,0x581F04+(i*4),_Mod(_ReadF(0x581F04+(i*4)),_Mov(1000)))
			CAdd(FP,0x57F0F0+(i*4),_Mul(_Mul(ExchangeP,_Mov(10)),{FP,ExchangeRate[2],nil,"V"}))
			CMov(FP,ExchangeP,0)
		CIfEnd()
		DoActions(FP,SetDeaths(i,Subtract,1,111))
		NJumpEnd(FP,ExC_Cond)

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
					PreserveTrigger();
				},
			}
		CElseX()
			DoActions(FP,{SetMemoryW(0x660E00 + (MarID[i+1]*2),SetTo,1000)})
		CIfXEnd()

		CIf(FP,CDeaths(FP,AtLeast,1,PExitFlag),SetCDeaths(FP,Subtract,1,PExitFlag))
			CMov(FP,0x5821D4 + (4*i),_Div(MarNumberLimit,PCheckV),24*2)
			CMov(FP,0x582234 + (4*i),_Div(MarNumberLimit,PCheckV),24*2)
		CIfEnd()
		CElseX()
			DoActions(FP,{SetDeaths(i,SetTo,0,440)}) -- 각플레이어가 존재하지 않을 경우 각플레이어의 브금타이머 0으로 고정 
			TriggerX(FP,{Deaths(i,AtLeast,1,227)},{SetDeaths(i,SetTo,0,227),SetCDeaths(FP,Add,100,PExitFlag)}) -- 나갔을 경우 1회에 한해 인구수 계산기 작동
		CIfXEnd()
	end
	CIf(FP,Deaths(Force1,AtLeast,1,71)) -- 원격스팀
		CMov(FP,0x6509B0,19025+19)
		CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
			for i = 0, 6 do
				Trigger {
					players = {FP},
					conditions = {
						DeathsX(CurrentPlayer,Exactly,i,0,0xFF);
						Deaths(i,AtLeast,1,71);
					},
					actions = {
						MoveCp(Add,50*4);
						SetDeathsX(CurrentPlayer,SetTo,255*256,0,0xFF00);
						MoveCp(Subtract,50*4);
						PreserveTrigger();
					}
				}
			end
			CAdd(FP,0x6509B0,84)
		CWhileEnd()
		CMov(FP,0x6509B0,FP)
		DoActions(FP,SetDeaths(Force1,SetTo,0,71))
	CIfEnd()
	local HealT = CreateCCode()
	DoActionsX(FP,{SetCDeaths(FP,Add,1,IntroT),SetCDeaths(FP,Add,1,HealT)})
	CIf(FP,CDeaths(FP,AtLeast,50,HealT),SetCDeaths(FP,SetTo,0,HealT))
	for i = 0, 6 do
		Trigger2(FP,{PlayerCheck(i,1)},{ModifyUnitHitPoints(All,"Men",i,i+2,100),ModifyUnitHitPoints(All,"Buildings",i,i+2,100),ModifyUnitShields(All,"Men",i,i+2,100),ModifyUnitShields(All,"Buildings",i,i+2,100)},{Preserved})
	end
	CIfEnd()
--	Trigger2(FP,{Bring(FP,AtMost,0,147,64)},{ModifyUnitShields(All,"Men",Force1,64,0)},{Preserved})
	
	
	CIf(FP,CVar(FP,InputPoint[2],AtLeast,1000))
	CAdd(FP,OutputPoint,_Div(InputPoint,_Mov(1000)))
	f_Mod(FP,InputPoint,_Mov(1000))
	CIfEnd()
    CallTriggerX(FP,Call_ScorePrint,{CDeaths(FP,AtLeast,1,ScorePrint)},{SetCDeaths(FP,SetTo,0,ScorePrint),SetCDeaths(FP,SetTo,0,isDBossClear)})
end