function Opening()
    local OPCCode = CreateCcode()
    
    CIf(FP,{CD(OPJump,0,AtMost)})
    CDoActions(FP,{AddCD(OPCCode,Dt)})
    DoActionsX(FP,{SetV(BGMType,1)},1)
    if Limit == 0 then
    
    end
	for i=1, 57 do
        Trigger2X(FP,{CDeaths(FP,AtLeast,i*15,OPCCode);},{RotatePlayer(
			{DisplayTextX(string.rep("\x0D\x0D\n", 10),4);
			DisplayTextX("\x0D\x0D\n",4);
			DisplayTextX("\x0D\x0D\x13\x04"..string.rep("��", i),4);
			DisplayTextX("\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n",4);
			DisplayTextX("\x0D\x0D\x13\x04"..string.rep("��", i),4);
			DisplayTextX("\x0D\x0D\n\x0D\x0D\n",4);
        },HumanPlayers,FP)})
end
Trigger2X(FP,{CDeaths(FP,AtLeast,956,OPCCode);},{RotatePlayer(
    {DisplayTextX(string.rep("\x0D\x0D\n", 10),4);
    DisplayTextX("\x0D\x0D\n",4);
    DisplayTextX("\x0D\x0D\x13\x04"..string.rep("��", 57),4);
    DisplayTextX("\x0D\x0D\x13\x06== \x04����Ű��� \x07�ͣ�����_�� \x06==\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x02"..VerText.."\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x1FSTRCtrig \x04Assembler \x07v5.4\x04, \x1FCB \x16Paint \x07v2.4 \x04in Used \x19(��>��<)��",4);
    DisplayTextX("\x0D\x0D\x13\x04"..string.rep("��", 57),4);
    DisplayTextX("\x0D\x0D\x13\x03\x0D\x0D\n\x0D\x0D\n",4);},HumanPlayers,FP)})
Trigger2X(FP,{CDeaths(FP,AtLeast,3100,OPCCode);},{RotatePlayer(
    {DisplayTextX(string.rep("\x0D\x0D\n", 10),4);
    DisplayTextX("\x0D\x0D\n",4);
    DisplayTextX("\x0D\x0D\x13\x04"..string.rep("��", 57),4);
    DisplayTextX("\x0D\x0D\x13\x06== \x04����Ű��� \x07�ͣ�����_�� \x06==\x0D\x0D\n\x0D\x0D\x13\x05��\x04The Wonderful Abstractions of a Lost Memory\x07��\x0D\x0D\n\x0D\x0D\x13\x02"..VerText.."\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x1FSTRCtrig \x04Assembler \x07v5.4\x04, \x1FCB \x16Paint \x07v2.4 \x04in Used \x19(��>��<)��",4);
    DisplayTextX("\x0D\x0D\x13\x04"..string.rep("��", 57),4);
    DisplayTextX("\x0D\x0D\x13\x03\x0D\x0D\n\x0D\x0D\n",4);},HumanPlayers,FP)})
Trigger2X(FP,{CDeaths(FP,AtLeast,3378,OPCCode);},{RotatePlayer(
    {DisplayTextX(string.rep("\x0D\x0D\n", 10),4);
    DisplayTextX("\x0D\x0D\n",4);
    DisplayTextX("\x0D\x0D\x13\x04"..string.rep("��", 57),4);
    DisplayTextX("\x0D\x0D\x13\x06== \x04����Ű��� \x07�ͣ�����_�� \x06==\x0D\x0D\n\x0D\x0D\x13\x07��\x04The Wonderful Abstractions of a Lost Memory\x07��\x0D\x0D\n\x0D\x0D\x13\x02"..VerText.."\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x1FSTRCtrig \x04Assembler \x07v5.4\x04, \x1FCB \x16Paint \x07v2.4 \x04in Used \x19(��>��<)��",4);
    DisplayTextX("\x0D\x0D\x13\x04"..string.rep("��", 57),4);
    DisplayTextX("\x0D\x0D\x13\x03\x0D\x0D\n\x0D\x0D\n",4);},HumanPlayers,FP)})
Trigger2X(FP,{CDeaths(FP,AtLeast,4200,OPCCode);},{RotatePlayer(
    {DisplayTextX(string.rep("\x0D\x0D\n", 10),4);
    DisplayTextX("\x0D\x0D\n",4);
    DisplayTextX("\x0D\x0D\x13\x04"..string.rep("��", 57),4);
    DisplayTextX("\x0D\x0D\x13\x06== \x04����Ű��� \x07�ͣ�����_�� \x06==\x0D\x0D\n\x0D\x0D\x13\x07��\x04The Wonderful Abstractions of a Lost Memory\x07��\x0D\x0D\n\x0D\x0D\x13\x02"..VerText.."\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x1FSTRCtrig \x04Assembler \x07v5.4\x04, \x1FCB \x16Paint \x07v2.4 \x04in Used \x19(��>��<)��",4);
    DisplayTextX("\x0D\x0D\x13\x04"..string.rep("��", 57),4);
    DisplayTextX("\x0D\x0D\x13\x03Made \x06by \x04GALAXY_BURST\x0D\x0D\n\x0D\x0D\x13\x04���� ������ F10 + J �� �ֽ��ϴ�.",4);},HumanPlayers,FP)})
