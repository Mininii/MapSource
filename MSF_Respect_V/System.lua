﻿function System()

	iTblJump = def_sIndex()
	CJump(FP, iTblJump)
	t01 = "\x07。\x18˙\x0F+\x1C˚  0000000000 \x04(00000\x0D\x04) \x1C。\x0F+\x18.\x07˚"
	t03 = "\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"
	iStrSize1 = GetiStrSize(0,t01)
	S1 = MakeiTblString(1394,"None",'None',MakeiStrLetter("\x0D",iStrSize1+5),"Base",1) -- 단축키없음
	iTbl3 = GetiTblId(FP,1396,S1) --DMG
	iTbl4 = GetiTblId(FP,1397,S1) --DMG
	iTbl5 = GetiTblId(FP,764,S1) --DMG
	iTbl9 = GetiTblId(FP,1299,S1) --실명
	Str1, Str1a, Str1s = SaveiStrArrX(FP,t01)
	Str3, Str3a, Str3s = SaveiStrArrX(FP,t03)
	t04 = "\x07。\x18˙\x0F+\x1C˚\x19 R\x04espect \x17V! \x19(つ>ㅅ<)つ \x1C。\x0F+\x18.\x07˚"--일반
	t05 = "\x07。\x18˙\x0F+\x1C˚\x19 R\x04espect \x17V! \x19(つXㅅ<)つ \x1C。\x0F+\x18.\x07˚"--디텍터
	t06 = "\x07。\x18˙\x0F+\x1C˚\x19 R\x04espect \x17V! \x19(つ3ㅅ3)つ \x1C。\x0F+\x18.\x07˚"--패로사이트
	--iTbl7 = GetiTblId(FP,1319,S1) --DMG
	--iTbl8 = GetiTblId(FP,831,S1) --DMG
	--Str4, Str4a, Str4s = SaveiStrArrX(FP,t04)
	--Str5, Str5a, Str5s = SaveiStrArrX(FP,t05)
	T290 = "\x07。\x18˙\x0F+\x1C˚\x1F 행\x04이오닉 \x1C충\x04격파 \x19(つ>ㅅ<)つ \x1C。\x0F+\x18.\x07˚\x02 "
	T426 = "\x07。\x18˙\x0F+\x1C˚\x19(つ>ㅅ<)つ \x1C。\x0F+\x18.\x07˚\x02"
	T1365 = "\x07。\x18˙\x0F+\x1C˚\x19 흥\x04이오닉 \x08어\x04썰트 \x19(つ>ㅅ<)つ \x1C。\x0F+\x18.\x07˚\x02 "
	T1414 = "\x07。\x18˙\x0F+\x1C˚\x1F 행\x04이오닉 \x1C스\x04톰 \x19(つ>ㅅ<)つ \x1C。\x0F+\x18.\x07˚\x02 "
	T1366 = "\x07。\x18˙\x0F+\x1C˚\x1F \x10망\x04이 \x08레이저\x16빔 \x19(つ\x08X\x19ㅅ<)つ \x1C。\x0F+\x18.\x07˚\x02"
	TBLData = {
		{1319,t04},
		{831,t05},
		{290,T290},
		{426,T426},
		{1365,T1365},
		{1414,T1414},
		{218,T426},
		{827,t06},
		{1366,T1366},

	}

	

	CJumpEnd(FP, iTblJump)

	CIfOnce(FP)
	
	for j,k in pairs(TBLData) do
		local TBLPtr = CreateVar(FP)
		f_GetTblptr(FP, TBLPtr, k[1])
		local CText = CreateCText(FP, k[2])
		f_Memcpy(FP,TBLPtr,_TMem(Arr(CText[3],0),"X","X",1),CText[2])
	end
	CIfEnd()
	

