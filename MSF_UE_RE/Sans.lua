function Install_SansBoss()
	

    function SetBright(Time,Value)
        TriggerX(FP,{CD(SBossStart,Time,AtLeast)},{SetMemory(0x657A9C,SetTo,Value)})
    end
    function StoryPrintS(T,Talk,Cond)
        Trigger2X(FP,{CDeaths(FP,AtLeast,T,SBossStart),Cond},{RotatePlayer({DisplayTextX("\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\x13\x06 :: \x1CSans, \x08Judge \x04Of \x11The \x07Level \x06::\r\n\x0D\x0D!H\x13"..Talk.."\r\n\r\n",4)},HumanPlayers,FP);})
    end
    BWait = CreateCcode()
    TalkCond = CreateCcode()
    BossP=CreateVar(FP)
	function CABossFunc()
		local UnitPtr = CABossPtr
		local PlayerID = CABossPlayerID
		local CA = CABossDataArr
		local CB = CABossTempArr
		local PattV = CreateVarArr(4,FP)
		local PattC = CreateCcodeArr(4)
		local PattC2 = CreateCcodeArr(49)
        TriggerX(FP,{CD(BWait,1)},SetV(CB[3],250),{preserved})--CD(TestMode,1),
        CIf(FP,{CV(CB[3],0)}) -- 보스패턴 작성구간

        CIfEnd()
		if Limit == 1 then
			--CTrigger(FP,{CD(TestMode,1),Deaths(Force1,AtLeast,1,208)},{SetV(CB[2],0)},1)
		end


		CIf(FP,{CD(PattC[1],1,AtLeast),CV(CB[3],0)},{SetCD(PattC[1],0)})
			TriggerX(FP,{},SetV(CB[3],250),{preserved})--CD(TestMode,1),
			CIfX(FP,{TMemory(_Add(UnitPtr,2),AtMost,(8320000*256)),CV(CA[1],9,AtMost)},{AddV(CA[1],1)})
				--DoActions2(FP,{CreateUnit(3,84,64,FP),KillUnit(84, FP),RotatePlayer({PlayWAVX("staredit\\wav\\start.ogg"),PlayWAVX("staredit\\wav\\start.ogg"),PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP)})
			CElseX()

			CIfXEnd()
			ResetActT = {}
			for j,k in pairs(PattV) do
				table.insert(ResetActT,SetV(k,0))
			end
			for j,k in pairs(PattC) do
				table.insert(ResetActT,SetCD(k,0))
			end
			for j,k in pairs(PattC2) do
				table.insert(ResetActT,SetCD(k,0))
			end
			
			
			
			
			DoActions2X(FP,ResetActT)
		CIfEnd()
	B3DeathCheck = CB[5]
	end--CABossFunc end




    CIf(FP,{CD(SBossStart,1,AtLeast)},{AddCD(SBossStart,Dt)})
    DoActions(FP,{MoveUnit(All,96,FP,64,64)})--보스위치고정
    DoActionsX(FP,{SetCD(BWait,1)},1)
    local TempActT = {}
    local TempCond2 = {}
    local TempActT2 = {}
        for i = 0, 6 do
            table.insert(TempActT,SetMemory(0x657470 + (MarWep[i+1]*4) ,SetTo,32*7))
            table.insert(TempActT,MoveUnit(All, "Men", i, "Center", 2+i))
            Trigger2X(FP,{HumanCheck(i, 1),Bring(i,AtLeast,13,"Men",89)},{RotatePlayer({PlayWAVX("staredit\\wav\\SE2.ogg"),PlayWAVX("staredit\\wav\\SE2.ogg"),PlayWAVX("staredit\\wav\\SE2.ogg"),PlayWAVX("staredit\\wav\\SE2.ogg")},HumanPlayers,FP),SetCD(TalkCond,1),MoveUnit(All, "Men", i, 89, 2+i)},{preserved})
        end
        DoActions(FP,TempActT,1)
	DoActions(FP,{RotatePlayer({RunAIScript(P8VON)},MapPlayers,FP)},1)
    for i = 0, 6 do
        local Br = 0
        if i%2==1 then Br = 32 
        else
            Trigger2X(FP,{CD(SBossStart,i*100,AtLeast)},{RotatePlayer({PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),},HumanPlayers,FP)})
        end
        SetBright(i*100,Br)
    end
    Trigger2X(FP,{CD(SBossStart,600,AtLeast)},{RotatePlayer({PlayWAVX("staredit\\wav\\SE3.ogg"),PlayWAVX("staredit\\wav\\SE3.ogg"),PlayWAVX("staredit\\wav\\SE3.ogg")},HumanPlayers,FP)})

    
    
    SetBright(3100,31)

    SetBright(1000,31)
    CIfOnce(FP,{CD(SBossStart,1000,AtLeast)})
    CDoActions(FP, {
        CreateUnit(1,96,64,FP),RotatePlayer({CenterView(64)},HumanPlayers,FP),
		SetMemoryB(0x669E28+151, SetTo, 0),--색상복구
        SetInvincibility(Enable, 96, FP, 64)
    })
    CIfEnd()

    StoryPrintS(5000+(2500*0),"\x04정말 아름다운 날이야.")
    StoryPrintS(5000+(2500*1),"\x04새들은 지저귀고, 꽃들은 피어나고...")
    StoryPrintS(5000+(2500*2),"\x04이런 날엔, 너희 같은 랭커들은...")
    SetBright(5000+(2500*3)+0,0)
    Trigger2X(FP,{CD(SBossStart,5000+(2500*3)+0,AtLeast)},{RotatePlayer({PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg")},HumanPlayers,FP),RemoveUnit(96,FP)})
    SetBright(5000+(2500*3)+500,31)
    Trigger2X(FP,{CD(SBossStart,5000+(2500*3)+500,AtLeast)},{RotatePlayer({PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg")},HumanPlayers,FP),SetV(TalkTimer,6)})
    StoryPrintS(5000+(2500*3)+1000,"\x081층으로 떨어트려야 해.")
    


    CIfOnce(FP,{CD(SBossStart,5000+(2500*3)+500,AtLeast)})
	f_Read(FP,0x628438,nil,Nextptrs)
    CMov(FP,SBossPtr,Nextptrs)
    CDoActions(FP, {
		SetMemoryB(0x669E28+151, SetTo, 16),--색상
        CreateUnit(1,96,64,FP),RotatePlayer({CenterView(64)},HumanPlayers,FP),
		SetMemoryB(0x669E28+151, SetTo, 0),--색상복구
    })
    CIfEnd()


    
    for i = 30,0,-1 do
        SetBright((5000+(2500*3)+4000)-(i*100),i)
    end
    SetBright(5000+(2500*3)+4200,32)
    TriggerX(FP,{CD(SBossStart,5000+(2500*3)+1000,AtLeast)},{SetCVar(FP,ReserveBGM[2],SetTo,SBossBGM)},{preserved})
    
    StoryPrintS(5000+(2500*3)+4200,"\x04뭐? 내가 딜찍누를 허용할 거라 생각했어?",CD(TalkCond,1))
    Trigger2X(FP,{CD(SBossStart,5000+(2500*3)+4200,AtLeast)},{RotatePlayer({PlayWAVX("staredit\\wav\\GBl2.ogg"),PlayWAVX("staredit\\wav\\GBl2.ogg"),PlayWAVX("staredit\\wav\\GBl2.ogg"),PlayWAVX("staredit\\wav\\GBl2.ogg")},HumanPlayers,FP)})
    CIf(FP,{CD(SBossStart,5000+(2500*3)+4200,AtLeast),CV(BossP,32*11,AtMost)},{SetV(TalkTimer,2),SetCD(BWait,0),SetMemoryB(0x669E28+429, SetTo, 17),})
        CFor(FP,0,360,15)
        local CI = CForVariable()
        CIf(FP,Memory(0x628438,AtLeast,1))
        f_Read(FP,0x628438,nil,Nextptrs)
        f_Lengthdir(FP, BossP, CI, CPosX, CPosY)
        Simple_SetLocX(FP, 0, _Add(CPosX,(96*16)-32), _Add(CPosY,(192*16)-32), _Add(CPosX,(96*16)+32), _Add(CPosY,(192*16)+32), {})--
        CDoActions(FP, {CreateUnit(1,13,1,FP),
        TSetMemoryX(_Add(Nextptrs,55),SetTo,0xA00104,0xA00104),
        TSetMemory(_Add(Nextptrs,57),SetTo,0),
        KillUnitAt(All, "Men", 1, Force1),KillUnit(13, FP),
        })
        CIfEnd()
        CForEnd()
        CAdd(FP,BossP,32)
    CIfEnd()
        
    if Limit == 1 then
        CIf(FP,CD(TestMode,1))
        TriggerX(FP,{}, RotatePlayer({RunAIScript(P8VON)},MapPlayers,FP),{preserved})
        GetLocCenter(73, CPosX, CPosY)
        AngleRand = f_CRandNum(360)

        --Trigger2X(FP,{Deaths(Force1,AtLeast,1,41)},{RotatePlayer({DisplayTextX("\x0D\x0D!H대사 출력 테스트,        나는 샌즈",4)},HumanPlayers,FP),SetCD(GBl1SE,0)},{preserved})
        --TS_SendX(Deaths(Force1,AtLeast,1,41), BlasterBullet, {96*16,192*16,CPosX,CPosY,nil,nil,AngleRand})
        DoActions(FP, SetDeaths(Force1,SetTo,0,41))
        
        CIfEnd()
    end
    TS_CreateArr(BlasterBullet)
    Trigger2X(FP,{CD(GBl1SE,1)},{RotatePlayer({PlayWAVX("staredit\\wav\\GBl1.ogg")},HumanPlayers,FP),SetCD(GBl1SE,0)},{preserved})
    Trigger2X(FP,{CD(GBl2SE,1)},{RotatePlayer({PlayWAVX("staredit\\wav\\GBl2.ogg")},HumanPlayers,FP),SetCD(GBl2SE,0)},{preserved})
	CallTrigger(FP, Call_CDPrint)






    
	if BossPhaseTestMode == 1 then
		BinitT = CreateVar2(FP,nil,nil,300)
		TriggerX(FP, {CD(TestMode,1)}, {SetV(BinitT,0)})
	else
		BinitT = 300
	end

	CABoss(SBossPtr,nil,{0,BinitT,2,"128000000000",8320000,1},"CABossFunc",FP,nil,nil,LHPCunit)
    CIfEnd()

end