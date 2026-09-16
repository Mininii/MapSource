# R4b — eudext 설계 재료: 입력·동기화 / CX Paint 파이프라인 / 수학 / 소기능

작성 2026-09-17. 조사만 했고 원본 파일은 고치지 않았다. 확인하지 못한 내용에는 "(추측)"을 붙였다.

## 줄임말

| 줄임 | 경로 |
|---|---|
| CA | `ScmDraft 2\MapSource\Library\CtrigAsm v5.5.lua` |
| GB | `ScmDraft 2\MapSource\Library\Ctrig Assembler v5.4 Guide Book.txt` |
| CBP | `ScmDraft 2\MapSource\Library\CB Paint v2.5.lua` |
| EXT | `ScmDraft 2\MapSource\Library\Extra.lua` |
| OBC | `ScmDraft 2\MapSource\Library\ObserverChat.lua` |
| MSQC / NSQC | `C:\euddraft0.9.2.0\plugins\MSQC.py` / `NSQC.py` (설치본) |
| STRA | `C:\euddraft0.9.2.0\plugins\STRCtrig Assembler v5.5.py` |
| INT / FEA | `MapSource\Library\MSQC_INTERNALS.md` / `MSQC_CTRIGASM_FEASIBILITY.md` |
| EP | `C:\Users\whatd\.venvs\eud076\Lib\site-packages\eudplib\` (0.76.14) |
| DPS | `ScmDraft 2\DPS_eud\eud\` (lupa 이식 계층) |
| CAPI | `ScmDraft 2\theSeed\Engine\CAPlotIndexed.lua` |

실험 파일(스크래치패드): `lupa_cbpaint_exp.py`, `lupa_cbpaint_exp2.py`, `lupa_cbpaint_exp.log`, `math_sim.py`, `cbpaint_out\CS\exp_circle.txt`

---

## A. 입력과 동기화

### A1. 원리: 입력값은 모두 로컬 메모리다

| 주소 | 내용 | 쓰는 곳 |
|---|---|---|
| `0x596A18 + vk` | 가상 키 코드마다 1바이트짜리 키 상태. 누르고 있으면 1 | CA:80234 `ParseKeyName`, MSQC/NSQC `KeyPress`(NSQC:181) |
| `0x6CDDC0` | 마우스 버튼 비트. L=2, R=8, M=32 | CA:80275, NSQC:27 |
| `0x6CDDC4` / `0x6CDDC8` | 화면 기준 마우스 X / Y | NSQC:249~283 |
| `0x62848C` / `0x6284A8` | 화면 왼쪽 위 모서리의 맵 좌표 X / Y | CA:80424, NSQC:258 |
| `0x68C144` | 채팅 입력 대상. 0 = 채팅창 닫힘 | CA:80322~80328 |
| `0x512684` | 로컬 플레이어 번호. 관전자는 128~131 | OBC:76, EP `eudlib/utilf/userpl.py:21` |
| `0x6284B8` | 로컬 클라이언트의 선택 유닛 포인터 12개 | NSQC:1108 |

- 이 값들은 **각자의 PC에서만 다르다.** 공유 상태(데스값, 유닛, 로케이션, 공유 변수)를 이 값으로 조건 분기해 바꾸면 곧바로 디싱크가 난다. 가이드북도 "비공유 조건"이라고 적었다(GB:3699~3722).
- 표시만 바꾸는 것은 안전하다. 예: `DisplayText`, `PlayWAV`, `CenterView`, 로컬 전용 변수.

### A2. CtrigAsm 쪽 구현 (CA:80174~80328)

- `ParseKeyName(K)`: 표에서 가상 키 코드를 찾아 `0x596A18 + code`를 돌려준다. 없는 이름이면 `PushErrorMsg`(CA:80174~80236).
- `KeyPress(K,"Down"|"Up")`: `MemoryB(addr, Exactly, 1|0)` 조건 하나(CA:80238~80246). 누르고 있는 동안 계속 참(레벨).
- `TTKeyPress(K,"Down"|"Up")`: 누르는 순간·떼는 순간에 한 번만 참(엣지). TT 모드 20/21이고, 플래그 Ccode를 하나 쓴다(CA:80248~80272). FEA 2절은 비용을 "트리거 3개 + 스위치"로 적었다.
- `ParseMouseName`/`MousePress`/`TTMousePress`: `MemoryX(0x6CDDC0, Exactly, bit|0, bit)`(CA:80274~80320).
- `IsTyping` = `Memory(0x68C144, AtLeast, 1)`, `NotTyping` = `Exactly, 0`(CA:80322~80328).
- 동기화 기능은 CtrigAsm 자체에 없다. NSQC.py 플러그인에 맡긴다(GB 27장, 7597~7864).

### A3. MSQC.py / NSQC.py 가 동기화하는 방식

**원리(INT 0·1절).** 로컬 값을 "숨긴 QC 유닛에게 (x,y)로 이동하라"는 명령의 좌표에 실어 커맨드 큐에 넣는다. 지연 턴이 지나면 모든 클라이언트에서 그 유닛의 `moveTarget`(CUnit+0x10)에 같은 값이 생긴다. 이것을 읽어 데스값이나 배열에 풀어 쓰면 공유 값이 된다.
- 패킷: Select(4바이트) + Move 명령.
  - MSQC: `0x15` Targeted Order, 11바이트(MSQC:888~889, 923~924)
  - NSQC: `0x14` RightClick, 10바이트(NSQC:1169~1170, 1204~1205, 1429~1430)
- 한 턴에 보낸 여러 프레임의 명령은 같은 프레임에 차례로 실행된다. `moveTarget`은 필드가 하나라 **마지막 값만 남는다**(INT 5.1).
- 지연(INT 1.3, BWAPI): `LatencyFrames[speed] * (Latency + callDelay + 1)` 프레임. 구체적인 프레임 수는 이 기계에서 재지 않았다.

**수명주기.** euddraft 가 프레임마다 아래 순서로 부른다(INT 2절, MSQC:559·1199·1240, NSQC:820·1655·1696).
1. `onPluginStart`: `Respawn`. units.dat 슬롯을 덮어쓰고 플레이어별 QC 유닛을 만든다(INT 3.3).
2. `beforeTriggerExec`: `DebugQC` → `SendQC`(로컬) → `ReceiveQC`(공유)
3. 맵 트리거
4. `afterTriggerExec`: `RestoreSelUnits`. 원래 선택을 `0x09 Select`로 되돌린다.

**eds 문법** (`[MSQC]` 또는 `[NSQC]` 섹션. 키 = 조건 목록, 값 = 출력. 파서는 INT 3.1, NSQC:439~680)

```
QCUnit : 49                  # units.dat 를 통째로 덮어쓰므로 맵에서 쓰지 않는 슬롯이어야 한다 (기본 58)
QCDebug : false
QCLoc : 0 / QCPlayer : 10 / QC_XY : 128,128
X : 0, 1                                  # 맨 키 이름 = KeyDown(X). SetDeaths(누른 사람, Add, 1, 유닛 0)
KeyDown(X) / KeyUp(X) / KeyPress(X) : 유닛, 증가량
MouseDown(L) / MouseUp(R) / MousePress(M) : 유닛, 증가량
NotTyping; X : 유닛, 증가량               # ';' 로 조건을 AND 로 잇는다
0x58F450, Exactly, 0; X : 유닛, 증가량    # Memory 조건. '0xADDR, V' 형태는 비트 검사
Switch("Switch 210", Cleared); X : 유닛, 증가량   # 문자열은 eval (eudplib 이름공간 치환)
<조건> : 배열이름, 증가량                  # 네임스페이스의 EUDArray/EUDVArray 의 [플레이어] 칸
mouse : 로케이션                           # 사람 수만큼 연속 로케이션에 마우스 맵 좌표 부착
Always(); val, 0x58F500 : 유닛             # 값 채널. 0~valMask (256맵 0x3FFFFF)
Always(); xy, 0xA[, 0xB] : 유닛[, 유닛2]   # 맵 좌표 범위 값
--- NSQC 에만 있는 것 ---
Always(); dword, 0xADDR(, 0x에러코드) : 유닛   # QC 유닛 2마리, 32비트 전체. 받지 못한 사이클에는 에러코드
MouseMoved / ScreenMoved / WideScreen : 유닛, 증가량   # 로컬 조건
화면 | Screen : 로케이션                     # 화면 중앙 좌표 부착 (와이드 자동 보정)
... : 1.0                                   # 출력을 CtrigAsm NSQCVArray[1] 에 담는다
QCDummy : 227                               # 'Always(); val, 0x58A364' 를 항상 보낸다 (드래그 버그 방지, GB:7779)
```

theSeed 생성기는 `QCUnit = 49`처럼 `=`를 쓴다(`theSeed\MapLogic\EUDEditorEdsGen.lua:299~305`). DPS eds 는 `:`를 쓴다.

**받는 쪽(공유).** 플레이어마다 아래 순서로 처리한다(NSQC:1435~1653).
1. 등록된 데스 유닛을 모두 0으로 되돌린다. 배열 출력은 0으로, xy·val 배열 출력은 −1로 되돌린다.
2. QC 유닛의 `moveTarget ≥ 기준값+1`이면 비트마다 `SetDeaths(CurrentPlayer, Add, inc, unit)`을 실행한다.
3. `moveTarget`을 기준값으로 되돌린다.

→ 받은 값은 **"턴이 실행된 사이클에만 있는 펄스"**다(INT 3.5·5.1). theSeed 는 `val`을 `Always()`로 매 프레임 보낸다.

**NSQC 확장**
- `dword`(NSQC:573~589, 1336~1386, 1545~1578, 1630~1645): 하위 16비트와 상위 16비트를 QC 유닛 두 마리에 나눠 보낸다. 각 16비트는 x=하위 바이트, y=상위 바이트다(`f_low2posread_epd`, NSQC:766~769). 받는 쪽은 `Check`(low=+1, high=+2)가 3이 아니면 에러코드를 쓴다. 따라서 둘 다 도착한 사이클에만 실제 값이 들어 있다.
- `ScreenMoved`/`MouseMoved`(NSQC:249~315): 직전 사이클의 화면·마우스 값을 조건 트리거의 비교값에 되써 두고 달라졌는지 본다.
- `WideScreen`(NSQC:317~402): 순서는 아래와 같다.
  1. Location 1(0x58DC60)을 맵 중앙 `2^map_x`로 옮긴다.
  2. 로컬 플레이어만 `CenterView`한다.
  3. `0x62848C == 중앙 − 320`이면 일반 화면(640폭)으로 본다.
  4. 원래 화면 위치로 되돌리고 로케이션도 복원한다.
- `NSQCASM`(STRA:8~9, 1819; NSQC:1536 등): STRCtrig 플러그인이 CtrigAsm 변수 영역의 EPD를 이 변수에 넣는다. NSQC 는 `NSQCASM + cp*604 + i*604*8`에 직접 쓴다. CtrigAsm 전용 연결이다.
- CtrigAsm `NSQCSend`/`NSQCReceive`(CA:80851~, GB:7833~7860): VA 원소를 틱마다 하나씩 dword 채널에 싣는다. 같은 턴 안에서는 마지막 값만 남으므로(INT 5.1), 턴이 2프레임 이상이면 원소가 빠질 수 있다 (추측, 인게임 미확인).

**비트 예산**(INT 3.2): QC 유닛 하나에 불리언 20~24비트(맵 크기에 따라)를 싣는다. `val`·`xy`·`mouse`는 유닛 하나를 통째로 쓰고, `dword`는 두 마리를 쓴다. 이 수가 사람 수만큼 곱해진다. NSQC 계산식은 GB:7815~7818.

### A4. 두 문서의 결론

- FEA 0절: MSQC 를 CtrigAsm 으로 다시 짜는 데 막히는 원시 기능은 없다. 그러나 이득이 없다. 권장안은 "Python 전송 + 개선"이다.
- INT 7절 개선안:
  - B: 두 번의 QGC를 15바이트 한 번 쓰기로 합친다.
  - C: 버퍼가 넘치면 버리지 말고 다음 사이클에 다시 보낸다.
  - D: 같은 턴의 엣지를 OR 로 합친다.
  - E: `val` 은 값이 바뀔 때만 보내고 받는 쪽에 걸쇠(latch)를 둔다.
  - F: 컴파일 시점 검증을 늘린다.
  - G: 선택이 비었을 때 QC 유닛을 해제한다.
- INT 5.3 은 "로컬 MSQC 는 `EUDArray(8)` 키 캐시가 eudplib 0.80 에서 어긋난다"고 적었다. **0.76.14 에서는 문제없다.** 확인 근거는 두 가지다.
  - `EUDArray`는 주소를 가리키는 ExprProxy 다(EP `eudlib/eudarray.py:61~77`).
  - `Memory(addr)`의 EPD는 4로 내림 나눗셈을 한다(EP `utils/etc.py:19~22`). 그래서 `KeyArray + o//8`, 비트 `o%32` 조합이 결국 256비트 배열의 o번째 비트가 된다(계산으로 확인).

