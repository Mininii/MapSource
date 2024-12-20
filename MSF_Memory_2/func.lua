
---@param Str? string
---@return string
function StrDesign(Str)
	return "\x0D\x0D\x07·\x11·\x08·\x07【 "..Str.." \x07】\x08·\x11·\x07·"
end

---@param Str? string
---@return string
function StrDesignX(Str)
	return "\x0D\x0D\x13\x07·\x11·\x08·\x07【 "..Str.." \x07】\x08·\x11·\x07·"
end
function StrDesignX2(Str)
	return "\x13\x07·\x11·\x08·\x07【 "..Str.." \x07】\x08·\x11·\x07·"
end
function TestSet(val)
	if val == 1 then 
		Limit = 1
		TestStart = 0
	elseif val == 2 then
		Limit = 1
		TestStart = 1
	else
		Limit = 0
		TestStart = 0
	end
end
function Install_BackupCP(Player)
	BackupCp = CreateVar(Player)
	SaveCp_CallIndex = SetCallForward()
	SetCall(Player)
		SaveCp(Player,BackupCp)
	SetCallEnd()

	LoadCp_CallIndex = SetCallForward()
	SetCall(Player)
		LoadCp(Player,BackupCp)
		SetRecoverCp()
	SetCallEnd()

	function f_SaveCp()
		CallTrigger(Player,SaveCp_CallIndex,nil)
	end
	function f_LoadCp()
		CallTrigger(Player,LoadCp_CallIndex,nil)
	end
end
function Install_EXCC(Player,ArrSize,ResetFlag) -- 확장 구조오프셋 단락 전용 배열 구성하기
	local HeaderV = CreateVar(Player) -- 헤더가 저장된 V
	local EXCunitTemp = CreateVarArr(ArrSize,Player) -- 구조오프셋 확장 변수 TempV
	local Index = FuncAlloc -- FuncAlloc에서 라벨 받아옴
	FuncAlloc = FuncAlloc + 3
	table.insert(CtrigInitArr[Player+1],SetCtrigX(Player,HeaderV[2],0x15C,0,SetTo,Player,Index+2,0x15C,1,1))--{"X",EXCC_Forward,0x15C,1,2}--CC_Header
	local EXCUnitArr = {}
	for k, v in pairs(EXCunitTemp) do
		table.insert(EXCUnitArr,SetCVar("X",v[2],SetTo,0))
	end

	if ResetFlag ~= nil then
		if type(ResetFlag) == "number" then
			local EXCunit_Reset = {} -- 필요시 리셋 또는 값 조정 테이블
			for i = 1, #EXCunitTemp do
				table.insert(EXCunit_Reset,SetCtrig1X("X","X",CAddr("Value",i,0),0,SetTo,0))
			end
			return {Player,Index,HeaderV,EXCunitTemp,EXCUnitArr,EXCunit_Reset}
		elseif type(ResetFlag) == "table" then
			local EXCunit_Reset = {} -- 필요시 리셋 또는 값 조정 테이블(타이머or값초기화 등)
			for i = 1, #EXCunitTemp do
				if ResetFlag[i]~= nil then
					if type(ResetFlag[i]) == "table" then
						local X = ResetFlag[i]
						local RFValue = X[1]
						local RFType
						local RFMask
						if X[2] == nil then
							RFType = SetTo
						else
							RFType = X[2]
						end
						if X[3] == nil then
							RFMask = 0xFFFFFFFF
						else
							RFMask = X[3]
						end

						table.insert(EXCunit_Reset,SetCtrig1X("X","X",CAddr("Value",i,0),0,RFType,RFValue,RFMask))
					else
						PushErrorMsg("ResetFlag_Inputdata_Error")
					end
				end
			end
			return {Player,Index,HeaderV,EXCunitTemp,EXCUnitArr,EXCunit_Reset}
		end
	else
		return {Player,Index,HeaderV,EXCunitTemp,EXCUnitArr}
	end
end
function Set_EXCC2(EXCC_init,CUnitIndex,Line,Type,Value) -- EXCC단락 외부에서 값을 쓰고싶을때. 무조건 T액션, 너무많이 쓸 경우 성능 하락 우려 있음
	return TSetMemory(_Add(_Mul(CUnitIndex,_Mov(0x970/4)),_Add(EXCC_init[3],((0x20*Line)/4))),Type,Value)
end
function Set_EXCC2X(EXCC_init,CUnitIndex,Line,Type,Value,Mask) -- EXCC단락 외부에서 값을 쓰고싶을때. 무조건 T액션, 너무많이 쓸 경우 성능 하락 우려 있음
	return TSetMemoryX(_Add(_Mul(CUnitIndex,_Mov(0x970/4)),_Add(EXCC_init[3],((0x20*Line)/4))),Type,Value,Mask)
end

function Set_EXCC(Line,Type,Value) -- EXCC단락 내부에서 값을 쓰고싶을때. 실제값 X
	return SetV(EXCC_TempVarArr[Line+1],Value,Type)
end
function Set_EXCCX(Line,Type,Value,Mask) -- EXCC단락 내부에서 값을 쓰고싶을때. 실제값
	if Mask == nil then Mask = 0xFFFFFFFF end
	return TSetMemoryX(_Add(EXCC_TempHeader,((0x20*Line)/4)),Type,Value,Mask)
end


function Cond_EXCC(Line,Type,Value,Mask) -- EXCC단락 내부에서 값을 검사하고 싶을때.
	return CVar(FP,EXCC_TempVarArr[Line+1][2],Type,Value,Mask)
end
function Cond_EXCC2(EXCC_init,CUnitIndex,Line,Type,Value) -- EXCC단락 외부에서 값을 검사하고 싶을때.
	return TMemory(_Add(_Mul(CUnitIndex,_Mov(0x970/4)),_Add(EXCC_init[3],((0x20*Line)/4))),Type,Value)
end
function Cond_EXCC2X(EXCC_init,CUnitIndex,Line,Type,Value,Mask) -- EXCC단락 외부에서 값을 검사하고 싶을때.
	return TMemoryX(_Add(_Mul(CUnitIndex,_Mov(0x970/4)),_Add(EXCC_init[3],((0x20*Line)/4))),Type,Value,Mask)
end
function _Cond_EXCC2(EXCC_init,CUnitIndex,Line,Type,Value) -- EXCC단락 외부에서 값을 검사하고 싶을때. TTOR전용
	return _TMemory(_Add(_Mul(CUnitIndex,_Mov(0x970/4)),_Add(EXCC_init[3],((0x20*Line)/4))),Type,Value)
end
EXCC_initArr = {}
function EXCC_Part1(EXCC_init,Actions)
	if #EXCC_initArr ~= 0 then
		PushErrorMsg("EXCCinitArr_Already_Loading")
	end
	EXCC_initArr = EXCC_init
	EXCC_Player = EXCC_initArr[1]
	EXCC_Index = EXCC_initArr[2]
	EXCC_TempVarArr = EXCC_initArr[4]
	PlayerID = EXCC_Player
	EXCC_TempHeader = CreateVar(EXCC_Player)
	PlayerID = PlayerConvert(PlayerID)
	Trigger { -- Cunit Ctrig Start
		players = {PlayerID},
		conditions = { 
			Label(0);
		},
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",EXCC_Index+2,0,0,1); 
		},
		flag = {preserved}
	}	
	Trigger { -- Cunit Calc Selector
		players = {PlayerID},
		conditions = { 
			Label(EXCC_Index);
		},
		actions = {
			SetDeathsX(0,SetTo,0,0,0xFFFFFFFF); -- RecoverNext
			Actions,
		},
		flag = {preserved}
	}	
	
end
-- NJump Trig 삽입 부분 (조건만족시 Jump)
function EXCC_Part2()
	PlayerID = EXCC_Player
	PlayerID = PlayerConvert(PlayerID)
	for k, P in pairs(PlayerID) do
		Trigger { -- Cunit Calc Last
			players = {P},
			conditions = { 
				Label(EXCC_Index+1);
			},
		   	actions = {
				SetDeathsX(0,SetTo,0,0,0xFFFFFFFF); -- RecoverNext
				SetMemory(0x6509B0,SetTo,P);
			},
			flag = {preserved}
		}	
	end
end
function EXCC_Part3X()
	MoveCpValue = 0
	PlayerID = EXCC_Player
	Trigger { -- Cunit Calc Start
		players = {PlayerID},
		conditions = { 
			Label(EXCC_Index+2);
		},
		flag = {preserved}
	}	
end

function EXCC_Part4X(LoopIndex,Conditions,Actions)
	MoveCpValue = 0
	PlayerID = EXCC_Player
	Trigger { -- Cunit Calc Main
		players = {PlayerID},
		conditions = { 
			Label(0);
			Conditions,
		},
		actions = { 
		EXCC_initArr[5],
		SetCtrigX("X","X",0x4,0,SetTo,"X",EXCC_Index,0,0,0);
		SetCtrigX("X",EXCC_Index+1,0x4,0,SetTo,"X","X",0,0,1);
		SetCtrigX("X",EXCC_Index,0x158,0,SetTo,"X","X",0x4,1,0);
		SetCtrigX("X",EXCC_Index,0x15C,0,SetTo,"X","X",0,0,1);
		SetCtrigX("X",EXCC_TempHeader[2],0x15C,0,SetTo,"X","X",0x15C,1,0),
		SetMemory(0x6509B0,SetTo,19025 + (84 * LoopIndex));
		Actions,
		EXCC_initArr[6]
			},
		flag = {preserved}
	}		
end

	
function EXCC_ClearCalc(Actions)
	PlayerID = EXCC_Player
	Trigger { -- Cunit Calc End
		players = {PlayerID},
		conditions = { 
			Label(0);
		}, 
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",EXCC_Index+1,0,0,0);
			Actions
		},
		flag = {preserved}
	}	
end

function EXCC_BreakCalc(Conditions,Actions)	
	PlayerID = EXCC_Player
	STPopTrigArr(PlayerID)
	TTPopTrigArr(PlayerID)
	Conditions = PopCondArr(Conditions)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,3)

	Trigger { -- Cunit Calc Break
		players = {PlayerID},
		conditions = { 
			Label(0);
			Conditions,
		}, 
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",EXCC_Index+1,0,0,0);
			SetCtrigX("X",EXCC_Index+1,0x158,0,SetTo,"X","X",0x4,1,0);
			SetCtrigX("X",EXCC_Index+1,0x15C,0,SetTo,"X","X",0,0,1);
			Actions,
		},
		flag = {preserved}
	}	
end

function EXCC_End()
	EXCC_Index = nil
	EXCC_Player = nil
	EXCC_initArr = {}
	EXCC_TempHeader = nil
end
	



function Include_CRandNum(Player)
	TempRandRet = CreateVar(Player)
	Oprnd = CreateVar(Player)
	InputMaxRand = CreateVar(Player)
CRandNum = SetCallForward()
SetCall(Player)
f_Rand(Player,TempRandRet)
f_Mod(Player,TempRandRet,InputMaxRand)
CAdd(Player,TempRandRet,Oprnd)
SetCallEnd()
function f_CRandNum(Max,Operand,Condition)
	if Operand == nil then Operand = 0 end
	local RandRet = TempRandRet
	CallTriggerX(Player,CRandNum,Condition,{SetCVar(Player,InputMaxRand[2],SetTo,Max),SetCVar(Player,Oprnd[2],SetTo,Operand)})
	return RandRet
end
end



function Install_UnitCount(Player)
	count,count1,count2,count3 = CreateVars(4,FP)
	function Cast_UnitCount()
		--UnitReadX(Player,AllPlayers,229,64,count)
		--UnitReadX(Player,AllPlayers,17,nil,count1)
		--UnitReadX(Player,AllPlayers,23,nil,count2)
		--UnitReadX(Player,AllPlayers,25,nil,count3)
		--CAdd(Player,count,count1)
		--CAdd(Player,count,count2)
		--CAdd(Player,count,count3)
		f_Read(Player, 0x6283F0, count)
	end
end


function UnitLimit(Player,UID,Limit,Text,ReturnResources)
	Trigger {
		players = {Player},
		conditions = {
			Label();
			Bring(Player,AtLeast,Limit+1,UID,64);
			},
		
		actions = {
			KillUnitAt(1,UID,"Anywhere",Player);
			DisplayText(StrDesign("\x04"..Text.." "..Limit.."기를 넘어서 소지할 수 없습니다. \x1C자원 반환 \x1F+ "..ReturnResources.." Ore\x07"),4);
			SetResources(Player,Add,ReturnResources,Ore);
			PreserveTrigger();
		},
	}
end


function IBGM_EPDX(Player,MaxPlayer,MSQC_Recives,Option_NT,BGMDeathsT)
	local Dx,Dy,Dv,Du,DtP = CreateVariables(5)
	
	f_Read(Player,0x51CE8C,Dx)
	CiSub(Player,Dy,_Mov(0xFFFFFFFF),Dx)
	CiSub(Player,DtP,Dy,Du)
	CMov(Player,Dv,DtP) 
	CMov(Player,0x58F500,DtP) -- MSQC val Send. 180
	CMov(Player,Du,Dy)
	

	if Option_NT ~= nil then
		if type(Option_NT) == "table" then
		CIf(FP,{NTCond2()})
			CMov(FP,Option_NT[1],MSQC_Recives)
		CIfEnd()
		CIf(FP,{NTCond()})
			CAdd(FP,Option_NT[2],MSQC_Recives,Option_NT[1])
		CIfEnd()
		else
			PushErrorMsg("OPtion_NT_InputData_Error")
		end
	end

	for j, k in pairs(BGMDeathsT) do
		for i = 0, MaxPlayer do
			CTrigger(Player,{HumanCheck(i,1)},{TSetDeathsX(i,Subtract,MSQC_Recives,k,0xFFFFFF)},1) -- 브금타이머
			CTrigger(Player,{HumanCheck(i,0)},{SetDeaths(i,SetTo,0,k)},1) -- 브금타이머
		end
		CDoActions(Player,{TSetDeathsX(Player,Subtract,MSQC_Recives,k,0xFFFFFF),
		SetDeathsX(Player,SetTo,0,k,0xFF000000),
		SetDeaths(8,SetTo,0,k),SetDeaths(9,SetTo,0,k),SetDeaths(10,SetTo,0,k),SetDeaths(11,SetTo,0,k)}) -- 브금타이머
	end
end



function CreateBPtrRetArr(MaxPlayer,Ptr,Multiplier)
	local X = {}
	local Y = {}
	for i = 0, MaxPlayer do
		table.insert(X,(Ptr+(i*Multiplier))%4)
		table.insert(Y,(Ptr+(i*Multiplier))-X[i+1])
	end
	return X,Y
end

function S_to_EmS(Str)
	local X={}
	for i = 1, #Str do
		local Check = string.byte(string.sub(Str,i,i),1)
		if Check<=0x20 or Check==string.byte(" ",1) then
			table.insert(X,string.sub(Str,i,i))
		else	
			if Check>=97 and Check<=97+26 then
				table.insert(X,string.char(239,189,32+string.byte(string.sub(Str,i,i),1)))
			else
				table.insert(X,string.char(239,188,96+string.byte(string.sub(Str,i,i),1)))
			end
		end
		--239,188,96+n
	end
	return table.concat(X),X
end
function N_to_EmN(Num)
	if type(Num) ~= "string" then Num = tostring(Num) end
	T,X = S_to_EmS(Num)
	local LoopCount = 0
	for i = #X, 1, -1 do
		LoopCount = LoopCount+1
		if LoopCount>=3 and i~=1 then
			LoopCount = LoopCount - 3
			table.insert(X,i,",")
		end
	end
	return table.concat(X)
end
function Conv_HStr(Str)
	return "\x10【 "..S_to_EmS(Convert_StrCode(Str)).." \x10】"
end
function Conv_HStr2(Str)
	return S_to_EmS(Convert_StrCode(Str))
end


function Convert_StrCode(Str)
	for i = 1, #Str do
		if string.sub(Str,i,i) == "<" then
			for j= i, #Str do
				if string.sub(Str,j,j) == ">" then
					local Str1 = string.sub(Str,1,i-1)
					local Str2 = string.sub(Str,j+1,#Str)
					local Code = string.sub(Str,i+1,j-1)
					Str = Str1..string.char(tonumber(Code,16))..Str2
				break end
				if j == #Str then PushErrorMsg("StrCode_EndPos_NotFound") end
			end
		end
	end
	return Str
end
HeroPointArr = {}
function CreateHeroPointArr(Index,KillPoint,HPRate,ShieldRate,Name,Point,Type,DmgType,EraUngmeojulFlag) --  영작 유닛 설정 함수
	if DmgType == nil then DmgType = 0 end
	local TextType1 = " \x08처치\x04"
	local TextType2 = " \x07획득\x04"
	local Name2
	if Type == 1 then
		Name2 = TextType1
	elseif Type == 2 then
		Name2 = TextType2
	
	elseif Type == nil then
		Name2 = TextType1
	else
		PushErrorMsg("Need_Input_TextType")
	end
	local Text = "\x10기억\x04의 "..Name..""..Name2.." \x1F＋"..N_to_EmN(Point).."\x1FＰｔｓ"
	if EraUngmeojulFlag ~= nil then
		table.insert(EraUngmeojulT,{Index,"\x10기억\x04의 "..Name})
	end
	local X = {}
	
	table.insert(X,"\x0D\x0D!H"..StrDesignX2(Text))
	table.insert(X,Index)
	table.insert(X,Point) -- HPoint
	table.insert(X,DmgType) -- HPoint
	table.insert(X,HPRate*256) -- HPoint
	table.insert(X,ShieldRate) -- HPoint
	table.insert(HeroPointArr,X)
	
end
function InstallHeroPoint() -- CreateHeroPointArr에서 전송받은 영웅 포인트 정보 설치 함수. CunitCtrig 단락에 포함됨.
	for i = 1, #HeroPointArr do
		local CT = HeroPointArr[i][1]
		local index = HeroPointArr[i][2]
		local Point = HeroPointArr[i][3]
		local EXPPoint = (Point/700)
		if EVFFlag == 1 then EXPPoint = EXPPoint*2 end
			CIf(FP,DeathsX(CurrentPlayer,Exactly,index,0,0xFF))
			TriggerX(FP, {CVar(FP,SetPlayers[2],Exactly,1)}, AddV(CurEXP,EXPPoint),{preserved})
			DoActions2X(FP,{SetScore(Force1,Add,Point,Kills),AddV(CurEXP,EXPPoint),RotatePlayer({DisplayTextX(CT,4);},HumanPlayers,FP)})
			Trigger2X(FP,{CDeaths(FP,AtMost,5,SoundLimit)},{RotatePlayer({PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg");},HumanPlayers,FP),SetCDeaths(FP,Add,1,SoundLimit),},{preserved})
			f_LoadCp()
			if index == 68 then
				DoActions(FP,{MoveCp(Subtract,4*6)})
				TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,4,0,0xFF)},{AddCD(TTEndC1,1)},{preserved})
				TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,5,0,0xFF)},{AddCD(TTEndC2,1)},{preserved})
				TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,6,0,0xFF)},{AddCD(TTEndC1,1)},{preserved})
				TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,7,0,0xFF)},{AddCD(TTEndC2,1)},{preserved})
				DoActions(FP,{MoveCp(Add,4*6)})
			end
			CIfEnd()
			

	end
end


function Install_CText1(StrPtr,CText1,CText2,PlayerVArr)

	f_Memcpy(FP,StrPtr,_TMem(Arr(CText1[3],0),"X","X",1),CText1[2])
	f_Movcpy(FP,_Add(StrPtr,CText1[2]),VArr(PlayerVArr,0),4*5)
	f_Memcpy(FP,_Add(StrPtr,CText1[2]+(4*6)+3),_TMem(Arr(CText2[3],0),"X","X",1),CText2[2])

end

