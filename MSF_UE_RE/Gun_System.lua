function Gun_System()


	--[[
	EXCunit ����
	1���� : ������ ����
	9���� : �������� ǥ��
	10���� : ���� ������ �ߺ����� ������
	]]
	EXCC_Part1(DUnitCalc)
	--CunitCtrig_Part1(FP) -- �������� �ν� �ܶ� ����
	DoActions(FP,MoveCp(Subtract,6*4))
	Check_P8 = def_sIndex()
	NJump(FP,Check_P8,DeathsX(CurrentPlayer,Exactly,7,0,0xFF))
	DoActions(FP,MoveCp(Add,6*4))
	Install_DeathNotice()
	EXCC_ClearCalc()
	--ClearCalc()

	NJumpEnd(FP,Check_P8)
	DoActions(FP,MoveCp(Add,6*4))
	CIf(FP,Cond_EXCC(8,AtLeast,1)) -- ���������ν�
	f_SaveCp()
	InstallHeroPoint()
	CIfEnd()
	CMov(FP,Gun_Type,0)
	CIf(FP,{CVar(FP,LevelT[2],AtMost,3)})
	for j, k in pairs({142,135,140,141,138,139,137}) do -- ����� ���
		f_GSend(k,{SetCVar(FP,Gun_Type[2],SetTo,256)}) -- GunType = ����� �÷���
	end
	CIfEnd()

	f_GSend(131)
	f_GSend(132)
	f_GSend(133)
	f_GSend(130)
	f_GSend(151)
	f_GSend(201)
	f_GSend(148)
	f_GSend(173)
	f_GSend(152)
	CIf(FP,{DeathsX(CurrentPlayer,Exactly,193,0,0xFF)}) -- ��ũ��ĭ ��������Ʈ
		f_SaveCp()
		f_Read(FP,_Sub(BackupCp,15),CPos)
		Convert_CPosXY()
		CreateBullet(205,20,0,CPosX,CPosY)
		CreateBullet(206,20,0,CPosX,CPosY)
		CSPlot(CSMakePolygon(8,64,0,PlotSizeCalc(2,6),1),FP,63,0,nil,1,32,FP,nil,nil,1)
		DoActions(FP,{KillUnit(63,FP)})
		f_LoadCp()
	CIfEnd()

	if TestStart == 1 then
		--f_GSend(146)
		--f_GSend(136)
	end



	EXCC_ClearCalc()
	EXCC_Part2()
	--CunitCtrig_Part2()
	--DoActionsXI(FP,EXCC_Forward)
	EXCC_Part3X()
	--CunitCtrig_Part3X()
	for i = 0, 1699 do -- Part4X �� Cunit Loop (x1700)
	EXCC_Part4X(i,{
	DeathsX(19025+(84*i)+40,AtLeast,1*16777216,0,0xFF000000),
	DeathsX(19025+(84*i)+19,Exactly,0*256,0,0xFF00),
	},
	{SetDeathsX(19025+(84*i)+40,SetTo,0*16777216,0,0xFF000000),
	SetCVar(FP,CurCunitI[2],SetTo,i),
	MoveCp(Add,25*4),
	})--
	end
	EXCC_End()




	
	
	EXCC_Part1(LHPCunit)
	f_SaveCp()
	local ReadHP = CreateVar(FP)
	local TempV1 = CreateVar(FP)
	local TempV2 = CreateVar(FP)
	local TempW = CreateWar(FP)
	local TempW2 = CreateWar(FP)
	local TempW3 = CreateWar(FP)
	local TempW4 = CreateWar(FP)
	local TempW5 = CreateWar(FP)
	local VoidV = CreateVar(FP)

	
	f_Read(FP, BackupCp, ReadHP)

	f_LMov(FP, TempW, {EXCC_TempVarArr[2],EXCC_TempVarArr[3]}, nil, nil, 1)
	f_LMov(FP, TempW2, {ReadHP,VoidV}, nil, nil, 1)


	f_LAdd(FP, TempW3, TempW, TempW2)
	
	CIfX(FP, {TTCWar(FP, TempW3[2], AtLeast, tostring(8320000*256))})
	
		f_LSub(FP, TempW4, _LMov(tostring(8320000*256)), TempW2)
		f_LSub(FP, TempW5, TempW, TempW4)


		f_LMov(FP, {EXCC_TempVarArr[2],EXCC_TempVarArr[3]},TempW5, nil, nil, 1)
	CDoActions(FP, {
		TSetMemory(BackupCp, SetTo, 8320000*256),
		Set_EXCCX(0, SetTo, 1),
		Set_EXCCX(1, SetTo, EXCC_TempVarArr[2]),
		Set_EXCCX(2, SetTo, EXCC_TempVarArr[3]),
	})
	CElseX()
		f_LMov(FP, {TempV1,TempV2}, TempW, nil, nil, 1)
		CDoActions(FP, {
			TSetMemory(BackupCp, Add, TempV1),
			Set_EXCCX(0, SetTo, 0),
			Set_EXCCX(1, SetTo, 0),
			Set_EXCCX(2, SetTo, 0),
		})
	CIfXEnd()
	

	f_LoadCp()
	EXCC_ClearCalc()
	EXCC_Part2()
	EXCC_Part3X()
	
	for i = 0, 1699 do -- Part4X �� Cunit Loop (x1700)
	EXCC_Part4X(i,{
		
		CVar("X", "X", AtLeast, 1);
		Deaths(19025+(84*i)+2,AtMost,(8320000*256)-256,0),
		DeathsX(19025+(84*i)+19,AtLeast,1*256,0,0xFF00),
		DeathsX(19025+(84*i)+19,AtLeast,7,0,0xFF00),
	},
	{
		SetCVar(FP,CurCunitI[2],SetTo,i),
		SetCVar(FP, BackupCp[2], SetTo, 19025+(84*i)+2);
		MoveCp(Add,2*4),
	})--
	end
	EXCC_End()

	
	MarSkill = def_sIndex()
	MarSkillP = CreateVar(FP)
	CJump(FP,MarSkill)
    CallMarSkill = SetCallForward()
    SetCall(FP)
    f_SaveCp()
    
    --19
	for i = 1,7 do
		CTrigger(FP,{CV(MarSkillP,i-1)},{TSetMemory(_Add(MarSkillTimerArr,MarSkillTimerPtr),SetTo,MSkillCool[i])},1)
	
	end
    f_Read(FP,_Sub(BackupCp,9),CPos)
    Convert_CPosXY()
    Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
        CIf(FP,Memory(0x628438,AtLeast,1))
        f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
        CDoActions(FP,{
            TCreateUnit(1,179,1,MarSkillP),
            TSetDeathsX(_Add(Nextptrs,8),SetTo,127*65536,0,0xFF0000),
            TSetDeathsX(_Add(Nextptrs,19),SetTo,152*256,0,0xFF00),
            TSetDeaths(_Add(Nextptrs,22),SetTo,1536+(3072*65536),0),
            TSetDeathsX(_Add(Nextptrs,21),SetTo,0,0,0xFF),
            TSetDeathsX(_Add(Nextptrs,21),SetTo,0,1,0xFF00),
        })
        CIfEnd()

    f_LoadCp()
    SetCallEnd()
    CJumpEnd(FP,MarSkill)
	

