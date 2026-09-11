# MSQC.py 내부 동작 분석 및 개선안

대상: [Py/MSQC.py](../Py/MSQC.py) (1241줄, euddraft 플러그인). 비교 기준: 업스트림
`armoha/euddraft/plugins/MSQC.py`(2026-09-11 기준 1231줄), 설치된 eudplib 0.80.6
(`~/.eudplib-linux/venv`), BWAPI 소스(`~/bwapi`, 커밋 d727fed6).

이 문서는 "왜 MSQC가 로컬 입력(키보드/마우스/로컬 메모리)을 디싱크 없이 공유 상태로 옮길 수 있는가"를
스타크래프트의 **커맨드 큐(QueueCommand)** 수준에서 설명하고, 코드의 각 단계를 해부한 뒤,
측정 가능한 근거가 있는 개선안을 우선순위대로 정리한다.

---

## 0. 한 줄 요약

MSQC는 **플레이어가 유닛에 내리는 명령은 네트워크로 브로드캐스트되어 모든 클라이언트가 같은 프레임에
똑같이 실행한다**는 락스텝 규칙을 데이터 채널로 악용한다. 로컬에서만 아는 값(키 입력, 마우스 좌표,
로컬 변수)을 **"보이지 않는 전용 유닛(QC 유닛)에게 (x, y)로 이동하라"는 명령의 좌표**에 인코딩해
커맨드 큐에 밀어 넣으면, 지연(latency) 턴 뒤에 모든 클라이언트의 그 유닛 구조체 `moveTarget`(0x10)에
같은 값이 나타난다. 이 값을 트리거가 읽어 Deaths 테이블/EUDArray에 풀어 쓰면 공유 값이 된다.

---

## 1. 스타크래프트 커맨드 큐 (BWAPI 소스로 확인한 사실)

### 1.1 메모리 구조

| 주소 | BWAPI 이름 | 의미 |
| --- | --- | --- |
| `0x654880` | `TurnBuffer[512]` | 이번 턴에 보낼 명령 바이트열 (`TURN_BUFFER_SIZE = 512`) |
| `0x654AA0` | `sgdwBytesInCmdQueue` | 현재 큐에 쌓인 바이트 수. 턴 전송 시 0으로 리셋 |
| `0x57F0D8` | (eudplib `_PROV_MAXBUFFER`) | Storm `SNetGetProviderCaps().maxmessagesize` 캐시. 실제 상한 |
| `0x485BD0` | `BWFXN_QueueCommand` | 원본 QueueCommand 함수. BWAPI는 여기에 `CommandFilter`를 jmp 패치 |
| `0x485A40` | `BWFXN_sendTurn` | 턴 버퍼를 즉시 전송 |
| `0x6556E4` | `Latency` | 0~2 (Low/Medium/High) |
| `0x51CE70` | `LatencyFrames[speed]` | 속도별 턴 프레임 수 |

출처: `bwapi/BWAPI/Source/BW/Offsets.h` 74~92행, `BW/Constants.h` 20행.

### 1.2 원본 QueueCommand의 동작 (`BWAPI/Source/DLLMain.cpp` 30~68행 재구현판)

```cpp
void QueueGameCommand(void *pBuffer, size_t dwLength) {
  dwMaxBuffer = clamp(caps.maxmessagesize, 0, 512);
  if (dwLength + sgdwBytesInCmdQueue <= dwMaxBuffer) {      // 들어가면
    memcpy(&TurnBuffer[sgdwBytesInCmdQueue], pBuffer, dwLength);
    sgdwBytesInCmdQueue += dwLength;  return;
  }
  // 버퍼가 꽉 찼으면: 전송 중 턴이 16-callDelay 미만일 때 턴을 미리 보내고 새 버퍼에 복사
  if (SNetGetTurnsInTransit(&turns) && turns < 16 - callDelay) {
    BWFXN_sendTurn();  memcpy(...);  sgdwBytesInCmdQueue += dwLength;
  }
}
```

핵심 두 가지:

- **턴 버퍼는 프레임마다 비워지는 게 아니라 턴마다 비워진다.** 한 턴 동안 여러 프레임의 명령이
  이어 붙는다. 매 프레임 15바이트를 보내면 턴 길이(프레임)만큼 곱해서 쌓인다.
- 원본은 꽉 차면 **턴을 앞당겨 보내서라도** 넣는다. eudplib의 `QueueGameCommand`는 이 분기가
  없어서 **조용히 버린다**(4절 참고). 키 입력 유실의 후보 1순위.

### 1.3 언제 실행되나

`GameImpl::getLatencyFrames()` (`BWAPI/GameImpl.cpp` 781행):

```
latencyFrames = LatencyFrames[GameSpeed] * (Latency + callDelay + 1)   // callDelay: LAN 2~8, 싱글 1
```

