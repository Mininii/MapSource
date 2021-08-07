
function InstallGunData()
	function Case_OverCocoon()
		CIf(FP,CVar(FP,Var_TempTable[1][2],Exactly,201))--오버코쿤
			CIf(FP,{CVar(FP,Var_TempTable[5][2],AtMost,0),CVar(FP,Var_TempTable[6][2],Exactly,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,15000)})
				CMov(FP,ReserveBGM,5)
				GunBreak("\x07ＣｏＣｏｏｎ",77000)

			CIfEnd()
			CIf(FP,CVar(FP,Var_TempTable[5][2],AtLeast,15000))
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,1),Gun_Line(5,Exactly,0),Gun_Line(1,AtMost,48*32)},{40,43},"ACAS",CC_L,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,1),Gun_Line(5,Exactly,0),Gun_Line(1,AtLeast,48*32)},{40,43},"ACAS",CC_R,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,1),Gun_Line(5,Exactly,1),Gun_Line(1,AtMost,48*32)},{39,44},"ACAS",CC_L,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,1),Gun_Line(5,Exactly,1),Gun_Line(1,AtLeast,48*32)},{39,44},"ACAS",CC_R,{255,255})
				
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,2),Gun_Line(5,Exactly,0),Gun_Line(1,AtMost,48*32)},{51,55},"ACAS",CC_L,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,2),Gun_Line(5,Exactly,0),Gun_Line(1,AtLeast,48*32)},{51,55},"ACAS",CC_R,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,2),Gun_Line(5,Exactly,1),Gun_Line(1,AtMost,48*32)},{48,56},"ACAS",CC_L,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,2),Gun_Line(5,Exactly,1),Gun_Line(1,AtLeast,48*32)},{48,56},"ACAS",CC_R,{255,255})
				
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,3),Gun_Line(5,Exactly,0),Gun_Line(1,AtMost,48*32)},{28,47},"ACAS",CC_L,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,3),Gun_Line(5,Exactly,0),Gun_Line(1,AtLeast,48*32)},{28,47},"ACAS",CC_R,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,3),Gun_Line(5,Exactly,1),Gun_Line(1,AtMost,48*32)},{86,57},"ACAS",CC_L,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,3),Gun_Line(5,Exactly,1),Gun_Line(1,AtLeast,48*32)},{86,57},"ACAS",CC_R,{255,255})
				
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,4),Gun_Line(5,Exactly,0),Gun_Line(1,AtMost,48*32)},{17,27},"ACAS",CC_L,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,4),Gun_Line(5,Exactly,0),Gun_Line(1,AtLeast,48*32)},{17,27},"ACAS",CC_R,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,4),Gun_Line(5,Exactly,1),Gun_Line(1,AtMost,48*32)},{75,88},"ACAS",CC_L,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,4),Gun_Line(5,Exactly,1),Gun_Line(1,AtLeast,48*32)},{75,88},"ACAS",CC_R,{255,255})
				
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,5),Gun_Line(5,Exactly,0),Gun_Line(1,AtMost,48*32)},{28,19},"ACAS",CC_L,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,5),Gun_Line(5,Exactly,0),Gun_Line(1,AtLeast,48*32)},{28,19},"ACAS",CC_R,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,5),Gun_Line(5,Exactly,1),Gun_Line(1,AtMost,48*32)},{86,79},"ACAS",CC_L,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,5),Gun_Line(5,Exactly,1),Gun_Line(1,AtLeast,48*32)},{86,79},"ACAS",CC_R,{255,255})

				
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,6),Gun_Line(5,Exactly,0),Gun_Line(1,AtMost,48*32)},{40,43},"ACAS",CC_LF,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,6),Gun_Line(5,Exactly,0),Gun_Line(1,AtLeast,48*32)},{40,43},"ACAS",CC_RF,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,6),Gun_Line(5,Exactly,1),Gun_Line(1,AtMost,48*32)},{39,44},"ACAS",CC_LF,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,6),Gun_Line(5,Exactly,1),Gun_Line(1,AtLeast,48*32)},{39,44},"ACAS",CC_RF,{255,255})
				
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,7),Gun_Line(5,Exactly,0),Gun_Line(1,AtMost,48*32)},{51,55},"ACAS",CC_LF,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,7),Gun_Line(5,Exactly,0),Gun_Line(1,AtLeast,48*32)},{51,55},"ACAS",CC_RF,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,7),Gun_Line(5,Exactly,1),Gun_Line(1,AtMost,48*32)},{48,56},"ACAS",CC_LF,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,7),Gun_Line(5,Exactly,1),Gun_Line(1,AtLeast,48*32)},{48,56},"ACAS",CC_RF,{255,255})
				
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,8),Gun_Line(5,Exactly,0),Gun_Line(1,AtMost,48*32)},{28,47},"ACAS",CC_LF,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,8),Gun_Line(5,Exactly,0),Gun_Line(1,AtLeast,48*32)},{28,47},"ACAS",CC_RF,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,8),Gun_Line(5,Exactly,1),Gun_Line(1,AtMost,48*32)},{86,57},"ACAS",CC_LF,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,8),Gun_Line(5,Exactly,1),Gun_Line(1,AtLeast,48*32)},{86,57},"ACAS",CC_RF,{255,255})
				
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,9),Gun_Line(5,Exactly,0),Gun_Line(1,AtMost,48*32)},{17,27},"ACAS",CC_LF,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,9),Gun_Line(5,Exactly,0),Gun_Line(1,AtLeast,48*32)},{17,27},"ACAS",CC_RF,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,9),Gun_Line(5,Exactly,1),Gun_Line(1,AtMost,48*32)},{75,88},"ACAS",CC_LF,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,9),Gun_Line(5,Exactly,1),Gun_Line(1,AtLeast,48*32)},{75,88},"ACAS",CC_RF,{255,255})
				
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,10),Gun_Line(5,Exactly,0),Gun_Line(1,AtMost,48*32)},{28,19},"ACAS",CC_LF,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,10),Gun_Line(5,Exactly,0),Gun_Line(1,AtLeast,48*32)},{28,19},"ACAS",CC_RF,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,10),Gun_Line(5,Exactly,1),Gun_Line(1,AtMost,48*32)},{86,79},"ACAS",CC_LF,{255,255})
				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,10),Gun_Line(5,Exactly,1),Gun_Line(1,AtLeast,48*32)},{86,79},"ACAS",CC_RF,{255,255})
				
				CTrigger(FP,{CVar(FP,Var_TempTable[6][2],AtLeast,1),G_CA_CondStack},{Gun_DoSuspend()},1)
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
			CIfEnd()
		CIfEnd()
	end

	function Case_Overmind()
		CIf(FP,{Gun_Line(0,exactly,148)})--오버마인드
		CIf(FP,{Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
			CDoActions(FP,{Gun_SetLine(4,Add,15000)})
			CMov(FP,ReserveBGM,5)
			GunBreak("\x07ＯｖｅｒＭｉｎｄ",90000)

		CIfEnd()
		CIf(FP,Gun_Line(4,AtLeast,15000))
		local OvCUTable = {{{56,48},{57,51}},{{47,51},{57,104}},{{88,77},{80,78}},{{21,75},{28,76}},{{88,19},{29,79}}}
		local ShapeType = Ovrm
--		for i = 1, 10 do
--			local iNum = i
--			if iNum >= 6 then 
--				iNum = iNum - 5
--				ShapeType = OvrmF
--			end
--			for j = 0, 1 do
--				G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,i),Gun_Line(5,Exactly,j)},OvCUTable[iNum][j+1],"ACAS",ShapeType,{255,255})
--			end
--		end--

			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,1),Gun_Line(5,Exactly,0)},{56,48},"ACAS",Ovrm,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,1),Gun_Line(5,Exactly,1)},{57,51},"ACAS",Ovrm,"MAX")

			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,2),Gun_Line(5,Exactly,0)},{47,51},"ACAS",Ovrm,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,2),Gun_Line(5,Exactly,1)},{57,104},"ACAS",Ovrm,"MAX")

			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,3),Gun_Line(5,Exactly,0)},{88,77},"ACAS",Ovrm,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,3),Gun_Line(5,Exactly,1)},{80,78},"ACAS",Ovrm,"MAX")

			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,4),Gun_Line(5,Exactly,0)},{21,75},"ACAS",Ovrm,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,4),Gun_Line(5,Exactly,1)},{28,76},"ACAS",Ovrm,"MAX")

			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,5),Gun_Line(5,Exactly,0)},{29,79},"ACAS",Ovrm,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,5),Gun_Line(5,Exactly,1)},{88,19,81},"ACAS",Ovrm,"MAX")

			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,6),Gun_Line(5,Exactly,0)},{56,48},"ACAS",OvrmF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,6),Gun_Line(5,Exactly,1)},{57,51},"ACAS",OvrmF,"MAX")

			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,7),Gun_Line(5,Exactly,0)},{47,51},"ACAS",OvrmF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,7),Gun_Line(5,Exactly,1)},{57,104},"ACAS",OvrmF,"MAX")

			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,8),Gun_Line(5,Exactly,0)},{88,77},"ACAS",OvrmF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,8),Gun_Line(5,Exactly,1)},{80,78},"ACAS",OvrmF,"MAX")

			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,9),Gun_Line(5,Exactly,0)},{21,75},"ACAS",OvrmF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,9),Gun_Line(5,Exactly,1)},{28,76},"ACAS",OvrmF,"MAX")

			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,10),Gun_Line(5,Exactly,0)},{29,79},"ACAS",OvrmF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,10),Gun_Line(5,Exactly,1)},{88,19,81},"ACAS",OvrmF,"MAX")
			CTrigger(FP,{Gun_Line(5,AtLeast,1),G_CA_CondStack},{Gun_DoSuspend()},1)
			CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
			CDoActions(FP,{Gun_SetLine(5,Add,1)})
		CIfEnd()
	CIfEnd()
	end

	function Case_Daggoth()
		CIf(FP,Gun_Line(0,Exactly,152))--셀브다고쓰
		CIf(FP,{Gun_Line(4,AtMost,0),Gun_Line(5,Exactly,0)})
			CDoActions(FP,{Gun_SetLine(4,Add,15000)})
			CMov(FP,ReserveBGM,5)
			GunBreak("\x07Ｄａｇｇｏｔｈ",100000)

		CIfEnd()
		CIf(FP,Gun_Line(4,AtLeast,15000))
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,1),Gun_Line(5,Exactly,0)},{37,43},"ACAS",CC_L,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,1),Gun_Line(5,Exactly,0)},{37,43},"ACAS",CC_R,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,1),Gun_Line(5,Exactly,1)},{38,44},"ACAS",CC_L,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,1),Gun_Line(5,Exactly,1)},{38,44},"ACAS",CC_R,"MAX")
			
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,2),Gun_Line(5,Exactly,0)},{54,55},"ACAS",CC_L,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,2),Gun_Line(5,Exactly,0)},{54,55},"ACAS",CC_R,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,2),Gun_Line(5,Exactly,1)},{53,56},"ACAS",CC_L,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,2),Gun_Line(5,Exactly,1)},{53,56},"ACAS",CC_R,"MAX")
			
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,3),Gun_Line(5,Exactly,0)},{51,47},"ACAS",CC_L,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,3),Gun_Line(5,Exactly,0)},{51,47},"ACAS",CC_R,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,3),Gun_Line(5,Exactly,1)},{77,57},"ACAS",CC_L,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,3),Gun_Line(5,Exactly,1)},{77,57},"ACAS",CC_R,"MAX")
			
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,4),Gun_Line(5,Exactly,0)},{78,88},"ACAS",CC_L,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,4),Gun_Line(5,Exactly,0)},{78,88},"ACAS",CC_R,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,4),Gun_Line(5,Exactly,1)},{79,21},"ACAS",CC_L,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,4),Gun_Line(5,Exactly,1)},{79,21},"ACAS",CC_R,"MAX")
			
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,5),Gun_Line(5,Exactly,0)},{21,25},"ACAS",CC_L,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,5),Gun_Line(5,Exactly,0)},{21,25},"ACAS",CC_R,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,5),Gun_Line(5,Exactly,1)},{80,75},"ACAS",CC_L,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,5),Gun_Line(5,Exactly,1)},{80,75},"ACAS",CC_R,"MAX")

			
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,6),Gun_Line(5,Exactly,0)},{37,43},"ACAS",CC_LF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,6),Gun_Line(5,Exactly,0)},{37,43},"ACAS",CC_RF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,6),Gun_Line(5,Exactly,1)},{38,44},"ACAS",CC_LF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,6),Gun_Line(5,Exactly,1)},{38,44},"ACAS",CC_RF,"MAX")
			
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,7),Gun_Line(5,Exactly,0)},{54,55},"ACAS",CC_LF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,7),Gun_Line(5,Exactly,0)},{54,55},"ACAS",CC_RF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,7),Gun_Line(5,Exactly,1)},{53,56},"ACAS",CC_LF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,7),Gun_Line(5,Exactly,1)},{53,56},"ACAS",CC_RF,"MAX")
			
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,8),Gun_Line(5,Exactly,0)},{51,47},"ACAS",CC_LF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,8),Gun_Line(5,Exactly,0)},{51,47},"ACAS",CC_RF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,8),Gun_Line(5,Exactly,1)},{77,57},"ACAS",CC_LF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,8),Gun_Line(5,Exactly,1)},{77,57},"ACAS",CC_RF,"MAX")
			
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,9),Gun_Line(5,Exactly,0)},{78,88},"ACAS",CC_LF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,9),Gun_Line(5,Exactly,0)},{78,88},"ACAS",CC_RF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,9),Gun_Line(5,Exactly,1)},{79,21},"ACAS",CC_LF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,9),Gun_Line(5,Exactly,1)},{79,21},"ACAS",CC_RF,"MAX")
			
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,10),Gun_Line(5,Exactly,0)},{21,25},"ACAS",CC_LF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,10),Gun_Line(5,Exactly,0)},{21,25},"ACAS",CC_RF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,10),Gun_Line(5,Exactly,1)},{80,75},"ACAS",CC_LF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,10),Gun_Line(5,Exactly,1)},{80,75},"ACAS",CC_RF,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,10),Gun_Line(5,Exactly,1)},{30},"ACAS",CC_R,"MAX")
			G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,10),Gun_Line(5,Exactly,1)},{30},"ACAS",CC_L,"MAX")
			CTrigger(FP,{Gun_Line(5,AtLeast,1),G_CA_CondStack},{Gun_DoSuspend()},1)
			CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
			CDoActions(FP,{Gun_SetLine(5,Add,1)})
		CIfEnd()
		CIfEnd()
	end

	function Case_Cerebrate()
		CIf(FP,Gun_Line(0,Exactly,151))--셀브순대
		CIf(FP,{Gun_Line(4,AtMost,0),Gun_Line(5,Exactly,0)})
			CDoActions(FP,{Gun_SetLine(4,Add,15000)})
			CMov(FP,ReserveBGM,4)
			GunBreak("\x07Ｃｅｒｅｂｒａｔｅ",120000)

		CIfEnd()
		CIf(FP,Gun_Line(4,AtLeast,15000))
		CIf(FP,{CVar(FP,LevelT[2],AtLeast,1),CVar(FP,LevelT[2],AtMost,2)})
		G_CA_SetSpawn({Gun_Line(5,Exactly,0),Gun_Line(1,AtMost,48*32)},{55},"ACAS",Cere_L,"MAX")
		G_CA_SetSpawn({Gun_Line(5,Exactly,1),Gun_Line(1,AtMost,48*32)},{56},"ACAS",Cere_L,"MAX")
		G_CA_SetSpawn({Gun_Line(5,Exactly,0),Gun_Line(1,AtLeast,48*32)},{55},"ACAS",Cere_R,"MAX")
		G_CA_SetSpawn({Gun_Line(5,Exactly,1),Gun_Line(1,AtLeast,48*32)},{56},"ACAS",Cere_R,"MAX")
		CifEnd()
		CIf(FP,{CVar(FP,LevelT[2],AtLeast,3),CVar(FP,LevelT[2],AtMost,4)})
		G_CA_SetSpawn({Gun_Line(5,Exactly,0),Gun_Line(1,AtMost,48*32)},{56},"ACAS",Cere_L,"MAX")
		G_CA_SetSpawn({Gun_Line(5,Exactly,1),Gun_Line(1,AtMost,48*32)},{47},"ACAS",Cere_L,"MAX")
		G_CA_SetSpawn({Gun_Line(5,Exactly,0),Gun_Line(1,AtLeast,48*32)},{56},"ACAS",Cere_R,"MAX")
		G_CA_SetSpawn({Gun_Line(5,Exactly,1),Gun_Line(1,AtLeast,48*32)},{47},"ACAS",Cere_R,"MAX")
		CifEnd()
		CIf(FP,{CVar(FP,LevelT[2],AtLeast,5),CVar(FP,LevelT[2],AtMost,6)})
		G_CA_SetSpawn({Gun_Line(5,Exactly,0),Gun_Line(1,AtMost,48*32)},{55,47},"ACAS",Cere_L,"MAX")
		G_CA_SetSpawn({Gun_Line(5,Exactly,1),Gun_Line(1,AtMost,48*32)},{56,57},"ACAS",Cere_L,"MAX")
		G_CA_SetSpawn({Gun_Line(5,Exactly,0),Gun_Line(1,AtLeast,48*32)},{55,47},"ACAS",Cere_R,"MAX")
		G_CA_SetSpawn({Gun_Line(5,Exactly,1),Gun_Line(1,AtLeast,48*32)},{56,57},"ACAS",Cere_R,"MAX")
		CifEnd()
		CIf(FP,{CVar(FP,LevelT[2],AtLeast,7),CVar(FP,LevelT[2],AtMost,8)})
		G_CA_SetSpawn({Gun_Line(5,Exactly,0),Gun_Line(1,AtMost,48*32)},{55,57,62},"ACAS",Cere_L,"MAX")
		G_CA_SetSpawn({Gun_Line(5,Exactly,1),Gun_Line(1,AtMost,48*32)},{56,88,21},"ACAS",Cere_L,"MAX")
		G_CA_SetSpawn({Gun_Line(5,Exactly,0),Gun_Line(1,AtLeast,48*32)},{55,57,62},"ACAS",Cere_R,"MAX")
		G_CA_SetSpawn({Gun_Line(5,Exactly,1),Gun_Line(1,AtLeast,48*32)},{56,88,21},"ACAS",Cere_R,"MAX")
		CifEnd()
		CIf(FP,{CVar(FP,LevelT[2],AtLeast,9),CVar(FP,LevelT[2],AtMost,10)})
		G_CA_SetSpawn({Gun_Line(5,Exactly,0),Gun_Line(1,AtMost,48*32)},{55,56,88,62},"ACAS",Cere_L,"MAX")
		G_CA_SetSpawn({Gun_Line(5,Exactly,1),Gun_Line(1,AtMost,48*32)},{27,57,47,62},"ACAS",Cere_L,"MAX")
		G_CA_SetSpawn({Gun_Line(5,Exactly,0),Gun_Line(1,AtLeast,48*32)},{55,56,88,62},"ACAS",Cere_R,"MAX")
		G_CA_SetSpawn({Gun_Line(5,Exactly,1),Gun_Line(1,AtLeast,48*32)},{27,57,47,62},"ACAS",Cere_R,"MAX")
		CifEnd()
			CTrigger(FP,{Gun_Line(5,AtLeast,1),G_CA_CondStack},{Gun_DoSuspend()},1)
			CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
			CDoActions(FP,{Gun_SetLine(5,Add,1)})
		CIfEnd()
	CIfEnd()
	end

	function Case_InfestedCommand()
		local RandSpeed = CreateVar()
		local CUID = CreateVar()
		CIf(FP,Gun_Line(0,Exactly,130))--감커
			CIf(FP,{Gun_Line(4,AtMost,0),Gun_Line(5,Exactly,0)})
				CDoActions(FP,{Gun_SetLine(4,Add,15000)})
				TriggerX(FP,{CVar(FP,LevelT[2],Exactly,10)},{SetCDeaths(FP,Add,45000,GCT)},{Preserved})
				CMov(FP,ReserveBGM,5)
				GunBreak("\x07Ｇｒａｖｉｔｙ　Ｃｅｎｔｅｒ",150000)
			CIfEnd()
			CIf(FP,{CVar(FP,LevelT[2],AtMost,3),Gun_Line(4,AtLeast,500)})
				CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
				CDoActions(FP,{Gun_SetLine(5,Add,1)})
				TriggerX(FP,{CVar(FP,LevelT[2],Exactly,1),Gun_Line(1,AtMost,48*32)},{SetCVar(FP,CUID[2],SetTo,57)},{Preserved})
				TriggerX(FP,{CVar(FP,LevelT[2],Exactly,1),Gun_Line(1,AtLeast,48*32)},{SetCVar(FP,CUID[2],SetTo,47)},{Preserved})
				TriggerX(FP,{CVar(FP,LevelT[2],Exactly,2),Gun_Line(1,AtMost,48*32)},{SetCVar(FP,CUID[2],SetTo,88)},{Preserved})
				TriggerX(FP,{CVar(FP,LevelT[2],Exactly,2),Gun_Line(1,AtLeast,48*32)},{SetCVar(FP,CUID[2],SetTo,21)},{Preserved})
				TriggerX(FP,{CVar(FP,LevelT[2],Exactly,3),Gun_Line(1,AtMost,48*32)},{SetCVar(FP,CUID[2],SetTo,98)},{Preserved})
				TriggerX(FP,{CVar(FP,LevelT[2],Exactly,3),Gun_Line(1,AtLeast,48*32)},{SetCVar(FP,CUID[2],SetTo,27)},{Preserved})
				f_TempRepeatX(CUID,10,nil,187)
				DoActions(FP,{CreateUnit(1,ObEff,1,FP),KillUnit(ObEff,FP)})
			CIfEnd()
			CIf(FP,{CVar(FP,LevelT[2],AtLeast,4),CVar(FP,LevelT[2],AtMost,6)})
				CIf(FP,{Gun_Line(4,AtLeast,1000),Gun_Line(5,AtMost,10),G_CA_CondStack})
					CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
					CDoActions(FP,{Gun_SetLine(5,Add,1)})
					G_CA_SetSpawn(nil,{ObEff},"ACAS",{GC1},{3})
					G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,4),Gun_Line(1,AtMost,48*32)},{57},"ACAS",{GC1},{3},{1})
					G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,4),Gun_Line(1,AtLeast,48*32)},{47},"ACAS",{GC1},{3},{1})

					G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,5),Gun_Line(1,AtMost,48*32)},{88},"ACAS",{GC1},{3},{1})
					G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,5),Gun_Line(1,AtLeast,48*32)},{21},"ACAS",{GC1},{3},{1})

					G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,6),Gun_Line(1,AtMost,48*32)},{98},"ACAS",{GC1},{3},{1})
					G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,6),Gun_Line(1,AtLeast,48*32)},{27},"ACAS",{GC1},{3},{1})

				CIfEnd()
				DoActions(FP,{Order("Any unit",P9,64,Move,64)})
				DoActions(FP,{CreateUnit(1,ObEff,64,FP),KillUnit(ObEff,FP)})
				CIf(FP,{Gun_Line(5,AtLeast,10),Gun_Line(4,AtLeast,20000),G_CA_CondStack},{Gun_DoSuspend()})
					CTrigger(FP,{CVar(FP,LevelT[2],Exactly,4),Gun_Line(1,AtMost,48*32)},{GiveUnits(All,57,P9,64,FP),SetInvincibility(Disable,57,FP,64),SetMemory(0x6509B0,SetTo,FP),RunAIScriptAt(JYD,64)},1)
					CTrigger(FP,{CVar(FP,LevelT[2],Exactly,4),Gun_Line(1,AtLeast,48*32)},{GiveUnits(All,47,P9,64,FP),SetInvincibility(Disable,47,FP,64),SetMemory(0x6509B0,SetTo,FP),RunAIScriptAt(JYD,64)},1)
					CTrigger(FP,{CVar(FP,LevelT[2],Exactly,5),Gun_Line(1,AtMost,48*32)},{GiveUnits(All,88,P9,64,FP),SetInvincibility(Disable,88,FP,64),SetMemory(0x6509B0,SetTo,FP),RunAIScriptAt(JYD,64)},1)
					CTrigger(FP,{CVar(FP,LevelT[2],Exactly,5),Gun_Line(1,AtLeast,48*32)},{GiveUnits(All,21,P9,64,FP),SetInvincibility(Disable,21,FP,64),SetMemory(0x6509B0,SetTo,FP),RunAIScriptAt(JYD,64)},1)
					CTrigger(FP,{CVar(FP,LevelT[2],Exactly,6),Gun_Line(1,AtMost,48*32)},{GiveUnits(All,98,P9,64,FP),SetInvincibility(Disable,98,FP,64),SetMemory(0x6509B0,SetTo,FP),RunAIScriptAt(JYD,64)},1)
					CTrigger(FP,{CVar(FP,LevelT[2],Exactly,6),Gun_Line(1,AtLeast,48*32)},{GiveUnits(All,27,P9,64,FP),SetInvincibility(Disable,27,FP,64),SetMemory(0x6509B0,SetTo,FP),RunAIScriptAt(JYD,64)},1)
				CIfEnd()
			CIfEnd()
			CIf(FP,{CVar(FP,LevelT[2],AtLeast,7),CVar(FP,LevelT[2],AtMost,9)})
				CIf(FP,{Gun_Line(4,AtLeast,15000),Gun_Line(5,AtMost,0),G_CA_CondStack})
					CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
					CDoActions(FP,{Gun_SetLine(5,Add,1)})
					G_CA_SetSpawn(nil,{ObEff},"ACAS",{GC2},{3})
					G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,7),Gun_Line(1,AtMost,48*32)},{88},"ACAS",{GC2},{3},{1})
					G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,7),Gun_Line(1,AtLeast,48*32)},{21},"ACAS",{GC2},{3},{1})
					G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,8),Gun_Line(1,AtMost,48*32)},{27},"ACAS",{GC2},{3},{1})
					G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,8),Gun_Line(1,AtLeast,48*32)},{80},"ACAS",{GC2},{3},{1})
					G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,9),Gun_Line(1,AtMost,48*32)},{98},"ACAS",{GC2},{3},{1})
					G_CA_SetSpawn({CVar(FP,LevelT[2],Exactly,9),Gun_Line(1,AtLeast,48*32)},{29},"ACAS",{GC2},{3},{1})
				CIfEnd()
				CIf(FP,{Gun_Line(4,AtLeast,20000),G_CA_CondStack},{Gun_DoSuspend()})
					CTrigger(FP,{CVar(FP,LevelT[2],Exactly,7),Gun_Line(1,AtMost,48*32)},{GiveUnits(All,88,P9,64,FP),SetInvincibility(Disable,88,FP,64),SetMemory(0x6509B0,SetTo,FP),RunAIScriptAt(JYD,64)},1)
					CTrigger(FP,{CVar(FP,LevelT[2],Exactly,7),Gun_Line(1,AtLeast,48*32)},{GiveUnits(All,21,P9,64,FP),SetInvincibility(Disable,21,FP,64),SetMemory(0x6509B0,SetTo,FP),RunAIScriptAt(JYD,64)},1)
					CTrigger(FP,{CVar(FP,LevelT[2],Exactly,8),Gun_Line(1,AtMost,48*32)},{GiveUnits(All,27,P9,64,FP),SetInvincibility(Disable,27,FP,64),SetMemory(0x6509B0,SetTo,FP),RunAIScriptAt(JYD,64)},1)
					CTrigger(FP,{CVar(FP,LevelT[2],Exactly,8),Gun_Line(1,AtLeast,48*32)},{GiveUnits(All,80,P9,64,FP),SetInvincibility(Disable,80,FP,64),SetMemory(0x6509B0,SetTo,FP),RunAIScriptAt(JYD,64)},1)
					CTrigger(FP,{CVar(FP,LevelT[2],Exactly,9),Gun_Line(1,AtMost,48*32)},{GiveUnits(All,98,P9,64,FP),SetInvincibility(Disable,98,FP,64),SetMemory(0x6509B0,SetTo,FP),RunAIScriptAt(JYD,64)},1)
					CTrigger(FP,{CVar(FP,LevelT[2],Exactly,9),Gun_Line(1,AtLeast,48*32)},{GiveUnits(All,29,P9,64,FP),SetInvincibility(Disable,29,FP,64),SetMemory(0x6509B0,SetTo,FP),RunAIScriptAt(JYD,64)},1)
				CIfEnd()
				DoActions(FP,{CreateUnit(1,ObEff,64,FP),KillUnit(ObEff,FP)})
			CIfEnd()
			CIf(FP,{CVar(FP,LevelT[2],Exactly,10)})
				DoActions(FP,Order("Any unit",FP,64,Move,64))
				f_Recall(nil,48*32,96*32)
				CTrigger(FP,{Gun_Line(4,AtLeast,20000),CDeaths(FP,AtMost,0,GCT),Gun_Line(5,AtMost,0),G_CA_CondStack},{Gun_DoSuspend()},1)
			CIfEnd()
			CTrigger(FP,{CVar(FP,LevelT[2],AtMost,3),Gun_Line(5,AtLeast,20),G_CA_CondStack},{Gun_DoSuspend()},1)
		CIfEnd()
	end

	function Case_Hive()
		CIf(FP,Gun_Line(0,Exactly,133))--하이브
			CIf(FP,{Gun_Line(4,AtMost,0),Gun_Line(5,Exactly,0)})
				CDoActions(FP,{Gun_SetLine(4,Add,15000)})
				CMov(FP,ReserveBGM,4)
				GunBreak("\x07Ｈｉｖｅ",50000)
			CIfEnd()
			CIf(FP,{Gun_Line(4,AtLeast,15000),G_CA_CondStack})
				CIf(FP,Gun_Line(3,Exactly,0))
					CIf(FP,{LvT(ATMost,3)})
						Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
							{Simple_CalcLoc(0,-32*4 + (-32*7),-32*4 + (-32*7),-32*4 + (32*7),-32*4 + (32*7))}) -- 좌상
						f_TempRepeat(56,9)
						f_TempRepeat(104,15)
						f_TempRepeat(48,7)
						f_TempRepeat(51,15)
						f_TempRepeat(62,15)
						Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
							{Simple_CalcLoc(0,32*4 + (-32*7),-32*4 + (-32*7),32*4 + (32*7),-32*4 + (32*7))}) -- 우상
						f_TempRepeat(56,9)
						f_TempRepeat(104,15)
						f_TempRepeat(48,7)
						f_TempRepeat(51,15)
						f_TempRepeat(62,15)
						Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
							{Simple_CalcLoc(0,-32*4 + (-32*7),32*4 + (-32*7),-32*4 + (32*7),32*4 + (32*7))}) -- 좌하
						f_TempRepeat(56,9)
						f_TempRepeat(104,15)
						f_TempRepeat(48,7)
						f_TempRepeat(51,15)
						f_TempRepeat(62,15)
						Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
							{Simple_CalcLoc(0,32*4 + (-32*7),32*4 + (-32*7),32*4 + (32*7),32*4 + (32*7))}) -- 우하
						f_TempRepeat(56,9)
						f_TempRepeat(104,15)
						f_TempRepeat(48,7)
						f_TempRepeat(51,15)
						f_TempRepeat(62,15)
					CIfEnd()
					CIf(FP,{LvT(AtLeast,4),LvT(ATMost,6)})
						CIf(FP,Gun_Line(5,Exactly,0))
							G_CA_SetSpawn(nil,{55,56},{S_6,P_6},{2,3})
							G_CA_SetSpawn(nil,{54,104},{S_8,S_6},{2,1})
							G_CA_SetSpawn(nil,{51,48},{P_8,S_6},{2,1})
							G_CA_SetSpawn(nil,{48,53},{S_8,S_6},{2,2})
						CIfEnd()
						CIf(FP,Gun_Line(5,Exactly,1))
							G_CA_SetSpawn(nil,{47,62},{S_6,P_6},{2,3})
							G_CA_SetSpawn(nil,{54,104},{S_8,S_6},{2,1})
							G_CA_SetSpawn(nil,{51,48,52},{S_3,S_6,S_5},{3,1,2})
							G_CA_SetSpawn(nil,{48,53,77,78},{S_8,S_6,P_5,S_4},{1,1,4,1})
						CIfEnd()
					CIfEnd()
					CIf(FP,{LvT(AtLeast,7),LvT(ATMost,9)})
						CIf(FP,Gun_Line(5,Exactly,0))
							G_CA_SetSpawn(nil,{88,77},{P_5,S_6},{2,2})
							G_CA_SetSpawn(nil,{77,78},{P_5,S_4},{4,1})
						CIfEnd()
						CIf(FP,Gun_Line(5,Exactly,1))
							G_CA_SetSpawn(nil,{28,77},{P_6,S_6},{1,2})
							G_CA_SetSpawn(nil,{79,75,52},{P_7,P_5,P_7},{2,2,3})
						CIfEnd()
					CIfEnd()
					CIf(FP,{LvT(Exactly,10)})
						CIf(FP,Gun_Line(5,Exactly,0))
							G_CA_SetSpawn(nil,{98,75,69},{S_3,S_8,S_3},{1,2,0})
							G_CA_SetSpawn(nil,{79,75,30},{P_7,P_5,P_3},{2,2,0})
						CIfEnd()
						CIf(FP,Gun_Line(5,Exactly,1))
							G_CA_SetSpawn(nil,{29,75,69},{S_7,S_8,S_3},{0,2,0})
							G_CA_SetSpawn(nil,{76,19,25},{S_5,P_4,S_5},{2,3,2})
						CIfEnd()
					CIfEnd()
				CTrigger(FP,{Gun_Line(5,AtLeast,1),G_CA_CondStack},{Gun_DoSuspend()},1)
				CIfEnd()
				CIf(FP,Gun_Line(3,Exactly,1))
					CIf(FP,{LvT(ATMost,3)})

						G_CA_SetSpawn(Gun_Line(5,Exactly,0),{48,55},"ACAS",Hive_1,"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),{104,56},"ACAS",Hive_1,"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),{51,56},"ACAS",Hive_1,"MAX")
					CIfEnd()
					CIf(FP,{LvT(AtLeast,4),LvT(ATMost,6)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),{51,56},"ACAS",Hive_1,"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),{77,56},"ACAS",Hive_1,"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),{78,88},"ACAS",Hive_1,"MAX")
					CIfEnd()
					CIf(FP,{LvT(AtLeast,7),LvT(ATMost,9)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),{76,56},"ACAS",Hive_1,"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),{25,56},"ACAS",Hive_1,"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),{79,21},"ACAS",Hive_1,"MAX")
					CIfEnd()
					CIf(FP,{LvT(Exactly,10)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),{51,28},"ACAS",Hive_1,"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),{86,21},"ACAS",Hive_1,"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),{75,98},"ACAS",Hive_1,"MAX")
					CIfEnd()
					CTrigger(FP,{Gun_Line(5,AtLeast,2),G_CA_CondStack},{Gun_DoSuspend()},1)
				CIfEnd()
				CIf(FP,Gun_Line(3,Exactly,2))
					CIf(FP,{LvT(ATMost,3)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),{55,56},"ACAS",Hive_2,"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),{56,47},"ACAS",Hive_2,"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),{47,57},"ACAS",Hive_2,"MAX")
					CIfEnd()
					CIf(FP,{LvT(AtLeast,4),LvT(ATMost,6)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),{57,62},"ACAS",Hive_2,"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),{56,88,47},"ACAS",Hive_2,"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),{47,21,62},"ACAS",Hive_2,"MAX")
					CIfEnd()
					CIf(FP,{LvT(AtLeast,7),LvT(ATMost,9)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),{47,21.80},"ACAS",Hive_2,"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),{47,28,57},"ACAS",Hive_2,"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),{57,86,11},"ACAS",Hive_2,"MAX")
					CIfEnd()
					CIf(FP,{LvT(Exactly,10)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),{55,56,57,86},"ACAS",Hive_2,"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),{56,57,47,98},"ACAS",Hive_2,"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),{11,47,57,27},"ACAS",Hive_2,"MAX")
					CIfEnd()
					CTrigger(FP,{Gun_Line(5,AtLeast,2),G_CA_CondStack},{Gun_DoSuspend()},1)
				CIfEnd()
				CIf(FP,Gun_Line(3,Exactly,3))
					CIf(FP,{LvT(ATMost,3)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),{54,53},"ACAS",Hive_3F,"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),{55,53},"ACAS",Hive_3F,"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),{56,48},"ACAS",Hive_3F,"MAX")
					CIfEnd()
					CIf(FP,{LvT(AtLeast,4),LvT(ATMost,6)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),{48,55},"ACAS",Hive_3F,"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),{51,56,52},"ACAS",{Hive_3F,Hive_3F,Hive_3},"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),{104,62,52},"ACAS",Hive_3F,"MAX")
					CIfEnd()
					CIf(FP,{LvT(AtLeast,7),LvT(ATMost,9)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),{77,78,11},"ACAS",{Hive_3F,Hive_3F,Hive_3},"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),{25,88,52},"ACAS",{Hive_3F,Hive_3F,Hive_3},"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),{17,21,81},"ACAS",{Hive_3F,Hive_3F,Hive_3},"MAX")
					CIfEnd()
					CIf(FP,{LvT(Exactly,10)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),{19,28,23},"ACAS",{Hive_3F,Hive_3F,Hive_3},"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),{79,98,86},"ACAS",{Hive_3F,Hive_3,Hive_3F},"MAX")
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),{75,29,80},"ACAS",{Hive_3F,Hive_3,Hive_3F},"MAX")
					CIfEnd()
					CTrigger(FP,{Gun_Line(5,AtLeast,2),G_CA_CondStack},{Gun_DoSuspend()},1)
				CIfEnd()
				CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
				CDoActions(FP,{Gun_SetLine(5,Add,1)})
				CTrigger(FP,{Gun_Line(5,AtLeast,2),G_CA_CondStack},{Gun_DoSuspend()},1)
			CIfEnd()
		CIfEnd()
	end

	function Case_Lair()

		CIf(FP,Gun_Line(0,Exactly,132))--레어
		CIf(FP,{Gun_Line(4,AtMost,0),Gun_Line(5,Exactly,0)})
			CDoActions(FP,{Gun_SetLine(4,Add,15000)})
			GunBreak("\x07Ｌａｉｒ",40000)
			CMov(FP,ReserveBGM,3)
		CIfEnd()
		CIf(FP,{Gun_Line(4,AtLeast,15000),G_CA_CondStack})
			CIf(FP,{LvT(AtLeast,4),LvT(AtMost,6)})
				CIf(FP,Gun_Line(5,Exactly,0))
					G_CA_SetSpawn(nil,{55},{P_6},{3})
					G_CA_SetSpawn(nil,{54,104},{S_8,S_6},{1,1})
					G_CA_SetSpawn(nil,{51,48},{S_8,S_6},{1,1})
					G_CA_SetSpawn(nil,{48,53},{S_8,S_6},{1,1})
				CIfEnd()
				CIf(FP,Gun_Line(5,Exactly,1))
					G_CA_SetSpawn(nil,{56},{P_6},{4})
					G_CA_SetSpawn(nil,{54,104},{S_8,S_6},{1,1})
					G_CA_SetSpawn(nil,{51,48},{S_8,S_6},{1,1})
					G_CA_SetSpawn(nil,{48,53},{S_8,S_6},{1,1})
				CIfEnd()
			CIfEnd()
			
			CIf(FP,{LvT(AtLeast,7),LvT(AtMost,9)})
				CIf(FP,Gun_Line(5,Exactly,0))
					G_CA_SetSpawn(nil,{77},{P_4},{4})
					G_CA_SetSpawn(nil,{88},{P_6},{5})
					G_CA_SetSpawn(nil,{78},{P_5},{4})
				CIfEnd()
				CIf(FP,Gun_Line(5,Exactly,1))
					G_CA_SetSpawn(nil,{77},{P_7},{4})
					G_CA_SetSpawn(nil,{21},{S_7},{2})
					G_CA_SetSpawn(nil,{78},{P_7},{3})
				CIfEnd()
			CIfEnd()

			CIf(FP,{LvT(Exactly,10)})
				CIf(FP,Gun_Line(5,Exactly,0))
					G_CA_SetSpawn(nil,{21},{S_6},{2})
					G_CA_SetSpawn(nil,{77},{S_5},{1})
					G_CA_SetSpawn(nil,{56,57},{S_5,S_7},{1,3})
					G_CA_SetSpawn(nil,{78},{P_7},{3})
				CIfEnd()
				CIf(FP,Gun_Line(5,Exactly,1))
					G_CA_SetSpawn(nil,{80},{S_5},{2})
					G_CA_SetSpawn(nil,{77},{S_5},{2})
					G_CA_SetSpawn(nil,{57,62},{S_5,S_7},{2,3})
					G_CA_SetSpawn(nil,{78},{P_6},{3})
				CIfEnd()
			CIfEnd()

			CIf(FP,{LvT(AtMost,3)})
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
					{Simple_CalcLoc(0,-32*4 + (-32*7),-32*4 + (-32*7),-32*4 + (32*7),-32*4 + (32*7))}) -- 좌상
				f_TempRepeat(55,9,Gun_Line(5,Exactly,0))
				f_TempRepeat(56,9,Gun_Line(5,Exactly,1))
				f_TempRepeat(53,10)
				f_TempRepeat(48,7)
				f_TempRepeat(54,10)
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
					{Simple_CalcLoc(0,32*4 + (-32*7),-32*4 + (-32*7),32*4 + (32*7),-32*4 + (32*7))}) -- 우상
				f_TempRepeat(55,9,Gun_Line(5,Exactly,0))
				f_TempRepeat(56,9,Gun_Line(5,Exactly,1))
				f_TempRepeat(53,10)
				f_TempRepeat(48,7)
				f_TempRepeat(54,10)
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
					{Simple_CalcLoc(0,-32*4 + (-32*7),32*4 + (-32*7),-32*4 + (32*7),32*4 + (32*7))}) -- 좌하
				f_TempRepeat(55,9,Gun_Line(5,Exactly,0))
				f_TempRepeat(56,9,Gun_Line(5,Exactly,1))
				f_TempRepeat(53,10)
				f_TempRepeat(48,7)
				f_TempRepeat(54,10)
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
					{Simple_CalcLoc(0,32*4 + (-32*7),32*4 + (-32*7),32*4 + (32*7),32*4 + (32*7))}) -- 우하
				f_TempRepeat(55,9,Gun_Line(5,Exactly,0))
				f_TempRepeat(56,9,Gun_Line(5,Exactly,1))
				f_TempRepeat(53,10)
				f_TempRepeat(48,7)
				f_TempRepeat(54,10)
			CIfEnd()


			CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
			CDoActions(FP,{Gun_SetLine(5,Add,1)})
		CIfEnd()
		CTrigger(FP,{Gun_Line(5,AtLeast,2),G_CA_CondStack},{Gun_DoSuspend()},1)
	CIfEnd()
	end

	function Case_Hatchery()

		CIf(FP,Gun_Line(0,Exactly,131))--해처리
		CIf(FP,{Gun_Line(4,AtMost,0),Gun_Line(5,Exactly,0)})
			CDoActions(FP,{Gun_SetLine(4,Add,15000)})
			CMov(FP,ReserveBGM,2)
			GunBreak("\x07Ｈａｔｃｈｅｒｙ",30000)
		CIfEnd()

		CIf(FP,{CVar(FP,LevelT[2],AtLeast,1),CVar(FP,LevelT[2],AtMost,3)})
			CIf(FP,{Gun_Line(4,AtLeast,15000),G_CA_CondStack})
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
					{Simple_CalcLoc(0,-32*4 + (-32*7),-32*4 + (-32*7),-32*4 + (32*7),-32*4 + (32*7))}) -- 좌상
				f_TempRepeat(43,9,Gun_Line(5,Exactly,0))
				f_TempRepeat(44,9,Gun_Line(5,Exactly,1))
				f_TempRepeat(38,10)
				f_TempRepeat(39,7)
				f_TempRepeat(37,10)
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
					{Simple_CalcLoc(0,32*4 + (-32*7),-32*4 + (-32*7),32*4 + (32*7),-32*4 + (32*7))}) -- 우상
				f_TempRepeat(43,9,Gun_Line(5,Exactly,0))
				f_TempRepeat(44,9,Gun_Line(5,Exactly,1))
				f_TempRepeat(38,10)
				f_TempRepeat(39,7)
				f_TempRepeat(37,10)
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
					{Simple_CalcLoc(0,-32*4 + (-32*7),32*4 + (-32*7),-32*4 + (32*7),32*4 + (32*7))}) -- 좌하
				f_TempRepeat(43,9,Gun_Line(5,Exactly,0))
				f_TempRepeat(44,9,Gun_Line(5,Exactly,1))
				f_TempRepeat(38,10)
				f_TempRepeat(39,7)
				f_TempRepeat(37,10)
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
					{Simple_CalcLoc(0,32*4 + (-32*7),32*4 + (-32*7),32*4 + (32*7),32*4 + (32*7))}) -- 우하
				f_TempRepeat(43,9,Gun_Line(5,Exactly,0))
				f_TempRepeat(44,9,Gun_Line(5,Exactly,1))
				f_TempRepeat(38,10)
				f_TempRepeat(39,7)
				f_TempRepeat(37,10)
				CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
				CDoActions(FP,{Gun_SetLine(5,Add,1)})
				CIfEnd()
			CIfEnd()
			CIf(FP,{CVar(FP,LevelT[2],AtLeast,4),CVar(FP,LevelT[2],AtMost,6)})
				CIf(FP,{Gun_Line(4,AtLeast,15000),G_CA_CondStack})
					CIf(FP,Gun_Line(5,Exactly,0))
						G_CA_SetSpawn(nil,{43},{S_5},{1})
						G_CA_SetSpawn(nil,{38,39,37},{S_8,S_6,S_4},{1,1,2})
					CIfEnd()
					CIf(FP,Gun_Line(5,Exactly,1))
						G_CA_SetSpawn(nil,{44},{S_6},{1})
						G_CA_SetSpawn(nil,{38,39,37},{S_8,S_6,S_4},{1,1,2})
					CIfEnd()
					CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
					CDoActions(FP,{Gun_SetLine(5,Add,1)})
				CIfEnd()
			CIfEnd()
			CIf(FP,{CVar(FP,LevelT[2],AtLeast,7),CVar(FP,LevelT[2],AtMost,9)})
				CIf(FP,{Gun_Line(4,AtLeast,15000),G_CA_CondStack})
					CIf(FP,Gun_Line(5,Exactly,0))
						G_CA_SetSpawn(nil,{55,47},{S_5,P_4},{2,5})
						G_CA_SetSpawn(nil,{53,48,54,51},{S_8,S_6,S_4,P_7},{1,1,2,7},{255,255,255,10})
					CIfEnd()
					CIf(FP,Gun_Line(5,Exactly,1))
						G_CA_SetSpawn(nil,{56,57},{S_6,S_4},{2,2})
						G_CA_SetSpawn(nil,{53,48,54,51},{S_8,S_6,S_4,P_7},{1,1,2,7},{255,255,255,10})
					CIfEnd()
					CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
					CDoActions(FP,{Gun_SetLine(5,Add,1)})
				CIfEnd()
			CIfEnd()
			CIf(FP,{CVar(FP,LevelT[2],Exactly,10)})
				CIf(FP,{Gun_Line(4,AtLeast,15000),G_CA_CondStack})
					CIf(FP,Gun_Line(5,Exactly,0))
						G_CA_SetSpawn(nil,{47,57},{S_6,P_8},{3,5},{4,4})
						G_CA_SetSpawn(nil,{51,52},{S_8,P_8},{3,5},{4,4})
					CIfEnd()
					CIf(FP,Gun_Line(5,Exactly,1))
						G_CA_SetSpawn(nil,{57,62},{S_7,P_8},{2,7},{4,4})
						G_CA_SetSpawn(nil,{51,52},{S_8,P_8},{3,5},{4,4})
					CIfEnd()
					CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
					CDoActions(FP,{Gun_SetLine(5,Add,1)})
				CIfEnd()
			CIfEnd()
		CTrigger(FP,{Gun_Line(5,AtLeast,2),G_CA_CondStack},{Gun_DoSuspend()},1)
	CIfEnd()
	end


	function Case_Test()
		if TestStart == 1 then
			CIf(FP,Gun_Line(0,Exactly,146))--테스트용 유닛
				CIf(FP,{Gun_Line(4,AtMost,0),Gun_Line(5,Exactly,0)})
					CMov(FP,ReserveBGM,2)
					CDoActions(FP,{Gun_SetLine(4,Add,15000)})
					
					G_CA_SetSpawnX(nil,{77,S_4,3},{55,P_5,6},{56,P_3,6},{104,S_8,2})
					
					GunBreak("\x07테스트용 썽큰~~~~~~~~~~~~~~~~",322322)
				CIfEnd()
				CIf(FP,{Gun_Line(4,AtLeast,15000),G_CA_CondStack})
					CDoActions(FP,{Gun_SetLine(4,SetTo,0),Gun_SetLine(5,Add,1)})
				CIfEnd()
				CTrigger(FP,{Gun_Line(5,AtLeast,2),G_CA_CondStack},{Gun_DoSuspend()},1)
			CIfEnd()
			CIf(FP,Gun_Line(0,Exactly,136))--테스트용 유닛
				CIf(FP,{Gun_Line(4,AtMost,0),Gun_Line(5,Exactly,0)})
					CMov(FP,ReserveBGM,2)
					CDoActions(FP,{Gun_SetLine(4,Add,15000)})
					
					G_CA_SetSpawn(nil,{55,56,55,56},{NBYD,NBYD,NBYD,NBYD})
					GunBreak("\x07테스트용 디파파~~~~~~~~~~~~~~~~",322322)
				CIfEnd()
				CIf(FP,{Gun_Line(4,AtLeast,15000),G_CA_CondStack})
					CDoActions(FP,{Gun_SetLine(4,SetTo,0),Gun_SetLine(5,Add,1)})
				CIfEnd()
				CTrigger(FP,{Gun_Line(5,AtLeast,2),G_CA_CondStack},{Gun_DoSuspend()},1)
			CIfEnd()
		end
	end

	function Case_Various()
		CIf(FP,{Gun_Line(53,AtLeast,256)}) -- 잡건작일 경우
			CIf(FP,{Gun_Line(5,Exactly,0)})
				CDoActions(FP,{Gun_SetLine(4,Add,2500)})
			CIfEnd()
			CIf(FP,Gun_Line(4,AtLeast,2500))
				CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
				CDoActions(FP,{Gun_SetLine(5,Add,1)})
				CDoActions(FP,{Gun_SetLine(6,Add,15)})
				CDoActions(FP,{Gun_SetLine(7,Add,10)})
				CDoActions(FP,{Gun_SetLine(8,Add,5)})
				CDoActions(FP,{Gun_SetLine(9,Add,3)})
				CIf(FP,CVar(FP,Level[2],AtLeast,11))
				function BYDTechGunFunc()

					f_TempRepeatX(VArr(HeroVArr,_Mod(_Rand(),_Mov(#HeroArr))),1)
					
					end
					
					local BYDTechGunCAPlot = CAPlotForward()
					CMov(FP,V(BYDTechGunCAPlot[5]),_Mul(LevelT,2))
					CAPlot(CSMakePolygon(6,96,0,PlotSizeCalc(6,1),1),P8,nilunit,0,nil,1,32,{1,0,0,0,9999,0},nil,FP,
						nil,nil,
						1,"BYDTechGunFunc")
					
					CMov(FP,V(BYDTechGunCAPlot[6]),1)
					
					Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3])
				CIfEnd()
			CIfEnd()
			TriggerX(FP,{Gun_Line(0,Exactly,137)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,56)},{Preserved})
			TriggerX(FP,{Gun_Line(0,Exactly,142)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,54)},{Preserved})
			TriggerX(FP,{Gun_Line(0,Exactly,135)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,53)},{Preserved})
			TriggerX(FP,{Gun_Line(0,Exactly,140)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,48)},{Preserved})
			TriggerX(FP,{Gun_Line(0,Exactly,141)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,55)},{Preserved})
			TriggerX(FP,{Gun_Line(0,Exactly,138)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,51)},{Preserved})
			TriggerX(FP,{Gun_Line(0,Exactly,139)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,53)},{Preserved})
			f_Repeat(7)
			CMov(FP,Gun_TempSpawnSet1,0)
			TriggerX(FP,{Gun_Line(0,Exactly,139)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,54)},{Preserved})
			TriggerX(FP,{Gun_Line(0,Exactly,138)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,104)},{Preserved})
			f_Repeat(8)
			CMov(FP,Gun_TempSpawnSet1,0)
			TriggerX(FP,{Gun_Line(0,Exactly,138)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,56)},{Preserved})
			f_Repeat(9)
			CMov(FP,Gun_TempSpawnSet1,0)
			TriggerX(FP,{Gun_Line(0,Exactly,138)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,45)},{Preserved})
			f_Repeat(10)
			CTrigger(FP,{Gun_Line(5,AtLeast,7)},{Gun_DoSuspend()},1)
			
		CIfEnd()
	end
end