CunitCtrig_Part1(FP)


MJ = def_sIndexArr(7)
SkillUnit = def_sIndex()
NJumpX(FP,SkillUnit,{DeathsX(CurrentPlayer,Exactly,179,0,0xFF)},{})

for i = 1, 7 do
	NJump(FP, MJ[i], DeathsX(CurrentPlayer,Exactly,MarID[i],0,0xFF),{SetMemory(0x6509B0, Subtract, 4),SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF),
	SetDeathsX(CurrentPlayer,SetTo,0,1,0xFF00),})
end
ClearCalc()
for i = 1, 7 do
	NJumpEnd(FP, MJ[i])



--21���� 33���� �̵��Ͽ� ��Ž 1ƽ ������ ����
	--DoActions(FP, {SetMemory(0x6509B0, Add, 12),SetDeathsX(CurrentPlayer, Subtract, 1, 0, 0xFFFF),SetMemory(0x6509B0, Subtract, 12)})
	CDoActions(FP, {TSetMemory(_Add(MarSkillTimerArr,MarSkillTimerPtr),Subtract,1)})
	BreakCalc({DeathsX(CurrentPlayer,AtMost,18*256,0,0xFF00),DeathsX(CurrentPlayer,AtMost,18*65536,0,0xFF0000)})
	
	CSub(FP,0x6509B0,2)
	CIf(FP,{TTOR({DeathsX(CurrentPlayer,Exactly,10*256,0,0xFF00),DeathsX(CurrentPlayer,Exactly,107*256,0,0xFF00),DeathsX(CurrentPlayer,Exactly,5*256,0,0xFF00)})})--����, Ȧ��, �κ�Ŀ üũ
		CAdd(FP,0x6509B0,4)
		CIf(FP,{Deaths(CurrentPlayer,AtLeast,1,0)})--��� ���� üũ

			CIf(FP,{CV(MSkillP[i],1,AtLeast),Memory(0x628438,AtLeast,1),TMemory(_Add(MarSkillTimerArr,MarSkillTimerPtr),AtMost,0),Bring(FP, AtLeast, 1, 147, 64)},{SetV(MarSkillP,i-1)})--��Ÿ��,ĵ�� üũ
			CSub(FP,0x6509B0,4)
			CallTrigger(FP,CallMarSkill)
			CAdd(FP,0x6509B0,4)
			CIfEnd()

			CIf(FP,{CD(roka7Chk,1)})--roka7���� ���� ��� �ߵ���
			local TargetPtr = CreateVar(FP)
				f_SaveCp()
				f_Read(FP,BackupCp,nil,TargetPtr)
				CTrigger(FP,{
					TMemoryX(_Add(TargetPtr,25),Exactly,ParseUnit("����+��roka7��+.������+��roka7��+.��     "),0xFF)},{
						TSetMemory(_Sub(BackupCp,21),Subtract,AtkMirrorV[i])},1) -- �����ϴ� ����� ��ī�� ��� ������ ���� ��������ŭ ������ ���ظ� ����
						if Limit == 1 then -- ��ġ ����͸��� �׽�Ʈ �ڵ�
							CIf(FP,{CD(TestMode,1)})
							local TempV = CreateVar(FP)
							f_Div(FP,TempV,AtkMirrorV[i],256)
							DisplayPrint(i-1,{"AtkMirrorV : ", AtkMirrorV[i],"   /256 : ",TempV})
							CIfEnd()
						end
				CTrigger(FP,{
					TMemory(_Sub(BackupCp,21),Exactly,0)},{
						TSetMemoryX(_Sub(BackupCp,4),SetTo,0,0xFF00)},1) -- ������ �ǰ� 0�� ��� ���� ����(�� Ʈ���Ű� ���� ��� ������ �ڵ����� ���� �ʰ� ���� ���°� ��)
				f_LoadCp()
				
			CIfEnd()

			
		CIfEnd()
		CSub(FP,0x6509B0,4)
	CIfEnd()
	CAdd(FP,0x6509B0,2)
	


	CDoActions(FP,{TSetDeathsX(CurrentPlayer, SetTo, MCoolDown[i], 0, 0xFFFF00),SetMemory(0x6509B0, Add, 48)})
	TriggerX(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00)},{SetMemory(0x6509B0, Subtract, 48),SetDeathsX(CurrentPlayer, Subtract, (5*256)+(5*65536), 0, 0xFFFF00)},{preserved})
	
	
	ClearCalc()
