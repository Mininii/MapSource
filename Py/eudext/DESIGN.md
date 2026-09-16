# eudext 설계도 (v0.1, 2026-09-17)

새 맵 코드를 eudplib(파이썬·epScript)으로 짤 때 쓰는 공용 라이브러리의 설계다.
CtrigAsm 에는 있었지만 eudplib 에는 없는 기능, 그리고 사용자 맵마다 반복되던 틀(G_CB 스포너, 건물 스택,
DisplayPrint, EXCC 등)을 eudplib 방식으로 제공한다. 이 문서를 보고 모듈별로 나눠 병렬로 구현하는 것이 목표다.

이름은 `eudext` 로 정했다(2026-09-17, 7절 D1). 기준 판은 euddraft 0.11.0.1 / eudplib 0.81.0 이다(D2).

> **판 기준 변경 (2026-09-17)** — 조사 문서(R1~R4b)는 eudplib 0.76.14 에서 했다. 기준을 0.81.0 으로 올렸으므로
> R3 의 실측(euddraft 경로 규칙, epScript 번역, 번들 표준 모듈, 에뮬레이터 가로채기)은 **WP0 에서 0.81 로 다시 확인**한다.
> 0.81 에서 달라진 것은 R3 4절 표에 있다(변수끼리 `<`·`>` 버그 수정, `EUDArray` EPD 기본, scdata, epScript 타입 변수 등).

근거 자료:

| 자료 | 위치 |
|---|---|
| CtrigAsm ↔ eudplib 기능 비교 | `MapSource\Py\CtrigAsm_vs_eudplib\` (README = 결론) |
| 이 설계의 조사 문서 5개 | `docs\research\` — R1 맵별 사용량, R2 DPS 이식 계층 재고, R3 eudplib 규약·epScript·최신판, R4a 총알·서식·글자 효과·채팅, R4b 입력·CX Paint·수학·기타 |
| 시제품·실험 | `docs\proto\` (Int64 시제품, 에뮬레이터 시험, lupa 로 CB Paint 돌리기, 비용 측정) |
| DPS 이식 계층·명세 | `ScmDraft 2\DPS_eud\eud\` (`ctrig\*.py`, `spec\G1~G9`, `tests\emu.py`) — DPS_Enhance 저장소 `eudplib-port` 브랜치 |
| 용량 원리 | `MapSource\Library\EPSCRIPT_TRIGGER_BUDGET.md` 2·4절 |

---

## 0. 한눈에

### 0.1 핵심 결정

| 주제 | 결정 | 근거 |
|---|---|---|
| 기준 판 | euddraft **0.11.0.1** / eudplib **0.81.0** (번들 파이썬 3.14t). `C:\euddraft0.11.0.1` 에 **나란히 설치**하고, 기존 CtrigAsm 맵·DPS 이식 계층이 쓰는 `C:\euddraft0.9.2.0`(0.9.10.11 / 0.76.14)은 그대로 둔다. 0.76.14 호환은 목표가 아니다 | 사용자 결정 D2, R3 4절 |
| 위치·형태 | `MapSource\Py\eudext\` **평평한 패키지**(`import eudext.i64 as i64;`) | R3 3.2 |
| 불러오기 | eds 맨 앞 **부트 플러그인**이 `sys.path` 추가와 `import eudext` 까지 끝낸다 | R3 3.1 (euddraft 가 플러그인마다 sys.path 를 되돌림) |
| 64비트 | 파이썬 클래스 `Int64` 안에 `EUDVariable` 두 개(lo, hi). EUDStruct·EUDVariable 상속은 쓰지 않는다 | R3 1.2, 시제품 400건 통과 |
| Ccode | `Cell` = `EUDLightVariable`(4B Db) 감싸기. 정수 코드(Line/Index)는 없앤다 | 2026-09-17 실험 |
| 숫자 서식 | `Dec(v, width=…)` 같은 **래퍼 객체 + `fmt()` 훅**. `{:05d}` 는 선택(몽키패치) | R4a C.3 |
| 입력 동기화 | 전송은 MSQC/NSQC 플러그인에 맡기고, 라이브러리는 선언을 받아 **eds 조각을 생성**한다 | R4b A7 |
| CX Paint | 도형 계산은 **lupa 로 `CB Paint v2.5.lua` 를 그대로** 돌리고, 찍기는 좌표표 + 루프 하나 | R4b B, 실험 통과 |
| 비교 연산 | 부호 있는 비교·경계값 처리는 `cmp` 모듈로 통일한다(0.76.14 의 변수끼리 `<`·`>` 버그는 0.81 에서 고쳐졌다) | R3 1.6, 4.1 |
| 뺄셈 의미 | **0 에서 멈추는 뺄셈(포화)과 한 바퀴 도는 뺄셈(wrap)을 이름으로 확실히 구분한다.** 64비트 구현의 가장 중요한 대목이라 eudplib·CtrigAsm·SC 액션의 뺄셈 의미를 전수 조사(S8)한 뒤 이름을 확정한다 | 사용자 지시, 3.5 |
| 각도·반올림 | **CtrigAsm 과 같게 고정**한다. 런타임 각도는 CtrigAsm `f_Lengthdir` 기준(0 = +x, 화면에서 시계 방향), 도형 좌표는 TEP 처럼 0 방향 자르기. 다른 기준을 고르는 옵션은 두지 않는다 | 사용자 결정 D5·D6 |
| 위험 기능 | 일부러 멈추게 하거나 디싱크를 내는 기능은 `unsafe_` 접두사, 기본 비활성 | R4b D8 |

### 0.2 우선순위 (맵 10개 사용량 기준, R1 3절)

| 순위 | 기능 | 사용량 | 모듈 |
|---|---|---|---|
| 상 | 64비트 정수·출력 | 4맵 2,658회 (+DPS 128비트 163) | `i64`, `numfmt` |
| 상 | CX Paint 도형·찍기, G_CB 스포너 | 8맵 1,798 / 7맵 121 / 7맵 2,048 | `shape`, `plot`, `spawn` |
| 상 | 건물 스택(Gun_Line)·오브젝트 풀 | 4맵 2,298 (+TStruct 58) | `pool` |
| 상 | 서식 있는 출력(DisplayPrint) | 9맵 696 (+DPS 원소 220) | `display`, `numfmt` |
| 상 | 방금 만든 유닛·유닛별 저장(EXCC) | 10맵 311 / 8맵 361 | `units` |
| 상 | 키 입력·MSQC | 4맵 77 + 헬퍼 78 | `local`, `sync` |
| 상 | 플레이어별 액션·CP 관용구 | RotatePlayer 783, DisplayTextX 1,994 | `players` |
| 중 | lengthdir(음수·360 초과 보정) | 8맵 100 | `mathx` |
| 중 | 총알(사용자판) | 4맵 95 (라이브러리 28장은 0) | `bullet` |
| 중 | dat 패치 표 | 8맵 950 | `datpatch` |
| 중 | BGM, 채팅 효과·관전자 채팅, SCR_DB | 7맵 57 / 5맵·4맵 복붙 블록 / 2맵 21 | `bgm`, `chat`, `misc`, `scrdb` |
| 하 | 128비트, CGRP, 28장 스프라이트, 방장·부대 지정, ExitDrop, Timer/Stage | 0~3회 | `i128`, `cgrp`, `bullet`, `misc` |

호출이 0회인 CtrigAsm 기능(`CA__MoveXY`, `CD__ScanW`, `f_Log2`, `f_Diff`, `NSQCSend`, `MousePress` 등)은
**설계만 남기고 구현은 요청이 있을 때** 한다.

### 0.3 쓰는 모습

파이썬 플러그인:

```python
from eudplib import *
from eudext import i64, numfmt, players, units, sync
from eudext.i64 import Int64
from eudext.numfmt import Dec

gold = [Int64(0) for _ in range(8)]
bus = sync.Bus(transport="msqc")      # [MSQC] eds 조각은 빌드 스크립트가 euddraft 전에 만든다 (4.12, 5.3)
buy = bus.key_down("B", guard=sync.not_typing())

def beforeTriggerExec():
    for p in players.humans():                           # 컴파일 시점 목록 (루프가 펼쳐짐)
        if EUDIf()(buy.pulse(p)):
            gold[p] += 12_800_000_000                    # 64비트 상수
            players.display(p, "골드: ", Dec(gold[p], group=(3, ",")))
        EUDEndIf()
    with units.capture() as u:
        DoActions(CreateUnit(1, "Zerg Zergling", "Anywhere", P8))
    if EUDIf()(u.ok):
        units.CUnit(u.epd).set_invincible()
    EUDEndIf()
```

epScript:

```js
import eudext.i64 as i64;
import eudext.numfmt as nf;

const hp = i64.Int64(0x100000000);      // const 로 묶는다 (var 에 담으면 32비트가 된다)
var mp;

