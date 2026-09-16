# CtrigAsm ↔ eudplib 기능 비교 (2026-09-17)

DPS강화하기를 eudplib 으로 옮기면서(DPS_Enhance 브랜치 `eudplib-port`, 워크트리 `ScmDraft 2\DPS_eud`) 조사한 자료다.
질문: "CtrigAsm 에는 있는데 eudplib 에 없는 기능이 있는가, 그 반대도 있는가."

비교 기준:
- eudplib 0.76.14 소스: `C:\Users\whatd\.venvs\eud076\Lib\site-packages\eudplib\`
- euddraft: `C:\euddraft0.9.2.0` (폴더 이름과 달리 실제 판은 0.9.10.11, 안에 eudplib 0.76.14)
- CtrigAsm v5.5 소스와 가이드북 v5.4: `MapSource\Library\`
- 더 새 eudplib 판은 보지 않았다.

## 파일

| 파일 | 내용 |
|---|---|
| `cmp_A1_ch01-14.md` | 가이드북 D장 1~14장 + 부록 H·I·J·K·L ↔ eudplib. 0절에 두 쪽 구조 차이(트리거 레이아웃, 변수 모양, CP 캐시) |
| `cmp_A2_ch15-29_libs.md` | 가이드북 D장 15~29장 + LibraryFor322·Extra·DisplayPrint·ObserverChat·TStruct 등 추가 라이브러리 ↔ eudplib |
| `cmp_A3_cxpaint_tools.md` | CX Paint(F장·`CB Paint v2.5.lua`), 부록 A~C·M~R, 도구 사슬(TEP·어셈블러 ↔ euddraft) |
| `cmp_A4_eudplib_to_ctrig.md` | 반대 방향: eudplib 에만 있는 것 |
| `lists\a4_eudplib_all.txt` | eudplib 0.76.14 공개 이름을 모듈별로 모은 목록 |
| `lists\a4_ctrig_funcs.txt` | CtrigAsm v5.5 함수 이름 1,315개 |
| `lists\a4_guide_funcs.txt` | 가이드북 D장 함수 서명(가이드북 줄 번호 포함) |
| `lists\a2_sigs.txt` | 가이드북 15장 이후 함수 서명과 한 줄 설명(가이드북 줄 번호 포함) |

판정 기호: **동등** / **대체**(다른 방식으로 같은 결과) / **불필요**(eudplib 구조에선 필요 없음) /
**없음**(직접 짜야 함) / **흉내 어려움**. A4 는 **있음 / 부분적 / 없음**(CtrigAsm 기준).

## 결론 요약

CtrigAsm 에만 있는 기능은 전부 eudplib 으로 직접 짤 수 있다. 새로 짜는 코드라면 옮기기 곤란한 것이 없다.
eudplib 에만 있는 기능 중에는 용량 줄이기와 디버깅에 바로 쓸 수 있는 것이 많다.

### CtrigAsm 에만 있는 것 (eudplib 에서는 직접 짜야 함)

| 기능 | CtrigAsm | 난이도 | 비고 |
|---|---|---|---|
| 64비트 변수·연산 | W 계열 (22장) | 중~상 | eudplib 0.76.14 에 64비트 형이 없다. 이식 계층 `DPS_eud\eud\ctrig\war.py` 에 덧셈·뺄셈·곱셈·나눗셈·난수 구현 |
| 64비트 숫자↔문자열 | `CA__lItoCustom`, `CD__ScanW` | 중 | 64비트 나눗셈이 먼저 필요 |
| 숫자 서식 | `ItoDec`, `ItoHex`, `CA__ItoCustom` | 하 | `f_sprintf` 는 부호 없는 10진과 8자리 대문자 16진만. 부호·0 채우기·자릿수 제한·전각·자릿수별 색 없음 |
| 글자 이동·색 변환 효과 | `CA__MoveXY`, `CA__ConvertColor` | 중 | eudplib 은 TextFX 페이드만 |
| 총알·스프라이트 생성, CGRP 그림 | `CreateBullet`, `CreateSprite`, `ScanSprite` (28·29장) | 중 | eudplib `EUDGrp` 는 .grp 파일 삽입이라 용도가 다름 |
| 키·마우스 입력 | `KeyPress`, `MousePress`, `IsTyping` | 하 | eudplib 본체에 없음. 동기화는 MSQC/NSQC 플러그인 |
| 부호 있는 비교 | `iAtLeast` 등 | 하 | eudplib 은 부호 없는 비교뿐 |
| 삼각함수 임의 주기 | `f_Lengthdir`/`f_Atan2` 의 Cycle, 고정밀 모드 | 하~중 | eudplib 은 360·256 주기만, 음수 각도 보정 없음 |
| CX Paint 도형 라이브러리 | CSMake, CS_ 함수 | lupa 로 그대로 하 / 파이썬 재작성 상 | 33,628줄 |
| 도형 → 유닛 소환 | `CSPlot`, CreateUnitShape.lua | 하 | |
| 작은 것 | `f_Diff`, `f_Log2`, 방장 번호·이름, `HotkeyUnit`, 관전자 채팅, `NSQCSend/Receive`, `ExitDrop` | 하 (`ExitDrop` 중, 원리 미확인) | |

CX Paint 는 도형 계산을 lupa 로 Lua 그대로 돌려 좌표만 받고, 유닛을 찍는 부분은 좌표 `Db` + 루프 하나로 새로 짠다
(theSeed `CAPlotIndexed.lua` 와 같은 구조). CSPlot 그대로면 1,700점에 약 583KB, 루프 방식이면 약 14KB.

기존 코드를 옮길 때만 까다로운 것:
- 번호로 옆 저장소를 찾는 계산(V 의 Next, VArr 원소 `×604`/`×2416`, `CtrigX` 의 Next). eudplib 변수는 72B 씩 겹쳐 놓여 번호가 없다. DPS 에 28곳(`DPS_eud\eud\spec\G9_dps_audit.md`).
- 플레이어별 사본 모델(`V(i,"X")`, 모든 함수의 PlayerID) → `EUDPlayerLoop` + `PVariable` 로 구조 변경.

### eudplib 에만 있는 것 (쓸모 순)

1. 안 쓰는 함수·변수·데이터 자동 제거 (CtrigAsm 은 선언한 트리거를 전부 싣는다)
2. 리스트 순회: `EUDLoopNewUnit`, `EUDLoopSprite`, `EUDLoopBullet`
3. `QueueGameCommand` 계열: 선택·우클릭·생산·일시정지 명령 보내기
4. 크래시 위치 추적: `EPS_SetDebug` + `epTrace.exe`
5. 함수별 트리거 수 측정 `EUDFuncN.size()`
6. 타입과 구조체: `EUDTypedFunc`, `EUDStruct`(필드 이름·중첩·`alloc/free`), `EUDMethod`
7. 형식 문자열 출력: `f_sprintf`, `StringBuffer`
8. MPQ 파일 추가(`MPQAddFile`), 컴파일 때 맵 데이터 편집(`GetChkTokenized`)
9. 되돌릴 수 있는 메모리 패치: `f_dwpatch_epd` → `f_unpatchall`
10. 작은 것: `f_pow`, `LocalLocale`, 부호 있는 나눗셈 3종, nand/nor/nxor, 클래식 TRIG 인라인

CtrigAsm 에도 있지만 제약이 큰 것:

| 기능 | CtrigAsm | eudplib |
|---|---|---|
| 트리거 적층 | 포크(lean)에만 있고 검증률 절반 | 기본 |
| 변수 하나 크기 | 2400B (VarStack 포크는 변수만 72B) | 72B |
| 함수 | 인자 수 상한이 맵 전체에 하나(기본 16), 호출마다 트리거 2~4개 | 호출마다 트리거 1개 |
| 제어문 | break/continue 없음, 점프 번호 0~0xFFF | 둘 다 있음, 번호 한도 없음 |
| 플레이어별 트리거 | TEP 가 플레이어 수만큼 복제 | `PTrigger` 1벌 |

### eudplib 에서 필요 없어지는 것
- CtrigAsm 틀: Label, 번호 할당기, `Include_*`, `ErrorCheck`, `StartCtrig`/`CJump` 틀, `ConvertArr`, Ccode
- T/TT 표식: eudplib `Trigger`/`DoActions` 가 조건·액션 칸에 변수를 바로 받고 16/64개를 넘으면 알아서 나눈다
- STRx/STRCtrig, 파일 삽입식 배열, CP 수동 복구(CP 캐시가 대신)
- 플러그인 NSQC, Debug, CPLP, CPIP, unlimiterX 는 모두 eudplib 플러그인이라 그대로 쓴다. `eudx.py` 는 불필요(마스크 조건 내장)

### 옮길 때 소리 없이 틀리기 쉬운 곳
- `CSub` 는 0 밑으로 내려가지 않는 뺄셈. eudplib `v -= x` 는 32비트 wrap(`core/variable/eudv.py` `__isub__`) → `SubtractNumber` 로 옮긴다.
- CP 를 `SetMemory(0x6509B0, ...)` 로 직접 쓰면 eudplib CP 캐시가 어긋난다 → `f_setcurpl`.
- 0 나눗셈 결과: `CiDiv` 는 0x7FFFFFFF/0x80000000, `f_div_towards_zero` 는 −1/1.
- `f_lengthdir` 는 `angle >= 360` 이면 `% 360` 만 한다(`eudlib/mathf/lengthdir.py`) → 음수 각도는 틀린 값.
- P1 마린 데스(0x58A364): eudplib 변수의 기본 대상도 이 칸이라 CtrigAsm 때의 주의가 그대로 필요.
- lupa(Lua 5.4)에는 `math.atan2`·`math.pow` 가 없다(실행해서 확인). CB Paint 15061행 `CS_ShapeInShape` 한 곳에서 atan2 를 쓴다 → `math.atan2 = math.atan` 한 줄.

### 확인하지 못한 것
- 더 새 eudplib 판에 64비트, 키 입력, 부호 있는 비교가 들어갔는지
- CPLP.exe 가 eudplib 빌드 결과물에서도 통과하는지
- `ExitDrop` 동작 원리, 두 방식의 빌드 속도 차이
- 이식 계층이 CAPlot 에 필요한 CtrigAsm 함수(`f_Lengthdir`, `CiDiv`, `ConvertLocation` 등)를 받쳐 주는지
