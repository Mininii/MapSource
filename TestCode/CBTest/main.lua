
-- to DeskTop : Curdir="C:\\Users\\USER\\Documents\\"
-- to LAPTOP : Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
--__MapDirSetting(__encode_cp949("C:\\euddraft0.9.2.0")) -- 맵파일 경로(\를 \\로 바꿔야함)
--__SubDirSetting(__encode_cp949(Curdir.."MapSource\\TestCode")) -- Main.lua 폴더경로 (\를 \\로 바꿔야함, 없으면 비우기)
--속도측정용
--local x = os.clock()
----------------------------------------------Loader Space ---------------------------------------------------------------------


--Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
EXTLUA = "dir \""..Curdir.."\\MapSource\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$"  then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\Library\\"..dir))
		InitEXTLua()
     end
end

SnowFlake =
{140,{1.2540383223269e-015,-20.48},{17.736200269506,-10.24},{17.736200269506,10.24},{1.2540383223269e-015,20.48},{-17.736200269506,10.24},{-17.736200269506,-10.24},{2.5080766446538e-015,-40.96},{35.47240053901,-20.48},{35.47240053901,20.48},{2.5080766446538e-015,40.96},{-35.47240053901,20.48},{-35.47240053901,-20.48},{3.7621149669806e-015,-61.44},{53.208600808516,-30.72},{53.208600808516,30.72},{3.7621149669806e-015,61.44},{-53.208600808516,30.72},{-53.208600808516,-30.72},{5.0161532893076e-015,-81.92},{70.944801078022,-40.96},{70.944801078022,40.96},{5.0161532893076e-015,81.92},{-70.944801078022,40.96},{-70.944801078022,-40.96},{6.2701916116344e-015,-102.4},{88.681001347528,-51.2},{88.681001347528,51.2},{6.2701916116344e-015,102.4},{-88.681001347528,51.2},{-88.681001347528,-51.2},{7.5242299339616e-015,-122.88},{106.41720161703,-61.44},{106.41720161703,61.44},{7.5242299339616e-015,122.88},{-106.41720161703,61.44},{-106.41720161703,-61.44},{8.778268256288e-015,-143.36},{124.15340188654,-71.68},{124.15340188654,71.68},{8.778268256288e-015,143.36},{-124.15340188654,71.68},{-124.15340188654,-71.68},{1.0032306578615e-014,-163.84},{141.88960215605,-81.92},{141.88960215605,81.92},{1.0032306578615e-014,163.84},{-141.88960215605,81.92},{-141.88960215605,-81.92},{1.1286344900942e-014,-184.32},{159.62580242555,-92.16},{159.62580242555,92.16},{1.1286344900942e-014,184.32},{-159.62580242555,92.16},{-159.62580242555,-92.16},{31.038350471634,-53.76},{46.557525707451,-44.8},{62.076700943269,-17.92},{62.076700943269,0},{62.076700943269,17.92},{46.557525707451,44.8},{31.038350471634,53.76},{15.519175235817,62.72},{4.3891341281442e-015,71.68},{-15.519175235817,62.72},{-31.038350471634,53.76},{-46.557525707451,44.8},{-62.076700943269,17.92},{-62.076700943269,7.6022033111802e-015},{-62.076700943269,-17.92},{-46.557525707451,-44.8},{-31.038350471634,-53.76},{-15.519175235817,-62.72},{-1.3167402384433e-014,-71.68},{15.519175235817,-62.72},{46.557525707451,-80.64},{62.076700943269,-71.68},{77.595876179085,-62.72},{93.115051414904,-35.84},{93.115051414904,-17.92},{93.115051414904,0},{93.115051414904,17.92},{93.115051414904,35.84},{77.595876179085,62.72},{62.076700943269,71.68},{46.557525707451,80.64},{31.038350471634,89.6},{15.519175235817,98.56},{-15.519175235817,98.56},{-31.038350471634,89.6},{-46.557525707451,80.64},{-62.076700943269,71.68},{-77.595876179085,62.72},{-93.115051414904,35.84},{-93.115051414904,17.92},{-93.115051414904,1.140330496677e-014},{-93.115051414904,-17.92},{-93.115051414904,-35.84},{-77.595876179085,-62.72},{-62.076700943269,-71.68},{-46.557525707451,-80.64},{-31.038350471634,-89.6},{-15.519175235817,-98.56},{15.519175235817,-98.56},{31.038350471634,-89.6},{15.519175235817,-142.08},{-15.519175235817,-142.08},{-115.28530175178,-84.48},{-130.8044769876,-57.6},{-130.8044769876,57.6},{-115.28530175178,84.48},{-15.519175235817,142.08},{15.519175235817,142.08},{115.28530175178,84.48},{130.8044769876,57.6},{130.8044769876,-57.6},{115.28530175178,-84.48},{31.038350471634,-151.04},{-31.038350471634,-151.04},{-115.28530175178,-102.4},{-146.32365222342,-48.64},{-146.32365222342,48.64},{-115.28530175178,102.4},{-31.038350471634,151.04},{31.038350471634,151.04},{115.28530175178,102.4},{146.32365222342,48.64},{146.32365222342,-48.64},{115.28530175178,-102.4},{46.557525707451,-160},{-46.557525707451,-160},{-115.28530175178,-120.32},{-161.84282745924,-39.68},{-161.84282745924,39.68},{-115.28530175178,120.32},{-46.557525707451,160},{46.557525707451,160},{115.28530175178,120.32},{161.84282745924,39.68},{161.84282745924,-39.68},{115.28530175178,-120.32}}

