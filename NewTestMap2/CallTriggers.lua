function Install_CallTriggers()
	
	Call_Print13 = {}
	for i = 0, 6 do
	Call_Print13[i+1] = SetCallForward()
	SetCall(FP)
		Print_13_2(FP,{i},nil)
	SetCallEnd()
	end
	


	CreateStackedUnit = SetCallForward()
	SUnitID = CreateVar(FP)
	SLocation = CreateVar(FP)
	DLocation = CreateVar(FP)
	SPlayer = CreateVar(FP)
	SAmount = CreateVar(FP)
	SetCall(FP)
	CWhile(FP,{CV(SAmount,1,AtLeast)},{SubV(SAmount,1)})
	CIf(FP,{Memory(0x628438, AtLeast, 1)},{SetCD(TBLFlag,1)})
		f_Read(FP, 0x628438, nil, Nextptrs)
		CDoActions(FP, {TCreateUnit(1,SUnitID,SLocation,SPlayer),
		TSetDeaths(_Add(Nextptrs,13),SetTo,2000,0),
		TSetDeathsX(_Add(Nextptrs,18),SetTo,2000,0,0xFFFF),
		TSetMemoryX(_Add(Nextptrs,8),SetTo,127*65536,0xFF0000),
		TSetMemoryX(_Add(Nextptrs,9),SetTo,0,0xFF000000),
		TSetMemoryX(_Add(Nextptrs,55),SetTo,0xA00000,0xA00000),
	})
	CSub(FP,CurCunitI,Nextptrs,19025)
	f_Div(FP,CurCunitI,_Mov(84))
	local TempV = CreateVar(FP)
	CMov(FP,TempV,_Add(_Mul(CurCunitI,_Mov(0x970/4)),_Add(CT_Cunit[3],((0x20*0)/4))))
	CDoActions(FP, {
		TSetMemory(TempV,SetTo,_Add(CT_GNextRandV,SUnitID)),
		TSetMemory(_Add(TempV,0x20/4),SetTo,CT_GNextRandV)
	})
	CTSUPtr = CreateVar(FP)
	CTSUID = CreateVar(FP)
		--DisplayPrint(Force1, {"\x13\x04CTSUPtr : ",SUnitID})--
	CIf(FP,{TTOR({
		CV(SUnitID,5),
		CV(SUnitID,23),
		CV(SUnitID,30),
		CV(SUnitID,3),
		CV(SUnitID,17),
	})})
	f_Read(FP, _Add(Nextptrs, 28), nil, CTSUPtr)
			--DisplayPrint(Force1, {"\x13\x04CTSUPtr : ",CTSUPtr})--
	CIf(FP,{CV(CTSUPtr,19025,AtLeast),CV(CTSUPtr,19025+(84*1699),AtMost)})
	f_Read(FP, _Add(CTSUPtr, 25), CTSUID, nil, 0xFF, 1)
		--DisplayPrint(Force1, {"\x13\x04CTSUID : ",CTSUID})--
	CSub(FP,CurCunitI,CTSUPtr,19025)
	f_Div(FP,CurCunitI,_Mov(84))
	CMov(FP,TempV,_Add(_Mul(CurCunitI,_Mov(0x970/4)),_Add(CT_Cunit[3],((0x20*0)/4))))
	CDoActions(FP, {
		TSetMemory(TempV,SetTo,_Add(CT_GNextRandV,CTSUID)),
		TSetMemory(_Add(TempV,0x20/4),SetTo,CT_GNextRandV)
	})
	CIfEnd()

	CIfEnd()


	--CallTrigger(FP, Call_CTInputUID)
	CTrigger(FP, {CV(DLocation,1,AtLeast)}, {TOrder(SUnitID, SPlayer, SLocation, Move, DLocation)},1)
	CWhileEnd()

	CIfEnd()
	SetCallEnd()
	function CreateUnitStacked(Condition,Amount,UnitID,Location,DestLocation,Player,AddTrig,Preserved)
		if DestLocation == nil then DestLocation = 0 end
		CallTriggerX(FP, CreateStackedUnit, Condition, {
			SetNVar(SAmount,SetTo,Amount),
			SetNVar(SUnitID,SetTo,UnitID),
			SetNVar(SLocation,SetTo,Location),
			SetNVar(DLocation,SetTo,DestLocation),
			SetNVar(SPlayer,SetTo,Player),AddTrig
		}, Preserved)
		
	end

	

	Call_Enchant = SetCallForward()
	--100000 = 100%
	SetCall(FP)
	if TestStart == 1 then
		GetEPer = CreateVar(FP)
		CIfX(FP,{KeyPress("F12", "Down")})
		CMov(FP,GetEPer,1)
		CElseX()
		GetEPer2 = f_CRandNum(100001,1) -- ���� ���� ����. GetEPer ��� ������� ����� ����
		CMov(FP,GetEPer,GetEPer2)
		CIfXEnd()
	else
		GetEPer = f_CRandNum(100001,1) -- ���� ���� ����. GetEPer ��� ������� ����� ����
	end
	
	TotalEper = CreateVar(FP) -- ���ο� ���� ������� �ߺ����� ����
	TotalEper2 = CreateVar(FP) -- ���ο� ���� ������� �ߺ����� ����
	TotalEper3 = CreateVar(FP) -- ���ο� ���� ������� �ߺ����� ����
	--ELevel = ���� ��ȭ���� ����
	CAdd(FP,TotalEper,UEper,GEper) -- +1�� Ȯ��
	CAdd(FP,TotalEper2,_Div(UEper,10),GEper2)
	CAdd(FP,TotalEper3,_Div(UEper,100),GEper3)

	E3Range = CreateVarArr(2, FP)
	E2Range = CreateVarArr(2, FP)
	E1Range = CreateVarArr(2, FP)
	CMov(FP,E3Range[1],1)
	CMov(FP,E3Range[2],TotalEper3)
	CMov(FP,E2Range[1],E3Range[2],1)
	CMov(FP,E2Range[2],_Add(E3Range[2],TotalEper2))
	CMov(FP,E1Range[1],E2Range[2],1)
	CMov(FP,E1Range[2],_Add(E2Range[2],TotalEper))
	if Limit == 1 then -- �׽�Ʈ�� ��� ���
		CIf(FP,{KeyPress("F12", "Down")})
			CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText(string.rep("\n", 10), 4)})
			for i = 1, 39 do
				TriggerX(FP, CV(ELevel,i-1), {DisplayText("\x08"..i.."�� ���� ��ȭ �õ�", 4)},{preserved})
			end
			ColorCodeV = CreateVar2(FP,nil,nil,0x0E)
			ColorCodeV2 = CreateVar2(FP,nil,nil,0x0F)
			ColorCodeV3 = CreateVar2(FP,nil,nil,0x10)
			ColorCodeV4 = CreateVar2(FP,nil,nil,0x1B)

			DisplayPrint(ECP,{"\x04��µ� ���� : ",ColorCodeV[2],GetEPer})
			DisplayPrint(ECP,{"\x1F���� +3 Ȯ�� : ",ColorCodeV2[2],E3Range[1]," \x04~ ",E3Range[2]})
			DisplayPrint(ECP,{"\x1F���� +2 Ȯ�� : ",ColorCodeV3[2],E2Range[1]," \x04~ ",E2Range[2]})
			DisplayPrint(ECP,{"\x1F���� +1 Ȯ�� : ",ColorCodeV4[2],E1Range[1]," \x04~ ",E1Range[2]})
			
		CIfEnd()
	end

	
	
	--��ȭ ���� �Ǵ� ���� ����. TotalEper�� ������������ �� Ŭ��� ����
	CIfX(FP,{TNVar(GetEPer, AtLeast, E3Range[1]),TNVar(GetEPer, AtMost, E3Range[2])})--+3�� ������
		if Limit == 1 then
			CIf(FP,{KeyPress("F12", "Down")})
				CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("\x1F��� : +3 ����", 4)})
			CIfEnd()
		end
		CIfX(FP, {CV(ELevel,33,AtMost)}) -- 35������ +2 ����ȵ�, 36������ +2 ����ȵ�
		CAdd(FP,ELevel,3)
		CElseIfX({CV(ELevel,34,AtLeast),CV(ELevel,35,AtMost)})
		CMov(FP,ELevel,36)
		CElseX()
		CAdd(FP,ELevel,1)
		CIfXEnd()
	CElseIfX({TNVar(GetEPer, AtLeast, E2Range[1]),TNVar(GetEPer, AtMost, E2Range[2])})--+2�� ������
		if Limit == 1 then
			CIf(FP,{KeyPress("F12", "Down")})
				CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("\x1C��� : +2 ����", 4)})
			CIfEnd()
		end
		CIfX(FP, {CV(ELevel,34,AtMost)}) -- 36������ +2 +3 ����ȵ�
		CAdd(FP,ELevel,2)
		CElseIfX({CV(ELevel,35)})
		CMov(FP,ELevel,36)
		CElseX()
		CAdd(FP,ELevel,1)
		CIfXEnd()
	CElseIfX({TNVar(GetEPer, AtLeast, E1Range[1]),TNVar(GetEPer, AtMost, E1Range[2])})--+1�� ������
		if Limit == 1 then
			CIf(FP,{KeyPress("F12", "Down")})
				CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("\x0F��� : +1 ����", 4)})
			CIfEnd()
		end
		CAdd(FP,ELevel,1)
	CElseX()--���н� Never(����ġ ����)
		local TempEXP = CreateVar(FP)
		if Limit == 1 then
			CIf(FP,{KeyPress("F12", "Down")})
				CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("\x08��� : ����", 4)})
			CIfEnd()
		end
		for i = 0, 6 do
			--CIf(FP,{Never(),CV(ECP,i)})
			--f_LAdd(FP, PEXP[i+1], PEXP[i+1], {EExp,0})
			----f_LAdd(FP, Credit[i+1], Credit[i+1], {EExp,0})
			--CIf(FP,{CV(GEXP,1,AtLeast)})
		--	
			--	CAdd(FP,PEXP2[i+1],_Mul(EExp,GEXP))
			--	CMov(FP,TempEXP,_Div(PEXP2[i+1],10),nil,nil,1)
			--	f_LAdd(FP, PEXP[i+1], PEXP[i+1], {TempEXP,0})
			--	CMod(FP, PEXP2[i+1], 10)
			--CIfEnd()
			--CIfEnd()
		end

		--if TestStart == 1 then
		--	CIf(FP,{KeyPress("F12", "Down")})
		--		ItoDec(FP,_Add(EExp,TempEXP),VArr(TestVA2,0),2,0x1F,0)
		--		f_Movcpy(FP,_Add(ETestStrPtr3,ETestTxt3[2]),VArr(TestVA2,0),4*4)
		--		CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("\x0D\x0D\x0DET3".._0D, 4)})
		--	CIfEnd()
		--end
	CMov(FP,ELevel,0)
	CIfXEnd()
	CIf(FP,{CV(ELevel,1,AtLeast)})
	TriggerX(FP,{CV(ELevel,#LevelUnitArr-1,AtLeast)},{SetV(ELevel,#LevelUnitArr-1)},{preserved})--�����÷ο� ����

		for i = 0, 6 do
			CIf(FP,{CV(ECP,i)})
				CMovX(FP,VArr(GetUnitVArr[i+1], ELevel),1,Add)
			CIfEnd()
		end
	CIfEnd()
	
	SetCallEnd()
	Call_CT = SetCallForward()
	SetCall(FP)
	
	CTPEXP = CreateWar(FP)
	CTPLevel = CreateVar(FP)
	CTStatP = CreateVar(FP)
	CTCurEXP = CreateWar(FP)
	CTTotalExp = CreateWar(FP)
	local TempReadV = CreateVar(FP)

	local CheatTestJump = def_sIndex()
	CJumpEnd(FP, CheatTestJump)
	NIf(FP,{TTNWar(CTPEXP,AtLeast,CTTotalExp),CV(CTPLevel,9999,AtMost)},{AddV(CTPLevel,1)}) -- ����ġ ġ�� �˻�

	f_Read(FP,FArr(EXPArr,_Sub(CTPLevel,1)),TempReadV,nil,nil,1)
	f_LAdd(FP, CTTotalExp, CTTotalExp, {TempReadV,0})
	f_Read(FP,FArr(EXPArr,_Sub(CTPLevel,2)),TempReadV,nil,nil,1)
	f_LAdd(FP, CTCurEXP, CTCurEXP, {TempReadV,0})
	CAdd(FP,CTStatP,5)
	CJump(FP, CheatTestJump)
	NIfEnd()


	SetCallEnd()

	MCP = CreateVar(FP)
	Call_SetScrMouse = SetCallForward()
	SetCall(FP)
	mouseX = dwread_epd(0x6CDDC4)
	mouseY = dwread_epd(0x6CDDC8)
	screenGridX = dwread_epd(0x62848C)
	screenGridY = dwread_epd(0x6284A8)
	Simple_SetLocX(FP,117, 256*16, 256*16,256*16, 256*16) --�߾� (�ʻ�����*16, �ʻ�����*16)
	CDoActions(FP,{TSetMemory(0x6509B0, SetTo, MCP),CenterView(118)})
	ScreenX2 = dwread_epd(0x62848C);
	ScreenY2 = dwread_epd(0x6284A8);
	screenSizeX = CreateVar(FP)
	screenSizeY = CreateVar(FP)
	CMov(FP,screenSizeX,_iSub(_Mov(256*16),ScreenX2))
	CMov(FP,screenSizeY,_iSub(_Mov(256*16),ScreenY2))
	screenX = CreateVar(FP)
	screenY = CreateVar(FP)
	CAdd(FP,screenX,screenGridX,screenSizeX)
	CAdd(FP,screenY,screenGridY,screenSizeY)
	Simple_SetLocX(FP,117, screenX, screenY,screenX, screenY)
	CDoActions(FP,{TSetMemory(0x6509B0, SetTo, MCP),CenterView(118)})
	Simple_SetLocX(FP,117, 256*16, 256*16,256*16, 256*16) --�߾� (�ʻ�����*16, �ʻ�����*16)
	CMov(FP,screenX,_iSub(_Add(mouseX,320),screenSizeX))

	screenX2 = CreateVar(FP)
	CiSub(FP,screenX2,screenX,screenSizeX)

	SetCallEnd()
	G_Btnptr = CreateVar(FP)
	G_BtnFnm = CreateVar(FP)
	G_PushBtnm = CreateVar(FP)
	G_BtnCP = CreateVar(FP)
	local VArrI,VArrI4 = CreateVars(2,FP)

	Call_BtnFnc = SetCallForward()
	SetCall(FP)
	CIf(FP,{CVar(FP,G_Btnptr[2],AtLeast,19025),CVar(FP,G_Btnptr[2],AtMost,19025+(1699*84))})
	CIf(FP,{TMemory(_Add(G_Btnptr,0x98/4),AtMost,0 + 227*65536)}) -- ��ư ���������
	--Print_13X(FP,G_BtnCP)

	f_Read(FP,_Add(G_Btnptr,0x98/4),G_PushBtnm)
	CrShift(FP,G_PushBtnm,16)

	CIfX(FP,{Never()})
	CElseIfX(CV(G_BtnFnm,1))--�ڵ�����
	local AutoBuyVArr = GetVArray(iv.AutoBuyCode[1], 7)
	local GetNum = CreateVar(FP)
	local GetABData = CreateVar(FP)
	local PBJump = def_sIndex()
	local PBJump2 = def_sIndex()
	NJump(FP, PBJump, CV(G_PushBtnm,24))
	CMov(FP, GetNum,_SHRead(Arr(BuyDataArr,G_PushBtnm)))
	CMovX(FP,GetABData,VArrX(AutoBuyVArr,VArrI,VArrI4))
	CIfX(FP,{TNVar(GetNum, Exactly, GetABData)})
	DisplayPrintEr(G_BtnCP, {"\x07�� \x06",GetNum,"�� \x04���� \x1B�ڵ����� \x08OFF \x07��"})
	CMovX(FP,VArrX(AutoBuyVArr,VArrI,VArrI4),0)
	CElseX()
	DisplayPrintEr(G_BtnCP, {"\x07�� \x06",GetNum,"�� \x04���� \x1B�ڵ����� \x07ON \x07��"})
	CMovX(FP,VArrX(AutoBuyVArr,VArrI,VArrI4),GetNum)
	CIfXEnd()
	CJump(FP, PBJump2)
	NJumpEnd(FP, PBJump)
	DisplayPrintEr(G_BtnCP, {"\x07�� \x04���� \x1B�ڵ����� \x08OFF \x07��"})
	CMovX(FP,VArrX(AutoBuyVArr,VArrI,VArrI4),0)
	CJumpEnd(FP,PBJump2)




	CElseIfX({CV(G_BtnFnm,2,AtLeast),CV(G_BtnFnm,5,AtMost)})--�ڵ���ȭ 1~25
	TriggerX(FP, {CV(G_BtnFnm,3)}, AddV(G_PushBtnm,25), {preserved})
	TriggerX(FP, {CV(G_BtnFnm,5)}, AddV(G_PushBtnm,25), {preserved})
	local GetArrNum = CreateVar(FP)
	local GetArrNum2 = CreateVar(FP)
	local TxtColor = CreateVar(FP)
	f_Mul(FP, GetArrNum2, G_PushBtnm, 7)
	CAdd(FP,GetArrNum2,G_BtnCP)
	ConvertArr(FP,GetArrNum,GetArrNum2)

	DoActionsX(FP,{SetV(TxtColor,0x06),AddV(G_PushBtnm,1)})
	TriggerX(FP, {CV(G_PushBtnm,26,AtLeast)}, SetV(TxtColor,0x0F), {preserved})

	CIf(FP,{CV(G_BtnFnm,2,AtLeast),CV(G_BtnFnm,3,AtMost)})
	CIfX(FP,{TMemory(_TMem(ArrX(AutoEnchArr,GetArrNum)),Exactly,0)})
	DisplayPrintEr(G_BtnCP, {"\x07�� ",TxtColor[2],G_PushBtnm,"�� \x04���� \x1B�ڵ���ȭ \x07ON \04(�Ǹ� �켱 �����) \x07��",})
	CMovX(FP,ArrX(AutoEnchArr,GetArrNum),1)
	CElseX()
	DisplayPrintEr(G_BtnCP, {"\x07�� ",TxtColor[2],G_PushBtnm,"�� \x04���� \x1B�ڵ���ȭ \x08OFF \04(�Ǹ� �켱 �����) \x07��",})
	CMovX(FP,ArrX(AutoEnchArr,GetArrNum),0)
	CIfXEnd()
	CIfEnd()
	CIf(FP,{CV(G_BtnFnm,4,AtLeast),CV(G_BtnFnm,5,AtMost)})
	CIfX(FP,{TMemory(_TMem(ArrX(AutoSellArr,GetArrNum)),Exactly,0)})
	DisplayPrintEr(G_BtnCP, {"\x07�� ",TxtColor[2],G_PushBtnm,"�� \x04���� \x07�ڵ��Ǹ� \x07ON \04(�Ǹ� �켱 �����) \x07��",})
	CMovX(FP,ArrX(AutoSellArr,GetArrNum),1)

	CElseX()
	DisplayPrintEr(G_BtnCP, {"\x07�� ",TxtColor[2],G_PushBtnm,"�� \x04���� \x07�ڵ��Ǹ� \x08OFF \04(�Ǹ� �켱 �����) \x07��",})
	CMovX(FP,ArrX(AutoSellArr,GetArrNum),0)
	CIfXEnd()
	CIfEnd()
	

	





	CIfXEnd()



	CIfEnd()--ShopEnd
	CDoActions(FP,{
		TSetMemory(_Add(G_Btnptr,0x98/4),SetTo,0 + 228*65536);
		TSetMemory(_Add(G_Btnptr,0x9C/4),SetTo,228 + 228*65536);
		TSetMemoryX(_Add(G_Btnptr,0xA0/4),SetTo,228,0xFFFF)})
	CIfEnd()


		
	SetCallEnd()



	Call_BtnInit = SetCallForward()

	local BtnFncArr = {
		TestShop[1], -- ���� �ڵ����ű�
		SettingUnit1[1], -- 1~25������ �ڵ���ȭ ����
		SettingUnit2[1], -- 26~39���� �ڵ���ȭ ����
		SettingUnit3[1], -- 15~25������ �ڵ��Ǹ� ����
		SettingUnit4[1], -- 26~39���� �ڵ��Ǹ� ����
	}
	SetCall(FP)
	ConvertVArr(FP,VArrI,VArrI4,G_BtnCP,7)
	for j,k in pairs(BtnFncArr) do
		local BtnVA = GetVArray(k, 7)
		CMovX(FP,G_Btnptr,VArrX(BtnVA,VArrI,VArrI4),nil,nil,nil,1)
		CallTrigger(FP,Call_BtnFnc,{SetV(G_BtnFnm,j)})
	end
	



		
	SetCallEnd()


	Call_ConvertTime = SetCallForward()
	SetCall(FP)
	CTimeV = CreateVar(FP)
	CTimeSS = CreateVar(FP)
	CTimeMM = CreateVar(FP)
	CTimeHH = CreateVar(FP)
	CTimeDD = CreateVar(FP)
	Byte_NumSet(CTimeV,CTimeDD,86400,1,nil,6)
	Byte_NumSet(CTimeV,CTimeHH,3600,1,nil,6)
	Byte_NumSet(CTimeV,CTimeMM,60,1,nil,6)
	Byte_NumSet(CTimeV,CTimeSS,1,1,nil,6)

	SetCallEnd()
if TestStart == 1 then
	
end
end