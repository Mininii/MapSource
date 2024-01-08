
		
	function DisplayPrint(TargetPlayers,arg) -- ext text ver
		if TargetPlayers == CurrentPlayer or TargetPlayers == "CP" then
			f_SaveCp()
		end--
		local BSize = 0
		for j,k in pairs(arg) do -- StrSizeCalc
			if type(k) == "string" then
				local CT = GetStrSize(0,k)
				BSize=BSize+CT
			elseif type(k)=="table" and k[1] == "PVA" then -- PNameVArr ��ȸ����
				BSize = BSize+(4*5)
			elseif type(k)=="table" and k[4]=="V" then
				if k["fwc"] == true then
					BSize=BSize+(4*12)
				else
					BSize=BSize+(4*4)
				end
			elseif type(k)=="table" and k[4]=="W" then
				BSize=BSize+(4*5)
			elseif type(k)=="table" and k[1][4]=="V" then -- VarArr�� ���
				BSize = BSize+#k
			elseif type(k)=="number" then -- ���index V �Է�, string.char ������. �Ǿ� 0xFF������ ���
				BSize=BSize+1
			else
				PushErrorMsg("Print_Inputdata_Error")
			end
		end
		local StrT = "\x0D\x0D\x0DSI"..dp.StrXIndex..string.rep("\x0D", BSize+3)
		
		if ExtTextArr[StrT] == nil then
			ExtTextArr[StrT] = ExtTextIndex
			ExtTextFile[ExtTextIndex] = StrT
			ExtTextIndex = ExtTextIndex + 1
		end--

		local StrKey = ExtTextArr[StrT]
		local ExtTextTrigIdx = dp.Alloc
		dp.Alloc = dp.Alloc+1
		local RetV = CreateVar(FP)
		local Dev = 0
		table.insert(dp.ExtTextDataArr,{RetV,ExtTextTrigIdx})
		dp.StrXIndex=dp.StrXIndex+1
		for j,k in pairs(arg) do
			if type(k) == "string" then
				local CT = CreateCText(FP,k)
				table.insert(dp.StrXPatchArr,{RetV,Dev,CT})
				Dev=Dev+CT[2]
			elseif type(k)=="table" and k[1] == "PVA" then -- PNameVArr ��ȸ����
				if k[2] == "LocalPlayerID" then
					table.insert(dp.StrXPNameArr,{RetV,Dev,dp.LPNameVArr})
				elseif type(k[2])=="number" then
					table.insert(dp.StrXPNameArr,{RetV,Dev,dp.PNameVArrArr[k[2]+1]})
				elseif k[2][4] == "V" then
					CAdd(FP,dp.VtoNamePtr,RetV,Dev)
					CMov(FP,dp.VtoNameV,k[2])
					CallTrigger(FP, dp.Call_VtoName)
				end
				Dev=Dev+(4*5)
			elseif type(k)=="table" and k[4]=="V" then
				if k["fwc"] == true then
					CMov(FP,dp.publicItoDecV,k)
					CallTrigger(FP,dp.Call_IToDecX)
					f_Movcpy(FP,_Add(RetV,Dev),VArr(dp.publicItoDecVArrX,0),4*12)
					Dev=Dev+(4*12)
				else
					CMov(FP,dp.publicItoDecV,k)
					CallTrigger(FP,dp.Call_IToDec)
					f_Movcpy(FP,_Add(RetV,Dev),VArr(dp.publicItoDecVArr,0),4*4)
					Dev=Dev+(4*4)
				end
			elseif type(k)=="table" and k[4]=="W" then
				f_LMov(FP, dp.publiclItoDecW, k, nil, nil, 1)
				CallTrigger(FP,dp.Call_lIToDec)
				f_Movcpy(FP,_Add(RetV,Dev),VArr(dp.publiclItoDecVArr,0),4*5)
				Dev=Dev+(4*5)
			elseif type(k)=="table" and k[1][4]=="V" then -- VarArr�� ���
				for o,p in pairs(k) do
					CDoActions(FP,{TBwrite(_Add(RetV,Dev),SetTo,p)})
					Dev=Dev+(1)
				end
			elseif type(k)=="number" then -- ���index V �Է�, string.char ������. �Ǿ� 0xFF������ ���
				CDoActions(FP,{TBwrite(_Add(RetV,Dev),SetTo,V(k))})
				Dev=Dev+(1)
			else
				PushErrorMsg("Print_Inputdata_Error")
			end
		end
		if TargetPlayers==CurrentPlayer or TargetPlayers=="CP" then
			CDoActions(FP,{TSetMemory(0x6509B0,SetTo,BackupCp),Action(0, StrKey, 0, 0, 0, 0, 0, 6, 0, 4)},nil,ExtTextTrigIdx)
		elseif type(TargetPlayers)=="table" and TargetPlayers[4]=="V" then
			CDoActions(FP,{TSetMemory(0x6509B0,SetTo,TargetPlayers),Action(0, StrKey, 0, 0, 0, 0, 0, 6, 0, 4)},nil,ExtTextTrigIdx)
		else
			DoActionsX(FP,{RotatePlayer({Action(0, StrKey, 0, 0, 0, 0, 0, 6, 0, 4)},TargetPlayers,FP)},nil,ExtTextTrigIdx)
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
		local ItoNameKey = {}
		local VCharKey = {}
		





		for j,k in pairs(arg) do
			if type(k) == "string" then
				local Strl = GetStrSize(0,k)
				if Strl%4~=0 then k=string.rep("\x0D", (4-Strl%4))..k Strl=Strl+(4-Strl%4) end
				table.insert(RetAct,print_utf8_2(12, Dev, k))
				
				Dev=Dev+Strl
			elseif type(k)=="table" and k[1] == "PVA" then -- PNameVArr ��ȸ����
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
			elseif type(k)=="number" then -- ���index V �Է�, string.char ������. �Ǿ� 0xFF������ ���
				table.insert(RetAct,print_utf8_2(12, Dev, string.rep("\x0D", 1)))
				table.insert(VCharKey,{k,Dev})
				Dev=Dev+(1)

			else
				PushErrorMsg("Print_Inputdata_Error")
			end
		end
		local TPArr = {}
		if type(TargetPlayer) == "number"  then
			TPArr = {TargetPlayer}
		end

		for j,k in pairs(TPArr) do
			if type(k) == "number" then
				if  k>= 8 then PushErrorMsg("Invalid TargetPlayer. Please Select P1~P8") end
				if OP_Hold ~= nil then
					CallTrigger(FP, dp.Call_Print13X,{SetV(dp.Print13V,k),SetDeaths(k,SetTo,OP_Hold[2],OP_Hold[1])})
				else
					CallTrigger(FP, dp.Call_Print13X,{SetV(dp.Print13V,k)})
				end
			else --type == V
				if OP_Hold ~= nil then
					CDoActions(FP,{TSetDeaths(k,SetTo,OP_Hold[2],OP_Hold[1])})
				end
				CMov(FP,dp.Print13V,k)
				CallTrigger(FP, dp.Call_Print13X)
			end


			
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
		DoActions2(FP, RetAct)
		for j,p in pairs(ItoDecKey) do
			local k = p[1]
			local bool = p[3]
			CMov(FP,dp.publicItoDecV,k)
			if bool == true then
				CallTrigger(FP,dp.Call_IToDecX)
				f_Movcpy(FP,0x640B60 + (12 * 218)+p[2],VArr(dp.publicItoDecVArrX,0),4*12)
			else
				CallTrigger(FP,dp.Call_IToDec)
				f_Movcpy(FP,0x640B60 + (12 * 218)+p[2],VArr(dp.publicItoDecVArr,0),4*4)
			end
		end
		for j,p in pairs(ItoNameKey) do
			local k = p[1]
			
			if k == "LocalPlayerID" then
				f_Movcpy(FP,0x640B60 + (12 * 218)+p[2],VArr(dp.LPNameVArr,0),4*5)
			elseif type(k)=="number" then
				f_Movcpy(FP,0x640B60 + (12 * 218)+p[2],VArr(dp.PNameVArrArr[k],0),4*5)
			elseif k[4] == "V" then
				CMov(FP,dp.VtoNamePtr,0x640B60 + (12 * 218)+p[2])
				CMov(FP,dp.VtoNameV,k)
				CallTrigger(FP, dp.Call_VtoName)
			end
			
		end
		for j,p in pairs(VCharKey) do
			CDoActions(FP,{TBwrite(0x640B60 + (12 * 218)+p[2],SetTo,V(p[1]))})
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
		for k, v in pairs(dp.StrXKeyArr) do
			f_GetStrXptr(FP,v[1],v[2])
		end
		for k, v in pairs(dp.ExtTextDataArr) do
			f_GetStrXptr(FP,v[1],_ReadF({FP,v[2],CAddr("Str",2),0}))
		end
		
		
		for k, v in pairs(dp.StrXPatchArr) do -- STRXPtr,Deviation,CTextData
			if v[2]==0 then
				f_Memcpy(FP,v[1],_TMem(Arr(v[3][3],0),"X","X",1),v[3][2])
			else
				f_Memcpy(FP,_Add(v[1],v[2]),_TMem(Arr(v[3][3],0),"X","X",1),v[3][2])
			end
		end

		for k, v in pairs(dp.StrXPNameArr) do -- STRXPtr,Deviation,PNameVArr
			f_Movcpy(FP,_Add(v[1],v[2]),VArr(v[3],0),4*5)
		end

	end
	function init_Setting()
		
	function dp.ItoDec(PlayerID,Input,OutputVA,ZeroMode,Color,Sign,DigitMax,DigitMin) -- VA index = ��� / Int -> Dec VA[0~3]
		STPopTrigArr(PlayerID)
	-- B = 0x20, C = ColorCod, S = Sign, 0~9 = Number, X = 0x0D
	-- ZeroMode : 0 ǥ�� ��� ���� / 0 (0) / Space (1) / 0x0D (2)
	-- Color : �÷��ڵ� �߰� / 0x01 ~ 0x1F (�⺻ 0x0D)
	-- Sign : ��ȣ �߰� / ��ȣ���� (0) / ��ȣ�߰�(1) / ��ȣ�߰� +Space (2)
	-- DigitMax : ���� �ڸ��� (�⺻ 10) / DigitMin : �� �ڸ��� (�⺻1)
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

			CIf(FP,{LocalPlayerID(i)})--����
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
		SetCallEnd2()
		
		SetCall2(FP, dp.Call_IToDecX)
		ItoDecX(FP,dp.publicItoDecV,VArr(dp.publicItoDecVArrX,0),2,nil,1)
		SetCallEnd2()

		SetCall2(FP, dp.Call_VtoName)
		for i = 0,6 do
		CIf(FP,{CV(dp.VtoNameV,i)})
		f_Movcpy(FP, dp.VtoNamePtr, dp.PNameVArrArr[i+1], 4*5)
		CIfEnd()
		end

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
			SetCVAar(VArr(dp.publiclItoDecVArr,0), SetTo, 0x30303000+string.byte("-")),--�����̴�
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
			f_LNeg(FP, dp.publiclItoDecW, dp.publiclItoDecW)--����ǥ���� ���� ����
			CIfEnd()
			function dp.War_NumSet(DestVAI,DivNum,MaskBit)
				local MaskBit = 256^MaskBit
				for i = 3, 0, -1 do
					local CBit = 2^i
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
		if FixedPlayer == nil and FP == nil then
			PushErrorMsg("Need FixedPlayer")
		end
		if FixedPlayer~=nil then FP = FixedPlayer end
		if DP_OP_Hold ~= nil then
			if type(DP_OP_Hold)~= "table" then
				PushErrorMsg("OP_Hold Factor Error. Help: {DeathUnit,Value}")
			end
			OP_Hold = DP_OP_Hold
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
		dp.StrXPatchArr = {}
		dp.StrXPNameArr = {}
		dp.StrXIndex = 0
		dp.publicItoDecVArr =CreateVArr(4,FP)
		dp.publicItoDecVArrX =CreateVArr(12,FP)
		dp.publicItoDecV = CreateVar(FP)
		dp.Call_IToDec = CreateCallIndex()
		dp.Call_IToDecX = CreateCallIndex()
		dp.Call_VtoName = CreateCallIndex()
		
		dp.Call_Print13X = CreateCallIndex()
		dp.Print13V = CreateVar(FP)
		if CheckInclude_64BitLibrary == 1 then
			dp.publiclItoDecVArr =CreateVArr(5,FP)
			dp.publiclItoDecW = CreateWar(FP)
			dp.Call_lIToDec = CreateCallIndex()
		end
		dp.VtoNamePtr = CreateVar(FP)
		dp.VtoNameV = CreateVar(FP)
		dp.ExtTextDataArr = {}
		
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