--↓ 이곳에 예제를 붙여넣기 (예제에 Include_CtrigPlib가 존재하는경우 삭제 또는 교체) ----------------------

SetForces({P1},{P2},{},{},{P1,P2}) 
SetFixedPlayer(P1)
StartCtrig(1,P1,nil,1,"C:\\Temp")



Trigger { -- 유닛크기변경
	players = {P1},
	actions = {
		SetMemory(0x6617C8, SetTo, 0x00010001);
		SetMemory(0x6617CC, SetTo, 0x00010001);
		SetMemory(0x6617D0, SetTo, 0x00010001);
		SetMemory(0x6617D4, SetTo, 0x00010001);
		SetMemory(0x6617D8, SetTo, 0x00010001);
		SetMemory(0x6617DC, SetTo, 0x00010001);
		SetMemory(0x6617E0, SetTo, 0x00010001);
		SetMemory(0x6617E4, SetTo, 0x00010001);
		SetMemory(0x6617E8, SetTo, 0x00010001);
		SetMemory(0x6617EC, SetTo, 0x00010001);
		SetMemory(0x6617F0, SetTo, 0x00010001);
		SetMemory(0x6617F4, SetTo, 0x00010001);
		SetMemory(0x6617F8, SetTo, 0x00010001);
		SetMemory(0x6617FC, SetTo, 0x00010001);
		SetMemory(0x661800, SetTo, 0x00010001);
		SetMemory(0x661804, SetTo, 0x00010001);
		SetMemory(0x661808, SetTo, 0x00010001);
		SetMemory(0x66180C, SetTo, 0x00010001);
		SetMemory(0x661810, SetTo, 0x00010001);
		SetMemory(0x661814, SetTo, 0x00010001);
		SetMemory(0x661818, SetTo, 0x00010001);
		SetMemory(0x66181C, SetTo, 0x00010001);
		SetMemory(0x661820, SetTo, 0x00010001);
		SetMemory(0x661824, SetTo, 0x00010001);
		SetMemory(0x661828, SetTo, 0x00010001);
		SetMemory(0x66182C, SetTo, 0x00010001);
		SetMemory(0x661830, SetTo, 0x00010001);
		SetMemory(0x661834, SetTo, 0x00010001);
		SetMemory(0x661838, SetTo, 0x00010001);
		SetMemory(0x66183C, SetTo, 0x00010001);
		SetMemory(0x661840, SetTo, 0x00010001);
		SetMemory(0x661844, SetTo, 0x00010001);
		SetMemory(0x661848, SetTo, 0x00010001);
		SetMemory(0x66184C, SetTo, 0x00010001);
		SetMemory(0x661850, SetTo, 0x00010001);
		SetMemory(0x661854, SetTo, 0x00010001);
		SetMemory(0x661858, SetTo, 0x00010001);
		SetMemory(0x66185C, SetTo, 0x00010001);
		SetMemory(0x661860, SetTo, 0x00010001);
		SetMemory(0x661864, SetTo, 0x00010001);
		SetMemory(0x661868, SetTo, 0x00010001);
		SetMemory(0x66186C, SetTo, 0x00010001);
		SetMemory(0x661870, SetTo, 0x00010001);
		SetMemory(0x661874, SetTo, 0x00010001);
		SetMemory(0x661878, SetTo, 0x00010001);
		SetMemory(0x66187C, SetTo, 0x00010001);
		SetMemory(0x661880, SetTo, 0x00010001);
		SetMemory(0x661884, SetTo, 0x00010001);
		SetMemory(0x661888, SetTo, 0x00010001);
		SetMemory(0x66188C, SetTo, 0x00010001);
		SetMemory(0x661890, SetTo, 0x00010001);
		SetMemory(0x661894, SetTo, 0x00010001);
		SetMemory(0x661898, SetTo, 0x00010001);
		SetMemory(0x66189C, SetTo, 0x00010001);
		SetMemory(0x6618A0, SetTo, 0x00010001);
		SetMemory(0x6618A4, SetTo, 0x00010001);
		SetMemory(0x6618A8, SetTo, 0x00010001);
		SetMemory(0x6618AC, SetTo, 0x00010001);
		SetMemory(0x6618B0, SetTo, 0x00010001);
		SetMemory(0x6618B4, SetTo, 0x00010001);
		SetMemory(0x6618B8, SetTo, 0x00010001);
		SetMemory(0x6618BC, SetTo, 0x00010001);
		SetMemory(0x6618C0, SetTo, 0x00010001);
		Comment("유닛크기변경");
	},
}


