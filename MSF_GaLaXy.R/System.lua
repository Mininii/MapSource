function Gun_System()
	CanC = CreateCcode()
	CanCT = CreateCcode()
	DefeatCC = CreateCcode()
	DoActions(FP, {RemoveUnitAt(All,"Any unit",4,P12),KillUnit(84,FP)})

	CIf(FP,{CV(HondonMode,1,AtLeast)})
	TurboSeekT = CreateCcode()
	UnitTurnRadT = CreateCcode()
	DoActionsX(FP,{AddCD(TurboSeekT,1),AddCD(UnitTurnRadT,1)})
	TriggerX(FP,{CD(TurboSeekT,2,AtLeast)},{SetDeaths(-111923, SetTo, 1, 0),SubCD(TurboSeekT,2)},{preserved})

	CIf(FP,{CD(UnitTurnRadT,12,AtLeast)},{SetCD(UnitTurnRadT,0)})
	
	PtrV = CreateVar(FP)

	CMov(FP,PtrV,19025)
	CWhile(FP,CV(PtrV,19025 + (84*1699),AtMost))
	CIf(FP,{TMemoryX(_Add(PtrV,19),AtMost,6,0xFF),TTOR({_TMemoryX(_Add(PtrV,25),Exactly,12,0xFF),_TMemoryX(_Add(PtrV,25),Exactly,60,0xFF)})})
	CDoActions(FP, {
		TSetMemoryX(_Add(PtrV,8),SetTo,127*65536,0xFF0000),
		TSetMemoryX(_Add(PtrV,9),SetTo,0*16777216,0xFF000000),
		})
	CIfEnd()
	CAdd(FP,PtrV,84)
	CWhileEnd()


	CIfEnd()
	
	CIfEnd()

	CanWarn = "\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x08ＷＡＲＮＩＮＧ\x04　！！！\n\x14\n\x14\n\x13\x04캔낫을 의도적으로 걸 경우 게임에서 \x08패배\x04합니다.\n\x13\x04\x07유닛 생성 큐\x04에 유닛이 \x08５０，０００\x04이상 \x10증가\x04하지 않도록 \x08주의\x04해 주시기 바랍니다.\n\x14\n\x13\x04！！！　\x08ＷＡＲＮＩＮＧ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
	for j = 1, 9 do
		Trigger2X(FP, {CVar(FP,CreateUnitQueueNum[2],AtLeast,5000*j);}, {
			RotatePlayer({
			DisplayTextX(CanWarn,4);
			PlayWAVX("sound\\Terran\\RAYNORM\\URaPss02.WAV");
			PlayWAVX("sound\\Terran\\RAYNORM\\URaPss02.WAV");
			PlayWAVX("sound\\Terran\\RAYNORM\\URaPss02.WAV");
			PlayWAVX("sound\\Terran\\RAYNORM\\URaPss02.WAV");
			},HumanPlayers,FP);})
	end

	InvTable = {131,132,133,156,109,175,116,150,154,151,130,148,190}
	InvDisTable = {}
	InvEnvTable = {}
	for j,k in pairs(InvTable) do
		table.insert(InvDisTable,SetInvincibility(Disable, k, FP, 64))
		table.insert(InvEnvTable,SetInvincibility(Enable, k, FP, 64))
	end

--	Trigger2X(FP,{--유닛생성 큐 데이터 5000이상 건작무적
--	CV(CreateUnitQueueNum,5000,AtLeast);
--},InvEnvTable,{preserved})
--Trigger2X(FP,{--유닛생성 큐 데이터 4999이하 건작무적해제
--CV(CreateUnitQueueNum,4999,AtMost);
--},InvDisTable,{preserved})


	Trigger2X(FP,{--유닛생성 큐 데이터 5만개이상 패배
	CV(CreateUnitQueueNum,50000,AtLeast);
},{
	RotatePlayer({
		PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
		PlayWAVX("staredit\\wav\\CanOver.ogg"),
		PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV"),
		PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV")
		},HumanPlayers,FP);
		SetCDeaths(FP,SetTo,24*30,CanCT);
		SetCDeaths(FP,Add,1,DefeatCC);
})

TriggerX(FP,CD(DefeatCC,1,AtLeast),{AddCD(DefeatCC,1)},{preserved})
TriggerX(FP,{CD(DefeatCC,150,AtLeast),CD(TestMode,0)},{
	RotatePlayer({Defeat()},HumanPlayers,FP);},{preserved})
