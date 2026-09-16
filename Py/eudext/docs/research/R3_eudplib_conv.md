# R3. eudplib 라이브러리 작성 규약 · epScript 연동 · 최신판 비교 (eudext 설계 재료)

작성 2026-09-17. 기준: eudplib 0.76.14 소스 `C:\Users\whatd\.venvs\eud076\Lib\site-packages\eudplib\`(아래 경로는 이 폴더 기준),
euddraft `C:\euddraft0.9.2.0`(실제 판 0.9.10.11, 파이썬 3.11.6 frozen, 내장 eudplib 0.76.14).
최신판 비교에는 스크래치패드에 얕게 복제한 `upstream\eudplib`(0.81.0)와 `upstream\euddraft`(0.11.0.1)을 썼다.
"(실험)" 표시는 스크래치패드에서 직접 돌려 본 결과다. 실험 파일 목록은 맨 끝(6절)에 있다. 확인하지 못한 것은 "(추측)"이라고 적었다.

---

## 0. 한눈에

| 주제 | 결론 |
|---|---|
| 64비트 같은 값 타입 | **파이썬 클래스 안에 EUDVariable 두 개(lo, hi)를 담는 방식**을 권장한다. EUDStruct 는 참조형(포인터)이라 값 연산에 맞지 않는다. EUDVariable 을 상속하면 32비트 연산이 소리 없이 섞인다. 시제품을 만들어 에뮬레이터로 400개 경우를 검사했고 모두 맞았다. |
| 비교 연산 결과 | "조건으로 쓸 수 있는 것"을 돌려준다: `Condition`, Condition 목록(AND), `EUDLightBool`, 0/1 `EUDVariable`. 앞 계산 트리거가 필요하면 **연산자를 부를 때** 트리거를 낸다. EUDIf, EUDWhile, EUDSCAnd 가 그 순서를 지켜 준다(실험 확인). |
| 함수 | 변수끼리 연산은 지연 생성하는 `EUDFunc` 한 벌로, 상수 연산은 `functools.cache` 로 상수마다 만들거나 짧으면 인라인한다. 64비트 값은 EUDTypedFunc 인자 하나로 넘길 수 없어서 (lo, hi) 두 인자로 넘긴다. |
| CP | 잠깐 바꿨다면 끝에서 `f_setcurpl2cpcache()` 로 되돌린다. 계속 바꿀 거면 `f_setcurpl`, `SetCurrentPlayer` 를 쓴다. `SetMemory(0x6509B0, SetTo, …)` 로 바꾼 채 두면 안 된다. |
| epScript 에서 쓸 수 있는 범위 | 클래스 생성, 이항 연산자, 비교, 메서드, 속성 쓰기(`x.v = …`, `x.v += …`)는 된다. **`const` 로 묶은 객체에는 `=`, `+=` 를 쓸 수 없고**, `var` 에 담으면 32비트 변수 하나로 바뀌어 타입을 잃는다. 모듈 함수 `m.foo()` 는 **`m.f_foo()` 로 번역된다**. `from … import`, 기본 인자, 데코레이터, 문자열 상수 선언은 0.76.14 에서 안 된다. |
| 공용 패키지 불러오기 | euddraft 는 플러그인 하나를 읽고 나면 **`sys.path` 를 원래대로 되돌린다**. 그래서 맨 앞 부트 플러그인이 경로를 넣고 **그 자리에서 `import eudext`** 까지 해 둔다. 그 뒤로는 `eudext.*` 하위 모듈(.py와 .eps)을 어디서나 불러올 수 있다(euddraft 실측). |
| 최신판(eudplib 0.81.0, euddraft 0.11.0.1) | 64비트 정수, 키·마우스 입력, 부호 있는 비교, 총알·스프라이트 생성, sprintf 서식 확장은 **여전히 없다**. 바뀐 것은 epScript 타입 변수(`var x: T = …`), 문자열 식, 변수끼리 `<`·`>` 버그 수정, scdata(`TrgUnit.armor += 1` 같은 멤버 접근), 파이썬 3.13/3.14t 이다. |

---

## 1. 값 타입 · 조건 · 함수 · CP 규약

### 1.1 EUDVariable 이 연산자를 구현하는 방식 (근거)

- 변수 하나는 72B 크기의 "변수 트리거"이고, 값은 액션 칸 안에 있다. 값 주소는 `_varact + 20` 이다. `core/variable/eudv.py:168-182`
- 기반 클래스 `VariableBase` 가 조건과 액션을 만든다. `AtLeast/AtMost/Exactly` 는 `Memory(...)` 조건을, `SetNumber/AddNumber/SubtractNumber` 는 `SetMemory` 액션을 돌려준다. `core/variable/vbase.py:31-49`
- **비교 연산자는 트리거를 만들지 않고 `Condition` 을 돌려준다.** `vbase.py:163-188`, `eudv.py:578-647`
  - `__ne__` 는 0이나 0xFFFFFFFF 와 비교할 때만 조건 하나로 끝난다. 그 밖에는 `(self - other).AtLeast(1)` 를 쓰므로 앞 계산 트리거가 생긴다. `eudv.py:587-593`
  - `__lt__`/`__gt__` 에 변수를 넣으면 `AtMost(other - 1)` 가 된다. 이때 임시 변수를 조건의 amount 칸에 넣는데, **b==0 이나 b==0xFFFFFFFF 일 때 답이 틀린다**(1.6 실험). `eudv.py:617-647`
- **대입은 `<<` 로 한다.** `vbase.py:75-79`, `eudv.py:295-301`(SeqCompute 한 번). 파이썬의 `=` 는 이름을 다시 묶을 뿐 트리거를 만들지 않는다.
- 제자리 연산 `+=` 은 `SeqCompute((self, Add, other))` 이고 self 를 돌려준다. `eudv.py:303-305`
  - `-=` 에 상수를 넣으면 `Add(-k)` 로 바꿔 wrap 뺄셈을 한다. 변수를 넣으면 `(~0 - other) + (self + 1)` 로 계산한다. `eudv.py:307-323`
  - **`Subtract` 액션을 쓰지 않는 것이 규약이다.** SetDeaths 의 Subtract 는 0 에서 멈춘다(포화). `VariableBase.__isub__`(`vbase.py:85-87`)는 Subtract 를 쓰므로 `EUDLightVariable -= 5` 는 0 에서 멈춘다(1.6 실험).
- 이항 연산은 임시 변수(rvalue)를 재활용한다. `_is_rvalue` 가 참조 수로 임시값인지 판정하고, 임시값이면 새 변수 대신 제자리 연산을 한다. 결과는 `makeR()` 로 임시값 표시를 붙인다. `eudv.py:71-76, 327-341`
- `* // % >>` 등은 자리표시만 있다가 `core/calcf/_eudvsupport.py:36-45` 가 `setattr(EUDVariable, …)` 로 붙인다. 제자리 연산은 `ret=[x]` 로 결과를 자기 자신에 받는다(40-44행). **"결과 변수를 `ret=` 로 지정하는" 관용**의 원형이다.
- 연산 → 트리거 변환의 핵심은 `SeqCompute`(`eudv.py:809-882`, 액션 64개 단위로 나눈다)와 `VProc`(`eudv.py:701-716`, 변수 트리거를 거쳐 실행한다)이다.

### 1.2 64비트 값 타입: 권장 형태

#### 선택지 비교

