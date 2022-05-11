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
		f_Read(FP,BackupCp,GunID,"X",0xFF,1)
		f_Read(FP,_Sub(BackupCp,6),GunPlayer,"X",0xFF)
		function GunBGM(ID,Type,Text)
			local GText = "\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D!H\x13\x07·\x11·\x08·\x07† "..Text.." \x04을(를) 파괴하였습니다. \x07†\x08·\x11·\x07·\n\x0D\x0D\n\x0D\x0D"
			if Type == nil then
				TriggerX(FP,{CV(GunID,ID)},{RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP)},{preserved})
			else
				TriggerX(FP,{CV(GunID,ID)},{SetV(BGMType,Type),RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP)},{preserved})
			end
		end
		--\x1B기억의 기둥 \x1D【 Conv_HStr2("") \x1D】


		GunBGM(131,2,"\x19기억의 \x04기둥 \x10《 "..Conv_HStr2("<19>H<4>atchery").." \x10》")
		GunBGM(132,3,"\x19기억의 \x04기둥 \x10《 "..Conv_HStr2("<19>L<4>air").." \x10》")
		GunBGM(133,4,"\x19기억의 \x04기둥 \x10《 "..Conv_HStr2("<19>H<4>ive").." \x10》")
		GunBGM(154,5,"\x19기억의 \x1D조각상 \x10《 "..Conv_HStr2("<19>F<1D>elis").." \x10》")
		GunBGM(148,5,"\x19기억의 \x1D위기 \x10《 "..Conv_HStr2("<19>C<1D>risis").." \x10》")
		GunBGM(174,5,"\x19기억의 \x1D문명 \x10《 "..Conv_HStr2("<19>L<1D>ost <19>C<1D>ivilization").." \x10》")
		GunBGM(147,5,"\x19기억의 \x1D천국 \x10《 "..Conv_HStr2("<1D>the <19>H<1D>eaven").." \x10》")
		GunBGM(151,5,"\x19기억의 \x1D실용성 \x10《 "..Conv_HStr2("<19>P<1D>ragmatism").." \x10》")
		GunBGM(127,5,"\x19기억의 \x1D보관소 \x10《 "..Conv_HStr2("<19>A<1D>rchive").." \x10》")
		GunBGM(126,5,"\x19기억의 \x1D균형 \x10《 "..Conv_HStr2("<19>E<1D>quilibrium").." \x10》")
		GunBGM(200,5,"\x19기억의 \x1D압도 \x10《 "..Conv_HStr2("<19>O<1D>verwhelm").." \x10》")
		GunBGM(201,5,"\x19기억의 \x1D망각 \x10《 "..Conv_HStr2("<19>O<1D>blivion").." \x10》")
		GunBGM(152,5,"\x19기억의 \x1D악몽 \x10《 "..Conv_HStr2("<19>N<1D>ightmare").." \x10》")
		GunBGM(130,5,"\x19기억의 \x1D봄 \x10《 "..Conv_HStr2("<19>A<1D>uxesia").." \x10》")
		GunBGM(168,nil,"\x19기억의 \x1D공명 \x10《 "..Conv_HStr2("<19>R<1D>esonance").." \x10》")
		GunBGM(175,5,"\x19기억의 \x1D내곽 \x10《 "..Conv_HStr2("<19>D<1D>efined <19>I<1D>nside").." \x10》")
		GunBGM(189,6,"\x19기억의 \x1D통로 \x10《 "..Conv_HStr2("<19>W<1D>arp <19>T<1D>unnel").." \x10》")
		GunBGM(190,nil,"\x19기억의 \x08중\x1D심부 \x10《 "..Conv_HStr2("<08>C<1D>Ore <1C>of <08>D<1D>epth").." \x10》")
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
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,1),Gun_Line(6,AtLeast,1)},{104,56,53,47},"ACAS","Circle3",1,444,nil,"CP")

	G_CA_SetSpawn2X({Gun_Line(3,Exactly,2),Gun_Line(5,Exactly,0)},{55,53,54,48},"ACAS","Polygon6",1,10,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,2),Gun_Line(6,AtLeast,1)},{104,56,53,47},"ACAS","Polygon6",1,10,nil,"CP")

	
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(5,Exactly,0)},{55,53,54,48},"ACAS","Star6_2",5,4,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(6,AtLeast,1)},{104,56,53,47},"ACAS","Star6_2",5,4,nil,"CP")
	
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,4),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Circle6_2",5,979,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,4),Gun_Line(6,AtLeast,1)},{104,62,47,54},"ACAS","Circle6_2",5,979,nil,"CP")

	
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,5),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Polygon6_2",5,530,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,5),Gun_Line(6,AtLeast,1)},{104,62,47,54},"ACAS","Polygon6_2",5,530,nil,"CP")
	
	
	
	


	CIfEnd()
	CIf_GCase(132)
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,1),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Star2",1,964,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,1),Gun_Line(5,Exactly,0)},{77,77},"ACAS","Star3",1,547,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,1),Gun_Line(6,AtLeast,1)},{104,62,51,15},"ACAS","Star2",1,964,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,1),Gun_Line(6,AtLeast,1)},{78,78},"ACAS","Star3",1,547,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,2),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Star2",1,427,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,2),Gun_Line(5,Exactly,0)},{77,77},"ACAS","Star3",1,984,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,2),Gun_Line(6,AtLeast,1)},{104,62,51,15},"ACAS","Star2",1,427,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,2),Gun_Line(6,AtLeast,1)},{78,78},"ACAS","Star3",1,984,nil,"CP")

	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","SqKal1",1,391,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(5,Exactly,0)},{65,70},"ACAS","SqKal2",1,364,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(6,AtLeast,1)},{104,62,51,15},"ACAS","SqKal1",1,391,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,3),Gun_Line(6,AtLeast,1)},{66,70},"ACAS","SqKal2",1,364,nil,"CP")

	
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,4),Gun_Line(5,Exactly,0)},{56,51},"ACAS","Pol_6_1",1,524,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,4),Gun_Line(5,Exactly,0)},{61,98},"ACAS","Pol_6_2",1,548,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,4),Gun_Line(6,AtLeast,1)},{62,51},"ACAS","Pol_6_1",1,524,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,4),Gun_Line(6,AtLeast,1)},{67,98},"ACAS","Pol_6_2",1,548,nil,"CP")




	G_CA_SetSpawn2X({Gun_Line(3,Exactly,5),Gun_Line(5,Exactly,0)},{56,51},"ACAS","Pol_4_1",1,441,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,5),Gun_Line(5,Exactly,0)},{81,29},"ACAS","Pol_4_2",1,503,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,5),Gun_Line(6,AtLeast,1)},{62,51},"ACAS","Pol_4_1",1,441,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,5),Gun_Line(6,AtLeast,1)},{23,29},"ACAS","Pol_4_2",1,503,nil,"CP")
	


	G_CA_SetSpawn2X({Gun_Line(3,Exactly,6),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Cir36_1",1,441,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,6),Gun_Line(5,Exactly,0)},{3,57},"ACAS","Cir36_2",1,503,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,6),Gun_Line(6,AtLeast,1)},{104,62,51,15},"ACAS","Cir36_1",1,441,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,6),Gun_Line(6,AtLeast,1)},{30,57},"ACAS","Cir36_2",1,503,nil,"CP")


	
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,7),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Spi2",1,559,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,7),Gun_Line(5,Exactly,0)},{65,8},"ACAS","Spi3",1,445,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,7),Gun_Line(6,AtLeast,1)},{104,62,51,15},"ACAS","Spi2",1,559,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,7),Gun_Line(6,AtLeast,1)},{66,8},"ACAS","Spi3",1,445,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,8),Gun_Line(5,Exactly,0)},{56,53,54,48},"ACAS","Tor2",1,559,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,8),Gun_Line(5,Exactly,0)},{65,8},"ACAS","Tor3",1,445,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,8),Gun_Line(6,AtLeast,1)},{104,62,51,15},"ACAS","Tor2",1,559,nil,"CP")
	G_CA_SetSpawn2X({Gun_Line(3,Exactly,8),Gun_Line(6,AtLeast,1)},{66,8},"ACAS","Tor3",1,445,nil,"CP")


	
	



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
	CIf(FP,{Gun_Line(0,AtLeast,131),Gun_Line(0,AtMost,133),Gun_Line(54,AtMost,0)},{Gun_SetLine(5,SetTo,1)})
		for i = 0, 3 do
			TriggerX(FP,{GCP(4+i),Gun_Line(0,Exactly,131),Gun_Line(6,AtLeast,1)},{SubCD(HactCcode[i+1],1)},{preserved})
			TriggerX(FP,{GCP(4+i),Gun_Line(0,Exactly,132),Gun_Line(6,AtLeast,1)},{SubCD(LairCcode[i+1],1)},{preserved})
			TriggerX(FP,{GCP(4+i),Gun_Line(0,Exactly,133),Gun_Line(6,AtLeast,1)},{SubCD(HiveCcode[i+1],1)},{preserved})
		end
		CTrigger(FP,{Gun_Line(6,AtLeast,1)},{Gun_DoSuspend()},1)
		CTrigger(FP,{TGun_Line(7,AtLeast,RedNumber)},{Gun_SetLine(6,SetTo,1)},1)
	CIfEnd()

	
	CIf_GCase(154)
		CTrigger(FP,{TGun_Line(7,AtLeast,RedNumber)},{Gun_SetLine(6,Add,1),Gun_SetLine(7,SetTo,0)},1)
		CTrigger(FP,{Gun_Line(6,AtLeast,5)},{Gun_DoSuspend(),AddCD(NexCcode,1)},1)
		for i = 5, 8 do
			TriggerX(FP,{Gun_Line(4,Exactly,i-1),Gun_Line(6,Exactly,5)},{Simple_CalcLoc(0,-128,-128,128,128),SetCp(i-1),RunAIScriptAt(JYD,1)})
			G_CA_SetSpawn2X({Gun_Line(4,Exactly,i-1)},{21},"ACAS","NexP"..i,"MAX",429,nil,"CP",nil,nil,1)
			G_CA_SetSpawn2X({Gun_Line(4,Exactly,i-1),Gun_Line(6,Exactly,1)},{88},"ACAS","NexP"..i,"MAX",424,nil,"CP",nil,nil,1)
			G_CA_SetSpawn2X({Gun_Line(4,Exactly,i-1),Gun_Line(6,Exactly,2)},{86},"ACAS","NexP"..i,"MAX",427,nil,"CP",nil,nil,1)
			G_CA_SetSpawn2X({Gun_Line(4,Exactly,i-1),Gun_Line(6,Exactly,3)},{22},"ACAS","NexP"..i,"MAX",337,nil,"CP",nil,nil,1)
			G_CA_SetSpawn2X({Gun_Line(4,Exactly,i-1),Gun_Line(6,Exactly,4)},{80},"ACAS","NexP"..i,"MAX",951,nil,"CP",nil,nil,1)
			G_CA_SetSpawn2X({Gun_Line(4,Exactly,i-1),Gun_Line(6,Exactly,5)},{98},"ACAS","NexP"..i,"MAX",549,nil,"CP",nil,nil,1)
		end
	CIfEnd()
	UID1I = 221
	UID2I = 222
	UID3I = 223
	UID4I = 224
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
		CMov(FP,TRepeatX,G_CA_CenterX)
		CMov(FP,TRepeatY,G_CA_CenterY)
		CIf(FP,{Gun_Line(7,AtLeast,35)},{Gun_SetLine(6,Add,1),Gun_SetLine(7,SetTo,0)})
		DoActionsX(FP,{SetV(WV,0)})
		CWhile(FP,{CV(WV,2,AtMost)},{AddV(WV,1)}) -- 티어1
			CMov(FP,UnitIDV1,VArr(Tier1VA,f_CRandNum(#Tier1,0)))
			f_TempRepeat2X(nil,UID1I,1,233,"CP","X",2)
			--G_CA_SetSpawn2X({},{UID1I},"ACAS","Point","MAX",233,nil,"CP",2,nil)
		CWhileEnd()
		DoActionsX(FP,{SetV(WV,0)})
		CWhile(FP,{CV(WV,1,AtMost)},{AddV(WV,1)}) -- 티어2
			CMov(FP,UnitIDV1,VArr(Tier2VA,f_CRandNum(#Tier2,0)))
			f_TempRepeat2X(nil,UID1I,1,545,"CP","X",2)
			--G_CA_SetSpawn2X({},{UID1I},"ACAS","Point","MAX",545,nil,"CP",2,nil)
		CWhileEnd()
		CMov(FP,UnitIDV1,VArr(Tier3VA,f_CRandNum(#Tier3,0))) -- 티어3
		f_TempRepeat2X(nil,UID1I,1,211,"CP","X",2)
		--G_CA_SetSpawn2X({},{UID1I},"ACAS","Point","MAX",211,nil,"CP",2,nil)
		CIfEnd()
		CIf(FP,{Gun_Line(6,AtLeast,5)},{Gun_SetLine(8,Add,1),Gun_SetLine(6,SetTo,0)})
		CMov(FP,UnitIDV1,VArr(Tier4VA,f_CRandNum(#Tier4,0))) -- 티어3
		f_TempRepeat2X(nil,UID1I,1,548,"CP","X",2)
		--G_CA_SetSpawn2X({},{UID1I},"ACAS","Point","MAX",548,nil,"CP",2,nil)

		CIfEnd()
		CIf(FP,{Gun_Line(8,AtLeast,2)},{Gun_SetLine(9,Add,1),Gun_SetLine(8,SetTo,0)})
		CMov(FP,UnitIDV1,VArr(Tier5VA,f_CRandNum(#Tier5,0))) -- 티어3
		f_TempRepeat2X(nil,UID1I,1,984,"CP","X",2)
		--G_CA_SetSpawn2X({},{UID1I},"ACAS","Point","MAX",984,nil,"CP",2,nil)

		CIfEnd()
	CTrigger(FP,{Gun_Line(9,AtLeast,5)},{Gun_DoSuspend(),AddCD(OvCcode,1)},1)
	
	CIfEnd()

	CIf_GCase(174)
	CDoActions(FP,{TGun_SetLine(8,Add,Dt)})
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
		--TriggerX(FP,{GCP(i),Gun_Line(8,AtLeast,1000),Gun_Line(9,AtLeast,12)},{Order("Men",i,64,Attack,11+i-4)},{preserved})
		TriggerX(FP,{GCP(i)},{SetV(G_CA_CenterX,TempleXY[i-3][1]),SetV(G_CA_CenterY,TempleXY[i-3][2])},{preserved})
		CSPlot(EffShape1,i,84,0,{TempleXY[i-3][1],TempleXY[i-3][2]},1,32,FP,{Label(),GCP(i),Gun_Line(20,AtMost,0)},{Gun_SetLine(20,SetTo,1)},1)
	for j = 0, 12 do
		
	local cond = {Label(),GCP(i),Gun_Line(8,AtLeast,1000),Gun_Line(9,Exactly,j-1)}
	if j == 0 then cond = {Label(),GCP(i),Gun_Line(30,Exactly,0)} end

	CSPlot(CS_Rotate(EffShape2,(j*30)),i,84,0,{TempleXY[i-3][1],TempleXY[i-3][2]},1,32,FP,cond,RotatePlayer({PlayWAVX("staredit\\wav\\Clock.ogg"),PlayWAVX("staredit\\wav\\Clock.ogg")},HumanPlayers,FP),nil)
	end
	end
	
	
	for i = 0, 12 do
		local cond = {Gun_Line(8,AtLeast,1000),Gun_Line(9,Exactly,i-1)}
		if i == 0 then cond = {Gun_Line(31,Exactly,0)} end
	G_CA_SetSpawn(cond,{TempleCUT[i+1]},"ACAS","TempleG",1,4,nil,"CP",G_CA_Rotate(270+(i*30)))
	end
	DoActionsX(FP,{Gun_SetLine(30,SetTo,1),Gun_SetLine(31,SetTo,1)})
	CTrigger(FP,{Gun_Line(8,AtLeast,1000)},{Gun_SetLine(9,Add,1),Gun_SetLine(20,SetTo,0),Gun_SetLine(8,Subtract,1000)},1)
	CTrigger(FP,{Gun_Line(9,AtLeast,13)},{Gun_DoSuspend(),AddCD(TempleCcode,1)},1)
	CIfEnd()
	CIf_GCase(147)
	--	Tier1 = {17,19,77,78,76,63,21,88,28,86,75,25}
	--	Tier2 = {79,80,52,10,22,65,70}
	--	Tier3 = {27,66,29,98,57,3,8,11,69,100}
	--	Tier4 = {102,61,67,23,81,30}
	--	Tier5 = {60,68}
	OvGCUT = {88,21,80,8,11,29,69,98}
	for i = 0, 7 do
		local cond = {Gun_Line(7,AtLeast,(#OvG-1)*3),Gun_Line(6,Exactly,i-1)}
		if i == 0 then
		cond = {Gun_Line(30,Exactly,0)} 
		end
	G_CA_SetSpawn(cond,{OvGCUT[i+1]},"ACAS","OvG"..i+1,1,3,nil,"CP",G_CA_LoopTimer(3))
	end

	for i = 0, 7 do
		local cond = {Gun_Line(7,AtLeast,(#OvG-1)*3),Gun_Line(6,Exactly,i)}
		for j = 4, 7 do
			TriggerX(FP,{cond,GCP(j)},{Order(OvGCUT[i+1],j,64,Attack,1)},{preserved})
			if i == 7 then
				Trigger2X(FP,{cond,GCP(j)},{Simple_CalcLoc(0,-128,-128,128,128),SetCp(j),RunAIScriptAt(JYD,1)},{preserved})
			end
		end
	end
	DoActionsX(FP,{Gun_SetLine(30,SetTo,1),Gun_SetLine(31,SetTo,1)})
	CTrigger(FP,{Gun_Line(7,AtLeast,(#OvG-1)*3)},{Gun_SetLine(6,Add,1),Gun_SetLine(7,SetTo,0)},{preserved})
	CTrigger(FP,{Gun_Line(6,AtLeast,8)},{Gun_DoSuspend(),AddCD(OvGCcode,1)},1)
	
	CIfEnd()


	CIf_GCase(151)
		DoActions2(FP,{Simple_CalcLoc(0,-256,-256,256,256)})
		CDoActions(FP,{Gun_SetLine(8,SetTo,1),TCreateUnit(1,84,1,G_CA_Player)})
		CTrigger(FP,{TGun_Line(7,AtLeast,RedNumber)},{Gun_SetLine(6,Add,1),Gun_SetLine(7,SetTo,0),Gun_SetLine(9,Add,1)},1)
		CereT = {80,8}
		for j = 1, 2 do
		for i = 0, 7 do
		local cond = {Gun_Line(3,Exactly,j),Gun_Line(6,Exactly,i),Gun_Line(9,AtLeast,1)}
		if i == 0 then cond = {Gun_Line(3,Exactly,j),Gun_Line(30,Exactly,0)} end
			G_CA_SetSpawn(cond,{CereT[j]},"ACAS","Cere1","MAX",0,nil,"CP",G_CA_Rotate(270+(i*45)))
		end
		end
		for i = 0, 3 do
			TriggerX(FP,{GCP(i+4),Gun_Line(6,AtLeast,8)},{AddCD(CereCond[i+1],1)},{preserved})
		end
	--Gun_Line(3,Exactly,1),
		CTrigger(FP,{Gun_Line(9,AtLeast,1)},{Gun_SetLine(9,SetTo,0)},1)
		DoActionsX(FP,{Gun_SetLine(30,SetTo,1),Gun_SetLine(31,SetTo,1)})
		CTrigger(FP,{Gun_Line(6,AtLeast,8)},{TSetMemory(0x6509B0,SetTo,G_CA_Player),RunAIScriptAt(JYD,1),Gun_DoSuspend()},1)

	CIfEnd()

	CIf_GCase(127)
	CTrigger(FP,{TGun_Line(7,AtLeast,RedNumber)},{Gun_SetLine(6,Add,1),Gun_SetLine(7,SetTo,0),Gun_SetLine(9,Add,1)},1)
	Ion_CUTable1={{23,69,11},{81,30},{67,102},{60,68}}
	Ion_CUTable2={{21,17},{28,19},{22,10},{8,3}}
	Ion_CUTable3={{55,53,54,48},{104,56,53,47},{56,53,54,48},{104,62,51,15}}
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
	CTrigger(FP,{Gun_Line(9,AtLeast,1)},{Gun_SetLine(9,SetTo,0)},1)
	for i = 0, 3 do
		TriggerX(FP,{GCP(4+i),Gun_Line(6,AtLeast,3)},{AddCD(IonCcode[i+1],1)})
	end
	CDoActions(FP,{Gun_SetLine(8,SetTo,1)})
	CTrigger(FP,{Gun_Line(6,AtLeast,3)},{Gun_DoSuspend()},1)
	CIfEnd()
	CIf_GCase(126)
	CTrigger(FP,{TGun_Line(7,AtLeast,RedNumber)},{Gun_SetLine(6,Add,1),Gun_SetLine(7,SetTo,0),Gun_SetLine(9,Add,1)},1)
	--	Tier1 = {17,19,77,78,76,63,21,88,28,86,75,25}
	--	Tier2 = {79,80,52,10,22,65,70}
	--	Tier3 = {27,66,29,98,57,3,8,11,69,100}
	--	Tier4 = {102,61,67,23,81,30}
	--	Tier5 = {60,68}
	Norad_CUTable1={{23,69,11},{81,30},{67,102},{60,68}}
	Norad_CUTable2={{88,77},{80,78},{57,66},{98,52}}
	Norad_CUTable3={{55,53,54,48},{104,56,53,47},{56,53,54,48},{104,62,51,15}}
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
	CTrigger(FP,{Gun_Line(9,AtLeast,1)},{Gun_SetLine(9,SetTo,0)},1)
	for i = 0, 3 do
		TriggerX(FP,{GCP(4+i),Gun_Line(6,AtLeast,3)},{AddCD(NoradCcode[i+1],1)})
	end
	CDoActions(FP,{Gun_SetLine(8,SetTo,1)})
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
	},{preserved})
	CTrigger(FP,{
		Gun_Line(14,Exactly,1) --CVar("X",Move1,Exactly,1);
	},{
		Gun_SetLine(15,Subtract,9); -- SetCVar("X",Move2,Subtract,9);
	},{preserved})
	CTrigger(FP,{
		Gun_Line(14,Exactly,1); --CVar("X",Move1,Exactly,1);
		Gun_Line(15,Exactly,0); --CVar("X",Move2,Exactly,0);
	},{
		Gun_SetLine(14,SetTo,0); -- SetCVar("X",Move1,SetTo,0);
	},{preserved})
	CTrigger(FP,{
		Gun_Line(14,Exactly,0); --CVar("X",Move1,Exactly,0);
		Gun_Line(15,AtLeast,1280); --CVar("X",Move2,AtLeast,1280);
	},{
		Gun_SetLine(14,SetTo,1); -- SetCVar("X",Move1,SetTo,1);
	},{preserved})
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
		Gun_Line(30,AtMost,0)},{
		Gun_SetLine(10,SetTo,540); -- SetCVar("X",TSize,SetTo,540);
		SetCD(GeneT,0),RotatePlayer({PlayWAVX("sound\\Terran\\Frigate\\AfterOff.wav"),PlayWAVX("sound\\Terran\\Frigate\\AfterOff.wav"),PlayWAVX("sound\\Terran\\Frigate\\AfterOff.wav"),PlayWAVX("sound\\Terran\\Frigate\\AfterOff.wav")},HumanPlayers,FP);
		SetInvincibility(Enable,"Men",Force2,64);
	},{preserved})
	CTrigger(FP,{CD(GeneT,29999,AtMost),
		Gun_Line(10,AtMost,540*3*6) --CVar(FP,TSize,AtMost,540*3*6)
	},{
		Gun_SetLine(10,Add,540/4); -- SetCVar("X",TSize,Add,540/4);
	},{preserved})
	
	
	CallTrigger(FP,CallCXPlot,{SetCD(CXEffType,0)})
	DoActionsX(FP,{Gun_SetLine(30,SetTo,1),Gun_SetLine(31,SetTo,1)})
	CTrigger(FP,{CD(GeneT,30000,AtLeast)},{Gun_SetLine(10,Subtract,540/6)},1)
	CTrigger(FP,{CD(GeneT,30000,AtLeast),Gun_Line(10,AtMost,0)},{Gun_DoSuspend(),AddCD(GeneCcode,1),SetInvincibility(Disable,"Men",Force2,64),RotatePlayer({PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav")},HumanPlayers,FP);},1)

	
	CIfEnd()

	CIf_GCase(152)
		TriggerX(FP,{Gun_Line(7,AtMost,340)},{CreateUnit(1,84,1,FP)},{preserved})
		CIf(FP,{Gun_Line(7,AtLeast,241),Gun_Line(7,AtLeast,240)},{Gun_SetLine(10,Add,540/2)})
		CTrigger(FP,{GCP(6)},{Gun_SetLine(1,Add,12)},{preserved})
		CTrigger(FP,{GCP(7),Gun_Line(7,AtLeast,241),Gun_Line(7,AtLeast,240)},{Gun_SetLine(1,Subtract,12)},{preserved})
		CallTrigger(FP,CallCXPlot,{SetCD(CXEffType,0)})
		CIfEnd()
		CIf(FP,{Gun_Line(7,AtLeast,290)},{Gun_DoSuspend(),AddCD(DGCcode,1)})
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
	CenterCUT = {88,21,86,28}--{11,69,22,47}--
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
				Gun_SetLine(8,Add,1)})
			f_Read(FP,_Add(Nextptrs,10),CPos)
			Convert_CPosXY()
				Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
				CDoActions(FP,{
					TGiveUnits(1,CenterUIDV,G_CA_Player,1,P9);
					TSetDeathsX(_Add(Nextptrs,72),SetTo,0xFF*256,0,0xFF00),
					TSetDeaths(_Add(Nextptrs,13),SetTo,1,0),
					TSetDeathsX(_Add(Nextptrs,18),SetTo,1,0,0xFFFF),
					Order("Men",P9,1,Move,64);})
		CIfEnd()
	CIfEnd()
	CIf(FP,{TTOR({Gun_Line(8,Exactly,360),TTAND({Gun_Line(8,AtLeast,361),Gun_Line(7,Exactly,500)})})},{Gun_SetLine(7,SetTo,0)})
			
			CMov(FP,C_FS,1)
			CMov(FP,C_W,0)
			CWhile(FP,{CV(C_W,359,AtMost)})
			ConvertArr(FP,C_ArrConv,C_W)
			for i = 0, 3 do
				CIf(FP,GCP(i+4),{SetV(C_FS2,60+(i*15)),SetV(C_A,(i*90)),SetV(CenterUIDV,CenterCUT[i+1])})
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
						--TSetDeathsX(_Add(CenterPtrs,19),SetTo,6*256,0,0xFF00),
						})
				TriggerX(FP,{CV(C_FS,2000,AtLeast)},{SetV(C_FS,1)},{preserved})
				CElseX()
				f_Read(FP,_Add(CenterPtrs,10),TempPos)
				CMov(FP,CPos,TempPos)
				Convert_CPosXY()
				Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,Simple_CalcLoc(0, -2, -2, 2, 2))
				CDoActions(FP,{
					TGiveUnits(1,CenterUIDV,P9,1,G_CA_Player);
					TSetDeathsX(_Add(CenterPtrs,72),SetTo,0,0,0xFF00),
					TSetDeathsX(_Add(CenterPtrs,55),SetTo,0,0,0x04000000),
					TSetDeaths(_Add(CenterPtrs,23),SetTo,0,0),
					TSetDeathsX(_Add(CenterPtrs,19),SetTo,187*256,0,0xFF00),
					TSetDeaths(_Add(CenterPtrs,6),SetTo,TempPos,0),
					TSetDeaths(_Add(CenterPtrs,22),SetTo,TempPos,0),
					TSetDeaths(_Add(CenterPtrs,4),SetTo,TempPos,0),
					--TSetMemory(0x6509B0,SetTo,G_CA_Player),
					--KillUnitAt(1, nilunit, 1, FP),
					--RunAIScriptAt(JYD,1),SetCp(FP),
					Gun_DoSuspend(),AddCD(CenCcode,1)
				})
				for i = 4, 7 do
					TriggerX(FP,{GCP(i)},{AddCD(CenCcode2[i-3],1)},{preserved})
				end
				CIfXEnd()
			CIfEnd()
				DoActionsX(FP,{AddV(C_W,1)})
			CWhileEnd()
			
			
			CTrigger(FP,{Gun_Line(8,Exactly,360)},{Gun_SeTLine(8,SetTo,361)},1)
	CIfEnd()



	CIfEnd()
	N_R,N_A = CreateVars(2,FP)
	CIf_GCase(168)
	N_Check = CreateCcode()
	CMov(FP,N_R,Var_TempTable[10])
	CMov(FP,N_A,0)
	DoActionsX(FP,{SetCD(N_Check,0)})
	CWhile(FP,{CVar(FP,N_A[2],AtMost,359)})
	f_Lengthdir(FP,N_R,_Add(N_A,Var_TempTable[9]),N_X,N_Y)
	
	CAdd(FP,N_X,G_CA_CenterX)
	CAdd(FP,N_Y,G_CA_CenterY)

	Simple_SetLocX(FP,0,N_X,N_Y,N_X,N_Y)
	CreateEffUnit({CV(N_X,4096,AtMost),CV(N_Y,4096,AtMost),GCP(4)},20,548,0)
	CreateEffUnit({CV(N_X,4096,AtMost),CV(N_Y,4096,AtMost),GCP(5)},20,548,13)
	CreateEffUnit({CV(N_X,4096,AtMost),CV(N_Y,4096,AtMost),GCP(6)},20,548,17)
	CreateEffUnit({CV(N_X,4096,AtMost),CV(N_Y,4096,AtMost),GCP(7)},20,548,10)
	DoActions(FP,Simple_CalcLoc(0,-96,-96,96,96))
	for i = 4, 7 do
		TriggerX(FP,{GCP(i)},{
			KillUnitAt(All,135,1,i);
			KillUnitAt(All,136,1,i);
			KillUnitAt(All,137,1,i);
			KillUnitAt(All,138,1,i);
			KillUnitAt(All,139,1,i);
			KillUnitAt(All,140,1,i);
			KillUnitAt(All,141,1,i);
			KillUnitAt(All,142,1,i);
		},{preserved})
	end
	
	TriggerX(FP,{CV(N_X,4096,AtMost),CV(N_Y,4096,AtMost)},{SetCD(N_Check,1)},{preserved})
	CAdd(FP,N_A,12)
	CWhileEnd()
	TriggerX(FP,{Gun_Line(7,Exactly,1)},{RotatePlayer({PlayWAVX("staredit\\wav\\res1.wav"),PlayWAVX("staredit\\wav\\res1.wav"),PlayWAVX("staredit\\wav\\res1.wav"),PlayWAVX("staredit\\wav\\res1.wav")},HumanPlayers,FP)},{preserved})
	TriggerX(FP,{Gun_Line(7,Exactly,100)},{RotatePlayer({PlayWAVX("staredit\\wav\\res2.wav"),PlayWAVX("staredit\\wav\\res2.wav"),PlayWAVX("staredit\\wav\\res2.wav"),PlayWAVX("staredit\\wav\\res2.wav")},HumanPlayers,FP)},{preserved})
	CIf(FP,{TTOR({Gun_Line(7,AtMost,15),Gun_Line(7,AtLeast,100)})})
	CDoActions(FP,{TGun_SetLine(8,Add,Var_TempTable[8])})
	CAdd(FP,N_R,8)
	CIfEnd()
	CDoActions(FP,{TGun_SetLine(9,SetTo,N_R)})
	CTrigger(FP,{CD(N_Check,0)},{Gun_DoSuspend(),AddCD(CellCcode,1)},1)
	CIfEnd()

	CIf_GCase(175)
	CTrigger(FP,{Gun_Line(7,Exactly,1)},{TCreateUnitWithProperties(5,13,1,G_CA_Player,{energy=100})},1)
	CIf(FP,{TGun_Line(7,AtLeast,RedNumber)},{Gun_DoSuspend(),AddCD(XelCcode,1),RotatePlayer({PlayWAVX("staredit\\wav\\Recall.ogg"),PlayWAVX("staredit\\wav\\Recall.ogg")},HumanPlayers,FP)})
		for i = 4, 7 do
			TriggerX(FP,{GCP(i)},{Order("Men",i,64,Attack,2+i-4)},{preserved})
		end
	CIfEnd()

	CIfEnd()
	CIf_GCase(201)
		Simple_SetLoc2X(FP,0,_Neg(Var_TempTable[8]),_Neg(Var_TempTable[8]),Var_TempTable[8],Var_TempTable[8])
		DoActionsX(FP,{Gun_SetLine(8,Add,1)})
		TriggerX(FP,{Gun_Line(8,AtLeast,10)},{Gun_SetLine(8,SetTo,0),Order("Men",Force1,1,Move,1),CreateScanEff(58)},{preserved})
		TriggerX(FP,{Gun_Line(7,AtLeast,1000)},{Gun_DoSuspend(),AddCD(OcCcode,1),},{preserved})
	CIfEnd()
	

	CIf_GCase(189)
	DoActionsX(FP,{SetCD(WarpCheck,1),SetInvincibility(Enable,189,Force2,64)})
	CIfX(FP,{TTOR({Gun_Line(8,AtMost,1224),TTAND({Gun_Line(13,AtLeast,1),Gun_Line(8,AtLeast,15410),Gun_Line(8,AtMost,16350)})})})
		CIfX(FP,{Gun_Line(8,AtMost,1224)})
		CSub(FP,N_R,_Mov(1224),Var_TempTable[9])
		f_Div(FP,N_R,4)
		CElseX()
		CSub(FP,N_R,_Mov(16350),Var_TempTable[9])
		f_Div(FP,N_R,3)
		CIfXEnd()

		CMov(FP,N_A,0)
		TempRand = f_CRandNum(360)
		DoActionsX(FP,{SetCD(N_Check,0)})
		CWhile(FP,{CVar(FP,N_A[2],AtMost,359)})
		f_Lengthdir(FP,N_R,_Add(N_A,TempRand),N_X,N_Y)
		
		CAdd(FP,N_X,G_CA_CenterX)
		CAdd(FP,N_Y,G_CA_CenterY)

		Simple_SetLocX(FP,0,N_X,N_Y,N_X,N_Y)
		CreateEffUnit({CV(N_X,4096,AtMost),CV(N_Y,4096,AtMost),GCP(4)},20,548,0)
		CreateEffUnit({CV(N_X,4096,AtMost),CV(N_Y,4096,AtMost),GCP(5)},20,548,13)
		CreateEffUnit({CV(N_X,4096,AtMost),CV(N_Y,4096,AtMost),GCP(6)},20,548,17)
		CreateEffUnit({CV(N_X,4096,AtMost),CV(N_Y,4096,AtMost),GCP(7)},20,548,10)

		
		TriggerX(FP,{CV(N_X,4096,AtMost),CV(N_Y,4096,AtMost)},{SetCD(N_Check,1)},{preserved})
		CAdd(FP,N_A,12)
		CWhileEnd()

	CElseIfX({Gun_Line(10,AtMost,0)},{Gun_SetLine(10,SetTo,1)})
		G_CA_SetSpawn({},{84},"ACAS","Warp1",nil,5,nil,"CP")
		
	--Ion_CUTable3={{55,53,54,48,17},{104,56,53,47,19},{56,53,54,48,10},{104,62,51,15,3}}
	G_CA_SetSpawn({},{56,53,54,48},"ACAS",{"Warp2","Warp3","Warp3","Warp3"},"MAX",1,nil,"CP")
	G_CA_SetSpawn({},{104,51,15},"ACAS",{"Warp3","Warp4","Warp4"},"MAX",1,nil,"CP")
	CElseIfX({Gun_Line(8,AtLeast,8790),Gun_Line(11,AtMost,0)},{Gun_SetLine(11,SetTo,1)})
	G_CA_SetSpawn({},{84},"ACAS","Warp1",nil,5,nil,"CP")
	G_CA_SetSpawn({},{56,53,54,48},"ACAS",{"Warp2","Warp3","Warp3","Warp3"},"MAX",1,nil,"CP")
	G_CA_SetSpawn({},{104,51,15},"ACAS",{"Warp3","Warp4","Warp4"},"MAX",1,nil,"CP")
	CElseIfX({Gun_Line(8,AtLeast,15410),Gun_Line(13,AtMost,0)},{Gun_SetLine(13,SetTo,1)})
	CDoActions(FP,{TKillUnit("Factories",G_CA_Player)})
	G_CA_SetSpawn({},{84},"ACAS","Warp1",nil,5,nil,"CP")
	CElseIfX({Gun_Line(8,AtLeast,16350),Gun_Line(12,AtMost,0),Memory(0x628438,AtLeast,1)},{Gun_SetLine(12,SetTo,1),Gun_DoSuspend()})
	f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
	--중간보스 소환 
BossUID = {87,74,5,2}
	HName = {
		"\x10Ｄ\x04ｉｖｉｄｅ",
		"\x15Ｔ\x04ｅｎｅｂｒｉｓ",
		"\x18Ｄ\x04ｅｍｉｓｅ",
		"\x1BＡ\x04ｎｏｍａｌｙ"
	}
    WarpXY = {
		{1632,1824},
		{-1632+4096,1824},
		{1632,-1824+4096},
		{-1632+4096,-1824+4096}}
	for j = 4, 7 do
		Trigger2X(FP,{GCP(j)},{Simple_SetLoc(0,WarpXY[j-3][1],WarpXY[j-3][2],WarpXY[j-3][1],WarpXY[j-3][2]),CreateUnitWithProperties(1,BossUID[j-3],1,j,{energy=100}),RotatePlayer({PlayWAVX("staredit\\wav\\BossAwak.ogg"),PlayWAVX("staredit\\wav\\BossAwak.ogg"),PlayWAVX("staredit\\wav\\BossAwak.ogg"),PlayWAVX("staredit\\wav\\BossAwak.ogg"),DisplayTextX("\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04\n\x0D\x0D\x13\x04！！！　\x08ＢＯＳＳ　ＢＡＴＴＬＥ\x04　！！！\n\x0D\x0D\x14\x0D\x0D\n\x14\x0D\x0D\n\x0D\x0D!H"..StrDesignX2("\x07기억\x04의 수호자 \x10【 "..HName[j-3].." \x10】 \x04가 \x08봉인\x04에서 \x17해방\x04되었습니다.").."\n\x0D\x0D\x14\n\x0D\x0D\x14\n\x0D\x0D\x13\x04！！！　\x08ＢＯＳＳ　ＢＡＴＴＬＥ\x04　！！！\n\x0D\x0D\x13\x04",4)},HumanPlayers,FP)})
		CTrigger(FP,{GCP(j)},{SetV(BPtrArr[j-3],Nextptrs)})
	end
	
	CIfXEnd()
--
	CDoActions(FP,{TGun_SetLine(8,Add,Dt)})
	CIfEnd()

	






	CIf_GCase(190)
	TriggerX(FP,{},{RotatePlayer({RunAIScript(P8VON),RunAIScript(P7VON),RunAIScript(P6VON),RunAIScript(P5VON)},MapPlayers,FP)})
	G_CA_SetSpawn({},{70,57,8,98},"ACAS",{"GB_P1","GB_P3","GB_P4","GB_P2"},1,72,nil,nil,G_CA_LoopTimer(2),nil,1)
	DoActionsX(FP,{Gun_SetLine(10,Add,25000),KillUnit("Factories",Force2),SetMemory(0x58D718, SetTo, 0x00000000);SetMemory(0x58D71C, SetTo, 0x00000000);},1)
	TriggerX(FP,{},{RotatePlayer({PlayWAVX("staredit\\wav\\GBossAct.ogg"),PlayWAVX("staredit\\wav\\GBossAct.ogg"),PlayWAVX("staredit\\wav\\GBossAct.ogg"),},HumanPlayers,FP)})

	CIf(FP,Gun_Line(7,AtLeast,400))

	CTrigger(FP,{},{TGun_SetLine(10,Add,Dt),TGun_SetLine(8,Add,Dt)},1)--CV(Dt,0x2A,AtMost)
--	CTrigger(FP,{CV(Dt,0x2A+1,AtLeast)},{TGun_SetLine(10,Add,0x2A),TGun_SetLine(8,Add,0x2A)},1)

	DoActionsX(FP,{SetV(CA_Create,0)})
	DoActionsX(FP,{RotatePlayer({CenterView(64)},HumanPlayers,FP)},1)
	CMov(FP,CA_Eff_Rat,Var_TempTable[11])
	CMov(FP,CA_Eff_XY,Var_TempTable[12])
	CMov(FP,CA_Eff_YZ,Var_TempTable[13])
	CMov(FP,CA_Eff_ZX,Var_TempTable[14])
	CallTrigger(FP,Call_CA_Effect)
    GunBGMArr = {}
    for i = 1, 148 do
        if i <= 9 then
            table.insert(GunBGMArr,"staredit\\wav\\ikasu00"..i..".ogg")
        elseif i >= 10 and i<= 99 then
            table.insert(GunBGMArr,"staredit\\wav\\ikasu0"..i..".ogg")
        else
            table.insert(GunBGMArr,"staredit\\wav\\ikasu"..i..".ogg")
        end
		TriggerX(FP,{Gun_Line(8,AtLeast,(i-1)*1263)},{RotatePlayer({PlayWAVX(GunBGMArr[i]),PlayWAVX(GunBGMArr[i]),PlayWAVX(GunBGMArr[i])},HumanPlayers,FP)})
    end

	function CA_3DAcc(Time,XY,YZ,ZX)
		TriggerX(FP,{Gun_Line(8,AtLeast,Time)},{
			Gun_SetLine(11,Add,XY),
			Gun_SetLine(12,Add,YZ),
			Gun_SetLine(13,Add,ZX),
		},{preserved})
	end
	DoActionsX(FP,{
		Gun_SetLine(11,Add,1),
		Gun_SetLine(12,Add,1),
		--Gun_SetLine(13,Add,0),
	})
	CA_3DAcc(32840,1,1,1)
	CA_3DAcc(80210,2,1,0)
	CA_3DAcc(112420,2,1,1)
	CA_3DAcc(142730,2,1,1)


	--Tier3 = {66,29,3}
	--Tier4 = {102,61,67,23,81,30}
	--Tier5 = {60,68}

	G_CA_SetSpawn({Gun_Line(8,AtLeast,15780)},{77,88},"ACAS","EllipseMirror1","MAX",0,nil,nil,nil,nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,23360)},{25,21},"ACAS","EllipseMirror1","MAX",0,nil,nil,nil,nil,1)
	
	G_CA_SetSpawn({Gun_Line(8,AtLeast,32840)},{15,56},"ACAS","Hp2","MAX",0,nil,nil,G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,40420)},{17,28},"ACAS","Hp2","MAX",0,nil,nil,G_CA_Rotate3D(),nil,1)
--
	G_CA_SetSpawn({Gun_Line(8,AtLeast,55570)},{75,80},"ACAS","Hp2","MAX",0,nil,nil,G_CA_Rotate3D(),nil,1)

	G_CA_SetSpawn({Gun_Line(8,AtLeast,70730)},{22,76},"ACAS","Hp2","MAX",0,nil,nil,G_CA_Rotate3D(),nil,1)
	
	G_CA_SetSpawn({Gun_Line(8,AtLeast,80210)},{100,57},"ACAS","Hp2","MAX",0,nil,nil,G_CA_Rotate3D(),nil,1)

	G_CA_SetSpawn({Gun_Line(8,AtLeast,95360)},{63,29},"ACAS","Hp2","MAX",0,nil,nil,G_CA_Rotate3D(),nil,1)

	G_CA_SetSpawn({Gun_Line(8,AtLeast,112420)},{10,8},"ACAS","Hp2","MAX",0,nil,nil,G_CA_Rotate3D(),nil,1)

	G_CA_SetSpawn({Gun_Line(8,AtLeast,127570)},{86,79},"ACAS","Hp2","MAX",0,nil,nil,G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,142730)},{98,52},"ACAS","Hp2","MAX",0,nil,nil,G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,157890)},{70,65},"ACAS","Hp2","MAX",0,nil,nil,G_CA_Rotate3D(),nil,1)
	
	--

	bit = 315.7894
	GBAirT = {55,56,62,88,21,28,86,22,70}
	for j, k in pairs(GBAirT) do
		G_CA_SetSpawn({Gun_Line(8,AtLeast,157890+((j-1)*(bit*6)))},{k},"ACAS","GBAir",1,0,nil,nil,G_CA_Rotate(10*(j-1)),nil,1)
	end
	



	G_CA_SetSpawn({Gun_Line(8,AtLeast,174000)},{19,27},"ACAS","Hp2","MAX",0,nil,nil,G_CA_Rotate3D(),nil,1)

	
	G_CA_SetSpawn({Gun_Line(8,AtLeast,30940)},{84},"ACAS","EllipseMirror1","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,31570)},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,31650)},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,31730)},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,32520)},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,63150)},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,63150+(1*(bit)/2))},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,63150+(3*(bit)/2))},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,63150+(5*(bit)/2))},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,63150+(6*(bit)/2))},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,63150+(7*(bit)/2))},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,63150+(9*(bit)/2))},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,63150+(11*(bit)/2))},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,63150+(12*(bit)/2))},{84},"ACAS","EllipseMirror1","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,63150)},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,66940+(0*(bit)/2))},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,66940+(3*(bit)/2))},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,66940+(5*(bit)/2))},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,66940+(6*(bit)/2))},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,66940+(8*(bit)/2))},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,66940+(10*(bit)/2))},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,66940+(12*(bit)/2))},{84},"ACAS","EllipseMirror1","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,76420)},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,77360)},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,78310)},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,78630)},{84},"ACAS","Warp1",Warp1[1]/30,3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,79260)},{84},"ACAS","EllipseMirror1","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,80210)},{84},"ACAS","HCD2","MAX",3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,112420)},{84},"ACAS","Warp1",Warp1[1]/20,3,nil,"OP",G_CA_Rotate3D(),nil,1)
	G_CA_SetSpawn({Gun_Line(8,AtLeast,173050)},{84},"ACAS","Warp1",Warp1[1]/40,3,nil,"OP",G_CA_Rotate3D(),nil,1)

	

	

	
