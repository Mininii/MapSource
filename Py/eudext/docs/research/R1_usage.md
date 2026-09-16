# R1 — 맵별 CtrigAsm 기능 사용량 (eudext 우선순위 근거)

작성 2026-09-17. 파일은 읽기만 했고 고친 것은 없다. 수치는 스크래치패드의 스크립트로 다시 뽑을 수 있다.

- `r1_count.py` → `r1_raw.json`(이름별·맵별 호출 수, 인자 예), `r1_top.txt`(맵별 호출 상위 150개)
- `r1_extra.py`(추가 관용구 수), `r1_128.py`(DPS 128비트), `r1_summary.py`/`r1_table.py`(표 만들기)
- 실행: `C:\Users\whatd\.venvs\eud076\Scripts\python.exe r1_count.py` (약 11초)

## 0. 세는 법

**대상 맵과 약칭** (`SD` = `C:\Users\whatd\Desktop\Stormcoast Fortress\ScmDraft 2`)

| 약칭 | 경로 | 넣은 파일 | 줄 수(주석 포함) |
|---|---|---|---:|
| DPS | `SD\DPS_eud` | 루트 `*.lua`·`*.eps`, `CallTriggers\**`, `recover\` (`eud\ build\ tools\ docs\` 제외) 63개 | 33,109 |
| Seed | `SD\theSeed` | `**\*.lua` 73개 (`Engine\G_CB_Lib.lua` 제외) | 33,244 |
| Stel | `SD\Stella_II` | `**\*.lua` 13개 (`Engine\*` 제외: 템플릿과 같은 파일) | 6,495 |
| ResV | `SD\MSF_Respect_V` | 9개 (`G_CBPlot.lua` 제외) | 11,195 |
| Mem2 | `SD\MapSource\MSF_Memory_2` | 21개 | 17,345 |
| Mem1 | `SD\MapSource\MSF_Memory` | 3개 | 19,287 |
| G2R | `SD\MapSource\MSF_GaLaXy.2_R` | 8개 | 13,569 |
| UERE | `SD\MapSource\MSF_UE_RE` | 33개(eps 2개 포함) | 22,555 |
| Brz | `SD\MapSource\MSF_Breeze` | 8개 | 6,029 |
| Tpl | `C:\Users\whatd\Documents\MSF-Template` | `func.lua` `CallTriggers.lua` `BGMEngine.lua` (`G_CB_Lib.lua` 제외) | 1,307 |
| 그 밖 | `MapSource\` 의 `MSF_GaLaXy`, `MSF_GaLaXy.R`, `MSF_GaLaXy.2`, `MSF_UE`(각각 구판), `NewTestMap1`, `NewTestMap3`, `TestCode`(`G_CB_Lib.lua` 제외) + **목록 밖** `SD\MSF_MEME_EUD`(8개) | | 합 약 71,800 |
| 참고 | Tpl `G_CB_Lib.lua` 하나 (라이브러리 사본이 무엇을 부르는지 보려고 따로 셈. 합계에는 안 넣음) | | 2,226 |

**셈 규칙**
- 주석(`--`, `--[[ ]]`, eps 의 `//` `/* */`)은 지운다. 문자열 속 글자는 호출로 치지 않는다.
- "호출" = `이름(`. 단 `function 이름(` 정의 줄은 뺀다. 함수 값을 넘기는 식의 참조는 따로 셌다(iAtLeast 같은 상수는 참조 수로 표에 넣음).
- **맵 파일 안의 라이브러리 사본은 몸체를 통째로 지우고 센다.** 함수 이름이 CtrigAsm·CB Paint·LibraryFor322·Extra·DisplayPrint·TStruct·ObserverChat·CreateUnitShape·SCR_DB_Core·G_CB 계열과 같으면 사본으로 본다. 사용자가 새로 쓴 동명 함수(`CreateBullet` 류, `MSQC_Key*`, `CreateWarArr2`, `SetMemoryWX`, `Set_EXCC3` 류)는 사본이 아니라서 몸체도 센다. 지운 목록은 4절.
- 분류 이름 목록: CtrigAsm 함수 1,315개(`lists\a4_ctrig_funcs.txt`), 가이드북 장별 서명(`lists\a4_guide_funcs.txt`), 라이브러리 파일의 `function` 정의.
- 정규식으로 셌고 파서를 쓰지 않았다. `_G[...]`, 문자열로 만든 코드, 표에 담아 넘기는 간접 호출(DisplayPrint 의 `{SetNumX,…}` 제외)은 빠진다.

## 1. 기능 × 맵 호출 수

"주요 맵 수"는 위 10개 중 한 번이라도 부른 맵 수. "그 밖 합"은 구판·테스트·MEME 합.

