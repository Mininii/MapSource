# MSQC를 CtrigAsm 라이브러리로 구현할 수 있는가

전제 문서: [MSQC_INTERNALS.md](MSQC_INTERNALS.md) (MSQC.py의 동작 원리·개선안). 이 문서는 그 전송 계층을
`CtrigAsm v5.5.lua`(TEP 트리거 빌더)만으로 다시 만들 수 있는지를 원시 기능 단위로 대조하고, 안 되는
부분과 되더라도 손해인 부분을 근거와 함께 적는다.

조사 대상: `Library/CtrigAsm v5.5.lua`(103,985줄), `Library/Ctrig Assembler v5.4 Guide Book.txt`
27장, `Py/STRCtrig Assembler v5.5.py`(어셈블러 euddraft 플러그인), 자매 프로젝트의 실사용 grep.

---

## 0. 결론

**원시 기능만 보면 전부 가능하다.** MSQC가 하는 모든 일(큐 길이 읽기, 가변 오프셋에 바이트 쓰기,
intransit 유닛 생성, CUnit 포인터→EPD, 알파ID 변환, 키/마우스 엣지, 런타임 플레이어로 Deaths 쓰기)에
대응하는 CtrigAsm 함수가 이미 있다(2절 표). 막히는 원시 기능은 없다.

**그러나 "전면 Lua 포팅"은 이득이 거의 없고 비용은 확실하다.**

1. CtrigAsm 자체가 `STRCtrig Assembler v5.5.py`(euddraft 플러그인) 없이는 돌지 않는다. 파이썬과
   euddraft 의존은 그대로 남고, 플러그인 수만 둘에서 하나로 준다.
2. CtrigAsm의 변수 삽입(T/TT)은 실행 시 트리거 필드를 고쳐 쓰고 점프하는 방식이라, 같은 일을 하는
   eudplib 코드보다 트리거 실행량이 대략 2~3배 많다(3.2절 추정 근거).
3. euddraft의 `beforeTriggerExec`/`afterTriggerExec` 훅에 해당하는 것이 없다. CtrigAsm 코드는
   특정 플레이어 TRIG 목록의 일부라 "모든 맵 트리거 전/후"를 보장할 수 없다(3.3절).
4. 가이드북 27장의 **NSQC.py**가 이미 "MSQC 계열 플러그인 + CtrigAsm 연동(NSQCVArray, NSQCASM)"
   이다. 즉 이 질문의 답은 원작자가 "전송은 Python, 프로토콜은 Lua"로 이미 내려 놓았다. 전면 포팅은
   NSQC.py가 푼 문제(QCDummy, dword 모드, 화면/와이드)를 다시 푸는 일이 된다(1절).

권장 순서: **A) 지금 구조 유지 + MSQC_INTERNALS.md 7절 개선을 Python 쪽에 적용** →
필요 시 **B) 최소 전송 플러그인 + Lua 상위 계층**(4절) → C) 전면 포팅은 "Lua 단일화"가 목적 그
자체일 때만.

---

## 1. 이미 있는 것: NSQC.py + CtrigAsm 27장

### 1.1 NSQC.py (가이드북 27장, 소스는 이 기계에 없음)

- 설정 문법은 MSQC와 같고 상위호환이다: `조건; val, 주소 : 유닛`, `xy`, `mouse`, 키/마우스, `NotTyping`
  에 더해 **`dword`(QC 유닛 2마리, 32비트 전체, 에러코드)**, `MouseMoved`, `ScreenMoved`,
  `WideScreen`, `화면/Screen` 로케이션, 출력 자리에 `i.0`을 쓰면 **`NSQCVArray[i]`에 값을 담는다**.
- "QC유닛 드래그 후 값 조작 버그 방지 [기본 적용] (QCDummy에 쓰레기값 항상 복사)": MSQC_INTERNALS.md
  3.7절에서 지적한 "QC 유닛이 선택으로 남는" 계열의 문제를 원작자가 이미 겪고 막았다는 뜻이다.
- 플러그인 순서 제약: `[Ctrig Assembler]`가 `[NSQC]`보다 위여야 한다. theSeed의
  `EUDEditorEdsGen.lua`가 쓰는 순서(`[unlimiter]/[Ctrig Assembler]/[MSQC]/...`)와 일치한다.

### 1.2 CtrigAsm 쪽 연동 지점

