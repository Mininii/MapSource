function init() -- 맵 실행시 1회 실행 트리거
	CIfOnce(FP)
	table.insert(CtrigInitArr[FP],SetCtrigX(FP,CC_Header[2],0x15C,0,SetTo,FP,EXCC_Forward,0x15C,1,2))--{"X",EXCC_Forward,0x15C,1,2}--CC_Header


	CMov(FP,CurrentUID,0)
	CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227)) --  모든 유닛의 스패셜 어빌리티 플래그 설정
	local Rep_Jump1 = def_sIndex()
	for j, k in pairs(Replace_JumpUnitArr) do
		NJumpX(FP,Rep_Jump1,{CVar(FP,CurrentUID[2],Exactly,k)})
	end
	CMov(FP,VRet,CurrentUID,EPD(0x664080)) -- SpecialAdvFlag
	CMov(FP,VRet2,CurrentUID,EPD(0x662860)) --BdDim
	ConvertArr(FP,ArrID,CurrentUID)
	CMov(FP,ArrX(BdDimArr,ArrID),_ReadF(VRet2))
	f_Read(FP,_Add(CurrentUID,EPD(0x662350)),ArrX(MaxHPBackUp,ArrID))
	f_Mod(FP,VRet3,CurrentUID,_Mov(2))
	f_Div(FP,VRet4,CurrentUID,_Mov(2))
	CTrigger(FP,{TDeathsX(VRet,Exactly,0x1,0,0x1)},{TSetDeaths(VRet2,SetTo,65537,0)},1) -- if Advanced Flags = Building then Building Dimensions SetTo 1x1
	CDoActions(FP,{TSetDeathsX(VRet,SetTo,0x200000,0,0x200000),}) -- All Unit SetTo Spellcaster
	CTrigger(FP,{CVar(FP,VRet3[2],Exactly,0)},{TSetDeathsX(_Add(VRet4,EPD(0x661518)),SetTo,0x1C7,0,0x1C7)},1) -- Set All Units StarEdit Av Flags
	CTrigger(FP,{CVar(FP,VRet3[2],Exactly,1)},{TSetDeathsX(_Add(VRet4,EPD(0x661518)),SetTo,0x1C7*0x10000,0,0x1C7*0x10000)},1) -- Set All Units StarEdit Av Flags
	NJumpXEnd(FP,Rep_Jump1)
	CAdd(FP,CurrentUID,1)
	CWhileEnd()
	CMov(FP,CurrentUID,0)
	
CMov(FP,0x6509B0,19025+19)
CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
	CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,Exactly,4,0,0xFF)})
		-- 유닛정보를 길이 8바이트의 데이터 배열에 저장함
		-- 0xYYYYXXXX 0xLLIIPPUU
		-- X = 좌표 X, Y = 좌표 Y, L = 유닛 식별자, I = 무적 플래그, P = 플레이어ID, U = 유닛ID
		CAdd(FP,0x6509B0,6)
		local Rep_Jump4 = def_sIndex()
		for j, k in pairs(Replace_JumpUnitArr) do
			NJumpX(FP,Rep_Jump4,{DeathsX(CurrentPlayer,Exactly,k,0,0xFF)})
		end
		CSub(FP,0x6509B0,6)
		f_SaveCp()
			f_Read(FP,_Sub(BackupCp,9),CPos)
			f_Read(FP,_Sub(BackupCp,17),CunitHP)
			f_Read(FP,BackupCp,CunitP,"X",0xFF)
			f_Div(FP,CunitHP,_Mov(256))
			f_Read(FP,_Add(BackupCp,6),RepHeroIndex)
			CMov(FP,Gun_LV,0)
			CTrigger(FP,{TTOR({
				CVar(FP,RepHeroIndex[2],Exactly,133),
				CVar(FP,RepHeroIndex[2],Exactly,132),
				CVar(FP,RepHeroIndex[2],Exactly,131)})},{TSetCVar(FP,Gun_LV[2],SetTo,CunitHP)},1)
			CMov(FP,CunitIndex,_Div(_Sub(BackupCp,19025+19),_Mov(84)))
			CMov(FP,0x6509B0,UnitDataPtr)
			NWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0))
			CAdd(FP,0x6509B0,2)
			NWhileEnd()
			CDoActions(FP,{
				TSetDeaths(CurrentPlayer,SetTo,CPos,0),
				SetMemory(0x6509B0,Add,1),
				TSetDeathsX(CurrentPlayer,SetTo,RepHeroIndex,0,0xFF),
				TSetDeathsX(CurrentPlayer,SetTo,_Mul(CunitP,_Mov(0x100)),0,0xFF00),
				TSetDeathsX(CurrentPlayer,SetTo,_Mul(Gun_LV,_Mov(0x1000000)),0,0xFF000000),
				})
				CTrigger(FP,{TMemoryX(_Add(BackupCp,36),Exactly,0x04000000,0x04000000)},{SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0x10000)},1) -- 0x10000 무적플래그
			--CDoActions(FP,{
			--	--TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(CC_Header,((0x20*8)/4))),SetTo,1),
			--	TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),CC_Header),SetTo,Gun_LV)})
		f_LoadCp()
		CAdd(FP,0x6509B0,6)
		NJumpXEnd(FP,Rep_Jump4)
		CSub(FP,0x6509B0,6)
	CIfEnd()
	CAdd(FP,0x6509B0,84)