function afterTriggerExec() {
    hp.v += 5;                          // const 객체는 .v 통로로 고친다
    if (hp >= 0x100000005) {
        printAll("HP {}", hp.fmt());                      // 값 타입은 fmt() 로 넘긴다 (3.2-7)
        printAll("MP {}", nf.Dec(mp, width=5, fill="0")); // 파이썬 함수 호출의 키워드 인자는 된다
    }
}
```

(위 epScript 는 `epsCompile` 번역까지 확인한 모양이다. `nf.Dec(…)` 는 대문자라 그대로, `nf.dec(…)` 였다면 `nf.f_dec(…)` 로 번역된다.)

---

## 1. 목표와 범위

### 1.1 목표

1. **새 맵 코드가 CtrigAsm 없이** 사용자 맵의 모든 기능을 짤 수 있게 한다.
2. **용량**: eudplib 의 적층·72B 변수·함수 1벌 방출을 해치지 않는다. 모듈마다 비용 목표를 둔다(3.8).
3. **안전**: eudplib 함정(뺄셈 포화/wrap 혼동, 비교 경계, CP 캐시, P1 마린 데스 칸, 로컬 값 섞기)을 라이브러리 안에서 막는다.
4. **파이썬과 epScript 양쪽**에서 쓸 수 있다(3.11).
5. **게임 없이 시험**할 수 있다(5.1, 트리거 에뮬레이터).

### 1.2 비목표

- CtrigAsm 함수 이름·인자 모양의 복제. 새 API 는 eudplib 관례를 따른다(단, 사용자가 원한 `Cell`/`CD` 계열처럼 익숙한 이름은 별칭으로 둔다).
- CtrigAsm 원본 동작의 바이트 단위 재현. 그것은 호환 계층(`DPS_eud\eud\ctrig`)의 몫이다.
- "주소 + 번호×604" 같은 번호 산술을 API 로 노출하는 것.
- 사용 0회인 기능의 선구현.

### 1.3 호환 계층과의 관계

| | 호환 계층 `ctrig` | `eudext` |
|---|---|---|
| 대상 | 기존 CtrigAsm Lua 맵(DPS 등) | 새로 짜는 코드 |
| 입력 | Lua 표(`{P,Index,Next,"V"}`, T 팩, Flags) | eudplib 객체 |
| 원칙 | 원본과 같은 결과 | eudplib 관례, 용량 우선 |

- `eudext` 는 `ctrig` 에 의존하지 않는다. 알고리즘은 **복사해서** 가져오고 출처를 주석에 적는다(R2 7.1 목록).
- `eudext.i64` 가 안정되고 DPS 가 인게임을 통과한 뒤, `ctrig/war.py` 가 `eudext.i64` 본체를 쓰도록 합칠 수 있다(선택, 6.1 WP-X).
- 같은 eudplib 판이면 한 맵에서 둘을 섞어 쓸 수 있다. 지금 DPS 이식 계층은 0.76.14 이므로, DPS 에 eudext 를 섞는 것은 DPS 를 0.81 로 옮긴 뒤다.

---

## 2. 환경과 배포

### 2.1 기준 판

| 용도 | 위치 | 판 |
|---|---|---|
| eudext 빌드 | `C:\euddraft0.11.0.1` | euddraft 0.11.0.1, eudplib 0.81.0, 번들 파이썬 3.14t |
| eudext 개발·시험 | `C:\Users\whatd\.venvs\eud081` | 파이썬 3.13 + eudplib 0.81.0 + lupa (WP0-ENV 에서 만든다) |
| euddraft 안에서 쓸 lupa | `C:\Users\whatd\.venvs\euddraft011_site` | lupa cp314t 휠을 `pip install --target` 으로 받은 폴더 |
| 기존 맵(theSeed·MSF·DPS 이식) | `C:\euddraft0.9.2.0`, `C:\Users\whatd\.venvs\eud076` | 0.9.10.11 / 0.76.14 — **건드리지 않는다** |

규칙:
- 상대 import 를 쓰지 않는다. 패키지 안에서도 `import eudext.x` 절대 경로만(0.81 `_RELIMP` 는 sys.path 밖 상대 경로에서 ImportError).
- 비공개 API 는 `_compat.py` 한 곳에서만 쓰고, import 때 판(0.81.x)을 검사한다.
- 0.81 에서 생긴 기능(scdata `TrgUnit.armor`, epScript 타입 변수, `EUDArray` EPD 기본, 문자열 식)은 **써도 된다**. 쓸 때는 docstring 에 적는다.
- 개발 venv 의 파이썬(3.13)과 번들(3.14t)이 다르므로, 파이썬 판에 기대는 코드(표준 모듈, 바이트코드)는 쓰지 않는다. 최종 확인은 euddraft 빌드로 한다.

### 2.2 폴더 구조

```
MapSource\Py\eudext\
  __init__.py        판 번호, 판 검사. 무거운 import 금지 (lupa 는 shape 만)
  _compat.py         eudplib 판 검사, 비공개 API 접근 한 곳 (EUDVarBuffer._initvals, curpl 캐시, _create_func_body …)
  _parts.py          내부 부품: 분기·1회 분기·마스크 쓰기·임시 변수 (DPS core.py 에서 복사)
  boot.py            euddraft 부트 플러그인 (eds 에서 경로로 지정)
  errors.py          EPError 도우미, 한국어 메시지
  ── 값·수학 ──
  cmp.py             부호 없는 안전 비교, 부호 있는 비교
  cell.py            Cell(Ccode), Flag, PCell
  i64.py             Int64, Int64Array, Int64Ref(나중)
  i128.py            (3단계)
  mathx.py           lengthdir/atan2/isqrt/ilog2/부호 나눗셈/Delta/Table
  ── 글자 ──
  numfmt.py          Dec/Hex 래퍼, 고정 폭 변환, Int64 10진, 직접 쓰기, 파싱
  display.py         DisplayPrint 대체 (대상·원소·13번째 줄·TBL)
  strdesign.py       컴파일 시점 색 문자열 꾸미기 (StrDesign 대체)
  textfx.py          셀(글자당 4B) 편집 효과
  chat.py            채팅 줄 직접 쓰기 (CDPrint 대체), 13번째 줄
  ── 게임 ──
  players.py         대상 목록, 플레이어별 액션, 사람 판정
  units.py           방금 만든 유닛, 유닛별 저장(UnitData), 새 유닛 루프
  pool.py            오브젝트 풀 + 살아 있는 것만 돌기 (Gun_Line/TStruct 대체)
  local.py           로컬 입력(키·마우스·채팅 중·화면) — 표시 전용
  sync.py            동기화 입력 선언 → MSQC/NSQC eds 조각, 수신값 걸쇠
  bullet.py          총알·스프라이트
  datpatch.py        dat 필드 표, 시작 시 적용, 되돌릴 수 있는 패치
  bgm.py             곡 표, 여러 조각, 관전자 끄기
  misc.py            방장, 부대 지정, 관전자 채팅, 와이드 판정, unsafe_exit_trap
  ── 도형 ──
  shape.py           lupa 다리(CX), Shape, ShapeSet(좌표표 저장)
  plot.py            Plotter(찍기 루프), 점 변환(CA_ 대체)
  spawn.py           G_CB 식 소환 대기열
  cgrp.py            (3단계)
  ── 앱 ──
  scrdb.py           SCR_DB 네이티브 코어 (런처 레이아웃 7 호환)
  ── 개발 ──
  testing\           emu.py(에뮬레이터), scmodel.py(SC 조건·액션 확장), harness.py(차등 시험 틀)
  tools\             cost.py(비용 보고), edsgen.py(eds 생성), lua_consts.py(Lua 상수 읽기)
  tests\             모듈별 시험 (t_<모듈>.py)
  examples\          작은 예제 맵 소스 (파이썬 1개, eps 1개)
  docs\              research\, proto\, COSTS.md(측정값 기록)
```

`.gitignore` 에 `__epspy__/`, `__pycache__/` 를 넣는다(epScript 번역본이 패키지 폴더에 생긴다, R3 2.1).

### 2.3 불러오기

**euddraft 빌드** — eds:

```ini
[main]
input: base.scx
output: out.scx

[..\..\MapSource\Py\eudext\boot.py]      ; 반드시 eudext 를 쓰는 모든 플러그인보다 앞
EudextRoot : C:\Users\whatd\Desktop\Stormcoast Fortress\ScmDraft 2\MapSource\Py
VenvSite   : C:\Users\whatd\.venvs\euddraft011_site            ; shape(lupa, cp314t) 를 쓸 때만
Preload    : shape, i64                                         ; 부트 중에 미리 import 할 모듈