| 위치 | 내용 |
| --- | --- |
| `StartCtrig(STRX, IncludePlayer, NSQC=n)` (lua 592~597행) | `CVArray(FixPlayer, 8)`을 n개 만들어 `NSQCVArray[1..n]`으로 반환. 플레이어별 8칸 |
| `STRCtrig Assembler v5.5.py` 8~9행 | `NSQCASM = EUDVariable()` 을 `EUDRegisterObjectToNamespace`로 등록. 1819행에서 CtrigAsm 변수 영역의 EPD(`CurEPD+87-604*7`)를 대입 |
| MSQC.py `parseArray`/`parseCond` | `GetEUDNamespace()`의 이름을 `eval`로 찾는 구조. NSQC.py도 같은 방식으로 `NSQCASM`을 찾아 `NSQCVArray` 위치를 계산하는 것으로 추정(소스 미확인) |
| `NSQCSend(PlayerID, SourceVA, Size, Mask, Offset, ErrorCode, ...)` (lua 80847행) | VArray 원소를 **사이클마다 하나씩** `Offset`에 써서 NSQC.py의 `val`/`dword` 채널로 흘림. 끝나면 `Offset = ErrorCode` |
| `NSQCReceive(PlayerID, DestVA, Size, TargetPlayer, NSQCIndex, ErrorCode, ErrorCheck, ...)` (lua 81010행) | `NSQCVArray[NSQCIndex][TargetPlayer]`를 사이클마다 읽어 DestVA에 순서대로 저장. ErrorCode면 종료 |
| `NSQCMov` (lua 80827행) | 주석 처리된 사장 코드 |

즉 CtrigAsm의 NSQC 함수는 **전송 계층이 아니라 그 위의 스트리밍 프로토콜**이다. 자매 프로젝트
(theSeed, Stella-II, MSF_Respect_V, MapSource)에서 `NSQCSend`/`NSQCReceive`를 쓰는 곳은 없다.
실제 사용은 전부 설정 파일의 `val`/키 줄과 `TDeaths` 소비뿐이다.

> 검증 필요: `NSQCSend`는 프레임마다 원소 하나를 보내는데, MSQC_INTERNALS.md 5.1절대로 같은 네트워크
> 턴 안의 송신은 마지막 것만 남는다. NSQC.py가 `dword` 모드에서 수신 확인(handshake)을 하지 않는다면
> 원소가 유실된다. NSQC.py 소스를 확보해야 판정할 수 있다.

---

## 2. 원시 기능 대조표

MSQC.py의 각 단계를 CtrigAsm 함수로 옮길 수 있는지. "✓"는 함수가 존재하고 의미가 맞는 것,
"△"는 되지만 비용·제약이 큰 것, "✗"는 대응물이 없는 것.

