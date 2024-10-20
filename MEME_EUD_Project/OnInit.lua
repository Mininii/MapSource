function OnInit()
	if TestStart == 1 then
			
		if TestStart == 1 then
			DoActionsX(FP,{SetSwitch("Switch 254", Set)}) -- Limit설정
			DoActionsX(FP, {SetCD(TestMode,1),--SetResources(Force1, Add, 66666666, Ore),
			})
		end
		if Limit == 1 then
			DoActionsX(FP,{SetSwitch("Switch 253", Set)}) -- Limit설정
		end
		DoActionsX(FP, {SetMemory(0x5124F0,SetTo,0x1D)}, 1)
	end

	UnitRepIndex2 = CreateVar(FP)
	RepHeroIndex = CreateVar(FP)
	PlayerV = CreateVar(FP)
	UnitRepIndex = CreateVar(FP)
	CIfOnce(FP,{ElapsedTime(AtLeast, 4)})
	RepPlayerID = CreateVar(FP)
	CWhile(FP, {CV(UnitRepIndex,1,AtLeast)})
	f_Read(FP, ArrX(UnitPosArr,UnitRepIndex2), CPos)
	f_Read(FP, ArrX(UnitIDArr,UnitRepIndex2), RepHeroIndex)
	f_Read(FP, ArrX(PlayerIDArr,UnitRepIndex2), RepPlayerID)
	Convert_CPosXY()
	Simple_SetLocX(FP, 0, CPosX, CPosY, CPosX, CPosY)
	
	CIf(FP,{Memory(0x628438, AtLeast, 1)})
	f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
	CDoActions(FP, {TCreateUnit(1, RepHeroIndex, 1, RepPlayerID)})
	CIfEnd()

	CAdd(FP,UnitRepIndex2,1)
	CSub(FP,UnitRepIndex,1)
	CWhileEnd()

Shape1000 = {2   ,{416, 3936},{416, 3904}}
Shape1020 = {1   ,{416, 3872}}
Shape2000 = {2   ,{448, 3936},{448, 3904}}
Shape2020 = {1   ,{448, 3872}}
Shape3000 = {2   ,{480, 3936},{480, 3904}}
Shape3020 = {1   ,{480, 3872}}
Shape4000 = {2   ,{512, 3936},{512, 3904}}
Shape4020 = {1   ,{512, 3872}}
Shape5000 = {2   ,{544, 3936},{544, 3904}}
Shape5020 = {1   ,{544, 3872}}
CSPlot(Shape1000,P1,00,0,{0,0},1,32,FP,{HumanCheck(P1, 1)})
CSPlot(Shape1020,P1,20,0,{0,0},1,32,FP,{HumanCheck(P1, 1)})
CSPlot(Shape2000,P2,00,0,{0,0},1,32,FP,{HumanCheck(P2, 1)})
CSPlot(Shape2020,P2,20,0,{0,0},1,32,FP,{HumanCheck(P2, 1)})
CSPlot(Shape3000,P3,00,0,{0,0},1,32,FP,{HumanCheck(P3, 1)})
CSPlot(Shape3020,P3,20,0,{0,0},1,32,FP,{HumanCheck(P3, 1)})
CSPlot(Shape4000,P4,00,0,{0,0},1,32,FP,{HumanCheck(P4, 1)})
CSPlot(Shape4020,P4,20,0,{0,0},1,32,FP,{HumanCheck(P4, 1)})
CSPlot(Shape5000,P5,00,0,{0,0},1,32,FP,{HumanCheck(P5, 1)})
CSPlot(Shape5020,P5,20,0,{0,0},1,32,FP,{HumanCheck(P5, 1)})


	CIfEnd()




	CIfOnce(FP)
	SizePatchArr = {48,53,54,55,56,62,11,8,12,21,28,29,70,82,81,86,88,50,25,80,87,98,30}
	for j,k in pairs(SizePatchArr) do
		SetUnitsDatX(k, {SizeL = 4,SizeU = 4,SizeR = 4,	SizeD = 4,})
	end
	DoActions2(FP, PatchArr)
	DoActions2(FP, PatchArr2)
	DoActions2(AllPlayers, PatchArrPrsv)


	
	
	CFor(FP,19025,19025+(84*1700),84)
	CI = CForVariable()
	
	RepArr = SizePatchArr
	table.insert(RepArr,13)
	condbox = {}
	for j,k in pairs(RepArr) do
		table.insert(condbox,CV(RepHeroIndex,k))
	end
	
	f_Read(FP,_Add(CI,25),RepHeroIndex,nil,0xFF,1)
	f_Read(FP,_Add(CI,19),PlayerV,nil,0xFF,1)
	CIf(FP,{TTOR(condbox)})
	f_Read(FP,_Add(CI,10),CPos)
	CMov(FP,ArrX(UnitPosArr,UnitRepIndex),CPos)
	CMov(FP,ArrX(UnitIDArr,UnitRepIndex),RepHeroIndex,nil,0xFF,1)
	CMov(FP,ArrX(PlayerIDArr,UnitRepIndex),PlayerV,nil,0xFF,1)
	CAdd(FP,UnitRepIndex,1)
	CIfEnd()


	CTrigger(FP, {
		CV(PlayerV,5,AtLeast);
		TTOR({ -- 투명화 선택
		CV(RepHeroIndex,174),
		CV(RepHeroIndex,147),
		CV(RepHeroIndex,148),
		CV(RepHeroIndex,130),
		CV(RepHeroIndex,200),
		CV(RepHeroIndex,167),
		CV(RepHeroIndex,154),
		CV(RepHeroIndex,127),
		CV(RepHeroIndex,123),
		CV(RepHeroIndex,175),
		CV(RepHeroIndex,189),
		CV(RepHeroIndex,106),
		CV(RepHeroIndex,168),
		CV(RepHeroIndex,126),
		CV(RepHeroIndex,152),
		CV(RepHeroIndex,150),
	})}, {
		TSetMemoryX(_Add(CI,55), SetTo, 0x100,0x100),
		TSetMemoryX(_Add(CI,57), SetTo, 0,0xFF),
	}, {preserved})


	CForEnd()
	removebox = {}
	for j,k in pairs(RepArr) do
		table.insert(removebox,ModifyUnitEnergy(All, k, AllPlayers, 64, 0))
		table.insert(removebox,RemoveUnit(k, AllPlayers))
	end

	DoActions2(FP, removebox)
	DoActions(FP,{
		SetPlayerColor(P6, SetTo, 154);
		SetPlayerColor(P7, SetTo, 255);
		SetPlayerColor(P8, SetTo, 128);
		SetMinimapColor(P6, SetTo, 154),
		SetMinimapColor(P7, SetTo, 255),
		SetMinimapColor(P8, SetTo, 128),
		ModifyUnitHangarCount(2, All, "Gantrithor (Carrier)", AllPlayers, "Anywhere");
	})

	CIfEnd()
end