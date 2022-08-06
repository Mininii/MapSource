function Install_IdenBoss()


	-- Tarim, Lord Of Regal Castle, Made By Ninfia. Arrenged By Mininii
	-- from MSF Identity OpenSource
	-- Thanks to Ninfia
	--------B_Id_C : 0x58F55C : BossCunit
	--"CLoc109" : 30
Id_T0C = CreateCcode()
Id_T1C = CreateCcode()
Id_T2C = CreateCcode()
Id_T3C = CreateCcode()
Id_T4C = CreateCcode()
Id_T5C = CreateCcode()
StoryT2 = CreateCcode()
local BType = CreateVar(FP)
local BSeed = CreateVar(FP)
local BCheck = CreateVar(FP)
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
--CAdd(FP,_Ccode("X",StoryT),Dt)
CTrigger(FP,{CVar(FP,Dt[2],AtMost,2500)},{TSetCDeaths(FP,Add,Dt,StoryT)},1)
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
},Id_T5C,{SetCDeaths(FP,SetTo,1,StoryT2)}) 
CIf(FP,CDeaths(FP,AtLeast,1,StoryT2),SetCDeaths(FP,SetTo,0,StoryT2)) -- 소환
f_Read(FP,0x628438,nil,Nextptrs,0xFFFFFF)
CDoActions(FP,{
	CreateUnit(1,68,29,FP),
	SetInvincibility(Enable,"Tarim, Lord Of Regal Castle", FP, 64),
	SetV(B_Id_C,Nextptrs),
	--TSetMemory(B_Id_C,SetTo,Nextptrs),
	TSetMemory(0x58F558,SetTo,7),
	SetCVar(FP,ReserveBGM[2],SetTo,IdenBGM),
	TSetMemory(_Add(Nextptrs,2),SetTo,_Add(_Mul(PCheckV,_Mov(500*256)),_Mul(LevelT2,1000*256))),
	KillUnitAt(All,"Men",29,Force1),
})

DoActions2(FP,
RotatePlayer({
	TalkingPortrait(68, 6100);
	PlayWAVX("sound\\Protoss\\ARCHON\\PArPss00.WAV");
	PlayWAVX("sound\\Protoss\\ARCHON\\PArPss00.WAV");
	DisplayTextX(Id_T5,4);},HumanPlayers,FP))

CIfEnd()

CIfEnd()