### A5. 비용

| 항목 | 비용 | 근거 |
|---|---|---|
| 로컬 키·버튼 조건 | 조건 1개 | CA:80240 |
| 엣지(이전 상태 캐시) | 키마다 갱신 트리거 2개 | NSQC:128~147 |
| MSQC 송신 1회 | 15바이트(NSQC 14바이트) + `f_memcpy` 바이트 루프 | INT 4절 |
| 선택 복원 | 2 + 2×선택 수 바이트 | INT 3.4 |
| 턴 버퍼 상한 | `0x57F0D8`, 최대 512바이트. 넘치면 eudplib 은 **조용히 버린다** | EP `eudlib/qgcf/qgc.py:67~84` |
| QC 유닛 | (불리언 묶음 수 + val/xy 수 + 2×dword 수 [+QCDummy]) × 사람 수 | GB:7815 |

### A6. eudplib 0.76.14 부품

| 부품 | 위치 |
|---|---|
| `f_getuserplayerid`, `IsUserCP` (0x512684) | `eudlib/utilf/userpl.py:21~28` |
| `QueueGameCommand`, `_Select/_AddSelect/_RightClick/_TrainUnit/_MinimapPing/_PauseGame/_UseCheat` 등 | `eudlib/qgcf/qgc.py:67~273` |
| `EUDVArrayReader` (순차 읽기, 원소당 약 2트리거) | `eudlib/memiof/varrayreader.py:12~` |
| `f_readgen_epd`, `f_posread_epd` (한 번에 x·y 분리) | `eudlib/memiof/memifgen.py:63, 222` |
| `PVariable`, `EUDLoopPlayer`, `f_playerexist` | `eudlib/utilf/pexist.py` |

키·마우스·채팅 주소를 쓰는 곳은 eudplib 안에 **없다**(0x512684 만 있음. grep 확인).

### A7. API 스케치

**(1) 로컬 전용 읽기 (표시용)**

```python
from eudext import local            # 이 모듈의 값은 절대 공유 상태로 흘려보내지 않는다

local.key_held("X")                 # Condition: MemoryX(0x596A18+0x58-r, Exactly, 256**r, 256**r)
local.key_pressed("X")              # 엣지. 내부 Db(32) 캐시 + local.update() 가 프레임 끝에 갱신
local.key_released("X")
local.mouse_held("L")               # MemoryX(0x6CDDC0, Exactly, 2, 2)
local.typing() / local.not_typing() # 0x68C144
x, y = local.mouse_map_xy()         # 0x62848C+0x6CDDC4, 0x6284A8+0x6CDDC8 (맵 크기 마스크)
sx, sy = local.screen_xy()
local.is_observer()                 # 0x512684 in 128..131
with local.only(player):            # EUDIf(Memory(0x512684, Exactly, p)) … 표시 액션만 쓰라는 구역
    DisplayText(...)
local.update()                      # 엣지 캐시 갱신. 모든 소비자 뒤에서 1회
```

- `local.only()` 안에서는 SetDeaths, CreateUnit 같은 공유 액션을 금지한다고 문서로 못박는다. 정적 검사는 어렵다(추측: 대기열에 액션이 쌓일 때 가로채 경고하는 정도는 가능).
- 키 이름 표는 CA:80175~80228 과 NSQC:28 을 그대로 쓴다. `'|'`(0xDC)와 `'\\'` 표기가 다르니 둘 다 받는다(GB:7651).

**(2) 동기화된 입력 — 권장 구조: "전송은 MSQC 계열에 맡기고, 선언·소비는 라이브러리가 한다"**

```python
from eudext import sync
bus = sync.Bus(transport="msqc", qc_unit=49, debug=False)   # 또는 "nsqc"
jump   = bus.key_down("SPACE", guard=[local.not_typing()])  # PlayerCounter: jump[p] 이번 사이클 펄스 수
fire   = bus.mouse_down("L")
cursor = bus.mouse_location(first="MouseP1")                # 사람 수만큼 로케이션
seed   = bus.value(local_var, cond="Always()", latch=True)  # val 채널. latch=True 면 받은 사이클에만 갱신한 PVariable
wide   = bus.dword(local_flag, error=0xFFFFFFFF)            # NSQC 전용
bus.eds_section()                   # -> "[MSQC]\n..." 문자열
bus.write_eds("build/map.eds")      # 빌드 스크립트가 euddraft 실행 전에 부른다
```

- **eds 를 사람이 적지 않게 하는 두 가지 길**
  - (a) 빌드 전 생성: 파이썬 선언을 모아 eds 조각을 쓴다. euddraft 는 eds 를 플러그인보다 먼저 읽으므로 **같은 빌드 안에서는 반영되지 않는다.** theSeed 생성기도 같은 한계를 적어 두었다(`EUDEditorEdsGen.lua:16`). 그러니 "선언 파일 → 생성 → euddraft" 순서의 빌드 스크립트가 필요하다.
  - (b) 프로세스 안 적재 (추측, 미검증): MSQC.py 는 import 할 때 모듈 전역 `settings`를 읽어 `onInit()`을 부른다(MSQC.py:481, NSQC.py:738 의 모듈 최상위 `onInit()` 호출). 라이브러리가 방법을 두 단계로 적재할 수 있다.
    1. 모듈 dict 에 `settings`를 먼저 넣고 소스를 `exec`한다.
    2. 그 모듈의 `onPluginStart/beforeTriggerExec/afterTriggerExec`를 라이브러리 훅에서 부른다.

    이때 eds 에는 `[MSQC]`를 **적지 않는다**(두 번 적재 방지).
- 출력 칸
  - 데스값 대신 `EUDArray`/`EUDVArray` 출력을 쓰면 데스 유닛 예약이 필요 없다. 등록 방법: `EUDRegisterObjectToNamespace` + 설정의 `배열이름, 증가량`(NSQC:1446~1466).
  - 받은 값은 **턴 펄스**다. 그래서 `latch`(마지막 수신값 유지)와 `level`(Down/Up 짝으로 토글) 도우미를 라이브러리가 준다. 근거: INT 5.1, GOTCHAS 6절.
  - NSQC `dword`는 받지 못한 사이클에 에러코드가 들어온다. latch 는 에러코드를 무시해야 한다.
