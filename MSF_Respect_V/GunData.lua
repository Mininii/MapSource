
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
		GunBGM(132,3,"\x1FO\x04nly \x1FFor \x1FY\x04ou",50000)
		GunBGM(133,4,"\x11K\x04amui",50000)
		--GunBGM(175,5,"\x04쥬림 \x11무너진 \x07신전 \x04을",300000)
		--GunBGM(127,5,"\x07쥬림 \x06산맥의 \x11결계 \x04를",500000)
		--GunBGM(109,6,"보급고 \x18Supply Depot \x04을",100000)
		--GunBGM(156,6,"수정탑 \x18Pylon \x04을",100000)
		--GunBGM(154,nil,"연결체 \x18Nexus \x04를",150000,{SetCD(NosBGM,1)})
		--GunBGM(116,7,"연구소 \x18Facility \x04을",30000)
		--GunBGM(150,7,"번데기 \x18Mature Crysalis \x04을",30000)
		--GunBGM(151,4,"정신체 \x18Cerebrate \x04을",60000)
		--GunBGM(130,4,"감염체 \x18Center \x04를",60000)
		--GunBGM(201,8,"정신체 \x18Cocoon \x04을",150000)
		--GunBGM(200,8,"발전소 \x18Generator \x04를",250000)
		--GunBGM(147,8,"완전체 \x18Overmind G \x04를",400000)
		--GunBGM(148,8,"초월체 \x18Overmind \x04를",100000)
		--GunBGM(173,8,"수정 집합체 \x18Formation \x04을",100000)
		--GunBGM(190,8,"교란기 \x18Psi Disrupter \x04를",300000)
		--GunBGM(168,nil,"봉인 \x18Stasis Cell \x04을",50000)
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
	f_GunTable = {}
	function CIf_GCase(Index)
		CIf(FP,{Gun_Line(0,Exactly,Index),Gun_Line(54,AtMost,0)},{SetCD(GunCaseCheck,1)})
		table.insert(f_GunTable,Index)
	end
	function GCP(Value,Type)
		if Type==nil then Type = Exactly end
		return Gun_Line(4,Type,Value)
	end
	SetCall(FP)
	CMov(FP,G_CA_X,Var_TempTable[2])
	CMov(FP,G_CA_Y,Var_TempTable[3])
	Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3])
	DoActionsX(FP,{SetSwitch(RandSwitch1,Random),SetSwitch(RandSwitch2,Random),SetCD(GunCaseCheck,0)})
	CDoActions(FP,{Gun_SetLine(7,Add,1)})
	
	CIf_GCase(131)--해처리
	G_CA_SetSpawn({Gun_Line(3,Exactly,1),Gun_Line(5,Exactly,0)}, {43,37,38,39}, P_5, 2, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(3,Exactly,1),Gun_Line(6,AtLeast,1)}, {44,46,38,39}, P_5, 2, "MAX", 0, nil, nil, P7)
	
	G_CA_SetSpawn({Gun_Line(3,Exactly,2),Gun_Line(5,Exactly,0)}, {43,37,38,39}, P_4, 3, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(3,Exactly,2),Gun_Line(6,AtLeast,1)}, {44,46,38,39}, P_4, 3, "MAX", 0, nil, nil, P7)
	
	G_CA_SetSpawn({Gun_Line(3,Exactly,3),Gun_Line(5,Exactly,0)}, {43,37,38,39}, P_3, 4, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(3,Exactly,3),Gun_Line(6,AtLeast,1)}, {44,46,38,39}, P_3, 4, "MAX", 0, nil, nil, P7)
	
	G_CA_SetSpawn({Gun_Line(3,Exactly,4),Gun_Line(5,Exactly,0)}, {43,37,38,39}, S_5, 1, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(3,Exactly,4),Gun_Line(6,AtLeast,1)}, {44,46,38,39}, S_5, 1, "MAX", 0, nil, nil, P7)
	
	G_CA_SetSpawn({Gun_Line(3,Exactly,5),Gun_Line(5,Exactly,0)}, {43,37,38,39}, S_4, 1, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(3,Exactly,5),Gun_Line(6,AtLeast,1)}, {44,46,38,39}, S_4, 1, "MAX", 0, nil, nil, P7)

	CIfEnd()
	CIf_GCase(132)--레어
	G_CA_SetSpawn({Gun_Line(3,Exactly,1),Gun_Line(5,Exactly,0)}, {55,53,54,46}, S_5, 1, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(3,Exactly,1),Gun_Line(6,AtLeast,1)}, {56,53,51,48}, S_5, 1, "MAX", 0, nil, nil, P7)
	
	G_CA_SetSpawn({Gun_Line(3,Exactly,2),Gun_Line(5,Exactly,0)}, {55,53,54,46}, P_6, 3, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(3,Exactly,2),Gun_Line(6,AtLeast,1)}, {56,53,51,48}, P_6, 3, "MAX", 0, nil, nil, P7)
	
	G_CA_SetSpawn({Gun_Line(3,Exactly,3),Gun_Line(5,Exactly,0)}, {55,53,54,46}, S_3, 2, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(3,Exactly,3),Gun_Line(6,AtLeast,1)}, {56,53,51,48}, S_3, 2, "MAX", 0, nil, nil, P7)
	
	G_CA_SetSpawn({Gun_Line(3,Exactly,4),Gun_Line(5,Exactly,0)}, {55,53,54,46}, P_8, 2, "MAX", 0, nil, nil, P7)
	G_CA_SetSpawn({Gun_Line(3,Exactly,4),Gun_Line(6,AtLeast,1)}, {56,53,51,48}, P_8, 2, "MAX", 0, nil, nil, P7)

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
		CTrigger(FP,{TGun_Line(7,AtLeast,360)},{Gun_SetLine(6,SetTo,1)},1)
	CIfEnd()


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