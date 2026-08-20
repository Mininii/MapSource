
--[[
	TStruct : "구조체 배열(오브젝트 풀)" 시스템
	=================================================
	CtrigAsm(트리거 어셈블러) 위에서 동작하는 일종의 미니 오브젝트 풀/스레드 풀 라이브러리.
	실제 사용 예(MSF_UE_RE/Sans.lua, CallTriggers.lua)를 보면 보스전 탄막(총알) 오브젝트를
	구현하는 데 쓰였다:
		BlasterBullet = TStruct_init(FP, 32, 20, HumanPlayers)  -- 슬롯 32개, 필드 20개
		TS_CreateArr(BlasterBullet)                              -- 슬롯 32개짜리 처리 트리거 생성
		TS_SendX(조건, BlasterBullet, {x,y,destX,destY,flag,angle}) -- 빈 슬롯에 새 총알 데이터 push(스폰)
		TStr_Func(BlasterBullet) ... TStr_EndFunc()               -- 슬롯 1개가 매 틱 실행하는 "본체" 로직

	즉 "Number개의 인스턴스 × Line개의 필드"를 가진 구조체 배열이며,
		- 필드 값은 CreateVarArr로 만든 EUD 변수(VarArr)를 "작업 레지스터"로 사용하고,
		- 인스턴스별 영구 데이터는 StartIndex(고유 Label) 기반 주소에서 시작하는
		  실제 게임 메모리 블록(인스턴스당 0x970바이트, 필드당 0x20바이트 간격)에 저장한다.
		- 필드 값이 전부 0이면 "빈 슬롯"으로 취급되어 TS_Send/TS_SendX가 재사용한다.

	용어 정리
		- "Send"  : 빈 슬롯을 찾아 새 데이터를 기록 = 스폰/enqueue
		- "Func"  : Number개의 슬롯이 공유하는 처리 로직(생성자 겸 업데이트 함수) 정의
		- "Suspend" : 처리 로직 종료 조건을 만족하면 필드를 0으로 리셋 = 슬롯 반납/despawn

	성능(렉) 관련 검토 결과 - Number(풀 크기)를 정할 때 반드시 참고할 것
	=================================================
	이 프레임워크(CtrigAsm)는 "CJump(AllPlayers,0) ~ CJumpEnd" 하나의 큰 루프 안에서 맵의 모든
	트리거를 매 프레임 순서대로 훑으며, 각 트리거는 자신이 지금 실행할 차례인지(Next 포인터가
	자신을 가리키는지)를 조건으로 검사한다. 즉 "정의된 트리거 개수"가 곧 "매 프레임 조건 검사 횟수"이며,
	이는 실제로 몇 개가 활성 상태인지와 무관하게 고정 비용으로 든다. 이 사실이 아래 두 지점에서
	TStruct의 성능에 직접 영향을 준다.

	1) TS_CreateArr가 만드는 Number개의 워커 트리거 (TStruct.lua 내 TS_CreateArr 참고)
	   - 슬롯이 하나도 안 쓰이고 있어도 Number개의 CTrigger({CVar("X","X",AtLeast,1)}, ...)가
	     매 프레임 전부 조건 검사를 받는다. 즉 Number를 필요 이상으로 크게 잡으면(예: 화면에는
	     총알이 몇 개 없는데 풀은 200개) 그 차이만큼 순수 오버헤드가 매 프레임 누적된다.
	   - 실사용 예(MSF_UE_RE)에서 BoneBullet=200, BlasterBullet=32로, 이미 이 둘만으로 232개의
	     상시 평가 트리거가 생긴다. TStruct를 여러 개(총알 종류별로) 만들수록 그대로 합산된다.
	   - 개선 방향: Number는 "실제 최대 동시 사용량"에 최대한 맞춰서 잡는 것이 유일한 완화책이다
	     (구조 자체를 바꾸지 않는 한 사용하지 않는 여유분도 매 프레임 비용을 낸다).

	2) TS_Send/TS_SendX 내부의 "빈 슬롯 탐색" 루프 (TStruct_init의 TStr_SendJump 부분)
	   - [해결 시도: Next-Fit 커서] 원래는 항상 슬롯 0번부터 훑는 선형 탐색이라, 하필 "총알이 이미
	     많이 떠 있어서 렉이 가장 걱정되는 시점(=풀이 꽉 참)"에 탐색 비용도 가장 커지는 문제가 있었다.
	     지금은 마지막으로 성공한 위치(TStr_NextTry)를 커서로 기억해두고 그 다음 슬롯부터 훑도록
	     바꿔서, 스폰↔반납이 섞여 일어나는 일반적인 패턴에서는 평균 탐색 거리가 크게 줄어든다.
	   - 처음엔 "빈 슬롯 인덱스를 스택으로 관리하는 free-list(O(1))"를 검토했으나, free-list의
	     pop은 "동적으로 계산된 주소에 저장된 값을 읽어 다시 주소 계산에 쓰는" 진짜 역참조가 필요해
	     f_Read/CRead 같은 무거운 CP 스왑 기법(36129줄 f_Read 참고: CALL + RecoverCp)을 써야
	     한다 — 오히려 지금의 선형 탐색보다 느려질 수 있어 채택하지 않았다.
	   - 다만 Next-Fit도 최악의 경우(운 나쁘게 빈 슬롯이 커서에서 먼 경우)엔 여전히 O(Number)이다.
	     보장된 O(log Number)를 원한다면 "구간별로 빈 슬롯 개수를 미리 집계해두는 카운터(세그먼트
	     트리류)" 방식이 있지만, 스폰/반납마다 경로상의 카운터를 전부 갱신해야 해서 구현 복잡도가
	     상당히 올라간다 — 지금은 과설계로 판단해 보류.
]]

