# R2 — 이미 있는 구현·명세 재고 조사 (새 eudplib 라이브러리 `eudext` 설계 재료)

작성: 2026-09-17 02:40 무렵. 저장소 파일은 읽기만 했다. 시험과 측정은 TEMP·pycache 를 스크래치패드로 돌려서 실행했다.

**표기**
- `ctrig/` = `ScmDraft 2\DPS_eud\eud\ctrig\`, `spec/` = `DPS_eud\eud\spec\`, `tests/` = `DPS_eud\eud\tests\`
- `CA` = `MapSource\Library\CtrigAsm v5.5.lua`, `EP` = `C:\Users\whatd\.venvs\eud076\Lib\site-packages\eudplib\`
- "호환 전용" = Lua 모양, PlayerID, "X", Label/Index 번호, TEP 전역 같은 것에 묶인 부분
- "재사용" = Lua 없이 eudplib 객체만으로 도는 부분
- (추측) = 확인하지 못한 것

**주의: 작업 트리가 지금도 바뀌고 있다.** 이 조사 중에 다른 작업이 파일을 계속 고쳤다.
- `ctrig/war.py`(02:29)와 `ctrig/arrays.py`(02:33, 1012줄 → 1105줄)가 바뀌었고, 02:37 커밋 **dff4538** "실행량 최적화"로 들어갔다.
- 그 뒤 `ctrig/arith.py`(02:42, 619줄 → 662줄: `and_const`·`_mul_small`·f_Read 마스크 읽기 추가)와 `tests/t_core.py`(02:42)가 또 바뀌었다. 이 둘은 커밋 전이다.
- 한 번은 arrays.py 가 저장되는 도중에 읽혀(NUL 바이트) 시험이 import 에서 실패했다. 다시 돌린 시험은 통과했다.
- **줄 번호는 02:43 기준이다** (arith 662 / arrays 1105 / war 767 줄). 나머지 모듈은 02:04 이후 바뀌지 않았다.

---

## 1. 이식 계층 모듈 지도

### 1.1 모듈 표

| 모듈(줄) | 역할 | 호환 전용 | 재사용 가능 (순수 eudplib) |
|---|---|---|---|
| `lua.py`(88) | lupa 값 도우미. latin-1 로 Lua 바이트열과 str 을 1:1 로 오간다 | 전부 | CX Paint 를 lupa 로 돌릴 때 `lbytes/pystr/to_lua_str`(lua.py:64-88)과 `CtrigError`(10) 정도 |
| `luart.py`(225) | TEP 환경 흉내: bit32/bit64 Lua 구현(21-134), loaderscript 실행, 전역 소문자화, 파이썬 예외를 Lua traceback 과 함께 감쌈(137-206) | 전부 | lupa 로 Lua 도형 계산기를 돌릴 때의 틀. `_WRAP`(186)의 예외 위치 붙이기 |
| `runtime.py`(182) | TEP cflag2 로드 순서, `dofile` 경로 재매핑(19-32), C:\Temp 쓰기 격리(37-63), 원시 `Trigger{}` 싱크(138-154), FP 외 소유자 거부(156-161) | 전부 | 시험 격리 아이디어(쓰기 경로 재매핑)만 |
| `classic.py`(180) | TEP 조건·액션 표를 `Condition/Action` 으로 바꿈(44-72), Parse* 네이티브(87-148), `emit_raw` 의 disabled 플래그(`_flags|=8`, 175) | 전부 | `_tep_uprp`(151) 정도 |
| `api.py`(15) | 모듈 순서대로 `EXPORTS`/`LUA` 를 등록 | 전부 | — |
| `core.py`(981) | 공유 상태, 값 판별, 저장소 레지스트리, 32비트 대입, 부호 없는 비교, 조건·액션 서술자, materialize, 분기 부품, 라벨 | 레지스트리(42-58, 199-262, 425-480), Lua 판별(143-192), 서술자·감싸기(61-68, 668-842), `st_pop`(359), Labels(938-972), `_patch_funcbody`(89-107) | **비교** `c_ge/c_gt/c_lt/c_le/c_eq`(611-661): 경계값 처리 포함, 변수끼리는 포화 Subtract 한 번. **덧셈 접기** `plus`(385). **마스크 쓰기** `set_masked/write_addr`(509-542): 값·마스크가 변수여도 패치된 SetMemoryX 액션 1개. **분기** `branch/jump_if/jump_if_not`(872-904): 변수 필드가 든 액션을 분기 뒤로 나눔. **1회 분기** `once_branch`(907-931). **방출** `emit_trigger`(857). **CP 캐시 동기화** `cp_fix/set_cp`(545, 761-784). 임시 풀 `_Pool/scratch`(321-347) |
| `cells.py`(185) | CtrigX/SetCtrig1X/SetCtrigX/SetCtrig2X 를 주소로 번역. `CellAct.fold`(112) 로 초기값 굽기. next 조작형 SetCtrigX 는 라벨 엔진(`FlowAct`)으로 보냄(132-135) | 거의 전부 | `epd_act/epd_cond`(60-73): eudx 마스크 원시 액션·조건. eudplib `SetMemoryXEPD/MemoryXEPD` 와 겹친다 |
| `arith.py`(662) | CMov/CAdd/CSub/…/f_Read/f_Div 등 32비트 C 함수와 f_ 함수 | 인자 해석(`_mask/_src/_load/_modify`), Deviation/Clear 규칙, `Include_CtrigPlib`(623) | **변수 & 상수 마스크를 실행 3회로** `and_const`(51): 변수 트리거의 마스크 칸을 잠시 m 으로 두고 호출한다. **적은 비트 상수 곱을 배가·덧셈으로 펼침** `_mul_small`(268). **SC 마스크 Add/Subtract 의미** `_masked_sum`(87). **스위치 난수** `_swrand`(572, 동기 안전, 67트리거). **유닛 수 이진 탐색** `UnitReadX`(594, Command/Bring AtLeast 11단, 2047 포화). **부호 확장 읽기** `f_SHRead`(529). **바이트 배수 읽기** `f_ReadX`(509). 0 나눗셈을 포함한 상수 접기 `_divmod`(298). f_Read 의 마스크 경로는 `f_maskread_epd`(468~) |
| `arrays.py`(1105) | 변수·배열 배치(Layout), 원소 접근(VA/A/WA/LA), TMem/TLMem, Convert*, 파일·빈 메모리, 바이트·워드 T 액션, f_Memcpy, CreateCText 추적 | `Layout`(125-263, CreateVarPArr 따라잡기), CT_STRIDE 수출(1085), Convert*(667-751), `_new_label/_db_label`(756-767, 기준 = Db−0x970), `_TRACK/CTEXT` | **연속 변수 블록** `VarBlock`(49-68, EUDVarBuffer 하나를 따로 둠 → 연속 보장). **고칠 수 있는 dword 배열** `DwordArray`(71-100, 초기값에 ConstExpr 허용, 생성 뒤에도 값 수정 가능). **변수 트리거 호출 읽기** `call_read`(417): 인덱스를 ×18·×72 두 벌로 들고 다니면 SeqCompute 한 번과 트리거 한 개로 원소를 읽는다. **포인터 → (EPD, 바이트 위치)** `_bsplit`(863, 30단 공유 함수). **바이트/워드 값 이동** `_bval`(881). **변수 주소 바이트·워드 쓰기를 액션 하나로** `_ByteAct/TBwrite/TSetMemoryB/W`(910-973). **상수 바이트를 변수 포인터에 복사** `_static_copy`(997, CP+SetDeaths 32워드/트리거, 바이트 위치 4갈래) |
| `war.py`(767) | 64비트: Lua 값 해석(eval64/store64/mask64/pointer64), 산술 본체, f_L* 공개 함수 | `i64`(49, Lua tonumber 규칙), `eval64/val64/mask64/store64/_store_half`(75-195), `f_LMov` 편차 규칙(536), `f_Cast`(596), `f_LRead/f_LWrite/pointer64/TLMem`(623-740) | **본체 전부**: `_add64`(205), `_add64_inline`(398), `_neg64`(217), `_subwrap64`(230), `_lt64`(242), `_subsat64`(255), `_subsat64_inline`(406), `_shl1`(273), `_mul64`(288), `_div6432`(317), `_div64big`(340), `_divmod64`(368), `_rand64`(479), 상수 접기 판 `add64…mod64`(423-468), `_bit2`(470), `split`(66). `_set32`(130) |
| `tlib.py`(455) | T 조건·액션(변수 삽입), TT 비교(앞 계산 플래그), TTOR | T 인자 해석(`tval/tmask/target/player_arg/unit_arg`, 37-84), TT 모드 표(198-206, 275-286, 원본 비교 코드 번호), `resolve_or_elem`(380, Lua 팩 모양) | **부호 있는 비교** `flip`(167) + `cmp32`(217): gt/lt/ne/sge/sle/sgt/slt. **64비트 사전식 비교** `cmp64`(328): 부호 없음·있음. **조건 묶음 OR 을 플래그로** `flag_or`(189). **단락 OR 노드** `OrNode`(406) |
| `cp.py`(161) | RecoverCp(Lua 전역 `RecoverCpValue` 를 부를 때마다 읽음), T 유닛·자원 액션 | 전부. `recover_cp`(24), `amount_arg`(60, 변수는 "개수×2^24" 규약) | 없음 (eudplib Trigger 패치가 같은 일을 한다) |
| `flow.py`(538) | CIf/NIf/CIfX/NIfX/CWhile/NWhile/CFor/NJump/CJump/NBag. 종류별 스택(19-29) | 전부 (PlayerID 검사, IndexAlloc 증가, Lua UnPack) | NBag 구조(425-507: DwordArray + count, 맞바꿔 지우기) 정도. 스택 검사 `check_done`(512) 아이디어 |
| `trig.py`(323) | TriggerX/Trigger2/CTrigger/DoActions*/SetCall/CallTrigger | Flags 해석(63-99), 라벨 트리거, 64개씩 쪼개기 규칙 | **인자 없는 서브루틴 호출** `_emit_call`(256-274): 복귀 트램펄린의 next 에 복귀 주소를 둔다. 호출 1회에 트리거 1개. 조건부·1회 변형 있음. 재진입 불가 |
| `text.py`(400) | DisplayPrint 내부 교체: SetNext 라벨, f_GetStrXptr, f_Movcpy, 고정 폭 숫자, FixText, `init_Setting` Lua 판(335-388) | `FlowAct/SetNext`(44-73), `dp_ItoDec/ItoDecX/ItoHex`(186-242, DisplayPrint 설정만 받음), `init_Setting` | **고정 폭 숫자 → 바이트**: `_itodec16`(162, 부호 10진 16B), `_itodec48`(196, 전각 10진 48B), `_itohex12`(218, 대문자 16진 12B), `_lidec_body`(264, 64비트 부호 10진 20B). 부품 `_dec_digits/_lead_mask/_set_byte/_lt64c`(142-261). **변수 여러 개를 포인터에 바이트 복사** `copy_vars_to_ptr`(122) |
| `excc.py`(166) | EXCC(유닛 1700칸 × N 저장소 루프)의 파이썬 판 | API 모양(Install_EXCC/Part1~4X/ClearCalc/BreakCalc/End), Lua 전역(`EXCC_SLOT/EXCC_LINE`, 58-59) | 저장소 = `VarBlock`(24), 유닛 트리거가 칸 변수 트리거들을 사슬로 엮어 임시 변수에 복사(125-145). 구조만 참고할 것 (1.8 의 비용 참고) |
| `framework.py`(197) | StartCtrig/EndCtrig 틀, CtrigInitArr 를 초기값으로 굽기(142-176), 첫 사이클에 초기화 구역으로 점프(93-97) | 거의 전부 | `Enable_HumanCheck`(37-51): 0x57EEE8 플레이어 형에서 사람 비트 모으기 |

### 1.2 변수 레지스트리와 값 표현 (호환 전용)

- **공유 상태** `core.Ctx`(core.py:42-53)
  - `vars`: `(index, next)` → EUDVariable
  - `wars`: `(index, next)` → W 의 상위 반쪽
  - `ccodes`: Ccode 정수 → EUDVariable
- **저장소를 누가 만드나**
  - `var_at`/`hi_at`(209, 230)은 해석기 목록 `VAR_RESOLVERS/WAR_RESOLVERS`(56-58)를 먼저 묻는다.
  - 아무도 소유하지 않으면 새 `EUDVariable()` 을 만든다.
- **W 의 표현**
  - W = `(lo, hi)` 이고, lo 는 같은 번호의 V 와 같은 저장소다 (원본 +0x15C, G1 1.11).
- **칸 주소 번역** `cell_addr`(455)
  - CtrigAsm 의 `(Index, Address, Next)` 를 eudplib 주소로 바꾼다.
  - 0x148~0x168 → 변수 vtable + addr
  - 0x188~0x1A8 → hi 변수
  - Ccode 뱅크 → `0x1C8+4·Line`
- **배치** `arrays.Layout`(125)
  - Lua 전역 `CreateVarPArr` 를 따라잡으며(134) 번호마다 슬롯을 받는다.
  - V·W 하위·VArray 는 LO `VarBlock`, W 상위·WArray 상위는 HI `VarBlock` 에 번호 순서대로 들어간다(arrays.py:4-11). 그래서 묶음 원소 간격이 72바이트(EPD 18)로 일정하다.
  - CArray/LArray 는 `DwordArray(레코드 수 × 604)`(176-181) 이다.
- **G6 1.10 권고와 다르게 갔다**
  - G6 1.10 은 "2416 간격 유지"를 권했다.
  - 구현은 18/72 간격을 택하고, DPS 의 604/2416 리터럴을 Lua 전역 `CT_STRIDE/CT_STRIDE4` 로 바꿨다 (커밋 7e2ef3b, arrays.py:9-10).
  - 이유(docstring): 2416 간격이면 원소마다 약 2.4KB 가 는다. eudplib 할당기가 빈 칸을 채우지 못했다.
- **eudplib 비공개 속성에 기댄다**
  - `view()`(core.py:265): `EUDVariable.__new__` 를 쓰고 `_vartrigger/_varact` 를 직접 넣는다.
  - `set_initval`(274): `vt._initval` 을 고친다.
  - `VarBlock`: `EUDVarBuffer._initvals` 를 쓴다.
  - euddraft 0.9.10.11 의 `lib\library.zip` 안 eudplib 이 순수 `.pyc`(vbuf.pyc 포함)라서 접근은 된다(목록만 확인).

### 1.3 식 객체 (호환 전용)

- **파이썬 식 객체는 없다**
  - 임시식(`_Add` 등)은 원본 Lua 그대로 `STPushTrigArr` 에 쌓인다.
  - 소비 함수 첫 줄의 `core.st_pop`(359)이 Lua `STPopTrigArr` 를 부르고, 그것이 파이썬 `CAdd` 등을 부른다.
- **조건·액션은 지연 서술자로 넘긴다**
  - 파이썬이 만든 조건·액션은 `Cond/Act` 서술자다(668-716).
  - Lua 표 `{…, __py=obj}` 로 감싸서 넘긴다(61-68).
  - 소비 지점의 `materialize`(818)가 앞 계산 코드를 방출한 뒤 eudplib `Condition/Action` 을 만든다.
- **임시 변수 풀**
  - materialize 한 번 안에서는 `_Pool`(321)로 임시 변수를 돌려쓴다.
  - EUDFunc 본문을 만드는 동안에는 `_patch_funcbody`(89)가 풀을 끈다. eudplib 비공개 `_create_func_body` 를 몽키패치한 것이다.
- **새 라이브러리에는 이 기계장치가 필요 없다**
  - eudplib 연산자와 `Trigger()` 패치(tpatcher)가 같은 일을 한다.
- **다만 "코드를 먼저 내고 조건을 돌려주는" 함수 모양은 필요하다** (cmp64, 부호 비교 등)
  - `EUDIf()(f())` 는 `EUDIf()` 가 먼저 평가되고 `f()` 가 그다음 코드를 낸다. 그래서 분기 트리거보다 앞에 놓여 안전하다.
  - 루프 조건은 머리 안에서 매번 다시 계산해야 한다 (flow.py:5, G4 3.13).

### 1.4 블록 스택 (호환 전용)

- **스택 구성**
  - `flow.State`(19-29): CIf/NIf/CIfX/NIfX/CWhile/NWhile/CFor/NBag 종류마다 파이썬 리스트를 따로 둔다. CIf 와 NIfNot 은 같은 스택이다.
  - 레코드는 `Forward` 참/거짓 목적지를 들고 있고, 닫는 함수가 채운다(109-127).
  - 점프는 `jumpend` 사전에 둔다(338-351).
- **분기 부품**
  - eudplib `EUDIf/EUDWhile` 은 단일 블록 스택이라 교차나 점프가 끼면 assert 가 난다 (G4 1.9).
  - 그래서 모든 분기를 `core.branch`(EUDBranch 래퍼)로 직접 만든다.
- **새 라이브러리 관점**
  - 사용자 코드는 eudplib 제어문을 쓰면 된다.
  - 라이브러리 내부 부품만 `branch/jump_if/once_branch` 를 가져가면 된다.

### 1.5 CP 캐시 처리

- **쓰기마다 캐시를 같이 고친다** `core.cp_fix`(761-784)
  - CP(EPD 203155)에 쓰는 원시 액션(acttype 45, unit 0)마다, 같은 연산자로 두 칸을 고치는 액션 2개를 앞에 붙인다.
    - eudplib 캐시 변수(`curpl.GetCPCache()` 값 칸)
    - 캐시 검사 조건의 amount 칸(`cpcache_match_cond()+8`)
  - `resolve_act`(787)가 늘 `cp_fix` 를 거친다. 그래서 TEP 원시 `SetCp`/`RotatePlayer`/`TSetMemory(0x6509B0)` 도 모두 잡힌다.
- **다른 경로**
  - 마스크 CP 쓰기는 거부한다 (core.py:527, 773).
  - `set_cp`(545)는 상수·변수 CP 대입이다.
  - `driver.run` 은 본문을 `f_setcurpl(7)` 과 `f_setcurpl(oldcp)` 사이에 둔다 (driver.py:57-66, G7 1.2.6-1).
  - `recover_cp`(cp.py:24)는 Lua 전역 `RecoverCpValue` 를 호출할 때마다 읽는다 (G7 1.2.3).
- **G7 1.2.6-2 권고와 다르다**
  - G7 은 "eudplib 함수 앞에 `f_getcurpl()` 안전망"을 권했다. 구현은 "모든 CP 쓰기에 캐시를 같이 고친다"를 택했다.
  - 대가: CP 쓰기마다 액션이 2개 늘어 64개를 넘으면 `Trigger()` 가 나눈다(emit_trigger 861-864). G7 1.2.6-4 가 걱정한 곳이다.
- **G7 1.2.5 의 지적은 고쳐졌다**
  - 지적: `write_mem` 이 `f_dwread_epd` 를 불러 CP 가 낡은 캐시로 돌아간다.
  - 지금 `write_mem` 은 `write_addr`(SetMemoryX 1액션)이다.
  - `war._write_mem32`(149-160)는 아직 변수 마스크에서 `f_dwread_epd` 를 쓴다. 캐시가 늘 맞으므로 문제는 없다고 본다 (추측).
- **새 라이브러리 규칙**: CP 를 원시 액션으로 쓰지 말고 `f_setcurpl/SetCurrentPlayer` 만 쓴다. `cp_fix` 는 "원시 액션 목록을 받는 헬퍼"를 만들 때만 필요하다.

### 1.6 64비트 표현과 알고리즘 (war.py)

- **값 표현**
  - `(lo, hi)` 쌍이다. 각 반쪽은 EUDVariable 이거나 int 다.
  - 둘 다 상수면 파이썬에서 접는다(423-468).
- **본체와 비용**
  - 크기는 `EUDFuncN.size()`, 실행량은 에뮬레이터 실측값이다 (4.4 절).

| 연산 | 방식 | 트리거 수(본체) | 실행 트리거 수 |
|---|---|---|---|
| add | `rl=al+bl; rh=ah+bh; rl<bl 이면 rh+=1`. 공개 경로는 인라인 `_add64_inline`(398, SeqCompute + 트리거 1) | EUDFunc 판 10 | EUDFunc 판 34 |
| subsat (f_LSub) | 인라인 `_subsat64_inline`(406): 반쪽별 포화 뺄셈 2쌍 + 빌림 보정 점프 3개. EUDFunc 판(255)은 `_lt64` + 분기 | 27 | 51 |
| subwrap (f_LiSub) / neg | `_subwrap64`(230), `_neg64`(217): 비트 반전 + 1 + 올림 | 12 / 12 | — |
| mul | `_mul64`(288): b 의 비트를 위에서부터 64번 본다. 결과를 두 배(`_shl1`) 하고, 비트가 서면 `_add64` 호출 | 41 | **2,268 (작은 수) ~ 4,626 (전부 1)** |
| divmod | `_divmod64`(368) 경로 셋 | 28 + 293 + 550 | 32/32: 287, 64/32: 675, 64/64: 711, d=0: 34, n<d: 35 |

- **divmod 경로 셋**
  1. 제수 hi=0 이고 피제수 hi=0 → eudplib `f_div`
  2. 제수 hi=0 → `f_div(nh,dl)` 뒤 `_div6432`(317): 복원 나눗셈 32단
  3. 제수 hi≠0 → `_div64big`(340): 몫 < 2^32 이므로 32단
- **0 나눗셈**: 몫 = 0xFFFF…FFFF, 나머지 = 피제수.
- **비교 기준값**: eudplib `f_div` 32/32 는 252 실행, `f_mul` 변수×변수는 26~205 실행.
  - 그래서 곱셈을 16비트 쪼개기로 바꾸면(G3 1.10 이 제안) 64회 루프보다 훨씬 싸질 것이다 (추측, 미측정).
- **난수**: `_rand64`(479) = `f_dwrand()` 2번 (크기 6).
- **의미 규칙** (war.py:4-10, G3 1.5)
  - LAdd/LiSub/LMul/LNeg 는 wrap, **LSub 는 포화**
  - LDiv/LMod 는 부호 없음
  - `f_LMov` 편차는 반쪽별 덧셈이라 올림이 없다
  - 숫자 입력은 0 확장, 문자열은 Lua tonumber 로 64비트 wrap
- **구현하지 않은 것**
  - 부호판 f_LiMul/f_LiDiv/f_LiMod/f_LAbs, f_LlShift/f_LNot. G3 1.5 에 의미만 있다. DPS 는 쓰지 않는다.

### 1.7 arith.py 의 마스크·포화 연산

- **마스크 의미** (G2 1.3, SC 마스크 액션을 식으로 정리한 것 — 추정 포함, G2 8-1)
  - SetTo `(d&~m)|(v&m)`
  - Add `(d&~m)|(((d&m)+(v&m))&m)`
  - Subtract `(d&~m)|max(0,(d&m)-(v&m))`
- **구현 위치**
  - `_masked_sum`(87): 꽉 찬 마스크면 `plus` 이거나 포화 SeqCompute Subtract 다. 부분 마스크면 `_and` 두 번 → Add/Subtract → `_and` 다.
  - `_and` 는 변수 & 상수일 때 `and_const`(51)를 쓴다. 변수 트리거 마스크 칸 트릭으로 `f_bitand` 호출보다 싸다.
  - `_store`(106): Clear 규칙 `(Dev&~m)|(v&m)`.
- **뺄셈의 차이**
  - `CSub` 2인자형은 modifier 9(Subtract) 액션이라 **포화**다(arith.py:228).
  - `CiSub` 는 `Add(-x)` 라 **wrap** 이다(249).
- **0 나눗셈**
  - `f_Div(x,0)` = 0xFFFFFFFF (eudplib `f_div` 와 같다, EP `core/calcf/muldiv.py:66`)
  - `CDiv(상수 0)` → 1 (arith.py:332, G2 1.8)
- **마스크 쓰기 두 벌**
  - 값·마스크가 변수인 마스크 쓰기는 `core.write_addr`(521) 쪽이 싸다. 패치된 SetMemoryX 1액션이다.
  - `war._set32`(130)는 `f_bitand/f_bitor` 3회라 비싸다. 새 라이브러리에서 하나로 합칠 후보다.

### 1.8 excc.py (유닛별 저장소)

- **구조**
  - 저장소: `VarBlock` 에 1700 × size 칸(excc.py:24-25)
  - `EXCC_Part4X`(125): 유닛 i 마다 트리거 1개를 둔다. 조건이 참이면 다음을 하고 칸 0 의 변수 트리거로 점프한다.
    - 칸 변수 트리거 N개의 dest·modifier·next 를 고쳐 "호출 사슬"을 만든다(134-138). 사슬 끝이 본문이다.
    - CP ← 19025+84i
    - `Last.next` ← 다음 유닛
  - 바깥에서 짚는 식은 `헤더 EPD + i·EXCC_SLOT + 줄·EXCC_LINE` 이다(Lua 전역, 58-59).
- **비용** (4.4 실측)
  - 매 사이클 유닛 트리거 1700개를 검사한다.
  - 1700×6 칸을 `VarBlock` 으로 두면 메모리에 약 734KB(72B×10200) 다. scx 는 압축 후 **+11.5KB** 다.
  - 같은 칸을 `EUDArray(10200)` 로 두면 40.8KB, scx **+0.66KB** 다.
- **새 라이브러리 권고**: G9 2.3.1 과 cmp_A2 가 권하는 `EUDArray(1700*N)` + `EUDLoopNewUnit/EUDLoopUnit2/UnitGroup` 이 용량과 실행량 모두 낫다 (실행량은 추측). 칸 사슬 복사는 필요 없다.

### 1.9 text.py (문자열)

- **고정 폭 숫자 루틴**은 모두 공유 `@EUDFunc` 이고, 결과 dword 를 돌려준다(바이트 배치는 G8 1.4).
  - `_itodec16`: 59 트리거, 72~80 실행
  - `_itodec48`: 52 트리거
  - `_itohex12`: 67 트리거
  - `_lidec_body`: 607 트리거, 325~447 실행
- **알고리즘**: 나눗셈 없이 "큰 자리값부터 8·4·2·1×10^k 이상이면 빼고 그 자리 바이트에 더하기"(`_dec_digits` 146). 앞자리 가림은 `_lead_mask`(156) 가 한다.
- **64비트**
  - 상수 10^i 와의 64비트 비교를 `_lt64c`(253)의 OR 조건 목록 + 플래그로 한다.
  - 음수면 `war.neg64` 뒤 "앞자리 0 포함"이다(원본 DisplayPrint 모양, G8 1.4(d)).
- **공개 함수는 DisplayPrint 설정만 받는다**
  - `dp_ItoDec`: ZeroMode 2, Sign 1, 색 없음 (186-190)
  - 나머지 설정은 오류로 멈춘다.
- **출력 경로**: 결과를 VArr 원소 변수에 넣은 뒤 `f_Movcpy`(128)가 `copy_vars_to_ptr`(122: 임시 DwordArray + `f_memcpy`)로 바이트 복사한다.

### 1.10 cells.py

- **번역 대상**: `CtrigX(P,Index,Address,Next,…)` 는 `cell_addr` 로 주소를 풀어 `Memory/MemoryX` 조건이 된다(83-89).
- **SetCtrig1X / SetCtrigX**
  - `CellAct`(92) 서술자가 된다.
  - EndCtrig 가 `CtrigInitArr` 안의 SetTo·마스크 없는 것을 초기값으로 굽는다 (framework.py:142-155 → arrays.py:238 `fold`).
- **next 조작형 SetCtrigX**
  - 모양: Address1=0x4, Address2=0
  - `text.FlowAct`(라벨 Forward 의 SetNextPtr)로 바꾼다.
  - DPS `OnInit.lua:213` ExitDrop 줄이 이 경로로 가서 "0xFFFD 의 next ← 자기 다음" = 사실상 아무 일도 안 한다 (framework.py:178-180).
- **거부하는 것**: `"X"` 자기수정은 오류로 멈춘다(76-80).
- **새 라이브러리에서 남는 것**: `epd_act/epd_cond` 정도뿐이다.

---

## 2. 기능별 재고 표 (비교 문서 README "CtrigAsm 에만 있는 것")

**먼저 알아 둘 것: DPS 가 실제로 부르는 것만 명세·구현됐다.**
- DPS 소스(`eud\` 제외)를 검색한 호출 수: `f_Lengthdir/f_Atan2/CiDiv/CreateBullet/CA__*/CD__ScanW/MousePress/IsTyping/f_Diff/f_Log2/HotkeyUnit/GetHostPlayerID/NSQCSend/TStruct/CDPrint/Stage/iAtLeast` 는 **0회**다.
- `KeyPress` 60회(7파일), `DisplayPrint` 619회, `ExitDrop` 1회(주석 달린 SetCtrigX 형태)다.
- 그래서 README 표의 대부분은 **G1~G9 명세도, 이식 계층 구현도 없다.**

| 기능 | 명세(G?절) | 구현(파일:줄) | 알고리즘·비용 | 시험 | 새 라이브러리로 옮길 때 |
|---|---|---|---|---|---|
| **64비트 변수·연산** (CA 22장, W 계열) | G3 전체(1.1 저장 모양, 1.2 I64, 1.4 마스크, 1.5 의미, 1.6 포인터·비교, 1.10 구현 방향, 2절 math128, 4절 기대값), G1 1.3·1.6.4·1.7 | war.py 본체 205-480, 공개 f_L* 505-746. 64비트 비교 tlib.py:328 `cmp64`. 64비트 배열 원소 arrays.py:477-517 | 1.6 표. 곱셈이 가장 비싸다(최대 4,626 실행) | t_war.py: G3 4절 27건 + 나눗셈 경로 17쌍×2 = **61건 전부 통과**. t_core: NWar/SetNWar/WArr/WArrX 5건 | ① Lua 해석층(`eval64/store64/mask64/pointer64/i64`, "X", 편차 규칙)을 버리고 `Var64` 형을 만든다(lo/hi EUDVariable, 연산자, 상수 접기, EUDStruct 필드·2칸 배열 원소, EPD 쌍 포인터). ② `core.scratch` 풀 대신 함수 지역 변수. ③ 뺄셈 의미를 이름으로 가른다(sub_sat 과 sub_wrap). ④ 곱셈은 `f_mul` 16비트 쪼개기로 바꿀지 검토. ⑤ 비교는 반쪽별(NWar)과 사전식(TTNWar)을 헷갈리지 않게 사전식만 연산자로. ⑥ 부호판 연산은 새로 짠다(G3 1.5 의미표) |
| **64비트 숫자↔문자열** (`CA__lItoCustom` CA:51398, `CD__ScanW` CA:54540) | 이 함수들 자체는 없음. 64비트 → 10진 고정 20바이트만 G8 1.4(d) | text.py:264 `_lidec_body`, 245 `dp_lItoDec`. 문자열 → 64비트 파싱은 **없음** | 나눗셈 없이 8·4·2·1×10^i 비교·뺄셈을 i=18..0. 607 트리거, 325~447 실행 | 없음 (이 조사의 측정 스크립트로 0, 12345678901234, 2^64−1, 2^63 의 바이트가 G8 1.4(d)와 맞음을 봤다) | 출력 모양(앞 0x0D, 음수는 0 채움)이 DisplayPrint 전용이다 → 채움 문자·부호·최소 자릿수·색을 인자로. 가변 길이 출력(EUDByteWriter 방식)도 필요. ScanW(파싱)는 새로 |
| **숫자 서식** (`ItoDec` CA:58336, `ItoHex` CA:58673, `CA__ItoCustom` CA:50699) | G8 1.4 (a)(b)(c), 2절 "dp.ItoDec / ItoDecX / ItoHex" | text.py:162 `_itodec16`, 196 `_itodec48`(전각), 218 `_itohex12`. 공개 186/209/237 은 DisplayPrint 설정만 | 비교·뺄셈 자리 추출. 59/52/67 트리거. itodec16 72~80 실행 | 없음 (측정으로 0, 5, −5, 2^31−1 바이트가 G8 1.4(a)와 맞음을 확인) | ZeroMode·Sign·DigitMax/Min·Color·Case·진법을 일반화하고, VArr 원소가 아니라 바이트 포인터나 버퍼에 쓰게. `f_sprintf/f_dbstr_adddw` 는 부호 없는 가변 10진과 8자리 16진만 된다 (G8 1.9, README) |
| **글자 이동·색 변환** (`CA__MoveXY` CA:48587, `CA__ConvertColor` CA:50156) | 없음 | 없음 | — | — | 새로 짠다. 원본은 SVA1(글자당 4바이트) 형식 기준 → eudplib 에선 바이트 버퍼(`StringBuffer`/Db)에 대해 짠다 |
| **총알·스프라이트, CGRP** (`CreateBullet` CA:81453, `CreateSprite` 81717, `ScanSprite` 81315) | 없음 | 없음 | — | — | 새로 짠다(cmp_A2 3절: 스캔·자폭·리콜 원리). 에뮬레이터는 CreateUnit 계열을 흉내 내지 못한다 → 인게임 확인 필요 |
| **키·마우스 입력** (`KeyPress` CA:80238, `MousePress` 80283, `IsTyping` 80326, 키 이름 표 `ParseKeyName` CA:80174) | G7 1.5(로컬 조건 규칙), 2절 KeyPress·LocalPlayerID, 3절 9번 기대값 | 파이썬 구현 **없음** — 원본 Lua 를 그대로 돌린다: KeyPress → MemoryB → TEP 조건 표 → `classic.to_condition`(44) | `MemoryX(0x596A18+VK 정렬, Exactly, v<<8r, 0xFF<<8r)` 조건 1개 | 없음 (G7 3-9 기대값만) | 키 이름 → VK 표를 파이썬 dict 로 옮긴다. 로컬 조건이라는 표시·경고(공유 상태 금지, `IsUserCP` 와 다름). 누름·뗌 순간 판정(TT판)은 이전 값 변수로. 동기화가 필요하면 MSQC/NSQC 플러그인 |
| **부호 있는 비교** (`iAtLeast` 등) | G1 1.6.4 (32비트 모드 10~13, `"i<"` 문자열이 없는 원본 오타), G3 1.6 (64비트 모드 25~28) | tlib.py:167 `flip`, 217 `cmp32`(sge/sle/sgt/slt), 328 `cmp64` 부호 모드 | 양쪽에 +0x80000000(SeqCompute) 뒤 부호 없는 비교. 비교 부품 `core.c_gt` 가 경계(x=0xFFFFFFFF → Never)를 처리 | t_core "TTCVar iAtLeast" 1건(32비트 sge) 통과 | 거의 그대로 떼어 쓸 수 있다. 조건 목록을 돌려주는 `s_ge/s_lt…` API로. 64비트 부호판도 같은 틀 |
| **삼각함수 임의 주기** (`f_Lengthdir` CA:35153, `f_Atan2` 34879, `f_Atan2X` 35016, `Include_MatheMatics` 31196) | G2 1.10·G5 Include_CtrigPlib (전역 `AngleCycle/LengthdirMode` 만) | **없음**. arith.py:632-633 이 전역만 설정 | — | — | 새로 짠다. eudplib `f_lengthdir` 는 `angle >= 360` 이면 `%360` 만 한다 (EP `eudlib/mathf/lengthdir.py:34`) → 음수 각 보정, 임의 주기 표(EUDArray), 고정밀 모드 |
| **CX Paint 도형** (`CB Paint v2.5.lua` 33,628줄) | 없음 | 없음. lupa 틀(luart.py·lua.py)은 있다 | README: lupa 로 좌표만 계산하고 Db + 루프로 찍기 | — | lupa 다리(latin-1 오가기, bit32, `math.atan2 = math.atan` 한 줄)는 luart.py 에서 떼어 온다. 호환 계층의 TEP 흉내 전체는 필요 없다 |
| **도형 → 유닛 소환** (`CSPlot`, CreateUnitShape.lua) | 없음 | 없음 | README: CSPlot 1,700점 ≈583KB, 루프 방식 ≈14KB | — | 좌표 Db + `f_setloc` + CreateUnit 루프(theSeed `CAPlotIndexed.lua` 구조). 에뮬레이터에 로케이션 모델이 없다 |
| 작은 것: `f_Diff` CA:74698, `f_Log2` CA:34772 | 없음 (G5 Include_CtrigPlib 가 이름만) | 없음 | — | — | 새로 짠다 (이전 값 + `f_getgametick` / 비트 스캔 32단 또는 `EUDBinaryMax`) |
| 작은 것: 방장 `GetHostPlayerID` CA:80111, `HotkeyUnit` CA:80795, 관전자 채팅(ObserverChat.lua) | 없음 | 없음 | — | — | 주소 상수 + Memory/SetMemory, `f_memcmp` 루프 (cmp_A2 3절) |
| 작은 것: `NSQCSend/Receive` CA:80851/81014 | 없음 | 없음 | — | — | SCR_DB 수신기(G8 1.10)가 비슷한 일(워드 조각·토글)을 한다 → 일반화한 "dword 채널 수신기"로 묶을 수 있다 |
| 작은 것: `ExitDrop` CA:83529 | G9 2.3 (DPS 는 `OnInit.lua:213` 의 SetCtrigX 형태 → "수정/삭제"), G5 1.7 B·3절(효과 없음으로 추정) | 원본 ExitDrop 은 **없음**. DPS 줄은 cells.py:132 → FlowAct 로 흡수되어 사실상 아무 일도 안 함(framework.py:178-180) | 원본: 대상 로컬에서 STRCtrig 내부 라벨의 next 를 자기 자신으로(무한 루프) | — | 원리 미확인(README). "로컬 조건 + 자기 자신으로 점프하는 RawTrigger" 로 흉내 가능 (추측) |
| (README "소리 없이 틀리기 쉬운 곳") `CiDiv` CA:25314 / `CiMod` 26882 의 0 나눗셈 | G2 1.8 표에는 CiDiv 없음 (f_iDiv 이름만) | 없음 | 원본: 양수 → 0x7FFFFFFF, 음수 → 0x80000000. eudplib `f_div_towards_zero`(EP `eudlib/mathf/div.py:14`)는 −1/1 | — | 부호 나눗셈 헬퍼를 둘 거라면 `b==0` 분기로 CtrigAsm 값과 eudplib 값 중 하나를 정해 문서화 |

---

## 3. "대체" 항목의 헬퍼 후보

| 항목 | 명세 | 현재 구현 | 상태 | 새 라이브러리 헬퍼 제안 |
|---|---|---|---|---|
| **EXCC → 유닛별 배열** | G9 2.3.1 (구조, 주소식 사용처, eudplib 방향), G5 1.7 D, G6 1.9 E | excc.py 전체 + arrays.VarBlock. DPS 쪽 `EXCC_SLOT/EXCC_LINE` 치환 | DPS 전체 컴파일·스모크 통과(4.2). 전용 단위 시험 없음 | `UnitArray(n_fields)` = `EUDArray(1700*N)` 또는 `EUDStructArray`. 색인 = `(ptr−0x59CCA8)//336`(`CUnit` 과 같음). `EUDLoopNewUnit/UnitGroup` 과 짝. VarBlock 판은 용량 불리(1.8). CP 가정(G9 2.3.1 끝, 본문이 `CP = 유닛 EPD+19` 전제)은 호환 쪽 문제 |
| **TStruct → EUDStruct 풀** (TStruct.lua 333줄, `TStruct_init` :79, `TS_CreateArr` :171) | 없음 (G5 1.6 은 CreateCallIndex 공유만, G7 은 TStruct.lua:140 CopyCpAction 언급만) | 없음. DPS 미사용 | — | EP `EUDStruct.alloc/free`(`core/eudstruct/eudstruct.py:33,39`, 내부 `ObjPool` `eudlib/objpool.py:40`). TStruct 가 제공하던 "살아 있는 슬롯마다 공통 처리"가 없다 → 살아 있는 객체만 도는 반복자(EUDQueue/EUDDeque 에 포인터 보관)를 더한 풀 헬퍼 |
| **Timer / TimerX / Stage** (CA:55053 / 55505 / 80330) | 없음. G8 1.5 의 DisplayPrint `ResetTimer`(Ccode 카운트다운: `SubCD` 포화 + `CD==0` 이면 재설정)만 | 없음 (DisplayPrint Lua 안에서만) | DPS 미사용 | 변수 카운터(포화 감소 = Subtract 액션) + `EUDIf`, 단계는 `EUDSwitch`(EP `ctrlstru/swblock.py`). **주의**: EUDSwitch 는 CP 를 캐시로 되돌린다(G7 1.2.5) — 새 라이브러리에선 CP 를 원시로 안 쓰면 무해. TimerX 유리수 주기는 누산기 한 개 |
| **CDPrint / DisplayPrint → 출력** | DisplayPrint: G8 1.2~1.9, 2절 전체. CDPrint(CA:52633)는 없음 | DisplayPrint 본문은 **원본 Lua 유지**. 내부 교체: text.py(서브루틴·FixText·f_Movcpy·f_GetStrXptr), arrays.py:813 `f_GetTblptr`(GetTBLAddr), 1038 `f_Memcpy`(+`_static_copy`), 937 `TBwrite` | 스모크 통과. 단위 시험은 t_core TBwrite 1건뿐 | G8 1.9 API 선택표가 그대로 설계 재료다. 고정 배치가 필요하면 `f_sprintf/f_settbl` 금지(NUL·가변 길이). 새 헬퍼 제안: "틀 문자열 + 컴파일 시점에 계산한 슬롯 오프셋 + 고정 폭 숫자 루틴(text.py)", 12번 줄 = `f_raise_CCMU` + 로컬 분기(G8 1.7), TBL = `GetTBLAddr + f_memcpy`. DisplayPrint 의 전역 계약(RetV/Dev/BSize)은 호환 전용 |
| **SCR_DB 저장/불러오기** | G8 1.10(레이아웃 7), 1.11(호환 체크리스트 36항), 3절(코어), 4절(DPS 어댑터), 6절 | 파이썬 구현 **없음**. `MapSource\Library\SCR_DB_Core.lua`(394줄)와 어댑터 `DPS_eud\SCR_DB.lua`(399줄)를 Lua 로 돌린다. 어댑터는 하나 더 있다: `MapSource\MSF_UE_RE\SCR_DB_MSF.lua`(데스값 방식) | DPS 스모크 통과(매니페스트가 격리 폴더에 써짐 확인). 수신기 단위 시험 없음(에뮬레이터는 DeathsX·SetMemory 를 지원하므로 짤 수 있음) | 아래 3.1 |

