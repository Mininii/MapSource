function Install_IdenBoss()


	-- 아칸 보스
	-- from MSF Identity OpenSource
	-- Thanks to Ninfia
	--------0x58F55C : BossCunit
	--"CLoc109" : 30
Id_T0C = CreateCCode()
Id_T1C = CreateCCode()
Id_T2C = CreateCCode()
Id_T3C = CreateCCode()
Id_T4C = CreateCCode()
Id_T5C = CreateCCode()
StoryT2 = CreateCCode()
function StoryPrint(T,Print,Flag,AddTrig,StoryCcode)
	if StoryCcode == nil then
		StoryCcode = StoryT
	end
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,T,StoryCcode);
			CDeaths(FP,AtMost,0,Flag);

		},
		actions = {
			RotatePlayer(Print,HumanPlayers,FP);
			SetCDeaths(FP,Add,1,Flag);
			AddTrig,
			PreserveTrigger();
		},
	}
	end
CIf(FP,CDeaths(FP,AtLeast,1,StoryT))
CAdd(FP,_Ccode("X",StoryT),Dt)
Id_T0 = "\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n \x13\x02코스크 충들\x04의 \x08레갈 성 \x15서문 요새\x04가 \x07배고픈 마린들\x04에게 \x08함락\x04되었습니다."
Id_T1 = "\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n   \x07 :: \x1F배\x02고픈 \x11마\x03린들 \x07::\r\n\x1B여기\x04가 \x08놈\x04의 본거지군. 진진짜라를 내놓아라 \x08타림.\r\n\r\n  "
Id_T2 = "\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n   \x08:: \x11진진 \x1B짜라의 주인 \x08타\x15림 \x08::\r\n\x08버러지\x1B같은 \x06그지들 주제\x1B에 감히 어디서 그 이름을 입에 함부로 놀리는 것이냐?\r\n\r\n "
Id_T3 = "\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n   \x07 :: \x1F배\x02고픈 \x11마\x03린들 \x07::\r\n\x08닥쳐라. \x1B견딜 수 없는 허기\x04가 \x1B몰려오는 것\x04을 더 이상 두고 볼 수 없다.\r\n\x15타림, \x04네놈의 \x1B그 라면\x04을 가져가겠다.\r\n\r\n  "
Id_T4 = "\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n   \x08:: \x11진진 \x1B짜라의 주인 \x08타\x15림 \x08::\r\n\x1B어쩔 수 없군. 내가 직접 나서서 \x08저 그지 놈들\x1B을 처리하겠다.\r\n\r\n "
Id_T5 = "\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n \x13\x11진진 \x15짜라의 \x1B주인 \x08타\x06림\x04이 \x08등장\x04하였습니다.\r\n\x13\x1FS\x04heild \x022,000 \x03/// \x07H\x04ealth \x1D??,???,???\r\n\x13\x1B\"내가 직접 나서서 저 빌어먹을 그지새끼들을 한 놈도 빠짐없이 라면통에 쳐박아주마.\""

StoryPrint(6000*(0),{
	PlayWAVX("staredit\\wav\\button3.wav");
	PlayWAVX("staredit\\wav\\button3.wav");
	PlayWAVX("staredit\\wav\\button3.wav");
	DisplayTextX(Id_T0,4);
},Id_T0C) 
StoryPrint(6000*(1),{
	TalkingPortrait(0, 9148);
	PlayWAVX("sound\\Terran\\MARINE\\TMaPss04.WAV");
	PlayWAVX("sound\\Terran\\MARINE\\TMaPss04.WAV");
	DisplayTextX(Id_T1,4);
},Id_T1C) 
StoryPrint(6000*(2),{
	TalkingPortrait(68, 6100);
	PlayWAVX("sound\\Protoss\\ARCHON\\PArPss01.WAV");
	PlayWAVX("sound\\Protoss\\ARCHON\\PArPss01.WAV");
	DisplayTextX(Id_T2,4);
},Id_T2C) 
StoryPrint(6000*(3),{
	TalkingPortrait(0, 9148);
	PlayWAVX("sound\\Terran\\MARINE\\TMaPss06.WAV");
	PlayWAVX("sound\\Terran\\MARINE\\TMaPss06.WAV");
	DisplayTextX(Id_T3,4);
},Id_T3C) 
StoryPrint(6000*(4),{
	TalkingPortrait(68, 6100);
	PlayWAVX("sound\\Protoss\\ARCHON\\PArPss02.WAV");
	PlayWAVX("sound\\Protoss\\ARCHON\\PArPss02.WAV");
	DisplayTextX(Id_T4,4);
},Id_T4C) 
StoryPrint(6000*(5),{
	TalkingPortrait(68, 6100);
	PlayWAVX("sound\\Protoss\\ARCHON\\PArPss00.WAV");
	PlayWAVX("sound\\Protoss\\ARCHON\\PArPss00.WAV");
	DisplayTextX(Id_T5,4);
},Id_T5C,{SetCDeaths(FP,SetTo,1,StoryT2)}) 
CIf(FP,CDeaths(FP,AtLeast,1,StoryT2),SetCDeaths(FP,SetTo,0,StoryT2)) -- 소환
f_Read(FP,0x628438,nil,Nextptrs,0xFFFFFF)
CDoActions(FP,{
	CreateUnit(1,68,29,FP),
	TSetMemory(B_Id_C,SetTo,Nextptrs),
	TSetMemory(0x58F558,SetTo,7),
	SetCVar(FP,ReserveBGM[2],SetTo,IdenBGM),
	TSetMemory(_Add(Nextptrs,2),SetTo,_Add(_Mul(PCheckV,_Mov(1000*256)),_Mov(2000*256))),
	KillUnitAt(All,"Men",29,Force1),
})

CIfEnd()

CIfEnd()

CIf(FP,NTCond())
CIfX(FP,Bring(FP,AtLeast,1,"Tarim, Lord Of Regal Castle",64),SetCVar(FP,VResetSw2[2],SetTo,0))
CMov(FP,VO(41),LevelT2) -- Diff

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Memory(0x58F564,Exactly,0);
	},
	actions = {
		SetMemory(0x58F564,SetTo,1);
		PreserveTrigger();
	},
}