--[[
	TStruct_init(PlayerID, Number, Line, HumanPlayersArr)
	구조체(오브젝트 풀) 하나를 정의하고 초기화한다.

	Params
		PlayerID        : 이 구조체가 소속될 플레이어(EUD 변수/트리거를 이 플레이어 기준으로 할당)
		Number          : 인스턴스(슬롯) 개수 - 예: 최대 동시 존재 가능한 총알 수
		Line            : 인스턴스 1개당 필드 개수
		HumanPlayersArr : (선택) 슬롯이 가득 찼을 때 에러 메시지/효과음을 보여줄 사람 플레이어 목록

	Return: {PlayerID, VarArr, Number, SetCallIndex, StartIndex, InputH, TempH, SendVarArr, Send_CallIndex}
	이 테이블("TStructData")을 TS_CreateArr / TStr_Func / TS_Send 등 나머지 API에 계속 넘겨서 사용한다.
]]
-- Line 상한의 실제 근거는 메모리 블록 크기(0x970/0x20)가 아니라, TS_CreateArr가 만드는
-- 슬롯 트리거(아래 CTrigger 1개)의 액션 개수 제한이다. 그 트리거는
--   필드 리셋(TStr_InputCVar, Line개) + 자기참조 기록(SetCtrigX×1) + Call(SetNext×2)
--   + RecoverNext(SetCtrigX×2, SetCtrig1X×1) = Line + 6개
-- 의 고정 액션을 갖는데, 네이티브 트리거는 액션을 64개까지만 담을 수 있어(TStruct_MAX_TRIGGER_ACTIONS)
-- Line이 너무 크면 이 트리거 자체가 컴파일되지 않는다. 원래 값(Line>=56 에러, 즉 최대 55)을
-- 그대로 유지하되 근거만 명확히 남겨둔다.
TStruct_MAX_TRIGGER_ACTIONS = 64 -- 네이티브 트리거 1개에 담을 수 있는 최대 액션 수
TStruct_MAX_LINE = 55

