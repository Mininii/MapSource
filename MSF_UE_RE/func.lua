
function Install_CBullet()

local CB_UnitIDV =CreateVar(FP)
local Height_V = CreateVar(FP)
local Angle_V = CreateVar(FP)
local CB_X = CreateVar(FP)
local CB_Y = CreateVar(FP)
local CB_TX = CreateVar(FP)
local CB_TY = CreateVar(FP)
local CB_P = CreateVar(FP)
function CreateBulletCond(UnitId,Height,Angle,XY,Player,Cond,Act)
	CallTriggerX(FP,CallCBullet,Cond,{Act,
	SetCVar(FP,CB_X[2],SetTo,XY[1]),
	SetCVar(FP,CB_Y[2],SetTo,XY[2]),
	SetCVar(FP,Angle_V[2],SetTo,Angle),
	SetCVar(FP,Height_V[2],SetTo,Height),
	SetCVar(FP,CB_UnitIDV[2],SetTo,UnitId),
	SetCVar(FP,CB_P[2],SetTo,Player),})
end
	function CreateBullet(UnitID,Height,Angle,X,Y,ForPlayer)
		if ForPlayer == nil then ForPlayer = FP end
	CDoActions(FP,{
		TSetCVar(FP,CB_UnitIDV[2],SetTo,UnitID),
		TSetCVar(FP,Height_V[2],SetTo,Height),
		TSetCVar(FP,Angle_V[2],SetTo,Angle),
		TSetCVar(FP,CB_X[2],SetTo,X),
		TSetCVar(FP,CB_Y[2],SetTo,Y),
		TSetCVar(FP,CB_P[2],SetTo,ForPlayer),
		SetNext("X",CallCBullet,0),SetNext(CallCBullet+1,"X",1)
	})
	end
	
	CallCBullet = SetCallForward()
	SetCall(FP)
	CIf(FP,Memory(0x628438,AtLeast,1))
		f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
		CIf(FP,{CVar(FP,Angle_V[2],AtLeast,0x80000000)})
			CNeg(FP,Angle_V)
			CSub(FP,Angle_V,_Mov(256),Angle_V)
		CIfEnd()
		f_Mod(FP,Angle_V,_Mov(256))
		CDoActions(FP,{
			TSetMemoryB(0x656990, CB_UnitIDV, SetTo, Height_V),
			TSetMemory(0x58DC60 + 0x14*0,SetTo,CB_X),
			TSetMemory(0x58DC68 + 0x14*0,SetTo,CB_X),
			TSetMemory(0x58DC64 + 0x14*0,SetTo,CB_Y),
			TSetMemory(0x58DC6C + 0x14*0,SetTo,CB_Y),
			TCreateUnit(1, CB_UnitIDV, 1, CB_P)})
		CDoActions(FP,{
			TSetMemoryX(_Add(Nextptrs,0x58/4),SetTo,_ReadF(_Add(Nextptrs,(0x28/4))),0xFFFFFFFF),
			TSetMemoryX(_Add(Nextptrs,0x20/4),SetTo,_Mul(Angle_V,256),0xFF00),
			TSetMemoryX(_Add(Nextptrs,0x4C/4),SetTo,135*256,0xFF00),
			TSetMemoryX(_Add(Nextptrs,40),SetTo,0,0xFF000000),
			TSetMemoryX(_Add(Nextptrs,55),SetTo,0x200104,0x300104),
			TSetMemory(_Add(Nextptrs,57),SetTo,0),
			TSetMemoryX(_Add(Nextptrs,68),SetTo,12,0xFFFF)
		})
	CIfEnd()
	SetCallEnd()

	function CreateBulletXY(UnitID,Height,XY,TargetXY,ForPlayer)
		if ForPlayer == nil then ForPlayer = FP end
		if XY == nil then
			XY={0,0}
		elseif type(XY) ~= "table" then
			PushErrorMsg("SetBullet_XY_Error")
		end
		if TargetXY == nil then
			TargetXY={0,0}
		elseif type(TargetXY) ~= "table" then
			PushErrorMsg("SetBullet_XY_Error")
		end
	CDoActions(FP,{
		TSetCVar(FP,CB_UnitIDV[2],SetTo,UnitID),
		TSetCVar(FP,Height_V[2],SetTo,Height),
		TSetCVar(FP,CB_X[2],SetTo,XY[1]),
		TSetCVar(FP,CB_Y[2],SetTo,XY[2]),
		TSetCVar(FP,CB_TX[2],SetTo,TargetXY[1]),
		TSetCVar(FP,CB_TY[2],SetTo,TargetXY[2]),
		TSetCVar(FP,CB_P[2],SetTo,ForPlayer),
		SetNext("X",Call_CreateBulletXY,0),SetNext(Call_CreateBulletXY+1,"X",1)
	})
	end
	
	Call_CreateBulletXY = SetCallForward()
	local Angle_T=CreateVar(FP)
	SetCall(FP)
	CIf(FP,Memory(0x628438,AtLeast,1))
		f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
		f_Atan2(FP, _iSub(CB_Y,CB_TY), _iSub(CB_X,CB_TX), Angle_T)
		CIf(FP,{CV(Angle_T,360,AtLeast)})
		CMod(FP, Angle_T, 360)
		CIfEnd()
		CMov(FP,Angle_V,_SHRead(FArr(DCtoSCFArr,Angle_T)),64)
		f_Mod(FP,Angle_V,_Mov(256))
		CDoActions(FP,{
			TSetMemoryB(0x656990, CB_UnitIDV, SetTo, Height_V),
			TSetMemory(0x58DC60 + 0x14*0,SetTo,CB_X),
			TSetMemory(0x58DC68 + 0x14*0,SetTo,CB_X),
			TSetMemory(0x58DC64 + 0x14*0,SetTo,CB_Y),
			TSetMemory(0x58DC6C + 0x14*0,SetTo,CB_Y),
			TCreateUnit(1, CB_UnitIDV, 1, CB_P)})
		CDoActions(FP,{
			TSetMemoryX(_Add(Nextptrs,0x58/4),SetTo,_ReadF(_Add(Nextptrs,(0x28/4))),0xFFFFFFFF),
			TSetMemoryX(_Add(Nextptrs,0x20/4),SetTo,_Mul(Angle_V,256),0xFF00),
			TSetMemoryX(_Add(Nextptrs,0x4C/4),SetTo,135*256,0xFF00),
			TSetMemoryX(_Add(Nextptrs,40),SetTo,0,0xFF000000),
			TSetMemoryX(_Add(Nextptrs,55),SetTo,0x200104,0x300104),
			TSetMemory(_Add(Nextptrs,57),SetTo,0),
			TSetMemoryX(_Add(Nextptrs,68),SetTo,12,0xFFFF)
		})
	CIfEnd()
	SetCallEnd()


end
function f_SaveCp()
	CallTrigger(FP,SaveCp_CallIndex,nil)
end
function f_LoadCp()
	CallTrigger(FP,LoadCp_CallIndex,nil)
end

function TestSet(val)
if val == 1 then 
	Limit = 1
	TestStart = 0
elseif val == 2 then
	Limit = 1
	TestStart = 1
else
	Limit = 0
	TestStart = 0
end
end
function Install_CText1(StrPtr,CText1,CText2,PlayerVArr)

	f_Memcpy(FP,StrPtr,_TMem(Arr(CText1[3],0),"X","X",1),CText1[2])
	f_Movcpy(FP,_Add(StrPtr,CText1[2]),VArr(PlayerVArr,0),4*6)
	f_Memcpy(FP,_Add(StrPtr,CText1[2]+(4*6)),_TMem(Arr(CText2[3],0),"X","X",1),CText2[2])

end


function CreateHeroPointArr(Index,Point,Name,Type) --  영작 유닛 설정 함수
	local TextType1 = "을(를) 처치하였다...! "
	local TextType2 = "를 획득하였다...! "
	local Name2
	if Type == 1 then
		Name2 = TextType1
	elseif Type == 2 then
		Name2 = TextType2
	
	elseif Type == nil then
		Name2 = nil
	else
		PushErrorMsg("Need_Input_TextType")
	end
	local Text = "\x13\x04"..Name..""..Name2.."\x1F+ "..Point.." \x1CPoint \x07Get!"
	local X = {}
	table.insert(X,Text)
	table.insert(X,Index)
	table.insert(X,Point) -- HPoint
	table.insert(HeroPointArr,X)
end
function InstallHeroPoint() -- CreateHeroPointArr에서 전송받은 영웅 포인트 정보 설치 함수. CunitCtrig 단락에 포함됨.
	for i = 1, #HeroPointArr do
		local CT = HeroPointArr[i][1]
		local index = HeroPointArr[i][2]
		local Point = HeroPointArr[i][3]
			CIf(FP,DeathsX(CurrentPlayer,Exactly,index,0,0xFF),SetScore(Force1,Add,Point,Kills))
			for i = 0, 6 do
				TriggerX(FP,{CDeaths(FP,Exactly,0,HeroPointNotice[i+1])},{
					SetMemory(0x6509B0,SetTo,i),
					DisplayText(CT,4);
					SetMemory(0x6509B0,SetTo,FP),
				},{preserved})
				TriggerX(FP,{CDeaths(FP,AtMost,2,SoundLimit[i+1]),CDeaths(FP,Exactly,0,HeroPointNotice[i+1])},{
					SetMemory(0x6509B0,SetTo,i),
					PlayWAV("staredit\\wav\\HeroKill.ogg"),PlayWAV("staredit\\wav\\HeroKill.ogg");
					SetMemory(0x6509B0,SetTo,FP),
					SetCDeaths(FP,Add,1,SoundLimit[i+1]),
				},{preserved})
			end
			CIfEnd()
			

			f_LoadCp()
	end
end

function Install_DeathNotice()
	CIf(FP,DeathsX(CurrentPlayer,Exactly,10,0,0xFF))
		DoActions(FP,MoveCp(Subtract,6*4))
		for j = 1, 7 do
			CIf(FP,DeathsX(CurrentPlayer,Exactly,j-1,0,0xFF))
				f_SaveCp()
				Install_CText1(HTextStrPtr,Str12,Str01,Names[j])
				DoActionsX(FP,{
					RotatePlayer({DisplayTextX(HTextStr,4)},HumanPlayers,FP);
					SetScore(j-1,Add,50,Custom);
					SetCVar(FP,ExScore[j][2],Add,-50);
				})
				for k = 0, 6 do
					TriggerX(FP,{CDeaths(FP,AtMost,4,SoundLimit[k+1])},{SetMemory(0x6509B0,SetTo,k),PlayWAV("staredit\\wav\\die_se.ogg"),SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,Add,1,SoundLimit[k+1])},{preserved})
				end
				f_Memcpy(FP,HTextStrPtr,_TMem(Arr(HTextStrReset[3],0),"X","X",1),HTextStrReset[2])
				f_LoadCp()
			CIfEnd()
		end
		DoActions(FP,MoveCp(Add,6*4))
	CIfEnd()

	for j = 1, 7 do
	CIf(FP,DeathsX(CurrentPlayer,Exactly,MarID[j],0,0xFF))
		DoActions(FP,MoveCp(Subtract,6*4))
			CIf(FP,DeathsX(CurrentPlayer,Exactly,j-1,0,0xFF))
				f_SaveCp()
				Install_CText1(HTextStrPtr,Str12,Str02,Names[j])
				DoActionsX(FP,{
					RotatePlayer({DisplayTextX(HTextStr,4)},HumanPlayers,FP);
					SetScore(j-1,Add,500,Custom);
					SetCVar(FP,ExScore[j][2],Add,-500);
				})
				for k = 0, 6 do
					TriggerX(FP,{CDeaths(FP,AtMost,4,SoundLimit[k+1])},{SetMemory(0x6509B0,SetTo,k),PlayWAV("staredit\\wav\\die_se.ogg"),SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,Add,1,SoundLimit[k+1])},{preserved})
				end
				f_Memcpy(FP,HTextStrPtr,_TMem(Arr(HTextStrReset[3],0),"X","X",1),HTextStrReset[2])
				f_LoadCp()
			CIfEnd()
		DoActions(FP,MoveCp(Add,6*4))
CIfEnd()
end
end

function f_GSend(UnitID,Actions)
CallTriggerX(FP,G_Send,{DeathsX(CurrentPlayer,Exactly,UnitID,0,0xFF)},Actions)
end
function BGMManager()
	AddBGM(1,"staredit\\wav\\GRAVITY_OP.ogg",94*1000,{1,5})
	AddBGM(1,"staredit\\wav\\ExceedOP.ogg",99000,{6,10})
	AddBGM(2,"staredit\\wav\\BGM1_1.ogg",42*1000,{1,2})
	AddBGM(3,"staredit\\wav\\BGM1_2.ogg",47*1000,{1,2})
	AddBGM(4,"staredit\\wav\\BGM1_3.ogg",60*1000,{1,2})
	AddBGM(5,"staredit\\wav\\BGM1_4.ogg",60*1000,{1,2})
	AddBGM(2,"staredit\\wav\\BGM2_1.ogg",43*1000,{3,4})
	AddBGM(3,"staredit\\wav\\BGM2_2.ogg",67*1000,{3,4})
	AddBGM(4,"staredit\\wav\\BGM2_3.ogg",58*1000,{3,4})
	AddBGM(5,"staredit\\wav\\BGM2_4.ogg",73*1000,{3,4})
	AddBGM(2,"staredit\\wav\\BGM3_1.ogg",46*1000,{5,6})
	AddBGM(3,"staredit\\wav\\BGM3_2.ogg",53*1000,{5,6})
	AddBGM(4,"staredit\\wav\\BGM3_3.ogg",50*1000,{5,6})
	AddBGM(5,"staredit\\wav\\BGM3_4.ogg",48*1000,{5,6})
	AddBGM(2,"staredit\\wav\\BGM4_1.ogg",47*1000,{7,8})
	AddBGM(3,"staredit\\wav\\BGM4_2.ogg",60300,{7,8})
	AddBGM(4,"staredit\\wav\\BGM4_3.ogg",49400,{7,8})
	AddBGM(5,"staredit\\wav\\BGM4_4.ogg",60500,{7,8})
	AddBGM(2,"staredit\\wav\\BGM5_1.ogg",49*1000,{9,10})
	AddBGM(3,"staredit\\wav\\BGM5_2.ogg",48*1000,{9,10})
	AddBGM(4,"staredit\\wav\\BGM5_3.ogg",73*1000,{9,10})
	AddBGM(5,"staredit\\wav\\BGM5_4.ogg",59*1000,{9,10})
	AddBGM(12,"staredit\\wav\\ExceedOP.ogg",99000)

	
	roka7BGM = AddBGM(8,"staredit\\wav\\roka7boss.ogg",197*1000)
	IdenBGM = AddBGM(9,"staredit\\wav\\JinjinZzara.ogg",220*1000)
	Akasha = AddBGM(10,"staredit\\wav\\Akasha.ogg",262*1000)
	DLBossBGM = AddBGM(11,"staredit\\wav\\Lanterns.ogg",231*1000)
	SBossBGM = AddBGM(13,"staredit\\wav\\SBoss.ogg",368*1000)
	
	CIf(FP,{CVar(FP,ReserveBGM[2],AtLeast,1),DeathsX(AllPlayers,AtMost,0,12,0xFFFFFF)})
		CMov(FP,BGMTypeV,ReserveBGM)
		CMov(FP,ReserveBGM,0)
		TriggerX(FP,{Bring(FP,AtLeast,1,87,64)},{SetCVar(FP,BGMTypeV[2],SetTo,roka7BGM),SetCVar(FP,ReserveBGM[2],SetTo,roka7BGM)},{preserved})
		TriggerX(FP,{Bring(FP,AtLeast,1,68,64)},{SetCVar(FP,BGMTypeV[2],SetTo,IdenBGM),SetCVar(FP,ReserveBGM[2],SetTo,IdenBGM)},{preserved})
		TriggerX(FP,{Bring(FP,AtLeast,1,15,64)},{SetCVar(FP,BGMTypeV[2],SetTo,Akasha),SetCVar(FP,ReserveBGM[2],SetTo,Akasha)},{preserved})
		TriggerX(FP,{Bring(FP,AtLeast,1,74,64)},{SetCVar(FP,BGMTypeV[2],SetTo,DLBossBGM),SetCVar(FP,ReserveBGM[2],SetTo,DLBossBGM)},{preserved})
	CIfEnd()
	Install_BGMSystem(FP,6,BGMTypeV,12,1)