### 3.1 SCR_DB 코어를 eudplib 네이티브로 만들 가치와 제약

**가치**
1. 새 eudplib 맵과 MSF 계열이 Lua 호환 계층 없이 쓴다. 코어는 기본 함수만 쓰므로 직역이 쉽다 (G8 3절 "파이썬 직역 시" 메모).
2. **용량과 실행량을 줄일 수 있다**
   - 수신기는 채널 8 × 사람 4 = 32벌을 펼친다 (SC:257-299). 벌마다 CIf 5개, f_Read 2회, CMov 3회, TriggerX 2개다.
   - 네이티브 판은 다음이 가능하다.
     - `f_maskread_epd` 1회로 Echo·Pay·꼬리표를 모두 얻는다 (G8 3절)
     - 상태(Tog/HaveLo/Key/Lo)를 `PVariable`/배열로 둔다
     - 본체를 `EUDFunc(k, i)` 하나로 합친다
3. epScript 에서 부를 수 있는 API(`setup/anchor/receiver/notify/save_signal`)가 된다.

**제약** (런처 호환 — 어기면 조용히 깨진다)
- **(a) 단일 출처**
  - 레이아웃 상수(`SCRDB_I` 칸 번호, `SCRDB_MAGIC`, 토글·꼬리표 비트, 예약 워드)는 Lua(SC:31-89)와 런처(`DPS_eud\tools\scr_db_launcher.py:56` `SUPPORTED_LAYOUTS=(6,7)`, LN:61-74 칸 표)에 이미 **두 벌** 있다. G8 3절은 "값을 파이썬으로 옮겨 적지 말 것"이라고 했다.
  - 네이티브 판은 둘 중 하나로 가야 한다.
    - 빌드 때 lupa 로 SC 를 읽어 상수를 가져온다
    - 공통 JSON 명세를 새로 만들어 세 곳이 읽게 한다