| 형태 | 장점 | 단점 | 판정 |
|---|---|---|---|
| **A. 파이썬 클래스에 EUDVariable 두 개를 담음 (`Int64.lo/.hi`)** | 읽기 비용이 없다(조건에 lo/hi 를 바로 넣음). 연산자 모양을 마음대로 정한다. 상수 접기와 인라인이 쉽다. 타입이 섞일 위험이 없다. | EUDTypedFunc, EUDVArray 에 한 칸으로 들어가지 않는다. epScript 는 `const` 로 묶고 메서드나 속성으로 고쳐야 한다. | **권장** |
| B. `EUDVariable` 상속 (자기 자신 = lo, `self.hi` 추가) | epScript 에서 `var x = Int64(…)` 가 임시값일 때만 타입이 남는다(`_LVAR` 재사용). | 임시값이 아니면 `_LVAR` 가 lo 만 복사해 **hi 가 소리 없이 사라진다**(`epscript/helper.py:490-496`). 오버라이드하지 않은 32비트 연산이 그대로 섞이고, EUDFunc 인자로 넘기면 lo 만 간다. | 비추천 |
| C. `EUDStruct`(필드 lo, hi) | 필드 접근이 쉽고, EUDTypedFunc/`EUDStruct * n`/`alloc` 을 쓸 수 있다. | **참조형이다**: 프록시 값이 포인터라 `a + b` 가 포인터 덧셈이 된다(`utils/exprproxy.py:52-53`). `<<` 는 오류를 낸다(`core/eudstruct/eudstruct.py:137-138`). `copy()` 는 호출 자리마다 정적 인스턴스를 새로 만든다(86-91행). 함수 인자로 넘기면 같은 저장소를 가리킨다(에일리어싱). 변수 self 로 필드를 읽으면 트리거 2~3개가 든다(`vararray.py:217-247`). 0.76.14 의 `EUDMethod` 는 정적 인스턴스마다 본문을 복제한다(`core/eudfunc/eudfmethod.py:64-79`, 0.10.0.0 에서 고침). | 64비트 **저장소 참조**(`Int64Ref`, 동적 할당용)로만 |
| D. `ExprProxy` 하위 클래스 | eudplib 의 cast 규약에 맞춘다(`exprproxy.py:22-27`). | 값 하나를 감싸는 구조라 변수 두 개에 맞지 않는다. 산술을 다 오버라이드해야 한다. | 불필요 |

참고: `EUDStruct()` 는 alloc 이 아니다. 인자 없이 만들면 **정적 EUDVArray**(`eudstruct.py:23-28`)이고, 동적 할당은 `.alloc()`/`.free()`(`eudstruct.py:33-42`, objpool)다.
EUDVArray 의 `basetype` 은 원소 하나(32비트)를 `basetype.cast(r)` 로 감싼다(`vararray.py:151-153`). 그래서 64비트 원소는 넣을 수 없다.

#### 권장 구현 스케치 (시제품 `edtest\shared\eudext\i64.py` 에서 발췌)

```python
class Int64:
    __slots__ = ("lo", "hi")
    dont_flatten = True                  # FlattenList 가 쪼개지 않게 (utils/etc.py:88)

    def __init__(self, value=0, hi=None):
        if hi is None and isinstance(value, int):     # EUDVariable(상수)와 같은 규약: 초기값만, 트리거 없음
            lo_i, hi_i = _split(value); self.lo, self.hi = EUDVariable(lo_i), EUDVariable(hi_i); return
        self.lo, self.hi = EUDVariable(), EUDVariable()
        if hi is None: self << value                   # Int64/EUDVariable 복사
        else: SeqCompute([(self.lo, SetTo, value), (self.hi, SetTo, hi)])

    @classmethod
    def wrap(cls, lo, hi): ...           # 복사 없이 감싸기 (EUDFunc 인자·반환 받기)

    def __lshift__(self, other):         # 대입. EUDVariable 과 같이 self 를 돌려준다
        lo, hi = Int64._parts(other); SeqCompute([(self.lo, SetTo, lo), (self.hi, SetTo, hi)]); return self

    def __iadd__(self, other):
        blo, bhi = Int64._parts(other)
        if isinstance(blo, int) and isinstance(bhi, int):   # 상수: 인라인 2트리거
            RawTrigger(conditions=self.lo.AtLeast((1<<32) - blo), actions=self.hi.AddNumber(1))  # 올림(더하기 전 값으로 검사)
            RawTrigger(actions=[self.lo.AddNumber(blo), self.hi.AddNumber(bhi)])
        else:                                                 # 변수: 공유 EUDFunc, 결과를 자기 변수로
            _add64(self.lo, self.hi, blo, bhi, ret=[self.lo, self.hi])
        return self

    def __add__(self, other):            # 임시값 = 호출 자리마다 새 변수 2개 (eudplib 과 같은 규약)
        t = Int64(self); t += other; return t

    def __ge__(self, other): ...         # 상수 → EUDLightBool(트리거 2~3), 변수 → _geu64(...) 의 0/1 변수
    def __eq__(self, other):             # 부작용 없는 조건 목록(AND)
        blo, bhi = Int64._parts(other); return [self.lo == blo, self.hi == bhi]
    __hash__ = ...                        # __eq__ 를 바꿨으니 id 기반으로 다시 정의

    # epScript 통로: const 로 묶인 객체를 고친다 (2절 참고)
    v = property(lambda s: s, lambda s, val: s.__lshift__(val))   # x.v = y
    def iaddattr(self, name, value): ...                          # x.v += y  (_ATTW 가 부른다)

    # 인쇄: f_dbstr_print/f_eprintln/f_cpstr_print 는 arg.fmt() 를 부른다 (eudprint.py:269-270, cpprint.py:224)
    def fmt(self): buf = DBString(24); f_sprintf(buf, "0x{:x}{:x}", self.hi, self.lo); return buf

    # 실수 막기
    def __bool__(self): raise EPError(...)       # 파이썬 if 에 넣기
    def __format__(self, spec): raise EPError(...)  # f_sprintf("{}", x) 는 format() 으로 가서 객체 repr 이 찍힌다 (fmtprint.py:114)
    def __repr__(self): return "<… epScript 에서는 var 대신 const …>"   # _LVAR 오류문에 그대로 나온다 (1.6)
    @classmethod
    def cast(cls, _from): raise EPError("(lo, hi) 두 인자로 넘기세요")   # EUDTypedFunc([Int64]) 방지

# 변수-변수 본문: 지연 생성 1벌 (올림은 '포화 뺄셈'으로 판정)
@EUDFunc
def _add64(alo, ahi, blo, bhi):
    carry = EUDVariable()
    alo += blo                                              # wrap
    SeqCompute([(carry, SetTo, blo), (carry, Subtract, alo)])   # carry = max(blo - alo, 0) > 0  <=>  새 alo < blo
    ahi += bhi
    RawTrigger(conditions=carry.AtLeast(1), actions=ahi.AddNumber(1))
    return alo, ahi
```

- **"포화 뺄셈" 비교 기법**: `SeqCompute((d, Subtract, var))` 는 Subtract 액션을 그대로 쓰므로 `d = max(a-b, 0)` 이 된다. 그래서 `d>0 ⇔ a>b` 로 변수끼리 **부호 없는 비교를 정확히** 할 수 있다. 최신 eudplib 이 `__lt__` 를 고칠 때 쓴 방식과 같다(`upstream\eudplib\src\eudplib\core\variable\eudv.py:589-620`). 최신판은 조건의 첫 칸에 값을 쓰고 그 칸을 스스로 읽게 해서 트리거를 1개로 줄였다.
- 부호 있는 비교는 두 값의 부호 비트를 뒤집은 뒤(`hi.AddNumber(0x80000000)`) 부호 없는 비교를 한다. EUDFunc 인자는 호출된 쪽의 사본이라 고쳐도 된다.
- 32비트 부호 있는 비교(`f_sge32`)의 예:
  - k ≥ 0 이면 `[x.AtLeast(k), x.AtMost(0x7FFFFFFF)]` **조건 목록**이다(트리거 0개).
  - k < 0 이면 OR 형태라 `EUDLightBool` 플래그로 계산한다(트리거 2개).
  - 변수끼리는 사본의 부호 비트를 뒤집고 포화 뺄셈으로 비교한다.

#### 시제품 검증 (실험: `proto\t_i64_emu.py`, DPS_eud `eud\tests\emu.py` 를 복사해 씀)

- 무작위와 경계값(0, 1, 2³²−1, 2³², 2⁶³−1, 2⁶³, 2⁶⁴−1 …) 400개로 검사했다. 검사한 연산은 add/sub(변수·상수 9종), `>= <= < > == !=`, 부호 있는 `sge`(변수·상수), 32비트 `sge32`(변수·상수 6종)다. **모두 맞았다(fails 0).**
- 트리거 수(`GetTriggerCounter()` 차이, 함수 본문은 처음 부를 때 한 번 포함):

| 연산 | 트리거 |
|---|---|
| `S << A + B` (변수) | 9 (본문 `_add64.size()` 6 포함) |
| `D << A - B` (변수) | 11 (본문 `_sub64.size()` 8 포함) |
| `T << A; T += K` (상수) | 1~3 (인라인) |
| `A >= K` 를 EUDIf/Else 로 값 만들기 | 7~8 (비교만 따지면 2~3) |
| `sge32(x, k)` + EUDIf/Else | 5 (k≥0, 조건 목록) / 6~7 (k<0, 플래그) |