TriggerX(FP,{CD(DefeatCC,150,AtLeast),CD(DMode,2)},{ -- 캔아웃 드랍
	RotatePlayer({RunAIScript(P8VON)},{8,9,10,11},FP)
},{preserved})
CWhile(FP,{CD(DefeatCC,150,AtLeast),CD(DMode,3)}) -- 캔아웃 응없
CWhileEnd()

	CIf(FP,{Switch("Switch 201",Set),CD(GMode,2,AtLeast)})

	
	if X2_Mode == 0 then
		
		CanDisplayT = {}
		CanDisplayT2 = {}
	
		for i = 0, 6 do
		table.insert(CanDisplayT,SetMemory(0x582174+(4*i),Add,2))
		table.insert(CanDisplayT2,SetMemory(0x582144+(4*i),Add,8))
		table.insert(CanDisplayT2,SetMemory(0x5821A4+(4*i),Add,8))
		end
		DoActions(FP,CanDisplayT2,1)
		DoActionsX(FP,{SubCD(CanCT,1)})
		Trigger2X(FP,{
			CDeaths(FP,AtMost,0,CanCT);
			Memory(0x628438,AtMost,0)},{
				KillUnit(37,FP);
				KillUnit(38,FP);
				KillUnit(39,FP);
				KillUnit(43,FP);
				KillUnit(44,FP);
				KillUnit(47,FP);
				KillUnit(48,FP);
				KillUnit(50,FP);
				KillUnit(51,FP);
				KillUnit(53,FP);
				KillUnit(54,FP);
				KillUnit(55,FP);
				KillUnit(56,FP);
				CanDisplayT;},{preserved})
		Trigger2X(FP,{--캔발동
		Memory(0x628438,AtMost,0);
			CDeaths(FP,AtMost,2,CanC);
			CDeaths(FP,AtMost,0,CanCT);
		},{
			RotatePlayer({
				PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
				PlayWAVX("staredit\\wav\\warn.wav"),
				PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV"),
				PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV")
				},HumanPlayers,FP);
				SetCDeaths(FP,SetTo,24*30,CanCT);
				SetCDeaths(FP,Add,1,CanC);
		},{preserved})
		
		Trigger2X(FP,{--캔발동
			Memory(0x628438,AtMost,0);
			CDeaths(FP,AtLeast,3,CanC);
			CDeaths(FP,AtMost,0,CanCT);
		},{
			RotatePlayer({
				PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
				PlayWAVX("staredit\\wav\\CanOver.ogg"),
				PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV"),
				PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV")
				},HumanPlayers,FP);
				SetCDeaths(FP,SetTo,24*30,CanCT);
				SetCDeaths(FP,Add,1,CanC);
				SetCDeaths(FP,Add,1,DefeatCC);
		},{preserved})
	end


	CIfEnd()
	count4 = CreateVar(FP)
	count5 = CreateVar(FP)
	count6 = CreateVar(FP)
	UnitReadX(FP,AllPlayers,229,64,count)
	UnitReadX(FP,AllPlayers,17,nil,count1)
	UnitReadX(FP,AllPlayers,23,nil,count2)
	UnitReadX(FP,AllPlayers,25,nil,count3)
	UnitReadX(FP,AllPlayers,73,nil,count4)
	UnitReadX(FP,AllPlayers,65,nil,count5)
	UnitReadX(FP,AllPlayers,30,nil,count6)
	CAdd(FP,count,count1)
	CAdd(FP,count,count2)
	CAdd(FP,count,count3)
	CAdd(FP,count,count4)
	CAdd(FP,count,count5)
	CAdd(FP,count,count6)
	local CurCunitI2 = CreateVar(FP)
	CIf(FP,{CD(NosBGM,1)},SetCD(NosBGM,0))
	TriggerX(FP,DeathsX(AllPlayers,AtLeast,1,12,0xFFFFFF),{SetV(BGMType,99)},{preserved})
	TriggerX(FP,{DeathsX(AllPlayers,Exactly,0,12,0xFFFFFF),CD(NextNosBGM,0),CV(BGMType,0)},{SetV(BGMType,2),SetCD(NextNosBGM,1)},{preserved})
	TriggerX(FP,{DeathsX(AllPlayers,Exactly,0,12,0xFFFFFF),CD(NextNosBGM,1),CV(BGMType,0)},{SetV(BGMType,3),SetCD(NextNosBGM,0)},{preserved})
	CIfEnd()

	IBGM_EPD(FP,6,nil,{12})
    AddBGM(1,"staredit\\wav\\Opening.ogg",23*1000)--오프닝
    AddBGM(2,"staredit\\wav\\NosBGM_2.ogg",32*1000)
    AddBGM(3,"staredit\\wav\\NosBGM_1.ogg",29*1000)
    AddBGM(4,"staredit\\wav\\BGM_1.ogg",41*1000)
    AddBGM(5,"staredit\\wav\\BGM_2.ogg",79*1000)
    AddBGM(6,"staredit\\wav\\BGM_3.ogg",62*1000)
    AddBGM(7,"staredit\\wav\\BGM_4.ogg",61*1000)
    AddBGM(8,"staredit\\wav\\BGM_5.ogg",84*1000)

	
	
    Install_BGMSystem(FP,6,BGMType,12)

	



	CIf(FP,{CD(Drop, 0)})
    EXCC_Part1(DUnitCalc) -- 죽은유닛 인식 단락 시작
    Check_Enemy = def_sIndex()
    NJump(FP,Check_Enemy,{DeathsX(CurrentPlayer,AtLeast,7,0,0xFF)})
--	f_SaveCp()
--	DUnitID = CreateVar(FP)
--	DPlayer = CreateVar(FP)
	DSound = CreateCcode()
