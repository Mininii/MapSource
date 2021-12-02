
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
	Call_CPosXY = SetCallForward()
	SetCall(Player)
	CMov(Player,CPosX,CPos,0,0XFFFF)
	CMov(Player,CPosY,CPos,0,0XFFFF0000)
	f_Div(Player,CPosY,_Mov(0x10000))
	SetCallEnd()
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



function Install_CallTriggers()
	f_Replace = SetCallForward()
	SetCall(FP)
		CIfX(FP,Memory(0x628438,AtLeast,1)) -- 캔낫체크.
		f_SaveCp()
		CMov(FP,Gun_LV,0)
		f_Read(FP,BackupCP,CPos)
		Convert_CPosXY()
		f_Read(FP,_Add(BackupCP,1),Gun_LV,"X",0xFF000000)
		f_Read(FP,_Add(BackupCP,1),RepHeroIndex,"X",0xFF)
		f_Div(FP,Gun_LV,_Mov(0x1000000)) -- 1
		f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
		
		CMov(FP,CunitP,4)
		CIf(FP,CDeaths(FP,Exactly,1,CurPlace))
			CNeg(FP,CPosX)
			CAdd(FP,CPosX,4096)
			CMov(FP,CunitP,5)
		CIfEnd()
		CIf(FP,CDeaths(FP,Exactly,2,CurPlace))
			CNeg(FP,CPosY)
			CAdd(FP,CPosY,4096)
			CMov(FP,CunitP,6)
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,41)},{SetCVar(FP,CPosY[2],Add,64)},{Preserved})
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,176)},{SetCVar(FP,CPosY[2],Add,64)},{Preserved})
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,177)},{SetCVar(FP,CPosY[2],Add,64)},{Preserved})
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,178)},{SetCVar(FP,CPosY[2],Add,64)},{Preserved})
		CIfEnd()
		CIf(FP,CDeaths(FP,Exactly,3,CurPlace))
			CNeg(FP,CPosX)
			CAdd(FP,CPosX,4096)
			CNeg(FP,CPosY)
			CAdd(FP,CPosY,4096)
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,41)},{SetCVar(FP,CPosY[2],Add,64)},{Preserved})
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,176)},{SetCVar(FP,CPosY[2],Add,64)},{Preserved})
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,177)},{SetCVar(FP,CPosY[2],Add,64)},{Preserved})
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,178)},{SetCVar(FP,CPosY[2],Add,64)},{Preserved})
			CMov(FP,CunitP,7)
		CIfEnd()

		CMov(FP,CunitIndex,_Div(_Sub(Nextptrs,19025),_Mov(84)))
		CDoActions(FP,{
		TSetMemory(0x58DC60 + 0x14*0,SetTo,_Sub(CPosX,18)),
		TSetMemory(0x58DC68 + 0x14*0,SetTo,_Add(CPosX,18)),
		TSetMemory(0x58DC64 + 0x14*0,SetTo,_Sub(CPosY,18)),
		TSetMemory(0x58DC6C + 0x14*0,SetTo,_Add(CPosY,18)),
		})
		CDoActions(FP,{
			TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(CC_Header,((0x20*8)/4))),SetTo,1), -- 확장 구조오프셋 변수에 값 입력
			TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),CC_Header),SetTo,Gun_LV), -- 확장 구조오프셋 변수에 값 입력
			TCreateUnitWithProperties(1, RepHeroIndex, 1, CunitP,{energy = 100})})
		CTrigger(FP,{TMemoryX(_Add(BackupCP,1),Exactly,0x10000,0x10000)},{TSetMemoryX(_Add(Nextptrs,55),SetTo,0x04000000,0x04000000)},1) -- 무적플래그 1일경우 무적상태로 바꿈
		f_LoadCp()
		CElseX()
		DoActions(FP,{RotatePlayer({DisplayTextX(f_ReplaceErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
		CIfXEnd()
	SetCallEnd()
end

function install_UnitCount(Player)
	count,count1,count2,count3 = CreateVars(4,FP)
	function Cast_UnitCount()
		UnitReadX(Player,AllPlayers,229,64,count)
		UnitReadX(Player,AllPlayers,17,64,count1)
		UnitReadX(Player,AllPlayers,23,64,count2)
		UnitReadX(Player,AllPlayers,25,64,count3)
		CAdd(Player,count,count1)
		CAdd(Player,count,count2)
		CAdd(Player,count,count3)
	end
end