function Install_DeathNotice()
	for j = 1, 4 do
		

	
	CIf(FP,DeathsX(CurrentPlayer,Exactly,MarID[j],0,0xFF))
		DoActions(FP,MoveCp(Subtract,6*4))
		EXCC_BreakCalc({DeathsX(CurrentPlayer,Exactly,11,0,0xFF)})
		f_SaveCp()
		DoActions2X(FP,{
			SetScore(j-1,Add,2,Custom);
			AddV(DCV,2);
		})
		Trigger2X(FP,{CDeaths(FP,AtMost,5,SoundLimit)},{RotatePlayer({PlayWAVX("staredit\\wav\\die_se.ogg")},HumanPlayers,FP),SetCDeaths(FP,Add,1,SoundLimit)},{preserved})
		DisplayPrint(HumanPlayers,{"\x0D\x0D!H\x07·\x11·\x08·\x07【 ",PName(j-1),"\x04의 "..Color[j].."Ｌ\x11ｕ\x03ｍ\x18ｉ"..Color[j].."Ａ "..Color[j].."Ｍ\x04ａｒｉｎｅ이 \x16빛\x04을 \x04잃었습니다. \x07】\x08·\x11·\x07·"})
		f_LoadCp()
		DoActions(FP,MoveCp(Add,6*4))
	CIfEnd()
	DoActions(FP,MoveCp(Subtract,6*4))
	CIf(FP,{DeathsX(CurrentPlayer,Exactly,j-1,0,0xFF)})
	DoActions(FP,MoveCp(Add,6*4))
	CIf(FP,DeathsX(CurrentPlayer,Exactly,32,0,0xFF))
		f_SaveCp()
		DoActions2X(FP,{
			SetScore(j-1,Add,1,Custom);
			AddV(DCV,1);
		})
		Trigger2X(FP,{CDeaths(FP,AtMost,5,SoundLimit)},{RotatePlayer({PlayWAVX("staredit\\wav\\die_se.ogg")},HumanPlayers,FP),SetCDeaths(FP,Add,1,SoundLimit)},{preserved})
		DisplayPrint(HumanPlayers,{"\x0D\x0D!H\x07·\x11·\x08·\x07【 ",PName(j-1),"\x04의 Ｍ\x04ａｒｉｎｅ이 \x16빛\x04을 \x04잃었습니다. \x07】\x08·\x11·\x07·"})
		f_LoadCp()
	CIfEnd()
	CIf(FP,DeathsX(CurrentPlayer,Exactly,20,0,0xFF))
		f_SaveCp()
		DoActions2X(FP,{
			SetScore(j-1,Add,1,Custom);
			AddV(DCV,1);
		})
		Trigger2X(FP,{CDeaths(FP,AtMost,5,SoundLimit)},{RotatePlayer({PlayWAVX("staredit\\wav\\die_se.ogg")},HumanPlayers,FP),SetCDeaths(FP,Add,1,SoundLimit)},{preserved})
		DisplayPrint(HumanPlayers,{"\x0D\x0D!H\x07·\x11·\x08·\x07【 ",PName(j-1),"\x04의 \x1BＨ \x04Ｍ\x04ａｒｉｎｅ이 \x16빛\x04을 \x04잃었습니다. \x07】\x08·\x11·\x07·"})
		f_LoadCp()
	CIfEnd()
	DoActions(FP,MoveCp(Subtract,6*4))
	CIfEnd()
	DoActions(FP,MoveCp(Add,6*4))
end

end


	

function Include_G_CA_Library(DefaultAttackLoc,StartIndex,Size_of_G_CA_Arr)
	if CPos == nil then PushErrorMsg("Need_Include_Conv_CPosXY") end
	if FP == nil then PushErrorMsg("Need_Define_Fixed_Player ( ex : FP = P8 )") end
	if GLocC == nil then PushErrorMsg("Need_Install_GetCLoc") end
	if TempRandRet == nil then PushErrorMsg("Need_Include_CRandNum") end

	CXPlotVAI = CreateVar(FP)
	CXPlotVAI4 = CreateVar(FP)
	

	if DefaultAttackLoc == nil then
		PushErrorMsg("G_CA_DefaultXY_InputData_Error")
	elseif DefaultAttackLoc == 0 then
		DefaultAttackLoc = 9
		DefaultAttackLocCheck = 1
	end