프레임 N에 큐에 넣은 명령은 모든 클라이언트가 프레임 N+latencyFrames 근처의 **같은 프레임**에
같은 순서로 실행한다. 그래서 명령이 남긴 유닛 구조체의 흔적은 공유 상태다.

### 1.4 MSQC가 쓰는 패킷 포맷 (`BW/OrderTypes.h`, `BW/UnitTarget.cpp`)

| ID | 이름 | 레이아웃 | 크기 |
| --- | --- | --- | --- |
| `0x09` | Select | `u8 0x09, u8 count, u16 target[count]` | 2 + 2n |
| `0x0A`/`0x0B` | SelectAdd / SelectRemove | 위와 동일 | 2 + 2n |
| `0x14` | RightClick | `u8 0x14, u16 x, u16 y, u16 unitTarget, u16 unitType(0xE4=None), u8 queued` | 10 |
| `0x15` | Targeted Order | `u8 0x15, u16 x, u16 y, u16 unitTarget, u16 unitType, u8 order, u8 queued` | 11 |
| `0x58` | MinimapPing | `u8 0x58, u16 x, u16 y` | 5 |

`unitTarget`(UnitTarget) 인코딩은 `(index + 1) | (uniquenessIdentifier << 11)`. index는
`(CUnit* - 0x59CCA8) / 336`, uniquenessIdentifier는 CUnit+0xA5. MSQC의 `f_epd2alphaid`가
이 식을 EPD 기준으로 옮긴 것이고, MSQC는 QC 유닛의 0xA5를 0으로 강제해 상위 5비트를 없앤다.

MSQC의 두 버퍼:

```python
SEL = Db(b"..\x09\x0112..")                  # [2..5]  = 09 01 [id lo][id hi]      -> 4바이트
RC  = Db(b"...\x15XXYY\0\0\xE4\0\x06\x00")   # [3..13] = 15 XX YY 00 00 E4 00 06 00 -> 11바이트
```

`RC`는 주석과 달리 RightClick(0x14)이 아니라 **0x15 Targeted Order, order = 6 (Move), queued = 0**
이다. 0x14를 안 쓴 이유는 QC 유닛의 units.dat `rightClickAction`을 6(Nothing)으로 바꿔 두기
때문(3.2절). 명시적 Move 오더는 rightClickAction과 무관하게 실행된다.

### 1.5 BWAPI도 같은 트릭을 쓴다

`BWAPI/Source/Detours.cpp` 526~580행 `CommandFilter`: BWAPI가 봇 명령을 넣은 뒤 사용자의
GUI 선택이 바뀐 걸 숨기려고 `ClientSelectionGroup`(0x597208, 12개)으로 `Select`를 다시 큐잉한다.
MSQC의 `RestoreSelUnits`와 동일한 설계다. 또 이 함수의 분기는 명령 ID 분류표로 쓸 수 있다:
`0x09~0x0B` 선택, `0x0C` 건설, `0x13` 핫키, `0x14`/`0x15` 타겟 명령, `0x18~0x36` 유닛 명령,
`0x5A` 다크아칸 합체.

---

## 2. 플러그인 수명주기 (euddraft `applyeuddraft.py`)

```python
def payloadMain():
    for f in onPluginStart:  f()            # 1회: MSQC.Respawn()
    while True:
        for f in beforeTriggerExec:  f()    # 매 사이클: DebugQC -> SendQC -> ReceiveQC
        RunTrigTrigger()                     # 맵 트리거
        for f in reversed(afterTriggerExec): f()   # 매 사이클: RestoreSelUnits
        EUDDoEvents()
```

`settings` 딕셔너리는 `.eds`의 `[MSQC]` 섹션 키/값이 그대로 모듈 전역으로 주입된다
(`pluginModule.__dict__["settings"] = pluginSettings`). `onInit()`은 euddraft 훅이 아니라
MSQC.py가 **import 시점**에 직접 호출하는 설정 파서다.

---

## 3. 코드 해부

### 3.1 설정 파싱 (`onInit`, 250~470행)

- `humans` = OWNR 섹션에서 값이 6(Human)인 P1~P8.
- 특수 키: `QCUnit`/`QCUnitID`, `QCLoc`, `QCPlayer`, `QC_XY`, `QCDebug`/`QCSafety`.
- 나머지 키는 `;`로 자른 **조건 목록**, 값은 **출력 방식**:

| 조건 토큰 | 생성되는 조건 | 비고 |
| --- | --- | --- |
| `KeyDown(K)` / 맨몸 키 이름 `K` | 0x596A18 키 상태 바이트 == 1 **and** KeyArray 비트 == 0 | 엣지. 한 사이클만 참 |
| `KeyUp(K)` | 키 상태 == 0 and KeyArray 비트 == 1 | 엣지 |
| `KeyPress(K)` | 키 상태 == 1 | 레벨. 누르는 동안 매 사이클 참 |
| `MouseDown/Up/Press(L|R|M)` | 0x6CDDC0 `InputFlags` 비트 2/8/32 + MouseArray 캐시 | 키와 동일 구조 |
| `NotTyping` | `Memory(0x68C144, Exactly, 0)` | 채팅 입력 중 아님 |
| `mouse` / `마우스` | `MouseMoved()` | 값은 로케이션. 플레이어별 `loc + p` |
| `val, <addr|var>` | 없음(조건은 앞의 토큰) | 값 = Deaths 유닛 또는 배열 |
| `xy, <src>[, <src>]` | 없음 | 값 = 유닛 1~2개 |
| `0xADDR, Modifier, Value` | `Memory(...)` | `eval(Modifier)` |
| `0xADDR, Value` | `MemoryX(ADDR, Exactly, V, V)` | 비트 테스트 |
| 그 외 문자열 | `eval()` | EUD 변수/배열 이름을 `_ns[...]`로 치환 후 평가 |

출력 방식 `유닛,증가량` → `["deaths", unit, inc]`, `배열이름,증가량` → `["array", name, inc]`.
`val`/`xy`/`mouse`는 `xy_cons`/`xy_rets`로, 나머지는 `qc_cons`/`qc_rets`로 간다.

**QC 유닛 수**: `QCCount = len(xy_rets) + ceil(len(qc_rets) / len(bit_xy))`.
불리언 조건은 `len(bit_xy)`개씩 한 유닛에 비트 패킹되고, `val`/`xy`/`mouse`는 각각 유닛 하나를
통째로 쓴다. 이 수가 **플레이어마다** 생성된다.

### 3.2 비트 예산 (`bit_xy`, `valMask`)

```python
bit_x, bit_y = dim_x.bit_length() + 2, dim_y.bit_length() + 18
bit_xy = [2**y for y in range(bit_y, 15, -1)] + [2**x for x in range(bit_x, -1, -1)]
```

좌표의 기준값(sentinel)은 `64 * 65537` = (x=64, y=64). 조건이 참이면 해당 비트를 더한다.
x에 2^0..2^bit_x, y에 2^16..2^bit_y를 쓰므로 최대 좌표는 `64 + 2^(bit_x+1) - 1`이고, 이것이
맵 픽셀 폭(`dim_x * 32`) 안에 들어오도록 `bit_length() + 2`로 잡은 것이다.

| 맵 크기 | 유닛당 불리언 비트 | `val` 값 범위 (`valMask`) |
| --- | --- | --- |
| 64 | 20 (x10 + y10) | 0 ~ 2^20-1 |
| 96 | 20 | 0 ~ 2^20-1 |
| 128 | 22 (x11 + y11) | 0 ~ 2^22-1 |
| 192 | 22 | 0 ~ 2^22-1 |
| 256 | 24 (x12 + y12) | 0 ~ 2^24-1 |

`val`은 기준값 `64*65537 + 1`(x=65, y=64)에 `f_v2posread_epd`가 값을 하위 `map_x`비트 → x,
상위 → y<<16 으로 쪼갠 것을 더한다. 수신 측 `f_pos2vread_epd`가 역변환.

`xy`는 소스 좌표(맵 마스크 적용)를 같은 기준값에 **더한다**. 즉 실제 x = 65 + px.
px가 맵 오른쪽 끝(예: 128맵에서 4031 이상)이면 4096을 넘는다. 게임이 Move 목표를 맵 안으로
클램프한다면 값이 깨진다. **실측 미확인 의심 지점**(7절 참고). `mouse`는 기준값 없이 좌표를
그대로 보내고, 우연히 (64,64)가 되면 (65,65)로 밀어 sentinel과 충돌을 피한다.

### 3.3 QC 유닛 만들기 (`Respawn`, 563~680행)

units.dat를 `QCUnit` 슬롯에 대해 통째로 덮어쓴다 (eudplib `scdata/unit.py` 기준 이름):

| 주소 | 필드 | 값 | 목적 |
| --- | --- | --- | --- |
| `0x6644F8` | flingy | 94 | 주석: Command Center flingy. 이동 애니메이션 없음 |
| `0x6617C8` | unitDimensions | 1x1 | 충돌/선택 박스 최소화 |
| `0x662860` | buildingDimensions | 0 | |
| `0x6636B8` / `0x6616E0` | groundWeapon / airWeapon | 130 (None) | |
| `0x662DB8` / `0x663238` | seekRange / sightRange | 0 | 시야 없음 |
| `0x662098` | rightClickAction | 6 = Nothing | 사용자가 실수로 우클릭해도 무반응 (3.7절) |
| `0x664080` | baseProperty | `0x38000025` | Building + Flyer + FlyingBuilding + AutoAttackAndMove + Attack + Invincible |
| `0x661518` | availabilityFlags | `0x1CF` → 생성 후 0 | CreateUnit 통과용, 끝나면 원복 |
| `0x6637A0` | groupFlags | 0 | |
| `0x660FC8` | movementFlags | `0xC5` | |
| `0x663150` | elevation | 19 | 최상층 |