-- 커세어 생성 -> x1~4 Lv & 480까지 (속도 랜덤)
Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Memory(0x58F564,Exactly,1);
	},
	actions = {
		SetMemory(0x58DC60+0x14*30,SetTo,0),
		SetMemory(0x58DC64+0x14*30,SetTo,0),
		SetMemory(0x58DC68+0x14*30,SetTo,0),
		SetMemory(0x58DC6C+0x14*30,SetTo,0),
		MoveLocation("CLoc109","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		Order(60,P9,"Anywhere",Move,"CLoc109");
		PreserveTrigger();
	},
}
--커세어 생성구간
        FX = CreateVar(FP)
        FY = CreateVar(FP)
        FA = CreateVar(FP)
        FR = CreateVar(FP)
        Fx2 = CreateVar(FP)
        Fy2 = CreateVar(FP)
        Sh_Para = CreateVar(FP)



CIf(FP,Memory(0x58F564,Exactly,1))
DoActionsX(FP,SetCVar(FP,FA[2],Add,9))
CMov(FP,FR,16*32)
f_Lengthdir(FP,FR,FA,FX,FY)

DoActions(FP,{Simple_SetLoc(30,0,0,0,0),MoveLocation("CLoc109","Tarim, Lord Of Regal Castle",P8,"Anywhere")})
Simple_SetLoc2X(FP,30,FX,FY,FX,FY)
f_Read(FP,0x58DC60+0x14*30,Fx2,nil,0xFFFF)
f_Read(FP,0x58DC64+0x14*30,Fy2,nil,0xFFFF)
f_Recall(nil,Fx2,Fy2)
f_Recall(nil,Fx2,Fy2)
f_Read(FP,0x628438,nil,Sh_Para,0xFFFFFF)
CDoActions(FP,{
		CreateUnitWithProperties(1, 60, "CLoc109", P8, {invincible = true}),
		TSetDeathsX(_Add(Sh_Para,72),SetTo,0xFF*256,0,0xFF00),
		GiveUnits(All,60,P8,64,P9),
	})

	CIf(FP,Memory(0x594000+4*41, Exactly, 2))

	f_Lengthdir(FP,FR,_Add(FA,180),FX,FY)
	DoActions(FP,{Simple_SetLoc(30,0,0,0,0),MoveLocation("CLoc109","Tarim, Lord Of Regal Castle",P8,"Anywhere")})
	Simple_SetLoc2X(FP,30,FX,FY,FX,FY)
	f_Read(FP,0x58DC60+0x14*30,Fx2,nil,0xFFFF)
	f_Read(FP,0x58DC64+0x14*30,Fy2,nil,0xFFFF)
	f_Recall(nil,Fx2,Fy2)
	f_Recall(nil,Fx2,Fy2)
	f_Read(FP,0x628438,nil,Sh_Para,0xFFFFFF)
	CDoActions(FP,{
			CreateUnitWithProperties(1, 60, "CLoc109", P8, {invincible = true}),
			TSetDeathsX(_Add(Sh_Para,72),SetTo,0xFF*256,0,0xFF00),
			TSetDeathsX(_Add(Sh_Para,55),SetTo,0x200104,0,0x300104),
			TSetDeaths(_Add(Sh_Para,57),SetTo,0,0),
			GiveUnits(All,60,P8,64,P9),
		})
	CIfEnd()

	CIf(FP,Memory(0x594000+4*41, Exactly, 3))
	f_Lengthdir(FP,FR,_Add(FA,120),FX,FY)
	DoActions(FP,{Simple_SetLoc(30,0,0,0,0),MoveLocation("CLoc109","Tarim, Lord Of Regal Castle",P8,"Anywhere")})
	Simple_SetLoc2X(FP,30,FX,FY,FX,FY)
	f_Read(FP,0x58DC60+0x14*30,Fx2,nil,0xFFFF)
	f_Read(FP,0x58DC64+0x14*30,Fy2,nil,0xFFFF)
	f_Recall(nil,Fx2,Fy2)
	f_Recall(nil,Fx2,Fy2)
	f_Read(FP,0x628438,nil,Sh_Para,0xFFFFFF)
	CDoActions(FP,{
			CreateUnitWithProperties(1, 60, "CLoc109", P8, {invincible = true}),
			TSetDeathsX(_Add(Sh_Para,72),SetTo,0xFF*256,0,0xFF00),
			TSetDeathsX(_Add(Sh_Para,55),SetTo,0x200104,0,0x300104),
			TSetDeaths(_Add(Sh_Para,57),SetTo,0,0),
			GiveUnits(All,60,P8,64,P9),
		})
	f_Lengthdir(FP,FR,_Add(FA,240),FX,FY)
	DoActions(FP,{Simple_SetLoc(30,0,0,0,0),MoveLocation("CLoc109","Tarim, Lord Of Regal Castle",P8,"Anywhere")})
	Simple_SetLoc2X(FP,30,FX,FY,FX,FY)
	f_Read(FP,0x58DC60+0x14*30,Fx2,nil,0xFFFF)
	f_Read(FP,0x58DC64+0x14*30,Fy2,nil,0xFFFF)
	f_Recall(nil,Fx2,Fy2)
	f_Recall(nil,Fx2,Fy2)
	f_Read(FP,0x628438,nil,Sh_Para,0xFFFFFF)
	CDoActions(FP,{
			CreateUnitWithProperties(1, 60, "CLoc109", P8, {invincible = true}),
			TSetDeathsX(_Add(Sh_Para,72),SetTo,0xFF*256,0,0xFF00),
			TSetDeathsX(_Add(Sh_Para,55),SetTo,0x200104,0,0x300104),
			TSetDeaths(_Add(Sh_Para,57),SetTo,0,0),
			GiveUnits(All,60,P8,64,P9),
		})
CIfEnd()

