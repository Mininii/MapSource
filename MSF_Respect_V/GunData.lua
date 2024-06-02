
function Include_GunData(Size,LineNum)
	local G_TempV,G_A,GunID = CreateVariables(3,FP)
	local GunPlayer = CreateVar(FP)
	local CIndex = FuncAlloc
	f_GunSendT = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: f_GunSend 성공. f_Gun 실행자 : ")
	f_GunSendT2 = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: 성공한 f_GunSend의 EXCunit Number : ")
	G_A = CreateVar(FP)
	FuncAlloc = FuncAlloc + 1
	G_Send = SetCallForward()
	G_InputH = CreateVar(FP)
	f_GunStrPtr = CreateVar(FP)
	Actived_Gun = CreateVar(FP)
	f_GunNum = CreateVar(FP)
	G_TempH = CreateVar(FP)
	f_GunT = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: f_Gun Suspend 성공. f_Gun 실행자 : ")
	G_SendErrT = "\x07『 \x08ERROR : \x04f_Gun의 목록이 가득 차 G_Send를 실행할 수 없습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
	f_GunT2 = CreateCText(FP," \x07』")
	local f_GunNumT = CreateVArray(FP,5)
	Var_InputCVar = {}
	Var_Lines = LineNum
	Var_TempTable = CreateVarArr(Var_Lines,FP)
	f_GunSendStrPtr = CreateVar(FP)
	f_GunSendStrPtr2 = CreateVar(FP)
	
	table.insert(CtrigInitArr[FP+1],SetCtrigX(FP,G_InputH[2],0x15C,0,SetTo,FP,CIndex,0x15C,1,0))--{"X",0x500,0x15C,1,0}--G_InputH
	SetCall(FP)
		f_SaveCp()
		f_Read(FP,_Sub(BackupCp,15),CPos)
		f_Read(FP,BackupCp,GunID,"X",0xFF,1)
		f_Read(FP,_Sub(BackupCp,6),GunPlayer,"X",0xFF)

		CIf(FP, {CV(GunPlayer,7)}) -- P8건물만 건작으로 작동
		function GunBGM(ID,Type,Text,Point,OtherTrig)
			local GText = "\n\n\n\n\n"..StrDesignX(Text.." \x04를 파괴하였습니다\x17 + "..Point.." P t s").."\n\n"
			if Type == nil then
				TriggerX(FP,{CV(GunID,ID)},{SetScore(Force1,Add,Point,Kills),RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP),OtherTrig},{preserved})
			else
				TriggerX(FP,{CV(GunID,ID)},{SetScore(Force1,Add,Point,Kills),SetV(BGMType,Type),RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP),OtherTrig},{preserved})
			end
		end
		GunBGM(131,2,"\x1CB\x04lue \x1CW\x04hite",50000)
		GunBGM(132,3,"\x1FO\x04nly \x1FF\x04or \x1FY\x04ou",50000)
		GunBGM(133,4,"\x11K\x04amui",50000)
		GunBGM(122,5,"\x11A\x04LiCE",65000)
		GunBGM(116,6,"\x11E\x04CiLA",65000)
		GunBGM(114,7,"\x10D\x042",65000)
		GunBGM(113,8,"\x1CO\x04BLIVION",65000)
		GunBGM(148,9,"\x1CH\x04ypernaid",150000)
		GunBGM(130,10,"\x10M\x04isty \x10E\x04'ra '\x10M\x04ui'",300000)

		
		--{5,"staredit\\wav\\BGM_ALiCE.ogg",43*1000},
		--{6,"staredit\\wav\\BGM_ECiLA.ogg",40*1000},
		--{7,"staredit\\wav\\BGM_D2.ogg",37*1000},
		--{8,"staredit\\wav\\BGM_OBLIVION.ogg",48*1000},



