﻿
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
	f_GunForceOption = CreateCcode()
	
	table.insert(CtrigInitArr[FP+1],SetCtrigX(FP,G_InputH[2],0x15C,0,SetTo,FP,CIndex,0x15C,1,0))--{"X",0x500,0x15C,1,0}--G_InputH
	SetCall(FP)
		f_SaveCp()
		CIf(FP,{CD(f_GunForceOption,0)})
		f_Read(FP,_Sub(BackupCp,15),CPos)
		f_Read(FP,BackupCp,GunID,"X",0xFF,1)
		f_Read(FP,_Sub(BackupCp,6),GunPlayer,"X",0xFF)
		CIfEnd()

		CIf(FP, {TTOR({CV(GunPlayer,7),CV(GunID,119)})}) -- P8건물과 탄막유닛만 건작으로 작동
		function GunBGM(ID,Type,Text,Point,OtherTrig,GNum)
			Act = {}
			if GNum ~= nil then Act = {CV(DUnitCalc[4][3],GNum)} end
			local GText = "\n\n\n\n\n"..StrDesignX(Text.." \x04을(를) 파괴하였습니다\x17 + "..Point.." P t s").."\n\n"
			if Type == nil then
				TriggerX(FP,{CV(GunID,ID),Act},{SetScore(Force1,Add,Point,Kills),RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP),OtherTrig},{preserved})
			else
				TriggerX(FP,{CV(GunID,ID),Act},{SetScore(Force1,Add,Point,Kills),SetV(BGMType,Type),RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP),OtherTrig},{preserved})
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
		GunBGM(200,11,"\x03N\x04ew\x03G\x04ame\x03S\x04tart",500000)
		GunBGM(150,12,"\x1FO\x04ver \x1FM\x04e",13737)
		GunBGM(201,13,"\x08E\x04nemy \x08S\x04torm",250000)
		GunBGM(160,14,"\x1CD\x04iomedes",80000)
		GunBGM(167,15,"\x11D\x04ream \x11i\x04t",80000)
		GunBGM(126,16,"\x1CB\x04lyth\x1CE",250000)
		GunBGM(174,17,"\x08B\x04lack \x08S\x04wan",250000)
		GunBGM(127,18,"\x0FL\x04auncher",300000)
		GunBGM(106,19,"\x1FM\x04iles",150000)
		GunBGM(168,20,"\x1BD\x04on't \x1BD\x04ie",444444)
		GunBGM(154,21,"\x11D\x04aydream",150000)
		GunBGM(190,22,"\x08H\x04ell\'o",150000,nil,1)
		GunBGM(190,25,"\x08O\x04\'men",150000,nil,2)
		GunBGM(175,23,"\x1DL\x04ENA \x1DT\x04ower",555555)
		GunBGM(147,23,"\x08D\x04IE \x08I\x04N",555555)
		GunBGM(152,24,"\x1FR\x04e:\x1FB\x04IRTH",444444)
		
		
		
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
		CallTriggerX(FP,G_Send,{DeathsX(CurrentPlayer,Exactly,UnitID,0,0xFF)},{Actions,SetCD(f_GunForceOption,0)})
	end
	function f_GunForceSend(UnitID,GP,GPos,GNum,Conditions,Actions,Preserve)--죽은유닛 인식이 아닌 트리거로 강제 입력
		CallTriggerX(FP,G_Send,Conditions,{Actions,SetCD(f_GunForceOption,1),SetV(CPos,GPos),SetV(GunID,UnitID),SetV(GunPlayer,GP),SetV(DUnitCalc[4][3],GNum)},Preserve)
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
	function CIf_GCase(Index,ForceOption)
		CIf(FP,{Gun_Line(0,Exactly,Index),Gun_Line(54,AtMost,0)},{SetCD(GunCaseCheck,1)})
		if ForceOption ~= 1 then
		table.insert(f_GunTable,Index)
		end
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
	CMov(FP,G_CB_X,Var_TempTable[2])
	CMov(FP,G_CB_Y,Var_TempTable[3])
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

function Gen2Gun(CUTable1,CUTable2,GunNm,ShapeHD,ShapeSC,ZunitSh1,ZunitShLV1,ZunitSh2,ZunitShLV2,RotateOption)
	CIf(FP,GNm(GunNm))
	if RotateOption ==  1 then
		G_CB_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, CUTable1, "ACAS", ShapeHD, 0, 0, nil, nil, P7)
		G_CB_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2)}, CUTable1, "ACAS", ShapeSC, 0, 0, nil, nil, P7)
		G_CB_TSetSpawn({Gun_Line(5,Exactly,0),CD(GMode,3)}, CUTable1, _G[ShapeSC], nil, {OwnerTable=P7,RotateTable="Main",RepeatType={"Attack_Gun","Attack_Gun","Attack_Gun","Attack_Gun"}})
		G_CB_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,1)}, CUTable2, "ACAS", ShapeHD, 0, 0, nil, nil, P7)
		G_CB_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2)}, CUTable2, "ACAS", ShapeSC, 0, 0, nil, nil, P7)
		G_CB_TSetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,3)}, CUTable2, _G[ShapeSC], nil, {OwnerTable=P7,RotateTable="Main",RepeatType={"Attack_Gun","Attack_Gun","Attack_Gun","Attack_Gun"}})
	else
		G_CB_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, CUTable1, "ACAS", ShapeHD, 0, 0, nil, nil, P7)
		G_CB_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2)}, CUTable1, "ACAS", ShapeSC, 0, 0, nil, nil, P7)
		G_CB_TSetSpawn({Gun_Line(5,Exactly,0),CD(GMode,3)}, CUTable1, _G[ShapeSC], nil, {OwnerTable=P7,RepeatType={"Attack_Gun","Attack_Gun","Attack_Gun","Attack_Gun"}})
		G_CB_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,1)}, CUTable2, "ACAS", ShapeHD, 0, 0, nil, nil, P7)
		G_CB_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2)}, CUTable2, "ACAS", ShapeSC, 0, 0, nil, nil, P7)
		G_CB_TSetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,3)}, CUTable2, _G[ShapeSC], nil, {OwnerTable=P7,RepeatType={"Attack_Gun","Attack_Gun","Attack_Gun","Attack_Gun"}})
	end

	G_CB_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2,AtMost)}, {55,53,54,46}, ZunitSh1,ZunitShLV1, 0, 0, nil, nil, P8)
	G_CB_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2,AtMost)}, {56,104,51,48}, ZunitSh2,ZunitShLV2, 0, 0, nil, nil, P8)
	G_CB_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,3)}, {55,53,54,46}, ZunitSh1,ZunitShLV1, 0, {"Attack_Gun","Attack_Gun","Attack_Gun","Attack_Gun"}, nil, nil, P8)
	G_CB_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,3)}, {56,104,51,48}, ZunitSh2,ZunitShLV2, 0, {"Attack_Gun","Attack_Gun","Attack_Gun","Attack_Gun"}, nil, nil, P8)
	CIfEnd()
end

function Gen2GunS(CUTable1,CUTable2,GunNm,ShapeHD,ShapeSC,ZunitSh1,ZunitSh2,CreateOneUnitID)
	CIf(FP,GNm(GunNm))

	G_CB_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, CUTable1, "ACAS", ShapeHD, 0, 0, nil, nil, P7)
	G_CB_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2)}, CUTable1, "ACAS", ShapeSC, 0, 0, nil, nil, P7)
	G_CB_TSetSpawn({Gun_Line(5,Exactly,0),CD(GMode,3)}, CUTable1, _G[ShapeSC], nil, {OwnerTable=P7,RepeatType={"Attack_Gun","Attack_Gun","Attack_Gun","Attack_Gun"}})
	G_CB_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,1)}, CUTable2, "ACAS", ShapeHD, 0, 0, nil, nil, P7)
	G_CB_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2)}, CUTable2, "ACAS", ShapeSC, 0, 0, nil, nil, P7)
	G_CB_TSetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,3)}, CUTable2, _G[ShapeSC], nil, {OwnerTable=P7,RepeatType={"Attack_Gun","Attack_Gun","Attack_Gun","Attack_Gun"}})

	G_CB_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2,AtMost)}, {55,53,54,46}, "ACAS" ,ZunitSh1, 0, 0, nil, nil, P8)
	G_CB_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2,AtMost)}, {56,104,51,48}, "ACAS" ,ZunitSh2, 0, 0, nil, nil, P8)
	G_CB_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,3)}, {55,53,54,46}, "ACAS" ,ZunitSh1, 0, {"Attack_Gun","Attack_Gun","Attack_Gun","Attack_Gun"}, nil, nil, P8)
	G_CB_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,3)}, {56,104,51,48}, "ACAS" ,ZunitSh2, 0, {"Attack_Gun","Attack_Gun","Attack_Gun","Attack_Gun"}, nil, nil, P8)
	f_TempRepeat({Gun_Line(6,AtLeast,1),CD(GMode,3)},CreateOneUnitID,1,14,P6)
	CIfEnd()
