function Interface()
    count = CreateVar(FP)
    f_Read(FP, 0x6283F0, count)
	
	Dt = IBGM_EPD(FP, {P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12}, BGMType, {
		{1,"staredit\\wav\\BGM_OP.ogg",96*1000},
		{2,"staredit\\wav\\BGM_BlueWhite.ogg",35*1000},
		{3,"staredit\\wav\\BGM_OnlyForYou.ogg",39*1000},
		{4,"staredit\\wav\\BGM_Kamui.ogg",77*1000},
	})

	DoActionsX(FP,{SetCDeaths(FP,SetTo,0,PCheck),SetCVar(FP,PCheckV[2],SetTo,0)})
	for i = 0, 4 do
		TriggerX(FP,{HumanCheck(i,1)},{SetCDeaths(FP,Add,1,PCheck),SetCVar(FP,PCheckV[2],Add,1)},{preserved})
	end

	CIf(FP,CDeaths(FP,AtLeast,1,PExitFlag),SetCDeaths(FP,Subtract,1,PExitFlag))
		CMov(FP,SuppMax,_Div(MarNumberLimit,PCheckV))
		for i = 0, 4 do
		CMov(FP,0x582234 + (4*i),SuppMax) -- 인구수 상시 업데이트(맥스)
		CMov(FP,0x5821D4 + (4*i),SuppMax) -- 인구수 상시 업데이트(사용가능)
		end
	CIfEnd()
    
	local DelayMedic = CreateCcodeArr(7)
	local GiveRate = CreateCcodeArr(7)
	local BanCode = CreateCcodeArr(6)
	local CurrentOP = CreateVar(FP)
	local Cunit2 = CreateVar(FP)
    CIfX(FP,Never()) -- 상위플레이어 단락 시작
        for i = 0, 6 do
            CElseIfX(HumanCheck(i,1),{SetCVar(FP,CurrentOP[2],SetTo,i),GiveUnits(All, 115,AllPlayers, 64, i),GiveUnits(All, 96, AllPlayers, 64, i)})
            if Limit == 1 then
                
                f_Read(FP,0x6284E8+(0x30*i),"X",Cunit2)
            end
    
        end
        CIfXEnd()

	CurrentSpeed,SpeedVar = CreateVars(2,FP)
	TestVar = CreateVar(FP)
	TriggerX(FP,{Command(Force1,AtLeast,1,62);},{ModifyUnitEnergy(1,62,Force1,64,0);
	RemoveUnitAt(1,62,"Anywhere",Force1);SetCVar(FP,SpeedVar[2],Add,1);SetCVar(FP,TestVar[2],Add,1);},{preserved})
	TriggerX(FP,{Command(Force1,AtLeast,1,63);},{ModifyUnitEnergy(1,63,Force1,64,0);
	RemoveUnitAt(1,63,"Anywhere",Force1);SetCVar(FP,SpeedVar[2],Subtract,1);SetCVar(FP,TestVar[2],Subtract,1);},{preserved})
	if TestStart == 1 then
		CDoActions(FP, {
			TSetMemoryX(0x581DD8,SetTo,_Mul(TestVar,65536),0xFF0000);
			TSetMemoryX(0x581D96,SetTo,_Mul(TestVar,65536),0xFF0000);
			TSetResources(Force1, SetTo, TestVar, Gas)
		})
	end
	CIf(FP,{TTCVar(FP,CurrentSpeed[2],NotSame,SpeedVar)}) -- 배속조정 트리거
	TriggerX(FP,{CVar(FP,SpeedVar[2],AtMost,0)},{SetCVar(FP,SpeedVar[2],SetTo,1)},{preserved})
	TriggerX(FP,{CVar(FP,SpeedVar[2],AtLeast,12)},{SetCVar(FP,SpeedVar[2],SetTo,11)},{preserved})
	CMov(FP,CurrentSpeed,SpeedVar)
	for i = 1, 11 do
		Trigger2X(FP,{
			Label(0);
			CVar(FP,SpeedVar[2],Exactly,i);
		},{
			RotatePlayer({
			DisplayTextX(StrDesignX("\x0F게임 \x10속도\x04를 \x10- "..XSpeed[i].."\x04로 \x0F변경\x04하였습니다."), 0)},HumanPlayers,FP);
			SetMemory(0x5124F0,SetTo,SpeedV[i]);},{preserved})
	end
	CIfEnd()


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
		CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
		KillTable = {}
		for j,k in pairs(UnitPointArr) do
			table.insert(KillTable, KillUnit(k[1], Force2))
		end
			Trigger2X(FP, {Deaths(CurrentPlayer,AtLeast,1,204)}, KillTable, {preserved})
			Trigger {
				players = {FP},
				conditions = {
					Label(0);

					Deaths(CurrentPlayer,AtLeast,1,204)
				},
				actions = {
					--KillUnit("Men",Force2);
					--KillUnit(143,Force2);
					--KillUnit(144,Force2);
					--KillUnit(146,Force2);
					PreserveTrigger();
				}
				}
			TestUPtr = CreateVar(FP)
			
			if HeroTestMode==1 then
				local TempUID = CreateVar(FP)
				CIf(FP,{Deaths(CurrentPlayer,AtLeast,1,199)}) -- F12 누르면 선택한 유닛 12마리가 적으로 출현함
				
					CIf(FP,{CVar(FP,Cunit2[2],AtLeast,1),CVar(FP,Cunit2[2],AtMost,0x7FFFFFFF)})
					f_Read(FP, _Add(Cunit2,25), TempUID, nil, 0xFF, 1)
					CDoActions(FP, {TCreateUnit(12, TempUID, 15, FP)})
					CIfEnd()
				CIfEnd()
			end

			--CTrigger(FP,{Deaths(CurrentPlayer,AtLeast,1,199)},{TCreateUnit(12, 20, _Add(CurrentOP,65), CurrentOP)},{preserved})
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
				--0x00020000 - Is A Building

				f_SaveCp()
				CMov(FP,CunitIndex,_Div(_Sub(Cunit2,19025),_Mov(84)))
				TmpGunNum = CreateVarArr(4,FP)
				f_Read(FP, _Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(DUnitCalc[3],((0x20*0)/4))), TmpGunNum[1])
				f_Read(FP, _Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(DUnitCalc[3],((0x20*1)/4))), TmpGunNum[2])
				f_Read(FP, _Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(DUnitCalc[3],((0x20*2)/4))), TmpGunNum[3])
				f_Read(FP, _Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(DUnitCalc[3],((0x20*3)/4))), TmpGunNum[4])
				DisplayPrintEr(CurrentOP, {"DC1 : ",TmpGunNum[1],"   DC2 : ",TmpGunNum[2],"   DC3 : ",TmpGunNum[3],"   DC4 : ",TmpGunNum[4]})
					
				CDoActions(FP,{TSetMemoryX(_Add(Cunit2,35),SetTo,_Mul(_Read(BackupCp),65536),0xFF000000)})
				f_LoadCp()
	
			CIfEnd()
		CIfEnd()
	
		CMov(FP,0x6509B0,FP)--상위플레이어 단락
				end


    for i = 0, 4 do
		TriggerX(FP,{HumanCheck(i, 0)},{SetCDeaths(FP,Add,10,PExitFlag)}) -- 나갔을 경우 1회에 한해 인구수 계산기 작동
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


	GS = CreateCcode()
	GST = CreateCcode()
	GST2 = CreateCcode()
	SelEPD = CreateVar(FP)
	SelUID = CreateVar(FP)
	CurEPD = CreateVar(FP)
	
	CIf(FP,{CD(GS,0)},{AddCD(GST2,1)})--MoveUnit(All, 0, Force1, 64, 46),MoveUnit(All, 20, Force1, 64, 46)
	tt = "\x13\x1ES\x04pecial \x1ET\x04hanks : SANDELE, CheezeNacho, ...(더 추가할 예정) And All DJMAX Respect V Users"
	TriggerX(FP, {},{RotatePlayer({PlayWAVX("staredit\\wav\\scan.wav"),PlayWAVX("staredit\\wav\\scan.wav"),PlayWAVX("staredit\\wav\\scan.wav")}, HumanPlayers, FP)})
	TriggerX(FP, {CD(GST2,299-#tt,AtLeast)},{RotatePlayer({PlayWAVX("staredit\\wav\\scanr.wav"),PlayWAVX("staredit\\wav\\scanr.wav"),PlayWAVX("staredit\\wav\\scanr.wav")}, HumanPlayers, FP)})
	
	for i = 1, 150 do
		local rep = i
		if rep>= 57 then rep = 57 end  
		Trigger2X(FP, {CD(GST2,i)}, 
		{RotatePlayer({DisplayTextX(string.rep("\n", 5),4),
		DisplayTextX("\x13\x04"..string.rep("―", rep),4),
		DisplayTextX(string.sub("\x13\x04Marine Special Forces \x17R\x04espect \x17V",1,i),4),
		DisplayTextX(string.sub("\x13\x1FSTRCtrig \x04Assembler \x07v5.4\x04, \x1FCB \x16Paint \x07v2.4 \x04in Used \x19(つ>ㅅ<)つ",1,i),4),
		DisplayTextX("\x13\x04",4),
		DisplayTextX(string.sub("\x13\x1BC\x04reated \x1BB\x04y : GALAXY_BURST",1,i),4),
		DisplayTextX(string.sub("\x13\x1FI\x04nspirated to \x03MSF \x11R\x04espect. \x18B\x04y.\x1DSANDELE",1,i),4),
		DisplayTextX("\x13\x04",4),
		DisplayTextX(string.sub(tt,1,i),4),
		DisplayTextX("\x13\x04"..string.rep("―", rep),4)}, HumanPlayers, FP)
			})
	end
	
	for j = 151, 299 do
		local i = 299-j+1
		local rep = i
		if rep>= 57 then rep = 57 end  
		Trigger2X(FP, {CD(GST2,j)}, 
		{RotatePlayer({DisplayTextX(string.rep("\n", 5),4),
		DisplayTextX("\x13\x04"..string.rep("―", rep),4),
		DisplayTextX(string.sub("\x13\x04Marine Special Forces \x17R\x04espect \x17V",1,i),4),
		DisplayTextX(string.sub("\x13\x1FSTRCtrig \x04Assembler \x07v5.4\x04, \x1FCB \x16Paint \x07v2.4 \x04in Used \x19(つ>ㅅ<)つ",1,i),4),
		DisplayTextX("\x13\x04",4),
		DisplayTextX(string.sub("\x13\x1BC\x04reated \x1BB\x04y : GALAXY_BURST",1,i),4),
		DisplayTextX(string.sub("\x13\x1FI\x04nspirated to \x03MSF \x11R\x04espect. \x18B\x04y.\x1DSANDELE",1,i),4),
		DisplayTextX("\x13\x04",4),
		DisplayTextX(string.sub(tt,1,i),4),
		DisplayTextX("\x13\x04"..string.rep("―", rep),4)}, HumanPlayers, FP)
			})
	end


	

	CTrigger(FP, {CD(GST2,300,AtLeast)}, {TCreateUnit(1, 96, 10, CurrentOP)})
	TriggerX(FP, {Bring(AllPlayers, AtMost, 0, 96, 10)}, {MoveUnit(All, 96, AllPlayers, 64, 10)},{preserved})
	TriggerX(FP,{CD(GST2,1000,AtLeast)},{MoveUnit(All, 96, AllPlayers, 64, 8)},{preserved})
	TriggerX(FP, {CD(GST2,300,AtMost)}, {RotatePlayer({CenterView(64)}, HumanPlayers, FP)},{preserved})
	TriggerX(FP, {CD(GST2,300,AtLeast)}, {RotatePlayer({CenterView(10)}, HumanPlayers, FP)},{preserved})
	TriggerX(FP, {CD(GST2,300,AtLeast)}, {RotatePlayer({DisplayTextX(StrDesignX("\x04난이도를 선택해 주십시오.").."\n"..StrDesignX("\x04- \x03난이도 설명은 비콘 클릭시 출력됩니다 \x04-"), 4)}, HumanPlayers, FP)})
	
	CIf(FP,{Memory(0x6284B8 ,AtLeast,1),Memory(0x6284B8 + 4,AtMost,0)})
		f_Read(FP,0x6284B8,nil,SelEPD)
		f_Read(FP,_Add(SelEPD,25),SelUID,"X",0xFF)
		CIf(FP,{TTCVar(FP,SelEPD[2],NotSame,CurEPD)},{})
		for i = 0, 4 do
			TriggerX(FP, {LocalPlayerID(i)}, {SetCp(i),DisplayText("\n\n\n\n\n\n\n\n\n\n\n",4)}, {preserved})
			TriggerX(FP, {LocalPlayerID(i)}, {SetCp(i),PlayWAV("staredit\\wav\\CTEnd.ogg")}, {preserved})
		end
		CMov(FP,CurEPD,SelEPD)
		TriggerX(FP, {CV(SelUID,199)}, {RotatePlayer({DisplayTextX(StrDesignX("\x08H\x04D \x08S\x04tyle").."\n"..StrDesignX("\x04- \x03위험도 \x04: \x07★★★ \x04-").."\n"..StrDesignX("\x04어느정도 어렵지만 입문용 난이도로 나쁘지 않습니다.").."\n"..StrDesignX("\x03특징 : \x0ES\x04pecial \x0EM\x04arine, \x17R\x04espect \x17M\x04arine 을 사용할 수 있습니다."), 4)}, HumanPlayers, FP)}, {preserved})
		TriggerX(FP, {CV(SelUID,198)}, {RotatePlayer({DisplayTextX(StrDesignX("\x16M\x04X \x16S\x04tyle").."\n"..StrDesignX("\x04- \x03위험도 \x04: \x08★★★★★★★ \x04-").."\n"..StrDesignX("\x08조심하십시오.. 매우 어렵습니다.").."\n"..StrDesignX("\x03특징 : \x0ES\x04pecial \x0EM\x04arine, \x17R\x04espect \x17M\x04arine 을 사용할 수 있습니다."), 4)}, HumanPlayers, FP)}, {preserved})
		TriggerX(FP, {CV(SelUID,197)}, {RotatePlayer({DisplayTextX(StrDesignX("\x10S\x04C \x10S\x04tyle").."\n"..StrDesignX("\x04- \x03위험도 \x04: \x11??? \x04-").."\n"..StrDesignX("\x11정의할 수 없는, 정의하지 못한 난이도입니다. ").."\n"..StrDesignX("\x03특징 : \x1BH\x04ero \x1BM\x04arine 만 사용할 수 있습니다."), 4)}, HumanPlayers, FP)}, {preserved})
		TriggerX(FP, {CV(SelUID,145)}, {RotatePlayer({DisplayTextX(StrDesignX("\x0FE\x04VF \x0FM\x04ode").."\n"..StrDesignX("\x04- \x03활성화 가능 옵션 \x04-").."\n"..StrDesignX("\x07속시원한 빠른 플레이\x04를 원할 경우 사용할 수 있습니다. ").."\n"..StrDesignX("\x03특징 : \x1B마린 공격력 \x082배\x04, \x17Fever Power \x04활성화, \x07무적 벙커 활성화").."\n"..StrDesignX("\x17Fever Power \x04사용 중에는 모든 마린의 체력, 쉴드가 100%로 고정되고, 환전률 \x075배\x04가 적용됩니다."), 4)}, HumanPlayers, FP)}, {preserved})
		CIfEnd()
	CIfEnd()
	CMov(FP,0x6509B0,FP)

	

	Trigger2X(FP, {Bring(AllPlayers, AtLeast, 1, 96, 11)}, {SetCD(EVFCcode,1),RemoveUnit(145, AllPlayers),RotatePlayer({DisplayTextX("\n\n\n\n\n\n\n\n\n",4),DisplayTextX(StrDesignX("\x0FE\x04VF \x0FM\x04ode\x04가 활성화되었습니다.").."\n"..StrDesignX("\x1B마린 공격력 \x082배\x04, \x17Fever Power \x04활성화, \x07무적 벙커 활성화").."\n"..StrDesignX("\x17Fever Power \x04사용 중에는 모든 마린의 체력, 쉴드가 100%로 고정되고, 환전률 \x075배\x04가 적용됩니다."), 4),PlayWAVX("staredit\\wav\\ADEnd.ogg"),PlayWAVX("staredit\\wav\\ADEnd.ogg"),PlayWAVX("staredit\\wav\\ADEnd.ogg")}, HumanPlayers, FP)})

	Trigger2X(FP, {Bring(AllPlayers, AtLeast, 1, 96, 8)}, {SetCD(GST,1),RemoveUnit(96, AllPlayers),SetCD(GMode,1)})
	Trigger2X(FP, {Bring(AllPlayers, AtLeast, 1, 96, 12)}, {SetCD(GST,1),RemoveUnit(96, AllPlayers),SetCD(GMode,2)})
	Trigger2X(FP, {Bring(AllPlayers, AtLeast, 1, 96, 9)}, {SetCD(GST,1),RemoveUnit(96, AllPlayers),SetCD(GMode,3)})
	
	TriggerX(FP, {CD(GST,1,AtLeast)},{SetV(SpeedVar,4),SetCD(GS,1),RotatePlayer({PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")}, HumanPlayers, FP)},{preserved})
	CIfEnd()


	CIfOnce(FP,{CD(GS,1)},{
		SetV(BGMType,1),
		SetCp(FP),
		RunAIScriptAt("Expansion Zerg Campaign Insane","AI"),
		RunAIScriptAt("Value This Area Higher",6),
		SetResources(Force1, Add, 25000, Ore),
		RemoveUnit(199, AllPlayers),
		RemoveUnit(198, AllPlayers),
		RemoveUnit(197, AllPlayers),
		RemoveUnit(145, AllPlayers),
	})
	TriggerX(FP, {CD(EVFCcode,0)}, {SetMemoryB(0x57F27C + (0 * 228) + 19,SetTo,0),
	SetMemoryB(0x57F27C + (1 * 228) + 19,SetTo,0),
	SetMemoryB(0x57F27C + (2 * 228) + 19,SetTo,0),
	SetMemoryB(0x57F27C + (3 * 228) + 19,SetTo,0),
	SetMemoryB(0x57F27C + (4 * 228) + 19,SetTo,0)})
	TriggerX(FP, {CD(GMode,3)}, {SetMemoryB(0x57F27C + (0 * 228) + 7,SetTo,0),SetMemoryB(0x663CE8 + 8,SetTo,4),
	SetMemoryB(0x57F27C + (1 * 228) + 7,SetTo,0),
	SetMemoryB(0x57F27C + (2 * 228) + 7,SetTo,0),
	SetMemoryB(0x57F27C + (3 * 228) + 7,SetTo,0),
	SetMemoryB(0x57F27C + (4 * 228) + 7,SetTo,0)})
	TriggerX(FP, {CD(EVFCcode,1)}, {
		SetMemoryW(0x656EB0+(0 *2),Add,NMBaseAtk), -- 공격력
		SetMemoryW(0x657678+(0 *2),Add,NMFactorAtk), -- 추가공격력
		SetMemoryW(0x656EB0+(1 *2),Add,HMBaseAtk), -- 공격력
		SetMemoryW(0x657678+(1 *2),Add,HMFactorAtk), -- 추가공격력
		SetMemoryW(0x656EB0+(2 *2),Add,SMBaseAtk), -- 공격력
		SetMemoryW(0x657678+(2 *2),Add,SMFactorAtk), -- 추가공격력
		SetMemoryW(0x656EB0+(3 *2),Add,RMBaseAtk), -- 공격력
		SetMemoryW(0x657678+(3 *2),Add,RMFactorAtk), -- 추가공격력
})
	

	DoActions2(FP, {RotatePlayer({CenterView(6)}, HumanPlayers, FP)})
	
		Shape1032 = {2   ,{1088, 1040},{1088, 1008}}
		Shape2032 = {2   ,{1056, 1040},{1056, 1008}}
		Shape3032 = {2   ,{1024, 1040},{1024, 1008}}
		Shape4032 = {2   ,{992, 1040},{992, 1008}}
		Shape5032 = {2   ,{960, 1040},{960, 1008}}
		Shape1020 = {1   ,{1088, 976}}
		Shape2020 = {1   ,{1056, 976}}
		Shape3020 = {1   ,{1024, 976}}
		Shape4020 = {1   ,{992, 976}}
		Shape5020 = {1   ,{960, 976}}
	NMT = {
		Shape1032,
		Shape2032,
		Shape3032,
		Shape4032,
		Shape5032
	}
	HMT = {
		Shape1020,
		Shape2020,
		Shape3020,
		Shape4020,
		Shape5020
	}
	for i = 0, 4 do
		CSPlot(NMT[i+1], i, 32, 0, {0,0}, 1, 32, FP, {HumanCheck(i,1)})
		CSPlot(HMT[i+1], i, 20, 0, {0,0}, 1, 32, FP, {HumanCheck(i,1)})
		TriggerX(FP, {HumanCheck(i, 1)}, {SetCp(i),RunAIScriptAt("Enter Transport", 64),SetCp(FP)})
	end

--	Trigger2X(FP,{},{RotatePlayer({PlayWAVX("sound\\Misc\\TRescue.wav"),PlayWAVX("staredit\\wav\\Computer Beep.wav"),DisplayTextX("\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04\n\x13\x04\n\x13\x04마린키우기 \x03산들바람 \x08지옥\n\x13\x04\n\x13\x03Creator \x04: GALAXY_BURST\n\x13\x04\n\x13\x042024 "..VerText.." \n\x13\x04\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――")}, HumanPlayers, FP)})
	Trigger2X(FP, {CV(SetPlayers,1)},{SetResources(Force1, Add, 30000, Ore),RotatePlayer({DisplayTextX(StrDesignX("솔로 플레이 보너스 \x04: \x1F30000 ore"), 4)}, HumanPlayers, FP)})
	CIfEnd()
	


    

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
		for j,k in pairs(KillPointArr) do
			TriggerX(i, {Kills(i, AtLeast, 1, k[1])}, {SetKills(i, Subtract, 1, k[1]),SetScore(i, Add, k[2], Kills),PlayWAV("staredit\\wav\\Herokill.ogg"),DisplayText(StrDesignX(k[3].."\x07개인 처치 보상 \x04: \x1F＋ "..N_to_EmN(k[2]).." \x03Ｐｔｓ"), 4)},{preserved})
		end
		Trigger2X(i,{Kills(i,AtLeast,1,176)},{SetKills(i,Subtract,1,176),SetScore(i,Add,150000,Kills)},{preserved})
		Trigger2X(i,{Kills(i,AtLeast,1,177)},{SetKills(i,Subtract,1,177),SetScore(i,Add,150000,Kills)},{preserved})
		Trigger2X(i,{Kills(i,AtLeast,1,178)},{SetKills(i,Subtract,1,178),SetScore(i,Add,150000,Kills)},{preserved})

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

		UnitButton(i,82,nil,{SetCp(i),
			DisplayText(StrDesign("\x1DM\x04arine을 \x19소환\x04하였습니다. - \x1F"..NMCost.." O r e"),4);
			CreateUnit(1, 32, 6, i),SetCp(FP)
		})
		UnitButton(i,8,{CD(GMode,2,AtMost)},{SetCp(i),
			DisplayText(StrDesign("\x1DS\x04pecial \x1DM\x04arine 을 \x19소환\x04하였습니다. - \x1F"..NMCost+HMCost+SMCost.." O r e"),4);
			CreateUnit(1, 10, 6, i),SetCp(FP)
		})
		UnitButton(i,8,{CD(GMode,3,AtLeast)},{SetCp(i),
			DisplayText(StrDesign("\x1BH\x04ero M\x04arine을 2기 \x19소환\x04하였습니다. - \x1F"..NMCost+HMCost+SMCost.." O r e"),4);
			CreateUnit(2, 20, 6, i),SetCp(FP)
		})
		UnitButton(i,7,{},{SetCp(i),
			DisplayText(StrDesign("\x19R\x04espect M\x19arine을 \x19소환\x04하였습니다. - \x1F"..NMCost+HMCost+SMCost+RMCost.." O r e"),4);
			CreateUnit(1, MarID[i+1], 6, i),SetCp(FP)
		})
		
	

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
			--TriggerX(FP,{CD(TestMode,1)},{SetMemoryB(0x58D2B0+15+(i*46),SetTo,255),SetMemoryB(0x58D2B0+7+(i*46),SetTo,255),SetMemoryB(0x58D2B0+(i*46),SetTo,255)})--SetV(CurEXP,0x7FFFFFFF)
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
		CIf(FP,{CDeaths(FP,AtMost,0,BanCode2[i+1]),Score(i,Kills,AtLeast,1000)})
		CMov(FP,ExchangeP,_Div(_ReadF(0x581F04+(i*4)),_Mov(1000)))
		CMov(FP,0x581F04+(i*4),_Mod(_ReadF(0x581F04+(i*4)),_Mov(1000)))
		CIfX(FP, {Memory(0x582294+(4*i),AtLeast,1200)})
		CAdd(FP,0x57F0F0+(i*4),_Mul(_Mul(ExchangeP,_Mov(10)),_Mul(ExRate, 5)))
		CElseX()
		CAdd(FP,0x57F0F0+(i*4),_Mul(_Mul(ExchangeP,_Mov(10)),ExRate))
		CIfXEnd()

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
DisplayPrint(HumanPlayers, {"\x12"..StrD[1],PName(i)," \x04님이 \x19Fever Power \x04를 사용했습니다."..StrD[2]})
DoActions(FP, {RotatePlayer({PlayWAVX("staredit\\wav\\ADUse.ogg"),PlayWAVX("staredit\\wav\\ADUse.ogg"),PlayWAVX("staredit\\wav\\ADUse.ogg"),PlayWAVX("staredit\\wav\\ADUse.ogg")},HumanPlayers,FP);})
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
		DisplayText(StrDesign("\x19Fever Power \x04사용이 종료되었습니다."),4);
		PlayWAV("staredit\\wav\\ADEnd.ogg");
		PlayWAV("staredit\\wav\\ADEnd.ogg");
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
		DisplayText(StrDesign("\x19Fever Power \x04쿨타임이 종료되었습니다."),4);
		PlayWAV("staredit\\wav\\CTEnd.ogg");
		PlayWAV("staredit\\wav\\CTEnd.ogg");
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
	GT = {"\x08H\x04D \x08S\x04tyle","\x16M\x04X \x16S\x04tyle","\x11S\x04C \x11S\x04tyle"}
	for i = 1, 3 do
		
	Trigger { -- 킬 포인트 리더보드,
	players = {FP},
	conditions = {
		Label(0);
		CD(GMode,i),
		CDeaths(FP,AtMost,0,LeaderBoardT);
	},
	actions = {
		LeaderBoardScore(Kills, StrDesign("\x1DP\x04oints".." - "..GT[i]));
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
		CD(GMode,i),
		
		CDeaths(FP,Exactly,400,LeaderBoardT);
	},
	actions = {
		LeaderBoardScore(Custom, StrDesign("\x08D\x04eaths".." - "..GT[i]));
		LeaderBoardComputerPlayers(Disable);
		PreserveTrigger();
},
}
Trigger { -- 킬 스코어 리더보드
	players = {FP},
	conditions = {
		Label(0);
		CD(GMode,i),
		CDeaths(FP,Exactly,200,LeaderBoardT);
	},
	actions = {
		LeaderBoardKills("Any unit",StrDesign("\x11K\x04ills".." - "..GT[i]));
		LeaderBoardComputerPlayers(Disable);
		PreserveTrigger();
},
}

	end
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