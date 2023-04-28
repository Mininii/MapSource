function GlobalBoss()
    
	local PLevel = iv.PLevel--CreateVarArr2(7,1,FP)-- �ڽ��� ���� ����
	local B_IncomeMax = iv.B_IncomeMax--CreateVar(FP)
	local B_TotalEPer = iv.B_TotalEPer--CreateVar(FP)
	local B_TotalEPer2 = iv.B_TotalEPer2--CreateVar(FP)
	local B_TotalEPer3 = iv.B_TotalEPer3--CreateVar(FP)
	local B_Stat_EXPIncome = iv.B_Stat_EXPIncome--CreateVar(FP)
	local B_Stat_Upgrade = iv.B_Stat_Upgrade
	local B_Credit = iv.B_Credit--CreateVar(FP)
	local B_PCredit = iv.B_PCredit--CreateVar(FP)
	local B_Ticket = iv.B_Ticket--CreateVar(FP)
	local B_PTicket = iv.B_PTicket--CreateVar(FP)
	local CT_PLevel = iv.CT_PLevel
	local SaveRemind = iv.SaveRemind
	local BossLV = iv.BossLV-- CreateVar(FP)
	local LV5Cool = iv.LV5Cool
	local Time = iv.Time
	local PBossClearFlag = iv.PBossClearFlag

--Trigger2X(FP,{CV(BossLV,5,AtLeast)},{SetCountdownTimer(Add, 60*60*24),RotatePlayer({DisplayExtText(StrDesignX("\x1F���� LV.5\x04�� Ŭ�����Ͽ����ϴ�. �������� \x1Fī��Ʈ�ٿ� Ÿ�̸� 24�ð�\x04���� \x1F5���\x04�� ����˴ϴ�."),4)}, Force1, FP)})
--if TestStart == 0 then
--	TriggerX(FP,{CountdownTimer(AtLeast, 1)},{SetMemory(0x5124F0,SetTo,0x4)},{preserved})--ī��Ʈ�ٿ� Ÿ�̸� �����
--	TriggerX(FP,{CV(SpeedV,0),CountdownTimer(AtMost, 0)},{SetMemory(0x5124F0,SetTo,0x15)},{preserved})--4����� �Ȼ������
--	TriggerX(FP,{CV(SpeedV,1),CountdownTimer(AtMost, 0)},{SetMemory(0x5124F0,SetTo,13)},{preserved})--4����� �������
--end

CMov(FP,B_Credit,0)
CMov(FP,B_Ticket,0)

--"\x13\x04\x1B- �η�. \x08��Ƽ ���� ���� ���� ��� \x1B-",
--"\x041�ܰ� \x04: \x0F+1�� Ȯ�� \x07+1.0%p, \x1B����� \x07+6,",
--"\x042�ܰ� \x04: \x0F+1�� Ȯ�� \x07+1.0%p, \x1B����� \x07+6,\x08���ݷ� + 50%, \x17ũ���� +500",
--"\x043�ܰ� \x04: \x17ũ���� +1,000, \x1C�߰�EXP +30%",
--"\x044�ܰ� \x04: \x17���� �Ǹű� + 50, \x08���ݷ� + 50%, ",
--"\x045�ܰ� \x04: \x17ũ���� + \x07�ڽ��� ���� \x1F*\x17 100\x08(\x17�ִ� 5�� ũ����\x08, ��Ƽ �÷��� �ÿ��� ����)",
--"\x045�ܰ� ������ \x072�� �̻� �÷���\x04�� �ƴϸ� \x08���� �Ұ����մϴ�."

