# A1 — CtrigAsm 가이드북 D장 1~14장 + 부록 H·I·J·K·L ↔ eudplib 0.76.14 기능 비교

- 범위: `Ctrig Assembler v5.4 Guide Book.txt` 473~2537줄(1~14장), 27560~28491줄(H~L).
- 동작 확인: `CtrigAsm v5.5.lua`(아래 **CA:줄**). 이미 있는 명세 `DPS_eud\eud\spec\G1~G9` 의 판단은 그대로 가져다 썼다(표에 `G2 1.8` 처럼 적음).
- eudplib 경로는 `C:\Users\whatd\.venvs\eud076\Lib\site-packages\eudplib\` 기준 상대 경로다(`파일:줄`). 소스에서 확인하지 못한 것은 "(추측)", 더 새 판에만 있다고 알고 있는 것은 "(최신판, 추측)"으로 표시했다.
- 판정 기호
  - **동등**: eudplib 에 같은 일을 하는 API 가 있다.
  - **대체**: 다른 방식으로 같은 결과를 낸다.
  - **불필요**: eudplib 구조에서는 필요 없는 기능이다.
  - **없음**: 직접 짜야 한다(난이도 상/중/하).
  - **흉내 어려움**: eudplib 모델로 옮기기 곤란하다.

---

## 0. 표를 읽기 전에 알아 둘 구조 차이

1. **저장 위치와 주소를 찾는 방법이 다르다.**
   - CtrigAsm 의 변수·배열·함수 몸체는 TRIG 단락 트리거 안에 있다. 트리거에는 라벨 번호가 붙는다. 어셈블러 플러그인(`Ctrig/STRCtrig Assembler v5.5.py`)이 게임 시작 때 그 번호를 실제 주소로 푼다.
   - eudplib 는 payload(`Db`, `EUDObject`)에 올리고, 주소는 `ConstExpr`/`Forward` 로 컴파일할 때 정해진다.
   - 그래서 **라벨, 번호 할당기, 주소 변환 함수는 대부분 필요 없다.**
2. **변수의 모양은 사실상 같다.**
   - 둘 다 "SetDeaths 류 액션 하나를 가진 트리거"이고, 값 칸이 **트리거 + 0x15C** 에 있다. eudplib 쪽 근거는 `EUDVariable._varact = vt + 8 + 320` 과 `getValueAddr = _varact + 20` 이다(core/variable/eudv.py:170,181).
   - 차이는 크기다.
     - CtrigAsm: 변수 1개 = 트리거 1개(2408B), VArray 원소 간격 0x970.
     - eudplib: 72B 씩 겹쳐 놓는다(core/variable/vbuf.py "72 bytes per variable").
   - 둘 다 기본 대상이 EPD 0 = **P1 마린 데스(0x58A364)** 다(vbuf.py 초기 바이트 `\0\0\x2D\x07`, player 0). 그래서 가이드 B-6 주의("0x58A364 값이 임의로 바뀔 수 있음")는 eudplib 에서도 그대로 유효하다.
3. **트리거 레이아웃 오프셋이 같다.**
   - +4 next, +8+0x14·i 조건, +0x148+0x20·i 액션, +0x948 내부 플래그는 두 쪽이 같다.
   - eudplib 근거: `SetNextPtr` = trg+4(core/rawtrigger/stockact.py:859), `EUDExecuteOnce` 가 +2376(=0x948)을 쓴다(ctrlstru/simpleblock.py:137).
   - 그래서 CAddr 의 오프셋 지식은 eudplib 에서도 그대로 쓸 수 있다.
4. **실행 주체가 다르다.**
   - CtrigAsm 트리거는 P1~P8 목록에 실린다. SC 는 플레이어마다 CP 를 바꿔 가며 실행한다.
     - Force·AllPlayers 트리거는 한 프레임에 여러 번 돈다.
     - 변수·배열도 플레이어별 사본이 생긴다(`V(i,"X")` = 현재 플레이어의 사본).
   - eudplib 메인 루프는 프레임당 1회만 돈다.
     - 플레이어별 반복: `EUDPlayerLoop`/`EUDLoopPlayer`(eudlib/utilf/pexist.py:100,50)
     - 플레이어 조건 트리거: `PTrigger`(trigger/ptrigger.py:31)
     - 플레이어별 저장소: `PVariable`(eudlib/playerv.py), 또는 8배 크기 배열
5. **코드를 공유하는 방식이 다르다.**
   - CtrigAsm 은 C 매크로(CMul/CDiv/CRead…)를 **호출할 때마다 인라인으로 펼친다**. f_ 함수는 Include 로 몸체 1벌을 두고 호출한다.
   - eudplib `EUDFunc`(core/eudfunc/eudf.py:50)는 처음 호출될 때 몸체 1벌을 만든다. 상수 곱·나눗셈도 상수마다 EUDFunc 를 캐시한다(core/calcf/muldiv.py `_const_mul`/`_const_div`).
6. **변수 삽입(T)과 임시식(_)**
   - eudplib 의 `Trigger`/`DoActions`/`EUDIf`/`EUDBranch` 는 조건·액션 칸에 들어온 `EUDVariable` 을 앞 트리거에서 채워 넣는다(trigger/tpatcher.py:89 `patch_condition`, `apply_patch_table`).
   - `a + b*c` 같은 식은 그 자리에서 임시 변수로 계산된다.
   - 단, `RawTrigger` 는 상수만 받는다(core/rawtrigger/action.py:159 `CheckArgs`).
7. **CP 관리가 다르다.**
   - CtrigAsm 은 `RecoverCpValue` 수동 규약을 쓴다.
   - eudplib 은 **CP 캐시**를 쓴다(eudlib/memiof/modcurpl.py `f_setcurpl`/`f_getcurpl`/`f_setcurpl2cpcache`). `SetMemory(0x6509B0, …)` 로 CP 를 직접 쓰면 캐시가 어긋난다(G7 1.2.5).

---

## 1장 — 맵 정보 입력

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 0.76.14 대응(파일) | 판정 | 비고 |
|---|---|---|---|---|---|
| 세력 구성 입력 | `SetForces` (CA:247) | Force1~4·AllPlayers 에 속한 플레이어를 손으로 입력한다(CForce 표). PlayerConvert 가 이 표를 쓴다. | 맵에서 자동으로 읽는다: `GetPlayerInfo(p).force`(core/mapdata/playerinfo.py:62). 이 정보를 `PTrigger`(trigger/ptrigger.py:31), `EUDLoopPlayer(ptype, force, race)`(eudlib/utilf/pexist.py:50)가 쓴다. | 불필요 | CtrigAsm 은 손으로 넣은 값이 맵과 다르면 틀린 코드를 만든다. |
| 고정 플레이어 | `SetFixedPlayer` (CA:243) | 공용 변수·레지스터·함수 몸체를 실을 "나가지 않는 플레이어"(FixPlayer)를 정한다. | eudplib 메인 루프는 플레이어가 나가도 매 프레임 1회 돈다. | 불필요 | "트리거 소유자 = FP" 규약 자체가 필요 없다. |

## 2장 — CtrigAsm 설치

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 0.76.14 대응(파일) | 판정 | 비고 |
|---|---|---|---|---|---|
| 적용 구간 시작/끝 | `StartCtrig` (CA:503), `EndCtrig` (CA:658) | 어셈블러 적용 구간을 표시한다. 공용 레지스터(CRet/NRet/WRet/SRet)와 CFunc 인자·스택 변수를 선언하고, `Include_Last` 로 공유 루틴을 내보낸다. | euddraft 플러그인 진입점 `onPluginStart`/`beforeTriggerExec`/`afterTriggerExec`(euddraft 규약), `EUDOnStart`(maprw/injector/mainloop.py:29) | 불필요 | "각 1회만 사용", "구간 밖은 어셈블러 미적용" 같은 제약이 없다. |
| 옵션 STRX | `StartCtrig(1,…)` | 맵 스트링 단락을 STR 로 볼지 STRx 로 볼지 알려 준다. | eudplib 이 단락을 직접 판별한다(`get_string_section_name`, eudlib/stringf/cpstr.py:31). | 불필요 | |
| 옵션 IncludePlayer | `StartCtrig(_,P)` | 호출형 함수 몸체를 실을 플레이어를 정한다. | EUDFunc 몸체는 payload 에 들어간다. | 불필요 | |
| 옵션 NSQC | `StartCtrig(_,_,n)` → NSQCVArray | 비공유 데이터(로컬 값)를 동기화하는 배열을 만든다. | eudplib 생태계(`NSQC.py`, `MSQC.py` 플러그인 — `MapSource\Py`, `C:\euddraft0.9.2.0\plugins`), eudplib 자체 `QueueGameCommand*`(eudlib/qgcf/qgc.py) | 대체 | 자세한 비교는 27장 담당. |
| 옵션 STRCTRIG | `StartCtrig(_,_,_,1)` | STRCtrig 어셈블러(트리거를 STR 쪽으로 옮김)를 쓴다고 표시한다. | 코드는 payload 에 실린다. | 불필요 | TRIG 트리거 수·블록 테이블 한도를 피하려고 생긴 옵션이다. |
| 옵션 AbsolutePath | `StartCtrig(…, path)` → `SetFileDirectory` | 파일 입출력(CSSave, File I/O)의 경로를 정한다. | 파이썬 `open()`/`os.path`(컴파일 시), `MPQAddFile`(maprw/mpqadd.py) | 대체 | 29장 담당. |
| 옵션 CFunc/CStack/LStack | `StartCtrig(…,16,64,32)` | CFunc 인자 최대 수, 32비트·64비트 호출 스택 크기를 정한다. | EUDFunc 인자 수 = 파이썬 시그니처(제한 없음). 스택은 `EUDStack(size)`(eudlib/eudstack.py:12)를 직접 선언한다. | 불필요 | CFunc·CPush 본체는 21장 담당. |
| 클래식 트리거와 공존 | StartCtrig 구간 밖 트리거 | 일반 트리거(EUD Editor, EudTurbo 등)를 함께 둔다. | euddraft 가 맵의 클래식 트리거를 그대로 둔다. 필요하면 `TrigTriggerBegin/End`·`RunTrigTrigger`(trigtrg/runtrigtrg.py:33)를 쓴다. | 동등 | EUDTurbo 는 euddraft `eudTurbo.py` 플러그인이다. |

## 3장 — 기본 내장 조건/액션 (.Py 직접 연동)

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 0.76.14 대응(파일) | 판정 | 비고 |
|---|---|---|---|---|---|
| 트리거 식별자 | `Label(Index)` | 0x0~0x1FFFF 번호를 붙여 런타임에 주소를 찾게 한다. 첫 조건에 넣어 "Ctrig 조건/액션 사용 트리거"라고 표시한다(B-12). | 트리거 객체 자체가 주소(ConstExpr)다: `RawTrigger`, `NextTrigger()`(core/rawtrigger/triggerscope.py:41), `Forward()`(core/allocator/constexpr.py:16) | 불필요 | 라벨 중복, `Label(0)` 누락 같은 버그가 원천적으로 없다. |
| 트리거 메모리 조건 | `CtrigX(P,Idx,Addr,Next,Type,Val,Mask)` | 라벨로 찾은 트리거의 +Addr 칸을 MemoryX 로 검사한다. | `MemoryX(trg + off, cmp, v, mask)`(core/rawtrigger/stockcond.py). `Condition`/`Action` 객체도 ConstExpr 이라 `act + 20` 같은 식을 쓸 수 있다(core/rawtrigger/condition.py:49, action.py:84). | 대체 | `"X"`(CurrentPlayer 의 사본) 개념은 없다 → 0절 4. |
| 트리거 메모리 쓰기(자기수정) | `SetCtrigX`, `SetCtrig1X`, `SetCtrig2X` | 트리거 A 의 칸에 상수나 트리거 B 의 주소(Offset/EPD)를 쓴다. | `SetMemoryX(trg+off, mod, other+off2 또는 EPD(other+off2), mask)`, `SetNextPtr(trg, dst)`(stockact.py:859), `EPD()`(utils/etc.py:19) | 대체 | eudplib 라이브러리 내부도 같은 기법을 쓴다(예: simpleblock.py `EUDExecuteOnce`, mathf/div.py `_div_floor`). |
| 표식 풀이(재배치) | 어셈블러 플러그인 `Ctrig/STRCtrig Assembler v5.5.py` | 위 표식 값을 게임 시작 때 실제 주소로 바꾼다. | payload 재배치(maprw/injector/payload_reloc.py, `PRT_SkipPayloadRelocator`) | 불필요 | 가이드 B-3 의 "euddraft 인라이닝 비호환(`PRT_SetInliningRate(0)` 강제)" 제약이 없다(maprw/inlinecode/ilcprocesstrig.py:29). |

## 4장 — 기본 오류 체크

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 0.76.14 대응(파일) | 판정 | 비고 |
|---|---|---|---|---|---|
| 문법 검사 | `ErrorCheck` = `AllocCheck`/`LabelCheck`/`ControlCheck` (CA:2166~2240) | 번호 넘침, 라벨 중복, 제어문 짝을 검사한다. | 블록 짝은 자동으로 검사된다: `EUDPopBlock` assert(utils/blockstru.py:71), 함수 끝 검사 "Block start/end mismatch inside function"(core/eudfunc/eudfuncn.py:123). 번호·라벨은 없다. | 불필요(자동) | EndCtrig 아래에 따로 부를 필요가 없다. |
| 사용자 오류 띄우기 | `PushErrorMsg` (CA:60044) | 존재하지 않는 전역을 불러 TEP 오류창을 띄운다. | `raise EPError(...)`, `ep_assert`, `ep_warn`(utils/eperror.py:13,25) | 동등 | |
| CP 변경 감지 | `PushRecoverCpMsg` (CA:60048) | 이후 RecoverCp 가 만들어지면 컴파일 오류를 낸다. | 대응 없음. CP 캐시가 복구를 맡는다. | 불필요 | CP 를 직접 쓰는 곳을 잡아 주는 검사기는 없다(추측). |
| 컴파일 시 값 출력 | `PushValueMsg(...)` (CA:60056) | **Lua 값**(숫자·문자열·표)을 오류창에 출력한다. 런타임 값이 아니다. | 파이썬 `print()`, `ep_eprint`(utils/eperror.py) | 동등 | 런타임 값 출력은 eudplib `f_eprintf`/`f_sprintf`(eudlib/stringf/fmtprint.py:128,138), `EUDTraceLog`(core/eudfunc/trace/tracetool.py:97)가 한다. CtrigAsm 쪽은 `Debug.py` 플러그인이 한다(C절). |

## 5장 — 표준 입출력·변환

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 0.76.14 대응(파일) | 판정 | 비고 |
|---|---|---|---|---|---|
| 트리거 칸 이름표 | `CAddr(Section,Line,Next)` | `"Value",3,1` → 0x19C+0x970 처럼 칸 이름을 오프셋으로 바꾼다. | 이름표 함수는 없다. 레이아웃이 같으므로(0절 3) 상수를 직접 쓴다. | 대체 | 한 줄짜리 도우미로 충분하다. |
| 데스값 주소 | `DtoA(P, unit)` (CA:2397) | 0x58A364 + 4·(P + 12·unit) 을 돌려준다. | 전용 함수는 없다 → `0x58A364 + 4*(EncodePlayer(p) + 12*EncodeUnit(u))`(core/rawtrigger/constenc.py:391). EPD 로는 `p + 12*u`. | 대체 | |
| 제어문 번호 미리 보기 | `Forward(Move)`, `Struct(Type,N)` (CA:2403,2411) | 뒤에 올 CStruct 의 IndexAlloc 번호를 미리 계산한다(앞으로 점프할 때 씀). | eudplib `Forward()` 는 **이름만 같고 뜻이 다르다**(아직 정해지지 않은 주소). 앞으로 점프하려면 `Forward` 를 만들어 두고 나중에 `<<` 로 채운다. | 불필요 | 이름이 겹치니 주의한다. |
| 변수 참조 | `V(Index,P,Next)`, `X(t)`, `Vi(Index,dev)` | 변수 테이블 `{P,Index,Next,"V"}`. Vi 는 값 + 상수 편차다. | `EUDVariable` 객체를 참조한다. 편차는 `v + k` 식으로 쓴다(조건 칸 `Memory(addr, AtLeast, v + k)`도 가능). | 대체 | 비용 차이: Vi 는 패치 값에 편차를 얹으므로 추가 트리거가 0개다. eudplib `v + k` 는 임시 변수에 복사하고 더한다(액션 몇 개). |
| 확장 데스 칸 번호 | `Ccode(Index,Line)` (CA:2425) | 변수 트리거 한 개 안의 480칸(N 은 60칸) 중 한 칸의 번호를 만든다. | 칸마다 `EUDVariable`/`EUDLightVariable`(core/variable/eudlv.py:14)을 선언하거나 `EUDArray` 를 쓴다. | 불필요 | 트리거 수를 아끼려고 생긴 장치다. |
| Ctrig 메모리 주소 핸들 | `Mem`, `_Mem`, `_Ccode`, `_Ncode` | 트리거 칸 주소를 값 또는 EPD 형식으로 만든다. | `v.getValueAddr()`(core/variable/eudv.py:181), `getDestAddr`/`getMaskAddr`(:175,178), `EPD(...)` | 대체 | |
| 메모리 배열 원소 | `Arr`, `ArrX`, `ConvertArr` | 상수 인덱스는 주소로 바꾼다. 변수 인덱스는 `((i+Vi)/301)&~1` 로 바꾸고 0x968/0x96C 칸을 건너뛴다. | `EUDArray`(eudlib/eudarray.py:61): `arr[i]`, `arr[i] = v`, 주소 `arr + 4*i`, `EPD(arr) + i` | 동등(ConvertArr 는 불필요) | CtrigAsm 배열은 트리거 몸체 안에 있어서 602칸마다 빈 칸을 건너뛰는 계산이 필요했다. |
| 변수 배열 원소 | `VArr`, `VArrX`, `ConvertVArr` | 인덱스를 `(i)*604`(epd), `(i)*2416`(offset)로 바꾼다. | `EUDVArray(n)`(core/eudstruct/vararray.py:105): `va[i]`, `va[i] = v`, `iadditem`/`eqitem`… | 동등(Convert 는 불필요) | 원소 간격이 0x970 대 72B 로 다르다. "번호×604" 산술은 옮기면 깨진다(G6 1.9·1.10). 원소 값 칸은 `EPD(va) + 18*i + 87`(vararray.py:270). |

## 6장 — 변수/배열 선언·호출

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 0.76.14 대응(파일) | 판정 | 비고 |
|---|---|---|---|---|---|
| 변수 선언 | `CVariable(P,Index)` | 라벨 번호로 변수 트리거를 만든다. P 가 Force 면 플레이어마다 사본이 생긴다. | `EUDVariable()`, `EUDCreateVariables(n)`(core/variable/eudv.py) | 동등 | 플레이어별 사본은 `PVariable`(eudlib/playerv.py)로 대체한다. |
| 초기 대상·연산·값·마스크 지정 | `CVariable2(P,Idx,Offset,Type,Value,Mask)` | 변수 트리거의 초기 액션을 정한다. | `EUDVariable(epd, modifier, initval, nextptr=)`(core/variable/eudv.py:151). 마스크는 `EUDXVariable`(core/variable/eudxv.py:14). | 동등 | |
| 바이트/dword 배열 | `CDb(P,Bytes)`, `CArray(P,Size)` (CA:6687,6694) | 트리거 몸체를 배열로 쓴다. 최대 4096×602칸이고, **초기값이 0 이라는 보장이 없다**. | `EUDArray(크기 또는 초기값 목록)`, `Db(bytes)`(core/eudobj/bytedump.py:14) | 동등 | eudplib 은 0 이나 지정값으로 초기화된다. 크기 한도는 payload 뿐이다. |
| 변수 배열 | `CVArray(P,Size)` (CA:6758) | 최대 4095개. | `EUDVArray(size)(initvars, dest=, nextptr=)` | 동등 | eudplib 한도는 2^28(vararray.py:106). |
| 연속 변수를 배열로 묶기 | `GetVArray(V,Size)` (CA:3162) | 따로 선언한 연속 CVariable 을 VArray 로 다룬다. | `EUDVArray(n)(_from=주소)`(vararray.py:118)로 주소를 감쌀 수는 있다. 하지만 따로 만든 `EUDVariable` 들이 연속으로 놓인다는 보장이 없다 → 처음부터 EUDVArray 로 선언한다. | 대체 | 기존 코드를 옮길 때는 흉내 어려움 목록 1 참고. |
| 변수 트리거 호출 | `CallLabel1/2`, `CallLabelAlways(2~4,N)`, `CallVariable`, 각 `…X` (CA:6120~6360) | 변수(또는 라벨 트리거)로 갔다 돌아오며 그 액션(=대입)을 실행한다. 1/2 쌍은 조건부 호출이다. | `VProc(v 또는 [v1, v2, …], actions)`(core/variable/eudv.py:701) — 여러 변수를 한 번에 체인으로 호출한다. | 동등 | 조건부 호출은 `EUDIf` 로 감싼다. "CallLabelAlways 트리거의 조건은 Label(0) 하나뿐" 같은 제약이 없다. |

## 7장 — DoActions류 트리거 생성

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 0.76.14 대응(파일) | 판정 | 비고 |
|---|---|---|---|---|---|
| 조건 없는 액션 트리거 | `DoActions`, `DoActions2` | 액션 64개 제한(DoActions) / 무제한(64개마다 이어 붙임) | `DoActions(*acts, preserved=)`(ctrlstru/basicstru.py:14) → `Trigger` 가 64개를 넘으면 자동으로 나눈다(trigger/triggerdef.py:22). | 동등 | |
| 액션 무제한 트리거 | `Trigger2` | 조건 16개, 액션 무제한 | `Trigger(conds, acts, preserved)` — 조건도 16개를 넘을 수 있다. | 동등 | |
| Ctrig 조건/액션 허용 트리거 | `TriggerX`, `DoActionsX`, `Trigger2X`, `DoActions2X` | Label(Index) 를 붙인다. | `Trigger`/`RawTrigger` 에는 구분이 없다. | 불필요 | |
| 변수 삽입(T) 허용 트리거 | `CTrigger`, `CDoActions`(+`CTriggerX`/`CDoActionX`/`2X`) | T 조건·액션을 앞 트리거에서 풀어 준다. | `Trigger`/`DoActions`/`EUDIf` 의 tpatcher(trigger/tpatcher.py:89) | 동등 | TT(조건 결과 계산) 비교는 16·17장 담당. |
| 트리거를 실을 플레이어 | 거의 모든 함수의 `PlayerID` | 그 플레이어 목록에 트리거를 싣는다. | `PTrigger(players, conds, acts)`(trigger/ptrigger.py:31): CP 가 해당 플레이어일 때만 실행한다. `EUDPlayerLoop` 과 함께 쓴다. | 대체 | 0절 4 참고. |
| 1회 / 보존 | `flag`/`Flags` 인자 | Preserved 여부 | `preserved=False` | 동등 | |

## 8장 — Ctrig 파생 조건/액션

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 0.76.14 대응(파일) | 판정 | 비고 |
|---|---|---|---|---|---|
| next 바꾸기 | `SetNext(I1,I2,Next)` (CA:7263) | 라벨 I1 의 next 를 I2(+Next) 로 바꾼다. | `SetNextPtr(trg, dst)` | 동등 | |
| Mem 조건/액션 | `MemX`, `SetMemX` | Mem 핸들로 MemoryX/SetMemoryX 를 만든다. | `MemoryX(addr,…)`, `SetMemoryX(addr, mod, value, mask)`, `MemoryXEPD`/`SetMemoryXEPD` | 동등 | |
| 변수 트리거 부위 조작 | `VariableX`/`SetVariableX`/`Variable`/`SetVariable` (Section: EPD·Value·Next·Mask·Type·Flag) | 변수 트리거의 대상·값·next·마스크·연산·플래그 칸을 비교하거나 쓴다. | 대상 `SetDest/AddDest/SetDestX`, 마스크 `SetMask…`/`MaskAtLeast…`, 연산 `SetModifier`(core/variable/eudv.py:202~290), 값 `AtLeast/SetNumber…`. Next·Flag 칸은 전용 API 가 없다 → `SetMemory(v.GetVTable()+4, …)`, `SetMemoryX(v._varact + 28, …)`. | 동등(Next·Flag 는 대체) | |
| 변수 값 조건/액션 | `CVar`/`SetCVar`/`NVar`/`SetNVar` | 값 칸을 비교하거나 설정한다. | `v.AtLeast/AtMost/Exactly`, `v.SetNumber/AddNumber/SubtractNumber`, `…X`(core/variable/vbase.py:31~70), 연산자 `== <= >= < >` | 동등 | `v > 0xFFFFFFFF`, `v < 0` 경계에 주의한다(G1 1.11). |
| 변수 배열(상수 인덱스) 조건/액션 | `VArrayX`/`SetVArrayX`, `CVAar`/`SetCVAar` | VArr 원소 칸을 비교하거나 쓴다. | `va.eqitem/leitem/geitem/ltitem/gtitem`, `va[i] = …`, `va.iadditem`(vararray.py:374~901) | 동등 | "Type" 같은 부위 선택은 주소 계산으로 대체한다. |
| 확장 데스값 | `CDeaths(X)`/`SetCDeaths(X)`, `NDeaths(X)`/`SetNDeaths(X)` (CA:9102~) | 변수 트리거 칸을 데스값처럼 쓴다. N 계열은 플레이어가 고정이다. | `EUDVariable`/`EUDLightVariable` 의 `AtLeast…`/`SetNumber…`(마스크는 `…X`). 비트 플래그는 `EUDLightBool`(core/variable/eudlv.py:29). | 동등 | |

## 9장 — Cp트릭·CunitCtrig

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 0.76.14 대응(파일) | 판정 | 비고 |
|---|---|---|---|---|---|
| CP 복구 | `RecoverCp`, `SetRecoverCp` (CA:5533) | 규약값(CurrentPlayer/상수/변수)으로 CP 를 되돌리는 트리거를 만든다. | `f_setcurpl(cp)`, `f_setcurpl2cpcache()`(eudlib/memiof/modcurpl.py:16,37). eudplib 의 `_epd` 읽기·쓰기 함수는 끝에서 스스로 CP 를 복구한다. | 대체 | 규약값이 빌드 시점 전역이라 생기는 실수(G7 1.2.3)가 없다. |
| CP 이동 | `MoveCp(Type,Value)` | 누적 이동량을 추적(컴파일 시)하며 Add/Subtract/SetTo 액션을 만든다. | `SetCurrentPlayer`, `AddCurrentPlayer`(패키지 최상위), `f_addcurpl(v)`(modcurpl.py:79) — 캐시가 이동량을 추적한다. | 동등 | |
| CP 저장/복원 | `SaveCp`, `LoadCp`, `LoadCpX` (CA:5685) | CP(EPD/Offset)를 변수에 백업하고 되돌린다. | `cp = f_getcurpl()`(modcurpl.py:63), `f_setcurpl(cp)` | 동등 | |
| 유닛 1700 슬롯 루프 | `CunitCtrig_Part1/2/3`, `Part3X/4X/End`, `ClearCalc`, `BreakCalc` (CA:5692~5850) | 0x628298 부터 0x150 씩 줄여 가며 1700 슬롯을 돈다. **슬롯마다 트리거 1개씩 펼쳐** 조건이 맞는 슬롯에서 CP=유닛 EPD 로 연산 단락을 실행하고, Clear/Break 로 복귀한다. | `EUDLoopUnit2()`, `EUDLoopCUnit()`(eudlib/utilf/listloop.py:130,179, 1700 슬롯 순회), `EUDLoopUnit()`(연결 리스트), `EUDLoopPlayerUnit(p)`, `EUDLoopNewUnit()`. 탈출은 `EUDBreak`/`EUDContinue`(ctrlstru/breakcont.py). | 동등(방식 차이) | **용량**: Part3 은 트리거 1700개(개당 2408B, 합계 약 4MB)를 한 번에 깔고, 슬롯마다 트리거 1개를 실행한다. eudplib 은 루프 몸체 1벌(트리거 몇 개)을 두고 슬롯마다 여러 트리거를 실행한다. CP 기준으로 읽으려면 `f_setcurpl(epd)` 뒤 `*_cp` 함수를 쓰거나 `CUnit`(offsetmap/cunit.py:89)을 쓴다. |

## 10장 — 제어문 (CStruct)

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 0.76.14 대응(파일) | 판정 | 비고 |
|---|---|---|---|---|---|
| 무조건 점프 | `CJump/CJumpEnd`, `CJumpX/CJumpXEnd` | 쌍 번호(sIndex 0~0xFFF)로 앞이나 뒤로 점프한다. X 판은 출발점이 여러 개다. | `EUDJump(target)`(ctrlstru/basicstru.py:18), 목적지는 `Forward()`/`NextTrigger()` | 동등 | 번호가 아니라 파이썬 객체라 개수 제한(0xA00)이 없다. |
| 런타임 점프 조작 | `SetCJump(sIndex,Status,NewDest)` (CA:7271) | 점프를 켜고 끄거나 목적지를 바꾼다. | `SetNextPtr(jumptrg, dst)` 액션. 목적지가 변수면 `EUDJump(var)`(basicstru.py:19 변수 분기). | 대체 | |
| 조건 점프 | `NJump/NJumpEnd`, `NJumpX/NJumpXEnd` | 조건을 만족하면 액션을 실행하고 점프한다. | `EUDJumpIf(conds, target, _actions=)`, `EUDJumpIfNot`(basicstru.py:27,33), `EUDBranch`(trigger/branch.py:46) | 동등 | |
| 초소형 반복 | `SLoopN(P,Repeat,Cond,Act,Init,Single)`/`SLoopNEnd` (CA:9768) | 상수(≤500000) 또는 변수(V/4) 횟수만큼 반복한다. Single=1 이면 트리거 하나가 next 를 자기 자신으로 돌려 반복한다. | `EUDLoopN()(n)`(ctrlstru/loopblock.py:50 — n 을 RawTrigger 에 넣으므로 상수 전용으로 보임). 변수 횟수는 `EUDLoopRange(n)`(loopblock.py:84)이나 `EUDWhile`. | 동등(Single 은 대체) | 단일 트리거 자기반복은 `RawTrigger(nextptr=자기)` 와 탈출 조건으로 직접 짠다(하). |
| If | `CIf/CIfEnd`, `NIf/NIfEnd`, `NIfNot` | 조건부 단락. C 는 단락 안에서 점프로 빠져나갈 수 없고 N 은 가능하다. | `EUDIf()(cond)`, `EUDIfNot`, `EUDEndIf`(ctrlstru/simpleblock.py:21,40,101) | 동등 | eudplib 분기는 모두 N 계열처럼 빠져나가도 안전하다(G4 1.9). `CIfEnd(Actions_Always)` 는 EndIf 뒤 DoActions 로 옮긴다. |
| 1회 If | `CIfOnce`, `NIfOnce` | 조건을 처음 만족할 때 한 번만 실행한다. | `EUDExecuteOnce()(cond)`/`EUDEndExecuteOnce`(simpleblock.py:116,147) | 동등 | |
| 다중 분기 | `CIfX/CElseIfX/CElseX/CIfXEnd`, `NIfX…` | If~ElseIf~Else | `EUDIf/EUDElseIf/EUDElseIfNot/EUDElse/EUDEndIf`(simpleblock.py) | 동등 | 값 분기 `EUDSwitch/EUDSwitchCase/EPDSwitch`(ctrlstru/swblock.py:24,42)는 CtrigAsm 에 대응이 없다(eudplib 쪽 추가 기능). |
| While | `CWhile/NWhile`(+End), `CWhileX/NWhileX` | 반복. X 가 없는 판은 T 조건의 변수가 갱신되지 않고, X 판은 자동 갱신된다. | `EUDWhile()(cond)`, `EUDWhileNot`, `EUDEndWhile`(loopblock.py:104) | 동등 | eudplib 은 패치 트리거가 loopstart 뒤에 놓여 매 반복 새로 채워진다 → 항상 X 판과 같은 의미다. |
| 횟수 + 조건 반복 | `CLoop/NLoop/CLoopX/NLoopX(Repeat 상수)` (CA:10760~) | 조건을 만족하는 동안 최대 Repeat 회 반복한다. | `EUDLoopN()(n)` + `EUDBreakIfNot(cond)`(ctrlstru/breakcont.py:61) | 대체 | |
| DoWhile | `DoWhile/DoWhileEnd` (CA:11575) | 먼저 실행하고, 조건을 만족하면 반복한다. | 전용 블록이 없다 → `EUDInfLoop()`(loopblock.py:25) … `EUDBreakIfNot(cond)` … `EUDEndInfLoop()` | 대체 | |
| For | `CFor(P,Init,End,Step)/CForEnd`, `CForVariable(Level)` (CA:11773) | Init 에서 End 까지(반드시 도달) Step 씩 반복하고, 루프 변수를 돌려준다. | `for i in EUDLoopRange(start, end)` — step 1, end 는 포함하지 않는다. 이때 `i` 가 CForVariable 이다. Step≠1 이면 `EUDWhile` + `i += step`. | 동등(step 1) / 대체 | |
| 루프 탈출·계속 | (N 계열 안에서 Jump 로 탈출) | | `EUDBreak/EUDBreakIf/EUDContinue/EUDContinueIf`(ctrlstru/breakcont.py) | 동등 | |
| "2" 접미 변형 | `SLoopN2`, `CIf2`, `CWhile2` … | 조건·액션을 CTriggerX 팩(CunPack) 형태로 받는다. | 파이썬 리스트를 쓴다. | 불필요 | |
| Bring/Command 반복 조건 함정 | (주의문) | Kill/RemoveUnit 으로는 탈출하지 못하고 GiveUnit 이 필요하다. | SC 동작이라 eudplib 에서도 같다. | 동등(주의 유지) | |

## 11장 — SafeRead류

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 0.76.14 대응(파일) | 판정 | 비고 |
|---|---|---|---|---|---|
| 비트 조건 복사 | `SafeReadX(P,In,{Out…},Mask,EPDRead)` (CA:9137) | 고정 주소·Cp·변수 값을 비트 조건 32개로 **여러 출력에 한꺼번에** 복사한다(CP 를 바꾸지 않음). | `f_readgen_epd(mask, (init, f)…)`(eudlib/memiof/memifgen.py:63), `f_maskread_epd(epd, mask)`(:238), `f_dwread_epd`, `f_dwepdread_epd`(dwepdio.py:22) | 동등 | eudplib 은 CP 를 옮겼다가 캐시로 되돌리므로 결과가 같다. 출력이 여러 개면 읽은 뒤 대입한다. |
| 유닛 수 이진 탐색 | `UnitReadX(P,Player,Unit,Loc,Out)` (CA:9311) | Command/Bring AtLeast 2^i 조건으로 유닛 수(≤2047)를 구한다. | `EUDBinaryMax(lambda x: Bring(p, AtLeast, x, u, loc), 0, 2047)`(eudlib/utilf/binsearch.py:14) | 동등 | 변수 player·unit·loc 는 Trigger 패치로 넣는다(G2 §7). |
| 곱해서 읽기 | `ConvertReadX(…,Multiplier,Mask,UseCycle)` (CA:9661) | 메모리 × 상수(또는 ÷2^n)를 읽는다. | `f_readgen_epd(mask, (0, lambda b: b*k))` | 동등 | |

## 12장 — 매크로형 최종 연산 (C)

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 0.76.14 대응(파일) | 판정 | 비고 |
|---|---|---|---|---|---|
| 대입 | `CMov(P,Dest,Src,Dev,Mask,Clear)` (CA:20936) | Dest ← Src + Dev. Dest 는 주소/"Cp"/V/Mem/A/VA 중 하나다. | `dst << src`, `SetVariables`(core/variable/eudv.py:926), `SeqCompute`(:809). 주소 대상 `f_dwwrite_epd` 또는 `Trigger` 안 `SetMemory(addr, SetTo, v)`. "Cp" 대상 `f_setcurpl`. 배열 `arr[i] = v`. | 동등 | 부분 마스크 대입: 메모리는 `f_maskwrite_epd`(eudlib/memiof/bwepdio.py:271), 변수끼리는 `VProc` + `SetMask`(G2 1.11). |
| VA 대입 | `CMovX` (CA:5130) | VA ↔ V/상수를 옮긴다(CP 트릭). | `va[i]`, `va[i] = v`, `va.iadditem` 등 | 동등 | |
| 메모리 읽기 | `CRead(…,EPDRead)` (CA:20158), `CReadX(…,{BitMask,DestMask},Multiplier)` (CA:20561) | f_maskread 방식을 인라인으로 펼친다. | `f_maskread_epd`, `f_dwepdread_epd`(EPD 출력), `f_readgen_epd`(곱, 부분 대상) | 동등 | 비용 차이: CRead 는 호출마다 트리거 최대 32개를 인라인으로 펼친다. eudplib 은 마스크마다 EUDFunc 1벌을 공유한다(memifgen.py:19 `functools.cache`). |
| 저장 주소 얻기 | `TMem(P,Dest,Src,Addr,Next,OffsetFlag)` (CA:4356) | V/VA/A/W 의 저장 주소(EPD 또는 Offset)를 변수에 넣는다. | `v.getValueAddr()`, `EPD(...)`, `arr + 4*i`, `EPD(va) + 18*i + 87` | 대체 | |
| 변화량 | `f_Diff(P,Dest,Src,Mask,Time,Delay,Init)` (CA:74698) | Time 주기마다 V − V이전 을 구한다(대기·초기화 옵션). | 대응 없음 | **없음(하)** | 이전값 변수와 `f_getgametick`(eudlib/utilf/gametick.py) 타이머로 몇 줄이면 된다. |
| 간접 쓰기 | `CWrite(P,Dest(V=EPD),Src,Dev,Mask)` (CA:21104) | SetMemoryX(V, SetTo, V2, Mask) | `f_dwwrite_epd(epd, v)`(dwepdio.py:155), `f_maskwrite_epd`, `Trigger` 안 `SetMemoryEPD(v, SetTo, v2)` | 동등 | |
| 덧셈 | `CAdd` (CA:21587) | Dest += Src / Dest = Src + Op | `+=`, `+`, `AddNumber`, `QueueAddTo` | 동등 | |
| 포화 뺄셈 | `CSub` (CA:21850) | max(0, X − Y) ("1−2=0") | `v.SubtractNumber(c)`(vbase.py:48), 변수는 `QueueSubtractTo`(eudv.py:290) | 동등 | **`v -= x` 는 wrap(=CiSub) 이다.** 이름이 비슷해 헷갈리기 쉽다(G2 1.8). |
| wrap 뺄셈 | `CiSub` (CA:22121) | X − Y mod 2^32 | `-=`, `-`(eudv.py:307,343) | 동등 | |
| 부호 반전 | `CNeg` (CA:22466) | −X | `-v`, `v.ineg()`(vbase.py:122) | 동등 | |
| 시프트 | `ClShift` (CA:21215), (참고 `CrShift`) | << / >>(논리) | `<<=`/`>>=` 상수(vbase.py:142,152), `f_bitlshift`/`f_bitrshift`(core/calcf/bitwise.py:145,201) | 동등 | CrShift 는 가이드북 12장에 없고 G2 에 있다. |
| 곱셈 | `CMul(…,BitLimit)` (CA:23123) | 상수 곱과 변수 곱 | `*`, `f_mul`(core/calcf/muldiv.py:22) | 동등 | 비용 차이: CMul 상수판은 호출마다 트리거 32개 이상을 인라인으로 펼친다(G2). eudplib 상수 곱은 상수마다 EUDFunc 1벌이다. BitLimit(비트 범위를 줄이는 최적화)는 없다 → 불필요. |
| 부호 없는 나눗셈·나머지 | `CDiv` (CA:23606), `CMod` (CA:24460) | ÷0 → 몫 0xFFFFFFFF, 나머지 N | `f_div(a,b)` → (몫, 나머지)(muldiv.py:41), `//`, `%` | 동등 | 변수 제수 ÷0 결과는 같다. 상수 0 제수에서는 CDiv=1 로 결과가 다르다(G2 1.8). |
| 부호 있는 나눗셈·나머지 | `CiDiv` (CA:25314), `CiMod` (CA:26882) | C++ 방식: 몫은 0 방향으로 버리고, 나머지 부호는 피제수를 따른다(소스 머리 주석). | `f_div_towards_zero(a,b)`(eudlib/mathf/div.py:15). `f_div_floor`, `f_div_euclid` 도 있다. | 동등(÷0 만 다름) | ÷0: CtrigAsm 은 양수→0x7FFFFFFF, 음수→0x80000000. eudplib 은 div.py 를 따라가면 양수→0xFFFFFFFF(−1), 음수→1 이다. 가이드북의 CiMod 예시(10%−3=−1)는 소스 주석(=1)과 다르다 → 소스를 기준으로 했다. |
| 비트 연산 | `CNot`, `CAnd`, `COr`, `CXor` (CA:28340~29021) | ~ & \| ^ | `~v`/`v.iinvert()`/`f_bitnot`, `&`/`f_bitand`, `\|`/`f_bitor`, `^`/`f_bitxor`(core/calcf/bitwise.py:20~56) | 동등 | eudplib 에는 nand/nor/nxor 도 있다. |
| 공통 인자 Mask | 모든 C 함수 | 결과를 쓸 비트 범위 | 대부분의 API 에 없다 → 임시 변수로 계산한 뒤 `f_maskwrite_epd`/`SetNumberX` 로 쓴다. | 대체 | |
| 공통 인자 PlayerID·Clear | | 트리거를 실을 플레이어, 중간식 초기화 | | 불필요 | |

