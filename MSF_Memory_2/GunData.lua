function Include_GunData(Size,LineNum)
	local G_TempV,G_A,GunID = CreateVariables(3,FP)
	local GunPlayer = CreateVar(FP)
	local CIndex = FuncAlloc
	f_GunSendT = CreateCText(FP,"\x07·\x11·\x08·\x07【 \x03TESTMODE OP \x04: f_GunSend 성공. f_Gun 실행자 : ")
	f_GunSendT2 = CreateCText(FP,"\x07·\x11·\x08·\x07【 \x03TESTMODE OP \x04: 성공한 f_GunSend의 EXCunit Number : ")
	G_A = CreateVar(FP)
	FuncAlloc = FuncAlloc + 1
	G_Send = SetCallForward()
	G_InputH = CreateVar(FP)
	f_GunStrPtr = CreateVar(FP)
	Actived_Gun = CreateVar(FP)
	f_GunNum = CreateVar(FP)
	G_TempH = CreateVar(FP)
	f_GunT = CreateCText(FP,"\x07·\x11·\x08·\x07【 \x03TESTMODE OP \x04: f_Gun Suspend 성공. f_Gun 실행자 : ")
	G_SendErrT = StrDesign("\x08ERROR : \x04f_Gun의 목록이 가득 차 G_Send를 실행할 수 없습니다! 스크린샷으로 제작자에게 제보해주세요!\x07")
	f_GunT2 = CreateCText(FP," \x07】\x08·\x11·\x07·")
	local f_GunNumT = CreateVArray(FP,5)
	Var_InputCVar = {}
	Var_Lines = LineNum
	Var_TempTable = CreateVarArr(Var_Lines,FP)
	f_GunSendStrPtr = CreateVar(FP)
	f_GunSendStrPtr2 = CreateVar(FP)
	
	function G_init()
		table.insert(CtrigInitArr[FP+1],SetCtrigX(FP,G_InputH[2],0x15C,0,SetTo,FP,CIndex,0x15C,1,0))--{"X",0x500,0x15C,1,0}--G_InputH
		f_GetStrXptr(FP,f_GunStrPtr,"\x0D\x0D\x0Df_Gun".._0D)
		f_GetStrXptr(FP,f_GunSendStrPtr,"\x0D\x0D\x0Df_GunSend".._0D)
		f_GetStrXptr(FP,f_GunSendStrPtr2,"\x0D\x0D\x0Df_GunSend2".._0D)
		f_Memcpy(FP,f_GunSendStrPtr,_TMem(Arr(f_GunSendT[3],0),"X","X",1),f_GunSendT[2])
		f_Memcpy(FP,f_GunSendStrPtr2,_TMem(Arr(f_GunSendT2[3],0),"X","X",1),f_GunSendT2[2])
		f_Memcpy(FP,f_GunStrPtr,_TMem(Arr(f_GunT[3],0),"X","X",1),f_GunT[2])
		f_Memcpy(FP,_Add(f_GunStrPtr,f_GunT[2]+16),_TMem(Arr(f_GunT2[3],0),"X","X",1),f_GunT2[2])
		f_Memcpy(FP,_Add(f_GunSendStrPtr,f_GunSendT[2]+16),_TMem(Arr(f_GunT2[3],0),"X","X",1),f_GunT2[2])
		f_Memcpy(FP,_Add(f_GunSendStrPtr2,f_GunSendT2[2]+16),_TMem(Arr(f_GunT2[3],0),"X","X",1),f_GunT2[2])
	end
	SetCall(FP)
		f_SaveCp()
		f_Read(FP,_Sub(BackupCp,15),CPos)
		f_Read(FP,BackupCp,GunID,"X",0xFF)
		f_Read(FP,_Sub(BackupCp,6),GunPlayer,"X",0xFF)
		function GunBGM(ID,Type)
			TriggerX(FP,{CV(GunID,ID),DeathsX(AllPlayers,Exactly,0,12,0xFFFFFF)},{SetV(BGMType,Type)})
		end
		GunBGM(131,3)
		GunBGM(132,4)
		GunBGM(133,5)
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
			TSetMemory(_Add(G_TempV,3*(0x20/4)),SetTo,DUnitCalc[4][1]),
			TSetMemory(_Add(G_TempV,4*(0x20/4)),SetTo,GunPlayer),
		})
		
		if Limit == 1 then
			CIf(FP,CD(TestMode,1))
			ItoDec(FP,G_A,VArr(f_GunNumT,0),2,0x1F,0)
			f_Movcpy(FP,_Add(f_GunSendStrPtr,f_GunSendT[2]),VArr(f_GunNumT,0),4*4)
			DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0Df_GunSend".._0D,4)},HumanPlayers,FP)})
			ItoDec(FP,DUnitCalc[4][1],VArr(f_GunNumT,0),2,0x1F,0)
			f_Movcpy(FP,_Add(f_GunSendStrPtr2,f_GunSendT2[2]),VArr(f_GunNumT,0),4*4)
			DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0Df_GunSend2".._0D,4)},HumanPlayers,FP)})
			CIfEnd()
		end
		CElseX()
		DoActions(FP,{RotatePlayer({DisplayTextX(G_SendErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
		CIfXEnd()
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
		return TSetMemoryX(_Add(G_TempH,(Line*0x20)/4),Type,Value,Mask)
	end

	function Gun_DoSuspend()
		return TSetMemory(_Add(G_TempH,(54*0x20)/4),Add,1)
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
	local GunCaseErrT = StrDesign("\x08ERROR : \x04등록되지 않은 건작이 작동하여 자동으로 Suspend하였습니다. 건작을 등록해주세요.\x07")
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

	Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3])
	CMov(FP,G_CA_CenterX,Var_TempTable[2])
	CMov(FP,G_CA_CenterY,Var_TempTable[3])
	CMov(FP,G_CA_Player,Var_TempTable[5])
	DoActionsX(FP,{SetSwitch(RandSwitch,Random),SetCD(GunCaseCheck,0)})
	CDoActions(FP,{Gun_SetLine(7,Add,1)})

	CIf_GCase(131)
	
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,1),Gun_Line(5,Exactly,0)},{55,53,54,48},"ACAS","Circle3",1,444,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,1),Gun_Line(6,AtLeast,1)},{104,56,53,54},"ACAS","Circle3",1,444,nil,"CP")

	G_CA_SetSpawn2X({Gun_Line(3,Exactly,2),Gun_Line(5,Exactly,0)},{55,53,54,48},"ACAS","Polygon6",1,10,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,2),Gun_Line(6,AtLeast,1)},{104,56,53,54},"ACAS","Polygon6",1,10,nil,"CP")

	
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(5,Exactly,0)},{55,53,54,48},"ACAS","Star6_2",5,4,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(6,AtLeast,1)},{104,56,53,54},"ACAS","Star6_2",5,4,nil,"CP")
	
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,4),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Circle6_2",5,979,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,4),Gun_Line(6,AtLeast,1)},{104,62,53,54},"ACAS","Circle6_2",5,979,nil,"CP")

	
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,5),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Polygon6_2",5,530,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,5),Gun_Line(6,AtLeast,1)},{104,62,53,54},"ACAS","Polygon6_2",5,530,nil,"CP")
	
	
	
	


	CIfEnd()
	CIf_GCase(132)
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,1),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Star2",1,964,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,1),Gun_Line(5,Exactly,0)},{77,77,77,77},"ACAS","Star3",1,547,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,1),Gun_Line(6,AtLeast,1)},{104,62,51,15},"ACAS","Star2",1,964,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,1),Gun_Line(6,AtLeast,1)},{78,78,78,78},"ACAS","Star3",1,547,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,2),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Star2",1,427,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,2),Gun_Line(5,Exactly,0)},{77,77,77,77},"ACAS","Star3",1,984,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,2),Gun_Line(6,AtLeast,1)},{104,62,51,15},"ACAS","Star2",1,427,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,2),Gun_Line(6,AtLeast,1)},{78,78,78,78},"ACAS","Star3",1,984,nil,"CP")

	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","SqKal1",1,391,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(5,Exactly,0)},{65,70,65,70},"ACAS","SqKal2",1,364,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(6,AtLeast,1)},{104,62,51,15},"ACAS","SqKal1",1,391,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(6,AtLeast,1)},{66,70,66,70},"ACAS","SqKal2",1,364,nil,"CP")

	
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,4),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Pol_6_1",1,524,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,4),Gun_Line(5,Exactly,0)},{61,61,98,98,98},"ACAS","Pol_6_2",1,548,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,4),Gun_Line(6,AtLeast,1)},{104,62,51,15},"ACAS","Pol_6_1",1,524,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,4),Gun_Line(6,AtLeast,1)},{67,67,98,98,98},"ACAS","Pol_6_2",1,548,nil,"CP")




	G_CA_SetSpawn2X({Gun_Line(3,Exactly,5),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Pol_4_1",1,441,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,5),Gun_Line(5,Exactly,0)},{81,29,29},"ACAS","Pol_4_2",1,503,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,5),Gun_Line(6,AtLeast,1)},{104,62,51,15},"ACAS","Pol_4_1",1,441,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,5),Gun_Line(6,AtLeast,1)},{23,29,29},"ACAS","Pol_4_2",1,503,nil,"CP")
	


	G_CA_SetSpawn2X({Gun_Line(3,Exactly,6),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Cir36_1",1,441,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,6),Gun_Line(5,Exactly,0)},{3,3,3,57,57,57},"ACAS","Cir36_2",1,503,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,6),Gun_Line(6,AtLeast,1)},{104,62,51,15},"ACAS","Cir36_1",1,441,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,6),Gun_Line(6,AtLeast,1)},{30,30,30,57,57,57},"ACAS","Cir36_2",1,503,nil,"CP")


	
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,7),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Spi2",1,559,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,7),Gun_Line(5,Exactly,0)},{65,65,65,65,8},"ACAS","Spi3",1,445,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,7),Gun_Line(6,AtLeast,1)},{104,62,51,15},"ACAS","Spi2",1,559,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,7),Gun_Line(6,AtLeast,1)},{66,66,66,66,8},"ACAS","Spi3",1,445,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,8),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Tor2",1,559,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,8),Gun_Line(5,Exactly,0)},{65,65,65,65,8},"ACAS","Tor3",1,445,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,8),Gun_Line(6,AtLeast,1)},{104,62,51,15},"ACAS","Tor2",1,559,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,8),Gun_Line(6,AtLeast,1)},{66,66,66,66,8},"ACAS","Tor3",1,445,nil,"CP")


	
	



	CIfEnd()
	CIf_GCase(133)
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,1),Gun_Line(5,Exactly,0)},{76},"ACAS","HCA",1,215,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,1),Gun_Line(6,AtLeast,1)},{63,28},"ACAS","HCA",1,60,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,2),Gun_Line(5,Exactly,0)},{17},"ACAS","CirAX",1,333,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,2),Gun_Line(6,AtLeast,1)},{19,86},"ACAS","CirAX",1,318,nil,"CP")

	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(5,Exactly,0)},{25},"ACAS","MinHive",1,398,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(6,AtLeast,1)},{25,100},"ACAS","MinHive",1,397,nil,"CP")
	for i = 4, 7 do
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(5,Exactly,0),GCP(i)},{27},"ACAS","MinHiveP"..i+1,1,983,nil,"CP",1)
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(6,AtLeast,1),GCP(i)},{102},"ACAS","MinHiveP"..i+1,1,984,nil,"CP",1)
	end
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,4),Gun_Line(5,Exactly,0)},{52},"ACAS","Sp1",1,389,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,4),Gun_Line(6,AtLeast,1)},{10,22},"ACAS","Sp1",1,474,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,5),Gun_Line(5,Exactly,0)},{75},"ACAS","Tornado",1,974,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,5),Gun_Line(6,AtLeast,1)},{79,80},"ACAS","Tornado",1,545,nil,"CP")
	CIfEnd()
	CIf(FP,{Gun_Line(0,AtLeast,131),Gun_Line(0,AtMost,133)},{Gun_SetLine(5,SetTo,1)})
		CTrigger(FP,{Gun_Line(6,AtLeast,1)},{Gun_DoSuspend()},1)
		CTrigger(FP,{TGun_Line(7,AtLeast,RedNumber)},{Gun_SetLine(6,SetTo,1)},1)
	CIfEnd()

	
	CIf_GCase(154)
		for i = 5, 8 do
			G_CA_SetSpawn2X({Gun_Line(4,Exactly,i-1)},{21},"ACAS","NexP"..i,"MAX",429,nil,"CP",nil,nil,1)
			G_CA_SetSpawn2X({Gun_Line(4,Exactly,i-1),Gun_Line(6,Exactly,1)},{88},"ACAS","NexP"..i,"MAX",424,nil,"CP",nil,nil,1)
			G_CA_SetSpawn2X({Gun_Line(4,Exactly,i-1),Gun_Line(6,Exactly,2)},{86},"ACAS","NexP"..i,"MAX",427,nil,"CP",nil,nil,1)
			G_CA_SetSpawn2X({Gun_Line(4,Exactly,i-1),Gun_Line(6,Exactly,3)},{22},"ACAS","NexP"..i,"MAX",337,nil,"CP",nil,nil,1)
			G_CA_SetSpawn2X({Gun_Line(4,Exactly,i-1),Gun_Line(6,Exactly,4)},{80},"ACAS","NexP"..i,"MAX",951,nil,"CP",nil,nil,1)
			G_CA_SetSpawn2X({Gun_Line(4,Exactly,i-1),Gun_Line(6,Exactly,5)},{98},"ACAS","NexP"..i,"MAX",549,nil,"CP",nil,nil,1)
		end
		CTrigger(FP,{TGun_Line(7,AtLeast,RedNumber)},{Gun_SetLine(6,Add,1),Gun_SetLine(7,SetTo,0)},1)
		CTrigger(FP,{Gun_Line(6,AtLeast,5)},{Gun_DoSuspend()},1)
	CIfEnd()
	UID1I = 221
	UID2I = 222
	UID3I = 223
	UID4I = 224
	Tier1 = {17,19,77,78,76,63,21,88,28,86,75,25}
	Tier2 = {79,80,52,10,22,65,70}
	Tier3 = {27,66,29,98,57,3,8,11,69}
	Tier4 = {102,61,67,23,81,30}
	Tier5 = {60,68}
	Tier1VA = CreateVArr(#Tier1,FP)
	Tier2VA = CreateVArr(#Tier2,FP)
	Tier3VA = CreateVArr(#Tier3,FP)
	Tier4VA = CreateVArr(#Tier4,FP)
	Tier5VA = CreateVArr(#Tier5,FP)
	TierInitT = {Tier1VA,Tier2VA,Tier3VA,Tier4VA,Tier5VA}
	TierInitT2 = {Tier1,Tier2,Tier3,Tier4,Tier5}
	for l,m in pairs(TierInitT2) do
		for j, k in pairs(m) do
			table.insert(CtrigInitArr[8],SetVArrayX(VArr(TierInitT[l],j-1),"Value",SetTo,k))
		end
	end

	WV = CreateVar(FP)
	CIf_GCase(148)
		CTrigger(FP,{Gun_Line(10,AtMost,0)},{Gun_SetLine(7,SetTo,50),Gun_SetLine(10,SetTo,1)},1)

		CIf(FP,{Gun_Line(7,AtLeast,35)},{Gun_SetLine(6,Add,1),Gun_SetLine(7,SetTo,0)})
		DoActionsX(FP,{SetV(WV,0)})
		CWhile(FP,{CV(WV,4,AtMost)},{AddV(WV,1)}) -- 티어1
			CMov(FP,UnitIDV1,VArr(Tier1VA,f_CRandNum(#Tier1,0)))
			G_CA_SetSpawn2X({},{UID1I},"ACAS","Point","MAX",233,nil,"CP",2,nil)
		CWhileEnd()
		DoActionsX(FP,{SetV(WV,0)})
		CWhile(FP,{CV(WV,2,AtMost)},{AddV(WV,1)}) -- 티어2
			CMov(FP,UnitIDV1,VArr(Tier2VA,f_CRandNum(#Tier2,0)))
			G_CA_SetSpawn2X({},{UID1I},"ACAS","Point","MAX",545,nil,"CP",2,nil)
		CWhileEnd()
		CMov(FP,UnitIDV1,VArr(Tier3VA,f_CRandNum(#Tier3,0))) -- 티어3
		G_CA_SetSpawn2X({},{UID1I},"ACAS","Point","MAX",211,nil,"CP",2,nil)
		CIfEnd()
		CIf(FP,{Gun_Line(6,AtLeast,5)},{Gun_SetLine(8,Add,1),Gun_SetLine(6,SetTo,0)})
		CMov(FP,UnitIDV1,VArr(Tier4VA,f_CRandNum(#Tier4,0))) -- 티어3
		G_CA_SetSpawn2X({},{UID1I},"ACAS","Point","MAX",548,nil,"CP",2,nil)

		CIfEnd()
		CIf(FP,{Gun_Line(8,AtLeast,2)},{Gun_SetLine(9,Add,1),Gun_SetLine(8,SetTo,0)})
		CMov(FP,UnitIDV1,VArr(Tier5VA,f_CRandNum(#Tier5,0))) -- 티어3
		
		G_CA_SetSpawn2X({},{UID1I},"ACAS","Point","MAX",984,nil,"CP",2,nil)

		CIfEnd()
	CTrigger(FP,{Gun_Line(9,AtLeast,5)},{Gun_DoSuspend()},1)
	
	CIfEnd()

	CIf_GCase(174)
	TempleXY = {
		{1024,1024},
		{1024*3,1024},
		{1024,1024*3},
		{1024*3,1024*3},
	}
	TempleCUT = {55,56,62,21,88,28,80,22,70,27,8,98,57}
	EffShape1 = CSMakeCircle(90,960,0,91,1)
	EffShape2 = CSMakeLine(1,96,0,11,0)
	for i = 4, 7 do
		TriggerX(FP,{GCP(i),Gun_Line(9,AtLeast,13)},{Order("Men",i,64,Attack,11+i-4)},{Preserved})
	TriggerX(FP,{GCP(i)},{SetV(G_CA_CenterX,TempleXY[i-3][1]),SetV(G_CA_CenterY,TempleXY[i-3][2])},{Preserved})
	CSPlot(EffShape1,i,84,0,{TempleXY[i-3][1],TempleXY[i-3][2]},1,32,FP,{Label(),GCP(i),Gun_Line(20,AtMost,0)},nil,1)
	for j = 0, 12 do
	local cond = {Label(),GCP(i),Gun_Line(8,AtLeast,1000),Gun_Line(9,Exactly,j-1)}
	if j == 0 then cond = {Label(),GCP(i),Gun_Line(7,Exactly,0)} end
	CSPlot(CS_Rotate(EffShape2,(j*30)),i,84,0,{TempleXY[i-3][1],TempleXY[i-3][2]},1,32,FP,cond,nil,nil)
	end
	end
	CTrigger(FP,{Gun_Line(20,AtMost,0)},{Gun_SetLine(20,SetTo,1)},1)
	
	
	for i = 0, 12 do
		local cond = {Gun_Line(8,AtLeast,1000),Gun_Line(9,Exactly,i-1)}
		if i == 0 then cond = {Gun_Line(7,Exactly,0)} end
	G_CA_SetSpawn(cond,{TempleCUT[i+1]},"ACAS","TempleG",1,4,nil,"CP",G_CA_Rotate(270+(i*30)))

	end

	CDoActions(FP,{Gun_SetLine(8,Add,Dt)})
	CTrigger(FP,{Gun_Line(8,AtLeast,1000)},{Gun_SetLine(9,Add,1),Gun_SetLine(20,SetTo,0),Gun_SetLine(8,Subtract,1000),RotatePlayer({PlayWAVX("staredit\\wav\\Clock.ogg"),PlayWAVX("staredit\\wav\\Clock.ogg")},HumanPlayers,FP)},1)
	CTrigger(FP,{Gun_Line(9,AtLeast,13)},{Gun_DoSuspend()},1)
	CIfEnd()
	CIf_GCase(147)
	CTrigger(FP,{Gun_Line(7,AtLeast,(#OvG-1)*5)},{Gun_SetLine(6,Add,1),Gun_SetLine(7,SetTo,0)},{Preserved})
	OvGCUT = {11,29,69,102}
	for i = 0, 3 do
		local cond = {Gun_Line(7,AtLeast,(#OvG-1)*5),Gun_Line(6,Exactly,i-1)}
		if i == 0 then cond = {Gun_Line(7,Exactly,0),Gun_Line(6,Exactly,0)} end
	G_CA_SetSpawn(cond,{OvGCUT[i+1]},"ACAS","OvG"..i+1,1,3,nil,"CP",G_CA_LoopTimer(5))
	end
	CTrigger(FP,{Gun_Line(6,AtLeast,4)},{Gun_DoSuspend()},1)
	CIfEnd()


	CIf_GCase(151)
		DoActions2(FP,{Simple_CalcLoc(0,-256,-256,256,256)})
		CDoActions(FP,{Gun_SetLine(8,SetTo,1),TCreateUnit(1,84,1,G_CA_Player)})
		CereT = {80,8}
		for j = 1, 2 do
		for i = 0, 7 do
		local cond = {Gun_Line(3,Exactly,j),Gun_Line(6,Exactly,i),Gun_Line(9,AtLeast,1)}
		if i == 0 then cond = {Gun_Line(3,Exactly,j),Gun_Line(8,AtMost,0)} end
			G_CA_SetSpawn(cond,{CereT[j]},"ACAS","Cere1","MAX",0,nil,"CP",G_CA_Rotate(270+(i*45)))
		end
		end
		for i = 0, 3 do
			TriggerX(FP,{GCP(i+4),Gun_Line(6,AtLeast,8)},{AddCD(CereCond[i+1],1)},{Preserved})
		end
	--Gun_Line(3,Exactly,1),
		CTrigger(FP,{TGun_Line(7,AtLeast,RedNumber)},{Gun_SetLine(6,Add,1),Gun_SetLine(7,SetTo,0),Gun_SetLine(9,Add,1)},1)
		CTrigger(FP,{Gun_Line(9,AtLeast,1)},{Gun_SetLine(9,SetTo,0)},1)
		CTrigger(FP,{Gun_Line(6,AtLeast,8)},{TSetMemory(0x6509B0,SetTo,G_CA_Player),RunAIScriptAt(JYD,1),Gun_DoSuspend()},1)

	CIfEnd()

--	Tier1 = {17,19,77,78,76,63,21,88,28,86,75,25}
--	Tier2 = {79,80,52,10,22,65,70}
--	Tier3 = {27,66,29,98,57,3,8,11,69}
--	Tier4 = {102,61,67,23,81,30}
--	Tier5 = {60,68}
	CIf_GCase(127)
	CDoActions(FP,{Gun_SetLine(8,SetTo,1)})
	Ion_CUTable1={{23,69,11},{81,30},{67,102},{60,68}}
	Ion_CUTable2={{21},{28},{22},{8}}
	Ion_CUTable3={{55,53,54,48,17},{104,56,53,54,19},{56,53,54,48,10},{104,62,51,15,3}}
	for j = 1, 4 do
	for i = 0, 3 do
	local cond = {GCP(j+3),Gun_Line(6,Exactly,i),Gun_Line(9,AtLeast,1)}
	if i == 0 then cond = {GCP(j+3),Gun_Line(8,AtMost,0)} end
--	if j == 2 then PushErrorMsg(table.concat(Ion_CUTable3[i+1])) end
		G_CA_SetSpawn2X(cond,Ion_CUTable3[i+1],"ACAS","ion2_P"..j+4,"MAX",974,nil,"CP")
		G_CA_SetSpawn(cond,Ion_CUTable1[i+1],"ACAS","ion1_P"..j+4,1,0,nil,"CP")
		G_CA_SetSpawn(cond,Ion_CUTable2[i+1],"ACAS","ion3_P"..j+4,nil,0,nil,"CP")
	end
	end
	CTrigger(FP,{TGun_Line(7,AtLeast,RedNumber)},{Gun_SetLine(6,Add,1),Gun_SetLine(7,SetTo,0),Gun_SetLine(9,Add,1)},1)
	CTrigger(FP,{Gun_Line(9,AtLeast,1)},{Gun_SetLine(9,SetTo,0)},1)
	CTrigger(FP,{Gun_Line(6,AtLeast,3)},{Gun_DoSuspend()},1)
	CIfEnd()
	CIf_GCase(126)
	CDoActions(FP,{Gun_SetLine(8,SetTo,1)})
	--	Tier1 = {17,19,77,78,76,63,21,88,28,86,75,25}
	--	Tier2 = {79,80,52,10,22,65,70}
	--	Tier3 = {27,66,29,98,57,3,8,11,69}
	--	Tier4 = {102,61,67,23,81,30}
	--	Tier5 = {60,68}
	Norad_CUTable1={{23,69,11},{81,30},{67,102},{60,68}}
	Norad_CUTable2={{88},{80},{57},{98}}
	Norad_CUTable3={{55,53,54,48,77},{104,56,53,54,78},{56,53,54,48,66},{104,62,51,15,52}}
	for j = 1, 4 do
	for i = 0, 3 do
	local cond = {GCP(j+3),Gun_Line(6,Exactly,i),Gun_Line(9,AtLeast,1)}
	if i == 0 then cond = {GCP(j+3),Gun_Line(8,AtMost,0)} end
--	if j == 2 then PushErrorMsg(table.concat(Ion_CUTable3[i+1])) end
		G_CA_SetSpawn2X(cond,Norad_CUTable3[i+1],"ACAS","norad2_P"..j+4,"MAX",974,nil,"CP")
		G_CA_SetSpawn(cond,Norad_CUTable1[i+1],"ACAS","norad1_P"..j+4,1,0,nil,"CP")
		G_CA_SetSpawn(cond,Norad_CUTable2[i+1],"ACAS","norad3_P"..j+4,nil,0,nil,"CP")
	end
	end
	CTrigger(FP,{TGun_Line(7,AtLeast,RedNumber)},{Gun_SetLine(6,Add,1),Gun_SetLine(7,SetTo,0),Gun_SetLine(9,Add,1)},1)
	CTrigger(FP,{Gun_Line(9,AtLeast,1)},{Gun_SetLine(9,SetTo,0)},1)
	CTrigger(FP,{Gun_Line(6,AtLeast,3)},{Gun_DoSuspend()},1)
	CIfEnd()

	
	CIf(FP,{TTOR({Gun_Line(0,Exactly,200),Gun_Line(0,Exactly,152)})}) -- CXPlot DataInput
	CDoActions(FP,{
		Gun_SetLine(11,Add,11); --SetCVar("X",XAngle,Add,11);
		Gun_SetLine(12,Add,8); --SetCVar("X",YAngle,Add,8);
		Gun_SetLine(13,Add,5); --SetCVar("X",ZAngle,Add,5);
	})
	CTrigger(FP,{
		Gun_Line(14,Exactly,0) --CVar("X",Move1,Exactly,0);
	},{
		Gun_SetLine(15,Add,1); -- SetCVar("X",Move2,Add,1);
	},{Preserved})
	CTrigger(FP,{
		Gun_Line(14,Exactly,1) --CVar("X",Move1,Exactly,1);
	},{
		Gun_SetLine(15,Subtract,9); -- SetCVar("X",Move2,Subtract,9);
	},{Preserved})
	CTrigger(FP,{
		Gun_Line(14,Exactly,1); --CVar("X",Move1,Exactly,1);
		Gun_Line(15,Exactly,0); --CVar("X",Move2,Exactly,0);
	},{
		Gun_SetLine(14,SetTo,0); -- SetCVar("X",Move1,SetTo,0);
	},{Preserved})
	CTrigger(FP,{
		Gun_Line(14,Exactly,0); --CVar("X",Move1,Exactly,0);
		Gun_Line(15,AtLeast,1280); --CVar("X",Move2,AtLeast,1280);
	},{
		Gun_SetLine(14,SetTo,1); -- SetCVar("X",Move1,SetTo,1);
	},{Preserved})
	CMov(FP,V(TSize),Var_TempTable[10+1])
	CMov(FP,V(XAngle),Var_TempTable[11+1])
	CMov(FP,V(YAngle),Var_TempTable[12+1])
	CMov(FP,V(ZAngle),Var_TempTable[13+1])
	CMov(FP,V(Move1),Var_TempTable[14+1])
	CMov(FP,V(Move2),Var_TempTable[15+1])
	CMov(FP,SHLX,G_CA_CenterX)
	CMov(FP,SHLY,G_CA_CenterY)
	CIfEnd()
	CIf_GCase(200)
	
	
	CTrigger(FP,{
		Gun_Line(7,AtMost,0)},{
		Gun_SetLine(10,SetTo,540); -- SetCVar("X",TSize,SetTo,540);
		SetCD(GeneT,0),RotatePlayer({PlayWAVX("sound\\Terran\\Frigate\\AfterOff.wav"),PlayWAVX("sound\\Terran\\Frigate\\AfterOff.wav"),PlayWAVX("sound\\Terran\\Frigate\\AfterOff.wav"),PlayWAVX("sound\\Terran\\Frigate\\AfterOff.wav")},HumanPlayers,FP);
		SetInvincibility(Enable,"Men",Force2,64);
	},{Preserved})
	CTrigger(FP,{CD(GeneT,29999,AtMost),
		Gun_Line(10,AtMost,540*3*6) --CVar(FP,TSize,AtMost,540*3*6)
	},{
		Gun_SetLine(10,Add,540/4); -- SetCVar("X",TSize,Add,540/4);
	},{Preserved})
	
	
	CallTrigger(FP,CallCXPlot,{SetCD(CXEffType,0)})
	CTrigger(FP,{CD(GeneT,30000,AtLeast)},{Gun_SetLine(10,Subtract,540/6)},1)
	CTrigger(FP,{CD(GeneT,30000,AtLeast),Gun_Line(10,AtMost,0)},{Gun_DoSuspend(),SetInvincibility(Disable,"Men",Force2,64),RotatePlayer({PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav")},HumanPlayers,FP);},1)

	
	CIfEnd()

	CIf_GCase(152)
		TriggerX(FP,{Gun_Line(7,AtMost,340)},{CreateUnit(1,84,1,FP)},{Preserved})
		CIf(FP,{Gun_Line(7,AtLeast,241),Gun_Line(7,AtLeast,240)},{Gun_SetLine(10,Add,540/2)})
		CTrigger(FP,{GCP(6)},{Gun_SetLine(1,Add,12)},{Preserved})
		CTrigger(FP,{GCP(7),Gun_Line(7,AtLeast,241),Gun_Line(7,AtLeast,240)},{Gun_SetLine(1,Subtract,12)},{Preserved})
		CallTrigger(FP,CallCXPlot,{SetCD(CXEffType,0)})
		CIfEnd()
		CIf(FP,{Gun_Line(7,AtLeast,290)},{Gun_DoSuspend()})
			CallTriggerX(FP,CallCXPlot,{GCP(6)},{SetCD(CXEffType,1)})
			CallTriggerX(FP,CallCXPlot,{GCP(7)},{SetCD(CXEffType,2)})
		CIfEnd()
		
	CIfEnd()

	CIf_GCase(130)
	CenterPtr1 = CreateArr(360,FP)
	CenterPtr2 = CreateArr(360,FP)
	CenterPtr3 = CreateArr(360,FP)
	CenterPtr4 = CreateArr(360,FP)
	CenterUIDV = CreateVar(FP)
	C_ArrConv = CreateVar(FP)
	CenterPtrs = CreateVar(FP)
	TempPos = CreateVar(FP)
	C_W = CreateVar(FP)
	C_FS = CreateVar(FP)
	C_FS2 = CreateVar(FP)
	CenterCUT = {88,21,86,28}
	N_X,N_Y,L_X,L_Y,C_A = CreateVars(5,FP)
		
	CIf(FP,{Gun_Line(8,AtMost,359)})
		CIf(FP,{Memory(0x628438,AtLeast,1)})
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
				ConvertArr(FP,C_ArrConv,Var_TempTable[9])
				for i = 0, 3 do
					CIf(FP,GCP(i+4),{SetV(C_A,(i*90)),SetV(CenterUIDV,CenterCUT[i+1])})
					CMovX(FP,Arr(_G["CenterPtr"..i+1],C_ArrConv),Nextptrs)
					CIfEnd()
				end

			f_Lengthdir(FP,2000,_Add(C_A,Var_TempTable[9]),L_X,L_Y)
			Simple_SetLocX(FP,0,_Add(L_X,2048-32),_Add(L_Y,2048-32),_Add(L_X,2048+32),_Add(L_Y,2048+32))
			CDoActions(FP,{
				TCreateUnitWithProperties(1,CenterUIDV,1,G_CA_Player,{invincible = true});
				TSetDeathsX(_Add(Nextptrs,72),SetTo,0xFF*256,0,0xFF00),
				TSetDeaths(_Add(Nextptrs,13),SetTo,1,0),
				TSetDeathsX(_Add(Nextptrs,18),SetTo,1,0,0xFFFF),
				Gun_SetLine(8,Add,1)})
			f_Read(FP,_Add(Nextptrs,10),CPos)
			Convert_CPosXY()
				Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
				DoActions(FP,{
					Order("Men",Force2,1,Move,64);})
		CIfEnd()
	CIfEnd()
	CIf(FP,{TTOR({Gun_Line(8,Exactly,360),TTAND({Gun_Line(8,AtLeast,361),Gun_Line(7,Exactly,500)})})},{Gun_SetLine(8,SetTo,361),Gun_SetLine(7,SetTo,0)})
			
			CMov(FP,C_FS,1)
			CMov(FP,C_W,0)
			CWhile(FP,{CV(C_W,359,AtMost)})
			ConvertArr(FP,C_ArrConv,C_W)
			for i = 0, 3 do
				CIf(FP,GCP(i+4),{SetV(C_FS2,60+(i*15))})
				CMov(FP,CenterPtrs,_Read(Arr(_G["CenterPtr"..i+1],C_ArrConv)))
				CIfEnd()
			end
			CIf(FP,CVar(FP,CenterPtrs[2],AtLeast,1))
				CIfX(FP,{Gun_Line(8,Exactly,360)})
					CAdd(FP,C_FS,C_FS2)
					f_Lengthdir(FP,2000,_Add(_Add(C_A,C_W),150),N_X,N_Y)
					CAdd(FP,TempPos,_Add(N_X,2048),_Mul(_Add(N_Y,2048),65536))
					CDoActions(FP,{
						TSetDeaths(_Add(CenterPtrs,23),SetTo,0,0),
						TSetDeaths(_Add(CenterPtrs,6),SetTo,TempPos,0),
						TSetDeaths(_Add(CenterPtrs,4),SetTo,TempPos,0),
						TSetDeaths(_Add(CenterPtrs,22),SetTo,TempPos,0),
						TSetDeaths(_Add(CenterPtrs,13),SetTo,C_FS,0),
						TSetDeathsX(_Add(CenterPtrs,18),SetTo,C_FS,0,0xFFFF),
						TSetDeathsX(_Add(CenterPtrs,19),SetTo,6*256,0,0xFF00),
						})
				TriggerX(FP,{CV(C_FS,2000,AtLeast)},{SetV(C_FS,1)},{Preserved})
				CElseX()
				f_Read(FP,_Add(CenterPtrs,10),TempPos)
				CDoActions(FP,{
					TSetDeathsX(_Add(CenterPtrs,72),SetTo,0,0,0xFF00),
					TSetDeathsX(_Add(CenterPtrs,55),SetTo,0,0,0x04000000),
					TSetDeaths(_Add(CenterPtrs,23),SetTo,0,0),
					TSetDeathsX(_Add(CenterPtrs,19),SetTo,187*256,0,0xFF00),
					TSetDeaths(_Add(CenterPtrs,6),SetTo,TempPos,0),
					TSetDeaths(_Add(CenterPtrs,22),SetTo,TempPos,0),
					TSetDeaths(_Add(CenterPtrs,4),SetTo,TempPos,0)
				})
				CIfXEnd()
			CIfEnd()
				DoActionsX(FP,{AddV(C_W,1)})
			CWhileEnd()
			CTrigger(FP,{Gun_Line(8,AtLeast,361),Gun_Line(7,Exactly,500)},{Gun_DoSuspend()},1)
	CIfEnd()



	CIfEnd()



	CTrigger(FP,{CD(GunCaseCheck,0),Gun_Line(54,AtMost,0)},{Gun_SetLine(54,SetTo,1),RotatePlayer({DisplayTextX(GunCaseErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)},1)
	CIf(FP,{Gun_Line(54,AtLeast,1),}) -- SuspendCode
		CMov(FP,G_TempW,0)
		CWhile(FP,CVar(FP,G_TempW[2],AtMost,(Var_Lines-1)*(0x20/4)))
			CDoActions(FP,{TSetMemory(_Add(G_TempH,G_TempW),SetTo,0)})
			CAdd(FP,G_TempW,0x20/4)
		CWhileEnd()
		if Limit == 1 then
			CIf(FP,CD(TestMode,1))
			ItoDec(FP,f_GunNum,VArr(f_GunNumT,0),2,0x1F,0)
			f_Movcpy(FP,_Add(f_GunStrPtr,f_GunT[2]),VArr(f_GunNumT,0),4*4)
			DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0Df_Gun".._0D,4)},HumanPlayers,FP)})
			CIfEnd()
		end
	CIfEnd()

	
	SetCallEnd()
end