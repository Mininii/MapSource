function System()
	local CPlayer = CreateVar(FP)
	local BCPos = CreateVar(FP)
	local CurCunitI2 = CreateVar(FP)
	local TempTarget = CreateVar(FP)
	local X = {}
	local ToggleCcode = CreateCcode()
	for i = 0, 249 do
		table.insert(X,SetMemory(0x5187E8+0xC*i,SetTo,0))
		table.insert(X,SetMemory(0x5187EC+0xC*i,SetTo,0))
	end
	CIfOnce(FP)
	for i = 4, 7 do
		CIf(FP,{LocalPlayerID(i)})
		Trigger2X(FP,{},X,{preserved})
		CIfEnd()
	end
	CIfEnd()

	CIf(FP,{CD(SpecialEEggCcode,3,AtMost)})
	CIfX(FP,{Memory(0x596A44, Exactly, 0x00000100),CD(ToggleCcode,0)})
	CTrigger(FP,{},{
	TSetMemory(0x6509B0,SetTo,LocalPlayerV),
	DisplayText("\x0D\x0D!H\x13\x10??\x04??????????\x08??\x04?桡\x11??\x04???塡\x1F?ţ???",4),
	PlayWAV("staredit\\wav\\AxiomPreview2.wav"),
	PlayWAV("staredit\\wav\\AxiomPreview2.wav"),},1)
	local FoundArr = {
		"\x0D\x0D!H\x13\x057IS46rOE64qUIOybgOyngeydtOq4sCDsi5zsnpHtlojri6Qu",
		"\x0D\x0D!H\x13\x056rO166qF7J2EIOuniOyjvO2VmOuLpC4=",
		"\x0D\x0D!H\x13\x057KCB64yA6rCQ7J2YIOqzte2PrA==",
		"\x0D\x0D!H\x13\x056riw7Ja17IaN7J2YIOqzoO2GtQ=="
	}
	local NotFoundArr = {
		"\x0D\x0D!H\x13"..AxStrArr[1],
		"\x0D\x0D!H\x13"..AxStrArr[2],
		"\x0D\x0D!H\x13"..AxStrArr[3],
		"\x0D\x0D!H\x13"..AxStrArr[4],
	}
	for i = 0,3 do
		CTrigger(FP, {CD(AxiomCcode[i+1],1)},{DisplayText(FoundArr[i+1],4)},1)
		CTrigger(FP, {CD(AxiomCcode[i+1],0)},{DisplayText(NotFoundArr[i+1],4)},1)
	end

	DoActionsX(FP, {SetCp(FP),SetCD(ToggleCcode,1),})
	CElseIfX({Memory(0x596A44, Exactly, 0x00000100)},SetCD(ToggleCcode,1))
	CElseX(SetCD(ToggleCcode,0))
	CIfXEnd()
	CIfEnd()
	
	DoActions(FP,{
		RemoveUnit(7,P12),
		RemoveUnit(20,P12),
		RemoveUnit(32,P12),
		RemoveUnit(MarID[1],P12),
		RemoveUnit(MarID[2],P12),
		RemoveUnit(MarID[3],P12),
		RemoveUnit(MarID[4],P12),
		ModifyUnitEnergy(All,"Men",P12,64,0),
		RemoveUnit(204,AllPlayers),
		RemoveUnit(205,AllPlayers),})

	Cast_UnitCount()
	AddBGM(1,"staredit\\wav\\BYD_OP.ogg",152*1000)--??????
	AddBGM(2,"staredit\\wav\\GBGM1.ogg",33*1000)--??
	AddBGM(3,"staredit\\wav\\GBGM2.ogg",34*1000)--????
	AddBGM(4,"staredit\\wav\\GBGM3.ogg",55*1000)--???̺?
	AddBGM(5,"staredit\\wav\\GBGM4.ogg",69*1000)--Ư??
	AddBGM(6,"staredit\\wav\\MBoss.ogg",133*1000)--????
	AddBGM(7,"staredit\\wav\\story.ogg",83*1000)--???丮
	AddBGM(8,"staredit\\wav\\ED2Boss.ogg",165*1000)--????2
	AddBGM(9,"staredit\\wav\\ED3Boss.ogg",150*1000)--????3
	AddBGM(10,"staredit\\wav\\BadEnd.ogg",36*1000)--????3
	AddBGM(11,"staredit\\wav\\Axiom.ogg",118*1000)--???丮
	AddBGM(12,"staredit\\wav\\WorldEnder1.ogg",36*1000)--???丮2
	Install_BGMSystem(FP,3,BGMType,12,1,1,ObPlayers)

	BGMArr = {}
	for i = 1, 364 do
		if i <= 9 then
			table.insert(BGMArr,"staredit\\wav\\BGM00"..i..".ogg")
		elseif i >= 10 and i<= 99 then
			table.insert(BGMArr,"staredit\\wav\\BGM0"..i..".ogg")
		else
			table.insert(BGMArr,"staredit\\wav\\BGM"..i..".ogg")
		end
	end

	CIf(FP,{Command(FP,AtLeast,1,190)})
	for i = 0, 3 do
		CIf(FP,{HumanCheck(i,1),Deaths(i,Exactly,0,12),Deaths(i,Exactly,0,14)})
		for j = 0, 363 do
			Trigger { -- ???ú???
				players = {FP},
				conditions = {
					Deaths(i,Exactly,j,13);
					Deaths(i,AtMost,0,14);
				},
				actions = {
					SetCp(i);
					PlayWAV(BGMArr[j+1]); 
					SetCp(FP);
					SetDeathsX(i,Add,2000,14,0xFFFFFF);
					SetDeathsX(i,Add,1,13,0xFFFFFF);
					PreserveTrigger();
					
					},
				}
		end
		Trigger { -- ???ú???
			players = {FP},
			conditions = {
				Deaths(i,AtLeast,364,13);
				Deaths(i,AtMost,0,14);
			},
			actions = {
				SetCp(i);
				PlayWAV(BGMArr[1]); 
				SetCp(FP);
				SetDeaths(i,Add,2000,14);
				SetDeaths(i,SetTo,1,13);
				PreserveTrigger();
				
				},
			}
			CIfEnd()
	end
	CIf(FP,{Deaths(FP,Exactly,0,12),Deaths(FP,Exactly,0,14)})
	for j = 0, 363 do
		Trigger { -- ???ú???
			players = {FP},
			conditions = {
				Deaths(FP,Exactly,j,13);
				Deaths(FP,AtMost,0,14);
			},
			actions = {
				RotatePlayer({PlayWAVX(BGMArr[j+1])},ObPlayers,FP);
				SetDeaths(FP,Add,2000,14);
				SetDeaths(FP,Add,1,13);
				PreserveTrigger();
				
				},
			}
	end
	Trigger { -- ???ú???
		players = {FP},
		conditions = {
			Deaths(FP,AtLeast,364,13);
			Deaths(FP,AtMost,0,14);
		},
		actions = {
			RotatePlayer({PlayWAVX(BGMArr[1])},ObPlayers,FP);
			SetDeaths(FP,Add,2000,14);
			SetDeaths(FP,SetTo,1,13);
			PreserveTrigger();
			
			},
		}
	CIfEnd()
	CIfEnd()

CurBID = CreateCcode()
HPRegenTable = {64}
--    CMov(FP,0x57f120,0)
	local TempMarHPRead = CreateVar(FP)
	EXCC_Part1(UnivCunit) -- ??Ÿ ?????????? ?ܶ? ????
	WhiteList = def_sIndex()
	HPRList = def_sIndex()
	for j, i in pairs(MarID) do
		NJumpX(FP,WhiteList,DeathsX(CurrentPlayer,Exactly,i,0,0xFF))
	end
	for j, i in pairs(HPRegenTable) do
		NJumpX(FP,HPRList,{DeathsX(CurrentPlayer,Exactly,i,0,0xFF),CD(EDNum,3)},{SetCD(CurBID,i)})
	end
	SkillUnit = def_sIndex()
	NJumpX(FP,SkillUnit,{TTOR({DeathsX(CurrentPlayer,Exactly,183,0,0xFF),DeathsX(CurrentPlayer,Exactly,214,0,0xFF)})})

	DarkSkill = def_sIndex()
	NJumpX(FP,DarkSkill,{Command(P6,AtLeast,1,BossUID[2]),DeathsX(CurrentPlayer,Exactly,33,0,0xFF)})
	Crystal = def_sIndex()
	NJumpX(FP,Crystal,{DeathsX(CurrentPlayer,Exactly,128,0,0xFF)})


--    EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,204,0,0xFF),{
--        SetMemory(0x6509B0,Add,55-25),
--        TSetMemoryX(CurrentPlayer,SetTo,0x104,0x104);
--        SetMemory(0x6509B0,Add,57),
--        TSetMemoryX(CurrentPlayer,SetTo,0,0xFF);
--    })

	
	CIfX(FP,{DeathsX(CurrentPlayer,AtLeast,116,0,0xFF),DeathsX(CurrentPlayer,AtMost,117,0,0xFF)},{SetMemory(0x6509B0,Subtract,23),SetDeaths(CurrentPlayer,Subtract,256,0)})