Trigger { -- 유닛크기변경
	players = {P1},
	actions = {
		SetMemory(0x6618C4, SetTo, 0x00010001);
		SetMemory(0x6618C8, SetTo, 0x00010001);
		SetMemory(0x6618CC, SetTo, 0x00010001);
		SetMemory(0x6618D0, SetTo, 0x00010001);
		SetMemory(0x6618D4, SetTo, 0x00010001);
		SetMemory(0x6618D8, SetTo, 0x00010001);
		SetMemory(0x6618DC, SetTo, 0x00010001);
		SetMemory(0x6618E0, SetTo, 0x00010001);
		SetMemory(0x6618E4, SetTo, 0x00010001);
		SetMemory(0x6618E8, SetTo, 0x00010001);
		SetMemory(0x6618EC, SetTo, 0x00010001);
		SetMemory(0x6618F0, SetTo, 0x00010001);
		SetMemory(0x6618F4, SetTo, 0x00010001);
		SetMemory(0x6618F8, SetTo, 0x00010001);
		SetMemory(0x6618FC, SetTo, 0x00010001);
		SetMemory(0x661900, SetTo, 0x00010001);
		SetMemory(0x661904, SetTo, 0x00010001);
		SetMemory(0x661908, SetTo, 0x00010001);
		SetMemory(0x66190C, SetTo, 0x00010001);
		SetMemory(0x661910, SetTo, 0x00010001);
		SetMemory(0x661914, SetTo, 0x00010001);
		SetMemory(0x661918, SetTo, 0x00010001);
		SetMemory(0x66191C, SetTo, 0x00010001);
		SetMemory(0x661920, SetTo, 0x00010001);
		SetMemory(0x661924, SetTo, 0x00010001);
		SetMemory(0x661928, SetTo, 0x00010001);
		SetMemory(0x66192C, SetTo, 0x00010001);
		SetMemory(0x661930, SetTo, 0x00010001);
		SetMemory(0x661934, SetTo, 0x00010001);
		SetMemory(0x661938, SetTo, 0x00010001);
		SetMemory(0x66193C, SetTo, 0x00010001);
		SetMemory(0x661940, SetTo, 0x00010001);
		SetMemory(0x661944, SetTo, 0x00010001);
		SetMemory(0x661948, SetTo, 0x00010001);
		SetMemory(0x66194C, SetTo, 0x00010001);
		SetMemory(0x661950, SetTo, 0x00010001);
		SetMemory(0x661954, SetTo, 0x00010001);
		SetMemory(0x661958, SetTo, 0x00010001);
		SetMemory(0x66195C, SetTo, 0x00010001);
		SetMemory(0x661960, SetTo, 0x00010001);
		SetMemory(0x661964, SetTo, 0x00010001);
		SetMemory(0x661968, SetTo, 0x00010001);
		SetMemory(0x66196C, SetTo, 0x00010001);
		SetMemory(0x661970, SetTo, 0x00010001);
		SetMemory(0x661974, SetTo, 0x00010001);
		SetMemory(0x661978, SetTo, 0x00010001);
		SetMemory(0x66197C, SetTo, 0x00010001);
		SetMemory(0x661980, SetTo, 0x00010001);
		SetMemory(0x661984, SetTo, 0x00010001);
		SetMemory(0x661988, SetTo, 0x00010001);
		SetMemory(0x66198C, SetTo, 0x00010001);
		SetMemory(0x661990, SetTo, 0x00010001);
		SetMemory(0x661994, SetTo, 0x00010001);
		SetMemory(0x661998, SetTo, 0x00010001);
		SetMemory(0x66199C, SetTo, 0x00010001);
		SetMemory(0x6619A0, SetTo, 0x00010001);
		SetMemory(0x6619A4, SetTo, 0x00010001);
		SetMemory(0x6619A8, SetTo, 0x00010001);
		SetMemory(0x6619AC, SetTo, 0x00010001);
		SetMemory(0x6619B0, SetTo, 0x00010001);
		SetMemory(0x6619B4, SetTo, 0x00010001);
		SetMemory(0x6619B8, SetTo, 0x00010001);
		SetMemory(0x6619BC, SetTo, 0x00010001);
		Comment("유닛크기변경");
	},
}


