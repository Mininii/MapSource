
		

	function DisplayPrintTbl(TBLID,arg,ResetTimer)
		
		TBLPtr = {}
		if dp.TBLKeyArr[TBLID] == nil then
			local InputTBLPtr = CreateVar(FP)
			dp.TBLKeyArr[TBLID] = {InputTBLPtr,TBLID}
			TBLPtr = dp.TBLKeyArr[TBLID][1]
		else
			TBLPtr = dp.TBLKeyArr[TBLID][1]

		end
		Dev = 0
		
		if ResetTimer~=nil then
			
			if type(ResetTimer)=="table" and ResetTimer[4]== "V" then
				CIf(FP,{CV(ResetTimer,0)})

			elseif type(ResetTimer)=="number" then
				ResetTimerCode = CreateCcode()
				DoActionsX(FP,{SubCD(ResetTimerCode, 1)})
				CIf(FP,{CD(ResetTimerCode,0)},{SetCD(ResetTimerCode,ResetTimer)})

			end
		end
		CMov(FP,dp.publicItoCusPtr,TBLPtr)
		for j,k in pairs(arg) do
			
			if type(k) == "function" then
				k()
			elseif type(k)=="table" and type(k[1]) == "function" then
				local lfunc = k[1]
				table.remove(k,1)
				lfunc(table.unpack(k))
			elseif type(k) == "string" then
			local CT = CreateCText(FP,k)
				f_Memcpy(FP,_Add(TBLPtr,Dev),_TMem(Arr(CT[3],0),"X","X",1),CT[2])
				Dev=Dev+CT[2]
			elseif type(k)=="table" and k[1] == "PVA" then -- PNameVArr 우회전용
				if k[2] == "LocalPlayerID" then
					CAdd(FP,dp.VtoNamePtr,RetV,Dev)
					CallTrigger(FP, dp.Call_VtoLPName)
				elseif type(k[2])=="number" then
					CAdd(FP,dp.VtoNamePtr,RetV,Dev)
					CallTrigger(FP, dp.Call_VtoName,{SetV(dp.VtoNameV,k[2])})
				elseif k[2][4] == "V" then
					CAdd(FP,dp.VtoNamePtr,RetV,Dev)
					CMov(FP,dp.VtoNameV,k[2])
					CallTrigger(FP, dp.Call_VtoName)
				end
				Dev=Dev+(4*5)
			elseif type(k)=="table" and k[4]=="V" then

				if k["fwc"] == true then
					CMov(FP,dp.publicItoDecV,k)
					CallTrigger(FP,dp.Call_IToDecX,{SetV(dp.DevV,Dev)}) 
					Dev=Dev+(4*12)
				elseif k["hex"] == true then
					CMov(FP,dp.publicItoDecV,k)
					CallTrigger(FP,dp.Call_ItoHex,{SetV(dp.DevV,Dev)}) 
					Dev=Dev+(3*4)
				else
					CMov(FP,dp.publicItoDecV,k)
					CallTrigger(FP,dp.Call_IToDec,{SetV(dp.DevV,Dev)}) 
					Dev=Dev+(4*4)
				end
			elseif type(k)=="number" then -- 상수index V 입력, string.char 구현용. 맨앞 0xFF영역만 사용
				CMov(FP,dp.TBwInputChar,V(k))
				CallTrigger(FP,dp.Call_TBwrite,{SetV(dp.DevV,Dev)}) 
				Dev=Dev+(1)
		end
		end

		
		
		CallTrigger(FP,dp.Call_TBwrite,{SetV(dp.TBwInputChar,0xE2),SetV(dp.DevV,Dev)}) 
		CallTrigger(FP,dp.Call_TBwrite,{SetV(dp.TBwInputChar,0x80),SetV(dp.DevV,1)}) 
		CallTrigger(FP,dp.Call_TBwrite,{SetV(dp.TBwInputChar,0x89),SetV(dp.DevV,2)}) 
		

		
	if ResetTimer~=nil then
		CIfEnd()

	end
		table.insert(dp.TBOLutputTxt,{"TBL - "..TBLID.." : "..string.rep("<0D>",Dev+10).."\n"})


	end
	function DisplayPrint(TargetPlayers,arg,FixTextPreset,SoundRepeat,ResetTimer) -- ext text ver
		if FixTextPreset == 3 or FixTextPreset == 1 then
		local TPArr = {}
		if type(TargetPlayers) == "number"  then
			TPArr = {TargetPlayers}
		end

		if #TPArr == 1 then
			CIf(FP, {TMemory(0x512684,Exactly,TPArr[1])})
		else
			local CondArr = {}
			for j,k in pairs(TPArr) do
				table.insert(CondArr, _TMemory(0x512684,Exactly,k))
			end
			CIf(FP,{TTOR(CondArr)})
			
		end
		FixText(FP,1)


		CIfEnd()
		end
		if TargetPlayers == CurrentPlayer or TargetPlayers == "CP" then
			f_SaveCp()
		end--
		BSize = 0
		

		dp.Alloc = dp.Alloc+1
		RetV = CreateVar(FP)
		Dev = 0

		if ResetTimer~=nil then
			
			if type(ResetTimer)=="table" and ResetTimer[4]== "V" then
				CIf(FP,{CV(ResetTimer,0)})

			elseif type(ResetTimer)=="number" then
				ResetTimerCode = CreateCcode()
				DoActionsX(FP,{SubCD(ResetTimerCode, 1)})
				CIf(FP,{CD(ResetTimerCode,0)},{SetCD(ResetTimerCode,ResetTimer)})

			end
		end
		CMov(FP,dp.publicItoCusPtr,RetV)
		local StrT = {}
		dp.StrXIndex=dp.StrXIndex+1
		for j,k in pairs(arg) do
			if type(k) == "function" then
				local PrevBSize = BSize
				k()
				local NextBSize = BSize
				table.insert(StrT,string.rep("\x0D",NextBSize-PrevBSize))
				
			elseif type(k)=="table" and type(k[1]) == "function" then
				local lfunc = k[1]
				local PrevBSize = BSize
				table.remove(k,1)
				lfunc(table.unpack(k))
				local NextBSize = BSize
				table.insert(StrT,string.rep("\x0D",NextBSize-PrevBSize))
			elseif type(k) == "string" then
				--local CT = CreateCText(FP,k)
				table.insert(StrT,k)
				BSize=BSize+#k
				Dev=Dev+#k
			elseif type(k)=="table" and k[1] == "PVA" then -- PNameVArr 우회전용
				BSize = BSize+(4*5)
				if k[2] == "LocalPlayerID" then
					CAdd(FP,dp.VtoNamePtr,RetV,Dev)
					CallTrigger(FP, dp.Call_VtoLPName)
				elseif type(k[2])=="number" then
					CAdd(FP,dp.VtoNamePtr,RetV,Dev)
					CallTrigger(FP, dp.Call_VtoName,{SetV(dp.VtoNameV,k[2])})
				elseif k[2][4] == "V" then
					CAdd(FP,dp.VtoNamePtr,RetV,Dev)
					CMov(FP,dp.VtoNameV,k[2])
					CallTrigger(FP, dp.Call_VtoName)
				end
				Dev=Dev+(4*5)
				table.insert(StrT,string.rep("\x0D",4*5))
			elseif type(k)=="table" and k[4]=="V" then
				if k["fwc"] == true then
					BSize=BSize+(4*12)
					CMov(FP,dp.publicItoDecV,k)
					CallTrigger(FP,dp.Call_IToDecX,{SetV(dp.DevV,Dev)}) 
					Dev=Dev+(4*12)
					table.insert(StrT,string.rep("\x0D",4*12))
				elseif k["hex"] == true then
					BSize=BSize+(3*4)
					CMov(FP,dp.publicItoDecV,k)
					CallTrigger(FP,dp.Call_ItoHex,{SetV(dp.DevV,Dev)}) 
					Dev=Dev+(3*4)
					table.insert(StrT,string.rep("\x0D",3*4))
				else
					BSize=BSize+(4*4)
					CMov(FP,dp.publicItoDecV,k)
					CallTrigger(FP,dp.Call_IToDec,{SetV(dp.DevV,Dev)}) 
					Dev=Dev+(4*4)
					table.insert(StrT,string.rep("\x0D",4*4))
				end
			elseif type(k)=="table" and k[4]=="W" then
				BSize=BSize+(4*5)
				f_LMov(FP, dp.publiclItoDecW, k, nil, nil, 1)
				CallTrigger(FP,dp.Call_lIToDec,{SetV(dp.DevV,Dev)}) 
				Dev=Dev+(4*5)
				table.insert(StrT,string.rep("\x0D",4*5))
			elseif type(k)=="table" and k[1][4]=="V" then -- VarArr일 경우
				BSize = BSize+#k
				for o,p in pairs(k) do
					CMov(FP,dp.TBwInputChar,p)
					CallTrigger(FP,dp.Call_TBwrite,{SetV(dp.DevV,Dev)}) 
					
					Dev=Dev+(1)
					table.insert(StrT,string.rep("\x0D",1))
				end
			elseif type(k)=="number" then -- 상수index V 입력, string.char 구현용. 맨앞 0xFF영역만 사용
				BSize=BSize+1
				CMov(FP,dp.TBwInputChar,V(k))
				CallTrigger(FP,dp.Call_TBwrite,{SetV(dp.DevV,Dev)}) 
				Dev=Dev+(1)
				table.insert(StrT,string.rep("\x0D",1))
			else
				PushErrorMsg("Print_Inputdata_Error")
			end
		end
		
		if ResetTimer~=nil then
			CIfEnd()

		end
		StrT = table.concat(StrT).."\x0D\x0D\x0D\x0D"
		table.insert(dp.StrXKeyArr,{RetV,StrT})
		if TargetPlayers==CurrentPlayer or TargetPlayers=="CP" then
			local Act = {TSetMemory(0x6509B0,SetTo,BackupCp),DisplayText(StrT,4)}
			if SoundRepeat ~= nil then
				for j,k in pairs(SoundRepeat) do
					table.insert(Act, PlayWAV(k))
				end
				
			end
			CDoActions(FP,Act,nil,nil)
		elseif type(TargetPlayers)=="table" and TargetPlayers[4]=="V" then
			
			local Act = {TSetMemory(0x6509B0,SetTo,TargetPlayers),DisplayText(StrT,4)}
			if SoundRepeat ~= nil then
				for j,k in pairs(SoundRepeat) do
					table.insert(Act, PlayWAV(k))
				end
				
			end
			CDoActions(FP,Act,nil,nil)
		else
			local RotAct = {DisplayTextX(StrT,4)}
			if SoundRepeat ~= nil then
				for j,k in pairs(SoundRepeat) do
					table.insert(RotAct, PlayWAVX(k))
				end
				
			end
			DoActionsX(FP,{RotatePlayer(RotAct,TargetPlayers,FP)},nil,nil)
		end
		RetV = nil
		Dev = nil
		BSize = nil
		
		if FixTextPreset == 3 or FixTextPreset == 2 then
			
			local TPArr = {}
			if type(TargetPlayers) == "number"  then
				TPArr = {TargetPlayers}
			end
	
			if #TPArr == 1 then
				CIf(FP, {TMemory(0x512684,Exactly,TPArr[1])})
			else
				local CondArr = {}
				for j,k in pairs(TPArr) do
					table.insert(CondArr, _TMemory(0x512684,Exactly,k))
				end
				CIf(FP,{TTOR(CondArr)})
				
			end
			FixText(FP,2)
	
	
			CIfEnd()
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
			local t = StrToMem(str)
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
		local ItoNameKey = {}
		local VCharKey = {}
		





		for j,k in pairs(arg) do
			if type(k) == "string" then
				local Strl = GetStrSize(0,k)
				if Strl%4~=0 then k=string.rep("\x0D", (4-Strl%4))..k Strl=Strl+(4-Strl%4) end
				table.insert(RetAct,print_utf8_2(12, Dev, k))
				Dev=Dev+Strl
			elseif type(k)=="table" and k[1] == "PVA" then -- PNameVArr 우회전용
				table.insert(ItoNameKey,{k[2],Dev})
				Dev=Dev+(4*5)
			elseif type(k)=="table" and k[4]=="V" then
				table.insert(RetAct,print_utf8_2(12, Dev, string.rep("\x0D", 16)))
				--V,Dev
				if k["fwc"] == true then
					table.insert(ItoDecKey,{k,Dev,true})
					Dev=Dev+(4*12)
				else
					table.insert(ItoDecKey,{k,Dev,false})
					Dev=Dev+(4*4)
				end
			elseif type(k)=="number" then -- 상수index V 입력, string.char 구현용. 맨앞 0xFF영역만 사용
				table.insert(RetAct,print_utf8_2(12, Dev, string.rep("\x0D", 1)))
				table.insert(VCharKey,{k,Dev})
				Dev=Dev+(1)

			else
				PushErrorMsg("Print_Inputdata_Error")
			end
		end
		local TPArr = TargetPlayer
		if type(TargetPlayer) == "number"  then
			TPArr = {TargetPlayer}
		end
		if TPArr[4] == "V" then
			CMov(FP,dp.Print13V,TPArr)
			CallTrigger(FP, dp.Call_Print13X)
		else
			for j,k in pairs(TPArr) do
				if type(k) == "number" then
					if  k>= 8 then PushErrorMsg("Invalid TargetPlayer. Please Select P1~P8") end
					if OP_Hold ~= "X" then 
						CallTrigger(FP, dp.Call_Print13X,{SetV(dp.Print13V,k),SetDeaths(k,SetTo,OP_Hold[2],OP_Hold[1])})
					else
						CallTrigger(FP, dp.Call_Print13X,{SetV(dp.Print13V,k)})
					end
				else --type == V
					if OP_Hold ~= "X" then 
						CDoActions(FP,{TSetDeaths(k,SetTo,OP_Hold[2],OP_Hold[1])})
					end
					CMov(FP,dp.Print13V,k)
					CallTrigger(FP, dp.Call_Print13X)
				end
		end 


			
		end

		if TPArr[4] == "V" then
			CIf(FP, {TMemory(0x512684,Exactly,TPArr)})
		else
			if #TPArr == 1 then
				CIf(FP, {TMemory(0x512684,Exactly,TPArr[1])})
			else
				local CondArr = {}
				for j,k in pairs(TPArr) do
					table.insert(CondArr, _TMemory(0x512684,Exactly,k))
				end
				CIf(FP,{TTOR(CondArr)})
				
			end
		end
		DoActions2(FP, {print_utf8_2(12, 0, string.rep("\x0D", 210))})
		DoActions2(FP, RetAct)
		CMov(FP,dp.publicItoCusPtr,0x640B60 + (12 * 218))
		for j,p in pairs(ItoDecKey) do
			local k = p[1]
			local bool = p[3]
			CMov(FP,dp.publicItoDecV,k)
			if bool == true then
				CallTrigger(FP,dp.Call_IToDecX,{SetV(dp.DevV,p[2])})
			else
				CallTrigger(FP,dp.Call_IToDec,{SetV(dp.DevV,p[2])})
			end
		end
		for j,p in pairs(ItoNameKey) do
			local k = p[1]
			
			if k == "LocalPlayerID" then
				CallTrigger(FP, dp.Call_VtoLPName,{SetV(dp.VtoNamePtr,0x640B60 + (12 * 218)+p[2])})
			elseif type(k)=="number" then
				CallTrigger(FP, dp.Call_VtoName,{SetV(dp.VtoNamePtr,0x640B60 + (12 * 218)+p[2]),SetV(dp.VtoNameV,k)})
			elseif k[4] == "V" then
				CallTrigger(FP, dp.Call_VtoName,{SetV(dp.VtoNamePtr,0x640B60 + (12 * 218)+p[2]),})
			end
			
		end
		for j,p in pairs(VCharKey) do
			CMov(FP,dp.TBwInputChar,V(p[1]))
			CallTrigger(FP,dp.Call_TBwrite,{SetV(dp.TBwInputChar,0x80),SetV(dp.publicItoCusPtr,0x640B60 + (12 * 218)),SetV(dp.DevV,p[2])}) 
		end
		CIfEnd()

	end

	function Print_13X(PlayerID,TargetPlayer)
		local Y = {}
		CIf(PlayerID,Memory(0x628438,AtLeast,1))
			f_ReadX(PlayerID,0x628438,V(FuncAlloc),1,0xFFFFFF)
			CDoActions(PlayerID,{SetMemory(0x628438,SetTo,0),TCreateUnit(1,0,"Anywhere",TargetPlayer)})
			--DoActions2(PlayerID, Y)
			CVariable2(PlayerID,FuncAlloc,0x628438,SetTo,0)
		CIfEnd()
		FuncAlloc = FuncAlloc + 1
	end


	function init_StrX()
		for k, v in pairs(dp.StrXKeyArr) do
			f_GetStrXptr(FP,v[1],v[2])
		end
		
		
		
		for k, v in pairs(dp.TBLKeyArr) do
			f_GetTblptr(FP,v[1],v[2])
		end

	end
	function init_Setting()
		
	function dp.ItoDec(PlayerID,Input,OutputVA,ZeroMode,Color,Sign,DigitMax,DigitMin) -- VA index = 상수 / Int -> Dec VA[0~3]
		STPopTrigArr(PlayerID)
	-- B = 0x20, C = ColorCod, S = Sign, 0~9 = Number, X = 0x0D
	-- ZeroMode : 0 표시 방법 선택 / 0 (0) / Space (1) / 0x0D (2)
	-- Color : 컬러코드 추가 / 0x01 ~ 0x1F (기본 0x0D)
	-- Sign : 부호 추가 / 부호없음 (0) / 부호추가(1) / 부호추가 +Space (2)
	-- DigitMax : 시작 자리수 (기본 10) / DigitMin : 끝 자리수 (기본1)
		if Sign == nil or Sign == "X" then
			Sign = 0
		end
		if Color == nil or Color == "X" or Color == 0 then
			Color = 0x0D
		end
		if ZeroMode == nil or ZeroMode == "X" then
			ZeroMode = 0
		end
		if ZeroMode == 0 then
			ZeroMode = 0x30
		elseif ZeroMode == 1 then
			ZeroMode = 0x20
		elseif ZeroMode == 2 then
			ZeroMode = 0x0D
		end
		if DigitMax == nil or DigitMax == "X" then
			DigitMax = 10
		end
		if DigitMin == nil or DigitMin == "X" then
			DigitMin = 1
		end

		local X = {}
		if Sign == 0 then
			Trigger {
				players = {PlayerID},
				conditions = {
					Label(0);
				},
				actions = {
					SetCtrig1X(Input[1],Input[2],0x148,Input[3],SetTo,0xFFFFFFFF);
					SetCtrig1X(Input[1],Input[2],0x160,Input[3],SetTo,SetTo*16777216,0xFF000000);
					SetCtrigX(Input[1],Input[2],0x158,Input[3],SetTo,"X",CRet[1],0x15C,1,0);
					CallLabelAlways(Input[1],Input[2],Input[3]);
				},
				flag = {preserved}
			}
		else
			CIfX(PlayerID, CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x7FFFFFFF))
				Trigger {
					players = {PlayerID},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X(Input[1],Input[2],0x148,Input[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Input[1],Input[2],0x160,Input[3],SetTo,SetTo*16777216,0xFF000000);
						SetCtrigX(Input[1],Input[2],0x158,Input[3],SetTo,"X",CRet[1],0x15C,1,0);
						CallLabelAlways(Input[1],Input[2],Input[3]);
					},
					flag = {preserved}
				}
			CElseX()
				Trigger {
					players = {PlayerID},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,SetTo,0xFFFFFFFF);
						SetCtrig1X(Input[1],Input[2],0x148,Input[3],SetTo,0xFFFFFFFF);
						SetCtrig1X(Input[1],Input[2],0x160,Input[3],SetTo,Subtract*16777216,0xFF000000);
						SetCtrigX(Input[1],Input[2],0x158,Input[3],SetTo,"X",CRet[1],0x15C,1,0);
						CallLabelAlways(Input[1],Input[2],Input[3]);
					},
					flag = {preserved}
				}
				Trigger {
					players = {PlayerID},
					conditions = {
						Label(0);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,Add,1);
					},
					flag = {preserved}
				}
			CIfXEnd()
		end
		-- XXXX[0] 90SC[1] 5678[2] 1234[3] / CXXX[0] 90BS[1] 5678[2] 1234[3]
		if Sign == 0 then
			DoActionsX(PlayerID,{SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3],SetTo,0x0D0D0D0D),
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x30*0x01010000 + 0x00000D00 + Color*0x00000001),
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x30*0x01010101),
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x30*0x01010101)})
		elseif Sign == 1 then
			DoActionsX(PlayerID,{SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3],SetTo,0x0D0D0D0D),
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x30*0x01010000 + 0x00000D00 + Color*0x00000001),
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x30*0x01010101),
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x30*0x01010101)})
			Trigger {players = {PlayerID},conditions = {Label(0);CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x7FFFFFFF);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x00000D00,0x0000FF00)},flag = {preserved}}
			Trigger {players = {PlayerID},conditions = {Label(0);CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x80000000);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x00002D00,0x0000FF00)},flag = {preserved}}
		elseif Sign == 2 then
			DoActionsX(PlayerID,{SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3],SetTo,0x000D0D0D + Color * 0x01000000),
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x30*0x01010000 + 0x0000200D),
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x30*0x01010101),
					SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x30*0x01010101)})
			Trigger {players = {PlayerID},conditions = {Label(0);CtrigX(Input[1],Input[2],0x15C,Input[3],AtMost,0x7FFFFFFF);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0000000D,0x000000FF)},flag = {preserved}}
			Trigger {players = {PlayerID},conditions = {Label(0);CtrigX(Input[1],Input[2],0x15C,Input[3],AtLeast,0x80000000);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0000002D,0x000000FF)},flag = {preserved}}
		end

		Trigger {players = {PlayerID},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,999999999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x00010000*ZeroMode,0x00FF0000)},flag = {preserved}}
		Trigger {players = {PlayerID},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,99999999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x01000000*ZeroMode,0xFF000000)},flag = {preserved}}
		Trigger {players = {PlayerID},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,9999999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x00000001*ZeroMode,0x000000FF)},flag = {preserved}}
		Trigger {players = {PlayerID},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,999999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x00000100*ZeroMode,0x0000FF00)},flag = {preserved}}
		Trigger {players = {PlayerID},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,99999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x00010000*ZeroMode,0x00FF0000)},flag = {preserved}}
		Trigger {players = {PlayerID},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,9999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x01000000*ZeroMode,0xFF000000)},flag = {preserved}}
		Trigger {players = {PlayerID},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,999);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x00000001*ZeroMode,0x000000FF)},flag = {preserved}}
		Trigger {players = {PlayerID},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,99);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x00000100*ZeroMode,0x0000FF00)},flag = {preserved}}
		Trigger {players = {PlayerID},conditions = {Label(0);CtrigX("X",CRet[1],0x15C,0,AtMost,9);},actions = {SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x00010000*ZeroMode,0x00FF0000)},flag = {preserved}}
			
		for i = 2, 0, -1 do
				CBit = 2^i * 1000000000
				Trigger {
					players = {PlayerID},
					conditions = {
						Label(0);
						CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
						SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,Add,2^i*0x010000);
					},
					flag = {preserved}
				}
		end

		for i = 3, 0, -1 do
				CBit = 2^i * 100000000
				Trigger {
					players = {PlayerID},
					conditions = {
						Label(0);
						CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
						SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,Add,2^i*0x01000000);
					},
					flag = {preserved}
				}
		end

		for i = 3, 0, -1 do
				CBit = 2^i * 10000000
				Trigger {
					players = {PlayerID},
					conditions = {
						Label(0);
						CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
						SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,Add,2^i*0x00000001);
					},
					flag = {preserved}
				}
		end

		for i = 3, 0, -1 do
				CBit = 2^i * 1000000
				Trigger {
					players = {PlayerID},
					conditions = {
						Label(0);
						CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
						SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,Add,2^i*0x0100);
					},
					flag = {preserved}
				}
		end

		for i = 3, 0, -1 do
				CBit = 2^i * 100000
				Trigger {
					players = {PlayerID},
					conditions = {
						Label(0);
						CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
						SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,Add,2^i*0x010000);
					},
					flag = {preserved}
				}
		end

		for i = 3, 0, -1 do
				CBit = 2^i * 10000
				Trigger {
					players = {PlayerID},
					conditions = {
						Label(0);
						CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
						SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,Add,2^i*0x01000000);
					},
					flag = {preserved}
				}
		end

		for i = 3, 0, -1 do
				CBit = 2^i * 1000
				Trigger {
					players = {PlayerID},
					conditions = {
						Label(0);
						CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
						SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,Add,2^i*0x01);
					},
					flag = {preserved}
				}
		end

		for i = 3, 0, -1 do
				CBit = 2^i * 100
				Trigger {
					players = {PlayerID},
					conditions = {
						Label(0);
						CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
						SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,Add,2^i*0x0100);
					},
					flag = {preserved}
				}
		end

		for i = 3, 0, -1 do
				CBit = 2^i * 10
				Trigger {
					players = {PlayerID},
					conditions = {
						Label(0);
						CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
						SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,Add,2^i*0x010000);
					},
					flag = {preserved}
				}
		end

		for i = 3, 0, -1 do
				CBit = 2^i * 1
				Trigger {
					players = {PlayerID},
					conditions = {
						Label(0);
						CtrigX("X",CRet[1],0x15C,0,AtLeast,CBit);
					},
					actions = {
						SetCtrig1X("X",CRet[1],0x15C,0,Subtract,CBit);
						SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,Add,2^i*0x01000000);
					},
					flag = {preserved}
				}
		end

		if DigitMax == 9 then
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0x00FF0000))
		elseif DigitMax == 8 then
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFF0000))
		elseif DigitMax == 7 then
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFF0000))
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0x000000FF))
		elseif DigitMax == 6 then
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFF0000))
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0x0000FFFF))
		elseif DigitMax == 5 then
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFF0000))
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0x00FFFFFF))
		elseif DigitMax == 4 then
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFF0000))
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFFFF))
		elseif DigitMax == 3 then
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFF0000))
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFFFF))
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0x000000FF))
		elseif DigitMax == 2 then
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFF0000))
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFFFF))
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0x0000FFFF))
		elseif DigitMax == 1 then
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFFFF0000))
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFFFF))
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0x00FFFFFF))
		end

		if DigitMin == 2 then
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFF000000))
		elseif DigitMin == 3 then
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFF0000))
		elseif DigitMin == 4 then
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFF00))
		elseif DigitMin == 5 then
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFFFF))
		elseif DigitMin == 6 then
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFFFF))
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFF000000))
		elseif DigitMin == 7 then
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFFFF))
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFF0000))
		elseif DigitMin == 8 then
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFFFF))
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFF00))
		elseif DigitMin == 9 then
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFFFF))
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFFFF))
		elseif DigitMin == 10 then
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+3,SetTo,0x0D0D0D0D,0xFFFFFFFF))
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+2,SetTo,0x0D0D0D0D,0xFFFFFFFF))
			table.insert(X,SetCtrig1X(OutputVA[1],OutputVA[2],0x15C,OutputVA[3]+1,SetTo,0x0D0D0D0D,0xFF000000))
		end
		DoActionsX(PlayerID,X)
	end


		CJump(FP, dp.CustominitJump)
		for i = 0, 6 do
			ItoName(FP,i,VArr(dp.PNameVArrArr[i+1],0),ColorCode[i+1])
			_0DPatchforVArr(FP,dp.PNameVArrArr[i+1],4)

			CIf(FP,{LocalPlayerID(i)})--로컬
			ItoName(FP,i,VArr(dp.LPNameVArr,0),ColorCode[i+1])
			_0DPatchforVArr(FP,dp.LPNameVArr,4)
			CIfEnd()
		end

		init_StrX()
		
		DoActionsX(FP,{SetNext(dp.initTrigIndex, dp.initTrigIndex,1),SetNext("X", dp.initTrigIndex,1)},1,dp.lastTrigIndex)--RecoverNext

		local SCJump = def_sIndex()
		CJump(FP,SCJump)
		SetCall2(FP, dp.Call_IToDec)
		dp.ItoDec(FP,dp.publicItoDecV,VArr(dp.publicItoDecVArr,0),2,nil,1)
		f_Movcpy(FP,_Add(dp.publicItoCusPtr,dp.DevV),VArr(dp.publicItoDecVArr,0),4*4)
		SetCallEnd2()
		
		SetCall2(FP, dp.Call_IToDecX)
		ItoDecX(FP,dp.publicItoDecV,VArr(dp.publicItoDecVArrX,0),2,nil,0)
		f_Movcpy(FP,_Add(dp.publicItoCusPtr,dp.DevV),VArr(dp.publicItoDecVArrX,0),4*12)
		SetCallEnd2()

		SetCall2(FP, dp.Call_ItoHex)
		ItoHex(FP, dp.publicItoDecV, VArr(dp.publicItoHexVArr,0), 0, nil, 0)
		f_Movcpy(FP,_Add(dp.publicItoCusPtr,dp.DevV),VArr(dp.publicItoHexVArr,0),3*4)
		SetCallEnd2()

		SetCall2(FP, dp.Call_VtoName)
		for i = 0,6 do
		CIf(FP,{CV(dp.VtoNameV,i)})
		f_Movcpy(FP, dp.VtoNamePtr, dp.PNameVArrArr[i+1], 4*5)
		CIfEnd()
		end
		SetCallEnd2()

		SetCall2(FP, dp.Call_VtoLPName)
		f_Movcpy(FP, dp.VtoNamePtr, dp.LPNameVArr[i+1], 4*5)
		CIfEnd()
		SetCallEnd2()
		
		SetCall2(FP, dp.Call_TBwrite)
		CDoActions(FP,{TBwrite(_Add(dp.publicItoCusPtr,dp.DevV),SetTo,dp.TBwInputChar)})
		SetCallEnd2()
		
		
		if CheckInclude_64BitLibrary == 1 then
		SetCall2(FP, dp.Call_lIToDec)
		DoActionsX(FP, {
			SetCVAar(VArr(dp.publiclItoDecVArr,0), SetTo, 0x30303030),
			SetCVAar(VArr(dp.publiclItoDecVArr,1), SetTo, 0x30303030),
			SetCVAar(VArr(dp.publiclItoDecVArr,2), SetTo, 0x30303030),
			SetCVAar(VArr(dp.publiclItoDecVArr,3), SetTo, 0x30303030),
			SetCVAar(VArr(dp.publiclItoDecVArr,4), SetTo, 0x30303030)})--init << 0
		local li = def_sIndex()
		NJump(FP,li,{TTNWar(dp.publiclItoDecW,AtLeast,"0x8000000000000000")},{
			SetCVAar(VArr(dp.publiclItoDecVArr,0), SetTo, 0x30303000+string.byte("-")),--음수이다
			SetCVAar(VArr(dp.publiclItoDecVArr,1), SetTo, 0x30303030),
			SetCVAar(VArr(dp.publiclItoDecVArr,2), SetTo, 0x30303030),
			SetCVAar(VArr(dp.publiclItoDecVArr,3), SetTo, 0x30303030),
			SetCVAar(VArr(dp.publiclItoDecVArr,4), SetTo, 0x30303030)})--<<Zeromode = 0x0D
			for i = 19, 1, -1 do
				local wt = string.rep("9",i)
				local mb = 3-i%4
				local MaskBit = 256^mb
				local idx = 4-math.floor(i/4)
				CTrigger(FP,{TTNWar(dp.publiclItoDecW,AtMost,wt)},{SetCVAar(VArr(dp.publiclItoDecVArr,idx),SetTo,MaskBit*0x0D,MaskBit*0xFF)},1)--<<Zeromode = 0x0D
			end--
			NJumpEnd(FP,li)
			CIf(FP,{TTNWar(dp.publiclItoDecW,AtLeast,"0x8000000000000000")})
			f_LNeg(FP, dp.publiclItoDecW, dp.publiclItoDecW)--음수표현을 위해 반전
			CIfEnd()
			function dp.War_NumSet(DestVAI,DivNum,MaskBit)
				local MaskBit = 256^MaskBit
				for i = 3, 0, -1 do
					local CBit = math.floor(2^i)
					local nt = tostring(CBit)..string.rep("0",DivNum)
					CIf(FP,{TTNWar(dp.publiclItoDecW, AtLeast, nt)},{SetCVAar(VArr(dp.publiclItoDecVArr,DestVAI), Add, CBit*MaskBit,MaskBit*0xFF)})
					f_LSub(FP, dp.publiclItoDecW, dp.publiclItoDecW, nt)
					CIfEnd()
				end
			end
			for i = 18, 0, -1 do
				local mb=3-(i%4)
				local mi=4-math.floor(i/4)
				dp.War_NumSet(mi,i,mb)
			end
			--


			f_Movcpy(FP,_Add(dp.publicItoCusPtr,dp.DevV),VArr(dp.publiclItoDecVArr,0),4*5)
		SetCallEnd2()--
		end

	--	SetCall2(FP, dp.Call_lIToDec)
	--	DoActionsX(FP, {
	--		SetCVAar(VArr(dp.publiclItoDecVArr,0), SetTo, 0x30303030),
	--		SetCVAar(VArr(dp.publiclItoDecVArr,1), SetTo, 0x30303030),
	--		SetCVAar(VArr(dp.publiclItoDecVArr,2), SetTo, 0x30303030),
	--		SetCVAar(VArr(dp.publiclItoDecVArr,3), SetTo, 0x30303030),
	--		SetCVAar(VArr(dp.publiclItoDecVArr,4), SetTo, 0x30303030)})--init << 0
	--	CIfX(FP,{TTNWar(dp.publiclItoDecW,AtLeast,"1"..string.rep("0",19))},{
	--		SetCVAar(VArr(dp.publiclItoDecVArr,0), SetTo, 0x30303031),
	--		SetCVAar(VArr(dp.publiclItoDecVArr,1), SetTo, 0x30303030),
	--		SetCVAar(VArr(dp.publiclItoDecVArr,2), SetTo, 0x30303030),
	--		SetCVAar(VArr(dp.publiclItoDecVArr,3), SetTo, 0x30303030),
	--		SetCVAar(VArr(dp.publiclItoDecVArr,4), SetTo, 0x30303030),})
	--		f_LSub(FP, dp.publiclItoDecW, dp.publiclItoDecW, "1"..string.rep("0",19))
	--	CElseX()
	--	for i = 19, 1, -1 do
	--		local wt = string.rep("9",i)
	--		local mb = 3-i%4
	--		local MaskBit = 256^mb
	--		local idx = 4-math.floor(i/4)
	--		CTrigger(FP,{TTNWar(dp.publiclItoDecW,AtMost,wt)},{SetCVAar(VArr(dp.publiclItoDecVArr,idx),SetTo,MaskBit*0x0D,MaskBit*0xFF)},1)--<<Zeromode = 0x0D
	--	end
	--	CIfXEnd()--

	--		function dp.War_NumSet(DestVAI,DivNum,MaskBit)
	--			local MaskBit = 256^MaskBit
	--			for i = 3, 0, -1 do
	--				local CBit = 2^i
	--				local nt = tostring(CBit)..string.rep("0",DivNum)
	--				CIf(FP,{TTNWar(dp.publiclItoDecW, AtLeast, nt)},{SetCVAar(VArr(dp.publiclItoDecVArr,DestVAI), Add, CBit*MaskBit,MaskBit*0xFF)})
	--				f_LSub(FP, dp.publiclItoDecW, dp.publiclItoDecW, nt)
	--				CIfEnd()
	--			end
	--		end
	--		for i = 18, 0, -1 do
	--			local mb=3-(i%4)
	--			local mi=4-math.floor(i/4)
	--			dp.War_NumSet(mi,i,mb)
	--		end
	--		--
	--
	--

	--	SetCallEnd2()

		SetCall2(FP, dp.Call_Print13X)
		Print_13X(FP,dp.Print13V)
		SetCallEnd2()




		CJumpEnd(FP,SCJump)
		CJumpEnd(FP, dp.CustominitJump)
	end

	function DP_Start_init(FixedPlayer,DP_OP_Hold,AllocStart,AllocEnd,SettingOp)
		
	ColorCode = {0x08,0x0E,0x0F,0x10,0x11,0x15,0x16,0x17}
		if FixedPlayer~=nil then FP = FixedPlayer end
		if FixedPlayer == nil and FP == nil then
			PushErrorMsg("Need FixedPlayer")
		end
		if DP_OP_Hold ~= nil then
			if type(DP_OP_Hold)~= "table" then
				PushErrorMsg("OP_Hold Factor Error. Help: {DeathUnit,Value}")
			end
			OP_Hold = DP_OP_Hold
		else
			OP_Hold = "X"
		end


		if STRCTRIGASM == 0 then
			PushErrorMsg("Need_STRCTRIGASM")
		end
		dp={}
		if AllocStart == nil then
			dp.Alloc = 0xC000
		else dp.Alloc = AllocStart
			
		end
		if AllocEnd == nil then
			dp.AllocLimit = 0xF000
		else dp.AllocLimit = AllocEnd
		end
		
		dp.LPNameVArr = CreateVArr(5,FP)
		dp.VPNameVArr = CreateVArr(5,FP)
		dp.ColorCode = {0x08,0x0E,0x0F,0x10,0x11,0x15,0x16}
		dp.PNameVArrArr = CreateVArrArr(7, 5, FP)
		dp.CustominitJump = def_sIndex()
		dp.initTrigIndex = FuncAlloc
		FuncAlloc=FuncAlloc+1
		dp.lastTrigIndex = FuncAlloc
		FuncAlloc=FuncAlloc+1
		dp.StrXKeyArr = {}
		dp.StrXIndex = 0
		dp.publicItoDecVArr =CreateVArr(4,FP)
		dp.publicItoHexVArr =CreateVArr(3,FP)
		dp.publicItoDecVArrX =CreateVArr(12,FP)
		dp.publicItoDecV = CreateVar(FP)
		dp.publicItoCusPtr = CreateVar(FP)
		dp.TBwInputChar = CreateVar(FP)
		dp.DevV = CreateVar(FP)
		
		dp.Call_IToDec = CreateCallIndex()
		dp.Call_IToDecX = CreateCallIndex()
		dp.Call_VtoName = CreateCallIndex()
		dp.Call_ItoHex = CreateCallIndex()
		dp.Call_Print13X = CreateCallIndex()
		dp.Call_TBwrite = CreateCallIndex()
		dp.Call_VtoLPName = CreateCallIndex()
		
		dp.Print13V = CreateVar(FP)
		dp.publiclItoDecVArr =CreateVArr(5,FP)
		dp.publiclItoDecW = CreateWar(FP)
		dp.Call_lIToDec = CreateCallIndex()
		dp.VtoNamePtr = CreateVar(FP)
		dp.VtoNameV = CreateVar(FP)
		dp.VtoLPNamePtr = CreateVar(FP)

		dp.TBLKeyArr = {}
		dp.TBLPatchArr = {}
		dp.TBLPNameArr = {}
		dp.TBOLutputTxt = {}

	if #dp.TBOLutputTxt~=0 then
	os.execute("mkdir " .. "DP_TBL")
	local CSfile = io.open(FileDirectory .. "DP_TBL" .. ".txt", "w")
	io.output(CSfile)
	for j,k in pairs(dp.TBOLutputTxt) do
		io.write(k)
	end
	io.close(CSfile)
	end



		
	function _0DPatchforVArr(Player,VArrName,VArrLength) -- CtrigAsm 5.1
		for j=0, VArrLength do
			for k=0, 3 do
			TriggerX(Player,{VArrayX(VArr(VArrName,j),"Value",Exactly,0,255*(256^k))},{
			SetVArrayX(VArr(VArrName,j),"Value",SetTo,(256^k)*0x0D,255*(256^k))})
			end
		end
	end
	function PName(Player) -- "LocalPlayerID" = LocalPName
		return {"PVA",Player}
	end
	if SettingOp == nil then
		DoActionsX(FP, {SetNext("X", dp.CustominitJump+JumpStartAlloc,1),SetNext(dp.lastTrigIndex, "X",1)}, 1,dp.initTrigIndex)
	else
		return {"DoActionsX",FP,{SetNext("X", dp.CustominitJump+JumpStartAlloc,1),SetNext(dp.lastTrigIndex, "X",1)},1,dp.initTrigIndex}
	end
	end


	
function print_utf8_A(DB, string)
	local ret = {}
	
	if type(string) == "string" then
		local str = string
		local n = 1
		if #str % 4 >= 1 then
			for i = 1, #str % 4 do str = '\x0d'..str end
		end
		local t = StrToMem(str)
		while n <= #t do
			ret[#ret+1] = SetCtrig1X(FP,DB[2],(((n-1)//4)+(math.floor(((n-1)//4)/602))*2)*4,0, SetTo, _dw(t, n))
			n = n + 4
		end
	elseif type(string) == "number" then
		PushErrorMsg("print_utf8_InputError")
	end
	return ret
end