end


function Install_RandPlaceHero()
	local RandW2 = CreateVar(FP)
	local HeroID = CreateVar(FP)
	local HPosX,HPosY = CreateVariables(2)
	CWhile(FP,CVar(FP,RandW[2],AtLeast,1),SetCVar(FP,RandW[2],Subtract,1))
		Check_Spawn = def_sIndex()
		NJumpXEnd(FP,Check_Spawn)
		f_Mod(FP,HPosX,_Rand(),_Mov(3072))
		f_Mod(FP,HPosY,_Rand(),_Mov(6144))
		NJumpX(FP,Check_Spawn,{CVar(FP,HPosX[2],AtLeast,320),CVar(FP,HPosX[2],AtMost,2752),CVar(FP,HPosY[2],AtLeast,4480)}) -- 좌표설정 실패, 다시
		Simple_SetLocX(FP,0,HPosX,HPosY,HPosX,HPosY,Simple_CalcLoc(0,-64,-64,64,64))
		Check_Cannot = def_sIndex()
		NJumpX(FP,Check_Cannot,{Memory(0x628438,Exactly,0)}) -- 캔낫. 강제캔슬
		CMov(FP,RandW2,1)
		CMov(FP,HeroID,VArr(HeroVArr,_Mod(_Rand(),_Mov(#HeroArr))))
		NWhile(FP,CVar(FP,RandW2[2],AtLeast,1),SetCVar(FP,RandW2[2],Subtract,1))
			NJumpX(FP,Check_Cannot,{Memory(0x628438,Exactly,0)}) -- 캔낫. 강제캔슬
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			CDoActions(FP,{TCreateUnitWithProperties(1,HeroID,1,P8,{energy = 100})})
			NIfX(FP,{TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)}) -- 소환 성공 여부 
				CMov(FP,CunitIndex,_Div(_Sub(Nextptrs,19025),_Mov(84)))
				--CTrigger(FP,{CVar(FP,Level[2],AtMost,10)},{TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(CC_Header,((0x20*8)/4))),SetTo,1)},1) -- 10레벨 이하는 영작포인트 적용됨
				CTrigger(FP,{},{Set_EXCC2(DUnitCalc, CunitIndex, 8, SetTo,1)},1) -- 
				
				local TempW = CreateWar(FP)
				f_LMovX(FP, TempW, WArr(MaxHPWArr,HeroID), SetTo, nil, nil, 1)
				CIf(FP,{TTCWar(FP, TempW[2], AtLeast, tostring(8320000*256))})
				local TempV1 = CreateVar(FP)
				local TempV2 = CreateVar(FP)
				f_LMov(FP, {TempV1,TempV2}, _LSub(TempW,tostring(8320000*256)), nil, nil, 1)
					CDoActions(FP, {
						Set_EXCC2(LHPCunit, CunitIndex, 0, SetTo,1),
						Set_EXCC2(LHPCunit, CunitIndex, 1, SetTo,TempV1),
						Set_EXCC2(LHPCunit, CunitIndex, 2, SetTo,TempV2),
						
				})
				CIfEnd()

				f_Mod(FP,BiteCalc,HeroID,_Mov(2),0xFF)
				f_Read(FP,_Add(_Div(HeroID,_Mov(2)),_Mov(EPD(0x663EB8))),UnitPoint)
				NIfX(FP,{CVar(FP,BiteCalc[2],AtLeast,1)})
				CDiv(FP,UnitPoint,65536)
				NElseX()
				CMod(FP,UnitPoint,65536)
				NIfXEnd()
				CAdd(FP,InputPoint,UnitPoint)
				NElseX()
				NJumpX(FP,Check_Spawn) -- 소환실패, 다시
			NIfXEnd()
		NWhileEnd()
		NJumpXEnd(FP,Check_Cannot)
	CWhileEnd()
end


function Print13_NumSet(Ptr,Ptr2,DivNum,Mask)
	for i = 3, 0, -1 do
		Trigger {
			players = {FP},
			conditions = {
				Memory(Ptr,AtLeast,(2^i)*DivNum);
			},
			actions = {
				SetMemoryX(Ptr2,SetTo,(2^i)*Mask,2^i*Mask);
				SetMemory(Ptr,Subtract,(2^i)*DivNum);
				PreserveTrigger();
			}
		}
	end
end


function ValToTimeX(VIndex,DestPtr,DivNum,DestPlace)
	for i = 6, 0, -1 do
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				CVar(FP,VIndex,AtLeast,(2^i)*DivNum)
			},
			actions = {
				SetMemory(DestPtr,Add,(2^i)*DestPlace);
				SetCVar(FP,VIndex,Subtract,(2^i)*DivNum);
				PreserveTrigger();
			}
		}
	end
end

function EPDToPtr(EPD)
	return 0x58A364+(EPD*4)
end

function KeyInput(Key,Conditions,Actions,PreserveFlag,CutFlag)
	local X = {}
	local Y = {}
	if CutFlag ~= 1 then 
		Y = {SetDeaths(KeyCP,SetTo,0,Key)}
	end
	if PreserveFlag == 1 then
		X = {preserved}
	end
	TriggerX(FP,{Deaths(KeyCP,AtLeast,1,Key),Conditions},{Y,Actions},X)
end

function Print_13_2(PlayerID,DisplayPlayer,String)
	local X = {}
	local Y = {}
	PlayerID = PlayerConvert(PlayerID)
	if type(DisplayPlayer) == "number" then
		temp = {DisplayPlayer}
		DisplayPlayer = temp
	end
	for k, P in pairs(DisplayPlayer) do
		table.insert(X,CreateUnit(1,0,"Anywhere",P))
	end
	if String ~= nil then
		table.insert(Y,print_utf8(12, 0, String))
	end
	CIf(PlayerID,Memory(0x628438,AtLeast,1))
		f_ReadX(PlayerID,0x628438,V(FuncAlloc),1,0xFFFFFF)
		DoActionsX(PlayerID,{SetMemory(0x628438,SetTo,0),X,Y})
		CVariable2(PlayerID,FuncAlloc,0x628438,SetTo,0)
	CIfEnd()
	FuncAlloc = FuncAlloc + 1
end
function Print13_Preserve()
	local Print13 = CreateCcode()
		CIf(FP,CDeaths(FP,Exactly,0,Print13),SetCDeaths(FP,Add,88,Print13))
			for i = 0, 6 do
				CallTriggerX(FP,Call_Print13[i+1],{HumanCheck(i,1),Deaths(i,AtMost,0,15)})
			end
		CIfEnd()
		for i = 0, 6 do
			CIf(FP,{HumanCheck(i,1),Deaths(i,AtMost,0,202)})
			for j = 0, 12 do
			CallTriggerX(FP,Call_Print13[i+1],{Switch("Switch 240",Set);Deaths(i,AtLeast,1,100+j)})
			end
			CallTriggerX(FP,Call_Print13[i+1],{Switch("Switch 240",Set);Deaths(i,AtLeast,1,114)})
--			CallTriggerX(FP,Call_Print13[i+1],{Switch("Switch 240",Set);Deaths(i,AtLeast,1,150)})
			
			for j = 0, 6 do
				CallTriggerX(FP,Call_Print13[i+1],{CDeaths(FP,AtLeast,1,GivePChange[i+1]),Switch("Switch 240",Set);Deaths(i,AtLeast,1,212+j)})
			end
			CallTriggerX(FP,Call_Print13[i+1],{CDeaths(FP,AtMost,0,GivePChange[i+1]),Switch("Switch 240",Set);Deaths(i,AtLeast,1,219)})
			
			CIfEnd()
		end
		
		DoActionsX(FP,SetCDeaths(FP,Subtract,1,Print13))
end


function IBGM_EPDX(Player,MaxPlayer,MSQC_Recives,Option_NT)
	local Dx,Dy,Dv,Du,DtP = CreateVariables(5)
	
	f_Read(Player,0x51CE8C,Dx)
	CiSub(Player,Dy,_Mov(0xFFFFFFFF),Dx)
	CiSub(Player,DtP,Dy,Du)
	CMov(Player,Dv,DtP) 
	CMov(Player,0x58F500,DtP) -- MSQC val Send. 180
	CMov(Player,Du,Dy)
	

	if Option_NT ~= nil then
		if type(Option_NT) == "table" then
		CIf(FP,{NTCond2()})
			CMov(FP,Option_NT[1],MSQC_Recives)
		CIfEnd()
		CIf(FP,{NTCond()})
			CAdd(FP,Option_NT[2],MSQC_Recives,Option_NT[1])
		CIfEnd()
		else
			PushErrorMsg("OPtion_NT_InputData_Error")
		end
	end


	for i = 0, MaxPlayer do
		CTrigger(Player,{HumanCheck(i,1)},{TSetDeathsX(i,Subtract,MSQC_Recives,12,0xFFFFFF)},1) -- 브금타이머
	end
	CDoActions(Player,{TSetDeathsX(Player,Subtract,MSQC_Recives,12,0xFFFFFF),SetDeathsX(Player,SetTo,0,12,0xFF000000),SetDeaths(8,SetTo,0,12),SetDeaths(9,SetTo,0,12),SetDeaths(10,SetTo,0,12),SetDeaths(11,SetTo,0,12)}) -- 브금타이머
end

function ObDisplay()
	local TempT = CreateVar(FP)
	CMov(FP,0x582144+(4*7),0)
	CMov(FP,0x5821A4+(4*7),0)
	CMov(FP,0x582174+(4*7),count)
	CAdd(FP,0x582174+(4*7),count)
	CMov(FP,0x57F120+(4*7),Level)
	CMov(FP,TempT,Time)
	
	CMov(FP,0x57F0F0+(4*7),0)
	ValToTimeX(TempT[2],0x57F0F0+(4*7),3600000,10000)
	ValToTimeX(TempT[2],0x57F0F0+(4*7),60000,100)
	ValToTimeX(TempT[2],0x57F0F0+(4*7),1000,1)
end

function DoHumanCheck()
	
	DoActionsX(FP,{SetCDeaths(FP,SetTo,0,PCheck),SetCVar(FP,PCheckV[2],SetTo,0)})
	for i = 0, 6 do
		TriggerX(FP,{HumanCheck(i,1)},{SetCDeaths(FP,Add,1,PCheck),SetCVar(FP,PCheckV[2],Add,1)},{preserved})
	end
	TriggerX(FP,{CVar(FP,PCheckV[2],Exactly,1),CV(LevelT,1)},{SetCD(SoloNoPointC,1)})
	
end

function UnitLimit(Player,UID,Limit,Text,ReturnResources)
	Trigger {
		players = {Player},
		conditions = {
			Bring(Player,AtLeast,Limit+1,UID,64);
			},
		
		actions = {
			KillUnitAt(1,UID,"Anywhere",Player);
			DisplayText("\x07『 \x04"..Text.." "..Limit.."기를 넘어서 소지할 수 없습니다. \x1C자원 반환 \x1F+ "..ReturnResources.." Ore\x07 』",4);
			SetResources(Player,Add,ReturnResources,Ore);
			PreserveTrigger();
		},
	}
end


function GunBreak(GName,Point,Flag)
	local Text = "\n\n\n\x13- \x0E- \x0F-\x11 Ｓｔｒｕｃｔｕｒｅ \x04－ "..GName.." \x04 파괴!! \x1F+ "..Point.." P t s \x11- \x0E- \x0F-\n"
	if Flag == 1 then
		DoActions(FP,{
			RotatePlayer({DisplayTextX(Text,4)},HumanPlayers,FP);
			SetScore(Force1,Add,Point,Kills);
	
		})
	else
		DoActions(FP,{
			RotatePlayer({DisplayTextX(Text,4),PlayWAVX("staredit\\wav\\SpeedMessage.wav")},HumanPlayers,FP);
			SetScore(Force1,Add,Point,Kills);
	
		})
	end
end
function Gun_DoSuspend()
	return Gun_SetLine(54,SetTo,1)
end


function f_CRandNum(Max,Operand,Condition)
	if Operand == nil then Operand = 0 end
	local RandRet = TempRandRet
	CallTriggerX(FP,Call_CRandNum,Condition,{SetCVar(FP,InputMaxRand[2],SetTo,Max),SetCVar(FP,Oprnd[2],SetTo,Operand)})
	return RandRet
end

function Gun_SetLine(Line,Type,Value,Mask)
	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	return SetCVar(FP,Var_TempTable[Line+1][2],Type,Value,Mask)
end