## 13장 — Include (호출형 함수 몸체 선언)

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 0.76.14 대응(파일) | 판정 | 비고 |
|---|---|---|---|---|---|
| 호출형 함수 몸체 미리 내보내기 | `Include_CtrigPlib(Cycle,SeedSwitch)` = `Include_DataTransfer`(CA:29464) + `Include_ArithMetic`(CA:30246) + `Include_MatheMatics(Cycle,LengthdirX)`(CA:31196) + `Include_MiscFunctions(SeedSwitch)`(CA:31329) | 공유 루틴 몸체를 CJump(0) 안에 정해진 순서로 미리 내보낸다. 포함하지 않고 부르면 오류가 난다. | `EUDFunc` 는 처음 호출될 때 몸체 1벌을 자동으로 만든다(core/eudfunc/eudf.py:50). | 불필요 | 인자의 행방: Cycle 은 아래 f_Lengthdir 의 "임의 주기"(없음), SeedSwitch 는 eudplib `f_randomize` 가 쓰는 "Switch 1"(eudlib/utilf/random.py:30, 고정)에 해당한다. |

## 14장 — 호출형 최종 연산 (f_)

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 0.76.14 대응(파일) | 판정 | 비고 |
|---|---|---|---|---|---|
| 메모리 읽기 | `f_Read(P,In,Out,EPDOut,Mask)` | 값과 EPD 를 함께 읽는다. | `f_dwepdread_epd(epd)` → (값, EPD)(dwepdio.py:22), `f_maskread_epd` | 동등 | |
| 바이트 단위 곱 읽기 | `f_ReadX(…,Multiplier 256^n)` | 바이트 구간을 256^n 배로 읽는다. | `f_readgen_epd`, `f_bread_epd`/`f_wread_epd`(bwepdio.py) | 동등 | |
| Offset→EPD | `f_EPD` (CA:35455) | Dest ← EPD(Src) | `EPD(v)`(utils/etc.py:19, 변수 지원) | 동등 | |
| Offset 나머지 | `f_EPDX` (CA:35666) | Src % 4 | `v & 3` / `f_bitand(v, 3)` | 동등 | |
| 블록 복사 | `f_MemcpyEPD` (CA:31928), `f_Memcpy`, `f_MemcpyX` (CA:33699) | dword/바이트 블록을 복사한다(epd + 0~3 편차). | `f_repmovsd_epd(dst, src, n)`(eudlib/memiof/mblockio.py:23), `f_memcpy(dst, src, len)`(:96) | 동등 | |
| 메모리 ↔ VArray 복사 | `f_ReadcpyEPD`/`f_Readcpy`(CA:33214)/`f_ReadcpyX`, `f_MovcpyEPD`/`f_Movcpy`(CA:31511) | VArray 를 버퍼로 삼아 블록을 복사한다(시작 바이트 편차 지정). | 전용 함수는 없다. 버퍼를 `EUDArray`/`Db` 로 잡으면 `f_repmovsd_epd`/`f_memcpy` 한 번이면 된다. EUDVArray 가 꼭 필요하면 루프를 돈다. | 대체 | CtrigAsm 은 TRIG 안 배열에 CP 트릭 없이 쓰기 어려워 VArray 버퍼를 둔 것이다. |
| 바이트 변환·복사·비교 | `f_byteConvert(X)`, `f_bytecpy(X)`, `f_bytecmp(X)` (13장 목록) | 바이트 단위로 복사·비교한다. | `f_memcpy`, `f_memcmp`(mblockio.py:108), `EUDByteReader/Writer`(eudlib/memiof/byterw.py), `f_strcmp`(eudlib/stringf/strfunc.py) | 동등(추측) | 본체 비교는 25장 담당. |
| 절댓값 | `f_Abs` (CA:36663) | | `v.iabs()`(vbase.py:135) | 동등 | |
| 곱셈 | `f_Mul`, `f_iMul` (CA:37002) | | `f_mul` | 동등 | f_iMul 의 속도 최적화(절댓값이 작은 부호 값)는 없다. 결과는 같다. |
| 나눗셈 | `f_Div`/`f_Mod`, `f_iDiv`/`f_iMod` | | `f_div`, `f_div_towards_zero` | 동등 | ÷0 차이는 12장과 같다. |
| 제곱근 | `f_Sqrt` (CA:35345) | | `f_sqrt(n)`(eudlib/mathf/sqrt.py:14) | 동등 | |
| 극좌표 → 직교 | `f_Lengthdir(P,R,Θ,Cos,Sin)` (CA:35153, 표 CA:84378) | 주기 Cycle(4의 배수, 표 크기 Cycle/4+1). 음수 각을 보정한다. −32768≤R≤32767. LengthdirX 고정밀 모드(STRCtrig 필요)가 있다. | `f_lengthdir(len, angle)`(eudlib/mathf/lengthdir.py:18 — 1° 단위 표 91칸, 360 주기), `f_lengthdir_256` | 동등(360·256) / **없음(임의 주기)** | eudplib 은 `angle >= 360` 이면 `%= 360` 만 한다. 부호 있는 음수 각은 부호 없는 큰 수로 처리되므로 직접 보정해야 한다(소스 확인). |
| 각도 | `f_Atan2(P,dY,dX,Θ)` (CA:34879) | Cycle 주기 | `f_atan2(y, x)`(eudlib/mathf/atan2.py:16), `f_atan2_256` | 동등(360·256) / **없음(임의 주기)** | |
| 정수 로그 | `f_Log2` (CA:34772) | log2(X) | 없다(파이썬 `math.log2` 는 컴파일 시 상수에만 쓸 수 있다). | **없음(하)** | 비트 스캔 32 트리거나 `EUDBinaryMax` 로 몇 줄이면 된다. 같은 Include 의 `f_Square` 는 `v*v` 로 대체한다. |
| 난수 | `f_Rand(P,Dest,Mask)` | 호출할 때마다 SeedSwitch 를 Random 으로 32번 섞어 32비트를 만든다. | `f_dwrand()`, `f_rand()`(16비트)(eudlib/utilf/random.py:76,67) + `f_randomize()`/`f_srand(seed)`/`f_getseed()` | 동등(방식 차이) | eudplib 은 LCG 다. 시드는 `f_randomize` 가 Switch 1 을 Random 으로 32번 섞어 한 번 만든다. 두 방식 모두 동기 안전하다. |
| 스트링 주소 | `f_GetStrptr`(STR, CA:34305), `f_GetStrXptr`(STRx, CA:34177) | 스트링 ID(상수·변수·내용 문자열)를 주소로 바꾼다. | `GetMapStringAddr(str_id)`(eudlib/stringf/cpstr.py:77) — 변수와 문자열 내용을 받고, STR/STRx 를 스스로 가린다. | 동등 | 두 쪽 다 STR 주소를 0x191943C8 로 고정해 둔다(cpstr.py:18). |
| TBL 주소 | `f_GetTblptr` | tbl 인덱스를 주소로 바꾼다. | `GetTBLAddr(tbl_id)`(eudlib/stringf/tblprint.py:30) | 동등 | |
| 호출 뒤 CP 복구 | (부록 J 목록) | f_Read, VA 읽기 뒤 RecoverCp 를 실행한다. | CP 캐시 | 대체 | |