| 기능 · 하위 묶음 | DPS | Seed | Stel | ResV | Mem2 | Mem1 | G2R | UERE | Brz | Tpl | 주요 맵 수 | 주요 합 | 그 밖 합 |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 1 64비트 · W 선언·참조 | 468 | · | 1 | · | · | 2 | · | 46 | · | · | 4 | 517 | 126 |
| 1 64비트 · W 산술·읽기쓰기 | 1521 | · | · | · | · | 5 | · | 53 | · | · | 3 | 1579 | 150 |
| 1 64비트 · W 조건·액션·비교 | 548 | · | · | · | · | 1 | · | 12 | · | · | 3 | 561 | 54 |
| 1 64비트 · 64비트 체력(`Bit64_HP_SystemX`) | · | · | · | · | · | 1 | · | · | · | · | 1 | 1 | 0 |
| 1 128비트 · DPS `math128`/`f_LMov128` 호출(2-b) | 163 | · | · | · | · | · | · | · | · | · | 1 | 163 | 0 |
| 2 숫자출력 · ItoDec/ItoHex 류 | · | · | · | · | 2 | 4 | 2 | 12 | · | · | 4 | 20 | 45 |
| 2 숫자출력 · CA__/CS__ItoCustom 류 | · | 3 | 3 | 3 | 14 | · | · | 32 | · | · | 5 | 55 | 21 |
| 2 숫자출력 · CD__Scan 류 | · | · | · | 1 | 1 | · | · | 1 | · | · | 3 | 3 | 3 |
| 2 숫자출력 · DisplayPrint 틀 | 470 | 40 | 23 | 57 | 20 | 22 | 11 | 32 | 21 | · | 9 | 696 | 49 |
| 2 숫자출력 · DPS DisplayPrint 원소 서식 함수 `{SetNumX,…}` | 220 | · | · | · | · | · | · | · | · | · | 1 | 220 | 0 |
| 2 숫자출력 · CAPrint/CDPrint/C13/FixText | 2 | 4 | 2 | 3 | 2 | 3 | 1 | 7 | 2 | · | 9 | 26 | 14 |
| 2 숫자출력 · iStr 준비(SVA1·SaveiStr·MakeiStr) | 1 | 72 | 67 | 55 | 123 | · | · | 148 | · | · | 6 | 466 | 219 |
| 2 숫자출력 · 채팅줄 상수 출력(print_utf8, Print_String) | 65 | · | · | · | · | · | 22 | 12 | · | · | 3 | 99 | 74 |
| 2 숫자출력 · 디스플레이 줄 조건(TTDisplay 류) | · | 2 | · | 5 | 5 | · | · | 5 | · | · | 4 | 17 | 14 |
| 3 글자효과 · CA__MoveXY/ConvertColor/ConvertLetter/Encode | · | · | · | · | · | · | · | · | · | · | 0 | 0 | 0 |
| 3 글자효과 · 그 밖의 CA__/CB__/CD__/CS__ 편집 | · | 16 | 17 | 32 | 35 | · | · | 61 | · | · | 5 | 161 | 104 |
| 4 총알 · 28장 이름(`CreateBullet`) ※전부 **사용자 재정의판** 호출 | · | · | · | · | 8 | 12 | 15 | 42 | · | · | 4 | 77 | 54 |
| 4 총알 · 사용자판 총알 함수(XY/Cond/Loc/SetBullet) | · | · | · | · | 10 | · | 1 | 7 | · | · | 3 | 18 | 1 |
| 4 총알 · dat 수정(28장 SetImage*) | 26 | · | · | 2 | · | · | · | · | · | · | 2 | 28 | 0 |
| 4 총알 · CGRP/BMP | · | · | · | · | · | · | · | · | · | · | 0 | 0 | 0 |
| 4 총알 · 파일 삽입(29장) | 35 | 15 | · | 1 | 15 | · | 1 | 12 | 5 | 1 | 8 | 85 | 61 |
| 5 입력 · KeyPress/TT*Press | 51 | 9 | · | 12 | · | · | · | 5 | · | · | 4 | 77 | 42 |
| 5 입력 · IsTyping/NotTyping | · | · | · | · | · | · | · | · | · | · | 0 | 0 | 0 |
| 5 입력 · NSQCSend/NSQCReceive/NSQCMov | · | · | · | · | · | · | · | · | · | · | 0 | 0 | 0 |
| 5 입력 · 사용자 MSQC 키 헬퍼(`MSQC_Key*`) | 54 | 24 | · | · | · | · | · | · | · | · | 2 | 78 | 2 |
| 6 부호비교 · `iAtLeast` 류 상수(참조) | · | · | · | · | 2 | · | · | 2 | · | · | 2 | 4 | 1 |
| 6 부호비교 · `"i>="` 류 문자열 | · | · | · | · | · | · | · | · | · | · | 0 | 0 | 0 |
| 6 (참고) 부호 있는 산술 CiSub/f_SHRead/_iSub 등 | 21 | 50 | 12 | 26 | 63 | 13 | 9 | 43 | 11 | · | 9 | 248 | 77 |
| 7 수학 · f_Lengthdir | · | 1 | · | 6 | 22 | 19 | 20 | 24 | 7 | 1 | 8 | 100 | 36 |
| 7 수학 · f_Atan2 | · | · | · | · | 1 | · | · | 1 | 1 | · | 3 | 3 | 0 |
| 7 수학 · f_Sqrt (따로 `_Square` 주요 8) | · | · | 1 | 1 | 2 | · | · | · | · | · | 3 | 4 | 0 |
| 7 수학 · f_Log2 / f_Diff·f_SDiff / CMathFunc | · | · | · | · | · | · | · | · | · | · | 0 | 0 | 0 |
| 7 수학 · Include_CtrigPlib | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | · | 9 | 9 | 10 |
| 7 수학 · f_CRandNum 류(범위 난수), f_Sqrd | 1 | 3 | 4 | 3 | 54 | · | 8 | 11 | 4 | 1 | 9 | 89 | 32 |
| 8 CX Paint · CSMake* | · | 43 | 174 | 189 | 76 | 26 | 35 | 44 | 14 | · | 8 | 601 | 433 (MEME 186) |
| 8 CX Paint · CS_* 편집 | · | 165 | 404 | 283 | 127 | 9 | 74 | 73 | 62 | · | 8 | 1197 | 680 (MEME 200) |
| 8 CX Paint · CSPlot/CSPlotAct | · | 4 | · | 5 | 2 | 4 | 7 | 97 | 2 | · | 7 | 121 | 130 |
| 8 CX Paint · CAPlot/CBPlot/CXPlot | · | · | · | · | 5 | 20 | 4 | 7 | 4 | · | 5 | 40 | 24 |
| 8 CX Paint · CA_/CB_ 실시간 편집 | · | · | · | · | 13 | 9 | · | 2 | · | · | 3 | 24 | 16 |
| 8 CX Paint · CX 3D | · | · | · | · | 3 | · | · | 3 | · | · | 2 | 6 | 6 |
| 8 CX Paint · CreateUnitShape(+Safe2Gun 판) | · | · | · | · | · | 332 | 6 | · | · | · | 2 | 338 | 278 |
| 8 (사용자 라이브러리) G_CB_Lib API | · | 17 | 172 | 861 | 44 | · | 14 | 356 | 75 | · | 7 | 1539 | 1048 (MEME 603) |
| 8 (사용자 라이브러리) G_CA_* (구 G_CB, 맵 안 G_CA 정의 몸체 제외) | · | · | · | · | 301 | · | 163 | · | 45 | · | 3 | 509 | 198 |
| 9 기타 · 방장(GetHostPlayerID 등) | · | · | · | · | · | · | · | · | · | · | 0 | 0 | 0 |
| 9 기타 · HotkeyUnit 계열 | · | · | · | · | · | · | · | · | · | · | 0 | 0 | 0 |
| 9 기타 · ObserverChat | · | 1 | 3 | 3 | 3 | · | · | · | 3 | · | 5 | 13 | 0 |
| 9 기타 · ExitDrop | · | · | · | · | · | · | · | · | · | · | 0 | 0 | 2 |
| 9 기타 · FindSD/FindSDLocal/WideScreen | · | · | · | · | · | · | · | · | · | · | 0 | 0 | 0 |
| 9 기타 · 플레이어 이름(PName·isname·ItoName·SetUnitName) | 12 | 8 | 9 | 14 | 5 | 18 | 6 | 9 | 6 | · | 9 | 87 | 22 |
| 9 기타 · HumanCheck·LocalPlayerID | 86 | 30 | 31 | 60 | 44 | 27 | 21 | 46 | 25 | 1 | 10 | 371 | 162 |
| 9 기타 · EUDTurbo·NoAirCollisionX·Enable_HideErrorMessage | 1 | 3 | 3 | 3 | 2 | 3 | 3 | 3 | 3 | · | 9 | 24 | 23 |
| 10 대체 · TStruct | · | 24 | · | · | · | · | · | 34 | · | · | 2 | 58 | 0 |
| 10 대체 · EXCC | 39 | 24 | 61 | 61 | 112 | · | · | 42 | 15 | 7 | 8 | 361 | 100 |
| 10 대체 · CunitCtrig_Part* | · | · | · | · | · | 20 | 10 | 10 | 5 | · | 4 | 45 | 15 |
| 10 대체 · Timer/TimerX/Stage | · | · | · | · | · | · | · | · | · | · | 0 | 0 | 0 |
| 10 대체 · SCR_DB | 14 | · | · | · | · | · | · | 7 | · | · | 2 | 21 | 0 |
| 10 대체 · BGM(AddBGM·IBGM_EPD·Install_BGMSystem) | · | 3 | 1 | 2 | 18 | · | · | 31 | 1 | 1 | 7 | 57 | 44 |
| 10 대체 · CABoss | · | · | · | · | 1 | · | · | 2 | · | · | 2 | 3 | 0 |
| 10 대체 · NBag | 8 | · | · | · | · | · | · | · | · | · | 1 | 8 | 5 |
| 10 대체 · CPush/CPop | · | · | · | · | · | · | · | · | · | · | 0 | 0 | 0 |
| 10 대체 · CFunc | · | 15 | · | · | · | · | · | · | · | · | 1 | 15 | 12 |
| 10 대체 · SetCall/CallTrigger(서브루틴) | 642 | 12 | 4 | 44 | 162 | 46 | 101 | 136 | 56 | 21 | 10 | 1224 | 384 |
| 10 대체 · Overflow_HP_System | · | · | · | · | · | 3 | · | · | · | · | 1 | 3 | 0 |

### 1-a. 이름별 소계 (주요 맵 합 / 그 밖 합, 괄호 = 부른 주요 맵)