f_RepeatTypeErr = "\x07『 \x08ERROR : \x04잘못된 RepeatType이 입력되었습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
f_RepeatErr = "\x07『 \x08ERROR : \x04f_Repeat에서 문제가 발생했습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
f_RepeatErr2 = "\x07『 \x08ERROR : \x04Set_Repeat에서 잘못된 UnitID(0)을 입력받았습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
f_GunSendErrT = "\x07『 \x08ERROR \x04: G_CA_SpawnSet 목록이 가득 차 데이터를 입력하지 못했습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
G_CA_PosErr = "\x07『 \x03CAUCTION : \x04생성 좌표가 맵 밖을 벗어났습니다.\x07 』"
f_GunErrT = "\x07『 \x08ERROR \x04: G_CAPlot Not Found. \x07』"
f_GunFuncT = "\x07『 \x03TESTMODE OP \x04: G_CAPlot Suspended. \x07』"
f_GunFuncT2 = "\x07『 \x03TESTMODE OP \x04: G_CAPlot Sended. \x07』"
local Gun_TempSpawnSet1 = CreateVar(FP)
local Gun_TempSpawnSet2 = CreateVar(FP)
local Gun_TempSpawnSet3 = CreateVar(FP)
local Gun_TempSpawnSet4 = CreateVar(FP)
local Gun_TempSpawnSet5 = CreateVar(FP)
local Spawn_TempW = CreateVar(FP)
local RepeatType = CreateVar(FP)
local G_CA_Nextptrs = CreateVar(FP)
local G_CA_Nextptrs2 = CreateVar(FP)
local Repeat_TempV = CreateVar(FP)
local CreatePlayer = CreateVar(FP)
local G_CA_LineV = CreateVar(FP)
local G_CA_CUTV = CreateVarArr(5,FP)
local G_CA_SNTV = CreateVar(FP)
local G_CB_SNTV = CreateVarArr(4,FP)
local G_CA_LMTV = CreateVar(FP)
local G_CA_RPTV = CreateVar(FP)
local G_CA_Owner = CreateVar(FP)
local G_CA_EffType = CreateVar(FP)
local G_CA_XPos = CreateVar(FP)
local G_CA_YPos = CreateVar(FP)
local G_CA_MaxNum = CreateVar(FP)
local G_CA_FuncNum = CreateVar(FP)
TRepeatX = CreateVar(FP)
TRepeatY = CreateVar(FP)
local G_CA_UnitIndex = CreateVar(FP)
local Write_SpawnSet_Jump = def_sIndex()
local G_CA_Arr_IndexAlloc = StartIndex
local G_CA_InputCVar = {}
local G_CA_Lines = 55
local G_CA_TempTable = CreateVarArr(G_CA_Lines,FP)
local G_CA_TempH = CreateVar(FP)
local G_CA_Num = CreateVar(FP)
local G_CA_InputH = CreateVar(FP)
local G_CA_LineTemp = CreateVar(FP)
local CA_Repeat_Check = CreateCcode()
local TargetArr = { {160,144},{3936,144},{160,3952},{3936,3952} }
G_CA_CenterX = CreateVar(FP)
G_CA_CenterY = CreateVar(FP)
G_CA_Player = CreateVar(FP)
local LDrX,LDrY = CreateVars(2,FP)
local G_CA_X = CreateVar(FP)
local G_CA_Y = CreateVar(FP)
local G_CA_BakX = CreateVar(FP)
local G_CA_BakY = CreateVar(FP)
local G_CA_WSTestStrPtr = CreateVar(FP)
local G_CA_WSTestVA = CreateVArr(5,FP)
local TargetRotation = CreateVar(FP)
PatchCondArr = {UnitIDV1,UnitIDV2,UnitIDV3,UnitIDV4}
Call_Repeat = SetCallForward() -- 유닛생성부
SetCall(FP)
CWhile(FP,{Memory(0x628438,AtLeast,1),CVar(FP,Spawn_TempW[2],AtLeast,1)})

	CIfX(FP,{CVar(FP,RepeatType[2],Exactly,101)}) -- 이펙트유닛 or 탄막유닛

		CIfX(FP,CVar(FP,G_CA_TempTable[13][2],Exactly,0))
			CreateBulletXY(Gun_TempSpawnSet1,20,nil,{G_CA_TempTable[11],G_CA_TempTable[12]},FP)-- 위치로 쏘기
			--SetBullet(Gun_TempSpawnSet1,20,nil,{G_CA_TempTable[11],G_CA_TempTable[12]}) -- 위치로 쏘기
		CElseIfX(CVar(FP,G_CA_TempTable[13][2],Exactly,1))
			CreateBullet(Gun_TempSpawnSet1,20,0,nil,FP) -- 각도없이 쏘기
		CElseIfX(CVar(FP,G_CA_TempTable[13][2],Exactly,2))
			CreateBullet(Gun_TempSpawnSet1,20,G_CA_TempTable[14],nil,FP)--각도로 쏘기
		CElseIfX({CVar(FP,G_CA_TempTable[13][2],Exactly,3)})--뉴클리어런치
			CallTrigger(FP, Call_Nuke)
		CElseX()
			DoActions2X(FP,RotatePlayer({DisplayTextX(f_RepeatTypeErr,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP))
		CIfXEnd()
	CElseX()
		f_Read(FP,0x628438,"X",G_CA_Nextptrs,0xFFFFFF)
		CSub(FP,G_CA_UnitIndex,G_CA_Nextptrs,19025)
		f_Div(FP,G_CA_UnitIndex,_Mov(84))
		CDoActions(FP,{Set_EXCC2(DUnitCalc,G_CA_UnitIndex,1,SetTo,2)})
		CTrigger(FP,{TTCVar(FP,RepeatType[2],NotSame,100)},{TSetMemoryX(_Add(G_CA_Nextptrs,9),SetTo,1*65536,0xFF0000),},1)
		CTrigger(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,128)},{TSetMemoryX(_Add(G_CA_Nextptrs,9),SetTo,0*65536,0xFF0000),},1)

		

		CIf(FP,{CDeaths(FP,AtMost,0,CA_Repeat_Check)},{
				SetCVar(FP,G_CA_TempTable[1][2],SetTo,0);
				SetCVar(FP,G_CA_TempTable[11][2],SetTo,0);
				SetCVar(FP,G_CA_TempTable[12][2],SetTo,0);
				SetCVar(FP,G_CA_TempTable[13][2],SetTo,0);
				SetCVar(FP,G_CA_TempTable[14][2],SetTo,0);
			}) -- TempRepeat로 생성했을 경우
			--DisplayPrint(HumanPlayers, {UnitIDV1,"   ",UnitIDV2,"   ",UnitIDV3,"   ",UnitIDV4})
			--DisplayPrint(HumanPlayers, {Gun_TempSpawnSet1})
			for i = 0, 3 do
				for j= 0, 3 do
					CTrigger(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,(221+i)*256^j,255*(256^j))},{TSetCVar(FP,Gun_TempSpawnSet1[2],SetTo,_Mul(PatchCondArr[i+1],256^j),255*(256^j))},1)
				end
			end

			CIf(FP,{CVar(FP,RepeatType[2],Exactly,100)})
			CMov(FP,G_CA_TempTable[1],Gun_TempSpawnSet1)
			CMov(FP,G_CA_TempTable[11],Gun_TempSpawnSet2)
			CMov(FP,G_CA_TempTable[12],Gun_TempSpawnSet3)
			CMov(FP,G_CA_TempTable[13],Gun_TempSpawnSet4)
			CMov(FP,G_CA_TempTable[14],Gun_TempSpawnSet5)
			CMov(FP,Gun_TempSpawnSet1,0)
			CMov(FP,Gun_TempSpawnSet2,0)
			CMov(FP,Gun_TempSpawnSet3,0)
			CMov(FP,Gun_TempSpawnSet4,0)
			CMov(FP,Gun_TempSpawnSet5,0)
			CIfEnd()
			CTrigger(FP,{CVar(FP,CreatePlayer[2],Exactly,0x7FFFFFFF)},{SetCVar(FP,CreatePlayer[2],SetTo,0),TSetCVar(FP,CreatePlayer[2],SetTo,G_CA_Player,0xFF)},1)
			CIf(FP,{CVar(FP,TRepeatX[2],AtMost,0x7FFFFFFF)})
				Simple_SetLocX(FP,0,TRepeatX,TRepeatY,TRepeatX,TRepeatY)
				CMov(FP,G_CA_TempTable[8],TRepeatX)
				CMov(FP,G_CA_TempTable[9],TRepeatY)
				CMov(FP,G_CA_X,TRepeatX)
				CMov(FP,G_CA_Y,TRepeatY)
			CIfEnd()
		CIfEnd()
		CIfX(FP,{CVar(FP,CreatePlayer[2],Exactly,0xFFFFFFFF)},{SetSwitch(RandSwitch,Random),SetSwitch(RandSwitch2,Random)}) -- 생성플레이어가 설정되지 않았을경우
		TriggerX(FP,{Switch(RandSwitch,Cleared),Switch(RandSwitch2,Cleared)},{SetCVar(FP,CreatePlayer[2],SetTo,4)},{preserved})
		TriggerX(FP,{Switch(RandSwitch,Set),Switch(RandSwitch2,Cleared)},{SetCVar(FP,CreatePlayer[2],SetTo,5)},{preserved})
		TriggerX(FP,{Switch(RandSwitch,Cleared),Switch(RandSwitch2,Set)},{SetCVar(FP,CreatePlayer[2],SetTo,6)},{preserved})
		TriggerX(FP,{Switch(RandSwitch,Set),Switch(RandSwitch2,Set)},{SetCVar(FP,CreatePlayer[2],SetTo,7)},{preserved})
		CIfXEnd()
		if DefaultAttackLocCheck == 1 then -- 디폴트 로케이션이 0일 경우 RepeatType에 따라 중심점으로 어택
			CIfX(FP,{TTOR({CVar(FP,RepeatType[2],Exactly,1),CVar(FP,RepeatType[2],Exactly,194)})}) -- 어택 일반 해당플레이어 위치로
				CIfX(FP,Never())
			for i = 0, 3 do
				CElseIfX({CVar(FP,CreatePlayer[2],Exactly,i+4),HumanCheck(i,1)})
					Simple_SetLocX(FP,DefaultAttackLoc,TargetArr[i+1][1]+2,TargetArr[i+1][2]+2,TargetArr[i+1][1]+2,TargetArr[i+1][2]+2)
			end
				CElseX() -- 해당플레이어가 존재하지 않을 경우 
				CTrigger(FP, {TTCVar(FP,TargetRotation[2],NotSame,0xFFFFFFFF)}, {SetV(TargetRotation,CreatePlayer)}, 1)
					CIfX(FP,{CD(Theorist,0)})--이론치모드가 아닐 경우 현존하는 플레이어에게 어택
						local L_Gun_Order2 = def_sIndex()
						NJumpXEnd(FP,L_Gun_Order2)

						for i = 0, 3 do
							CIf(FP,{CVar(FP,TargetRotation[2],Exactly,i+4),HumanCheck(i,0)})
							DoActions(FP,{SetSwitch(RandSwitch,Random),SetSwitch(RandSwitch2,Random)})
							TriggerX(FP,{Switch(RandSwitch,Cleared),Switch(RandSwitch2,Cleared)},{SetV(TargetRotation,4)},{preserved})
							TriggerX(FP,{Switch(RandSwitch,Set),Switch(RandSwitch2,Cleared)},{SetV(TargetRotation,5)},{preserved})
							TriggerX(FP,{Switch(RandSwitch,Cleared),Switch(RandSwitch2,Set)},{SetV(TargetRotation,6)},{preserved})
							TriggerX(FP,{Switch(RandSwitch,Set),Switch(RandSwitch2,Set)},{SetV(TargetRotation,7)},{preserved})
							CIfEnd()
						end
						for j = 0, 3 do
						NJumpX(FP,L_Gun_Order2,{CVar(FP,TargetRotation[2],Exactly,j+4),HumanCheck(j,0)}) -- 타겟 설정 시 플레이어가 없을 경우 다시 연산함
						end
						
						CIfX(FP,Never())
						for i = 0, 3 do
							CElseIfX({CVar(FP,TargetRotation[2],Exactly,i+4),HumanCheck(i,1)})
							Simple_SetLocX(FP,DefaultAttackLoc,TargetArr[i+1][1]+2,TargetArr[i+1][2]+2,TargetArr[i+1][1]+2,TargetArr[i+1][2]+2)
						end
						CElseX() -- TargetRotation이 0xFFFFFFFF일 경우 생성 중심점에 어택
						Simple_SetLocX(FP,DefaultAttackLoc,G_CA_TempTable[8],G_CA_TempTable[9],G_CA_TempTable[8],G_CA_TempTable[9])
						CIfXEnd()
					CElseX()--이론치모드일 경우 생성 중심점에 어택
						Simple_SetLocX(FP,DefaultAttackLoc,G_CA_TempTable[8],G_CA_TempTable[9],G_CA_TempTable[8],G_CA_TempTable[9])
					CIfXEnd()
				CIfXEnd()
			CElseIfX({CVar(FP,RepeatType[2],Exactly,100)}) 
				CMov(FP,G_CA_BakX,G_CA_TempTable[8])
				CMov(FP,G_CA_BakY,G_CA_TempTable[9])

				CIfX(FP,Never())
					CElseIfX({CD(tesStart,1,AtLeast)})--testify 발동시 우선. 어택지점 = 생산중심점
					Simple_SetLocX(FP,DefaultAttackLoc,G_CA_TempTable[8],G_CA_TempTable[9],G_CA_TempTable[8],G_CA_TempTable[9])
					CElseIfX({CD(EDNum,1,AtLeast)})--보스전 우선. 어택지점 = 생산중심점
					Simple_SetLocX(FP,DefaultAttackLoc,G_CA_TempTable[8],G_CA_TempTable[9],G_CA_TempTable[8],G_CA_TempTable[9])

				for i = 0, 3 do
					CElseIfX({CVar(FP,CreatePlayer[2],Exactly,i+4),HumanCheck(i,1)})
						Simple_SetLocX(FP,DefaultAttackLoc,G_CA_TempTable[8],G_CA_TempTable[9],G_CA_TempTable[8],G_CA_TempTable[9])
						CMov(FP,G_CA_TempTable[8],TargetArr[i+1][1])
						CMov(FP,G_CA_TempTable[9],TargetArr[i+1][2])
				end
				CElseX() -- 해당플레이어가 존재하지 않을 경우
				CTrigger(FP, {TTCVar(FP,TargetRotation[2],NotSame,0xFFFFFFFF)}, {SetV(TargetRotation,CreatePlayer)}, 1)
				
					CIfX(FP,{CD(Theorist,0)})--이론치모드가 아닐 경우 현존하는 플레이어에게 어택

						local L_Gun_Order = def_sIndex()
						NJumpXEnd(FP,L_Gun_Order)

						for i = 0, 3 do
							CIf(FP,{CVar(FP,TargetRotation[2],Exactly,i+4),HumanCheck(i,0)})
							DoActions(FP,{SetSwitch(RandSwitch,Random),SetSwitch(RandSwitch2,Random)})
							TriggerX(FP,{Switch(RandSwitch,Cleared),Switch(RandSwitch2,Cleared)},{SetV(TargetRotation,4)},{preserved})
							TriggerX(FP,{Switch(RandSwitch,Set),Switch(RandSwitch2,Cleared)},{SetV(TargetRotation,5)},{preserved})
							TriggerX(FP,{Switch(RandSwitch,Cleared),Switch(RandSwitch2,Set)},{SetV(TargetRotation,6)},{preserved})
							TriggerX(FP,{Switch(RandSwitch,Set),Switch(RandSwitch2,Set)},{SetV(TargetRotation,7)},{preserved})
							CIfEnd()
						end
						for j = 0, 3 do
						NJumpX(FP,L_Gun_Order,{CVar(FP,TargetRotation[2],Exactly,j+4),HumanCheck(j,0)}) -- 타겟 설정 시 플레이어가 없을 경우 다시 연산함
						end
						
						CIfX(FP,Never())
						for i = 0, 3 do
							CElseIfX({CVar(FP,TargetRotation[2],Exactly,i+4),HumanCheck(i,1)})
								Simple_SetLocX(FP,DefaultAttackLoc,G_CA_TempTable[8],G_CA_TempTable[9],G_CA_TempTable[8],G_CA_TempTable[9])
								CMov(FP,G_CA_TempTable[8],TargetArr[i+1][1])
								CMov(FP,G_CA_TempTable[9],TargetArr[i+1][2])
						end
						CElseX() -- TargetRotation이 0xFFFFFFFF일 경우 생성 중심점에 어택
						Simple_SetLocX(FP,DefaultAttackLoc,G_CA_TempTable[8],G_CA_TempTable[9],G_CA_TempTable[8],G_CA_TempTable[9])
						CIfXEnd()

					CElseX()--이론치모드일 경우 생성 중심점에 어택
						Simple_SetLocX(FP,DefaultAttackLoc,G_CA_TempTable[8],G_CA_TempTable[9],G_CA_TempTable[8],G_CA_TempTable[9])
					CIfXEnd()
				CIfXEnd()
			CElseX() -- 어택 일반 도형중심점
			Simple_SetLocX(FP,DefaultAttackLoc,G_CA_TempTable[8],G_CA_TempTable[9],G_CA_TempTable[8],G_CA_TempTable[9])

			CIfXEnd()
		end
		
		

		CIfX(FP,{CVar(FP,RepeatType[2],Exactly,100)},{})

		local EffType1 = G_CA_TempTable[15]
		local ScriptBak = CreateVar(FP)
		local Script2 = CreateVar(FP)
		CMov(FP,Script2,EffType1,EPDF(0x66EC48))
		CMov(FP,ScriptBak,_Read(Script2))
		CDoActions(FP,{TSetMemoryX(0x6663C4, SetTo, EffType1,0xFFFF),
		
			TSetMemory(Script2,SetTo,165),--131
			TCreateUnitWithProperties(1,116,DefaultAttackLoc+1,CreatePlayer,{energy = 100}),
			TSetMemory(Script2,SetTo,ScriptBak)
		})
		CElseX()
		for j = 4, 7 do
			CTrigger(FP,{CVar(FP,CreatePlayer[2],Exactly,j),TTCVar(FP,RepeatType[2],NotSame,2)},{TCreateUnitWithProperties(1,Gun_TempSpawnSet1,22+j-4,CreatePlayer,{energy = 100}),TMoveUnit(1,_Mov(Gun_TempSpawnSet1,0xFF),_Mov(CreatePlayer,0xFF),22+j-4,1)},1)
			CTrigger(FP,{CVar(FP,CreatePlayer[2],Exactly,j),CVar(FP,RepeatType[2],Exactly,2)},{TCreateUnitWithProperties(1,Gun_TempSpawnSet1,22+j-4,CreatePlayer,{energy = 100, burrowed = true}),TMoveUnit(1,_Mov(Gun_TempSpawnSet1,0xFF),_Mov(CreatePlayer,0xFF),22+j-4,1)},1) -- 버로우상태로 소환
		end
		f_Read(FP,_Add(G_CA_Nextptrs,10),CPos) -- 생성유닛 위치 불러오기
		Convert_CPosXY()
		CIfXEnd()
		CTrigger(FP,{CVar(FP,RepeatType[2],Exactly,3)},{TCreateUnitWithProperties(1,84,1,CreatePlayer,{energy = 100}),TKillUnit(84,CreatePlayer)},1)-- 어택없음+옵저버이펙트
		
		
		CIf(FP,{TMemoryX(_Add(G_CA_Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
		CDoActions(FP,{TSetMemoryX(_Add(G_CA_Nextptrs,35),SetTo,CreatePlayer,0xFF),})

		
		CTrigger(FP, {TMemoryX(_Add(G_CA_Nextptrs,25),Exactly,63,0xFF)},
		 {TSetMemoryX(_Add(G_CA_Nextptrs,40),SetTo,50*16777216,0xFF000000)}, 1)


			CIfX(FP,CVar(FP,RepeatType[2],Exactly,0)) -- 어택 일반
				Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
				CDoActions(FP,{
					Order("Men", Force2, 1, Attack, DefaultAttackLoc+1);
				})
			CElseIfX(CVar(FP,RepeatType[2],Exactly,1))-- 어택 해당플레이어 위치
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CDoActions(FP,{
				Order("Men", Force2, 1, Attack, DefaultAttackLoc+1);
			})
			CElseIfX(CVar(FP,RepeatType[2],Exactly,3))-- 어택없음+옵저버이펙트
			CElseIfX(CVar(FP,RepeatType[2],Exactly,4))-- 어택없음
			CElseIfX(CVar(FP,RepeatType[2],Exactly,5))-- 그냥 터지는 유닛
			CDoActions(FP,{
				TSetMemoryX(_Add(G_CA_Nextptrs,19),SetTo,0,0xFF00)
			})

			CElseIfX(CVar(FP,RepeatType[2],Exactly,6))-- 어택 해당플레이어 위치 + 패러사이트
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CDoActions(FP,{
				TSetDeathsX(_Add(G_CA_Nextptrs,72),SetTo,0xFF*256,0,0xFF00),
				Order("Men", Force2, 1, Attack, DefaultAttackLoc+1);
			})
			CElseIfX(CVar(FP,RepeatType[2],Exactly,100),{TSetMemoryX(_Add(G_CA_Nextptrs,9),SetTo,0*65536,0xFF0000),TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0xA00000,0xA00000)})-- 특수생성트리거
			local LPos= CreateVar(FP)
			CMov(FP,LPos,_Add(G_CA_X,_Mul(G_CA_Y,65536)))
			TriggerX(FP,{CVar(FP,LPos[2],AtLeast,32768,0xFFFF)},{SetCVar(FP, LPos[2], SetTo, 0, 0xFFFF)},{preserved})
			TriggerX(FP,{CVar(FP,LPos[2],AtLeast,4096,0xFFFF),CVar(FP,LPos[2],AtMost,32768,0xFFFF)},{SetCVar(FP, LPos[2], SetTo, 4095, 0xFFFF)},{preserved})
			TriggerX(FP,{CVar(FP,LPos[2],AtLeast,32768*0x10000,0xFFFF0000)},{SetCVar(FP, LPos[2], SetTo, 0, 0xFFFF0000)},{preserved})
			TriggerX(FP,{CVar(FP,LPos[2],AtLeast,4096*0x10000,0xFFFF0000),CVar(FP,LPos[2],AtMost,32768*0x10000,0xFFFF0000)},{SetCVar(FP, LPos[2], SetTo, 4095*0x10000, 0xFFFF0000)},{preserved})
			CDoActions(FP,{
				Set_EXCC2(DUnitCalc,G_CA_UnitIndex,7,SetTo,G_CA_TempTable[1]),
				Set_EXCC2(DUnitCalc,G_CA_UnitIndex,8,SetTo,G_CA_TempTable[11]),
				Set_EXCC2(DUnitCalc,G_CA_UnitIndex,9,SetTo,G_CA_TempTable[12]),
				Set_EXCC2(DUnitCalc,G_CA_UnitIndex,10,SetTo,G_CA_TempTable[13]),
				Set_EXCC2(DUnitCalc,G_CA_UnitIndex,11,SetTo,G_CA_TempTable[14]),
				Set_EXCC2(DUnitCalc,G_CA_UnitIndex,5,SetTo,G_CA_TempTable[8]),
				Set_EXCC2(DUnitCalc,G_CA_UnitIndex,6,SetTo,G_CA_TempTable[9]),
				Set_EXCC2(UnivCunit,G_CA_UnitIndex,0,SetTo,LPos)
			})
			
			--DisplayPrint(HumanPlayers, {G_CA_TempTable[1],"   ",G_CA_TempTable[11],"   ",G_CA_TempTable[12],"   ",G_CA_TempTable[13]})
			CIfX(FP,Never())
			for i = 0, 3 do
				CElseIfX({CVar(FP,CreatePlayer[2],Exactly,i+4),HumanCheck(i,1)})
			end
			CIfXEnd()
			CMov(FP,G_CA_TempTable[8],G_CA_BakX)
			CMov(FP,G_CA_TempTable[9],G_CA_BakY)

			CIf(FP,{CVar(FP,G_CA_TempTable[17][2],Exactly,1,1+0xF0000000)})
			CDoActions(FP,{Set_EXCC2X(DUnitCalc,G_CA_UnitIndex,12,SetTo,1,1),
			Set_EXCC2(DUnitCalc,G_CA_UnitIndex,5,SetTo,G_CA_TempTable[8]),
			Set_EXCC2(DUnitCalc,G_CA_UnitIndex,6,SetTo,G_CA_TempTable[9]),})

			CIfEnd()
			CIf(FP,{CVar(FP,G_CA_TempTable[17][2],Exactly,2,2+0xF0000000)})
				f_Lengthdir(FP,_Mod(_Rand(),256),_Mod(_Rand(),360),LDrX,LDrY)
				CAdd(FP,LPos,_Add(LDrX,_Mul(LDrY,65536)))
				TriggerX(FP,{CVar(FP,LPos[2],AtLeast,32768,0xFFFF)},{SetCVar(FP, LPos[2], SetTo, 0, 0xFFFF)},{preserved})
				TriggerX(FP,{CVar(FP,LPos[2],AtLeast,4096,0xFFFF),CVar(FP,LPos[2],AtMost,32768,0xFFFF)},{SetCVar(FP, LPos[2], SetTo, 4095, 0xFFFF)},{preserved})
				TriggerX(FP,{CVar(FP,LPos[2],AtLeast,32768*0x10000,0xFFFF0000)},{SetCVar(FP, LPos[2], SetTo, 0, 0xFFFF0000)},{preserved})
				TriggerX(FP,{CVar(FP,LPos[2],AtLeast,4096*0x10000,0xFFFF0000),CVar(FP,LPos[2],AtMost,32768*0x10000,0xFFFF0000)},{SetCVar(FP, LPos[2], SetTo, 4095*0x10000, 0xFFFF0000)},{preserved})
				CDoActions(FP,{Set_EXCC2(UnivCunit,G_CA_UnitIndex,0,SetTo,LPos),
				Set_EXCC2(DUnitCalc,G_CA_UnitIndex,5,SetTo,G_CA_TempTable[8]),
				Set_EXCC2(DUnitCalc,G_CA_UnitIndex,6,SetTo,G_CA_TempTable[9]),})
			CIfEnd()
			CTrigger(FP,{CVar(FP,G_CA_TempTable[17][2],Exactly,4,4+0xF0000000)},{Set_EXCC2X(DUnitCalc,G_CA_UnitIndex,12,SetTo,4,4)},1)
				
				
			CElseIfX(CVar(FP,RepeatType[2],Exactly,186))-- 정야독+충돌판정삭제
			f_Read(FP,_Add(G_CA_Nextptrs,10),CPos) -- 생성유닛 위치 불러오기
			Convert_CPosXY()
			CDoActions(FP,{
				TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0xA00000,0xA00000),
				TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
				TSetDeaths(_Add(G_CA_Nextptrs,23),SetTo,0,0),
				TSetDeaths(_Add(G_CA_Nextptrs,6),SetTo,CPos,0),
				TSetDeaths(_Add(G_CA_Nextptrs,22),SetTo,CPos,0),
				TSetDeaths(_Add(G_CA_Nextptrs,4),SetTo,CPos,0),
			})
			CElseIfX(CVar(FP,RepeatType[2],Exactly,187))-- 정야독
			f_Read(FP,_Add(G_CA_Nextptrs,10),CPos) -- 생성유닛 위치 불러오기
			Convert_CPosXY()
			CDoActions(FP,{
				TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
				TSetDeaths(_Add(G_CA_Nextptrs,23),SetTo,0,0),
				TSetDeaths(_Add(G_CA_Nextptrs,6),SetTo,CPos,0),
				TSetDeaths(_Add(G_CA_Nextptrs,22),SetTo,CPos,0),
				TSetDeaths(_Add(G_CA_Nextptrs,4),SetTo,CPos,0),
			})
			CElseIfX(CVar(FP,RepeatType[2],Exactly,188)) -- 유닛 랜덤 속도 설정 + 정야독
				TempSpeedVar = f_CRandNum(4000)
				CDoActions(FP,{
					TSetDeaths(_Add(G_CA_Nextptrs,13),SetTo,TempSpeedVar,0),
					TSetDeathsX(_Add(G_CA_Nextptrs,18),SetTo,TempSpeedVar,0,0xFFFF)})
				CDoActions(FP,{
					TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
				})
			CElseIfX(CVar(FP,RepeatType[2],Exactly,189)) -- 정야독 + 옵저버이펙트
			f_Read(FP,_Add(G_CA_Nextptrs,10),CPos) -- 생성유닛 위치 불러오기
			Convert_CPosXY()
			CDoActions(FP,{
				TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
				TSetDeaths(_Add(G_CA_Nextptrs,23),SetTo,0,0),
				TSetDeaths(_Add(G_CA_Nextptrs,6),SetTo,CPos,0),
				TSetDeaths(_Add(G_CA_Nextptrs,22),SetTo,CPos,0),
				TSetDeaths(_Add(G_CA_Nextptrs,4),SetTo,CPos,0),
				TCreateUnitWithProperties(1,84,1,CreatePlayer,{energy = 100})
			})
			CElseIfX(CVar(FP,RepeatType[2],Exactly,190)) -- 생성 일반어택 + 정야독이펙트
				f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
				Convert_CPosXY()
				Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
				CDoActions(FP,{
					Order("Men", Force2, 1, Attack, DefaultAttackLoc+1);
					TCreateUnitWithProperties(1,84,1,CreatePlayer,{energy = 100})
				})

			CElseIfX(CVar(FP,RepeatType[2],Exactly,72),{SetMemoryX(0x666458, SetTo, 391,0xFFFF)}) -- 건작보스전용 : 패러사이트 + P9 무적유닛 + 전플레이어 센터뷰
				CDoActions(FP,{
					TSetDeathsX(_Add(G_CA_Nextptrs,72),SetTo,0xFF*256,0,0xFF00),
					TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0x4000000,0x4000000),
					--TGiveUnits(1,_Mov(Gun_TempSpawnSet1,0xFF),_Mov(CreatePlayer,0xFF),1,P9),
					TCreateUnitWithProperties(1,33,1,CurrentOP,{energy = 100}),
					TKillUnit(33,CurrentOP);
					SetMemoryX(0x666458, SetTo, 546,0xFFFF),
					
				})
				--CMov(FP,0x57f0f0,CGPtr2)
				--CMov(FP,0x57f120,G_CA_Nextptrs)
				f_CGive(FP, G_CA_Nextptrs, nil, P9, CreatePlayer)
				DoActions2(FP,RotatePlayer({CenterView(1)},HumanPlayers,FP))
			CElseIfX(CVar(FP,RepeatType[2],Exactly,192)) -- 무적유닛으로 생성하기
			CDoActions(FP,{
				TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0x4000000,0x4000000),
			})
			
			CElseIfX(CVar(FP,RepeatType[2],Exactly,193))-- 정야독+충돌판정삭제, 최대체력 10퍼센트로 너프
			
			f_Read(FP,_Add(G_CA_Nextptrs,10),CPos) -- 생성유닛 위치 불러오기
			Convert_CPosXY()
			CDoActions(FP,{
				TSetMemory(_Add(G_CA_Nextptrs,2),SetTo,_Div(_Read(_Add(Gun_TempSpawnSet1,EPDF(0x662350))),10));
				TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0xA00000,0xA00000),
				TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
				TSetDeaths(_Add(G_CA_Nextptrs,23),SetTo,0,0),
				TSetDeaths(_Add(G_CA_Nextptrs,6),SetTo,CPos,0),
				TSetDeaths(_Add(G_CA_Nextptrs,22),SetTo,CPos,0),
				TSetDeaths(_Add(G_CA_Nextptrs,4),SetTo,CPos,0),
			})
			CTrigger(FP,{TMemory(_Add(G_CA_Nextptrs,2),AtMost,255)},{TSetMemory(_Add(G_CA_Nextptrs,2),SetTo,256)},1)


			CElseIfX(CVar(FP,RepeatType[2],Exactly,194))-- 웨이브 어택
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CDoActions(FP,{
				Order("Men", Force2, 1, Attack, DefaultAttackLoc+1);
				Set_EXCC2(DUnitCalc,G_CA_UnitIndex,1,SetTo,0);
			})

			CElseIfX(CVar(FP,RepeatType[2],Exactly,195))-- 어택 일반 충돌판정삭제
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CDoActions(FP,{
				Order("Men", Force2, 1, Attack, DefaultAttackLoc+1);
				TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0xA00000,0xA00000),
			})
			CElseIfX(CVar(FP,RepeatType[2],Exactly,196))-- testify 전용 정야독+충돌판정삭제, 이속1
			f_Read(FP,_Add(G_CA_Nextptrs,10),CPos) -- 생성유닛 위치 불러오기
			Convert_CPosXY()
			CDoActions(FP,{
				TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0xA00000,0xA00000),
				TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
				TSetDeaths(_Add(G_CA_Nextptrs,23),SetTo,0,0),
				TSetDeaths(_Add(G_CA_Nextptrs,6),SetTo,CPos,0),
				TSetDeaths(_Add(G_CA_Nextptrs,22),SetTo,CPos,0),
				TSetDeaths(_Add(G_CA_Nextptrs,4),SetTo,CPos,0),
				TSetMemory(_Add(G_CA_Nextptrs,13),SetTo,1),
				TSetMemoryX(_Add(G_CA_Nextptrs,18),SetTo,1,0xFFFF),
			})
			CElseIfX(CVar(FP,RepeatType[2],Exactly,197))-- testify 전용 비행체 이동속도 중앙비례 일정하게, 공격지점은 중앙
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			local TPosX, TPosY,SpeedRet = CreateVars(3,FP)
			DoActions(FP, Order("Men", Force2, 1, Attack, DefaultAttackLoc+1))
			CiSub(FP,TPosX,CPosX,G_CA_TempTable[8])
			CiSub(FP,TPosY,CPosY,G_CA_TempTable[9])
			f_Sqrt(FP, SpeedRet, _Div(_Add(_Square(TPosX),_Square(TPosY)),_Mov(5)))
			CDoActions(FP,{
				TSetMemoryX(_Add(G_CA_Nextptrs,8),SetTo,127*65536,0xFF0000),
				TSetMemory(_Add(G_CA_Nextptrs,13),SetTo,SpeedRet),
				TSetMemoryX(_Add(G_CA_Nextptrs,18),SetTo,SpeedRet,0xFFFF),
			})
			CElseIfX(CVar(FP,RepeatType[2],Exactly,198))-- testify 전용 비행체 이동속도 중앙비례 일정하게, P9 대기상태
			local TPosX, TPosY,SpeedRet = CreateVars(3,FP)
			CiSub(FP,TPosX,CPosX,G_CA_TempTable[8])
			CiSub(FP,TPosY,CPosY,G_CA_TempTable[9])
			f_Sqrt(FP, SpeedRet, _Div(_Add(_Square(TPosX),_Square(TPosY)),_Mov(5)))
			f_CGive(FP, G_CA_Nextptrs, nil, P9, CreatePlayer)
			CDoActions(FP,{
				TSetDeathsX(_Add(G_CA_Nextptrs,72),SetTo,0xFF*256,0,0xFF00),
				TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0x4000000,0x4000000),
				TSetMemoryX(_Add(G_CA_Nextptrs,8),SetTo,127*65536,0xFF0000),
				TSetMemory(_Add(G_CA_Nextptrs,13),SetTo,SpeedRet),
				TSetMemoryX(_Add(G_CA_Nextptrs,18),SetTo,SpeedRet,0xFFFF),
			})
			CElseIfX(CVar(FP,RepeatType[2],Exactly,2)) -- 버로우 생성(위에서 이미 생성해놨으므로 예외처리만 함)
			CElseX() -- RepeatType이 잘못 설정되었을경우 에러메세지 표출
				DoActions2X(FP,RotatePlayer({DisplayTextX(f_RepeatTypeErr,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP))
			CIfXEnd()
		CIfEnd()
	CIfXEnd()

	CSub(FP,Spawn_TempW,1)
CWhileEnd()
CMov(FP,RepeatType,0)
SetCallEnd()

function f_TempRepeat(Condition,UnitID,Number,Type,Owner,CenterXY,PreserveFlag)
	if Owner == nil then Owner = 0xFFFFFFFF end
	if Type == nil then Type = 0 end
	local SetX = 0 
	local SetY = 0
	if CenterXY == nil then 
		SetX = 0xFFFFFFFF
		SetY = 0xFFFFFFFF
	elseif type(CenterXY) == "table" then
		SetX = CenterXY[1]
		SetY = CenterXY[2]
	else
		PushErrorMsg("TRepeat_CenterXY_Error")
	end
	

	CallTriggerX(FP,Set_Repeat,Condition,{
		SetCDeaths(FP,SetTo,0,CA_Repeat_Check),
		SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,UnitID),
		SetCVar(FP,Repeat_TempV[2],SetTo,Number),
		SetCVar(FP,RepeatType[2],SetTo,Type),
		SetCVar(FP,CreatePlayer[2],SetTo,Owner),
		SetCVar(FP,TRepeatX[2],SetTo,SetX),
		SetCVar(FP,TRepeatY[2],SetTo,SetY),
	},PreserveFlag)
end

function f_TempRepeatX(Condition,UnitID,Number,Type,Owner,CenterXY)
	if Owner == nil then Owner = 0xFFFFFFFF end
	if Type == nil then Type = 0 end
	local SetX = 0 
	local SetY = 0
	if CenterXY == nil then 
		SetX = 0xFFFFFFFF
		SetY = 0xFFFFFFFF
	elseif type(CenterXY) == "table" then
		SetX = CenterXY[1]
		SetY = CenterXY[2]
	else
		PushErrorMsg("TRepeat_CenterXY_Error")
	end
	CDoActions(FP,{
		TSetCVar(FP,Gun_TempSpawnSet1[2],SetTo,UnitID),
		TSetCVar(FP,Repeat_TempV[2],SetTo,Number),
		TSetCVar(FP,TRepeatX[2],SetTo,SetX),
		TSetCVar(FP,TRepeatY[2],SetTo,SetY),
		TSetCVar(FP,CreatePlayer[2],SetTo,Owner),
		SetCVar(FP,RepeatType[2],SetTo,Type),
		SetCDeaths(FP,SetTo,0,CA_Repeat_Check),})
	CallTriggerX(FP,Set_Repeat,Condition)
end

TempRepeat2X_CUTV = {
	Gun_TempSpawnSet1,
	Gun_TempSpawnSet2,
	Gun_TempSpawnSet3,
	Gun_TempSpawnSet4,
	Gun_TempSpawnSet5,
}

function f_TempRepeat2X(Condition,G_CA_CUTable,Number,EffType,Owner,CenterXY,Flags)
	if type(G_CA_CUTable)=="number"then G_CA_CUTable={G_CA_CUTable} end
	
local Z = {}
local CUTable = {}
local CUTable2 = G_CA_CUTable
--if RedMode == 1 then
--	CUTable2 = {}
--	local CUTi=0
--	while #CUTable2~=20 do
--		if #CUTable2>=20 then break end
--
--		for j,k in pairs(G_CA_CUTable) do
--			if #CUTable2>=20 then break end
--			table.insert(CUTable2,k)
--		end
--		CUTi=CUTi+1
--		if CUTi==2 then break end
--
--	end
--	
--else
--	CUTable2 = G_CA_CUTable
--end


if type(CUTable2) ~= "table" then
	PushErrorMsg("G_CA_SetSpawn_Inputdata_Error")
else
	if #CUTable2 <= 4 then
		Z = {SetCVar(FP,TempRepeat2X_CUTV[1][2],SetTo,T_to_BiteBuffer(CUTable2))}

	elseif #CUTable2 >= 5 and #CUTable2 <= 20 then
		local TempT = {}
		
		for j, k in pairs(CUTable2) do
			if #TempT > 3 then table.insert(CUTable,TempT) TempT = {} end
			table.insert(TempT,k)
		end
		if #TempT > 0 then table.insert(CUTable,TempT) TempT = {} end

		for j, k in pairs(CUTable) do
			table.insert(Z,SetCVar(FP,TempRepeat2X_CUTV[j][2],SetTo,T_to_BiteBuffer(k)))
		end
		
	else 
		PushErrorMsg("G_CA_CUTable_Size_OverFlow")
	end
end



	if Owner == nil then Owner = 0xFFFFFFFF
	elseif Owner == "CP" then Owner = 0x7FFFFFFF end
	if Type == nil then Type = 0 end
	local SetXY = {}
	if CenterXY == nil then 
		SetXY = {
		SetCVar(FP,TRepeatX[2],SetTo,0xFFFFFFFF),
		SetCVar(FP,TRepeatY[2],SetTo,0xFFFFFFFF),
		}
	elseif type(CenterXY) == "table" then
		SetXY = {
		SetCVar(FP,TRepeatX[2],SetTo,CenterXY[1]),
		SetCVar(FP,TRepeatY[2],SetTo,CenterXY[2]),
		}
	elseif CenterXY ~= "X" then 
		PushErrorMsg("TRepeat_CenterXY_Error")
	end
	CDoActions(FP,{Z,
		TSetCVar(FP,Repeat_TempV[2],SetTo,Number),
		SetXY,
		SetCVar(FP,RepeatType[2],SetTo,100),
		SetCDeaths(FP,SetTo,0,CA_Repeat_Check),
		SetCVar(FP,G_CA_TempTable[15][2],SetTo,EffType),
		SetCVar(FP,G_CA_TempTable[17][2],SetTo,Flags),
		SetCVar(FP,CreatePlayer[2],SetTo,Owner)})
	CallTriggerX(FP,Set_Repeat,Condition)
end



Set_Repeat = SetCallForward()
SetCall(FP)
Trigger2X(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,0)},{RotatePlayer({DisplayTextX(f_RepeatErr2,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP),SetCVar(FP,Repeat_TempV[2],SetTo,0)},{preserved})
TriggerX(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,256)},{SetCVar(FP,Repeat_TempV[2],SetTo,0)},{preserved})
CIf(FP,CVar(FP,Repeat_TempV[2],AtLeast,1))
	CMov(FP,Spawn_TempW,Repeat_TempV)
	CMov(FP,Repeat_TempV,0)
	CallTrigger(FP,Call_Repeat)
	CMov(FP,Spawn_TempW,0)
