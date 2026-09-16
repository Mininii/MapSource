# A3. CX Paint(F 1~7장·실제 파일) + 부록 A~C·M~R + 도구 사슬 비교

조사일 2026-09-17. 파일은 읽기만 했다.

## 0. 확인한 기준

- **eudplib 0.76.14**: `C:\Users\whatd\.venvs\eud076\Lib\site-packages\eudplib\`. 아래 "eudplib/..." 경로는 이 폴더 기준이다.
- **euddraft**: `C:\euddraft0.9.2.0` 은 폴더 이름과 달리 `VERSION` = **0.9.10.11** 이다. `lib\library.zip` 안에 `eudplib-0.76.14.dist-info` 와 `freeze/` 패키지가 들어 있다.
- **TEP 3.0**: Lua **5.4** (`TrigEditPlus/Editor/Encoder/Lua/lua.h`). 다만 `lmathlib.c` 에 `atan2`·`pow`·`log10` 같은 호환 함수가 **추가되어 있다**(728~739행).
- **lupa 2.8 (lua54)**: 실제로 돌려 보니 `_VERSION`="Lua 5.4" 이고 `math.atan2`·`math.pow`·`math.log10`·`bit32`·`unpack` 이 **모두 없다**. 이식 계층 `eud/ctrig/luart.py` 는 이 가운데 `bit32` 만 채워 넣는다.
- **범위**: 가이드북 F장의 8~11장(CAPlot·CXPlot·CBPlot·CB_ 실시간)은 다른 조각이 맡았다. 이 문서에서는 CB Paint 실제 파일에 들어 있어서 참고로만 한 줄 적는다.

---

## 1. CX Paint — 도형 데이터 만들기·편집 (컴파일 시점 Lua 계산)

공통 사항: 1~3장과 6장의 함수는 **트리거를 하나도 만들지 않는 순수 Lua 계산**이다. 결과는 `{n,{x1,y1},...}` 테이블 하나다.
eudplib 0.76.14 에는 이런 도형 라이브러리가 **없다**. 그래서 대응 방법은 두 가지다.
(a) 파이썬으로 다시 짜기. (b) lupa 로 `CB Paint v2.5.lua` 를 그대로 돌리고 좌표만 받아 쓰기.
아래 표의 "판정" 칸은 (b)를 기준으로 쓰고, (a)의 난이도는 비고 칸에 적었다.

| 기능 묶음 | CtrigAsm/TEP 대표 | 하는 일 | eudplib 0.76.14·euddraft 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 도형 자료 구조 (1장) | `{n,{X,Y},...}` Shape/Path | 점 목록. 직접 만들어도 됨 | 파이썬 `list[tuple]`. lupa 테이블은 `.values()` 로 꺼낸다 | 동등 | 좌표는 실수로 저장된다. 트리거에 넣을 때 TEP 는 0 방향으로 자른다(`eud/ctrig/classic.py _i32` 가 같은 규칙) |
| 기본 도형 생성 (2장) | `CSMakePath(X)`, `CSMakePolygon(X)`, `CSMakeCircle(X)`, `CSMakeStar(X)`, `CSMakeLine(X)`, 파일에만 있는 `CSMakePath*`·`CSMakeCStar*` | 껍질 규칙(k번째 껍질에 k·n점)으로 정n각형·원·별·방사선 점 생성 | 대응 없음. 파이썬 `math` 로 짜거나 lupa 로 그대로 실행 | 대체 (lupa) | (a)는 하~중: 함수 하나하나는 짧지만 껍질·Hollow 규칙을 그대로 맞춰야 한다. theSeed·Stella_II·Respect_V 에서 가장 많이 쓰는 묶음이다 |
| 그래프 곡선 (2장 고급) | `CSMakeGraphX/Y/A/R/T` (+10장 `...1/2`, `CSMakeGraphXY/RA`) | 사용자 함수(**함수 이름을 문자열로 전달**)의 등간격 곡선 | 대응 없음 | 대체 (lupa) | lupa 에서는 `_G[funcName]` 호출이 그대로 동작한다(CB Paint 에 `_G[` 180곳). (a)는 중: 콜백을 callable 로 바꾸고 등간격 탐색 알고리즘을 옮겨야 한다 |
| 나선 | `CSMakeSpiral(X)` (`CSMakeSpiral.lua` 146줄. CB Paint 안에도 같은 이름이 있음) | 로그 나선 r=M·exp(C(θ−A)) | 대응 없음 | 대체 (lupa) | 같은 이름이 두 파일에 있다. 이식 계층은 `dir /b` 순서로 불러서 **나중에 로드된 CSMakeSpiral.lua 판이 이긴다**(`_AGENT_BRIEF.md` 규칙) |
| 자유 변형 (3장) | `CS_MoveXY/RA`, `CS_MoveCenter`, `CS_Rotate`, `CS_Rotate3D`, `CS_InvertXY/RA`, `CS_RatioXY/RA`, `CS_MirrorX/Y/R/A` | 평행이동·회전·반전·배율·대칭 | 대응 없음 | 대체 (lupa) | (a)는 하 |
| 특수 변형 (3장) | `CS_Kaleidoscope(X)`, `CS_Distortion(X)`, `CS_Vector2D(Polar)` (+10장 `CS_Distortion2`, `CS_Warping`) | 만화경·원근 왜곡·벡터함수 변환. 사용자 함수를 문자열로 받음 | 대응 없음 | 대체 (lupa) | (a)는 중 |
| 집합 연산 (3장) | `CS_Add`, `CS_Overlap(X)`, `CS_Merge`, `CS_Intersect`, `CS_Subtract`, `CS_Xor`, `CS_RemoveStack` | 합치기·겹침·차집합. Size 로 "같은 점"을 판정 | 대응 없음 | 대체 (lupa) | (a)는 하~중: 판정 순서와 Priority 규칙을 맞춰야 결과가 같다 |
| 자르기 (3장) | `CS_CropXY/RA/Path`, `CS_CropGraphXY/RA` | 사각형·부채꼴·Path 내부·음함수 영역으로 자르기 | 대응 없음 | 대체 (lupa) | 점-다각형 내부 판정이 들어 있다. (a)는 중 |
| 채우기 (3·6장) | `CS_FillXY/RA/HX/RD`, `CS_FillPathXY/RA/HX/RD`, `CS_FillPath*2`, `CS_FillGrad*`, `CS_FillPathGrad*` (+파일에만 있는 `CS_FillPattern*`, `CSMakeTile`) | 격자·방사·육각·무작위·그라데이션으로 영역 채우기 | 대응 없음 | 대체 (lupa) | `RD`·`GradXD` 는 `math.random` 을 쓴다. 파일을 불러올 때 최상위(3148행)에서 `math.randomseed(os.time())` 가 실행되므로 **컴파일할 때마다 결과가 바뀐다**(원래 동작). (a)는 중~상 |
| 검사 (3장) | `CS_CheckXY/RA/Stack/Collide/Path(X)` | 조건에 맞는 점이 있으면 **컴파일을 멈춤** | 파이썬 `raise`, `ep_assert`/`EPError` (`eudplib/utils/eperror.py`) | 대체 | CtrigAsm 은 **정의되지 않은 전역 함수를 일부러 호출**해서 오류를 낸다(`CS_OverX2_Detected()`, CtrigAsm `PushErrorMsg` = `_G["\n"..msg.."\n"]()`). lupa 에서도 같은 오류가 `LuaError` 로 올라온다 |
| 점 순서 (3·6장) | `CS_Reverse`, `CS_Shuffle`, `CS_Convert`, `CS_SortX/Y/R/A`, `CS_DoubleSortRA`, `CS_SortGraphXY/RA`, `CS_DoubleSortGraph`, `CS_SortXY/RA/I` | 점을 찍는 순서 정하기 = "나타나기 효과" | 대응 없음 | 대체 (lupa) | 순서가 곧 연출이다. 파이썬으로 옮기면 정렬 안정성과 동점 처리까지 맞춰야 한다. (a)는 중 |
| 크기·중심 정보 (3·6장) | `CS_GetXmax/min`·`Y`·`R`·`A`, `CS_GetXCntr/YCntr/RCntr`, `CS_GetXYmax/min`, `CS_GetRAmax/min`, `CS_Round` | 최대·최소·중심·반올림 | 대응 없음 | 대체 (lupa) | (a)는 하 |
| 경로 보간·분할 | `CS_ConnectPath(X)`(6장), `CS_Addon.lua` 의 `CS_Slice`, `CS_PathInPath(X)` | 선분 사이 내분점 추가, 긴 선분에서 끊기, 경로 위에 도형 배치 | 대응 없음 | 대체 (lupa) | `CS_Addon.lua` 는 전역 변수를 새게 둔다(`LArr`, `Ret` 등 local 없음). lupa 에서도 동작은 같다 |
| TSort·LoopMax 자료 (6장) | `CS_TInputVoid`, `CS_TMakePath`, `CS_TMakeAuto`, `CS_NSortXY/RA/I`, `CS_TSortXY/RA/I`, `CS_Arrange/Split/Mix`, `CS_SortTM/TI`, `CS_TArrange/TSplit/TMix` | "틱마다 몇 점씩 찍나" 배열을 도형과 짝지어 만듦 | 대응 없음 | 대체 (lupa) | 계산만 한다. 이 자료를 **소비하는 쪽은 CBPlot(실시간, 10~11장)** 이라 그쪽 판정에 따라 쓸모가 정해진다 |
| 사용자 정의 도형 확장 | theSeed `CSMakeNatoriUsaChan`, `CS_Thin`, `CS_Level`(10장) 등 맵별 Lua | 제작자가 CB Paint 위에 직접 짠 도형 | 대응 없음 | 대체 (lupa) | lupa 로 가면 **맵 쪽 Lua 도형 코드도 그대로 살릴 수 있다**. 파이썬으로 옮기면 이것까지 옮겨야 한다 |
| 파일 기반 이미지 (v2.5, 가이드 1~7장 밖) | `CS_BMPConvert(X)`, `CS_BMPConvertColor(X)`, `CS_BMPGraph`(도형 → .BMP 미리보기 파일), `CS_CropMask(X)`, `CS_FillMask*`, `CS_VectorMask2D`(.BMP 마스크 읽기) | 컴파일할 때 BMP 쓰기·읽기 | 파이썬 `open`/`struct`. euddraft `library.zip` 에 **PIL 은 없다**(확인). 필요하면 lupa 처럼 경로를 추가해 불러온다 | 대체 (lupa 는 그대로 동작) | Lua `io.open(FileDirectory..)` 를 쓰므로 lupa 에서는 `FileDirectory` 전역을 맞춰 줘야 한다 |
| 옛 도형+트리거 합본 | `CreateUnitPolygonSafe2Gun[Move].lua`(2,044줄), `CreateUnitShape.lua` | 정n각형 좌표 계산과 로케이션 이동·CreateUnit 트리거 방출이 한 함수에 섞여 있음 | 아래 2절 CSPlot 과 같다 | 대체 (lupa로 그대로 / eudplib 하) | `bit32.band` 사용(17곳). 이식 계층의 bit32 shim 으로 해결된다 |

## 2. CX Paint — 트리거를 만드는 부분

| 기능 묶음 | CtrigAsm/TEP 대표 | 하는 일 | eudplib 0.76.14·euddraft 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 도형 → 정적 소환 트리거 (4장) | `CSPlot`, `CSPlotWithProperties`, `CSPlotX`(6장, 점마다 유닛 종류 배열) | 점마다 로케이션 L/U/R/D 를 `SetMemory` 로 옮기고 `CreateUnit` 실행. **63액션씩 끊어 클래식 `Trigger{}` 로 방출**. 1,700점을 넘으면 오류 | `f_setloc`/`f_addloc`/`f_dilateloc` (`eudplib/eudlib/locf/locf.py`, `action=True` 로 액션 리스트 반환), `SetMemory`·`CreateUnit`·`CreateUnitWithProperties` (`eudplib/core/rawtrigger/stockact.py`), `Trigger` (`eudplib/trigger/triggerdef.py`, 조건 16개·액션 64개를 넘으면 자동 분할), `PTrigger` (`eudplib/trigger/ptrigger.py`) | **없음·하** (직접 짜기) / 이식 계층에서는 동등 | 이식 계층에서는 CSPlot 이 `Trigger{}` → `__internal__AddTrigger` → `RawTrigger` 경로(`eud/ctrig/classic.py`)로 **수정 없이 돈다**. 다만 용량 면에서는 트리거가 액션으로 꽉 차 있어 겹쳐 쌓기 이득이 거의 없다. 1,700점 기준(CenterXY 없음, 점당 9액션) 약 243트리거 ≈ 583KB. 좌표표(8B×점)와 루프 하나로 바꾸면 ≈ 14KB + 루프 몇 트리거 |
| 점마다 추가 액션 (4장) | `CSPlotAct(WithProperties)` | 유닛 하나 소환할 때마다 PerAction 실행 | 위와 같음 (액션 리스트에 끼워 넣기) | 없음·하 | |
| 소환 후 이동 명령 (4장) | `CSPlotOrder(WithProperties)` | 두 번째 도형(OrderShape)의 점으로 Attack/Patrol/Move | `Order` (`stockact.py:679`), `MoveLocation`, `f_setloc` | 없음·하 | |
| 도형 저장 (5장) | `CSSave`, `CSSaveWithName`, `CSTSaveWithName`, `CS_Test` | `FileDirectory.."CS/"..name..".txt"` 에 Lua 테이블 문법으로 저장. `CSSaveInit` 이 `os.execute("mkdir")` 실행 | 파이썬 `open`·`json` (euddraft `library.zip` 에 `json`·`csv`·`struct` 포함 확인) | 대체 (lupa 는 그대로) | 저장 형식이 Lua 문법이라 파이썬에서 읽을 때도 lupa 로 `dofile` 하는 편이 가장 쉽다 |
| 도형 불러오기 (5장) | `CSLoad` | 여러 txt 를 **SCMDraft 의 `lua/CSLoad.lua` 로 합쳐 써서** 다음 컴파일부터 TEP 플러그인이 자동 로드 | 파이썬 `import`/`open`, lupa `dofile` | 불필요 | SCMDraft 의 lua 폴더 자동 로드에 기대는 구조라, 빌드가 파일을 직접 읽으면 필요 없다 |
| 실시간 좌표 편집 (7장, 어셈블러 필요) | `CA_ConvertRA/XY`, `CA_MoveXY/RA`, `CA_RatioXY/RA`, `CA_InvertXY/RA`, `CA_Rotate`, `CA_Rotate3D`, `CA_CropXY/RA` | CAPlot 의 CAfunc 안에서 **현재 점 좌표 CA[8]·CA[9] 를 게임 도중 변환**. 내부적으로 CtrigAsm `f_Atan2`, `f_Sqrt`, `f_Lengthdir`, `CMul`, `CiDiv`, `CMov`, `STPopTrigArr` 사용. Crop 은 CB[10]>0 으로 그 점을 건너뜀 | 부품은 있다. `f_atan2`/`f_atan2_256` (`eudplib/eudlib/mathf/atan2.py`), `f_sqrt` (`mathf/sqrt.py`), `f_lengthdir`/`f_lengthdir_256` (`mathf/lengthdir.py`, 입력 360도 단위), `f_div_towards_zero`/`f_div_floor` (`mathf/div.py`, 부호 있는 나눗셈), `EUDVariable` 산술, `EUDContinue` 계열 | **없음·하~중** (조합해서 짜기) | CtrigAsm 쪽 RA 함수는 `Include_MatheMatics` 의 **Cycle 값**(각도 분할 수)을 따른다. eudplib 은 360·256 두 가지뿐이라 다른 Cycle 은 직접 환산해야 한다(중). 3D 회전은 lengthdir 3번 조합(하). 이식 계층 쪽 판정: `f_Lengthdir`·`f_Sqrt`·`f_Atan2`·`CiDiv` 는 `eud/ctrig/*.py` 에서 이름으로 찾지 못했다. CtrigAsm Lua 원본이 받쳐 주는지는 **확인 못 함** |
| (참고, 범위 밖) 실시간 소환기 (8~11장) | `CAPlot(2)`, `CAPlotOrder`, `CXPlot(2)`, `CBPlot(Order)`, `CVPlot`, `CB_*`, `CB_InitCache` 등 | 도형을 메모리 배열에 싣고 틱마다 소환. `CVariable`·`CArray`·`NWhileX`·`TCreateUnit`·`SetMemX`·`Trigger2X` 같은 CtrigAsm 공개 함수로 짜여 있음 | eudplib 네이티브로 짜면 좌표 `Db`/`EUDArray` + `EUDLoopRange` + `f_dwread_epd` + `f_setloc` + `CreateUnit` | (다른 조각 판정) | theSeed `Engine/CAPlotIndexed.lua` 가 이미 "도형별 가지 → 주소표 + 두 번 읽기" 구조로 바꿔 두었다(도형 108개일 때 약 17.2 → 4.0 트리거/도형). eudplib 으로 옮길 때 그대로 따라 할 설계다 |

## 3. 부록 A~C, M~R

| 기능 묶음 | CtrigAsm/TEP 대표 | 하는 일 | eudplib 0.76.14·euddraft 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 설치 (A) | lua 폴더 → SCMDraft `lua/`, .py → euddraft `plugins/`, Tep v1.0/v2.0 → SCMDraft `plugins/`, Loader*.lua → SCMDraft 폴더 | 네 곳에 나눠 복사. Tep v1 은 자동완성 O·최적화 X, v2 는 반대 | eudplib 휠(pip) 또는 euddraft 압축 해제 + `plugins/` | 불필요 | 트리거 편집기(SCMDraft 플러그인)와 컴파일러가 둘로 나뉘지 않는다 |
| 외부 Lua 로더 (A) | `Loader.lua`, `LoaderX.lua`(VS Code), `Loader2(X).lua` | Tep 안에서 `Dofile` 로 외부 파일 로드. Loader2 는 트리거를 `맵이름__TRIG.chk` 로 빼서 **TEP 트리거 65,536개 한도**를 우회 | 파이썬 `import`, epScript `import`, `EPSLoader` (`eudplib/epscript/`) | 불필요 | eudplib 은 맵 TRIG 섹션에 트리거를 싣지 않으므로 이 한도 자체가 없다 |
| 표준 템플릿 (A) | `SetForces`, `SetFixedPlayer`, `StartCtrig`, `CJump…CJumpEnd`, `EndCtrig` | 세력·고정 플레이어 선언, 어셈블러 구역 열고 닫기 | `onPluginStart`/`beforeTriggerExec`/`afterTriggerExec`, `EUDOnStart` (`eudplib/maprw/injector/mainloop.py`). 세력 정보는 맵에서 읽음(`GetChkTokenized`, `eudplib/core/mapdata/mapdata.py`) | 불필요 | |
| 주의사항 (B) | 65,536 한도, **euddraft 트리거 인라이닝과 비호환**, P1 마린 데스(0x58A364) 임의 사용, 코드 유지 풀림, TRIG 를 건드리는 다른 플러그인, String Corruption(ParseString) | CtrigAsm 구조 때문에 생기는 제약 | eudplib 은 `EncodeString` 이 STR 을 관리하고, 인라이닝은 기본으로 켜져 있음 | 불필요 (대신 eudplib 쪽 제약은 freeze 한도) | |
| 예제맵 (C) | `Testmap TRIG.txt` + 예제 붙여넣기 | 예제 실행 | epScript/파이썬 예제 파일 | 대체 | |
| Debug.py (C) | `[Debug]` 플러그인 (1,571줄). 0x58F448 비트로 켬: 13번째 줄에 0x58F450~ 16진 표시, 채팅 1~8줄에 0x58F480~ 표시, 채팅 `\|\|AAAAAA BBBBBBBB`·`##…` 로 메모리 쓰기, `@@ReadV#` 로 읽기 | 게임 중 메모리 보기·쓰기 | **Debug.py 자체가 eudplib 플러그인**(`beforeTriggerExec`)이라 그대로 쓸 수 있다. 표준 수단: `f_eprintln`/`f_eprintf`/`f_printAll`/`f_simpleprint` (`eudplib/eudlib/stringf/`), `EUDTraceLog` (`eudplib/core/eudfunc/trace/tracetool.py`) + euddraft 폴더의 `epTrace.exe`, eds `[main] debug` → `EPS_SetDebug(True)`(바이트코드로 확인) | 동등 | 채팅으로 메모리를 쓰는 기능은 eudplib 표준에 없다. Debug.py 를 계속 쓰면 된다 |
| STRCtrig (M) | `STRCtrigAssembler.exe`(+SFmpq.dll) → `TRIGP1~8.chk`, `[STRCtrig Assembler v5.5]` 플러그인 | Tep 트리거를 STRx 로 옮김. 나간 플레이어의 트리거 보존(Next 접근), 파일 삽입, 시작 로딩 약 25배 빠름. NSQC 보다 위에 둬야 함 | eudplib 페이로드는 처음부터 STR 쪽 메모리에서 돈다. 재배치는 표 기반(`eudplib/maprw/injector/payload_reloc.py`). 겹쳐 쌓기는 `stack_objects`. 파일은 `Db(bytes)`, `MPQAddFile`/`MPQAddWave` (`eudplib/maprw/mpqadd.py`) | 불필요 | STRCtrig 플러그인은 트리거마다 런타임 패치를 한다(theSeed: 시작 시 약 1,010만 회 실행, `UPSTREAM.md`). eudplib 트리거는 플레이어와 상관없이 돌아서 "나간 플레이어" 문제가 없다 |
| CPLP 프로텍터 (N) | `[CPLP]` 플러그인 + `CustomPlibLockProtector.exe` 후처리 | **eudplib 맵용** 수정 방지. 런타임에 MPQ HET/BET 표를 키로 검사하고, 틀리면 멈춤·드롭. **freeze 를 끄고** 써야 하며, freeze 를 못 쓸 만큼 큰 맵에도 적용 가능 | eudplib 생태계(CPLP) — 원래 eudplib 플러그인이다. 비교 대상 `freeze` 는 euddraft 에 내장(`library.zip/freeze/`, `freezeMpq.pyd`, `[freeze] freeze: 1`) | 동등 | euddraft 는 "SCDB 맵에는 freeze 불가" 메시지를 갖고 있다. freeze 한도는 블록 테이블 크기(기억 기록 참고: theSeed ≈75MB 에서는 못 씀). `eud/build_eud.py --full` 이 CPLP 적용까지 **계획**해 두었지만, eudplib 0.76.14 산출물에 CPLP.exe 를 실제로 돌려 통과했는지는 **확인 못 함** |
| CPIP (N 인접) | `[CPIP]` (CustomPlibICEProtector v1.0B) | 시간값·MSQC 유닛(226/227)으로 접속자 값을 비교해 조건이 맞으면 드롭하는 보호 플러그인(목적 세부는 추측) | eudplib 생태계(CPIP) — 역시 eudplib 플러그인 | 동등 | |
| 도형 추출기 (O) | `CS_Extractor.exe` v2.0 (+SFmpq.dll) | 맵에 배치한 특정 플레이어·유닛의 좌표를 Shape 텍스트(`_out.txt`)로. 배치 순서 = 점 순서, 맵 좌상단이 원점 | exe 는 컴파일러와 상관없이 그대로 쓸 수 있다. eudplib 대체: `GetChkTokenized().getsection("UNIT")` 를 읽어 36바이트씩 파싱하면 **빌드할 때 자동 추출**도 가능 | 동등 (도구 독립) / 대체·하 | 예제 O-1 은 추출한 도형을 `CS_MoveCenter` → `CSPlot`·`CAPlot` 에 넣는다 |
| 썸네일 편집기 (P) | `CS_Minimap.exe` v4.5 (euddraft 폴더에는 없고 `Desktop\정리용 폴더\download\Ctrig Assembler v5.4\exe\` 에 있음) | 8비트 BMP(P13/P16.ACT)를 미니맵 가스통 유닛 배치로 바꿔 맵에 넣음. 모서리·그림자·투명색·스타팅 복구 옵션 | eudplib·euddraft 에는 대응 없음. 입력 맵에 미리 적용하면 되므로 도구 독립. 시작할 때 가스통을 지우는 트리거는 eudplib 으로 짜면 됨 | 동등 (도구 독립) | 파이썬으로 다시 짜는 것은 없음·중(UNIT 섹션 쓰기 + 미니맵 색 규칙) |
| 사진 변환기 (Q) | `CS_Photo.exe` v1.0 (위와 같은 폴더) | 24비트 BMP → 밝기 필터 → Shape 텍스트 + `_preview.bmp`. 두 번째 모드(CGRP)는 CtrigAsm 29단원 | exe 는 그대로 쓸 수 있다. 파이썬 대체: BMP 헤더를 `struct` 로 직접 읽기(PIL 없음) | 동등 (도구 독립) / 대체·하 | 예제 Q-1 은 `CS_TSortXY` + `CBPlot` 으로 이어진다(실시간 쪽은 범위 밖) |
| VS Code 연계 (R) | sumneko Lua 확장 + 라이브러리 경로, **파일 인코딩 EUC-KR 필수**, `LoaderX` 로 `Main.lua`/`Sub.lua`(함수 단위) 분할, `Loader2X` + STRCtrig | 하이라이트·자동완성·파일 분할 | 파이썬: 아무 IDE(eudplib 0.76.14 에 `py.typed` 가 있어 타입 기반 자동완성). epScript: VS Code 확장(외부, 추측), EUD Editor 3 내장 편집기(외부, 추측). 파일 분할은 `import` 가 기본. 인코딩: 소스는 UTF-8, 맵 문자열은 `u2b`(기본 cp949) / `u2utf8` 선택 (`eudplib/utils/ubconv.py`) | 대체 | 이식 계층(lupa)을 쓰면 기존 Lua + VS Code 작업 방식을 그대로 유지할 수 있다 |

## 4. 도구 사슬 비교 (TEP/CtrigAsm vs eudplib/euddraft)

| 기능 묶음 | CtrigAsm/TEP 대표 | 하는 일 | eudplib 0.76.14·euddraft 대응 | 판정 | 비고 |
|---|---|---|---|---|---|
| 트리거 생성 언어 | TEP 3.0 = Lua 5.4 (+bit32, atan2/pow 호환) | Lua 로 트리거 테이블을 만든다 | 파이썬 3.11(euddraft 에 `python311.dll`), epScript(`libepScriptLib.dll` → 파이썬 코드로 변환) | 대체 | 이식 계층은 lupa 로 Lua 를 그대로 돌린다. 위의 atan2 차이에 주의 |
| 컴파일 순서 | 맵 + Lua → TEP(GUI 또는 `tepc`) → `STRCtrigAssembler.exe` → euddraft(`[STRCtrig Assembler]`) → (CPLP.exe) | 3~4단계 | euddraft 한 번(.eds/.edd). `.edd` 는 데몬 모드(R 키로 재컴파일, 바이트코드 문자열로 확인) | 대체 | |
| 컴파일 시점 파일 I/O | Lua `io.open`/`os.execute` (CSSave, BMP, `__TRIG.chk`, `mkdir`). 원본 TEP 는 `fopen` 결과를 검사하지 않아 경로가 틀리면 **메시지 없이 크래시**(`HEADLESS.md`, `UPSTREAM.md`) | 빌드 중 파일 읽기·쓰기 | 파이썬 표준 라이브러리 전부. euddraft 에는 `json`·`csv`·`struct`·`openpyxl` 이 번들되어 있고 PIL·numpy 는 없음 | 동등 이상 | |
| 오류 검사·메시지 | Lua 오류, `PushErrorMsg`(정의되지 않은 전역을 호출하는 트릭), `CS_Check*` | 잘못된 입력에서 멈추기 | `EPError`, `ep_assert` (`eudplib/utils/eperror.py`), 파이썬 traceback | 대체 | |
| 오류 줄 번호 | Lua chunk 줄 번호. `tepc --mapdir` 는 앞에 한 줄을 붙이는 방식이라 원본 줄 번호를 보존한다 | 오류 위치 | epScript: `linetable_calculator.py` 가 파이썬 코드 객체의 줄 번호를 **.eps 줄로 되돌린다**(`eudplib/epscript/epsimp.py`). 파이썬은 원래 줄 번호 | 동등 | |
| 트리거 용량 우회 | STRx/STRCtrig(TRIG→STRx, 트리거 2,400B 고정), 적층 포크 | 트리거 한도·용량 문제 해결 | 페이로드 + `stack_objects` 겹쳐 쌓기, 변수 72B, `CompressPayload` (`eudplib/core/allocator/payload.py`) | 불필요 | 수치는 `EPSCRIPT_TRIGGER_BUDGET.md` 3절 참고 |
| 클래식 TRIG 인라인 | STRCtrig 플러그인이 `PRT_SetInliningRate(0)` 으로 끔 | — | `PRT_SetInliningRate`, `inline_eudplib` 트리거 (`eudplib/maprw/inlinecode/ilcprocesstrig.py`), 여러 플레이어 트리거 공유 | eudplib 쪽에만 있음 | |
| 플러그인 재배치 | STRCtrig 플러그인이 시작 시 트리거마다 STRX PATCH | 주소 고정 | `payload_reloc.py`·`vector_reloc.py` 표 기반 | 불필요 | |
| euddraft 옵션 | (CtrigAsm 도 결국 euddraft 위에서 돈다) | — | `[main]` 옵션 `input, output, shufflePayload, debug, decodeUnitName, objFieldN, sectorSize` (바이트코드로 확인) | 동등 | |
| 동봉·내장 플러그인 | CtrigAsm 동봉: `NSQC.py`, `eudx.py`, `unlimiterX.py`, `Debug.py`, `CPLP.py`, `CPIP.py`, `CopyTBL.py` | 키 입력·마스크 조건·총알 한도 해제 등 | euddraft `plugins/`: `unlimiter.py`, `MSQC.py`, `chatEvent.py`, `dataDumper.py`, `eudTurbo.py`, `noAirCollision.py`, `bgmplayer.py`, `scnd.py` + 내장 freeze. **CtrigAsm 동봉분도 전부 eudplib 플러그인이라 eudplib 빌드에서 그대로 쓸 수 있다** | 동등 | `keySelector` 는 이 설치본 `plugins/` 에 **없다**(확인 못 함). NSQC 가 CtrigAsm 없이 온전히 도는지는 확인 안 함 |
| 마스크 조건 (eudx) | `eudx.py` (`DeathsX`, `MemoryX`, `ConditionX`) | SC:R 마스크 조건 | `DeathsX`/`MemoryX`/`MemoryXEPD` (`eudplib/core/rawtrigger/stockcond.py`), `SetDeathsX`/`SetMemoryX` (`stockact.py`) | 동등 | eudx.py 가 필요 없다 |
| 맵 보호 | CPLP(+freeze 끔), CPIP | 수정 방지 | freeze(내장, 크기 한도 있음), CPLP·CPIP 도 사용 가능 | 동등 | 3절 N 참고 |
| MPQ 파일 추가 | CtrigAsm 파일 삽입 함수(STRCtrig + AbsolutePath, P9~P12 트리거 이용), BGM 폴더 | 외부 파일 싣기 | `MPQAddFile`/`MPQAddWave`, `Db(open(...).read())`, `EUDGrp` (`eudplib/eudlib/eudgrp.py`) | 동등 | |
| 디버깅 | Debug.py, `PushValueMsg` | 게임 중 값 보기 | 3절 Debug.py 행과 같음. 이식 계층에는 **게임 없이 페이로드를 돌리는 트리거 에뮬레이터**(`eud/tests/emu.py`, 커밋 d660f42)도 있다 | 동등 이상 | |
| 빌드 속도 | TEP GUI 는 사람이 눌러야 함. `tepc` 로 헤드리스화 | — | `build_eud.py --check` 주석에 "몇 초" | — | 같은 맵으로 잰 비교 수치는 **확인 못 함** |
| 소스 보관 | TEP "코드 유지"(맵 안에 소스 저장, 풀리면 복구 불가, AppData 에 마지막 코드만 남음) | — | 소스는 파일 + git | 불필요 | |
| 편집기 | TEP 3.0 Scintilla 창(F5 컴파일, `triggersyntax.txt`), VS Code + sumneko | 편집과 컴파일을 한 창에서 | euddraft 에는 편집기가 없다. 파이썬 IDE, epScript 확장(외부, 추측), EUD Editor 3(외부) | 대체 | |

---

## 5. 없음 / 흉내 어려움 목록

**없음 (직접 짜야 함)**
1. CX Paint 도형 라이브러리 전체(CSMake·CS_·6장 함수팩·CS_Addon): eudplib 에 없다. **lupa 로 그대로 쓰면 하.** 파이썬으로 옮기면 상(33,628줄, 함수 300여 개, 문자열 콜백 `_G[` 180곳).
2. CSPlot / CSPlotAct / CSPlotOrder 같은 "도형 → 소환" 도우미: 하. 부품(`f_setloc`, `CreateUnit`, `Order`, `Trigger` 자동 분할)은 다 있다. 이식 계층에서는 수정 없이 돈다.
3. CA_ 실시간 좌표 변환 묶음(7장): 하~중. 부품은 `f_lengthdir`·`f_atan2`·`f_sqrt`·`f_div_towards_zero` 로 있다. Cycle 을 360·256 이 아닌 값으로 쓰면 환산이 필요해 중.
4. 채팅으로 메모리를 읽고 쓰는 디버그 명령: eudplib 표준에는 없다. 하지만 Debug.py 가 eudplib 플러그인이라 **그대로 쓰면 된다**.
5. 썸네일(미니맵) 편집: euddraft·eudplib 에 대응이 없다. CS_Minimap.exe 가 도구 독립이라 그대로 쓰면 된다. 다시 짜면 중.

**흉내 어려움**
1. 파이썬 재작성 시 **결과를 똑같이 맞추기**: `math.random`(os.time 시드), Lua 5.4 `pairs` 순회 순서(`HEADLESS.md`: 실행마다 바뀜), 실수 연산 순서 때문에 무작위 채우기·셔플·정렬 동점 결과가 원본과 달라진다. 원본도 매 컴파일 달라지므로 실질적인 문제는 작다. 파이썬 재작성을 피해야 할 이유다.
2. lupa 로 CB Paint 를 쓸 때 TEP 전용 Lua 확장 차이: `math.atan2` 가 lupa 에 없다. CB Paint 15061행 `CS_ShapeInShape` 의 Rotate 옵션 **한 곳**에서만 쓰며, `math.atan2 = math.atan` 한 줄 shim 으로 해결된다(이식 계층 `luart.py` 에는 아직 없음). 그 밖의 소스(Library·theSeed·Stella_II·DPS)에는 atan2·pow·log10 등을 쓰는 곳이 없다.

## 6. 불필요 (구조 차이) 목록

- Loader / LoaderX / Loader2 / Loader2X 외부 Lua 로더와 TEP 트리거 65,536개 한도 우회: 파이썬·epScript `import` 가 있고 TRIG 섹션을 쓰지 않는다.
- STRCtrigAssembler.exe + `[STRCtrig Assembler]` 플러그인(TRIG→STRx, `TRIGP*.chk`, 시작 시 런타임 패치, 나간 플레이어 트리거 보존): 페이로드가 처음부터 STR 쪽에서 돌고 재배치는 표 기반이다.
- `StartCtrig`/`EndCtrig`/`CJump` 템플릿, `SetForces`/`SetFixedPlayer`: 플러그인 진입점과 맵 정보 읽기로 대신한다.
- `CSLoad`(SCMDraft `lua/` 폴더 자동 로드에 기대는 방식): 빌드가 파일을 직접 읽는다.
- `eudx.py`: 마스크 조건·액션이 eudplib 에 내장되어 있다.
- 인라이닝 끄기(`PRT_SetInliningRate(0)`), 0x58A364 예약, ParseString String Corruption 회피 요령: 모두 CtrigAsm 자기수정 구조에서 생긴 제약이다.
- TEP "코드 유지"와 AppData 백업: 소스가 파일과 git 에 있다.
- VS Code EUC-KR 강제: 소스는 UTF-8 로 쓰고, 맵 문자열 인코딩은 함수(`u2b`/`u2utf8`)로 고른다.

## 7. CX Paint 를 eudplib 에서 쓰는 현실적 방법

**도형 계산은 (b) lupa 로 `CB Paint v2.5.lua`·`CSMakeSpiral.lua`·`CS_Addon.lua` 와 맵별 Lua 도형 코드를 수정 없이 돌리고, 결과 테이블을 파이썬 좌표 목록으로 받는 것이 현실적이다.**

- TEP 3.0 과 lupa 가 모두 Lua 5.4 라 의미 차이가 거의 없다.
- 필요한 보정은 세 가지다.
  - `bit32` shim: 이식 계층에 이미 있다.
  - `math.atan2 = math.atan` 한 줄.
  - BMP·CSSave 를 쓸 때 `FileDirectory` 전역 설정.
- 결과가 매번 같아야 하면 `math.randomseed` 를 고정한다. 원본은 `os.time()` 을 시드로 쓴다.
- 이미 `etc/extract_CAPlot_shapes.lua`(CAPlot 첫 인자에서 닿는 도형 정의만 뽑기)와 그 산출물 `44TRIG_CAPlotShapes.lua` 가 이 방식의 선례다.
- 파이썬 재작성(a)은 자주 쓰는 소수만 옮길 때 권한다. 사용 빈도 상위: `CSMakeCircle/Star/Line/Polygon`, `CS_MoveXY/RatioXY/Rotate/OverlapX/Merge`, `CS_Level`.

**트리거를 만드는 부분은 CX Paint 에 맡기지 말고 eudplib 으로 새로 짜는 편이 낫다.**

- `CSPlot` 류는 이식 계층에서 그대로 돌기는 하지만, 액션으로 꽉 찬 클래식 트리거라 겹쳐 쌓기 이득이 없다.
- 도형 좌표를 `Db`/`EUDArray` 로 싣고 `EUDLoopRange` + `f_dwread_epd` + `f_setloc` + `CreateUnit` 루프 하나로 찍으면, 트리거 수가 **도형 크기·개수와 무관**해진다. theSeed `CAPlotIndexed.lua` 가 CtrigAsm 안에서 이미 증명한 구조다.
- CA_ 실시간 변환은 그 루프 안에 `f_lengthdir`/`f_atan2`/`f_sqrt` 로 넣는다.
- CAPlot·CBPlot(8~11장)을 lupa 로 그대로 살리는 길은 `CVariable`·`CArray`·`NWhileX`·`f_Lengthdir` 같은 CtrigAsm 내부까지 이식 계층이 받쳐야 한다. 이 경로는 확인하지 않았다.

## 8. 확인 못 한 것

- CPLP.exe 가 eudplib 0.76.14 / euddraft 0.9.10.11 산출물에서 정상 동작하는지 (빌드 스크립트에는 계획만 있음).
- 이식 계층이 CAPlot 이 쓰는 CtrigAsm 함수(`f_Lengthdir`, `f_Sqrt`, `f_Atan2`, `CiDiv`, `ConvertLocation` 등)를 받쳐 주는지. `eud/ctrig/*.py` 에서 이름을 찾지 못했다. CtrigAsm Lua 원본 정의로 도는지는 실행해 보지 않았다.
- `keySelector` 플러그인(이 설치본에 없음), epScript 편집기 확장·EUD Editor 3 의 현재 기능(외부).
- TEP 대 eudplib 빌드 시간 실측.
- CPIP 의 정확한 보호 목적(코드 일부만 읽음).
- CS_Minimap·CS_Photo 를 실행해 보지는 않았다(존재 위치만 확인).
