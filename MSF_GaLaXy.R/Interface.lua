function Interface()
	local InfWhile = CreateCcode()
	local Drop = CreateCcode()
	
	Trigger { -- ���չ� insertŰ
		players = {Force1},
		conditions = {
			Memory(0x596A44, Exactly, 0x00000100);
		},
		actions = {
			--DisplayText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\x12\x04���� ���չ�\n\x12\x04Marine + \x1F"..HMCost.."�� \x04= \x1BH \x04Marine\n\x12\x1BH \x04Marine + \x1F"..GMCost.."�� \x04= \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\n\x12\x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\x04 + \x1F"..NeCost.."�� \x04= \x11��\x07��\x1F��\x1C��\x17��\x11��\n\x12\x04���������� �����ϴ�.\n\x12\x04ȯ�� : \x03�跰���� F�� ��������.\n\x12\x04�ݱ� : \x03Delete\n\n\n",4);
			DisplayText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\x12\x04���� Ȯ��ǥ\n\x12\x04Marine \x07- \x0E65.00%\n\x12\x1BH \x04Marine \x07- \x0F20.00%\n\x12\x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine \x07- \x108.90%\n\x12\x11��\x07��\x1F��\x1C��\x17��\x11�� \x07- \x114.10%\n\x12\x10��\x07��\x0F�ң�\x1F�� \x07- \x081.70%\n\x12\x07��\x1F��\x1C��\x0E��\x0F��\x10��\x17��\x11��\x08�� \x07- \x1D0.25%\n\x12\x11��\x1F��\x1B��\x16��\x10��\x1D�� \x07- \x1F0.05%\n\x12\x04\x10��\x07��\x0F�ң�\x1F��\x04 ���� ���� ���� 3��� \x07���հ���\n\x12\x04ȯ�� : \x03�跰���� F�� ��������. \x04�ݱ� : \x03Delete",4);
			PreserveTrigger();
		},
	}
	Trigger { -- ä��â ���� deleteŰ
		players = {Force1},
		conditions = {
			Memory(0x596A44, Exactly, 65536);
	},
		actions = {
			DisplayText(string.rep("\n", 20),4);
			PreserveTrigger();
			},
		}
	Trigger { -- ���ͻ��� ����
	players = {Force1},
	actions = {
		SetAllianceStatus(Force1,Ally);
		SetAllianceStatus(P12,Enemy);
		RunAIScript("Turn ON Shared Vision for Player 1");
		RunAIScript("Turn ON Shared Vision for Player 2");
		RunAIScript("Turn ON Shared Vision for Player 3");
		RunAIScript("Turn ON Shared Vision for Player 4");
		RunAIScript("Turn ON Shared Vision for Player 5");
		RunAIScript("Turn ON Shared Vision for Player 6");
		RunAIScript("Turn ON Shared Vision for Player 7");
		PreserveTrigger();
	},
}
	for i = 1, 6 do -- ������
		Trigger { -- ������ū
			players = {FP},
			conditions = {
				Label(0);
				Command(Force1,AtLeast,1,BanToken[i]);
			},
			actions = {
				RemoveUnitAt(1,BanToken[i],"Anywhere",Force1);
				SetCDeaths(FP,Add,1,BanCode[i]);
				PreserveTrigger();
				},
			}
			for j = 1, 4 do
				Trigger { -- ������ū
					players = {i},
					conditions = {
						Label(0);
						CDeaths(FP,Exactly,j,BanCode[i]);
					},
					actions = {
						RotatePlayer({DisplayTextX("\x07�� "..PlayerString[i+1].."\x04���� \x08��� �� "..j.."ȸ ����\x04 �Ǿ����ϴ�. �� 5ȸ ������ \x08���� ó�� \x04�˴ϴ�. \x07��",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,FP);
						},
					}
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
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					SetMemory(0xCDDDCDDC,SetTo,1);
					
					},
				}
				
			
			end
	for i = 0, 6 do
		Trigger { -- ����
		players = {i},
		conditions = {
			Label(0);
			CDeaths(FP, AtLeast, 2, DMode);
		},
		actions = {
			SetMemory(0x59CC78, SetTo, -1048576),
			SetMemory(0x59CC80, SetTo, 2),
			PreserveTrigger()
			},
		}
		
		
		Trigger { -- ����
		players = {i},
		conditions = {
			Label(0);
			CDeaths(FP, AtLeast, 2, DMode);
			Score(i,Custom,AtLeast,100);--��ī 100 �̻��� ���
		},
		actions = {
			RotatePlayer({DisplayTextX("\x07�� \x04"..PlayerString[i+1].."\x04�� ����ī��Ʈ �ƿ����� ���� \x06��� \x04���߽��ϴ�.\x07 ��",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i);
			},
		}
		
		Trigger { -- ����
		players = {i},
		conditions = {
			Label(0);
			CDeaths(FP, AtLeast, 2, DMode);
			CDeaths(FP,AtLeast,1,GStart),
			Bring(i, Exactly, 0, "Men", 64);
		},
		actions = {
			RotatePlayer({DisplayTextX("\x07�� \x04"..PlayerString[i+1].."\x04�� ������� ����� ���� \x06��� \x04���߽��ϴ�.\x07 ��",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i);
			},
		}
		
		Trigger { -- ���� ���
			players = {i},
			conditions = {
				Label(0);
				CDeaths(FP, Exactly, 2, DMode);--������
				Score(i,Custom,AtLeast,100);--��ī 100 �̻��� ���
				Memory(0x57F1B0, Exactly, i)--�����÷��̾���̵�
				
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
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				SetCD(Drop, 1),--���
				SetCtrigX("X",0xFFFD,0x4,0,SetTo,"X",0xFFFD,0x0,0,1);--ExitDrop
				},
			}
		Trigger { -- ���� ����
			players = {i},
			conditions = {
				Label(0);
				CDeaths(FP, Exactly, 3, DMode);--������
				Score(i,Custom,AtLeast,100);--��ī 100 �̻��� ���
				Memory(0x57F1B0, Exactly, i)--�����÷��̾���̵�
				
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
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				SetCD(InfWhile, 1),--�������
				},
			}
			
		Trigger { -- ���� ���
			players = {i},
			conditions = {
				Label(0);
				CDeaths(FP, Exactly, 2, DMode);--������
				CDeaths(FP,AtLeast,1,GStart),
				Bring(i, Exactly, 0, "Men", 64);
				Memory(0x57F1B0, Exactly, i)--�����÷��̾���̵�
				
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
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ����ȭ�鰡�� �ٶ��� ������ñ���.\x07 ��",4);
				SetCD(Drop, 1),--���
				SetCtrigX("X",0xFFFD,0x4,0,SetTo,"X",0xFFFD,0x0,0,1);--ExitDrop
				},
			}
		Trigger { -- ���� ����
			players = {i},
			conditions = {
				Label(0);
				CDeaths(FP, Exactly, 3, DMode);--������
				CDeaths(FP,AtLeast,1,GStart),
				Bring(i, Exactly, 0, "Men", 64);
				Memory(0x57F1B0, Exactly, i)--�����÷��̾���̵�
				
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
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				DisplayText("\x07�� \x04����.. �󸶳� ������ �̴ϱ�? �� �� ����ϼ���. ��Ÿ�� �ð��� ��ǳ�� �����ϴ�.\x07 ��",4);
				SetCD(InfWhile, 1),--�������
				},
			}


		DoActions(i,{
			SetMemoryB(0x57F27C+(228*i)+MedicTrig[1],SetTo,0),
			SetMemoryB(0x57F27C+(228*i)+MedicTrig[2],SetTo,0),
			SetMemoryB(0x57F27C+(228*i)+MedicTrig[3],SetTo,0),
			SetMemoryB(0x57F27C+(228*i)+MedicTrig[4],SetTo,0),
		})
		for j = 0, 3 do
			TriggerX(i,{CDeaths(FP,Exactly,j,DelayMedic[i+1])},{SetMemoryB(0x57F27C+(228*i)+MedicTrig[j+1],SetTo,1)},{preserved})
			TriggerX(i,{Command(i,AtLeast,1,72),CDeaths(FP,Exactly,j,DelayMedic[i+1])},{
				DisplayText(DelayMedicT[j+1],4),
				SetCDeaths(FP,Add,1,DelayMedic[i+1]),
				GiveUnits(All,72,i,"Anywhere",P12),
				RemoveUnitAt(1,72,"Anywhere",P12)},{preserved})
		end
			TriggerX(i,{CDeaths(FP,AtLeast,4,DelayMedic[i+1])},{SetCDeaths(FP,Subtract,4,DelayMedic[i+1])},{preserved})
		
			Trigger2(i,{DeathsX(i,Exactly,0,12,0xFF000000);Command(i,AtLeast,1,3);},{
				GiveUnits(All,3,i,"Anywhere",P12);
				RemoveUnitAt(All,3,"Anywhere",P12);
				DisplayText("\x07�� \x1CBGM\x04�� ���� �ʽ��ϴ�. \x07��",4);
				SetDeathsX(i,SetTo,1*16777216,12,0xFF000000);
			},{preserved})

			Trigger2(i,{DeathsX(i,Exactly,1*16777216,12,0xFF000000);Command(i,AtLeast,1,3);},{
				GiveUnits(All,3,i,"Anywhere",P12);
				RemoveUnitAt(All,3,"Anywhere",P12);
				DisplayText("\x07�� \x1CBGM\x04�� ����ϴ�. \x07��",4);
				SetDeathsX(i,SetTo,0*16777216,12,0xFF000000);
			},{preserved})

			for k = 0, 5 do
				Trigger { -- ��� �ݾ� ����
					players = {i},
					conditions = {
						Label(0);
						CDeaths(FP,Exactly,k,GiveRate[i+1]);
						Command(i,AtLeast,1,"Protoss Reaver");
					},
					actions = {
						GiveUnits(All,"Protoss Reaver",CurrentPlayer,"Anywhere",11);
						RemoveUnitAt(All,"Protoss Reaver","Anywhere",11);
						DisplayText(GiveRateT[k+1],4);
						SetCDeaths(FP,Add,1,GiveRate[i+1]);
						PreserveTrigger();
						},
				}
			end
		TriggerX(i,{CDeaths(FP,AtLeast,6,GiveRate[i+1])},{SetCDeaths(FP,Subtract,6,GiveRate[i+1])},{preserved})

		
Trigger {
	players = {i},
	conditions = {
		MemoryB(0x58D2B0+(46*i)+0,Exactly,255);
	},
	actions = {
		SetMemoryB(0x58D088+(46*i)+1,SetTo,0);
		SetMemoryB(0x58D088+(46*i)+2,SetTo,0);

	}
}
Trigger {
	players = {i},
	conditions = {
		MemoryB(0x58D088+(46*i)+8,Exactly,0),
		MemoryB(0x58D088+(46*i)+9,Exactly,0);
		MemoryB(0x58D088+(46*i)+1,Exactly,0);
		MemoryB(0x58D088+(46*i)+2,Exactly,0);
	},
	actions = {
		SetMemoryB(0x57F27C + (i * 228) + 50,SetTo,1),
		SetMemoryB(0x57F27C + (i * 228) + 51,SetTo,1),
		SetMemoryB(0x57F27C + (i * 228) + 53,SetTo,1),
		SetMemoryB(0x57F27C + (i * 228) + 54,SetTo,1),
		SetMemoryB(0x57F27C + (i * 228) + 52,SetTo,1),

	}
}

Trigger { -- �ڵ�ȯ��
players = {i},
conditions = {
	Command(i,AtLeast,1,"Terran Vulture");
},
actions = {
	RemoveUnitAt(1,"Terran Vulture","Anywhere",i);
	SetDeaths(i,SetTo,50,"Terran Barracks");
	DisplayText(StrDesign("\x07�ڵ�ȯ��\x04�� ����ϼ̽��ϴ�. - \x1F1000 O r e"),4);
	PreserveTrigger();
},
}




CIf(FP,{HumanCheck(i,1)})

local ACArr = {0,20,100,16}
local ACArr2 = {
	StrDesign("\x04���� ��ó�� ��� \x04Marine \x04�� �����մϴ�."),
	StrDesign("\x04���� ��ó�� ��� \x1BH \x04Marine \x04�� �����մϴ�."),
	StrDesign("\x04���� ��ó�� ��� \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine \x04�� �����մϴ�."),
	StrDesign("\x04���� ��ó�� ��� \x11��\x07��\x1F��\x1C��\x17��\x11�� \x04�� �����մϴ�.")
}

for j,k in pairs({50,51,53,54}) do
	Trigger { -- �ڵ�����
	players = {FP},
	conditions = {
		Label();
		Command(i,AtLeast,1,k);
	},
	actions = {
		RemoveUnitAt(1,k,"Anywhere",i);
		MoveUnit(All, ACArr[j], i, 21, 3);
		SetCp(i);
		DisplayText(ACArr2[j],4);
		SetCD(AutoCombiCcode[i+1], 1);
		SetCp(FP);
		PreserveTrigger();
	},
	}

end
Trigger { -- �ڵ�����
players = {FP},
conditions = {
	Label();
	Command(i,AtLeast,1,52);
},
actions = {
	RemoveUnitAt(1,52,"Anywhere",i);
	MoveUnit(All, 0, i, 21, 3);
	MoveUnit(All, 20, i, 21, 3);
	MoveUnit(All, 100, i, 21, 3);
	MoveUnit(All, 16, i, 21, 3);
	SetCD(AutoCombiCcode[i+1], 1);
	SetCp(i);
	DisplayText(StrDesign("\x04���� ��ó�� ��� \x1F���� ���� ���� \x04�� �����մϴ�."),4);
	SetCp(FP);
	PreserveTrigger();
},
}
TriggerX(FP, {
	CD(AutoCombiCcode[i+1], 1);
	Bring(i, AtMost, 2, 0, 3);
	Bring(i, AtMost, 2, 20, 3);
	Bring(i, AtMost, 2, 100, 3);
	Bring(i, AtMost, 2, 16, 3);
}, {SetCD(AutoCombiCcode[i+1], 0),
MoveUnit(All, 0, i, 3, 4);
MoveUnit(All, 20, i, 3, 4);
MoveUnit(All, 100, i, 3, 4);
MoveUnit(All, 16, i, 3, 4);
}, {preserved})
CallTriggerX(FP,MinGacha,{Kills(i,AtLeast,1,176)},{SetKills(i,Subtract,1,176),SetV(MinGachaP,i)})
CallTriggerX(FP,MinGacha,{Kills(i,AtLeast,1,177)},{SetKills(i,Subtract,1,177),SetV(MinGachaP,i)})
CallTriggerX(FP,MinGacha,{Kills(i,AtLeast,1,178)},{SetKills(i,Subtract,1,178),SetV(MinGachaP,i)})





local ExchangeP = CreateVar(FP)
local TempScore=CreateVar(FP)
local TempOre=CreateVar(FP)
	ExJump = def_sIndex()
	NJump(FP,ExJump,{Deaths(i,AtMost,0,"Terran Barracks"),Bring(i,AtMost,0,"Men",36),Bring(i,AtMost,0,"Men",2),Bring(i,AtMost,0,"Men",37)})
	CIf(FP,Score(i,Kills,AtLeast,1000))
	f_Read(FP,0x581F04+(i*4),TempScore)
	f_Div(FP,ExchangeP,TempScore,1000)
	f_Mod(FP,0x581F04+(i*4),TempScore,1000)
	f_Mul(FP,TempOre,ExchangeP,ExRateV)
	CAdd(FP,0x57F0F0+(i*4),TempOre)
	CMov(FP,0x6509B0,FP)
	CIfEnd({SetV(TempScore,0),
	SetV(ExchangeP,0),
	SetV(TempOre,0)})
	DoActions(FP,SetDeaths(i,Subtract,1,111))
	NJumpEnd(FP,ExJump)

HealT = CreateCcode()

Trigger { -- ����Ʈ����
players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtMost,0,HealT);
	},
	actions = {
		SetCDeaths(FP,Add,50,HealT);
		ModifyUnitHitPoints(All,"Men",Force1,4,100);
		ModifyUnitShields(All,"Men",Force1,4,100);
		PreserveTrigger();
	},
}



CIf(FP,{CDeaths(FP,Exactly,50,HealT),CV(HiddenHP,1,AtLeast)})

HealFuncJump = def_sIndex()
CJump(FP,HealFuncJump)
Call_HealZone = SetCallForward()
SetCall(FP)

local CUnitID = CreateVar(FP)
CAdd(FP,0x6509B0,15)


f_SaveCp()
CMov(FP,CUnitID,_Read(BackupCp,0xFF),nil,0xFF,1)
CDoActions(FP,{TSetMemory(_Sub(BackupCp,23),SetTo,_Read(_Add(CUnitID,EPDF(0x662350))))})
f_LoadCp()
CSub(FP,0x6509B0,15)


SetCallEnd()
CJumpEnd(FP,HealFuncJump)


function DeathsXRange(Player, Left,Right, Unit,Mask)
	return {DeathsX(Player, AtLeast, Left, Unit, Mask),DeathsX(Player, AtMost, Right, Unit, Mask)}
end



CMov(FP,0x6509B0,19025+10)
CWhile(FP,Memory(0x6509B0,AtMost,19025+10 + (84*1699)))
if X2_Mode == 1 then
	CallTriggerX(FP, Call_HealZone, {DeathsXRange(CurrentPlayer, 3552*2,3872*2, 0,0xFFFF),DeathsXRange(CurrentPlayer, 160*2*65536,416*2*65536, 0,0xFFFF0000)})
else
	CallTriggerX(FP, Call_HealZone, {DeathsXRange(CurrentPlayer, 3552,3872, 0,0xFFFF),DeathsXRange(CurrentPlayer, 160*65536,416*65536, 0,0xFFFF0000)})
end


CAdd(FP,0x6509B0,84)
CWhileEnd()
CMov(FP,0x6509B0,FP)


CIfEnd()
DoActionsX(FP,{SubCD(HealT,1)})

	for j = 1, 5 do
TriggerX(FP,{CVar(FP,HiddenATKM[2],Exactly,j),MemoryB(0x58D2B0+(46*i)+7,Exactly,50+(200-(40*j)))},{
	SetMemoryB(0x58D088+(46*i)+8,SetTo,0),
	SetMemoryB(0x58D088+(46*i)+9,SetTo,0),
	SetMemoryB(0x57F27C + (i * 228) + 1,SetTo,1),
})

TriggerX(FP,{CVar(FP,HiddenATKM[2],Exactly,j),MemoryB(0x58D2B0+(46*i)+14,Exactly,50+(200-(40*j)))},{
	SetMemoryB(0x58D088+(46*i)+13,SetTo,0),
})

	end

TriggerX(FP,{CVar(FP,HiddenATKM[2],Exactly,0),MemoryB(0x58D2B0+(46*i)+7,Exactly,255)},{
	SetMemoryB(0x58D088+(46*i)+8,SetTo,0),
	SetMemoryB(0x58D088+(46*i)+9,SetTo,0),
	SetMemoryB(0x57F27C + (i * 228) + 1,SetTo,1),
})

UpButtonSetArr = {}
table.insert(UpButtonSetArr,SetMemoryB(0x58D2B0+(46*i)+8,SetTo,0))
table.insert(UpButtonSetArr,SetMemoryB(0x58D2B0+(46*i)+9,SetTo,0))
table.insert(UpButtonSetArr,SetMemoryB(0x58D2B0+(46*i)+1,SetTo,0))
table.insert(UpButtonSetArr,SetMemoryB(0x58D2B0+(46*i)+2,SetTo,0))



local MedicTrigJump = def_sIndex()
for j = 1, 4 do
	NJumpX(FP,MedicTrigJump,{CDeaths(FP,Exactly,j-1,DelayMedic[i+1]),Bring(i,AtLeast,1,MedicTrig[j],64)})
end
NIf(FP,Never())
	NJumpXEnd(FP,MedicTrigJump)
	TriggerX(FP,{CV(HiddenHPM,0)},{
		RemoveUnit(MedicTrig[1],i),
		RemoveUnit(MedicTrig[2],i),
		RemoveUnit(MedicTrig[3],i),
		RemoveUnit(MedicTrig[4],i),
		ModifyUnitHitPoints(All,"Men",i,"Anywhere",100),
		ModifyUnitHitPoints(All,"Buildings",i,"Anywhere",100),
		ModifyUnitShields(All,"Men",i,"Anywhere",100),
		ModifyUnitShields(All,"Buildings",i,"Anywhere",100)
	},{preserved})
	TriggerX(FP,{CV(HiddenHPM,1,AtLeast)},{
		RemoveUnit(MedicTrig[1],i),
		RemoveUnit(MedicTrig[2],i),
		RemoveUnit(MedicTrig[3],i),
		RemoveUnit(MedicTrig[4],i),
		SetDeaths(i,SetTo,1,34);
		SetCD(CUnitFlag,1)
	},{preserved})
	TriggerX(FP,{CV(HiddenHP,1,AtLeast)},{
		RemoveUnit(MedicTrig[1],i),
		RemoveUnit(MedicTrig[2],i),
		RemoveUnit(MedicTrig[3],i),
		RemoveUnit(MedicTrig[4],i),
		SetDeaths(i,SetTo,1,34);
		SetCD(CUnitFlag,1)
	},{preserved})

		
--				TriggerX(FP,{CVar(FP,LevelT2[2],AtLeast,3),Bring(FP, AtMost, 0, 147, 64)},{
--					ModifyUnitShields(All,"Men",i,"Anywhere",0),
--					ModifyUnitShields(All,"Buildings",i,"Anywhere",0)},{preserved})
NIfEnd()
DoActionsX(FP,{
SetV(TempUpgradeMaskRet,0),
SetV(TempUpgradePtr,0),
SetV(CurrentUpgrade,0),
SetV(CurrentFactor,0),
SetV(UpCount,0)
})
CallTriggerX(FP,Call_OCU,MemoryB(0x58D2B0+(46*i)+8,AtLeast,1),{
	SetCVar(FP,TempUpgradePtr[2],SetTo,EPDF(AtkUpgradePtrArr[i+1])),
	SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^AtkUpgradeMaskRetArr[i+1]),
	SetCVar(FP,UpgradeFactor[2],SetTo,AtkFactor),
	SetCVar(FP,UpgradeCP[2],SetTo,i),
	SetCVar(FP,UpgradeMax[2],SetTo,255),
	SetMemoryB(0x58D2B0+(46*i)+8,SetTo,0),
	SetCDeaths(FP,SetTo,1,ifUpisAtk)
})
CallTriggerX(FP,Call_OCU,MemoryB(0x58D2B0+(46*i)+9,AtLeast,1),{
	SetCVar(FP,TempUpgradePtr[2],SetTo,EPDF(AtkUpgradePtrArr[i+1])),
	SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^AtkUpgradeMaskRetArr[i+1]),
	SetCVar(FP,UpgradeFactor[2],SetTo,AtkFactor),
	SetCVar(FP,UpgradeCP[2],SetTo,i),
	SetCVar(FP,UpgradeMax[2],SetTo,10),
	SetMemoryB(0x58D2B0+(46*i)+9,SetTo,0),
	SetCDeaths(FP,SetTo,1,ifUpisAtk),

})