CIf(FP,NTCond())
CIfX(FP,Bring(FP,AtLeast,1,"Tarim, Lord Of Regal Castle",64),SetCVar(FP,VResetSw2[2],SetTo,0))


	CIf(FP,{CV(B_Id_C,19025,AtLeast)})
		CTrigger(FP,{Memory(0x58F558,AtLeast,1),TMemory(_Add(B_Id_C,2),AtMost,1000*256)},{TSetMemory(_Add(B_Id_C,2),Add,_Mul(LevelT2,770*256)),SetMemory(0x58F558,Subtract,1),},1)
		CTrigger(FP,{Void(41,Exactly, 1)},{TSetMemory(_Add(B_Id_C,13),SetTo,427)},1)
		CTrigger(FP,{Void(41,Exactly, 2)},{TSetMemory(_Add(B_Id_C,13),SetTo,640)},1)
		CTrigger(FP,{Void(41,Exactly, 3)},{TSetMemory(_Add(B_Id_C,13),SetTo,853)},1)
		CTrigger(FP,{Void(41,Exactly, 4)},{TSetMemory(_Add(B_Id_C,13),SetTo,1280)},1)
	CIfEnd()
	
	TriggerX(FP,{Memory(0x58F570,Exactly,0),Memory(0x58F564,Exactly,0),Switch("Switch 34",Cleared)},{SetV(BCheck,0)},{preserved})
	CIf(FP,{Memory(0x58F564,Exactly,1),CV(BCheck,0)},{SetV(BCheck,1)})
	CRandNum(FP,15,BSeed)

	TriggerX(FP,{CV(BSeed,0,AtLeast),CV(BSeed,2730*1,AtMost)},{SetMemory(0x58F56C,SetTo,0x00051234)},{preserved})
	TriggerX(FP,{CV(BSeed,2730*1+1,AtLeast),CV(BSeed,2730*2,AtMost)},{SetMemory(0x58F56C,SetTo,0x00051243)},{preserved})
	TriggerX(FP,{CV(BSeed,2730*2+1,AtLeast),CV(BSeed,2730*3,AtMost)},{SetMemory(0x58F56C,SetTo,0x00051324)},{preserved})
	TriggerX(FP,{CV(BSeed,2730*3+1,AtLeast),CV(BSeed,2730*4,AtMost)},{SetMemory(0x58F56C,SetTo,0x00051342)},{preserved})
	TriggerX(FP,{CV(BSeed,2730*4+1,AtLeast),CV(BSeed,2730*5,AtMost)},{SetMemory(0x58F56C,SetTo,0x00051423)},{preserved})
	TriggerX(FP,{CV(BSeed,2730*5+1,AtLeast),CV(BSeed,2730*6,AtMost)},{SetMemory(0x58F56C,SetTo,0x00051432)},{preserved})

	TriggerX(FP,{CV(BSeed,2730*6+1,AtLeast),CV(BSeed,2730*7,AtMost)},{SetMemory(0x58F56C,SetTo,0x00052134)},{preserved})
	TriggerX(FP,{CV(BSeed,2730*7+1,AtLeast),CV(BSeed,2730*8,AtMost)},{SetMemory(0x58F56C,SetTo,0x00052143)},{preserved})
	TriggerX(FP,{CV(BSeed,2730*8+1,AtLeast),CV(BSeed,2730*9,AtMost)},{SetMemory(0x58F56C,SetTo,0x00052314)},{preserved})
	TriggerX(FP,{CV(BSeed,2730*9+1,AtLeast),CV(BSeed,2730*10,AtMost)},{SetMemory(0x58F56C,SetTo,0x00052341)},{preserved})
	TriggerX(FP,{CV(BSeed,2730*10+1,AtLeast),CV(BSeed,2730*11,AtMost)},{SetMemory(0x58F56C,SetTo,0x00052413)},{preserved})
	TriggerX(FP,{CV(BSeed,2730*11+1,AtLeast),CV(BSeed,2730*12,AtMost)},{SetMemory(0x58F56C,SetTo,0x00052431)},{preserved})

	TriggerX(FP,{CV(BSeed,2730*12+1,AtLeast),CV(BSeed,2730*13,AtMost)},{SetMemory(0x58F56C,SetTo,0x00053124)},{preserved})
	TriggerX(FP,{CV(BSeed,2730*13+1,AtLeast),CV(BSeed,2730*14,AtMost)},{SetMemory(0x58F56C,SetTo,0x00053142)},{preserved})
	TriggerX(FP,{CV(BSeed,2730*14+1,AtLeast),CV(BSeed,2730*15,AtMost)},{SetMemory(0x58F56C,SetTo,0x00053214)},{preserved})
	TriggerX(FP,{CV(BSeed,2730*15+1,AtLeast),CV(BSeed,2730*16,AtMost)},{SetMemory(0x58F56C,SetTo,0x00053241)},{preserved})
	TriggerX(FP,{CV(BSeed,2730*16+1,AtLeast),CV(BSeed,2730*17,AtMost)},{SetMemory(0x58F56C,SetTo,0x00053124)},{preserved})
	TriggerX(FP,{CV(BSeed,2730*17+1,AtLeast),CV(BSeed,2730*18,AtMost)},{SetMemory(0x58F56C,SetTo,0x00053142)},{preserved})

	TriggerX(FP,{CV(BSeed,2730*18+1,AtLeast),CV(BSeed,2730*19,AtMost)},{SetMemory(0x58F56C,SetTo,0x00054123)},{preserved})
	TriggerX(FP,{CV(BSeed,2730*19+1,AtLeast),CV(BSeed,2730*20,AtMost)},{SetMemory(0x58F56C,SetTo,0x00054132)},{preserved})
	TriggerX(FP,{CV(BSeed,2730*20+1,AtLeast),CV(BSeed,2730*21,AtMost)},{SetMemory(0x58F56C,SetTo,0x00054213)},{preserved})
	TriggerX(FP,{CV(BSeed,2730*21+1,AtLeast),CV(BSeed,2730*22,AtMost)},{SetMemory(0x58F56C,SetTo,0x00054231)},{preserved})
	TriggerX(FP,{CV(BSeed,2730*22+1,AtLeast),CV(BSeed,2730*23,AtMost)},{SetMemory(0x58F56C,SetTo,0x00054312)},{preserved})
	TriggerX(FP,{CV(BSeed,2730*23+1,AtLeast),CV(BSeed,65535,AtMost)},{SetMemory(0x58F56C,SetTo,0x00054321)},{preserved})

	CIfEnd()

	TriggerX(FP,{Memory(0x58F570,Exactly,0),MemoryX(0x58F56C,Exactly,1*1,0xF)},{SetV(BType,1)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,1),MemoryX(0x58F56C,Exactly,1*16,0xF0)},{SetV(BType,1)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,2),MemoryX(0x58F56C,Exactly,1*256,0xF00)},{SetV(BType,1)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,3),MemoryX(0x58F56C,Exactly,1*4096,0xF000)},{SetV(BType,1)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,4),MemoryX(0x58F56C,Exactly,1*65536,0xF0000)},{SetV(BType,1)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,0),MemoryX(0x58F56C,Exactly,2*1,0xF)},{SetV(BType,2)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,1),MemoryX(0x58F56C,Exactly,2*16,0xF0)},{SetV(BType,2)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,2),MemoryX(0x58F56C,Exactly,2*256,0xF00)},{SetV(BType,2)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,3),MemoryX(0x58F56C,Exactly,2*4096,0xF000)},{SetV(BType,2)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,4),MemoryX(0x58F56C,Exactly,2*65536,0xF0000)},{SetV(BType,2)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,0),MemoryX(0x58F56C,Exactly,3*1,0xF)},{SetV(BType,3)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,1),MemoryX(0x58F56C,Exactly,3*16,0xF0)},{SetV(BType,3)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,2),MemoryX(0x58F56C,Exactly,3*256,0xF00)},{SetV(BType,3)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,3),MemoryX(0x58F56C,Exactly,3*4096,0xF000)},{SetV(BType,3)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,4),MemoryX(0x58F56C,Exactly,3*65536,0xF0000)},{SetV(BType,3)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,0),MemoryX(0x58F56C,Exactly,4*1,0xF)},{SetV(BType,4)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,1),MemoryX(0x58F56C,Exactly,4*16,0xF0)},{SetV(BType,4)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,2),MemoryX(0x58F56C,Exactly,4*256,0xF00)},{SetV(BType,4)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,3),MemoryX(0x58F56C,Exactly,4*4096,0xF000)},{SetV(BType,4)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,4),MemoryX(0x58F56C,Exactly,4*65536,0xF0000)},{SetV(BType,4)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,0),MemoryX(0x58F56C,Exactly,5*1,0xF)},{SetV(BType,5)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,1),MemoryX(0x58F56C,Exactly,5*16,0xF0)},{SetV(BType,5)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,2),MemoryX(0x58F56C,Exactly,5*256,0xF00)},{SetV(BType,5)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,3),MemoryX(0x58F56C,Exactly,5*4096,0xF000)},{SetV(BType,5)},{preserved})
	TriggerX(FP,{Memory(0x58F570,Exactly,4),MemoryX(0x58F56C,Exactly,5*65536,0xF0000)},{SetV(BType,5)},{preserved})
	CIf(FP,{Memory(0x58F564,Exactly,1)})
		TriggerX(FP,{Void(41, Exactly, 1)},{SetV(BSeed,400)},{preserved})
		TriggerX(FP,{Void(41, Exactly, 2)},{SetV(BSeed,500)},{preserved})
		TriggerX(FP,{Void(41, Exactly, 3)},{SetV(BSeed,600)},{preserved})
		TriggerX(FP,{Void(41, Exactly, 4)},{SetV(BSeed,800)},{preserved})
		CRandNum(FP,11,BSeed,1)
		CDoActions(FP,{TSetMemory(0x6CA1F4, SetTo, BSeed),TSetMemoryX(0x6C9DF4, SetTo, _Mul(_Div(BSeed,10),65536),0xFFFF0000)})
	CIfEnd()

	TriggerX(FP,{CV(BType,1)},{SetMemoryX(0x669FAC, SetTo, 13*16777216,0xFF000000),SetMemoryX(0x666458, SetTo, 391, 0xFFFF)},{preserved})
	TriggerX(FP,{CV(BType,2)},{SetMemoryX(0x669FAC, SetTo, 16*16777216,0xFF000000),SetMemoryX(0x666458, SetTo, 391, 0xFFFF)},{preserved})
	TriggerX(FP,{CV(BType,3)},{SetMemoryX(0x669FAC, SetTo, 17*16777216,0xFF000000),SetMemoryX(0x666458, SetTo, 391, 0xFFFF)},{preserved})
	TriggerX(FP,{CV(BType,4)},{SetMemoryX(0x669FAC, SetTo, 10*16777216,0xFF000000),SetMemoryX(0x666458, SetTo, 391, 0xFFFF)},{preserved})
	TriggerX(FP,{CV(BType,5)},{SetMemoryX(0x669FAC, SetTo, 12*16777216,0xFF000000),SetMemoryX(0x666458, SetTo, 391, 0xFFFF)},{preserved})
