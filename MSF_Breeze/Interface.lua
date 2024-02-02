function Interface()


	local DelayMedic = CreateCcodeArr(7)
	local GiveRate = CreateCcodeArr(7)
	local BanCode = CreateCcodeArr(6)
	local CurrentOP = CreateVar(FP)
	function Install_UnitCount(Player)
		count,count1,count2,count3,count4,count5 = CreateVars(6,FP)
			UnitReadX(Player,AllPlayers,229,64,count)
			UnitReadX(Player,AllPlayers,17,nil,count1)
			UnitReadX(Player,AllPlayers,23,nil,count2)
			UnitReadX(Player,AllPlayers,25,nil,count3)
			UnitReadX(Player,AllPlayers,73,nil,count4)
			UnitReadX(Player,AllPlayers,65,nil,count5)
			CAdd(FP,count,count1)
			CAdd(FP,count,count2)
			CAdd(FP,count,count3)
			CAdd(FP,count,count4)
			CAdd(FP,count,count5)
	end
	Install_UnitCount(FP)
	
	Dt = IBGM_EPD(FP, {P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12}, BGMType, {
		{1,"staredit\\wav\\BrOP.ogg",188*1000},
		{2,{"staredit\\wav\\BGM1_1.ogg","staredit\\wav\\BGM1_2.ogg"},45*1000},
		{3,{"staredit\\wav\\BGM2_1.ogg","staredit\\wav\\BGM2_2.ogg"},45*1000},
		{4,{"staredit\\wav\\BGM3_1.ogg","staredit\\wav\\BGM3_2.ogg"},42*1000},
		{5,"staredit\\wav\\MB.ogg",37*1000},
	})
	if TestStart == 1 then
		DoActionsX(FP, {SetAllianceStatus(AllPlayers, Ally),
		SetMemoryX(0x581DDC,SetTo,128*256,0xFF00); --P8 미니맵
		SetMemoryX(0x581DAC,SetTo,128*65536,0xFF0000), --P8컬러
	},1)
	else
		DoActionsX(FP, {SetAllianceStatus(AllPlayers, Ally),
		SetMemoryX(0x581DDC,SetTo,128*256,0xFF00); --P8 미니맵
		SetMemoryX(0x581DAC,SetTo,128*65536,0xFF0000), --P8컬러
	},1)
	end
	GS = CreateCcode()
	TriggerX(Force1, {CD(GS,1)}, {
		SetAllianceStatus(P12,Enemy),--P12 적으로
		SetAllianceStatus(FP,Enemy),--FP 적으로
		SetAllianceStatus(Force1,Ally),--FP 적으로
	}, {preserved})
	TriggerX(FP, {CD(GS,1)}, {
		SetAllianceStatus(Force1,Enemy),--FP 적으로
	}, {preserved})
	OPCcode = CreateCcode()
	DoActionsX(FP, {AddCD(OPCcode,1)})