| MSQC.py 단계 | eudplib 수단 | CtrigAsm 대응 | 판정 |
| --- | --- | --- | --- |
| 로컬 플레이어 판별 | `f_getuserplayerid()` (0x512684) | `LocalPlayerID(P)` (43389행) | ✓ |
| 키 상태/엣지 | `MemoryX(0x596A18+..)` + `KeyArray` 캐시 | `KeyPress(K,"Down")`(레벨), `TTKeyPress(K,"Down")`(엣지, 트리거 3개+Switch) (80234행, 40273행) | ✓ |
| 마우스 버튼/좌표 | `0x6CDDC0`, `0x6CDDC4` | `MousePress`, `TTMousePress`, `_Read(0x6CDDC4)` | ✓ |
| 채팅 중 아님 | `Memory(0x68C144,Exactly,0)` | `NotTyping()` (80318행) | ✓ |
| 큐 길이 읽기·상한 비교 | `f_dwread_epd(EPD(0x654AA0))`, `Memory(0x57F0D8, AtMost, ..)` | `CRead(P, V, 0x654AA0)`, `TMemory(0x57F0D8, AtLeast, _Add(V,17))` | ✓ |
| 큐에 15바이트 쓰기(가변 오프셋) | `f_memcpy(0x654880+len, Db, 15)` | `f_Memcpy(P, DestV, DbConst, 15)` (33534행) 또는 `TBwrite(OffsetV, SetTo, ValueV)`×15 (44246행) | △ 비용 |
| 큐 길이 갱신 | `SetMemory(0x654AA0, SetTo, V)` | `CMov(P, 0x654AA0, V)` | ✓ |
| units.dat 패치 | `SetMemoryX` 상수 | `SetMemoryX` 상수, `CJump(AllPlayers,0)` 초기화 구역 | ✓ |
| intransit 유닛 생성 | `CreateUnitWithProperties(.., UnitProperty(intransit=True))` | TEP `CreateUnitWithProperties(1, Unit, Loc, P, {intransit=true, invincible=true, ...})` — `CSPlotWithProperties` 예제(가이드북 22448행)로 문법 확인 | ✓ |
| 빈 슬롯 포인터→EPD | `f_cunitepdread_epd(EPD(0x628438))` | `f_CunitRead(P, 0x628438, ptrV, epdV)` (35946행) | ✓ |
| 로케이션 이동 | `SetMemoryEPD(LocEPD..)` | `SetLoc(loc,"L",SetTo,V)`, `TSetLoc` (43100행) | ✓ |
| GiveUnits | 클래식 액션 | 클래식 액션 | ✓ |
| CUnit 필드 패치(0x10,0x34,0x4C,0xDC,0xA5) | `SetMemoryXEPD(epd+k,..)` | `TSetDeathsX(Vi(epdV,k), SetTo, v, 0, mask)` — Player 자리에 EPD 변수 삽입 가능(가이드북 2855행) | ✓ |
| 알파ID | `f_epd2alphaid` (`//84`) | `f_EPDToAlphaID(P, epdV, outV)` (80559행). 내부는 `CReadX`로 0xA5 읽고 `CDiv 84`. 인덱스 규약이 역순(`161741-84i`)이지만 결과식은 동일 | ✓ |
| 선택 저장/복원 | 0x6284B8 12개 읽기 → 알파ID ×12 → Select 패킷 | `CRead`×12 + `f_EPDToAlphaID`×12 + `TBwrite`×(2+2n) | △ 비용 |
| 플레이어별 QC EPD 표 | `EUDVArray`/`PVariable` | `CVArray(FP,8)` + `VArr(VA, playerV)` (3166행) | ✓ |
| 수신: waypoint 비트 검사 ×22 | `MemoryXEPD(epd+4, AtLeast, 1, bit)` | `TDeathsX(Vi(epdV,4), AtLeast, 1, 0, bit)`×22, 또는 Cp 트릭: `TSetMemory(0x6509B0,SetTo,epdV)` 후 `DeathsX(CurrentPlayer, AtLeast, 1, 4, bit)`×22 (패치 없음, `SaveCp`/`LoadCp`로 복원, 9장) | ✓ |
| 수신 출력 (런타임 플레이어) | `SetDeaths(CurrentPlayer, Add, inc, unit)` | `TSetDeaths(playerV, Add, inc, unit)` — theSeed가 이미 `TSetDeathsX(i, Subtract, ..)`로 소비 중 | ✓ |
| 제어 흐름 | `EUDWhile`/`EUDIf` | `CWhile`/`CIf`/`CIfX`/`CFor` (CIf 안에서 Jump 탈출 금지, GOTCHAS) | ✓ |
| 자기수정 점프(`skipper`) | `SetNextPtr` | `SetCtrigX("X","X",0x4,..)` (가이드북 예제 3-2). `CIf`로 대체 가능 | ✓ |
| 1회 초기화(`onPluginStart`) | 플러그인 훅 | `CJump(AllPlayers,0) ... CJumpEnd` 구역 | ✓ |
| 매 사이클 맵 트리거 **전**(`beforeTriggerExec`) | 플러그인 훅 | 없음. FP 트리거 목록 맨 앞에 두는 것으로 근사 | ✗ 제약 |
| 매 사이클 맵 트리거 **후**(`afterTriggerExec`) | 플러그인 훅 | 없음. FP 트리거 목록 맨 뒤 | ✗ 제약 |
| 디버그 출력 | `DisplayText` | `DisplayPrint`/`DisplayPrintEr` | ✓ |

---

## 3. 실제 장애물

### 3.1 파이썬 의존은 사라지지 않는다

`STRCtrig Assembler v5.5.py`(1,941줄)의 `onPluginStart`는 tepc가 써낸 `TRIGP1~8.chk`를 `Db`로
싣고, "STRX PATCH" 루프에서 `Label` 트리거의 주소를 해석해 `SetCtrigX` 계열의 대상 EPD를 확정한다.
T/TT 변수 삽입, `CallLabelAlways`, Include 함수 호출이 전부 이 해석에 의존한다. 따라서 MSQC를 Lua로
옮겨도 빌드는 여전히 `tepc → euddraft(+어셈블러 플러그인)`이고, MSQC_INTERNALS.md 5.3절의
eudplib 0.80.6 호환 문제는 어셈블러 플러그인 쪽에서 똑같이 관리해야 한다.

