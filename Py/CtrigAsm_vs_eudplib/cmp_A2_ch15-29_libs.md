# A2 — CtrigAsm ↔ eudplib 0.76.14 기능 대조: 가이드북 15~29장·부록 + 추가 라이브러리 파일

## 범위와 약어
- 범위: 가이드북 `Ctrig Assembler v5.4 Guide Book.txt`(GB) D. 함수목록 **15~29장과 `# 부록 설명`**(2538~9085줄), 그리고 가이드북에 없는 추가 파일
  `LibraryFor322.lua`(L322), `Extra.lua`, `DisplayPrint.lua`(DPL), `Print_utf8X.lua`(PU), `ObserverChat.lua`/`ObserverChatAlways.lua`, `TStruct.lua`,
  `isname.lua`, `SCR_DB_Core.lua`, `BeatTimer.lua`, `NoAirCollision2.lua`, `CreateUnitShape.lua`.
- CA = `MapSource\Library\CtrigAsm v5.5.lua`.
- `EP/` = `C:\Users\whatd\.venvs\eud076\Lib\site-packages\eudplib\` (0.76.14 소스를 직접 열어 확인한 이름만 적었다).
- `PL/` = `C:\euddraft0.9.2.0\plugins\` (euddraft 플러그인. 표에서는 "eudplib 생태계(플러그인 이름)"로 적는다).
- 기존 명세 재사용: `DPS_eud\eud\spec\G2`(임시식), `G3`(64비트), `G6`(배열·파일), `G7`(CP·로컬 조건), `G8`(문자열·SCR_DB), `G9`(파일 입출력).
- 판정: **동등** / **대체**(방식 한 줄) / **불필요**(구조 차이) / **없음**(직접 구현, 난이도) / **흉내 어려움**.

## 0. 먼저 확인한 핵심 사실

1. **64비트·128비트 정수: eudplib 0.76.14 에 없다.** `EP/` 전체에서 64비트 변수형·연산 함수를 찾지 못했다(`grep int64|qword|64bit` 결과는 mpqapi 의 OS 64비트 분기뿐).
   `EUDVariable` 은 32비트 전용이다. 지원되는 것은 `f_mul`(하위 32비트), `f_div`(부호 없음, 0 나눗셈이면 몫 0xFFFFFFFF), 부호 있는 나눗셈 `f_div_towards_zero`·`f_div_floor`·`f_div_euclid`(`EP/eudlib/mathf/div.py`),
   `iabs`·`ineg`·`iinvert`(`EP/core/variable/vbase.py`)까지다. 128비트는 DPS 사용자 코드(`math128.lua`)가 W 위에 쌓아 만든 것이다.
   → 22장 W 계열 전부와 64비트 표시·스캔(CA__lItoCustom, CD__ScanW)은 **직접 구현해야 한다**(G3 1.10 에 설계가 있다). 최신 eudplib 판에 들어갔는지는 확인하지 못했다.
2. **문자열 출력 기능은 eudplib 쪽이 대부분 덮는다.** 다만 **숫자 서식 선택지가 좁다.**
   - 있는 것: `StringBuffer`(런타임 버퍼. insert/delete/printf/printAt/tagprint/fadeIn/fadeOut, `EP/eudlib/stringf/strbuffer.py`), `DBString`, `f_sprintf`·`f_eprintf`·`f_printAll`,
     `f_dbstr_print`/`f_dbstr_adddw`/`f_dbstr_addptr`, `DisplayTextAt`·`f_printAt`(줄 지정), `f_eprintln`·`f_eprintAll`·`f_eprintln2`(13번째 줄·오류 줄), `f_raise_CCMU`,
     `f_settbl`/`f_settblf`/`f_settbl2`/`GetTBLAddr`(TBL), `PColor`·`PName`(`{:c}`·`{:n}`), `IsPName`·`SetPName`, `FixedText`·`f_gettextptr`,
     `f_strcpy`/`f_strcmp`/`f_strlen`/`f_strnstr`, `f_parse`(문자열→정수, 진법 지정), `f_cp949_to_utf8_cpy`,
     **`f_cpchar_print`/`TextFX_FadeIn`/`TextFX_FadeOut`**(글자마다 "색 1바이트 + UTF-8 3바이트" 4바이트 칸에 쓴다. CtrigAsm iStr(iutf8)와 같은 배치다. `EP/eudlib/stringf/texteffect.py`).
   - 없는 것: 서식 기호는 `{}`(부호 없는 10진, 가변 길이), `{:x}`(8자리 고정 대문자 16진), `{:s}`,`{:t}`,`{:c}`,`{:n}` 뿐이다(`EP/eudlib/stringf/fmtprint.py` eudformat_field).
     **부호 있는 10진, 0 채우기 방식, 최소·최대 자릿수, 소문자 16진, 전각 숫자(１２３４), 숫자마다 다른 색, 임의 진법 출력은 없다** → ItoDec/ItoHex/ItoDecX/ItoHexX/ItoX/CA__ItoCustom 은 작은 EUDFunc 로 직접 짜야 한다(G8 1.4 에 고정폭 루틴 설계가 있다).
3. **비공유(로컬) 데이터 동기화**: eudplib 본체에는 `QueueGameCommand` 와 그 파생(`_Select`, `_RightClick`, `_TrainUnit`, `_MinimapPing`…, `EP/eudlib/qgcf/qgc.py`)만 있다.
   키·마우스·val·xy 전송 프로토콜은 **플러그인** `PL/MSQC.py` 가 한다. NSQC.py(`PL/NSQC.py`, 1697줄)는 **그 자체가 eudplib 플러그인**(`from eudplib import *`)이며 MSQC 에
   `dword`(4바이트 전체 + 에러코드), `ScreenMoved`, `WideScreen`, 화면 로케이션을 더했다. CtrigAsm 과 이어지는 곳은 `NSQCASM` 주소로 NSQCVArray 칸에 쓰는 부분뿐이다(NSQC.py 1536~1635행).
   → 27장은 **eudplib 생태계(MSQC.py/NSQC.py)로 동등**하다. CtrigAsm 쪽 함수인 NSQCSend/NSQCReceive(VA 를 여러 틱에 나눠 보냄)는 eudplib 쪽에 같은 헬퍼가 없어 짜야 한다(하~중).
   eudplib 0.76.14 에는 **키보드·마우스 입력 API 자체가 없다**(`grep keypress|keydown|0x596A18` 결과 0건). 로컬 키 상태를 직접 읽는 조건은 한 줄짜리 Memory 조건으로 짜면 된다.
4. **파일 I/O·GRP**: eudplib 은 파이썬이라 컴파일할 때 `open()` 으로 아무 파일이나 읽고 쓸 수 있고, 읽은 바이트는 `Db(bytes)`/`EUDArray`/`EUDVArray(n)(초기값)` 으로 맵에 곧바로 싣는다.
   MPQ 에는 `MPQAddFile`/`MPQAddWave`(`EP/maprw/mpqadd.py`)로 넣는다. epScript 에서도 파이썬 내장 함수를 부를 수 있다(`EP/epscript/epscompile.py` 가 `registerPyBuiltins` 로 등록. 호출 이름 규칙 `py_open` 은 추측).
   → 29장 "파일 삽입식 배열"(STRCtrig 필수)은 TEP 가 원시 바이트를 맵에 못 넣는 한계를 우회하려고 생긴 것이라 **불필요/대체**다.
   **CGRP 는 GRP 가 아니다.** CS_Photo.exe 가 만드는 "점 목록" 데이터 형식이고, 총알을 점마다 찍어 그림을 그린다. eudplib 의 `EUDGrp`(`EP/eudlib/eudgrp.py`)는 **진짜 .grp 이미지 파일**을 맵에 넣는 기능이라
   용도가 다르다. **CGRP 를 화면에 그리는 쪽(28장 총알 생성)은 eudplib 에 없다.**
5. **T/TT(변수 삽입형 조건·액션)**: eudplib 의 `Trigger()`(`EP/trigger/triggerdef.py`)와 `DoActions()` 는 조건·액션 필드에 `EUDVariable` 을 그대로 받아 실행 직전에 필드를 채운다(`EP/trigger/tpatcher.py`).
   조건 16개·액션 64개를 넘으면 트리거를 알아서 쪼갠다. → 16·17장 T/TT 와 `CDoActions2X`/`CTrigger2X` 는 **동등**하다. CtrigAsm 은 T 하나마다 사전 트리거 + 패치 액션 3~5개가 붙어 용량 차이가 크다
   (`EPSCRIPT_TRIGGER_BUDGET.md` 3절: 변수 1개 2400B 대 72B).

---

## 1. 가이드북 장별 대조표

### 15장 — 중간 연산자 `_` (GB 2538~2797)

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 0.76.14 대응(파일) | 판정 | 비고 |
|---|---|---|---|---|---|
| 식 안 사칙·비트 연산 | `_Add` `_Sub` `_iSub` `_Neg` `_Mul` `_MulX` `_iMul` `_Div` `_DivX` `_Mod` `_ModX` `_Not` `_Or` `_And` `_Xor` `_lShift` (`_rShift`) | 임시 변수 V 를 할당해 앞 트리거에서 계산하고, 그 V 를 인자로 넘긴다. 무제한 중첩 | `EUDVariable` 연산자 `+ - * // % & \| ^ << >> ~ 단항-` (`EP/core/variable/eudv.py`), `f_mul`/`f_div`(`EP/core/calcf/muldiv.py`), `f_bit*`(`EP/core/calcf/bitwise.py`), epScript 식 | 동등 | eudplib 의 식 트리 자체가 임시식이다. `_Sub`(포화, 결과가 음수면 0)는 대응 연산자가 없다 → `SubtractNumber`(포화 액션) 또는 조건 한 줄로 짠다 |
| 부호 있는 나눗셈·나머지 | `_iDiv` `_iMod` `_iDivX` `_iModX` | 부호 있는 몫·나머지 | `f_div_towards_zero` / `f_div_floor` / `f_div_euclid` (`EP/eudlib/mathf/div.py`) | 동등 | 나머지 규칙(0 쪽/바닥/유클리드)은 CtrigAsm 과 대조해서 골라야 한다 |
| 메모리 읽기 식 | `_Read` `_ReadX` `_ReadF` `_ReadFX` `_EPDRead` `_EPDReadF` `_SHRead` | 마스크를 씌워 읽기, 곱하기, EPD 로 바꾸기 | `f_maskread_epd` `f_dwread_epd` `f_dwepdread_epd` `f_epdread_epd` `f_wread_epd`(`EP/eudlib/memiof/`) | 동등 | `_SHRead`(부호 있는 short, bit31 로 부호 확장)는 `f_wread` 뒤에 한 줄 더 → 대체 |
| 주소·EPD 변환 | `_EPD` `_EPDX` `_TMem` `_MovX` | 값을 EPD 로, 4 로 나눈 나머지, 배열 원소의 주소(EPD/Offset) | `EPD()`(`EP/utils/etc.py`), `(x - 0x58A364) // 4`, `EUDVariable.getValueAddr()`(`EP/core/variable/eudv.py:181`), `EUDArray`·`EUDVArray` 인덱싱 | 동등 | `_MovX`(VA → V 강제 출력)는 CtrigAsm 의 입력/출력 자동 판정을 피하려고 생긴 것 → 불필요 |
| 수학 함수 | `_Abs` `_Sqrt` `_Lengthdir` `_Atan2` `_Log2` `_Rand` | 절댓값, 제곱근, 길이·각→좌표, atan2, log2, 32비트 난수 | `iabs()`(vbase.py), `f_sqrt`, `f_lengthdir`/`f_lengthdir_256`, `f_atan2`/`f_atan2_256`, `f_pow`(`EP/eudlib/mathf/`), `f_rand`/`f_dwrand`(`EP/eudlib/utilf/random.py`) | 동등(`_Log2` 제외) | `_Log2` 는 eudplib 에 없다 → 없음(하: 최상위 비트 찾기 32줄 또는 `EUDBinaryMax`). `_Lengthdir` 는 결과를 W(두 칸)에 담지만 eudplib 은 두 값을 돌려준다 |