function SetBright(Time,Value)
	TriggerX(FP,{Gun_Line(8,AtLeast,Time)},{SetMemory(0x657A9C,SetTo,Value)})
	end
	SetBright(0,0)
	SetBright(15780,31)
	SetBright(23360,15)
	SetBright(30940,31)
	SetBright(31570,23)
	SetBright(31650,17)
	SetBright(31730,15)
	SetBright(32520,5)
	SetBright(32840,31)
	SetBright(65050,27)
	SetBright(68840,24)
	SetBright(70730,31)
	SetBright(76420,25)
	SetBright(77360,20)
	SetBright(78310,15)
	SetBright(79260,10)
	SetBright(80210,31)
	SetBright(109570,27)
	SetBright(110210,24)
	SetBright(110420,21)
	SetBright(110630,17)
	SetBright(110840,15)
	SetBright(111360,10)
	for i = 0, 31 do
	SetBright(111780 + (i*19),31-i)
	end
	SetBright(112420,31)



	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(0*(bit)/8))},{SubV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(1*(bit)/8))},{AddV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(2*(bit)/8))},{SubV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(3*(bit)/8))},{AddV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(4*(bit)/8))},{SubV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(5*(bit)/8))},{AddV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(6*(bit)/8))},{AddV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(7*(bit)/8))},{AddV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(8*(bit)/8))},{AddV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(9*(bit)/8))},{AddV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(10*(bit)/8))},{SubV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(11*(bit)/8))},{AddV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(12*(bit)/8))},{SubV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(13*(bit)/8))},{AddV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(14*(bit)/8))},{SubV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(15*(bit)/8))},{AddV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(16*(bit)/8))},{SubV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(17*(bit)/8))},{AddV(Var_TempTable[11],5000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(18*(bit)/8))},{SubV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(19*(bit)/8))},{AddV(Var_TempTable[11],5000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(20*(bit)/8))},{SubV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(21*(bit)/8))},{AddV(Var_TempTable[11],5000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(22*(bit)/8))},{SubV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(23*(bit)/8))},{AddV(Var_TempTable[11],5000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(24*(bit)/8))},{SubV(Var_TempTable[11],10000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(25*(bit)/8))},{AddV(Var_TempTable[11],5000*3)})
	TriggerX(FP,{Gun_Line(8,AtLeast,110210+(26*(bit)/8))},{SetV(Var_TempTable[11],110210+(26*(bit)/8))})
	TriggerX(FP,{Gun_Line(8,AtLeast,111780)},{SetV(Var_TempTable[11],(110210+(27*(bit)/8))*2)})
	TriggerX(FP,{Gun_Line(8,AtLeast,111780),Gun_Line(8,AtMost,112420)},{SubV(Var_TempTable[11],8500)},{preserved})
	TriggerX(FP,{Gun_Line(8,AtLeast,112420)},{SetV(Var_TempTable[11],112420+25000)})
	



	NUGive(63150,70)
	NUGive(80210,57)
	TriggerX(FP,{Gun_Line(8,AtLeast,112420)},{KillUnit("Men",Force2)})
	NUGive(112420,8)
	NUGive(142730,98)
				--0x00XXXXXX 
				--0x0000NPUU 


	function GBossCr(Var,UID)
	CallTriggerX(FP,Call_CA_Effect,{Gun_Line(8,AtLeast,Var)},SetV(CA_Create,UID),1)
	end
	function GBossEf(Var,EFT)
	CallTriggerX(FP,Call_CA_Effect,{Gun_Line(8,AtLeast,Var)},SetV(CA_Create,EFT+1000),1)
	end
	CrEfT = {
		{30940,28,334},
		{31570,28,334},
		{31650,28,334},
		{31730,28,334},
		{32520,28,334},
	}
