
function StrDesign(Str)
	return "\x07·\x11·\x08·\x07【 "..Str.." \x07】\x08·\x11·\x07·"
end
function StrDesignX(Str)
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
function Install_EXCC(Player,Index,ArrSize)
	EXCC_Forward = Index
	CurCunitI = CreateVar(Player)
	CC_Header = CreateVar(Player)
	EXCunitTemp = CreateVarArr(ArrSize,Player)
    EXCunit_Reset = {}
    for i = 1, #EXCunitTemp do
        table.insert(EXCunit_Reset,SetCtrig1X("X","X",CAddr("Value",i-1,0),0,SetTo,0))
    end
    --[[
    EXCunit 적용
    1번줄 : 건작의 레벨
    9번줄 : 영작유닛 표식
    10번줄 : 마린 데스값 중복적용 방지용
    ]]
	function CunitCtrig_Part4_EX(LoopIndex,Conditions,Actions,ExCunitArr)
		MoveCpValue = 0
		local X = {}
		for k, v in pairs(ExCunitArr) do
			table.insert(X,SetCVar("X",v[2],SetTo,0))
		end
		Trigger { -- Cunit Calc Main
			players = {ParsePlayer(PlayerID)},
			conditions = { 
				Label(0);
				Conditions,
			},
			actions = {
				X,
				SetCtrigX("X","X",0x4,0,SetTo,"X",CCArr[CCptr],0,0,0);
				SetCtrigX("X",CCArr[CCptr]+1,0x4,0,SetTo,"X","X",0,0,1);
				SetCtrigX("X",CCArr[CCptr],0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",CCArr[CCptr],0x15C,0,SetTo,"X","X",0,0,1);
				SetMemory(0x6509B0,SetTo,19025 + 84 * LoopIndex);
				Actions,
				},
			flag = {Preserved}
		}		
	end
	function Cast_EXCC()
		CunitCtrig_Part2()
		DoActionsXI(Player,EXCC_Forward)
		CunitCtrig_Part3X()
		for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
			CunitCtrig_Part4_EX(i,{
			DeathsX(19025+(84*i)+40,AtLeast,1*16777216,0,0xFF000000),
			DeathsX(19025+(84*i)+19,Exactly,0*256,0,0xFF00),
			},
			{SetDeathsX(19025+(84*i)+40,SetTo,0*16777216,0,0xFF000000),
			SetCVar(Player,CurCunitI[2],SetTo,i),EXCunit_Reset,
			MoveCp(Add,25*4),
			},EXCunitTemp)
		end
		CunitCtrig_End()
	end

end

function Include_Conv_CPosXY(Player)
	CPos,CPosX,CPosY = CreateVars(3,Player)
	Call_CPosXY = SetCallForward()
	SetCall(Player)
	CMov(Player,CPosX,CPos,0,0XFFFF)
	CMov(Player,CPosY,CPos,0,0XFFFF0000)
	f_Div(Player,CPosY,_Mov(0x10000))
	SetCallEnd()
	function Convert_CPosXY(Value)
		if Value ~= nil then
			CDoActions(Player,{
				TSetCVar(Player,CPos[2],SetTo,Value),
				SetNext("X",Call_CPosXY,0),SetNext(Call_CPosXY+1,"X",1)
			})
		else
			CallTrigger(Player,Call_CPosXY)
		end
		return CPosX,CPosY
	end
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
		UnitReadX(Player,AllPlayers,229,64,count)
		UnitReadX(Player,AllPlayers,17,nil,count1)
		UnitReadX(Player,AllPlayers,23,nil,count2)
		UnitReadX(Player,AllPlayers,25,nil,count3)
		CAdd(Player,count,count1)
		CAdd(Player,count,count2)
		CAdd(Player,count,count3)
	end
end


function UnitLimit(Player,UID,Limit,Text,ReturnResources)
	Trigger {
		players = {Player},
		conditions = {
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


function IBGM_EPDX(Player,MaxPlayer,MSQC_Recives,Option_NT)
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
			OPtion_NT_InputData_Error()
		end
	end


	for i = 0, MaxPlayer do
		CTrigger(Player,{PlayerCheck(i,1)},{TSetDeathsX(i,Subtract,MSQC_Recives,12,0xFFFFFF)},1) -- 브금타이머
	end
	CDoActions(Player,{TSetDeathsX(Player,Subtract,MSQC_Recives,12,0xFFFFFF),SetDeathsX(Player,SetTo,0,12,0xFF000000)}) -- 브금타이머
end