[MSQC]
...
[main.eps]
```

`boot.py` 가 하는 일(R3 3.2 스케치):
1. `settings` 키를 소문자로 접고 `EudextRoot` 를 `sys.path` 앞에, `VenvSite` 를 **뒤에** 넣는다(번들 eudplib 이 먼저 잡혀야 한다).
2. `import eudext` 후 `_compat.check()` 로 eudplib 판을 검사한다.
3. `Preload` 의 모듈을 import 한다. **lupa 는 부트 중에만** import 할 수 있다(그 뒤 venv 경로가 빠진다).
4. 판 번호와 불러온 모듈을 한 줄 출력한다.

규칙:
- 공용 코드는 모두 `eudext` 패키지 **안**에 둔다. `MapSource\Py` 바로 밑의 비패키지 모듈은 부트 뒤에 불러올 수 없다.
- eudext 안의 `.eps` 도 `import eudext.x` 로 불러올 수 있다. 같은 이름의 `.py` 가 있으면 `.py` 가 먼저 잡힌다.

**단독 빌드(시험·개발)** — venv 파이썬에서 `sys.path.insert(0, MapSource\Py)` 후 `LoadMap`/`SaveMap`.

위 경로 규칙(플러그인마다 `sys.path` 복원, `__file__` 없음, 부트 뒤 패키지 하위 모듈 import 가능)은 0.9.10.11 실측이다(R3 3.1). **WP0 에서 0.11.0.1 로 다시 잰다.**

### 2.4 번들 파이썬 제약

번들에 **없는** 표준 모듈은 쓰지 않는다. 0.9.10.11 에서 없던 것: `colorsys, configparser, tomllib, sqlite3, timeit, graphlib, uuid, zoneinfo, optparse, sched, shelve` 등(R3 3.3).
0.11.0.1(파이썬 3.14t) 번들 목록은 **WP0 에서 다시 뽑아** 이 절을 고친다. 그때까지는 위 목록을 피한다.
있다고 확인된 것(0.9.10.11): `json, csv, struct, fractions, dataclasses, functools, itertools, math`.

---

## 3. 공통 규약

모든 모듈이 지킨다. 리뷰할 때 이 절을 체크리스트로 쓴다.

### 3.1 이름

- **epScript 에서 부를 모듈 함수는 `f_이름`** 으로 정의한다. epScript 가 `m.foo()` 를 `m.f_foo()` 로 번역하기 때문이다(R3 2.2). 파이썬 편의로 `foo = f_foo` 별칭을 둔다.
- 클래스·상수는 대문자로 시작한다(번역에서 접두사가 붙지 않는다).
- 로컬 전용 함수는 `local` 모듈에 두거나 이름에 `local_` 을 붙인다. 위험 기능은 `unsafe_` 로 시작한다.
- 모듈 전역 이름에 CtrigAsm 이름을 그대로 쓰는 것은 **별칭**일 때만(`cell.CD = cell.f_cd`).

### 3.2 값 타입 규약 (`Int64` 가 기준 구현)

R3 5절을 그대로 따른다.

1. 파이썬 클래스 + 내부 `EUDVariable`. `__slots__`, `dont_flatten = True`, `__hash__ = id`.
2. 실수 막기: `__bool__`·`__format__`·`__iter__`·`cast` 는 안내 오류, `__repr__` 에 "epScript 에서는 var 대신 const" 안내문.
3. 생성: `T(상수)` = 초기값만(트리거 0개). `T(변수)`·`T(a, b)` = 실행 시 대입. `T.wrap(…)` = 복사 없이 감싸기.
4. 이항 연산은 **새 임시 객체**를 만든다. 제자리 연산은 self 를 고치고 self 를 돌려준다(epScript 는 반환값을 버린다).
5. `<<` 는 **대입**이다. 시프트는 메서드(`shl`, `shr`)로만 준다. epScript 식 `x << 3` 은 시프트로 번역되므로 값 타입에서는 막는다.
6. epScript 통로: `x.v = y`(property), `x.v += y`(`iaddattr`/`isubattr`), `x.assign(y)`, `x.iadd(y)`.
7. 인쇄: `fmt()` 를 구현한다(`f_dbstr_print`, `StringBuffer`, `f_eprintln` 이 부른다). `f_sprintf("{}", x)` 는 `__format__` 에서 막고 `x.fmt()` 를 쓰라고 안내한다.
8. 함수 인자로는 한 칸에 못 넘긴다. `(lo, hi)` 두 인자로 받고 본문에서 `Int64.wrap(lo, hi)`.

### 3.3 연산 분기와 함수 캐시

| 피연산자 | 처리 |
|---|---|
| 모두 상수 | 파이썬에서 계산 (트리거 0) |
| 한쪽 상수 | 본문이 트리거 3개 이하면 **인라인**, 아니면 `functools.cache` 로 **상수별 EUDFunc** |
| 모두 변수 | **처음 부를 때 한 벌** 만드는 공유 `EUDFunc`, 결과는 `ret=[…]` 로 받는다 |

- 옵션 조합이 많은 함수(예: `Dec` 서식)는 "공용 본문 1벌 + 옵션별 작은 꼬리" 로 캐시한다(키 = 옵션 튜플).
- EUDFunc 는 재귀·재진입이 안 된다. 라이브러리 함수 안에서 사용자 콜백을 부를 때(예: `Plotter.on_point`) 그 콜백이 같은 함수를 다시 부르지 않게 문서화하고, 가능하면 빌드 때 검사한다.

### 3.4 조건을 돌려주는 함수

R3 1.3 규칙:

- 돌려주는 것: **새** `Condition`(또는 목록) > `EUDLightBool` > 0/1 `EUDVariable` 순으로 싼 것을 고른다.
- 앞 계산 트리거가 필요하면 **함수를 부르는 순간** 낸다(`EUDIf()(f())` 에서 분기보다 앞에 놓인다. 루프 조건도 매번 다시 계산된다 — 실험 확인).
- 같은 `Condition` 객체를 캐시해 두 번 쓰지 않는다(오류).
- epScript 는 `__lt__`·`__gt__`·`__ne__` 를 부르지 않고 `__ge__`·`__le__`·`__eq__` 의 부정을 쓴다 → 이 세 개를 먼저 완성한다.
- epScript `return a < b;` 는 컴파일 오류다 → 문서에 `return a < b ? 1 : 0;` 로 안내한다.

### 3.5 뺄셈과 비교의 의미

**이 절은 64비트 구현의 가장 중요한 대목이다(사용자 지시).** 게임 기능에는 0 에서 멈춰야 하는 뺄셈(체력·자원·쿨타임)이
분명히 필요하고, eudplib 은 곳에 따라 `Add(-k)` 로 한 바퀴 돌게 빼기도 하고 `Subtract` 액션으로 0 에서 멈추게 빼기도 한다.
두 의미가 이름만 보고 구분되어야 한다.

알려진 사실(0.76.14 기준, 0.81 은 S8 에서 확인):

| 방법 | 의미 | 근거 |
|---|---|---|
| SC `Subtract` 액션 (`SetDeaths`/`SetMemory`/`SetResources` …) | **포화**(0 에서 멈춤) | SC 동작 |
| `VariableBase.SubtractNumber(k)`, `SubtractNumberX(k, mask)` | `Subtract` 액션을 돌려준다 → **포화** (마스크판 의미는 추정, R2 6-8) | `core/variable/vbase.py:48-51, 70-72` |
| `EUDVariable -= 상수` | `Add(-k)` → **wrap** | `eudv.py:307-309` |
| `EUDVariable -= 변수`, `a - b` | `(~0 - b) + (a + 1)` → **wrap** | `eudv.py:310-323` |
| `EUDLightVariable -= x` (`VariableBase.__isub__`) | `Subtract` 액션 → **포화** | `vbase.py:85-87`, 실험 |
| `SeqCompute((v, Subtract, x))`, `SetVariables(…, Subtract)` | **포화** | R3 1.2 |

잠정 규칙(S8 결과로 확정, 7절 D3):
- 연산자 `-`, `-=` 는 모든 eudext 값 타입(`Int64`, `Cell` 포함)에서 **wrap**.
- 포화는 **이름에 드러낸다**: `sub_sat(a, b)` / `x.isub_sat(b)`. eudplib 의 `SubtractNumber` 처럼 `Subtract` 라는 단어가 들어간 eudext 이름은 **포화만** 뜻하게 한다(`Int64.SubtractNumber(k)` 를 두면 포화 액션 묶음).
- wrap 이 필요한 곳에서 `Subtract` 액션을 쓰지 않는다(`Add(-k)`). 변수끼리 비교에서만 `SeqCompute((d, Subtract, v))` 포화 기법을 쓴다.
- CtrigAsm 이름 별칭(`SubCD`, `f_LSub` 대응)은 원본 의미(포화)를 따른다.
- **S8 산출물**: eudplib 0.76.14/0.81.0 의 모든 뺄셈 경로(연산자, `SubtractNumber(X)`, `f_dwsubtract_epd` 류, `SetVariables`, epScript `-=`/`--` 번역, `EUDXVariable`, `ineg`/`iabs`), CtrigAsm 의 뺄셈 함수(CSub/CiSub/SubV/SubCD/f_LSub/f_LiSub/_Sub/_iSub…), SC 액션의 마스크 뺄셈 의미를 표로 만들고 에뮬레이터 실험으로 확인한다.

비교:
- 0.76.14 변수끼리 `a < b`(b=0), `a > b`(b=0xFFFFFFFF) 는 틀린 답이었다(0.81 에서 고침). eudext 는 판과 상관없이 `cmp` 를 쓴다.
- 0 나눗셈: 기본은 eudplib 과 같게(몫 전부 1, 나머지 = 피제수). CtrigAsm 값이 필요하면 `div0=` 인자(4.5).

### 3.6 CP 규약

R3 1.5:

1. CP 를 잠깐 옮겨 쓰는 함수는 끝에서 **반드시 `f_setcurpl2cpcache()`**.
2. CP 를 바꾼 채 두려면 `f_setcurpl` / `SetCurrentPlayer`.
3. `SetMemory(0x6509B0, SetTo, …)` 로 CP 를 바꾸는 원시 액션은 **금지**. 사용자가 넘긴 원시 액션 목록을 받는 헬퍼는 `_parts.cp_fix`(DPS core.py 761 방식)로 캐시를 같이 고친다.
4. 기본 계약: 라이브러리 함수는 **호출자의 CP 를 바꾸지 않는다**. 바꾸는 함수는 이름이나 문서에 적는다.

### 3.7 로컬과 공유

- 로컬 값(키·마우스·채팅 중·화면 좌표·`0x512684`·와이드 판정)은 **공유 상태에 쓰면 디싱크**다.
- `local` 모듈의 함수는 결과에 표식을 붙인다(`LocalValue`/`LocalCondition` 래퍼). `sync` 의 전송 함수만 받아들이고, 공유 변수 대입(`<<`)에 넣으면 빌드 때 경고한다(가능한 범위에서).
- 표시 전용 블록은 `with local.only(player):` 또는 `IsUserCP()` 분기로 감싼다. `StringBuffer` 쓰기도 이 안에서만.
- CreateUnit 실패 트릭(13번째 줄)처럼 **공유 동작**은 모든 클라이언트에서 같은 조건으로 실행한다.

### 3.8 용량 규약

`EPSCRIPT_TRIGGER_BUDGET.md` 2·4절:

- **작은 트리거**를 선호한다. 액션 64개를 억지로 채우지 않는다(적층 이득이 사라진다).
- 저장소 고르기: 자주 읽는 값 = `EUDVariable`(72B), 비교·설정만 하는 값 = `Cell`(4B), 참/거짓 = `Flag`(1비트), 많은 값 = `EUDArray`(칸당 4B). 원소마다 변수 트리거가 필요할 때만 `EUDVArray`(72B).
- 공개 함수 docstring 에 **비용**을 적는다: "본문 N 트리거(1벌) / 호출 자리 M / 실행 K".
- 모듈마다 `docs\COSTS.md` 에 측정값을 남긴다(5.2 도구).
- 비용 목표(초안, 구현 뒤 실측으로 고친다):

| 항목 | 목표 |
|---|---|
| Int64 덧셈·wrap 뺄셈 호출 자리 | ≤ 3 트리거 |
| Int64 곱셈 실행 | ≤ 1,000 트리거 (지금 war.py 2,268~4,626) |
| Int64 나눗셈 실행 | ≤ 711 (war.py 수준 유지) |
| 32비트 10진 고정 폭 | 본문 ≤ 60, 실행 ≤ 80 |
| 64비트 10진 | 본문 ≤ 620, 실행 ≤ 450 |
| 도형 찍기 | 트리거 수가 도형 수·점 수와 무관, 좌표 1점 4B |
| 유닛별 저장 1700×N | `EUDArray` (scx 증가 < 1KB, R2 4.4) |

### 3.9 금지 목록

- P1 마린 데스 칸(`0x58A364`, EPD 0)을 저장소로 쓰기. eudplib 변수의 기본 dest 이기도 하다 → 사용자 문서에 경고.
- `EUDVariable` 연속 배치 가정. 포인터 산술이 필요하면 `EUDArray` 나 전용 버퍼.
- 번호 간격 리터럴(604/2416/72/18)을 API 밖으로 노출.
- MSQC 채널 7(`0x58F524`)과 겹치는 eudplib `IsPName`·`f_check_id` 계열을 SCR_DB 와 함께 쓰기(R2 6-11).
- `_compat.py` 밖에서 eudplib 비공개 속성 접근.

### 3.10 오류 처리

- 입력 검사는 **컴파일 시점**에 `EPError`(한국어 메시지)로 한다: 범위 밖 상수, 잘못된 옵션, 로컬 값 섞기, 재진입 가능성.
- 런타임 검사는 비용이 들므로 `debug=True` 옵션일 때만 넣는다(예: 스포너 대기열 넘침 알림).

### 3.11 epScript 연동

R3 2절 요약:

- `import eudext.i64 as i64;` 형태만 쓴다(`from … import` 없음, 마지막 이름만 묶임).
- 값 타입 객체는 `const` 로 묶는다. `var` 에 담으면 32비트 변수로 바뀐다.
- 파이썬 함수를 부를 때 **키워드 인자는 된다**(`nf.Dec(v, width=5)` 가 그대로 번역됨, 2026-09-17 실험). 안 되는 것은 epScript **함수 정의**의 기본 인자와 전역 문자열 상수 선언이다(문자열은 함수 인자로는 된다). 그래서 라이브러리 API 는 키워드 인자를 자유롭게 써도 된다.
- 모듈마다 `examples\` 에 epScript 사용 예 하나와 번역 시험(`epsCompile`)을 둔다.

### 3.12 문서화

공개 함수·클래스 docstring 형식:

```
한 줄 요약.

인자: …
반환: …(조건이면 어떤 형태인지)
비용: 본문 N / 호출 M / 실행 K (측정일)
CP: 바꾸지 않음 | 바꿈(어떻게)
로컬: 공유 안전 | 로컬 전용
epScript: 사용 예 한 줄
출처: CtrigAsm 함수 이름, 재사용한 코드(파일:줄)
```

---

## 4. 모듈 설계

### 4.0 계층과 의존

| 계층 | 모듈 | 의존 |
|---|---|---|
| 0 기반 | `_compat`, `_parts`, `errors`, `boot` | eudplib |
| 1 값 | `cmp`, `cell`, `i64`, `mathx`, `i128` | 0 |
| 2 글자 | `numfmt`, `strdesign`, `display`, `textfx`, `chat` | 0, 1 |
| 3 게임 | `players`, `units`, `pool`, `local`, `sync`, `datpatch`, `bullet`, `bgm`, `misc` | 0~2 |
| 4 도형 | `shape`, `plot`, `spawn`, `cgrp` | 0~3 (`shape` 만 lupa) |
| 5 앱 | `scrdb` | 0~3, `tools.lua_consts` |
| 개발 | `testing`, `tools` | eudplib |

아래 각 절의 형식: **목적 / 근거 / API / 의미·알고리즘 / 비용 목표 / 시험 / 위험·미정**.

---

### 4.1 `_compat`, `_parts`, `boot`, `errors`

**목적**: 판 검사와 비공개 API 격리, 여러 모듈이 쓰는 내부 부품.

**`_compat`**
- `check()`: `eudplib.eudplibVersion()` 가 0.76.x 가 아니면 경고, 비공개 속성이 없으면 오류.
- 접근자: `varbuffer_initvals`, `cpcache_var`, `cpcache_cond`, `funcbody_hook` 등(R2 1.2, 1.5, 5.6 의 목록).
- 판별 도우미: `is_const(x)`, `is_var(x)`, `split64_const(x)`.

**`_parts`** (DPS `ctrig/core.py` 에서 복사, R2 7.1)
- `branch(cond, ontrue, onfalse)`, `jump_if`, `jump_if_not`, `once_branch()` — `EUDBranch` 가 변수 필드 액션을 패치하지 않는 문제를 피한다(R2 6-13).
- `set_masked(addr, value, mask)` — 값·마스크가 변수여도 패치된 `SetMemoryX` 1액션(core.py 509~542).
- `and_const(v, m)` — 변수 & 상수를 실행 3회로(arith.py 51).
- `cp_fix(actions)` — 원시 CP 쓰기에 캐시 갱신 액션을 붙인다(core.py 761~784).
- `call_sub(label)` — 인자 없는 서브루틴 트램펄린(trig.py 256, 호출 1트리거, 재진입 금지).

**`boot`**: 2.3 절.

**시험**: 판 검사 단위 시험, `set_masked`·`and_const` 차등 시험.

---

### 4.2 `cmp` — 안전 비교와 부호 있는 비교

**근거**: 부호 있는 비교 CtrigAsm TT(R1: `iAtLeast` 4회, 그러나 `f_SHRead` 70·부호 뺄셈 다수), 경계값 처리(`gt(x, 0xFFFFFFFF)` 등), 0.76.14 비교 버그(R3 1.6, 0.81 에서 고쳐짐 — 0.81 의 새 구현을 확인하고 그대로 쓸 수 있으면 감싸기만). DPS `core.c_*`, `tlib.flip/cmp32` 재사용.

**API**

```python
from eudext import cmp
cmp.ge(a, b) cmp.le(a, b) cmp.gt(a, b) cmp.lt(a, b) cmp.eq(a, b) cmp.ne(a, b)   # 부호 없음, 모든 경계 정확
cmp.sge(a, b) cmp.sle(a, b) cmp.sgt(a, b) cmp.slt(a, b)                        # 부호 있는 32비트
cmp.f_wread_signed(epd, off) / cmp.f_bread_signed(...)                           # 부호 확장 읽기 (f_SHRead 대체)
cmp.between(x, lo, hi, signed=False)
```

**의미·알고리즘**
- 상수 비교는 조건 목록(트리거 0): `sge(x, k)` 에서 k≥0 이면 `[x.AtLeast(k), x.AtMost(0x7FFFFFFF)]`, k<0 이면 OR → `EUDLightBool`(트리거 2).
- 변수끼리: 사본의 부호 비트를 뒤집고(`+0x80000000`) **포화 뺄셈** 한 번으로 판정(R3 1.2).
- 경계: `gt(x, 0xFFFFFFFF)` = Never, `lt(x, 0)` = Never(core.py 629~650).

**비용 목표**: 상수 0~2, 변수끼리 호출 2~3.
**시험**: 32비트 경계값(0, 1, 2³¹−1, 2³¹, 2³²−1) × 무작위 차등, `EUDIf`/`EUDWhile`/`EUDSCAnd`/neg 안에서.
**위험**: 없음(순수 연산).

---

### 4.3 `cell` — Ccode

**근거**: 사용자 요청(Ccode 를 그대로 쓰고 싶다). DPS `CD` 490, `SetCD` 503(대부분 비교·설정). 2026-09-17 실험(아래).

| 동작 | `EUDLightVariable` 그대로 | `Cell` 에서 |
|---|---|---|
| 상수 대입·비교 | 됨 (1 / 2 트리거) | 그대로 |
| 변수 대입 `c << v`, `c += v` | **오류** | `SeqCompute`/`DoActions` 로 자동 전환 (1~2) |
| 변수로 읽기 | **오류** | `c.read()` → `f_dwread_epd` (본문 약 35 1벌, 호출 약 2) |
| `-=` | 포화 | **wrap** 으로 고정(3.5), 포화는 `isub_sat` |

**API**

```python
from eudext.cell import Cell, Flag, PCell, CreateCcode, CreateCcodes, CreateCcodeArr, CD, SetCD, AddCD, SubCD

