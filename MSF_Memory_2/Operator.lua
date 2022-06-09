function Operator_Trig()
    Cunit2 = CreateVar(FP)
	local DtX = CreateVar(FP)
	
	BanCode = CreateCcodeArr(3)
	DoActions(FP,{
		SetMemoryB(0x57F27C + (0 * 228) + 60,SetTo,0),
		SetMemoryB(0x57F27C + (1 * 228) + 60,SetTo,0),
		SetMemoryB(0x57F27C + (2 * 228) + 60,SetTo,0),
		SetMemoryB(0x57F27C + (3 * 228) + 60,SetTo,0),
		SetMemoryB(0x57F27C + (0 * 228) + 23,SetTo,0),
		SetMemoryB(0x57F27C + (1 * 228) + 23,SetTo,0),
		SetMemoryB(0x57F27C + (2 * 228) + 23,SetTo,0),
		SetMemoryB(0x57F27C + (3 * 228) + 23,SetTo,0)
	})
	for i = 0, 3 do
		CIf(FP,{HumanCheck(i,1),})

        f_Read(FP,0x6284E8+(0x30*i),"X",Cunit2)
		CIf(FP,{CVar(FP,Cunit2[2],AtLeast,19025),CVar(FP,Cunit2[2],AtMost,19025+(1700*84))})

		CMov(FP,0x6509B0,Cunit2,25)

		CIf(FP,{DeathsX(CurrentPlayer,Exactly,111,0,0xFF)})
		
			CAdd(FP,0x6509B0,62-25)
			CIf(FP,{TTDeaths(CurrentPlayer,NotSame,BarRally[i+1],0)}) --배럭랠리 갱신
				f_SaveCp()
				f_Read(FP,BackupCp,BarRally[i+1])
				--if Limit == 1 then
				--CIf(FP,CD(TestMode,1))
				--CMov(FP,CPos,BarRally[i+1])
				--Convert_CPosXY()
				--Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{CreateUnit(1,"Dark Swarm",1,P8)})
				--CIfEnd()
				--end
				f_LoadCp()
			CIfEnd()
			CSub(FP,0x6509B0,62-25)

			CIfOnce(FP) -- 배럭위치 초기세팅
				CSub(FP,0x6509B0,15)
				f_SaveCp()
				f_Read(FP,BackupCp,BarPos[i+1])
				f_LoadCp()
				CAdd(FP,0x6509B0,15)
			CIfEnd()

		CIfEnd()


		CIf(FP,{DeathsX(CurrentPlayer,Exactly,117,0,0xFF)})
			CSub(FP,0x6509B0,6)
			CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00)})

				DoActionsX(FP,{
					SetMemory(0x6509B0,Subtract,17),SetDeaths(CurrentPlayer,Subtract,256*75,0),
				})
				TriggerX(FP,{Deaths(CurrentPlayer,Exactly,0,0)},{SetMemory(0x6509B0,Add,17),SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00),SetMemory(0x6509B0,Subtract,17)},{preserved})
				
				CAdd(FP,0x6509B0,53)
				DoActions(FP, SetDeathsX(CurrentPlayer,SetTo,0,0,0x04000000))
				CSub(FP,0x6509B0,53-7)
				Trigger2X(FP,{DeathsX(CurrentPlayer,Exactly,0,0,0xFF0000)},{
					SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000),
					SetMemory(0x582204+(0*4),Add,2),
					SetMemory(0x582204+(1*4),Add,2),
					SetMemory(0x582204+(2*4),Add,2),
					SetMemory(0x582204+(3*4),Add,2),
					SetCDeaths(FP,Add,1,EEggCode),
					AddV(RedNumberT,-9000*10),
					RotatePlayer({DisplayTextX("\x0D\x0D\x0D"..PlayerString[i+1].."EEgg".._0D,4),PlayWAVX("staredit\\wav\\EEgg.ogg")},HumanPlayers,FP)},{preserved})
				
			CIfEnd()

		CIfEnd()

		CIfEnd()
		CIfEnd()
		CMov(FP,0x6509B0,FP)
	end
    CIfX(FP,Never()) -- 상위플레이어 단락 시작
	for i = 0, 3 do
        CElseIfX(HumanCheck(i,1),{SetCVar(FP,CurrentOP[2],SetTo,i),SetMemoryB(0x57F27C + (i * 228) + 60,SetTo,1)})
		
		TriggerX(FP,{CD(Theorist,0),ElapsedTime(AtMost,59)},SetMemoryB(0x57F27C + (i * 228) + 23,SetTo,1),{preserved})
        f_Read(FP,0x6284E8+(0x30*i),"X",Cunit2)
        f_Read(FP,0x58A364+(48*181)+(4*i),DtX) -- MSQC val Recive. 181
		CTrigger(FP,{CV(DtX,2500,AtMost)},{SetV(Dt,DtX)},1)
		CAdd(FP,RedNumberT,Dt)
	end
    CIfXEnd()
	TestVar = CreateVar(FP)
	if Limit == 1 then
	CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
	TriggerX(FP,{Switch("Switch 253",Cleared),ElapsedTime(AtMost, 60),Deaths(CurrentPlayer,AtLeast,1,199)},{SetCD(CheatMode,1)})--에라응머즐 활성화
	TriggerX(FP,{Switch("Switch 253",Set),Deaths(CurrentPlayer,AtLeast,1,199)},{SetCD(TestMode,1),SetSwitch("Switch 254",Set),SetMemory(0x657A9C,SetTo,31)})
	CIf({FP},CD(TestMode,1)) -- 테스트 트리거
	local TestStim = CreateCcode()
	TriggerX(FP,{CD(TestStim,0)},{SetCD(CUnitFlag,1);
	SetCD(TestStim,50),
	SetDeaths(Force1,Add,1,71);},{preserved})
	DoActionsX(FP,{SubCD(TestStim,1)})
	TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,209)},{RotatePlayer({RunAIScript(P8VON),RunAIScript(P7VON),RunAIScript(P6VON),RunAIScript(P5VON)},MapPlayers,FP)})
	TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,210)},{RotatePlayer({RunAIScript(P8VON),RunAIScript(P7VON),RunAIScript(P6VON),RunAIScript(P5VON)},MapPlayers,FP)})
	
	if TheoristTestMode == 1 then
		DoActionsX(FP, {
			SetCD(Theorist,1);
			SetMemoryB(0x57F27C + (0 * 228) + 23,SetTo,0);
			SetMemoryB(0x57F27C + (1 * 228) + 23,SetTo,0);
			SetMemoryB(0x57F27C + (2 * 228) + 23,SetTo,0);
			SetMemoryB(0x57F27C + (3 * 228) + 23,SetTo,0);
			SetMemoryB(0x57F27C + (0 * 228) + 7,SetTo,0);
			SetMemoryB(0x57F27C + (1 * 228) + 7,SetTo,0);
			SetMemoryB(0x57F27C + (2 * 228) + 7,SetTo,0);
			SetMemoryB(0x57F27C + (3 * 228) + 7,SetTo,0);},1)
	end
	DoActionsX(FP, {
		SetMemoryB(0x57F27C + (0 * 228) + 23,SetTo,1),
		SetMemoryB(0x57F27C + (1 * 228) + 23,SetTo,1),
		SetMemoryB(0x57F27C + (2 * 228) + 23,SetTo,1),
		SetMemoryB(0x57F27C + (3 * 228) + 23,SetTo,1),
		SetCD(EEggCode,EEggTestNum)
	},1)
	CDoActions(FP, {
		TSetMemoryX(0x581DD8,SetTo,_Mul(TestVar,65536),0xFF0000);
		TSetMemoryX(0x581D96,SetTo,_Mul(TestVar,65536),0xFF0000);
		--TSetResources(0, SetTo, TestVar, Gas)
	})
	CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
    SingleGunTestMode = {}
    ExWt = {135,136,137,138,139,140,141,142,35,176,177,178,149,156,150}
	TargetTestGun = 190
    for j, k in pairs(f_GunTable) do
		if k ~= TargetTestGun then
        table.insert(SingleGunTestMode,ModifyUnitEnergy(All,k,Force2,64,0))
        table.insert(SingleGunTestMode,RemoveUnit(k,Force2))
        table.insert(SingleGunTestMode,RemoveUnit(k,P12))
		end
    end
    for j, k in pairs(ExWt) do
        table.insert(SingleGunTestMode,ModifyUnitEnergy(All,k,Force2,64,0))
        table.insert(SingleGunTestMode,RemoveUnit(k,Force2))
        table.insert(SingleGunTestMode,RemoveUnit(k,P12))
    end
	table.insert(SingleGunTestMode,SetV(CurEXP,0x7FFFFFFF))
    Trigger2X(FP,Deaths(CurrentPlayer,AtLeast,1,208),SingleGunTestMode)
	CIfOnce(FP,Deaths(CurrentPlayer,AtLeast,1,208))
	CMov(FP,0x6509B0,19025+9) --CUnit 시작지점 +19 (0x4C)
	CWhile(FP,Memory(0x6509B0,AtMost,19025+9 + (84*1699)),{SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF0000),SetMemory(0x6509b0,Add,84)})
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
	CIfEnd()

		for i = 0, 3 do
			TriggerX(FP,{Deaths(i,AtLeast,1,199)},{CreateUnitWithProperties(12,MarID[i+1],2+i,i,{energy=100})},{preserved})
		end
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				Deaths(CurrentPlayer,AtLeast,1,204);
			},
			actions = {
				KillUnit("Men",Force2);
				KillUnit(143,Force2);
				KillUnit(144,Force2);
				KillUnit(146,Force2);
				PreserveTrigger();
			}
			}
		TestUPtr = CreateVar(FP)
		CTrigger(FP,{Deaths(CurrentPlayer,AtLeast,1,199)},{SetV(TestUPtr,Cunit2)},{preserved})
		--CIf(FP,{CVar(FP,TestUPtr[2],AtLeast,1),CVar(FP,TestUPtr[2],AtMost,0x7FFFFFFF)})
		--	CDoActions(FP,{TSetMemoryX(_Add(CurrentOP,EPD(0x57f120)),SetTo,_Div(_Read(_Add(TestUPtr,19)),256),0xFF)})
		--CIfEnd()

		CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
		CIf(FP,{CVar(FP,Cunit2[2],AtLeast,1),CVar(FP,Cunit2[2],AtMost,0x7FFFFFFF)})
			CIf(FP,{Deaths(CurrentPlayer,AtLeast,1,207)})
				CMov(FP,0x6509B0,Cunit2,25)
				CTrigger(FP,{TTDeathsX(CurrentPlayer,NotSame,58,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,111,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,107,0,0xFF)},{
					MoveCp(Add,15*4);
					SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF000000);
					MoveCp(Subtract,21*4);
					SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
					MoveCp(Add,6*4);
				},1)
			CIfEnd()

			CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
			CIf(FP,{Deaths(CurrentPlayer,AtLeast,1,203)})
				CMov(FP,0x6509B0,Cunit2,25)
				f_SaveCp()
				TestUID = CreateVar(FP)
				TestP = CreateVar(FP)
				f_Read(FP,BackupCp,TestUID,nil,0xFF,1)
				f_Read(FP,_Sub(BackupCp,6),TestP,nil,0xFF,1)
				CDoActions(FP,{TSetMemory(_Add(_Mul(TestUID,12),TestP),Add,1)})
				f_LoadCp()
				CTrigger(FP,{TTDeathsX(CurrentPlayer,NotSame,58,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,111,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,107,0,0xFF)},{
					MoveCp(Subtract,6*4);
					SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
					MoveCp(Add,6*4);
				},1)
			CIfEnd()
			
			CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
			CMov(FP,0x6509B0,Cunit2,19)
			f_SaveCp()
			CDoActions(FP,{TSetMemoryX(_Add(Cunit2,35),SetTo,_Mul(_Read(BackupCp),65536),0xFF000000)})
			f_LoadCp()

		CIfEnd()
	CIfEnd()

	CMov(FP,0x6509B0,FP)--상위플레이어 단락
			end