- 스트림(`NSQCSend` 대체): 보내는 쪽도 공유 수신값을 볼 수 있다. 그래서 **자기 PC에서 방금 보낸 원소가 수신된 것을 확인한 뒤에야 다음 원소로 넘어가는** 방식으로 짜면 턴 안 유실이 없다. 확인 응답(handshake) 없이 턴당 원소 1개를 보낸다(설계안, 미검증).

**(3) `QueueGameCommand` 로 직접 동기화하는 대안**

- 유닛 없이 임의 데이터를 실을 공유 흔적은 거의 없다(INT 7H).
  - `0x58 MinimapPing`: UI 로컬이고 동맹으로 걸러진다. 쓸 수 없다.
  - `0x09 Select`: 선택 배열 `0x6284E8`이 공유로 남는다. 그러나 게임이 유효한 유닛만 받아 주므로 데이터를 싣기에는 비효율이다.
  - `0x13` 핫키: 현재 선택을 핫키 그룹에 복사하는 명령이다(추측). 그룹 번호에 1바이트를 실을 수는 있어 보이지만 검증이 필요하다.
  - `0x12 UseCheat`: 멀티플레이에서 처리되는지 미확인이다.
- 따라서 "직접 동기화"는 결국 **QC 유닛 + Select + Move** 이고, MSQC 를 라이브러리 안에 다시 짜는 일(`transport="native"`)이 된다.
  - 이득: INT 7절 B·C·D·G 개선을 넣을 수 있다. 수신 채널을 라이브러리 객체로 선언할 수 있다. eds 가 필요 없다.
  - 한계:
    - eudplib `QueueGameCommand`는 넘치면 조용히 버린다. 직접 바이트를 써서 재시도해야 한다.
    - units.dat 슬롯 하나를 영구로 점유한다.
    - 선택을 복원하는 코드가 **모든 맵 코드 뒤**에서 돌아야 한다. 라이브러리가 `before()/after()` 훅을 내보내고, 메인 플러그인이 그것을 맨 앞과 맨 뒤에서 불러야 한다.
    - MSQC/NSQC 와 같이 쓰면 QC 유닛·선택 복원이 충돌한다(추측). 전송 계층은 하나만 써야 한다.

### A8. 위험·미확인

- 로컬 값을 공유 로직에 섞는 실수가 가장 흔한 디싱크 원인이다. `local` 모듈에서 나온 값에 타입 표식을 붙여 두면 좋다(설계 권고).
- NSQC `화면/Screen`은 임시 로케이션에 로컬 화면에서 나온 값을 남긴다(NSQC:1250~1290). 첫 사람의 출력 로케이션이 수신이 없는 사이클에 로컬 값이 되므로, 이 로케이션을 게임 로직에 쓰면 디싱크가 난다 (추측, 코드 해석).
- 턴 프레임 수, SC:R 의 동적 턴 속도, `NSQCSend` 유실 여부: 인게임 미확인.
- MSQC 계열이 SC:R 에서 쓰는 `0x628438` free list 추정(INT 3.3): 미확인.

---

## B. CX Paint — 컴파일 시 파이프라인과 런타임 루프

### B1. 도형 테이블 형식 (CBP:1~15, 17~30, 459~517)

- `Shape = {n, {x1,y1}, {x2,y2}, …}`. **인덱스 1 = 점 개수 n, 2..n+1 = 점**(1 기반). 점은 `{x, y}` 실수(float)다.
- 단위는 픽셀이고, **중심 기준 상대 좌표**다. y 는 아래가 +(SC 화면 좌표).
- 각도 규약(CBP:9 주석 "0 degree = 12'o Clock Direction -> Clockwise (+)"):
  - CSMake 류는 내부에서 `Angle - 90`을 하고 `cos/sin`을 쓴다(CBP:463, 503~506). 그래서 0° = 12시, 각도가 늘면 화면에서 시계 방향으로 돈다.
  - 실험에서 `CSMakeCircle` 두 번째 점이 `(0, -32)`로 나왔다(아래 B3).
  - **주의:** 런타임 `f_Lengthdir`/`f_Atan2`(와 CA_ 함수)는 0 = +x(3시)다. 두 규약이 90° 어긋난다(C1 참고).
- 껍질 규칙: k번째 껍질에 k·Point 개의 점. `Hollow`는 안쪽부터 건너뛸 점 수(CBP:459~517).
- 트리거에 넣을 때 TEP 는 실수를 **0 방향으로 자른다**(cmp_A3 1절, DPS `ctrig/classic.py _i32`). 실험에서 1,700점 원 가운데 **1,184점이 자르기와 반올림 결과가 달랐다.** CtrigAsm 맵과 같은 배치를 원하면 자르기 규칙을 써야 한다.

### B2. euddraft 안에서 lupa 로 부르는 방법 (DPS 계층)

- **적재.**
  - `dps_eud.py:17~31`: euddraft 는 플러그인을 `exec`로 불러오므로 `__file__`이 없다. eds 의 `EudDir`, `VenvSite`를 `settings`에서 받는다.
  - `VenvSite`(lupa 가 깔린 site-packages)를 `sys.path` **뒤에** 붙인다. 앞에 붙이면 euddraft 내장 eudplib 보다 venv eudplib 이 먼저 잡힌다.
  - 내장 파이썬(3.11)과 판이 같아야 한다(`dps_eud.py:4~9`).
- **런타임.**
  - `ctrig/luart.py:147~`: `lupa.lua54.LuaRuntime(unpack_returned_tuples=True, register_eval=False, encoding="latin-1")`. latin-1 로 Lua 바이트와 파이썬 str 을 1:1 로 주고받는다.
  - 소스는 바이트로 읽어 BOM 을 떼고 `load(src, "@name")`로 실행한다(`luart.py:199~208`).
- **이미 있는 shim:** `bit32`(TEP lbitlib 의미와 같음, `luart.py:19~74`), `bit64`, TEP 네이티브 흉내(`__Print` 등, `luart.py:161~176`), `dofile`/`loadfile` 경로 바꿔치기, `C:\Temp` 쓰기 돌리기(`runtime.py:17~62`).
- **CX Paint 에 더 필요한 shim**
  - `math.atan2`: CBP:15061 `CS_ShapeInShape` 의 회전 옵션에서만 쓴다. 인자 순서가 `math.atan2(CX, CY)`인데 TEP 의미를 그대로 따르면 되므로 `math.atan2 = function(y,x) return math.atan(y,x) end`로 충분하다.
  - `FileDirectory` 전역: CSSave·BMP 류가 쓴다(CBP:8118~8220, 30341~).
  - `math.randomseed` 고정: CBP:3148 최상위에서 `math.randomseed(os.time())`를 부른다. 로드 **뒤에** 다시 시드를 넣어야 재현된다.
- lupa 기본 환경에 없는 것(실험 [0]): `math.atan2, pow, log10, ldexp, cosh`, `bit32`, `unpack`, `loadstring`, `setfenv`. CB Paint 는 이 가운데 atan2·bit32 만 쓴다(cmp_A3 5절과 일치).
- **CSPlot 류**(트리거를 방출하는 부분)는 `ConvertLocation`, `Trigger`, `CreateUnit` 같은 TEP/CtrigAsm 전역이 필요하다. 순수 lupa 에서는 실패한다(실험 [10]: `attempt to call a nil value (global 'ConvertLocation')`). DPS 이식 계층을 통째로 올리면 돌지만(cmp_A3 2절), 새 라이브러리에서는 **좌표 계산만** lupa 로 하는 편이 맞다.

### B3. lupa 실험 결과 (`lupa_cbpaint_exp.py`, `lupa_cbpaint_exp2.py`, 로그 `lupa_cbpaint_exp.log`)

venv 파이썬 3.11.9, lupa 2.8(Lua 5.4). DPS `ctrig.luart.BIT32_LUA`를 빌려 썼다.

| # | 시도 | 결과 |
|---|---|---|
| 1 | `CB Paint v2.5.lua` 로드 | **0.06초**. 전역 함수 391개(CS*/CA*/CB* 324개). 최상위에서 막히는 곳 없음 |
| 2 | `CSMakeCircle(6,32,0,37,0)` | n=37. `(0,0), (0,-32), (27.713,-16), (27.713,16), (0,32), …, (0,-64)…`. 최대 반지름 96. 0°=12시·시계 방향 확인 |
| 3 | `CSMakePolygon(4,40,0,25,0)`, `CSMakeLine(4,30,0,13,1)`, `CS_Rotate(c,45)`, `CS_MoveXY(c,100,-50)`, `CS_RatioXY(c,2,0.5)` | 모두 정상. Rotate 45: `(0,-32)→(22.63,-22.63)` = 시계 방향 |
| 3' | `CS_FillXY(0,128,96,16,16)` | n=48. 인자를 틀리게 넣은 첫 시도는 `CS_InputError`(**일부러 정의하지 않은 함수**)를 불러 `LuaError`로 멈췄다. 원본의 오류 방식이 그대로 동작한다 |
| 4 | `CSMakeGraphT({1,1},'__expT',0,0,8,nil,40)` (문자열 콜백 `_G[name]`) | n=40, 정상. 파이썬에서 Lua 함수를 정의해 넘길 수 있다 |
| 5 | `CS_ShapeInShape(circ, tri, 1, 0)` | shim 이 있으면 n=76. **shim 이 없으면** `CBP:15061 attempt to call a nil value (field 'atan2')` |
| 6 | 파이썬 리스트 → `L.table_from` → `CSMakePath`/`CS_ConnectPath(.,16)` | 동작한다. 단 `CS_ConnectPath`는 선분 안 보간점을 **끝점 쪽부터** 넣는다(CBP:8264~8268, 원본 동작) |
| 7 | `CSMakeSpiral.lua`, `CS_Addon.lua` 덧불러오기 | 각 0.00초. `CSMakeSpiral`은 나중에 불러온 `CSMakeSpiral.lua:1` 판이 이긴다 |
| 8 | `math.randomseed(1234)` 뒤 `CS_Shuffle` 두 번 | 같은 결과(재현 가능) |
| 9 | `CSSaveWithName("exp_circle",0,circ,"ExpCircle")` | `cbpaint_out\CS\exp_circle.txt` 생성(`os.execute("mkdir")` 도 동작) |
| 10 | `CSPlot(...)` | 실패(위 B2) |
| + | `CSMakeCircle(12,16,0,1700,0)` → `<hh` 로 묶기 | 0.006초, 절댓값 최대 272, 6,800바이트. 자르기·반올림 결과가 다른 점 1,184/1,700 |