c = Cell(0)                   # = CreateCcode()
a, b = CreateCcodes(2)
arr = CreateCcodeArr(15)      # CellArray: EUDArray 기반, arr[i] 는 Cell 뷰 (상수 i) / 읽기·쓰기 함수 (변수 i)
f = Flag()                    # EUDLightBool
pc = PCell()                  # 플레이어별 8칸 (CtrigAsm 의 플레이어 사본 대체)

CD(c, AtLeast, 3)             # Condition  (CtrigAsm CD/CDeaths)
SetCD(c, SetTo, v)            # Action. v 가 변수면 DoActions/Trigger 안에서만 (RawTrigger 는 상수만 받음)
AddCD(c, 1); SubCD(c, 1)      # SubCD 는 원본처럼 포화 (이름이 CtrigAsm 이므로 원본 의미)
c.addr / c.epd                # _Ccode 대체 (주소 핸들)
```

**의미**
- 정수 코드(`Line*0x100000+Index`)는 없다. 핸들은 객체다.
- `SetCD`/`SubCD` 처럼 **CtrigAsm 이름을 쓴 별칭은 원본 의미**(Subtract 포화)를 따른다. 연산자는 3.5 규칙.

**시험**: 대입·덧셈·포화·wrap·읽기 차등, 조건 형태 검사.
**위험**: 자주 읽는 값을 `Cell` 에 두면 읽기 비용이 크다 → docstring 에 명시.

---

### 4.4 `i64` — 64비트 정수

**근거**: 4맵 2,658회(R1). 시제품(`docs\proto\i64_proto.py`, 400건 통과, R3 1.2). 본체 알고리즘 `ctrig/war.py`(61건 시험, R2 1.6).

**실제로 쓰인 모양**(R1 2-a): 10진 문자열 상수, 32비트 값을 올리기(`{V,0}`), 결과를 `{V,V}` 로 받기, 식 중첩, 부호 있는 64비트 비교.

**API**

```python
from eudext.i64 import Int64, Int64Array, parse

x = Int64(12_800_000_000)          # 초기값만
y = Int64(v32)                     # 32비트 값을 올림 (hi=0)
z = Int64(lo_var, hi_var)          # 두 반쪽
w = Int64.wrap(lo_var, hi_var)     # 복사 없이 감싸기
k = parse("12800000000")           # 문자열 상수 → int (컴파일 시점)

x << y; x += y; x -= 5             # wrap
x.isub_sat(y); i64.sub_sat(x, y)   # 포화 (CtrigAsm f_LSub). 이름은 S8 결과로 확정 (3.5)
x * y; x // y; x % y; i64.divmod(x, y)       # 부호 없음
i64.sdiv(x, y); i64.smod(x, y); x.neg(); x.abs()   # 부호 있음 (2단계)
x & y; x | y; x ^ y; x.invert(); x.shl(n); x.shr(n)  # (2단계)
x >= y; x <= y; x == y; x > y; x < y; x != y # 부호 없는 사전식 비교 → 조건
i64.sge(x, y) …                              # 부호 있는 비교
x.lo, x.hi                                   # 반쪽 EUDVariable
x.to32(saturate=True)                        # 32비트로 내림 (넘치면 0xFFFFFFFF 또는 잘라냄)
x.fmt()                                      # 10진 출력 (numfmt.Dec 와 연결)
x.v = y; x.v += y                            # epScript 통로

arr = Int64Array(1700)             # lo 배열 + hi 배열. arr[i] → Int64.wrap 임시값
i64.rand()                          # 64비트 난수 (f_dwrand 2회)
```

**의미**
- `+ - *` wrap, `// %` 부호 없음, 0 나눗셈 = 몫 2⁶⁴−1·나머지 = 피제수(war.py 와 같음).
- 비교 연산자는 **사전식**(hi 먼저). CtrigAsm 의 "반쪽별 AND"(NWar) 비교는 제공하지 않는다(R2 6-7 혼동 방지).
- 편차 덧셈(`f_LMov` Deviation)은 제공하지 않는다(호환 전용).

**알고리즘**
- add: 인라인 SeqCompute + 올림 트리거 1(war.py `_add64_inline`).
- 상수 덧셈: 올림 판정 조건 + 액션 2(시제품).
- sub_sat: war.py `_subsat64_inline`.
- mul: war.py `_mul64`(64회 비트 루프, 2,268~4,626 실행) → **16비트 쪼개기**로 바꿔 목표 ≤ 1,000(WP4, G3 1.10 제안). 상수 곱은 비트 수가 적으면 배가·덧셈 펼치기(arith.py `_mul_small` 방식).
- divmod: war.py 3경로(32/32 → `f_div`, 64/32 → `_div6432`, 64/64 → `_div64big`).

**비용 목표**: 3.8 표.
**시험**: 시제품 시험 확장 — 경계값(0, 1, 2³²−1, 2³², 2⁶³−1, 2⁶³, 2⁶⁴−1) × 무작위 × 모든 연산, `EUDWhile` 조건, 배열 원소, epScript 번역·빌드.
**위험**: `EUDTypedFunc([Int64])` 는 안 된다(한 칸) → `cast` 에서 안내 오류. 128비트는 4.4b.

**4.4b `i128` (3단계)**: DPS `math128.lua`(호출 163)가 쓰는 연산만: add/sub/mul(128×64)/div(128÷64)/비교/10진 출력. `Int64` 두 개로 표현. 새 맵에서 요청이 있을 때 한다.

---

### 4.5 `mathx` — 삼각·정수 수학

**근거**: `f_Lengthdir` 8맵 100회. 전부 Cycle 360, **음수 반지름과 360 초과·음수 각도가 실제로 들어온다**(R1). eudplib `f_lengthdir` 는 음수에서 틀림(예: (100, −90) → (−97, 24), R4b C5). 고정밀 모드는 Memory_2 한 곳.

**API**

```python
from eudext import mathx as mx

x, y = mx.lengthdir(r, a, cycle=360)     # r, a 부호 있음. 결과가 CtrigAsm f_Lengthdir 와 같다
x, y = mx.lengthdir(r, a, precise=True)  # LengthdirX(고정밀) 와 같다. 표 크기 경고 (360 → 11.9MB)
a = mx.atan2(dy, dx, cycle=360)          # CtrigAsm f_Atan2 와 같다 (올림 성격, 출력 0~cycle-1)
d = mx.atan2_sc(dy, dx)                  # CtrigAsm f_Atan2X 와 같다 (256 주기, 0 = 위쪽)
a256 = mx.to_dir256(a, cycle=360)        # 360 주기 각 → SC 256 방향 (총알에서 씀)
r = mx.isqrt(n); k = mx.ilog2(n, zero=0x80000000)
q = mx.sdiv(a, b, div0="eudplib"|"ctrig")                 # 부호 나눗셈, 0 나눗셈 정책 선택
m = mx.smod(a, b, div0=…)
v = mx.ratio(x, mul, div)                                 # x*mul/div 부호 있음 (CA_Ratio 계열)
d = mx.Delta(src, period=24); d.update()                  # f_Diff (0회, 설계만)
t = mx.Table(lambda i: …, 0, 359, scale=65536)            # CMathFunc (0회, 설계만)
```

**각도 기준·결과 (사용자 결정 D5: CtrigAsm 과 같아야 한다)**
- 각도 기준은 CtrigAsm 런타임과 같다: 0 = +x, y 가 아래로 커지므로 각이 늘면 화면에서 시계 방향. **다른 기준을 고르는 옵션은 두지 않는다.** SC 256 방향이 필요하면 `atan2_sc`/`to_dir256` 을 따로 부른다.
- 결과 값도 CtrigAsm 과 같게 한다(R4b C1·C2):
  - lengthdir: 표 값 = `0x10000·sin` 을 **0 방향으로 자름**, 결과 = `R·표 ÷ 0x10000` 을 **0 방향으로 자르는 부호 나눗셈**(CiDiv). eudplib 의 반올림 표(`floor(v·65536+0.5)`)를 쓰지 않는다.
  - 음수 각은 `CiMod` 후 음수면 `+cycle`(CtrigAsm 과 같은 순서), R 범위 −32768~32767.
  - atan2: `Y<<16 ÷ X` 비율로 거친 8갈래 + 세밀 선형 탐색(올림 성격, (1,1) → 46), 사분면 보정.
  - cycle 은 4의 배수만. 사용 맵은 전부 360 이다(R1).
- 표는 `EUDArray`(작은 표) 또는 `Db`(고정밀 파일 표).

**시험**: **CtrigAsm 알고리즘을 파이썬으로 옮긴 참조 구현**(R4b `math_sim.py` 에 있음)과 무작위 20만 개 + 경계(각 −1, 0, 89, 90, 359, 360, 720, R=±32767) 차등. 참조 구현 자체는 CtrigAsm Lua 원문(CA:84377~85048)과 줄 단위로 대조해 확인한다. 원본 트리거를 에뮬레이터로 돌리는 방법은 지금 없다(DPS 이식 계층이 `f_Lengthdir` 를 받쳐 주지 않음, R2 2절).
**위험**: eudplib `f_lengthdir`/`f_atan2` 를 대신 쓰면 음수·반올림이 조용히 달라진다(R4b C5) → eudext 안에서는 쓰지 않는다.

---

### 4.6 `numfmt` — 숫자 서식