- 부작용이 있는 조건이 매번 다시 계산되는지도 확인했다(`proto\t_loopcond.py`). `EUDWhile()(A < 0x100000005)` 는 21회 반복했고 정답과 같다. `EUDSCAnd()(A >= K)(z == 0)()` 와 `EUDSCOr()(…)(A >= K, neg=True)()` 도 맞았다.

#### 배열

`EUDVArray(n, Int64)` 는 원소 하나를 cast 하는 구조라 쓸 수 없다. **구조체 배열 대신 배열 두 개를 둔다**(`Int64Array(n)` = lo 배열 + hi 배열, `arr[i]` 는 `Int64.wrap(lo[i], hi[i])` 임시값).

| 배열 종류 | 원소 크기 | 변수 번호로 읽기 |
|---|---|---|
| EUDVArray | 72B | 공유 비트 트리거 28개 + 호출마다 1~2개 (`vararray.py:155-215`) |
| EUDArray | 4B | 한 번 읽을 때마다 `f_dwread_epd` 호출 (`eudlib/eudarray.py:101-103`) |

동적 할당이 필요하면 C안의 `Int64Ref(EUDStruct)` 를 따로 둔다(추측: 쓰임이 있을 때만).

### 1.3 조건 객체 규약

**받아들이는 형태**: `EUDIf()(…)`, `EUDWhile()(…)`, `EUDJumpIf`, `Trigger(conditions=…)`, `EUDBranch` 는 모두 `FlattenList` → `patch_condition` 을 거친다(`trigger/branch.py:59-60`, `trigger/triggerdef.py:48-56`). `patch_condition`(`trigger/tpatcher.py:89-110`)이 받는 것:

| 입력 | 변환 |
|---|---|
| `Condition` | 칸에 EUDVariable 이 있으면(`condpt`, 54-60행) **그 자리에서 채움 트리거를 내고**(`apply_patch_table` 33-51행) 칸을 0 으로 바꾼다 |
| `EUDVariable` / `EUDLightVariable` | `Memory(addr, AtLeast, 1)` (≠0) |
| `EUDLightBool` | `MemoryX(…, AtLeast, 1, mask)` |
| `bool` / `int` | `Always`/`Never` |
| `Forward`(설정됨), 캐스트형 ExprProxy 상수 | 경고 후 Always/Never |
| **리스트(중첩 가능)** | AND. 16개가 넘으면 EUDBranch 가 16개씩 나눈다(`branch.py:67-76`), Trigger 도 나눈다(`triggerdef.py:68-116`) |

`RawTrigger` 는 patch 를 거치지 않는다. 조건 칸에 상수(ConstExpr)만 넣을 수 있고 16개를 넘기면 오류가 난다(`core/rawtrigger/rawtriggerdef.py:132,145`, `condition.py:116-162`). bool 은 받는다(134행).

**부정(neg)**:
- `EUDIf()(c, neg=True)`, `EUDWhileNot` 은 `EUDJumpIf` 로 분기만 바꾼다(`ctrlstru/simpleblock.py:29-35`, `loopblock.py:115-121`). 그래서 **어떤 조건이든 부정할 수 있다.**
- `EUDNot(c)`(`eudlib/utilf/logic.py:59-85`)은 순서대로 시도한다: 변수 → `==0` 조건, `negate_cond` → `Condition.negate()`(`condition.py:192-251`, 비교 상수가 int 이고 AtLeast/AtMost 이거나 Exactly 0/0xFFFFFFFF 일 때만 된다). 둘 다 안 되면 EUDIf 로 `EUDLightBool` 을 만든다.
- `EUDSCAnd` 는 부정할 수 있는 상수 조건만 목록에 모은다(`ctrlstru/shortcircuit.py:72-84`).

**앞 계산이 필요한 조건의 규칙**:
1. 연산자나 함수를 **부르는 순간** 트리거를 낸다. 결과로는 조건으로 쓸 수 있는 값(플래그/변수/Condition)을 돌려준다.
   - 파이썬은 `EUDWhile()` 를 인자보다 먼저 평가한다. `EUDWhile()` 가 그 자리에서 `loopstart = NextTrigger()` 를 잡으므로(`loopblock.py:104-125`) 조건 계산이 루프 **안**에 들어간다(실험 확인).
   - `EUDIf()` 도 블록을 먼저 만든다(`simpleblock.py:21-37`).
2. `EUDSCAnd` 는 생성자에서 `PushTriggerScope()` 를 하고, 조건을 받은 뒤 트리거 목록이 바뀌었으면 부작용으로 보고 따로 처리한다(`shortcircuit.py:14-20, 56-71`). 그래서 epScript 의 `&&`/`||` 안에서도 앞 계산이 안전하다.
3. **같은 `Condition` 객체를 두 트리거에 쓰면 오류**다(`condition.py:164-166`, 실험). 라이브러리는 **부를 때마다 새 Condition 을 만들어야 하고, 캐시하면 안 된다.**
4. Condition 에 산술을 하면 "Orphan condition"이 된다(`condition.py:175-178`). Condition 을 `EUDReturn` 에 넣거나 `SetVariables` 로 값처럼 쓰면 안 된다(1.6).
5. `Condition.__bool__` 은 오류를 낸다(`condition.py:189-190`). 파이썬 `if` 에 넣으면 막힌다. 값 타입도 같은 방어를 둔다(시제품 `__bool__`).
6. 권장 반환 형태:
   - **(가) 부작용 없는 Condition 또는 목록**: 가장 싸고 `EUDSCAnd` 에서 부정할 수 있다.
   - **(나) `EUDLightBool`**: OR 형태나 여러 단계 판정일 때. 1비트만 쓰고 `IsSet/IsCleared` 로 부정한다.
   - **(다) EUDFunc 가 돌려준 0/1 `EUDVariable`**: 본문이 클 때.
   - 조건이 필요 없는 곳에 값으로 넘길 때는 epScript 의 `_L2V`(`epscript/helper.py:470-477`)처럼 EUDIf 로 0/1 을 만든다.

### 1.4 함수 규약

- **`EUDFunc` 의 성질** (`core/eudfunc/eudfuncn.py`)
  - 본문은 **처음 부를 때** 별도 트리거 영역에 한 번 만든다(`211-213`, `81-133`, `PushTriggerScope` 94행). 한 번도 부르지 않은 함수는 싣지 않는다.
  - 인자와 반환값은 함수마다 고정된 변수다(`135-143`, `145-149`). 그래서 **재귀나 재진입이 안 된다.**
  - 반환 개수는 첫 `return` 에서 정해진다(`151-155`). `return a, b` 로 여러 개를 돌려준다.
  - `ret=[v1, v2]` 로 결과를 받을 변수를 지정한다(`225-241`). 받은 값에는 `makeR()` 가 붙는다(`257-262`).
  - 호출 비용은 SeqCompute 1회 + 점프다(`233-255`).
- **상수 특수화 관용**
  - `functools.cache` 로 상수마다 EUDFunc 를 만든다: `eudlib/mathf/div.py:40-46, 112-118`, `core/eudstruct/vararray.py:35,104`, `eudlib/memiof/memifgen.py:19,79`.
  - 손으로 dict 에 캐시하는 예: `_const_mul` `core/calcf/muldiv.py:140-208`(0, 1, −1, 2의 거듭제곱은 따로 처리), `_const_div` 211행~.
  - 변수끼리 연산은 `hasattr` 로 **처음 부를 때 한 벌만** 만든다(`div.py:23-32`).
  - 분기 순서: 둘 다 상수 → 파이썬에서 계산, 한쪽 상수 → 특수화, 둘 다 변수 → 일반 함수(`div.py:14-37`, `muldiv.py:22-38`).
  - 본문이 트리거 2~3개면 함수로 만들지 말고 인라인한다(시제품 상수 덧셈).