function Gun_SetLineX(Line,Type,Value,Mask)
	return TSetCVar(FP,Var_TempTable[Line+1][2],Type,Value,Mask)
end

function Gun_Line(Line,Type,Value,Mask)
	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	return CVar(FP,Var_TempTable[Line+1][2],Type,Value,Mask)
end

function LvT(Type,Value)
	return CVar(FP,LevelT[2],Type,Value)
end
function NormalTurboSet(Player,DeathUnitID)
	local NTUID = DeathUnitID
	DoActions(Player,SetDeaths(Player,Add,1,DeathUnitID))
	Trigger2(Player,{Deaths(Player,AtLeast,2,DeathUnitID)},{SetDeaths(Player,SetTo,0,DeathUnitID)},{preserved})
	
	function NTCond()
		return Deaths(Player,Exactly,1,NTUID)
	end
	function NTCond2()
		return Deaths(Player,Exactly,0,NTUID)
	end
end


function CArrSizeConvert(Size)
	local TNum = Size/602
	if Size%602 ~= 0 then
		TNum = TNum + 1
	end
	return TNum
end


function SetCVar(Player,Index,Type,Value,Mask)
	if type(Index) == "table" and Index[4] == "V" then
		Index = Index[2]
	end
	return SetVariableX(Player,Index,"Value",Type,Value,Mask)
end

function CVar(Player,Index,Type,Value,Mask)
	if type(Index) == "table" and Index[4] == "V" then
		Index = Index[2]
	end
	return VariableX(Player,Index,"Value",Type,Value,Mask)
end


	

function CunitCtrig_Part4_EX(LoopIndex,Conditions,Actions,ExCunitArr)
	MoveCpValue = 0
	local X = {}
	for k, v in pairs(ExCunitArr) do
		table.insert(X,SetCVar("X",v[2],SetTo,0))
	end
	Trigger { -- Cunit Calc Main
		players = {PlayerID},
		conditions = { 
			Label(0);
			Conditions,
		},
		actions = {
			X,
			SetCtrigX("X","X",0x4,0,SetTo,"X",CCArr[CCptr],0,0,0);
			SetCtrigX("X",CCArr[CCptr]+1,0x4,0,SetTo,"X","X",0,0,1);
			SetCtrigX("X",CCArr[CCptr],0x158,0,SetTo,"X","X",0x4,1,0);
			SetCtrigX("X",CCArr[CCptr],0x15C,0,SetTo,"X","X",0,0,1);
			SetMemory(0x6509B0,SetTo,19025 + 84 * LoopIndex);
			Actions,
			},
		flag = {preserved}
	}		
end


	--0x590004~0x591FE4 PEUD Area UnitID : 494~664
StartPEUDValue = 494
function CreatePEUD()
	if StartPEUDValue >= 665 then PushErrorMsg("PEUD Has OverFlowed") end
	local Ret = StartPEUDValue
	StartPEUDValue = StartPEUDValue+1
	return Ret
end



function Include_G_CB_Library(StartIndex,G_CB_ArrSize,G_CB_Lines,DefCenterXYV,TRefeatXYV,ShapeTable,LoopMaxTable)
	if FP == nil then PushErrorMsg("Need_Define_Fixed_Player ( ex : FP = P8 )") end
local f_RepeatTypeErr = "\x07『 \x08ERROR : \x04잘못된 RepeatType이 입력되었습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
local f_GunSendErrT = "\x07『 \x08ERROR \x04: G_CB_SpawnSet 목록이 가득 차 데이터를 입력하지 못했습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
local f_GunErrT = "\x07『 \x08ERROR \x04: G_CBPlot Not Found. \x07』"
local f_GunErrT2 = "\x07『 \x08ERROR \x04: G_CBPlot Suspend Error. \x07』"
local f_GunFuncT = "\x07『 \x03TESTMODE OP \x04: G_CBPlot Suspended. \x07』"
local f_GunFuncT2 = "\x07『 \x03TESTMODE OP \x04: G_CBPlot Sended. \x07』"
local Repeat_UnitIDV = CreateVar(FP)
local RepeatType = CreateVar(FP)
local Spawn_TempW = CreateVar(FP)
local CreatePlayer = CreateVar(FP)
local G_CB_LineV = CreateVar(FP)
local G_CB_CUTV = CreateVar(FP)
local G_CB_SNTV = CreateVarArr(4,FP)
local G_CB_DLTV = CreateVar(FP)
local G_CB_LMTV = CreateVar(FP)
local G_CB_RPTV = CreateVar(FP)
local G_CB_Owner = CreateVar(FP)
local G_CB_EffType = CreateVar(FP)
local G_CB_XPos = CreateVar(FP)
local G_CB_YPos = CreateVar(FP)
local G_CB_FNTV = CreateVar(FP)
local G_CB_PFTV = CreateVar(FP)

local TRepeatX = TRefeatXYV[1]
local TRepeatY = TRefeatXYV[2]
local G_CB_CenterX = DefCenterXYV[1]
local G_CB_CenterY = DefCenterXYV[2]

local Write_SpawnSet_Jump = def_sIndex()
local G_CB_Arr_IndexAlloc = StartIndex
local G_CB_TempTable = CreateVarArr(G_CB_Lines,FP)
local G_CB_InputH = CreateVar(FP)
local G_CB_InputCVar = {}
for i = 1, G_CB_Lines do
	table.insert(G_CB_InputCVar,SetCVar(FP,G_CB_TempTable[i][2],SetTo,0))
end
table.insert(CtrigInitArr[FP+1],SetCtrigX(FP,G_CB_InputH[2],0x15C,0,SetTo,FP,StartIndex,0x15C,1,0))
local G_CB_TempH = CreateVar(FP)
local G_CB_Num = CreateVar(FP)
local G_CB_LineTemp = CreateVar(FP)
local CB_Repeat_Check = CreateCcode()
local Repeat_X = CreateVar(FP)
local Repeat_Y = CreateVar(FP)
local G_CB_WSTestStrPtr = CreateVar(FP)
local G_CB_WSTestVA = CreateVArr(5,FP)
local TempAngle = CreateVar(FP)




