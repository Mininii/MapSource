
LD2XOption = 1
if LD2XOption == 1 then
	Mapdir="C:\\euddraft0.9.2.0\\CBTest"
	__StringArray = {}
	__TRIGChkptr = io.open(Mapdir.."__TRIG.chk", "wb")
	Loader2XFName = "Loader.lua"
else
	Loader2XFName = "Loader2X.lua"
end



EXTLUA = "dir \""..Curdir.."\\MapSource\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= Loader2XFName then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\Library\\"..dir))
		InitEXTLua()
     end
end
SnowFlake =
{140,{1.2540383223269e-015,-20.48},{17.736200269506,-10.24},{17.736200269506,10.24},{1.2540383223269e-015,20.48},{-17.736200269506,10.24},{-17.736200269506,-10.24},{2.5080766446538e-015,-40.96},{35.47240053901,-20.48},{35.47240053901,20.48},{2.5080766446538e-015,40.96},{-35.47240053901,20.48},{-35.47240053901,-20.48},{3.7621149669806e-015,-61.44},{53.208600808516,-30.72},{53.208600808516,30.72},{3.7621149669806e-015,61.44},{-53.208600808516,30.72},{-53.208600808516,-30.72},{5.0161532893076e-015,-81.92},{70.944801078022,-40.96},{70.944801078022,40.96},{5.0161532893076e-015,81.92},{-70.944801078022,40.96},{-70.944801078022,-40.96},{6.2701916116344e-015,-102.4},{88.681001347528,-51.2},{88.681001347528,51.2},{6.2701916116344e-015,102.4},{-88.681001347528,51.2},{-88.681001347528,-51.2},{7.5242299339616e-015,-122.88},{106.41720161703,-61.44},{106.41720161703,61.44},{7.5242299339616e-015,122.88},{-106.41720161703,61.44},{-106.41720161703,-61.44},{8.778268256288e-015,-143.36},{124.15340188654,-71.68},{124.15340188654,71.68},{8.778268256288e-015,143.36},{-124.15340188654,71.68},{-124.15340188654,-71.68},{1.0032306578615e-014,-163.84},{141.88960215605,-81.92},{141.88960215605,81.92},{1.0032306578615e-014,163.84},{-141.88960215605,81.92},{-141.88960215605,-81.92},{1.1286344900942e-014,-184.32},{159.62580242555,-92.16},{159.62580242555,92.16},{1.1286344900942e-014,184.32},{-159.62580242555,92.16},{-159.62580242555,-92.16},{31.038350471634,-53.76},{46.557525707451,-44.8},{62.076700943269,-17.92},{62.076700943269,0},{62.076700943269,17.92},{46.557525707451,44.8},{31.038350471634,53.76},{15.519175235817,62.72},{4.3891341281442e-015,71.68},{-15.519175235817,62.72},{-31.038350471634,53.76},{-46.557525707451,44.8},{-62.076700943269,17.92},{-62.076700943269,7.6022033111802e-015},{-62.076700943269,-17.92},{-46.557525707451,-44.8},{-31.038350471634,-53.76},{-15.519175235817,-62.72},{-1.3167402384433e-014,-71.68},{15.519175235817,-62.72},{46.557525707451,-80.64},{62.076700943269,-71.68},{77.595876179085,-62.72},{93.115051414904,-35.84},{93.115051414904,-17.92},{93.115051414904,0},{93.115051414904,17.92},{93.115051414904,35.84},{77.595876179085,62.72},{62.076700943269,71.68},{46.557525707451,80.64},{31.038350471634,89.6},{15.519175235817,98.56},{-15.519175235817,98.56},{-31.038350471634,89.6},{-46.557525707451,80.64},{-62.076700943269,71.68},{-77.595876179085,62.72},{-93.115051414904,35.84},{-93.115051414904,17.92},{-93.115051414904,1.140330496677e-014},{-93.115051414904,-17.92},{-93.115051414904,-35.84},{-77.595876179085,-62.72},{-62.076700943269,-71.68},{-46.557525707451,-80.64},{-31.038350471634,-89.6},{-15.519175235817,-98.56},{15.519175235817,-98.56},{31.038350471634,-89.6},{15.519175235817,-142.08},{-15.519175235817,-142.08},{-115.28530175178,-84.48},{-130.8044769876,-57.6},{-130.8044769876,57.6},{-115.28530175178,84.48},{-15.519175235817,142.08},{15.519175235817,142.08},{115.28530175178,84.48},{130.8044769876,57.6},{130.8044769876,-57.6},{115.28530175178,-84.48},{31.038350471634,-151.04},{-31.038350471634,-151.04},{-115.28530175178,-102.4},{-146.32365222342,-48.64},{-146.32365222342,48.64},{-115.28530175178,102.4},{-31.038350471634,151.04},{31.038350471634,151.04},{115.28530175178,102.4},{146.32365222342,48.64},{146.32365222342,-48.64},{115.28530175178,-102.4},{46.557525707451,-160},{-46.557525707451,-160},{-115.28530175178,-120.32},{-161.84282745924,-39.68},{-161.84282745924,39.68},{-115.28530175178,120.32},{-46.557525707451,160},{46.557525707451,160},{115.28530175178,120.32},{161.84282745924,39.68},{161.84282745924,-39.68},{115.28530175178,-120.32}}