- **`EUDTypedFunc(argtypes, rettypes)`** (`core/eudfunc/eudf.py:19-43`, `eudtypedfuncn.py:15-72`): 호출 전후에 `vartype.cast(var)` 를 부른다(42-46행). 인자 하나 = 변수 하나다. **64비트 값은 (lo, hi) 두 인자로 받고 본문에서 `Int64.wrap(lo, hi)` 로 감싼다**(시제품에서 `cast` 가 안내 오류를 내게 함, 1.6).
- **`_EUDPredefineParam/_EUDPredefineReturn`**(`eudf.py:118-180`): 내부 최적화용이다.
  - 인자와 반환을 공유 변수나 **CurrentPlayer(0x6509B0)** 에 직접 묶는다(128-129행).
  - 제약: "본문에서 다른 EUDFunc 호출 금지", "modifier 를 SetTo 로 되돌릴 것" 등(주석 119-124, 154-160).
  - 라이브러리에서는 성능이 꼭 필요할 때만 쓴다.
- **`EUDFuncPtr(argn, retn)` / `EUDTypedFuncPtr`**(`core/eudfunc/eudfptr.py:82-175`)
  - 인자 수마다 공용 인자·반환 저장소를 거친다(22-33행). `fp = EUDFuncPtr(1,1)(f)` 로 만들고 `fp << g` 로 바꾸며 `fp(x)` 로 부른다.
  - 대상 함수마다 간접 호출기 트리거가 생긴다(61-76행).
  - 값 타입을 넘기려면 역시 (lo, hi) 두 칸이 필요하다.
- **`EUDMethod`**(`eudfmethod.py:21-96`): 변수 self 면 공용 본문 하나를 쓴다. 상수 self(정적 EUDStruct)면 인스턴스마다 본문을 따로 만든다(64-79행, 0.76.14).
- **트리거 수 측정**
  - `f.size()`(`eudfuncn.py:75-79`)는 필요하면 본문을 만들고 `_triggerCount` 를 돌려준다. 함수 안의 트리거만 센다(22-38행).
  - `GetTriggerCounter()`(`rawtriggerdef.py:27-31, 101-102`)는 만들어진 RawTrigger 전체 수다. 구간 차이로 호출 자리 비용을 잰다(시제품 표). 차이에는 그 구간에서 처음 만든 함수 본문도 들어간다.

### 1.5 CP(현재 플레이어) 캐시 규약

- **구조**(`core/curpl.py:13-42`): `_curpl_var`(캐시 값)와 `_curpl_checkcond`(= `Memory(0x6509B0, Exactly, 캐시)` 조건)를 짝으로 둔다.
  - `SetCurrentPlayer(p)`/`AddCurrentPlayer(p)` 는 캐시, 검사 조건, 실제 0x6509B0 **세 곳을 같이** 바꾸는 액션 3개다.
- **함수** (`eudlib/memiof/modcurpl.py`)

| 함수 | 줄 | 하는 일 |
|---|---|---|
| `f_setcurpl(cp)` | 16-34 | 변수면 VProc 2개로 세 곳을 갱신한다. 상수면 `SetCurrentPlayer` |
| `f_setcurpl2cpcache()` | 37-43 | **0x6509B0 을 캐시 값으로 되돌린다.** 캐시는 그대로다 |
| `f_getcurpl()` | 62-76 | 검사 조건이 거짓이면 32비트 판독으로 캐시를 다시 채운다(47-59행) |
| `f_addcurpl` | 79-92 | CP 에 값을 더한다 |

- **라이브러리 함수가 지킬 것**
  1. **CP 를 잠깐 옮겨 쓰는 함수**(EPD 읽기 등)는 `SetMemory(0x6509B0, Add, …)` 로 옮기고, **끝에서 반드시 `f_setcurpl2cpcache()`** 를 부른다. 예: `dwepdio.py:19-44`(28행에서 옮기고 42행에서 되돌림), `inplacecw.py:46-48`, `locf.py:305`.
  2. **CP 를 바꾼 채 두려는 함수**(DisplayText 대상 변경 등)는 `f_setcurpl`/`SetCurrentPlayer` 를 쓴다. `SetMemory(0x6509B0, SetTo, x)` 로 바꾸고 캐시를 두면 다음 `f_setcurpl2cpcache()` 가 **옛 값으로 되돌린다**(README "소리 없이 틀리기 쉬운 곳"과 같음).
  3. 호출하는 쪽의 CP 를 바꾸지 않는 것을 기본 계약으로 삼는다. 최신판도 `f_rand()` 가 CP 를 바꾸지 않게 고쳤다(euddraft 0.10.0.1).
  4. 인자를 CP 로 직접 받는 최적화(`_EUDPredefineParam(CurrentPlayer)`)는 부르는 순간 캐시가 깨지므로 본문 끝에서 복구가 필수다(`dwepdio.py:19-44`).
  5. CP 를 쓰는 조건·액션(`Deaths(CurrentPlayer, …)`)을 내기 전에 CP 가 캐시와 같다고 가정할 수 있는 곳은 "직전에 f_setcurpl 류를 부른 뒤"뿐이다. 모르면 `f_getcurpl()` 로 읽는다.

### 1.6 0.76.14 함정 (실험: `proto\t_pitfalls.py`)

| 실험 | 결과 |
|---|---|
| 변수끼리 `a < b`, a=5, b=0 | **1 (틀림)**. a=b=0 일 때도 1. 원인은 `AtMost(b-1)` 의 wrap. 최신판에서 고침(euddraft 0.10.0.0 "Fixed `<`, `>` for EUDVariable") |
| 변수끼리 `a > b`, b=0xFFFFFFFF | **1 (틀림)**. 같은 원인 |
| `EUDLightVariable(3) -= 5` | **0** (Subtract 포화). `EUDVariable(3) -= 5` 는 0xFFFFFFFE (wrap) |
| epScript `var q = i64.Int64(5);` 번역(`_LVAR`) | `EPError: 잘못된 amount 필드: <…>`. 시제품 `__repr__` 에 안내문을 넣어 두면 그대로 보인다 |
| `f_dbstr_print(buf, x)` (fmt 훅) | 된다 |
| `f_sprintf(buf, "{}", x)` | `__format__` 에서 막는다. 막지 않으면 객체 문자열이 찍힌다(`fmtprint.py:114`) |
| `f_sprintf(buf, "{}", x.fmt())` | 된다(DBString 을 돌려주므로) |
| `EUDTypedFunc([Int64])(x)` | 시제품 `cast` 가 안내 오류를 낸다 |
| epScript `return p < q;` → `EUDReturn(EUDNot(p >= q))` | **컴파일 오류**. EUDNot 이 EUDLightBool 을 돌려주고, 반환값은 amount 칸에 들어갈 수 없다. `return a == b;` 도 Condition 을 반환하므로 같다(추측: Orphan 오류). **epScript 에서 조건을 반환하려면 `return a < b ? 1 : 0;`** |
| 같은 Condition 을 두 번 `RawTrigger` 에 넣기 | `조건을 2개 이상의 트리거와 공유할 수 없습니다` |

---

## 2. epScript 연동 규칙 (실험 결과)

실험 방법:
- `eps_exp\probe.py`, `probe2.py` 가 코드 조각 약 140개를 `epsCompile`(`epscript/epscompile.py:47-54`)로 번역한다. 결과는 `probe_out.txt`, `probe2_out.txt` 에 있다.
- 따로 실제 euddraft 로 빌드도 했다(3절).
- 번역문 머리에는 항상 `from eudplib import *` 와 helper `_RELIMP, _IGVA, _CGFW, _ARR, _VARR, _SRET, _SV, _ATTW, _ARRW, _ATTC, _ARRC, _L2V, _LVAR, _LSH` 가 붙는다.

### 2.1 import

| epScript | 파이썬 번역 | 비고 |
|---|---|---|
| `import eudext.i64 as i64;` | `from eudext import i64 as i64` | 됨 |
| `import eudext.fmt;` | `from eudext import fmt` | **마지막 이름(`fmt`)만** 묶인다. `eudext.fmt.foo()` 는 "Undefined rvalue eudext" |
| `import mylib;` | `import mylib` | 됨 |
| `import .sibling [as sb];` | `sb = _RELIMP(".", "sibling")` | 같은 폴더의 .py 를 먼저, 없으면 .eps (`helper.py:54-73`) |
| `import ..parentmod as pm;` / `import ..shared.eudext.relmod as rm;` | `_RELIMP("..", …)` / `_RELIMP("..shared.eudext", "relmod")` | 됨. 단 **최상위 모듈 `relmod` 로 따로 올라간다**(`__package__` 비어 있음, euddraft 실측). `eudext.relmod` 와 다른 객체라 상태가 둘로 갈린다 |
| `import py_mylib;` | — | 오류. `py_` 는 모듈 이름에 쓰지 않는다 |
| `from a import b;`, `from a import *;` | — | **문법 오류**(0.81 문법에도 없음: `upstream\…\epparser.lemon:182,206` 에 `IMPORT dottedName [AS NAME]` 뿐) |
| 패키지 안의 .eps (`import eudext.epsmod as em;`) | `from eudext import epsmod as em` | 됨. `EPSFinder` 가 `sys.meta_path` **끝**에 붙어 있다(`epscript/epsimp.py:168-190`). 그래서 **같은 이름의 .py 가 있으면 .py 가 먼저** 잡힌다 |

