# CtrigAsm v5.5 — 26장 이상 스트링 편집 및 출력 함수(CAPrint) 상세 설명서 (부분 완성본)

> **상태: 부분 완성 (2026-09-07).** 26장 전체 13개 기능 그룹 중 **2개 그룹(iStr 인코딩·STR 단락 등록, SVA1/SVA32/SV54 변수 타입)** 만 수록되어 있다. 나머지(CAPrint/CBPrint/CDPrint/C13Print 출력 엔진, CA__/CB__/CD__/CS__ 편집 함수, 디스플레이·채팅 줄 함수, TBL/버튼, 예제 26-1~26-41 해설)는 사용량 문제로 작업이 중단되어 **아직 없다.** 수록된 2개 섹션도 조사관이 작성한 뒤 별도 검증관의 소스 재대조 단계는 거치지 않았다. 아래 "근거와 우선순위" 대로 소스가 항상 정답이다.

## 근거 자료와 우선순위
- 가이드북: `Library/Ctrig Assembler v5.4 Guide Book.txt` — 26장 레퍼런스 6266~7596줄, 예제 16145~17694줄.
- 소스(실제 배포본, 가이드와 충돌 시 이쪽이 정답): `Library/CtrigAsm v5.5.lua`. 본문의 `CtrigAsm v5.5.lua:NNNN` 표기는 이 파일의 줄번호다.
- STRCtrig 플러그인: `Py/STRCtrig Assembler v5.5.py` ("＃STRCtrig 필수" 함수가 의존).
- 함정 모음: `Library/CTRIGASM_GOTCHAS.md`.

## 이 문서를 읽는 법
각 함수 항목은 **시그니처 → 한 줄 요약 → 사용 위치(컴파일 타임 Lua / Print 함수 내부 전용 / CJump 사이 전용) → 인자표(타입·nil 기본값·단위) → 리턴값 → 작동 메커니즘(컴파일 타임에 하는 일, 생성되는 트리거, 런타임 데이터 흐름, 건드리는 공용 자원) → 제약·주의사항 → 예제 → 관련 함수** 순서다. AI 가 코드를 쓸 때는 다음을 먼저 확인한다.

1. **단위**: 상수 Index 는 "글자 번호(0-based)", V(변수) Index 는 "글자 번호 × 604" 다. 트리거 1개 = 604 dword = 0x970 바이트이기 때문이다.
2. **선언 위치**: `CreateSVA*`/`SaveiStr*`/`GetiStrId` 는 변수 선언 구간(맵 최상단 `CJump(AllPlayers,0)`~`CJumpEnd` 사이)에서 부른다. 파일 저장판(`SaveiStrptr` 계열)은 `StartCtrig` 의 STRCTRIG 인자가 1 이어야 한다.
3. **인코딩**: TEP 3.0 에서 `SaveiStrArr` 계열의 기본은 iutf8 이다. cp949(icp949)로 저장하려면 4번째 인자 `tblflag=1`. X 계열(`SaveiStrArrX`, `MakeiStrDataX` 등)은 CDPrint/C13Print/CA__OverWrite 용 utf8, 비 X 계열은 CAPrint/CSPrint 용이다. 둘을 섞으면 한글이 깨진다.
4. **문자열 종류**: `MakeiStrVoid/Letter/Word` 의 결과는 flag 없이(Str 타입) `GetiStrId`/`SaveiStrArr` 에 넣는다. flag=1(iStr 타입) 결과를 넣으면 4배로 불어난다.
5. **0x0D**: 스타크래프트에서 `\x0D` 는 줄바꿈이 아니라 "자리는 차지하되 아무것도 안 그리는 공백"이다. iStr 의 빈칸 채움값이며 버그가 아니다.

## 공통 사실 요약 (두 섹션이 공유)
| 항목 | 내용 |
|---|---|
| iStr 한 글자 | dword 1개. byte0 = 컬러 슬롯(직전 컬러코드 또는 0x0D), byte1~3 = 글자(1바이트 `0D 0D X`, cp949/utf8 2바이트 `0D X1 X2`, utf8 3바이트 `X1 X2 X3`) |
| SVA1 | 글자 하나당 트리거 하나. 글자 dword 는 첫 트리거 주소 + n×0x970 + 0x15C. act[0] 은 Disabled(쓰기 게이트), act[1] 은 CP+1, act[2] 는 자기 재비활성화 |
| SVA32 / SVA32X | 트리거 하나에 32글자(SetDeaths + CP+1 또는 CP+8). X 는 CDPrint 계열의 "글자당 8 dword" 간격용. 리턴 타입 문자열은 둘 다 "SVA32" 라 소비자가 구별 못 함 |
| SV54 | C13Print 전용. 54 dword 를 오류줄 버퍼 0x641598 에 통째로 쓰는 트리거 1개 |
| iStrid | `GetiStrId` 리턴 `{V, StringKey, Size, iStr바이트열}`. V 는 게임 시작 시 STR(x) 단락의 iStr EPD 로 채워짐 |
| 트리거 오프셋 | 0x4 next, 0x148 act[0] mask, 0x158 act[0] player(EPD), 0x15C act[0] number(=값), 0x160 unit/type/modifier, 0x164 act[0] flags(0x2=Disabled), 0x178/0x17C/0x184 act[1] |
| 특수 주소 | 0x6509B0 = CurrentPlayer(CP), 0x191943C8 = STR(x) 단락 고정 주소, 0x641598 = 오류줄 버퍼 |

## 수록 범위
- 1장(§1): str_to_istr/iutf8/icp949, GetiStrArr, GetiStrSize, GetiStrId, GetStrId, GetStrSize, f_GetiStrptr, f_GetiStrXepd, f_InitiStrptr, MakeiStrVoid/Letter/Word, MakeiStrData/Diff(X) — 18개
- 2장(§2): CreateSVA32/SVA32X/SVA1, SaveiStrArr/ptr/File(+X, +Dw 계열 12종), SVA1(), TSVA1Mem, CSVA1/SetCSVA1/TCSVA1/TSetCSVA1/TTCSVA1/_TCSVA1/_TTCSVA1, CreateSV54, f_GetFileVArrptrN/SVArrptrN/Arrptr — 28개
- **미수록(작업 중단)**: CAPrint, CSPrint, FixText, CBPrint, CDPrint, C13Print, CA__ 전부, CB__ 전부, CD__ 전부, CS__ 전부, Display/TTDisplay(X), f_Strlen, f_Strcat, MakeChatOffset, f_ChatOffset, _Chat, _GIndex(2), _MIndex(2), MakeiTblString, GetiTblId, MakeHotkeyValue, MakeButtonTypeValue, TTepdcmp, __SetCAPrintVarAlloc, CTrigger2X, 예제 26-1~26-41 해설

---

<!-- functions: str_to_istr, str_to_iutf8, str_to_icp949, GetiStrArr, GetiStrSize, GetiStrId, GetStrId, GetStrSize, MakeiStrVoid, MakeiStrLetter, MakeiStrWord, MakeiStrData, MakeiStrDiff, MakeiStrDataX, MakeiStrDiffX, f_GetiStrptr, f_InitiStrptr, f_GetiStrXepd -->

## 1. iStr 인코딩 · STR 단락 등록 · iStr 생성 유틸

이 그룹은 "사람이 쓴 문자열"을 CAPrint 계열이 다루는 **iStr(이상 스트링, 글자당 4바이트)** 로 바꾸는 순수 Lua 함수들(`str_to_*`, `GetiStr*`, `MakeiStr*`)과, 그렇게 만든 iStr 을 **맵의 STR/STRx 단락에 실제로 집어넣고 게임 시작 시 주소를 변수에 채워 주는 트리거 생성기**(`GetiStrId` → `EndCtrig` 안의 `f_GetiStrptr`+`f_InitiStrptr` 또는 `f_GetiStrXepd`)로 이루어진다.

### 1.0 이 그룹의 공통 메커니즘

#### 1.0.1 iStr 한 글자 = dword 1개의 바이트 배치 (str_to_* 소스에서 확정)

`str_to_istr` / `str_to_iutf8` / `str_to_icp949` 세 함수는 모두 같은 규칙으로 바이트를 밀어 넣는다(`CtrigAsm v5.5.lua:45651~45703`, `45798~45851`, `45885~45927`). 입력 바이트 `v` 를 다음 5종으로 분류한다.

| 분류 | 바이트 값 v | 소스 조건 |
|---|---|---|
| NUL(종료) | 0x00 | `v == 0x0` |
| 1바이트 글자 | 0x20~0x7F, 0x09~0x0D, 0x12, 0x13 | `(v>=0x20 and v<=0x7F) or (v>=0x9 and v<=0xD) or (v>=0x12 and v<=0x13)` |
| 3바이트 글자(utf8 전용) | 0xE0 이상 | `v >= 0xE0` (str_to_istr 의 TEP30Flag==1 분기와 str_to_iutf8 에만 존재) |
| 2바이트 글자 | 0x80 이상(위에 안 걸린 것) | `v >= 0x80` (cp949 는 0x81~0xFE 선행바이트, utf8 은 0xC0~0xDF 선행바이트) |
| 컬러코드 | 그 외 0x01~0x1F (0x01~0x08, 0x0E~0x11, 0x14~0x1F) | else 분기. 단 다음 바이트 w 도 컬러코드이면 v 는 **버려진다**(연속 컬러코드는 마지막 것만 남음) |

주의: **0x0D(\r), 0x0A(\n), 0x09(\t), 0x0B, 0x0C, 0x12, 0x13 은 컬러코드가 아니라 "1바이트 글자"로 취급**된다. 그래서 `"\r\n"` 은 두 글자(dword 2개)가 된다. 0x0D 는 스타크래프트에서 "자리는 차지하되 아무것도 그리지 않는 공백"이므로 iStr 의 빈칸 채움값으로 쓰인다.

한 글자의 dword(메모리 순서, 낮은 주소부터 byte0..byte3):

| 글자 종류 | byte0 (컬러 슬롯) | byte1 | byte2 | byte3 | 소스 |
|---|---|---|---|---|---|
| 1바이트 글자 X | C | 0x0D | 0x0D | X | `insert 0xD; insert 0xD; insert 0xD; insert v` (45662~45670) |
| 2바이트 글자 X1 X2 (cp949 또는 utf8 2바이트) | C | 0x0D | X1 | X2 | `insert 0xD; insert 0xD; insert v; insert w` (45682~45691) |
| 3바이트 글자 X1 X2 X3 (utf8, 한글 등) | C | X1 | X2 | X3 | `insert 0xD; insert v; insert w; insert x` (45671~45681) |
| 종료 dword | 0x00 (또는 직전 컬러코드) | 0x00 | 0x00 | 0x00 | NUL 분기 (45653~45661) |

- C(컬러 슬롯)는 **직전에 컬러코드가 나왔으면 그 컬러코드, 아니면 0x0D** 다. 소스는 `prt` 플래그로 이를 구현한다: 컬러코드를 만나면 `insert v; prt = 1`, 글자를 만나면 `if prt == 0 then insert 0xD end` 후 글자 바이트를 넣고 `prt = 0`.
- 즉 **컬러코드는 절대 독립 dword 를 차지하지 않고, 다음 글자의 byte0 에 흡수**된다. 스타크래프트 텍스트 렌더러가 dword 를 순서대로 바이트 스트림으로 읽기 때문에 `C 0D 0D X` 는 "색 바꾸고, 공백 둘(안 그림), X" 로 보인다. 0x0D 패딩이 "안 그리는 공백"이라는 점이 이 4바이트 고정폭 설계의 핵심이다.
- utf8 3바이트 글자는 패딩 없이 컬러 슬롯 뒤에 꽉 차고, cp949 2바이트 글자는 byte1 에 0x0D 패딩 1개가 들어간다. 이 차이 때문에 cp949 iStr 과 utf8 iStr(X 계열)은 서로 호환되지 않는다(`MakeiStrData` 와 `MakeiStrDataX` 가 따로 있는 이유).
- **4바이트 utf8(이모지 등, 0xF0~)은 지원하지 않는다.** 소스가 `v >= 0xE0` 를 모두 3바이트로 처리하므로 4번째 바이트(0x80~0xBF)가 다음 루프에서 "2바이트 글자 선행바이트"로 오인되어 깨진 dword 가 하나 더 생긴다.
- 컬러코드가 **문자열 맨 끝**에 오면(뒤에 바이트가 없으면) `local w = ret[i+1]` 이 nil 이 되고 `w >= 0x1` 비교에서 **Lua 런타임 에러(compare nil with number)** 가 난다. 문자열은 반드시 글자로 끝내야 한다.

#### 1.0.2 STR 단락용 3바이트 선두 패딩과 종료 처리

`STRXFlag == 0`(STR 단락 모드)일 때만 `iret = {0xD,0xD,0xD}` 로 시작한다(45644~45646, 45790~45791, 45877~45878). 이 3바이트는 글자가 아니라 **런타임 재정렬용 여유분**이다(1.11 `f_InitiStrptr` 참조). `STRXFlag == 1`(STRx 모드, `StartCtrig` 를 부르면 무조건 이 값 — `CtrigAsm v5.5.lua:504`)이면 선두 패딩이 없다. `GetiStrArr`/`GetiStrSize`/`SaveiStrArr` 는 `flag=1` 을 넘겨 어떤 모드에서도 패딩을 넣지 않는다(45787~45788).

종료·길이 규칙(45653~45661, 45704~45709):

```lua
-- CtrigAsm v5.5.lua:45653~45661, 45704~45709  (세 함수 동일)
if v == 0x0 then
    if #iret%4 == 0 then table.insert(iret,0x0) end   -- 컬러 슬롯이 비어 있으면 0 으로 채움
    table.insert(iret,0x0); table.insert(iret,0x0); table.insert(iret,0x0)
    Null = 1
    break
...
if Null == 0 then Size = math.floor(#iret/4) else Size = math.floor((#iret-1)/4) end
```

- Lua 문자열에 `\0` 이 **없으면**(보통의 경우) 종료 dword 를 넣지 않고 `Size = floor(#iret/4)` = 글자 수. STR 단락에 넣을 때의 실제 NUL 종료는 맵 문자열 테이블(`ParseString`)이 붙인다.
- `\0` 을 만나면 그 자리에서 끊고 0x00 을 3~4개 붙인다. STRx 모드에서 n 글자 뒤 `\0` → `#iret = 4n` → `%4==0` → 4바이트 `00 00 00 00` 이 붙고 `Size = floor((4n+3)/4) = n`. STR 모드(선두 3바이트)에서는 `#iret = 4n+3` → `00 00 00` 3바이트만 붙고 `Size = floor((4n+5)/4) = n+1` 이 되어 **종료 dword 가 길이에 포함되는 비대칭**이 있다(소스 그대로의 동작이며 의도인지는 소스에서 확인 불가). 실전 코드는 `\0` 을 넣지 않으므로 보통 문제되지 않는다.

#### 1.0.3 컴파일 모드 전역 4개

| 전역 | 결정 위치 | 의미 |
|---|---|---|
| `TEP30Flag` | `CtrigAsm v5.5.lua:1~6` — `_G` 에 `__mapdirsetting` 키가 있으면 1 | 1 = TrigEditPlus 3.0(소스 파일이 utf8) / 0 = 구 TEP(소스가 cp949). 문자열을 어떤 인코딩으로 볼지 결정 |
| `STRXFlag` | `46` 에서 0, `StartCtrig` 첫 줄(`504`)에서 무조건 1 | 0 = STR 단락(2바이트 오프셋 테이블, 3바이트 선두 패딩, `f_GetiStrptr`+`f_InitiStrptr`) / 1 = STRx 단락(4바이트 오프셋, `f_GetiStrXepd`). `StartCtrig` 를 쓰는 모든 실전 맵은 1 |
| `__STRxSwitch` / `__STRxSwitchX` | TEP 로더스크립트 전역(`loaderscript.lua:1498`, 기본 0, basescript 는 -1) / `GetiStrId` 등이 등록 시점 값을 `__STRxSwitchX` 로 복사(45938~45942) | `STRxStart()`~`STRxEnd()` 사이면 1. 등록 항목의 `["STRx"]` 필드에 저장되어, 그 변수 트리거를 STRx 단락에 놓을지 결정(`1272`) |
| `STRCTRIGASM` | `StartCtrig` 4번째 인자(`529~533`) | 1 이면 STRCtrig 플러그인 필수 함수 사용 가능. 이 그룹의 함수 중 STRCTRIGASM 을 검사하는 것은 없음(`SaveiStrptr` 계열은 다른 그룹) |

호스트(TEP)가 제공하는 내장 함수: `ParseString(문자열)` → 맵 문자열 테이블에 등록하고 StringId 반환(`TEP3.0_Headless_Compiler/TrigEditPlus/Editor/Encoder/LuaParseString.cpp:46~59`, 내부적으로 `StringTable_AddString(..., AlwaysCreate=0)` → **같은 내용의 문자열은 기존 항목을 재활용**, `StringEncoder.cpp:40~43`, `SICStringList.h:27`), `DecodeString(id)` → StringId 의 문자열, `__encode_cp949(utf8문자열)` → cp949 문자열(TEP 3.0 C++ 바인딩; 헤드리스 포팅 소스에는 `__Encode_cp949` 로 등록되어 있어 대소문자가 다름 — 1.19 미확인 항목), `cp949_to_utf8(cp949문자열)` → utf8 바이트 배열(`Library/Print_utf8X.lua:43`, 끝에 0 이 하나 붙어 오므로 호출측이 `table.remove` 로 뗀다).

#### 1.0.4 "Str 타입"과 "iStr 타입" 문자열

`MakeiStrVoid/Letter/Word` 의 `flag` 는 리턴 문자열이 **아직 인코딩 전(Str 타입, 글자당 원래 바이트 수)** 인지 **이미 4바이트 배치가 끝난(iStr 타입)** 인지를 뜻한다. `GetiStrId`, `SaveiStrArr`, `GetiStrArr` 는 모두 내부에서 `str_to_*` 를 다시 돌리므로 **인자로는 Str 타입을 넘겨야 한다.** iStr 타입(flag=1) 문자열을 `GetiStrId` 에 넣으면 0x0D 패딩 하나하나가 다시 글자로 인코딩되어 4배로 불어난다. iStr 타입은 `MakeiTblString`(TBL 문자열, 다른 그룹)처럼 "이미 배치된 바이트를 그대로 쓰는" 곳에만 넣는다(자매 프로젝트 실사용: `theSeed/MapLogic/SelectedUnitInfo.lua:170` 의 `MakeiStrLetter("\x0D", sz+8)` 는 flag 없이 Str 타입).

#### 1.0.5 등록 흐름 개요 (컴파일 타임 → EndCtrig → 런타임)

```
GetiStrId(P, S)                      [컴파일 타임, 아무 곳]
  ├ str_to_istr(S) → 바이트열, Size
  ├ ParseString(바이트열) → StringKey   (맵 STR/STRx 단락에 실제 바이트가 들어감)
  ├ V = CreateVar(P)                   (주소를 담을 일반 변수 트리거 1개 예약)
  └ iStringKeyArr ← {STRx=, StringKey, P, V, Size}

EndCtrig()                            [CtrigAsm v5.5.lua:658]
  ├ 665~671: iStringKeyArr 가 비어있지 않으면 STRXFlag 에 따라
  │          ISTRCheck=1,FPSTRCheck=1 (STR) 또는 FISTRXCheck=1 (STRx) → Include_Last 가 공용 루틴 트리거를 생성
  └ 1036~1043: 항목마다  STR : f_GetiStrptr(P,V,StringKey) ; f_InitiStrptr(P,V,V,Size)
                        STRx: f_GetiStrXepd(P,V,StringKey)
               (InitCtrig() 직후의 초기화 구간, TEP30STRx 모드에서는 793 STRxStart()~1132 STRxEnd() 사이)

런타임(초기화 구간 실행 시)
  STR : V ← 문자열 절대주소(0x191943C8+오프셋) → 문자열을 dword 경계로 제자리 이동 → V ← 정렬된 iStr 의 EPD
  STRx: V ← EPD(0x191943C8) + 오프셋/4   (재정렬 없음, 문자열이 4바이트 정렬돼 있다고 가정)
```

`GetiStrId` 가 돌려주는 `{V, StringKey, Size, String}` 의 `V` 는 이렇게 **게임 시작 후 iStr 첫 dword 의 EPD** 를 갖게 되고, CAPrint/CSPrint 의 `iStrid` 인자가 이를 쓴다.

#### 1.0.6 이 그룹이 쓰는 공용 자원

- `CRet = {0xFFF1..0xFFFA}`(`127`): 산술 함수의 임시 변수 라벨. `f_InitiStrptr` 루틴은 `CMod` 가 남긴 몫 `CRet[1]` 을 읽는다.
- `ISTR[1..5]`, `ISTRCall1/2`(`31472~31477`): STR 재정렬 루틴의 지역변수 5개(Offset, EPD, EPD%4, Size, EPD backup)와 진입/복귀 라벨.
- `FPSTR[1..3]`, `FPSTRCall0/1/2`(`31406~31415`): STR 오프셋 조회 루틴(StringId, 반쪽 선택, 결과 ptr).
- `FISTRX[1..2]`, `FISTRXCall1/2`(`31459~31468`): STRx EPD 조회 루틴(StringId, 결과 EPD).
- CP(0x6509B0): 세 루틴 모두 CP 를 STR(x) 단락 EPD 로 옮겨 오프셋 테이블을 읽고, 끝에 `RecoverCp(PlayerID)` 로 되돌린다(`34171`, `34450`). `f_InitiStrptr` 는 CP 를 만지지 않는다.
- `SetCtrigX(Player1,Index1,Address1,Next1,Type,Player2,Index2,Address2,EPD2,Next2,Mask)`(`1827`)와 `SetCtrig1X(Player1,Index1,Address1,Next1,Type,Value,Mask)`(`1957`)는 "라벨 Index 트리거의 오프셋 Address 를 (다른 트리거의 오프셋 값 또는 상수로) 쓰는" 의사 액션이다(`Action(...,0x5,Type,0x14+Mflag2)`, `1955`). `EPD2=1` 이면 소스 오프셋을 /4 해서 EPD 로 쓴다(`1925~1931`). 이 그룹에서 반복되는 관용구 "V → 다른 변수로 복사"는 항상 다음 4줄이다: 소스 트리거의 `0x158`(첫 액션 player) ← 목적 트리거 `0x15C` 의 EPD, `0x148`(마스크) ← 0xFFFFFFFF, `0x160`(modifier 바이트) ← SetTo<<24, `CallLabelAlways(소스)` 로 소스 트리거를 한 번 실행.

---

### 1.1 str_to_istr
**시그니처**: `str_to_istr(String)`  (소스: `CtrigAsm v5.5.lua:45633~45773`, 가이드: 미수록 — 내부 함수)
**한 줄 요약**: `GetiStrId` 전용 인코더. 현재 컴파일 모드(`TEP30Flag`, `STRXFlag`)에 맞춰 문자열을 iStr 바이트열로 바꾸고 **Lua 문자열**과 글자 수를 돌려준다.
**사용 위치**: 컴파일 타임 Lua 함수. `GetiStrId` 가 호출(45944). 직접 호출할 일은 거의 없다.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| String | Lua 문자열(상수만) | 없음(nil 이면 `#String` 에서 에러) | TEP30Flag==1 이면 utf8, 0 이면 cp949 바이트열로 해석 |

**리턴값**: `iret, Size` — `iret` 은 `utf8_from(iret)`(`45355~45362`, 바이트 배열을 `string.char` 로 이어붙임)을 거친 **Lua 문자열**(`ParseString` 에 바로 넣을 수 있음), `Size` 는 글자 수(dword 개수).