CDoActions(FP,{TSetMemory(0x594000+4*42,SetTo,BType)})





CMov(FP,VO(41),LevelT2) -- Diff
DoActions2(FP,{
	Simple_SetLoc(0,0,0,32*96,5),
	RemoveUnitAt(All,60,1,FP);
	Simple_SetLoc(0,3072-5,0,3072,6144),
	RemoveUnitAt(All,60,1,FP);
	Simple_SetLoc(0,0,0,5,6144),
	RemoveUnitAt(All,60,1,FP);

})

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
CIf(FP,{Memory(0x628438,AtLeast,1)})
f_Read(FP,0x628438,nil,Sh_Para,0xFFFFFF)
CDoActions(FP,{
		CreateUnitWithProperties(1, 60, "CLoc109", P8, {invincible = true}),
		TSetDeathsX(_Add(Sh_Para,72),SetTo,0xFF*256,0,0xFF00),
		GiveUnits(All,60,P8,64,P9),
	})
CIfEnd()
	CIf(FP,Memory(0x594000+4*41, Exactly, 2))

	f_Lengthdir(FP,FR,_Add(FA,180),FX,FY)
	DoActions(FP,{Simple_SetLoc(30,0,0,0,0),MoveLocation("CLoc109","Tarim, Lord Of Regal Castle",P8,"Anywhere")})
	Simple_SetLoc2X(FP,30,FX,FY,FX,FY)
	f_Read(FP,0x58DC60+0x14*30,Fx2,nil,0xFFFF)
	f_Read(FP,0x58DC64+0x14*30,Fy2,nil,0xFFFF)
	f_Recall(nil,Fx2,Fy2)
	f_Recall(nil,Fx2,Fy2)
	CIf(FP,{Memory(0x628438,AtLeast,1)})
	f_Read(FP,0x628438,nil,Sh_Para,0xFFFFFF)
	CDoActions(FP,{
			CreateUnitWithProperties(1, 60, "CLoc109", P8, {invincible = true}),
			TSetDeathsX(_Add(Sh_Para,72),SetTo,0xFF*256,0,0xFF00),
			TSetDeathsX(_Add(Sh_Para,55),SetTo,0x200104,0,0x300104),
			TSetDeaths(_Add(Sh_Para,57),SetTo,0,0),
			GiveUnits(All,60,P8,64,P9),
		})
	CIfEnd()
	CIfEnd()

	CIf(FP,Memory(0x594000+4*41, Exactly, 3))
	f_Lengthdir(FP,FR,_Add(FA,120),FX,FY)
	DoActions(FP,{Simple_SetLoc(30,0,0,0,0),MoveLocation("CLoc109","Tarim, Lord Of Regal Castle",P8,"Anywhere")})
	Simple_SetLoc2X(FP,30,FX,FY,FX,FY)
	f_Read(FP,0x58DC60+0x14*30,Fx2,nil,0xFFFF)
	f_Read(FP,0x58DC64+0x14*30,Fy2,nil,0xFFFF)
	f_Recall(nil,Fx2,Fy2)
	f_Recall(nil,Fx2,Fy2)