- 번역된 .eps 는 파일 옆 `__epspy__\이름.py` 에 기록된다(`epsimp.py:126-136`). 공용 패키지 폴더에도 `__epspy__` 가 생기므로 `.gitignore` 에 넣어야 한다.
- 최신판 `_RELIMP` 는 상대 경로를 `sys.path` 기준의 절대 import 로 바꾼다. 그래서 **sys.path 밖으로 올라가는 상대 import 는 ImportError** 가 난다(`upstream\eudplib\src\eudplib\epscript\helper.py:37-72`, 0.10.0.0 변경). 공용 패키지는 절대 import(`import eudext.x`)만 쓰는 것이 두 판 모두에서 안전하다.

### 2.2 이름 번역 규칙 (중요)

| epScript | 번역 |
|---|---|
| `i64.foo(a)` | `i64.f_foo(a)` ← **모듈 함수 호출에는 `f_` 가 붙는다** |
| `i64.f_foo(a)` | `i64.f_f_foo(a)` (이중 접두사) |
| `i64.Foo(a)`, `i64.EUDFoo(a)` | 그대로 (대문자로 시작하면 안 붙음) |
| `i64.foo_bar(a)` | `i64.f_foo_bar(a)` |
| `i64.sub.foo(a)`, `i64.obj.method(a)`, `i64.Int64.from_var(a)` | 그대로 (두 단계 이상이면 안 붙음) |
| `i64.CONST`, `i64.foo`(호출 아님) | 그대로 |
| `const add = i64.add; add(a, a);` | `add(a, a)` (별칭 호출은 그대로) |
| 전역 함수 `foo(a)` (정의 없음) | "Undefined function f_foo". **eudplib 전역 이름이나 같은 파일에서 정의한 함수만** 부를 수 있다(`eudplib/__init__.py:188-192` 가 전역 목록을 등록) |
| `setcurpl(a)`, `dwread_epd(a)`, `printAll(…)` | `f_setcurpl`, `f_dwread_epd`, `f_printAll` |
| `function g(x)` 정의 | `def f_g(x)` (단 `onPluginStart`, `beforeTriggerExec`, `afterTriggerExec` 는 그대로) |
| `py_list()`, `py_str("a")`, `py_range(3)`, `py_eval`, `py_exec`, `py_getattr`, `py_print` | 파이썬 내장 `list()` … (`py_` 를 떼고 부른다) |

⇒ **공용 라이브러리 규약**:
- epScript 에서 부를 **모듈 함수는 `f_이름` 으로 정의**한다. 파이썬 쪽 편의를 위해 `이름 = f_이름` 별칭을 둘 수 있다.
- 클래스와 상수는 대문자로 시작한다.
- 메서드 이름은 자유롭다.

### 2.3 선언과 대입

| epScript | 번역 | 의미 |
|---|---|---|
| `const K = 5;` (전역) | `K = _CGFW(lambda: [5], 1)[0]` | 식을 따로 둔 트리거 영역에서 평가하고 EUDOnStart 에 붙인다(`helper.py:106-130`). 파이썬 객체도 된다(`const I = i64.Int64(1, 2);`) |
| `var gv;` / `var gv = 5;` (전역) | `EUDVariable()` / `_IGVA(1, lambda: [5])` | `_IGVA` 는 `EUDVariable(식)` 을 시도하고, 안 되면 시작 시 대입한다(92-103행) |
| `static var sv = 3;` (**전역**) | 문법 오류 | 0.76.14 에서 전역 static 은 없다(전역 var 가 이미 정적) |
| `static var s = 0;` (함수 안) | `s = EUDVariable(0)` | 초기값만, 부를 때마다 다시 대입하지 않는다 |
| `var q = expr;` (함수 안) | `q = _LVAR([expr])` | 임시 변수면 재사용하고, 아니면 새 변수에 복사한다(`helper.py:480-499`). **파이썬 객체도 32비트 변수 하나로 바뀐다** |
| `const q = expr;` (함수 안) | `q = expr` | 이름만 묶는다. 이후 `q = …`, `q += …` 는 **"Not a variable" / "Undefined variable" 컴파일 오류** |
| `q = b; q += 1; q -= b; q *= 2; q /= 2; q %= 3; q \|= 1; q &= 1; q ^= 1; q >>= 1; q <<= 2; i++` | `q << (b)`, `q.__iadd__(1)`, `__isub__`, `__imul__`, `__ifloordiv__`, `__imod__`, `__ior__`, `__iand__`, `__ixor__`, `__irshift__`, `__ilshift__`, `__iadd__(1)` | **반환값을 버린다**: 제자리 연산은 반드시 self 를 직접 고쳐야 한다 |
| `x.a = v; x.a += v;` | `_ATTW(x,'a') << (v)`, `_ATTW(x,'a').__iadd__(v)` | `_ATTW` 는 모듈이 아니면 `setattr`, 제자리 연산이면 `obj.iaddattr(name, v)` 를 먼저 시도하고 없으면 get→연산→set (`helper.py:155-266`). **const 객체를 고치는 통로** |
| `x[i] = v; x[i] += v; x[i] < 3` | `_ARRW(x,i) << v`, `.__iadd__` → `obj.iadditem`, `_ARRC(x,i) >= 3` → `obj.geitem` | `helper.py:269-467` |
| `x.a == 5` | `_ATTC(x,'a') == 5` → `obj.eqattr` 를 먼저 시도 | `helper.py:386-425` |
| `var a, b = f(x); a, b = f(x); const q, r = f(x);` | `_LVAR([...])`, `_SV([...],[...])`, `List2Assignable([...])` | 여러 값 반환을 받는다 |
| `const s = "abc";`, `const t = 'x';` | **문법 오류** | 0.76.14 는 문자열을 **함수 인자로만** 받는다(`f_sprintf(a, "x {}", a)` 는 됨). 값이 필요하면 `py_str("abc")`. 최신판은 식으로 허용한다(euddraft 0.9.11.0) |
| `1.5`, `a ** 2`, `&a`, `do {} while`, `class X {}`, `@decorator`, `function f(a, b = 3)`, `function f(*args)`, `inline function`, `var x: T = …` | 모두 오류 | (최신판은 `var x: T = …` 만 됨) |
| `0x100000000` | 그대로 파이썬 int | 64비트 상수를 적을 수 있다 |

### 2.4 연산자와 조건 번역 (값 타입 설계에 직접 영향)

| epScript | 번역 |
|---|---|
| `a < b` | **`a >= b, neg=True`** (조건 자리), `EUDNot(a >= b)` (값 자리), `EUDTernary(a >= b, neg=True)` (삼항) |
| `a > b` | **`a <= b, neg=True`** |
| `a != b` | **`a == b, neg=True`** |
| `!(a < b)` | `(a >= b)` |
| `!a`, `!m.cond(x)` | `EUDIf()(a, neg=True)`, 값 자리면 `EUDNot(…)` |
| `a && b \|\| c` | `EUDSCOr()(EUDSCAnd()(a)(b)())(c)()` |
| `a << b` (식) | `_LSH(a, b)`: 변수면 `f_bitlshift`, 아니면 **파이썬 `a << b`** (`helper.py:502-506`) |
| `a / b` | `a // b` |
| `if (list(c1, c2))` | `FlattenList([c1, c2])` |
| `return a < b;` | `EUDReturn(EUDNot(a >= b))` (1.6: 변수 비교면 오류) |

