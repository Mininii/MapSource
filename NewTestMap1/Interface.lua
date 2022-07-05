function Interface()
    local CurExpLoc = CreateVar(FP)
    local LVLoc = CreateVar(FP)
    local PtsLoc = CreateVar(FP)
    local MinLoc = CreateVar(FP)
    local GasLoc = CreateVar(FP)
    local KillReadTemp = CreateVar(FP)
    local IncomeT = CreateCcodeArr(7)
    local DiffCheck = CreateVarArr(7, FP)
    local TerranFlagLoc = CreateCcode()
    for i = 0, 6 do
        local p = i+1
        UnitLimit(i,13,50)
        table.insert(CtrigInitArr[8],SetV(MaxEXP[p],18))
        table.insert(CtrigInitArr[8],SetV(Minpsec[p],1700))
        table.insert(CtrigInitArr[8],SetV(Gaspsec[p],800))
        CIf(FP,HumanCheck(i, 1))

		for j=1, 5 do
			CIf(FP,Kills(i,AtLeast,1,ZealotUIDArr[j][1]))
				f_Read(FP, 0x5878A4+(ZealotUIDArr[j][1]*48)+(i*4), KillReadTemp)
				if j~=1 then
					f_Mul(FP,KillReadTemp, 100^(j-1))
				end
				CAdd(FP,CurEXP[p],KillReadTemp)
				DoActions(FP,{SetKills(i, SetTo, 0, ZealotUIDArr[j][1])})
			CIfEnd()
		end


            CIfX(FP,{CV(Level[p],2499,AtMost),TTCWar(FP,DiffCheck[p][2], NotSame, CurEXP[p])})
            CMov(FP,DiffCheck[p],CurEXP[p])
            f_LMul(FP, CurExpTmp[p], {CurEXP[p],0}, "1000")
            f_LMov(FP, CurExpTmp[p], _LDiv(CurExpTmp[p],{MaxEXP[p],0}))
            CElseX({TSetCWar(FP, CurExpTmp[p][2], SetTo, "1000")})
            CIfXEnd()

            CIf(FP,{TCWar(FP, CurExpTmp[p][2], AtLeast, "1000"),CV(Level[p],2499,AtMost)},{TSetCWar(FP, CurExpTmp[p][2], Subtract,"1000")})
                CSub(FP,CurEXP[p],MaxEXP[p])
                if LD2XOption==0 then
                    ConvertArr(FP,ArrI,Level[p])
                    f_Read(FP,ArrX(EXPArr,ArrI),MaxEXP[p],nil,nil,1)
                else
                    f_Read(FP,FArr(EXPArr,Level[p]),MaxEXP[p],nil,nil,1)
                end
                CAdd(FP,Level[p],1)
                CAdd(FP,Pts[p],1)
                CDoActions(FP,{TSetScore(i, SetTo, Level[p], Custom),SetCp(i),PlayWAV("staredit\\wav\\LevelUp.ogg"),SetCp(FP)})
            CIfEnd()
            TriggerX(FP,{CV(Pts[p],1,AtLeast),Deaths(i,AtLeast,1,200)},{AddV(Minpsec[p],65),SubV(Pts[p],1),SetCp(i),PlayWAV("staredit\\wav\\UseStat.ogg"),SetCp(FP)},{preserved})
            TriggerX(FP,{CV(Pts[p],1,AtLeast),Deaths(i,AtLeast,1,201)},{AddV(Gaspsec[p],30),SubV(Pts[p],1),SetCp(i),PlayWAV("staredit\\wav\\UseStat.ogg"),SetCp(FP)},{preserved})
            TriggerX(FP,{CV(Pts[p],50,AtLeast)},{AddV(Minpsec[p],65),AddV(Gaspsec[p],60),SubV(Pts[p],3)},{preserved})
            CIf(FP,LocalPlayerID(i)) -- ���� ������ ����
            f_Cast(FP,{CurExpLoc,0},CurExpTmp[p])
            CMov(FP,LVLoc,Level[p])
            CMov(FP,PtsLoc,Pts[p])
            CMov(FP,MinLoc,Minpsec[p])
            CMov(FP,GasLoc,Gaspsec[p])
            TriggerX(FP,{Deaths(i,AtLeast,1,210)},{SetCD(TerranFlagLoc,1)},{preserved})
            CIfEnd()
            DoActionsX(FP,{AddCD(IncomeT[p],1)})
            CTrigger(FP, {CD(IncomeT[p],24,AtLeast)},{TSetResources(i,Add,Minpsec[p],Ore),TSetResources(i,Add,Gaspsec[p],Gas),SubCD(IncomeT[p],24)},1)
            TriggerX(FP,{Deaths(i,AtLeast,1,202)},{SetCp(i),RunAIScriptAt("Enter Transport", 64),SetCp(FP)},{preserved})
        CIfEnd()
    end


    
