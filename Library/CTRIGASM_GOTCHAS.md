# CtrigAsm 트리거 빌더 함정 모음 (AI/작업자 공용 인수인계용)

이 문서는 `MapSource/Library`(CtrigAsm v5.5)를 사용하는 모든 자매 맵 프로젝트(DPS_Enhance, theSeed,
Stella-II, MSF_* 계열 등)에 공통으로 적용되는, 실제로 컴파일 에러/런타임 크래시/멀티플레이 디싱크로
발현됐던 함정들을 정리한 것입니다. 새 세션(AI든 사람이든)이 같은 실수를 반복하지 않도록 남겨둡니다.

## 문서 우선순위

- 가이드북: `Ctrig Assembler v5.4 Guide Book.txt` (같은 폴더의 `.pdf`는 참고용, 텍스트가 항상 최신)
- 라이브러리 소스(가이드북과 충돌 시 이쪽이 우선 — 실제 배포본은 v5.5): `CtrigAsm v5.5.lua`와 같은
  폴더의 `DisplayPrint.lua`, `LibraryFor322.lua` 등. 이 폴더 전체가 모든 자매 맵의 `main.lua`
  로더에서 자동으로 불러와짐.
- 가이드북에 없거나 애매한 함수는 자매 맵들의 실사용 코드를 grep해서 확인하는 게 가이드북보다 빠르고
  정확함 (실제 배포/테스트된 코드이기 때문).

## 1. X-suffixed 액션은 CopyCpAction/RotatePlayer로 감싸야 함

`DisplayTextX`, `PlayWAVX`, `SetMissionObjectivesX`, `LeaderBoardGoalControlX` 등은
"CopyCpAction 전용 함수"(가이드북 21장)로 문서화되어 있음. `DoActionsX(FP,{...})`나 순수
`Trigger{actions=...}` 목록 안에 맨몸으로 넣으면 안 되고 반드시 감싸야 함:

- `DoActions2X(FP, {CopyCpAction({DisplayTextX(Text,4)}, TargetForce, FP)})`
- `DoActions(FP, {RotatePlayer({DisplayTextX(Text,4), PlayWAVX(...)}, HumanPlayers, FP)})`
  (`Engine/G_CB_Lib.lua` 전반에서 쓰이는 패턴)

이유: 이 X-액션들은 플레이어별 "현재 플레이어" 컨텍스트 전환이 필요해서, 감싸지 않으면 ScmDraft2에서
플레이어 간 문자열이 깨짐. 가능하면 이 문제를 원천적으로 피하는 `DisplayPrint()`/`DisplayPrintTbl()`
헬퍼를 raw `DisplayTextX` 대신 쓰는 걸 우선 고려할 것.

## 2. T/TT 조건·액션(변수 삽입)은 TriggerX가 아니라 CTrigger를 써야 함

