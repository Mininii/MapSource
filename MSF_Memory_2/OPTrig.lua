function Opening()
    local OPCCode = CreateCcode()
    
    CIf(FP,{CD(OPJump,0,AtMost)})
    CDoActions(FP,{AddCD(OPCCode,Dt)})
    DoActionsX(FP,{SetV(BGMType,1)},1)
	for i=1, 57 do
        Trigger2X(FP,{CDeaths(FP,AtLeast,i*15,OPCCode);},{RotatePlayer(
			{DisplayTextX(string.rep("\n", 20),4);
			DisplayTextX("\n",4);
			DisplayTextX("\x13\x04"..string.rep("―", i),4);
			DisplayTextX("\n\n",4);
			DisplayTextX("\x13\x04"..string.rep("―", i),4);
			DisplayTextX("\n\n",4);
        },HumanPlayers,FP)})
end
Trigger2X(FP,{CDeaths(FP,AtLeast,956,OPCCode);},{RotatePlayer(
    {DisplayTextX(string.rep("\n", 20),4);
    DisplayTextX("\n",4);
    DisplayTextX("\x13\x04"..string.rep("―", 57),4);
    DisplayTextX("\x13\x06== \x04마린키우기 \x07Ｍｅｍｏｒｙ_２ \x06==\n\n\x13\x02"..VerText.."\n\n\x13\x1FCtrig \x04Assembler \x07v5.3\x04, \x1FCA \x16Paint \x07v2.3 \x04in Used \x19(つ>ㅅ<)つ",4);
    DisplayTextX("\x13\x04"..string.rep("―", 57),4);
    DisplayTextX("\x13\x03\n",4);},HumanPlayers,FP)})
Trigger2X(FP,{CDeaths(FP,AtLeast,3100,OPCCode);},{RotatePlayer(
    {DisplayTextX(string.rep("\n", 20),4);
    DisplayTextX("\n",4);
    DisplayTextX("\x13\x04"..string.rep("―", 57),4);
    DisplayTextX("\x13\x06== \x04마린키우기 \x07Ｍｅｍｏｒｙ_２ \x06==\n\x13\x05＝\x04The Wonderful Abstractions of a Lost Memory\x07＝\n\x13\x02"..VerText.."\n\n\x13\x1FCtrig \x04Assembler \x07v5.3\x04, \x1FCA \x16Paint \x07v2.3 \x04in Used \x19(つ>ㅅ<)つ",4);
    DisplayTextX("\x13\x04"..string.rep("―", 57),4);
    DisplayTextX("\x13\x03\n",4);},HumanPlayers,FP)})
Trigger2X(FP,{CDeaths(FP,AtLeast,3378,OPCCode);},{RotatePlayer(
    {DisplayTextX(string.rep("\n", 20),4);
    DisplayTextX("\n",4);
    DisplayTextX("\x13\x04"..string.rep("―", 57),4);
    DisplayTextX("\x13\x06== \x04마린키우기 \x07Ｍｅｍｏｒｙ_２ \x06==\n\x13\x07＝\x04The Wonderful Abstractions of a Lost Memory\x07＝\n\x13\x02"..VerText.."\n\n\x13\x1FCtrig \x04Assembler \x07v5.3\x04, \x1FCA \x16Paint \x07v2.3 \x04in Used \x19(つ>ㅅ<)つ",4);
    DisplayTextX("\x13\x04"..string.rep("―", 57),4);
    DisplayTextX("\x13\x03\n",4);},HumanPlayers,FP)})