CIf(FP,Memory(0x594000+4*41, Exactly, 4))
	f_Lengthdir(FP,FR,_Add(FA,90),FX,FY)
	DoActions(FP,{Simple_SetLoc(30,0,0,0,0),MoveLocation("CLoc109","Tarim, Lord Of Regal Castle",P8,"Anywhere")})
	Simple_SetLoc2X(FP,30,FX,FY,FX,FY)
	f_Read(FP,0x58DC60+0x14*30,Fx2,nil,0xFFFF)
	f_Read(FP,0x58DC64+0x14*30,Fy2,nil,0xFFFF)
	f_Recall(nil,Fx2,Fy2)
	f_Recall(nil,Fx2,Fy2)
	f_Read(FP,0x628438,nil,Sh_Para,0xFFFFFF)
	CDoActions(FP,{
			CreateUnitWithProperties(1, 60, "CLoc109", P8, {invincible = true}),
			TSetDeathsX(_Add(Sh_Para,72),SetTo,0xFF*256,0,0xFF00),
			TSetDeathsX(_Add(Sh_Para,55),SetTo,0x200104,0,0x300104),
			TSetDeaths(_Add(Sh_Para,57),SetTo,0,0),
			GiveUnits(All,60,P8,64,P9),
		})
	f_Lengthdir(FP,FR,_Add(FA,180),FX,FY)
	DoActions(FP,{Simple_SetLoc(30,0,0,0,0),MoveLocation("CLoc109","Tarim, Lord Of Regal Castle",P8,"Anywhere")})
	Simple_SetLoc2X(FP,30,FX,FY,FX,FY)
	f_Read(FP,0x58DC60+0x14*30,Fx2,nil,0xFFFF)
	f_Read(FP,0x58DC64+0x14*30,Fy2,nil,0xFFFF)
	f_Recall(nil,Fx2,Fy2)
	f_Recall(nil,Fx2,Fy2)
	f_Read(FP,0x628438,nil,Sh_Para,0xFFFFFF)
	CDoActions(FP,{
			CreateUnitWithProperties(1, 60, "CLoc109", P8, {invincible = true}),
			TSetDeathsX(_Add(Sh_Para,72),SetTo,0xFF*256,0,0xFF00),
			TSetDeathsX(_Add(Sh_Para,55),SetTo,0x200104,0,0x300104),
			TSetDeaths(_Add(Sh_Para,57),SetTo,0,0),
			GiveUnits(All,60,P8,64,P9),
		})
	f_Lengthdir(FP,FR,_Add(FA,270),FX,FY)
	DoActions(FP,{Simple_SetLoc(30,0,0,0,0),MoveLocation("CLoc109","Tarim, Lord Of Regal Castle",P8,"Anywhere")})
	Simple_SetLoc2X(FP,30,FX,FY,FX,FY)
	f_Read(FP,0x58DC60+0x14*30,Fx2,nil,0xFFFF)
	f_Read(FP,0x58DC64+0x14*30,Fy2,nil,0xFFFF)
	f_Recall(nil,Fx2,Fy2)
	f_Recall(nil,Fx2,Fy2)
	f_Read(FP,0x628438,nil,Sh_Para,0xFFFFFF)
	CDoActions(FP,{
			CreateUnitWithProperties(1, 60, "CLoc109", P8, {invincible = true}),
			TSetDeathsX(_Add(Sh_Para,72),SetTo,0xFF*256,0,0xFF00),
			TSetDeathsX(_Add(Sh_Para,55),SetTo,0x200104,0,0x300104),
			TSetDeaths(_Add(Sh_Para,57),SetTo,0,0),
			GiveUnits(All,60,P8,64,P9),
		})

CIfEnd()
DoActions(FP,RemoveUnit(33,P8))
CIfEnd()

CIf(FP,{Memory(0x58F564,AtLeast,1),Memory(0x58F564,AtMost,47)})
DoActions(FP,{SetMemory(0x58DC60+0x14*30,SetTo,0),
	SetMemory(0x58DC64+0x14*30,SetTo,0),
	SetMemory(0x58DC68+0x14*30,SetTo,0),
	SetMemory(0x58DC6C+0x14*30,SetTo,0),
	MoveLocation("CLoc109","Tarim, Lord Of Regal Castle",P8,"Anywhere"),
	Order(60, P9, "Anywhere", Move, "CLoc109"),
})
f_Read(FP,0x58DC60+0x14*30,Fx2,nil,0xFFFF)
f_Read(FP,0x58DC64+0x14*30,Fy2,nil,0xFFFF)
f_Recall(nil,Fx2,Fy2)

CIfEnd()
CIf(FP,Memory(0x58F564,AtLeast,100))

DoActions(FP,{SetMemory(0x58DC60+0x14*30,SetTo,0),
	SetMemory(0x58DC64+0x14*30,SetTo,0),
	SetMemory(0x58DC68+0x14*30,SetTo,0),
	SetMemory(0x58DC6C+0x14*30,SetTo,0),
	MoveLocation("CLoc109","Tarim, Lord Of Regal Castle",P8,"Anywhere"),
	Order(60, P9, "Anywhere", Move, "CLoc109"),
	})
	f_Read(FP,0x58DC60+0x14*30,Fx2,nil,0xFFFF)
	f_Read(FP,0x58DC64+0x14*30,Fy2,nil,0xFFFF)
	f_Recall(nil,Fx2,Fy2)

CIfEnd()

--
Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 1);
		Memory(0x58F564,Exactly,1);
		Bring(P9, AtLeast, 120, 60, "Anywhere");
	},
	actions = {
		SetMemory(0x58F564,SetTo,2);
		PreserveTrigger();
	},
}
Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 2);
		Memory(0x58F564,Exactly,1);
		Bring(P9, AtLeast, 240, 60, "Anywhere");
	},
	actions = {
		SetMemory(0x58F564,SetTo,2);
		PreserveTrigger();
	},
}
Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 3);
		Memory(0x58F564,Exactly,1);
		Bring(P9, AtLeast, 360, 60, "Anywhere");
	},
	actions = {
		SetMemory(0x58F564,SetTo,2);
		PreserveTrigger();
	},
}
Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 4);
		Memory(0x58F564,Exactly,1);
		Bring(P9, AtLeast, 480, 60, "Anywhere");
	},
	actions = {
		SetMemory(0x58F564,SetTo,2);
		PreserveTrigger();
	},
}
Trigger { -- 리콜 아칸에 생성
	players = {FP},
	conditions = {
		Memory(0x58F564,Exactly,2);
	},
	actions = {
		SetMemory(0x58F564,SetTo,100);
		PreserveTrigger();
	},
}

Trigger { -- 리콜 아칸에 생성
	players = {FP},
	conditions = {
		Void(41,Exactly, 1);
		Memory(0x58F564,AtLeast,100);
		Memory(0x58F564,AtMost,100+18*18);
	},
	actions = {
		SetMemory(0x58F564,Add,1);
		PreserveTrigger();
	},
}