---

## 부록 H — 전역변수 목록

| 기능 묶음 | CtrigAsm 대표 이름 | 하는 일 | eudplib 0.76.14 대응(파일) | 판정 | 비고 |
|---|---|---|---|---|---|
| 플레이어·비교·연산 상수 | `P1~P12`=0~11, `AtLeast=0`, `AtMost=1`, `Exactly=10`, `SetTo=7`, `Add=8`, `Subtract=9` | 숫자 상수 | `P1…P12`, `AtLeast…`, `SetTo…`(TrgPlayer/TrgComparison/TrgModifier 객체, 패키지 최상위) | 동등 | eudplib 상수는 객체라 `SetTo*16777216` 같은 산술을 그대로 할 수 없다 → `EncodeModifier(SetTo)`(core/rawtrigger/constenc.py). |
| 확장 비교 상수 | `Above`, `Below`, `iAtLeast`, `iAtMost`, `iAbove`, `iBelow`, `NotSame` | TT/_T 조건용 초과·미만·부호 있는 비교·다름 | 부호 없는 `>`, `<`, `!=`(core/variable/vbase.py:163~185, eudv.py:578~650). **부호 있는 비교 API 는 없다**(패키지 전체 grep). | 동등(부호 없음) / **없음(부호 있음, 하)** | 부호 있는 비교는 `x ^ 0x80000000` 뒤 부호 없는 비교로 직접 짠다. TT 본체는 16·17장 담당. |
| C 연산 상수 | `CSetTo=10`, `CAdd=11`, `CSubtract=12` | 용도 미확인 | — | 확인 못 함 | |
| 제어문 블록 스택 | `CJumpArr`…`SLoopNArr`, `CIfptr` 등 | 컴파일 시 블록 스택 | `EUDCreateBlock/EUDPopBlock`(utils/blockstru.py:35,71) | 동등(내부) | |
| 공유 루틴 호출 라벨 | `FCB*`, `FL*`, `F*Call1/2/Check/Alloc` | 호출형 함수의 라벨과 포함 여부 | EUDFunc 객체 | 불필요 | |
| 번호 할당기 | `IndexAlloc`, `FuncAlloc`, `VarXAlloc/MAXVAlloc`, `WarXAlloc`, `SVarXAlloc`, `CreateVarXAlloc`, `FlagAlloc`, `*Limit` | 라벨·임시 변수 번호 영역 | 자동이다(payload 할당, 임시 변수 `_ev` = core/variable/evcommon.py). | 불필요 | |
| 레지스터 | `CRet`, `NRet`, `WRet`, `SRet`, `ARet` | 함수 결과와 중간값을 담는 고정 변수 | EUDFunc 반환값, `EUDReturn`, `_ev` 임시 변수 | 대체 | |
| T/TT·임시식 대기열 | `PushTrigArr`, `PushCondArr`, `TTPushTrigArr`, `STPushTrigArr`, `_TPushCondArr`, `…PopTrigLock` | 변수 삽입과 임시식의 대기열 | tpatcher, 식 즉시 계산 | 불필요 | |
| OR 조건 상태 | `EUDORPlayer/EUDORFlag`, `ORPushCondArr` | OR 조건 | `EUDSCOr`(ctrlstru/shortcircuit.py:98) | 동등 | |
| CP 규약 | `RecoverCpValue`, `MoveCpValue`, `DetectRecoverCp` | | CP 캐시(modcurpl.py) | 대체 | |
| CunitCtrig 스택 | `CCArr`, `CCPArr`, `CCptr` | | listloop 블록 | 불필요 | |
| 빈 메모리 영역 | `VoidAreaOffset=0x58F500`, `VoidAreaAlloc`, `VoidAreaLimit=0x5967F0` | 게임 안 빈 메모리를 런타임 저장소로 쓴다. | payload(Db/EUDArray)에 할당한다. | 불필요 | 다른 플러그인과 빈 영역을 나눠 쓰다 충돌할 위험이 없다. |
| 컴파일 시 스트링 관리 | `StringKeyArr`, `iStringKeyArr`, `iTBLIndexArr`, `__StringArray`, `__UPUSCheckArray` | | `EncodeString`(core/rawtrigger/strenc.py:277), `Db(u2utf8(...))`(utils/ubconv.py:36), `TBL`(core/mapdata/tblformat.py:58) | 대체 | 19장 담당. |
| 세력 표 | `CForce1~4`, `CAllPlayers`, `Force5`, `EveryPlayers` | SetForces 결과 | `GetPlayerInfo` | 불필요 | |
| CFunc·스택 | `CFuncParaVarNum`, `CFuncParaVarArr`, `CFuncRetVarArr`, `CStackArr/LStackArr`, `CStackptr…` | | EUDFunc 인자, `EUDStack` | 대체 | 21장 담당. |
| 파일 | `FileDirectory`, `FileNameIndex`, `CSLoad/CSSaveInitCheck` | | 파이썬 | 대체 | 29장 담당. |
| 설치 상태 | `STRCTRIGASM`, `IncludePlayerID`, `NSQCVArray` | | | 불필요 | |
| 배열 초기 데이터 | `__VArrSTR/__WArrSTR/__SVArrSTR`, `__VoidCondArr/__VoidActArr` | 초기 데이터를 문자열로 넣는다. | `EUDArray([...])`, `EUDVArray(n)([...])`, `Db` | 동등 | |
| Loader2 | `__TRIGChkptr` | SCMDraft 의 65536 트리거 한도를 피하려고 `__TRIG.chk` 에 기록한다. | payload | 불필요 | |
| 고정 포인터 가정 | "STR(X) ptr 고정 0x191943c8 / TBL ptr 고정 0x19184660" | | STR 은 eudplib 도 0x191943C8 고정(cpstr.py:18). TBL 은 0x6D5A30 포인터를 런타임에 읽는다(tblprint.py:26, "TODO: hardcode 0x19184660?"). | 동등 | |
| 다른 조각 담당 | `BulletTable`(28장), `CAPlot*`/`CBPlot*`(F장), `CAPrint*`(26장), `__Sort*`(CB Paint 내부, `CB Paint v2.5.lua:28363`), 64비트 `WRet`/`LStack`(22장) | | | — | |