### 16장 — 변수 삽입형 조건/액션 `T` (GB 2801~3033)

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 기본 조건·액션 필드에 변수 넣기 | `TDeaths(X)` `TSetDeaths(X)` `TMemory(X)` `TSetMemory(X)` `TCommand` `TBring` `TAccumulate` `TKills` `TScore` `TOpponents` `TCountdownTimer` `TElapsedTime` | 필드(Player EPD, Value, Mask, UnitId, Location…)를 런타임 V 값으로 채운 조건·액션 | `Trigger(conditions, actions)` / `DoActions` 가 필드 속 `EUDVariable` 을 자동으로 채운다 (`EP/trigger/triggerdef.py`, `EP/trigger/tpatcher.py`). `MemoryEPD`/`SetMemoryEPD`/`MemoryXEPD`/`SetMemoryXEPD`, `SetVariables`/`VProc` | 동등 | 용량: CtrigAsm 은 T 마다 사전 트리거 + 패치 액션 3~5개. eudplib 은 `VProc` 로 필드에 바로 쓴다 |
| 액션 필드에 변수 넣기 | `TCreateUnit(WithProperties)` `TKillUnit(At)` `TRemoveUnit(At)` `TGiveUnits` `TOrder` `TMoveLocation` `TMoveUnit` `TModifyUnit*` `TSetResources` `TSetScore` `TWait` `TSetDoodadState` `TSetInvincibility` `TSetAllianceStatus` `TSetCountdownTimer` | 같음. Amount 는 `×16777216` 을 사람이 챙겨야 함 | 같음 (tpatcher 가 바이트 위치를 알아서 맞춘다) | 동등 | "Amount×16777216" 같은 손 보정이 필요 없다 |
| 문자열 필드에 변수 넣기 | `TDisplayText` `TPlayWAV` `TSetMissionObjectives` | 문자열 번호를 V 로 | `DisplayText(EUDVariable)` 등. `EncodeString` 이 변수를 그대로 통과시키고(`EP/core/rawtrigger/strenc.py:282` 오버로드), tpatcher 액션 표(`actpt`)의 dword 필드 6개(locid1·strid·wavid·time·player1·player2)가 모두 패치 대상이다 | 동등 | |
| 변수 트리거 칸 대상 T | `TCDeaths(X)` `TSetCDeaths(X)` `TNDeaths(X)` `TSetNDeaths(X)` `TVariable(X)` `TSetVariable(X)` `TVArrayX` `TCVar` `TNVar` `TCVAar` `TSetCVAar` `TCtrigX` `TSetCtrig1X/2X` | CtrigAsm 변수 트리거 안의 칸을 조건·액션으로 다룸 | `EUDVariable` 비교·대입(`v == x`, `v << x`, `SetNumberX`, `QueueAssignTo`), `EUDVArray` 의 `eqitem` 등 | 동등 / `TCtrigX` 계열은 불필요 | `TSetCtrig*` 는 "트리거 칸 주소"를 직접 다루는 CtrigAsm 내부 장치 → eudplib 은 `Forward` + `SetMemory(trig+off)` 로 한다 |

### 17장 — 특수 조건 `TT` (GB 3037~3143)

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 같지 않다·초과·미만 | `TTMemory(X)` `TTDeaths(X)` `TTCVar` `TTNVar` `TTCVAar` `TTCDeaths` `TTNDeaths` `TTCtrigX` 등 (`"!="` `">"` `"<"`) | 게임에 없는 비교를 CFlag 로 계산해 조건 자리에 넣음 | `EUDVariable.__ne__/__gt__/__lt__`(`EP/core/variable/eudv.py:617~`), `EUDNot`, `EUDSCAnd`/`EUDSCOr` | 동등 | 메모리 값은 `f_dwread_epd` 로 읽은 뒤 비교 |
| 부호 있는 비교 | `"i>="` `"i<="` `"i>"` `"i<"` | 32비트 부호 있는 비교 | 전용 연산자 없음 → 양쪽에 `0x80000000` 을 더해 부호 없는 비교로 바꿈 | 대체 | 한 줄 |
| 기본 조건의 TT판 | `TTCommand` `TTBring` `TTAccumulate` `TTCountdownTimer` `TTElapsedTime` `TTKills` `TTScore` `TTOpponents` | 위와 같음 | `Trigger` + `EUDVariable` 필드 + `EUDNot` 조합 | 대체 | `!=` 는 `EUDNot(Exactly)`, `>` 는 `AtLeast(v+1)` |
| 옛 OR/AND | `TTOR` `TTAND` | 조건 OR/AND | `EUDOr`/`EUDAnd`(`EP/eudlib/utilf/logic.py`), `EUDSCOr`/`EUDSCAnd`(`EP/ctrlstru/shortcircuit.py`) | 동등 | |