- **(b) FieldHash·ID 는 바이트 단위로 같아야 한다**
  - djb2: `h=5381; h=(h*33+b)%2^32`. 한 줄은 `"%s|%s|%d\n" % (id, mode, index|slot)` 이다 (SC:127).
  - 이름이 겹치면 `name#modeN` 이다 (SC:103).
  - 입력 순서는 어댑터가 준 필드 순서다 (DPS 는 `pairs(SCA_DataArr)`).
  - JSON 은 키 정렬, 특정 이스케이프, `%d` 규칙을 따른다 (SC:323).
  - 기존 매니페스트와의 대조는 아직 안 됐다 (G8 1.11-28, 6-7).
- **(c) 주소 규칙** (G8 1.11 A)
  - 표지 블록 168 dword 는 미러 구역 0x57F0E0~0x59F0E0 안에 둔다. 칸 10 = 블록 EUD 주소, 칸 11/13 = 바이트 주소, `DataOffsetArr` = EPD.
  - **시그니처 8 dword 가 페이로드에 연속으로 나타나면 안 된다** (Db/EUDArray 금지, SetMemory 8액션으로만 쓴다; 1.11-10).
- **(d) MSQC 채널**
  - 주소 0x58F508+4k, 데스 유닛 21~28, eds 8줄 형식 (build_eud.py:36-40).
  - eudplib `IsPName/f_check_id` 계열은 `_get_player_lightvar` 가 0x58F524(=채널 7)를 쓰므로 **사용 금지** (1.11-6).