CIfEnd()
SetCallEnd()




for i = 1, G_CA_Lines do
	table.insert(G_CA_InputCVar,SetCVar(FP,G_CA_TempTable[i][2],SetTo,0))
end
table.insert(CtrigInitArr[8],SetCtrigX(FP,G_CA_InputH[2],0x15C,0,SetTo,FP,StartIndex,0x15C,1,0))

Write_SpawnSet = SetCallForward()
SetCall(FP)


for i = 221, 224 do
	CTrigger(FP,{CVar(FP,G_CA_CUTV[1][2],Exactly,i,0xFF)},{TSetCVar(FP,G_CA_CUTV[1][2],SetTo,PatchCondArr[i-220],0xFF)},1)
	CIf(FP,{CVar(FP,G_CA_CUTV[1][2],Exactly,i*0x100,0xFF00)})
		CTrigger(FP,{},{TSetCVar(FP,G_CA_CUTV[1][2],SetTo,_Mul(PatchCondArr[i-220],_Mov(0x100)),0xFF00)},1)
	CIfEnd()
	CIf(FP,{CVar(FP,G_CA_CUTV[1][2],Exactly,i*0x10000,0xFF0000)})
		CTrigger(FP,{},{TSetCVar(FP,G_CA_CUTV[1][2],SetTo,_Mul(PatchCondArr[i-220],_Mov(0x10000)),0xFF0000)},1)
	CIfEnd()
	CIf(FP,{CVar(FP,G_CA_CUTV[1][2],Exactly,i*0x1000000,0xFF000000)})
		CTrigger(FP,{},{TSetCVar(FP,G_CA_CUTV[1][2],SetTo,_Mul(PatchCondArr[i-220],_Mov(0x1000000)),0xFF000000)},1)
	CIfEnd()
end
CMov(FP,G_CA_LineV,0)
CJumpEnd(FP,Write_SpawnSet_Jump)

CAdd(FP,G_CA_LineTemp,G_CA_LineV,G_CA_InputH)
NIfX(FP,{TMemory(G_CA_LineTemp,AtMost,0)})
CTrigger(FP,{CVar(FP,G_CA_Owner[2],Exactly,0x7FFFFFFF)},{SetCVar(FP,G_CA_Owner[2],SetTo,0),TSetCVar(FP,G_CA_Owner[2],SetTo,G_CA_Player,0xFF)},1)
CTrigger(FP,{CVar(FP,G_CA_Owner[2],Exactly,0x8FFFFFFF)},{SetCVar(FP,G_CA_Owner[2],SetTo,0),TSetCVar(FP,G_CA_Owner[2],SetTo,CurrentOP,0xFF)},1)

CDoActions(FP,{
	TSetMemory(_Add(G_CA_LineTemp,0*(0x20/4)),SetTo,G_CA_CUTV[1]),
	--TSetMemory(_Add(G_CA_LineTemp,1*(0x20/4)),SetTo,SL_Ret), -- unused
	TSetMemory(_Add(G_CA_LineTemp,2*(0x20/4)),SetTo,0),
	TSetMemory(_Add(G_CA_LineTemp,3*(0x20/4)),SetTo,G_CA_SNTV),
	TSetMemory(_Add(G_CA_LineTemp,4*(0x20/4)),SetTo,G_CA_LMTV),
	TSetMemory(_Add(G_CA_LineTemp,5*(0x20/4)),SetTo,G_CA_RPTV),
	--TSetMemory(_Add(G_CA_LineTemp,6*(0x20/4)),SetTo,G_CA_CTTV), -- unused
	TSetMemory(_Add(G_CA_LineTemp,9*(0x20/4)),SetTo,G_CA_Owner),
	TSetMemory(_Add(G_CA_LineTemp,10*(0x20/4)),SetTo,G_CA_CUTV[2]),
	TSetMemory(_Add(G_CA_LineTemp,11*(0x20/4)),SetTo,G_CA_CUTV[3]),
	TSetMemory(_Add(G_CA_LineTemp,12*(0x20/4)),SetTo,G_CA_CUTV[4]),
	TSetMemory(_Add(G_CA_LineTemp,13*(0x20/4)),SetTo,G_CA_CUTV[5]),
	TSetMemory(_Add(G_CA_LineTemp,14*(0x20/4)),SetTo,G_CA_EffType),
	TSetMemory(_Add(G_CA_LineTemp,15*(0x20/4)),SetTo,G_CA_MaxNum),
	TSetMemory(_Add(G_CA_LineTemp,16*(0x20/4)),SetTo,G_CA_FuncNum),
	TSetMemory(_Add(G_CA_LineTemp,18*(0x20/4)),SetTo,G_CB_SNTV[1]),
	TSetMemory(_Add(G_CA_LineTemp,19*(0x20/4)),SetTo,G_CB_SNTV[2]),
	TSetMemory(_Add(G_CA_LineTemp,20*(0x20/4)),SetTo,G_CB_SNTV[3]),
	TSetMemory(_Add(G_CA_LineTemp,21*(0x20/4)),SetTo,G_CB_SNTV[4]),
})


















CIfX(FP,{CVar(FP,G_CA_XPos[2],Exactly,0xFFFFFFFF),CVar(FP,G_CA_YPos[2],Exactly,0xFFFFFFFF)})
CDoActions(FP,{
	TSetMemory(_Add(G_CA_LineTemp,7*(0x20/4)),SetTo,G_CA_CenterX),
	TSetMemory(_Add(G_CA_LineTemp,8*(0x20/4)),SetTo,G_CA_CenterY)
})