**작동 메커니즘**
1. 문자열을 바이트 배열 `ret` 로 푼다(45634~45637).
2. `TEP30Flag == 1` 분기(45642~45711)와 `== 0` 분기(45712~45772)는 3바이트(`v >= 0xE0`) 케이스 유무만 다르고 나머지는 동일하다. 즉 TEP 3.0 에서는 utf8(한글 3바이트), 구 TEP 에서는 cp949(한글 2바이트)로 본다.
3. `STRXFlag == 0` 이면 `iret = {0xD,0xD,0xD}` 로 시작(45644~45646), 아니면 빈 배열.
4. 1.0.1 표의 규칙으로 dword 를 쌓는다. 핵심 줄:
```lua
-- CtrigAsm v5.5.lua:45662~45670 (1바이트 글자)
elseif (v>=0x20 and v<=0x7F) or (v>=0x9 and v<=0xD) or (v>=0x12 and v<=0x13) then
    if prt == 0 then table.insert(iret,0xD) end   -- 컬러 슬롯 비어 있으면 0x0D
    table.insert(iret,0xD); table.insert(iret,0xD); table.insert(iret,v)
    prt = 0; i = i+1
-- 45692~45703 (컬러코드)
else
    local w = ret[i+1]
    if (w >= 0x1 and w <= 0x8) or (w >= 0xE and w <= 0x11) or (w >= 0x14 and w <= 0x1F) then
        i = i+1        -- 연속 컬러코드: 앞의 것은 버림
    else
        table.insert(iret,v); prt = 1; i = i+1   -- 다음 글자의 byte0 이 됨
    end
end
```
5. 종료/길이는 1.0.2 참조. `utf8_from` 으로 문자열화해 리턴(45710).
6. 트리거 생성 없음, 전역 변경 없음.

**제약·주의사항**
- 문자열 끝이 컬러코드면 Lua 에러(1.0.1). 4바이트 utf8 미지원.
- `STRXFlag` 가 0 이면 선두 3바이트 0x0D 가 붙으므로 `#iret` 이 4 의 배수가 아니다. 이는 STR 단락 재정렬(1.11)을 위한 것이며 버그가 아니다.
- 리턴 문자열은 이미 iStr 이므로 `GetiStrArr` 등에 다시 넣으면 안 된다.

**예제**
```lua
-- 내부 동작 확인용 (TEP 3.0, StartCtrig 이후 STRXFlag=1)
local s, n = str_to_istr("\x04A가")
-- s 의 바이트: 04 0D 0D 41 | 0D EA B0 80    n = 2
```

**관련 함수**: `str_to_iutf8`(GetiStrArr 용, flag 인자 있음), `str_to_icp949`, `GetiStrId`.

---

### 1.2 str_to_iutf8
**시그니처**: `str_to_iutf8(String, flag)`  (소스: `CtrigAsm v5.5.lua:45774~45860`, 가이드: 미수록 — 내부 함수)
**한 줄 요약**: 입력을 **항상 utf8 iStr**(한글 3바이트, `C X1 X2 X3`)로 인코딩해 **바이트 배열**과 글자 수를 돌려준다.
**사용 위치**: 컴파일 타임. `GetiStrArr`/`GetiStrSize`(cp949flag 0), `SaveiStrArr(TEP30, tblflag~=1)`, `SaveiStrArrX` 계열이 호출.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| String | Lua 문자열 | 없음 | TEP30Flag==1 이면 이미 utf8 이라 보고 `gsub(".")` 로 바이트 분해(45777~45778); 0 이면 `cp949_to_utf8` 로 변환 후 끝의 0 을 제거(45780~45781) |
| flag | 1 또는 그 외 | nil | 1 이면 선두 3바이트 패딩을 **절대 넣지 않음**(45787~45788). nil/0 이면 `STRXFlag==0` 일 때만 패딩(45790~45794) |

**리턴값**: `iret, Size` — `iret` 은 **숫자 바이트 배열**(문자열이 아님, `CreateSVA1/SVA32` 가 이 배열을 그대로 소비), `Size` 는 글자 수.

**작동 메커니즘**
- 분류/배치 규칙은 1.0.1 과 동일하며 3바이트 분기(`v >= 0xE0`, 45819~45829)가 항상 존재한다. 2바이트 utf8(0xC0~0xDF 선행, 라틴 확장 등)은 `C 0D X1 X2`, 3바이트(한글·특수문자)는 `C X1 X2 X3`.
- 구 TEP(cp949 소스)에서는 `cp949_to_utf8`(`Print_utf8X.lua:43`)이 cp949 → 유니코드 → utf8 로 바꿔 준 뒤 같은 로직을 탄다.
- 트리거 생성 없음.

**제약·주의사항**
- `GetiStrArr` 의 주석 "iutf8 Size" 대로 **X 계열(CDPrint/C13Print/CA__OverWrite, DisplayX)** 과 짝이다. 일반 `CAPrint`/`CSPrint`(cp949 iStr) 에 이 배열을 넣으면 한글이 깨진다.
- 문자열 끝 컬러코드 → Lua 에러(1.0.1).

**예제**
```lua
local arr, n = str_to_iutf8("\x13가",1)   -- arr = {0x13,0xEA,0xB0,0x80}, n = 1
```

**관련 함수**: `str_to_icp949`, `GetiStrArr`, `SaveiStrArrX`, `MakeiStrDataX`.

---

### 1.3 str_to_icp949
**시그니처**: `str_to_icp949(String, flag)`  (소스: `CtrigAsm v5.5.lua:45861~45936`, 가이드: 미수록 — 내부 함수)
**한 줄 요약**: 입력을 **항상 cp949 iStr**(한글 2바이트, `C 0D X1 X2`)로 인코딩해 바이트 배열과 글자 수를 돌려준다.
**사용 위치**: 컴파일 타임. `GetiStrArr`/`GetiStrSize`(cp949flag 1), `SaveiStrArr`(구 TEP 항상 / TEP30 은 tblflag==1 일 때) 가 호출.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| String | Lua 문자열 | 없음 | TEP30Flag==1 이면 `__encode_cp949(String)` 으로 utf8→cp949 변환(45862~45864); 0 이면 그대로 cp949 로 봄 |
| flag | 1 또는 그 외 | nil | 1.2 와 동일(1 이면 선두 패딩 없음) |

**리턴값**: `iret, Size` — 숫자 바이트 배열, 글자 수.

**작동 메커니즘**
- 3바이트 분기가 없다(45886~45927). `v >= 0x80` 이면 무조건 2바이트로 소비(`C 0D X1 X2`).
- TEP 3.0 의 `__encode_cp949` 는 C++ 바인딩으로 3바이트 utf8 → 2바이트 cp949 테이블 조회(`TriggerEncode.cpp:770~826`). cp949 에 없는 글자는 테이블 0 번째 항목으로 대체된다(`loc = 0x0`).
- 트리거 생성 없음.

**제약·주의사항**
- cp949 iStr 은 `CAPrint`/`CSPrint`/`CA__*`(비 X 계열) 용이다. `Display`(비 X) 로 화면에 뿌릴 때 스타크래프트가 cp949 로 읽는다.
- 가이드(6266~6272)의 "cp949flag 1 입력시 cp949 형식" 이 이 함수다.

**예제**
```lua
local arr, n = str_to_icp949("\x04가",1)   -- arr = {0x04,0x0D,0xB0,0xA1}, n = 1  (TEP 3.0)
```

**관련 함수**: `str_to_iutf8`, `GetiStrArr`, `SaveiStrArr`, `MakeiStrData`.

---

### 1.4 GetiStrArr
**시그니처**: `GetiStrArr(cp949flag, String)`  (소스: `CtrigAsm v5.5.lua:45986~45999`, 가이드: `Guide Book.txt:6270`)
**한 줄 요약**: 문자열(또는 StringId)을 iStr **바이트 배열**로 바꿔 배열과 길이를 돌려준다. `CreateSVA32`/`CreateSVA1` 의 입력을 만들 때 쓴다.
**사용 위치**: 컴파일 타임, 아무 곳.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| cp949flag | 0, nil, "X" → utf8 / 그 외(1) → cp949 | nil → utf8 | `str_to_iutf8` 과 `str_to_icp949` 선택(45993~45997). **가이드는 "0=utf8, 1=cp949" 로만 적었지만 소스는 nil/"X" 도 utf8** |
| String | Lua 문자열 또는 숫자(StringId) | 없음 | 숫자면 `DecodeString` 으로 맵 문자열을 꺼내 사용(45987~45989) |

**리턴값**: `Arr, Size` — 바이트 배열(패딩 없음, `flag=1` 로 호출), 글자 수.

**작동 메커니즘**
```lua
-- CtrigAsm v5.5.lua:45993~45998
if cp949flag == "X" or cp949flag == nil or cp949flag == 0 then -- iutf8 Size
    Arr, Size = str_to_iutf8(String,1)
else -- icp949 Size
    Arr, Size = str_to_icp949(String,1)
end
```
항상 `flag=1` 이므로 `STRXFlag` 와 무관하게 선두 3바이트 패딩이 없다(변수에 저장할 iStr 은 재정렬이 필요 없기 때문). 트리거 생성 없음.

**제약·주의사항**
- 예제 26-2(`Guide Book.txt:16173`)처럼 `GetiStrArr(1, ...)` → `CreateSVA32(StrA1,StrS1,P1)` → `CSPrint` 로 이어지는 경우 cp949flag=1 이어야 한다(CSPrint 는 cp949 iStr).
- X 계열(CDPrint/C13Print/DisplayX)에는 cp949flag 0(utf8).

**예제**
```lua
-- [예제 26-2] Guide Book.txt:16173~16174
StrA1, StrS1 = GetiStrArr(1,"\x13\x1B테\x19스\x1D트\x02☆")   -- cp949 iStr 배열과 길이(=5)
Str1 = CreateSVA32(StrA1,StrS1,P1)                               -- SVA32 변수(CSPrint 용)
```

**관련 함수**: `GetiStrSize`, `SaveiStrArr`(변환+변수 생성 한 번에), `GetStrArr`(25장, 일반 문자열 배열).

---

### 1.5 GetiStrSize
**시그니처**: `GetiStrSize(cp949flag, String)`  (소스: `CtrigAsm v5.5.lua:46000~46013`, 가이드: `Guide Book.txt:6276`)
**한 줄 요약**: `GetiStrArr` 와 완전히 같은 변환을 하고 **길이만** 돌려준다.
**사용 위치**: 컴파일 타임, 아무 곳. 주로 `MakeiStrVoid(GetiStrSize(0,s)+10)` 처럼 버퍼 크기 계산에 쓴다(`MapSource/MSF_Memory_2/LeaderBoardFunc.lua:7`).

**인자**: 1.4 와 동일.
**리턴값**: `Size`(글자 수, 숫자).

**작동 메커니즘**: 본문이 1.4 와 동일하며 마지막에 `return Size` 만 한다(46007~46012). 트리거 생성 없음.

**제약·주의사항**: cp949/utf8 에 따라 글자 수는 같지만(글자당 dword 1개) 컬러코드 처리·2바이트/3바이트 분기가 달라 **깨진 입력에서는 값이 달라질 수 있다.** 실제로 출력에 쓸 인코딩과 같은 cp949flag 로 재라.

**예제**
```lua
local n = GetiStrSize(0,"\x04CAPrint 예제")   -- 컬러코드는 글자 수에 안 들어감 → 11
iStr1 = GetiStrId(P1, MakeiStrVoid(n+10))
```

**관련 함수**: `GetiStrArr`, `GetStrSize`(1.8).

---

### 1.6 GetiStrId
**시그니처**: `GetiStrId(PlayerId, String)`  (소스: `CtrigAsm v5.5.lua:45937~45952`, 가이드: `Guide Book.txt:6281`)
**한 줄 요약**: 문자열을 iStr 로 바꿔 **맵 STR/STRx 단락에 등록**하고, 게임 시작 시 그 iStr 의 EPD 가 채워질 변수 `V` 를 예약해 `{V, StringKey, Size, String}` 을 돌려준다. CAPrint/CSPrint/CBPrint 의 `iStrid` 인자.
**사용 위치**: 컴파일 타임. 가이드 예제는 모두 `CJump(AllPlayers,0)`~`CJumpEnd` 사이(변수 선언 구간)에 둔다(`Guide Book.txt:16152~16156`). `CreateVar` 를 부르므로 변수 선언이 허용되는 곳이어야 한다.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| PlayerId | P1~P8 숫자, AllPlayers 등 | `CreateVar` 가 nil → AllPlayers 로 바꿈(`75530~75532`) | 예약되는 변수 트리거의 체크 플레이어이자 `EndCtrig` 초기화 트리거의 players |
| String | Lua 문자열(Str 타입, 상수) | 없음 | iStr 로 바뀌어 단락에 저장될 **초기 내용**. 보통 `MakeiStrVoid(n)` 같은 빈 버퍼 |

**리턴값**: `{V, StringKey, Size, String}` —
- `[1] V` = `CreateVar(PlayerId)` 의 리턴 `{Player,Index,0,"V"}`(`75534~75538`). 런타임에 iStr 첫 dword 의 EPD 를 담는다.
- `[2] StringKey` = `ParseString` 이 준 맵 문자열 id.
- `[3] Size` = 글자 수(dword 수).
- `[4] String` = 인코딩된 iStr 바이트 **문자열**(`str_to_istr` 리턴, 원문이 아님. 가이드 6289 "입력된 스트링" 과 다름).

**작동 메커니즘**
1. 컴파일 타임(45937~45951):
```lua
-- CtrigAsm v5.5.lua:45938~45951
if TEP30Flag == 1 then __STRxSwitchX = __STRxSwitch else __STRxSwitchX = -1 end
local Size
String, Size = str_to_istr(String)                       -- 현재 STRXFlag 에 맞는 iStr 문자열
StringKey = ParseString(String)                          -- 맵 문자열 테이블에 실제 바이트 등록 (전역 StringKey 오염)
table.insert(StringKeyArr,StringKey)
local V = CreateVar(PlayerId)                            -- CreateVarXAlloc+1, CreateVarPArr 에 "V" 등록
table.insert(iStringKeyArr,{["STRx"]=__STRxSwitchX,StringKey,PlayerId,V,Size})
return {V,StringKey,Size,String}
```
   - `StringKey` 는 `local` 이 아니라 **전역**에 대입된다(다른 함수도 같은 관행, 부작용).
   - `ParseString` 은 TEP 내장. TEP 3.0 에서 `__STRxSwitch==1`(`STRxStart()` 이후)이면 문자열이 STRx 단락에, 아니면 STR 단락에 들어간다(`__STRxSwitchSetting__` 이 C++ 로 전달, `loaderscript.lua:1499~1502`). `StringTable_AddString(...,AlwaysCreate=0)` 이므로 **바이트가 완전히 같은 문자열은 같은 StringKey 를 받는다**(`StringEncoder.cpp:42`, `SICStringList.h:27`) → 같은 `MakeiStrVoid(54)` 로 두 번 `GetiStrId` 하면 두 iStrid 가 **같은 버퍼를 공유**할 수 있다(TEP 3.0 GUI 의 동작이 헤드리스 소스와 같다는 전제, 1.19 참조).
2. 트리거 생성은 이 함수가 아니라 `EndCtrig` 가 한다(`665~671`, `1036~1043`):
```lua
-- CtrigAsm v5.5.lua:1036~1043
for k, v in pairs(iStringKeyArr) do
    if STRXFlag == 0 then -- STR Table
        f_GetiStrptr(v[2],v[3],v[1])          -- (PlayerId, V, StringKey) : V ← 문자열 절대주소
        f_InitiStrptr(v[2],v[3],v[3],v[4])    -- (PlayerId, V, V, Size)  : 재정렬 후 V ← 정렬된 EPD
    else -- STRX Table
        f_GetiStrXepd(v[2],v[3],v[1]) -- +0x0 Fixed   (PlayerId, V, StringKey) : V ← EPD
    end
end
```
   각 등록마다 STR 모드는 6개(+`RecoverCp` 가 플레이어별로 만드는 CP 복구 트리거), STRx 모드는 3개(+`RecoverCp`)의 초기화 트리거가 생기고, 공용 루틴(FPSTR·ISTR 각 수십 개, FISTRX 32개 트리거)은 한 번만 포함된다(`Include_Last`, `83846~84165`). 상세는 1.9~1.11.
3. 런타임: 초기화 구간에서 위 루틴이 돌아 `V` 에 EPD 가 들어간다. 그 뒤 CAPrint 계열이 `iStrid[1]` 을 읽어 SVA1 의 글자를 그 EPD 부터 `Size` 개 dword 로 복사하고, `iStrid[2]`(StringKey) 로 `DisplayText` 한다.
4. 공용 자원: `CreateVarXAlloc` 1 증가, `iStringKeyArr`/`StringKeyArr`/`CreateVarPArr` 추가, 전역 `StringKey`·`__STRxSwitchX` 덮어씀.

**제약·주의사항**
- `String` 은 **Str 타입**(1.0.4). `MakeiStrVoid(n)`(flag 없음) 또는 `MakeiStrLetter(" ",n)` 처럼 넣는다. 예제 26-1(`16155`): `GetiStrId(P1,MakeiStrVoid(100))`.
- 등록된 문자열은 iStr 버퍼로 **덮어써지는 메모리**이므로 다른 곳에서 같은 내용의 `DisplayText("...")` 를 쓰면 문자열 재활용으로 같은 슬롯이 될 수 있다.
- `Size` 보다 긴 텍스트를 CAPrint 로 넣으면 단락의 다음 문자열을 침범한다(범위 검사 없음 — 이 함수 어디에도 길이 검사 코드가 없다).
- 가이드(6282)의 "STR단락 공간 할당용" 은 `STRXFlag` 에 따라 STR 또는 STRx 단락이다. 예제 26-1 머리말(`16151`)의 "STRX 인자를 플립 버전에 맞게" 는 `StartCtrig` 의 1번째 인자 `IncludeSTRx` 이며, **`STRXFlag` 자체는 `StartCtrig` 호출만으로 1 이 된다**(`504`). 즉 v5.5 에서 STR 모드(패딩+재정렬 경로)는 `StartCtrig` 를 안 쓰는 경우에만 활성이다.

**예제**
```lua
-- [예제 26-1] Guide Book.txt:16153~16158
CJump(AllPlayers,0)
CJumpEnd(AllPlayers,0)
DoActions(P1,{CopyCpAction({DisplayTextX(MakeiStrLetter("\r\n",11),4)},EveryPlayers,0)})
iStr1 = GetiStrId(P1,MakeiStrVoid(100))       -- 0x0D 100글자짜리 iStr 버퍼를 단락에 등록, iStr1 = {V,StringKey,100,바이트열}
Str1 = SaveiStrArr(P2,"\x13\x08테\x17스\x07트\x1F☆\n\x13\x04CSPrint \x1C예제\x0E-1\n\x13\x1BT\x19E\x1DS\x02T",1)
CSPrint(iStr1,Str1,{P1,Force5},3,P1,nil,nil,nil,1)   -- Str1 의 iStr 을 iStr1 버퍼에 덮어쓰고 출력
```

**관련 함수**: `GetiTblId`(TBL 판), `SaveiStrArr`/`SaveiStrptr`(변수에 저장), `f_GetiStrptr`/`f_InitiStrptr`/`f_GetiStrXepd`(등록 트리거).

---

### 1.7 GetStrId
**시그니처**: `GetStrId(String)`  (소스: `CtrigAsm v5.5.lua:57286~57291`, 가이드: `Guide Book.txt:3874`)
**한 줄 요약**: 문자열을 **가공 없이** 맵 문자열 테이블에 등록하고 StringId 를 돌려준다(iStr 변환 없음).
**사용 위치**: 컴파일 타임, 아무 곳.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| String | Lua 문자열(또는 숫자 id — `ParseString` 은 숫자를 그대로 돌려줌, `LuaParseString.cpp:34~36`) | 없음 | 그대로 STR(x) 단락에 저장됨 |

**리턴값**: `StringKey`(숫자).

**작동 메커니즘**
```lua
-- CtrigAsm v5.5.lua:57286~57291
function GetStrId(String)
    StringKey = ParseString(String)          -- 전역 StringKey 오염
    table.insert(StringKeyArr,StringKey)
    return StringKey
end
```
트리거 생성 없음. `iStringKeyArr` 에는 넣지 않으므로 **주소 변수도, 초기화 트리거도 생기지 않는다.** `f_GetiStrptr(P, V, GetStrId("..."))` 처럼 직접 주소를 얻는 조합의 재료로 쓴다.

**제약·주의사항**: 같은 내용은 재활용된다(1.6). 가이드 3876 "Str 단락에 그대로 저장" 은 STRx 모드에서는 STRx 단락.

**예제**
```lua
local id = GetStrId("\x04Hello")        -- 일반 문자열 id
DoActions(P1,DisplayText(id,4))          -- 그대로 출력
```

**관련 함수**: `GetiStrId`, `GetStrSize`, `GetStrArr`(25장).

---

### 1.8 GetStrSize
**시그니처**: `GetStrSize(cp949flag, String, Null)`  (소스: `CtrigAsm v5.5.lua:57292~57320`, 가이드: 25장 `Guide Book.txt:3860` 부근 — 26장 3874 인접)
**한 줄 요약**: iStr 이 아닌 **일반 문자열의 바이트 길이**(utf8 또는 cp949 기준)를 돌려준다.
**사용 위치**: 컴파일 타임, 아무 곳.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| cp949flag | 0/nil/"X" → utf8, 그 외 → cp949 | nil → utf8 | 길이를 어느 인코딩 바이트로 셀지 |
| String | 문자열 또는 숫자(StringId → `DecodeString`) | 없음 | |
| Null | nil 또는 그 외 | nil → 0 | nil 이 아니면(값이 0 이어도!) 1 을 더해 종료 NUL 을 포함(57297~57301: `if Null == nil then Null = 0 else Null = 1 end`) |

**리턴값**: `Size`(바이트 수).

**작동 메커니즘**
```lua
-- CtrigAsm v5.5.lua:57302~57318
if cp949flag == "X" or cp949flag == nil or cp949flag == 0 then -- utf8 Size
    if TEP30Flag == 1 then
        local tmp = String; String = {}
        tmp:gsub(".",function(c) table.insert(String,string.byte(c)) end)
        table.insert(String,0)              -- 0 을 하나 붙이고
    else
        String = cp949_to_utf8(String)      -- (끝에 0 이 붙어 옴)
    end
    Size = #String-1+Null                   -- 다시 빼서 순수 바이트 수
else -- cp949 Size
    Size = #String+Null                     -- TEP30 에서도 __encode_cp949 를 하지 않고 그대로 #String
end
```
트리거 생성 없음.

**제약·주의사항**
- **cp949flag=1 에 TEP 3.0(utf8 소스)이면 변환 없이 `#String` 이라 utf8 바이트 수가 나온다**(한글 3바이트로 셈). 소스가 그렇게 되어 있으며, cp949 바이트 수를 원하면 `#__encode_cp949(s)` 를 직접 써야 한다.
- 컬러코드도 바이트로 센다(iStr 의 `GetiStrSize` 와 다름).
- `Null=0` 을 넘겨도 1 이 더해진다(nil 검사만 함).

**예제**
```lua
local n = GetStrSize(0,"가나")      -- utf8: 6
local m = GetStrSize(0,"가나",1)    -- 7 (NUL 포함)
```

**관련 함수**: `GetStrArr`(57321~), `GetiStrSize`.

---