⇒ 값 타입이 epScript 에서 제대로 동작하려면 다음을 지킨다:
1. epScript 는 `__lt__`, `__gt__`, `__ne__` 를 **부르지 않는다**. 대신 **`__ge__`, `__le__`, `__eq__`** 결과를 neg 분기로 쓴다. 이 세 연산자의 결과는 EUDJumpIf 에 들어갈 수 있어야 하고, 값 자리를 위해 `EUDNot` 이 처리할 수 있어야 한다(LightBool/변수/Condition이면 된다).
2. `__lshift__` 는 **파이썬에서는 대입**(eudplib 관례)이지만 epScript 식 `x << 3` 에서는 **시프트로 기대된다**(`_LSH`). 값 타입의 `__lshift__` 를 대입으로 두면 epScript 사용자가 `const y = x << 3;` 이라고 쓸 때 **x 에 3 이 대입된다.** 시프트는 `x.shl(3)` 메서드로만 제공하고 안내문에 적는다.
3. const 로 묶인 객체의 변경 통로(시제품에서 실측): `x.v = y`(property setter), `x.v += y`/`x.v -= y`(`iaddattr`/`isubattr`), 메서드 `x.assign(y)`/`x.iadd(y)`. `A.v += B; A.v -= 1; A.v = C;` 가 euddraft 빌드에서 번역·컴파일됐다(3절).
4. `var x = Int64(…)` 는 쓰지 못하게 한다(1.6 오류문 안내). 함수 인자로 받을 때는 `function f(lo, hi) { const a = i64.wrap(lo, hi); … return a.lo, a.hi; }`, 호출은 `const lo, hi = f(x.lo, x.hi); const r = i64.wrap(lo, hi);`.
5. 조건 반환 함수는 `m.cond(x)` 가 `m.f_cond(x)` 로 번역되어 `EUDIf()`·`EUDSCAnd()` 뒤에서 불린다(실측 번역문). 부작용이 있어도 안전하다(1.3).

### 2.5 object 와 EUDStruct

| epScript | 번역 |
|---|---|
| `object P { var x, y; function m() {…} };` | `class P(EUDStruct): _fields_ = ['x','y']` + `@EUDMethod def m(this)` |
| `var a: P;` (필드 타입) | `('a', P)` |
| `var next: selftype;` | `('next', selftype)` |
| `object B extends A {…}` | `class B(A)` |
| `function f(p: P)` | `@EUDTypedFunc([P])` |
| `function f(a) : TrgUnit, TrgPlayer` | `@EUDTypedFunc([None], [TrgUnit, TrgPlayer])` |
| `function f(a: i64.Int64)` / 별칭 `const Int64 = i64.Int64; function f(a: Int64)` | `@EUDTypedFunc([i64.Int64])` / `@EUDTypedFunc([Int64])` (번역은 됨. 실행 시 `cast` 가 부름) |
| `P()`, `P.cast(v)`, `P.alloc()`/`P.free(p)`, `P.array(n)`, `P * n`, `constructor(v)` | 파이썬 그대로 |
| `object P { const x; }` | 오류 (필드는 var 만) |

- **object = 파이썬 EUDStruct 하위 클래스**이므로 파이썬 라이브러리가 만든 EUDStruct 도 epScript 에서 같은 문법으로 쓴다.
- 반대로 epScript object 를 파이썬에서 `from … import P` 로 가져와 쓸 수도 있다(패키지 안 .eps 불러오기 실측).
- `function f(a: py_int)` 처럼 `py_` 타입 이름은 쓸 수 없다.

---

## 3. 배포 · 불러오기

### 3.1 euddraft 의 경로 규칙

근거: 번들 `lib\library.zip` 의 `pluginLoader.pyc`, `euddraft.pyc` 를 디스어셈블한 결과(`eps_exp\bundle_report.txt`)와 같은 구조인 최신 소스(`upstream\euddraft\pluginLoader.py`, `euddraft.py`), 그리고 실측.

1. `euddraft.exe x.eds` 는 **eds 폴더로 chdir** 하고 그 폴더를 `sys.path[0]` 에 넣는다(`euddraft.py:129-133`). `lib`, `library.zip` 은 그 뒤에 온다(`applylib` 42-52행). 실측 `sys.path[:4] = [eds폴더, …\lib\library.zip, …\lib, …\lib]`.
2. 플러그인 경로(`pluginLoader.py:54-63`): 이름이 `.py`/`.eps` 로 끝나면 `abspath`(= **eds 기준 상대 경로**)이고, 아니면 `euddraft폴더\plugins\이름.eps`, 없으면 `.py` 다.
3. 플러그인을 읽을 때마다(`pluginLoader.py:186-230`):
   - 플러그인 폴더를 `sys.path` 1번 자리에 넣는다(196-197행).
   - `types.ModuleType(이름)` 을 만들고 `settings` 를 넣는다(200-201행). **`__file__` 은 없다**(실측 `'__file__' in globals(): False`). 그래서 DPS 는 eds 에 `EudDir` 를 따로 적는다(`DPS_eud\eud\dps_eud.py:15-22`).
   - `sys.modules[이름]` 에 등록하고 `exec_module` 을 부른다(210-212행).
   - **`finally` 에서 `os.chdir(처음 폴더)`, `sys.path[:] = 처음 목록`** 으로 되돌린다(226-229행). 번들 판에서도 `loadPluginsFromConfig` 의 ExceptionTable 과 `initialPath` 저장으로 같은 구조를 확인했다.
4. 실측(`edtest\run1.log`, 순서 `[boot.py] → [late.py] → [main.eps]`):
   - boot.py 가 불러오는 동안 `sys.path.insert(0, shared)` 를 하고 `import eudext`, `from eudext import i64` 를 했다: **성공**.
   - late.py 시점에는 `SHARED in sys.path: False`(되돌려짐), `'eudext' in sys.modules: True`.
     - 처음 부르는 `import eudext.lazy2`: **성공**(패키지 `__path__` 로 찾음).
     - `shared` 바로 밑의 비패키지 모듈 `import rootmod2`: **실패**.
   - `onPluginStart` 시점(빌드 중) `import eudext.lazymod`: 성공. `import rootmod`: 실패. eds 폴더의 `import localpy`: 성공.
   - main.eps 에서 `import eudext.i64`, `import eudext.epsmod`(패키지 안 .eps), `import .helper`, `import ..shared.eudext.relmod`, `import localpy` 가 **모두 성공**했다. Int64 사용 코드가 컴파일되어 `out.scx`(56KB)가 나왔다(rc=0).

### 3.2 여러 맵이 `MapSource\Py\eudext` 를 쓰는 방법 (권장)

```ini
; 맵.eds  — 부트 플러그인을 모든 eudext 사용 플러그인보다 앞에 둔다
[main]
input: ...
output: ...

[..\..\MapSource\Py\eudext_boot.py]      ; 또는 eds 폴더에 둔 작은 boot.py
EudextRoot : C:\Users\whatd\Desktop\Stormcoast Fortress\ScmDraft 2\MapSource\Py
VenvSite   : C:\Users\whatd\.venvs\eud076\Lib\site-packages   ; lupa 가 필요할 때만

[MSQC]
...
[main.eps]            ; 여기서 import eudext.i64 as i64;
```

```python
# eudext_boot.py (부트 플러그인) — 불러오는 동안에만 sys.path 가 유효하므로 여기서 import 까지 끝낸다
import sys
from eudplib import *  # noqa
_s = {k.strip().lower(): v.strip() for k, v in settings.items()}   # euddraft 가 넣어 준다
root = _s["eudextroot"]
if root not in sys.path:
    sys.path.insert(0, root)
venv = _s.get("venvsite")
if venv and venv not in sys.path:
    sys.path.append(venv)          # 뒤에 붙인다: 번들 eudplib 이 먼저 잡혀야 한다 (DPS 와 같은 방식)
import eudext                      # 이후 eudext.* 는 어디서든 지연 import 가능
import eudext.i64, eudext.fmt     # 무거운 외부 의존(lupa 등)은 여기서 미리 import 해 둔다
```

규칙:
- `eudext` 는 **반드시 패키지**(`__init__.py`)로 둔다. 하위 모듈과 하위 .eps 는 `__path__` 로 찾으므로 sys.path 가 되돌려져도 불러올 수 있다.
- `MapSource\Py` 바로 밑의 **비패키지 모듈**은 부트 이후에 불러올 수 없다. 공용 코드는 모두 `eudext` 안에 둔다.
- 외부 site-packages(lupa)에 있는 모듈도 **부트 중에 import** 해 둬야 한다. 부트 뒤에는 venv 경로가 sys.path 에서 빠진다.
  - DPS 가 동작하는 이유: `dps_eud.py:27` 이 불러오는 동안 `driver` → `ctrig.lua`/`luart` 를 import 하고, 이들이 `lupa` 를 import 한다(`ctrig\lua.py:5`, `luart.py:13`).