**근거**: DisplayPrint 원소·ItoCustom 에서 실제로 쓰는 것(R1 3절 2번): 자릿수 제한, 0 채우기, 전각, 자리마다 색, 세 자리 묶음, 부호, 64비트. eudplib 은 부호 없는 가변 10진과 8자리 대문자 16진뿐(R4a C.2). 구현 재료: DPS `text.py` `_itodec16`/`_itodec48`/`_itohex12`/`_lidec_body`(R2 1.9).

**API** (R4a C.5 를 다듬음)

```python
from eudext.numfmt import Dec, Hex, f_fmt_dec_to, f_fmt_dec_cells, f_scan_dec_cells, enable_format_spec

Dec(v, width=0, fill="\r", sign=None, max_digits=None, cut_low=0,
    fullwidth=False, colors=None, group=None, glyphs=None)
    # v: EUDVariable | 상수 | Int64
    # sign: None | "-" | "+-"      group: None | (3, ",") | (4, ("만","억","조"))
Hex(v, width=8, lower=False, fill="0")

f_sprintf(buf, "HP {}", Dec(hp, width=5, fill="0"))   # fmt() 훅으로 동작 (패치 없음)
sb.printf("{} 골드", Dec(gold, group=(3, ",")))

f_fmt_dec_to(dst_ptr, value, **opts) -> 쓴 길이        # 고정 배치 직접 쓰기 (NUL 없음)
f_fmt_dec_cells(dst_epd, value, color=None, **opts)    # 글자당 4B 셀 배치
f_scan_dec_cells(src_epd, n, signed=False) -> 값        # CD__ScanV 대체
enable_format_spec()                                    # 선택: "{:05d}", "{:+,d}", "{:08x}", "{:w}" 허용 (몽키패치)
```

**알고리즘**: 나눗셈 없이 자리값 `8·4·2·1 × 10ᵏ` 비교·뺄셈(본문 약 50, 실행 약 80). 옵션은 컴파일 시점 상수 → 작은 꼬리. 64비트는 비교·뺄셈 64비트판(`_lidec_body`) 또는 10⁹ 덩어리 3개로 나눈 뒤 32비트 루틴 재사용(비용 비교 후 결정).
**주의**: `Dec` 는 호출 자리마다 scratch 버퍼를 따로 가진다. `f_cpchar_print`(TextFX 경로)는 `fmt()` 를 부르지 않는다 → `Dec(...).fmt()` 결과를 넘기라고 문서화하고 시험으로 막는다(R4a C.3).
**시험**: 파이썬 `format` 참조와 바이트 단위 비교(에뮬레이터 바이트 읽기), 경계값·음수·64비트.
**위험**: 몽키패치는 eudplib 판 의존 → 선택 기능. `cut_low`(CtrigAsm DigitMin) 이름 혼동 주의.

---

### 4.7 `display`, `strdesign` — DisplayPrint 대체

**근거**: `DisplayPrint` 9맵 470, `DisplayPrintEr` 97(13번째 줄), `DisplayPrintTbl` 96(TBL = 버튼 설명), DPS 서식 원소 220(R1). 명세 G8 1.2~1.9, 2절. `StrDesign` 735회(컴파일 시점 색 문자열).

**선행 작업**: **S3** — DisplayPrint 가 받는 원소 종류와 대상 종류를 G8·DisplayPrint.lua 에서 표로 뽑기(원소: 문자열, V, W, 128비트, 플레이어 이름, 색, 서식 원소 `{SetNumX,…}`; 대상: 플레이어, Force, CP, V).

**API 초안**

```python
from eudext import display as dp

dp.show(target, *parts)          # target: 상수 플레이어 | 변수 | players.Humans | players.Force(1) | CurrentPlayer
dp.show_line13(target, *parts)   # DisplayPrintEr (f_raise_CCMU + 로컬 쓰기)
dp.set_tbl(tbl_id, *parts)       # DisplayPrintTbl (GetTBLAddr + 고정 길이 쓰기)
dp.Template("골드 {gold} / {max}")  # 선택: 컴파일 시점 틀 + 슬롯 오프셋 (고정 배치, DisplayPrint 방식)
# parts: str | EUDVariable | Int64 | Dec/Hex | PName(p) | PColor(p) | Cell

from eudext.strdesign import design
design("\x04[\x1f보스\x04] 등장")  # StrDesign 규칙을 파이썬 함수로 (S7 에서 규칙 추출)
```

**의미**: 내부는 `StringBuffer` + `f_sprintf` + `EUDPlayerLoop`/`IsUserCP`. 고정 배치가 필요한 곳(TBL, 틀)은 `f_sprintf`/`f_settbl` 을 쓰지 않는다(NUL·가변 길이, R2 6-12).
**시험**: 에뮬레이터에 DisplayText 캡처 모델 추가 후 바이트 비교(5.1). 인게임: 줄 위치·색·TBL 표시.
**위험**: 대상이 여럿일 때 StringBuffer 를 대상마다 다시 쓰는 비용 → 대상 루프 밖에서 한 번 만들고 로컬 분기에서 표시.

---

### 4.8 `textfx`, `chat` — 글자 효과와 채팅 줄

**근거**: `CDPrint` + `CD__ScanChat` 채팅 효과 블록(5맵 복붙), 관전자 채팅 블록(4맵). `CA__MoveXY`·`ConvertColor`·`ConvertLetter` 는 0회(설계만). R4a D·E 절.

**버퍼 형식 주의**(R4a D.1): 글자당 4바이트이고 0번 바이트가 색인 것은 같지만, **1·2바이트 글자의 0x0D 채움 위치가 CtrigAsm(앞)과 eudplib(뒤)이 반대**다. 색 효과는 호환, 글자 비교·치환 상수는 비호환 → `cell_const()`(eudplib 배치)와 `cell_const_ctrig()`(옛 데이터용)를 따로 둔다.

**API** (R4a D.5, E.4)

```python
from eudext.chat import ChatLines, chat_prime, f_chat_slot, f_chat_epd, chat_active, f_line13, PinnedText
from eudext.textfx import Cells, cell_const

lines = ChatLines(rows=range(11), absolute=True)
with local.only(p):
    lines.clear(row, mask=0)           # 기존 글자 유지, 효과만 (사용자 맵 관용: 초기화 마스크 0)
    lines.write(row, col, "…", Dec(v))
    lines.cells(row).convert_color([(0x04, 0x1F)])
f_line13(player, "…", cells=True)      # C13Print
```

**우선 구현 범위**: 사용자 맵의 채팅 효과 블록과 관전자 채팅 블록을 그대로 대체할 만큼(S6 에서 두 블록을 추출). `reveal`/`blit`/`convert_letter` 는 설계만.
**시험**: 에뮬레이터 바이트 비교(채팅 버퍼 주소 모델), 인게임: 줄 위치·홀수 줄 정렬·줄이 꺼졌을 때.
**위험**: 줄 표시 시간 저장 위치 미확인, 사용자 채팅이 slot 을 밀어냄(매 프레임 slot 재계산).

---

### 4.9 `players` — 대상 목록과 플레이어별 액션

**근거**: `RotatePlayer` 783, `DisplayTextX`/`PlayWAVX` 1,994, 원시 CP `0x6509B0` 1,670, 플레이어 수만큼 배열 494, `HumanCheck`/`LocalPlayerID` 371(R1 1-c).

**API**

```python
from eudext import players as pl

pl.humans()                      # 컴파일 시점 목록 (맵 정보) → for p in pl.humans(): 펼침
pl.Humans                        # 런타임 대상 (EUDPlayerLoop + f_playerexist)
pl.Force(1), pl.Allies(p), pl.All
with pl.each(pl.Humans) as p:    # EUDPlayerLoop 감싸기, CP = p 보장, 끝에서 CP 복구
    ...
pl.run_as(targets, actions)      # 대상마다 CP 를 바꿔 같은 액션 (RotatePlayer 대체). 상수 목록이면 한 트리거
pl.display(targets, *parts)      # = display.show
pl.play_wav(targets, wav)        # PlayWAVX 대체
pl.is_human(p) / pl.human_mask() # Enable_HumanCheck (framework.py 37) 재사용
pl.PerPlayer(Int64)              # 8칸 배열 생성 도우미 (CreateVarArr 대체)
```

**시험**: CP 복구 확인(에뮬레이터 CP 모델), 대상 조합.
**위험**: `EUDPlayerLoop` 안 CP 규약(3.6).

---

### 4.10 `units` — 방금 만든 유닛, 유닛별 저장

**근거**: `0x628438` 10맵 311(그중 `f_Read` 136), EXCC 8맵 361, `MoveCp` 345(R1). EXCC 대체는 `EUDArray` 가 용량·실행 모두 유리(R2 1.8: VarBlock +11.5KB vs EUDArray +0.66KB).

**API**

```python
from eudext import units

with units.capture() as u:           # CreateUnit 직전 0x628438 읽기
    DoActions(CreateUnit(1, unit, loc, owner))
u.epd, u.ptr, u.ok                   # ok = 0x628438 이 바뀌었는가 (생성 성공)

data = units.UnitData(hp2="dword", stack="word", flags="byte")   # EXCC 대체: 필드마다 EUDArray(1700)
data.hp2[u.index] += 5
data.of(epd).stack                    # epd → 색인 변환
units.index(epd_or_ptr)               # (ptr − 0x59CCA8) // 336
for cu in units.new_units():          # EUDLoopNewUnit 감싸기 + 색인 제공
    ...
units.clear_on_death(data)            # 죽은 유닛 칸 초기화 루프 (EXCC ClearCalc 대체)
units.CUnit                           # eudplib CUnit 다시 내보냄 (MoveCp 관용 → 멤버 이름 접근)
```

**시험**: 에뮬레이터에 CUnit 표 스텁·`0x628438` 모델 추가(5.1). 인게임: 생성 실패 시 `ok`.
**위험**: 새 유닛 루프의 실행 시점(생성 직후 같은 프레임인지)은 eudplib `EUDLoopNewUnit` 규칙을 문서화.

---

### 4.11 `pool` — 오브젝트 풀 (건물 스택·TStruct 대체)

**근거**: `Gun_Line`/`Gun_SetLine` 4맵 2,298회, TStruct 2맵 58(R1). 건물 하나의 기록 칸을 줄 번호로 조건·대입하고(`Gun_Line(5, Exactly, 0)`), 매 프레임 살아 있는 슬롯마다 공통 처리를 한다(`Install_GunStack`: 슬롯 수만큼 트리거 → 용량 큼).

**선행 작업**: **S2** — `MSF_Respect_V\GunData.lua`, `theSeed`·Memory_2 의 건물 스택, `TStruct.lua` 에서 필드 목록·수명 규칙(생성, 일시 정지 `Gun_DoSuspend`, 종료)·슬롯 수·유형별 함수 호출 방식 추출.

**API 초안**

```python
from eudext.pool import Pool, Field

class Gun(Pool.Record):              # EUDStruct 하위, 필드 이름·타입
    kind = Field("dword"); timer = Field("dword"); step = Field("dword")
    x = Field("dword"); y = Field("dword"); owner = Field("dword"); suspend = Field("dword")

guns = Pool(Gun, capacity=256)
g = guns.alloc(kind=3, x=..., y=...)  # 실패 시 0 (넘침 알림은 debug 옵션)

@guns.each                            # 매 프레임: 살아 있는 레코드만 도는 루프 1벌 (슬롯 수와 무관한 트리거 수)
def tick(g):
    if EUDIf()(g.suspend >= 1): EUDContinue()   # 형태는 구현 때 정함
    EUDSwitch(g.kind) …               # 유형별 처리 (Gun 함수 표)
guns.free(g)                          # 루프 안에서 해제해도 안전
guns.count                            # 살아 있는 수
```