PatchStack = {}
function UnitSizePatch(UnitID,Value,Table)
	table.insert(Table,SetMemory(0x6617C8 + (UnitID*8),SetTo,(Value)+(Value*65536)))
	table.insert(Table,SetMemory(0x6617CC + (UnitID*8),SetTo,(Value)+(Value*65536)))
end
for i = 0, 227 do
	UnitSizePatch(i,1,PatchStack)
end

DoActions2(P1,PatchStack,1)--유닛크기변경

SetForces({P1},{P2},{},{},{P1,P2}) 
SetFixedPlayer(P2)
StartCtrig(1,nil,nil,1,"C:\\Temp")
CJump(AllPlayers,0)
Include_CtrigPlib(360,"Switch 1")
Include_CBPaint()
CJumpEnd(AllPlayers,0)
NoAirCollisionX(P1)

--↓ 이곳에 예제를 붙여넣기 (예제에 Include_CtrigPlib가 존재하는경우 삭제 또는 교체) ----------------------

DoActions(P1,SetMemory(0x58F448,SetTo,0x25)) -- Debug.py 세팅
S1 = CS_FillXY({1,1},256,256,32,32)
DoActions(P1,{RemoveUnit(0,P1)})
X, Y = CreateVars(2,P1)
DoActionsX(P1,{SetNVar(X,Add,1),SetNVar(Y,Add,-2)})
TriggerX(P1,Memory(0x58F45C,Exactly,1),{SetNVar(X,SetTo,0),SetNVar(Y,SetTo,0)},{Preserved})
function func1()
CIfX(P1,Memory(0x58F454,Exactly,0))
CB_MirrorX(X,_Read(0x58F458),1,2)
CElseX()
CB_MirrorY(Y,_Read(0x58F458),1,2)
CIfXEnd()
end
CBPlot({S1,CS_InputVoid(S1[1]*2)},nil,P1,0,"Location 13",nil,1,32
,{2,0,0,0,S1[1]*2,0},nil,"func1",P1,Memory(0x58F450,Exactly,0),nil,1)
TriggerX(P1,{Memory(0x58F450,Exactly,1)}
,{SetMemory(0x58F458,SetTo,1),SetMemory(0x58F45C,SetTo,1),SetMemory(0x58F460,SetTo,1)
,SetMemory(0x58F464,SetTo,1),SetMemory(0x58F468,SetTo,1),SetMemory(0x58F46C,SetTo,1),
SetMemory(0x58F470,SetTo,1),SetMemory(0x58F474,SetTo,1),SetMemory(0x58F478,SetTo,0),
SetMemory(0x58F47C,SetTo,0)})
TriggerX(P1,{KeyPress("Q", "Down")},{SetMemory(0x58F458, Add, 1)},{preserved})
TriggerX(P1,{KeyPress("W", "Down")},{SetMemory(0x58F460, Add, 1)},{preserved})
TriggerX(P1,{KeyPress("E", "Down")},{SetMemory(0x58F468, Add, 1)},{preserved})
TriggerX(P1,{KeyPress("R", "Down")},{SetMemory(0x58F470, Add, 1)},{preserved})
TriggerX(P1,{KeyPress("T", "Down")},{SetMemory(0x58F478, Add, 1)},{preserved})
TriggerX(P1,{KeyPress("A", "Down")},{SetMemory(0x58F45C, Add, 1)},{preserved})
TriggerX(P1,{KeyPress("S", "Down")},{SetMemory(0x58F464, Add, 1)},{preserved})
TriggerX(P1,{KeyPress("D", "Down")},{SetMemory(0x58F46C, Add, 1)},{preserved})
TriggerX(P1,{KeyPress("F", "Down")},{SetMemory(0x58F474, Add, 1)},{preserved})
TriggerX(P1,{KeyPress("G", "Down")},{SetMemory(0x58F47C, Add, 1)},{preserved})


