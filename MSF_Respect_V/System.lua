﻿function System()
    count = CreateVar(FP)
    f_Read(FP, 0x6283F0, count)

    
	EXCC_Part1(DUnitCalc) -- 죽은유닛 인식 단락 시작
    EXCC_ClearCalc()
        EXCC_Part2()
        EXCC_Part3X()
        for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
            EXCC_Part4X(i,{
            DeathsX(19025+(84*i)+40,AtLeast,1*16777216,0,0xFF000000),
            DeathsX(19025+(84*i)+19,Exactly,0*256,0,0xFF00),
            },
            {SetDeathsX(19025+(84*i)+40,SetTo,0*16777216,0,0xFF000000),
            --SetDeathsX(19025+(84*i)+9,SetTo,0*65536,0,0xFF0000),
            SetDeathsX(19025+(84*i)+35,SetTo,0,0,0xFF); -- 
            MoveCp(Add,19*4),
            SetCVar(FP,CurCunitI2[2],SetTo,i)
            })
        end
        EXCC_End()
    


    
	Create_G_CA_Arr()

    if TestStart == 1 then-- BarTextTest
		
function ToggleFunc(CondArr,Mode,EnterFlag)
	local KeyToggle = CreateCcode()
	local KeyToggle2 = CreateCcode()
	local NotTypingCond = nil
	if EnterFlag ~= nil then
		NotTypingCond = Memory(0x68C144,Exactly,0)
	end
	
	if Mode ~= nil then
		DoActionsX(FP,{SetCD(KeyToggle,0)})
		TriggerX(FP, {NotTypingCond,CondArr[1],CD(KeyToggle2,1)}, {SetCD(KeyToggle2,0),SetCD(KeyToggle,1)}, {preserved})
		TriggerX(FP, {NotTypingCond,CondArr[2]}, {SetCD(KeyToggle2,1)}, {preserved})
	else
		DoActionsX(FP,{SetCD(KeyToggle,0)})
		TriggerX(FP, {NotTypingCond,CondArr[2],CD(KeyToggle2,0)}, {SetCD(KeyToggle2,1),SetCD(KeyToggle,1)}, {preserved})
		TriggerX(FP, {NotTypingCond,CondArr[1]}, {SetCD(KeyToggle2,0)}, {preserved})
	end

	return KeyToggle2,KeyToggle