## 부록 I — Index 자동할당 목록

| 기능 묶음 | CtrigAsm 영역 | 하는 일 | eudplib 0.76.14 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 사용자 라벨 | 0x0001~0x9FFF, 0x10000~0x17FFF (Label 최대 0x1FFFF, 17비트 표식) | 사용자가 붙이는 번호 | 파이썬 객체 참조 | 불필요 | |
| 점프 번호 | sIndex 0x000~0x9FF(사용자 2560쌍), 0xA00~0xFFF(CAPlot), 라벨 0xA000~0xBFFF | | `Forward` 개수 제한 없음 | 불필요 | |
| 제어문 번호 | 0xC000~0xEFFF(IndexAlloc, 12288개). CIf 2, NIf 3, CWhile/CLoop 3, NWhile/NLoop 4, DoWhile 2, CFor 4, CIfX/NIfX 개당 2 씩 쓴다. | | 제한 없음 | 불필요 | 큰 맵에서 CtrigAsm 한계가 되던 부분이 없어진다. |
| TT 플래그 | 0xF300~0xF3FF(FlagAlloc, 최대 12480) | TT 조건 결과 비트 | `EUDLightBool`/임시 변수, 제한 없음 | 불필요 | |
| 임시 변수·레지스터 | 0xF000~0xF2FF CAPrint, 0xF400~0xFBFF SVar 임시·SRet, 0xFC00~0xFDFF W 임시·WRet, 0xFE00~0xFFDF V 임시(480개), 0xFFE0 시스템 Label(0), 0xFFE1~0xFFFA NRet+CRet, 0xFFFB~0xFFFF Ctriginit | | eudplib 임시 변수를 자동으로 재사용한다(rvalue, `_ev`). | 불필요 | |
| 선언형 변수·함수·배열 | 0x18000~0x19FFF CreateVar(8192개), 0x1A000~0x1CFFF CAPlot, 0x1D000~0x1FFFF FuncAlloc(CMul/CDiv/CMod 서브루틴·배열·함수 12288개) | | 제한 없음(payload 크기만) | 불필요 | |