- **W 선언·참조**: `CreateWar` 292/54 (DPS,Mem1,UERE), `WArrX` 51/25, `GetWArray` 29/25, `LArrX` 26/5 (DPS), `CreateWarArr` 24/4, `WArr` 22/3, `CreateWars` 20/2, `ConvertLArr` 18/4, `CreateWArr` 9, `LMem` 6, `CreateWArrArr` 5, `CreateWarArr2`(DPS 사용자 함수) 3/2, `ConvertWArr` 3, `LArr` 3, `CreateLArr` 2, `W` 1/1, `f_GetWArrptr` 1/1, `CreateWar2` 1, `Not64Bit` 1(Stel)
- **W 산술·읽기쓰기**: `f_LMov` 762/36, `f_LAdd` 234/8, `_LMul` 93/4, `_TLMem` 78, `f_LSub` 75/14, `f_LMul` 59/7, `_LAdd` 41/2, `_LDiv` 37/6, `f_LDiv` 33/4, `_Cast` 32/9, `f_Cast` 31/16, `f_LRead` 23/6, `_LSub` 15/6, `f_LMovX` 11/13(UERE), `f_LMod` 9/3, `f_LXor` 7/5, `_LMov` 6/4, `_LMod` 5, `f_LRand` 5, `f_LWrite` 5, `f_LiSub` 4/1, `Include_64BitLibrary` 3/3, `_LRead` 3, `_LXor` 2/1, `_LRand` 1/1, `f_LNeg` 1/1, `f_LOr` 2, `_LNeg` 1, `_LOr` 1. **0회**: `f_LAnd` `f_LNot` `f_LlShift` `f_LAbs` `f_LiMul` `f_LiDiv` `f_LiMod` `f_LDiff` `f_iCast` `LPush` `LPop`
- **W 조건·액션·비교**: `SetNWar` 239/9, `TTNWar` 186/28, `TTLMemory` 74, `NWar` 20, `_TTNWar` 11, `SetCWar` 9/2, `_TTLMemory` 7, `TTCWar` 6/10(UERE), `SetCWAar` 4, `SetLMemX` 3, `TTLMemoryX` 2. (DPS 수치는 `eud\spec\G3_war.md:18~42` 와 같다.)
- **DisplayPrint 틀**: `DisplayPrint` 470/27 (9맵), `DisplayPrintEr` 97/3 (7맵), `DisplayPrintTbl` 96 (DPS 83, Seed 1, ResV 12), `_0DPatchforVArr` 9/11, `DP_Start_init`·`init_Setting` 각 9 (9맵, 설치 1회), `print_utf8_A` 4, `DisplaySTRX` 2. `dp.*` 직접 호출 0.
- **ItoCustom 류**: `CS__ItoCustom` 38/10 (Seed,Stel,ResV,Mem2,UERE), `CA__ItoCustom` 16/5 (Mem2,UERE), `CS__lItoCustom` 1/1 (UERE), `CA__lItoCustom` 0/5 (NTM1·NTM3 만)
- **ItoDec 류**: `ItoDec` 20/41, `ItoDecX` 0/4. `ItoHex` `ItoHexX` `ItoX` 0회.
- **iStr 준비**: `SVA1` 205/92, `SetCSVA1` 107/33, `MakeiStrVoid` 31/21, `GetiStrSize` 27/8, `MakeiStrLetter` 26/14, `SaveiStrArrX` 25/15, `CSVA1` 18/15, `SaveiStrArr` 14/7, `GetiStrId` 5/4, `MakeiStrWord` 5/3
- **CA__ 편집(효과 외)**: `CS__InputVA` 46/16, `CS__SetValue` 37/14, `CA__SetValue` 28/28, `CA__SetMemoryX` 12/7, `CA__InputVA` 9/11, `CD__InputVAX` 9/9, `CA__SetNext` 6/4, `CA__Input` 4/1, `CD__InputMask` 3/3, `CA__InputSVA1` 3/6, 그 밖 1회씩
- **파일 삽입**: `f_GetFileArrptr` 28/23, `FArr` 23/9, `f_GetVoidptr` 10/8 (7맵), `f_GetVArrptr` 8/10, `f_GetFileArrptrN` 6(Seed), `SaveFileArr` 5/5, `f_GetFileptr` 5/5
- **입력**: `KeyPress` 75/42, `TTKeyPress` 1, `TTMousePress` 1 (둘 다 ResV), `MousePress` 0. `MSQC_KeyInput` 35/2(DPS), `MSQC_TKeyInput` 23(Seed), `MSQC_KeySet` 19, `MSQC_ExportEdsTxt` 1
- **부호**: `iAtLeast` 2/1, `iAtMost` 2. (참고) `f_SHRead` 70/8, `CiSub` 52/37, `_iSub` 50/23, `_iMul` 19/2, `_iDiv` 15/3, `CNeg` 14/4, `_SHRead` 10, `CiDiv` 8, `_Neg` 6, `f_Abs` 2, `f_iDiv` 1, `f_iMul` 1
- **수학**: `f_Lengthdir` 100/36 (8맵), `f_Atan2` 3, `f_Sqrt` 4, `_Square` 8 (참고 G_CB_Lib 6), `f_CRandNum` 77/27, `Include_CRandNum` 7/5, `f_Sqrd` 4(Mem2)
- **CSMake***: `CSMakeCircle` 159/128, `CSMakeStar` 121/61, `CSMakeLine` 101/92, `CSMakePolygon` 88/85, `CSMakePath` 74/48, `CSMakePolygonX` 21/2, `CSMakeStarX` 11, `CSMakeGraphT` 10/10, `CSMakeLineX` 9/3, `CSMakeSpiral` 5/2, `CSMakeCircleX` 2, `CSMakeGraphX` 0/2
- **CS_* 상위 20**: `CS_Level` 244/50, `CS_MoveXY` 199/127, `CS_RatioXY` 160/77, `CS_OverlapX` 82/58, `CS_FillPathXY` 64/61, `CS_ConnectPathX` 53/60, `CS_MoveCenter` 46/38, `CS_Rotate` 44/52, `CS_Merge` 43/24, `CS_DoubleSortRA` 28/8, `CS_SortY` 26/8, `CS_SortR` 24/18, `CS_ConnectPath` 24/7, `CS_RemoveStack` 17/13, `CS_SortA` 17/14, `CS_SortX` 16/10, `CS_CropXY` 13/11, `CS_MirrorX` 13/6, `CS_Overlap` 13/1, `CS_FillPathHX2` 12/5 (그 밖 21개는 주요 맵 합 10회 미만)
- **찍기**: `CSPlot` 113/121 (Seed,ResV,Mem2,G2R,UERE,Brz — UERE 97), `CSPlotAct` 8/9, `CAPlot` 19/6, `CAPlotForward` 14/8, `CAPlot2`(맵 재정의) 4/5, `CXPlot` 2/1, `CBPlot` 1/3, `CA_Rotate3D` 10/6, `CA_RatioXY` 9/3, `CA_Rotate` 5/1. `CSSave`·`CSLoad`·`CVPlot` 0.
- **CreateUnitShape**: `CreateUnitPolygonSafe2Gun` 165/132, `…Safe2GunMove` 69/81, `CreateUnitLine` 48/20, `CreateUnitLineSafeGun` 31, `CreateUnitLineSafeGunMove` 12, `CreateUnitStarSafeGun(Move)` 11/42 (거의 Mem1·구 GaLaXy)
- **G_CB/G_CA API**: `G_CB_TSetSpawn` 542/420, `G_CB_SetSpawn` 393/233, `f_TempRepeat` 297/185, `G_CB_SetSpawnX` 128, `f_TempRepeatX` 72/9, `G_CB_SetSpawn2X` 52, `T_to_BiteBuffer` 28/12, `f_TempRepeat2X` 15, `G_CB_TScanEff` 0/183(MEME), `G_CA_SetSpawn` 등 509/198
- **EXCC**: `Set_EXCC2` 99/28, `Cond_EXCC` 51/2, `Set_EXCCX` 37/16, `EXCC_BreakCalc` 33/12, `EXCC_ClearCalc` 32/7, `Install_EXCC`·`EXCC_Part1~4X`·`EXCC_End` 각 12/5, `Set_EXCC` 12, `Set_EXCC3`(템플릿 추가 함수) 11, `Cond_EXCC2` 7/3, `Set_EXCC2X` 5/2
- **TStruct**: `TS_SendX` 18, `TSLine` 15, `SetTSLine` 7, `TS_Suspend` 4, `TS_CreateArr`·`TStr_Func`·`TStr_EndFunc`·`TStruct_init` 각 3 (Seed·UERE 만)
- **BGM**: `AddBGM` 44/36 (Mem2,UERE), `IBGM_EPD` 5/3, `NormalTurboSet` 4/2, `Install_BGMSystem` 2/2, `IBGM_EPDX` 2/1
- **SCR_DB**: `SCRDB_Addr` 8, `SCRDB_Setup`·`Anchor`·`Notify`·`Receiver`·`SaveSignal`·`WriteManifest` 각 2 (DPS,UERE), `SCRDB_CloseLoad` 1

### 1-b. DPS 128비트 (호출 쪽만, `math128.lua`·`converter.lua` 내부 제외)

`SetNumX128`(DisplayPrint 원소) 36, `f_LMov128` 24, `f_LAdd128` 24, `f_LMul128_2` 17, `f_LDiv128` 17, `Compare_128` 9, `f_LMul128X` 8, `SetNumTBLX128` 7, `f_LMul128` 6, `f_LSub128` 5, `f_LAdd192` 3, `SetNumX256` 3, `Compare_192`·`Compare_256`·`f_LSub256`·`SetNumTBLX256` 각 1 → **합 163**. 쓰는 파일: `CallTriggers.lua`, `GameDisplay.lua`, `CallTriggers\gameplay\mine.lua`, `items\token.lua`·`fragment.lua`, `unit\damage_check.lua`·`combat.lua`, `auto\sell_refactored.lua`, `TBL.lua`, `function.lua`, `GlobalBoss.lua`, `economy\money.lua`.

### 1-c. 표에 없던 관용구 (주석 제외 정규식 수, 정의 줄 제외. 주소 상수 줄은 쓰인 횟수)

