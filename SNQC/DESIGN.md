# SNQC - Sana Natori QueueCommand

MSQC(Murakami Shiina QueueCommand)를 대신하는 **로컬 입력 → 모든 PC 동기화** 라이브러리. 이름은 제작자 지정(2026-09-17).
두 판이 있다 - 같은 설계, 같은 결과.

| 판 | 파일 | 설정 | 쓰는 곳 |
| --- | --- | --- | --- |
| euddraft 플러그인 | `MapSource/SNQC/SNQC.py` (설치: `C:\euddraft0.9.2.0\plugins\SNQC.py` 로 복사) | .eds `[SNQC]` 단락 - **MSQC 와 같은 줄 문법** | eudplib 맵 (DPS_eud 등), MSQC 를 쓰던 모든 맵 |
| CtrigAsm 라이브러리 | `MapSource/SNQC/SNQC.lua` (자동으로 안 읽힘 - 맵이 직접 dofile) | Lua 표 / 함수 (`SNQC_Key` 등), MSQC 줄 문법도 받음 (`SNQC_Line`) | TEP/CtrigAsm 맵 (DPS_Enhance, theSeed) |

**확인 상태 (2026-09-17)**: 플러그인 판(1.0)은 theSeed 싱글·LAN 2인 인게임 통과 (아래 7번 1~5, 150프레임 소실 없음, 디싱크 없음). 합치기·버퍼 한계는 아직.
Lua 판(1.2)은 MSF_UE_RE 싱글 인게임 통과 (키, SCR_DB 불러오기 0.4초, 8채널 동시 전송). 멀티(LAN)는 아직. 아래 "7. 확인 목록". 판별 변경은 `CHANGELOG.md`.

---

## 0. 왜 바꾸나 - MSQC 의 한계 (실측)

theSeed `QUEUE_COMMAND_RESEARCH.md` (T1~T3) 요약.

- MSQC 는 숨긴 비행 건물(QC 유닛)에 **Move** 명령을 보내 **이동 목표 좌표**(CUnit+0x10)에 비트를 싣는다.
- **스타가 150프레임마다 그 Move 오더를 다시 시작**시킨다 (프레임 % 150 = 8 에 오더 상태 +0x4E 가 0, 78번 중 77번).
  그 사이클에 받는 쪽 값이 통째로 빈다 → 드래그가 끊기는 등 (theSeed 런타임 리뷰 A1-6).
- 같은 턴의 여러 사이클 값은 마지막 것만 남는다 (칸이 하나).
- 받는 쪽이 매 사이클 값을 0 으로 지우므로 "새 값이 왔는가" 를 따로 알 수 없다.

## 1. 실측으로 확인한 새 채널 (2026-09-17, SC:R 64비트, 싱글/LAN)

| 확인한 것 | 결과 |
| --- | --- |
| 맵 트리거가 턴 버퍼(0x654880)에 직접 쓴 명령 | 그대로 실행된다. 지연 3사이클 (싱글·LAN 매 프레임 턴) |
| 랠리 좌표 (+0xF8, 오더 40 Rally to Ground Tile) | 3사이클 뒤 들어가고 **엔진이 스스로 바꾸지 않는다** (7600사이클 유지) |
| 맵 밖 좌표 | 명령 전체가 무시된다 (잘리지 않음) |
| 랠리를 받는 종류 | **12종**(CC·배럭·팩토리·스타포트·인페스티드CC·해처리·레어·하이브·넥서스·게이트웨이·스타게이트·로보틱스) 중 **땅에 앉은 것**만. 컴샛·띄운 건물 무시 |
| 소유자 | 소유자 바이트(+0x4C)만 본다 - P12 에게 넘긴 뒤 바이트만 사람으로 되돌린 건물도 받는다 |
| 오더 39 (Rally to Visible Unit) | 좌표는 버리고 대상 유닛·그 위치를 적는다. 대상이 없거나 틀리면 자기 자신 |
| **건설크기 (1,0)/(0,1)/(0,0)** | 건물이 **안 보이고 드래그로도 안 골라진다**. 그래도 명령은 받는다 (MSQC QC 유닛과 같은 상태) |
| **받는 쪽이 매 사이클 랠리 칸을 (0,0) 으로 되돌리기** | 같은 값 두 번 → 두 번 받음, 연속 4사이클 → 4번 받음, (0,0)·맵 밖 → 못 받음. 되돌린 값은 유지된다 |
| 한 사이클에 같은 건물로 두 번 | 마지막 값만 |

