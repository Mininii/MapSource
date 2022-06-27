function Interface()
    local CurExpLoc = CreateVar(FP)
    local LVLoc = CreateVar(FP)
    local PtsLoc = CreateVar(FP)
    local MinLoc = CreateVar(FP)
    local GasLoc = CreateVar(FP)
    local KillReadTemp = CreateVar(FP)
    for i = 0, 6 do
        local p = i+1
        table.insert(CtrigInitArr[8],SetV(MaxEXP[p],18))
        table.insert(CtrigInitArr[8],SetV(Minpsec[p],3000))
        table.insert(CtrigInitArr[8],SetV(Gaspsec[p],1500))
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


            CIfX(FP,{CV(Level[p],2499,AtMost)})
            f_Mul(FP,CurExpTmp[p],CurEXP[p],1000)
            f_Div(FP,CurExpTmp[p],MaxEXP[p])
            CElseX({SetV(CurExpTmp[p],1000)})
            CIfXEnd()


            CIf(FP,{CV(CurExpTmp[p],1000,AtLeast),CV(Level[p],2499,AtMost)},{SubV(CurExpTmp[p],1000)})
                CSub(FP,CurEXP[p],MaxEXP[p])
                ConvertArr(FP,ArrI,Level[p])
                f_Read(FP,ArrX(EXPArr,ArrI),MaxEXP[p],nil,nil,1)
                CAdd(FP,Level[p],1)
                CAdd(FP,Pts[p],1)
            CIfEnd()
            TriggerX(FP,{CV(Pts[p],1,AtLeast),Deaths(i,AtLeast,1,200)},{AddV(Minpsec[p],100),SubV(Pts[p],1)},{preserved})
            TriggerX(FP,{CV(Pts[p],1,AtLeast),Deaths(i,AtLeast,1,201)},{AddV(Gaspsec[p],50),SubV(Pts[p],1)},{preserved})
            TriggerX(FP,{CV(Pts[p],50,AtLeast)},{AddV(Minpsec[p],100),AddV(Gaspsec[p],50),SubV(Pts[p],2)},{preserved})
            CIf(FP,LocalPlayerID(i)) -- 로컬 데이터 전송
            CMov(FP,CurExpLoc,CurExpTmp[p])
            CMov(FP,LVLoc,Level[p])
            CMov(FP,PtsLoc,Pts[p])
            CMov(FP,MinLoc,Minpsec[p])
            CMov(FP,GasLoc,Gaspsec[p])
            CIfEnd()

        CIfEnd()
    end


    
function TEST() 
    local PlayerID = CAPrintPlayerID 
    --local Data = {{{0,9},{"０",{0x1000000}}}} 
    CA__SetValue(Str1,"12\x04,123\x04,123\x04,123\x04,123\x04,123\x04,123 \x04Kills",nil,1)
    CA__lItoCustom(SVA1(Str1,0),KillW,nil,nil,10,1,nil,{"\x1F\x0D","\x08\x0D","\x040"},{0x04,0x04,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x02,0x02,0x2,0x1E,0x1E,0x1E,0x05,0x05,0x05}
    ,{0,1,3,4,5,7,8,9,11,12,13,15,16,17,19,20,21,23,24,25},nil,{0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0}})
    CA__InputVA(56*0,Str1,Str1s,nil,56*0,56*1-3)
    CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
    CIf(FP,LocalPlayerID())
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
    CIfEnd()
    
    
    function CS__InputTA(Player,Condition,SVA1,Value,Mask,Flag)
        if Flag == nil then Flag = {preserved} elseif Flag == 1 then Flag = {} end
        TriggerX(Player,Condition,{SetCSVA1(SVA1,SetTo,Value,Mask)},Flag)
    end
    
    
    end 
    CAPrint(iStr1,{Force1,Force2,Force5},{1,0,0,0,1,3,0,0},"TEST",FP,{}) 

    
end