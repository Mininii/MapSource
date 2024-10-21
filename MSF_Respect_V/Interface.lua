function Interface()
	local BanCode = CreateCcodeArr(7)
    count = CreateVar(FP)
    f_Read(FP, 0x6283F0, count)
	CMov(FP,0x582144+(4*5),3000)
	CMov(FP,0x582174+(4*5),count)
	CAdd(FP,0x582174+(4*5),count)
	

	Dt = IBGM_EPD(FP, {P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12}, BGMType, {
		{1,"staredit\\wav\\BGM_OP.ogg",96*1000},
		{2,"staredit\\wav\\BGM_BlueWhite.ogg",35*1000},
		{3,"staredit\\wav\\BGM_OnlyForYou.ogg",39*1000},
		{4,"staredit\\wav\\BGM_Kamui.ogg",77*1000},
		{5,"staredit\\wav\\BGM_ALiCE.ogg",43*1000},
		{6,"staredit\\wav\\BGM_ECiLA.ogg",40*1000},
		{7,"staredit\\wav\\BGM_D2.ogg",37*1000},
		{8,"staredit\\wav\\BGM_OBLIVION.ogg",48*1000},
		{9,"staredit\\wav\\BGM_Hypernaid.ogg",98*1000},
		{10,"staredit\\wav\\BGM_Mysti_Era_Mui.ogg",68*1000},
		{11,"staredit\\wav\\BGM_NewGameStart.ogg",115*1000},
		{12,"staredit\\wav\\BGM_OverMe.ogg",111*1000},
		{13,"staredit\\wav\\BGM_EnemyStorm.ogg",107*1000},
		{14,"staredit\\wav\\BGM_Diomedes.ogg",41*1000},
		{15,"staredit\\wav\\BGM_Dream_it.ogg",44*1000},
		{16,"staredit\\wav\\BGM_Blythe.ogg",92*1000},
		{17,"staredit\\wav\\BGM_Black_Swan.ogg",76*1000},
		{18,"staredit\\wav\\BGM_Launcher.ogg",57*1000},
		{19,"staredit\\wav\\BGM_Miles.ogg",44*1000},
		{20,"staredit\\wav\\BGM_DontDie.ogg",78*1000},
		{21,"staredit\\wav\\BGM_Daydream.ogg",44*1000},
		{22,"staredit\\wav\\BGM_Hello.ogg",49*1000},
		{23,"staredit\\wav\\BGM_DIE_IN.ogg",96*1000},
		{24,"staredit\\wav\\BGM_ReBIRTH.ogg",60*1000},
		{25,"staredit\\wav\\BGM_Omen.ogg",44*1000},
		{26,"staredit\\wav\\BGM_Summer2017.ogg",50*1000},
		{27,"staredit\\wav\\BGM_SpaceofSoul.ogg",76*1000},
		{28,"staredit\\wav\\BGM_OP_DLC.ogg",127*1000},
		{29,"staredit\\wav\\BGM_OP_DLC2.ogg",125*1000},
		
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
	DoActions(FP, {
		SetMemoryB(0x57F27C + (0 * 228) + 62,SetTo,0),
		SetMemoryB(0x57F27C + (0 * 228) + 63,SetTo,0),
		SetMemoryB(0x57F27C + (1 * 228) + 62,SetTo,0),
		SetMemoryB(0x57F27C + (1 * 228) + 63,SetTo,0),
		SetMemoryB(0x57F27C + (2 * 228) + 62,SetTo,0),
		SetMemoryB(0x57F27C + (2 * 228) + 63,SetTo,0),
		SetMemoryB(0x57F27C + (3 * 228) + 62,SetTo,0),
		SetMemoryB(0x57F27C + (3 * 228) + 63,SetTo,0),
		SetMemoryB(0x57F27C + (4 * 228) + 62,SetTo,0),
		SetMemoryB(0x57F27C + (4 * 228) + 63,SetTo,0),}, 1)
	local DelayMedic = CreateCcodeArr(7)
	local GiveRate = CreateCcodeArr(7)
	local CurrentOP = CreateVar(FP)
	local Cunit2 = CreateVar(FP)
    CIfX(FP,Never()) -- 상위플레이어 단락 시작
        for i = 0, 4 do
            CElseIfX(HumanCheck(i,1),{SetCVar(FP,CurrentOP[2],SetTo,i),SetMemoryB(0x57F27C + (i * 228) + 62,SetTo,1),SetMemoryB(0x57F27C + (i * 228) + 63,SetTo,1)})
			TriggerX(FP, {CD(GS,0)}, {GiveUnits(All, 96, AllPlayers, 64, i),},{preserved})
			TriggerX(FP, {CD(GS,1)}, {GiveUnits(All, 96, AllPlayers, 41, i),},{preserved})
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
	for i= 0, 3 do
		TriggerX(FP,{Bring(Force1, Exactly, 1, 96, 43+i)},{SetV(SpeedVar,4+(i*2))},{preserved})
	end
	-- P6 255
	-- P7 42
	-- P8 128
	--if TestStart == 1 then
	--	CDoActions(FP, {
	--		TBwrite(0x581DD6+7, SetTo, TestVar);
	--		TBwrite(0x581D76+(8*7), SetTo, TestVar);
	--		TSetResources(Force1, SetTo, TestVar, Gas)
	--	})
	--end

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
			SetMemory(0x5124F0,SetTo,SpeedV[i]);SetV(CurSpeed,SpeedV[i])},{preserved})
	end
	CIfEnd()


	if Limit == 1 then
		CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
		TestCode = CreateCcode()
		TestCode2 = CreateCcode()
		TriggerX(FP, {Deaths(CurrentPlayer,AtLeast,1,198)},AddCD(TestCode,1) , {preserved})
		TriggerX(FP, {Deaths(CurrentPlayer,AtLeast,1,196)},AddCD(TestCode2,1) , {preserved})
		TriggerX(FP,{ElapsedTime(20, AtMost),Switch("Switch 253",Set),Deaths(CurrentPlayer,AtLeast,1,199)},{SetCD(TestMode,1),SetSwitch("Switch 254",Set),SetMemory(0x657A9C,SetTo,31),SetDeaths(CurrentPlayer, SetTo, 0, 199)})
		CIf(FP,CD(TestMode,1)) -- 테스트 트리거
		--DoActions(FP, {RemoveUnit("Men",Force2);})

		
		CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
		KillTable = {}
		KillTable2 = {}
		for j,k in pairs(UnitPointArr) do
			table.insert(KillTable, KillUnit(k[1], Force2))
		end
		for j,k in pairs(f_GunTable) do
			table.insert(KillTable2, ModifyUnitEnergy(All, k, Force2, 64, 0))
			table.insert(KillTable2, KillUnit(k, Force2))
		end
		table.insert(KillTable2, KillUnit("Any unit", Force2))
		table.insert(KillTable2, SetCD(WinCcode,480))
		table.insert(KillTable2, SetResources(Force1, Add, 322322322, OreAndGas))
			Trigger2X(FP, {Deaths(CurrentPlayer,AtLeast,1,204),CD(GS,1);}, KillTable, {preserved})
			Trigger2X(FP, {Deaths(CurrentPlayer,AtLeast,1,210),CD(GS,1);}, KillTable2, {preserved})
			Trigger {
				players = {FP},
				conditions = {
					Label(0);
					CD(GS,1);
					Deaths(CurrentPlayer,AtLeast,1,204)
				},
				actions = {
					KillUnit("Men",Force2);
					--KillUnitAt(1, "Buildings", 64, Force2),
					--KillUnit(143,Force2);
					--KillUnit(144,Force2);
					--KillUnit(146,Force2);
					--KillUnit(138,Force2);
					--KillUnit(136,Force2);
					--KillUnit(137,Force2);
					--KillUnit(139,Force2);
					--KillUnit(140,Force2);
					--KillUnit(141,Force2);
					--KillUnit(142,Force2);
					--KillUnit(143,Force2);
					--KillUnit(144,Force2);
					--KillUnit(146,Force2);
					--KillUnit(134,Force2);
					
					PreserveTrigger();
				}
				}
			TestUPtr = CreateVar(FP)
			if HeroTestMode==1 then
				local TempUID = CreateVar(FP)
				CIf(FP,{Deaths(CurrentPlayer,AtLeast,1,199),CD(GS,1);}) -- F12 누르면 선택한 유닛 12마리가 적으로 출현함
					f_SaveCp()
					CIf(FP,{CVar(FP,Cunit2[2],AtLeast,1),CVar(FP,Cunit2[2],AtMost,0x7FFFFFFF)})
					f_Read(FP, _Add(Cunit2,25), TempUID, nil, 0xFF, 1)
					CIf(FP,{
						TTCVar(FP,TempUID[2],NotSame,49,0xFF),
						TTCVar(FP,TempUID[2],NotSame,111,0xFF),
						TTCVar(FP,TempUID[2],NotSame,107,0xFF)})
					DoActions(FP, {Simple_SetLoc(0, 576,832,576,832)})
					f_TempRepeatX({},TempUID,1,2,FP)
					CIfEnd()
					CIfEnd()
					f_LoadCp()
				CIfEnd()
				

			end
			
			CTrigger(FP,{Deaths(CurrentPlayer,AtLeast,1,197),CD(GS,1);},{TCreateUnitWithProperties(12,20,_Add(CurrentOP,21),CurrentOP,{energy=100})},{preserved}) -- F12 누르면 마린소환
			for i = 0, 4 do
				CTrigger(FP,{Deaths(CurrentPlayer,AtLeast,1,189),CD(GS,1);CV(CurrentOP,i)},{TCreateUnitWithProperties(12,MarID[i+1],_Add(CurrentOP,21),CurrentOP,{energy=100})},{preserved}) -- F8 누르면 마린소환
			end
			--CTrigger(FP,{Deaths(CurrentPlayer,AtLeast,1,199)},{TCreateUnit(12, 20, _Add(CurrentOP,65), CurrentOP)},{preserved})
			CTrigger(FP,{Deaths(CurrentPlayer,AtLeast,1,199)},{SetV(TestUPtr,Cunit2)},{preserved})
			CIf(FP,{CVar(FP,TestUPtr[2],AtLeast,1),CVar(FP,TestUPtr[2],AtMost,0x7FFFFFFF)})
				CDoActions(FP,{TSetMemoryX(_Add(CurrentOP,EPD(0x57f120)),SetTo,_Div(_Read(_Add(TestUPtr,19)),256),0xFF)})
			CIfEnd()
	
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
				CIf(FP,Deaths(CurrentPlayer,AtLeast,1,208))
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
					MoveCp(Add,21*4);
					SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF000000);
					MoveCp(Subtract,15*4);
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
				TmpGunNum = CreateVarArr(6,FP)
				f_Read(FP, TtoA("VisionTurbo"), TmpGunNum[1])
				--DisplayPrintEr(CurrentOP, {
				--	"SeekOffset : ",TmpGunNum[1],
				--})
					
				CDoActions(FP,{TSetMemoryX(_Add(Cunit2,35),SetTo,_Mul(_Read(BackupCp),65536),0xFF000000)})
				f_LoadCp()
	
			CIfEnd()
		CIfEnd()
	
		end

		CMov(FP,0x6509B0,FP)--상위플레이어 단락

    for i = 0, 4 do
		TriggerX(FP,{HumanCheck(i, 0)},{SetCDeaths(FP,Add,10,PExitFlag)}) -- 나갔을 경우 1회에 한해 인구수 계산기 작동
        DoActions(i,{SetCp(i),SetAllianceStatus(Force1,Ally),--팀킬방지
        RunAIScript("Turn ON Shared Vision for Player 1");
        RunAIScript("Turn ON Shared Vision for Player 2");
        RunAIScript("Turn ON Shared Vision for Player 3");
        RunAIScript("Turn ON Shared Vision for Player 4");
        RunAIScript("Turn ON Shared Vision for Player 5");
        RunAIScript("Turn ON Shared Vision for Player 6");
        })
		TriggerX(i,{HumanCheck(i, 0)},{SetCDeaths(FP,Add,10,PExitFlag)}) -- 나갔을 경우 1회에 한해 인구수 계산기 작동
    end
	DoActions(P6,{
	RunAIScript("Turn ON Shared Vision for Player 6");
	RunAIScript("Turn ON Shared Vision for Player 7");
	RunAIScript("Turn ON Shared Vision for Player 8");
	})
	DoActions(P7,{
	RunAIScript("Turn ON Shared Vision for Player 6");
	RunAIScript("Turn ON Shared Vision for Player 7");
	RunAIScript("Turn ON Shared Vision for Player 8");
	})
	DoActions(P8,{SetCp(FP),
	RunAIScript("Turn ON Shared Vision for Player 6");
	RunAIScript("Turn ON Shared Vision for Player 7");
	RunAIScript("Turn ON Shared Vision for Player 8");
	})
	DoActions(FP,{ -- 나간플레이어 유닛 삭제
		KillUnit(MarID[1], P12),
		KillUnit(MarID[2], P12),
		KillUnit(MarID[3], P12),
		KillUnit(MarID[4], P12),
		KillUnit(MarID[5], P12),
		KillUnit(20, P12),
		KillUnit(32, P12),
		KillUnit(10, P12),
	})
	GST = CreateCcode()
	GST2 = CreateCcode()
	SelEPD = CreateVar(FP)
	SelUID = CreateVar(FP)
	CurEPD = CreateVar(FP)
	
	CIf(FP,{CD(GS,0)},{AddCD(GST2,1)})--MoveUnit(All, 0, Force1, 64, 46),MoveUnit(All, 20, Force1, 64, 46)
	tt = "\x13\x1ET\x04hanks \x1CT\x04o : CheezeNacho, Marine_T_T, Hybrid)_GOD60, Mint22, AwakenSense, Mystia_Lorelei, Standible"
	TriggerX(FP, {},{RotatePlayer({PlayWAVX("staredit\\wav\\scan.wav"),PlayWAVX("staredit\\wav\\scan.wav"),PlayWAVX("staredit\\wav\\scan.wav")}, HumanPlayers, FP)})
	TriggerX(FP, {CD(GST2,299-#tt,AtLeast)},{RotatePlayer({PlayWAVX("staredit\\wav\\scanr.wav"),PlayWAVX("staredit\\wav\\scanr.wav"),PlayWAVX("staredit\\wav\\scanr.wav")}, HumanPlayers, FP)})
	
	
	
	if Limit == 1 then
		for i = 1, 150 do
			local rep = i
			if rep>= 57 then rep = 57 end  
			Trigger2X(FP, {CD(GST2,i)}, 
			{RotatePlayer({DisplayTextX(string.rep("\n", 5),4),
			DisplayTextX("\x13\x04"..string.rep("―", rep),4),
			DisplayTextX(string.sub("\x13"..MapText[DLC_Project+1],1,i),4),
			DisplayTextX(string.sub("\x13\x1FSTRCtrig \x04Assembler \x07v5.4\x04, \x1FCB \x16Paint \x07v2.4 \x04in Used \x19(つ>ㅅ<)つ",1,i),4),
			DisplayTextX(string.sub("\x13\x0Fⓒ \x08NEOWIZ\x04, \x17DJMAX\x04. \x07A\x04ll \x1BR\x04ights \x11R\x04eserved.",1,i),4),
			DisplayTextX(string.sub("\x13\x03TESTMODE OP \x04: "..G_CB_ShNm.." Shapes Initiated",1,i),4),
			DisplayTextX(string.sub("\x13\x1BC\x04reated \x1BB\x04y : GALAXY_BURST",1,i),4),
			DisplayTextX(string.sub("\x13\x1FI\x04nspirated to \x03MSF \x11R\x04espect. \x18B\x04y.\x1DSANDELE",1,i),4),
			DisplayTextX(string.sub(tt,1,i),4),
			DisplayTextX(string.sub("\x13\x1ES\x04pecial \x1ET\x04hanks : \x1DSANDELE\x04, And \x07All \x19DJMAX Respect V \x07U\x04sers",1,i),4),
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
			DisplayTextX(string.sub("\x13"..MapText[DLC_Project+1],1,i),4),
			DisplayTextX(string.sub("\x13\x1FSTRCtrig \x04Assembler \x07v5.4\x04, \x1FCB \x16Paint \x07v2.4 \x04in Used \x19(つ>ㅅ<)つ",1,i),4),
			DisplayTextX(string.sub("\x13\x0Fⓒ \x08NEOWIZ\x04, \x17DJMAX\x04. \x07A\x04ll \x1BR\x04ights \x11R\x04eserved.",1,i),4),
			DisplayTextX(string.sub("\x13\x03TESTMODE OP \x04: "..G_CB_ShNm.." Shapes Initiated",1,i),4),
			DisplayTextX(string.sub("\x13\x1BC\x04reated \x1BB\x04y : GALAXY_BURST",1,i),4),
			DisplayTextX(string.sub("\x13\x1FI\x04nspirated to \x03MSF \x11R\x04espect. \x18B\x04y.\x1DSANDELE",1,i),4),
			DisplayTextX(string.sub(tt,1,i),4),
			DisplayTextX(string.sub("\x13\x1ES\x04pecial \x1ET\x04hanks : \x1DSANDELE\x04, And \x07All \x19DJMAX Respect V \x07U\x04sers",1,i),4),
			DisplayTextX("\x13\x04"..string.rep("―", rep),4)}, HumanPlayers, FP)
				})
		end
	
	else
		for i = 1, 150 do
			local rep = i
			if rep>= 57 then rep = 57 end  
			Trigger2X(FP, {CD(GST2,i)}, 
			{RotatePlayer({DisplayTextX(string.rep("\n", 5),4),
			DisplayTextX("\x13\x04"..string.rep("―", rep),4),
			DisplayTextX(string.sub("\x13"..MapText[DLC_Project+1],1,i),4),
			DisplayTextX(string.sub("\x13\x1FSTRCtrig \x04Assembler \x07v5.4\x04, \x1FCB \x16Paint \x07v2.4 \x04in Used \x19(つ>ㅅ<)つ",1,i),4),
			DisplayTextX(string.sub("\x13\x0Fⓒ \x08NEOWIZ\x04, \x17DJMAX\x04. \x07A\x04ll \x1BR\x04ights \x11R\x04eserved.",1,i),4),
			DisplayTextX("\x13\x04",4),
			DisplayTextX(string.sub("\x13\x1BC\x04reated \x1BB\x04y : GALAXY_BURST",1,i),4),
			DisplayTextX(string.sub("\x13\x1FI\x04nspirated to \x03MSF \x11R\x04espect. \x18B\x04y.\x1DSANDELE",1,i),4),
			DisplayTextX(string.sub(tt,1,i),4),
			DisplayTextX(string.sub("\x13\x1ES\x04pecial \x1ET\x04hanks : \x1DSANDELE\x04, And \x07All \x19DJMAX Respect V \x07U\x04sers",1,i),4),
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
			DisplayTextX(string.sub("\x13"..MapText[DLC_Project+1],1,i),4),
			DisplayTextX(string.sub("\x13\x1FSTRCtrig \x04Assembler \x07v5.4\x04, \x1FCB \x16Paint \x07v2.4 \x04in Used \x19(つ>ㅅ<)つ",1,i),4),
			DisplayTextX(string.sub("\x13\x0Fⓒ \x08NEOWIZ\x04, \x17DJMAX\x04. \x07A\x04ll \x1BR\x04ights \x11R\x04eserved.",1,i),4),
			DisplayTextX("\x13\x04",4),
			DisplayTextX(string.sub("\x13\x1BC\x04reated \x1BB\x04y : GALAXY_BURST",1,i),4),
			DisplayTextX(string.sub("\x13\x1FI\x04nspirated to \x03MSF \x11R\x04espect. \x18B\x04y.\x1DSANDELE",1,i),4),
			DisplayTextX(string.sub(tt,1,i),4),
			DisplayTextX(string.sub("\x13\x1ES\x04pecial \x1ET\x04hanks : \x1DSANDELE\x04, And \x07All \x19DJMAX Respect V \x07U\x04sers",1,i),4),
			DisplayTextX("\x13\x04"..string.rep("―", rep),4)}, HumanPlayers, FP)
				})
		end
	
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
		if DLC_Project == 1 then

			TriggerX(FP, {CV(SelUID,199)}, {RotatePlayer({DisplayTextX(StrDesignX("\x08H\x04D \x08S\x04tyle").."\n"..StrDesignX("\x04- \x03위험도 \x04: \x07★★★ \x04-").."\n"..StrDesignX("\x04어느정도 어렵지만 입문용 난이도로 나쁘지 않습니다."), 4)}, HumanPlayers, FP)}, {preserved})
			TriggerX(FP, {CV(SelUID,198)}, {RotatePlayer({DisplayTextX(StrDesignX("\x16M\x04X \x16S\x04tyle").."\n"..StrDesignX("\x04- \x03위험도 \x04: \x08★★★★★★★★★ \x04-").."\n"..StrDesignX("\x08조심하십시오.. 매우 어렵습니다."), 4)}, HumanPlayers, FP)}, {preserved})
			TriggerX(FP, {CV(SelUID,197)}, {RotatePlayer({DisplayTextX(StrDesignX("\x10S\x04C \x10S\x04tyle").."\n"..StrDesignX("\x04- \x03위험도 \x04: \x11??? \x04-").."\n"..StrDesignX("\x11정의할 수 없는, 정리하지 못한 난이도입니다. "), 4)}, HumanPlayers, FP)}, {preserved})
			TriggerX(FP, {CV(SelUID,145)}, {RotatePlayer({DisplayTextX(StrDesignX("\x0FE\x04VF \x0FM\x04ode").."\n"..StrDesignX("\x04- \x03활성화 가능 옵션 \x04-").."\n"..StrDesignX("\x07속시원한 빠른 플레이\x04를 원할 경우 사용할 수 있습니다. ").."\n"..StrDesignX("\x03특징 : \x1B마린, 스킬 공격력 \x081.5배\x04, \x17Fever Power \x04활성화").."\n"..StrDesignX("\x17Fever Power \x04사용 중에는 모든 마린의 체력, 쉴드가 100%로 고정되고, 환전률 \x072배\x04가 적용되며 잠시동안 \x08공격속도\x04가 \x07매우 빨라집니다."), 4)}, HumanPlayers, FP)}, {preserved})
	
		else

			TriggerX(FP, {CV(SelUID,199)}, {RotatePlayer({DisplayTextX(StrDesignX("\x08H\x04D \x08S\x04tyle").."\n"..StrDesignX("\x04- \x03위험도 \x04: \x07★★★ \x04-").."\n"..StrDesignX("\x04어느정도 어렵지만 입문용 난이도로 나쁘지 않습니다.").."\n"..StrDesignX("\x03특징 : \x0ES\x04pecial \x0EM\x04arine, \x17R\x04espect \x17M\x04arine 을 사용할 수 있습니다."), 4)}, HumanPlayers, FP)}, {preserved})
			TriggerX(FP, {CV(SelUID,198)}, {RotatePlayer({DisplayTextX(StrDesignX("\x16M\x04X \x16S\x04tyle").."\n"..StrDesignX("\x04- \x03위험도 \x04: \x08★★★★★★★★★ \x04-").."\n"..StrDesignX("\x08조심하십시오.. 매우 어렵습니다.").."\n"..StrDesignX("\x03특징 : \x0ES\x04pecial \x0EM\x04arine, \x17R\x04espect \x17M\x04arine 을 사용할 수 있습니다."), 4)}, HumanPlayers, FP)}, {preserved})
			TriggerX(FP, {CV(SelUID,197)}, {RotatePlayer({DisplayTextX(StrDesignX("\x10S\x04C \x10S\x04tyle").."\n"..StrDesignX("\x04- \x03위험도 \x04: \x11??? \x04-").."\n"..StrDesignX("\x11정의할 수 없는, 정리하지 못한 난이도입니다. ").."\n"..StrDesignX("\x03특징 : \x1BH\x04ero \x1BM\x04arine 만 사용할 수 있습니다."), 4)}, HumanPlayers, FP)}, {preserved})
			TriggerX(FP, {CV(SelUID,145)}, {RotatePlayer({DisplayTextX(StrDesignX("\x0FE\x04VF \x0FM\x04ode").."\n"..StrDesignX("\x04- \x03활성화 가능 옵션 \x04-").."\n"..StrDesignX("\x07속시원한 빠른 플레이\x04를 원할 경우 사용할 수 있습니다. ").."\n"..StrDesignX("\x03특징 : \x1B마린 공격력 \x081.5배\x04, \x17Fever Power \x04활성화").."\n"..StrDesignX("\x17Fever Power \x04사용 중에는 모든 마린의 체력, 쉴드가 100%로 고정되고, 환전률 \x072배\x04가 적용됩니다."), 4)}, HumanPlayers, FP)}, {preserved})
	
		end
		CIfEnd()
	CIfEnd()
	CMov(FP,0x6509B0,FP)

	
if DLC_Project == 1 then
	Trigger2X(FP, {Bring(AllPlayers, AtLeast, 1, 96, 11)}, {SetCD(EVFCcode,1),RemoveUnit(145, AllPlayers),RotatePlayer({DisplayTextX("\n\n\n\n\n\n\n\n\n",4),DisplayTextX(StrDesignX("\x0FE\x04VF \x0FM\x04ode\x04가 활성화되었습니다.").."\n"..StrDesignX("\x1B마린 공격력 \x081.5배\x04, \x17Fever Power \x04활성화").."\n"..StrDesignX("\x17Fever Power \x04사용 중에는 모든 마린의 체력, 쉴드가 100%로 고정되고, 환전률 \x072배\x04가 적용되며 잠시동안 \x08공격속도\x04가 \x07매우 빨라집니다."), 4),PlayWAVX("staredit\\wav\\ADEnd.ogg"),PlayWAVX("staredit\\wav\\ADEnd.ogg"),PlayWAVX("staredit\\wav\\ADEnd.ogg")}, HumanPlayers, FP)})
else
	Trigger2X(FP, {Bring(AllPlayers, AtLeast, 1, 96, 11)}, {SetCD(EVFCcode,1),RemoveUnit(145, AllPlayers),RotatePlayer({DisplayTextX("\n\n\n\n\n\n\n\n\n",4),DisplayTextX(StrDesignX("\x0FE\x04VF \x0FM\x04ode\x04가 활성화되었습니다.").."\n"..StrDesignX("\x1B마린 공격력 \x081.5배\x04, \x17Fever Power \x04활성화").."\n"..StrDesignX("\x17Fever Power \x04사용 중에는 모든 마린의 체력, 쉴드가 100%로 고정되고, 환전률 \x072배\x04가 적용됩니다."), 4),PlayWAVX("staredit\\wav\\ADEnd.ogg"),PlayWAVX("staredit\\wav\\ADEnd.ogg"),PlayWAVX("staredit\\wav\\ADEnd.ogg")}, HumanPlayers, FP)})
end


	
	Trigger2X(FP, {Bring(AllPlayers, AtLeast, 1, 96, 8)}, {SetCD(GST,1),RemoveUnit(96, AllPlayers),SetCD(GMode,1)})
	Trigger2X(FP, {Bring(AllPlayers, AtLeast, 1, 96, 12)}, {SetCD(GST,1),RemoveUnit(96, AllPlayers),SetCD(GMode,2)})
	Trigger2X(FP, {Bring(AllPlayers, AtLeast, 1, 96, 9)}, {SetCD(GST,1),RemoveUnit(96, AllPlayers),SetCD(GMode,3)})
	
	TriggerX(FP, {CD(GST,1,AtLeast)},{SetV(SpeedVar,4),SetCD(GS,1),RotatePlayer({PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")}, HumanPlayers, FP)},{preserved})
	CIfEnd()
	local BGMAct
	if DLC_Project == 1 then
		BGMAct = SetV(BGMType,28)
	else
		BGMAct = SetV(BGMType,1)
	end
	if TestStart == 1 then BGMAct = SetV(BGMType,0) end

	CIfOnce(FP,{CD(GS,1)},{SetCDeaths(FP,Add,10,PExitFlag),
		BGMAct,
		ModifyUnitEnergy(All, "Any unit", AllPlayers, 64, 100);
		SetResources(Force2, SetTo, 99999999, OreAndGas),
		SetCp(FP),
		RunAIScriptAt("Expansion Zerg Campaign Insane","AI"),
		RunAIScriptAt("Value This Area Higher",6),
		SetCp(P7),
		RunAIScriptAt("Expansion Zerg Campaign Insane","AI"),
		RunAIScriptAt("Value This Area Higher",6),
		SetResources(Force1, Add, 25000, Ore),
		RemoveUnit(199, AllPlayers),
		RemoveUnit(198, AllPlayers),
		RemoveUnit(197, AllPlayers),
		RemoveUnit(145, AllPlayers),
		SetMemory(0x582144 + (4 * 6),SetTo,1600);
		SetMemory(0x5821A4 + (4 * 6),SetTo,1600);
		SetMemory(0x582144 + (4 * 7),SetTo,1600);
		SetMemory(0x5821A4 + (4 * 7),SetTo,1600);
		SetCp(FP);RemoveUnit(101,P6),
		SetMemoryB(0x57F27C + (0 * 228) + 74,SetTo,0),
		SetMemoryB(0x57F27C + (1 * 228) + 74,SetTo,0),
		SetMemoryB(0x57F27C + (2 * 228) + 74,SetTo,0),
		SetMemoryB(0x57F27C + (3 * 228) + 74,SetTo,0),
		SetMemoryB(0x57F27C + (4 * 228) + 74,SetTo,0)
	})
	  

	if DLC_Project == 1 then
		TriggerX(FP, (CD(GMode,3)), {SetV(BGMType,29),
		SetPlayerColor(P6, SetTo, 188);
		SetPlayerColor(P7, SetTo, 160);
		SetPlayerColor(P8, SetTo, 173);
		SetMinimapColor(P6, SetTo, 188),
		SetMinimapColor(P7, SetTo, 160),
		SetMinimapColor(P8, SetTo, 173),})
		
	end
	CDoActions(FP, {TCreateUnit(1, 96, 40, CurrentOP)})
	for i = 0, 4 do
		f_TempRepeat({HumanCheck(i, 1)}, 96, 1, "BanUnit", i, {2896,112})
	end
	if TestStart == 0 then
		DoActions(FP,{KillUnit(218, AllPlayers),KillUnit(128, AllPlayers),KillUnit(129, AllPlayers)})
	end
	if Limit == 1 then
		GSEnable = CreateCcode()
		TriggerX(FP, {CD(TestCode,4),CD(TestCode2,3)}, {SetCD(GSEnable,1)})
		Trigger2X(FP, {
			Memory(0x6D0F38,AtLeast,GlobalTime);
			CD(GSEnable,0)
		}, {
				RotatePlayer({
					DisplayTextX(StrDesignX("\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.").."\n"..StrDesignX("\x04실행 방지 코드 0x32223223 작동."),4);
				Defeat();
				},HumanPlayers,FP);
				Defeat();
				SetMemory(0xCDDDCDDC,SetTo,1);})
		
	end
if DLC_Project == 1 then
	for j = 1, 3 do
			
			for p = 1, 5 do
				local TT = "\x13\x04마린키우기 \x17R\x04espect \x17V \x06L\x11I\x17B\x18E\x1CR\x0ET\x10Y\n\x13"..MSDiff[j].." "..string.char(ColorCode[p])..p.."인 \x17환전률 : \x1B"..ExRateT[j][p].."%\n\x13\x04Marine + \x1F"..HMCost.." Ore\x04 = \x1BH\x04ero \x1BM\x04arine\n\x13\x1BH\x04ero \x1BM\x04arine * 12 + \x1F"..SMCost.." Ore \x04= \x1DS\x04pecial \x1DM\x04arine (MAX 1)\n\x13\x1DS\x04pecial \x1DM\x04arine + \x1F"..RMCost.." Ore \x04= \x19R\x04espect \x19M\x04arine (MAX 1)"
				Trigger2X(FP, {CD(GMode,j),CV(SetPlayers,p)}, {
					RotatePlayer({SetMissionObjectivesX(TT)},HumanPlayers,FP);
					SetCVar(FP,ExRate[2],SetTo,ExRateT[j][p]);})
			end
	
	end
else
	for j = 1, 3 do
			local TT
			if j == 3 then TT = "\x13\x04마린키우기 \x17R\x04espect \x17V\n\x13"..MSDiff[j].." \x17환전률 : \x1B"..ExRateT[j].."%\n\x13\x04Marine + \x1F"..HMCost.." Ore\x04 = \x1BH\x04ero \x1BM\x04arine"
			else TT = "\x13\x04마린키우기 \x17R\x04espect \x17V\n\x13"..MSDiff[j].." \x17환전률 : \x1B"..ExRateT[j].."%\n\x13\x04Marine + \x1F"..HMCost.." Ore\x04 = \x1BH\x04ero \x1BM\x04arine\n\x13\x1BH\x04ero \x1BM\x04arine + \x1F"..SMCost.." Ore \x04= \x1DS\x04pecial \x1DM\x04arine\n\x13\x1DS\x04pecial \x1DM\x04arine + \x1F"..RMCost.." Ore \x04= \x19R\x04espect \x19M\x04arine"
			end
			Trigger2X(FP, {CD(GMode,j)}, {
				RotatePlayer({SetMissionObjectivesX(TT)},HumanPlayers,FP);
				SetCVar(FP,ExRate[2],SetTo,ExRateT[j]);})
	
	end
end

	if DLC_Project== 0 then
		TriggerX(FP, {CD(EVFCcode,0)}, {
			SetMemoryB(0x57F27C + (0 * 228) + 19,SetTo,0),
			SetMemoryB(0x57F27C + (1 * 228) + 19,SetTo,0),
			SetMemoryB(0x57F27C + (2 * 228) + 19,SetTo,0),
			SetMemoryB(0x57F27C + (3 * 228) + 19,SetTo,0),
			SetMemoryB(0x57F27C + (4 * 228) + 19,SetTo,0),
		})
		TriggerX(FP, {CD(GMode,3)}, {SetMemoryB(0x663CE8 + 8,SetTo,4),
		SetMemoryB(0x57F27C + (0 * 228) + 7,SetTo,0),
		SetMemoryB(0x57F27C + (1 * 228) + 7,SetTo,0),
		SetMemoryB(0x57F27C + (2 * 228) + 7,SetTo,0),
		SetMemoryB(0x57F27C + (3 * 228) + 7,SetTo,0),
		SetMemoryB(0x57F27C + (4 * 228) + 7,SetTo,0),
		SetMemoryB(0x57F27C + (0 * 228) + 12,SetTo,0),
		SetMemoryB(0x57F27C + (1 * 228) + 12,SetTo,0),
		SetMemoryB(0x57F27C + (2 * 228) + 12,SetTo,0),
		SetMemoryB(0x57F27C + (3 * 228) + 12,SetTo,0),
		SetMemoryB(0x57F27C + (4 * 228) + 12,SetTo,0),})
		TriggerX(FP, {CD(EVFCcode,1)}, {
			SetMemoryW(0x656EB0+(0 *2),Add,3), -- 공격력
			SetMemoryW(0x657678+(0 *2),Add,2), -- 추가공격력
			SetMemoryW(0x656EB0+(1 *2),Add,HMBaseAtk/2), -- 공격력
			SetMemoryW(0x657678+(1 *2),Add,HMFactorAtk/2), -- 추가공격력
			SetMemoryW(0x656EB0+(2 *2),Add,SMBaseAtk/2), -- 공격력
			SetMemoryW(0x657678+(2 *2),Add,SMFactorAtk/2), -- 추가공격력
			SetMemoryW(0x656EB0+(3 *2),Add,RMBaseAtk/2), -- 공격력
			SetMemoryW(0x657678+(3 *2),Add,RMFactorAtk/2), -- 추가공격력
			
	})
	else
		TriggerX(FP, {CD(EVFCcode,0)}, {
			SetMemoryB(0x57F27C + (0 * 228) + 19,SetTo,0),
			SetMemoryB(0x57F27C + (1 * 228) + 19,SetTo,0),
			SetMemoryB(0x57F27C + (2 * 228) + 19,SetTo,0),
			SetMemoryB(0x57F27C + (3 * 228) + 19,SetTo,0),
			SetMemoryB(0x57F27C + (4 * 228) + 19,SetTo,0),
		})
		
	TriggerX(FP, {CD(EVFCcode,1)}, {
		SetMemoryW(0x656EB0+(0 *2),Add,3), -- 공격력
		SetMemoryW(0x657678+(0 *2),Add,2), -- 추가공격력
		SetMemoryW(0x656EB0+(1 *2),Add,HMBaseAtk/2), -- 공격력
		SetMemoryW(0x657678+(1 *2),Add,HMFactorAtk/2), -- 추가공격력
		SetMemoryW(0x656EB0+(2 *2),Add,SMBaseAtk/2), -- 공격력
		SetMemoryW(0x657678+(2 *2),Add,SMFactorAtk/2), -- 추가공격력
		SetMemoryW(0x656EB0+(3 *2),Add,RMBaseAtk/2), -- 공격력
		SetMemoryW(0x657678+(3 *2),Add,RMFactorAtk/2), -- 추가공격력
		
		SetMemoryW(0x656EB0+(119 *2),Add,SMSkillBaseAtk/2), -- 공격력
		SetMemoryW(0x657678+(119 *2),Add,SMSkillFactorAtk/2), -- 추가공격력
		SetMemoryW(0x656EB0+(120 *2),Add,RMSkillBaseAtk/2), -- 공격력
		SetMemoryW(0x657678+(120 *2),Add,RMSkillFactorAtk/2), -- 추가공격력
		SetMemoryW(0x656EB0+(121 *2),Add,SMSkillBaseAtk2/2), -- 공격력
		SetMemoryW(0x657678+(121 *2),Add,SMSkillFactorAtk2/2), -- 추가공격력
		SetMemoryW(0x656EB0+(122 *2),Add,SMSkillBaseAtk3/2), -- 공격력
		SetMemoryW(0x657678+(122 *2),Add,SMSkillFactorAtk3/2), -- 추가공격력
})
	
	end
	

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
		local MCT = {
		{NMCr[i+1],32,1500*256},
		{HMCr[i+1],20,3000*256},
		{SMCr[i+1],10,6000*256},
		{RMCr[i+1],MarID[i+1],5000*256}}
		for o = 2, #NMT[i+1] do
			CallTriggerX(FP, Call_MarCr,{HumanCheck(i,1),Memory(0x628438, AtLeast, 1)}, {
			SetV(MID,MCT[1][2]),
			SetV(MPID,i),
			SetV(MHP,MCT[1][3]),
			SetV(MPosX,NMT[i+1][o][1]),
			SetV(MPosY,NMT[i+1][o][2]),
		},1)
		end
		for o = 2, #HMT[i+1] do
			CallTriggerX(FP, Call_MarCr,{HumanCheck(i,1),Memory(0x628438, AtLeast, 1)}, {
			SetV(MID,MCT[2][2]),
			SetV(MPID,i),
			SetV(MHP,MCT[2][3]),
			SetV(MPosX,HMT[i+1][o][1]),
			SetV(MPosY,HMT[i+1][o][2]),
		},1)
		end
		--CSPlot(NMT[i+1], i, 32, 0, {0,0}, 1, 32, FP, {HumanCheck(i,1)})
		--CSPlot(HMT[i+1], i, 20, 0, {0,0}, 1, 32, FP, {HumanCheck(i,1)})
		TriggerX(FP, {HumanCheck(i, 1)}, {SetCp(i),RunAIScriptAt("Enter Transport", 64),SetCp(FP)})
	end

	Trigger2X(FP, {CV(SetPlayers,1)},{SetResources(Force1, Add, 30000, Ore),RotatePlayer({DisplayTextX(StrDesignX("솔로 플레이 보너스 \x04: \x1F30000 ore"), 4)}, HumanPlayers, FP)})
	CIfEnd()
	

	Shape6101 = {{2400, 284},{2912, 284},{3424, 284},{3936, 284},{4448, 284},{4960, 284},{5472, 284},{5984, 284},{6496, 284},{7008, 284},{7520, 284},{8032, 284},{2400, 796},{2912, 796},{3424, 796},{3936, 796},{4448, 796},{4960, 796},{5472, 796},{5984, 796},{6496, 796},{7008, 796},{7520, 796},{8032, 796},{2400, 1308},{2912, 1308},{3424, 1308},{3936, 1308},{4448, 1308},{4960, 1308},{5472, 1308},{5984, 1308},{6496, 1308},{7008, 1308},{7520, 1308},{8032, 1308},{2400, 1820},{2912, 1820},{3424, 1820},{3936, 1820},{4448, 1820},{4960, 1820},{5472, 1820},{5984, 1820},{6496, 1820},{7008, 1820},{7520, 1820},{8032, 1820},{2400, 2332},{2912, 2332},{3424, 2332},{3936, 2332},{4448, 2332},{4960, 2332},{5472, 2332},{5984, 2332},{6496, 2332},{7008, 2332},{7520, 2332},{8032, 2332},{2400, 2844},{2912, 2844},{3424, 2844},{3936, 2844},{4448, 2844},{4960, 2844},{5472, 2844},{5984, 2844},{6496, 2844},{7008, 2844},{7520, 2844},{8032, 2844},{2400, 3356},{2912, 3356},{3424, 3356},{3936, 3356},{4448, 3356},{4960, 3356},{5472, 3356},{5984, 3356},{6496, 3356},{7008, 3356},{7520, 3356},{8032, 3356},{2400, 3868},{2912, 3868},{3424, 3868},{3936, 3868},{4448, 3868},{4960, 3868},{5472, 3868},{5984, 3868},{6496, 3868},{7008, 3868},{7520, 3868},{8032, 3868},{2400, 4380},{2912, 4380},{3424, 4380},{3936, 4380},{4448, 4380},{4960, 4380},{5472, 4380},{5984, 4380},{6496, 4380},{7008, 4380},{7520, 4380},{8032, 4380},{2400, 4892},{2912, 4892},{3424, 4892},{3936, 4892},{4448, 4892},{4960, 4892},{5472, 4892},{5984, 4892},{6496, 4892},{7008, 4892},{7520, 4892},{8032, 4892},{2400, 5404},{2912, 5404},{3424, 5404},{3936, 5404},{4448, 5404},{4960, 5404},{5472, 5404},{5984, 5404},{6496, 5404},{7008, 5404},{7520, 5404},{8032, 5404},{2400, 5916},{2912, 5916},{3424, 5916},{3936, 5916},{4448, 5916},{4960, 5916},{5472, 5916},{5984, 5916},{6496, 5916},{7008, 5916},{7520, 5916},{8032, 5916},{2400, 6428},{2912, 6428},{3424, 6428},{3936, 6428},{4448, 6428},{4960, 6428},{5472, 6428},{5984, 6428},{6496, 6428},{7008, 6428},{7520, 6428},{8032, 6428},{2400, 6940},{2912, 6940},{3424, 6940},{3936, 6940},{4448, 6940},{4960, 6940},{5472, 6940},{5984, 6940},{6496, 6940},{7008, 6940},{7520, 6940},{8032, 6940},{2400, 7452},{2912, 7452},{3424, 7452},{3936, 7452},{4448, 7452},{4960, 7452},{5472, 7452},{5984, 7452},{6496, 7452},{7008, 7452},{7520, 7452},{8032, 7452},{2400, 7964},{2912, 7964},{3424, 7964},{3936, 7964},{4448, 7964},{4960, 7964},{5472, 7964},{5984, 7964},{6496, 7964},{7008, 7964},{7520, 7964},{8032, 7964}}

	--TriggerX(FP,{CD(GS,1)},{SetDeaths(-111923, SetTo, 0, 0)},{preserved})
	CIf(FP, {Deaths(-111923,Exactly,0,0)})
	local Act = {CreateUnit(1, 91, 31, P6)}
	for j,k in pairs(Shape6101) do
		table.insert(Act, Simple_SetLoc(0, k[1], k[2],k[1], k[2]))
		table.insert(Act, MoveUnit(All, 91, P6, 32, 1))
	end
	table.insert(Act, RemoveUnit(91, P6))
	DoActions2X(FP, Act)

		
	CIfEnd()

	
DoActions(FP,{
	RemoveUnitAt(1,BanToken[1],"Anywhere",Force1);
	RemoveUnitAt(1,BanToken[2],"Anywhere",Force1);
	RemoveUnitAt(1,BanToken[3],"Anywhere",Force1);
	RemoveUnitAt(1,BanToken[4],"Anywhere",Force1);
	RemoveUnitAt(1,BanToken[5],"Anywhere",Force1);

})
	local PColorC = { 111, 165, 159, 164, 156 }
	BanCode2 = CreateCcodeArr(7)
	WanCT = CreateCcodeArr(7)
	local ExchangeP = CreateVar(FP)
	MacroWarn1 = "\x13\x04\n\x0D\x0D\x13\x04！！！　\x08ＷＡＲＮＩＮＧ\x04　！！！\n\x14\n\x14\n"..StrDesignX("\x08매크로 또는 핵이 감지되었습니다.").."\n"..StrDesignX("\x08경고를 무시하고 계속 사용하실 경우 드랍됩니다.").."\n\n\x14\n\x0D\x0D\x13\x04！！！　\x08ＷＡＲＮＩＮＧ\x04　！！！\n\x0D\x0D\x13\x04"
	MacroWarn2 = "\x13\x04\n\x0D\x0D\x13\x04！！！　\x08ＷＡＲＮＩＮＧ\x04　！！！\n\x14\n\x14\n"..StrDesignX("\x08매크로 또는 핵이 감지되었습니다.").."\n"..StrDesignX("\x08패널티로 모든 미네랄, 유닛 몰수, 무한 찌릿찌릿이 제공됩니다.").."\n\n\x14\n\x0D\x0D\x13\x04！！！　\x08ＷＡＲＮＩＮＧ\x04　！！！\n\x0D\x0D\x13\x04"
	ColorTimer = TimerToggle(0x1D/2)
	for i = 0, 4 do
		
		
		Trigger { -- 조합 영웅마린
		players = {i},
		conditions = {
			Label(0);
			Bring(i,AtLeast,1,32,13); 
			Accumulate(i,AtLeast,HMCost,Ore);
			Accumulate(i,AtMost,0x7FFFFFFF,Ore);
		},
		actions = {
			ModifyUnitEnergy(1,32,i,13,0);
			RemoveUnitAt(1,32,13,i);
			SetResources(i,Subtract,HMCost,Ore);
			AddCD(HMCr[i+1],1);
			DisplayText(StrDesign("\x1F광물\x04을 소모하여 \x1DM\x04arine을 \x1BH\x04ero M\x04arine으로 \x19변환\x04하였습니다. - \x1F"..N_to_EmN(HMCost).." O r e"),4);
			PreserveTrigger();
		},
		}
		
		
		if DLC_Project == 1 then
			Trigger { -- 조합 스마
			players = {i},
			conditions = {
				Label(0);
				Command(i,AtMost,0,10),
				Bring(i,AtLeast,12,20,13); 
				Accumulate(i,AtLeast,SMCost,Ore);
				Accumulate(i,AtMost,0x7FFFFFFF,Ore);
				CD(SMCr[i+1],0)
			},
			actions = {
				ModifyUnitEnergy(12,20,i,13,0);
				RemoveUnitAt(12,20,13,i);
				SetResources(i,Subtract,SMCost,Ore);
				AddCD(SMCr[i+1],1);
				DisplayText(StrDesign("\x1F광물\x04을 소모하여 \x1BH\x04ero M\x04arine 12기를 \x1DS\x04pecial \x1DM\x04arine으로 \x19변환\x04하였습니다. - \x1F"..N_to_EmN(SMCost).." O r e"),4);
				PreserveTrigger();
			},
			}
			Trigger { -- 조합 근
			players = {i},
			conditions = {
				Label(0);
				Command(i,AtMost,0,MarID[i+1]),
				Bring(i,AtLeast,1,10,13); 
				Accumulate(i,AtLeast,RMCost,Ore);
				Accumulate(i,AtMost,0x7FFFFFFF,Ore);
				CD(RMCr[i+1],0)
			},
			actions = {
				ModifyUnitEnergy(1,10,i,13,0);
				RemoveUnitAt(1,10,13,i);
				SetResources(i,Subtract,RMCost,Ore);
				AddCD(RMCr[i+1],1);
				SetV(SMPtr[i+1],0),
				DisplayText(StrDesign("\x1F광물\x04을 소모하여 \x1DS\x04pecial \x1DM\x04arine을 \x19R\x04espect \x19M\x04arine으로 \x19변환\x04하였습니다. - \x1F"..N_to_EmN(RMCost).." O r e"),4);
				PreserveTrigger();
			},
			}
		else
			Trigger { -- 조합 스마
			players = {i},
			conditions = {
				Label(0);
				Bring(i,AtLeast,1,20,13); 
				Accumulate(i,AtLeast,SMCost,Ore);
				Accumulate(i,AtMost,0x7FFFFFFF,Ore);
				CD(GMode,2,AtMost);
			},
			actions = {
				ModifyUnitEnergy(1,20,i,13,0);
				RemoveUnitAt(1,20,13,i);
				SetResources(i,Subtract,SMCost,Ore);
				AddCD(SMCr[i+1],1);
				DisplayText(StrDesign("\x1F광물\x04을 소모하여 \x1BH\x04ero M\x04arine을 \x1DS\x04pecial \x1DM\x04arine으로 \x19변환\x04하였습니다. - \x1F"..N_to_EmN(SMCost).." O r e"),4);
				PreserveTrigger();
			},
			}
			Trigger { -- 조합 근
			players = {i},
			conditions = {
				Label(0);
				Bring(i,AtLeast,1,10,13); 
				Accumulate(i,AtLeast,RMCost,Ore);
				Accumulate(i,AtMost,0x7FFFFFFF,Ore);
				CD(GMode,2,AtMost);
			},
			actions = {
				ModifyUnitEnergy(1,10,i,13,0);
				RemoveUnitAt(1,10,13,i);
				SetResources(i,Subtract,RMCost,Ore);
				AddCD(RMCr[i+1],1);
				DisplayText(StrDesign("\x1F광물\x04을 소모하여 \x1DS\x04pecial \x1DM\x04arine을 \x19R\x04espect \x19M\x04arine으로 \x19변환\x04하였습니다. - \x1F"..N_to_EmN(RMCost).." O r e"),4);
				PreserveTrigger();
			},
			}
		end
		

		
		Trigger { -- 강퇴
		players = {i},
		conditions = {
			Label(0);
			Bring(AllPlayers, AtLeast, 3, 96, 34+i)
		},
		actions = {
			RotatePlayer({DisplayTextX(StrDesign("\x04"..PlayerString[i+1].."\x04의 강퇴처리가 완료되었습니다."),4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i);
			},
		}

		Trigger { -- 강퇴 드랍
		players = {i},
		conditions = {
			Label(0);
			Bring(AllPlayers, AtLeast, 3, 96, 34+i);
			Memory(0x57F1B0, Exactly, i)
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
			DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍되어 싱글플레이로 전환됩니다.\x07 』",4);
			DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍되어 싱글플레이로 전환됩니다.\x07 』",4);
			DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍되어 싱글플레이로 전환됩니다.\x07 』",4);
			DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍되어 싱글플레이로 전환됩니다.\x07 』",4);
			DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍되어 싱글플레이로 전환됩니다.\x07 』",4);
			DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍되어 싱글플레이로 전환됩니다.\x07 』",4);
			DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍되어 싱글플레이로 전환됩니다.\x07 』",4);
			DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍되어 싱글플레이로 전환됩니다.\x07 』",4);
			DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍되어 싱글플레이로 전환됩니다.\x07 』",4);
			DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍되어 싱글플레이로 전환됩니다.\x07 』",4);
			DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍되어 싱글플레이로 전환됩니다.\x07 』",4);
			DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍되어 싱글플레이로 전환됩니다.\x07 』",4);
			DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍되어 싱글플레이로 전환됩니다.\x07 』",4);
			DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍되어 싱글플레이로 전환됩니다.\x07 』",4);
			CreateUnit(1, 94, 1, FP);
			RemoveUnit(94, FP);
			},
		}

		
--		Trigger { -- 다운그레이드
--		players = {i},
--		conditions = {
--			Label(0);
--			Bring(i,AtLeast,1,MarID[i+1],13); 
--			Accumulate(i,AtLeast,RMtoSMCost,Ore);
--			Accumulate(i,AtMost,0x7FFFFFFF,Ore);
--			CD(GMode,2,AtMost);
--		},
--		actions = {
--			ModifyUnitEnergy(1,MarID[i+1],i,13,0);
--			RemoveUnitAt(1,MarID[i+1],13,i);
--			SetResources(i,Subtract,RMtoSMCost,Ore);
--			AddCD(SMCr[i+1],1);
--			DisplayText(StrDesign("\x1F광물\x04을 소모하여 \x19R\x04espect \x19M\x04arine을 \x1DS\x04pecial \x1DM\x04arine으로 \x07다운그레이드 \x04하였습니다. - \x1F"..N_to_EmN(RMtoSMCost).." O r e"),4);
--			PreserveTrigger();
--		},
--		}



		for j,k in pairs(KillPointArr) do
			TriggerX(i, {Deaths(P8, AtMost, 0, 189),Kills(i, AtLeast, 1, k[1])}, {SetKills(i, Subtract, 1, k[1]),SetScore(i, Add, k[2], Kills),PlayWAV("staredit\\wav\\Herokill.ogg"),DisplayText(StrDesignX(k[3].."\x07개인 처치 보상 \x04: \x1F＋ "..N_to_EmN(k[2]).." \x03Ｐｔｓ"), 4)},{preserved})
		end
		Trigger2X(i,{Kills(i,AtLeast,1,176)},{SetKills(i,Subtract,1,176),SetScore(i,Add,150000,Kills)},{preserved})
		Trigger2X(i,{Kills(i,AtLeast,1,177)},{SetKills(i,Subtract,1,177),SetScore(i,Add,150000,Kills)},{preserved})
		Trigger2X(i,{Kills(i,AtLeast,1,178)},{SetKills(i,Subtract,1,178),SetScore(i,Add,150000,Kills)},{preserved})
		Trigger2X(i,{Kills(i,AtLeast,1,188)},{SetKills(i,Subtract,1,188),SetScore(i,Add,150000*2,Kills)},{preserved})

		CreatingUnit = CreateVar(FP)
		CreatingUID = CreateVar(FP)
		CreatingUnitHP = CreateVar(FP)
		CIf(FP,HumanCheck(i,1),{ModifyUnitEnergy(All, "Any unit", i, 64, 100)})
		
		TriggerX(FP, {Deaths(i, Exactly, 1, 217),Deaths(i, AtLeast, 1, 190)}, AddCD(CrCheck1[i+1],1),{preserved})
		TriggerX(FP, {Deaths(i, Exactly, 1, 217),Deaths(i, AtLeast, 1, 191)}, AddCD(CrCheck2[i+1],1),{preserved})
		TriggerX(FP, {Deaths(i, Exactly, 2, 217),Deaths(i, AtLeast, 1, 190)}, AddCD(CrCheck1[i+1],1),{preserved})
		TriggerX(FP, {Deaths(i, Exactly, 2, 217),Deaths(i, AtLeast, 1, 191)}, AddCD(CrCheck2[i+1],1),{preserved})
		TriggerX(FP, {CD(CrCheck1[i+1],1),CD(CrCheck2[i+1],1),}, {SetDeaths(i, SetTo, 1, 219),SetCp(i),DisplayText(StrDesignX("\x03제작자\x04 인식되었습니다.\x07환영합니다."), 4),PlayWAV("staredit\\wav\\ADEnd.ogg");PlayWAV("staredit\\wav\\ADEnd.ogg"),SetCp(FP)})
		Trigger2X(FP, {Deaths(i, AtLeast, 1, 217),Bring(i, AtLeast, 1, 96, 34+i);CD(EVFCcode,1)},{SetCD(HongEnable,1)})
		CTrigger(FP, {CD(ColorTimer,0)}, {SetPlayerColor(i, SetTo, PColorC[i+1])}, {preserved})
		CTrigger(FP, {CD(ColorTimer,1),Memory(0x582294+(4*i),AtLeast,2100),Memory(0x582294+(4*i),AtMost,2400)}, {SetPlayerColor(i, SetTo, 255)}, {preserved})--TSetMemoryX(EXCC_TempVarArr[9],SetTo,P6*0x10000, 0xFF0000)
		CTrigger(FP, {CD(ColorTimer,1),Memory(0x582294+(4*i),AtLeast,1800),Memory(0x582294+(4*i),AtMost,2100)}, {SetPlayerColor(i, SetTo, 128)}, {preserved})--TSetMemoryX(EXCC_TempVarArr[9],SetTo,P8*0x10000, 0xFF0000)
		CTrigger(FP, {CD(ColorTimer,1),Memory(0x582294+(4*i),AtLeast,1500),Memory(0x582294+(4*i),AtMost,1800)}, {SetPlayerColor(i, SetTo, 51)}, {preserved})--TSetMemoryX(EXCC_TempVarArr[9],SetTo,P12*0x10000, 0xFF0000)
		CTrigger(FP, {CD(ColorTimer,1),Memory(0x582294+(4*i),AtLeast,1200),Memory(0x582294+(4*i),AtMost,1500)}, {SetPlayerColor(i, SetTo, 42)}, {preserved})--TSetMemoryX(EXCC_TempVarArr[9],SetTo,P7*0x10000, 0xFF0000)
		CTrigger(FP, {CD(ColorTimer,1),Memory(0x582294+(4*i),Exactly,1),}, {SetPlayerColor(i, SetTo, PColorC[i+1])}, {preserved})


		CDoActions(FP, {TSetDeathsX(i, Subtract, Dt, 12,0xFFFFFF)})
        DoActions(FP, {
            SetMemory(0x5822C4+(i*4),SetTo,1200);
            SetMemory(0x582264+(i*4),SetTo,1200);}, 1)

		TriggerX(FP, {CD(EVFCcode,1),MemoryB(0x58D2B0+(46*i)+7,AtLeast,255)}, {--evf, 공업완료시
			SetMemoryB(0x57F27C + (i * 228) + 74,SetTo,1),})

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

		if DLC_Project==1 then
			
		--CurHealUpgrade = CreateVarArr(5, FP)
		--HealUpgrade = CreateVarArr(5, FP)
		--CurRebirthUp = CreateVarArr(5, FP)
		--RebirthUp = CreateVarArr(5, FP)
		--CurInvUp = CreateVarArr(5, FP)
		--InvUp = CreateVarArr(5, FP)
		--CurSMUp = CreateVarArr(5, FP)
		--SMUp = CreateVarArr(5, FP)
		--CurRMUp = CreateVarArr(5, FP)
		--RMUp = CreateVarArr(5, FP)
		
		--HealUpMaskRetArr = {}
		--HealUpPtrArr = {}
		--RebirthUpMaskRetArr = {}
		--RebirthUpPtrArr = {}
		--InvUpMaskRetArr = {}
		--InvUpPtrArr = {}
		--SMUpMaskRetArr
		--SMUpPtrArr
		--RMUpMaskRetArr
		--RMUpPtrArr

		DoActionsX(FP,{SetCVar(FP,CurHealUpgrade[i+1][2],SetTo,0),SetCVar(FP,CurRebirthUp[i+1][2],SetTo,0),SetCVar(FP,CurSMUp[i+1][2],SetTo,0),SetCVar(FP,CurRMUp[i+1][2],SetTo,0)})


		for j = 0, 5 do
			TriggerX(FP,{MemoryX(HealUpPtrArr[i+1],Exactly,2^(j+(8*HealUpMaskRetArr[i+1])),2^(j+(8*HealUpMaskRetArr[i+1])))},{SetCVar(FP,CurHealUpgrade[i+1][2],SetTo,2^j,2^j)},{preserved})
		end
		for j = 0, 5 do
			TriggerX(FP,{MemoryX(RebirthUpPtrArr[i+1],Exactly,2^(j+(8*RebirthUpMaskRetArr[i+1])),2^(j+(8*RebirthUpMaskRetArr[i+1])))},{SetCVar(FP,CurRebirthUp[i+1][2],SetTo,2^j,2^j)},{preserved})
		end
		
		for j = 0, 5 do
			TriggerX(FP,{MemoryX(SMUpPtrArr[i+1],Exactly,2^(j+(8*SMUpMaskRetArr[i+1])),2^(j+(8*SMUpMaskRetArr[i+1])))},{SetCVar(FP,CurSMUp[i+1][2],SetTo,2^j,2^j)},{preserved})
		end
		
		for j = 0, 5 do
			TriggerX(FP,{MemoryX(RMUpPtrArr[i+1],Exactly,2^(j+(8*RMUpMaskRetArr[i+1])),2^(j+(8*RMUpMaskRetArr[i+1])))},{SetCVar(FP,CurRMUp[i+1][2],SetTo,2^j,2^j)},{preserved})
		end
		--TriggerX(FP,{MemoryX(InvUpPtrArr[i+1],Exactly,2^(0+(8*InvUpMaskRetArr[i+1])),2^(0+(8*InvUpMaskRetArr[i+1])))},{SetCVar(FP,CurInvUp[i+1][2],SetTo,2^0,2^0)},{preserved})
	

		CIf(FP,{TTCVar(FP,CurHealUpgrade[i+1][2],NotSame,HealUpgrade[i+1])})
			CIfX(FP,{TAccumulate(i,AtLeast,HealCost[i+1],Ore)},{TSetResources(i,Subtract,HealCost[i+1],Ore)})
				CMov(FP,HealUpgrade[i+1],CurHealUpgrade[i+1])
				CAdd(FP,HealCost[i+1],HealCostFactor)
				DisplayPrint(i, {"\x07。\x18˙\x0F+\x1C˚ \x07자동 \x0F회복 \x07업그레이드\x04가 완료되었습니다. \x1C현재 업글 횟수 \x04: \x07",HealUpgrade[i+1]," \x1C。\x0F+\x18.\x07˚"})
				CIf(FP,{LocalPlayerID(i)})
				DisplayPrintTbl(1391,{"z\x02\x07。\x18˙\x0F+\x1C˚\x19 \x07자동 \x0F회복 \x04업그레이드 (\x1F",HealCost[i+1]," Ore\x04) \x11(\x07",HealUpgrade[i+1],"\x04/\x1C5\x11) \x04(\x03Z\x04) \x1C。\x0F+\x18.\x07˚\n\x07업그레이드 단계\x04마다 \x0F회복\x1F속도\x04가 점점 빨라집니다."})
				CIfEnd()
				
			CElseX()
				CDoActions(FP,{TSetMemoryX(HealUpPtrArr[i+1],SetTo,_Mul(HealUpgrade[i+1],(256^HealUpMaskRetArr[i+1])),255*(256^HealUpMaskRetArr[i+1])),
				SetCp(i),DisplayText(StrDesign("\x04잔액이 부족합니다."),4),SetCp(FP)})
				CMov(FP,CurHealUpgrade[i+1],HealUpgrade[i+1])
			CIfXEnd()
		CIfEnd()

		
		CIf(FP,{TTCVar(FP,CurRebirthUp[i+1][2],NotSame,RebirthUp[i+1])})
			CIfX(FP,{TAccumulate(i,AtLeast,RebirthCost[i+1],Ore)},{TSetResources(i,Subtract,RebirthCost[i+1],Ore)})
			CMov(FP,RebirthUp[i+1],CurRebirthUp[i+1])
				CAdd(FP,RebirthCost[i+1],RebirthCostFactor)
				DisplayPrint(i, {"\x07。\x18˙\x0F+\x1C˚ \x19부활의 가호 \x07업그레이드\x04가 완료되었습니다. \x1C현재 업글 횟수 \x04: \x07",RebirthUp[i+1]," \x1C。\x0F+\x18.\x07˚"})
				CIf(FP,{LocalPlayerID(i)})
				DisplayPrintTbl(1390,{"x\x02\x07。\x18˙\x0F+\x1C˚\x19 부활의 가호 \x04업그레이드 (\x1F",RebirthCost[i+1]," Ore\x04) \x11(\x07",RebirthUp[i+1],"\x04/\x1C3\x11) \x04(\x03X\x04) \x1C。\x0F+\x18.\x07˚\n\x041회 : \x18S\x04pecial \x18M\x04arine \x19부활 적용\n\x042회 : \x19R\x04espect \x19M\x04arine \x19부활 적용\n\x043회 : \x07쿨타임\x04이 \x1F5분에서 3분으로 단축\x04됨"})
				CIfEnd()
				
			CElseX()
				CDoActions(FP,{TSetMemoryX(RebirthUpPtrArr[i+1],SetTo,_Mul(RebirthUp[i+1],(256^RebirthUpMaskRetArr[i+1])),255*(256^RebirthUpMaskRetArr[i+1])),
				SetCp(i),DisplayText(StrDesign("\x04잔액이 부족합니다."),4),SetCp(FP)})
				CMov(FP,CurRebirthUp[i+1],RebirthUp[i+1])
			CIfXEnd()
		CIfEnd()
		
		CIf(FP,{TTCVar(FP,CurSMUp[i+1][2],NotSame,SMUp[i+1])})
			CIfX(FP,{TAccumulate(i,AtLeast,SMSkillCost[i+1],Ore)},{TSetResources(i,Subtract,SMSkillCost[i+1],Ore),})
			
					CAdd(FP,SMSkillCost[i+1],SMSkillCostFactor)
				CMov(FP,SMUp[i+1],CurSMUp[i+1])
				DisplayPrint(i, {"\x07。\x18˙\x0F+\x1C˚ \x18S\x04pecial \x18M\x04arine \x07스킬 업그레이드\x04가 완료되었습니다. \x1C현재 업글 횟수 \x04: \x07",SMUp[i+1]," \x1C。\x0F+\x18.\x07˚"})
				CIf(FP,{LocalPlayerID(i)})
				DisplayPrintTbl(1387,{"q\x02\x07。\x18˙\x0F+\x1C˚\x19 \x18S\x04pecial \x18M\x04arine \x1F특수 \x04업그레이드 (\x1F",SMSkillCost[i+1]," Ore\x04) \x11(\x07",SMUp[i+1],"\x04/\x1C24\x11) \x04(\x03Q\x04)\x1C。\x0F+\x18.\x07˚\x14\x14\x14\x14"})
				CIfEnd()
			CElseX()
				CDoActions(FP,{TSetMemoryX(SMUpPtrArr[i+1],SetTo,_Mul(SMUp[i+1],(256^SMUpMaskRetArr[i+1])),255*(256^SMUpMaskRetArr[i+1])),
				SetCp(i),DisplayText(StrDesign("\x04잔액이 부족합니다."),4),SetCp(FP)})
				CMov(FP,CurSMUp[i+1],SMUp[i+1])
			CIfXEnd()
		CIfEnd()
		
		CIf(FP,{TTCVar(FP,CurRMUp[i+1][2],NotSame,RMUp[i+1])})
		CIfX(FP,{TAccumulate(i,AtLeast,RMSkillCost[i+1],Ore)},{TSetResources(i,Subtract,RMSkillCost[i+1],Ore),})
			
				CAdd(FP,RMSkillCost[i+1],RMSkillCostFactor)
				CMov(FP,RMUp[i+1],CurRMUp[i+1])
				DisplayPrint(i, {"\x07。\x18˙\x0F+\x1C˚ \x19R\x04espect \x19M\x04arine \x07스킬 업그레이드\x04가 완료되었습니다. \x1C현재 업글 횟수 \x04: \x07",RMUp[i+1]," \x1C。\x0F+\x18.\x07˚"})
				CIf(FP,{LocalPlayerID(i)})
				DisplayPrintTbl(1388,{"w\x02\x07。\x18˙\x0F+\x1C˚\x19 \x19R\x04espect \x19M\x04arine \x1F특수 \x04업그레이드 (\x1F",RMSkillCost[i+1]," Ore\x04) \x11(\x07",RMUp[i+1],"\x04/\x1C9\x11) \x04(\x03W\x04) \x1C。\x0F+\x18.\x07˚"})
				CIfEnd()
			CElseX()
				CDoActions(FP,{TSetMemoryX(RMUpPtrArr[i+1],SetTo,_Mul(RMUp[i+1],(256^RMUpMaskRetArr[i+1])),255*(256^RMUpMaskRetArr[i+1])),
				SetCp(i),DisplayText(StrDesign("\x04잔액이 부족합니다."),4),SetCp(FP)})
				CMov(FP,CurRMUp[i+1],RMUp[i+1])
			CIfXEnd()
		CIfEnd()




		TriggerX(FP,{CV(RebirthUp[i+1],1,AtLeast)},{SubV(SMRebirthT[i+1], 0x1D)},{preserved})
		TriggerX(FP,{CV(RebirthUp[i+1],2,AtLeast)},{SubV(RMRebirthT[i+1], 0x1D)},{preserved})
		TriggerX(FP,{CV(RebirthUp[i+1],3,AtLeast)},{SubV(SMRebirthT[i+1], 0x1D),SubV(RMRebirthT[i+1], 0x1D)},{preserved})

		
		--CIf(FP,{TTCVar(FP,CurInvUp[i+1][2],NotSame,InvUp[i+1])})
		--	CIfX(FP,{Accumulate(i,AtLeast,1500000,Ore)},{SetResources(i,Subtract,1500000,Ore)})
		--		CMov(FP,InvUp[i+1],CurInvUp[i+1])
		--	CElseX()
		--		CDoActions(FP,{TSetMemoryX(InvUpPtrArr[i+1],SetTo,_Mul(InvUp[i+1],(256^InvUpMaskRetArr[i+1])),255*(256^InvUpMaskRetArr[i+1])),
		--		SetCp(i),DisplayText(StrDesign("\x04잔액이 부족합니다."),4),SetCp(FP)})
		--		CMov(FP,CurInvUp[i+1],InvUp[i+1])
		--	CIfXEnd()
		--CIfEnd()
		local InvUpT = CreateCcode()
		CIfX(FP,CV(InvUp[i+1],1,AtLeast),{SubCD(InvUpT,1)})
		
		TriggerX(FP,{CD(SMRebirthT2[i+1],1,AtLeast)},{SetInvincibility(Enable, 10, i, 64)},{preserved})
		TriggerX(FP,{CD(RMRebirthT2[i+1],1,AtLeast)},{SetInvincibility(Enable, MarID[i+1], i, 64)},{preserved})
		TriggerX(FP,{CD(SMRebirthT2[i+1],0),CD(InvUpT,24,AtLeast)},{SetInvincibility(Enable, 10, i, 64)},{preserved})
		TriggerX(FP,{CD(RMRebirthT2[i+1],0),CD(InvUpT,24,AtLeast)},{SetInvincibility(Enable, MarID[i+1], i, 64)},{preserved})
		TriggerX(FP,{CD(SMRebirthT2[i+1],0),CD(InvUpT,23,AtMost)},{SetInvincibility(Disable, 10, i, 64)},{preserved})
		TriggerX(FP,{CD(RMRebirthT2[i+1],0),CD(InvUpT,23,AtMost)},{SetInvincibility(Disable, MarID[i+1], i, 64)},{preserved})

		TriggerX(FP, {CD(InvUpT,24,AtLeast)}, {
			SetInvincibility(Enable, 32, i, 64),
			SetInvincibility(Enable, 20, i, 64)
		}, {preserved})
		TriggerX(FP, {CD(InvUpT,23,AtMost)}, {
			SetInvincibility(Disable, 32, i, 64),
			SetInvincibility(Disable, 20, i, 64)}, {preserved})
		TriggerX(i,{CD(InvUpT,0)},{SetCD(InvUpT,40)},{preserved})
		CElseX()
		
		TriggerX(FP,{CD(SMRebirthT2[i+1],1,AtLeast)},{SetInvincibility(Enable, 10, i, 64)},{preserved})
		TriggerX(FP,{CD(RMRebirthT2[i+1],1,AtLeast)},{SetInvincibility(Enable, MarID[i+1], i, 64)},{preserved})
		TriggerX(FP,{CD(SMRebirthT2[i+1],0)},{SetInvincibility(Disable, 10, i, 64)},{preserved})
		TriggerX(FP,{CD(RMRebirthT2[i+1],0)},{SetInvincibility(Disable, MarID[i+1], i, 64)},{preserved})
		CIfXEnd()

		--local HealUpgradeT = CreateCcode()
		--CIf(FP,CV(HealUpgrade[i+1],1,AtLeast),{})
		--for j = 1, 5 do
		--	TriggerX(FP, {CV(HealUpgrade[i+1],j)}, {SubCD(HealUpgradeT, j)}, {preserved})
		--end
		--TriggerX(FP,{CD(HealUpgradeT,0)},{SetCD(HealUpgradeT,75),
		--ModifyUnitHitPoints(All,"Men",i,"Anywhere",100),
		--ModifyUnitHitPoints(All,"Buildings",i,"Anywhere",100),
		--ModifyUnitShields(All,"Men",i,"Anywhere",100),
		--ModifyUnitShields(All,"Buildings",i,"Anywhere",100),},{preserved})
		--CIfEnd()




		





		end
		UnitButton(i,82,nil,{SetCp(i),
			DisplayText(StrDesign("\x1DM\x04arine을 \x19소환\x04하였습니다. - \x1F"..NMCost.." O r e"),4);
			AddCD(NMCr[i+1],1),SetCp(FP)
		})
		if DLC_Project==1 then
			UnitButton(i,8,{},{SetCp(i),
				DisplayText(StrDesign("\x1BH\x04ero M\x04arine을 을 \x19소환\x04하였습니다. - \x1F"..NMCost+HMCost.." O r e"),4);
				AddCD(HMCr[i+1],1),SetCp(FP)
			})
		else
			UnitButton(i,8,{CD(GMode,2,AtMost)},{SetCp(i),
				DisplayText(StrDesign("\x1DS\x04pecial \x1DM\x04arine 을 \x19소환\x04하였습니다. - \x1F"..NMCost+HMCost+SMCost.." O r e"),4);
				AddCD(SMCr[i+1],1),SetCp(FP)
			})
			UnitButton(i,8,{CD(GMode,3,AtLeast)},{SetCp(i),
				DisplayText(StrDesign("\x1BH\x04ero M\x04arine을 2기 \x19소환\x04하였습니다. - \x1F"..NMCost+HMCost+SMCost.." O r e"),4);
				AddCD(HMCr[i+1],2),SetCp(FP)
			})
			UnitButton(i,7,{},{SetCp(i),
				DisplayText(StrDesign("\x19R\x04espect \x19M\x04arine을 \x19소환\x04하였습니다. - \x1F"..NMCost+HMCost+SMCost+RMCost.." O r e"),4);
				AddCD(RMCr[i+1],1),SetCp(FP)
			})
		end
		
		UnitButton(i,12,{MemoryX(0x664080 + (MarID[i+1]*4),Exactly,0,0x8000)},{SetCp(i),
			SetMemoryX(0x664080 + (MarID[i+1]*4),SetTo,0x8000,0x8000),
			DisplayText(StrDesign("\x19R\x04espect \x19M\x04arine 의 \x03디텍터 \x04기능을 \x07활성화\x04합니다"),4);
			SetCp(FP),
		})
		
		UnitButton(i,12,{MemoryX(0x664080 + (MarID[i+1]*4),Exactly,0x8000,0x8000)},{SetCp(i),
			SetMemoryX(0x664080 + (MarID[i+1]*4),SetTo,0,0x8000),
			DisplayText(StrDesign("\x19R\x04espect \x19M\x04arine 의 \x03디텍터 \x04기능을 \x08비활성화\x04합니다"),4);
			SetCp(FP),
		})
		UnitButton(i,74,{},{SetCp(i),
			SetDeaths(i, Add, 1, 74),
			DisplayText(StrDesign("\x04원격 \x1B스팀팩\x04기능을 사용합니다."),4);
			SetCp(FP),
		})
	

		CIf(FP,{CV(BarPos[i+1],19025,AtLeast),CV(BarPos[i+1],19025+(84*1699),AtMost)})

		CIf(FP,{TTMemory(_Add(BarPos[i+1],62), NotSame, BarRally[i+1])})
			f_Read(FP, _Add(BarPos[i+1],62), BarRally[i+1])
			Convert_CPosXY(BarRally[i+1])
			--DisplayPrintEr(i, {"\x07『 \x03TESTMODE OP \x04: 랠리 포인트가 갱신되었습니다. X : ",CPosX,"  Y : ",CPosY," \x07』"})
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

		local MCT = {
		{NMCr[i+1],32,1500*256},
		{HMCr[i+1],20,3000*256},
		{SMCr[i+1],10,6000*256},
		{RMCr[i+1],MarID[i+1],5000*256}}
		for p = 1, 4 do
			CallTriggerX(FP, Call_MarCr,{CD(MCT[p][1],1,AtLeast),Memory(0x628438, AtLeast, 1)}, {SubCD(MCT[p][1],1),
				SetV(MID,MCT[p][2]),
				SetV(MPID,i),
				SetV(MHP,MCT[p][3]),
				SetV(MPosX,NMT[i+1][2][1]),
				SetV(MPosY,NMT[i+1][2][2]),
			})
		end
		
		
		if Limit == 1 then
			--DisplayPrintEr(i, {"RebirthUp : ",RebirthUp[i+1],"   SMRebirthT : ",SMRebirthT[i+1],"   RMRebirthT : ",RMRebirthT[i+1],"   "})
			CIf(FP,CD(TestMode,1))
			CIfEnd()
			--TriggerX(FP,{CD(TestMode,1)},{SetInvincibility(Enable, "Buildings", FP, 64)},{preserved})--SetV(CurEXP,0x7FFFFFFF)
			--TriggerX(FP,{CD(TestMode,1)},{SetMemoryB(0x58D2B0+15+(i*46),SetTo,255),SetMemoryB(0x58D2B0+7+(i*46),SetTo,255),SetMemoryB(0x58D2B0+(i*46),SetTo,255)})--SetV(CurEXP,0x7FFFFFFF)
		end
		
		DoActionsX(FP, {
			SubCD(SMRebirthT2[i+1], 0x1D),
			SubCD(RMRebirthT2[i+1], 0x1D),
		})
		
		local SMSkillT = CreateCcode()
		CIfX(FP,{CV(SMPtr[i+1],1,AtLeast),CV(SMPtr[i+1],19025+(1699*84),AtMost)},{SubCD(SMSkillT,1)})
		CTrigger(FP, {TMemoryX(_Add(SMPtr[i+1],69),AtLeast,1*256,0xFF00)}, {SubCD(SMSkillT,1)}, 1)--스팀쓸경우 스킬 시전속도 증가
			local SMSkill = CreateCcode()
			TriggerX(FP,{CD(SMSkill,1)},{SetCD(SMSkillT,20),RemoveUnit(91, i),RemoveUnit(90, i),RemoveUnit(121, i)},{preserved})
			CIf(FP,{CD(SMSkillT,0)},{SetCD(SMSkillT,20),RemoveUnit(91, i),RemoveUnit(90, i),RemoveUnit(121, i),SetMemory(0x6C9EF8+(41*4), SetTo, 427)})
			f_Read(FP,_Add(SMPtr[i+1],10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP, 0, CPosX, CPosY, CPosX, CPosY)
			local ttt = {}
			for j = 1, 16 do
				local hc = 1
				local nc = j+1
				if j>= 9 then
					hc=j-7
				end
				if nc >= 9 then nc = 9 end
				table.insert(ttt, nc.." "..hc.." "..(j-7).."\n")
				CSPlot(CSMakeStar(4, 135, 128, 45, nc, hc), i, 91, 0, nil, 1, 32, FP, {MemoryB(0x58D2B0+(i*46)+17, Exactly, j)}, {}, 1)
				--CSPlot(CSMakeStar(4, 135, 128, 45, nc, hc), i, 47, 0, nil, 1, 32, FP, {MemoryB(0x58D2B0+(i*46)+17, Exactly, j)}, {KillUnit(47, i)}, 1)
				
				CSPlot(CSMakeStar(4, 135, 128, 45, nc, hc), i, 90, 0, nil, 1, 32, FP, {MemoryB(0x58D2B0+(i*46)+17, Exactly, j+8)}, {}, 1)
				--CSPlot(CSMakeStar(4, 135, 128, 45, nc, hc), i, 84, 0, nil, 1, 32, FP, {MemoryB(0x58D2B0+(i*46)+17, Exactly, j+8)}, {KillUnit(84, i)}, 1)
				if j >= 9 then
					CSPlot(CSMakeStar(4, 135, 128, 45, j-7, 1), i, 121, 0, nil, 1, 32, FP, {MemoryB(0x58D2B0+(i*46)+17, Exactly, j+8)}, {}, 1)
					--CSPlot(CSMakeStar(4, 135, 128, 45, j-7, 1), i, 153, 0, nil, 1, 32, FP, {MemoryB(0x58D2B0+(i*46)+17, Exactly, j+8)}, {KillUnit(153, i)}, 1)
				end

			end

			--PushErrorMsg(table.concat(ttt))
			for j = 1,24 do
			end
			DoActions(FP, {Order(91, i, 64, Patrol, 64),Order(90, i, 64, Patrol, 64),Order(121, i, 64, Patrol, 64),SetMemory(0x6C9EF8+(41*4), SetTo, 3413)})
			CIfEnd()
			--
		
			CIfX(FP,{TMemoryX(_Add(SMPtr[i+1],19), Exactly,0,0xFF00),},{})
				CIf(FP,{CV(RebirthUp[i+1],1,AtLeast),CV(SMRebirthT[i+1],0),TMemoryX(_Add(SMPtr[i+1],40),AtLeast,150*16777216,0xFF000000)},{SetV(SMRebirthT[i+1],5*60*1000)})
					f_Read(FP,_Add(SMPtr[i+1],10),CPos)
					CDoActions(FP, {
						TSetMemoryX(_Add(SMPtr[i+1],40),SetTo,0*16777216,0xFF000000),
						SetV(SMRebirthAct[i+1],CPos),
					})
					TriggerX(FP,{CV(RebirthUp[i+1],1,AtLeast),CV(RebirthUp[i+1],2,AtMost)},{
						SetCp(i),PlayWAV("staredit\\wav\\revive.ogg"),
						DisplayText(StrDesign("\x08사망\x04한 \x18S\x04pecial \x18M\x04arine 이 \x19부활\x04의 \x19가호\x04를 받아 \x07다시 태어났습니다. \x1B(재사용 대기시간 : 5분)"),4),
						SetCp(FP),},{preserved})
					TriggerX(FP,{CV(RebirthUp[i+1],3)},{
						SetCp(i),PlayWAV("staredit\\wav\\revive.ogg"),
						DisplayText(StrDesign("\x08사망\x04한 \x18S\x04pecial \x18M\x04arine 이 \x19부활\x04의 \x19가호\x04를 받아 \x07다시 태어났습니다. \x1B(재사용 대기시간 : 2분 30초)"),4),
						SetCp(FP),},{preserved})
				CIfEnd()
				CMov(FP,SMPtr[i+1],0)
			CElseX()
			CTrigger(FP,{TMemory(_Add(SMPtr[i+1],0x98/4),AtMost,227*65536),CDeaths(FP,Exactly,0,SMSkill)},{
				SetMemory(0x6509B0,SetTo,i);
				DisplayText(StrDesign("\x18S\x04pecial \x18M\x04arine \x04의 Skill을 \x06Off \x04하였습니다."),4),
				SetMemory(0x6509B0,SetTo,FP);
				SetCDeaths(FP,SetTo,1,SMSkill),
				TSetMemory(_Add(SMPtr[i+1],0x98/4),SetTo,0 + 228*65536);
				TSetMemory(_Add(SMPtr[i+1],0x9C/4),SetTo,228 + 228*65536);
				},1)
			CTrigger(FP,{TMemory(_Add(SMPtr[i+1],0x98/4),AtMost,227*65536),CDeaths(FP,Exactly,1,SMSkill)},{
				SetMemory(0x6509B0,SetTo,i);
				DisplayText(StrDesign("\x18S\x04pecial \x18M\x04arine \x04의 Skill을 \x1FOn \x04하였습니다."),4),
				SetMemory(0x6509B0,SetTo,FP);
				SetCDeaths(FP,SetTo,0,SMSkill),
				TSetMemory(_Add(SMPtr[i+1],0x98/4),SetTo,0 + 228*65536);
				TSetMemory(_Add(SMPtr[i+1],0x9C/4),SetTo,228 + 228*65536);
				},1)
			CIfXEnd()
		CDoActions(FP,{
			TSetMemory(_Add(SMPtr[i+1],0x98/4),SetTo,0 + 228*65536);
			TSetMemory(_Add(SMPtr[i+1],0x9C/4),SetTo,228 + 228*65536);
			TSetMemoryX(_Add(SMPtr[i+1],0xA0/4),SetTo,228,0xFFFF)})
		CElseX({KillUnit(91, i),KillUnit(90, i),KillUnit(121, i)})
		CIfXEnd()
		
		local RMSkillT = CreateCcode()
		local RMSkill = CreateCcode()
		CIfX(FP,{CV(RMPtr[i+1],1,AtLeast),CV(RMPtr[i+1],19025+(1699*84),AtMost)},{SubCD(RMSkillT,1)})
		CTrigger(FP, {TMemoryX(_Add(RMPtr[i+1],69),AtLeast,1*256,0xFF00)}, {SubCD(RMSkillT,1)}, 1)--스팀쓸경우 스킬 시전속도 증가
		


		TriggerX(FP,{CD(RMSkill,1)},{SetCD(RMSkillT,20),RemoveUnit(92, i)},{preserved})
		CIf(FP,{CD(RMSkillT,0)},{SetCD(RMSkillT,20),RemoveUnit(92, i)})
		f_Read(FP,_Add(RMPtr[i+1],10),CPos)
		Convert_CPosXY()
		Simple_SetLocX(FP, 0, CPosX, CPosY, CPosX, CPosY)
		for j = 1,9 do
			CSPlot(CSMakeStar(4, 135, 128, 45, j, 0), i, 92, 0, nil, 1, 32, FP, {MemoryB(0x58D2B0+(i*46)+21, Exactly, j)}, {}, 1)
			--CSPlot(CSMakeStar(4, 135, 128, 45, j, 0), i, 70, 0, nil, 1, 32, FP, {MemoryB(0x58D2B0+(i*46)+21, Exactly, j)}, {KillUnit(70, i)}, 1)
		end
		DoActions(FP, {Order(92, i, 64, Patrol, 64)})
		CIfEnd()

			CIfX(FP,{TMemoryX(_Add(RMPtr[i+1],19), Exactly,0,0xFF00),},{})
				CIf(FP,{CV(RebirthUp[i+1],2,AtLeast),CV(RMRebirthT[i+1],0),TMemoryX(_Add(RMPtr[i+1],40),AtLeast,150*16777216,0xFF000000)},{SetV(RMRebirthT[i+1],5*60*1000)})
					f_Read(FP,_Add(RMPtr[i+1],10),CPos)
					CDoActions(FP, {
						TSetMemoryX(_Add(RMPtr[i+1],40),SetTo,0*16777216,0xFF000000),
						SetV(RMRebirthAct[i+1],CPos),
					})
					TriggerX(FP,{CV(RebirthUp[i+1],2,AtLeast),CV(RebirthUp[i+1],2,AtMost)},{
						SetCp(i),PlayWAV("staredit\\wav\\revive.ogg"),
						DisplayText(StrDesign("\x08사망\x04한 \x19R\x04espect \x19M\x04arine 이 \x19부활\x04의 \x19가호\x04를 받아 \x07다시 태어났습니다. \x1B(재사용 대기시간 : 5분)"),4),
						SetCp(FP),},{preserved})
					TriggerX(FP,{CV(RebirthUp[i+1],3)},{
						SetCp(i),PlayWAV("staredit\\wav\\revive.ogg"),
						DisplayText(StrDesign("\x08사망\x04한 \x19R\x04espect \x19M\x04arine 이 \x19부활\x04의 \x19가호\x04를 받아 \x07다시 태어났습니다. \x1B(재사용 대기시간 : 2분 30초)"),4),
						SetCp(FP),},{preserved})
				CIfEnd()
				CMov(FP,RMPtr[i+1],0)
			CElseX()
			CTrigger(FP,{TMemory(_Add(RMPtr[i+1],0x98/4),AtMost,227*65536),CDeaths(FP,Exactly,0,RMSkill)},{
				SetMemory(0x6509B0,SetTo,i);
				DisplayText(StrDesign("\x19R\x04espect \x18M\x04arine \x04의 Skill을 \x06Off \x04하였습니다."),4),
				SetMemory(0x6509B0,SetTo,FP);
				SetCDeaths(FP,SetTo,1,RMSkill),
				TSetMemory(_Add(RMPtr[i+1],0x98/4),SetTo,0 + 228*65536);
				TSetMemory(_Add(RMPtr[i+1],0x9C/4),SetTo,228 + 228*65536);
				},1)
			CTrigger(FP,{TMemory(_Add(RMPtr[i+1],0x98/4),AtMost,227*65536),CDeaths(FP,Exactly,1,RMSkill)},{
				SetMemory(0x6509B0,SetTo,i);
				DisplayText(StrDesign("\x19R\x04espect \x18M\x04arine \x04의 Skill을 \x1FOn \x04하였습니다."),4),
				SetMemory(0x6509B0,SetTo,FP);
				SetCDeaths(FP,SetTo,0,RMSkill),
				TSetMemory(_Add(RMPtr[i+1],0x98/4),SetTo,0 + 228*65536);
				TSetMemory(_Add(RMPtr[i+1],0x9C/4),SetTo,228 + 228*65536);
				},1)
			CIfXEnd()
			
		CDoActions(FP,{
			TSetMemory(_Add(RMPtr[i+1],0x98/4),SetTo,0 + 228*65536);
			TSetMemory(_Add(RMPtr[i+1],0x9C/4),SetTo,228 + 228*65536);
			TSetMemoryX(_Add(RMPtr[i+1],0xA0/4),SetTo,228,0xFFFF)})
		CElseX({KillUnit(92, i)})
		CIfXEnd()
		DoActions(FP,{KillUnit(91, P12),KillUnit(92, P12),KillUnit(90, P12),KillUnit(121, P12)})
		CIf(FP,{Memory(0x628438, AtLeast, 1),CV(SMRebirthAct[i+1],1,AtLeast)})
		local RPosX,RPosY=Convert_CPosXY(SMRebirthAct[i+1])
			CMov(FP,MPosX,RPosX)
			CMov(FP,MPosY,RPosY)
			CallTriggerX(FP, Call_MarCr,{Memory(0x628438, AtLeast, 1)}, {
				SetV(MID,10),
				SetV(MPID,i),SetCD(SMRebirthT2[i+1],30*1000)
			})
		CMov(FP,SMRebirthAct[i+1],0)
		CIfEnd()
		CIf(FP,{Memory(0x628438, AtLeast, 1),CV(RMRebirthAct[i+1],1,AtLeast)})
			local RPosX,RPosY=Convert_CPosXY(RMRebirthAct[i+1])
			CMov(FP,MPosX,RPosX)
			CMov(FP,MPosY,RPosY)
			CallTriggerX(FP, Call_MarCr,{Memory(0x628438, AtLeast, 1)}, {
				SetV(MID,MarID[i+1]),
				SetV(MPID,i),SetCD(RMRebirthT2[i+1],30*1000)
			})
		CMov(FP,RMRebirthAct[i+1],0)
		CIfEnd()
		
		

		

		



		TriggerX(FP, {ElapsedTime(AtLeast, 10),Deaths(i,AtLeast,1,140),CD(WanCT[i+1],0)},{SetCD(WanCT[i+1],480),SetCp(i),DisplayText(MacroWarn1, 4),PlayWAV("sound\\Bullet\\TNsFir00.wav"),PlayWAV("sound\\Bullet\\TNsFir00.wav"),PlayWAV("sound\\Bullet\\TNsFir00.wav"),PlayWAV("sound\\Bullet\\TNsFir00.wav")})
		TriggerX(FP, {ElapsedTime(AtLeast, 10),Deaths(i,AtLeast,1,140),CD(WanCT[i+1],0)},{SetCD(BanCode2[i+1],1)})
		TriggerX(FP, {CD(BanCode2[i+1],1)}, {
			SetMemory(0x59CC78, SetTo, -1048576),
			SetMemory(0x59CC80, SetTo, 2),SetCp(i),PlayWAV("staredit\\wav\\zzirizziri.ogg"),PlayWAV("staredit\\wav\\zzirizziri.ogg"),DisplayText(MacroWarn2, 4),SetCp(FP),SetResources(i, SetTo, 0, Ore),ModifyUnitEnergy(All, "Men", i, 64, 0),ModifyUnitEnergy(All, "Buildings", i, 64, 0),RemoveUnit("Men", i),RemoveUnit(203, i),RemoveUnit(125, i)},{preserved})
	
			Trigger {--찌릿찌릿 ExitDrop
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
		Trigger2X(FP,{},{SubCD(WanCT[i+1],1)},{preserved})

		Trigger2X(FP,{CDeaths(FP,AtLeast,1,BanCode2[i+1]);},{RotatePlayer({DisplayTextX(StrDesign("\x04"..PlayerString[i+1].."\x04가 매크로를 사용하여 \x08찌리리릿 500배 \x04당하셨습니다."),4),PlayWAVX("staredit\\wav\\zzirizziri.ogg"),PlayWAVX("staredit\\wav\\zzirizziri.ogg")},HumanPlayers,FP);})

			CMov(FP,0x582174+(4*i),count)
			CAdd(FP,0x582174+(4*i),count)
		CIf(FP,{CDeaths(FP,AtMost,0,BanCode2[i+1]),Score(i,Kills,AtLeast,1000)})
		CMov(FP,ExchangeP,_Div(_ReadF(0x581F04+(i*4)),_Mov(1000)))
		CMov(FP,0x581F04+(i*4),_Mod(_ReadF(0x581F04+(i*4)),_Mov(1000)))
		CIfX(FP, {Memory(0x582294+(4*i),AtLeast,1200)})
		CAdd(FP,0x57F0F0+(i*4),_Mul(_Mul(ExchangeP,_Mov(10)),_Mul(ExRate, 2)))
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
				NJumpX(FP,MedicTrigJump,{Command(i,AtLeast,1,MedicTrig[j])},{SetResources(i, Add, 1, Gas);})--가스 = 메딕사용횟수
			end
		end
		--NJumpX(FP,MedicTrigJump,{Memory(0x628438, Exactly, 0)},{})
		
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
		--ModifyUnitShields(All,"Men",i,"Anywhere",100);
		--ModifyUnitShields(All,"Buildings",i,"Anywhere",100);
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



if TestStart == 1 then
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
	GT = {{"\x08H\x04D \x08S\x04tyle","\x16M\x04X \x16S\x04tyle","\x11S\x04C \x11S\x04tyle"},{"\x07EVF - \x08H\x04D \x08S\x04tyle","\x07EVF - \x16M\x04X \x16S\x04tyle","\x07EVF - \x11S\x04C \x11S\x04tyle"}}
	for j=0,1 do
		for i = 1, 3 do
			
		Trigger { -- 킬 포인트 리더보드,
		players = {FP},
		conditions = {
			Label(0);
			CD(GMode,i),
			CD(EVFCcode,j),
			CDeaths(FP,AtMost,0,LeaderBoardT);
		},
		actions = {
			LeaderBoardKills("Any unit",StrDesign("\x11K\x04ills".." - "..GT[j+1][i]));
			LeaderBoardComputerPlayers(Disable);
			SetCDeaths(FP,SetTo,600,LeaderBoardT);
			ModifyUnitShields(All,"Men",Force2,"Anywhere",100);
			Order(37, Force2, 64, Attack, 6),
			Order(38, Force2, 64, Attack, 6),
			Order(39, Force2, 64, Attack, 6),
			Order(43, Force2, 64, Attack, 6),
			Order(44, Force2, 64, Attack, 6),
			PreserveTrigger();
		},
	}
	Trigger { -- 데스 스코어 리더보드
		players = {FP},
		conditions = {
			Label(0);
			CD(GMode,i),
			CD(EVFCcode,j),
			CDeaths(FP,Exactly,200,LeaderBoardT);
		},
		actions = {
			LeaderBoardScore(Custom, StrDesign("\x08D\x04eaths".." - "..GT[j+1][i]));
			LeaderBoardComputerPlayers(Disable);
			PreserveTrigger();
	},
	}
	end
	end
	Trigger { -- 자원량
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,Exactly,400,LeaderBoardT);
		},
		actions = {
			
			LeaderBoardGreed(10000000);
			LeaderBoardComputerPlayers(Disable);
			PreserveTrigger();
	},
	}
	CIf(FP,{CDeaths(FP,Exactly,399,LeaderBoardT);})
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