플래그 이름은 BWAPI `BW/UnitPrototypeFlags.h` 기준. 이 덮어쓰기 때문에 **QCUnit 슬롯은
맵에서 다른 용도로 절대 쓰면 안 된다**. theSeed에서 기본값 58(Valkyrie)이 로스터와 겹쳐 게임 중
크래시가 났고, 이후 49를 MSQC 전용 예약 슬롯으로 명문화했다 (`theSeed/PROGRESS.md` 10-c).

생성 루프 (플레이어별 `QCCount`회):

1. `Memory(0x628438, Exactly, 0)`이면 `-1` 반환. 이 주소는 BWAPI Offsets.h에 없다. 생성 전에
   읽어 "다음에 할당될 CUnit"으로 쓰는 용법으로 보아 **빈 유닛 노드 리스트의 머리(free list head)**
   로 추정된다. 0이면 유닛 1700개 한도 초과.
2. `QCLoc` 로케이션을 `QC_XY` 한 점으로 만들고 `CreateUnitWithProperties(..., intransit=True)`.
   **`intransit`(수송선 탑승 상태)이 유닛을 화면에 안 보이고 마우스로 못 잡게 만드는 핵심**이다.
3. 유닛 실제 좌표(CUnit+0x28)를 읽어 로케이션을 그 점으로 옮긴 뒤 `GiveUnits(1, ..., QCPlayer)`.
4. CUnit 직접 패치: `+0x10` moveTarget = sentinel, `+0x34` flingyTopSpeed = 0 (부동),
   `+0x4C` playerID += cp - QCPlayer (**소유자를 바이트만 바꿈** — 플레이어 유닛 리스트에 안 들어가
   Bring/Command에 안 잡힌다), `+0xDC` statusFlags |= `0xA00000` (NoCollide | IsGathering, 겹침
   허용), `+0xA5` uniquenessIdentifier = 0.
5. 로컬 플레이어(`0x512684 == cp`)의 유닛이면 `MyQCptrs[i]`(조건의 비교값)와 `MyQCalphaids[i]`
   (SEL 패킷에 쓸 액션의 값)를 Forward 패치로 박아 넣는다. 로컬 전용 값이라 디싱크와 무관.

결과 EPD는 플레이어별 `EUDVArray(QCCount)`(`QC_EPDs`)에 저장되고 `ArrayPTRs`/`ArrayEPDs`
(PVariable)로 플레이어 인덱싱한다.

### 3.4 송신 (`SendQC`, 796~1043행, 로컬 전용)

1. **선택 저장**: `0x6284B8`(로컬 클라이언트의 선택 유닛 포인터 12개, BWAPI에는 없는 주소.
   `0x6284E8`부터가 공유되는 플레이어별 선택 배열이고 이건 그 앞 슬롯)의 첫 항목이 내 QC 유닛
   중 하나면 저장을 건너뛴다(`skipper` 트리거가 자기 nextptr을 바꿔 점프하고, 점프 대상이 되돌린다).
   아니면 최대 12개의 EPD를 `SelMem`에 저장하고 `SelCount`를 센다.
2. `f_setcurpl(f_getuserplayerid())`: 설정의 `Deaths(CurrentPlayer, ...)` 같은 조건이 **로컬
   플레이어 기준**으로 평가되게 한다.
3. 불리언 그룹마다: `RC+4 = sentinel`, 조건별로 `EUDIf` → `RC+4 += bit`. 하나라도 참이면
   `SEL+4 = alphaID`, `QGCActivated = 1`, `QueueGameCommand(SEL+2, 4)`,
   `QueueGameCommand(RC+3, 11)`.
4. `mouse`: 화면 좌상단(`0x62848C`/`0x6284A8` MoveToX/Y) + 마우스(`0x6CDDC4`/`0x6CDDC8`)를
   더해 맵 픽셀 좌표를 만든다. 동시에 `_IsMouseMoved`의 비교 상수를 갱신해 다음 사이클에 안 움직였으면
   보내지 않는다.
5. `val`/`xy`: 소스를 읽어 기준값에 더한 뒤 같은 두 패킷.

한 번 보낼 때 **15바이트**, `RestoreSelUnits`가 사이클 끝에 **2 + 2×SelCount(최대 26)바이트**.

### 3.5 수신 (`ReceiveQC`, 1046~1200행, 모든 클라이언트 동일)

플레이어 `cp`마다:

1. **등록된 모든 Deaths 유닛을 0으로 리셋**(`deathsUnits`, `val`의 대상 유닛 포함).
   `array` 출력은 0, `xy`의 배열 출력은 -1(“이번 사이클 수신 없음” 표시).