local SelEPD,SelHP,SelSh,SelMaxHP,SelI = CreateVars(5,FP)
local CurEPD = CreateVar(FP)
local SelWepID = CreateVar(FP)
local AFlag = CreateCcode()
local BFlag = CreateCcode()
local NWepCcode = CreateCcode()
local SelATK = CreateVar(FP)
local SelClass = CreateVar(FP)
local SelAtkType = CreateVar(FP)
local SelShbool = CreateVar(FP)
	CIf(FP,{Memory(0x6284B8 ,AtLeast,1),Memory(0x6284B8 + 4,AtMost,0)})
		f_Read(FP,0x6284B8,nil,SelEPD)
		f_Read(FP,_Add(SelEPD,25),SelUID,"X",0xFF)
		f_Read(FP,_Add(SelEPD,2),SelHP)
		f_Read(FP,_Add(SelEPD,24),SelSh,"X",0xFFFFFF)
		f_Div(FP,SelHP,_Mov(256))
		f_Div(FP,SelSh,_Mov(256))
		CS__SetValue(FP, Str1, t01, nil, 0,1,1)

		CS__ItoCustom(FP,SVA1(Str1,0+5),SelHP,nil,nil,{10,10},1,nil,"\x040",0x04,{0,1,2,3,4,5,6,7,8,9})
		CS__ItoCustom(FP,SVA1(Str1,13+5),SelSh,nil,nil,{10,5},1,nil,"\x1C0",0x1C,{0,1,2,3,4})
		--CS__ItoCustom(FP,SVA1(Str2,23),SelATK,nil,nil,{10,3},1,{"\x0D","\x1F0","\x1F0"},nil,0x1F,{0,1,3})
		--CS__InputVA(FP,iTbl2,0,Str2,Str2s,nil,0,Str2s)

		CIf(FP,{TTCVar(FP,SelEPD[2],NotSame,CurEPD)},{SetCD(AFlag,0),SetCD(NWepCcode, 0)})
			CMov(FP,CurEPD,SelEPD)
			local LCunitIndex = CreateVar(FP)
			CMov(FP,LCunitIndex,_Div(_Sub(SelEPD,19025),_Mov(84)))
			f_BreadX(FP, 0x6647B0, SelUID, SelShbool)
			f_BreadX(FP, 0x663DD0, SelUID, SelClass)
			TriggerX(FP,CV(SelUID,5),SetV(SelUID,6),{preserved})
			TriggerX(FP,CV(SelUID,23),SetV(SelUID,24),{preserved})
			TriggerX(FP,CV(SelUID,25),SetV(SelUID,26),{preserved})
			TriggerX(FP,CV(SelUID,30),SetV(SelUID,31),{preserved})
			TriggerX(FP,CV(SelUID,3),SetV(SelUID,4),{preserved})
			TriggerX(FP,CV(SelUID,17),SetV(SelUID,18),{preserved})
			TriggerX(FP,CV(SelUID,77),SetCD(AFlag,1),{preserved})
			TriggerX(FP,CV(SelUID,65),SetCD(AFlag,1),{preserved})
			TriggerX(FP,CV(SelUID,15),SetCD(AFlag,1),{preserved})
			f_BreadX(FP, 0x6636B8, SelUID, SelWepID)
			local ObjectNumV = CreateVar(FP)
			if TestStart == 1 then
				DisplayPrint(0, {"SelWepID : ", SelWepID})
			end
			CIfX(FP,{CV(SelWepID,129,AtMost)})
			f_WreadX(FP, 0x656EB0, SelWepID, SelATK)
			f_BreadX(FP, 0x657258, SelWepID, SelAtkType)
			f_BreadX(FP, 0x6564E0, SelWepID, ObjectNumV)
			CElseX({SetCD(NWepCcode,1)})
			CIfXEnd()
			CTrigger(FP,{CV(ObjectNumV,2)},{SetCD(AFlag,1)},1)
			CIf(FP,{CD(AFlag,1)})
				CAdd(FP,SelATK,SelATK)
			CIfEnd()

			CIf(FP,CV(SelUID,190))--프사이
				
			local PSITBLPtr = CreateVar(FP)
			local PSIGunNum = CreateVar(FP)
			f_GetTblptr(FP, PSITBLPtr, 191)
			local CText1 = CreateCText(FP, "\t\t\t\x1E。˙+˚Hell'o。+.˚\x12\x08。˙+˚H\x04ell'o\x08。+.˚\t\t\t\t\t  ")--HellO
			local CText2 = CreateCText(FP, "\t\x11。˙+˚O\'men。+.˚\x12\x08。˙+˚O\x04\'men\x08。+.˚\t\t\t\t\t\t\t    ")--OMen
			f_Read(FP, _Add(_Mul(LCunitIndex,_Mov(0x970/4)),_Add(DUnitCalc[3],((0x20*2)/4))), PSIGunNum)
			CIf(FP,{CV(PSIGunNum,1)})
			f_Memcpy(FP,PSITBLPtr,_TMem(Arr(CText1[3],0),"X","X",1),CText1[2])
			CIfEnd()
			CIf(FP,{CV(PSIGunNum,2)})
			f_Memcpy(FP,PSITBLPtr,_TMem(Arr(CText2[3],0),"X","X",1),CText2[2])
			CIfEnd()

			CIfEnd()
			
		CIfEnd()

		CIf(FP, {CV(SelShbool,0)})
			CS__SetValue(FP, Str1, "\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D", nil, 17,1)
		CIfEnd()
		KillsV = CreateVar(FP)
		f_Read(FP, _Add(SelEPD,35), KillsV)
		CrShift(FP, KillsV, 24)
		CS__ItoCustom(FP,SVA1(Str3,30),KillsV,nil,nil,{10,3},1,nil,"\x080",0x08,{0,1,2})
		local CFlag = CreateCcode()
		DoActionsX(FP, {SetCD(CFlag,0)})

		CIfX(FP, {CD(NWepCcode,1)})
		CS__SetValue(FP, Str3, "\x0EN\x04o \x0EW\x04eapons \x04- \x07K\x04ills\x03: \x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D", 0xFFFFFFFF,1)
		for i = 0, 9 do
			TriggerX(FP, {CSVA1(SVA1(Str1,6+i), AtLeast, 0x0E*0x1000000, 0xFF000000),CD(CFlag,0)}, {SetCD(CFlag, 1),SetCSVA1(SVA1(Str1,6+i), SetTo, 0x07, 0xFF)}, {preserved})
		end
		CS__InputVA(FP,iTbl9,0,Str1,Str1s,nil,0,Str1s)
		
		CS__InputVA(FP,iTbl5,0,Str3,Str3s,nil,0,Str3s)
		CElseX()
		CIfX(FP,{CV(SelClass,95)})-- SC타입
		CS__SetValue(FP, Str3, "\x08S\x04C \x08S\x04tyle \x04- \x07K\x04ills\x03: \x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D", 0xFFFFFFFF,1)
		for i = 0, 9 do
			TriggerX(FP, {CSVA1(SVA1(Str1,6+i), AtLeast, 0x0E*0x1000000, 0xFF000000),CD(CFlag,0)}, {SetCD(CFlag, 1),SetCSVA1(SVA1(Str1,6+i), SetTo, 0x08, 0xFF)}, {preserved})
		end
		CS__InputVA(FP,iTbl4,0,Str1,Str1s,nil,0,Str1s)
		CS__InputVA(FP,iTbl5,0,Str3,Str3s,nil,0,Str3s)
		CElseIfX({CV(SelAtkType,3)})-- 일반형
		CS__SetValue(FP, Str3, "\x1BN\x04ormal \x04- \x07K\x04ills\x03: \x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D", 0xFFFFFFFF,1)
		for i = 0, 9 do
			TriggerX(FP, {CSVA1(SVA1(Str1,6+i), AtLeast, 0x0E*0x1000000, 0xFF000000),CD(CFlag,0)}, {SetCD(CFlag, 1),SetCSVA1(SVA1(Str1,6+i), SetTo, 0x1B, 0xFF)}, {preserved})
		end
		CS__InputVA(FP,iTbl3,0,Str1,Str1s,nil,0,Str1s)
		CS__InputVA(FP,iTbl5,0,Str3,Str3s,nil,0,Str3s)
		CElseIfX({CV(SelAtkType,4)})-- 방어무시
		CS__SetValue(FP, Str3, "\x1FI\x04gnore \x04- \x07K\x04ills\x03: \x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D", 0xFFFFFFFF,1)
		for i = 0, 9 do
			TriggerX(FP, {CSVA1(SVA1(Str1,6+i), AtLeast, 0x0E*0x1000000, 0xFF000000),CD(CFlag,0)}, {SetCD(CFlag, 1),SetCSVA1(SVA1(Str1,6+i), SetTo, 0x1F, 0xFF)}, {preserved})
		end
		CS__InputVA(FP,iTbl3,0,Str1,Str1s,nil,0,Str1s)
		CS__InputVA(FP,iTbl5,0,Str3,Str3s,nil,0,Str3s)
		CElseIfX(CV(SelAtkType,1))--폭발형
		CS__SetValue(FP, Str3, "\x11E\x04xplosion \x04- \x07K\x04ills\x03: \x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D", 0xFFFFFFFF,1)
		for i = 0, 9 do
			TriggerX(FP, {CSVA1(SVA1(Str1,6+i), AtLeast, 0x0E*0x1000000, 0xFF000000),CD(CFlag,0)}, {SetCD(CFlag, 1),SetCSVA1(SVA1(Str1,6+i), SetTo, 0x11, 0xFF)}, {preserved})
		end
		CS__InputVA(FP,iTbl3,0,Str1,Str1s,nil,0,Str1s)
		CS__InputVA(FP,iTbl5,0,Str3,Str3s,nil,0,Str3s)
		CElseIfX(CV(SelAtkType,2))--진동형
		CS__SetValue(FP, Str3, "\x1DC\x04oncussive \x04- \x07K\x04ills\x03: \x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D", 0xFFFFFFFF,1)
		for i = 0, 9 do
			TriggerX(FP, {CSVA1(SVA1(Str1,6+i), AtLeast, 0x0E*0x1000000, 0xFF000000),CD(CFlag,0)}, {SetCD(CFlag, 1),SetCSVA1(SVA1(Str1,6+i), SetTo, 0x1D, 0xFF)}, {preserved})
		end
		CS__InputVA(FP,iTbl3,0,Str1,Str1s,nil,0,Str1s)
		CS__InputVA(FP,iTbl5,0,Str3,Str3s,nil,0,Str3s)
		CIfXEnd()
		CIfXEnd()
		
		
		
	CIfEnd()


	DoActions(FP, {
		CreateUnit(1, 94, 20, P8),RemoveUnit(94, P8)
	})





	DoActions(FP, {ModifyUnitEnergy(All, 40, AllPlayers, 64, 100)})

	--[[
	Line Usage
	0 = 
	]]
	EXCC_Part1(UnivCunit) -- 기타 구조오프셋 단락 시작

	MRCheck = def_sIndex()
	NJumpX(FP,MRCheck,DeathsX(CurrentPlayer,Exactly,101,0,0xFF)) -- 맵리벌러 트리거작동 제외
	--CIf(FP,DeathsX(CurrentPlayer,Exactly,3,0,0xFF))--셜리하우스 보조유닛 iScript로 제어하기
	--	f_SaveCp()
	--	SubUnitPtr = CreateVar(FP)
	--	CIf(FP,{TMemory(_Add(BackupCp, 3), AtLeast, 1)})
	--	f_Read(FP, _Add(BackupCp, 3), nil, SubUnitPtr)
	--	CDoActions(FP, {TSetMemoryX(_Add(SubUnitPtr,8),SetTo,2+(127*65536),0xFF00FF)})
	--	CIfEnd()
	--	f_LoadCp()
	--	if Limit == 1 then
	--		EXCC_ClearCalc()
	--	end
	--CIfEnd()
	--0x4 in air check

	CAdd(FP,0x6509B0,30)
	CIf(FP,{DeathsX(CurrentPlayer,Exactly,0x4,0,0x4)},{Set_EXCCX(0, SetTo, 1),Set_EXCC(0, SetTo, 1)}) -- Lock On
	--55 to 10
	
	CSub(FP,0x6509B0,45)
	CIf(FP,{DeathsX(CurrentPlayer,AtLeast,2048,0,0xFFFF),DeathsX(CurrentPlayer,AtMost,3712,0,0xFFFF)}) -- Reflection
	--10 to 6

	CSub(FP,0x6509B0,4)
	CIf(FP,{DeathsX(CurrentPlayer,AtLeast,2048,0,0xFFFF)})
	f_SaveCp()--BackupCp = 6
	local UIDV = CreateVar(FP)
	local PIDV = CreateVar(FP)
	f_Read(FP, _Add(BackupCp,19), UIDV, nil,0xFF,1)
	EXCC_BreakCalc({CV(UIDV,33)}, {TSetDeathsX(_Add(BackupCp,13), SetTo, 0, 0,0xFF00)})--스캐너 삭제
	--f_Read(FP, _Add(BackupCp,13), PIDV, nil,0xFF,1)
	local X_Pos = CreateVar(FP)
	local Y_Pos = CreateVar(FP)
	local X_Des = CreateVar(FP)
	local Y_Des = CreateVar(FP)
	f_Read(FP,_Add(BackupCp,10),X_Pos,nil,0xFFFF,1)
	f_Read(FP,_Add(BackupCp,10),Y_Pos,nil,0xFFFF0000,1)
	CrShift(FP, Y_Pos, 16)
	f_Read(FP,BackupCp,X_Des,nil,0xFFFF,1)
	f_Read(FP,BackupCp,Y_Des,nil,0xFFFF0000,1)
	CrShift(FP, Y_Des, 16)

	if TestStart == 1 then 
		--DisplayPrint(HumanPlayers, {"X_Des : ",X_Des,"   Y_Des : ",Y_Des})
	end
	X_Des2= CreateVar(FP)
	CMov(FP,X_Des2,_Sub(_Mov(4096),X_Des))
	if TestStart == 1 then 
		--DisplayPrint(HumanPlayers, {"X_Des2 : ",X_Des2,"   Y_Des : ",Y_Des})
	end
	

	--CIfX(FP,{TDeathsX(_Add(BackupCp,13),Exactly,187*256,0,0xFF00)})
	--CDoActions(FP,{
	--	TSetDeathsX(BackupCp,SetTo,X_Des2,0,0xFFFF),
	--	TSetDeathsX(_Add(BackupCp,16),SetTo,X_Des2,0,0xFFFF),
	--	TSetDeathsX(_Sub(BackupCp,2),SetTo,X_Des2,0,0xFFFF)})
	--CElseX()
	--Simple_SetLocX(FP,0, X_Pos, Y_Pos, X_Pos, Y_Pos,{Simple_CalcLoc(0, -4,-4,4,4)})
	--Simple_SetLocX(FP,200, X_Des2, Y_Des, X_Des2, Y_Des,{Simple_CalcLoc(200, -4,-4,4,4)})
	--CDoActions(FP,{TOrder(UIDV,PIDV,1,Attack,201)})
	--CIfXEnd()
	CDoActions(FP,{
		TSetDeathsX(BackupCp,SetTo,X_Des2,0,0xFFFF),
		TSetDeathsX(_Add(BackupCp,16),SetTo,X_Des2,0,0xFFFF),
		TSetDeathsX(_Sub(BackupCp,2),SetTo,X_Des2,0,0xFFFF)})
	f_LoadCp()

	CIfEnd()
	CAdd(FP,0x6509B0,4)
	CIfEnd()
	CAdd(FP,0x6509B0,45)
	CIfEnd()
	CSub(FP,0x6509B0,30)
	
	WhiteList = def_sIndex()
	LauncherUnit = def_sIndex()
	for j, i in pairs(MarID) do
		NJumpX(FP,WhiteList,DeathsX(CurrentPlayer,Exactly,i,0,0xFF))
	end
	NJumpX(FP,WhiteList,DeathsX(CurrentPlayer,Exactly,32,0,0xFF))
	NJumpX(FP,WhiteList,DeathsX(CurrentPlayer,Exactly,20,0,0xFF))
	NJumpX(FP,WhiteList,DeathsX(CurrentPlayer,Exactly,10,0,0xFF))
	NJumpX(FP,LauncherUnit,DeathsX(CurrentPlayer,Exactly,119,0,0xFF))
	TimerUnit = def_sIndex()
	NJumpX(FP,TimerUnit,{Cond_EXCC(2, AtLeast, 1)}) -- 2 = Timer 4 = Option

	
	
	

	NJumpXEnd(FP, MRCheck)
	EXCC_BreakCalc({Cond_EXCC(0, Exactly, 0)}, {SetMemory(0x6509B0,Subtract,16),SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000)})--Lock On이 없을 경우
	EXCC_ClearCalc()
	NJumpXEnd(FP, WhiteList)
	--CIf(FP,{CV(EXCC_TempVarArr[9],0)})
	--	
	--	f_SaveCp()
	--	local CSPtr = CreateVar(FP)
	--	f_Read(FP, _Sub(BackupCp,22), nil, CSPtr)
	--	CDoActions(FP, {Set_EXCCX(8, SetTo, _Add(CSPtr,2))})
	--	f_LoadCp()
	--CIfEnd()
		CIf(FP,{Cond_EXCC(1, AtLeast, 1)})
		CDoActions(FP, {TSetDeaths(_Add(CurCunitI,19025+2), SetTo,EXCC_TempVarArr[11],0)})
		CIfEnd()
	--CIf(FP,{Cond_EXCC(8, AtLeast, 1)})
	--	CIf(FP,{Cond_EXCC(1, AtLeast, 1)})
	--		CTrigger(FP, {NTCond()}, {TSetMemoryX(EXCC_TempVarArr[9],SetTo,EXCC_TempVarArr[10], 0xFF0000)}, {preserved})
	--		CTrigger(FP, {NTCond2()}, {TSetMemoryX(EXCC_TempVarArr[9],SetTo,P6*0x10000, 0xFF0000)}, {preserved})
	--		CTrigger(FP, {NTCond2(),Cond_EXCC(1, Exactly, 1)}, {TSetMemoryX(EXCC_TempVarArr[9],SetTo,EXCC_TempVarArr[10], 0xFF0000)}, {preserved})
	--	CIfEnd()
	--	for i = 0, 4 do
	--		CIf(FP, {CVX(EXCC_TempVarArr[10],i*65536,0xFF0000)})
	--		CTrigger(FP, {NTCond()}, {TSetMemoryX(EXCC_TempVarArr[9],SetTo,EXCC_TempVarArr[10], 0xFF0000)}, {preserved})
	--		CTrigger(FP, {NTCond2(),Memory(0x582294+(4*i),AtLeast,2100),Memory(0x582294+(4*i),AtMost,2400)}, {TSetMemoryX(EXCC_TempVarArr[9],SetTo,P6*0x10000, 0xFF0000)}, {preserved})
	--		CTrigger(FP, {NTCond2(),Memory(0x582294+(4*i),AtLeast,1800),Memory(0x582294+(4*i),AtMost,2100)}, {TSetMemoryX(EXCC_TempVarArr[9],SetTo,P8*0x10000, 0xFF0000)}, {preserved})
	--		CTrigger(FP, {NTCond2(),Memory(0x582294+(4*i),AtLeast,1500),Memory(0x582294+(4*i),AtMost,1800)}, {TSetMemoryX(EXCC_TempVarArr[9],SetTo,P12*0x10000, 0xFF0000)}, {preserved})
	--		CTrigger(FP, {NTCond2(),Memory(0x582294+(4*i),AtLeast,1200),Memory(0x582294+(4*i),AtMost,1500)}, {TSetMemoryX(EXCC_TempVarArr[9],SetTo,P7*0x10000, 0xFF0000)}, {preserved})
	--		CTrigger(FP, {NTCond2(),Memory(0x582294+(4*i),Exactly,1),}, {TSetMemoryX(EXCC_TempVarArr[9],SetTo,EXCC_TempVarArr[10], 0xFF0000)}, {preserved})
	--		CIfEnd()
	--	end
	--CIfEnd()
	EXCC_ClearCalc()
	NJumpXEnd(FP, TimerUnit)
	CIf(FP, {Cond_EXCC(2, Exactly, 1)})--타이머 종료시 1회한정 작동
		f_SaveCp()

		f_Read(FP, _Sub(BackupCp,15), CPos)
		Convert_CPosXY()
		f_Read(FP, BackupCp, UIDV, nil,0xFF,1)
		f_Read(FP, _Sub(BackupCp,6), PIDV, nil,0xFF,1)
		CIf(FP, {Cond_EXCC(5, Exactly, 1)})--타이머 타입 번호
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CDoActions(FP, {TOrder(UIDV, PIDV, 1, Attack, 6)})
		CIfEnd()
		CIf(FP, {Cond_EXCC(5, Exactly, 2)})--타이머 타입 번호
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			Simple_SetLocX(FP,200,EXCC_TempVarArr[12],EXCC_TempVarArr[13],EXCC_TempVarArr[12],EXCC_TempVarArr[13],{Simple_CalcLoc(200,-4,-4,4,4)})
			CDoActions(FP, {TOrder(UIDV, PIDV, 1, Attack, 201)})
		CIfEnd()
		CIf(FP, {Cond_EXCC(5, Exactly, 3)})--타이머 타입 번호(f_CGive 해제 후 기지공격)
			f_CGive(FP, _Sub(BackupCp,25), nil, P6, PIDV)
			local NPosX, NPosY = CreateVars(2, FP)
			GetLocCenter(5, NPosX, NPosY)
			SpeedRet = CreateVar(FP)
			f_Sqrt(FP, SpeedRet, _Div(_Add(_Square(_iSub(CPosX,NPosX)),_Square(_iSub(CPosY,NPosY))),_Mov(2)))
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CDoActions(FP, {TOrder(UIDV, P6, 1, Attack, 6),TSetMemoryX(_Add(BackupCp,55-25),SetTo,0,0x4000000),
			TSetMemory(_Sub(BackupCp,25-13),SetTo,SpeedRet),
			TSetMemoryX(_Sub(BackupCp,25-18),SetTo,SpeedRet,0xFFFF),
			TSetMemoryX(_Add(BackupCp,72-25),SetTo,0*256,0xFF00),})
		CIfEnd()
		f_LoadCp()
	CIfEnd()
	
	CIf(FP, {Cond_EXCC(5, Exactly, 4),CD(CocoonCcode,1)})--타이머 타입 번호(조건부 만족시 정야독)
		f_SaveCp()
		f_Read(FP, _Sub(BackupCp,6), PIDV, nil,0xFF,1)
		CIf(FP,{CV(PIDV,8)})
		f_CGive(FP, _Sub(BackupCp,25), nil, P6, PIDV)
		f_Read(FP, _Sub(BackupCp,15), CPos)
		Convert_CPosXY()
		Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
		CDoActions(FP, {
		TSetDeathsX(_Sub(BackupCp,6),SetTo,187*256,0,0xFF00),
		TSetMemoryX(_Add(BackupCp,55-25),SetTo,0,0x4000000),
		TSetMemoryX(_Add(BackupCp,72-25),SetTo,0*256,0xFF00),
		Set_EXCCX(5,SetTo,0),
		Set_EXCCX(2,SetTo,0)})
		CIfEnd()
		f_LoadCp()
	CIfEnd()

	EXCC_ClearCalc()
	NJumpXEnd(FP, LauncherUnit)
	f_SaveCp()
	f_Read(FP, _Sub(BackupCp,15), CPos)
	Convert_CPosXY()
	Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
	CDoActions(FP, {CreateUnit(1, 94, 1, P6),KillUnit(94, P6)})
		
	f_LoadCp()
	EXCC_ClearCalc()
	EXCC_Part2()
	EXCC_Part3X()
	for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
		EXCC_Part4X(i,{
			DeathsX(19025+(84*i)+9,AtMost,0,0,0xFF0000),--
			DeathsX(19025+(84*i)+19,AtLeast,1*256,0,0xFF00),
		},
		{MoveCp(Add,25*4),
		SetCVar(FP,CurCunitI2[2],SetTo,i),--SetResources(P1,Add,1,Gas)
		SetCVar(FP,CurCunitI[2],SetTo,i*84),--SetResources(P1,Add,1,Gas)
		})
	end
	EXCC_End()


	HeroIndex = CreateVar(FP)
	EXCC_Part1(DUnitCalc) -- 죽은유닛 인식 단락 시작

	CDoActions(FP, {Set_EXCC2(UnivCunit, CurCunitI2, 0, SetTo, 0)})--Lock On Disable

	EnemyCheck = def_sIndex()
	NJump(FP, EnemyCheck,{DeathsX(CurrentPlayer, AtLeast, 5, 0, 0xFF)})

	