function TStruct_init(PlayerID,Number,Line,HumanPlayersArr)
	if Line == nil or Line < 1 or Line > TStruct_MAX_LINE then PushErrorMsg("TStruct Line Overflow") end
	if Number == nil or Number < 1 then PushErrorMsg("TStruct Number InputData Error") end
	local TStr_SendErrT = "\x07『 \x08ERROR \x04: Trigger Struct 목록이 가득 차 데이터를 입력하지 못했습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
	local StartIndex = FuncAlloc -- FuncAlloc에서 라벨 받아옴
	FuncAlloc = FuncAlloc + 1
	local VarArr = CreateVarArr(Line,PlayerID) -- 처리 중 "현재 인스턴스"의 필드 값을 담는 작업용 EUD 변수 Line개
	local InputH = CreateVar(PlayerID) -- 이 구조체 데이터 영역의 "베이스 주소" 역할을 하는 핸들
	local TempH = CreateVar(PlayerID) -- 현재 실행 중인 슬롯(인스턴스)을 식별하는 임시 핸들
	-- 맵 시작 시 1회, InputH 내부의 트리거 구조체 필드에 StartIndex를 자기참조로 새겨 넣음
	-- => 이 구조체 전용 메모리 영역의 시작 주소를 InputH에 고정시키는 트릭
	table.insert(CtrigInitArr[PlayerID+1],SetCtrigX(PlayerID,InputH[2],0x15C,0,SetTo,PlayerID,StartIndex,0x15C,1,0))
	local SetCallIndex = CreateCallIndex() -- Number개의 슬롯이 공유해서 호출할 "본체"(TStr_Func~TStr_EndFunc) 서브루틴 라벨 예약

	local SendVarArr = CreateVarArr(Line,PlayerID) -- TS_Send/TS_SendX가 넘겨받은 값을 임시로 담는 EUD 변수 Line개

	local TStr_LineV = CreateVar(PlayerID)     -- 빈 슬롯을 찾기 위한 반복문의 "현재 슬롯 오프셋" 카운터
	local TStr_LineTemp = CreateVar(PlayerID)  -- TStr_LineV + InputH(베이스) = 실제로 검사할 메모리 주소
	local TStr_NextTry = CreateVar(PlayerID)   -- [Next-Fit] 마지막으로 성공한 지점의 "다음 슬롯" 오프셋(커서). 다음 탐색은 0이 아니라 여기서부터 시작
	local TStr_Checked = CreateVar(PlayerID)   -- [Next-Fit] 이번 탐색에서 지금까지 검사한 슬롯 개수(Number개를 다 돌았는지 판정용)
	local TStr_SendJump = def_sIndex()         -- 아래 반복문(loop)에 쓸 점프 라벨 예약
	local Send_CallIndex = CreateCallIndex()   -- "빈 슬롯 탐색 후 기록" 루틴(Send 처리부)의 서브루틴 라벨
	SetCall2(PlayerID,Send_CallIndex) -- Send_CallIndex 서브루틴 본체 시작 (CALL로 진입 가능한 구간)

	-- [성능/Next-Fit] 매번 슬롯 0번부터 훑지 않고, 지난번 성공 지점(TStr_NextTry) 다음부터 훑고
	-- 끝까지 가면 0번으로 wrap한다. f_Read/CRead 같은 "동적 주소 역참조"는 전혀 쓰지 않고(비용 문제로
	-- 배제, 파일 상단 "성능 검토" 및 대화 로그 참고) CMov/CAdd만으로 구현했다.
	-- 최악의 경우(운 나쁘게 빈 슬롯이 커서에서 먼 경우)엔 여전히 O(Number)이지만, 스폰↔반납이 섞여서
	-- 일어나는 일반적인 패턴에서는 평균 탐색 거리가 크게 줄어든다. Number개를 다 돌아도 못 찾으면
	-- 기존과 동일하게 "가득 참" 처리한다.
	CMov(PlayerID,TStr_LineV,TStr_NextTry) -- 0이 아니라 커서 위치부터 시작
	CMov(PlayerID,TStr_Checked,0) -- 검사 개수 초기화
	CJumpEnd(PlayerID,TStr_SendJump) -- 아래 CJump(...)가 되돌아올 루프 시작 지점

	CAdd(PlayerID,TStr_LineTemp,TStr_LineV,InputH) -- 검사할 실제 주소 = 베이스(InputH) + 현재 오프셋
	NIfX(PlayerID,{TMemory(TStr_LineTemp,AtMost,0)}) -- 해당 슬롯의 첫 필드가 0 이하이면 "비어있음"으로 간주
	local TStr_SendTAct = {}
	for i = 0, #SendVarArr-1 do
		-- 빈 슬롯을 찾았으므로 SendVarArr에 담긴 값들을 필드 간격(0x20바이트 = 8dword)만큼 떨어뜨려 기록
		table.insert(TStr_SendTAct,TSetMemory(_Add(TStr_LineTemp,i*(0x20/4)),SetTo,SendVarArr[i+1]))

	end
	CDoActions(PlayerID,TStr_SendTAct)
	-- [Next-Fit] 다음 번 탐색은 이 슬롯 "다음" 자리부터 시작하도록 커서 갱신(끝이면 0으로 wrap)
	CAdd(PlayerID,TStr_LineV,0x970/4)
	NIfX(PlayerID,{CVar(PlayerID,TStr_LineV[2],AtLeast,(0x970/4)*Number)})
	CMov(PlayerID,TStr_LineV,0)
	NIfXEnd()
	CMov(PlayerID,TStr_NextTry,TStr_LineV)

	NElseIfX({CVar(PlayerID,TStr_Checked[2],AtMost,Number-2)}) -- 아직 Number개를 다 검사하지 않았으면
	CAdd(PlayerID,TStr_Checked,1) -- 검사 개수 +1
	CAdd(PlayerID,TStr_LineV,0x970/4) -- 다음 슬롯(0x970바이트 뒤)으로 오프셋 이동
	NIfX(PlayerID,{CVar(PlayerID,TStr_LineV[2],AtLeast,(0x970/4)*Number)}) -- 배열 끝을 넘어가면
	CMov(PlayerID,TStr_LineV,0) -- 0번으로 wrap
	NIfXEnd()
	CJump(PlayerID,TStr_SendJump) -- 루프 처음으로 되돌아가서 다시 검사
	NElseX() -- Number개 슬롯을 전부 돌았는데도 빈 슬롯을 못 찾은 경우 = 풀이 가득 참
	if HumanPlayersArr~=nil then
		if type(HumanPlayersArr) ~= "table" then PushErrorMsg("HumanPlayersArr InputData Error") end
		-- 사람 플레이어들에게 "가득 참" 에러 메시지 + 경고음 2회 출력
		DoActions(PlayerID,{CopyCpAction({DisplayTextX(TStr_SendErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayersArr,PlayerID)})
	end
	NIfXEnd()
	SetCallEnd2() -- Send_CallIndex 서브루틴 끝 (CALL한 곳으로 복귀)

	--[1] = PlayerID
	--[2] = VarArr
	--[3] = Number
	--[4] = SetCallIndex
	--[5] = StartIndex
	--[6] = InputH
	--[7] = TempH
	--[8] = SendVarArr
	--[9] = Send_CallIndex
	return {PlayerID,VarArr,Number,SetCallIndex,StartIndex,InputH,TempH,SendVarArr,Send_CallIndex}
end


--[[
	TS_CreateArr(TStructData)
	TStruct_init에서 정의한 구조체의 실제 "일꾼(worker)" 트리거를 Number개 생성한다.
	각 트리거는 외부에서 CallTrigger류로 호출되면
		1) 작업용 필드 변수(VarArr)를 0으로 리셋하고
		2) 자기 자신의 슬롯 위치를 TempH에 기록한 뒤
		3) SetCallIndex(=TStr_Func/TStr_EndFunc로 정의될 본체)로 점프해서 처리 로직을 실행한다.
	반드시 TStruct_init 이후, 그리고 실제 사용 전에 (구조체마다) 한 번만 호출해야 한다.

	[성능] 여기서 생성하는 Number개의 트리거는 슬롯 사용 여부와 무관하게 매 프레임 조건 검사를
	받는다(파일 상단 "성능 검토" 참고). Number를 실제 필요량보다 크게 잡으면 그 차이가 그대로
	상시 오버헤드가 되므로, 풀 크기는 여유를 최소화해서 설정하는 것이 좋다.
]]
function TS_CreateArr(TStructData)
	local TStr_PlayerID = TStructData[1]
	local TStr_VarArr = TStructData[2]
	local TStr_Number = TStructData[3]
	local TStr_StartIndex
	local TStr_SetCallIndex = TStructData[4]
	local TStr_InputCVar = {}
	local TStr_TempH = TStructData[7]
	for i = 1, #TStr_VarArr do
		table.insert(TStr_InputCVar,SetCVar(TStr_PlayerID,TStr_VarArr[i][2],SetTo,0))
	end
	for i = 0, TStr_Number-1 do
		if i == 0 then TStr_StartIndex = TStructData[5] else TStr_StartIndex=nil end -- 첫 슬롯만 TStruct_init에서 예약해둔 StartIndex 라벨을 사용
		CTrigger(TStr_PlayerID, {CVar("X","X",AtLeast,1)}, {
			TStr_InputCVar, -- 필드 초기화(0으로 리셋)
			SetCtrigX("X",TStr_TempH[2],0x15C,0,SetTo,"X","X",0x15C,1,0), -- 이 슬롯 자신의 위치를 TempH에 자기참조로 기록
			SetNext("X",TStr_SetCallIndex,0),SetNext(TStr_SetCallIndex+1,"X",1), -- Call TStrFunc  (본체 서브루틴으로 CALL)
			SetCtrigX("X",TStr_SetCallIndex+1,0x158,0,SetTo,"X","X",0x4,1,0), -- RecoverNext (복귀 주소 저장, CALL 관례)
			SetCtrigX("X",TStr_SetCallIndex+1,0x15C,0,SetTo,"X","X",0,0,1), -- RecoverNext
			SetCtrig1X("X",TStr_SetCallIndex+1,0x164,0,SetTo,0x0,0x2) -- RecoverNext (preserve 플래그 복원)
		}, 1, TStr_StartIndex)
	end