function PushCr(Var,UID,EFT)
	table.insert(CrEfT,{Var,UID,EFT})
end
	PushCr(47360,56,59)
	PushCr(47520,56,59)
	PushCr(47680,56,59)
	PushCr(47840,56,59)
	PushCr(48000,56,59)

	PushCr(48940,55,213)

	PushCr(49260,55,332)
	PushCr(49260+(1*(bit/2)),55,332)
	PushCr(49260+(2*(bit/2)),55,332)
	PushCr(49260+(3*(bit/2)),55,332)
	PushCr(49260+(4*(bit/2)),55,332)

	PushCr(50280,62,59)
	PushCr(50360,62,59)

	PushCr(50840,62,213)
	PushCr(51150,62,213)
	PushCr(51150+(1*(bit/2)),62,213)
	PushCr(51150+(2*(bit/2)),62,213)
	PushCr(51150+(3*(bit/2)),62,213)

	PushCr(51150+(4*(bit/2)),21,332)
	PushCr(51150+(5*(bit/2)),21,332)
	PushCr(51150+(6*(bit/2)),21,332)
	PushCr(51150+(7*(bit/2)),21,332)
	PushCr(51150+(8*(bit/2)),21,332)
	PushCr(51150+(9*(bit/2)),21,332)

	PushCr(51150+(10*(bit/2)),62,59)
	PushCr(51150+(11*(bit/2)),62,59)
	PushCr(51150+(12*(bit/2)),62,59)
	PushCr(51150+(13*(bit/2)),62,59)
	PushCr(51150+(14*(bit/2)),62,59)
	PushCr(51150+(15*(bit/2)),62,59)

	PushCr(51150+(16*(bit/2)),88,213)
	PushCr(51150+(17*(bit/2)),88,213)
	PushCr(51150+(18*(bit/2)),88,213)
	PushCr(51150+(19*(bit/2)),88,213)
	PushCr(51150+(20*(bit/2)),88,213)
	PushCr(51150+(42*(bit/4)),88,213)
	PushCr(51150+(43*(bit/4)),88,213)


	PushCr(51150+(22*(bit/2)),22,332)
	PushCr(51150+(25*(bit/2)),22,332)

	PushCr(55570+(0*(bit/2)),56,59)
	PushCr(55570+(2*(bit/2)),56,59)
	PushCr(55570+(3*(bit/2)),56,59)
	PushCr(55570+(4*(bit/2)),56,59)
	PushCr(55570+(5*(bit/2)),56,59)

	PushCr(55570+(6*(bit/2)),86,213)
	PushCr(55570+(9*(bit/2)),86,213)
	PushCr(55570+(22*(bit/4)),86,213)
	PushCr(55570+(23*(bit/4)),86,213)
 
	PushCr(55570+(12*(bit/2)),28,332)
	PushCr(55570+(14*(bit/2)),28,332)
	PushCr(55570+(15*(bit/2)),28,332)
	PushCr(55570+(16*(bit/2)),28,332)
	PushCr(55570+(17*(bit/2)),28,332)

	PushCr(55570+(18*(bit/2)),62,59)
	PushCr(55570+(21*(bit/2)),62,59)
	PushCr(55570+(23*(bit/2)),62,59)

	PushCr(55570+(24*(bit/2)),88,213)
	PushCr(55570+(25*(bit/2)),88,213)
	PushCr(55570+(26*(bit/2)),88,213)
	PushCr(55570+(27*(bit/2)),88,213)
	PushCr(55570+(28*(bit/2)),88,213)
	PushCr(55570+(29*(bit/2)),88,213)

	PushCr(55570+(60*(bit/4)),21,332)
	PushCr(55570+(61*(bit/4)),21,332)
	PushCr(55570+(62*(bit/4)),21,332)
	PushCr(55570+(64*(bit/4)),21,332)
	for j = 66, 85 do
		local k = 59
		local l = 56
		if j >=66 and j<=71 then
			k = 332
			l = 28
		end
		if j >=72 and j<=84 then
			k = 59
			l = 62
		end
		if j == 85 then
			k = 215
			l = 70
		end
	PushCr(55570+(j*(bit/4)),l,k)
	end
	PushCr(63150,27,429)
	PushCr(63150+(1*(bit)/2),27,429)
	PushCr(63150+(3*(bit)/2),27,429)
	PushCr(63150+(5*(bit)/2),27,429)
	PushCr(63150+(6*(bit)/2),27,429)
	PushCr(63150+(7*(bit)/2),27,429)
	PushCr(63150+(9*(bit)/2),27,429)
	PushCr(63150+(11*(bit)/2),27,429)
	PushCr(63150+(12*(bit)/2),30,334)
	PushCr(66940+(0*(bit)/2),102,444)
	PushCr(66940+(3*(bit)/2),102,444)
	PushCr(66940+(5*(bit)/2),102,444)
	PushCr(66940+(6*(bit)/2),102,444)
	PushCr(66940+(8*(bit)/2),102,444)
	PushCr(66940+(10*(bit)/2),102,444)
	PushCr(66940+(12*(bit)/2),60,334)

	
	PushCr(76420,30,391)
	PushCr(77360,30,391)
	PushCr(78310,30,391)
	PushCr(79260,30,391)
	PushCr(80210,60,391)
	
	PushCr(126310+(0*(bit/4)),21,214)
	PushCr(126310+(2*(bit/4)),21,214)
	PushCr(126310+(4*(bit/4)),21,214)
	PushCr(126310+(6*(bit/4)),21,214)
	PushCr(126310+(7*(bit/4)),21,214)
	PushCr(126310+(8*(bit/4)),21,214)
	PushCr(126310+(10*(bit/4)),21,214)
	PushCr(126310+(12*(bit/4)),21,214)
	PushCr(126310+(13*(bit/4)),21,214)
	PushCr(126310+(14*(bit/4)),21,214)
	PushCr(126310+(15*(bit/4)),21,214)

	for j = 0, 44 do
		local k = 8
		local l = 10

		if j >=6 and j<=11 then
			k = 80
			l = 4
		end
		if j >=12 and j<=17 then
			k = 57
			l = 48
		end
		if j >=18 and j<=23 then
			k = 98
			l = 558
		end
		if j >=24 and j<=29 then
			k = 27
			l = 333
		end
		if j >=30 and j<=35 then
			k = 70
			l = 3
		end
		if j >=36 and j<=41 then
			k = 11
			l = 332
		end
		if j >=42 then
			k = 69
			l = 213
		end

		PushCr(127570+(j*(bit)),k,l)
	end
	
	for i = 0, 3 do
	PushCr(141470+(i*(bit/4)),69,213)
	end
	G_CA_SetSpawn({Gun_Line(8,AtLeast,141780)},{84},"ACAS","Warp1",Warp1[1]/20,3,nil,"OP",G_CA_Rotate3D(),nil,1)
	
	
	PushCr(170210,102,334)
	PushCr(170440,102,334)
	PushCr(170680,102,334)
	PushCr(170920,102,334)
	
	
	for j = 0, 23 do--171150 0~23
		
		local k = 80
		local l = 214

		if j >=12 and j<=23 then
			k = 21
			l = 333
		end
		PushCr(171150+(j*(bit/4)),k,l)
	end
	
	

	for j, k in pairs(CrEfT) do
		if k == 0 then
			GBossEf(k[1],k[3])
		else
			GBossCr(k[1],k[2])
			GBossEf(k[1],k[3])
		end
	end
	CMov(FP,SHLX,G_CA_CenterX)
	CMov(FP,SHLY,G_CA_CenterY)
	CallTrigger(FP,EffUnitLoop)
	TriggerX(FP,{Gun_Line(8,AtLeast,186000)},{Gun_SetLine(10,Subtract,4000)},{preserved})
	
	InvDisable(173,FP,{Gun_Line(8,AtLeast,186000),Gun_Line(10,AtMost,0)},"\x08최후\x04의 \x10기억 \x10"..Conv_HStr("<11>L<19>ost <10>M<19>emory").." \x04의 \x02무적상태\x04가 해제되었습니다.")
	TriggerX(FP,{Gun_Line(8,AtLeast,186000),Gun_Line(10,AtMost,0)},{Gun_DoSuspend()})
	
	CIfEnd()
	CIfEnd()

	CIf_GCase(173)