막힌 점: 없음(함수 인자를 잘못 넣은 것뿐). 남은 확인 거리는 두 가지다.
- euddraft 내장 파이썬에서 VenvSite 경유로 lupa 를 불러오기. DPS 가 이미 쓰는 경로라 따로 돌리지 않았다.
- theSeed 의 맵별 도형 Lua(`CSMakeNatoriUsaChan` 등)를 같은 런타임에 얹기.

### B4. 자주 쓰는 진입 함수 (서명: CBP 줄)

- 생성
  - `CSMakePath(PathData,...)` 17
  - `CSMakePolygon(Point,Radius,Angle,Number,Hollow)` 67
  - `CSMakeCircle(...)` 459 / `CSMakeCircleX` 522
  - `CSMakeStar(Point,StarAngle,Radius,Angle,Number,Hollow)` 1272
  - `CSMakeLine(...)` 1724
  - `CSMakeGraphT(Ratio,Parafunc,Start,Direction,StepSize,StepRange,Number)` 2516
  - `CSMakeSpiral(Point,Magnificent,Coefficient,Radius,Angle,Number,Hollow)` (`CSMakeSpiral.lua:1`)
  - `CS_Level(Type,Point,Number)` 14410
- 변형: `CS_MoveXY(Shape,X,Y)` 2592, `CS_Rotate(Shape,Angle)` 2648, `CS_RatioXY(Shape,mulX,mulY)` 3029, `CS_MoveCenter` 6582
- 순서: `CS_Shuffle` 3149, `CS_SortRA` 28475
- 합치기·자르기: `CS_Overlap(A,B)` 4218, `CS_CropRA` 3417
- 채우기·경로: `CS_FillXY(Edge,areaX,areaY,sizeX,sizeY)` 4688, `CS_ConnectPath(Path,PerNumber,EndLine,Index)` 8250, `CS_ShapeInShape` 15043
- 저장: `CSSave(FileName,Local,...)` 8126, `CSSaveWithName(FileName,Local,shape,name,...)` 8148

### B5. 런타임: theSeed `CAPlotIndexed.lua` 구조

원본은 CBP `CBPlot`(CBP:15068~15420)이고, 이 파일은 그 복사본에서 세 곳만 바꿨다(CAPI:17~26).

- **좌표 저장**: 도형마다 X 배열과 Y 배열을 따로 둔다. `f_GetFileArrptrN(PlayerID, arr, 4, 1)`으로 파일 배열(원소 4바이트)에 싣는다(CAPI:84~98, 107~119). 점 개수는 `CA[10]`에 있다.
- **변수**(GB:20480~ "8장", CAPI:127~207)

| 변수 | 뜻 |
|---|---|
| `CA[1]` | 도형 선택 |
| `CA[2]` | 남은 대기 틱 |
| `CA[3]` | 한 사이클 뒤 더할 대기 |
| `CA[4]` | 이번 사이클에 찍은 수 |
| `CA[5]` | 사이클당 한도 |
| `CA[6]` | 점 번호 |
| `CA[7]` | 사용 금지 |
| `CA[8]`, `CA[9]` | 현재 점 X, Y |
| `CA[10]` | 점 수 |
| `CA[11~14]` | 자유 |
| `CB[1]` | PerUnit×2²⁴ |
| `CB[2]` | 유닛 |
| `CB[3]` | 소유자 |
| `CB[10]` | 0 보다 크면 이 점을 건너뜀 |
| `CA2[7]` | LoopMax 스케줄 포인터 |

- **여러 도형 선택**(바뀐 부분): 원본은 도형마다 `CIfX` 가지를 두고, 가지마다 `f_SHRead`를 두 번 넣었다. 도형당 약 17트리거였다(CAPI:8~15). 바뀐 판은 이렇게 한다.
  - 런타임 포인터 표 `CBPlotFXArr/FYArr`에서 선택된 도형의 배열 시작 주소를 한 번만 읽는다(CAPI:283~284).
  - 루프 안에서는 `시작 + CA[6]`을 두 번 읽는다(CAPI:327~328).
  - 결과: 도형당 약 4.0트리거로 줄었고, 인게임 검증도 마쳤다(CAPI:34~38).
- **루프**(CAPI:316~387): `while CA[2]==0`
  - `if CA[4]<CA[5] and CA[6]<CA[10]`이면 아래를 실행한다.
    1. 점을 읽는다.
    2. `CAfunc()`를 실행한다(`_G[CAfunc]`, CAPI:335).
    3. `CB[10]`이 서 있으면 CA[4]·CA[6]을 올리고 건너뛴다(CAPI:337).
    4. 중심을 구한다. 로케이션 L/R/U/D 를 읽어 평균을 내거나 고정 좌표를 쓴다.
    5. 로케이션을 점 ± PlotSize 로 옮긴다.
    6. `TCreateUnit(CB[1],CB[2],Loc,CB[3])`와 PerAction 을 실행하고 CA[4]·CA[6]을 올린다.
    7. 로케이션을 복원한다.
  - 조건이 거짓이면 `CA[2]=CA[3]`, `CA[4]=0`으로 두고 빠져나간다.
  - 마지막에 매 틱 `CA[2]-=1`(CAPI:411).
  - `Preserve`면 `CA[6]≥CA[10]`일 때 0으로 되돌린다(CAPI:391~409).
- **LoopMax 스케줄**: 배열 `{밴드수, c1, c2, …}`. 포인터는 1부터 시작해야 한다(CAPI:140~146, 232~237의 버그 수정 기록).
- **비용**
  - 정적 CSPlot 은 1,700점에 약 243트리거, 약 583KB 다(cmp_A3 2절. 점당 9액션, 63개씩 끊음, CBP:7023~7120).
  - 루프형은 도형 수와 무관한 트리거 몇십 개에 좌표표를 더한 크기다.
  - 런타임에 점 하나당 `f_SHRead`가 2~6회 돈다. 각 회는 비트마다 트리거가 하나라 수십 트리거다(추측, 재지 않음).

### B6. 가이드북 F 7장 CA_ 실시간 편집 함수 (GB:20371~20478, CBP:9658~10060)

CAfunc 안에서 현재 점 `CA[8],CA[9]`를 게임 도중에 바꾼다. **RA(극좌표) 계열은 `Include_MatheMatics(Cycle)`의 Cycle 단위를 따른다**(GB:20374).

| 함수 | 의미 | 구현 |
|---|---|---|
| `CA_ConvertRA(R,A,X,Y)` | 직교 → 극 | `f_Atan2(Y,X)`, `f_Sqrt(X²+Y²)` (CBP:9658) |
| `CA_ConvertXY(X,Y,R,A)` | 극 → 직교. 극으로 바꿨으면 마지막에 꼭 호출 | `f_Lengthdir(R,A)` → CA[8],CA[9] (CBP:9671) |
| `CA_MoveXY(X,Y)` | 평행이동 | `CAdd` (CBP:9687) |
| `CA_MoveRA(R,A)` | 극좌표 평행이동: r+=R, θ+=A | atan2, sqrt, lengthdir (CBP:9700) |
| `CA_RatioXY(mX,dX,mY,dY)` / `CA_RatioRA(mR,dR,mA,dA)` | x·mX/dX (정수 곱 → 부호 있는 나눗셈) | CBP:9718, 9753 |
| `CA_InvertXY(X,Y)` / `CA_InvertRA(R,A)` | 직선 x=X(원 r=R)에 대한 반전 | CBP:9804, 9833 |
| `CA_Rotate(θ)` | x' = x·cos − y·sin, y' = x·sin + y·cos. lengthdir 두 번 | CBP:9865~9881 |
| `CA_Rotate3D(xy,yz,zx)` | 평면별 회전. CA[11~14]를 덮어씀 | CBP:9883~9932 |
| `CA_CropXY(X1,X2,Y1,Y2)` / `CA_CropRA(R1,R2,A1,A2)` | 범위 밖이면 `CB[10]=1`(건너뜀). RA 는 부호 조건을 TTOR 로 처리 | CBP:9934, 10018~ |

