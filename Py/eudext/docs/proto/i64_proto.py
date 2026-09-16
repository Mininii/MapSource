"""eudext.i64 -- 64비트 정수 값 타입 시제품 (eudplib 0.76.14 기준, 설계 재료용).

규약 시연:
  * 값 타입 = 파이썬 클래스 + EUDVariable 두 개(lo, hi). EUDStruct(참조형) 아님.
  * 상수 접기: 둘 다 파이썬 int 면 파이썬에서 계산.
  * 한쪽이 상수: 짧으면 호출 자리에 인라인(트리거 2~3개), 길면 상수별 functools.cache EUDFunc.
  * 둘 다 변수: 지연 생성 EUDFunc 하나를 공유(인자 4개, 반환 2개).
  * 제자리 연산(+=, <<)은 self.lo/self.hi 를 직접 고친다 (ret=[...] 관용).
  * 비교는 "조건으로 쓸 수 있는 값"을 돌려준다: 상수 비교 = 조건 목록 또는 EUDLightBool,
    변수 비교 = EUDFunc 반환 변수(0/1).
  * epScript 호환: 모듈 함수는 f_ 접두사 (eps 의 i64.add(...) 가 i64.f_add(...) 로 번역됨).
"""
import functools

from eudplib import core as c
from eudplib import utils as ut
from eudplib.core.variable.eudv import SeqCompute

MASK32 = 0xFFFFFFFF
MASK64 = (1 << 64) - 1
SIGN32 = 0x80000000


def _split(n):
    n &= MASK64
    return n & MASK32, n >> 32


def _sat_sub(dst, a, b):
    """dst = max(a - b, 0) (부호 없는 포화 뺄셈). SetDeaths Subtract 는 0 에서 멈춘다."""
    SeqCompute([(dst, c.SetTo, a), (dst, c.Subtract, b)])


# ---------------------------------------------------------------- 변수-변수 함수 (지연 생성, 1벌 공유)
@c.EUDFunc
def _add64(alo, ahi, blo, bhi):
    carry = c.EUDVariable()
    alo += blo                      # wrap
    _sat_sub(carry, blo, alo)       # carry>0  <=>  새 alo < blo
    ahi += bhi
    c.RawTrigger(conditions=carry.AtLeast(1), actions=ahi.AddNumber(1))
    return alo, ahi


@c.EUDFunc
def _sub64(alo, ahi, blo, bhi):
    borrow = c.EUDVariable()
    _sat_sub(borrow, blo, alo)      # borrow>0 <=> alo < blo (빼기 전)
    alo -= blo                      # EUDVariable.__isub__ 는 wrap (Subtract 액션 안 씀)
    ahi -= bhi
    c.RawTrigger(conditions=borrow.AtLeast(1), actions=ahi.AddNumber(MASK32))  # -1
    return alo, ahi


@c.EUDFunc
def _geu64(alo, ahi, blo, bhi):
    """a >= b (부호 없음) -> 1/0"""
    r, d1, d2, d3 = c.EUDVariable(), c.EUDVariable(), c.EUDVariable(), c.EUDVariable()
    _sat_sub(d1, ahi, bhi)          # d1>0 <=> ahi > bhi
    _sat_sub(d2, bhi, ahi)          # d2>0 <=> ahi < bhi
    _sat_sub(d3, blo, alo)          # d3>0 <=> alo < blo
    r << 0
    c.RawTrigger(conditions=d1.AtLeast(1), actions=r.SetNumber(1))
    c.RawTrigger(conditions=[d1.Exactly(0), d2.Exactly(0), d3.Exactly(0)],
                 actions=r.SetNumber(1))
    return r


@c.EUDFunc
def _ges64(alo, ahi, blo, bhi):
    """a >= b (부호 있음): 부호 비트를 뒤집고 부호 없는 비교. 인자는 호출된 함수의 사본이라 고쳐도 된다."""
    c.RawTrigger(actions=[ahi.AddNumber(SIGN32), bhi.AddNumber(SIGN32)])
    return _geu64(alo, ahi, blo, bhi)


# ---------------------------------------------------------------- 상수 특수화 (상수별 캐시)
@functools.cache
def _geu_const_func(k):
    """상수 비교를 함수로 만들 때의 모양 (시연용; 실제로는 인라인이 더 싸다)."""
    klo, khi = _split(k)

    @c.EUDFunc
    def f(alo, ahi):
        r = c.EUDVariable()
        r << 0
        if khi < MASK32:
            c.RawTrigger(conditions=ahi.AtLeast(khi + 1), actions=r.SetNumber(1))
        c.RawTrigger(conditions=[ahi.Exactly(khi), alo.AtLeast(klo)], actions=r.SetNumber(1))
        return r

    return f