CIf(FP,{Memory(0x628438,AtLeast,1)})
	f_Read(FP,0x628438,nil,Sh_Para,0xFFFFFF)
	CDoActions(FP,{
			CreateUnitWithProperties(1, 60, "CLoc109", P8, {invincible = true}),
			TSetDeathsX(_Add(Sh_Para,72),SetTo,0xFF*256,0,0xFF00),
			TSetDeathsX(_Add(Sh_Para,55),SetTo,0x200104,0,0x300104),
			TSetDeaths(_Add(Sh_Para,57),SetTo,0,0),
			GiveUnits(All,60,P8,64,P9),
		})
CIfEnd()
	f_Lengthdir(FP,FR,_Add(FA,240),FX,FY)
	DoActions(FP,{Simple_SetLoc(30,0,0,0,0),MoveLocation("CLoc109","Tarim, Lord Of Regal Castle",P8,"Anywhere")})
	Simple_SetLoc2X(FP,30,FX,FY,FX,FY)
	f_Read(FP,0x58DC60+0x14*30,Fx2,nil,0xFFFF)
	f_Read(FP,0x58DC64+0x14*30,Fy2,nil,0xFFFF)
	f_Recall(nil,Fx2,Fy2)
	f_Recall(nil,Fx2,Fy2)
