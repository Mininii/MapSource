function Interface()
    count = CreateVar(FP)
    f_Read(FP, 0x6283F0, count)
	
	Dt = IBGM_EPD(FP, {P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12}, BGMType, {
		{1,"staredit\\wav\\BGM_OP.ogg",96*1000},
		{2,"staredit\\wav\\BGM_BlueWhite.ogg",35*1000},
		{3,"staredit\\wav\\BGM_OnlyForYou.ogg",39*1000},
		{4,"staredit\\wav\\BGM_Kamui.ogg",77*1000},
	})

    
	local DelayMedic = CreateCcodeArr(7)
	local GiveRate = CreateCcodeArr(7)
	local BanCode = CreateCcodeArr(6)
	local CurrentOP = CreateVar(FP)
	local Cunit2 = CreateVar(FP)
    CIfX(FP,Never()) -- 상위플레이어 단락 시작
        for i = 0, 6 do
            CElseIfX(HumanCheck(i,1),{SetCVar(FP,CurrentOP[2],SetTo,i),GiveUnits(All, 115,AllPlayers, 64, i),GiveUnits(All, 15, AllPlayers, 64, i)})
            if Limit == 1 then
                
                f_Read(FP,0x6284E8+(0x30*i),"X",Cunit2)
            end
    
        end
        CIfXEnd()
	if Limit == 1 then
		CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
		TriggerX(FP,{ElapsedTime(20, AtMost),Switch("Switch 253",Set),Deaths(CurrentPlayer,AtLeast,1,199)},{SetCD(TestMode,1),SetSwitch("Switch 254",Set),SetMemory(0x657A9C,SetTo,31),SetDeaths(CurrentPlayer, SetTo, 0, 199)})
		CIf(FP,CD(TestMode,1)) -- 테스트 트리거

		
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
					CTrigger(FP,{TTDeathsX(CurrentPlayer,NotSame,49,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,111,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,107,0,0xFF)},{
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
					CTrigger(FP,{TTDeathsX(CurrentPlayer,NotSame,49,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,111,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,107,0,0xFF)},{
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


    for i = 0, 4 do
        DoActions(i,{SetCp(i),SetAllianceStatus(Force1,Ally),--팀킬방지
        RunAIScript("Turn ON Shared Vision for Player 1");
        RunAIScript("Turn ON Shared Vision for Player 2");
        RunAIScript("Turn ON Shared Vision for Player 3");
        RunAIScript("Turn ON Shared Vision for Player 4");
        RunAIScript("Turn ON Shared Vision for Player 5");
        })
        if TestStart == 1 then
            
        DoActions(i,{SetCp(i),
            RunAIScript("Turn ON Shared Vision for Player 1");
            RunAIScript("Turn ON Shared Vision for Player 2");
            RunAIScript("Turn ON Shared Vision for Player 3");
            RunAIScript("Turn ON Shared Vision for Player 4");
            RunAIScript("Turn ON Shared Vision for Player 5");
            RunAIScript("Turn ON Shared Vision for Player 6");
            RunAIScript("Turn ON Shared Vision for Player 7");
            RunAIScript("Turn ON Shared Vision for Player 8");
            })
        end
        
    end
    if TestStart == 1 then
        DoActions(P6,{SetCp(P6),
            RunAIScript("Turn ON Shared Vision for Player 1");
            RunAIScript("Turn ON Shared Vision for Player 2");
            RunAIScript("Turn ON Shared Vision for Player 3");
            RunAIScript("Turn ON Shared Vision for Player 4");
            RunAIScript("Turn ON Shared Vision for Player 5");
            RunAIScript("Turn ON Shared Vision for Player 6");
            RunAIScript("Turn ON Shared Vision for Player 7");
            RunAIScript("Turn ON Shared Vision for Player 8");
            })
    DoActions(P7,{SetCp(P7),
        RunAIScript("Turn ON Shared Vision for Player 1");
        RunAIScript("Turn ON Shared Vision for Player 2");
        RunAIScript("Turn ON Shared Vision for Player 3");
        RunAIScript("Turn ON Shared Vision for Player 4");
        RunAIScript("Turn ON Shared Vision for Player 5");
        RunAIScript("Turn ON Shared Vision for Player 6");
        RunAIScript("Turn ON Shared Vision for Player 7");
        RunAIScript("Turn ON Shared Vision for Player 8");
        })
    DoActions(P8,{SetCp(P8),
        RunAIScript("Turn ON Shared Vision for Player 1");
        RunAIScript("Turn ON Shared Vision for Player 2");
        RunAIScript("Turn ON Shared Vision for Player 3");
        RunAIScript("Turn ON Shared Vision for Player 4");
        RunAIScript("Turn ON Shared Vision for Player 5");
        RunAIScript("Turn ON Shared Vision for Player 6");
        RunAIScript("Turn ON Shared Vision for Player 7");
        RunAIScript("Turn ON Shared Vision for Player 8");
        })
    end


    

for i = 1, 4 do -- 강퇴기능
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
					RotatePlayer({DisplayTextX(StrDesign(PlayerString[i+1].."\x04에게 \x08경고가 총 "..j.."회 누적\x04 되었습니다. 총 5회 누적시 \x08강퇴 처리 \x04됩니다."),4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i);
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
			RotatePlayer({DisplayTextX(StrDesign("\x04"..PlayerString[i+1].."\x04의 강퇴처리가 완료되었습니다."),4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i);
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
	for i = 0, 4 do
		CreatingUnit = CreateVar(FP)
		CreatingUID = CreateVar(FP)
		CreatingUnitHP = CreateVar(FP)
		CIf(FP,HumanCheck(i,1),{ModifyUnitEnergy(All, "Any unit", i, 64, 100)})
		CDoActions(FP, {TSetDeathsX(i, Subtract, Dt, 12,0xFFFFFF)})
        DoActions(FP, {
            SetMemory(0x5822C4+(i*4),SetTo,1200);
            SetMemory(0x582264+(i*4),SetTo,1200);}, 1)




		NIf(FP,MemoryB(0x58D2B0+(46*i)+18,Exactly,1)) -- 공업 255회
		CDoActions(FP,{
			SetCD(UpMaster,0),
			SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(AtkUpgradePtrArr[i+1])),
			SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^AtkUpgradeMaskRetArr[i+1]),
			SetCVar(FP,TempUpgradeLimPtr[2],SetTo,EPD(AtkUpgradeLimPtrArr[i+1])),
			SetCVar(FP,TempUpgradeLimMaskRet[2],SetTo,256^AtkUpgradeMaskLimRetArr[i+1]),
			SetCVar(FP,UpgradeCP[2],SetTo,i),
			SetCVar(FP,UpgradeFlag[2],SetTo,1),
			SetCD(UpResultFlag,0);
			SetMemoryB(0x58D2B0+(46*i)+18,SetTo,0)})
		CallTrigger(FP,OneClickUpgrade)
		TriggerX(FP, {CD(UpMaster,1)}, {SetMemoryB(0x58D088 + (i * 46) + 18,SetTo,0)}, {preserved})
		NIfEnd()
		NIf(FP,MemoryB(0x58D2B0+(46*i)+19,Exactly,1)) -- 체업 255회
		CDoActions(FP,{
			SetCD(UpMaster,0),
			SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(HPUpgradePtrArr[i+1])),
			SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^HPUpgradeMaskRetArr[i+1]),
			SetCVar(FP,TempUpgradeLimPtr[2],SetTo,EPD(HPUpgradeLimPtrArr[i+1])),
			SetCVar(FP,TempUpgradeLimMaskRet[2],SetTo,256^HPUpgradeMaskLimRetArr[i+1]),
			SetCVar(FP,UpgradeCP[2],SetTo,i),
			SetCVar(FP,UpgradeFlag[2],SetTo,2),
			SetCD(UpResultFlag,0);
			SetMemoryB(0x58D2B0+(46*i)+19,SetTo,0)})
		CallTrigger(FP,OneClickUpgrade)
		TriggerX(FP, {CD(UpMaster,1)}, {SetMemoryB(0x58D088 + (i * 46) + 19,SetTo,0)}, {preserved})
		NIfEnd()
		NIf(FP,MemoryB(0x58D2B0+(46*i)+20,Exactly,1)) -- 쉴드업 255회
		CDoActions(FP,{
			SetCD(UpMaster,0),
			SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(ShUpgradePtrArr[i+1])),
			SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^ShUpgradeMaskRetArr[i+1]),
			SetCVar(FP,TempUpgradeLimPtr[2],SetTo,EPD(ShUpgradeLimPtrArr[i+1])),
			SetCVar(FP,TempUpgradeLimMaskRet[2],SetTo,256^ShUpgradeMaskLimRetArr[i+1]),
			SetCVar(FP,UpgradeCP[2],SetTo,i),
			SetCVar(FP,UpgradeFlag[2],SetTo,3),
			SetCD(UpResultFlag,0);
			SetMemoryB(0x58D2B0+(46*i)+20,SetTo,0)})
		CallTrigger(FP,OneClickUpgrade)
		TriggerX(FP, {CD(UpMaster,1)}, {SetMemoryB(0x58D088 + (i * 46) + 20,SetTo,0)}, {preserved})
		NIfEnd()
	

		CIf(FP,{CV(BarPos[i+1],19025,AtLeast),CV(BarPos[i+1],19025+(84*1699),AtMost)})

		CIf(FP,{TTMemory(_Add(BarPos[i+1],62), NotSame, BarRally[i+1])})
			f_Read(FP, _Add(BarPos[i+1],62), BarRally[i+1])
			Convert_CPosXY(BarRally[i+1])
			DisplayPrintEr(i, {"\x07『 \x03TESTMODE OP \x04: 랠리 포인트가 갱신되었습니다. X : ",CPosX,"  Y : ",CPosY," \x07』"})
		CIfEnd()
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
			CIfEnd()
			--TriggerX(FP,{CD(TestMode,1)},{SetInvincibility(Enable, "Buildings", FP, 64)},{preserved})--SetV(CurEXP,0x7FFFFFFF)
			TriggerX(FP,{CD(TestMode,1)},{SetMemoryB(0x58D2B0+15+(i*46),SetTo,255),SetMemoryB(0x58D2B0+7+(i*46),SetTo,255),SetMemoryB(0x58D2B0+(i*46),SetTo,255)})--SetV(CurEXP,0x7FFFFFFF)
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
		CIf(FP,{CDeaths(FP,AtMost,0,BanCode2[i+1]),Score(i,Kills,AtLeast,1000)})
		CMov(FP,ExchangeP,_Div(_ReadF(0x581F04+(i*4)),_Mov(1000)))
		CMov(FP,0x581F04+(i*4),_Mod(_ReadF(0x581F04+(i*4)),_Mov(1000)))
		CAdd(FP,0x57F0F0+(i*4),_Mul(_Mul(ExchangeP,_Mov(10)),ExRate))

		CMov(FP,ExchangeP,0)
		CIfEnd()
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
			if false then--Limit == 1 then
				
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
			DisplayText(StrDesign("\x1CBGM\x04을 듣지 않습니다."),4);
			SetDeathsX(i,SetTo,1*16777216,12,0xFF000000);
		},{preserved})

		Trigger2(i,{DeathsX(i,Exactly,1*16777216,12,0xFF000000);Command(i,AtLeast,1,3);},{
			GiveUnits(All,3,i,"Anywhere",P12);
			RemoveUnitAt(All,3,"Anywhere",P12);
			DisplayText(StrDesign("\x1CBGM\x04을 듣습니다."),4);
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

		


    
    
	Trigger { -- 보호막 가동
	players = {i},
	conditions = {
		Label(0);
		Memory(0x582294+(4*i),AtLeast,1200);
		Command(i,AtLeast,1,19);
	},
	actions = {
		SetResources(i,Add,ShCost,Ore);
		ModifyUnitEnergy(1,19,i,64,0);
		RemoveUnitAt(1,19,"Anywhere",i);
		DisplayText(StrDesign("\x04이미 \x19Fever Power \x04를 사용중입니다. 자원 반환 + \x1F"..ShCost.." Ore"),4);
		PlayWAV("sound\\Misc\\PError.WAV");
		PlayWAV("sound\\Misc\\PError.WAV");
		PreserveTrigger();
	},
	}

	Trigger { -- 보호막 가동
	players = {i},
	conditions = {
		Label(0);
		Memory(0x582294+(4*i),AtLeast,1);
		Memory(0x582294+(4*i),AtMost,1199);
		Command(i,AtLeast,1,19);
	},
	actions = {
		SetResources(i,Add,ShCost,Ore);
		ModifyUnitEnergy(1,19,i,64,0);
		RemoveUnitAt(1,19,"Anywhere",i);
		DisplayText(StrDesign("\x19Fever Power \x04가 현재 \x0E쿨타임 \x04중입니다. 자원 반환 + \x1F"..ShCost.." Ore"),4);
		PlayWAV("sound\\Misc\\PError.WAV");
		PlayWAV("sound\\Misc\\PError.WAV");
		PreserveTrigger();
	},
}
CIf(FP,{{
	Label(0);
	Memory(0x582294+(4*i),Exactly,0);
	Command(i,AtLeast,1,19);
}})
DisplayPrint(HumanPlayers, {"\x12\x07『 ",PName(i),"\x04님이 \x19Fever Power \x04를 사용했습니다. \x07』"})
DoActions(FP, {RotatePlayer({PlayWAVX("staredit\\wav\\shield_use.ogg")},HumanPlayers,FP);})
DoActions(FP, {{
	SetMemory(0x582294+(4*i),SetTo,2400);
	ModifyUnitEnergy(1,19,i,64,0);
	RemoveUnitAt(1,19,"Anywhere",i);
}})
CIfEnd()
Trigger { -- 보호막 가동
	players = {i},
	conditions = {
		Label(0);
		Memory(0x582294+(4*i),AtLeast,1200);
	},
	actions = {
		SetCDeaths(i,SetTo,1,ShUsed);
		ModifyUnitShields(All,"Men",i,"Anywhere",100);
		ModifyUnitShields(All,"Buildings",i,"Anywhere",100);
		ModifyUnitHitPoints(All,"Men",i,"Anywhere",100);
		ModifyUnitHitPoints(All,"Buildings",i,"Anywhere",100);
		PreserveTrigger();
	},
}
	DoActions(i,{SetMemory(0x582294+(4*i),Subtract,1)})

Trigger { -- 보호막 가동
	players = {i},
	conditions = {
		Label(0);
		CDeaths(i,AtLeast,1,ShUsed);
		Memory(0x582294+(4*i),AtMost,1199);
	},
	actions = {
		DisplayText(StrDesign("\x19Fever Power \x04 사용이 종료되었습니다."),4);
		PlayWAV("staredit\\wav\\GMode.ogg");
		PlayWAV("staredit\\wav\\GMode.ogg");
		SetCDeaths(i,SetTo,0,ShUsed);
		SetCDeaths(i,SetTo,1,ShCool);
		PreserveTrigger();
	},
}
Trigger { -- 보호막 가동
	players = {i},
	conditions = {
		Label(0);
		CDeaths(i,AtLeast,1,ShCool);
		Memory(0x582294+(4*i),AtMost,0);
	},
	actions = {
		DisplayText(StrDesign("\x19Fever Power \x04 쿨타임이 종료되었습니다."),4);
		PlayWAV("staredit\\wav\\GMode.ogg");
		PlayWAV("staredit\\wav\\GMode.ogg");
		SetCDeaths(i,SetTo,0,ShCool);
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

	for k=0, 4 do -- 기부시스템
		CIf(FP,{HumanCheck(k, 1)})
		for j=0, 4 do
		if k~=j then
		for i=0, 5 do
		Trigger { -- 돈 기부 시스템
			players = {FP},
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
				SetCp(k);
				DisplayText("\x07『 \x04잔액이 부족합니다. \x07』",4);
				SetCp(FP);
				PreserveTrigger();
			},
			}
			CallTriggerX(FP, GiveAlarm, {
				Command(k,AtLeast,1,GiveUnitID[j+1]);
				HumanCheck(j,1);
				CDeaths(FP,Exactly,i,GiveRate[k+1]);
				Accumulate(k,AtLeast,GiveRate2[i+1],Ore);
				Accumulate(k,AtMost,0x7FFFFFFF,Ore);
			}, {
				SetResources(k,Subtract,GiveRate2[i+1],Ore);
				SetResources(j,Add,GiveRate2[i+1],Ore);
				SubV(CTMin[k+1],GiveRate2[i+1]),
				AddV(CTMin[k+1],GiveRate2[i+1]),
				RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
				SetV(GivePrevP, k);
				SetV(GiveNextP, j);
				SetV(GiveMin, GiveRate2[i+1]);
			})
		end
		Trigger { -- 돈 기부 시스템
			players = {FP},
			conditions = {
				--MemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],AtLeast,1);
				Command(k,AtLeast,1,GiveUnitID[j+1]);
				HumanCheck(j,0);
			},
			actions = {
				SetCp(k);
				DisplayText("\x07『 "..PlayerString[j+1].."\x04이(가) 존재하지 않습니다. \x07』",4);
				SetCp(FP);
				--SetMemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],SetTo,0);
				RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
				PreserveTrigger();
			},
			}
	end 