2. `EUDVArrayReader`로 QC EPD를 차례로 읽고 `moveTarget`이 `sentinel + 1` 이상이면 데이터.
   sentinel을 빼고 비트마다 `MemoryXEPD` 검사 → `SetDeaths(cp, Add, inc, unit)` 또는 배열 가산.
3. 다 읽으면 `moveTarget = sentinel`로 되돌린다.
4. `val`/`xy`/`mouse`는 역변환해서 `SetDeaths(SetTo)`, 배열 쓰기, `f_setloc(loc + cp, x, y)`.
5. 루프가 끝난 뒤 `KeyUpdate()`/`MouseUpdate()`가 엣지 캐시(KeyArray/MouseArray)를 갱신한다.
   SendQC보다 뒤에 있으므로 엣지는 정확히 한 사이클 동안만 참이다.

**따라서 MSQC의 Deaths 값은 "한 사이클짜리 펄스"다.** 1.2절과 합치면 더 정확히는 **턴이 실행된
직후 사이클에만 값이 있고 그 사이 사이클은 0**이다(5.1절). `val`도 예외가 아니라서 theSeed와
MSF_UE_RE는 `val`을 매 프레임 조건(`Always()`, `Switch(...)`)으로 계속 보낸다.

> `CTRIGASM_GOTCHAS.md` 7절은 NSQC.py의 `MousePress`가 "매 틱 Add가 발동해 무한히 누적"된다고
> 적고 있다. 이 저장소의 MSQC.py에는 위 1번 리셋이 있어 누적이 생길 수 없다. 이 기계에는 Windows
> `euddraft0.9.2.0\plugins\NSQC.py`가 없어 대조하지 못했다. 업스트림 euddraft 저장소의 `plugins/`
> 에는 MSQC.py만 있고 NSQC.py는 없다. 실제 배포에 쓰는 NSQC.py가 이 파일과 다른 계열이라면 그
> 파일을 기준으로 이 문서의 3.5절을 다시 확인해야 한다.

### 3.6 감시/복구 (`DebugQC`, `KillQCUnits`)

`QCDebug`가 켜져 있으면 매 사이클 모든 인간의 모든 QC 유닛에 대해 sprite==0(제거됨),
uniquenessIdentifier≠0(슬롯 재사용됨), 소유자≠cp 를 검사한다. 하나라도 걸리면 전원에게 에러를
출력하고 `KillQCUnits`(CUnit+0x110 `removeTimer` = 1)로 전부 지운 뒤 `Respawn`. 그것도 실패하면
`QCShutdown = 60*23` 사이클(약 1분) 동안 Send/Receive를 건너뛴다.

### 3.7 선택 복원 (`RestoreSelUnits`)

`SelCount >= 1`이고 이번 사이클에 명령을 보냈으면 저장해 둔 유닛들로 `0x09 Select`를 큐잉한다.
알파ID는 `(index+1) + (uid<<11)`을 런타임에 다시 계산한다(`f_tosread_epd`가 0xA5 바이트를
`<<11`로 읽음).

**빈 선택일 때의 구멍**: 사용자가 아무것도 선택하지 않은 상태에서 MSQC가 명령을 보내면
`SelCount == 0`이라 복원이 없고, QC 유닛이 그 플레이어의 선택으로 남는다. 다음 사이클에는
`skipper`가 "QC가 선택됨"을 보고 저장을 건너뛰므로 계속 그 상태다. 이때 사용자가 `S`(정지) 같은
핫키를 누르면 QC 유닛에 Stop이 들어가 `moveTarget`이 유닛 좌표(기본 128,128)로 바뀌고, 수신
측은 이를 데이터(x 비트 6)로 해석한다. `rightClickAction = 6`은 이 상황에서 우클릭만 막는
방어다. 7절 G 항목에서 해결책을 다룬다.

---

## 4. eudplib `QueueGameCommand` 구현 (`eudplib/qgc/qgc.py`)

```python
_cmdqlen = EUDVariable();  _len_cache = Memory(0x654AA0, Exactly, 0)
def _update_cmdqlen():                      # 0x654AA0가 캐시와 다를 때만 다시 읽음 (턴 전송 감지)
    if EUDIfNot()(_len_cache): f_dwread_epd(EPD(0x654AA0), ret=[_cmdqlen]); ...
class QueueGameCommandHelper:               # new_len + 2 <= maxmessagesize 일 때만 진입
    __enter__: if EUDIfNot()(Memory(0x57F0D8, AtMost, new_len + 1)): ...
    __exit__ : 0x654AA0 = new_len; 캐시 갱신
@EUDFunc
def QueueGameCommand(data, size):
    with QueueGameCommandHelper(size) as qgc:
        f_memcpy(0x654880 + qgc.cmdqlen, data, qgc.size)
```