### 1.9 f_GetiStrptr
**시그니처**: `f_GetiStrptr(PlayerID, Output, StringId)`  (소스: `CtrigAsm v5.5.lua:34453~34460`, 가이드: `Guide Book.txt:6373`)
**한 줄 요약**: `STRXFlag` 에 따라 `f_GetStrptr`(STR: 문자열 **절대 주소**를 Output 에) 또는 `f_GetStrXptr`(STRx) 로 위임하는 래퍼.
**사용 위치**: 일반 트리거 흐름 어디서나(트리거를 생성함). `EndCtrig` 가 STR 모드 등록 시 첫 단계로 호출(1038).

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| PlayerID | 플레이어 | 없음 | 생성 트리거의 players |
| Output | V / VA / A / 숫자(오프셋) / 기타 {P,I,N,Addr} | 없음 | 주소를 받을 대상. `f_GetStrptr` 34395~34448 에서 타입별 분기 |
| StringId | 숫자 / 문자열(내용) / V / VA | 없음 | 문자열이면 내부에서 `ParseString` 하고 그 id 를 리턴 |

**리턴값**: `StringKey`(StringId 가 상수·문자열일 때; V/VA 면 nil).

**작동 메커니즘**
```lua
-- CtrigAsm v5.5.lua:34453~34460
function f_GetiStrptr(PlayerID,Output,StringId)
    if STRXFlag == 0 then return f_GetStrptr(PlayerID,Output,StringId)
    else                  return f_GetStrXptr(PlayerID,Output,StringId) end
end
```
STR 경로(`f_GetStrptr`, 34301~34451)가 만드는 트리거(StringId 상수일 때):
1. `FPSTR[1] ← StringKey/2`, `FPSTR[2] ← StringKey%2`(34309~34318). STR 단락은 `uint16 count` 뒤에 `uint16 offset[N]` 이 이어지므로 id N 의 오프셋 워드는 바이트 `2N` = dword 인덱스 `N/2` 의 `N%2` 번째 반쪽이다.
2. `FPSTRCall1` 로 점프(34320~34329, `SetCtrigX("X","X",0x4,...)` 로 자기 next 포인터를 바꾸고 `FPSTRCall2` 트리거의 next 를 자기 다음으로 잇는 호출 관용구).
3. 공용 루틴(`83846~83945`): `FPSTR[3] ← 0x191943C8`, `CP ← EPD(0x191943C8)`, `FPSTR[1]` 트리거의 첫 액션을 "player=EPD(0x6509B0), modifier Add" 로 고쳐 실행 → `CP += N/2`. 이어서 `FPSTR[2]==0` 이면 `DeathsX(CurrentPlayer,Exactly,2^i,0,2^i)` (i=0..15) 로 하위 워드 비트를, 아니면 i=16..31 로 상위 워드 비트를 읽어 `FPSTR[3] += 2^i(/65536)` 한다. 결과 `FPSTR[3] = 0x191943C8 + 오프셋` = **문자열 절대 주소**(EPD 아님).
4. 출력(34395~34448): Output 이 V 면 `FPSTR[3]` 트리거의 액션을 Output 의 `0x15C` 로 향하게 고쳐 실행. 숫자면 그 주소로, VA/A 면 `MovX`.
5. `RecoverCp(PlayerID)`(34450) — `RecoverCpValue=="X"` 이면 플레이어별로 `SetMemory(0x6509B0,SetTo,P)` 트리거를 만들어 CP 를 되돌린다(`5533~5548`).
STR 단락의 고정 주소 0x191943C8 은 소스 주석(`43~44`)에 "STR(X) ptr 고정" 으로 적혀 있다(STRCtrig/euddraft 환경에서 단락이 그 주소에 로드된다는 전제).

**제약·주의사항**
- 리턴은 **절대 주소**다. EPD 가 필요하면 `f_InitiStrptr`(재정렬까지) 또는 STRx 경로를 쓴다.
- 이 루틴은 `Include_Last` 에서 `FPSTRCheck==1` 일 때만 포함되며, `EndCtrig` 665~668 이 `STRXFlag==0` 이고 iStr 등록이 있을 때 자동으로 켠다. 사용자가 직접 부를 때는 `f_GetStrptr` 첫 줄(`34302`)이 `FPSTRCheck = 1` 로 켠다.
- `StringKey/2` 는 Lua 실수 나눗셈이라 홀수 id 에서 `x.5` 가 `SetCtrig1X` 값으로 들어간다. `Action` 인코딩이 이를 정수화하는지는 소스에서 확인 불가(STR 모드 자체가 v5.5 실전 맵에서 비활성).
- 가이드 6374 "StartCtrig 의 STRX 옵션에 따라 선택" — 소스는 `STRXFlag` 로 선택하며, 그 값은 `StartCtrig` 호출 여부로만 정해진다(옵션 아님).

**예제**
```lua
-- STR 모드(StartCtrig 미사용) 에서 문자열 절대주소를 변수에
local Ptr = CreateVar(P1)
f_GetiStrptr(P1, Ptr, GetStrId("Hello"))   -- Ptr ← 0x191943C8 + offset("Hello")
```

**관련 함수**: `f_GetStrptr`, `f_GetStrXptr`, `f_InitiStrptr`, `f_GetiStrXepd`, `f_GetTblptr`(TBL 판).

---

### 1.10 f_GetiStrXepd
**시그니처**: `f_GetiStrXepd(PlayerID, Output, StringId)`  (소스: `CtrigAsm v5.5.lua:34044~34172`, 가이드: `Guide Book.txt:6380`)
**한 줄 요약**: STRx 단락(4바이트 오프셋 테이블)에서 StringId 문자열의 **EPD** 를 계산해 Output 에 넣는다. 재정렬 없음("+0x0 Fixed").
**사용 위치**: 일반 트리거 흐름 어디서나. `EndCtrig` 가 STRx 모드 등록 시 호출(1041).

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| PlayerID | 플레이어 | 없음 | 생성 트리거 players |
| Output | 숫자(주소) / V / VA / A / {P,I,N,Addr} | 없음 | EPD 를 받을 대상(34116~34169) |
| StringId | 숫자 / 문자열 / V / VA | 없음 | 문자열이면 `ParseString` 후 `Disabled(DisplayText(StringKey,4))` 를 액션에 끼워 문자열 참조를 살려 둠(34066) |

**리턴값**: `StringKey`(상수·문자열일 때).

**작동 메커니즘**
1. 입력(34048~34092): 상수면 `SetCtrig1X("X",FISTRX[1],0x15C,0,SetTo,StringKey)`; V 면 V→`FISTRX[1]` 복사 관용구(0x158/0x148/0x160 + `CallLabelAlways`); VA 면 `MovX`.
2. 호출(34102~34112): `FISTRXCall1` 로 점프, `FISTRXCall2` 가 돌아올 곳을 가리키게 함. `FISTRXCall1 == 0` 이면 `Need_Include_MiscFunc()` 에러.
3. 공용 루틴(`84074~84123`, 트리거 1+30+1 = 32개):
```lua
-- CtrigAsm v5.5.lua:84085~84091
SetCVar("X",FISTRX[2],SetTo,EPD(0x191943C8));                 -- 결과 = STRx 단락 EPD 부터
SetMemory(0x6509B0,SetTo,EPD(0x191943C8));                    -- CP = STRx 단락 EPD
SetCtrig1X("X",FISTRX[1],0x158,0,SetTo,EPD(0x6509B0));        -- FISTRX[1] 트리거가 CP 에
SetCtrig1X("X",FISTRX[1],0x148,0,SetTo,0xFFFFFFFF);
SetCtrig1X("X",FISTRX[1],0x160,0,SetTo,Add*16777216,0xFF000000);  -- Add 하도록
CallLabelAlways("X",FISTRX[1],0);                              -- CP += StringId  → offset[StringId] dword
-- 84097~84109: i = 2..31
DeathsX(CurrentPlayer,Exactly,CBit,0,CBit)  →  SetCtrig1X("X",FISTRX[2],0x15C,0,Add,CBit/4);
```
   STRx 는 `uint32 count` 뒤에 `uint32 offset[N]` 이므로 id N 의 오프셋 dword 는 단락 시작 + 4N, 즉 `CP = EPD(단락)+N`. 오프셋의 비트 2..31 만 더하므로 `FISTRX[2] = EPD(단락) + floor(오프셋/4)` = **문자열 시작 dword 의 EPD**. 비트 0,1(오프셋%4)은 버려진다 — 문자열이 4바이트 정렬되어 있지 않으면 시작이 최대 3바이트 앞으로 밀린 잘못된 EPD 가 된다. STRx 문자열이 정렬돼 저장되는지는 STRCtrig/euddraft 쪽 책임이며 이 소스에서는 확인 불가(주석 "+0x0 Fixed" 가 그 전제를 뜻함).
4. 출력(34116~34169): Output 타입별로 `FISTRX[2]` 를 복사.
5. `RecoverCp(PlayerID)`(34171). `FISTRXCheck = 1`(34113) 로 루틴 포함 요청. TEP30STRx 모드에서는 루틴 자체가 `STRxStart()~STRxEnd()` 로 감싸여 STRx 단락에 놓인다(84075~84078, 84119~84122).

**제약·주의사항**
- `STRXFlag==1` 등록 경로에서는 `f_InitiStrptr` 를 부르지 않는다. 즉 **STRx iStr 은 선두 패딩도, 런타임 재정렬도 없다.** `str_to_istr` 가 `STRXFlag==1` 일 때 패딩을 안 넣는 것과 짝이다.
- 가이드 6381 "euddraft 0.8.9.0 이후, StartCtrig 에서 STRX 옵션 선택 필수" — 소스에는 버전 검사가 없다. `IncludeSTRxFlag`(StartCtrig 1번째 인자)는 이 함수와 무관하다(grep 상 이 함수 안에서 참조 없음).

**예제**
```lua
local E = CreateVar(P1)
local id = f_GetiStrXepd(P1, E, "\x04TEXT")   -- E ← "\x04TEXT" 문자열의 EPD, id = 그 StringId
TSetMemoryX(V(E),SetTo,0x0D0D0D41,0xFFFFFFFF)  -- 첫 dword 를 직접 고치는 식으로 활용
```

**관련 함수**: `f_GetStrXptr`(EPD 대신 절대주소), `f_GetiStrptr`, `f_GetTblptr`.

---

### 1.11 f_InitiStrptr
**시그니처**: `f_InitiStrptr(PlayerID, Output, StringOffset, Size)`  (소스: `CtrigAsm v5.5.lua:34461~34514`, 가이드: 미수록(6355~6395 구간에 없음, v5.5 소스 기준))
**한 줄 요약**: STR 단락의 iStr(선두 0x0D 3바이트 포함)을 **문자열 절대주소의 %4 에 따라 dword 경계로 제자리 이동**시키고, 정렬된 첫 dword 의 EPD 를 Output 에 넣는다.
**사용 위치**: 일반 트리거 흐름(트리거 생성). `EndCtrig` 가 STR 모드에서 `f_GetiStrptr` 바로 뒤에 호출(1039).

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| PlayerID | 플레이어 | 없음 | 생성 트리거 players |
| Output | V (또는 {P,I,N,Addr}) | 없음 | 정렬된 iStr 의 EPD 를 받을 변수. 소스는 `Output[1..3]` 을 V 로 가정(34503) |
| StringOffset | V | 없음 | `f_GetiStrptr` 가 채운 **절대 주소** 변수(EPD 아님). 등록 흐름에서는 Output 과 같은 V |
| Size | 상수 | 없음 | 글자 수(dword 수). `ISTR[4]` 로 들어가 루프 횟수 |

**리턴값**: 없음.

**작동 메커니즘**
1. 입력 트리거(34463~34476): `ISTR[4] ← Size`(상수), `StringOffset`(V) → `ISTR[1]` 복사 관용구.
2. 호출 트리거(34480~34490): `ISTRCall1` 로 점프. `ISTRCall1 == 0` 이면 `Need_Include_MiscFunc()`(34494~34496; 호출 트리거를 만든 뒤에 검사한다).
3. 공용 루틴(`84126~84165`, `ISTRCheck==1` 일 때 `Include_Last` 가 생성):
```lua
-- CtrigAsm v5.5.lua:84136~84139
CMod(IncludePlayer,V(ISTR[3]),V(ISTR[1]),4)   -- ISTR[3] = 주소%4, 몫(주소/4)은 CRet[1] 에 남음 (CMod 24935~24984)
CMov(IncludePlayer,V(ISTR[2]),V(CRet[1]))      -- ISTR[2] = 주소/4
CiSub(IncludePlayer,V(ISTR[2]),1452249)        -- 1452249 = 0x58A364/4 → ISTR[2] = EPD(주소 & ~3)
CMov(IncludePlayer,V(ISTR[5]),V(ISTR[2]))      -- ISTR[5] = 출력용 EPD 백업
```
   이어서 `ISTR[3]`(주소%4)로 4갈래 `CIfX/CElseIfX`(84141~84157). 단락에 저장된 바이트는 `0D 0D 0D | C1 x x x | C2 x x x | ... | Cn x x x | 00` 이므로 첫 글자의 컬러 슬롯은 주소+3 에 있다.

| 주소%4 | 저장 모습(dword 경계 기준) | 처리 | 출력 EPD |
|---|---|---|---|
| 0 ("<- 3byte") | `[0D 0D 0D C1][x x x C2]…[x x x 00]` | Size 회 루프: `dword[k] = dword[k]>>24  OR  dword[k+1]<<8` (두 `TSetMemoryX`: 마스크 0xFF 에 `_ReadFX(EPD,0xFF000000,"-3")`, 마스크 0xFFFFFF00 에 `_ReadFX(EPD+1,0xFFFFFF,"+1")`), 매 회 `ISTR[2]+1`. 루프 후 다음 dword 하위 3바이트에 `0x0D0D0D` | EPD(주소) |
| 1 ("<- 0byte") | `[?? 0D 0D 0D][C1 x x x]…` | 이미 정렬됨. 이동 없음 | EPD+1 |
| 2 ("<- 1byte") | `[?? ?? 0D 0D][0D C1 x x][x C2 x x]…` | EPD+1 부터 Size 회: `dword = dword>>8 OR next<<24` (마스크 0xFFFFFF / 0xFF000000). 루프 후 하위 1바이트에 `0x0D` | EPD+1 |
| 3 ("<- 2byte") | `[?? ?? ?? 0D][0D 0D C1 x][x x C2 x]…` | EPD+1 부터 Size 회: `dword = dword>>16 OR next<<16` (마스크 0xFFFF / 0xFFFF0000). 루프 후 하위 2바이트에 `0x0D0D` | EPD+1 |

```lua
-- CtrigAsm v5.5.lua:84141~84145 (주소%4==0 갈래)
CIfX(IncludePlayer,CVar("X",ISTR[3],Exactly,0)) -- <- 3byte
    CWhile(IncludePlayer,CVar("X",ISTR[4],AtLeast,1),SetCVar("X",ISTR[4],Subtract,1))
        CDoActions(IncludePlayer,{TSetMemoryX(V(ISTR[2]),SetTo,_ReadFX(V(ISTR[2]),0xFF000000,"-3"),0xFF),
                                  TSetMemoryX(V(ISTR[2]),SetTo,_ReadFX(_Add(V(ISTR[2]),1),0xFFFFFF,"+1"),0xFFFFFF00)})
    CWhileEnd(SetCVar("X",ISTR[2],Add,1))
    CDoActions(IncludePlayer,{TSetMemoryX(V(ISTR[2]),SetTo,0x0D0D0D,0xFFFFFF)})
```
   즉 선두 3바이트 0x0D 는 **"어느 %4 에 놓이더라도 최대 3바이트 앞으로 당길 수 있는 여유분"** 이고, 당긴 뒤 비는 꼬리는 0x0D 로 메워 종료 NUL 앞까지 "안 그리는 공백" 이 되게 한다(꼬리 dword 의 나머지 바이트는 단락의 NUL/다음 문자열 바이트가 그대로 남음).
4. 출력 트리거(34499~34511): `ISTR[5]` → Output 복사 관용구. `ISTRCheck = 1`(34512).
5. 이 루틴은 `TEP30STRx` 감싸기(STRxStart/End)가 **없다**(84126 블록에는 FISTRX/ITBL 블록과 달리 해당 코드가 없음).

**제약·주의사항**
- `StringOffset` 은 절대 주소여야 한다(내부에서 `-0x58A364/4`). `f_GetStrXptr`/`f_GetiStrXepd` 의 결과를 넣으면 안 된다.
- 문자열은 반드시 `STRXFlag==0` 상태의 `str_to_istr` 로 만든 것(선두 3바이트 있음)이어야 한다. 패딩 없는 iStr 을 넣으면 첫 글자가 잘린다.
- `Size` 는 글자 수. 루프가 `Size` 회 dword 를 읽으므로 뒤 dword(k+1)를 항상 하나 더 읽는다(문자열 끝 NUL 포함 영역).
- 이 함수는 가이드 v5.4 에 항목이 없고, 소스 주석 "Ret[4] : Size (4N+3)" 도 실제 호출(글자 수)과 표기가 다르다.

**예제**
```lua
-- EndCtrig 1038~1039 가 하는 일을 손으로 쓰면:
local Ptr = CreateVar(P1)
local id = GetiStrId(P1, MakeiStrVoid(20))      -- STRXFlag==0 환경(StartCtrig 미사용)
f_GetiStrptr(P1, Ptr, id[2])                     -- Ptr ← 절대주소
f_InitiStrptr(P1, Ptr, Ptr, id[3])               -- 재정렬, Ptr ← 정렬된 EPD
```

**관련 함수**: `f_InitiTblptr`(TBL 판, 84167~), `f_GetiStrptr`, `CMod`/`CiSub`/`_ReadFX`.

---

### 1.12 MakeiStrVoid
**시그니처**: `MakeiStrVoid(Size, flag)`  (소스: `CtrigAsm v5.5.lua:46348~46361`, 가이드: `Guide Book.txt:6325`)
**한 줄 요약**: 0x0D(안 그리는 공백) `Size` 글자짜리 문자열을 만든다. iStr 버퍼 초기값의 표준 재료.
**사용 위치**: 컴파일 타임, 아무 곳.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| Size | 정수 | 없음(nil 이면 `for` 에서 에러) | 글자 수 |
| flag | 0 / "X" / nil → Str 타입, 그 외(1) → iStr 타입 | nil → Str 타입 | Str 타입: 글자당 `"\x0D"` 1바이트. iStr 타입: 글자당 `"\x0D\x0D\x0D\x0D"` 4바이트(46350~46358) |

**리턴값**: Lua 문자열(배열 아님).

**작동 메커니즘**
```lua
-- CtrigAsm v5.5.lua:46348~46361
if flag == 0 or flag == "X" or flag == nil then
    for i = 1, Size do Void = Void.."\x0D" end
else
    for i = 1, Size do Void = Void.."\x0D\x0D\x0D\x0D" end
end
```
트리거 생성 없음. Str 타입을 `str_to_*` 에 넣으면 0x0D 가 "1바이트 글자" 분류라 각 글자가 `0D 0D 0D 0D` dword 가 된다 — 결과적으로 iStr 타입 문자열과 바이트가 같다. 그래서 **`GetiStrId`/`SaveiStrArr` 에는 flag 없이** 넣는다.

**제약·주의사항**: flag=1 결과를 `GetiStrId` 에 넣으면 4배 길이 버퍼가 된다(1.0.4). flag=1 은 `MakeiTblString` 처럼 원시 바이트를 그대로 쓰는 곳(`theSeed/MapLogic/StatTxtPatch.lua:187` 참조)용.

**예제**
```lua
iStr1 = GetiStrId(P1,MakeiStrVoid(100))                 -- [예제 26-1] 16155: 100글자 빈 버퍼
Str54 = CreateSV54(P1,MakeiStrVoid(40))                  -- [예제 26-27] 17265
PtiStr = GetiStrId(FP,MakeiStrVoid(GetiStrSize(0, ls01)+10))   -- MSF_Memory_2/LeaderBoardFunc.lua:7
```

**관련 함수**: `MakeiStrLetter`, `MakeiStrWord`.

---

### 1.13 MakeiStrLetter
**시그니처**: `MakeiStrLetter(Letter, Size, flag, cp949flag)`  (소스: `CtrigAsm v5.5.lua:46362~46443`, 가이드: `Guide Book.txt:6331` — **가이드에는 cp949flag 인자가 없음(v5.5 추가)**)
**한 줄 요약**: 한 글자(컬러코드 포함 가능)를 `Size` 번 반복한 문자열을 만든다. flag=1 이면 iStr 4바이트 배치로 만든다.
**사용 위치**: 컴파일 타임, 아무 곳.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| Letter | 문자열(글자 1개, 앞에 컬러코드 1개 허용) | 없음 | flag=1 일 때는 첫 바이트로 종류를 판정 |
| Size | 정수 | 없음 | 반복 횟수(글자 수) |
| flag | 0/"X"/nil → Str 타입, 그 외 → iStr 타입 | nil | Str 타입은 `Letter` 를 그냥 `Size` 번 이어붙임(46366~46368, 46410~46412) |
| cp949flag | nil/0 → utf8 판정 분기, 그 외 → cp949 판정 분기 | nil | `TEP30Flag == 1 and (cp949flag == nil or cp949flag == 0)` 이면 3바이트 분기가 있는 앞쪽 블록(46364~46408), 아니면 2바이트까지만 보는 뒤쪽 블록(46409~46441). **flag 가 iStr 타입일 때만 의미 있음** |

**리턴값**: Lua 문자열.

**작동 메커니즘**
- Str 타입(flag nil): `Void = Void..Letter` 반복. 컬러코드가 붙어 있으면 그대로 반복되므로 `str_to_*` 에서 매 글자 byte0 에 그 컬러가 들어간다.
- iStr 타입(flag=1): 첫 바이트 `ret[1]` 로 분기(46375~46407):
  - 1바이트 글자 → 글자당 `'\x0D\x0D\x0D'..Letter`(46377~46379) = `0D 0D 0D X`.
  - 컬러코드 → `ret[2]` 가 또 컬러코드면 `MakeiStrLetter_InputData_Error()`(미정의 함수 호출 에러, 46394). 아니면 `ret[1]` 로 다시 1바이트 판정을 하고 `'\x0D\x0D'..Letter`(= `C 0D 0D X`) 를 만들려 하나, **`ret[1]` 은 컬러코드라 이 조건이 거짓**이고 이어지는 `elseif v >= 0xE0` / `v >= 0x80` 의 `v` 는 **어디에도 선언되지 않은 전역(nil)** 이라 "attempt to compare nil with number" 로 죽는다.
  - 2바이트/3바이트 글자 → 역시 `v >= 0xE0`(46381), `v >= 0x80`(46385) 을 검사하므로 같은 이유로 **Lua 에러**.
  즉 **flag=1 은 "컬러코드 없는 1바이트 글자" 에서만 동작**한다(소스 그대로; `v` 는 `ret[1]` 의 오기로 보이나 추측이므로 사실만 기록). 자매 프로젝트는 전부 `MakeiStrLetter("\x0D", n)`(flag 없음)으로만 쓴다(`Stella-II/Vars.lua:407`, `theSeed/MapLogic/SelectedUnitInfo.lua:170`).
- 트리거 생성 없음.

**제약·주의사항**
- 가이드 6333 "Letter : 컬러코드+1글자" 는 Str 타입(flag 없음)에서만 성립. iStr 타입에서 컬러코드·한글은 에러.
- `MakeiStrLetter("\r\n",11)`(예제 26-1 `16154`)은 2글자 문자열을 11번 반복 — 함수는 `#Letter` 를 검사하지 않으므로 단어도 들어간다(`MakeiStrWord` 와 같은 결과).

**예제**
```lua
iStr1 = GetiStrId(P1,MakeiStrLetter(" ",30))                          -- [예제 26-16] 16657: 스페이스 30글자
S1 = MakeiTblString(1394,"None",'None',MakeiStrLetter("\x0D",iStrSize1+5),"Base",1)  -- Stella-II/Vars.lua:407
```