TriggerX(P1,{KeyPress("Y", "Down")},{SetMemory(0x58F458, Add, -1)},{preserved})
TriggerX(P1,{KeyPress("U", "Down")},{SetMemory(0x58F460, Add, -1)},{preserved})
TriggerX(P1,{KeyPress("I", "Down")},{SetMemory(0x58F468, Add, -1)},{preserved})
TriggerX(P1,{KeyPress("O", "Down")},{SetMemory(0x58F470, Add, -1)},{preserved})
TriggerX(P1,{KeyPress("P", "Down")},{SetMemory(0x58F478, Add, -1)},{preserved})
TriggerX(P1,{KeyPress("H", "Down")},{SetMemory(0x58F45C, Add, -1)},{preserved})
TriggerX(P1,{KeyPress("J", "Down")},{SetMemory(0x58F464, Add, -1)},{preserved})
TriggerX(P1,{KeyPress("K", "Down")},{SetMemory(0x58F46C, Add, -1)},{preserved})
TriggerX(P1,{KeyPress("L", "Down")},{SetMemory(0x58F474, Add, -1)},{preserved})
TriggerX(P1,{KeyPress("SEMICOLON", "Down")},{SetMemory(0x58F47C, Add, -1)},{preserved})

CIf(P1,KeyPress("1", "Down"),{SetMemory(0x58F450,SetTo,1),SetMemory(0x58F454,SetTo,1)})
CMov(P1,0x58F458,_iSub(_Mod(_Rand(),800),400))
CMov(P1,0x58F460,_iSub(_Mod(_Rand(),800),400))
CMov(P1,0x58F468,_iSub(_Mod(_Rand(),800),400))
CMov(P1,0x58F470,_iSub(_Mod(_Rand(),800),400))
CMov(P1,0x58F478,_iSub(_Mod(_Rand(),800),400))
CMov(P1,0x58F45C,_iSub(_Mod(_Rand(),800),400))
CMov(P1,0x58F464,_iSub(_Mod(_Rand(),800),400))
CMov(P1,0x58F46C,_iSub(_Mod(_Rand(),800),400))
CMov(P1,0x58F474,_iSub(_Mod(_Rand(),800),400))

CIfEnd()


function func2()
CIfX(P1,Memory(0x58F454,Exactly,0))
CB_Distortion({_ReadF(0x58F458),_ReadF(0x58F45C)},
{_ReadF(0x58F460),_ReadF(0x58F464)},
{_ReadF(0x58F468),_ReadF(0x58F46C)},
{_ReadF(0x58F470),_ReadF(0x58F474)},
{_ReadF(0x58F478),_ReadF(0x58F47C)},1,2)
CElseX()
CB_Distortion2({_ReadF(0x58F458),_ReadF(0x58F45C)}, -- 좌하
{_ReadF(0x58F460),_ReadF(0x58F464)}, -- 좌상
{_ReadF(0x58F468),_ReadF(0x58F46C)}, -- 우하
{_ReadF(0x58F470),_ReadF(0x58F474)}, -- 우상
{_ReadF(0x58F478),_ReadF(0x58F47C)},1,2) -- 중심점
CIfXEnd()
end
CBPlot({S1,CS_InputVoid(S1[1])},nil,P1,0,"Location 13",nil,1,32
,{2,0,0,0,S1[1],0},nil,"func2",P1,Memory(0x58F450,Exactly,1),nil,1)


-- 에러 체크 함수 선언 위치 --
--↑Tep에 그대로 붙여넣기----------------------------------------
EndCtrig()
ErrorCheck()
EUDTurbo(P1)

if LD2XOption == 1 then
__PopStringArray()
io.close(__TRIGchkptr)
end