--
		Convert_CPosXY()
		CMov(FP,G_A,0)
		G_SkipJump = def_sIndex()
		CJumpEnd(FP,G_SkipJump)
		CAdd(FP,G_TempV,_Mul(G_A,_Mov(0x970/4)),G_InputH)
		NIf(FP,{TMemory(G_TempV,AtLeast,1),CVar(FP,G_A[2],AtMost,Size-1)},{SetCVar(FP,G_A[2],Add,1)})
			CJump(FP,G_SkipJump)
		NIfEnd()
	
		CIfX(FP,{CVar(FP,G_A[2],AtMost,Size-1)})
		CDoActions(FP,{
			TSetMemory(G_TempV,SetTo,GunID),
			TSetMemory(_Add(G_TempV,1*(0x20/4)),SetTo,CPosX),
			TSetMemory(_Add(G_TempV,2*(0x20/4)),SetTo,CPosY),
			TSetMemory(_Add(G_TempV,3*(0x20/4)),SetTo,DUnitCalc[4][3]),
			TSetMemory(_Add(G_TempV,4*(0x20/4)),SetTo,GunPlayer),
		})
		if Limit == 1 then
            DisplayPrint(HumanPlayers,{"\x07『 \x03TESTMODE OP \x04: f_GunSend 성공. f_Gun 실행자 : ",G_A," \x07』"})
            DisplayPrint(HumanPlayers,{"\x07『 \x03TESTMODE OP \x04: 성공한 f_GunSend의 EXCunit Number : ",DUnitCalc[4][3]," \x07』"})
		end
		CElseX()
		DoActions(FP,{RotatePlayer({DisplayTextX(G_SendErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
		CIfXEnd()
		CIfEnd()
		f_LoadCp()
	SetCallEnd()


	
	function f_GSend(UnitID,Actions)
		CallTriggerX(FP,G_Send,{DeathsX(CurrentPlayer,Exactly,UnitID,0,0xFF)},Actions)
	end
	for i = 1, Var_Lines do
		table.insert(Var_InputCVar,SetCVar(FP,Var_TempTable[i][2],SetTo,0))
	end
	function Gun_SetLine(Line,Type,Value,Mask)
		if Mask == nil then
			Mask = 0xFFFFFFFF
		end
		return SetCVar(FP,Var_TempTable[Line+1][2],Type,Value,Mask)
	end
	function TGun_SetLine(Line,Type,Value,Mask)
		if Mask == nil then
			Mask = 0xFFFFFFFF
		end
		return TSetCVar(FP,Var_TempTable[Line+1][2],Type,Value,Mask)
	end

	function Gun_DoSuspend()
		return SetCVar(FP,Var_TempTable[55][2],Add,1)
	end
	
	function Gun_Line(Line,Type,Value,Mask)
		if Mask == nil then
			Mask = 0xFFFFFFFF
		end
		return CVar(FP,Var_TempTable[Line+1][2],Type,Value,Mask)
	end
	function TGun_Line(Line,Type,Value,Mask)
		if Mask == nil then
			Mask = 0xFFFFFFFF
		end
		return TCVar(FP,Var_TempTable[Line+1][2],Type,Value,Mask)
	end
	
	f_Gun = SetCallForward()
	function Install_GunStack()
		CMov(FP,Actived_Gun,0)
		for i = 0, Size-1 do
			local TempCIndex
			if i == 0 then TempCIndex=CIndex else TempCIndex = 0 end
			CTrigger(FP, {CVar("X","X",AtLeast,1)}, {
				Var_InputCVar,
				SetCtrigX("X",G_TempH[2],0x15C,0,SetTo,"X","X",0x15C,1,0),
				SetCVar(FP,f_GunNum[2],SetTo,i),
				SetCVar(FP,Actived_Gun[2],Add,1),
				SetNext("X",f_Gun,0),SetNext(f_Gun+1,"X",1), -- Call f_Gun
				SetCtrigX("X",f_Gun+1,0x158,0,SetTo,"X","X",0x4,1,0), -- RecoverNext
				SetCtrigX("X",f_Gun+1,0x15C,0,SetTo,"X","X",0,0,1), -- RecoverNext
				SetCtrig1X("X",f_Gun+1,0x164,0,SetTo,0x0,0x2) -- RecoverNext
			}, 1,TempCIndex)
		end
	end
	local G_TempW = CreateVar(FP)
	local CurLoc,CurLoc2 = CreateVars(2,FP)
	local GunCaseCheck = CreateCcode()
	local GunCaseErrT = "\x07『 \x08ERROR : \x04등록되지 않은 건작이 작동하여 자동으로 Suspend하였습니다. 건작을 등록해주세요.\x07 』"
	local GunCaseErrT2 = "\x07『 \x08ERROR : \x04등록되지 않은 건작 인덱스가 감지되어 자동으로 Suspend하였습니다. 건작 인덱스를 등록해주세요.\x07 』"
	f_GunTable = {}
	f_GunTCheck = {}
	function CIf_GCase(Index)
		CIf(FP,{Gun_Line(0,Exactly,Index),Gun_Line(54,AtMost,0)},{SetCD(GunCaseCheck,1)})
		table.insert(f_GunTable,Index)
		if f_GunTCheck[Index] ==nil then f_GunTCheck[Index] = true else PushErrorMsg("GCase_Duplicated") end
	end
	function GCP(Value,Type)
		if Type==nil then Type = Exactly end
		return Gun_Line(4,Type,Value)
	end
	function GNm(Value,Type)
		if Type == nil then Type = Exactly end
		return Gun_Line(3,Type,Value)
	end
	SetCall(FP)
	CMov(FP,G_CA_X,Var_TempTable[2])
	CMov(FP,G_CA_Y,Var_TempTable[3])
	Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3])
	DoActionsX(FP,{SetSwitch(RandSwitch1,Random),SetSwitch(RandSwitch2,Random),SetCD(GunCaseCheck,0)})
	CDoActions(FP,{Gun_SetLine(7,Add,1)})
--[[ 자동생성 도형데이터 정리
P_3, 0 : 4
P_4, 0 : 5
P_5, 0 : 6
P_6, 0 : 7
S_3, 0 : 7
P_7, 0 : 8
P_8, 0 : 9
S_4, 0 : 9
P_3, 1 : 10
S_5, 0 : 11
S_6, 0 : 13
P_4, 1 : 13
S_7, 0 : 15
P_5, 1 : 16
S_8, 0 : 17
S_3, 1 : 19
P_3, 2 : 19
P_6, 1 : 19
P_7, 1 : 22
S_4, 1 : 25
P_8, 1 : 25
P_4, 2 : 25
P_3, 3 : 31
P_5, 2 : 31
S_5, 1 : 31
P_6, 2 : 37
S_3, 2 : 37
S_6, 1 : 37
P_4, 3 : 41
P_7, 2 : 43
S_7, 1 : 43
P_3, 4 : 46
P_8, 2 : 49
S_4, 2 : 49
S_8, 1 : 49
P_5, 3 : 51
S_5, 2 : 61
P_6, 3 : 61
P_4, 4 : 61
S_3, 3 : 61
P_3, 5 : 64
P_7, 3 : 71
S_6, 2 : 73
P_5, 4 : 76
P_8, 3 : 81
S_4, 3 : 81
P_4, 5 : 85
P_3, 6 : 85
S_7, 2 : 85
P_6, 4 : 91
S_8, 2 : 97
S_5, 3 : 101
P_5, 5 : 106
P_7, 4 : 106
P_3, 7 : 109
P_4, 6 : 113
P_8, 4 : 121
S_6, 3 : 121
P_6, 5 : 127
P_5, 6 : 141
S_7, 3 : 141
P_4, 7 : 145
P_7, 5 : 148
S_8, 3 : 161
P_8, 5 : 169
P_6, 6 : 169
P_5, 7 : 181
P_7, 6 : 197
P_6, 7 : 217
P_8, 6 : 225
P_7, 7 : 253
P_8, 7 : 289
]]


	
	CIf_GCase(131)--해처리
	G_CA_SetSpawn({GNm(1),Gun_Line(5,Exactly,0)}, {43,37,38,39}, P_5, 2, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({GNm(1),Gun_Line(6,AtLeast,1)}, {44,46,38,39}, P_5, 2, "MAX", 0, nil, nil, P7)
	
	G_CA_SetSpawn({GNm(2),Gun_Line(5,Exactly,0)}, {43,37,38,39}, S_5, 1, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({GNm(2),Gun_Line(6,AtLeast,1)}, {44,46,38,39}, S_5, 1, "MAX", 0, nil, nil, P7)
	
	G_CA_SetSpawn({GNm(3),Gun_Line(5,Exactly,0)}, {43,37,38,39}, P_6, 2, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({GNm(3),Gun_Line(6,AtLeast,1)}, {44,46,38,39}, P_6, 2, "MAX", 0, nil, nil, P7)
	
	G_CA_SetSpawn({GNm(4),Gun_Line(5,Exactly,0)}, {43,37,38,39}, S_3, 2, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({GNm(4),Gun_Line(6,AtLeast,1)}, {44,46,38,39}, S_3, 2, "MAX", 0, nil, nil, P7)
	
	G_CA_SetSpawn({GNm(5),Gun_Line(5,Exactly,0)}, {43,37,38,39}, S_6, 1, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({GNm(5),Gun_Line(6,AtLeast,1)}, {44,46,38,39}, S_6, 1, "MAX", 0, nil, nil, P7)

	
	
	
	
	
	
	
	
	
	
	CIfEnd()
	CIf_GCase(132)--레어
	G_CA_SetSpawn({GNm(1),Gun_Line(5,Exactly,0)}, {55,53,54,46}, P_6, 2, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({GNm(1),Gun_Line(6,AtLeast,1)}, {56,53,51,48}, P_6, 2, "MAX", 0, nil, nil, P7)
	
	G_CA_SetSpawn({GNm(2),Gun_Line(5,Exactly,0)}, {55,53,54,46}, S_3, 2, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({GNm(2),Gun_Line(6,AtLeast,1)}, {56,53,51,48}, S_3, 2, "MAX", 0, nil, nil, P7)
	
	G_CA_SetSpawn({GNm(3),Gun_Line(5,Exactly,0)}, {55,53,54,46}, S_6, 1, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({GNm(3),Gun_Line(6,AtLeast,1)}, {56,53,51,48}, S_6, 1, "MAX", 0, nil, nil, P7)
	
	G_CA_SetSpawn({GNm(4),Gun_Line(5,Exactly,0)}, {55,53,54,46}, P_4, 3, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({GNm(4),Gun_Line(6,AtLeast,1)}, {56,53,51,48}, P_4, 3, "MAX", 0, nil, nil, P7)
	CIfEnd()


	CIf_GCase(133)--하이브
	CIf(FP,GNm(1))
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, {21,17}, {P_8,S_4}, {0,0}, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {21,17}, {S_5,P_5}, {1,2}, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0)}, {55,53,54,46}, S_5, 1, "MAX", 0, nil, nil, P7)

	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,1)}, {19,28}, {P_6,S_3}, {0,0}, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2,AtLeast)}, {19,28}, {P_6,S_3}, {2,2}, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1)}, {56,53,51,48}, S_5, 1, "MAX", 0, nil, nil, P7)
	CIfEnd()

	CIf(FP,GNm(2))

	
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, {88,77}, {P_3,P_4}, {0,0}, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {88,77}, {P_3,P_5}, {3,2}, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0)}, {55,53,54,46}, P_6, 3, "MAX", 0, nil, nil, P7)

	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,1)}, {78,86}, {P_7,P_8}, {0,0}, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2,AtLeast)}, {78,86}, {S_4,P_8}, {1,1}, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1)}, {56,53,51,48}, P_6, 3, "MAX", 0, nil, nil, P7)

	
	CIfEnd()

	CIfEnd()

	
	
	
	--ZUnit : S_5, 2 : 61
	--ZUnit : P_6, 3 : 61
	-- EnBay1 HD 9
	-- EnBay2 MXSC 36
	CIf_GCase(122)--엔베
	CIf(FP,GNm(1))
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, {75,88}, "ACAS", "EnBay1", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {75,88}, "ACAS", "EnBay2", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0)}, {55,53,54,46}, S_5, 2, "MAX", 0, nil, nil, P7)

	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,1)}, {75,88}, "ACAS", "EnBay1", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2,AtLeast)}, {75,88}, "ACAS", "EnBay2", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1)}, {56,53,51,48}, P_6, 3, "MAX", 0, nil, nil, P7)
	CIfEnd()
	--P_5, 3 : 51
	--S_5, 2 : 61
	CIf(FP,GNm(2))
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, {"Kazansky","Raynor V"}, "ACAS", "EnBay1", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {"Kazansky","Raynor V"}, "ACAS", "EnBay2", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0)}, {55,53,54,46}, P_5, 3, "MAX", 0, nil, nil, P7)

	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,1)}, {"Kazansky","Raynor V"}, "ACAS", "EnBay1", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2,AtLeast)}, {"Kazansky","Raynor V"}, "ACAS", "EnBay2", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1)}, {56,53,51,48}, S_5, 2, "MAX", 0, nil, nil, P7)
	CIfEnd()
	--P_3, 4 : 46
	--P_8, 2 : 49
	CIf(FP,GNm(3))
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, {"Schezar","Hyperion"}, "ACAS", "EnBay1", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {"Schezar","Hyperion"}, "ACAS", "EnBay2", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0)}, {55,53,54,46}, P_3, 4, "MAX", 0, nil, nil, P7)

	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,1)}, {"Schezar","Hyperion"}, "ACAS", "EnBay1", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2,AtLeast)}, {"Schezar","Hyperion"}, "ACAS", "EnBay2", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1)}, {56,53,51,48}, P_8, 2, "MAX", 0, nil, nil, P7)
	CIfEnd()
	--S_4, 2 : 49
	--S_8, 1 : 49
	CIf(FP,GNm(4))
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, {"Fenix Z","Lin"}, "ACAS", "EnBay1", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {"Fenix Z","Lin"}, "ACAS", "EnBay2", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0)}, {55,53,54,46}, S_4, 2, "MAX", 0, nil, nil, P7)

	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,1)}, {"Fenix D","Lin"}, "ACAS", "EnBay1", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2,AtLeast)}, {"Fenix D","Lin"}, "ACAS", "EnBay2", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1)}, {56,53,51,48}, S_8, 1, "MAX", 0, nil, nil, P7)
	CIfEnd()

	--ZUnit : P_4, 4 : 61
	--ZUnit : S_3, 3 : 61
	--HD
	--P_4, 0 : 5
	--P_5, 0 : 6
	--S_3, 0 : 7
	--P_7, 0 : 8

	--MXSC
	---S_3, 2 : 37
	---S_6, 1 : 37
	---P_8, 2 : 49
	---S_4, 2 : 49
	--[[
	CIf(FP,GNm(2))
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, {"Duke Siege","Kazansky"}, {P_4,P_5}, {0,0}, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {"Duke Siege","Kazansky"}, {S_3,S_6}, {2,1}, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0)}, {55,53,54,46}, P_4, 4, "MAX", 0, nil, nil, P7)

	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,1)}, {"Duke Siege","Kazansky"}, {S_3,P_7}, {0,0}, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2,AtLeast)}, {"Duke Siege","Kazansky"}, {P_8,S_4}, {2,2}, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1)}, {56,53,51,48}, S_3, 3, "MAX", 0, nil, nil, P7)
	CIfEnd()
]]
	CIfEnd()

	-- Fac1 HD 9
	-- Fac2 MXSC 36
	CIf_GCase(113)--팩
	--P_8, 3 : 81
	--S_4, 3 : 81
	CIf(FP,GNm(1))
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, {75,88}, "ACAS", "Fac1", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {75,88}, "ACAS", "Fac2", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0)}, {55,53,54,46}, P_8, 3, "MAX", 0, nil, nil, P7)

	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,1)}, {75,88}, "ACAS", "Fac1", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2,AtLeast)}, {75,88}, "ACAS", "Fac2", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1)}, {56,53,51,48}, S_4, 3, "MAX", 0, nil, nil, P7)
	CIfEnd()
	--P_3, 5 : 64
	--P_7, 3 : 71
	CIf(FP,GNm(2))
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, {"Kazansky","Raynor V"}, "ACAS", "Fac1", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {"Kazansky","Raynor V"}, "ACAS", "Fac2", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0)}, {55,53,54,46}, P_3, 5, "MAX", 0, nil, nil, P7)

	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,1)}, {"Kazansky","Raynor V"}, "ACAS", "Fac1", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2,AtLeast)}, {"Kazansky","Raynor V"}, "ACAS", "Fac2", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1)}, {56,53,51,48}, P_7, 3, "MAX", 0, nil, nil, P7)
	CIfEnd()
	--S_6, 2 : 73
	--P_5, 4 : 76
	CIf(FP,GNm(3))
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, {"Schezar","Hyperion"}, "ACAS", "Fac1", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {"Schezar","Hyperion"}, "ACAS", "Fac2", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0)}, {55,53,54,46}, S_6, 2, "MAX", 0, nil, nil, P7)

	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,1)}, {"Schezar","Hyperion"}, "ACAS", "Fac1", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2,AtLeast)}, {"Schezar","Hyperion"}, "ACAS", "Fac2", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1)}, {56,53,51,48}, P_5, 4, "MAX", 0, nil, nil, P7)
	CIfEnd()
	--P_4, 5 : 85
	--P_3, 6 : 85
	CIf(FP,GNm(4))
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, {"Fenix Z","Lin"}, "ACAS", "Fac1", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {"Fenix Z","Lin"}, "ACAS", "Fac2", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(5,Exactly,0)}, {55,53,54,46}, P_4, 5, "MAX", 0, nil, nil, P7)

	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,1)}, {"Fenix D","Lin"}, "ACAS", "Fac1", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2,AtLeast)}, {"Fenix D","Lin"}, "ACAS", "Fac2", "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(6,AtLeast,1)}, {56,53,51,48}, P_3, 6, "MAX", 0, nil, nil, P7)
	CIfEnd()
	CIfEnd()
	
	CIf_GCase(116)--퍼실
	CIfEnd()
	CIf_GCase(114)--스타포트
	CIfEnd()
	CIf_GCase(130)--감커
	G_CA_SetSpawn({}, {88}, {"ACAS"}, {"CenU"}, 1, 130, nil, {0,0}, P6,1)
	G_CA_SetSpawn({}, {88}, {"ACAS"}, {"CenD"}, 1, 130, nil, {0,0}, P6,1)
	G_CA_SetSpawn({}, {88}, {"ACAS"}, {"CenU2"}, 1, 130, nil, {0,0}, P6,1)
	G_CA_SetSpawn({}, {88}, {"ACAS"}, {"CenD2"}, 1, 130, nil, {0,0}, P6,1)
	CIfEnd()



	CIf_GCase(148)--옵마(Hypernaid)
		CIf(FP,GNm(1))
		
		CTrigger(FP,{Gun_Line(7,AtLeast,480)},{Gun_SetLine(6,Add,1),Gun_SetLine(7,SetTo,0),},1)

		G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, {21,17}, "ACAS", "Hy1LC_64", nil, 0, nil, nil, P7)
		G_CA_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {21,17}, "ACAS", "Hy1FP_64", nil, 0, nil, nil, P7)
		G_CA_SetSpawn({Gun_Line(5,Exactly,0)}, {55,53,54,46}, "ACAS", "Hy1FP_64", nil, 0, nil, nil, P7)

		CIf(FP,{Gun_Line(7,Exactly,0)})
		G_CA_SetSpawn({Gun_Line(6,Exactly,1),CD(GMode,1)}, {19,28}, "ACAS", "Hy1LC_64", nil, 0, nil, nil, P7)
		G_CA_SetSpawn({Gun_Line(6,Exactly,1),CD(GMode,2,AtLeast)}, {19,28}, "ACAS", "Hy1FP_64", nil, 0, nil, nil, P7)
		G_CA_SetSpawn({Gun_Line(6,Exactly,1)}, {56,53,51,48}, "ACAS", "Hy1FP_64", nil, 0, nil, nil, P7)
		
		G_CA_SetSpawn({Gun_Line(6,Exactly,2),CD(GMode,1)}, {88,77}, "ACAS", "Hy1LC_64", nil, 0, nil, nil, P7)
		G_CA_SetSpawn({Gun_Line(6,Exactly,2),CD(GMode,2,AtLeast)}, {88,77}, "ACAS", "Hy1FP_64", nil, 0, nil, nil, P7)
		G_CA_SetSpawn({Gun_Line(6,Exactly,2)}, {56,53,51,48}, "ACAS", "Hy1FP_64", nil, 0, nil, nil, P7)
		
		G_CA_SetSpawn({Gun_Line(6,Exactly,3),CD(GMode,1)}, {78,86}, "ACAS", "Hy1LC_64", nil, 0, nil, nil, P7)
		G_CA_SetSpawn({Gun_Line(6,Exactly,3),CD(GMode,2,AtLeast)}, {78,86}, "ACAS", "Hy1FP_64", nil, 0, nil, nil, P7)
		G_CA_SetSpawn({Gun_Line(6,Exactly,3)}, {56,53,51,48}, "ACAS", "Hy1FP_64", nil, 0, nil, nil, P7)
		CIfEnd()

		--21,17
		--19,28
		--88,77
		--78,86
		--Hy1LC_64
		--Hy1FP_64
		


		DoActionsX(FP,{Gun_SetLine(5,SetTo,1)})
		TriggerX(FP,{Gun_Line(6,AtLeast,3)},{SubCD(GunCcode,1)},{preserved})
		CTrigger(FP,{Gun_Line(6,AtLeast,3)},{Gun_DoSuspend()},1)
		CIfEnd()
	CIfEnd()
	

	
	
	if TestStart == 1 then
		--DisplayPrint(HumanPlayers, {"Executer",f_GunNum," : ",Var_TempTable[1]," ",Var_TempTable[2]," ",Var_TempTable[3]," ",Var_TempTable[4]," ",Var_TempTable[5]," ",Var_TempTable[6]," ",Var_TempTable[7]," ",Var_TempTable[8]," ",Var_TempTable[9]," ",Var_TempTable[10]})
	end
	
	CIf(FP,{
		TTOR({ -- 2젠 건작 목록
			Gun_Line(0,Exactly,131),
			Gun_Line(0,Exactly,132),
			Gun_Line(0,Exactly,133),
			Gun_Line(0,Exactly,122),
			Gun_Line(0,Exactly,113),
			Gun_Line(0,Exactly,114),
			Gun_Line(0,Exactly,160),
			Gun_Line(0,Exactly,167),
			Gun_Line(0,Exactly,154),
			Gun_Line(0,Exactly,116),
		}),
		Gun_Line(54,AtMost,0)},{Gun_SetLine(5,SetTo,1)})
			TriggerX(FP,{Gun_Line(6,AtLeast,1)},{SubCD(GunCcode,1)},{preserved})
		CTrigger(FP,{Gun_Line(6,AtLeast,1)},{Gun_DoSuspend()},1)
		CTrigger(FP,{Gun_Line(7,AtLeast,480)},{Gun_SetLine(6,SetTo,1)},1)
	CIfEnd()

	
	CTrigger(FP,{GNm(51,AtLeast)},{Gun_SetLine(54,SetTo,1),RotatePlayer({DisplayTextX(GunCaseErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)},1)

	CTrigger(FP,{CD(GunCaseCheck,0)},{Gun_SetLine(54,SetTo,1),RotatePlayer({DisplayTextX(GunCaseErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)},1)
	GunPushTrig = {}
	for i = 0, 54 do
		table.insert(GunPushTrig,TSetMemory(_Add(G_TempH,(i*0x20)/4),SetTo,Var_TempTable[i+1]))
	end
	CDoActions(FP,GunPushTrig)
	CIf(FP,{Gun_Line(54,AtLeast,1),}) -- SuspendCode
		CMov(FP,G_TempW,0)
		CWhile(FP,CVar(FP,G_TempW[2],AtMost,(Var_Lines-1)*(0x20/4)))
			CDoActions(FP,{TSetMemory(_Add(G_TempH,G_TempW),SetTo,0)})
			CAdd(FP,G_TempW,0x20/4)
		CWhileEnd()
		if Limit == 1 then
            DisplayPrint(HumanPlayers,{"『 \x03TESTMODE OP \x04: f_Gun Suspend 성공. f_Gun 실행자 : ",f_GunNum," \x07』"})
		end
	CIfEnd()

	
	SetCallEnd()
end