### 18장 — 기타 편의기능 (GB 3147~3793)

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| EUD 터보 | `EUDTurbo` | 매 사이클 0x6509A0 ← 0 | eudplib 생태계(`PL/eudTurbo.py`: afterTriggerExec 에서 SetMemory 한 줄) | 동등 | |
| 로케이션 좌표 | `Loc` `LocX` `SetLoc` `SetLocX` (+`TLoc*` `TTLoc*` `_TLoc*`) | 로케이션 한 변 조건·액션, 갱신 액션 | `f_setloc` `f_addloc` `f_dilateloc` `f_getlocTL` `f_setloc_epd`(`EP/eudlib/locf/locf.py`), `Memory(0x58DC60+…)` | 동등 | |
| 바이트·워드 조건/액션 (상수 주소) | `MemoryB` `SetMemoryB` `MemoryW` `SetMemoryW` `TTMemoryB/W` | 4의 배수가 아닌 주소 | `MemoryX`/`SetMemoryX`(마스크·자리 이동), `f_bread`/`f_bwrite`/`f_wread`/`f_wwrite`(`EP/eudlib/memiof/`) | 대체 | 헬퍼 이름은 없고 마스크 식 한 줄 |
| 공중 밀림 방지 | `NoAirCollision` `NoAirCollisionX` | 공중 유닛 밀림 끄기 | eudplib 생태계(`PL/noAirCollision.py`) | 동등 | |
| EPD 정수화·F 메모리 | `EPDX` `EPDF` `FMemory(X)` `FSetMemory(X)` | EPD 를 반올림 없이 정수로. EPD 를 Deaths 로 넣어 Ctrig 수정에 안전하게 | `EPD()`(정수 연산), `MemoryEPD`·`SetMemoryEPD`·`MemoryXEPD`·`SetMemoryXEPD` | 동등 / EPDF 는 불필요 | TEP 가 소수를 반올림하는 문제는 파이썬에 없다 |
| 플레이어 존재 | `PlayerCheck` (`Enable_PlayerCheck`) | 0x51A284 로 존재 확인 | `f_playerexist`, `EUDLoopPlayer`/`EUDPlayerLoop`(`EP/eudlib/utilf/pexist.py`) | 동등 | |
| 공메모리 슬롯 | `_Void` `Void` `SetVoid` `VoidX` `SetVoidX` | 0x58F500+4n 을 저장소로 | `EUDVariable`/`EUDArray`/`Db` 가 자기 메모리를 가진다 | 불필요 | 외부(eps·플러그인)와 고정 주소를 나눌 때만 상수 주소를 직접 쓴다 |
| CP 설정 | `SetCp` | 0x6509B0 ← n | `SetCurrentPlayer`, `f_setcurpl`, `f_addcurpl` | 동등 | eudplib 은 CP 캐시가 있어 원시 SetMemory(0x6509B0) 를 쓰면 캐시가 깨진다(G7 1.2.5) |
| 64비트 상수 문자열 | `I64Zero` | 64비트 상수 자릿수 채우기 | — | 없음(64비트와 함께) | 파이썬 정수는 크기 제한이 없어 상수 자체는 문제없다 |
| 게임 상태 조건·액션 | `PlayerColor` `SetPlayerColor` `MinimapColor` `SetMinimapColor` `Speed` `SetSpeed` `SetMapSize` `TSetMapSize` `PlayerState` `SetPlayerState` `PauseCount` `SetPauseCount` `DropTimer` `SetDropTimer` `DropWindow` `SetDropWindow` `VisionTurbo` | 알려진 주소에 대한 Memory/SetMemory 묶음 | 이름 붙은 API 없음 → `MemoryX`/`SetMemoryX` 한 줄. 유닛 색은 `CUnit.set_color`(`EP/offsetmap/cunit.py:521`) | 대체 | 주소는 CA 에서 가져오면 된다(예: PauseCount 0x58D718, CA:83600 부근) |
| 로컬 플레이어 조건 | `LocalPlayerID` | 0x512684 비교(관전자 128~131 포함) | `IsUserCP()`, `f_getuserplayerid()`(`EP/eudlib/utilf/userpl.py`), `Memory(0x512684, …)` | 동등 | |
| 맵 유통기한 | `UnixTime` | `Memory(0x6D0F38, Type, os.time(Date))` (CA:43409) | 전용 API 없음 → 파이썬 `time`/`calendar` 로 상수를 계산해 `Memory(0x6D0F38, …)` | 대체 | |
| 킬 수 | `SetKills` `TSetKills` `KtoA` | 킬 수 액션, 킬 수 주소 | `SetKills`(`EP/core/rawtrigger/stockact.py`), `Kills` 조건, 필드 변수는 `Trigger` 가 처리 | 동등 | `KtoA` 주소 계산은 파이썬 식 한 줄 |
| 부호 있는 short 읽기 | `f_SHRead` `_SHRead` | 워드를 읽어 부호 확장 | `f_wread_epd` + 조건부 `0xFFFF0000` 더하기 | 대체 | 하 |
| 바이트·워드 읽기/쓰기 (변수 주소) | `TBread` `TBwrite` `TWread` `TWwrite` `TTBread` `TTWread` `TMemoryB/W/Dw` `TSetMemoryB/W/Dw` `TTMemoryBX/WX/Dw` `f_Bread(X)` `f_Wread(X)` `f_Bwrite(X)` `f_Wwrite(X)` `f_Dwwrite(X)` | 변수 주소·DatEdit(Base+Index) 방식 바이트/워드/더블워드 R/W, 곱하기 | `f_bread` `f_bwrite` `f_wread` `f_wwrite` `f_dwread` `f_dwwrite`(+`_epd`/`_cp`), `f_badd_epd` `f_bsubtract_epd` `f_wadd_epd` `f_wsubtract_epd` `f_dwadd_epd` `f_dwsubtract_epd` `f_maskwrite_epd` | 동등 | 비교형(T/TT)은 읽은 뒤 비교 → 대체 |
| 상수 바이트 분해 | `_ParseDw` `_ParseW` | 정수를 바이트로 | `i2b4`/`b2i1`(`EP/utils/binio.py`), 파이썬 `struct` | 동등 | 컴파일 때 계산 |
| 타이머·단계 트리거 생성기 | `Timer` `TimerX` `Stage` | 초기화/리셋/증가 트리거를 자동 생성. TimerX 는 유리수 주기 | 생성기 없음 → `EUDVariable` 카운터 + `EUDIf`/`EUDSwitch`(`EP/ctrlstru/swblock.py`), `f_getgametick` | 대체 | 하. `Stage` 는 `EUDSwitch` 가 거의 그대로다 |
| 문자열을 파일로 저장 | `SaveValueMsg` | 컴파일 때 AbsolutePath 에 파일 쓰기 | 파이썬 `open().write()` | 대체 | |
| 와이드 스크린 판정 | `FindSD` (+Extra `FindSDLocal`) | 센터뷰 + 로케이션으로 화면 폭 추정 | eudplib 생태계(`PL/NSQC.py` `WideScreen`, 동기화까지 함) | 대체 | NSQC 를 안 쓰면 없음(중) |
| 나가면 튕기게 | `ExitDrop` | 대상 로컬에서 STRCtrig 내부 트리거(라벨 0x1FFF2/0xFFFD)의 next 를 자기 자신으로 바꿔 무한 루프 (CA:83529) | 없음 | 없음(중) | eudplib 에서는 "로컬 조건 + 자기 자신으로 점프하는 `RawTrigger`" 로 흉내 낼 수 있을 것 같다(추측). 원리가 STRCtrig 내부 라벨에 걸려 있어 동작은 확인하지 못했다 |
| 등가속도 운동 | `CMotion` | v=v0+aΔt, d=(v+v0)Δt/2 | 변수 산술 몇 줄 | 대체 | |
| 끊김 없는 BGM | `IBGM_EPD` `IBGM_EPDX` | 0x51CE8C 실시간 타이머로 곡 길이만큼 재생, 1곡 대기열 | eudplib 생태계(`PL/bgmplayer.py`: 같은 0x51CE8C 방식, 단일 곡 반복). 여러 곡·대기열은 짜야 함 | 대체 | 하~중 |
| 파일 내용 복사 | `NPA5` | 파일 포인터 내용을 대상 주소로 Size 만큼 복사 | `f_memcpy`, `f_repmovsd_epd`(`EP/eudlib/memiof/mblockio.py`) + `Db` | 동등 | |
| 유닛 소유자 변경 | `f_CGive` | CUnit 으로 Give | `CUnit.cgive(player)`(`EP/offsetmap/cunit.py:497`) | 동등 | |
| 채팅 중 여부 | `IsTyping` `NotTyping` | `Memory(0x68C144, …)` (CA:80326) | `Memory(0x68C144, …)` 한 줄, 동기화하려면 `PL/MSQC.py` `NotTyping` | 대체 | |
| 키·마우스 (로컬) | `KeyPress` `TTKeyPress` `MousePress` `TTMousePress` | 키 상태 배열을 읽음. TT판은 누름·뗌 순간 1회 | 0.76.14 에 키 API 없음 → 로컬 조건은 `MemoryX(키배열 주소)` 로, 동기화는 `PL/MSQC.py`/`PL/NSQC.py` | 대체 | 누름·뗌 순간 판정은 이전 값 변수 1개로 |
| 알파 ID | `f_OffsetToAlphaID` `f_EPDToAlphaID` `f_AlphaIDToCunit` | CUnit ↔ 알파 ID | 공개 함수 없음. `CUnit.uniquenessIdentifier`(`EP/offsetmap/cunit.py:203`), 비공개 `_qgc_alphaids`(`EP/eudlib/qgcf/qgc.py:91`)에 같은 계산이 있다 | 대체 | 하 |
| 부대 지정 | `_HotKeyUnit` `HotkeyUnit` `SetHotkeyUnit` `THotkeyUnit` `TSetHotkeyUnit` `TTHotKeyUnit` | `0x57FE60+0x360p+0x30g+4i` (CA:80827) 조건·액션 | 없음 → 주소 식 + Memory/SetMemory | 없음(하) | |
| 유닛 이름 문자열 교체 | `SetUnitName` | 유닛 이름에 연결된 문자열 번호를 바꾸는 액션 (CA:79989) | 전용 API 없음 → `SetMemory`(주소는 CA 에서) + `GetStringIndex` | 대체 | 하 |

### 19장 — 기타 스트링 (GB 3797~4049)

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 채팅 줄에 상수 문자열 쓰기·검사 | `print_utf8` `check_utf8` (PU) | 0x640B60+218·line+off 에 UTF-8 을 쓰는 SetMemory 액션 / 비교 조건 | `f_dbstr_print(주소, "…")`, `DisplayTextAt`/`f_printAt`, 비교는 `f_memcmp`/`f_strcmp` | 대체 | 컴파일 때 바로 액션 목록을 만드는 헬퍼는 없지만 파이썬 몇 줄 |
| 메모리·변수에 문자열 쓰기 | `Print_String` `Print_StringX` | EPD/VA 위치에 문자열 기록(InitBytes 편차) | `f_dbstr_print`, `f_strcpy`, `f_memcpy`, `EUDByteWriter` | 동등 | |
| 13번째 줄 출력 | `Print_13` | 대상 플레이어의 오류 줄에 출력 | `f_eprintln` / `f_eprintAll` / `f_eprintln2` + `f_raise_CCMU`(`EP/eudlib/stringf/cpprint.py`, `tblprint.py`) | 동등 | |
| 문자열 길이·바이트 배열·번호 | `GetStrSize` `GetStrArr` `GetStrId` `SaveStrArr` | 컴파일 때 UTF-8/CP949 길이, 바이트 배열, 문자열 번호, 메모리에 저장 | `len(u2utf8(s))`/`u2b`(`EP/utils/ubconv.py`), `GetStringIndex`, `Db` | 동등 | |
| 플레이어 이름 | `GetPlayerName` `GetPlayerLength` `ItoName` | 이름 복사, 길이, 색 입힌 이름 | `PName(p)`(= `ptr2s(0x57EEEB+36p)`), `f_strlen`, `f_dbstr_print(dst, PColor(p), PName(p))` | 동등 | 완충(0x0D) 고정폭 배치가 필요하면 G8 1.4 루틴 |
| 숫자 → 문자열 (서식) | `ItoDec` `ItoHex` `ItoDecX` `ItoHexX` `ItoX` | 0 채우기 방식 3가지, 부호 표시 3가지, 최소·최대 자릿수, 대소문자, 전각 숫자, 자릿수마다 색 | `f_dbstr_adddw`(부호 없는 10진, 가변 길이), `hptr`/`{:x}`(8자리 대문자), `f_cpchar_adddw` | 부분만 → **없음(하)** | 부호·0 채우기·자릿수 제한·소문자·전각·자릿수별 색은 직접 짜야 한다(`f_div` 루프 1개) |
| 방장 | `GetHostPlayerID` `GetHostName` `GetHostLength` `ItoHost` `HostName` | 0x6D0F78(방장 이름)과 각 플레이어 이름을 비교해 방장 번호를 찾음 (CA:80111) | 없음 → `f_memcmp(0x6D0F78, 0x57EEEB+36p, 25)` 루프, 이름 출력은 `PName` | 없음(하) | |
| 이름 비교 조건 | `PlayerName` | 대상 플레이어 이름 == 문자열 | `IsPName(player, name)`(`EP/eudlib/stringf/pname.py:100`) | 동등 | |