- **(e) 타이밍** (1.11 C)
  - 1회 블록은 0 초기화 → 헤더 → **시그니처 마지막** 순서이고, 수신기가 처음 돌기 전에 끝나야 한다.
  - Seq·LocalPlayer 는 매 사이클 쓴다.
  - 수신기는 MSQC `beforeTriggerExec` 수신과 같은 사이클에 돈다 (플러그인 순서 `[MSQC]` → 본 플러그인).
  - SaveSeqP 는 명령 4 에서만 올린다.
- **(f) 로컬과 공유의 경계** (1.6)
  - Notify·LocalPlayer 칸은 로컬 전용이다. 공유 변수를 건드리면 안 된다.
  - 저장 완료 문구는 MSQC 로 받은 `SaveDone` 으로만 연다.
- **(g) 상태기계 세부** (G8 3절 함정)
  - 토글 두 if 는 else 가 아니다.
  - Count 불변식은 `Tog == Count mod 2` 다 (1회 블록이 0 으로 지움).
  - 꼬리표 2(HI) 뒤에도 HaveLo 를 내리지 않는다.
  - 키는 0xFFFD 미만, 예약 워드는 꼬리표 0 일 때만 인식한다.
- **(h) BuildId** = `os.time() % 0x7FFFFFFF` 다. 런처는 빌드 ID 가 안 맞으면 FieldHash 로 고른다.
- **(i) 맵별로 다른 부분은 어댑터에 남는다**
  - DPS 의 Write 콜백은 VArrX 간격 관용구(`SCR_DB.lua:303-309`)와 void 할당 순서(`SCR_CarveVoid`, `VoidAreaAlloc`; G9 2.5, 6.1)에 묶여 있어 호환 전용이다.
  - 네이티브 판은 Write 를 파이썬 콜백(`write(i, key_var, val_var)`)으로 받는다.