Trigger { -- 유닛크기변경
	players = {P1},
	actions = {
		SetMemory(0x6619C0, SetTo, 0x00010001);
		SetMemory(0x6619C4, SetTo, 0x00010001);
		SetMemory(0x6619C8, SetTo, 0x00010001);
		SetMemory(0x6619CC, SetTo, 0x00010001);
		SetMemory(0x6619D0, SetTo, 0x00010001);
		SetMemory(0x6619D4, SetTo, 0x00010001);
		SetMemory(0x6619D8, SetTo, 0x00010001);
		SetMemory(0x6619DC, SetTo, 0x00010001);
		SetMemory(0x6619E0, SetTo, 0x00010001);
		SetMemory(0x6619E4, SetTo, 0x00010001);
		SetMemory(0x6619E8, SetTo, 0x00010001);
		SetMemory(0x6619EC, SetTo, 0x00010001);
		SetMemory(0x6619F0, SetTo, 0x00010001);
		SetMemory(0x6619F4, SetTo, 0x00010001);
		SetMemory(0x6619F8, SetTo, 0x00010001);
		SetMemory(0x6619FC, SetTo, 0x00010001);
		SetMemory(0x661A00, SetTo, 0x00010001);
		SetMemory(0x661A04, SetTo, 0x00010001);
		SetMemory(0x661A08, SetTo, 0x00010001);
		SetMemory(0x661A0C, SetTo, 0x00010001);
		SetMemory(0x661A10, SetTo, 0x00010001);
		SetMemory(0x661A14, SetTo, 0x00010001);
		SetMemory(0x661A18, SetTo, 0x00010001);
		SetMemory(0x661A1C, SetTo, 0x00010001);
		SetMemory(0x661A20, SetTo, 0x00010001);
		SetMemory(0x661A24, SetTo, 0x00010001);
		SetMemory(0x661A28, SetTo, 0x00010001);
		SetMemory(0x661A2C, SetTo, 0x00010001);
		SetMemory(0x661A30, SetTo, 0x00010001);
		SetMemory(0x661A34, SetTo, 0x00010001);
		SetMemory(0x661A38, SetTo, 0x00010001);
		SetMemory(0x661A3C, SetTo, 0x00010001);
		SetMemory(0x661A40, SetTo, 0x00010001);
		SetMemory(0x661A44, SetTo, 0x00010001);
		SetMemory(0x661A48, SetTo, 0x00010001);
		SetMemory(0x661A4C, SetTo, 0x00010001);
		SetMemory(0x661A50, SetTo, 0x00010001);
		SetMemory(0x661A54, SetTo, 0x00010001);
		SetMemory(0x661A58, SetTo, 0x00010001);
		SetMemory(0x661A5C, SetTo, 0x00010001);
		SetMemory(0x661A60, SetTo, 0x00010001);
		SetMemory(0x661A64, SetTo, 0x00010001);
		SetMemory(0x661A68, SetTo, 0x00010001);
		SetMemory(0x661A6C, SetTo, 0x00010001);
		SetMemory(0x661A70, SetTo, 0x00010001);
		SetMemory(0x661A74, SetTo, 0x00010001);
		SetMemory(0x661A78, SetTo, 0x00010001);
		SetMemory(0x661A7C, SetTo, 0x00010001);
		SetMemory(0x661A80, SetTo, 0x00010001);
		SetMemory(0x661A84, SetTo, 0x00010001);
		SetMemory(0x661A88, SetTo, 0x00010001);
		SetMemory(0x661A8C, SetTo, 0x00010001);
		SetMemory(0x661A90, SetTo, 0x00010001);
		SetMemory(0x661A94, SetTo, 0x00010001);
		SetMemory(0x661A98, SetTo, 0x00010001);
		SetMemory(0x661A9C, SetTo, 0x00010001);
		SetMemory(0x661AA0, SetTo, 0x00010001);
		SetMemory(0x661AA4, SetTo, 0x00010001);
		SetMemory(0x661AA8, SetTo, 0x00010001);
		SetMemory(0x661AAC, SetTo, 0x00010001);
		SetMemory(0x661AB0, SetTo, 0x00010001);
		SetMemory(0x661AB4, SetTo, 0x00010001);
		SetMemory(0x661AB8, SetTo, 0x00010001);
		Comment("유닛크기변경");
	},
}


Trigger { -- 유닛크기변경
	players = {P1},
	actions = {
		SetMemory(0x661ABC, SetTo, 0x00010001);
		SetMemory(0x661AC0, SetTo, 0x00010001);
		SetMemory(0x661AC4, SetTo, 0x00010001);
		SetMemory(0x661AC8, SetTo, 0x00010001);
		SetMemory(0x661ACC, SetTo, 0x00010001);
		SetMemory(0x661AD0, SetTo, 0x00010001);
		SetMemory(0x661AD4, SetTo, 0x00010001);
		SetMemory(0x661AD8, SetTo, 0x00010001);
		SetMemory(0x661ADC, SetTo, 0x00010001);
		SetMemory(0x661AE0, SetTo, 0x00010001);
		SetMemory(0x661AE4, SetTo, 0x00010001);
		SetMemory(0x661AE8, SetTo, 0x00010001);
		SetMemory(0x661AEC, SetTo, 0x00010001);
		SetMemory(0x661AF8, SetTo, 0x00010001);
		SetMemory(0x661AFC, SetTo, 0x00010001);
		SetMemory(0x661B00, SetTo, 0x00010001);
		SetMemory(0x661B04, SetTo, 0x00010001);
		SetMemory(0x661B08, SetTo, 0x00010001);
		SetMemory(0x661B0C, SetTo, 0x00010001);
		SetMemory(0x661B10, SetTo, 0x00010001);
		SetMemory(0x661B14, SetTo, 0x00010001);
		SetMemory(0x661B18, SetTo, 0x00010001);
		SetMemory(0x661B1C, SetTo, 0x00010001);
		SetMemory(0x661B20, SetTo, 0x00010001);
		SetMemory(0x661B24, SetTo, 0x00010001);
		SetMemory(0x661B28, SetTo, 0x00010001);
		SetMemory(0x661B2C, SetTo, 0x00010001);
		SetMemory(0x661B30, SetTo, 0x00010001);
		SetMemory(0x661B34, SetTo, 0x00010001);
		SetMemory(0x661B38, SetTo, 0x00010001);
		SetMemory(0x661B3C, SetTo, 0x00010001);
		SetMemory(0x661B40, SetTo, 0x00010001);
		SetMemory(0x661B44, SetTo, 0x00010001);
		SetMemory(0x661B48, SetTo, 0x00010001);
		SetMemory(0x661B4C, SetTo, 0x00010001);
		SetMemory(0x661B50, SetTo, 0x00010001);
		SetMemory(0x661B54, SetTo, 0x00010001);
		SetMemory(0x661B58, SetTo, 0x00010001);
		SetMemory(0x661B5C, SetTo, 0x00010001);
		SetMemory(0x661B60, SetTo, 0x00010001);
		SetMemory(0x661B64, SetTo, 0x00010001);
		SetMemory(0x661B68, SetTo, 0x00010001);
		SetMemory(0x661B6C, SetTo, 0x00010001);
		SetMemory(0x661B70, SetTo, 0x00010001);
		SetMemory(0x661B74, SetTo, 0x00010001);
		SetMemory(0x661B78, SetTo, 0x00010001);
		SetMemory(0x661B7C, SetTo, 0x00010001);
		SetMemory(0x661B80, SetTo, 0x00010001);
		SetMemory(0x661B84, SetTo, 0x00010001);
		SetMemory(0x661B88, SetTo, 0x00010001);
		SetMemory(0x661B8C, SetTo, 0x00010001);
		SetMemory(0x661B90, SetTo, 0x00010001);
		SetMemory(0x661B94, SetTo, 0x00010001);
		SetMemory(0x661B98, SetTo, 0x00010001);
		SetMemory(0x661B9C, SetTo, 0x00010001);
		SetMemory(0x661BA0, SetTo, 0x00010001);
		SetMemory(0x661BA4, SetTo, 0x00010001);
		SetMemory(0x661BA8, SetTo, 0x00010001);
		SetMemory(0x661BAC, SetTo, 0x00010001);
		SetMemory(0x661BB0, SetTo, 0x00010001);
		SetMemory(0x661BB4, SetTo, 0x00010001);
		SetMemory(0x661BB8, SetTo, 0x00010001);
		SetMemory(0x661BBC, SetTo, 0x00010001);
		Comment("유닛크기변경");
	},
}


