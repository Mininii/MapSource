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
	function CIf_GCase(Index)
		CIf(FP,{Gun_Line(0,Exactly,Index),Gun_Line(54,AtMost,0)},{SetCD(GunCaseCheck,1)})
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
	
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,4),Gun_Line(5,Exactly,0)},{55,53,54,48},"ACAS","Circle6_2",5,979,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,4),Gun_Line(6,AtLeast,1)},{104,56,53,54},"ACAS","Circle6_2",5,979,nil,"CP")

	
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,5),Gun_Line(5,Exactly,0)},{55,53,54,48},"ACAS","Polygon6_2",5,530,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,5),Gun_Line(6,AtLeast,1)},{104,56,53,54},"ACAS","Polygon6_2",5,530,nil,"CP")



	CIfEnd()
	CIf_GCase(132)
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,1),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Star2",1,964,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,1),Gun_Line(5,Exactly,0)},{77,77,77,77},"ACAS","Star3",1,547,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,1),Gun_Line(6,AtLeast,1)},{104,56,51,15},"ACAS","Star2",1,964,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,1),Gun_Line(6,AtLeast,1)},{78,78,78,78},"ACAS","Star3",1,547,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,2),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Star2",1,427,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,2),Gun_Line(5,Exactly,0)},{77,77,77,77},"ACAS","Star3",1,984,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,2),Gun_Line(6,AtLeast,1)},{104,56,51,15},"ACAS","Star2",1,427,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,2),Gun_Line(6,AtLeast,1)},{78,78,78,78},"ACAS","Star3",1,984,nil,"CP")

	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","SqKal1",1,391,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(5,Exactly,0)},{65,70,65,70},"ACAS","SqKal2",1,364,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(6,AtLeast,1)},{104,56,51,15},"ACAS","SqKal1",1,391,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(6,AtLeast,1)},{66,70,66,70},"ACAS","SqKal2",1,364,nil,"CP")

	
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,4),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Pol_6_1",1,524,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,4),Gun_Line(5,Exactly,0)},{61,61,98,98,98},"ACAS","Pol_6_2",1,548,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,4),Gun_Line(6,AtLeast,1)},{104,56,51,15},"ACAS","Pol_6_1",1,524,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,4),Gun_Line(6,AtLeast,1)},{67,67,98,98,98},"ACAS","Pol_6_2",1,548,nil,"CP")




	G_CA_SetSpawn2X({Gun_Line(3,Exactly,5),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Pol_4_1",1,441,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,5),Gun_Line(5,Exactly,0)},{81,29,29},"ACAS","Pol_4_2",1,503,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,5),Gun_Line(6,AtLeast,1)},{104,56,51,15},"ACAS","Pol_4_1",1,441,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,5),Gun_Line(6,AtLeast,1)},{23,29,29},"ACAS","Pol_4_2",1,503,nil,"CP")
	


	G_CA_SetSpawn2X({Gun_Line(3,Exactly,6),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Cir36_1",1,441,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,6),Gun_Line(5,Exactly,0)},{3,3,3,57,57,57},"ACAS","Cir36_2",1,503,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,6),Gun_Line(6,AtLeast,1)},{104,56,51,15},"ACAS","Cir36_1",1,441,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,6),Gun_Line(6,AtLeast,1)},{30,30,30,57,57,57},"ACAS","Cir36_2",1,503,nil,"CP")


	
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,7),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Star2",1,559,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,7),Gun_Line(5,Exactly,0)},{65,65,65,65,8},"ACAS","Star3",1,445,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,7),Gun_Line(6,AtLeast,1)},{104,56,51,15},"ACAS","Star2",1,559,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,7),Gun_Line(6,AtLeast,1)},{66,66,66,66,8},"ACAS","Star3",1,445,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,8),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Star2",1,559,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,8),Gun_Line(5,Exactly,0)},{65,65,65,65,8},"ACAS","Star3",1,445,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,8),Gun_Line(6,AtLeast,1)},{104,56,51,15},"ACAS","Star2",1,559,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,8),Gun_Line(6,AtLeast,1)},{66,66,66,66,8},"ACAS","Star3",1,445,nil,"CP")


	
	



	CIfEnd()
	CIf_GCase(133)
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,1),Gun_Line(5,Exactly,0)},{76},"ACAS","HCA",1,215,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,1),Gun_Line(6,AtLeast,1)},{63,28},"ACAS","HCA",1,60,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,2),Gun_Line(5,Exactly,0)},{17},"ACAS","CirAX",1,333,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,2),Gun_Line(6,AtLeast,1)},{19,86},"ACAS","CirAX",1,318,nil,"CP")

	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(5,Exactly,0)},{25},"ACAS","MinHive",1,398,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(6,AtLeast,1)},{25,100},"ACAS","MinHive",1,397,nil,"CP")
	for i = 4, 7 do
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(5,Exactly,0),Gun_Line(4,Exactly,i)},{27},"ACAS","MinHiveP"..i+1,1,983,nil,"CP",1)
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(6,AtLeast,1),Gun_Line(4,Exactly,i)},{102},"ACAS","MinHiveP"..i+1,1,984,nil,"CP",1)
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
	Tier3 = {27,66,29,98,57,3,8}
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