class Int64:
    """64비트 정수 값 타입. 기본 해석은 부호 없음, 부호 있는 비교는 slt/sge 등 따로."""

    __slots__ = ("lo", "hi")
    dont_flatten = True  # FlattenList(인쇄 함수 인자 등)에서 쪼개지 않는다

    # -------------------------------------------------- 생성
    def __init__(self, value=0, hi=None):
        if hi is None and isinstance(value, int):
            lo_i, hi_i = _split(value)
            # EUDVariable(상수) 와 같은 규약: 초기값만, 트리거 없음
            self.lo, self.hi = c.EUDVariable(lo_i), c.EUDVariable(hi_i)
            return
        self.lo, self.hi = c.EUDVariable(), c.EUDVariable()
        if hi is None:
            self << value            # Int64/EUDVariable 복사 (트리거)
        else:
            SeqCompute([(self.lo, c.SetTo, value), (self.hi, c.SetTo, hi)])

    @classmethod
    def wrap(cls, lo, hi):
        """기존 변수 두 개를 복사 없이 감싼다 (EUDFunc 인자/반환값 받기용)."""
        obj = cls.__new__(cls)
        obj.lo, obj.hi = lo, hi
        return obj

    @classmethod
    def cast(cls, _from):
        """EUDTypedFunc 호환용 자리. 변수 하나로는 64비트를 받을 수 없어 오류."""
        raise ut.EPError("Int64 는 변수 하나로 넘길 수 없습니다. (lo, hi) 두 인자로 넘기세요.")

    # -------------------------------------------------- 공통
    @staticmethod
    def _parts(o):
        """-> (lo, hi) : 상수는 int, 변수는 EUDVariable. EUDVariable 은 0 확장."""
        if isinstance(o, Int64):
            return o.lo, o.hi
        o = ut.unProxy(o)
        if isinstance(o, int):
            return _split(o)
        if c.IsEUDVariable(o):
            return o, 0
        raise ut.EPError(f"Int64 와 연산할 수 없는 값: {o!r}")

    def __repr__(self):
        return ("<eudext.i64.Int64 - 값 타입(변수 2개). epScript 에서는 'var x = ...' 대신 "
                "'const x = i64.Int64(...)' 로 선언하고 x.v = ..., x.v += ... 로 고치세요>")

    def __hash__(self):
        return id(self)

    def __bool__(self):
        raise ut.EPError("Int64 를 파이썬 if 에 넣을 수 없습니다. EUDIf()(x != 0) 를 쓰세요.")

    def __iter__(self):
        raise ut.EPError(repr(self))

    def __format__(self, spec):
        raise ut.EPError("f_sprintf 의 {} 에는 x.fmt() 를 넘기세요 (Int64 자체는 형식화 불가).")

    # -------------------------------------------------- 대입
    def __lshift__(self, other):
        lo, hi = Int64._parts(other)
        SeqCompute([(self.lo, c.SetTo, lo), (self.hi, c.SetTo, hi)])
        return self

    assign = __lshift__

    # epScript: x.v = y / x.v += y  (const 로 묶인 객체를 고치는 통로)
    @property
    def v(self):
        return self

    @v.setter
    def v(self, value):
        self << value

    def iaddattr(self, name, value):
        if name != "v":
            raise AttributeError(name)
        self += value

    def isubattr(self, name, value):
        if name != "v":
            raise AttributeError(name)
        self -= value

    # -------------------------------------------------- 산술
    def _iadd(self, other):
        blo, bhi = Int64._parts(other)
        if isinstance(blo, int) and isinstance(bhi, int):
            k_lo, k_hi = blo, bhi
            acts = []
            if k_lo:
                # 올림: lo >= 2^32 - k_lo  (더하기 전 값으로 검사)
                c.RawTrigger(conditions=self.lo.AtLeast((1 << 32) - k_lo),
                             actions=self.hi.AddNumber(1))
                acts.append(self.lo.AddNumber(k_lo))
            if k_hi:
                acts.append(self.hi.AddNumber(k_hi))
            if acts:
                c.RawTrigger(actions=acts)
        else:
            _add64(self.lo, self.hi, blo, bhi, ret=[self.lo, self.hi])
        return self

    def __iadd__(self, other):
        return self._iadd(other)

    iadd = __iadd__

    def __isub__(self, other):
        blo, bhi = Int64._parts(other)
        if isinstance(blo, int) and isinstance(bhi, int):
            return self._iadd(-(blo | (bhi << 32)))
        _sub64(self.lo, self.hi, blo, bhi, ret=[self.lo, self.hi])
        return self

    isub = __isub__

    def __add__(self, other):
        t = Int64(self)            # 임시값 (호출 자리마다 새 변수 2개)
        t += other
        return t

    __radd__ = __add__

    def __sub__(self, other):
        t = Int64(self)
        t -= other
        return t

    def __rsub__(self, other):
        t = Int64(other)
        t -= self
        return t

    def __neg__(self):
        t = Int64(0)
        t.lo << 0
        t.hi << 0
        t -= self
        return t

    # -------------------------------------------------- 비교 (부호 없음)
    def _geu(self, other):
        blo, bhi = Int64._parts(other)
        if isinstance(blo, int) and isinstance(bhi, int):
            # 인라인: 부작용 트리거 2~3개 + EUDLightBool
            flag = c.EUDLightBool()
            c.RawTrigger(actions=flag.Clear())
            if bhi < MASK32:
                c.RawTrigger(conditions=self.hi.AtLeast(bhi + 1), actions=flag.Set())
            c.RawTrigger(conditions=[self.hi.Exactly(bhi), self.lo.AtLeast(blo)],
                         actions=flag.Set())
            return flag
        return _geu64(self.lo, self.hi, blo, bhi)  # EUDVariable 0/1

    def _leu(self, other):
        blo, bhi = Int64._parts(other)
        if isinstance(blo, int) and isinstance(bhi, int):
            flag = c.EUDLightBool()
            c.RawTrigger(actions=flag.Clear())
            if bhi > 0:
                c.RawTrigger(conditions=self.hi.AtMost(bhi - 1), actions=flag.Set())
            c.RawTrigger(conditions=[self.hi.Exactly(bhi), self.lo.AtMost(blo)],
                         actions=flag.Set())
            return flag
        return _geu64(blo, bhi, self.lo, self.hi)

    def __ge__(self, other):
        return self._geu(other)

    def __le__(self, other):
        return self._leu(other)

    def __lt__(self, other):          # epScript 는 이것을 부르지 않는다 ((a >= b, neg=True) 로 번역)
        return _negate(self._geu(other))

    def __gt__(self, other):          # epScript 는 (a <= b, neg=True)
        return _negate(self._leu(other))

    def __eq__(self, other):
        blo, bhi = Int64._parts(other)
        # 조건 목록(AND). 변수가 든 조건은 소비 시점에 tpatcher 가 채움 트리거를 만든다.
        return [self.lo == blo, self.hi == bhi]

    def __ne__(self, other):          # epScript 는 (a == b, neg=True)
        from eudplib import EUDNot
        return EUDNot(self == other)

    # 부호 있는 비교 (메서드)
    def sge(self, other):
        blo, bhi = Int64._parts(other)
        if isinstance(blo, int) and isinstance(bhi, int):
            t = Int64(self)
            c.RawTrigger(actions=t.hi.AddNumber(SIGN32))
            return t._geu((blo | (bhi << 32)) ^ (1 << 63))
        return _ges64(self.lo, self.hi, blo, bhi)

    def slt(self, other):
        return _negate(self.sge(other))

    # -------------------------------------------------- 인쇄 (f_dbstr_print/f_eprintln 등은 .fmt() 를 부른다)
    def fmt(self):
        from eudplib import DBString, f_sprintf
        buf = DBString(24)
        f_sprintf(buf, "0x{:x}{:x}", self.hi, self.lo)
        return buf