for i = 0, 4 do
	CIf(FP,{DeathsX(CurrentPlayer, Exactly, i, 0, 0xFF)},{SetMemory(0x6509B0, Add, 6),})
		

		CIf(FP,{DeathsX(CurrentPlayer, Exactly, 32, 0, 0xFF)},{SetScore(i, Add, 1, Custom)})
		f_SaveCp()
		TriggerX(FP,{CD(SELimit,4,AtMost)}, {AddCD(SELimit,1),RotatePlayer({PlayWAVX("staredit\\wav\\Marinedead.ogg"),PlayWAVX("staredit\\wav\\Marinedead.ogg")},HumanPlayers, FP)},{preserved})
		CIfX(FP, {Deaths(i, Exactly, 2, 217)})
		DisplayPrint(HumanPlayers,{"\x12"..StrD[1]..string.char(ColorCode[i+1]).."名取さな \x04의 마린이 \x08폭사\x04당했어...",StrD[2]})
		CElseX()
		DisplayPrint(HumanPlayers,{"\x12"..StrD[1],PName(i)," \x04의 마린이 \x08폭사\x04당했어...",StrD[2]})
		CIfXEnd()
		f_LoadCp()
		CIfEnd()

		CIf(FP,{DeathsX(CurrentPlayer, Exactly, 20, 0, 0xFF),},{SetScore(i, Add, 2, Custom)})
		f_SaveCp()
		TriggerX(FP,{CD(SELimit,4,AtMost)}, {AddCD(SELimit,1),RotatePlayer({PlayWAVX("staredit\\wav\\Marinedead.ogg"),PlayWAVX("staredit\\wav\\Marinedead.ogg")},HumanPlayers, FP)},{preserved})
		CIfX(FP, {Deaths(i, Exactly, 2, 217)})
		DisplayPrint(HumanPlayers,{"\x12"..StrD[1]..string.char(ColorCode[i+1]).."名取さな \x04의 \x1B영\x04웅 \x1B마\x04린이 \x08폭사\x04당했어...",StrD[2]})
		CElseX()
		DisplayPrint(HumanPlayers,{"\x12"..StrD[1],PName(i)," \x04의 \x1B영\x04웅 \x1B마\x04린이 \x08폭사\x04당했어...",StrD[2]})
		CIfXEnd()
		f_LoadCp()
		CIfEnd()
		
		CIf(FP,{DeathsX(CurrentPlayer, Exactly, 10, 0, 0xFF),},{SetScore(i, Add, 3, Custom)})
		f_SaveCp()
		TriggerX(FP,{CD(SELimit,4,AtMost)}, {AddCD(SELimit,1),RotatePlayer({PlayWAVX("staredit\\wav\\Marinedead.ogg"),PlayWAVX("staredit\\wav\\Marinedead.ogg")},HumanPlayers, FP)},{preserved})
		CIfX(FP, {Deaths(i, Exactly, 2, 217)})
		DisplayPrint(HumanPlayers,{"\x12"..StrD[1]..string.char(ColorCode[i+1]).."名取さな \x04의 \x1F스\x04페셜 \x1F마\x04린이 \x08폭사\x04당했어...",StrD[2]})
		CElseX()
		DisplayPrint(HumanPlayers,{"\x12"..StrD[1],PName(i)," \x04의 \x1F스\x04페셜 \x1F마\x04린이 \x08폭사\x04당했어...",StrD[2]})
		CIfXEnd()
		f_LoadCp()
		CIfEnd()

		CIf(FP,{DeathsX(CurrentPlayer, Exactly, MarID[i+1], 0, 0xFF),},{SetScore(i, Add, 4, Custom)})
		f_SaveCp()
		TriggerX(FP,{CD(SELimit,4,AtMost)}, {AddCD(SELimit,1),RotatePlayer({PlayWAVX("staredit\\wav\\Marinedead.ogg"),PlayWAVX("staredit\\wav\\Marinedead.ogg")},HumanPlayers, FP)},{preserved})
		CIfX(FP, {Deaths(i, Exactly, 2, 217)})
		DisplayPrint(HumanPlayers,{"\x12"..StrD[1]..string.char(ColorCode[i+1]).."名取さな \x04의 \x17리\x04스펙트"..string.char(ColorCode[i+1]).." 마\x04린이 \x08폭사\x04당했어...",StrD[2]})
		CElseX()
		DisplayPrint(HumanPlayers,{"\x12"..StrD[1],PName(i)," \x04의 \x17리\x04스펙트"..string.char(ColorCode[i+1]).." 마\x04린이 \x08폭사\x04당했어...",StrD[2]})
		CIfXEnd()
		f_LoadCp()
		CIfEnd()
		

	DoActions(FP, {SetMemory(0x6509B0, Subtract, 6)})
	--CIf(FP, Cond_EXCC(4, AtLeast, 1,0xFF))
	--CDoActions(FP, {TSetDeathsX(CurrentPlayer, SetTo, EXCC_TempVarArr[5], 0, 0xFF)})
	--CIfEnd()
	CIfEnd()