--	local TempV = CreateVar(FP)
--	CMov(FP,DUnitID,_ReadF(BackupCP),nil,0xFF)
--	CMov(FP,TempV,BackupCP,6)
--	CMov(FP,DPlayer,_ReadF(TempV),nil,0xFF)

	DUArr={0,20,100,16,7,99,12,60}
	DCArr = {1,1,2,3,0,5,10,20}
	for i = 0, 6 do
		CIf(FP,{DeathsX(CurrentPlayer,Exactly,i,0,0xFF)})
		DoActions(FP,MoveCp(Add,6*4))
		local DUStrArr = {"\x0D\x0D\x0D"..ColorCode[i+1].."NM".._0D,"\x0D\x0D\x0D"..ColorCode[i+1].."HM".._0D,"\x0D\x0D\x0D"..ColorCode[i+1].."GM".._0D,"\x0D\x0D\x0D"..ColorCode[i+1].."NB".._0D,"\x0D\x0D\x0D"..ColorCode[i+1].."SV".._0D,"\x0D\x0D\x0D"..ColorCode[i+1].."TR".._0D,"\x0D\x0D\x0D"..ColorCode[i+1].."SN".._0D,"\x0D\x0D\x0D"..ColorCode[i+1].."QS".._0D,}
		for j= 1, 8 do
			CIf(FP,{DeathsX(CurrentPlayer,Exactly,DUArr[j],0,0xFF)})
			f_SaveCp()
			Trigger2X(FP,{},{SetScore(i,Add,DCArr[j],Custom),SetCD(DSound,1),RotatePlayer({DisplayTextX(DUStrArr[j],4)},HumanPlayers,FP)},{preserved})
			f_LoadCp()
			CIfEnd()
		end
		DoActions(FP,MoveCp(Subtract,6*4))
		CIfEnd()
	end

	f_LoadCp()
    




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
	CMov(FP,HIndex,_ReadF(BackupCp),nil,0xFF,1)
	HPointEPD = CreateVar(FP)
	CMov(FP,HPointEPD,_Div(HIndex,2),EPDF(0x663408))
	CMov(FP,HPoint,_ReadF(HPointEPD),nil,nil,1)
	f_Mod(FP,HIndex2,HIndex,2)
	NIfX(FP,{TMemory(_Mem(HIndex2),AtLeast,1)})
	f_Div(FP,HPoint,65536)
	NElseX()
	f_Mod(FP,HPoint,65536)
	NIfXEnd()
	CIfX(FP,{CV(HiddenPts,0),CV(HiddenPtsM,0)})
	CMov(FP,HPoint10,_Mul(HPoint,200))
	CElseX()
	CMov(FP,HPoint10,_Mul(HPoint,HPointVar))
	CIfXEnd()
	
	local HPointT = CreateVArr(4,FP)
	ItoDec(FP,HPoint10,VArr(HPointT,0),2,0x1F,0)

	--CMov(FP,0x57f120,HIndex)
	f_Movcpy(FP,_Add(HeroTxtStrPtr,Str19[2]+0x40+Str20[2]),VArr(HPointT,0),16)
	f_Memcpy(FP,_Add(HeroTxtStrPtr,Str19[2]),_Add(_Mul(HIndex,0x40),UnitNamePtr),0x40)
	CDoActions(FP,{TSetScore(Force1,Add,HPoint10,Kills)})
	HText = "\x0D\x0D\x0DHK".._0D
	DoActions(FP,CopyCpAction({DisplayTextX(HText,4)},HumanPlayers,FP))
	--
	CIfX(FP,{Never()})
	for j,k in pairs({27,61,68}) do
		CElseIfX({CV(HIndex,k)})
		Trigger2X(FP,{CDeaths(FP,AtMost,5,SoundLimit)},{CopyCpAction({PlayWAVX("staredit\\wav\\JRHKill.ogg"),PlayWAVX("staredit\\wav\\JRHKill.ogg"),PlayWAVX("staredit\\wav\\JRHKill.ogg")},HumanPlayers,FP),SetCDeaths(FP,Add,1,SoundLimit)},{preserved})
	end
	CElseX()
	Trigger2X(FP,{CDeaths(FP,AtMost,5,SoundLimit)},{CopyCpAction({PlayWAVX("staredit\\wav\\HeroKill.wav")},HumanPlayers,FP),SetCDeaths(FP,Add,1,SoundLimit)},{preserved})
	CIfXEnd()
	
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
	CMov(FP,0x6509B0,FP)
	CIfEnd()
	DoActions(FP, {KillUnit(188,P12)})
	CIf(FP,{CV(AtkSpeedMode,1,AtLeast)})
		
	for i = 0, 1699 do -- 공속무한모듈
		Trigger2(FP, {
			DeathsX(19025+(84*i)+19,AtMost,6,0,0xFF),
			DeathsX(19025+(84*i)+19,AtLeast,1*256,0,0xFF00),},{
			SetDeaths(19025+(84*i)+21,SetTo,0,0),
			SetDeathsX(19025+(84*i)+21,SetTo,0,1,0xFF00),
			},{preserved})
	end
	CIfEnd()


	TriggerX(FP,{CD(SoundLimit,5,AtMost),CD(DSound,1,AtLeast)},{SetCD(DSound,0),AddCD(SoundLimit,1),RotatePlayer({PlayWAVX("staredit\\wav\\die_se.ogg")},HumanPlayers,FP)},{preserved})
    DoActionsX(FP,SetCDeaths(FP,Add,1,SoundLimitT))
    TriggerX(FP,{CDeaths(FP,AtLeast,100,SoundLimitT)},{SetCDeaths(FP,SetTo,0,SoundLimit),SetCD(DSound,0),SetCDeaths(FP,SetTo,0,SoundLimitT)},{preserved})
	Install_GunStack()
	Create_G_CA_Arr()
	CMov(FP,0x6509B0,FP)
	
	countDisplayT = {}
	for i = 0, 6 do
	
		table.insert(countDisplayT,SetMemory(0x582234 + (i*4),SetTo,GunLimit*2))
		table.insert(countDisplayT,SetMemory(0x5821D4 + (i*4),SetTo,GunLimit*2))
	CMov(FP,0x582204+(4*i),count)
	CAdd(FP,0x582204+(4*i),count)
	end
	DoActions(FP,countDisplayT,1)
	DoActions(FP,{ModifyUnitHangarCount(1,All,82,P8,64),SetInvincibility(Enable,73,P8,64)})
	HangerT=CreateCcode()
	DoActionsX(FP,{AddCD(HangerT,1)})
	TriggerX(FP,{CD(HangerT,50,AtLeast)},{SetCD(HangerT,0),RemoveUnit(85,P8),ModifyUnitHangarCount(1,All,81,P8,64)},{preserved})
	DoActions(FP,{SetCp(FP),RunAIScriptAt("Expansion Zerg Campaign Insane",17);
	RunAIScriptAt("Value This Area Higher",4);},1)
	Trigger2(FP,{Command(FP,AtLeast,15,42)},{KillUnit(42,FP)},{preserved})
	Trigger2(FP,{Command(FP,AtLeast,30,35)},{KillUnit(35,FP)},{preserved})
	
	PyT = CreateCcode()
-- 193번 오브젝트 존재시 처리
CIf(FP,Command(AllPlayers,AtLeast,1,193))
DoActions(FP,{Simple_SetLoc(0,0,32,0,32)})
CWhile(FP,Bring(FP,AtLeast,1,193,64),{
	MoveLocation(1,193,FP,"Anywhere"),
	CreateUnit(1,84,1,FP),KillUnit(84,FP),
	GiveUnits(All,193,FP,"Anywhere",8)})
CWhileEnd()
DoActions(FP,{GiveUnits(All,193,8,"Anywhere",FP),Order(193,AllPlayers,"Anywhere",Move,4),SetSwitch("Switch 10",Random),SetSwitch("Switch 11",Random)})
CIf(FP,{Bring(FP,AtLeast,1,193,4),CD(PyT,0)},{SetCD(PyT,10),GiveUnits(1,193,FP,4,8),KillUnitAt(1,193,4,AllPlayers),SetSwitch(RandSwitch2,Random),SetSwitch(RandSwitch1,Random),AddCD(PyCCode,1)})
if X2_Mode == 1 then
	HealZoneSpawnArr = {{3552*2, 160*2},{3552*2, 416*2},{3872*2, 416*2},{3872*2, 160*2}}
else
	HealZoneSpawnArr = {{3552, 160},{3552, 416},{3872, 416},{3872, 160}}
end

if X2_Mode==1 then
	G_CA_SetSpawn({},{84},"ACAS","ObEffShape","MAX",nil,{3712*2,288*2},FP)
else
	G_CA_SetSpawn({},{84},"ACAS","ObEffShape","MAX",nil,{3712,288},FP)
end
for j, k in pairs(HealZoneSpawnArr) do
	f_TempRepeat({CD(GMode,2)},77,2,nil,nil,k)
	f_TempRepeat({CD(GMode,2)},78,2,nil,nil,k)
	f_TempRepeat({CD(GMode,2)},75,3,nil,nil,k)
	f_TempRepeat({CD(GMode,2)},88,4,nil,nil,k)
	f_TempRepeat({CD(GMode,3)},77,6,nil,nil,k)
	f_TempRepeat({CD(GMode,3)},78,6,nil,nil,k)
	f_TempRepeat({CD(GMode,3)},75,6,nil,nil,k)
	f_TempRepeat({CD(GMode,3)},88,15,nil,nil,k)