**의미**: 저장은 `EUDStruct` + 풀(eudplib `ObjPool`), 살아 있는 목록은 포인터 배열 + 맞바꿔 지우기(DPS `flow.py` NBag 구조, R2 1.1). 필드 조건은 `g.step == 5` 처럼 이름으로.
**비용 목표**: 매 프레임 루프 본문 1벌. 레코드당 저장 = 필드 수 × 4B(EUDStruct 는 EUDVArray 기반이면 72B — 구현 때 EUDArray 기반 레코드를 비교 측정).
**시험**: 할당·해제·루프 중 해제·넘침 차등(파이썬 참조 풀).
**위험**: 0.76.14 `EUDMethod` 는 정적 인스턴스마다 본문을 복제했다(R3 1.4, euddraft 0.10.0.0 에서 고침) → 0.81 에서 다시 확인.

---

### 4.12 `local`, `sync` — 입력

**근거**: `KeyPress` 4맵 77, 사용자 MSQC 헬퍼 78, 원시 채팅 중 조건 27(R1). 입력값은 전부 로컬 메모리(R4b A1). MSQC/NSQC 플러그인이 동기화한다.

**`local`** (표시 전용)

```python
from eudext import local
local.key_held("X"); local.key_pressed("X"); local.key_released("X")   # 엣지는 local.update() 가 캐시 갱신
local.mouse_held("L"); local.typing(); local.not_typing()
local.mouse_map_xy(); local.screen_xy(); local.is_observer()
with local.only(p): ...
local.update()                        # 모든 소비자 뒤 1회
local.KEYS                            # 키 이름 → VK 표 (CA 80175~80228 + NSQC 표기 둘 다)
```

**`sync`** (공유 로직용)

```python
from eudext import sync
bus = sync.Bus(transport="msqc")      # 또는 "nsqc"
jump = bus.key_down("SPACE", guard=[sync.not_typing()])   # 플레이어별 펄스
fire = bus.mouse_down("L")
cur  = bus.mouse_location()
val  = bus.value(local_expr, latch=True)                  # 받은 사이클에만 갱신한 PVariable 유지
wide = bus.dword(local_flag, error=0xFFFFFFFF)            # NSQC 전용
jump.pulse(p)   # Condition
jump.level(p)   # Down/Up 짝으로 토글한 상태
bus.eds_fragment() -> str             # "[MSQC]\n…"
bus.write_eds_fragment(path)          # 빌드 스크립트가 euddraft 실행 전에 부름
```

**핵심 제약**(R4b A7)
- euddraft 는 eds 를 플러그인보다 먼저 읽는다 → **eds 조각은 같은 빌드 안에서 반영되지 않는다.** 빌드 순서 = "선언 모듈 실행(파이썬만) → eds 생성 → euddraft". `tools/edsgen.py` 가 맡는다(5.3).
- 받은 값은 네트워크 턴이 실행된 사이클에만 들어오고 한 턴 안에서는 마지막 값만 남는다 → `latch`, `level` 도우미.
- 출력 칸은 데스값 대신 `EUDArray` 를 쓰면 데스 유닛 예약이 필요 없다(NSQC 등록 방식).
- 자체 전송(`transport="native"`, QC 유닛 + Select + Move 를 라이브러리 안에 다시 짜기)은 **3단계 선택**. 이득: MSQC 개선안(INT 7절 B·C·D·G), eds 불필요. 비용: 선택 복원 훅을 모든 코드 뒤에서 불러야 함.

**시험**: 에뮬레이터에서 수신 펄스 주입(데스 칸) → latch/level 동작. 인게임: 2인 이상 디싱크 없음.
**위험**: 로컬 값 섞기(3.7), NSQC 화면 로케이션의 로컬 좌표.

---

### 4.13 `shape`, `plot` — CX Paint 도형과 찍기

**근거**: `CSMake*`/`CS_*` 8맵 1,798, `CSPlot` 7맵 121, `CAPlot` 류 소수(R1). lupa 실험: `CB Paint v2.5.lua` 0.06초 로드, 도형 생성·변형·채우기·콜백·저장 모두 동작, 1,700점 원 0.006초(R4b B3).

**`shape`** — 컴파일 시점

```python
from eudext.shape import CX, Shape, ShapeSet

cx = CX(lib_dir=r"…\MapSource\Library", extra=["CSMakeSpiral.lua", "CS_Addon.lua"],
        seed=1234, file_dir=BUILD_TMP)
ring = cx.call("CSMakeCircle", 6, 32, 0, 37, 0)          # Shape([(x, y), …])
star = cx.eval("CS_Rotate(CSMakeStar(5,72,60,0,CS_Level('Star',5,4),0), 15)")
cx.run_file(r"MapShapes\Boss.lua")                        # 맵별 Lua 도형 그대로
Shape.from_points([...]); ring.points; len(ring); ring.bounds()
shapes = ShapeSet([ring, star], storage="db")             # "db"(4B/점) | "varray"(72B/점, 순차 읽기 빠름)
```

- shim: `bit32`(DPS `luart.py` 에서 복사), `math.atan2 = math.atan`, `FileDirectory` 전역, 로드 **뒤에** `math.randomseed(seed)`.
- **좌표 정수화는 TEP 와 같은 0 방향 자르기로 고정**한다(사용자 결정 D6, 옵션 없음). 반올림과는 1,700점 중 1,184점이 다르다. 음수 좌표도 0 방향(`int()`), `floor` 아님. TEP 의 실수→정수 변환 규칙은 DPS `ctrig/classic.py _i32` 와 같게 한다.
- 도형의 각도 기준은 CB Paint 가 lupa 안에서 스스로 계산하므로 원본과 같다(0°=12시, 시계 방향).
- 저장: 점 하나 = dword `(x+0x8000) | (y+0x8000)<<16`, 도형별 시작 EPD·점 수는 주소표(theSeed `CAPlotIndexed.lua` 방식).
- lupa 는 이 모듈만 import 한다. 부트에서 `Preload: shape`(2.3).

**`plot`** — 런타임

```python
from eudext.plot import Plotter

plot = Plotter(shapes, unit=u, owner=P8, loc="CAPlot", per_tick=12, delay=1, size=0,
               repeat=False)
plot.start(shape=idx, center=(cx_var, cy_var))           # 또는 center="loc"
@plot.on_point                                            # CAfunc 대체
def fx(pt):
    pt.rotate(angle, cycle=360)                           # CA_Rotate (mathx 사용)
    pt.move(dx, dy); pt.ratio(mx, dx, my, dy)            # CA_MoveXY, CA_RatioXY
    if EUDIf()(pt.x > 200): pt.skip()                     # CA_CropXY
    EUDEndIf()
plot.tick()                                                # 매 프레임 1회
plot.busy / plot.done                                      # 조건
units.CreateUnitShape                                      # (정적 CSPlot 류가 꼭 필요할 때만) 루프판으로 대체
```

- 한 프레임 루프 본문은 `EUDLoopRange(per_tick)` 하나: 읽기 → 편향 빼기 → `on_point` → `f_setloc` → `CreateUnit` → 번호 증가. 트리거 수가 도형 수·점 수와 무관하다.
- 각도 기준은 CtrigAsm 과 똑같이 둔다(D5): 정적 도형(CB Paint)은 0°=12시, 런타임 점 변환(`pt.rotate` 등, CA_ 대응)은 CtrigAsm CA_ 함수와 같은 0°=+x 에 `Include_MatheMatics` Cycle 단위. 두 기준이 90° 어긋나는 것도 원본 그대로이며, docstring 에 적는다(R4b B6·B8). `pt.*` 결과는 CtrigAsm CA_ 함수와 같아야 한다(mathx 참조 구현으로 시험).
- `LoopMax` 스케줄은 `EUDArray`, 포인터는 1부터(CAPlotIndexed 버그 기록 반영).

**비용 목표**: 1,700점 = 좌표 6.8KB + 루프 수십 트리거(CSPlot 583KB 대비).
**시험**: lupa 결과를 고정 시드로 스냅숏 비교, 에뮬레이터에 로케이션·CreateUnit 기록 모델(5.1) → 찍힌 좌표 목록 비교. 인게임: 모양·속도.
**위험**: euddraft 번들 파이썬에서 lupa 적재(DPS 경로라 가능성 높음, 이번엔 venv 에서만 실험), 콜백 안 임시 변수 충돌.

---

### 4.14 `spawn` — G_CB 식 소환 대기열

**근거**: `G_CB_TSetSpawn` 542, `G_CB_SetSpawn` 393, `f_TempRepeat` 297 등 7맵 2,048회(R1). 구조: 도형을 컴파일 시점에 번호로 등록(최대 4층) → 런타임에 소환 작업(유닛 표, 도형, 소유자, 중심, 속성)을 대기열 배열에 넣음 → `G_CBPlot` 이 매 프레임 작업을 진행(theSeed `Engine\G_CB_Lib.lua` 2,769줄).

**선행 작업**: **S1** — theSeed 판 `G_CB_Lib.lua` 의 속성 표 전부(`LMTable`, `Delay`, `Rotate`, `Size`, `FN`, `NQOp`, `RepeatType`, `Eff`/`Color`, `OrderXY`, `SATimer`, 중심 모드 등)와 `f_TempRepeat`(유닛 반복 소환·명령), 대기열 크기·넘침 처리, 맵 경계 처리(theSeed 수정 사항)를 명세로 뽑는다. `G_CA`(옛판)는 제외.

**API 초안**

```python
from eudext.spawn import Spawner

sp = Spawner(capacity=64, default_attack=(x, y), map_size=(6144, 3072))
job = sp.push(units=[u1, u2], shapes=[ring, star],        # 층마다 (유닛, 도형), 최대 4층
              owner=P8, center=(x, y) | loc | "unit",
              delay=[0, 12], rotate=[0, 90], size=[100, 100],
              repeat="attack" | "move" | ("order", tx, ty),
              effect=None, per_tick="MAX", on_point=fx)    # 조건은 호출 자리의 EUDIf 로
sp.tick()                                                  # 매 프레임 1회 (Plotter 재사용)
sp.repeat(unit, n, owner, center, order=...)               # f_TempRepeat 대체
```

**의미**: 내부는 `pool`(작업 레코드) + `plot`(찍기) + `units.capture`(소환된 유닛에 명령). 속성의 의미는 S1 명세를 따른다.
**시험**: 에뮬레이터 대기열 동작(작업 넣기·진행·종료·넘침), 인게임: 보스·건작 패턴 몇 개를 옮겨 비교.
**위험**: 가장 큰 모듈. S1 없이 시작하지 않는다.

---

### 4.15 `bullet` — 총알·스프라이트

**근거**: 라이브러리 28장 함수는 0회, **사용자판 `CreateBullet` 류 4맵 95회**(6개 폴더가 서명이 다른 자기 판을 정의, R1). 원리: 유닛을 만들고 같은 트리거에서 그 유닛의 주문 칸을 고쳐 게임 로직이 무기를 쏘게 한다(R4a A). 선례 `MapSource\Py\Galaxy.py`(eudplib 판 CreateBullet).

**선행 작업**: **S4** — 사용자판 `CreateBullet`·`CreateBulletXY`·`CreateBulletCond`·`CreateBulletLoc`·`SetBullet`·`Install_CBullet` 의 서명·동작 비교표.

**API 초안** (사용자판 방식이 1단계, 28장 스프라이트류는 3단계)

```python
from eudext.bullet import BulletKind, f_bullet, f_bullet_to

kind = BulletKind(unit=…, weapon=…, flingy=…, sprite=…, image=…, iscript=…)   # BulletInitSetting 대체
f_bullet(kind, owner, x, y, dir256, speed, time, height=0) -> epd | 0
f_bullet_to(kind, owner, x, y, tx, ty, speed, time) -> epd | 0   # mathx.atan2 + to_dir256, 1프레임
# 3단계: f_storm, f_perma_sprite, f_scan_sprite, f_unit_sprite, f_recall_sprite
```