for i = 1, 3 do
Trigger2X(FP,{CDeaths(FP,AtLeast,5900+(i*1000),OPCCode);},{RotatePlayer(
    {DisplayTextX(string.rep("\x0D\x0D\n", 10),4);
    DisplayTextX("\x0D\x0D\n",4);
    DisplayTextX("\x0D\x0D\x13\x04"..string.rep("��", 57),4);
    DisplayTextX("\x0D\x0D\x13\x06== \x04����Ű��� \x07�ͣ�����_�� \x06==\x0D\x0D\n\x0D\x0D\x13\x07��\x04The Wonderful Abstractions of a Lost Memory\x07��\x0D\x0D\n\x0D\x0D\x13\x02"..VerText.."\x0D\x0D\n\x0D\x0D\x13\x04"..(4-i).."�� ���ҽ��ϴ�.\x0D\x0D\n\x0D\x0D\x13\x1FSTRCtrig \x04Assembler \x07v5.4\x04, \x1FCB \x16Paint \x07v2.4 \x04in Used \x19(��>��<)��",4);
    DisplayTextX("\x0D\x0D\x13\x04"..string.rep("��", 57),4);
    DisplayTextX("\x0D\x0D\x13\x03Made \x06by \x04GALAXY_BURST\x0D\x0D\n\x0D\x0D\x13\x04���� ������ F10 + J �� �ֽ��ϴ�.",4);
    PlayWAVX("sound\\glue\\countdown.wav")
},HumanPlayers,FP)})
end
Trigger2X(FP,{CDeaths(FP,AtLeast,5900+(4*1000),OPCCode);},{RotatePlayer(
    {DisplayTextX(string.rep("\x0D\x0D\n", 10),4);
    DisplayTextX("\x0D\x0D\n",4);
    DisplayTextX("\x0D\x0D\x13\x04",4);
    DisplayTextX("\x0D\x0D\x13\x06\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04�ӡ��ԡ������ҡ���\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x1F",4);
    DisplayTextX("\x0D\x0D\x13\x04",4);
    DisplayTextX("\x0D\x0D\x13\x04\x0D\x0D\n\x0D\x0D\n",4);
    PlayWAVX("sound\\Bullet\\pshield.wav");
},HumanPlayers,FP),SetCD(OPJump,1),SetMemory(0x657A9C,SetTo,31),SetSwitch("Switch 253",Clear)})
DoActions2(FP,{RotatePlayer({CenterView(64)},HumanPlayers,FP)})
CIfEnd()
if Limit == 1 then
    TriggerX(FP,{CD(TestMode,1)},{SetCD(OPCCode,5900+(4*1000))})
    --TriggerX(FP,{CD(TestMode,1)},{ModifyUnitShields(All,"Men",Force1,64,100),ModifyUnitHitPoints(All,"Men",Force1,64,100)},{preserved})
end
CIfOnce(FP,CD(OPJump,1))



if Limit == 1 then


	TriggerX(FP,{},{RotatePlayer({RunAIScript(P8VOFF),RunAIScript(P7VOFF),RunAIScript(P6VOFF),RunAIScript(P5VOFF)},MapPlayers,FP)})
	
	for i = 0, 3 do
	TriggerX(FP,{CD(TestMode,1),HumanCheck(i)},{CreateUnitWithProperties(24,MarID[i+1],i+2,i,{energy = 100}),SetResources(i,Add,15000,Ore)})
	TriggerX(FP,{HumanCheck(i)},{CreateUnitWithProperties(3,32,i+2,i,{energy = 100}),CreateUnitWithProperties(1,20,i+2,i,{energy = 100}),SetResources(i,Add,15000,Ore)})
	TriggerX(FP,{HumanCheck(i),CVar(FP,SetPlayers[2],Exactly,1)},{CreateUnitWithProperties(2,32,i+2,i,{energy = 100}),CreateUnitWithProperties(1,20,i+2,i,{energy = 100}),SetResources(i,Add,15000,Ore)})
    
	end