Trigger { -- 리콜 아칸에 생성
	players = {FP},
	conditions = {
		Void(41,Exactly, 1);
		Memory(0x58F564,AtLeast,100+18*18);
	},
	actions = {
		SetMemory(0x58F564,SetTo,48);
		PreserveTrigger();
	},
}

Trigger { -- 리콜 아칸에 생성
	players = {FP},
	conditions = {
		Void(41,Exactly, 2);
		Memory(0x58F564,AtLeast,100);
		Memory(0x58F564,AtMost,100+18*15);
	},
	actions = {
		SetMemory(0x58F564,Add,1);
		PreserveTrigger();
	},
}

Trigger { -- 리콜 아칸에 생성
	players = {FP},
	conditions = {
		Void(41,Exactly, 2);
		Memory(0x58F564,AtLeast,100+18*15);
	},
	actions = {
		SetMemory(0x58F564,SetTo,48);
		PreserveTrigger();
	},
}

Trigger { -- 리콜 아칸에 생성
	players = {FP},
	conditions = {
		Void(41,Exactly, 3);
		Memory(0x58F564,AtLeast,100);
		Memory(0x58F564,AtMost,100+18*12);
	},
	actions = {
		SetMemory(0x58F564,Add,1);
		PreserveTrigger();
	},
}

Trigger { -- 리콜 아칸에 생성
	players = {FP},
	conditions = {
		Void(41,Exactly, 3);
		Memory(0x58F564,AtLeast,100+18*12);
	},
	actions = {
		SetMemory(0x58F564,SetTo,48);
		PreserveTrigger();
	},
}

Trigger { -- 리콜 아칸에 생성
	players = {FP},
	conditions = {
		Void(41,Exactly, 4);
		Memory(0x58F564,AtLeast,100);
		Memory(0x58F564,AtMost,100+18*6);
	},
	actions = {
		SetMemory(0x58F564,Add,1);
		PreserveTrigger();
	},
}

Trigger { -- 리콜 아칸에 생성
	players = {FP},
	conditions = {
		Void(41,Exactly, 4);
		Memory(0x58F564,AtLeast,100+18*6);
	},
	actions = {
		SetMemory(0x58F564,SetTo,48);
		PreserveTrigger();
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Memory(0x58F564,Exactly,48);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,96);
		SetMemory(0x58DC6C+0x14*31,SetTo,96);
		PreserveTrigger();
	},
}
Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Memory(0x58F564,Exactly,48);
	},
	actions = {
		SetMemory(0x58F564,SetTo,49);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		GiveUnits(All,60,P9,"Anywhere",FP);
		SetMemory(0x6509B0,SetTo,FP);
		RunAIScriptAt(JYD, "Anywhere");
		RotatePlayer({DisplayTextX("\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n   \x08:: \x11진진 \x1B짜라의 주인 \x08타\x15림 \x08::\r\n\x1B줴거하라.\r\n\r\n ",4),TalkingPortrait(68, 2000),
		PlayWAVX("sound\\Protoss\\ARCHON\\PArYes02.WAV"),PlayWAVX("sound\\Protoss\\ARCHON\\PArYes02.WAV")},HumanPlayers,FP);
		PreserveTrigger();
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Memory(0x58F564,AtLeast,49);
		Memory(0x58F564,AtMost,59);
	},
	actions = {
		SetMemory(0x58F564,Add,1);
		PreserveTrigger();
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Memory(0x58F564,Exactly,60);
	},
	actions = {
		SetMemory(0x58F564,SetTo,61);
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,96);
		SetMemory(0x58DC6C+0x14*31,SetTo,96);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		GiveUnits(All,60,P9,"Anywhere",FP);
		SetMemory(0x6509B0,SetTo,FP);
		RunAIScriptAt(JYD, "Anywhere");
		PreserveTrigger();
	},
}
-- 커세어 상하좌우/중심 방향으로 Remove
Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Memory(0x58F564,Exactly,61);
		Bring(FP, Exactly, 0, 60, "Anywhere");
	},
	actions = {
		SetMemory(0x58F564,SetTo,0);
		SetMemory(0x58F570,Add,1);
		PreserveTrigger();
	},
}

DoActions(P8,{SetMemory(0x58F560,Subtract,1),SetMemory(0x58F568,Subtract,1),ModifyUnitShields(All, "Tarim, Lord Of Regal Castle", FP, "Anywhere", 100)})

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Memory(0x58F564,AtLeast,1);
		Switch("Switch 34",Set);
	},
	actions = {
		SetMemory(0x58F564,SetTo,0);
		KillUnit(60,AllPlayers);
		PreserveTrigger();
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Memory(0x58F570,AtLeast,5);
	},
	actions = {
		SetMemory(0x58F570,SetTo,0);
		PreserveTrigger();
	},
}

local DX1 = CreateVar(FP)
local DY1 = CreateVar(FP)
local DZ1 = CreateVar(FP)
local Del = CreateVar(FP)
local Loc = CreateVar(FP)
local Num = CreateVar(FP)

TriggerX(FP,{Void(41,Exactly,1)},{
	SetCVar(FP,DX1[2],SetTo,2),
	SetCVar(FP,DY1[2],SetTo,1),
	SetCVar(FP,DZ1[2],SetTo,0)
},{Preserved})
TriggerX(FP,{Void(41,Exactly,2)},{
	SetCVar(FP,DX1[2],SetTo,4),
	SetCVar(FP,DY1[2],SetTo,1),
	SetCVar(FP,DZ1[2],SetTo,1)
},{Preserved})
TriggerX(FP,{Void(41,Exactly,3)},{
	SetCVar(FP,DX1[2],SetTo,6),
	SetCVar(FP,DY1[2],SetTo,1),
	SetCVar(FP,DZ1[2],SetTo,2)
},{Preserved})
TriggerX(FP,{Void(41,Exactly,4)},{
	SetCVar(FP,DX1[2],SetTo,8),
	SetCVar(FP,DY1[2],SetTo,2),
	SetCVar(FP,DZ1[2],SetTo,2)
},{Preserved})

