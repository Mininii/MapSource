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
    CIfX(FP,Never()) -- �����÷��̾� �ܶ� ����
	for i = 0, 3 do
        CElseIfX(PlayerCheck(i,1),{SetCVar(FP,CurrentOP[2],SetTo,i),SetMemoryB(0x57F27C + (i * 228) + 60,SetTo,1)})
        f_Read(FP,0x6284E8+(0x30*i),"X",Cunit2)
        f_Read(FP,0x58A364+(48*181)+(4*i),DtX) -- MSQC val Recive. 181
		CTrigger(FP,{CV(DtX,2500,AtMost)},{SetV(Dt,DtX)},1)
	end
    CIfXEnd()
	if Limit == 1 then
	CMov(FP,0x6509B0,CurrentOP)--�����÷��̾� �ܶ�
	TriggerX(FP,{Switch("Switch 253",Set),Deaths(CurrentPlayer,AtLeast,1,199)},{SetCD(TestMode,1),SetSwitch("Switch 254",Set),SetMemory(0x657A9C,SetTo,31)})

	CIf({FP},CD(TestMode,1)) -- �׽�Ʈ Ʈ����
	
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
		CIf(FP,{Deaths(CurrentPlayer,AtLeast,1,203),CVar(FP,Cunit2[2],AtLeast,1),CVar(FP,Cunit2[2],AtMost,0x7FFFFFFF)})
			CMov(FP,0x6509B0,Cunit2,25)
			Trigger {
				players = {FP},
				conditions = {
					DeathsX(CurrentPlayer,AtMost,57,0,0xFF);
				},
				actions = {
					MoveCp(Subtract,6*4);
					SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
					MoveCp(Add,6*4);
					PreserveTrigger();
				}
			}
			Trigger {
				players = {FP},
				conditions = {
					DeathsX(CurrentPlayer,AtLeast,59,0,0xFF);
				},
				actions = {
					MoveCp(Subtract,6*4);
					SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
					MoveCp(Add,6*4);
					PreserveTrigger();
				}
			}
		CIfEnd()
	CIfEnd()

	CMov(FP,0x6509B0,FP)--�����÷��̾� �ܶ�
			end
--function StrDesignX(Str)
--	return "\x13\x07��\x11��\x08��\x07�� "..Str.." \x07��\x08��\x11��\x07��"
--end

local Print13T = CreateVar(FP)
CIf(FP,{Memory(0x628438, AtLeast, 0x00000001),CV(Print13T,3000,AtLeast)},{SetV(Print13T,0)})
	Print_13(FP,MapPlayers,nil)
CIfEnd({print_utf8(12,0,StrDesign("\x10��\x04�ɣͣţң�\x07����\x04��\x0F����\x04��\x1F���� \x04�� \x07�̣�\x04��������\x1C���� \x04�� \x07�ţأ�\x04������������ �� \x06������\x04 �� \x04��������"))})
CAdd(FP,Print13T,Dt)
CAdd(FP,Time1,Dt)
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

CIfX(FP,{CV(Level,49,AtMost)})
	f_Mul(FP,CurExpTmp,CurEXP,100)
	f_Div(FP,_Ccode(FP,ExpTmp),CurExpTmp,MaxEXP)
CElseX({SetCD(ExpTmp,100)})
CIfXEnd()