## 부록 J — Cp트릭 사용 함수 목록

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 0.76.14 대응(파일) | 판정 | 비고 |
|---|---|---|---|---|---|
| CP 를 바꾸고 RecoverCp 로 끝나는 함수들 | `f_Cast/f_iCast/SCast`, `MovX/MovW/MovS`, `CMovX`, `f_LMovX`(VA·WA·SVA 읽기), `CRead/CReadX`(V/VA/A 소스), `f_Read/f_ReadX/f_LRead/f_LReadX`, `f_Movcpy/f_MovcpyEPD`, `f_byteConvert*/bytecpy*/bytecmp*`, `f_GetTblptr/f_GetStrXptr/f_GetStrptr` | 호출자가 `SaveCp`→`SetRecoverCp` 로 복구값을 넘겨야 한다. | 대응 함수(`f_dwread_epd`, `f_maskread_epd`, EUDVArray 읽기, `f_memcpy`, `GetTBLAddr`…)도 CP 를 쓰지만, 끝에서 `f_setcurpl2cpcache` 로 원래 CP 로 돌아간다. `*_cp` 함수(eudlib/memiof/cpmemio.py)는 반대로 "현재 CP 기준"으로 읽는 쪽이다. | 대체(자동) | eudplib CP 캐시는 CP 쓰기가 모두 `f_setcurpl`/`SetCurrentPlayer`/`AddCurrentPlayer` 를 거친다고 가정한다. CtrigAsm 습관인 `CMov(FP, 0x6509B0, …)` 같은 직접 쓰기를 옮기면 캐시가 틀어진다(G7 1.2.5). |
| 감지 도구 | `PushRecoverCpMsg` | | 없음 | 불필요 | |

