function Interface()
	local SaveAvTime = CreateVarArr(8, FP)
	it_jump = def_sIndex()
	CJump(FP, it_jump)
	it_Call = SetCallForward()
	SetCall(FP)
	local GetPUnitLevel = CreateVar(FP)
	local GetPUnitCool = CreateVar(FP)
	
	DPSBuildingX(GCP,DpsLV1,nil,iv.BuildMul1,{iv.TempO,Ore},iv.Money,iv.Money2)
	Debug_DPSBuildingX(DpsLV1,127,95)


	




	
	CIf(FP,{TMemory(0x512684, Exactly, GCP)})

	
	f_LMov(FP,iv.ExpLoc,_LSub(WArrX(GetWArray(iv.PEXP[1], 7),WArrI,WArrI4), WArrX(GetWArray(iv.CurEXP[1], 7),WArrI,WArrI4)),nil,nil,1)
	f_LMov(FP,iv.TotalExpLoc,_LSub(WArrX(GetWArray(iv.TotalExp[1], 7), WArrI,WArrI4), WArrX(GetWArray(iv.CurEXP[1], 7), WArrI,WArrI4)),nil,nil,1)
	for j,k in pairs(LocalDataArr) do
		if k[1][4]=="V" then
			local LocPVA = GetVArray(k[1], 7)
			CMovX(FP,k[2],VArrX(LocPVA,VArrI,VArrI4),nil,nil,nil,1)
		elseif k[1][4]=="W" then
			local LocPWA = GetWArray(k[1], 7)
			f_LMovX(FP, k[2], WArrX(LocPWA, WArrI,WArrI4), SetTo, nil,nil, 1)
		else
			PushErrorMsg("LocalDataArr_InputError")
		end
	end
	
	CIfEnd()
	
	local BtnFncArr = {
		SettingUnit1, -- 1~25강유닛 자동강화 설정
	}

	for j,k in pairs(BtnFncArr) do
		PVtoV(SettingUnit1,G_Btnptr)
		CallTriggerX(FP,Call_BtnFnc,{CV(G_Btnptr,1,AtLeast)},{SetV(G_BtnFnm,j)})
	end




	SetCallEnd()



	CJumpEnd(FP, it_jump)

	CMov(FP,iv.PCheckV,0)
	for i = 0, 7 do
		local PLevelBak = CreateVar(FP)
		CIf(FP,HumanCheck(i, 1),{SubV(SaveAvTime[i+1],1)})
		TriggerX(FP,{},{AddV(iv.PCheckV,1)},{preserved})
		CallTriggerX(FP,it_Call, {},{SetV(GCP,i),SetNWar(GCPW,SetTo,tostring(i)),SetV(VArrI,604*i),SetV(VArrI4,2416*i),SetNWar(WArrI, SetTo, {604*i,604*i}),SetNWar(WArrI4, SetTo, {2416*i,2416*i})})
		CreateUnitStackedCp({}, 3, 0, 34, nil,nil,1)


		
	CIfOnce(FP,{CD(SCA.LoadCheckArr[i+1],1)},{SetCD(iv.CheatDetect,0),SetCD(iv.StatTest, 0),SetCD(SCA.LoadCheckArr[i+1],2)})--로드 완료시 첫 실행 트리거
	CIfX(FP, {TDeaths(_Add(SCA_DataPtrV,(500*i)+1),AtLeast,1,0)})--레벨데이터가 있을경우 로드후 모두 덮어씌움, 없으면 뉴비로 간주하고 로드안함


	CallTrigger(FP,Call_SCA_DataLoadAll)

	NIfX(FP,{CV(iv.PStatVer[i+1],StatVer)},{})--스탯버전이 저장된 값과 같거나 제작자가 아닐경우 경우 치팅 감지 작동
	f_LMov(FP, CTPEXP, iv.PEXP[i+1])
	CMov(FP,CTStatP2,iv.StatP[i+1])
	f_LMov(FP, CTCurEXP, "0",nil,nil,1)
	f_LMov(FP, CTTotalExp, "0",nil,nil,1)
	CMov(FP,CTStatP,_Mul(iv.PLevel2[i+1],_Mov(5)))
	CMov(FP,CTPLevel,iv.PLevel2[i+1])
	CallTrigger(FP,Call_CT)
	CTrigger(FP, {TTNVar(CTStatP,NotSame,CTStatP2)}, {SetCDX(iv.StatTest,1,1)})
	CIfX(FP,{CV(iv.MapMakerFlag[i+1],0)})
		CTrigger(FP, {TTNVar(CTPLevel,NotSame,iv.PLevel[i+1])}, {SetCDX(iv.StatTest,2,2)})
	CElseX()
		CTrigger(FP, {}, {SetV(iv.PLevel[i+1],CTPLevel)})
	CIfXEnd()
	CTrigger(FP, {TTNWar(CTCurEXP,NotSame,iv.CurEXP[i+1])}, {SetCDX(iv.StatTest,4,4)})
	CTrigger(FP, {TTNWar(CTTotalExp,NotSame,iv.TotalExp[i+1])}, {SetCDX(iv.StatTest,8,8)})
	
	local StatTestJump = def_sIndex()
	NJump(FP, StatTestJump, CD(iv.StatTest,1,AtLeast))
	NElseX()--새 스탯 버전이 감지될 경우 치팅감지 작동X, 스탯을 초기화함
	NJumpEnd(FP, StatTestJump)--스탯 무결성 검사 실패시 자동으로 초기화

	CTrigger(FP, {TTNVar(iv.PStatVer[i+1], NotSame, StatVer)}, {SetCp(i),
	DisplayText(StrDesignX("\x04스탯이 \x07초기화\x04되었습니다. \x08사유 \x04: \x07버전 업"), 4),}, 1)
	for h = 1, 5 do
		local NBit = 2^(h-1)
		CTrigger(FP, {CDX(iv.StatTest,NBit,NBit)}, {SetCp(i),
		DisplayText(StrDesignX("\x04스탯이 \x07초기화\x04되었습니다. \x08사유 \x04: \x10레벨, 스탯 무결성 검사 실패. \x04실패코드 : "..h), 4),}, 1)
	end
	--CIf(FP,{CV(iv.PStatVer[i+1], 14,AtMost)})
	--	CTrigger(FP, {CV(SCA.WeekV,4),CV(iv.WeekCheck[i+1],3)}, {SetV(iv.FirstRewardLim2[i+1],0),SetV(iv.WeekCheck[i+1],SCA.WeekV),SetCp(i),
	--	DisplayText(StrDesignX("\x04주간 첫 달성 보상 남은횟수가 \x07초기화\x04되었습니다. \x08사유 \x04: 주간 글로벌 데이터 버그로 인한 조치"), 4)})

	--CIfEnd()
	CIf(FP,CD(iv.StatTest,1,AtLeast))
	--DisplayPrint(i, {"\x13\x07『 \x03SYSTEM Message \x04- \x04CTPLevel : ",CTPLevel,"    iv.PLevel : ",iv.PLevel[i+1]," \x07』"})
	--DisplayPrint(i, {"\x13\x07『 \x03SYSTEM Message \x04- \x04CTStatP : ",CTStatP,"    CTStatP2 : ",CTStatP2," \x07』"})

	TriggerX(FP,{CDX(iv.StatTest,2^(6-1),2^(6-1)),LocalPlayerID(i)},{
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayText("LV\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
		DisplayText("\x13\x07『 \x04SCA 아이디, 스타 아이디, 현재 미네랄, 가스 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
		SetMemory(0xCDDDCDDC,SetTo,1);

	})

	CIfEnd()
	NIfXEnd()

	
	--CreateUnitStacked({Deaths(i, AtLeast, 1, 100)},6, 88, 36+i,15+i, i, nil, 1)--제작자 칭호 보유자 스카 6개 추가지급
	
		CTrigger(FP, {CV(iv.BanFlag4[i+1],1,AtLeast)}, {SetCD(iv.CheatDetect,1)})
		CTrigger(FP, {CV(iv.BanFlag3[i+1],1,AtLeast)}, {SetCD(iv.CheatDetect,1)})
		CTrigger(FP, {CV(iv.BanFlag2[i+1],1,AtLeast)}, {SetCD(iv.CheatDetect,1)})
		CTrigger(FP, {CV(iv.BanFlag[i+1],1,AtLeast)}, {SetCD(iv.CheatDetect,1)})
		CTrigger(FP, {CV(iv.BanFlag8[i+1],1,AtLeast)}, {SetCD(iv.CheatDetect,1)})
		CTrigger(FP, {CV(iv.BanFlag7[i+1],1,AtLeast)}, {SetCD(iv.CheatDetect,1)})
		CTrigger(FP, {CV(iv.BanFlag6[i+1],1,AtLeast)}, {SetCD(iv.CheatDetect,1)})
		CTrigger(FP, {CV(iv.BanFlag5[i+1],1,AtLeast)}, {SetCD(iv.CheatDetect,1)})
		TriggerX(FP, {CD(iv.CheatDetect,1),LocalPlayerID(i)}, {
			SetCp(i),
			PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
			DisplayText("LB\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
			DisplayText("\x13\x07『 \x04SCA 아이디, 스타 아이디, 현재 미네랄, 가스 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
			SetMemory(0xCDDDCDDC,SetTo,1);})
			if Limit == 1 then
				CElseX()--레벨이 0일 경우 이쪽으로
			else
				CElseX(SetV(SaveAvTime[i+1],24*60*10))--레벨이 0일 경우 이쪽으로
			end
		
	CIfXEnd()
	--CIfOnce(FP, {CV(iv.PStatVer[i+1],4,AtMost)}) --기존 8시간 적용된 쿨 비례해서 낮춰줌
	--CDiv(FP, LV5Cool[i+1], 8)
	--CIfEnd()
	
	
	CMov(FP,iv.PStatVer[i+1],StatVer)--저장 여부에 관계없이 로드완료시 스탯버전 항목 초기화
		
	if Limit == 1 then --테스트 참가 유저 테스터유저 칭호 지급
		TriggerX(FP, {}, {SetCp(i),DisplayText(StrDesignX("\x07테스트 맵\x04에서의 SCA 로드가 \x10감지\x04되었습니다! 테스트맵 플레이에 협조해 주셔서 감사합니다."), 4)}, {preserved})
		TriggerX(FP, {CVX(iv.TesterFlag[i+1],0,2)}, {SetVX(iv.TesterFlag[i+1],2,2),SetCp(i),DisplayText(StrDesignX("\x07테스터 보상\x04이 지급되었습니다!!!").."\n"..StrDesignX("보상내용 : \x04시즌2 \x1F테스터 \x04칭호(영구지급), \x17DPC(디스코드 코인)"), 4)}, {preserved})
	end
	CIfEnd()



	local CTSwitch = CreateCcode()
	local CTSwitch2 = CreateCcode()
	
	TriggerX(FP,{Deaths(i, Exactly, 1,13),Deaths(i, Exactly, 0,14)},{SetDeaths(i, SetTo, 1,14)},{preserved})

		
	CIf(FP,{CD(SCA.LoadSlot1[i+1],0),CD(SCA.GlobalCheck,3),CD(SCA.LoadCheckArr[i+1],2),Deaths(i, AtLeast, 1,14),})--로드슬롯 프로토콜이 완료되어야됨
if Limit == 1 and SaveLimit == 1 then
	NIfX(FP,{CV(iv.MapMakerFlag[i+1],1,AtLeast),CV(SaveAvTime[i+1],0,AtMost)},{}) -- 저장버튼을 누르거나 자동저장 시스템에 의해 해당 트리거에 진입했을 경우
else
	NIfX(FP,{CV(SaveAvTime[i+1],0,AtMost)},{}) -- 저장버튼을 누르거나 자동저장 시스템에 의해 해당 트리거에 진입했을 경우
end

--NIfX(FP,{CV(CurMission[i+1],3,AtLeast)},{SetV(DPErT[i+1],24*10)}) -- 저장버튼을 누르거나 자동저장 시스템에 의해 해당 트리거에 진입했을 경우
	TriggerX(FP, {SCA.Available(i),Deaths(i, Exactly, 1, 14)}, {SetCp(i),DisplayText(StrDesignX("\x03SCArchive\x04에 \x07게임 데이터\x04를 저장하고 있습니다..."), 4),SetCp(FP)}, {preserved})
	TriggerX(FP,{SCA.Available(i),Deaths(i, Exactly, 1, 14)},{SetDeaths(i, SetTo, 4, 2),SetDeaths(i, SetTo, 2,14),SCA.Reset(i)},{preserved})--저장신호 보내기
	TriggerX(FP,{SCA.Available(i),Deaths(i, Exactly, 2, 14)},{SetDeaths(i, SetTo, 0,14),SetCD(CTSwitch,1),SCA.Reset(i)},{preserved})--저장트리거 닫고 CT작동
	CMov(FP,iv.PLevel2[i+1],iv.PLevel[i+1])
	CIf(FP,CV(iv.MapMakerFlag[i+1],1))--제작자일경우 레벨 1으로 저장후 세팅.
	CMov(FP,PLevelBak,iv.PLevel[i+1])
	CMov(FP,iv.PLevel[i+1],1)
	CIfEnd()
	SCA_DataReset(i)
	CallTrigger(FP,Call_SCA_DataSaveAll)
	CIf(FP,CV(iv.MapMakerFlag[i+1],1))
	CMov(FP,iv.PLevel[i+1],PLevelBak)
	CIfEnd()
	NElseIfX({CV(SaveAvTime[i+1],1,AtLeast)},{SetDeaths(i, SetTo, 0,14)}) -- 조건불만족
	TriggerX(FP, {}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 첫 플레이 시 저장을 하기 위해서는 \x0710분 이상 플레이\x04 하셔야 합니다."), 4),SetCp(FP)}, {preserved})
	if Limit == 1 then
	
	NElseIfX({CV(iv.MapMakerFlag[i+1],0)},{}) -- 조건불만족 - 테스트맵
	TriggerX(FP,{SCA.Available(i),Deaths(i, Exactly, 2, 14)},{SetDeaths(i, SetTo, 0,14),SetCD(CTSwitch,1),SCA.Reset(i)},{preserved})--저장트리거 닫고 CT작동
	TriggerX(FP, {SCA.Available(i),Deaths(i, Exactly, 1, 14)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 테스트맵에서는 게임 데이터를 저장할 수 없습니다..."), 4),SetCp(FP)}, {preserved})
	
	TriggerX(FP,{SCA.Available(i),Deaths(i, Exactly, 1, 14)},{SetDeaths(i, SetTo, 0,14),SetCD(CTSwitch,1),SCA.Reset(i)},{preserved})--저장신호 보내기
	end
	NIfXEnd()
	CIfEnd()





	TriggerX(FP,{CD(iv.StatEff[i+1],1)},{SetCD(iv.StatEffLoc,1)},{preserved})


	
	
	local AutoEnable = {}
	local AutoEnable2 = {}
	local AutoEnable3 = {}
	for j, k in pairs(LevelUnitArr) do
		table.insert(AutoEnable, SetMemX(Arr(AutoEnchArr2,((j-1)*8)+i), SetTo, 1))
		
		Trigger2X(FP, {Command(i,AtLeast,1,k[2])}, AutoEnable)


		
		TriggerX(FP,{Command(i,AtLeast,1,k[2]),MemX(Arr(AutoEnchArr,((j-1)*8)+i), Exactly, 1)},{ModifyUnitEnergy(All, k[2], i, 64, 1)},{preserved})
		--TriggerX(FP,{Command(i,AtLeast,1,k[2]),MemX(Arr(AutoSellArr,((j-1)*7)+i), Exactly, 1)},{Order(UID, i, 36+i, Move, i+73)},{preserved})


	end



		CIfEnd()
	end
--	if Limit == 1 then
--		local TempV = CreateVar(FP)
--		local TempV2 = CreateVar(FP)
--		CMov(FP,TempV2,CurrentOP,1)
--		for i = 0, 7 do
--			f_Read(FP, 0x58A364+(48*1)+(4*i), TempV)
--			
--			DisplayPrint(i, {"CurrentOP : ",TempV2,"P    SCA_LastMessage = ",TempV,"   ",})
--			DisplayPrint(i, {SCA.YearV,".",SCA.MonthV,".",SCA.DayV,". ",SCA.HourV," : ",SCA.MinV,"   Week : ",SCA.WeekV})--
--		end
--	end
end