**관련 함수**: `MakeiStrVoid`, `MakeiStrWord`.

---

### 1.14 MakeiStrWord
**시그니처**: `MakeiStrWord(String, Size)`  (소스: `CtrigAsm v5.5.lua:46444~46451`, 가이드: `Guide Book.txt:6338`)
**한 줄 요약**: 문자열을 `Size` 번 이어붙인 Str 타입 문자열을 돌려준다.
**사용 위치**: 컴파일 타임, 아무 곳.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| String | 문자열 | 없음 | 반복 단위(컬러코드·개행 포함 가능) |
| Size | 정수 | 없음 | 반복 횟수 |

**리턴값**: Lua 문자열.

**작동 메커니즘**: `for i=1,Size do Void = Void..String end`(46446~46449). 가이드 6340 "Size : 만들 문자열의 길이" 는 정확히는 **반복 횟수**이며 결과 글자 수는 `Size × 글자수(String)`. 트리거 생성 없음.

**예제**
```lua
iStr1 = GetiStrId(P1,MakeiStrWord("CAPrint 예제-E\n",6))                -- [예제 26-14] 16580: 13글자 × 6줄
Str3 = SaveiStrptr(P3,"\x13"..MakeiStrWord("\x08T\x17E\x07S\x1FT",2),1)   -- [예제 26-2] 16165
local OPiStr = GetiStrId(FP,MakeiStrWord(MakeiStrVoid(54).."\r\n",8))    -- MSF_UE_RE/Operator.lua:160: 54칸+개행 × 8줄
```

**관련 함수**: `MakeiStrVoid`, `MakeiStrLetter`.

---

### 1.15 MakeiStrData
**시그니처**: `MakeiStrData(Letter, Fill)`  (소스: `CtrigAsm v5.5.lua:49412~49449`, 가이드: `Guide Book.txt:6423`)
**한 줄 요약**: 글자 1개(컬러코드 포함 가능)의 **cp949 iStr dword 값(숫자)** 을 만든다. `CA__SetMemoryX`, `CA__ConvertLetter/Color`, `CreateVar2` 초기값 등에 쓴다.
**사용 위치**: 컴파일 타임, 아무 곳.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| Letter | 1~3바이트(cp949 기준) 문자열: `X`, `C X`, `X1 X2`, `C X1 X2` | 없음 | TEP30Flag==1 이면 `__encode_cp949` 로 먼저 cp949 화(49413~49415). 4바이트 이상이면 `Temp` 가 nil 로 리턴 |
| Fill | 1 → 빈 바이트를 0x0D 로 채움 / 그 외 → 0x00 | nil → 0x00 | |

**리턴값**: 32비트 정수(dword 값, little-endian 으로 메모리에 쓰면 iStr 한 글자). 규칙에 안 맞으면 nil.

**작동 메커니즘**(49421~49446)
| 바이트 수 | 판정 | 값(Fill=1) | 메모리 바이트(byte0..3) |
|---|---|---|---|
| 1 | — | `A1<<24 + 0x0D0D0D` | `0D 0D 0D X` |
| 2, `A1>=0x20`(cp949 선행바이트 0x81~ 포함; 주석 "1byte" 는 오기) | 2바이트 글자 | `A1<<16 + A2<<24 + 0x0D0D` | `0D 0D X1 X2` |
| 2, 그 외(A1 이 컬러코드) | 컬러+1바이트 | `A1 + A2<<24 + 0x0D0D00` | `C 0D 0D X` |
| 3 | 컬러+2바이트 | `A1 + A2<<16 + A3<<24 + 0x0D00` | `C 0D X1 X2` |
Fill≠1 이면 0x0D 자리가 모두 0x00. `(A1>=0x9 and A1<=0xD) or (A1>=0x12 and A1<=0x13)` 는 `A1>=0x20` 에 or 로 묶여 있어 0x09~0x0D, 0x12, 0x13 을 첫 바이트로 갖는 2바이트 입력(예: `"\rA"`)도 "2바이트 글자" 취급이 된다(소스 그대로). 트리거 생성 없음.

**제약·주의사항**
- 이 값은 **cp949 iStr** 전용. utf8 iStr(X 계열)에는 `MakeiStrDataX`.
- 컬러코드만 1바이트로 넣으면 `0D 0D 0D C` 가 되어 컬러 슬롯이 아닌 byte3 에 들어간다 — 컬러만 바꾸려면 `CA__SetColor` 나 마스크 0xFF 로 `MakeiStrData("\x04A",1)` 의 하위 바이트를 쓴다.

**예제**
```lua
-- [예제 26-14] Guide Book.txt:16587~16595
local VA2Init = {"Ｃ","Ａ","Ｐ","ｒ","ｉ","ｎ","ｔ"," ","예","제","－","Ｅ"}
for i = 1, #VA2Init do
    table.insert(VA2Act,SetCVAar(VArr(VA2,i-1),SetTo,MakeiStrData(VA2Init[i],1)))  -- 전각/한글 = 0D 0D X1 X2
end
CA__SetMemoryX(11+13*4,MakeiStrData("\x04e",1))    -- 16606: 04 0D 0D 65 를 글자 위치 63 에
-- [예제 26-16] 16663: CreateVar2 초기값으로
A = CreateVar2(P1,nil,nil,MakeiStrData("ａ",1))
```

**관련 함수**: `MakeiStrDataX`, `MakeiStrDiff`, `CA__SetMemoryX`, `CA__ConvertLetter`.

---

### 1.16 MakeiStrDiff
**시그니처**: `MakeiStrDiff(Start, End)`  (소스: `CtrigAsm v5.5.lua:49450~49477`, 가이드: `Guide Book.txt:6429`)
**한 줄 요약**: 두 글자(컬러코드 없이 1~2바이트 cp949)의 dword 값 차 `End - Start` 를 돌려준다. `CA__ConvertLetter` 의 범위 변환(예: 'A'..'Z' → 'ａ'..'Ｚ')용 가산값.
**사용 위치**: 컴파일 타임.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| Start | 1바이트 또는 2바이트 글자(컬러코드 불가) | 없음 | TEP30 이면 `__encode_cp949` |
| End | 동일 | 없음 | 3바이트 이상이면 `X`/`Y` 가 nil → 산술 에러 |

**리턴값**: 정수(음수 가능).

**작동 메커니즘**(49463~49475)
- 1바이트: `A1<<24 + 0x0D0000`(byte2 에 0x0D 를 넣은 값 = `?? ?? 0D X`), 2바이트: `A1<<16 + A2<<24`.
- `ret = Y - X`. 1바이트 글자의 byte2 를 0x0D 로 둔 것은, `MakeiStrData(...,1)` 로 채운 대상 dword(`0D 0D 0D X`)에 이 차를 더했을 때 2바이트 글자(`0D 0D X1 X2`)로 정확히 넘어가게 하기 위한 보정이다(예: 'A'(0x41) → 'ａ'(cp949 A3 E1): X = 0x41000000+0x0D0000, Y = 0xE1A30000, 차를 `0D 0D 0D 41` 에 더하면 `0D 0D A3 E1`).
- 트리거 생성 없음.

**제약·주의사항**: 컬러코드가 든 입력은 2바이트로 오판되어 엉뚱한 값이 된다. Fill 없이 저장된(0x00 패딩) 글자에 더하면 byte2 보정이 어긋난다 — 짝이 되는 데이터는 `MakeiStrData(...,1)` 로 만든다.

**예제**
```lua
-- [예제 26-16] Guide Book.txt:16664~16668
G = CreateVar2(P1,nil,nil,MakeiStrDiff("A","ａ"))          -- 'A'→'ａ' 가산값
local LetterArr = {{{E,F},G,{H,0xFF0000}}, ...}             -- E..F 범위 글자에 G 를 더해 변환
CA__ConvertLetter(Str1,LetterArr,nil,1,12)
```

**관련 함수**: `MakeiStrDiffX`, `MakeiStrData`, `CA__ConvertLetter`.

---

### 1.17 MakeiStrDataX
**시그니처**: `MakeiStrDataX(Letter, Fill)`  (소스: `CtrigAsm v5.5.lua:49478~49536`, 가이드: `Guide Book.txt:6972`)
**한 줄 요약**: 글자 1개의 **utf8 iStr dword 값**을 만든다(X 계열: CDPrint/C13Print/CA__OverWrite/DisplayX 용).
**사용 위치**: 컴파일 타임.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| Letter | utf8 1~4바이트: `X`, `C`, `C X`, `X1 X2`, `C X1 X2`, `X1 X2 X3`, `C X1 X2 X3` | 없음 | TEP30 이면 바이트 분해만, 구 TEP 면 `cp949_to_utf8` 후 끝 0 제거(49481~49487) |
| Fill | 1 → 0x0D 채움 / 그 외 → 0x00 | nil | |

**리턴값**: 정수(dword). 5바이트 이상은 nil.

**작동 메커니즘**(49488~49533)
| 바이트 수 | 판정 | 값(Fill=1) | 메모리 바이트 |
|---|---|---|---|
| 1, 글자(`A1>=0x20` 또는 0x9~0xD, 0x12,0x13) | 1바이트 글자 | `A1<<24 + 0x0D0D0D` | `0D 0D 0D X` |
| 1, 그 외 | 컬러코드 단독 | `A1 + 0x0D0D0D00` | `C 0D 0D 0D` |
| 2, A1 이 컬러코드 | 컬러+1바이트 | `A1 + A2<<24 + 0x0D0D00` | `C 0D 0D X` |
| 2, 그 외 | utf8 2바이트 | `A1<<16 + A2<<24 + 0x0D0D` | `0D 0D X1 X2` |
| 3, A1 이 컬러코드 | 컬러+2바이트 | `A1 + A2<<16 + A3<<24 + 0x0D00` | `C 0D X1 X2` |
| 3, 그 외 | utf8 3바이트(한글) | `A1<<8 + A2<<16 + A3<<24 + 0x0D` | `0D X1 X2 X3` |
| 4 | 컬러+3바이트 | `A1 + A2<<8 + A3<<16 + A4<<24` | `C X1 X2 X3` |
`MakeiStrData` 와 달리 컬러코드 판정을 정식 범위(0x1~0x8, 0xE~0x11, 0x14~0x1F)로 하고, 컬러코드 단독 입력도 지원한다. 트리거 생성 없음.

**제약·주의사항**: cp949 iStr(CAPrint/CSPrint)에 쓰면 안 된다. 예제 26-27 의 `LetterArr` 안에 섞인 `MakeiStrData("Ａ",1)`(17275) 는 가이드 예제 원문 그대로이며 utf8 문맥에서는 `MakeiStrDataX` 가 맞을 것으로 보이나, 예제 의도는 소스에서 확인 불가.

**예제**
```lua
-- [예제 26-27] Guide Book.txt:17269~17271
A = CreateVar2(P1,nil,nil,MakeiStrDataX("ａ",1))   -- 0D EF BD 81
C = CreateVar2(P1,nil,nil,MakeiStrDataX("☆",1))    -- 0D E2 98 86
CA__ConvertColor(Str2,{{MakeiStrDataX("으",1),MakeiStrDataX("\x08으",1)}, ...}, ...)   -- 17283: 컬러만 다른 두 dword
```

**관련 함수**: `MakeiStrData`, `MakeiStrDiffX`, `str_to_iutf8`.

---

### 1.18 MakeiStrDiffX
**시그니처**: `MakeiStrDiffX(Start, End)`  (소스: `CtrigAsm v5.5.lua:49537~49570`, 가이드: `Guide Book.txt:6980`)
**한 줄 요약**: utf8 iStr 기준 두 글자 dword 값의 차 `End - Start`.
**사용 위치**: 컴파일 타임.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| Start / End | utf8 1~3바이트 글자(컬러코드 불가) | 없음 | TEP30 이면 바이트 분해, 구 TEP 면 `cp949_to_utf8` 후 끝 0 제거(49540~49551) |

**리턴값**: 정수.

**작동 메커니즘**(49553~49569)
- 1바이트: `A1<<24 + 0x0D0D00`(byte1,byte2 를 0x0D 로 본 값), 2바이트: `A1<<16 + A2<<24 + 0x0D00`(byte1 을 0x0D 로), 3바이트: `A1<<8 + A2<<16 + A3<<24`.
- 즉 각 글자를 `MakeiStrDataX(...,1)` 의 byte1~byte3 부분과 같은 형태로 놓고 빼므로, Fill=1 로 저장된 dword 에 더하면 1바이트↔3바이트 사이 변환에서도 패딩이 정확히 맞는다(예: 'A' → 'ａ'(EF BD 81): X = 0x41000000+0x0D0D00 = 0x410D0D00, Y = 0xEF<<8 + 0xBD<<16 + 0x81<<24 = 0x81BDEF00, `MakeiStrDataX("A",1)` = 0x410D0D0D 에 (Y-X) 를 더하면 0x81BDEF0D = `0D EF BD 81`. byte0(컬러 슬롯)은 두 값 모두 0 이므로 변하지 않는다).
- 트리거 생성 없음.

**제약·주의사항**: 1.16 과 같은 이유로 컬러코드 포함 입력 불가, Fill=1 데이터와만 짝.

**예제**
```lua
G = CreateVar2(P1,nil,nil,MakeiStrDiffX("A","ａ"))       -- [예제 26-27] 17271
CA__ConvertLetter(Str1,LetterArr,nil,1,12,1)               -- 17276: 마지막 인자 1 = utf8(X) 모드
```

**관련 함수**: `MakeiStrDiff`, `MakeiStrDataX`, `CA__ConvertLetter`.

---

### 1.19 가이드 vs 소스 차이 · 미확인 사항 (이 그룹)

**가이드와 소스가 다른 점**
1. `MakeiStrLetter` 는 소스에 4번째 인자 `cp949flag` 가 있다(가이드 6331 은 3개).
2. `GetiStrId` 리턴 `[4]` 는 원문이 아니라 `str_to_istr` 가 만든 iStr 바이트 문자열(가이드 6289 "입력된 스트링").
3. `f_InitiStrptr` 는 가이드 26장에 항목이 없다(소스 34461). STR 모드 등록의 필수 2단계.
4. `f_GetiStrptr` 의 STR/STRx 선택은 "StartCtrig 의 STRX 옵션"(가이드 6374)이 아니라 `STRXFlag` 이며, 이 값은 `StartCtrig` 호출 자체로 1 이 된다(`504`). 따라서 v5.5 에서 `StartCtrig` 를 쓰면 항상 STRx 경로(`f_GetiStrXepd`)다.
5. `GetiStrArr`/`GetiStrSize` 의 cp949flag 는 nil 과 "X" 도 utf8 로 처리(가이드는 0/1 만 기술).
6. `MakeiStrWord` 의 `Size` 는 "문자열 길이"가 아니라 반복 횟수.
7. `MakeiStrLetter` flag=1 은 컬러코드·2/3바이트 글자에서 미선언 전역 `v` 비교로 Lua 에러 — 가이드 6333 "컬러코드+1글자" 는 Str 타입에서만 성립.
8. `GetStrSize(1, ...)` 는 TEP 3.0 에서 cp949 변환을 하지 않아 utf8 바이트 수를 돌려준다(가이드 3873 "cp949: 한글 2바이트" 와 불일치).
9. `f_GetiStrXepd` 가이드 6381 의 "euddraft 0.8.9.0 이후 / STRX 옵션 선택 필수" 에 해당하는 검사 코드는 소스에 없다.

**소스에서 확인 불가 / 미확인**
- `__encode_cp949`(CtrigAsm 이 부르는 이름, 소문자)와 TEP 3.0 헤드리스 포팅 소스가 등록한 `__Encode_cp949`(`TriggerEncode.cpp:999`, 대문자 E)의 불일치. 실전 맵(theSeed 등)이 `MakeiTblString` → `tbl_to_itbl` → `__encode_cp949` 경로를 문제없이 컴파일하므로 GUI TEP 3.0 은 소문자 이름도 제공하는 것으로 보이나, 그 근거 코드는 이 저장소에 없다.
- STRx 단락 문자열의 4바이트 정렬 보장(`f_GetiStrXepd` 가 오프셋%4 를 버리는 전제) — STRCtrig/euddraft 측 동작, 본 소스 범위 밖.
- `ParseString` 의 동일 문자열 재활용이 TEP 3.0 GUI(STRCtrig 플러그인 포함)에서도 헤드리스 소스(`AlwaysCreate=0`)와 같은지.
- `f_GetStrptr` 의 `StringKey/2`(실수) 가 액션 인코딩에서 어떻게 정수화되는지.
- `str_to_*` 의 STR 모드 `\0` 종료 시 `Size = n+1` 이 되는 비대칭이 의도인지.
- `TEP30Flag` 판정 키는 소문자 `__mapdirsetting`(`CtrigAsm v5.5.lua:3`)인데 헤드리스 포팅의 로더스크립트에는 `__MapDirSetting`(대문자)만 보인다(`loaderscript.lua:1503`). GUI TEP 3.0 이 소문자 전역을 따로 두는지는 이 저장소에서 확인 불가.
- `EndCtrig` 초기화 구간(`InitCtrig()` 이후, STRx init 1/2 체인 사이)에 방출되는 등록 트리거가 "게임 시작 시 정확히 1회" 실행됨을 보장하는 상위 구조(`InitCtrig`, 0xFFFD/0x1FFF4 라벨 체인)는 이 그룹 범위에서 추적하지 않았다.

---

<!-- functions: CreateSVA32, CreateSVA32X, CreateSVA1, SaveiStrArr, SaveiStrptr, SaveiStrFile, SaveiStrArrX, SaveiStrptrX, SaveiStrFileX, DwSaveiStrArr, DwSaveiStrptr, DwSaveiStrFile, DwSaveiStrArrX, DwSaveiStrptrX, DwSaveiStrFileX, SVA1, TSVA1Mem, CSVA1, SetCSVA1, TCSVA1, TSetCSVA1, TTCSVA1, _TCSVA1, _TTCSVA1, CreateSV54, f_GetFileVArrptrN, f_GetFileSVArrptrN, f_GetFileArrptr -->

## 2. SVA1 · SVA32 · SV54 변수 타입과 저장 함수

### 2.0 이 그룹의 공통 메커니즘

#### 2.0.1 iStr 배열(iStrArr)의 실제 모양 — "바이트 배열"이다

이 그룹의 모든 `Create*`/`Save*` 함수가 받는 `iStrArr` 는 **글자당 4바이트가 연속으로 들어 있는 Lua 바이트 배열**이다(dword 배열이 아님). `str_to_icp949` / `str_to_iutf8` (`CtrigAsm v5.5.lua:45861~45936`, `45774~45860`)이 만들어 내는 배열이며, 한 글자는 다음 4바이트다.

```
글자 1개 = 4바이트 (배열 순서 = 메모리 little-endian 순서)
  [C][_][_][X]   1바이트 글자 (ASCII, 0x20~0x7F, 0x9~0xD, 0x12~0x13)  → 0xD,0xD,0xD,X
  [C][_][X][X]   2바이트 글자 (cp949 한글 / utf8 2바이트)              → 0xD,0xD,X1,X2
  [C][X][X][X]   3바이트 글자 (utf8 한글 등, str_to_iutf8 전용)        → 0xD,X1,X2,X3
  C = 컬러코드 바이트. 직전에 컬러코드가 없으면 0xD(빈칸) 가 들어간다.
  _ = 0xD (자리는 차지하되 아무것도 안 그리는 공백)
```

```lua
-- CtrigAsm v5.5.lua:45809~45815 (str_to_iutf8, 1바이트 글자 분기)
elseif (v>=0x20 and v<=0x7F) or (v>=0x9 and v<=0xD) or (v>=0x12 and v<=0x13) then -- 1byte
    if prt == 0 then table.insert(iret,0xD) end   -- 컬러코드가 앞에 없으면 C 자리에 0xD
    table.insert(iret,0xD); table.insert(iret,0xD); table.insert(iret,v)
```

컬러코드(0x01~0x08, 0x0E~0x11, 0x14~0x1F)는 다음 글자의 C 바이트로 흡수된다(연속 컬러코드는 마지막 것만 남음, `45845~45852`). 문자열 안의 `\0` 을 만나면 `0,0,0,(0)` 을 넣고 중단한다(`45798~45806`). 리턴 `Size` 는 글자 수(= `#iret/4`, Null 종료면 `(#iret-1)/4`).

트리거 생성기는 이 4바이트를 `Arr[n]+Arr[n+1]*256+Arr[n+2]*65536+Arr[n+3]*16777216` 로 묶어 **dword 하나** 로 만든다(`1514`, `1544`, `1574`). 따라서 dword 의 최하위 바이트(0x000000FF)가 컬러코드, 상위 3바이트(0xFFFFFF00)가 글자다. CSVA1 등에서 마스크 `0xFF` 는 컬러코드, `0xFF000000` 은 글자의 마지막 바이트를 뜻한다(예제 26-32 의 `0x31000000,0xFF000000` = ASCII '1').

#### 2.0.2 인코딩 분기표 (TEP30Flag / tblflag) — 특별 과제 (f)

`TEP30Flag` 는 소스 1~6줄에서 결정된다: 호스트 전역 `__mapdirsetting` 이 있으면(TEP 3.0) 1, 없으면(TEP 2.x) 0.

```lua
-- CtrigAsm v5.5.lua:1~6
TEP30Flag = 0
for k, v in pairs(_G) do
if k == "__mapdirsetting" then TEP30Flag = 1 end
end
```

| 함수 계열 | TEP30Flag == 1 (TEP 3.0, 소스 .lua 가 UTF-8) | TEP30Flag == 0 (TEP 2.x, 소스 .lua 가 cp949) |
|---|---|---|
| SaveiStrArr / SaveiStrptr / SaveiStrFile | tblflag==1 → `str_to_icp949(String,1)` (내부에서 `__encode_cp949` 로 UTF-8→cp949 변환 후 icp949). 그 외 → `str_to_iutf8(String,1)` (UTF-8 바이트 그대로 iutf8) | 항상 `str_to_icp949(String,1)` (tblflag 무시. 소스 바이트가 이미 cp949) |
| SaveiStrArrX / SaveiStrptrX / SaveiStrFileX | `str_to_iutf8` : 바이트 그대로 | `str_to_iutf8` : `cp949_to_utf8(String)` (Print_utf8X.lua:43) 로 변환 후 iutf8 |
| CreateSV54 | `str_to_iutf8(String,1)` 고정 | `str_to_iutf8(String,1)` 고정 (내부에서 cp949→utf8) |
| DwSaveiStrArr / DwSaveiStrptr / DwSaveiStrFile | `string.byte` 로 **원문 바이트 그대로**(인코딩 변환 없음, iStr 변환도 없음) | 동일(원문 cp949 바이트 그대로) |
| DwSaveiStrArrX / DwSaveiStrptrX / DwSaveiStrFileX | 원문 바이트 그대로 | `cp949_to_utf8(String)` 변환 후 마지막 원소 제거 |

```lua
-- CtrigAsm v5.5.lua:46083~46091 (SaveiStrArr, 다른 non-X 함수도 동일 블록)
if TEP30Flag == 1 then
    if tblflag == 1 then Arr, Size = str_to_icp949(String,1)
    else                 Arr, Size = str_to_iutf8(String,1) end
else
    Arr, Size = str_to_icp949(String,1)
end
```

즉 TEP 3.0 에서 `tblflag` 를 비우면 **non-X 함수도 iutf8 로 저장된다**. cp949(icp949) 로 저장하려면 `tblflag=1` 을 명시해야 한다. (가이드북 v5.4 에는 `tblflag` 인자가 없다 — v5.5 추가.)

#### 2.0.3 변수 트리거 한 개 = 0x970 바이트 = 604 dword — 특별 과제 (b)