각도 θ는 **Cycle 단위 정수**다(Cycle=360 이면 1°). 0 = +x 이고, y 가 아래가 +라서 각이 늘면 화면에서 시계 방향으로 돈다. 정적 CSMake 의 "0°=12시"와 90° 어긋난다.

### B7. eudplib 부품과 API 스케치

부품
- 좌표표: `Db`(바이트), `EUDArray`, `EUDVArray`(원소 72바이트)
- 순차 읽기: `EUDVArrayReader`(원소당 약 2트리거, EP `varrayreader.py:17~33`), `f_posread_epd`(x·y 를 한 번에, `memifgen.py:222`)
- 임의 읽기: `EUDVArray[i]`(인덱스 비트 28개, `vararray.py:155~166`), `f_dwread_epd`(32비트 트리거, `dwepdio.py:50~63`)
- 로케이션·소환·반복: `f_setloc`(`locf/locf.py:171`), `CreateUnit`/`CreateUnitWithProperties`, `EUDLoopRange`(`ctrlstru/loopblock.py:84`)

```python
from eudext.shape import CX, ShapeSet, Plotter

cx = CX(lib_dir=LIBRARY, extra=["CSMakeSpiral.lua", "CS_Addon.lua"],
        seed=1234, file_dir=BUILD_TMP, rounding="trunc")        # 컴파일 시 lupa 런타임 1개
ring  = cx.call("CSMakeCircle", 6, 32, 0, 37, 0)                # -> Shape([(x, y), …])
star  = cx.eval("CS_Rotate(CSMakeStar(5,72,60,0,CS_Level('Star',5,4),0), 15)")
cx.run_file(r"MapShapes\Natori.lua")                            # 맵별 Lua 도형도 그대로
shapes = ShapeSet([ring, star], storage="varray")               # "db"(작음, 읽기 느림) | "varray"(원소 72B, 순차 읽기 빠름)
# 저장: 점마다 dword 하나 = (x+0x8000) | (y+0x8000)<<16 (편향값). 도형 i 의 시작 EPD·점 수는 주소표에 (= CAPlotIndexed 방식)

plot = Plotter(shapes, unit=var_or_const, owner=P8, loc="CAPlot",
               per_tick=12, delay=1, size=0, repeat=False)
plot.start(shape=idx_var, center=(cx_var, cy_var))              # 또는 center="loc" (로케이션 현재 중심)
@plot.on_point                                                  # CAfunc 대체. pt.x/pt.y 는 EUDVariable
def fx(pt):
    pt.rotate(angle_var, cycle=360)                             # eudext.mathx 사용
    if EUDIf()(pt.x > 200): pt.skip()
plot.tick()                                                     # 매 프레임 1회. 트리거 수 = 도형 수와 무관
```

- 한 프레임의 루프 본체는 `EUDLoopRange(per_tick)` 하나다. 흐름: 읽기 → 편향값 빼기 → `on_point` → `f_setloc(loc, cx+x-size, cy+y-size, cx+x+size, cy+y+size)` → `CreateUnit` → 점 번호 증가.
- LoopMax 스케줄은 `EUDArray`로 둔다. 포인터는 1부터 시작한다(CAPI 버그 기록을 그대로 반영).
- 크기 비교(1,700점): `Db`/`EUDArray` 6.8KB, `EUDVArray` 약 122KB. 둘 다 CSPlot 583KB 보다 작다.

### B8. 위험·미확인

- 각도 규약 90° 차이(정적 0°=12시, 런타임 0°=3시). API 에서 `convention=` 인자로 드러내야 한다.
- 자르기·반올림 차이(1,184/1,700점).
- 원본 난수 시드(`os.time`)와 `pairs` 순서 때문에 결과가 비결정적이다(cmp_A3 5절).
- `CAfunc` 안에서 쓰는 임시 변수 충돌. CA_Rotate3D 는 CA[11~14]를 덮어쓴다(GB:20510).
- 런타임 비용(점당 트리거 수): 재지 않음.

---

## C. 수학

### C1. `f_Lengthdir(P, R, θ, Cos, Sin)` (호출 틀 CA:35153~35343, 본체 CA:84377~84638)

- `Include_MatheMatics(Cycle, LengthdirX)`(CA:31196~31289). Cycle 은 "2π = Cycle"이고 4의 배수여야 한다. 비우면 360(CA:84378~84380, GB:2163~2171).
- **보통 모드**(CA:84383~84479)
  - 표: `i = 0..Cycle/4` 마다 트리거 하나에 `0x10000·sin(i·90/R)`을 액션 값으로 저장한다. **Cycle/4+1 트리거**(360 이면 91)이고 VArray 로 읽는다.
  - 각 정규화: `θ ≥ Cycle`(부호 없는 비교라 음수도 여기에 걸림)이면 `CiMod`(부호 있는 나머지), 그다음 `θ ≥ 0x80000000`이면 `+Cycle`. **음수 각을 바르게 보정한다.**
  - 사분면별로 sin/cos 인덱스와 부호 플래그를 정한다. 흐름: `f_Mul` → `CiDiv(·, 0x10000)`(0 방향으로 자르는 부호 있는 나눗셈) → 부호 플래그면 `CNeg`.
  - 결과는 `Cos = R·cosθ`, `Sin = R·sinθ`. R 은 **−32768~32767**(표 값 ≤ 65536 × R 이 부호 있는 32비트 안에 들어야 함, GB:2461~2463).
- **LengthdirX(고정밀) 모드**(CA:84480~84637, STRCtrig 필수)
  - 파일 `FileDirectory.."f_Lengthdir"..R..".CMathTable"`에 **R×sin(θ)를 (Cycle/4+1) × 32768칸 dword로 미리 계산해 저장**하고, 맵에 파일로 넣는다(`f_GetFileptr`).
  - Cycle=360 이면 91×32768×4 = **11,927,552바이트**(계산).
  - 조회: R 을 절댓값으로 바꾼 뒤 `(각 인덱스 << 15) + R` 칸을 CP 로 가리키고, 32비트 트리거로 읽는다. cos·sin 을 따로 읽는다(32+32+α).
  - 실수 곱을 자른 정확값이다. 보통 모드는 "표를 자른 값 × R ÷ 65536"이라 두 번 잘린다.
  - `LengthdirMode==1`이면 호출 틀이 `RecoverCp`를 한다(CA:35340).
- 호출 비용: 인자 대입 트램펄린 2~3트리거(`SetCtrigX` + `CallLabelAlways`) + 호출·복귀 1 + 출력 2(CA:35158~35339). 본체에는 CiMod·곱셈 2번·나눗셈 2번이 있다.

### C2. `f_Atan2(P, dY, dX, θ)` / `f_Atan2X` (호출 틀 CA:34879~35151, 본체 CA:84640~85048)

- 입력 −32768~32767(GB:2472~2479).
- 사분면: 부호로 1~4 사분면 플래그를 정하고 절댓값을 만든다(CA:84650~84666).
- `Y<<16`(`ClShift2`) → `f_Div(Y, X)`로 **비율×65536**을 구한다. 여기서 입력 범위 제한이 나온다(Y·65536 < 2³¹).
- 탐색
  1. 거친 8갈래: `tan(k·90/8)`와 비교해 점프한다(CA:84672~84774).
  2. 세밀 선형: `ratio ≤ tan(i·90/R)`인 첫 i. 트리거 R개 + 1(CA:84783~84811).
  - 결과는 **올림 성격**이다. 예: (1,1) → 46.
- 사분면 보정: 2 → 2R−θ, 3 → θ+2R, 4 → 4R−θ(CA:84826~84832). 출력 0~Cycle(−1).
- `f_Atan2X`: R=64(256 주기)로 계산한 뒤 `+64 mod 256`(CA:85038~85039). **SC 방향 규약(0 = 위쪽)** 이고 출력은 `FATANX[4]`다.
- 트리거 수: 약 8 + Cycle/4 + 몇 개(360 이면 100 남짓). 호출당 세밀 탐색은 최대 Cycle/32 정도다.

### C3. `f_Sqrt` / `f_Log2` / `f_Square`

- `f_Sqrt`(CA:35345~, 본체 CA:84231~84375)
  1. 입력이 0이면 건너뛴다.
  2. 최고 비트를 찾는다(16트리거).
  3. 비트마다 후보를 더한다. 이 과정에서 `CMul` 서브루틴을 호출한다(점프 테이블은 `CtrigInitArr`/`STRxInitArr`에 둠).
  - floor(√X)를 구하고, 최대 15번 곱한다.
- `f_Log2`(CA:34772~34877, 본체 CA:85121~85190): floor(log₂X). **X=0 이면 0x80000000**, X=1 이면 0. `X ≤ 2^i−1`을 선형으로 찾는다(33트리거, 호출당 최대 32).
- `f_Square`(CA:85051~85118): 비트 곱 전개(`Include_MatheMatics`에 포함).

### C4. eudplib 0.76.14 와 비교