CIf(FP,{Memory(0x58F564,Exactly,61),Void(42,Exactly,1)})
	CMov(FP,Del,0)
	DoActions(FP,{
		SetMemory(0x58DC60+0x14*31,SetTo,0),
		SetMemory(0x58DC68+0x14*31,SetTo,0),
		SetMemory(0x58DC64+0x14*31,SetTo,0),
		SetMemory(0x58DC6C+0x14*31,SetTo,0),
		SetMemory(0x58DC64+0x14*30,SetTo,0),
		SetMemory(0x58DC6C+0x14*30,SetTo,6144),
		SetMemoryX(0x669E28, SetTo, 16,0xFF),
	})
	local While = def_sIndex()
	local While2 = def_sIndex()
	CJumpEnd(FP,While)
	NWhile(FP,{TTCVar(FP,Del[2],"<",DX1)})
		CMov(FP,Loc,0)
		CMov(FP,Num,0)
		CJumpEnd(FP,While2)
		NWhile(FP,{TTCVar(FP,Loc[2],"<",3072-32),CVar(FP,Num[2],Exactly,0)})
			CDoActions(FP,{
				TSetMemory(0x58DC60+0x14*30,SetTo,Loc),
				TSetMemory(0x58DC68+0x14*30,SetTo,_Add(Loc,32)),
				RemoveUnitAt(1,47,"CLoc109",P8),
			})
			TriggerX(FP,{Bring(P8, AtLeast, 1, 60, "CLoc109")},
				{SetCVar(FP,Num[2],SetTo,1),
					MoveLocation("Shot", 60, P8, "CLoc109"),MoveLocation("CLoc115", 60, P8, "CLoc109"),
					GiveUnits(1,60,P8,"CLoc115",P12),
					RemoveUnit(60,P12),
					CreateUnitWithProperties(1, 47, "Start", P8, {hallucinated = true, invincible = true}),
					MoveUnit(All, 47, P8, "Start", "Shot"),
					KillUnit(47, P8),
					},{Preserved})
			CAdd(FP,Loc,32)
			CJump(FP,While2)
		NWhileEnd()
		CAdd(FP,Del,1)
		CJump(FP,While)
	NWhileEnd()
	DoActions(FP,SetMemoryX(0x669E28, SetTo, 0,0xFF))
CIfEnd()

CIf(FP,{Memory(0x58F564,Exactly,61),Void(42,Exactly,2)})
	CMov(FP,Del,0)
	DoActions(FP,{
		SetMemory(0x58DC60+0x14*31,SetTo,0),
		SetMemory(0x58DC68+0x14*31,SetTo,0),
		SetMemory(0x58DC64+0x14*31,SetTo,0),
		SetMemory(0x58DC6C+0x14*31,SetTo,0),
		SetMemory(0x58DC64+0x14*30,SetTo,0),
		SetMemory(0x58DC6C+0x14*30,SetTo,6144),
		SetMemoryX(0x669E28, SetTo, 16,0xFF),
	})
	local While = def_sIndex()
	local While2 = def_sIndex()
	CJumpEnd(FP,While)
	NWhile(FP,{TTCVar(FP,Del[2],"<",DX1)})
		CMov(FP,Loc,0)
		CMov(FP,Num,0)
		CJumpEnd(FP,While2)
		NWhile(FP,{TTCVar(FP,Loc[2],"<",3072-32),CVar(FP,Num[2],Exactly,0)})
			CDoActions(FP,{
				TSetMemory(0x58DC60+0x14*30,SetTo,_Sub(_Mov(3072-32),Loc)),
				TSetMemory(0x58DC68+0x14*30,SetTo,_Sub(_Mov(3072),Loc)),
				RemoveUnitAt(1,47,"CLoc109",P8),
			})
			TriggerX(FP,{Bring(P8, AtLeast, 1, 60, "CLoc109")},
				{SetCVar(FP,Num[2],SetTo,1),
					MoveLocation("Shot", 60, P8, "CLoc109"),MoveLocation("CLoc115", 60, P8, "CLoc109"),
					GiveUnits(1,60,P8,"CLoc115",P12),
					RemoveUnit(60,P12),
					CreateUnitWithProperties(1, 47, "Start", P8, {hallucinated = true, invincible = true}),
					MoveUnit(All, 47, P8, "Start", "Shot"),
					KillUnit(47, P8),
					},{Preserved})
			CAdd(FP,Loc,32)
			CJump(FP,While2)
		NWhileEnd()
		CAdd(FP,Del,1)
		CJump(FP,While)
	NWhileEnd()
	DoActions(FP,SetMemoryX(0x669E28, SetTo, 0,0xFF))
CIfEnd()

CIf(FP,{Memory(0x58F564,Exactly,61),Void(42,Exactly,3)})
	CMov(FP,Del,0)
	DoActions(FP,{
		SetMemory(0x58DC60+0x14*31,SetTo,0),
		SetMemory(0x58DC68+0x14*31,SetTo,0),
		SetMemory(0x58DC64+0x14*31,SetTo,0),
		SetMemory(0x58DC6C+0x14*31,SetTo,0),
		SetMemory(0x58DC60+0x14*30,SetTo,0),
		SetMemory(0x58DC68+0x14*30,SetTo,3072),
		SetMemoryX(0x669E28, SetTo, 16,0xFF),
	})
	local While = def_sIndex()
	local While2 = def_sIndex()
	CJumpEnd(FP,While)
	NWhile(FP,{TTCVar(FP,Del[2],"<",DX1)})
		CMov(FP,Loc,0)
		CMov(FP,Num,0)
		CJumpEnd(FP,While2)
		NWhile(FP,{TTCVar(FP,Loc[2],"<",6144-32),CVar(FP,Num[2],Exactly,0)})
			CDoActions(FP,{
				TSetMemory(0x58DC64+0x14*30,SetTo,Loc),
				TSetMemory(0x58DC6C+0x14*30,SetTo,_Add(Loc,32)),
				RemoveUnitAt(1,47,"CLoc109",P8),
			})
			TriggerX(FP,{Bring(P8, AtLeast, 1, 60, "CLoc109")},
				{SetCVar(FP,Num[2],SetTo,1),
					MoveLocation("Shot", 60, P8, "CLoc109"),MoveLocation("CLoc115", 60, P8, "CLoc109"),
					GiveUnits(1,60,P8,"CLoc115",P12),
					RemoveUnit(60,P12),
					CreateUnitWithProperties(1, 47, "Start", P8, {hallucinated = true, invincible = true}),
					MoveUnit(All, 47, P8, "Start", "Shot"),
					KillUnit(47, P8),
					},{Preserved})
			CAdd(FP,Loc,32)
			CJump(FP,While2)
		NWhileEnd()
		CAdd(FP,Del,1)
		CJump(FP,While)
	NWhileEnd()
	DoActions(FP,SetMemoryX(0x669E28, SetTo, 0,0xFF))