### 3.2 실행 비용

CtrigAsm의 변수 삽입은 **실행 시** 대상 트리거의 필드(0x148 마스크, 0x158 플레이어, 0x15C 값, 0x160
연산자)를 `SetCtrig1X`/`SetCtrigX`로 고쳐 쓰고 `CallLabelAlways`로 그 트리거를 호출하는 방식이다.
같은 일을 eudplib는 `VProc`가 변수 여러 개를 트리거 하나에 묶어 한다.

| 작업 | eudplib(MSQC.py) | CtrigAsm | 근거 |
| --- | --- | --- | --- |
| 바이트 1개 가변 오프셋 쓰기 | `writebyte` ≈ 10 트리거 | `_ConvertBwriteX`: 입력 1 + 호출 1 + 출력 1 트리거 + Include 본체(오프셋→EPD·마스크·시프트 분해) | lua 43591행 |
| 15바이트 패킷 | `f_memcpy` ≈ 15×(read+write) ≈ 300 | `TBwrite`×15 ≈ 수백~천 단위, `f_Memcpy` 루프도 바이트당 본체는 동급 | 33534행 |
| 알파ID 1개 | `//84` ≈ 32단 나눗셈 | `CReadX` 32비트 + `CDiv 84` + 호출 규약 | 83690행 부근 |
| 선택 복원(12개) | 12×알파ID + 바이트 쓰기 | 동일 구조, 호출 오버헤드 추가 | |
| 수신 22비트 검사 | 변수 EPD 패치 1 + 조건 22 | Cp 트릭이면 동급, T 조건이면 22×패치 | 9장 |

정확한 배수는 컴파일해서 TRIG 수와 실행 트리거 수를 재야 하지만, 구조상 **송신 사이클 기준 2~3배**를
보는 것이 합리적이다. 절대량이 "불가능" 수준은 아니다. theSeed 정도 규모의 맵이 이미 프레임당 수천
트리거를 돌리고 있다.

### 3.3 훅 시점

euddraft는 `payloadMain`에서 `beforeTriggerExec → RunTrigTrigger → afterTriggerExec` 순서를
보장한다. CtrigAsm 코드는 `Trigger{ players = {FP} }`로 **한 플레이어의 TRIG 목록 안**에 들어가고,
클래식 트리거 루프는 P1부터 P8 순으로 각 플레이어의 목록을 돈다.

- 송신·수신을 FP 목록 맨 앞에 두면, FP보다 번호가 작은 플레이어 소유 트리거는 그 사이클의 수신값을
  **다음 사이클**에 본다. 1사이클 지연이고, 값이 사이클 중간에 바뀌지는 않으므로(리셋+쓰기가 한
  블록) 일관성은 유지된다.
- 선택 복원을 FP 목록 맨 뒤에 두면, FP보다 번호가 큰 플레이어의 트리거가 그 뒤에 돈다. 그 트리거들이
  커맨드 큐를 쓰지 않는 한 문제없다. 큐를 쓰는 다른 플러그인(euddraft 쪽)은 어차피
  `afterTriggerExec`라 CtrigAsm 복원보다 뒤다.
- 인간 플레이어가 나가면 그 플레이어 소유 트리거는 멈춘다. MSQC 대체 코드는 **항상 존재하는
  플레이어(컴퓨터 FP)** 소유여야 한다. theSeed의 FP 관례와 같다.

### 3.4 락스텝 경계가 코드 구조로 강제되지 않는다

MSQC.py는 로컬 읽기(`SendQC`)와 공유 쓰기(`ReceiveQC`)가 함수 경계로 나뉜다. Lua 포팅에서는 같은
트리거 목록에 섞이므로 GOTCHAS 6절의 규칙("로컬 조건으로 공유 쓰기를 게이트하지 말 것")을 사람이
지켜야 한다. 특히 `TTKeyPress`가 만드는 FCode(Ccode Deaths)는 로컬 값이다. 이 값을 조건으로
할 수 있는 공유 부작용은 **커맨드 큐 쓰기 하나뿐**이어야 한다.

### 3.5 NSQC.py가 이미 해결한 것을 다시 만들어야 한다

QCDummy(드래그 조작 방지), `dword` 2마리 모드와 에러코드, 화면/와이드 로케이션, `NSQCVArray` 연동,
`QCDebug` 안전장치. 그리고 NSQC.py 소스가 이 기계에 없어 "원본과 같은가"를 대조할 기준도 없다.