## 부록 K — 내부함수 목록

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 0.76.14 대응(파일) | 판정 | 비고 |
|---|---|---|---|---|---|
| 플레이어 정규화 | `PlayerConvert(2)(X)` | Force·목록을 P1~P8 목록으로 편다. | `EncodePlayer`(core/rawtrigger/constenc.py:391), PTrigger 내부 | 대체 | |
| 검사기 | `AllocCheck`, `LabelCheck`, `ControlCheck`, `CAPrintAllocCheck`, `CAPlotAllocCheck` | | blockstru assert | 불필요 | |
| OR·비교 조건 | `EUDORInit`, `EUDOR`, `EUDCond`, `EUDCompare`, `EUDNotSame`, `EUDAbove`, `EUDBelow`(구 함수, CA:16927~), `ORPopCondArr` | | `EUDSCOr`/`EUDSCAnd`(ctrlstru/shortcircuit.py), `EUDOr`/`EUDAnd`/`EUDNot`(eudlib/utilf/logic.py:14,59), `!=`/`>`/`<` | 동등 | |
| 시작 틀 | `InitCtrig`(CA:38508), `Include_Last`, `Include_CBLast`, `CSSaveInit` | | injector(maprw/injector), EUDFunc 지연 생성 | 불필요 | CB/CS 는 다른 조각 담당. |
| 대기열 비우기 | `PopCondArr`, `PopActArr`, `PopTrigArr`, `TTPopTrigArr`, `STPopTrigArr`, `_TPopCondArr`, `_TPopTrig`, `_TPopBind`, `FlagIndex` | T/TT/임시식을 조건·액션 앞 트리거로 풀어낸다. | tpatcher `apply_patch_table`, 식 즉시 계산 | 동등(내부) | G5 1.3. |
| 내부 복사 | `MovY`, `MovZ`, `MovW` (CA:3825,4020,4183) | 상수/V ↔ VA·W 전용 복사 | 변수 연산, 배열 get/set | 동등 | W(64비트)는 22장 담당. |
| 64비트 상수 계산 | `I64`, `I64Sub(2)`, `I64Neg`, `I64Add`, `I64Mul`, `I64Pow` | Lua(53비트 실수)로 64비트 상수를 계산한다. | 파이썬 int(자릿수 제한 없음) | 불필요 | |
| 바이트·워드 쓰기 변환 | `_ConvertBwrite(Z/X)`, `_ConvertWwrite(Z/X)` | 정렬되지 않은 주소에 바이트·워드를 쓴다. | `f_bwrite_epd`/`f_wwrite_epd`(eudlib/memiof/bwepdio.py:151,49), `f_bwrite`/`f_wwrite`(ptrmemio.py) | 동등 | |
| 문자열 인코딩 | `utf8_from`, `str_to_istr`, `str_to_iutf8`, `str_to_icp949`, `tbl_to_itbl` | 컴파일 시 문자열을 바이트로 바꾼다. | `u2utf8`/`u2b`/`b2u`(utils/ubconv.py), `EncodeString`, `TBL`, `f_settbl`(stringf/tblprint.py) | 동등 | |
| 핫키·버튼 값 | `ParseHotkey`, `ParseButtonType`, `MakeHotkeyValue`, `MakeButtonTypeValue` | stat_txt 핫키·버튼 형식 바이트를 만든다. | 전용 도우미는 없다. `TBL` 로 바이트를 직접 넣는다. | 대체(하) | |
| 키·마우스 이름 표 | `ParseKeyName`(CA:80174), `ParseMouseName` (→ `KeyPress`/`MousePress` CA:80238,80283) | 키 이름을 가상키 코드로 바꾼다. | 0.76.14 파이썬 소스에는 없다(KeyPress/KeyDown grep 결과 0). 더 새 판에는 키 입력 함수가 있다고 알려져 있다(최신판, 추측). | **없음(하)** | 표를 옮기고 키 상태 메모리를 `MemoryX` 로 읽으면 된다. 로컬 값이라 디싱크에 주의한다(G7 1.5). |
| Loader2 | `__InitTrigger`, `__PopStringArray` | 65536 트리거 한도 우회 | | 불필요 | |
| 경로 | `SetFileDirectory` | | 파이썬 `os.path` | 대체 | |
| 트리거 생성 틀 | `__DoActions2`, `__Trigger`, `__Comment` | | `Trigger`(자동 분할), `Comment` 액션(패키지 최상위) | 동등 | |
| 평탄화·팩 풀기 | `CunPack`, `__FlattenAct`, `__FlattenCCond`, `__FlattenCAct` | | `FlattenList`(utils/etc.py) | 동등 | |
| 인코딩 표 포인터 | `EncodeTableptr`(CA:76704) | CAPrint 인코딩 표 | — | — | 26장 담당. |
| 정렬 | `__Sort`, `__TSort`, `__SortT` | CB Paint 내부 정렬 | — | — | F장(CB Paint) 담당. |
| Print_utf8X 함수들 | | | | — | G8 참고. |