CallTriggerX(FP,Call_OCU,MemoryB(0x58D2B0+(46*i)+1,AtLeast,1),{
	SetCVar(FP,TempUpgradePtr[2],SetTo,EPDF(DefUpgradePtrArr[i+1])),
	SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^DefUpgradeMaskRetArr[i+1]),
	SetCVar(FP,UpgradeFactor[2],SetTo,DefFactor),
	SetCVar(FP,UpgradeCP[2],SetTo,i),
	SetCVar(FP,UpgradeMax[2],SetTo,255),
	SetMemoryB(0x58D2B0+(46*i)+1,SetTo,0),
	SetCDeaths(FP,SetTo,0,ifUpisAtk)

})
CallTriggerX(FP,Call_OCU,MemoryB(0x58D2B0+(46*i)+2,AtLeast,1),{
	SetCVar(FP,TempUpgradePtr[2],SetTo,EPDF(DefUpgradePtrArr[i+1])),
	SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^DefUpgradeMaskRetArr[i+1]),
	SetCVar(FP,UpgradeFactor[2],SetTo,DefFactor),
	SetCVar(FP,UpgradeCP[2],SetTo,i),
	SetCVar(FP,UpgradeMax[2],SetTo,10),
	SetMemoryB(0x58D2B0+(46*i)+2,SetTo,0),
	SetCDeaths(FP,SetTo,0,ifUpisAtk)
})
DoActions2(FP,UpButtonSetArr)
CIf(FP,{CD(FormCcode,0)})
	for NB = 0, 6 do -- �ߺ� Ʈ����
	Trigger {
		players = {FP},
		conditions = {
			Bring(i,AtLeast,1,"Men",NB+5);
			Bring(P10,AtLeast,1,125,NB+5);
		},
		actions = {
			GiveUnits(All,125,P10,NB+5,i);
			PreserveTrigger();
		},
	}
	Trigger {
		players = {FP},
		conditions = {
			Bring(i,Exactly,0,"Men",NB+5);
			Bring(i,AtLeast,1,125,NB+5);
		},
		actions = {
			GiveUnits(All,125,i,NB+5,P8);
			PreserveTrigger();
		},
	}
	end
	DoActions(FP,{GiveUnits(All,125,P12,64,P10),GiveUnits(All,125,P8,64,P10)})