### 20장 — CreateUnitShape.lua (GB 4053~4169)

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 도형 배치로 유닛 생성 | `CreateUnitPolygon` `CreateUnitLine` `CreateUnitStar` `CreateUnitFlower` (+`WithProperties`, `Safe`) | 컴파일 때 정다각형·직선·별·극좌표 꽃 좌표를 계산해 "로케이션 이동 + CreateUnit" 액션을 펼침 | 도형 라이브러리 없음. `f_setloc` + `CreateUnit(WithProperties)` 와 파이썬 `math` 로 짠다 | 없음(하) | 좌표 계산은 순수 계산이라 Lua 원본을 lupa 로 그대로 돌려도 된다. CtrigAsm 없이도 도는 파일이다 |

### 21장 — 사용자 정의 추가 함수 (GB 4173~4892)

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| CP 바꿔 가며 문자열 액션 | `CopyCpAction(X)` + `DisplayTextX` `PlayWAVX` `SetMissionObjectivesX` `TransmissionX` `LeaderBoard*X` | 한 트리거에서 CP 를 바꿔 가며 문자열 액션 실행(ScmDraft 문자열 깨짐 방지) | `EUDPlayerLoop`, `DisplayTextAll`·`PlayWAVAll`·`MinimapPingAll`·`CenterViewAll`(`EP/eudlib/utilf/userpl.py`), `f_setcurpl` + 액션 | 동등 | 깨짐 방지 목적은 불필요(eudplib 은 ScmDraft 문자열 표를 거치지 않는다) |
| 자동 할당 영역 설정 | `__SetFuncAlloc` `__SetIndexAlloc` `__SetJumpAlloc` `__SetVoidArea` `__SetFlagAlloc` `__SetCAPlot*Alloc` `__SetCreateVarIndex` | 라벨·인덱스 번호 공간 조정 | 필요 없음(객체를 주소로 배치) | 불필요 | TEP 라벨·인덱스 체계 때문에 생긴 것 |
| 변수·배열 자동 생성 | `CreateVar(2/3/s/Arr/2s/Arr2)` `CreateVArr(s/Arr/2…)` `CreateArr(s/Arr)` `CreateDb(s/Arr)` `CreateWar*` `CreateWArr*` `CreateLArr*` `CreateLDb*` `CreateSVar*` `CreateSVArr*` `CreateCcode(s/Arr)` `CreateNcode(s/Arr)` `CreateVoid(s/Arr)` | 변수·배열 선언과 초기값 | `EUDVariable(초기값)`, `EUDCreateVariables(n)`, `EUDArray`, `EUDVArray(n)(초기값)`, `Db`, `EUDStruct`, `PVariable`(플레이어별, `EP/eudlib/playerv.py`) | 동등(W·L 은 없음) | 변수 1개 2400B → 72B. Ccode/Ncode(CDeaths/NDeaths)는 `EUDVariable`/`PVariable` 로 대체. `CreateVoid` 는 불필요(외부 고정 주소 공유 때만) |
| 조건·액션 묶음 풀기 | `CunPack` `CDoActionsX` `CTriggerX` | Lua 전역 배열 꼬임 방지용 `{함수명, 인자…}` 지연 실행 | — | 불필요 | 파이썬 호출은 인자가 바로 평가된다 |
| 조건·액션 개수 제한 없음 | `CDoActions2X` `CTrigger2X` | 16/64 개 초과 자동 분할 | `Trigger()` 가 자동 분할(`EP/trigger/triggerdef.py`) | 동등 | |
| 값 스택 | `CPush` `CPop` | V 스택(크기 = StartCtrig 의 CStack) | `EUDStack`(`EP/eudlib/eudstack.py`), `EUDQueue`/`EUDDeque`(`EP/eudlib/eudqueue.py`) | 동등 | |
| 64비트 스택 | `LPush` `LPop` | W 스택 | `EUDStack` 에 반쪽 두 개를 넣음 | 대체 | 64비트 연산 자체는 없음 |
| 사용자 함수 | `InitCFunc` `CFunc` `CFuncEnd` `CFuncReturn` `CallCFunc(X)` `_Func` `TTFunc` | 인자·반환 여러 개인 함수, 식·조건 안에서 호출 | `EUDFunc`/`EUDTypedFunc`/`EUDReturn`(`EP/core/eudfunc/`), 반환값을 식·조건(`f(x) >= 1`)에 바로 씀 | 동등 | 본문 1회 + 호출 지점 1트리거(EPSCRIPT_TRIGGER_BUDGET 2.5) |
| 함수 포인터 | `InitVFunc` `VFunc` `CallVFunc(X)` `_VFunc` `TTVFunc` | W 에 CFunc 주소를 넣고 간접 호출 | `EUDFuncPtr`/`EUDTypedFuncPtr`(`EP/core/eudfunc/eudfptr.py`) | 동등 | |
| 표 기반 수학 함수 생성 | `CMathFunc` `CMathFunc2` (STRCtrig 필수) | Lua 수식을 정의역 전체에서 미리 계산해 표로 만들고 CFunc 로 조회, 예외·주기·배율 | 파이썬 리스트로 계산해 `EUDArray`/`EUDVArray` + `EUDFunc` 조회 | 대체 | 하. 파이썬이라 표 생성이 더 쉽다 |

### 22장 — 64비트 변수 연산 `W` (GB 4896~5715, 자세한 의미는 G3)

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 64비트 변수·배열 선언과 참조 | `W` `Wi` `CWariable(2)` `CWArray` `LArray` `LDb` `WArr` `LArr` `LArrX` `ConvertWArr` `ConvertLArr` `LMem` `_LMem` `GetWArray` `CallWariable(X)` `LCallLabel*` | lo·hi 두 칸짜리 변수 트리거, 8바이트 원소 배열 | 64비트 형 없음 → `EUDVariable` 두 개 / `EUDArray` 에 2칸씩 / `EUDStruct` 두 필드 | 없음(중) | 저장만 보면 대체가 쉽다. `WArr` 604 간격 산술을 DPS 가 직접 쓴다(G6 1.9) |
| 64비트 칸 조건·액션 | `WariableX` `SetWariableX` `CWar` `SetCWar` `NWar` `SetNWar` `CWAar` `SetCWAar` `LMemX` `SetLMemX` `TSetWArrayX` `TSetCWAar` | lo/hi 칸에 대한 조건·액션 | 반쪽마다 `EUDVariable` 조건·대입 | 대체 | |
| 64비트 비교 | `TTLMemoryX` `TTWArrayX` `TTCWAar` `TTNWar` `_TTNWar` | 사전식(hi 먼저) 비교, 부호 모드 | `EUDSCOr`/`EUDSCAnd` 로 사전식 조건 조립 | 없음(중) | G3 1.10 의 `cmp64` 설계 |
| 64비트 산술·비트 | `f_LAdd` `f_LSub`(포화) `f_LiSub` `f_LNeg` `f_LAbs` `f_LMul` `f_LiMul` `f_LDiv` `f_LiDiv` `f_LMod` `f_LiMod` `f_LlShift` `f_LAnd` `f_LOr` `f_LXor` `f_LNot` + `_L*` 임시식 | mod 2^64 연산, 부호판 | 없음 → EUDFunc 로 올림 처리 덧셈, 16비트 쪼갠 곱셈, 64회 복원 나눗셈 | **없음(중~상)** | 나눗셈·곱셈이 가장 품이 든다. `f_mul` 은 하위 32비트만 준다 |
| 64비트 읽기·쓰기·복사·변환 | `f_LRead(X)` `f_LWrite` `f_LMov(X)` `TLMem` `_TLMem` `f_LDiff` `f_LRand` `f_Cast` `f_iCast` `_Cast` `_CastW` `_iCast` `_iCastW` `Include_64BitLibrary` | 두 칸 읽기·쓰기, 반쪽별 편차, 64비트 난수, W↔V 변환 | `f_dwread_epd` ×2, `f_dwrand` ×2, 반쪽 대입 | 대체(하) | 64비트 난수는 `f_dwrand` 두 번 |

### 23장 — 구조체 변수 `SV` (GB 5717~6122)

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 구조체 선언·배열 | `CSVariable(2)` `SVArray` `GetSVArray` `SV` `SVArr` `SVArrX` `ConvertSVArr` `CallSVariable(X)` `SCallLabel*` | 트리거 하나에 변수 최대 32개(0x40 간격), 0x970 간격 배열 | `EUDStruct`(`EP/core/eudstruct/eudstruct.py`), `EUDStructArray`(`Struct * n`, `EP/core/eudstruct/structarr.py`), `EUDVArray(n)` | 동등 | 필드 이름·형을 선언한다. 인덱스 ×604·×2416 변환(ConvertSVArr)이 필요 없다 |
| 필드 조건·대입·주소 | `SVariableX` `SetSVariableX` `CSVar` `SetCSVar` `NSVar` `SetNSVar` `CSVAar` `SetCSVAar` `TSetSVArrayX` `TSetCSVAar` `TTCSVAar` `_SMem` `TSMem` `_TSMem` | 필드 비교·대입, 필드 주소 | `obj.field` 비교·대입, `EUDVArray` 의 `eqitem`/`ltitem`…, `getValueAddr` | 동등 | |
| 구조체 연산 | `SMov` `MovS` `SCast` `SCopy` `f_SDiff` `_SMov` `_MovS` `_SCast` `_CastS` `_SCopy` | 필드 복사, 필드↔V 변환, 변화량 | `copyto`/`copy`(`structarr.py`), 필드 대입, 변수 뺄셈 | 동등 | |

### 24장 — 논리 조건 `_T` (GB 6126~6151)

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 조건 논리식 | `_TP` `_TC` `_TB` `_TNOT` `_TOR` `_TAND` (+ T/TT 조건 앞에 `_`) | CStruct 조건에서 AND/OR/NOT 을 무제한 중첩 | `EUDSCAnd`/`EUDSCOr`(단락 평가), `EUDNot`, `EUDOr`/`EUDAnd`, epScript `&&` `\|\|` `!` | 동등 | `_TP` 감싸기, `_TB` 묶기(최적화)는 불필요 |

### 25장 — 바이트 단위 R/W (GB 6156~6262)

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 바이트 비교용 데이터 변환 | `CbyteConvert` `f_byteConvert(X)` `_byteConvert(F/FX)` | 바이트 배열을 f_byte 전용 VA 형식으로 변환 | — | 불필요 | CtrigAsm 이 바이트를 직접 못 다뤄서 생긴 단계 |
| 바이트 복사·비교 | `f_bytecpy(X)` `f_bytecmp(X)` `TTbytecmp(X)` | Size 만큼 바이트 복사·비교(채팅 인식, 칭호) | `f_memcpy`, `f_memcmp`(`EP/eudlib/memiof/mblockio.py`), `EUDByteReader`/`EUDByteWriter`/`EUDByteStream`, `f_strcmp` | 동등 | 채팅 인식은 eudplib 생태계(`PL/chatEvent.py`)도 있다 |