### 3.6 Lua 포팅이 유리한 점 (공정하게)

- 설정 파서와 `eval` 네임스페이스 해킹이 사라진다. 조건·출력이 Lua 코드라 `AssertQCUnitFree()` 같은
  컴파일 타임 검증을 자연스럽게 붙일 수 있다.
- MSQC_INTERNALS.md 7절의 C(보류 마스크), D(턴 감지 OR 합치기), G(빈 선택 해제)는 프로토콜 수준
  변경이라 Lua 변수로도 구현된다. 다만 같은 변경을 `Py/MSQC.py` 사본에 넣는 쪽이 코드량과 실행
  비용 모두 작다.
- 인덱스 규약 함정 하나: CtrigAsm의 `CunitCtrig` 루프 인덱스 i는 **역순**(`0x6509B0 = 161741 - 84*i`,
  i=0이 마지막 슬롯)이고 MSQC의 알파ID는 BW 인덱스+1이다. 둘 다 EPD에서 같은 알파ID를 내므로 값을
  주고받는 데는 문제없지만, "인덱스"라는 말을 양쪽에서 섞어 쓰면 틀린다.

---

## 4. 선택지 비교

| 선택지 | 내용 | 비용 | 남는 파이썬 | 판정 |
| --- | --- | --- | --- | --- |
| A. 현상 유지 + Python 개선 | `Py/MSQC.py`에 7절 A~G 적용. CtrigAsm는 지금처럼 `TDeaths` 소비 | 낮음 | 어셈블러 + MSQC/NSQC | **권장** |
| B. 하이브리드 | 전송만 하는 최소 플러그인(QC 유닛 관리, `QueueGameCommand` 15바이트 1회, waypoint 노출)과 Lua 상위(비트 패킹, 턴 합치기, 선택 관리) | 중간 | 어셈블러 + 최소 플러그인 | Lua에서 프로토콜을 자주 바꿀 때만 |
| C. 전면 Lua 포팅 | 2절 표 전부를 CtrigAsm으로 | 높음(3.2절), 훅 제약(3.3절) | 어셈블러 | 이득 없음 |

B의 실체는 NSQC.py가 이미 상당 부분 제공한다. NSQC.py 소스를 확보해 `NSQCVArray` 출력(`i.0`)과
`dword` 모드가 원하는 프로토콜을 지원하는지 먼저 확인하는 것이 B를 새로 짜는 것보다 싸다.

---

## 5. 그래도 C를 한다면: 설계 스케치 (미검증)

트리거 소유자는 컴퓨터 FP. 인간 수 H, 그룹 수 G(=`QCCount`)는 컴파일 타임 상수.