**의미·제약**(R4a A.4): 속도·수명·투사방식은 전역 dat → **같은 프레임 같은 무기는 마지막 값을 공유**. 총알 1발 = 유닛 슬롯 1개를 몇 프레임 점유. 대량 생성은 컴퓨터 소유. 언리미터 여부는 설정 인자로 받는다(eudplib 이 스스로 알 수 없음).
**시험**: 인게임 필수(에뮬레이터는 CreateUnit 을 흉내 내지 못함). 단위 시험은 dat 패치 액션 목록과 포인터 처리만.
**위험**: 영구 dat 부작용(벌처 이미지 iscript 등), 언리미터에서 eudplib `CSprite.from_read` 가 틀린 포인터(R4a A.6).

---

### 4.16 `datpatch` — dat 필드 표

**근거**: `PatchInsert*` 614, `SetUnitsDatX`/`SetWeaponsDatX`/`SetUnitAbility` 336, 8맵(R1). CtrigAsm 기능이 아니라 템플릿 헬퍼지만 거의 모든 맵에 있다. 기준 판 0.81 에는 scdata(`TrgUnit.armor += 1`, `Weapon[...]` 멤버 접근)가 있으므로 **주소표를 새로 만들기 전에 scdata 로 되는 범위를 먼저 확인**하고, 없는 필드만 표로 보탠다.

**선행 작업**: **S5** — `LibraryFor322.lua`·템플릿 `func.lua` 의 `SetUnitsDatX` 류와 `PatchInsert` 가 쓰는 필드 이름 → 주소·크기 표 추출.

**API 초안**

```python
from eudext import datpatch as dat
dat.units[unit].hp.set(5000)             # 시작 시 1회 적용 목록에 쌓임
dat.weapons[w].damage.add(10)
dat.apply_on_start()                      # EUDOnStart 에 SetMemory 목록 (작은 트리거 여러 개)
with dat.temporary():                     # f_dwpatch_epd … f_unpatchall (되돌릴 수 있는 패치)
    ...
dat.field_addr("units", "hp", unit)       # 주소 계산 (런타임 unit 변수도 허용)
```

**시험**: 주소표 스냅숏, 액션 목록 비교. 정적 수정은 EUD Editor/`dataDumper` 와 겹치므로 문서에 선택 기준을 적는다.

---

### 4.17 `bgm` — 배경음악

**근거**: `AddBGM` 44 등 7맵 57(R1). `bgmplayer.py` 플러그인은 한 곡 반복만.

**선행 작업**: **S5b** — 템플릿 `BGMEngine.lua`·`IBGM_EPD` 동작(곡 표, 여러 조각, 관전자 끄기, 턴 속도 보정 `NormalTurboSet`) 추출.

**API 초안**

```python
from eudext.bgm import BGM
bgm = BGM(turbo=True)
song = bgm.add("boss1", [r"bgm\boss1_1.ogg", r"bgm\boss1_2.ogg"], lengths_ms=[60000, 42000])  # MPQAddWave
bgm.play(song, targets=pl.Humans); bgm.stop(); bgm.mute_observers(True)
bgm.tick()
```

---

### 4.18 `scrdb` — SCR_DB 네이티브 코어

**근거**: DPS·UE_RE 사용(2맵 21). 가치와 제약은 R2 3.1 에 정리돼 있다.

**핵심 제약** (어기면 런처와 조용히 어긋난다)
- **(a) 단일 출처**: 레이아웃 상수를 파이썬에 다시 적지 않는다. 빌드 때 `tools/lua_consts.py` 가 lupa 로 `MapSource\Library\SCR_DB_Core.lua` 를 읽어 가져온다.
- **(b)** FieldHash·매니페스트 JSON 이 Lua 판과 바이트 단위로 같아야 한다 → lupa 로 Lua 판 `SCRDB_FieldHash/Json` 을 돌려 **차등 시험으로 고정**.
- **(c)** 시그니처 8 dword 는 페이로드에 연속으로 두지 않는다(SetMemory 8액션).
- **(d)** MSQC 채널 주소·데스 유닛·eds 줄 형식을 `sync`/`edsgen` 과 공유.
- **(e)** 타이밍: 1회 블록(0 초기화 → 헤더 → 시그니처 마지막)이 수신기 첫 실행 전에 끝나야 한다. 플러그인 순서 `[MSQC]` → 본 플러그인.
- **(f)** 로컬 칸(Notify·LocalPlayer)은 공유 변수를 건드리지 않는다.

**API 초안**: `scrdb.setup(fields, save_key, layout=7)`, `scrdb.receiver()`, `scrdb.notify()`, `scrdb.save_signal(p)`, `scrdb.write_manifest(path)`, 필드 쓰기는 파이썬 콜백 `write(i, key_var, val_var)`.
**비용 목표**: 수신기 32벌 펼침 → `EUDFunc(k, i)` 한 벌 + `f_maskread_epd` 1회(R2 3.1 가치 2).
**시험**: FieldHash 차등, 수신 상태기계(에뮬레이터에 DeathsX·SetMemory 있음), 인게임 + 런처.

---

### 4.19 `misc` — 기타 소기능

모두 사용 0~2회라 3단계(요청 시). 설계는 R4b D7 스케치를 따른다.

| 기능 | API | 로컬/공유 | 위험 |
|---|---|---|---|
| 방장 번호·이름 | `misc.host_player()`, `misc.HostNameIs(name)` | 공유(표 공유성 미확인) | 중 |
| 부대 지정 | `misc.HotkeyUnit(p,g,i,cmp,alpha)`, `SetHotkeyUnit` | 미확인 | 하 |
| 관전자 채팅 | `misc.ObserverChat(...)` (사용자 복붙 블록 대체) | 로컬 | 하 |
| 와이드 판정 | `local.is_widescreen()` → 필요하면 `sync.value` | 로컬 | 상(섞으면 디싱크) |
| 나가면 멈춤 | `misc.unsafe_exit_trap(target, list_owner=P8)` | 로컬 next 포인터 | **최상**, 인게임 검증 전 실험 기능 |
| 채팅 이름 | eudplib `SetPName` 그대로 안내 | 표시 전용 | — |
| Timer/Stage | `misc.Countdown`, `EUDSwitch` 안내 | 공유 | — |

`unsafe_exit_trap` 원리(R4b D4): 대상 PC 에서만 프레임이 끝난 뒤 트리거 사슬에 자기 순환을 남기고, 다음 프레임 첫 트리거(eudplib `tstart`)가 푼다. SC 가 게임을 떠날 때 사슬을 따라가다 멈추는 것은 **추측**이다. 순환은 절대 나가지 않는 FP 목록에 심는다.

---

### 4.20 `cgrp` 와 28장 스프라이트 (3단계)

R4a B 절 설계(컴파일 시점 파서가 그릴 점만 추려 층별 `Db` 로 굽고, `CGRPPainter.tick()` 이 프레임당 N 점씩 `f_perma_sprite`). CS_Photo.exe·.cgrp 파일을 이 PC 에서 찾지 못해 형식은 문서 근거뿐 → 실제 파일로 파서 검증이 먼저다.

---

## 5. 개발 도구

### 5.1 `testing` — 트리거 에뮬레이터

- `testing/emu.py`: DPS `eud/tests/emu.py` 를 **복사**해 시작(판 검사·비공개 가로채기를 `_compat` 로 옮김). 지금 흉내 내는 것: Deaths/Memory 조건(마스크 포함), SetDeaths(SetTo/Add/포화 Subtract, 마스크), next 사슬·자기수정, 보존 플래그, CP(player 13).
- `testing/scmodel.py`: 모듈 시험에 필요한 SC 모델을 **필요한 만큼만** 더한다(R2 4.3).

| 확장 | 필요한 모듈 |
|---|---|
| Switch 조건 / SetSwitch | misc, 일반 |
| DisplayText 캡처(STR/STRx 해독) | display, chat |
| CreateUnit 기록 + `0x628438` 모델 | units, plot, spawn |
| MoveLocation / MRGN 모델 | plot, spawn, mathx |
| CUnit 표 스텁 | units, pool |
| 게임 메모리 초기값(0x512684, 0x57EEE8, 0x6509B0) | local, players |
| 플레이어 목록 여러 개, before/afterTriggerExec 순서, 수신 펄스 주입 | sync, scrdb |
| 채팅 버퍼(0x640B60) 바이트 | chat, textfx |

- `testing/harness.py`: 한 빌드에 여러 케이스를 모으고(빌드 시간 절약), 케이스 하나의 예외가 전체를 멈추지 않게 한다. 파이썬 참조 구현과 **무작위 + 경계값 차등 시험**, 실행 트리거 수 기록.
- 작은 기준 맵: `testing/base.scx`(빈 맵, CBTest.scx 사본)를 둔다. DPS 맵에 묶이지 않게.
- 모듈 상태 초기화: 한 프로세스에서 여러 번 빌드할 때 `EUDFunc` 본문 캐시가 남는지 WP0 에서 확인하고, 필요하면 모듈별 `_reset()` 을 둔다(R2 5.6-5).

### 5.2 `tools/cost.py` — 비용 보고

- 함수별 `EUDFuncN.size()`, 호출 자리 비용(`GetTriggerCounter()` 차이), 실행 트리거 수(에뮬레이터), SaveMap 결과 크기 증가분을 표로 출력.
- 결과를 `docs/COSTS.md` 에 날짜와 함께 덧붙인다. 3.8 목표와 비교해 넘으면 표시.

### 5.3 `tools/edsgen.py` — eds 생성과 빌드 순서

- 맵별 `build.py` 가 부르는 도우미: 부트 플러그인 줄, `sync.Bus` 선언에서 `[MSQC]`/`[NSQC]` 조각, SCR_DB 채널 줄, 언리미터·기타 플러그인 줄을 모아 eds 를 쓴다.
- 순서: ① 선언 모듈을 파이썬으로 실행해 선언만 모음(트리거 생성 없이) ② eds 쓰기 ③ euddraft 실행 ④ (선택) CPLP.
- theSeed `EUDEditorEdsGen.lua` 와 DPS `build_eud.py write_eds` 를 참고.

### 5.4 `tools/lua_consts.py`

- lupa 로 Lua 파일을 실행해 전역 상수·함수 결과를 파이썬 값으로 가져온다(SCR_DB 레이아웃, 키 표 대조 등). `shape.CX` 와 lupa 적재 코드를 공유한다.

---

## 6. 작업 계획

### 6.1 작업 묶음

크기: 하 = 반나절 이하, 중 = 1~2일, 상 = 3일 이상(에이전트 기준 추정).
"재사용" 은 복사해 올 코드. 완료 조건은 6.4 공통 + 표의 추가 조건.