--function StrDesignX(Str)
--	return "\x13\x07·\x11·\x08·\x07【 "..Str.." \x07】\x08·\x11·\x07·"
--end

CSub(FP,ShieldEnV,Dt)
CIf(FP,CD(Fin,0))
CAdd(FP,Time1,Dt)
CAdd(FP,Time2,Dt)
CIfEnd()
CDoActions(FP,{TSetCDeaths(FP,Add,Dt,GeneT)})
TriggerX(FP,{ElapsedTime(AtLeast,60)},{--
	SetMemoryB(0x57F27C + (0 * 228) + 23,SetTo,0),
	SetMemoryB(0x57F27C + (1 * 228) + 23,SetTo,0),
	SetMemoryB(0x57F27C + (2 * 228) + 23,SetTo,0),
	SetMemoryB(0x57F27C + (3 * 228) + 23,SetTo,0),
},{preserved})

TriggerX(FP,{CD(Theorist,1),CD(RedNumPanelty,1,AtLeast)},{SubCD(RedNumPanelty,1),AddV(RedNumberT,(9000*2)*(400-322))})
CWhile(FP,{
	CVar(FP,RedNumberT[2],AtLeast,9000*2);
	CVar(FP,RedNumberT[2],AtMost,0x7FFFFFFF);
	CVar(FP,RedNumber[2],AtLeast,1);
},{
	SetCVar(FP,RedNumberT[2],Add,-9000*2);
	SetCVar(FP,RedNumber[2],Subtract,1);})