CIfEnd()
CIf(FP,{Memory(0x58F564,Exactly,61),Void(42,Exactly,4)})
	CMov(FP,Del,0)
	DoActions(FP,{
		SetMemory(0x58DC60+0x14*31,SetTo,0),
		SetMemory(0x58DC68+0x14*31,SetTo,0),
		SetMemory(0x58DC64+0x14*31,SetTo,0),
		SetMemory(0x58DC6C+0x14*31,SetTo,0),
		SetMemory(0x58DC60+0x14*30,SetTo,0),
		SetMemory(0x58DC68+0x14*30,SetTo,3072),
		SetMemoryX(0x669E28, SetTo, 16,0xFF),
	})
	local While = def_sIndex()
	local While2 = def_sIndex()
	CJumpEnd(FP,While)
	NWhile(FP,{TTCVar(FP,Del[2],"<",DX1)})
		CMov(FP,Loc,0)
		CMov(FP,Num,0)
		CJumpEnd(FP,While2)
		NWhile(FP,{TTCVar(FP,Loc[2],"<",6144-32),CVar(FP,Num[2],Exactly,0)})
			CDoActions(FP,{
				TSetMemory(0x58DC64+0x14*30,SetTo,_Sub(_Mov(6144-32),Loc)),
				TSetMemory(0x58DC6C+0x14*30,SetTo,_Sub(_Mov(6144),Loc)),
				RemoveUnitAt(1,47,"CLoc109",P8),
			})
			TriggerX(FP,{Bring(P8, AtLeast, 1, 60, "CLoc109")},
				{SetCVar(FP,Num[2],SetTo,1),
					MoveLocation("Shot", 60, P8, "CLoc109"),MoveLocation("CLoc115", 60, P8, "CLoc109"),
					GiveUnits(1,60,P8,"CLoc115",P12),
					RemoveUnit(60,P12),
					CreateUnitWithProperties(1, 47, "Start", P8, {hallucinated = true, invincible = true}),
					MoveUnit(All, 47, P8, "Start", "Shot"),
					KillUnit(47, P8),
					},{Preserved})
			CAdd(FP,Loc,32)
			CJump(FP,While2)
		NWhileEnd()
		CAdd(FP,Del,1)
		CJump(FP,While)
	NWhileEnd()
	DoActions(FP,SetMemoryX(0x669E28, SetTo, 0,0xFF))
CIfEnd()

