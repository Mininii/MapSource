function Operator_Trig()
    Cunit2 = CreateVar(FP)
	CurrentOP = CreateVar(FP)
	local DtX = CreateVar(FP)
	
	BanCode = CreateCcodeArr(3)
	DoActions(FP,{
		SetMemoryB(0x57F27C + (0 * 228) + 60,SetTo,0),
		SetMemoryB(0x57F27C + (1 * 228) + 60,SetTo,0),
		SetMemoryB(0x57F27C + (2 * 228) + 60,SetTo,0),
		SetMemoryB(0x57F27C + (3 * 228) + 60,SetTo,0)
	})
	for i = 0, 3 do
		CIf(FP,{PlayerCheck(i,1),})

        f_Read(FP,0x6284E8+(0x30*i),"X",Cunit2)
		CIf(FP,{CVar(FP,Cunit2[2],AtLeast,19025),CVar(FP,Cunit2[2],AtMost,19025+(1700*84))})
		CMov(FP,0x6509B0,Cunit2,25)
		CIf(FP,{DeathsX(CurrentPlayer,Exactly,184,0,0xFF)})
			DoActionsX(FP,{
                SetMemory(0x6509B0,Subtract,23),SetDeaths(CurrentPlayer,Subtract,256*25,0),
			})
			TriggerX(FP,{Deaths(CurrentPlayer,Exactly,0,0)},{SetMemory(0x6509B0,Add,17),SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00),SetMemory(0x6509B0,Subtract,17)},{Preserved})

			CAdd(FP,0x6509B0,7)
			
			TriggerX(FP,{DeathsX(CurrentPlayer,Exactly,0,0,0xFF0000)},{SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000),SetCDeaths(FP,Add,1,EEggCode),RotatePlayer({DisplayTextX("\x0D\x0D\x0D"..PlayerString[i+1].."EEgg".._0D,4),PlayWAVX("staredit\\wav\\EEgg.ogg")},HumanPlayers,FP)},{Preserved})
			
		CMov(FP,0x6509B0,FP)
		CIfEnd()
		CIfEnd()
		CIfEnd()
	end
    CIfX(FP,Never()) -- 상위플레이어 단락 시작
	for i = 0, 3 do
        CElseIfX(PlayerCheck(i,1),{SetCVar(FP,CurrentOP[2],SetTo,i),SetMemoryB(0x57F27C + (i * 228) + 60,SetTo,1)})
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
		CIf(FP,{CVar(FP,TestUPtr[2],AtLeast,1),CVar(FP,TestUPtr[2],AtMost,0x7FFFFFFF)})
			CDoActions(FP,{TSetMemoryX(_Add(CurrentOP,EPD(0x57f120)),SetTo,_Div(_Read(_Add(TestUPtr,19)),256),0xFF)})
		CIfEnd()

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

local Print13T = CreateVar(FP)
CIf(FP,{Memory(0x628438, AtLeast, 0x00000001),CV(Print13T,3000,AtLeast)},{SetV(Print13T,0)})
	Print_13(FP,MapPlayers,nil)
CIfEnd({})
CAdd(FP,Print13T,Dt)
CAdd(FP,Time1,Dt)
CDoActions(FP,{TSetCDeaths(FP,Add,Dt,GeneT)})
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



local TimeTmp = CreateCcode()
local CountTmp = CreateCcode()
local LevelTmp = CreateCcode()
local ExpTmp = CreateCcode()
local RedNumberTmp = CreateCcode()
local ArrI = CreateVar()
CMov(FP,_Ccode(FP,RedNumberTmp),RedNumber)
CMov(FP,_Ccode(FP,TimeTmp),Time1)
CMov(FP,_Ccode(FP,LevelTmp),Level)
CMov(FP,_Ccode(FP,CountTmp),count)

CIfX(FP,{CV(Level,49,AtMost)},{print_utf8(12,0,StrDesign("\x10Ｔ\x04ＩＭＥＲ－\x07００\x04：\x0F００\x04：\x1F００ \x04◈ \x07ＬＶ\x04．００／\x1C５０ \x04◈ \x07ＥＸＰ\x04："..string.rep("\x0D",GetStrSize(0,"．")).."０"..string.rep("\x0D",GetStrSize(0,"．")).."０％ ◈ \x06０００\x04 ◈ \x04００００"))})
	f_Mul(FP,CurExpTmp,CurEXP,100)
	f_Div(FP,_Ccode(FP,ExpTmp),CurExpTmp,MaxEXP)
CElseX({SetCD(ExpTmp,100),print_utf8(12,0,StrDesign("\x10Ｔ\x04ＩＭＥＲ－\x07００\x04：\x0F００\x04：\x1F００ \x04◈ \x07ＬＶ\x04．００／\x1C５０ \x04◈ \x07ＥＸＰ\x04：００"..string.rep("\x0D",GetStrSize(0,"．")).."０％ ◈ \x06０００\x04 ◈ \x04００００"))})
CIfXEnd()

