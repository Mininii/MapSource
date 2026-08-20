
		

	-- ============================================================================
-- DisplayPrint.lua
--
-- 스타크래프트 CtrigAsm(트리거 어셈블리) 기반 "문자열 출력" 라이브러리.
-- 트리거 액션 DisplayText(...)는 컴파일 시점에 고정된 문자열만 넣을 수 있는데,
-- 이 라이브러리는 런타임에 계산되는 값(변수, 8/32/64비트 정수, 플레이어 이름 등)을
-- 10진수/16진수 문자열로 변환하는 서브루틴들을 트리거로 직접 만들어 붙여서
-- "printf" 처럼 동적인 텍스트를 화면에 뿌릴 수 있게 해준다.
--
-- 핵심 개념
--  - dp            : 이 라이브러리 전역 상태를 담는 네임스페이스 테이블(DP_Start_init에서 생성)
--  - FP            : Fixed Player. 조건 평가에 사용되는 고정 플레이어(트리거 소유자)
--  - CallXxx / SetCall2 / CallTrigger : "함수처럼" 재사용되는 트리거 블록을 만들고 호출하는
--    CtrigAsm 매크로. 실제로는 EUD/트리거 점프(CJump)로 서브루틴 흉내를 낸다
--  - Dev / BSize   : 출력 버퍼 안에서 현재 쓰기 위치(offset)를 추적하는 카운터
--  - dp.StrT       : DisplayText에 넘길 "틀(template)" 문자열. 런타임에 채워질 구간은
--    자리표시자 문자 0x0D로 채워두고, 실제 값은 트리거 액션(SetMemory 등)으로
--    그 메모리 위치에 나중에 덮어쓴다
--  - arg 배열의 각 원소는 타입에 따라 다르게 처리된다:
--      string                → 그대로 리터럴 텍스트로 삽입
--      number                → 상수 문자 코드(string.char 대체용, TBwrite 호출)
--      table, k[4]=="V"      → 32비트 변수(Var) → 10진수/16진수 변환(IToDec/IToDecX/ItoHex)
--      table, k[4]=="W"      → 64비트 변수(War) → lIToDec으로 10진수 변환
--      table, k[4]=="VA"/"WA"→ 변수 배열(VArr/WArr) 버전
--      table, k[1]=="PVA"    → PName()으로 만들어진 태그. 플레이어 이름 삽입(VtoName)
--      function / {function,...} → 커스텀 서브루틴 직접 호출(다른 Print 계열 함수 재귀 삽입 등)
-- ============================================================================

	function DisplayPrintTbl(TBLID,arg,ResetTimer,UTF8OptionOff)
		-- ID(TBLID)로 식별되는 "고정 메모리 테이블"에 arg 내용을 인코딩해 써 넣는다.
		-- DisplayPrint와 달리 즉시 DisplayText로 출력하지 않고, 이후 다른 곳에서
		-- 재사용할 수 있는 포인터(TBLPtr)에 내용을 채워두는 용도(예: 다른 트리거가
		-- 참조하는 공용 텍스트 버퍼). 같은 TBLID로 다시 호출하면 이미 할당된
		-- 포인터를 재사용한다(dp.TBLKeyArr 캐시).
		
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
					CAdd(FP,dp.VtoNamePtr,TBLPtr,Dev)
					CallTrigger(FP, dp.Call_VtoLPName)
				elseif type(k[2])=="number" then
					CAdd(FP,dp.VtoNamePtr,TBLPtr,Dev)
					CallTrigger(FP, dp.Call_VtoName,{SetV(dp.VtoNameV,k[2])})
				elseif k[2][4] == "V" then
					CAdd(FP,dp.VtoNamePtr,TBLPtr,Dev)
					CMov(FP,dp.VtoNameV,k[2])
					CallTrigger(FP, dp.Call_VtoName)
				end
				Dev=Dev+(4*5)
			elseif type(k)=="table" and k[4]=="W" then
					f_LMov(FP, dp.publiclItoDecW, k, nil, nil, 1)
					CallTrigger(FP,dp.Call_lIToDec,{SetV(dp.DevV,Dev)}) 
					Dev=Dev+(5*4)
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

		
		if UTF8OptionOff == nil then
		CallTrigger(FP,dp.Call_TBwrite,{SetV(dp.TBwInputChar,0xE2),SetV(dp.DevV,Dev)}) 
		CallTrigger(FP,dp.Call_TBwrite,{SetV(dp.TBwInputChar,0x80),SetV(dp.DevV,Dev+1)}) 
		CallTrigger(FP,dp.Call_TBwrite,{SetV(dp.TBwInputChar,0x89),SetV(dp.DevV,Dev+2)}) 
		end
		

		
	if ResetTimer~=nil then
		CIfEnd()

	end
		table.insert(dp.TBOLutputTxt,{"TBL - "..TBLID.." : "..string.rep("<0D>",Dev+10).."\n"})


	end
	-- ============================================================================
	-- [DisplayPrint] 라이브러리의 메인 "printf" 함수.
	-- TargetPlayers 에게 arg(문자열/숫자/변수 혼합 배열)를 조합한 텍스트를
	-- DisplayText(단일/고정 대상) 또는 DisplayTextX(RotatePlayer, 여러 대상 순회)로 출력한다.
	--
	-- 파라미터
	--  TargetPlayers : 숫자(플레이어 번호), CurrentPlayer/"CP"(현재 트리거 소유자),
	--                   변수(V 태그 테이블), 또는 그 외(RotatePlayer로 순회 대상 목록)
	--  arg           : 위 파일 헤더에서 설명한 타입별 혼합 배열
	--  FixTextPreset : 1/3이면 출력 "전"에, 2/3이면 출력 "후"에 FixText(자막 밀림 방지 등
	--                   텍스트 표시 관련 보정 트릭)를 대상 플레이어에게 적용
	--  SoundRepeat   : 출력과 동시에 재생할 WAV 목록
	--  ResetTimer    : nil이 아니면 CIf로 감싸서, 조건이 참일 때만(타이머 만료 시 등)
	--                   실제로 출력하도록 함(스팸 방지용 쿨다운)
	-- ============================================================================
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
			f_SaveCp() -- CurrentPlayer(트리거 실행 주체) 대상이면 CP를 별도 변수에 백업(아래 244번째 줄 근처 BackupCp로 복원됨)
		end--
		BSize = 0 -- dp.StrT(자리표시자 템플릿 문자열)의 누적 길이 카운터


		dp.Alloc = dp.Alloc+1 -- 이번 출력 호출의 고유 번호(디버그/추적용, 실제 주소 계산엔 안 쓰임)
		RetV = CreateVar(FP) -- 이번 호출에서 실제 출력 버퍼로 쓰일 "포인터" 변수(런타임에 init_StrX가 실주소를 채움)
		Dev = 0 -- 버퍼 내 현재 쓰기 오프셋(바이트 단위)

		if ResetTimer~=nil then
			-- ResetTimer가 있으면 "쿨다운"이 끝났을 때만 출력하도록 CIf로 감싼다.
			-- table(V 변수) → 그 변수 값이 0일 때만 출력
			-- number       → 내부 카운트다운 코드(Ccode)를 만들어 매 호출마다 1씩 깎고, 0이 되면 통과 후 ResetTimer로 리셋
			if type(ResetTimer)=="table" and ResetTimer[4]== "V" then
				CIf(FP,{CV(ResetTimer,0)})

			elseif type(ResetTimer)=="number" then
				ResetTimerCode = CreateCcode()
				DoActionsX(FP,{SubCD(ResetTimerCode, 1)})
				CIf(FP,{CD(ResetTimerCode,0)},{SetCD(ResetTimerCode,ResetTimer)})

			end
		end
		CMov(FP,dp.publicItoCusPtr,RetV) -- 공용 "현재 쓰기 대상 포인터"를 이번 버퍼(RetV)로 세팅
		dp.StrT = {} -- DisplayText에 넘길 틀 문자열 조각들(리터럴 텍스트 + 0x0D 자리표시자)
		dp.StrXIndex=dp.StrXIndex+1
		-- arg 배열을 순회하며 각 항목 타입에 따라 분기 처리(파일 상단 헤더 설명 참고).
		-- 각 분기는 (1) 실제 값을 버퍼에 써넣는 트리거 액션/서브루틴 호출을 발생시키고
		-- (2) dp.StrT에는 그 값이 차지할 길이만큼 0x0D 자리표시자를 넣고
		-- (3) Dev/BSize를 그만큼 전진시킨다.
		for j,k in pairs(arg) do
			if type(k) == "function" then -- 커스텀 함수: 직접 호출해서 부수효과(다른 Print 재귀 호출 등)로 버퍼를 채움. BSize 증가분으로 길이 역산
				local PrevBSize = BSize
				k()
				local NextBSize = BSize
				table.insert(dp.StrT,string.rep("\x0D",NextBSize-PrevBSize))
				
			elseif type(k)=="table" and type(k[1]) == "function" then
				local lfunc = k[1]
				local PrevBSize = BSize
				table.remove(k,1)
				lfunc(table.unpack(k))
				local NextBSize = BSize
				table.insert(dp.StrT,string.rep("\x0D",NextBSize-PrevBSize))
			elseif type(k) == "string" then -- 리터럴 문자열: 그대로 삽입, 실행 시점에 바뀌지 않으므로 트리거 액션 불필요
				--local CT = CreateCText(FP,k)
				table.insert(dp.StrT,k)
				BSize=BSize+#k
				Dev=Dev+#k
			elseif type(k)=="table" and k[1] == "PVA" then -- PNameVArr 우회전용 : PName()이 만든 태그, 플레이어 이름을 삽입
				BSize = BSize+(4*5) -- 이름은 VArr(5) 슬롯 = 20바이트 고정폭 사용
				if k[2] == "LocalPlayerID" then -- 로컬(관전 중인 실제) 플레이어 이름
					CAdd(FP,dp.VtoNamePtr,RetV,Dev)
					CallTrigger(FP, dp.Call_VtoLPName)
				elseif type(k[2])=="number" then -- 상수 플레이어 번호의 이름
					CAdd(FP,dp.VtoNamePtr,RetV,Dev)
					CallTrigger(FP, dp.Call_VtoName,{SetV(dp.VtoNameV,k[2])})
				elseif k[2][4] == "V" then -- 변수로 지정된 플레이어 번호의 이름
					CAdd(FP,dp.VtoNamePtr,RetV,Dev)
					CMov(FP,dp.VtoNameV,k[2])
					CallTrigger(FP, dp.Call_VtoName)
				end
				Dev=Dev+(4*5)
				table.insert(dp.StrT,string.rep("\x0D",4*5))
			elseif type(k)=="table" and k[4]=="V" then -- 32비트 변수(Var) → 문자열 변환
				if k["fwc"] == true then -- fwc = 고정폭(fixed width) 10진수, VA[0~11] = 12자리 버퍼(Call_IToDecX)
					BSize=BSize+(4*12)
					CMov(FP,dp.publicItoDecV,k)
					CallTrigger(FP,dp.Call_IToDecX,{SetV(dp.DevV,Dev)})
					Dev=Dev+(4*12)
					table.insert(dp.StrT,string.rep("\x0D",4*12))
				elseif k["hex"] == true then -- 16진수 변환(Call_ItoHex), VA[0~2] = 3워드(=12바이트) 버퍼
					BSize=BSize+(3*4)
					CMov(FP,dp.publicItoDecV,k)
					CallTrigger(FP,dp.Call_ItoHex,{SetV(dp.DevV,Dev)})
					Dev=Dev+(3*4)
					table.insert(dp.StrT,string.rep("\x0D",3*4))
				else -- 기본 10진수 변환(Call_IToDec), VA[0~3] = 4워드(=16바이트) 버퍼
					BSize=BSize+(4*4)
					CMov(FP,dp.publicItoDecV,k)
					CallTrigger(FP,dp.Call_IToDec,{SetV(dp.DevV,Dev)})
					Dev=Dev+(4*4)
					table.insert(dp.StrT,string.rep("\x0D",4*4))
				end
			elseif type(k)=="table" and k[4]=="VA" then -- 변수 배열(VArr) 원소 하나를 10진수로: V와 동일한 처리, 버퍼 크기도 동일
				BSize=BSize+(4*4)
				CMov(FP,dp.publicItoDecV,k)
				CallTrigger(FP,dp.Call_IToDec,{SetV(dp.DevV,Dev)})
				Dev=Dev+(4*4)
				table.insert(dp.StrT,string.rep("\x0D",4*4))
			elseif type(k)=="table" and k[4]=="W" then -- 64비트 변수(War) → 10진수 변환(Call_lIToDec), 20자리 고정폭 버퍼
				BSize=BSize+(4*5)
				f_LMov(FP, dp.publiclItoDecW, k, nil, nil, 1)
				CallTrigger(FP,dp.Call_lIToDec,{SetV(dp.DevV,Dev)})
				Dev=Dev+(4*5)
				table.insert(dp.StrT,string.rep("\x0D",4*5))
			elseif type(k)=="table" and k[4]=="WA" then -- 64비트 변수 배열(WArr) 원소: W와 동일 처리
				BSize=BSize+(4*5)
				f_LMov(FP, dp.publiclItoDecW, k, nil, nil, 1)
				CallTrigger(FP,dp.Call_lIToDec,{SetV(dp.DevV,Dev)})
				Dev=Dev+(4*5)
				table.insert(dp.StrT,string.rep("\x0D",4*5))
			elseif type(k)=="table" and k[1][4]=="V" then -- VarArr일 경우 : {V,V,V,...} 형태, 원소 하나당 문자 1개씩 직접 기록(TBwrite)
				BSize = BSize+#k
				for o,p in pairs(k) do
					CMov(FP,dp.TBwInputChar,p)
					CallTrigger(FP,dp.Call_TBwrite,{SetV(dp.DevV,Dev)})

					Dev=Dev+(1)
					table.insert(dp.StrT,string.rep("\x0D",1))
				end
			elseif type(k)=="number" then -- 상수index V 입력, string.char 구현용. 맨앞 0xFF영역만 사용
				-- 리터럴 문자 코드 하나(고정폭 UTF8 밖 특수문자 등)를 1바이트로 직접 기록
				BSize=BSize+1
				CMov(FP,dp.TBwInputChar,V(k))
				CallTrigger(FP,dp.Call_TBwrite,{SetV(dp.DevV,Dev)})
				Dev=Dev+(1)
				table.insert(dp.StrT,string.rep("\x0D",1))
			else
				PushErrorMsg("Print_Inputdata_Error") -- 위 타입 어디에도 해당하지 않는 인자: 사용 실수를 컴파일 타임에 알림
			end
		end
		
		if ResetTimer~=nil then
			CIfEnd()

		end
		-- 조각들을 이어붙여 최종 템플릿 문자열 완성. 끝에 0x0D 4개를 덧붙이는 건
		-- DisplayText 내부 파싱/정렬 여유분(패딩)으로 보인다.
		dp.StrT = table.concat(dp.StrT).."\x0D\x0D\x0D\x0D"
		table.insert(dp.StrXKeyArr,{RetV,dp.StrT}) -- init_StrX가 나중에 RetV(가상 포인터)를 실제 메모리 주소로 확정할 수 있도록 등록
		if TargetPlayers==CurrentPlayer or TargetPlayers=="CP" then
			-- 트리거 소유자(CurrentPlayer) 자신에게 출력: 0x6509B0(표시 대상 슬롯)을 되돌릴 CP 값으로 세팅 후 DisplayText
			local Act = {TSetMemory(0x6509B0,SetTo,BackupCp),DisplayText(dp.StrT,4)}
			if SoundRepeat ~= nil then
				for j,k in pairs(SoundRepeat) do
					table.insert(Act, PlayWAV(k))
				end

			end
			CDoActions(FP,Act,nil,nil)
		elseif type(TargetPlayers)=="table" and TargetPlayers[4]=="V" then
			-- 대상이 변수로 지정된 단일 플레이어: 그 변수 값을 표시 대상 슬롯에 세팅 후 DisplayText
			local Act = {TSetMemory(0x6509B0,SetTo,TargetPlayers),DisplayText(dp.StrT,4)}
			if SoundRepeat ~= nil then
				for j,k in pairs(SoundRepeat) do
					table.insert(Act, PlayWAV(k))
				end

			end
			CDoActions(FP,Act,nil,nil)
		else
			-- 그 외(숫자 하나, 또는 여러 플레이어 목록): RotatePlayer로 각 대상을 순회하며 DisplayTextX 실행
			local RotAct = {DisplayTextX(dp.StrT,4)}
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

		if FixTextPreset == 3 or FixTextPreset == 2 then -- 출력 "후" FixText 보정(위쪽 FixText(FP,1)과 대칭)
			
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



	-- 컴파일 타임에 값이 확정된 리터럴 문자열을 스타크래프트의 트리거 텍스트 메모리
	-- (0x640B60, "TRIG" 텍스트 라인 배열. 라인당 218바이트 폭)에 직접 SetMemory로
	-- 굽는(bake) 헬퍼. DisplayPrint처럼 런타임 변환 서브루틴을 거치지 않고,
	-- 컴파일 시점에 4바이트(DWORD) 단위로 SetMemory 액션을 나열해서 즉시 값을 박아넣는다.
	-- DisplayPrintEr(즉시/저수준 출력 함수)에서 사용됨.
	--   line   : 텍스트 라인 인덱스 (기준 주소 = 0x640B60 + line*218)
	--   offset : 그 라인 내 바이트 오프셋
	--   string : 써넣을 리터럴 문자열
	function print_utf8_2(line, offset, string)
		local ret = {}
		local dst = 0x640B60 + line * 218 + offset

		if type(string) == "string" then
			local str = string
			local n = 1
			-- dst가 4바이트 정렬이 안 되어 있으면, SetMemory가 4바이트 단위로만 쓸 수 있으므로
			-- 정렬 경계 앞부분을 0x0D(자리표시자/무해한 채움 문자)로 패딩해서 맞춘다.
			if dst % 4 >= 1 then
				for i = 1, dst % 4 do str = '\x0d'..str end
			end
			local t = StrToMem(str)
			while n <= #t do
				-- 4바이트씩 끊어 하나의 SetMemory(SetTo, DWORD) 액션으로 변환
				ret[#ret+1] = SetMemory(dst - dst % 4 +n-1, SetTo, _dw(t, n))
				n = n + 4
			end
		elseif type(string) == "number" then
			PushErrorMsg("print_utf8_InputError") -- 이 함수는 리터럴 문자열 전용. 숫자를 넘기면 사용 실수
		end
		return ret
	end



	-- ============================================================================
	-- [DisplayPrintEr] "즉시/에러용" 저수준 출력 함수.
	-- DisplayPrint와 달리 동적 포인터(RetV)나 DisplayText 액션을 쓰지 않고,
	-- 트리거 텍스트 메모리의 고정된 12번 라인(0x640B60 + 12*218)을 직접 덮어써서
	-- 화면에 표시한다(스타크래프트가 그 메모리 영역의 텍스트를 그대로 그려주는 특성 이용).
	-- 이름 그대로 디버그/에러 메시지처럼 예외적으로 즉시 찍어야 하는 텍스트에 적합.
	--
	-- 동작 순서
	--  1) arg를 훑으며 각 값의 "타입/오프셋"만 먼저 큐(ItoDecKey/lItoDecKey/ItoNameKey/VCharKey)에
	--     적재하고, 리터럴 문자열 부분은 print_utf8_2로 즉시 컴파일 타임 굽기, 나머지는
	--     0x0D로 자리만 비워둠(RetAct)
	--  2) TargetPlayer 조건에 맞을 때만(CIf) 실제 실행되도록 감싼 뒤,
	--     먼저 라인 전체를 0x0D로 초기화 → 리터럴/자리표시자 액션(RetAct) 실행
	--  3) 큐에 쌓아둔 변환 호출들(IToDec/IToDecX/lIToDec/VtoName/TBwrite)을 순서대로 실행해
	--     해당 오프셋 위치에 실제 값을 덮어씀
	-- ============================================================================
	function DisplayPrintEr(TargetPlayer,arg)
		Dev = 0
		local RetAct = {} -- 컴파일 타임에 확정 가능한 액션들(리터럴 텍스트 굽기, 자리표시자 초기화)
		local ItoDecKey = {} -- {변수, 오프셋, fwc여부} 목록 : 나중에 IToDec/IToDecX 호출용
		local lItoDecKey = {} -- 64비트(War) 버전
		local ItoNameKey = {} -- 플레이어 이름 삽입 목록
		local VCharKey = {} -- 상수 문자 코드 삽입 목록
		DPGeneralFuncKey = {} -- 커스텀 함수 후처리 목록(전역, 하단 for문에서 소비)





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
				
			elseif type(k)=="table" and k[4]=="VA" then
				table.insert(RetAct,print_utf8_2(12, Dev, string.rep("\x0D", 16)))
				table.insert(ItoDecKey,{k,Dev,false})
				Dev=Dev+(4*4)
			elseif type(k)=="table" and k[4]=="WA" then
				table.insert(RetAct,print_utf8_2(12, Dev, string.rep("\x0D", 20)))
				table.insert(lItoDecKey,{k,Dev,false})
				Dev=Dev+(4*5)
			elseif type(k)=="table" and k[4]=="W" then
				table.insert(RetAct,print_utf8_2(12, Dev, string.rep("\x0D", 20)))
				table.insert(lItoDecKey,{k,Dev,false})
				Dev=Dev+(4*5)
			elseif type(k)=="number" then -- 상수index V 입력, string.char 구현용. 맨앞 0xFF영역만 사용
				table.insert(RetAct,print_utf8_2(12, Dev, string.rep("\x0D", 1)))
				table.insert(VCharKey,{k,Dev})
				Dev=Dev+(1)
			elseif type(k)=="table" and type(k[1]) == "function" then
				local lfunc = k[1]
				table.remove(k,1)
				local PrevDev = Dev
				lfunc(table.unpack(k))
				--error(Dev)
				local NextDev = Dev
				table.insert(RetAct,print_utf8_2(12, Dev, string.rep("\x0D", NextDev-PrevDev)))
				
			else
				PushErrorMsg("Print_Inputdata_Error")
			end
		end
		-- Print_13X(아래 정의)를 대상 플레이어(들)에 대해 호출해서 표시를 트리거하는 부분.
		-- OP_Hold가 설정돼 있으면(맵마다 다른 "죽음 카운트 훅") 부수적으로 SetDeaths도 실행.
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
		DoActions2(FP, {print_utf8_2(12, 0, string.rep("\x0D", 210))}) -- 12번 라인 전체(210바이트)를 먼저 0x0D로 초기화(이전 출력 잔재 제거)
		DoActions2(FP, RetAct) -- 리터럴 문자열/자리표시자 굽기 실행
		CMov(FP,dp.publicItoCusPtr,0x640B60 + (12 * 218)) -- 공용 쓰기 포인터를 이 고정 라인 주소로 세팅(아래 TBwrite 호출들이 참조)
		for j,p in pairs(ItoDecKey) do -- 큐에 쌓아둔 32비트 정수→문자열 변환들을 실제로 실행하며 각자의 오프셋에 덮어씀
			local k = p[1]
			local bool = p[3]
			CMov(FP,dp.publicItoDecV,k)
			if bool == true then
				CallTrigger(FP,dp.Call_IToDecX,{SetV(dp.DevV,p[2])})
			else
				CallTrigger(FP,dp.Call_IToDec,{SetV(dp.DevV,p[2])})
			end
		end
		for j,p in pairs(lItoDecKey) do
			local k = p[1]
			f_LMov(FP, dp.publiclItoDecW, k, nil, nil, 1)
			CallTrigger(FP,dp.Call_lIToDec,{SetV(dp.DevV,p[2])})
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
			CallTrigger(FP,dp.Call_TBwrite,{SetV(dp.publicItoCusPtr,0x640B60 + (12 * 218)),SetV(dp.DevV,p[2])}) 
		end
		for j,p in pairs(DPGeneralFuncKey) do
			p[1](p[2])
		end

		
		CIfEnd()

		DPGeneralFuncKey = nil
		Dev = nil
	end

	-- DisplayPrintEr가 Call_Print13X 슬롯을 통해 대상 플레이어별로 호출하는 헬퍼.
	-- 0x628438(EUD 스크래치 메모리)에 큐잉된 대기 값이 있으면(AtLeast 1) 그것을 읽어
	-- 유닛 생성(TCreateUnit)을 트리거하는 방식으로 "즉시 표시" 갱신을 유발한다.
	-- 라이브러리 전역 카운터 FuncAlloc으로 매 정의마다 별도의 EUD 슬롯을 할당해 충돌을 피함.
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


	-- 맵 컴파일 마지막 단계에서 한 번 호출되는 "주소 확정" 패스.
	-- DisplayPrint/DisplaySTRX 호출 중에는 RetV가 아직 실제 메모리 주소를 갖지 않는
	-- 가상의 변수였는데, 여기서 f_GetStrXptr/f_GetTblptr을 통해 실제 할당된 주소를
	-- 각 RetV/TBLPtr에 채워 넣는다(전방 참조 문제를 2-패스로 해결).
	function init_StrX()
		for k, v in pairs(dp.StrXKeyArr) do
			f_GetStrXptr(FP,v[1],v[2])
		end



		for k, v in pairs(dp.TBLKeyArr) do
			f_GetTblptr(FP,v[1],v[2])
		end

	end
	-- ============================================================================
	-- [init_Setting] DP_Start_init에서 호출되는 초기화 본체.
	-- DisplayPrint 계열 함수들이 CallTrigger(FP, dp.Call_Xxx, ...)로 호출하는
	-- 공용 "서브루틴"들(IToDec/IToDecX/ItoHex/VtoName/VtoLPName/TBwrite/lIToDec/Print13X)을
	-- 실제로 정의(SetCall2 ~ SetCallEnd2)하고, 각 플레이어 이름 캐시를 초기화하며,
	-- 초기화 트리거 체인을 맵의 트리거 실행 순서에 끼워 넣는다(CJump/SetNext).
	--
	-- 안에 정의된 dp.ItoDec는 "정수를 10진수 문자열로 바꾸는" 알고리즘 자체를
	-- CtrigAsm 저수준 명령(SetCtrig1X 등, 트리거의 조건/액션 바이트를 직접 조작하는
	-- "트리거를 코드로 취급하는" 기법)으로 구현한 것으로, 이 파일에서 가장 복잡한 부분이다.
	-- ============================================================================
	function init_Setting()
		
	-- 32비트 부호있는 정수를 10진수 ASCII 문자열(최대 10자리)로 변환하는 CtrigAsm 서브루틴.
	-- SetCtrig1X(...)는 "일반 변수"가 아니라 트리거 그 자체의 조건/액션 바이트를 오프셋(0x148/0x158/
	-- 0x15C/0x160 등, 트리거 구조체 내부 필드)째 직접 덮어써서 값을 저장하는 저수준 CtrigAsm 기법이다
	-- (Ctrig = "트리거를 변수 저장 공간으로 재사용"하는 트릭). 즉, 이 함수 자체는 계산을 하지 않고
	-- "값을 계산하는 트리거들을 컴파일 타임에 조립"해서 맵에 심어두는 코드다.
	--
	-- 알고리즘 개요(이진→십진 변환, 자릿수별 반복 감산 방식):
	--   1) 부호(Sign) 처리 후 입력값을 CRet[1] 슬롯(임시 누산기, 0x15C 필드)에 복사
	--   2) 출력 버퍼(OutputVA)를 ZeroMode(0/공백/0x0D)로 채워 초기 템플릿 구성
	--      ("XXXX 90SC 5678 1234" 처럼 4바이트씩 4워드 = 최대 10자리 + 부호/색상 슬롯)
	--   3) 남은 값이 몇 자리 수인지에 따라 ZeroMode를 각 자리에 적용(선행 0 표시 여부 결정)
	--   4) 10^9 자리부터 1의 자리까지, 각 자리마다 "그 자리에 해당하는 2의 거듭제곱×10^n" 값을
	--      큰 것부터 작은 것까지 조건 검사(AtLeast)해서 누산기에서 빼고(Subtract) 그만큼을
	--      해당 자리의 ASCII 문자 코드에 더하는(Add) 방식으로 각 10진 자릿수를 구해낸다
	--      (자릿수당 이진탐색형 감산이므로 자리마다 최대 4번 비교/감산이면 충분: 4bit BCD 추출과 유사)
	--   5) DigitMax/DigitMin으로 표시할 자릿수 범위를 잘라내고(마스크 SetTo로 해당 필드를 0x0D로 지움)
	--      최종적으로 X(액션 목록)를 한 번에 실행
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

		-- 아래부터 10^9 자리~1의 자리까지, 자리마다 2^i * 10^n 값들을 큰 것부터 시험해
		-- 누산기(CRet[1])에서 빼고 그만큼을 해당 자리 문자 필드에 더하는 반복.
		-- for 루프 그룹이 총 9개(1e9~1) 있으며 각 그룹의 승수(2^0~2^i)와 대상 필드/바이트
		-- 위치만 다르고 구조는 동일하다.
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

		-- DigitMax: 표시할 최상위 자리수 제한. 그보다 상위 자리 필드를 SetTo 0x0D0D0D0D로
		-- 마스킹(비트마스크로 해당 바이트만 지움)해서 안 보이게 만든다.
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

		-- DigitMin: 표시할 최하위 자리수 제한(반대 방향 마스킹, 1의 자리부터 잘라냄).
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
		DoActionsX(PlayerID,X) -- 자릿수 마스킹 액션들을 한 번에 실행하며 dp.ItoDec 정의 종료
	end


		-- (A) 초기화 전용 점프 블록: 플레이어 0~6에 대해 이름을 미리 변수 배열로
		-- 구워두고(ItoName), _0DPatchforVArr로 0x00 바이트를 0x0D로 패치(문자열 조기 종료 방지).
		-- LocalPlayerID(관전/로컬 시점 플레이어)는 별도 슬롯(dp.LPNameVArr)에 한 번 더 저장.
		CJump(FP, dp.CustominitJump)
		for i = 0, 6 do
			ItoName(FP,i,VArr(dp.PNameVArrArr[i+1],0),ColorCode[i+1])
			_0DPatchforVArr(FP,dp.PNameVArrArr[i+1],4)

			CIf(FP,{LocalPlayerID(i)})--로컬
			ItoName(FP,i,VArr(dp.LPNameVArr,0),ColorCode[i+1])
			_0DPatchforVArr(FP,dp.LPNameVArr,4)
			CIfEnd()
		end

		init_StrX() -- 이 시점까지 쌓인 DisplayPrint/DisplayPrintTbl 호출들의 가상 포인터를 실주소로 확정

		DoActionsX(FP,{SetNext(dp.initTrigIndex, dp.initTrigIndex,1),SetNext("X", dp.initTrigIndex,1)},1,dp.lastTrigIndex)--RecoverNext

		-- (B) 공용 서브루틴 정의 블록. SetCall2(slot)~SetCallEnd2()로 감싼 코드는
		-- CallTrigger(FP, dp.Call_Xxx, ...)가 호출될 때 실행되는 "함수 본문"에 해당한다.
		-- 각 서브루틴은 계산 결과를 임시 VArr에 만든 뒤 f_Movcpy로 공용 쓰기 포인터
		-- (dp.publicItoCusPtr + dp.DevV, 즉 DisplayPrint가 세팅해둔 현재 출력 버퍼 위치)에
		-- 그대로 복사해 넣는 동일한 패턴을 따른다.
		local SCJump = def_sIndex()
		CJump(FP,SCJump)
		SetCall2(FP, dp.Call_IToDec) -- 32비트 정수 → 10진수(16바이트, ZeroMode=2 즉 0x0D 채움, 부호 없음)
		dp.ItoDec(FP,dp.publicItoDecV,VArr(dp.publicItoDecVArr,0),2,nil,1)
		f_Movcpy(FP,_Add(dp.publicItoCusPtr,dp.DevV),VArr(dp.publicItoDecVArr,0),4*4)
		SetCallEnd2()

		SetCall2(FP, dp.Call_IToDecX) -- 32비트 정수 → 10진수 고정폭(fwc) 버전, 12워드(48바이트) 출력
		ItoDecX(FP,dp.publicItoDecV,VArr(dp.publicItoDecVArrX,0),2,nil,0)
		f_Movcpy(FP,_Add(dp.publicItoCusPtr,dp.DevV),VArr(dp.publicItoDecVArrX,0),4*12)
		SetCallEnd2()

		SetCall2(FP, dp.Call_ItoHex) -- 32비트 정수 → 16진수, 3워드(12바이트) 출력
		ItoHex(FP, dp.publicItoDecV, VArr(dp.publicItoHexVArr,0), 0, nil, 0)
		f_Movcpy(FP,_Add(dp.publicItoCusPtr,dp.DevV),VArr(dp.publicItoHexVArr,0),3*4)
		SetCallEnd2()

		SetCall2(FP, dp.Call_VtoName) -- 플레이어 번호(dp.VtoNameV) → 미리 구워둔 이름 문자열을 대상 위치(dp.VtoNamePtr)로 복사
		for i = 0,6 do
		CIf(FP,{CV(dp.VtoNameV,i)})
		f_Movcpy(FP, dp.VtoNamePtr, dp.PNameVArrArr[i+1], 4*5)
		CIfEnd()
		end
		SetCallEnd2()

		SetCall2(FP, dp.Call_VtoLPName) -- 로컬(관전) 플레이어 이름 버전
		f_Movcpy(FP, dp.VtoNamePtr, dp.LPNameVArr, 4*5)
		SetCallEnd2()

		SetCall2(FP, dp.Call_TBwrite) -- 문자 1개(dp.TBwInputChar)를 현재 위치에 그대로 기록(리터럴 상수/특수문자용)
		CDoActions(FP,{TBwrite(_Add(dp.publicItoCusPtr,dp.DevV),SetTo,dp.TBwInputChar)})
		SetCallEnd2()


		if CheckInclude_64BitLibrary == 1 then -- 64비트(War) 정수 지원은 별도 64비트 라이브러리가 포함된 경우에만 컴파일
		SetCall2(FP, dp.Call_lIToDec) -- 64비트 정수 → 10진수(최대 20자리, 5워드) 변환 서브루틴
		DoActionsX(FP, {
			SetCVAar(VArr(dp.publiclItoDecVArr,0), SetTo, 0x30303030),
			SetCVAar(VArr(dp.publiclItoDecVArr,1), SetTo, 0x30303030),
			SetCVAar(VArr(dp.publiclItoDecVArr,2), SetTo, 0x30303030),
			SetCVAar(VArr(dp.publiclItoDecVArr,3), SetTo, 0x30303030),
			SetCVAar(VArr(dp.publiclItoDecVArr,4), SetTo, 0x30303030)})--init << 0
		-- 최상위 비트가 켜져 있으면(부호 비트) 음수로 보고 첫 바이트에 '-'를 새겨두고,
		-- 자릿수가 짧을수록(19자리 미만) 상위 필드를 0x0D로 마스킹(선행 0 숨김)한다.
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
			-- 실제 값이 음수였다면 절댓값으로 부호 반전(f_LNeg) 후, 아래 War_NumSet으로
			-- 자리별(10^18~10^0) 이진탐색형 감산을 수행해 각 10진 자릿수 문자를 채운다.
			-- (dp.ItoDec의 32비트 버전과 동일한 원리, WAR 64비트 연산 헬퍼로 구현)
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

	-- 아래는 위 Call_lIToDec 블록의 예전 구현(1e19 자리 처리 방식이 다름)이 통째로
	-- 주석 처리되어 남아있는 죽은 코드다. 참고용으로 보존된 것으로 보이며 실행되지 않는다.
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

		SetCall2(FP, dp.Call_Print13X) -- DisplayPrintEr가 사용하는 즉시-표시 트리거 호출 지점
		Print_13X(FP,dp.Print13V)
		SetCallEnd2()



		-- (B) 서브루틴 정의 블록과 (초기화 CJump)를 닫아 정상 트리거 흐름으로 복귀.
		CJumpEnd(FP,SCJump)
		CJumpEnd(FP, dp.CustominitJump)
	end

	-- ============================================================================
	-- [DP_Start_init] 라이브러리의 공개 진입점. 맵 스크립트 최상단에서 한 번 호출해
	-- DisplayPrint 계열 함수들이 쓸 전역 상태(dp 테이블)와 EUD 변수/배열/콜슬롯을
	-- 전부 할당한 뒤, 초기화 트리거 체인을 맵의 트리거 실행 순서에 연결한다.
	--
	--   FixedPlayer : 조건 평가에 쓰일 고정 플레이어(FP). 이미 다른 곳에서 FP가
	--                 잡혀 있으면 생략 가능, 둘 다 없으면 에러
	--   DP_OP_Hold  : {DeathUnit, Value} 형태. DisplayPrintEr가 표시 시점마다
	--                 특정 유닛의 데스카운트를 세팅하는 부가 훅(다른 시스템과의 동기화용)
	--   AllocStart/AllocEnd : dp.Alloc(메모리 할당 카운터)의 시작/끝 범위
	--   SettingOp   : nil이 아니면 초기화 트리거를 바로 심지 않고, 나중에 실행할 수
	--                 있도록 {"DoActionsX",...} 형태로 반환만 함(호출 순서 제어용)
	-- ============================================================================
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
		dp.TBOLutputTxt = {} -- DisplayPrintTbl이 호출될 때마다 "TBL - id : ..." 디버그 텍스트를 여기 쌓음

		-- dp.TBOLutputTxt를 파일(DP_TBL.txt)로 덤프하는 디버그 로직. 다만 여기서는
		-- 방금 dp.TBOLutputTxt를 {}로 초기화한 직후라 항상 비어 있으므로 이 블록은
		-- 실질적으로 실행되지 않는다(DisplayPrintTbl 호출 이후 시점에 다시 검사해야 값이 쌓여 있음).
	if #dp.TBOLutputTxt~=0 then
	os.execute("mkdir " .. "DP_TBL")
	local CSfile = io.open(FileDirectory .. "DP_TBL" .. ".txt", "w")
	io.output(CSfile)
	for j,k in pairs(dp.TBOLutputTxt) do
		io.write(k)
	end
	io.close(CSfile)
	end



		
	-- 플레이어 이름 등 널(0x00) 바이트가 섞인 문자열을 VArr(4바이트씩 여러 슬롯)에 담을 때,
	-- 0x00을 만나면 스타크래프트 텍스트 렌더링이 거기서 끊길 수 있으므로 각 바이트 자리별로
	-- 값이 정확히 0이면 0x0D(안전한 채움 문자)로 바꿔치기한다. VArrLength+1개 슬롯 x 4바이트를 전수 검사.
	function _0DPatchforVArr(Player,VArrName,VArrLength) -- CtrigAsm 5.1
		for j=0, VArrLength do
			for k=0, 3 do
			TriggerX(Player,{VArrayX(VArr(VArrName,j),"Value",Exactly,0,255*(256^k))},{
			SetVArrayX(VArr(VArrName,j),"Value",SetTo,(256^k)*0x0D,255*(256^k))})
			end
		end
	end
	-- DisplayPrint/DisplayPrintTbl의 arg 배열에서 "플레이어 이름을 여기 넣어라"라고
	-- 표시하는 태그 생성 헬퍼. Player가 "LocalPlayerID" 문자열이면 로컬(관전) 플레이어 이름을 뜻함.
	function PName(Player) -- "LocalPlayerID" = LocalPName
		return {"PVA",Player}
	end
	-- 초기화 트리거 체인(dp.CustominitJump ~ dp.lastTrigIndex)을 맵의 트리거 실행 순서(Next 체인)에
	-- 끼워 넣는 마무리 작업. SettingOp가 지정되면 즉시 심지 않고 액션 설명만 반환해서
	-- 호출자가 원하는 시점/순서에 직접 실행할 수 있게 한다.
	if SettingOp == nil then
		DoActionsX(FP, {SetNext("X", dp.CustominitJump+JumpStartAlloc,1),SetNext(dp.lastTrigIndex, "X",1)}, 1,dp.initTrigIndex)
	else
		return {"DoActionsX",FP,{SetNext("X", dp.CustominitJump+JumpStartAlloc,1),SetNext(dp.lastTrigIndex, "X",1)},1,dp.initTrigIndex}
	end
	end


	