local Call_Repeat = SetCallForward()
SetCall(FP)
--RandZ = 227
--CIfX(FP,CVar(FP,Repeat_UnitIDV[2],Exactly,RandZ,0xFF))
--local RetRand = f_CRandNum(#ZergGndUArr,0)
--CMovX(FP,Repeat_UnitIDV,VArr(ZergGndVArr,RetRand),nil,0xFF)
--CIfXEnd()
CWhile(FP,{CVar(FP,Spawn_TempW[2],AtLeast,1)})








local QueueX = CreateVar(FP)
local QueueY = CreateVar(FP)

local LocV = CreateVarArr(4, FP)


	CIfX(FP,{CV(RepeatType,100)})--탄막유닛 전용 RepeatType
	CreateBullet(Repeat_UnitIDV, 20, TempAngle, Repeat_X, Repeat_Y, FP)
	CElseX()
		local RepeatProperties = CreateVar(FP)
		
		f_Read(FP,0x58DC60,LocV[1],"X",0xFFFFFFFF,1)
		f_Read(FP,0x58DC68,LocV[2],"X",0xFFFFFFFF,1)
		f_Read(FP,0x58DC64,LocV[3],"X",0xFFFFFFFF,1)
		f_Read(FP,0x58DC6C,LocV[4],"X",0xFFFFFFFF,1)

		CMov(FP,QueueX,_iDiv(_Add(LocV[1],LocV[2]),2))
		CMov(FP,QueueY,_iDiv(_Add(LocV[3],LocV[4]),2))



	TriggerX(FP,{CD(CB_Repeat_Check,0)},{SetVX(RepeatProperties, 0, 1)},{preserved})
	TriggerX(FP,{CD(CB_Repeat_Check,1)},{SetVX(RepeatProperties, 1, 1)},{preserved})
	CDoActions(FP,{
		TSetMemory(_Add(CreateUnitQueueXPosArr,CreateUnitQueuePtr),SetTo,QueueX),
		TSetMemory(_Add(CreateUnitQueueYPosArr,CreateUnitQueuePtr),SetTo,QueueY),
		TSetMemory(_Add(CreateUnitQueueUIDArr,CreateUnitQueuePtr),SetTo,_Mov(Repeat_UnitIDV,0xFF)),
		TSetMemory(_Add(CreateUnitQueuePIDArr,CreateUnitQueuePtr),SetTo,CreatePlayer),
		TSetMemory(_Add(CreateUnitQueueTypeArr,CreateUnitQueuePtr),SetTo,RepeatType),
		TSetMemory(_Add(CreateUnitQueuePropertiesArr,CreateUnitQueuePtr),SetTo,RepeatProperties),
	})
	DoActionsX(FP,{AddV(CreateUnitQueueNum,1),AddV(CreateUnitQueuePtr,1)})
	TriggerX(FP, {CV(CreateUnitQueuePtr,100000,AtLeast)},{SetV(CreateUnitQueuePtr,0),},{preserved})

	CIfXEnd()
	CSub(FP,Spawn_TempW,1)
CWhileEnd()
CMov(FP,RepeatType,0)
SetCallEnd()


function f_TempRepeat(UnitID,Number,Condition,Type,Owner,CenterXY)
	if Owner == nil then Owner = 0xFFFFFFFF end
	if Type == nil then Type = 0 end
	local SetX = 0 
	local SetY = 0
	if CenterXY == nil then 
		SetX = 0xFFFFFFFF
		SetY = 0xFFFFFFFF
	elseif type(CenterXY) == "table" then
		SetX = CenterXY[1]
		SetY = CenterXY[2]
	else
		PushErrorMsg("TRepeat_CenterXY_Error")
	end
	

	CallTriggerX(FP,Call_Repeat,Condition,{
		SetCDeaths(FP,SetTo,0,CB_Repeat_Check),
		SetCVar(FP,Repeat_UnitIDV[2],SetTo,UnitID),
		SetCVar(FP,Spawn_TempW[2],SetTo,Number),
		SetCVar(FP,RepeatType[2],SetTo,Type),
		SetCVar(FP,CreatePlayer[2],SetTo,Owner),
		SetCVar(FP,TRepeatX[2],SetTo,SetX),
		SetCVar(FP,TRepeatY[2],SetTo,SetY),
	})
end

function f_TempRepeatX(UnitID,Number,Condition,Type,Owner,CenterXY)
	if Owner == nil then Owner = 0xFFFFFFFF end
	if Type == nil then Type = 0 end
	local SetX = 0 
	local SetY = 0
	if CenterXY == nil then 
		SetX = 0xFFFFFFFF
		SetY = 0xFFFFFFFF
	elseif type(CenterXY) == "table" then
		SetX = CenterXY[1]
		SetY = CenterXY[2]
	else
		PushErrorMsg("TRepeat_CenterXY_Error")
	end
	CDoActions(FP,{
		TSetCVar(FP,Repeat_UnitIDV[2],SetTo,UnitID),
		TSetCVar(FP,Spawn_TempW[2],SetTo,Number),
		TSetCVar(FP,TRepeatX[2],SetTo,SetX),
		TSetCVar(FP,TRepeatY[2],SetTo,SetY),
		SetCVar(FP,RepeatType[2],SetTo,Type),
		SetCDeaths(FP,SetTo,0,CB_Repeat_Check),
		SetCVar(FP,CreatePlayer[2],SetTo,Owner)})
	CallTriggerX(FP,Call_Repeat,Condition)
end





Write_SpawnSet = SetCallForward()
SetCall(FP)


-- Line0 = UnitIDTable 0xFF
-- Line1 = RepeatTypeTable 0xFF
-- Line2 = G_CB_FNTableTable 0xFF
-- Line3 = ShapeNumberTable1
-- Line4 = ShapeNumberTable2
-- Line5 = ShapeNumberTable3
-- Line6 = ShapeNumberTable4
-- Line7 = XPos
-- Line8 = YPos
-- Line9 = CA[5],0xFF 루프 리미트 (트리거 순환당 소환할 유닛 수 / k입력시 CA[4] : 0~k-1까지 루프함) 
-- Line10 = CA[2] 남은 대기 시간 (Tick 단위 / 0일때 유닛 소환) 
-- Line11 = CA[3] 소환후 대기시간 증가량 (Tick 단위/ k입력시 1회 루프후 대기시간 k추가()
-- Line12 = CA[6] 데이터 인덱스 (k입력시 Shape[k+1]의 데이터를 출력함


CMov(FP,G_CB_LineV,0)
CJumpEnd(FP,Write_SpawnSet_Jump)

CAdd(FP,G_CB_LineTemp,G_CB_LineV,G_CB_InputH)
NIfX(FP,{TMemory(G_CB_LineTemp,AtMost,0)})

_0D = string.rep("\x0D",200)
if Limit == 1 then
	TriggerX(FP,{CD(TestMode,1)},{RotatePlayer({DisplayTextX(f_GunFuncT2,4)},HumanPlayers,FP)},{preserved})
		CIf(FP,CD(TestMode,1))
--		TriggerX(FP,{},{RotatePlayer({DisplayTextX(f_GunFuncT2,4)},HumanPlayers,FP)},{preserved})
--		ItoDec(FP,G_CB_CUTV,VArr(G_CB_WSTestVA,0),0,nil,0)
--		f_Movcpy(FP,G_CB_WSTestStrPtr,VArr(G_CB_WSTestVA,0),4*4)
--		TriggerX(FP,{},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CB_WS".._0D,4)},HumanPlayers,FP)},{preserved})
--		ItoDec(FP,G_CB_RPTV,VArr(G_CB_WSTestVA,0),0,nil,0)
--		f_Movcpy(FP,G_CB_WSTestStrPtr,VArr(G_CB_WSTestVA,0),4*4)
--		TriggerX(FP,{},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CB_WS".._0D,4)},HumanPlayers,FP)},{preserved})
--		ItoDec(FP,G_CB_FNTV,VArr(G_CB_WSTestVA,0),0,nil,0)
--		f_Movcpy(FP,G_CB_WSTestStrPtr,VArr(G_CB_WSTestVA,0),4*4)
--		TriggerX(FP,{},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CB_WS".._0D,4)},HumanPlayers,FP)},{preserved})
--		ItoDec(FP,G_CB_SNTV[1],VArr(G_CB_WSTestVA,0),0,nil,0)
--		f_Movcpy(FP,G_CB_WSTestStrPtr,VArr(G_CB_WSTestVA,0),4*4)
--		TriggerX(FP,{},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CB_WS".._0D,4)},HumanPlayers,FP)},{preserved})
--		ItoDec(FP,G_CB_LMTV,VArr(G_CB_WSTestVA,0),0,nil,0)
--		f_Movcpy(FP,G_CB_WSTestStrPtr,VArr(G_CB_WSTestVA,0),4*4)
--		TriggerX(FP,{},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CB_WS".._0D,4)},HumanPlayers,FP)},{preserved})
		CIfEnd()
	
	end
CDoActions(FP,{
	TSetMemory(_Add(G_CB_LineTemp,0*(0x20/4)),SetTo,G_CB_CUTV),
	TSetMemory(_Add(G_CB_LineTemp,1*(0x20/4)),SetTo,G_CB_RPTV),
	TSetMemory(_Add(G_CB_LineTemp,2*(0x20/4)),SetTo,G_CB_FNTV),
	TSetMemory(_Add(G_CB_LineTemp,3*(0x20/4)),SetTo,G_CB_SNTV[1]),
	TSetMemory(_Add(G_CB_LineTemp,4*(0x20/4)),SetTo,G_CB_SNTV[2]),
	TSetMemory(_Add(G_CB_LineTemp,5*(0x20/4)),SetTo,G_CB_SNTV[3]),
	TSetMemory(_Add(G_CB_LineTemp,6*(0x20/4)),SetTo,G_CB_SNTV[4]),
	TSetMemory(_Add(G_CB_LineTemp,9*(0x20/4)),SetTo,G_CB_LMTV),
	TSetMemory(_Add(G_CB_LineTemp,10*(0x20/4)),SetTo,0),
	TSetMemory(_Add(G_CB_LineTemp,11*(0x20/4)),SetTo,G_CB_DLTV),
	TSetMemory(_Add(G_CB_LineTemp,12*(0x20/4)),SetTo,0),
	TSetMemory(_Add(G_CB_LineTemp,13*(0x20/4)),SetTo,G_CB_PFTV),
	
	
})
CIfX(FP,{CVar(FP,G_CB_XPos[2],Exactly,0xFFFFFFFF),CVar(FP,G_CB_YPos[2],Exactly,0xFFFFFFFF)})
CDoActions(FP,{
	TSetMemory(_Add(G_CB_LineTemp,7*(0x20/4)),SetTo,G_CB_CenterX),
	TSetMemory(_Add(G_CB_LineTemp,8*(0x20/4)),SetTo,G_CB_CenterY)
})
CElseX()
CDoActions(FP,{
	TSetMemory(_Add(G_CB_LineTemp,7*(0x20/4)),SetTo,G_CB_XPos),
	TSetMemory(_Add(G_CB_LineTemp,8*(0x20/4)),SetTo,G_CB_YPos)
})
CIfXEnd()
NElseIfX({CVar(FP,G_CB_LineV[2],AtMost,((0x970/4)*G_CB_ArrSize-2))})
CAdd(FP,G_CB_LineV,0x970/4)
CJump(FP,Write_SpawnSet_Jump)
NElseX()

DoActions(FP,{RotatePlayer({DisplayTextX(f_GunSendErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})

NIfXEnd()
SetCallEnd()










local G_CB_Suspend = CreateCcode()


local G_CB_Launch = CreateCcode()
function G_CB_Func()
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local TempFunc = CreateVar(FP)
	
	CMov(FP,TempFunc,G_CB_TempTable[3],nil,0xFF,1)



	CIf(FP,CVar(FP,G_CB_TempTable[10][2],AtMost,0,0xFF))
		local TempLM = CreateVar(FP)
		f_Div(FP,TempLM,V(CA[10]),50)
		CMov(FP,G_CB_TempTable[10],TempLM,1,0xFF)
	CIfEnd()

	CAdd(FP,Repeat_X,V(CA[8]),G_CB_TempTable[8])
	CAdd(FP,Repeat_Y,V(CA[9]),G_CB_TempTable[9])
	CMov(FP,0x58DC60,Repeat_X)
	CMov(FP,0x58DC64,Repeat_Y)
	CMov(FP,0x58DC68,Repeat_X)
	CMov(FP,0x58DC6C,Repeat_Y)
	CMov(FP,Repeat_UnitIDV,G_CB_TempTable[1],nil,0xFF,1)
	CMov(FP,RepeatType,G_CB_TempTable[2],nil,0xFF,1)
	CMov(FP,Spawn_TempW,1)
	CMov(FP,TempAngle,G_CB_TempTable[15],nil,0xFF,1)

	CallTrigger(FP,Call_Repeat,{SetCDeaths(FP,SetTo,1,CB_Repeat_Check)})
	
end
G_CB_ShapeTable = {}


-- Line0 = UnitIDTable 0xFF
-- Line1 = RepeatTypeTable 0xFF
-- Line2 = G_CB_FNTable 0xFF
-- Line3 = ShapeNumberTable1
-- Line4 = ShapeNumberTable2
-- Line5 = ShapeNumberTable3
-- Line6 = ShapeNumberTable4
-- Line7 = XPos
-- Line8 = YPos
-- Line9 = CA[5],0xFF 루프 리미트 (트리거 순환당 소환할 유닛 수 / k입력시 CA[4] : 0~k-1까지 루프함) 
-- Line10 = CA[2] 남은 대기 시간 (Tick 단위 / 0일때 유닛 소환) 
-- Line11 = CA[3] 소환후 대기시간 증가량 (Tick 단위/ k입력시 1회 루프후 대기시간 k추가()
-- Line12 = CA[6] 데이터 인덱스 (k입력시 Shape[k+1]의 데이터를 출력함


	if type(ShapeTable) ~= "table" then
		PushErrorMsg("ShapeData_Input_Error")
	end
	local Y = {}
	local X = {}
	for j, k in pairs(ShapeTable) do
		if type(k) ~= "string" then
			PushErrorMsg("ShapeData_Input_Error")
		end
		Y[j] = _G[k]
		G_CB_ShapeTable[j] = k
		if LoopMaxTable[j] ~= nil then
			X[j] = LoopMaxTable[j]
		else
			X[j] = CS_TMakeAuto(_G[k])
		end
	end
	local STSize = #ShapeTable
	table.insert(Y,CS_InputVoid(1699))
	table.insert(Y,CS_InputVoid(1699))
	table.insert(Y,CS_InputVoid(1699))
	for i = 1, G_CB_ArrSize do
		table.insert(Y,CS_InputVoid(1699))
	end

	function CBRandSort()
		local Ret = f_CRandNum(11)
		CIf(FP,CV(Ret,0))
		CIfEnd()
	end

	local EndRetShape = STSize+3 -- 최종 연산 ShapeNum


	
	local Sh_X, Sh_Y, CFRet = CreateVars(4,FP)
	local DR = CreateVar(FP)
	local NG = CreateVar(FP)


	CFunc1 = InitCFunc(FP)
	Para = CFunc(CFunc1)
	-- n*X + (10-n)*Y - 100 = k
	CiSub(FP,CFRet,_Add(_iMul(Para[1],Sh_X),_iMul(Para[2],Sh_Y)),100)
	CIf(FP,{CV(NG,1),CV(CFRet,0x80000000,AtLeast)})
	CNeg(FP,CFRet)
	CIfEnd()
	CFuncReturn({CFRet})
	CFuncEnd()



	function CB_RandSort()
		
		CMov(FP,Sh_X,_Mod(_Rand(),200),-100)
		CMov(FP,Sh_Y,_Mod(_Rand(),200),-100)
		DoActions(FP,SetSwitch("Switch 1",Random))
		TriggerX(FP,Switch("Switch 1",Cleared),{SetV(DR,1)},{preserved})
		TriggerX(FP,Switch("Switch 1",Set),{SetV(DR,0)},{preserved})
		DoActions(FP,SetSwitch("Switch 1",Random))
		TriggerX(FP,Switch("Switch 1",Cleared),{SetV(NG,1)},{preserved})
		TriggerX(FP,Switch("Switch 1",Set),{SetV(NG,0)},{preserved})
		CB_Sort(CFunc1,DR,STSize+1,STSize+3)

	end


	G_CB_PrefuncArr = {
		{1,"CB_RandSort"}
	} --{index,funcname}





	function G_CB_Prefunc()
		local CA = CAPlotDataArr
		local CB = CAPlotCreateArr
		local TempFunc = CreateVar(FP)
		local TempFunc2 = CreateVar(FP)

		CB_PrfcInit = def_sIndex()
		CJump(FP,CB_PrfcInit)
			CB_initTCopy()
		CJumpEnd(FP,CB_PrfcInit)
		



		
		CMov(FP,TempFunc,G_CB_TempTable[14],nil,0xFF,1)
		CMov(FP,TempFunc2,G_CB_TempTable[3],nil,0xFF,1)
		
		CIfX(FP,{TTOR({CV(TempFunc,1,AtLeast),TTAND({CV(TempFunc2,1,AtLeast),CV(TempFunc2,8,AtMost)})})})
		--ItoDec(FP,TempFunc2,VArr(G_CB_WSTestVA,0),0,nil,0)
		--f_Movcpy(FP,G_CB_WSTestStrPtr,VArr(G_CB_WSTestVA,0),4*4)
		--TriggerX(FP,{},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CB_WS".._0D,4)},HumanPlayers,FP)},{preserved})
		--CIfX(FP,{Never()})
		CB_TCopy(V(CA[1]),STSize+1)

		CIf(FP,{CV(TempFunc2,1,AtLeast),CV(TempFunc2,8,AtMost)})
		local CurShNum = CreateVar(FP)
			CB_GetNumber(STSize+1, CurShNum)
			INumJump = def_sIndex()
			for j = 3, 8 do
				for i = 1, 8 do
				NJumpX(FP,INumJump,{CV(CurShNum,_G["P_"..j][1]),CV(TempFunc2,i)},{SetV(CurShNum,PlotSizeCalc(j,i))})
				end
				for i = 1, 4 do
				NJumpX(FP,INumJump,{CV(CurShNum,_G["S_"..j][1]),CV(TempFunc2,i)},{SetV(CurShNum,PlotSizeCalc(j*2,i))})
				end
			end
			NJumpEnd(FP, INumJump)
			CB_SetNumber(CurShNum, STSize+1)
			local CurShDL = CreateVar(FP)
			CDiv(FP,CurShDL,_Mov(50),CurShNum)
			
			CMov(FP,V(CA[3]),CurShDL)
			CMov(FP,G_CB_TempTable[12],CurShDL)
	
			for i = 1, 8 do
				CIf(FP,CV(TempFunc2,i))
					CB_Ratio(5000-(350*i), 1000, 5000-(350*i), 1000, STSize+1, STSize+2)
				CIfEnd()
			end
			CMov(FP,Sh_X,_Mod(_Rand(),200),-100)
			CMov(FP,Sh_Y,_Mod(_Rand(),200),-100)
			DoActions(FP,SetSwitch("Switch 1",Random))
			TriggerX(FP,Switch("Switch 1",Cleared),{SetV(DR,1)},{preserved})
			TriggerX(FP,Switch("Switch 1",Set),{SetV(DR,0)},{preserved})
			DoActions(FP,SetSwitch("Switch 1",Random))
			TriggerX(FP,Switch("Switch 1",Cleared),{SetV(NG,1)},{preserved})
			TriggerX(FP,Switch("Switch 1",Set),{SetV(NG,0)},{preserved})
			CB_Sort(CFunc1,DR,STSize+2,STSize+3)
		CIfEnd()

		for j, k in pairs(G_CB_PrefuncArr) do
			CIf(FP,CV(TempFunc,k[1]))
				_G[k[2]]()
			CIfEnd()
		end
		local TempRetShape = CreateVar(FP)
		CMov(FP,TempRetShape,G_CB_Num,EndRetShape)
		CB_TCopy(EndRetShape,TempRetShape)
		CMov(FP,V(CA[1]),G_CB_Num,EndRetShape)
		CMov(FP,G_CB_TempTable[4],G_CB_Num,EndRetShape)


		CMov(FP,G_CB_TempTable[14],0,nil,0xFF)
		CMov(FP,G_CB_TempTable[3],0,nil,0xFF)
		
		CIfXEnd()
	end


	Load_CBPlot = SetCallForward()
	local CA = CAPlotForward()
	SetCall(FP)
	DoActionsX(FP,{SetCDeaths(FP,SetTo,1,G_CB_Launch)})
	CMov(FP,V(CA[1]),G_CB_TempTable[4])
	CMov(FP,V(CA[2]),G_CB_TempTable[11])
	CMov(FP,V(CA[3]),G_CB_TempTable[12])
	CMov(FP,V(CA[6]),G_CB_TempTable[13])
	CMov(FP,V(CA[5]),G_CB_TempTable[10],nil,0xFF,1)
	TriggerX(FP, {CVar(FP,G_CB_TempTable[10][2],AtMost,0,0xFF)}, {SetV(V(CA[5]),1)}, {preserved})


	CBPlot(Y,nil,FP,nilunit,0,{G_CB_TempTable[8],G_CB_TempTable[9]},1,32,{0,0,0,0,0,1},"G_CB_Func","G_CB_Prefunc",FP,nil,nil,{SetCDeaths(FP,Add,1,G_CB_Suspend)}) 
	CDoActions(FP,{TSetCVar(FP,G_CB_TempTable[13][2],SetTo,V(CA[6])),TSetCVar(FP,G_CB_TempTable[11][2],SetTo,V(CA[2]))})
	--CMov(FP,0x57f0f0,V(CA[6]))
	--CMov(FP,0x57f120,V(CA[10]))
	DoActions(FP,{DisplayText("asdafsa",1)})
	SetCallEnd()


function T_to_BiteBuffer(Table)
	local BiteValue = 0
	if type(Table) == "table" then
		local ret = 0
		if #Table >= 5 then
			PushErrorMsg("BiteStack_is_Over_5")
		end
		for i, j in pairs(Table) do
			BiteValue = BiteValue + j*(256^ret)
			ret = ret + 1
		end
		Table = BiteValue
	end
	return BiteValue
end



function G_CB_SetSpawn(Condition,G_CB_CUTable,G_CB_SNTable,G_CB_LMTable,G_CB_RPTable,G_CB_FNTable,Delay,CenterXY,Owner,G_CB_PFTable,PreserveFlag)
	if type(G_CB_CUTable) ~= "table" then
		PushErrorMsg("G_CB_SetSpawn_Inputdata_Error")
	end
	local X = {}
	if type(G_CB_SNTable) == "table" then
		if #G_CB_SNTable >= 5 then
			PushErrorMsg("BiteStack_is_Over_5")
		end
		for i = 1, 4 do
			if G_CB_SNTable[i] ~= nil then
				if type(G_CB_SNTable[i]) == "string" then
					local G_CB_ShapeTable_Check = ""
					for j, k in pairs(G_CB_ShapeTable) do
						if G_CB_SNTable[i] == k then
							table.insert(X,SetCVar(FP,G_CB_SNTV[i][2],SetTo,j))
							G_CB_ShapeTable_Check = "OK"
						end
					end
					if G_CB_ShapeTable_Check ~= "OK" then
						PushErrorMsg("G_CB_SetSpawn_String_Shape_NotFound")
					end
				else
					PushErrorMsg("G_CB_SNTable_InputData_Error")
				end
			else
				table.insert(X,SetCVar(FP,G_CB_SNTV[i][2],SetTo,0))
			end
		end
	elseif type(G_CB_SNTable) == "string" then
		local G_CB_ShapeTable_Check = ""
		for j, k in pairs(G_CB_ShapeTable) do
			if G_CB_SNTable == k then
				table.insert(X,SetCVar(FP,G_CB_SNTV[1][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[2][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[3][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[4][2],SetTo,j))
				G_CB_ShapeTable_Check = "OK"
			end
		end
		if G_CB_ShapeTable_Check ~= "OK" then
			PushErrorMsg("G_CB_SetSpawn_String_Shape_NotFound")
		end
	else
		PushErrorMsg("G_CB_SNTable_InputData_Error")
	end
	if type(G_CB_FNTable) ~= "table" then
		G_CB_FNTable = {G_CB_FNTable,G_CB_FNTable,G_CB_FNTable,G_CB_FNTable}
	elseif G_CB_FNTable == nil then 
		G_CB_FNTable = {0,0,0,0}
	end
	if type(G_CB_PFTable) ~= "table" then
		G_CB_PFTable = {G_CB_PFTable,G_CB_PFTable,G_CB_PFTable,G_CB_PFTable}
	elseif G_CB_PFTable == nil then 
		G_CB_PFTable = {0,0,0,0}
	end
	if type(G_CB_RPTable) ~= "table" then
		G_CB_RPTable = {G_CB_RPTable,G_CB_RPTable,G_CB_RPTable,G_CB_RPTable}
	elseif G_CB_RPTable == nil then 
		PushErrorMsg("G_CB_SetSpawn_Inputdata_Error")
	end
	
	local LMRet = 0
	if G_CB_LMTable == "MAX" then
		LMRet = T_to_BiteBuffer({255,255,255,255})
	elseif type(G_CB_LMTable) == "table" then
		LMRet = T_to_BiteBuffer(G_CB_LMTable)
	elseif type(G_CB_LMTable) == "number" then
		LMRet = T_to_BiteBuffer({G_CB_LMTable,G_CB_LMTable,G_CB_LMTable,G_CB_LMTable})
	else
		LMRet = T_to_BiteBuffer({0,0,0,0})
	end
	local Y = {}
	if CenterXY == nil then 
		table.insert(Y,SetCVar(FP,G_CB_XPos[2],SetTo,0xFFFFFFFF))
		table.insert(Y,SetCVar(FP,G_CB_YPos[2],SetTo,0xFFFFFFFF))
	elseif type(CenterXY) == "table" then
		table.insert(Y,SetCVar(FP,G_CB_XPos[2],SetTo,CenterXY[1]))
		table.insert(Y,SetCVar(FP,G_CB_YPos[2],SetTo,CenterXY[2]))
	else
		PushErrorMsg("G_CB_SetSpawn_CenterXY_Inputdata_Error")
	end
	if Owner == nil then Owner = 0xFFFFFFFF end
	if Delay == nil then Delay = 0 end
	CallTriggerX(FP,Write_SpawnSet,Condition,{
		SetCVar(FP,G_CB_CUTV[2],SetTo,T_to_BiteBuffer(G_CB_CUTable)),
		X,
		
		SetCVar(FP,G_CB_DLTV[2],SetTo,Delay),
		SetCVar(FP,G_CB_LMTV[2],SetTo,LMRet),
		SetCVar(FP,G_CB_RPTV[2],SetTo,T_to_BiteBuffer(G_CB_RPTable)),Y,
		SetCVar(FP,G_CB_Owner[2],SetTo,Owner),
		SetCVar(FP,G_CB_FNTV[2],SetTo,T_to_BiteBuffer(G_CB_FNTable)),
		SetCVar(FP,G_CB_PFTV[2],SetTo,T_to_BiteBuffer(G_CB_PFTable)),
		SetCVar(FP,G_CB_EffType[2],SetTo,0),
		
	},PreserveFlag)
end


function G_CB_SetSpawnX(Condition,G_CB_CUTable,G_CB_SNTable,Property)
	if type(G_CB_CUTable) ~= "table" then
		PushErrorMsg("G_CB_SetSpawn_Inputdata_Error")
	end
	local X = {}
	if type(G_CB_SNTable) == "table" then
		if #G_CB_SNTable >= 5 then
			PushErrorMsg("BiteStack_is_Over_5")
		end
		for i = 1, 4 do
			if G_CB_SNTable[i] ~= nil then
				if type(G_CB_SNTable[i]) == "string" then
					local G_CB_ShapeTable_Check = ""
					for j, k in pairs(G_CB_ShapeTable) do
						if G_CB_SNTable[i] == k then
							table.insert(X,SetCVar(FP,G_CB_SNTV[i][2],SetTo,j))
							G_CB_ShapeTable_Check = "OK"
						end
					end
					if G_CB_ShapeTable_Check ~= "OK" then
						PushErrorMsg("G_CB_SetSpawn_String_Shape_NotFound")
					end
				else
					PushErrorMsg("G_CB_SNTable_InputData_Error")
				end
			else
				table.insert(X,SetCVar(FP,G_CB_SNTV[i][2],SetTo,0))
			end
		end
	elseif type(G_CB_SNTable) == "string" then
		local G_CB_ShapeTable_Check = ""
		for j, k in pairs(G_CB_ShapeTable) do
			if G_CB_SNTable == k then
				table.insert(X,SetCVar(FP,G_CB_SNTV[1][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[2][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[3][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[4][2],SetTo,j))
				G_CB_ShapeTable_Check = "OK"
			end
		end
		if G_CB_ShapeTable_Check ~= "OK" then
			PushErrorMsg("G_CB_SetSpawn_String_Shape_NotFound")
		end
	else
		PushErrorMsg("G_CB_SNTable_InputData_Error")
	end
	local G_CB_FNTable = {0,0,0,0}
	local G_CB_PFTable = {0,0,0,0}
	local G_CB_RPTable = {0,0,0,0}
	local G_CB_LMTable = {255,255,255,255}
	local Y = {SetCVar(FP,G_CB_XPos[2],SetTo,0xFFFFFFFF),SetCVar(FP,G_CB_YPos[2],SetTo,0xFFFFFFFF)}
	local Owner = 0xFFFFFFFF
	local Delay = 0
	local PreserveFlag


	
	if Property ~= nil then
		if type(Property) ~= "table" then
			PushErrorMsg("G_CB_SetSpawn_Property_Error")
		else
			for j,k in pairs(Property) do
				if j == "FNTable" then
					if type(k) ~= "table" then
						G_CB_FNTable = {k,k,k,k}
					else
						G_CB_FNTable = k
					end
				elseif j == "PFTable" then
					if type(k) ~= "table" then
						G_CB_PFTable = {k,k,k,k}
					else
						G_CB_PFTable = k
					end
				elseif j == "RPTable" then
					if type(k) ~= "table" then
						G_CB_RPTable = {k,k,k,k}
					else
						G_CB_RPTable = k
					end
				elseif j == "LMTable" then
					if k == "MAX" then
						G_CB_LMTable = {255,255,255,255}
					elseif type(k) ~= "table" then
						G_CB_LMTable = {k,k,k,k}
					else
						G_CB_LMTable = k
					end
					
				elseif j == "CenterXY" then
					if type(k) == "table" then
						Y = {SetCVar(FP,G_CB_XPos[2],SetTo,k[1]),
						SetCVar(FP,G_CB_YPos[2],SetTo,k[2])}
					else
						PushErrorMsg("G_CB_SetSpawn_CenterXY_Inputdata_Error")
					end
				elseif j == "Owner" then
					Owner = k
				elseif j == "Delay" then
					Delay = k
				elseif j == "PreserveFlag" then
					PreserveFlag = k
				else
					PushErrorMsg("Wrong Property Name Detected!! : "..j)
				end
			end
		end
	end 


	CallTriggerX(FP,Write_SpawnSet,Condition,{
		SetCVar(FP,G_CB_CUTV[2],SetTo,T_to_BiteBuffer(G_CB_CUTable)),
		X,
		
		SetCVar(FP,G_CB_DLTV[2],SetTo,Delay),
		SetCVar(FP,G_CB_LMTV[2],SetTo,T_to_BiteBuffer(G_CB_LMTable)),
		SetCVar(FP,G_CB_RPTV[2],SetTo,T_to_BiteBuffer(G_CB_RPTable)),Y,
		SetCVar(FP,G_CB_Owner[2],SetTo,Owner),
		SetCVar(FP,G_CB_FNTV[2],SetTo,T_to_BiteBuffer(G_CB_FNTable)),
		SetCVar(FP,G_CB_PFTV[2],SetTo,T_to_BiteBuffer(G_CB_PFTable)),
		SetCVar(FP,G_CB_EffType[2],SetTo,0),
		
	},PreserveFlag)
end
-- Line0 = UnitIDTable 0xFF
-- Line1 = RepeatTypeTable 0xFF
-- Line2 = G_CB_FNTableTable 0xFF
-- Line3 = ShapeNumberTable1
-- Line4 = ShapeNumberTable2
-- Line5 = ShapeNumberTable3
-- Line6 = ShapeNumberTable4
-- Line7 = XPos
-- Line8 = YPos
-- Line9 = CA[5],0xFF 루프 리미트 (트리거 순환당 소환할 유닛 수 / k입력시 CA[4] : 0~k-1까지 루프함) 
-- Line10 = CA[2] 남은 대기 시간 (Tick 단위 / 0일때 유닛 소환) 
-- Line11 = CA[3] 소환후 대기시간 증가량 (Tick 단위/ k입력시 1회 루프후 대기시간 k추가()
-- Line12 = CA[6] 데이터 인덱스 (k입력시 Shape[k+1]의 데이터를 출력함
-- Line14 = Bullet Repeat Angle

	Call_G_CB = SetCallForward()
	SetCall(FP)
		CIfX(FP,CVar(FP,G_CB_TempTable[1][2],AtLeast,1,0xFF))
			CallTrigger(FP,Load_CBPlot)
			CIfX(FP,{CDeaths(FP,AtLeast,1,G_CB_Launch),CDeaths(FP,AtLeast,1,G_CB_Suspend)})
			CDiv(FP,G_CB_TempTable[1],256)
			CDiv(FP,G_CB_TempTable[2],256)
			CDiv(FP,G_CB_TempTable[3],256)
			CMov(FP,G_CB_TempTable[4],G_CB_TempTable[5])
			CMov(FP,G_CB_TempTable[5],G_CB_TempTable[6])
			CMov(FP,G_CB_TempTable[6],G_CB_TempTable[7])
			CDiv(FP,G_CB_TempTable[10],256)
			CMov(FP,G_CB_TempTable[7],0)
			CMov(FP,G_CB_TempTable[11],0)
			CMov(FP,G_CB_TempTable[12],0)
			CMov(FP,G_CB_TempTable[13],0)
			CDiv(FP,G_CB_TempTable[14],256)
			CDiv(FP,G_CB_TempTable[15],256)
			if Limit == 1 then
				TriggerX(FP,{CD(TestMode,1)},{RotatePlayer({DisplayTextX(f_GunFuncT,4)},HumanPlayers,FP)},{preserved}) --
			end
			CElseIfX({CDeaths(FP,AtLeast,1,G_CB_Launch),CDeaths(FP,AtLeast,0,G_CB_Suspend)})
			CElseX()
			if Limit == 1 then
				TriggerX(FP,{CD(TestMode,1)},{RotatePlayer({DisplayTextX(f_GunErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)},{preserved})
			end
			
			local G_CB_InputCAct = {}
			for i = 1, G_CB_Lines do
				table.insert(G_CB_InputCAct,SetNVar(G_CB_TempTable[i],SetTo,0))
			end
				CDoActions(FP,G_CB_InputCAct)
			CIfXEnd()
		CElseIfX(CVar(FP,G_CB_TempTable[1][2],AtLeast,1))
		CDiv(FP,G_CB_TempTable[1],256)
		CDiv(FP,G_CB_TempTable[2],256)
		CDiv(FP,G_CB_TempTable[3],256)
		CMov(FP,G_CB_TempTable[4],G_CB_TempTable[5])
		CMov(FP,G_CB_TempTable[5],G_CB_TempTable[6])
		CMov(FP,G_CB_TempTable[6],G_CB_TempTable[7])
		CDiv(FP,G_CB_TempTable[10],256)
		CMov(FP,G_CB_TempTable[7],0)
		CMov(FP,G_CB_TempTable[11],0)
		CMov(FP,G_CB_TempTable[12],0)
		CMov(FP,G_CB_TempTable[13],0)
		CDiv(FP,G_CB_TempTable[14],256)
		CDiv(FP,G_CB_TempTable[15],256)
		if Limit == 1 then
			TriggerX(FP,{CD(TestMode,1)},{RotatePlayer({DisplayTextX(f_GunErrT2,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)},{preserved})
		end

		CIfXEnd()

		local G_CB_InputCAct = {}
		for i = 1, G_CB_Lines do
			table.insert(G_CB_InputCAct,TSetMemory(Vi(G_CB_TempH[2],(i-1)*(0x20/4)),SetTo,G_CB_TempTable[i]))
		end
		CDoActions(FP,G_CB_InputCAct)
		DoActionsX(FP,{SetCDeaths(FP,SetTo,0,G_CB_Suspend),SetCDeaths(FP,SetTo,0,G_CB_Launch)})
	SetCallEnd()
Actived_G_CB = CreateVar(FP)
function Create_G_CB_Arr()
	if G_CB_Arr_IndexAlloc ~= StartIndex then PushErrorMsg("Already_G_CB_Arr_Created") end
	CMov(FP,Actived_G_CB,0)
	for i = 0, G_CB_ArrSize-1 do
		CTrigger(FP, {CVar("X","X",AtLeast,1)}, {
			G_CB_InputCVar,
			SetCtrigX("X",G_CB_TempH[2],0x15C,0,SetTo,"X","X",0x15C,1,0),
			SetCVar(FP,G_CB_Num[2],SetTo,i+1),
			SetCVar(FP,Actived_G_CB[2],Add,1),
			SetNext("X",Call_G_CB,0),SetNext(Call_G_CB+1,"X",1), -- Call f_Gun
			SetCtrigX("X",Call_G_CB+1,0x158,0,SetTo,"X","X",0x4,1,0), -- RecoverNext
			SetCtrigX("X",Call_G_CB+1,0x15C,0,SetTo,"X","X",0,0,1), -- RecoverNext
			SetCtrig1X("X",Call_G_CB+1,0x164,0,SetTo,0x0,0x2) -- RecoverNext
		}, 1, G_CB_Arr_IndexAlloc)
		G_CB_Arr_IndexAlloc = G_CB_Arr_IndexAlloc + 1
	end
end


	function G_CB_init()

		f_GetStrXptr(FP,G_CB_WSTestStrPtr,"\x0D\x0D\x0DG_CB_WS".._0D)

	end

end


function Install_EXCC(Player,ArrSize,ResetFlag) -- 확장 구조오프셋 단락 전용 배열 구성하기
	local HeaderV = CreateVar(Player) -- 헤더가 저장된 V
	local EXCunitTemp = CreateVarArr(ArrSize,Player) -- 구조오프셋 확장 변수 TempV
	local Index = FuncAlloc -- FuncAlloc에서 라벨 받아옴
	FuncAlloc = FuncAlloc + 3
	table.insert(CtrigInitArr[Player+1],SetCtrigX(Player,HeaderV[2],0x15C,0,SetTo,Player,Index+2,0x15C,1,1))--{"X",EXCC_Forward,0x15C,1,2}--CC_Header
	local EXCUnitArr = {}
	for k, v in pairs(EXCunitTemp) do
		table.insert(EXCUnitArr,SetCVar("X",v[2],SetTo,0))
	end

	if ResetFlag ~= nil then
		if type(ResetFlag) == "number" then
			local EXCunit_Reset = {} -- 필요시 리셋 또는 값 조정 테이블
			for i = 1, #EXCunitTemp do
				table.insert(EXCunit_Reset,SetCtrig1X("X","X",CAddr("Value",i,0),0,SetTo,0))
			end
			return {Player,Index,HeaderV,EXCunitTemp,EXCUnitArr,EXCunit_Reset}
		elseif type(ResetFlag) == "table" then
			local EXCunit_Reset = {} -- 필요시 리셋 또는 값 조정 테이블(타이머or값초기화 등)
			for i = 1, #EXCunitTemp do
				if ResetFlag[i]~= nil then
					if type(ResetFlag[i]) == "table" then
						local X = ResetFlag[i]
						local RFValue = X[1]
						local RFType
						local RFMask
						if X[2] == nil then
							RFType = SetTo
						else
							RFType = X[2]
						end
						if X[3] == nil then
							RFMask = 0xFFFFFFFF
						else
							RFMask = X[3]
						end

						table.insert(EXCunit_Reset,SetCtrig1X("X","X",CAddr("Value",i,0),0,RFType,RFValue,RFMask))
					else
						PushErrorMsg("ResetFlag_Inputdata_Error")
					end
				end
			end
			return {Player,Index,HeaderV,EXCunitTemp,EXCUnitArr,EXCunit_Reset}
		end
	else
		return {Player,Index,HeaderV,EXCunitTemp,EXCUnitArr}
	end
end
function Set_EXCC2(EXCC_init,CUnitIndex,Line,Type,Value) -- EXCC단락 외부에서 값을 쓰고싶을때. 무조건 T액션, 너무많이 쓸 경우 성능 하락 우려 있음
	return TSetMemory(_Add(_Mul(CUnitIndex,_Mov(0x970/4)),_Add(EXCC_init[3],((0x20*Line)/4))),Type,Value)
end
function Set_EXCC2X(EXCC_init,CUnitIndex,Line,Type,Value,Mask) -- EXCC단락 외부에서 값을 쓰고싶을때. 무조건 T액션, 너무많이 쓸 경우 성능 하락 우려 있음
	return TSetMemoryX(_Add(_Mul(CUnitIndex,_Mov(0x970/4)),_Add(EXCC_init[3],((0x20*Line)/4))),Type,Value,Mask)
end

function Set_EXCC(Line,Type,Value) -- EXCC단락 내부에서 값을 쓰고싶을때. 실제값 X
	return SetV(EXCC_TempVarArr[Line+1],Value,Type)
end
function Set_EXCCX(Line,Type,Value,Mask) -- EXCC단락 내부에서 값을 쓰고싶을때. 실제값
	if Mask == nil then Mask = 0xFFFFFFFF end
	return TSetMemoryX(_Add(EXCC_TempHeader,((0x20*Line)/4)),Type,Value,Mask)
end


function Cond_EXCC(Line,Type,Value,Mask) -- EXCC단락 내부에서 값을 검사하고 싶을때.
	return CVar(FP,EXCC_TempVarArr[Line+1][2],Type,Value,Mask)
end
function Cond_EXCC2(EXCC_init,CUnitIndex,Line,Type,Value) -- EXCC단락 외부에서 값을 검사하고 싶을때.
	return TMemory(_Add(_Mul(CUnitIndex,_Mov(0x970/4)),_Add(EXCC_init[3],((0x20*Line)/4))),Type,Value)
end
function _Cond_EXCC2(EXCC_init,CUnitIndex,Line,Type,Value) -- EXCC단락 외부에서 값을 검사하고 싶을때. TTOR전용
	return _TMemory(_Add(_Mul(CUnitIndex,_Mov(0x970/4)),_Add(EXCC_init[3],((0x20*Line)/4))),Type,Value)
end
EXCC_initArr = {}
function EXCC_Part1(EXCC_init,Actions)
	if #EXCC_initArr ~= 0 then
		PushErrorMsg("EXCCinitArr_Already_Loading")
	end
	EXCC_initArr = EXCC_init
	EXCC_Player = EXCC_initArr[1]
	EXCC_Index = EXCC_initArr[2]
	EXCC_TempVarArr = EXCC_initArr[4]
	PlayerID = EXCC_Player
	EXCC_TempHeader = CreateVar(EXCC_Player)
	PlayerID = PlayerConvert(PlayerID)
	Trigger { -- Cunit Ctrig Start
		players = {PlayerID},
		conditions = { 
			Label(0);
		},
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",EXCC_Index+2,0,0,1); 
		},
		flag = {preserved}
	}	
	Trigger { -- Cunit Calc Selector
		players = {PlayerID},
		conditions = { 
			Label(EXCC_Index);
		},
		actions = {
			SetDeathsX(0,SetTo,0,0,0xFFFFFFFF); -- RecoverNext
			Actions,
		},
		flag = {preserved}
	}	
	
end
-- NJump Trig 삽입 부분 (조건만족시 Jump)
function EXCC_Part2()
	PlayerID = EXCC_Player
	PlayerID = PlayerConvert(PlayerID)
	for k, P in pairs(PlayerID) do
		Trigger { -- Cunit Calc Last
			players = {P},
			conditions = { 
				Label(EXCC_Index+1);
			},
		   	actions = {
				SetDeathsX(0,SetTo,0,0,0xFFFFFFFF); -- RecoverNext
				SetMemory(0x6509B0,SetTo,P);
			},
			flag = {preserved}
		}	
	end
end
function EXCC_Part3X()
	MoveCpValue = 0
	PlayerID = EXCC_Player
	Trigger { -- Cunit Calc Start
		players = {PlayerID},
		conditions = { 
			Label(EXCC_Index+2);
		},
		flag = {preserved}
	}	
end

function EXCC_Part4X(LoopIndex,Conditions,Actions)
	MoveCpValue = 0
	PlayerID = EXCC_Player
	Trigger { -- Cunit Calc Main
		players = {PlayerID},
		conditions = { 
			Label(0);
			Conditions,
		},
		actions = { 
		EXCC_initArr[5],
		SetCtrigX("X","X",0x4,0,SetTo,"X",EXCC_Index,0,0,0);
		SetCtrigX("X",EXCC_Index+1,0x4,0,SetTo,"X","X",0,0,1);
		SetCtrigX("X",EXCC_Index,0x158,0,SetTo,"X","X",0x4,1,0);
		SetCtrigX("X",EXCC_Index,0x15C,0,SetTo,"X","X",0,0,1);
		SetCtrigX("X",EXCC_TempHeader[2],0x15C,0,SetTo,"X","X",0x15C,1,0),
		SetMemory(0x6509B0,SetTo,19025 + (84 * LoopIndex));
		Actions,
		EXCC_initArr[6]
			},
		flag = {preserved}
	}		
end

	
function EXCC_ClearCalc(Actions)
	PlayerID = EXCC_Player
	Trigger { -- Cunit Calc End
		players = {PlayerID},
		conditions = { 
			Label(0);
		}, 
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",EXCC_Index+1,0,0,0);
			Actions
		},
		flag = {preserved}
	}	
end

function EXCC_BreakCalc(Conditions,Actions)	
	PlayerID = EXCC_Player
	STPopTrigArr(PlayerID)
	TTPopTrigArr(PlayerID)
	Conditions = PopCondArr(Conditions)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,3)

	Trigger { -- Cunit Calc Break
		players = {PlayerID},
		conditions = { 
			Label(0);
			Conditions,
		}, 
		actions = {
			SetCtrigX("X","X",0x4,0,SetTo,"X",EXCC_Index+1,0,0,0);
			SetCtrigX("X",EXCC_Index+1,0x158,0,SetTo,"X","X",0x4,1,0);
			SetCtrigX("X",EXCC_Index+1,0x15C,0,SetTo,"X","X",0,0,1);
			Actions,
		},
		flag = {preserved}
	}	
end

function EXCC_End()
	EXCC_Index = nil
	EXCC_Player = nil
	EXCC_initArr = {}
	EXCC_TempHeader = nil
end
	


function Install_TMemoryBW(PlayerID)
	local OffsetV = CreateVar(PlayerID)
	local MaskRetV = CreateVar(PlayerID)
	local BWTypeV = CreateVar(PlayerID)
	local TypeV = CreateVar(PlayerID)
	local RetV = CreateVar(PlayerID)
	local EPDRetV = CreateVar(PlayerID)
	local ValueV = CreateVar(PlayerID)
	local MaskV = CreateVar(PlayerID)
	local MaskV2 = CreateVar(PlayerID)


	Call_MemoryCalc = SetCallForward()
	SetCall(PlayerID)
		CiSub(PlayerID,OffsetV,0x58A364)
		f_iMod(PlayerID,MaskRetV,OffsetV,4)
		f_iDiv(PlayerID,OffsetV,4)
		CIf(PlayerID,{CVar(PlayerID,MaskRetV[2],AtLeast,0x80000000)})
			CNeg(PlayerID,MaskRetV)
		CIfEnd()
		CIfX(PlayerID,{CVar(PlayerID,BWTypeV[2],Exactly,1)}) -- B
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,0)},{SetCVar(PlayerID,MaskV[2],SetTo,1)},1)
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,1)},{SetCVar(PlayerID,MaskV[2],SetTo,256)},1)
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,2)},{SetCVar(PlayerID,MaskV[2],SetTo,65536)},1)
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,3)},{SetCVar(PlayerID,MaskV[2],SetTo,16777216)},1)
			f_Mul(PlayerID,ValueV,MaskV)
			CIfX(PlayerID,CVar(PlayerID,MaskV2[2],Exactly,0xFFFFFFFF))
			f_Mul(PlayerID,MaskV,255)
			CElseX()
			f_Mul(PlayerID,MaskV,MaskV2)
			CIfXEnd()
		CElseX() -- W
			
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,0)},{SetCVar(PlayerID,MaskV[2],SetTo,1)},1)
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,2)},{SetCVar(PlayerID,MaskV[2],SetTo,65536)},1)
			f_Mul(PlayerID,ValueV,MaskV)
			CIfX(PlayerID,CVar(PlayerID,MaskV2[2],Exactly,0xFFFFFFFF))
			f_Mul(PlayerID,MaskV,65535)
			CElseX()
			f_Mul(PlayerID,MaskV,MaskV2)
			CIfXEnd()
		CIfXEnd()
		CIfX(PlayerID,{CVar(PlayerID,TypeV[2],Exactly,SetTo)})
			CDoActions(PlayerID,{TSetMemoryX(OffsetV,SetTo,ValueV,MaskV)})
		CElseIfX({CVar(PlayerID,TypeV[2],Exactly,Add)})
			CDoActions(PlayerID,{TSetMemoryX(OffsetV,Add,ValueV,MaskV)})
		CElseIfX({CVar(PlayerID,TypeV[2],Exactly,Subtract)})
			CDoActions(PlayerID,{TSetMemoryX(OffsetV,Subtract,ValueV,MaskV)})
		CIfXEnd()
	SetCallEnd()
	Call_ReadCalc = SetCallForward()
	SetCall(PlayerID)
		CiSub(PlayerID,OffsetV,0x58A364)
		f_iMod(PlayerID,MaskRetV,OffsetV,4)
		f_iDiv(PlayerID,OffsetV,4)
		CIf(PlayerID,{CVar(PlayerID,MaskRetV[2],AtLeast,0x80000000)})
			CNeg(PlayerID,MaskRetV)
		CIfEnd()
		f_Read(PlayerID,OffsetV,RetV)
		CIfX(PlayerID,{CVar(PlayerID,BWTypeV[2],Exactly,1)}) -- B
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,0)},{SetCVar(PlayerID,MaskV[2],SetTo,1),SetCVar(PlayerID,MaskV2[2],SetTo,256)},1)
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,1)},{SetCVar(PlayerID,MaskV[2],SetTo,256),SetCVar(PlayerID,MaskV2[2],SetTo,65536)},1)
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,2)},{SetCVar(PlayerID,MaskV[2],SetTo,65536),SetCVar(PlayerID,MaskV2[2],SetTo,16777216)},1)
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,3)},{SetCVar(PlayerID,MaskV[2],SetTo,16777216),SetCVar(PlayerID,MaskV2[2],SetTo,0)},1)
		CElseX() -- W
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,0)},{SetCVar(PlayerID,MaskV[2],SetTo,1),SetCVar(PlayerID,MaskV2[2],SetTo,65536)},1)
			CTrigger(PlayerID,{CVar(PlayerID,MaskRetV[2],Exactly,2)},{SetCVar(PlayerID,MaskV[2],SetTo,65536),SetCVar(PlayerID,MaskV2[2],SetTo,0)},1)
		CIfXEnd()
		f_Mod(PlayerID,RetV,MaskV2)
		f_Div(PlayerID,RetV,MaskV)
		CIf(FP,CVar(PlayerID,MaskV2[2],AtLeast,1))
		CIfEnd()
	SetCallEnd()

	function Act_TSetMemoryB(Offset,Type,Value,Mask)
		if Mask == nil then Mask = 0xFFFFFFFF end
		CDoActions(PlayerID,{
			TSetCVar(PlayerID,OffsetV[2],SetTo,Offset),
			TSetCVar(PlayerID,TypeV[2],SetTo,Type),
			TSetCVar(PlayerID,ValueV[2],SetTo,Value),
			TSetCVar(PlayerID,MaskV2[2],SetTo,Mask),
			SetCVar(PlayerID,BWTypeV[2],SetTo,1),
			
		})
		CallTrigger(PlayerID,Call_MemoryCalc,{})
	end	
	function Act_TSetMemoryW(Offset,Type,Value,Mask)
		if Mask == nil then Mask = 0xFFFFFFFF end
		CDoActions(PlayerID,{
			TSetCVar(PlayerID,OffsetV[2],SetTo,Offset),
			TSetCVar(PlayerID,TypeV[2],SetTo,Type),
			TSetCVar(PlayerID,ValueV[2],SetTo,Value),
			TSetCVar(PlayerID,MaskV2[2],SetTo,Mask),
			SetCVar(PlayerID,BWTypeV[2],SetTo,0),
			
		})
		CallTrigger(PlayerID,Call_MemoryCalc,{})
	end
	function Act_BRead(Offset)
		CDoActions(PlayerID,{
			TSetCVar(PlayerID,OffsetV[2],SetTo,Offset),
			SetCVar(PlayerID,BWTypeV[2],SetTo,1),
			
		})
		CallTrigger(PlayerID,Call_ReadCalc,{})
		return RetV
	end
	function Act_WRead(Offset)
		CDoActions(PlayerID,{
			TSetCVar(PlayerID,OffsetV[2],SetTo,Offset),
			SetCVar(PlayerID,BWTypeV[2],SetTo,0),
			
		})
		CallTrigger(PlayerID,Call_ReadCalc,{})
		return RetV
	end

	