스타크래프트 메모리상의 트리거 노드 크기는 0x970(2416) 바이트다. CtrigAsm 은 이것을 두 단위로 쓴다.

- **바이트 주소 단위**: `0x970`. `SetCtrigX`/`SetCtrig1X`/`CtrigX` 의 `Next` 인자가 2 이상이면 `Address = Address + 0x970*Next` 로 "라벨 트리거에서 Next 개 뒤 트리거의 같은 오프셋"을 가리킨다(`1875~1877`, `1996~1998`, `1798~1800`).
- **EPD(dword) 단위**: `604 = 0x970/4`. 액션의 player 칸(0x158)에 들어가는 값은 EPD 이므로 "트리거 하나 뒤로" 는 `+604` 다.

```lua
-- CtrigAsm v5.5.lua:47461 (CA__InputSVA1 의 CWhileEnd) : 같은 이동을 두 단위로 표현
SetCtrig1X("X",FuncAlloc,0x158,0,Add,604*SourceDistance),     -- player(EPD) 칸은 604
SetCtrig1X("X",FuncAlloc,0x15C,1,Add,0x970*SourceDistance),   -- 주소(바이트) 칸은 0x970
```

트리거 내부 오프셋(메모리 기준, TRIG 파일 형식보다 앞에 prev/next 포인터 8바이트가 있다):

```
0x000 prev ptr        0x004 next ptr
0x008 cond[0] (20B)   ... 0x1C cond[1] ... (16개 × 0x14)      → 0x148 까지
0x148 act[0] (32B)    0x168 act[1]  0x188 act[2] ... (64개 × 0x20) → 0x948 까지
0x948 trigger flags (0x4 = Preserved)   0x94C players[27]   0x968~0x970 pad
액션 내부: +0x00 loc(=eudx 마스크) +0x04 string(=라벨 Index) +0x08 wav(=Rflag) +0x0C time
          +0x10 player(EPD) +0x14 number(값) +0x18 unit(2) +0x1A type +0x1B modifier
          +0x1C flags(0x2=Disabled) +0x1E "SC"(eudx 마스크 액션 표식)
→ act[0] 의 player = 0x158, number(값) = 0x15C, type/modifier = 0x162/0x163, flags = 0x164
```

`Label(i)` 는 `Condition(0,0,i,0,Exactly,0xFE,0,0x2)` — 즉 **Disabled 플래그(0x2)가 켜진 condtype 0xFE 조건**으로, amount 칸(0x10)에 라벨 번호를 넣는다(`1745~1755`). 항상 참인 더미 조건이며 STRCtrig 가 라벨 번호로 트리거 주소를 찾는 데 쓴다. `Label(0)`/`Label()` 은 이름 없는 트리거다.

#### 2.0.4 SVA1 한 글자 트리거 vs 일반 V 트리거 레이아웃 — 특별 과제 (a)

**일반 변수 V (`CVariable`, `5853~5866`)**

```lua
actions = {
    SetDeathsX(0,SetTo,0,0,0xFFFFFFFF);            -- act[0] "Full Variable" (활성)
    Disabled(SetDeathsX(0,SetTo,0,0,0xFFFFFFFF));  -- act[1] "Recover Next" (비활성)
}, flag = {Preserved}
```

**SVA1 한 글자 트리거 (생성기 `1566~1606`)**

```lua
-- CtrigAsm v5.5.lua:1574, 1583~1595
table.insert(Box1,Disabled(SetDeathsX(CurrentPlayer,SetTo,<글자dword>,0,0xFFFFFFFF)))
Trigger {
    players = {CreateVarPArr[k][2]},
    conditions = { Label(i); },                       -- 첫 글자만 Label(i), 2번째부터 Label()
    actions = {
        Box1,                                         -- act[0]
        FSetMemoryX(0x6509B0,Add,1,0xFFFFFFFF);       -- act[1] CP += 1
        SetCtrig1X("X","X",0x164,0,SetTo,0x2,0x2);    -- act[2] 자기 자신의 0x164 에 0x2 를 마스크 0x2 로 SetTo
    },
    flag = {Preserved}
}
```

두 트리거를 바이트 단위로 나란히 놓으면(값은 `f_GetFileVArrptrN` 이 파일에 쓰는 실제 바이트 `77161~77190` 과 생성기 `1574~1595` 로 확정):

```
오프셋   일반 V 트리거 (CVariable)                     SVA1 한 글자 트리거
------  --------------------------------------------  ------------------------------------------------
0x008   Label(i): amount=i, cmp=0x0A, type=0xFE, fl=0x02   동일 (2번째 글자부터는 amount=0 = Label())
0x148   act0 mask   = 0xFFFFFFFF                      act0 mask   = 0xFFFFFFFF
0x158   act0 player = 0        (호출자가 대상 EPD 로 덮어씀)   act0 player = 13 (CurrentPlayer) → 대상 = [CP]
0x15C   act0 number = 0        (= 변수 값)             act0 number = 글자 dword  (= 글자 값)
0x162   act0 type=0x2D SetDeaths, 0x163 mod=0x07 SetTo  동일
0x164   act0 flags  = 0x14     (활성)                   act0 flags  = 0x16  (0x14 + 0x02 Disabled) ★
0x166   "SC"                                          "SC"
0x168   act1 mask = 0xFFFFFFFF                        act1 mask = 0xFFFFFFFF
0x178   act1 player = 0                                act1 player = 0x31993 = EPD(0x6509B0)  (CP 값 주소)
0x17C   act1 number = 0                                act1 number = 1
0x182   type 0x2D, 0x183 mod 0x07 SetTo                type 0x2D, 0x183 mod 0x08 Add
0x184   act1 flags = 0x16 (Disabled, "Recover Next")   act1 flags = 0x14 (활성)  → 실행될 때마다 CP += 1
0x188   act2 = 없음(0)                                 act2 loc(mask)=0x2, 0x18C string(Index)=0
0x190                                                  act2 wav(Rflag)=0x20 (Index 없음 = "자기 자신")
0x198                                                  act2 player = 0x59 (= 0x164/4, 자기 트리거의 flags dword 의 EPD 상대값)
0x19C                                                  act2 number = 0x2, 0x1A2 type=0x05(PauseGame 자리 = STRCtrig 가 치환하는 가짜 액션), 0x1A3 mod=SetTo
0x948   flags = 0x4 Preserved                          동일
```

`SetCtrig1X("X","X",0x164,0,SetTo,0x2,0x2)` 의 인코딩 근거:

```lua
-- CtrigAsm v5.5.lua:2020~2027
local ExSetCtrig1X = Action(Mask,Index1,Rflag1,0,Address1/4,Value,0,0x5,Type,0x14+Mflag2) -- (PauseGame = 0x5)
-- Mask=0x2 → loc, Index1=nil→0 & Cflag1=32 → wav=0x20("자기 자신"), Address1/4 = 0x164/4 = 0x59 → player, Value=0x2 → number
```

**왜 act[0] 이 Disabled(0x16) 인가, 왜 act[1] 에 `FSetMemoryX(0x6509B0,Add,1)` 이 있는가.**
SVA1 트리거는 "글자 하나를 [CP] 위치에 쓰는 실행 가능한 액션" 이다. 소비자(`CA__InputSVA1`, `47313~47463`)는 한 글자를 옮길 때마다 다음을 한다.

1. 작업 트리거의 act[0] `SetDeathsX(0,SetTo,0,0,0x2) -- Enable` 의 player 칸(0x158)에 **글자 트리거의 0x164 의 EPD** (+Index×604)를 넣어 두고(`47322`, `47326`), CP 가 Start~End 범위일 때만(`FMemory(0x6509B0,AtLeast/AtMost)` 조건, `47441~47442`) 그 글자의 Disabled 비트를 0 으로 지운다 → **쓰기 게이트 열림**.
2. 다음 트리거가 자기 next 포인터를 글자 트리거 주소로 바꾸고(`SetCtrig1X("X","X",0x4,0,SetTo,0) -- "X"->VA`, 값은 `47323` 에서 미리 글자 트리거 주소(+Index×0x970)로 세팅), 글자 트리거의 next 포인터를 "자기 다음 트리거"로 바꾼다(`SetCtrig2X(0,SetTo,"X","X",0,0,1) -- VA->"X"+1`) → 글자 트리거 한 개를 서브루틴처럼 호출.
3. 글자 트리거가 실행된다: act[0] 이 (게이트가 열렸다면) 글자 dword 를 `Deaths[CP]` 즉 CP 가 가리키는 dword 에 SetTo 로 쓴다 → act[1] 이 **CP 를 1 올려** 다음 글자가 다음 dword 로 가게 한다 → act[2] 가 **자기 0x164 에 0x2 를 다시 켜** 게이트를 닫는다.
4. `CWhileEnd` 가 소스 포인터를 `SourceDistance` 만큼(604/0x970 단위) 이동시키며 반복(`47461`).

따라서 Disabled 비트는 "범위 밖 글자는 실행되더라도 쓰지 않게 하는 per-글자 쓰기 게이트" 이고, act[2] 의 자기-재비활성화는 "호출이 끝나면 항상 닫힌 상태로 되돌려 다음 호출이 깨끗하게 시작하도록" 하는 장치다. CP+1 은 "글자 트리거 여러 개를 연속 호출하면 연속 dword 에 글자가 이어 써지는" 테이프 동작을 만든다. 일반 V 의 act[1] "Recover Next" 는 CallLabel1 (`6120~6128`) 이 0x178/0x17C/0x184 를 세팅해 호출 후 next 포인터를 복원하는 용도로, SVA1 에는 없다(대신 CP+1 이 그 자리에 있다).

**SVA1 은 "V 와 같은 꼴" 이지만 값 칸만 같다.** 리턴 `{P, Index, 0, "V", 0, Size}` 이므로 `CVar`/`SetCVar` 같은 V 용 함수에 넣으면 컴파일은 되지만, act[0] 의 player 가 13 이고 Disabled 라서 V 로서의 읽기/쓰기 동작(CallLabel 로 값을 더하기 등)이 성립하지 않는다. 가이드 6412 의 "SVA1함수 사용시 반드시 값 입력 용도로만 사용해야함 (출력X)" 가 이 뜻이다. 0x15C 를 직접 다루는 `CSVA1`/`SetCSVA1`/`CA__Input*` 계열만 써야 한다.

#### 2.0.5 SVA32 / SVA32X 트리거당 32글자 레이아웃 — 특별 과제 (c)

```lua
-- CtrigAsm v5.5.lua:1506~1535 (SVA32)
while true do
    if n <= 128 then   -- 첫 32글자(128바이트) → Box1
        table.insert(Box1,SetDeaths(CurrentPlayer,SetTo,Arr[n]+Arr[n+1]*256+Arr[n+2]*65536+Arr[n+3]*16777216,0))
        table.insert(Box1,SetMemory(0x6509B0,Add,1))
    else               -- 나머지 전부 → Box2
        table.insert(Box2,SetDeaths(CurrentPlayer,SetTo,...,0))
        table.insert(Box2,SetMemory(0x6509B0,Add,1))
    end
    n = n+4
    if n > #Arr then break end
end
Trigger { players={P}, conditions={Label(i)}, actions={Box1}, flag={Preserved} }
for m = 2, Size do DoActions2X(CreateVarPArr[k][2],Box2) end
```

- 글자 하나 = `SetDeaths(CurrentPlayer,SetTo,글자dword,0)` + `SetMemory(0x6509B0,Add,1)` 두 액션. 32글자 = 64액션 = 트리거 하나가 꽉 찬다.
- 첫 트리거는 `Label(i)`, 이후 트리거는 `DoActions2X` 가 64액션씩 잘라 `Label(0)` 트리거로 만든다(`6985~7030`).
- **모든 액션이 활성**(Disabled 없음). SVA32 트리거를 `CallLabelAlways*` 로 호출하면 32글자가 `[CP], [CP+1], ...` 에 연속으로 써지고 CP 는 32 전진한다. `CSPrint` 가 iStr V 트리거를 먼저 호출해 CP := iStr 의 EPD 로 만든 뒤 `CallLabelAlwaysN(iStrid[1], SVA32Arr...)` 로 트리거들을 줄줄이 호출하는 것이 그 사용례다(`57214~57243`).
- **SVA32X 의 유일한 차이는 `SetMemory(0x6509B0,Add,8)`** (`1544~1547`). 글자 하나를 쓰고 CP 를 8 dword(32바이트) 전진시킨다. 이것은 CDPrint 계열의 "글자당 8 dword" 디스플레이 구조(가이드 7335 `CB[2] = 54*8`, 예제 26-27 의 `29*8`, `39*8`)에 맞추기 위한 것으로, SVA32X 는 `CA__OverWrite` (CDPrint 출력용) 가 CP := Index 로 맞춘 뒤 호출한다(`49307~49310`, `49384`). 리턴 테이블의 타입 문자열은 둘 다 `"SVA32"` 이므로 소비자는 구별하지 않는다 — **SVA32 를 CDPrint 에, SVA32X 를 CSPrint 에 넣으면 간격이 틀려 글자가 깨진다.**
- 파일 저장판(`f_GetFileSVArrptrN`)은 트리거를 바이트로 직접 쓴다: 글자당 64바이트 = `[mask FFFFFFFF][string/wav/time 0][player 0x0D=CurrentPlayer][글자dword][unit 0][0x2D SetDeaths][0x07 SetTo][flags 0x14]["SC"]` + `[mask FFFFFFFF][0×12][player 0x31993=EPD(0x6509B0)][number 1 또는 8][unit 0][0x2D][0x08 Add][0x14]["SC"]` (`77540~77541` `__SVArrSTR[4]`=Add 1, `[5]`=Add 8). 마지막 트리거의 빈 글자 칸은 Disabled(0x16) 액션으로 채운다(`__SVArrSTR[6]`, `77546~77552`).

**소스상 사실(과잉 생성)**: 맵 내 생성기(`1531~1533`) 는 `Box2` 에 33번째 이후 **모든** 글자를 넣고 `for m = 2, Size` 루프에서 매번 `DoActions2X(P,Box2)` 전체를 다시 방출한다. Size(트리거 수) ≥ 3 이면 같은 트리거 묶음이 (Size-1) 번 반복 생성되어 총 `1 + (Size-1)×ceil((글자수-32)/32)` 개가 나온다(예: 96글자 → 1+2×2 = 5개, 320글자 → 1+9×9 = 82개). 소비자는 첫 Size 개만 `SVA32[3]+i` 로 참조하므로 내용은 맞지만 트리거 공간이 낭비된다. 파일 저장판(`SaveiStrptr`, SVA32=1)에는 이 문제가 없다. 긴 상수 문자열은 파일 저장판을 쓰는 편이 낫다.

#### 2.0.6 세 가지 저장 경로 — 특별 과제 (d)

| 경로 | 함수 | 트리거가 놓이는 곳 | 리턴 [2] Index | 리턴 [3] Next | 필요 조건 |
|---|---|---|---|---|---|
| Arr (맵 내) | SaveiStrArr / SaveiStrArrX / DwSaveiStrArr(X) → CreateSVA1/CreateSVA32(X) | `CreateVarPArr` 에 예약만 하고, 컴파일 종료 시점의 소비 루프(`1268~`) 가 맵 TRIG 에 실제 트리거를 생성 | `CreateVarXAlloc` (0x18000 부터 1씩) = 첫 글자 트리거의 Label 번호 | 0 | 없음 |
| ptr (파일) | SaveiStrptr / SaveiStrptrX / DwSaveiStrptr(X) → f_GetFileVArrptrN / f_GetFileSVArrptrN | Lua 가 `FileDirectory.."temp\\SCTRIGASMFILE%04X"` 에 0x970 바이트 단위 트리거 이미지를 씀. 맵에는 `players={P12 또는 P9, PlayerID}`, `Label(FuncAlloc)`, `Never()` 인 **표식 트리거** 하나만 생성되고, TEP 의 STRCtrig.h 가 표식 트리거 뒤에 파일 내용을 그대로 이어붙여 `TRIGP1~8.chk` 로 만든다 | `FuncAlloc-1` = 표식 트리거의 Label | **1** (표식 트리거의 "다음" 트리거가 첫 글자) | `STRCTRIGASM==1` (StartCtrig 의 STRCTRIG 인자), 파일 쓰기 가능 경로 |
| File (원시 파일) | SaveiStrFile / SaveiStrFileX / DwSaveiStrFile(X) → f_GetFileArrptr | iStr 바이트를 **트리거 형식 없이** 파일에 쓰고(`SaveFileArr`, `76930`), P9 표식 트리거 뒤에 0x970 단위로 패딩되어 붙는다 | `FuncAlloc-1` | 0x970 (표식 트리거 기준 데이터 시작 바이트 오프셋) | 위와 동일 |

파일 경로는 `SetDeathsX(Repeat,SetTo,Value,0,Mask)` 액션에 8바이트씩(Mask = 앞 4글자, Value = 뒤 4글자) 실려 표식 트리거에 들어간다(`77015~77026`). TEP 쪽(`TEP3.0_Headless_Compiler/TrigEditPlus/STRCtrig.h:157~166`)은 `effplayer[8]`(P9)→f_GetFileptr, `effplayer[11]`(P12)→f_GetTRIGptr 로 구분하고, `act[l].locid/target` 에서 경로를 복원해 파일을 읽어 표식 트리거 바로 뒤에 `0x970` 단위로 붙인다(`STRCtrig.h:196~235`). 이 "바로 뒤에 연속" 이 `Next=1`, `+0x970×n` 주소 계산이 성립하는 근거다.

Next 의 의미: `SetCtrigX`/`CtrigX` 에서 `Next==1` 은 `Nflag=16` (STRCtrig 가 라벨 트리거의 next 포인터를 한 번 따라감), `Next>=2` 는 `Address + 0x970*Next` (라벨 트리거 주소 + n 트리거) 다(`1875~1881`). 파일 저장판 SVA1 의 글자 n(0-based) 은 `Next = n + 1` 이 되어 두 방식 모두 같은 트리거를 가리킨다.

#### 2.0.7 Dw 계열이란 — 특별 과제 (e)

가이드북 미수록(v5.5 추가). `Dw*` 는 **iStr 변환을 하지 않고 문자열의 원시 바이트 4개를 dword 하나로** 저장하는 변형이다.

```lua
-- CtrigAsm v5.5.lua:46180~46203 (DwSaveiStrArr)
Arr = {}
Size = math.ceil(#String/4)                    -- dword 개수 = 바이트 수 / 4 (올림)
for i = 1, #String do table.insert(Arr,string.byte(String,i)) end
if #String%4 == 3 then table.insert(Arr,0xD)   -- 4의 배수가 되도록 0xD 로 패딩
elseif #String%4 == 2 then ... 0xD,0xD  elseif #String%4 == 1 then ... 0xD,0xD,0xD end
if SVA32 == 1 then ret = CreateSVA32(Arr,Size,PlayerID) else ret = CreateSVA1(Arr,Size,PlayerID) end
```

- 컬러코드 바이트 자리가 없다. "글자" 가 아니라 "바이트 4개" 단위다. `"ABCDEFGH"` → 2 dword `0x44434241`, `0x48474645`.
- 용도는 `CA__DwSetValue`/`CA__DwItoName`(`48041`, `52408`) 처럼 dword 단위로 직접 값을 박는 Dw 계열 출력 함수의 원본 데이터다(그 함수들은 다른 그룹 담당).
- non-X 판은 인코딩 변환을 전혀 하지 않는다(TEP 3.0 이면 UTF-8 바이트가, TEP 2.x 면 cp949 바이트가 그대로 들어감). X 판은 TEP 2.x 에서만 `cp949_to_utf8` 변환을 한다.

#### 2.0.8 SVA1 인덱스 단위 규칙 — 특별 과제 (b) 계속

`SVA1(SVA1,Index)` (`46452~46461`) 는 Index 의 타입에 따라 다른 테이블을 만든다.

```lua
function SVA1(SVA1,Index)
    if type(Index) == "number" then ret = {SVA1[1],SVA1[2],SVA1[3],"V",Index,SVA1[6]}    -- 상수: 타입 "V",  [5]=글자 인덱스
    else                            ret = {SVA1[1],SVA1[2],SVA1[3],"VA",Index,SVA1[6]}   -- V:    타입 "VA", [5]=V 테이블
    end
    return ret
end
```

- **상수 Index → 단위는 "글자(트리거) 번호" (0-based)**. 소비자가 알아서 ×604/×0x970 을 붙인다. 예: `CSVA1` 은 `CtrigX(P,Index,0x15C, SVA1[5]+SVA1[3], ...)` — Next 인자로 넘겨 `+0x970×n`. `CA__InputVA` 는 `SetCtrig1X("X",FuncAlloc,0x158,0,Add,SVA1[5]*604)` (`46731`).
- **V Index → 단위는 "604 의 배수"**. V 의 런타임 값은 액션의 **player(EPD) 칸에 그대로 더해지기** 때문이다. TCSVA1 의 VA 분기(`8756~8765`)가 전형이다: 조건 트리거의 0xC(cond[0].player) 에 SVA1 0x15C 의 EPD 를 넣고, V 트리거의 act[0] 을 `Add` 모드로 바꿔 대상 = 그 0xC 칸으로 호출한다 → 0xC += V. 한 글자 = 한 트리거 = 604 dword 이므로 V 에는 `글자번호×604` 가 들어 있어야 한다. 예제 26-32: `CMul(P1,X,_Read(0x57F0F0),604)`, `_Mul(_Read(0x57F120),604)`.

```lua
-- CtrigAsm v5.5.lua:8756~8762 (TCSVA1, SVA1[4]=="VA")
local X = {CallLabelAlways(SVA1[5][1],SVA1[5][2],SVA1[5][3]),                          -- V 트리거 호출
        SetCtrig1X(SVA1[5][1],SVA1[5][2],0x148,SVA1[5][3],SetTo,0xFFFFFFFF),            -- V act0 마스크 = 전체
        SetCtrig1X(SVA1[5][1],SVA1[5][2],0x160,SVA1[5][3],SetTo,Add*16777216,0xFF000000), -- V act0 modifier = Add
        SetCtrigX(SVA1[5][1],SVA1[5][2],0x158,SVA1[5][3],SetTo,"X","X",0xC,1,0),         -- V act0 대상 = 이 조건트리거의 0xC (EPD)
        SetCtrigX("X","X",0xC,0,SetTo,SVA1[1],SVA1[2],0x15C,1,SVA1[3]+SVA1[5][5])}       -- 0xC := EPD(SVA1 글자0 의 0x15C) (+Deviation)
```

#### 2.0.9 이 그룹이 건드리는 전역

| 전역 | 역할 |
|---|---|
| `CreateVarXAlloc` (초기 0x18000-1, `197`) / `CreateMaxVAlloc` (0x19FFF, `198`) | Create* 계열 변수 라벨 번호 할당기. 넘치면 `CreateVariable_IndexAllocation_Overflow()` (미정의 함수 호출로 고의 에러) |
| `CreateVarPArr` | 컴파일 종료 시 소비되는 변수 트리거 예약 목록. 항목 `{["STRx"]=..., 타입문자열, PlayerID, iStrArr, Size}` |
| `__STRxSwitchX` | TEP 3.0 STRx 구간 상태를 예약 항목에 기록(TEP30Flag==1 이면 `__STRxSwitch` 값, 아니면 -1). 소비 루프가 `STRx==1` 항목 앞에서 `STRxStart()` 를 다시 켠다(`1272~1275`) |
| `FuncAlloc` | 파일 표식 트리거와 SV54 트리거의 Label 번호 할당기 |
| `FileNameIndex` (`76903`), `FileDirectory` (`76695`, `StartCtrig` 의 AbsolutePath 로 세팅) | 임시 파일 `temp\SCTRIGASMFILE%04X` 이름/경로. 0x10000 개 넘으면 `FILEIndex_Overflow()` |
| `STRCTRIGASM` (`223`, `StartCtrig:530~532`) | 0 이면 ptr/File 계열이 `Need_STRCTRIGASM()` 으로 컴파일 실패 |
| `VarXAlloc`/`MAXVAlloc`, `PushTrigArr`/`PushTrigStack`, `STPushTrigArr`, `PushCondArr`/`CondLineArr`, `PushActArr`/`ActLineArr`, `TTPushTrigArr`/`TTPushCondArr`/`TTFCodeArr`/`TTModeArr`, `FlagAlloc` | T/TT 계열(TCSVA1 등)이 CTrigger 조립기에 넘기는 push 스택 |
| `CRet[1]` | TSVA1Mem 의 OffsetFlag=1 분기가 스크래치 변수로 사용 |