- **판단**
  - 코어(SC)만 네이티브로 옮기고 DPS 는 계속 Lua 판을 써도 된다. 같은 런처 규약이기 때문이다.
  - 이때 두 판의 FieldHash·매니페스트가 같은 입력에서 같은지 **시험으로 고정**해야 한다. lupa 로 SC 의 `SCRDB_FieldHash/Json` 을 돌려 파이썬 판과 비교하면 된다.

---

## 4. 시험 도구

### 4.1 무엇을 흉내 내나

**emu.py (255줄)**

- **페이로드 얻기** `Program.build`(67-119)
  - `SaveMap` 을 그대로 돌리되 eudplib 비공개 함수 두 개를 가로챈다: `maprw.savemap.apply_injector`, `maprw.injector.apply_injector.initialize_payload`(91-109).
  - 재배치 전 페이로드와 루트 트리거를 얻는다.
  - `prttable/orttable` 로 BASE=0x10000000 에 재배치한다(112-117).
  - 확인할 주소는 `_Probe` EUDObject(29-48)가 `WritePayload` 시점에 `Evaluate()` 해 모은다. EUDVariable 값 칸, RawTrigger 객체 등 무엇이든 된다.
- **메모리 모델**
  - 희소 dict 이고, 없는 주소는 0 이다.
  - 쓰기는 4바이트 정렬 주소만 된다. 비정렬 주소면 예외다(`setdw` 141-145).
  - 게임 메모리 표(CUnit, 문자열, TBL, 로케이션, 0x512684 등)는 없다. 모두 0 이다.