CIf(FP,{CD(ExpTmp,100,AtLeast),CV(Level,49,AtMost)},{SubCD(ExpTmp,100)})
	CSub(FP,CurEXP,MaxEXP)
	ConvertArr(FP,ArrI,Level)
	f_Read(FP,ArrX(EXPArr,ArrI),MaxEXP,nil,nil,1)
	CAdd(FP,Level,1)

	f_Mul(FP,MarHPRegen,Level,256)
	CMov(FP,AtkCondTmp,_Mul(Level,4),50)
	CMov(FP,HPCondTmp,_Mul(Level,5))
	ItoDec(FP,_Add(Level,1),VArr(LVVA,0),2,nil,0)--��
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
--SetMemory(0x6415BC, SetTo, 0xBCEF90BC);--10��
--SetMemory(0x6415C0, SetTo, 0xBCEF0490);--1��
--SetMemory(0x6415C4, SetTo, 0xBCEF0F9A);
--SetMemory(0x6415C8, SetTo, 0x90BCEF90);--0xFF 10�� 0xFF000000 1��
--SetMemory(0x6415CC, SetTo, 0x9ABCEF04);
--SetMemory(0x6415D0, SetTo, 0x90BCEF1F);--10��
--SetMemory(0x6415D4, SetTo, 0x2090BCEF);--1��
--SetMemory(0x6415D8, SetTo, 0x8897E204);
--SetMemory(0x6415DC, SetTo, 0xBCEF0720);
--SetMemory(0x6415E0, SetTo, 0xB6BCEFAC);
--SetMemory(0x6415E4, SetTo, 0x8EBCEF04);
--SetMemory(0x6415E8, SetTo, 0xEF90BCEF);--10����
--SetMemory(0x6415EC, SetTo, 0xBCEF90BC);--1����
--SetMemory(0x6415F0, SetTo, 0xBCEF1C8F);
--SetMemory(0x6415F4, SetTo, 0x90BCEF95);--����
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
--SetMemory(0x641620, SetTo, 0x90BCEF06);--10��
--SetMemory(0x641624, SetTo, 0xEF90BCEF);--1��
--SetMemory(0x641628, SetTo, 0x200490BC);--0.1��
--SetMemory(0x64162C, SetTo, 0x208897E2);
--SetMemory(0x641630, SetTo, 0x90BCEF04);--1000����
--SetMemory(0x641634, SetTo, 0xEF90BCEF);--100����
--SetMemory(0x641638, SetTo, 0xBCEF90BC);--10����
--SetMemory(0x64163C, SetTo, 0xE3072090);--1����
--SetMemory(0x641640, SetTo, 0xC2089180);
--SetMemory(0x641644, SetTo, 0xB7C211B7);
--SetMemory(0x641648, SetTo, 0x00B7C207);




	for i = 1, 3 do -- ������
		TriggerX(FP,{Command(Force1,AtLeast,1,BanToken[i]);},{RemoveUnitAt(1,BanToken[i],"Anywhere",Force1);SetCDeaths(FP,Add,1,BanCode[i]);},{Preserved})
		for j = 1, 4 do
			TriggerX(i,{CDeaths(FP,Exactly,j,BanCode[i])},{RotatePlayer({DisplayTextX(StrDesign(PlayerString[i+1].."\x04���� \x08����� �� "..j.."ȸ ����\x04 �Ǿ����ϴ�. �� 5ȸ ������ \x08���� ó�� \x04�˴ϴ�."),4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i)})
		end
		Trigger { -- ����
		players = {i},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,5,BanCode[i]);
		},
		actions = {
			RotatePlayer({DisplayTextX("\x07�� \x04"..PlayerString[i+1].."\x04�� ����ó���� �Ϸ�Ǿ����ϴ�.\x07 ��",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i);
			},
		}
		local WAVT = {}
		for k = 0, 9 do
			table.insert(WAVT,PlayWAVX("sound\\Protoss\\ARCHON\\PArDth00.WAV"))
			table.insert(WAVT,DisplayTextX(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4))
		end
		Trigger2X(i,{CDeaths(FP,AtLeast,5,BanCode[i]);Memory(0x57F1B0, Exactly, i)},{RotatePlayer(WAVT,i,i),SetMemory(0xCDDDCDDC,SetTo,1);})
		end

		TriggerX(FP,{Command(Force1,AtLeast,1,62);},{RemoveUnitAt(1,62,"Anywhere",Force1);SetCVar(FP,SpeedVar[2],Add,1);},{Preserved})
		TriggerX(FP,{Command(Force1,AtLeast,1,61);},{RemoveUnitAt(1,61,"Anywhere",Force1);SetCVar(FP,SpeedVar[2],Subtract,1);},{Preserved})
    CIf(FP,{TTCVar(FP,CurrentSpeed[2],NotSame,SpeedVar)}) -- ������� Ʈ����
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
                    DisplayTextX(StrDesignX("\x0F���� \x10�ӵ�\x04�� \x10- "..XSpeed[i].."\x04�� \x0F����\x04�Ͽ����ϴ�."), 0)},HumanPlayers,FP);
                    SetMemory(0x5124F0,SetTo,SpeedV[i]);
                },
            }
        end
    CIfEnd()
end