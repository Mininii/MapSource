function Shop()
	local SellTicket = iv.SellTicket
	local MulOp = iv.MulOp--CreateVarArr2(7,1,FP) -- ���� ���ݷ¿� ���� ��ġ ǥ��� ����
	local Credit = iv.Credit--CreateWarArr(7,FP) -- �������� ũ����
	local CreditAddSC = iv.CreditAddSC
	local LCP = iv.LCP--CreateVar(FP)
	local GeneralPlayTime= iv.GeneralPlayTime
	local VaccItem = iv.VaccItem
    
SpeedV = CreateVar(FP)
CIf(FP,{Bring(AllPlayers, AtLeast, 1, 15, 112)})
	for i= 0, 6 do
		--CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,113)},{MoveUnit(1, 15, i, 113, 116)})
		--	CIfX(FP,{CV(SpeedV,0),TTNWar(Credit[i+1], AtLeast, "500")},{SetMemory(0x5124F0,SetTo,13),KillUnit(166, FP),SetV(SpeedV,1),RotatePlayer({DisplayTextX(StrDesignX(ColorT[i+1].."P"..(i+1).." \x04��(��) \x084��� \x04�������� �����Ͽ����ϴ�. �������� \x084���\x04�� ����˴ϴ�."),4)}, Force1, FP)})
		--		f_LSub(FP, Credit[i+1], Credit[i+1], "500")
		--		TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)}) -- �ڵ�����
		--	CElseIfX({CV(SpeedV,1)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: �̹� ���ԵǾ����ϴ�."), 4),SetCp(FP)})
		--	CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x17ũ����\x04�� �����մϴ�."), 4),SetCp(FP)})
		--	CIfXEnd()
		--CIfEnd()
		--CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,114)},{MoveUnit(1, 15, i, 114, 116)})
		--local NeedSp = def_sIndex()
		--	NJump(FP, NeedSp, {CV(SpeedV,0)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x085��� \x04�������� ���� �������ּ���."), 4),SetCp(FP)})
		--	CIfX(FP,{CountdownTimer(AtMost, 60*60*48),CV(SpeedV,1),TTNWar(Credit[i+1], AtLeast, "10000")},{SetCountdownTimer(Add, 60*60*12),KillUnit(169, FP)})
		--	TriggerX(FP,{CountdownTimer(AtMost, 0)},{RotatePlayer({DisplayTextX(StrDesignX(ColorT[i+1].."P"..(i+1).." \x04��(��) \x1F5��� \x04�������� �����Ͽ����ϴ�. �������� \x1Fī��Ʈ�ٿ� Ÿ�̸� 12�ð�\x04���� \x1F5���\x04�� ����˴ϴ�."),4)}, Force1, FP)},{preserved})
		--	TriggerX(FP,{CountdownTimer(AtLeast, 1)},{RotatePlayer({DisplayTextX(StrDesignX(ColorT[i+1].."P"..(i+1).." \x04��(��) \x1F5��� \x04�������� �����Ͽ����ϴ�. \x1Fī��Ʈ�ٿ� Ÿ�̸�\x04�� \x1F12�ð�\x04 �߰��Ǿ����ϴ�."),4)}, Force1, FP)},{preserved})
		--		f_LSub(FP, Credit[i+1], Credit[i+1], "10000")
		--		TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)}) -- �ڵ�����
		--		CElseIfX({CountdownTimer(AtLeast, (60*60*48)+1)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: ī��Ʈ�ٿ� Ÿ�̸Ӱ� �ʹ� �����ϴ�. ���ӽð��� �Ҹ��ϰ� �ٽ� �õ����ּ���."), 4),SetCp(FP)})
		--		CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x17ũ����\x04�� �����մϴ�."), 4),SetCp(FP)})
		--	CIfXEnd()
		--	NJumpEnd(FP, NeedSp)
		--CIfEnd()
		CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,128)},{MoveUnit(1, 15, i, 128, 116)})

			CIfX(FP,{CV(CreditAddSC[i+1],0),TTNWar(Credit[i+1], AtLeast, "10000")},{SetV(CreditAddSC[i+1],1),SetCp(i),DisplayText(StrDesignX("\x07�⺻���� 6��\x04�� �����ϼ̽��ϴ�. \x08���� \x04: \x07�⺻����\x04�� ���� ���� 1ȸ���� �����ϸ� 3�� �� ������ϴ�."), 4)})
				TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)},{preserved})--�ڵ�����
				f_LSub(FP, Credit[i+1], Credit[i+1], "10000")
			CElseIfX({CV(CreditAddSC[i+1],1,AtLeast),Deaths(i,AtMost,0,99)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: �̹� ���ԵǾ����ϴ�."), 4),SetCp(FP)})
			CElseIfX({CV(CreditAddSC[i+1],1,AtLeast),Deaths(i,AtLeast,1,99)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: �̹� �׽�Ʈ �÷��� Ư������ ���޹޾ҽ��ϴ�."), 4),SetCp(FP)})
			CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x17ũ����\x04�� �����մϴ�."), 4),SetCp(FP)})
			CIfXEnd()
		CIfEnd()
		CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,127)},{MoveUnit(1, 15, i, 127, 116)})
		
			CIfX(FP,{TTNWar(Credit[i+1], AtLeast,_LMul({MulOp[i+1],0}, "100"))},{})
				TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)},{preserved})--�ڵ�����
				CAdd(FP,SellTicket[i+1],MulOp[i+1])
				f_LSub(FP, Credit[i+1], Credit[i+1], _LMul({MulOp[i+1],0}, "100"))
				CMov(FP,iv.MissionV[i+1],4,nil,4)
				CIf(FP,{LocalPlayerID(i)})
				local TempV = CreateVar(FP)
				f_Cast(FP,{TempV,0},_LMul({MulOp[i+1],0}, "100"),nil,nil,1)
				DisplayPrint(LCP, {"\x13\x07�� \x19���� �Ǹű�\x04�� ",MulOp[i+1],"�� �����Ͽ����ϴ�. ",TempV," \x17ũ���� \x08��� \x07��"})
				DisplayPrint(LCP, {"\x13\x07�� \x04���� ",SellTicket[i+1]," ���� \x19���� �Ǹű� ������ \x07��"})
				CIfEnd()
			CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x17ũ����\x04�� �����մϴ�."), 4),SetCp(FP)})
			CIfXEnd()
		CIfEnd()
		
		CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,126)},{MoveUnit(1, 15, i, 126, 116)})
		
			CIfX(FP,{CV(GeneralPlayTime,4*24*60*60,AtLeast),CV(SellTicket[i+1],MulOp[i+1],AtLeast)},{})
				TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)},{preserved})--�ڵ�����
				CMov(FP,iv.MissionV[i+1],64,nil,64)


				CSub(FP,SellTicket[i+1],MulOp[i+1])
				
				f_LAdd(FP, Credit[i+1], Credit[i+1], _LMul({MulOp[i+1],0}, "75"))

				CIf(FP,{LocalPlayerID(i)})
				local TempV = CreateVar(FP)
				f_Cast(FP,{TempV,0},_LMul({MulOp[i+1],0}, "75"),nil,nil,1)
				DisplayPrint(LCP, {"\x13\x07�� \x19���� �Ǹű�\x04�� ",MulOp[i+1],"�� �Ǹ��Ͽ����ϴ�. ",TempV," \x17ũ���� \x07��ȯ \x07��"})
				DisplayPrint(LCP, {"\x13\x07�� \x04���� ",SellTicket[i+1]," ���� \x19���� �Ǹű� ������ \x07��"})
				CIfEnd()
				
			CElseIfX({CV(GeneralPlayTime,4*24*60*60,AtMost)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: �ش� �׸��� \x1F�ΰ��� \x0F4�ð� �̻� \x04�÷��� �� ��밡���մϴ�.."), 4),SetCp(FP)})
			CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x19���� �Ǹű�\x04�� �����մϴ�."), 4),SetCp(FP)})
			CIfXEnd()
		CIfEnd()
		
		CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,114)},{MoveUnit(1, 15, i, 114, 116)})
		
			CIfX(FP,{TTNWar(Credit[i+1], AtLeast,_LMul({MulOp[i+1],0}, "100000"))},{})
				TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)},{preserved})--�ڵ�����
				CMov(FP,iv.MissionV[i+1],256,nil,256)
				CAdd(FP,VaccItem[i+1],MulOp[i+1])
				f_LSub(FP, Credit[i+1], Credit[i+1], _LMul({MulOp[i+1],0}, "100000"))
				CIf(FP,{LocalPlayerID(i)})
				local TempV = CreateVar(FP)
				f_Cast(FP,{TempV,0},_LMul({MulOp[i+1],0}, "100000"),nil,nil,1)
				DisplayPrint(LCP, {"\x13\x07�� \x10��ȭ�� ���\x04�� ",MulOp[i+1],"�� �����Ͽ����ϴ�. ",TempV," \x17ũ���� \x08��� \x07��"})
				DisplayPrint(LCP, {"\x13\x07�� \x04���� ",VaccItem[i+1]," ���� \x10��ȭ�� ��� ������ \x07��"})
				DoActions(FP, {SetCp(i),DisplayText(StrDesignX("\x03���� \x04: \x10��ȭ�� ���\x04�� SCA�� ������ �� �ֽ��ϴ�!"))})
				CIfEnd()
			CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x17ũ����\x04�� �����մϴ�."), 4),SetCp(FP)})
			CIfXEnd()
		CIfEnd()

		
		CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,113)},{MoveUnit(1, 15, i, 113, 116)})
		
			CIfX(FP,{CV(VaccItem[i+1],MulOp[i+1],AtLeast)},{})
				TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)},{preserved})--�ڵ�����
				CSub(FP,VaccItem[i+1],MulOp[i+1])
				f_LAdd(FP, Credit[i+1], Credit[i+1], _LMul({MulOp[i+1],0}, "100000"))
				CMov(FP,iv.MissionV[i+1],1024,nil,1024)
				CAdd(FP,_Ccode(FP, VaccSCount[i+1]),MulOp[i+1])
				CIf(FP,{LocalPlayerID(i)})
				local TempV = CreateVar(FP)
				f_Cast(FP,{TempV,0},_LMul({MulOp[i+1],0}, "100000"),nil,nil,1)
				DisplayPrint(LCP, {"\x13\x07�� \x10��ȭ�� ���\x04�� ",MulOp[i+1],"�� �Ǹ��Ͽ����ϴ�. ",TempV," \x17ũ���� \x07��ȯ \x07��"})
				DisplayPrint(LCP, {"\x13\x07�� \x04���� ",VaccItem[i+1]," ���� \x10��ȭ�� ��� ������ \x07��"})
				CIfEnd()
			CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x10��ȭ�� ���\x04�� �����մϴ�."), 4),SetCp(FP)})
			CIfXEnd()
		CIfEnd()


	end
CIfEnd()
end