--	Trigger2X(FP,{CD(OPCcode,150,AtLeast)},{RotatePlayer({PlayWAVX("staredit\\wav\\Computer Beep.wav"),DisplayTextX(StrDesignX("\x08아니근데 들판에 저그들이 왜이렇게 많아???"))}, HumanPlayers, FP)})
--	Trigger2X(FP,{CD(OPCcode,300,AtLeast)},{RotatePlayer({PlayWAVX("staredit\\wav\\Computer Beep.wav"),DisplayTextX(StrDesignX("\x04마린들은 결심했다. 얼른 이 \x08저그놈들의 머리통을 날려버리고 집으로 돌아가자고!"))}, HumanPlayers, FP)})
--	Trigger2X(FP,{CD(OPCcode,450,AtLeast)},{RotatePlayer({PlayWAVX("sound\\Misc\\TRescue.wav"),DisplayTextX(StrDesignX("\x04승리 조건 : 모든 저그를 처치하고 6시의 초월체를 파괴하세요."))}, HumanPlayers, FP)})
	if Limit == 1 then
		DoActions2X(FP,{RotatePlayer({DisplayTextX(StrDesignX("\x04현재 "..#G_CAPlot_Shape_InputTable.."개의 도형 데이터가 입력되었습니다."),4)},HumanPlayers,FP)},1)
		Trigger2X(FP,{},{RotatePlayer({DisplayTextX("\x13\x04현재 \x07테스트 버전\x04을 이용중입니다.\n\x13\x07테스트에 협조해주셔서 감사합니다. \n\x13\x04테스트맵 이용 가능 기간은 "..T_YY.."년 "..T_MM.."월 "..T_DD.."일 "..T_HH.."시 까지입니다."),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,FP)})
	end
Cunit2 = CreateVar(FP)
CIfX(FP,Never()) -- 상위플레이어 단락 시작
	for i = 0, 6 do
        CElseIfX(HumanCheck(i,1),{SetCVar(FP,CurrentOP[2],SetTo,i),GiveUnits(All, 115,AllPlayers, 64, i),GiveUnits(All, 15, AllPlayers, 64, i)})
		if Limit == 1 then
			
			f_Read(FP,0x6284E8+(0x30*i),"X",Cunit2)
		end

	end
    CIfXEnd()


	GST2 = CreateCcode()
	CIf(FP,{CD(GS,0)},{AddCD(GST2,1)})--MoveUnit(All, 0, Force1, 64, 46),MoveUnit(All, 20, Force1, 64, 46)
	GST = CreateCcode()
	CDoActions(FP, {TCreateUnit(1, 15, 59, CurrentOP)},1)
	TriggerX(FP, {Bring(AllPlayers, AtMost, 0, 15, 59)}, {MoveUnit(All, 15, AllPlayers, 64, 59)},{preserved})
	TriggerX(FP,{CD(GST2,600,AtLeast)},{MoveUnit(All, 15, AllPlayers, 64, 58)},{preserved})
	DoActions2(FP, {RotatePlayer({CenterView(59)}, HumanPlayers, FP)})
	DoActions2(FP, {RotatePlayer({DisplayTextX(StrDesignX("\x04난이도를 선택해 주십시오.").."\n"..StrDesignX("\x04- \x03난이도 설명 \x04-"), 4)}, HumanPlayers, FP)},1)
	DoActions2(FP, {RotatePlayer({DisplayTextX(StrDesignX("\x04노말 : 이전 버전의 난이도와 같습니다."), 4)}, HumanPlayers, FP)},1)
	DoActions2(FP, {RotatePlayer({DisplayTextX(StrDesignX("\x11프로페셔널 \x04: 더 어려워졌으나 공격력 최대 업글 가능 횟수 상승됩니다."), 4)}, HumanPlayers, FP)},1)
	Trigger2X(FP, {Bring(AllPlayers, AtLeast, 1, 15, 58)}, {RotatePlayer({DisplayTextX(StrDesignX("\x04노말 난이도가 선택되었습니다."), 4),PlayWAVX("staredit\\wav\\GameStart.ogg"),PlayWAVX("staredit\\wav\\GameStart.ogg"),PlayWAVX("staredit\\wav\\GameStart.ogg")}, HumanPlayers, FP),SetCD(GST,1),RemoveUnit(15, AllPlayers)})
	Trigger2X(FP, {Bring(AllPlayers, AtLeast, 1, 15, 57)}, {SetCD(GST,1),SetCD(GMode,1),--SetV(ExRate,11),
		SetMemoryB(0x58D088+(46*0)+7,SetTo,150),
		SetMemoryB(0x58D088+(46*1)+7,SetTo,150),
		SetMemoryB(0x58D088+(46*2)+7,SetTo,150),
		SetMemoryB(0x58D088+(46*3)+7,SetTo,150),
		SetMemoryB(0x58D088+(46*4)+7,SetTo,150),
		SetMemoryB(0x58D088+(46*5)+7,SetTo,150),
		SetMemoryB(0x58D088+(46*6)+7,SetTo,150),
		SetMemoryB(0x58D088+(46*0)+0,SetTo,0),
		SetMemoryB(0x58D088+(46*1)+0,SetTo,0),
		SetMemoryB(0x58D088+(46*2)+0,SetTo,0),
		SetMemoryB(0x58D088+(46*3)+0,SetTo,0),
		SetMemoryB(0x58D088+(46*4)+0,SetTo,0),
		SetMemoryB(0x58D088+(46*5)+0,SetTo,0),
		SetMemoryB(0x58D088+(46*6)+0,SetTo,0),
		SetDeaths(Force1, SetTo, 1, 49);
		SetMemoryX(0x664080 + (86*4),SetTo,0x400200,0x400200),
		SetMemoryX(0x664080 + (98*4),SetTo,0x400200,0x400200),
		PatchInsert(SetMemory(0x657470+(86 *4),SetTo,32*3)), -- 사거리 최대
		PatchInsert(SetMemory(0x657470+(117 *4),SetTo,32)), -- 사거리 최대
		PatchInsert(SetMemoryW(0x656EB0+(25 *2),SetTo,750)), -- 공격력
		RotatePlayer({DisplayTextX(StrDesignX("\x11프로페셔널 난이도가 선택되었습니다."), 4),PlayWAVX("staredit\\wav\\GameStart.ogg"),PlayWAVX("staredit\\wav\\GameStart.ogg"),PlayWAVX("staredit\\wav\\GameStart.ogg")}, HumanPlayers, FP),RemoveUnit(15, AllPlayers)})
	TriggerX(FP, {CD(GST,1,AtLeast)},{AddCD(GST,1)},{preserved})
	TriggerX(FP, {CD(GST,100,AtLeast)},{SetCD(GS,1)},{preserved})
	CIfEnd()


	CIfOnce(FP,{CD(GS,1)},{SetV(BGMType,1),SetCp(FP),KillUnit(72, P12),KillUnit(84, P12),RunAIScriptAt("Expansion Zerg Campaign Insane","AI"),RunAIScriptAt("Value This Area Higher",2),SetResources(Force1, Add, 25000, Ore),RemoveUnit(15, AllPlayers),RemoveUnit(195, AllPlayers),RemoveUnit(196, AllPlayers)})
	DoActions2(FP, {RotatePlayer({CenterView(2)}, HumanPlayers, FP)})
	Shape1000 = {3   ,{1440, 352},{1440, 320},{1440, 288}}
	Shape2000 = {3   ,{1472, 352},{1472, 320},{1472, 288}}
	Shape3000 = {3   ,{1504, 352},{1504, 320},{1504, 288}}
	Shape4000 = {3   ,{1536, 352},{1536, 320},{1536, 288}}
	Shape5000 = {3   ,{1568, 352},{1568, 320},{1568, 288}}
	Shape6000 = {3   ,{1600, 352},{1600, 320},{1600, 288}}
	Shape7000 = {3   ,{1632, 352},{1632, 320},{1632, 288}}
	Shape1020 = {1   ,{1440, 384}}
	Shape2020 = {1   ,{1472, 384}}
	Shape3020 = {1   ,{1504, 384}}
	Shape4020 = {1   ,{1536, 384}}
	Shape5020 = {1   ,{1568, 384}}
	Shape6020 = {1   ,{1600, 384}}
	Shape7020 = {1   ,{1632, 384}}
	NMT = {
		Shape1000,
		Shape2000,
		Shape3000,
		Shape4000,
		Shape5000,
		Shape6000,
		Shape7000
	}
	HMT = {
		Shape1020,
		Shape2020,
		Shape3020,
		Shape4020,
		Shape5020,
		Shape6020,
		Shape7020
	}
	for i = 0, 6 do
		CSPlot(NMT[i+1], i, 0, 0, {0,0}, 1, 32, FP, {HumanCheck(i,1)})
		CSPlot(HMT[i+1], i, 20, 0, {0,0}, 1, 32, FP, {HumanCheck(i,1)})
	end
	Trigger2X(FP,{},{RotatePlayer({PlayWAVX("sound\\Misc\\TRescue.wav"),PlayWAVX("staredit\\wav\\Computer Beep.wav"),DisplayTextX("\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04\n\x13\x04\n\x13\x04마린키우기 \x03산들바람 \x08지옥\n\x13\x04\n\x13\x03Creator \x04: GALAXY_BURST\n\x13\x04\n\x13\x042024 "..VerText.." \n\x13\x04\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――")}, HumanPlayers, FP)})
	Trigger2X(FP, {CV(SetPlayers,1)},{SetResources(Force1, Add, 30000, Ore),CreateUnit(2, 20, 2, Force1),RotatePlayer({DisplayTextX(StrDesignX("솔로 플레이 보너스 \x04: \x1F30000 ore \x04+ \x03영웅마린 2기"), 4)}, HumanPlayers, FP)})
	CIf(FP,{CD(GMode,1)})
		CFor(FP,19025,19025+(84*1700),84)
			CI = CForVariable()
			CTrigger(FP, {TTOR({
				_TMemoryX(_Add(CI,25), Exactly, 150,0xFF),
				_TMemoryX(_Add(CI,25), Exactly, 148,0xFF),
				_TMemoryX(_Add(CI,25), Exactly, 86,0xFF),
				_TMemoryX(_Add(CI,25), Exactly, 98,0xFF),
				_TMemoryX(_Add(CI,25), Exactly, 147,0xFF),
				
			})}, {
				TSetMemoryX(_Add(CI,55), SetTo, 0x100,0x100),
				TSetMemoryX(_Add(CI,57), SetTo, 0,0xFF),
			}, {preserved})
		CForEnd()
	CIfEnd()
	CIfEnd()
	TriggerX(FP, {CD(GMode,1)}, {
		ModifyUnitEnergy(All, 144, FP, 14, 0),
		ModifyUnitEnergy(All, 144, FP, 15, 0),
		ModifyUnitEnergy(All, 144, FP, 16, 0),
		ModifyUnitEnergy(All, 144, FP, 17, 0),
		ModifyUnitEnergy(All, 144, FP, 75, 0),
		ModifyUnitEnergy(All, 146, FP, 14, 0),
		ModifyUnitEnergy(All, 146, FP, 15, 0),
		ModifyUnitEnergy(All, 146, FP, 16, 0),
		ModifyUnitEnergy(All, 146, FP, 17, 0),
		ModifyUnitEnergy(All, 146, FP, 75, 0),
	}, {preserved})
	
	
	if Limit == 1 then
		CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
		TriggerX(FP,{ElapsedTime(20, AtMost),Switch("Switch 253",Set),Deaths(CurrentPlayer,AtLeast,1,199)},{SetCD(TestMode,1),SetSwitch("Switch 254",Set),SetMemory(0x657A9C,SetTo,31),SetDeaths(CurrentPlayer, SetTo, 0, 199)})
		CIf(FP,CD(TestMode,1)) -- 테스트 트리거

		
	for i = 0, 1699 do
		TriggerX(FP,{ -- 테스트모드 무한스팀
			DeathsX(EPDF(0x628298-0x150*i+(25*4)),Exactly,20,0,0xFF); -- EPD 35 Unused 0x8C
		},
		{
			SetDeathsX(EPDF(0x628298-0x150*i+(69*4)),SetTo,255*256,0,0xFF00); -- \
		},{preserved})
		end
		
		CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
		CIfOnce(FP,Deaths(CurrentPlayer,AtLeast,1,208))
		CMov(FP,0x6509B0,19025+9) --CUnit 시작지점 +19 (0x4C)
		CWhile(FP,Memory(0x6509B0,AtMost,19025+9 + (84*1699)),{SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF0000),SetMemory(0x6509b0,Add,84)})
		CWhileEnd()
		CMov(FP,0x6509B0,FP)
		CIfEnd()
	
			Trigger {
				players = {FP},
				conditions = {
					Label(0);
					Deaths(CurrentPlayer,AtLeast,1,204);
				},
				actions = {
					KillUnit("Men",Force2);
					KillUnit(143,Force2);
					KillUnit(144,Force2);
					KillUnit(146,Force2);
					PreserveTrigger();
				}
				}
			TestUPtr = CreateVar(FP)
			CTrigger(FP,{Deaths(CurrentPlayer,AtLeast,1,199)},{TCreateUnit(12, 20, _Add(CurrentOP,65), CurrentOP)},{preserved})
			--CTrigger(FP,{Deaths(CurrentPlayer,AtLeast,1,199)},{SetV(TestUPtr,Cunit2)},{preserved})
			--CIf(FP,{CVar(FP,TestUPtr[2],AtLeast,1),CVar(FP,TestUPtr[2],AtMost,0x7FFFFFFF)})
			--	CDoActions(FP,{TSetMemoryX(_Add(CurrentOP,EPD(0x57f120)),SetTo,_Div(_Read(_Add(TestUPtr,19)),256),0xFF)})
			--CIfEnd()
	
			CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
			CIf(FP,{CVar(FP,Cunit2[2],AtLeast,1),CVar(FP,Cunit2[2],AtMost,0x7FFFFFFF)})
				CIf(FP,{Deaths(CurrentPlayer,AtLeast,1,207)})
					CMov(FP,0x6509B0,Cunit2,25)
					CTrigger(FP,{TTDeathsX(CurrentPlayer,NotSame,58,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,111,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,107,0,0xFF)},{
						MoveCp(Add,15*4);
						--SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF000000);
						MoveCp(Subtract,21*4);
						SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
						MoveCp(Add,6*4);
					},1)
				CIfEnd()
	
				CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
				CIf(FP,{Deaths(CurrentPlayer,AtLeast,1,203)})
					CMov(FP,0x6509B0,Cunit2,25)
					f_SaveCp()
					TestUID = CreateVar(FP)
					TestP = CreateVar(FP)
					f_Read(FP,BackupCp,TestUID,nil,0xFF,1)
					f_Read(FP,_Sub(BackupCp,6),TestP,nil,0xFF,1)
					CDoActions(FP,{TSetMemory(_Add(_Mul(TestUID,12),TestP),Add,1)})
					f_LoadCp()
					CTrigger(FP,{TTDeathsX(CurrentPlayer,NotSame,58,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,111,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,107,0,0xFF)},{
						MoveCp(Subtract,6*4);
						SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
						MoveCp(Add,6*4);
					},1)
				CIfEnd()
				
				CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
				CMov(FP,0x6509B0,Cunit2,19)
				f_SaveCp()
				CDoActions(FP,{TSetMemoryX(_Add(Cunit2,35),SetTo,_Mul(_Read(BackupCp),65536),0xFF000000)})
				f_LoadCp()
	
			CIfEnd()
		CIfEnd()
	
		CMov(FP,0x6509B0,FP)--상위플레이어 단락
				end






for i = 1, 6 do -- 강퇴기능
	Trigger { -- 강퇴토큰
		players = {FP},
		conditions = {
			Label(0);
			Command(Force1,AtLeast,1,BanToken[i]);
		},
		actions = {
			RemoveUnitAt(1,BanToken[i],"Anywhere",Force1);
			SetCDeaths(FP,Add,1,BanCode[i]);
			PreserveTrigger();
			},
		}
		for j = 1, 4 do
			Trigger { -- 강퇴토큰
				players = {i},
				conditions = {
					Label(0);
					CDeaths(FP,Exactly,j,BanCode[i]);
				},
				actions = {
					RotatePlayer({DisplayTextX("\x07『 "..PlayerString[i+1].."\x04에게 \x08경고가 총 "..j.."회 누적\x04 되었습니다. 총 5회 누적시 \x08강퇴 처리 \x04됩니다. \x07』",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i);
					},
				}
		end
		Trigger { -- 강퇴
		players = {i},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,5,BanCode[i]);
		},
		actions = {
			RotatePlayer({DisplayTextX("\x07『 \x04"..PlayerString[i+1].."\x04의 강퇴처리가 완료되었습니다.\x07 』",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i);
			},
		}
		Trigger { -- 강퇴 드랍
			players = {i},
			conditions = {
				Label(0);
				CDeaths(FP,AtLeast,5,BanCode[i]);Memory(0x57F1B0, Exactly, i)
				
			},
			actions = {
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
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
				SetMemory(0xCDDDCDDC,SetTo,1);
				
				},
			}
			
		
		end
		BanCode2 = CreateCcodeArr(7)
	local ExchangeP = CreateVar(FP)
	MacroWarn = "\x13\x04\n\x0D\x0D\x13\x04！！！　\x08ＷＡＲＮＩＮＧ\x04　！！！\n\x14\n\x14\n"..StrDesignX("\x08매크로 또는 핵이 감지되었습니다.").."\n"..StrDesignX("\x08패널티로 모든 미네랄, 유닛 몰수, 무한 찌릿찌릿이 제공됩니다.").."\n\n\x14\n\x0D\x0D\x13\x04！！！　\x08ＷＡＲＮＩＮＧ\x04　！！！\n\x0D\x0D\x13\x04"
	for i = 0, 6 do
		CreatingUnit = CreateVar(FP)
		CreatingUID = CreateVar(FP)
		CreatingUnitHP = CreateVar(FP)
		CIf(FP,HumanCheck(i,1),{ModifyUnitEnergy(All, "Any unit", i, 64, 100)})
		
		
		CIf(FP,{CV(BarPos[i+1],19025,AtLeast),CV(BarPos[i+1],19025+(84*1699),AtMost)})
		CIf(FP,{TMemory(_Add(BarPos[i+1],59), AtLeast, 1)})
		f_Read(FP,_Add(BarPos[i+1],59), nil, CreatingUnit,nil, 1)
		f_Read(FP, _Add(CreatingUnit,25), CreatingUID)
		f_Read(FP, _Add(CreatingUID,EPD(0x662350)), CreatingUnitHP)
		CDoActions(FP, {TSetMemory(_Add(CreatingUnit,2), SetTo, CreatingUnitHP)})
		--DisplayPrint(HumanPlayers, {"BarPos : ",BarPos[i+1],"   CreatingUnit : ",CreatingUnit,"   CreatingUID : ",CreatingUID,"   CreatingUnitHP : ",CreatingUnitHP})
		CIfEnd()
		CIfEnd()
		GetLocCenter(64+i, CPosX, CPosY)
		CIf(FP,{TTOR({_TTCVar(FP,CPosX[2],NotSame,2),_TTCVar(FP,CPosY[2],NotSame,2)})})
		
			--CNeg(FP,CPosX)
			--CAdd(FP,CPosX,96*32)

		CTrigger(FP, {}, {SetV(PPosY[i+1],CPosY)}, {preserved})
		CTrigger(FP, {}, {SetV(PPosX[i+1],CPosX)}, {preserved})
		CIfEnd()
		
		
		
		if Limit == 1 then
			CIf(FP,CD(TestMode,1))
				DisplayPrint(i, {"\x13\x04X : ",PPosX[i+1],"   Y : ",PPosY[i+1]}, 3)
			CIfEnd()
			--TriggerX(FP,{CD(TestMode,1)},{SetInvincibility(Enable, "Buildings", FP, 64)},{preserved})--SetV(CurEXP,0x7FFFFFFF)
			TriggerX(FP,{CD(TestMode,1)},{SetMemoryB(0x58D2B0+7+(i*46),SetTo,100),SetMemoryB(0x58D2B0+(i*46),SetTo,50)})--SetV(CurEXP,0x7FFFFFFF)
			TriggerX(FP,{CD(TestMode,1),CD(GMode,1)},{SetMemoryB(0x58D2B0+7+(i*46),SetTo,150),SetMemoryB(0x58D2B0+(i*46),SetTo,0)})--SetV(CurEXP,0x7FFFFFFF)
		end

		TriggerX(FP, {ElapsedTime(AtLeast, 10),Deaths(i,AtLeast,1,140)},{SetCD(BanCode2[i+1],1)})
		TriggerX(FP, {CD(BanCode2[i+1],1)}, {
			SetMemory(0x59CC78, SetTo, -1048576),
			SetMemory(0x59CC80, SetTo, 2),SetCp(i),PlayWAV("staredit\\wav\\zzirizziri.ogg"),PlayWAV("staredit\\wav\\zzirizziri.ogg"),DisplayText(MacroWarn, 4),SetCp(FP),SetResources(i, SetTo, 0, Ore),ModifyUnitEnergy(All, "Men", i, 64, 0),ModifyUnitEnergy(All, "Buildings", i, 64, 0),RemoveUnit("Men", i),RemoveUnit(203, i),RemoveUnit(125, i)},{preserved})
	
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				LocalPlayerID(i);
				CD(BanCode2[i+1],1)
			},
			actions = {
				SetCtrigX("X",0xFFFD,0x4,0,SetTo,"X",0xFFFD,0x0,0,1);
			},
			flag = {preserved}
		}
		Trigger2X(FP,{CDeaths(FP,AtLeast,1,BanCode2[i+1]);},{RotatePlayer({DisplayTextX(StrDesign("\x04"..PlayerString[i+1].."\x04가 매크로를 사용하여 \x08찌리리릿 500배 \x04당하셨습니다."),4),PlayWAVX("staredit\\wav\\zzirizziri.ogg"),PlayWAVX("staredit\\wav\\zzirizziri.ogg")},HumanPlayers,FP);})

			CMov(FP,0x582174+(4*i),count)
			CAdd(FP,0x582174+(4*i),count)
		ExJump = def_sIndex()--주석화 : 자동환전
		--NJump(FP,ExJump,{Deaths(i,AtMost,0,111),Bring(i,AtMost,0,"Men",3),Bring(i,AtMost,0,"Men",4)})
		CIf(FP,{CDeaths(FP,AtMost,0,BanCode2[i+1]),Score(i,Kills,AtLeast,1000)})
		CMov(FP,ExchangeP,_Div(_ReadF(0x581F04+(i*4)),_Mov(1000)))
		CMov(FP,0x581F04+(i*4),_Mod(_ReadF(0x581F04+(i*4)),_Mov(1000)))
		CAdd(FP,0x57F0F0+(i*4),_Mul(_Mul(ExchangeP,_Mov(10)),ExRate))--노말 13% 프로페셔널 20%

		CMov(FP,ExchangeP,0)
		CIfEnd()
		DoActions(FP,SetDeaths(i,Subtract,1,111))
		
		--NJumpEnd(FP,ExJump)

		DoActions(i,{
			SetMemoryB(0x57F27C+(228*i)+MedicTrig[1],SetTo,0),
			SetMemoryB(0x57F27C+(228*i)+MedicTrig[2],SetTo,0),
			SetMemoryB(0x57F27C+(228*i)+MedicTrig[3],SetTo,0),
			SetMemoryB(0x57F27C+(228*i)+MedicTrig[4],SetTo,0),
			SetMemoryB(0x57F27C+(228*i)+MedicTrig[5],SetTo,0),
		})





		for j = 0, 4 do
		TriggerX(i,{CDeaths(FP,Exactly,j,DelayMedic[i+1])},{SetMemoryB(0x57F27C+(228*i)+MedicTrig[j+1],SetTo,1)},{preserved})
		TriggerX(i,{Command(i,AtLeast,1,72),CDeaths(FP,Exactly,j,DelayMedic[i+1])},{
			DisplayText(DelayMedicT[j+1],4),
			SetCDeaths(FP,Add,1,DelayMedic[i+1]),
			GiveUnits(All,72,i,"Anywhere",P12),
			ModifyUnitEnergy(1,72,P12,64,0);
			--SetCDeaths(FP,Add,1,CUnitRefrash);
			RemoveUnitAt(1,72,"Anywhere",P12)},{preserved})
		end
		TriggerX(i,{CDeaths(FP,AtLeast,5,DelayMedic[i+1])},{SetCDeaths(FP,Subtract,5,DelayMedic[i+1])},{preserved})
	

		local MedicTrigJump = def_sIndex()
		for j = 1, 5 do
			if Limit == 1 then
				
				local TestT = CreateCcode()
				TriggerX(FP,{CD(TestMode,1)},{AddCD(TestT,1)},{preserved})
				NJumpX(FP,MedicTrigJump,{CD(TestMode,1),CD(TestT,8,AtLeast)},{SetCD(TestT,0)})
				NJumpX(FP,MedicTrigJump,{CD(TestMode,1),CDeaths(FP,Exactly,j-1,DelayMedic[i+1]),Command(i,AtLeast,1,MedicTrig[j])},{})
				--NJumpX(FP,MedicTrigJump,{CDeaths(FP,Exactly,j-1,DelayMedic[i+1]),Command(i,AtLeast,1,MedicTrig[j])},{})
				NJumpX(FP,MedicTrigJump,{CD(TestMode,0),CDeaths(FP,Exactly,j-1,DelayMedic[i+1]),Command(i,AtLeast,1,MedicTrig[j])},{})
			else
				NJumpX(FP,MedicTrigJump,{Command(i,AtLeast,1,MedicTrig[j])},{})
			end
		end
		
			NIf(FP,Never())
				NJumpXEnd(FP,MedicTrigJump)
					DoActionsX(FP,{
						ModifyUnitEnergy(All,MedicTrig[1],i,64,0);
						ModifyUnitEnergy(All,MedicTrig[2],i,64,0);
						ModifyUnitEnergy(All,MedicTrig[3],i,64,0);
						ModifyUnitEnergy(All,MedicTrig[4],i,64,0);
						ModifyUnitEnergy(All,MedicTrig[5],i,64,0);
						--SetCDeaths(FP,Add,1,CUnitRefrash);
						RemoveUnit(MedicTrig[1],i),
						RemoveUnit(MedicTrig[2],i),
						RemoveUnit(MedicTrig[3],i),
						RemoveUnit(MedicTrig[4],i),
						RemoveUnit(MedicTrig[5],i),
						ModifyUnitHitPoints(All,"Men",i,"Anywhere",100),
						ModifyUnitHitPoints(All,"Buildings",i,"Anywhere",100),
						ModifyUnitShields(All,"Men",i,"Anywhere",100),
						ModifyUnitShields(All,"Buildings",i,"Anywhere",100),
					})
			NIfEnd()
	
		CIfEnd()
		
		Trigger2(i,{DeathsX(i,Exactly,0,12,0xFF000000);Command(i,AtLeast,1,3);},{
			GiveUnits(All,3,i,"Anywhere",P12);
			RemoveUnitAt(All,3,"Anywhere",P12);
			DisplayText("\x07『 \x1CBGM\x04을 듣지 않습니다. \x07』",4);
			SetDeathsX(i,SetTo,1*16777216,12,0xFF000000);
		},{preserved})

		Trigger2(i,{DeathsX(i,Exactly,1*16777216,12,0xFF000000);Command(i,AtLeast,1,3);},{
			GiveUnits(All,3,i,"Anywhere",P12);
			RemoveUnitAt(All,3,"Anywhere",P12);
			DisplayText("\x07『 \x1CBGM\x04을 듣습니다. \x07』",4);
			SetDeathsX(i,SetTo,0*16777216,12,0xFF000000);
		},{preserved})

		for k = 0, 5 do
			Trigger { -- 기부 금액 변경
				players = {i},
				conditions = {
					Label(0);
					CDeaths(FP,Exactly,k,GiveRate[i+1]);
					Command(i,AtLeast,1,"Protoss Reaver");
				},
				actions = {
					GiveUnits(All,"Protoss Reaver",CurrentPlayer,"Anywhere",11);
					RemoveUnitAt(All,"Protoss Reaver","Anywhere",11);
					DisplayText(GiveRateT[k+1],4);
					SetCDeaths(FP,Add,1,GiveRate[i+1]);
					PreserveTrigger();
					},
			}
		end
	TriggerX(i,{CDeaths(FP,AtLeast,6,GiveRate[i+1])},{SetCDeaths(FP,Subtract,6,GiveRate[i+1])},{preserved})

		
	Trigger { -- 자동환전
	players = {i},
	conditions = {
		Command(i,AtLeast,1,"Terran Firebat");
	},
	actions = {
		ModifyUnitEnergy(1,"Terran Firebat",i,64,0);
		RemoveUnitAt(1,"Terran Firebat","Anywhere",i);
		SetDeaths(i,SetTo,1,"Terran Barracks");
		DisplayText(StrDesign("\x07자동환전\x04을 사용하셨습니다."),4);
		--SetCDeaths(FP,Add,1,CUnitRefrash);
		PreserveTrigger();
	},
}


Trigger { -- 조합 영웅마린
players = {i},
conditions = {
	Label(0);
	Bring(i,AtLeast,1,0,5); 
	Accumulate(i,AtLeast,4500,Ore);
	Accumulate(i,AtMost,0x7FFFFFFF,Ore);
},
actions = {
	ModifyUnitEnergy(1,0,i,5,0);
	RemoveUnitAt(1,0,5,i);
	SetResources(i,Subtract,4500,Ore);
	CreateUnitWithProperties(1,20,2,i,{energy = 100});
	DisplayText(StrDesign("\x1F광물\x04을 소모하여 Marine 을 Jim Raynor로 \x19변환\x04하였습니다. - \x1F4500 O r e"),4);
	--SetCDeaths(FP,Add,1,CUnitRefrash);
	--SetCD(CUnitFlag,1);
	PreserveTrigger();
},
}
	
DoActions(i,{SetCp(i),SetAllianceStatus(Force1,Ally),--팀킬방지
RunAIScript("Turn ON Shared Vision for Player 1");
RunAIScript("Turn ON Shared Vision for Player 2");
RunAIScript("Turn ON Shared Vision for Player 3");
RunAIScript("Turn ON Shared Vision for Player 4");
RunAIScript("Turn ON Shared Vision for Player 5");
RunAIScript("Turn ON Shared Vision for Player 6");
RunAIScript("Turn ON Shared Vision for Player 7");
})
if false then
	TriggerX(i, {Switch("Switch 254", Set)}, {
		RunAIScript("Turn ON Shared Vision for Player 1");
		RunAIScript("Turn ON Shared Vision for Player 2");
		RunAIScript("Turn ON Shared Vision for Player 3");
		RunAIScript("Turn ON Shared Vision for Player 4");
		RunAIScript("Turn ON Shared Vision for Player 5");
		RunAIScript("Turn ON Shared Vision for Player 6");
		RunAIScript("Turn ON Shared Vision for Player 7");
		RunAIScript("Turn ON Shared Vision for Player 8");})
	
end
	end

	for k=0, 6 do -- 기부시스템
		for j=0, 6 do
		if k~=j then
		for i=0, 5 do
		Trigger { -- 돈 기부 시스템
			players = {k},
			conditions = {
				Label(0);
				--MemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],AtLeast,1);
				Command(k,AtLeast,1,GiveUnitID[j+1]);
				HumanCheck(j,1);
				CDeaths(FP,Exactly,i,GiveRate[k+1]);
				Accumulate(k,AtMost,GiveRate2[i+1],Ore);
			},
			actions = {
				--SetMemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],SetTo,0);`
				RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
				DisplayText("\x07『 \x04잔액이 부족합니다. \x07』",4);
				PreserveTrigger();
			},
			}
		Trigger { -- 돈 기부 시스템
			players = {k},
			conditions = {
				Label(0);
				--MemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],AtLeast,1);
				Command(k,AtLeast,1,GiveUnitID[j+1]);
				HumanCheck(j,1);
				CDeaths(FP,Exactly,i,GiveRate[k+1]);
				Accumulate(k,AtLeast,GiveRate2[i+1],Ore);
				Accumulate(k,AtMost,0x7FFFFFFF,Ore);
			},
			actions = {
				SetResources(k,Subtract,GiveRate2[i+1],Ore);
				SetResources(j,Add,GiveRate2[i+1],Ore);
				--SetMemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],SetTo,0);
				
				RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
				DisplayText("\x07『 "..PlayerString[j+1].."\x04에게 \x1F"..GiveRate2[i+1].." Ore\x04를 기부하였습니다. \x07』",4);
				SetMemory(0x6509B0,SetTo,j);
				DisplayText("\x12\x07『"..PlayerString[k+1].."\x04에게 \x1F"..GiveRate2[i+1].." Ore\x04를 기부받았습니다.\x02 \x07』",4);
				SetMemory(0x6509B0,SetTo,k);
				PreserveTrigger();
			},
			}
		end
		Trigger { -- 돈 기부 시스템
			players = {k},
			conditions = {
				--MemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],AtLeast,1);
				Command(k,AtLeast,1,GiveUnitID[j+1]);
				HumanCheck(j,0);
			},
			actions = {
				DisplayText("\x07『 "..PlayerString[j+1].."\x04이(가) 존재하지 않습니다. \x07』",4);
				--SetMemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],SetTo,0);
				RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
				PreserveTrigger();
			},
			}
	end end end

	--LeaderBoard
	local LeaderBoardT = CreateCcode()
	Trigger { -- 킬 포인트 리더보드,
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtMost,0,LeaderBoardT);
		},
		actions = {
			LeaderBoardScore(Kills, "\x07[ \x1DP\x04oints\x07 ]");
			LeaderBoardComputerPlayers(Disable);
			SetCDeaths(FP,SetTo,600,LeaderBoardT);
			ModifyUnitShields(All,"Men",Force2,"Anywhere",100);
			PreserveTrigger();
		},
	}
	Trigger { -- 데스 스코어 리더보드
		players = {FP},
		conditions = {
			Label(0);
			
			CDeaths(FP,Exactly,400,LeaderBoardT);
		},
		actions = {
			LeaderBoardScore(Custom, "\x07[ \x08D\x04eaths\x07 ]");
			LeaderBoardComputerPlayers(Disable);
			ModifyUnitShields(All,"Men",Force2,"Anywhere",100);
			PreserveTrigger();
	},
	}
	Trigger { -- 킬 스코어 리더보드
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,Exactly,200,LeaderBoardT);
		},
		actions = {
			LeaderBoardKills("Any unit","\x07[ \x11K\x04ills\x07 ]");
			LeaderBoardComputerPlayers(Disable);
			ModifyUnitShields(All,"Men",Force2,"Anywhere",100);
			PreserveTrigger();
	},
	}
	DoActionsX(FP,{SetCDeaths(FP,Subtract,1,LeaderBoardT)})


	--HealZone
	
	local HealT = CreateCcode()
	TriggerX(FP,CDeaths(FP,AtLeast,50,HealT),{SetCDeaths(FP,SetTo,0,HealT),
	ModifyUnitHitPoints(All,"Men",Force1,2,100),
	ModifyUnitShields(All,"Men",Force1,2,100)},{preserved})
	DoActionsX(FP,{SetCDeaths(FP,Add,1,HealT),ModifyUnitHitPoints(All, 125, Force1, 2, 100)})

	
	for i = 128,131 do
		ObserverChatToOb(FP,0x58D740+(20*59),i,"END",10,nil,{SetMemory(0x6509B0,SetTo,i),DisplayText("\x0D\x0D!H"..StrDesign("\x1C채팅→관전자\x04에게 메세지를 보냅니다.").."\x0D\x0D",4),PlayWAV("staredit\\wav\\button3.wav"),SetMemory(0x6509B0,SetTo,FP)})
		ObserverChatToAll(FP,0x58D740+(20*59),i,"HOME",10,nil,{SetMemory(0x6509B0,SetTo,i),DisplayText("\x0D\x0D!H"..StrDesign("\x07채팅→전체\x04에게 메세지를 보냅니다.").."\x0D\x0D",4),PlayWAV("staredit\\wav\\button3.wav"),SetMemory(0x6509B0,SetTo,FP)})
		ObserverChatToNone(FP,0x58D740+(20*59),i,"INSERT",10,nil,{SetMemory(0x6509B0,SetTo,i),DisplayText("\x0D\x0D!H"..StrDesign("\x02채팅→대상없음\x04에게 메세지를 보냅니다.(귓말 명령어 등 전용)").."\x0D\x0D",4),PlayWAV("staredit\\wav\\button3.wav"),SetMemory(0x6509B0,SetTo,FP)})
	end


end