- `f_memcpy`는 목적지가 변수라 **바이트 단위 루프**(`EUDByteReader.readbyte` +
  `EUDByteWriter.writebyte`, 15바이트 = 15회 반복 × 읽기/쓰기)로 떨어진다. MSQC 코드의
  `# TODO: Optimize QueueGameCommand and f_memcpy` 주석이 가리키는 지점.
- 버퍼가 부족하면 **아무 일도 하지 않는다**. docstring도 "silent"라고 명시. 원본 게임(1.2절)과
  다른 유일한 의미 차이다.
- 같은 파일의 `_qgc_alphaids`(`QueueGameCommand_Select` 계열)는 memcpy 없이 `EUDByteWriter`로
  바이트를 직접 쓰고, 유닛 포인터로부터 알파ID를 11단 이진 탐색 트리거로 계산한다. 5절 개선안 B의
  참고 구현.

---

## 5. 이 분석에서 새로 드러난 동작 특성

### 5.1 같은 턴 안의 이벤트는 마지막 것만 남는다

한 턴 동안 프레임 f, f+1의 패킷이 모두 쌓였다가 같은 프레임에 순서대로 실행된다:
`Select QC, Move(v_f), Select 원래, Select QC, Move(v_{f+1}), Select 원래`. `moveTarget`은 단일
필드이므로 `v_{f+1}`만 남고, 트리거는 그것만 읽는다.

- 불리언 그룹: 프레임 f에 `KeyDown(A)`, f+1에 `KeyDown(B)`가 같은 턴에 들어가면 **A 이벤트가
  사라진다**. 같은 프레임에 눌리면 한 패킷에 두 비트가 들어가 괜찮다.
- `val`/`xy`/`mouse`: 최신값만 필요하므로 무해.
- `KeyPress`(레벨) 조건: 누르고 있는 동안 Deaths 값은 **턴 주기의 펄스**로 보인다.

수신 측 리셋(3.5절 1번)과 합쳐 보면, 소비자 트리거는 "Exactly N인 사이클이 한 턴에 한 번 온다"고
가정해야 한다. 이는 GOTCHAS 6절의 "MouseDown/Up 짝으로 슬롯을 토글해 레벨을 만들라"는 지침과
정확히 맞아떨어진다.

### 5.2 대역폭은 프레임이 아니라 턴 단위로 쌓인다

| 항목 | 바이트 |
| --- | --- |
| 불리언 그룹 1회 송신 | 15 |
| `val` / `xy` / `mouse` 1회 송신 | 15 |
| 선택 복원 (n개 선택) | 2 + 2n (최대 26) |
| 상한 | `maxmessagesize`(0x57F0D8), 최대 512 |

`val` 4개 + 마우스 + 12개 선택 = 15×5 + 26 = 101바이트/프레임. 턴이 3프레임이면 303바이트.
`val` 8개면 프레임당 146, 턴당 438로 상한 근처다. 넘치면 eudplib는 조용히 버린다(4절).
가장 먼저 버려지는 것은 그 프레임의 마지막 큐잉, 즉 `RestoreSelUnits`의 Select이고(afterTriggerExec
에서 실행), 그러면 QC 유닛이 선택으로 남는 3.7절 상황이 된다.

### 5.3 로컬 사본은 업스트림보다 오래된 판이다

`diff` 결과 의미 있는 차이:

| 항목 | 로컬 (`Py/MSQC.py`) | 업스트림 |
| --- | --- | --- |
| 키/마우스 엣지 캐시 | `EUDArray(8)` / `EUDArray(1)` | `Db(32)` / `Db(4)` |
| `LOC_TEMP` 저장 | `SetMemory(LOC_TEMP, ...)` (포인터 가정) | `LOCPTR = LOC_TEMP*4 + 0x58A364 if LOC_TEMP._is_epd()` |
| 배열 출력 EPD 계산 | `EPD(array) + cp` | `array if array._is_epd() else EPD(array)` |
| `EUDVArray` 판별 | `isUnproxyInstance(v, EUDVArray(8))` | `VArrayType = type(QC_EPDs[0])` |
| `parseCond` 치환 대상 | EUD 변수 4종만 | 네임스페이스의 모든 이름 |
| `parseSource` | `val`/`xy` 분기 안에 중복 정의, `val`쪽은 인자 대신 `ret[1]`을 씀 | 바깥에 1개, `getValueAddr` 없으면 `EPD(ret)` |

eudplib 0.80.6에서 `EUDArray`는 기본이 **EPD 값**(`collections/eudarray.py` 19행
`_ptr_array = False`)이다. 그러면 로컬 사본의 `KeyArray + offset // 8`은 바이트 오프셋이 아니라
dword 오프셋으로 더해지고, `SetMemory(LOC_TEMP, ...)`는 EPD를 주소로 오해한다. **euddraft
0.9.2.0(Windows, 구 eudplib)에서는 맞지만 헤드리스 파이프라인(eudplib 0.80.6)에서는 키 엣지 캐시가
엉뚱한 곳을 가리킨다.** 헤드리스 빌드가 어느 MSQC.py를 로드했는지는 이 기계에서 확인할 수 없었다
(euddraft 체크아웃이 남아 있지 않음).