--    local HPJump = def_sIndex()
--    NJumpX(FP,HPJump,{CV(count,1450,AtLeast)})
--    DoActions(FP,{SetDeaths(CurrentPlayer,Subtract,256,0)})
--    NJumpXEnd(FP,HPJump)



	EXCC_BreakCalc({Memory(0x628438,AtLeast,1),Deaths(CurrentPlayer,Exactly,0,0)},{SetMemory(0x6509B0,Add,17),SetDeathsX(CurrentPlayer,SetTo,0*256,0,0xFF00)})
		CAdd(FP,0x6509B0,38)--40
		CIf(FP,{DeathsX(CurrentPlayer,AtLeast,150*16777216,0,0xFF000000)})
			CDoActions(FP,{
				SetMemory(0x6509B0,Subtract,17),
				SetDeaths(CurrentPlayer,SetTo,0,0),
				SetMemory(0x6509B0,Subtract,4),
				SetDeathsX(CurrentPlayer,SetTo,6*256,0,0xFF00),
				SetMemory(0x6509B0,Subtract,15),
				TSetDeaths(CurrentPlayer,SetTo,EXCC_TempVarArr[1],0),
				SetMemory(0x6509B0,Add,2),
				TSetDeaths(CurrentPlayer,SetTo,EXCC_TempVarArr[1],0),
				SetMemory(0x6509B0,Add,16),
				TSetDeaths(CurrentPlayer,SetTo,EXCC_TempVarArr[1],0),
			})
		CIfEnd()
	CElseIfX({DeathsX(CurrentPlayer,Exactly,94,0,0xFF)},{SetMemory(0x6509B0,Subtract,23),SetDeaths(CurrentPlayer,Subtract,256,0)})
	EXCC_BreakCalc({Deaths(CurrentPlayer,Exactly,0,0)},{
		MoveCp(Add,53*4); -- 55
		SetDeathsX(CurrentPlayer,SetTo,0x40000000,0,0x40000000);
		SetMemory(0x6509B0,Subtract,55-19),
		SetDeathsX(CurrentPlayer,SetTo,0*256,0,0xFF00)})

   
	
	CElseX({SetMemory(0x6509B0,Subtract,16),SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000)})
	CIfXEnd()

	
	EXCC_ClearCalc()
	NJumpXEnd(FP,Crystal)

	DoActions(FP,{SetMemory(0x6509B0,Subtract,23),SetDeaths(CurrentPlayer,Subtract,256,0)})
	CIf(FP,{Deaths(CurrentPlayer,Exactly,0,0)},{SetMemory(0x6509B0,Add,17),SetDeathsX(CurrentPlayer,SetTo,0*256,0,0xFF00)})
	CSub(FP,0x6509B0,9)
	f_SaveCp()
	f_Read(FP,BackupCp,CPos)
	Convert_CPosXY()
	Simple_SetLocX(FP,0,_Sub(CPosX,11),_Sub(CPosY,11),_Add(CPosX,11),_Add(CPosY,11),{
		CreateUnit(1,191,1,P6),
		KillUnit(191,P6),KillUnitAt(All, "Men",1,Force1)
	})
	f_LoadCp()
	CAdd(FP,0x6509B0,9)
	CIfEnd()


	EXCC_ClearCalc()
	NJumpXEnd(FP,SkillUnit)

	DoActions(FP,{SetMemory(0x6509B0,Subtract,23),SetDeaths(CurrentPlayer,Subtract,256,0)})
	CIf(FP,Deaths(CurrentPlayer,Exactly,0,0))
	CAdd(FP,0x6509B0,23)
	DoActions(FP,{SetDeathsX(CurrentPlayer,SetTo,84,0,0xFF),
	RemoveUnit(84,Force1);
	SetMemory(0x6509B0,Subtract,16),
	SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000),
	SetMemory(0x6509B0,Add,16),})
	CSub(FP,0x6509B0,23)
	CIfEnd()

	
	EXCC_ClearCalc()
	NJumpXEnd(FP,DarkSkill)

	DoActions(FP,{SetMemory(0x6509B0,Subtract,16),SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000),SetMemory(0x6509B0,Add,1),})
	f_SaveCp()
	CMov(FP,CPlayer,_ReadF(_Add(BackupCp,9)),nil,0xFF)
	CMov(FP,CPos,_ReadF(BackupCp))
	Convert_CPosXY()
	Simple_SetLocX(FP,0,_Sub(CPosX,18),_Sub(CPosY,18),_Add(CPosX,18),_Add(CPosY,18),{CreateUnit(1,49,1,P6)}) --
	CIf(FP,Memory(0x628438,AtLeast,1))
	f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
	CTrigger(FP,{},{TCreateUnit(1,214,1,CPlayer),TSetMemoryX(_Add(Nextptrs,9),SetTo,0,0xFF0000)},1)
	CIfEnd()
	f_LoadCp()

	EXCC_ClearCalc()
	NJumpXEnd(FP,HPRList)
	CSub(FP,0x6509B0,23)
	CIf(FP,{Deaths(CurrentPlayer,AtMost,4000000*256,0),Cond_EXCC(4,AtLeast,1)})
	CIfX(FP,Cond_EXCC(4,AtLeast,1000000))
	CDoActions(FP,{Set_EXCCX(4,Subtract,1000000),SetDeaths(CurrentPlayer,Add,1000000*256,0),Set_EXCC(4,Subtract,1000000)})
	CElseX()
	CDoActions(FP,{Set_EXCCX(4,SetTo,0),TSetDeaths(CurrentPlayer,Add,_Mul(EXCC_TempVarArr[5],256),0),Set_EXCC(4,SetTo,0)})
	CIfXEnd()
	CIfEnd()
	CTrigger(FP,CD(CurBID,64),{SetV(B2H,EXCC_TempVarArr[5])},1)
	CAdd(FP,0x6509B0,23)



	EXCC_ClearCalc()
	NJumpXEnd(FP,WhiteList)
	
	CIf(FP,{CD(EDNum,1,AtLeast)})
	CAdd(FP,0x6509B0,70-25)
		TriggerX(FP,{DeathsX(CurrentPlayer,AtLeast,21*256,0,0xFF00)},{SetDeathsX(CurrentPlayer, SetTo, 20*256,0, 0xFF00)},{preserved})
	CSub(FP,0x6509B0,70-25)
	CIfEnd()
	
	EXCC_BreakCalc({CD(Theorist,1)})
	
	CSub(FP,0x6509B0,6)
	
	
	for i = 1, 4 do-- ???Ǻ? CMov. ?߰??????? ?????Ұ???
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				DeathsX(CurrentPlayer,Exactly,i-1,0,0xFF)
			},
			actions = {
				SetCtrig1X("X",TempMarHPRead[2],0x15C,"X",SetTo,0);
				SetCtrig1X("X",MarHPRead[i][2],0x148,"X",SetTo,0xFFFFFFFF);
				SetCtrig1X("X",MarHPRead[i][2],0x160,"X",SetTo,Add*16777216,0xFF000000);
				SetCtrigX("X",MarHPRead[i][2],0x158,"X",SetTo,"X",TempMarHPRead[2],0x15C,1,"X");
				CallLabel1("X",MarHPRead[i][2],"X")
			},
			flag = {preserved}
		}
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				DeathsX(CurrentPlayer,Exactly,i-1,0,0xFF)
			},
			actions = {
				CallLabel2("X",MarHPRead[i][2],"X")
			},
			flag = {preserved}
		}
		end

	CSub(FP,0x6509B0,17)

	CIfX(FP,{TDeaths(CurrentPlayer,AtMost,Vi(TempMarHPRead[2],-256),0)},{TSetDeaths(CurrentPlayer,Add,MarHPRegen,0)})
	CElseX({TSetDeaths(CurrentPlayer,SetTo,TempMarHPRead,0)})
	CIfXEnd()
	CAdd(FP,0x6509B0,17)

	
	NIfX(FP,{Cond_EXCC(2,AtLeast,2)})--?????????ϰ???
		CDoActions(FP,{
			SetMemory(0x6509B0, Subtract,17),
			TSetDeaths(CurrentPlayer,SetTo,TempMarHPRead,0),--2
			SetMemory(0x6509B0, Add,22),
			SetDeathsX(CurrentPlayer,SetTo,5000*256,0,0xFFFFFF),--24
			SetMemory(0x6509B0, Add,31),
			SetDeathsX(CurrentPlayer,SetTo,0x04000000,0,0x04000000),--55
			SetMemory(0x6509B0, Subtract,36),
		})--2
		NIf(FP,{TTOR({
			Cond_EXCC(2,Exactly,50),
			Cond_EXCC(2,Exactly,100),
			Cond_EXCC(2,Exactly,150),
			Cond_EXCC(2,Exactly,200),
		})})
			CSub(FP,0x6509B0,9)
			f_SaveCp()
			f_Read(FP,BackupCp,CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{CreateUnitWithProperties(1,95,1,FP,{hallucinated = true}),KillUnit(95,FP)})
			f_LoadCp()
			CAdd(FP,0x6509B0,9)
		NIfEnd()
	NElseIfX({Cond_EXCC(2,Exactly,1)})--???????°? ?ƴҰ???
		CDoActions(FP,{
			SetMemory(0x6509B0, Add,36),
			SetDeathsX(CurrentPlayer,SetTo,0,0,0x04000000),--55
			SetMemory(0x6509B0, Subtract,36),
		})--2
	NIfXEnd()

	
	CIf(FP,{CV(Level,40,AtLeast),Cond_EXCC(3,AtMost,0)})
		MarSkill = def_sIndex()
		CJump(FP,MarSkill)
		CallMarSkill = SetCallForward()
		SetCall(FP)
		f_SaveCp()

		CIfX(FP,{TMemoryX(_Add(BackupCp,50),AtLeast,1*256,0xFF00)})
		CDoActions(FP,{Set_EXCCX(3,SetTo,15)})
		CElseX()
		CDoActions(FP,{Set_EXCCX(3,SetTo,25)})
		CIfXEnd()

		f_Read(FP,_Sub(BackupCp,9),CPos)
		CMov(FP,CPlayer,_Read(BackupCp),nil,0xFF)
		Convert_CPosXY()
		Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
