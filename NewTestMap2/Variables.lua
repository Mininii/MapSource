function Include_Vars()
	--System
	LimitVerPtr = 0x58f608
	Nextptrs = CreateVar(FP)
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
	_0D = string.rep("\x0D",200) 
	--Interface
	TestShop = CreateVarArr(7, FP)

	SettingUnit1 = CreateVarArr(7, FP)
	SettingUnit2 = CreateVarArr(7, FP)

	DpsLV1 = CreateVarArr(7, FP)
	DpsLV2 = CreateVarArr(7, FP)
	PEXP = CreateWarArr(7, FP)
	ELevel = CreateVar(FP)
	EExp = CreateVar(FP)
	ECP = CreateVar(FP)
	GEper = CreateVar(FP)
	GEper2 = CreateVar(FP)
	GEper3 = CreateVar(FP)
	UEper = CreateVar(FP)
	if TestStart == 1 then 
		ETestTxt1 = CreateCText(FP,"��µ� ���� : ")
		ETestTxt2 = CreateCText(FP,"���� Ȯ�� : ")
		ETestStrPtr1 = CreateVar(FP)
		ETestStrPtr2 = CreateVar(FP)
	end

	ShopSw = CreateCcodeArr(7)

	--String
	
	iStr1 = GetiStrId(FP,MakeiStrWord(MakeiStrVoid(54).."\r\n",2)) 
	Str1, Str1a, Str1s = SaveiStrArr(FP,MakeiStrVoid(54))



	--Balance
	LevelUnitArr = {}
	AutoEnchArr = {}
	PatchInit()

	
	
	PushLevelUnit(1,75000,0,0,0,24*1,1,0,60)--����
	PushLevelUnit(2,75000,0,1,2,24*3,10,1,59)--��Ʈ
	PushLevelUnit(3,75000,0,2,4,24*3,20,2,59)--����
	PushLevelUnit(4,75000,0,7,13,24*2,20,2,59)--������
	PushLevelUnit(5,65000,0,8,16,24*2,30,3,59)--���̽�
	PushLevelUnit(6,65000,0,5,11,24*2,50,5,59,1)--��ũ
	PushLevelUnit(7,65000,0,3,7,24*2,80,8,59,1)--��
	PushLevelUnit(8,65000,0,32,25,24*3,60,6,59)--�ĺ� 3Ÿ
	PushLevelUnit(9,60000,0,58,103,24*2,80,8,59)--��Ű�� 2Ÿ
	PushLevelUnit(10,60000,0,12,19,24*2,250,25,59)--��Ʋ



	PushLevelUnit(11,55000,0,65,64,24*3,250,25,59)--���� 2Ÿ
	PushLevelUnit(12,55000,0,66,66,24*2,400,40,59)--���
	PushLevelUnit(13,50000,0,67,68,24*2,550,55,59)--����
	PushLevelUnit(14,50000,0,61,111,24*3,1000,100,59)--����
	PushLevelUnit(15,45000,0,83,115,24*3,1300,130,59,nil,1)--����
	PushLevelUnit(16,45000,0,70,73,24*2,1000,100,59)--��ī��
	PushLevelUnit(17,40000,0,60,100,24*2,1300,130,59)--Ŀ����
	PushLevelUnit(18,40000,0,71,77,24*2,1800,180,59)--�ƺ���


	
	PushLevelUnit(19,50000,0,37,35,12,600,60,59)--���۸�
	PushLevelUnit(20,50000,0,38,38,24,2000,200,59)--�����
	PushLevelUnit(21,45000,0,43,48,24,2700,270,59)--��Ż
	PushLevelUnit(22,45000,0,44,46,24*2,7000,700,59)--�����
	PushLevelUnit(23,40000,0,62,104,24*2,10000,1000,59)--��ٿ췯
	PushLevelUnit(24,40000,0,39,40,24*2,13000,1300,59)--��Ʈ��
	PushLevelUnit(25,35000,0,46,50,24,10000,1000,59)--����



	PushLevelUnit(25+1,35000,1,20,1,24*1,10,1,60)--����
	PushLevelUnit(25+2,30000,2,16,3,24*2,30,3,59)--���
	PushLevelUnit(25+3,30000,5,19,5,24*1,20,2,59)--��������
	PushLevelUnit(25+4,25000,10,17,10,24*1,30,3,59,1,1)--�˷�
	PushLevelUnit(25+5,25000,15,23,12,24*2,100,10,59,1)--��ũ
	PushLevelUnit(25+6,20000,25,53,39,24,80,8,59)--����
	PushLevelUnit(25+7,20000,40,52,51,24,150,15,59)--��Ŭ��
	PushLevelUnit(25+8,15000,75,69,53,24*3,700,70,59)--��Ʋ
	PushLevelUnit(25+9,15000,100,41,43,24,350,35,59)--���
	PushLevelUnit(25+10,10000,125,40,42,24*2,800,80,59)--��



	PushLevelUnit(25+11,10000,250,10,26,24*3,600,60,59)--�ĺ����� 3Ÿ
	PushLevelUnit(25+12,8000,1000,75,85,24,1200,120,59)--������
	PushLevelUnit(25+13,8000,10000,29,21,24*2,6000,600,59)--����
	PushLevelUnit(25+14,6000,100000,86,78,24*2,10000,1000,59)--�ٴϸ�
	PushLevelUnit(25+15,6000,1000000,54,36,1,5000,500,59,nil,1)--������� �����ִ�

	--���� �뷱�� ����
	--PushLevelUnit(25+16,4000,70,73,24*2,1000,100,59)--��ī��
	--PushLevelUnit(25+17,4000,60,100,24*2,1300,130,59)--Ŀ����
	--PushLevelUnit(25+18,3000,71,77,24*2,1800,180,59)--�ƺ���
	--PushLevelUnit(25+19,3000,37,35,12,600,60,59)--���۸�
	--PushLevelUnit(25+20,2000,38,38,24,2000,200,59)--�����
	--PushLevelUnit(25+21,2000,43,48,24,2700,270,59)--��Ż
	--PushLevelUnit(25+22,1000,44,46,24*2,7000,700,59)--�����
	--PushLevelUnit(25+23,1000,62,104,24*4,20000,2000,59)--��ٿ췯
	--PushLevelUnit(25+24,500,39,40,24*2,13000,1300,59)--��Ʈ��
	--PushLevelUnit(25+25,500,46,50,24*2,18000,1800,59)--����


	PopLevelUnit()


end