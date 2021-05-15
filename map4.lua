
	dofile("lua/Loader.lua")
	dofile("Map4Source/LibraryFor322.lua")

	FP = P8
	EUDTurbo(FP) -- 뎡터보


	RepUnitPtr = 0x593000 -- 유닛 데이터 저장 장소

	function Call_SaveCp()
		CallTrigger(FP,SaveCp_CallIndex,nil)
	end
	function Call_LoadCp()
		CallTrigger(FP,LoadCp_CallIndex,nil)
	end



	MarID = {0,1,16,20,32,99,100} 

	SetForces({P1,P2,P3,P4,P5,P6},{P7,P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
	SetFixedPlayer(FP)
	StartCtrig()

	CreateTableSet({
	"MarHP",
	})
	for i = 0, 6 do
		table.insert(MarHP,CreateVar())
	end
	CreateVariableSet({"RepHeroIndex","RepX","RepY","BackupCp","CPos","CPosX","CPosY","BacpupPtr","CurrentUID","SelPTR","SelEPD","MarTblPtr","SelHP"})

	CJump(AllPlayers,0x700)
	Include_CtrigPlib(360,"Switch 100",1)


	tblReset = CreateCText(FP,string.rep("\x0D",80))
	HPText = CreateCText(FP,"\x06HP \x04: \x0D\x0D\x0D\x0D")
	HPText2 = CreateCText(FP,"\x04 / \x0D\x0D\x0D\x0D")
	MarHPT = CVArray(FP,4)
	SelHPT = CVArray(FP,4)

	SaveCp_CallIndex = SetCallForward()
	SetCall(FP)
		SaveCp(FP,BackupCp)
	SetCallEnd()
	LoadCp_CallIndex = SetCallForward()
	SetCall(FP)
		LoadCp(FP,BackupCp)
	SetCallEnd()
	HeroToData = SetCallForward()
	SetCall(FP)
	CMov(FP,0x6509B0,19025+25)
	CWhile(FP,Memory(0x6509B0,AtMost,19025+25 + (84*1699)))
	CIf(FP,{TDeathsX(CurrentPlayer,Exactly,RepHeroIndex,0,0xFF)})
	Call_SaveCp()
	f_Read(FP,_Sub(BackupCp,15),CPos)
	CMov(FP,0x6509B0,EPD(RepUnitPtr))
	NWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0))
	CAdd(FP,0x6509B0,2)
	NWhileEnd()
	CDoActions(FP,{
	TSetDeaths(CurrentPlayer,SetTo,CPos,0),
	SetMemory(0x6509B0,Add,1),
	TSetDeaths(CurrentPlayer,SetTo,RepHeroIndex,0)
	})
	Call_LoadCp()
	CIfEnd()
	CAdd(FP,0x6509B0,84)
	CWhileEnd()
	CAdd(FP,0x6509B0,FP)
	CDoActions(FP,{TRemoveUnit(RepHeroIndex,AllPlayers)})
	SetCallEnd()
	CJumpEnd(AllPlayers,0x700)
	NoAirCollisionX(FP)
	Enable_PlayerCheck()




	CIfOnce(FP,nil) -- OnPluginStart

	dofile("Map4Source/EUDinit.lua")


	HeroIndexArr = {101} -- 재배치할 유닛 ID 하나하나 쓰면 됨.


	for i = 1, #HeroIndexArr do -- 유닛 데이터화
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
		},
		actions = {
			SetCVar(FP,RepHeroIndex[2],SetTo,HeroIndexArr[i]);
			SetNext("X",HeroToData,0);
			SetNext(HeroToData+1,"X",1);
		}
	}
	end



	CMov(FP,0x6509B0,EPD(RepUnitPtr))-- 데이터화 한 유닛 배치하는 코드
	CWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0))

	Call_SaveCp()

	f_Read(FP,BackupCP,CPosX,"X",0xFFFF)
	f_Read(FP,BackupCP,CPosY,"X",0xFFFF0000)
	CDiv(FP,CPosY,0x10000)
	f_Read(FP,_Add(BackupCP,1),RepHeroIndex)
	CDoActions(FP,{
	SetMemory(0x58DC60 + 0x14*0,SetTo,0),
	SetMemory(0x58DC68 + 0x14*0,SetTo,0),
	SetMemory(0x58DC64 + 0x14*0,SetTo,0),
	SetMemory(0x58DC6C + 0x14*0,SetTo,0),
	TSetMemory(0x58DC60 + 0x14*0,SetTo,_Sub(CPosX,18)),
	TSetMemory(0x58DC68 + 0x14*0,SetTo,_Add(CPosX,18)),
	TSetMemory(0x58DC64 + 0x14*0,SetTo,_Sub(CPosY,18)),
	TSetMemory(0x58DC6C + 0x14*0,SetTo,_Add(CPosY,18)),
	TCreateUnit(1, RepHeroIndex, 1, P7)
	})
	Call_LoadCp()
	CAdd(FP,0x6509B0,2)
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
	f_GetTblptr(FP,MarTblPtr,1501)
	DoActions(FP,CreateUnit(1,MarID[1],64,P1))
	CMov(FP,MarHP[1],9000)
	CMov(FP,0x58F464,8999)
	CIfEnd(SetMemory(0x6509B0,SetTo,FP))

	DoActions2(FP,PatchArrPrsv)

	TblActArr = {}
	for i = 0, 19 do
		table.insert(TblActArr,SetDeaths(0,SetTo,0x0D0D0D0D,0))
	end

	for i = 0, 6 do

	CIf(FP,PlayerCheck(i,1))
		CIf(FP,{TTMemory(0x58F464+(i*4),"!=",MarHP[i+1])})
			f_Read(FP,0x58F464+(i*4),MarHP[i+1])
			CMov(FP,0x662350 + (MarID[i+1]*4),_Mul(MarHP[i+1],256))
			CMov(FP,0x515BB0+(i*4),_Div(_Read(0x662350 + (MarID[i+1]*4)),1000))
		CIfEnd()
		f_Read(FP,0x6284E8+(12*i),SelPTR,SelEPD)
		CIf(FP,{CVar(FP,SelPTR[2],AtLeast,1),Memory(0x57F1B0, Exactly, i)})
			CIf(FP,{TDeathsX(_Add(SelEPD,25),Exactly,MarID[i+1],0,0xFF)})
				f_Read(FP,_Add(SelEPD,2),SelHP)
				ItoDec(FP,MarHP[i+1],VArr(MarHPT,0),2,0x08)
				ItoDec(FP,SelHP,VArr(SelHPT,0),2,0x08)

				f_MemCpyX(FP,_EPD(MarTblPtr),0,_TMem(Arr(tblReset[3],0)),0,tblReset[2])

				f_MemCpy(FP,MarTblPtr,_TMem(Arr(HPText[3],0),"X","X",1),HPText[2])
				f_MovCpy(FP,_Add(MarTblPtr,HPText[2]),VArr(SelHPT,0),4*4)
				f_MemCpy(FP,_Add(MarTblPtr,HPText[2]+(4*4)),_TMem(Arr(HPText2[3],0),"X","X",1),HPText2[2])
				f_MovCpy(FP,_Add(MarTblPtr,HPText[2]+(4*4)+HPText2[2]),VArr(MarHPT,0),4*4)
			CIfEnd()
		CIfEnd()
	CIfEnd()
	end




	CJump(FP,0x0)
	InstallCVariable()
	CJumpEnd(FP,0x0)
	EndCtrig()
	ErrorCheck()