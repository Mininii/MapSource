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
				f_Read(FP,BackupCP,BarRally[i+1])
				f_LoadCp()
			CIfEnd()
			CSub(FP,0x6509B0,62-25)

			CIfOnce(FP) -- 배럭위치 초기세팅
				CSub(FP,0x6509B0,15)
				f_SaveCp()
				f_Read(FP,BackupCP,BarPos[i+1])
				f_LoadCp()
				CAdd(FP,0x6509B0,15)
			CIfEnd()

		CIfEnd()


		CIf(FP,{DeathsX(CurrentPlayer,Exactly,184,0,0xFF)})
			DoActionsX(FP,{
                SetMemory(0x6509B0,Subtract,23),SetDeaths(CurrentPlayer,Subtract,256*25,0),
			})
			TriggerX(FP,{Deaths(CurrentPlayer,Exactly,0,0)},{SetMemory(0x6509B0,Add,17),SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00),SetMemory(0x6509B0,Subtract,17)},{Preserved})

			CAdd(FP,0x6509B0,7)
			
			TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,0,0,0xFF0000)},{
				SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000),
				SetMemory(0x582204+(0*4),Add,2),
				SetMemory(0x582204+(1*4),Add,2),
				SetMemory(0x582204+(2*4),Add,2),
				SetMemory(0x582204+(3*4),Add,2),
				SetCDeaths(FP,Add,1,EEggCode),
				RotatePlayer({DisplayTextX("\x0D\x0D\x0D"..PlayerString[i+1].."EEgg".._0D,4),PlayWAVX("staredit\\wav\\EEgg.ogg")},HumanPlayers,FP)},{Preserved})
			
		CIfEnd()

		CIfEnd()
		CIfEnd()
		CMov(FP,0x6509B0,FP)
	end
    CIfX(FP,Never()) -- 상위플레이어 단락 시작
	for i = 0, 3 do
        CElseIfX(HumanCheck(i,1),{SetCVar(FP,CurrentOP[2],SetTo,i),SetMemoryB(0x57F27C + (i * 228) + 60,SetTo,1)})
		
		TriggerX(FP,{CD(Theorist,0),ElapsedTime(AtMost,59)},SetMemoryB(0x57F27C + (i * 228) + 23,SetTo,1),{Preserved})
        f_Read(FP,0x6284E8+(0x30*i),"X",Cunit2)
        f_Read(FP,0x58A364+(48*181)+(4*i),DtX) -- MSQC val Recive. 181
		CTrigger(FP,{CV(DtX,2500,AtMost)},{SetV(Dt,DtX)},1)
		CAdd(FP,RedNumberT,Dt)
	end
    CIfXEnd()
	if Limit == 1 then
	CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
	TriggerX(FP,{Switch("Switch 253",Set),Deaths(CurrentPlayer,AtLeast,1,199)},{SetCD(TestMode,1),SetSwitch("Switch 254",Set),SetMemory(0x657A9C,SetTo,31)})
	
	CIf({FP},CD(TestMode,1)) -- 테스트 트리거
	
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
			TriggerX(FP,{Deaths(i,AtLeast,1,199)},{CreateUnitWithProperties(12,MarID[i+1],2+i,i,{energy=100})},{Preserved})
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
		CTrigger(FP,{Deaths(CurrentPlayer,AtLeast,1,199)},{SetV(TestUPtr,Cunit2)},{Preserved})
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
			CDoActions(FP,{TSetMemoryX(_Add(Cunit2,35),SetTo,_Mul(_Read(BackupCP),65536),0xFF000000)})
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
CIfEnd()
CDoActions(FP,{TSetCDeaths(FP,Add,Dt,GeneT)})
TriggerX(FP,{ElapsedTime(AtLeast,60)},{
	SetMemoryB(0x57F27C + (0 * 228) + 23,SetTo,0),
	SetMemoryB(0x57F27C + (1 * 228) + 23,SetTo,0),
	SetMemoryB(0x57F27C + (2 * 228) + 23,SetTo,0),
	SetMemoryB(0x57F27C + (3 * 228) + 23,SetTo,0),
},{Preserved})
Trigger { -- 빨간숫자
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,RedNumberT[2],AtLeast,9000*2);
		CVar(FP,RedNumber[2],AtLeast,1);
	},
	actions = {
		SetCVar(FP,RedNumberT[2],Subtract,9000*2);
		SetCVar(FP,RedNumber[2],Subtract,1);
		SetMemory(0x662350+(185*4),Subtract,256);
		PreserveTrigger();
	},
}

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
local StimUnlock = "\n\n\n\n\x13\x04\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x07LV.10\x04 돌파, \x1B원격 스팀팩\x04이 \x03활성화\x04되었습니다.\n \n\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\x13\x04"
local ReviveUnlock = "\n\n\n\n\x13\x04\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x07LV.50\x04 돌파, \x07소생 스킬\x04이 \x03활성화\x04되었습니다.\n \n\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\x13\x04"
local SkillUnlock = "\n\n\n\n\x13\x04\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x07LV.40\x04 돌파, \x08공격 스킬\x04이 \x03활성화\x04되었습니다.\n \n\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\x13\x04"
local ExchangeUnlock = "\n\n\n\n\x13\x04\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x07LV.20\x04 돌파, \x07자동 환전\x04이 \x03활성화\x04되었습니다.\n \n\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\x13\x04"

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

	local ShieldUnlockT = "\n\n\n\n\x13\x04\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x07LV.30\x04 돌파, \x1C빛의 보호막\x04이 \x03활성화\x04되었습니다.\n \n\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\x13\x04"


	Trigger2X(FP,{CV(Level,40,AtLeast)},{RotatePlayer({DisplayTextX(SkillUnlock,4),PlayWAVX("staredit\\wav\\SkillUnlock.ogg"),PlayWAVX("staredit\\wav\\SkillUnlock.ogg"),PlayWAVX("staredit\\wav\\SkillUnlock.ogg"),PlayWAVX("staredit\\wav\\SkillUnlock.ogg")},HumanPlayers,FP)})
	Trigger2X(FP,{CV(Level,50,AtLeast)},{RotatePlayer({DisplayTextX(ReviveUnlock,4),PlayWAVX("staredit\\wav\\reviveunlock.ogg"),PlayWAVX("staredit\\wav\\reviveunlock.ogg"),PlayWAVX("staredit\\wav\\reviveunlock.ogg"),PlayWAVX("staredit\\wav\\reviveunlock.ogg")},HumanPlayers,FP)})
	
	f_Mul(FP,MarHPRegen,Level,256)
	CMov(FP,AtkCondTmp,_Mul(Level,4),50)
	CMov(FP,HPCondTmp,_Mul(Level,5))
	ItoDec(FP,_Add(Level,1),VArr(LVVA,0),2,nil,0)--렙
	f_Movcpy(FP,_Add(AtkCondTblPtr,AtkCondT[2]),VArr(LVVA,0),4*4)
	f_Movcpy(FP,_Add(HPCondTblPtr,HPCondT[2]),VArr(LVVA,0),4*4)
	CIfEnd()