CIfEnd()

local MarGUID = {0,20,100,16,99,12,60}

CallTriggerX(FP, MarGacha, {Command(i,AtLeast,1,"Terran Firebat");}, {SetV(MarGachaP,i),RemoveUnitAt(1,"Terran Firebat","Anywhere",i);SetDeaths(i,SetTo,1,101);SetDeaths(i,Add,1,125);})

CWhile(FP, {CD(RandMarCcode[i+1],1,AtLeast)}, SubCD(RandMarCcode[i+1],1))
CallTriggerX(FP, MarGacha, {}, {SetV(MarGachaP,i),SetDeaths(i,SetTo,1,101);SetDeaths(i,Add,1,125);})
CWhileEnd()

for j = 0, 6 do
TriggerX(FP,{Memory(0x628438,AtLeast,1),CVAar(VArr(MarCreateVArr[i+1], j), AtLeast, 1)},{SetCVAar(VArr(MarCreateVArr[i+1], j), Subtract, 1),CreateUnitWithProperties(1, MarGUID[j+1], 39, i, {energy=100}),MoveUnit(1, MarGUID[j+1], i, 39, 4),Order(MarGUID[j+1], i, 39, Attack, 4)},{preserved})
end

CIfEnd()
	end
	for j=0, 6 do

--	Trigger { -- ��ȯ ����
--	players = {j},
--	conditions = {
--		Command(j,AtLeast,1,"Terran Firebat");
--	},
--	actions = {
--		RemoveUnitAt(1,"Terran Firebat","Anywhere",j);
--		CreateUnitWithProperties(1,0,4,j,{energy = 100});
--		DisplayText("\x02�� \x04Marine�� \x19��ȯ\x04�Ͽ����ϴ�. - \x1F"..NMCost.." O r e",4);
--		SetDeaths(j,SetTo,1,101);
--		PreserveTrigger();
--	},
--}
--Trigger { -- ��ȯ ����
--players = {j},
--conditions = {
--	Command(j,AtLeast,1,1);
--	Deaths(j,AtMost,23,125);
--},
--actions = {
--	SetResources(j,Add,NMCost+GMCost+HMCost,ore);
--	RemoveUnitAt(1,1,"Anywhere",j);
--	DisplayText("\x02�� \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine \x19���� ��ȯ\x04 ������ ���� �ʽ��ϴ�. (���� - \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine \x0424�� ����) �ڿ� ��ȯ + \x1F"..(NMCost+GMCost+HMCost).." O r e",4);
--	PreserveTrigger();
--},
--}

