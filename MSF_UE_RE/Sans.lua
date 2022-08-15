function Install_SansBoss()
	--Boss : Sans, Judge OF Level. Made By Mininii
	--from. MSF_UE

	function SetBright(Time,Value)
		TriggerX(FP,{CD(SBossStart,Time,AtLeast)},{SetMemory(0x657A9C,SetTo,Value)})
	end
	function SetBright2(Time,Value)
		TriggerX(FP,{CD(DTimer,Time,AtLeast)},{SetMemory(0x657A9C,SetTo,Value)})
	end
	function StoryPrintS(T,Talk,Cond)
		Trigger2X(FP,{CD(DCheck,0),CDeaths(FP,AtLeast,T,SBossStart),Cond},{RotatePlayer({DisplayTextX("\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\x13\x06 :: \x1CSans, \x08Judge \x04Of \x11The \x07Level \x06::\r\n\x0D\x0D!H\x13"..Talk.."\r\n\r\n",4)},HumanPlayers,FP);})
	end
	function StoryPrintS2(T,Talk,Cond)
		Trigger2X(FP,{CDeaths(FP,AtLeast,T,DTimer),Cond},{RotatePlayer({DisplayTextX("\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\x13\x06 :: \x1CSans, \x08Judge \x04Of \x11The \x07Level \x06::\r\n\x0D\x0D!H\x13"..Talk.."\r\n\r\n",4)},HumanPlayers,FP);})
	end
	
	function SetFlingySpeed(FID,Value)
		return {
			SetMemory(0x6C9EF8+(4*FID),SetTo,0xFFFFFFFF-Value),--최고속도
			SetMemoryW(0x6C9C78+(2*FID),SetTo,Value)--가속도
		}
	end
	Shape9215 = {84,{1528, 2977},{1536, 2977},{1544, 2977},{1528, 2985},{1528, 2993},{1536, 2993},{1544, 2993},{1544, 2985},{1544, 3001},{1544, 3009},{1536, 3009},{1528, 3009},{1568, 2977},{1576, 2977},{1584, 2977},{1568, 2985},{1568, 2993},{1576, 2993},{1584, 2993},{1584, 2985},{1584, 3001},{1584, 3009},{1576, 3009},{1568, 3009},{1608, 2977},{1616, 2977},{1624, 2977},{1608, 2985},{1608, 2993},{1616, 2993},{1624, 2993},{1624, 2985},{1624, 3001},{1624, 3009},{1616, 3009},{1608, 3009},{1488, 2977},{1496, 2977},{1504, 2977},{1488, 2985},{1488, 2993},{1496, 2993},{1504, 2993},{1504, 2985},{1504, 3001},{1504, 3009},{1496, 3009},{1488, 3009},{1448, 2977},{1456, 2977},{1464, 2977},{1448, 2985},{1448, 2993},{1456, 2993},{1464, 2993},{1464, 2985},{1464, 3001},{1464, 3009},{1456, 3009},{1448, 3009},{1648, 2977},{1656, 2977},{1664, 2977},{1648, 2985},{1648, 2993},{1656, 2993},{1664, 2993},{1664, 2985},{1664, 3001},{1664, 3009},{1656, 3009},{1648, 3009},{1408, 2977},{1416, 2977},{1424, 2977},{1408, 2985},{1408, 2993},{1416, 2993},{1424, 2993},{1424, 2985},{1424, 3001},{1424, 3009},{1416, 3009},{1408, 3009}}

	BWait = CreateCcode()
	TalkCond = CreateCcode()
	BossP=CreateVar(FP)
	DCheck = CreateCcode()
	function CABossFunc()
		local UnitPtr = CABossPtr
		local PlayerID = CABossPlayerID
		local CA = CABossDataArr
		local CB = CABossTempArr
		local PattV = CreateVarArr(10,FP)
		local PattC = CreateCcodeArr(4)
		local PattC2 = CreateCcodeArr(49)
		local PattC3 = CreateCcodeArr(41)
		TriggerX(FP,{CD(BWait,1)},{SetV(CB[3],250)},{preserved})--CD(TestMode,1),
		--TriggerX(FP,{CD(BWait,0)},{SetInvincibility(Disable, 96, FP, 64)},{preserved})
		DoActionsX(FP,SetV(CB[6],1))
		CIf(FP,{CV(CB[3],0)}) -- 보스패턴 작성구간

		if Limit == 1 then
			BossPhaseTestNum = 4
			CIf(FP,{CD(TestMode,1)})
			CMov(FP,0x6509B0,CurrentOP)
			TriggerX(FP, {CD(TestMode,1)}, {SetV(CA[1],BossPhaseTestNum)})
			TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,224)},{SetCD(PattC[1],1),SetCVar(FP,CA[1][2],Add,1),SetCD(SBossStart,5000+(2500*3)+4200)},{preserved})
			TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,223)},{SetCD(PattC[1],1),SetCVar(FP,CA[1][2],Subtract,1),SetCD(SBossStart,5000+(2500*3)+4200)},{preserved})
			CMov(FP,0x6509B0,FP)
			CMov(FP,0x57f120,CA[1])
			for i = 0, 6 do
				CMov(FP,0x57f0f0+(i*4),0x70000000)
			end
			CIfEnd()
		end
			CIf(FP,{CV(CA[1],0)})
			TriggerX(FP,{Bring(Force1,AtLeast,1,"Men",91)},{SetCD(PattC2[1],1)},{preserved})
			CIf(FP,{CD(PattC2[1])})
				DoActionsX(FP,{SubCD(PattC[2],1),AddCD(PattC[3],1)})
				CIf(FP,{CD(PattC[2],0),CD(PattC[3],100,AtMost)},SetCD(PattC[2], 25))
				CMov(FP,0x6509B0,19025+19)
				CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
					CIf(FP,{DeathsX(CurrentPlayer, AtMost, 6, 0, 0xFF),DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00)})
						CSub(FP,0x6509B0,9)
						CIf(FP,{
							DeathsX(CurrentPlayer, AtLeast, 1200,0, 0xFFFF),DeathsX(CurrentPlayer, AtMost, 1872,0, 0xFFFF),
							DeathsX(CurrentPlayer, AtLeast, 2736*65536,0, 0xFFFF0000),DeathsX(CurrentPlayer, AtMost, 3408*65536,0, 0xFFFF0000),
						})
							f_SaveCp()
							Convert_CPosXY(_Read(BackupCp))
							TS_SendX({}, BoneBullet, {CPosX,CPosY})
							f_LoadCp()
						CIfEnd()
						CAdd(FP,0x6509B0,9)
					CIfEnd()
				CAdd(FP,0x6509B0,84)
				CWhileEnd()
				CIfEnd()
				
				Trigger2X(FP,{CD(PattC[3],100)},{RotatePlayer({PlayWAVX("staredit\\wav\\SE2.ogg"),PlayWAVX("staredit\\wav\\SE2.ogg"),PlayWAVX("staredit\\wav\\SE2.ogg"),PlayWAVX("staredit\\wav\\SE2.ogg")},HumanPlayers,FP)},{preserved})
				CIf(FP,{CD(PattC[3],100,AtLeast),CD(PattC[3],100+180,AtMost)},{SetFlingySpeed(158,(20*32)*4)})
					SetWeaponsDat({},128,{DmgBase=65535,FlingyID=158,Splash={8,8,8},RemoveAfter=64},{preserved})--210번 탄막유닛 무기 전반 설정
					f_Lengthdir(FP, 5*32, PattV[1], CPosX, CPosY)
					CreateBullet(210, 20, 192, 1216, _Add(CPosY,2912), FP)
					CreateBullet(210, 20, 192, 1216, _Add(CPosY,3232), FP)
					CAdd(FP,PattV[1],2)
				CIfEnd()
				
				TS_SendX(CD(PattC[3],200+80), BlasterBullet, {96*16,192*16,96*16,2848,1,0})
				TS_SendX(CD(PattC[3],200+80), BlasterBullet, {96*16,192*16,96*16,3296,1,180})
				TS_SendX(CD(PattC[3],250+80), BlasterBullet, {96*16,192*16,1472,192*16,1,90})
				TS_SendX(CD(PattC[3],250+80), BlasterBullet, {96*16,192*16,1600,192*16,1,270})
				TS_SendX(CD(PattC[3],300+80), BlasterBullet, {96*16,192*16,96*16,3008,1,0})
				TS_SendX(CD(PattC[3],300+80), BlasterBullet, {96*16,192*16,96*16,3136,1,180})
				TS_SendX(CD(PattC[3],350+80), BlasterBullet, {96*16,192*16,1312,192*16,1,90})
				TS_SendX(CD(PattC[3],350+80), BlasterBullet, {96*16,192*16,1760,192*16,1,270})
				TS_SendX(CD(PattC[3],400+80), BlasterBullet, {96*16,192*16,96*16,192*16,1,45})
				TS_SendX(CD(PattC[3],400+80), BlasterBullet, {96*16,192*16,96*16,192*16,1,45+90})
				TS_SendX(CD(PattC[3],450+80), BlasterBullet, {96*16,192*16,96*16,192*16,1,180})
				TS_SendX(CD(PattC[3],450+80), BlasterBullet, {96*16,192*16,96*16,192*16,1,180+90})
				TriggerX(FP,{CD(PattC[3],500+180,AtLeast)},{SetCD(PattC[1],1)},{preserved})

			CIfEnd()
		--			
			CIfEnd()


			CIf(FP,{CV(CA[1],1)},{SetFlingySpeed(158,(20*32))})
				DoActionsX(FP,{SubCD(PattC[2],1),AddCD(PattC[3],1)})
				SetWeaponsDat({},128,{DmgBase=65535,FlingyID=158,Splash={12,12,12},RemoveAfter=255},{preserved})--210번 탄막유닛 무기 전반 설정
				CIf(FP,{CD(PattC[2],0,AtMost)},{SetCD(PattC[2], 150)})

					local P2Act={} 
					for i = 1, 41 do
						table.insert(P2Act,SetCD(PattC3[i],1))

					end
						DoActions2X(FP,P2Act)
						local RS = f_CRandNum(41)
						for i = 1, 41 do
							local BSw = {}
							if PattC3[i-2] ~= nil then
								table.insert(BSw,SetCD(PattC3[i-2],0))
							end
							if PattC3[i-1] ~= nil then
								table.insert(BSw,SetCD(PattC3[i-1],0))
							end
							table.insert(BSw,SetCD(PattC3[i],0))
							if PattC3[i+1] ~= nil then
								table.insert(BSw,SetCD(PattC3[i+1],0))
							end
							if PattC3[i+2] ~= nil then
								table.insert(BSw,SetCD(PattC3[i+2],0))
							end
							
							TriggerX(FP,{CV(RS,i-1)},BSw,{preserved})
						end
					for i = 1, 41 do
						CreateBulletCond(210,20,192,{1216+16,2752-16+(i*16)},FP,{CD(PattC3[i],1)})
						CreateBulletCond(210,20,64,{1824+16,2752-16+(i*16)},FP,{CD(PattC3[i],1)})
					end
				CIfEnd()
				TriggerX(FP,{CD(PattC[3],1050,AtLeast)},{SetCD(PattC[1],1)},{preserved})
			CIfEnd()

			CIf(FP,{CV(CA[1],2)},{SetFlingySpeed(158,(20*32))})
			DoActionsX(FP,{SubCD(PattC[2],1),AddCD(PattC[3],1)})
			SetWeaponsDat({},128,{DmgBase=65535,FlingyID=158,Splash={12,12,12},RemoveAfter=255},{preserved})--210번 탄막유닛 무기 전반 설정
			TriggerX(FP,{CD(PattC[2],0,AtMost)},{SetCD(PattC[2], 150)},{preserved})
			DoActions(FP, {SetSwitch("Switch 100",Random),SetSwitch("Switch 1",Random)})
			for i = 0, 3 do
				local SW1 = Cleared
				local SW2 = Cleared
				if i == 1 then SW1 = Set end if i == 2 then SW2 = Set end if i==3 then SW1 = Set SW2 = Set end
				TriggerX(FP,{Switch("Switch 100",SW1),Switch("Switch 1",SW2)},{SetV(PattV[1],i*90)},{preserved})
			end
			TS_SendX({TTOR({CD(PattC[2],75),CD(PattC[2],150)})}, BlasterBullet, {96*16,192*16,96*16,192*16,0,PattV[1]})
			for i = 0, 20 do
				CreateBulletCond(210,20,0,{1216+(i*16),2752},FP,{CD(PattC[2],75)})
				CreateBulletCond(210,20,128,{1856-(i*16),2752+(20*32)},FP,{CD(PattC[2],150)})
			end
			TriggerX(FP,{CD(PattC[3],1050,AtLeast)},{SetCD(PattC[1],1)},{preserved})
			CIfEnd()

			
			CIf(FP,{CV(CA[1],3)},{SetFlingySpeed(158,(20*32)*2)})
			DoActionsX(FP,{SubCD(PattC[2],1),AddCD(PattC[3],1)})
			SetWeaponsDat({},128,{DmgBase=65535,FlingyID=158,Splash={12,12,12},RemoveAfter=128},{preserved})--210번 탄막유닛 무기 전반 설정
			TriggerX(FP,{CD(PattC[2],0,AtMost)},{SetCD(PattC[2], 70)},{preserved})
			
			DoActions(FP, {SetSwitch("Switch 100",Random),SetSwitch("Switch 1",Random),SetSwitch("Switch 101",Random)})
			for i = 0, 3 do
				local SW1 = Cleared
				local SW2 = Cleared
				if i == 1 then SW1 = Set end if i == 2 then SW2 = Set end if i==3 then SW1 = Set SW2 = Set end
				TriggerX(FP,{Switch("Switch 100",SW1),Switch("Switch 1",SW2)},{SetV(PattV[2],2752-16+((3+(i*5))*32))},{preserved})
			end
			
			TriggerX(FP,{Switch("Switch 101",Cleared)},{SetV(PattV[1],0)},{preserved})
			TriggerX(FP,{Switch("Switch 101",Set)},{SetV(PattV[1],180)},{preserved})
			TS_SendX({CD(PattC[2],70)}, BlasterBullet, {96*16,192*16,1536,PattV[2],1,PattV[1]})

			
			CreateBulletCond(210,20,192,{1216,2752+(5*32)},FP,{CD(PattC[2],15,AtMost)})
			CreateBulletCond(210,20,64,{1856,2752+(10*32)},FP,{CD(PattC[2],15,AtMost)})
			CreateBulletCond(210,20,192,{1216,2752+(15*32)},FP,{CD(PattC[2],15,AtMost)})


			
			TriggerX(FP,{CD(PattC[3],1000,AtLeast)},{SetCD(PattC[1],1)},{preserved})
			CIfEnd()



			CIf(FP,{CV(CA[1],4)},{SetFlingySpeed(158,(20*32)*6)})
			DoActionsX(FP,{SubCD(PattC[2],1),AddCD(PattC[3],1)})
			SetWeaponsDat({},128,{DmgBase=65535,FlingyID=158,Splash={12,12,12},RemoveAfter=48},{preserved})--210번 탄막유닛 무기 전반 설정
			--CallTrigger(FP, Call_CreateBullet_EPD) -- 타겟 탄막 작동
			CIf(FP,{CD(PattC[3],1)})
			CMov(FP,PattV[1],f_CRandNum(360))

			CMov(FP,PattV[2],_Div(_Mul(_Div(_Mul(PattV[1],100000),360),256),100000))

			
			local CI = CFor(FP,0,25*32,32)
			f_Lengthdir(FP, CI, PattV[1], CPosX, CPosY)
			Simple_SetLocX(FP, 0, _Add(CPosX,96*16), _Add(CPosY,192*16), _Add(CPosX,96*16), _Add(CPosY,192*16), {CreateUnitWithProperties(1, 94, 1, FP, {hallucinated = true}),KillUnit(94,FP)})
			f_Lengthdir(FP, CI, _Add(PattV[1],90), CPosX, CPosY)
			Simple_SetLocX(FP, 0, _Add(CPosX,96*16), _Add(CPosY,192*16), _Add(CPosX,96*16), _Add(CPosY,192*16), {CreateUnitWithProperties(1, 94, 1, FP, {hallucinated = true}),KillUnit(94,FP)})
			CForEnd()
			CIfEnd()

			CIf(FP,{CD(PattC[3],100,AtLeast)})
			TriggerX(FP,{CD(PattC[2],0,AtMost),CD(PattC[3],100,AtLeast),CD(PattC[3],200-1,AtMost)},{AddV(PattV[2],6)},{preserved})
			TriggerX(FP,{CD(PattC[2],0,AtMost),CD(PattC[3],200,AtLeast),CD(PattC[3],300-1,AtMost)},{SubV(PattV[2],9)},{preserved})
			TriggerX(FP,{CD(PattC[2],0,AtMost),CD(PattC[3],300,AtLeast),CD(PattC[3],450-1,AtMost)},{AddV(PattV[2],4)},{preserved})
			TriggerX(FP,{CD(PattC[2],0,AtMost),CD(PattC[3],450,AtLeast),CD(PattC[3],500-1,AtMost)},{SubV(PattV[2],12)},{preserved})
			TriggerX(FP,{CD(PattC[2],0,AtMost),CD(PattC[3],500,AtLeast),CD(PattC[3],600-1,AtMost)},{AddV(PattV[2],6)},{preserved})
			TriggerX(FP,{CD(PattC[2],0,AtMost),CD(PattC[3],600,AtLeast),CD(PattC[3],650-1,AtMost)},{SubV(PattV[2],3)},{preserved})
			TriggerX(FP,{CD(PattC[2],0,AtMost),CD(PattC[3],650,AtLeast),CD(PattC[3],700-1,AtMost)},{AddV(PattV[2],12)},{preserved})
			TriggerX(FP,{CD(PattC[2],0,AtMost)},{SetCD(PattC[2], 4)},{preserved})

			CIf(FP,{CD(PattC[2],4)})

			local CI = CFor(FP,0,192,6)

			CreateBullet(210, 20, _Add(CI,PattV[2]), 96*16, 192*16, FP)

			CForEnd()

				
			CIfEnd()

			CIfEnd()


			
			TriggerX(FP,{CD(PattC[3],700,AtLeast)},{SetCD(PattC[1],1)},{preserved})
			CIfEnd()


		CIfEnd()
		if Limit == 1 then
			--CTrigger(FP,{CD(TestMode,1),Deaths(Force1,AtLeast,1,208)},{SetV(CB[2],0)},1)
		end
		--CV(CB[2],8320000,AtMost) --LHP의 피가 다깎였을경우

		

		CIf(FP,{CD(PattC[1],1,AtLeast),CV(CB[3],0)},{SetCD(PattC[1],0)})
			TriggerX(FP,{},{SetV(CB[3],250)},{preserved})--SetInvincibility(Enable, 96, FP, 64),
			CIfX(FP,{CV(CB[2],8320000,AtMost),CV(CA[1],9,AtMost)},{AddV(CA[1],1)})--
				CA_SetLHP("12800000000")
				--DoActions2(FP,{CreateUnit(3,84,64,FP),KillUnit(84, FP),RotatePlayer({PlayWAVX("staredit\\wav\\start.ogg"),PlayWAVX("staredit\\wav\\start.ogg"),PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP)})
			CElseX()

			CIfXEnd()
			ResetActT = {}
			for j,k in pairs(PattV) do
				table.insert(ResetActT,SetV(k,0))
			end
			for j,k in pairs(PattC) do
				table.insert(ResetActT,SetCD(k,0))
			end
			for j,k in pairs(PattC2) do
				table.insert(ResetActT,SetCD(k,0))
			end
			
			
			
			
			DoActions2X(FP,ResetActT)
		CIfEnd()
	B3DeathCheck = CB[5]
	end--CABossFunc end




	CIf(FP,{CD(SBossStart,1,AtLeast)},{AddCD(SBossStart,Dt)})

	Trigger2X(FP,{},{RotatePlayer({PlayWAVX("staredit\\wav\\SE4.ogg"),PlayWAVX("staredit\\wav\\SE4.ogg")},HumanPlayers,FP)})
	DoActions(FP,{MoveUnit(All,96,FP,64,64)})--보스위치고정
	DoActionsX(FP,{SetCD(BWait,1),SetCD(CUnitFlag,1),SetCD(MarDup,1),SetCD(MarDup2,1),
	SetMemoryW(0x666160+(511*2), SetTo, 961),--럴커가시이미지
	SetMemoryB(0x669E28+961, SetTo, 17),--럴커가시색상
	SetMemoryB(0x669E28+541, SetTo, 16),--야마토색상
	SetMemoryB(0x669E28+374, SetTo, 17),--할루시데스색상
	SetMemoryB(0x669E28+375, SetTo, 17),--할루시데스색상
	SetMemoryB(0x669E28+376, SetTo, 17),--할루시데스색상
},1)
	local TempActT = {}
		for i = 0, 6 do
			table.insert(TempActT,SetMemory(0x657470 + (MarWep[i+1]*4) ,SetTo,32*7))
			table.insert(TempActT,MoveUnit(All, "Men", i, "Center", 2+i))
			Trigger2X(FP,{CD(SBossStart,5000+(2500*3)+5000,AtLeast),HumanCheck(i, 1),Bring(i,AtLeast,13,"Men",91)},{RotatePlayer({PlayWAVX("staredit\\wav\\SE2.ogg"),PlayWAVX("staredit\\wav\\SE2.ogg"),PlayWAVX("staredit\\wav\\SE2.ogg"),PlayWAVX("staredit\\wav\\SE2.ogg")},HumanPlayers,FP),SetCD(TalkCond,1),MoveUnit(All, "Men", i, 91, 2+i)},{preserved})
		end
		DoActions(FP,TempActT,1)
	DoActions(FP,{RotatePlayer({RunAIScript(P8VON)},MapPlayers,FP)},1)
	for i = 0, 6 do
		local Br = 0
		if i%2==1 then Br = 32 
		else
			Trigger2X(FP,{CD(SBossStart,i*100,AtLeast)},{RotatePlayer({PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),},HumanPlayers,FP)})
		end
		SetBright(i*100,Br)
	end
	Trigger2X(FP,{CD(SBossStart,600,AtLeast)},{RotatePlayer({PlayWAVX("staredit\\wav\\SE3.ogg"),PlayWAVX("staredit\\wav\\SE3.ogg"),PlayWAVX("staredit\\wav\\SE3.ogg")},HumanPlayers,FP)})

	
	
	SetBright(3100,31)

	SetBright(1000,31)
	CIfOnce(FP,{CD(SBossStart,1000,AtLeast)})
	CDoActions(FP, {
		CreateUnit(1,96,64,FP),RotatePlayer({CenterView(64)},HumanPlayers,FP),
		SetMemoryB(0x669E28+151, SetTo, 0),--색상복구
		SetInvincibility(Enable, 96, FP, 64)
	})
	CIfEnd()

	StoryPrintS(5000+(2500*0),"\x04정말 아름다운 날이야.")
	StoryPrintS(5000+(2500*1),"\x04새들은 지저귀고, 꽃들은 피어나고...")
	StoryPrintS(5000+(2500*2),"\x04이런 날엔, 너희 같은 랭커들은...")
	SetBright(5000+(2500*3)+0,0)
	Trigger2X(FP,{CD(SBossStart,5000+(2500*3)+0,AtLeast)},{RotatePlayer({PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg")},HumanPlayers,FP),RemoveUnit(96,FP)})
	SetBright(5000+(2500*3)+500,31)
	Trigger2X(FP,{CD(SBossStart,5000+(2500*3)+500,AtLeast)},{RotatePlayer({PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg"),PlayWAVX("staredit\\wav\\SE1.ogg")},HumanPlayers,FP),SetV(TalkTimer,6)})
	StoryPrintS(5000+(2500*3)+1000,"\x081층으로 떨어져야 해.")
	


	CIfOnce(FP,{CD(SBossStart,5000+(2500*3)+500,AtLeast)})
	local CryAct = {SetMemoryB(0x669E28+958, SetTo, 16)}
	--1216 2736
	local OrderLocAct = {}--색상
	local CLX = 1216
	local CRX = 1856
	local CLY = 2736
	local CRY = 3408
	
	for i =0, 10 do
		table.insert(OrderLocAct,Simple_SetLoc(0, 1216+(i*64)-32, 2752-16, 1216+(i*64)+32, 2752+16))
		table.insert(OrderLocAct,Simple_SetLoc(80, 1216+(i*64)-32, 2752-16+32, 1216+(i*64)+32, 2752+16+32))
		table.insert(OrderLocAct,Order("Men",Force1,1,Move,81))
		table.insert(OrderLocAct,Simple_SetLoc(0, 1216+(i*64)-32, 3392-16, 1216+(i*64)+32, 3392+16))
		table.insert(OrderLocAct,Simple_SetLoc(80, 1216+(i*64)-32, 3392-16-32, 1216+(i*64)+32, 3392+16-32))
		table.insert(OrderLocAct,Order("Men",Force1,1,Move,81))

		table.insert(CryAct,Simple_SetLoc(0, 1216+(i*64), 2752, 1216+(i*64), 2752))
		table.insert(CryAct,CreateUnit(1,129,1,FP))
		table.insert(CryAct,Simple_SetLoc(0, 1216+(i*64), 3392, 1216+(i*64), 3392))
		table.insert(CryAct,CreateUnit(1,129,1,FP))

		
	end
	for i =0, 9 do
		table.insert(OrderLocAct,Simple_SetLoc(0, 1216-16, 2784+(i*64)-32, 1216+16, 2784+(i*64)+32))
		table.insert(OrderLocAct,Simple_SetLoc(80, 1216-16+32, 2784+(i*64)-32, 1216+16+32, 2784+(i*64)+32))
		table.insert(OrderLocAct,Order("Men",Force1,1,Move,81))

		table.insert(OrderLocAct,Simple_SetLoc(0, 1856-16, 2784+(i*64)-32, 1856+16, 2784+(i*64)+32))
		table.insert(OrderLocAct,Simple_SetLoc(80, 1856-16-32, 2784+(i*64)-32, 1856+16-32, 2784+(i*64)+32))
		table.insert(OrderLocAct,Order("Men",Force1,1,Move,81))

		table.insert(CryAct,Simple_SetLoc(0, 1216, 2784+(i*64), 1216, 2784+(i*64)))
		table.insert(CryAct,CreateUnit(1,129,1,FP))
		table.insert(CryAct,Simple_SetLoc(0, 1856, 2784+(i*64), 1856, 2784+(i*64)))
		table.insert(CryAct,CreateUnit(1,129,1,FP))

	end
	table.insert(CryAct,Simple_SetLoc(0, 1408, 2944, 1408, 2944))
	table.insert(CryAct,CreateUnit(1,101,1,FP))
	table.insert(CryAct,Simple_SetLoc(0, 1664, 2944, 1664, 2944))
	table.insert(CryAct,CreateUnit(1,101,1,FP))
	table.insert(CryAct,Simple_SetLoc(0, 1408, 3200, 1408, 3200))
	table.insert(CryAct,CreateUnit(1,101,1,FP))
	table.insert(CryAct,Simple_SetLoc(0, 1664, 3200, 1664, 3200))
	table.insert(CryAct,CreateUnit(1,101,1,FP))
	DoActions2(FP, CryAct)
	f_Read(FP,0x628438,nil,Nextptrs)
	CMov(FP,SBossPtr,Nextptrs)
	CDoActions(FP, {
		SetMemoryB(0x669E28+151, SetTo, 16),--색상
		CreateUnit(1,96,64,FP),RotatePlayer({CenterView(64)},HumanPlayers,FP),
		SetMemoryB(0x669E28+151, SetTo, 0),--색상복구
	})
	CIfEnd()


	

	
	for i = 30,0,-1 do
		SetBright((5000+(2500*3)+4000)-(i*100),i)
	end
	SetBright(5000+(2500*3)+4200,32)
	TriggerX(FP,{CD(SBossStart,5000+(2500*3)+1000,AtLeast)},{SetCVar(FP,ReserveBGM[2],SetTo,SBossBGM)},{preserved})
	if Limit == 1 then
		TriggerX(FP,{CD(TestMode)},{SetCD(SBossStart,5000+(2500*3)+4200)})
	end
	StoryPrintS(5000+(2500*3)+4200,"\x04뭐? 내가 딜찍누를 허용할 거라 생각했어?",CD(TalkCond,1))
	Trigger2X(FP,{CD(SBossStart,5000+(2500*3)+4200,AtLeast)},{RotatePlayer({PlayWAVX("staredit\\wav\\GBl2.ogg"),PlayWAVX("staredit\\wav\\GBl2.ogg"),PlayWAVX("staredit\\wav\\GBl2.ogg"),PlayWAVX("staredit\\wav\\GBl2.ogg")},HumanPlayers,FP)})
	CIf(FP,{CD(SBossStart,5000+(2500*3)+4200,AtLeast),CV(BossP,32*11,AtMost)},{SetV(TalkTimer,3),SetCD(BWait,0),SetMemoryB(0x669E28+429, SetTo, 17),})
		CFor(FP,0,360,15)
		local CI = CForVariable()
		CIf(FP,Memory(0x628438,AtLeast,1))
		f_Read(FP,0x628438,nil,Nextptrs)
		f_Lengthdir(FP, BossP, CI, CPosX, CPosY)
		Simple_SetLocX(FP, 0, _Add(CPosX,(96*16)-32), _Add(CPosY,(192*16)-32), _Add(CPosX,(96*16)+32), _Add(CPosY,(192*16)+32), {})--
		CDoActions(FP, {CreateUnit(1,13,1,FP),
		TSetMemoryX(_Add(Nextptrs,55),SetTo,0xA00104,0xA00104),
		TSetMemory(_Add(Nextptrs,57),SetTo,0),
		KillUnitAt(All, "Men", 1, Force1),KillUnit(13, FP),
		})
		CIfEnd()
		CForEnd()
		CAdd(FP,BossP,32)
	CIfEnd()




	DTimer = CreateCcode()
	CIf(FP,{CV(SBossPtr,19025,AtLeast),CV(SBossPtr,19025+(84*1699),AtMost)})    
	DoActions2(FP,OrderLocAct)
	CTrigger(FP,{TMemoryX(_Add(SBossPtr,19), Exactly, 0, 0xFF00),CD(DTimer,6000+(20000),AtMost)},{TSetMemoryX(_Add(SBossPtr,19), SetTo, 1*256, 0xFF00),TSetMemory(_Add(SBossPtr,2), SetTo, 0),SetCD(DCheck,1),SetInvincibility(Enable, 96, FP, 64)},1)
	CIfEnd()
	Trigger2X(FP,{CD(DCheck,1)},{RotatePlayer({PlayWAVX("staredit\\wav\\UTKill.wav"),PlayWAVX("staredit\\wav\\UTKill.wav"),PlayWAVX("staredit\\wav\\UTKill.wav"),PlayWAVX("staredit\\wav\\UTKill.wav")},HumanPlayers,FP),})



	CIf(FP,{CD(DCheck,1,AtLeast),CD(DCheck,60,AtMost)},{
		SetMemoryW(0x666160+(294*2), SetTo, 233),--이미지
		SetMemory(0x66EC48+(4*233), SetTo, 131),--스크립트
		SetMemoryB(0x669E28+233, SetTo, 0),
		AddCD(DCheck,1)
	})
	local TempDv = CreateVar(FP)
	CMov(FP,CPosX,0)
	CMov(FP,CPosY,TempDv,0)

	function SDeathFunc()
		local CA = CAPlotDataArr
		local CB = CAPlotCreateArr
		local PlayerID = CAPlotPlayerID
		CIf(FP,Memory(0x628438,AtLeast,1))
		Simple_SetLocX(FP, 0, _Add(V(CA[8]),CPosX),_Add(V(CA[9]),CPosY),_Add(V(CA[8]),CPosX),_Add(V(CA[9]),CPosY))--
		f_Read(FP,0x628438,nil,Nextptrs)
		CDoActions(FP,{
			CreateUnit(1,207, 1,FP),
			TSetMemoryX(_Add(Nextptrs,55),SetTo,0xA00104,0xA00104),
			TSetMemory(_Add(Nextptrs,57),SetTo,0),
		})
	
		CIfEnd()
	end

	


	CAPlot(Shape9215, FP, nilunit, 0, {CPosX,CPosY},1, 32, {1,0,0,0,9999,0}, "SDeathFunc", FP, {}, {}, 1)
	CAdd(FP,TempDv,-1)
	CIfEnd()
	CTrigger(FP, {CD(DCheck,1,AtLeast)}, {AddCD(DTimer,Dt),SetV(TalkTimer,4)}, 1)
	StoryPrintS2(6000,"...그래...")
	StoryPrintS2(6000+(3000*1),"결국... 이렇게, 되는건가?")
	StoryPrintS2(6000+(3000*2),"뭐.. 그릴비나 가야겠군.")
	for i = 30,0,-1 do
		SetBright2((6000+(3000*2)+3000)-(i*100),i)
	end
	StoryPrintS2(6000+(3000*3),"파피루스, 뭐 먹고싶은거 없어?")
	Trigger2X(FP, {CD(DTimer,6000+(20000),AtLeast)}, {RotatePlayer({PlayWAVX("staredit\\wav\\SDth.ogg"),PlayWAVX("staredit\\wav\\SDth.ogg"),SetCD(SBossStart,0)},HumanPlayers,FP),RemoveUnit(96, FP)})
	


		
	if Limit == 1 then
		CIf(FP,CD(TestMode,1))
		TriggerX(FP,{}, RotatePlayer({RunAIScript(P8VON)},MapPlayers,FP),{preserved})
		--GetLocCenter(73, CPosX, CPosY)
		--AngleRand = f_CRandNum(360)
        --TS_SendX(Deaths(Force1,AtLeast,1,41), BlasterBullet, {96*16,192*16,CPosX,CPosY,1,AngleRand})
		--Trigger2X(FP,{Deaths(Force1,AtLeast,1,41)},{RotatePlayer({DisplayTextX("\x0D\x0D!H대사 출력 테스트,        나는 샌즈",4)},HumanPlayers,FP),SetCD(GBl1SE,0)},{preserved})
		--TS_SendX(Deaths(Force1,AtLeast,1,41), BoneBullet, {CPosX,CPosY})
		DoActions(FP, SetDeaths(Force1,SetTo,0,41))
		
		CIfEnd()
	end

	
	TS_CreateArr(BoneBullet)
	TS_CreateArr(BlasterBullet)
	Trigger2X(FP,{CD(GBl1SE,1)},{RotatePlayer({PlayWAVX("staredit\\wav\\GBl1.ogg"),PlayWAVX("staredit\\wav\\GBl1.ogg")},HumanPlayers,FP),SetCD(GBl1SE,0)},{preserved})
	Trigger2X(FP,{CD(GBl2SE,1)},{RotatePlayer({PlayWAVX("staredit\\wav\\GBl2.ogg"),PlayWAVX("staredit\\wav\\GBl2.ogg")},HumanPlayers,FP),SetCD(GBl2SE,0)},{preserved})
	Trigger2X(FP,{CD(WRSE,1)},{RotatePlayer({PlayWAVX("staredit\\wav\\WR.ogg"),PlayWAVX("staredit\\wav\\WR.ogg")},HumanPlayers,FP),SetCD(WRSE,0)},{preserved})
	Trigger2X(FP,{CD(BSSE,1)},{RotatePlayer({PlayWAVX("staredit\\wav\\BS.ogg"),PlayWAVX("staredit\\wav\\BS.ogg")},HumanPlayers,FP),SetCD(BSSE,0)},{preserved})
	

--
--


	CallTrigger(FP, Call_CDPrint)






	
	if BossPhaseTestMode == 1 then
		BinitT = CreateVar2(FP,nil,nil,300)
		TriggerX(FP, {CD(TestMode,1)}, {SetV(BinitT,0)})
	else
		BinitT = 300
	end

	CABoss(SBossPtr,nil,{0,BinitT,2,"12800000000",8320000,1},"CABossFunc",FP,nil,nil,LHPCunit)
	CIfEnd()

end