end

	
	CIf_GCase(131)--해처리
	G_CB_SetSpawn({GNm(1),Gun_Line(5,Exactly,0)}, {43,37,38,39}, P_5, 2, 0, 0, nil, nil, P7)
	G_CB_SetSpawn({GNm(1),Gun_Line(6,AtLeast,1)}, {44,46,38,39}, P_5, 2, 0, 0, nil, nil, P7)
	
	G_CB_SetSpawn({GNm(2),Gun_Line(5,Exactly,0)}, {43,37,38,39}, S_5, 1, 0, 0, nil, nil, P7)
	G_CB_SetSpawn({GNm(2),Gun_Line(6,AtLeast,1)}, {44,46,38,39}, S_5, 1, 0, 0, nil, nil, P7)
	
	G_CB_SetSpawn({GNm(3),Gun_Line(5,Exactly,0)}, {43,37,38,39}, P_6, 2, 0, 0, nil, nil, P7)
	G_CB_SetSpawn({GNm(3),Gun_Line(6,AtLeast,1)}, {44,46,38,39}, P_6, 2, 0, 0, nil, nil, P7)
	
	G_CB_SetSpawn({GNm(4),Gun_Line(5,Exactly,0)}, {43,37,38,39}, S_3, 2, 0, 0, nil, nil, P7)
	G_CB_SetSpawn({GNm(4),Gun_Line(6,AtLeast,1)}, {44,46,38,39}, S_3, 2, 0, 0, nil, nil, P7)
	
	G_CB_SetSpawn({GNm(5),Gun_Line(5,Exactly,0)}, {43,37,38,39}, S_6, 1, 0, 0, nil, nil, P7)
	G_CB_SetSpawn({GNm(5),Gun_Line(6,AtLeast,1)}, {44,46,38,39}, S_6, 1, 0, 0, nil, nil, P7)
	CIfEnd()
	CIf_GCase(132)--레어
	G_CB_SetSpawn({GNm(1),Gun_Line(5,Exactly,0)}, {55,53,54,46}, P_6, 2, 0, 0, nil, nil, P7)
	G_CB_SetSpawn({GNm(1),Gun_Line(6,AtLeast,1)}, {56,104,51,48}, P_6, 2, 0, 0, nil, nil, P7)
	
	G_CB_SetSpawn({GNm(2),Gun_Line(5,Exactly,0)}, {55,53,54,46}, S_3, 2, 0, 0, nil, nil, P7)
	G_CB_SetSpawn({GNm(2),Gun_Line(6,AtLeast,1)}, {56,104,51,48}, S_3, 2, 0, 0, nil, nil, P7)
	
	G_CB_SetSpawn({GNm(3),Gun_Line(5,Exactly,0)}, {55,53,54,46}, S_6, 1, 0, 0, nil, nil, P7)
	G_CB_SetSpawn({GNm(3),Gun_Line(6,AtLeast,1)}, {56,104,51,48}, S_6, 1, 0, 0, nil, nil, P7)
	
	G_CB_SetSpawn({GNm(4),Gun_Line(5,Exactly,0)}, {55,53,54,46}, P_4, 3, 0, 0, nil, nil, P7)
	G_CB_SetSpawn({GNm(4),Gun_Line(6,AtLeast,1)}, {56,104,51,48}, P_4, 3, 0, 0, nil, nil, P7)

	Gen2GunS({"Division"},{"Destroy"},5,"LSHD","LSSC","LSFill","LSFill","EL FAIL")
	Gen2GunS({"Deaths"},{"Division"},6,"LSHD","LSSC","LSFill","LSFill","DIEIN")
	Gen2GunS({"Zero"},{"Deaths"},7,"LSHD","LSSC","LSFill","LSFill","PLAY")
	Gen2GunS({"Identity"},{"Zero"},8,"LSHD","LSSC","LSFill","LSFill","EL CLEAR")
	Gen2GunS({"Destroy"},{"Identity"},9,"LSHD","LSSC","LSFill","LSFill","LENA")
	
	
	CIfEnd()


	CIf_GCase(133)--하이브
	CIf(FP,GNm(1))
	G_CB_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, {21,17}, {P_8,S_4}, {0,0}, 0, 0, nil, nil, P7)
	G_CB_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {21,17}, {S_5,P_5}, {1,2}, 0, 0, nil, nil, P7)
	G_CB_SetSpawn({Gun_Line(5,Exactly,0)}, {55,53,54,46}, S_5, 1, 0, 0, nil, nil, P7)

	G_CB_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,1)}, {19,28}, {P_6,S_3}, {0,0}, 0, 0, nil, nil, P7)
	G_CB_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2,AtLeast)}, {19,28}, {P_6,S_3}, {2,2}, 0, 0, nil, nil, P7)
	G_CB_SetSpawn({Gun_Line(6,AtLeast,1)}, {56,104,51,48}, S_5, 1, 0, 0, nil, nil, P7)
	CIfEnd()

	CIf(FP,GNm(2))

	
	G_CB_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, {88,77}, {P_3,P_4}, {0,0}, 0, 0, nil, nil, P7)
	G_CB_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {88,77}, {P_3,P_5}, {3,2}, 0, 0, nil, nil, P7)
	G_CB_SetSpawn({Gun_Line(5,Exactly,0)}, {55,53,54,46}, P_6, 3, 0, 0, nil, nil, P7)

	G_CB_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,1)}, {78,86}, {P_7,P_8}, {0,0}, 0, 0, nil, nil, P7)
	G_CB_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2,AtLeast)}, {78,86}, {S_4,P_8}, {1,1}, 0, 0, nil, nil, P7)
	G_CB_SetSpawn({Gun_Line(6,AtLeast,1)}, {56,104,51,48}, P_6, 3, 0, 0, nil, nil, P7)

	
	CIfEnd()


	function Gen2GunH(CUTable1,CUTable2,GunNm,ShapeHD,ShapeSC,ZunitSh1,ZunitSh2,CreateOneUnitID,CenterXY)
		CIf(FP,GNm(GunNm))
		G_CB_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, CUTable1, "ACAS", ShapeHD, 0, 0, nil, CenterXY, P7)
		G_CB_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2)}, CUTable1, "ACAS", ShapeSC, 0, 0, nil, CenterXY, P7)
		G_CB_TSetSpawn({Gun_Line(5,Exactly,0),CD(GMode,3)}, CUTable1, _G[ShapeSC], nil, {OwnerTable=P7,RepeatType={"Attack_Gun","Attack_Gun","Attack_Gun","Attack_Gun"},CenterXY=CenterXY})
		G_CB_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,1)}, CUTable2, "ACAS", ShapeHD, 0, 0, nil, CenterXY, P7)
		G_CB_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2)}, CUTable2, "ACAS", ShapeSC, 0, 0, nil, CenterXY, P7)
		G_CB_TSetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,3)}, CUTable2, _G[ShapeSC], nil, {OwnerTable=P7,RepeatType={"Attack_Gun","Attack_Gun","Attack_Gun","Attack_Gun"},CenterXY=CenterXY})

		G_CB_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2,AtMost)}, {55,53,54,46}, "ACAS" ,ZunitSh1, 0, 0, nil, CenterXY, P8)
		G_CB_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2,AtMost)}, {56,104,51,48}, "ACAS" ,ZunitSh2, 0, 0, nil, CenterXY, P8)
		G_CB_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,3)}, {55,53,54,46}, "ACAS" ,ZunitSh1, 0, {"Attack_Gun","Attack_Gun","Attack_Gun","Attack_Gun"}, nil, CenterXY, P8)
		G_CB_SetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,3)}, {56,104,51,48}, "ACAS" ,ZunitSh2, 0, {"Attack_Gun","Attack_Gun","Attack_Gun","Attack_Gun"}, nil, CenterXY, P8)
		f_TempRepeat({Gun_Line(6,AtLeast,1),CD(GMode,3)},CreateOneUnitID,1,14,P6,CenterXY)
		CIfEnd()
	end
	
	
	--512,7824
	Gen2GunH({"Lizzet","Rophe"},{"Lizzet","Rophe"},3,"LSLineHD","LSLine","LSFill","LSFill","EL FAIL",{512,7696})
	Gen2GunH({"Merry","Sui"},{"Merry","Sui"},4,"LSLineHD","LSLine","LSFill","LSFill","DIEIN",{512,7696})
	Gen2GunH({"Rose","Shirley House"},{"Rose","Shirley House"},5,"LSLineHD","LSLine","LSFill","LSFill","PLAY",{512,7696})
	Gen2GunH({"Norad II","Jisoo"},{"Norad II","Jisoo"},6,"LSLineHD","LSLine","LSFill","LSFill","EL CLEAR",{512,7696})
	Gen2GunH({"Era","Yuri"},{"Era","Yuri"},7,"LSLineHD","LSLine","LSFill","LSFill","LENA",{512,7696})
	--1536,7824
	Gen2GunH({"Nina","Freyja"},{"Nina","Freyja"},8,"LSLineHD","LSLine","LSFill","LSFill","EL FAIL",{1536,7696})
	Gen2GunH({"Sera","Kamilia"},{"Sera","Kamilia"},9,"LSLineHD","LSLine","LSFill","LSFill","DIEIN",{1536,7696})
	Gen2GunH({"Sorang","Sadol"},{"Sorang","Sadol"},10,"LSLineHD","LSLine","LSFill","LSFill","PLAY",{1536,7696})
	Gen2GunH({"Sena","Gaya"},{"Sena","Gaya"},11,"LSLineHD","LSLine","LSFill","LSFill","EL CLEAR",{1536,7696})
	Gen2GunH({"Sen","Leon"},{"Sen","Leon"},12,"LSLineHD","LSLine","LSFill","LSFill","LENA",{1536,7696})




	CIfEnd()

	
	--ZUnit : S_5, 2 : 61
	--ZUnit : P_6, 3 : 61
	-- EnBayHD1 HD 9
	-- EnBaySC1 MXSC 36
	CIf_GCase(122)--엔베

	Gen2Gun({75,88}, {75,88},1,"EnBayHD1","EnBaySC1",S_5, 2, P_6, 3)
	--P_5, 3 : 51
	--S_5, 2 : 61
	Gen2Gun({"Kazansky","Raynor V"},{"Kazansky","Raynor V"},2,"EnBayHD1","EnBaySC1",P_5, 3, S_5, 2)
	--P_3, 4 : 46
	--P_8, 2 : 49
	Gen2Gun({"Schezar","Hyperion"},{"Schezar","Hyperion"},3,"EnBayHD1","EnBaySC1",P_3, 4, P_8, 2)
	--S_4, 2 : 49
	--S_8, 1 : 49
	Gen2Gun({"Fenix Z","Lin"},{"Fenix D","Lin"},4,"EnBayHD1","EnBaySC1",S_4, 2, S_8, 1)
	
	--S_7, 1 : 43
	--P_3, 4 : 46
	Gen2Gun({"Tassadar","Envy"},{"Tassadar","Envy"},5,"EnBayHD1","EnBaySC1",S_7, 1, P_3, 4)
	--P_8, 2 : 49
	--S_4, 2 : 49
	Gen2Gun({"Raszagal","Darly"},{"Raszagal","Darly"},6,"EnBayHD1","EnBaySC1",P_8, 2, S_4, 2)
	
	--S_5, 2 : 61
	--P_6, 3 : 61
	Gen2Gun({"Lizzet","Rophe"}, {"Lizzet","Rophe"},7,"EnvShVHD","EnvShVSC",S_5, 2, P_6, 3,1)
	--P_4, 4 : 61
	--S_3, 3 : 61
	Gen2Gun({"Merry","Sui"}, {"Merry","Sui"},8,"EnvShVHD","EnvShVSC",P_4, 4, S_3, 3,1)
	--P_3, 5 : 64
	--P_7, 3 : 71
	Gen2Gun({"Rose","Shirley House"}, {"Rose","Shirley House"},9,"EnvShVHD","EnvShVSC",P_3, 5, P_7, 3,1)
	CIfEnd()

	-- FacHD1 HD 9
	-- FacSC1 MXSC 36
	CIf_GCase(113)--팩
	--P_8, 3 : 81
	--S_4, 3 : 81
	Gen2Gun({75,88},{75,88},1,"FacHD1","FacSC1",P_8, 3, S_4, 3)
	--P_3, 5 : 64
	--P_7, 3 : 71
	Gen2Gun({"Kazansky","Raynor V"},{"Kazansky","Raynor V"},2,"FacHD1","FacSC1",P_3, 5, P_7, 3)
	--S_6, 2 : 73
	--P_5, 4 : 76
	Gen2Gun({"Schezar","Hyperion"},{"Schezar","Hyperion"},3,"FacHD1","FacSC1",S_6, 2, P_5, 4)
	--P_4, 5 : 85
	--P_3, 6 : 85
	Gen2Gun({"Fenix Z","Lin"},{"Fenix Z","Lin"},4,"FacHD1","FacSC1",P_4, 5, P_3, 6)
	--P_6, 4 : 91
	--S_8, 2 : 97
	Gen2Gun({"Archon","Norad II"},{"Archon","Norad II"},5,"FacHD1","FacSC1",P_6, 4, S_8, 2)
	CIfEnd()
	

	CIf_GCase(116)--퍼실
	--PaciShHD,PaciShSC
	--P_5, 4 : 76
	--P_8, 3 : 81
	Gen2Gun({"Lizzet","Rophe"},{"Lizzet","Rophe"},1,"PaciShHD","PaciShSC",P_5, 4, P_8, 3,1)
	--S_4, 3 : 81
	--P_4, 5 : 85
	Gen2Gun({"Sera","Freyja"},{"Sera","Freyja"},2,"PaciShHD","PaciShSC",S_4, 3, P_4, 5,1)
	--P_3, 6 : 85
	--S_7, 2 : 85
	Gen2Gun({"Sen","Kamilia"},{"Sen","Kamilia"},3,"PaciShHD","PaciShSC",P_3, 6, S_7, 2,1)
	CIfEnd()
	CIf_GCase(114)--스타포트
	--STCirHD
	--STCirSC
	--P_3, 5 : 64
	--P_7, 3 : 71
	Gen2Gun({"Norad II","Jisoo"},{"Norad II","Jisoo"},1,"STCirHD","STCirSC",P_3, 5, P_7, 3,1)
	--S_6, 2 : 73
	--P_5, 4 : 76
	Gen2Gun({"Era","Yuri"},{"Era","Yuri"},2,"STCirHD","STCirSC",S_6, 2, P_5, 4,1)
	--P_8, 3 : 81
	--S_4, 3 : 81
	Gen2Gun({"Nina","Sadol"},{"Nina","Sadol"},3,"STCirHD","STCirSC",P_8, 3, S_4, 3,1)

	CIfEnd()
	CIf_GCase(160)--게이트
	
	--P_3, 6 : 85
	--S_7, 2 : 85
	Gen2Gun({"Darly","Raszagal"},{"Darly","Raszagal"},1,"GateHD1","GateSC1",P_3, 6, S_7, 2)
	--P_5, 4 : 76
	--P_8, 3 : 81
	Gen2Gun({"Archon","Artanis"},{"Archon","Artanis"},2,"GateHD1","GateSC1",P_5, 4, P_8, 3)
	--P_3, 5 : 64
	--P_7, 3 : 71
	Gen2Gun({"Tassadar","Lin"},{"Tassadar","Lin"},3,"GateHD1","GateSC1",P_3, 5, P_7, 3)
	--P_7, 3 : 71
	--S_6, 2 : 73
	Gen2Gun({"Fenix D","Danimoth"},{"Fenix D","Danimoth"},4,"GateHD1","GateSC1",P_7, 3, S_6, 2)
	CIfEnd()

	CIf_GCase(167)--스타게이트
	--P_4, 4 : 61
	--S_3, 3 : 61
	Gen2Gun({"Yumi","Envy"},{"Yumi","Envy"},3,"STGateHD1","STGateSC1",P_4, 4, S_3, 3)
	--P_3, 5 : 64
	--P_7, 3 : 71
	Gen2Gun({"Yuna","Raszagal"},{"Yuna","Raszagal"},2,"STGateHD1","STGateSC1",P_3, 5, P_7, 3)
	--P_5, 5 : 106
	--P_7, 4 : 106
	Gen2Gun({"Yona","Lizzet"},{"Yona","Lizzet"},1,"STGateHD1","STGateSC1",P_5, 5, P_7, 4)


	CIfEnd()
	CIf_GCase(154)--넥서스
	
	

	function Gen2GunN(CUTable1,CUTable2,CUTable3,CUTable4,GunNm,HDSh1,SCSh1,HDSh2,SCSh2,CX,CY)
	CIf(FP,GNm(GunNm))
	G_CB_TSetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, CUTable1, HDSh1, nil, {OwnerTable=P8,LMTable="MAX"})
	G_CB_TSetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, CUTable1, SCSh1, nil, {OwnerTable=P7,LMTable="MAX"})
	G_CB_TSetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, CUTable3, HDSh2, nil, {OwnerTable=P8,LMTable="MAX",SizeTable=150,CenterXY={CX,CY}})
	G_CB_TSetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, CUTable3, SCSh2, nil, {OwnerTable=P7,LMTable="MAX",SizeTable=150,CenterXY={CX,CY}})

	G_CB_TSetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,1)}, CUTable2, HDSh1, nil, {OwnerTable=P8,LMTable="MAX"})
	G_CB_TSetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2,AtLeast)}, CUTable2, SCSh1, nil, {OwnerTable=P7,LMTable="MAX"})
	G_CB_TSetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,1)}, CUTable4, HDSh2, nil, {OwnerTable=P8,LMTable="MAX",SizeTable=150,CenterXY={CX,CY}})
	G_CB_TSetSpawn({Gun_Line(6,AtLeast,1),CD(GMode,2,AtLeast)}, CUTable4, SCSh2, nil, {OwnerTable=P7,LMTable="MAX",SizeTable=150,CenterXY={CX,CY}})
	CIfEnd()
	end
	Gen2GunN({88,21},{28,84},{77,78},{17,19},2,S_4[2],S_4[3],P_6[3],P_6[5],1600,2640)
	Gen2GunN({98,58},{8,12},{83,95},{65,66},1,S_4[2],S_4[3],P_6[3],P_6[5],1712,3728)

	--
	--

	--
	--
	CIfEnd()

	CIf_GCase(130)--감커
	CenT2={88,21,86,84,98,58}
	for j,k in pairs(CenT2) do
		CIf(FP,GNm(j))
		G_CB_TSetSpawn({CD(GMode,1)},{k},{CenNM1},1,{LMTable = 1,RepeatType=130,CenterXY={0,0},OwnerTable=P6})
		G_CB_TSetSpawn({CD(GMode,1)},{k},{CenNM2},1,{LMTable = 1,RepeatType=130,CenterXY={0,0},OwnerTable=P6})
		G_CB_TSetSpawn({CD(GMode,2,AtLeast)},{k},{Cen1},1,{LMTable = 1,RepeatType=130,CenterXY={0,0},OwnerTable=P6})
		G_CB_TSetSpawn({CD(GMode,2,AtLeast)},{k},{Cen2},1,{LMTable = 1,RepeatType=130,CenterXY={0,0},OwnerTable=P6})
		CIfEnd()
		
	end
	CheckJump = def_sIndex()
		CIf(FP,{Gun_Line(7,AtLeast,480)},{Gun_DoSuspend()})
			CIf(FP, {CD(GMode,3)})
			CFor(FP, 0, 2048,64)
			local NI = CForVariable()
			CIf(FP,{TTOR({GNm(1),GNm(3),GNm(5)})})
			Simple_SetLocX(FP, 200, NI, 0, _Add(NI,64), 8192)
			DoActions(FP, {KillUnitAt(All,nilunit,201,FP),Simple_SetLoc(201, 0, 0, 0, 0)})
			NJumpX(FP, CheckJump,{Bring(Force1, AtLeast, 1, "Men", 201)},{MoveLocation(202, "Men", Force1, 201)})
			CIfEnd()
			CIf(FP,{TTOR({GNm(2),GNm(4),GNm(6)})})
			Simple_SetLocX(FP, 200, _Sub(_Mov(2048-64),NI), 0, _Sub(_Mov(2048),NI), 8192)
			DoActions(FP, {KillUnitAt(All,nilunit,201,FP),Simple_SetLoc(201, 0, 0, 0, 0)})
			NJumpX(FP, CheckJump,{Bring(Force1, AtLeast, 1, "Men", 201)},{MoveLocation(202, "Men", Force1, 201)})

			CIfEnd()
			CForEnd()
			NJumpXEnd(FP, CheckJump,{RotatePlayer({DisplayTextX("Check",4)},HumanPlayers,FP)})
			GetLocCenter(201, CPosX, CPosY)
			--DisplayPrint(HumanPlayers, {"CPosX: ",CPosX,"  CPosY: ",CPosY})
			CNeg(FP,CPosX)
			CAdd(FP,CPosX,32*64)
			CNeg(FP,CPosY)
			CAdd(FP,CPosY,32*256)
			CMov(FP,G_CB_X,CPosX)
			CMov(FP,G_CB_Y,CPosY)
			CenT = {7,60,70,57,62,64}
			for j,k in pairs(CenT) do
				G_CB_SetSpawn({GNm(j)}, {k}, {"ACAS"}, {"CenCross"}, "MAX", 129, nil, nil, P7,1)
			end
			CIfEnd()
		CIfEnd()

	CIfEnd()



	CIf_GCase(148)--옵마(Hypernaid)
		CIf(FP,GNm(1))
		
		CTrigger(FP,{Gun_Line(7,AtLeast,480)},{Gun_SetLine(6,Add,1),Gun_SetLine(7,SetTo,0),},1)

		G_CB_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,1)}, {21,17}, "ACAS", "Hy1LC_64", nil, 0, nil, nil, P7)
		G_CB_SetSpawn({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {21,17}, "ACAS", "Hy1FP_64", nil, 0, nil, nil, P7)
		G_CB_SetSpawn({Gun_Line(5,Exactly,0)}, {55,53,54,46}, "ACAS", "Hy1FP_64", nil, 0, nil, nil, P8)

		CIf(FP,{Gun_Line(7,Exactly,0)})
		G_CB_SetSpawn({Gun_Line(6,Exactly,1),CD(GMode,1)}, {19,28}, "ACAS", "Hy1LC_64", nil, 0, nil, nil, P7)
		G_CB_SetSpawn({Gun_Line(6,Exactly,1),CD(GMode,2,AtLeast)}, {19,28}, "ACAS", "Hy1FP_64", nil, 0, nil, nil, P7)
		G_CB_SetSpawn({Gun_Line(6,Exactly,1)}, {56,104,51,48}, "ACAS", "Hy1FP_64", nil, 0, nil, nil, P8)
		
		G_CB_SetSpawn({Gun_Line(6,Exactly,2),CD(GMode,1)}, {88,77}, "ACAS", "Hy1LC_64", nil, 0, nil, nil, P7)
		G_CB_SetSpawn({Gun_Line(6,Exactly,2),CD(GMode,2,AtLeast)}, {88,77}, "ACAS", "Hy1FP_64", nil, 0, nil, nil, P7)
		G_CB_SetSpawn({Gun_Line(6,Exactly,2)}, {56,104,51,48}, "ACAS", "Hy1FP_64", nil, 0, nil, nil, P8)
		
		G_CB_SetSpawn({Gun_Line(6,Exactly,3),CD(GMode,1)}, {78,86}, "ACAS", "Hy1LC_64", nil, 0, nil, nil, P7)
		G_CB_SetSpawn({Gun_Line(6,Exactly,3),CD(GMode,2,AtLeast)}, {78,86}, "ACAS", "Hy1FP_64", nil, 0, nil, nil, P7)
		G_CB_SetSpawn({Gun_Line(6,Exactly,3)}, {56,104,51,48}, "ACAS", "Hy1FP_64", nil, 0, nil, nil, P8)
		CIfEnd()

		--21,17
		--19,28
		--88,77
		--78,86
		--Hy1LC_64
		--Hy1FP_64
		


		DoActionsX(FP,{Gun_SetLine(5,SetTo,1)})
		CTrigger(FP,{Gun_Line(6,AtLeast,3)},{Gun_DoSuspend()},1)
		CIfEnd()
	CIfEnd()
	GeneCUT1 = {55,21,86,58,12,60,7,"EL FAIL"}
	GeneCUT2 = {56,88,98,80,29,70,64,"PLAY"}
	GeneCUT3 = {28,84,8,62,57,102,"Zero","LENA"}
	
	
	




	CIf_GCase(200) -- 제네
		for j,k in pairs(GeneCUT1) do
			if j == 8 then
				G_CB_SetSpawn({CD(GMode,1),GNm(1),Gun_Line(7,AtLeast,240*(j-1))}, {k}, "ACAS", "GeneN1R", "MAX", 200, nil, {0,0}, P6,1)
				G_CB_SetSpawn({CD(GMode,2,AtLeast),GNm(1),Gun_Line(7,AtLeast,240*(j-1))}, {k}, "ACAS", "GeneN1P", "MAX", 200, nil, {0,0}, P6,1)
			else
				G_CB_SetSpawn({CD(GMode,1),GNm(1),Gun_Line(7,AtLeast,240*(j-1))}, {k}, "ACAS", "GeneN1", "MAX", 200, nil, {0,0}, P6,1)
				G_CB_SetSpawn({CD(GMode,2,AtLeast),GNm(1),Gun_Line(7,AtLeast,240*(j-1))}, {k}, "ACAS", "Gene1", "MAX", 200, nil, {0,0}, P6,1)
			end
		end
		for j,k in pairs(GeneCUT2) do
			if j == 8 then
				G_CB_SetSpawn({CD(GMode,1),GNm(2),Gun_Line(7,AtLeast,240*(j-1))}, {k}, "ACAS", "GeneN2R", "MAX", 201, nil, {0,0}, P6,1)
				G_CB_SetSpawn({CD(GMode,2,AtLeast),GNm(2),Gun_Line(7,AtLeast,240*(j-1))}, {k}, "ACAS", "GeneN2P", "MAX", 201, nil, {0,0}, P6,1)
			else
				G_CB_SetSpawn({CD(GMode,1),GNm(2),Gun_Line(7,AtLeast,240*(j-1))}, {k}, "ACAS", "GeneN2", "MAX", 201, nil, {0,0}, P6,1)
				G_CB_SetSpawn({CD(GMode,2,AtLeast),GNm(2),Gun_Line(7,AtLeast,240*(j-1))}, {k}, "ACAS", "Gene2", "MAX", 201, nil, {0,0}, P6,1)
			end
		end
		for j,k in pairs(GeneCUT3) do
			if k == 102 or k == "Zero" then
				G_CB_SetSpawn({CD(GMode,1),GNm(3),Gun_Line(7,AtLeast,240*(j-1))}, {k}, "ACAS", "GeneN3P", "MAX", 202, nil, {0,0}, P6,1)
			elseif j == 8 then
				G_CB_SetSpawn({CD(GMode,1),GNm(3),Gun_Line(7,AtLeast,240*(j-1))}, {k}, "ACAS", "GeneN3R", "MAX", 202, nil, {0,0}, P6,1)
			else
				G_CB_SetSpawn({CD(GMode,1),GNm(3),Gun_Line(7,AtLeast,240*(j-1))}, {k}, "ACAS", "GeneN3", "MAX", 202, nil, {0,0}, P6,1)
			end


			if k == 102 or k == "Zero" then
				G_CB_SetSpawn({CD(GMode,2,AtLeast),GNm(3),Gun_Line(7,AtLeast,240*(j-1))}, {k}, "ACAS", "GeneN3", "MAX", 202, nil, {0,0}, P6,1)
			elseif j == 8 then
				G_CB_SetSpawn({CD(GMode,2,AtLeast),GNm(3),Gun_Line(7,AtLeast,240*(j-1))}, {k}, "ACAS", "GeneN3P", "MAX", 202, nil, {0,0}, P6,1)
			else
				G_CB_SetSpawn({CD(GMode,2,AtLeast),GNm(3),Gun_Line(7,AtLeast,240*(j-1))}, {k}, "ACAS", "Gene3", "MAX", 202, nil, {0,0}, P6,1)
			end
		end
		CTrigger(FP,{Gun_Line(7,AtLeast,240*(8))},{Gun_DoSuspend()},1)
		
	CIfEnd()
	--HD
	--S_7, 0 : 15
	--S_7, 0 : 15
	--S_7, 0 : 15
	--P_4, 1 : 13
	--P_4, 1 : 13
	--P_4, 1 : 13
	--S_6, 0 : 13
	--S_6, 0 : 13
	--S_6, 0 : 13
	--S_5, 0 : 11
	--S_5, 0 : 11
	--S_5, 0 : 11
	--P_3, 1 : 10
	--P_3, 1 : 10
	--P_3, 1 : 10
	--S_4, 0 : 9
	--S_4, 0 : 9
	--S_4, 0 : 9
	--SC
	--P_3, 5 : 64
	--P_3, 5 : 64
	--P_3, 5 : 64
	--S_3, 3 : 61
	--S_3, 3 : 61
	--S_3, 3 : 61
	--P_4, 4 : 61
	--P_4, 4 : 61
	--P_4, 4 : 61
	--P_6, 3 : 61
	--P_6, 3 : 61
	--P_6, 3 : 61
	--S_5, 2 : 61
	--S_5, 2 : 61
	--S_5, 2 : 61
	--P_5, 3 : 51
	--P_5, 3 : 51
	--P_5, 3 : 51
	
	KimrhegbArr = {55,56,"Kazansky","Artanis","Danimoth","Lin","Raszagal","Envy","Lizzet","Merry","Rose","Norad II","Era","Nina","Sera","Sorang","Sena","Sen"}
	
	KimrhegbArr2 = {{P_3, 5},{P_3, 5},{P_3, 5},{S_3, 3},{S_3, 3},{S_3, 3},{P_4, 4},{P_4, 4},{P_4, 4},{P_6, 3},{P_6, 3},{P_6, 3},{S_5, 2},{S_5, 2},{S_5, 2},{P_5, 3},{P_5, 3},{P_5, 3}}
	KimrhegbArr3 = {{S_7, 0},{S_7, 0},{S_7, 0},{P_4, 1},{P_4, 1},{P_4, 1},{S_6, 0},{S_6, 0},{S_6, 0},{S_5, 0},{S_5, 0},{S_5, 0},{P_3, 1},{P_3, 1},{P_3, 1},{S_4, 0},{S_4, 0},{S_4, 0},}
	CIf_GCase(150)--오버미
		for j,k in pairs(KimrhegbArr) do
			G_CB_SetSpawn({CD(GMode,1),GNm(j-1)}, {k,94}, KimrhegbArr3[j][1],KimrhegbArr3[j][2], "MAX", 187, nil, nil, P6,1)
			G_CB_SetSpawn({CD(GMode,2,AtLeast),GNm(j-1)}, {k,94}, KimrhegbArr2[j][1],KimrhegbArr2[j][2], "MAX", 187, nil, nil, P6,1)
		end
		CTrigger(FP,{},{Gun_DoSuspend(),SubCD(ChryCcode, 1),Gun_SetLine(6,SetTo,1)},1)

	CIfEnd()
	CIf_GCase(201)--에너미스톰
			for j,k in pairs(KimrhegbArr) do
			CIfOnce(FP, {Gun_Line(7,AtLeast,(j-1)*12)})
			f_SHRead(FP, ArrX(OverMePosX,j-1), G_CB_X)
			f_SHRead(FP, ArrX(OverMePosY,j-1), G_CB_Y)
			G_CB_SetSpawn({CD(GMode,1)}, {k}, KimrhegbArr3[j][1],KimrhegbArr3[j][2], "MAX", 203, nil, nil, P6,1)
			G_CB_SetSpawn({CD(GMode,2,AtLeast)}, {k}, KimrhegbArr2[j][1],KimrhegbArr2[j][2], "MAX", 203, nil, nil, P6,1)
			DoActions(FP, {Simple_SetLoc(0, 288,3792,288,3792),CreateUnit(10, 94, 1, P6)})
			CIfEnd()
			end
			CIf(FP,{Gun_Line(7,AtLeast,640)},{Gun_DoSuspend(),SetCD(CocoonCcode,1),SetCp(P6),RunAIScriptAt(JYD, 64),SetCp(FP)})
			for j,k in pairs(KimrhegbArr) do
				f_SHRead(FP, ArrX(OverMePosX,j-1), G_CB_X)
				f_SHRead(FP, ArrX(OverMePosY,j-1), G_CB_Y)
				G_CB_SetSpawn({CD(GMode,1)}, {94}, KimrhegbArr3[j][1],KimrhegbArr3[j][2], "MAX", nil, nil, nil, P6,1)
				G_CB_SetSpawn({CD(GMode,2,AtLeast)}, {94}, KimrhegbArr2[j][1],KimrhegbArr2[j][2], "MAX", nil, nil, nil, P6,1)
			end
			CIfEnd()
	CIfEnd()
	
	CIf_GCase(126)--노라드
		CTrigger(FP,{Gun_Line(7,AtLeast,480)},{Gun_SetLine(6,Add,1),Gun_SetLine(7,SetTo,0),},1)
		--NS_HD
		--NS_SC
		--NS_HDW
		--NS_SCW
		--SpiHD
		--SpiSC
		CIf(FP,GNm(1))	
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,1)}, {"Lin"}, NS_HD, 1, "Timer_Attack", 3, nil, 1, nil, P8)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {"Lin"}, NS_SC, 1, "Timer_Attack", 3, nil, 1, nil, P8)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,1)}, {"Zeratul"}, NS_HDW, 1, 0, 2, nil, 1, nil, P8)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {"Zeratul"}, NS_SCW, 1, 0, 2, nil, 1, nil, P8)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,1)}, {"Duke Siege"}, SpiHD, 1, 0, 0, nil, nil, nil, P8)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {"Duke Siege"}, SpiSC, 1, 0, 0, nil, nil, nil, P8)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0)}, {55,53,54,46}, SpiSC, 1, 0, 0, nil, nil, nil, P8)
			CIf(FP,{Gun_Line(7,Exactly,0)})
				CIf(FP,Gun_Line(6,Exactly,1))
					G_CB_SetSpawnX({CD(GMode,1)}, {"Raszagal"}, NS_HD, 1, "Timer_Attack", 3, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Raszagal"}, NS_SC, 1, "Timer_Attack", 3, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,1)}, {"Archon"}, NS_HDW, 1, 0, 2, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Archon"}, NS_SCW, 1, 0, 2, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,1)}, {"Tassadar"}, SpiHD, 1, 0, 0, nil, nil, nil, P8)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Tassadar"}, SpiSC, 1, 0, 0, nil, nil, nil, P8)
					G_CB_SetSpawnX({}, {55,53,54,46}, SpiSC, 1, 0, 0, nil, nil, nil, P8)
				CIfEnd()
				CIf(FP,Gun_Line(6,Exactly,2))
					G_CB_SetSpawnX({CD(GMode,1)}, {"Envy"}, NS_HD, 1, "Timer_Attack", 3, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Envy"}, NS_SC, 1, "Timer_Attack", 3, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,1)}, {"Yumi"}, NS_HDW, 1, 0, 2, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Yumi"}, NS_SCW, 1, 0, 2, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,1)}, {"Darly"}, SpiHD, 1, 0, 0, nil, nil, nil, P8)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Darly"}, SpiSC, 1, 0, 0, nil, nil, nil, P8)
					G_CB_SetSpawnX({}, {55,53,54,46}, SpiSC, 1, 0, 0, nil, nil, nil, P8)
				CIfEnd()
				CIf(FP,Gun_Line(6,Exactly,3))
					G_CB_SetSpawnX({CD(GMode,1)}, {"Lizzet"}, NS_HD, 1, "Timer_Attack", 3, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Lizzet"}, NS_SC, 1, "Timer_Attack", 3, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,1)}, {"Yuna"}, NS_HDW, 1, 0, 2, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Yuna"}, NS_SCW, 1, 0, 2, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,1)}, {"Yona"}, SpiHD, 1, 0, 0, nil, nil, nil, P8)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Yona"}, SpiSC, 1, 0, 0, nil, nil, nil, P8)
					G_CB_SetSpawnX({}, {55,53,54,46}, SpiSC, 1, 0, 0, nil, nil, nil, P8)
				CIfEnd()
			CIfEnd()
		CIfEnd()

		
		
		
		
		
		CIf(FP,GNm(2))	
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,1)}, {"Merry"}, NS_HD, 1, "Timer_Attack", 3, nil, 1, nil, P8)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {"Merry"}, NS_SC, 1, "Timer_Attack", 3, nil, 1, nil, P8)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,1)}, {"Sui"}, NS_HDW, 1, 0, 2, nil, 1, nil, P8)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {"Sui"}, NS_SCW, 1, 0, 2, nil, 1, nil, P8)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,1)}, {"Rophe"}, SpiHD, 1, 0, 0, nil, nil, nil, P8)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {"Rophe"}, SpiSC, 1, 0, 0, nil, nil, nil, P8)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0)}, {55,53,54,46}, SpiSC, 1, 0, 0, nil, nil, nil, P8)
			CIf(FP,{Gun_Line(7,Exactly,0)})
				CIf(FP,Gun_Line(6,Exactly,1))
					G_CB_SetSpawnX({CD(GMode,1)}, {"Rose"}, NS_HD, 1, "Timer_Attack", 3, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Rose"}, NS_SC, 1, "Timer_Attack", 3, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,1)}, {"Jisoo"}, NS_HDW, 1, 0, 2, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Jisoo"}, NS_SCW, 1, 0, 2, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,1)}, {"Yuri"}, SpiHD, 1, 0, 0, nil, nil, nil, P8)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Yuri"}, SpiSC, 1, 0, 0, nil, nil, nil, P8)
					G_CB_SetSpawnX({}, {55,53,54,46}, SpiSC, 1, 0, 0, nil, nil, nil, P8)
				CIfEnd()
				CIf(FP,Gun_Line(6,Exactly,2))
					G_CB_SetSpawnX({CD(GMode,1)}, {"Era"}, NS_HD, 1, "Timer_Attack", 3, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Era"}, NS_SC, 1, "Timer_Attack", 3, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,1)}, {"Freyja"}, NS_HDW, 1, 0, 2, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Freyja"}, NS_SCW, 1, 0, 2, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,1)}, {"Kamilia"}, SpiHD, 1, 0, 0, nil, nil, nil, P8)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Kamilia"}, SpiSC, 1, 0, 0, nil, nil, nil, P8)
					G_CB_SetSpawnX({}, {55,53,54,46}, SpiSC, 1, 0, 0, nil, nil, nil, P8)
				CIfEnd()
				CIf(FP,Gun_Line(6,Exactly,3))
					G_CB_SetSpawnX({CD(GMode,1)}, {"Sena"}, NS_HD, 1, "Timer_Attack", 3, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Sena"}, NS_SC, 1, "Timer_Attack", 3, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,1)}, {"Sadol"}, NS_HDW, 1, 0, 2, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Sadol"}, NS_SCW, 1, 0, 2, nil, 1, nil, P8)
					G_CB_SetSpawnX({CD(GMode,1)}, {"Gaya"}, SpiHD, 1, 0, 0, nil, nil, nil, P8)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Gaya"}, SpiSC, 1, 0, 0, nil, nil, nil, P8)
					G_CB_SetSpawnX({}, {55,53,54,46}, SpiSC, 1, 0, 0, nil, nil, nil, P8)
				CIfEnd()
			CIfEnd()
		CIfEnd()

		
		DoActionsX(FP,{Gun_SetLine(5,SetTo,1)})
		CTrigger(FP,{Gun_Line(6,AtLeast,3)},{Gun_DoSuspend()},1)

	CIfEnd()
	--{2,"CB_MarNumFill"},--저그유닛전용
	--{3,"CB_MarNumFill2"}--영웅유닛전용
	--TemConnectHD
	--TemConnectSC
	--TemConnect
	CIf_GCase(174)
	
	--0~20


	CTrigger(FP,{Gun_Line(7,AtLeast,480)},{Gun_SetLine(6,Add,1),Gun_SetLine(7,SetTo,0),},1)
	local MarNum = CreateVars(FP)
	local SizeV = CreateVar(FP)
	Simple_SetLocX(FP, 200, Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],{Simple_CalcLoc(200, -32*15, -32*15, 32*15, 32*15),KillUnitAt(All, nilunit, 201, FP)})
	UnitReadX(FP, Force1, "Men", 201, MarNum)
	TriggerX(FP, {CV(MarNum,480,AtLeast)}, {SetV(MarNum,480)},{preserved})
	CDiv(FP, SizeV, MarNum, 20)
		CIf(FP,GNm(2))	
			for i = 0, 24 do
			CIf(FP,{CV(SizeV,i)})
				local SHI = i
				local ShRet = CS_FillPathHX2(TemConnect,1,72+72+72+72-(8.4*SHI),48+48+48+48-(5.6*SHI),1,0,26.57,5)
				local ShRet2 = CS_FillPathHX2(TemConnect,1,72+72+72+72-((4.5)*SHI),48+48+48+48-((3)*SHI),1,0,26.57,5)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,1)}, {"Schezar"}, ShRet2, 0, 0, 0, nil, 2, nil, P8)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,1)}, {"Raynor V"}, ShRet2, 0, 0, 0, nil, 2, nil, P8)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {"Schezar"}, ShRet, 0, 0, 0, nil, 2, nil, P8)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {"Raynor V"}, ShRet, 0, 0, 0, nil, 2, nil, P8)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0)}, {55,53,54,46}, ShRet, 0, 0, 0, nil, 2, nil, P8)
				CIf(FP,{Gun_Line(7,Exactly,0)})
					CIf(FP,Gun_Line(6,Exactly,1))
						G_CB_SetSpawnX({CD(GMode,1)}, {"Fenix Z"}, ShRet2, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({CD(GMode,1)}, {"Zeratul"}, ShRet2, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Fenix Z"}, ShRet, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Zeratul"}, ShRet, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({}, {55,53,54,46}, ShRet, 0, 0, 0, nil, 2, nil, P8)
					CIfEnd()
					CIf(FP,Gun_Line(6,Exactly,2))
						G_CB_SetSpawnX({CD(GMode,1)}, {"Fenix D"}, ShRet2, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({CD(GMode,1)}, {"Archon"}, ShRet2, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Fenix D"}, ShRet, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Archon"}, ShRet, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({}, {55,53,54,46}, ShRet, 0, 0, 0, nil, 2, nil, P8)
					CIfEnd()
					CIf(FP,Gun_Line(6,Exactly,3))
						G_CB_SetSpawnX({CD(GMode,1)}, {"Duke Siege"}, ShRet2, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({CD(GMode,1)}, {"Tassadar"}, ShRet2, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Duke Siege"}, ShRet, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Tassadar"}, ShRet, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({}, {55,53,54,46}, ShRet, 0, 0, 0, nil, 2, nil, P8)
					CIfEnd()
				CIfEnd()
			CIfEnd()
			end
			G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,1)}, {"Kazansky"}, TemConnectHD, 0, "Timer_Attack_Gun", 2, nil, 1, nil, P7)
			G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {"Kazansky"}, TemConnectSC, 0, "Timer_Attack_Gun", 2, nil, 1, nil, P7)
			CIf(FP,{Gun_Line(7,Exactly,0)})
				CIf(FP,Gun_Line(6,Exactly,1))
					G_CB_SetSpawnX({CD(GMode,1)}, {"Hyperion"}, TemConnectHD, 0, "Timer_Attack_Gun", 2, nil, 1, nil, P7)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Hyperion"}, TemConnectSC, 0, "Timer_Attack_Gun", 2, nil, 1, nil, P7)
				CIfEnd()
				CIf(FP,Gun_Line(6,Exactly,2))
					G_CB_SetSpawnX({CD(GMode,1)}, {"Artanis"}, TemConnectHD, 0, "Timer_Attack_Gun", 2, nil, 1, nil, P7)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Artanis"}, TemConnectSC, 0, "Timer_Attack_Gun", 2, nil, 1, nil, P7)
				CIfEnd()
				CIf(FP,Gun_Line(6,Exactly,3))
					G_CB_SetSpawnX({CD(GMode,1)}, {"Danimoth"}, TemConnectHD, 0, "Timer_Attack_Gun", 2, nil, 1, nil, P7)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Danimoth"}, TemConnectSC, 0, "Timer_Attack_Gun", 2, nil, 1, nil, P7)
				CIfEnd()
			CIfEnd()
		CIfEnd()


		
		
		
		
		
		
		
		
		


		CIf(FP,GNm(1))	
			for i = 0, 24 do
			CIf(FP,{CV(SizeV,i)})
				local SHI = i
				local ShRet = CS_FillPathHX2(TemConnect2,1,72+72+72-(8.4*SHI),48+48+48-(5.6*SHI),1,0,26.57,5)
				local ShRet2 = CS_FillPathHX2(TemConnect2,1,72+72+72-((4.5)*SHI),48+48+48-((3)*SHI),1,0,26.57,5)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,1)}, {"Yuna"}, ShRet2, 0, 0, 0, nil, 2, nil, P8)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,1)}, {"Darly"}, ShRet2, 0, 0, 0, nil, 2, nil, P8)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {"Yuna"}, ShRet, 0, 0, 0, nil, 2, nil, P8)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {"Darly"}, ShRet, 0, 0, 0, nil, 2, nil, P8)
				G_CB_SetSpawnX({Gun_Line(5,Exactly,0)}, {55,53,54,46}, ShRet, 0, 0, 0, nil, 2, nil, P8)
				CIf(FP,{Gun_Line(7,Exactly,0)})
					CIf(FP,Gun_Line(6,Exactly,1))
						G_CB_SetSpawnX({CD(GMode,1)}, {"Yumi"}, ShRet2, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({CD(GMode,1)}, {"Sui"}, ShRet2, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Yumi"}, ShRet, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Sui"}, ShRet, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({}, {55,53,54,46}, ShRet, 0, 0, 0, nil, 2, nil, P8)
					CIfEnd()
					CIf(FP,Gun_Line(6,Exactly,2))
						G_CB_SetSpawnX({CD(GMode,1)}, {"Jisoo"}, ShRet2, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({CD(GMode,1)}, {"Yuri"}, ShRet2, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Jisoo"}, ShRet, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Yuri"}, ShRet, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({}, {55,53,54,46}, ShRet, 0, 0, 0, nil, 2, nil, P8)
					CIfEnd()
					CIf(FP,Gun_Line(6,Exactly,3))
						G_CB_SetSpawnX({CD(GMode,1)}, {"Sadol"}, ShRet2, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({CD(GMode,1)}, {"Gaya"}, ShRet2, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Sadol"}, ShRet, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Gaya"}, ShRet, 0, 0, 0, nil, 2, nil, P8)
						G_CB_SetSpawnX({}, {55,53,54,46}, ShRet, 0, 0, 0, nil, 2, nil, P8)
					CIfEnd()
				CIfEnd()
			CIfEnd()
			end
			G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,1)}, {"Raszagal"}, TemConnect2HD, 0, "Timer_Attack_Gun", 2, nil, 1, nil, P7)
			G_CB_SetSpawnX({Gun_Line(5,Exactly,0),CD(GMode,2,AtLeast)}, {"Raszagal"}, TemConnect2SC, 0, "Timer_Attack_Gun", 2, nil, 1, nil, P7)
			CIf(FP,{Gun_Line(7,Exactly,0)})
				CIf(FP,Gun_Line(6,Exactly,1))
					G_CB_SetSpawnX({CD(GMode,1)}, {"Envy"}, TemConnect2HD, 0, "Timer_Attack_Gun", 2, nil, 1, nil, P7)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Envy"}, TemConnect2SC, 0, "Timer_Attack_Gun", 2, nil, 1, nil, P7)
				CIfEnd()
				CIf(FP,Gun_Line(6,Exactly,2))
					G_CB_SetSpawnX({CD(GMode,1)}, {"Nina"}, TemConnect2HD, 0, "Timer_Attack_Gun", 2, nil, 1, nil, P7)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Nina"}, TemConnect2SC, 0, "Timer_Attack_Gun", 2, nil, 1, nil, P7)
				CIfEnd()
				CIf(FP,Gun_Line(6,Exactly,3))
					G_CB_SetSpawnX({CD(GMode,1)}, {"Sera"}, TemConnect2HD, 0, "Timer_Attack_Gun", 2, nil, 1, nil, P7)
					G_CB_SetSpawnX({CD(GMode,2,AtLeast)}, {"Sera"}, TemConnect2SC, 0, "Timer_Attack_Gun", 2, nil, 1, nil, P7)
				CIfEnd()
			CIfEnd()
		CIfEnd()


		DoActionsX(FP,{Gun_SetLine(5,SetTo,1)})
		CTrigger(FP,{Gun_Line(6,AtLeast,3)},{Gun_DoSuspend()},1)
	CIfEnd()
	

	CIf_GCase(127)


	
	CTrigger(FP,{Gun_Line(5,Exactly,0)},{Gun_SetLine(50,SetTo,1),Gun_SetLine(51,SetTo,1830)},1)
	CTrigger(FP,{Gun_Line(50,Exactly,0)},{Gun_SetLine(11,Add,1)},1)
	CTrigger(FP,{Gun_Line(50,Exactly,1)},{Gun_SetLine(11,Subtract,1)},1)
	CTrigger(FP,{Gun_Line(11,Exactly,0),Gun_Line(50,Exactly,1)},{Gun_SetLine(50,SetTo,0)},1)
	CTrigger(FP,{Gun_Line(11,AtLeast,60),Gun_Line(50,Exactly,0)},{Gun_SetLine(50,SetTo,1),Gun_SetLine(51,SetTo,0)},1)
	CTrigger(FP,{Gun_Line(50,Exactly,1)},{TGun_SetLine(51,Add,Var_TempTable[12])},1)
	CTrigger(FP,{Gun_Line(50,Exactly,0)},{TGun_SetLine(51,Subtract,Var_TempTable[12])},1)
	CDoActions(FP,{Gun_SetLine(52,Add,3)}) -- 
	CTrigger(FP,{Gun_Line(52,AtLeast,72)},{Gun_SetLine(52,SetTo,0)},1)


	CTrigger(FP,{},{Gun_SetLine(13,Add,3)},{preserved})
	local NPosX, NPosY = CreateVars(2, FP)
	
	CFor(FP, 0, 360, 72)
	local CI = CForVariable()
	f_Lengthdir(FP, _Div(Var_TempTable[52],_Mov(7)),_Add(Var_TempTable[53],CI), NPosX, NPosY)
	f_Div(FP,NPosY,2)
	Simple_SetLocX(FP,200, _Add(NPosX,Var_TempTable[2]), _Add(NPosY,Var_TempTable[3]), _Add(NPosX,Var_TempTable[2]), _Add(NPosY,Var_TempTable[3]))
	CDoActions(FP, {CreateUnit(1, 94, 201, P6),KillUnit(94, P6)})
	CForEnd()
	CIf(FP,{Gun_Line(7,AtLeast,480),Memory(0x628438,AtLeast,1)},{Gun_SetLine(6,Add,1),Gun_SetLine(7,SetTo,0),})
		f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
		CMov(FP,CunitIndex,_Div(_Sub(Nextptrs,19025),_Mov(84)))
		CDoActions(FP, {CreateUnit(1, 119, 1, P6)})
		CTrigger(FP,{},{Set_EXCC2(DUnitCalc, CunitIndex, 2, SetTo, _Add(_Mul(_Sub(Var_TempTable[4],1),4),Var_TempTable[7]))},{preserved})
		CTrigger(FP, {GNm(1)}, {
			TSetMemory(_Add(Nextptrs,13),SetTo,1500),
			TSetMemoryX(_Add(Nextptrs,18),SetTo,1500,0xFFFF),}, {preserved})
		CTrigger(FP, {GNm(2)}, {
			TSetMemory(_Add(Nextptrs,13),SetTo,4500),
			TSetMemoryX(_Add(Nextptrs,18),SetTo,4500,0xFFFF),}, {preserved})
			G_CB_TSetSpawn({GNm(1)}, {94}, {L1084}, nil, {OwnerTable=P6,LMTable="MAX",CenterXY={0,0}})
			G_CB_TSetSpawn({GNm(2)}, {94}, {L2084}, nil, {OwnerTable=P6,LMTable="MAX",CenterXY={0,0}})
			Trigger2X(FP, {}, {RotatePlayer({PlayWAVX("staredit\\wav\\BossWin.ogg"),PlayWAVX("staredit\\wav\\BossWin.ogg"),PlayWAVX("staredit\\wav\\BossWin.ogg"),PlayWAVX("staredit\\wav\\BossWin.ogg"),}, HumanPlayers, FP)},{preserved})


	CIfEnd()
	DoActionsX(FP,{Gun_SetLine(5,SetTo,1)})
	CTrigger(FP,{Gun_Line(6,AtLeast,4)},{Gun_DoSuspend()},1)
	CIfEnd()
	

	--1024,1088
	--LauncherShHD
	--LauncherShSC

	CIf_GCase(119)--로켓런쳐 탄환
	
	Trigger2X(FP, {}, {RotatePlayer({PlayWAVX("staredit\\wav\\SoundHorror.ogg"),PlayWAVX("staredit\\wav\\SoundHorror.ogg"),PlayWAVX("staredit\\wav\\SoundHorror.ogg"),PlayWAVX("staredit\\wav\\SoundHorror.ogg"),PlayWAVX("staredit\\wav\\SoundHorror.ogg"),PlayWAVX("staredit\\wav\\SoundHorror.ogg")}, HumanPlayers, FP)},{preserved})

	G_CB_SetSpawnX({GNm((4*0)+1),CD(GMode,1)}, {"Artanis","Fenix Z",94}, LauncherShHD, "MAX", 0, 0, nil, nil, {1024,1088}, P6)
	G_CB_SetSpawnX({GNm((4*0)+1),CD(GMode,2,AtLeast)}, {"Artanis","Fenix Z",94}, LauncherShSC, "MAX", 0, 0, nil, nil, {1024,1088}, P6)
	G_CB_SetSpawnX({GNm((4*0)+2),CD(GMode,1)}, {"Kazansky","Raynor V",94}, LauncherShHD, "MAX", 0, 0, nil, nil, {1024,1088}, P6)
	G_CB_SetSpawnX({GNm((4*0)+2),CD(GMode,2,AtLeast)}, {"Kazansky","Raynor V",94}, LauncherShSC, "MAX", 0, 0, nil, nil, {1024,1088}, P6)
	G_CB_SetSpawnX({GNm((4*0)+3),CD(GMode,1)}, {"Hyperion","Zeratul",94}, LauncherShHD, "MAX", 0, 0, nil, nil, {1024,1088}, P6)
	G_CB_SetSpawnX({GNm((4*0)+3),CD(GMode,2,AtLeast)}, {"Hyperion","Zeratul",94}, LauncherShSC, "MAX", 0, 0, nil, nil, {1024,1088}, P6)
	G_CB_SetSpawnX({GNm((4*0)+4),CD(GMode,1)}, {"Danimoth","Fenix D",94}, LauncherShHD, "MAX", 0, 0, nil, nil, {1024,1088}, P6)
	G_CB_SetSpawnX({GNm((4*0)+4),CD(GMode,2,AtLeast)}, {"Danimoth","Fenix D",94}, LauncherShSC, "MAX", 0, 0, nil, nil, {1024,1088}, P6)


	G_CB_SetSpawnX({GNm((4*1)+1),CD(GMode,1)}, {"Archon","Raszagal",94}, LauncherShHD, "MAX", 0, 0, nil, nil, {1024,1088}, P6)
	G_CB_SetSpawnX({GNm((4*1)+1),CD(GMode,2,AtLeast)}, {"Archon","Raszagal",94}, LauncherShSC, "MAX", 0, 0, nil, nil, {1024,1088}, P6)
	G_CB_SetSpawnX({GNm((4*1)+2),CD(GMode,1)}, {"Tassadar","Envy",94}, LauncherShHD, "MAX", 0, 0, nil, nil, {1024,1088}, P6)
	G_CB_SetSpawnX({GNm((4*1)+2),CD(GMode,2,AtLeast)}, {"Tassadar","Envy",94}, LauncherShSC, "MAX", 0, 0, nil, nil, {1024,1088}, P6)
	G_CB_SetSpawnX({GNm((4*1)+3),CD(GMode,1)}, {"Yuri","Norad II",94}, LauncherShHD, "MAX", 0, 0, nil, nil, {1024,1088}, P6)
	G_CB_SetSpawnX({GNm((4*1)+3),CD(GMode,2,AtLeast)}, {"Yuri","Norad II",94}, LauncherShSC, "MAX", 0, 0, nil, nil, {1024,1088}, P6)
	G_CB_SetSpawnX({GNm((4*1)+4),CD(GMode,1)}, {"Yona","Lizzet",94}, LauncherShHD, "MAX", 0, 0, nil, nil, {1024,1088}, P6)
	G_CB_SetSpawnX({GNm((4*1)+4),CD(GMode,2,AtLeast)}, {"Yona","Lizzet",94}, LauncherShSC, "MAX", 0, 0, nil, nil, {1024,1088}, P6)



	CTrigger(FP,{},{Gun_DoSuspend(),Gun_SetLine(53, SetTo,1)},1)
	CIfEnd()


	CIf_GCase(106)--커맨드센터
	CenCUT = {
		{
			55,
			56,
			"Kazansky",
		},
		{
			"Artanis",
			"Danimoth",
			"Raszagal",
		},
		{
			"Lin",
			"Envy",
			"Lizzet"
		},
		{
			"Rose",
			"Norad II",
			"Nina"
		},
		{
			"Sera",
			"Sorang",
			"Sena",
			"PLAY"
		},
		{
			"Merry",
			"Sen",
			"Era",
			"LENA"
		},
		{
			"Identity",
			"Division",
			"Zero",
			"EL FAIL"
		},
	}

	CenCUSh = {
		RCen1,RCen2,RCen3,RCen4,RCen5,RCen6,RCen7,
	}
	CenCUShN = {
		RCenN1,RCenN2,RCenN3,RCenN4,RCenN5,RCenN6,RCenN7,
	}
	
	if TestStart == 1 then
		--DisplayPrint(HumanPlayers, {G_CB_RotateV})
	end
	for j,k in pairs(CenCUT) do
		local SCSh = CenCUSh[j]
		local NmSh = CenCUShN[j]
		local RPT = 187
		if j == 7 then RPT = 188 end -- 디비전 제로 감커는 체력 10%로 설정
		CIf(FP,{GNm(j)})
		for l, m in pairs(k) do
			if l == 4 then
				f_TempRepeat({CD(GMode,1),Gun_Line(7,AtLeast,120*(10-1))},m,1,188,P6,nil,1)
				f_TempRepeat({CD(GMode,2,AtLeast),Gun_Line(7,AtLeast,120*(10-1))},m,1,187,P6,nil,1)
				--G_CB_TSetSpawn({CD(GMode,2,AtLeast),Gun_Line(7,AtLeast,120*(10-1))}, {m}, {NmSh}, 1, {OwnerTable={P6},RepeatType = 187,RotateTable="Main"})
			else
				for o = 1, 3 do
					G_CB_TSetSpawn({CD(GMode,1),Gun_Line(7,AtLeast,120*((o-1)+((l-1)*3)))}, {m}, {NmSh}, 1, {OwnerTable={P6},RepeatType = RPT,RotateTable="Main"})
					G_CB_TSetSpawn({CD(GMode,2,AtLeast),Gun_Line(7,AtLeast,120*((o-1)+((l-1)*3)))}, {m}, {SCSh}, 1, {OwnerTable={P6},RepeatType = RPT,RotateTable="Main"})
				end
			end
		end
		CIfEnd()
	end
	CTrigger(FP,{Gun_Line(7,AtLeast,120*(10))},{Gun_DoSuspend()},1)
	CIfEnd()


	CIf_GCase(168)
		TriggerX(FP, {Gun_Line(6, Exactly, 0),Memory(0x657A9C, AtLeast, 1)}, {SetMemory(0x657A9C,Subtract,1)}, {preserved})
		TriggerX(FP, {Gun_Line(6, Exactly, 1),Memory(0x657A9C, AtMost, 30)}, {SetMemory(0x657A9C,Add,1)}, {preserved})
		TriggerX(FP, {Memory(0x657A9C, Exactly, 0)}, {Gun_SetLine(6, SetTo, 1)}, {preserved})
		CIfOnce(FP,Gun_Line(6, Exactly, 1))
		
			DoActions2(FP, {Simple_SetLoc(0, 288,3792,288,3792),RotatePlayer({CenterView(1)}, HumanPlayers, FP)})
			G_CB_TSetSpawn({}, {217}, Shape1217, 1, {CenterXY={0,0},OwnerTable={P6},RepeatType=217})
			f_TempRepeat({CD(GMode,1)}, 74, 3, 2, P8, {160,3712})
			f_TempRepeat({CD(GMode,1)}, 74, 3, 2, P8, {384,3616})
			f_TempRepeat({CD(GMode,1)}, 74, 3, 2, P8, {256,3936})
			f_TempRepeat({CD(GMode,1)}, 74, 3, 2, P8, {416,3872})
			f_TempRepeat({CD(GMode,2,AtLeast)}, 74, 27, 2, P8, {160,3712})
			f_TempRepeat({CD(GMode,2,AtLeast)}, 74, 27, 2, P8, {384,3616})
			f_TempRepeat({CD(GMode,2,AtLeast)}, 74, 27, 2, P8, {256,3936})
			f_TempRepeat({CD(GMode,2,AtLeast)}, 74, 27, 2, P8, {416,3872})
			CFor(FP,19025,19025+(1700*84),84)
			local CI = CForVariable()
			CIf(FP,{TMemoryX(_Add(CI,19), AtMost, 4,0xFF),TMemoryX(_Add(CI,19), AtLeast, 1*256,0xFF00)})
			f_Read(FP,_Add(CI,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP, 199, CPosX, CPosY, CPosX, CPosY, Simple_CalcLoc(199, -4, -4, 4, 4))
			DoActions(FP,{SetSwitch(RandSwitch1,Random),SetSwitch(RandSwitch2,Random)})
			local RandXY = {
				{160,3712},
				{384,3616},
				{256,3936},
				{416,3872},}
				for i = 0, 3 do
					if i == 0 then RS1 = Cleared RS2=Cleared end
					if i == 1 then RS1 = Set RS2=Cleared end
					if i == 2 then RS1 = Cleared RS2=Set end
					if i == 3 then RS1 = Set RS2=Set end
					TriggerX(FP,{Switch(RandSwitch1,RS1),Switch(RandSwitch2,RS2)},{Simple_SetLoc(0, RandXY[i+1][1], RandXY[i+1][2], RandXY[i+1][1], RandXY[i+1][2]),MoveUnit(1, "Men", Force1, 200, 1)},{preserved})
				end
			CIfEnd()
			CForEnd()
		CIfEnd()
		
		CIfOnce(FP, {Gun_Line(7, AtLeast, 240),Gun_Line(8, Exactly, 0),Bring(P8, AtMost, 0, 74, 26)}, {Gun_SetLine(8, SetTo, 1),Gun_SetLine(7,SetTo,0)})
			G_CB_TSetSpawn({CD(GMode,2,AtLeast)}, {"Kazansky","Schezar"},CellMShapeSC,nil,{OwnerTable=P6,CenterXY={0,0}})
			G_CB_TSetSpawn({CD(GMode,1)}, {"Kazansky","Schezar"},CellMShape,nil,{OwnerTable=P6,CenterXY={0,0}})
		CIfEnd()
		CIfOnce(FP, {Gun_Line(7, AtLeast, 240),Gun_Line(8, Exactly, 1)}, {Gun_SetLine(8, SetTo, 2),Gun_SetLine(7,SetTo,0)})
			G_CB_TSetSpawn({CD(GMode,2,AtLeast)}, {"Artanis","Fenix Z"},CellMShapeSC,nil,{OwnerTable=P6,CenterXY={0,0}})
			G_CB_TSetSpawn({CD(GMode,1)}, {"Artanis","Fenix Z"},CellMShape,nil,{OwnerTable=P6,CenterXY={0,0}})
		CIfEnd()
		CIfOnce(FP, {Gun_Line(7, AtLeast, 240),Gun_Line(8, Exactly, 2)}, {KillUnit(217, Force2),Gun_DoSuspend(),Gun_SetLine(7,SetTo,0)})
			G_CB_TSetSpawn({CD(GMode,2,AtLeast)}, {13,"Identity"},CellMShape,nil,{OwnerTable=P6,CenterXY={0,0}})
		CIfEnd()
--
	CIfEnd()
	CIf_GCase(256,1)--강제입력된 콜
	CDoActions(FP,{Gun_SetLine(8, Add, 0x1D)})
	Trigger2X(FP, {Gun_Line(7, Exactly, 1)}, {RotatePlayer({PlayWAVX("staredit\\wav\\Wavecall_R.ogg"),PlayWAVX("staredit\\wav\\Wavecall_R.ogg"),PlayWAVX("staredit\\wav\\Wavecall_R.ogg"),PlayWAVX("staredit\\wav\\Wavecall_R.ogg"),}, HumanPlayers, FP)},{preserved})
	--24*4
	CIf(FP,(CD(GMode,2,AtLeast)))	
		--256,400 1760,400
		function ObEff1(CenterX,CenterY)
			
		f_Lengthdir(FP, _Sub(_Mov(3800/8),_Div(Var_TempTable[9],8)), _Mul(Var_TempTable[8],2), CPosX, CPosY)
		f_Div(FP,CPosY,2)
		Simple_SetLocX(FP, 199, _Add(CPosX,CenterX), _Add(CPosY,CenterY), _Add(CPosX,CenterX), _Add(CPosY,CenterY), Simple_CalcLoc(199, -4, -4, 4, 4))
		DoActions(FP,{CreateUnit(1, 94, 200, P6)})
		f_Lengthdir(FP, _Sub(_Mov(3800/8),_Div(Var_TempTable[9],8)), _Add(_Mul(Var_TempTable[8],2),180), CPosX, CPosY)
		f_Div(FP,CPosY,2)
		Simple_SetLocX(FP, 199, _Add(CPosX,CenterX), _Add(CPosY,CenterY), _Add(CPosX,CenterX), _Add(CPosY,CenterY), Simple_CalcLoc(199, -4, -4, 4, 4))
		DoActions(FP,{CreateUnit(1, 94, 200, P6)})

		end
		--256,400 1760,400
		ObEff1(256,400)
		ObEff1(1760,400)
	CIfEnd()
	CIf(FP,(CD(GMode,3)))
		f_Lengthdir(FP, _Sub(_Mov(3800/8),_Div(Var_TempTable[9],8)), _Mul(Var_TempTable[8],2), CPosX, CPosY)
		f_Div(FP,CPosY,2)
		Simple_SetLocX(FP, 199, _Add(CPosX,Var_TempTable[2]), _Add(CPosY,Var_TempTable[3]), _Add(CPosX,Var_TempTable[2]), _Add(CPosY,Var_TempTable[3]), Simple_CalcLoc(199, -4, -4, 4, 4))
		DoActions(FP,{CreateUnit(1, 94, 200, P6)})
		f_Lengthdir(FP, _Sub(_Mov(3800/8),_Div(Var_TempTable[9],8)), _Add(_Mul(Var_TempTable[8],2),180), CPosX, CPosY)
		f_Div(FP,CPosY,2)
		Simple_SetLocX(FP, 199, _Add(CPosX,Var_TempTable[2]), _Add(CPosY,Var_TempTable[3]), _Add(CPosX,Var_TempTable[2]), _Add(CPosY,Var_TempTable[3]), Simple_CalcLoc(199, -4, -4, 4, 4))
		DoActions(FP,{CreateUnit(1, 94, 200, P6)})
		CIfEnd()


		--GNm(숫자)
		--1~6 5분간격 30분까지 일반저그종합세트1,일반저그종합세트2, 영웅저그종합세트1,영웅저그종합세트2,알타페닉스세트,카잔스키알랜세트 
		--7~9 10분간격 60분까지 히페 다니모스 린
		--10~13 15분간격 120분 2시간 까지 
		--14~17 30분간격 240분 4시간 까지 
		--18~21 60분간격 480분 8시간 까지 아덴 디비전 디스트로이어 제로 SC에서만 출현

		--CallStarS
		--CallStarSFL
		--CallStarL
		--CallStarLFL
		CIf(FP,{Gun_Line(8, AtLeast, 3800)},{Gun_DoSuspend(),Gun_SetLine(53, SetTo,1)})

			CIf(FP,(CD(GMode,2,AtLeast)))

				G_CB_TSetSpawn({}, {94}, {WarpZ}, nil, {OwnerTable=P6,LMTable=WarpZ[1]/40,SizeTable={40},CenterXY={256,400}})
				G_CB_TSetSpawn({}, {94}, {WarpZ}, nil, {OwnerTable=P6,LMTable=WarpZ[1]/40,SizeTable={40},CenterXY={1760,400}})

				function WaveGM2(GNum,ACUTable,GCUTable)
					G_CB_TSetSpawn({GNm(GNum)}, ACUTable, {CallStarS}, nil, {OwnerTable=P6,LMTable="MAX",CenterXY={256,400}})
					G_CB_TSetSpawn({GNm(GNum)}, ACUTable, {CallStarS}, nil, {OwnerTable=P6,LMTable="MAX",CenterXY={1760,400}})
					G_CB_TSetSpawn({GNm(GNum)}, GCUTable, {CallStarSFL}, nil, {OwnerTable=P6,LMTable="MAX",CenterXY={256,400}})
					G_CB_TSetSpawn({GNm(GNum)}, GCUTable, {CallStarSFL}, nil, {OwnerTable=P6,LMTable="MAX",CenterXY={1760,400}})
				end
				function WaveGM3(GNum,ACUTable,GCUTable)
					G_CB_TSetSpawn({GNm(GNum)}, ACUTable, {CallStarL}, nil, {OwnerTable=P6,LMTable="MAX"})
					G_CB_TSetSpawn({GNm(GNum)}, GCUTable, {CallStarLFL}, nil, {OwnerTable=P6,LMTable="MAX"})
				end
				WaveGM2(1,{43},{37,38})
				WaveGM2(2,{44},{39,46})
				WaveGM2(3,{55},{54,53})
				WaveGM2(4,{56},{48,51})
				WaveGM2(5,{88},{104,51})
				WaveGM2(6,{21},{50,51})

				WaveGM2(7,{28},{17,19})
				WaveGM2(8,{86},{77,78})
				WaveGM2(9,{84},{75,76})
				

				WaveGM2(10,{98},{81})
				WaveGM2(11,{58},{83})
				WaveGM2(12,{80},{93})
				WaveGM2(13,{29},{34})


				
				WaveGM2(14,{7},{65})
				WaveGM2(15,{60},{40})
				WaveGM2(16,{70},{87})
				WaveGM2(17,{62},{74})
				
				WaveGM2(18,{7},{65})
				WaveGM2(19,{60},{40})
				WaveGM2(20,{70},{87})
				WaveGM2(21,{62},{74})
				

			CIfEnd()
			CIf(FP,(CD(GMode,3)))
				G_CB_TSetSpawn({}, {94}, {WarpZ}, nil, {OwnerTable=P6,LMTable=WarpZ[1]/40})

				WaveGM3(1,{38},{41})
				WaveGM3(2,{53},{54})
				WaveGM3(3,{46},{48})
				WaveGM3(4,{104},{50})
				WaveGM3(5,{78},{77})
				WaveGM3(6,{17},{19})

				
				WaveGM3(7,{25},{81})
				WaveGM3(8,{79},{83})
				WaveGM3(9,{98},{95})

				
				WaveGM3(10,{5},{93})
				WaveGM3(11,{2},{34})
				WaveGM3(12,{3},{65})
				WaveGM3(13,{52},{66})
				
				WaveGM3(14,{70},{7})
				WaveGM3(15,{57},{40})
				WaveGM3(16,{62},{87})
				WaveGM3(17,{60},{64})

				
				WaveGM3(18,{"Division"},{"Deaths"})
				WaveGM3(19,{"Zero"},{"Destroy"})
				WaveGM3(20,{"EL FAIL"},{"DIEIN"})
				WaveGM3(21,{"LENA"},{"EL CLEAR"})
			CIfEnd()
		CIfEnd()
	CIfEnd()

	CIf_GCase(190)
	
	function PSIGunUID(GenNum,CUT)
		G_CB_TSetSpawn({Gun_Line(7,AtLeast,(GenNum*360)+0),CD(GMode,1)}, {CUT[1]}, {PSILHD1}, 1, {OwnerTable=P6,RepeatType={"Attack_Gun"}})
		G_CB_TSetSpawn({Gun_Line(7,AtLeast,(GenNum*360)+0),CD(GMode,2,AtLeast)}, {CUT[1]}, {PSILSC1}, 1, {OwnerTable=P6,RepeatType={"Attack_Gun"}})
		G_CB_TSetSpawn({Gun_Line(7,AtLeast,(GenNum*360)+120),CD(GMode,1)}, {CUT[2]}, {PSICHD1}, 1, {OwnerTable=P7,RepeatType={"Attack_Gun"}})
		G_CB_TSetSpawn({Gun_Line(7,AtLeast,(GenNum*360)+120),CD(GMode,2,AtLeast)}, {CUT[2]}, {PSICSC1}, 1, {OwnerTable=P7,RepeatType={"Attack_Gun"}})
		G_CB_TSetSpawn({Gun_Line(7,AtLeast,(GenNum*360)+240),CD(GMode,1)}, {CUT[3]}, {PSISHD1}, 1, {OwnerTable=P8,RepeatType={"Attack_Gun"}})
		G_CB_TSetSpawn({Gun_Line(7,AtLeast,(GenNum*360)+240),CD(GMode,2,AtLeast)}, {CUT[3]}, {PSISSC1}, 1, {OwnerTable=P8,RepeatType={"Attack_Gun"}})
		
		G_CB_TSetSpawn({Gun_Line(7,AtLeast,(GenNum*360)+0),CD(GMode,1)}, {94}, {PSILHD1}, 1, {OwnerTable=P6})
		G_CB_TSetSpawn({Gun_Line(7,AtLeast,(GenNum*360)+0),CD(GMode,2,AtLeast)}, {94}, {PSILSC1}, 1, {OwnerTable=P6})
		G_CB_TSetSpawn({Gun_Line(7,AtLeast,(GenNum*360)+120),CD(GMode,1)}, {94}, {PSICHD1}, 1, {OwnerTable=P6})
		G_CB_TSetSpawn({Gun_Line(7,AtLeast,(GenNum*360)+120),CD(GMode,2,AtLeast)}, {94}, {PSICSC1}, 1, {OwnerTable=P6})
		G_CB_TSetSpawn({Gun_Line(7,AtLeast,(GenNum*360)+240),CD(GMode,1)}, {94}, {PSISHD1}, 1, {OwnerTable=P6})
		G_CB_TSetSpawn({Gun_Line(7,AtLeast,(GenNum*360)+240),CD(GMode,2,AtLeast)}, {94}, {PSISSC1}, 1, {OwnerTable=P6})
		end
		CIf(FP,GNm(1))
		PSIGunUID(0,{86,25,75})
		PSIGunUID(1,{84,76,79})
		PSIGunUID(2,{98,83,95})
		PSIGunUID(3,{58,81,5})
		CIfEnd()

		CIf(FP,GNm(2))
		PSIGunUID(0,{80,2,34})
		PSIGunUID(1,{29,3,52})
		PSIGunUID(2,{7,65,66})
		PSIGunUID(3,{64,40,87})
		CIfEnd()

		
		CTrigger(FP,{Gun_Line(7,AtLeast,360*4)},{Gun_DoSuspend()},1)
	CIfEnd()
	
	
	
	
	
	
	
	
	
	
	
	
	CIf_GCase(175)
	function LDSetSpawn(SNm,CUTable)
		G_CB_TSetSpawn({Gun_Line(7,AtLeast,(SNm*480)),CD(GMode,1)}, CUTable, LDH, 1, {OwnerTable={P7,P8},LMTable="MAX"})
		G_CB_TSetSpawn({Gun_Line(7,AtLeast,(SNm*480)),CD(GMode,2,AtLeast)}, CUTable, LD, 1, {OwnerTable={P7,P8},LMTable="MAX"})
	end
	LDSetSpawn(0,{"Lizzet","Yona"})
	LDSetSpawn(1,{"Rose","Sui"})
	LDSetSpawn(2,{"Era","Jisoo"})
	LDSetSpawn(3,{"Sera","Freyja"})
	LDSetSpawn(4,{"Sena","Sadol"})

	CTrigger(FP,{Gun_Line(7,AtLeast,480*4)},{Gun_DoSuspend()},1)
	CIfEnd()

	CIf_GCase(147)
	LDSetSpawn(0,{"Merry","Rophe"})
	LDSetSpawn(1,{"Norad II","Shirley House"})
	LDSetSpawn(2,{"Nina","Yuri"})
	LDSetSpawn(3,{"Sorang","Kamilia"})
	LDSetSpawn(4,{"Sen","Gaya"})
	CTrigger(FP,{Gun_Line(7,AtLeast,480*4)},{Gun_DoSuspend()},1)
	CIfEnd()
	
	CIf_GCase(152)
	function RBSetSpawn(SNm,CUTable1,CUTable2,CUTable3)
		G_CB_TSetSpawn({Gun_Line(7,AtLeast,(SNm*480)),CD(GMode,1)}, CUTable1, RBLineHD, 1, {OwnerTable=P7,LMTable="MAX",CenterXY={1024,7776}})
		G_CB_TSetSpawn({Gun_Line(7,AtLeast,(SNm*480)),CD(GMode,2,AtLeast)}, CUTable1, RBLine, 1, {OwnerTable=P7,LMTable="MAX",CenterXY={1024,7776}})
		
		G_CB_TSetSpawn({Gun_Line(7,AtLeast,(SNm*480)),CD(GMode,1)}, CUTable2, RBFillHD, 1, {OwnerTable=P7,LMTable="MAX",CenterXY={1024,7776}})
		G_CB_TSetSpawn({Gun_Line(7,AtLeast,(SNm*480)),CD(GMode,2,AtLeast)}, CUTable2, RBFill, 1, {OwnerTable=P7,LMTable="MAX",CenterXY={1024,7776}})
		
		G_CB_TSetSpawn({Gun_Line(7,AtLeast,(SNm*480)),CD(GMode,1)}, CUTable3, RBCHD, 1, {OwnerTable=P7,LMTable="MAX",CenterXY={1024,7776}})
		G_CB_TSetSpawn({Gun_Line(7,AtLeast,(SNm*480)),CD(GMode,2,AtLeast)}, CUTable3, RBC, 1, {OwnerTable=P7,LMTable="MAX",CenterXY={1024,7776}})
	end
	
	RBSetSpawn(0,{"Sorang"},{"Gaya","Yuri"},{"Sera"})
	RBSetSpawn(1,{"Sena"},{"Deaths"},{"Era"})
	RBSetSpawn(2,{"Sen"},{"Sadol","Leon"},{"Zero"})
	RBSetSpawn(3,{"Identity"},{"Destroy"},{"Division"})
	CTrigger(FP,{Gun_Line(7,AtLeast,480*3)},{Gun_DoSuspend()},1)
	CIfEnd()
	--1024,7776
	CIf_GCase(189,1)--강제입력된 화홀
	--6 = CurSpeed
	DoActionsX(FP, {Gun_SetLine(6, SetTo, 0x1D)}, 1)--처음기본배속
	CDoActions(FP, {TGun_SetLine(8, Add, Var_TempTable[7]),TSetMemory(0x5124F0, SetTo, Var_TempTable[7])})--배속은 변수에 의해 고정되고 배속에 따라 화홀의 밀리세컨드 단위가 달라진다.
	
	local Lyrics = {
		{"\x0D\x0D!H\x13\x07♪ \x0FS\x04ong \x08T\x04itle \x07♪",2520},
		{"\x0D\x0D!H\x13\x07♪ \x11g\x04lory\x11MAX \x07♪",5050},
		{"\x0D\x0D!H\x13\x07♪ \x07나\x04의 \x11최대치\x04로 \x08너\04와 \x1F함께할게 \x07♪",7570},
		{"\x0D\x0D!H\x13\x07♪ \x07from \x17DJMAX \x17R\x04espect \x17V \x07♪",10100},
		{"\x0D\x0D!H\x13\x07♪ \x17V E\x04XTENSION \x17V \x04(2023) \x07♪",10100},
		{"\x0D\x0D!H\x13\x07♪ \x11we go\x04, \x0Ewe go\x04, \x0Fwe go \x17H\x04igher \x07♪",24310},
		{"\x0D\x0D!H\x13\x07♪ \x1C저 하늘 위로 \x1FSkydive \x07♪",26840},
		{"\x0D\x0D!H\x13\x07♪ \x04미뤄 미뤄 버린 \x08걱정 \x07♪",29680},
		{"\x0D\x0D!H\x13\x07♪ \x04이제 \x07Goodbye \x07♪",31260},
		{"\x0D\x0D!H\x13\x07♪ \x1FForever\x04, and \x1CEver \x07♪",32360},
		{"\x0D\x0D!H\x13\x07♪ \x10Whatever\x04, \x08no \x11Matter \x10what \x07♪",33630},
		{"\x0D\x0D!H\x13\x07♪ \x04난 \x08너 \x19하나면 \x07충분한 걸 \x07♪",35210},
		{"\x0D\x0D!H\x13\x07♪ \x1E손끝\x04에 닿은 \x17멜로디\x04에 \x07♪",37570},
		{"\x0D\x0D!H\x13\x07♪ \x10꿈\x04에서 깬 우린 지금 \x07만나게 돼 \x07♪",39940},
		
		{"\x0D\x0D!H\x13\x07♪ \x10기억 속 너\x04의 \x1F낮\x04과 \x1C밤 \x04사이 \x07♪",42470},
		{"\x0D\x0D!H\x13\x07♪ \x04남겨진 \x18추억들 \x11위\x04에 \x07♪",45000},
		
		{"\x0D\x0D!H\x13\x07♪ \x1F반짝이는 나\x04를 꺼내 \x07♪",47840},
		{"\x0D\x0D!H\x13\x07♪ \x04언제든 \x0FPlay \x04me \x07once again \x07♪",50360},

		{"\x0D\x0D!H\x13\x07♪ \x05새까만 밤하늘 빛을 잃어간 \x07♪",52570},
		{"\x0D\x0D!H\x13\x07♪ \x19별들\x04이 하나씩 \x08사라진다 해도 \x07♪",55420},
		{"\x0D\x0D!H\x13\x07♪ \x11(그런대도) \x07♪",58420},

		{"\x0D\x0D!H\x13\x07♪ \x07나\x04의 \x11최대치\x04로 \x07♪",60150},
		{"\x0D\x0D!H\x13\x07♪ \x08너\x04와 \x1F함께할게 \x07♪",61730},

		
		--{"\x0D\x0D!H\x13\x07♪ ~ \x10M\x04isty \x10E\x04'ra '\x10M\x04ui' ~ \x07♪",72780},
		{"\x0D\x0D!H\x13\x07♪ \x10fah shu nee \x07♪",72780},
		{"\x0D\x0D!H\x13\x07♪ \x10주문\x04의 \x11목소리\x04가 들리네. \x07♪",72780},
		
		{"\x0D\x0D!H\x13\x07♪ \x10veshu, me de su te ar \x07♪",75470},
		{"\x0D\x0D!H\x13\x07♪ \x08두려워하라\x04, \x11내\x04가 \x17눈\x04을 뜰 것이니 \x07♪",75470},

		{"\x0D\x0D!H\x13\x07♪ \x10Nich jak fa hef khan \x07♪",77680},
		{"\x0D\x0D!H\x13\x07♪ \x08너희\x04는 \x06지옥불\x04로 떨어져 \x07♪",77680},

		{"\x0D\x0D!H\x13\x07♪ \x10vir muk ar \x07♪",80840},
		{"\x0D\x0D!H\x13\x07♪ \x1F심판\x04을 받으리라 \x07♪",80840},

		
		{"\x0D\x0D!H\x13\x07♪ \x11G\x04lory \x19Day \x07♪",86360},
		{"\x0D\x0D!H\x13\x07♪ \x04(I \x10Never \x08Die\x04) \x07♪",87150},
		
		{"\x0D\x0D!H\x13\x07♪ \x11G\x04lory \x1FLight \x07♪",91570},
		{"\x0D\x0D!H\x13\x07♪ \x04(\x1D시간\x04을 넘어) \x07♪",91570},
		{"\x0D\x0D!H\x13\x07♪ \x04(\x1E널 만날 수 있다면\x04) \x07♪",94100},

		{"\x0D\x0D!H\x13\x07♪ \x04My \x17Only \x1DOne \x07♪",96470},
		{"\x0D\x0D!H\x13\x07♪ \x04(\x10결과 \x04속 \x17흥\x10망\x04에) \x07♪",96470},
		{"\x0D\x0D!H\x13\x07♪ \x04(\x1C상관없이 \x04그저 \x1B끌리는 대로\x04) \x07♪",99150},

		{"\x0D\x0D!H\x13\x07♪ \x04My \x17Only \x1FLight \x07♪",101360},
		{"\x0D\x0D!H\x13\x07♪ \x04(\x07달려갔던 \x04지금 \x08너\x04와 \x07나\x04) \x07♪",104360},

		
		
		{"\x0D\x0D!H\x13\x07♪ \x04(\x11G\x04lory \x19Day\x04) \x07♪",109100},
		{"\x0D\x0D!H\x13\x07♪ \x10기억 속 너\x04의 \x1F낮\x04과 \x1C밤 \x04사이 \x07♪",109420},
		{"\x0D\x0D!H\x13\x07♪ \x04(\x11G\x04lory \x1FLight\x04) \x07♪",111630},
		{"\x0D\x0D!H\x13\x07♪ \x04남겨진 \x18추억들 \x11위\x04에 \x07♪",111940},
		
		{"\x0D\x0D!H\x13\x07♪ \x04(\x04My \x17Only \x1DOne\x04) \x07♪",114150},
		{"\x0D\x0D!H\x13\x07♪ \x1F반짝이는 나\x04를 꺼내 \x07♪",114780},
		{"\x0D\x0D!H\x13\x07♪ \x04(\x04My \x17Only \x1FLight\x04) \x07♪",116680},
		{"\x0D\x0D!H\x13\x07♪ \x04언제든 \x0FPlay \x04me \x07once again \x07♪",117310},

		{"\x0D\x0D!H\x13\x07♪ \x04(\x11G\x04lory \x19Day\x04) \x07♪",119210},
		{"\x0D\x0D!H\x13\x07♪ \x05새까만 밤하늘 빛을 잃어간 \x07♪",119520},
		{"\x0D\x0D!H\x13\x07♪ \x04(\x11G\x04lory \x1FLight\x04) \x07♪",121730},
		
		{"\x0D\x0D!H\x13\x07♪ \x19별들\x04이 하나씩 \x08사라진다 해도 \x07♪",122360},
		{"\x0D\x0D!H\x13\x07♪ \x04(\x11그런대도\x04) \x07♪",125360},

		{"\x0D\x0D!H\x13\x07♪ \x1F끝없는 \x11최대치\x04로 \x07♪",127100},
		{"\x0D\x0D!H\x13\x07♪ \x08너\x04와 \x1F함께할게 \x07♪",129940},

		
		

		
		

		{"\x0D\x0D!H\x13\x07♪ \x04my \x11g\x04lory \x11MAX \x07♪",133100},
		{"\x0D\x0D!H\x13\x07♪ \x04for \x08You \x04and \x07I \x07♪",135470},
		{"\x0D\x0D!H\x13\x07♪ \x04to the \x11MAX\x16imum \x07♪",140520},
		
		
		
		{"\x0D\x0D!H\x13\x07♪ \x04(\x07I \x1Fnever \x08\"D\x04IE \x08I\x04N\x08\"\x04) \x07♪",143840},
		{"\x0D\x0D!H\x13\x07♪ \x0F바람\x04의 \x18끝\x04까지 \x07♪",144940},
		{"\x0D\x0D!H\x13\x07♪ \x07나\x04의 \x11최대치\x04로 \x07♪",148570},
		{"\x0D\x0D!H\x13\x07♪ \x08너\x04와 \x10영원할게 \x07♪",150150},

		
		

		
		
		

		
		

		
		




	}
	
    for i = 1, 61 do
		local WAVS
        if i <= 9 then
            WAVS = "staredit\\wav\\gMAX_00"..i..".ogg"
        elseif i >= 10 and i<= 99 then
            WAVS = "staredit\\wav\\gMAX_0"..i..".ogg"
        else
            WAVS = "staredit\\wav\\gMAX_"..i..".ogg"
        end
		Trigger2X(FP,{Gun_Line(8,AtLeast,(i-1)*2520)},{RotatePlayer({PlayWAVX(WAVS),PlayWAVX(WAVS),PlayWAVX(WAVS)},HumanPlayers,FP)})
    end
	for j, k in pairs(Lyrics) do
		Trigger2X(FP, {Gun_Line(8,AtLeast,k[2])}, {RotatePlayer({DisplayTextX(k[1], 4)},HumanPlayers,FP)})
	end


	SpCodeBase = 0x8080E200 
	SpCode0 = 0x8880E200 -- 식별자 (텍스트 미출력 라인은 첫 1바이트가 00으로 고정됨) 
	SpCode3 = 0x8B80E200 -- \x0D\x0D!H
	function HTextEff() -- ScanChat -> 11줄 전체를 utf8 -> iutf8화 (식별자로 중복방지) 
	CA__SetNext(HStr2,8,SetTo,0,54*11-1,0)
	CA__SetNext(HStr4,8,SetTo,0,54-1,0)
	CMov(FP,HLine,0)
	EffCV2 = CreateVArr(11, FP)
	VArrI,VArrI4 = CreateVars(2,FP)

	DoActionsX(FP, {SetV(VArrI,0),SetV(VArrI4,0)})

	CWhile(FP,NVar(HLine,AtMost,10),SetNVar(HCheck,SetTo,0))
		f_ChatOffset(FP,HLine,0,ChatOff) 
		CMovX(FP,HCheck,VArrX(EffCV2, VArrI, VArrI4))
		CIfX(FP,{TTbytecmp(ChatOff,VArr(HVA3,0),GetStrSize(0,"\x0D\x0D!H"))},{SetNVar(HCheck,SetTo,3)})
	--    for i = 0, 3 do
	--        CElseIfX({HumanCheck(i, 1),TTbytecmp(ChatOff,VArr(Names2[i+1],0),PLength[i+1])},{SetNVar(HCheck,SetTo,4)})
	--    end
		CElseIfX({TTDisplayX(HLine,0,NotSame,SpCode3,0xFFFFFF00)},{SetNVar(HCheck,SetTo,0)})
		CIfXEnd()

		CurLiV = CreateVar(FP)
		EffCV = CreateVArr(11, FP)
		CIf(FP,{NVar(HCheck,AtLeast,3),NVar(HCheck,AtMost,4)})
		CIfX(FP,{TTDisplayX(HLine,0,"!=",SpCodeBase,0xF0FFFF00)}) -- 0x8080E2 ~ 0x8F80F2 인식
			CMovX(FP,VArr(EffCV,HLine),0)
			CMov(FP,CurLiV, _Mul(HLine,54*604))
			CA__SetValue(HStr2,MakeiStrLetter("\x0D",53),0xFFFFFFFF,CurLiV,1,1) 
			CD__ScanChat(SVA1(HStr2,CurLiV),ChatOff,52,ChatSize,0,1) 
			CIfX(FP,NVar(HCheck,Exactly,3))
				CA__SetValue(HStr2,MakeiStrLetter("\x0D",2),0xFFFFFFFF,CurLiV,1,1) 
				CA__SetMemoryX(_GIndex2(HLine,0),SpCode3+0x0D,0xFFFFFFFF,1) 
			CElseX()
				CA__SetMemoryX(_GIndex2(HLine,0),SpCode0+0x0D,0xFFFFFFFF,1) 
			CIfXEnd()

			CIf(FP,{TTNVar(HCheck, NotSame, 3)})
			CD__InputVAX(_GIndex2(HLine,1),SVA1(HStr2,CurLiV),52,0xFFFFFFFF,0xFFFFFFFF,8,604*11-1)
			CIfEnd()
			CD__InputMask(HLine,0xFFFFFFFF,0,52) 
		CElseIfX({TTDisplay(HLine,"On"),TTDisplayX(HLine,0,Exactly,SpCode3,0xFFFFFF00)}) 
		TempEC = CreateVar(FP)
			CMov(FP,CurLiV, _Mul(HLine,54*604))
			CMovX(FP,TempEC,VArr(EffCV,HLine))
			CD__InputVAX(_GIndex2(HLine,1),HStr4,52,0xFFFFFFFF,0xFFFFFFFF,8,604*11-1)
			CD__InputVAX(_GIndex2(HLine,1),SVA1(HStr2,CurLiV),TempEC,0xFFFFFFFF,0xFFFFFFFF,8,604*11-1)
			CIf(FP,NVar(TempEC,AtMost,51),SetNVar(TempEC, Add, 1))
				CMovX(FP,VArr(EffCV,HLine),TempEC)
			CIfEnd()
		CIfXEnd()
		CIfEnd()


		CMovX(FP,VArrX(EffCV2, VArrI, VArrI4),HCheck)
	CWhileEnd({SetNVar(HLine,Add,1),AddV(VArrI,604),AddV(VArrI4,2416)}) 
	end 
	CDPrint(0,11,{"\x0D",0,0},{Force1,Force2,Force5},{1,0,0,0,1,1,0,0},"HTextEff",FP) 

	CIfEnd()
	

	if TestStart == 1 then
		--DisplayPrint(HumanPlayers, {"Executer",f_GunNum," : ",Var_TempTable[1]," ",Var_TempTable[2]," ",Var_TempTable[3]," ",Var_TempTable[4]," ",Var_TempTable[5]," ",Var_TempTable[6]," ",Var_TempTable[7]," ",Var_TempTable[8]," ",Var_TempTable[9]," ",Var_TempTable[10]})
	end
	
	CIf(FP,{TTOR({ -- 2젠 건작 목록
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
		}),})
		CIf(FP,{Gun_Line(54,AtMost,0)},{Gun_SetLine(5,SetTo,1)})
		CTrigger(FP,{Gun_Line(6,AtLeast,1)},{Gun_DoSuspend()},1)
		CTrigger(FP,{Gun_Line(7,AtLeast,480)},{Gun_SetLine(6,SetTo,1)},1)
		CIfEnd()
	CIfEnd()
	
	CTrigger(FP,{GNm(51,AtLeast)},{Gun_SetLine(54,SetTo,1),RotatePlayer({DisplayTextX(GunCaseErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)},1)

	CTrigger(FP,{CD(GunCaseCheck,0)},{Gun_SetLine(54,SetTo,1),RotatePlayer({DisplayTextX(GunCaseErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)},1)
	GunPushTrig = {}
	for i = 0, 54 do
		table.insert(GunPushTrig,TSetMemory(_Add(G_TempH,(i*0x20)/4),SetTo,Var_TempTable[i+1]))
	end
	CDoActions(FP,GunPushTrig)
	CIf(FP,{Gun_Line(54,AtLeast,1),}) -- SuspendCode
		TriggerX(FP,{Gun_Line(53,Exactly,0)},{SubCD(GunCcode,1)},{preserved})
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