--Trigger { -- ��ȯ ����
--players = {j},
--conditions = {
--	Deaths(j,AtLeast,24,125);
--	Command(j,AtLeast,1,1);
--},
--actions = {
--	RemoveUnitAt(1,1,"Anywhere",j);
--	DisplayText("\x02�� \x1F����\x04�� �Ҹ��Ͽ� \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine�� \x19��ȯ\x04�Ͽ����ϴ�. - \x1F"..(GMCost+NMCost+HMCost).." O r e",4);
--	CreateUnitWithProperties(1,100,4,j,{energy = 100});
--	SetDeaths(j,SetTo,1,101);
--	PreserveTrigger();
--},
--}



Trigger { -- ��í 10��
players = {j},
conditions = {
	Command(j,AtLeast,1,1);
	Deaths(j,AtMost,29,125);
},
actions = {
	RemoveUnitAt(1,1,"Anywhere",j);
	DisplayText("\x02�� \x07���� ���� �̱� 10ȸ \x04������ ���� �ʽ��ϴ�. (���� - \x07���� ���� �̱� \x0430ȸ �̻� ����)",4);
	PreserveTrigger();
},
}
Trigger { -- ��í 10��
players = {j},
conditions = {
	Deaths(j,AtLeast,30,125);
	Command(j,AtLeast,1,1);
	Accumulate(j, AtMost, NMCost10X-1, Ore)
},
actions = {
	RemoveUnitAt(1,1,"Anywhere",j);
	DisplayText("\x02�� \x07���� ���� �̱� 10ȸ \x04������ ���� �ʽ��ϴ�. (���� - \x1F300,000 Ore \x04����)",4);
	PreserveTrigger();
},
}