Trigger { -- 공업완료시 수정보호막 활성화
players = {FP},
conditions = {
	Label(0);
	CDeaths(FP,AtLeast,1,ShieldUnlock);
	CV(ShieldEnV,0);
},
actions = {
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
},
}
CIfEnd()


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
CA__SetValue(Str1,"\x07·\x11·\x08·\x07【 \x06０００\x04 ◈ ００００ \x04◈ ０\x04／\x10４　\x07】\x08·\x11·\x07·",nil,0) 
CA__ItoCustom(SVA1(Str1,0),RedNumber,nil,nil,{10,3},1,"\x06０",nil,0x06,{5,6,7},Data) 
CA__ItoCustom(SVA1(Str1,0),count,nil,nil,{10,4},1,"０",nil,nil,{11,12,13,14},Data) 
CA__ItoCustom(SVA1(Str1,0),CanC,nil,nil,{10,1},1,"\x04０",nil,0x04,{18},Data) 

function CS__InputTA(Player,Condition,SVA1,Value,Mask,Flag)
	if Flag == nil then Flag = {Preserved} elseif Flag == 1 then Flag = {} end
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
CS__InputTA(PlayerID,{CD(CanCT,1,AtLeast),CD(CanCTC,1)},SVA1(Str1,18),0x04,0xFF)
TriggerX(FP,{CD(CanCTC,2)},{SetCD(CanCTC,0)},{Preserved})

 CA__InputVA(40*1,Str1,Str1s,nil,40*1,40*2-3)
 CA__SetValue(Str1,MakeiStrVoid(38),0xFFFFFFFF,0) 

