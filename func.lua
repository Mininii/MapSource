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
	table.insert(X,Point) -- HPoint
	table.insert(HeroPointArr,X)
end
function InstallHeroPoint() -- CreateHeroPointArr에서 전송받은 영웅 포인트 정보 설치 함수. CunitCtrig 단락에 포함됨. 4213번 줄
	for i = 1, #HeroPointArr do
		local index = HeroPointArr[i][2]
		local Point = HeroPointArr[i][3]
		CIf(FP,Deaths(CurrentPlayer,Exactly,index,0,0xFF))
			DoActions(FP,MoveCp(Subtract,6*4))
			CIf(FP,DeathsX(CurrentPlayer,Exactly,7,0,0xFF))
				f_SaveCp()
				f_MemCpy(FP,HTextStrPtr,_TMem(Arr(HeroPointArr[i][1][3],0),"X","X",1),HeroPointArr[i][1][2])
				Trigger {
					players = {FP},
					conditions = {
						Label(0);
					},
					actions = {
						SetScore(Force1,Add,Point,Kills);
						RotatePlayer({DisplayTextX(HTextStr,4),PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg")},HumanPlayers,FP);
						PreserveTrigger();
					},
				}
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