## 부록 L — Vi() 사용가능 함수 목록

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 0.76.14 대응(파일) | 판정 | 비고 |
|---|---|---|---|---|---|
| 변수 + 상수 편차 입력 | `Vi(Index,k)`/`Wi`. 허용 목록: `CA__*`, `CD__*`, `CDPrint`, `CallCFunc(X)`, `CallVFunc(X)`, `Arr/LArr/VArr/WArr/SVArr`(+X, +Convert*), `SetRecoverCp`, `CWrite`, `f_LWrite`, 모든 T/TT 조건·액션의 변수 칸(TTbytecmp 제외) | 편차를 패치 값에 얹는다. `CA__` 함수에서는 k 가 k*604 로 들어간다. | 어느 인자 자리에든 식 `v + k` 를 넣을 수 있다: `Trigger` 조건·액션 칸, EUDFunc 인자, 배열 인덱스 `arr[v + k]`. **허용 목록이라는 개념 자체가 없다.** | 동등(더 일반적) | 비용 차이: Vi 는 추가 연산이 0개다. eudplib `v + k` 는 임시 변수 복사와 덧셈이 든다. 성능이 중요한 루프라면 미리 더해 둔다. `k*604` 규칙은 원소 간격이 달라 불필요하다. Wi(64비트)는 22장 담당. |