- **실행** `cycle`(224-255)
  - 루트부터 next 포인터를 따라간다. 액션을 실행한 **뒤** next 를 읽으므로 자기수정이 반영된다.
  - 플래그: +2376 의 8 = 꺼짐, 4 = 보존. 비보존 트리거는 실행 후 끈다.
  - 페이로드 밖으로 점프하면 예외, 실행 한도(기본 500만)를 넘어도 예외다.
  - 사이클마다 `(실행 트리거 수, 끝 주소)` 를 기록하고, 정상 끝은 0x80000000 이다.
  - 사이클 사이에 `setdw` 로 입력을 넣을 수 있다 (측정 스크립트가 이렇게 씀).
- **조건** `_cond`(159-190)
  - Deaths/Memory(condtype 15)의 AtLeast/AtMost/Exactly 와 eudx 마스크, Always(22)/Never(23)를 흉내 낸다.
  - 꺼진 조건(flags&2)은 참으로 본다.
  - **그 밖의 조건은 거짓**으로 보고 기록만 한다: Command/Bring/Switch/Accumulate/ElapsedTime…
  - 다른 비교 코드는 예외다.
- **액션** `_act`(192-222)
  - SetDeaths(45)의 SetTo/Add/Subtract(포화)와 마스크를 흉내 낸다. 마스크 식은 G2 1.3 의 추정식이다.
  - **그 밖의 액션은 기록만** 한다: SetSwitch·CreateUnit·DisplayText·MoveLocation·SetResources…
- **CP·플레이어 번호**
  - player 13(CurrentPlayer)은 0x6509B0 값을 쓴다.
  - 12·14~26 은 예외다.
  - EPD 트릭(큰 player 값)은 `unit*12+player` 로 처리한다.
- **플레이어 목록**: 목록은 하나(루트)뿐이다. `beforeTriggerExec/afterTriggerExec`, PTrigger, 플레이어별 CP 시작값은 모델이 없다.

**luatest.py (103줄)**
- DPS 와 같은 Lua 환경을 만든다: Library 를 불러오고 `__ctrig_install`(PRELUDE 33-41)을 한다.
- Lua 조각을 setup(1회)·body(매 사이클)로 나눠 넣고, Lua 전역 이름으로 V/W 값을 읽는다.
- 레지스트리는 body 실행 뒤에 정해지므로 지연 탐침 `_Late`(81-92)를 쓴다.
- **호환 전용**이다: driver·Library·DPS_headless.scx 에 묶여 있다.

**시험 파일**
- `t_core.py`: (이름, 선언 Lua, 본문 Lua, [(전역, 기대값)]) 표를 한 프로그램으로 모아 1사이클 돈다. `--multi` 는 3사이클.
- `t_war.py`: G3 4절 + 나눗셈 경로 표.
- `t_smoke.py`: DPS 전체를 에뮬레이터로 돌린다.
- `t_profile.py`: RawTrigger 생성 위치 → Lua 줄로 실행량을 모은다. `RawTrigger.__init__` 과 `_create_func_body` 를 몽키패치한다.

### 4.2 실행 결과 (이 조사에서 실행)

- 파이썬: `C:\Users\whatd\.venvs\eud076\Scripts\python.exe`
- TEMP·PYTHONPYCACHEPREFIX 를 스크래치패드로 돌렸다.
- 내 실행은 저장소에 아무것도 쓰지 않았다. 그사이 `git status` 가 바뀐 것은 다른 작업의 커밋(dff4538)과 수정 때문이다.

| 시험 | 결과 | 시간 |
|---|---|---|
| `t_emu_basic.py` | 통과. 5사이클 값 `v=3..15, w=0/100/200, x=5−7k wrap`, 199 실행 | 3s |
| `t_war.py` | **61/61 OK**, 22,945 실행. dff4538 뒤 02:43 재실행도 61/61, 23,570 실행 | 2s |
| `t_core.py` | 첫 실행: **75/75 확인 OK**. 02:43 재실행(파일이 51케이스·86확인으로 늘어남, arith.py 변경분 포함): **86/86 OK**, 2,609 실행. 흉내 못 낸 액션: CreateUnit(44) | 2s |
| `t_core.py --multi` | **3/3 OK** (CIfOnce, TriggerX 1회, CTrigger 보존) | 1s |
| `t_smoke.py 3` 1차 | **실패** — `SyntaxError: source code string cannot contain null bytes`(ctrig 모듈 import). 같은 시각에 arrays.py 가 다른 작업에 의해 저장되던 중이었다 | 0s |
| `t_smoke.py 3` 재시도 | **통과**. Lua 트리 2.7s, 본문 17.2s, 빌드 29.6s, chk 0.49MB. 사이클별 실행 트리거 수: 1 = 162, 2 = **596,010**, 3 = **49,469**, 모두 정상 끝. 흉내 못 낸 것 상위: SetSwitch(13) 196, Switch 조건(11) 192, RunAIScript(15) 128, DisplayText(9) 54, PlayWAV(8) 33, SetAllianceStatus(57) 32, RemoveUnitAt(25) 29 (dff4538 이전 트리 기준) | 40s |

Lua 가 C:\Temp 에 쓰는 것(매니페스트, banflag, 비용표)은 `ctemp` 격리 폴더에 써진 것을 확인했다.

### 4.3 떼어 쓰기 평가

**한 줄 평가**: `emu.Program/Machine` 은 순수 eudplib 코드의 연산·흐름 단위 시험에 그대로 쓸 수 있다. 다만 SC 조건·액션 대부분과 게임 메모리가 없어 유닛·문자열·스위치·로케이션 기능은 시험할 수 없고, `luatest` 는 호환 전용이다.

**그대로 쓸 수 있는 것**
- `Program(body)` + `watch(이름, 주소식)` + `build()` + `Machine.setdw`/`var`/`cycle`/`steps`.
- 측정 스크립트(스크래치패드 `measure_costs.py`)가 한 프로그램 안에서 `mode` 변수로 루틴을 고르고, 사이클 사이에 입력을 주입하고, 실행 트리거 수를 재는 방식으로 이미 동작했다.

**더해야 할 것**
1. **시험 틀**
   - pytest 방식 격리: 한 케이스의 예외가 전체를 멈추지 않게.
   - "입력 → 기대값" 표와 파이썬 참조 구현의 무작위 차등 시험.
   - EUDVariable/EUDArray/Db 읽기 도우미, 바이트 단위 읽기.
2. **SC 모델 확장**
   - Switch 조건 / SetSwitch(Random 은 결정적 난수)
   - Command/Bring 을 위한 유닛 수 표 스텁
   - DisplayText 캡처(STR/STRx 해독)
   - CreateUnit 기록
   - MoveLocation/MRGN 모델 (`f_setloc` 시험용)
   - CUnit 표 스텁 (`EUDLoopNewUnit` 시험용)