Trigger { -- 유닛크기변경
	players = {P1},
	actions = {
		SetMemory(0x661BC0, SetTo, 0x00010001);
		SetMemory(0x661BC4, SetTo, 0x00010001);
		SetMemory(0x661BC8, SetTo, 0x00010001);
		SetMemory(0x661BCC, SetTo, 0x00010001);
		SetMemory(0x661BD0, SetTo, 0x00010001);
		SetMemory(0x661BD4, SetTo, 0x00010001);
		SetMemory(0x661BD8, SetTo, 0x00010001);
		SetMemory(0x661BDC, SetTo, 0x00010001);
		SetMemory(0x661BE0, SetTo, 0x00010001);
		SetMemory(0x661BE4, SetTo, 0x00010001);
		SetMemory(0x661BE8, SetTo, 0x00010001);
		SetMemory(0x661BEC, SetTo, 0x00010001);
		SetMemory(0x661BF0, SetTo, 0x00010001);
		SetMemory(0x661BF4, SetTo, 0x00010001);
		SetMemory(0x661BF8, SetTo, 0x00010001);
		SetMemory(0x661BFC, SetTo, 0x00010001);
		SetMemory(0x661C00, SetTo, 0x00010001);
		SetMemory(0x661C04, SetTo, 0x00010001);
		SetMemory(0x661C08, SetTo, 0x00010001);
		SetMemory(0x661C0C, SetTo, 0x00010001);
		SetMemory(0x661C10, SetTo, 0x00010001);
		SetMemory(0x661C14, SetTo, 0x00010001);
		SetMemory(0x661C18, SetTo, 0x00010001);
		SetMemory(0x661C1C, SetTo, 0x00010001);
		SetMemory(0x661C20, SetTo, 0x00010001);
		SetMemory(0x661C24, SetTo, 0x00010001);
		SetMemory(0x661C28, SetTo, 0x00010001);
		SetMemory(0x661C2C, SetTo, 0x00010001);
		SetMemory(0x661C30, SetTo, 0x00010001);
		SetMemory(0x661C34, SetTo, 0x00010001);
		SetMemory(0x661C38, SetTo, 0x00010001);
		SetMemory(0x661C3C, SetTo, 0x00010001);
		SetMemory(0x661C40, SetTo, 0x00010001);
		SetMemory(0x661C44, SetTo, 0x00010001);
		SetMemory(0x661C48, SetTo, 0x00010001);
		SetMemory(0x661C4C, SetTo, 0x00010001);
		SetMemory(0x661C50, SetTo, 0x00010001);
		SetMemory(0x661C54, SetTo, 0x00010001);
		SetMemory(0x661C58, SetTo, 0x00010001);
		SetMemory(0x661C5C, SetTo, 0x00010001);
		SetMemory(0x661C60, SetTo, 0x00010001);
		SetMemory(0x661C64, SetTo, 0x00010001);
		SetMemory(0x661C68, SetTo, 0x00010001);
		SetMemory(0x661C6C, SetTo, 0x00010001);
		SetMemory(0x661C70, SetTo, 0x00010001);
		SetMemory(0x661C74, SetTo, 0x00010001);
		SetMemory(0x661C78, SetTo, 0x00010001);
		SetMemory(0x661C7C, SetTo, 0x00010001);
		SetMemory(0x661C80, SetTo, 0x00010001);
		SetMemory(0x661C84, SetTo, 0x00010001);
		SetMemory(0x661C88, SetTo, 0x00010001);
		SetMemory(0x661C8C, SetTo, 0x00010001);
		SetMemory(0x661C90, SetTo, 0x00010001);
		SetMemory(0x661C94, SetTo, 0x00010001);
		SetMemory(0x661C98, SetTo, 0x00010001);
		SetMemory(0x661C9C, SetTo, 0x00010001);
		SetMemory(0x661CA0, SetTo, 0x00010001);
		SetMemory(0x661CA4, SetTo, 0x00010001);
		SetMemory(0x661CA8, SetTo, 0x00010001);
		SetMemory(0x661CAC, SetTo, 0x00010001);
		SetMemory(0x661CB0, SetTo, 0x00010001);
		SetMemory(0x661CB4, SetTo, 0x00010001);
		SetMemory(0x661CB8, SetTo, 0x00010001);
		Comment("유닛크기변경");
	},
}