### 26장 — 이상 스트링(iStr) 편집·출력 CAPrint/CBPrint/CDPrint/C13Print (GB 6266~7593)

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| iStr 만들기·저장 | `GetiStrArr` `GetiStrSize` `GetiStrId` `SaveiStrArr(X)` `SaveiStrptr(X)` `CreateSVA32(X)` `CreateSVA1` `SVA1` `TSVA1Mem` `MakeiStrVoid` `MakeiStrLetter` `MakeiStrWord` `MakeiStrData(X)` `MakeiStrDiff(X)` `CSVA1` `SetCSVA1` `TSetCSVA1` `TTCSVA1` | 글자마다 4바이트(색 1 + 글자 3) 형식으로 바꿔 "글자 1개 = 트리거 1개"(SVA1) 또는 32글자/트리거(SVA32) 변수에 저장 | 문자열은 `Db`/`DBString`/`StringBuffer` 에 그대로 둔다. 4바이트 글자 형식이 필요하면 `f_cpchar_print`(`texteffect.py`), 상수 변환은 파이썬 | 불필요 / 대체 | **용량 차이 큼**: SVA1 은 글자마다 트리거 1개(0x970). eudplib 은 문자열 바이트만 싣는다 |
| 텍스트 위치 고정 | `FixText` | 0x640B58 저장·복원 | `FixedText`, `f_gettextptr`(`cpprint.py`) | 동등 | |
| 상수 문자열 덮어써서 출력 | `CSPrint` | SVA32 내용을 iStr 자리에 덮어써서 대상에게 출력 | `StringBuffer.print`/`printAt`, `f_sprintf` + `DisplayText` | 대체 | |
| 문자열 주소 | `f_GetiStrptr` `f_GetiStrXepd` | 문자열 번호 → 주소/EPD (STR/STRx 선택) | `GetMapStringAddr`(`EP/eudlib/stringf/cpstr.py:77`), `GetStringIndex` | 동등 | eudplib 은 항상 STRx 라 STR/STRx 분기가 없다 |
| 변수 문자열 출력 틀 | `CAPrint` (+CA[1~8] 대기·루프·출력 딜레이, CB[1~4]) | 사용자 함수(CAfunc)를 끼워 넣을 수 있는 실시간 출력 틀 | `StringBuffer` + `EUDVariable` 타이머, `f_sprintf` | 대체 | 틀 자체는 eudplib 의 일반 제어문으로 충분하다 |
| 글자 단위 실시간 편집 | `CA__InputSVA1(X)` `CA__OverWrite` `CA__SetMask` `CA__SetNext` `CA__Mov` `CA__Movcpy` `CA__Read(X)` `CA__SetMemoryX` `CA__SetColor` `CA__SetLetter` `CA__epdcmp` `TTepdcmp` `CA__GetName` `CA__ItoName` | 버퍼의 n 번째 글자 읽기·쓰기, 색 바꾸기, 복사·비교, 이름 넣기 | `f_bread`/`f_bwrite`/`f_dwwrite`(버퍼 주소 + 4·n), `f_memcpy`, `f_memcmp`, `StringBuffer.insert/delete`, `PName`/`PColor` | 대체 | 하 |
| 글자 효과·변환 | `CA__MoveXY`(글자 복사 위치를 상하좌우로 옮기는 경로 효과) `CA__ConvertColor` `CA__ConvertLetter` `CA__Encode`(cp949↔utf8) | 색·글자 일괄 변환, 이동 효과 | 페이드는 `TextFX_FadeIn`/`TextFX_FadeOut`/`TextFX_Remove`/`TextFX_SetTimer`. 인코딩은 `f_cp949_to_utf8_cpy`. 나머지는 없음 | 부분 → **없음(중)** | `CA__MoveXY` 같은 2차원 이동 효과, 색·글자 표 변환 루프는 직접 짜야 한다 |
| 숫자·64비트 숫자 출력(임의 서식) | `CA__ItoCustom` `CA__lItoCustom` | 진법·길이·부호·자릿수별 색·치환 표를 받는 정수→문자열. l 판은 64비트 | `f_dbstr_adddw`/`hptr` 만 있음 | **없음(하 / 64비트판은 중)** | 64비트판은 64비트 나눗셈이 필요하다 |
| TBL(버튼 설명) 실시간 출력 | `MakeiTblString` `GetiTblId` `MakeButtonTypeValue` `MakeHotkeyValue` `CBPrint` `CB__SetButtonType` `CB__SetHotkey` | stat_txt 문자열 자리를 확보하고(TBLString.txt → EUDEditor 로 붙여 넣기) 실시간으로 고쳐 씀. 버튼 종류·단축키 바이트 교체 | `GetTBLAddr`, `f_settbl`/`f_settblf`/`f_settbl2`/`f_settblf2`(`EP/eudlib/stringf/tblprint.py`), `f_bwrite` 로 앞 바이트(단축키·종류) 교체 | 대체 | 자리 확보는 `[dataDumper]`(`PL/dataDumper.py`)·EUDEditor 로 한다. 단축키 이름 → 값 표는 파이썬 dict 하나 |
| 디스플레이 줄 조건·길이·주소 | `Display` `TTDisplay` `DisplayX` `TTDisplayX` `f_Strlen` `MakeChatOffset` `f_ChatOffset` `_Chat` | 0x640B60+218·line 줄 표시 여부·글자 비교·길이·주소 | `Memory(0x640B60+218*line, …)`, `f_strlen_epd`, `f_getnextchatdst`(`cpprint.py`) | 동등 | |
| 채팅 줄 직접 출력 틀 | `CDPrint` + `CD__GetDisplayLine` `CD__GetLine` `CD__GetIndex(2)` `_GIndex(2)` `CD__GetMask(2)` `_MIndex(2)` `CD__SetMaskX` `CD__InputVAX` `CD__InputMask` `CD__Resize` | 11줄×54글자를 액션 54개짜리 트리거 21개(SVA54)로 채팅 버퍼에 직접 씀. 줄 초기화 문자, 글자 크기 바꾸기(0x0D0D0D0A 삽입) | `DisplayTextAt`, `f_printAt`, `StringBuffer.printAt`/`DisplayAt`, `f_cpchar_print` 로 버퍼에 바로 씀 | 대체 | 용량: SVA54 가 트리거 21개(≈50KB)를 고정으로 쓴다. 글자 크기 코드는 바이트 쓰기 한 줄 |
| 채팅 → 문자열·숫자 | `CD__ScanChat` `CD__ScanV` `CD__ScanW` | 채팅 줄을 버퍼로 복사·인코딩, 문자열을 32/64비트 수로 | `f_memcpy`/`f_strcpy`, `f_parse(dst, radix)`(`EP/eudlib/stringf/parse.py`), 채팅 인식은 `PL/chatEvent.py` | ScanChat·ScanV 동등 / **ScanW 없음(중)** | |
| 오류 줄 실시간 출력 | `CreateSV54` `C13Print` | 13번째 줄에 변수 문자열 출력 | `f_eprintln`, `f_eprintAll`, `f_eprintln2`, `f_raise_CCMU` | 동등 | |
| CA__ 의 바깥판 | `CS__*` 30여 개 | CA__/CB__/CD__ 를 CAPrint 밖에서 부르는 판 | — | 불필요 | 위 대응을 어디서나 그냥 부르면 된다 |

### 27장 — 비공유 데이터 전송 NSQC.py (GB 7597~7864)

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 로컬 조건·값을 동기화 데스값으로 | `[NSQC]` 설정: 일반 조건, 키(Down/Up/Press), 마우스(L/R/M), `NotTyping` `MouseMoved` `ScreenMoved` `WideScreen`, 마우스/화면 로케이션, `xy`, `val`, `dword`, `QCDebug`, `QCUnit`… | QC 유닛 선택·우클릭 패킷(QueueGameCommand)으로 로컬 값을 모든 클라이언트에 전달 | eudplib 생태계: `PL/MSQC.py`(키·마우스·val·xy·NotTyping·MouseMoved·마우스 로케이션), `PL/NSQC.py`(그 위에 dword·ScreenMoved·WideScreen·화면 로케이션; 그 자체가 eudplib 플러그인). 바탕은 `QueueGameCommand*`(`EP/eudlib/qgcf/qgc.py`) | 동등 | NSQC.py 는 eudplib 맵에서도 쓸 수 있다(NSQCASM 연결 부분 제외) |
| CtrigAsm 배열로 받기 | `StartCtrig(NSQC=n)` → `NSQCVArray`, 설정의 `i.0` | 받은 값을 CtrigAsm VA 칸에 씀 | 받는 쪽을 `EUDVariable`/`EUDArray` 주소로 두면 됨 | 불필요 | |
| VA 여러 칸 연속 전송 | `NSQCSend` `NSQCReceive` | `dword` 채널로 4N바이트를 N+1틱에 걸쳐 보내고 받음(에러코드·완료 상태) | 전용 헬퍼 없음 → 틱마다 인덱스를 올리며 dword 채널에 한 칸씩 싣고 받는 루프 | 없음(하~중) | SCR_DB(G8)의 MSQC 채널이 비슷한 일을 이미 한다 |