3. **게임 메모리 초기값 표**: 0x512684 로컬 번호, 0x57EEE8 플레이어 형, 0x6509B0 목록 시작 CP, 0x58F500 대 void.
4. **실행 구조**: 플레이어 목록 여러 개와 PTrigger, beforeTriggerExec/afterTriggerExec 순서 (MSQC 수신 흉내 = 사이클 시작 때 데스 칸 펄스 주입).
5. **비용 보고**
   - `EUDFuncN.size()`(EP `core/eudfunc/eudfuncn.py:75`)
   - SaveMap 결과 크기
   - t_profile 식 "호출 위치별 실행량"을 파이썬 traceback 기준으로
6. **작은 기준 맵**: 지금은 `DPS_eud\DPS_headless.scx` 를 하드코딩한다.
7. **비공개 API 몽키패치 격리**: 가로채기 두 곳을 eudplib 판 검사와 함께 한 모듈로 모은다.

### 4.4 이 조사에서 잰 비용

스크래치패드의 `measure_costs.py`, `measure_costs2.py`, `measure_storage.py` 로 쟀다.

**트리거 수** (`EUDFuncN.size()`)

| 함수 | 트리거 수 |
|---|---|
| `_add64` | 10 |
| `_neg64` | 12 |
| `_subwrap64` | 12 |
| `_subsat64` | 27 |
| `_mul64` | 41 |
| `_div6432` | 293 |
| `_div64big` | 550 |
| `_divmod64` | 28 |
| `_rand64` | 6 |
| `_itodec16` | 59 |
| `_itodec48` | 52 |
| `_itohex12` | 67 |
| `_lidec_body` | 607 |
| `_swrand` | 67 |

**호출 한 번의 실행 트리거 수** (빈 사이클을 뺀 값)

| 호출 | 실행 트리거 수 |
|---|---|
| `mul64` | 2,268 (작은 수) / 4,626 (전부 1) |
| `divmod64` | 287 (32/32) / 675 (64/32) / 711 (64/64) / 34 (d=0) / 35 (n<d) |
| `add64` | 34 |
| `subsat64` | 51 |
| eudplib `f_div` 32비트 | 252 |
| eudplib `f_mul` 변수×변수 | 26~205 |
| `itodec16` | 72~80 |
| `lidec` | 325~447 |

모든 결과값이 파이썬 참조값과 같았다.

**유닛별 저장소 1700×6** (CompressPayload(True), scx 크기 증가분)
- VarBlock(EUDVarBuffer): **+11,501B**, 메모리에서는 72B×10200 ≈ 734KB
- EUDArray: **+655B**, 메모리에서는 40.8KB

---

## 5. 빌드 경로

### 5.1 euddraft 플러그인 `dps_eud.py`(38줄)

1. euddraft 가 넣어 주는 `settings` 의 키를 소문자로 접는다(16).
2. `EudDir` 를 받는다(20). euddraft 는 플러그인을 exec 로 불러와 `__file__` 이 없기 때문이다.
3. `sys.path` 맨 앞에 넣는다(21-22).
4. `VenvSite`(lupa 가 깔린 site-packages)를 **맨 뒤에** 붙인다(23-25). euddraft 내장 eudplib 이 먼저 잡히게 하려는 것이다.
5. `import driver` → `Driver(options=settings)` → 모듈 로드 시점에 `strip_map_triggers()`(TRIG 섹션 비우기, driver.py:52-54).
6. `beforeTriggerExec()` 에서 `driver.run()` 한다(37-38).

### 5.2 `driver.py`(67줄)

- **경로를 자기 위치에서 계산한다**(13-24)
  - `HERE` 를 sys.path 에 넣는다
  - `DPS_DIR` = 부모
  - `ROOT` = 그 부모 = TEP Curdir
  - `LIBRARY_DIR = ROOT\MapSource\Library`
  - **`STAT_TXT = ROOT\theSeed\stat_txt.tbl`** — 다른 저장소를 하드코딩했다
  - `MAIN_LUA = eud_main.lua`
- `Runtime(root, dps, library, scmd_units, temp_redirect)` 뒤 `api.install_all` 을 한다(42-49).
- `run()`
  1. DPS 트리를 불러온다
  2. `f_getcurpl` 로 CP 를 저장하고 `f_setcurpl(7)` 을 한다
  3. `eud_main.lua` 를 실행한다
  4. CP 를 복원한다 (56-67)

### 5.3 `eud_main.lua`

- Library 를 `dir /b` 순서로 불러온다.
- `__ctrig_install()`(13) 을 하고, DPS 루트를 다시 불러온 뒤 한 번 더 `__ctrig_install()`(18) 을 한다 (G9 3.3).

### 5.4 `build_eud.py`(141줄)

- **`--check`**(45-61)
  - venv 의 eudplib 으로 `LoadMap(DPS_headless.scx)` → `SaveMap(out, d.run)` 한다.
  - C:\Temp 쓰기를 작업 폴더로 돌린다.