Trigger { -- 유닛크기변경
	players = {P1},
	actions = {
		SetMemory(0x661CBC, SetTo, 0x00010001);
		SetMemory(0x661CC0, SetTo, 0x00010001);
		SetMemory(0x661CC4, SetTo, 0x00010001);
		SetMemory(0x661CC8, SetTo, 0x00010001);
		SetMemory(0x661CCC, SetTo, 0x00010001);
		SetMemory(0x661CD0, SetTo, 0x00010001);
		SetMemory(0x661CD4, SetTo, 0x00010001);
		SetMemory(0x661CD8, SetTo, 0x00010001);
		SetMemory(0x661CDC, SetTo, 0x00010001);
		SetMemory(0x661CE0, SetTo, 0x00010001);
		SetMemory(0x661CE4, SetTo, 0x00010001);
		SetMemory(0x661CE8, SetTo, 0x00010001);
		SetMemory(0x661CEC, SetTo, 0x00010001);
		SetMemory(0x661CF0, SetTo, 0x00010001);
		SetMemory(0x661CF4, SetTo, 0x00010001);
		SetMemory(0x661CF8, SetTo, 0x00010001);
		SetMemory(0x661CFC, SetTo, 0x00010001);
		SetMemory(0x661D00, SetTo, 0x00010001);
		SetMemory(0x661D04, SetTo, 0x00010001);
		SetMemory(0x661D08, SetTo, 0x00010001);
		SetMemory(0x661D0C, SetTo, 0x00010001);
		SetMemory(0x661D10, SetTo, 0x00010001);
		SetMemory(0x661D14, SetTo, 0x00010001);
		SetMemory(0x661D18, SetTo, 0x00010001);
		SetMemory(0x661D1C, SetTo, 0x00010001);
		SetMemory(0x661D20, SetTo, 0x00010001);
		SetMemory(0x661D24, SetTo, 0x00010001);
		SetMemory(0x661D28, SetTo, 0x00010001);
		SetMemory(0x661D2C, SetTo, 0x00010001);
		SetMemory(0x661D30, SetTo, 0x00010001);
		SetMemory(0x661D34, SetTo, 0x00010001);
		SetMemory(0x661D38, SetTo, 0x00010001);
		SetMemory(0x661D3C, SetTo, 0x00010001);
		SetMemory(0x661D40, SetTo, 0x00010001);
		SetMemory(0x661D44, SetTo, 0x00010001);
		SetMemory(0x661D48, SetTo, 0x00010001);
		SetMemory(0x661D4C, SetTo, 0x00010001);
		SetMemory(0x661D50, SetTo, 0x00010001);
		SetMemory(0x661D54, SetTo, 0x00010001);
		SetMemory(0x661D58, SetTo, 0x00010001);
		SetMemory(0x661D5C, SetTo, 0x00010001);
		SetMemory(0x661D60, SetTo, 0x00010001);
		SetMemory(0x661D64, SetTo, 0x00010001);
		SetMemory(0x661D68, SetTo, 0x00010001);
		SetMemory(0x661D6C, SetTo, 0x00010001);
		SetMemory(0x661D70, SetTo, 0x00010001);
		SetMemory(0x661D74, SetTo, 0x00010001);
		SetMemory(0x661D78, SetTo, 0x00010001);
		SetMemory(0x661D7C, SetTo, 0x00010001);
		SetMemory(0x661D80, SetTo, 0x00010001);
		SetMemory(0x661D84, SetTo, 0x00010001);
		SetMemory(0x661D88, SetTo, 0x00010001);
		SetMemory(0x661D8C, SetTo, 0x00010001);
		SetMemory(0x661D90, SetTo, 0x00010001);
		SetMemory(0x661D94, SetTo, 0x00010001);
		SetMemory(0x661D98, SetTo, 0x00010001);
		SetMemory(0x661D9C, SetTo, 0x00010001);
		SetMemory(0x661DA0, SetTo, 0x00010001);
		SetMemory(0x661DA4, SetTo, 0x00010001);
		SetMemory(0x661DA8, SetTo, 0x00010001);
		SetMemory(0x661DAC, SetTo, 0x00010001);
		SetMemory(0x661DB0, SetTo, 0x00010001);
		SetMemory(0x661DB4, SetTo, 0x00010001);
		Comment("유닛크기변경");
	},
}