| 항목 | CtrigAsm | eudplib (`eudlib/mathf/`) |
|---|---|---|
| lengthdir 주기 | 임의 Cycle(4의 배수) | 360(`f_lengthdir`, 1° 표 91칸, `lengthdir.py:17~26`), 256(`f_lengthdir_256`, 입력에 +192 & 255 → **SC 방향 규약**, `lengthdir.py:108~121`) |
| lengthdir 음수 각 | 보정함 | 360판은 `angle>=360`이면 `%=360`뿐이다. 음수(부호 없는 큰 값)는 **틀린 각**이 된다. 256판은 마스크라 음수도 맞다 |
| lengthdir 음수 R | 부호 있는 곱·나눗셈 | 부호 없는 `*`와 `//`. **음수 R 은 틀린 값** |
| lengthdir R 범위 | ±32767 | 0~65535(65536 이상은 넘침) |
| 표 값 | 0 방향으로 자름 `0x10000·sin` | 반올림 `floor(v·65536+0.5)` |
| atan2 | 표 탐색(올림 성격), 임의 Cycle | 근사식 `z(45−(z−1)(14+4z))`(`atan2.py:16~`). x≥400이면 나눠 정규화한다. 360판과 256판(+64 → SC 방향) |
| sqrt | 비트 탐색 + CMul | `EUDBinaryMax(x*x<=n, 0, 0xFFFF)`(`sqrt.py:14`). 곱셈 16번 |
| log2 | 있음 | 없음 |
| 고정밀 2D 표 | LengthdirX | 없음 |

### C5. 모의 계산 (`math_sim.py`, 무작위 입력 20만 개, −32768~32767)

- 최악 절대 오차
  - eudplib `f_atan2`: **1.166°**, (x,y)=(12711,−5439)에서 338 대 336.83
  - CtrigAsm `f_Atan2`(360): **1.000°**, 올림 성격
- 작은 벡터
  - (1,1): eud 45 / ctrig 46
  - (1,2)[y=1,x=2]: 26 / 27
  - (1,−1000): 180 / 179 (참값 179.94)
- eudplib `f_lengthdir`
  - (100, −90) → (−97, 24). 기대값 (0,−100)
  - (−100, 0) → (65436, 0)
  - (65536, 0) → (0,0) 넘침
  - (100,45) → (70,70)

  음수 입력은 **조용히 틀린다.**

### C6. 부호 있는 비교 (TT `iAtLeast/iAtMost/iAbove/iBelow`)

- 상수: `iAtLeast=4, iAtMost=5, iAbove=6, iBelow=7`(CA:36~39). TT 모드 10~13으로 바뀐다(CA:18219~18226).
- 원리(CA:38827~38890, iAtLeast): 비교할 값 Y 를 `CRet[1]`에 복사한 뒤 트리거 3개로 가른다.
  1. `X ≥ 0 & Y < 0` → 참, 점프
  2. `X < 0 & Y ≥ 0` → 거짓, 점프
  3. 부호가 같으면 원래 부호 없는 조건
  - 부호는 `0x80000000` 마스크로 본다. 결과는 플래그 Ccode 에 담는다. **약 4~5트리거 + Ccode 하나**다.
  - 버그 흔적: `"i>" or Type == iBelow`처럼 문자열 비교가 틀린 줄이 있다(CA:18225). `"i<"`로는 iBelow 가 선택되지 않는다.
- eudplib 에는 부호 없는 `>=`,`<=`,`>`,`<`만 있다(cmp_A1 230행).
  - 가장 싼 대체: 임시 변수에 `+0x80000000`(= XOR 최상위 비트, 액션 1개)을 하고 부호 없는 비교를 한다.
  - 상수 비교는 조건 하나로 된다: `tmp >= (c + 0x80000000) & 0xFFFFFFFF`.

### C7. `f_Diff`, `CMathFunc`

- `f_Diff(P,Dest,Src,Mask,Time,Delay,Init)`(CA:74698~, GB:1802~1812, 예제 GB:10416~10462): `Dest = V − Vprev`를 구한 뒤 `Vprev = V`.
  - `Time ≤ 1`이면 매 틱, 아니면 Time 틱 주기다.
  - `Delay`: 첫 실행 전 대기. `Init`: 첫 실행 뒤 Vprev 가 정해지기 전까지 0으로 고정한다.
  - 구현: 트리거 자기수정으로 "Temp V"(트리거 액션 칸) 하나를 이전값 저장소로 쓴다(CA:74722~74770).
- `CMathFunc(P, "FuncName", Start, End, Exception, T, TException, Magnificent)`(CA:82109~82190, GB:4764~4792, STRCtrig 필수)
  - 컴파일할 때 `_G[Func](i)`를 정의역 Start~End 에서 계산해 파일 배열(4바이트)에 넣고, CFunc 로 조회한다.
  - `Exception`: `{"==",v,out}`, `{">=",…}`, `{"><",a,b,out}` 예외.
  - `T`: 주기. `CiMod` 뒤 음수면 `+T`.
  - `Magnificent`: 표 값에 M 을 곱해 저장하고, 호출 때 두 번째 인자 k 로 `f(x)·M·k/M`을 구한다(lengthdir 과 같은 방식).
  - `CMathFunc2`는 2변수판이다.

### C8. API 스케치

```python
from eudext import mathx as mx

x, y = mx.lengthdir(r, a, cycle=360, convention="math")  # r, a 부호 있음. cycle 은 4의 배수 아무거나
                                                          # convention="sc": 0=위, 시계 (256판 호환)
                                                          # "cs": CX Paint 정적 규약 (0=12시)
x, y = mx.lengthdir(r, a, cycle=360, exact=True)          # 2D 표(파일 삽입). 크기 경고 (360 → 11.9MB)
a = mx.atan2(dy, dx, cycle=360, mode="table"|"approx", convention="math")
r = mx.isqrt(n)                                           # 비트 탐색 (곱셈 없는 판 권장)
k = mx.ilog2(n, zero=0x80000000)                          # CtrigAsm 호환 0 처리
s = mx.signed                                             # s.ge(a,b) s.lt(a,b) … -> Condition / 결과 변수
d = mx.Delta(src, period=24, delay=0, hold_first=True); d.update()  # f_Diff
f = mx.Table(lambda i: 64*math.sin(math.radians(i)), 0, 359,
             period=360, scale=65536, exceptions=[("==", 90, 64)])  # CMathFunc: 파이썬 callable
v = f(x) ; v = f(x, k)                                    # scale 이 있으면 f(x)*k
```

- 구현 재료: 표는 `EUDArray`(작은 표) 또는 `Db`. 부호 있는 곱은 eudplib `*`(32비트 wrap이라 부호 있는 곱도 하위 32비트가 같음). 부호 있는 나눗셈은 `f_div_towards_zero`(`mathf/div.py`, 0 나눗셈 결과가 CiDiv 와 다름: cmp README).
- 음수 각 보정: `a %= cycle` 전에 부호 판정(C1 방식)을 한다.

### C9. 위험·미확인

- eudplib `f_lengthdir`/`f_atan2`를 **그대로 CtrigAsm 대체로 쓰면 음수·주기·반올림이 조용히 달라진다**(C5).
- eudplib 곱셈·나눗셈의 실제 트리거 수: 재지 않음.
- `f_div_towards_zero`의 0 나눗셈 동작을 `CiDiv`와 맞출지 결정해야 한다.

---

## D. 기타 소기능

### D1. 방장 번호·이름

- `GetHostPlayerID(P, Out)`(CA:80111~80121)
  - `CIfOnce` 안에서 `Out=-1`(관전자 방장)로 시작한다.
  - `i=0..7` 마다 `0x6D0F78`(방장 이름) 16바이트를 **`0x6D0FDC + 0x24·i`**(플레이어 이름 표) 16바이트와 dword 4개씩 비교해 `Out=i`로 둔다.
  - 한 번만 실행한다.
- 관련 함수
  - `HostName(Name,Len)`(CA:80055~80109): `MemoryX(0x6D0F78+…)` 조건
  - `PlayerName(p,Name,Len)`(CA:80000~80053): `0x6D0FDC+0x24p`
  - `GetHostName/GetHostLength/ItoHost`(CA:80123~80172, GB:4020~4040)
  - `CA__GetName`(CA:54880~54896, `0x6D0F78` / `0x6D0FDC`)
- 주의
  - 이름 비교에 **`0x57EEEB+36p`(게임 플레이어 구조체 이름, eudplib `IsPName`/`PName`, EP `stringf/pname.py:81~105`, `cpprint.py:74`)가 아니라 `0x6D0FDC` 표를 쓴다.** 두 표가 SC:R 에서 늘 같은 내용인지는 미확인이다.
  - 가이드북은 `GetPlayerName`에 "솔플시 제대로 작동 안될수도있음"이라고 적었다(GB:3897, 3912).
- 로컬 여부: 방 정보라 모든 클라이언트가 같다고 보인다(추측). 결과가 공유 로직에 쓰이므로 확인이 필요하다. 싱글플레이·리플레이에서 채워지는지도 미확인이다.
- eudplib: 대응 없음. `EUDOnStart`에서 `MemoryX` 4개 × 8 비교 트리거를 두면 된다(비용 약 8~9트리거, 1회).

### D2. 부대 지정 `HotkeyUnit` 계열 (CA:80795~80829, GB:3752~3784)

- 주소 `0x57FE60 + 0x360·p + 0x30·g + 0x4·i`를 **소스에서 확인했다**(`_HotKeyUnit`, CA:80827~80829).
  - 플레이어당 0x360 = 864바이트 = 그룹 18개 × 48바이트(12칸 × 4바이트)다. 가이드북이 문서화한 범위는 그룹 0~9, 인덱스 0~11이다.
- 값은 알파ID 다. `f_OffsetToAlphaID`/`f_EPDToAlphaID`의 결과를 쓴다(GB:3731~3743).
  - CA:80468 주석: `alphaID = 2048·tos(0xA5) + 1701 − index`(CtrigAsm 역순 인덱스). BW 인덱스 기준으로는 `(idx+1) | uid<<11`(INT 1.4)로 같은 값이다.