- **`--euddraft`**(103-113)
  - `build\` 를 작업 폴더로 복사한다.
  - `write_eds`(64-100)로 eds 를 고친다.
    - `[STRCtrig Assembler v5.5]` 자리를 `[플러그인 경로]` + `EudDir` + `VenvSite` 로 바꾼다.
    - `[MSQC]` 끝에 SCR 채널 8줄을 넣는다.
    - `[chatEvent]` 와 `main.eps`, SCA MSQC 줄을 지운다.
    - `[CPLP]` 를 넣는다.
  - `C:\euddraft0.9.2.0\euddraft.exe` 를 실행한다.
- **`--full`**: StarCraft\Maps 에 쓰고 CPLP 를 2회까지 시도한다.
- `--euddraft`/`--full` 이 최근에 통과했는지는 확인하지 않았다. git 로그에는 "단독 컴파일 통과"(2f5479c)만 있다.

### 5.5 euddraft 0.9.10.11 내부

- `lib\library.zip` 에 eudplib 이 **순수 .pyc**(vbuf.pyc 포함)로 들어 있다.
- 컴파일된 것은 `eudplib.bindings._rust.cp311` pyd 뿐이다. `python311.dll` 이 있다.
- 따라서 lupa 는 **cp311 빌드**여야 한다.

### 5.6 공용 라이브러리를 다른 맵에서 불러오려면

1. **위치**
   - DPS_eud 밖에 둔다. 예: `MapSource\Py\eudext\` 같은 공용 폴더나 별도 저장소.
   - 호환 계층(`ctrig`)과 패키지를 나누고, `eudext` 는 lupa 없이 import 되게 한다. lupa 는 CX Paint 다리 같은 선택 모듈에서만.
2. **경로 주입**
   - 방법 A: dps_eud.py 처럼 eds 설정 한 줄(`EudExtDir : …`)을 받는 **작은 로더 플러그인**을 다른 플러그인보다 앞에 둔다.
   - 방법 B: 쓰는 쪽 플러그인이 `settings` 로 sys.path 에 넣는다.
   - epScript 의 `import eudext.x as y;` 가 파이썬 import 체계로 해석되는지는 확인하지 않았다 (추측: sys.path 에 있으면 됨).
3. **판 고정**
   - Python 3.11 + eudplib 0.76.14 에서만 시험됐다.
   - 비공개 속성을 쓰는 곳은 한 모듈에 모으고 import 때 판을 검사한다: `EUDVarBuffer._initvals`, `EUDVariable._vartrigger/_varact`, `_initval`, `EUDFuncN._create_func_body`, `curpl._curpl_var`, savemap 가로채기.
4. **하드코딩 제거**
   - `theSeed\stat_txt.tbl`, `DPS_headless.scx`, `C:\Temp`, `C:\euddraft0.9.2.0` 은 설정으로 받는다.
5. **모듈 상태 초기화**
   - euddraft 는 한 프로세스에 빌드 1회지만, 시험은 한 프로세스에서 여러 번 빌드한다.
   - ctrig 의 `setup()` 관례(모듈 전역 초기화)나 빌드 문맥 객체가 필요하다.
   - `@EUDFunc` 을 모듈 전역에 두면 빌드마다 새로 만들어야 하는지 확인이 필요하다 (추측: eudplib 은 SaveMap 마다 할당기를 초기화하지만 EUDFuncN 객체의 본문 캐시가 남을 수 있음 — 측정 스크립트는 한 번만 빌드했다).
6. **플러그인 순서**: 본문을 `beforeTriggerExec` 에 싣고 `[MSQC]` 뒤에 둔다 (DESIGN 3, G9 6.3).

---

## 6. 설계에 영향을 주는 함정 (G1~G9 + 이 조사에서 본 것)

1. **포화 뺄셈과 wrap 뺄셈**
   - SC Subtract 액션은 0 에서 멈춘다 (CSub, SubV, SubCD, 메타테이블 `-`, f_LSub).
   - eudplib `v -= x` 는 wrap 이다 (EP `core/variable/eudv.py:307`).
   - 라이브러리 API 는 두 의미를 이름으로 나눈다 (G1 1.5, G2 1.8, G3 1.5).
2. **eudplib 비교 경계**
   - `var > x` 는 `AtLeast(x+1)` 이라 x=0xFFFFFFFF 이면 늘 참이다. `<` 는 x=0 이면 같은 문제다.
   - `core.c_gt/c_lt`(629-650)가 처리한다 (G1 1.11).
3. **CP 캐시**
   - 원시 CP 쓰기는 캐시를 낡게 한다.
   - `f_dwread_epd`·`EUDVArray` 색인·`EUDSwitch` 등은 검사 없이 캐시로 CP 를 되돌린다 (G7 1.2.5 목록).
   - eudplib 본문 진입 때 CP 는 7 이 아니다 (G7 1.2.5 끝).
   - 이식 계층은 `cp_fix` 로 해결했다(1.5). 새 라이브러리는 원시 CP 쓰기를 금지한다.
4. **0 나눗셈 값이 제각각이다** (G2 1.8, G3 1.5, README)
   - `f_div`/f_Div: 몫 0xFFFFFFFF, 나머지 = 피제수
   - CDiv 상수 0: 1
   - CiDiv: 0x7FFFFFFF / 0x80000000
   - `f_div_towards_zero`: −1 / 1
   - f_LDiv: 전부 1, f_LMod: 피제수
5. **32비트 절단**: Lua 실수(`2^31`, `0x970/4`)와 음수는 `int(x) & 0xFFFFFFFF` (G1 1.5). bit32 소수 절삭 문제(G4 1.10)는 luart.py:27-31 에서 고쳐졌다.
6. **P1 마린 데스 칸 0x58A364**
   - eudplib 변수의 기본 dest(EPD 0)가 이 칸이다.
   - CtrigAsm 도 안 쓰는 반쪽·빈 슬롯·트램펄린 초기값을 여기에 쓴다 (G3 1.8, G4 4-6, G5 1.6).
   - 라이브러리는 이 칸을 저장소로 쓰지 말고, 사용자에게도 경고한다.
7. **64비트 비교 두 종류**: 반쪽별 AND(NWar)와 사전식(TTNWar)을 섞으면 틀린다 (G1 1.7). 편차 덧셈은 반쪽별이라 올림이 없다 (G3 1.5).
8. **마스크 Add/Subtract 의 정확한 의미는 추정이다** (G2 8-1, G6 3-4). 부분 마스크 Add 를 쓰는 헬퍼는 인게임 확인이 필요하다.
9. **변수 연속 배치는 보장되지 않는다** (G6 1.10-2). 포인터 산술이 필요하면 `EUDArray`/`EUDVarBuffer` 를 따로 둔다 (arrays.VarBlock). 간격 리터럴(604/2416 ↔ 18/72)을 API 밖으로 내보이지 않는다 (G6 1.9, G9 2.9 — DPS 에서 28곳을 손봐야 했다).
10. **로컬 조건**
    - LocalPlayerID/KeyPress 블록은 공유 상태를 건드리면 안 된다.
    - `IsUserCP()` ≠ `LocalPlayerID` 다.
    - 1회 트리거 상태도 로컬로 갈린다 (G7 1.5).
11. **SCR_DB 관련**
    - MSQC 채널 7 = 0x58F524 가 eudplib `_get_player_lightvar`(IsPName 류)와 겹친다 (G8 1.11-6).
    - 시그니처는 페이로드에 연속으로 두면 안 된다 (1.11-10).
12. **출력**
    - `f_sprintf/f_settbl/f_eprintln` 은 NUL·가변 길이라 고정 배치 틀을 깬다 (G8 1.4, 1.8, 1.9).
    - 12번 줄 트릭은 CreateUnit 실패 **뒤에** 글자를 쓴다 (G8 1.7).
    - `StringBuffer` 는 `IsUserCP` 분기 안에서만 쓴다 (G8 1.9).
13. **분기**
    - `EUDBranch` 의 `_actions` 는 변수 필드를 패치하지 않는다 → 변수 액션은 분기 뒤 트리거로 (core.py:9, 872-882).
    - 조건 없는 1회 머리가 자기 next 를 고치면 엔진이 곧바로 따라간다 → 다음 트리거에서 고친다 (core.py:913-923).
    - `EUDIf/EUDWhile` 은 단일 스택이다 (G4 1.9).
14. **쪼개기 의미**: CtrigAsm `Trigger2` 는 64개 덩어리마다 조건을 **다시** 검사한다. eudplib `Trigger()` 확장은 한 번만 검사한다 (G5 1.5).
15. **서브루틴 복귀 칸이 하나다** (trig._emit_call): 재진입하면 무한 루프다 (G5 1.6). 헬퍼로 떼어 가면 재귀 금지를 문서화한다.
16. **EUDFunc 본문 생성 시점**: 처음 호출될 때 본문이 생긴다. 호출자의 임시 변수 풀과 겹칠 수 있다 (core._patch_funcbody). 새 라이브러리는 풀을 두지 않거나 함수 경계에서 초기화한다.
17. **첫 사이클 순서**: 원본은 1사이클에 초기화만 한다 (G5 1.8). 초기화를 초기값으로 굽는 방식(framework._fold)은 원본보다 이르다. 무해로 판단했다 (G5 3절 추정).
18. **T 액션 수량 바이트**: 변수는 "개수×2^24" 규약이다 (cp.amount_arg 60, G7 1.3.3). 새 API 에서는 개수를 그대로 받는다.
19. **UnitReadX**: 2047 포화, 로케이션은 1기반 번호다 (G2 UnitReadX).
20. **lengthdir**: eudplib `f_lengthdir` 은 음수 각에서 틀린다. lupa 에 `math.atan2`/`math.pow` 가 없다 (README).
21. **CP 마스크 쓰기는 지원하지 않는다** (core.py:527, 773).
22. **작업 트리가 바뀌고 있다**: war.py 공개 경로가 인라인 add/subsat 로 바뀌었다(02:29). 이 문서의 비용표는 EUDFunc 판과 인라인 판을 구분해 적었다.
23. **확인 안 된 것** (각 명세 "미확인" 절)
    - CtrigInitArr 실제 적용 시점 (G9 7)
    - FieldHash 기존 매니페스트 대조 (G8 6-7)
    - `+151` 의 뜻 (G9 7)
    - 인게임 검증 전부

---

## 7. 요약 목록

### 7.1 바로 떼어 쓸 수 있는 구현 (Lua 의존 없음, 작은 손질만)

- **64비트 산술**: war.py 205-480 (`_add64(_inline)`, `_neg64`, `_subwrap64`, `_subsat64(_inline)`, `_mul64`, `_div6432`, `_div64big`, `_divmod64`, `_rand64`, 상수 접기 `add64…mod64`)
  - 시험 61건이 있다.
  - `core.c_*`·`core.scratch` 의존만 바꾸면 된다.
- **64비트 비교와 부호 비교**: tlib.py 167-195(`flip`, `flag_or`), 217-226(`cmp32`), 328-351(`cmp64`), 406-422(`OrNode`)
- **비교·덧셈·마스크 쓰기·분기 부품**: core.py 385(`plus`), 611-661(`c_ge…c_eq`), 509-542(`set_masked/write_addr`), 857-931(`emit_trigger`, `branch`, `jump_if(_not)`, `once_branch`)
- **고정 폭 숫자 → 바이트**: text.py 142-305(`_itodec16`, `_itodec48`, `_itohex12`, `_lidec_body` 와 부품), 122(`copy_vars_to_ptr`)
- **바이트·워드 쓰기와 포인터 분해**: arrays.py 834-935(`_byte_shift_act`, `_bsplit`, `_bval`, `_ByteAct`), 997(`_static_copy`)
- **저장 도우미**: arrays.py 49-100(`VarBlock`, `DwordArray`), 417(`call_read`)
- **기타**
  - arith.py 51(`and_const`), 268(`_mul_small`), 572(`_swrand`), 594(`UnitReadX` 알고리즘), 529(`f_SHRead`)
  - trig.py 256(`_emit_call` 트램펄린)
  - framework.py 37(`Enable_HumanCheck`)
  - cells.py 60-73(`epd_act/epd_cond`)

### 7.2 호환 전용이라 새로 짜야 하는 것

- **호환 틀 전체** (새 라이브러리에는 필요 없음)
  - Lua 해석층: luart/lua/runtime/classic/api
  - 레지스트리·서술자·materialize·Labels: core 의 절반
  - CtrigAsm 번호 주소 번역: cells, arrays.Layout, Convert*, CT_STRIDE
  - 블록 스택 API: flow
  - Flags·라벨 트리거: trig
  - RecoverCpValue·T 인자 해석: cp, tlib 윗부분
  - StartCtrig/EndCtrig 틀: framework
- **공개 함수 모양이 원본 규칙에 묶인 것**
  - `f_LMov` 편차·마스크 규칙, `f_Cast`, `pointer64`(EPD 쌍 포인터 W)
  - DisplayPrint 설정만 받는 `dp_ItoDec/ItoDecX/ItoHex`
- **EXCC API**: excc.py. 새 판은 EUDArray + 유닛 루프로 짠다.
- **명세도 구현도 없는 것** (전부 새로 짠다)
  - 문자열 → 64비트 파싱, 일반 숫자 서식
  - 글자 이동·색 변환
  - 총알·스프라이트·CGRP
  - 키·마우스 표와 TT 판
  - 임의 주기 삼각함수
  - CX Paint 다리와 CSPlot 루프
  - f_Diff/f_Log2/방장/부대 지정/관전자 채팅/NSQC 전송
  - ExitDrop
  - TStruct 식 풀 반복자
  - Timer/Stage
  - 부호 64비트 연산(LiMul/LiDiv/LiMod/LAbs/LlShift/LNot)
  - SCR_DB 네이티브 코어