CIf(FP,{Memory(0x58F564,Exactly,61),Void(42,Exactly,5)})
	CMov(FP,Del,0)
	DoActions(FP,{
		SetMemory(0x58DC60+0x14*31,SetTo,0),
		SetMemory(0x58DC68+0x14*31,SetTo,0),
		SetMemory(0x58DC64+0x14*31,SetTo,0),
		SetMemory(0x58DC6C+0x14*31,SetTo,0),
		SetMemory(0x58DC64+0x14*30,SetTo,0),
		SetMemory(0x58DC6C+0x14*30,SetTo,6144),
		SetMemoryX(0x669E28, SetTo, 16,0xFF),
	})
	local While = def_sIndex()
	local While2 = def_sIndex()
	CJumpEnd(FP,While)
	NWhile(FP,{TTCVar(FP,Del[2],"<",DY1)})
		CMov(FP,Loc,0)
		CMov(FP,Num,0)
		CJumpEnd(FP,While2)
		NWhile(FP,{TTCVar(FP,Loc[2],"<",3072-32),CVar(FP,Num[2],Exactly,0)})
			CDoActions(FP,{
				TSetMemory(0x58DC60+0x14*30,SetTo,Loc),
				TSetMemory(0x58DC68+0x14*30,SetTo,_Add(Loc,32)),
					RemoveUnitAt(1,47,"CLoc109",P8),
			})
			TriggerX(FP,{Bring(P8, AtLeast, 1, 60, "CLoc109")},
				{SetCVar(FP,Num[2],SetTo,1),
					MoveLocation("Shot", 60, P8, "CLoc109"),MoveLocation("CLoc115", 60, P8, "CLoc109"),
					GiveUnits(1,60,P8,"CLoc115",P12),
					RemoveUnit(60,P12),
					CreateUnitWithProperties(1, 47, "Start", P8, {hallucinated = true, invincible = true}),
					MoveUnit(All, 47, P8, "Start", "Shot"),
					KillUnit(47, P8),
					},{Preserved})
			CAdd(FP,Loc,32)
			CJump(FP,While2)
		NWhileEnd()
		CAdd(FP,Del,1)
		CJump(FP,While)
	NWhileEnd()
	DoActions(FP,SetMemoryX(0x669E28, SetTo, 0,0xFF))

	CMov(FP,Del,0)
	DoActions(FP,{
		SetMemory(0x58DC60+0x14*31,SetTo,0),
		SetMemory(0x58DC68+0x14*31,SetTo,0),
		SetMemory(0x58DC64+0x14*31,SetTo,0),
		SetMemory(0x58DC6C+0x14*31,SetTo,0),
		SetMemory(0x58DC64+0x14*30,SetTo,0),
		SetMemory(0x58DC6C+0x14*30,SetTo,6144),
		SetMemoryX(0x669E28, SetTo, 16,0xFF),
	})
	local While = def_sIndex()
	local While2 = def_sIndex()
	CJumpEnd(FP,While)
	NWhile(FP,{TTCVar(FP,Del[2],"<",DY1)})
		CMov(FP,Loc,0)
		CMov(FP,Num,0)
		CJumpEnd(FP,While2)
		NWhile(FP,{TTCVar(FP,Loc[2],"<",3072-32),CVar(FP,Num[2],Exactly,0)})
			CDoActions(FP,{
				TSetMemory(0x58DC60+0x14*30,SetTo,_Sub(_Mov(3072-32),Loc)),
				TSetMemory(0x58DC68+0x14*30,SetTo,_Sub(_Mov(3072),Loc)),
				RemoveUnitAt(1,47,"CLoc109",P8),
			})
			TriggerX(FP,{Bring(P8, AtLeast, 1, 60, "CLoc109")},
				{SetCVar(FP,Num[2],SetTo,1),
					MoveLocation("Shot", 60, P8, "CLoc109"),MoveLocation("CLoc115", 60, P8, "CLoc109"),
					GiveUnits(1,60,P8,"CLoc115",P12),
					RemoveUnit(60,P12),
					CreateUnitWithProperties(1, 47, "Start", P8, {hallucinated = true, invincible = true}),
					MoveUnit(All, 47, P8, "Start", "Shot"),
					KillUnit(47, P8),
					},{Preserved})
			CAdd(FP,Loc,32)
			CJump(FP,While2)
		NWhileEnd()
		CAdd(FP,Del,1)
		CJump(FP,While)
	NWhileEnd()
	DoActions(FP,SetMemoryX(0x669E28, SetTo, 0,0xFF))

	CMov(FP,Del,0)
	DoActions(FP,{
		SetMemory(0x58DC60+0x14*31,SetTo,0),
		SetMemory(0x58DC68+0x14*31,SetTo,0),
		SetMemory(0x58DC64+0x14*31,SetTo,0),
		SetMemory(0x58DC6C+0x14*31,SetTo,0),
		SetMemory(0x58DC60+0x14*30,SetTo,0),
		SetMemory(0x58DC68+0x14*30,SetTo,3072),
		SetMemoryX(0x669E28, SetTo, 16,0xFF),
	})
	local While = def_sIndex()
	local While2 = def_sIndex()
	CJumpEnd(FP,While)
	NWhile(FP,{TTCVar(FP,Del[2],"<",DZ1)})
		CMov(FP,Loc,0)
		CMov(FP,Num,0)
		CJumpEnd(FP,While2)
		NWhile(FP,{TTCVar(FP,Loc[2],"<",6144-32),CVar(FP,Num[2],Exactly,0)})
			CDoActions(FP,{
				TSetMemory(0x58DC64+0x14*30,SetTo,Loc),
				TSetMemory(0x58DC6C+0x14*30,SetTo,_Add(Loc,32)),
					RemoveUnitAt(1,47,"CLoc109",P8),
			})
			TriggerX(FP,{Bring(P8, AtLeast, 1, 60, "CLoc109")},
				{SetCVar(FP,Num[2],SetTo,1),
					MoveLocation("Shot", 60, P8, "CLoc109"),MoveLocation("CLoc115", 60, P8, "CLoc109"),
					GiveUnits(1,60,P8,"CLoc115",P12),
					RemoveUnit(60,P12),
					CreateUnitWithProperties(1, 47, "Start", P8, {hallucinated = true, invincible = true}),
					MoveUnit(All, 47, P8, "Start", "Shot"),
					KillUnit(47, P8),
					},{Preserved})
			CAdd(FP,Loc,32)
			CJump(FP,While2)
		NWhileEnd()
		CAdd(FP,Del,1)
		CJump(FP,While)
	NWhileEnd()
	DoActions(FP,SetMemoryX(0x669E28, SetTo, 0,0xFF))

	CMov(FP,Del,0)
	DoActions(FP,{
		SetMemory(0x58DC60+0x14*31,SetTo,0),
		SetMemory(0x58DC68+0x14*31,SetTo,0),
		SetMemory(0x58DC64+0x14*31,SetTo,0),
		SetMemory(0x58DC6C+0x14*31,SetTo,0),
		SetMemory(0x58DC60+0x14*30,SetTo,0),
		SetMemory(0x58DC68+0x14*30,SetTo,3072),
		SetMemoryX(0x669E28, SetTo, 16,0xFF),
	})
	local While = def_sIndex()
	local While2 = def_sIndex()
	CJumpEnd(FP,While)
	NWhile(FP,{TTCVar(FP,Del[2],"<",DZ1)})
		CMov(FP,Loc,0)
		CMov(FP,Num,0)
		CJumpEnd(FP,While2)
		NWhile(FP,{TTCVar(FP,Loc[2],"<",6144-32),CVar(FP,Num[2],Exactly,0)})
			CDoActions(FP,{
				TSetMemory(0x58DC64+0x14*30,SetTo,_Sub(_Mov(6144-32),Loc)),
				TSetMemory(0x58DC6C+0x14*30,SetTo,_Sub(_Mov(6144),Loc)),
					RemoveUnitAt(1,47,"CLoc109",P8),
			})
			TriggerX(FP,{Bring(P8, AtLeast, 1, 60, "CLoc109")},
				{SetCVar(FP,Num[2],SetTo,1),
					MoveLocation("Shot", 60, P8, "CLoc109"),MoveLocation("CLoc115", 60, P8, "CLoc109"),
					GiveUnits(1,60,P8,"CLoc115",P12),
					RemoveUnit(60,P12),
					CreateUnitWithProperties(1, 47, "Start", P8, {hallucinated = true, invincible = true}),
					MoveUnit(All, 47, P8, "Start", "Shot"),
					KillUnit(47, P8),
					},{Preserved})
			CAdd(FP,Loc,32)
			CJump(FP,While2)
		NWhileEnd()
		CAdd(FP,Del,1)
		CJump(FP,While)
	NWhileEnd()
	DoActions(FP,SetMemoryX(0x669E28, SetTo, 0,0xFF))