---

### 2.1 CreateSVA32
**시그니처**: `CreateSVA32(iStrArr,Size,PlayerID)`  (소스: `CtrigAsm v5.5.lua:46014~46036`, 가이드: `Guide Book.txt:6317`)
**한 줄 요약**: iStr 바이트 배열을 "트리거당 32글자" SVA32 상수 변수로 예약하고 SVA32 변수 테이블을 리턴한다 (CSPrint 용).
**사용 위치**: 컴파일 타임 Lua 함수. 변수 선언 위치(가이드 관례상 최상단 `CJump(0)` 블록 안)에서 호출.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| iStrArr | Lua 바이트 배열 (글자당 4바이트, `GetiStrArr`/`str_to_icp949`/`str_to_iutf8` 출력) | 없음(필수) | 저장할 iStr. 길이가 4의 배수여야 dword 로 묶인다 |
| Size | 정수(글자 수) | 없음(필수. nil 이면 `math.ceil(nil/32)` 에러) | 글자 수. 내부에서 `ceil(Size/32)` = 트리거 수로 바뀜 |
| PlayerID | 플레이어 상수(P1..P8, AllPlayers, Force 등) | `AllPlayers` | 생성 트리거의 체크 플레이어. 숫자면 리턴 [1] 에도 들어감 |

**리턴값**: `{"X" 또는 PlayerID, CreateVarXAlloc, 0, "SVA32", ceil(Size/32), Size}`
[1] 플레이어(숫자가 아니면 "X"), [2] 첫 트리거 Label 번호, [3] Next=0, [4] 타입 "SVA32", [5] 트리거 수, [6] 글자 수.

**작동 메커니즘**
1. 컴파일 타임: `TEP30Flag==1` 이면 `__STRxSwitchX = __STRxSwitch`, 아니면 -1 (`46015~46019`). `CreateVarXAlloc` 를 1 올리고 `CreateMaxVAlloc`(0x19FFF) 초과 시 `CreateVariable_IndexAllocation_Overflow()` 로 에러. PlayerID nil → AllPlayers. `Size` 를 `ceil(Size/32)` 로 바꾸고 `CreateVarPArr` 에 `{["STRx"]=__STRxSwitchX,"SVA32",PlayerID,iStrArr,Size}` 를 추가(`46029`).
2. 생성되는 트리거: 이 시점엔 없다. 컴파일 종료 시 소비 루프(`1268~`)의 `"SVA32"` 분기(`1506~1535`)가 2.0.5 의 레이아웃으로 생성한다 — 첫 트리거 `Label(i)` + 32글자×(SetDeaths(CP,SetTo,글자)+SetMemory(0x6509B0,Add,1)) = 64액션, 이후 `DoActions2X` 가 64액션씩 `Label(0)` 트리거로. Preserved.
3. 런타임: 트리거 자체는 실행되지 않고 데이터로 있다가 `CSPrint`(`57238~57243`) 등이 CP 를 목적지 iStr 의 EPD 로 맞춘 뒤 `CallLabelAlwaysN` 으로 순서대로 호출하면 32글자씩 `[CP]` 에 이어 써진다.
4. 공용 자원: `CreateVarXAlloc`, `CreateVarPArr`, `__STRxSwitchX`.

**제약·주의사항**
- iStrArr 의 마지막 dword 조각이 4바이트 미만이면 `Arr[n+1]` 이 nil 이라 생성기에서 산술 에러(`1514`). `GetiStrArr`/`SaveiStrArr` 출력은 항상 4의 배수.
- Size ≥ 3 트리거 분량(65글자 이상)이면 2.0.5 의 과잉 생성으로 트리거가 `1+(Size-1)×(Size-1)` 개 나온다. 긴 문자열은 `SaveiStrptr(...,1)` 권장.
- 리턴 타입 문자열이 `"SVA32"` 라서 `CSPrint`(`57197`)/`CA__OverWrite`(`49294`) 의 타입 검사를 통과한다. 하지만 CP+1 간격이므로 **CSPrint 용**이다(가이드 6315). CDPrint/CA__OverWrite 에는 `CreateSVA32X` 를 쓸 것.
- 가이드 vs 소스: 가이드는 "CSPrint 전용" 만 말하고 SVA32X 와의 CP 간격 차이는 언급하지 않는다. 소스가 정답.

**예제**
```lua
-- 예제 26-2 (Guide Book.txt:16163~) 발췌
CJump(AllPlayers,0)
StrA1, StrS1 = GetiStrArr(1,"\x13\x1B테\x19스\x1D트\x02☆")  -- cp949 iStr 배열과 글자 수
Str1 = CreateSVA32(StrA1,StrS1,P1)                          -- SVA32 예약, 리턴 {P1,0x18000+k,0,"SVA32",1,StrS1}
CJumpEnd(AllPlayers,0)
iStr1 = GetiStrId(P1,MakeiStrVoid(20))                      -- 출력용 iStr 공간
CSPrint(iStr1,Str1,P1,0,P1,{MemoryX(0x57F0F0,Exactly,1,1)},nil,nil,1)  -- Str1 을 iStr1 에 복사해 출력
```

**관련 함수**: CreateSVA32X(CP+8 판), SaveiStrArr(문자열→iStr→CreateSVA32 래퍼), SaveiStrptr(파일판), CSPrint/CA__OverWrite(소비자).

---

### 2.2 CreateSVA32X
**시그니처**: `CreateSVA32X(iStrArr,Size,PlayerID)`  (소스: `CtrigAsm v5.5.lua:46037~46059`, 가이드: `Guide Book.txt:6951`)
**한 줄 요약**: CreateSVA32 와 같되 글자마다 CP 를 8 전진시키는 트리거를 만든다 (CDPrint 의 CA__OverWrite 용, utf8 전용이라고 가이드는 말하지만 소스는 인코딩을 검사하지 않음).
**사용 위치**: 컴파일 타임 Lua 함수. 변수 선언 위치.

**인자**: CreateSVA32 와 동일 (iStrArr / Size / PlayerID, 기본 AllPlayers).

**리턴값**: `{"X" 또는 PlayerID, CreateVarXAlloc, 0, "SVA32", ceil(Size/32), Size}` — **타입 문자열이 "SVA32" 로 CreateSVA32 와 같다**(`46054`).

**작동 메커니즘**
1. 컴파일 타임: CreateSVA32 와 완전히 같고 `CreateVarPArr` 항목의 타입만 `"SVA32X"` (`46052`).
2. 생성 트리거: 소비 루프 `"SVA32X"` 분기(`1536~1565`). 글자당 `SetDeaths(CurrentPlayer,SetTo,글자dword,0)` + `SetMemory(0x6509B0,Add,8)`. 나머지(64액션 분할, Label, Preserved, 과잉 생성)는 SVA32 와 동일.
3. 런타임: 호출될 때 글자 하나를 `[CP]` 에 쓰고 CP 를 8 dword(32바이트) 전진. `CA__OverWrite`(`49307~49310`)가 `SetMemory(0x6509B0,SetTo,Index)` 로 CP 를 디스플레이 인덱스로 맞춘 뒤 `CallLabelAlwaysN(SVA32Arr...)`(`49384`) 로 호출한다.
4. 공용 자원: CreateSVA32 와 동일.

**제약·주의사항**
- 리턴 타입이 "SVA32" 라 소비자가 X 여부를 구별하지 못한다. CSPrint 에 넣으면 글자가 8칸 간격으로 흩어진다.
- "utf8 전용" 은 관례다. 소스는 iStrArr 의 인코딩을 검사하지 않는다(가이드 vs 소스).

**예제**
```lua
-- 예제 26-22 (Guide Book.txt:16976~) 의 SaveiStrArrX(...,1) 이 내부에서 CreateSVA32X 를 호출한다
CJump(AllPlayers,0)
Str1 = SaveiStrArrX(P2,"\x13\x04CAPrint \x07예제\x18-M",1)   -- SVA32=1 → CreateSVA32X
CJumpEnd(AllPlayers,0)
function TEST()
    CA__OverWrite(Str1,_GIndex(0),1,1)                        -- 디스플레이 줄 0 에 덮어쓰기 (글자당 CP+8)
end
CDPrint({0},1,{" ",0xFFFFFFFF},{P1},{1,0,0,0,1,1,0,0},"TEST",P1)
```

**관련 함수**: CreateSVA32, SaveiStrArrX/SaveiStrptrX/DwSaveiStrArrX/DwSaveiStrptrX(래퍼), CA__OverWrite(소비자).

---

### 2.3 CreateSVA1
**시그니처**: `CreateSVA1(iStrArr,Size,PlayerID)`  (소스: `CtrigAsm v5.5.lua:46060~46080`, 가이드: `Guide Book.txt:6399`)
**한 줄 요약**: iStr 바이트 배열을 "글자 하나당 트리거 하나" 인 SVA1 변수 문자열로 예약하고 V 꼴 테이블을 리턴한다 (CAPrint/CDPrint/C13Print 및 CA__ 편집 함수용).
**사용 위치**: 컴파일 타임 Lua 함수. 변수 선언 위치.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| iStrArr | Lua 바이트 배열(글자당 4바이트) | 없음(필수) | 저장할 iStr |
| Size | 정수(글자 수) | 없음(필수) | 생성할 글자 트리거 수. `#iStrArr/4` 보다 크면 생성기 `Box2[m-1]` 이 nil 이 되어 빈 액션 트리거가 됨(에러는 아님, 확인: `1597`) |
| PlayerID | 플레이어 상수 | `AllPlayers` | 체크 플레이어 |

**리턴값**: `{"X" 또는 PlayerID, CreateVarXAlloc, 0, "V", 0, Size}`
[1] 플레이어, [2] 첫 글자 트리거 Label 번호, [3] Next=0, [4] 타입 "V", [5] Deviation=0(글자 인덱스 자리), [6] 글자 수.

**작동 메커니즘**
1. 컴파일 타임: STRx 상태 기록, `CreateVarXAlloc+1`, 초과 검사, PlayerID 기본값, `CreateVarPArr` 에 `{["STRx"]=..,"SVA1",PlayerID,iStrArr,Size}` 추가(`46074`). Size 는 변환하지 않는다.
2. 생성 트리거(소비 루프 `1566~1606`): **Size 개**, 각각 2.0.4 레이아웃. 첫 글자만 `Label(i)`(i = 리턴 [2]), 2번째부터 `Label()` (=Label(0)). 각 트리거: act[0] `Disabled(SetDeathsX(CurrentPlayer,SetTo,글자dword,0,0xFFFFFFFF))`, act[1] `FSetMemoryX(0x6509B0,Add,1,0xFFFFFFFF)`, act[2] `SetCtrig1X("X","X",0x164,0,SetTo,0x2,0x2)`. Preserved. 글자 n 의 트리거는 첫 트리거 주소 + n×0x970 (EPD +n×604).
3. 런타임: 데이터로 존재. `CA__InputSVA1`(2.0.4 절차), `CA__InputVA`(`46720~46760`), `CSVA1`/`SetCSVA1`(0x15C 직접 읽기/쓰기) 등이 소비한다. 글자 dword 는 항상 `Label + n×0x970 + 0x15C` 에 있다.
4. 공용 자원: `CreateVarXAlloc`, `CreateVarPArr`.

**제약·주의사항**
- 글자 수만큼 트리거가 생기므로(1글자 = 2416바이트) 긴 문자열은 맵 크기를 크게 늘린다.
- 리턴이 V 꼴이지만 V 로 쓰면 안 된다(2.0.4 마지막 문단, 가이드 6412).
- `SVA1(ret,Index)` 로 감싸 글자 인덱스를 지정해서 CA__ 함수에 넣는다. 상수 Index 는 글자 번호, V Index 는 604 배수.

**예제**
```lua
-- 예제 26-3 (Guide Book.txt:16180~) 발췌
CJump(AllPlayers,0)
iStr1 = GetiStrId(P1,MakeiStrVoid(20))
Str1a, Str1s = GetiStrArr(1,"\x13\x04CAPrint \x1B예제\x08-3\x00")  -- iStr 배열, 글자 수
Str1 = CreateSVA1(Str1a,Str1s,P2)                                -- SVA1 예약: 글자 수만큼 트리거
CJumpEnd(AllPlayers,0)
function TEST()
    CA__InputVA(0,Str1,Str1s,nil,0,19)                            -- Str1 의 글자 0~19 를 출력 iStr 에 입력
end
CAPrint(iStr1,{P1},{1,0,0,0,1,1,0,0},"TEST",P1)
```

**관련 함수**: SaveiStrArr/SaveiStrArrX/DwSaveiStrArr(X)(문자열→CreateSVA1 래퍼), SaveiStrptr(파일판), SVA1(), CSVA1 계열, TSVA1Mem, CA__InputSVA1/CA__InputVA(소비자).

---

### 2.4 SaveiStrArr
**시그니처**: `SaveiStrArr(PlayerID,String,SVA32,tblflag)`  (소스: `CtrigAsm v5.5.lua:46081~46100`, 가이드: `Guide Book.txt:6291`)
**한 줄 요약**: 문자열을 iStr 로 변환해 맵 내 트리거(SVA1 또는 SVA32)에 상수로 박아 넣고 `변수, iStr배열, 글자수` 를 리턴한다.
**사용 위치**: 컴파일 타임 Lua 함수. 변수 선언 위치.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| PlayerID | 플레이어 상수 | Create* 로 넘어가 `AllPlayers` | 체크 플레이어 |
| String | Lua 문자열(컬러코드 포함 가능) | 없음(필수) | 저장할 문자열 |
| SVA32 | 1 또는 그 외 | nil → SVA1 | 1 이면 `CreateSVA32`, 아니면 `CreateSVA1` |
| tblflag | 1 또는 그 외 | nil → (TEP 3.0) iutf8 | **TEP30Flag==1 일 때만 의미**. 1 이면 icp949 로 저장. 가이드북 미수록(v5.5 추가) |

**리턴값**: `ret, Arr, Size` — [1] `CreateSVA32`/`CreateSVA1` 의 리턴 테이블, [2] iStr 바이트 배열, [3] 글자 수.

**작동 메커니즘**
1. 컴파일 타임: 2.0.2 표대로 `str_to_icp949(String,1)` 또는 `str_to_iutf8(String,1)` 로 `Arr, Size` 를 얻는다(flag=1 이므로 선행 `{0xD,0xD,0xD}` 패딩 없음). `SVA32==1` 이면 `CreateSVA32(Arr,Size,PlayerID)`, 아니면 `CreateSVA1(Arr,Size,PlayerID)` (`46093~46098`).
2. 생성 트리거: 2.1/2.3 참조(컴파일 종료 시 생성).
3. 런타임: 2.1/2.3 참조.
4. 공용 자원: 2.1/2.3 참조.

**제약·주의사항**
- 문자열 안의 `\0` 은 iStr 변환을 거기서 끊는다(예제 26-3 은 끝에 `\x00` 을 붙여 종료를 명시).
- 가이드 vs 소스: 가이드 시그니처 `SaveiStrArr(PlayerID,String,SVA32)` 에는 `tblflag` 가 없다. 또 가이드는 "cp949 로 변환" 을 전제하지만 TEP 3.0 에서는 기본이 iutf8 이다.
- STRCtrig 불필요(파일을 쓰지 않음).

**예제**
```lua
-- 예제 26-1 (Guide Book.txt:16149~) 발췌
CJump(AllPlayers,0)
CJumpEnd(AllPlayers,0)
iStr1 = GetiStrId(P1,MakeiStrVoid(100))
Str1 = SaveiStrArr(P2,"\x13\x08테\x17스\x07트\x1F☆\n\x13\x04CSPrint \x1C예제\x0E-1\n\x13\x1BT\x19E\x1DS\x02T",1) -- SVA32 로 저장
CSPrint(iStr1,Str1,{P1,Force5},3,P1,nil,nil,nil,1)
-- 실사용 (MapSource/MSF_UE_RE/Operator.lua:158): SVA1 로 저장하고 세 리턴을 모두 받음
local OPStr, OPStra, OPStrs = SaveiStrArr(FP, MakeiStrVoid(54))
```

**관련 함수**: SaveiStrArrX(utf8 고정), SaveiStrptr(파일판), SaveiStrFile(원시 파일), DwSaveiStrArr(raw dword), CreateSVA1/CreateSVA32.

---

### 2.5 SaveiStrptr  ＃STRCtrig 필수
**시그니처**: `SaveiStrptr(PlayerID,String,SVA32,tblflag)`  (소스: `CtrigAsm v5.5.lua:46101~46123`, 가이드: `Guide Book.txt:6299`)
**한 줄 요약**: 문자열을 iStr 로 변환해 **트리거 이미지 파일**로 저장하고, 맵에는 STRCtrig 표식 트리거만 남긴다. 리턴 테이블은 Next=1 인 V/SVA32 꼴.
**사용 위치**: 컴파일 타임 Lua 함수. 가이드 관례상 "Tep 맨 위의 CJump(0) 사이" (`6311`). 소스에는 위치 검사가 없다.

**인자**: SaveiStrArr 와 동일 (PlayerID / String / SVA32 / tblflag).

**리턴값**: `ret, Arr, Size`
- SVA32==1: `{P, FuncAlloc-1, 1, "SVA32", ceil(Size/32), Size}` (`46117`)
- 그 외: `{P, FuncAlloc-1, 1, "V", 0, Size}` (`46120`)
[2] 표식 트리거 Label, **[3] Next=1** (표식 트리거의 다음 트리거가 첫 글자). P 는 `f_GetFile*ptrN` 이 PlayerID 가 숫자면 그 값, 아니면 "X".

**작동 메커니즘**
1. 컴파일 타임: `STRCTRIGASM==0` 이면 `Need_STRCTRIGASM()` 에러(`46102~46104`). 인코딩 분기(2.0.2)로 Arr/Size. SVA32==1 → `f_GetFileSVArrptrN(PlayerID,Arr,1,32,"SVA32",1)`, 아니면 `f_GetFileVArrptrN(PlayerID,Arr,1,"SVA1",1)`.
2. `f_GetFileVArrptrN` (`77154~77419`): `SaveTempFileInit()` 로 `FileDirectory.."temp"` 디렉터리를 만들고, `temp\SCTRIGASMFILE%04X`(FileNameIndex) 를 `wb` 로 연다(실패 시 `PushErrorMsg`). 글자마다 0x970 바이트 트리거 이미지를 쓴다(2.0.4 표의 SVA1 열과 동일: `__VArrSTR[1]` = 8바이트 prev/next + Label(0) 조건 + 조건 15개 0; 마스크 4바이트(ElementSize=1 이면 남은 바이트 수에 따라 `FF 00 00 00`~`FF FF FF FF`); 12바이트 0 + `0D 00 00 00`(player=CurrentPlayer); 글자 4바이트; `__VArrSTR[3]` = type 0x2D/SetTo/flags **0x16**/"SC" + act[1](EPD(0x6509B0), 1, Add, 0x14) + act[2](mask 0x2, Rflag 0x20, player 0x59, value 0x2, type 0x05, SetTo) + 0x7A0 바이트 0 + flags `04 00 00 00`; 플레이어 바이트 8개(`PlayerConvert2`); 0x1C 바이트 0). 파일을 닫고 `f_GetTRIGptrN(PlayerID,FileName,1,1)` 호출 → `players={P12,PlayerID}`, `Label(FuncAlloc)`, `Never()`, 액션 = 파일 경로를 8바이트씩 담은 `SetDeathsX(1,SetTo,Value,0,Mask)` 들인 표식 트리거 1개 생성(`77067~77120`), `FuncAlloc+1`, `FileNameIndex+1`. 리턴 `{"X"/P, FuncAlloc-1, 1, "V", 0, TCount}`.
3. `f_GetFileSVArrptrN` (`77517~77720`): 같은 방식으로 트리거당 32글자(글자당 64바이트, 2.0.5) 이미지를 쓰고 `f_GetFileptrN` → `players={P9,PlayerID}` 표식 트리거. 리턴 `{"X"/P, FuncAlloc-1, 1, "SA", 32, TCount}` 를 SaveiStrptr 가 `{.., "SVA32", ceil(Size/32), Size}` 로 바꿔 리턴.
4. 맵 빌드 시 TEP 의 STRCtrig.h 가 P12/P9 표식을 보고 파일을 읽어 표식 트리거 바로 뒤에 붙인다(2.0.6). 런타임 소비는 Arr 판과 동일하되 Next 가 1 이라 `SVA1[3]+Index` 로 주소가 잡힌다.
5. 공용 자원: `FuncAlloc`, `FileNameIndex`, `FileDirectory`, `__VArrSTR`/`__SVArrSTR` 캐시(`__VArrCheck` 로 1회 초기화), TEP 3.0 STRx 상태(`f_GetFileptrN:77029~77040` 은 `TEP30STRx==1 and __STRxSwitch==0` 이면 표식 트리거를 `STRxStart()/STRxEnd()` 로 감싼다).