CWhileEnd()
CWhile(FP,{
	CVar(FP,RedNumberT[2],AtMost,-(9000*2));
	CVar(FP,RedNumberT[2],AtLeast,0x80000000);
	CVar(FP,RedNumber[2],AtMost,399);
},{
	SetCVar(FP,RedNumberT[2],Add,9000*2);
	SetCVar(FP,RedNumber[2],Add,1);})
CWhileEnd()
local CurRM = CreateVar(FP)
TriggerX(FP,{CV(RedNumber,401,AtLeast)},{SetV(RedNumber,400)},{preserved})
CIf(FP,{Command(Force2,AtLeast,1,173),TTCVar(FP,CurRM[2],NotSame,RedNumber)})
CMov(FP,CurRM,RedNumber)
CMov(FP,0x662350+(116*4),_Mul(RedNumber,256),256*100)
CIfEnd()
if Limit == 1 then
	--TriggerX(FP,{CD(TestMode,1)},{SetV(RedNumber,100)})
end

local CurExpTmp = CreateVar()
--local MaxExpTmp = CreateVar()



local ArrI = CreateVar()
local LevelUpEff = CreateVar(FP)



CIf(FP,CD(Theorist,0))
CIfX(FP,{CV(Level,49,AtMost)})
	f_Mul(FP,CurExpTmp,CurEXP,1000)
	f_Div(FP,CurExpTmp,MaxEXP)
CElseX({SetV(CurExpTmp,1000)})
CIfXEnd()