Trigger2X(FP,{CV(BossLV,1,AtLeast)},{
	AddV(B_IncomeMax,6),--����� ���ּ� 6 ����
	AddV(B_TotalEPer,1000),--��ȭȮ�� +1.0%p
	SetV(Time,(300000)-5000),SetCD(SaveRemind,1),RotatePlayer({DisplayExtText(StrDesignX("\x081�ܰ� ��Ƽ����\x04�� Ŭ�����Ͽ����ϴ�. \x07��� �� �ڵ�����˴ϴ�..."),4)}, Force1, FP)
})
Trigger2X(FP,{CV(BossLV,2,AtLeast)},{
	AddV(B_IncomeMax,6),--����� ���ּ� 6 ����
	AddV(B_TotalEPer,1000),--��ȭȮ�� +1.0%p
	AddV(B_Credit,500),--ũ���� 200
	AddV(B_Stat_Upgrade,5),
	SetV(Time,(300000)-5000),SetCD(SaveRemind,1),RotatePlayer({DisplayExtText(StrDesignX("\x082�ܰ� ��Ƽ����\x04�� Ŭ�����Ͽ����ϴ�. \x07��� �� �ڵ�����˴ϴ�..."),4)}, Force1, FP)
})
Trigger2X(FP,{CV(BossLV,3,AtLeast)},{
	AddV(B_Credit,1000),--ũ���� 1000
	AddV(B_Stat_EXPIncome,3), -- �ǸŽ� ����ġ 30% ����
	SetV(Time,(300000)-5000),SetCD(SaveRemind,1),RotatePlayer({DisplayExtText(StrDesignX("\x083�ܰ� ��Ƽ����\x04�� Ŭ�����Ͽ����ϴ�. \x07��� �� �ڵ�����˴ϴ�..."),4)}, Force1, FP)
})
Trigger2X(FP,{CV(BossLV,4,AtLeast)},{
	AddV(B_Stat_Upgrade,5),
	AddV(B_Ticket,50);
	SetV(Time,(300000)-5000),SetCD(SaveRemind,1),RotatePlayer({DisplayExtText(StrDesignX("\x084�ܰ� ��Ƽ����\x04�� Ŭ�����Ͽ����ϴ�. \x07��� �� �ڵ�����˴ϴ�..."),4)}, Force1, FP)
})
AddLV5Cool2=CreateCcodeArr(7)
Trigger2X(FP,{CV(BossLV,5,AtLeast)},{
	AddV(B_Credit,50000);
	SetV(Time,(300000)-5000),SetCD(SaveRemind,1),RotatePlayer({DisplayExtText(StrDesignX("\x085�ܰ� ��Ƽ����\x04�� Ŭ�����Ͽ����ϴ�. \x07��� �� �ڵ�����˴ϴ�..."),4)}, Force1, FP)
})
Trigger2X(FP,{CV(BossLV,6,AtLeast)},{
	AddV(iv.PETicket2[1], 1),
	AddV(iv.PETicket2[2], 1),
	AddV(iv.PETicket2[3], 1),
	AddV(iv.PETicket2[4], 1),
	AddV(iv.PETicket2[5], 1),
	AddV(iv.PETicket2[6], 1),
	AddV(iv.PETicket2[7], 1),
	SetV(Time,(300000)-5000),SetCD(SaveRemind,1),RotatePlayer({DisplayExtText(StrDesignX("\x1DExtra Boss\x04�� Ŭ�����Ͽ����ϴ�. \x07��� �� �ڵ�����˴ϴ�..."),4)}, Force1, FP)
})
Trigger2X(FP, {CDX(PBossClearFlag,1,1)}, {SetV(B_Credit,50000);RotatePlayer({DisplayExtText(StrDesignX("\x08�������� \x1C6�ܰ� ���κ���\x04�� óġ�Ͽ����ϴ�. ��ü ���� - \x17ũ���� + 50,000."), 4)}, Force1,FP)})
Trigger2X(FP, {CDX(PBossClearFlag,2,2)}, {SetV(B_Credit,50000);RotatePlayer({DisplayExtText(StrDesignX("\x08�������� \x1F7�ܰ� ���κ���\x04�� óġ�Ͽ����ϴ�. ��ü ���� - \x17ũ���� + 50,000."), 4)}, Force1,FP)})
--Trigger2X(FP, {CDX(PBossClearFlag,4,4)}, {SetV(B_Credit,100000);RotatePlayer({DisplayExtText(StrDesignX("\x08�������� \x1E8�ܰ� ���κ���\x04�� óġ�Ͽ����ϴ�. ��ü ���� - \x17ũ���� + 100,000."), 4)}, Force1,FP)})
--Trigger2X(FP, {CDX(PBossClearFlag,8,8)}, {SetV(B_Credit,200000);RotatePlayer({DisplayExtText(StrDesignX("\x08�������� \x1D9�ܰ� ���κ���\x04�� óġ�Ͽ����ϴ�. ��ü ���� - \x17ũ���� + 200,000."), 4)}, Force1,FP)})

BossEPD = CreateVar(FP)
BossDPM = CreateWar(FP)
DPSArr2 = CreateArr(1441, FP)
DPSCheckV = CreateVar(FP)
DpsDest = CreateVar(FP)
DPSCheck = CreateCcode()
DPSCheck2 = CreateVar(FP)
TotalDPM = CreateWar(FP)
CIf(FP,CV(BossEPD,19025,AtLeast),AddCD(DPSCheck,1))
BossClearCheck = def_sIndex()
NJump(FP, BossClearCheck, {TMemoryX(_Add(BossEPD,17), Exactly, 0, 0xFF00)}, {SetV(BossEPD,0)})

TriggerX(FP,{CV(DPSCheck2,1440,AtLeast)},{SetV(DPSCheck2,0)},{preserved})

CIfX(FP, {CV(BossLV,5)})

