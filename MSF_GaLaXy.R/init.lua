
function init()
	
	-- Balance
	MarDamageFactor = 1 -- ����ü�� 2�� �����ؼ� ������ ������ ��ߵ�
	MarDamageAmount = 30 -- ����ü�� 2�� �����ؼ� ������ ������ ��ߵ�
	NMarDamageFactor = 1 -- ����ü�� 2�� �����ؼ� ������ ������ ��ߵ�
	NMarDamageAmount = 20 -- ����ü�� 2�� �����ؼ� ������ ������ ��ߵ�
	AtkFactor = 7
	DefFactor = 2
	GunLimit = 1500
	Ex1= {20,23,26,29,32,35,38}

	--System
	GiveRate2 = {1000, 5000, 10000, 50000,100000,500000}  
	SpeedV = {0x2A,0x24,0x20,0x1D,0x19,0x15,0x11,0xC,0x8,0x4} 
	ColorCode = {0x08,0x0E,0x0F,0x10,0x11,0x15,0x16}
	HumanPlayers = {0,1,2,3,4,5,6,P9,P10,P11,P12}
	MapPlayers = {0,1,2,3,4,5,6}
	ObPlayers = {P9,P10,P11,P12}
	MedicTrig = {34,9,2,3}
	EXCC_Forward = 0x2FFF
	
	CC_Header = CreateVar2({"X",EXCC_Forward,0x15C,1,2},FP)
	ObEff = 84
	nilunit = 181
	ZergGndUArr = {51,53,54,48,104}
	
	--MSQC_ButtonSet
	ESC = 199
	RIGHT = 200
	LEFT = 201
	F12 = 202
	F9 = 203
	B = 204

	Str12 = CreateCText(FP,"\x12\x07�� \x0d\x0d\x0d\x0d\x0d\x0d\x0d")
	Str22 = CreateCText(FP,"\x04 �̳׶��� �Һ��Ͽ� �� \x0d\x0d\x0d\x0d\x0d\x0d")
	Str23 = CreateCText(FP,"\x04 \x04ȸ ���׷��̵带 �Ϸ��Ͽ����ϴ�. \x07��\x0d\x0d\x0d\x0d\x0d\x0d")
	Str24 = CreateCText(FP,"\x07��\x0d\x0d\x0d\x0d\x0d\x0d")
	
	f_GunT = CreateCText(FP,"\x07�� \x03TESTMODE OP \x04: f_Gun Suspend ����. f_Gun ������ : ")
	f_GunErrT = CreateCText(FP,"\x07�� \x08ERROR \x04: G_CAPlot Not Found. f_Gun ������ : ")
	f_GunFuncT = CreateCText(FP,"\x07�� \x03TESTMODE OP \x04: G_CAPlot Suspended. f_Gun ������ : ")
	f_GunSendT = CreateCText(FP,"\x07�� \x03TESTMODE OP \x04: f_GunSend ����. f_Gun ������ : ")
	f_GunSendT2 = CreateCText(FP,"\x07�� \x03TESTMODE OP \x04: ������ f_GunSend�� EXCunit Number : ")
	f_GunSendErrT = CreateCText(FP,"\x07�� \x08ERROR \x04: G_CAPlot Send Failed. f_Gun ������ : ")
	f_RepeatErr = "\x07�� \x08ERROR : \x04f_Repeat���� ������ �߻��߽��ϴ�! ��ũ�������� �����ڿ��� �������ּ���!\x07 ��"
	f_RepeatErr2 = "\x07�� \x08ERROR : \x04Set_Repeat���� �߸��� UnitID(0)�� �Է¹޾ҽ��ϴ�! ��ũ�������� �����ڿ��� �������ּ���!\x07 ��"
	G_SendErrT = "\x07�� \x08ERROR : \x04f_Gun�� ����� ���� �� G_Send�� ������ �� �����ϴ�! ��ũ�������� �����ڿ��� �������ּ���!\x07 ��"
	f_ReplaceErrT = "\x07�� \x08ERROR : \x04ĵ������ ���� f_Replace�� ������ �� �����ϴ�! ��ũ�������� �����ڿ��� �������ּ���!\x07 ��"
	f_RepeatTypeErr = "\x07�� \x08ERROR : \x04�߸��� RepeatType�� �ԷµǾ����ϴ�! ��ũ�������� �����ڿ��� �������ּ���!\x07 ��"
	

	_0D = string.rep("\x0D",200) 
	HTextStr = _0D
	XSpeed = {"\x15#X0.5","\x05#X1.0","\x0E#X1.5","\x0F#X2.0","\x18#X2.5","\x10#X3.0","\x11#X3.5","\x08#X4.0","\x1C#X4.5","\x1F#X5.0"}
	PlayerString = {"\x08P1","\x0EP2","\x0FP3","\x10P4","\x11P5","\x15P6","\x16P7"} 
	P = {"\x081��","\x0E2��","\x0F3��","\x104��","\x115��","\x156��","\x167��"}
	P8VOFF = "Turn OFF Shared Vision for Player 8"
	P8VON = "Turn ON Shared Vision for Player 8"
	JYD = "Set Unit Order To: Junk Yard Dog" 
	DelayMedicT = {
		"\x1E�� \x1D����޵�\x04�� \x1B2Tick\x04���� �����մϴ�. - \x1F300 Ore\x1E ��",
		"\x1E�� \x1D����޵�\x04�� \x1B3Tick\x04���� �����մϴ�. - \x1F350 Ore\x1E ��",
		"\x1E�� \x1D����޵�\x04�� \x1B4Tick\x04���� �����մϴ�. - \x1F400 Ore\x1E ��",
		"\x1E�� \x1D����޵�\x04�� \x1B��Ȱ��ȭ(1Tick)\x04�Ͽ����ϴ�. - \x1F250 Ore\x1E ��"}

		
	--Gun_SVA = CreateSVArr(16,64,FP)
	--G_CA_SVA = CreateSVArr(16,64,FP)
	EXCunitTemp = CreateVarArr(10,FP)
	f_GunNum = CreateVar(FP)
	Actived_Gun = CreateVar(FP)
	SoundLimitT = CreateCCode()
	SoundLimit = CreateCCode()
	BackupCp = CreateVar(FP)
	CPosX,CPosY,CPos = CreateVars(3,FP)
	count,count1,count2,count3 = CreateVars(4,FP)
	Gun_Type = CreateVar(FP)
	CurCunitI = CreateVar(FP)
	G_TempH = CreateVar(FP)
	G_TempW = CreateVar(FP)
	G_InputH = CreateVar2({"X",0x500,0x15C,1,0},FP)
	CA2ArrX = CreateVArr(1700,FP)
	CA2ArrY = CreateVArr(1700,FP)
	CA2ArrZ = CreateVArr(10,FP)
    SpeedVar = CreateVar2(4,FP)
    CurrentSpeed = CreateVar(FP)
	ZergGndVArr = CreateVarray(FP,#ZergGndUArr)
	TempRandRet,InputMaxRand,Oprnd = CreateVars(3,FP)
	Gun_TempSpawnSet1,Repeat_TempV,RepeatType = CreateVars(3,FP)
	Var_InputCVar = {}
	Var_Lines = 55
	Var_TempTable = CreateVarArr(Var_Lines,FP)
	for i = 1, Var_Lines do
		table.insert(Var_InputCVar,SetCVar(FP,Var_TempTable[i][2],SetTo,0))
	end

	f_GunSendStrPtr,f_GunSendStrPtr2,G_CA_StrPtr,G_CA_StrPtr2,G_CA_StrPtr3,f_GunStrPtr,UPCompStrPtr = CreateVars(7,FP)
	
	RepHeroIndex,Gun_LV,CunitP,CunitIndex = CreateVars(4,FP)

end

function onInit_EUD()
	CIfOnce(FP)
	local CTrigPatchTable = {}
	local PatchArr = {}
		for i = 1, #ZergGndUArr do
			table.insert(CTrigPatchTable,SetVArrayX(VArr(ZergGndVArr,i-1),"Value",SetTo,ZergGndUArr[i]))
		end
		for i = 0, 6 do
			table.insert(PatchArr,SetMemory(0x5821A4 + (4*i),SetTo,GunLimit*2))
			table.insert(PatchArr,SetMemory(0x582144 + (4*i),SetTo,GunLimit*2))
		end
		DoActions2(FP,PatchArr)
		DoActions2X(FP,CTrigPatchTable)
		f_GetStrXptr(FP,UPCompStrPtr,"\x0D\x0D\x0DUPC".._0D)
		f_GetStrXptr(FP,f_GunStrPtr,"\x0D\x0D\x0Df_Gun".._0D)
		f_GetStrXptr(FP,G_CA_StrPtr,"\x0D\x0D\x0DG_CA_Err".._0D)
		f_GetStrXptr(FP,G_CA_StrPtr2,"\x0D\x0D\x0DG_CA_Func".._0D)
		f_GetStrXptr(FP,G_CA_StrPtr3,"\x0D\x0D\x0DG_CA_SendError".._0D)
		f_GetStrXptr(FP,f_GunSendStrPtr,"\x0D\x0D\x0Df_GunSend".._0D)
		f_GetStrXptr(FP,f_GunSendStrPtr2,"\x0D\x0D\x0Df_GunSend2".._0D)
		Print_All_CTextString(FP)

		f_MemCpy(FP,UPCompStrPtr,_TMem(Arr(Str12[3],0),"X","X",1),Str12[2])
		--f_MemCpy(FP,_Add(UPCompStrPtr,Str12[2]-3),_TMem(Arr(UpCompTxt,0),"X","X",1),5*4)
		f_MemCpy(FP,_Add(UPCompStrPtr,Str12[2]+20),_TMem(Arr(Str22[3],0),"X","X",1),Str22[2])
		--f_MemCpy(FP,_Add(UPCompStrPtr,Str12[2]-3+20+Str22[2]-3),_TMem(Arr(UpCompRet,0),"X","X",1),5*4)
		f_MemCpy(FP,_Add(UPCompStrPtr,Str12[2]+20+Str22[2]-3+20),_TMem(Arr(Str23[3],0),"X","X",1),Str23[2])
	
		f_MemCpy(FP,f_GunStrPtr,_TMem(Arr(f_GunT[3],0),"X","X",1),f_GunT[2])
		f_MemCpy(FP,G_CA_StrPtr,_TMem(Arr(f_GunErrT[3],0),"X","X",1),f_GunErrT[2])
		f_MemCpy(FP,G_CA_StrPtr2,_TMem(Arr(f_GunFuncT[3],0),"X","X",1),f_GunFuncT[2])
		f_MemCpy(FP,f_GunSendStrPtr,_TMem(Arr(f_GunSendT[3],0),"X","X",1),f_GunSendT[2])
		f_MemCpy(FP,f_GunSendStrPtr2,_TMem(Arr(f_GunSendT2[3],0),"X","X",1),f_GunSendT2[2])
		f_MemCpy(FP,G_CA_StrPtr3,_TMem(Arr(f_GunSendErrT[3],0),"X","X",1),f_GunSendErrT[2])
	
		f_MemCpy(FP,_Add(f_GunStrPtr,f_GunT[2]+20),_TMem(Arr(Str24[3],0),"X","X",1),Str24[2])
		
	CMov(FP,0x6509B0,19025+19)
	CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
		CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,AtMost,7,0,0xFF)})
			f_SaveCp()
			CIf(FP,{TTMemory(_Add(BackupCp,6),NotSame,58)}) -- ��Ű�� ������
				f_Read(FP,_Sub(BackupCp,9),CPos)
				f_Read(FP,_Sub(BackupCp,17),CunitP)
				f_Div(FP,CunitP,_Mov(256))
				f_Read(FP,_Add(BackupCp,6),RepHeroIndex)
				CMov(FP,Gun_LV,0)
				CIf(FP,TTOR({CVar(FP,RepHeroIndex[2],Exactly,133),CVar(FP,RepHeroIndex[2],Exactly,132),CVar(FP,RepHeroIndex[2],Exactly,131)}))
				CMov(FP,Gun_LV,CunitP)
				CIfEnd()
				CMov(FP,CunitIndex,_Div(_Sub(BackupCp,19025+19),_Mov(84)))
				CDoActions(FP,{
					--TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(CC_Header,((0x20*8)/4))),SetTo,1),
					TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),CC_Header),SetTo,Gun_LV)})
			CIfEnd()
			f_LoadCp()
		CIfEnd()
		CAdd(FP,0x6509B0,84)
	CWhileEnd()
	CMov(FP,0x6509B0,FP)

	CIfEnd()
end