function InputStory()
    local StartStoryTelling = CreateCcode()
    local StoryT = CreateCcode()
    TriggerX(FP,{CD(OPJump,1),DeathsX(AllPlayers,AtMost,0,12,0xFFFFFF)},{SetCD(StartStoryTelling,1)})
    CIf(FP,{CD(StartStoryTelling,1)})
    CAdd(FP,_Ccode(FP,StoryT),Dt)
--    DoActionsX(FP,SetV(BGMType,2),1)
--function StoryPrint(Talker,T,Text,AddTrig)
--    Trigger {
--        players = {FP},
--        conditions = {
--            Label(0);
--            CDeaths(FP,AtLeast,T,StoryT)
--        },
--        actions = {
--            RotatePlayer({
--                DisplayTextX(string.rep("\n", 20),4),
--                DisplayTextX("\x13\x04"..string.rep("��", 56),4),
--                DisplayTextX("\x12\n\n\n\x13"..Talker.."\n\x13"..Text.."\n\n\n\n",0),
--                DisplayTextX("\x13\x04"..string.rep("��", 56),4),
--            },HumanPlayers,FP);
--            SetCDeaths(FP,Add,1,ButtonSound);
--            AddTrig
--        },
--    }
--end
--    TalkerA = "\x02��"..StrDesign("\x04��").."\x02��"
--    
--    StoryPrint(TalkerA,5000*2,"\x04�ٽ� ��������.. \x1F�� �ٸ� ��.")
--    StoryPrint(TalkerA,5000*3,"\x04�ʵ� ���Ҵ� ���� �� ��� ���� ���� \x10������ ���\x04���� ���� �� �־�..")
--    StoryPrint(TalkerA,5000*4,"\x04�̴�� ���ٰ� �� ��� ���� ���� "..StrDesign("\x11D\x04emise").." \x04�� ������ �ž�.")
--    StoryPrint(TalkerA,5000*5,"\x04�ٽ� �̷� \x08���\x04�� �Ͼ���� �ȵ�!")
--    StoryPrint(TalkerA,5000*6,"\x04���� \x0F��\x04�� \x0F��\x04�� "..StrDesign("\x0FL\x04uminous \x0FS\x04kies\x10").." \x04�� ��Ű�� �����״�")
--    StoryPrint(TalkerA,5000*7,"\x04������� �� ����� ��ȭ�� �־����� ���ھ�.")
--    StoryPrint(TalkerA,5000*8,"\x04�׷�, ������ ����!")
CIfEnd()


TriggerX(FP,{CD(ButtonSound,1,AtLeast)},{
    RotatePlayer({
    PlayWAVX("staredit\\wav\\button3.wav"),
    PlayWAVX("staredit\\wav\\button3.wav"),
    PlayWAVX("staredit\\wav\\button3.wav")
    },HumanPlayers,FP);
    SetCD(ButtonSound,0);
},{preserved})
end