CIfX(FP,{TMemory(BossEPD,AtMost,(8319999*256)+128)})
	f_Read(FP, BossEPD, DPSCheckV)
	CMov(FP,DpsDest,_Sub(_Mov(8320000*256),DPSCheckV))
	CTrigger(FP,{},{TSetMemory(BossEPD,SetTo,8320000*256)},1)
	--if Limit == 1 then
	--	DisplayPrint(AllPlayers,{"Dmg256 : ",DpsDest})
	--end
	CrShift(FP, DpsDest, 7)
	--if Limit == 1 then
	--	DisplayPrint(AllPlayers,{"Dmg1 : ",DpsDest})
	--end
	CElseX()
	CMov(FP,DpsDest,0)
	CIfXEnd()

CElseX()

	CIfX(FP,{TMemory(BossEPD,AtMost,8319999*256)})
	f_Read(FP, BossEPD, DPSCheckV)
	CMov(FP,DpsDest,_Sub(_Mov(8320000*256),DPSCheckV))
	CTrigger(FP,{},{TSetMemory(BossEPD,SetTo,8320000*256)},1)
	CrShift(FP, DpsDest, 8)
	CElseX()
	CMov(FP,DpsDest,0)
	CIfXEnd()

CIfXEnd()


if TestStart == 1 then
	--CMov(FP,0x57f0f0,DpsDest)
	--CMov(FP,0x57f120,_ReadF(ArrX(DPSArr2,DPSCheck2)))
end

f_LMov(FP,TotalDPM,_LAdd(TotalDPM,{DpsDest,0}))
CIfX(FP, {CV(BossLV,5)})
CElseX()
f_LMov(FP,TotalDPM,_LSub(TotalDPM,{_ReadF(ArrX(DPSArr2,DPSCheck2)),0}))
CMovX(FP,ArrX(DPSArr2,DPSCheck2),DpsDest,nil,nil,nil,1)
DoActionsX(FP,{AddV(DPSCheck2,1)})
CIfXEnd()


NJumpEnd(FP, BossClearCheck)
CIfEnd()
BossFuncJump = def_sIndex()
CJump(FP, BossFuncJump)
ResetBDPMArr=SetCallForward()
SetCall(FP)

f_LMov(FP,TotalDPM,"0")
CFor(FP, 0, 1441, 1)
local CI = CForVariable()
CMovX(FP,ArrX(DPSArr2,DPSCheck2),DpsDest,nil,nil,nil,1)
CMov(FP,ArrX(DPSArr2,CI),0,nil,nil,1)
CForEnd()



SetCallEnd()
CJumpEnd(FP, BossFuncJump)
for j,k in pairs(BossArr) do
	local cond
	if j==6 then
		cond = {Memory(0x628438,AtLeast,1),CV(BossEPD,0),CV(BossLV,j-1),CD(iv.PartyBonus,2,AtLeast),}--
	else
		cond = {Memory(0x628438,AtLeast,1),CV(BossEPD,0),CV(BossLV,j-1)}
	end
	NIfOnce(FP,cond)--������ �ǹ� ����
	f_Read(FP, 0x628438, nil, Nextptrs)
	CDoActions(FP, {CreateUnit(1,k[1],110,FP),SetV(BossEPD,_Add(Nextptrs,2))})
	CSub(FP,CurCunitI,Nextptrs,19025)
	f_Div(FP,CurCunitI,_Mov(84))
	CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,0,SetTo,_Add(CT_GNextRandV,k[1]))})
	CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,1,SetTo,CT_GNextRandV)})
	CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,2,SetTo,_Add(CT_GNextRandV,FP))})
	f_LMov(FP,BossDPM,k[2])
	CallTrigger(FP, ResetBDPMArr)
	NIfEnd()
	local ClearJump = def_sIndex()
	NJump(FP,ClearJump,{CV(BossLV,j,AtLeast)})
	CIf(FP,{TTNWar(TotalDPM, AtLeast, BossDPM)})
	DoActionsX(FP,{KillUnit(k[1],FP),AddV(BossLV,1),SetV(BossEPD,0)})
	f_LMov(FP,TotalDPM,"0",nil,nil,1)
	CIfEnd()
	NJumpEnd(FP,ClearJump)
end
--DoActions(FP, SetInvincibility(Disable, BossArr[5][1], FP, 64))
--for i = 0,6 do
--	
--	TriggerX(FP, {HumanCheck(i,1),CV(LV5Cool[i+1],1,AtLeast);}, {SetInvincibility(Enable, BossArr[5][1], FP, 64)},{preserved})
----	TriggerX(FP, {HumanCheck(i,1),CD(SCA.LoadCheckArr[i+1],1,AtMost)}, {SetInvincibility(Enable, BossArr[5][1], FP, 64)},{preserved})--
--

--	
--end
end