else
	TriggerX(FP,{},{RotatePlayer({RunAIScript(P8VOFF),RunAIScript(P7VOFF),RunAIScript(P6VOFF),RunAIScript(P5VOFF)},MapPlayers,FP)})
	for i = 0, 3 do
    TriggerX(FP,{HumanCheck(i),CVar(FP,SetPlayers[2],Exactly,1)},{CreateUnitWithProperties(2,32,i+2,i,{energy = 100}),CreateUnitWithProperties(1,20,i+2,i,{energy = 100}),SetResources(i,Add,15000,Ore)})
    
	TriggerX(FP,{HumanCheck(i)},{CreateUnitWithProperties(3,32,i+2,i,{energy = 100}),CreateUnitWithProperties(1,20,i+2,i,{energy = 100}),SetResources(i,Add,15000,Ore)})
	end
end
for i = 0, 3 do
	TriggerX(FP,{HumanCheck(i)},{GiveUnits(All,"Buildings",P12,i+2,i),GiveUnits(All,203,P12,i+2,i),GiveUnits(All,"Buildings",P12,i+17,i),SetCp(i),CenterView(i+2),SetCp(FP)})
end

DoActions(FP,{RemoveUnit(111,P12),RemoveUnit(107,P12),RemoveUnit(125,P12),RemoveUnit(203,P12)})
CIfEnd()

DoActions(FP,{RemoveUnit(183,P12),RemoveUnit(84,P12),RemoveUnit(84,Force1)})

CIf(FP,CD(Win,1,AtLeast))
CDoActions(FP,{AddCD(Win,Dt)})
DoActions2(FP,{RotatePlayer({PlayWAVX("staredit\\wav\\H_Clear.ogg"),PlayWAVX("staredit\\wav\\H_Clear.ogg")},HumanPlayers,FP)},1)
	for i=1, 57 do
	Trigger2X(FP,{CD(Win,i*8,AtLeast)},RotatePlayer({
        DisplayTextX(string.rep("\x0D\x0D\n", 10),4),
        DisplayTextX("\x0D\x0D\n",4),
        DisplayTextX("\x0D\x0D\x13\x04"..string.rep("��", i),4),
        DisplayTextX("\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n",4),
        DisplayTextX("\x0D\x0D\x13\x04"..string.rep("��", i),4),
        DisplayTextX("\x0D\x0D\n\x0D\x0D\n",4),
    },HumanPlayers,FP))

    
    
	end
EDText = {
    "\x08�£�䡡\x0F��\x04������ �� �� \x1F����\x04�� \x10ȥ��\x04�� \x17��� ",
    "\x08�Σ����졡\x0F��\x04������ �� �� \x18�Ҿ���� \x07��\x04�� \x17���",
    "\x0E�Σ����졡\x0F��\x04������ �� �� \x11����\x04�� \x17���",
    "\x10�Σ����졡\x0F��\x04������ �� �� \x10����\x04�� \x08���"
}

for i=1, 4 do
Trigger2X(FP,{CD(Win,500,AtLeast),CD(EDNum,i)},
    RotatePlayer({
        DisplayTextX(string.rep("\x0D\x0D\n", 10),4),
        DisplayTextX("\x0D\x0D\x13\x04"..string.rep("��", 56),4),
        DisplayTextX("\x0D\x0D\x13\x06== \x04����Ű��� \x07�ͣ�����_�� \x06==\x0D\x0D\n\x0D\x0D\x13\x07��\x04The Wonderful Abstractions of a Lost Memory\x07�� \x0D\x0D\n\x0D\x0D\x13\x10Ŭ����\x04 �ϼ̽��ϴ�.",4),
        DisplayTextX("\x0D\x0D\x13"..EDText[i],4),
        DisplayTextX("\x0D\x0D\x13\x1FSTRCtrig \x04Assembler \x07v5.4\x04, \x1FCB \x16Paint \x07v2.4 \x04in Used \x19(��>��<)��",4),
        DisplayTextX("\x0D\x0D\x13\x04"..string.rep("��", 56),4),
        DisplayTextX("\x0D\x0D\x13\x03Made \x06by \x04GALAXY_BURST\x0D\x0D\n\x0D\x0D\x13\x04�ԣ���롡����������򡡣У�������",4),
    },HumanPlayers,FP))
end



Trigger2X(FP,{CD(Win,5000,AtLeast),CD(EDNum,1)},
RotatePlayer({DisplayTextX(StrDesignX("\x04���� \x08���� ī��Ʈ\x04�� \x06400 �̻�\x04�Դϴ�. �ٽ� �������ּ���."),4),
PlayWAVX("staredit\\wav\\button3.wav"),
PlayWAVX("staredit\\wav\\button3.wav"),
PlayWAVX("staredit\\wav\\button3.wav")
},HumanPlayers,FP))
Trigger2X(FP,{CD(Win,5000,AtLeast),CD(TestMode,0)},
RotatePlayer({Victory()
},HumanPlayers,FP))
CIfEnd()

TriggerX(FP,{CD(OPJump,1)},{
    RemoveUnit(111,P12),
    RemoveUnit(125,P12),
    RemoveUnit(124,P12),
    RemoveUnit(107,P12),
    RemoveUnit(109,P12),},{preserved})
    
end