function TEST() 
    local PlayerID = CAPrintPlayerID 
    --local Data = {{{0,9},{"��",{0x1000000}}}} 
    CA__SetValue(Str1,"12\x04,123\x04,123\x04,123\x04,123\x04,123\x04,123 \x05Kills",nil,1)
    CA__lItoCustom(SVA1(Str1,0),KillW,nil,nil,10,1,nil,{"\x1F\x0D","\x08\x0D","\x040"},{0x04,0x04,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x02,0x02,0x2,0x1E,0x1E,0x1E,0x05,0x05,0x05}
    ,{0,1,3,4,5,7,8,9,11,12,13,15,16,17,19,20,21,23,24,25},nil,{0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0}})
    CA__InputVA(56*0,Str1,Str1s,nil,56*0,56*1-3)
    CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
    CIfX(FP,LocalPlayerID())
    CA__SetValue(Str1,"\x1FLevel. \x04"..string.rep("\x0D",6).." (00.0%) || \x07Points : \x04"..string.rep("\x0D",6),nil,1)
    CA__ItoCustom(SVA1(Str1,8), LVLoc, nil, nil, {10,4}, 1, "\x0D", {"\x0D","\x0D","\x040"}, 0x04)
    --CA__ItoCustom(SVA1(Str1,15), CurExpLoc, nil, nil, {10,3},1, nil, nil, 0x04,{0,1,3})
    CA__ItoCustom(SVA1(Str1,16),CurExpLoc,nil,nil,{10,3},1,"\x040",nil,{0x04,0x04,0x04},{0,1,3}) 
    CA__ItoCustom(SVA1(Str1,35), PtsLoc, nil, nil, {10,4}, 1, "\x0D", {"\x0D","\x0D","\x040"}, 0x04)
    CA__InputVA(56*1,Str1,Str1s,nil,56*1,56*2-3)
    CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 

    CA__SetValue(Str1,"\x17[Q \x04Key\x17] \x1FMineral \x04+ "..string.rep("\x0D",11).." / Sec ",nil,1)
    CA__ItoCustom(SVA1(Str1,18), MinLoc, nil, nil, 10, 1, "\x0D", {"\x0D","\x0D","\x040"}, 0x04)
    CA__InputVA(56*2,Str1,Str1s,nil,56*2,56*3-3)
    CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 

    CA__SetValue(Str1,"\x17[E \x04Key\x17] \x07Gas \x04+ "..string.rep("\x0D",11).." / Sec",nil,1)
    CA__ItoCustom(SVA1(Str1,14), GasLoc, nil, nil, 10, 1, "\x0D", {"\x0D","\x0D","\x040"}, 0x04)
    CA__InputVA(56*3,Str1,Str1s,nil,56*3,56*4-4)
    CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
    CIfX(FP,{CD(TerranFlagLoc,1)})
    CIfX(FP,{CD(BGMOnOff,1)})
    CA__SetValue(Str1,"\x17[Delete \x04Key\x17] \x07BGM \x08Off \x04|| \x17[F12 \x04Key\x17] \x07Enter \x04Terran Bunker",nil,1)
    CA__InputVA(56*4,Str1,Str1s,nil,56*4,56*5-4)
    CElseX()
    CA__SetValue(Str1,"\x17[Delete \x04Key\x17] \x07BGM \x07On \x04|| \x17[F12 \x04Key\x17] \x07Enter \x04Terran Bunker",nil,1)
    CA__InputVA(56*4,Str1,Str1s,nil,56*4,56*5-4)
    CIfXEnd()
    CElseX()
    CIfX(FP,{CD(BGMOnOff,1)})
    CA__SetValue(Str1,"\x17[Delete \x04Key\x17] \x07BGM \x08Off",nil,1)
    CA__InputVA(56*4,Str1,Str1s,nil,56*4,56*5-4)
    CElseX()
    CA__SetValue(Str1,"\x17[Delete \x04Key\x17] \x07BGM \x07On",nil,1)
    CA__InputVA(56*4,Str1,Str1s,nil,56*4,56*5-4)
    CIfXEnd()
    CIfXEnd()
    CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
    CElseX()
    CIfXEnd()
    
    function CS__InputTA(Player,Condition,SVA1,Value,Mask,Flag)
        if Flag == nil then Flag = {preserved} elseif Flag == 1 then Flag = {} end
        TriggerX(Player,Condition,{SetCSVA1(SVA1,SetTo,Value,Mask)},Flag)
    end
    
    
    end 
    CAPrint(iStr1,{Force1,Force2,Force5},{1,0,0,0,1,3,0,0},"TEST",FP,{}) 

    
end