Trigger { -- 유닛크기변경
	players = {P1},
	actions = {
		SetMemory(0x661DB8, SetTo, 0x00010001);
		SetMemory(0x661DBC, SetTo, 0x00010001);
		SetMemory(0x661DC0, SetTo, 0x00010001);
		SetMemory(0x661DC4, SetTo, 0x00010001);
		SetMemory(0x661DC8, SetTo, 0x00010001);
		SetMemory(0x661DCC, SetTo, 0x00010001);
		SetMemory(0x661DD0, SetTo, 0x00010001);
		SetMemory(0x661DD4, SetTo, 0x00010001);
		SetMemory(0x661DD8, SetTo, 0x00010001);
		SetMemory(0x661DDC, SetTo, 0x00010001);
		SetMemory(0x661DE0, SetTo, 0x00010001);
		SetMemory(0x661DE4, SetTo, 0x00010001);
		SetMemory(0x661DE8, SetTo, 0x00010001);
		SetMemory(0x661DEC, SetTo, 0x00010001);
		SetMemory(0x661DF0, SetTo, 0x00010001);
		SetMemory(0x661DF4, SetTo, 0x00010001);
		SetMemory(0x661DF8, SetTo, 0x00010001);
		SetMemory(0x661DFC, SetTo, 0x00010001);
		SetMemory(0x661E00, SetTo, 0x00010001);
		SetMemory(0x661E04, SetTo, 0x00010001);
		SetMemory(0x661E08, SetTo, 0x00010001);
		SetMemory(0x661E0C, SetTo, 0x00010001);
		SetMemory(0x661E10, SetTo, 0x00010001);
		SetMemory(0x661E14, SetTo, 0x00010001);
		SetMemory(0x661E18, SetTo, 0x00010001);
		SetMemory(0x661E1C, SetTo, 0x00010001);
		SetMemory(0x661E20, SetTo, 0x00010001);
		SetMemory(0x661E24, SetTo, 0x00010001);
		SetMemory(0x661E28, SetTo, 0x00010001);
		SetMemory(0x661E2C, SetTo, 0x00010001);
		SetMemory(0x661E30, SetTo, 0x00010001);
		SetMemory(0x661E34, SetTo, 0x00010001);
		SetMemory(0x661E38, SetTo, 0x00010001);
		SetMemory(0x661E3C, SetTo, 0x00010001);
		SetMemory(0x661E40, SetTo, 0x00010001);
		SetMemory(0x661E44, SetTo, 0x00010001);
		SetMemory(0x661E48, SetTo, 0x00010001);
		SetMemory(0x661E4C, SetTo, 0x00010001);
		SetMemory(0x661E50, SetTo, 0x00010001);
		SetMemory(0x661E54, SetTo, 0x00010001);
		SetMemory(0x661E58, SetTo, 0x00010001);
		SetMemory(0x661E5C, SetTo, 0x00010001);
		SetMemory(0x661E60, SetTo, 0x00010001);
		SetMemory(0x661E64, SetTo, 0x00010001);
		SetMemory(0x661E68, SetTo, 0x00010001);
		SetMemory(0x661E6C, SetTo, 0x00010001);
		SetMemory(0x661E70, SetTo, 0x00010001);
		SetMemory(0x661E74, SetTo, 0x00010001);
		SetMemory(0x661E78, SetTo, 0x00010001);
		SetMemory(0x661E7C, SetTo, 0x00010001);
		SetMemory(0x661E80, SetTo, 0x00010001);
		SetMemory(0x661E84, SetTo, 0x00010001);
		SetMemory(0x661E88, SetTo, 0x00010001);
		SetMemory(0x661E8C, SetTo, 0x00010001);
		SetMemory(0x661E90, SetTo, 0x00010001);
		SetMemory(0x661E94, SetTo, 0x00010001);
		SetMemory(0x661E98, SetTo, 0x00010001);
		SetMemory(0x661E9C, SetTo, 0x00010001);
		SetMemory(0x661EA0, SetTo, 0x00010001);
		SetMemory(0x661EA4, SetTo, 0x00010001);
		SetMemory(0x661EA8, SetTo, 0x00010001);
		SetMemory(0x661EAC, SetTo, 0x00010001);
		SetMemory(0x661EB0, SetTo, 0x00010001);
		Comment("유닛크기변경");
	},
}


Trigger { -- 유닛크기변경
	players = {P1},
	actions = {
		SetMemory(0x661EB4, SetTo, 0x00010001);
		SetMemory(0x661EB8, SetTo, 0x00010001);
		SetMemory(0x661EBC, SetTo, 0x00010001);
		SetMemory(0x661EC0, SetTo, 0x00010001);
		SetMemory(0x661EC4, SetTo, 0x00010001);
		SetMemory(0x661EC8, SetTo, 0x00010001);
		SetMemory(0x661ECC, SetTo, 0x00010001);
		SetMemory(0x661ED0, SetTo, 0x00010001);
		SetMemory(0x661ED4, SetTo, 0x00010001);
		SetMemory(0x661ED8, SetTo, 0x00010001);
		SetMemory(0x661EDC, SetTo, 0x00010001);
		SetMemory(0x661EE0, SetTo, 0x00010001);
		SetMemory(0x661EE4, SetTo, 0x00010001);
		Comment("유닛크기변경");
	},
}