end

--[[
	TStr_WriteData(TStructData)
	현재 작업 중인 인스턴스(VarArr)의 필드 값들을, 그 인스턴스의 영구 메모리 슬롯
	(TempH가 가리키는 주소, 필드당 0x20바이트 간격)에 기록한다.
	TStr_EndFunc()가 자동으로 호출하므로 보통 직접 부를 필요는 없다.
]]
function TStr_WriteData(TStructData)
	local TStr_PlayerID = TStructData[1]
	local TStr_VarArr = TStructData[2]
	local TStr_Number = TStructData[3]
	local TStr_SetCallIndex = TStructData[4]
	local TStr_TempH = TStructData[7]
	local TStr_InputTAct = {}
	for i = 1, #TStr_VarArr do
		table.insert(TStr_InputTAct,TSetMemory(Vi(TStr_TempH[2],(i-1)*(0x20/4)),SetTo,TStr_VarArr[i]))
	end
	CDoActions(TStr_PlayerID,TStr_InputTAct)
end

--[[
	TStr_Func(TStructData) / TStr_EndFunc()
	Number개의 슬롯이 공유하는 처리 로직("본체")을 정의하는 구간을 여는/닫는 함수 쌍.
	사용법: TStr_Func(구조체데이터) ... (TSLine 등으로 필드를 읽고 쓰는 로직) ... TStr_EndFunc()

	TStr_Func는 전역 변수 TS_Data/TS_Player/TS_VarArr/TS_CallIndex에 현재 컨텍스트를 저장하고
	SetCall2로 SetCallIndex 서브루틴 구간을 연다. TSLine/SetTSLine 등은 이 전역값을 참조해서 동작하므로
	TStr_Func ~ TStr_EndFunc 블록 안에서만 사용할 수 있다 (중첩 호출 불가).

	TStr_EndFunc는 처리 결과(VarArr)를 TStr_WriteData로 영구 메모리에 반영한 뒤 서브루틴을 닫고
	전역 컨텍스트를 정리한다.
]]
function TStr_Func(TStructData)
	TS_Data = TStructData
	TS_Player = TStructData[1]
	TS_VarArr = TStructData[2]
	TS_CallIndex = TStructData[4]
	SetCall2(TS_Player,TS_CallIndex)