| WP | 내용 | 선행 | 우선 | 크기 | 재사용 | 추가 완료 조건 |
|---|---|---|---|---|---|---|
| ENV | euddraft 0.11.0.1 을 `C:\euddraft0.11.0.1` 에 나란히 설치, 개발 venv `eud081`(파이썬 3.13 + eudplib 0.81.0 + lupa), euddraft 용 lupa cp314t 폴더 | — | 필수 | 하 | — | 빈 맵 빌드 성공, 기존 `C:\euddraft0.9.2.0` 무변경 |
| **WP0** | 뼈대: 패키지, `_compat`, `_parts`, `errors`, `boot`, `testing`(emu 이식 + harness), `tools/cost`, `examples` 틀, 단독 빌드·euddraft 빌드 스크립트. **R3 실측(경로 규칙·epScript 번역·번들 표준 모듈)을 0.81 로 다시 재고 2.3·2.4·3.11 을 고친다** | ENV | 필수 | 중 | DPS emu.py, core.py 부품, R3 boot 시제품 | euddraft 0.11 로 빈 예제 맵 빌드 성공, 부트 뒤 `import eudext.x` 성공, 한 프로세스 여러 빌드 확인 |
| S8 | 조사: **뺄셈 의미 전수 조사**(eudplib 0.76.14·0.81.0, CtrigAsm, SC 마스크 뺄셈) + 에뮬레이터 실험 → 3.5 규칙과 Int64 이름 확정안 | — | **최상** | 중 | — | `docs/spec/S8_subtract.md` |
| S1 | 명세: theSeed G_CB_Lib 속성·대기열·f_TempRepeat | — | 상 | 중 | — | `docs/spec/S1_gcb.md` |
| S2 | 명세: 건물 스택(GunData 등)·TStruct | — | 상 | 하~중 | — | `docs/spec/S2_pool.md` |
| S3 | 명세: DisplayPrint 원소·대상·Er·Tbl | — | 상 | 하 | G8 | `docs/spec/S3_display.md` |
| S4 | 명세: 사용자판 CreateBullet 비교 | — | 중 | 하 | — | `docs/spec/S4_bullet.md` |
| S5 | 명세: SetUnitsDatX·PatchInsert 필드표, BGMEngine | — | 중 | 하 | — | `docs/spec/S5_dat_bgm.md` |
| S6 | 명세: 채팅 효과 블록·관전자 채팅 블록 | — | 중 | 하 | — | `docs/spec/S6_chat.md` |
| S7 | 명세: StrDesign 규칙 | — | 중 | 하 | — | `docs/spec/S7_strdesign.md` |
| **WP1** | `cmp` | WP0 | 상 | 하 | core.c_*, tlib.flip/cmp32 | 경계값 차등 전부 통과 |
| **WP2** | `cell` | WP1, S8 | 상 | 하 | — | 4.3 표의 모든 동작 |
| **WP3** | `i64` 1차: 생성·대입·덧셈·wrap/포화 뺄셈·비교(부호 없음·있음)·배열·fmt 훅·epScript 통로 | WP1, S8 | 상 | 중 | R3 시제품, war.py | 시제품 시험 400건 + epScript 빌드, 뺄셈 두 의미 경계값 시험 |
| **WP4** | `i64` 2차: 곱셈(16비트 쪼개기)·나눗셈·부호 연산·비트·시프트·난수·to32 | WP3 | 상 | 중 | war.py `_mul64`, `_divmod64` | 곱셈 실행 ≤ 1,000 |
| **WP5** | `numfmt` | WP3 | 상 | 중 | text.py 고정 폭 루틴 | 파이썬 format 과 바이트 일치 |
| **WP6** | `display`, `strdesign` | WP5, WP8, S3, S7 | 상 | 중 | G8 | DisplayText 캡처 비교 |
| **WP7** | `shape`, `plot` | WP0, WP9(점 변환) | 상 | 중 | luart.py bit32, lupa 실험, CAPlotIndexed 구조 | 고정 시드 스냅숏, 찍힌 좌표 비교, 번들 파이썬에서 lupa 적재 확인 |
| **WP8** | `players` | WP0 | 상 | 하 | framework.py HumanCheck | CP 복구 확인 |
| **WP9** | `mathx` | WP1 | 중(lengthdir 상) | 중 | — | 20만 개 무작위 차등 |
| **WP10** | `units` | WP0 | 상 | 하 | — | CUnit 스텁 시험 |
| **WP11** | `pool` | WP0, S2 | 상 | 중 | flow.py NBag 구조 | 참조 풀과 차등 |
| **WP12** | `spawn` | WP7, WP9, WP10, WP11, S1 | 상 | 상 | G_CB 구조 | 대기열 시험 + 인게임 패턴 3개 |
| **WP13** | `local`, `sync`, `tools/edsgen` | WP0 | 상 | 중 | CA 키 표, NSQC 표 | eds 조각 생성, 펄스 주입 시험, 2인 인게임 |
| **WP14** | `bullet` 1단계 | WP9, WP10, S4 | 중 | 중 | Galaxy.py | 인게임 발사 확인 |
| **WP15** | `datpatch` | WP0, S5 | 중 | 하~중 | — | 주소표 스냅숏 |
| **WP16** | `bgm` | WP8, S5 | 중 | 중 | — | 인게임 |
| **WP17** | `textfx`, `chat` | WP5, S6 | 중 | 중 | — | 채팅 버퍼 바이트 비교 |
| **WP18** | `scrdb`, `tools/lua_consts` | WP13 | 중 | 상 | SCR_DB_Core.lua | FieldHash 차등, 런처 인게임 |
| **WP19** | `misc` | WP13 | 하 | 하~중 | — | exit_trap 은 인게임 전까지 unsafe |
| **WP20** | `i128` | WP4 | 하 | 중 | math128.lua | — |
| **WP21** | `cgrp`, 28장 스프라이트 | WP14 | 하 | 중 | R4a B | 실제 .cgrp 파일 필요 |
| WP-X | DPS `ctrig/war.py` 가 `eudext.i64` 본체를 쓰게 합치기 | WP4, DPS 인게임 통과 | 선택 | 하 | — | t_war 61건 통과 |

### 6.2 병렬 배치

| 배치 | 동시에 하는 일 | 전제 |
|---|---|---|
| A | ENV → WP0, 그리고 동시에 명세·조사 S1~S8 (모두 서로 독립) | — |
| B | WP1, WP8, WP10, WP13, WP15 | WP0 |
| C | WP2, WP3, WP9, WP11 | WP1 (WP2·WP3 은 S8, WP11 은 S2) |
| D | WP4, WP5, WP7, WP14, WP16 | WP3 / WP9 |
| E | WP6, WP12, WP17, WP18 | WP5, WP7, WP11, WP13 |
| F | WP19, WP20, WP21, WP-X | 필요할 때 |

- 한 배치 안의 WP 는 서로 다른 파일만 고친다. 공용 파일(`_parts`, `testing/scmodel.py`)을 고쳐야 하면 **그 배치에서 한 WP 만** 맡고 나머지는 요청을 남긴다.
- 인게임 확인은 사용자 몫이다. 배치 끝마다 `docs/INGAME_CHECKLIST.md` 에 확인 항목을 모은다.

### 6.3 에이전트 지시문 틀

```
너는 eudext 의 WP<n>(<모듈>) 을 구현한다.
- 설계: MapSource\Py\eudext\DESIGN.md 3절(공통 규약)과 4.<k>절. 규약과 다르게 하려면 먼저 멈추고 이유를 보고한다.
- 재료: <R 문서 절>, <재사용 코드 파일:줄> (복사해 오고 출처를 주석에)
- 환경: C:\Users\whatd\.venvs\eud081\Scripts\python.exe (eudplib 0.81.0). euddraft 빌드는 C:\euddraft0.11.0.1. 기존 C:\euddraft0.9.2.0 과 eud076 venv 는 건드리지 않는다.
- 고칠 수 있는 파일: eudext\<모듈>.py, eudext\tests\t_<모듈>.py, eudext\examples\<모듈>_*.{py,eps}, eudext\docs\COSTS.md(덧붙이기만)
- 다른 모듈에 필요한 변경은 고치지 말고 보고에 적는다.
- 완료 조건: DESIGN.md 6.4 + 6.1 표의 추가 조건.
- 보고(300단어 이내): 만든 API, 시험 결과(건수), 비용 측정값, 설계와 달라진 점, 인게임 확인 항목.
```

### 6.4 완료 조건 (모든 WP 공통)

1. 공개 API 가 4절 초안과 맞거나, 달라진 점을 DESIGN.md 에 반영했다.
2. docstring 이 3.12 형식을 따른다(비용·CP·로컬 표기 포함).
3. `tests/t_<모듈>.py` 가 에뮬레이터에서 통과한다: 파이썬 참조와 무작위 + 경계값 차등(해당되는 모듈).
4. `tools/cost.py` 측정값을 `docs/COSTS.md` 에 기록했고 3.8 목표를 넘으면 이유를 적었다.
5. epScript 예제가 `epsCompile` 번역과 euddraft 빌드를 통과했다(epScript 대상 모듈).
6. `_compat` 밖에서 비공개 API 를 쓰지 않았다. 금지 목록(3.9)을 어기지 않았다.
7. 에뮬레이터로 확인할 수 없는 동작은 `docs/INGAME_CHECKLIST.md` 에 항목으로 남겼다.

---

## 7. 결정이 필요한 것

| # | 질문 | 권장 | 영향 |
|---|---|---|---|
| D1 | 라이브러리 이름 | **결정: `eudext`** (2026-09-17) | — |
| D2 | euddraft 를 최신판으로 올릴지 | **결정: 올린다** (2026-09-17). 0.11.0.1 을 나란히 설치하고 eudext 기준 판으로. 기존 맵용 0.9.10.11 은 유지 | 2.1, WP0 재측정 |
| D3 | 뺄셈 두 의미의 이름 | **사용자 지시: 포화와 wrap 을 확실히 구분**(64비트 구현의 핵심). 잠정안 = 연산자 wrap, 포화는 `sub_sat`/`Subtract` 이름. S8 결과로 확정 | i64, cell, 모든 값 타입 |
| D4 | 0 나눗셈 기본값 | eudplib 과 같게(몫 전부 1, 나머지 = 피제수). `div0="ctrig"` 선택 | 부호 나눗셈 |
| D5 | 각도 기준 | **결정: CtrigAsm 과 같게 고정**(옵션 없음). 결과 값까지 CtrigAsm `f_Lengthdir`/`f_Atan2`/CA_ 와 같게 | mathx, plot, spawn |
| D6 | 도형 좌표 정수화 | **결정: CtrigAsm(TEP) 과 같게 0 방향 자르기로 고정**(옵션 없음) | shape |
| D7 | 입력 전송 | 1단계 MSQC/NSQC + eds 생성, 자체 전송은 3단계 선택 | 빌드 순서가 2단계가 됨 |
| D8 | (해결됨) epScript 에서 키워드 인자 | 파이썬 함수 호출의 키워드 인자는 번역된다. 따로 할 일 없음 | — |
| D9 | SCR_DB 네이티브를 언제 | 2단계(WP18). 새 맵이 저장을 쓸 때 | 런처 호환 시험 |
| D10 | 위험 기능 포함 여부 | `unsafe_exit_trap` 은 실험 기능으로만, `ObserverDrop` 은 넣지 않음 | 맵 신뢰성 |
| D11 | Ccode 정수 코드 | 없앰(객체 핸들만) | 옛 코드 직역 불가(호환 계층 몫) |
| D12 | 128비트 | 새 맵이 필요로 할 때(WP20) | — |

---

## 8. 참고 — 조사 문서 요약 위치

| 알고 싶은 것 | 문서·절 |
|---|---|
| 맵별 호출 수·실제 인자 모양 | `docs/research/R1_usage.md` 1·2절 |
| 이식 계층에서 떼어 올 코드(파일:줄) | `docs/research/R2_existing.md` 7.1 |
| 에뮬레이터가 흉내 내는 범위 | R2 4.1 |
| SCR_DB 네이티브 제약 | R2 3.1 |
| 값 타입·조건·함수·CP 규약 근거 | `docs/research/R3_eudplib_conv.md` 1절 |
| epScript 번역 규칙(실험) | R3 2절, `docs/proto/eps_probe_out.txt` |
| euddraft 경로 규칙·부트 | R3 3절 |
| 최신 eudplib 대비 | R3 4절 |
| 총알 원리·dat 필드 | `docs/research/R4a_bullet_text.md` A |
| 숫자 서식 확장 지점 | R4a C |
| 글자 셀 배치 차이 | R4a D.1 |
| 채팅 버퍼 사실 | R4a E.1 |
| 입력 주소·MSQC 동작 | `docs/research/R4b_input_shape_misc.md` A |
| CB Paint 도형 형식·lupa 적재 | R4b B1~B4 |
| CAPlotIndexed 구조 | R4b B5 |
| lengthdir/atan2 원본 동작 | R4b C |
| ExitDrop 원리 | R4b D4 |