- 부트 플러그인 없이 쓰는 다른 방법들:
  - (가) eudext 를 쓰는 **각** .py 플러그인이 맨 위에서 sys.path 를 넣고 import 한다.
  - (나) eds 폴더에 `eudext` 로 향하는 디렉터리 정션(junction)을 둔다. 추측이며 시험하지 않았다. eds 폴더는 항상 sys.path[0] 이라 부트가 필요 없어진다. 대신 맵 폴더마다 정션을 관리해야 한다.
  - (다) `euddraft폴더\lib` 에 복사한다. 판마다 따라 옮겨야 하므로 비추천.
- 파이썬 단독 빌드(`LoadMap`/`SaveMap`, DPS `build_eud.py --check` 방식)에서는 venv 에서 `sys.path.insert(0, MapSource\Py)` 만 하면 된다.
- eudext 안의 모듈은 번들 파이썬 3.11.6 에서 돌아야 한다. 번들 eudplib 은 pyc 만 있고 0.76.14 이다. 개발 venv(3.11 + eudplib 0.76.14)와 판을 맞춘다.
- 공용 패키지 폴더에 `__epspy__\`, `__pycache__\` 가 생긴다. git 에서 제외한다.

### 3.3 번들 파이썬에 없는 표준 라이브러리

`sys.stdlib_module_names` 와 번들 목록(`library.zip` + `lib\*.pyd` + 내장 모듈)을 대조했다(`eps_exp\bundle_report.txt`).

- 번들에 없는 모듈: aifc, antigravity, asynchat, asyncore, cProfile, cgi, cgitb, chunk, **colorsys**, compileall, **configparser**, crypt, curses, dbm, distutils, ensurepip, fcntl, filecmp, fileinput, **graphlib**, grp, idlelib, imaplib, imghdr, imp, lib2to3, mailbox, mailcap, modulefinder, msilib, nis, nntplib, **optparse**, ossaudiodev, pickletools, pipes, poplib, posix, **profile/pstats**, pty, pwd, pyclbr, readline, resource, rlcompleter, **sched**, **shelve**, site, smtpd, smtplib, sndhdr, spwd, **sqlite3**, sre_*, sunau, symtable, syslog, tabnanny, telnetlib, termios, this, **timeit**, **tkinter**, **tomllib**, trace, turtle, turtledemo, uu, **uuid**, venv, wave, wsgiref, xdrlib, zipapp, **zoneinfo**.
- 실측(euddraft 안에서 import):
  - 없음: colorsys, configparser, tomllib, sqlite3, timeit, graphlib, uuid, lupa(venv 경로 없이).
  - 있음: fractions, dataclasses, functools, itertools, math, struct, json, csv.
- 따라서 eudext 는 위 모듈에 의존하지 않는다. 필요하면 부트에서 venv 의 표준 라이브러리 경로(`…\Python311\Lib`)를 append 해서 불러올 수는 있을 것이다(추측: 순수 파이썬 모듈만, 시험 안 함).
- 번들에 따로 들어 있는 것: `openpyxl`, `colorama`, `typing_extensions`, `Cython` 일부.

---

## 4. 최신 eudplib 대비표

출처:
- (E) `upstream\euddraft\CHANGELOG.md`(euddraft 변경 기록에 eudplib 변경도 함께 적혀 있다)
- (S) `upstream\eudplib\src\eudplib` 0.81.0 소스 검색
- (P) PyPI JSON: 최신 0.81.0(2026-09-07), requires-python `>=3.10,<3.15`
- (G) GitHub API: eudplib 릴리스 v0.81.0(2026-09-08), euddraft 릴리스 v0.11.0.1(2026-09-09, windows/linux/macos zip)

### 4.1 기능 대비

| 기능 | 0.76.14 | 최신(eudplib 0.81.0 / euddraft 0.11.0.1) | 출처 |
|---|---|---|---|
| 64비트 정수 | 없음 | **없음**. `int64/i64/64bit` 검색 결과는 `Is64BitWireframe`(SC 32/64비트 판별)뿐 | S: `eudlib/wireframe/wireframe.py:282` |
| 키·마우스 입력 | 본체에 없음. euddraft **MSQC/NSQC 플러그인**에 `KeyDown/KeyUp/KeyPress/MouseDown/…` 있음 (로컬 `plugins\MSQC.py:15-120`) | 본체에 **없음**. MSQC 플러그인은 계속 제공되고 고쳐짐(0.10.0.1 마우스 버튼 오류 수정, 0.9.11.2 로컬 조건에 등록 객체 허용) | S(검색 0건), `upstream\euddraft\plugins\MSQC.py:134-250`, E 196·366행 |
| 부호 있는 비교 | 없음 (나눗셈 3종만 부호 있음) | **없음**. EUDVariable 비교는 여전히 부호 없음 | S: `core/variable/eudv.py:589-620` |
| 변수끼리 `<`, `>` | **버그**(b=0 / b=0xFFFFFFFF, 1.6 실험) | 고침(포화 뺄셈 자기참조 조건, 트리거 1개) | E 302행(0.10.0.0), S `eudv.py:589-620` |
| sprintf 서식 | `{:s} {:t} {:x} {:c} {:n}`, 나머지는 파이썬 `format`(상수만) | **같음**(`eudformat_field` 동일). `StringBuffer` 를 서식 인자로 허용(0.10.1.5), 인자 수 오류문 개선, 상수 문자열 난독화 | S `string/fmtprint.py:92-116`, E 101·116·299행 |
| `.fmt()` 인쇄 훅 | 있음 (`eudprint.py:269-270`, `cpprint.py:224`) | 있음 (`string/eudprint.py:232`, `cpprint.py:221`) | S |
| 총알·스프라이트 생성 | 없음 | **없음**. `CSprite`/`CUnit` 멤버 읽기·쓰기, `EUDLoopSprite/Bullet` 는 있음 | S(검색 0건), E 57·88행 |
| 새 루프 | `EUDLoopRange/N/List/Unit/Unit2/NewUnit/PlayerUnit/Bullet/Sprite/Trigger`, `EUDLoopCUnit/NewCUnit/PlayerCUnit`, `EUDLoopPlayer`, `EUDPlayerLoop` (로컬 검색) | 같은 이름들. **EUDVArray 를 epScript foreach 로 순회**(0.10.0.0, 0.10.2.5 에서 고침), `EUDLoopNewCUnit` 누락 버그 수정 | S, E 43·257·75행 |
| epScript 타입 변수 | 없음 (`var x: T` 오류, 실험) | `var x: T = v;`, `static var x: T = v;`. **값 하나를 `T.cast` 로 감싸는 방식**(`_TYLV`)이라 64비트 값 타입은 여전히 못 넣음 | E 217-241, S `epscript/helper.py:109-142`, `epparser.lemon:1115,1152` |
| epScript 문자열 식 | 함수 인자로만 (실험) | 식으로 허용 | E 553 (0.9.11.0) |
| epScript object 전방 선언, `extends 식` | 없음(추측) | 있음 | E 573-590 |
| epScript `from … import`, 기본 인자, 데코레이터, float, `**` | 없음 (실험) | **없음** (문법 파일에 없음) | S `epparser.lemon` 규칙 목록 |
| epScript 상대 import | 파일을 직접 실행(모듈 중복 생길 수 있음) | sys.path 기준 절대 import 로 바꿈(밖으로 나가면 ImportError) | E 242-245, S `helper.py:37-72` |
| EUDStruct `@property`, 캐스트 | property 불가(추측), cast 는 복사 | `@property` 허용(0.10.2.5), cast 는 복사하지 않음(0.10.0.0) | E 46·247 |
| `EUDArray` | ptr 기반 | **EPD 기반이 기본**(`ptrEUDArray` 플래그로 옛 동작) | E 206-216 |
| `EUDVariable(epd, modifier, initval)` | 됨 | **제거**, `EUDXVariable` 사용 | E 248-249 |
| scdata (`TrgUnit.armor += 1`, `P1.ore`, `Upgrade[P]` …) | 없음 (offsetmap 의 CUnit/CSprite 만) | 있음 | E 557-571, 266-293 |
| MPQ API | 옛 `MPQAddFile(name, bytes)` | Rust 로 다시 짬. `MPQAddFile(name, 경로 또는 bytes)` | E 146-170 |
| 컴파일 속도·트리거 수 | — | 읽기 함수가 트리거를 공유, `EUDJump` 트리거 1개, `f_getcurpl` 최적화 등 | E 192·603·608 |
| 파이썬 | 3.11 (번들 3.11.6) | euddraft 0.10.2.1=3.12.8, 0.10.2.5=3.13.5, **0.11.0.0=3.14t(free-threaded)** | E 15·50·80 |

### 4.2 euddraft ↔ eudplib 판 대응

| euddraft | 날짜 | eudplib | 근거 |
|---|---|---|---|
| 0.9.10.11 (현재 설치) | 2023-12-29 | 0.76.14 | E 634, 번들 dist-info |
| 0.9.10.12 | 2024-01-25 | 0.76.15 | E 622 |
| 0.9.11.0~0.9.11.2 | 2024-09-01~07 | 0.77.x (0.9.11.2 = 0.77.9) | E 375 |
| 0.10.0.0~0.10.0.2 | 2024-09-22~26 | 0.78.2~0.78.4 (추측: PyPI 날짜 일치) | P |
| 0.10.1.0~0.10.1.6 | 2024-09-30~12-28 | 0.79.0~0.79.7 (추측: 날짜 일치) | P |
| 0.10.2.1 | 2025-02-03 | 0.80.0 | E 80 |
| 0.10.2.2 / .3 / .5 | 2025-03-18 / 04-26 / 08-04 | 0.80.2 / 0.80.3 / 0.80.6 (추측: 날짜 일치) | P |
| 0.11.0.0 / 0.11.0.1 (최신) | 2026-09-07 / 09 | 0.81.0 | E 23, `upstream\euddraft\pyproject.toml:17` (`eudplib>=0.81.0,<0.82`) |

### 4.3 "직접 만들지 / 올릴지" 판단 재료

- 목표 기능(64비트, 서식 확장, 총알·스프라이트 생성, 키 입력 본체 지원, 부호 있는 비교, 임의 주기 삼각함수, CX Paint)은 **최신판에도 없다**. 어느 쪽을 택해도 eudext 는 직접 만들어야 한다.
- 올리면 얻는 것:
  - 변수끼리 `<`·`>` 버그 수정. 0.76.14 에 남는다면 eudext 가 대체 비교 함수를 제공하거나 `a <= b` 계열만 쓰도록 안내해야 한다.
  - epScript 타입 변수와 문자열 식.
  - scdata, 속도 개선.
- 올리면 치르는 것:
  - 파이썬 판이 바뀐다(3.13 또는 3.14t). lupa 는 2.8 에 cp313, cp314t 휠이 있다(PyPI 확인). 다만 venv 를 새로 만들어야 한다.
  - `EUDArray` EPD 기본값, `EUDVariable` 3인자 생성자 제거, cast 의미 변경, 상대 import 동작 변경.
  - 실행 전 가볍게 검색해 보니 DPS 이식 계층(`DPS_eud\eud`)에는 `EUDArray` 사용과 `EUDVariable(a, b, c)` 호출이 없었다(추측: 영향 작음. `ctrig\arrays.py`, `core.py` 의 EUDVArray/EUDStruct 캐스트는 따로 봐야 함).
  - 그 밖에 CPLP, STRCtrig 등 기존 플러그인의 호환성은 확인하지 않았다.
- eudext 를 **0.76.14 기준으로 짜되** 최신판에서 바뀐 API(EUDArray EPD, EUDVariable 생성자, 비교 버그)를 피하면 양쪽에서 돈다. 실제로 시제품 i64 는 `EUDVariable(상수)`, `SeqCompute`, `RawTrigger`, `EUDFunc` 만 쓴다.

---

## 5. eudext 규약 요약 (설계도에 옮길 목록)

1. 값 타입 = 파이썬 클래스 + 내부 EUDVariable. `__slots__`, `dont_flatten = True`, `__hash__ = id` 를 둔다. `__bool__`/`__format__`/`__iter__`/`cast` 는 안내 오류를 내고 `__repr__` 에 epScript 안내문을 넣는다.
2. 생성: `T(상수)` = 초기값만(트리거 없음, EUDVariable 과 같음). `T(변수)`/`T(a, b)` = 실행 시 대입. `T.wrap(…)` = 복사 없이 감싸기.
3. 연산 분기: 모두 상수면 파이썬에서 계산한다. 한쪽이 상수면 짧을 때 인라인, 길 때 `functools.cache` 특수화 EUDFunc. 모두 변수면 지연 생성 공유 EUDFunc 이고 결과는 `ret=[…]` 로 받는다.
4. 이항 연산은 새 임시 객체를 만든다(호출 자리마다 새 변수). 제자리 연산은 self 를 고치고 self 를 돌려준다(epScript 는 반환값을 버림). `<<` 는 대입이다. 시프트는 메서드로만 제공한다.
5. 비교는 새 Condition(목록)/EUDLightBool/0-1 변수를 돌려주고, 필요한 앞 계산 트리거는 부를 때 낸다. `__ge__/__le__/__eq__` 를 먼저 완성한다(epScript 가 이것만 부름). Condition 은 캐시하지 않는다.
6. 뺄셈과 비교에서 wrap 이 필요하면 `Add(-k)` 를 쓰고 `Subtract` 는 쓰지 않는다. 포화가 필요한 비교에서만 `SeqCompute((d, Subtract, v))` 를 쓴다.
7. CP 를 잠깐 바꾸면 끝에서 `f_setcurpl2cpcache()` 를 부른다. 계속 바꿀 거면 `f_setcurpl`/`SetCurrentPlayer` 를 쓴다. raw `SetMemory(0x6509B0, SetTo)` 는 쓰지 않는다.
8. epScript 공개 함수는 `f_이름`, 클래스는 대문자로 짓는다. const 객체 변경 통로로 `x.v = …`(property)와 `iaddattr/isubattr` 를 둔다. 조건 반환 함수를 epScript `return` 에 쓰지 말라고 안내한다(`? 1 : 0`).
9. 인쇄는 `fmt()` 를 구현해 printf 계열과 f_sprintf `"{}", x.fmt()` 에 대응한다.
10. 패키지 배치는 `MapSource\Py\eudext\`(패키지)로 한다. 부트 플러그인이 import 까지 끝낸다. 절대 import 만 쓰고, 번들에 없는 표준 모듈은 쓰지 않는다. `__epspy__`, `__pycache__` 는 무시 목록에 넣는다.
11. 측정: 함수마다 `f.size()`, 호출 자리 비용은 `GetTriggerCounter()` 차이로 잰다. 정확성은 에뮬레이터(`emu.py`)에 무작위와 경계값을 넣어 검사한다.

---

## 6. 실험 파일 (모두 스크래치패드 안)

| 파일 | 내용 |
|---|---|
| `eps_exp\probe.py`, `probe2.py`, `probe_out.txt`, `probe2_out.txt` | epScript 조각 약 140개 번역 결과 |
| `eps_exp\compile_eps.py`, `t1_basic.eps` | 단일 파일 번역 도구 |
| `eps_exp\inspect_bundle.py`, `bundle_report.txt` | euddraft 번들 pyc 디스어셈블, 빠진 표준 라이브러리 |
| `edtest\shared\eudext\i64.py` (+ `__init__.py`, `epsmod.eps`, `relmod.py`, `lazymod.py`, `lazy2.py`), `edtest\shared\rootmod*.py` | Int64 시제품과 불러오기 시험용 공용 패키지 |
| `edtest\map\t_load.eds`, `boot.py`, `late.py`, `main.eps`, `helper.eps`, `localpy.py`, `base.scx`(CBTest.scx 사본), `out.scx`, `__epspy__\` | 실제 euddraft 0.9.10.11 빌드 시험 |
| `edtest\run1.log` | 그 실행 로그 |
| `proto\emu.py` | DPS_eud 에뮬레이터 사본 |
| `proto\t_i64_emu.py` | Int64 정확성 400개 경우와 트리거 수 측정 |
| `proto\t_pitfalls.py` | 0.76.14 함정 실험 |
| `proto\t_loopcond.py` | 부작용 조건의 루프·단락 평가 |
| `upstream\eudplib` (0.81.0), `upstream\euddraft` (0.11.0.1) | 최신 소스 얕은 복제 |
| `tmp\` | 에뮬레이터·실험 맵 출력 |
