function InputStory()
    local StartStoryTelling = CreateCcode()
    local StartStoryTelling2 = CreateCcode()
    local StoryT = CreateCcode()
    local StoryT2 = CreateCcode()
    TriggerX(FP,{CD(OPJump,1),CD(Theorist,1,AtLeast),DeathsX(AllPlayers,AtMost,0,12,0xFFFFFF)},{SetCD(StartStoryTelling,1)})
    CIf(FP,{CD(StartStoryTelling,1)})
    CAdd(FP,_Ccode(FP,StoryT),Dt)
    DoActionsX(FP,SetV(BGMType,11),1)
function AxiomStory(T,Text,AddTrig)
    Trigger2X(FP, {CDeaths(FP,AtLeast,T,StoryT)}, {
        RotatePlayer({
            DisplayTextX(string.rep("\n", 20),4),
            DisplayTextX("\x13\x04"..string.rep("��", 56),4),
            DisplayTextX("\x12\n\n\x0D\x0D!H\x13"..Text.."\n\n\n",0),
            DisplayTextX("\x13\x04"..string.rep("��", 56),4),
        },HumanPlayers,FP);
        SetCDeaths(FP,Add,1,ButtonSound);
        AddTrig
    })
end

AxiomStory(5000*2,"\x04�� � \x10�� \x04�� �̻��� ���� ��ٸ���.")
AxiomStory(5000*3,"\x04��� \x07����\x04�� \x0F�ɰ�\x04�ϰ�, ��� \x11��Ģ\x04�� \x1D�ʰ�\x04�ϴ� ��.")
AxiomStory(5000*4,"\x07��\x04�� \x10�븳\x04�� \x1F���\x04���� ���� �ϵ��... \x08�� �ߵ��� �ϵ�...")
AxiomStory(5000*5,"\x17���\x04�� �� \x1C��\x04�� �����ϱ� ���ؼ�...")
AxiomStory(5000*6,"\x04�װ͵��� �̰����� ������ \x10�� �� ���� ��\x04�� �Ȱ��� �ɾ�߸� �Ѵ�.")
AxiomStory(5000*7,"\x04��ŵ��� \x06��\x11��\x04�� �Ѿ� �ٶ󺸰�, �� ����� \x07�Ƹ��ٿ� ���\x04���� ��������.")
AxiomStory(5000*8,"\x04�̰͸��� Ȯ���� ����϶�. \x07Ʋ������ �� ���� Ȧ�� ã�� �� �ִ� ���� �ƴϴ�.")

Trigger2X(FP, {CDeaths(FP,AtLeast,5000*9,StoryT)}, {
    SetCD(StartStoryTelling,0),
    RotatePlayer({
        PlayWAVX("staredit\\wav\\AxiomPreview.wav"),
        PlayWAVX("staredit\\wav\\AxiomPreview.wav"),
        DisplayTextX(string.rep("\n", 20),4),
        DisplayTextX("\x13\x04"..string.rep("��", 56),4),
        DisplayTextX("\x0D\x0D!H\x13\x10��\x04������\x08��\x04�桡\x11��\x04��塡\x1F�ţ��\n\x0D\x0D!H\x13"..AxStrArr[1].."\n\x0D\x0D!H\x13"..AxStrArr[2].."\n\x0D\x0D!H\x13"..AxStrArr[3].."\n\x0D\x0D!H\x13"..AxStrArr[4].."\n\x0D\x0D!H\x13\x04InsertŰ�� ���� �����Ȳ�� Ȯ���� �� �ֽ��ϴ�.",0),
        DisplayTextX("\x13\x04"..string.rep("��", 56),4),
    },HumanPlayers,FP);
})

CIfEnd()

TriggerX(FP,{CD(SpecialEEggCcode,4,AtLeast),CD(Theorist,1,AtLeast),DeathsX(AllPlayers,AtMost,0,12,0xFFFFFF)},{SetCD(StartStoryTelling2,1)})
CIf(FP,{CD(StartStoryTelling2,1)})
CAdd(FP,_Ccode(FP,StoryT2),Dt)
DoActionsX(FP,SetV(BGMType,12),1)
function AxiomStory(T,Text,AddTrig)
Trigger2X(FP, {CDeaths(FP,AtLeast,T,StoryT2)}, {
    RotatePlayer({
        DisplayTextX(string.rep("\n", 20),4),
        DisplayTextX("\x13\x04"..string.rep("��", 56),4),
        DisplayTextX("\x12\n\n\x0D\x0D!H\x13"..Text.."\n\n\n",0),
        DisplayTextX("\x13\x04"..string.rep("��", 56),4),
    },HumanPlayers,FP);
    SetCDeaths(FP,Add,1,ButtonSound);
    AddTrig
})
end

AxiomStory(5000*1,"\x04�̰�����, \x07��� ����\x04�� �����Ͽ���.")
AxiomStory(5000*2,"\x04����� �� �̾߱��� \x1C������\x04�� ���� �Ǹ��� �־�����.")
AxiomStory(5000*3,"\x04���� �ʾҴ°�..? �׷�. \x07�и��� ����� ������ ���� �Ȱ� �־���.")
AxiomStory(5000*4,"\x04���̻��� \x08���\x04�� ���߱� ���� �������� �� ���̴�.")
AxiomStory(5000*5,"\x04���� �� ����, �и��� �ٷ� �տ� �����Ѵ�.")
AxiomStory(5000*6,"\x04��, ���ư���. �׸��� \x06��\x11��\x04�� �ٲپ��! \x07�̾߱��� ���� �����϶�!")

Trigger2X(FP, {CDeaths(FP,AtLeast,5000*7,StoryT2)}, {
    SetCD(StartStoryTelling2,0),
RotatePlayer({
    PlayWAVX("staredit\\wav\\AxiomComp.wav"),
    PlayWAVX("staredit\\wav\\AxiomComp.wav"),
    DisplayTextX(string.rep("\n", 20),4),
    DisplayTextX("\x13\x04"..string.rep("��", 56),4),
    DisplayTextX("\x0D\x0D!H\x13\x10��\x04������\x08��\x04�桡\x11��\x04��塡\x1F�ţ��\n\n\x0D\x0D!H\x13\x07���ã�����硡�ӣ��\n\x0D\x0D!H\x13\x04to Ver. 1.0\n\n\n",0),
    DisplayTextX("\x13\x04"..string.rep("��", 56),4),
},HumanPlayers,FP);
})

CIfEnd()


Trigger2X(FP,{CD(ButtonSound,1,AtLeast)},{
    RotatePlayer({
    PlayWAVX("staredit\\wav\\button3.wav"),
    PlayWAVX("staredit\\wav\\button3.wav"),
    PlayWAVX("staredit\\wav\\button3.wav")
    },HumanPlayers,FP);
    SetCD(ButtonSound,0);
},{preserved})
end