def _negate(cond):
    if isinstance(cond, c.EUDLightBool):
        return cond.IsCleared()
    if c.IsEUDVariable(cond):
        return cond.Exactly(0)
    from eudplib import EUDNot
    return EUDNot(cond)


# ---------------------------------------------------------------- epScript 용 모듈 함수 (f_ 접두사)
def f_add(a, b):
    return Int64(a) + b


def f_sub(a, b):
    return Int64(a) - b


def f_sge(a, b):
    return Int64(a).sge(b) if not isinstance(a, Int64) else a.sge(b)


def f_make(lo, hi=0):
    """eps: const x = i64.make(lo, hi);  (실행 때 대입)"""
    return Int64(lo, hi)


def f_wrap(lo, hi):
    return Int64.wrap(lo, hi)


# ---------------------------------------------------------------- 32비트 부호 있는 비교 (조건만 돌려주는 예)
def f_sge32(x, k):
    """x >=s k.  k 상수면 부작용 없는 조건(목록)이나 플래그, 변수면 부호 비트 뒤집어 비교."""
    x = ut.unProxy(x)
    if isinstance(k, int):
        k &= MASK32
        if k < SIGN32:                  # k >= 0 : k <= x <= 0x7FFFFFFF  (AND 목록, 트리거 0개)
            return [c.Memory(x.getValueAddr(), c.AtLeast, k),
                    c.Memory(x.getValueAddr(), c.AtMost, SIGN32 - 1)]
        # k < 0 : NOT (0x80000000 <= x <= k-1)  -> 플래그 (트리거 2개)
        flag = c.EUDLightBool()
        c.RawTrigger(actions=flag.Set())
        if k > SIGN32:
            c.RawTrigger(conditions=[x.AtLeast(SIGN32), x.AtMost(k - 1)], actions=flag.Clear())
        return flag
    # 둘 다 변수: 사본을 만들어 부호 비트를 뒤집고 부호 없는 >= (포화 뺄셈 자기참조 기법)
    xs, ks = c.EUDVariable(), c.EUDVariable()
    SeqCompute([(xs, c.SetTo, x), (ks, c.SetTo, k)])
    c.RawTrigger(actions=[xs.AddNumber(SIGN32), ks.AddNumber(SIGN32)])
    d = c.EUDVariable()
    _sat_sub(d, ks, xs)                 # d>0 <=> xs < ks
    return d.Exactly(0)