CIfX(FP,{CDeaths(FP,AtMost,0,Theorist)})

 CA__SetValue(Str1,"\x07·\x11·\x08·\x07【 \x07Ｌ\x07Ｖ\x04．００\x04／\x1C５\x1C０ \x04◈ \x07Ｅ\x07Ｘ\x07Ｐ\x04：０００\x04．０\x04％ \x07】\x08·\x11·\x07·",nil,0) 
 CA__ItoCustom(SVA1(Str1,0),Level,nil,nil,{10,2},1,"０",nil,nil,{8,9},Data) 
 CA__ItoCustom(SVA1(Str1,0),CurExpTmp,nil,nil,{10,4},1,"\x04０",nil,{0x04,0x04,0x04,0x04},{20,21,22,24},Data) 

 TriggerX(FP,{CV(Level,50)},{SetCSVA1(SVA1(Str1,23),SetTo,0x0D0D0D0D,0xFFFFFFFF),SetCSVA1(SVA1(Str1,24),SetTo,0x0D0D0D0D,0xFFFFFFFF)},{Preserved})
 function LevelIStrColor(Color,ValueArr)
	TriggerX(FP,{CVar(FP,Level[2],AtLeast,ValueArr[1]),CVar(FP,Level[2],AtMost,ValueArr[2])},{
		SetCSVA1(SVA1(Str1,8),SetTo,Color,0xFF),
		SetCSVA1(SVA1(Str1,9),SetTo,Color,0xFF),
	},{Preserved})
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
TriggerX(FP,{CD(CanCTC,1)},{
	SetCSVA1(SVA1(Str1,8),SetTo,0x04,0xFF),
	SetCSVA1(SVA1(Str1,9),SetTo,0x04,0xFF),
	SetCSVA1(SVA1(Str1,20),SetTo,0x04,0xFF),
	SetCSVA1(SVA1(Str1,21),SetTo,0x04,0xFF),
	SetCSVA1(SVA1(Str1,22),SetTo,0x04,0xFF),
	SetCSVA1(SVA1(Str1,23),SetTo,0x04,0xFF),
	SetCSVA1(SVA1(Str1,24),SetTo,0x04,0xFF),
	SetCSVA1(SVA1(Str1,25),SetTo,0x04,0xFF),
},{Preserved})
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
LVUPEffT= CreateCcode()
CAdd(FP,_Ccode(FP,LVUPEffT),1)

TriggerX(FP,{CD(LVUPEffT,3,AtLeast)},{AddV(LevelUpEffTmp2,604),SetCD(LVUPEffT,0)},{Preserved})
TriggerX(FP,{CV(LevelUpEffTmp2,40*604,AtLeast)},{SetV(LevelUpEff,0),SetV(LevelUpEffTmp2,0)},{Preserved})
CIfEnd()
DoActionsX(FP,{AddCD(CanCTC,1)})
 CA__InputVA(40*2,Str1,Str1s,nil,40*2,40*3)
 CA__SetValue(Str1,MakeiStrVoid(38),0xFFFFFFFF,0) 
