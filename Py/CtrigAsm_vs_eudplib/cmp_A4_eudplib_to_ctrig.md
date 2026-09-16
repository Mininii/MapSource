# eudplib 에는 있는데 CtrigAsm 에는 없는 기능 (A4 조사)

기준: eudplib 0.76.14 (`C:\Users\whatd\.venvs\eud076\Lib\site-packages\eudplib\`, 공개 이름 전체를 모듈별로 뽑은 목록은
`lists\a4_eudplib_all.txt`), CtrigAsm v5.5 소스(함수 1,315개 목록 `lists\a4_ctrig_funcs.txt`) + 가이드북 v5.4 D장.

줄 번호 약어:

| 약어 | 파일 |
|---|---|
| `E/…` | eudplib 소스 루트 아래 경로 |
| CA | `MapSource\Library\CtrigAsm v5.5.lua` |
| LF | `MapSource\Library\LibraryFor322.lua` |
| GB | `MapSource\Library\Ctrig Assembler v5.4 Guide Book.txt` |
| EB | `MapSource\Library\EPSCRIPT_TRIGGER_BUDGET.md` (실측 수치 출처) |
| GOT | `MapSource\Library\CTRIGASM_GOTCHAS.md` |

판정:

- **있음**: CtrigAsm(또는 TEP)에 같은 일을 하는 공개 함수가 있다.
- **부분적**: 대응 함수는 있지만 제약이 있다(비고에 한 줄).
- **없음**: 공개 함수가 없다(비고에 "만들려면 무엇이 막히는지").
- **같음**: 두 쪽 모두 없거나 두 쪽 모두 같은 방식이다. 차이가 아니다.
- **공통**: euddraft 기능이라 CtrigAsm 맵에서도 쓸 수 있다.

CtrigAsm v5.5 에는 가이드북 v5.4 이후에 들어온 함수가 많다(`NSwitch`, `NFor`, `NBag`, `NQueue`, `NDeque`, `NStack`,
`ChangeWireframe`, `InitWarpQueue` 등). 그래서 "가이드북에 없음"을 "CtrigAsm 에 없음"으로 판정하지 않았다. 소스를 grep 해서 확인했다.

---

## 1. 언어·구조

| 기능 묶음 | eudplib 대표 API(파일) | 하는 일 | CtrigAsm/TEP 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 함수(인자·반환값) | `EUDFunc`·`EUDTypedFunc` (E/core/eudfunc/eudf.py:19,50), 호출 `EUDFuncN.__call__`(eudfuncn.py:211), `EUDReturn`(:266) | 인자 N개, 반환값 N개. 본문은 한 번만 싣고, 호출하는 곳은 트리거 1개(인자·복귀 주소를 SeqCompute 로 대입한 뒤 점프) | `InitCFunc`·`CFunc`·`CFuncReturn`·`CallCFunc`·`CallCFuncX`·`_Func`·`TTFunc` (CA 77741, 77757, 77796, 77865; GB 4699~4760) | 부분적 | 인자 수 상한이 맵 전체 설정 하나다(`StartCtrig(...,CFunc)` 기본 16, CA 508-512). 호출하는 곳마다 입출력 마샬링 트리거가 2~4개 붙고 하나에 2400B씩 든다. eudplib 은 트리거 1개다(EB 2.5절). |
| 재귀·재진입 | EUDFunc 인자·반환값은 고정 EUDVariable 이다(eudfuncn.py:135-143). 재귀가 필요하면 `EUDStack`(E/eudlib/eudstack.py:12)에 직접 저장한다 | — | `CPush`·`CPop`·`LPush`·`LPop`(CA 82490, 82537)에 직접 저장 | 같음 | 둘 다 자동 재귀가 없다. 차이 아님. |
| 지역 변수 | 함수 안의 `EUDVariable()`, epScript `var`. 컴파일 때 1개씩 정적으로 잡히고 이름 범위만 지역이다 | — | `CreateVar` 결과를 Lua `local` 에 담음 | 같음 | 방식은 같다. 차이는 변수 1개의 크기다(아래 "변수·점프 표 크기" 행). |
| 함수 포인터 | `EUDFuncPtr(argn,retn)`·`EUDTypedFuncPtr` (E/core/eudfunc/eudfptr.py:82,174) | 변수·배열·구조체 필드에 함수를 담아 간접 호출 | `InitVFunc`·`VFunc`·`CallVFunc`·`_VFunc`·`TTVFunc` (CA 82933, 83034; GB 4836~4884) | 있음 | 포인터를 W(64비트 변수)에 담아야 한다. 인자 규칙은 CFunc 와 같다. |
| 구조체·객체 | `EUDStruct`(E/core/eudstruct/eudstruct.py:15): 이름 필드, `alloc/free`(:33,39), `copy`, `constructor/destructor`, 필드 타입(중첩 구조체·CUnit), `EUDStruct * n` 배열 | 이름 붙은 필드를 가진 레코드. 풀에서 할당·반납하고 배열 원소로도 쓴다 | `SV`·`CreateSVar`·`CSVariable`(CA 2480, 75842, 5987; GB 23장, 1~32칸 묶음 변수). 오브젝트 풀은 사용자 라이브러리 `TStruct.lua` | 부분적 | SV 는 칸 번호(Line)로만 접근한다. 필드 이름·타입·중첩·생성자가 없다. |
| 메서드 | `EUDMethod`·`EUDTypedMethod`(E/core/eudfunc/eudfmethod.py:21,91), `selftype`(eudstruct/selftype.py:11) | 구조체에 붙은 함수. self 를 그 타입으로 캐스팅 | — | 없음 | CFunc 는 전역 함수뿐이다. 구조체가 칸 묶음이라 메서드를 붙일 대상이 없다. |
| 타입 | `EUDTypedFunc([TrgUnit, CUnit, ...])`, 구조체 필드 타입, `EUDVArray(n, basetype)`(E/core/eudstruct/vararray.py:105), `.cast()` | 인자·반환값·원소를 타입으로 바꾼다(유닛 이름→번호, epd→CUnit 등). 이후 타입에 맞는 멤버와 연산을 쓴다 | 값은 전부 태그 테이블(`V`/`W`/`SV`/`Vi`)이나 숫자 | 없음 | TEP Lua 는 동적 타입이다. CtrigAsm 태그는 "어느 저장소인가"만 구분하고, 필드·메서드를 해석할 타입 정보가 없다. |
| 모듈·import | 파이썬 `import`, epScript `import a.b as x;`(E/epscript/helper.py:33 `_RELIMP`), `py_` 호출, `EUDRegisterObjectToNamespace`·`GetEUDNamespace`(E/core/inlinens.py:20,38) | 파일마다 이름공간이 따로 있고 필요한 것만 불러온다 | TEP 는 폴더의 .lua 를 순서대로 모두 로드한다. 전역은 하나이고, 같은 이름은 나중 정의가 이긴다(`DPS_eud\eud\spec\_AGENT_BRIEF.md` 1번) | 부분적 | Lua `local`·`dofile` 로 흉내는 낼 수 있다. 하지만 CtrigAsm API 가 전역 할당 상태(IndexAlloc 등)를 공유해서 파일을 나눠도 분리 효과가 없다. |
| 제어문 | epScript `if/else if/else`, `while`, `for(;;)`, `foreach`, `switch/case`, `break/continue`, `once` → `EUDIf`(E/ctrlstru/simpleblock.py:21), `EUDExecuteOnce`(:116), `EUDWhile`(loopblock.py:104), `EUDLoopRange`(:84), `EUDSwitch`·`EPDSwitch`(swblock.py:42,24), `EUDBreak`·`EUDContinue`(breakcont.py:37,14) | 구조적 제어 흐름 | `CIf`·`CIfX`·`NIfX`, `CWhile`·`NWhile`·`DoWhile`, `CFor`·`NFor`, `NSwitch`·`NSwitchCase`·`NSwitchBreak`, `CIfOnce`, `CJump`·`NJump` (CA 10444, 11785, 10703, 11663, 95082, 95227, 10397, 10193, 10233) | 부분적 | 루프용 break/continue 가 없어서 `NJump` 로 빠져나간다. C 계열 블록은 안에서 점프로 탈출할 수 없다(GB 1498, 1535, 1571). `CLoop`/`NLoop` 반복 횟수는 상수만 된다(GB 10장). |
| 짧은 회로 and/or·not·삼항 | `EUDSCAnd`·`EUDSCOr`(E/ctrlstru/shortcircuit.py:14,98), `EUDAnd`·`EUDOr`·`EUDNot`(E/eudlib/utilf/logic.py:14,34,59), `EUDTernary`(E/ctrlstru/basicstru.py:39). epScript `&&`·`||`·`!` | 조건 중첩, 값을 고르는 식 | `_TP`·`_TOR`·`_TAND`·`_TNOT`·`_TB`(CA 17023; GB 6126~6150), 구판 `TTOR`·`TTAND`(CA 16997) | 부분적 | CStruct 조건 칸 안에서만 쓸 수 있다(GB 6150). 뒤 조건을 건너뛰는 단락 평가인지는 확인하지 못했다. 삼항식은 없어서 CIfX 로 대입한다. |
| 식 문법·복합 대입·상수 폴딩 | `EUDVariable` 연산자 오버로드: `a*b+c`, `a += 1`, `a <<= 2`, 비교식이 곧 조건. 상수끼리는 파이썬이 계산하고 epScript `const` 도 쓴다(EB 1절). 대입 묶음은 `SeqCompute`·`NonSeqCompute` | 임시 변수를 자동으로 만든다 | 중간 연산자 `_Add`·`_Mul`…(CA 41799, 41973) + `CMov`·`CAdd`·`CMul`…(CA 20936), LF `V()` 산술 메타테이블(LF 23) | 부분적 | 중간 연산자의 1번 인자가 상수면 컴파일 오류다(GOT 3절). 메타테이블은 `(v+1)+2` 처럼 왼쪽이 임시식이면 Lua 오류가 난다(`spec\G1_vars.md:303`). 복합 대입은 함수 호출 모양이다. |
| 다중·병렬 대입 | `SetVariables`, epScript `a, b = b, a;`(EB 1절 `_SV`) | 한 트리거에 묶어서 동시에 대입 | `CMov` 여러 번, `CDoActions` 안의 T 액션 | 부분적 | 교환처럼 순서에 따라 결과가 달라지는 대입은 임시 변수를 직접 둔다. |
| goto·라벨 | `EUDJump`·`EUDJumpIf`(basicstru.py:18,27) + `Forward` | 아무 지점으로나 점프. 라벨 수 제한 없음 | `CJump`·`NJump`, `Label`, `SetNext`, `CallLabelAlways` (CA 10193, 1745, 6136) | 있음 | 번호 공간에 한도가 있다. 점프 번호 0~0xFFF(GB 1433), 라벨 0~0x1FFFF(GB 581). |
| 플레이어별 트리거 | `PTrigger(players, conds, acts)`(E/trigger/ptrigger.py:31) | 본문은 1벌이고, 현재 플레이어가 대상인지 가리는 트리거가 4개 붙는다. 포스는 맵 정보에서 자동으로 읽는다 | TEP `Trigger{players={...}}` 는 플레이어마다 복제한다. CtrigAsm 코드는 FP 목록 안에서 `CopyCpAction`·`RotatePlayer`(CA 42981, LF 74)로 처리한다 | 부분적 | 복제 방식이라 용량이 플레이어 수만큼(N배) 든다(2400B × N). |
| 원시 트리거 조작 | `RawTrigger(nextptr=…)`, `SetNextPtr`, `PushTriggerScope`, 조건·액션 안 변수를 자동으로 채우는 `trigger/tpatcher.py`, TRIG 바이트 생성 `trigtrg/trigtrg.py`, `RunTrigTrigger`(E/trigtrg/runtrigtrg.py:33) | 트리거 체인을 직접 구성한다. 클래식 TRIG 트리거를 원하는 시점에 실행한다 | `Trigger{}`, `Label`·`CtrigX`·`SetCtrigX`(CA 1745, 1827), T/TT 조건·액션(GB 16~17장), `CTrigger`(CA 7226) | 있음 (RunTrigTrigger 제외) | 주소는 원본 기준 런타임 Label 로 풀린다. TRIG 목록을 실행하는 시점을 바꾸는 RunTrigTrigger 에 해당하는 것은 없다(EUDTurbo 경로 고정). |
| 컴파일 시 주소·상수식 | `Forward`, `ConstExpr`, `Evaluate`, `RlocInt`, `GetObjectAddr`(E/core/allocator) | 어떤 객체 주소든 컴파일 때 식으로 써넣는다 | `Mem()`·`_Mem()`·`Arr()` 주소는 어셈블러가 맵 시작 때 재배치한다(STRX PATCH) | 부분적 | 원본은 런타임 재배치라 시작 때 트리거를 약 1,010만 회 실행한다(추정, memory `theseed-asm-stack`). 사용자 포크 `Py\STRCtrig Assembler v5.5 Stack.py` 가 이 재배치를 컴파일 때로 옮겼다. |
| 한 틱 양보 / 시작 1회 | `EUDDoEvents()`(E/maprw/injector/mainloop.py:87), `EUDOnStart(func)`(:29) | 코드 중간에서 다음 틱으로 넘기고 그 자리에서 이어서 실행한다 / 메인 코드보다 먼저 1회 실행 | 시작 1회는 `CIfOnce`, 1회 플래그 `DoActions`. 양보는 없다 | 없음 (양보) | CtrigAsm 은 매 사이클 위에서 아래로 실행되므로 여러 틱에 걸친 일은 상태 변수(`Timer` CA 55053, `Stage` CA 80330)로 나눠야 한다. 주의: `EUDDoEvents` 는 흐름 전체를 한 틱 멈춘다. euddraft 에선 그 틱에 TRIG 와 다른 플러그인도 건너뛸 것으로 보인다(추정). |

## 2. 페이로드·진단·빌드

| 기능 묶음 | eudplib 대표 API(파일) | 하는 일 | CtrigAsm/TEP 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 트리거 적층 | `CompressPayload`(E/core/allocator/payload.py:57) + Rust 할당기(`E/bindings/_rust`, EB 2.1절) | 트리거가 서로의 빈 칸에 끼어 들어가 146~2080B 로 실린다 | 원본은 적층이 없다. `TRIGP*.chk` 를 Db 로 통째 실어서 트리거 1개가 항상 2400B 다(EB 3절). 사용자 포크 Stack.py `lean` 은 적층 28,148 / 원래 자리 20,274 레코드(theSeed 0.4) | 부분적 (포크) | "주소+번호*604" 를 런타임에 계산하는 구간(CreateArr 빈 트리거, VArr, 점프 표)은 원래 자리에 둬야 한다. 포크의 검증률은 절반이다. |
| 사용 안 한 객체 제거 | `_collect_objects`(payload.py:116). 루트에서 참조되는 객체만 모은다 | 쓰지 않는 함수·변수·데이터는 맵에 실리지 않는다 | `Include_*`(예: `Include_CtrigPlib` CA 29329)를 손으로 켜고 끈다. 선언한 트리거는 전부 실린다 | 없음 | tepc 는 선언 순서대로 모두 내보낸다. 참조가 런타임 Label 로 풀리기 때문에 무엇이 도달하는지 알 수 없다. |
| 주소 섞기 | `ShufflePayload`(payload.py:68, 기본으로 켜짐) | 빌드마다 객체 배치를 무작위로 바꾼다 | — | 없음 | 보호에 약간 도움이 되는 부수 효과 정도. |
| 클래식 TRIG 인라인·공유 | `PRT_SetInliningRate`(E/maprw/inlinecode/ilcprocesstrig.py:29) | 맵 TRIG 트리거를 페이로드 코드로 옮기고, 같은 트리거는 하나로 공유한다 | 어셈블러 플러그인이 0 으로 끈다(`plugins\STRCtrig Assembler v5.5.py:6`, Stack.py:33) | 없음 | CtrigAsm 트리거는 Label 기반으로 자기를 고치기 때문에 위치가 바뀌면 깨진다(EB 2.8절). |
| 변수·점프 표 크기 | `EUDVariable` 72B(E/core/variable/vbuf.py:20), 점프 표 항목당 20B(E/ctrlstru/jumptable.py:8), `EUDLightVariable` 4B·`EUDLightBool` 1비트(eudlv.py:14,29), 마스크 변수 `EUDXVariable`(eudxv.py:14) | 값 하나를 저장하는 비용 | `CVariable` 2400B(CA 5853; 사용자 VarStack 포크는 72B), Ccode(변수 트리거 1개에 480칸)·Ncode(60칸), 빈 메모리 칸 `Void`(GB 3234~3246), 마스크 있는 `CVariable2` | 부분적 | 점프 표는 항목마다 트리거 1개다(EB 3절 표). 여러 값을 한 트리거에 담는 방식(Ccode·Void)은 있지만 칸 수에 한도가 있다. |
| 함수별 트리거 수 | `EUDFuncN.size()`·`_triggerCount`(E/core/eudfunc/eudfuncn.py:72-79), `GetTriggerCounter` | 함수마다 트리거를 몇 개 쓰는지 센다 | `AllocCheck`(인덱스 넘침 검사)뿐. 사용자 도구 `Py\tools\stack_plan_check.py` 는 청크 단위로만 본다 | 없음 | 용량을 줄일 때 어느 함수가 큰지 바로 알 수 있다. tepc 출력에는 함수 경계가 없다. |
| 컴파일 오류·줄 번호 | `EPError`·`ep_assert`·`ep_warn`(E/utils/eperror.py:13-34). 블록 짝이 안 맞으면 블록 이름을 알려 준다(eudfuncn.py:123-127). epScript 는 줄 번호 표를 바꿔 끼워 오류가 .eps 줄로 나온다(E/epscript/epsimp.py:33, linetable_calculator.py). 메시지는 한국어(E/localize/ko_KR) | 오류가 난 위치를 찾는다 | `PushErrorMsg`: 메시지를 이름으로 한, 정의되지 않은 전역 함수를 불러 Lua 오류를 낸다(CA 60044, LF 40). `ControlCheck`(CA 2240)·`LabelCheck`, `PushValueMsg`(CA 60056) | 부분적 | Lua 오류 위치가 라이브러리 안쪽 줄로 나와서, 호출한 맵 코드 줄은 traceback 으로 따로 찾아야 한다. 경고(warning) 체계가 없다. |
| 런타임 크래시 위치 추적 | `EPS_SetDebug(True)`가 함수 진입과 줄마다 `EUDTraceLog`(E/core/eudfunc/trace/tracetool.py:97)를 넣는다. 크래시 덤프를 `C:\euddraft0.9.2.0\epTrace.exe` 가 파일·함수·줄로 풀어 준다 | EUD 오류가 난 코드 줄을 찾는다 | `Debug.py` 플러그인(0x58F448 로 켜는 인게임 메모리 표시, GB 435~), 사용자 DebugBridge | 없음 | CtrigAsm 트리거에는 소스 줄 정보가 없다(tepc 출력은 라벨과 액션뿐). |
| 빌드 속도 | eudplib: 파이썬으로 객체 수집 + Rust 할당기 | — | tepc(C++) + 어셈블러 플러그인(파이썬) | 미측정 | 같은 맵을 두 경로로 빌드해 잰 수치가 없다. |

## 3. 라이브러리

### 3.1 유닛·스프라이트·메모리

| 기능 묶음 | eudplib 대표 API(파일) | 하는 일 | CtrigAsm/TEP 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 유닛 순회 | `EUDLoopUnit`(연결 리스트), `EUDLoopUnit2`(1700칸 런타임 루프), `EUDLoopCUnit`, `EUDLoopPlayerUnit`(플레이어별 리스트 0x6283F8) (E/eudlib/utilf/listloop.py:51,130,179,187) | 살아 있는 유닛마다 본문 1벌을 실행한다 | `CunitCtrig_Part1~3`·`Part3X`·`Part4X`·`End`, `ClearCalc`·`BreakCalc` (CA 5692, 5739; GB 1352~1392) | 부분적 | `CunitCtrig_Part3` 는 i=0..1699 를 트리거 1700개로 펼친다(CA 5750-5767, 2400B×1700 ≈ 4MB/회). eudplib 은 본문이 1벌이다. 플레이어별 리스트 순회는 없다. |
| 새 유닛 순회 | `EUDLoopNewUnit(allowance)`·`EUDLoopNewCUnit`(listloop.py:77,125) | 지난 틱 뒤에 생긴 유닛만 돈다 | 없음. 맵 코드가 CreateUnit 직전에 `f_Read(FP,0x628438,…)` 로 한 마리만 잡는다(예: `DPS_Enhance\CallTriggers\gameplay\boss.lua:37`) | 없음 | 여러 마리, 또는 다른 트리거가 만든 유닛을 잡는 일반 루틴이 없다. 0x628438 은 "다음 빈 슬롯"이라, 한 번에 여러 마리가 생기면 추적할 수 없다. |
| 유닛 모음 | `UnitGroup(capacity)` + `.cploop`·`.dying`(E/eudlib/unitgroup.py:46) | 등록한 유닛을 순회하고, 죽은 유닛은 자동으로 뺀다 | `NBag`·`NBagLoop`(CA 96635, 96989) | 부분적 | NBag 은 필드 1~32개짜리 자료 가방이다. 죽었는지 판정하고 빼는 일은 직접 짠다. |
| CUnit·CSprite 멤버 | `CUnit`(E/offsetmap/cunit.py:89, 멤버 선언 약 240줄), `CSprite`(csprite.py:34), `EPDCUnitMap`, 플래그 열거형(`StatusFlags` 등) | 이름·크기·타입이 붙은 구조 오프셋을 읽고 쓴다(`unit.hitPoints += …`) | `_CUnitEPD`·`f_CunitRead`·`f_EPD` + 숫자 오프셋(`Vi(NextEPD,0xDC/4)`, CA 98788), 확장 배열 `Install_EXCC`(LF 1804) | 부분적 | 오프셋과 크기를 숫자로 직접 쓴다. 이름표가 없다. |
| 스프라이트·총알·리스트 순회 | `EUDLoopSprite`, `EUDLoopBullet`, `EUDLoopList`, `EUDLoopTrigger`(listloop.py:229,225,27,249) | 활성 스프라이트, 총알, 임의 연결 리스트, 트리거 목록을 돈다 | 없음. 28장에는 생성 함수(`ScanSprite`·`CreateBullet`, CA 81315, 81453)만 있다 | 없음 | 연결 리스트를 따라가는 루프 틀이 없다. 리스트 길이만큼 CRead 와 점프를 직접 짜야 한다. |
| 32비트 읽기·쓰기 | `f_dwread_epd`·`f_dwwrite_epd`·`f_dwadd_epd`, `_cp` 판, `f_dwepdread_epd`(값과 epd 를 한 번에), `_safe` 판 (E/eudlib/memiof/dwepdio.py, cpmemio.py) | — | `CRead`·`f_Read`·`f_EPD`·`SafeReadX`·`CMov`·`TSetMemory` (CA 20158, 36149, 35455, 9137, 20936, 13229) | 있음 | — |
| 바이트·워드·마스크 | `f_bread_epd`·`f_wread_epd`·`f_maskread_epd`·`f_maskwrite_epd`·`f_flagread_epd`·`f_posread_epd`·`f_dwbreak`·`f_readgen_epd` (bwepdio.py, memifgen.py) | — | `f_Bread`·`f_Wread`·`TBread`·`TWwrite`·`MemoryB`·`SetMemoryW`·`SafeReadX(Mask)`·`f_byteConvert` (GB 25장, 3191~3491) | 있음 | `f_posread`(x,y 를 한 번에) 같은 묶음 함수는 CRead 두 번으로 대신한다. |
| 블록 복사·비교 | `f_memcpy`·`f_memcmp`·`f_repmovsd_epd`(E/eudlib/memiof/mblockio.py) | — | `f_Memcpy`·`f_MemcpyEPD`·`f_bytecpy`·`f_bytecmp`·`CA__epdcmp` (CA 33538, 32560, 32865) | 있음 | — |
| 바이트 스트림 | `EUDByteReader`·`EUDByteWriter`·`EUDByteStream`(E/eudlib/memiof/byterw.py:16,87,200), `CPByteWriter`, `EUDVArrayReader` | 위치를 기억하는 커서로 1바이트씩 읽고 쓴다 | `CA__`·`CS__` 글자 단위 편집, `TBread`·`TBwrite` | 부분적 | 위치를 기억하는 스트림 객체가 없다. |
| 임시 메모리 패치 | `f_dwpatch_epd`·`f_blockpatch_epd`·`f_unpatchall`(E/eudlib/utilf/mempatch.py:36,56,89) | 값을 바꿔 두었다가 한꺼번에 원래대로 돌린다(원래 값 스택) | 없음. 바꾸는 액션과 되돌리는 액션을 직접 짝지어 쓴다 | 없음 | 원래 값을 쌓아 두는 스택이 없다. |

### 3.2 수학

| 기능 묶음 | eudplib 대표 API(파일) | 하는 일 | CtrigAsm/TEP 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 곱셈·나눗셈·비트 연산 | `f_mul`·`f_div`(E/core/calcf/muldiv.py:22,41), `f_bitand`~`f_bitrshift`, `f_bitsplit`(bitwise.py:65), `f_div_floor`·`f_div_euclid`·`f_div_towards_zero`(E/eudlib/mathf/div.py:86,184,14) | — | `CMul`·`CDiv`·`CiDiv`·`CMod`·`_And`·`_Or`·`_Xor`·`_lShift`·`_rShift`·`f_Div`·`f_iDiv` (CA 37205, 37606) | 부분적 | 부호 있는 나눗셈은 한 종류(iDiv)뿐이다. floor·euclid 판, 32비트를 한 번에 쪼개는 bitsplit 이 없다. |
| sqrt·atan2·lengthdir | `f_sqrt`, `f_atan2`·`f_atan2_256`, `f_lengthdir`·`f_lengthdir_256` | — | `f_Sqrt`·`f_Atan2`·`f_Lengthdir`·`f_Log2`·`CMathFunc` (CA 35345, 34879, 35153, 34772, 82109) | 있음 | CtrigAsm 입력 범위는 ±32768(GB 2461~2479)이고, 각도 주기는 `Include_CtrigPlib(Cycle)` 로 정한다. log2 와 사용자 수학표(CMathFunc)는 CtrigAsm 에만 있다. |
| 거듭제곱 | `f_pow`(E/eudlib/mathf/pow.py:28) | 런타임에 a^b 계산 | `I64Pow`(CA 60016)는 Lua 가 컴파일 때 계산한다 | 없음 | 지수가 변수인 런타임 루틴이 없다. 곱셈 반복을 직접 짠다. |
| 이진 탐색 | `EUDBinaryMax`·`EUDBinaryMin`(E/eudlib/utilf/binsearch.py:14,58) | 조건을 만족하는 x 의 최댓값·최솟값 | `UnitReadX`(유닛 수 전용, CA 9311) | 부분적 | 임의 조건에 쓰는 틀이 없다. |
| 난수 | `f_rand`·`f_dwrand`·`f_srand`·`f_getseed`·`f_randomize`(E/eudlib/utilf/random.py:67,76,25,10,30) | 시드를 정할 수 있는 선형합동 난수 | `f_Rand`·`_Rand`·`f_LRand`(CA 34586, 68637). 스위치 Random 으로 비트를 만든다 | 부분적 | 시드를 정해서 같은 수열을 다시 뽑을 수 없다. |

### 3.3 문자열·출력

| 기능 묶음 | eudplib 대표 API(파일) | 하는 일 | CtrigAsm/TEP 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 런타임 문자열 저장 | `DBString`(E/eudlib/stringf/dbstr.py:14), `StringBuffer`(strbuffer.py:75), `GetMapStringAddr`, `CPString` | 런타임에 고쳐 쓰는 문자열 | `SaveiStrArr`·`CreateSVA1`·`CreateSVA32`·`f_GetStrptr` (GB 26장) | 있음 | — |
| 형식 문자열 출력 | `f_sprintf`·`f_eprintf`·`f_eprintAll`(E/eudlib/stringf/fmtprint.py:128~143), `f_println`·`f_printAt`(strbuffer.py:523,528), 형식 지정자 `{}`·`{:x}`·`{:c}`·`{:s}`·`{:n}`, `PName`·`PColor`·`epd2s`·`ptr2s`·`hptr` | "점수 {} / 이름 {:n}" 같은 한 줄 출력 | `CAPrint`·`CDPrint`·`CBPrint`·`CSPrint` + `CA__ItoCustom`·`CA__ItoName`·`CA__SetColor`·`ItoDec`·`ItoHex` (CA 56873, 52633; GB 26장) | 부분적 | 형식 문자열을 해석하는 기능이 없다. 자리·색·숫자 칸을 iStr 배열로 미리 짜고 CA__ 함수로 채우므로 줄마다 코드가 길다. |
| 오류줄·특정 줄 출력 | `f_eprintln`·`f_eprintln2`(cpprint.py:325, tblprint.py:105), `DisplayTextAt`(strbuffer.py:37) | — | `C13Print`·`Print_13`(CA 79775, 57574), `CDPrint(Line,…)` | 있음 | — |
| 문자열 함수 | `f_strcpy`·`f_strcmp`·`f_strlen`·`f_strnstr`(E/eudlib/stringf/strfunc.py:16,40,124,131) | 복사, 비교, 길이, 부분 문자열 찾기 | `f_bytecpy`·`f_bytecmp`·`f_Strlen`·`f_Strcat`·`CA__epdcmp`·`TTepdcmp` (CA 49901, 50052) | 부분적 | 부분 문자열 찾기(strnstr)가 없다. 채팅 명령은 고정 위치에서 비교해야 한다. |
| 숫자 파싱 | `f_parse(dst, radix)`(E/eudlib/stringf/parse.py:269) | 문자열을 정수로 바꾼다 | `CD__ScanV`·`CD__ScanW`(CA 54357) | 있음 | CtrigAsm 는 먼저 SVA1(iStr)로 옮긴 뒤 읽는다(`CD__ScanChat` CA 54918). |
| cp949↔utf8 | `f_cp949_to_utf8_cpy`(E/eudlib/stringf/cputf8.py:31), `u2utf8`·`b2u` | 런타임 변환, 컴파일 때 변환 | `CA__Encode`(CA 52514, STRCtrig 필요), `cp949_to_utf8`(Print_utf8X.lua:43) | 있음 | — |
| TBL 편집 | `f_settbl`·`f_settblf`·`f_settbl2`·`GetTBLAddr`(E/eudlib/stringf/tblprint.py:30~89) | 런타임에 stat_txt 문자열을 바꾼다(형식 문자열 포함) | `MakeiTblString`·`GetiTblId`·`f_GetTblptr`(CA 45957, 33924) | 있음 | 형식 문자열이 없는 점은 "형식 문자열 출력" 행과 같다. |
| 글자 효과 | `TextFX_FadeIn`·`TextFX_FadeOut`·`TextFX_SetTimer`·`TextFX_Remove`(E/eudlib/stringf/texteffect.py:339,421,166,246) | 한 글자씩 색이 바뀌며 나타나고 사라진다 | `CDPrint`·`C13Print` 의 사용자 코드 칸(CDfunc), 대기 시간, 마스크(`CD__SetMask` 등, GB 7070~7250) | 부분적 | 타이머·마스크 틀은 있다. 페이드 효과 자체는 사용자가 CD__ 코드로 짜야 한다. |
| 채팅 이름 바꾸기·이름 비교 | `SetPName`·`SetPNamef`(E/eudlib/stringf/pname.py:311,315), `IsPName`(:100) | 채팅줄에 나오는 플레이어 이름을 바꿔 보여 준다 / 이름으로 조건 | 비교는 사용자 `isname.lua`, `GetPlayerName`·`CA__GetName`(CA 57610). 이름 바꾸기 함수는 없다(채팅을 복사하는 `CD__ScanChat`, `ObserverChat.lua` 로 직접 짠다) | 부분적 | 이름을 바꿔치는 루틴이 없다. |
| 클라이언트 언어 판별 | `LocalLocale`(E/eudlib/stringf/locale.py:40, 판별 `_detect_locale` :100) | 클라이언트 언어(한/영 등)에 따라 다른 문자열을 보여 준다 | — | 없음 | 언어를 판별하는 함수가 없다. 판별 주소를 알면 CRead 로 만들 수 있지만, 값이 플레이어마다 달라서 출력에만 써야 한다. |

### 3.4 입력·네트워크·플레이어

| 기능 묶음 | eudplib 대표 API(파일) | 하는 일 | CtrigAsm/TEP 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 로컬 플레이어 | `f_getuserplayerid`·`IsUserCP`(E/eudlib/utilf/userpl.py:24,28) | 이 컴퓨터의 플레이어 번호 | `LocalPlayerID(Player)` 조건(CA 43393, 0x512684 비교) | 있음 | — |
| 관전자까지 출력 | `DisplayTextAll`·`PlayWAVAll`·`CenterViewAll`·`MinimapPingAll`·`TalkingPortraitAll`·`SetMissionObjectivesAll`(userpl.py:43~68) | 관전자를 포함한 모든 화면에 액션을 보낸다 | `CopyCpAction`·`RotatePlayer`(CA 42981, LF 74), `ObserverChat.lua` | 있음 | — |
| QueueGameCommand | `QueueGameCommand(data,size)` 와 `_Select`·`_AddSelect`·`_RightClick`·`_TrainUnit`·`_MinimapPing`·`_PauseGame`·`_ResumeGame`·`_RestartGame`·`_UseCheat`·`_MergeArchon` (E/eudlib/qgcf/qgc.py:67~273) | 게임 명령 패킷 큐에 직접 넣는다. 로컬 값을 모두에게 동기화하고, 플레이어 대신 선택·우클릭·생산·일시정지를 한다 | CtrigAsm Lua 에 없다(0x654880·0x654AA0 참조 0건). 동기화는 eudplib 플러그인 MSQC/NSQC 의 고정 규약으로만 한다 | 없음 | 패킷 버퍼(0x654880)에 가변 길이로 쓰고 길이(0x654AA0)를 고치는 루틴이 없다. 그래서 MSQC/NSQC 가 정한 데스값 규약 밖의 명령(선택, 우클릭 등)은 보낼 수 없다. |
| 플레이어 존재·순회 | `f_playerexist`(E/eudlib/utilf/pexist.py:20), `EUDPlayerLoop`·`EUDLoopPlayer(ptype,force,race)`(:100,50) | 남아 있는 플레이어만 런타임에 돈다 | `PlayerCheck`(CA 45318), `HumanCheck`(LF 336) + Lua for 로 플레이어마다 펼침 | 부분적 | 런타임 루프가 아니라 8벌을 펼친다. |
| 맵 플레이어 정보 | `GetPlayerInfo`(E/core/mapdata/playerinfo.py:62). 맵의 포스·종족·타입을 자동으로 읽는다 | — | `SetForces(...)`·`SetFixedPlayer` 로 직접 적는다(CA 247) | 부분적 | 맵 설정과 다르게 적어도 알아채지 못한다. |
| 게임 틱 | `f_getgametick`(E/eudlib/utilf/gametick.py:16) | 0x57F23C 를 캐시해서 읽는다 | 전용 함수는 없다(`f_Read(FP,0x57F23C,…)` 로 가능). `Timer`(CA 55053) | 부분적 | — |

### 3.5 자료구조

| 기능 묶음 | eudplib 대표 API(파일) | 하는 일 | CtrigAsm/TEP 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 배열 | `EUDArray(크기 또는 초깃값)`(E/eudlib/eudarray.py:61), `EUDVArray(n, basetype)`(E/core/eudstruct/vararray.py:105), `PVariable`(E/eudlib/playerv.py:17) | 초깃값을 넣어 컴파일 때 배치한다. 원소 하나에 4B / 72B | `CArray`·`CDb`·`CVArray`·`CreateVArr`·`CreateArr` + `Arr`·`VArr`·`ConvertArr`·`ConvertVArr`, 파일 삽입형 `f_GetVArrptr`·`f_GetFileVArrptrN`(STRCtrig 필요) (CA 6694, 6687, 6758, 76005, 76110) | 부분적 | CVArray 는 4096칸 미만(GB 969), CArray 는 618496 미만(GB 956)이고 원소 하나가 2408B(0x970)다. 변수 인덱스는 Convert 단계를 거쳐야 한다. CArray 는 런타임에 따로 초기화해야 한다(GB 958). 이 "주소+번호*604" 계산이 적층을 막는다. |
| 큐·덱·스택 | `EUDQueue`·`EUDDeque`(E/eudlib/eudqueue.py:17), `EUDStack`(E/eudlib/eudstack.py:12) | — | `NQueue`·`NDeque`·`NStack`·`NPush`·`NPop`·`NEnqueue`·`NDequeue`(CA 95993, 97209, 95474) | 있음 | v5.5 에 추가됐다. 필드는 1~32개(CA 96643). |
| 오브젝트 풀 | `ObjPool`·`get_global_pool`(E/eudlib/objpool.py:40,108), `EUDStruct.alloc/free` | 구조체를 동적으로 할당하고 반납한다 | 사용자 `TStruct.lua`(`TStruct_init`·`TS_Send`·`TS_Suspend`), `NBag` | 부분적 | TStruct 는 슬롯마다 워커 트리거가 매 틱 평가되고(TStruct.lua 머리말), 필드는 55개까지다(TStruct.lua:77). |

### 3.6 로케이션·그래픽·맵 입출력·보호

| 기능 묶음 | eudplib 대표 API(파일) | 하는 일 | CtrigAsm/TEP 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 로케이션 | `f_setloc`·`f_addloc`·`f_dilateloc`·`f_getlocTL`·`f_setloc_epd`(E/eudlib/locf/locf.py) | — | `SetLoc`·`SetLocX`·`TSetLoc`·`Loc`·`LocX`(CA 43104, 43135), `Simple_SetLoc`·`Simple_CalcLoc`(LF) | 있음 | 로케이션 번호의 0/1 기준 함정(GOT 5절)은 양쪽 모두 해당한다. |
| 와이어프레임 | `SetWireframes`·`SetGrpWire`·`SetTranWire`·`SetWirefram`·`InitialWireframe`·`Is64BitWireframe`(E/eudlib/wireframe/wireframe.py:32~245) | — | `Include_Wireframe`·`ChangeWireframe`·`ChangeGrpwire`·`ChangeTranwire`(CA 101742, 101968) | 있음 | v5.5 에 추가됐다(가이드북 5.4 에는 없다). |
| GRP | `EUDGrp(content)`(E/eudlib/eudgrp.py:15) | 표준 .grp 파일을 메모리에 올려 이미지 교체에 쓴다 | CGRP(CS_Photo.exe 로 변환한 자체 포맷) + `f_GetFileptr` (GB 29장 8314~) | 부분적 | 자체 포맷이고 UnlimiterX 가 필요하다. 표준 GRP 를 그대로 싣지 못한다. |
| MPQ 파일 추가 | `MPQAddFile`·`MPQAddWave`·`MPQCheckFile`(E/maprw/mpqadd.py:51,80,32) | 소리·BGM·임의 파일을 맵 MPQ 에 넣는다 | 없음. `f_GetFileptr`(CA 76815)는 파일 내용을 트리거 페이로드(STRx)에 복사할 뿐 MPQ 파일을 만들지 않는다. BGM 은 에디터 사운드나 eudplib 플러그인(`plugins\bgmplayer.py:47`)으로 넣는다 | 없음 | TEP 와 어셈블러가 MPQ 에 쓰는 API 를 부르지 않는다. |
| 컴파일 시 맵 데이터 편집 | `GetChkTokenized`(E/core/mapdata/mapdata.py:52), `LoadMap`·`SaveMap`, `TBL`(mapdata/tblformat.py), `EncodeWeapon`·`EncodeTech`·`EncodeUpgrade`·`EncodeSprite`·`EncodeImage`…(E/core/rawtrigger/strenc.py), `UnitProperty` | chk 섹션(유닛 설정, 업그레이드, 로케이션 등)을 직접 고친다. 데이터 이름을 번호로 바꾼다 | TEP 는 트리거 상수 이름만 해석한다(`Library\basescript\constparser.lua:478-533`). 나머지는 ScmDraft GUI 와 EUD Editor(원래 eudplib)가 맡는다 | 없음 | Lua 쪽에 chk 섹션을 다루는 API 가 없다. |
| 임의 데이터 삽입 | `Db(bytes)`, `EUDObject` 하위 클래스, `RegisterCreatePayloadCallback` | 임의 바이트나 사용자 객체를 페이로드에 싣는다 | `f_GetFileptr`·`f_GetVoidptr`·`f_GetFileArrptr`(CA 76815, 76544) | 부분적 | STRCtrig 가 필요하고, 크기는 0x970 배수 단위다(GB 8234~8238). |
| 보호(freeze) | euddraft `[freeze]`(`lib\library.zip` 안 `freeze/*`) | 트리거 암호화·난독화 | euddraft 기능이라 CtrigAsm 맵도 켤 수 있다. 단 CPLP 와 함께 쓸 수 없다(GB 138) | 공통 (한도 차이) | freeze 한도는 블록 테이블 4MiB 이고, 원본 chk 한도는 대략 4.09MB÷압축률이다(theSeed ≈75MB, memory `theseed-freeze-limit`). 적층으로 chk 가 작아지면 freeze 를 켤 수 있게 된다. CtrigAsm Db 블롭도 난독화되는지는 확인하지 못했다. |

## 4. euddraft 플러그인 (공통, 차이 아님)

`plugins\` 폴더의 `unlimiter.py`·`unlimiterX.py`·`eudTurbo.py`·`MSQC.py`·`NSQC.py`·`chatEvent.py`·`dataDumper.py`·`bgmplayer.py` 는
eudplib 으로 짜여 있지만 CtrigAsm 맵도 eds 에 넣어 쓰고 있다. 그래서 "eudplib 에만 있는 기능"으로 치지 않았다.
`keySelector` 는 이 설치본(`C:\euddraft0.9.2.0`, VERSION 0.9.10.11)의 plugins 에도, `lib\library.zip` 에도 없다.

## 5. 참고: 반대 방향에서 눈에 띈 것 (다른 담당 몫)

CtrigAsm 에만 있는 것으로 보인 것:

- 64비트 변수 W(GB 22장)
- `KeyPress`·`MousePress`·`IsTyping`(CA 80238, 80283, 80326)
- 총알 생성 `CreateBullet` 류(GB 28장)
- 사용자 수학표 `CMathFunc`
- log2
- 인게임 메모리 뷰어 `Debug.py`
- CB Paint 도형 함수

---

## 6. "CtrigAsm 에 없음" 목록 (맵 제작에 쓸모 있는 순)

1. **사용 안 한 객체 자동 제거**: 루트에서 닿지 않는 함수·변수·데이터를 맵에서 뺀다. CtrigAsm 은 선언한 트리거를 전부 싣고, 참조가 런타임 Label 로 풀려 도달성을 알 수 없다.
2. **새 유닛 순회(`EUDLoopNewUnit`)**와 **스프라이트·총알·임의 리스트 순회(`EUDLoopSprite`·`EUDLoopBullet`·`EUDLoopList`)**: CtrigAsm 에는 연결 리스트 루프 틀이 없다. 맵 코드는 0x628438 으로 한 마리만 잡는다.
3. **QueueGameCommand 계열**: 임의 동기화, 플레이어 대신 선택·우클릭·생산·일시정지. 패킷 큐에 쓰는 루틴이 없고, MSQC/NSQC 고정 규약으로만 동기화한다.
4. **런타임 크래시 위치 추적(`EPS_SetDebug` + `epTrace.exe`)**: CtrigAsm 트리거에는 소스 줄 정보가 없다.
5. **타입 시스템(`EUDTypedFunc`, 필드 타입, `cast`)**: TEP Lua 태그 테이블에 타입 정보가 없다.
6. **함수별 트리거 수 측정(`EUDFuncN.size()`)**: 용량 최적화 도구. tepc 출력에는 함수 경계가 없다.
7. **MPQ 파일 추가(`MPQAddFile`·`MPQAddWave`)**: 소리·BGM 은 에디터나 eudplib 플러그인에 기대야 한다.
8. **컴파일 시 chk·데이터 편집(`GetChkTokenized`, `EncodeWeapon` 등 이름→번호)**: Lua 쪽 API 가 없다.
9. **임시 메모리 패치와 일괄 원복(`f_dwpatch_epd`·`f_unpatchall`)**: 원래 값 스택이 없다.
10. **메서드(`EUDMethod`)**: SV 가 칸 묶음이라 메서드를 붙일 대상이 없다.
11. **클래식 TRIG 인라인·공유(`PRT_SetInliningRate`)**: Label 자기수정 때문에 어셈블러가 끈다.
12. **한 틱 양보(`EUDDoEvents`)**: 매 사이클 위→아래 구조라 상태 변수로 나눠야 한다. 흐름 전체가 멈추는 방식이라 실사용은 드물다.
13. **런타임 거듭제곱(`f_pow`)**
14. **클라이언트 언어 판별(`LocalLocale`)**
15. **TRIG 실행 시점 이동(`RunTrigTrigger`)**
16. **주소 섞기(`ShufflePayload`)**

## 7. "부분적" 목록 (중요한 순)

1. **트리거 적층**: 원본에는 없다. 사용자 포크 Stack.py lean 이 레코드 58%를 적층하지만, "주소+번호*604" 구간은 원래 자리에 두고 검증률은 절반이다.
2. **변수·점프 표 크기**: eudplib 은 72B·20B/항목, CtrigAsm 은 2400B/트리거다(VarStack 포크로 변수만 72B). 밀집 저장(Ccode·Void)은 칸 수 한도가 있다.
3. **함수(CFunc)**: 인자 수가 맵 전체 상한 하나(기본 16)다. 호출하는 곳마다 마샬링 트리거 2~4개(eudplib 1개).
4. **유닛 순회(CunitCtrig)**: 트리거 1700개로 펼친다(한 번에 약 4MB). 플레이어별 리스트 순회가 없다.
5. **배열**: CVArray 4096칸 미만, CArray 618496 미만, 원소 하나 2408B. 변수 인덱스는 Convert 단계가 필요하고 초깃값은 런타임에 넣는다.
6. **구조체(SV)**: 칸 번호로만 접근한다. 필드 이름·타입·중첩·생성자와 할당·반납이 없다(풀은 TStruct 사용자 라이브러리).
7. **형식 문자열 출력**: `f_sprintf` 에 해당하는 것이 없다. CAPrint 계열로 iStr 을 미리 짜야 한다.
8. **식 문법**: `_Add` 1번 인자가 상수면 오류다. 메타테이블은 왼쪽이 임시식이면 실패한다. 복합 대입은 함수 호출 모양이다.
9. **제어문**: break/continue 가 없다. C 블록은 점프로 탈출할 수 없다. 점프 번호는 0~0xFFF, CLoop 는 상수 횟수만 된다.
10. **컴파일 시 주소**: 원본은 맵 시작 때 재배치한다(시작 비용 큼). 포크가 컴파일 때로 옮겼다.
11. **플레이어별 트리거**: TEP 는 플레이어 수만큼 복제한다(N배 용량).
12. **모듈**: 전역이 하나이고 로드 순서에 의존한다(나중 정의가 이긴다).
13. **CUnit 멤버**: 숫자 오프셋을 직접 쓴다.
14. **오류 메시지**: Lua 오류 위치가 라이브러리 안쪽이다. 경고가 없다.
15. **난수**: 시드를 정하거나 수열을 재현할 수 없다.
16. **짧은 회로·삼항**: `_TOR`/`_TAND` 는 CStruct 조건 안에서만 된다. 단락 평가 여부는 미확인이고 삼항식은 없다.
17. **UnitGroup·오브젝트 풀**: NBag·TStruct 는 죽음 처리를 직접 짜고 상시 평가 비용이 든다.
18. **그 밖의 작은 차이**
    - 채팅 이름 바꾸기
    - 글자 페이드 효과
    - strnstr
    - 나눗셈 변형(floor·euclid)과 bitsplit
    - 범용 이진 탐색
    - 플레이어 런타임 루프(8벌 펼침)
    - 맵 플레이어 정보 직접 입력(SetForces)
    - 바이트 스트림 객체
    - 표준 GRP(CGRP 자체 포맷)
    - 임의 데이터 삽입(STRCtrig 필요, 0x970 단위)
    - 게임 틱 전용 함수
    - 다중 대입

## 8. 확인 못 한 것

- **빌드 속도**: 같은 맵을 두 경로로 빌드해 잰 수치가 없다.
- **`_TOR`/`_TAND` 단락 평가**: 뒤 조건을 건너뛰는지 소스를 따라가 보지 않았다.
- **freeze 난독화 범위**: CtrigAsm 이 Db 로 싣는 TRIGP 블롭에도 난독화가 걸리는지 모른다(freeze 는 컴파일된 pyc 뿐이다).
- **`EUDDoEvents` 동작**: 플러그인 본문 중간에서 부르면 euddraft 메인 루프가 그 틱의 TRIG 실행을 건너뛰는지는 `applyeuddraft.pyc` 를 보지 않았다. `DPS_eud\eud\DESIGN.md` 3절의 실행 순서로 추정했다.
- **epScript 문법**: 컴파일러가 dll(`libepScriptLib.dll`)이라 문법 목록은 `E/epscript/helper.py`, EB 1절 대응표, 알려진 문법에서 옮겼다.
- **keySelector 등**: 이 설치본에 없는 euddraft 내장 플러그인은 확인하지 못했다.
- **v5.5 추가 함수**: 가이드북 5.4 이후에 들어온 CtrigAsm v5.5 함수(NSwitch, NBag 계열, ChangeWireframe 등)는 설명서 없이 소스 머리 부분만 보고 판정했다.
- **LocalLocale 주소**: 판별에 쓰는 메모리 주소는 확인하지 않았다.