Trigger { -- ��í 10��
players = {j},
conditions = {
	Label();
	Deaths(j,AtLeast,30,125);
	Command(j,AtLeast,1,1);
	Accumulate(j, AtLeast, NMCost10X, Ore)
},
actions = {
	RemoveUnitAt(1,1,"Anywhere",j);
	SetResources(j,Subtract,NMCost10X,Ore);
	DisplayText("\x02�� \x1F����\x04�� �Ҹ��Ͽ� \x07���� ���� �̱� 10ȸ\x04�� \x19����\x04�մϴ�. - \x1F300,000 O r e",4);
	AddCD(RandMarCcode[j+1],10);
	SetDeaths(j,SetTo,1,101);
	PreserveTrigger();
},
}


Trigger { -- ���� ��������
players = {j},
conditions = {
	Memory(0x628438,AtLeast,1);
	Bring(j,AtLeast,3,0,3);
},
actions = {
	ModifyUnitEnergy(3,0,j,3,0);
	RemoveUnitAt(3,0,3,j);
	CreateUnitWithProperties(1,20,4,j,{energy = 100});
	DisplayText("\x02�� \x04Marine \x043�⸦ �����Ͽ� \x1BH \x04Marine���� \x19��ȯ\x04�Ͽ����ϴ�.",4);
	PreserveTrigger();
},
}
Trigger { -- ���� ������ ����
players = {j},
conditions = {
	Memory(0x628438,AtLeast,1);
	Bring(j,AtLeast,3,20,3);
},
actions = {
	ModifyUnitEnergy(3,20,j,3,0);
	RemoveUnitAt(3,20,3,j);
	CreateUnitWithProperties(1,100,4,j,{energy = 100});
	SetDeaths(j,Add,1,125);
	DisplayText("\x02�� \x1BH \x04Marine \x043�⸦ �����Ͽ� \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine���� \x19��ȯ\x04�Ͽ����ϴ�.",4);
	PreserveTrigger();
},
}
if TestStart == 1 then
	DoActions(j, {CreateUnit(1,60,4,j)},1)