end
        
        testc = CreateCcode()
        testc2 = CreateCcode()
        testc3 = CreateCcode()
		temp,QKey = ToggleFunc({KeyPress("Q","Up"),KeyPress("Q","Down")},nil,1)--누를 경우 설명서 출력
		temp,WKey = ToggleFunc({KeyPress("W","Up"),KeyPress("W","Down")},nil,1)--누를 경우 설명서 출력
		temp,AKey = ToggleFunc({KeyPress("A","Up"),KeyPress("A","Down")},nil,1)--누를 경우 설명서 출력
		temp,SKey = ToggleFunc({KeyPress("S","Up"),KeyPress("S","Down")},nil,1)--누를 경우 설명서 출력
		temp,ZKey = ToggleFunc({KeyPress("Z","Up"),KeyPress("Z","Down")},nil,1)--누를 경우 설명서 출력
		temp,XKey = ToggleFunc({KeyPress("X","Up"),KeyPress("X","Down")},nil,1)--누를 경우 설명서 출력
        TriggerX(FP,{CD(QKey,1)},{SubCD(testc,1)},{preserved})
        TriggerX(FP,{CD(WKey,1)},{AddCD(testc,1)},{preserved})
        TriggerX(FP,{CD(AKey,1)},{SubCD(testc2,1)},{preserved})
        TriggerX(FP,{CD(SKey,1)},{AddCD(testc2,1)},{preserved})
        TriggerX(FP,{CD(ZKey,1)},{SubCD(testc3,1)},{preserved})
        TriggerX(FP,{CD(XKey,1)},{AddCD(testc3,1)},{preserved})


        TestJ = def_sIndex()
        CJump(FP, TestJ)
	    TempiS1, TempiS1a, TempiS1s = SaveiStrArrX(FP,"\x0D\x0D\x0D\x0D\x0D\x0D")
	    TempiS2, TempiS1a, TempiS2s = SaveiStrArrX(FP,"\x0D\x0D\x0D\x0D\x0D\x0D")
		--일반타입 그림자 \x15 표면 \x1B
        --방어무시 그림자 \x1C 표면 \x1F
        --스택타입 그림자 \x18 표면 \x07
        --위험타입 그림자 \x06 표면 \x08

		
		--str22 = "\x08。+.˚Heart of Witch\x12\x10H\x04eart \x10o\x04f \x10W\x04itch\x10。+.˚"
		str22 = "\x06。˙+˚Don't Die。+.˚\x12\x1B。˙+˚D\x04on't \x1BD\x04ie\x1B。+.˚"
		--str33 = "\x08。+.˚Heart of Witch\x12\x10H\x04eart \x10o\x04f \x10W\x04itch\x10。+.˚"
		str33 = "\t\x1C。˙+˚Archon。+.˚\x12\x1F。˙+˚A\x04rchon\x1F。+.˚"
		--str44 = "\x08。+.˚Heart of Witch\x12\x10H\x04eart \x10o\x04f \x10W\x04itch\x10。+.˚"
		str44 = "\t\x1C。˙+˚Raszagal。+.˚\x12\x1F。˙+˚R\x04aszagal\x1F。+.˚"					           
		--str55 = "\x08。+.˚Heart of Witch\x12\x10H\x04eart \x10o\x04f \x10W\x04itch\x10。+.˚"
		str55 = "\t\x15。˙+˚Hyperion。+.˚\x12\x1B。˙+˚H\x04yperion\x1B。+.˚"
 

		str = str22.."\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"
	
        S6 = MakeiTblString(1480,"None",'None',str,"Base",1)
		Str2, Str2a, Str2s = SaveiStrArrX(FP,str)
        BarTblptr = GetiTblId(FP,112,S6)
        CJumpEnd(FP, TestJ)
		
        for i = 0, 19 do
		CIf(FP,CD(testc2,i),{SetCp(0),DisplayText("bar space:"..i, 4),SetCp(FP)})
		CS__SetValue(FP,Str2,str22.."\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"..string.rep(" ", i)..string.rep("\x0D",19-i),nil,0,nil,1) 
		CIfEnd()
		end
        for i = 0, 19 do
            CIf(FP,CD(testc,i),{SetCp(0),DisplayText("bar tab:"..i, 4),SetCp(FP)})
			CS__SetValue(FP,Str2,str22..string.rep("	", i)..string.rep("\x0D",19-i),nil,0,nil,1) 
            CIfEnd()
        end
		CS__InputVA(FP,BarTblptr,0,Str2,Str2s,nil,0,Str2s)


        
        testc = CreateCcode()
        testc2 = CreateCcode()
        testc3 = CreateCcode()
		temp,QKey = ToggleFunc({KeyPress("E","Up"),KeyPress("E","Down")},nil,1)--누를 경우 설명서 출력
		temp,WKey = ToggleFunc({KeyPress("R","Up"),KeyPress("R","Down")},nil,1)--누를 경우 설명서 출력
		temp,AKey = ToggleFunc({KeyPress("D","Up"),KeyPress("D","Down")},nil,1)--누를 경우 설명서 출력
		temp,SKey = ToggleFunc({KeyPress("F","Up"),KeyPress("F","Down")},nil,1)--누를 경우 설명서 출력
		temp,ZKey = ToggleFunc({KeyPress("C","Up"),KeyPress("C","Down")},nil,1)--누를 경우 설명서 출력
		temp,XKey = ToggleFunc({KeyPress("V","Up"),KeyPress("V","Down")},nil,1)--누를 경우 설명서 출력
        TriggerX(FP,{CD(QKey,1)},{SubCD(testc,1)},{preserved})
        TriggerX(FP,{CD(WKey,1)},{AddCD(testc,1)},{preserved})
        TriggerX(FP,{CD(AKey,1)},{SubCD(testc2,1)},{preserved})
        TriggerX(FP,{CD(SKey,1)},{AddCD(testc2,1)},{preserved})
        TriggerX(FP,{CD(ZKey,1)},{SubCD(testc3,1)},{preserved})
        TriggerX(FP,{CD(XKey,1)},{AddCD(testc3,1)},{preserved})


        TestJ = def_sIndex()
        CJump(FP, TestJ)
	    TempiS1, TempiS1a, TempiS1s = SaveiStrArrX(FP,"\x0D\x0D\x0D\x0D\x0D\x0D")
	    TempiS2, TempiS1a, TempiS2s = SaveiStrArrX(FP,"\x0D\x0D\x0D\x0D\x0D\x0D")
		
		str = str33.."\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"
	
        S6 = MakeiTblString(1480,"None",'None',str,"Base",1)
		Str2, Str2a, Str2s = SaveiStrArrX(FP,str)
        BarTblptr = GetiTblId(FP,219,S6)
        CJumpEnd(FP, TestJ)
		
        for i = 0, 19 do
		CIf(FP,CD(testc2,i),{SetCp(0),DisplayText("Disc space:"..i, 4),SetCp(FP)})
		CS__SetValue(FP,Str2,str33.."\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"..string.rep(" ", i)..string.rep("\x0D",19-i),nil,0,nil,1) 
		CIfEnd()
		end
        for i = 0, 19 do
            CIf(FP,CD(testc,i),{SetCp(0),DisplayText("Disc tab:"..i, 4),SetCp(FP)})
			CS__SetValue(FP,Str2,str33..string.rep("	", i)..string.rep("\x0D",19-i),nil,0,nil,1) 
            CIfEnd()
        end
		CS__InputVA(FP,BarTblptr,0,Str2,Str2s,nil,0,Str2s)

        
        testc = CreateCcode()
        testc2 = CreateCcode()
        testc3 = CreateCcode()
		temp,QKey = ToggleFunc({KeyPress("T","Up"),KeyPress("T","Down")},nil,1)--누를 경우 설명서 출력
		temp,WKey = ToggleFunc({KeyPress("Y","Up"),KeyPress("Y","Down")},nil,1)--누를 경우 설명서 출력
		temp,AKey = ToggleFunc({KeyPress("G","Up"),KeyPress("G","Down")},nil,1)--누를 경우 설명서 출력
		temp,SKey = ToggleFunc({KeyPress("H","Up"),KeyPress("H","Down")},nil,1)--누를 경우 설명서 출력
		temp,ZKey = ToggleFunc({KeyPress("B","Up"),KeyPress("B","Down")},nil,1)--누를 경우 설명서 출력
		temp,XKey = ToggleFunc({KeyPress("N","Up"),KeyPress("N","Down")},nil,1)--누를 경우 설명서 출력
        TriggerX(FP,{CD(QKey,1)},{SubCD(testc,1)},{preserved})
        TriggerX(FP,{CD(WKey,1)},{AddCD(testc,1)},{preserved})
        TriggerX(FP,{CD(AKey,1)},{SubCD(testc2,1)},{preserved})
        TriggerX(FP,{CD(SKey,1)},{AddCD(testc2,1)},{preserved})
        TriggerX(FP,{CD(ZKey,1)},{SubCD(testc3,1)},{preserved})
        TriggerX(FP,{CD(XKey,1)},{AddCD(testc3,1)},{preserved})


        TestJ = def_sIndex()
        CJump(FP, TestJ)
	    TempiS1, TempiS1a, TempiS1s = SaveiStrArrX(FP,"\x0D\x0D\x0D\x0D\x0D\x0D")
	    TempiS2, TempiS1a, TempiS2s = SaveiStrArrX(FP,"\x0D\x0D\x0D\x0D\x0D\x0D")
		
		str = str44.."\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"
	
        S6 = MakeiTblString(1480,"None",'None',str,"Base",1)
		Str2, Str2a, Str2s = SaveiStrArrX(FP,str)
        BarTblptr = GetiTblId(FP,130,S6)
        CJumpEnd(FP, TestJ)
		
        for i = 0, 19 do
		CIf(FP,CD(testc2,i),{SetCp(0),DisplayText("Khalis space:"..i, 4),SetCp(FP)})
		CS__SetValue(FP,Str2,str44.."\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"..string.rep(" ", i)..string.rep("\x0D",19-i),nil,0,nil,1) 
		CIfEnd()
		end
        for i = 0, 19 do
            CIf(FP,CD(testc,i),{SetCp(0),DisplayText("Khalis tab:"..i, 4),SetCp(FP)})
			CS__SetValue(FP,Str2,str44..string.rep("	", i)..string.rep("\x0D",19-i),nil,0,nil,1) 
            CIfEnd()
        end
		CS__InputVA(FP,BarTblptr,0,Str2,Str2s,nil,0,Str2s)


        
        testc = CreateCcode()
        testc2 = CreateCcode()
        testc3 = CreateCcode()
		temp,QKey = ToggleFunc({KeyPress("U","Up"),KeyPress("U","Down")},nil,1)--누를 경우 설명서 출력
		temp,WKey = ToggleFunc({KeyPress("I","Up"),KeyPress("I","Down")},nil,1)--누를 경우 설명서 출력
		temp,AKey = ToggleFunc({KeyPress("J","Up"),KeyPress("J","Down")},nil,1)--누를 경우 설명서 출력
		temp,SKey = ToggleFunc({KeyPress("K","Up"),KeyPress("K","Down")},nil,1)--누를 경우 설명서 출력
		temp,ZKey = ToggleFunc({KeyPress("M","Up"),KeyPress("M","Down")},nil,1)--누를 경우 설명서 출력
		temp,XKey = ToggleFunc({KeyPress(",","Up"),KeyPress(",","Down")},nil,1)--누를 경우 설명서 출력
        TriggerX(FP,{CD(QKey,1)},{SubCD(testc,1)},{preserved})
        TriggerX(FP,{CD(WKey,1)},{AddCD(testc,1)},{preserved})
        TriggerX(FP,{CD(AKey,1)},{SubCD(testc2,1)},{preserved})
        TriggerX(FP,{CD(SKey,1)},{AddCD(testc2,1)},{preserved})
        TriggerX(FP,{CD(ZKey,1)},{SubCD(testc3,1)},{preserved})
        TriggerX(FP,{CD(XKey,1)},{AddCD(testc3,1)},{preserved})


        TestJ = def_sIndex()
        CJump(FP, TestJ)
	    TempiS1, TempiS1a, TempiS1s = SaveiStrArrX(FP,"\x0D\x0D\x0D\x0D\x0D\x0D")
	    TempiS2, TempiS1a, TempiS2s = SaveiStrArrX(FP,"\x0D\x0D\x0D\x0D\x0D\x0D")
		
		str = str55.."\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"
	
        S6 = MakeiTblString(1480,"None",'None',str,"Base",1)
		Str2, Str2a, Str2s = SaveiStrArrX(FP,str)
        BarTblptr = GetiTblId(FP,129,S6)
        CJumpEnd(FP, TestJ)
		
        for i = 0, 19 do
		CIf(FP,CD(testc2,i),{SetCp(0),DisplayText("Uraj space:"..i, 4),SetCp(FP)})
		CS__SetValue(FP,Str2,str55.."\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"..string.rep(" ", i)..string.rep("\x0D",19-i),nil,0,nil,1) 
		CIfEnd()
		end
        for i = 0, 19 do
            CIf(FP,CD(testc,i),{SetCp(0),DisplayText("Uraj tab:"..i, 4),SetCp(FP)})
			CS__SetValue(FP,Str2,str55..string.rep("	", i)..string.rep("\x0D",19-i),nil,0,nil,1) 
            CIfEnd()
        end
		CS__InputVA(FP,BarTblptr,0,Str2,Str2s,nil,0,Str2s)

        




        TriggerX(FP,{},{CreateUnit(1, 84, 64, FP),KillUnit(84, FP)},{preserved})
		
    end
    --219
    --130
    --129
end