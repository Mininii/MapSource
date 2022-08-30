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
            DisplayTextX("\x13\x04"..string.rep("―", 56),4),
            DisplayTextX("\x12\n\n\x0D\x0D!H\x13"..Text.."\n\n\n",0),
            DisplayTextX("\x13\x04"..string.rep("―", 56),4),
        },HumanPlayers,FP);
        SetCDeaths(FP,Add,1,ButtonSound);
        AddTrig
    })
end

AxiomStory(5000*2,"\x04그 어떤 \x10고난 \x04그 이상의 것이 기다린다.")
AxiomStory(5000*3,"\x04모든 \x07도전\x04을 \x0F능가\x04하고, 모든 \x11변칙\x04을 \x1D초과\x04하는 것.")
AxiomStory(5000*4,"\x07빛\x04과 \x10대립\x04의 \x1F기억\x04들을 겪은 일들과... \x08곧 견뎌낼 일들...")
AxiomStory(5000*5,"\x17당신\x04은 그 \x1C끝\x04을 도달하기 위해서...")
AxiomStory(5000*6,"\x04그것들을 이곳까지 데려온 \x10알 수 없는 길\x04을 똑같이 걸어야만 한다.")
AxiomStory(5000*7,"\x04당신들의 \x06운\x11명\x04을 넘어 바라보고, 이 기억의 \x07아름다운 비밀\x04들을 밝혀내라.")
AxiomStory(5000*8,"\x04이것만은 확실히 기억하라. \x07틀림없이 이 길은 홀로 찾을 수 있는 것이 아니다.")

Trigger2X(FP, {CDeaths(FP,AtLeast,5000*9,StoryT)}, {
    SetCD(StartStoryTelling,0),
    RotatePlayer({
        PlayWAVX("staredit\\wav\\AxiomPreview.wav"),
        PlayWAVX("staredit\\wav\\AxiomPreview.wav"),
        DisplayTextX(string.rep("\n", 20),4),
        DisplayTextX("\x13\x04"..string.rep("―", 56),4),
        DisplayTextX("\x0D\x0D!H\x13\x10Ａ\x04ｘｉｏｍ　\x08ｏ\x04ｆ　\x11ｔ\x04ｈｅ　\x1FＥｎｄ\n\x0D\x0D!H\x13"..AxStrArr[1].."\n\x0D\x0D!H\x13"..AxStrArr[2].."\n\x0D\x0D!H\x13"..AxStrArr[3].."\n\x0D\x0D!H\x13"..AxStrArr[4].."\n\x0D\x0D!H\x13\x04Insert키를 눌러 진행상황을 확인할 수 있습니다.",0),
        DisplayTextX("\x13\x04"..string.rep("―", 56),4),
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
        DisplayTextX("\x13\x04"..string.rep("―", 56),4),
        DisplayTextX("\x12\n\n\x0D\x0D!H\x13"..Text.."\n\n\n",0),
        DisplayTextX("\x13\x04"..string.rep("―", 56),4),
    },HumanPlayers,FP);
    SetCDeaths(FP,Add,1,ButtonSound);
    AddTrig
})
end

AxiomStory(5000*1,"\x04이것으로, \x07모든 조건\x04을 만족하였다.")
AxiomStory(5000*2,"\x04당신은 이 이야기의 \x1C종지부\x04를 찍을 권리가 주어졌다.")
AxiomStory(5000*3,"\x04잊지 않았는가..? 그래. \x07분명히 당신은 망각의 길을 걷고 있었다.")
AxiomStory(5000*4,"\x04더이상의 \x08비극\x04을 멈추기 위해 움직여야 할 것이다.")
AxiomStory(5000*5,"\x04이제 그 끝은, 분명히 바로 앞에 존재한다.")
AxiomStory(5000*6,"\x04자, 나아가라. 그리고 \x06운\x11명\x04을 바꾸어라! \x07이야기의 끝을 맞이하라!")

Trigger2X(FP, {CDeaths(FP,AtLeast,5000*7,StoryT2)}, {
    SetCD(StartStoryTelling2,0),
RotatePlayer({
    PlayWAVX("staredit\\wav\\AxiomComp.wav"),
    PlayWAVX("staredit\\wav\\AxiomComp.wav"),
    DisplayTextX(string.rep("\n", 20),4),
    DisplayTextX("\x13\x04"..string.rep("―", 56),4),
    DisplayTextX("\x0D\x0D!H\x13\x10Ａ\x04ｘｉｏｍ　\x08ｏ\x04ｆ　\x11ｔ\x04ｈｅ　\x1FＥｎｄ\n\n\x0D\x0D!H\x13\x07～Ｃｏｍｍｉｎｇ　Ｓｏｏｎ～\n\x0D\x0D!H\x13\x04to Ver. 1.0\n\n\n",0),
    DisplayTextX("\x13\x04"..string.rep("―", 56),4),
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