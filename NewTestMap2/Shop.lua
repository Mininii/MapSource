function Shop()
	local SellTicket = iv.SellTicket
	local MulOp = iv.MulOp--CreateVarArr2(7,1,FP) -- 유닛 공격력에 따른 수치 표기용 변수
	local Credit = iv.Credit--CreateWarArr(7,FP) -- 보유중인 크레딧
	local CreditAddSC = iv.CreditAddSC
	local LCP = iv.LCP--CreateVar(FP)
	local GeneralPlayTime= iv.GeneralPlayTime
	local VaccItem = iv.VaccItem
    
SpeedV = CreateVar(FP)
CIf(FP,{Bring(AllPlayers, AtLeast, 1, 15, 112)})
	for i= 0, 6 do
		--CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,113)},{MoveUnit(1, 15, i, 113, 116)})
		--	CIfX(FP,{CV(SpeedV,0),TTNWar(Credit[i+1], AtLeast, "500")},{SetMemory(0x5124F0,SetTo,13),KillUnit(166, FP),SetV(SpeedV,1),RotatePlayer({DisplayTextX(StrDesignX(ColorT[i+1].."P"..(i+1).." \x04이(가) \x084배속 \x04아이템을 구입하였습니다. 이제부터 \x084배속\x04이 적용됩니다."),4)}, Force1, FP)})
		--		f_LSub(FP, Credit[i+1], Credit[i+1], "500")
		--		TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)}) -- 자동저장
		--	CElseIfX({CV(SpeedV,1)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: 이미 구입되었습니다."), 4),SetCp(FP)})
		--	CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x17크레딧\x04이 부족합니다."), 4),SetCp(FP)})
		--	CIfXEnd()
		--CIfEnd()
		--CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,114)},{MoveUnit(1, 15, i, 114, 116)})
		--local NeedSp = def_sIndex()
		--	NJump(FP, NeedSp, {CV(SpeedV,0)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x085배속 \x04아이템을 먼저 구입해주세요."), 4),SetCp(FP)})
		--	CIfX(FP,{CountdownTimer(AtMost, 60*60*48),CV(SpeedV,1),TTNWar(Credit[i+1], AtLeast, "10000")},{SetCountdownTimer(Add, 60*60*12),KillUnit(169, FP)})
		--	TriggerX(FP,{CountdownTimer(AtMost, 0)},{RotatePlayer({DisplayTextX(StrDesignX(ColorT[i+1].."P"..(i+1).." \x04이(가) \x1F5배속 \x04아이템을 구입하였습니다. 이제부터 \x1F카운트다운 타이머 12시간\x04동안 \x1F5배속\x04이 적용됩니다."),4)}, Force1, FP)},{preserved})
		--	TriggerX(FP,{CountdownTimer(AtLeast, 1)},{RotatePlayer({DisplayTextX(StrDesignX(ColorT[i+1].."P"..(i+1).." \x04이(가) \x1F5배속 \x04아이템을 구입하였습니다. \x1F카운트다운 타이머\x04가 \x1F12시간\x04 추가되었습니다."),4)}, Force1, FP)},{preserved})
		--		f_LSub(FP, Credit[i+1], Credit[i+1], "10000")
		--		TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)}) -- 자동저장
		--		CElseIfX({CountdownTimer(AtLeast, (60*60*48)+1)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: 카운트다운 타이머가 너무 많습니다. 지속시간을 소모하고 다시 시도해주세요."), 4),SetCp(FP)})
		--		CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x17크레딧\x04이 부족합니다."), 4),SetCp(FP)})
		--	CIfXEnd()
		--	NJumpEnd(FP, NeedSp)
		--CIfEnd()
		CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,128)},{MoveUnit(1, 15, i, 128, 116)})

			CIfX(FP,{CV(CreditAddSC[i+1],0),TTNWar(Credit[i+1], AtLeast, "10000")},{SetV(CreditAddSC[i+1],1),SetCp(i),DisplayText(StrDesignX("\x07기본유닛 6기\x04를 구입하셨습니다. \x08주의 \x04: \x07기본유닛\x04은 게임 실행 1회에만 등장하며 3분 뒤 사라집니다."), 4)})
				TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)},{preserved})--자동저장
				f_LSub(FP, Credit[i+1], Credit[i+1], "10000")
			CElseIfX({CV(CreditAddSC[i+1],1,AtLeast),Deaths(i,AtMost,0,99)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: 이미 구입되었습니다."), 4),SetCp(FP)})
			CElseIfX({CV(CreditAddSC[i+1],1,AtLeast),Deaths(i,AtLeast,1,99)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: 이미 테스트 플레이 특전으로 지급받았습니다."), 4),SetCp(FP)})
			CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x17크레딧\x04이 부족합니다."), 4),SetCp(FP)})
			CIfXEnd()
		CIfEnd()
		CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,127)},{MoveUnit(1, 15, i, 127, 116)})
		
			CIfX(FP,{TTNWar(Credit[i+1], AtLeast,_LMul({MulOp[i+1],0}, "100"))},{})
				TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)},{preserved})--자동저장
				CAdd(FP,SellTicket[i+1],MulOp[i+1])
				f_LSub(FP, Credit[i+1], Credit[i+1], _LMul({MulOp[i+1],0}, "100"))
				CMov(FP,iv.MissionV[i+1],4,nil,4)
				CIf(FP,{LocalPlayerID(i)})
				local TempV = CreateVar(FP)
				f_Cast(FP,{TempV,0},_LMul({MulOp[i+1],0}, "100"),nil,nil,1)
				DisplayPrint(LCP, {"\x13\x07『 \x19유닛 판매권\x04을 ",MulOp[i+1],"개 구입하였습니다. ",TempV," \x17크레딧 \x08사용 \x07』"})
				DisplayPrint(LCP, {"\x13\x07『 \x04현재 ",SellTicket[i+1]," 개의 \x19유닛 판매권 보유중 \x07』"})
				CIfEnd()
			CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x17크레딧\x04이 부족합니다."), 4),SetCp(FP)})
			CIfXEnd()
		CIfEnd()
		
		CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,126)},{MoveUnit(1, 15, i, 126, 116)})
		
			CIfX(FP,{CV(GeneralPlayTime,4*24*60*60,AtLeast),CV(SellTicket[i+1],MulOp[i+1],AtLeast)},{})
				TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)},{preserved})--자동저장
				CMov(FP,iv.MissionV[i+1],64,nil,64)


				CSub(FP,SellTicket[i+1],MulOp[i+1])
				
				f_LAdd(FP, Credit[i+1], Credit[i+1], _LMul({MulOp[i+1],0}, "75"))

				CIf(FP,{LocalPlayerID(i)})
				local TempV = CreateVar(FP)
				f_Cast(FP,{TempV,0},_LMul({MulOp[i+1],0}, "75"),nil,nil,1)
				DisplayPrint(LCP, {"\x13\x07『 \x19유닛 판매권\x04을 ",MulOp[i+1],"개 판매하였습니다. ",TempV," \x17크레딧 \x07반환 \x07』"})
				DisplayPrint(LCP, {"\x13\x07『 \x04현재 ",SellTicket[i+1]," 개의 \x19유닛 판매권 보유중 \x07』"})
				CIfEnd()
				
			CElseIfX({CV(GeneralPlayTime,4*24*60*60,AtMost)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: 해당 항목은 \x1F인게임 \x0F4시간 이상 \x04플레이 후 사용가능합니다.."), 4),SetCp(FP)})
			CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x19유닛 판매권\x04이 부족합니다."), 4),SetCp(FP)})
			CIfXEnd()
		CIfEnd()
		
		CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,114)},{MoveUnit(1, 15, i, 114, 116)})
		
			CIfX(FP,{TTNWar(Credit[i+1], AtLeast,_LMul({MulOp[i+1],0}, "100000"))},{})
				TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)},{preserved})--자동저장
				CMov(FP,iv.MissionV[i+1],256,nil,256)
				CAdd(FP,VaccItem[i+1],MulOp[i+1])
				f_LSub(FP, Credit[i+1], Credit[i+1], _LMul({MulOp[i+1],0}, "100000"))
				CIf(FP,{LocalPlayerID(i)})
				local TempV = CreateVar(FP)
				f_Cast(FP,{TempV,0},_LMul({MulOp[i+1],0}, "100000"),nil,nil,1)
				DisplayPrint(LCP, {"\x13\x07『 \x10강화기 백신\x04을 ",MulOp[i+1],"개 구입하였습니다. ",TempV," \x17크레딧 \x08사용 \x07』"})
				DisplayPrint(LCP, {"\x13\x07『 \x04현재 ",VaccItem[i+1]," 개의 \x10강화기 백신 보유중 \x07』"})
				DoActions(FP, {SetCp(i),DisplayText(StrDesignX("\x03참고 \x04: \x10강화기 백신\x04은 SCA로 저장할 수 있습니다!"))})
				CIfEnd()
			CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x17크레딧\x04이 부족합니다."), 4),SetCp(FP)})
			CIfXEnd()
		CIfEnd()

		
		CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,113)},{MoveUnit(1, 15, i, 113, 116)})
		
			CIfX(FP,{CV(VaccItem[i+1],MulOp[i+1],AtLeast)},{})
				TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)},{preserved})--자동저장
				CSub(FP,VaccItem[i+1],MulOp[i+1])
				f_LAdd(FP, Credit[i+1], Credit[i+1], _LMul({MulOp[i+1],0}, "100000"))
				CMov(FP,iv.MissionV[i+1],1024,nil,1024)
				CAdd(FP,_Ccode(FP, VaccSCount[i+1]),MulOp[i+1])
				CIf(FP,{LocalPlayerID(i)})
				local TempV = CreateVar(FP)
				f_Cast(FP,{TempV,0},_LMul({MulOp[i+1],0}, "100000"),nil,nil,1)
				DisplayPrint(LCP, {"\x13\x07『 \x10강화기 백신\x04을 ",MulOp[i+1],"개 판매하였습니다. ",TempV," \x17크레딧 \x07반환 \x07』"})
				DisplayPrint(LCP, {"\x13\x07『 \x04현재 ",VaccItem[i+1]," 개의 \x10강화기 백신 보유중 \x07』"})
				CIfEnd()
			CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x10강화기 백신\x04이 부족합니다."), 4),SetCp(FP)})
			CIfXEnd()
		CIfEnd()


	end
CIfEnd()
end