CIf(FP,{Memory(0x628438,AtLeast,1)})
	f_Read(FP,0x628438,nil,Sh_Para,0xFFFFFF)
	CDoActions(FP,{
			CreateUnitWithProperties(1, 60, "CLoc109", P8, {invincible = true}),
			TSetDeathsX(_Add(Sh_Para,72),SetTo,0xFF*256,0,0xFF00),
			TSetDeathsX(_Add(Sh_Para,55),SetTo,0x200104,0,0x300104),
			TSetDeaths(_Add(Sh_Para,57),SetTo,0,0),
			GiveUnits(All,60,P8,64,P9),
		})
CIfEnd()
CIfEnd()

CIf(FP,Memory(0x594000+4*41, Exactly, 4))
	f_Lengthdir(FP,FR,_Add(FA,90),FX,FY)
	DoActions(FP,{Simple_SetLoc(30,0,0,0,0),MoveLocation("CLoc109","Tarim, Lord Of Regal Castle",P8,"Anywhere")})
	Simple_SetLoc2X(FP,30,FX,FY,FX,FY)
	f_Read(FP,0x58DC60+0x14*30,Fx2,nil,0xFFFF)
	f_Read(FP,0x58DC64+0x14*30,Fy2,nil,0xFFFF)
	f_Recall(nil,Fx2,Fy2)
	f_Recall(nil,Fx2,Fy2)
CIf(FP,{Memory(0x628438,AtLeast,1)})
	f_Read(FP,0x628438,nil,Sh_Para,0xFFFFFF)
	CDoActions(FP,{
			CreateUnitWithProperties(1, 60, "CLoc109", P8, {invincible = true}),
			TSetDeathsX(_Add(Sh_Para,72),SetTo,0xFF*256,0,0xFF00),
			TSetDeathsX(_Add(Sh_Para,55),SetTo,0x200104,0,0x300104),
			TSetDeaths(_Add(Sh_Para,57),SetTo,0,0),
			GiveUnits(All,60,P8,64,P9),
		})
CIfEnd()
	f_Lengthdir(FP,FR,_Add(FA,180),FX,FY)
	DoActions(FP,{Simple_SetLoc(30,0,0,0,0),MoveLocation("CLoc109","Tarim, Lord Of Regal Castle",P8,"Anywhere")})
	Simple_SetLoc2X(FP,30,FX,FY,FX,FY)
	f_Read(FP,0x58DC60+0x14*30,Fx2,nil,0xFFFF)
	f_Read(FP,0x58DC64+0x14*30,Fy2,nil,0xFFFF)
	f_Recall(nil,Fx2,Fy2)
	f_Recall(nil,Fx2,Fy2)
CIf(FP,{Memory(0x628438,AtLeast,1)})
	f_Read(FP,0x628438,nil,Sh_Para,0xFFFFFF)
	CDoActions(FP,{
			CreateUnitWithProperties(1, 60, "CLoc109", P8, {invincible = true}),
			TSetDeathsX(_Add(Sh_Para,72),SetTo,0xFF*256,0,0xFF00),
			TSetDeathsX(_Add(Sh_Para,55),SetTo,0x200104,0,0x300104),
			TSetDeaths(_Add(Sh_Para,57),SetTo,0,0),
			GiveUnits(All,60,P8,64,P9),
		})
CIfEnd()
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
CIfEnd()
DoActions(FP,RemoveUnit(33,P8))

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
		SetInvincibility(Disable,"Tarim, Lord Of Regal Castle", FP, 64),
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
},{preserved})
TriggerX(FP,{Void(41,Exactly,2)},{
	SetCVar(FP,DX1[2],SetTo,4),
	SetCVar(FP,DY1[2],SetTo,1),
	SetCVar(FP,DZ1[2],SetTo,1)
},{preserved})
TriggerX(FP,{Void(41,Exactly,3)},{
	SetCVar(FP,DX1[2],SetTo,6),
	SetCVar(FP,DY1[2],SetTo,1),
	SetCVar(FP,DZ1[2],SetTo,2)
},{preserved})
TriggerX(FP,{Void(41,Exactly,4)},{
	SetCVar(FP,DX1[2],SetTo,8),
	SetCVar(FP,DY1[2],SetTo,2),
	SetCVar(FP,DZ1[2],SetTo,2)
},{preserved})

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
					},{preserved})
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
					},{preserved})
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
					},{preserved})
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
					},{preserved})
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
					},{preserved})
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
					},{preserved})
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
					},{preserved})
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
					},{preserved})
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
SetV(BType,0),
SetV(BSeed,0),
SetV(BCheck,0),
})
CIfXEnd()
CIfEnd()
end