end
function TStr_EndFunc()
	TStr_WriteData(TS_Data)
	SetCallEnd2()
	TS_Data = nil
	TS_Player = nil
	TS_CallIndex = nil
	TS_VarArr = nil
end

--[[
	TS_Suspend(Condition, Flags)
	TStr_Func ~ TStr_EndFunc 본체 안에서, Condition이 참이 되면 현재 인스턴스의 필드를
	전부 0으로 리셋한다(= 슬롯 반납/despawn). 필드가 0이면 TS_Send/TS_SendX의 "빈 슬롯 탐색"이
	이 슬롯을 다시 재사용 가능하다고 판단한다.
]]
function TS_Suspend(Condition,Flags)
	if TS_Data==nil then PushErrorMsg("Not Found TStr Parameter") end
	local TSAct = {}
	for i = 1, #TS_VarArr do
		table.insert(TSAct,SetCVar(TS_Player, TS_VarArr[i][2], SetTo, 0))
	end
	if Flags == nil then Flags = {preserved} end -- 호출부가 직접 넘긴 Flags를 더 이상 버리지 않는다
	CTrigger(TS_Player,Condition,TSAct,Flags)

end

-- 아래 4개 함수는 TStr_Func~TStr_EndFunc 본체 안에서 "현재 인스턴스의 Line번째 필드"를
-- 읽고/쓰는 조건(Condition)·액션(Action)을 만들어주는 헬퍼들이다.
-- TSLine/TTSLine   : 조건(Condition) - 필드 값이 Type/Value/Mask 조건을 만족하는지 검사
-- SetTSLine/TSetTSLine : 액션(Action)  - 필드 값을 Type(SetTo/Add/Sub 등)으로 갱신
-- 앞에 T가 붙은 버전은 CtrigAsm의 "T계열"(1틱 지연/트리거 값 기반) 조건·액션을 사용한다.
function TSLine(Line,Type,Value,Mask)
	if TS_Data==nil then PushErrorMsg("Not Found TStr Parameter") end
	return CVar(TS_Player, TS_VarArr[Line][2], Type, Value, Mask)
