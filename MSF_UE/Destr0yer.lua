function Install_Destr0yer()
	
local Lyrics = {
	{"\x13\x06※ \x04Ladies and Gentlemen \x06※",2,222},
	{"\x13\x06※ \x07Let's start \x06※",5,0},
	{"\x13\x06※ \x04Only is in Memories \x06※",8,0},
	{"\x13\x06※ \x08Tonight. \x06※",12,333},
	{"\x13\x07♪\x04 I wonder why things have \x03happened\x04. \x07♪\n\x13\x07♪\x04 왜 \x03이런 일들\x04이 일어났는지 궁금해. \x07♪",60-3,0},
	{"\x13\x07♪\x04 \x1DCould you imagine \x04the world is \x1Cboring\x04? \x07♪\n\x13\x07♪\x04 이 세상은 \x1C따분한 \x04걸, \x1D넌 알고 있니? \x07♪",68-3,0},
	{"\x13\x07♪\x08 Stereotype \x07♪\n\x13\x07♪\x08 고정관념 \x07♪",76-3,0},
	{"\x13\x07♪\x0E Sham \x07♪\n\x13\x07♪\x0E 엉터리 \x07♪",78-3,444},
	{"\x13\x07♪\x0F Brain Freeze \x07♪\n\x13\x07♪\x0F 브레인 프리즈 \x07♪",79-3,444},
	{"\x13\x07♪\x10 Collusion \x07♪\n\x13\x07♪\x10 공모 \x07♪",80-3,222},
	{"\x13\x07♪\x1F Mental block \x07♪\n\x13\x07♪\x1F 정신적 블록 \x07♪",82-3,333},
	{"\x13\x07♪\x04 The world is \x1Bfading\x04. \x07♪\n\x13\x07♪\x04 세계는 \x1B사라져 가고\x04, \x07♪",83-3,222},
	{"\x13\x07♪\x04 I know the \x08( \x11Ｆ\x04ａｔｅ \x08)\x04. \x07♪\n\x13\x07♪\x04 그 \x08( \x11운\x04명 \x08)\x04은 난 알고 있어. \x07♪",86-3,333},
	{"\x13\x07♪\x04 The world is \x1Bfading\x04. \x07♪\n\x13\x07♪\x04 세계는 \x1B사라지고\x04, \x07♪",88-3,444},
	{"\x13\x07♪\x04 I know the \x08( \x11Ｆ\x04ａｔｅ \x08)\x04. \x07♪\n\x13\x07♪\x04 나는 그 \x08( \x11운\x04명 \x08)\x04을 아는걸. \x07♪",90-3,444},
	{"\x13\x07♪\x04 I know \x07all of you\x04. \x07♪\n\x13\x07♪\x04 나는 너희를 \x07모두 아는데\x04, \x07♪",91-3,0},
	{"\x13\x07♪\x04 Have you, you, \x10followed me\x04? \x07♪\n\x13\x07♪\x04 너희는, 너희는, 날 \x10쫓아오기라도 했니\x04? \x07♪",95-3,444},
	{"\x13\x07♪\x04 Me in your mind is the \x1Fdream\x04. \x07♪\n\x13\x07♪\x04 너희 마음 속의 나는 \x1F꿈\x04인걸. \x07♪",99-3,0},
	{"\x13\x07♪\x04 The dream of the \x10 ( \x11Ｐ\x04ａｓｔ \x10) \x04. \x07♪\n\x13\x07♪\x04 \x10 ( \x11과\x04거 \x10) \x04의 꿈. \x07♪",105-3,333},
	{"\x13\x07♪\x04 So I would \x08forget \x04you. \x07♪\n\x13\x07♪\x04 난 너희를 \x08잊을\x04테니, \x07♪",107-3,0},
	{"\x13\x07♪\x11 Let you forget me. \x07♪\n\x13\x07♪\x11 너희도 날 잊어줘. \x07♪",111-3,0},
	{"\x13\x07♪\x04 'Cause I'm \x07『 \x08Ｄ\x04ｅｓｔｒ\x10０\x04ｙｅｒ\x07 』 \x07♪\n\x13\x07♪\x04 왜냐면 나는 \x07『 \x08파\x10괴\x04자\x07 』\x04이니까. \x07♪",115-3,333},
	{"\x13\x07♪\x08 I kill us all. \x07♪\n\x13\x07♪\x08 다 끝장내겠어. \x07♪",138-3,0},
	{"\x13\x07♪\x10 It's the only way. \x07♪\n\x13\x07♪\x10 이 길 뿐이야. \x07♪",151-3,333},
	{"\x13\x07♪\x06 It's over. \x07♪\n\x13\x07♪\x06 다 끝났어. \x07♪",153-3,0},
	{"\x13\x07♪\x08 I will kill. \x07♪\n\x13\x07♪\x08 끝장내겠어. \x07♪",159-3,333},
	{"\x13\x07♪\x04 I will \x07『 \x08Ｄ\x04ｅｓｔｒ\x10０\x04ｙ\x07 』\x04 the world. \x07♪\n\x13\x07♪\x04 내가 세상을 \x07『 \x08파\x10괴\x07 』 \x04하겠어. \x07♪",161-3,333},
	{"\x13\x07♪\x04 No matter what you do, \x0FI don't stop\x04. \x07♪\n\x13\x07♪\x04 너희가 뭐래도, \x0F멈추지 않아\x04. \x07♪",165-3,500},
	{"\x13\x07♪\x04 I'm the only one \x1Fwho's right\x04. \x07♪\n\x13\x07♪\x04 나만이 \x1F진리\x04이기에. \x07♪",168-3,0},
	{"\x13\x07♪\x08 I will kill. \x07♪\n\x13\x07♪\x08 끝장내겠어. \x07♪",175-3,333},
	{"\x13\x07♪\x04 I will \x07『 \x08Ｄ\x04ｅｓｔｒ\x10０\x04ｙ\x07 』\x04 the world. \x07♪\n\x13\x07♪\x04 내가 세상을 \x07『 \x08파\x10괴\x07 』 \x04하겠어. \x07♪",177-3,444},
	{"\x13\x07♪\x04 No matter what you do, \x0FI don't stop\x04. \x07♪\n\x13\x07♪\x04 너희가 뭐래도, \x0F멈추지 않아\x04. \x07♪",181-3,500},
	{"\x13\x07♪\x15 It is what it is. \x07♪\n\x13\x07♪\x15 뭐 어쩌겠어. \x07♪",184-3,0},
	{"\x13\x07♪\x1E It is what it is. \x07♪\n\x13\x07♪\x1E 원래 이랬는걸. \x07♪",188-3,0},
	{"\x13\x07♪\x04 It is not. It's not \x08my fault\x04. \x07♪\n\x13\x07♪\x04 아냐. \x08내 잘못\x04이 아냐. \x07♪",192-3,0},
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
	--if TestStart == 1 then
		--CIfX(FP,{Bring(FP,AtLeast,1,186,64)},{SetMemoryX(0x66655C, SetTo, 65536*210,0xFFFF0000),SetCVar(FP,VResetSw5[2],SetTo,0)})
	--else	
		CIfX(FP,{TTOR({Bring(FP,AtLeast,1,186,64),TTAND({DeathsX(FP,AtLeast,1,BGMLength,0xFFFFFF),DeathsX(FP,AtMost,271,BGMLength,0xFFFFFF)})})},{SetMemoryX(0x66655C, SetTo, 65536*210,0xFFFF0000),SetCVar(FP,VResetSw5[2],SetTo,0)})
	--end
	
	local DTotalDmg = CreateVar(FP)
	CIf(FP,{CVar(FP,DPtr[2],AtLeast,1),CVar(FP,DPtr[2],AtMost,0x7FFFFFFF)})
		CIf(FP,{TTMemory(_Add(DPtr,2),NotSame,DcurHP)})
			f_Read(FP,_Add(DPtr,2),DHP)
			CAdd(FP,DTotalDmg,_Sub(DcurHP,DHP))
			CMov(FP,DcurHP,DHP)
		CIfEnd()
	CIfEnd()
	if TestStart == 1 then
		for i = 0, 6 do
			CMov(FP,0x57f120 + (4*i),DTotalDmg)
		end
	end
	Simple_SetLocX(FP,"DCenter",0,0,32,32,{MoveLocation("DCenter",186,FP,64)})
	TriggerX(FP,{CDeaths(FP,AtLeast,1,LockBossUnit)},{Order(186,FP,64,Move,"DCenter")},{Preserved})
	
	CIf(FP,{DeathsX(FP,AtMost,(66*4),BGMLength,0xFFFFFF),Memory(0x628438,AtLeast,1)})
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
	local PatternCcode = {}
	function Create_PatternCcode(Table)
		local TempCcode = CreateCCode()
		table.insert(Table,TempCcode)
		return TempCcode
	end
	local Angle1 = CreateVar(FP)
	local Angle2 = CreateVar(FP)
	local Angle3 = CreateVar(FP)
	local Angle4 = CreateVar(FP)
	local Angle5 = CreateVar(FP)
	local Angle6 = CreateVar(FP)
	for i = 0, 3 do
		local Pat1 = Create_PatternCcode(PatternCcode)
		CIf(FP,{DeathsX(FP,Exactly,13+i,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1)})
			CSPlot(CSMakePolygon(32,160,0,33,1),FP,193,"DCenter",nil,1,32,FP,nil,nil,1)
			CSPlot(CSMakePolygon(32,160,0,33,1),FP,94,"DCenter",nil,1,32,FP,nil,nil,1)
			DoActionsX(FP,{SetMemoryB(0x6636B8 + 193, SetTo, 130),SetInvincibility(Enable,193,P8,64),GiveUnits(All,94,P8,64,P11),GiveUnits(All,193,P8,64,P11),Order(94,P11,64,Move,"DCenter"),Order(193,P11,64,Move,"DCenter")})
			if i == 0 then
				local Randnum = f_CRandNum(43)
				CMov(FP,Angle1,Randnum)
				CMov(FP,Angle2,Randnum,13)
				CMov(FP,Angle3,Randnum,13*2)
				CMov(FP,Angle4,Randnum,-13)
				CMov(FP,Angle5,Randnum,-13*2)
			end
		CIfEnd()
	end
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,13,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetMemoryW(0x657998+(127*2), SetTo, 0);SetMemoryX(0x665E44, SetTo, 0,0xFF000000)},{Preserved})
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
	TriggerX(FP,{DeathsX(FP,Exactly,17,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),KillUnit(94,P11),SetMemoryW(0x657998+(127*2), SetTo, 3);SetMemoryX(0x665E44, SetTo, 16777216,0xFF000000)},{Preserved})
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,20,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetMemoryW(0x657998+(208*2), SetTo, 0);SetMemoryX(0x665E44, SetTo, 0,0xFF000000),SetMemory(0x6509B0, SetTo, FP),GiveUnits(All,193,P11,64,P8),RunAIScriptAt(JYD,64)},{Preserved})
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,21,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetMemoryB(0x6636B8 + 193, SetTo, 55),SetInvincibility(Disable,193,P8,64)},{Preserved})

	
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(13*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetCDeaths(FP,SetTo,1,LockBossUnit)},{Preserved})
	
	
	for i = 0, 3 do
		local Pat1 = Create_PatternCcode(PatternCcode)
		CIf(FP,{DeathsX(FP,Exactly,(29*4)+1+i,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1)})
		CSPlot(CSMakePolygon(32,160,0,33,1),FP,193,"DCenter",nil,1,32,FP,nil,nil,1)
		CSPlot(CSMakePolygon(32,160,0,33,1),FP,94,"DCenter",nil,1,32,FP,nil,nil,1)
		DoActionsX(FP,{SetMemoryB(0x6636B8 + 193, SetTo, 130),SetInvincibility(Enable,193,P8,64),GiveUnits(All,94,P8,64,P11),GiveUnits(All,193,P8,64,P11),Order(94,P11,64,Move,"DCenter"),Order(193,P11,64,Move,"DCenter")})
			if i == 0 then
				local Randnum = f_CRandNum(43)
				CMov(FP,Angle1,Randnum)
				CMov(FP,Angle2,Randnum,13)
				CMov(FP,Angle3,Randnum,13*2)
				CMov(FP,Angle4,Randnum,-13)
				CMov(FP,Angle5,Randnum,-13*2)
			end
		CIfEnd()
	end
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(29*4)+1,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetMemoryW(0x657998+(127*2), SetTo, 0);SetMemoryX(0x665E44, SetTo, 0,0xFF000000)},{Preserved})
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
	TriggerX(FP,{DeathsX(FP,Exactly,(30*4)+1,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),KillUnit(94,P11),SetMemoryW(0x657998+(127*2), SetTo, 3);SetMemoryX(0x665E44, SetTo, 16777216,0xFF000000)},{Preserved})
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(30*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetMemoryW(0x657998+(127*2), SetTo, 0);SetMemoryX(0x665E44, SetTo, 0,0xFF000000),SetMemory(0x6509B0, SetTo, FP),GiveUnits(All,193,P11,64,P8),RunAIScriptAt(JYD,64),SetCDeaths(FP,SetTo,0,LockBossUnit)},{Preserved})
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(30*4)+1+4,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetMemoryB(0x6636B8 + 193, SetTo, 55),SetInvincibility(Disable,193,P8,64)},{Preserved})
	
	for i = 0, 2 do
		local Pat1 = Create_PatternCcode(PatternCcode)
		CIf(FP,{DeathsX(FP,Exactly,(34*4)+1+i,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetCDeaths(FP,SetTo,1,LockBossUnit)})
		CSPlot(CSMakePolygon(32,160,0,33,1),FP,193,"DCenter",nil,1,32,FP,nil,nil,1)
		CSPlot(CSMakePolygon(32,160,0,33,1),FP,94,"DCenter",nil,1,32,FP,nil,nil,1)
		DoActionsX(FP,{SetMemoryB(0x6636B8 + 193, SetTo, 130),SetInvincibility(Enable,193,P8,64),GiveUnits(All,94,P8,64,P11),GiveUnits(All,193,P8,64,P11),Order(94,P11,64,Move,"DCenter"),Order(193,P11,64,Move,"DCenter")})
		CIfEnd()
	end	
	local Pat1 = Create_PatternCcode(PatternCcode)
	CIf(FP,{DeathsX(FP,Exactly,(34*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1)})
	DoActionsX(FP,{SetCDeaths(FP,SetTo,0,LockBossUnit),SetMemoryW(0x657998+(127*2), SetTo, 3);SetMemoryX(0x665E44, SetTo, 16777216,0xFF000000),SetMemory(0x6509B0, SetTo, FP),GiveUnits(All,193,P11,64,P8),RunAIScriptAt(JYD,64),KillUnit(94,P11)})
		GetLocCenter("DCenter",CPosX,CPosY)
		local Randnum = f_CRandNum(43)
		CMov(FP,Angle1,Randnum)
		CMov(FP,Angle2,Randnum,13)
		CMov(FP,Angle3,Randnum,13*2)
		CMov(FP,Angle4,Randnum,-13)
		CMov(FP,Angle5,Randnum,-13*2)
		CreateBullet(208,20,Angle1,CPosX,CPosY)
		CreateBullet(208,20,Angle2,CPosX,CPosY)
		CreateBullet(208,20,Angle3,CPosX,CPosY)
		CreateBullet(208,20,Angle4,CPosX,CPosY)
		CreateBullet(208,20,Angle5,CPosX,CPosY)
		--CreateBullet(208,20,Angle6,CPosX,CPosY)
	CIfEnd()
	
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(34*4)+1+4,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetInvincibility(Disable,193,P8,64),SetMemoryB(0x6636B8 + 193, SetTo, 55)},{Preserved})
	for i = 0, 3 do
		local Pat1 = Create_PatternCcode(PatternCcode)
		CIf(FP,{DeathsX(FP,Exactly,(48*4)+1+i,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetCDeaths(FP,SetTo,1,LockBossUnit)})
		CSPlot(CSMakePolygon(32,160,0,33,1),FP,193,"DCenter",nil,1,32,FP,nil,nil,1)
		CSPlot(CSMakePolygon(32,160,0,33,1),FP,94,"DCenter",nil,1,32,FP,nil,nil,1)
		DoActionsX(FP,{SetMemoryB(0x6636B8 + 193, SetTo, 130),SetInvincibility(Enable,193,P8,64),GiveUnits(All,94,P8,64,P11),GiveUnits(All,193,P8,64,P11),Order(94,P11,64,Move,"DCenter"),Order(193,P11,64,Move,"DCenter")})
			if i == 0 then
				local Randnum = f_CRandNum(43)
				CMov(FP,Angle1,Randnum)
				CMov(FP,Angle2,Randnum,13)
				CMov(FP,Angle3,Randnum,13*2)
				CMov(FP,Angle4,Randnum,-13)
				CMov(FP,Angle5,Randnum,-13*2)
			end
		CIfEnd()
	end
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(48*4)+1,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetMemoryW(0x657998+(127*2), SetTo, 0);SetMemoryX(0x665E44, SetTo, 0,0xFF000000)},{Preserved})
	
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
	local BursterCall = CreateCCode()
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(49*4)+1,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{KillUnit(94,P11),SetCDeaths(FP,SetTo,1,Pat1),SetMemoryW(0x657998+(127*2), SetTo, 3);SetMemoryX(0x665E44, SetTo, 16777216,0xFF000000)},{Preserved})
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(49*4)+1+3,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetCDeaths(FP,SetTo,1,BursterCall),SetMemoryW(0x657998+(127*2), SetTo, 0);SetMemoryX(0x665E44, SetTo, 0,0xFF000000),SetMemory(0x6509B0, SetTo, FP),GiveUnits(All,193,P11,64,P8),RunAIScriptAt(JYD,64)},{Preserved})
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(49*4)+1+4,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetMemoryB(0x6636B8 + 193, SetTo, 55),SetInvincibility(Disable,193,P8,64)},{Preserved})
	local Pat1 = Create_PatternCcode(PatternCcode)
	TriggerX(FP,{DeathsX(FP,Exactly,(59*4)+1,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1),SetMemoryX(0x669FB4, SetTo, 16777216*10,0xFFFFFFFF),SetCDeaths(FP,SetTo,0,BursterCall)},{Preserved})
	local Pat1 = Create_PatternCcode(PatternCcode)
	local N_R,N_A,N_X,N_Y,N_A2,N_A3 = CreateVariables(6)
	CIf(FP,{CDeaths(FP,AtLeast,1,BursterCall)},SetCVar(FP,N_R[2],Add,2))
	
	CMov(FP,N_A,0)
	CAdd(FP,N_A2,1)
	CAdd(FP,N_A3,N_A2)
	CWhile(FP,{CVar(FP,N_A[2],AtMost,359)})
	f_lengthdir(FP,N_R,_Add(N_A,N_A3),N_X,N_Y)
	GetLocCenter("DCenter",CPosX,CPosY)
	CAdd(FP,N_X,CPosX)
	CAdd(FP,N_Y,CPosY)

	CIfX(FP,{CVar(FP,N_X[2],AtMost,4096),CVar(FP,N_Y[2],AtMost,4096)})
	Simple_SetLocX(FP,0,_Add(N_X,-16),_Add(N_Y,-16),_Add(N_X,16),_Add(N_Y,16),{
		CreateUnit(1,94,1,FP),
		KillUnit(94,FP),
		KillUnitAt(All,"Men",1,Force1),
	})
	CIfXEnd()

	CAdd(FP,N_A,12)
	CWhileEnd()

	CIfEnd()

	local TotalDmgVA = CreateVarray(FP,13)
	local Pat1 = Create_PatternCcode(PatternCcode)
	CIf(FP,{DeathsX(FP,Exactly,(66*4)+1,BGMLength,0xFFFFFF),CDeaths(FP,AtMost,0,Pat1)},{SetCDeaths(FP,SetTo,1,Pat1)})
		f_Div(FP,DTotalDmg,_Mov(256))
		ItoDecX(FP,DTotalDmg,VArr(TotalDmgVA,0),2,0x7,2)
		_0DPatchX(FP,TotalDmgVA,12)
		f_MemCpy(FP,DBoss_PrintScore2,_TMem(Arr(DBossTotalDMGT[3],0),"X","X",1),DBossTotalDMGT[2])
		f_Movcpy(FP,_Add(DBoss_PrintScore2,DBossTotalDMGT[2]),VArr(TotalDmgVA,0),12*4)
		for i = 1, 7 do
		CAdd(FP,ExScore[i],DTotalDmg)
		end
		DoActionsX(FP,{SetCVar(FP,DPtr[2],SetTo,0),SetCVar(FP,DHP[2],SetTo,0),SetCVar(FP,DcurHP[2],SetTo,0),SetCVar(FP,DTotalDmg[2],SetTo,0)})
		DoActions(FP,RotatePlayer({DisplayTextX("\x0D\x0D\x0DDBossDMG".._0D,4)},HumanPlayers,FP))
		DoActionsX(FP,{CreateUnitWithProperties(1,94,"DCenter",FP,{hallucinated = true}),RemoveUnit(186,FP),killUnit(94,FP),ModifyUnitEnergy(All,193,FP,64,0),RemoveUnit(193,FP)})
	CIfEnd()

	for i = 0, #BGMArr-1 do
		Trigger { -- 상시브금
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
	DoActions2X(FP,DResetTable)
	CallTrigger(FP,Call_VoidReset)

	DoActionsX(FP,{
		SetCDeaths(FP,SetTo,1,Destr0yerClear),SetDeaths(FP,SetTo,0,BGMLength),SetCVar(FP,N_R[2],SetTo,0)
	})

	f_ArrReset()
	CIfXEnd()
	CIf(FP,CDeaths(FP,AtLeast,1,Destr0yerClear))
		local ClearText1 = "\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x07ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x14\n\x14\n\x13\x04\x07『 \x08Ｄ\x04ｅｓｔｒ\x10０\x04ｙｅｒ\x07 』 \x04에게서 살아남으셨습니다.\x13\n\x14\n\n\x14\n\x13\x04！！！　\x07ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
		local ClearText2 = "\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\n\x14\n\x14\n\n\x13\x04점수를 계산중입니다...\n\x14\n\x14\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
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
		CIfX(FP,{TCVar(FP,TotalScore[2],AtLeast,OutputPoint),CVar(FP,TotalScore[2],AtMost,0x7FFFFFFF)}) --  점수만족시
		local ClearScoreT = "\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x07ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x14\n\x14\n\x13\x04\x07『 \x08Ｄ\x04ｅｓｔｒ\x10０\x04ｙｅｒ\x07 』 \x04에게서 살아남으셨습니다.\n\x13\x1F축하합니다! \x04점수가 충분하여 \x07다음 단계 진입 가능\x04합니다.\x14\n\n\x14\n\x13\x04！！！　\x07ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
		DoActionsX(FP,{RotatePlayer({DisplayTextX(ClearScoreT,4),PlayWAVX("staredit\\wav\\Level_Clear.ogg"),PlayWAVX("staredit\\wav\\Level_Clear.ogg"),PlayWAVX("staredit\\wav\\Level_Clear.ogg")},HumanPlayers,FP),
			SetCDeaths(FP,SetTo,1,Destr0yerClear2)})
		CElseX()--  점수불만족시
		DoActions2(FP,RotatePlayer({
			DisplayTextX(string.rep("\n", 20),4),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			DisplayTextX("\x13\x05ＧＡＭＥ　ＯＶＥＲ",4),
			DisplayTextX("\n",4),
			DisplayTextX("\x13\x15점수가 충분하지 않아 다음 단계 진입이 불가능합니다...\n",4);
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