```lua
-- (1) 초기화 구역: units.dat 패치 + QC 유닛 생성
CJump(AllPlayers,0)
  QCEPD = {}  for g = 1, G do QCEPD[g] = CVArray(FP, 8) end   -- [g][player]
  MyAlpha = CreateVarArr(FP, G)                                 -- 로컬 플레이어의 알파ID
  DoActions(FP, { SetMemoryX(0x6644F8+q4, SetTo, 94*m4, 0xFF*m4), ... })  -- INTERNALS 3.3절 표
  for p = 0, 7 do  -- 인간만
    for g = 1, G do
      ptr, epd = CreateVars(2, FP)
      f_CunitRead(FP, 0x628438, ptr, epd)                       -- 빈 슬롯 = 다음 생성 유닛
      DoActions(FP, { SetLoc(QCLoc,"L",SetTo,QCX), ..., 
        CreateUnitWithProperties(1, QCUnit, QCLoc+1, p, {intransit=true, invincible=true}) })
      -- 유닛 좌표(0x28)로 로케이션 이동 → GiveUnits(1, QCUnit, p, QCLoc+1, QCPlayer)
      CDoActions(FP, { TSetDeathsX(Vi(epd,4), SetTo, 64*65537, 0, 0xFFFFFFFF),  -- moveTarget
                        TSetDeathsX(Vi(epd,13), SetTo, 0, 0, 0xFFFFFFFF),       -- topSpeed
                        TSetDeathsX(Vi(epd,19), SetTo, p, 0, 0xFF),             -- owner
                        TSetDeathsX(Vi(epd,55), Add, 0xA00000, 0, 0xFFFFFFFF),  -- statusFlags
                        TSetDeathsX(Vi(epd,41), SetTo, 0, 0, 0xFF00) })         -- uid
      CMov(FP, VArr(QCEPD[g], p), epd)
      CIfX(FP, { LocalPlayerID(p) })  f_EPDToAlphaID(FP, epd, MyAlpha[g])  CIfXEnd()
    end
  end
CJumpEnd(AllPlayers,0)

-- (2) 송신 (FP 목록 맨 앞, 로컬)
Len, XY = CreateVars(2, FP)
for g = 1, G do
  CMov(FP, XY, 64*65537)
  for k, bit in ipairs(Group[g]) do CTrigger(FP, Group[g][k].cond, { SetNVar(XY, Add, bit) }, {Preserved}) end
  CIf(FP, { NVar(XY, AtLeast, 64*65537+1) })
    CRead(FP, Len, 0x654AA0)
    CIf(FP, { TMemory(0x57F0D8, AtLeast, _Add(Len, 17)) })      -- 15 + 여유 2
      Base = _Add(Len, 0x654880)
      -- 09 01 [alpha lo][alpha hi] 15 [x lo][x hi][y lo][y hi] 00 00 E4 00 06 00
      f_Bwrite(FP, Base, SetTo, 0x09) ; f_Bwrite(FP, _Add(Base,1), SetTo, 1)
      f_Bwrite(FP, _Add(Base,2), SetTo, _And(MyAlpha[g], 0xFF)) ; ...   -- 15회
      CMov(FP, 0x654AA0, _Add(Len, 15))
    CIfEnd()   -- 부족하면 다음 사이클 (INTERNALS 7절 C: XY를 보류 변수에 OR)
  CIfEnd()
end

-- (3) 수신 (송신 직후, 공유)
for p in humans do
  DoActions(FP, { SetDeaths(p, SetTo, 0, u) for u in deathUnits })
  for g = 1, G do
    SaveCp(FP, CpBackup)
    CDoActions(FP, { TSetMemory(0x6509B0, SetTo, VArr(QCEPD[g], p)) })   -- Cp = QC EPD
    CIf(FP, { Deaths(CurrentPlayer, AtLeast, 64*65537+1, 4) })
      DoActions(FP, { SetDeaths(CurrentPlayer, Subtract, 64*65537, 4) })
      for k, bit in ipairs(Group[g]) do
        CTrigger(FP, { DeathsX(CurrentPlayer, AtLeast, 1, 4, bit) },
                     { SetDeaths(p, Add, Group[g][k].inc, Group[g][k].unit) }, {Preserved})
      end
      DoActions(FP, { SetDeaths(CurrentPlayer, SetTo, 64*65537, 4) })
    CIfEnd()
    LoadCp(FP, CpBackup)
  end
end

-- (4) 선택 복원 (FP 목록 맨 뒤, 로컬): 0x6284B8..+0x2C 읽기 → f_EPDToAlphaID ×n → 09 n [id]*n
```

주의: `CIf` 안에서 `NJump`로 빠져나오지 말 것(GOTCHAS 1절). `_Add`/`_And`의 첫 인자는 변수여야
한다(GOTCHAS 3절). `CRead`의 Source는 상수 PTR이어야 하며 `_Add`로 만든 식을 넣으면 크래시한다
(GOTCHAS 4절) — 위 스케치의 `f_Bwrite(FP, Base, ...)`는 `TBwrite`가 Offset에 V를 받으므로 그 함정과
무관하지만, `CRead`로 바꿔 쓰면 걸린다.

---

## 6. 판정 전에 실측해야 할 것

1. **NSQC.py 소스 확보**(Windows `euddraft0.9.2.0\plugins\NSQC.py`). `NSQCVArray` 연동 방식,
   `dword` 모드의 턴 내 유실 여부, QCDummy 구현을 보면 B 선택지의 대부분이 이미 있는지 판정된다.
2. `f_Memcpy(FP, DestV, Const, 15)`와 `TBwrite`×15의 실제 트리거 수. 두 버전을 컴파일해 TRIG 크기와
   `Ctemp/TRIGP*.chk` 차이로 잰다.
3. TEP `CreateUnitWithProperties(..., {intransit=true})`가 MSQC의 `UnitProperty(intransit=True)`와
   같은 hidden 상태(0x628438 free list 소비, 스프라이트 미표시)를 만드는지.
4. FP 트리거 목록 맨 앞/뒤 배치가 실제 로드 순서(`dir /b` vs `ls` 정렬 차이, TEP3.0 PLAN.md)와
   일치하는지.
