function Gun_System()
	UnitReadX(FP,AllPlayers,229,64,count)
	UnitReadX(FP,AllPlayers,17,64,count1)
	UnitReadX(FP,AllPlayers,23,64,count2)
	UnitReadX(FP,AllPlayers,25,64,count3)
	CAdd(FP,count,count1)
	CAdd(FP,count,count2)
	CAdd(FP,count,count3)
	
    local EXCunit_Reset = {}
    for i = 1, #EXCunitTemp do
        table.insert(EXCunit_Reset,SetCtrig1X("X","X",CAddr("Value",i-1,0),0,SetTo,0))
    end
    --[[
    EXCunit ����
    1���� : ������ ����
    9���� : �������� ǥ��
    10���� : ���� ������ �ߺ����� ������
    ]]
    CunitCtrig_Part1(FP) -- �������� �ν� �ܶ� ����
    DoActions(FP,MoveCp(Subtract,6*4))
    Check_P8 = def_sIndex()
    NJump(FP,Check_P8,DeathsX(CurrentPlayer,Exactly,7,0,0xFF))
    DoActions(FP,MoveCp(Add,6*4))
    --Install_DeathNotice()

    ClearCalc()

    NJumpEnd(FP,Check_P8)
    DoActions(FP,MoveCp(Add,6*4))
    CIf(FP,CVar(FP,EXCunitTemp[9][2],AtLeast,1)) -- ���������ν�
    f_SaveCp()
    --InstallHeroPoint()
    CIfEnd()
    CMov(FP,Gun_Type,0)

    f_GSend(131)
    f_GSend(132)
    f_GSend(133)
	

    if TestStart == 1 then
        --f_GSend(146)
        --f_GSend(136)
    end



    ClearCalc()
    CunitCtrig_Part2()
    DoActionsXI(FP,EXCC_Forward)
    CunitCtrig_Part3X()
    for i = 0, 1699 do -- Part4X �� Cunit Loop (x1700)
    CunitCtrig_Part4_EX(i,{
    DeathsX(19025+(84*i)+40,AtLeast,1*16777216,0,0xFF000000),
    DeathsX(19025+(84*i)+19,Exactly,0*256,0,0xFF00),
    },
    {SetDeathsX(19025+(84*i)+40,SetTo,0*16777216,0,0xFF000000),
    SetCVar(FP,CurCunitI[2],SetTo,i),EXCunit_Reset,
    MoveCp(Add,25*4),
    },EXCunitTemp)
    end
    CunitCtrig_End()
    DoActionsX(FP,SetCDeaths(FP,Add,1,SoundLimitT))
    TriggerX(FP,{CDeaths(FP,AtLeast,100,SoundLimitT)},{SetCDeaths(FP,SetTo,0,SoundLimit),SetCDeaths(FP,SetTo,0,SoundLimitT)},{Preserved})

    CIfX(FP,{CVar(FP,count[2],AtMost,GunLimit)}) -- �����Լ� ����
        CMov(FP,Actived_Gun,0)
--        for i = 0, 63 do
--			CallTriggerX(FP,f_Gun,{CSVAar(SVArr(Gun_SVA,i,1),AtLeast,1)},{
--                SetCVar(FP,f_GunNum[2],SetTo,i),
--                SetCVar(FP,Actived_Gun[2],Add,1),
--			})
--        end

		for i = 0, 63 do
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
    CIfXEnd()
	for i = 0, 6 do
	CMov(FP,0x582174+(4*i),count)
	CAdd(FP,0x582174+(4*i),count)
	end
end