### 28장 — 순수 총알·스프라이트 생성 (GB 7868~8157)

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 스프라이트·총알 생성 | `ScanInitSetting` `ScanSprite` `UnitSprite` `RecallSprite` `BulletInitSetting` `CreateBullet` `CreateBulletTarget` `CreateStorm` `CreateSprite` | 스캔·리콜·유닛·벌처 자폭 명령(135)을 이용해 원하는 위치·각도·속도·수명의 총알/스프라이트 생성 | 생성 헬퍼 없음. 순회는 `EUDLoopBullet`/`EUDLoopSprite`(`EP/eudlib/utilf/listloop.py`), 유닛 필드는 `CUnit`/`CSprite`(`EP/offsetmap/`) | **없음(중)** | 방식(스캔/벌처 자폭/리콜)을 그대로 옮기면 된다. "0틱 연산 불가" 같은 제약은 게임 쪽이라 똑같다 |
| dat 값 바꾸기 | `SetImageColor` `SetImageScript` `SetImageAllScript` `SetRecallImage` `SetScanImage` `SetSpriteImage` `SetBulletDamage(Up)` `SetBulletNumber` `SetBulletUpgrade` `SetBulletDamageType` `SetBulletDamageSpecial` `SetBulletSpin` `SetBulletSplash100/50/25` `SetDimension` (+T판) | images/sprites/weapons/units.dat 필드 조건·액션 | 이름 붙은 API 없음 → `SetMemoryX`/`f_bwrite`/`f_wwrite` + 주소 상수. 정적 수정은 EUDEditor·`PL/dataDumper.py` | 대체 | 필드에 변수를 넣는 것은 `Trigger` 가 처리 |
| 총알 한도 늘리기 | UnlimiterX 설정 `Count` `SpCount` | 총알·스프라이트·이미지 최대 개수 | eudplib 생태계(`PL/unlimiter.py`, `PL/unlimiterX.py`). eudplib 본체에는 켜짐 여부 표시만 있다(`EP/eudlib/utilf/unlimiterflag.py`) | 동등 | |

### 29장 — 파일 I/O 및 CGRP (GB 8161~8642)

| 기능 묶음 | CtrigAsm 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 파일 삽입식 배열 | `f_GetVArrptr` `f_GetWArrptr` `f_GetSVArrptr` `f_GetFileVArrptrN` `f_GetFileWArrptrN` `f_GetFileSVArrptrN` `f_GetVoidptr` | STRCtrig 가 파일 바이트를 트리거 청크에 그대로 심어 큰 배열·빈 메모리를 만듦 | `EUDArray(n)`/`EUDArray(값목록)`, `EUDVArray(n)(초기값)`, `EUDStruct`, `Db(bytes)` | 불필요 / 대체 | TEP 가 원시 바이트를 못 싣는 한계를 우회한 장치. `f_GetVoidptr` 의 Size 는 바이트 단위(메모) |
| 파일을 맵에 넣기 | `f_GetFileptr` `f_GetFileptrN` `FArr` `f_GetFileSize` | AbsolutePath 의 파일 내용을 그대로(반복 가능) 싣고 원소 주소 계산 | `Db(open(path,'rb').read() * n)`, `EUDArray` 인덱싱, `os.path.getsize`, MPQ 에는 `MPQAddFile` | 동등 | DPS 의 `C:\Temp\expdata_dp` 등(G9 5절)은 그대로 `Db` 로 싣는다 |
| 표로 파일 만들고 넣기 | `SaveFileArr` `f_GetFileArrptr` `f_GetFileArrptrN` | Lua 표 → 임시 파일(원소 1/2/4바이트) → 삽입 | 파이썬 `struct.pack` → `Db` (파일 생략) | 대체 | 임시 파일이 필요 없다 |
| 파일을 트리거로 받기 | `f_GetTRIGptrN` | 파일 내용을 Ctrig 트리거 배열로 보고 실행 때 패치 | `RawTrigger` 객체를 파이썬으로 만들거나 `Db` + 포인터 연결 | 불필요 | |
| 이미지 → 점 데이터(CGRP) | CS_Photo.exe(8비트 BMP → .cgrp, 헤더 16B + 점당 4B: 색 플래그·명암·이미지ID·높이) | 도구로 만든 데이터를 f_GetFileptr 로 싣고 CreateBullet 류로 점마다 그림 | 데이터는 `Db` 로 실을 수 있다(CS_Photo.exe 는 외부 도구라 그대로 사용). **그리는 쪽(28장 총알)은 없음** | 없음(중) | eudplib `EUDGrp` 는 진짜 .grp 이미지를 넣는 다른 기능이다(반대 방향 목록 참고) |

### `# 부록 설명` (GB 8646~9082)

| 기능 묶음 | 내용 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|
| 트리거 구조표 | 조건 20B×16, 액션 32B×64, 체크 플레이어 28B, SCR 추가 8B | `RawTrigger`(`EP/core/rawtrigger/rawtriggerdef.py`), `Condition`/`Action` 필드 | 동등 | 게임 사실이라 공통 지식 |
| 입출력 타입 체계 | `"X"`, `"Cp"`, Mem, V, A, VA, W, LA, WA, S, SV, SA, SVA | 파이썬 형(`EUDVariable`, `EUDArray`, `EUDVArray`, `EUDStruct`, `ConstExpr`) | 불필요 | Lua 표에 형을 문자열로 붙이던 방식 |
| 확장 데스값 | CDeaths(변수 트리거의 빈 액션 60줄×0x20 → 480칸), NDeaths(P1~P8 4바이트) | `EUDVariable`, `PVariable`, `EUDArray` | 불필요 | |
| CunitCtrig 구조 | Header/Selector/NJump/Last/Start/Main(0~1699) | `EUDLoopUnit(2)`/`EUDLoopNewUnit`/`EUDLoopPlayerUnit`/`UnitGroup`(`EP/eudlib/unitgroup.py`) | 대체 | 1700칸을 펼치는 대신 런타임 루프 |
| 중간 연산자·T/TT 생성 원리 | STPushTrigArr/PopTrigArr, TTPushCondArr, CFlag | 식 객체 + tpatcher | 불필요 | |
| 데이터 입출력 변환 규칙 | A/VA 자동 입출력 판정, `_TMem`/`_MovX` 강제 변환 | 형으로 결정 | 불필요 | |
| 드래그 방지 유닛 표 | CUnit+0xDC 0x100/0x200, +0xE4 가시 플래그, 영구 클로킹 조합표 | `CUnit` 멤버(`EP/offsetmap/cunit.py`)로 같은 값 설정 | 동등(지식) | 게임 동작 표라 그대로 유효 |

---

## 2. 추가 라이브러리 파일별 대조표

### LibraryFor322.lua (2040줄)

| 기능 묶음 | 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 산술 메타테이블 변수 | `V`(L322:23) | V 끼리 `+ - * /` 를 임시식으로 | `EUDVariable` 연산자 | 동등 | G1 1.9 |
| 오류·문자열 꾸밈 | `PushErrorMsg` `StrDesign` `StrDesignX` | CP949 오류 메시지, 색 코드 치환 | 파이썬 예외(`ep_assert`, `EPError`), 문자열 치환 | 동등 | |
| CP 순회·로케이션 단순 설정 | `RotatePlayer` `Simple_SetLoc(2)(X)` `Simple_CalcLoc(X)` `ConvertLocation` | 플레이어마다 액션, 로케이션 4변 설정 | `EUDPlayerLoop`, `f_setloc`/`f_setloc_epd`, `GetLocationIndex` | 동등 | |
| 서브루틴 | `SetCall(2)` `SetCallEnd(2)` `SetCallForward` `CallTrigger(A/X)` `TCallTriggerX` `CreateCallIndex` `SetNextTrigger` `SetNextForward` `SetCallErrorCheck` `FindError` | 점프 + 복귀 서브루틴 | `EUDFunc`(인자 없는 함수), `EUDJump`, `Forward`, `SetNextTrigger`, `SetNextPtr` | 동등 | G5 |
| 사람 플레이어 판정 | `Enable_HumanCheck` `HumanCheck` | 0x57EEE8 슬롯 형을 비트로 모아 둠 | `f_playerexist`, `GetPlayerInfo`(컴파일 때), `EUDLoopPlayer` | 동등 | |
| 일괄 할당 | `CreateVArray` `CreateCArray` `CreateCText` `printA` `StrToMem` `CreateCCodeSet` `CreateNCodeSet` `CreateVariableSet` `CreateTableSet` `CreateTables` `CreateVariables` `Create_VTable` `Create_CCTable` `Create_VArrTable` `CreateVar3` | 변수·배열·문자열 배열 묶음 생성 | `EUDCreateVariables`, `EUDArray`, `Db`, 파이썬 리스트 | 동등 | `CreateCText`(문자열 → 배열 초기값)는 `Db(u2utf8(s))` |
| 초과 체력 시스템 | `Overflow_HP_System(X)` `Bit64_HP_SystemX` | 유닛 체력을 800만 근처에 고정하고 남은 체력을 변수(또는 64비트)에 보관 | `f_dwread_epd`/`f_dwwrite_epd` + 변수(64비트판은 64비트 연산 필요) | 대체 / 64비트판은 없음(중) | 32비트판은 하 |
| 변수 약식 조건·액션 | `AddCD` `SubCD` `SetCD(X)` `CD(X)` `AddV(X)` `SubV(X)` `SetV(X)` `CV(X)` `_CV` | Ccode·V 조건·액션 약식 | `v.AddNumber`/`SubtractNumber`/`SetNumber(X)`, `v.AtLeast` 등 | 동등 | G1 |
| BGM 시스템 | `AddBGM` `Install_BGMSystem` `IBGM_EPD` `NormalTurboSet` | 곡 목록·데스값 타이머, 관전자 BGM 켜기/끄기, 실시간 타이머로 재생 시간 계산 | eudplib 생태계 `PL/bgmplayer.py`(단일 곡 반복) + 직접 짠 곡 표 | 대체 | 여러 곡·관전자 토글은 하~중 |
| 오류 메시지 숨기기 | `Enable_HideErrorMessage` | 채팅 줄에서 특정 오류 문구("…:" 형태)를 찾아 지움 | 없음 → 줄마다 `Memory` 비교 + `SetMemory` | 대체(하) | |
| 점프 인덱스 | `def_sIndex` `def_sIndexArr` | NJump 인덱스 할당 | `Forward` | 불필요 | |
| VA 0x0D 패치 | `_0DPatchforVArr` `_0DPatchX` | 문자열로 쓰는 VA 의 0 바이트를 0x0D 로 | `f_bwrite` 루프 | 대체 | G8 |
| 바이트·워드 메모리 호출 | `Install_TMemoryBW` (`Act_TSetMemoryB/W`, `Act_BRead/WRead`) | 변수 주소 바이트·워드 R/W 서브루틴 | `f_bread`/`f_bwrite`/`f_wread`/`f_wwrite` | 동등 | |
| 로케이션 중심 얻기 | `Install_GetCLoc` (`GetLocCenter` `TGetLocCenter` `SetLocCenter(2)`) `f_LengthfdirLoc`(주석) | 임시 로케이션을 옮겨 중심 좌표를 읽음 | `f_getlocTL`, `f_dwread_epd(EPD(0x58DC60+…))` | 동등 | |
| 난수·거듭제곱 | `Include_CRandNum` (`f_CRandNum`) `Install_f_Sqrd` (`f_Sqrd`) | 범위 난수, 정수 거듭제곱 | `f_rand`/`f_dwrand` + `%`, `f_pow`(`EP/eudlib/mathf/pow.py`) | 동등 | |
| 트리거 방출 기본형 | `DoActions` `DoActions2(X)` `DoActionsX(I)` `CDoActions` | 액션 트리거(개수 초과 분할, 보존) | `DoActions`, `Trigger`, `RawTrigger` | 동등 | G5 |
| 좌표 변환 | `Include_Conv_CPosXY` (`Convert_CPosXY`) | 워드 좌표 → X, Y | `f_posread_epd`(`EP/eudlib/memiof/memifgen.py`) | 동등 | |
| 보스 틀 | `CABoss` `CA_SetLHP` | 보스 유닛 체력 고정·패턴 대기·무적·사망 플래그(프리셋 8 + 내부 9 변수) | `CUnit` 멤버 + 변수, `EUDIf` | 대체(중) | 틀 자체는 사용자 코드 |
| 테스트 스위치 | `TestSet` | Limit/TestStart 전역 | 파이썬 설정 | 불필요 | |
| 확장 구조오프셋 | `Install_EXCC` `Set_EXCC(2)(X)` `Cond_EXCC(2)(X)` `TCond_EXCC` `_Cond_EXCC2` `EXCC_Part1~4X` `EXCC_ClearCalc` `EXCC_BreakCalc` `EXCC_End` | 유닛 슬롯(1700)마다 추가 변수 배열을 두고 CunitCtrig 루프 안에서 읽고 씀 | `EUDArray(1700)` 여러 개(또는 `EUDStructArray`) + `(ptr − 0x59CCA8) // 336` 인덱스, `EUDLoopUnit2`/`EUDLoopNewUnit`/`UnitGroup` | 대체 | G9 2.3.1 이 DPS 의 EXCC 사용을 가장 까다로운 곳으로 꼽았다(자기수정 코드) |
| CP 저장·복원 | `Install_BackupCP` (`f_SaveCp` `f_LoadCp`) | CP 를 변수에 보관 | `f_getcurpl`/`f_setcurpl` | 동등 | G7 |

