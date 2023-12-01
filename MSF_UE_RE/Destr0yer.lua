function Install_Destr0yer()
	--Boss : Destr0yer. Made By Mininii
	--from. MSF_UE
	local IdenSiege,SMine,YamatoShuttle,HackBattle = CreateCcodes(4)
	local ResetCodeT = {IdenSiege,SMine,YamatoShuttle,HackBattle}
	local Lyrics = {
		{"\x0D\x0D!H\x13\x06※ \x04Ladies and Gentlemen \x06※",2,222},
		{"\x0D\x0D!H\x13\x06※ \x07Let's start \x06※",5,0},
		{"\x0D\x0D!H\x13\x06※ \x04Only is in Memories \x06※",8,0},
		{"\x0D\x0D!H\x13\x06※ \x08Tonight. \x06※",12,333},
		{"\x0D\x0D!H\x13\x07♪\x04 I wonder why things have \x03happened\x04. \x07♪\n\x0D\x0D!H\x13\x07♪\x04 왜 \x03이런 일들\x04이 일어났는지 궁금해. \x07♪",60-3,0},
		{"\x0D\x0D!H\x13\x07♪\x04 \x1DCould you imagine \x04the world is \x1Cboring\x04? \x07♪\n\x0D\x0D!H\x13\x07♪\x04 이 세상은 \x1C따분한 \x04걸, \x1D넌 알고 있니? \x07♪",68-3,0},
		{"\x0D\x0D!H\x13\x07♪\x08 Stereotype \x07♪\n\x0D\x0D!H\x13\x07♪\x08 고정관념 \x07♪",76-3,0},
		{"\x0D\x0D!H\x13\x07♪\x0E Sham \x07♪\n\x0D\x0D!H\x13\x07♪\x0E 엉터리 \x07♪",78-3,444},
		{"\x0D\x0D!H\x13\x07♪\x0F Brain Freeze \x07♪\n\x0D\x0D!H\x13\x07♪\x0F 브레인 프리즈 \x07♪",79-3,444},
		{"\x0D\x0D!H\x13\x07♪\x10 Collusion \x07♪\n\x0D\x0D!H\x13\x07♪\x10 공모 \x07♪",80-3,222},
		{"\x0D\x0D!H\x13\x07♪\x1F Mental block \x07♪\n\x0D\x0D!H\x13\x07♪\x1F 정신적 블록 \x07♪",82-3,333},
		{"\x0D\x0D!H\x13\x07♪\x04 The world is \x1Bfading\x04. \x07♪\n\x0D\x0D!H\x13\x07♪\x04 세계는 \x1B사라져 가고\x04, \x07♪",83-3,222},
		{"\x0D\x0D!H\x13\x07♪\x04 I know the \x08( \x11Ｆ\x04ａｔｅ \x08)\x04. \x07♪\n\x0D\x0D!H\x13\x07♪\x04 그 \x08( \x11운\x04명 \x08)\x04 은 난 알고 있어. \x07♪",86-3,333},
		{"\x0D\x0D!H\x13\x07♪\x04 The world is \x1Bfading\x04. \x07♪\n\x0D\x0D!H\x13\x07♪\x04 세계는 \x1B사라지고\x04, \x07♪",88-3,444},
		{"\x0D\x0D!H\x13\x07♪\x04 I know the \x08( \x11Ｆ\x04ａｔｅ \x08)\x04. \x07♪\n\x0D\x0D!H\x13\x07♪\x04 나는 그 \x08( \x11운\x04명 \x08)\x04 을 아는걸. \x07♪",90-3,444},
		{"\x0D\x0D!H\x13\x07♪\x04 I know \x07all of you\x04. \x07♪\n\x0D\x0D!H\x13\x07♪\x04 나는 너희를 \x07모두 아는데\x04, \x07♪",91-3,0},
		{"\x0D\x0D!H\x13\x07♪\x04 Have you, you, \x10followed me\x04? \x07♪\n\x0D\x0D!H\x13\x07♪\x04 너희는, 너희는, 날 \x10쫓아오기라도 했니\x04? \x07♪",95-3,444},
		{"\x0D\x0D!H\x13\x07♪\x04 Me in your mind is the \x1Fdream\x04. \x07♪\n\x0D\x0D!H\x13\x07♪\x04 너희 마음 속의 나는 \x1F꿈\x04인걸. \x07♪",99-3,0},
		{"\x0D\x0D!H\x13\x07♪\x04 The dream of the \x10 ( \x11Ｐ\x04ａｓｔ \x10) \x04. \x07♪\n\x0D\x0D!H\x13\x07♪\x04 \x10 ( \x11과\x04거 \x10) \x04의 꿈. \x07♪",105-3,333},
		{"\x0D\x0D!H\x13\x07♪\x04 So I would \x08forget \x04you. \x07♪\n\x0D\x0D!H\x13\x07♪\x04 난 너희를 \x08잊을\x04테니, \x07♪",107-3,0},
		{"\x0D\x0D!H\x13\x07♪\x11 Let you forget me. \x07♪\n\x0D\x0D!H\x13\x07♪\x11 너희도 날 잊어줘. \x07♪",111-3,0},
		{"\x0D\x0D!H\x13\x07♪\x04 'Cause I'm \x07『 \x08Ｄ\x04ｅｓｔｒ\x10０\x04ｙｅｒ\x07 』 \x07♪\n\x0D\x0D!H\x13\x07♪\x04 왜냐면 나는 \x07『 \x08파\x10괴\x04자\x07 』 \x04이니까. \x07♪",115-3,333},
		{"\x0D\x0D!H\x13\x07♪\x08 I kill us all. \x07♪\n\x0D\x0D!H\x13\x07♪\x08 다 끝장내겠어. \x07♪",138-3,0},
		{"\x0D\x0D!H\x13\x07♪\x10 It's the only way. \x07♪\n\x0D\x0D!H\x13\x07♪\x10 이 길 뿐이야. \x07♪",151-3,333},
		{"\x0D\x0D!H\x13\x07♪\x06 It's over. \x07♪\n\x0D\x0D!H\x13\x07♪\x06 다 끝났어. \x07♪",153-3,0},
		{"\x0D\x0D!H\x13\x07♪\x08 I will kill. \x07♪\n\x0D\x0D!H\x13\x07♪\x08 끝장내겠어. \x07♪",159-3,333},
		{"\x0D\x0D!H\x13\x07♪\x04 I will \x07『 \x08Ｄ\x04ｅｓｔｒ\x10０\x04ｙ\x07 』\x04 the world. \x07♪\n\x0D\x0D!H\x13\x07♪\x04 내가 세상을 \x07『 \x08파\x10괴\x07 』 \x04하겠어. \x07♪",161-3,333},
		{"\x0D\x0D!H\x13\x07♪\x04 No matter what you do, \x0FI don't stop\x04. \x07♪\n\x0D\x0D!H\x13\x07♪\x04 너희가 뭐래도, \x0F멈추지 않아\x04. \x07♪",165-3,500},
		{"\x0D\x0D!H\x13\x07♪\x04 I'm the only one \x1Fwho's right\x04. \x07♪\n\x0D\x0D!H\x13\x07♪\x04 나만이 \x1F진리\x04이기에. \x07♪",168-3,0},
		{"\x0D\x0D!H\x13\x07♪\x08 I will kill. \x07♪\n\x0D\x0D!H\x13\x07♪\x08 끝장내겠어. \x07♪",175-3,333},
		{"\x0D\x0D!H\x13\x07♪\x04 I will \x07『 \x08Ｄ\x04ｅｓｔｒ\x10０\x04ｙ\x07 』\x04 the world. \x07♪\n\x0D\x0D!H\x13\x07♪\x04 내가 세상을 \x07『 \x08파\x10괴\x07 』 \x04하겠어. \x07♪",177-3,444},
		{"\x0D\x0D!H\x13\x07♪\x04 No matter what you do, \x0FI don't stop\x04. \x07♪\n\x0D\x0D!H\x13\x07♪\x04 너희가 뭐래도, \x0F멈추지 않아\x04. \x07♪",181-3,500},
		{"\x0D\x0D!H\x13\x07♪\x15 It is what it is. \x07♪\n\x0D\x0D!H\x13\x07♪\x15 뭐 어쩌겠어. \x07♪",184-3,0},
		{"\x0D\x0D!H\x13\x07♪\x1E It is what it is. \x07♪\n\x0D\x0D!H\x13\x07♪\x1E 원래 이랬는걸. \x07♪",188-3,0},
		{"\x0D\x0D!H\x13\x07♪\x04 It is not. It's not \x08my fault\x04. \x07♪\n\x0D\x0D!H\x13\x07♪\x04 아냐. \x08내 잘못\x04이 아냐. \x07♪",192-3,0},
		}
	local BGMArr = {}
	for i = 1, 272 do
		if i <= 9 then
			table.insert(BGMArr,"staredit\\wav\\LV10_00"..i..".ogg")
		elseif i >= 10 and i<= 99 then
			table.insert(BGMArr,"staredit\\wav\\LV10_0"..i..".ogg")
		else
			table.insert(BGMArr,"staredit\\wav\\LV10_"..i..".ogg")
		end
	end
	local BGMLength = 439
	local BGMVar = 12
	local Length = 666
	local CBulletT = CreateCcode()
	local LockBossUnit = CreateCcode()
	--if TestStart == 1 then
		--CIfX(FP,{Bring(FP,AtLeast,1,186,64)},{SetMemoryX(0x66655C, SetTo, 65536*210,0xFFFF0000),SetCVar(FP,VResetSw5[2],SetTo,0)})
	--else	
		CIfX(FP,{TTOR({Bring(FP,AtLeast,1,186,64),TTAND({DeathsX(FP,AtLeast,1,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,271,BGMLength,0xFFFFFF)})}),CDeaths(FP,Exactly,0,Win)},{SetMemoryX(0x66655C, SetTo, 65536*210,0xFFFF0000),SetCVar(FP,VResetSw5[2],SetTo,0)})
		TriggerX(FP, {Void(1, AtLeast, 1)}, {ModifyUnitHitPoints(All, "Men", Force1, 64, 35)}, {preserved})
	--end
	
			


	
	local TShape = CXMakeShape(96,{0,0,0},{1,1,1},{-1,1,1},{1,-1,1},{1,1,-1},{-1,-1,1},{-1,1,-1},{1,-1,-1},{-1,-1,-1})
	local WhileLaunch = CreateCcode()
	local BursterCall = CreateCcode()
	local BlackBox =CreateCcode()
	local DTotalDmg = CreateVar(FP)
	local TSize = CreateVar(FP)
	local XAngle = CreateVar(FP)
	local YAngle = CreateVar(FP)
	local ZAngle = CreateVar(FP)
	local TCount = CreateVar(FP)
	local TCount2 = CreateVar(FP)
	local Angle1 = CreateVar(FP)
	local Angle2 = CreateVar(FP)
	local Angle3 = CreateVar(FP)
	local Angle4 = CreateVar(FP)
	local Angle5 = CreateVar(FP)
	local Angle6 = CreateVar(FP)
	local Angle7 = CreateVar(FP)
	local Angle8 = CreateVar(FP)
	local Angle9 = CreateVar(FP)
	local SkillW = CreateVar(FP)
	local SkillW2 = CreateVar(FP)
	local SkillW3 = CreateVar(FP)
	local CPosX2 = CreateVar(FP)
	local CPosY2 = CreateVar(FP)
	local RandRet2 = CreateVar(FP)
	local CXTemp1 = CreateVar2(FP,nil,nil,540*3*12)
	local CXTemp2 = CreateVar2(FP,nil,nil,10)
	DoActions(FP,{RotatePlayer({RunAIScript(P8VON)},MapPlayers,FP)})
	CIf(FP,{CVar(FP,DPtr[2],AtLeast,1),CVar(FP,DPtr[2],AtMost,0x7FFFFFFF)})
		CIf(FP,{TTMemory(_Add(DPtr,2),NotSame,DcurHP)})
			f_Read(FP,_Add(DPtr,2),DHP)
			CAdd(FP,DTotalDmg,_Sub(DcurHP,DHP))
			CMov(FP,DcurHP,DHP)
		CIfEnd()
	CIfEnd()
	if Limit == 1 then
		for i = 0, 6 do
			CTrigger(FP,{CD(TestMode,1)},{TSetResources(i, SetTo, DTotalDmg, Gas)},1)
		end
	end
	local PatternCcode = {}
	function Create_PatternCcode(Table)
		local TempCcode = CreateCcode()
		table.insert(Table,TempCcode)
		return TempCcode
	end
	Simple_SetLocX(FP,"DCenter",0,0,32,32,{MoveLocation("DCenter",186,FP,64)})
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{CDeaths(FP,AtLeast,1,LockBossUnit)},{Order(186,FP,64,Move,"DCenter")},{preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,1,LockBossUnit),CDeaths(FP,Exactly,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),MoveUnit(All,186,FP,64,64)},{preserved})
	

	
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{CDeaths(FP,Exactly,0,Pat1)},{
		SetCDeaths(FP,SetTo,1,Pat1),SetInvincibility(Enable,186,P8,64)},{preserved})

	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{CDeaths(FP,Exactly,0,Pat1),DeathsX(FP,AtLeast,1,BGMLength,0xFFFFFF)},{RotatePlayer({
		SetInvincibility(Disable,186,P8,64),
	},HumanPlayers,FP),SetCDeaths(FP,SetTo,1,Pat1)},{preserved})
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{CDeaths(FP,Exactly,0,isSingle),CDeaths(FP,Exactly,0,Pat1),DeathsX(FP,AtLeast,1,BGMLength,0xFFFFFF)},{RotatePlayer({
		CenterView(64),
	},HumanPlayers,FP),SetCDeaths(FP,SetTo,1,Pat1),},{preserved})

	CIf(FP,{DeathsX(FP,AtMost,(66*4),BGMLength,0xFFFFFF)})
		
	local Pat1 = Create_PatternCcode(PatternCcode)
	local CXForward = CAPlotForward()
	Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,0,Pat1)
	},
	actions = {
		SetCVar("X",TCount,SetTo,1);
		SetCVar("X",TSize,SetTo,540*16);
		SetCDeaths(FP,SetTo,1,Pat1);
		PreserveTrigger();
	}
}
Trigger {
		players = {FP},
		conditions = {
			Label(0);
		},
		actions = {
			SetCVar("X",XAngle,Add,11);
			SetCVar("X",YAngle,Add,8);
			SetCVar("X",ZAngle,Add,5);
			SetCVar("X",TCount,SetTo,1);
			PreserveTrigger();
		}
	}
	Trigger {
			players = {FP},
			conditions = {
				Label(0);
				CVar("X",TSize,AtLeast,0x80000000);
			},
			actions = {
				SetCVar("X",TSize,SetTo,0);
				PreserveTrigger();
			}
		}
	
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				CVar("X",TSize,AtLeast,1);
			},
			actions = {
				SetCVar("X",CXForward[5],SetTo,TShape[1]);
				PreserveTrigger();
			}
		}

	function CXfunc()
		local CA = CAPlotDataArr
		local CB = CAPlotCreateArr
		local PlayerID = CAPlotPlayerID

		CX_Ratio(TSize,CXTemp1,TSize,CXTemp1,TSize,CXTemp1)
		CX_Rotate(_Div(XAngle,CXTemp2),_Div(YAngle,CXTemp2),_Div(ZAngle,CXTemp2))
		
		TriggerX(FP, {CVar("X",CA[11],AtLeast,0x80000000)},{
			SetMemoryX(0x669FB4, SetTo, 10*16777216,0xFF000000); -- 화면출력
			SetMemoryX(0x66321C, SetTo, 0*16777216,0xFF000000); -- 높이
		},{preserved})
		TriggerX(FP, {CVar("X",CA[11],AtMost,0x7FFFFFFF)},{
			SetMemoryX(0x669FB4, SetTo, 16*16777216,0xFF000000); -- 화면출력
			SetMemoryX(0x66321C, SetTo, 20*16777216,0xFF000000); -- 높이
		},{preserved})
		TriggerX(FP, {
			CDeaths(FP,Exactly,0,BlackBox);
			CVar("X",CA[11],Exactly,0x0);}, {
				SetMemoryX(0x669FB4, SetTo, 17*16777216,0xFF000000); -- 화면출력
				SetMemoryX(0x66321C, SetTo, 12*16777216,0xFF000000); -- 높이
			},{preserved})
		TriggerX(FP, {
			CDeaths(FP,Exactly,1,BlackBox);
			CVar("X",CA[11],Exactly,0x0);}, {
				SetMemoryX(0x669FB4, SetTo, 10*16777216,0xFF000000); -- 화면출력
				SetMemoryX(0x66321C, SetTo, 12*16777216,0xFF000000); -- 높이
			},{preserved})
		CIf(FP,Memory(0x628438,AtLeast,1))
		f_Read(FP,0x628438,nil,Nextptrs)
		Simple_SetLocX(FP,"Location 1",_Add(V(CA[8]),CPosX),_Add(V(CA[9]),CPosY),_Add(V(CA[8]),CPosX),_Add(V(CA[9]),CPosY),Simple_CalcLoc(0,-32,-32,32,32))
		CDoActions(FP,{
			CreateUnit(1,207, 1,FP),
			TSetMemoryX(_Add(Nextptrs,55),SetTo,0xA00104,0xA00104),
			TSetMemory(_Add(Nextptrs,57),SetTo,0),
		})
		TriggerX(FP,{CDeaths(FP,AtLeast,1,HackBattle)},{CreateUnit(1,121, 1,FP),SetMemory(0x6509B0,SetTo,FP),RunAIScriptAt(JYD,64)},{preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,1,IdenSiege)},{CreateUnit(1,30, 1,FP),SetMemory(0x6509B0,SetTo,FP),RunAIScriptAt(JYD,64)},{preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,1,SMine)},{CreateUnit(1,13, 1,FP),SetMemory(0x6509B0,SetTo,FP),RunAIScriptAt(JYD,64)},{preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,1,YamatoShuttle)},{CreateUnit(1,69, 1,FP),SetMemory(0x6509B0,SetTo,FP),RunAIScriptAt(JYD,64)},{preserved})
		CIfEnd()
	end

	DoActions(FP,{Simple_CalcLoc("DCenter",0,-16,0,-16)})
	GetLocCenter("DCenter",CPosX,CPosY)
	CXPlot(TShape,FP,nilunit,0,{CPosX,CPosY},1,16,{1,0,0,0,9999,0},"CXfunc",FP,Always(),nil,1)
	local ResetActT = {}
	for j, k in pairs(ResetCodeT) do
		table.insert(ResetActT,SetCDeaths(FP,SetTo,0,k))
	end
	DoActionsX(FP,{Simple_CalcLoc("DCenter",0,16,0,16),ResetActT})

	CMov(FP,V(CXForward[6]),1)

	CIfEnd()
	SetRecoverCp()
	RecoverCp(FP)
	Simple_SetLocX(FP,"DCenter",0,0,32,32,{MoveLocation("DCenter",186,FP,64)})
	local LyricsCCode = {}
	for j, k in pairs(Lyrics) do
		local TempCcode = CreateCcode()
		table.insert(LyricsCCode,TempCcode)
		Trigger { -- 상시브금
			players = {FP},
			conditions = {
				Label(0);
				CDeaths(FP,AtMost,0,TempCcode);
				DeathsX(FP,Exactly,k[2],BGMLength,0xFFFFFF);
				DeathsX(FP,AtMost,k[3],BGMVar,0xFFFFFF);
			},
			actions = {
				RotatePlayer({DisplayTextX(k[1],4)},HumanPlayers,FP);
				SetCDeaths(FP,Add,1,TempCcode);
				PreserveTrigger();
				},
			}
	end

	for i = 0, 3 do
		local Pat1 = Create_PatternCcode(PatternCcode)
		CIf(FP,{DeathsX(FP,Exactly,13+i,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1)})
			CSPlot(CSMakePolygon(32,160,0,33,1),FP,193,"DCenter",nil,1,32,FP,nil,nil,1)
			CSPlot(CSMakePolygon(32,160,0,33,1),FP,94,"DCenter",nil,1,32,FP,nil,nil,1)
			DoActionsX(FP,{SetMemoryB(0x6636B8 + 193, SetTo, 130),SetInvincibility(Enable,193,P8,64),GiveUnits(All,94,P8,64,P11),GiveUnits(All,193,P8,64,P11),Order(94,P11,64,Move,"DCenter"),Order(193,P11,64,Move,"DCenter")})
			if i == 0 then
				local Randnum = f_CRandNum(256)
				CMov(FP,Angle1,Randnum)
				CMov(FP,Angle2,Randnum,13)
				CMov(FP,Angle3,Randnum,13*2)
				CiSub(FP,Angle4,Randnum,13)
				CiSub(FP,Angle5,Randnum,13*2)
			end
		CIfEnd()
	end
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,13,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetMemoryW(0x657998+(127*2), SetTo, 0);SetMemoryX(0x665E44, SetTo, 0,0xFF000000)},{preserved})
	CIf(FP,{DeathsX(FP,AtLeast,13,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,19,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,CBulletT)})
		GetLocCenter("DCenter",CPosX,CPosY)
		CreateBullet(208,20,Angle1,CPosX,CPosY)
		CreateBullet(208,20,Angle2,CPosX,CPosY)
		CreateBullet(208,20,Angle3,CPosX,CPosY)
		CreateBullet(208,20,Angle4,CPosX,CPosY)
		CreateBullet(208,20,Angle5,CPosX,CPosY)
		--CreateBullet(208,20,Angle6,CPosX,CPosY)
	CIfEnd()
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,17,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),KillUnit(94,P11),SetMemoryW(0x657998+(127*2), SetTo, 3);SetMemoryX(0x665E44, SetTo, 16777216,0xFF000000),SetVoid(1, SetTo, 1)},{preserved})
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,20,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetMemoryW(0x657998+(208*2), SetTo, 0);SetMemoryX(0x665E44, SetTo, 0,0xFF000000),SetMemory(0x6509B0, SetTo, FP),GiveUnits(All,193,P11,64,P8),RunAIScriptAt(JYD,64),SetVoid(1, SetTo, 0)},{preserved})
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,21,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetMemoryB(0x6636B8 + 193, SetTo, 55),SetInvincibility(Disable,193,P8,64)},{preserved})

	
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(13*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetCDeaths(FP,SetTo,1,LockBossUnit),SetCVar(FP,TSize,SetTo,0)},{preserved})
	
	
	for i = 0, 3 do
		local Pat1 = Create_PatternCcode(PatternCcode)
		CIf(FP,{DeathsX(FP,Exactly,(29*4)+1+i,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1)})
		CSPlot(CSMakePolygon(32,160,0,33,1),FP,193,"DCenter",nil,1,32,FP,nil,nil,1)
		CSPlot(CSMakePolygon(32,160,0,33,1),FP,94,"DCenter",nil,1,32,FP,nil,nil,1)
		DoActionsX(FP,{SetMemoryB(0x6636B8 + 193, SetTo, 130),SetInvincibility(Enable,193,P8,64),GiveUnits(All,94,P8,64,P11),GiveUnits(All,193,P8,64,P11),Order(94,P11,64,Move,"DCenter"),Order(193,P11,64,Move,"DCenter")})
			if i == 0 then
				local Randnum = f_CRandNum(256)
				CMov(FP,Angle1,Randnum)
				CMov(FP,Angle2,Randnum,13)
				CMov(FP,Angle3,Randnum,13*2)
				CiSub(FP,Angle4,Randnum,13)
				CiSub(FP,Angle5,Randnum,13*2)
				CMov(FP,Angle6,Angle1)
			end
		CIfEnd()
	end
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(29*4)+1,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetMemoryW(0x657998+(127*2), SetTo, 0);SetMemoryX(0x665E44, SetTo, 0,0xFF000000)},{preserved})
	CIf(FP,{DeathsX(FP,AtLeast,(29*4)+1,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,(30*4)+1+2,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,CBulletT)})
		GetLocCenter("DCenter",CPosX,CPosY)
		CreateBullet(208,20,Angle1,CPosX,CPosY)
		CreateBullet(208,20,Angle2,CPosX,CPosY)
		CreateBullet(208,20,Angle3,CPosX,CPosY)
		CreateBullet(208,20,Angle4,CPosX,CPosY)
		CreateBullet(208,20,Angle5,CPosX,CPosY)
		--CreateBullet(208,20,Angle6,CPosX,CPosY)
	CIfEnd()
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(30*4)+1,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),KillUnit(94,P11),SetMemoryW(0x657998+(127*2), SetTo, 3);SetMemoryX(0x665E44, SetTo, 16777216,0xFF000000),SetVoid(1, SetTo, 1)},{preserved})
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(30*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetMemoryW(0x657998+(127*2), SetTo, 0);SetMemoryX(0x665E44, SetTo, 0,0xFF000000),SetMemory(0x6509B0, SetTo, FP),GiveUnits(All,193,P11,64,P8),RunAIScriptAt(JYD,64),SetVoid(1, SetTo, 0)},{preserved})
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(30*4)+1+4,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetMemoryB(0x6636B8 + 193, SetTo, 55),SetInvincibility(Disable,193,P8,64)},{preserved})
	CIf(FP,{DeathsX(FP,AtLeast,(31*4)+1,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,(31*4)+1+2,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,CBulletT)},{SetMemoryW(0x657998+(127*2), SetTo, 3);SetMemoryX(0x665E44, SetTo, 16777216,0xFF000000)})
	GetLocCenter("DCenter",CPosX,CPosY)
		CAdd(FP,Angle6,3)
		CreateBullet(208,20,Angle6,CPosX,CPosY)
		DoActionsX(FP,{SetCVar("X",TSize,Add,800);})
	CIfEnd()
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(31*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetCDeaths(FP,SetTo,1,SMine)},{preserved})
	CIf(FP,{DeathsX(FP,AtLeast,(32*4)+1,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,(32*4)+1+2,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,CBulletT)})
	GetLocCenter("DCenter",CPosX,CPosY)
		CiSub(FP,Angle6,3)
		CMov(FP,Angle7,Angle6,128)
		CreateBullet(208,20,Angle7,CPosX,CPosY)
		DoActionsX(FP,{SetCVar("X",TSize,Subtract,400);})
	CIfEnd()
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(32*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetCDeaths(FP,SetTo,1,IdenSiege)},{preserved})
	CIf(FP,{DeathsX(FP,AtLeast,(33*4)+1,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,(33*4)+1+2,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,CBulletT)})
	GetLocCenter("DCenter",CPosX,CPosY)
		CAdd(FP,Angle6,3)
		CMov(FP,Angle7,Angle6,128)
		CreateBullet(208,20,Angle6,CPosX,CPosY)
		CreateBullet(208,20,Angle7,CPosX,CPosY)
		DoActionsX(FP,{SetCVar("X",TSize,Add,1200);})
	CIfEnd()
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(32*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetCDeaths(FP,SetTo,1,YamatoShuttle)},{preserved})
	CIf(FP,{DeathsX(FP,AtLeast,(34*4)+1,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,(34*4)+1+2,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,CBulletT)})
	GetLocCenter("DCenter",CPosX,CPosY)
		CiSub(FP,Angle6,3)
		CMov(FP,Angle7,Angle6,128)
		CMov(FP,Angle8,Angle6,64)
		CMov(FP,Angle9,Angle6,192)
		CreateBullet(208,20,Angle6,CPosX,CPosY)
		CreateBullet(208,20,Angle7,CPosX,CPosY)
		CreateBullet(208,20,Angle8,CPosX,CPosY)
		CreateBullet(208,20,Angle9,CPosX,CPosY)
		DoActionsX(FP,{SetCVar("X",TSize,Subtract,1500);})
	CIfEnd()
	for i = 0, 3 do
		local Pat1 = Create_PatternCcode(PatternCcode)
		CIf(FP,{DeathsX(FP,Exactly,(34*4)+1+i,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetCDeaths(FP,SetTo,1,LockBossUnit)})
		if i <= 2 then
			CSPlot(CSMakePolygon(32,160,0,33,1),FP,193,"DCenter",nil,1,32,FP,nil,nil,1)
			CSPlot(CSMakePolygon(32,160,0,33,1),FP,94,"DCenter",nil,1,32,FP,nil,nil,1)
			DoActionsX(FP,{SetMemoryB(0x6636B8 + 193, SetTo, 130),SetInvincibility(Enable,193,P8,64),GiveUnits(All,94,P8,64,P11),GiveUnits(All,193,P8,64,P11),Order(94,P11,64,Move,"DCenter"),Order(193,P11,64,Move,"DCenter")})
		end
		if i == 3 then
			local Randnum = f_CRandNum(256)
			CMov(FP,Angle6,Randnum)
			DoActionsX(FP,{SetMemoryW(0x657998+(127*2), SetTo, 3);SetMemoryX(0x665E44, SetTo, 16777216,0xFF000000),SetMemory(0x6509B0, SetTo, FP),GiveUnits(All,193,P11,64,P8),RunAIScriptAt(JYD,64),KillUnit(94,P11)})
		end
		CIfEnd()
	end	
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(34*4)+1+4,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetInvincibility(Disable,193,P8,64),SetMemoryB(0x6636B8 + 193, SetTo, 55)},{preserved})
	CIf(FP,{DeathsX(FP,AtLeast,(35*4)+1,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,(35*4)+1+2,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,CBulletT)},{SetMemoryW(0x657998+(127*2), SetTo, 3);SetMemoryX(0x665E44, SetTo, 16777216,0xFF000000)})
	GetLocCenter("DCenter",CPosX,CPosY)
		CAdd(FP,Angle6,3)
		CreateBullet(208,20,Angle6,CPosX,CPosY)
		DoActionsX(FP,{SetCVar("X",TSize,Add,600);})
	CIfEnd()
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(35*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetCDeaths(FP,SetTo,1,IdenSiege)},{preserved})
	CIf(FP,{DeathsX(FP,AtLeast,(36*4)+1,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,(36*4)+1+2,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,CBulletT)})
	GetLocCenter("DCenter",CPosX,CPosY)
		CiSub(FP,Angle6,3)
		CMov(FP,Angle7,Angle6,128)
		CreateBullet(208,20,Angle7,CPosX,CPosY)
		DoActionsX(FP,{SetCVar("X",TSize,Subtract,400);})
	CIfEnd()
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(36*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetCDeaths(FP,SetTo,1,YamatoShuttle)},{preserved})
	CIf(FP,{DeathsX(FP,AtLeast,(37*4)+1,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,(37*4)+1+2,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,CBulletT)})
	GetLocCenter("DCenter",CPosX,CPosY)
		CAdd(FP,Angle6,3)
		CMov(FP,Angle7,Angle6,128)
		CreateBullet(208,20,Angle6,CPosX,CPosY)
		CreateBullet(208,20,Angle7,CPosX,CPosY)
		DoActionsX(FP,{SetCVar("X",TSize,Add,900);})
	CIfEnd()
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(37*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetCDeaths(FP,SetTo,1,SMine)},{preserved})
	CIf(FP,{DeathsX(FP,AtLeast,(38*4)+1,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,(38*4)+1+2,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,CBulletT)})
	GetLocCenter("DCenter",CPosX,CPosY)
		CiSub(FP,Angle6,3)
		CMov(FP,Angle7,Angle6,128)
		CMov(FP,Angle8,Angle6,64)
		CMov(FP,Angle9,Angle6,192)
		CreateBullet(208,20,Angle6,CPosX,CPosY)
		CreateBullet(208,20,Angle7,CPosX,CPosY)
		CreateBullet(208,20,Angle8,CPosX,CPosY)
		CreateBullet(208,20,Angle9,CPosX,CPosY)
		DoActionsX(FP,{SetCVar("X",TSize,Subtract,1500);})
	CIfEnd()
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(38*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetCDeaths(FP,SetTo,1,HackBattle)},{preserved})
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(38*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetCVar(FP,SkillW[2],SetTo,0),SetMemoryW(0x657998+(127*2), SetTo, 0);SetMemoryX(0x665E44, SetTo, 0,0xFF000000),SetCVar("X",TSize,SetTo,0)},{preserved})
	CIf(FP,{DeathsX(FP,AtLeast,(39*4)+1,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,(45*4)+1+3,BGMLength,0xFFFFFF)})
		DoActionsX(FP,{SetCVar("X",TSize,Add,100);})
		CIf(FP,{CDeaths(FP,AtLeast,1,WhileLaunch)},{SetCDeaths(FP,SetTo,0,WhileLaunch)})
			CMov(FP,SkillW2,SkillW)
		CIfEnd()
		CWhile(FP,{CVar(FP,SkillW2[2],AtLeast,1),CVar(FP,SkillW2[2],AtMost,100)},{SetCVar(FP,SkillW3[2],Add,100),SetCVar(FP,SkillW2[2],Subtract,1)})
			local Randnum = f_CRandNum(360)
			CMov(FP,RandRet2,Randnum)
			f_Mod(FP,InputMaxRand,_Rand(),_Mov(30*32))
			CallTriggerX(FP,Call_CRandNum,nil,{SetCVar(FP,Oprnd[2],SetTo,0)})
			f_Lengthdir(FP,TempRandRet,RandRet2,CPosX2,CPosY2)
			GetLocCenter("DCenter",CPosX,CPosY)
			CAdd(FP,CPosX,CPosX2)
			CAdd(FP,CPosY,CPosY2)
			local Randnum = f_CRandNum(256)
			CreateBullet(209,20,Randnum,CPosX,CPosY)
		CWhileEnd()
		DoActionsX(FP,{SetCVar(FP,SkillW3[2],SetTo,0)})
	CIfEnd()
	Trigger2(FP,{DeathsX(FP,AtLeast,(39*4)+1,BGMLength,0xFFFFFF)},{ModifyUnitShields(All,"Any unit",Force1,64,0)},{preserved})
	for i = 0, 3 do
		local Pat1 = Create_PatternCcode(PatternCcode)
		CIf(FP,{DeathsX(FP,Exactly,(48*4)+1+i,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetCVar("X",TSize,SetTo,0)})
		CSPlot(CSMakePolygon(32,160,0,33,1),FP,193,"DCenter",nil,1,32,FP,nil,nil,1)
		CSPlot(CSMakePolygon(32,160,0,33,1),FP,94,"DCenter",nil,1,32,FP,nil,nil,1)
		DoActionsX(FP,{SetMemoryB(0x6636B8 + 193, SetTo, 130),SetInvincibility(Enable,193,P8,64),GiveUnits(All,94,P8,64,P11),GiveUnits(All,193,P8,64,P11),Order(94,P11,64,Move,"DCenter"),Order(193,P11,64,Move,"DCenter")})
			if i == 0 then
				local Randnum = f_CRandNum(256)
				CMov(FP,Angle1,Randnum)
				CMov(FP,Angle2,Randnum,13)
				CMov(FP,Angle3,Randnum,13*2)
				CiSub(FP,Angle4,Randnum,13)
				CiSub(FP,Angle5,Randnum,13*2)
			end
		CIfEnd()
	end
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(48*4)+1,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetMemoryW(0x657998+(127*2), SetTo, 0);SetMemoryX(0x665E44, SetTo, 0,0xFF000000)},{preserved})
	CIf(FP,{
		DeathsX(FP,AtLeast,(48*4)+1,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,(49*4)+1+2,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,CBulletT)})
		GetLocCenter("DCenter",CPosX,CPosY)
		CreateBullet(208,20,Angle1,CPosX,CPosY)
		CreateBullet(208,20,Angle2,CPosX,CPosY)
		CreateBullet(208,20,Angle3,CPosX,CPosY)
		CreateBullet(208,20,Angle4,CPosX,CPosY)
		CreateBullet(208,20,Angle5,CPosX,CPosY)
		--CreateBullet(208,20,Angle6,CPosX,CPosY)
	CIfEnd()
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(49*4)+1,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{KillUnit(94,P11),SetCDeaths(FP,SetTo,1,Pat1),SetMemoryW(0x657998+(127*2), SetTo, 3);SetMemoryX(0x665E44, SetTo, 16777216,0xFF000000),SetVoid(1, SetTo, 1)},{preserved})
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(49*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetMemoryW(0x657998+(127*2), SetTo, 0);SetMemoryX(0x665E44, SetTo, 0,0xFF000000),SetMemory(0x6509B0, SetTo, FP),GiveUnits(All,193,P11,64,P8),RunAIScriptAt(JYD,64),SetVoid(1, SetTo, 0)},{preserved})
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(49*4)+1+4,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetCDeaths(FP,SetTo,1,BursterCall),SetMemoryB(0x6636B8 + 193, SetTo, 55),SetInvincibility(Disable,193,P8,64)},{preserved})
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(59*4)+1,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetCDeaths(FP,SetTo,1,BlackBox),SetCDeaths(FP,SetTo,0,BursterCall),SetCVar("X",TSize,SetTo,0)},{preserved})
	local N_R,N_A,N_X,N_Y,N_A2,N_A3 = CreateVariables(6)
	CIf(FP,{CDeaths(FP,AtLeast,1,BursterCall)},{SetCVar(FP,N_R[2],Add,2),SetCVar("X",TSize,Add,100)})
	CMov(FP,N_A,0)
	CAdd(FP,N_A2,1)
	CAdd(FP,N_A3,N_A2)
	CWhile(FP,{CVar(FP,N_A[2],AtMost,359)})
	f_Lengthdir(FP,N_R,_Add(N_A,N_A3),N_X,N_Y)
	GetLocCenter("DCenter",CPosX,CPosY)
	CAdd(FP,N_X,CPosX)
	CAdd(FP,N_Y,CPosY)

	CIfX(FP,{CVar(FP,N_X[2],AtMost,96*32),CVar(FP,N_Y[2],AtMost,192*32)})
	Simple_SetLocX(FP,0,_Add(N_X,-16),_Add(N_Y,-16),_Add(N_X,16),_Add(N_Y,16),{
		CreateUnit(1,94,1,FP),
		KillUnit(94,FP),
		KillUnitAt(All,"Men",1,Force1),
		KillUnitAt(All,193,1,FP),
	})
	CIfXEnd()

	CAdd(FP,N_A,12)
	CWhileEnd()

	CIfEnd()

	local TotalDmgVA = CreateVArray(FP,13)
	local Pat1 = Create_PatternCcode(PatternCcode)
	CIf(FP,{DeathsX(FP,Exactly,(66*4)+1,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1)})
		f_Div(FP,DTotalDmg,_Mov(256))
		f_Mul(FP,DTotalDmg,_Mov(10))
		if Limit == 1 then
		else
			f_Div(FP,DTotalDmg,SetPlayers)
		end
		
		ItoDecX(FP,DTotalDmg,VArr(TotalDmgVA,0),2,0x7,2)
		_0DPatchX(FP,TotalDmgVA,12)
		f_Memcpy(FP,DBoss_PrintScore2,_TMem(Arr(DBossTotalDMGT[3],0),"X","X",1),DBossTotalDMGT[2])
		f_Movcpy(FP,_Add(DBoss_PrintScore2,DBossTotalDMGT[2]),VArr(TotalDmgVA,0),12*4)
		for i = 1, 7 do
			CIf(FP,CVar(FP,BarPos[i][2],AtLeast,1))
				CAdd(FP,ExScore[i],DTotalDmg)
			CIfEnd()
		end
		DoActionsX(FP,{SetCVar(FP,DPtr[2],SetTo,0),SetCVar(FP,DHP[2],SetTo,0),SetCVar(FP,DcurHP[2],SetTo,0),SetCVar(FP,DTotalDmg[2],SetTo,0)})
		DoActions(FP,RotatePlayer({DisplayTextX("\x0D\x0D\x0DDBossDMG".._0D,4)},HumanPlayers,FP))
		DoActionsX(FP,{CreateUnitWithProperties(1,94,"DCenter",FP,{hallucinated = true}),RemoveUnit(186,FP),KillUnit(94,FP),ModifyUnitEnergy(All,"Any unit",FP,64,0),RemoveUnit("Any unit",FP)})
	CIfEnd()

	for i = 0, #BGMArr-1 do
		Trigger { -- 상시브금
			players = {FP},
			conditions = {
				Label(0);
				DeathsX(FP,Exactly,i,BGMLength,0xFFFFFF);
				DeathsX(FP,AtMost,0,BGMVar,0xFFFFFF);
			},
			actions = {
				RotatePlayer({PlayWAVX(BGMArr[i+1]);PlayWAVX(BGMArr[i+1]);},HumanPlayers,FP);
				SetDeathsX(FP,Add,Length,BGMVar,0xFFFFFF);
				SetDeathsX(FP,Add,1,BGMLength,0xFFFFFF);
				SetCVar(FP,SkillW[2],Add,4);
				SetCDeaths(FP,Add,1,WhileLaunch);
				PreserveTrigger();
				},
			}
	end
	TriggerX(FP,{CDeaths(FP,AtMost,0,CBulletT)},{SetCDeaths(FP,Add,7,CBulletT)},{preserved})
	DoActionsX(FP,SetCDeaths(FP,Subtract,1,CBulletT))
	CallTrigger(FP, Call_CDPrint)

	CElseIfX(CVar(FP,VResetSw5[2],Exactly,0),SetCVar(FP,VResetSw5[2],SetTo,1))
	local DResetTable = {}
	for j, k in pairs(LyricsCCode) do
		table.insert(DResetTable,SetCDeaths(FP,SetTo,0,k))
	end
	for j, k in pairs(PatternCcode) do
		table.insert(DResetTable,SetCDeaths(FP,SetTo,0,k))
	end
	DoActions2X(FP,DResetTable)
	CallTrigger(FP,Call_VoidReset)
	
	
	

	DoActionsX(FP,{
		SetCDeaths(FP,SetTo,1,Destr0yerClear),
		SetDeaths(FP,SetTo,0,BGMLength),
		SetCDeaths(FP,SetTo,0,WhileLaunch),
		SetCDeaths(FP,SetTo,0,BursterCall),
		SetCDeaths(FP,SetTo,0,BlackBox),
		SetCDeaths(FP,SetTo,0,LockBossUnit),
		
		SetCVar(FP,N_R[2],SetTo,0),
		SetCVar(FP,N_A[2],SetTo,0);
		SetCVar(FP,N_X[2],SetTo,0);
		SetCVar(FP,N_Y[2],SetTo,0);
		SetCVar(FP,N_A2[2],SetTo,0);
		SetCVar(FP,N_A3[2],SetTo,0);
		SetCVar(FP,TSize[2],SetTo,0);
		SetCVar(FP,XAngle[2],SetTo,0);
		SetCVar(FP,YAngle[2],SetTo,0);
		SetCVar(FP,ZAngle[2],SetTo,0);
		SetCVar(FP,TCount[2],SetTo,0);
		SetCVar(FP,TCount2[2],SetTo,0);
		SetCVar(FP,Angle1[2],SetTo,0);
		SetCVar(FP,Angle2[2],SetTo,0);
		SetCVar(FP,Angle3[2],SetTo,0);
		SetCVar(FP,Angle4[2],SetTo,0);
		SetCVar(FP,Angle5[2],SetTo,0);
		SetCVar(FP,Angle6[2],SetTo,0);
		SetCVar(FP,Angle7[2],SetTo,0);
		SetCVar(FP,Angle8[2],SetTo,0);
		SetCVar(FP,Angle9[2],SetTo,0);
		SetCVar(FP,SkillW[2],SetTo,0);
		SetCVar(FP,SkillW2[2],SetTo,0);
		SetCVar(FP,SkillW3[2],SetTo,0);
		SetCVar(FP,CPosX2[2],SetTo,0);
		SetCVar(FP,CPosY2[2],SetTo,0);
		SetCVar(FP,RandRet2[2],SetTo,0);
		ResetActT
	})

	f_ArrReset()
	CIfXEnd()
	CIf(FP,CDeaths(FP,AtLeast,1,Destr0yerClear))
		local ClearText1 = "\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x07ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\n\x13\x04\x07『 \x08Ｄ\x04ｅｓｔｒ\x10０\x04ｙｅｒ\x07 』 \x04에게서 살아남으셨습니다.\x14\n\n\n\x13\x04！！！　\x07ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
		local ClearText2 = "\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\x14\n\x14\n\x13\x04점수를 계산중입니다...\n\x14\n\x14\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
		local ClearTimer = CreateCcode()
		local ClearSw1 = CreateCcode()
		local ClearSw2 = CreateCcode()
		TriggerX(FP,{CDeaths(FP,AtMost,0,ClearTimer)},{RotatePlayer({PlayWAVX("staredit\\wav\\DClear.ogg"),PlayWAVX("staredit\\wav\\DClear.ogg"),DisplayTextX(ClearText1,4)},HumanPlayers,FP),SetCDeaths(FP,SetTo,1,ClearTimer)},{preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,3000,ClearTimer),CDeaths(FP,AtMost,0,ClearSw1)},{RotatePlayer({PlayWAVX("staredit\\wav\\CalcSE.ogg"),PlayWAVX("staredit\\wav\\CalcSE.ogg"),DisplayTextX(ClearText2,4)},HumanPlayers,FP),SetCDeaths(FP,SetTo,1,ClearSw1)},{preserved})
		--CAdd(FP,_Ccode("X",ClearTimer),Dt)
		
		CTrigger(FP,{CVar(FP,Dt[2],AtMost,2500)},{TSetCDeaths(FP,Add,Dt,ClearTimer)},1)
		CIf(FP,{CDeaths(FP,AtLeast,3000+3000,ClearTimer),CDeaths(FP,AtMost,0,ClearSw2)},SetCDeaths(FP,SetTo,1,ClearSw2))
			CallTrigger(FP,Call_ScorePrint,{SetCDeaths(FP,SetTo,1,isDBossClear)})
		CIfEnd()
		CIf(FP,CDeaths(FP,AtLeast,3000+6000,ClearTimer))
		CIfX(FP,{TCVar(FP,TotalScore[2],AtLeast,OutputPoint),CVar(FP,TotalScore[2],AtMost,0x7FFFFFFF)}) --  점수만족시

		DoActionsX(FP,{SetCDeaths(FP,SetTo,1,Destr0yerClear2)})


		CElseX()--  점수불만족시
		DoActions2(FP,RotatePlayer({
			DisplayTextX(string.rep("\n", 20),4),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			DisplayTextX("\x13\x05ＧＡＭＥ　ＯＶＥＲ",4),
			DisplayTextX("\n",4),
			DisplayTextX("\x13\x15점수가 충분하지 않아 게임을 클리어하지 못했습니다....\n",4);
			DisplayTextX("\x13\x05게임을 종료합니다.",4);
			DisplayTextX("\n",4),
			DisplayTextX("\x13\x05ＧＡＭＥ　ＯＶＥＲ",4),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			PlayWAVX("staredit\\wav\\Game_Over.ogg")
		},HumanPlayers,FP)) 
		DoActionsX(FP,{SetCDeaths(FP,SetTo,1,Win)})
		CIfXEnd()
		DoActionsX(FP,{SetCDeaths(FP,SetTo,0,ClearTimer),SetCDeaths(FP,SetTo,0,ClearSw1),SetCDeaths(FP,SetTo,0,ClearSw2),SetCDeaths(FP,SetTo,0,Destr0yerClear)})
	CIfEnd()
	CIfEnd()
--	CIf(FP,)
--	GetLocCenter(63,CPosX,CPosY)
--	for i = 0, 7 do
	--CreateBullet(208,20,i*32,CPosX,CPosY)
--	end
--	CIfEnd()
	--SetMemoryX(0x663788, SetTo, ,0xFF);
	--staredit\wav\LV10_001.ogg -- 272
--SetMemoryX(0x66655C, SetTo, 65536*961,0xFFFF0000) -- 복구할때
end