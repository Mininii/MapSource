function Var_init()
	PatchArr = {}
	PatchArr2 = {}
	PatchArrPrsv={}
	ZealotUIDArr = {}
	SetZealotUnit(89,5,30,117,8,nil,1400,0,7,tostring(5*256)) -- 1
	SetZealotUnit(90,500,500,118,40,1,2000,0,7,tostring(5*256)..string.rep("0",2)) -- 100 
	SetZealotUnit(93,50000,3500,119,65,nil,2350,0,6,tostring(5*256)..string.rep("0",4)) -- 10000
	SetZealotUnit(95,5000000,15000,120,120,nil,2700,0,5,tostring(5*256)..string.rep("0",6)) -- 1000000
	SetZealotUnit(96,500000000,65535,121,255,nil,3500,0,4,tostring(5*256)..string.rep("0",8)) -- 100000000
	
	RandSwitch = "Switch 100"
	RandSwitch2 = "Switch 101"
	P1VOFF = "Turn OFF Shared Vision for Player 1"
	P1VON = "Turn ON Shared Vision for Player 1"
	P2VOFF = "Turn OFF Shared Vision for Player 2"
	P2VON = "Turn ON Shared Vision for Player 2"
	P3VOFF = "Turn OFF Shared Vision for Player 3"
	P3VON = "Turn ON Shared Vision for Player 3"
	P4VOFF = "Turn OFF Shared Vision for Player 4"
	P4VON = "Turn ON Shared Vision for Player 4"
	P5VOFF = "Turn OFF Shared Vision for Player 5"
	P5VON = "Turn ON Shared Vision for Player 5"
	P6VOFF = "Turn OFF Shared Vision for Player 6"
	P6VON = "Turn ON Shared Vision for Player 6"
	P7VOFF = "Turn OFF Shared Vision for Player 7"
	P7VON = "Turn ON Shared Vision for Player 7"
	P8VOFF = "Turn OFF Shared Vision for Player 8"
	P8VON = "Turn ON Shared Vision for Player 8"
	JYD = "Set Unit Order To: Junk Yard Dog"
	Nextptrs = CreateVar(FP)
	Dt = CreateVar(FP)
	HumanPlayers={P1,P2,P3,P4,P5,P6,P7,P9,P10,P11,P12}
	MapPlayers={P1,P2,P3,P4}
	CA_Eff_Rat = CreateVar2(FP,nil,nil,80000)
	CA_Eff_XY = CreateVar(FP)
	CA_Eff_YZ = CreateVar(FP)
	CA_Eff_ZX = CreateVar(FP)
	SHLX = CreateVar2(FP,nil,nil,2048)
	SHLY = CreateVar2(FP,nil,nil,2048)
	CA_Create = CreateVar(FP)
	BCFlag=CreateCcode()
	ZcountT = CreateVarArr(5, FP)
	Zcount = CreateVar(FP)
	iStr1 = GetiStrId(FP,MakeiStrWord(MakeiStrVoid(54).."\r\n",5)) 
	Str1, Str1a, Str1s = SaveiStrArr(FP,MakeiStrVoid(54))
	KillW =CreateWar(FP)
	LocalPlayerV=CreateVar(FP)
	
	if LD2XOption==0 then
		EXPArr = CreateArr(500,FP)
		for i = 1, 500 do
			table.insert(CtrigInitArr[8],SetMemX(Arr(EXPArr,i-1),SetTo,i*i*i))
		end
	else
		local EXPTable = {}
		for i = 1, 500 do
			EXPTable[i]= i*i*i
		end
		EXPArr = f_GetFileArrptr(FP,EXPTable,4,1)
		TBLFile = f_GetFileptr(FP,"custom_txt.tbl",1) -- 제작했던 아무 TBL이나 AbsolutePath에 넣고 로드
		TBLFiles = f_GetFileSize("custom_txt.tbl") -- 예제에 사용된 tbl은 뎡디터2의 Data폴더에서 가져옴
		CUnitArr = f_GetVoidptr(FP,1700)

		-- 버튼셋		
		bytebuffer = {1,0,41,0,96,142,66,0,144,55,66,0,41,0,41,0,66,2,0,0,2,0,37,0,96,142,66,0,144,55,66,0,37,0,37,0,63,2,226,2,3,0,42,0,96,142,66,0,144,55,66,0,42,0,42,0,67,2,0,0,4,0,38,0,96,142,66,0,144,55,66,0,38,0,38,0,64,2,227,2,5,0,43,0,96,142,66,0,144,55,66,0,43,0,43,0,68,2,229,2,6,0,130,1,208,130,66,0,240,154,69,0,0,0,201,0,90,5,10,6,7,0,45,0,96,142,66,0,144,55,66,0,45,0,45,0,70,2,231,2,8,0,39,0,96,142,66,0,144,55,66,0,39,0,39,0,65,2,228,2,9,0,46,0,96,142,66,0,144,55,66,0,46,0,46,0,71,2,232,2}
		btnptr35 = f_GetFileArrptr(FP,bytebuffer,1,1)
		bytebuffer = {1,0,228,0,208,130,66,0,64,68,66,0,0,0,0,0,152,2,0,0,2,0,229,0,208,130,66,0,240,51,66,0,0,0,0,0,153,2,0,0,3,0,230,0,48,143,66,0,128,67,66,0,0,0,0,0,154,2,0,0,4,0,254,0,208,130,66,0,64,65,66,0,0,0,0,0,155,2,0,0,5,0,255,0,208,130,66,0,112,51,66,0,0,0,0,0,156,2,0,0,7,0,44,0,96,142,66,0,144,55,66,0,44,0,44,0,69,2,230,2,8,0,62,0,96,142,66,0,144,55,66,0,62,0,62,0,8,5,17,5}
		btnptr43 = f_GetFileArrptr(FP,bytebuffer,1,1)
		bytebuffer = {1,0,228,0,192,131,66,0,64,68,66,0,0,0,0,0,152,2,0,0,2,0,229,0,192,131,66,0,240,51,66,0,0,0,0,0,153,2,0,0,3,0,230,0,48,143,66,0,128,67,66,0,0,0,0,0,154,2,0,0,4,0,254,0,192,131,66,0,64,65,66,0,0,0,0,0,155,2,0,0,5,0,255,0,192,131,66,0,112,51,66,0,0,0,0,0,156,2,0,0,9,0,3,1,240,144,66,0,176,50,66,0,11,0,11,0,116,1,126,1,9,0,4,1,112,144,66,0,144,50,66,0,11,0,0,0,117,1,0,0}
		btnptr46 = f_GetFileArrptr(FP,bytebuffer,1,1)
		bytebuffer = {1,0,228,0,192,131,66,0,64,68,66,0,0,0,0,0,152,2,0,0,2,0,229,0,192,131,66,0,240,51,66,0,0,0,0,0,153,2,0,0,3,0,230,0,48,143,66,0,128,67,66,0,0,0,0,0,154,2,0,0,4,0,254,0,192,131,66,0,64,65,66,0,0,0,0,0,155,2,0,0,5,0,255,0,192,131,66,0,112,51,66,0,0,0,0,0,156,2,0,0,9,0,3,1,240,144,66,0,176,50,66,0,11,0,11,0,116,1,126,1,9,0,4,1,112,144,66,0,144,50,66,0,11,0,0,0,117,1,0,0}
		btnptr52 = f_GetFileArrptr(FP,bytebuffer,1,1)
		bytebuffer = {1,0,228,0,208,130,66,0,64,68,66,0,0,0,0,0,152,2,0,0,2,0,229,0,208,130,66,0,240,51,66,0,0,0,0,0,153,2,0,0,3,0,230,0,48,143,66,0,128,67,66,0,0,0,0,0,154,2,0,0,4,0,254,0,208,130,66,0,64,65,66,0,0,0,0,0,155,2,0,0,5,0,255,0,208,130,66,0,112,51,66,0,0,0,0,0,156,2,0,0}
		btnptr61 = f_GetFileArrptr(FP,bytebuffer,1,1)
		bytebuffer = {1,0,228,0,208,130,66,0,64,68,66,0,0,0,0,0,152,2,0,0,2,0,229,0,208,130,66,0,240,51,66,0,0,0,0,0,153,2,0,0,3,0,230,0,48,143,66,0,128,67,66,0,0,0,0,0,154,2,0,0,4,0,254,0,208,130,66,0,64,65,66,0,0,0,0,0,155,2,0,0,5,0,255,0,208,130,66,0,112,51,66,0,0,0,0,0,156,2,0,0,7,0,116,1,224,148,66,0,112,63,66,0,29,0,29,0,243,4,249,4,8,0,115,1,224,148,66,0,112,63,66,0,27,0,27,0,242,4,246,4,9,0,125,1,224,148,66,0,112,63,66,0,31,0,31,0,244,4,250,4}
		btnptr63 = f_GetFileArrptr(FP,bytebuffer,1,1)
		bytebuffer = {1,0,228,0,208,130,66,0,64,68,66,0,0,0,0,0,152,2,0,0,2,0,229,0,208,130,66,0,240,51,66,0,0,0,0,0,153,2,0,0,3,0,230,0,48,143,66,0,128,67,66,0,0,0,0,0,154,2,0,0,4,0,254,0,208,130,66,0,64,65,66,0,0,0,0,0,155,2,0,0,5,0,255,0,208,130,66,0,112,51,66,0,0,0,0,0,156,2,0,0,7,0,24,1,224,148,66,0,112,63,66,0,21,0,21,0,146,1,151,1}
		btnptr71 = f_GetFileArrptr(FP,bytebuffer,1,1)
		bytebuffer = {1,0,228,0,208,130,66,0,96,66,66,0,0,0,0,0,152,2,0,0,2,0,229,0,208,130,66,0,176,51,66,0,0,0,0,0,153,2,0,0,3,0,230,0,48,143,66,0,128,67,66,0,0,0,0,0,154,2,10,6,4,0,254,0,208,130,66,0,64,65,66,0,0,0,0,0,155,2,0,0,5,0,255,0,208,130,66,0,112,51,66,0,0,0,0,0,156,2,0,0}
		btnptr83 = f_GetFileArrptr(FP,bytebuffer,1,1)
		bytebuffer = {1,0,228,0,32,132,66,0,64,68,66,0,0,0,0,0,152,2,0,0,1,0,0,0,96,142,66,0,176,52,66,0,0,0,0,0,74,2,0,0,2,0,229,0,32,132,66,0,240,51,66,0,0,0,0,0,153,2,0,0,2,0,32,0,96,142,66,0,176,52,66,0,32,0,32,0,76,2,190,2,3,0,1,0,96,142,66,0,176,52,66,0,1,0,1,0,75,2,189,2,4,0,34,0,96,142,66,0,176,52,66,0,34,0,34,0,10,5,14,5,5,0,0,0,96,142,66,0,176,52,66,0,20,0,20,0,66,5,0,0,6,0,30,1,32,149,66,0,160,68,66,0,0,0,0,0,160,2,0,0,7,0,32,0,96,142,66,0,176,52,66,0,10,0,10,0,67,5,190,2,8,0,1,0,96,142,66,0,176,52,66,0,100,0,100,0,68,5,189,2,9,0,27,1,240,131,66,0,48,60,66,0,0,0,111,0,158,2,0,0,9,0,26,1,208,135,66,0,48,50,66,0,0,0,0,0,159,2,0,0,9,0,236,0,48,133,66,0,144,52,66,0,0,0,254,0,181,2,0,0,9,0,236,0,32,137,66,0,208,50,66,0,0,0,0,0,182,2,0,0}
		btnptr111 = f_GetFileArrptr(FP,bytebuffer,1,1)
		bytebuffer = {1,0,228,0,32,132,66,0,64,68,66,0,0,0,0,0,152,2,0,0,1,0,2,0,96,142,66,0,176,52,66,0,2,0,2,0,77,2,0,0,2,0,229,0,32,132,66,0,240,51,66,0,0,0,0,0,153,2,0,0,2,0,5,0,96,142,66,0,176,52,66,0,5,0,5,0,79,2,192,2,3,0,3,0,96,142,66,0,176,52,66,0,3,0,3,0,78,2,191,2,4,0,2,0,96,142,66,0,176,52,66,0,19,0,19,0,69,5,0,0,5,0,5,0,96,142,66,0,176,52,66,0,23,0,23,0,70,5,192,2,6,0,30,1,32,149,66,0,160,68,66,0,0,0,0,0,160,2,0,0,7,0,120,0,96,142,66,0,16,61,66,0,120,0,120,0,151,2,0,0,8,0,3,0,96,142,66,0,176,52,66,0,17,0,17,0,71,5,191,2,9,0,27,1,240,131,66,0,48,60,66,0,0,0,113,0,158,2,0,0,9,0,26,1,208,135,66,0,48,50,66,0,0,0,0,0,159,2,0,0,9,0,236,0,48,133,66,0,144,52,66,0,0,0,254,0,181,2,0,0,9,0,236,0,0,137,66,0,240,50,66,0,0,0,0,0,179,2,0,0,9,0,236,0,32,137,66,0,208,50,66,0,0,0,0,0,182,2,0,0}
		btnptr113 = f_GetFileArrptr(FP,bytebuffer,1,1)
		bytebuffer = {1,0,228,0,32,132,66,0,64,68,66,0,0,0,0,0,152,2,0,0,1,0,8,0,96,142,66,0,176,52,66,0,8,0,8,0,81,2,0,0,2,0,229,0,32,132,66,0,240,51,66,0,0,0,0,0,153,2,0,0,2,0,11,0,96,142,66,0,176,52,66,0,11,0,11,0,83,2,194,2,3,0,9,0,96,142,66,0,176,52,66,0,9,0,9,0,82,2,193,2,4,0,12,0,96,142,66,0,176,52,66,0,12,0,12,0,84,2,195,2,5,0,58,0,96,142,66,0,176,52,66,0,58,0,58,0,11,5,15,5,6,0,8,0,96,142,66,0,176,52,66,0,21,0,21,0,72,5,0,0,7,0,115,0,96,142,66,0,16,61,66,0,115,0,115,0,148,2,0,0,8,0,12,0,96,142,66,0,176,52,66,0,28,0,28,0,73,5,195,2,9,0,27,1,240,131,66,0,48,60,66,0,0,0,114,0,158,2,0,0,9,0,26,1,208,135,66,0,48,50,66,0,0,0,0,0,159,2,0,0,9,0,236,0,48,133,66,0,144,52,66,0,0,0,254,0,181,2,0,0,9,0,236,0,32,137,66,0,208,50,66,0,0,0,0,0,182,2,0,0}
		btnptr114 = f_GetFileArrptr(FP,bytebuffer,1,1)
		bytebuffer = {1,0,31,1,80,148,66,0,16,51,66,0,17,0,17,0,217,1,0,0,3,0,245,0,0,149,66,0,80,51,66,0,5,0,5,0,72,1,0,0,4,0,124,1,80,148,66,0,16,51,66,0,54,0,54,0,2,5,7,5,9,0,236,0,224,136,66,0,48,51,66,0,0,0,0,0,180,2,0,0,9,0,236,0,0,137,66,0,240,50,66,0,0,0,0,0,179,2,0,0}
		btnptr120 = f_GetFileArrptr(FP,bytebuffer,1,1)
		bytebuffer = {1,0,69,0,96,142,66,0,176,52,66,0,69,0,69,0,91,2,0,0,2,0,83,0,96,142,66,0,176,52,66,0,83,0,83,0,96,2,211,2,3,0,83,0,96,142,66,0,176,52,66,0,81,0,81,0,78,5,211,2,4,0,68,0,96,142,66,0,176,52,66,0,76,0,76,0,79,5,208,2,5,0,63,0,96,142,66,0,176,52,66,0,63,0,63,0,80,5,16,5,6,0,30,1,32,149,66,0,160,68,66,0,0,0,0,0,160,2,0,0,9,0,236,0,48,133,66,0,144,52,66,0,0,0,254,0,181,2,0,0}
		btnptr155 = f_GetFileArrptr(FP,bytebuffer,1,1)
		bytebuffer = {1,0,65,0,96,142,66,0,176,52,66,0,65,0,65,0,88,2,0,0,2,0,66,0,96,142,66,0,176,52,66,0,66,0,66,0,89,2,207,2,3,0,67,0,96,142,66,0,176,52,66,0,67,0,67,0,90,2,208,2,4,0,61,0,96,142,66,0,176,52,66,0,61,0,61,0,13,5,16,5,5,0,65,0,96,142,66,0,176,52,66,0,77,0,77,0,74,5,0,0,6,0,66,0,96,142,66,0,176,52,66,0,78,0,78,0,75,5,207,2,7,0,67,0,96,142,66,0,176,52,66,0,79,0,79,0,76,5,208,2,8,0,61,0,96,142,66,0,176,52,66,0,75,0,75,0,77,5,16,5,9,0,30,1,32,149,66,0,160,68,66,0,0,0,0,0,160,2,0,0,9,0,236,0,48,133,66,0,144,52,66,0,0,0,254,0,181,2,0,0}
		btnptr160 = f_GetFileArrptr(FP,bytebuffer,1,1)
		bytebuffer = {1,0,19,1,0,149,66,0,80,51,66,0,19,0,19,0,139,1,0,0,3,0,62,1,80,148,66,0,16,51,66,0,40,0,40,0,240,1,0,0,5,0,125,1,0,149,66,0,80,51,66,0,31,0,31,0,239,4,0,0,6,0,129,1,80,148,66,0,16,51,66,0,49,0,49,0,6,5,0,0,9,0,236,0,224,136,66,0,48,51,66,0,0,0,0,0,180,2,0,0,9,0,236,0,0,137,66,0,240,50,66,0,0,0,0,0,179,2,0,0}
		btnptr165 = f_GetFileArrptr(FP,bytebuffer,1,1)
		bytebuffer = {1,0,70,0,96,142,66,0,176,52,66,0,70,0,70,0,92,2,0,0,3,0,71,0,96,142,66,0,176,52,66,0,71,0,71,0,93,2,209,2,4,0,60,0,96,142,66,0,176,52,66,0,60,0,60,0,12,5,0,0,5,0,72,0,96,142,66,0,176,52,66,0,82,0,82,0,89,5,210,2,6,0,30,1,32,149,66,0,160,68,66,0,0,0,0,0,160,2,0,0,7,0,70,0,96,142,66,0,176,52,66,0,88,0,88,0,81,5,0,0,8,0,71,0,96,142,66,0,176,52,66,0,86,0,86,0,82,5,209,2,9,0,236,0,48,133,66,0,144,52,66,0,0,0,254,0,181,2,0,0}
		btnptr167 = f_GetFileArrptr(FP,bytebuffer,1,1)
		bytebuffer = {1,0,63,1,80,148,66,0,16,51,66,0,41,0,41,0,241,1,0,0,2,0,64,1,80,148,66,0,16,51,66,0,42,0,42,0,242,1,0,0,3,0,65,1,80,148,66,0,16,51,66,0,43,0,43,0,243,1,0,0,5,0,127,1,80,148,66,0,16,51,66,0,47,0,47,0,5,5,0,0,9,0,236,0,0,137,66,0,240,50,66,0,0,0,0,0,179,2,0,0,9,0,236,0,224,136,66,0,48,51,66,0,0,0,0,0,180,2,0,0}
		btnptr169 = f_GetFileArrptr(FP,bytebuffer,1,1)
		bytebuffer = {1,0,24,1,0,149,66,0,80,51,66,0,21,0,21,0,141,1,0,0,3,0,66,1,80,148,66,0,16,51,66,0,44,0,44,0,244,1,0,0,9,0,236,0,224,136,66,0,48,51,66,0,0,0,0,0,180,2,0,0,9,0,236,0,0,137,66,0,240,50,66,0,0,0,0,0,179,2,0,0}
		btnptr170 = f_GetFileArrptr(FP,bytebuffer,1,1)
		bytebuffer = {2,0,37,0,96,142,66,0,144,55,66,0,54,0,54,0,83,5,226,2,4,0,38,0,96,142,66,0,144,55,66,0,53,0,53,0,84,5,227,2,5,0,43,0,96,142,66,0,144,55,66,0,55,0,55,0,85,5,229,2,6,0,44,0,96,142,66,0,144,55,66,0,56,0,56,0,86,5,230,2,7,0,46,0,96,142,66,0,144,55,66,0,52,0,52,0,88,5,232,2,8,0,39,0,96,142,66,0,144,55,66,0,48,0,48,0,87,5,228,2,9,0,236,0,208,130,66,0,240,154,69,0,70,0,228,0,177,2,10,6}
		btnptr201 = f_GetFileArrptr(FP,bytebuffer,1,1)
		bytebuffer = {1,0,228,0,208,130,66,0,64,68,66,0,0,0,0,0,152,2,0,0,2,0,229,0,208,130,66,0,240,51,66,0,0,0,0,0,153,2,0,0,3,0,230,0,48,143,66,0,128,67,66,0,0,0,0,0,154,2,0,0,4,0,254,0,208,130,66,0,64,65,66,0,0,0,0,0,155,2,0,0,5,0,255,0,208,130,66,0,112,51,66,0,0,0,0,0,156,2,0,0}
		btnptr73 = f_GetFileArrptr(FP,bytebuffer,1,1)
	end

	
	Level=CreateVarArr(4, FP)
	Pts=CreateVarArr(4, FP)
	CurExpTmp = CreateWarArr(4, FP)
	CurEXP = CreateVarArr(4, FP)
	MaxEXP = CreateVarArr(4, FP)
	ArrI = CreateVar(FP)
	Minpsec = CreateVarArr(4, FP)
	Gaspsec = CreateVarArr(4, FP)

	HeroArr={}
	TestCD = CreateCcode()

		
	t01 = " 000,000,000 \x04(00000\x0D\x04) - 00000  \x1BＤｍｇ"
	iStrSize1 = GetiStrSize(0,t01)
	S1 = MakeiTblString(827,"None",'None',MakeiStrLetter("\x0D",iStrSize1+5),"Base",1) -- 단축키없음
	iTbl1 = GetiTblId(FP,827,S1) --
	TblStr1, TblStr1a, TblStr1s = SaveiStrArr(FP,t01)
	CurCunitI= CreateVar(FP)
	CunitIndex = CreateVar(FP)

end