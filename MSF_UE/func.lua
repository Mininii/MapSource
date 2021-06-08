function f_SaveCp()
	CallTrigger(FP,SaveCp_CallIndex,nil)
end
function f_LoadCp()
	CallTrigger(FP,LoadCp_CallIndex,nil)
end

function f_Repeat(Line)
	TriggerX(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,0)},{SetCVar(FP,Var_TempTable[Line][2],SetTo,0)},{Preserved})
	CIf(FP,CVar(FP,Var_TempTable[Line][2],AtLeast,1))
		CMov(FP,Spawn_TempW,Var_TempTable[Line])
		CallTrigger(FP,Call_Repeat)
		CDoActions(FP,{TSetMemory(_Add(G_TempH,((Line-1)*0x20)/4),SetTo,Spawn_TempW)})
	CIfEnd()
end

function f_TempRepeat(UnitID,Number,Condition)
	CallTriggerX(FP,Set_Repeat,Condition,{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,UnitID),SetCVar(FP,Repeat_TempV[2],SetTo,Number)})
end
function f_TempRepeatX(UnitID,Number,Condition)
	CDoActions(FP,{TSetCVar(FP,Gun_TempSpawnSet1[2],SetTo,UnitID),TSetCVar(FP,Repeat_TempV[2],SetTo,Number)})
	CallTriggerX(FP,Set_Repeat,Condition)
end
function Input_CSData(CSPtr,UnitID,UnitID2,Condition)
	if UnitID2 == nil then
		UnitID2 = 0
	end
	CTrigger(FP,{Condition},{
		SetMemory(0x6509B0,SetTo,CSPtr[1]),
		TSetCVar(FP,G_TempW[2],SetTo,CSPtr[2]),
		SetCVar(FP,Gun_TempSpawnSet3[2],SetTo,UnitID),
		SetCVar(FP,Gun_TempSpawnSet2[2],SetTo,UnitID2),
	},1)
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

function CustomShapeAlloc()
	local X = {}
	table.insert(X,VoidAlloc(300))
	table.insert(X,CreateVar())
	table.insert(CustomShapeTable,X)
	return X
end

function Install_CText1(StrPtr,CText1,CText2,PlayerVArr)

	f_MemCpy(FP,StrPtr,_TMem(Arr(CText1[3],0),"X","X",1),CText1[2]-3)
	f_MovCpy(FP,_Add(StrPtr,CText1[2]),VArr(PlayerVArr,0),4*6)
	f_MemCpy(FP,_Add(StrPtr,CText1[2]+(4*6)+3),_TMem(Arr(CText2[3],0),"X","X",1),CText2[2])

end


function CreateHeroPointArr(Index,Point,Name,Type) --  영작 유닛 설정 함수
	local TextType1 = "을(를) 처치하였다...! "
	local TextType2 = "를 획득하였다...! "
	if Type == 1 then
		Name2 = TextType1
	elseif Type == 2 then
		Name2 = TextType2
	
	elseif Type == nil then
		Name2 = nil
	else
		Need_Input_TextType()
	end
	local Text = "\x0D\x0D\x0D\x0D\x13\x04"..Name..""..Name2.."\x1F+ "..Point.." \x1CPoint \x07Get!\x0D\x0D\x0D\x0D\x14\x14\x14\x14\x14\x14\x14\x14"
	local X = {}
	table.insert(X,CreateCText(FP,Text))
	table.insert(X,Index)
	table.insert(X,CreateVar(Point)) -- HPoint
	table.insert(HeroPointArr,X)
