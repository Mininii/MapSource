function System()

	iTblJump = def_sIndex()
	CJump(FP, iTblJump)
	t01 = "\x07。\x18˙\x0F+\x1C˚  0000000000 \x04(00000\x0D\x04) \x1C。\x0F+\x18.\x07˚"
	t03 = "\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"
	iStrSize1 = GetiStrSize(0,t01)
	S1 = MakeiTblString(1394,"None",'None',MakeiStrLetter("\x0D",iStrSize1+5),"Base",1) -- 단축키없음
	iTbl1 = GetiTblId(FP,1394,S1) --DMG
	iTbl2 = GetiTblId(FP,1395,S1) --DMG
	iTbl3 = GetiTblId(FP,1396,S1) --DMG
	iTbl4 = GetiTblId(FP,1397,S1) --DMG
	iTbl6 = GetiTblId(FP,1398,S1) --DMG
	iTbl5 = GetiTblId(FP,764,S1) --DMG
	iTbl9 = GetiTblId(FP,1299,S1) --실명
	Str1, Str1a, Str1s = SaveiStrArrX(FP,t01)
	Str3, Str3a, Str3s = SaveiStrArrX(FP,t03)
	t04 = "\x07。\x18˙\x0F+\x1C˚\x19 R\x04espect \x17V! \x19(つ>ㅅ<)つ \x1C。\x0F+\x18.\x07˚"--일반
	t05 = "\x07。\x18˙\x0F+\x1C˚\x19 R\x04espect \x17V! \x19(つXㅅ<)つ \x1C。\x0F+\x18.\x07˚"--디텍터
	--iTbl7 = GetiTblId(FP,1319,S1) --DMG
	--iTbl8 = GetiTblId(FP,831,S1) --DMG
	--Str4, Str4a, Str4s = SaveiStrArrX(FP,t04)
	--Str5, Str5a, Str5s = SaveiStrArrX(FP,t05)
	T290 = "\x07。\x18˙\x0F+\x1C˚\x1F 행\x04이오닉 \x1C충\x04격파 \x19(つ>ㅅ<)つ \x1C。\x0F+\x18.\x07˚\x02 "
	T426 = "\x07。\x18˙\x0F+\x1C˚\x19(つ>ㅅ<)つ \x1C。\x0F+\x18.\x07˚\x02"
	T1365 = "\x07。\x18˙\x0F+\x1C˚\x19 흥\x04이오닉 \x08어\x04썰트 \x19(つ>ㅅ<)つ \x1C。\x0F+\x18.\x07˚\x02 "
	T1414 = "\x07。\x18˙\x0F+\x1C˚\x1F 행\x04이오닉 \x1C스\x04톰 \x19(つ>ㅅ<)つ \x1C。\x0F+\x18.\x07˚\x02 "
	TBLData = {
		{1319,t04},
		{831,t05},
		{290,T290},
		{426,T426},
		{1365,T1365},
		{1414,T1414},
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
		CElseIfX({TTOR({CV(SelClass,93),CV(SelAtkType,3)})})-- 일반형
		CS__SetValue(FP, Str3, "\x1BN\x04ormal \x04- \x07K\x04ills\x03: \x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D", 0xFFFFFFFF,1)
		for i = 0, 9 do
			TriggerX(FP, {CSVA1(SVA1(Str1,6+i), AtLeast, 0x0E*0x1000000, 0xFF000000),CD(CFlag,0)}, {SetCD(CFlag, 1),SetCSVA1(SVA1(Str1,6+i), SetTo, 0x1B, 0xFF)}, {preserved})
		end
		CS__InputVA(FP,iTbl2,0,Str1,Str1s,nil,0,Str1s)
		CS__InputVA(FP,iTbl5,0,Str3,Str3s,nil,0,Str3s)
		CElseIfX({TTOR({CV(SelClass,94),CV(SelAtkType,4)})})-- 방어무시
		CS__SetValue(FP, Str3, "\x1FI\x04gnore \x04- \x07K\x04ills\x03: \x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D", 0xFFFFFFFF,1)
		for i = 0, 9 do
			TriggerX(FP, {CSVA1(SVA1(Str1,6+i), AtLeast, 0x0E*0x1000000, 0xFF000000),CD(CFlag,0)}, {SetCD(CFlag, 1),SetCSVA1(SVA1(Str1,6+i), SetTo, 0x1F, 0xFF)}, {preserved})
		end
		CS__InputVA(FP,iTbl3,0,Str1,Str1s,nil,0,Str1s)
		CS__InputVA(FP,iTbl5,0,Str3,Str3s,nil,0,Str3s)
		CElseIfX(TTOR({CV(SelClass,92),CV(SelAtkType,1)}))--폭발형
		CS__SetValue(FP, Str3, "\x11E\x04xplosion \x04- \x07K\x04ills\x03: \x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D", 0xFFFFFFFF,1)
		for i = 0, 9 do
			TriggerX(FP, {CSVA1(SVA1(Str1,6+i), AtLeast, 0x0E*0x1000000, 0xFF000000),CD(CFlag,0)}, {SetCD(CFlag, 1),SetCSVA1(SVA1(Str1,6+i), SetTo, 0x11, 0xFF)}, {preserved})
		end
		CS__InputVA(FP,iTbl1,0,Str1,Str1s,nil,0,Str1s)
		CS__InputVA(FP,iTbl5,0,Str3,Str3s,nil,0,Str3s)
		CElseIfX(CV(SelAtkType,2))--진동형
		CS__SetValue(FP, Str3, "\x1DC\x04oncussive \x04- \x07K\x04ills\x03: \x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D", 0xFFFFFFFF,1)
		CS__InputVA(FP,iTbl5,0,Str3,Str3s,nil,0,Str3s)
		CIfXEnd()
		CIfXEnd()
		
		
		
	CIfEnd()


	DoActions(FP, {
		CreateUnit(1, 94, 20, P8),RemoveUnit(94, P8)
	})





	count = CreateVar(FP)
	f_Read(FP, 0x6283F0, count)
	DoActions(FP, {ModifyUnitEnergy(All, 40, AllPlayers, 64, 100)})

	
	EXCC_Part1(UnivCunit) -- 기타 구조오프셋 단락 시작
	
	EXCC_ClearCalc({SetMemory(0x6509B0,Subtract,16),SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000)})
	EXCC_Part2()
	EXCC_Part3X()
	for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
		EXCC_Part4X(i,{
			DeathsX(19025+(84*i)+9,AtMost,0,0,0xFF0000),--
			DeathsX(19025+(84*i)+19,AtLeast,1*256,0,0xFF00),
		},
		{MoveCp(Add,25*4),
		SetCVar(FP,CurCunitI2[2],SetTo,i),--SetResources(P1,Add,1,Gas)
		})
	end
	EXCC_End()


	HeroIndex = CreateVar(FP)
	EXCC_Part1(DUnitCalc) -- 죽은유닛 인식 단락 시작

	CDoActions(FP, {Set_EXCC2(UnivCunit, CurCunitI2, 0, SetTo, 0)})--죽인수 초기화

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
	for j,k in pairs(UnitPointArr) do
		Trigger2X(FP, {
			CVX(HeroIndex, k[1], 0xFF)}, {SetV(HPT, k[2]),print_utf8_A(HTArr, k[3]..string.rep("\x0D",0x40-(#k[3])))},{preserved})
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
	

	f_Div(FP, ExchangeOre, _Mul(_Mul(ExRate,HPT), 10),1000)
	CDoActions(FP, {TSetResources(Force1, Add, ExchangeOre, Ore)})
	DisplayPrint(HumanPlayers,{"\x13",StrD[1],HeroTextFunc,"\x04을(를) \x07처치하였다! \x1F＋ ",ExchangeOre," \x03Ｏｒｅ"..StrD[2]})
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
			--SetDeathsX(19025+(84*i)+9,SetTo,0*65536,0,0xFF0000),
			SetDeathsX(19025+(84*i)+35,SetTo,0,0,0xFF); -- 
			MoveCp(Add,19*4),
			SetCVar(FP,CurCunitI2[2],SetTo,i)
			})
		end
		EXCC_End()
	
	SETimer = CreateCcode()
	TriggerX(FP,{CDeaths(FP,Exactly,0,SETimer)},{SetCDeaths(FP,SetTo,0,SELimit),SetCDeaths(FP,SetTo,100,SETimer)},{preserved})
	DoActionsX(FP,{SetCDeaths(FP,Subtract,1,SETimer)})


	
	Install_GunStack()
	Create_G_CA_Arr()

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
		str33 = "\t\x1E。˙+˚Sadol。+.˚\x12\x11。˙+˚S\x04adol\x11。+.˚"
		str44 = "\x15。+.˚Space of Soul\x12\x11S\x04pace \x10o\x04f \x07S\x04oul\x10。+.˚" --s16 t5
		--str44 = "\t\t\t\x15。˙+˚Leon。+.˚\x12\x1B。˙+˚L\x04eon。+.˚"
		str55 = "\x15。+.˚Misty E'ra 'Mui'\x12\x10M\x04isty \x10E\x04'ra '\x10M\x04ui'\x10。+.˚"
		--str55 = "\t\x1E。˙+˚Turret。+.˚\x12\x11。˙+˚T\x04urret\x11。+.˚"--(sp:13 tab:4)

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
end