end 
CIfEnd()
end

	--LeaderBoard
	local LeaderBoardT = CreateCcode()
	Trigger { -- 킬 포인트 리더보드,
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtMost,0,LeaderBoardT);
		},
		actions = {
			LeaderBoardScore(Kills, StrDesign("\x1DP\x04oints"));
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
			LeaderBoardScore(Custom, StrDesign("\x08D\x04eaths"));
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
			LeaderBoardKills("Any unit",StrDesign("\x11K\x04ills"));
			LeaderBoardComputerPlayers(Disable);
			ModifyUnitShields(All,"Men",Force2,"Anywhere",100);
			PreserveTrigger();
	},
	}
	CIf(FP,{CDeaths(FP,Exactly,400,LeaderBoardT);})
	CMov(FP, 0x6509B0, 19025+2)
	CFor(FP,19025+19,19025+(1700*84)+19,84) -- 좀비유닛탐지
	CI = CForVariable()
	CTrigger(FP, {Deaths(CurrentPlayer, AtMost, 0,0),TMemoryX(CI, AtLeast,1*256, 0xFF00)}, {SetDeaths(CurrentPlayer, Add, 1*256, 0)},{preserved})
	CAdd(FP,0x6509B0,84)
	CForEnd()
	CMov(FP, 0x6509B0, FP)
	CIfEnd()
	DoActionsX(FP,{SetCDeaths(FP,Subtract,1,LeaderBoardT)})


	--HealZone
	
	local HealT = CreateCcode()
	TriggerX(FP,CDeaths(FP,AtLeast,50,HealT),{SetCDeaths(FP,SetTo,0,HealT),
	ModifyUnitHitPoints(All,"Men",Force1,6,100),
	ModifyUnitShields(All,"Men",Force1,6,100)},{preserved})
	DoActionsX(FP,{SetCDeaths(FP,Add,1,HealT),ModifyUnitHitPoints(All, 125, Force1, 6, 100)})

	
	for i = 128,131 do
		ObserverChatToOb(FP,0x58D740+(20*59),i,"END",10,nil,{SetMemory(0x6509B0,SetTo,i),DisplayText("\x0D\x0D!H"..StrDesign("\x1C채팅→관전자\x04에게 메세지를 보냅니다.").."\x0D\x0D",4),PlayWAV("staredit\\wav\\button3.wav"),SetMemory(0x6509B0,SetTo,FP)})
		ObserverChatToAll(FP,0x58D740+(20*59),i,"HOME",10,nil,{SetMemory(0x6509B0,SetTo,i),DisplayText("\x0D\x0D!H"..StrDesign("\x07채팅→전체\x04에게 메세지를 보냅니다.").."\x0D\x0D",4),PlayWAV("staredit\\wav\\button3.wav"),SetMemory(0x6509B0,SetTo,FP)})
		ObserverChatToNone(FP,0x58D740+(20*59),i,"INSERT",10,nil,{SetMemory(0x6509B0,SetTo,i),DisplayText("\x0D\x0D!H"..StrDesign("\x02채팅→대상없음\x04에게 메세지를 보냅니다.(귓말 명령어 등 전용)").."\x0D\x0D",4),PlayWAV("staredit\\wav\\button3.wav"),SetMemory(0x6509B0,SetTo,FP)})
	end



end