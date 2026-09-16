# SNQC - Sana Natori QueueCommand

스타크래프트: 리마스터 EUD 맵에서 **각 PC 의 키보드·마우스 입력을 모든 PC 에 동기화**하는 라이브러리.
MSQC(Murakami Shiina QueueCommand)의 상위호환으로 만들었다. 이름은 제작자 지정.

MSQC 는 숨긴 QC 유닛의 **이동 목표**에 값을 실어 보내는데, 스타가 150프레임마다 그 이동 명령을 다시 시작시켜
그 사이클의 입력이 사라진다. SNQC 는 **가린 커맨드센터의 랠리 좌표**에 실어 보내서 그 소실이 없다.

## 파일

| 파일 | 내용 |
| --- | --- |
| `SNQC.py` | euddraft 플러그인 판. .eds `[SNQC]` 단락 - **MSQC 와 같은 줄 문법** |
| `SNQC.lua` | CtrigAsm(TEP) 판. Lua 함수로 설정 (MSQC 줄 문법도 받음) |
| `DESIGN.md` | 설계, 실측 근거, 설정표, MSQC 에서 옮기는 법, 확인 목록 |
| `HISTORY.md` | 작업 내역 (조사 → 실험 → 구현 → 시험) |
| `tests/test_snqc.py` | 플러그인 오프라인 컴파일 시험 (eudplib 0.76.14) |
| `tests/stub_test.lua` | Lua 판을 가짜 CtrigAsm 환경에서 끝까지 실행하는 시험 |

## 쓰는 법

**euddraft 플러그인 판**
1. `SNQC.py` 를 euddraft 의 `plugins` 폴더에 복사한다 (이 PC: `C:\euddraft0.9.2.0\plugins\` - 이름과 달리 euddraft 0.9.10.11 / eudplib 0.76.14).
2. .eds 의 `[MSQC]` 를 `[SNQC]` 로 바꾼다. 줄은 그대로 둔다. `[MSQC]` 와 같이 두지 않는다.
3. 커맨드센터(106)를 맵에서 쓰지 않아야 한다 (채널 건물 전용 - 다른 종류로 바꾸려면 `SNQCUnit`).

**CtrigAsm 판** (자동으로 읽히지 않는다 - `MapSource/Library` 가 아님)

```lua
dofile(Curdir .. "MapSource/SNQC/SNQC.lua")
SNQC_Config{ MapTiles = {192, 96}, Humans = {0,1,2,3,4,5,6}, WorkAddr = 0x58F7C0 }
SNQC_Key({SNQC_NotTyping(), SNQC_KeyDown("Y")}, 522, 1)
SNQC_Line('Switch("Switch 199", Set); val, 0x58F600 : 510')
SNQC_Install()   -- 받은 데스값을 읽는 트리거보다 앞에서
```

자세한 설정은 `DESIGN.md`.

## 상태 (2026-09-17)

| | 플러그인 판 | CtrigAsm 판 |
| --- | --- | --- |
| 문법·컴파일 | eudplib 0.76.14 오프라인 컴파일 (theSeed·DPS 설정) | luac 검사 + 가짜 환경 실행 |
| 인게임 | **theSeed 싱글·LAN 2인(64비트+32비트) 통과** - 150프레임 소실 없음, 디싱크 없음, 선택 꼬임 없음 | 아직 |
| 남은 확인 | 합치기(턴이 여러 사이클인 방), 버퍼 한계, DPS 적용 | 실제 TEP 컴파일부터 |