end
CMov(FP,0x6509B0,FP)
WaveArr = {
"staredit\\wav\\zealot1.ogg",
"staredit\\wav\\zealot2.ogg",
"staredit\\wav\\zealot3.ogg",
"staredit\\wav\\zealot4.ogg",
}
for i = 0, 3 do
	if i == 0 then RS1 = Cleared RS2=Cleared end
	if i == 1 then RS1 = Set RS2=Cleared end
	if i == 2 then RS1 = Cleared RS2=Set end
	if i == 3 then RS1 = Set RS2=Set end
	TriggerX(FP,{Switch(RandSwitch1,RS1),Switch(RandSwitch2,RS2)},{RotatePlayer({PlayWAVX(WaveArr[i+1]),PlayWAVX(WaveArr[i+1]),PlayWAVX(WaveArr[i+1])},HumanPlayers,FP)},{preserved})
end
CIfEnd()
CIfEnd()
-- 192번 오브젝트 존재시 처리
CIf(FP,Command(AllPlayers,AtLeast,1,192))
DoActions(FP,{Simple_SetLoc(0,0,32,0,32)})
CWhile(FP,Bring(FP,AtLeast,1,192,64),{
	MoveLocation(1,192,FP,"Anywhere"),
	CreateUnit(1,84,1,FP),KillUnit(84,FP),
	GiveUnits(All,192,FP,"Anywhere",8)})
CWhileEnd()
DoActions(FP,{GiveUnits(All,192,8,"Anywhere",FP),Order(192,AllPlayers,"Anywhere",Move,4),SetSwitch("Switch 10",Random),SetSwitch("Switch 11",Random)})
CIf(FP,{Bring(FP,AtLeast,1,192,4),CD(PyT,0)},{SetCD(PyT,10),GiveUnits(1,192,FP,4,8),KillUnitAt(1,192,4,AllPlayers),SetSwitch(RandSwitch2,Random),SetSwitch(RandSwitch1,Random),AddCD(PyCCode,1)})

if X2_Mode==1 then
	G_CA_SetSpawn({},{84},"ACAS","ObEffShape","MAX",nil,{3712*2,288*2},FP)
else
	G_CA_SetSpawn({},{84},"ACAS","ObEffShape","MAX",nil,{3712,288},FP)
end
for j, k in pairs(HealZoneSpawnArr) do
	f_TempRepeat({CD(GMode,2)},10,2,nil,nil,k)
	f_TempRepeat({CD(GMode,2)},17,2,nil,nil,k)
	f_TempRepeat({CD(GMode,2)},19,3,nil,nil,k)
	f_TempRepeat({CD(GMode,2)},21,4,nil,nil,k)
	f_TempRepeat({CD(GMode,3)},10,6,nil,nil,k)
	f_TempRepeat({CD(GMode,3)},17,6,nil,nil,k)
	f_TempRepeat({CD(GMode,3)},19,6,nil,nil,k)
	f_TempRepeat({CD(GMode,3)},21,15,nil,nil,k)
end
CMov(FP,0x6509B0,FP)
WaveArr = {
"sound\\Zerg\\BUGGUY\\ZBGPss00.wav",
"sound\\Zerg\\BUGGUY\\ZBGPss01.wav",
"sound\\Zerg\\BUGGUY\\ZBGPss02.wav",
"sound\\Zerg\\BUGGUY\\ZBGPss03.wav",
}
for i = 0, 3 do
	if i == 0 then RS1 = Cleared RS2=Cleared end
	if i == 1 then RS1 = Set RS2=Cleared end
	if i == 2 then RS1 = Cleared RS2=Set end
	if i == 3 then RS1 = Set RS2=Set end
	Trigger2X(FP,{Switch(RandSwitch1,RS1),Switch(RandSwitch2,RS2)},{RotatePlayer({PlayWAVX(WaveArr[i+1]),PlayWAVX(WaveArr[i+1]),PlayWAVX(WaveArr[i+1])},HumanPlayers,FP)},{preserved})
end
CIfEnd()
CIfEnd()
DoActionsX(FP,SubCD(PyT,1))
function InvDisable(Cond,UnitID,Player,Loc,Name)
txt = "\n\n\n\n\n\n\n\n\n\n\n\x13\x07※※※※※※※※※※※※\x1F ＮＯＴＩＣＥ\x07 ※※※※※※※※※※※※\n\n\n\x13\x03"..Name.."\x04의 \x08무적상태\x04가 해제되었습니다.\n\n\n\x13\x07※※※※※※※※※※※※\x1F ＮＯＴＩＣＥ\x07 ※※※※※※※※※※※※"
Wav = "staredit\\wav\\Unlock.ogg"
Trigger2X(FP,Cond,{
	MoveLocation(1,UnitID,Player,Loc);
	SetInvincibility(Disable,UnitID,Player,Loc);
	RotatePlayer({PlayWAVX(Wav);PlayWAVX(Wav);MinimapPing(1);DisplayTextX(txt,4);},HumanPlayers,FP)
})
end
TriggerX(FP,{CD(CocoonCcode,1,AtLeast),},{SetInvincibility(Disable, 21, FP, 64),SetInvincibility(Disable, 88, FP, 64),Order(88, FP, 23, Attack, 4),Order(21, FP, 23, Attack, 4)},{preserved})
InvDisable({CDeaths(FP,AtLeast,4,ChryCcode),CD(GeneCcode,1,AtLeast)},147,Force2,64,"Ｏｖｅｒｍｉｎｄ　Ｇ")
InvDisable({CDeaths(FP,AtLeast,4,FaciCcode)},200,Force2,64,"Ｇｅｎｅｒａｔｏｒ")
InvDisable({CDeaths(FP,AtLeast,10,PyCCode)},173,Force2,64,"Ｆｏｒｍａｔｉｏｎ")
InvDisable({CDeaths(FP,AtLeast,4,XelCcode)},127,Force2,64,"\x07쥬림 \x06산맥의 \x11결계")
InvDisable({CDeaths(FP,AtLeast,4,CereCcode),CDeaths(FP,AtLeast,4,CenCcode)},201,Force2,64,"Ｏｖｅｒｃｏｃｏｏｎ")
InvDisable({CDeaths(FP,AtLeast,3,CellCcode)},160,Force2,64,"Ｂｏｓｓ　Ｇａｔｅ")
InvDisable({
	CD(HactCcode,0,AtMost), -- 0일경우
	CD(LairCcode,0,AtMost), -- 0일경우
	CD(HiveCcode,0,AtMost), -- 0일경우
	CD(IonCcode,1,AtLeast), -- 1일경우
	CD(NexCcode,2,AtLeast), -- 2일경우
	CD(CocoonCcode,1,AtLeast), -- 1일경우
	CD(GeneCcode,1,AtLeast), -- 1일경우
	CD(OverGCcode,1,AtLeast), -- 1일경우
	CD(OvrmCcode,2,AtLeast), -- 2일경우
	CD(PsiCcode,1,AtLeast), -- 1일경우
	CD(BossCcode,1,AtLeast), -- 1일경우
	CV(CreateUnitQueueNum,0,AtMost) -- 유닛생성 큐에 아무것도 없어야됨
	
},174,Force2,64,"최후의 Ｔｅｍｐｌｅ")
function InvDisable2(Cond,UnitID,Player,Locs,Name)
txt = "\n\n\n\n\n\n\n\n\n\n\n\x13\x07※※※※※※※※※※※※\x1F ＮＯＴＩＣＥ\x07 ※※※※※※※※※※※※\n\n\n\x13\x03"..Name.."\x04의 \x08무적상태\x04가 해제되었습니다.\n\n\n\x13\x07※※※※※※※※※※※※\x1F ＮＯＴＩＣＥ\x07 ※※※※※※※※※※※※"
Wav = "staredit\\wav\\Unlock.ogg"
local X = {}
for j, k in pairs(Locs) do
	table.insert(X,MoveLocation(1,UnitID,Player,k))
	table.insert(X,SetInvincibility(Disable,UnitID,Player,k))
	table.insert(X,RotatePlayer({MinimapPing(1)},HumanPlayers,FP))
