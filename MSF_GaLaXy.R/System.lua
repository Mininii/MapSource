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
    AddBGM(4,"staredit\\wav\\BGM_1.ogg",41*1000)
    AddBGM(5,"staredit\\wav\\BGM_2.ogg",79*1000)
    AddBGM(6,"staredit\\wav\\BGM_3.ogg",62*1000)
    AddBGM(7,"staredit\\wav\\BGM_4.ogg",61*1000)

	
	
    Install_BGMSystem(FP,3,BGMType,12)

	
    EXCC_Part1(DUnitCalc) -- 죽은유닛 인식 단락 시작
    Check_Enemy = def_sIndex()
    NJump(FP,Check_Enemy,{DeathsX(CurrentPlayer,AtLeast,7,0,0xFF)})
    DoActions(FP,MoveCp(Add,6*4))
	f_SaveCp()
	DUnitID = CreateVar(FP)
	DPlayer = CreateVar(FP)
	DSound = CreateCcode()
	local TempV = CreateVar(FP)
	CMov(FP,DUnitID,_ReadF(BackupCP),nil,0xFF)
	CMov(FP,TempV,BackupCP,6)
	CMov(FP,DPlayer,_ReadF(TempV),nil,0xFF)
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
	
	for i=1,9 do -- 파일런 갯수마다 벙커 체력 설정
	TriggerX(FP,{CD(PyCCode,i)},{ModifyUnitHitPoints(All,125,AllPlayers,21,100-(10*i));},{preserved})
	end
	
-- 193번 오브젝트 존재시 처리
CIf(FP,Command(AllPlayers,AtLeast,1,193))
DoActions(FP,{Simple_SetLoc(0,0,32,0,32)})
CWhile(FP,Bring(FP,AtLeast,1,193,64),{
	MoveLocation(1,193,FP,"Anywhere"),
	CreateUnit(1,84,1,FP),KillUnit(84,FP),
	GiveUnits(All,193,FP,"Anywhere",8)})
CWhileEnd()
DoActions(FP,{GiveUnits(All,193,8,"Anywhere",FP),Order(193,AllPlayers,"Anywhere",Move,4),SetSwitch("Switch 10",Random),SetSwitch("Switch 11",Random)})
CIf(FP,Bring(FP,AtLeast,1,193,4),{GiveUnits(1,193,FP,4,8),KillUnitAt(1,193,4,AllPlayers),SetSwitch(RandSwitch2,Random),SetSwitch(RandSwitch1,Random),AddCD(PyCCode,1)})
HealZoneSpawnArr = {{3552, 160},{3552, 416},{3872, 416},{3872, 160}}
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
CSPlot(CSMakeStar(5,108,128,126,PlotSizeCalc(5*2,2),0),FP,84,0,{3712,288},1,32,FP,nil,{KillUnit(84,FP)},1)
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
	TriggerX(FP,{Switch(RandSwitch1,RS1),Switch(RandSwitch2,RS2)},{RotatePlayer({PlayWAVX(WaveArr[i+1]),PlayWAVX(WaveArr[i+1]),PlayWAVX(WaveArr[i+1])},HumanPlayers,FP)},{Preserved})
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
CIf(FP,Bring(FP,AtLeast,1,192,4),{GiveUnits(1,192,FP,4,8),KillUnitAt(1,192,4,AllPlayers),SetSwitch(RandSwitch2,Random),SetSwitch(RandSwitch1,Random),AddCD(PyCCode,1)})
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
CSPlot(CSMakeStar(5,108,128,126,PlotSizeCalc(5*2,2),0),FP,84,0,{3712,288},1,32,FP,nil,{KillUnit(84,FP)},1)
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
	Trigger2X(FP,{Switch(RandSwitch1,RS1),Switch(RandSwitch2,RS2)},{RotatePlayer({PlayWAVX(WaveArr[i+1]),PlayWAVX(WaveArr[i+1]),PlayWAVX(WaveArr[i+1])},HumanPlayers,FP)},{Preserved})
end
CIfEnd()
CIfEnd()
function InvDisable(Cond,UnitID,Player,Loc,Name)
txt = "\n\n\n\n\n\n\n\n\n\n\n\x13\x07※※※※※※※※※※※※\x1F ＮＯＴＩＣＥ\x07 ※※※※※※※※※※※※\n\n\n\x13\x03"..Name.."\x04의 \x08무적상태\x04가 해제되었습니다.\n\n\n\x13\x07※※※※※※※※※※※※\x1F ＮＯＴＩＣＥ\x07 ※※※※※※※※※※※※"
Wav = "staredit\\wav\\Unlock.ogg"
Trigger2X(FP,Cond,{
	MoveLocation(1,UnitID,Player,Loc);
	SetInvincibility(Disable,UnitID,Player,Loc);
	RotatePlayer({PlayWAVX(Wav);PlayWAVX(Wav);MinimapPing(1);DisplayTextX(txt,4);},HumanPlayers,FP)
})
end
InvDisable({CDeaths(FP,AtLeast,4,ChryCcode)},147,Force2,64,"Ｏｖｅｒｍｉｎｄ　Ｇ")
InvDisable({CDeaths(FP,AtLeast,4,FaciCcode)},200,Force2,64,"Ｇｅｎｅｒａｔｏｒ")
InvDisable({CDeaths(FP,AtLeast,9,PyCCode)},173,Force2,64,"Ｆｏｒｍａｔｉｏｎ")
InvDisable({CDeaths(FP,AtLeast,4,XelCcode)},127,Force2,64,"\x07쥬림 \x06산맥의 \x11결계")
InvDisable({CDeaths(FP,AtLeast,4,CereCcode),CDeaths(FP,AtLeast,4,CenCcode)},201,Force2,64,"Ｏｖｅｒｃｏｃｏｏｎ")

end