Trigger2X(FP,{CDeaths(FP,AtLeast,4200,OPCCode);},{RotatePlayer(
    {DisplayTextX(string.rep("\n", 20),4);
    DisplayTextX("\n",4);
    DisplayTextX("\x13\x04"..string.rep("―", 57),4);
    DisplayTextX("\x13\x06== \x04마린키우기 \x07Ｍｅｍｏｒｙ_２ \x06==\n\x13\x07＝\x04The Wonderful Abstractions of a Lost Memory\x07＝\n\x13\x02"..VerText.."\n\n\x13\x1FCtrig \x04Assembler \x07v5.3\x04, \x1FCA \x16Paint \x07v2.3 \x04in Used \x19(つ>ㅅ<)つ",4);
    DisplayTextX("\x13\x04"..string.rep("―", 57),4);
    DisplayTextX("\x13\x03Made \x06by \x04GALAXY_BURST\n",4);},HumanPlayers,FP)})
for i = 1, 3 do
Trigger2X(FP,{CDeaths(FP,AtLeast,5900+(i*1000),OPCCode);},{RotatePlayer(
    {DisplayTextX(string.rep("\n", 20),4);
    DisplayTextX("\n",4);
    DisplayTextX("\x13\x04"..string.rep("―", 57),4);
    DisplayTextX("\x13\x06== \x04마린키우기 \x07Ｍｅｍｏｒｙ_２ \x06==\n\x13\x07＝\x04The Wonderful Abstractions of a Lost Memory\x07＝\n\x13\x02"..VerText.."\n\x13\x04"..(4-i).."초 남았습니다.\n\x13\x1FCtrig \x04Assembler \x07v5.3\x04, \x1FCA \x16Paint \x07v2.3 \x04in Used \x19(つ>ㅅ<)つ",4);
    DisplayTextX("\x13\x04"..string.rep("―", 57),4);
    DisplayTextX("\x13\x03Made \x06by \x04GALAXY_BURST\n",4);
    PlayWAVX("sound\\glue\\countdown.wav")
},HumanPlayers,FP)})
end
Trigger2X(FP,{CDeaths(FP,AtLeast,5900+(4*1000),OPCCode);},{RotatePlayer(
    {DisplayTextX(string.rep("\n", 20),4);
    DisplayTextX("\n",4);
    DisplayTextX("\x13\x04"..string.rep("―", 57),4);
    DisplayTextX("\x13\x06\n\n\x13\x02\n\x13\x04Ｓ　Ｔ　Ａ　Ｒ　Ｔ\n\x13\x1F",4);
    DisplayTextX("\x13\x04"..string.rep("―", 57),4);
    DisplayTextX("\x13\x04\n",4);
    PlayWAVX("sound\\Bullet\\pshield.wav");
},HumanPlayers,FP),SetCD(OPJump,1),SetMemory(0x657A9C,SetTo,31),SetSwitch("Switch 253",Clear)})
CIfEnd()
CIfOnce(FP,CD(OPJump,1))



if Limit == 1 then
    TriggerX(FP,{CD(TestMode,1)},{SetCD(OPCCode,5900+(4*1000))})


	TriggerX(FP,{CD(TestMode,1)},{RotatePlayer({RunAIScript(P8VON),RunAIScript(P7VON),RunAIScript(P6VON),RunAIScript(P5VON)},MapPlayers,FP)})
	for i = 0, 3 do
	TriggerX(FP,{CD(TestMode,1),PlayerCheck(i)},{CreateUnit(12,MarID[i+1],i+2,i)})
	TriggerX(FP,{PlayerCheck(i)},{CreateUnit(3,MarID[i+1],i+2,i)})
	end
else
	TriggerX(FP,{},{RotatePlayer({RunAIScript(P8VOFF),RunAIScript(P7VOFF),RunAIScript(P6VOFF),RunAIScript(P5VOFF)},MapPlayers,FP)})
	for i = 0, 3 do
	TriggerX(FP,{PlayerCheck(i)},{CreateUnit(3,MarID[i+1],i+2,i)})
	end
end
for i = 0, 3 do
	TriggerX(FP,{PlayerCheck(i)},{GiveUnits(All,"Buildings",P12,i+2,i),SetCp(i),CenterView(i+2),SetCp(FP)})
end
DoActions(FP,{RemoveUnit(111,P12),RemoveUnit(107,P12)})

CIfEnd()
end