---

## 6. 이 저장소에서의 실제 사용 예

- theSeed `MapLogic/EUDEditorEdsGen.lua` 282행: `[MSQC]` + `QCUnit = 49`, `QCDebug = false`,
  키마다 `Memory(0x68C144,Exactly,0);Switch("Switch 210", Cleared);<KEY> = <unit>,<inc>`,
  마우스/채팅 시드는 `Switch(...); val, 0x<addr> : <unit>`.
- MSF_UE_RE `Var_Include.lua` 64행 주석: `Always() ; val, 0x58F500 : 180` (브금 타이머),
  `Deaths(CurrentPlayer,Exactly,1,441);RIGHT = 200,1` 등. 송신은 `func.lua` `IBGM_EPDX`가
  `0x58F500`에 값을 쓰고, 수신은 `Operator.lua` 7행이 `0x58A364 + 48*180 + 4*i`(플레이어 i의
  유닛 180 Deaths)를 읽는다.
- 소비 패턴: `MSQC_TKeyInput(Player, Key)` = `TDeaths(Player, Exactly, inc, unit)`
  (`NewTestMap3/function.lua` 781행). 런타임 Player 변수를 그대로 쓸 수 있어 `DtoA` unroll이 필요
  없다는 것이 GOTCHAS 6절의 요지.

---

## 7. 개선안 (근거가 있는 순서)

### A. 로컬 사본을 업스트림 기준으로 동기화 — 헤드리스 빌드 정합성

5.3절의 네 가지 차이를 그대로 반영하면 된다. `Db(32)`/`Db(4)`, `LOCPTR`, `_is_epd()` 분기,
`VArrayType`. 이것만으로 eudplib 0.74/0.80 양쪽에서 같은 코드가 돈다. `parseSource`의 `ret[1]`
버그도 같이 사라진다. **Windows 빌드에 영향 없음**(업스트림이 그 환경을 지원).

### B. `QueueGameCommand` 두 번 + `f_memcpy` → 15바이트 한 번에 직접 쓰기

현재 송신 1회 = `_update_cmdqlen` 2회, 길이 검사 2회, 바이트 루프 15회(각 readbyte + writebyte).
SEL과 RC를 **한 `Db`에 이어 붙여**(`09 01 id id 15 XX YY 00 00 E4 00 06 00`) 길이 검사 1회,
그리고 `f_memcpy` 대신 `EUDByteWriter.seekoffset(0x654880 + cmdqlen)` 후 상수 바이트는 리터럴로,
가변 4바이트(알파ID 2, XY 4)는 변수 바이트로 `writebyte`한다. 읽기 루프가 통째로 없어져 송신
비용이 대략 절반이 되고, `qgc.py`의 `_qgc_alphaids`가 이미 같은 방식이다. 알파ID는 `Respawn`
때 확정되므로 상위/하위 바이트를 미리 변수로 쪼개 두면 런타임 분해가 필요 없다.

더 줄이려면 `cmdqlen & 3`으로 4갈래 분기해 `SetMemoryX` 마스크로 dword 단위 5회 쓰기가 가능하지만,
XY의 8·16·24비트 시프트를 트리거로 만들어야 해서 이득이 확실치 않다. B의 첫 단계만 권장.

### C. 버퍼 넘침을 "버림"에서 "다음 프레임 재시도"로 — 키 유실 방지

송신 전에 `0x57F0D8 - 0x654AA0 >= 15 + (2 + 2*SelCount)`(복원까지 들어갈 자리)를 검사하고,
안 되면 이번 사이클 비트를 **보류 마스크**에 OR 해 두고 다음 사이클에 다시 시도한다. 엣지
조건은 한 사이클만 참이므로 지금은 버려지면 그대로 유실이다. 4절의 eudplib 동작과 1.2절의
원본 동작 차이를 플러그인 쪽에서 메우는 셈이다.

### D. 같은 턴 안의 엣지 합치기 — 5.1절 유실 해결

턴 전송은 로컬에서 감지할 수 있다. `0x654AA0`가 직전 사이클 값보다 작아졌으면 그 사이 턴이
나간 것이다(eudplib `_len_cache`가 쓰는 바로 그 성질). 그룹마다 `pending` 변수를 두고:

1. 턴 전송이 감지되면 `pending = 0`.
2. 이번 사이클 엣지 비트를 `pending |= bits`.
3. `bits != 0`이면 `XY = sentinel + pending`으로 송신.

한 턴의 마지막 패킷이 그 턴의 모든 엣지를 담으므로 수신 측 비트별 `Add`가 각 키를 정확히 한 번
센다. 같은 키가 한 턴에 두 번 눌리는 건 지금도 한 번으로 세므로 의미 변화가 없다. 추가 유닛이
필요 없고 C의 보류 마스크와 같은 변수를 공유할 수 있다.