end
	table.insert(X,RotatePlayer({PlayWAVX(Wav);PlayWAVX(Wav);DisplayTextX(txt,4)},HumanPlayers,FP))
Trigger2X(FP,Cond,X)
end
InvDisable2(CD(FormCcode,1),168,FP,{24,25,26},"Ｓｔａｓｉｓ　Ｃｅｌｌ")
Trigger2X(FP,{CommandLeastAt(160,27),Memory(0x628438,AtLeast,1)},{CreateUnit(1,65,27,FP),
RotatePlayer({TalkingPortrait(68, 2000),PlayWAVX("sound\\Protoss\\ARCHON\\PArYes02.WAV"),PlayWAVX("sound\\Protoss\\ARCHON\\PArYes02.WAV")},HumanPlayers,FP);})
CIf(FP,{CommandLeastAt(160,27),CD(BossCcode,0)},{ModifyUnitShields(All,65,FP,64,100)})
DoActions(FP,{Simple_SetLoc(0,0,0,64,64),MoveLocation(1,65,FP,64)})
BossT = CreateCcode()
DoActionsX(FP,{SubCD(BossT,1)})
TriggerX(FP,{CD(GMode,2,Exactly),CD(BossT,0)},{AddCD(BossT,20),CreateUnit(1,12,1,FP),KillUnit(12,FP),CreateUnit(9,70,1,FP),Order(70,FP,64,Patrol,1)},{preserved})
TriggerX(FP,{CD(GMode,3,Exactly),CD(BossT,0)},{AddCD(BossT,20),CreateUnit(1,12,1,FP),KillUnit(12,FP),CreateUnit(20,70,1,FP),Order(70,FP,64,Patrol,1)},{preserved})
TriggerX(FP,{CD(GMode,2,AtLeast),CD(BossT,5)},{KillUnit(70,FP)},{preserved})

Trigger2X(FP,{Bring(FP,AtMost,0,65,64)},{AddCD(BossCcode,1),SetScore(Force1,Add,1000000,Kills),KillUnit(70,FP),RotatePlayer({PlayWAVX("staredit\\wav\\BossKill.ogg"),PlayWAVX("staredit\\wav\\BossKill.ogg"),PlayWAVX("staredit\\wav\\BossKill.ogg"),PlayWAVX("staredit\\wav\\BossKill.ogg"),PlayWAVX("staredit\\wav\\BossKill.ogg"),DisplayTextX("\n\n\n\n\n\n\n\n\n\n\n\x13\x07※※※※※※※※※※※※\x08 N O T I C E\x07 ※※※※※※※※※※※※\n\n\n\x13\x04적의 \x08수호자 \x07Nought \x04가 쓰러졌습니다.\n\x13\x10+\x17 1000000 P t s \n\n\x13\x07※※※※※※※※※※※※\x08 N O T I C E\x07 ※※※※※※※※※※※※",4)},HumanPlayers,FP)})
CIfEnd()

Win = CreateCcode()
Trigger2X(FP,{CommandLeastAt(174,64);},{CopyCpAction({DisplayTextX("\n\n\n\n\n\n\n\n\n\n\n\x13\x08※※※※※※※※※※※※\x07 N O T I C E\x08 ※※※※※※※※※※※※\n\n\n\x13\x08최후의 건물 \x04Temple이 \x08파괴\x04되었습니다.\n\n\n\x13\x08※※※※※※※※※※※※\x07 N O T I C E\x08 ※※※※※※※※※※※※",4);
PlayWAVX("staredit\\wav\\E_Clear.ogg");
PlayWAVX("staredit\\wav\\E_Clear.ogg");
PlayWAVX("staredit\\wav\\E_Clear.ogg");},HumanPlayers,FP),SetCDeaths(FP,Add,1,Win)})

CIfX(FP,CDeaths(FP,AtLeast,1,Win))
DoActionsX(FP,SetCDeaths(FP,Add,1,Win))

ClearTextArr = {
"\n\n\n\n\n\n\n\n\n\n\n\x13\x04-\n\n\n\n\x13\x04-\n\n\n",
"\n\n\n\n\n\n\n\n\n\n\n\x13\x04- -\n\n\n\n\x13\x04- -\n\n\n",
"\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - -\n\n\n\n\x13\x04- - -\n\n\n",
"\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - -\n\n\n\n\x13\x04- - - -\n\n\n",
"\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - - -\n\n\n\n\x13\x04- - - - -\n\n\n",
"\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - - - -\n\n\n\n\x13\x04- - - - - -\n\n\n",
"\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - - - - -\n\n\n\n\x13\x04- - - - - - -\n\n\n",
"\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - - - - - -\n\n\n\n\x13\x04- - - - - - - -\n\n\n",
"\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - - - - - - -\n\n\n\n\x13\x04- - - - - - - - -\n\n\n",
"\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - - - - - - - -\n\n\n\n\x13\x04- - - - - - - - - -\n\n\n",
"\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - - - - - - - - -\n\n\n\n\x13\x04- - - - - - - - - - -\n\n\n",
"\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - - - - - - - - - -\n\n\n\n\x13\x04- - - - - - - - - - - -\n\n\n",
"\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - - - - - - - - - - -\n\n\n\n\x13\x04- - - - - - - - - - - - -\n\n\n",
"\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - - - - - - - - - - - -\n\n\n\n\x13\x04- - - - - - - - - - - - - -\n\n\n"}