---

## 없음 / 흉내 어려움 목록

### 없음 (직접 짜야 함)

| # | 항목 | 장 | 난이도 | 이유·방법 |
|---|---|---|---|---|
| 1 | `f_Diff` (주기별 변화량) | 12 | 하 | 대응 API 가 없다. 이전값 변수와 `f_getgametick` 타이머로 짠다. |
| 2 | `f_Log2` (정수 log2) | 14 | 하 | 없다. 비트 스캔 트리거 32개 또는 `EUDBinaryMax` 로 짠다. |
| 3 | `f_Lengthdir`/`f_Atan2` 의 **임의 각도 주기(Cycle)** 와 LengthdirX 고정밀 모드, 음수 각 자동 보정 | 13·14 | 하~중 | eudplib 은 360·256 주기만 있고(1° 표 91칸) 음수 각을 보정하지 않는다. 표를 `EUDArray` 로 만들고 lengthdir.py 구조를 복사한다. |
| 4 | **부호 있는 비교**(iAtLeast/iAtMost/iAbove/iBelow) | H | 하 | 0.76.14 에는 부호 없는 비교만 있다. `x ^ 0x80000000` 뒤 부호 없는 비교로 짠다. (TT 본체는 16·17장.) |
| 5 | `CiDiv`/`CiMod` 의 **0 나눗셈 결과**(양수→0x7FFFFFFF, 음수→0x80000000) | 12·14 | 하 | `f_div_towards_zero` 는 −1 / 1 을 낸다. 같은 결과가 필요하면 앞에 `b == 0` 분기를 둔다. |
| 6 | `ParseKeyName`/`ParseMouseName`(키 이름 → 코드 표) | K | 하 | 0.76.14 에 없다. 표를 옮긴다(최신판에는 키 입력 함수가 있다고 알려짐, 추측). |
| 7 | `SLoopN(…, Single=1)` 단일 트리거 자기반복 | 10 | 하 | 전용 블록이 없다. `RawTrigger(nextptr=자기)` 와 탈출 조건으로 짠다. |

### 흉내 어려움

| # | 항목 | 장 | 이유 |
|---|---|---|---|
| 1 | **번호로 이웃 저장소를 찾는 산술**: `V(Index,P,Next)` 의 Next, `GetVArray` 로 따로 선언한 변수를 배열처럼 쓰기, VArr 원소의 "번호×604/2416" 산술, `CtrigX(P,Index,…,Next)` 로 라벨 기준 n칸 뒤 트리거 찾기 | 5·6·3 | eudplib 변수는 72B 씩 겹쳐 놓이고 번호가 없다. 따로 만든 변수가 연속으로 놓인다는 보장도 없다. 기존 코드를 옮길 때는 (a) 2416 간격 저장소를 따로 두어 흉내 내거나 (b) 호출부를 고쳐야 한다(G6 1.10). 새로 짜는 코드에서는 EUDVArray/EUDArray 로 처음부터 선언하면 문제가 없다. |
| 2 | **플레이어별 실행·사본 모델**: 모든 함수의 `PlayerID`, `V(i,"X")`/`Arr(…,"X")` = 현재 플레이어의 사본 | 전반 | eudplib 은 프레임당 1회 실행이고 사본 개념이 없다. `EUDPlayerLoop` + `PVariable`/8배 배열로 **코드 구조를 바꿔야** 한다. 기계적으로 가능하지만 자동 치환은 어렵다. |
| 3 | **빌드 시점 전역 상태에 기대는 CP 규약**: `SetRecoverCp`/`LoadCp` 가 뒤따르는 모든 RecoverCp 의 복구값을 바꾼다 | 9·J | eudplib CP 캐시는 모델이 다르다. 새 코드에는 필요 없지만, 호환 계층에서 원본 CP 를 한 틱 단위까지 똑같이 재현하는 것은 까다롭다(G7 1.2.3~1.2.6). |
| 4 | CunitCtrig 의 **실행 비용 특성**(펼친 1700 트리거, 슬롯당 트리거 1개) | 9 | 기능은 `EUDLoopUnit2` 와 같다. 같은 실행 비용 구조를 원하면 `RawTrigger` 1700개를 직접 짜야 한다(중). 용량은 크게 는다. |

## 불필요 (구조 차이) 목록

| 항목 | 이유 |
|---|---|
| `Label`, 모든 Index/sIndex/FuncAlloc 할당기, 부록 I 전체 | eudplib 은 트리거·저장소를 파이썬 객체(ConstExpr)로 참조한다. 번호 공간과 그 한도(If/While 12288, Jump 2560쌍, CreateVar 8192 등)가 없다. |
| 어셈블러 플러그인의 표식 풀이, `TriggerX`/`DoActionsX` 의 Label(0) 표시, B-3 인라이닝 금지 | payload 재배치가 주소를 푼다. |
| `ErrorCheck`(Alloc/Label/Control), `PushRecoverCpMsg` | 블록 짝은 eudplib 이 자동으로 검사한다. CP 는 캐시가 복구한다. |
| `Include_*` 전체와 포함 순서 규칙 | EUDFunc 는 첫 호출 때 자동으로 만들어진다. |
| `StartCtrig`/`EndCtrig` 와 옵션(STRX, IncludePlayer, STRCTRIG, CFunc/CStack/LStack) | 플러그인 진입점과 payload 가 대신한다. 스택은 `EUDStack` 으로 직접 선언한다. |
| `SetForces`, `SetFixedPlayer`, CForce 표 | 세력 정보는 맵에서 읽는다. 메인 루프는 플레이어가 나가도 돈다. |
| `ConvertArr`/`ConvertVArr`(0x968/0x96C 건너뛰기, ×604/×2416) | 배열이 트리거 몸체가 아니라 payload 에 있다. |
| `Ccode`, `_Ccode`, `_Ncode`, `Mem`/`_Mem` | 트리거 수를 아끼려는 칸 번호와 주소 핸들이다. eudplib 은 변수 72B + `getValueAddr` 로 해결한다. |
| `Forward(Move)`/`Struct` | 앞 점프는 eudplib `Forward` 로 한다(이름만 같다). |
| CStruct "2" 변형, `CunPack`, `__Flatten*` | 파이썬 리스트를 쓴다. |
| C 함수의 `PlayerID`, `Clear`, `BitLimit` 인자 | 실행 주체·임시식 초기화·비트 범위 최적화가 eudplib 모델에 없다. |
| `I64*` | 파이썬 int 로 계산한다. |
| VoidArea(0x58F500~) 런타임 저장소, Loader2(`__TRIG.chk`) | 데이터와 코드는 payload 에 들어가고, SCMDraft 트리거 한도와 무관하다. |
| T/TT·임시식 대기열 전역(PushTrigArr 등), 레지스터 번호(CRet/NRet…) | tpatcher, 즉시 식 계산, EUDFunc 반환값이 대신한다. |

## 확인하지 못한 것

- `CSetTo=10`, `CAdd=11`, `CSubtract=12` 상수의 용도.
- `EUDLoopN()(n)` 이 변수 n 을 받는지. 소스상 `RawTrigger` 에 n 을 넣으므로 상수 전용이라고 판단했고, 실제로 돌려 보지는 않았다.
- `f_lengthdir` 의 R 범위와 넘침. 표 배율이 65536 이라 큰 R 에서 넘치는지 확인하지 않았다(CtrigAsm 은 −32768~32767 로 명시).
- `f_byteConvert`/`f_bytecpy`/`f_bytecmp` 의 실제 의미. 이름만 보고 판정했고, 본체는 25장 담당이다.
- 더 새 eudplib 판에 키 입력 함수·부호 있는 비교가 있는지(최신판, 추측).
- CunitCtrig_Part3 에서 조건을 평가하는 순간의 CP 값. 앞 트리거의 액션이 CP 를 옮기는 구조로 보이지만 세부는 따라가지 않았다. 판정에는 영향이 없다.
- 가이드북 CiMod 예시와 소스 주석이 서로 다르다. 소스를 따랐고, 게임 안에서는 확인하지 않았다.