CIf(FP,{CD(ExpTmp,100,AtLeast),CV(Level,49,AtMost)},{SubCD(ExpTmp,100)})
local StimUnlock = "\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x07LV.10\x04 돌파, \x1B원격 스팀팩\x04이 \x03활성화\x04되었습니다.\n \n\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
local ReviveUnlock = "\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x07LV.50\x04 돌파, \x07소생 스킬\x04이 \x03활성화\x04되었습니다.\n \n\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
local SkillUnlock = "\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x07LV.40\x04 돌파, \x08공격 스킬\x04이 \x03활성화\x04되었습니다.\n \n\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
local ExchangeUnlock = "\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x07LV.20\x04 돌파, \x07자동 환전\x04이 \x03활성화\x04되었습니다.\n \n\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"

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
		SetV(ShieldEnV[1],3200);
		SetV(ShieldEnV[2],3200);
		SetV(ShieldEnV[3],3200);
		SetV(ShieldEnV[4],3200);
		SetCDeaths(FP,SetTo,1,ShieldUnlock[1]);
		SetCDeaths(FP,SetTo,1,ShieldUnlock[2]);
		SetCDeaths(FP,SetTo,1,ShieldUnlock[3]);
		SetCDeaths(FP,SetTo,1,ShieldUnlock[4]);
		
	})
	Trigger2X(FP,{CV(Level,40,AtLeast)},{RotatePlayer({DisplayTextX(SkillUnlock,4),PlayWAVX("staredit\\wav\\SkillUnlock.ogg"),PlayWAVX("staredit\\wav\\SkillUnlock.ogg"),PlayWAVX("staredit\\wav\\SkillUnlock.ogg"),PlayWAVX("staredit\\wav\\SkillUnlock.ogg")},HumanPlayers,FP)})
	Trigger2X(FP,{CV(Level,50,AtLeast)},{RotatePlayer({DisplayTextX(ReviveUnlock,4),PlayWAVX("staredit\\wav\\reviveunlock.ogg"),PlayWAVX("staredit\\wav\\reviveunlock.ogg"),PlayWAVX("staredit\\wav\\reviveunlock.ogg"),PlayWAVX("staredit\\wav\\reviveunlock.ogg")},HumanPlayers,FP)})
	
	f_Mul(FP,MarHPRegen,Level,256)
	CMov(FP,AtkCondTmp,_Mul(Level,4),50)
	CMov(FP,HPCondTmp,_Mul(Level,5))
	ItoDec(FP,_Add(Level,1),VArr(LVVA,0),2,nil,0)--렙
	f_Movcpy(FP,_Add(AtkCondTblPtr,AtkCondT[2]),VArr(LVVA,0),4*4)
	f_Movcpy(FP,_Add(HPCondTblPtr,HPCondT[2]),VArr(LVVA,0),4*4)
CIfEnd()

TriggerX(FP,{CD(CountTmp,399,AtMost)},{SetMemoryX(0x641630,SetTo,14,0xFF)},{Preserved})
TriggerX(FP,{CD(CountTmp,400,AtLeast)},{SetMemoryX(0x641630,SetTo,15,0xFF)},{Preserved})
TriggerX(FP,{CD(CountTmp,800,AtLeast)},{SetMemoryX(0x641630,SetTo,17,0xFF)},{Preserved})
TriggerX(FP,{CD(CountTmp,1200,AtLeast)},{SetMemoryX(0x641630,SetTo,08,0xFF)},{Preserved})
Print13_NumSetC(TimeTmp,0x6415BC,36000000,0x100)
Print13_NumSetC(TimeTmp,0x6415C0,3600000,0x1)
Print13_NumSetC(TimeTmp,0x6415C8,60000*10,0x1)
Print13_NumSetC(TimeTmp,0x6415C8,60000,0x1000000)
Print13_NumSetC(TimeTmp,0x6415D0,10000,0x1000000)
Print13_NumSetC(TimeTmp,0x6415D4,1000,0x10000)
Print13_NumSetC(LevelTmp,0x6415E8,10,0x10000)
Print13_NumSetC(LevelTmp,0x6415EC,1,0x100)
Print13_NumSetC(ExpTmp,0x64160C,100,0x10000)
Print13_NumSetC(ExpTmp,0x641610,10,0x100)
Print13_NumSetC(ExpTmp,0x641614,1,0x1000000)
Print13_NumSetC(RedNumberTmp,0x641620,100,0x1000000)
Print13_NumSetC(RedNumberTmp,0x641624,10,0x10000)
Print13_NumSetC(RedNumberTmp,0x641628,1,0x100)
Print13_NumSetC(CountTmp,0x641630,1000,0x1000000)
Print13_NumSetC(CountTmp,0x641634,100,0x10000)
Print13_NumSetC(CountTmp,0x641638,10,0x100)
Print13_NumSetC(CountTmp,0x64163C,1,0x1)