end

NJumpXEnd(FP,SkillUnit)


DoActions(FP,{SetMemory(0x6509B0,Subtract,23),SetDeaths(CurrentPlayer,Subtract,256,0)})
TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,10*256,0)},{SetDeaths(CurrentPlayer,SetTo,9*256,0)},{preserved})
CIf(FP,Deaths(CurrentPlayer,Exactly,0,0))
CAdd(FP,0x6509B0,23)
DoActions(FP,{SetDeathsX(CurrentPlayer,SetTo,84,0,0xFF),
RemoveUnit(84,Force1);
SetMemory(0x6509B0,Subtract,16),
SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000),
SetMemory(0x6509B0,Add,16),})
CSub(FP,0x6509B0,23)
CIfEnd()



ClearCalc()

CunitCtrig_Part2()
CunitCtrig_Part3X()
for i = 0, 1699 do -- Part4X �� Cunit Loop (x1700)
CunitCtrig_Part4X(i,{
	DeathsX(EPDF(0x628298-0x150*i+(19*4)),AtLeast,1*256,0,0xFF00),
	DeathsX(EPDF(0x628298-0x150*i+(19*4)),AtMost,6,0,0xFF),
},
{MoveCp(Add,25*4),SetV(MarSkillTimerPtr,i)})
end
CunitCtrig_End()


	
	DoActionsX(FP,SetCDeaths(FP,Add,1,SoundLimitT))
	TriggerX(FP,{CDeaths(FP,AtLeast,100,SoundLimitT)},{
		SetCDeaths(FP,SetTo,0,SoundLimit[1]),
		SetCDeaths(FP,SetTo,0,SoundLimit[2]),
		SetCDeaths(FP,SetTo,0,SoundLimit[3]),
		SetCDeaths(FP,SetTo,0,SoundLimit[4]),
		SetCDeaths(FP,SetTo,0,SoundLimit[5]),
		SetCDeaths(FP,SetTo,0,SoundLimit[6]),
		SetCDeaths(FP,SetTo,0,SoundLimit[7]),
		SetCDeaths(FP,SetTo,0,SoundLimitT)},{preserved})
	TriggerX(FP, {CD(GCT,1,AtLeast),CV(LevelT,10)}, {Order("Any unit",FP,64,Move,64)}, {preserved})

	
	DoActions(FP,{
		SetInvincibility(Disable,"Buildings",FP,64);
	})
	CMov(FP,Actived_Gun,0)
	CTrigger(FP,{CVar(FP,Dt[2],AtMost,2500)},{TSetCDeaths(FP,Subtract,1,GCT)},1)
	for i = 0, 127 do
		CTrigger(FP, {CVar("X","X",AtLeast,1)}, {
			Var_InputCVar,
			SetCtrigX("X",G_TempH[2],0x15C,0,SetTo,"X","X",0x15C,1,0),
			SetCVar(FP,f_GunNum[2],SetTo,i),
			SetCVar(FP,Actived_Gun[2],Add,1),
			SetNext("X",f_Gun,0),SetNext(f_Gun+1,"X",1), -- Call f_Gun
			SetCtrigX("X",f_Gun+1,0x158,0,SetTo,"X","X",0x4,1,0), -- RecoverNext
			SetCtrigX("X",f_Gun+1,0x15C,0,SetTo,"X","X",0,0,1), -- RecoverNext
			SetCtrig1X("X",f_Gun+1,0x164,0,SetTo,0x0,0x2) -- RecoverNext
		}, 1, 0x500+i)
	end
	CMov(FP,0x6509B0,FP)
	Create_G_CB_Arr()

	


	local G_CA_Nextptrs = CreateVar(FP)
	local TempUID = CreateVar(FP)
	local TempPID = CreateVar(FP)
	local TempType = CreateVar(FP)
	local TempProperties = CreateVar(FP)
	local f_TempTypeErr = "\x07�� \x08ERROR : \x04�߸��� RepeatType�� �ԷµǾ����ϴ�! ��ũ�������� �����ڿ��� �������ּ���!\x07 ��"
	if Limit == 1 then
