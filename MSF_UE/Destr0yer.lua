function Install_Destr0yer()
	
local Lyrics = {
	{"\x13\x06�� \x04Ladies and Gentlemen \x06��",2,222},
	{"\x13\x06�� \x07Let's start \x06��",5,0},
	{"\x13\x06�� \x04Only is in Memories \x06��",8,0},
	{"\x13\x06�� \x08Tonight. \x06��",12,333},
	{"\x13\x07��\x04 I wonder why things have \x03happened\x04. \x07��\n\x13\x07��\x04 �� \x03�̷� �ϵ�\x04�� �Ͼ���� �ñ���. \x07��",60-3,0},
	{"\x13\x07��\x04 \x1DCould you imagine \x04the world is \x1Cboring\x04? \x07��\n\x13\x07��\x04 �� ������ \x1C������ \x04��, \x1D�� �˰� �ִ�? \x07��",68-3,0},
	{"\x13\x07��\x08 Stereotype \x07��\n\x13\x07��\x08 �������� \x07��",76-3,0},
	{"\x13\x07��\x0E Sham \x07��\n\x13\x07��\x0E ���͸� \x07��",78-3,444},
	{"\x13\x07��\x0F Brain Freeze \x07��\n\x13\x07��\x0F �극�� ������ \x07��",79-3,444},
	{"\x13\x07��\x10 Collusion \x07��\n\x13\x07��\x10 ���� \x07��",80-3,222},
	{"\x13\x07��\x1F Mental block \x07��\n\x13\x07��\x1F ������ ��� \x07��",82-3,333},
	{"\x13\x07��\x04 The world is \x1Bfading\x04. \x07��\n\x13\x07��\x04 ����� \x1B����� ����\x04, \x07��",83-3,222},
	{"\x13\x07��\x04 I know the \x08( \x11��\x04����� \x08)\x04. \x07��\n\x13\x07��\x04 �� \x08( \x11��\x04�� \x08)\x04�� �� �˰� �־�. \x07��",86-3,333},
	{"\x13\x07��\x04 The world is \x1Bfading\x04. \x07��\n\x13\x07��\x04 ����� \x1B�������\x04, \x07��",88-3,444},
	{"\x13\x07��\x04 I know the \x08( \x11��\x04����� \x08)\x04. \x07��\n\x13\x07��\x04 ���� �� \x08( \x11��\x04�� \x08)\x04�� �ƴ°�. \x07��",90-3,444},
	{"\x13\x07��\x04 I know \x07all of you\x04. \x07��\n\x13\x07��\x04 ���� ���� \x07��� �ƴµ�\x04, \x07��",91-3,0},
	{"\x13\x07��\x04 Have you, you, \x10followed me\x04? \x07��\n\x13\x07��\x04 �����, �����, �� \x10�Ѿƿ���� �ߴ�\x04? \x07��",95-3,444},
	{"\x13\x07��\x04 Me in your mind is the \x1Fdream\x04. \x07��\n\x13\x07��\x04 ���� ���� ���� ���� \x1F��\x04�ΰ�. \x07��",99-3,0},
	{"\x13\x07��\x04 The dream of the \x10 ( \x11��\x04���� \x10) \x04. \x07��\n\x13\x07��\x04 \x10 ( \x11��\x04�� \x10) \x04�� ��. \x07��",105-3,333},
	{"\x13\x07��\x04 So I would \x08forget \x04you. \x07��\n\x13\x07��\x04 �� ���� \x08����\x04�״�, \x07��",107-3,0},
	{"\x13\x07��\x11 Let you forget me. \x07��\n\x13\x07��\x11 ���� �� �ؾ���. \x07��",111-3,0},
	{"\x13\x07��\x04 'Cause I'm \x07�� \x08��\x04������\x10��\x04�����\x07 �� \x07��\n\x13\x07��\x04 �ֳĸ� ���� \x07�� \x08��\x10��\x04��\x07 ��\x04�̴ϱ�. \x07��",115-3,333},
	{"\x13\x07��\x08 I kill us all. \x07��\n\x13\x07��\x08 �� ���峻�ھ�. \x07��",138-3,0},
	{"\x13\x07��\x10 It's the only way. \x07��\n\x13\x07��\x10 �� �� ���̾�. \x07��",151-3,333},
	{"\x13\x07��\x06 It's over. \x07��\n\x13\x07��\x06 �� ������. \x07��",153-3,0},
	{"\x13\x07��\x08 I will kill. \x07��\n\x13\x07��\x08 ���峻�ھ�. \x07��",159-3,333},
	{"\x13\x07��\x04 I will \x07�� \x08��\x04������\x10��\x04��\x07 ��\x04 the world. \x07��\n\x13\x07��\x04 ���� ������ \x07�� \x08��\x10��\x07 �� \x04�ϰھ�. \x07��",161-3,333},
	{"\x13\x07��\x04 No matter what you do, \x0FI don't stop\x04. \x07��\n\x13\x07��\x04 ���� ������, \x0F������ �ʾ�\x04. \x07��",165-3,500},
	{"\x13\x07��\x04 I'm the only one \x1Fwho's right\x04. \x07��\n\x13\x07��\x04 ������ \x1F����\x04�̱⿡. \x07��",168-3,0},
	{"\x13\x07��\x08 I will kill. \x07��\n\x13\x07��\x08 ���峻�ھ�. \x07��",175-3,333},
	{"\x13\x07��\x04 I will \x07�� \x08��\x04������\x10��\x04��\x07 ��\x04 the world. \x07��\n\x13\x07��\x04 ���� ������ \x07�� \x08��\x10��\x07 �� \x04�ϰھ�. \x07��",177-3,444},
	{"\x13\x07��\x04 No matter what you do, \x0FI don't stop\x04. \x07��\n\x13\x07��\x04 ���� ������, \x0F������ �ʾ�\x04. \x07��",181-3,500},
	{"\x13\x07��\x15 It is what it is. \x07��\n\x13\x07��\x15 �� ��¼�ھ�. \x07��",184-3,0},
	{"\x13\x07��\x1E It is what it is. \x07��\n\x13\x07��\x1E ���� �̷��°�. \x07��",188-3,0},
	{"\x13\x07��\x04 It is not. It's not \x08my fault\x04. \x07��\n\x13\x07��\x04 �Ƴ�. \x08�� �߸�\x04�� �Ƴ�. \x07��",192-3,0},
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
	local BGMVar = 440
	local Length = 666
	local CBulletT = CreateCCode()
	local LockBossUnit = CreateCCode()
	if TestStart == 1 then
		CIfX(FP,{Bring(FP,AtLeast,1,186,64)},{SetMemoryX(0x66655C, SetTo, 65536*210,0xFFFF0000),SetCVar(FP,VResetSw5[2],SetTo,0)})
	else	
		CIfX(FP,{TTOR({Bring(FP,AtLeast,1,186,64),TTAND({DeathsX(FP,AtLeast,1,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,271,BGMLength,0xFFFFFF)})})},{SetMemoryX(0x66655C, SetTo, 65536*210,0xFFFF0000),SetCVar(FP,VResetSw5[2],SetTo,0)})
	end
	Simple_SetLocX(FP,"DCenter",0,0,32,32,{MoveLocation("DCenter",186,FP,64)})
	TriggerX(FP,{CDeaths(FP,AtLeast,1,LockBossUnit)},{MoveUnit(All,186,FP,64,"DCenter")},{Preserved})
	
	CIf(FP,{Memory(0x628438,AtLeast,1)})
		f_Read(FP,0x628438,nil,Nextptrs)
		CDoActions(FP,{
			Simple_CalcLoc("DCenter",0,-16,0,-16),
			CreateUnit(4,207, "DCenter",FP),
			TSetMemoryX(_Add(Nextptrs,55),SetTo,0x200104,0x300104),
			Simple_CalcLoc("DCenter",0,16,0,16),
			--TSetMemory(_Add(Nextptrs,57))
		})
	CIfEnd()
	SetRecoverCp()
	RecoverCp(FP)
	local LyricsCCode = {}
	for j, k in pairs(Lyrics) do
		local TempCcode = CreateCCode()
		table.insert(LyricsCCode,TempCcode)
		Trigger { -- ��ú��
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
	local PatternCcode = {}
	function Create_PatternCcode(Table)
		local TempCcode = CreateCCode()
		table.insert(Table,TempCcode)
		return TempCcode
	end
	local Angle1 = CreateVar()
	local Angle2 = CreateVar()
	local Angle3 = CreateVar()
	local Angle4 = CreateVar()
	local Angle5 = CreateVar()
	local Angle6 = CreateVar()
	for i = 0, 3 do
		local Pat1 = Create_PatternCcode(PatternCcode)
		CIf(FP,{DeathsX(FP,Exactly,13+i,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1)})
			CSPlot(CSMakePolygon(32,160,0,33,1),FP,193,"DCenter",nil,1,32,FP,nil,nil,1)
			CSPlot(CSMakePolygon(32,160,0,33,1),FP,94,"DCenter",nil,1,32,FP,nil,nil,1)
			DoActionsX(FP,{SetInvincibility(Enable,193,P8,64),GiveUnits(All,94,P8,64,P11),GiveUnits(All,193,P8,64,P11),Order(94,P11,64,Move,"DCenter"),Order(193,P11,64,Move,"DCenter")})
			if i == 0 then
				local Randnum = f_CRandNum(43)
				CMov(FP,Angle1,Randnum)
				CMov(FP,Angle2,Randnum,43)
				CMov(FP,Angle3,Randnum,43*2)
				CMov(FP,Angle4,Randnum,43*3)
				CMov(FP,Angle5,Randnum,43*4)
				CMov(FP,Angle6,Randnum,43*5)
			end
		CIfEnd()
	end
	CIf(FP,{DeathsX(FP,AtLeast,13,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,16,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,CBulletT)},{SetMemoryX(0x665E44, SetTo, 0,0xFF000000)})
		GetLocCenter("DCenter",CPosX,CPosY)
		CreateBullet(210,20,Angle1,CPosX,CPosY)
		CreateBullet(210,20,Angle2,CPosX,CPosY)
		CreateBullet(210,20,Angle3,CPosX,CPosY)
		CreateBullet(210,20,Angle4,CPosX,CPosY)
		CreateBullet(210,20,Angle5,CPosX,CPosY)
		CreateBullet(210,20,Angle6,CPosX,CPosY)
	CIfEnd()
	CIf(FP,{DeathsX(FP,AtLeast,17,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,19,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,CBulletT)},SetMemoryX(0x665E44, SetTo, 16777216,0xFF000000))
		GetLocCenter("DCenter",CPosX,CPosY)
		CreateBullet(208,20,Angle1,CPosX,CPosY)
		CreateBullet(208,20,Angle2,CPosX,CPosY)
		CreateBullet(208,20,Angle3,CPosX,CPosY)
		CreateBullet(208,20,Angle4,CPosX,CPosY)
		CreateBullet(208,20,Angle5,CPosX,CPosY)
		CreateBullet(208,20,Angle6,CPosX,CPosY)
	CIfEnd()
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,20,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetMemoryX(0x665E44, SetTo, 0,0xFF000000),SetMemory(0x6509B0, SetTo, FP),GiveUnits(All,193,P11,64,P8),RunAIScriptAt(JYD,64),SetInvincibility(Disable,193,P8,64)},{Preserved})
	local Pat1 = Create_PatternCcode(PatternCcode)
	CIf(FP,{DeathsX(FP,Exactly,17,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1)})
		DoActionsX(FP,KillUnit(94,P11))
	CIfEnd()

	
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(13*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetCDeaths(FP,SetTo,1,LockBossUnit)},{Preserved})
	
	
	for i = 0, 3 do
		local Pat1 = Create_PatternCcode(PatternCcode)
		CIf(FP,{DeathsX(FP,Exactly,(29*4)+1+i,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1)})
		CSPlot(CSMakePolygon(32,160,0,33,1),FP,193,"DCenter",nil,1,32,FP,nil,nil,1)
		CSPlot(CSMakePolygon(32,160,0,33,1),FP,94,"DCenter",nil,1,32,FP,nil,nil,1)
		DoActionsX(FP,{SetInvincibility(Enable,193,P8,64),GiveUnits(All,94,P8,64,P11),GiveUnits(All,193,P8,64,P11),Order(94,P11,64,Move,"DCenter"),Order(193,P11,64,Move,"DCenter")})
			if i == 0 then
				local Randnum = f_CRandNum(43)
				CMov(FP,Angle1,Randnum)
				CMov(FP,Angle2,Randnum,43)
				CMov(FP,Angle3,Randnum,43*2)
				CMov(FP,Angle4,Randnum,43*3)
				CMov(FP,Angle5,Randnum,43*4)
				CMov(FP,Angle6,Randnum,43*5)
			end
		CIfEnd()
	end
	CIf(FP,{DeathsX(FP,AtLeast,(29*4)+1,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,(29*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,CBulletT)},{SetMemoryX(0x665E44, SetTo, 0,0xFF000000)})
		GetLocCenter("DCenter",CPosX,CPosY)
		CreateBullet(210,20,Angle1,CPosX,CPosY)
		CreateBullet(210,20,Angle2,CPosX,CPosY)
		CreateBullet(210,20,Angle3,CPosX,CPosY)
		CreateBullet(210,20,Angle4,CPosX,CPosY)
		CreateBullet(210,20,Angle5,CPosX,CPosY)
		CreateBullet(210,20,Angle6,CPosX,CPosY)
	CIfEnd()
	CIf(FP,{DeathsX(FP,AtLeast,(30*4)+1,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,(30*4)+1+2,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,CBulletT)},SetMemoryX(0x665E44, SetTo, 16777216,0xFF000000))
		GetLocCenter("DCenter",CPosX,CPosY)
		CreateBullet(208,20,Angle1,CPosX,CPosY)
		CreateBullet(208,20,Angle2,CPosX,CPosY)
		CreateBullet(208,20,Angle3,CPosX,CPosY)
		CreateBullet(208,20,Angle4,CPosX,CPosY)
		CreateBullet(208,20,Angle5,CPosX,CPosY)
		CreateBullet(208,20,Angle6,CPosX,CPosY)
	CIfEnd()
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(30*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetMemoryX(0x665E44, SetTo, 0,0xFF000000),SetMemory(0x6509B0, SetTo, FP),GiveUnits(All,193,P11,64,P8),RunAIScriptAt(JYD,64),SetInvincibility(Disable,193,P8,64),SetCDeaths(FP,SetTo,0,LockBossUnit)},{Preserved})
	local Pat1 = Create_PatternCcode(PatternCcode)
	CIf(FP,{DeathsX(FP,Exactly,(30*4)+1,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1)})
		DoActionsX(FP,KillUnit(94,P11))
	CIfEnd()

	for i = 0, 2 do
		local Pat1 = Create_PatternCcode(PatternCcode)
		CIf(FP,{DeathsX(FP,Exactly,(34*4)+1+i,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetCDeaths(FP,SetTo,1,LockBossUnit)})
		CSPlot(CSMakePolygon(32,160,0,33,1),FP,193,"DCenter",nil,1,32,FP,nil,nil,1)
		CSPlot(CSMakePolygon(32,160,0,33,1),FP,94,"DCenter",nil,1,32,FP,nil,nil,1)
		DoActionsX(FP,{SetInvincibility(Enable,193,P8,64),GiveUnits(All,94,P8,64,P11),GiveUnits(All,193,P8,64,P11),Order(94,P11,64,Move,"DCenter"),Order(193,P11,64,Move,"DCenter")})
		CIfEnd()
	end	
	local Pat1 = Create_PatternCcode(PatternCcode)
	CIf(FP,{DeathsX(FP,Exactly,(34*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),})
	DoActionsX(FP,{SetCDeaths(FP,SetTo,0,LockBossUnit),SetMemoryX(0x665E44, SetTo, 1*16777216,0xFF000000),SetMemory(0x6509B0, SetTo, FP),GiveUnits(All,193,P11,64,P8),RunAIScriptAt(JYD,64),SetInvincibility(Disable,193,P8,64),KillUnit(94,P11)})
		GetLocCenter("DCenter",CPosX,CPosY)
		local Randnum = f_CRandNum(43)
		CMov(FP,Angle1,Randnum)
		CMov(FP,Angle2,Randnum,43)
		CMov(FP,Angle3,Randnum,43*2)
		CMov(FP,Angle4,Randnum,43*3)
		CMov(FP,Angle5,Randnum,43*4)
		CMov(FP,Angle6,Randnum,43*5)
		CreateBullet(208,20,Angle1,CPosX,CPosY)
		CreateBullet(208,20,Angle2,CPosX,CPosY)
		CreateBullet(208,20,Angle3,CPosX,CPosY)
		CreateBullet(208,20,Angle4,CPosX,CPosY)
		CreateBullet(208,20,Angle5,CPosX,CPosY)
		CreateBullet(208,20,Angle6,CPosX,CPosY)
	CIfEnd()
	for i = 0, 3 do
		local Pat1 = Create_PatternCcode(PatternCcode)
		CIf(FP,{DeathsX(FP,Exactly,(48*4)+1+i,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetCDeaths(FP,SetTo,1,LockBossUnit)})
		CSPlot(CSMakePolygon(32,160,0,33,1),FP,193,"DCenter",nil,1,32,FP,nil,nil,1)
		CSPlot(CSMakePolygon(32,160,0,33,1),FP,94,"DCenter",nil,1,32,FP,nil,nil,1)
		DoActionsX(FP,{SetInvincibility(Enable,193,P8,64),GiveUnits(All,94,P8,64,P11),GiveUnits(All,193,P8,64,P11),Order(94,P11,64,Move,"DCenter"),Order(193,P11,64,Move,"DCenter")})
			if i == 0 then
				local Randnum = f_CRandNum(43)
				CMov(FP,Angle1,Randnum)
				CMov(FP,Angle2,Randnum,43)
				CMov(FP,Angle3,Randnum,43*2)
				CMov(FP,Angle4,Randnum,43*3)
				CMov(FP,Angle5,Randnum,43*4)
				CMov(FP,Angle6,Randnum,43*5)
			end
		CIfEnd()
	end
	CIf(FP,{DeathsX(FP,AtLeast,(48*4)+1,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,(48*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,CBulletT)},{SetMemoryX(0x665E44, SetTo, 0,0xFF000000)})
		GetLocCenter("DCenter",CPosX,CPosY)
		CreateBullet(210,20,Angle1,CPosX,CPosY)
		CreateBullet(210,20,Angle2,CPosX,CPosY)
		CreateBullet(210,20,Angle3,CPosX,CPosY)
		CreateBullet(210,20,Angle4,CPosX,CPosY)
		CreateBullet(210,20,Angle5,CPosX,CPosY)
		CreateBullet(210,20,Angle6,CPosX,CPosY)
	CIfEnd()
	CIf(FP,{DeathsX(FP,AtLeast,(49*4)+1,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,(49*4)+1+2,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,CBulletT)},SetMemoryX(0x665E44, SetTo, 16777216,0xFF000000))
		GetLocCenter("DCenter",CPosX,CPosY)
		CreateBullet(208,20,Angle1,CPosX,CPosY)
		CreateBullet(208,20,Angle2,CPosX,CPosY)
		CreateBullet(208,20,Angle3,CPosX,CPosY)
		CreateBullet(208,20,Angle4,CPosX,CPosY)
		CreateBullet(208,20,Angle5,CPosX,CPosY)
		CreateBullet(208,20,Angle6,CPosX,CPosY)
	CIfEnd()
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(49*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetMemoryX(0x665E44, SetTo, 0,0xFF000000),SetMemory(0x6509B0, SetTo, FP),GiveUnits(All,193,P11,64,P8),RunAIScriptAt(JYD,64),SetInvincibility(Disable,193,P8,64)},{Preserved})
	local Pat1 = Create_PatternCcode(PatternCcode)
	CIf(FP,{DeathsX(FP,Exactly,(49*4)+1,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1)})
		DoActionsX(FP,KillUnit(94,P11))
	CIfEnd()

	for i = 0, #BGMArr-1 do
		Trigger { -- ��ú��
			players = {FP},
			conditions = {
				DeathsX(FP,Exactly,i,BGMLength,0xFFFFFF);
				DeathsX(FP,AtMost,0,BGMVar,0xFFFFFF);
			},
			actions = {
				RotatePlayer({PlayWAVX(BGMArr[i+1]);PlayWAVX(BGMArr[i+1]);},HumanPlayers,FP);
				SetDeathsX(FP,Add,Length,BGMVar,0xFFFFFF);
				SetDeathsX(FP,Add,1,BGMLength,0xFFFFFF);
				PreserveTrigger();
				},
			}
	end
	TriggerX(FP,{CDeaths(FP,AtMost,0,CBulletT)},{SetCDeaths(FP,Add,7,CBulletT)},{Preserved})
	DoActionsX(FP,SetCDeaths(FP,Subtract,1,CBulletT))
	CElseIfX(CVar(FP,VResetSw5[2],Exactly,0),SetCVar(FP,VResetSw5[2],SetTo,1))
	local DResetTable = {}
	for j, k in pairs(LyricsCCode) do
		table.insert(DResetTable,SetCDeaths(FP,SetTo,0,k))
	end
	for j, k in pairs(PatternCcode) do
		table.insert(DResetTable,SetCDeaths(FP,SetTo,0,k))
	end
	DoActionsX(FP,DResetTable)
	CallTrigger(FP,Call_VoidReset)

	DoActionsX(FP,{
		SetCDeaths(FP,SetTo,1,Destr0yerClear),SetDeaths(FP,SetTo,0,BGMLength)
	})

	f_ArrReset()
	CIfXEnd()
	CIf(FP,CDeaths(FP,AtLeast,1,Destr0yerClear))
		local ClearText1 = "\n\n\n\n\x13\x04������������������������������������������������������������������������������������������������������������\n\x13\x04��������\x07�£ϣӣӡ��ạ̃ţ���\x04��������\n\x14\n\x14\n\x13\x04\x07�� \x08��\x04������\x10��\x04�����\x07 �� \x04���Լ� ��Ƴ����̽��ϴ�.\x13\n\x14\n\n\x14\n\x13\x04��������\x07�£ϣӣӡ��ạ̃ţ���\x04��������\n\x13\x04������������������������������������������������������������������������������������������������������������"
		local ClearText2 = "\n\n\n\n\x13\x04������������������������������������������������������������������������������������������������������������\n\n\x14\n\x14\n\n\x13\x04������ ������Դϴ�...\n\x14\n\x14\n\n\x13\x04������������������������������������������������������������������������������������������������������������"
		local ClearTimer = CreateCCode()
		local ClearSw1 = CreateCCode()
		local ClearSw2 = CreateCCode()
		TriggerX(FP,{CDeaths(FP,AtMost,0,ClearTimer)},{RotatePlayer({PlayWAVX("staredit\\wav\\DClear.ogg"),PlayWAVX("staredit\\wav\\DClear.ogg"),DisplayTextX(ClearText1,4)},HumanPlayers,FP),SetCDeaths(FP,SetTo,1,ClearTimer)},{Preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,3000,ClearTimer),CDeaths(FP,AtMost,0,ClearSw1)},{RotatePlayer({PlayWAVX("staredit\\wav\\CalcSE.ogg"),PlayWAVX("staredit\\wav\\CalcSE.ogg"),DisplayTextX(ClearText2,4)},HumanPlayers,FP),SetCDeaths(FP,SetTo,1,ClearSw1)},{Preserved})
		CAdd(FP,_Ccode("X",ClearTimer),Dt)
		CIf(FP,{CDeaths(FP,AtLeast,3000+3000,ClearTimer),CDeaths(FP,AtMost,0,ClearSw2)},SetCDeaths(FP,SetTo,1,ClearSw2))
			CallTrigger(FP,Call_ScorePrint,{SetCDeaths(FP,SetTo,1,isDBossClear)})
		CIfEnd()
		CIf(FP,CDeaths(FP,AtLeast,3000+6000,ClearTimer))
		CIfX(FP,{TCVar(FP,TotalScore[2],AtLeast,OutputPoint),CVar(FP,TotalScore[2],AtMost,0x7FFFFFFF)}) --  ����������
		local ClearScoreT = "\n\n\n\n\x13\x04������������������������������������������������������������������������������������������������������������\n\x13\x04��������\x07�£ϣӣӡ��ạ̃ţ���\x04��������\n\x14\n\x14\n\x13\x04\x07�� \x08��\x04������\x10��\x04�����\x07 �� \x04���Լ� ��Ƴ����̽��ϴ�.\n\x13\x1F�����մϴ�! \x04������ ����Ͽ� \x07���� �ܰ� ���� ����\x04�մϴ�.\x14\n\n\x14\n\x13\x04��������\x07�£ϣӣӡ��ạ̃ţ���\x04��������\n\x13\x04������������������������������������������������������������������������������������������������������������"
		DoActionsX(FP,{RotatePlayer({DisplayTextX(ClearScoreT,4),PlayWAVX("staredit\\wav\\Level_Clear.ogg"),PlayWAVX("staredit\\wav\\Level_Clear.ogg"),PlayWAVX("staredit\\wav\\Level_Clear.ogg")},HumanPlayers,FP),
			SetCDeaths(FP,SetTo,1,Destr0yerClear2)})
		CElseX()--  �����Ҹ�����
		DoActions2(FP,RotatePlayer({
			DisplayTextX(string.rep("\n", 20),4),
			DisplayTextX("\x13\x04"..string.rep("��", 56),4),
			DisplayTextX("\x13\x05�ǣ��ͣš��ϣ֣ţ�",4),
			DisplayTextX("\n",4),
			DisplayTextX("\x13\x15������ ������� �ʾ� ���� �ܰ� ������ �Ұ����մϴ�...\n",4);
			DisplayTextX("\x13\x05������ �����մϴ�.",4);
			DisplayTextX("\n",4),
			DisplayTextX("\x13\x05�ǣ��ͣš��ϣ֣ţ�",4),
			DisplayTextX("\x13\x04"..string.rep("��", 56),4),
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
--SetMemoryX(0x66655C, SetTo, 65536*961,0xFFFF0000) -- �����Ҷ�
end