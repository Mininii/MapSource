function Operator_Trig()
    Cunit2 = CreateVar(FP)
	CurrentOP = CreateVar(FP)
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
        f_Read(FP,0x58A364+(48*181)+(4*i),Dt) -- MSQC val Recive. 181
	end
    CIfXEnd()

	for i = 1, 3 do -- ������
		TriggerX(FP,{Command(Force1,AtLeast,1,BanToken[i]);},{RemoveUnitAt(1,BanToken[i],"Anywhere",Force1);SetCDeaths(FP,Add,1,BanCode[i]);},{Preserved})
		for j = 1, 4 do
			TriggerX(i,{CDeaths(FP,Exactly,j,BanCode[i])},{RotatePlayer({DisplayTextX(StrDesign(PlayerString[i+1].."\x04���� \x08��� �� "..j.."ȸ ����\x04 �Ǿ����ϴ�. �� 5ȸ ������ \x08���� ó�� \x04�˴ϴ�."),4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i)})
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
		Trigger { -- ���� ���
			players = {i},
			conditions = {
				Label(0);
				CDeaths(FP,AtLeast,5,BanCode[i]);Memory(0x57F1B0, Exactly, i)
				
			},
			actions = {
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				DisplayText(StrDesign("\x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�."),4);
				SetMemory(0xCDDDCDDC,SetTo,1);
				
				},
			}
		end

		TriggerX(FP,{Command(Force1,AtLeast,1,62);},{RemoveUnitAt(1,62,"Anywhere",Force1);SetCVar(FP,SpeedVar[2],Add,1);},{Preserved})
		TriggerX(FP,{Command(Force1,AtLeast,1,61);},{RemoveUnitAt(1,61,"Anywhere",Force1);SetCVar(FP,SpeedVar[2],Subtract,1);},{Preserved})
    CIf(FP,{TTCVar(FP,CurrentSpeed[2],NotSame,SpeedVar)}) -- ������� Ʈ����
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