--		CIf(FP,{CD(TestMode,1)})
--		--DisplayPrintEr(0,{"\x07�� \x03TESTMODE OP \x04: CreateUnitQueuePtr : ",CreateUnitQueuePtr," || CreateUnitQueuePtr2 : ",CreateUnitQueuePtr2," \x07��"})
--		local TestV = CreateVar()
--		CMov(FP,TestV,0)
--		CFor(FP, 19025+19, 19025+19 + (84*1700), 84)
--			local CI = CForVariable()
--			CTrigger(FP, {TMemoryX(CI,AtLeast,1*256,0xFF00)}, {AddV(TestV,1)},1)
--		CForEnd()
		--DisplayPrintEr(0,{"\x07�� \x03TESTMODE OP \x04: CUnit Count : ",TestV," \x07��"})--

--		CIfEnd()
	end
	NWhile(FP,{CV(count,1500,AtMost),Memory(0x628438,AtLeast,1),CV(CreateUnitQueueNum,1,AtLeast)},{})

	


	QPosX = CreateVar(FP)
	QPosY = CreateVar(FP)
	f_Read(FP,0x628438,"X",G_CA_Nextptrs,0xFFFFFF)
	f_SHRead(FP, _Add(CreateUnitQueueXPosArr,CreateUnitQueuePtr2), QPosX)
	f_SHRead(FP, _Add(CreateUnitQueueYPosArr,CreateUnitQueuePtr2), QPosY)
	f_SHRead(FP, _Add(CreateUnitQueueUIDArr,CreateUnitQueuePtr2), TempUID)
	f_SHRead(FP, _Add(CreateUnitQueuePIDArr,CreateUnitQueuePtr2), TempPID)
	f_SHRead(FP, _Add(CreateUnitQueueTypeArr,CreateUnitQueuePtr2), TempType)
	f_SHRead(FP, _Add(CreateUnitQueuePropertiesArr,CreateUnitQueuePtr2), TempProperties)
	CDoActions(FP, {
		TSetMemory(_Add(CreateUnitQueueXPosArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueueYPosArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueueUIDArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueuePIDArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueueTypeArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueuePropertiesArr,CreateUnitQueuePtr2), SetTo, 0)
	})
	DoActionsX(FP,{AddV(CreateUnitQueuePtr2,1),SubV(CreateUnitQueueNum,1)})
	TriggerX(FP, {CV(CreateUnitQueuePtr2,100000,AtLeast)},{SetV(CreateUnitQueuePtr2,0)},{preserved})

	local isScore = CreateCcode()

	CIf(FP,{TTOR({CVar(FP,TempType[2],Exactly,0),CVar(FP,TempType[2],Exactly,4)})})
		local Gun_Order = def_sIndex()
		CJumpXEnd(FP,Gun_Order)
		f_Mod(FP,Gun_TempRand,_Rand(),_Mov(7))
		for i = 0, 6 do
			NIf(FP,{CVar(FP,Gun_TempRand[2],Exactly,i),HumanCheck(i,0)})
				CJumpX(FP,Gun_Order)
			NIfEnd()
		end
		CIf(FP,CDeaths(FP,AtLeast,1,PCheck))
		for i = 0, 6 do
			CIf(FP,{CVar(FP,BarrackPtr[i+1][2],AtLeast,1),CVar(FP,Gun_TempRand[2],Exactly,i)})
				CMov(FP,TempBarPos,BarPos[i+1])
			CIfEnd()
		end
		CIfEnd()
	CIfEnd()



	NIf(FP,{CV(TempUID,1,AtLeast),CV(TempUID,226,AtMost)})
	local CRLID = CreateVar(FP)



	Simple_SetLocX(FP,0,QPosX,QPosY,QPosX,QPosY)
	-- MoveUnitLoc = 1
	-- DefAttackLoc = 89
	-- DefCreateLoc = 90
	CMov(FP,CunitIndex,_Div(_Sub(G_CA_Nextptrs,19025),_Mov(84)))

	f_Lengthdir(FP,_Mod(_Rand(),24*32),_Mod(_Rand(),360),CPosX,CPosY)
	CDiv(FP,CPosY,2)
	Simple_SetLocX(FP,89,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(89,1536,4480,1536,4480)})
	CDoActions(FP,{
		TCreateUnitWithProperties(1,TempUID,90,P8,{energy = 100}),
--		TModifyUnitEnergy(All,TempUID,P8,1,100);
	})
	

	CIf(FP,{TMemoryX(_Add(G_CA_Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
	
		
		CTrigger(FP, {TMemoryX(_Add(TempUID,EPDF(0x664080)), Exactly, 4,4),CVX(TempProperties,1,1)},{TSetDeathsX(_Add(G_CA_Nextptrs,55),SetTo,0xA00000,0,0xA00000)} , 1) -- ��������+CBRepeat ��ȯ = ��ġ�� ON
		local TempW = CreateWar(FP)
		f_LMovX(FP, TempW, WArr(MaxHPWArr,TempUID), SetTo, nil, nil, 1)
		CIf(FP,{TTCWar(FP, TempW[2], AtLeast, tostring(8320000*256))})
		local TempV1 = CreateVar(FP)
		local TempV2 = CreateVar(FP)
		f_LMov(FP, {TempV1,TempV2}, _LSub(TempW,tostring(8320000*256)), nil, nil, 1)
			CDoActions(FP, {
				Set_EXCC2(LHPCunit, CunitIndex, 0, SetTo,1),
				Set_EXCC2(LHPCunit, CunitIndex, 1, SetTo,TempV1),
				Set_EXCC2(LHPCunit, CunitIndex, 2, SetTo,TempV2),
		})
		CIfEnd()


		f_Read(FP,_Add(G_CA_Nextptrs,10),CPos) -- �������� ��ġ �ҷ�����
		Convert_CPosXY()
		Simple_SetLocX(FP,89,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(89,-4,-4,4,4)})
		CDoActions(FP,{TMoveUnit(1,TempUID,FP,90,1)})
		f_Read(FP,_Add(G_CA_Nextptrs,10),CPos) -- �������� ��ġ �ҷ�����
		Convert_CPosXY()
		Simple_SetLocX(FP,89,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(89,-4,-4,4,4)})

		CIfX(FP,CVar(FP,TempType[2],Exactly,0),SetCDeaths(FP,SetTo,1,isScore))
		
			CMov(FP,CPos,TempBarPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,88,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(88,-4,-4,4,4)})
			CDoActions(FP,{TOrder(TempUID,FP,90,Attack,89)})
		CElseIfX(CVar(FP,TempType[2],Exactly,4),SetCDeaths(FP,SetTo,1,isScore)) -- ��ȿ�� �ο�+����

			CMov(FP,CPos,TempBarPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,88,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(88,-4,-4,4,4)})
			CDoActions(FP,{TOrder(TempUID,FP,90,Attack,89),TSetDeathsX(_Add(G_CA_Nextptrs,55),SetTo,0xA00000,0,0xA00000)})


		CElseIfX(CVar(FP,TempType[2],Exactly,187),SetCDeaths(FP,SetTo,1,isScore))
			CDoActions(FP,{TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),})
		CElseIfX(CVar(FP,TempType[2],Exactly,1),SetCDeaths(FP,SetTo,1,isScore))
			f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,59,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(59,-32,-32,32,32)})
			CDoActions(FP,{
				TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0x04000000,0x04000000),TSetDeathsX(_Add(G_CA_Nextptrs,72),SetTo,0xFF*256,0,0xFF00),TSetDeathsX(_Add(G_CA_Nextptrs,55),SetTo,0xA00000,0,0xA00000),CreateUnit(1,ObEff,60,FP),KillUnit(ObEff, FP)
			})
			f_CGive(FP, G_CA_Nextptrs,nil, P9, FP)
		CElseIfX(CVar(FP,TempType[2],Exactly,3),SetCDeaths(FP,SetTo,1,isScore))
		CElseIfX(CVar(FP,TempType[2],Exactly,5),SetCDeaths(FP,SetTo,0,isScore)) -- ��ī�������� ���ø��, ���� �浹���� ���� ��ī������ ���� TempType
		TriggerX(FP,CVar(FP,TempUID[2],Exactly,80),{KillUnitAt(All,"Edmund Duke (Siege Mode)",1,FP)},{preserved})
		GetLocCenter("Boss",CPosX,CPosY)
		Simple_SetLocX(FP,88,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(88,-4,-4,4,4)})
		CDoActions(FP,{TOrder(TempUID,FP,90,Attack,89),TSetDeathsX(_Add(G_CA_Nextptrs,55),SetTo,0xA00000,0,0xA00000)})
		CTrigger(FP,{CVar(FP,TempUID[2],Exactly,27)},{TSetDeathsX(_Add(G_CA_Nextptrs,55),SetTo,0x04000000,0,0x04000000)},1)

		CElseIfX(CVar(FP,TempType[2],Exactly,2),SetCDeaths(FP,SetTo,0,isScore)) -- ��ī�������� ���ø��, ��ī������ ���� TempType
		TriggerX(FP,CVar(FP,TempUID[2],Exactly,80),{KillUnitAt(All,"Edmund Duke (Siege Mode)",1,FP)},{preserved})
		GetLocCenter("Boss",CPosX,CPosY)
		Simple_SetLocX(FP,88,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(88,-4,-4,4,4)})
		CDoActions(FP,{TOrder(TempUID,FP,90,Attack,89)})
		CTrigger(FP,{CVar(FP,TempUID[2],Exactly,27)},{TSetDeathsX(_Add(G_CA_Nextptrs,55),SetTo,0x04000000,0,0x04000000)},1)
		CElseX(SetCDeaths(FP,SetTo,0,isScore))
			DoActions(FP,RotatePlayer({DisplayTextX(f_TempTypeErr,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP))
		CIfXEnd()
		CIf(FP,CDeaths(FP,AtLeast,1,isScore))
			f_Mod(FP,BiteCalc,TempUID,_Mov(2),0xFF)
			f_Read(FP,_Add(_Div(TempUID,_Mov(2)),_Mov(EPD(0x663EB8))),UnitPoint)
			NIfX(FP,{CVar(FP,BiteCalc[2],AtLeast,1)})
			CDiv(FP,UnitPoint,65536)
			NElseX()
			CMod(FP,UnitPoint,65536)
			NIfXEnd()
			CAdd(FP,InputPoint,UnitPoint)
		CIfEnd()
		
	CIfEnd()

	


	NIfEnd()

	NWhileEnd()
	
	DoActions(FP,{RemoveUnit(179,P12),RemoveUnit(84,P12),RemoveUnit(84,Force1)})
	if Limit == 1 then
		TriggerX(FP,{CD(TestMode,1)}, RotatePlayer({RunAIScript(P8VON)},MapPlayers,FP),{preserved})
	end
end