### Extra.lua (481줄)

| 기능 묶음 | 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| NBag 순회 보조 | `NGetThisptr` `NGetThisidx` `NGetLastptr` `NGetLastidx` `_PTR` `NReset` | NBag(가방 자료구조) 순회 중 현재 원소 주소·번호, 스택·덱 초기화 | `EUDQueue`/`EUDDeque`/`EUDStack` 의 반복자, `UnitGroup` 의 `cpl.remove()` | 대체 | NBag 자체는 G4 |
| CP 약식 | `TSetCp` `AddCp` `TAddCp` | CP 설정·더하기(변수판) | `f_setcurpl`, `f_addcurpl`, `AddCurrentPlayer` | 동등 | |
| 로컬 조건(변수판) | `TLocalPlayerID` `isObserverPlayer` `isNotObserverPlayer` | 0x512684 를 변수와 비교, 관전자 여부 | `Memory(0x512684, …)`, `f_getuserplayerid()` 비교 | 동등 | |
| 바이트·워드 마스크 조건 | `MemoryBX` `SetMemoryBX` `MemoryWX` `SetMemoryWX` | 마스크 붙은 바이트·워드 조건·액션 | `MemoryX`/`SetMemoryX` | 동등 | |
| 점프 | `NJumpX` | 조건부 점프 구역 | `EUDJumpIf`, `EUDIf` | 동등 | G4 |
| 와이드 스크린(로컬) | `FindSDLocal` | FindSD 의 로컬판 | 없음 → `PL/NSQC.py` `WideScreen` | 대체 | |
| 문자열 가공 | `iStrColorFillX` `MakeString` `check_utf8X_Add` | 글자마다 색 코드 채우기, 표 합치기, 채팅 줄 비교 액션 누적 | 파이썬 문자열 처리, `f_memcmp` | 동등 | 컴파일 때 계산 |

### DisplayPrint.lua (1423줄) — G8 에 상세 명세

| 기능 묶음 | 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 틀 문자열 + 동적 값 출력 | `DisplayPrint` `DisplaySTRX` `init_StrX` `print_utf8_A` | STRx 틀에 숫자·이름·64비트 값을 고정 폭으로 끼워 대상(숫자·V·Force)에게 출력, 갱신 주기, FixText | `StringBuffer.printf`, `f_sprintf` + `DisplayText`, `GetMapStringAddr` | 대체 | 고정 폭 배치·64비트 숫자·전역 계약(RetV/Dev/BSize)이 걸려 G8 은 **Lua 유지 + 내부 교체**를 권했다 |
| TBL 출력 | `DisplayPrintTbl` | stat_txt 문자열에 같은 방식으로 씀 | `f_settblf`, `GetTBLAddr` + `f_memcpy` | 대체 | `f_settbl*` 은 NUL·가변 길이라 원본과 배치가 다르다(G8 1.8) |
| 오류 줄 출력 | `DisplayPrintEr` `Print_13X` | 13번째 줄 출력 | `f_raise_CCMU` + 0x641598 쓰기, `f_eprintln` | 동등 | |
| 숫자·이름 변환 서브루틴 | `dp.ItoDec` `dp.ItoDecX` `dp.ItoHex` `dp.War_NumSet` `PName` | 고정 폭 10진·16진·전각·64비트 숫자, 이름 복사 | `f_dbstr_adddw`/`hptr`(서식 좁음), `PName` | 64비트판은 **없음(중)**, 나머지 없음(하) | 1장 0절 2번 |
| 초기화 틀 | `init_Setting` `DP_Start_init` | 서브루틴 정의·1회 초기화 | `EUDOnStart`, `EUDExecuteOnce` | 동등 | |

### Print_utf8X.lua (329KB, 대부분 표)

| 기능 묶음 | 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 채팅 줄 상수 출력·검사 | `print_utf8` `check_utf8` `print_utf8X` `check_utf8X` | 상수 UTF-8 을 채팅 줄에 쓰는 액션 / 비교 조건(마스크판 포함) | `f_dbstr_print`, `DisplayTextAt`, `f_memcmp` | 대체 | |
| 인코딩·비트 도우미 | `cp949_to_utf8` `_dw` `bitand` `bitor` `lshift` `log2` | CP949→UTF-8 변환 표, 4바이트 묶기 | `u2utf8`/`u2b`(`EP/utils/ubconv.py`), 파이썬 `str.encode('cp949')`, `b2i4` | 동등 | lupa 로 그대로 돌려도 된다 |

### ObserverChat.lua (1066줄) / ObserverChatAlways.lua (52줄)

| 기능 묶음 | 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 관전자↔플레이어 채팅 | `TogglePlayerModerate` `TogglePlayerChat` `ObserverDrop` `ObserverChatToAll` `ObserverChatToNone` `ObserverChatToPlayer` `ObserverChatToOb` `ObserverChatToAllAlways` | 키로 모드 전환, 채팅 대상(0x68C144)·음소거 비트(0x57F1D8) 강제, 관전자 내보내기 | 전용 API 없음 → 로컬 조건(`Memory(0x512684,…)`) + `SetMemoryX`, 키 조건 | 없음(하) | 원리는 메모리 몇 칸이다. Always 판은 트리거 1개 |

### TStruct.lua (333줄)

| 기능 묶음 | 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 오브젝트 풀(탄막 등) | `TStruct_init` `TS_CreateArr` `TStr_WriteData` `TStr_Func` `TStr_EndFunc` `TS_Suspend` `TSLine` `TTSLine` `SetTSLine` `TSetTSLine` `TS_Send(X)` | 슬롯 N × 필드 L 구조체 배열. 빈 슬롯에 넣고(Next-Fit), 슬롯마다 공통 처리 로직, 종료 시 반납 | `EUDStruct.alloc()/free()`(내부 `ObjPool`, `EP/core/eudstruct/eudstruct.py:33`, `EP/eudlib/objpool.py`), `EUDQueue`/`EUDDeque`, `UnitGroup` 식 순회 | 대체 | 용량·속도: TStruct 는 **슬롯 수만큼 트리거를 매 프레임 검사**(파일 머리 주석). eudplib 은 살아 있는 원소만 도는 루프를 짤 수 있다 |

### isname.lua (213줄)

| 기능 묶음 | 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 이름 비교 | `isname` `s2b` | 0x57EEE8 슬롯의 이름과 상수 비교 조건 | `IsPName`(`EP/eudlib/stringf/pname.py:100`) | 동등 | |
| 슬롯 정보 쓰기 | `setname` (+`EncodeType`/`EncodeRace`) | 슬롯 형·종족·포스·이름을 SetMemory 로 | `SetPName`/`SetPNamef`(이름), 형·종족·포스는 `SetMemory` | 대체 | |

### SCR_DB_Core.lua (394줄) — G8 3절

| 기능 묶음 | 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 외부 런처 세이브·로드 | `SCRDB_Setup` `SCRDB_Anchor` `SCRDB_Receiver` `SCRDB_Notify` `SCRDB_SaveSignal` `SCRDB_CloseLoad` `SCRDB_Slot/Addr/AssignIds/FieldHash/Json/WriteManifest` | 표지 블록·MSQC 채널·매니페스트(JSON)로 런처와 값을 주고받음 | 사용자 고유 시스템. 기본 함수만 쓰므로 Lua 유지 가능, 파이썬 이식도 쉬움. 전송은 원래 eudplib 생태계(`PL/MSQC.py`) | 대체 | 런처 호환 체크리스트(G8 1.11)를 지켜야 한다 |

### BeatTimer.lua (143줄)