--    DoActionsX(FP,{KillUnit("Men",Force2)},1)

--	CIf(FP,CD(EEggCode,9,AtMost))
--	
--    DoActionsX(FP,{SetV(BGMType,7),SetCD(Fin,1)},1)
--	StoryPrint(4000*2,"\x04마침내 이 혼돈의 기억을 모두 정화하였다.")
--	StoryPrint(4000*3,"\x04하지만, 잃어버린 \x07빛\x04의 \x17기억\x04은 찾을 수 없었고")
--	StoryPrint(4000*4,"\x04머지않아 이 기억은 다시 \x10혼돈\x04에 잠길 것이겠지..")
--	StoryPrint(4000*5,"\x04...라는.. 혹독한 \x1F절망\x04감에 다시한번 사로잡히게 된다.")
--	StoryPrint(4000*6,"\x0F잃어버린 \x17기억\x04의 \x0E멋지고 \x1F아름다운 \x1D추상화\x04는, 도대체 어디에 있단 말인가?")
--	StoryPrint(4000*7,"\x04어쩌면, 그 기억은 \x10허구\x04의 존재가 아닐까...?")
--	StoryPrint(4000*8,"\x04수많은 생각이 당신의 머릿속을 스쳐 지나가며")
--	StoryPrint(4000*9,"\x08넓디 넓은 \x07기억\x04속에서 \x11끝없는 여정\x04이 계속된다.")
--	TriggerX(FP,{Gun_Line(8,AtLeast,4000*10)},{Gun_DoSuspend(),SetCD(Win,1),SetCD(EDNum,1)})
--	CDoActions(FP,{TGun_SetLine(8,Add,Dt)})
--	CIfEnd()
--	CIf(FP,{CD(EEggCode,10,AtLeast),CD(EEggCode,16,AtMost)})
--    DoActionsX(FP,{SetV(BGMType,8),Gun_SetLine(9,SetTo,19780)},1)
--	TriggerX(FP,{Gun_Line(13,AtLeast,22580)},{SetCD(BStart,1)})
--	CIf(FP,{Gun_Line(12,Exactly,0)},{Gun_SetLine(11,Add,1)})
--	f_Mul(FP,Var_TempTable[11],Var_TempTable[10],Var_TempTable[10])
--	f_Div(FP,Var_TempTable[11],195674)
--	CMov(FP,N_A,0)
--	CWhile(FP,{CV(N_A,359,AtMost)})
--	f_Lengthdir(FP,Var_TempTable[11],_Add(N_A,Var_TempTable[12]),N_X,N_Y)
--	CAdd(FP,N_X,G_CA_CenterX)
--	CAdd(FP,N_Y,G_CA_CenterY)
--	Simple_SetLocX(FP,0,N_X,N_Y,N_X,N_Y)
--	CreateEffUnit({CV(N_X,4096,AtMost),CV(N_Y,4096,AtMost)},20,548,0)
--	CAdd(FP,N_A,12)
--	CWhileEnd()
--
--	
--
--	CIfOnce(FP,{Gun_Line(9,AtMost,0),Memory(0x628438,AtLeast,1)},{Gun_SetLine(12,SetTo,1),SetMemoryB(0x6636B8+64,SetTo,130)})
--	f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
--	CSub(FP,CurCunitI,Nextptrs,19025)
--	f_Div(FP,CurCunitI,_Mov(84))
--	CDoActions(FP,{Set_EXCC2(UnivCunit,CurCunitI,4,SetTo,20000000-8320000)})
--	G_CA_SetSpawn({},{84},"ACAS","Warp1",Warp1[1]/40,3,nil,"OP",nil,nil,1)
--
--
--	CTrigger(FP,{},{SetV(BPtrArr[5],Nextptrs),CreateUnitWithProperties(1,64,64,FP,{energy=100, invincible = true})})
--	CIfEnd()
--	CIfEnd()
--	
--	CIf(FP,{CD(ED2Clear,0)})
--	local SpawnSet = {{22580,{77,88}},{33880,{25,21}},{45170,{15,56}},{56470,{17,28}},{68480,{75,80}},{79760,{22,76}},{91050,{100,57}},{102350,{63,29}},{113640,{10,8}},{124940,{86,79}},{136240,{98,52}},{147520,{70,65}}}
--for j, k in pairs(SpawnSet) do
--	G_CA_SetSpawn({Gun_Line(13,AtLeast,k[1])},k[2],"ACAS","EllipseMirror1",nil,0,nil,nil,nil,nil,1)
--end
--	CIfEnd()
--
----
--	CIf(FP,{CD(ED2Clear,1)})
--	G_CA_SetSpawn({},{84},"ACAS","Warp1",Warp1[1]/40,3,nil,"OP",nil,nil,1)
--Trigger2X(FP,{},{RotatePlayer({
--	DisplayTextX("\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04\n\x0D\x0D\x13\x04！！！　\x10ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D!H\x13\x18Ｆｉｎａｌ　Ｂｏｓｓ \x04－\x10【 \x11Ｐ\x04ａｓｔ \x10】 \x04를 처치하셨습니다.\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04！！！　\x10ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\x0D\x0D\n\x0D\x0D\x13\x04",4),
--	PlayWAVX("staredit\\wav\\Clear1.ogg"),
--	PlayWAVX("staredit\\wav\\Clear1.ogg"),
--	PlayWAVX("staredit\\wav\\Clear1.ogg"),
--	PlayWAVX("staredit\\wav\\Clear1.ogg"),
--	PlayWAVX("staredit\\wav\\Clear1.ogg")
--	},HumanPlayers,FP);})
--		StoryPrint(4000*1,"\x04마침내, 과거의 기억을 되찾아 내었다.")
--		StoryPrint(4000*2,"\x04하지만, 어째서일까, \x10슬픈 \x18감정\x04이 \x08폭풍\x04처럼 몰아친다.")
--		StoryPrint(4000*3,"\x04아아, 이것은 그녀와 함께했던 \x1C추억\x04의 \x17기억\x04인가..?")
--		StoryPrint(4000*4,"\x04지금은 이 세상에 존재하지 않는 그녀와의 \x0E소중한 기억\x04.")
--		StoryPrint(4000*5,"\x04지금쯤, 그녀는 어디서 무엇을 하고 있을까?")
--		StoryPrint(4000*6,"\x04부디 좋은 곳으로 잘 떠났기를 빌며...")
--		StoryPrint(4000*7,"\x04당신은 또다른 \x07빛\x04의 \x17기억을 찾아 \x11끝없는 여정\x04이 계속된다.")
--		TriggerX(FP,{Gun_Line(8,AtLeast,4000*8)},{Gun_DoSuspend(),SetCD(Win,1),SetCD(EDNum,2)})
--		CDoActions(FP,{TGun_SetLine(8,Add,Dt)})
--	CIfEnd()
--	CIfEnd()
	CIf(FP,{})--CD(EEggCode,17,AtLeast),CD(EEggCode,24,AtMost)
	CallTrigger(FP, Call_CreateBullet_EPD)--탄막 구조체 불러오기
	
	
	CIfOnce(FP)
	G_CA_SetSpawn({},{204},"ACAS",{"Warp4"},"MAX",3,nil,"CP")
	DoActionsX(FP,{
		MoveUnit(All, "Men", 0, 15, 2),
		MoveUnit(All, "Men", 1, 15, 3),
		MoveUnit(All, "Men", 2, 15, 4),
		MoveUnit(All, "Men", 3, 15, 5),
		Order("Men",0,15,Move,2),
		Order("Men",1,15,Move,3),
		Order("Men",2,15,Move,4),
		Order("Men",3,15,Move,5),
		SetCD(MarDup,1),
		SetCD(CUnitFlag,1),
		SetMemory(0x66EC48+(318*4), SetTo, 133),--핵터지는모션살리기
		RemoveUnit(60, AllPlayers)--핵배틀삭제
	},1)
	
	BPTest = CreateVar(FP)	
	BPHRetTest = CreateVar(FP)	
	f_Read(FP,0x628438,"X",BPTest,0xFFFFFF)
	DoActions(FP,CreateUnit(1,12,64,FP),SetMemoryB(0x665C48+511,SetTo,0),1)--가시 보이기 삭제
	CIfEnd()
	function CABossFunc()
		local UnitPtr = CABossPtr
		local PlayerID = CABossPlayerID
		local CA = CABossDataArr
		local CB = CABossTempArr
		
		
	end
	CABoss(BPTest,BPHRetTest,8000000,{0,300,1},"CABossFunc",FP)
	CIfEnd()



CDoActions(FP,{TGun_SetLine(9,Subtract,Dt)})
CDoActions(FP,{TGun_SetLine(13,Add,Dt)})
	CIfEnd()
	
	GunPushTrig = {}
	for i = 0, 54 do
		table.insert(GunPushTrig,TSetMemory(_Add(G_TempH,(i*0x20)/4),SetTo,Var_TempTable[i+1]))
	end
	CDoActions(FP,GunPushTrig)
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