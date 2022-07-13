function InputStory()
    local StartStoryTelling = CreateCcode()
    local StoryT = CreateCcode()
    TriggerX(FP,{CD(OPJump,1),DeathsX(AllPlayers,AtMost,0,12,0xFFFFFF)},{SetCD(StartStoryTelling,1)})
    CIf(FP,{CD(StartStoryTelling,1)})
    CAdd(FP,_Ccode(FP,StoryT),Dt)
    DoActionsX(FP,SetV(BGMType,11),1)
function AxiomStory(T,Text,AddTrig)
    Trigger {
        players = {FP},
        conditions = {
            Label(0);
            CDeaths(FP,AtLeast,T,StoryT)
        },
        actions = {
            RotatePlayer({
                DisplayTextX(string.rep("\n", 20),4),
                DisplayTextX("\x13\x04"..string.rep("��", 56),4),
                DisplayTextX("\x12\n\n\x0D\x0D!H\x13"..Text.."\n\n\n",0),
                DisplayTextX("\x13\x04"..string.rep("��", 56),4),
            },HumanPlayers,FP);
            SetCDeaths(FP,Add,1,ButtonSound);
            AddTrig
        },
    }
end

AxiomStory(5000*2,"\x04�� � \x10�� \x04�� �̻��� ���� ��ٸ���.")
AxiomStory(5000*3,"\x04��� \x07����\x04�� \x0F�ɰ�\x04�ϰ�, ��� \x11��Ģ\x04�� \x1D�ʰ�\x04�ϴ� ��.")
AxiomStory(5000*4,"\x07��\x04�� \x10�븳\x04�� \x1F���\x04���� ���� �ϵ��... \x08�� �ߵ��� �ϵ�...")
AxiomStory(5000*5,"\x17���\x04�� �� \x1C��\x04�� �����ϱ� ���ؼ�...")
AxiomStory(5000*6,"\x04�װ͵��� �̰����� ������ \x10�� �� ���� ��\x04�� �Ȱ��� �ɾ�߸� �Ѵ�.")
AxiomStory(5000*7,"\x04��ŵ��� \x06��\x11��\x04�� �Ѿ� �ٶ󺸰�, �� ����� \x07������ ���\x04���� ��������.")
AxiomStory(5000*8,"\x04�̰͸��� Ȯ���� ����϶�. \x07Ʋ������ �� ���� Ȧ�� ã�� �� �ִ� ���� �ƴϴ�.")
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