| 기능 묶음 | 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| BPM → 시점 계산 | `MakeBeatTimer` (`T.F` `T.Seq` `T.SeqF` `T.List` `T.ListF` `T.Len`) | 마디·박 → ms/프레임, 구간별 템포 | 트리거를 만들지 않는 순수 계산 → 파이썬으로 옮기거나 Lua 그대로 | 불필요(순수 계산) | eudplib 에 해당 기능은 없지만 필요하지도 않다 |

### NoAirCollision2.lua (77줄)

| 기능 묶음 | 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 공중 밀림 방지 | `NoAirCollision(PlayerID)` | Artanis 판 noAirCollision 에 소유자 인자를 더함(0x6D5CD8 반복 뺄셈) | eudplib 생태계 `PL/noAirCollision.py` | 동등 | |

### CreateUnitShape.lua (1698줄)

| 기능 묶음 | 대표 함수 | 하는 일 | eudplib 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 도형 유닛 생성 | 20장과 같음 (16개 함수) | 20장과 같음 | 없음 | 없음(하) | 20장 참고 |

---

## 3. 없음 / 흉내 어려움 목록 (직접 짜야 하는 것)

"흉내 어려움"으로 판정한 항목은 없다. 모두 eudplib 모델로 짤 수 있고, 품이 드는 정도만 다르다.

| 항목 | 출처 | 난이도 | 이유 |
|---|---|---|---|
| 64비트 변수·배열·비교·산술(+/−포화/−순환/×/÷/%/비트/부호판), 64비트 난수·변환 | 22장, L322 `Bit64_HP_SystemX`, DPL 64비트 출력 | **중~상** | eudplib 0.76.14 에 64비트 형이 없다. ×·÷·% 가 가장 무겁다(G3 1.10 설계) |
| 128비트 연산 | DPS `math128.lua`(사용자 코드) | 중 | 64비트 위에 쌓인 것이라 64비트가 먼저 있어야 한다 |
| 64비트 숫자 ↔ 문자열 | `CA__lItoCustom`, `CD__ScanW`, `dp.War_NumSet` | 중 | 64비트 나눗셈·곱셈이 필요하다 |
| 숫자 서식(부호·0 채우기·최소/최대 자릿수·소문자·전각·자릿수별 색·임의 진법) | 19장 `ItoDec/Hex(X)`·`ItoX`, 26장 `CA__ItoCustom` | 하 | `f_dbstr_adddw`/`hptr` 는 부호 없는 가변 10진 / 8자리 대문자 16진만 된다 |
| 글자 효과(2차원 이동, 색·글자 표 변환) | 26장 `CA__MoveXY` `CA__ConvertColor` `CA__ConvertLetter` | 중 | eudplib 은 페이드 인/아웃(TextFX)만 있다 |
| 총알·스프라이트 생성 헬퍼 | 28장 `CreateBullet(Target)` `CreateStorm` `CreateSprite` `ScanSprite` `UnitSprite` `RecallSprite` `BulletInitSetting` | 중 | eudplib 에 없음. 원리(스캔/벌처 자폭/리콜)를 옮기면 된다 |
| CGRP 그림 출력 | 29장 + 28장 | 중 | 데이터는 `Db` 로 실리지만 점마다 총알을 찍는 쪽이 없다 |
| 도형 유닛 생성 | 20장, CreateUnitShape.lua | 하 | 좌표 계산 + `f_setloc` + `CreateUnit` 반복 |
| VA 연속 전송 | 27장 `NSQCSend` `NSQCReceive` | 하~중 | MSQC/NSQC 의 dword 채널 위에 틱 단위 루프를 짜야 한다 |
| 나가면 튕기게 | 18장 `ExitDrop` | 중 | STRCtrig 내부 라벨에 의존. 로컬 조건 + 자기 점프 `RawTrigger` 로 흉내 가능(추측, 확인 안 함) |
| 방장 번호·이름 | 19장 `GetHostPlayerID` 등 | 하 | API 없음. `f_memcmp(0x6D0F78, 이름칸)` 루프 |
| 부대 지정 조건·액션 | 18장 `HotkeyUnit` 계열 | 하 | API 없음. 주소 `0x57FE60+0x360p+0x30g+4i` |
| `_Log2` | 15장 | 하 | eudplib mathf 에 log2 가 없다 |
| 관전자 채팅 제어 | ObserverChat(.Always).lua | 하 | 메모리 몇 칸 + 로컬 조건 |
| 와이드 스크린 판정(NSQC 없이) | 18장 `FindSD`, Extra `FindSDLocal` | 중 | NSQC.py `WideScreen` 을 쓰면 해결 |

## 4. 불필요(구조 차이) 목록

| 항목 | 출처 | 이유 |
|---|---|---|
| T/TT 표식·대기열, `_TP`/`_TB`, `CunPack`/`CDoActionsX`/`CTriggerX`, `CS__*` 바깥판 | 16·17·21·24·26장 | eudplib 은 조건·액션 필드에 변수를 바로 넣고(tpatcher), 파이썬 인자는 바로 평가된다 |
| `__Set*Alloc` 자동 할당 영역, `def_sIndex`, 라벨·인덱스·Ccode·Ncode 체계, 확장 데스값 | 21장, L322, 부록 | eudplib 은 객체를 주소로 배치하고 링크한다 |
| 공메모리 슬롯 `_Void`/`Void`/`CreateVoid*` | 18·21장 | 변수·배열이 자기 메모리를 가진다(외부와 고정 주소를 나눌 때만 상수 주소) |
| `EPDF`(반올림 방지) | 18장 | 파이썬 정수 연산 |
| `CopyCpAction`/`*X` 액션의 문자열 깨짐 방지 목적 | 21장 | ScmDraft 문자열 표를 거치지 않는다(순회 기능 자체는 `EUDPlayerLoop` 으로 동등) |
| iStr 변환·SVA1/SVA32 저장 | 26장 | 글자마다 트리거를 만드는 CtrigAsm 방식 때문에 생긴 형식. eudplib 은 문자열 바이트를 그대로 싣는다 |
| `CbyteConvert` 계열 | 25장 | CtrigAsm 이 바이트를 직접 다루지 못해 생긴 변환 단계 |
| `_MovX`/`_TMem` 강제 입출력 변환, A/VA 타입 판정 | 15장, 부록 | 파이썬 형으로 정해진다 |
| 파일 삽입식 배열(`f_Get*Arrptr*`, `f_GetVoidptr`), 임시 파일(`SaveFileArr`), `f_GetTRIGptrN` | 29장 | TEP 가 원시 바이트를 못 실어 STRCtrig 가 우회한 것. eudplib 은 `Db`/`EUDArray` 로 바로 싣는다 |
| NSQCVArray 연결(`StartCtrig` NSQC 인자, `i.0`) | 27장 | 받는 쪽을 eudplib 변수 주소로 두면 된다 |
| STR/STRx 분기(`f_GetiStrptr` 등) | 26장 | eudplib 출력은 항상 STRx |
| 입출력 타입 문자열(`"V"`,`"VA"`,`"SV"`…) | 부록 | 파이썬 형 |
| `TestSet`, `BeatTimer`(순수 계산) | L322, BeatTimer.lua | 트리거를 만들지 않는다 |

### 참고: 중요한 "대체" 몇 가지
- **CAPrint/CDPrint** → `StringBuffer` + `f_sprintf` + `DisplayTextAt`/`f_printAt` + `f_cpchar_print`/TextFX. CDPrint 는 고정 트리거 21개(≈50KB)를 쓰지만 eudplib 판은 훨씬 작다.
- **TStruct 오브젝트 풀** → `EUDStruct.alloc/free`(ObjPool). 슬롯 수만큼 트리거를 매 프레임 검사하던 비용이 사라진다.
- **EXCC(유닛 슬롯별 추가 변수)** → `EUDArray(1700)` + CUnit 인덱스. DPS 에서 가장 손이 많이 가는 곳(G9 2.3.1).
- **Timer/TimerX/Stage** → 변수 카운터 + `EUDSwitch`.
- **BGM 시스템** → `PL/bgmplayer.py` + 곡 표.
- **dat 수정(28장)** → `SetMemoryX`/`f_bwrite` + 주소 상수, 정적 수정은 EUDEditor/`PL/dataDumper.py`.

## 5. 반대 방향 — 이 범위에서 눈에 띈 "eudplib 에만 있는 것"
(다른 조사자가 전체를 다룰 것이므로 이 범위에서 보인 것만 적는다)
- `EUDGrp`(진짜 .grp 이미지 삽입), `SetWireframes`/`SetTranWire`/`SetGrpWire`(`EP/eudlib/wireframe/`), `TextFX_FadeIn/Out`, `StringBuffer.insert/delete/tagprint`, `LocalLocale`(클라이언트 언어 감지),
  `f_parse`(진법 지정 파싱), `f_strnstr`, `EUDBinaryMax/Min`, `UnitGroup`, `EUDLoopTrigger`, `CUnit`/`CSprite` 멤버 이름 접근과 `cgive`/`set_color`/`check_buildq`/`die`/`set_invincible` 등,
  `QueueGameCommand_*`(선택·우클릭·훈련·치트·일시정지·재시작 패킷), `f_blockpatch_epd`/`f_dwpatch_epd`/`f_unpatchall`(되돌릴 수 있는 메모리 패치), `EUDFuncPtr`, `EUDTracedFunc`(추적 로그), 트리거 겹쳐 쌓기(용량).

## 6. 확인하지 못한 것
- 최신 eudplib(0.77 이후)에 64비트 형, 키 입력 API, 총알 생성 헬퍼가 들어갔는지 — 설치된 0.76.14 만 봤다.
- epScript 에서 파이썬 내장 함수를 부르는 이름 규칙(`py_open` 등). 등록 코드만 확인했다.
- `ExitDrop` 의 실제 동작 원리(STRCtrig 내부 라벨 0x1FFF2/0xFFFD 가 어디서 실행되는지).
- 26장 CA__/CD__ 개별 함수 본문은 가이드북 설명 수준까지만 읽었다(CA 본문 미확인). 22장 의미는 G3 를 그대로 인용했다.
- NSQC.py 의 `dword` 모드가 MSQC 업스트림의 어느 판에 대응하는지(MSQC_INTERNALS.md 5.3 은 로컬 MSQC 가 업스트림보다 오래된 판이라고 적었다).