end
Trigger { -- ���� �׺��
players = {j},
conditions = {
	Label(0);
	Memory(0x628438,AtLeast,1);
--	Command(j,AtMost,0,16);
	Bring(j,AtLeast,3,100,3);
},
actions = {
	ModifyUnitEnergy(3,100,j,3,0);
	RemoveUnitAt(3,100,3,j);
	DisplayText("\x02�� \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine \x043�⸦ �����Ͽ� \x11��\x07��\x1F��\x1C��\x17��\x11�� ���� \x19��ȯ\x04�Ͽ����ϴ�.",4);
	CreateUnitWithProperties(1,16,4,j,{energy = 100});
	PreserveTrigger();
},
}
Trigger { -- ���� �׶�
players = {j},
conditions = {
	Label(0);
	Memory(0x628438,AtLeast,1);
--	Command(j,AtMost,0,16);
	Bring(j,AtLeast,3,16,3);
},
actions = {
	ModifyUnitEnergy(3,16,j,3,0);
	RemoveUnitAt(3,16,3,j);
	DisplayText("\x02�� \x11��\x07��\x1F��\x1C��\x17��\x11�� \x043�⸦ �����Ͽ� \x10��\x07��\x0F�ң�\x1F�� ���� \x19��ȯ\x04�Ͽ����ϴ�.",4);
	CreateUnitWithProperties(1,99,4,j,{energy = 100});
	PreserveTrigger();
},
}



	end

	for k=0, 6 do -- ��νý���
		for j=0, 6 do
		if k~=j then
		for i=0, 5 do
		Trigger { -- �� ��� �ý���
			players = {k},
			conditions = {
				Label(0);
				--MemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],AtLeast,1);
				Command(k,AtLeast,1,GiveUnitID[j+1]);
				HumanCheck(j,1);
				CDeaths(FP,Exactly,i,GiveRate[k+1]);
				Accumulate(k,AtMost,GiveRate2[i+1],Ore);
			},
			actions = {
				--SetMemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],SetTo,0);`
				RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
				DisplayText("\x07�� \x04�ܾ��� �����մϴ�. \x07��",4);
				PreserveTrigger();
			},
			}
		Trigger { -- �� ��� �ý���
			players = {k},
			conditions = {
				Label(0);
				--MemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],AtLeast,1);
				Command(k,AtLeast,1,GiveUnitID[j+1]);
				HumanCheck(j,1);
				CDeaths(FP,Exactly,i,GiveRate[k+1]);
				Accumulate(k,AtLeast,GiveRate2[i+1],Ore);
				Accumulate(k,AtMost,0x7FFFFFFF,Ore);
			},
			actions = {
				SetResources(k,Subtract,GiveRate2[i+1],Ore);
				SetResources(j,Add,GiveRate2[i+1],Ore);
				--SetMemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],SetTo,0);
				
				RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
				DisplayText("\x07�� "..PlayerString[j+1].."\x04���� \x1F"..GiveRate2[i+1].." Ore\x04�� ����Ͽ����ϴ�. \x07��",4);
				SetMemory(0x6509B0,SetTo,j);
				DisplayText("\x12\x07��"..PlayerString[k+1].."\x04���� \x1F"..GiveRate2[i+1].." Ore\x04�� ��ι޾ҽ��ϴ�.\x02 \x07��",4);
				SetMemory(0x6509B0,SetTo,k);
				PreserveTrigger();
			},
			}
		end
		Trigger { -- �� ��� �ý���
			players = {k},
			conditions = {
				--MemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],AtLeast,1);
				Command(k,AtLeast,1,GiveUnitID[j+1]);
				HumanCheck(j,0);
			},
			actions = {
				DisplayText("\x07�� "..PlayerString[j+1].."\x04��(��) �������� �ʽ��ϴ�. \x07��",4);
				--SetMemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],SetTo,0);
				RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
				PreserveTrigger();
			},
			}
	end end end
	CallTxt = "\x13\x04����������������������������������������������������������������������������������������������������������������\n\x13\x04\n\x13\x04\x04���� ����Ű��� \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04:\x1FRe\x11B\x01��\x07t \x04�� �÷��� ���Դϴ�.\n\x13\n\x13\x1FCtrig \x04Assembler \x07v5.4\x04, \x1FCB \x16Paint \x07v2.4 \x04in Used \x19(��>��<)��\n\x13\x0FCreator \x04: GALAXY_BURST\n\x13\x07������ ����ī�� \x04: https://open.kakao.com/o/sejFLxdb\n\x13\x04\n\x13\x04������ \x1F2000 Ore\x04�� �޾ҽ��ϴ�.\n\x13\x04\n\x13\x04����������������������������������������������������������������������������������������������������������������"
	TriggerX(FP,{CD(ButtonSound,1,AtLeast)},{
		RotatePlayer({
		PlayWAVX("staredit\\wav\\button3.wav"),
		PlayWAVX("staredit\\wav\\button3.wav")
		},HumanPlayers,FP);
		SetCD(ButtonSound,0);
	},{preserved})
	TriggerX(FP,{CD(NoticeCD,1,AtLeast)},{
		RotatePlayer({
		PlayWAVX("staredit\\wav\\notice.wav"),
		PlayWAVX("staredit\\wav\\notice.wav"),
		DisplayTextX(CallTxt,4)
		},HumanPlayers,FP);
		SetCD(NoticeCD,0);SetResources(Force1,Add,2000,Ore)
	},{preserved})
	if Limit == 1 then
		--TriggerX(FP,{CD(TestMode,1)},{ModifyUnitHitPoints(All,"Men",Force1,64,100)},{preserved})
	end


	CIf(FP,{TTOR({CV(HiddenHPM,1,AtLeast),CV(HiddenHP,1,AtLeast)}),CD(CUnitFlag,1,AtLeast)},{SetCD(CUnitFlag,0)})
	FuncJump = def_sIndex()
	CJump(FP,FuncJump)
	MedicFunc = SetCallForward()
	SetCall(FP)
	CAdd(FP,0x6509B0,6)
	CIf(FP,{CV(HiddenHPM,1,AtLeast)})

	for i = 1, 5 do
		for j, k in pairs(MedicFuncArr) do
			TriggerX(FP,{CV(HiddenHPM,i),DeathsX(CurrentPlayer,Exactly,k,0,0xFF)},{
				SetMemory(0x6509B0,Subtract,23),
				SetDeaths(CurrentPlayer,Add,(MedicFuncArr2[j]-(MedicFuncArr2[j]*(0.16*i)))*256,0);
				SetMemory(0x6509B0,Add,22),
				SetDeathsX(CurrentPlayer,Add,(MedicFuncArr3[j]-(MedicFuncArr3[j]*(0.16*i)))*256,0,0xFFFFFF);
				SetMemory(0x6509B0,Add,1),
			},{preserved})
		end
	end
	CIfEnd()
	CIf(FP,{CV(HiddenHP,1,AtLeast)})
	local CUnitID = CreateVar(FP)
	f_SaveCp()
	CMov(FP,CUnitID,_Read(BackupCp,0xFF),nil,0xFF,1)
	CDoActions(FP,{TSetMemory(_Sub(BackupCp,23),SetTo,_Read(_Add(CUnitID,EPDF(0x662350))))})
	f_LoadCp()
	CIfEnd()


	CSub(FP,0x6509B0,6)
	SetCallEnd()
	CJumpEnd(FP,FuncJump)
	CMov(FP,0x6509B0,19025+19)
	CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))

	for i = 0, 6 do
		CallTriggerX(FP,MedicFunc,{DeathsX(CurrentPlayer,Exactly,i,0,0xFF),Deaths(i,AtLeast,1,34)})
	end
	

	CAdd(FP,0x6509B0,84)
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
	DoActions(FP,{SetDeaths(Force1,SetTo,0,34)})
	CIfEnd()
	
	CIf(FP, CD(Drop,1,AtLeast),{AddCD(Drop,1),KillUnit("Any unit",Force1)}) -- ��ī�ƿ��� �ڱ������� ����. 3ƽ�� ���
		TriggerX(FP,{CD(Drop,3,AtLeast)},{SetCp(8),RunAIScript(P8VON),SetCp(9),RunAIScript(P8VON),SetCp(10),RunAIScript(P8VON),SetCp(11),RunAIScript(P8VON)})
	CIfEnd()
	CIf(FP,{CD(InfWhile,1,AtLeast)},{AddCD(InfWhile,1),KillUnit("Any unit",Force1)}) -- ��ī�ƿ��� �ڱ������� ����. 3ƽ�� ����
	CWhile(FP, CD(InfWhile,4,AtLeast))
	CWhileEnd()
	CIfEnd()


	
--�����ν� ���� ����
SelEPD,SelHP,SelSh,SelMaxHP = CreateVars(4,FP)
SelUID = CreateVar(FP)
CIf(FP,{Memory(0x6284B8 ,AtLeast,1),Memory(0x6284B8 + 4,AtMost,0)})
f_Read(FP,0x6284B8,nil,SelEPD)
CDoActions(FP,{TSetMemory(SelOPEPD,Add,1)})
f_Read(FP,_Add(SelEPD,2),SelHP)
f_Read(FP,_Add(SelEPD,25),SelUID,"X",0xFF)
f_Read(FP,_Add(SelEPD,24),SelSh,"X",0xFFFFFF)
CMov(FP,SelMaxHP,_Div(_ReadF(_Add(SelUID,_Mov(EPDF(0x662350)))),_Mov(256)))
f_Div(FP,SelHP,_Mov(256))
f_Div(FP,SelSh,_Mov(256))
CDoActions(FP,{TSetMemory(SelHPEPD,SetTo,SelHP),TSetMemory(MarHPEPD,SetTo,SelMaxHP),TSetMemory(SelShEPD,SetTo,SelSh)})
CIfEnd()



end 