end
function TTSLine(Line,Type,Value,Mask)
	if TS_Data==nil then PushErrorMsg("Not Found TStr Parameter") end
	return TCVar(TS_Player, TS_VarArr[Line][2], Type, Value, Mask)
end
function SetTSLine(Line,Type,Value,Mask)
	if TS_Data==nil then PushErrorMsg("Not Found TStr Parameter") end
	return SetCVar(TS_Player, TS_VarArr[Line][2], Type, Value, Mask)
end
function TSetTSLine(Line,Type,Value,Mask)
	if TS_Data==nil then PushErrorMsg("Not Found TStr Parameter") end
	return TSetCVar(TS_Player, TS_VarArr[Line][2], Type, Value, Mask)
end

--[[
	TS_Send(Condition, TStructData, SendProperty, PreserveFlag)
	Condition이 참일 때, 빈 슬롯을 찾아 SendProperty에 담긴 값들을 새 인스턴스로 기록한다(스폰).
	SendProperty에 없는 필드는 0으로 채워진다. 상수 값만 넘길 때 사용
	("상수만 입력하고 싶을때" - 원 주석). 내부적으로 TStruct_init에서 만든 Send_CallIndex
	서브루틴(빈 슬롯 탐색 로직)을 CallTriggerX로 호출한다.
]]
function TS_Send(Condition,TStructData,SendProperty,PreserveFlag)--상수만 입력하고 싶을때
	if type(SendProperty) ~= "table" then PushErrorMsg("SendProperty InputData Error") end
	local TStr_PlayerID = TStructData[1]
	local TStr_SendVarArr = TStructData[8]
	local TStr_SendCallIndex = TStructData[9]
	local Line = #TStr_SendVarArr
	local TStr_SendArr = {}
	for i = 1, Line do
		if SendProperty[i]~= nil then
			table.insert(TStr_SendArr,SetCVar(TStr_PlayerID,TStr_SendVarArr[i][2],SetTo,SendProperty[i]))
		else
			table.insert(TStr_SendArr,SetCVar(TStr_PlayerID,TStr_SendVarArr[i][2],SetTo,0))
		end
	end
	CallTriggerX(TStr_PlayerID,TStr_SendCallIndex,Condition,TStr_SendArr,PreserveFlag)

end
--[[
	TS_SendX(Condition, TStructData, SendProperty, PreserveFlag)
	TS_Send와 동일하지만 SendProperty에 상수 대신 변수(V)를 넣을 수 있도록 T계열(TSetCVar)로
	기록한다. 원 주석대로 "중간연산자, 다른 데이터형 등"을 섞어 넣으면 버그가 날 수 있으니 주의.
]]
function TS_SendX(Condition,TStructData,SendProperty,PreserveFlag) -- 변수 V 를 입력하고 싶을때(중간연산자, 다른 데이터형 등 입력시 버그남)
	if type(SendProperty) ~= "table" then PushErrorMsg("SendProperty InputData Error") end
	local TStr_PlayerID = TStructData[1]
	local TStr_SendVarArr = TStructData[8]
	local TStr_SendCallIndex = TStructData[9]
	local Line = #TStr_SendVarArr
	if PreserveFlag == nil then
		CIf(TStr_PlayerID,Condition)
	else
		CIfOnce(TStr_PlayerID,Condition)
	end
	local TStr_SendArr = {}
	for i = 1, Line do
		if SendProperty[i]~= nil then
			table.insert(TStr_SendArr,TSetCVar(TStr_PlayerID,TStr_SendVarArr[i][2],SetTo,SendProperty[i]))
		else
			table.insert(TStr_SendArr,TSetCVar(TStr_PlayerID,TStr_SendVarArr[i][2],SetTo,0))
		end
	end
	CDoActions(TStr_PlayerID,TStr_SendArr)
	CallTrigger(TStr_PlayerID,TStr_SendCallIndex)
	CIfEnd()

end