end 
CAPrint(iStr1,{Force1,Force5},{1,0,0,0,1,3,0,0},"TEST",FP,{CD(OPJump,1,AtLeast)}) 



	for i = 1, 3 do -- 강퇴기능
		TriggerX(FP,{Command(Force1,AtLeast,1,BanToken[i]);},{ModifyUnitEnergy(1,BanToken[i],Force1,64,0);
		SetCDeaths(FP,Add,1,CUnitRefrash);RemoveUnitAt(1,BanToken[i],"Anywhere",Force1);SetCDeaths(FP,Add,1,BanCode[i]);},{Preserved})
		for j = 1, 4 do
			TriggerX(i,{CDeaths(FP,Exactly,j,BanCode[i])},{RotatePlayer({DisplayTextX(StrDesign(PlayerString[i+1].."\x04에게 \x08경고가 총 "..j.."회 누적\x04 되었습니다. 총 5회 누적시 \x08강퇴 처리 \x04됩니다."),4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i)})
		end
		Trigger { -- 강퇴
		players = {i},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,5,BanCode[i]);
		},
		actions = {
			RotatePlayer({DisplayTextX("\x07『 \x04"..PlayerString[i+1].."\x04의 강퇴처리가 완료되었습니다.\x07 』",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i);
			},
		}
		local WAVT = {}
		for k = 0, 9 do
			table.insert(WAVT,PlayWAVX("sound\\Protoss\\ARCHON\\PArDth00.WAV"))
			table.insert(WAVT,DisplayTextX(StrDesign("\x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동."),4))
		end
		Trigger2X(i,{CDeaths(FP,AtLeast,5,BanCode[i]);Memory(0x57F1B0, Exactly, i)},{RotatePlayer(WAVT,i,i),SetMemory(0xCDDDCDDC,SetTo,1);})
		end

		
		
		TriggerX(FP,{Command(Force1,AtLeast,1,62);},{ModifyUnitEnergy(1,62,Force1,64,0);
		SetCDeaths(FP,Add,1,CUnitRefrash);RemoveUnitAt(1,62,"Anywhere",Force1);SetCVar(FP,SpeedVar[2],Add,1);},{Preserved})
		TriggerX(FP,{Command(Force1,AtLeast,1,61);},{ModifyUnitEnergy(1,61,Force1,64,0);
		SetCDeaths(FP,Add,1,CUnitRefrash);RemoveUnitAt(1,61,"Anywhere",Force1);SetCVar(FP,SpeedVar[2],Subtract,1);},{Preserved})
		TriggerX(FP,{Command(FP,AtMost,0,190)},{SetCVar(FP,SpeedVar[2],SetTo,4)})
    CIf(FP,{TTCVar(FP,CurrentSpeed[2],NotSame,SpeedVar)}) -- 배속조정 트리거
		TriggerX(FP,{CVar(FP,SpeedVar[2],AtMost,0)},{SetCVar(FP,SpeedVar[2],SetTo,1)},{Preserved})
		TriggerX(FP,{Command(FP,AtMost,0,190),CVar(FP,SpeedVar[2],AtMost,3)},{SetCVar(FP,SpeedVar[2],SetTo,4)},{Preserved})
		TriggerX(FP,{CVar(FP,SpeedVar[2],AtLeast,12)},{SetCVar(FP,SpeedVar[2],SetTo,11)},{Preserved})
        CMov(FP,CurrentSpeed,SpeedVar)
        for i = 1, 11 do
            Trigger { -- No comment (E93EF7A9)
                players = {FP},
                conditions = {
                    Label(0);
                    CVar(FP,SpeedVar[2],Exactly,i);
                },
                actions = {PreserveTrigger();
                    RotatePlayer({PlayWAVX("staredit\\wav\\sel_m.ogg"),
                    DisplayTextX(StrDesignX("\x0F게임 \x10속도\x04를 \x10- "..XSpeed[i].."\x04로 \x0F변경\x04하였습니다."), 0)},HumanPlayers,FP);
                    SetMemory(0x5124F0,SetTo,SpeedV[i]);
                },
            }
        end
    CIfEnd()
end