`TriggerX(Player,Conditions,Actions,Flags,Index)`는 T/TT 전처리 없이 바로 `Trigger{...}`를 만듦.
`CTrigger`는 시그니처/호출 규약이 동일하면서 `PopCondArr`/`PopActArr`/`PopTrigArr` 파이프라인을 추가로
돌려서 `TDeaths`, `TCV` 같은 T/TT 조건·액션의 변수 삽입을 해석함(가이드북 16장: "CTrigger: TriggerX와
동일하나 T/TT 조건/액션 사용가능(CStruct)"). T/TT 조건(또는 그걸 감싼 헬퍼, 예: `MSQC_TKeyInput`)을
`TriggerX`의 조건 목록에 넣으면 컴파일 에러가 남.

**원칙**: 목록 중 하나라도 T/TT-prefixed면 기본으로 `CTrigger`를 쓸 것 — 인자 순서/`{preserved}` 플래그
규약은 완전히 동일해서 드롭인 교체 가능함.

## 3. 중간 연산자(`_Add`/`_Sub`/`_Mul`/`_Div`/`_iSub`/`_iMul` 등)는 첫 번째 인자가 반드시 non-constant

컴파일 타임에 상수로 폴딩되는 값(리터럴, 또는 `0x58A364 + 0x30*5` 같은 식)을 첫 번째 인자로 넣으면
컴파일 에러. 의도적인 안전장치 — 양쪽 다 상수면 애초에 순수 Lua 산술로 처리하면 되기 때문. 변수/식
쪽이 항상 먼저, 상수는 두 번째.

- 틀림: `_Add(0x58A364 + 0x30*Unit, _Mul(4, Player))` (바깥 `_Add`의 1번 인자도, 안쪽 `_Mul`의 1번
  인자도 둘 다 상수)
- 맞음: `_Add(_Mul(Player, 4), 0x58A364 + 0x30*Unit)` — 모든 중첩 단계에서 변수 쪽이 먼저
- 제약은 **첫 번째 인자에만** 적용됨 — 두 번째 인자는 상수여도 무방
  (`_Div(_Mul(Offset, Scale), 2*HalfWidth)`는 `_Mul`의 1번 인자 `Offset`이 변수라 문제없음)
- 가이드/문서 예시가 "상수 op 변수" 순서로 쓰여 있는 경우가 많아서, 그대로 옮기면 순서가 반대로 되는
  실수가 잦음 — `_Add`/`_Sub`/`_Mul`/`_Div`/`_iSub`/`_iMul` 호출마다 인자 순서를 다시 확인할 것.

## 4. CRead의 Source: PTR(정적 상수 주소) vs EPD(변수 기반 주소) 구분

`CRead`의 `Source`는 상수(PTR, 정적 메모리 주소)와 변수(V, EPD 방식)를 서로 다른 인코딩으로 읽음 —
가이드북 확인: "Source : 값을 읽어올 대상 (상수(오프셋)/"Cp"/변수/Mem/A/VA) - **변수값를 epd로 간주해
읽어옴**". `_Add`/`_Mul` 같은 중간 연산자로 런타임 변수 Player를 조합해서 Source에 넣으면, 의도한
PTR 주소가 아니라 EPD 방식의 변수 입력으로 오인식되어 **컴파일은 되지만 실제 게임이 크래시**함
(EUD ERROR — 크래시 다이얼로그의 주소는 실제 잘못된 주소의 32비트 보수: 실주소 =
`0xFFFFFFFF - 표시된값`).

- `DtoA(Player,UnitId)` (`0x58A364 + 0x30*Unit + 0x4*Player`)는 컴파일 타임 상수 `Player`에서만
  동작하는 순수 Lua 산술(= PTR 값). 런타임 변수 Player를 지원하려고 `_Add(_Mul(Player,4), constant)`
  식으로 재구현해서 `CRead`에 넣으면 위 문제가 발생함.
- **해결**: 주소가 런타임 변수 Player에 진짜로 의존해야 하면, 상수 Player 값 전부에 대해 분기(unroll)
  해서 각 분기 안에서 리터럴 Player로 `DtoA(Player, Unit)`을 호출할 것 — `SetupAuthority.lua`의
  `IsSetupAuthority(Player)`와 같은 플레이어별 `CIfX`/`CElseIfX` unroll 패턴.
- `_Add`/`_Sub`/`_Mul`로 만든 식은 값/비교/인덱스 컨텍스트에는 안전하게 쓸 수 있지만(예:
  `RandomPlacement.lua`의 격자 좌표 계산), `CRead`의 `Source`처럼 진짜 상수 PTR 주소가 필요한 자리를
  대체할 수는 없음 — 문서/예제가 항상 상수로만 호출하는 함수는, 실제 동작하는 변수-입력 예제가 없는 한
  변수 식을 그대로 넣어도 될 거라 가정하지 말 것.

**배경 (실제 맵 제작 경험으로 확인됨)**: PTR은 SC 1.16.1 시절 EUD 씬에서 쓰이던 용어로, 그냥 정적
메모리 주소를 뜻함. EPD는 EUD가 Unit을 Player로 바꿔 부르는 인덱싱 방식으로, 전형적인 활용 형태가
`SetDeaths(P1, SetTo, 0, 15235)`처럼 UnitID 슬롯을 실제 유닛 ID가 아니라 원래는 접근 불가능한 메모리
영역에 닿는 통로로 쓰는 것. 이를 확장해 Player 슬롯 자체에 큰 상수를 넣는 방식도 있음(예:
`SetDeaths(1583685, SetTo, 0, 0)`). Player=1, 상수 0 지점의 데스 테이블 시작 주소는 `0x58A364`이고,
Player에 음수(`-1`)를 넣으면 `SetDeaths(-1, SetTo, 0, 0)`으로 `0x58A360`에 접근 가능함 —
**실제로 작동하는 것까지 확인됨**. (그 주소 접근 자체가 EUD ERROR를 유발하는지는 불명이나, 접근
가능 여부와는 무관한 부차적인 사항.)

## 5. 로케이션 번호: 메모리 직접 조작은 0-based 그대로, 트리거 조건/액션엔 +1

로케이션 배열은 메모리상 0-based지만 트리거 조건/액션 인코딩은 1-based(에디터의 "Location 1" =
메모리 슬롯 0; 트리거 인코딩에서 로케이션 ID 0은 "No Location"을 의미).

- `Simple_SetLocX(FP, MyLoc, ...)` (로케이션 범위를 메모리로 직접 조작) — 원래 숫자 그대로, +1 없음
- `CenterView(MyLoc+1)`, `TCreateUnitWithProperties(..., MyLoc+1, ...)`, `CBPlot(..., MyLoc+1, ...)`
  (또는 그 외 로케이션을 상수로 받는 트리거 조건/액션) — 항상 +1

두 호출 형태가 겉보기엔 똑같아서(`FunctionName(FP, SomeLocVar, ...)`) 놓치기 쉬움 — 구분 기준은
호출 대상이 메모리를 직접 조작하는지, 실제 트리거 조건/액션을 만드는지 뿐. 헷갈리면 같은 프로젝트
안에서 이미 맞게 짜여진 코드(예: `SetupMenu.lua`의 `BaseViewLoc` 사용부)를 참고할 것.

## 6. 비공유(로컬) 조건으로 공유 변수 쓰기를 게이트하면 안 됨 — 실제 멀티플레이 디싱크 원인

`MousePress`, `Bring`, `Command` 등은 클라이언트별로 다르게 평가되는 로컬 입력 상태를 읽음.
이런 조건을 게이트로 걸어 공유(shared) 변수/메모리에 쓰는 액션을 실행하면, 클라이언트마다 그 "공유"
변수 값이 달라져서 즉시 디싱크가 남 — 실제 라이브 멀티플레이 테스트로 확인된 문제
(`theSeed/MapLogic/CustomSliderPhase.lua`의 `SliderDragging` 사례).

- **해결 패턴**: 로컬 조건을 키보드/마우스 좌표와 동일하게 MSQC/NSQC를 거쳐 공유화할 것. NSQC.py의
  마우스 인식(가이드북 27장) 설정 `MouseDown(L)`/`MouseUp(L)`/`MousePress(L) : UnitID, 값`은
  락스텝 경계 바깥에서 `SetDeaths(Player,Add,값,UnitID)`를 실행함 — 키보드(`MSQC_KeySet`)/마우스
  좌표(`val`)와 같은 안전한 주입 경로. 이렇게 Deaths 테이블에 들어온 값은
  `TDeaths(Player,Exactly,Value,DeathUnit)`로 안전하게 읽을 수 있음(런타임 변수 Player를 직접
  지원 — `DtoA`와 달리 플레이어별 unroll 불필요).
- 구체적으로: 같은 Death-count 슬롯에 `MouseDown(L) : UnitID, 1`과 `MouseUp(L) : UnitID, -1`을
  등록해서 슬롯 자체가 0/1(뗌/누름)로 토글되게 하고, "이 슬롯이 정확히 1인가"를 안전한 공유
  "눌림" 조건으로 취급할 것 — 트리거 조건에서 `MousePress`를 직접 쓰지 말 것.
- **일반 원칙**: 클라이언트별/로컬 상태(마우스 버튼, 마우스 위치, 키보드 비트 테스트, 일부 클라이언트만
  명확히 보는 `Bring`/`Command` 등)를 읽는 조건으로 공유 상태 쓰기를 게이트하기 전에, "모든
  클라이언트가 같은 시뮬레이션 틱에 이 조건을 동일하게 평가하는가?"를 먼저 물을 것. 숫자 값뿐 아니라
  불리언/레벨형 조건도 똑같이 이 문제가 적용됨.

## 7. 가이드북 문서 서술보다 실제 설치된 플러그인 소스가 정확할 수 있음

가이드북 NSQC 챕터는 `MouseDown(키)/MouseUp(키)/MousePress(키) : UnitID, 값`을 전부 동일하게
`SetDeaths(Player,Add,값,UnitID)`로 서술하지만, 실제로는 `plugins/NSQC.py` 소스(euddraft 설치
경로, 예: `c:\euddraft0.9.2.0\plugins\NSQC.py`)에만 드러나는 중요한 동작 차이가 있음:
`MouseDown`/`MouseUp`은 내부적으로 엣지를 캐시(`MouseArray` 비교)해서 누름/뗌마다 정확히 한 번만
Add가 발동하지만, `MousePress`는 그런 캐시가 없어서 **버튼을 누르고 있는 동안 매 틱 계속 Add가
발동**함 — 그대로 두면 Death 카운트가 무한히 누적됨. `MousePress` 기반 값을 안전하게 소비하려면
매 사이클 읽자마자 0으로 리셋해야 함(`Exactly N` 단발 비교로는 안 됨).

**적용 원칙**: 정확한 틱 단위 동작(누적 vs 리셋, 엣지 vs 레벨)이 중요하고 틀리면 컴파일 에러가 아니라
조용히 잘못된 런타임 동작으로 이어지는 경우, 번역된 가이드북 서술만 믿지 말고 실제 플러그인/라이브러리
소스(`euddraft*/plugins/*.py`)를 직접 확인할 것.

---

**적용 가이드**: 특정 CtrigAsm 함수를 맨몸으로 써도 되는지, 특정 래퍼/빌더 변형이 필요한지 애매하면
가이드북에서 해당 챕터(16장 = T 조건/액션, 21장 = CopyCpAction 전용 함수)를 먼저 확인할 것. 연산자
인자 순서 규칙은 챕터 참고 없이 그냥 항상 변수/식 쪽을 먼저 쓰면 됨. "이 함수가 런타임 변수 Player를
지원하는가"는 기본적으로 "아니오"로 가정하고, 변수 Player로 실제 동작하는 예제가 없으면
`IsSetupAuthority` 스타일의 플레이어별 분기 unroll을 기본으로 쓸 것. 로케이션을 받는 함수는 메모리
직접 조작용(`Simple_SetLocX` 스타일, 원래 숫자)인지 실제 트리거 조건/액션(+1 필요)인지부터 구분할 것.