CIf(FP,{CV(CurExpTmp,1000,AtLeast),CV(Level,49,AtMost)},{SubV(CurExpTmp,1000),SetV(LevelUpEff,1)})
local StimUnlock = "\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04\x0D\x0D\n\x0D\x0D\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D!H\x13\x07LV.10\x04 돌파, \x1B원격 스팀팩\x04이 \x03활성화\x04되었습니다.\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\x0D\x0D\n\x0D\x0D\x13\x04"
local ReviveUnlock = "\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04\x0D\x0D\n\x0D\x0D\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D!H\x13\x07LV.50\x04 돌파, \x07소생 스킬\x04이 \x03활성화\x04되었습니다.\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\x0D\x0D\n\x0D\x0D\x13\x04"
local SkillUnlock = "\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04\x0D\x0D\n\x0D\x0D\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D!H\x13\x07LV.40\x04 돌파, \x08공격 스킬\x04이 \x03활성화\x04되었습니다.\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\x0D\x0D\n\x0D\x0D\x13\x04"
local ExchangeUnlock = "\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04\x0D\x0D\n\x0D\x0D\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D!H\x13\x07LV.20\x04 돌파, \x07자동 환전\x04이 \x03활성화\x04되었습니다.\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\x0D\x0D\n\x0D\x0D\x13\x04"

	CSub(FP,CurEXP,MaxEXP)
	ConvertArr(FP,ArrI,Level)
	f_Read(FP,ArrX(EXPArr,ArrI),MaxEXP,nil,nil,1)
	CAdd(FP,Level,1)
	Trigger2X(FP,{CV(Level,10,AtLeast)},{RotatePlayer({DisplayTextX(StimUnlock,4),PlayWAVX("staredit\\wav\\start.ogg"),PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP),

	SetMemoryB(0x57F27C + (0 * 228) + 71,SetTo,1),
	SetMemoryB(0x57F27C + (1 * 228) + 71,SetTo,1),
	SetMemoryB(0x57F27C + (2 * 228) + 71,SetTo,1),
	SetMemoryB(0x57F27C + (3 * 228) + 71,SetTo,1)})
	Trigger2X(FP,{CV(Level,20,AtLeast)},{RotatePlayer({DisplayTextX(ExchangeUnlock,4),PlayWAVX("staredit\\wav\\start.ogg"),PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP),

	SetMemoryB(0x57F27C + (0 * 228) + 2,SetTo,1),
	SetMemoryB(0x57F27C + (1 * 228) + 2,SetTo,1),
	SetMemoryB(0x57F27C + (2 * 228) + 2,SetTo,1),
	SetMemoryB(0x57F27C + (3 * 228) + 2,SetTo,1)})
	
	Trigger2X(FP,{CV(Level,30,AtLeast)},{
		RotatePlayer({PlayWAVX("staredit\\wav\\shield_unlock.ogg"),PlayWAVX("staredit\\wav\\shield_unlock.ogg")},HumanPlayers,FP);
		SetV(ShieldEnV,3200);
		SetCDeaths(FP,SetTo,1,ShieldUnlock);
	})

	local ShieldUnlockT = "\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04\x0D\x0D\n\x0D\x0D\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D!H\x13\x07LV.30\x04 돌파, \x1C빛의 보호막\x04이 \x03활성화\x04되었습니다.\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\x0D\x0D\n\x0D\x0D\x13\x04"


	Trigger2X(FP,{CV(Level,40,AtLeast)},{RotatePlayer({DisplayTextX(SkillUnlock,4),PlayWAVX("staredit\\wav\\SkillUnlock.ogg"),PlayWAVX("staredit\\wav\\SkillUnlock.ogg"),PlayWAVX("staredit\\wav\\SkillUnlock.ogg"),PlayWAVX("staredit\\wav\\SkillUnlock.ogg")},HumanPlayers,FP)})
	Trigger2X(FP,{CV(Level,50,AtLeast)},{RotatePlayer({DisplayTextX(ReviveUnlock,4),PlayWAVX("staredit\\wav\\reviveunlock.ogg"),PlayWAVX("staredit\\wav\\reviveunlock.ogg"),PlayWAVX("staredit\\wav\\reviveunlock.ogg"),PlayWAVX("staredit\\wav\\reviveunlock.ogg")},HumanPlayers,FP)})
	
	f_Mul(FP,MarHPRegen,Level,256)
	CMov(FP,AtkCondTmp,Level,49)
	CMov(FP,HPCondTmp,_Sub(Level,1))
	ItoDec(FP,_Add(Level,1),VArr(LVVA,0),2,nil,0)--렙
	f_Movcpy(FP,_Add(AtkCondTblPtr,AtkCondT[2]),VArr(LVVA,0),4*4)
	f_Movcpy(FP,_Add(HPCondTblPtr,HPCondT[2]),VArr(LVVA,0),4*4)
	CIfEnd()


Trigger2X(FP,{
	Label(0);
	CDeaths(FP,AtLeast,1,ShieldUnlock);
	CV(ShieldEnV,0);
},{
	
	RotatePlayer({DisplayTextX(ShieldUnlockT,4);},HumanPlayers,FP);
	SetMemory(0x5822C4+(0*4),SetTo,1200);
	SetMemory(0x582264+(0*4),SetTo,1200);
	SetMemoryB(0x57F27C+(228*0)+19,SetTo,1);
	SetMemory(0x5822C4+(1*4),SetTo,1200);
	SetMemory(0x582264+(1*4),SetTo,1200);
	SetMemoryB(0x57F27C+(228*1)+19,SetTo,1);
	SetMemory(0x5822C4+(2*4),SetTo,1200);
	SetMemory(0x582264+(2*4),SetTo,1200);
	SetMemoryB(0x57F27C+(228*2)+19,SetTo,1);
	SetMemory(0x5822C4+(3*4),SetTo,1200);
	SetMemory(0x582264+(3*4),SetTo,1200);
	SetMemoryB(0x57F27C+(228*3)+19,SetTo,1);
})
CIfEnd()
TriggerX(FP,{Command(Force1,AtLeast,1,62);},{ModifyUnitEnergy(1,62,Force1,64,0);
SetCDeaths(FP,Add,1,CUnitRefrash);RemoveUnitAt(1,62,"Anywhere",Force1);SetCVar(FP,SpeedVar[2],Add,1);SetCVar(FP,TestVar[2],Add,1);},{preserved})
TriggerX(FP,{Command(Force1,AtLeast,1,61);},{ModifyUnitEnergy(1,61,Force1,64,0);
SetCDeaths(FP,Add,1,CUnitRefrash);RemoveUnitAt(1,61,"Anywhere",Force1);SetCVar(FP,SpeedVar[2],Subtract,1);SetCVar(FP,TestVar[2],Subtract,1);},{preserved})
TriggerX(FP,{Command(FP,AtMost,0,190)},{SetCVar(FP,SpeedVar[2],SetTo,4)})

	
	
	



CIf(FP,{TTCVar(FP,CurrentSpeed[2],NotSame,SpeedVar)}) -- 배속조정 트리거
TriggerX(FP,{CVar(FP,SpeedVar[2],AtMost,0)},{SetCVar(FP,SpeedVar[2],SetTo,1)},{preserved})
TriggerX(FP,{Command(FP,AtMost,0,190),CVar(FP,SpeedVar[2],AtMost,3)},{SetCVar(FP,SpeedVar[2],SetTo,4)},{preserved})
TriggerX(FP,{CVar(FP,SpeedVar[2],AtLeast,12)},{SetCVar(FP,SpeedVar[2],SetTo,11)},{preserved})
CMov(FP,CurrentSpeed,SpeedVar)
for i = 1, 11 do
	Trigger2X(FP,{
		Label(0);
		CVar(FP,SpeedVar[2],Exactly,i);
	},{
		RotatePlayer({PlayWAVX("staredit\\wav\\sel_m.ogg"),
		DisplayTextX("\x0D\x0D!H"..StrDesignX2("\x0F게임 \x10속도\x04를 \x10- "..XSpeed[i].."\x04로 \x0F변경\x04하였습니다."), 0)},HumanPlayers,FP);
		SetMemory(0x5124F0,SetTo,SpeedV[i]);},{preserved})
end
CIfEnd()

SpCodeBase = 0x8080E200 
SpCode0 = 0x8880E200 -- 식별자 (텍스트 미출력 라인은 첫 1바이트가 00으로 고정됨) 
SpCode3 = 0x8B80E200 -- \x0D\x0D!H
function HTextEff() -- ScanChat -> 11줄 전체를 utf8 -> iutf8화 (식별자로 중복방지) 
CA__SetNext(HStr2,8,SetTo,0,54*11-1,0)
CA__SetNext(HStr4,8,SetTo,0,54-1,0)
CMov(FP,HLine,0)
EffCV2 = CreateVArr(11, FP)
CWhile(FP,NVar(HLine,AtMost,10),SetNVar(HCheck,SetTo,0))
	f_ChatOffset(FP,HLine,0,ChatOff) 
    CMovX(FP,HCheck,VArr(EffCV2,HLine))
    CIfX(FP,{TTbytecmp(ChatOff,VArr(HVA3,0),GetStrSize(0,"\x0D\x0D!H"))},{SetNVar(HCheck,SetTo,3)})
--    for i = 0, 3 do
--        CElseIfX({HumanCheck(i, 1),TTbytecmp(ChatOff,VArr(Names2[i+1],0),PLength[i+1])},{SetNVar(HCheck,SetTo,4)})
--    end
    CElseIfX({TTDisplayX(HLine,0,NotSame,SpCode3,0xFFFFFF00)},{SetNVar(HCheck,SetTo,0)})
    CIfXEnd()

	CurLiV = CreateVar(FP)
	EffCV = CreateVArr(11, FP)
    CIf(FP,{NVar(HCheck,AtLeast,3),NVar(HCheck,AtMost,4)})
	CIfX(FP,{TTDisplayX(HLine,0,"!=",SpCodeBase,0xF0FFFF00)}) -- 0x8080E2 ~ 0x8F80F2 인식
		CMovX(FP,VArr(EffCV,HLine),0)
		CMov(FP,CurLiV, _Mul(HLine,54*604))
		CA__SetValue(HStr2,MakeiStrLetter("\x0D",53),0xFFFFFFFF,CurLiV,1,1) 
		CD__ScanChat(SVA1(HStr2,CurLiV),ChatOff,52,ChatSize,0,1) 
		CIfX(FP,NVar(HCheck,Exactly,3))
			CA__SetValue(HStr2,MakeiStrLetter("\x0D",2),0xFFFFFFFF,CurLiV,1,1) 
			CA__SetMemoryX(_GIndex2(HLine,0),SpCode3+0x0D,0xFFFFFFFF,1) 
		CElseX()
			CA__SetMemoryX(_GIndex2(HLine,0),SpCode0+0x0D,0xFFFFFFFF,1) 
		CIfXEnd()

		CIf(FP,{TTNVar(HCheck, NotSame, 3)})
		CD__InputVAX(_GIndex2(HLine,1),SVA1(HStr2,CurLiV),52,0xFFFFFFFF,0xFFFFFFFF,8,604*11-1)
		CIfEnd()
		CD__InputMask(HLine,0xFFFFFFFF,0,52) 
	CElseIfX({TTDisplay(HLine,"On"),TTDisplayX(HLine,0,Exactly,SpCode3,0xFFFFFF00)}) 
	TempEC = CreateVar(FP)
		CMov(FP,CurLiV, _Mul(HLine,54*604))
		CMovX(FP,TempEC,VArr(EffCV,HLine))
		CD__InputVAX(_GIndex2(HLine,1),HStr4,52,0xFFFFFFFF,0xFFFFFFFF,8,604*11-1)
		CD__InputVAX(_GIndex2(HLine,1),SVA1(HStr2,CurLiV),TempEC,0xFFFFFFFF,0xFFFFFFFF,8,604*11-1)
		CIf(FP,NVar(TempEC,AtMost,51),SetNVar(TempEC, Add, 1))
			CMovX(FP,VArr(EffCV,HLine),TempEC)
		CIfEnd()
	CIfXEnd()
    CIfEnd()


    CMovX(FP,VArr(EffCV2,HLine),HCheck)
CWhileEnd(SetNVar(HLine,Add,1)) 
end 
CDPrint(0,11,{"\x0D",0,0},{Force1,Force2,Force5},{1,0,0,0,1,1,0,0},"HTextEff",FP) 



function TEST() 

	TimeTmp = CreateCcode()
	TimeV = CreateVar(FP)
	CMov(FP,_Ccode(FP,TimeTmp),Time1)
	CMov(FP,TimeV,0)
	for i = 6, 0, -1 do
		Trigger {
			players = {FP},
			conditions = {
				Label();
				CDeaths(FP,AtLeast,(2^i)*3600000,TimeTmp);
			},
			actions = {
				SetCVar(FP,TimeV[2],Add,(2^i)*10000);
				SetCDeaths(FP,Subtract,(2^i)*3600000,TimeTmp);
				PreserveTrigger();
			}
		}
	end
	for i = 6, 0, -1 do
		Trigger {
			players = {FP},
			conditions = {
				Label();
				CDeaths(FP,AtLeast,(2^i)*60000,TimeTmp);
			},
			actions = {
				SetCVar(FP,TimeV[2],Add,(2^i)*100);
				SetCDeaths(FP,Subtract,(2^i)*60000,TimeTmp);
				PreserveTrigger();
			}
		}
	end
	for i = 6, 0, -1 do
		Trigger {
			players = {FP},
			conditions = {
				Label();
				CDeaths(FP,AtLeast,(2^i)*1000,TimeTmp);
			},
			actions = {
				SetCVar(FP,TimeV[2],Add,(2^i)*1);
				SetCDeaths(FP,Subtract,(2^i)*1000,TimeTmp);
				PreserveTrigger();
			}
		}
	end


local PlayerID = CAPrintPlayerID 
CA__SetValue(Str1,"\x07·\x11·\x08·\x07【 \x10Ｔ\x04ＩＭＥＲ－\x07００\x04：\x0F００\x04：\x1F００ \x07】\x08·\x11·\x07·",nil,0) 
local Data = {{{0,9},{"０",{0x1000000}}}} 
CA__ItoCustom(SVA1(Str1,0),TimeV,nil,nil,{10,6},1,{"\x07０","\x07０","\x0F０","\x0F０","\x1F０","\x1F０"},nil,{0x07,0x07,0x0F,0x0F,0x1F,0x1F},{11,12,14,15,17,18},Data)
CA__InputVA(40*0,Str1,Str1s,nil,40*0,40*1-3)
CA__SetValue(Str1,MakeiStrVoid(38),0xFFFFFFFF,0) 
CA__SetValue(Str1,"\x07·\x11·\x08·\x07【 \x06０００\x04 ◈ ００００ \x04◈ ０\x04／\x10４ \x07】\x08·\x11·\x07·",nil,0) 
CA__ItoCustom(SVA1(Str1,0),RedNumber,nil,nil,{10,3},1,"\x06０",nil,0x06,{5,6,7},Data) 
CA__ItoCustom(SVA1(Str1,0),count,nil,nil,{10,4},1,"０",nil,nil,{11,12,13,14},Data) 
CA__ItoCustom(SVA1(Str1,0),CanC,nil,nil,{10,1},1,"\x04０",nil,0x04,{18},Data) 

function CS__InputTA(Player,Condition,SVA1,Value,Mask,Flag)
	if Flag == nil then Flag = {preserved} elseif Flag == 1 then Flag = {} end
	TriggerX(Player,Condition,{SetCSVA1(SVA1,SetTo,Value,Mask)},Flag)
end
function SetStr1Data(Index,ConActTable,Flags) --{{{"CD"or "V",CDVIndex,CType,CValue},...},Value,Mask}
	for j, k in pairs(ConActTable) do
		local X = {}
		for l, m in pairs(k[1]) do
			if m[1] == "CD" then
				table.insert(X,CD(m[2],m[4],m[3]))
			elseif m[1] == "V" then
				table.insert(X,CV(m[2],m[4],m[3]))
			else PushErrorMsg("SetStr1Data_InputData_Error") end
		end

		CS__InputTA(FP,{X},SVA1(Str1,Index),k[2],k[3],Flags)
	end
end

TriggerX(FP,{
	Command(FP,AtMost,0,173);},{
	SetCSVA1(SVA1(Str1,18),SetTo,0x0D0D0D0D,0xFFFFFFFF),
	SetCSVA1(SVA1(Str1,19),SetTo,0x0D0D0D0D,0xFFFFFFFF),
	SetCSVA1(SVA1(Str1,20),SetTo,0x0D0D0D0D,0xFFFFFFFF),
	SetCSVA1(SVA1(Str1,21),SetTo,0x0D0D0D0D,0xFFFFFFFF),
},{preserved})


CanCTC = CreateCcode()
SetStr1Data(10,
{
	{
		{
			{"V",count,AtMost,399}
		},14,0xFF
	},
	{
		{
			{"V",count,AtLeast,400},
			{"V",count,AtMost,799}
		},15,0xFF
	},
	{
		{
			{"V",count,AtLeast,800},
			{"V",count,AtMost,1199}
		},0x11,0xFF
	},
	{
		{
			{"V",count,AtLeast,1200},
			{"V",count,AtMost,1499}
		},08,0xFF
	},
	{
		{
			{"V",count,AtLeast,1500},
			{"CD",CanCTC,Exactly,1}
		},0x11,0xFF
	}
})

CanColorT = {0x0E,0x0F,0x11,0x08,0x1F}
for j, k in pairs(CanColorT) do
	CS__InputTA(PlayerID,{CV(CanC,j-1)},SVA1(Str1,18),k,0xFF)
end

TriggerX(FP,{CD(Theorist,1),CD(CanCTC,1),CD(CanCT,1,AtLeast)},{
	SetCSVA1(SVA1(Str1,5),SetTo,0x04,0xFF),
	SetCSVA1(SVA1(Str1,6),SetTo,0x04,0xFF),
	SetCSVA1(SVA1(Str1,7),SetTo,0x04,0xFF),
},{preserved})

CS__InputTA(PlayerID,{CD(CanCT,1,AtLeast),CD(CanCTC,1)},SVA1(Str1,18),0x04,0xFF)
TriggerX(FP,{CD(CanCTC,2)},{SetCD(CanCTC,0)},{preserved})

 CA__InputVA(40*1,Str1,Str1s,nil,40*1,40*2-3)
 CA__SetValue(Str1,MakeiStrVoid(38),0xFFFFFFFF,0) 

CIfX(FP,{CDeaths(FP,AtMost,0,Theorist)})

 CA__SetValue(Str1,"\x07·\x11·\x08·\x07【 \x07Ｌ\x07Ｖ\x04．００\x04／\x1C５\x1C０ \x04◈ \x07Ｅ\x07Ｘ\x07Ｐ\x04：０００\x04．０\x04％ \x07】\x08·\x11·\x07·",nil,0) 
 CA__ItoCustom(SVA1(Str1,0),Level,nil,nil,{10,2},1,"０",nil,nil,{8,9},Data) 
 CA__ItoCustom(SVA1(Str1,0),CurExpTmp,nil,nil,{10,4},1,"\x04０",nil,{0x04,0x04,0x04,0x04},{20,21,22,24},Data) 

 TriggerX(FP,{CV(Level,50)},{SetCSVA1(SVA1(Str1,23),SetTo,0x0D0D0D0D,0xFFFFFFFF),SetCSVA1(SVA1(Str1,24),SetTo,0x0D0D0D0D,0xFFFFFFFF)},{preserved})
 function LevelIStrColor(Color,ValueArr)
	TriggerX(FP,{CVar(FP,Level[2],AtLeast,ValueArr[1]),CVar(FP,Level[2],AtMost,ValueArr[2])},{
		SetCSVA1(SVA1(Str1,8),SetTo,Color,0xFF),
		SetCSVA1(SVA1(Str1,9),SetTo,Color,0xFF),
	},{preserved})
 end

 LevelIStrColor(0x0E,{0,9})
 LevelIStrColor(0x0F,{10,19})
 LevelIStrColor(0x18,{20,29})
 LevelIStrColor(0x11,{30,39})
 LevelIStrColor(0x08,{40,49})
 LevelIStrColor(0x1F,{50,50})

CElseX()
CIfOnce(FP)
CA__SetMemoryX((40*2)-1,0x0D0D0D0D,0xFFFFFFFF,1)
CA__SetMemoryX((40*2)-2,0x0D0D0D0D,0xFFFFFFFF,1)
CA__SetMemoryX((40*3)-1,0x0D0D0D0D,0xFFFFFFFF,1)
CA__SetMemoryX((40*3)-2,0x0D0D0D0D,0xFFFFFFFF,1)
CIfEnd()
CIfXEnd()
CIf(FP,CV(LevelUpEff,1,AtLeast))
local LevelUpEffTmp2 = CreateVar(FP)
local LevelUpEffTmp = CreateVarArr(8,FP)
LVEFT = {}
for i = 1, 8 do
	CMov(FP,LevelUpEffTmp[i],LevelUpEffTmp2)
	table.insert(LVEFT,{SubV(LevelUpEffTmp[i],604*i)})
end
DoActionsX(FP,LVEFT)

LVUpEffArr = {0x08,0x0E,0x0F,0x10,0x11,0x18,0x16,0x17}
for j,k in pairs(LVUpEffArr) do
	CA__Input(k,SVA1(Str1,LevelUpEffTmp[j]),0xFF) 
end
TriggerX(FP,{CD(CanCTC,1)},{
	SetCSVA1(SVA1(Str1,8),SetTo,0x04,0xFF),
	SetCSVA1(SVA1(Str1,9),SetTo,0x04,0xFF),
	SetCSVA1(SVA1(Str1,20),SetTo,0x04,0xFF),
	SetCSVA1(SVA1(Str1,21),SetTo,0x04,0xFF),
	SetCSVA1(SVA1(Str1,22),SetTo,0x04,0xFF),
	SetCSVA1(SVA1(Str1,23),SetTo,0x04,0xFF),
	SetCSVA1(SVA1(Str1,24),SetTo,0x04,0xFF),
	SetCSVA1(SVA1(Str1,25),SetTo,0x04,0xFF),
},{preserved})

LVUPEffT= CreateCcode()
CAdd(FP,_Ccode(FP,LVUPEffT),1)

TriggerX(FP,{CD(LVUPEffT,3,AtLeast)},{AddV(LevelUpEffTmp2,604),SetCD(LVUPEffT,0)},{preserved})
TriggerX(FP,{CV(LevelUpEffTmp2,40*604,AtLeast)},{SetV(LevelUpEff,0),SetV(LevelUpEffTmp2,0)},{preserved})
CIfEnd()
DoActionsX(FP,{AddCD(CanCTC,1)})
 CA__InputVA(40*2,Str1,Str1s,nil,40*2,40*3)
 CA__SetValue(Str1,MakeiStrVoid(38),0xFFFFFFFF,0) 
end 
CAPrint(iStr1,{Force1,Force2,Force5},{1,0,0,0,1,3,0,0},"TEST",FP,{CD(OPJump,1,AtLeast)}) 



	for i = 1, 3 do -- 강퇴기능
		TriggerX(FP,{Command(Force1,AtLeast,1,BanToken[i]);},{ModifyUnitEnergy(1,BanToken[i],Force1,64,0);
		SetCDeaths(FP,Add,1,CUnitRefrash);RemoveUnitAt(1,BanToken[i],"Anywhere",Force1);SetCDeaths(FP,Add,1,BanCode[i]);},{preserved})
		for j = 1, 4 do
			Trigger2X(i,{CDeaths(FP,Exactly,j,BanCode[i])},{RotatePlayer({DisplayTextX(StrDesign(PlayerString[i+1].."\x04에게 \x08경고가 총 "..j.."회 누적\x04 되었습니다. 총 5회 누적시 \x08강퇴 처리 \x04됩니다."),4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i)})
		end
		Trigger2X(i,{CDeaths(FP,AtLeast,5,BanCode[i]);},{RotatePlayer({DisplayTextX(StrDesign("\x04"..PlayerString[i+1].."\x04의 강퇴처리가 완료되었습니다."),4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i);
	})
		local WAVT = {}
		for k = 0, 9 do
			table.insert(WAVT,PlayWAVX("sound\\Protoss\\ARCHON\\PArDth00.WAV"))
			table.insert(WAVT,DisplayTextX(StrDesign("\x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동."),4))
		end
		Trigger2X(i,{CDeaths(FP,AtLeast,5,BanCode[i]);Memory(0x57F1B0, Exactly, i)},{RotatePlayer(WAVT,i,i),SetMemory(0xCDDDCDDC,SetTo,1);})
		end

		
		
end