CWhileEnd()
CMov(FP,0x6509B0,FP)

CMov(FP,CurrentUID,0)
CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227))
local Rep_Jump2 = def_sIndex()
for j, k in pairs(Replace_JumpUnitArr) do
	NJumpX(FP,Rep_Jump2,{CVar(FP,CurrentUID[2],Exactly,k)})
end
CDoActions(FP,{
	TModifyUnitEnergy(All,CurrentUID,P5,64,0),
	TRemoveUnit(CurrentUID,P5)})
NJumpXEnd(FP,Rep_Jump2)
CAdd(FP,CurrentUID,1)
CWhileEnd()
CDoActions(FP,{KillUnit(35,P5)})
CIfEnd(SetMemory(0x6509B0,SetTo,FP)) -- OnPluginStart End
end
function init_Start() -- 게임 시작시 1회 실행 트리거
	CIfOnce(FP)
	
	CWhile(FP,CDeaths(FP,AtMost,3,CurPlace))
	CMov(FP,0x6509B0,UnitDataPtr)
	CWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0)) -- 배열에서 데이터가 발견되지 않을때까지 순환한다.
		f_SaveCp()
	--	CIf(FP,{TDeathsX(_Add(BackupCP,1),Exactly,TestCheck,0,0xFF)})
		CallTrigger(FP,f_Replace)-- 데이터화 한 유닛 재배치하는 코드
	--	CIfEnd()
		CAdd(FP,0x6509B0,2)
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
	DoActionsX(FP,{SetCDeaths(FP,Add,1,CurPlace)})
	CWhileEnd()
	--CIfEnd()
	DoActions(P8,SetResources(Force1,SetTo,0,Gas),1)
	if TestStart == 1 then
		DoActions(P8,SetResources(Force1,SetTo,0x66666666,Ore),1)
	end
	CMov(FP,CurrentUID,0)
	CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227))
	local Rep_Jump3 = def_sIndex()
	for j, k in pairs(Replace_JumpUnitArr) do
		NJumpX(FP,Rep_Jump3,{CVar(FP,CurrentUID[2],Exactly,k)})
	end
	CMov(FP,VRet2,CurrentUID,EPD(0x662860)) --BdDim
	ConvertArr(FP,ArrID,CurrentUID)
	CDoActions(FP,{TSetMemory(VRet2,SetTo,_ReadF(ArrX(BdDimArr,ArrID)))})
	NJumpEnd(FP,Rep_Jump3)
	CAdd(FP,CurrentUID,1)
	CWhileEnd()
	
	CIfEnd()
end