EUDTurbo(P1)
FP=P1


CJump(AllPlayers,0)
Include_CtrigPlib(360,"Switch 1")
Include_CBPaint()
CJumpEnd(AllPlayers,0)
NoAirCollisionX(P1)
DoActions(P1,{SetMemoryX(0x581D74,SetTo,0x75750000,0xFFFF0000),SetMemory(0x581D78,SetTo,0x75757575),SetMemoryX(0x581DD4,SetTo,0x750000,0xFF0000)})
DoActions(P1,SetMemory(0x58F448,SetTo,0x25)) -- Debug.py 세팅
X, Y, Z, Ret = CreateVars(4,P1)
S1 = CSMakeCircle(64,256,0,65,1)
CIf(P1,Switch("Switch 2",Cleared))


function ToggleFunc(CondArr,Mode,EnterFlag)
	local KeyToggle = CreateCcode()
	local KeyToggle2 = CreateCcode()
	local NotTypingCond = nil
	if EnterFlag ~= nil then
		NotTypingCond = Memory(0x68C144,Exactly,0)
	end
	
	if Mode ~= nil then
		DoActionsX(FP,{SetCD(KeyToggle,0)})
		TriggerX(FP, {NotTypingCond,CondArr[1],CD(KeyToggle2,1)}, {SetCD(KeyToggle2,0),SetCD(KeyToggle,1)}, {preserved})
		TriggerX(FP, {NotTypingCond,CondArr[2]}, {SetCD(KeyToggle2,1)}, {preserved})
	else
		DoActionsX(FP,{SetCD(KeyToggle,0)})
		TriggerX(FP, {NotTypingCond,CondArr[2],CD(KeyToggle2,0)}, {SetCD(KeyToggle2,1),SetCD(KeyToggle,1)}, {preserved})
		TriggerX(FP, {NotTypingCond,CondArr[1]}, {SetCD(KeyToggle2,0)}, {preserved})
	end

	return KeyToggle2,KeyToggle
end
function KeyUpDown(KeyD,KeyU,OffSet)
	local temp,KeyUC = ToggleFunc({KeyPress(KeyU,"Up"),KeyPress(KeyU,"Down")},nil,1)--누를 경우 설명서 출력
	local temp,KeyDC = ToggleFunc({KeyPress(KeyD,"Up"),KeyPress(KeyD,"Down")},nil,1)--누를 경우 설명서 출력
	TriggerX(FP,{CD(KeyUC,1)},{SetMemory(OffSet, Add, 1)},{preserved})
	TriggerX(FP,{CD(KeyDC,1)},{SetMemory(OffSet, Subtract, 1)},{preserved})
end
KeyUpDown("Q","W",0x58F458)
KeyUpDown("A","S",0x58F45C)

DoActionsX(P1,{SetNVar(X,Add,1),SetNVar(Y,Add,-1),SetNVar(Z,Add,1)})
TriggerX(P1,{Memory(0x58F458,Exactly,1)},{SetNVar(X,SetTo,-5),SetNVar(Y,SetTo,15)},{PReserved})
TriggerX(P1,{Memory(0x58F45C,Exactly,1)},{SetNVar(Z,SetTo,0)},{PReserved})
CIfEnd()
CFunc1 = InitCFunc(P1)
Para = CFunc(CFunc1)
-- n*X + (10-n)*Y - 100 = k
CiSub(P1,Ret,_Add(_iMul(Para[1],X),_iMul(Para[2],Y)),100)
CFuncReturn({Ret})
CFuncEnd()
CFunc2 = InitCFunc(P1)
Para = CFunc(CFunc2)
-- I - n = k (음수의 우선순위를 양수보다 뒤로함)
CiSub(P1,Ret,Para[1],Z)
TriggerX(P1,{NVar(Ret,AtLeast,0x80000000)},{SetNVar(Ret,Add,S1[1])},{Preserved})
CFuncReturn({Ret})
CFuncEnd()
function func1()
CIfX(P1,{Memory(0x58F450,Exactly,0),Switch("Switch 2",Cleared)}
,SetSwitch("Switch 2",Set))
CB_Sort(CFunc1,_Read(0x58F454),1,2)
CElseIfX({Memory(0x58F450,AtLeast,1),Switch("Switch 2",Cleared)}
,SetSwitch("Switch 2",Set))
CB_SortI(CFunc2,_Read(0x58F454),1,2)
CIfXEnd()
end
CBPlot({S1,CS_InputVoid(S1[1])},nil,P1,0,"Location 13",nil,1,32
,{2,0,0,0,3,0},nil,"func1",P1,nil,nil,{RemoveUnit(0,P1),SetSwitch("Switch 2",Clear)})
CMov(P1,0x58F460,X) CMov(P1,0x58F464,Y) CMov(P1,0x58F468,Z)

EndCtrig()
-- 에러 체크 함수 선언 위치 --
--↑Tep에 그대로 붙여넣기----------------------------------------
ErrorCheck()