| 관용구 | DPS | Seed | Stel | ResV | Mem2 | Mem1 | G2R | UERE | Brz | Tpl | 주요 합 | 그 밖 합 |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| CP 주소 `0x6509B0` 직접 사용 | 164 | 62 | 65 | 100 | 135 | 148 | 658 | 302 | 36 | · | 1670 | 2320 |
| `SetCp`/`TSetCp`/`AddCp` | 206 | 15 | 29 | 89 | 24 | 10 | 12 | 23 | 30 | 1 | 439 | 76 |
| `MoveCp`(CP 상대 이동) | 1 | 11 | 10 | 10 | 30 | 171 | 73 | 23 | 16 | · | 345 | 134 |
| `f_SaveCp`/`f_LoadCp` | 10 | 12 | 40 | 44 | 68 | · | 27 | 33 | 18 | · | 252 | 84 |
| `RotatePlayer`(플레이어마다 CP 바꿔 액션) | 93 | 45 | 69 | 86 | 109 | 173 | 42 | 98 | 68 | · | 783 | 250 |
| `DisplayTextX`/`PlayWAVX` 류 | 106 | 58 | 157 | 249 | 309 | 485 | 191 | 269 | 170 | · | 1994 | 663 |
| `CopyCpAction` | · | · | · | · | · | · | 40 | 1 | · | · | 41 | 49 |
| `0x628438`(방금 만든 유닛 포인터) | 41 | 8 | 6 | 21 | 56 | 29 | 40 | 73 | 34 | 3 | 311 | 149 |
| 그중 `f_Read(FP,0x628438,…)` | 21 | 4 | 2 | 7 | 24 | 13 | 16 | 33 | 15 | 1 | 136 | 51 |
| `Nextptrs` 변수 참조 | 60 | · | 5 | 33 | 125 | 61 | 64 | 120 | 45 | 5 | 518 | 207 |
| `Simple_SetLoc`/`Simple_CalcLoc` | 23 | 21 | 14 | 73 | 132 | 54 | 30 | 141 | 88 | 3 | 579 | 195 |
| `GetLocCenter` | · | 1 | 3 | 5 | 2 | · | 17 | 53 | 25 | · | 106 | 72 |
| `CreateVarArr`/`CreateWarArr` 류(플레이어 수만큼 배열) | 192 | 13 | 17 | 57 | 78 | 37 | 40 | 35 | 23 | 2 | 494 | 172 |
| `for i=0,6/7 do` 플레이어 반복 | 10 | 32 | 2 | 3 | 12 | 2 | · | 69 | 32 | · | 162 | 117 |
| `Gun_Line`/`Gun_SetLine`(건물 스택 슬롯 변수 줄) | · | · | · | 774 | 735 | · | 388 | 401 | · | · | 2298 | 974 |
| `PatchInsert*`(시작 시 dat 패치 목록) | 101 | 137 | 1 | 98 | 79 | · | · | 23 | 86 | 89 | 614 | 482 |
| `SetUnitsDatX`/`SetWeaponsDatX`/`SetUnitAbility` | 41 | 43 | 45 | 140 | · | · | · | · | 64 | 3 | 336 | 140 |
| `StrDesign`/`StrDesignX`(컴파일 때 색 문자열 꾸밈) | 433 | 43 | 50 | 80 | 54 | · | 1 | 9 | 65 | · | 735 | 43 |
| `PVWArrX`/`PVtoV`/`VtoPV`(DPS 플레이어별 V·W) | 1962 | · | · | · | · | · | · | · | · | · | 1962 | 31 |
| `CreateDataPV/PW/NPV/NPW`(저장 변수 등록) | 599 | · | · | · | · | · | · | · | · | · | 599 | 23 |
| `Void`/`SetVoid`(공메모리 슬롯) | · | · | · | · | · | · | 1 | 783 | · | · | 784 | 766 |
| `SetCtrigX`/`SetCtrig1X`/`2X`(트리거 자기수정) | 66 | 8 | 4 | 11 | 17 | 15 | 19 | 11 | 9 | 1 | 161 | 61 |
| `×604`/`×2416`/`×0x970` 번호 산술 | 12 | · | · | 5 | 7 | · | · | 13 | · | · | 37 | 29 |
| `TTOR`/`TTAND` | 64 | 3 | 6 | 22 | 26 | 14 | 12 | 24 | 17 | · | 188 | 37 |
| `0x68C144`(채팅 중) 원시 조건 | 14 | 1 | · | 9 | · | · | · | 3 | · | · | 27 | 22 |
| `0x6CDDC4/C8`(마우스 좌표) | 4 | 2 | · | 2 | · | · | · | · | · | · | 8 | 0 |
| `0x57EEE8/EB`(플레이어 이름칸) 원시 | 5 | 3 | 3 | 3 | 2 | 6 | 4 | 3 | · | · | 29 | 10 |
| `KeyInput`/`CIfKey`/`KeyActions`/`KeyToggleFunc*`(사용자 키 래퍼) | 2 | 19 | · | · | · | · | · | 13 | · | · | 34 | 71 |
| `CreateEffUnit*`(이펙트 유닛) | · | · | · | · | 107 | · | · | · | · | 4 | 111 | 48 |
| `CreateHeroPointArr`(영작 표) | · | · | · | · | 43 | 32 | · | 24 | · | · | 99 | 20 |
| `StoryPrint` 류 | · | · | · | · | 30 | 45 | · | 23 | · | · | 98 | 14 |
| `f_Memcpy`/`f_Movcpy`/`f_GetStrXptr`/`CreateCText` | 29 | 3 | 5 | 12 | 20 | 33 | 97 | 21 | 9 | · | 229 | 373 |
| `CreateUnitQueue*`/`CreateUnitStack*` 이름(주석 포함 grep, 대략) | 29 | 2 | · | 105 | 40 | · | 19 | 67 | 58 | · | 320 | — |

---

## 2. 실제 인자 모양 (파일:줄, 경로는 0절 약칭 기준)

### 2-a. 64비트 W
- 선언은 항상 FP 하나: `CreateWar(FP)` DPS `CallTriggers.lua:24`, `CreateWarArr(2, FP)` DPS `CallTriggers.lua:339`, `CreateWarArr(7,FP)` UERE `Var_Include.lua:422`. 초기값 넣는 `CreateWar2` 는 1회.
- **상수는 10진 문자열**, 32비트 값은 `{V,0}` 로 올려서 넣는다:
  - `f_LSub(FP, PVWArrX(iv.FfragItem), PVWArrX(iv.FfragItem), "1000000000000000000")` DPS `CallTriggers.lua:453`
  - `f_LAdd(FP,PVWArrX(iv.B_PFfragItem2),PVWArrX(iv.B_PFfragItem2),{PVWArrX(iv.B_PFfragItem),0})` DPS `CallTriggers.lua:406`
  - `f_LMov(FP, {TempV1,TempV2}, _LSub(TempW,tostring(8320000*256)), nil, nil, 1)` UERE `CallTriggers.lua:301` — 출력이 `{V,V}` 쌍, `Clear=1`
- 임시식 중첩: `f_LMul(FP,PVWArrX(iv.TempIncm),_LDiv(PVWArrX(iv.TempIncm),"10"),_LAdd({PVWArrX(iv.FXIncm),0},"10"))` DPS `CallTriggers.lua:323`; `_LMul(_LDiv(TempLvHP_L4, "256"), {HPMul,0})` UE `CallTriggers.lua:225`
- 비교: `TTNWar(TempFfragGet,AtLeast,"1000000000000000000")` DPS `CallTriggers.lua:437`, `TTNWar(EnchMoney,AtLeast,EnchCost)`(W 대 W) NTM3 `CallTriggers.lua:123`, `TTLMemory(_TLMem(PVWArrX(iv.B_AwakItem)),AtLeast,"1")`(배열 원소 포인터) DPS `CallTriggers.lua:502`, `TTCWar(FP,TempLvHP_L4[2],AtLeast,"2129920000")` UERE `CallTriggers.lua:252`
- 대입·변환: `SetNWar(WI,SetTo,{0,0})` DPS `CallTriggers.lua:36`; `f_Cast(FP,{ECV,0},ECW)`(W 하위 → V) DPS `CallTriggers\auto\sell_refactored.lua:484`
- 배열: `WArrX(GetUnitVArr[i+1], WI,WI4)`(번호를 ×604·×2416 해 둔 변수) DPS `CallTriggers.lua:49`; `SetNWar(WArrL, SetTo, {604*i,604*i})` UERE `CheatTest.lua:23`; `f_LRead(FP, LArrX({EXPArr_dp},LocLIndex), TempW, nil, 1)`(파일 표 원소) DPS `CallTriggers\gameplay\boss.lua:76`
- UE/UERE 의 64비트는 **체력 넘침** 용도: `TempLvHP_L*` (`CallTriggers.lua:244~254`), `CABoss(SBossPtr,nil,{0,BinitT,2,"12800000000",8320000,1},…)` UERE `Sans.lua:521`
- 128비트 흐름 (DPS `CallTriggers.lua:337~342`): `f_LMul128_2(PVWArrX(a),PVWArrX(b))` → `f_LDiv128(FFRet,{"100","0"})` → `f_LMov128(FP, XRet, {DRetT[1],DRetT[2]})` → `DisplayPrint(GCP, {"…",{SetNumX128,XRet}})`. 192비트 누적 `Math128.f_LAdd192({a,b,c}, {retMul[1],retMul[2],"0"})` DPS `CallTriggers\gameplay\mine.lua:202`.

### 2-b. 숫자 서식·출력
- DisplayPrint 원소는 문자열·V·W·`PName(p)`·`{서식함수, 값, 옵션}`:
  - `DisplayPrint(Force1, {"\x13\x04CurUID : ",TempUID," CT_CUnit : ",TempV,…})` DPS `CUnit.lua:147`
  - `DisplayPrint(GiveNextP, {"\x12\x07『 ",PName(GivePrevP),"\x04에게 \x1F",GiveMin," Ore…"})`(대상이 V) ResV `CallTriggers.lua:10`
  - `DisplayPrint({P1,P2,P3,P4,P5}, {"…",TestW})`(W 원소) Mem1 `Main.lua:1892`
  - `DisplayPrintEr(GCP, {"…", {SetNumErX, TempCostV, 1}, "…"})` DPS `CallTriggers\items\crystal.lua:307`
  - `DisplayPrintTbl(KickVoteTblIDs[k], {…, PName(…), …}, nil, 1)` Seed `MapLogic\KickVote.lua:103`
  - DPS 원소 집계는 `eud\spec\G8_text_scrdb.md:488,522,562` 에 이미 있다(`{SetNumX,…}` 62, `{SetEPerSTRX,…}` 46, `{SetNumX128,…}` 32 등).
- `ItoDec(PlayerID,Input,OutVA,ZeroMode,Color,Sign,DigitMax,DigitMin)`:
  - `ItoDec(FP,CurrentFactor,VArr(UpCompTxt,0),2,0x1F,0)` G2R `main.lua:719` (0 채우기 모드 2, 색 0x1F)
  - `ItoDec(FP,BRX,VArr(BRXT,0),1,nil,2)` UERE `TestTriggers.lua:104` (부호 모드 2)
  - `ItoDecX(FP,ReadScore,VArr(GetPVA,0),2,0x7,2)` UE `CallTriggers.lua:455`