--        MarSkillCA = CAPlotForward()
--        CMov(FP,V(MarSkillCA[6]),1)
--        CMov(FP,V(MarSkillCA[5]),5)
		for i = 0, 3 do
		--TriggerX(FP,{HumanCheck(i,1)},{SetCVar(FP,MarSkillCA[5],Subtract,1)},{preserved})
		end
		function MarListSkillUnitFunc()
			CIf(FP,Memory(0x628438,AtLeast,1))
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			CDoActions(FP,{
				TCreateUnit(1,183,1,CPlayer),
				TSetDeathsX(_Add(Nextptrs,19),SetTo,152*256,0,0xFF00),
				TSetDeathsX(_Add(Nextptrs,9),SetTo,0*65536,0,0xFF0000),
				TSetDeaths(_Add(Nextptrs,22),SetTo,2048+(2048*65536),0),
			})
			CIfEnd()
		end
		MarListSkillUnitFunc()
			--CAPlot({CSMakePolygon(4,128,45,5,1)},FP,181,0,nil,1,1,{1,0,0,0,6,0},nil,FP,nil,nil,1,"MarListSkillUnitFunc")
		


		f_LoadCp()
		SetCallEnd()
		CJumpEnd(FP,MarSkill)

		CIf(FP,DeathsX(CurrentPlayer,Exactly,10*256,0,0xFF00))
			CAdd(FP,0x6509B0,4)
			CIf(FP,Deaths(CurrentPlayer,AtLeast,1,0))
				CSub(FP,0x6509B0,4)
				CallTrigger(FP,CallMarSkill)
				CAdd(FP,0x6509B0,4)
			CIfEnd()
			CSub(FP,0x6509B0,4)
		CIfEnd()
		CIf(FP,DeathsX(CurrentPlayer,Exactly,107*256,0,0xFF00))
			CAdd(FP,0x6509B0,4)
			CIf(FP,Deaths(CurrentPlayer,AtLeast,1,0))
				CSub(FP,0x6509B0,4)
				CallTrigger(FP,CallMarSkill)
				CAdd(FP,0x6509B0,4)
			CIfEnd()
			CSub(FP,0x6509B0,4)
		CIfEnd()
		CIf(FP,DeathsX(CurrentPlayer,Exactly,5*256,0,0xFF00))
			CAdd(FP,0x6509B0,4)
			CIf(FP,Deaths(CurrentPlayer,AtLeast,1,0))
				CSub(FP,0x6509B0,4)
				CallTrigger(FP,CallMarSkill)
				CAdd(FP,0x6509B0,4)
			CIfEnd()
			CSub(FP,0x6509B0,4)
		CIfEnd()
		
	CIfEnd()



	EXCC_ClearCalc()
	EXCC_Part2()
	EXCC_Part3X()
	for i = 0, 1699 do -- Part4X ?? Cunit Loop (x1700)
		EXCC_Part4X(i,{
			DeathsX(19025+(84*i)+9,AtMost,0,0,0xFF0000),
			DeathsX(19025+(84*i)+19,AtLeast,1*256,0,0xFF00),
		},
		{MoveCp(Add,25*4),
		SetCVar(FP,CurCunitI2[2],SetTo,i),--SetResources(P1,Add,1,Gas)
		})
	end
	EXCC_End()




	EXCC_Part1(DUnitCalc) -- ???????? ?ν? ?ܶ? ????
	Check_Enemy = def_sIndex()
	NJump(FP,Check_Enemy,{DeathsX(CurrentPlayer,AtLeast,4,0,0xFF)})
	DoActions(FP,MoveCp(Add,6*4))
	
	WhiteList2 = def_sIndex()
	for j, i in pairs(MarID) do
		NJumpX(FP,WhiteList2,{DeathsX(CurrentPlayer,Exactly,i,0,0xFF),CD(Theorist,0)})
	end

	ReviveSkill = def_sIndex()
	CJump(FP,ReviveSkill)
	NJumpXEnd(FP,WhiteList2)
	DoActions(FP,MoveCp(Subtract,6*4))
	CAdd(FP,0x6509B0,21)
	CIf(FP,{CV(Level,50,AtLeast)})
	f_SaveCp()
	NIfX(FP,{Cond_EXCC2(UnivCunit,CurCunitI2,1,Exactly,0)})
		CMov(FP,CPlayer,_Read(_Sub(BackupCp,21)),nil,0xFF)
		CCMU_Check = def_sIndex()
		NJump(FP,CCMU_Check,{Memory(0x628438,AtMost,0)},{TSetMemory(0x6509B0,SetTo,CPlayer),
			PlayWAV("staredit\\wav\\revive.ogg"),
			DisplayText(StrDesign("\x08ERROR : \x04????(Nextptrs)?? ã?? ?? ?????ϴ?. \x07?һ? \x04??ġ?? ???????? ?????մϴ?."),4),
			SetMemory(0x6509B0,SetTo,FP),
			TSetDeaths(CPlayer,Add,1,178)
		})

		f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			CSub(FP,CurCunitI,Nextptrs,19025)
			f_Div(FP,CurCunitI,_Mov(84))
		CDoActions(FP,{
			TSetMemoryX(_Add(Nextptrs,9),SetTo,0,0xFF0000);
			Set_EXCC2(UnivCunit,CurCunitI2,1,SetTo,0),
			Set_EXCC2(UnivCunit,CurCunitI2,2,SetTo,0),
			Set_EXCC2(UnivCunit,CurCunitI,0,SetTo,0),
			Set_EXCC2(UnivCunit,CurCunitI,1,SetTo,600*24),
			Set_EXCC2(UnivCunit,CurCunitI,2,SetTo,30*24),
			Set_EXCC2(UnivCunit,CurCunitI,3,SetTo,0),
			Set_EXCC2(UnivCunit,CurCunitI,4,SetTo,0),
			Set_EXCC2(UnivCunit,CurCunitI,5,SetTo,0),
			Set_EXCC2(UnivCunit,CurCunitI,6,SetTo,0),
		})
		CSub(FP,BackupCp,30)
		f_Read(FP,BackupCp,CPos)
		CAdd(FP,BackupCp,30)
		Convert_CPosXY()
		--TriggerX(FP,{CDeaths(FP,AtLeast,1,BYDBossStart2)},{BYDBossMarHPRecover},{preserved})
		Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
			for i = 0, 3 do
				TriggerX(FP,{CV(CPlayer,i)},{
				CreateUnitWithProperties(1,MarID[i+1],1,i,{energy = 100,invincible = true}),
				SetMemory(0x6509B0,SetTo,i),
				PlayWAV("staredit\\wav\\revive.ogg"),
				DisplayText(StrDesign("\x16??\x04?? ???? "..Color[i+1].."??\x11??\x03??\x18??"..Color[i+1].."?? "..Color[i+1].."??\x04???????????? \x16??\x04?? \x03?ູ\x04?? ?޾? \x07?һ??Ͽ????ϴ?. \x1B(?????? ?????ð? : 10??)"),4),
				SetMemory(0x6509B0,SetTo,FP),
				--RunAIScriptAt("Recall Here",24)
			},{preserved})
				TriggerX(FP,{CV(CPlayer,i),Command(P6,AtMost,0,BossUID[2])},{
				SetMemoryB(0x665C48+380,SetTo,0);
				SetMemoryX(0x666458, SetTo, 391,0xFFFF),
				CreateUnitWithProperties(1,33,1,FP,{energy = 100}),
				RemoveUnit(33,FP),
				SetMemoryB(0x665C48+380,SetTo,1);
				SetMemoryX(0x666458, SetTo, 546,0xFFFF),
				},{preserved})
			end
			f_Read(FP,_Add(Nextptrs,0x28/4),TempTarget)
		CIf(FP,{TMemoryX(_Add(Nextptrs,19),Exactly,2*256,0xFF00),TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
		CDoActions(FP,{
			TSetMemory(_Add(Nextptrs,0x5C/4),SetTo,0),
			TSetMemory(_Add(Nextptrs,0x18/4),SetTo,TempTarget),
			TSetMemory(_Add(Nextptrs,0x58/4),SetTo,TempTarget),
			TSetMemory(_Add(Nextptrs,0x10/4),SetTo,TempTarget),
			TSetMemoryX(_Add(Nextptrs,19),SetTo,107*256,0xFF00),
		})
		CTrigger(FP, {CD(MarDup,1)},{
			TSetMemoryX(_Add(Nextptrs,55),SetTo,0xA00000,0xA00000),

		} ,1)
		CIfEnd()
		--TriggerX(FP,{CDeaths(FP,AtLeast,1,BYDBossStart2)},{BYDBossMarHPPatch},{preserved})
		--CMov(FP,BackupCp,Nextptrs,40)
		NJumpEnd(FP,CCMU_Check)
		CDoActions(FP,{
			Set_EXCC2(UnivCunit,CurCunitI2,1,SetTo,0),
			Set_EXCC2(UnivCunit,CurCunitI2,2,SetTo,0),
		})
		EXCC_ClearCalc()
		NElseX()
		CDoActions(FP,{
			Set_EXCC2(UnivCunit,CurCunitI2,1,SetTo,0),
			Set_EXCC2(UnivCunit,CurCunitI2,2,SetTo,0),
		})

	NIfXEnd()
	f_LoadCp()
	CIfEnd()
	CSub(FP,0x6509B0,21)
	DoActions(FP,MoveCp(Add,6*4))

	
	CJumpEnd(FP,ReviveSkill)

	Install_DeathNotice()



	EXCC_ClearCalc()
	NJumpEnd(FP,Check_Enemy)
	DoActions(FP,MoveCp(Add,6*4))
	EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,35,0,0xFF))
	EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,204,0,0xFF))
	EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,33,0,0xFF))
	EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,84,0,0xFF))
	EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,94,0,0xFF))
	EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,42,0,0xFF))
	EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,191,0,0xFF))
	EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,128,0,0xFF))
	EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,205,0,0xFF))

	CIf(FP,DeathsX(CurrentPlayer,Exactly,156,0,0xFF)) -- ???Ϸ? ?ν?
		f_SaveCp()
		f_Read(FP,_Sub(BackupCp,15),CPos)
		Convert_CPosXY()
		Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,CreateScanEff(981))
		DoActions2(FP,{RotatePlayer({MinimapPing(1),
		PlayWAVX("staredit\\wav\\Eff1.ogg"),
		PlayWAVX("staredit\\wav\\Eff1.ogg"),
		PlayWAVX("sound\\glue\\bnetclick.wav"),
		PlayWAVX("sound\\glue\\bnetclick.wav")},HumanPlayers,FP)})
		CMov(FP,CPlayer,_Read(_Sub(BackupCp,6)),nil,0xFF)
		for i = 4, 7 do
			TriggerX(FP,{CV(CPlayer,i)},{AddCD(PyCCode[i-3],1)},{preserved})
			if i ==4 then
				TriggerX(FP,{CV(CPlayer,i)},{AddCD(PyCcodeAxiom,1)},{preserved})
			end
			
		end
		
		f_LoadCp()
	CIfEnd()
	CIf(FP,{CD(NCBullet,1),DeathsX(CurrentPlayer,Exactly,14,0,0xFF)}) -- ?ٹ̻???
		f_SaveCp()
		f_Read(FP,_Sub(BackupCp,15),CPos)
		Convert_CPosXY()
		CFor(FP, 0, 256, 8)
		local CI = CForVariable()
		CreateBullet(206, 20, CI, {CPosX,CPosY}, FP)
		CForEnd()
		f_LoadCp()
	CIfEnd()



	CallTriggerX(FP,MakeEisEgg,{Command(FP,AtLeast,1,190),Cond_EXCC(13,Exactly,1,1)})
	TriggerX(FP,{Cond_EXCC(13,Exactly,2,2)},{SetCD(AxiomCcode[4],1)})
	CIf(FP,{Cond_EXCC(1,Exactly,1),Command(FP,AtLeast,1,190)}) -- ?????????ν?
	f_SaveCp()
	InstallHeroPoint()
	CIfEnd()
	CIf(FP,{DeathsX(CurrentPlayer,Exactly,116,0,0xFF)}) -- ?????????ν?
		f_SaveCp()
		f_Read(FP,_Sub(BackupCp,15),BCPos)
		CMov(FP,CPlayer,_Read(_Sub(BackupCp,6)),nil,0xFF)
		Simple_SetLocX(FP,9,EXCC_TempVarArr[6],EXCC_TempVarArr[7],EXCC_TempVarArr[6],EXCC_TempVarArr[7])

		for i = 7, 11 do
		CWhile(FP,{Cond_EXCC(i,AtLeast,1)})
			CIf(FP,Memory(0x628438,AtLeast,1))
				f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
				Convert_CPosXY(BCPos)
				Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
				TriggerX(FP,CVar(FP,EXCC_TempVarArr[i+1][2],Exactly,118,0xFF),{SetMemoryX(0x664080 + (118*4),SetTo,1,1),SetMemory(0x662860+(118*4),SetTo,65537)},{preserved})
				for j = 0, 3 do
				CTrigger(FP,{CVar(FP,CPlayer[2],Exactly,j+4,0xFF)},{TCreateUnitWithProperties(1,_Mov(EXCC_TempVarArr[i+1],0xFF),22+j,CPlayer,{energy = 100}),TMoveUnit(1,_Mov(EXCC_TempVarArr[i+1],0xFF),_Mov(CPlayer,0xFF),22+j,1)},1)
				end
				CIf(FP,{TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
					CTrigger(FP, {TMemoryX(_Add(Nextptrs,25),Exactly,63,0xFF)},
					{TSetMemoryX(_Add(Nextptrs,40),SetTo,50*16777216,0xFF000000)}, 1)
					f_Read(FP,_Add(Nextptrs,10),CPos)
					Convert_CPosXY()
					CDoActions(FP,{TSetMemoryX(_Add(Nextptrs,35), SetTo, CPlayer, 0xFF),})
					Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
					DoActions2(FP,{Order("Men",Force2,1,Attack,10),Simple_CalcLoc(0,-64,-64,64,64)})
					CTrigger(FP,{Cond_EXCC(12,Exactly,1,1)},{TSetMemory(_Add(Nextptrs,13),SetTo,64)},1)
					--CTrigger(FP,{Cond_EXCC(12,Exactly,4,4)},{TSetMemory(0x6509B0,SetTo,_Mov(CPlayer,0xFF)),RunAIScriptAt(JYD,1)},1)
				CIfEnd()
				TriggerX(FP,CVar(FP,EXCC_TempVarArr[i+1][2],Exactly,118,0xFF),{SetMemoryX(0x664080 + (118*4),SetTo,0,1),SetMemory(0x662860+(118*4),SetTo,64+(64*65536))},{preserved})
			CIfEnd()
			CDoActions(FP,{Set_EXCC(i,SetTo,_Div(EXCC_TempVarArr[i+1],256))})
		CWhileEnd()
		end
		for i = 0, 3 do
			DoActions(FP,Order("Men",4+i,22+i,Attack,2+i))
		end

		f_LoadCp()
	CIfEnd()
--    CMov(FP,Gun_Type,0)
	for j, k in pairs(f_GunTable) do
	f_GSend(k)
	end
	
	
	--?׿? ??????
	--{?????? ??ȣ,{???????̺?},{??????Ʈ??????},{????Ʈ??ȣ}}
	OtherGunT = {
		

		{135,{{53},{103}},{"Star1","Circle1"},{982,366}},--????????
		{136,{{46},{54,50}},{"L00_1_128F","L00_1_64F"},{984,365}},--???ĸ?????
		{137,{{56,62}},{"H00_1_82F"},{366}},--?׷????ͽ????̾?
		{138,{{45},{40,51,104}},{"H00_1_128F","QNest"},{984,366}},--???׽?Ʈ
		{139,{{53},{15}},{"EChamb","H00_1_96F"},{366,367}},--????????è??
		{140,{{48}},{"H00_1_64L"},{365}},--??Ʈ??
		{141,{{55}},{"H00_1_82F"},{366}},--?????̾?
		{142,{{54}},{"Circle2"},{982}},--??????Ǯ

	}
	OtherG = def_sIndex()
	for j, k in pairs(OtherGunT) do
		NJumpX(FP,OtherG,DeathsX(CurrentPlayer,Exactly,k[1],0,0xFF))
	end
	if TestStart == 1 then
		--f_GSend(146)
		--f_GSend(136)
	end

	TriggerX(FP, {CVar(FP,SetPlayers[2],Exactly,1)}, AddV(CurEXP,1),{preserved})
	EXCC_ClearCalc(AddV(CurEXP,1))
	NJumpXEnd(FP,OtherG)
	C_UID = CreateVar(FP)
	f_SaveCp()
	f_Read(FP,_Sub(BackupCp,15),CPos)
	f_Read(FP,BackupCp,C_UID)
	f_Read(FP,_Sub(BackupCp,6),G_CA_Player)
	Convert_CPosXY()
	CMov(FP,G_CA_CenterX,CPosX)
	CMov(FP,G_CA_CenterY,CPosY)
	CMov(FP,TRepeatX,G_CA_CenterX)
	CMov(FP,TRepeatY,G_CA_CenterY)
	CIf(FP,CD(Theorist,1))
	CMov(FP,UnitIDV1,VArr(Tier1VA,f_CRandNum(#Tier1,0)))
	f_TempRepeat2X({CV(Time1,300000,AtLeast)},UID1I,_Div(Time1,_Mov(300000)),233,"CP","X",2)
	CMov(FP,UnitIDV1,VArr(Tier2VA,f_CRandNum(#Tier2,0)))
	f_TempRepeat2X({CV(Time1,600000,AtLeast)},UID1I,_Div(Time1,_Mov(600000)),545,"CP","X",2)
	CMov(FP,UnitIDV1,VArr(Tier3VA,f_CRandNum(#Tier3,0)))
	f_TempRepeat2X({CV(Time1,1200000,AtLeast)},UID1I,_Div(Time1,_Mov(1200000)),211,"CP","X",2)
	CMov(FP,UnitIDV1,VArr(Tier4VA,f_CRandNum(#Tier4,0)))
	f_TempRepeat2X({CV(Time1,1800000,AtLeast)},UID1I,_Div(Time1,_Mov(1800000)),548,"CP","X",2)
	CMov(FP,UnitIDV1,VArr(Tier5VA,f_CRandNum(#Tier5,0)))
	f_TempRepeat2X({CV(Time1,3600000,AtLeast)},UID1I,_Div(Time1,_Mov(3600000)),984,"CP","X",2)
	CIfEnd()
	for j, k in pairs(OtherGunT) do
		for l,m in pairs(k[2]) do
			G_CA_SetSpawn2X(CVar(FP,C_UID[2],Exactly,k[1],0xFF),m,"ACAS",k[3][l],1,k[4][l],nil,"CP")
		end
	end
	f_LoadCp()



	EXCC_ClearCalc()
	EXCC_Part2()
	EXCC_Part3X()
	for i = 0, 1699 do -- Part4X ?? Cunit Loop (x1700)
		EXCC_Part4X(i,{
		DeathsX(19025+(84*i)+40,AtLeast,1*16777216,0,0xFF000000),
		DeathsX(19025+(84*i)+19,Exactly,0*256,0,0xFF00),
		},
		{SetDeathsX(19025+(84*i)+40,SetTo,0*16777216,0,0xFF000000),
		SetDeathsX(19025+(84*i)+9,SetTo,0*65536,0,0xFF0000),
		MoveCp(Add,19*4),
		SetCVar(FP,CurCunitI2[2],SetTo,i)
		})
	end
	EXCC_End()
	
	
	
	
	SETimer = CreateCcode()
	TriggerX(FP,{CDeaths(FP,Exactly,0,SETimer)},{SetCDeaths(FP,SetTo,0,SoundLimit),SetCDeaths(FP,SetTo,100,SETimer)},{preserved})

	function SwarmSet(LVTable,CUTable)
		local LvLeast
		local LVMost
		if type(LVTable)=="table" then
			LvLeast = LVTable[1]
			LVMost = LVTable[2]
		else
			PushErrorMsg("LVTable_TypeError")
		end
		CIf(FP,{CV(Level,LvLeast,AtLeast),CV(Level,LVMost,AtMost)})
		if type(CUTable)=="table" then
			for j, k in pairs(CUTable) do
				--f_TempRepeat({CV(Level,LvLeast,AtLeast),CV(Level,LVMost,AtMost)},k[1],k[2],1,Player)--
				--CTrigger(FP,{CV(Level,LvLeast,AtLeast),CV(Level,LVMost,AtMost)},{TCreateUnit(k[2],k[1],1,f_CRandNum(4,4))},1)
				f_TempRepeatX(nil,k[1],k[2],194,nil,{CPosX,CPosY})
			end
		else
			PushErrorMsg("CUTable_TypeError")
		end
		CIfEnd()
		
	end
	CIf(FP,{Bring(AllPlayers,AtLeast,1,"Dark Swarm",64)},{Simple_SetLoc(0,0,0,0,0),MoveLocation(1,"Dark Swarm",AllPlayers,"Anywhere"),RemoveUnitAt(1,"Dark Swarm",1,AllPlayers),CreateUnit(1,84,1,FP),KillUnit(84,FP)}) -- ??ũ???? Ʈ????
	f_Read(FP, 0x58DC60, CPosX, nil, nil, 1)
	f_Read(FP, 0x58DC64, CPosY, nil, nil, 1)
	
	
	CIf(FP,Command(FP,AtLeast,1,173))
	SwarmSet({0,9},{{53,5},{54,5}})
	SwarmSet({10,19},{{48,3},{53,3},{55,4}})
	SwarmSet({20,24},{{55,4},{48,2},{54,2},{53,2},{88,1},{21,1}})
	SwarmSet({25,50},{{56,4},{51,2},{104,2},{48,2},{53,2},{54,2},{88,2},{21,2}})
	CIfEnd()
	CIfEnd()
	Install_GunStack()
	TriggerX(FP,{CD(ResNumT[2],1),CD(ResNumT[1],1)},{SetCD(ResNum,1)})
	TriggerX(FP,{CD(ResNumT[2],1),CD(ResNumT[3],1)},{SetCD(ResNum,1)})
	TriggerX(FP,{CD(ResNumT[2],1),CD(ResNumT[4],1)},{SetCD(ResNum,1)})

	Trigger2X(FP, {CD(ResNum,1,AtLeast)}, {AddCD(SpecialEEggCcode,1),
	SetCD(AxiomCcode[2],1),
	RotatePlayer({
		PlayWAVX("staredit\\wav\\FindAxiom.wav"),
		PlayWAVX("staredit\\wav\\FindAxiom.wav"),
		DisplayTextX(string.rep("\n", 20),4),
		DisplayTextX("\x13\x04"..string.rep("??", 56),4),
		DisplayTextX("\x12\n\n\x0D\x0D!H\x13"..AxStrArr[2].."\n\n\n",0),
		DisplayTextX("\x13\x04"..string.rep("??", 56),4),}, HumanPlayers, FP)
	})
	DoActionsX(FP,{
		SetCD(ResNum,0),
		SetCD(ResNumT[1],0),
		SetCD(ResNumT[2],0),
		SetCD(ResNumT[3],0),
		SetCD(ResNumT[4],0),
	})

	CIf(FP,CVar(FP,count[2],AtMost,GunLimit))
		Create_G_CA_Arr()
	CIfEnd()
	WarpXY = {
	{1632,1824},
	{-1632+4096,1824},
	{1632,-1824+4096},
	{-1632+4096,-1824+4096}}
	local WaveT = CreateCcode()
	function WaveSet(LVTable,CUTable)
		local LvLeast
		local LVMost
		if type(LVTable)=="table" then
			LvLeast = LVTable[1]
			LVMost = LVTable[2]
		else
			PushErrorMsg("LVTable_TypeError")
		end
		if type(CUTable)=="table" then
			for j, k in pairs(CUTable) do
				for i = 0, 3 do
					f_TempRepeat({CV(Level,LvLeast,AtLeast),CV(Level,LVMost,AtMost),HumanCheck(i,1),Command(i+4,AtLeast,1,189)},k[1],k[2],194,i+4,{WarpXY[i+1][1],WarpXY[i+1][2]})--
				end
			end
		else
			PushErrorMsg("CUTable_TypeError")
		end
	end
	function WaveSet2(RMTable,CUTable)
		local RMLeast
		local RMMost
		if type(RMTable)=="table" then
			RMLeast = RMTable[1]
			RMMost = RMTable[2]
		else
			PushErrorMsg("LVTable_TypeError")
		end
		if type(CUTable)=="table" then
			for j, k in pairs(CUTable) do
				for i = 0, 3 do
					f_TempRepeat({CV(RedNumber,RMLeast,AtLeast),CV(RedNumber,RMMost,AtMost),HumanCheck(i,1),Command(i+4,AtLeast,1,189)},k[1],k[2],194,i+4,{WarpXY[i+1][1],WarpXY[i+1][2]})--
				end
			end
		else
			PushErrorMsg("CUTable_TypeError")
		end
	end
	CIf(FP,{Command(FP,AtLeast,1,173),CV(Time1,(60*30)*1000,AtMost),CD(WaveT,1800,AtLeast)},SetCD(WaveT,0))

		CIf(FP,{CD(Theorist,1)})
			WaveSet2({0,300},{{3,10},{27,15},{100,10},{57,10},{66,15},{65,15}})
			WaveSet2({300,315},{{3,10},{27,15},{100,10},{57,10}})
			WaveSet2({316,330},{{52,10},{10,15},{98,10},{70,10}})
			WaveSet2({331,350},{{79,7},{80,5},{22,5},{19,5}})
			WaveSet2({350,370},{{28,15},{17,15},{75,10}})
			WaveSet2({371,390},{{88,5},{21,5},{17,5},{77,5},{78,5}})
		CIfEnd()
		WaveSet({0,9},{{53,15},{54,20}})
		WaveSet({10,19},{{48,8},{53,10},{55,10}})
		WaveSet({20,24},{{55,10},{48,8},{54,7},{53,6}})
		WaveSet({25,50},{{56,15},{51,5},{104,5},{48,5},{53,5},{54,5}})
		

		--Tier1 = {17,77,78,76,63,21,88,28,86,75,25}
		--Tier2 = {79,80,52,10,22,19}
		--Tier3 = {27,66,29,98,57,3,8,11,69,100,70,65}
		--Tier4 = {102,61,67,23,81,30}
		--Tier5 = {60,68}
	CIfEnd(AddCD(WaveT,1))
	CIf(FP,{Memory(0x628438,AtLeast,1),CD(Theorist,1),CD(ThCallT,0)})
		TheoristCallArr = {
			{322,50},
			{285,70},
			{250,100},
			{222,110},
			{197,100},
			{165,150},
			{133,110},
			{102,85},
			{84,100},
			{56,70},
			{37,200},
			{10,100},
			{0,350},
		}
		for j, k in pairs(TheoristCallArr) do
			local TempCc = CreateCcode()
			f_TempRepeat({CV(RedNumber,k[1],AtMost),CD(TempCc,0)}, 69, k[2], 186, nil, {2048,2048})
			f_TempRepeat({CV(RedNumber,k[1],AtMost),CD(TempCc,0)}, 11, k[2], 186, nil, {2048,2048})
			TriggerX(FP,{CV(RedNumber,k[1],AtMost),CD(TempCc,0)},{CreateUnit(10,84,64,FP),KillUnit(84,FP),SetCD(TempCc,1)},{preserved})
			TriggerX(FP,{CV(RedNumber,k[1]+1,AtLeast),CD(TempCc,1)},{SetCD(TempCc,0)},{preserved})
		end
	CIfEnd({SubCD(ThCallT,1)})

	CMov(FP,0x6509B0,FP)
for i = 0, 3 do
TriggerX(FP,{CD(PyCCode[i+1],1)},{
	ModifyUnitHitPoints(All,146,i+4,64,70);
	ModifyUnitHitPoints(All,144,i+4,64,70);
	ModifyUnitHitPoints(All,143,i+4,64,70);})
TriggerX(FP,{CD(PyCCode[i+1],2)},{
	ModifyUnitHitPoints(All,146,i+4,64,20);
	ModifyUnitHitPoints(All,144,i+4,64,20);
	ModifyUnitHitPoints(All,143,i+4,64,20);})
TriggerX(FP,{CD(PyCCode[i+1],3)},{
	KillUnit(146,i+4);
	KillUnit(144,i+4);
	KillUnit(143,i+4);})
end




	--
GunSPStr = {
"\x08???? 9?? ",
"\x0E???? 3?? ",
"\x0F?߾? 9?? ",
"\x10?߾? 3?? ",
}
GunPStr = {
"\x08???? ???? ",
"\x0E???? ???? ",
"\x0F???? ?ϴ? ",
"\x10???? ?ϴ? ",
}
CellPStr = {
"\x08?߾? ???? ",
"\x0E?߾? ?ϴ? ",
"\x0F?߾? ???? ",
"\x10?߾? ???? ",
}


for i = 4, 7 do
	InvDisable(154,i,{CD(PyCCode[i-3],3,AtLeast)},GunPStr[i-3].."\x04???? \x10"..Conv_HStr("<19>F<1D>elis").." \x04?? \x02????????\x04?? ?????Ǿ????ϴ?.")
	InvDisable(147,i,{CD(CereCond[i-3],2,AtLeast)},GunPStr[i-3].."\x04???? \x10"..Conv_HStr("<1D>the <19>H<1D>eaven").." \x04?? \x02????????\x04?? ?????Ǿ????ϴ?.")
	--InvDisable(168,i,{CD(HiveCcode[i-3],0,AtMost)},CellPStr[i-3].."\x04???? \x10"..Conv_HStr("<19>R<1D>esonance").." \x04?? \x02????????\x04?? ?????Ǿ????ϴ?.")

	
	InvDisable(189,i,{CD(HactCcode[i-3],0,AtMost),CD(LairCcode[i-3],0,AtMost),CD(HiveCcode[i-3],0,AtMost),CD(CenCcode2[i-3],1,AtLeast)},GunPStr[i-3].."\x04???? \x10"..Conv_HStr("<19>W<1D>arp <19>T<1D>unnel").." \x04?? \x02????????\x04?? ?????Ǿ????ϴ?.")
end
for i = 4, 5 do
	InvDisable(201,i,{CD(IonCcode[i-3],1,AtLeast),CD(NoradCcode[i-3],1,AtLeast)},GunSPStr[i-3].."\x04???? \x10"..Conv_HStr("<19>O<1D>blivion").." \x04?? \x02????????\x04?? ?????Ǿ????ϴ?.")
end
for i = 6, 7 do
	InvDisable(152,i,{CD(IonCcode[i-3],1,AtLeast),CD(NoradCcode[i-3],1,AtLeast)},GunSPStr[i-3].."\x04???? \x10"..Conv_HStr("<19>N<1D>ightmare").." \x04?? \x02????????\x04?? ?????Ǿ????ϴ?.")
end
InvDisable(190,FP,{
	Deaths(4,AtLeast,1,BossUID[1]),
	Deaths(5,AtLeast,1,BossUID[2]),
	Deaths(6,AtLeast,1,BossUID[3]),
	Deaths(7,AtLeast,1,BossUID[4]),
	CD(NexCcode,4,AtLeast);
	CD(TempleCcode,4,AtLeast);
	CD(OvCcode,4,AtLeast);
	CD(OvGCcode,4,AtLeast);
	CD(CellCcode,4,AtLeast);
	CD(XelCcode,4,AtLeast);
	CD(CenCcode,4,AtLeast);
	CD(OcCcode,2,AtLeast);
	CD(DgCcode,2,AtLeast); 
	CD(GeneCcode,2,AtLeast);
},"\x17?߾? \x10"..Conv_HStr("<08>C<1D>ore <1C>of <08>D<1D>epth").." \x04?? \x02????????\x04?? ?????Ǿ????ϴ?.")

CanText = "\x13\x04\n\x0D\x0D\x13\x04????????\x08?ף??ңΣɣΣ?\x04????????\n\x14\n\x14\n"..StrDesignX("\x04?ʻ??? ?????? \x08????????\x04?? ?̻? ?ֽ??ϴ?.").."\n"..StrDesignX("\x08ĵ??\x04?? \x074ȸ ?̻?\x04 ?ɸ? ???? \x10????\x04???? \x06?й?\x04?մϴ?.\x04").."\n\n\x14\n\x0D\x0D\x13\x04????????\x08?ף??ңΣɣΣ?\x04????????\n\x0D\x0D\x13\x04"
Trigger2X(FP, {
	Command(FP,AtLeast,1,173);
	CDeaths(FP,AtMost,0,CanCT);
	CDeaths(FP,Exactly,0,CanWT);
	CVar(FP,count[2],AtLeast,1500);}, {
	RotatePlayer({
		DisplayTextX(CanText,4),
		PlayWAVX("sound\\Terran\\RAYNORM\\URaPss02.WAV"),
		PlayWAVX("sound\\Terran\\RAYNORM\\URaPss02.WAV")
	},HumanPlayers,FP);
	SetCDeaths(FP,Add,24*10,CanWT);}, {preserved})

CIf(FP,{--ĵ?ߵ?
Command(FP,AtLeast,1,173);
	CV(CanC,2,AtMost);
	CDeaths(FP,AtMost,0,CanCT);
	CVar(FP,count[2],AtLeast,1500);
	Memory(0x628438,AtMost,0);
},{
	SetCD(ThCallT,50);
	AddCD(RedNumPanelty,1);
	KillUnit("Factories",Force2);
	SetCDeaths(FP,SetTo,24*30,CanCT);
	AddV(CanC,1);})

Trigger2X(FP,{},{
	RotatePlayer({
		PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
		PlayWAVX("staredit\\wav\\warn.wav"),
		PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV"),
		PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV")
		},HumanPlayers,FP);
},{preserved})
CIfEnd()
CIf(FP, {--ĵ?ߵ?
Command(FP,AtLeast,1,173);
	CV(CanC,3,AtLeast);
	CDeaths(FP,AtMost,0,CanCT);
	CVar(FP,count[2],AtLeast,1500);
	Memory(0x628438,AtMost,0);
},{
	AddV(CanC,1);
	SetCD(ThCallT,50);
	KillUnit("Factories",Force2);
	SetCDeaths(FP,Add,1,DefeatCC);
	SetCDeaths(FP,SetTo,24*30,CanCT);})
	
	Trigger2X(FP,{},{
		RotatePlayer({
			PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
			PlayWAVX("staredit\\wav\\CanOver.ogg"),
			PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV"),
			PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV")
			},HumanPlayers,FP);
	},{preserved})
CIfEnd()

DoActions2X(FP,{SubCD(CanWT,1),SubCD(CanCT,1)})
CIf(FP,CD(DefeatCC,1,AtLeast))
DoActionsX(FP,{AddCD(DefeatCC,1)})
DoActions2(FP,{RotatePlayer({
	DisplayTextX(string.rep("\n", 20),4);
	DisplayTextX("\x13\x04"..string.rep("??", 56),4);
	DisplayTextX("\x13\x05?ǣ??ͣš??ϣ֣ţ?",4);
	DisplayTextX("\n",4);
	DisplayTextX("\x13\x15???? ?÷??̾ ???? ?Ҿ????ϴ?.\n",4);
	DisplayTextX("\x13\x05???ӿ??? ?й??Ͽ????ϴ?.",4);
	DisplayTextX("\n",4);
	DisplayTextX("\x13\x05?ǣ??ͣš??ϣ֣ţ?",4);
	DisplayTextX("\x13\x04"..string.rep("??", 56),4);
	PlayWAVX("staredit\\wav\\Game_Over.ogg");
	PlayWAVX("staredit\\wav\\Game_Over.ogg");
	PlayWAVX("staredit\\wav\\Game_Over.ogg");},HumanPlayers,FP)},1)

	

TriggerX(FP,{CD(TestMode,0),CD(DefeatCC,100,AtLeast)},{RotatePlayer({Defeat()},MapPlayers,FP)})
CIfEnd()
TTShape1 = {{416, 1984},{352, 1952},{288, 1920},{224, 1888},{160, 1856},{96, 1824},{32, 1792}}
TTShape3 = {{416, 2144},{352, 2176},{288, 2208},{224, 2240},{160, 2272},{96, 2304},{32, 2336}}
TTShape2 = {{4064, 1792},{4000, 1824},{3936, 1856},{3872, 1888},{3808, 1920},{3744, 1952},{3680, 1984}}
TTShape4 = {{4064, 2336},{4000, 2304},{3936, 2272},{3872, 2240},{3808, 2208},{3744, 2176},{3680, 2144}}
TTCond1 = CreateCcode()
TTAct1 = CreateCcode()
TTCond2 = CreateCcode()
TTAct2 = CreateCcode()
CIf(FP,{CD(TTEndC1,3,AtMost)})
for j, k in pairs(TTShape1) do
	DoActions2X(FP,{Simple_SetLoc(0,k[1]-32,k[2]-32,k[1]+32,k[2]+32),Simple_SetLoc(9,0,0,0,0),MoveLocation(10,"Men",Force1,1),SetCD(TTCond1,1)})
	TriggerX(FP,{
		CD(TTAct1,0),
		Loc(9,0,Exactly,k[1]),
		Loc(9,4,Exactly,k[2]),
	},{SetCD(TTCond1,0)
	},{preserved})
	TriggerX(FP,{CD(TTCond1,1),CD(TTAct1,0)},{SetCD(TTAct1,1),GiveUnits(All,68,P12,11,P5),GiveUnits(All,68,P12,13,P7),SetInvincibility(Disable,68,P5,64),SetInvincibility(Disable,68,P7,64),Order(68,P5,64,Attack,30),Order(68,P7,64,Attack,30)})
	TriggerX(FP,{CD(TTAct1,1)},{Simple_SetLoc(9,k[1]-32,k[2]-32+64,k[1]+32,k[2]+32+64),Order("Men",Force1,1,Move,10)},{preserved})
end
for j, k in pairs(TTShape3) do
	DoActions2X(FP,{Simple_SetLoc(0,k[1]-32,k[2]-32,k[1]+32,k[2]+32),Simple_SetLoc(9,0,0,0,0),MoveLocation(10,"Men",Force1,1),SetCD(TTCond1,1)})
	TriggerX(FP,{
		CD(TTAct1,0),
		Loc(9,0,Exactly,k[1]),
		Loc(9,4,Exactly,k[2]),
	},{SetCD(TTCond1,0)
	},{preserved})
	TriggerX(FP,{CD(TTCond1,1),CD(TTAct1,0)},{SetCD(TTAct1,1),GiveUnits(All,68,P12,11,P5),GiveUnits(All,68,P12,13,P7),SetInvincibility(Disable,68,P5,64),SetInvincibility(Disable,68,P7,64),Order(68,P5,64,Attack,30),Order(68,P7,64,Attack,30)})
	TriggerX(FP,{CD(TTAct1,1)},{Simple_SetLoc(9,k[1]-32,k[2]-32-64,k[1]+32,k[2]+32-64),Order("Men",Force1,1,Move,10)},{preserved})
end
CIfEnd()


CIf(FP,{CD(TTEndC2,3,AtMost)})
for j, k in pairs(TTShape2) do
	DoActions2X(FP,{Simple_SetLoc(0,k[1]-32,k[2]-32,k[1]+32,k[2]+32),Simple_SetLoc(9,0,0,0,0),MoveLocation(10,"Men",Force1,1),SetCD(TTCond2,1)})
	TriggerX(FP,{
		CD(TTAct2,0),
		Loc(9,0,Exactly,k[1]),
		Loc(9,4,Exactly,k[2]),
	},{SetCD(TTCond2,0)
	},{preserved})
	TriggerX(FP,{CD(TTCond2,1),CD(TTAct2,0)},{SetCD(TTAct2,1),GiveUnits(All,68,P12,12,P6),GiveUnits(All,68,P12,14,P8),SetInvincibility(Disable,68,P6,64),SetInvincibility(Disable,68,P8,64),Order(68,P6,64,Attack,31),Order(68,P8,64,Attack,31)})
	TriggerX(FP,{CD(TTAct2,1)},{Simple_SetLoc(9,k[1]-32,k[2]-32+64,k[1]+32,k[2]+32+64),Order("Men",Force1,1,Move,10)},{preserved})
end
for j, k in pairs(TTShape4) do
	DoActions2X(FP,{Simple_SetLoc(0,k[1]-32,k[2]-32,k[1]+32,k[2]+32),Simple_SetLoc(9,0,0,0,0),MoveLocation(10,"Men",Force1,1),SetCD(TTCond2,1)})
	TriggerX(FP,{
		CD(TTAct2,0),
		Loc(9,0,Exactly,k[1]),
		Loc(9,4,Exactly,k[2]),
	},{SetCD(TTCond2,0)
	},{preserved})
	TriggerX(FP,{CD(TTCond2,1),CD(TTAct2,0)},{SetCD(TTAct2,1),GiveUnits(All,68,P12,12,P6),GiveUnits(All,68,P12,14,P8),SetInvincibility(Disable,68,P6,64),SetInvincibility(Disable,68,P8,64),Order(68,P6,64,Attack,31),Order(68,P8,64,Attack,31)})
	TriggerX(FP,{CD(TTAct2,1)},{Simple_SetLoc(9,k[1]-32,k[2]-32-64,k[1]+32,k[2]+32-64),Order("Men",Force1,1,Move,10)},{preserved})
end
CIfEnd()

for j = 4, 7 do
Trigger2X(FP,{Deaths(j,AtLeast,1,BossUID[j-3])},{SetScore(Force1,Add,500000,Kills),RotatePlayer({PlayWAVX("staredit\\wav\\E_Clear.ogg"),PlayWAVX("staredit\\wav\\E_Clear.ogg"),PlayWAVX("staredit\\wav\\E_Clear.ogg"),PlayWAVX("staredit\\wav\\E_Clear.ogg"),DisplayTextX("\n\n\n\x0D\x0D\x13\x04\n\x0D\x0D\x13\x04????????\x07?£ϣӣӡ??ạ̃ţ???\x04????????\n\x14\x14\n\x0D\x0D!H\x13\x04\x07????\x04?? ??ȣ?? \x10?? "..HName[j-3].."\x10 ?? \x04?? óġ?Ͽ????ϴ?.\n\x0D\x0D!H\x13\x04+ \x1F?????????????? ?У???\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04????????\x07?£ϣӣӡ??ạ̃ţ???\x04????????\n\x0D\x0D\x13\x04\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14",4)},HumanPlayers,FP)})
end
TargetRotation = CreateVar(FP)
WBreak=CreateCcode()
for i = 0, 3 do
	DoActionsX(FP,{SetCD(WBreak,100)})
	CWhile(FP,{TTOR({HumanCheck(i,0),Command(FP,AtMost,0,173)}),Bring(i+4,AtLeast,1,"Men",36+i),CD(WBreak,1,AtLeast)},SubCD(WBreak,1))
	f_Lengthdir(FP,f_CRandNum(384,320),_Mod(_Rand(),360),T_X,T_Y)
	f_Div(FP,T_Y,2)
	Simple_SetLocX(FP,9,T_X,T_Y,T_X,T_Y,{Simple_CalcLoc(9,2048,2048,2048,2048)})
	DoActions(FP,{MoveUnit(1,"Men",i+4,36+i,10)})
--    NJumpXEnd(FP,L_Gun_Move)
--    CMov(FP,TargetRotation,f_CRandNum(4))
--    
--	for i = 0, 3 do
--		CIf(FP,{CVar(FP,TargetRotation[2],Exactly,i),HumanCheck(i,0)})
--		DoActions(FP,{SetSwitch(RandSwitch,Random),SetSwitch(RandSwitch2,Random)})
--		TriggerX(FP,{Switch(RandSwitch,Cleared),Switch(RandSwitch2,Cleared)},{SetV(TargetRotation,0)},{preserved})
--		TriggerX(FP,{Switch(RandSwitch,Set),Switch(RandSwitch2,Cleared)},{SetV(TargetRotation,1)},{preserved})
--		TriggerX(FP,{Switch(RandSwitch,Cleared),Switch(RandSwitch2,Set)},{SetV(TargetRotation,2)},{preserved})
--		TriggerX(FP,{Switch(RandSwitch,Set),Switch(RandSwitch2,Set)},{SetV(TargetRotation,3)},{preserved})
--		CIfEnd()
--	end
--    for j = 0, 3 do
--    NJumpX(FP,L_Gun_Move,{CVar(FP,TargetRotation[2],Exactly,j),HumanCheck(j,0)}) -- Ÿ?? ???? ?? ?÷??̾ ???? ???? ?ٽ? ??????
--    end
--	for i = 0, 3 do
--        TriggerX(FP,{CV(TargetRotation,i)},{Order("Men")},{preserved})
--    end


	CWhileEnd()
end

CIfOnce(FP,CD(Theorist,1)) --?̷?ġ???? init
TheoristPatchArr = {}
for i = 1, 4 do
		table.insert(TheoristPatchArr,SetMemoryW(0x656EB0 + (0*2),SetTo,NMAtk*2)) -- ?⺻???ݷ?
		table.insert(TheoristPatchArr,SetMemoryW(0x657678 + (0*2),SetTo,NMAtkFactor*2)) -- ?߰????ݷ?
		table.insert(TheoristPatchArr,SetMemoryW(0x656EB0 + (1*2),SetTo,HMAtk*2)) -- ?⺻???ݷ?
		table.insert(TheoristPatchArr,SetMemoryW(0x657678 + (1*2),SetTo,HMAtkFactor*2)) -- ?߰????ݷ?
		table.insert(TheoristPatchArr,SetMemoryW(0x656EB0 + (MarWep[i]*2),SetTo,MarAtk*2)) -- ?⺻???ݷ?
		table.insert(TheoristPatchArr,SetMemoryW(0x657678 + (MarWep[i]*2),SetTo,MarAtkFactor*2)) -- ?߰????ݷ?
end
function TheoristFlingyPatch(FlingyID,TunRad)
	if TunRad ~= nil then
	table.insert(TheoristPatchArr, SetMemoryB(0x6C9E20 + FlingyID,SetTo,TunRad))
	else 
		table.insert(TheoristPatchArr, SetMemoryB(0x6C9E20 + FlingyID,SetTo,40))
	end
	table.insert(TheoristPatchArr, SetMemoryB(0x6C9858 + FlingyID,SetTo,0))
	table.insert(TheoristPatchArr, SetMemory(0x6C9930 + (FlingyID*4),SetTo,0))
	table.insert(TheoristPatchArr, SetMemoryW(0x6C9C78 + (FlingyID*2),SetTo,4000))
	table.insert(TheoristPatchArr, SetMemory(0x6C9EF8 + (FlingyID*4),SetTo,20000))
end

TheoristFlingyPatch(44,40)--??Ʋ
TheoristFlingyPatch(72,127)--??????
DoActions2X(FP,{
RemoveUnit(203,AllPlayers),
SetMemoryW(0x656EB0+(0*2),Add,15);
SetMemoryW(0x657678+(0*2),Add,1);
SetMemoryW(0x656EB0+(1*2),Add,50);
SetMemoryW(0x657678+(1*2),Add,3);TheoristPatchArr,
SetV(Level,50),
SetV(AtkCondTmp,100),
SetV(HPCondTmp,50),
SetMemoryW(0x656888 + (2*62), SetTo, 32), -- ???κ꽺??
SetMemoryW(0x6570C8 + (2*62), SetTo, 32), -- ???κ꽺??
SetMemoryW(0x657780 + (2*62), SetTo, 32), -- ???κ꽺??
SetMemoryX(0x664080 + (22*4),SetTo,0x00400200,0x00400200),
SetMemoryX(0x664080 + (70*4),SetTo,0x00400200,0x00400200),
SetMemoryX(0x664080 + (98*4),SetTo,0x00400200,0x00400200),
SetMemoryX(0x664080 + (13*4),SetTo,0x00400200,0x00400200),
SetMemoryB(0x669E28+(974), SetTo, 16),
SetMemory(0x662350+(64*4),SetTo,1200000*256),
SetMemoryX(0x656EBC, SetTo, 999,0xFFFF);--???ε?
SetMemoryX(0x662DC4, SetTo, 256*6,0xFF00);--????SeekRange
SetMemoryW(0x663888 + (28 *2),SetTo,NMCost+HMCost+LMCost2);--???̸??? ???? ?缳??

})
TheoristTxt = "\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04\n\x0D\x0D\x13\x04????????\x08?ͣϣģš??ţΣ??£̣?\x04????????\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D!H\x13\x10?????? \x04MODE\x04 ?? \x03Ȱ??ȭ\x04?Ǿ????ϴ?.\n\x0D\x0D!H\x13\x07Level\x04?? \x17?̻??? Ʈ??\x04?? ?????ǰ? \x1B?Ϻ? ????\x04?? ?ټ? \x10????\x04?Ǹ?, \x08???ݷ? 2??\x04?? ?????˴ϴ?.\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04????????\x08?ͣϣģš??ţΣ??£̣?\x04????????\n\x0D\x0D\x13\x04"
DoActions2(FP,{RotatePlayer({DisplayTextX(TheoristTxt,4),PlayWAVX("staredit\\wav\\SkillUnlock.ogg"),PlayWAVX("staredit\\wav\\SkillUnlock.ogg"),PlayWAVX("staredit\\wav\\SkillUnlock.ogg"),PlayWAVX("staredit\\wav\\SkillUnlock.ogg")},HumanPlayers,FP)})
	
for k = 1, 4 do
	Trigger2X(FP,{CVar(FP,SetPlayers[2],Exactly,k);},{RotatePlayer({SetMissionObjectivesX("\x13\x04????Ű???? \x07?ͣ????????? ??\n\x13"..Players[k].." \x17ȯ???? : \x1B"..ExRate[k].."%\n\x13\x04Marine + \x1F"..HMCost.." Ore\x04 = \x1BH \x04Marine\n\x13\x1BH \x04Marine + \x1F"..LMCost2.." Ore \x04= \x08??\x11??\x03??\x18??\x08?? \x08??\x04??????????\n\x13\x04????????????????????????????????????????????????????????????\n\x13\x04Thanks to : +=.=+, A..K, psc.Archive, CheezeNacho, LucasSpia, \n\x13\x04njjds148, lptime106, -Men-, Ninfia, NyanCats\n\x13\x04Spetial Thanks : Balexs")},HumanPlayers,FP);
})
	end


CIfEnd()


EraUngmeojulCT = CreateCcodeArr(#EraUngmeojulT)
if CheatEnableFlag== 1 then
	CIf(FP,{CD(CheatMode,1)})
		CIfOnce(FP)
		CheatTxt = "\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04????????\x08?ͣϣģš??ţΣ??£̣?\x04????????\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D!H\x13\x07CHEAT \x04MODE\x04 ?? \x03Ȱ??ȭ\x04?Ǿ????ϴ?.\n\x0D\x0D!H\x13\x07???? ????????\x04?? ?????Ǹ?, \x08?ڵ?ȯ??\x04?? ?????˴ϴ?.\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04????????\x08?ͣϣģš??ţΣ??£̣?\x04????????\n\x0D\x0D\x13\x04"
		DoActions2(FP,{RotatePlayer({DisplayTextX(CheatTxt,4),PlayWAVX("staredit\\wav\\SkillUnlock.ogg"),PlayWAVX("staredit\\wav\\SkillUnlock.ogg"),PlayWAVX("staredit\\wav\\SkillUnlock.ogg"),PlayWAVX("staredit\\wav\\SkillUnlock.ogg")},HumanPlayers,FP)})
		CIfEnd()
		for j, k in pairs(EraUngmeojulT) do
			Trigger2X(FP,{ElapsedTime(AtLeast, (10*j)+300)},{SetCD(EraUngmeojulCT[j],1),SetCD(EraUngmeojulC,1),
			RotatePlayer({
				DisplayTextX("\x0D\x0D!H"..StrDesignX2("\x07???? \x1B?? \x04?? \x08?? \x04"..k[2].." \x04?? ?????????ϴ?."),4),
				DisplayTextX("\x0D\x0D!H"..StrDesignX2("\x07???? \x1B?? \x04?? \x08?? \x04"..k[2].." \x04?? ?????????ϴ?."),4),
				DisplayTextX("\x0D\x0D!H"..StrDesignX2("\x07???? \x1B?? \x04?? \x08?? \x04"..k[2].." \x04?? ?????????ϴ?."),4),
				PlayWAVX("staredit\\wav\\Recall.ogg"),PlayWAVX("staredit\\wav\\Recall.ogg"),PlayWAVX("staredit\\wav\\Recall.ogg"),PlayWAVX("staredit\\wav\\Recall.ogg")}, HumanPlayers, FP)})
		end
	CIfEnd()
end


CallTriggerX(FP,Call_CunitRefrash,{CD(CUnitRefrash,1,AtLeast)},{SetCD(CUnitRefrash,0)})

end

function Sys2()
	
local X = {}
for i = 0, 227 do
	if 
	i ~= 0 and 
	i ~= 1 and 
	i ~= 7 and 
	i ~= 32 and 
	i ~= 58 and 
	i ~= 16 and 
	i ~= 20 and 
	i ~= 99 and 
	i ~= 107 and 
	i ~= 108 and 
	i ~= 111 and 
	i ~= 125 then
		if i%4 == 0 then
			table.insert(X,SetMemoryX(0x662098+0x4*math.floor(i/4),SetTo,0,0xFF))
		elseif i%4 == 1 then 
			table.insert(X,SetMemoryX(0x662098+0x4*math.floor(i/4),SetTo,0,0xFF00))
		elseif i%4 == 2 then 
			table.insert(X,SetMemoryX(0x662098+0x4*math.floor(i/4),SetTo,0,0xFF0000))
		elseif i%4 == 3 then 
			table.insert(X,SetMemoryX(0x662098+0x4*math.floor(i/4),SetTo,0,0xFF000000))
		end
	end
end
DoActions2(FP,X)
ComExitFlag = CreateCcode()
TriggerX(FP,{CD(OPJump,1),Bring(P12,AtLeast,1,"Buildings",64)},{SetCD(ComExitFlag,1)},{preserved})
DoActions2X(FP,{RotatePlayer({SetAllianceStatus(Force1, Enemy),RunAIScript(P1VON),RunAIScript(P2VON),RunAIScript(P3VON),RunAIScript(P4VON)}, {P5,P6,P7,P8}, FP)})
CIf(FP,CD(ComExitFlag,1),SetCD(ComExitFlag,0))
CFor(FP, 19025, 19025+(84*1700), 84)
CI = CForVariable()
CIf(FP,{
	TMemoryX(_Add(CI,19), Exactly, 11,0xFF),
	TMemoryX(_Add(CI,19), AtLeast, 1*256,0xFF00),
	TTMemoryX(_Add(CI,25), NotSame, 58,0xFF),
	TTMemoryX(_Add(CI,25), NotSame, 125,0xFF),
	TTMemoryX(_Add(CI,25), NotSame, 111,0xFF),
	TTMemoryX(_Add(CI,25), NotSame, 107,0xFF),
	TTMemoryX(_Add(CI,25), NotSame, 203,0xFF),
	TMemoryX(_Add(CI,35),AtLeast,4,0xFF),
	TMemoryX(_Add(CI,35),AtMost,7,0xFF),

})
local TempP = CreateVar(FP)
local TempU = CreateVar(FP)
CMov(FP,CunitIndex,_Div(_Sub(CI,19025),_Mov(84)))
local HeroJump = def_sIndex()
NJump(FP, HeroJump, {TMemoryX(_Add(CI,25), Exactly, 68,0xFF),Cond_EXCC2(DUnitCalc, CunitIndex, 1, Exactly, 1)})

CMov(FP,TempP,_Read(_Add(CI,35),0xFF),nil,0xFF,1)
CMov(FP,TempU,_Read(_Add(CI,25)),nil,0xFF)
f_Read(FP,_Add(CI,10),CPos) -- ???????? ??ġ ?ҷ?????
Convert_CPosXY()
Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
CDoActions(FP,{TGiveUnits(1,TempU,P12,1,TempP)})
--f_CGive(FP, CI, nil, TempP, P12)
NJumpEnd(FP,HeroJump)


CIfEnd()
CForEnd()
CIfEnd()
end