
function Include_G_CB_Library(DefaultAttackLoc,StartIndex,Size_of_G_CB_Arr)
	
	if CPos == nil then PushErrorMsg("Need_Include_Conv_CPosXY") end
	if FP == nil then PushErrorMsg("Need_Define_Fixed_Player ( ex : FP = P8 )") end
	if GLocC == nil then PushErrorMsg("Need_Install_GetCLoc") end
	if TempRandRet == nil then PushErrorMsg("Need_Include_CRandNum") end
	if STRCTRIGASM == 1 then
		CA2ArrX = f_GetVArrptr(FP,1700)
		CA2ArrY = f_GetVArrptr(FP,1700)
		CA2ArrZ = f_GetVArrptr(FP,1700)
	else
		CA2ArrX = CreateVArr(1700,FP)
		CA2ArrY = CreateVArr(1700,FP)
		CA2ArrZ = CreateVArr(1700,FP)
	end
	if DefaultAttackLoc == nil then
		PushErrorMsg("G_CB_DefaultXY_InputData_Error")
	end
f_RepeatTypeErr = "\x07『 \x08ERROR : \x04잘못된 RepeatType이 입력되었습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
f_RepeatErr = "\x07『 \x08ERROR : \x04f_Repeat에서 문제가 발생했습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
f_RepeatErr2 = "\x07『 \x08ERROR : \x04Set_Repeat에서 잘못된 UnitID(0)을 입력받았습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
f_GunSendErrT = "\x07『 \x08ERROR \x04: G_CB_SpawnSet 목록이 가득 차 데이터를 입력하지 못했습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
G_CB_PosErr = "\x07『 \x03CAUCTION : \x04생성 좌표가 맵 밖을 벗어났습니다.\x07 』"
f_GunFuncT = "\x07『 \x03TESTMODE OP \x04: G_CBPlot Suspended. \x07』"
f_GunFuncT2 = "\x07『 \x03TESTMODE OP \x04: G_CBPlot All Suspended. \x07』"
f_GunSpawnSet = "\x07『 \x03TESTMODE OP \x04: G_CBPlot SpawnSet Initiation. \x07』"
f_GunErrT = "\x07『 \x08ERROR \x04: G_CBPlot Not Found. \x07』"
local Gun_TempSpawnSet1 = CreateVar(FP)
local Spawn_TempW = CreateVar(FP)
local RepeatType = CreateVar(FP)
G_CB_Nextptrs = CreateVar(FP)
G_CB_NextptrsP = CreateVar(FP)
local Repeat_TempV = CreateVar(FP)
local CreatePlayer = CreateVar(FP)
local CA_Repeat_Check = CreateCcode()
local TRepeatX,TRepeatY = CreateVars(2,FP)
local NQOption = CreateVar(FP)
CA_Repeat_X = CreateVar(FP)
CA_Repeat_Y = CreateVar(FP)
G_CB_BackupX = CreateVar(FP)
G_CB_BackupY = CreateVar(FP)
G_CB_X = CreateVar(FP)
G_CB_Y = CreateVar(FP)
G_CB_Shapes = {}
G_CB_ShapeIndexAlloc = 1
G_CB_RotateV = CreateVar(FP)
Call_RepeatOption = SetCallForward()
SetCall(FP)
RBX = CreateVar(FP)
RBY = CreateVar(FP)
RUID = CreateVar(FP)
RPID = CreateVar(FP)
RType = CreateVar(FP)
RPtr = CreateVar(FP)
RPtrP = CreateVar(FP)
RLocV = CreateVar(FP)
QueueOX = CreateVar(FP)
QueueOY = CreateVar(FP)
CIf(FP,{TMemoryX(_Add(RPtr,40),AtLeast,150*16777216,0xFF000000)})
		
		--CIf(FP,{TTOR({CV(RUID,25),CV(RUID,30)})})
		--CDoActions(FP,{
		--	TSetDeathsX(_Add(RPtr,72),SetTo,0xFF*256,0,0xFF00),TSetMemoryX(_Add(RPtr,68), SetTo, 600,0xFFFF)})
		--CIfEnd()
		local CunitIndex2 = CreateVar(FP)
		CMov(FP,CunitIndex,_Div(_Sub(RPtr,19025),_Mov(84)))
		f_Mul(FP,CunitIndex2, CunitIndex, 0x970/4)
		CDoActions(FP, {
			TSetMemoryX(_Add(RPtr,9),SetTo,0,0xFF0000),
			TSetMemory(_Add(CunitIndex2,_Add(UnivCunit[3],((0x20*4)/4))),SetTo, 0),
			TSetMemory(_Add(CunitIndex2,_Add(UnivCunit[3],((0x20*5)/4))),SetTo, 0),
			TSetMemory(_Add(CunitIndex2,_Add(UnivCunit[3],((0x20*2)/4))),SetTo, 0),
			TSetMemory(_Add(CunitIndex2,_Add(UnivCunit[3],((0x20*8)/4))),SetTo, 0),
			TSetMemory(_Add(CunitIndex2,_Add(UnivCunit[3],((0x20*9)/4))),SetTo, 0),
			TSetMemory(_Add(CunitIndex2,_Add(UnivCunit[3],((0x20*10)/4))),SetTo, 0),
		})

		f_Read(FP,_Add(RPtr,10),CPos)
		Convert_CPosXY()
		Simple_SetLocX(FP,71,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(71,-4,-4,4,4)})
		CIfX(FP,{CVar(FP,RType[2],AtLeast,200),CVar(FP,RType[2],AtMost,203)})
		if DLC_Project == 1 then
			CTrigger(FP,{CVar(FP,RType[2],Exactly,200),CD(GMode,2,AtMost)},{Simple_SetLoc(200, 1888, 2928, 1888, 2928),TMoveUnit(1,RUID,RPID,72,201)},{preserved})
			CTrigger(FP,{CVar(FP,RType[2],Exactly,201),CD(GMode,2,AtMost)},{Simple_SetLoc(200, 96, 4112, 96, 4112),TMoveUnit(1,RUID,RPID,72,201)},{preserved})
			CTrigger(FP,{CVar(FP,RType[2],Exactly,202),CD(GMode,2,AtMost)},{Simple_SetLoc(200, 1024, 7568, 1024, 7568),TMoveUnit(1,RUID,RPID,72,201)},{preserved})
			CTrigger(FP,{CVar(FP,RType[2],Exactly,200),CD(GMode,3)},{TMoveUnit(1,RUID,RPID,72,1)},{preserved})
			CTrigger(FP,{CVar(FP,RType[2],Exactly,201),CD(GMode,3)},{TMoveUnit(1,RUID,RPID,72,1)},{preserved})
			CTrigger(FP,{CVar(FP,RType[2],Exactly,202),CD(GMode,3)},{TMoveUnit(1,RUID,RPID,72,1)},{preserved})
		else
			CTrigger(FP,{CVar(FP,RType[2],Exactly,200)},{Simple_SetLoc(200, 1888, 2928, 1888, 2928),TMoveUnit(1,RUID,RPID,72,201)},{preserved})
			CTrigger(FP,{CVar(FP,RType[2],Exactly,201)},{Simple_SetLoc(200, 96, 4112, 96, 4112),TMoveUnit(1,RUID,RPID,72,201)},{preserved})
			CTrigger(FP,{CVar(FP,RType[2],Exactly,202)},{Simple_SetLoc(200, 1024, 7568, 1024, 7568),TMoveUnit(1,RUID,RPID,72,201)},{preserved})
		end

        CTrigger(FP,{CVar(FP,RType[2],Exactly,203)},{Simple_SetLoc(200, 288,3792,288,3792),TMoveUnit(1,RUID,RPID,72,201)},{preserved})

		CElseX()
        CTrigger(FP,{},{TMoveUnit(1,RUID,RPID,72,1)},{preserved})
		CIfXEnd()
		RTypeDupeCheck = {}
		RTypeKey = {}
		function CElseIfX_AddRepeatType(TypeNum,TypeString)
			if RTypeDupeCheck[TypeNum] == nil then 
				if TypeString ~=nil then
					RTypeDupeCheck[TypeNum] = TypeString
					RTypeKey[TypeString] = TypeNum
				else
					RTypeDupeCheck[TypeNum] = true
				end
			 else PushErrorMsg("RepeatTypeNum_Duplicated") end
			 CElseIfX({CVar(FP,RType[2],Exactly,TypeNum)})
		end
		
		function CElseIfX_AddRepeatType_LR(TypeNumL,TypeNumR,TypeString)
			
			for i = TypeNumL,TypeNumR,1 do
				if RTypeDupeCheck[i] == nil then 
					if TypeString ~=nil then
						RTypeDupeCheck[i] = TypeString[i-TypeNumL+1]
						RTypeKey[TypeString] = i
					else
						RTypeDupeCheck[i] = true
					end
				 else PushErrorMsg("RepeatTypeNum_Duplicated") end
				
			end
			CElseIfX({CVar(FP,RType[2],AtLeast,TypeNumL),CVar(FP,RType[2],AtMost,TypeNumR)})
		end
			CIfX(FP,CVar(FP,RType[2],Exactly,0))
				f_Read(FP,_Add(RPtr,10),CPos)
				Convert_CPosXY()
				Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
				CTrigger(FP, {}, {TOrder(RUID, RPID, 1, Attack, RLocV);}, {preserved})
			CElseIfX_AddRepeatType(5,"Attack_HP10")
			
			f_Read(FP,_Add(RPtr,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CTrigger(FP, {}, {TOrder(RUID, RPID, 1, Attack, RLocV);TSetMemory(_Add(RPtr,2), SetTo, _Div(_ReadF(_Add(RUID,EPD(0x662350))),10)),}, {preserved})
			CElseIfX_AddRepeatType(6,"BanUnit")
			CDoActions(FP,{TSetMemoryX(_Add(RPtr,35),SetTo,6*16777216,0xFF000000)})
			
			CElseIfX_AddRepeatType(1,"Attack_HP50")
			f_Read(FP,_Add(RPtr,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CTrigger(FP, {}, {TOrder(RUID, RPID, 1, Attack, RLocV);}, {preserved})
			CDoActions(FP,{
				TSetMemory(_Add(RPtr,2), SetTo, _Div(_ReadF(_Add(RUID,EPD(0x662350))),2)),
			})
			
			CElseIfX_AddRepeatType(168,"Attack_Cell")
			f_Read(FP,_Add(RPtr,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			DoActions(FP,{Simple_SetLoc(20,288,3792,288,3792)})
			CDoActions(FP, {TOrder(RUID, RPID, 1, Attack, 21);})
			


			CElseIfX_AddRepeatType(187,"JYD")
			CIfX(FP,{TTOR({CV(RUID,86),CV(RUID,71)})})
			f_Read(FP,_Add(RPtr,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CDoActions(FP, {
			Set_EXCC2(UnivCunit, CunitIndex, 5, SetTo, 7);--잠시후 정야독
			Set_EXCC2(UnivCunit, CunitIndex, 2, SetTo, 3);
			Set_EXCC2(UnivCunit, CunitIndex, 8, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 9, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 10, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 11, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 12, SetTo, 0);})	
			CElseX()
				CDoActions(FP,{
					TSetDeathsX(_Add(RPtr,19),SetTo,187*256,0,0xFF00),
				})
			CIfXEnd()
			CElseIfX_AddRepeatType(188,"JYD_HP10")
			
			CIfX(FP,{TTOR({CV(RUID,86),CV(RUID,71)})})
			f_Read(FP,_Add(RPtr,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CDoActions(FP, {
			Set_EXCC2(UnivCunit, CunitIndex, 5, SetTo, 7);--잠시후 정야독
			Set_EXCC2(UnivCunit, CunitIndex, 2, SetTo, 3);
			Set_EXCC2(UnivCunit, CunitIndex, 8, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 9, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 10, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 11, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 12, SetTo, 0);})	
			CElseX()
				CDoActions(FP,{
					TSetDeathsX(_Add(RPtr,19),SetTo,187*256,0,0xFF00),
				})
			CIfXEnd()

			CDoActions(FP,{
				TSetMemory(_Add(RPtr,2), SetTo, _Div(_ReadF(_Add(RUID,EPD(0x662350))),10)),
			})
			CElseIfX_AddRepeatType_LR(200,203,{"Gene1","Gene2","Gene3","EnemyStorm"})
			local NPosX, NPosY = CreateVars(2, FP)
			local SpeedRet = CreateVar(FP)

			f_Read(FP,_Add(RPtr,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			
			CiSub(FP,CPosX,QueueOX)
			CiSub(FP,CPosY,QueueOY)
			f_Sqrt(FP, SpeedRet, _Div(_Add(_Square(CPosX),_Square(CPosY)),_Mov(2)))
			CDoActions(FP,{
				--TOrder(RUID, RPID, 1, Move, 64);
				TSetMemoryX(_Add(RPtr,8),SetTo,127*65536,0xFF0000),
				TSetMemory(_Add(RPtr,13),SetTo,SpeedRet),
				TSetMemoryX(_Add(RPtr,18),SetTo,SpeedRet,0xFFFF),
				SetDeaths(_Add(RPtr,23),SetTo,0,0),
				SetDeathsX(_Add(RPtr,19),SetTo,14*256,0,0xFF00),
				TSetDeaths(_Add(RPtr,4),SetTo,_Add(QueueOX,_Mul(QueueOY,65536)),0),
				TSetDeaths(_Add(RPtr,6),SetTo,_Add(QueueOX,_Mul(QueueOY,65536)),0),
				--TSetDeaths(_Add(RPtr,7),SetTo,_Add(QueueOX,_Mul(QueueOY,65536)),0),
				TSetDeaths(_Add(RPtr,22),SetTo,_Add(QueueOX,_Mul(QueueOY,65536)),0),
			})
			CIf(FP,{CVar(FP,RType[2],AtLeast,200),CVar(FP,RType[2],AtMost,202)})--fCGive후 타이머 어택
			
			if DLC_Project ==1 then
				CIf(FP,{CD(GMode,2,AtMost)})
					f_CGive(FP, RPtr, nil, P9, RPID)
				CIfEnd()
				CTrigger(FP,{CD(GMode,2,AtMost)},{TSetMemoryX(_Add(RPtr,55),SetTo,0x4000000,0x4000000),
				TSetMemoryX(_Add(RPtr,9),SetTo,0,0xFF0000),
				TSetMemoryX(_Add(RPtr,72),SetTo,0xFF*256,0xFF00),
				TSetMemoryX(_Add(RPtr,55),SetTo,0xA00000,0xA00000),
				Set_EXCC2(UnivCunit, CunitIndex, 5, SetTo, 3);--f_CGive 해제후 공격
				Set_EXCC2(UnivCunit, CunitIndex, 2, SetTo, 480);
				Set_EXCC2(UnivCunit, CunitIndex, 8, SetTo, 0);
				Set_EXCC2(UnivCunit, CunitIndex, 9, SetTo, 0);
				Set_EXCC2(UnivCunit, CunitIndex, 10, SetTo, 0);
				Set_EXCC2(UnivCunit, CunitIndex, 11, SetTo, 0);
				Set_EXCC2(UnivCunit, CunitIndex, 12, SetTo, 0);}
			,{preserved})


				CTrigger(FP,{CD(GMode,3)},{TSetMemoryX(_Add(RPtr,55),SetTo,0x4000000,0x4000000),
				TSetMemoryX(_Add(RPtr,9),SetTo,0,0xFF0000),
				TSetMemoryX(_Add(RPtr,72),SetTo,0xFF*256,0xFF00),
				--TSetMemoryX(_Add(RPtr,55),SetTo,0xA00000,0xA00000),
				Set_EXCC2(UnivCunit, CunitIndex, 5, SetTo, 3);--f_CGive 해제후 공격
				Set_EXCC2(UnivCunit, CunitIndex, 2, SetTo, 3);
				Set_EXCC2(UnivCunit, CunitIndex, 8, SetTo, 0);
				Set_EXCC2(UnivCunit, CunitIndex, 9, SetTo, 0);
				Set_EXCC2(UnivCunit, CunitIndex, 10, SetTo, 0);
				Set_EXCC2(UnivCunit, CunitIndex, 11, SetTo, 0);
				Set_EXCC2(UnivCunit, CunitIndex, 12, SetTo, 0);},{preserved})
			else
				
			CDoActions(FP,{TSetMemoryX(_Add(RPtr,55),SetTo,0x4000000,0x4000000),
			TSetMemoryX(_Add(RPtr,9),SetTo,0,0xFF0000),
			TSetMemoryX(_Add(RPtr,72),SetTo,0xFF*256,0xFF00),
			TSetMemoryX(_Add(RPtr,55),SetTo,0xA00000,0xA00000),
			Set_EXCC2(UnivCunit, CunitIndex, 5, SetTo, 3);--f_CGive 해제후 공격
			Set_EXCC2(UnivCunit, CunitIndex, 2, SetTo, 480);
			Set_EXCC2(UnivCunit, CunitIndex, 8, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 9, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 10, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 11, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 12, SetTo, 0);
		 })
			end
			CIfEnd()
			CIf(FP,{CV(RType,203)},{TSetMemoryX(_Add(RPtr,55),SetTo,0x4000000,0x4000000)})
			f_CGive(FP, RPtr, nil, P9, RPID)
			CDoActions(FP, {TSetMemoryX(_Add(RPtr,55),SetTo,0x4000000,0x4000000),
			TSetMemoryX(_Add(RPtr,9),SetTo,0,0xFF0000),
			TSetMemoryX(_Add(RPtr,72),SetTo,0xFF*256,0xFF00),
			TSetMemoryX(_Add(RPtr,55),SetTo,0xA00000,0xA00000),
			Set_EXCC2(UnivCunit, CunitIndex, 5, SetTo, 4);--f_CGive 해제후 정야독
			Set_EXCC2(UnivCunit, CunitIndex, 2, SetTo, 999999);
			Set_EXCC2(UnivCunit, CunitIndex, 8, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 9, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 10, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 11, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 12, SetTo, 0);
		})
			CIfEnd()
			CElseIfX_AddRepeatType(189,"gMAX1")
			
			f_CGive(FP, RPtr, nil, P9, RPID)
			CDoActions(FP, {TSetMemoryX(_Add(RPtr,55),SetTo,0x4000000,0x4000000),
			TSetMemoryX(_Add(RPtr,9),SetTo,0,0xFF0000),
			TSetMemoryX(_Add(RPtr,72),SetTo,0xFF*256,0xFF00),
			Set_EXCC2(UnivCunit, CunitIndex, 5, SetTo, 5);--f_CGive 해제후 공격
			Set_EXCC2(UnivCunit, CunitIndex, 2, SetTo, 999999);
			Set_EXCC2(UnivCunit, CunitIndex, 8, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 9, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 10, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 11, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 12, SetTo, 0);
		})

		CElseIfX_AddRepeatType(191,"gMAX2")
			
		f_CGive(FP, RPtr, nil, P9, RPID)
		CDoActions(FP, {TSetMemoryX(_Add(RPtr,55),SetTo,0x4000000,0x4000000),
		TSetMemoryX(_Add(RPtr,9),SetTo,0,0xFF0000),
		TSetMemoryX(_Add(RPtr,72),SetTo,0xFF*256,0xFF00),
		TSetMemoryX(_Add(RPtr,8),SetTo,127*65536,0xFF0000),
		TSetMemory(_Add(RPtr,13),SetTo,640),
		TSetMemoryX(_Add(RPtr,18),SetTo,640,0xFFFF),
		Set_EXCC2(UnivCunit, CunitIndex, 5, SetTo, 6);--f_CGive 해제후 정야독
		Set_EXCC2(UnivCunit, CunitIndex, 2, SetTo, 999999);
		Set_EXCC2(UnivCunit, CunitIndex, 8, SetTo, 0);
		Set_EXCC2(UnivCunit, CunitIndex, 9, SetTo, 0);
		Set_EXCC2(UnivCunit, CunitIndex, 10, SetTo, 0);
		Set_EXCC2(UnivCunit, CunitIndex, 11, SetTo, 0);
		Set_EXCC2(UnivCunit, CunitIndex, 12, SetTo, 0);
	})

			CElseIfX_AddRepeatType(84,"Explosion_Guard")
			CDoActions(FP,{
				TSetMemoryX(_Add(RPtr,55),SetTo,0xA00000,0xA00000),KillUnit(94,FP)
			})

			CElseIfX_AddRepeatType(129,"Era_Attack")
			GetLocCenter(201, NPosX, NPosY)
			
			f_Read(FP,_Add(RPtr,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CiSub(FP,CPosX,NPosX)
			CiSub(FP,CPosY,NPosY)
			f_Sqrt(FP, SpeedRet, _Div(_Add(_Square(CPosX),_Square(CPosY)),_Mov(5)))
			
			CDoActions(FP, {TSetMemoryX(_Add(RPtr,8),SetTo,127*65536,0xFF0000),
			TSetMemory(_Add(RPtr,13),SetTo,SpeedRet),
			TSetMemoryX(_Add(RPtr,18),SetTo,SpeedRet,0xFFFF),})
			Convert_CPosXY()
			CNeg(FP,CPosX)
			CAdd(FP,CPosX,32*64)
			CNeg(FP,CPosY)
			CAdd(FP,CPosY,32*256)
			Simple_SetLocX(FP,20,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CDoActions(FP, {TOrder(RUID, RPID, 1, Attack, 202);})
			CElseIfX_AddRepeatType(130,"Era_Patrol")
			f_Read(FP,_Add(RPtr,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			local SpeedRet = CreateVar(FP)
			CiSub(FP,CPosX,16*64)
			CiSub(FP,CPosY,16*256)
			f_Sqrt(FP, SpeedRet, _Div(_Add(_Square(CPosX),_Square(CPosY)),_Mov(5)))
			CDoActions(FP, {TSetMemoryX(_Add(RPtr,8),SetTo,127*65536,0xFF0000),
			TSetMemory(_Add(RPtr,13),SetTo,SpeedRet),
			TSetMemoryX(_Add(RPtr,18),SetTo,SpeedRet,0xFFFF),})
			Convert_CPosXY()
			CNeg(FP,CPosX)
			CAdd(FP,CPosX,32*64)
			CNeg(FP,CPosY)
			CAdd(FP,CPosY,32*256)
			Simple_SetLocX(FP,20,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CDoActions(FP, {TOrder(RUID, RPID, 1, Patrol, 21);})
			CDoActions(FP, {
			Set_EXCC2(UnivCunit, CunitIndex, 5, SetTo, 7);--60초후 정야독
			Set_EXCC2(UnivCunit, CunitIndex, 2, SetTo, 480*3);
			Set_EXCC2(UnivCunit, CunitIndex, 8, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 9, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 10, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 11, SetTo, 0);
			Set_EXCC2(UnivCunit, CunitIndex, 12, SetTo, 0);
		})
		
			CElseIfX_AddRepeatType(131,"GMAX_Era_Patrol")
			GetLocCenter(5, NPosX, NPosY)
			
			f_Read(FP,_Add(RPtr,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CiSub(FP,CPosX,NPosX)
			CiSub(FP,CPosY,NPosY)
			f_Sqrt(FP, SpeedRet, _Div(_Add(_Square(CPosX),_Square(CPosY)),_Mov(2)))
			
			CDoActions(FP, {TSetMemoryX(_Add(RPtr,8),SetTo,127*65536,0xFF0000),
			TSetMemory(_Add(RPtr,13),SetTo,SpeedRet),
			TSetMemoryX(_Add(RPtr,18),SetTo,SpeedRet,0xFFFF),})
			Convert_CPosXY()
			CNeg(FP,CPosX)
			CAdd(FP,CPosX,32*64)
			CNeg(FP,CPosY)
			CAdd(FP,CPosY,32*256)
			Simple_SetLocX(FP,20,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CDoActions(FP, {TOrder(RUID, RPID, 1, Patrol, 6);})
			CElseIfX_AddRepeatType(3,"Timer_Attack")
			CDoActions(FP, {
				TSetMemoryX(_Add(RPtr,9),SetTo,0,0xFF0000),
				Set_EXCC2(UnivCunit, CunitIndex, 5, SetTo, 1);
				Set_EXCC2(UnivCunit, CunitIndex, 2, SetTo, 240);
				Set_EXCC2(UnivCunit, CunitIndex, 8, SetTo, 0);
				Set_EXCC2(UnivCunit, CunitIndex, 9, SetTo, 0);
				Set_EXCC2(UnivCunit, CunitIndex, 10, SetTo, 0);
				Set_EXCC2(UnivCunit, CunitIndex, 11, SetTo, 0);
				Set_EXCC2(UnivCunit, CunitIndex, 12, SetTo, 0);
			})

			CElseIfX_AddRepeatType(4,"Timer_Attack_Gun")
			CDoActions(FP, {
				TSetMemoryX(_Add(RPtr,9),SetTo,0,0xFF0000),
				Set_EXCC2(UnivCunit, CunitIndex, 5, SetTo, 2);
				Set_EXCC2(UnivCunit, CunitIndex, 2, SetTo, 240);
				Set_EXCC2(UnivCunit, CunitIndex, 8, SetTo, 0);
				Set_EXCC2(UnivCunit, CunitIndex, 9, SetTo, 0);
				Set_EXCC2(UnivCunit, CunitIndex, 10, SetTo, 0);
				Set_EXCC2(UnivCunit, CunitIndex, 11, SetTo, RBX);
				Set_EXCC2(UnivCunit, CunitIndex, 12, SetTo, RBY);
			})
			CElseIfX_AddRepeatType(14,"Attack_Gun")
			f_Read(FP,_Add(RPtr,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			Simple_SetLocX(FP,20,RBX,RBY,RBX,RBY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CDoActions(FP, {TOrder(RUID, RPID, 1, Attack, 21);})
			CElseIfX_AddRepeatType(140,"Patrol_Gun")
			f_Read(FP,_Add(RPtr,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			Simple_SetLocX(FP,20,RBX,RBY,RBX,RBY,{Simple_CalcLoc(0,-4,-4,4,4)})
			if X4_Mode ==1 then
				CDoActions(FP, {TOrder(RUID, RPID, 1, Attack, 21);})
			else
				CDoActions(FP, {TOrder(RUID, RPID, 1, Patrol, 21);})
			end

			CElseIfX_AddRepeatType(217,"Walls")
			CDoActions(FP, {
				Set_EXCC2(DUnitCalc, CunitIndex, 1, SetTo, 1);
			})
			CElseIfX_AddRepeatType(218,"MAXHP")
			CDoActions(FP,{TSetMemory(_Add(RPtr,2), SetTo, 8380000*256)})
			CElseIfX(CVar(FP,RType[2],Exactly,2))
			CElseX()
				DoActions(FP,RotatePlayer({DisplayTextX("\x07『 \x08ERROR : \x04잘못된 RepeatType이 입력되었습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』",4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP))
			CIfXEnd()
			--Simple_SetLocX(FP,0,G_CB_BackupX,G_CB_BackupY,G_CB_BackupX,G_CB_BackupY,{Simple_CalcLoc(0,-4,-4,4,4)})
			--CDoActions(FP,{TOrder(RUID,RPID,72,Attack,1)})
			
		CIfEnd()
SetCallEnd()



Call_Repeat = SetCallForward()
SetCall(FP)
DefaultAttackLocV = CreateVar(FP)
CWhile(FP,{CVar(FP,Spawn_TempW[2],AtLeast,1)})
	if X4_Mode == 1 then
	CIfX(FP,{TTNVar(Gun_TempSpawnSet1,NotSame,94,0xFF)})
	CFor(FP,0,5,1)
	end
	CMov(FP,DefaultAttackLocV,DefaultAttackLoc)
		QueueX = CreateVar(FP)
		QueueY = CreateVar(FP)
		CIf(FP,{CDeaths(FP,Exactly,0,CA_Repeat_Check)})
		CIfX(FP,{CVar(FP,TRepeatX[2],AtMost,0x7FFFFFFF-5)})

			Simple_SetLocX(FP,0,TRepeatX,TRepeatY,TRepeatX,TRepeatY)
			CMov(FP,QueueX,TRepeatX)
			CMov(FP,QueueY,TRepeatY)

		CElseIfX(CVar(FP,TRepeatX[2],AtLeast,0x80000000-5))
		Simple_SetLocX(FP,0,G_CB_X,G_CB_Y,G_CB_X,G_CB_Y)
		CMov(FP,QueueX,G_CB_X)
		CMov(FP,QueueY,G_CB_Y)

		CIfXEnd()
		CIfEnd()


		CIf(FP,{CD(CA_Repeat_Check,1)})
		f_SHRead(FP, 0x58DC60, QueueX)
		f_SHRead(FP, 0x58DC64, QueueY)
		CMov(FP, CA_Repeat_X,QueueX)
		CMov(FP, CA_Repeat_Y,QueueY)
		CIfEnd()

		CIfX(FP,{CV(NQOption,0)}) -- 큐를 사용하여 소환할경우(일반적)
		local BX, BY = CreateVars(2,FP)
			--DisplayPrint(HumanPlayers, {"Queue Executed. X : ",QueueX,"  Y : ",QueueY,"  UID : ",Gun_TempSpawnSet1})
		CDoActions(FP,{
			TSetMemory(_Add(CreateUnitQueueXPosArr,CreateUnitQueuePtr),SetTo,QueueX),
			TSetMemory(_Add(CreateUnitQueueYPosArr,CreateUnitQueuePtr),SetTo,QueueY),
			TSetMemory(_Add(CreateUnitQueueUIDArr,CreateUnitQueuePtr),SetTo,_Mov(Gun_TempSpawnSet1,0xFF)),
			TSetMemory(_Add(CreateUnitQueuePIDArr,CreateUnitQueuePtr),SetTo,CreatePlayer),
			TSetMemory(_Add(CreateUnitQueueTypeArr,CreateUnitQueuePtr),SetTo,RepeatType),
			TSetMemory(_Add(CreateUnitQueueBakXPosArr,CreateUnitQueuePtr),SetTo,BX),
			TSetMemory(_Add(CreateUnitQueueBakYPosArr,CreateUnitQueuePtr),SetTo,BY),
		})
		DoActionsX(FP,{AddV(CreateUnitQueueNum,1),AddV(CreateUnitQueuePtr,1)})
		TriggerX(FP, {CV(CreateUnitQueuePtr,QueueMaxSize,AtLeast)},{SetV(CreateUnitQueuePtr,0),},{preserved})
		CElseIfX({Memory(0x628438,AtLeast,1)})--큐를 사용하지 않고 소환할경우(무적버그, 큐에 이펙트유닛 쌓이는거 등 방지)
		
		NIf(FP,{CV(Gun_TempSpawnSet1,0,AtLeast),CV(Gun_TempSpawnSet1,226,AtMost)})
		local CRLID = CreateVar(FP)

		
		DoActions(FP,{SetSwitch(RandSwitch1,Random),SetSwitch(RandSwitch2,Random)})
		
		local LocIndex = FuncAlloc
			for i = 0, 3 do
				if i == 0 then RS1 = Cleared RS2=Cleared end
				if i == 1 then RS1 = Set RS2=Cleared end
				if i == 2 then RS1 = Cleared RS2=Set end
				if i == 3 then RS1 = Set RS2=Set end
				TriggerX(FP,{Switch(RandSwitch1,RS1),Switch(RandSwitch2,RS2)},{SetCtrig1X("X",FuncAlloc,CAddr("Mask",1),nil,SetTo,16+i),SetCtrig1X("X",FuncAlloc+1,CAddr("Mask",1),nil,SetTo,16+i)},{preserved})
			end
		CDoActions(FP, {
			SetMemoryB(0x6644F8+4,SetTo,158),
			SetMemoryB(0x6C9858+158,SetTo,2),
			SetMemoryB(0x6644F8+6,SetTo,200),
			SetMemory(0x66EC48+(541*4), SetTo, 91),
			SetMemory(0x66EC48+(956*4), SetTo, 91),
			
			TSetMemory(_Add(Gun_TempSpawnSet1,EPDF(0x662860)) ,SetTo,1+65536),
		})
		f_Read(FP,0x628438,G_CB_NextptrsP,G_CB_Nextptrs,0xFFFFFF)
			TriggerX(FP,{CVar(FP,CreatePlayer[2],Exactly,0xFFFFFFFF)},{SetCVar(FP,CreatePlayer[2],SetTo,7)},{preserved})
			CTrigger(FP,{TTCVar(FP,RepeatType[2],NotSame,2)},{TCreateUnitWithProperties(1,Gun_TempSpawnSet1,1,CreatePlayer,{energy = 100})},1,LocIndex)
			CTrigger(FP,{CVar(FP,RepeatType[2],Exactly,2)},{TCreateUnitWithProperties(1,Gun_TempSpawnSet1,1,CreatePlayer,{energy = 100, burrowed = true})},1,LocIndex+1)
		DoActions(FP, {
			SetMemoryB(0x6644F8+4,SetTo,76),
			SetMemoryB(0x6644F8+6,SetTo,83),
			SetMemoryB(0x6C9858+158,SetTo,0),
			SetMemory(0x66EC48+(956*4), SetTo, 377),
			SetMemory(0x66EC48+(541*4), SetTo, 247),
		})
		FuncAlloc=FuncAlloc+2
		Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
		CMov(FP,QueueOX,CPosX)
		CMov(FP,QueueOY,CPosY)
		CMov(FP,RUID,Gun_TempSpawnSet1)
		CMov(FP,RPID,CreatePlayer)
		CMov(FP,RType,RepeatType)
		CMov(FP,RPtr,G_CB_Nextptrs)
		CMov(FP,RPtrP,G_CB_NextptrsP)
		
		CMov(FP,RLocV,DefaultAttackLocV)
		CallTrigger(FP, Call_RepeatOption)
		NIfEnd()
		
		CIfXEnd()



		
		CIf(FP,{CDeaths(FP,Exactly,0,CA_Repeat_Check)})
			CIfX(FP,{CVar(FP,TRepeatX[2],AtMost,0x7FFFFFFF-5)})
				Simple_SetLocX(FP,0,TRepeatX,TRepeatY,TRepeatX,TRepeatY)
			CElseIfX(CVar(FP,TRepeatX[2],AtLeast,0x80000000-5))
				Simple_SetLocX(FP,0,G_CB_X,G_CB_Y,G_CB_X,G_CB_Y)
			CElseX()
				Simple_SetLocX(FP,0,3712,288,3712,288)
			CIfXEnd()
		CIfEnd()
		

--Queue



		CIf(FP,{CD(CA_Repeat_Check,1),CV(Spawn_TempW,2,AtLeast)})
		Simple_SetLocX(FP,0,CA_Repeat_X,CA_Repeat_Y,CA_Repeat_X,CA_Repeat_Y)
		CIfEnd()

	CSub(FP,Spawn_TempW,1)
	if X4_Mode == 1 then
		CForEnd()
		CElseX()
		CMov(FP,Spawn_TempW,0)
		CIfXEnd()
	end
CWhileEnd()


CMov(FP,RepeatType,0)
SetCallEnd()
function f_TempRepeat(Condition,UnitID,Number,Type,Owner,CenterXY,Flags,NQOp)
	
	if type(UnitID) == "string" then
		UnitID = ParseUnitNameT[UnitID]
	end

	if Owner == nil then Owner = 0xFFFFFFFF end
	if NQOp == nil then NQOp = 0 end
	if Type == nil then Type = 0 end
	local SetX = 0 
	local SetY = 0
	if type(CenterXY) == "table" then
		SetX = CenterXY[1]
		SetY = CenterXY[2]
	elseif CenterXY == nil then
		SetX = 0xFFFFFFFF
		SetY = 0xFFFFFFFF

	elseif CenterXY == "CG" then
		SetX = 0x80000000
		SetY = 0x80000000
	else
		PushErrorMsg("TRepeat_CenterXY_Error")
	end
	CallTriggerX(FP,Set_Repeat,Condition,{
		SetCDeaths(FP,SetTo,0,CA_Repeat_Check),
		SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,UnitID),
		SetCVar(FP,Repeat_TempV[2],SetTo,Number),
		SetCVar(FP,RepeatType[2],SetTo,Type),
		SetCVar(FP,CreatePlayer[2],SetTo,Owner),
		SetCVar(FP,TRepeatX[2],SetTo,SetX),
		SetCVar(FP,TRepeatY[2],SetTo,SetY),
		SetCVar(FP,NQOption[2],SetTo,NQOp),
	},Flags)

end

function f_TempRepeatX(Condition,UnitID,Number,Type,Owner,CenterXY,Flags,NQOp)
	if Owner == nil then Owner = 0xFFFFFFFF end
	if NQOp == nil then NQOp = 0 end
	if Type == nil then Type = 0 end
	local SetX = 0 
	local SetY = 0
	if CenterXY == nil then 
		SetX = 0xFFFFFFFF
		SetY = 0xFFFFFFFF
	elseif type(CenterXY) == "table" then
		SetX = CenterXY[1]
		SetY = CenterXY[2]
	elseif CenterXY == "CG" then
		SetX = 0x80000000
		SetY = 0x80000000
	else
		PushErrorMsg("TRepeat_CenterXY_Error")
	end
	CDoActions(FP,{
		TSetCVar(FP,Gun_TempSpawnSet1[2],SetTo,UnitID),
		TSetCVar(FP,Repeat_TempV[2],SetTo,Number),
		TSetCVar(FP,TRepeatX[2],SetTo,SetX),
		TSetCVar(FP,TRepeatY[2],SetTo,SetY),
		SetCVar(FP,RepeatType[2],SetTo,Type),
		SetCDeaths(FP,SetTo,0,CA_Repeat_Check),
		SetCVar(FP,CreatePlayer[2],SetTo,Owner),
		SetCVar(FP,NQOption[2],SetTo,NQOp),})
	CallTriggerX(FP,Set_Repeat,Condition,nil,Flags)
end
Set_Repeat = SetCallForward()
SetCall(FP)
--TriggerX(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,0)},{RotatePlayer({DisplayTextX(f_RepeatErr2,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP),SetCVar(FP,Repeat_TempV[2],SetTo,0)},{preserved})
TriggerX(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,256)},{SetCVar(FP,Repeat_TempV[2],SetTo,0)},{preserved})
CIf(FP,CVar(FP,Repeat_TempV[2],AtLeast,1))
	CMov(FP,Spawn_TempW,Repeat_TempV)
	CMov(FP,Repeat_TempV,0)
	CallTrigger(FP,Call_Repeat)
	CMov(FP,Spawn_TempW,0)
CIfEnd()
SetCallEnd()

local G_CB_LineV = CreateVar(FP)
local G_CB_CUTV = CreateVar(FP)
local G_CB_SNTV = CreateVarArr(4,FP)
local G_CB_DLTV = CreateVarArr(4,FP)
local G_CB_FNTV = CreateVar(FP)
local G_CB_LMTV = CreateVar(FP)
local G_CB_RPTV = CreateVar(FP)
local G_CB_CPTV = CreateVar(FP)
local G_CB_SZTV = CreateVar(FP)
local G_CB_RTTV = CreateVarArr(4,FP)
local G_CB_XPos = CreateVar(FP)
local G_CB_YPos = CreateVar(FP)
local G_CB_NQOption =CreateVar(FP)
local SL_TempV = Create_VTable(4)
local SL_Ret = CreateVar(FP)
local Write_SpawnSet_Jump = def_sIndex()
local G_CB_Arr_IndexAlloc = StartIndex
local G_CB_InputCVar = {}
local G_CB_Lines = 55
local G_CB_TempTable = CreateVarArr(G_CB_Lines,FP)
local G_CB_TempH = CreateVar(FP)
local G_CB_Num = CreateVar(FP)
for i = 1, G_CB_Lines do
	table.insert(G_CB_InputCVar,SetCVar(FP,G_CB_TempTable[i][2],SetTo,0))
end
local G_CB_InputH = CreateVar(FP)
local G_CB_LineTemp = CreateVar(FP)


table.insert(CtrigInitArr[FP+1],SetCtrigX(FP,G_CB_InputH[2],0x15C,0,SetTo,FP,StartIndex,0x15C,1,0))

Write_SpawnSet = SetCallForward()
SetCall(FP)
UnitIDV1,UnitIDV2,UnitIDV3,UnitIDV4 = CreateVars(4,FP)
local PatchCondArr = {UnitIDV1,UnitIDV2,UnitIDV3,UnitIDV4}
for i = 221, 224 do
	CTrigger(FP,{CVar(FP,G_CB_CUTV[2],Exactly,i,0xFF)},{TSetCVar(FP,G_CB_CUTV[2],SetTo,PatchCondArr[i-220],0xFF)},1)
	CIf(FP,{CVar(FP,G_CB_CUTV[2],Exactly,i*0x100,0xFF00)})
		CTrigger(FP,{},{TSetCVar(FP,G_CB_CUTV[2],SetTo,_Mul(PatchCondArr[i-220],_Mov(0x100)),0xFF00)},1)
	CIfEnd()
	CIf(FP,{CVar(FP,G_CB_CUTV[2],Exactly,i*0x10000,0xFF0000)})
		CTrigger(FP,{},{TSetCVar(FP,G_CB_CUTV[2],SetTo,_Mul(PatchCondArr[i-220],_Mov(0x10000)),0xFF0000)},1)
	CIfEnd()
	CIf(FP,{CVar(FP,G_CB_CUTV[2],Exactly,i*0x1000000,0xFF000000)})
		CTrigger(FP,{},{TSetCVar(FP,G_CB_CUTV[2],SetTo,_Mul(PatchCondArr[i-220],_Mov(0x1000000)),0xFF000000)},1)
	CIfEnd()
end
if Limit == 1 then
TriggerX(FP,{CD(TestMode,1)},{RotatePlayer({DisplayTextX(f_GunSpawnSet,4)},HumanPlayers,FP)})
end
CMov(FP,G_CB_LineV,0)
CJumpEnd(FP,Write_SpawnSet_Jump)

CAdd(FP,G_CB_LineTemp,G_CB_LineV,G_CB_InputH)
NIfX(FP,{TMemory(G_CB_LineTemp,AtMost,0)})

--[[
	Line 0 = UnitID 1Byte
	Line 1 = PrefuncID 1Byte
	Line 2 = CBPlot Index 4Byte
	Line 3 = Current Delay Time 4Byte
	Line 4 = Loop Limit 1Byte
	Line 5 = RepeatType 1Byte
	Line 6 = ??? 
	Line 9 = CreatePlayer 1Byte
	Line 10 = ShapeSize 1Byte (100=100%)
	Line 11 = Use Queue Option 1Byte
	Line 12 SelectShapeNumber1 4Byte
	Line 13 SelectShapeNumber2 4Byte
	Line 14 SelectShapeNumber3 4Byte
	Line 15 SelectShapeNumber4 4Byte
	Line 16 Set Delay Timer 1 4Byte
	Line 17 Set Delay Timer 2 4Byte
	Line 18 Set Delay Timer 3 4Byte
	Line 19 Set Delay Timer 4 4Byte
]]


CDoActions(FP,{
	TSetMemory(_Add(G_CB_LineTemp,0*(0x20/4)),SetTo,G_CB_CUTV),
	TSetMemory(_Add(G_CB_LineTemp,1*(0x20/4)),SetTo,G_CB_FNTV),
	TSetMemory(_Add(G_CB_LineTemp,2*(0x20/4)),SetTo,0),
	TSetMemory(_Add(G_CB_LineTemp,3*(0x20/4)),SetTo,0),--현재딜레이
	TSetMemory(_Add(G_CB_LineTemp,4*(0x20/4)),SetTo,G_CB_LMTV),
	TSetMemory(_Add(G_CB_LineTemp,5*(0x20/4)),SetTo,G_CB_RPTV),
	TSetMemory(_Add(G_CB_LineTemp,6*(0x20/4)),SetTo,0),
	TSetMemory(_Add(G_CB_LineTemp,9*(0x20/4)),SetTo,G_CB_CPTV),
	TSetMemory(_Add(G_CB_LineTemp,10*(0x20/4)),SetTo,G_CB_SZTV),
	TSetMemory(_Add(G_CB_LineTemp,11*(0x20/4)),SetTo,G_CB_NQOption),
	TSetMemory(_Add(G_CB_LineTemp,12*(0x20/4)),SetTo,G_CB_SNTV[1]),
	TSetMemory(_Add(G_CB_LineTemp,13*(0x20/4)),SetTo,G_CB_SNTV[2]),
	TSetMemory(_Add(G_CB_LineTemp,14*(0x20/4)),SetTo,G_CB_SNTV[3]),
	TSetMemory(_Add(G_CB_LineTemp,15*(0x20/4)),SetTo,G_CB_SNTV[4]),
	TSetMemory(_Add(G_CB_LineTemp,16*(0x20/4)),SetTo,G_CB_DLTV[1]),
	TSetMemory(_Add(G_CB_LineTemp,17*(0x20/4)),SetTo,G_CB_DLTV[2]),
	TSetMemory(_Add(G_CB_LineTemp,18*(0x20/4)),SetTo,G_CB_DLTV[3]),
	TSetMemory(_Add(G_CB_LineTemp,19*(0x20/4)),SetTo,G_CB_DLTV[4]),
	TSetMemory(_Add(G_CB_LineTemp,20*(0x20/4)),SetTo,G_CB_RTTV[1]),
	TSetMemory(_Add(G_CB_LineTemp,21*(0x20/4)),SetTo,G_CB_RTTV[2]),
	TSetMemory(_Add(G_CB_LineTemp,22*(0x20/4)),SetTo,G_CB_RTTV[3]),
	TSetMemory(_Add(G_CB_LineTemp,23*(0x20/4)),SetTo,G_CB_RTTV[4]),

})
CIfX(FP,{CVar(FP,G_CB_XPos[2],Exactly,0xFFFFFFFF),CVar(FP,G_CB_YPos[2],Exactly,0xFFFFFFFF)})
CDoActions(FP,{
	TSetMemory(_Add(G_CB_LineTemp,7*(0x20/4)),SetTo,G_CB_X),
	TSetMemory(_Add(G_CB_LineTemp,8*(0x20/4)),SetTo,G_CB_Y)
})
CElseX()
CDoActions(FP,{
	TSetMemory(_Add(G_CB_LineTemp,7*(0x20/4)),SetTo,G_CB_XPos),
	TSetMemory(_Add(G_CB_LineTemp,8*(0x20/4)),SetTo,G_CB_YPos)
})
CIfXEnd()

NElseIfX({CVar(FP,G_CB_LineV[2],AtMost,((0x970/4)*Size_of_G_CB_Arr-2))})
CAdd(FP,G_CB_LineV,0x970/4)
CJump(FP,Write_SpawnSet_Jump)
NElseX()

DoActions(FP,{RotatePlayer({DisplayTextX(f_GunSendErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})

NIfXEnd()
SetCallEnd()










local CA_TempUID = CreateVar(FP)
local CA_Suspend = CreateCcode()

Call_CA_Repeat = SetCallForward()
SetCall(FP)
TriggerX(FP,{CVar(FP,CA_TempUID[2],AtLeast,221)},{SetCVar(FP,CA_TempUID[2],SetTo,0)},{preserved})
DoActionsX(FP,{SetCDeaths(FP,SetTo,1,CA_Repeat_Check)})
CMov(FP,Gun_TempSpawnSet1,CA_TempUID)
CMov(FP,Repeat_TempV,1)
TriggerX(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,94),CVar(FP,Repeat_TempV[2],Exactly,4)},{SetCVar(FP,Repeat_TempV[2],SetTo,1)},{preserved}) -- 도형건작 옵저버 1개 제한

CMov(FP,RepeatType,G_CB_TempTable[6],nil,0xFF)
CMov(FP,CreatePlayer,G_CB_TempTable[10],nil,0xFF)
--NQOption
CallTrigger(FP,Set_Repeat)
SetCallEnd()

local G_CB_Launch = CreateCcode()

function CA_Func1()
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local SizeTemp = CreateVar(FP)
	CMov(FP,BX,G_CB_BackupX)
	CMov(FP,BY,G_CB_BackupY)
	CIf(FP,{TTCVar(FP,G_CB_TempTable[11][2],NotSame,100,0xFF)})
		CMov(FP, SizeTemp, G_CB_TempTable[11], nil, 0xFF, 1)
		CA_RatioXY(SizeTemp, 100, SizeTemp, 100)
	CIfEnd()

	CIf(FP,{CV(G_CB_TempTable[21],1,AtLeast)})
		CIfX(FP,{CV(G_CB_TempTable[21],0xFFFFFFFF)})
			CA_Rotate(G_CB_RotateV)
		CElseX()
			CA_Rotate(G_CB_TempTable[21])
		CIfXEnd()
	CIfEnd()
	local CX = CreateVar(FP)
	local CY = CreateVar(FP)
	CAdd(FP,CX,V(CA[8]),G_CB_TempTable[8])
	CAdd(FP,CY,V(CA[9]),G_CB_TempTable[9])
    
	--CallTrigger(FP,Call_CA_Repeat,{SetCDeaths(FP,SetTo,1,G_CB_Launch)})
	CIfX(FP,{CVar(FP,CX[2],AtMost,32*64),CVar(FP,CY[2],AtMost,32*256)})
    Simple_SetLocX(FP,0,CX,CY,CX,CY)
	CallTrigger(FP,Call_CA_Repeat,{SetCDeaths(FP,SetTo,1,G_CB_Launch)})
	if Limit == 1 then
		CElseX({SetCDeaths(FP,SetTo,1,G_CB_Launch),})--RotatePlayer({DisplayTextX(G_CB_PosErr,4)},HumanPlayers,FP)
	else
		CElseX({SetCDeaths(FP,SetTo,1,G_CB_Launch)})--RotatePlayer({DisplayTextX(G_CB_PosErr,4)},HumanPlayers,FP)
	end
	CIfXEnd()


end

local Ret = CreateVar(FP)
local CalcX, CalcY = CreateVars(2, FP)
local CalcA = CreateVar(FP)
local FncRand = CreateVar(FP)
CFunc1 = InitCFunc(FP)
Para = CFunc(CFunc1)
CIfX(FP, {CV(FncRand,0)})
local NG = CreateVar(FP)
CiSub(FP,Ret,_Add(_iMul(Para[1],CalcX),_iMul(Para[2],CalcY)),100)
CIf(FP,{CV(NG,1),CV(Ret,0x80000000,AtLeast)})
CNeg(FP,Ret)
CIfEnd()

CElseIfX({CV(FncRand,1)})--SortR
CMov(FP,Ret,_Sqrt(_Add(_Square(Para[1]),_Square(Para[2]))))
CElseIfX({CV(FncRand,2)})--SortA
local RetAbs= CreateVar(FP)

CMov(FP,RetAbs,_Abs(_Atan2(Para[2],Para[1])))
CAdd(FP,Ret,RetAbs,CalcA)
CMod(FP,Ret,360)

CIfXEnd()
CFuncReturn({Ret})
CFuncEnd()

CFunc2 = InitCFunc(FP)
Para = CFunc(CFunc2)--
CMov(FP,Ret,_Sqrt(_Add(_Square(Para[1]),_Square(Para[2]))))
CFuncReturn({Ret})
CFuncEnd()

function G_CB_Prefunc()
	
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


local CA = CAPlotDataArr
local CB = CAPlotCreateArr
local TempFunc = CreateVar(FP)
local TempFunc2 = CreateVar(FP)

CB_PrfcInit = def_sIndex()
CJump(FP,CB_PrfcInit)
	CB_initTCopy()
CJumpEnd(FP,CB_PrfcInit)





function CB_RandSort()
		
	CMov(FP,CalcX,_Mod(_Rand(),200),-100)
	CMov(FP,CalcY,_Mod(_Rand(),200),-100)
	CMov(FP,CalcA,_Mod(_Rand(),360))
	DoActions(FP,SetSwitch(RandSwitch1,Random))
	TriggerX(FP,Switch(RandSwitch1,Cleared),{SetV(NG,1)},{preserved})
	TriggerX(FP,Switch(RandSwitch1,Set),{SetV(NG,0)},{preserved})

	RandRet = f_CRandNum(2)
	DirRand = CreateVar(FP)
	CMov(FP,DirRand,RandRet)
	RandRet = f_CRandNum(3)
	CMov(FP,FncRand,RandRet)
	if TestStart == 1 then
		--DisplayPrint(HumanPlayers, {"DirRand : ",DirRand,"  FncRand : ",FncRand})
	end
	CB_Sort(CFunc1, DirRand, STSize+2, EndRetShape)
	CurShNum = CreateVar(FP)
	CB_GetNumber(EndRetShape, CurShNum)
	if TestStart == 1 then

	--DisplayPrint(HumanPlayers, {"Calc "..(STSize+2).." to "..EndRetShape.." DirRand : ",DirRand,"  FncRand : ",FncRand,"   CurShNum : ",CurShNum})
	end
	

end

function CB_MarNumFill()
	local MarNum = CreateVars(FP)
	--Simple_SetLocX(FP, 200, G_CB_TempTable[8],G_CB_TempTable[9],G_CB_TempTable[8],G_CB_TempTable[9],{Simple_CalcLoc(200, -32*15, -32*15, 32*15, 32*15),KillUnitAt(All, nilunit, 201, FP)})
	--최대값 32 최소값 2
	--최대값기준 마린 480마리
	--local Xm, Ym = CreateVars(2, FP)
	--CB_GetXmin(G_CB_Shapes[TemConnect][2], Xm)
	--CB_GetYmin(G_CB_Shapes[TemConnect][2], Ym)
	--UnitReadX(FP, Force1, "Men", 201, MarNum)
	--TriggerX(FP, {CV(MarNum,480,AtLeast)}, {SetV(MarNum,480)},{preserved})
	--local SizeV = CreateVar(FP)
	--CSub(FP,SizeV, _Mov(128+16+32), _Div(MarNum,5))
	
	--CB_Fill(Xm, Ym, SizeV, SizeV,32,32, STSize+2)
	--CB_CropPath(G_CB_Shapes[TemConnect][2],0,STSize+2,STSize+3)
	RandRet = f_CRandNum(2)
	CMov(FP,DirRand,RandRet)
	CB_Sort(CFunc2,DirRand,STSize+2,EndRetShape)


end
	G_CB_PrefuncArr = {
		{1,"CB_RandSort"},
		{2,"CB_MarNumFill"},
	} --{index,funcname}



	
	
	CIfX(FP,{CVX(G_CB_TempTable[2],1,0xFF,AtLeast)})
	CB_TCopy(V(CA[1]),STSize+2)
	--DisplayPrint(HumanPlayers, {"ShapeData ",V(CA[1])," to "..(STSize+2).." TempFunc : ",G_CB_TempTable[2]})
	for j, k in pairs(G_CB_PrefuncArr) do
		CIf(FP,CVX(G_CB_TempTable[2],k[1],0xFF))
			_G[k[2]]()
		CIfEnd()
	end
	local TempRetShape = CreateVar(FP)
	CMov(FP,TempRetShape,G_CB_Num,EndRetShape)
	CB_TCopy(EndRetShape,TempRetShape)
	CMov(FP,V(CA[1]),G_CB_Num,EndRetShape)
	CMov(FP,G_CB_TempTable[13],G_CB_Num,EndRetShape)
	--DisplayPrint(HumanPlayers, {"ShapeData "..EndRetShape.." to ",V(CA[1])," G_CB_TempTable[13] : ",G_CB_TempTable[13]})

	CIf(FP,CVX(G_CB_TempTable[5],0,0xFF))
	local RetNum = CreateVar(FP)
	CB_GetNumber(EndRetShape, RetNum)
	CMov(FP,G_CB_TempTable[5],_Div(RetNum,50),1,0xFF,1)
	CMov(FP,V(CA[5]),G_CB_TempTable[5],nil,0xFF,1)

	CIfEnd()

	CIfXEnd()

	
	CIfX(FP,CVar(FP,G_CB_TempTable[5][2],AtMost,0,0xFF)) -- LoopLimit
	for j, k in pairs(Z) do
		CTrigger(FP,{CVar(FP,G_CB_TempTable[13][2],Exactly,j,0xFF)},{SetCVar(FP,G_CB_TempTable[5][2],SetTo,(k[1]/50)+1)},1)
	end
		CMov(FP,V(CA[5]),G_CB_TempTable[5],nil,0xFF,1)
	CElseX()
		CMov(FP,V(CA[5]),G_CB_TempTable[5],nil,0xFF,1)
	CIfXEnd()
	CMov(FP,G_CB_TempTable[2],0,nil,0xFF)


end

--[[
	Line 0 = UnitID 1Byte
	Line 1 = PrefuncID 1Byte
	Line 2 = CBPlot Index 4Byte
	Line 3 = Current Delay Time 4Byte
	Line 4 = Loop Limit 1Byte
	Line 5 = RepeatType 1Byte
	Line 6 = ??? 
	Line 9 = CreatePlayer 1Byte
	Line 10 = ShapeSize 1Byte (100=100%)
	Line 11 = Use Queue Option 1Byte
	Line 12 SelectShapeNumber1 4Byte
	Line 13 SelectShapeNumber2 4Byte
	Line 14 SelectShapeNumber3 4Byte
	Line 15 SelectShapeNumber4 4Byte
	Line 16 Set Delay Timer 1 4Byte
	Line 17 Set Delay Timer 2 4Byte
	Line 18 Set Delay Timer 3 4Byte
	Line 19 Set Delay Timer 4 4Byte
]]


G_CB_ShNm = 0
local Call_G_CBPlot = CreateCallIndex()
function G_CBPlot()
		Z = {}
		local c = 0
		for j,k in pairs(G_CB_Shapes) do
			Z[k[2]] = k[1]
			c=c+1
			G_CB_ShNm = G_CB_ShNm+1
		end

		
	if type(Z) ~= "table" then
		PushErrorMsg("ShapeData_Input_Error")
	end
	local Y = {}
	local X = {}
	local L = {}
	for j, k in pairs(Z) do
		Y[j] = k
		if L[j] ~= nil then
			X[j] = L[j]
		else
			X[j] = CS_TMakeAuto(k)
		end
	end
	STSize = #Y
	table.insert(Z,CS_InputVoid(1699))
	table.insert(Z,CS_InputVoid(1699))
	table.insert(Z,CS_InputVoid(1699))
	for i = 1, Size_of_G_CB_Arr do
		table.insert(Z,CS_InputVoid(1699))
	end


	EndRetShape = STSize+3 -- 최종 연산 ShapeNum




	local CA = CAPlotForward()
	SetCall2(FP,Call_G_CBPlot)
	CTrigger(FP, {CV(G_CB_TempTable[17],0)}, {SetV(G_CB_TempTable[4],0),SetV(V(CA[3]),0)},1)
	CMov(FP,CA_TempUID,G_CB_TempTable[1],nil,0xFF) -- UnitID
	CMov(FP,V(CA[1]),G_CB_TempTable[13]) -- ShapeIndex
	CMov(FP,V(CA[3]),G_CB_TempTable[17]) -- SetDelayTimer
	CMov(FP,V(CA[2]),G_CB_TempTable[4]) -- CurDelayTimer
	--DisplayPrint(HumanPlayers, {
	--	"   G_CB_TempTable[1] : ",G_CB_TempTable[1],--Line 0 = UnitID 1Byte
	--	"   G_CB_TempTable[2] : ",G_CB_TempTable[2],--Line 1 = PrefuncID 1Byte
	--	"   G_CB_TempTable[3] : ",G_CB_TempTable[3],--Line 2 = CBPlot Index 4Byte
	--	"   G_CB_TempTable[4] : ",G_CB_TempTable[4],--Line 3 = Current Delay Time 4Byte
	--	"   G_CB_TempTable[5] : ",G_CB_TempTable[5],--Line 4 = Loop Limit 1Byte
	--	"   G_CB_TempTable[6] : ",G_CB_TempTable[6],--Line 5 = RepeatType 1Byte
	--	"   G_CB_TempTable[7] : ",G_CB_TempTable[7],--Line 6 = ??? 
	--	"   G_CB_TempTable[8] : ",G_CB_TempTable[8],--.
	--	"   G_CB_TempTable[9] : ",G_CB_TempTable[9],--.
	--	"   G_CB_TempTable[10] : ",G_CB_TempTable[10],--Line 9 = CreatePlayer 1Byte
	--	"   G_CB_TempTable[11] : ",G_CB_TempTable[11],--Line 10 = ShapeSize 1Byte (100=100%)
	--	"   G_CB_TempTable[12] : ",G_CB_TempTable[12],--Line 11 = Use Queue Option 1Byte
	--	"   G_CB_TempTable[13] : ",G_CB_TempTable[13],--Line 12 SelectShapeNumber1 4Byte
	--	"   G_CB_TempTable[14] : ",G_CB_TempTable[14],--Line 13 SelectShapeNumber2 4Byte
	--	"   G_CB_TempTable[15] : ",G_CB_TempTable[15],--Line 14 SelectShapeNumber3 4Byte
	--	"   G_CB_TempTable[16] : ",G_CB_TempTable[16],--Line 15 SelectShapeNumber4 4Byte
	--	"   G_CB_TempTable[17] : ",G_CB_TempTable[17],--Line 16 Set Delay Timer 1 4Byte
	--	"   G_CB_TempTable[18] : ",G_CB_TempTable[18],--Line 17 Set Delay Timer 2 4Byte
	--	"   G_CB_TempTable[19] : ",G_CB_TempTable[19],--Line 18 Set Delay Timer 3 4Byte
	--	"   G_CB_TempTable[20] : ",G_CB_TempTable[20],--Line 19 Set Delay Timer 4 4Byte
	--})

	CMov(FP,V(CA[6]),G_CB_TempTable[3]) -- CBPlot Index
    CMov(FP,NQOption,G_CB_TempTable[12],nil,0xFF,1) -- QueueOption
	CMov(FP,V(CA[5]),G_CB_TempTable[5],nil,0xFF,1)
	CMov(FP,G_CB_BackupX,G_CB_TempTable[8])
	CMov(FP,G_CB_BackupY,G_CB_TempTable[9])
    CBPlot(Z, nil, FP,nilunit, 0, {G_CB_TempTable[8],G_CB_TempTable[9]}, 1,32,{0,0,0,0,0,1}, "CA_Func1", "G_CB_Prefunc", FP, nil,nil,{SetCDeaths(FP,Add,1,CA_Suspend)})
    CTrigger(FP, {TTNVar(V(CA[2]), NotSame, G_CB_TempTable[4])}, {SetCDeaths(FP,SetTo,1,G_CB_Launch)},{preserved})
	if TestStart == 1 then
		--CIf(FP,{CD(CA_Suspend,1)})
		
		--DisplayPrint(HumanPlayers, {
		--	"   G_CB_TempTable[1] : ",G_CB_TempTable[1],--Line 0 = UnitID 1Byte
		--	"   G_CB_TempTable[2] : ",G_CB_TempTable[2],--Line 1 = PrefuncID 1Byte
		--	"   G_CB_TempTable[3] : ",G_CB_TempTable[3],--Line 2 = CBPlot Index 4Byte
		--	"   G_CB_TempTable[4] : ",G_CB_TempTable[4],--Line 3 = Current Delay Time 4Byte
		--	"   G_CB_TempTable[5] : ",G_CB_TempTable[5],--Line 4 = Loop Limit 1Byte
		--	"   G_CB_TempTable[6] : ",G_CB_TempTable[6],--Line 5 = RepeatType 1Byte
		--	"   G_CB_TempTable[7] : ",G_CB_TempTable[7],--Line 6 = ??? 
		--	"   G_CB_TempTable[8] : ",G_CB_TempTable[8],--.
		--	"   G_CB_TempTable[9] : ",G_CB_TempTable[9],--.
		--	"   G_CB_TempTable[10] : ",G_CB_TempTable[10],--Line 9 = CreatePlayer 1Byte
		--	"   G_CB_TempTable[11] : ",G_CB_TempTable[11],--Line 10 = ShapeSize 1Byte (100=100%)
		--	"   G_CB_TempTable[12] : ",G_CB_TempTable[12],--Line 11 = Use Queue Option 1Byte
		--	"   G_CB_TempTable[13] : ",G_CB_TempTable[13],--Line 12 SelectShapeNumber1 4Byte
		--	"   G_CB_TempTable[14] : ",G_CB_TempTable[14],--Line 13 SelectShapeNumber2 4Byte
		--	"   G_CB_TempTable[15] : ",G_CB_TempTable[15],--Line 14 SelectShapeNumber3 4Byte
		--	"   G_CB_TempTable[16] : ",G_CB_TempTable[16],--Line 15 SelectShapeNumber4 4Byte
		--	"   G_CB_TempTable[17] : ",G_CB_TempTable[17],--Line 16 Set Delay Timer 1 4Byte
		--	"   G_CB_TempTable[18] : ",G_CB_TempTable[18],--Line 17 Set Delay Timer 2 4Byte
		--	"   G_CB_TempTable[19] : ",G_CB_TempTable[19],--Line 18 Set Delay Timer 3 4Byte
		--	"   G_CB_TempTable[20] : ",G_CB_TempTable[20],--Line 19 Set Delay Timer 4 4Byte
		--})

			--DisplayPrint(HumanPlayers, {"CA[6] : ",V(CA[6])})
		--CIfEnd()
	end
	CDoActions(FP,{TSetCVar(FP,G_CB_TempTable[3][2],SetTo,V(CA[6])),TSetCVar(FP,G_CB_TempTable[4][2],SetTo,V(CA[2]))})

    
	SetCallEnd2()
end

function T_to_ByteBuffer(Table)
	local VMode = 0
	for j,k in pairs(Table) do
		if type(k) == "table" then--V가 한개라도 있을경우 VMode On
			if k[4] == "V" then
				VMode = 1
				G_CBPlotTOption = 1
			else
				PushErrorMsg("Table_InputData_Error")
			end
		end
	end
	if VMode == 0 then
		local ByteValue = 0
		if type(Table) == "table" then
			local ret = 0
			if #Table >= 5 then
				PushErrorMsg("BiteStack_is_Over_5")
			end
			for i, j in pairs(Table) do
				if type(j) == "string" then
					ByteValue = ByteValue + ParseUnitNameT[j]*(256^ret)
				else
				ByteValue = ByteValue + j*(256^ret)
				end
				ret = ret + 1
			end
			Table = ByteValue
		end
		return ByteValue
	else
		local ByteValue = 0
		local TempV = CreateVar(FP)
		if type(Table) == "table" then
			local ret = 0
			if #Table >= 5 then
				PushErrorMsg("BiteStack_is_Over_5")
			end
			for i, j in pairs(Table) do
				if type(j) == "table" and j[4]== "V" then
					if i~= 1 then
						CAdd(FP,TempV,_lShift(j, (i-1)*8))
					else
						ByteValue = ByteValue + j*(256^ret)
					end
					
				elseif type(j) == "number" then
					ByteValue = ByteValue + j*(256^ret)
				else
					PushErrorMsg("Table_InputData_Error")
				end
				ret = ret + 1
			end
		end
		if ByteValue >= 1 then
			CAdd(FP,TempV,ByteValue)
		end
		return TempV
	end
end


function G_CB_SetSpawn(Condition,G_CB_CUTable,G_CB_SNTable,G_CB_SLTable,G_CB_LMTable,G_CB_RepeatType,G_CB_SizeTable,CenterXY,G_CB_OwnerTable,PreserveFlag,G_CB_NQOpTable)
    local G_CB_ShapeTable = {}
	if G_CB_SizeTable == nil then G_CB_SizeTable = 100 end
	if G_CB_NQOpTable == nil then G_CB_NQOpTable = 0 end
	if G_CB_RepeatType == nil then G_CB_RepeatType = 0 end
	local G_CB_FNTable = {}
	if type(G_CB_SNTable) == "string" then
		G_CB_SNTable = {G_CB_SNTable,G_CB_SNTable,G_CB_SNTable,G_CB_SNTable}
    elseif type(G_CB_SNTable[1]) == "table"  then
        if type(G_CB_SNTable[1][1]) == "number" then
            G_CB_SNTable = {G_CB_SNTable,G_CB_SNTable,G_CB_SNTable,G_CB_SNTable}
        end
	elseif G_CB_SNTable == nil then
		PushErrorMsg("G_CB_SetSpawn_Inputdata_Error")
	end

	if type(G_CB_SLTable) ~= "table" then
		G_CB_SLTable = {G_CB_SLTable,G_CB_SLTable,G_CB_SLTable,G_CB_SLTable}
	elseif G_CB_SLTable == nil then
		PushErrorMsg("G_CB_SetSpawn_Inputdata_Error")
	end
    for j,k in pairs(G_CB_SNTable) do
        if k == "ACAS" then
            G_CB_ShapeTable[j] = _G[G_CB_SLTable[j]]
        else
            G_CB_ShapeTable[j] = k[G_CB_SLTable[j]+1]
			G_CB_FNTable[j] = 1
        end
    end
	if #G_CB_FNTable == 0 then G_CB_FNTable = nil end


    G_CB_SetSpawnX(Condition,G_CB_CUTable,G_CB_ShapeTable,G_CB_LMTable,G_CB_RepeatType,nil,G_CB_SizeTable,G_CB_FNTable,CenterXY,G_CB_OwnerTable,PreserveFlag,G_CB_NQOpTable)
end



function G_CB_SetSpawnX(Condition,G_CB_CUTable,G_CB_ShapeTable,G_CB_LMTable,G_CB_RepeatType,G_CB_Delay,G_CB_SizeTable,G_CB_FNTable,CenterXY,G_CB_OwnerTable,PreserveFlag,G_CB_NQOpTable)

	G_CB_TSetSpawn(Condition,G_CB_CUTable,G_CB_ShapeTable,PreserveFlag,{
		LMTable = G_CB_LMTable,
		RepeatType = G_CB_RepeatType,
		Delay = G_CB_Delay,
		SizeTable = G_CB_SizeTable,
		FNTable = G_CB_FNTable,
		OwnerTable = G_CB_OwnerTable,
		NQOpTable = G_CB_NQOpTable,
		CenterXY = CenterXY,
	})


end

function G_CB_TSetSpawn(Condition,G_CB_CUTable,G_CB_ShapeTable,PreserveFlag,G_CB_Property)
	--LM == nil then LM = 255
	if type(G_CB_CUTable) ~= "table" then
		PushErrorMsg("G_CB_SetSpawn_Inputdata_Error")
	end
	
	if type(G_CB_ShapeTable[1]) == "number" then
		G_CB_ShapeTable = {G_CB_ShapeTable,G_CB_ShapeTable,G_CB_ShapeTable,G_CB_ShapeTable}
	elseif G_CB_ShapeTable == nil then
		PushErrorMsg("G_CB_SetSpawn_Inputdata_Error")
	end

	G_CBPlotTOption = 0
	local X = {}
	if type(G_CB_ShapeTable[1]) == "table" then
		if #G_CB_ShapeTable >= 5 then
			PushErrorMsg("BiteStack_is_Over_5")
		end
		for i = 1, 4 do
			if G_CB_ShapeTable[i] ~= nil then
				
                if G_CB_Shapes[G_CB_ShapeTable[i]] == nil then
                    G_CB_Shapes[G_CB_ShapeTable[i]] = {G_CB_ShapeTable[i],G_CB_ShapeIndexAlloc}
                    G_CB_ShapeIndexAlloc = G_CB_ShapeIndexAlloc + 1
                end
                G_CB_ShapeTable[i] = G_CB_Shapes[G_CB_ShapeTable[i]][2]
				
            else
                G_CB_ShapeTable[i] = 0
            end
		end
	else
		PushErrorMsg("G_CB_SLTable_InputData_Error")
	end



	local G_CB_LMTable = {{G_CB_LMTV,0}}
	local G_CB_Delay = {
		{G_CB_DLTV[1],0},
		{G_CB_DLTV[2],0},
		{G_CB_DLTV[3],0},
		{G_CB_DLTV[4],0},
	}
	local G_CB_Rotate = {
		{G_CB_RTTV[1],0},
		{G_CB_RTTV[2],0},
		{G_CB_RTTV[3],0},
		{G_CB_RTTV[4],0},
	}
	local G_CB_SizeTable = {{G_CB_SZTV,T_to_ByteBuffer({100,100,100,100})}}
	local G_CB_FNTable = {{G_CB_FNTV,T_to_ByteBuffer({0,0,0,0})}}
	local G_CB_NQOpTable = {{G_CB_NQOption,T_to_ByteBuffer({0,0,0,0})}}
	local G_CB_RepeatType = {{G_CB_RPTV,T_to_ByteBuffer({0,0,0,0})}}
	local CenterXY = {{G_CB_XPos,0xFFFFFFFF},{G_CB_YPos,0xFFFFFFFF}}
	local G_CB_OwnerTable = {{G_CB_CPTV,T_to_ByteBuffer({FP,FP,FP,FP})}}
	for j,k in pairs(G_CB_Property) do
		if j == "LMTable" then
			if k == "MAX" then
				G_CB_LMTable = {{G_CB_LMTV,-1}}
			elseif type(k) == "table" and k[4]~="V" then
				G_CB_LMTable = {{G_CB_LMTV,T_to_ByteBuffer(k)}}
			else
				G_CB_LMTable = {{G_CB_LMTV,T_to_ByteBuffer({k,k,k,k})}}
			end
		elseif j == "Delay" then
			--_G[k]()
			if type(k) == "table" and k[4]~="V" then
				for o, p in pairs(k) do
					G_CB_Delay[o] = {G_CB_DLTV[o],p}
				end
			else
				G_CB_Delay = {
					{G_CB_DLTV[1],k},
					{G_CB_DLTV[2],k},
					{G_CB_DLTV[3],k},
					{G_CB_DLTV[4],k},
				}
			end



			
		elseif j == "SizeTable" then
			if type(k) == "table" and k[4]~="V" then
				G_CB_SizeTable = {{G_CB_SZTV,T_to_ByteBuffer(k)}}
			else
				G_CB_SizeTable = {{G_CB_SZTV,T_to_ByteBuffer({k,k,k,k})}}
			end
		elseif j == "FNTable" then
			if type(k) == "table" and k[4]~="V" then
				G_CB_FNTable = {{G_CB_FNTV,T_to_ByteBuffer(k)}}
			else
				G_CB_FNTable = {{G_CB_FNTV,T_to_ByteBuffer({k,k,k,k})}}
			end
		elseif j == "NQOpTable" then
			if type(k) == "table" and k[4]~="V" then
				G_CB_NQOpTable = {{G_CB_NQOption,T_to_ByteBuffer(k)}}
			else
				G_CB_NQOpTable = {{G_CB_NQOption,T_to_ByteBuffer({k,k,k,k})}}
			end
		elseif j == "RepeatType" then

			if type(k) == "table" and k[4]~="V" then
				local RT = {}
				for o,p in pairs(k) do
					local retP
					if type(p) == "string" then
						retP = RTypeKey[p]
					else
						retP = p
					end
					RT[o] = retP
				end
				G_CB_RepeatType = {{G_CB_RPTV,T_to_ByteBuffer(RT)}}
			else
				local retP
				if type(k) == "string" then
					retP = RTypeKey[k]
				else
					retP = k
				end
				G_CB_RepeatType = {{G_CB_RPTV,T_to_ByteBuffer({retP,retP,retP,retP})}}
			end
		elseif j == "RotateTable" then
			if type(k) == "table" and k[4]~="V" then
				for o, p in pairs(k) do
					G_CB_Rotate[o] = {G_CB_RTTV[o],p}
				end
			elseif type(k) == "string" and k=="Main" then
				G_CB_Rotate = {
					{G_CB_RTTV[1],0xFFFFFFFF},
					{G_CB_RTTV[2],0xFFFFFFFF},
					{G_CB_RTTV[3],0xFFFFFFFF},
					{G_CB_RTTV[4],0xFFFFFFFF},
				}
			else
				G_CB_Rotate = {
					{G_CB_RTTV[1],k},
					{G_CB_RTTV[2],k},
					{G_CB_RTTV[3],k},
					{G_CB_RTTV[4],k},
				}
			end
		elseif j == "CenterXY" then
				CenterXY = {
					{G_CB_XPos,k[1]},
					{G_CB_YPos,k[2]}}
		elseif j == "OwnerTable" then
			if type(k) == "table" and k[4]~="V" then
				G_CB_OwnerTable = {{G_CB_CPTV,T_to_ByteBuffer(k)}}
			else
				G_CB_OwnerTable = {{G_CB_CPTV,T_to_ByteBuffer({k,k,k,k})}}
			end
		end
	end
	if G_CBPlotTOption == 0 then
		local Act = {
		SetCVar(FP,G_CB_CUTV[2],SetTo,T_to_ByteBuffer(G_CB_CUTable)),
		SetCVar(FP,G_CB_SNTV[1][2],SetTo,G_CB_ShapeTable[1]),
		SetCVar(FP,G_CB_SNTV[2][2],SetTo,G_CB_ShapeTable[2]),
		SetCVar(FP,G_CB_SNTV[3][2],SetTo,G_CB_ShapeTable[3]),
		SetCVar(FP,G_CB_SNTV[4][2],SetTo,G_CB_ShapeTable[4]),
		}
		AutoSetV(Act,G_CB_LMTable)
		AutoSetV(Act,G_CB_Delay)
		AutoSetV(Act,G_CB_SizeTable)
		AutoSetV(Act,G_CB_FNTable)
		AutoSetV(Act,G_CB_NQOpTable)
		AutoSetV(Act,G_CB_RepeatType)
		AutoSetV(Act,CenterXY)
		AutoSetV(Act,G_CB_OwnerTable)
		AutoSetV(Act,G_CB_Rotate)
		CallTriggerX(FP,Write_SpawnSet,Condition,Act,PreserveFlag)
	else
		local Act = {
		TSetCVar(FP,G_CB_CUTV[2],SetTo,T_to_ByteBuffer(G_CB_CUTable)),
		TSetCVar(FP,G_CB_SNTV[1][2],SetTo,G_CB_ShapeTable[1]),
		TSetCVar(FP,G_CB_SNTV[2][2],SetTo,G_CB_ShapeTable[2]),
		TSetCVar(FP,G_CB_SNTV[3][2],SetTo,G_CB_ShapeTable[3]),
		TSetCVar(FP,G_CB_SNTV[4][2],SetTo,G_CB_ShapeTable[4]),
		}
		TAutoSetV(Act,G_CB_LMTable)
		TAutoSetV(Act,G_CB_Delay)
		TAutoSetV(Act,G_CB_SizeTable)
		TAutoSetV(Act,G_CB_FNTable)
		TAutoSetV(Act,G_CB_NQOpTable)
		TAutoSetV(Act,G_CB_RepeatType)
		TAutoSetV(Act,CenterXY)
		TAutoSetV(Act,G_CB_OwnerTable)
		TAutoSetV(Act,G_CB_Rotate)
		CDoActions(FP, Act,PreserveFlag)
		CallTriggerX(FP,Write_SpawnSet,Condition,nil,PreserveFlag)

	end
end
function AutoSetV(ActT,T)
	
for j,k in pairs(T) do
	table.insert(ActT, SetCVar(FP, k[1][2], SetTo, k[2]))
end

end
function TAutoSetV(ActT,T)
	
for j,k in pairs(T) do
	table.insert(ActT, TSetCVar(FP, k[1][2], SetTo, k[2]))
end

end
--[[
	Line 0 = UnitID 1Byte
	Line 1 = PrefuncID 1Byte
	Line 2 = CBPlot Index 4Byte
	Line 3 = Current Delay Time 4Byte
	Line 4 = Loop Limit 1Byte
	Line 5 = RepeatType 1Byte
	Line 6 = ??? 
	Line 9 = CreatePlayer 1Byte
	Line 10 = ShapeSize 1Byte (100=100%)
	Line 11 = Use Queue Option 1Byte
	Line 12 SelectShapeNumber1 4Byte
	Line 13 SelectShapeNumber2 4Byte
	Line 14 SelectShapeNumber3 4Byte
	Line 15 SelectShapeNumber4 4Byte
	Line 16 Set Delay Timer 1 4Byte
	Line 17 Set Delay Timer 2 4Byte
	Line 18 Set Delay Timer 3 4Byte
	Line 19 Set Delay Timer 4 4Byte
]]

Call_G_CB = SetCallForward()
SetCall(FP)
    CIfX(FP,CVar(FP,G_CB_TempTable[1][2],AtLeast,1,0xFF))
		--DisplayPrint(HumanPlayers, {G_CB_TempTable[5]})
        CallTrigger(FP,Call_G_CBPlot)
        CIfX(FP,{CDeaths(FP,AtLeast,1,G_CB_Launch),CDeaths(FP,AtMost,0,CA_Suspend)})
            CDoActions(FP,{
                TSetMemoryX(Vi(G_CB_TempH[2],0*(0x20/4)),SetTo,G_CB_TempTable[1],0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],1*(0x20/4)),SetTo,G_CB_TempTable[2],0xFF),
                TSetMemory(Vi(G_CB_TempH[2],2*(0x20/4)),SetTo,G_CB_TempTable[3]),
                TSetMemory(Vi(G_CB_TempH[2],3*(0x20/4)),SetTo,G_CB_TempTable[4]),
                TSetMemoryX(Vi(G_CB_TempH[2],4*(0x20/4)),SetTo,G_CB_TempTable[5],0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],5*(0x20/4)),SetTo,G_CB_TempTable[6],0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],6*(0x20/4)),SetTo,G_CB_TempTable[7],0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],9*(0x20/4)),SetTo,G_CB_TempTable[10],0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],10*(0x20/4)),SetTo,G_CB_TempTable[11],0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],11*(0x20/4)),SetTo,G_CB_TempTable[12],0xFF),
                TSetMemory(Vi(G_CB_TempH[2],12*(0x20/4)),SetTo,G_CB_TempTable[13]),
                
            })
            

        CElseIfX({CDeaths(FP,AtLeast,1,G_CB_Launch),CDeaths(FP,AtLeast,1,CA_Suspend)})
        CDoActions(FP,{
            TSetMemoryX(Vi(G_CB_TempH[2],0*(0x20/4)),SetTo,0,0xFF),
            TSetMemoryX(Vi(G_CB_TempH[2],1*(0x20/4)),SetTo,0,0xFF),
            TSetMemory(Vi(G_CB_TempH[2],2*(0x20/4)),SetTo,0),
            TSetMemory(Vi(G_CB_TempH[2],3*(0x20/4)),SetTo,0),
            TSetMemoryX(Vi(G_CB_TempH[2],4*(0x20/4)),SetTo,0,0xFF),
            TSetMemoryX(Vi(G_CB_TempH[2],5*(0x20/4)),SetTo,0,0xFF),
            TSetMemoryX(Vi(G_CB_TempH[2],6*(0x20/4)),SetTo,0,0xFF),
            TSetMemoryX(Vi(G_CB_TempH[2],9*(0x20/4)),SetTo,0,0xFF),
            TSetMemoryX(Vi(G_CB_TempH[2],10*(0x20/4)),SetTo,0,0xFF),
            TSetMemoryX(Vi(G_CB_TempH[2],11*(0x20/4)),SetTo,0,0xFF),
			TSetMemory(Vi(G_CB_TempH[2],12*(0x20/4)),SetTo,0),
			TSetMemory(Vi(G_CB_TempH[2],16*(0x20/4)),SetTo,0),
			TSetMemory(Vi(G_CB_TempH[2],20*(0x20/4)),SetTo,0),
        })
        CIf(FP,{TMemory(Vi(G_CB_TempH[2],0*(0x20/4)), Exactly, 0)})--G_CBPlot 데이터에 유닛아이디가 존재하지 않을경우 배열을 전부 초기화한다.
        local TActArr = {}
        for arr = 1, G_CB_Lines do
            if arr == 3 then
                table.insert(TActArr, TSetMemory(Vi(G_CB_TempH[2],(arr-1)*(0x20/4)), SetTo, 1))
            else
                table.insert(TActArr, TSetMemory(Vi(G_CB_TempH[2],(arr-1)*(0x20/4)), SetTo, 0))
            end
        end
        CDoActions(FP, TActArr)
        if TestStart == 1 then
        DoActions(FP,{RotatePlayer({DisplayTextX(f_GunFuncT2,4)},HumanPlayers,FP)})
        end
        CIfEnd()
        if TestStart == 1 then
        DoActions(FP,{RotatePlayer({DisplayTextX(f_GunFuncT,4)},HumanPlayers,FP)})
        end
        CElseX()
            DoActions(FP,{RotatePlayer({DisplayTextX(f_GunErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
			if TestStart == 1 then
        	DisplayPrint(HumanPlayers, {
        		"   G_CB_TempTable[1] : ",G_CB_TempTable[1],--Line 0 = UnitID 1Byte
        		"   G_CB_TempTable[2] : ",G_CB_TempTable[2],--Line 1 = PrefuncID 1Byte
        		"   G_CB_TempTable[3] : ",G_CB_TempTable[3],--Line 2 = CBPlot Index 4Byte
        		"   G_CB_TempTable[4] : ",G_CB_TempTable[4],--Line 3 = Current Delay Time 4Byte
        		"   G_CB_TempTable[5] : ",G_CB_TempTable[5],--Line 4 = Loop Limit 1Byte
        		"   G_CB_TempTable[6] : ",G_CB_TempTable[6],--Line 5 = RepeatType 1Byte
        		"   G_CB_TempTable[7] : ",G_CB_TempTable[7],--Line 6 = ??? 
        		"   G_CB_TempTable[8] : ",G_CB_TempTable[8],--.
        		"   G_CB_TempTable[9] : ",G_CB_TempTable[9],--.
        		"   G_CB_TempTable[10] : ",G_CB_TempTable[10],--Line 9 = CreatePlayer 1Byte
        		"   G_CB_TempTable[11] : ",G_CB_TempTable[11],--Line 10 = ShapeSize 1Byte (100=100%)
        		"   G_CB_TempTable[12] : ",G_CB_TempTable[12],--Line 11 = Use Queue Option 1Byte
        		"   G_CB_TempTable[13] : ",G_CB_TempTable[13],--Line 12 SelectShapeNumber1 4Byte
        		"   G_CB_TempTable[14] : ",G_CB_TempTable[14],--Line 13 SelectShapeNumber2 4Byte
        		"   G_CB_TempTable[15] : ",G_CB_TempTable[15],--Line 14 SelectShapeNumber3 4Byte
        		"   G_CB_TempTable[16] : ",G_CB_TempTable[16],--Line 15 SelectShapeNumber4 4Byte
        		"   G_CB_TempTable[17] : ",G_CB_TempTable[17],--Line 16 Set Delay Timer 1 4Byte
        		"   G_CB_TempTable[18] : ",G_CB_TempTable[18],--Line 17 Set Delay Timer 2 4Byte
        		"   G_CB_TempTable[19] : ",G_CB_TempTable[19],--Line 18 Set Delay Timer 3 4Byte
        		"   G_CB_TempTable[20] : ",G_CB_TempTable[20],--Line 19 Set Delay Timer 4 4Byte
        	})

        	end
            CDoActions(FP,{
                TSetMemoryX(Vi(G_CB_TempH[2],0*(0x20/4)),SetTo,0,0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],1*(0x20/4)),SetTo,0,0xFF),
                TSetMemory(Vi(G_CB_TempH[2],2*(0x20/4)),SetTo,0),
                TSetMemory(Vi(G_CB_TempH[2],3*(0x20/4)),SetTo,0),
                TSetMemoryX(Vi(G_CB_TempH[2],4*(0x20/4)),SetTo,0,0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],5*(0x20/4)),SetTo,0,0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],6*(0x20/4)),SetTo,0,0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],9*(0x20/4)),SetTo,0,0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],10*(0x20/4)),SetTo,0,0xFF),
                TSetMemoryX(Vi(G_CB_TempH[2],11*(0x20/4)),SetTo,0,0xFF),
				TSetMemory(Vi(G_CB_TempH[2],12*(0x20/4)),SetTo,0),
				TSetMemory(Vi(G_CB_TempH[2],16*(0x20/4)),SetTo,0),
				TSetMemory(Vi(G_CB_TempH[2],20*(0x20/4)),SetTo,0),
            })
            CIf(FP,{TMemory(Vi(G_CB_TempH[2],0*(0x20/4)), Exactly, 0)})--G_CBPlot 데이터에 유닛아이디가 존재하지 않을경우 배열을 전부 초기화한다.
            local TActArr = {}
            for arr = 1, G_CB_Lines do
                if arr == 3 then
                    table.insert(TActArr, TSetMemory(Vi(G_CB_TempH[2],(arr-1)*(0x20/4)), SetTo, 1))
                else
                    table.insert(TActArr, TSetMemory(Vi(G_CB_TempH[2],(arr-1)*(0x20/4)), SetTo, 0))
                end
            end
            CDoActions(FP, TActArr)
            if TestStart == 1 then
            DoActions(FP,{RotatePlayer({DisplayTextX(f_GunFuncT2,4)},HumanPlayers,FP)})
            end
            CIfEnd()
        CIfXEnd()
    CElseIfX({CVar(FP,G_CB_TempTable[1][2],AtMost,0,0xFF),CVar(FP,G_CB_TempTable[1][2],AtLeast,1)})
        CDoActions(FP,{

        TSetMemory(Vi(G_CB_TempH[2],0*(0x20/4)),SetTo,_rShift(G_CB_TempTable[1],8)),
        TSetMemory(Vi(G_CB_TempH[2],1*(0x20/4)),SetTo,_rShift(G_CB_TempTable[2],8)),
        TSetMemory(Vi(G_CB_TempH[2],2*(0x20/4)),SetTo,0),
        TSetMemory(Vi(G_CB_TempH[2],3*(0x20/4)),SetTo,0),
        TSetMemory(Vi(G_CB_TempH[2],4*(0x20/4)),SetTo,_rShift(G_CB_TempTable[5],8)),
        TSetMemory(Vi(G_CB_TempH[2],5*(0x20/4)),SetTo,_rShift(G_CB_TempTable[6],8)),
        TSetMemory(Vi(G_CB_TempH[2],6*(0x20/4)),SetTo,_rShift(G_CB_TempTable[7],8)),
        TSetMemory(Vi(G_CB_TempH[2],9*(0x20/4)),SetTo,_rShift(G_CB_TempTable[10],8)),
        TSetMemory(Vi(G_CB_TempH[2],10*(0x20/4)),SetTo,_rShift(G_CB_TempTable[11],8)),
        TSetMemory(Vi(G_CB_TempH[2],11*(0x20/4)),SetTo,_rShift(G_CB_TempTable[12],8)),
		TSetMemory(Vi(G_CB_TempH[2],12*(0x20/4)),SetTo,G_CB_TempTable[14]),
		TSetMemory(Vi(G_CB_TempH[2],13*(0x20/4)),SetTo,G_CB_TempTable[15]),
		TSetMemory(Vi(G_CB_TempH[2],14*(0x20/4)),SetTo,G_CB_TempTable[16]),
		TSetMemory(Vi(G_CB_TempH[2],15*(0x20/4)),SetTo,0),
		TSetMemory(Vi(G_CB_TempH[2],16*(0x20/4)),SetTo,G_CB_TempTable[18]),
		TSetMemory(Vi(G_CB_TempH[2],17*(0x20/4)),SetTo,G_CB_TempTable[19]),
		TSetMemory(Vi(G_CB_TempH[2],18*(0x20/4)),SetTo,G_CB_TempTable[20]),
		TSetMemory(Vi(G_CB_TempH[2],19*(0x20/4)),SetTo,0),
		TSetMemory(Vi(G_CB_TempH[2],20*(0x20/4)),SetTo,G_CB_TempTable[22]),
		TSetMemory(Vi(G_CB_TempH[2],21*(0x20/4)),SetTo,G_CB_TempTable[23]),
		TSetMemory(Vi(G_CB_TempH[2],22*(0x20/4)),SetTo,G_CB_TempTable[24]),
		TSetMemory(Vi(G_CB_TempH[2],23*(0x20/4)),SetTo,0),
    })
    CIfXEnd()
    DoActionsX(FP,{SetCDeaths(FP,SetTo,0,CA_Suspend),SetCDeaths(FP,SetTo,0,G_CB_Launch)})
SetCallEnd()
local Actived_G_CB = CreateVar(FP)
function Create_G_CB_Arr()
	if G_CB_Arr_IndexAlloc ~= StartIndex then PushErrorMsg("Already_G_CB_Arr_Created") end
	CMov(FP,Actived_G_CB,0)
	for i = 0, Size_of_G_CB_Arr-1 do
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
	--CMov(FP,0x57f0f0,Actived_G_CB)
end

end
    