- `CA__ItoCustom(SVA1,Input,Output,Mask,Base,Length,Init,Sign,ColorArr,IndexArr,DataArr,ClearArr,utf8flag)` (가이드북 6748):
  - `CS__ItoCustom(FP, SVA1(Str1, 0 + 5), SelHP, nil, nil, {10,10}, 1, nil, "\x040", 0x04, {0..9}, nil, nil, 1)` Seed `MapLogic\SelectedUnitInfo.lua:254` — 10진 최대 10자리, 0일 때 `"\x040"`, 색 0x04, UTF-8. 같은 줄이 Stel `MapLogic\System.lua:2366`, ResV `System.lua:158`, Mem2 `Interface.lua:856` 에 있다(선택 유닛 체력 표시 복붙).
  - `CA__ItoCustom(SVA1(Str1,0),TimeV,nil,nil,{10,6},1,{"\x07０","\x07０","\x0F０",…},nil,{0x07,0x07,0x0F,0x0F,0x1F,0x1F},{11,12,14,15,17,18},Data)` Mem2 `Operator.lua:580` — 전각 숫자, 자리마다 색, 자리 위치 표
  - `CA__lItoCustom(SVA1(Str1,0),KillW,nil,nil,10,1,nil,{"\x1F\x0D","\x08\x0D","\x040"},{색 20개},{0,1,3,4,5,7,…})` NTM1 `Interface.lua:97` — 64비트, 부호 있는 모드, 세 자리 묶음마다 색·빈칸
  - `CS__lItoCustom(FP, SVA1(Str3,0), TempW5, nil, 0xFFFFFF00, 10, 1, nil, {…}, nil, {…}, nil, {0,{0},0,…})` UERE `Player_interface.lua:1711`
- 채팅 줄 상수 출력: `print_utf8(12,0,StrDesign("\x04정상적으로 스탯을 증강하였습니다."))` DPS `CallTriggers\economy\stat_shop.lua:56`; `print_utf8(12, 0, "\x07[ LV.0000\x1F - 00h …]")` UERE `Operator.lua:8`
- 채팅 인식 효과 블록(5맵 복붙): `CD__ScanChat(SVA1(HStr2,CurLiV),ChatOff,52,ChatSize,0,1)` Mem2 `Operator.lua:493` + `CDPrint(0,11,{"\x0D",0,0},{Force1,Force2,Force5},{1,0,0,0,1,1,0,0},"HTextEff",FP)` Mem2 `Operator.lua:521` (같은 것: ResV `GunData.lua:2908/2936`, UERE `CallTriggers.lua:971/1026`, UE `Destr0yer.lua:623/651`, NTM1)
- `CAPrint(iStr1,{Force1},{1,0,0,0,1,1,0,0},"StatusInterface",FP,{CD(DeleteToggle,0)})` UERE `Player_interface.lua:199`

### 2-c. 글자 효과
- `CA__MoveXY`/`ConvertColor`/`ConvertLetter`/`Encode` 는 어느 맵에서도 부르지 않는다.
- 쓰는 것은 버퍼 칸 쓰기뿐: `CS__InputVA` 46, `CS__SetValue` 37, `CA__SetValue` 28 (예: Seed·Stel·ResV 의 선택 유닛 정보 줄 조립).

### 2-d. 총알·스프라이트
- **28장 라이브러리 함수 호출은 0회.** `CreateBullet` 을 부르는 맵 6곳(Mem2, Mem1, G2R, UERE, GaLaXy.2, UE)은 모두 자기 `CreateBullet` 을 정의해 쓴다. 서명이 라이브러리와 다르다:
  - Mem2 `func.lua:2023` `CreateBullet(UnitId,Height,Angle,XY,Player)` — 인자를 CVar 에 넣고 `SetNextTrigger(Call_CBullet)`
  - Mem2 `func.lua:2263` `CreateBulletXY(UnitID,Height,XY,TargetXY,ForPlayer)` — 본체 `2283~` 에서 `f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)` → `f_Atan2(FP, _iSub(CB_Y,CB_TY), _iSub(CB_X,CB_TX), Angle_T)` → 360→256 방향 표 `FArr(DCtoSCFArr,Angle_T)` → `TSetMemoryB(0x656990, …)`(유닛 dat 바꿔 만들기)
  - UERE `func.lua:21` `CreateBullet(UnitID,Height,Angle,X,Y,ForPlayer)`, Mem1 `Main.lua:1042` `CreateBullet(Height,Angle,X,Y)`
- 호출 모양: `CreateBullet(206,20,f_CRandNum(256),{CPosX,CPosY},P7)` Mem2 `BossTrig.lua:245` (각도 0~255); `CreateBullet(208,20,0,_iSub(_Add(CPosX,TS_VarArr[3]),TS_VarArr[20]),…)` UERE `CallTriggers.lua:868`; `CreateBulletXY(206,20,{CPosX,CPosY},{2048,2048},FP)` Mem2 `GunData.lua:3274`; `CreateBulletCond(207,20,0,{2048-(24*32)+(32*i),2048-500},FP,{CV(PattV[1],1,AtLeast),…})` Mem2 `GunData.lua:3328`
- dat 수정: `SetImageColor(588, 16)` DPS `CallTriggers\items\crystal.lua:199`, `SetImageScript(937, 335)` 같은 파일 `:239`, `SetImageScript(140, 82)` ResV `Interface.lua:2142`
- 파일 삽입: `f_GetFileArrptr(FP, HashCol, 4, 1)` DPS `DonorLookup.lua:131`, `f_GetFileArrptr(FP, EncodeButtonSet(…), 1, 1)` Seed `MapLogic\ButtonSetPatch.lua:253`, `f_GetFileptr(FP, "expdata", 1)` DPS `Variables.lua:903`, `FArr(DCtoSCFArr,Angle_T)` Mem2 `func.lua:2296`

### 2-e. 입력
- `KeyPress("F12", "Down")` DPS `CallTriggers\gameplay\gacha.lua:306`; `KeyPress(K, "Down")`(Lua 변수에 키 이름) Seed `MapLogic\Combination.lua:712`; `KeyPress(KeyArr[1],"Up")` ResV `System.lua:1457`
- 누름 순간: `TTKeyPress("C","Down")` ResV `System.lua:143`, `TTMousePress("LEFT","Down")` ResV `System.lua:144` (둘 다 여기 한 번씩). DPS 는 직접 짠다: `KeyToggleFunc2("TAB","LCTRL")` DPS `GameDisplay.lua:113` (정의 `function.lua:1081~1110` — `Memory(0x68C144,Exactly,0)` + `KeyPress` Up/Down + Ccode 토글)
- MSQC 키(동기화): `MSQC_KeySet("O",494)` DPS `Variables.lua:530`, `MSQC_KeyInput(CurrentPlayer, KeyID)` DPS `CallTriggers\economy\stat_shop.lua:84`, `MSQC_TKeyInput(SetupAuthorityPlayer,"P")`(플레이어가 V) Seed `MapLogic\SetupMenu.lua:258`. 정의는 DPS `function.lua:1042~1056`(= Seed `Engine\func.lua:1590~`): 키 이름 → 데스 유닛 번호 표, `Deaths(P, Exactly, n, unit)`. UERE 는 `KeyInput(F12,{…},{…})` `Operator.lua:364` (정의 `func.lua:371`, 데스값 확인 후 0 으로 지움)
- 마우스: `mouseX = dwread_epd(0x6CDDC4)` DPS `CallTriggers\ui\mouse.lua:16`, ResV `System.lua:81`; Seed `MapLogic\MouseInput.lua:81~88` 은 화면+스크롤을 더해 스크래치 주소에 쓰고 NSQC 로 동기화
- 타이핑 중 판정은 함수 대신 원시 조건 `Memory(0x68C144,Exactly,0)` (DPS `function.lua:1083` 등 27곳)

### 2-f. 부호 있는 비교
- `TTNVar(TotalScore, iAtLeast, OutputPoint)` UERE `Destr0yer.lua:645`, `Player_interface.lua:191`
- `TTLoc(DirLoc2, "R",iAtMost,MapSizeX)` Mem2 `CallTrigger.lua:767`, `:774`
- `TTNWar(TempW3,iAtLeast,"1")`(64비트 부호, "음수가 아니면") NTM3 `function.lua:1687`
- 문자열형 `"i>="` 은 0회. 부호 있는 값 자체는 흔하다: `CiSub(FP,Dy,_Mov(0xFFFFFFFF),Dx)` Mem1 `Main.lua:1113`, `f_SHRead(FP, _Add(CreateUnitQueueXPosArr,CreateUnitQueuePtr2), QPosX)`(부호 16비트 좌표 표) UERE `Gun_System.lua:382`