- 조건·액션
  - `HotkeyUnit`/`SetHotkeyUnit` = `FMemory`/`FSetMemory`
  - `THotkeyUnit`/`TSetHotkeyUnit` = `TDeaths(EPD(0x57FE60+0x360p+4i), …, Group)`. 그룹을 유닛 칸에 넣는 트릭이다(0x30 = 48 = 데스 테이블 한 줄 너비).
- 로컬 여부: 핫키 지정은 `0x13` 명령으로 네트워크를 탄다. 그래서 모든 클라이언트에 같은 값이 있다고 보인다(추측).
- eudplib: 대응 없음. `Memory/SetMemory`(상수)나 `MemoryEPD/SetMemoryEPD`(변수)로 짠다. `SetDeaths(EPD(base+0x360p+4i), …, g)` 트릭도 그대로 쓸 수 있다.

### D3. ObserverChat (OBC 1,066줄, `ObserverChatAlways.lua` 52줄; CtrigAsm 에도 들어 있음 CA:100659~)

관전자와 플레이어 사이의 채팅 대상을 로컬에서 강제한다. 전부 **로컬 조건**(`0x512684`) 아래에서 **로컬 메모리**만 쓴다.

| 함수 | 원리 | 주소 |
|---|---|---|
| `TogglePlayerModerate(P,"On"/"Off",Timer,T,…)` | 대상 플레이어의 Storm ID(`0x57EEE4+36p`, 0~15)를 찾아 `0x57F1D8`의 해당 비트를 켜거나 끈다(음소거 마스크, 추측) | OBC:12~68 |
| `TogglePlayerChat(P,Timer,T,Key,…)` | 플레이어가 키를 누르면 모드를 토글. 채팅창이 열리면 `0x68C144=5`(관전자에게) | OBC:70~249 |
| `ObserverChatToAll/ToNone/ToOb` | 키로 모드 비트(Timer 0x70000000)를 켜고, 채팅창이 열리면 `0x68C144` = 2(전체) / 3(없음) / 5(관전자) | OBC:322~488, 490~656, 1010~ |
| `ObserverChatToPlayer` | 8명 순환 선택. `0x57F1D8` 상위 16비트에 수신 Storm ID 비트, `0x68C144=4` | OBC:658~1000 |
| `ObserverChatToAllAlways(P,T,…)` | 관전자면 조건 없이 `0x68C144≥1 → 2` | `ObserverChatAlways.lua:25~51` |
| `ObserverDrop(P,Timer,T,Delay,…)` | 관전자 화면을 어둡게 한다(`0x657A9C=0`). Delay 뒤 **로컬에서만** CP=P9 로 `RunAIScript("Turn ON Shared Vision…")` 8번을 실행한다 → **일부러 디싱크를 내서 관전자를 떨어뜨린다**(추측, 코드 해석) | OBC:251~320 |

- 비용: 기능마다 트리거 2~40개(ToPlayer 는 8×8 순환이라 많음).
- 로컬 여부: 로컬 메모리만 쓰므로 안전하다. 단 `ObserverDrop`은 **의도적 디싱크**다.
- `Timer`는 사용자가 넘기는 EUD 주소다. 로컬 상태를 담는다.
- 함수 안에서 `LocalPlayerID`, `KeyPress`, `MemoryB`, `ParseKeyName`을 **전역으로 재정의**한다(OBC:71·91·101·118 등). 불러오는 순서에 따라 CtrigAsm 판을 덮어쓴다. 파일 머리말(OBC:5~10)에 PushErrorMsg 재정의 사고 기록이 있다.

### D4. `ExitDrop` 원리 (CA:83529~83558, 틀 CA:618~654, 680~773, 1143~1188; GB:3625~3630)

가이드북 설명: "대상 플레이어를 맵에 감금. 어떤 방법으로든 나가면 무한루프로 스타 크래시. 조건문으로 ExitDrop 실행을 멈추면 다음 틱에 해제. 승리·패배로 나가도 꺼짐."

**부품 해석**
- `SetCtrigX(P1,I1,A1,N1,Type,P2,I2,A2,EPD2,N2)`(CA:1827~): 라벨 I1 트리거에서 N1번째 뒤 트리거의 +A1 칸에 (라벨 I2 에서 N2번째 뒤 트리거의 +A2)의 **주소(EPD2=0) 또는 EPD(EPD2=1)**를 쓴다.
  - 트리거 노드는 +0x0 prev, +0x4 **next**, 한 칸이 0x970이다(CA:1878).
  - 액션 i 의 플래그 칸은 `0x148 + 0x20·i + 0x1C`다. 그래서 0x164 는 액션0, 0x184 는 액션1 이다.
- `Disabled(action)`은 SC 가 건너뛰는 액션이다. 첫 틱의 비보존 트리거 `Label(0xFFFE)`가 플래그를 지워 이 액션들을 **켠다**(CA:1157~1186: `SetCtrig1X("X",0xFFFD,0x164,…,0,0x2)`, `…0xFFFC,0x184…`).

**비 STRx 판**(`TEP30STRx==0`)

| 순서 | 트리거 | 하는 일 |
|---|---|---|
| 틀 맨 앞 | `0xFFFC`(보존) | 액션0: 자기 next = 바로 뒤 트리거(0xFFFE 가 다시 씀, CA:1179~1180). 액션1(켜짐): `next(0xFFFD) = 0xFFFF` → **해제** |
| 사용자 코드 | `ExitDrop(P, D)` | 조건 `LocalPlayerID(D)`. `next(0xFFFD) = 0xFFFD 다음 트리거 T` → **장전** |
| 틀 맨 끝 | `0xFFFD`(보존) | 액션(켜짐): `next(0xFFFC) = 0xFFFD` |
| 그 다음 | `T`(보존) | 액션(켜짐): `next(0xFFFD) = 0xFFFD`(**자기 순환**). T 의 next 는 0xFFFE 가 0xFFFF 로 맞춰 둠(CA:1181) |

- 한 프레임의 실행은 `0xFFFC → 사용자 코드 → 0xFFFD → (장전이면) T → 끝`이다.
  - T 는 0xFFFD 를 **이미 지나간 뒤에** 0xFFFD 를 자기 순환으로 만든다. 그래서 이번 실행은 멀쩡하다.
  - 다음 프레임은 0xFFFC 의 액션이 먼저 돌아 순환을 풀고, 0xFFFC 의 next 도 바로 뒤로 되돌린다. 그래서 **정상 실행은 절대 순환에 들어가지 않는다.**
- **프레임 사이(휴지 상태)의 사슬**은 `목록 머리 → … → 0xFFFC → 0xFFFD → 0xFFFD → …`다.
  - 대상 플레이어 PC에서만 이런 **무한 순환**이 남는다. 다른 PC 는 `0xFFFC → 0xFFFD → 0xFFFF`다.
- **트리거 액션을 실행하지 않고 목록을 따라가는 경로**가 이 순환에 들어가면 영원히 돈다. 원리를 정리하면 다음과 같다.
  - 게임을 떠날 때(나가기, 승리·패배, 드롭) SC 가 트리거 목록을 정리하려고 next 를 따라간다(추측).
  - 그 경로가 순환에 걸려 멈춘다. 가이드북이 "크래시"라고 부른 것이 이것이다.
  - 방증: eudplib `f_playerexist`는 "나간 플레이어의 트리거 목록 머리가 비었는가"로 판정한다(EP `eudlib/utilf/pexist.py:26~37`). 즉 SC 는 나간 플레이어의 목록을 비운다.
  - "조건으로 실행을 멈추면 다음 틱에 해제"(GB:3629)는 위 표의 해제 트리거와 정확히 맞는다.
- **디싱크가 없는 이유**: 바뀌는 것은 로컬 PC 의 트리거 next 포인터뿐이다. 게임 액션은 모든 PC 에서 똑같이 실행된다.

**STRx 판**(`TEP30STRx==1`, CA:630~640, 680~730, 741~750, 1157~1169)
- 같은 구조를 STRx 영역 트리거로 옮겼다.
  - `0xFFFD`가 `next(0xFFFC) = 0x1FFF6`로 둔다.
  - `0x1FFF6`(일반 목록)이 자기 next 를 해당 플레이어의 `0x1FFF2`(STRx)로 둔다.
  - `0xFFFC`가 `next(0x1FFF2) = 0x1FFF3`으로 해제한다.
  - `ExitDrop`은 `next(0x1FFF2) = 0x1FFF2+1`(= "ExitDrop 3")로 장전한다.
  - ExitDrop 3 은 `next(0x1FFF2) = 0x1FFF2`(자기 순환)로 둔 뒤 자기는 `0x1FFF3`으로 빠진다.
- 휴지 상태의 사슬은 `0xFFFC → 0x1FFF6 → 0x1FFF2 ⟲`다.
- 목록의 "X"는 `PlayerID` 목록이다. 가이드북 예 `ExitDrop(P1,"Ob1")`(GB:12990~12996)는 **P1 목록에** 순환을 심고 Ob1 PC에서만 장전한다.

**함정**
- DPS·Stella_II 는 비 STRx 형식(`"X",0xFFFD,…,1`)을 STRx 틀에서 직접 쓴다(`DPS_eud\OnInit.lua:213`, `Stella_II\MapLogic\OnInit.lua:460·476·495`). STRx 틀에서는 **0xFFFD 뒤에 순환 트리거가 없어 효과가 없고**(DPS `ctrig/framework.py:178` 주석과 일치), 바로 다음 액션 `SetMemory(0xCDDDCDDC, …)`(잘못된 주소 쓰기)가 실제 강제 종료를 맡는다.
- 순환을 심는 목록의 주인(PlayerID)이 먼저 나가면, 대상 PC가 그 목록을 치우다 멈출 수 있다(추측). **절대 나가지 않는 FP(컴퓨터 P8) 목록**에 심는 것이 안전해 보인다.