--SetMemory(0x641598, SetTo, 0x11B7C207);
--SetMemory(0x64159C, SetTo, 0xC208B7C2);
--SetMemory(0x6415A0, SetTo, 0x80E307B7);
--SetMemory(0x6415A4, SetTo, 0xEF102090);
--SetMemory(0x6415A8, SetTo, 0xEF04B4BC);
--SetMemory(0x6415AC, SetTo, 0xBCEFA9BC);
--SetMemory(0x6415B0, SetTo, 0xA5BCEFAD);
--SetMemory(0x6415B4, SetTo, 0xEFB2BCEF);
--SetMemory(0x6415B8, SetTo, 0xEF078DBC);
--SetMemory(0x6415BC, SetTo, 0xBCEF90BC);--10시
--SetMemory(0x6415C0, SetTo, 0xBCEF0490);--1시
--SetMemory(0x6415C4, SetTo, 0xBCEF0F9A);
--SetMemory(0x6415C8, SetTo, 0x90BCEF90);--0xFF 10분 0xFF000000 1분
--SetMemory(0x6415CC, SetTo, 0x9ABCEF04);
--SetMemory(0x6415D0, SetTo, 0x90BCEF1F);--10초
--SetMemory(0x6415D4, SetTo, 0x2090BCEF);--1초
--SetMemory(0x6415D8, SetTo, 0x8897E204);
--SetMemory(0x6415DC, SetTo, 0xBCEF0720);
--SetMemory(0x6415E0, SetTo, 0xB6BCEFAC);
--SetMemory(0x6415E4, SetTo, 0x8EBCEF04);
--SetMemory(0x6415E8, SetTo, 0xEF90BCEF);--10레벨
--SetMemory(0x6415EC, SetTo, 0xBCEF90BC);--1레벨
--SetMemory(0x6415F0, SetTo, 0xBCEF1C8F);
--SetMemory(0x6415F4, SetTo, 0x90BCEF95);--ㄴㄴ
--SetMemory(0x6415F8, SetTo, 0x97E20420);
--SetMemory(0x6415FC, SetTo, 0xEF072088);
--SetMemory(0x641600, SetTo, 0xBCEFA5BC);
--SetMemory(0x641604, SetTo, 0xB0BCEFB8);
--SetMemory(0x641608, SetTo, 0x9ABCEF04);
--SetMemory(0x64160C, SetTo, 0xEF90BCEF);--100
--SetMemory(0x641610, SetTo, 0xBCEF90BC);--10
--SetMemory(0x641614, SetTo, 0x90BCEF8E);--1
--SetMemory(0x641618, SetTo, 0x2085BCEF);
--SetMemory(0x64161C, SetTo, 0x208897E2);
--SetMemory(0x641620, SetTo, 0x90BCEF06);--10퍼
--SetMemory(0x641624, SetTo, 0xEF90BCEF);--1퍼
--SetMemory(0x641628, SetTo, 0x200490BC);--0.1퍼
--SetMemory(0x64162C, SetTo, 0x208897E2);
--SetMemory(0x641630, SetTo, 0x90BCEF04);--1000마리
--SetMemory(0x641634, SetTo, 0xEF90BCEF);--100마리
--SetMemory(0x641638, SetTo, 0xBCEF90BC);--10마리
--SetMemory(0x64163C, SetTo, 0xE3072090);--1마리
--SetMemory(0x641640, SetTo, 0xC2089180);
--SetMemory(0x641644, SetTo, 0xB7C211B7);
--SetMemory(0x641648, SetTo, 0x00B7C207);




	for i = 1, 3 do -- 강퇴기능
		TriggerX(FP,{Command(Force1,AtLeast,1,BanToken[i]);},{ModifyUnitEnergy(1,BanToken[i],Force1,64,0);RemoveUnitAt(1,BanToken[i],"Anywhere",Force1);SetCDeaths(FP,Add,1,BanCode[i]);},{Preserved})
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

		
		
		TriggerX(FP,{Command(Force1,AtLeast,1,62);},{ModifyUnitEnergy(1,62,Force1,64,0);RemoveUnitAt(1,62,"Anywhere",Force1);SetCVar(FP,SpeedVar[2],Add,1);},{Preserved})
		TriggerX(FP,{Command(Force1,AtLeast,1,61);},{ModifyUnitEnergy(1,61,Force1,64,0);RemoveUnitAt(1,61,"Anywhere",Force1);SetCVar(FP,SpeedVar[2],Subtract,1);},{Preserved})
    CIf(FP,{TTCVar(FP,CurrentSpeed[2],NotSame,SpeedVar)}) -- 배속조정 트리거
		TriggerX(FP,{CVar(FP,SpeedVar[2],AtMost,0)},{SetCVar(FP,SpeedVar[2],SetTo,1)},{Preserved})
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