**제약·주의사항**
- `StartCtrig(...,STRCTRIG=1,AbsolutePath)` 가 선행되어야 한다(`503~545`). 경로가 없으면 `FileDirectory` 가 nil 이라 문자열 연결에서 에러.
- 리눅스 헤드리스 빌드에서는 `temp\` 역슬래시 경로 처리가 호스트 래퍼에 달려 있다(`TEP3.0_Headless_Compiler/headless/platform/win32_fopen_wrap.cpp:13`).
- 맵 TRIG 크기를 늘리지 않는다(글자 트리거는 TRIGP*.chk 에 들어감). 긴 문자열에 유리.
- 가이드 vs 소스: 가이드 시그니처에 `tblflag` 없음. "반드시 CJump 사이" 규칙은 소스에서 강제하지 않음(표식 트리거는 `Never()` 라 어디 있어도 실행되진 않지만, STRCtrig 배치 규약은 가이드를 따를 것).

**예제**
```lua
-- 예제 26-2 (Guide Book.txt:16163~) 발췌
CJump(AllPlayers,0)
Str3 = SaveiStrptr(P3,"\x13"..MakeiStrWord("\x08T\x17E\x07S\x1FT",2),1)  -- SVA32 파일 저장. 리턴 {P3,FuncAlloc-1,1,"SVA32",1,8}
CJumpEnd(AllPlayers,0)
CSPrint(iStr1,Str3,P1,0,P1,{MemoryX(0x57F0F0,Exactly,4,4)},nil,nil,1)
```

**관련 함수**: SaveiStrArr(맵 내판), SaveiStrptrX(utf8), DwSaveiStrptr(raw dword), SaveiStrFile(원시 파일), f_GetFileVArrptrN/f_GetFileSVArrptrN.

---

### 2.6 SaveiStrFile  ＃STRCtrig 필수 (가이드북 미수록, v5.5 추가)
**시그니처**: `SaveiStrFile(PlayerID,String,tblflag)`  (소스: `CtrigAsm v5.5.lua:46124~46142`)
**한 줄 요약**: 문자열을 iStr 로 변환해 **트리거 형식 없이 원시 바이트 파일**로 저장하고 파일 포인터 테이블을 리턴한다.
**사용 위치**: 컴파일 타임 Lua 함수.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| PlayerID | 플레이어 상수 | `f_GetFileptr` 에서 `players={P9,PlayerID}` 로 쓰임. nil 이면 P9 만 | 표식 트리거 체크 플레이어 |
| String | Lua 문자열 | 필수 | 저장할 문자열 |
| tblflag | 1/그 외 | nil | 2.0.2 표 |

**리턴값**: `ret, Arr, Size` — ret = `{"X" 또는 PlayerID, FuncAlloc-1, 0x970, 0}` (`76861~76866`). [2] 표식 트리거 Label, [3] 데이터 시작 바이트 오프셋 0x970, [4] 0. **V 변수가 아니다.** SVA32 인자는 없다.

**작동 메커니즘**
1. `STRCTRIGASM` 검사, 인코딩 분기로 Arr(바이트)/Size. `f_GetFileArrptr(PlayerID,Arr,1,1)` (`76904~76928`): 파일명 생성 → `SaveFileArr(Arr,1,FileName)` (`76930~76966`) 가 바이트를 4096 단위로 flush 하며 그대로 씀 → `f_GetFileptr(PlayerID,FileName,1)` (`76811~76868`) 가 `players={P9,PlayerID}`, `Label(FuncAlloc)`, `Never()`, 경로 액션들 인 표식 트리거 생성, `FuncAlloc+1`. LoadCheck=1 이면 `f_GetFileSize` 호출(`76863`).
2. 맵 빌드 시 TEP 가 파일 내용을 0x970 단위로 패딩해 표식 트리거 뒤에 붙인다(`STRCtrig.h:196~230`). 따라서 데이터는 `Label 트리거 주소 + 0x970` 부터 iStr 바이트가 연속으로 놓인다.
3. 이 리턴을 소비하는 CAPrint 계열 함수는 이 그룹 범위에서 확인되지 않았다("소스에서 확인 불가" — 26장 다른 그룹 또는 다른 장의 `f_GetFileptr` 소비자 참조).

**제약·주의사항**: STRCtrig 필수. 리턴은 파일 포인터이므로 `SVA1()`/`CSVA1`/`CSPrint` 에 넣을 수 없다.

**예제**
```lua
-- 소스 기반 최소 예제 (가이드 예제 없음)
CJump(AllPlayers,0)
FStr, FArr, FSize = SaveiStrFile(P1,"\x04파일 문자열",1)  -- icp949 로 원시 저장. FStr = {P1, Label, 0x970, 0}
CJumpEnd(AllPlayers,0)
```

**관련 함수**: SaveiStrFileX, DwSaveiStrFile(X), f_GetFileArrptr, f_GetFileptr.

---

### 2.7 SaveiStrArrX
**시그니처**: `SaveiStrArrX(PlayerID,String,SVA32)`  (소스: `CtrigAsm v5.5.lua:46143~46153`, 가이드: `Guide Book.txt:6958`)
**한 줄 요약**: 문자열을 항상 iutf8 로 변환해 맵 내 트리거에 저장. SVA32=1 이면 `CreateSVA32X`(CP+8), 아니면 `CreateSVA1`.
**사용 위치**: 컴파일 타임. 변수 선언 위치 (theSeed `main.lua:229` 주석: "SaveiStrArrX류는 반드시 이 CJump 블록 안에서 호출").

**인자**: PlayerID / String / SVA32 (tblflag 없음).

**리턴값**: `ret, Arr, Size` — ret 은 `CreateSVA32X`(`{..,"SVA32",ceil(Size/32),Size}`) 또는 `CreateSVA1`(`{..,"V",0,Size}`).

**작동 메커니즘**: `str_to_iutf8(String,1)` (TEP 2.x 면 내부에서 `cp949_to_utf8`) → `CreateSVA32X` 또는 `CreateSVA1` (`46145~46151`). 이하 2.2/2.3.

**제약·주의사항**: SVA1 판은 `CreateSVA1` 이라 non-X 와 트리거 구조가 같고 인코딩만 utf8 이다. 가이드 6961: SVA1 은 CDPrint/C13Print 용, SVA32 는 CA__OverWrite 용.

**예제**
```lua
-- theSeed/MapLogic/SelectedUnitInfo.lua:187~188
Str1, Str1a, Str1s = SaveiStrArrX(FP, t01)   -- SVA1(utf8) 템플릿
Str3, Str3a, Str3s = SaveiStrArrX(FP, t03)
-- 예제 26-27: Str1, Str1a, Str1s = SaveiStrArrX(P1,"\x13\x04CDPrint \x18예제\x10-O")
```

**관련 함수**: SaveiStrArr, SaveiStrptrX, DwSaveiStrArrX, CreateSVA32X, CreateSVA1.

---

### 2.8 SaveiStrptrX  ＃STRCtrig 필수
**시그니처**: `SaveiStrptrX(PlayerID,String,SVA32)`  (소스: `CtrigAsm v5.5.lua:46154~46168`, 가이드: `Guide Book.txt:6966`)
**한 줄 요약**: SaveiStrptr 의 utf8 고정판. SVA32=1 이면 파일 트리거의 CP 증가량이 8 인 `"SVA32X"` 이미지로 저장.
**사용 위치**: 컴파일 타임, 최상단 CJump(0) 블록.

**인자**: PlayerID / String / SVA32.

**리턴값**: SVA32==1 → `{P, FuncAlloc-1, 1, "SVA32", ceil(Size/32), Size}`; 그 외 → `{P, FuncAlloc-1, 1, "V", 0, Size}` (`46160~46166`).

**작동 메커니즘**: `STRCTRIGASM` 검사 → `str_to_iutf8` → SVA32==1 이면 `f_GetFileSVArrptrN(PlayerID,Arr,1,32,"SVA32X",1)` — 이 때 `SVA32X = 8` 이 되어 각 글자 뒤 액션이 `__SVArrSTR[5]` (number=8, Add) 로 써진다(`77572~77575`, `77681~77685`); 아니면 `f_GetFileVArrptrN(PlayerID,Arr,1,"SVA1",1)`. 나머지는 2.5.

**제약·주의사항**: 2.5 와 동일.

**예제**
```lua
-- 예제 26-22 (Guide Book.txt:16976~)
CJump(AllPlayers,0)
Str2 = SaveiStrptrX(P3,"\x1D―\x04테스트☆\x05텍스트★",1)   -- SVA32X 파일판
CJumpEnd(AllPlayers,0)
function TEST2() local PlayerID = CAPrintPlayerID
    CA__OverWrite(Str2,_GIndex(A),0,1)