**eudplib 으로 옮긴다면 (설계안, 미검증)**
- eudplib 휴지 상태 사슬: `pts[p].first → tstart(p) → trs(p) → … → tre(p) → 끝`(EP `maprw/injector/inj_finalizer.py:205~252`, "Crash preventer" 214행).
- `tstart` 트리거는 실행될 때마다 **자기 next 를 `_t0`로 바꾸고, `_t0`가 다시 `trs`로 되돌린다.** CtrigAsm 의 0xFFFC 와 같은 "첫 트리거가 자동 해제" 성질이다.
- 따라서 순서는 다음과 같다.
  1. 런타임에 `tstart_ptr = dwread(0x51A280 + 12·p + 8)`로 FP 목록의 tstart 를 얻는다.
  2. 메인 루프 **끝**에서 로컬 조건이 맞으면 `SetMemory(tstart_ptr + 4, SetTo, trap)`을 실행한다. `trap`은 `RawTrigger(nextptr=자기자신)`이다.
  3. 다음 프레임에는 tstart 자신이 순환을 푼다.
- 주의
  - eudplib 이 8개 목록 모두에 tstart 를 거는지는 "원래 트리거가 있던 목록만" 조건(`inj_finalizer.py:231~233`)과 부트스트랩 트리거(`payload_init.py:78~93`)의 관계를 봐야 한다. 미확인이다.
  - `_runner_start/_runner_end`(`trigtrg/runtrigtrg.py:20~29`)는 비공개 이름이다. `TrigTriggerEnd(p)`만 공개다.
  - **인게임으로만 확인할 수 있다.**

### D5. `FindSD` / `FindSDLocal` / 와이드 스크린 판정

- `FindSD(P, TargetPlayer, Loc, Out, Preserve)`(CA:80402~80465, GB:3615~3623)
  1. 화면 좌표를 저장한다.
  2. Loc 를 크기 0으로 만들고 대상 플레이어의 유닛(기본 192 = 테란 마커)에 `MoveLocation`한다.
  3. CP 를 대상 플레이어로 두고 `CenterView(Loc)`를 실행한다.
  4. `loc.x == screen.x + 320`이면 일반 화면이라 Out=1, 아니면 와이드라 0이다.
  5. `저장한 화면 + (loc − 새 화면)`으로 로케이션을 옮기고 다시 `CenterView`해 원래 화면으로 돌아간다.
- `FindSDLocal(P, Loc, Out, Preserve)`(EXT:280~344): 대상이 `0x512684`(로컬 플레이어)이고 기본 유닛은 202 다.
- **로컬 여부**
  - `CenterView`는 CP 가 로컬 플레이어일 때만 화면을 움직인다. 그래서 **Out 과 마지막 로케이션 좌표가 PC 마다 다르다.**
  - 로케이션과 Out 을 게임 로직에 쓰면 디싱크가 난다.
  - 동기화하려면 NSQC `WideScreen` 조건(A3)이나 `val` 채널을 거쳐야 한다.
- 판정 한계
  - 유닛이 맵 가장자리에 있으면 CenterView 가 막혀(clamp) 오판한다. NSQC 는 이것을 피하려고 맵 중앙을 쓴다.
  - NSQC 가 쓰는 "중앙" `2^((dim-1).bit_length()+4)`는 맵 폭이 2의 거듭제곱보다 조금 클 때(예: 66타일 → 2048 대 폭 2112) 실제 중앙과 다르다. 와이드 반폭(약 427px, 추측)을 더하면 가장자리를 넘는다(계산으로 추정).
- eudplib 부품: `f_setloc`, `CenterView`, `f_getuserplayerid`, `f_dwread_epd(EPD(0x62848C))`.

### D6. 채팅 이름 바꾸기

- **eudplib `SetPName(player, *name)`**(EP `eudlib/stringf/pname.py:124~315`, 공개 함수 311·315행)
  - 채팅 표시 버퍼(`0x640B60`부터 218바이트 × 11줄, 다음 줄 포인터 `0x640B58`)를 훑는다.
  - 원래 이름(`0x57EEEB+36p`)으로 시작하는 줄의 이름 부분을 새 문자열로 **다시 쓴다.**
  - 줄 포인터가 그대로면 건너뛴다(최적화). `f_playerexist`로 나간 플레이어를 거른다.
  - **로컬 표시 버퍼만 바꾸므로 디싱크 걱정이 없다.** 다만 매 프레임 돌려야 한다.
- **CtrigAsm 쪽**: 이름을 바꿔 치는 루틴이 없다(cmp_A4 105행).
  - `isname.lua`의 `setname(p,Type,Race,Force,name)`(isname.lua:34~68)은 **플레이어 구조체 `0x57EEE8+36p`**에 타입·종족·세력·첫 글자를 한 dword 로, 나머지 이름을 4바이트씩 `SetMemory`한다.
  - 공유 메모리라 모든 PC에서 실행하면 디싱크는 없어 보인다. 그러나 **플레이어 타입(사람/컴퓨터)까지 덮어쓰므로 위험하다.** 채팅 표시에 실제로 반영되는지도 미확인이다.
  - `isname(p,name)`(isname.lua:23~32)은 같은 칸의 Memory 조건 목록이다(eudplib `IsPName`과 같은 역할).

### D7. API 스케치

```python
from eudext import misc

host = misc.host_player()                 # EUDOnStart 1회. 0~7, 관전자 방장이면 -1
misc.HostNameIs("Natori_sana")            # 조건 (0x6D0F78, 16바이트까지)
misc.hotkey_addr(p, g, i)                 # 상수 주소
misc.HotkeyUnit(p, g, i, Exactly, alpha)  # 조건 (g, i, alpha 는 변수 가능 → MemoryEPD)
misc.SetHotkeyUnit(p, g, i, SetTo, alpha)
misc.alpha_id(unit_epd)                   # (idx+1) | uid<<11

obs = misc.ObserverChat(timer=EUDVariable())   # 로컬 상태를 라이브러리가 소유 (주소를 넘기지 않음)
obs.force_all()                           # 관전자: 채팅창 열리면 0x68C144=2
obs.toggle_key("F2", modes=["all", "ob", "none"])
obs.mute(player, on=True)                 # 0x57F1D8 (Storm ID 비트)
# ObserverDrop(의도적 디싱크) 은 넣지 않거나 unsafe_ 접두사

misc.exit_trap(target=P1, list_owner=P8)  # D4 설계. unsafe_, 인게임 검증 전에는 실험 기능

w = local.is_widescreen()                 # NSQC 방식 (맵 중앙 CenterView). 로컬 값
bus.value(w)                              # 동기화가 필요하면 sync 채널로

SetPName(p, "\x04[VIP] ", PName(p))      # eudplib 그대로 쓴다 (표시 전용)
```

### D8. 위험 요약

| 항목 | 위험 | 이유 |
|---|---|---|
| ExitDrop / exit_trap | **최상** | 일부러 멈추게 하는 기능이다. 휴지 상태 사슬 가정과 목록 주인 선택이 틀리면 **다른 플레이어나 전원이 멈춘다**. SC 정리 루틴 동작은 추측이다. eudplib 은 비공개 사슬 구조에 기댄다 |
| ObserverDrop | 상 | 의도적 디싱크. SC:R 에서 누가 떨어지는지(다수결) 미확인 |
| FindSD / 와이드 판정 결과를 공유 로직에 사용 | 상 | 로컬 값이다. 로케이션에도 로컬 좌표가 남는다 |
| 로컬 키·마우스 값을 공유 로직에 사용 | 상 | 가장 흔한 디싱크 |
| setname(0x57EEE8) | 중 | 플레이어 타입 칸까지 덮어쓴다 |
| GetHostPlayerID | 중 | `0x6D0FDC` 표가 모든 PC·싱글에서 채워지는지 미확인. 결과가 공유 로직에 쓰인다 |
| HotkeyUnit | 하 | 주소 식은 확인했다. 공유 여부는 추측 |
| ObserverChat 계열 | 하 | 로컬 메모리만 쓴다. 전역 함수 재정의 부작용(Lua 원본) |

---

## E. 미확인 목록 (한곳에)

1. SC 가 게임을 떠날 때 트리거 목록을 next 로 따라가는지(ExitDrop 원리의 마지막 고리). eudplib tstart 가 모든 목록에 걸리는지.
2. 턴당 프레임 수(SC:R), `NSQCSend` 턴 안 유실 여부.
3. MSQC.py 를 eds 없이 모듈로 적재하는 방식(A7 (b))이 실제로 동작하는지.
4. `0x6D0F78`/`0x6D0FDC` 표의 공유성과 싱글 동작. `0x57FE60` 핫키 표의 공유성. `0x57F1D8` 비트의 정확한 의미.
5. `0x13` 핫키·`0x12` 치트 패킷을 데이터 채널로 쓸 수 있는지.
6. eudplib 곱셈·나눗셈과 CtrigAsm `f_SHRead`의 실제 트리거 수. CAPlot 점당 런타임 비용.
7. euddraft 내장 파이썬에서 CB Paint 를 lupa 로 불러오기(DPS 경로라 가능성은 높지만 이번에 돌리지 않음). theSeed 맵별 도형 Lua 를 같은 런타임에 얹기.
