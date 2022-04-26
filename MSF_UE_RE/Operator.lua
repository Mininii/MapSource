function OPTrig()
	Cunit2 = CreateVar(FP)
	CIfX(FP,Never()) -- 상위플레이어 단락 시작
	for i = 0, 6 do
		CElseIfX(HumanCheck(i,1),{SetCVar(FP,CurrentOP[2],SetTo,i)})
		f_Read(FP,0x6284E8+(0x30*i),"X",Cunit2)
		f_Read(FP,0x58A364+(48*180)+(4*i),Dt) -- MSQC val Recive. 180 
		CTrigger(FP,{Deaths(i,AtMost,0,15),TMemory(0x512684,Exactly,CurrentOP)},{print_utf8(12, 0, "\x07[ LV.\x0D000\x1F - 00h \x1100m \x0F00s \x04- \x07기부모드\x04 : F9, \x1F수동저장 \x04: HOME키, \x1C배속조정 \x04: F12\x07 ]")},1)
	end
	CIfXEnd()
	for i = 0, 6 do
		CIf(FP,{Deaths(i,AtMost,0,15),TMemory(0x512684,Exactly,i)})
--        Print13_NumSet(LevelPtr,0x64159C,1000,0x10000)
		Print13_NumSet(LevelPtr,0x64159C,100,0x1000000)
		Print13_NumSet(LevelPtr,0x6415A0,10,0x1)
		Print13_NumSet(LevelPtr,0x6415A0,1,0x100)
		Print13_NumSet(TimePtr,0x6415A4,36000000,0x10000)
		Print13_NumSet(TimePtr,0x6415A4,3600000,0x1000000)
		Print13_NumSet(TimePtr,0x6415A8,60000*10,0x1000000)
		Print13_NumSet(TimePtr,0x6415AC,60000,0x1)
		Print13_NumSet(TimePtr,0x6415B0,10000,0x1)
		Print13_NumSet(TimePtr,0x6415B0,1000,0x100)
		CIfEnd()
	end
	if Limit == 1 then
		CIf(FP,{CDeaths(FP,AtLeast,1,TestMode),CVar(FP,Cunit2[2],AtLeast,1),CVar(FP,Cunit2[2],AtMost,0x7fffffff)})
		--local TestTemp = CreateVar(FP)
		--f_Read(FP,_Add(Cunit2,19),TestTemp,nil,0xFF00)
		--CTrigger(FP,{CVar(FP,Cunit2[2],AtLeast,1)},{TSetMemoryX(_Add(Cunit2,35),SetTo,_Mul(TestTemp,_Mov(65536)),0xFF000000)},1)





		local CurLev = CreateVar(FP)
		CMov(FP,0x6509B0,CurrentOP)
			TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,224)},{SetCVar(FP,Level[2],Add,1)},{preserved})
			TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,223)},{SetCVar(FP,Level[2],Subtract,1)},{preserved})
			CIf(FP,{TTCVar(FP,CurLev[2],NotSame,Level)})
			f_Mod(FP,LevelT,Level,_Mov(10))
			f_Div(FP,LevelT2,Level,_Mov(10))
			CAdd(FP,LevelT2,1)
			TriggerX(FP,{CVar(FP,LevelT[2],Exactly,0)},{SetCVar(FP,LevelT[2],SetTo,10)},{preserved})
			CMov(FP,CurLev,Level)
			CIfEnd()

			Trigger {
				players = {FP},
				conditions = {
					Label(0);
					CDeaths(FP,AtLeast,1,TestMode);
					Deaths(CurrentPlayer,AtLeast,1,222);
				},
				actions = {
					KillUnit("Men",P8);
					KillUnit(143,P8);
					KillUnit(144,P8);
					KillUnit(146,P8);
					KillUnit(193,P8);
					PreserveTrigger();
				}
				}
			CMov(FP,0x6509B0,CurrentOP)
		
			CIf(FP,{Deaths(CurrentPlayer,AtLeast,1,ESC)})
				CMov(FP,0x6509B0,Cunit2)
				DoActions(FP,MoveCp(Add,25*4))
				local Not = def_sIndex()
				NJumpX(FP,Not,{DeathsX(CurrentPlayer,Exactly,111,0,0xFF)})
				NJumpX(FP,Not,{DeathsX(CurrentPlayer,Exactly,107,0,0xFF)})
				Trigger {
					players = {FP},
					conditions = {
						DeathsX(CurrentPlayer,AtMost,57,0,0xFF);
					},
					actions = {
						MoveCp(Subtract,6*4);
						SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
						MoveCp(Add,6*4);
						PreserveTrigger();
					}
				}
				Trigger {
					players = {FP},
					conditions = {
						DeathsX(CurrentPlayer,AtLeast,59,0,0xFF);
					},
					actions = {
						MoveCp(Subtract,6*4);
						SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
						MoveCp(Add,6*4);
						PreserveTrigger();
					}
				}
				NJumpXEnd(FP,Not)
				DoActions(FP,{MoveCp(Subtract,25*4)})
			CIfEnd()
		CIfEnd()
	end
	SetRecoverCp()
		
	local StartC = CreateCcode()
	local StartT = CreateCcode()
	local LoadingC = CreateCcode()
	
	CMov(FP,0x6509B0,CurrentOP)
	KeyCP = CurrentPlayer
	CIf(FP,{CD(StartC,0),Switch("Switch 240",Cleared),CDeaths(FP,AtMost,0,IntroT)},{SetDeaths(CurrentPlayer,SetTo,1,OPConsole),SetCD(LoadingC,0)})
	if TestStart == 1 then
		TriggerX(FP, {Deaths(CurrentPlayer,AtLeast,1,226)}, {SetCD(TestMode,1),SetResources(CurrentPlayer, Add, 0x55555555, Ore)})
	else
		TriggerX(FP, {Deaths(CurrentPlayer,AtLeast,1,226),Deaths(CurrentPlayer,AtLeast,1,11)}, {SetCD(TestMode,1),SetResources(CurrentPlayer, Add, 0x55555555, Ore)})
	end
	if Limit == 1 then
	TriggerX(FP, {Deaths(CurrentPlayer,AtLeast,1,11)}, {SetCD(LimitC,1);})
	end
	

	local iStrInit = def_sIndex()
	CJump(FP, iStrInit)
	local initStr = "\x07LV.0000" 
	local initStr2 = MakeiStrVoid(20).." \x04: " 
	local SCAStat1 = "\x07연결 되었습니다!" 
	local SCAStat2 = "\x07데이터를 불러오는 중..." 
	local NonSCAStr = "\x10SCA 런쳐\x04와 \x07연결\x04해주세요." 
	local SCAInitStr = "\x1F플\x04레이어 : \x07\x0D\x04명. 선택 가능 \x1F최대 \x07Level \x04- 000  / \x1F선택 \x07Level - 000 "
	
	local OPStr, OPStra, OPStrs = SaveiStrArr(FP, MakeiStrVoid(54))
	
	local OPiStr = GetiStrId(FP,MakeiStrWord(MakeiStrVoid(54).."\r\n",8)) 
	local EffStr1 = SaveiStrArrX(FP,MakeiStrWord("\x0E \x1C \x1F \x0F \x1D \x16 \x04 \x1B ",6)) -- 26+6 
	CJumpEnd(FP, iStrInit)
	
	local EffC = CreateCcode()
	local EC = CreateVar(FP)
	DoActionsX(FP, {AddCD(EffC,1),SetNVar(EC,Add,604)})
	TriggerX(FP, {CD(EffC,2,AtLeast)}, {SetCD(EffC,0)}, {preserved})
	TriggerX(FP,NVar(EC,AtLeast,8*604),SetNVar(EC,SetTo,0),{preserved}) 
	
	CTrigger(FP,{CD(TestMode,0),TCVar(FP,MapMaxLevel[2],AtLeast,_Add(CurLevel,10)),Deaths(CurrentPlayer,AtLeast,1,RIGHT)},{SetCVar(FP,CurLevel[2],Add,10)},1)
	CTrigger(FP,{CD(TestMode,1),Deaths(CurrentPlayer,AtLeast,1,RIGHT)},{SetCVar(FP,CurLevel[2],Add,10)},1)

	CTrigger(FP,{Deaths(CurrentPlayer,AtLeast,1,LEFT),CVar(FP, CurLevel[2], AtLeast, 11)},{SetCVar(FP,CurLevel[2],Subtract,10)},1)

	CTrigger(FP, {TTCVar(FP,Level[2],NotSame,CurLevel)}, {TSetCVar(FP, Level[2], SetTo, CurLevel),RotatePlayer({PlayWAVX("staredit\\wav\\sel_m.ogg")},HumanPlayers,FP)}, 1)
	CMov(FP,LevelFactor,_Div(Level,10))
	CMov(FP,SetPlayers,0)
	DoActionsX(FP, {
		SetCVar(FP,ExchangeRateT[1][2],SetTo,Ex1[1]);
		SetCVar(FP,ExchangeRateT[2][2],SetTo,Ex1[2]);
		SetCVar(FP,ExchangeRateT[3][2],SetTo,Ex1[3]);
		SetCVar(FP,ExchangeRateT[4][2],SetTo,Ex1[4]);
		SetCVar(FP,ExchangeRateT[5][2],SetTo,Ex1[5]);
		SetCVar(FP,ExchangeRateT[6][2],SetTo,Ex1[6]);
		SetCVar(FP,ExchangeRateT[7][2],SetTo,Ex1[7]);
	})
	for i = 0, 6 do
		if Limit == 1 then
		TriggerX(FP, {Deaths(i,AtLeast,1,38)}, {SetCD(LimitC,1);}) -- 테스터플래그
		end
		TriggerX(FP, HumanCheck(i,1), SetCVar(FP,SetPlayers[2],Add,1), {preserved})
	end
	for k = 1, 7 do
		CIf(FP, CVar(FP,SetPlayers[2],Exactly,k))
		-- 미션 오브젝트, 환전률 셋팅
		TriggerX(FP, {}, {
			SetMissionObjectives("\x13\x1F===================================\n\x13\n\x13\x04마린키우기 \x1FＵｍＬｉｍｉｔ ＥｘｃｅｅＤ\n\x13"..PlayersN[k].." \x07플레이중입니다.\n\x13\x04설명은 Insert키 또는 PgUp, PgDn 키로 확인 \n\x13\x1F===================================");
		}, {preserved})
			CAdd(FP,ExchangeRate,_Mul(LevelFactor,ExchangeRateT[k]),ExchangeRateT[k])
		CIfEnd()
	end

	CMov(FP,NCCalc,_Mul(LevelFactor,7),7)




	function CA_OPText() 
		CA__SetValue(OPStr,MakeiStrVoid(54),0xFFFFFFFF,0) 
		CA__SetValue(OPStr,SCAInitStr,nil,0) 
		for i = 0, 6 do
			CS__InputTA(FP,{CV(SetPlayers,i+1)},SVA1(OPStr,7),string.byte(tostring(i+1),1, 1)*256,0xFF00)
		end
		
		CS__InputTA(FP,{CD(EffC,0)},SVA1(OPStr,7),0x07,0xFF)
		CA__InputSVA1(SVA1(OPStr,11),SVA1(EffStr1,EC),48,0xFF,0,54)
		CA__ItoCustom(SVA1(OPStr,17+11),MapMaxLevel,nil,nil,{10,3},1,nil,"\x040",0x07,{0,1,2})
		CA__ItoCustom(SVA1(OPStr,35+11),CurLevel,nil,nil,{10,3},1,nil,"\x040",0x04,{0,1,2})
		CA__InputVA(0,OPStr,OPStrs,nil,0,56*1-3)
		for i = 0, 6 do
		CA__SetValue(OPStr,MakeiStrVoid(54),0xFFFFFFFF,0) 
		CA__SetValue(OPStr,initStr2,nil,0) 
		CIfX(FP,HumanCheck(i,1))
		f_Div(FP,NukesUsage[i+1],NCCalc,SetPlayers)
		CTrigger(FP,{TTCVar(FP, MapMaxLevel[2], "<", NewMaxLevel[i+1]),CVar(FP, MapMaxLevel[2], AtMost, LvLimit-1)},{TSetCVar(FP, MapMaxLevel[2], SetTo, NewMaxLevel[i+1])},1)
		CA__ItoName(SVA1(OPStr,0), i, nil, nil, ColorCode[i+1])

		
		CIfX(FP, {Deaths(i,Exactly,2,23)})
		
		CA__SetValue(OPStr,initStr,nil,23) 
		CA__ItoCustom(SVA1(OPStr,26),NewMaxLevel[i+1],nil,nil,{10,4},1,nil,"\x07NEWBIE!!!",nil,{0,1,2,3})
		
		CA__InputSVA1(SVA1(OPStr,23),SVA1(EffStr1,EC),26,0xFF,0,31)

		--CA__ItoCustom(SVA1(OPStr,55),OldMaxScore[i+1],nil,nil,10,1,nil,"\x07NEWBIE!!!",nil,{0,1,2,3,4,5,6,7,8,9})
		--CA__ItoCustom(SVA1(OPStr,32),OldStat[i+1],nil,nil,10,1,nil,"\x07NEWBIE!!!",nil,{0,1,2,3,4,5,6,7,8,9})
		--CA__ItoCustom(SVA1(OPStr,79),AtkLV[i+1],nil,nil,{10,3},1,nil,"0",nil,{0,1,2})
		--CA__ItoCustom(SVA1(OPStr,85),HPLV[i+1],nil,nil,{10,3},1,nil,"0",nil,{0,1,2})

		CElseIfX(Deaths(i,Exactly,0,23))
		CA__SetValue(OPStr,NonSCAStr,nil,23) 
		CElseIfX(Deaths(i,Exactly,3,23),SetCD(LoadingC,1))
		CA__SetValue(OPStr,SCAStat1,nil,23) 
		CS__InputTA(FP,{CD(EffC,0)},SVA1(OPStr,23),0x04,0xFF)
		CElseIfX(Deaths(i,Exactly,1,23),SetCD(LoadingC,1))
		CA__SetValue(OPStr,SCAStat2,nil,23) 
		CS__InputTA(FP,{CD(EffC,0)},SVA1(OPStr,23),0x04,0xFF)
		CIfXEnd()


		CElseX()
		CA__Input(0x0D0D0D0D, SVA1(OPStr,20), 0xFFFFFFFF)
		CA__Input(0x0D0D0D0D, SVA1(OPStr,21), 0xFFFFFFFF)
		CA__Input(0x0D0D0D0D, SVA1(OPStr,22), 0xFFFFFFFF)
		CA__SetMemoryX((56*(i+1))-1,0x0D0D0D0D,0xFFFFFFFF,1)
		CA__SetMemoryX((56*(i+1))-2,0x0D0D0D0D,0xFFFFFFFF,1)
		CIfXEnd()


		

		CA__InputVA((56*(i+1)),OPStr,OPStrs,nil,(56*(i+1)),(56*(i+2))-3)

		end


		end 
		CAPrint(OPiStr,{Force1,Force5},{1,0,0,0,1,1,0,0},"CA_OPText",FP,{}) 
		
		local IntroT1 = "\x13\x1E▶ \x04상위 플레이어는 시작 레벨 선택 후 Y를 눌러주세요.(좌우버튼) 현재 \x07LV."..LvLimit.." \x04까지 선택가능합니다. \x1E◀"
		local IntroT2 = "\x13\x1E▶ \x08게임이 시작되면 SCA에서 데이터를 불러올 수 없습니다. \x1E◀"
		DoActions2(FP, RotatePlayer({
			DisplayTextX(IntroT1,4),
			DisplayTextX(IntroT2,4),
		}, HumanPlayers, FP))
		FixText(FP,2)

		if Limit == 1 then
			CIf(FP,CD(TestMode,1))
			SetLevelUpHP(148)
			CIfEnd()
		end
		CMov(FP,0x6509B0,CurrentOP)
		StartJumpV = def_sIndex()
		NJump(FP, StartJumpV, {Deaths(CurrentPlayer,AtLeast,1,221),CD(LoadingC,1,AtLeast)}, {TSetMemory(0x6509B0, SetTo, CurrentOP),PlayWAV("sound\\Misc\\PError.WAV");PlayWAV("sound\\Misc\\PError.WAV");DisplayText("\x13\x07『 \x08ERROR \x04: 현재 로드중인 플레이어가 있어 시작할 수 없습니다. \x07』", 4)})
		CIfOnce(FP, {ElapsedTime(AtLeast, 15),Deaths(CurrentPlayer,AtLeast,1,221)})
		DoActions2X(FP, {RotatePlayer({PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav"),DisplayTextX("\x13\x1E▶ \x04모든 설정이 완료되었습니다. 잠시 후 게임이 시작됩니다. \x1E◀", 4)}, HumanPlayers, FP),
		SetCD(StartC,1)
	}, 1)
		CallTriggerX(FP, LevelReset,nil,nil,1)
		
	CIfX(FP,CVar(FP,SetPlayers[2],AtLeast,2))
	f_Memcpy(FP,PointStrPtr,_TMem(Arr(StPT[3],0),"X","X",1),StPT[2])
	f_Memcpy(FP,KillScStrPtr,_TMem(Arr(KillPT[3],0),"X","X",1),KillPT[2])
	CElseX()
	f_Memcpy(FP,PointStrPtr,_TMem(Arr(SoloNoPointT[3],0),"X","X",1),SoloNoPointT[2])
	f_Memcpy(FP,KillScStrPtr,_TMem(Arr(SoloNoPointT[3],0),"X","X",1),SoloNoPointT[2])
	CIfXEnd()
		CIfEnd()
		NJumpEnd(FP,StartJumpV)

		


	CIfEnd()
	TriggerX(FP, CD(StartC,1,AtLeast), AddCD(StartT,1), {preserved})
	CIfOnce(FP, CD(StartT,100,AtLeast))
	if Limit == 1 then
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,Exactly,1,LimitX);
			CDeaths(FP,Exactly,0,LimitC);
			
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요. \n\x13\x04실행 방지 코드 0x32223223 작동.",4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDC,SetTo,1);
		}
	}
	CallTriggerX(FP, ComputerReplace, {CD(StartT,100,AtLeast);CD(TestMode,1)}, {SetCD(initStart,1),SetSwitch("Switch 240",Set),SetDeaths(CurrentPlayer,SetTo,0,OPConsole)}, 1)
	CallTriggerX(FP, ComputerReplace, {CD(StartT,100,AtLeast);CD(TestMode,0)}, {SetCD(initStart,1),SetSwitch("Switch 240",Set),SetV(ReserveBGM,12),SetDeaths(CurrentPlayer,SetTo,0,OPConsole)}, 1)
	else
	CallTriggerX(FP, ComputerReplace, {CD(StartT,100,AtLeast);}, {SetCD(initStart,1),SetSwitch("Switch 240",Set),SetV(ReserveBGM,12),SetDeaths(CurrentPlayer,SetTo,0,OPConsole)}, 1)
	end
	CIfEnd()
	CMov(FP,0x6509B0,CurrentOP)

	CTrigger(FP,{TMemory(0x512684,Exactly,CurrentOP),Deaths(CurrentPlayer,AtLeast,1,F12),CDeaths(FP,AtLeast,150+(48*4)+3,IntroT),Deaths(CurrentPlayer,Exactly,1,CPConsole),},{print_utf8(12,0,"\x07『 \x1F기부 ON \x04상태에서는 사용할 수 없는 기능입니다. \x03ESC\x04를 눌러 기능을 OFF해주세요. \x07』")},1)
	KeyInput(F12,{CDeaths(FP,AtLeast,150+(48*4)+3,IntroT),Deaths(CurrentPlayer,Exactly,1,CPConsole)},{
		PlayWAV("sound\\Misc\\Buzz.wav"),
		PlayWAV("sound\\Misc\\Buzz.wav"),
		SetDeaths(CurrentPlayer,SetTo,150,15);},1)
	CTrigger(FP,{TMemory(0x512684,Exactly,CurrentOP),Deaths(CurrentPlayer,AtLeast,1,F9),CDeaths(FP,AtLeast,150+(48*4)+3,IntroT),Deaths(CurrentPlayer,Exactly,1,OPConsole),},{print_utf8(12,0,"\x07『 \x1C배속조정 \x04상태에서는 사용할 수 없는 기능입니다. \x03ESC\x04를 눌러 기능을 OFF해주세요. \x07』")},1)
	KeyInput(F9,{CDeaths(FP,AtLeast,150+(48*4)+3,IntroT),Deaths(CurrentPlayer,Exactly,1,OPConsole)},{
		PlayWAV("sound\\Misc\\Buzz.wav"),
		PlayWAV("sound\\Misc\\Buzz.wav"),
		SetDeaths(CurrentPlayer,SetTo,150,15);},1)
	KeyInput(F12,{CDeaths(FP,AtLeast,150+(48*4)+3,IntroT),Deaths(CurrentPlayer,Exactly,0,OPConsole)},SetDeaths(CurrentPlayer,SetTo,1,OPConsole),1)
	KeyInput(F12,{CDeaths(FP,AtLeast,150+(48*4)+3,IntroT),Deaths(CurrentPlayer,Exactly,1,OPConsole)},{SetDeaths(CurrentPlayer,SetTo,0,OPConsole),SetDeaths(FP,SetTo,0,BanConsole)},1)

	CIf(FP,{CDeaths(FP,AtLeast,150+(48*4)+3,IntroT),Deaths(CurrentPlayer,AtLeast,1,OPConsole)},{TSetCDeaths(FP,Add,Dt,OPFuncT)})
		TriggerX(FP,{CDeaths(FP,AtLeast,15*1000,OPFuncT)},{SetDeaths(CurrentPlayer,SetTo,0,OPConsole),SetCDeaths(FP,SetTo,0,OPFuncT)},{preserved})
		TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,RIGHT),CVar(FP,SpeedVar[2],AtMost,9)},{SetCDeaths(FP,SetTo,0,OPFuncT),SetCVar(FP,SpeedVar[2],Add,1)},{preserved})
		TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,LEFT),CVar(FP,SpeedVar[2],AtLeast,2)},{SetCDeaths(FP,SetTo,0,OPFuncT),SetCVar(FP,SpeedVar[2],Subtract,1)},{preserved})
		TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,B),Deaths(CurrentPlayer,Exactly,0,F9),Deaths(CurrentPlayer,Exactly,0,BanConsole)},{SetCDeaths(FP,SetTo,0,OPFuncT),SetDeaths(CurrentPlayer,SetTo,1,BanConsole),SetDeaths(CurrentPlayer,SetTo,0,B)},{preserved})
		TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,B),Deaths(CurrentPlayer,Exactly,0,F9),Deaths(CurrentPlayer,Exactly,1,BanConsole)},{SetCDeaths(FP,SetTo,0,OPFuncT),SetDeaths(CurrentPlayer,SetTo,0,BanConsole),SetDeaths(CurrentPlayer,SetTo,0,B)},{preserved})
		CIfX(FP,Deaths(CurrentPlayer,AtLeast,1,BanConsole))
			CTrigger(FP,{CDeaths(FP,AtLeast,150+(48*4)+3,IntroT),TMemory(0x512684,Exactly,CurrentOP),Deaths(CurrentPlayer,AtMost,0,15)},{print_utf8(12, 0, "\x07[ \x08강퇴모드 ON. \x04숫자키를 5회 눌러 강퇴하세요. ESC : 닫기\x07 ]")},1)
			-- 205 ~ 211
			for i = 1, 6 do
				CTrigger(FP,{Deaths(CurrentPlayer,AtLeast,1,205+i),TTMemory(0x6509B0,NotSame,i),HumanCheck(i,1)},{
					RotatePlayer({DisplayTextX("\x07『 "..PlayerString[i+1].."\x04에게 \x08경고 1회 누적\x04 되었습니다. 총 5회 누적시 \x08강퇴 처리 \x04됩니다. \x07』",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,FP);
					SetCDeaths(FP,SetTo,0,OPFuncT),SetCDeaths(FP,Add,1,BanToken[i+1])},{preserved})
			end
			CMov(FP,0x6509B0,CurrentOP)
			CElseX()
			CTrigger(FP,{CDeaths(FP,AtLeast,150+(48*4)+3,IntroT),TMemory(0x512684,Exactly,CurrentOP),Deaths(CurrentPlayer,AtMost,0,15)},{print_utf8(12, 0, "\x07[ \x04방향키(←→) : \x1F배속 조정, \x04ESC : 닫기, B : \x08강퇴모드 ON\x07 ]")},1)
		CIfXEnd()
		TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,ESC)},{SetCDeaths(FP,SetTo,0,OPFuncT),SetDeaths(CurrentPlayer,SetTo,0,OPConsole),SetDeaths(CurrentPlayer,SetTo,0,BanConsole)},{preserved})
	CIfEnd()
	CMov(FP,0x6509B0,FP) -- RecoverCP 상위플레이어 단락 끝
	CIf(FP,{TTCVar(FP,CurrentSpeed[2],NotSame,SpeedVar)}) -- 배속조정 트리거
		CMov(FP,CurrentSpeed,SpeedVar)
		for i = 1, 10 do
			Trigger { -- No comment (E93EF7A9)
				players = {FP},
				conditions = {
					Label(0);
					CVar(FP,SpeedVar[2],Exactly,i)
				},
				actions = {PreserveTrigger();
					RotatePlayer({PlayWAVX("staredit\\wav\\sel_m.ogg"),
					DisplayTextX("\x13\x07『 \x0F배속 변경 \x10- "..XSpeed[i].." \x07』", 0)},HumanPlayers,FP);
					SetMemory(0x5124F0,SetTo,SpeedV[i]);
				},
			}
		end
	CIfEnd()
end