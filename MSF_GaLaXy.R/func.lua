
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
function f_SaveCp()
	CallTrigger(FP,SaveCp_CallIndex,nil)
end
function f_LoadCp()
	CallTrigger(FP,LoadCp_CallIndex,nil)
end

function Convert_CPosXY(Value)
	if Value ~= nil then
	CDoActions(FP,{
		TSetCVar(FP,CPos[2],SetTo,Value),
		SetNext("X",Call_CPosXY,0),SetNext(Call_CPosXY+1,"X",1)
	})
	else
		CallTrigger(FP,Call_CPosXY)
	end
	return CPosX,CPosY
end

function Include_CRandNum(Player)
	TempRandRet = CreateVar(Player)
	Oprnd = CreateVar(Player)
	InputMaxRand = CreateVar(Player)
	function f_CRandNum(Max,Operand,Condition)
		if Operand == nil then Operand = 0 end
		local RandRet = TempRandRet
		CallTriggerX(Player,CRandNum,Condition,{SetCVar(Player,InputMaxRand[2],SetTo,Max),SetCVar(Player,Oprnd[2],SetTo,Operand)})
		return RandRet
	end
CRandNum = SetCallForward()
SetCall(Player)
f_Rand(Player,TempRandRet)
f_Mod(Player,TempRandRet,InputMaxRand)
CAdd(Player,TempRandRet,Oprnd)
SetCallEnd()
end
function Gun_SetLineX(Line,Type,Value)
	return TSetMemory(_Add(G_TempH,_Mul(Line,_Mov(0x20/4))),Type,Value)
end