근거 소스: OpenBW `actions.h`(`action_order`), `bwgame.h`(`unit_is_factory`, `unit_can_receive_order`, `update_thingy_visibility`).
주의: OpenBW 는 (0,0) 을 "보임" 으로 계산하지만 SC:R 에서는 가려졌다.

## 2. 구조

```
            보내는 PC (로컬)                                    모든 PC (공유)
 조건 → 좌표 dword → "09 01 채널 | 15 x x y y 00 00 E4 00 28 00"  →(턴)→  채널 건물 랠리 칸
                    + 선택 되돌리기 "09 n 원래선택..."                     ↓ 매 사이클 읽기
                                                                   0 이 아니면 풀어서 데스값에 쓰고 칸 = 0
```

**채널 건물** - 사람 플레이어 × 채널 수만큼, 게임 시작에 만든다.
1. 사람 소유로 CreateUnit (트리거는 P9 이상 소유로는 못 만든다)
2. GiveUnits → P11(기본) : 사람의 유닛 수(Command 조건 등)에 안 잡히게
3. 소유자 바이트(+0x4C)만 사람으로 되돌림 : 명령을 받게
4. 상태 +0xDC |= 0x04200000 (무적 + 충돌 없음), 랠리 칸 = 0
5. 자리: `XY` 에서 채널마다 x+32, 플레이어마다 y+32 (맵 끝이면 반대로). 넘길 때 옆 건물이 안 걸리게 하려는 것
6. 종류 전체의 units.dat: 건설크기 (1,0), 유닛 크기 1,1,1,1, 시야·탐색 0, 그룹 플래그 0, 서플라이 공급 0, 자원 반환 끔
   → **채널 종류(기본 106 커맨드센터)는 맵의 다른 곳에서 쓰면 안 된다.** theSeed 는 2티어 "커맨드센터" 건작을 사이언스
   퍼실리티(116)로 바꿔 106 을 비웠다 (theSeed PROGRESS §42).
7. 없어졌으면(종류·소유자가 다르면) 다시 만든다 (`Check`/`QCDebug`).

**보내기 (로컬)** - 채널마다
- 키 채널: 줄마다 조건이 참이면 그 줄의 비트를 켠다. 하나라도 켜지면 보낸다.
- 값/좌표/마우스 채널: 조건이 참이면(마우스는 좌표가 바뀌었을 때) 보낸다.
- 붙이기 전에 **합치기(Merge)**: 지난번에 붙인 자기 패킷이 아직 버퍼에 있으면(길이가 그때 이상 + 그 자리에 `09 01 내 채널`)
  새로 붙이지 않고 그 좌표를 고친다 - 키는 비트를 합치고(그 턴에 눌린 키를 모두 남김), 값은 덮어쓴다.
  턴이 여러 사이클에 한 번 나가는 방(배틀넷 등)을 위한 것. **이 방식은 아직 실측 전**이다.
- 새로 붙인 게 있으면 선택 되돌리기: 원래 선택이 있으면 `09 n ...`, 없었으면 `0B 01 채널`(선택에서 빼기).
- 턴 버퍼 길이가 `BufferLimit`(400)보다 크면 붙이지 않는다 (상한 0x57F0D8 = 496, 매 턴 맨 앞 Sync 7바이트).

**받기 (공유)** - 사람 플레이어마다
- 받는 데스값을 먼저 비운다 (MSQC 와 같다: 키 0, 값 0).
- 채널 건물의 랠리 칸이 0 이 아니면 풀고, 칸을 0 으로.

## 3. 비트 배치

맵 폭 W = 가로 타일×32, 높이 H = 세로 타일×32. 좌표는 맵 안이어야 명령이 산다.

| | x | y | 한 채널 |
| --- | --- | --- | --- |
| 키 | 비트 0..KX-1, KX = ⌊log2 W⌋ | 비트 16..16+KY-1, KY = ⌊log2 H⌋ | KX+KY 줄 |
| 값 | (값의 아래 VX 비트) + 1, VX = ⌊log2 (W-1)⌋ | 위 VY 비트, VY = ⌊log2 H⌋ | 0 ~ 2^(VX+VY)-1 |
| 좌표·마우스 | x + 1 (맨 오른쪽 줄은 그대로 → 받으면 W-2) | y | |