if Limit == 1 then
	CIf(FP,CD(TestMode,1))
	--TriggerX(FP,{CD(TestMode,1)},{RotatePlayer({DisplayTextX(f_GunFuncT2,4)},HumanPlayers,FP)},{preserved})
	--ItoDec(FP,G_CA_CUTV[1],VArr(G_CA_WSTestVA,0),0,nil,0)
	--f_Movcpy(FP,G_CA_WSTestStrPtr,VArr(G_CA_WSTestVA,0),4*4)
	--TriggerX(FP,{CD(TestMode,1)},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CA_WS".._0D,4)},HumanPlayers,FP)},{preserved})
--	ItoDec(FP,G_CA_CUTV[2],VArr(G_CA_WSTestVA,0),0,nil,0)
--	f_Movcpy(FP,G_CA_WSTestStrPtr,VArr(G_CA_WSTestVA,0),4*4)
--	TriggerX(FP,{CD(TestMode,1)},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CA_WS".._0D,4)},HumanPlayers,FP)},{preserved})
--	ItoDec(FP,G_CA_CUTV[3],VArr(G_CA_WSTestVA,0),0,nil,0)
--	f_Movcpy(FP,G_CA_WSTestStrPtr,VArr(G_CA_WSTestVA,0),4*4)
--	TriggerX(FP,{CD(TestMode,1)},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CA_WS".._0D,4)},HumanPlayers,FP)},{preserved})
--	ItoDec(FP,G_CA_CUTV[4],VArr(G_CA_WSTestVA,0),0,nil,0)
--	f_Movcpy(FP,G_CA_WSTestStrPtr,VArr(G_CA_WSTestVA,0),4*4)
--	TriggerX(FP,{CD(TestMode,1)},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CA_WS".._0D,4)},HumanPlayers,FP)},{preserved})
--	ItoDec(FP,G_CA_CUTV[5],VArr(G_CA_WSTestVA,0),0,nil,0)
--	f_Movcpy(FP,G_CA_WSTestStrPtr,VArr(G_CA_WSTestVA,0),4*4)
--	TriggerX(FP,{CD(TestMode,1)},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CA_WS".._0D,4)},HumanPlayers,FP)},{preserved})
	CIfEnd()

end
CElseX()
CDoActions(FP,{
	TSetMemory(_Add(G_CA_LineTemp,7*(0x20/4)),SetTo,G_CA_XPos),
	TSetMemory(_Add(G_CA_LineTemp,8*(0x20/4)),SetTo,G_CA_YPos)
})
CIfXEnd()
NElseIfX({CVar(FP,G_CA_LineV[2],AtMost,((0x970/4)*Size_of_G_CA_Arr-2))})
CAdd(FP,G_CA_LineV,0x970/4)
CJump(FP,Write_SpawnSet_Jump)
NElseX()

DoActions2X(FP,{RotatePlayer({DisplayTextX(f_GunSendErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})

NIfXEnd()

DoActionsX(FP,{
	SetV(G_CA_SNTV,0),
	SetV(G_CA_LMTV,0),
	SetV(G_CA_RPTV,0),
	SetV(G_CA_Owner,0),
	SetV(G_CA_CUTV[1],0),
	SetV(G_CA_CUTV[2],0),
	SetV(G_CA_CUTV[3],0),
	SetV(G_CA_CUTV[4],0),
	SetV(G_CA_CUTV[5],0),
	SetV(G_CA_EffType,0),
	SetV(G_CA_MaxNum,0),
	SetV(G_CA_FuncNum,0),
	SetV(G_CB_SNTV[1],0),
	SetV(G_CB_SNTV[2],0),
	SetV(G_CB_SNTV[3],0),
	SetV(G_CB_SNTV[4],0),
})


SetCallEnd()










local CA_TempUID = CreateVar(FP)
local CA_Suspend = CreateCcode()

Call_CA_Repeat = SetCallForward()
SetCall(FP)
TriggerX(FP,{CVar(FP,CA_TempUID[2],AtLeast,221)},{SetCVar(FP,CA_TempUID[2],SetTo,0)},{preserved})
CMov(FP,Gun_TempSpawnSet1,CA_TempUID)
CMov(FP,Repeat_TempV,1)
CMov(FP,RepeatType,G_CA_TempTable[6],nil,0xFF)
CMov(FP,CreatePlayer,G_CA_TempTable[10])
CallTrigger(FP,Set_Repeat,{SetCDeaths(FP,SetTo,1,CA_Repeat_Check)})
SetCallEnd()

local G_CA_Launch = CreateCcode()
function CA_Func()
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	CIfX(FP,{CVar(FP,G_CA_TempTable[17][2],Exactly,0x10000000,0xF0000000)})
	CA_Rotate(_Mov(G_CA_TempTable[17],0xFFFF))
	CIfXEnd()
	CIfX(FP,{CVar(FP,G_CA_TempTable[17][2],Exactly,0x20000000,0xF0000000)})
	CMov(FP,V(CA[3]),G_CA_TempTable[17],nil,0xFFFF)
	CElseX()
	CMov(FP,V(CA[3]),0)
	CIfXEnd()

	CIfX(FP,{CVar(FP,G_CA_TempTable[17][2],Exactly,0x30000000,0xF0000000)})
		CA_Rotate3D(CA_Eff_XY,CA_Eff_YZ,CA_Eff_ZX)
	CIfXEnd()
	CIfX(FP,{CVar(FP,G_CA_TempTable[17][2],Exactly,0x60000000,0xF0000000)})
		CA_Rotate3D(CA_Eff_XY2,CA_Eff_YZ2,CA_Eff_ZX2)
	CIfXEnd()
	CIfX(FP,{CVar(FP,G_CA_TempTable[17][2],Exactly,0x40000000,0xF0000000)})
		CA_RatioXY(_Mov(G_CA_TempTable[17],0xFFFF), 256, _Mov(G_CA_TempTable[17],0xFFFF), 256)
	CIfXEnd()
	CAdd(FP,G_CA_X,V(CA[8]),G_CA_TempTable[8])
	CAdd(FP,G_CA_Y,V(CA[9]),G_CA_TempTable[9])
	CMov(FP,0x58DC60,G_CA_X)
	CMov(FP,0x58DC64,G_CA_Y)
	CMov(FP,0x58DC68,G_CA_X)
	CMov(FP,0x58DC6C,G_CA_Y)
	CIf(FP,{CVar(FP,G_CA_TempTable[16][2],AtLeast,1)})
		CIf(FP,{TTCVar(FP,G_CA_TempTable[16][2],"<",V(CA[10]))})
			CMov(FP,V(CA[10]),G_CA_TempTable[16])
		CIfEnd()
	CIfEnd()
	CIfX(FP,{CVar(FP,G_CA_TempTable[17][2],Exactly,0x50000000,0xF0000000)})
	CallTriggerX(FP,Call_CA_Repeat,{CV(G_CA_X,4095,AtMost),CV(G_CA_Y,4095,AtMost)})
	CElseX()
	TriggerX(FP,{CV(G_CA_X,0x80000000,AtLeast)},{SetV(G_CA_X,0)},{preserved})
	TriggerX(FP,{CV(G_CA_Y,0x80000000,AtLeast)},{SetV(G_CA_Y,0)},{preserved})
	TriggerX(FP,{CV(G_CA_X,4096,AtLeast),CV(G_CA_X,0x7FFFFFFF,AtMost)},{SetV(G_CA_X,4095)},{preserved})
	TriggerX(FP,{CV(G_CA_Y,4096,AtLeast),CV(G_CA_Y,0x7FFFFFFF,AtMost)},{SetV(G_CA_Y,4095)},{preserved})

	CMov(FP,0x58DC60,G_CA_X)
	CMov(FP,0x58DC64,G_CA_Y)
	CMov(FP,0x58DC68,G_CA_X)
	CMov(FP,0x58DC6C,G_CA_Y)

	CallTrigger(FP,Call_CA_Repeat,{})
	CIfXEnd()
	
end
local G_CA_CallStack = {}
local G_CA_IndexAlloc = 1
G_CA2_ShapeTable = {}
function G_CAPlot2(ShapeTable)
	if type(ShapeTable) ~= "table" then
		PushErrorMsg("ShapeData_Input_Error")
	end
	local Y = {}
	for j, k in pairs(ShapeTable) do
		if type(k) ~= "string" then
			PushErrorMsg("ShapeData_Input_Error")
		end
		table.insert(Y,_G[k])
		table.insert(G_CA2_ShapeTable,k)
	end


	local G_CA_CallIndex = SetCallForward()
	Another_CAPlot_Shape = G_CA_IndexAlloc
	local CA = CAPlotForward()
	local X = {}
	SetCall(FP)
	DoActionsX(FP,{SetCDeaths(FP,SetTo,1,G_CA_Launch)})
	CMov(FP,CA_TempUID,G_CA_TempTable[1],nil,0xFF)
	CMov(FP,V(CA[1]),G_CA_TempTable[19])
	CMov(FP,V(CA[2]),G_CA_TempTable[18])
	CMov(FP,V(CA[6]),G_CA_TempTable[3])
	CIfX(FP,CVar(FP,G_CA_TempTable[5][2],AtMost,0,0xFF))
		for j, k in pairs(Y) do
			CTrigger(FP,{CVar(FP,G_CA_TempTable[19][2],Exactly,j,0xFF)},{SetCVar(FP,CA[5],SetTo,(k[1]/50)+1)},1)
		end
	CElseX()
		CMov(FP,V(CA[5]),G_CA_TempTable[5],nil,0xFF)
	CIfXEnd()
	CBPlot(Y,nil,FP,nilunit,0,{G_CA_TempTable[8],G_CA_TempTable[9]},1,32,{0,0,0,0,0,1},"CA_Func",nil,FP,nil,nil,{SetCDeaths(FP,Add,1,CA_Suspend)}) 
--	CAPlot2(Y,FP,nilunit,0,{G_CA_TempTable[8],G_CA_TempTable[9]},1,32,{0,0,0,0,0,1},"CA_Func",FP,nil,nil,{SetCDeaths(FP,Add,1,CA_Suspend)},"CA_Repeat")
	CDoActions(FP,{TSetCVar(FP,G_CA_TempTable[3][2],SetTo,V(CA[6])),TSetCVar(FP,G_CA_TempTable[18][2],SetTo,V(CA[2]))})
	SetCallEnd()
	G_CA_IndexAlloc = G_CA_IndexAlloc + 1
	table.insert(G_CA_CallStack,G_CA_CallIndex)
end


function T_to_BiteBuffer(Table)
	local BiteValue = 0
	if type(Table) == "table" then
		local ret = 0
		if #Table >= 5 then
			PushErrorMsg("BiteStack_is_Over_5")
		end
		for i, j in pairs(Table) do
			if type(j) == "string" and j =="ACAS" then
				BiteValue = BiteValue + Another_CAPlot_Shape*(256^ret)
			else
			BiteValue = BiteValue + j*(256^ret)
			end
			ret = ret + 1
		end
		Table = BiteValue
	end
	return BiteValue
end

function G_CA_SetSpawn(Condition,G_CA_CUTable,G_CA_SNTable,G_CA_SLTable,G_CA_LMTable,G_CA_RepeatType,CenterXY,Owner,FuncNum,MaxNum,PreserveFlag)
	if type(G_CA_CUTable) ~= "table" then
		PushErrorMsg("G_CA_SetSpawn_Inputdata_Error")
	end
	if type(G_CA_SNTable) ~= "table" then
		G_CA_SNTable = {G_CA_SNTable,G_CA_SNTable,G_CA_SNTable,G_CA_SNTable}
	elseif G_CA_SNTable == nil then 
		PushErrorMsg("G_CA_SetSpawn_Inputdata_Error")
		
	end
	if type(G_CA_SLTable) ~= "table" then
		G_CA_SLTable = {G_CA_SLTable,G_CA_SLTable,G_CA_SLTable,G_CA_SLTable}
	elseif G_CA_SLTable == nil then
		PushErrorMsg("G_CA_SetSpawn_Inputdata_Error")
	end
	if type(G_CA_RepeatType) ~= "table" then
		G_CA_RepeatType = {G_CA_RepeatType,G_CA_RepeatType,G_CA_RepeatType,G_CA_RepeatType}
	end
	local X = {}
	if type(G_CA_SLTable) == "table" then
		if #G_CA_SLTable >= 5 then
			PushErrorMsg("BiteStack_is_Over_5")
		end
		for i = 1, 4 do
			if G_CA_SLTable[i] ~= nil then
				if type(G_CA_SLTable[i]) == "string" then
					local G_CB_ShapeTable_Check = ""
					for j, k in pairs(G_CA2_ShapeTable) do
						if G_CA_SLTable[i] == k then
							table.insert(X,SetCVar(FP,G_CB_SNTV[i][2],SetTo,j))
							G_CB_ShapeTable_Check = "OK"
						end
					end
					if G_CB_ShapeTable_Check ~= "OK" then
						PushErrorMsg("G_CA_SetSpawn_String_Shape_NotFound")
					end
				else
					PushErrorMsg("G_CB_SNTable_InputData_Error")
				end
			else
				table.insert(X,SetCVar(FP,G_CB_SNTV[i][2],SetTo,0))
			end
		end
	elseif type(G_CA_SLTable) == "string" then
		local G_CB_ShapeTable_Check = ""
		for j, k in pairs(G_CA2_ShapeTable) do
			if G_CA_SLTable == k then
				table.insert(X,SetCVar(FP,G_CB_SNTV[1][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[2][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[3][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[4][2],SetTo,j))
				G_CB_ShapeTable_Check = "OK"
			end
		end
		if G_CB_ShapeTable_Check ~= "OK" then
			PushErrorMsg("G_CA_SetSpawn_String_Shape_NotFound")
		end
	else
		PushErrorMsg("G_CB_SNTable_InputData_Error")
	end


	local LMRet = 0
	if G_CA_LMTable == "MAX" then
		LMRet = T_to_BiteBuffer({255,255,255,255})
	elseif type(G_CA_LMTable) == "table" then
		LMRet = T_to_BiteBuffer(G_CA_LMTable)
	elseif type(G_CA_LMTable) == "number" then
		local NumRet = G_CA_LMTable
		LMRet = T_to_BiteBuffer({NumRet,NumRet,NumRet,NumRet})
	end
	local Y = {}
	if CenterXY == nil then 
		table.insert(Y,SetCVar(FP,G_CA_XPos[2],SetTo,0xFFFFFFFF))
		table.insert(Y,SetCVar(FP,G_CA_YPos[2],SetTo,0xFFFFFFFF))
	elseif type(CenterXY) == "table" then
		table.insert(Y,SetCVar(FP,G_CA_XPos[2],SetTo,CenterXY[1]))
		table.insert(Y,SetCVar(FP,G_CA_YPos[2],SetTo,CenterXY[2]))
	else
		PushErrorMsg("G_CA_SetSpawn_CenterXY_Inputdata_Error")
	end
	if FuncNum == nil then FuncNum = 0 end
	if Owner == nil then Owner = 0xFFFFFFFF
	elseif Owner == "CP" then Owner = 0x7FFFFFFF
	elseif Owner == "OP" then Owner = 0x8FFFFFFF end
	if MaxNum == nil then MaxNum = 0 end
	CallTriggerX(FP,Write_SpawnSet,Condition,{
		SetCVar(FP,G_CA_CUTV[1][2],SetTo,T_to_BiteBuffer(G_CA_CUTable)),
		SetCVar(FP,G_CA_CUTV[2][2],SetTo,0),
		SetCVar(FP,G_CA_CUTV[3][2],SetTo,0),
		SetCVar(FP,G_CA_CUTV[4][2],SetTo,0),
		SetCVar(FP,G_CA_CUTV[5][2],SetTo,0),
		X,
		SetCVar(FP,G_CA_SNTV[2],SetTo,T_to_BiteBuffer(G_CA_SNTable)),
		SetCVar(FP,G_CA_LMTV[2],SetTo,LMRet),
		SetCVar(FP,G_CA_RPTV[2],SetTo,T_to_BiteBuffer(G_CA_RepeatType)),Y,
		SetCVar(FP,G_CA_Owner[2],SetTo,Owner),
		SetCVar(FP,G_CA_FuncNum[2],SetTo,FuncNum),
		SetCVar(FP,G_CA_MaxNum[2],SetTo,MaxNum),
		SetCVar(FP,G_CA_EffType[2],SetTo,0),
		
	},PreserveFlag)
end

function G_CA_Bullet(Condition,UnitID,G_CA_SNTable,G_CA_SLTable,G_CA_LMTable,G_CA_BulletType,CenterXY,TargetXY,Angle,FuncNum,MaxNum,PreserveFlag)
	if type(G_CA_SNTable) ~= "table" then
		G_CA_SNTable = {G_CA_SNTable,G_CA_SNTable,G_CA_SNTable,G_CA_SNTable}
	elseif G_CA_SNTable == nil then 
		PushErrorMsg("G_CA_SetSpawn_Inputdata_Error")
	end
	if type(G_CA_SLTable) ~= "table" then
		G_CA_SLTable = {G_CA_SLTable,G_CA_SLTable,G_CA_SLTable,G_CA_SLTable}
	elseif G_CA_SLTable == nil then
		PushErrorMsg("G_CA_SetSpawn_Inputdata_Error")
	end
	
	local X = {}
	if type(G_CA_SLTable) == "table" then
		if #G_CA_SLTable >= 5 then
			PushErrorMsg("BiteStack_is_Over_5")
		end
		for i = 1, 4 do
			if G_CA_SLTable[i] ~= nil then
				if type(G_CA_SLTable[i]) == "string" then
					local G_CB_ShapeTable_Check = ""
					for j, k in pairs(G_CA2_ShapeTable) do
						if G_CA_SLTable[i] == k then
							table.insert(X,SetCVar(FP,G_CB_SNTV[i][2],SetTo,j))
							G_CB_ShapeTable_Check = "OK"
						end
					end
					if G_CB_ShapeTable_Check ~= "OK" then
						PushErrorMsg("G_CA_SetSpawn_String_Shape_NotFound")
					end
				else
					PushErrorMsg("G_CB_SNTable_InputData_Error")
				end
			else
				table.insert(X,SetCVar(FP,G_CB_SNTV[i][2],SetTo,0))
			end
		end
	elseif type(G_CA_SLTable) == "string" then
		local G_CB_ShapeTable_Check = ""
		for j, k in pairs(G_CA2_ShapeTable) do
			if G_CA_SLTable == k then
				table.insert(X,SetCVar(FP,G_CB_SNTV[1][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[2][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[3][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[4][2],SetTo,j))
				G_CB_ShapeTable_Check = "OK"
			end
		end
		if G_CB_ShapeTable_Check ~= "OK" then
			PushErrorMsg("G_CA_SetSpawn_String_Shape_NotFound")
		end
	else
		PushErrorMsg("G_CB_SNTable_InputData_Error")
	end
	local LMRet = 0
	if G_CA_LMTable == "MAX" then
		LMRet = T_to_BiteBuffer({255,255,255,255})
	elseif type(G_CA_LMTable) == "table" then
		LMRet = T_to_BiteBuffer(G_CA_LMTable)
	elseif type(G_CA_LMTable) == "number" then
		local NumRet = G_CA_LMTable
		LMRet = T_to_BiteBuffer({NumRet,NumRet,NumRet,NumRet})
	end
	local Y = {}
	if CenterXY == nil then 
		table.insert(Y,SetCVar(FP,G_CA_XPos[2],SetTo,0xFFFFFFFF))
		table.insert(Y,SetCVar(FP,G_CA_YPos[2],SetTo,0xFFFFFFFF))
	elseif type(CenterXY) == "table" then
		table.insert(Y,SetCVar(FP,G_CA_XPos[2],SetTo,CenterXY[1]))
		table.insert(Y,SetCVar(FP,G_CA_YPos[2],SetTo,CenterXY[2]))
	else
		PushErrorMsg("G_CA_SetSpawn_CenterXY_Inputdata_Error")
	end
	if TargetXY == nil then 
		table.insert(Y,SetCVar(FP,G_CA_CUTV[2][2],SetTo,0))
		table.insert(Y,SetCVar(FP,G_CA_CUTV[3][2],SetTo,0))
	elseif type(TargetXY) == "table" then
		table.insert(Y,SetCVar(FP,G_CA_CUTV[2][2],SetTo,TargetXY[1]))
		table.insert(Y,SetCVar(FP,G_CA_CUTV[3][2],SetTo,TargetXY[2]))
	else
		PushErrorMsg("G_CA_SetSpawn_CenterXY_Inputdata_Error")
	end
	if FuncNum == nil then FuncNum = 0 end
	if Angle == nil then Angle = 0 end
	
	if MaxNum == nil then MaxNum = 0 end
	CallTriggerX(FP,Write_SpawnSet,Condition,{
		SetCVar(FP,G_CA_CUTV[1][2],SetTo,UnitID),
		SetCVar(FP,G_CA_CUTV[4][2],SetTo,G_CA_BulletType),
		SetCVar(FP,G_CA_CUTV[5][2],SetTo,Angle),
		X,
		SetCVar(FP,G_CA_SNTV[2],SetTo,T_to_BiteBuffer(G_CA_SNTable)),
		SetCVar(FP,G_CA_LMTV[2],SetTo,LMRet),
		SetCVar(FP,G_CA_RPTV[2],SetTo,101),Y,
		SetCVar(FP,G_CA_Owner[2],SetTo,7),
		SetCVar(FP,G_CA_FuncNum[2],SetTo,FuncNum),
		SetCVar(FP,G_CA_MaxNum[2],SetTo,MaxNum),
		SetCVar(FP,G_CA_EffType[2],SetTo,0),
		
	},PreserveFlag)
end


--G_CA_Rotate(_Mov(G_CA_TempTable[17],0xFFFF))
function G_CA_Rotate(num)
	while num< 0 do num=num+360 end
	return 0x10000000+num
end
function G_CA_LoopTimer(num)
	return 0x20000000+num
end
function G_CA_Rotate3D()
	return 0x30000000
end
function G_CA_Ratio(num)
	return 0x40000000+num
end
function G_CA_MapLimit()
	return 0x50000000
end
function G_CA_Rotate3D2()
	return 0x60000000
end

function G_CA_SetSpawn2X(Condition,G_CA_CUTable,G_CA_SNTable,G_CA_SLTable,G_CA_LMTable,EffType,CenterXY,Owner,FuncNum,MaxNum,PreserveFlag)
	local Z = {}
	local CUTable = {}
	local CUTable2 = G_CA_CUTable
	--if RedMode == 1 then
	--	CUTable2 = {}
	--	local CUTi=0
	--	while #CUTable2~=20 do
	--		if #CUTable2>=20 then break end
--
	--		for j,k in pairs(G_CA_CUTable) do
	--			if #CUTable2>=20 then break end
	--			table.insert(CUTable2,k)
	--		end
	--		CUTi=CUTi+1
	--		if CUTi==2 then break end
--
	--	end
	--	
	--else
	--	CUTable2 = G_CA_CUTable
	--end


	if type(CUTable2) ~= "table" then
		PushErrorMsg("G_CA_SetSpawn_Inputdata_Error")
	else
		if #CUTable2 <= 4 then
			Z = {SetCVar(FP,G_CA_CUTV[1][2],SetTo,T_to_BiteBuffer(CUTable2))}

		elseif #CUTable2 >= 5 and #CUTable2 <= 20 then
			local TempT = {}
			
			for j, k in pairs(CUTable2) do
				if #TempT > 3 then table.insert(CUTable,TempT) TempT = {} end
				table.insert(TempT,k)
			end
			if #TempT > 0 then table.insert(CUTable,TempT) TempT = {} end

			for j, k in pairs(CUTable) do
				table.insert(Z,SetCVar(FP,G_CA_CUTV[j][2],SetTo,T_to_BiteBuffer(k)))
			end
			
		else 
			PushErrorMsg("G_CA_CUTable_Size_OverFlow")
		end
	end
	if type(G_CA_SNTable) == "table" then
		PushErrorMsg("G_CA_SetSpawn_Inputdata_Error")
	else
		G_CA_SNTable = {G_CA_SNTable,G_CA_SNTable,G_CA_SNTable,G_CA_SNTable}
	end
	if type(G_CA_SLTable) == "table" then
		PushErrorMsg("G_CA_SetSpawn_Inputdata_Error")
	else
		G_CA_SLTable = {G_CA_SLTable,G_CA_SLTable,G_CA_SLTable,G_CA_SLTable}
	end
	
	local X = {}
	if type(G_CA_SLTable) == "table" then
		if #G_CA_SLTable >= 5 then
			PushErrorMsg("BiteStack_is_Over_5")
		end
		for i = 1, 4 do
			if G_CA_SLTable[i] ~= nil then
				if type(G_CA_SLTable[i]) == "string" then
					local G_CB_ShapeTable_Check = ""
					for j, k in pairs(G_CA2_ShapeTable) do
						if G_CA_SLTable[i] == k then
							table.insert(X,SetCVar(FP,G_CB_SNTV[i][2],SetTo,j))
							G_CB_ShapeTable_Check = "OK"
						end
					end
					if G_CB_ShapeTable_Check ~= "OK" then
						PushErrorMsg("G_CA_SetSpawn_String_Shape_NotFound")
					end
				else
					PushErrorMsg("G_CB_SNTable_InputData_Error")
				end
			else
				table.insert(X,SetCVar(FP,G_CB_SNTV[i][2],SetTo,0))
			end
		end
	elseif type(G_CA_SLTable) == "string" then
		local G_CB_ShapeTable_Check = ""
		for j, k in pairs(G_CA2_ShapeTable) do
			if G_CA_SLTable == k then
				table.insert(X,SetCVar(FP,G_CB_SNTV[1][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[2][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[3][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[4][2],SetTo,j))
				G_CB_ShapeTable_Check = "OK"
			end
		end
		if G_CB_ShapeTable_Check ~= "OK" then
			PushErrorMsg("G_CA_SetSpawn_String_Shape_NotFound")
		end
	else
		PushErrorMsg("G_CB_SNTable_InputData_Error")
	end
	local LMRet = 0
	if G_CA_LMTable == "MAX" then
		LMRet = T_to_BiteBuffer({255,255,255,255})
	elseif type(G_CA_LMTable) == "number" then
		local NumRet = G_CA_LMTable
		LMRet = T_to_BiteBuffer({NumRet,NumRet,NumRet,NumRet})
	else
		PushErrorMsg("G_CA_LMTable_InputData_Error")
	end
	local Y = {}
	if CenterXY == nil then 
		table.insert(Y,SetCVar(FP,G_CA_XPos[2],SetTo,0xFFFFFFFF))
		table.insert(Y,SetCVar(FP,G_CA_YPos[2],SetTo,0xFFFFFFFF))
	elseif type(CenterXY) == "table" then
		table.insert(Y,SetCVar(FP,G_CA_XPos[2],SetTo,CenterXY[1]))
		table.insert(Y,SetCVar(FP,G_CA_YPos[2],SetTo,CenterXY[2]))
	else
		PushErrorMsg("G_CA_SetSpawn_CenterXY_Inputdata_Error")
	end
	if Owner == nil then Owner = 0xFFFFFFFF
	elseif Owner == "CP" then Owner = 0x7FFFFFFF end
	if MaxNum == nil then MaxNum = 0 end
	if FuncNum == nil then FuncNum = 0 end
	local Ef = {}
	--if EffType == nil then EffType = 0 
	--else Ef = {SetMemoryB(0x667718+EffType,SetTo,0)}
	--end
	CallTriggerX(FP,Write_SpawnSet,Condition,{
		SetCVar(FP,G_CA_CUTV[1][2],SetTo,0),
		SetCVar(FP,G_CA_CUTV[2][2],SetTo,0),
		SetCVar(FP,G_CA_CUTV[3][2],SetTo,0),
		SetCVar(FP,G_CA_CUTV[4][2],SetTo,0),
		SetCVar(FP,G_CA_CUTV[5][2],SetTo,0),
		Z,X,
		SetCVar(FP,G_CA_SNTV[2],SetTo,T_to_BiteBuffer(G_CA_SNTable)),
		SetCVar(FP,G_CA_LMTV[2],SetTo,LMRet),
		SetCVar(FP,G_CA_RPTV[2],SetTo,100),Y,Ef,
		SetCVar(FP,G_CA_Owner[2],SetTo,Owner),
		SetCVar(FP,G_CA_EffType[2],SetTo,EffType),
		SetCVar(FP,G_CA_FuncNum[2],SetTo,FuncNum),
		SetCVar(FP,G_CA_MaxNum[2],SetTo,MaxNum),

	},PreserveFlag)
end



function Install_Call_G_CA()
	Call_G_CA = SetCallForward()
	SetCall(FP)
		CIfX(FP,CVar(FP,G_CA_TempTable[1][2],AtLeast,1,0xFF))
			CDoActions(FP,{
			})
			CallTrigger(FP,Load_CAPlot_Shape)
			CIfX(FP,{CDeaths(FP,AtLeast,1,G_CA_Launch),CDeaths(FP,AtMost,0,CA_Suspend)})
			CElseIfX({TTCVar(FP,G_CA_TempTable[6][2],NotSame,100),CDeaths(FP,AtLeast,1,G_CA_Launch),CDeaths(FP,AtLeast,1,CA_Suspend)})
			DoActionsX(FP,{
				SetCVar(FP, G_CA_TempTable[1][2], SetTo, 0, 0xFF),
				SetCVar(FP, G_CA_TempTable[3][2], SetTo, 1),
				SetCVar(FP, G_CA_TempTable[4][2], SetTo, 0, 0xFF),
				SetCVar(FP, G_CA_TempTable[5][2], SetTo, 0, 0xFF),
				SetCVar(FP, G_CA_TempTable[6][2], SetTo, 0, 0xFF),
				SetCVar(FP, G_CA_TempTable[7][2], SetTo, 0, 0xFF),
				SetCVar(FP, G_CA_TempTable[18][2], SetTo, 0),
			})
			if Limit == 1 then
				--Trigger2X(FP,{CD(TestMode,1)},{RotatePlayer({DisplayTextX(f_GunFuncT,4)},HumanPlayers,FP)},{preserved})
			end
			CElseIfX({CVar(FP,G_CA_TempTable[6][2],Exactly,100),CDeaths(FP,AtLeast,1,G_CA_Launch),CDeaths(FP,AtLeast,1,CA_Suspend)})
			
			local G_CB_InputCAct = {}
			for i = 1, G_CA_Lines do
				table.insert(G_CB_InputCAct,SetNVar(G_CA_TempTable[i],SetTo,0))
			end
				CDoActions(FP,G_CB_InputCAct)
			if Limit == 1 then
				--Trigger2X(FP,{CD(TestMode,1)},{RotatePlayer({DisplayTextX(f_GunFuncT,4)},HumanPlayers,FP)},{preserved})
			end
			CElseX()
			if Limit == 1 then
				Trigger2X(FP,{CD(TestMode,1)},{RotatePlayer({DisplayTextX(f_GunErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)},{preserved})
			end
			
				DoActionsX(FP,{
					SetCVar(FP, G_CA_TempTable[1][2], SetTo, 0, 0xFF),
					SetCVar(FP, G_CA_TempTable[3][2], SetTo, 1),
					SetCVar(FP, G_CA_TempTable[4][2], SetTo, 0, 0xFF),
					SetCVar(FP, G_CA_TempTable[5][2], SetTo, 0, 0xFF),
					SetCVar(FP, G_CA_TempTable[6][2], SetTo, 0, 0xFF),
					SetCVar(FP, G_CA_TempTable[7][2], SetTo, 0, 0xFF),
					SetCVar(FP, G_CA_TempTable[18][2], SetTo, 0),
				})
			CIfXEnd()
		CElseIfX({CVar(FP,G_CA_TempTable[1][2],AtMost,0,0xFF),CVar(FP,G_CA_TempTable[1][2],AtLeast,1)})
			CDiv(FP,G_CA_TempTable[1],256)
			CMov(FP,G_CA_TempTable[3],0)
			CDiv(FP,G_CA_TempTable[4],256)
			CDiv(FP,G_CA_TempTable[5],256)
			CDiv(FP,G_CA_TempTable[6],256)
			CDiv(FP,G_CA_TempTable[7],256)
			CMov(FP,G_CA_TempTable[19],G_CA_TempTable[20])
			CMov(FP,G_CA_TempTable[20],G_CA_TempTable[21])
			CMov(FP,G_CA_TempTable[21],G_CA_TempTable[22])
			CMov(FP,G_CA_TempTable[22],0)

		CIfXEnd()
		
		local G_CB_InputCAct = {}
		for i = 1, G_CA_Lines do
			table.insert(G_CB_InputCAct,TSetMemory(Vi(G_CA_TempH[2],(i-1)*(0x20/4)),SetTo,G_CA_TempTable[i]))
		end
		CDoActions(FP,G_CB_InputCAct)

		DoActionsX(FP,{SetCDeaths(FP,SetTo,0,CA_Suspend),SetCDeaths(FP,SetTo,0,G_CA_Launch)})
	SetCallEnd()
end
local Actived_G_CA = CreateVar(FP)
function Create_G_CA_Arr()
	if G_CA_Arr_IndexAlloc ~= StartIndex then PushErrorMsg("Already_G_CA_Arr_Created") end
	CMov(FP,Actived_G_CA,0)
	for i = 0, Size_of_G_CA_Arr-1 do
		CTrigger(FP, {CVar("X","X",AtLeast,1),Memory(0x628438,AtLeast,1)}, {
			G_CA_InputCVar,
			SetCtrigX("X",G_CA_TempH[2],0x15C,0,SetTo,"X","X",0x15C,1,0),
			SetCVar(FP,G_CA_Num[2],SetTo,i+1),
			SetCVar(FP,Actived_G_CA[2],Add,1),
			SetNext("X",Call_G_CA,0),SetNext(Call_G_CA+1,"X",1), -- Call f_Gun
			SetCtrigX("X",Call_G_CA+1,0x158,0,SetTo,"X","X",0x4,1,0), -- RecoverNext
			SetCtrigX("X",Call_G_CA+1,0x15C,0,SetTo,"X","X",0,0,1), -- RecoverNext
			SetCtrig1X("X",Call_G_CA+1,0x164,0,SetTo,0x0,0x2) -- RecoverNext
		}, 1, G_CA_Arr_IndexAlloc)
		G_CA_Arr_IndexAlloc = G_CA_Arr_IndexAlloc + 1
	end
end
function Install_Load_CAPlot()
    Load_CAPlot_Shape = SetCallForward()
    SetCall(FP)
    for j, k in pairs(G_CA_CallStack) do
        CallTriggerX(FP,k,{CVar(FP,G_CA_TempTable[4][2],Exactly,j,0xFF)})
    end
    SetCallEnd()
end

	function G_CA_Lib_ErrorCheck()
		if Load_CAPlot_Shape == nil then PushErrorMsg("Need_Install_Load_CAPlot") end
	end

--	function G_CA_init()
--
--		f_GetStrXptr(FP,G_CA_WSTestStrPtr,"\x0D\x0D\x0DG_CA_WS".._0D)
--
--	end

end

function CreateEffUnit(Condition,Height,EffType,Color)
	local ret2 = 0x669E28+EffType
	local ret = bit32.band(ret2, 0xFFFFFFFF)%4
	local Mask = 0
	if ret == 0 then
		Mask = 0xFF
	elseif ret == 1 then
		Mask = 0xFF00
		Color = Color * 0x100
	elseif ret == 2 then
		Mask = 0xFF0000
		Color = Color * 0x10000
	elseif ret == 3 then
		Mask = 0xFF000000
		Color = Color * 0x1000000
	end
	ret2 = ret2 - ret

	
CallTriggerX(FP,Call_EffUnit,Condition,{
	SetMemoryW(0x666462, SetTo, EffType);
	SetMemoryB(0x66321C, SetTo, Height); -- 높이
	SetCVar(FP,SendEff[1][2],SetTo,EPDF(ret2));
	SetCVar(FP,SendEff[2][2],SetTo,Color);
	SetCVar(FP,SendEff[3][2],SetTo,Mask);
	SetCVar(FP,SendEff2[1][2],SetTo,EffType+EPDF(0x66EC48));
})
end


function CreateEffUnitX(Condition,EffType,Color)

	local ret2 = CreateVar(FP)
	CAdd(FP,ret2,EffType,0x669E28)
	local ret = CreateVar(FP)
	f_Mod(FP,ret,ret2,4)
	local ret3 = CreateVar(FP) -- ColorRet
	local Mask = CreateVar(FP)

	CIfX(FP, {CV(ret,0)})
		CMov(FP,Mask,0xFF)
		CMov(FP,ret3, Color)
	CElseIfX({CV(ret,1)})
		CMov(FP,Mask,0xFF00)
		f_Mul(FP,ret3, Color,0x100)
	CElseIfX({CV(ret,2)})
		CMov(FP,Mask,0xFF0000)
		f_Mul(FP,ret3, Color,0x10000)
	CElseIfX({CV(ret,3)})
		CMov(FP,Mask,0xFF000000)
		f_Mul(FP,ret3, Color,0x1000000)
	CIfXEnd()
	CSub(FP,ret2,ret)

	CDoActions(FP, {
		TSetMemoryW(0x666460, 1, SetTo, EffType);
		SetMemoryB(0x66321C, SetTo, 20); -- 높이
		TSetCVar(FP,SendEff[1][2],SetTo,_EPD(ret2));
		TSetCVar(FP,SendEff[2][2],SetTo,ret3);
		TSetCVar(FP,SendEff[3][2],SetTo,Mask);
		TSetCVar(FP,SendEff2[1][2],SetTo,_Add(EffType,EPDF(0x66EC48)));
	})
CallTriggerX(FP,Call_EffUnit,Condition)
end


function CreateScanEff(EffType)
	T ={
		SetMemoryX(0x666458, SetTo, EffType,0xFFFF),
		CreateUnitWithProperties(1,33,1,FP,{energy = 100}),
		KillUnit(33,FP);
		SetMemoryX(0x666458, SetTo, 546,0xFFFF),}
return T	
end

function InvDisable(UnitID,Owner,Condition,Str)
    Trigger2X(FP,Condition,{
        Simple_SetLoc(0,0,0,32,32);
        MoveLocation(1,UnitID,Owner,64);
        RotatePlayer({
            MinimapPing(1),
            PlayWAVX("staredit\\wav\\start.ogg"),
            PlayWAVX("staredit\\wav\\start.ogg"),
            DisplayTextX("\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x0D\x0D\n\x0D\x0D!H"..StrDesignX2(Str).."\n\x0D\x0D\n\x0D\x0D\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x0D\x0D\x13\x04",4)
        },HumanPlayers,FP);
        SetInvincibility(Disable,UnitID,Owner,1);
    })
end


function CreateBullet(UnitId,Height,Angle,XY,Player)
	if XY ~= nil and type(XY) == "table" then
		CDoActions(FP,{
			TSetCVar(FP,CBY[2],SetTo,XY[2]),
			TSetCVar(FP,CBX[2],SetTo,XY[1]),
			TSetCVar(FP,CBAngle[2],SetTo,Angle),
			TSetCVar(FP,CBHeight[2],SetTo,Height),
			TSetCVar(FP,CBUnitId[2],SetTo,UnitId),
			TSetCVar(FP,CBPlayer[2],SetTo,Player),
			SetNextTrigger(Call_CBullet)
		})
	elseif XY == nil then
		CDoActions(FP,{
			TSetCVar(FP,CBY[2],SetTo,0),
			TSetCVar(FP,CBX[2],SetTo,0),
			TSetCVar(FP,CBAngle[2],SetTo,Angle),
			TSetCVar(FP,CBHeight[2],SetTo,Height),
			TSetCVar(FP,CBUnitId[2],SetTo,UnitId),
			TSetCVar(FP,CBPlayer[2],SetTo,Player),
			SetNextTrigger(Call_CBullet)
		})
	else
		PushErrorMsg("CreateBullet_XY_Error")
	end
end

function CreateBulletCond(UnitId,Height,Angle,XY,Player,Cond,Act)
	CallTriggerX(FP,Call_CBullet,Cond,{Act,
	SetCVar(FP,CBY[2],SetTo,XY[2]),
	SetCVar(FP,CBX[2],SetTo,XY[1]),
	SetCVar(FP,CBAngle[2],SetTo,Angle),
	SetCVar(FP,CBHeight[2],SetTo,Height),
	SetCVar(FP,CBUnitId[2],SetTo,UnitId),
	SetCVar(FP,CBPlayer[2],SetTo,Player),})
end

function CreateBulletLoc(UnitId,Height,Angle,Player)
		CDoActions(FP,{
			TSetCVar(FP,CBY[2],SetTo,0),
			TSetCVar(FP,CBX[2],SetTo,0),
			TSetCVar(FP,CBAngle[2],SetTo,Angle),
			TSetCVar(FP,CBHeight[2],SetTo,Height),
			TSetCVar(FP,CBUnitId[2],SetTo,UnitId),
			TSetCVar(FP,CBPlayer[2],SetTo,Player),
			SetNextTrigger(Call_CBullet)
		})
end
function StoryPrint(T,Text,AddTrig)
	Trigger2X(FP,{Gun_Line(8,AtLeast,T)},{
		RotatePlayer({
			DisplayTextX("\x0D\x0D"..string.rep("\n", 20),4),
			DisplayTextX("\x0D\x0D\x12\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D!H\x13"..Text.."\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n",0),
		},HumanPlayers,FP);
		SetCDeaths(FP,Add,1,ButtonSound);
		AddTrig
	})
end


	
function Include_CBulletLib()
	
Call_CBullet = SetCallForward()
SetCall(FP)
NIf(FP,Memory(0x628438,AtLeast,1))
f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF,1)

CIf(FP,{TTOR({CVar(FP,CBX[2],AtLeast,1),CVar(FP,CBY[2],AtLeast,1)})})

CDoActions(FP,{
TSetMemory(0x58DC60 + 0x14*0,SetTo,CBX),
TSetMemory(0x58DC68 + 0x14*0,SetTo,CBX),
TSetMemory(0x58DC64 + 0x14*0,SetTo,_Add(CBY,10)),
TSetMemory(0x58DC6C + 0x14*0,SetTo,_Add(CBY,10)),
})
CIfEnd()
CDoActions(FP,{
	TSetMemoryX(0x66321C, SetTo, CBHeight,0xFF);
	TCreateUnit(1, CBUnitId, 1, CBPlayer),
	TSetMemoryX(_Add(Nextptrs,25),SetTo,CBUnitId,0xFFFF)
})
f_Read(FP,_Add(Nextptrs,10),Locs)
CDoActions(FP,{
	TSetMemoryX(_Add(Nextptrs,4),SetTo,Locs,0xFFFFFFFF),
	TSetMemoryX(_Add(Nextptrs,6),SetTo,Locs,0xFFFFFFFF),
	TSetMemoryX(_Add(Nextptrs,7),SetTo,Locs,0xFFFFFFFF),
	TSetMemoryX(_Add(Nextptrs,22),SetTo,Locs,0xFFFFFFFF),
	TSetMemoryX(_Add(Nextptrs,8),SetTo,_Mul(CBAngle,_Mov(256)),0xFF00),
	TSetMemoryX(_Add(Nextptrs,8),SetTo,127*65536,0xFF0000),
	TSetMemoryX(_Add(Nextptrs,19),SetTo,135*256,0xFF00),
	TSetMemoryX(_Add(Nextptrs,68),SetTo,30,0xFFFF),
})
NIfEnd()
SetCallEnd()
CBulletErrT = "\x07『 \x08ERROR \x04: CreateBullet_EPD 목록이 가득 차 데이터를 입력하지 못했습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"

Call_CBulletA = SetCallForward()
SetCall(FP)
CIf(FP,{CVar(FP,TempEPD[2],AtLeast,19025),CVar(FP,TempEPD[2],AtMost,19025+(84*1699))})

--CIf(FP,CVar(FP,AngleA[2],AtLeast,1*256))
--CDoActions(FP,{TSetMemory(_Add(CB_TempH,0x40/4),SetTo,AngleA)})
--CIfEnd()
CIfX(FP,CVar(FP,TempT[2],Exactly,0))
f_Read(FP,_Add(TempEPD,8),AngleA,nil,0xFF00)
f_Read(FP,_Add(TempEPD,10),LocsA)
CDoActions(FP,{
	TSetMemoryX(_Add(TempEPD,4),SetTo,LocsA,0xFFFFFFFF),
	TSetMemoryX(_Add(TempEPD,6),SetTo,LocsA,0xFFFFFFFF),
	TSetMemoryX(_Add(TempEPD,7),SetTo,LocsA,0xFFFFFFFF),
	TSetMemoryX(_Add(TempEPD,22),SetTo,LocsA,0xFFFFFFFF),
	TSetMemoryX(_Add(TempEPD,8),Add,32768,0xFF00),
	TSetMemoryX(_Add(TempEPD,19),SetTo,135*256,0xFF00),
	TSetMemoryX(CB_TempH,SetTo,0,0xFFFFFFFF)})
CElseX()
CDoActions(FP,{TSetMemory(_Add(CB_TempH,0x20/4),Subtract,1),
TSetMemoryX(_Add(TempEPD,19),SetTo,135*256,0xFF00),
TSetMemory(_Add(TempEPD,13),SetTo,1),
TSetMemoryX(_Add(TempEPD,18),SetTo,1,0xFFFF),
TSetMemoryX(_Add(TempEPD,68),SetTo,30,0xFFFF),
TSetMemoryX(_Add(TempEPD,4),SetTo,BPos,0xFFFFFFFF),
TSetMemoryX(_Add(TempEPD,6),SetTo,BPos,0xFFFFFFFF),
TSetMemoryX(_Add(TempEPD,7),SetTo,BPos,0xFFFFFFFF),
TSetMemoryX(_Add(TempEPD,22),SetTo,BPos,0xFFFFFFFF),
})
CIfXEnd()
CIfEnd()

SetCallEnd()


--Call_CreateBullet_EPD = SetCallForward()
--SetCall(FP)--

--local CBulletIndex = 0x1100
--for i = 0, 127 do
--	local Index = 0
--	if i == 0 then Index = CBulletIndex end
--	CTrigger(FP, {CVar("X","X",AtLeast,1)}, {
--		SetCVar(FP,TempEPD[2],SetTo,0),
--		SetCVar(FP,TempT[2],SetTo,0),
--		SetCVar(FP,TempA[2],SetTo,0),
--		SetCVar(FP,BPos[2],SetTo,0),
--		SetCtrigX("X",CB_TempH[2],0x15C,0,SetTo,"X","X",0x15C,1,0),
--		SetNext("X",Call_CBulletA,0),SetNext(Call_CBulletA+1,"X",1), -- Call f_Gun
--		SetCtrigX("X",Call_CBulletA+1,0x158,0,SetTo,"X","X",0x4,1,0), -- RecoverNext
--		SetCtrigX("X",Call_CBulletA+1,0x15C,0,SetTo,"X","X",0,0,1), -- RecoverNext
--		SetCtrig1X("X",Call_CBulletA+1,0x164,0,SetTo,0x0,0x2) -- RecoverNext
--	}, 1, Index)
--end
--table.insert(CtrigInitArr[8],SetCtrigX(FP,CBullet_InputH[2],0x15C,0,SetTo,FP,CBulletIndex,0x15C,1,0))--

--SetCallEnd()
--Call_SetBulletXY = SetCallForward()
--SetCall(FP)
--NIf(FP,Memory(0x628438,AtLeast,1))
--f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF,1)
--local Cur_CBulletArr = CreateVar(FP)--

--local CBullet_ArrCheck = def_sIndex()--

--CMov(FP,Cur_CBulletArr,0)
--CJumpEnd(FP,CBullet_ArrCheck)
--CAdd(FP,CBullet_ArrTemp,CBullet_InputH,Cur_CBulletArr)--

--CIf(FP,{TTOR({CVar(FP,CBX[2],AtLeast,1),CVar(FP,CBY[2],AtLeast,1)})})--

--CDoActions(FP,{
--TSetMemory(0x58DC60 + 0x14*0,SetTo,CBX),
--TSetMemory(0x58DC68 + 0x14*0,SetTo,CBX),
--TSetMemory(0x58DC64 + 0x14*0,SetTo,_Add(CBY,10)),
--TSetMemory(0x58DC6C + 0x14*0,SetTo,_Add(CBY,10)),
--})
--CIfEnd()--

--NIfX(FP,{TMemory(CBullet_ArrTemp,AtMost,0)})
--CDoActions(FP,{
--	TSetMemoryX(0x66321C, SetTo, CBHeight,0xFF),
--	TCreateUnit(1, CBUnitId, 1, FP),
--	TSetMemoryX(_Add(Nextptrs,25),SetTo,CBUnitId,0xFF),
--})
--local TempBPos = CreateVar(FP)
--CMov(FP,TempBPos,_Add(BPosX,_Mul(BPosY,_Mov(65536))))--

--CDoActions(FP,{
--	TSetMemoryX(_Add(Nextptrs,22),SetTo,TempBPos,0xFFFFFFFF),
--	TSetMemoryX(_Add(Nextptrs,19),SetTo,135*256,0xFF00),
--	TSetMemoryX(_Add(Nextptrs,8),SetTo,127*65536,0xFF0000),
--	TSetMemory(_Add(Nextptrs,13),SetTo,1),
--	TSetMemoryX(_Add(Nextptrs,18),SetTo,1,0xFFFF),
--	TSetMemoryX(_Add(Nextptrs,68),SetTo,30,0xFFFF),
--	TSetMemoryX(CBullet_ArrTemp,SetTo,Nextptrs,0xFFFFFFFF),
--	TSetMemoryX(_Add(CBullet_ArrTemp,0x20/4),SetTo,3,0xFFFFFFFF),
--	TSetMemoryX(_Add(CBullet_ArrTemp,(0x20/4)*3),SetTo,TempBPos,0xFFFFFFFF),
--})--

--NElseIfX({CVar(FP,Cur_CBulletArr[2],AtMost,((0x970/4)*126))})
--CAdd(FP,Cur_CBulletArr,0x970/4)
--CJump(FP,CBullet_ArrCheck)
--NElseX()--

--DoActions2(FP,{RotatePlayer({DisplayTextX(CBulletErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})--

--NIfXEnd()--

--NIfEnd()
--SetCallEnd()



Call_CBullet_PosCalc = SetCallForward()
SetCall(FP)
NIf(FP,Memory(0x628438,AtLeast,1))
f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF,1)
CDoActions(FP,{TSetMemoryX(0x66321C, SetTo, CBHeight,0xFF)})
CDoActions(FP,{
	TSetMemory(0x58DC60 + 0x14*0,Add,CBX),
	TSetMemory(0x58DC68 + 0x14*0,Add,CBX),
	TSetMemory(0x58DC64 + 0x14*0,Add,_Add(CBY,10)),
	TSetMemory(0x58DC6C + 0x14*0,Add,_Add(CBY,10)),
	TCreateUnit(1, CBUnitId, 1, FP),
	TSetMemoryX(_Add(Nextptrs,25),SetTo,CBUnitId,0xFF),
})
f_Read(FP,_Add(Nextptrs,10),Locs)
CDoActions(FP,{
	TSetMemoryX(_Add(Nextptrs,22),SetTo,Locs,0xFFFFFFFF),
	TSetMemoryX(_Add(Nextptrs,8),SetTo,_Mul(CBAngle,_Mov(256)),0xFF00),
	TSetMemoryX(_Add(Nextptrs,19),SetTo,135*256,0xFF00),
	TSetMemoryX(_Add(Nextptrs,68),SetTo,30,0xFFFF),
})
NIfEnd()
SetCallEnd()
CB_UnitIDV = CreateVar(FP)
Height_V = CreateVar(FP)
CB_X = CreateVar(FP)
CB_Y = CreateVar(FP)
CB_TX = CreateVar(FP)
CB_TY = CreateVar(FP)
CB_P = CreateVar(FP)
Angle_V = CreateVar(FP)
function CreateBulletXY(UnitID,Height,XY,TargetXY,ForPlayer)
	if ForPlayer == nil then ForPlayer = FP end
	if XY == nil then
		XY={0,0}
	elseif type(XY) ~= "table" then
		PushErrorMsg("SetBullet_XY_Error")
	end
	if TargetXY == nil then
		TargetXY={0,0}
	elseif type(TargetXY) ~= "table" then
		PushErrorMsg("SetBullet_XY_Error")
	end
CDoActions(FP,{
	TSetCVar(FP,CB_UnitIDV[2],SetTo,UnitID),
	TSetCVar(FP,Height_V[2],SetTo,Height),
	TSetCVar(FP,CB_X[2],SetTo,XY[1]),
	TSetCVar(FP,CB_Y[2],SetTo,XY[2]),
	TSetCVar(FP,CB_TX[2],SetTo,TargetXY[1]),
	TSetCVar(FP,CB_TY[2],SetTo,TargetXY[2]),
	TSetCVar(FP,CB_P[2],SetTo,ForPlayer),
	SetNext("X",Call_CreateBulletXY,0),SetNext(Call_CreateBulletXY+1,"X",1)
})
end

Call_CreateBulletXY = SetCallForward()
local Angle_T=CreateVar(FP)
SetCall(FP)
CIf(FP,Memory(0x628438,AtLeast,1))
	f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
	f_Atan2(FP, _iSub(CB_Y,CB_TY), _iSub(CB_X,CB_TX), Angle_T)
	CIf(FP,{CV(Angle_T,360,AtLeast)})
	CMod(FP, Angle_T, 360)
	CIfEnd()
	CMov(FP,Angle_V,_SHRead(FArr(DCtoSCFArr,Angle_T)),64)
	--CMov(FP,Angle_V,_Div(_Mul(_Div(_Mul(Angle_T,100000),360),256),100000),64)
	f_Mod(FP,Angle_V,_Mov(256))
	CDoActions(FP,{
		TSetMemoryB(0x656990, CB_UnitIDV, SetTo, Height_V),
		TSetMemory(0x58DC60 + 0x14*0,SetTo,CB_X),
		TSetMemory(0x58DC68 + 0x14*0,SetTo,CB_X),
		TSetMemory(0x58DC64 + 0x14*0,SetTo,CB_Y),
		TSetMemory(0x58DC6C + 0x14*0,SetTo,CB_Y),
		TCreateUnit(1, CB_UnitIDV, 1, CB_P)})
	CDoActions(FP,{
		TSetMemoryX(_Add(Nextptrs,0x58/4),SetTo,_ReadF(_Add(Nextptrs,(0x28/4))),0xFFFFFFFF),
		TSetMemoryX(_Add(Nextptrs,0x20/4),SetTo,_Mul(Angle_V,256),0xFF00),
		TSetMemoryX(_Add(Nextptrs,0x4C/4),SetTo,135*256,0xFF00),
		TSetMemoryX(_Add(Nextptrs,40),SetTo,0,0xFF000000),
		TSetMemoryX(_Add(Nextptrs,55),SetTo,0x200104,0x300104),
		TSetMemory(_Add(Nextptrs,57),SetTo,0),
		TSetMemoryX(_Add(Nextptrs,68),SetTo,12,0xFFFF)
	})
CIfEnd()
SetCallEnd()



function SetBulletSpeed(Value,BreakDis) -- 야마토건 Flingy Speed
	if BreakDis ~= nil then
		return {
			SetMemory(0x6CA170, SetTo,0xFFFFFFFF-Value);
			SetMemoryX(0x6C9DB4, SetTo, Value,0xFFFF);
			SetMemory(0x6C9BA8, SetTo, BreakDis);
		}
	else
		return {
			SetMemory(0x6CA170, SetTo, 0xFFFFFFFF-Value);
			SetMemoryX(0x6C9DB4, SetTo, Value,0xFFFF);
		}
	end
end
function SetFlingySpeed(FID,Value)
	return {
		SetMemory(0x6C9EF8+(4*FID),SetTo,0xFFFFFFFF-Value),--최고속도
		SetMemoryW(0x6C9C78+(2*FID),SetTo,Value)--가속도
	}
end
function WeaponTimeLeft(WepID,Value)
return SetMemoryB(0x657040+WepID,SetTo,Value)
end
function CreateBulletPosCalc(UnitId,Height,Angle,X,Y)
	CDoActions(FP,{
		TSetCVar(FP,CBY[2],SetTo,Y),
		TSetCVar(FP,CBX[2],SetTo,X),
		TSetCVar(FP,CBAngle[2],SetTo,Angle),
		TSetCVar(FP,CBHeight[2],SetTo,Height),
		TSetCVar(FP,CBUnitId[2],SetTo,UnitId),
		SetNextTrigger(Call_CBullet_PosCalc)
	})
	end
		
		
function SetBullet(UnitId,Height,XY,TargetXY)
	if XY == nil then
		XY={0,0}
	elseif type(XY) ~= "table" then
		PushErrorMsg("SetBullet_XY_Error")
	end
	if TargetXY == nil then
		TargetXY={0,0}
	elseif type(TargetXY) ~= "table" then
		PushErrorMsg("SetBullet_XY_Error")
	end

		CDoActions(FP,{
			TSetCVar(FP,CBY[2],SetTo,XY[2]),
			TSetCVar(FP,CBX[2],SetTo,XY[1]),
			TSetCVar(FP,BPosY[2],SetTo,TargetXY[2]),
			TSetCVar(FP,BPosX[2],SetTo,TargetXY[1]),
			TSetCVar(FP,CBHeight[2],SetTo,Height),
			TSetCVar(FP,CBUnitId[2],SetTo,UnitId),
			SetNextTrigger(Call_SetBulletXY)
		})
end

end


function UnitButton(Player,UnitID,Condition,Actions)
	Trigger { 
		players = {Player},
		conditions = {
			Label(0);
			Command(Player,AtLeast,1,UnitID);
			Condition
		},
		actions = {
			ModifyUnitEnergy(All,UnitID,Player,64,0);
			GiveUnits(All,UnitID,Player,"Anywhere",11);
			RemoveUnitAt(All,UnitID,"Anywhere",11);
			SetCDeaths(FP,Add,1,CUnitRefrash);
			Actions;
			PreserveTrigger();
			},
	}
end


function Install_NukeLibrary()
	Call_Nuke = SetCallForward()
	SetCall(FP)
	local Nextptrs,NextEPD = CreateVars(2,FP)
	f_Read(FP,0x628438,Nextptrs,NextEPD,0xFFFFFF)
	CDoActions(FP,{CreateUnit(1,215,1,FP),
		TSetMemoryX(_Add(NextEPD,0x110/4), SetTo, 420,0xFFFF),
	})
	f_Read(FP,_Add(NextEPD,10),CPos) -- 생성유닛 위치 불러오기
	f_Read(FP,0x628438,nil,NextEPD,0xFFFFFF)
	CDoActions(FP,{CreateUnit(1,14,1,FP),
	TSetMemory(_Add(NextEPD,0x80/4), SetTo, Nextptrs),
	TSetMemoryX(_Add(NextEPD,19), SetTo, 125*256,0xFF00),
	TSetMemory(_Add(NextEPD,0x58/4), SetTo, CPos),
	})
	SetCallEnd()
end


---@param UnitPtr? table -- 보스 유닛의 EPD가 담긴 주소
---@param UnitHPRetV? table -- 보스 유닛의 확장 HP를 리턴받는 V/VA
---@param Preset? table -- 6개의 프리셋 입력공간. {} 형태로 입력
---@param CAfunc? string -- 보스 패턴 등의 CAFunc 입력공간. CB[3]이 1이상일 경우 해당 함수가 작동되지 않음
---@param PlayerID? number -- 트리거 플레이어
---@param Condition? table -- CABoss 발동 조건
---@param Action? table -- 조건이 만족될때 실행할 액션
---@return table,table -- 해당함수의 리턴값 = CA,CB
function CABoss(UnitPtr,UnitHPRetV,Preset,CAfunc,PlayerID,Condition,Action)
	CIf(PlayerID,{CV(UnitPtr,19025,AtLeast),CV(UnitPtr,19025+(84*1699),AtMost),Condition},Action)
	
	if UnitPtr == nil then
		PushErrorMsg("CA_InputError")
	elseif UnitPtr[4] ~= "V" then
		PushErrorMsg("CA_InputError")
	end

	local CA = {} -- 8
	local CB = {} -- 4
	local CTemp
	for i = 1, 8 do -- Preset Setting
		if i == 5 then
			if Preset[i] == nil then
				Preset[i] = 4000000
			end
		else
			if Preset[i] == nil then
				Preset[i] = 0
			end
		end
	end

	for i = 1, 8 do -- CA : Preset
		if type(Preset[i]) == "number" then 
			CTemp = CreateVar2(PlayerID,nil,SetTo,Preset[i])
		else
			CTemp = CreateVar(PlayerID)
		end
		table.insert(CA,CTemp)
	end
	CB = CreateVarArr(9,PlayerID)

	--이하 프리셋
	--Preset[1] = PattNum -- 시작 패턴 넘버 결정. 0에서 시작시 nil입력해도됨
	--Preset[2] = initPattT -- 보스 소환 후 작동 대기시간. 1프레임 단위
	--Preset[3] = Lock type -- 보스를 고정시킬지 결정함. 1 입력시 부분고정됨(미세하게 이동함). 마린, 고스트류 모두 사용가능. 단, 2 이상 입력시 완전고정되는데 최고속도, 가속도 조작시 튕김
	--Preset[4] = initHP -- 초기 HP 입력(실제값은 MaxHP + InitHP)
	--Preset[5] = MaxHP -- 무적상태로 만들때 최대체력값. 마린 공격력이 너무 높을 경우 800만쯤으로 잡아줘야됨
	--Preset[6] = ExtendHPFlag -- 확장 체력 기능 사용 여부. 1일 경우 사용안함
	-- 이하 내부변수
	--CB[1] = Unused -- 사용안됨. 사용자가 자유롭게 사용 가능
	--CB[2] = ExHP -- 현재 확장된 HP값이 저장된 변수. 이 값을 변경하면 체력을 자유롭게 늘렸다 줄였다 할 수 있음
	--CB[3] = PattT -- 보스 작동 대기시간. 이 값이 1 이상일 경우 무적. 1프레임 단위로 1씩 감소됨
	--CB[4] = Unused -- 사용안됨. 사용자가 자유롭게 사용 가능
	--CB[5] = DeathFlag -- 죽엇을 경우 이 값이 1이 됨.
	--CB[6] = Enable BossKill -- 이 값이 0일 경우 보스를 죽일수 있는 상태가 됨. 아직 죽이기 싫을때 이 값을 1로 바꾸면 됨
	--CB[7] = Temp -- 내부 사용 변수. 사용자가 값 변경 금지
	--CB[8] = Temp -- 내부 사용 변수. 사용자가 값 변경 금지
	--CB[9] = Unused -- 사용안됨. 사용자가 자유롭게 사용 가능
	CIfOnce(PlayerID)--init
	CDoActions(PlayerID,{SetV(CB[3],Preset[2]),SetV(CB[2],CA[4])},1)
	CTrigger(PlayerID,{CV(CA[3],1,AtLeast)},{
		TSetMemory(_Add(UnitPtr,13), SetTo, 1),
		TSetMemoryX(_Add(UnitPtr,18), SetTo, 1,0xFFFF),
		TSetMemoryX(_Add(UnitPtr,9), SetTo, 0,0xFF000000),
		TSetMemoryX(_Add(UnitPtr,8), SetTo, 127*65536,0xFF0000),
	})
	CTrigger(PlayerID,{CV(CA[3],2,AtLeast)},{
		TSetMemory(_Add(UnitPtr,13), SetTo, 0),
		TSetMemoryX(_Add(UnitPtr,18), SetTo, 0,0xFFFF),
	})
	CIfEnd()

	-------- Preset Limit --------------------------------
	for i = 1, 6 do
		if type(Preset[i]) ~= "number" then
			CMov(PlayerID,CA[i],Preset[i])
		end
	end




		CIfX(PlayerID,{TMemoryX(_Add(UnitPtr,19),AtLeast,1*256,0xFF00)})--살아있는경우
		
			CTrigger(PlayerID,{TMemory(_Add(UnitPtr,2), AtMost, (Preset[5])*256),CV(CB[2],0,AtMost),CV(CB[6],1,AtLeast)},{TSetMemoryX(_Add(UnitPtr,24), SetTo, 65535*256,0xFFFFFF),TSetMemory(_Add(UnitPtr,2), SetTo, (Preset[5])*256)},1)
			CTrigger(PlayerID,{CV(CB[3],1,AtLeast)},{TSetMemory(_Add(UnitPtr,2), SetTo, (Preset[5]*256)),TSetMemoryX(_Add(UnitPtr,24), SetTo, 65535*256,0xFFFFFF)},1)
			if Preset[6] == 0 then
			CWhile(PlayerID,{CV(CB[2],1,AtLeast),TMemory(_Add(UnitPtr,2),AtMost,(Preset[5]*256)-256)})
				CIf(PlayerID,CV(CB[2],1,AtLeast))
					f_Read(PlayerID,_Add(UnitPtr,2),CB[7])
					f_Div(PlayerID,CB[7],256)
					CSub(PlayerID,CB[8],_Mov(Preset[5]),CB[7])
					CIfX(PlayerID,{TTCVar(PlayerID,CB[2][2],">",CB[8])})
					CSub(PlayerID,CB[2],CB[8])
					CDoActions(PlayerID, {TSetMemory(_Add(UnitPtr,2),SetTo,(Preset[5]*256))})
					CElseX()
					CDoActions(PlayerID, {TSetMemory(_Add(UnitPtr,2),Add,_Mul(CB[2],256))})
					CMov(PlayerID,CB[2],0)
					CIfXEnd()
				CIfEnd()
			CWhileEnd()
			end
			
			if UnitHPRetV ~= nil then
				if UnitHPRetV[4]== "V" then
				CMov(PlayerID,UnitHPRetV,CB[2])
				elseif UnitHPRetV[4]== "VA" then
				CMovX(PlayerID,UnitHPRetV,CB[2])
				else
					PushErrorMsg("CA_InputError")
				end
			end
	-------------------------------------------------------------------------
			CIfX(PlayerID,CV(CB[3],0))
				CDoActions(PlayerID,{TSetMemoryX(_Add(UnitPtr,24), SetTo, 0*256,0xFFFFFF),TSetMemoryX(_Add(UnitPtr,24), SetTo, 0*256,0xFFFFFF)})--TSetMemoryX(_Add(UnitPtr,70), SetTo, 0*256,0xFF00)
				CABossPtr = UnitPtr
				CABossPlayerID = PlayerID
				CABossDataArr = CA
				CABossTempArr = CB
				if CAfunc ~= nil then -- 패턴작성단락
					_G[CAfunc]()
				end
			CElseX({SubV(CB[3],1)})--패턴타이머 1이상일 경우 무적, 패턴작동정지
			CIfXEnd()
	-------------------------------------------------------------------------

		CElseX() -- 죽은경우
			CDoActions(PlayerID,{SetV(UnitPtr,0),SetV(CB[5],1)})
		CIfXEnd()
	CIfEnd()
	local Ret,Ret2 = CA,CB
	CABossPtr = nil
	CABossPlayerID = {}
	CABossDataArr = {}
	CABossTempArr = {}
	return Ret,Ret2
end

function VRange(Var,Left,Right)
	return {CV(Var,Left,AtLeast),CV(Var,Right,AtMost)}
	
end


function SetWeaponsDat2X(PatchTable,WepID,Property)
	local function PatchInsertLoc(PatchTrig)
		table.insert(PatchTable,PatchTrig)

	end
	if type(Property)~= "table" then
		PushErrorMsg("Property Inputdata Error")
	else
		for j,k in pairs(Property) do
			if j=="DmgBase" then
				PatchInsertLoc(SetMemoryW(0x656EB0+(WepID *2),SetTo,k)) -- 공격력
			elseif j=="DmgFactor" then
				PatchInsertLoc(SetMemoryW(0x657678+(WepID *2),SetTo,k)) -- 추가공격력
			elseif j=="Cooldown" then
				PatchInsertLoc(SetMemoryB(0x656FB8+(WepID *1),SetTo,k)) -- 공속
			elseif j=="Splash" then
				if type(k)=="boolean" then
					if k == true then
						PatchInsertLoc(SetMemoryB(0x6566F8+WepID,SetTo,3)) -- 스플타입(일방형)
					else
						PatchInsertLoc(SetMemoryB(0x6566F8+WepID,SetTo,1)) -- 스플타입(스플없음)
					end
				elseif type(k)~="table" or #k~=3 then
					PushErrorMsg("Splash Inputdata Error")
				else
					PatchInsertLoc(SetMemoryB(0x6566F8+WepID,SetTo,3)) -- 스플타입(일방형)
					PatchInsertLoc(SetMemoryW(0x656888+(WepID*2),SetTo,k[1])) --스플 안
					PatchInsertLoc(SetMemoryW(0x6570C8+(WepID*2),SetTo,k[2])) --스플 중
					PatchInsertLoc(SetMemoryW(0x657780+(WepID*2),SetTo,k[3])) --스플 밖
				end
			elseif j=="RangeMin" then
				PatchInsertLoc(SetMemory(0x656A18+(WepID *4),SetTo,k)) -- 사거리 최소
			elseif j=="RangeMax" then
				PatchInsertLoc(SetMemory(0x657470+(WepID *4),SetTo,k)) -- 사거리 최대
			elseif j=="TargetFlag" then
				PatchInsertLoc(SetMemoryW(0x657998 + (WepID*2), SetTo, k))
			elseif j=="UpgradeType" then
				PatchInsertLoc(SetMemoryB(0x6571D0 + WepID, SetTo, k))
			elseif j=="ObjectNum" then
				PatchInsertLoc(SetMemoryB(0x6564E0+WepID,SetTo,k)) -- 투사체수
			elseif j=="IconType" then
				PatchInsertLoc(SetMemoryW(0x656780+(WepID *2),SetTo,k)) -- 아이콘
			elseif j== "Behavior" then
				PatchInsertLoc(SetMemoryB(0x656670+WepID,SetTo,k))
			elseif j== "LaunchX" then
				PatchInsertLoc(SetMemoryB(0x657910+WepID,SetTo,k))
			elseif j== "LaunchY" then
				PatchInsertLoc(SetMemoryB(0x656C20+WepID,SetTo,k))
			elseif j== "LaunchSpin" then
				PatchInsertLoc(SetMemoryB(0x657888+WepID,SetTo,k))
			elseif j== "AttackAngle" then
				PatchInsertLoc(SetMemoryB(0x656990+WepID,SetTo,k))
			elseif j== "RemoveAfter" then
				PatchInsertLoc(SetMemoryB(0x657040+WepID,SetTo,k))
			elseif j== "FlingyID" then
				PatchInsertLoc(SetMemory(0x656CA8+(WepID *4),SetTo,k))
			elseif j== "WepName" then
				PatchInsertLoc(SetMemoryW(0x6572E0+(WepID *2),SetTo,k)) -- 이름
			elseif j== "DmgType" then
				PatchInsertLoc(SetMemoryB(0x657258+(WepID),SetTo,k)) -- 
				
			else
				PushErrorMsg("Wrong Property Name Detected!! : "..j)
			end
		end
	end

end



function SetUnitsDat2X(PatchTable,UnitID,Property)
	local function PatchInsertLoc(PatchTrig)
		table.insert(PatchTable,PatchTrig)

	end
	if type(UnitID) == "string" then
		UnitID = ParseUnit(UnitID) -- 스트링으로 유닛이름 입력가능
	end
	if UnitID>=228 then PushErrorMsg("UnitID Index Overflow") end
	if type(Property)~= "table" then
		PushErrorMsg("Property Inputdata Error")
	else
		for j,k in pairs(Property) do
			if j=="MinCost" then
				PatchInsertLoc(SetMemoryW(0x663888 + (UnitID *2),SetTo,k)) -- 미네랄
			elseif j=="Playerable" then
				local SType
				if type(k)=="boolean" then
					if k == true then
						SType=1
					else
						SType=0
					end
				else
					SType=k
				end
				PatchInsertLoc(SetMemoryB(0x57F27C + (0 * 228) + UnitID,SetTo,SType))
				PatchInsertLoc(SetMemoryB(0x57F27C + (1 * 228) + UnitID,SetTo,SType))
				PatchInsertLoc(SetMemoryB(0x57F27C + (2 * 228) + UnitID,SetTo,SType))
				PatchInsertLoc(SetMemoryB(0x57F27C + (3 * 228) + UnitID,SetTo,SType))
				PatchInsertLoc(SetMemoryB(0x57F27C + (4 * 228) + UnitID,SetTo,SType))
				PatchInsertLoc(SetMemoryB(0x57F27C + (5 * 228) + UnitID,SetTo,SType))
				PatchInsertLoc(SetMemoryB(0x57F27C + (6 * 228) + UnitID,SetTo,SType))
				PatchInsertLoc(SetMemoryB(0x57F27C + (7 * 228) + UnitID,SetTo,SType))
			elseif j=="GasCost"  then
				PatchInsertLoc(SetMemoryW(0x65FD00 + (UnitID *2),SetTo,k)) -- 가스
			elseif j=="BuildTime"  then
				PatchInsertLoc(SetMemoryW(0x660428 + (UnitID *2),SetTo,k)) -- 생산속도
			elseif j=="SuppCost"  then
				PatchInsertLoc(SetMemoryB(0x663CE8 + UnitID,SetTo,k*2)) -- 서플
			elseif j=="HP"  then
				PatchInsertLoc(SetMemory(0x662350 + (UnitID*4),SetTo,k*256))
			elseif j=="Shield"  then
				if type(k)=="boolean" then
					if k == true then
						PatchInsertLoc(SetMemoryB(0x6647B0 + UnitID,SetTo,1))
					else
						PatchInsertLoc(SetMemoryB(0x6647B0 + UnitID,SetTo,0))
						PatchInsertLoc(SetMemoryW(0x660E00 + (UnitID *2), SetTo, 0))
					end
				else
					PatchInsertLoc(SetMemoryB(0x6647B0 + UnitID,SetTo,1))
					PatchInsertLoc(SetMemoryW(0x660E00 + (UnitID *2), SetTo, k))
				end
			elseif j=="Armor" then
				PatchInsertLoc(SetMemoryB(0x65FEC8 + (UnitID),SetTo,k)) -- 방어력
			elseif j=="GroupFlag" then
				PatchInsertLoc(SetMemoryB(0x6637A0 + (UnitID),SetTo,k)) -- 그룹
			elseif j=="Height" then
				PatchInsertLoc(SetMemoryB(0x663150 + (UnitID),SetTo,k)) -- 건설크기
			elseif j=="BdDimX" then
				PatchInsertLoc(SetMemoryX(0x662860 + (UnitID*4),SetTo,k,0xFFFF)) -- 건설크기
			elseif j=="BdDimY" then
				PatchInsertLoc(SetMemoryX(0x662860 + (UnitID*4),SetTo,k*65536,0xFFFF0000)) -- 건설크기
			elseif j=="SizeL" then
				PatchInsertLoc(SetMemoryX(0x6617C8 + (UnitID*8),SetTo,(k),0xFFFF))
			elseif j=="SizeU" then
				PatchInsertLoc(SetMemoryX(0x6617C8 + (UnitID*8),SetTo,(k*65536),0xFFFF0000))
			elseif j=="SizeR" then
				PatchInsertLoc(SetMemoryX(0x6617CC + (UnitID*8),SetTo,(k),0xFFFF))
			elseif j=="SizeD" then
				PatchInsertLoc(SetMemoryX(0x6617CC + (UnitID*8),SetTo,(k*65536),0xFFFF0000))
			elseif j=="SuppProv" then
				PatchInsertLoc(SetMemoryB(0x6646C8+UnitID,SetTo,Property.SuppProv)) -- 서플공급량
			elseif j=="AdvFlag" then
				if type(k)~= "table" or #k~=2 then
					PushErrorMsg("AdvFlag Inputdata Error")
				end
				PatchInsertLoc(SetMemoryX(0x664080 + (UnitID*4),SetTo,k[1],k[2]))
			elseif j=="DefType" then
				PatchInsertLoc(SetMemoryB(0x662180 + UnitID,SetTo,k))
			elseif j=="DefUpType" then
				PatchInsertLoc(SetMemoryB(0x6635D0 + UnitID,SetTo,k))
			elseif j=="StarEditFlag"  then
				PatchInsertLoc(SetMemoryW(0x661518+(UnitID*2),SetTo,k))
			elseif j=="Class"  then
				PatchInsertLoc(SetMemoryB(0x663DD0+(UnitID),SetTo,k))

			elseif j=="AirWeapon"  then
				PatchInsertLoc(SetMemoryB(0x6616E0+UnitID,SetTo,k))
			elseif j=="GroundWeapon"  then
				PatchInsertLoc(SetMemoryB(0x6636B8+UnitID,SetTo,k))
				
			elseif j=="SpaceProv"  then
				PatchInsertLoc(SetMemoryB(0x660988+(UnitID*1),SetTo,k))
			elseif j=="SpaceReq"  then
			PatchInsertLoc(SetMemoryB(0x664410+(UnitID*1),SetTo,k))
			elseif j=="RClickAct" then
				PatchInsertLoc(SetMemoryB(0x662098+UnitID,SetTo,k))--RClickAct
			elseif j=="HumanInitAct" then
				PatchInsertLoc(SetMemoryB(0x662268+UnitID,SetTo,k))--HumanInitAct
			elseif j=="ComputerInitAct" then
				PatchInsertLoc(SetMemoryB(0x662EA0+UnitID,SetTo,k))--ComputerInitAct
			elseif j=="AttackOrder" then
				PatchInsertLoc(SetMemoryB(0x663320+UnitID,SetTo,k))--AttackOrder
			elseif j=="AttackMoveOrder" then
				PatchInsertLoc(SetMemoryB(0x663A50+UnitID,SetTo,k))--AttackMoveOrder
			elseif j=="IdleOrder" then
				PatchInsertLoc(SetMemoryB(0x664898+UnitID,SetTo,k))--IdleOrder
			elseif j=="RdySnd" then
				PatchInsertLoc(SetMemoryW(0x661FC0+(UnitID*2),SetTo,k))
			elseif j=="WhatSndInit" then
				PatchInsertLoc(SetMemoryW(0x662BF0+(UnitID*2),SetTo,k))
			elseif j=="WhatSndEnd" then
				PatchInsertLoc(SetMemoryW(0x65FFB0+(UnitID*2),SetTo,k))
			elseif j=="YesInit" then
				if UnitID>=106 then PushErrorMsg("UnitID Index Overflow") end
				PatchInsertLoc(SetMemoryW(0x663C10+(UnitID*2),SetTo,k))
			elseif j=="YesEnd" then
				if UnitID>=106 then PushErrorMsg("UnitID Index Overflow") end
				PatchInsertLoc(SetMemoryW(0x661440+(UnitID*2),SetTo,k))
			elseif j=="PissedInit" then
				if UnitID>=106 then PushErrorMsg("UnitID Index Overflow") end
				PatchInsertLoc(SetMemoryW(0x663B38+(UnitID*2),SetTo,k))
			elseif j=="PissedEnd" then
				if UnitID>=106 then PushErrorMsg("UnitID Index Overflow") end
				PatchInsertLoc(SetMemoryW(0x661EE8+(UnitID*2),SetTo,k))
			elseif j=="Reqptr" then
				PatchInsertPrsv(SetMemoryW(0x660A70+(UnitID*2), SetTo, k))
			elseif j== "SeekRange" then
				PatchInsertLoc(SetMemoryB(0x662DB8+UnitID,SetTo,k)) -- SeekRange
			elseif j== "Graphic" then
				PatchInsertLoc(SetMemoryB(0x6644F8+UnitID,SetTo,k)) -- Graphic
			elseif j== "BuildScore" then
				PatchInsertLoc(SetMemoryW(0x663408+(UnitID *2),SetTo,k))--BuildScore
			elseif j== "KillScore" then
				PatchInsertLoc(SetMemoryW(0x663EB8+(UnitID *2),SetTo,k))--KillScore
			else
				PushErrorMsg("Wrong Property Name Detected!! : "..j)
			end
			
		end
	end
end


LabelUseArr = {}

function CtrigX(Player,Index,Address,Next,Type,Value,Mask)
	if Player == "X" then 
		Player = nil
	end
	if Index == "X" then 
		Index = nil
	end
	if Next == "X" then 
		Next = nil
	end
	if Mask == "X" then 
		Mask = nil
	end
	if Index ~= nil and LabelUseArr[Index]==nil then
		LabelUseArr[Index] = true
	end


	local Pflag
	if Player == nil then
		Pflag = 0
	else
		if Player >= 0 and Player <= 7 then
			Pflag = Player + 1
		else
			Pflag = 0
		end
	end

	local Mflag
	if Mask == nil then
		Mflag = 0
		Mask = 0
	else
		--Mflag = 32 (Rflag)
		Mflag = 0x80
	end

	local Nflag
	if Next == 0 or Next == nil then
		Nflag = 0
	elseif Next == 1 then 
		Nflag = 16
	else
		Nflag = 0
		Address = Address + 0x970*Next
	end

	local Cflag
	if Index == nil then
		Index = 0
		Cflag = 64
	else
		Cflag = 0
	end

	local Xflag = 0
	if Index >= 0x10000 then
		Index = Index - 0x10000
		Xflag = 128
	end

	local Rflag
	Rflag = Pflag + Nflag + Cflag + Xflag

	local ExCtrigX = Condition(Mask,Address/4,Value,Index,Type,0xFF,Rflag,0x10+Mflag) -- #DefCond
	return ExCtrigX
end

function SetCtrigX(Player1,Index1,Address1,Next1,Type,Player2,Index2,Address2,EPD2,Next2,Mask)
	if Player1 == "X" then 
		Player1 = nil
	end
	if Index1 == "X" then 
		Index1 = nil
	end
	if Next1 == "X" then 
		Next1 = nil
	end
	if Player2 == "X" then 
		Player2 = nil
	end
	if Index2 == "X" then 
		Index2 = nil
	end
	if Next2 == "X" then 
		Next2 = nil
	end
	if EPD2 == "X" then
		EPD2 = nil
	end
	if Mask == "X" then 
		Mask = nil
	end

	if Index1~=nil and LabelUseArr[Index1]==nil then
		LabelUseArr[Index1] = true
	end
	if Index2~=nil and LabelUseArr[Index2]==nil then
		LabelUseArr[Index2] = true
	end

	local Pflag1
	if Player1 == nil then
		Pflag1 = 0
	else
		if Player1 >= 0 and Player1 <= 7 then
			Pflag1 = Player1 + 1
		else
			Pflag1 = 0
		end
	end

	local Nflag1
	if Next1 == 0 or Next1 == nil then
		Nflag1 = 0
	elseif Next1 == 1 then 
		Nflag1 = 16
	else
		Nflag1 = 0
		Address1 = Address1 + 0x970*Next1
	end

	local Cflag1
	if Index1 == nil then
		Index1 = 0
		Cflag1 = 32
	else
		Cflag1 = 0
	end

	local Xflag1 = 0
	if Index1 >= 0x10000 then
		Index1 = Index1 - 0x10000
		Xflag1 = 64
	end

	local Pflag2
	if Player2 == nil then
		Pflag2 = 0
	else
		if Player2 >= 0 and Player2 <= 7 then
			Pflag2 = Player2 + 1
		else
			Pflag2 = 0
		end
	end

	local Nflag2
	if Next2 == 0 or Next2 == nil then
		Nflag2 = 0
	elseif Next2 == 1 then 
		Nflag2 = 16
	else
		Nflag2 = 0
		Address2 = Address2 + 0x970*Next2
	end

	local Mflag2
	if Mask == nil then
		Mflag2 = 0
		Mask = 0
	else
		--Mflag2 = 64 (Rflag2)
		Mflag2 = 0x80
	end

	local Addr2
	if EPD2 == 0 or EPD2 == nil then
		Addr2 = Address2
		Eflag2 = 0
	else
		Addr2 = Address2/4
		Eflag2 = 32
	end

	local Cflag2
	if Index2 == nil then
		Index2 = 0
		Cflag2 = 128
	else
		Cflag2 = 0
	end

	local Xflag2 = 0
	if Index2 >= 0x10000 then
		Index2 = Index2 - 0x10000
		Xflag2 = 128
	end

	local Rflag1
	Rflag1 = Pflag1 + Nflag1 + Cflag1 + Xflag1 + Xflag2
	local Rflag2
	Rflag2 = Pflag2 + Nflag2 + Eflag2 + Cflag2

	local ExSetCtrigX = Action(Mask,Index1,Rflag1,Rflag2,Address1/4,Addr2,Index2,0x5,Type,0x14+Mflag2) -- #DefAct (PauseGame = 0x5)
	return ExSetCtrigX
end

function SetCtrig1X(Player1,Index1,Address1,Next1,Type,Value,Mask)
	if Player1 == "X" then 
		Player1 = nil
	end
	if Index1 == "X" then 
		Index1 = nil
	end
	if Index1 ~= nil and LabelUseArr[Index1]==nil then
		LabelUseArr[Index1] = true
	end
	if Next1 == "X" then 
		Next1 = nil
	end
	if Mask == "X" then 
		Mask = nil
	end

	local Pflag1
	if Player1 == nil then
		Pflag1 = 0
	else
		if Player1 >= 0 and Player1 <= 7 then
			Pflag1 = Player1 + 1
		else
			Pflag1 = 0
		end
	end

	local Nflag1
	if Next1 == 0 or Next1 == nil then
		Nflag1 = 0
	elseif Next1 == 1 then 
		Nflag1 = 16
	else
		Nflag1 = 0
		Address1 = Address1 + 0x970*Next1
	end

	local Cflag1
	if Index1 == nil then
		Index1 = 0
		Cflag1 = 32
	else
		Cflag1 = 0
	end

	local Xflag1 = 0
	if Index1 >= 0x10000 then
		Index1 = Index1 - 0x10000
		Xflag1 = 64
	end

	local Rflag1
	Rflag1 = Pflag1 + Nflag1 + Cflag1 + Xflag1

	local Mflag2
	if Mask == nil then
		Mflag2 = 0
		Mask = 0
	else
		--Mflag2 = 64 (Rflag2)
		Mflag2 = 0x80
	end

	local ExSetCtrig1X = Action(Mask,Index1,Rflag1,0,Address1/4,Value,0,0x5,Type,0x14+Mflag2) -- (PauseGame = 0x5)
	return ExSetCtrig1X
end

function SetCtrig2X(Offset,Type,Player2,Index2,Address2,EPD2,Next2,Mask)
	if Player2 == "X" then 
		Player2 = nil
	end
	if Index2 == "X" then 
		Index2 = nil
	end
	if Next2 == "X" then 
		Next2 = nil
	end
	if EPD2 == "X" then
		EPD2 = nil
	end
	if Mask == "X" then 
		Mask = nil
	end
	if Index2 ~=nil and LabelUseArr[Index2]==nil then
		LabelUseArr[Index2] = true
	end

	local Pflag2
	if Player2 == nil then
		Pflag2 = 0
	else
		if Player2 >= 0 and Player2 <= 7 then
			Pflag2 = Player2 + 1
		else
			Pflag2 = 0
		end
	end

	local Nflag2
	if Next2 == 0 or Next2 == nil then
		Nflag2 = 0
	elseif Next2 == 1 then 
		Nflag2 = 16
	else
		Nflag2 = 0
		Address2 = Address2 + 0x970*Next2
	end

	local Mflag2
	if Mask == nil then
		Mflag2 = 0
		Mask = 0
	else
		--Mflag2 = 64 (Rflag2)
		Mflag2 = 0x80
	end

	local Addr2
	if EPD2 == 0 or EPD2 == nil then
		Addr2 = Address2
		Eflag2 = 0
	else
		Addr2 = Address2/4
		Eflag2 = 32
	end

	local Cflag2
	if Index2 == nil then
		Index2 = 0
		Cflag2 = 128
	else
		Cflag2 = 0
	end

	local Xflag2 = 0
	if Index2 >= 0x10000 then
		Index2 = Index2 - 0x10000
		Xflag2 = 128
	end

	local Rflag1
	Rflag1 = Xflag2
	local Rflag2
	Rflag2 = Pflag2 + Nflag2 + Eflag2 + Cflag2

	local Offset2
	if Offset == "Cp" then
		Offset2 = 13
	else
		Offset2 = EPD(Offset)
	end

	local ExSetCtrig2X = Action(Mask,0,Rflag1,Rflag2,Offset2,Addr2,Index2,0x5,Type,0x14+Mflag2) -- (PauseGame = 0x5)
	return ExSetCtrig2X
end


function LabelUseCheck() -- Label 사용 체크
	local C = {}
	for k,v in pairs(LabelArr) do
		if v ~= 0xFFE0 then
			if not C[v] then
				C[v] = true
			end
		else
			Prohibited_Label()
		end
	end
	for k, v in pairs(LabelUseArr) do
		if k~=nil and C[k]== nil then
			_G["Undefined Label! Current Label : 0x"..string.format("%X",k)]() -- push error msg
		end
		
	end
end
