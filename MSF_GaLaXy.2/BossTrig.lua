function Install_boss()
	CIf(FP,{CGMode(2,AtLeast),CDeaths(FP,AtLeast,6000,GunBossAct),Bring(Force2, AtMost, 0, "Protoss Temple", 64)})

	local CBulletIndex = 0x1100
	for i = 0, 127 do
		local Index = 0
		if i == 0 then Index = CBulletIndex end
		CTrigger(FP, {CVar("X","X",AtLeast,1)}, {
			SetCVar(FP,TempEPD[2],SetTo,0),
			SetCVar(FP,TempT[2],SetTo,0),
			SetCVar(FP,TempA[2],SetTo,0),
			SetCtrigX("X",CB_TempH[2],0x15C,0,SetTo,"X","X",0x15C,1,0),
			SetNext("X",Call_CBulletA,0),SetNext(Call_CBulletA+1,"X",1), -- Call f_Gun
			SetCtrigX("X",Call_CBulletA+1,0x158,0,SetTo,"X","X",0x4,1,0), -- RecoverNext
			SetCtrigX("X",Call_CBulletA+1,0x15C,0,SetTo,"X","X",0,0,1), -- RecoverNext
			SetCtrig1X("X",Call_CBulletA+1,0x164,0,SetTo,0x0,0x2) -- RecoverNext
		}, 1, Index)
	end
	table.insert(CtrigInitArr[7],SetCtrigX(FP,CBullet_InputH[2],0x15C,0,SetTo,FP,CBulletIndex,0x15C,1,0))

	DoActions(FP,{SetCountdownTimer(Add,180)},1)
	FBPtr = CreateVar(FP)
	FBH = CreateVar(FP)
	CIfOnce(FP,{Memory(0x628438,AtLeast,1)},SetBulletSpeed(500))
		f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF,1)
		CMov(FP,FBPtr,Nextptrs)
		DoActions(FP,{CreateUnitWithProperties(1,186,"Location 31",FP,{invincible = true}),GiveUnits(1,186,FP,64,11)})
		CMov(FP,FBH,Nextptrs,2)
		CDoActions(FP,{TSetMemory(FBH,SetTo,8320000*256)})

	CIfEnd()
	DoActions(FP,{
		SetMemoryB(0x6636B8+204, SetTo, 125), -- 무기변경
		})
	GetLocCenter("Location 31",BPosX,BPosY)
	G_CA_SetSpawn(nil,{204},{S_4},{0},"MAX",nil,nil,{1024,2400})
		
	CIfEnd()
end