### 2-g. 삼각·수학
- **Cycle 은 모든 맵이 360.** `Include_CtrigPlib(360,"Switch 100")` DPS `main.lua:78`, Seed `main.lua:170`, Stel `main.lua:91`, ResV `main.lua:56`, Mem1 `Main.lua:643`, UERE `main.lua:107`, Brz `main.lua:87`. 고정밀(LengthdirX=1)은 Mem2 한 곳: `Include_CtrigPlib(360,RandSwitch,1)` Mem2 `main.lua:123`. G2R `main.lua:100` 은 `360,RandSwitch`.
- `f_Lengthdir(FP, SpawnRingRadius, _Div(RingAngle64, _Mov(64)), RingOffX, RingOffY)` Seed `MapLogic\RandomPlacement.lua:1526`
- 음수 반지름: `f_Lengthdir(FP, -32*25, TS_VarArr[6], CPosX, CPosY)` UERE `CallTriggers.lua:722`
- 360 을 넘길 수 있는 각도: `f_Lengthdir(P6,2000,_Add(N_A1,180),L_X,L_Y)` Mem1 `Main.lua:1378`; `f_Lengthdir(FP,N_R,_Add(N_A,TempRand),N_X,N_Y)` Tpl `CallTriggers.lua:179`
- `f_Atan2` 3회는 전부 사용자 `CreateBulletXY` 안: Mem2 `func.lua:2292`, UERE `func.lua:91`, Brz `func.lua:2075`
- `f_Sqrt(FP, SpeedRet, _Div(_Add(_Square(_iSub(CPosX,NPosX)),_Square(_iSub(CPosY,NPosY))),_Mov(2)))`(거리) Stel `MapLogic\System.lua:1240`, ResV `System.lua:769`
- `f_CRandNum(Max,Operand,Condition)`: `f_CRandNum(360)` Tpl `CallTriggers.lua:176`, `f_CRandNum(1600,200,{Void(41,Exactly,3)})` UERE `DemonicEmperor.lua:961`, `f_CRandNum(0x7FFFFFFF)` Seed `MapLogic\SeedSystem.lua:324`

### 2-h. CX Paint
- 도형 만들기(컴파일 시점): `CSMakeCircle(6, 32, 0, CS_Level("Circle", 6, 3), 0)` Seed `MapConfig\Shape.lua:83`; `CSMakeStar(4, 135, 160, 45, PlotSizeCalc(4*2, 4), 0)` ResV `GunData.lua:2491`; `CSMakePath({-160,-160},{160,-160},{160,160},{-160,160})` Mem2 `ShapeData.lua:45`
- 편집 중첩·실수 배율: `CS_MoveXY(CS_Rotate(CS_RatioXY(CSMakeCircle(51, EarR, 0, 52, 1), 1, 0.3), 70), 601, 1200)` Seed `MapConfig\Shape.lua:392` (같은 식 Stel `MapLogic\GunShape.lua:145`)
- `CS_Level("Star",4,2)` 는 점 개수 계산용(Stel 에만 200회)
- 찍기:
  - `CSPlot(CSMakeStar(4, 135, 128, 45, nc, hc), i, 91, 0, nil, 1, 32, FP, {MemoryB(0x58D2B0+(i*46)+17, Exactly, j)}, {}, 1)` ResV `Interface.lua:1988`
  - `CSPlot(EffShape1,i,84,0,{TempleXY[i-3][1],TempleXY[i-3][2]},1,32,FP,{Label(),GCP(i),Gun_Line(20,AtMost,0)},{Gun_SetLine(20,SetTo,1)},1)` Mem2 `GunData.lua:469`
  - `CSPlot(CSMakePolygon(8,128,90,9,1),FP,"Edmund Duke (Siege Mode)","Last Boss 93",nil,1,32,FP,{Void(41,AtLeast,4)},nil,1)`(유닛·로케이션을 이름 문자열로) UERE `DemonicEmperor.lua:1249`
  - `CSPlotAct(NeShape,j,182,"S"..j+1,nil,1,32,32,nil,FP,HumanCheck(j,1),{Order(182,j,64,Patrol,64)},1)` G2R `main.lua:6089`
  - `CAPlot({CSMakePolygon(8,256,0,9,1),CS_OverlapX(…)},FP,nilunit,0,{SHLX,SHLY},1,16,{1,0,0,0,9999,1},"CA_Eff",FP,nil,nil,1)` Mem2 `CallTrigger.lua:607` + CAfunc 안 `CA_Rotate3D(CA_Eff_XY,CA_Eff_YZ,CA_Eff_ZX)` `:419`
  - Seed `Engine\CAPlotIndexed.lua` = CB Paint `CBPlot` 사본을 좌표 FArr 방식으로 바꾼 것(`FArr(CBPlotFXArr,V(CA[1]))` `:283`)
- 도형 유닛 생성(구판 위주): `CreateUnitPolygonSafe2Gun(P6,{Deaths(P7,Exactly,1,"【 Anomaly 】")},1+(…),23,32,Radius,Angle,Points,1,P6,{1,19,1,84})` Mem1 `Main.lua:2017`; `CreateUnitPolygonSafe2Gun(FP,Always(),19,0,32,64,30,6,1,P8,{1,51})` G2R `main.lua:3748`
- 사용자 스포너(G_CB): `G_CB_TSetSpawn({CD(GunTrigGCcode,9600//0x1D,AtLeast)}, CUT[1], SH_Warp, P6, SummonBossLoc, 1, {LMTable="MAX"})` Stel `MapLogic\GunFunc.lua:23`; `G_CB_TSetSpawn({Gun_Line(5,Exactly,0),CD(GMode,3)}, CUTable1, _G[ShapeSC], nil, {OwnerTable=P7,RotateTable="Main",RepeatType={"Patrol_Gun",…}})` ResV `GunData.lua:418`; `G_CB_SetSpawn({CVar(FP,LevelT[2],Exactly,1),Gun_Line(5,Exactly,0),…},{38,43},"CC_L",nil,nil,nil,nil,{48*32,96*32},nil,1)` UERE `Gun_SpawnSet.lua:14`; `f_TempRepeat({CD(UTAGECcode,0)}, 21, 1, 187, FP, {1536*2,1920*2})` Brz `System.lua:192`; `G_CA_SetSpawn({},{128},"ACAS","Warp1",nil,3,nil,P8,nil,6+12+18)` Mem2 `BossTrig.lua:338`

### 2-i. 기타
- 사람·로컬 판정: `HumanCheck(i,1)`(10맵, 거의 이 모양), `LocalPlayerID(i)`
- 이름: `isname(Player,ID)` DPS `OnInit.lua:126`, `isname(i,"GALAXY_BURST")` Mem1 `Main.lua:9502`; `ItoName(FP,i,VArr(Names[i+1],0),ColorCode[i+1])` DPS `OnInit.lua:309`(같은 줄 7맵); `GetPlayerLength(FP, Player, RawNameLen)` + 원시 `0x57EEEB+0x24*Player` Seed `MapLogic\ChatSeedInput.lua:176~177`; `SetUnitName(UnitID, GetStrId(Name))` Seed `MapLogic\UnitNaming.lua:124`
- 관전자 채팅: `ObserverChatToAll(FP,0x58D740+(20*59),i,"HOME",10,nil,{SetMemory(0x6509B0,SetTo,i),DisplayText(…),…})` Stel `MapLogic\System.lua:2885` (ToNone·ToOb 와 함께 ResV `Interface.lua:2840`, Mem2 `Interface.lua:991`, Brz `Interface.lua:1166` 에 같은 블록); `ObserverChatToAllAlways(FP)` Seed `MapLogic\ObserverChat.lua:15`
- `ExitDrop(FP, i)` GaLaXy.R `System.lua:698`, `:702` (구판만)
- 방장 이름 주소는 eps 쪽에만: `const b = 0x6D0F78;` DPS `SCAInterface.eps:233`
- 설치 1회: `EUDTurbo(FP)`, `NoAirCollisionX(FP)`, `Enable_HideErrorMessage(FP)` 가 각 맵 `main.lua` 에 한 번씩