end
function InstallHeroPoint() -- CreateHeroPointArr에서 전송받은 영웅 포인트 정보 설치 함수. CunitCtrig 단락에 포함됨.
	for i = 1, #HeroPointArr do
		local CT = HeroPointArr[i][1]
		local index = HeroPointArr[i][2]
		local Point = HeroPointArr[i][3]
		CIf(FP,DeathsX(CurrentPlayer,Exactly,index,0,0xFF))
			f_SaveCp()
			f_MemCpy(FP,HTextStrPtr,_TMem(Arr(CT[3],0),"X","X",1),CT[2])

			CDoActions(FP,{
				TSetScore(Force1,Add,Point,Kills);
				RotatePlayer({DisplayTextX(HTextStr,4),PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg")},HumanPlayers,FP);
			})

			f_MemCpy(FP,HTextStrPtr,_TMem(Arr(HTextStrReset[3],0),"X","X",1),HTextStrReset[2])
			f_LoadCp()
		CIfEnd()
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
					RotatePlayer({DisplayTextX(HTextStr,4),PlayWAVX("staredit\\wav\\die_se.ogg")},HumanPlayers,FP);
					SetScore(j-1,Add,1,Custom);
					SetCVar(FP,ExScore[j][2],Add,-50);

				})

				f_MemCpy(FP,HTextStrPtr,_TMem(Arr(HTextStrReset[3],0),"X","X",1),HTextStrReset[2])
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
					RotatePlayer({DisplayTextX(HTextStr,4),PlayWAVX("staredit\\wav\\die_se.ogg")},HumanPlayers,FP);
					SetScore(j-1,Add,1,Custom);
					SetCVar(FP,ExScore[j][2],Add,-500);
				})
				f_MemCpy(FP,HTextStrPtr,_TMem(Arr(HTextStrReset[3],0),"X","X",1),HTextStrReset[2])
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
	AddBGM(1,"staredit\\wav\\ExceedOP.ogg",99000)
	AddBGM(2,"staredit\\wav\\BGM1_1.ogg",42*1000,0)
	AddBGM(2,"staredit\\wav\\BGM1_2.ogg",42*1000,1)
	AddBGM(3,"staredit\\wav\\BGM2.ogg",47*1000)
	AddBGM(4,"staredit\\wav\\BGM3.ogg",60*1000)
	AddBGM(5,"staredit\\wav\\BGM4.ogg",60*1000)
	AddBGM(6,"staredit\\wav\\GRAVITY_OP.ogg",94*1000)
	AddBGM(7,"staredit\\wav\\BGM_SP.ogg",180*1000)

	CIf(FP,{CVar(FP,ReserveBGM[2],AtLeast,1),DeathsX(AllPlayers,AtMost,0,440,0xFFFFFF)})
		CMov(FP,BGMTypeV,ReserveBGM)
		CMov(FP,ReserveBGM,0)
	CIfEnd()
	Install_BGMSystem(FP,6,BGMTypeV)
end


function Install_RandPlaceHero()
	DoActionsX(FP,SetCVar(FP,RandW[2],SetTo,200),1)
	CWhile(FP,CVar(FP,RandW[2],AtLeast,1),SetCVar(FP,RandW[2],Subtract,1))
	
	Check_Spawn = def_sIndex()
	NJumpXEnd(FP,Check_Spawn)
	f_Mod(FP,HPosX,_Rand(),_Mov(3072))
	f_Mod(FP,HPosY,_Rand(),_Mov(6144))
	NJumpX(FP,Check_Spawn,{CVar(FP,HPosX[2],AtLeast,320),CVar(FP,HPosX[2],AtMost,2752),CVar(FP,HPosY[2],AtLeast,5408)}) -- 좌표설정 실패, 다시
	Simple_SetLocX(FP,0,HPosX,HPosY,HPosX,HPosY,Simple_CalcLoc(0,-64,-64,64,64))
	
	
	Check_Cannot = def_sIndex()
	NJumpX(FP,Check_Cannot,{Memory(0x628438,Exactly,0)}) -- 캔낫. 강제캔슬
	f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
	CDoActions(FP,{TCreateUnitWithProperties(1,VArr(HeroVArr,_Mod(_Rand(),_Mov(#HeroArr))),1,P8,{energy = 100})})
	NIfX(FP,{TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)}) -- 소환 성공 여부 
	CMov(FP,CunitIndex,_Div(_Sub(Nextptrs,19025),_Mov(84)))
	
	CTrigger(FP,{CVar(FP,Level[2],AtMost,10)},{TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(CC_Header,((0x20*8)/4))),SetTo,1)},1) -- 10레벨 이하는 영작포인트 적용됨
	
	NElseX()
	NJumpX(FP,Check_Spawn) -- 소환실패, 다시
	NIfXEnd()
	NJumpXEnd(FP,Check_Cannot)
	CWhileEnd()
end