end




function print_utf8_A(DB, string)
	local ret = {}
	
	if type(string) == "string" then
		local str = string
		local n = 1
		if #str % 4 >= 1 then
			for i = 1, #str % 4 do str = '\x0d'..str end
		end
		local t = StrToMem(str)
		while n <= #t do
			ret[#ret+1] = SetCtrig1X(FP,DB[2],(((n-1)//4)+(math.floor(((n-1)//4)/602))*2)*4,0, SetTo, _dw(t, n))
			n = n + 4
		end
	elseif type(string) == "number" then
		PushErrorMsg("print_utf8_InputError")
	end
	return ret
end


	
	NJumpEnd(FP, EnemyCheck)
	CAdd(FP, 0x6509B0, 6)
	for j, k in pairs(f_GunTable) do
		f_GSend(k)
	end
	
	local HTArr = CreateArr(600, FP)
	local HPT = CreateVar(FP)
	local HTSize = CreateVar(FP)
	CIf(FP,{Cond_EXCC(1,Exactly,1)},SetV(HPT,0)) -- 영작유닛인식

	f_SaveCp()
	f_Read(FP, BackupCp, HeroIndex, nil, nil, 1)
	CIf(FP,{CV(HeroIndex,217)})--벽 터진위치에 마인생성
	f_Read(FP, _Sub(BackupCp,15), CPos)
	Convert_CPosXY()
	f_TempRepeatX({}, 13, 1, 2, P6, {CPosX,CPosY})
	CIfEnd()
	for j,k in pairs(UnitPointArr) do
		Trigger2X(FP, {
			CVX(HeroIndex, k[1], 0xFF)}, {SetV(HPT, k[2]/5),print_utf8_A(HTArr, k[3]..string.rep("\x0D",0x40-(#k[3])))},{preserved})
	end
	
	CIf(FP, {CV(HPT,1,AtLeast)})
	TriggerX(FP,{CD(SELimit,4,AtMost)}, {AddCD(SELimit,1),RotatePlayer({
		PlayWAVX("staredit\\wav\\Herokill.ogg"),
		PlayWAVX("staredit\\wav\\Herokill.ogg"),},HumanPlayers, FP)},{preserved})
		
	function HeroTextFunc()
		f_Memcpy(FP,_Add(RetV,Dev),Arr(HTArr,0),0x40)
		Dev = Dev+0x40
		BSize=BSize+0x40
	end
	local ExchangeOre = CreateVar(FP)

	CMov(FP,ExchangeOre,HPT)
	CDoActions(FP, {TSetResources(Force1, Add, ExchangeOre, Ore)})
	DisplayPrint(HumanPlayers,{"\x13"..StrD[1],HeroTextFunc,"\x04을(를) \x07처치하였다! \x1F＋ ",ExchangeOre," \x03Ｏｒｅ"..StrD[2]})
	CIfEnd()
	f_LoadCp()
	CIfEnd()




	EXCC_ClearCalc()
		EXCC_Part2()
		EXCC_Part3X()
		for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
			EXCC_Part4X(i,{
			DeathsX(19025+(84*i)+40,AtLeast,1*16777216,0,0xFF000000),
			DeathsX(19025+(84*i)+19,Exactly,0*256,0,0xFF00),
			},
			{SetDeathsX(19025+(84*i)+40,SetTo,0*16777216,0,0xFF000000),
			SetDeathsX(19025+(84*i)+9,SetTo,0*65536,0,0xFF0000),
			SetDeathsX(19025+(84*i)+35,SetTo,0,0,0xFF); -- 
			MoveCp(Add,19*4),
			SetCVar(FP,CurCunitI2[2],SetTo,i)
			})
		end
		EXCC_End()
	
	SETimer = CreateCcode()
	TriggerX(FP,{CDeaths(FP,Exactly,0,SETimer)},{SetCDeaths(FP,SetTo,0,SELimit),SetCDeaths(FP,SetTo,100,SETimer)},{preserved})
	DoActionsX(FP,{SetCDeaths(FP,Subtract,1,SETimer)})
	CMov(FP,GTime,_Div(_Mul(_ReadF(0x57F23C),42),1000))
	CMov(FP,G_CB_RotateV,_Mul(_Mod(GTime,60),6))


	CIf(FP,{CD(GMode,2,AtLeast),Deaths(P8, AtMost, 0, 189)})--콜은 MX난이도이상만 나옴, 워프게이트 깔때까지
	--1~6 5분간격
	--7~9 10분간격
	--10~13 15분간격
	--14~17 30분간격
	--17~21 60분간격
	
	for i = 1, 6 do
		f_GunForceSend(256,P8,1024+(1088*65536),i+0,{CV(GTime,i*(60*5),AtLeast)},nil,1)
	end
	for i = 1, 3 do
		f_GunForceSend(256,P8,1024+(1088*65536),i+6,{CV(GTime,(60*30)+(i*(60*10)),AtLeast)},nil,1)
	end
	for i = 1, 4 do
		f_GunForceSend(256,P8,1024+(1088*65536),i+9,{CV(GTime,(60*60)+(i*(60*15)),AtLeast)},nil,1)
	end
	for i = 1, 4 do
		f_GunForceSend(256,P8,1024+(1088*65536),i+13,{CV(GTime,(60*120)+(i*(60*30)),AtLeast)},nil,1)
	end
	for i = 1, 4 do
		f_GunForceSend(256,P8,1024+(1088*65536),i+17,{CV(GTime,(60*240)+(i*(60*60)),AtLeast)},nil,1)
	end
	CIfEnd()


	
	Install_GunStack()
	Create_G_CB_Arr()

	function ToggleFunc(CondArr,Mode,EnterFlag)
		local KeyToggle = CreateCcode()
		local KeyToggle2 = CreateCcode()
		local NotTypingCond = nil
		if EnterFlag ~= nil then
			NotTypingCond = Memory(0x68C144,Exactly,0)
		end
		
		if Mode ~= nil then
			DoActionsX(FP,{SetCD(KeyToggle,0)})
			TriggerX(FP, {NotTypingCond,CondArr[1],CD(KeyToggle2,1)}, {SetCD(KeyToggle2,0),SetCD(KeyToggle,1)}, {preserved})
			TriggerX(FP, {NotTypingCond,CondArr[2]}, {SetCD(KeyToggle2,1)}, {preserved})
		else
			DoActionsX(FP,{SetCD(KeyToggle,0)})
			TriggerX(FP, {NotTypingCond,CondArr[2],CD(KeyToggle2,0)}, {SetCD(KeyToggle2,1),SetCD(KeyToggle,1)}, {preserved})
			TriggerX(FP, {NotTypingCond,CondArr[1]}, {SetCD(KeyToggle2,0)}, {preserved})
		end
	
		return KeyToggle2,KeyToggle
	end
			
	if TestStart == 1 then-- BarTextTest
		
NameTest = 0
if NameTest == 1 then
		testc = CreateCcode()
		testc2 = CreateCcode()
		testc3 = CreateCcode()
		temp,QKey = ToggleFunc({KeyPress("Q","Up"),KeyPress("Q","Down")},nil,1)--누를 경우 설명서 출력
		temp,WKey = ToggleFunc({KeyPress("W","Up"),KeyPress("W","Down")},nil,1)--누를 경우 설명서 출력
		temp,AKey = ToggleFunc({KeyPress("A","Up"),KeyPress("A","Down")},nil,1)--누를 경우 설명서 출력
		temp,SKey = ToggleFunc({KeyPress("S","Up"),KeyPress("S","Down")},nil,1)--누를 경우 설명서 출력
		temp,ZKey = ToggleFunc({KeyPress("Z","Up"),KeyPress("Z","Down")},nil,1)--누를 경우 설명서 출력
		temp,XKey = ToggleFunc({KeyPress("X","Up"),KeyPress("X","Down")},nil,1)--누를 경우 설명서 출력
		TriggerX(FP,{CD(QKey,1)},{SubCD(testc,1)},{preserved})
		TriggerX(FP,{CD(WKey,1)},{AddCD(testc,1)},{preserved})
		TriggerX(FP,{CD(AKey,1)},{SubCD(testc2,1)},{preserved})
		TriggerX(FP,{CD(SKey,1)},{AddCD(testc2,1)},{preserved})
		TriggerX(FP,{CD(ZKey,1)},{SubCD(testc3,1)},{preserved})
		TriggerX(FP,{CD(XKey,1)},{AddCD(testc3,1)},{preserved})


		TestJ = def_sIndex()
		CJump(FP, TestJ)
		TempiS1, TempiS1a, TempiS1s = SaveiStrArrX(FP,"\x0D\x0D\x0D\x0D\x0D\x0D")
		TempiS2, TempiS1a, TempiS2s = SaveiStrArrX(FP,"\x0D\x0D\x0D\x0D\x0D\x0D")
		--일반타입 그림자 \x15 표면 \x1B
		--방어무시 그림자 \x1C 표면 \x1F
		--스택타입 그림자 \x18 표면 \x07
		--위험타입 그림자 \x06 표면 \x08

		--Dejavu
		--Ynn
		--Young
		--BV13
		--Mincho
		--Ann





		--Aram
		--Leon
		--퀸 60000 1000 노멀
		--str33 = "\x08。+.˚Heart of Witch\x12\x10H\x04eart \x10o\x04f \x10W\x04itch\x10。+.˚"
		str33 = "\x11。˙+˚Diomedes。+.˚\x12\x15。˙+˚D\x04iomedes\x15。+.˚"
		str44 = "\t\t\x11。˙+˚Sadol。+.˚\x12\x15。˙+˚S\x04adol\x15。+.˚"
		--str44 = "\t\t\t\x15。˙+˚Leon。+.˚\x12\x1B。˙+˚L\x04eon。+.˚"
		--str55 = "\x15。+.˚Misty E'ra 'Mui'\x12\x10M\x04isty \x10E\x04'ra '\x10M\x04ui'\x10。+.˚"
		str55 = "\x11。˙+˚Diomedes。+.˚\x12\x15。˙+˚D\x04iomedes\x15。+.˚"

		--Yuri
		--Sena
		--Yona
		--Sayu
		--Sorang
		str = str33.."\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"
	
		S6 = MakeiTblString(1480,"None",'None',str,"Base",1)
		Str2, Str2a, Str2s = SaveiStrArrX(FP,str)
		BarTblptr = GetiTblId(FP,219,S6)
		CJumpEnd(FP, TestJ)
		
		for i = 0, 19 do
		CIf(FP,CD(testc2,i),{SetCp(0),DisplayText("Disc space:"..i, 4),SetCp(FP)})
		CS__SetValue(FP,Str2,str33.."\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"..string.rep(" ", i)..string.rep("\x0D",19-i),nil,0,nil,1) 
		CIfEnd()
		end
		for i = 0, 19 do
			CIf(FP,CD(testc,i),{SetCp(0),DisplayText("Disc tab:"..i, 4),SetCp(FP)})
			CS__SetValue(FP,Str2,str33..string.rep("	", i)..string.rep("\x0D",19-i),nil,0,nil,1) 
			CIfEnd()
		end
		CS__InputVA(FP,BarTblptr,0,Str2,Str2s,nil,0,Str2s)

		
		testc = CreateCcode()
		testc2 = CreateCcode()
		testc3 = CreateCcode()
		temp,QKey = ToggleFunc({KeyPress("T","Up"),KeyPress("T","Down")},nil,1)--누를 경우 설명서 출력
		temp,WKey = ToggleFunc({KeyPress("Y","Up"),KeyPress("Y","Down")},nil,1)--누를 경우 설명서 출력
		temp,AKey = ToggleFunc({KeyPress("G","Up"),KeyPress("G","Down")},nil,1)--누를 경우 설명서 출력
		temp,SKey = ToggleFunc({KeyPress("H","Up"),KeyPress("H","Down")},nil,1)--누를 경우 설명서 출력
		temp,ZKey = ToggleFunc({KeyPress("B","Up"),KeyPress("B","Down")},nil,1)--누를 경우 설명서 출력
		temp,XKey = ToggleFunc({KeyPress("N","Up"),KeyPress("N","Down")},nil,1)--누를 경우 설명서 출력
		TriggerX(FP,{CD(QKey,1)},{SubCD(testc,1)},{preserved})
		TriggerX(FP,{CD(WKey,1)},{AddCD(testc,1)},{preserved})
		TriggerX(FP,{CD(AKey,1)},{SubCD(testc2,1)},{preserved})
		TriggerX(FP,{CD(SKey,1)},{AddCD(testc2,1)},{preserved})
		TriggerX(FP,{CD(ZKey,1)},{SubCD(testc3,1)},{preserved})
		TriggerX(FP,{CD(XKey,1)},{AddCD(testc3,1)},{preserved})


		TestJ = def_sIndex()
		CJump(FP, TestJ)
		TempiS1, TempiS1a, TempiS1s = SaveiStrArrX(FP,"\x0D\x0D\x0D\x0D\x0D\x0D")
		TempiS2, TempiS1a, TempiS2s = SaveiStrArrX(FP,"\x0D\x0D\x0D\x0D\x0D\x0D")
		
		str = str44.."\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"
	
		S6 = MakeiTblString(1480,"None",'None',str,"Base",1)
		Str2, Str2a, Str2s = SaveiStrArrX(FP,str)
		BarTblptr = GetiTblId(FP,130,S6)
		CJumpEnd(FP, TestJ)
		
		for i = 0, 19 do
		CIf(FP,CD(testc2,i),{SetCp(0),DisplayText("Khalis space:"..i, 4),SetCp(FP)})
		CS__SetValue(FP,Str2,str44.."\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"..string.rep(" ", i)..string.rep("\x0D",19-i),nil,0,nil,1) 
		CIfEnd()
		end
		for i = 0, 19 do
			CIf(FP,CD(testc,i),{SetCp(0),DisplayText("Khalis tab:"..i, 4),SetCp(FP)})
			CS__SetValue(FP,Str2,str44..string.rep("	", i)..string.rep("\x0D",19-i),nil,0,nil,1) 
			CIfEnd()
		end
		CS__InputVA(FP,BarTblptr,0,Str2,Str2s,nil,0,Str2s)


		
		testc = CreateCcode()
		testc2 = CreateCcode()
		testc3 = CreateCcode()
		temp,QKey = ToggleFunc({KeyPress("U","Up"),KeyPress("U","Down")},nil,1)--누를 경우 설명서 출력
		temp,WKey = ToggleFunc({KeyPress("I","Up"),KeyPress("I","Down")},nil,1)--누를 경우 설명서 출력
		temp,AKey = ToggleFunc({KeyPress("J","Up"),KeyPress("J","Down")},nil,1)--누를 경우 설명서 출력
		temp,SKey = ToggleFunc({KeyPress("K","Up"),KeyPress("K","Down")},nil,1)--누를 경우 설명서 출력
		temp,ZKey = ToggleFunc({KeyPress("M","Up"),KeyPress("M","Down")},nil,1)--누를 경우 설명서 출력
		temp,XKey = ToggleFunc({KeyPress(",","Up"),KeyPress(",","Down")},nil,1)--누를 경우 설명서 출력
		TriggerX(FP,{CD(QKey,1)},{SubCD(testc,1)},{preserved})
		TriggerX(FP,{CD(WKey,1)},{AddCD(testc,1)},{preserved})
		TriggerX(FP,{CD(AKey,1)},{SubCD(testc2,1)},{preserved})
		TriggerX(FP,{CD(SKey,1)},{AddCD(testc2,1)},{preserved})
		TriggerX(FP,{CD(ZKey,1)},{SubCD(testc3,1)},{preserved})
		TriggerX(FP,{CD(XKey,1)},{AddCD(testc3,1)},{preserved})


		TestJ = def_sIndex()
		CJump(FP, TestJ)
		TempiS1, TempiS1a, TempiS1s = SaveiStrArrX(FP,"\x0D\x0D\x0D\x0D\x0D\x0D")
		TempiS2, TempiS1a, TempiS2s = SaveiStrArrX(FP,"\x0D\x0D\x0D\x0D\x0D\x0D")
		
		str = str55.."\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"
	
		S6 = MakeiTblString(1480,"None",'None',str,"Base",1)
		Str2, Str2a, Str2s = SaveiStrArrX(FP,str)
		BarTblptr = GetiTblId(FP,129,S6)
		CJumpEnd(FP, TestJ)
		
		for i = 0, 19 do
		CIf(FP,CD(testc2,i),{SetCp(0),DisplayText("Uraj space:"..i, 4),SetCp(FP)})
		CS__SetValue(FP,Str2,str55.."\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"..string.rep(" ", i)..string.rep("\x0D",19-i),nil,0,nil,1) 
		CIfEnd()
		end
		for i = 0, 19 do
			CIf(FP,CD(testc,i),{SetCp(0),DisplayText("Uraj tab:"..i, 4),SetCp(FP)})
			CS__SetValue(FP,Str2,str55..string.rep("	", i)..string.rep("\x0D",19-i),nil,0,nil,1) 
			CIfEnd()
		end
		CS__InputVA(FP,BarTblptr,0,Str2,Str2s,nil,0,Str2s)

		




		--TriggerX(FP,{},{CreateUnit(1, 84, 64, FP),KillUnit(84, FP)},{preserved})
		
end
	end
	if false then -- 언리미터 구조 파악 or 껏다켯다 테스트 but 끄자마자 튕겨 실패. 폐기코드
		
		temp,F9Key = ToggleFunc({KeyPress("F9","Up"),KeyPress("F9","Down")},nil,1)--누를 경우 설명서 출력
		
		CIfOnce(FP, {})
		R_0x64EED8 = CreateVar(FP) R_0x64EED8["hex"] = true
		R_0x64EEDC = CreateVar(FP) R_0x64EEDC["hex"] = true
		R_0x63FE30 = CreateVar(FP) R_0x63FE30["hex"] = true
		R_0x63FE34 = CreateVar(FP) R_0x63FE34["hex"] = true
		R_0x57EB68 = CreateVar(FP) R_0x57EB68["hex"] = true
		R_0x57EB70 = CreateVar(FP) R_0x57EB70["hex"] = true
		R_0x64B2E0 = CreateVar(FP) R_0x64B2E0["hex"] = true
		R_0x64B2E4 = CreateVar(FP) R_0x64B2E4["hex"] = true
		R_0x64DEBC = CreateVar(FP) R_0x64DEBC["hex"] = true
		f_Read(FP, 0x64EED8, R_0x64EED8)
		f_Read(FP, 0x64EEDC, R_0x64EEDC)
		f_Read(FP, 0x63FE30, R_0x63FE30)
		f_Read(FP, 0x63FE34, R_0x63FE34)
		f_Read(FP, 0x57EB68, R_0x57EB68)
		f_Read(FP, 0x57EB70, R_0x57EB70)
		f_Read(FP, 0x64B2E0, R_0x64B2E0)
		f_Read(FP, 0x64B2E4, R_0x64B2E4)
		f_Read(FP, 0x64DEBC, R_0x64DEBC)
		CIfEnd()
		ResetUnLimiterArr = {
		{0x64EED8,0x64B2E8,R_0x64EED8},{0x64EEDC,0x64B358,R_0x64EEDC},
		{0x63FE30,0x63B15C,R_0x63FE30},{0x63FE34,0x629DBC,R_0x63FE34},
		{0x57EB68,0x56C6E8,R_0x57EB68},{0x57EB70,0x52F5A8,R_0x57EB70},
		{0x64B2E0,0x64B1A0,R_0x64B2E0},{0x64B2E4,0x6416B4,R_0x64B2E4},
		{0x64DEBC,0,R_0x64DEBC}}
		UnLimiterOnOff = CreateVar(FP)
		TriggerX(FP, {CD(F9Key,1),CD(UnLimiterOnOff,0)}, {SetCD(UnLimiterOnOff,1),RotatePlayer({DisplayTextX("UnLimiter Off")},HumanPlayers, FP)},{preserved})
		CIf(FP, {CD(F9Key,1),CD(UnLimiterOnOff,1)},{SetCD(F9Key,0)})
		for j,k in pairs(ResetUnLimiterArr) do
			CMov(FP,k[1],k[2])
		end
		CIfEnd()

		TriggerX(FP, {CD(F9Key,1),CD(UnLimiterOnOff,1)}, {SetCD(UnLimiterOnOff,0),RotatePlayer({DisplayTextX("UnLimiter On")},HumanPlayers, FP)},{preserved})
		CIf(FP, {CD(F9Key,1),CD(UnLimiterOnOff,0)},{SetCD(F9Key,0)})
		for j,k in pairs(ResetUnLimiterArr) do
			CMov(FP,k[1],k[3])
		end
		CIfEnd()
		TriggerX(FP, {CD(UnLimiterOnOff,0)}, {SetMemory(0x64DEBC,SetTo,40)},{preserved})


	end
	--219
	--130
	--129
Trigger2(FP,{Command(P7,AtLeast,100,42)},{KillUnitAt(1, 42, 64, P7)},{preserved})
Trigger2(FP,{Command(FP,AtLeast,100,42)},{KillUnitAt(1, 42, 64, FP)},{preserved})
Trigger2X(FP,{CD(CocoonCcode,1)},{SetInvincibility(Disable, "Men", P6, 64)},{preserved})


DoActionsX(FP, {KillUnit(94, AllPlayers),KillUnit(94, P9),Order(119, P6, 64, Move, 6),KillUnitAt(All, 119, 6, P6)})
if TestStart == 1 then
	--DoActionsX(FP, {AddV(GTime,10)})
end
ChryCcode2 = CreateCcode()
TriggerX(FP, {CD(ChryCcode,0)}, {AddCD(ChryCcode2,1)}, {preserved})
CCIText = "\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x07。\x18˙\x0F+\x1C˚ \x08E\x04nemy \x08S\x04torm \x1C。\x0F+\x18.\x07˚ \x04의 \x02무적상태\x04가 해제되었습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14"
CCIText2 = "\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x07。\x18˙\x0F+\x1C˚ \x11g\x04lory\x11MAX \x1C。\x0F+\x18.\x07˚ \x04가 \x07본진에 출현\x04했습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14"
CCIText3 = "\x13\x07。\x18˙\x0F+\x1C˚ \x03N\x04ew\x03G\x04ame\x03S\x04tart 를 모두 파괴하여 \x1F양방향 포탈\x04이 \x07활성화\x04 되었습니다. \x1C。\x0F+\x18.\x07˚"

TriggerX(FP, {CD(ChryCcode2,480,AtLeast)}, {SetInvincibility(Disable, 201, P8, 64),
	RotatePlayer({DisplayTextX(CCIText, 4),PlayWAVX("staredit\\wav\\unlock.ogg"),PlayWAVX("staredit\\wav\\unlock.ogg"),PlayWAVX("staredit\\wav\\unlock.ogg"),PlayWAVX("staredit\\wav\\unlock.ogg")}, HumanPlayers, FP),
})
TriggerX(FP,{CD(GunCcode,0)},{AddCD(WinCcode,1)},{preserved})
TriggerX(FP, {CD(WinCcode,480,AtLeast)}, {KillUnit(125, AllPlayers),KillUnit(125, P12),RotatePlayer({DisplayTextX(CCIText2, 4),PlayWAVX("staredit\\wav\\unlock.ogg"),PlayWAVX("staredit\\wav\\unlock.ogg"),PlayWAVX("staredit\\wav\\unlock.ogg"),PlayWAVX("staredit\\wav\\unlock.ogg")}, HumanPlayers, FP),})
f_TempRepeat(CD(WinCcode,480,AtLeast), 189, 1, 0, P8, {1024,1088}, 1)

--TriggerX(FP, Deaths(P8, AtLeast, 1, 189), {RotatePlayer({Victory()}, HumanPlayers, FP)})--화홀제작전 임시 승리트리거
f_GunForceSend(189, FP, 1024+(1088*65536), 1, Deaths(P8, AtLeast, 1, 189), nil, 1)--화홀강제입력
TriggerX(FP, {Deaths(P8, AtLeast, 3, 200)}, {--양방향 포탈 활성화
	RotatePlayer({DisplayTextX(CCIText3, 4)}, HumanPlayers, FP),
	GiveUnits(All, 204, P8, 64, P6),
	SetDoodadState(Disable, 204, P6, 27),
	SetDoodadState(Disable, 204, P6, 28),
})
TriggerX(FP, {Deaths(P8, AtLeast, 3, 200)}, {--양방향 포탈 활성화
	MoveUnit(All, "Men", Force1, 28, 29),
	MoveUnit(All, "Men", Force1, 27, 30),
},{preserved})

--실험적 메딕 인식 트리거


function dwread_epd(Ptr,EPDFlag) -- v=EPD
	local RetV= CreateVar(FP)
	if EPDFlag == 1 then
		f_Read(FP,Ptr,nil,RetV,nil,1)
	else
		f_Read(FP,Ptr,RetV,nil,nil,1)
	end
	return RetV
end


mouseX = dwread_epd(0x6CDDC4)
mouseY = dwread_epd(0x6CDDC8)
screenGridX = dwread_epd(0x62848C)
screenGridY = dwread_epd(0x6284A8)
Simple_SetLocX(FP,251, 256*16, 256*16,256*16, 256*16) --중앙 (맵사이즈*16, 맵사이즈*16)
local LCP = CreateVar(FP)
local SelPID = CreateVar(FP)
f_Read(FP,0x512684,LCP)
CDoActions(FP,{TSetMemory(0x6509B0, SetTo, LCP),CenterView(252)})
ScreenX2 = dwread_epd(0x62848C);
ScreenY2 = dwread_epd(0x6284A8);
screenSizeX = CreateVar(FP)
screenSizeY = CreateVar(FP)
CMov(FP,screenSizeX,_iSub(_Mov(256*16),ScreenX2))
CMov(FP,screenSizeY,_iSub(_Mov(256*16),ScreenY2))
screenX = CreateVar(FP)
screenY = CreateVar(FP)
CAdd(FP,screenX,screenGridX,screenSizeX)
CAdd(FP,screenY,screenGridY,screenSizeY)
Simple_SetLocX(FP,251, screenX, screenY,screenX, screenY)
CDoActions(FP,{TSetMemory(0x6509B0, SetTo, LCP),CenterView(252)})
Simple_SetLocX(FP,251, 256*16, 256*16,256*16, 256*16) --중앙 (맵사이즈*16, 맵사이즈*16)
CMov(FP,screenX,_iSub(_Add(mouseX,320),screenSizeX))

screenX2 = CreateVar(FP)
CiSub(FP,screenX2,screenX,screenSizeX)

CMov(FP, 0x6509B0, FP)
mmX = mouseX -- 상대좌표 좌측정렬
mmY = mouseY
mmX2 = screenX -- 중앙정렬
mmX3 = screenX2 -- 중앙정렬

--DisplayPrintEr(MapPlayers, {"상대좌표 X : ", mmX, "  Y : ", mmY, " || 중앙정렬 X : ", mmX2, "  Y : ", mmY," || 우측정렬 X : ",mmX3,"  Y : ",mmY});

GKeyValue = CreateVar(FP)
KeyTime = CreateVar(FP)
CalcValue = CreateVar(FP)
CAdd(FP,GKeyValue,1)
--DisplayPrintEr(MapPlayers, {"KeyTime: ",KeyTime,"   GKeyValue: ",GKeyValue,"   Calc : ",CalcValue})
--185~220
--398~431

function VRange(Var,Left,Right)
	return {CV(Var,Left,AtLeast),CV(Var,Right,AtMost)}
	
end
CSub(FP,CalcValue,GKeyValue,KeyTime)



CIf(FP,{Memory(0x6284B8 ,AtLeast,1),Memory(0x6284B8 + 4,AtMost,0)})

f_Read(FP,0x6284B8,nil,SelEPD)
f_Read(FP,_Add(SelEPD,25),SelUID,"X",0xFF,1)
f_Read(FP,_Add(SelEPD,19),SelPID,"X",0xFF,1)
CIf(FP,{CV(SelUID,111),CV(SelPID,LCP)})
CTrigger(FP, {TTKeyPress("C", "Down")}, {SetV(KeyTime,GKeyValue)},{preserved})
CTrigger(FP, {TTMousePress("LEFT", "Down"),VRange(mmX3,185,220),VRange(mmY, 398,431)}, {SetV(KeyTime,GKeyValue)},{preserved})
CIf(FP,{TMemoryX(_Add(SelEPD,38), AtMost, 227,0xFFFF)})
local SelBQ1 = CreateVar(FP)
f_Read(FP, _Add(SelEPD,38), SelBQ1, nil, 0xFFFF, 1)
CIf(FP, {TTOR({CV(SelBQ1,34),CV(SelBQ1,9),CV(SelBQ1,88),CV(SelBQ1,80),CV(SelBQ1,21)})})
Trigger2X(FP, {CV(CalcValue,35,AtLeast)}, {RotatePlayer({DisplayTextX("MacroWarn!!!", 4)}, HumanPlayers, FP)},{preserved})

CIfEnd()






CIfEnd()
CIfEnd()


CIfEnd()
CMov(FP, 0x6509B0, FP)
end