
-- to DeskTop : Curdir="C:\\Users\\USER\\Documents\\"
-- to LAPTOP : Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
--__MapDirSetting(__encode_cp949("C:\\euddraft0.9.2.0")) -- 맵파일 경로(\를 \\로 바꿔야함)
--__SubDirSetting(__encode_cp949(Curdir.."MapSource\\MSF_Breeze")) -- Main.lua 폴더경로 (\를 \\로 바꿔야함, 없으면 비우기)
--속도측정용
--local x = os.clock()
----------------------------------------------Loader Space ---------------------------------------------------------------------


--Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
EXTLUA = "dir \""..Curdir.."\\MapSource\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$"  then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\Library\\"..dir))
		InitEXTLua()
     end
end

EXTLUA = "dir \""..Curdir.."\\MapSource\\MSF_Breeze\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "main.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\MSF_Breeze\\"..dir))
		InitEXTLua()
     end
end
------------------------------------------------------------------------------------------------------------------------------

VerText = "\x04Ver. 1.8_EVF"
EVFPtsMul = 2
EVFMode = 1
TestSet(0)
if Limit == 1 then
	VerText = VerText.."T"
	
end

FP = P8
EUDTurbo(FP)
SetForces({P1,P2,P3,P4,P5,P6,P7},{P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(FP)
Enable_HumanCheck()
Trigger2(FP,{HumanCheck(0,0),HumanCheck(1,0),HumanCheck(2,0),HumanCheck(3,0),HumanCheck(4,0),HumanCheck(5,0),HumanCheck(6,0)},{Defeat()})
StartCtrig(1,FP,nil,1,"C:\\Temp")
DP_Start_init(FP)
init_func = def_sIndex()
CJump(AllPlayers,init_func)
	DUnitCalc = Install_EXCC(FP,15,1)
	Include_CtrigPlib(360,"Switch 100")
	Install_BackupCP(FP)
	Include_CBPaint()
	Include_Vars()
	Include_Conv_CPosXY(FP,{96*32,64*32})
	Install_GetCLoc(FP,0,nilunit)
	Include_CRandNum(FP)
	Include_G_CA_Library(2,0x600,32)
	Shape()
	S_3 = G_CAPlot(S_3_ShT)
	S_4 = G_CAPlot(S_4_ShT)
	S_5 = G_CAPlot(S_5_ShT)
	S_6 = G_CAPlot(S_6_ShT)
	S_7 = G_CAPlot(S_7_ShT)
	S_8 = G_CAPlot(S_8_ShT)
	P_3 = G_CAPlot(P_3_ShT)
	P_4 = G_CAPlot(P_4_ShT)
	P_5 = G_CAPlot(P_5_ShT)
	P_6 = G_CAPlot(P_6_ShT)
	P_7 = G_CAPlot(P_7_ShT)
	P_8 = G_CAPlot(P_8_ShT)
	Cir = G_CAPlot(Cir)
	if #G_CAPlot_Shape_InputTable >= 256 then
		PushErrorMsg("G_CAPlot_Shape_InputTable_is_Full")
	end
	G_CAPlot2(G_CAPlot_Shape_InputTable)
Install_Load_CAPlot()
Install_Call_G_CA()
G_CA_Lib_ErrorCheck()

GiveAlarm = SetCallForward()
GivePrevP = CreateVar(FP)
GiveNextP = CreateVar(FP)
GiveMin = CreateVar(FP)
SetCall(FP)
DisplayPrint(GivePrevP, {"\x07『 ",PName(GiveNextP),"\x04에게 \x1F",GiveMin," Ore\x04를 기부하였습니다. \x07』"})
DisplayPrint(GiveNextP, {"\x12\x07『 ",PName(GivePrevP),"\x04에게 \x1F",GiveMin," Ore\x04를 기부받았습니다.\x02 \x07』"})
SetCallEnd()


function CreateBPtrRetArr(MaxPlayer,Ptr,Multiplier)
	local X = {}
	local Y = {}
	for i = 0, MaxPlayer do
		table.insert(X,(Ptr+(i*Multiplier))%4)
		table.insert(Y,(Ptr+(i*Multiplier))-X[i+1])
	end
	return X,Y
end

TempMul_254,TempMul_255,TempMul_1,TempFactor = CreateVars(4,FP)
UpgradeCP,TempUpgradePtr,TempUpgradeMaskRet,UpgradeMax,UpResearched,UpCost,UpCompleted = CreateVariables(8)
UpMaster = CreateCcode()

TempUpgradeLimPtr = CreateVar(FP)
TempUpgradeLimMaskRet = CreateVar(FP)
UpLimit = CreateVar(FP)
UpCount = CreateVar(FP)

AtkUpgradeMaskRetArr, AtkUpgradePtrArr = CreateBPtrRetArr(7,0x58D2B0+7,46)
HPUpgradeMaskRetArr, HPUpgradePtrArr = CreateBPtrRetArr(7,0x58D2B0,46)
AtkUpgradeMaskLimRetArr, AtkUpgradeLimPtrArr = CreateBPtrRetArr(7,0x58D088+7,46)
HPUpgradeMaskLimRetArr, HPUpgradeLimPtrArr = CreateBPtrRetArr(7,0x58D088,46)



function CreateBPtrRetArr(MaxPlayer,Ptr,Multiplier)
	local X = {}
	local Y = {}
	for i = 0, MaxPlayer do
		table.insert(X,(Ptr+(i*Multiplier))%4)
		table.insert(Y,(Ptr+(i*Multiplier))-X[i+1])
	end
	return X,Y
end
OneClickUpgrade = SetCallForward()
UpResultFlag = CreateCcode()--1 = 성공실패여부
MinCostBase = CreateVar(FP)
MinCostFactor = CreateVar(FP)
UpgradeFlag = CreateVar(FP)
SetCall(FP) 
--0x655740 미네랄 코스트 베이스 2바이트
--0x6559C0 미네랄 코스트 증가량 2바이트
	CIfX(FP,{CV(UpgradeFlag,1)})
	f_WreadX(FP, 0x655740, 7, MinCostBase)
	f_WreadX(FP, 0x6559C0, 7, MinCostFactor)
	CElseIfX({CV(UpgradeFlag,2)})

	f_WreadX(FP, 0x655740, 0, MinCostBase)
	f_WreadX(FP, 0x6559C0, 0, MinCostFactor)
	CIfXEnd()


	f_Read(FP,TempUpgradePtr,UpResearched)
	f_Read(FP,TempUpgradeLimPtr,UpLimit)
	CIf(FP,CVar(FP,TempUpgradeLimMaskRet[2],AtMost,256^2))
		CMod(FP,UpLimit,_Mul(TempUpgradeLimMaskRet,_Mov(256)))
	CIfEnd()
	CIf(FP,CVar(FP,TempUpgradeMaskRet[2],AtMost,256^2))
		CMod(FP,UpResearched,_Mul(TempUpgradeMaskRet,_Mov(256)))
	CIfEnd()
	CDiv(FP,UpResearched,TempUpgradeMaskRet)
	CDiv(FP,UpLimit,TempUpgradeLimMaskRet)
	f_Mul(FP,TempMul_254,TempUpgradeMaskRet,_Mov(254))
	f_Mul(FP,TempMul_255,TempUpgradeMaskRet,_Mov(255))
	f_Mul(FP,TempMul_1,TempUpgradeMaskRet,_Mov(1))
	CMov(FP,0x6509B0,UpgradeCP)
	OCU_Jump = def_sIndex()
	CJumpEnd(FP,OCU_Jump)
	CAdd(FP,TempFactor,_Mul(UpResearched,MinCostFactor),MinCostBase)
	NWhile(FP,{
		TCVar(FP,UpResearched[2],AtMost,_Sub(UpLimit,1)),
		TAccumulate(CurrentPlayer,AtLeast,TempFactor,Ore),
		TMemoryX(TempUpgradePtr,AtMost,TempMul_254,TempMul_255)
	})
		CDoActions(FP,{
			TSetCVar(FP,UpCost[2],Add,TempFactor),
			TSetResources(CurrentPlayer,Subtract,TempFactor,Ore),
			SetCVar(FP,UpResearched[2],Add,1),
			SetCVar(FP,UpCompleted[2],Add,1),
			SetCVar(FP, UpCount[2], Add, 1);
			--TSetCVar(FP,UpCost[2],Add,TempFactor),
			TSetMemoryX(TempUpgradePtr,Add,TempMul_1,TempMul_255);
			SetCD(UpResultFlag, 1);
		})
	--DisplayPrint(UpgradeCP, {"\x12\x07『 \x1FUpCount : ",UpCount,"  UpResearched : ",UpResearched,"  UpCompleted : ",UpCompleted," \x07』"})

		CJump(FP,OCU_Jump)
	NWhileEnd()
	CIfX(FP,{CD(UpResultFlag,1)})
	
	DisplayPrint(UpgradeCP, {"\x12\x07『 \x1F",UpCost," \x04미네랄을 소비하여 총 \x19",UpCompleted," \x04회 업그레이드를 완료하였습니다. \x07』"})
	--DisplayPrint(HumanPlayers, {"\x12\x07『 \x1FUpgradeCP : ",UpgradeCP," \x07』"})

	if Limit == 1 then 
	DisplayPrint(UpgradeCP, {"\x12\x07『 \x03TESTMODE OP \x04: 원클릭 업그레이드 테스트 문구  \x07』"})
	DisplayPrint(UpgradeCP, {"\x12\x07『 \x04업글 리미트 : \x1F",UpLimit,"\x04 업글 횟수 : \x1F",UpCount,"  \x07』"})
	DisplayPrint(UpgradeCP, {"\x12\x07『 \x04미네랄 베이스 가격 : \x1F",MinCostBase,"\x04 미네랄 증가량 가격 : \x1F",MinCostFactor,"  \x07』"})
	ResultMinCostBase = CreateVar(FP)
	CAdd(FP,ResultMinCostBase,_Mul(UpResearched,MinCostFactor),MinCostBase)
	DisplayPrint(UpgradeCP, {"\x12\x07『 \x04업글 완료 후 가격 : \x1F",ResultMinCostBase,"  \x07』"})

	end
	CTrigger(FP,{TCVar(FP,UpLimit[2],Exactly,UpResearched)},{
		TSetMemory(0x6509B0,SetTo,UpgradeCP),
		DisplayText("\x12\x07『 \x04업그레이드가 모두 완료되었습니다. \x07』",4),
		SetMemory(0x6509B0,SetTo,FP),SetCD(UpMaster,1)
	},{preserved})
	CElseX()
	CTrigger(FP,{TCVar(FP,UpLimit[2],Exactly,UpResearched)},{
		TSetMemory(0x6509B0,SetTo,UpgradeCP),
		DisplayText("\x12\x07『 \x04이미 업그레이드가 모두 완료되었습니다. \x07』",4),
		SetMemory(0x6509B0,SetTo,FP),SetCD(UpMaster,1)
	},{preserved})
	CTrigger(FP,{TTCVar(FP,UpLimit[2],NotSame,UpResearched),CVar(FP,UpCompleted[2],Exactly,0)},{
		TSetMemory(0x6509B0,SetTo,UpgradeCP),
		DisplayText("\x12\x07『 \x04잔액이 부족합니다. \x07』",4),
		SetMemory(0x6509B0,SetTo,FP)
	},{preserved})
	CIfXEnd()
	DoActionsX(FP,{
		SetCVar(FP,TempUpgradeMaskRet[2],SetTo,0),
		SetCVar(FP,TempUpgradePtr[2],SetTo,0),
		SetCVar(FP,UpResearched[2],SetTo,0),
		SetCVar(FP,UpLimit[2],SetTo,0), 
		SetCVar(FP,UpCount[2],SetTo,0), 
		SetCVar(FP,UpCost[2],SetTo,0),
		SetCVar(FP,UpCompleted[2],SetTo,0)
	})
SetCallEnd()
CJumpEnd(AllPlayers,init_func)

onInit_EUD() -- onPluginStart


Interface()
System()
Waves()

init_Setting()
if Limit == 0 then
	Enable_HideErrorMessage(FP)
end

EndCtrig()
LabelUseCheck()
ErrorCheck()
SetCallErrorCheck()
