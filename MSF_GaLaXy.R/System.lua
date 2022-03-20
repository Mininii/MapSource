function Gun_System()
	UnitReadX(FP,AllPlayers,229,64,count)
	UnitReadX(FP,AllPlayers,17,64,count1)
	UnitReadX(FP,AllPlayers,23,64,count2)
	UnitReadX(FP,AllPlayers,25,64,count3)
	CAdd(FP,count,count1)
	CAdd(FP,count,count2)
	CAdd(FP,count,count3)
	local CurCunitI2 = CreateVar(FP)
	CIf(FP,{CD(NosBGM,1)},SetCD(NosBGM,0))
	TriggerX(FP,DeathsX(AllPlayers,AtLeast,1,12,0xFFFFFF),{SetV(BGMType,99)},{Preserved})
	TriggerX(FP,{DeathsX(AllPlayers,Exactly,0,12,0xFFFFFF),CD(NextNosBGM,0),CV(BGMType,0)},{SetV(BGMType,2),SetCD(NextNosBGM,1)},{Preserved})
	TriggerX(FP,{DeathsX(AllPlayers,Exactly,0,12,0xFFFFFF),CD(NextNosBGM,1),CV(BGMType,0)},{SetV(BGMType,3),SetCD(NextNosBGM,0)},{Preserved})
	CIfEnd()

	IBGM_EPD(FP,6,nil,{12})
    AddBGM(1,"staredit\\wav\\Opening.ogg",23*1000)--오프닝
    AddBGM(2,"staredit\\wav\\NosBGM_2.ogg",29*1000)
    AddBGM(3,"staredit\\wav\\NosBGM_1.ogg",32*1000)
    Install_BGMSystem(FP,3,BGMType,12)

	
    EXCC_Part1(DUnitCalc) -- 죽은유닛 인식 단락 시작
    Check_Enemy = def_sIndex()
    NJump(FP,Check_Enemy,{DeathsX(CurrentPlayer,AtLeast,7,0,0xFF)})
    DoActions(FP,MoveCp(Add,6*4))
	f_SaveCp()
	DUnitID = CreateVar(FP)
	DPlayer = CreateVar(FP)
	DSound = CreateCcode()
	CMov(FP,DUnitID,_ReadF(BackupCP),nil,0xFF)
	CMov(FP,DPlayer,_ReadF(_Sub(BackupCP,6)),nil,0xFF)
	DUArr={0,20,100,16,7}
	DCArr = {1,2,3,5,0}
	for i = 0, 6 do
	DUStrArr = {"\x0D\x0D\x0D"..ColorCode[i+1].."NM".._0D,"\x0D\x0D\x0D"..ColorCode[i+1].."HM".._0D,"\x0D\x0D\x0D"..ColorCode[i+1].."GM".._0D,"\x0D\x0D\x0D"..ColorCode[i+1].."NB".._0D,"\x0D\x0D\x0D"..ColorCode[i+1].."SV".._0D,}
		for j= 1, 5 do
			Trigger2X(FP,{CV(DUnitID,DUArr[j]),CV(DPlayer,i)},{SetScore(i,Add,DCArr[j],Custom),SetCD(DSound,1),RotatePlayer({DisplayTextX(DUStrArr[j],4)},HumanPlayers,FP)},{Preserved})
		end
	end

	f_LoadCp()
    

    --Install_DeathNotice()



    EXCC_ClearCalc()
    NJumpEnd(FP,Check_Enemy)
    DoActions(FP,MoveCp(Add,6*4))
    EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,35,0,0xFF))
    EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,204,0,0xFF))
    EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,33,0,0xFF))
    EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,84,0,0xFF))
    EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,42,0,0xFF))
    EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,191,0,0xFF))
    EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,128,0,0xFF))
    EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,205,0,0xFF))



    CIf(FP,{Cond_EXCC(1,Exactly,1)}) -- 영작유닛인식

	f_SaveCp()
	HIndex,HIndex2,HPoint,HPoint10 = CreateVars(4,FP)
	CMov(FP,HIndex,_ReadF(BackupCP),nil,0xFF,1)
	HPointEPD = CreateVar(FP)
	CMov(FP,HPointEPD,_Div(HIndex,2),EPDF(0x663408))
	CMov(FP,HPoint,_ReadF(HPointEPD),nil,nil,1)
	f_Mod(FP,HIndex2,HIndex,2)
	NIfX(FP,{TMemory(_Mem(HIndex2),AtLeast,1)})
	f_Div(FP,HPoint,65536)
	NElseX()
	f_Mod(FP,HPoint,65536)
	NIfXEnd()
	CMov(FP,HPoint10,_Mul(HPoint,100))
	local HPointT = CreateVArr(4,FP)
	ItoDec(FP,HPoint10,VArr(HPointT,0),2,0x1F,0)

	--CMov(FP,0x57f120,HIndex)
	f_Movcpy(FP,_Add(HeroTxtStrPtr,Str19[2]+0x40+Str20[2]),VArr(HPointT,0),16)
	f_Memcpy(FP,_Add(HeroTxtStrPtr,Str19[2]),_Add(_Mul(HIndex,0x40),UnitNamePtr),0x40)
	CDoActions(FP,{TSetScore(Force1,Add,HPoint10,Kills)})
	HText = "\x0D\x0D\x0DHK".._0D
	DoActions(FP,CopyCpAction({DisplayTextX(HText,4)},HumanPlayers,FP))
	TriggerX(FP,{CDeaths(FP,AtMost,2,SoundLimit)},{CopyCpAction({PlayWAVX("staredit\\wav\\HeroKill.wav")},HumanPlayers,FP),SetCDeaths(FP,Add,1,SoundLimit)},{Preserved})
	
	f_LoadCp()
    CIfEnd()
    for j, k in pairs(f_GunTable) do
    f_GSend(k)
    end
    
    
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
		MoveCp(Add,19*4),
        SetCVar(FP,CurCunitI2[2],SetTo,i)
		})
	end
	EXCC_End()
	
	

	TriggerX(FP,{CD(SoundLimit,5,AtMost),CD(DSound,1,AtLeast)},{SetCD(DSound,0),AddCD(SoundLimit,1),RotatePlayer({PlayWAVX("staredit\\wav\\die_se.ogg")},HumanPlayers,FP)},{Preserved})
    DoActionsX(FP,SetCDeaths(FP,Add,1,SoundLimitT))
    TriggerX(FP,{CDeaths(FP,AtLeast,100,SoundLimitT)},{SetCDeaths(FP,SetTo,0,SoundLimit),SetCDeaths(FP,SetTo,0,SoundLimitT)},{Preserved})
	Install_GunStack()
    CIfX(FP,{CVar(FP,count[2],AtMost,GunLimit)}) -- 건작함수 제어
		Create_G_CA_Arr()
        CMov(FP,Actived_Gun,0)
        CMov(FP,0x6509B0,FP)
    CIfXEnd()
	countDisplayT = {}
	for i = 0, 6 do
	
		table.insert(countDisplayT,SetMemory(0x582144 + (i*4),SetTo,GunLimit*2))
		table.insert(countDisplayT,SetMemory(0x5821A4 + (i*4),SetTo,GunLimit*2))
	CMov(FP,0x582174+(4*i),count)
	CAdd(FP,0x582174+(4*i),count)
	end
	DoActions(FP,countDisplayT,1)
	DoActions(FP,{ModifyUnitHangarCount(1,All,82,P8,64),SetInvincibility(Enable,73,P8,64)})
	HangerT=CreateCcode()
	DoActionsX(FP,{AddCD(HangerT,1)})
	TriggerX(FP,{CD(HangerT,50,AtLeast)},{SetCD(HangerT,0),RemoveUnit(85,P8),ModifyUnitHangarCount(1,All,81,P8,64)},{Preserved})
	DoActions(FP,{SetCp(FP),RunAIScriptAt("Expansion Zerg Campaign Insane",17);
	RunAIScriptAt("Value This Area Higher",4);},1)
	Trigger2(FP,{Command(FP,AtLeast,15,42)},{KillUnit(42,FP)},{Preserved})
	
end