end
```

**관련 함수**: SaveiStrptr, SaveiStrArrX, DwSaveiStrptrX, f_GetFileSVArrptrN.

---

### 2.9 SaveiStrFileX  ＃STRCtrig 필수 (가이드북 미수록, v5.5 추가)
**시그니처**: `SaveiStrFileX(PlayerID,String)`  (소스: `CtrigAsm v5.5.lua:46169~46179`)
**한 줄 요약**: SaveiStrFile 의 utf8 고정판.
**인자**: PlayerID / String.
**리턴값**: `{P, FuncAlloc-1, 0x970, 0}, Arr, Size`.
**작동 메커니즘**: `STRCTRIGASM` 검사 → `str_to_iutf8(String,1)` → `f_GetFileArrptr(PlayerID,Arr,1,1)`. 2.6 과 동일.
**제약·주의사항**: 2.6 과 동일.
**관련 함수**: SaveiStrFile, DwSaveiStrFileX.

---

### 2.10 DwSaveiStrArr (가이드북 미수록, v5.5 추가)
**시그니처**: `DwSaveiStrArr(PlayerID,String,SVA32)`  (소스: `CtrigAsm v5.5.lua:46180~46204`)
**한 줄 요약**: 문자열의 원시 바이트를 4바이트씩 dword 로 묶어(iStr 변환 없음) 맵 내 SVA1/SVA32 트리거에 저장.
**사용 위치**: 컴파일 타임, 변수 선언 위치.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| PlayerID | 플레이어 상수 | AllPlayers | 체크 플레이어 |
| String | Lua 문자열 | 필수 | 원시 바이트 원본 |
| SVA32 | 1/그 외 | nil → SVA1 | 1 이면 `CreateSVA32` (CP+1) |

**리턴값**: `ret, Arr, Size` — Arr 은 0xD 패딩된 바이트 배열, **Size = ceil(#String/4)** (dword 수).

**작동 메커니즘**: 2.0.7 코드. 인코딩 변환 없음. `CreateSVA32(Arr,Size,PlayerID)` 또는 `CreateSVA1(Arr,Size,PlayerID)`.

**제약·주의사항**: "글자" 개념이 없으므로 CA__ 의 컬러코드 마스크(0xFF)는 첫 바이트를 가리키게 된다. Dw 계열 출력 함수(`CA__DwSetValue` 등)와 짝을 이룬다.

**예제**
```lua
-- 소스 기반 최소 예제
CJump(AllPlayers,0)
DwStr, DwArr, DwSize = DwSaveiStrArr(P1,"ABCDEFG")  -- Arr = {65,66,67,68,69,70,71,0xD}, Size = 2 (dword)
CJumpEnd(AllPlayers,0)
```

**관련 함수**: DwSaveiStrptr, DwSaveiStrFile, DwSaveiStrArrX, SaveiStrArr.

---

### 2.11 DwSaveiStrptr  ＃STRCtrig 필수 (가이드북 미수록, v5.5 추가)
**시그니처**: `DwSaveiStrptr(PlayerID,String,SVA32)`  (소스: `CtrigAsm v5.5.lua:46205~46233`)
**한 줄 요약**: DwSaveiStrArr 의 파일 저장판.
**리턴값**: SVA32==1 → `{P, FuncAlloc-1, 1, "SVA32", ceil(Size/32), Size}`; 그 외 `{P, FuncAlloc-1, 1, "V", 0, Size}` (Size = dword 수).
**작동 메커니즘**: `STRCTRIGASM` 검사 → 2.0.7 의 바이트/패딩 → `f_GetFileSVArrptrN(PlayerID,Arr,1,32,"SVA32",1)` 또는 `f_GetFileVArrptrN(PlayerID,Arr,1,"SVA1",1)`. 2.5 와 동일한 파일/표식 트리거.
**관련 함수**: DwSaveiStrArr, DwSaveiStrptrX, SaveiStrptr.

---

### 2.12 DwSaveiStrFile  ＃STRCtrig 필수 (가이드북 미수록, v5.5 추가)
**시그니처**: `DwSaveiStrFile(PlayerID,String)`  (소스: `CtrigAsm v5.5.lua:46234~46258`)
**한 줄 요약**: 원시 바이트(0xD 패딩)를 트리거 형식 없이 파일로 저장. 리턴 `{P, FuncAlloc-1, 0x970, 0}, Arr, Size`.
**작동 메커니즘**: `STRCTRIGASM` 검사 → 바이트/패딩 → `f_GetFileArrptr(PlayerID,Arr,1,1)`. 2.6 과 동일.
**관련 함수**: SaveiStrFile, DwSaveiStrFileX.

---

### 2.13 DwSaveiStrArrX (가이드북 미수록, v5.5 추가)
**시그니처**: `DwSaveiStrArrX(PlayerID,String,SVA32)`  (소스: `CtrigAsm v5.5.lua:46259~46287`)
**한 줄 요약**: utf8 바이트를 dword 로 묶어 맵 내 트리거에 저장. SVA32=1 이면 `CreateSVA32X`(CP+8).
**작동 메커니즘**: `TEP30Flag==1` 이면 `String:gsub(".",...)` 로 바이트 그대로, 아니면 `cp949_to_utf8(String)` 후 마지막 원소 제거(`46261~46267`). `Size = ceil(#Arr/4)`, 0xD 패딩, `CreateSVA32X` 또는 `CreateSVA1`.
**리턴값**: `ret, Arr, Size`.
**관련 함수**: DwSaveiStrArr, DwSaveiStrptrX, SaveiStrArrX.

---

### 2.14 DwSaveiStrptrX  ＃STRCtrig 필수 (가이드북 미수록, v5.5 추가)
**시그니처**: `DwSaveiStrptrX(PlayerID,String,SVA32)`  (소스: `CtrigAsm v5.5.lua:46288~46319`)
**한 줄 요약**: DwSaveiStrArrX 의 파일판. SVA32=1 이면 `f_GetFileSVArrptrN(...,"SVA32X",1)` (CP+8 이미지).
**리턴값**: SVA32==1 → `{P, FuncAlloc-1, 1, "SVA32", ceil(Size/32), Size}`; 그 외 `{P, FuncAlloc-1, 1, "V", 0, Size}`.
**작동 메커니즘**: `STRCTRIGASM` 검사 → utf8 바이트(2.13) → 패딩 → 파일 저장(2.5/2.8).
**관련 함수**: DwSaveiStrptr, SaveiStrptrX.

---

### 2.15 DwSaveiStrFileX  ＃STRCtrig 필수 (가이드북 미수록, v5.5 추가)
**시그니처**: `DwSaveiStrFileX(PlayerID,String)`  (소스: `CtrigAsm v5.5.lua:46320~46347`)
**한 줄 요약**: utf8 원시 바이트(0xD 패딩)를 트리거 형식 없이 파일로 저장. 리턴 `{P, FuncAlloc-1, 0x970, 0}, Arr, Size`.
**작동 메커니즘**: `STRCTRIGASM` 검사 → utf8 바이트(2.13) → 패딩 → `f_GetFileArrptr(PlayerID,Arr,1,1)`.
**관련 함수**: DwSaveiStrFile, SaveiStrFileX.

---

### 2.16 SVA1
**시그니처**: `SVA1(SVA1,Index)`  (소스: `CtrigAsm v5.5.lua:46452~46461`, 가이드: `Guide Book.txt:6407`)
**한 줄 요약**: SVA1 변수에 글자 인덱스를 붙여 CA__/CS__/CSVA1 계열에 넘길 테이블을 만든다. 상수 Index → "V", V Index → "VA".
**사용 위치**: 컴파일 타임. CA__ 함수 인자, CSVA1 계열 인자, 어디서나.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| SVA1 | CreateSVA1/SaveiStrArr(X)/SaveiStrptr(X)/Dw* 의 리턴(타입 "V", [6]=글자 수) | 필수 | 원본 SVA1 |
| Index | 상수(정수, 0-based 글자 번호) 또는 V 테이블(값 = 글자번호×604) | nil 은 `type(nil)~="number"` 라 **"VA" 로 분류되어 이후 `Index[5]` 접근에서 에러** | 글자 인덱스 |

**리턴값**: 상수 → `{P, Label, Next, "V", Index, Size}`; V → `{P, Label, Next, "VA", V테이블, Size}`.

**작동 메커니즘**: 2.0.8. 원본 [1][2][3][6] 을 그대로 복사하고 [4] 타입과 [5] 인덱스만 채운다. 새 테이블을 만들므로 원본을 바꾸지 않는다. 트리거는 생성하지 않는다.

**제약·주의사항**
- V Index 는 반드시 604 배수(가이드 6413). `CMul(P,X,_Read(...),604)` 또는 `CreateVar2(P,nil,nil,3*604)` 처럼 준비.
- 파일판 SVA1(`[3]=1`) 도 그대로 쓸 수 있다. 소비자가 `SVA1[3]+Index` 로 Next 를 계산한다.
- 예제 26-3 은 `A = CreateVar2(P1,nil,nil,3*604)`, `SetNVar(A,Add,604)` 로 V 를 604 단위로 움직인다.

**예제**
```lua
-- 예제 26-3 발췌
CA__InputVA(0,Str1,Str1s,nil,0,19)                 -- SVA1 을 그대로 넣으면 인덱스 0 부터
CA__InputVA(D,SVA1(Str2,A),E,nil,B,C)              -- A(V, 604 배수) 를 인덱스로 하는 VA 형식
-- MSF_Respect_V/GunData.lua:2917
CD__InputVAX(_GIndex2(HLine,1),SVA1(HStr2,CurLiV),52,0xFFFFFFFF,0xFFFFFFFF,8,604*11-1)
```

**관련 함수**: CSVA1/SetCSVA1/TCSVA1/TSetCSVA1/TTCSVA1, TSVA1Mem, CA__InputSVA1, CA__InputVA, CS__ 대응 함수들.

---

### 2.17 TSVA1Mem
**시그니처**: `TSVA1Mem(PlayerID,Dest,SVA1,Address,OffsetFlag)`  (소스: `CtrigAsm v5.5.lua:78534~78636`, 가이드: `Guide Book.txt:6414`)
**한 줄 요약**: SVA1 특정 글자 트리거의 (기본 0x15C) 주소를 EPD 또는 바이트 오프셋으로 V 변수 Dest 에 저장하는 트리거를 생성한다.
**사용 위치**: 일반 트리거 흐름 어디서나(트리거를 즉시 생성). 내부에서 `STPopTrigArr(PlayerID)` 를 먼저 호출한다.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| PlayerID | 플레이어 상수 | 필수 | 생성 트리거 체크 플레이어 |
| Dest | V 변수(타입 "V") | 필수. 아니면 `_TSVA1Mem_InputData_Error()` | 주소를 받을 변수. Dest[3] 은 Next 로 쓰임 |
| SVA1 | `SVA1(...)` 결과(타입 "V" 또는 "VA") | 필수 | 주소를 읽을 글자. SVA1[3] nil/"X" 면 0 |
| Address | 정수(트리거 내부 오프셋) | nil/"X" → 0x15C | 글자 트리거 기준 오프셋 |
| OffsetFlag | 0/nil/"X" 또는 1 | 0 | 0 이면 EPD 값, 1 이면 바이트 오프셋 값을 저장 |

**리턴값**: 없음.

**작동 메커니즘**
- **SVA1 타입 "V" (상수 인덱스)** (`78544~78571`): 트리거 1개. `SetCtrigX(Dest[1],Dest[2],0x15C,Dest[3],SetTo, SVA1[1],SVA1[2],Address, EPD2, SVA1[3]+SVA1[5])` — STRCtrig 가 컴파일 시 "SVA1 라벨 트리거 + (Next)번째 트리거의 Address" 를 EPD(EPD2=1) 또는 바이트 주소(EPD2=0) 로 계산해 Dest 의 0x15C 에 SetTo 로 쓴다. 런타임 연산 없음.
- **SVA1 타입 "VA" (V 인덱스), OffsetFlag=0** (`78572~78590`): 트리거 1개. 위와 같이 글자 0 의 EPD 를 Dest 0x15C 에 쓴 뒤, 인덱스 V 트리거의 act[0] 을 `mask 0xFFFFFFFF, modifier Add, 대상 = Dest 0x15C 의 EPD` 로 세팅하고 `CallLabelAlways(V)` 로 호출 → Dest += V(604 단위). 결과 = 글자 V/604 의 EPD.
- **"VA", OffsetFlag=1** (`78591~78630`): 트리거 3개. V 를 `CRet[1]` 에 SetTo 로 복사(V act0 modifier=SetTo, 대상 = CRet 0x15C), CRet act0 을 Add·대상 자기자신으로 세팅, `CallLabelAlways2(V, CRet)` 로 V→CRet 순서 호출(CRet = 2V). 2번째 트리거가 CRet 을 다시 호출(CRet = 4V). 3번째 트리거가 CRet 의 대상을 Dest 0x15C 로 바꾸고 호출 → Dest += 4V = V×0x970/604 = 바이트 오프셋. 결과 = 글자 0 바이트 주소 + 인덱스×0x970.
- 공용 자원: `CRet[1]`(VA+Offset 분기), STPushTrigArr(선두의 `STPopTrigArr`).

**제약·주의사항**
- Dest 는 V 만. SVA1 인자에 원본 SVA1 을 `SVA1()` 없이 넣으면 [4]="V", [5]=0 이므로 글자 0 으로 동작한다.
- 가이드 vs 소스: 차이 없음(시그니처·기본값 일치).

**예제**
```lua
-- 소스 기반 최소 예제
Addr = CreateVar(P1)
TSVA1Mem(P1,Addr,SVA1(Str1,5))          -- Addr = EPD(Str1 6번째 글자의 0x15C)
TSVA1Mem(P1,Addr,SVA1(Str1,Idx),nil,1)  -- Idx(V, 604배수) 번째 글자의 바이트 주소
```

**관련 함수**: SVA1, CallLabelAlways/CallLabelAlways2, CS__ 계열(대응 없음, 소스 확인).

---

### 2.18 CSVA1
**시그니처**: `CSVA1(SVA1,Type,Value,Mask)`  (소스: `CtrigAsm v5.5.lua:8641~8648`, 가이드: `Guide Book.txt:6443`)
**한 줄 요약**: SVA1 글자 트리거의 값 칸(0x15C)을 비교하는 CtrigX 조건.
**사용 위치**: `Trigger{}`/`TriggerX` 의 conditions 안. 컴파일 타임에 조건 하나를 리턴.

**인자**
| 인자 | 타입·허용값 | 기본값(nil일 때) | 설명 |
|---|---|---|---|
| SVA1 | `SVA1(x, 상수Index)` 결과 (타입 "V") | 필수 | [5] 가 테이블이면 `SVA1[5]+SVA1[3]` 에서 산술 에러 → 상수만 |
| Type | AtMost / Exactly / AtLeast | 필수 | 비교 연산 |
| Value | 정수(글자 dword 값) | 필수 | 비교값 |
| Mask | 정수 | 0xFFFFFFFF | eudx 마스크(0xFF=컬러코드 바이트, 0xFFFFFF00=글자 바이트) |

**리턴값**: `CtrigX(SVA1[1],SVA1[2],0x15C,SVA1[5]+SVA1[3],Type,Value,Mask)` 가 만든 조건 1개.

**작동 메커니즘**: `CtrigX`(`1757~1825`) 는 `Condition(Mask, Address/4=0x57, Value, Index=Label, Type, 0xFF, Rflag, 0x10+0x80)` 인 가짜 조건을 만들고, STRCtrig 가 컴파일 시 "Label 트리거 + Next 번째 트리거의 0x15C" 의 EPD 를 player 칸에 채운다. Next = `SVA1[5]+SVA1[3]` (Arr 판은 글자 번호, ptr 판은 글자 번호+1). Next==1 이면 Nflag=16(next 포인터 추적), ≥2 면 `0x15C + 0x970*Next`. 런타임에는 그냥 DeathsX 마스크 비교다.

**제약·주의사항**: Index 상수만. 파일판 SVA1 도 사용 가능.

**예제**
```lua
-- 예제 26-32 (Guide Book.txt:17402~)
Str1, Str1a, Str1s = SaveiStrArr(P1,"\x0401\x0423456789")
TriggerX(P1,CSVA1(SVA1(Str1,1),Exactly,0x31000000,0xFF000000),    -- 2번째 글자의 글자 바이트가 '1'(0x31) 이면
           SetCSVA1(SVA1(Str1,1),SetTo,0x1F,0xFF),{Preserved})    -- 그 글자의 컬러코드를 0x1F 로
-- theSeed/MapLogic/SelectedUnitInfo.lua:386
TriggerX(FP, { CSVA1(SVA1(Str1, 6 + i), AtLeast, 0x0E * 0x1000000, 0xFF000000), CD(CFlag, 0) }, { ... }, { preserved })
```

**관련 함수**: SetCSVA1, TCSVA1(변수 삽입), TTCSVA1(NotSame/Above/Below), CtrigX.

---

### 2.19 SetCSVA1
**시그니처**: `SetCSVA1(SVA1,Type,Value,Mask)`  (소스: `CtrigAsm v5.5.lua:8649~8656`, 가이드: `Guide Book.txt:6449`)
**한 줄 요약**: SVA1 글자 트리거의 값 칸(0x15C)에 쓰는 SetCtrig1X 액션.
**사용 위치**: actions 안.

**인자**: SVA1(상수 Index, "V") / Type(Add·SetTo·Subtract) / Value / Mask(기본 0xFFFFFFFF).

**리턴값**: `SetCtrig1X(SVA1[1],SVA1[2],0x15C,SVA1[5]+SVA1[3],Type,Value,Mask)` 액션 1개.

**작동 메커니즘**: `SetCtrig1X`(`1957~2028`) 가 `Action(Mask,Label,Rflag,0,0x15C/4=0x57,Value,0,0x5,Type,0x14+0x80)` 를 만들고 STRCtrig 가 대상 EPD 를 채운다. 런타임에는 SetDeathsX(글자 dword 주소, Type, Value, mask). CSVA1 과 같은 Next 규칙.

**제약·주의사항**: 글자 바이트를 바꿀 때는 마스크를 정확히(예: 컬러코드만 0xFF). SVA1 act[0] 의 Disabled 상태와 무관하게 값만 바꾼다.

**예제**
```lua
-- theSeed/MapLogic/SelectedUnitInfo.lua:381
TriggerX(FP, { CV(SelDef, i) }, { SetCSVA1(SVA1(Str3, 11 + 1), SetTo, DefAPB[i + 1], 0xFF0000FF) }, { preserved })
-- MapSource/MSF_UE_RE/func.lua:1875 (래퍼)
TriggerX(Player,Condition,{SetCSVA1(SVA1,SetTo,Value,Mask)},Flag)
```

**관련 함수**: CSVA1, TSetCSVA1, CA__Input(SVA1 한 글자에 상수 입력, 예 Operator.lua:253).

---

### 2.20 TCSVA1
**시그니처**: `TCSVA1(SVA1,Type,Value,Mask)`  (소스: `CtrigAsm v5.5.lua:8657~8770`, 가이드: `Guide Book.txt:6456`)
**한 줄 요약**: CSVA1 의 변수 삽입형. SVA1 Index·Value·Mask 에 V/VA 를 넣을 수 있고, `CTrigger` 조건 자리에서만 쓴다.
**사용 위치**: `CTrigger(PlayerID,{TCSVA1(...)},{...})` 의 조건 안 전용(리턴 "TCond" 를 CTrigger 조립기가 소비).

**인자**
| 인자 | 타입·허용값 | 기본값 | 설명 |
|---|---|---|---|
| SVA1 | `SVA1(x,상수)`("V") 또는 `SVA1(x,V)`("VA") | 필수 | VA 면 V 값(604 배수)이 EPD 에 더해짐 |
| Type | AtMost/Exactly/AtLeast | 필수 | |
| Value | 정수, V, VA(V 배열; 임시 V 로 MovX 됨) | 필수 | V 의 [5] 가 숫자면 Deviation, 테이블이면 VA 규칙 |
| Mask | 정수, V, VA | nil → 마스크 0(SetCtrig 규칙상 "마스크 없음") | V 외 테이블은 `TMemoryX_InputData_Error()` |

**리턴값**: 문자열 `"TCond"` (실제 조건은 `PushCondArr` 에, 준비 트리거 묶음은 `PushTrigArr` 에 push).

**작동 메커니즘** (`8657~8770`)
1. Mask 가 VA 면 임시 V(`VarXAlloc`) 를 만들어 `STPushTrigArr` 에 `{"MovX",Temp,Mask}` 를 넣고 V 로 바꾼다. Mask 가 V 면 준비 액션 5개를 `PushTrigArr` 에 push: `CallLabelAlways(V)`, V act0 mask=0xFFFFFFFF, V act0 modifier=Add(0x160 에 `Add*16777216` 마스크 0xFF000000), V act0 대상 = 조건 트리거의 **0x8**(cond[0].loc = eudx 마스크 칸) EPD, 조건 트리거 0x8 := Mask[5]. → 런타임에 마스크 칸 = Deviation + V.
2. Value 도 같은 방식으로 **0x10**(cond[0].amount) 에 더한다. Value[5] 가 테이블(VA)이면 마지막 액션이 `SetCtrigX("X","X",0x10,0,SetTo,Value[5][1..])` 로 VA 원소 주소를 넣는다.
3. SVA1 이 "VA" 면 2.0.8 코드: 조건 트리거 **0xC**(cond[0].player) := EPD(SVA1 글자0 의 0x15C)(+SVA1[3]+Deviation), 그 위에 V 값을 Add. 그리고 `SVA1 = 0x58A364`(EPD 0 기준 주소) 로 바꿔 `FMemoryX(0x58A364,Type,Value,Mask)` = `DeathsX(0,...)` 조건을 만든다(player 칸은 위 준비 트리거가 채움). SVA1 이 "V" 면 `CtrigX(SVA1[1],SVA1[2],0x15C,SVA1[3]+SVA1[5],Type,Value,Mask)` 그대로.
4. `PushCondArr` 에 조건, `CondLineArr` 에 준비 트리거 수(PushLine) 를 넣고 "TCond" 리턴. CTrigger 조립기가 준비 트리거들을 조건 트리거 앞에 배치하고 `PushTrigStack` 만큼 오프셋(0x970/4 단위)을 보정한다(조립 상세는 CTrigger 담당 장).
5. 공용 자원: `VarXAlloc`/`MAXVAlloc`, `STPushTrigArr`, `PushTrigArr`/`PushTrigStack`, `PushCondArr`/`CondLineArr`.

**제약·주의사항**
- CTrigger 밖에서 쓰면 "TCond" 문자열이 조건 자리에 들어가 깨진다.
- 조건 트리거의 cond[0] 칸(0x8/0xC/0x10) 을 준비 트리거가 매 실행마다 덮어쓴다(SetTo 후 Add) → Preserved 반복에 안전.
- `Mask` nil 이면 CtrigX 에 nil 이 넘어가 "마스크 없음(0)" 이 된다. CSVA1 의 기본 0xFFFFFFFF 와 다르다(소스 확인: TCSVA1 에는 `if Mask == nil then Mask = 0xFFFFFFFF` 가 없음). **가이드 vs 소스**: 가이드는 CSVA1 계열 공통으로 "기본값 0xFFFFFFFF" 로 읽히지만 TCSVA1/TSetCSVA1/TTCSVA1 은 Mask 를 명시해야 한다.

**예제**
```lua
-- 예제 26-32
X = CreateVar(P1)
CMul(P1,X,_Read(0x57F0F0),604)                                   -- X = 인덱스 × 604
CTrigger(P1,{TCSVA1(SVA1(Str1,X),AtLeast,0x35000000,0xFF000000)},
           {TSetCSVA1(SVA1(Str1,X),SetTo,_Mov(0x41000000),0xFF000000)},{Preserved})
```

**관련 함수**: CSVA1, TSetCSVA1, TTCSVA1, _TCSVA1, TMemoryX(같은 push 규약).

---

### 2.21 TSetCSVA1
**시그니처**: `TSetCSVA1(SVA1,Type,Value,Mask)`  (소스: `CtrigAsm v5.5.lua:8771~8888`, 가이드: `Guide Book.txt:6457`)
**한 줄 요약**: SetCSVA1 의 변수 삽입형. CTrigger 액션 자리 전용.
**사용 위치**: `CTrigger(PlayerID,{...},{TSetCSVA1(...)})` 의 액션 안.

**인자**: TCSVA1 과 동일. 단 Value 가 V/VA 가 아닌 테이블이면 에러 대신 `TypeNum += 2` 로 "값 자리에 다른 변수 참조" 모드가 된다.

**리턴값**: `"TAct"` (액션은 `PushActArr`, 준비 트리거는 `PushTrigArr`).

**작동 메커니즘** (`8771~8888`)
- 준비 트리거 규약은 TCSVA1 과 같되 대상 오프셋이 액션 트리거 기준 **0x128**(Mask → act[0].loc −0x20), **0x13C**(Value → act[0].number −0x20), **0x138**(SVA1 VA → act[0].player −0x20) 이다. `TSetMemoryX`(`13515~13564`) 와 같은 규약이며 −0x20 은 CTrigger 조립기가 액션을 배치하는 슬롯 기준이다(조립기 내부는 이 그룹 범위 밖 — 소스에서 확인 불가).
- 최종 액션: `TypeNum==0`(SVA1 VA) → `FSetMemoryX(0x58A364,Type,Value,Mask)`; `1`(SVA1 V) → `SetCtrig1X(SVA1[1],SVA1[2],0x15C,SVA1[3]+SVA1[5],Type,Value,Mask)`; `2`(SVA1 VA + Value 테이블) → `SetCtrig2X(SVA1,Type,Value[1],Value[2],Value[3],Value[5],Value[4],Mask)`; `3`(SVA1 V + Value 테이블) → `SetCtrigX(SVA1[1],SVA1[2],0x15C,SVA1[3]+SVA1[5],Type,Value[1],Value[2],Value[3],Value[5],Value[4],Mask)`.
- 공용 자원: TCSVA1 과 동일 + `PushActArr`/`ActLineArr`.

**제약·주의사항**: Mask 기본값 없음(nil → 0). Value 에 `_Mov(...)` 같은 CTrigger 연산 결과(V) 를 넣는 것이 전형(예제 26-32).

**예제**: 2.20 예제 참조.

**관련 함수**: SetCSVA1, TCSVA1, TSetMemoryX.

---

### 2.22 TTCSVA1
**시그니처**: `TTCSVA1(SVA1,Type,Value,Mask)`  (소스: `CtrigAsm v5.5.lua:8889~9009`, 가이드: `Guide Book.txt:6461`)
**한 줄 요약**: CSVA1 의 특수조건(NotSame/Above/Below) + 변수 삽입형. CTrigger 조건 자리 전용.
**사용 위치**: `CTrigger` 조건 안.

**인자**: SVA1 / Type = `"!="` 또는 `NotSame`(Mode 0), `">"` 또는 `Above`(Mode 1), `"<"` 또는 `Below`(Mode 2); 그 외는 `TTMemoryX_TypeError()` / Value / Mask (V·VA 삽입 가능, TCSVA1 과 같은 규칙).

**리턴값**: `CDeaths("X",Exactly,1,FCode)` — 플래그 변수 `FCode`(=`FlagIndex(FlagAlloc)`) 가 1 인지 보는 조건. 실제 비교는 앞에 생성되는 준비 트리거가 한다.

**작동 메커니즘** — NotSame/Above/Below 지원 근거 (특별 과제 g)
1. `8889~8899`: Type → Mode 결정. `FlagAlloc` 에서 플래그 하나를 잡는다.
2. Mask/Value/SVA1(VA) 의 준비 액션 묶음을 `Y` 에 모은다. 대상 오프셋은 **0x1C/0x20/0x24**(cond[1] 의 loc/player/amount) — TT 검사 조건이 cond[1] 슬롯에 놓이기 때문(cond[0] 은 Label(0)).
3. 비교 조건은 항상 `Exactly` 로 만든다: SVA1 VA → `FMemoryX(0x58A364,Exactly,Value,Mask)`, V → `CtrigX(...,0x15C,SVA1[3]+SVA1[5],Exactly,Value,Mask)` (`8989~8994`). `TTPushTrigArr/TTPushCondArr/TTFCodeArr/TTModeArr` 에 push.
4. CTrigger 조립기(`38696~38822`)가 Mode 별로 트리거를 만든다:
   - **Mode 0 (NotSame)**: `FCode := 1`, 검사 트리거의 cond[1] comparison 바이트(0x28, 마스크 0xFF0000) := Exactly → 준비 트리거들 → `Label(0)+TargetCond` 가 참이면 `FCode := 0`. 결과 FCode==1 ⇔ 값 ≠ Value.
   - **Mode 1 (Above)**: `FCode := 0`, comparison := **AtLeast**, 검사 트리거 act0 값 := 1 → 검사(참이면 FCode := 1) → 이어서 next 포인터를 되돌려 같은 검사 트리거를 comparison := **Exactly**, act0 값 := 0 으로 한 번 더 실행(`38777~38780`). 결과 FCode==1 ⇔ (≥Value) 이고 (≠Value) ⇔ 값 > Value.
   - **Mode 2 (Below)**: AtMost 로 1차, Exactly 로 2차 → 값 < Value.
5. 공용 자원: `FlagAlloc`, TT 계열 push 배열, `VarXAlloc`.

**제약·주의사항**: TT 조건은 CTrigger 하나에 여러 개 가능(각각 플래그). Mask nil → 0. SVA1 VA 인덱스는 604 배수.

**예제**
```lua
-- 예제 26-32
CTrigger(P1,{TTCSVA1(SVA1(Str1,_Mul(_Read(0x57F120),604)),"!=",_Mov(0x0D),0xFF)},  -- 컬러코드 바이트가 0xD 가 아니면
           {DisplayText("컬러코드 O")},{Preserved})
```

**관련 함수**: TCSVA1, CSVA1, TTMemoryX(같은 규약), _TTCSVA1.

---

### 2.23 _TCSVA1 / _TTCSVA1 (가이드북 미수록)
**시그니처**: `_TCSVA1(SVA1,Type,Value,Mask)` / `_TTCSVA1(SVA1,Type,Value,Mask)`  (소스: `CtrigAsm v5.5.lua:9010~9013`, `9014~9019`)
**한 줄 요약**: 호출을 실행하지 않고 `{"T","TCSVA1",SVA1,Type,Value,Mask}` / `{"TT","TTCSVA1",...}` 튜플만 리턴하는 지연 표기.
**작동 메커니즘**: 트리거 생성 없음. OR 조건 디스패처(`38173~38250`)가 `v[1]=="T"/"TT"` 튜플을 `v[2]` 이름으로 분기해 실제 T/TT 함수를 호출하는 구조인데, **디스패처에 `"TCSVA1"`/`"TTCSVA1"` 분기가 없다**(grep 결과 문자열 `"TCSVA1"` 은 9011/9015 에만 존재). 따라서 이 두 함수의 튜플을 `COr` 등에 넣어도 무시된다.
**제약·주의사항**: 사실상 미완성 API. 쓰지 말 것(소스 기준).

---

### 2.24 CreateSV54
**시그니처**: `CreateSV54(PlayerID,String)`  (소스: `CtrigAsm v5.5.lua:79714~79770`, 가이드: `Guide Book.txt:7304`)
**한 줄 요약**: 54글자 iutf8 문자열을 오류줄(에러 메시지 줄) 버퍼 `0x641598` 에 통째로 써 넣는 트리거 1개를 만들고 SV54 변수 테이블을 리턴한다 (C13Print 전용).
**사용 위치**: 컴파일 타임. 변수 선언 위치(예제 26-27 은 CJump 블록 안). `FuncAlloc` 라벨을 쓰므로 CreateVar 계열과 다른 번호 공간.

**인자**
| 인자 | 타입·허용값 | 기본값 | 설명 |
|---|---|---|---|
| PlayerID | 플레이어 상수 | nil 이면 `players={nil}` — 소스에 기본값 처리 없음 | 트리거 체크 플레이어. 숫자면 리턴 [1] |
| String | Lua 문자열 | 필수 | 54글자 초과분은 잘림, 부족분은 0xD 패딩 |

**리턴값**: `{"X" 또는 PlayerID, FuncAlloc-1, 0, "SV54"}` — [2] 트리거 Label(FuncAlloc 공간), [4] 타입 "SV54". 글자 수 칸 없음.

**작동 메커니즘**
1. `str_to_iutf8(String,1)` 로 iutf8 바이트 배열(TEP30Flag 무관, tblflag 없음).
2. n=1,5,...,213 으로 **정확히 54 dword** 를 만든다. 각 바이트가 nil(문자열이 짧음)이면 0xD 로 채움(`79721~79741`): `Temp = b0 + b1*256 + b2*65536 + b3*16777216`, 빈 자리는 `0xD`, `0xD00`, `0xD0000`, `0xD000000`. `n > 216` 에서 중단하므로 55번째 글자부터는 버려진다.
3. 트리거 1개(`79746~79757`): `Label(FuncAlloc)`, 액션 = `SetMemoryX(0x641598+4*i, SetTo, Value[i+1], 0xFFFFFFFF)` i=0..53 (54개) + `SetMemoryX(0x641670, SetTo, 0, 0xFFFF)` (0x641598+0xD8 = 0x641670 의 하위 워드 0 = 종료). Preserved. `FuncAlloc+1`.
4. 런타임: 호출(C13Print 가 CallLabel 계열로)하면 오류줄 버퍼가 이 문자열로 덮이고 끝에 널이 찍힌다. C13Print 의 `CA[1]=k` 가 "k 번 SV54 데이터로 초기화" 라고 가이드가 말하는 것이 이 트리거 호출이다(C13Print 본체는 다른 그룹).
5. 공용 자원: `FuncAlloc`.

**제약·주의사항**
- 문자열 폭은 54 dword = 54글자 고정. 가이드 7307 "54자 이내, 빈칸은 0xD" 와 일치.
- 리턴에 글자 수가 없어 `SVA1()`/`CSVA1` 에 넣을 수 없다. C13Print 의 SV54 인자 전용.
- 가이드 vs 소스: 차이 없음.

**예제**
```lua
-- 예제 26-27 (Guide Book.txt:17261~) 발췌
CJump(AllPlayers,0)
Str54 = CreateSV54(P1,MakeiStrVoid(40))              -- 40글자 공백 + 14글자 0xD 패딩 = 54 dword 트리거 1개
CJumpEnd(AllPlayers,0)
function TEST2()
    CA__SetNext(Str2,8,SetTo,0,Str2s-1)
    ...
    CA__InputVA(0,Str2,Str2s,nil,0,39*8)
end
C13Print(Str54,P1,{1,0,12,0,1,0,0,0},"TEST2",P1)     -- Str54 를 오류줄에 출력
```

**관련 함수**: C13Print, CS__ 계열, MakeiStrVoid.

---

### 2.25 f_GetFileVArrptrN / f_GetFileSVArrptrN / f_GetFileArrptr (내부 헬퍼, 가이드북 미수록)
**시그니처**:
- `f_GetFileVArrptrN(PlayerID,FileArray,ElementSize,Repeat,LoadCheck)` (`77154~77419`)
- `f_GetFileSVArrptrN(PlayerID,FileArray,ElementSize,Number,Repeat,LoadCheck)` (`77517~77720`)
- `f_GetFileArrptr(PlayerID,FileArray,ElementSize,LoadCheck)` (`76904~76928`)

**한 줄 요약**: 파일 저장판 Save*ptr/Save*File 이 쓰는 파일 작성기. 배열을 트리거 이미지(V/SVA1, SV/SVA32/SVA32X) 또는 원시 바이트로 파일에 쓰고 표식 트리거를 만든다.

**인자**
| 인자 | 설명 |
|---|---|
| FileArray | 바이트(ElementSize=1)/워드(2)/dword(4) 배열. 그 외 → `f_GetFile*ArrptrN_InputData_Error()` |
| ElementSize | 원소 크기. Save* 계열은 항상 1 |
| Repeat | 숫자면 파일 반복 횟수(`f_GetFileptrN` 의 `SetDeathsX(Repeat,...)` → TEP 가 `act[0].player` 로 읽어 파일을 Repeat 번 이어붙임, `STRCtrig.h:161,212`). 문자열 `"SVA1"` 이면 SVA1 레이아웃(+Repeat=1), `"SVA32"`/`"SVA32X"` 면 SVA32 레이아웃(CP+1 / CP+8) |
| Number | (SV 판) 트리거당 원소 수. Save* 는 32 |
| LoadCheck | 1 이면 `f_GetFileSize` 호출 |

**리턴값**: V 판 `{"X"/P, FuncAlloc-1, 1, "V", 0, TCount}`, SV 판 `{"X"/P, FuncAlloc-1, 1, "SA", Number, TCount}`, Arr 판 `{"X"/P, FuncAlloc-1, 0x970, 0}`. TCount = 생성된 트리거 이미지 수.

**작동 메커니즘**
- 최초 1회 `__VArrSTR`/`__SVArrSTR` 에 고정 바이트 조각(2.0.4/2.0.5 의 파일 열)을 만든다(`__VArrCheck`, `__SVArrCheck`).
- V 판: `Repeat=="SVA1"` 이면 player 칸 `0D 00 00 00`(CurrentPlayer) 과 `__VArrSTR[3]`(Disabled act0 + CP+1 + 자기 재비활성) 을, 아니면 player 0 과 `__VArrSTR[2]`(활성 act0 + Disabled Recover Next = CVariable 과 동일) 을 쓴다(`77234~77238`, `77294~77298`). 4바이트씩 한 트리거. 마지막 조각이 4바이트 미만이면 마스크가 `FF 00 00 00` 식으로 줄고 나머지는 0.
- SV 판: 트리거당 Number(32) 원소, 각 64바이트. `SVA32X==8` 이면 `__SVArrSTR[5]`(Add 8). 남는 칸은 `__SVArrSTR[6]`(Disabled 액션 쌍). 원소가 32 미만이면 `__SVArrSTR[7]`(64바이트 0) 으로 채움.
- 플레이어 바이트(이미지의 0x94C~0x953): `PlayerConvert2(PlayerID)` (`78238~78284`, 포함된 플레이어 칸이 1) 결과 8개. **V 판은 `PlayerArr[j]==0` 일 때 1 을 쓰고(`77304~77309`), SV 판은 `==1` 일 때 1 을 쓴다(`77700~77706`)** — 두 함수가 반대 극성이다. 다만 TEP 의 STRCtrig.h 는 파일 이미지를 **표식 트리거의 플레이어 목록**(`Check[k]`, `STRCtrig.h:132~156`)에 따라 각 플레이어의 TRIGPk.chk 에 붙이므로, 이미지 안의 플레이어 바이트가 실제 배치에 쓰이는지는 이 조사 범위에서 확인하지 못했다(소스에서 확인 불가).
- 마지막에 `f_GetTRIGptrN`(P12, SVA1) / `f_GetFileptrN`(P9) / `f_GetFileptr`(P9, 원시) 로 표식 트리거를 만든다.

**제약·주의사항**: 직접 호출할 일은 드물다. `FileNameIndex` 0x10000 초과 시 `FILEIndex_Overflow()`.

**관련 함수**: SaveiStrptr(X), DwSaveiStrptr(X), SaveiStrFile(X), DwSaveiStrFile(X), f_GetFileptr/f_GetFileptrN/f_GetTRIGptrN, SaveFileArr.

---

### 2.26 가이드 vs 소스 요약 (이 그룹)
1. `SaveiStrArr`/`SaveiStrptr` 시그니처: 가이드 3인자, 소스 4인자(`tblflag`). TEP 3.0 기본 인코딩이 iutf8 이라는 점도 가이드에 없음.
2. `SaveiStrFile(X)`, `DwSaveiStr*` 6종, `_TCSVA1`/`_TTCSVA1`, `f_GetFile*` 은 가이드 미수록.
3. `CreateSVA32X` 의 "utf8 전용" 은 관례이고 소스는 인코딩을 검사하지 않음. 실제 차이는 CP 증가량 1 vs 8.
4. `TCSVA1`/`TSetCSVA1`/`TTCSVA1` 은 Mask 기본값(0xFFFFFFFF)이 없다(`CSVA1`/`SetCSVA1` 에만 있음).
5. `SaveiStrptr` 의 "반드시 CJump 사이" 는 소스가 강제하지 않는다(배치 규약).
6. 맵 내 `SVA32`/`SVA32X` 생성기는 65글자 이상에서 트리거를 중복 생성한다(내용은 정상).
7. `_TCSVA1`/`_TTCSVA1` 튜플을 소비하는 디스패처 분기가 소스에 없다.
