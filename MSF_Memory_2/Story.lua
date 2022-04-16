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
--                DisplayTextX("\x13\x04"..string.rep("―", 56),4),
--                DisplayTextX("\x12\n\n\n\x13"..Talker.."\n\x13"..Text.."\n\n\n\n",0),
--                DisplayTextX("\x13\x04"..string.rep("―", 56),4),
--            },HumanPlayers,FP);
--            SetCDeaths(FP,Add,1,ButtonSound);
--            AddTrig
--        },
--    }
--end
--    TalkerA = "\x02†"..StrDesign("\x04光").."\x02†"
--    
--    StoryPrint(TalkerA,5000*2,"\x04다시 만났구나.. \x1F또 다른 나.")
--    StoryPrint(TalkerA,5000*3,"\x04너도 보았다 싶이 이 기억 또한 많은 \x10부정의 기억\x04으로 가득 차 있어..")
--    StoryPrint(TalkerA,5000*4,"\x04이대로 가다간 이 기억 또한 종말 "..StrDesign("\x11D\x04emise").." \x04을 맞이할 거야.")
--    StoryPrint(TalkerA,5000*5,"\x04다시 이런 \x08비극\x04이 일어나서는 안돼!")
--    StoryPrint(TalkerA,5000*6,"\x04내가 \x0F빛\x04의 \x0F하\x04늘 "..StrDesign("\x0FL\x04uminous \x0FS\x04kies\x10").." \x04을 지키고 있을테니")
--    StoryPrint(TalkerA,5000*7,"\x04너희들은 이 기억을 정화해 주었으면 좋겠어.")
--    StoryPrint(TalkerA,5000*8,"\x04그럼, 건투를 빌게!")
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