### 2-j. "대체" 후보
- TStruct: `TStruct_init(FP, GunPoolSize, #GunFieldNames, HumanPlayers)` Seed `MapLogic\GunSystem.lua:1044`, `TStruct_init(FP,32,20,HumanPlayers)` UERE `main.lua:120`; `TS_SendX({}, BoneBullet, {CPosX,CPosY})` UERE `Sans.lua:67`; `TSLine(15, Exactly, 0)` UERE `CallTriggers.lua:717`; Seed 는 필드 이름표로 감싼다 `TSLine(GunFieldLine(Name), Type, Value, Mask)` `GunSystem.lua:89`
- 건물 스택(`Gun_Line`): 조건 `Gun_Line(5,Exactly,0)`, 액션 `Gun_SetLine(20,SetTo,1)` Mem2 `GunData.lua:469`. 정의 ResV `GunData.lua:261~289`(`Include_GunData` 안) / UERE `func.lua:532~550` — `Var_TempTable[Line+1]`(건물 하나를 실행할 때 복사해 오는 슬롯 변수)에 대한 `CVar`/`TSetCVar`. 슬롯 순회는 `Install_GunStack`(ResV `GunData.lua:292~`)이 `SetCtrigX` 로 값을 옮긴다.
- EXCC: `Install_EXCC(FP,25,1)` Seed `main.lua:167` (줄 수 3~25, DPS `FP,6,nil`); `Set_EXCC2(DUnitCalc,CunitIndex,1,SetTo,1)` Stel `MapLogic\System.lua:624`; `Set_EXCC2(CT_Cunit,CurCunitI,0,SetTo,_Xor(CT_GNextRandV,PBossIDB))` DPS `CallTriggers\gameplay\boss.lua:43`; `Cond_EXCC(6,Exactly,1,1)` Stel `System.lua:1150`; `Set_EXCC3(DUnitCalc,ResetUnitI,p-1,SetTo,0)` Tpl `CallTriggers.lua:23`
- CunitCtrig: `CunitCtrig_Part1(FP)` G2R `System.lua:8`, UERE `Gun_System.lua:182`, Brz `Waves.lua:816`
- BGM: `AddBGM(1,"staredit\\wav\\GRAVITY_OP.ogg",94*1000,{1,5})` UERE `func.lua:220`; `Install_BGMSystem(FP,6,BGMTypeV,12,1)` UERE `func.lua:259`; `IBGM_EPD(FP, {P1,…,P12}, BGMType, {{1,"…BrOP.ogg",188*1000},{2,{"…BGM1_1.ogg","…BGM1_2.ogg"},45*1000},…})`(곡 하나를 조각 여러 개로) Brz `Interface.lua:25`
- SCR_DB: `SCRDB_Setup({ SaveKey=…, Fields=…, AnchorBase=…, Humans=…, Channels=…, MsqcAddr=…, MsqcDeath=…, XferBase=…, … })` DPS `SCR_DB.lua:155`, UERE `SCR_DB_MSF.lua:77`
- DPS 플레이어별 저장 변수: `iv.Money = CreateDataPW("Money")` DPS `DataArr.lua:13`; `CMov(FP,PVWArrX(iv.CXEPerM),0)` DPS `CallTriggers.lua:214` (정의 `function.lua:964` — 4칸 VArr/WArr 에서 CP 로 원소 선택)
- 서브루틴: `SetCallForward()`/`SetCall(FP)`/`SetCallEnd()`/`CallTrigger(FP,Call_X,{…})` 10맵 1,224회 → eudplib `EUDFunc` 로 그대로 대체

### 2-k. CP·플레이어 관용구
- 원시 CP: `CMov(FP,0x6509B0,NBTemp,25)`, `CSub(FP,0x6509B0,4)` DPS `CUnit.lua:22,53`; `CDoActions(FP, {TSetMemory(0x6509B0, SetTo, MCP), CenterView(118)})` DPS `CallTriggers\ui\mouse.lua:21`
- 상대 이동: `MoveCp(Add,15*4)` Stel `MapLogic\System.lua:167`, `MoveCp("X",25*4)` G2R `System.lua:9` (CUnit 필드 오프셋으로 CP 옮기기)
- 방금 만든 유닛: `f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)` 17개 폴더 전부(예: ResV `CallTriggers.lua:160`, Tpl `CallTriggers.lua:43` 은 `f_Read(FP, 0x628438, nil, Nextptrs)`)
- 플레이어마다 액션: `RotatePlayer({DisplayTextX(StrDesignX("…"),4),…},HumanPlayers,FP)` DPS `GlobalBoss.lua:39`
- dat 패치 목록: `PatchInsert(SetMemoryB(0x58D088 + 17+(i*46),SetTo,24))` ResV `OnInit.lua:58`; `SetUnitsDatX(BID,{HP=k[2],Shield=k[3],AdvFlag={0,0x80000}})` Stel `MapLogic\OnInit.lua:42`; `SetWeaponsDatX(103,{Behavior=1,Splash=false})` DPS `OnInit.lua:5`
- 트리거 자기수정·번호 산술: `SetCtrig1X(FP, Index, 0x158, 0, Add, 604*Multiplier)` DPS `function2.lua:226`; `SetCtrigX(CTVMem[1],CTVMem[2],0x15C,j-1, SetTo, k[1][1], k[1][2], 0x15C, 1, 0)` DPS `CheatTest.lua:64`
- 공메모리 슬롯: `Void(0, Exactly, 0)` UERE `DemonLanterns.lua:28` (UE·UERE 에서 783/765회 — 보스 패턴 상태 저장)

---

## 3. 우선순위 제안

### 상
1. **64비트 정수(+64비트 숫자 출력, 선택으로 128비트)** — 주요 맵 4곳 2,658회(DPS 2,537, UERE 111), 128비트 DPS 163. 새 맵에서도 돈·경험치·보스 체력("12800000000")이 32비트를 넘는다. 인자 모양상 필요한 것: 10진 문자열 상수, `{V,0}` 로 32비트 올리기, `{V,V}` 로 받기, 식 중첩(연산자 오버로드), 부호 있는 64비트 비교(`TTNWar …iAtLeast`). 안 쓰인 것(`f_LAnd/Not/lShift/Abs`, 부호판 곱·나눗셈, `f_LDiff`, `LPush/LPop`)은 뒤로 미뤄도 된다.
2. **서식 있는 텍스트 출력** — DisplayPrint 9맵 696회 + DPS 서식 원소 220, ItoCustom 5맵 55, ItoDec 4맵 20. eudplib `f_sprintf` 에 없는 것이 실제로 쓰인다: 자릿수 제한·0 채우기, 전각 숫자, 자리마다 색, 세 자리 묶음, 부호 표시, 64/128비트 값, 플레이어 이름 원소, 대상이 V(플레이어 변수)·Force, TBL(버튼 설명) 출력.
3. **CX Paint 도형 → 유닛 찍기** — CSMake*/CS_* 8맵 1,798회(MEME 까지 넣으면 +386), CSPlot 7맵 121, 사용자 스포너(G_CB·G_CA) 7맵 2,048. 컴파일 시점 계산 그대로 + 좌표 표 + 찍는 루프. 실제로 쓰는 편집 함수는 20개 안팎(1-a). 좌표 스포너에는 조건·소유자·반복 방식·크기 표 옵션이 붙는다(2-h).
4. **유닛 관련 편의**: "방금 만든 유닛 잡기"(`0x628438` 10맵 311회), 유닛 슬롯별 추가 저장 EXCC(8맵 361회), CUnit 오프셋으로 CP 옮기기(`MoveCp` 9맵 345회). eudplib 에도 대응은 있지만(`EUDLoopNewUnit`, `EUDArray(1700)`, `CUnit`) 맵마다 반복되는 틀이라 헬퍼 값이 크다.
5. **오브젝트 풀 + 필드 + 프레임 처리기** — 건물 스택 `Gun_Line` 계열 4맵 2,298회(구판 포함 3,272), TStruct 2맵 58. 필드 이름으로 조건·대입을 쓰는 모양(`Gun_Line(5,Exactly,0)`, `TSLine(GunFieldLine(Name),…)`)이 공통이다. eudplib `EUDStruct` + `ObjPool` 위에 "살아 있는 것만 돌기"를 얹는 헬퍼로 둘을 한꺼번에 받을 수 있다(추측).
6. **키 입력** — `KeyPress` 4맵 77, MSQC 키 헬퍼 2맵 78, 사용자 키 래퍼 3맵 34, 원시 `0x68C144` 27. 필요한 것: 키 이름 표, 누름·뗌 순간 판정, 채팅 중 제외, MSQC eds 줄 만들기와 "데스값 받고 지우기". `MousePress`·`NSQCSend/Receive`·`IsTyping` 함수 자체는 안 쓰인다.

### 중
- **f_Lengthdir 래퍼**(8맵 100회): Cycle 은 전부 360 이라 임의 주기는 필요 없다. 대신 음수 반지름과 360 이상·음수 각도 보정이 필요하다(eudplib `f_lengthdir` 는 `% 360` 만). 고정밀 모드는 Mem2 한 곳.
- **총알(사용자판 방식)**: 라이브러리 28장은 0회, 사용자 `CreateBullet` 류 4맵 95회. "유닛 dat 잠깐 바꿔 만들고 방향·높이 넣기" + 목표 좌표 → 각도(`f_Atan2` 는 여기서만 쓰임) + 360→256 변환.
- **CP·플레이어별 액션 관용구**: `RotatePlayer` 783, `DisplayTextX/PlayWAVX` 1,994, 원시 `0x6509B0` 1,670. eudplib `EUDPlayerLoop`/`DisplayTextAll` 로 되지만 "대상 목록(HumanPlayers 등)에 액션 묶음" 한 줄 헬퍼가 있으면 옮기기 쉽다.
- **dat 패치 표**(`PatchInsert` 614, `SetUnitsDatX` 류 336, 합쳐 8맵): CtrigAsm 기능이 아니라 템플릿 헬퍼지만 거의 모든 맵에 있다. 필드 이름 → 주소 표 + 시작 시 1회 적용(또는 되돌리기 가능한 패치).
- **BGM**(7맵 57): 곡 표, 곡 하나를 여러 조각으로, 관전자 켜기/끄기. `PL/bgmplayer.py` 는 한 곡 반복만.
- **플레이어 판정·이름**(`HumanCheck`/`LocalPlayerID` 10맵 371, 이름 9맵 87): 대응이 있어 얇은 이름 맞춤만.
- **부호 있는 값 읽기·비교**: `iAtLeast` 류는 4회뿐이지만 부호 16비트 좌표 읽기(`f_SHRead` 6맵 70)와 부호 뺄셈이 많다 → `wread_signed`, 부호 비교 조건 한 벌.
- **SCR_DB**(2맵 21): 런처 호환이 걸려 따로 설계(G8 1.11).
- **CDPrint + CD__ScanChat 채팅 효과 블록**(5맵 같은 코드), **관전자 채팅**(4맵 같은 코드): 복붙 블록 하나씩이라 작은 헬퍼로 끝난다.

