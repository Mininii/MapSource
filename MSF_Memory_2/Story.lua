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
                DisplayTextX("\x13\x04"..string.rep("―", 56),4),
                DisplayTextX("\x12\n\n\x0D\x0D!H\x13"..Text.."\n\n\n",0),
                DisplayTextX("\x13\x04"..string.rep("―", 56),4),
            },HumanPlayers,FP);
            SetCDeaths(FP,Add,1,ButtonSound);
            AddTrig
        },
    }
end

AxiomStory(5000*2,"\x04그 어떤 \x10고난 \x04그 이상의 것이 기다린다.")
AxiomStory(5000*3,"\x04모든 \x07도전\x04을 \x0F능가\x04하고, 모든 \x11변칙\x04을 \x1D초과\x04하는 것.")
AxiomStory(5000*4,"\x07빛\x04과 \x10대립\x04의 \x1F기억\x04들을 겪은 일들과... \x08곧 견뎌낼 일들...")
AxiomStory(5000*5,"\x17당신\x04은 그 \x1C끝\x04을 도달하기 위해서...")
AxiomStory(5000*6,"\x04그것들을 이곳까지 데려온 \x10알 수 없는 길\x04을 똑같이 걸어야만 한다.")
AxiomStory(5000*7,"\x04당신들의 \x06운\x11명\x04을 넘어 바라보고, 이 기억의 \x07최후의 비밀\x04들을 밝혀내라.")
AxiomStory(5000*8,"\x04이것만은 확실히 기억하라. \x07틀림없이 이 길은 홀로 찾을 수 있는 것이 아니다.")
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