-- print_utf8_2와 목적은 같음(컴파일 타임 리터럴 문자열을 4바이트 DWORD 단위 SetCtrig1X로
-- 굽기)이지만, 대상이 고정된 텍스트 라인 메모리(0x640B60+...)가 아니라 CtrigAsm 트리거
-- 구조체(DB, {트리거slot, offset} 형태로 추정) 안의 필드로 직접 쓴다는 점이 다르다.
-- "602"는 트리거 액션 슬롯이 일정 개수(602워드 단위로 추정)마다 다음 트리거 블록으로
-- 넘어가야 하는 CtrigAsm 내부 레이아웃 제약을 보정하기 위한 값으로 보인다(정확한 602의
-- 유래는 CtrigAsm 프레임워크 문서 참고 필요).
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




	-- ============================================================================
	-- [DisplaySTRX] DisplayPrint와 인자 처리 로직은 완전히 동일하지만(같은 arg 타입
	-- 디스패치, 같은 인코딩 서브루틴 호출), 마지막에 실제로 화면에 표시하는 대신
	-- DisplayText 액션을 Disabled(비활성) 상태로 한 번만 등록해두고 dp.StrT(완성된
	-- 템플릿 문자열)를 그대로 반환한다. 즉 "출력용"이 아니라 "다른 곳에서 재사용할
	-- 동적 문자열 버퍼를 만들어두는" 용도 — 예: 다른 트리거가 이 버퍼의 DisplayText
	-- 액션을 나중에 Enable해서 재사용하거나, 반환된 dp.StrT를 다른 함수에 넘기는 식.
	-- ============================================================================
	function DisplaySTRX(arg,ResetTimer) -- ext text ver
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
		dp.StrT = {}
		dp.StrXIndex=dp.StrXIndex+1
		for j,k in pairs(arg) do
			if type(k) == "function" then
				local PrevBSize = BSize
				k()
				local NextBSize = BSize
				table.insert(dp.StrT,string.rep("\x0D",NextBSize-PrevBSize))
				
			elseif type(k)=="table" and type(k[1]) == "function" then
				local lfunc = k[1]
				local PrevBSize = BSize
				table.remove(k,1)
				lfunc(table.unpack(k))
				local NextBSize = BSize
				table.insert(dp.StrT,string.rep("\x0D",NextBSize-PrevBSize))
			elseif type(k) == "string" then
				--local CT = CreateCText(FP,k)
				table.insert(dp.StrT,k)
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
				table.insert(dp.StrT,string.rep("\x0D",4*5))
			elseif type(k)=="table" and k[4]=="V" then
				if k["fwc"] == true then
					BSize=BSize+(4*12)
					CMov(FP,dp.publicItoDecV,k)
					CallTrigger(FP,dp.Call_IToDecX,{SetV(dp.DevV,Dev)}) 
					Dev=Dev+(4*12)
					table.insert(dp.StrT,string.rep("\x0D",4*12))
				elseif k["hex"] == true then
					BSize=BSize+(3*4)
					CMov(FP,dp.publicItoDecV,k)
					CallTrigger(FP,dp.Call_ItoHex,{SetV(dp.DevV,Dev)}) 
					Dev=Dev+(3*4)
					table.insert(dp.StrT,string.rep("\x0D",3*4))
				else
					BSize=BSize+(4*4)
					CMov(FP,dp.publicItoDecV,k)
					CallTrigger(FP,dp.Call_IToDec,{SetV(dp.DevV,Dev)}) 
					Dev=Dev+(4*4)
					table.insert(dp.StrT,string.rep("\x0D",4*4))
				end
			elseif type(k)=="table" and k[4]=="W" then
				BSize=BSize+(4*5)
				f_LMov(FP, dp.publiclItoDecW, k, nil, nil, 1)
				CallTrigger(FP,dp.Call_lIToDec,{SetV(dp.DevV,Dev)}) 
				Dev=Dev+(4*5)
				table.insert(dp.StrT,string.rep("\x0D",4*5))
			elseif type(k)=="table" and k[1][4]=="V" then -- VarArr일 경우
				BSize = BSize+#k
				for o,p in pairs(k) do
					CMov(FP,dp.TBwInputChar,p)
					CallTrigger(FP,dp.Call_TBwrite,{SetV(dp.DevV,Dev)}) 
					
					Dev=Dev+(1)
					table.insert(dp.StrT,string.rep("\x0D",1))
				end
			elseif type(k)=="number" then -- 상수index V 입력, string.char 구현용. 맨앞 0xFF영역만 사용
				BSize=BSize+1
				CMov(FP,dp.TBwInputChar,V(k))
				CallTrigger(FP,dp.Call_TBwrite,{SetV(dp.DevV,Dev)}) 
				Dev=Dev+(1)
				table.insert(dp.StrT,string.rep("\x0D",1))
			else
				PushErrorMsg("Print_Inputdata_Error")
			end
		end
		
		if ResetTimer~=nil then
			CIfEnd()
		end

		dp.StrT = table.concat(dp.StrT).."\x0D\x0D\x0D\x0D"
		table.insert(dp.StrXKeyArr,{RetV,dp.StrT})
		DoActions(FP, {Disabled(DisplayText(dp.StrT))}, 1)

		RetV = nil
		Dev = nil
		BSize = nil
		return dp.StrT


	end