### 하 / 만들지 않아도 됨
- **호출 0**: `CA__MoveXY` `CA__ConvertColor` `CA__ConvertLetter` `CA__Encode`, `CD__ScanW`, CGRP/BMP, 28장 라이브러리(`ScanSprite` `UnitSprite` `RecallSprite` `CreateStorm` `CreateSprite` `BulletInitSetting` `ScanInitSetting`), `IsTyping`/`NotTyping`, `NSQCSend/Receive/Mov`, `MousePress`, `f_Log2`, `f_Diff`/`f_SDiff`, `CMathFunc(2)`, 방장 함수, `HotkeyUnit` 계열, `FindSD`/`FindSDLocal`/`WideScreen`, `Timer`/`TimerX`/`Stage`, `CPush`/`CPop`, `ItoHex(X)`/`ItoX`, `CSSave`/`CSLoad`, `"i>="` 문자열 비교
- **거의 없음**: `ExitDrop`(구 GaLaXy.R 2), `CA__lItoCustom`(테스트 맵만 5), `TTKeyPress`·`TTMousePress` 각 1, `CABoss` 3, `NBag` 8(DPS), `CFunc` 15(Seed), CX 3D 6, `CA_`/`CB_` 실시간 편집 24, `Overflow_HP_System` 3, `Bit64_HP_SystemX` 1
- **eudplib 기본으로 충분**: 서브루틴(SetCall/CallTrigger 1,224 → `EUDFunc`), iStr/SVA1·CAPrint 틀(→ `StringBuffer`), 파일 삽입(→ `Db`), `Simple_SetLoc`(→ `f_setloc`), `StrDesign`(컴파일 시점 문자열 치환 — 파이썬 함수 하나), `Include_*`/`EUDTurbo`/`NoAirCollisionX`(플러그인)

---

## 4. 사본으로 보고 뺀 것, 확인 못 한 것

### 파일째 뺀 것
- `theSeed\Engine\G_CB_Lib.lua`, `Stella_II\Engine\G_CB_Lib.lua`, `MSF_Respect_V\G_CBPlot.lua`(구판 G_CB), `MapSource\TestCode\G_CB_Lib.lua`, `MSF-Template\G_CB_Lib.lua`(참고 열로만 셈)
- `Stella_II\Engine\func.lua`·`CallTriggers.lua`·`BGMEngine.lua`: 템플릿과 같은 파일(`func.lua` 는 빈 줄 하나 차이, 나머지 둘은 동일). 템플릿 열에서 한 번만 셈.
- DPS 의 `eud\`(이식 계층), `build\`(EUDEditor 산출 eps), `tools\`, `docs\`. 모든 맵의 `.py`(빌드·진단 도구)

### 맵 파일 안에서 몸체만 지운 함수 (파일:시작~끝 줄)
- DPS: `Variables.lua` HumanCheck(3-5); `function.lua` Install_BackupCP(2-21), Print_13X(310-321), Install_EXCC~EXCC_End(1439-1685), TSetCp(2412-2414), _Read(2440-2442); `function2.lua` _Mul/_Div/_Mod(348-490); `recover\recover.lua` SaveFileArr(13-48)
- Seed: `Engine\func.lua` StrDesign(X)(22-29), CtrigX·SetCtrigX·SetCtrig1X·SetCtrig2X(956-1328), IBGM_EPD(1334-1444)
- ResV: `func.lua` StrDesign(X)(12-19), CtrigX~SetCtrig2X(652-1021), LabelUseCheck(1024-1041), IBGM_EPD(1044-1153)
- Mem2: `func.lua` StrDesign(X)(4-12), Install_BackupCP·EXCC 일체(28-260), Include_CRandNum(265-281), IBGM_EPDX(318-351), f_TempRepeat·X·2X(1026-1164), T_to_BiteBuffer(1430-1448), CABoss(2428-2557), CtrigX~SetCtrig2X(2784-3138), LabelUseCheck(3141-3158); `GunData.lua` CS_Rotate3D(1426-1452); `OnPluginStart.lua` PushErrorMsg(392-394)
- Mem1: `MemoryInit.lua` CAPlot(91-295); `Main.lua` PushErrorMsg(9540-9542)
- G2R: `func.lua` CAPlot2·CXPlot2(86-475), f_TempRepeat(X)(640-651), CA_Func1(796-802), T_to_BiteBuffer(872-890), f_SaveCp/f_LoadCp(1256-1261)
- UERE: `func.lua` f_SaveCp/LoadCp(118-123), IBGM_EPDX(431-460), f_CRandNum(525-530), NormalTurboSet(555-566), SetCVar/CVar(578-590), **Include_G_CB_Library(632-1537, G_CB 통째)**, EXCC 일체(1540-1749), Install_TMemoryBW(1753-1871), CB_initTCopy(1879-1903); `EUDinit.lua` PushErrorMsg(478-480)
- Brz: `func.lua` IBGM_EPD(242-350), CAPlot2·CXPlot2(367-756), f_TempRepeat(X)(866-965), CA_Func1(1128-1136), T_to_BiteBuffer(1211-1229), CtrigX~SetCtrig2X(1468-1837), LabelUseCheck(1840-1857)
- Tpl: `func.lua` StrDesign(X)(16-23), CtrigX~SetCtrig2X(465-837), IBGM_EPD(843-953)
- 그 밖: MEME `function.lua` IBGM_EPD(186-294)·Include_G_CB_Library(296-2054); GaLaXy.R·GaLaXy.2·UE·NTM1·NTM3·GaLaXy 의 같은 종류(EXCC 일체, CAPlot2/CXPlot2, G_CB, CtrigX 류, DoActionsX 류, SaveFileArr 등) — 전체 목록은 `r1_raw.json` 의 `copy_report`
- **몸체를 남긴 동명 함수**(사용자 작성): `CreateBullet`·`CreateBulletXY`·`CreateBulletCond`·`CreateBulletLoc`·`SetBullet`·`Install_CBullet`, `MSQC_Key*`, `CreateVarArr2`·`CreateWarArr2`, `SetMemoryWX`, `Set_EXCC3(X)`·`Cond_EXCC3`, `TestSet`

### 확인 못 한 것·주의
- `ScmDraft 2` 안의 다른 폴더(`Gay_Enhance`, `MapSource_Private`, `Map2Source`, `SCA`, `뜸부기`/`발구지`/`양진이`)는 보지 않았다. `DPS_Enhance` 는 DPS_eud 와 같은 저장소라 뺐다. `MSF_MEME_EUD` 는 목록 밖이지만 CtrigAsm 맵이라 "그 밖" 열에 넣었다.
- Seed `Engine\func.lua` 는 템플릿에서 갈라진 사본(템플릿과 663줄 다름)이라 Seed 코드로 셌다. 템플릿에서 온 부분은 Tpl 과 Seed 에 두 번 들어간다(Tpl 열 자체가 작아 영향은 작다). `DebugBridge.lua` 는 DPS 와 Seed 에 같은 파일이 있고 둘 다 셌다.
- 정규식 셈이라 다음은 빠지거나 틀릴 수 있다: `_G["이름"]` 호출, 문자열로 만든 코드, 표에 담아 넘기는 호출(DPS `{SetNumX,…}` 만 따로 셈), 로컬 별칭(`local f = f_LMov`). `CreateUnitQueue*` 줄 수만 주석까지 센 대략값이다. G_CA 줄은 맵 안 `G_CA_*` 정의 몸체를 지우고 셌다(G_CA 는 G_CB 의 옛판이라 사본으로 봄).
- 1-c 의 `0x6509B0`·`0x628438` 같은 주소 상수 줄은 `r1_count.py` 값(정의 여부와 무관), 나머지 줄은 `r1_extra.py` 값이다.
- 동명 사용자 함수는 이름으로만 판정했다. 여기 적은 것 외에 라이브러리와 서명이 같은 채 조금 고친 사본이 더 있을 수 있다(추측).
- `CS__ItoCustom` 등 인자 의미는 가이드북 6748·7474행 설명을 따랐고, 라이브러리 본문은 읽지 않았다.
- `Void`/`SetVoid` 는 CtrigAsm 18장 공메모리 슬롯(`CtrigAsm v5.5.lua:43056`)으로 보았다. UERE/UE 에서 어떤 값을 담는지는 보지 않았다.
- `Gun_Line` 이 가리키는 "건물 스택" 동작은 정의부(ResV `GunData.lua:252~330`)만 훑었다. TStruct 와 한 헬퍼로 합칠 수 있다는 것은 추측이다.