| 맵 | 키 줄/채널 (MSQC) | 값 범위 (MSQC) |
| --- | --- | --- |
| 192×96 (theSeed) | 23 (21) | 0 ~ 8,388,607 (같음) |
| 256×256 (DPS) | 26 | 0 ~ 33,554,431 (MSQC 0 ~ 16,777,215) |

키 줄은 비트가 하나 이상 켜지므로 기준값 (0,0) 과 겹치지 않는다. 값·좌표는 x 에 1 을 더해 피한다.

## 4. euddraft 플러그인 판 (SNQC.py)

**설치**: `SNQC.py` 를 `C:\euddraft0.9.2.0\plugins\` 에 둔다 (이 폴더의 euddraft 는 이름과 달리 0.9.10.11 / eudplib 0.76.14).
**옮기기**: .eds 의 `[MSQC]` 를 `[SNQC]` 로 바꾸면 된다. 줄은 그대로.

| 설정 | 기본 | MSQC 이름도 받음 |
| --- | --- | --- |
| `SNQCUnit` | 106 | `QCUnit` - 단, 12종이 아니면 **무시하고 106** (MSQC 의 QC 유닛은 보통 12종이 아니다. 로그에 찍힌다) |
| `SNQCPlayer` | P11 | `QCPlayer` |
| `SNQCLoc` | 0 (0부터, 편집기의 Location 1) | `QCLoc` |
| `SNQC_XY` | 128, 128 | `QC_XY` (DPS 의 `8064, 128` 도 된다 - 맵 끝이면 x 를 반대로 늘어놓는다) |
| `SNQCBuildSize` | 1, 0 | |
| `SNQCMerge` | true | |
| `SNQCBufferLimit` | 400 | |
| `QCDebug` | true (34사이클마다 검사) | `SNQCDebug`, `QCSafety` |

줄 문법·결과는 MSQC 와 같다 (키 = 더하기, `val` = 값, `xy` = 좌표, `mouse` = 로케이션, EUDArray 결과, `0x주소,비교,값`, eudplib 식).
MSQC 와 다른 점
- 값 범위가 맵 크기에 따라 조금 다르다 (위 표, 빌드 로그에 출력).
- `mouse` 줄은 MSQC 처럼 마우스가 움직였을 때만 보낸다 (조건은 따로 안 붙여도 된다).
- 선택 되돌리기를 트리거 앞(`beforeTriggerExec`)에서 바로 한다. 아무것도 안 고른 상태면 채널을 선택에서 뺀다.
- QC 유닛 대신 채널 건물이라 `QCUnit` 의 units.dat 를 건드리지 않는다.
- **[MSQC] 와 [SNQC] 를 같이 두지 말 것** (둘 다 선택을 되돌리고 같은 데스값을 지운다).

오프라인 컴파일 시험: `MapSource/SNQC/tests/test_snqc.py` (theSeed·DPS 설정, 결과 `C:\Temp\snqc\out_*.scx`).

## 5. CtrigAsm 판 (SNQC.lua)

```lua
SNQC_Config{ MapTiles = {192, 96}, Humans = {0,1,2,3,4,5,6}, WorkAddr = 0x58F7C0 }
SNQC_Key({SNQC_NotTyping(), SNQC_KeyDown("Y")}, 522, 1)
SNQC_Value({Switch("Switch 199", Set)}, 0x58F600, 510)
SNQC_Line('Memory(0x68C144,Exactly,0);Switch("Switch 254",Set);KeyPress(LALT);1 = 518,1')
SNQC_Install()   -- 받은 데스값을 읽는 트리거보다 앞에서 한 번
```

| 설정 | 기본 | |
| --- | --- | --- |
| `MapTiles` | (필수) | 맵 크기(타일) |
| `Humans` | (필수) | 채널을 만들 플레이어 번호 (0부터) |
| `WorkAddr` | nil → CreateVoids(13) | 로컬 작업 공간 52바이트. **맵이 0x58F500 부터를 CreateVoid 없이 쓰면 꼭 준다** (DPS 는 0x58F500~0x58F527 을 직접 씀). 1.1 부터 패킷 틀을 매 사이클 다시 써서 맵이 이 자리를 지워도 된다 |
| `Unit` `Player` `Loc` `XY` `Step` `BuildSize` `Order` `Merge` `BufferLimit` `Check` `CheckInterval` | 플러그인과 같음 | |

줄 함수
- `SNQC_Key(Conds, Death, Add)`
- `SNQC_Value(Conds, Src, Death, {Hold, NewDeath, Change})` - Src = 주소 또는 CtrigAsm 변수.
  `Hold` = 안 받은 사이클에 값을 그대로 둔다, `NewDeath` = 받은 사이클에 1 (새 값 표시), `Change` = 바뀐 사이클에만 보낸다 (Lua 판에만 있음)
- `SNQC_Point(Conds, SrcX, SrcY, DeathX, DeathY, {Hold, NewDeath})`
- `SNQC_Mouse(Conds, DeathX, DeathY, {Loc, Hold(기본 true), NewDeath})`
- `SNQC_Line("MSQC 줄")` - `mouse : 로케이션` 은 MSQC 처럼 1부터 센 번호 또는 이름
- 조건: `SNQC_KeyDown/KeyUp/KeyPress(k)`, `SNQC_MouseDown/MouseUp/MousePress(b)`, `SNQC_NotTyping()`,
  `SNQC_MyDeaths(비교, 값, 유닛)` (1.1, 이 PC 플레이어의 데스값), TEP/CtrigAsm 조건 (평평한 목록), 또는 MSQC 문법 문자열.
  **보내는 트리거는 FP 소유라 `Deaths(CurrentPlayer, ...)` 를 표로 넣으면 FP 의 데스를 본다.** 문자열로 주면 `SNQC_MyDeaths` 로 바뀐다.

주의
- `MapSource/Library` 가 아니라서 **자동으로 읽히지 않는다** - 쓰는 맵이 `dofile(Curdir .. "MapSource/SNQC/SNQC.lua")` 로 읽는다.
  읽기만 해서는 아무 트리거도 안 만든다. `SNQC_Install` 을 부른 맵에서만 동작한다.
- 변수는 `SNQC_Install` 안에서 만든다 (FP 가 정해진 뒤). 줄 등록은 그 전 어디서든.
- CtrigAsm 은 "모든 트리거 앞" 시점이 없다 - 메인 흐름에서 받은 데스값을 읽는 곳보다 **앞에** 부를 것.
- `Include_CtrigPlib` 뒤에서 부를 것 (`f_Read` 가 요구한다). `MapSource/Library/LibraryFor322.lua` 의 `SetCall` / `CallTrigger(X)` / `def_sIndex` 를 쓴다.
- **CtrigAsm 인덱스 한도** (0xC000~0xEFFF, `CIf` 하나에 2개): 1.0 은 (플레이어 × 채널 × 비트)마다 `CIf` 를 펼쳐 MSF_UE_RE(16채널 × 7명)에서
  6990개를 써 컴파일이 안 됐다. 1.1 은 본체를 `SetCall` 함수로 두고 `CTrigger` 만 펼쳐 112개 (tepc 실측). 줄을 늘려도 거의 늘지 않는다.

## 6. MSQC 에서 옮기기

| 맵 | 지금 | 옮기는 법 |
| --- | --- | --- |
| theSeed | `MapLogic/EUDEditorEdsGen.lua` 가 `[MSQC]` 줄을 만든다 (euddraft) | 단락 이름을 `[SNQC]` 로 (플러그인 판). 106 은 이미 비웠다. 큐 커맨드 실험기(`QueueCommandLabEnable`)는 106 을 같이 쓰므로 끈다 |
| DPS_eud | **적용함 (2026-09-17, 플러그인 판)**. `eud/build_eud.py` 의 `QC_PLUGIN = "SNQC"` 로 `write_eds` 가 단락 이름을 바꾼다 (SCR_DB 줄 8개는 그대로). euddraft 빌드 통과, 인게임 미확인 | `[MSQC]` → `[SNQC]`. `QCUnit = Zerg Scourge` 는 자동으로 무시된다. 106 은 코드·미리 놓인 유닛에 없다 (2026-09-17 확인. `SCA.FXEPer = 106` 은 아이템 번호). **EUD Editor 3 dat 편집에서 106 을 바꿨는지는 미확인** |
| DPS_Enhance | EUD Editor 3 프로젝트(.e3s) 안의 `[MSQC]` | 플러그인 판이면 위와 같음. Lua 판이면 `Variables.lua` 의 `MSQC_KeySet` 표로 `SNQC_Key` 를 만들고 `WorkAddr` 를 줄 것 |
| MSF_UE_RE | **적용함 (2026-09-17, Lua 판)**. `MSF_UE_RE/QCInput.lua` 가 줄의 정본이고 `QCInput_Plugin` 으로 `SNQC_LUA` / `SNQC_PY` / `MSQC` 를 고른다 (`tools/build_scrdb.py` 가 따라 eds 단락을 만든다) | 106 은 맵에서 안 쓴다(코드·버튼·맵 데이터 확인). 한 일: EUDinit 의 전 유닛 루프 3곳(건설크기 1x1 덮기·미리 놓인 유닛 재배치·RemoveUnit)이 106 을 건너뜀, 보스 클리어의 `KillUnit("Any unit", P11)` 을 P11 에 넘기는 유닛만으로, `@칭호` 결과를 EUDArray 대신 데스 191 로 (Lua 판은 데스만 받는다), 작업 공간 0x593C00, 채널 자리 (2512, 3312) |

SCR_DB(런처 저장) 쪽: MSQC 는 매 프레임 다시 보내서 토글 비트를 쓴다(`docs/SCR_DB_PORTING.md`). SNQC 도 조건이 참인 동안 매 사이클 보내므로
프로토콜은 그대로 쓸 수 있다. 150프레임 소실이 없어지는 만큼 재전송이 줄어드는지 볼 것.

## 7. 확인 목록 (인게임)

1. 채널 건물이 사람마다 만들어지고 안 보이는지, 사람 유닛 수에 안 잡히는지. — **플러그인 판 theSeed 싱글 확인** (P1 0 / P11 9, 안 보임)
2. 키 줄 (KeyDown / KeyPress 조합, Alt+숫자) 이 한 번 누름에 한 번 들어오는지. — **확인** (Alt+1/4, 설정 화면 키)
3. 값 줄 (theSeed 마우스 X/Y, 채팅 시드) 이 매 사이클 들어오고 **150프레임 빈칸이 없는지**. — **확인** (11999사이클 = 150프레임 주기 80번, 빈칸 0)
4. 선택 되돌리기 - 유닛을 고른 채 / 아무것도 안 고른 채 입력했을 때 선택이 그대로인지. — **확인** (아무것도 안 고른 채 부대지정하면 QC 유닛이 잡히던 MSQC 문제도 없음)
5. 멀티(LAN 2인)에서 동기화가 깨지지 않는지. — **확인** (64비트+32비트, 20940사이클 = 150프레임 주기 139번, 디싱크 없음. 한 턴에 두 사이클이 실린 것으로 보이는 1사이클 빈칸이 P2 에 2번, P2 가 나갈 때 P1 에 1번)
6. 합치기(Merge): 턴이 여러 사이클에 한 번 나가는 방에서 키가 사라지지 않는지 (이 방은 아직 못 만들었다).
7. 버퍼 한계 - 줄이 많을 때 `BufferLimit` 에 걸려 빠지는 입력이 없는지.
8. Lua 판: 실제 TEP 컴파일 — **MSF_UE_RE 빌드 통과 (1.1)**. 인게임 1~5 를 MSF_UE_RE 로 (`마린키우기_UnLimit_ExceeD_SCR_DB_out.scx`).
   `WorkAddr` 없이 CreateVoid 로 동작하는지는 아직 (MSF_UE_RE 는 WorkAddr 를 준다).
   MSF_UE_RE 에서 더 볼 것: 채널 건물 자리 (2512, 3312) 에 16×7 개가 다 만들어지는지(지형 자료 없이 고른 자리), 보스 클리어 뒤 입력이 계속 되는지,
   `@칭호 N`·기부 채팅·멀티 커맨드 우클릭·SCR_DB 불러오기/저장.

## 8. 알려진 한계

- 채널 종류(기본 106)는 맵 전체에서 그 용도로만 써야 한다 (units.dat 가 종류 단위).
- 한 턴에 한 채널은 값 하나 - 여러 사이클이 한 턴에 합쳐지면 값 줄은 마지막 값만 남는다 (키는 합치기로 보존).
- 채널 수 × 사람 수만큼 유닛을 쓴다 (theSeed 9×7 = 63, DPS 11×4 = 44).
- 좌표 줄의 맨 오른쪽 한 줄은 x 가 1 작게 온다.