CIfEnd()


Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 1);
		Memory(0x58F558,Exactly,6);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,54,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,55,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,53,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,47,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
	},
}


Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 1);
		Memory(0x58F558,Exactly,5);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,48,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,56,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,104,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,62,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 1);
		Memory(0x58F558,Exactly,4);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,104,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,43,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,52,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,45,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 1);
		Memory(0x58F558,Exactly,3);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,51,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,104,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,50,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,44,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 1);
		Memory(0x58F558,Exactly,2);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,37,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,103,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,39,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,53,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 1);
		Memory(0x58F558,Exactly,1);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,21,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,77,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,21,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,78,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 1);
		Memory(0x58F558,Exactly,0);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,25,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,88,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,17,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,88,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
	},
}







Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 2);
		Memory(0x58F558,Exactly,6);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,51,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,56,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,50,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,55,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 2);
		Memory(0x58F558,Exactly,5);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,77,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,21,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,78,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,21,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 2);
		Memory(0x58F558,Exactly,4);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,25,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,21,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,17,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,21,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 2);
		Memory(0x58F558,Exactly,3);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,78,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,88,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,75,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,88,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 2);
		Memory(0x58F558,Exactly,2);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,21,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,17,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,21,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,19,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 2);
		Memory(0x58F558,Exactly,1);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,88,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,79,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,88,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,77,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 2);
		Memory(0x58F558,Exactly,0);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,80,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,78,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,80,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,76,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
	},
}








Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 3);
		Memory(0x58F558,Exactly,6);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,88,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,75,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(2,30,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,78,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 3);
		Memory(0x58F558,Exactly,5);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,21,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,25,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,57,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,17,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 3);
		Memory(0x58F558,Exactly,4);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,13,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,77,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,88,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,78,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 3);
		Memory(0x58F558,Exactly,3);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,80,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,79,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,25,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,76,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 3);
		Memory(0x58F558,Exactly,2);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(4,11,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,19,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,27,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,52,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 3);
		Memory(0x58F558,Exactly,1);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(3,13,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,11,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(3,30,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,52,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 3);
		Memory(0x58F558,Exactly,0);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,86,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(5,75,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,86,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnitWithProperties(2,121,"CLoc115",P8,{hitpoint = 10});
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
	},
}





Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 4);
		Memory(0x58F558,Exactly,6);
		Void(0,Exactly, 0);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,21,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,25,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,21,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,17,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
		SetVoid(0,SetTo,1);
		PreserveTrigger();
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 4);
		Memory(0x58F558,Exactly,5);
		Void(1,Exactly, 0);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,88,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,77,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,25,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,78,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
		SetVoid(1,SetTo,1);
		PreserveTrigger();
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 4);
		Memory(0x58F558,Exactly,4);
		Void(2,Exactly, 0);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,13,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,79,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,30,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,76,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
		SetVoid(2,SetTo,1);
		PreserveTrigger();
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 4);
		Memory(0x58F558,Exactly,3);
		Void(3,Exactly, 0);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,11,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,19,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,27,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,52,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
		SetVoid(3,SetTo,1);
		PreserveTrigger();
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 4);
		Memory(0x58F558,Exactly,2);
		Void(4,Exactly, 0);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,27,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,69,"CLoc115",FP);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,30,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,11,"CLoc115",FP);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
		SetVoid(4,SetTo,1);
		PreserveTrigger();
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 4);
		Memory(0x58F558,Exactly,1);
		Void(5,Exactly, 0);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,81,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,75,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,13,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,11,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
		SetVoid(5,SetTo,1);
		PreserveTrigger();
	},
}

Trigger { -- No comment (4347C6C8)
	players = {FP},
	conditions = {
		Void(41,Exactly, 4);
		Memory(0x58F558,Exactly,0);
		Void(6,Exactly, 0);
	},
	actions = {
		SetMemory(0x58DC60+0x14*31,SetTo,0);
		SetMemory(0x58DC64+0x14*31,SetTo,0);
		SetMemory(0x58DC68+0x14*31,SetTo,320);
		SetMemory(0x58DC6C+0x14*31,SetTo,320);
		MoveLocation("CLoc115","Tarim, Lord Of Regal Castle",FP,"Anywhere");
		SetMemory(0x58DC68+0x14*31,Subtract,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		CreateUnit(10,98,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,320);
		CreateUnit(10,29,"CLoc115",P8);
		SetMemory(0x58DC6C+0x14*31,Add,320);
		CreateUnit(10,23,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Subtract,320);
		CreateUnit(10,121,"CLoc115",P8);
		SetMemory(0x58DC68+0x14*31,Add,160);
		SetMemory(0x58DC6C+0x14*31,Subtract,160);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD, "Anywhere");
		SetMemory(0x6509B0,SetTo,6);
		SetVoid(6,SetTo,1);
		PreserveTrigger();
	},
}

CElseIfX({CVar(FP,VResetSw2[2],Exactly,0),Bring(FP,AtMost,0,"Tarim, Lord Of Regal Castle",64)},SetCVar(FP,VResetSw2[2],SetTo,1))
DoActionsX(FP,{KillUnit("Any unit",FP),KillUnit("Any unit",P9),KillUnit("Any unit",P10),KillUnit("Any unit",P11),KillUnit("Any unit",P12),SetCDeaths(FP,Add,1,IdenClear)})
DoActions2X(FP,{SetMemory(0x58F568,SetTo,0);
SetMemory(0x58F564,SetTo,0);
SetMemory(0x58F570,SetTo,0);
SetMemory(0x58F560,SetTo,0);
SetMemory(0x58F558,SetTo,0);
SetCVar(FP,FX[2],SetTo,0);
SetCVar(FP,FY[2],SetTo,0);
SetCVar(FP,FA[2],SetTo,0);
SetCVar(FP,FR[2],SetTo,0);
SetCVar(FP,Fx2[2],SetTo,0);
SetCVar(FP,Fy2[2],SetTo,0);
SetCVar(FP,DX1[2],SetTo,0);
SetCVar(FP,DY1[2],SetTo,0);
SetCVar(FP,DZ1[2],SetTo,0);
SetCVar(FP,Del[2],SetTo,0);
SetCVar(FP,Loc[2],SetTo,0);
SetCVar(FP,Num[2],SetTo,0);
SetCVar(FP,Sh_Para[2],SetTo,0);
SetCDeaths(FP,SetTo,0,Id_T0C),
SetCDeaths(FP,SetTo,0,Id_T1C),
SetCDeaths(FP,SetTo,0,Id_T2C),
SetCDeaths(FP,SetTo,0,Id_T3C),
SetCDeaths(FP,SetTo,0,Id_T4C),
SetCDeaths(FP,SetTo,0,Id_T5C),
SetCDeaths(FP,SetTo,0,StoryT2),
SetCDeaths(FP,SetTo,0,StoryT),
SetMemory(0x6CA1F4, SetTo, 1707),
SetMemoryX(0x6C9DF4, SetTo, 67*65536,0xFFFF0000),
SetVoid(0,SetTo,0);
SetVoid(1,SetTo,0);
SetVoid(2,SetTo,0);
SetVoid(3,SetTo,0);
SetVoid(4,SetTo,0);
SetVoid(5,SetTo,0);
SetVoid(6,SetTo,0);
SetVoid(42,SetTo,0);
})
CIfXEnd()
CIfEnd()
end