for j, k in pairs(ClearTextArr) do
	Trigger2X(FP,{CD(Win,140+(j*10),AtLeast)},{RotatePlayer({DisplayTextX(k,4)},HumanPlayers,FP)})
end

PlayersT = {"\x081인","\x0E2인","\x0F3인","\x104인","\x115인","\x186인","\x167인"}
GModeT = {"\x0EEASY","\x08HARD","\x11BURST"}

for i = 1, 3 do
for k = 1, 7 do



	ClearText1 = "\n\n\n\n\n\n\n\n\n\x13\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x04 축하드립니다 \x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\n\x13\x04- - - - - - - - - - - - - -\n\x13\x03★ \x04마 린 키 우 기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04:\x1FRe\x11B\x01∞\x07t \x03★"
	ClearText2 = "\x13"..PlayersT[k]..", "..GModeT[i].." Mode"
	ClearText3 = "\x13\x04클리어 하셨습니다.\n\x13\x04Creator - GALAXY_BURST\n\x13\x04- - - - - - - - - - - - - -\n\x13\x04Thanks For Playing\n\x13\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x04 축하드립니다 \x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆"
	ClearText4 = "\x13\x18Hidden Mode \x04적용됨"
	--ClearText5 = "HD".._0D
	

Trigger2X(FP,{
	CDeaths(FP,AtMost,#HiddenCommand-1,HiddenMode),
	CDeaths(FP,Exactly,i,GMode);
	CVar(FP,SetPlayers[2],Exactly,k);
	CDeaths(FP,AtLeast,280,Win);
},RotatePlayer({
	DisplayTextX(ClearText1,4);
	DisplayTextX(ClearText2,4);
	DisplayTextX(ClearText3,4);
	PlayWAVX("staredit\\wav\\clear2.ogg");
	PlayWAVX("staredit\\wav\\clear2.ogg");
	PlayWAVX("staredit\\wav\\clear2.ogg");},HumanPlayers,FP))


	Trigger2X(FP,{
		CDeaths(FP,AtLeast,#HiddenCommand,HiddenMode),
		CDeaths(FP,Exactly,i,GMode);
		CVar(FP,SetPlayers[2],Exactly,k);
		CDeaths(FP,AtLeast,280,Win);
	},RotatePlayer({
		DisplayTextX(ClearText1,4);
		DisplayTextX(ClearText2,4);
		DisplayTextX(ClearText4,4);
		PlayWAVX("staredit\\wav\\clear2.ogg");
		PlayWAVX("staredit\\wav\\clear2.ogg");
		PlayWAVX("staredit\\wav\\clear2.ogg");},HumanPlayers,FP)
	)



	
end
end

CIfOnce(FP,{
	CDeaths(FP,AtLeast,#HiddenCommand,HiddenMode),
	CDeaths(FP,AtLeast,280,Win);})
DisplayPrint(HumanPlayers,{"\x13\x10[ \x04(\x08HP \x04: ",HiddenColor[1][2],HiddenDisplay[1],"\x04) (\x1BATK \x04: ",HiddenColor[2][2],HiddenDisplay[2],"\x04) (\x1FPts \x04: ",HiddenColor[3][2],HiddenDisplay[3],"\x04) (\x10혼돈 옵션 \x04: ",hondondisplay,"\x04) (\x1F공속무한모드 \x04: ",AtkSpeedDisplay,"\x04)  \x10]"})
DoActions2(FP, {RotatePlayer({
	DisplayTextX(ClearText3,4);}, HumanPlayers, FP)})
CIfEnd()

function DisplayDeathRank(Player,GM,Sc1,Sc2,Text,GameOverFlag)
	local X = nil
	local Y = nil
	local Z = nil
	if GameOverFlag ~= nil then X = Defeat() else X = Victory() end
	if Sc1 ~= nil then Y = Score(Player,Custom,AtLeast,Sc1) end
	if Sc2 ~= nil then Z = Score(Player,Custom,AtMost,Sc2) end
	TriggerX(FP,{CD(GMode,GM),CDeaths(FP,AtLeast,760,Win),Y,Z},{SetCp(Player),DisplayText(Text,4),PlayWAV("staredit\\wav\\HeroKill.wav"),PlayWAV("staredit\\wav\\HeroKill.wav"),X,SetCp(FP)})
end

--\n
ScoreBoardArr = {
	{
		{0,1},{2,10},{11,20},{21,50},{51,100},{101,200},{201,300},{301,99999999}--이지
	},
	{
		{0,3},{4,12},{13,25},{26,65},{66,100},{101,200},{201,300},{301,99999999}--하드
	},
	{
		{0,5},{6,15},{16,30},{31,70},{71,100},{101,200},{201,300},{301,99999999}--버
	}
}

RankTextArr = {
"\x07GOD \x04- \x04마린키우기의 신 인정합니다.",
"\x07S \x04- \x04당신은 초고수입니다.",
"\x0EA \x04- \x04열심히 하셧네요. 조금만 더 힘내봅시다.",
"\x0FB \x04- \x04살짝 아쉽네요. ㅠㅠ",
"\x10C \x04- \x04너무 많이 죽었네요...힘내시길 바랍니다.",
"\x15D \x04- \x04메딕을 잘 활용해보시기 바랍니다.",
"\x17E \x04- \x04게임오버는 피하셨네요;;",
"\x08Game Over \x04- \x04저런... 얼마나 죽으신 겁니까? 좀 더 분발하세요"}
RankTextArr2 = {
"\x13\x07GOD\x04 - \x04",
"\x13\x07S\x04 - \x04",
"\x13\x0EA\x04 - \x04",
"\x13\x0FB\x04 - \x04",
"\x13\x10C\x04 - \x04",
"\x13\x15D\x04 - \x04",
"\x13\x17E\x04 - \x04",
"\x13\x08Game Over\x04 - \x04"}
ScoreBoardTextArr = {
	{},{},{}
}
for j, k in pairs(ScoreBoardArr) do
	for l,m in pairs(k) do
		local X = m[2]
		if l == 8 then X = "" end
		table.insert(ScoreBoardTextArr[j],RankTextArr2[l])
		table.insert(ScoreBoardTextArr[j],m[1].." ～ "..X.."\n")
	end
end
for i = 1, 3 do
	TriggerX(FP,{CD(GMode,i),CD(Win,500,AtLeast)},{RotatePlayer({PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav"),DisplayTextX("\x13"..DifLeaderBoard[i].." \x07ScoreBoard \x04-\n"..table.concat(ScoreBoardTextArr[i]),4),},HumanPlayers,FP)})
end
for i = 0, 6 do
	for j, k in pairs(ScoreBoardArr) do
		for l,m in pairs(k) do
			
			local X = nil
			if l==8 then X = 1 end
			DisplayDeathRank(i,j,m[1],m[2],"\x13\x08Death\x04Rank \x04: "..RankTextArr[l],X)
		end
	end
	--TriggerX(FP,{CD(GMode,3),Score(i,Custom,AtMost,70)},{SetCp(i),DisplayText("\x13\x07GOD \x04Rank 보상 : 히든 활성화\x13\x04스크린샷으로 이 문구를 제작자에게 보여주세요.",4),SetCp(FP)})
end



CElseIfX({Switch("Switch 201",Set),CD(DMode,2,AtLeast)},{SetMemory(0x59CC80,SetTo,0),SetCtrigX("X",0xFFFD,0x4,0,SetTo,"X",0xFFFD,0x0,0,1)})--관전이고 뭐고 모두 ExitDrop 실행
CIfXEnd()
DoActions(FP,{SetResources(FP,Add,0x12345678,OreAndGas)},1)
TriggerX(FP,{Deaths(FP,AtLeast,4,10)},{SetMemoryX(0x663ECC, SetTo, 400,0xFFFF);
})
TriggerX(FP,{ElapsedTimeX(AtMost,390)},{
	ModifyUnitEnergy(All,71,FP,64,20),
	ModifyUnitEnergy(All,63,FP,64,20),
	ModifyUnitEnergy(All,67,FP,64,20),
},{preserved})


ObCcode2 = CreateCcode()
ObChatMode = CreateCcode()
	CIf(FP,{Memory(0x512684,AtLeast,128),Memory(0x512684,AtMost,131)})
	CIfX(FP,{KeyPress("HOME", "Down"),CD(ObCcode2,0)})
	CTrigger(FP,{CD(ObChatMode,0),CD(ObCcode2,0)},{SetCD(ObChatMode,1),SetCD(ObCcode2,1),
	TSetMemory(0x6509B0,SetTo,_Read(0x512684)),PlayWAV("staredit\\wav\\button3.wav"),DisplayText(StrDesign("\x07채팅→전체\x04에게 메세지를 보냅니다."),4),SetCp(FP)},{preserved})
	CTrigger(FP,{CD(ObChatMode,1),CD(ObCcode2,0)},{SetCD(ObChatMode,0),SetCD(ObCcode2,1),
	TSetMemory(0x6509B0,SetTo,_Read(0x512684)),PlayWAV("staredit\\wav\\button3.wav"),DisplayText(StrDesign("\x1C채팅→관전자\x04에게 메세지를 보냅니다."),4),SetCp(FP)},{preserved})
	CElseIfX({KeyPress("HOME", "Down")},SetCD(ObCcode2,1))
	CElseX(SetCD(ObCcode2,0))
	CIfXEnd()
	Trigger { --ObserverChatToOb
		players = {FP},
		conditions = {
			Label();
			CD(ObChatMode,0);
			Memory(0x68C144,AtLeast,1);
		},
		actions = {
			SetMemory(0x68C144,SetTo,5);
			PreserveTrigger();
		},
	}
	Trigger { --ObserverChatToAll
		players = {FP},
		conditions = {
			Label();
			CD(ObChatMode,1);
			Memory(0x68C144,AtLeast,1);
		},
		actions = {
			SetMemory(0x68C144,SetTo,2);
			PreserveTrigger();
		},
	}
	CIfEnd()


end

function CreateUnitQueue()
	
	local G_CA_Nextptrs = CreateVar(FP)
	local TempUID = CreateVar(FP)
	local TempPID = CreateVar(FP)
	local TempType = CreateVar(FP)
	if Limit == 1 then
--		CIf(FP,{CD(TestMode,1)})
--		--DisplayPrintEr(0,{"\x07『 \x03TESTMODE OP \x04: CreateUnitQueuePtr : ",CreateUnitQueuePtr," || CreateUnitQueuePtr2 : ",CreateUnitQueuePtr2," \x07』"})
--		local TestV = CreateVar()
--		CMov(FP,TestV,0)
--		CFor(FP, 19025+19, 19025+19 + (84*1700), 84)
--			local CI = CForVariable()
--			CTrigger(FP, {TMemoryX(CI,AtLeast,1*256,0xFF00)}, {AddV(TestV,1)},1)
--		CForEnd()
		--DisplayPrintEr(0,{"\x07『 \x03TESTMODE OP \x04: CUnit Count : ",TestV," \x07』"})--

--		CIfEnd()
	end
	NWhile(FP,{CV(count,1500,AtMost),Memory(0x628438,AtLeast,1),CV(CreateUnitQueueNum,1,AtLeast)},{})
	f_Read(FP,0x628438,"X",G_CA_Nextptrs,0xFFFFFF)
	f_SHRead(FP, _Add(CreateUnitQueueXPosArr,CreateUnitQueuePtr2), CPosX)
	f_SHRead(FP, _Add(CreateUnitQueueYPosArr,CreateUnitQueuePtr2), CPosY)
	f_SHRead(FP, _Add(CreateUnitQueueUIDArr,CreateUnitQueuePtr2), TempUID)
	f_SHRead(FP, _Add(CreateUnitQueuePIDArr,CreateUnitQueuePtr2), TempPID)
	f_SHRead(FP, _Add(CreateUnitQueueTypeArr,CreateUnitQueuePtr2), TempType)
	CDoActions(FP, {
		TSetMemory(_Add(CreateUnitQueueXPosArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueueYPosArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueueUIDArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueuePIDArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueueTypeArr,CreateUnitQueuePtr2), SetTo, 0)
	})
	DoActionsX(FP,{AddV(CreateUnitQueuePtr2,1),SubV(CreateUnitQueueNum,1)})
	TriggerX(FP, {CV(CreateUnitQueuePtr2,50000,AtLeast)},{SetV(CreateUnitQueuePtr2,0)},{preserved})





	NIf(FP,{CV(TempUID,1,AtLeast),CV(TempUID,226,AtMost)})
	local CRLID = CreateVar(FP)

	
	DoActions(FP,{SetSwitch(RandSwitch1,Random),SetSwitch(RandSwitch2,Random)})
	for i = 0, 3 do
		if i == 0 then RS1 = Cleared RS2=Cleared end
		if i == 1 then RS1 = Set RS2=Cleared end
		if i == 2 then RS1 = Cleared RS2=Set end
		if i == 3 then RS1 = Set RS2=Set end
		TriggerX(FP,{Switch(RandSwitch1,RS1),Switch(RandSwitch2,RS2)},{SetV(CRLID,43+i)},{preserved})
	end


	TriggerX(FP,{CVar(FP,TempPID[2],Exactly,0xFFFFFFFF)},{SetCVar(FP,TempPID[2],SetTo,7)},{preserved})
	CTrigger(FP,{TTCVar(FP,TempType[2],NotSame,2)},{TCreateUnitWithProperties(1,TempUID,CRLID,TempPID,{energy = 100})},1)
	CTrigger(FP,{CVar(FP,TempType[2],Exactly,2)},{TCreateUnitWithProperties(1,TempUID,CRLID,TempPID,{energy = 100, burrowed = true})},1)
	



	Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)

	



	NIf(FP,{TMemoryX(_Add(G_CA_Nextptrs,40),AtLeast,150*16777216,0xFF000000)})

	CIf(FP,{TTOR({CV(TempUID,25),CV(TempUID,30)})})
		CDoActions(FP,{
			TSetDeathsX(_Add(G_CA_Nextptrs,72),SetTo,0xFF*256,0,0xFF00),})
	CIfEnd()
	
	CTrigger(FP,{CVar(FP,HondonMode[2],AtLeast,1)},{
		TSetMemoryX(_Add(G_CA_Nextptrs,8),SetTo,127*65536,0xFF0000),
		TSetMemory(_Add(G_CA_Nextptrs,13),SetTo,20000),
		TSetMemoryX(_Add(G_CA_Nextptrs,18),SetTo,4000,0xFFFF),
		},1)
	f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
	Convert_CPosXY()
	Simple_SetLocX(FP,15,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(15,-4,-4,4,4)})
	CDoActions(FP,{TMoveUnit(1,TempUID,Force2,16,1)})

		CIfX(FP,CVar(FP,TempType[2],Exactly,0))
			f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CDoActions(FP,{
				TOrder(TempUID, Force2, 1, Attack, 4);
			})
		CElseIfX(CVar(FP,TempType[2],Exactly,187))
			CDoActions(FP,{
				TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
			})

		CElseIfX(CVar(FP,TempType[2],Exactly,189))
		CDoActions(FP,{
			TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
			TCreateUnitWithProperties(1,84,1,TempPID,{energy = 100}),TRemoveUnit(84,TempPID)
		})
		CElseIfX(CVar(FP,TempType[2],Exactly,190))
			f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CTrigger(FP,{CVar(FP,HondonMode[2],Exactly,0)},{
				TSetMemory(_Add(G_CA_Nextptrs,13),SetTo,1920),
				},1)
			CTrigger(FP,{CVar(FP,HondonMode[2],AtLeast,1)},{
				TSetMemory(_Add(G_CA_Nextptrs,13),SetTo,20000),
				},1)
			CDoActions(FP,{
				TOrder(TempUID, Force2, 1, Attack, 4);
				TSetDeathsX(_Add(G_CA_Nextptrs,72),SetTo,0xFF*256,0,0xFF00),
				TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0xA00000,0xA00000),
				
			})

		CElseIfX(CVar(FP,TempType[2],Exactly,188))
			--CIfX(FP,CVar(FP,HondonMode[2],AtMost,0))
			TempSpeedVar = f_CRandNum(4000)
			CDoActions(FP,{
				TSetDeaths(_Add(G_CA_Nextptrs,13),SetTo,TempSpeedVar,0),
				TSetDeathsX(_Add(G_CA_Nextptrs,18),SetTo,TempSpeedVar,0,0xFFFF)})
			--CElseX()
			--CDoActions(FP,{
			--	TSetDeaths(_Add(G_CA_Nextptrs,13),SetTo,12000,0),
			--	TSetDeathsX(_Add(G_CA_Nextptrs,18),SetTo,4000,0,0xFFFF)})
			--CIfXEnd()
			CDoActions(FP,{
				TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
			})

		CElseIfX(CVar(FP,TempType[2],Exactly,147))
		f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
		Convert_CPosXY()
		Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
		CDoActions(FP,{
			TOrder(TempUID, Force2, 1, Attack, 23);
			TSetMemory(_Add(G_CA_Nextptrs,13),SetTo,128),
			TSetMemoryX(_Add(G_CA_Nextptrs,18),SetTo,128,0xFFFF),
			TSetDeathsX(_Add(G_CA_Nextptrs,72),SetTo,0xFF*256,0,0xFF00),
			TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0xA00000,0xA00000),
			CreateUnit(1,84,1,FP),KillUnit(84,FP)
		})

		CElseIfX(CVar(FP,TempType[2],Exactly,3))
			CDoActions(FP,{
				TSetDeathsX(_Add(G_CA_Nextptrs,72),SetTo,0xFF*256,0,0xFF00)})
		CElseIfX(CVar(FP,TempType[2],Exactly,84))
		CDoActions(FP,{
			TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0xA00000,0xA00000),KillUnit(84,FP)
		})

		CElseIfX(CVar(FP,TempType[2],Exactly,201))
		f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
		Convert_CPosXY()
		Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
		CDoActions(FP,{
			TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0x04000000,0x04000000),
			TOrder(TempUID, Force2, 1, Move, 36);
		})
		CElseIfX(CVar(FP,TempType[2],Exactly,2))
		CElseX()
			DoActions(FP,RotatePlayer({DisplayTextX(f_RepeatTypeErr,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP))
		CIfXEnd()
		


	NIfEnd()
	NIfEnd()

	NWhileEnd()
	
CIf(FP,{Switch("Switch 201",Set)})
FixText(FP, 1)
DisplayPrint(HumanPlayers,{"\x07『 \x04CreateUnit\x07Queue \x04: ",CreateUnitQueueNum," / \x0850000 \x07』"})
FixText(FP, 2)
CIfEnd()
end