end

function CS__InputTA(Player,Condition,SVA1,Value,Mask,Flag)
	if Flag == nil then Flag = {preserved} elseif Flag == 1 then Flag = {} end
	TriggerX(Player,Condition,{SetCSVA1(SVA1,SetTo,Value,Mask)},Flag)
end


function CB_initTCopy()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	local FXAddrT = {}
	local FYAddrT = {}
	CBPlotFXArr = f_GetVoidptr(PlayerID,#FX+1)
	CBPlotFYArr = f_GetVoidptr(PlayerID,#FY+1)
	CBPlotFYArr = f_GetVoidptr(PlayerID,#FY+1)
	CBPlotFNum = f_GetVoidptr(PlayerID,#Num+1)
	for i = 1, #FX do
		table.insert(CtrigInitArr[PlayerID+1],SetCtrigX(PlayerID,CBPlotFXArr[2],(i*4)+2416,0, SetTo, PlayerID, FX[i][2], 2416, 1, 0))
	end
	for i = 1, #FY do
		table.insert(CtrigInitArr[PlayerID+1],SetCtrigX(PlayerID,CBPlotFYArr[2],(i*4)+2416,0, SetTo, PlayerID, FY[i][2], 2416, 1, 0))
	end
	for i = 1, #Num do
		table.insert(CtrigInitArr[PlayerID+1],SetCtrig1X(PlayerID,CBPlotFNum[2],(i*4)+2416,0, SetTo, Num[i]))
	end
	CBPlotNumHeader = CreateVar(PlayerID)
	table.insert(CtrigInitArr[PlayerID+1],SetCtrigX(PlayerID,CBPlotNumHeader[2],0x15C,0, SetTo, PlayerID, CA[7], 0x15C, 1, 0))
end
function CB_TCopy(Shape,RetShape)
	FCBCOPYCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		PushErrorMsg("Need_Include_CBPaint")
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)
	local LShNextV = CreateVar(PlayerID)
	local LRShNextV2 = CreateVar(PlayerID)
	if type(Shape) == "number" then
		CMov(PlayerID,LShNextV,Shape*(0x970/4))
	else
	CMul(PlayerID,LShNextV,Shape,(0x970/4))
	end
	if type(RetShape) == "number" then
		CMov(PlayerID,LRShNextV2,RetShape*(0x970/4))
	else
	CMul(PlayerID,LRShNextV2,RetShape,(0x970/4))
	end
	f_SHRead(PlayerID,_Add(CBPlotNumHeader,LShNextV),CV[2])
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {preserved}
		}

	CMov(PlayerID,CV[5],_Read(FArr(CBPlotFXArr,Shape)))
	CMov(PlayerID,CV[6],_Read(FArr(CBPlotFYArr,Shape)))
 	CMov(PlayerID,CV[7],_Read(FArr(CBPlotFXArr,RetShape)))
	CMov(PlayerID,CV[8],_Read(FArr(CBPlotFYArr,RetShape)))
	if type(RetShape) == "number" then
		CDoActions(PlayerID,{SetV(CV[4],_SHRead(FArr(CBPlotFNum,RetShape-1)))})
	else
		CDoActions(PlayerID,{SetV(CV[4],_SHRead(FArr(CBPlotFNum,_Sub(RetShape,1))))})
	end
	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBCOPYCall1,0x0,0,0);
				SetCtrigX("X",FCBCOPYCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBCOPYCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBCOPYCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {preserved}
		}
	CDoActions(PlayerID,{TSetMemory(_Add(CBPlotNumHeader,LRShNextV2),SetTo,CV[1])})
end
function CRandNum(PlayerID,Bit,DestV,ResetFlag) -- 경량화 랜덤숫자 생성기
	if ResetFlag == nil then
		DoActionsX(PlayerID,{SetNVar(DestV,SetTo,0)})
	end
	for i = 0, Bit do
		DoActions(PlayerID,{SetSwitch("Switch 100",Random)})
		TriggerX(PlayerID,{Switch("Switch 100",Set)},{SetNVar(DestV,Add,2^i)},{preserved})
	end
end


function CFor3(PlayerID,Init,End,Step,Actions,UnPack) -- DoWhile x CJump
	CDoActions(PlayerID,{TSetVariableX("X",IndexAlloc+1,"Value",SetTo,Init)}) -- Calc Init
	if UnPack == 1 then
		if Actions ~= nil then
		for k, v in pairs(Actions) do
			local Temp = CunPack(v)
			Actions[k] = Temp
		end
	end
	end
	Actions = __FlattenCAct(Actions)

	STPopTrigArr(PlayerID)
	Actions = PopActArr(Actions)
	PopTrigArr(PlayerID,1,1)
	Trigger {
		players = {PlayerID},
		conditions = {
			Label(IndexAlloc);
			VariableX("X",IndexAlloc+1,"Value",Exactly,End); -- Calc Last
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
			Actions,
	   		PreserveTrigger();
		},
	}
	CVariable(PlayerID,IndexAlloc+1)
	Trigger {
		players = {PlayerID},
		conditions = {
			Label(IndexAlloc+2);
		},
		actions = {
			SetDeaths(0,SetTo,0,0);
	   		PreserveTrigger();
		},
	}
	PlayerID = PlayerConvert(PlayerID)
	table.insert(CForArr, IndexAlloc)
	table.insert(CForPArr, PlayerID)
	table.insert(CForStep, Step)
	CForptr = CForptr + 1
	IndexAlloc = IndexAlloc + 0x4

	return {"X",IndexAlloc-3,0,"V"}
end


function SetFlingySpeed(FID,Value)
	return {
		SetMemory(0x6C9EF8+(4*FID),SetTo,0xFFFFFFFF-Value),--최고속도
		SetMemoryW(0x6C9C78+(2*FID),SetTo,Value)--가속도
	}
end


function SetWeaponsDat(Condition,WepID,Property,Flag)
	local Action = {}
	function PatchInsert(Act)
		table.insert(Action,Act)
	end
	if type(Property)~= "table" then
		PushErrorMsg("Property Inputdata Error")
	else
		for j,k in pairs(Property) do
			if j=="DmgBase" then
				PatchInsert(SetMemoryW(0x656EB0+(WepID *2),SetTo,k)) -- 공격력
			elseif j=="DmgFactor" then
				PatchInsert(SetMemoryW(0x657678+(WepID *2),SetTo,k)) -- 추가공격력
			elseif j=="Cooldown" then
				PatchInsert(SetMemoryB(0x656FB8+(WepID *1),SetTo,k)) -- 공속
			elseif j=="Splash" then
				if type(k)=="boolean" then
					if k == true then
						PatchInsert(SetMemoryB(0x6566F8+WepID,SetTo,3)) -- 스플타입(일방형)
					else
						PatchInsert(SetMemoryB(0x6566F8+WepID,SetTo,1)) -- 스플타입(스플없음)
					end
				elseif type(k)~="table" or #k~=3 then
					PushErrorMsg("Splash Inputdata Error")
				else
					PatchInsert(SetMemoryB(0x6566F8+WepID,SetTo,3)) -- 스플타입(일방형)
					PatchInsert(SetMemoryW(0x656888+(WepID*2),SetTo,k[1])) --스플 안
					PatchInsert(SetMemoryW(0x6570C8+(WepID*2),SetTo,k[2])) --스플 중
					PatchInsert(SetMemoryW(0x657780+(WepID*2),SetTo,k[3])) --스플 밖
				end
			elseif j=="RangeMin" then
				PatchInsert(SetMemory(0x656A18+(WepID *4),SetTo,k)) -- 사거리 최소
			elseif j=="RangeMax" then
				PatchInsert(SetMemory(0x657470+(WepID *4),SetTo,k)) -- 사거리 최대
			elseif j=="TargetFlag" then
				PatchInsert(SetMemoryW(0x657998 + (WepID*2), SetTo, k))
			elseif j=="UpgradeType" then
				PatchInsert(SetMemoryB(0x6571D0 + WepID, SetTo, k))
			elseif j=="ObjectNum" then
				PatchInsert(SetMemoryB(0x6564E0+WepID,SetTo,k)) -- 투사체수
			elseif j=="IconType" then
				PatchInsert(SetMemoryW(0x656780+(WepID *2),SetTo,k)) -- 아이콘
			elseif j== "Behavior" then
				PatchInsert(SetMemoryB(0x656670+WepID,SetTo,k))
			elseif j== "LaunchX" then
				PatchInsert(SetMemoryB(0x657910+WepID,SetTo,k))
			elseif j== "LaunchY" then
				PatchInsert(SetMemoryB(0x656C20+WepID,SetTo,k))
			elseif j== "LaunchSpin" then
				PatchInsert(SetMemoryB(0x657888+WepID,SetTo,k))
			elseif j== "AttackAngle" then
				PatchInsert(SetMemoryB(0x656990+WepID,SetTo,k))
			elseif j== "RemoveAfter" then
				PatchInsert(SetMemoryB(0x657040+WepID,SetTo,k))
			elseif j== "FlingyID" then
				PatchInsert(SetMemory(0x656CA8+(WepID *4),SetTo,k))
			elseif j== "WepName" then
				PatchInsert(SetMemoryW(0x6572E0+(WepID *2),SetTo,k)) -- 이름
			else
				PushErrorMsg("Wrong Property Name Detected!! : "..j)
			end
		end
	end
	Trigger2(FP,Condition,Action,Flag)
end

function CheatTestX(Player,VW,TrapVW,Flag,PRandFlag,Text)
	
	local TrapKey
	local CT_PrevRand
	local CT_NextRand
	local PCT_PrevRandV
	local PCT_NextRandV
	local PCT_PrevRandW
	local PCT_NextRandW
	
	PCT_PrevRandV = CT_GPrevRandV
	PCT_NextRandV = CT_GNextRandV
	PCT_PrevRandW = CT_GPrevRandW
	PCT_NextRandW = CT_GNextRandW
	
	if VW[4] == "V" then
		CIfX(FP,{CV(VW, TrapVW)}) -- 치트 난수 테스트(참이어야 정상)
		
	else
		CIfX(FP,{TTNWar(VW, Exactly, TrapVW)}) -- 치트 난수 테스트(참이어야 정상)
	end
	local DeathUnit = 1
	local ttable = {}

	if type(Flag) == "number" then
		
		if Flag>=32 then
			DeathUnit = math.floor(DeathUnit+(Flag/32))
			Flag = Flag%32
		end
		if DeathUnit == 2 and Flag == 5 then
			--error(Text)
		end
		--if DeathUnit == 3 then Pushdsadas() end
		
	if Player == AllPlayers then
		for i = 0, 6 do
			table.insert(ttable,SetCVar(FP, BPArr[DeathUnit][i+1][2], SetTo, 2^Flag, 2^Flag))
		end
	else
		ttable = {SetCVar(FP, BPArr[DeathUnit][Player+1][2], SetTo, 2^Flag, 2^Flag)}
	end
	ctarr[DeathUnit][Flag+1] = Text
	
	if DeathUnit== 	1 then 
		--if 2^Flag == 2048 then error(Text) end
	end
	CElseX({ttable})

	else
	CElseX()
		

	if TestStart ~= 1 then
		if Player == AllPlayers then
			for p = 0, 6 do
				TriggerX(FP,{LocalPlayerID(p)},{{
					SetCp(p),
					PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
					DisplayExtText(Flag.."\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
					DisplayExtText("\x13\x07『 \x04SCA 아이디, 스타 아이디, 현재 미네랄, 가스 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
					SetMemory(0xCDDDCDDC,SetTo,1);}})
			end
		else
			TriggerX(FP,{LocalPlayerID(Player)},{{
				SetCp(Player),
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				DisplayExtText(Flag.."\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
				DisplayExtText("\x13\x07『 \x04SCA 아이디, 스타 아이디, 현재 미네랄, 가스 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
				SetMemory(0xCDDDCDDC,SetTo,1);}})
				
		end

	end


	end
	

--	if TestStart == 1 then
--		if Player == AllPlayers then Player = iv.LCP end
--		if VW[4] =="W" then
--			CDoActions(FP, {TSetMemory(0x6509B0,SetTo,iv.LCP),DisplayExtText(Text,4)})
--		else
--			CDoActions(FP, {TSetMemory(0x6509B0,SetTo,iv.LCP),DisplayExtText(Text,4)})
--		end
--		
--	end
	CIfXEnd()
	if VW[4] == "V" then
		CXor(FP, VW, PCT_PrevRandV)--감지 여부 상관없이 진짜값으로 복구
		
	else
		f_LXor(FP, VW, VW, PCT_PrevRandW)--감지 여부 상관없이 진짜값으로 복구
	end
	return TrapKey
end	



function CreateDataPV(DataName,SCADeathData,LocOp)
	local Ret = CreateVarArr(7,FP)
	local Ret2 = CreateVarArr(7,FP)
	table.insert(PVWArr,{Ret,Ret2,DataName})
	if SCADeathData ~= nil then
		table.insert(SCA_DataArr,{Ret,SCADeathData,DataName})
	end
	if LocOp == 1 then 
		local Ret3 = CreateVar(FP)
		table.insert(LocalDataArr,{Ret[1],Ret3})
		return Ret,Ret2,Ret3
	else return Ret,Ret2
	end
	
end
function CreateDataPW(DataName,SCADeathData,LocOp)
	local Ret = CreateWarArr(7,FP)
	local Ret2 = CreateWarArr(7,FP)
	table.insert(PVWArr,{Ret,Ret2,DataName})
	if SCADeathData ~= nil then
		if #SCADeathData~=2 then PushErrorMsg("SCADeathData_InputData_Error") end
		table.insert(SCA_DataArr,{Ret,SCADeathData,DataName})
	end
	if LocOp == 1 then 
		local Ret3 = CreateWar(FP)
		table.insert(LocalDataArr,{Ret[1],Ret3})
		return Ret,Ret2,Ret3
	else return Ret,Ret2
	end
	
end



function CheatTest2X(Player,VW,TrapVW,Flag,PRandFlag,Text)
	local TrapKey
	if VW[1][4] == "V" then
		CMovX(FP,GV,VArrX(GetVArray(VW[1], 7), VArrL, VArrL4),nil,nil,nil,1)
		CMovX(FP,TrapGV,VArrX(GetVArray(TrapVW[1], 7), VArrL, VArrL4),nil,nil,nil,1)
		CIfX(FP,{CV(GV, TrapGV)}) -- 치트 난수 테스트(참이어야 정상)
	else
		f_LMovX(FP,GW,WArrX(GetWArray(VW[1], 7), WArrL, WArrL4),nil,nil,nil,1)
		f_LMovX(FP,TrapGW,WArrX(GetWArray(TrapVW[1], 7), WArrL, WArrL4),nil,nil,nil,1)
		CIfX(FP,{TTNWar(GW, Exactly, TrapGW)}) -- 치트 난수 테스트(참이어야 정상)
	end
	local DeathUnit = 1
	--local ttable = {}

	if type(Flag) == "number" then
		
		if Flag>=32 then
			DeathUnit = math.floor(DeathUnit+(Flag/32))
			Flag = Flag%32
		end
		if DeathUnit == 2 and Flag == 5 then
			--error(Text)
		end
		--if DeathUnit == 3 then Pushdsadas() end
		
	--ttable = {SetCVar(FP, BPArr[DeathUnit][Player+1][2], SetTo, 2^Flag, 2^Flag)}
	ctarr[DeathUnit][Flag+1] = Text
	if DeathUnit== 	1 then 
		--if 2^Flag == 2048 then error(Text) end
	end
	CElseX()
	if TestStart == 0 then
		CMovX(FP, VArrX(GetVArray(BPArr[DeathUnit][1], 7), VArrL, VArrL4), 2^Flag,SetTo,2^Flag)
	end
 
	else

	end
	

--	if TestStart == 1 then
--		if Player == AllPlayers then Player = iv.LCP end
--		if VW[4] =="W" then
--			CDoActions(FP, {TSetMemory(0x6509B0,SetTo,iv.LCP),DisplayExtText(Text,4)})
--		else
--			CDoActions(FP, {TSetMemory(0x6509B0,SetTo,iv.LCP),DisplayExtText(Text,4)})
--		end
--		
--	end
	CIfXEnd()
	if VW[1][4] == "V" then
		CXor(FP, GV, CT_GPrevRandV)--감지 여부 상관없이 진짜값으로 복구
		CMovX(FP,VArrX(GetVArray(VW[1], 7), VArrL, VArrL4),GV,nil,nil,nil,1)
		
	else
		f_LXor(FP, GW, GW, CT_GPrevRandW)--감지 여부 상관없이 진짜값으로 복구
		f_LMovX(FP,WArrX(GetWArray(VW[1], 7), WArrL, WArrL4),GW,nil,nil,nil,1)
	end
	
	return TrapKey
end	

function DisplayPrint(TargetPlayers,arg)
	if TargetPlayers == CurrentPlayer or TargetPlayers == "CP" then
		f_SaveCp()
	end

	local BSize = 0
	for j,k in pairs(arg) do -- StrSizeCalc
		if type(k) == "string" then
			local CT = GetStrSize(0,k)
			BSize=BSize+CT
		elseif type(k)=="table" and k[4]=="V" then
			BSize=BSize+(4*4)
		elseif type(k)=="table" and k[1][4]=="V" then -- VarArr일 경우
			BSize = BSize+#k
		elseif type(k)=="number" then -- 상수index V 입력, string.char 구현용. 맨앞 0xFF영역만 사용
			BSize=BSize+1
		else
			PushErrorMsg("Print_Inputdata_Error")
		end
	end
	
	local StrT = "\x0D\x0D\x0DSI"..StrXIndex..string.rep("\x0D", BSize+3)
	local RetV = CreateVar(FP)
	local Dev = 0
	table.insert(StrXKeyArr,{RetV,StrT})
	StrXIndex=StrXIndex+1
	for j,k in pairs(arg) do
		if type(k) == "string" then
			local CT = CreateCText(FP,k)
			table.insert(StrXPatchArr,{RetV,Dev,CT})
			Dev=Dev+CT[2]
		elseif type(k)=="table" and k[4]=="V" then
			CMov(FP,publicItoDecV,k)
			CallTrigger(FP,Call_IToDec)
			f_Movcpy(FP,_Add(RetV,Dev),VArr(publicItoDecVArr,0),4*4)
			Dev=Dev+(4*4)
		elseif type(k)=="table" and k[1][4]=="V" then -- VarArr일 경우
			for o,p in pairs(k) do
				CDoActions(FP,{TBwrite(_Add(RetV,Dev),SetTo,p)})
				Dev=Dev+(1)
			end

		elseif type(k)=="number" then -- 상수index V 입력, string.char 구현용. 맨앞 0xFF영역만 사용
			CDoActions(FP,{TBwrite(_Add(RetV,Dev),SetTo,V(k))})
			Dev=Dev+(1)

		else
			PushErrorMsg("Print_Inputdata_Error")
		end
	end
	if TargetPlayers==CurrentPlayer or TargetPlayers=="CP" then
		CDoActions(FP,{TSetMemory(0x6509B0,SetTo,BackupCp),DisplayText(StrT,4)})
	elseif type(TargetPlayers)=="table" and TargetPlayers[4]=="V" then
		CDoActions(FP,{TSetMemory(0x6509B0,SetTo,TargetPlayers),DisplayText(StrT,4)})

	else
		DoActions2(FP,{RotatePlayer({DisplayTextX(StrT,4)},TargetPlayers,FP)})
	end
end

function print_utf8_2(line, offset, string)
    local ret = {}
    local dst = 0x640B60 + line * 218 + offset
	
    if type(string) == "string" then
        local str = string
        local n = 1
        if dst % 4 >= 1 then
            for i = 1, dst % 4 do str = '\x0d'..str end
        end
        local t = cp949_to_utf8(str)
        while n <= #t do
			
            ret[#ret+1] = SetMemory(dst - dst % 4 +n-1, SetTo, _dw(t, n))
            n = n + 4
        end
    elseif type(string) == "number" then
        PushErrorMsg("print_utf8_InputError")
    end
    return ret
end

function DisplayPrintEr(TargetPlayer,arg)
	local Dev = 0
	local RetAct = {}
	local ItoDecKey = {}
	local VCharKey = {}
	


	for j,k in pairs(arg) do
		if type(k) == "string" then
			local Strl = GetStrSize(0,k)
			if Strl%4~=0 then k=string.rep("\x0D", (4-Strl%4))..k Strl=Strl+(4-Strl%4) end
			table.insert(RetAct,print_utf8_2(12, Dev, k))
			
			Dev=Dev+Strl
		elseif type(k)=="table" and k[4]=="V" then
			table.insert(RetAct,print_utf8_2(12, Dev, string.rep("\x0D", 16)))
			--V,Dev
			table.insert(ItoDecKey,{k,Dev})
			Dev=Dev+(4*4)
		elseif type(k)=="number" then -- 상수index V 입력, string.char 구현용. 맨앞 0xFF영역만 사용
			table.insert(RetAct,print_utf8_2(12, Dev, string.rep("\x0D", 1)))
			table.insert(VCharKey,{k,Dev})
			Dev=Dev+(1)

		else
			PushErrorMsg("Print_Inputdata_Error")
		end
	end
	if type(TargetPlayer) == "table" and TargetPlayer[4] == "V" then
		Print_13X(FP, TargetPlayer)
	else
		CallTrigger(FP, Call_Print13[TargetPlayer+1])
	end
	CIf(FP, {TMemory(0x512684,Exactly,TargetPlayer)})
	DoActions2(FP, RetAct)
	for j,p in pairs(ItoDecKey) do
		local k = p[1]
		CMov(FP,publicItoDecV,k)
		CallTrigger(FP,Call_IToDec)
		f_Movcpy(FP,0x640B60 + (12 * 218)+p[2],VArr(publicItoDecVArr,0),4*4)
	end
	for j,p in pairs(VCharKey) do
		CDoActions(FP,{TBwrite(0x640B60+p[2],SetTo,V(p[1]))})
	end
	
	CIfEnd()

end

function Print_13X(PlayerID,TargetPlayer,String)
	local Y = {}
	if String ~= nil then
		table.insert(Y,print_utf8(12, 0, String))
	end
	CIf(PlayerID,Memory(0x628438,AtLeast,1))
		f_ReadX(PlayerID,0x628438,V(FuncAlloc),1,0xFFFFFF)
		CDoActions(PlayerID,{SetMemory(0x628438,SetTo,0),TCreateUnit(1,0,"Anywhere",TargetPlayer),Y})
		CVariable2(PlayerID,FuncAlloc,0x628438,SetTo,0)
	CIfEnd()
	FuncAlloc = FuncAlloc + 1
end

function init_StrX()
	for k, v in pairs(StrXKeyArr) do
		f_GetStrXptr(FP,v[1],v[2])
	end
	for k, v in pairs(StrXPatchArr) do -- STRXPtr,Deviation,CTextData
		if v[2]==0 then
			f_Memcpy(FP,v[1],_TMem(Arr(v[3][3],0),"X","X",1),v[3][2])
		else
			f_Memcpy(FP,_Add(v[1],v[2]),_TMem(Arr(v[3][3],0),"X","X",1),v[3][2])
		end
	end
end
function init_Setting()
	CJump(FP, CustominitJump)
	init_StrX()
	DoActionsX(FP,{SetNext(initTrigIndex, initTrigIndex,1),SetNext("X", initTrigIndex,1)},1,lastTrigIndex)--RecoverNext

	local SCJump = def_sIndex()
	CJump(FP,SCJump)
	SetCall2(FP, Call_IToDec)
	ItoDec(FP,publicItoDecV,VArr(publicItoDecVArr,0),2,nil,0)
	SetCallEnd2()
	CJumpEnd(FP,SCJump)
	


	CJumpEnd(FP, CustominitJump)
end
function Start_init()
	CustominitJump = def_sIndex()
	initTrigIndex = FuncAlloc
	FuncAlloc=FuncAlloc+1
	lastTrigIndex = FuncAlloc
	FuncAlloc=FuncAlloc+1
	StrXKeyArr = {}
	StrXPatchArr = {}
	StrXIndex = 0
	publicItoDecVArr =CreateVArr(4,FP)
	publicItoDecV = CreateVar(FP)
	Call_IToDec = CreateCallIndex()
	
	DoActionsX(FP, {SetNext("X", CustominitJump+JumpStartAlloc,1),SetNext(lastTrigIndex, "X",1)}, 1,initTrigIndex)
end


function Print_13_2(PlayerID,DisplayPlayer,String)
	local X = {}
	local Y = {}
	PlayerID = PlayerConvert(PlayerID)
	if type(DisplayPlayer) == "number" then
		temp = {DisplayPlayer}
		DisplayPlayer = temp
	end
	for k, P in pairs(DisplayPlayer) do
		table.insert(X,CreateUnit(1,0,"Anywhere",P))
	end
	if String ~= nil then
		table.insert(Y,print_utf8(12, 0, String))
	end
	CIf(PlayerID,Memory(0x628438,AtLeast,1))
		f_ReadX(PlayerID,0x628438,V(FuncAlloc),1,0xFFFFFF)
		DoActionsX(PlayerID,{SetMemory(0x628438,SetTo,0),X,Y})
		CVariable2(PlayerID,FuncAlloc,0x628438,SetTo,0)
	CIfEnd()
	FuncAlloc = FuncAlloc + 1
end

function KeyToggleFunc2(KeyName,KeyName2)
	local KeyToggle = CreateCcode()
	local KeyToggle2 = CreateCcode()
	TriggerX(FP, {Memory(0x68C144,Exactly,0),KeyPress(KeyName, "Up")}, {SetCD(KeyToggle,0)}, {preserved})
	TriggerX(FP, {Memory(0x68C144,Exactly,0),KeyPress(KeyName2, "Down"),KeyPress(KeyName, "Down"),CD(KeyToggle,0),CD(KeyToggle2,0)},{SetCD(KeyToggle,1),SetCD(KeyToggle2,1)}, {preserved})
	TriggerX(FP, {Memory(0x68C144,Exactly,0),KeyPress(KeyName2, "Down"),KeyPress(KeyName, "Down"),CD(KeyToggle,0),CD(KeyToggle2,1)},{SetCD(KeyToggle,1),SetCD(KeyToggle2,0)}, {preserved})
	return KeyToggle2,KeyToggle
end