대안은 그룹당 QC 유닛을 k개 두고 프레임마다 돌려쓰는 것(k ≥ 턴 프레임 수). 유닛과 Respawn 비용이
k배라 D를 먼저 권한다.

### E. `val` 송신 절감 — 바뀐 값만, 단 수신 리셋을 같이 바꿔야 함

`val`은 지금 매 프레임 15바이트를 쓴다(5.2절). "값이 바뀐 사이클 + 턴 전송 직후 사이클"에만
보내면 대부분 제거되지만, 수신 측이 매 사이클 Deaths를 0으로 리셋하므로(3.5절) **`val` 대상
유닛만 리셋에서 빼는 latch 옵션**을 함께 넣어야 소비자가 계속 값을 읽을 수 있다. 소비자
코드(`Operator.lua`의 `f_Read`, `IBGM_EPDX`)가 "0이면 미수신"에 의존하는지 먼저 확인할 것.
배열 출력의 `-1` 마커도 같은 이유로 옵션 밖에 둔다.

### F. 정적 검증 강화 — 컴파일 시점에 잡을 수 있는 것

- `QCUnit`이 맵 MRGN/UNIT 섹션이나 트리거 유닛 ID 목록에 나타나면 컴파일 실패. theSeed의
  `AssertQCUnitFree()`를 플러그인 안으로 옮기는 것.
- 설정 파싱 시 프레임당 최악 송신 바이트(`15 × (그룹 수 + xy_rets 수) + 26`)를 출력하고 임계
  이상이면 경고. 5.2절 계산을 자동화.
- `xy` 소스가 맵 끝 좌표를 낼 수 있으면(3.2절) 경고. 게임의 클램프 여부는 실측 필요.

### G. 빈 선택일 때 QC 유닛 해제 — 3.7절 구멍

`SelCount == 0`이어도 `QGCActivated`이면 **count 0인 `0x09 Select`(2바이트, `09 00`)**를 큐잉해
선택을 비운다. BWAPI `CommandFilter`는 `ClientSelectionCount`가 0인 상태에서도 같은 패킷을 큐잉하므로
게임이 이를 "선택 해제"로 처리한다는 근거가 된다. 이렇게 하면 `rightClickAction = 6` 방어에 기대지
않아도 되고, `0x14 RightClick`(10바이트)로 바꿔 송신당 1바이트를 줄이는 선택지도 열린다
(`rightClickAction`을 2 = NormalMove_NoAttack로 두면 우클릭이 Move가 된다).

### H. 더 큰 페이로드를 찾는 방향 (연구 과제, 미검증)

- `0x15`의 `order` 바이트는 유닛의 `orderID`(CUnit+0x4D)로 그대로 남는다. 부동 유닛에 무해한
  오더 몇 개를 골라 쓰면 패킷당 1~2비트를 더 얻을 수 있다. Move 외 오더의 부작용을 실측해야 한다.
- `0x58 MinimapPing`(5바이트)은 저장 위치가 로컬 UI이고 동맹 여부로 걸러지므로 채널로 부적합.
- `queued = 1`로 오더 큐에 여러 좌표를 쌓는 방식은 부동 유닛이 오더를 끝내지 못해 큐가 자라고, 큐를
  트리거로 걷는 비용이 커서 권하지 않는다.
- 플레이어별 공유 선택 배열(`0x6284E8`)에 Select 순열로 데이터를 싣는 방식은 이론상 바이트당
  비트가 비슷하고 디코딩이 비싸다.

---

## 8. 참조 위치

| 무엇 | 어디 |
| --- | --- |
| 원본 큐 함수 재구현 | `~/bwapi/bwapi/BWAPI/Source/DLLMain.cpp` 30~68행 |
| 명령 ID 분류, 선택 복원 트릭 | `~/bwapi/bwapi/BWAPI/Source/Detours.cpp` 526~580행 |
| 패킷 구조체 | `~/bwapi/bwapi/BWAPI/Source/BW/OrderTypes.h`, `UnitTarget.cpp` |
| 주소표 | `~/bwapi/bwapi/BWAPI/Source/BW/Offsets.h` |
| CUnit 오프셋 | `~/bwapi/bwapi/BWAPI/Source/BW/CUnit.h` (0x10, 0x34, 0x4C, 0xA5, 0xDC, 0x110) |
| eudplib 큐 구현 | `~/.eudplib-linux/venv/lib/python3.13/site-packages/eudplib/qgc/qgc.py` |
| eudplib memcpy | 같은 경로 `memio/mblockio.py` |
| units.dat 필드 이름 | 같은 경로 `scdata/unit.py` |
| 업스트림 MSQC.py | `https://raw.githubusercontent.com/armoha/euddraft/master/plugins/MSQC.py` |
