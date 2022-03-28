
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
		function GunBGM(ID,Type,Text,Point,OtherTrig)
			local GText = "\n\n\n\n\n\x13\x08！ ！ ！ \x04적의 "..Text.." 파괴하였다!\x17 + "..Point.." P t s\x08 ！ ！ ！\n\n"
			if Type == nil then
				TriggerX(FP,{CV(GunID,ID)},{SetScore(Force1,Add,Point,Kills),RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP),OtherTrig},{Preserved})
			else
				TriggerX(FP,{CV(GunID,ID)},{SetScore(Force1,Add,Point,Kills),SetV(BGMType,Type),RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP),OtherTrig},{Preserved})
			end
		end
		GunBGM(131,nil,"기지 \x18Hatchery \x04를",25000,{SetCD(NosBGM,1)})
		GunBGM(132,nil,"기지 \x18Lair \x04를",35000,{SetCD(NosBGM,1)})
		GunBGM(133,4,"기지 \x18Hive \x04를",50000)
		GunBGM(175,5,"\x04쥬림 \x11무너진 \x07신전 \x04을",300000)
		GunBGM(127,5,"\x07쥬림 \x06산맥의 \x11결계 \x04를",500000)
		GunBGM(109,6,"보급고 \x18Supply Depot \x04을",100000)
		GunBGM(156,6,"수정탑 \x18Pylon \x04을",100000)
		GunBGM(154,nil,"연결체 \x18Nexus \x04를",150000,{SetCD(NosBGM,1)})
		GunBGM(116,7,"연구소 \x18Facility \x04을",30000)
		GunBGM(150,7,"번데기 \x18Mature Crysalis \x04을",30000)
		GunBGM(151,4,"정신체 \x18Cerebrate \x04을",60000)
		GunBGM(130,4,"감염체 \x18Center \x04를",60000)
		GunBGM(201,8,"정신체 \x18Cocoon \x04을",150000)
		GunBGM(200,8,"발전소 \x18Generator \x04를",250000)
		GunBGM(147,8,"완전체 \x18Overmind G \x04를",400000)
		GunBGM(148,8,"초월체 \x18Overmind \x04를",100000)
		GunBGM(173,8,"수정 집합체 \x18Formation \x04을",100000)
		GunBGM(190,8,"교란기 \x18Psi Disrupter \x04를",300000)
		GunBGM(168,nil,"봉인 \x18Stasis Cell \x04을",50000)

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
		local TempV = CreateVar(FP)
		if Limit == 1 then
			CIf(FP,CD(TestMode,1))
			ItoDec(FP,G_A,VArr(f_GunNumT,0),2,0x1F,0)
			CMov(FP,TempV,f_GunSendStrPtr,f_GunSendT[2])
			f_Movcpy(FP,TempV,VArr(f_GunNumT,0),4*4)
			DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0Df_GunSend".._0D,4)},HumanPlayers,FP)})
			ItoDec(FP,DUnitCalc[4][1],VArr(f_GunNumT,0),2,0x1F,0)
			CMov(FP,TempV,f_GunSendStrPtr2,f_GunSendT2[2])
			f_Movcpy(FP,TempV,VArr(f_GunNumT,0),4*4)
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
	DoActionsX(FP,{SetSwitch(RandSwitch1,Random),SetSwitch(RandSwitch2,Random),SetCD(GunCaseCheck,0),Gun_SetLine(7,Subtract,1)})
	CIf_GCase(131)
	HatcCUTable = {
		{ -- Index 1
			{54,25,1},{53,15,2},{55,9,3},{48,15,4},{104,{5,10,15},5}
		},
		{ -- Index 2
			{54,25,1},{53,15,2},{55,25,3},{48,9,4},{104,{5,10,15},5}
		},
		{ -- Index 3
			{54,25,1},{53,15,2},{55,25,3},{48,9,4},{104,{5,10,15},5}
		},
		{ -- Index 4
			{54,25,1},{53,25,2},{55,25,3},{48,9,4},{104,{5,10,15},5},{51,{5,10,15},5}
		},
		{ -- Index 5
			{55,25,1},{54,25,1},{53,25,2},{56,25,3},{48,9,4},{104,{5,10,25},5},{51,{5,10,15},5}
		},
		{ -- Index 6
			{55,25,1},{54,25,1},{53,25,2},{56,25,3},{48,9,4},{104,{10,15,25},5},{51,{10,15,25},5}
		},
		{ -- Index 7
			{55,25,1},{54,25,1},{53,25,2},{56,25,3},{48,9,4},{51,{5,10,15},5}
		},
		{ -- Index 8
			{55,25,1},{54,25,1},{53,25,2},{56,25,3},{48,9,4},{104,{10,15,25},3},{51,{10,15,25},5},{56,25,5}
		},
		}
		CIf(FP,Gun_Line(7,AtMost,0),Gun_SetLine(7,Add,120))
		TMem(FP,TempEPD,Arr(HactLinkArr[1],0),0,0)
		CAdd(FP,TempEPD,_Mul(Var_TempTable[4],0x970/4))
		JumpArrI = def_sIndex()
		CJumpEnd(FP,JumpArrI)
		NIf(FP,{TMemory(TempEPD,AtLeast,1)})
			f_Read(FP,TempEPD,CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
			CMov(FP,G_CA_X,CPosX)
			CMov(FP,G_CA_Y,CPosY)
			--여기에 TempRepeat나 G_CA_SpawnSet을 입력
			for j, k in pairs(HatcCUTable) do
				for l,m in pairs(k) do
					if type(m[2]) == "table" then
						for o,p in pairs(m[2]) do
							f_TempRepeat({Gun_Line(3,Exactly,j),Gun_Line(8,Exactly,m[3]-1),CD(GMode,o)},m[1],p,nil,nil,"CG")
						end
					else
						f_TempRepeat({Gun_Line(3,Exactly,j),Gun_Line(8,Exactly,m[3]-1)},m[1],m[2],nil,nil,"CG")
					end
				end
			end

			DoActionsX(FP,{AddV(TempEPD,1)})
			CJump(FP,JumpArrI)
		NIfEnd()
		DoActionsX(FP,{Gun_SetLine(8,Add,1)})
		CIfEnd()
		TriggerX(FP,{Gun_Line(8,AtLeast,5)},{Gun_DoSuspend(),SubCD(HactCcode,1)},{Preserved})
	CIfEnd()
	
	CIf_GCase(132)
	LairCUTable = {
		{ -- Index 1
			{53,25,1},{48,15,2},{56,9,3},{51,15,4},{10,{2,5,15},5}
		},
		{ -- Index 2
			{53,25,1},{48,15,2},{56,25,3},{51,15,4},{77,{2,5,15},5}
		},
		{ -- Index 3
			{53,25,1},{48,15,2},{56,25,3},{51,15,4},{75,{2,5,15},5}
		},
		{ -- Index 4
			{53,25,1},{48,15,2},{56,25,3},{51,15,4},{17,{2,5,15},5}
		},
		{ -- Index 5
			{53,25,1},{48,15,2},{56,25,3},{51,15,4},{82,{1,3,11},5}
		},
		{ -- Index 6
			{53,25,1},{48,15,2},{56,25,3},{51,15,4},{78,{2,5,15},5}
		},
		{ -- Index 7
			{53,25,1},{48,15,2},{56,25,3},{51,15,4},{19,{2,5,15},5}
		},
		{ -- Index 8
			{53,25,1},{48,15,2},{56,25,3},{51,15,4},{81,{2,5,15},5}
		},
		{ -- Index 9
			{53,25,1},{48,15,2},{56,25,3},{51,15,4},{79,{2,5,15},5}
		},
		{ -- Index 10
			{53,25,1},{48,15,2},{56,25,3},{51,15,4},{76,{2,5,15},5}
		},
		}
		CIf(FP,Gun_Line(7,AtMost,0),Gun_SetLine(7,Add,120))
		TMem(FP,TempEPD,Arr(LairLinkArr[1],0),0,0)
		CAdd(FP,TempEPD,_Mul(Var_TempTable[4],0x970/4))
		JumpArrI = def_sIndex()
		CJumpEnd(FP,JumpArrI)
		NIf(FP,{TMemory(TempEPD,AtLeast,1)})
			f_Read(FP,TempEPD,CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
			CMov(FP,G_CA_X,CPosX)
			CMov(FP,G_CA_Y,CPosY)
			--여기에 TempRepeat나 G_CA_SpawnSet을 입력
			for j, k in pairs(LairCUTable) do
				for l,m in pairs(k) do
					if type(m[2]) == "table" then
						for o,p in pairs(m[2]) do
							f_TempRepeat({Gun_Line(3,Exactly,j),Gun_Line(8,Exactly,m[3]-1),CD(GMode,o)},m[1],p,nil,nil,"CG")
						end
					else
						f_TempRepeat({Gun_Line(3,Exactly,j),Gun_Line(8,Exactly,m[3]-1)},m[1],m[2],nil,nil,"CG")
					end
				end
			end

			DoActionsX(FP,{AddV(TempEPD,1)})
			CJump(FP,JumpArrI)
		NIfEnd()
		DoActionsX(FP,{Gun_SetLine(8,Add,1)})
		CIfEnd()
		TriggerX(FP,{Gun_Line(8,AtLeast,5)},{Gun_DoSuspend(),SubCD(LairCcode,1)},{Preserved})
	CIfEnd()
	
	CIf_GCase(133)
		CIf(FP,Gun_Line(7,AtMost,0),Gun_SetLine(7,Add,120))
		CIf(FP,{Gun_Line(3,AtMost,3),})
		HiveCUTable = {
			{ -- Index 1
				{53,15,1},{54,15,1},{55,25,1},{51,25,2},{56,25,3},{10,{3,10,20},3},{104,25,4},{48,15,4},{21,{5,10,20},5}
			},
			{ -- Index 2
				{53,15,1},{54,15,1},{55,25,1},{51,25,2},{56,25,3},{17,{3,10,20},3},{104,25,4},{48,15,4},{88,{5,10,20},5}
			},
			{ -- Index 3
				{53,15,1},{54,15,1},{55,25,1},{51,25,2},{56,25,3},{75,{3,10,20},3},{104,25,4},{48,15,4},{28,{2,5,11},5}
			},
		}
		HiveLinkTable = {
			{ -- Index 1
				{2432,672},{2400,288},
			},
			{ -- Index 2
				{1760,608},{2208,768},
			},
			{ -- Index 3
				{1312,832},{1056,960},
			},
		}
		for j, k in pairs(HiveCUTable) do
			for l,m in pairs(k) do
				if type(m[2]) == "table" then
					for o,p in pairs(m[2]) do
						f_TempRepeat({Gun_Line(3,Exactly,j),Gun_Line(8,Exactly,m[3]-1),CD(GMode,o)},m[1],p,nil,nil,"CG")

						for s, t in pairs(HiveLinkTable[j]) do
							f_TempRepeat({Gun_Line(3,Exactly,j),Gun_Line(8,Exactly,m[3]-1),CD(GMode,o)},m[1],p,nil,nil,t)
						end
					end
				else
					f_TempRepeat({Gun_Line(3,Exactly,j),Gun_Line(8,Exactly,m[3]-1)},m[1],m[2],nil,nil,"CG")
					for s, t in pairs(HiveLinkTable[j]) do
						f_TempRepeat({Gun_Line(3,Exactly,j),Gun_Line(8,Exactly,m[3]-1)},m[1],m[2],nil,nil,t)
					end
				end
			end
		end
		CIfEnd()
		PSIHiveShape = CS_ConnectPathX({3   ,{480, 1600},{1152, 1216},{448, 864}},148)
		TriggerX(FP,{CD(GMode,2,AtLeast),Gun_Line(3,Exactly,4)},{Simple_SetLoc(15,320,1216,320,1216),SetMemory(0x6CA010, SetTo, 64)},{Preserved})
		CSPlotAct(PSIHiveShape,FP,29,0,{0,0},1,32,256,{Order(29,FP,1,Attack,16)},FP,{Label(),CD(GMode,2,AtLeast),Gun_Line(3,Exactly,4),Gun_Line(8,Exactly,0)})
		CSPlotAct(PSIHiveShape,FP,29,0,{0,0},1,32,256,{Order(29,FP,1,Attack,16)},FP,{Label(),CD(GMode,2,AtLeast),Gun_Line(3,Exactly,4),Gun_Line(8,Exactly,4)})
		DoActions(FP,SetMemory(0x6CA010, SetTo, 640))
		HiveCUTable2 = {
			{ -- Index 4
				{53,15,1},{54,15,1},{55,25,1},{51,25,2},{56,25,3},{104,25,4},{48,15,4},{19,{5,10,20},5}
			},
			{ -- Index 5
				{53,15,1},{54,15,1},{55,25,1},{51,25,2},{56,25,3},{81,{3,10,20},3},{104,25,4},{48,15,4},{29,{2,5,11},5}
			},
			{ -- Index 6
				{53,15,1},{54,15,1},{55,25,1},{51,25,2},{56,25,3},{64,{3,10,20},3},{104,25,4},{48,15,4},{80,{1,3,6},5}
			},
			{ -- Index 7
				{53,15,1},{54,15,1},{55,25,1},{51,25,2},{56,25,3},{23,{1,3,6},3},{104,25,4},{48,15,4},{102,{1,2,3},5}
			},
			{ -- Index 8
				{53,15,1},{54,15,1},{55,25,1},{51,25,2},{56,25,3},{27,{2,5,11},3},{104,25,4},{48,15,4},{61,{2,6,15},5}
			},
			{ -- Index 9
				{53,15,1},{54,15,1},{55,25,1},{51,25,2},{56,25,3},{68,{1,2,4},3},{104,25,4},{48,15,4},{98,{3,6,15},5}
			},
			{ -- Index 10
				{53,15,1},{54,15,1},{55,25,1},{51,25,2},{56,25,3},{17,{3,10,20},3},{104,25,4},{48,15,4},{29,{2,5,11},5}
			},
			{ -- Index 11
				{53,15,1},{54,15,1},{55,25,1},{51,25,2},{56,25,3},{77,{4,10,25},3},{104,25,4},{48,15,4},{88,{5,15,30},5}
			},
			{ -- Index 12
				{53,15,1},{54,15,1},{55,25,1},{51,25,2},{56,25,3},{78,{4,10,25},3},{104,25,4},{48,15,4},{88,{5,15,30},5}
			},
			{ -- Index 13
				{53,15,1},{54,15,1},{55,25,1},{51,25,2},{56,25,3},{10,{4,10,25},3},{104,25,4},{48,15,4},{21,{5,15,30},5}
			},
			{ -- Index 14
				{53,15,1},{54,15,1},{55,25,1},{51,25,2},{56,25,3},{19,{4,10,25},3},{104,25,4},{48,15,4},{21,{5,15,30},5}
			},
			{ -- Index 15
				{53,15,1},{54,15,1},{55,25,1},{51,25,2},{56,25,3},{25,{4,10,25},3},{104,25,4},{48,15,4},{28,{2,5,11},5}
			},
			{ -- Index 16
				{53,15,1},{54,15,2},{51,25,5},{104,25,4},{48,15,3},
				{77,{2,5,10},1},{78,{2,5,10},2},{77,{2,5,10},3},{78,{2,5,10},4},{77,{2,5,10},5},
				{88,{2,5,10},1},{88,{2,5,10},2},{88,{2,5,10},3},{88,{2,5,10},4},{88,{2,5,10},5}
			},
			{ -- Index 17
				{79,{4,10,25},1},{53,15,1},{54,15,1},{55,25,1},{51,25,2},{56,25,3},{75,{4,10,25},3},{104,25,4},{48,15,4},{80,{2,5,11},5}
			},
			{ -- Index 18
				{53,15,1},{54,15,2},{51,25,5},{104,25,4},{48,15,3},
				{10,{2,5,10},1},{17,{2,5,10},2},{10,{2,5,10},3},{17,{2,5,10},4},{10,{2,5,10},5},
				{21,{2,5,10},1},{21,{2,5,10},2},{21,{2,5,10},3},{21,{2,5,10},4},{21,{2,5,10},5}
			},
		}
		for j, k in pairs(HiveCUTable2) do
			for l,m in pairs(k) do
				if type(m[2]) == "table" then
					for o,p in pairs(m[2]) do
						f_TempRepeat({Gun_Line(3,Exactly,j+3),Gun_Line(8,Exactly,m[3]-1),CD(GMode,o)},m[1],p,nil,nil,"CG")
					end
				else
					f_TempRepeat({Gun_Line(3,Exactly,j+3),Gun_Line(8,Exactly,m[3]-1)},m[1],m[2],nil,nil,"CG")
				end
			end
		end


		CIf(FP,{Gun_Line(3,AtLeast,19),Gun_Line(3,AtMost,22)})
			HTankZoneArr = {
				{1216,2336},{1984,2336},{1216,1952},{1984,1952}
			}
			HTankDiffArr = {2,5,nil}
			HTankDiffArr2 = {nil,nil,3}
			for i = 0, 4 do
				for j, k in pairs(HTankZoneArr) do
					for l, m in pairs(HTankDiffArr) do
						if m ~= nil then
							f_TempRepeat({Gun_Line(8,Exactly,i),CD(GMode,l)},25,m,nil,nil,k)
						end
						
					end
					for l, m in pairs(HTankDiffArr2) do
						if m ~= nil then
							f_TempRepeat({Gun_Line(8,Exactly,i),CD(GMode,l)},30,m,nil,nil,k)
							
						end
					end
				end
			end
		CIfEnd()
		


		DoActionsX(FP,{Gun_SetLine(8,Add,1)})
		CIfEnd()
		
		TriggerX(FP,{Gun_Line(8,AtLeast,5)},{Gun_DoSuspend(),SubCD(HiveCcode,1)},{Preserved})
	CIfEnd()
	CIf_GCase(156)
		DoActions(FP,{CreateUnit(1,84,1,FP),KillUnit(84,FP)})
		CIf(FP,Gun_Line(7,AtMost,0),{Gun_SetLine(7,Add,50),Gun_SetLine(8,Add,1)})
			DoActions2(FP,{RotatePlayer({MinimapPing(1)},HumanPlayers,FP),SetMemoryX(0x666458, SetTo, 391,0xFFFF),})
			PySuShape = {4,{-6*32,0},{0,-3*32},{6*32,0},{0,3*32}}
			CSPlot(PySuShape,FP,33,0,nil,1,32,FP,nil,{KillUnit(33,FP)},1)
		CIfEnd(SetMemoryX(0x666458, SetTo, 546,0xFFFF))
		CSPlot(PySuShape,FP,84,0,nil,1,32,FP,{Label(),Gun_Line(8,AtLeast,20)},{KillUnit(84,FP)},1)
		TriggerX(FP,{Memory(0x6509B0,AtLeast,1),Gun_Line(8,AtLeast,20)},{RotatePlayer({PlayWAVX("staredit\\wav\\res1.ogg")},HumanPlayers,FP),Gun_DoSuspend(),CreateUnit(1,193,1,FP)},{Preserved})
	CIfEnd()
	CIf_GCase(109)
		DoActions(FP,{CreateUnit(1,22,1,FP),KillUnit(22,FP)})
		CIf(FP,Gun_Line(7,AtMost,0),{Gun_SetLine(7,Add,50),Gun_SetLine(8,Add,1)})
			DoActions2(FP,{RotatePlayer({MinimapPing(1)},HumanPlayers,FP),SetMemoryX(0x666458, SetTo, 391,0xFFFF),})
			PySuShape = {4,{-6*32,0},{0,-3*32},{6*32,0},{0,3*32}}
			CSPlot(PySuShape,FP,33,0,nil,1,32,FP,nil,{KillUnit(33,FP)},1)
		CIfEnd(SetMemoryX(0x666458, SetTo, 546,0xFFFF))
		CSPlot(PySuShape,FP,22,0,nil,1,32,FP,{Label(),Gun_Line(8,AtLeast,20)},{KillUnit(22,FP)},1)
		TriggerX(FP,{Memory(0x6509B0,AtLeast,1),Gun_Line(8,AtLeast,20)},{RotatePlayer({PlayWAVX("staredit\\wav\\res1.ogg")},HumanPlayers,FP),Gun_DoSuspend(),CreateUnit(1,192,1,FP)},{Preserved})
	CIfEnd()
	CIf_GCase(175)
	XelCUTable = {3,6,11}
	XelCUTable2 = {2,5,12}
		CIf(FP,Gun_Line(7,AtMost,0),Gun_SetLine(7,Add,240))
				for l = 1, 3 do
					f_TempRepeat({CD(GMode,l)},27,XelCUTable[l],nil,nil,"CG")
					f_TempRepeat({CD(GMode,l)},61,XelCUTable2[l],nil,nil,"CG")
				end
			DoActionsX(FP,{Gun_SetLine(8,Add,1)})
		CIfEnd()
		TriggerX(FP,{Gun_Line(8,AtLeast,2)},{Gun_DoSuspend(),AddCD(XelCcode,1)},{Preserved})
	CIfEnd()
	CIf_GCase(127)
	IonCUTable = {1,6,25}
	IonCUTable2 = {28,27,27}
	IonCUTable3 = {75,19,61}
	IonShape =  CS_ConnectPathX({4   ,{2816, 1280},{2272, 1568},{2880, 1888},{3456, 1600}},148)
	IonShape2 = CS_ConnectPathX({4   ,{2880, 1456},{2656, 1568},{2880, 1680},{3120, 1568}},96,1)

		CIf(FP,Gun_Line(7,AtMost,0),Gun_SetLine(7,Add,240))
			CAdd(FP,G_CA_Y,64)
			for i = 0, 1 do
				for l = 1, 3 do
					f_TempRepeat({Gun_Line(8,Exactly,i),CD(GMode,l)},68,IonCUTable[l],nil,nil,"CG")
					CSPlotAct(IonShape,FP,IonCUTable2[l],0,{0,0},1,32,256,{Order(IonCUTable2[l],FP,1,Attack,4)},FP,{Label(),Gun_Line(8,Exactly,i),CD(GMode,l)},nil)
					CSPlotAct(IonShape2,FP,IonCUTable3[l],0,{0,0},1,32,256,{Order(IonCUTable3[l],FP,1,Attack,4)},FP,{Label(),Gun_Line(8,Exactly,i),CD(GMode,l)},nil)
				end
			end
			DoActionsX(FP,{Gun_SetLine(8,Add,1)})
		CIfEnd()
		TriggerX(FP,{Gun_Line(8,AtLeast,2)},{Gun_DoSuspend(),AddCD(IonCcode,1)},{Preserved})
	CIfEnd()
	CIf_GCase(116)
	
	CIf(FP,Gun_Line(7,AtMost,0),Gun_SetLine(7,Add,120))
	FaciCUTable = {3,6,11}
	FaciCUTable2 = {7,15,30}
	FaciCUTable3 = {1,3,10}
	for l = 1, 3 do
		f_TempRepeat({Gun_Line(9,Exactly,0),CD(GMode,l)},28,FaciCUTable[l],187,nil,"CG")
		f_TempRepeat({Gun_Line(9,Exactly,1),CD(GMode,l)},21,FaciCUTable2[l],187,nil,"CG")
		f_TempRepeat({CD(GMode,l)},25,FaciCUTable3[l],nil,nil,{1600,2144})
	end
	Simple_SetLocX(FP,0,G_CA_X,G_CA_Y,G_CA_X,G_CA_Y,{CreateUnit(5,84,1,FP),KillUnit(84,FP),})
	DoActionsX(FP,{Gun_SetLine(8,Add,1),Gun_SetLine(9,Add,1)})
	TriggerX(FP,{Gun_Line(9,AtLeast,2)},{Gun_SetLine(9,SetTo,0)},{Preserved})
	CIfEnd()
		TriggerX(FP,{Gun_Line(8,AtLeast,10)},{Gun_DoSuspend(),AddCD(FaciCcode,1)},{Preserved})
	CIfEnd()
	CIf_GCase(150)
	CIf(FP,Gun_Line(7,AtMost,0),Gun_SetLine(7,Add,360))
	ChryShape1 = CSMakePolygon(4,192,0,PlotSizeCalc(4,2),0)
	ChryShape2 = CSMakePolygon(4,164,0,PlotSizeCalc(4,3),0)
	ChryShape3 = CSMakePolygon(4,96,0,PlotSizeCalc(4,5),0)
	CSPlot(ChryShape1,FP,25,0,nil,1,32,FP,{Label(),CD(GMode,1)},nil,1)
	CSPlot(ChryShape2,FP,25,0,nil,1,32,FP,{Label(),CD(GMode,2)},nil,1)
	CSPlot(ChryShape3,FP,25,0,nil,1,32,FP,{Label(),CD(GMode,3)},nil,1)
	DoActionsX(FP,{Gun_SetLine(8,Add,1)})
	CIfEnd()
	TriggerX(FP,{Gun_Line(8,AtLeast,3)},{Gun_DoSuspend(),AddCD(ChryCcode,1)},{Preserved})
	CIfEnd()
	CIf_GCase(154)
	CIf(FP,Gun_Line(7,AtMost,0),Gun_SetLine(7,Add,90))
	NexCUTable1 = {5,10,30}
	NexCUTable2 = {1,2,5}
	for l = 1, 3 do
		f_TempRepeat({CD(GMode,l)},88,NexCUTable1[l],nil,nil,"CG")
		f_TempRepeat({CD(GMode,l)},80,NexCUTable2[l],nil,nil,"CG")
	end
	DoActionsX(FP,{Gun_SetLine(8,Add,1)})
	CIfEnd()
	TriggerX(FP,{Gun_Line(8,AtLeast,6)},{Gun_DoSuspend(),AddCD(NexCcode,1)},{Preserved})

	CIfEnd()

	CIf_GCase(151)
	CIf(FP,Gun_Line(7,AtMost,0),{Gun_SetLine(7,Add,20),CreateUnit(5,84,1,FP),KillUnit(84,FP)})
	CereCUTable = {1,3,10}
	for l = 1, 3 do
		f_TempRepeat({Gun_Line(9,Exactly,0),CD(GMode,l)},88,CereCUTable[l],187,nil,"CG")
	end
	DoActionsX(FP,{Gun_SetLine(8,Add,1)})
	CIfEnd()
	TriggerX(FP,{Gun_Line(8,AtLeast,20)},{Gun_DoSuspend(),AddCD(CereCcode,1)},{Preserved})
	CIfEnd()
	CIf_GCase(130)
	CIf(FP,Gun_Line(7,AtMost,0),{Gun_SetLine(7,Add,20),CreateUnit(5,84,1,FP),KillUnit(84,FP)})
	CenCUTable = {1,3,10}
	for l = 1, 3 do
		f_TempRepeat({Gun_Line(9,Exactly,0),CD(GMode,l)},21,CenCUTable[l],187,nil,"CG")
	end
	DoActionsX(FP,{Gun_SetLine(8,Add,1)})
	CIfEnd()
	TriggerX(FP,{Gun_Line(8,AtLeast,20)},{Gun_DoSuspend(),AddCD(CenCcode,1)},{Preserved})
	CIfEnd()



	CIf_GCase(201)
	DoActions(FP,{Simple_SetLoc(15,1600-256,2144-256,1600+256,2144+256)})
	TriggerX(FP,{Gun_Line(8,AtMost,62)},{
		Order(88,FP,16,Move,16),
		Order(21,FP,16,Move,16),
		SetMemoryX(0x666458, SetTo, 391,0xFFFF),CreateUnit(1,33,16,FP),
		KillUnit(33,FP),
		SetMemoryX(0x666458, SetTo, 546,0xFFFF)
	})
	CIf(FP,Gun_Line(7,AtMost,0),{Gun_SetLine(7,Add,10)})
	Shape8130 = {{4032, 3392},{3392, 3072},{3392, 3712},{2752, 3392}}
	Shape8151 = {{3072, 3232},{3072, 3552},{3712, 3552},{3712, 3232}}

	
	for i = 1, 4 do
		DoActions(FP,{Simple_SetLoc(0,Shape8130[i][1]-128,Shape8130[i][2]-128,Shape8130[i][1]+128,Shape8130[i][2]+128),CreateUnit(1,84,1,FP),KillUnit(84,FP)})
		TriggerX(FP,{Gun_Line(8,AtMost,39)},{CreateUnitWithProperties(1,21,1,FP,{invincible = true}),Order(21,FP,1,Move,16)},{Preserved})
		DoActions(FP,{Simple_SetLoc(0,Shape8151[i][1]-128,Shape8151[i][2]-128,Shape8151[i][1]+128,Shape8151[i][2]+128),CreateUnit(1,72,1,FP),KillUnit(72,FP)})
		TriggerX(FP,{Gun_Line(8,AtMost,39)},{CreateUnitWithProperties(1,88,1,FP,{invincible = true}),Order(88,FP,1,Move,16)},{Preserved})
	end
	TriggerX(FP,{Gun_Line(8,AtLeast,63),Gun_Line(8,AtMost,68)},{SetCp(FP),RunAIScriptAt(JYD,16)},{Preserved})
	TriggerX(FP,{Gun_Line(8,Exactly,69)},{Order(88,FP,16,Attack,4),Order(21,FP,16,Attack,4),CreateUnit(5,84,16,FP),KillUnit(84,FP),SetInvincibility(Disable,88,FP,64),SetInvincibility(Disable,21,FP,64)},{Preserved})

	DoActionsX(FP,{Gun_SetLine(8,Add,1)})
	CIfEnd()
	TriggerX(FP,{Gun_Line(8,AtLeast,70)},{Gun_DoSuspend(),AddCD(CocoonCcode,1)},{Preserved})
	CIfEnd()

	CIf_GCase(200)
		CIf(FP,Gun_Line(7,AtMost,0),Gun_SetLine(7,Add,400))
			FaciCUTable = {3,6,11}
			FaciCUTable2 = {7,15,30}
			FaciCUTable3 = {1,3,10}
			FaciPosArr = {
				{2336,2144},{864,2144},{1600,2528},{1600,1760}
			}
			CSPlot(ChryShape1,FP,25,0,nil,1,32,FP,{Label(),Gun_Line(8,Exactly,4),CD(GMode,1)},nil,1)
			CSPlot(ChryShape2,FP,25,0,nil,1,32,FP,{Label(),Gun_Line(8,Exactly,4),CD(GMode,2)},nil,1)
			CSPlot(ChryShape3,FP,25,0,nil,1,32,FP,{Label(),Gun_Line(8,Exactly,4),CD(GMode,3)},nil,1)
			for l = 1, 3 do
				for j, k in pairs(FaciPosArr) do
					f_TempRepeat({Gun_Line(9,Exactly,0),Gun_Line(8,AtMost,3),CD(GMode,l)},28,FaciCUTable[l],187,nil,k)
					f_TempRepeat({Gun_Line(9,Exactly,1),Gun_Line(8,AtMost,3),CD(GMode,l)},21,FaciCUTable2[l],187,nil,k)
					f_TempRepeat({Gun_Line(8,Exactly,4),CD(GMode,l)},98,FaciCUTable2[l],187,nil,k)
				end
			end
			
			DoActionsX(FP,{Gun_SetLine(8,Add,1),Gun_SetLine(9,Add,1)})
			TriggerX(FP,{Gun_Line(9,AtLeast,2)},{Gun_SetLine(9,SetTo,0)},{Preserved})
		CIfEnd()
		GeneActArr={}
		for j, k in pairs(FaciPosArr) do
			table.insert(GeneActArr,Simple_SetLoc(0,k[1],k[2],k[1],k[2]))
			table.insert(GeneActArr,CreateUnit(1,84,1,FP))
		end
		DoActions(FP,{GeneActArr,KillUnit(84,FP)})
		TriggerX(FP,{Gun_Line(8,AtLeast,5)},{Gun_DoSuspend(),AddCD(GeneCcode,1)},{Preserved})

	CIfEnd()
	CIf_GCase(147)
	DoActionsX(FP,{Gun_SetLine(7,Add,2)})
	TriggerX(FP,{Gun_Line(7,AtLeast,NBYD[1]/15)},{Gun_DoSuspend(),SetCD(OverGCcode,1)})
	G_CA_SetSpawn(CD(GMode,1),{56},"ACAS","NBYD",15,147,nil,FP,1)
	G_CA_SetSpawn(CD(GMode,2),{88},"ACAS","NBYD",15,147,nil,FP,1)
	G_CA_SetSpawn(CD(GMode,3),{98},"ACAS","NBYD",15,147,nil,FP,1)
	CIfEnd()

	CIf_GCase(148)
		CIf(FP,Gun_Line(7,AtMost,0),{Gun_SetLine(7,Add,400)})
		OvrmLinkArr = {
			{4000,2016},{3968,2752}
		}
		OverLinkCUTable = {
			{{55,25},{54,{25,15,5}},{53,{15,15,5}},{17,{2,4,10}},{10,{2,4,10}}},
			{{48,{25,15,10}},{56,25},{19,{3,6,15}}},
			{{51,{25,20,15}},{104,{25,20,15}},{21,{4,9,25}},{25,{2,4,10}}}
		}

		for j, k in pairs(OverLinkCUTable) do
			for l,m in pairs(k) do
				if type(m[2]) == "table" then
					for o,p in pairs(m[2]) do
						for i = 1, #OvrmLinkArr do
						f_TempRepeat({Gun_Line(3,Exactly,1),Gun_Line(8,Exactly,j-1),CD(GMode,o)},m[1],p,nil,nil,OvrmLinkArr[i])
						end
						f_TempRepeat({Gun_Line(3,Exactly,1),Gun_Line(8,Exactly,j-1),CD(GMode,o)},m[1],p,nil,nil,"CG")
					end
				else
					for i = 1, #OvrmLinkArr do
					f_TempRepeat({Gun_Line(3,Exactly,1),Gun_Line(8,Exactly,j-1)},m[1],m[2],nil,nil,OvrmLinkArr[i])
					end
					f_TempRepeat({Gun_Line(3,Exactly,1),Gun_Line(8,Exactly,j-1)},m[1],m[2],nil,nil,"CG")
				end
			end
		end
		OvrmLinkArr2 = {
			{2464,2720},{3200,2304}
		}
		OverLinkCUTable2 = {
			{{55,25},{54,{25,15,5}},{53,{15,15,5}},{77,{2,4,10}},{78,{2,4,10}}},
			{{48,{25,15,10}},{56,25},{75,{2,4,10}},{79,{2,4,10}}},
			{{51,{25,20,15}},{104,{25,20,15}},{88,{4,9,25}},{76,{2,4,10}}}
		}

		for j, k in pairs(OverLinkCUTable2) do
			for l,m in pairs(k) do
				if type(m[2]) == "table" then
					for o,p in pairs(m[2]) do
						for i = 1, #OvrmLinkArr2 do
						f_TempRepeat({Gun_Line(3,Exactly,2),Gun_Line(8,Exactly,j-1),CD(GMode,o)},m[1],p,nil,nil,OvrmLinkArr2[i])
						end
						f_TempRepeat({Gun_Line(3,Exactly,2),Gun_Line(8,Exactly,j-1),CD(GMode,o)},m[1],p,nil,nil,"CG")
					end
				else
					for i = 1, #OvrmLinkArr2 do
					f_TempRepeat({Gun_Line(3,Exactly,2),Gun_Line(8,Exactly,j-1)},m[1],m[2],nil,nil,OvrmLinkArr2[i])
					end
					f_TempRepeat({Gun_Line(3,Exactly,2),Gun_Line(8,Exactly,j-1)},m[1],m[2],nil,nil,"CG")
				end
			end
		end

		DoActionsX(FP,{Gun_SetLine(8,Add,1)})
		CIfEnd()
		DoActionsX(FP,{Gun_SetLine(9,Subtract,1)})
		CIf(FP,Gun_Line(9,AtMost,0),{Gun_SetLine(9,Add,50)})
			OvrMineActArr = {}
			OvrMinePosArr = {
				{3776,2368},{3712,2144},{3904,2752}
			}
			for j, k in pairs(OvrMinePosArr) do
				table.insert(OvrMineActArr,Simple_SetLoc(0,k[1],k[2],k[1],k[2]))
				table.insert(OvrMineActArr,CreateUnit(1,13,1,FP))
			end
			OvrMineActArr2 = {}
			OvrMinePosArr2 = {
				{2848,2432},{2752,2720},{2944,2624}
			}
			for j, k in pairs(OvrMinePosArr2) do
				table.insert(OvrMineActArr2,Simple_SetLoc(0,k[1],k[2],k[1],k[2]))
				table.insert(OvrMineActArr2,CreateUnit(1,13,1,FP))
			end
			Trigger2X(FP,{Gun_Line(3,Exactly,1)},OvrMineActArr,{Preserved})
			Trigger2X(FP,{Gun_Line(3,Exactly,2)},OvrMineActArr2,{Preserved})
		DoActionsX(FP,{Gun_SetLine(10,Add,1)})
		CIfEnd()
		TriggerX(FP,{Gun_Line(8,AtLeast,3)},{Gun_DoSuspend(),AddCD(OvrmCcode,1)},{Preserved})
	CIfEnd()
	CIf_GCase(190)
	PsiCUTable = {
	{55,56,55,56,55,56},
	{55,56,88,21,28,64},
	{88,21,28,64,86,98}}
	CIf(FP,Gun_Line(7,AtMost,0),{Gun_SetLine(7,Add,480)})

	for i = 0 ,5 do
		for l=1, 3 do
			if i%2 == 0 then
				G_CA_SetSpawn({CD(GMode,l),Gun_Line(8,Exactly,i)},{PsiCUTable[l][i+1]},"ACAS","LeftLine","MAX",190,{64,2048},FP,1)
	
			else
				G_CA_SetSpawn({CD(GMode,l),Gun_Line(8,Exactly,i)},{PsiCUTable[l][i+1]},"ACAS","SouthLine","MAX",190,{2048,4096},FP,1)
			end
		end
	end
	DoActionsX(FP,{Gun_SetLine(8,Add,1),Gun_SetLine(9,Add,1)})
	CIfEnd()
	TriggerX(FP,{Gun_Line(8,AtLeast,6)},{Gun_DoSuspend(),AddCD(PsiCcode,1)},{Preserved})
		
	CIfEnd()
	CIf_GCase(173)
		DoActions(FP,{CreateUnit(1,84,1,FP),KillUnit(84,FP)})
		CIf(FP,Gun_Line(7,AtMost,0),{Gun_SetLine(7,Add,50),Gun_SetLine(8,Add,1)})
			DoActions2(FP,{RotatePlayer({MinimapPing(1)},HumanPlayers,FP),SetMemoryX(0x666458, SetTo, 391,0xFFFF),})
			FormShape = {4,{-12*32,0},{0,-6*32},{12*32,0},{0,6*32}}
			CSPlot(FormShape,FP,33,0,nil,1,32,FP,nil,{KillUnit(33,FP)},1)
		CIfEnd(SetMemoryX(0x666458, SetTo, 546,0xFFFF))
		CSPlot(FormShape,FP,72,0,nil,1,32,FP,{Label(),Gun_Line(8,AtLeast,20)},{KillUnit(72,FP)},1)
		Trigger2X(FP,{Gun_Line(8,AtLeast,20)},{RotatePlayer({PlayWAVX("staredit\\wav\\seeya.ogg"),PlayWAVX("staredit\\wav\\seeya.ogg")},HumanPlayers,FP),Gun_DoSuspend(),KillUnitAt(All,125,21,AllPlayers),AddCD(FormCcode,1)},{Preserved})
	CIfEnd()
	
	CIf_GCase(168)
	DoActionsX(FP,Gun_SetLine(7,Add,2))
	TriggerX(FP,{Gun_Line(3,Exactly,1),Gun_Line(7,AtLeast,Cell1[1])},{Gun_DoSuspend(),AddCD(CellCcode,1)})
	TriggerX(FP,{Gun_Line(3,Exactly,2),Gun_Line(7,AtLeast,Cell2[1])},{Gun_DoSuspend(),AddCD(CellCcode,1)})
	TriggerX(FP,{Gun_Line(3,Exactly,3),Gun_Line(7,AtLeast,Cell3[1])},{Gun_DoSuspend(),AddCD(CellCcode,1)})
	G_CA_SetSpawn({Gun_Line(3,Exactly,1)},{84},"ACAS","Cell1",1,84,{0,0},FP,1)
	G_CA_SetSpawn({Gun_Line(3,Exactly,2)},{84},"ACAS","Cell2",1,84,{0,0},FP,1)
	G_CA_SetSpawn({Gun_Line(3,Exactly,3)},{84},"ACAS","Cell3",1,84,{0,0},FP,1)

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
			CMov(FP,TempV,f_GunStrPtr,f_GunT[2])
			f_Movcpy(FP,TempV,VArr(f_GunNumT,0),4*4)
			DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0Df_Gun".._0D,4)},HumanPlayers,FP)})
			CIfEnd()
		end
	CIfEnd()

	
	SetCallEnd()
end