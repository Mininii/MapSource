"""STRCtrig Assembler v5.5 Stack - 원본 STRCtrig Assembler v5.5 (Ninfia) 의 포크 (2026-09-12)

원본과 같은 .eds 설정(Path / bat)을 받고, 청크(TRIGP1~8.chk)를 싣는 방식만 바꾼다.

  Mode : reloc  재배치를 컴파일 시점(eudplib 주소식)으로 옮긴다. 청크 배치는 원본과 같다(청크 하나 = 객체 하나).
                맵 시작 때 STRX PATCH 루프(theSeed 기준 트리거 실행 약 1,000만 회 추정)가 없어진다.
  Mode : stack  reloc + 코드 트리거를 eudplib 할당기가 겹쳐 싣게 한다(엔진이 읽는 칸만 점유, 나머지는 WriteSpace).
                데이터 블록(skip), 변수형 트리거(V/W/SV 배열 포함), 액션 60개 이상, 빈 트리거(CArray/CreateArr
                메모리), 그리고 _plan 이 고르는 코드 트리거(빈 칸을 참조당함, 604 보폭 포인터·배열·점프 테이블의
                base 가 든 같은 모양 구간)는 원래 배치 그대로 연속 묶음으로 둔다 - 런타임에 "주소 + 번호*604" 로
                계산하는 코드가 그 안에서만 돌기 때문이다.
  Pin  : safe   (stack 모드 기본) 원래 배치로 둘 트리거를 넓게 고른다 - 2026-09-12 theSeed 인게임 통과 규칙.
         lean   safe 에서 '순수 점프'(함수 복귀 주소처럼 next 로만 흘러가는 트리거 주소)만 풀어 준다. _plan 설명.

원본의 맵 시작 재배치 = (1) Connect Next: next += 청크 주소  (2) 표식 해제: 조건 타입 0x0F, 액션 타입 0x2D, 값 플래그
(3) base 덧셈: STRx 대상은 청크 TRIGPp, 맵 TRIG 대상은 런타임에 찾은 PpSTART  (4) NSQC.
이 포크는 (1)(2)와 STRx 대상의 (3), 그리고 (4)를 컴파일 때 끝낸다. 런타임에 남는 것은
  - 맵 TRIG 를 가리키는 참조(STRx 비트 없음, theSeed 32개): PpSTART 덧셈
  - stack 모드에서 맵 TRIG(TRIGP0) 쪽이 STRx 청크를 가리키는 참조(theSeed 3,960개): SetDeaths 로 한 번 채움
  - 맵 TRIG 자체의 재배치 루프(TRIG PATCH)와 PpSTART 를 찾는 루프: 원본 그대로
뿐이다.

★ 알려진 한계: NSQC 플러그인(NSQCASM + 604*8 간격 쓰기)과는 stack 모드를 같이 쓸 수 없다.
★ 청크 해석 규칙은 원본 STRX PATCH(1802~1937행)와 TRIG PATCH(1664~1800행)를 그대로 옮긴 것이다.
"""
from eudplib import *
from eudx import *
import math
import os
import struct
import bisect

PRT_SetInliningRate(0)

NSQCASM = EUDVariable()
EUDRegisterObjectToNamespace("NSQCASM", NSQCASM)


# ==== CORE BEGIN (eudplib 없이 도는 해석부 - 오프라인 검증 스크립트가 이 구간만 떼어 쓴다) ====
REC = 0x970                 # 청크 레코드 = prev 4 + next 4 + 트리거 2400 + 여분 8
EPD_BIAS = 0x58A364 // 4    # tepc STRCtrig.h: EPD(X) = (X >> 2) - 1452249


def _u32(b, o):
    return struct.unpack_from('<I', b, o)[0]


def _s32(v):
    v &= 0xFFFFFFFF
    return v - 0x100000000 if v & 0x80000000 else v


def _ncna(b, body):
    """조건/액션 개수 (엔진처럼 타입 0 에서 멈춘다)."""
    nc = 0
    for c in range(16):
        if b[body + c * 20 + 15] == 0:
            break
        nc += 1
    na = 0
    for a in range(64):
        if b[body + 320 + a * 32 + 26] == 0:
            break
        na += 1
    return nc, na


def _scan(b, body, patch=None):
    """런타임 재배치 루프(STRX PATCH / TRIG PATCH)와 같은 순서·조건으로 표식을 찾는다.
    b: bytearray, body: 트리거 본문(조건 0 번)의 오프셋. 조건 0 이 라벨(0xFE)인 트리거에만 부를 것.
    patch: None / "all" / "strx"(STRx 대상만) - 해당 표식의 타입·플래그를 런타임이 하던 대로 되돌린다.
    반환: [(필드 오프셋, kind, strx, 대상 청크 1~8)]  kind C=조건 player, D=액션 목적지, E=값(EPD), P=값(PTR)"""
    out = []
    for c in range(1, 16):                                  # 조건 1~15 (0 번은 라벨)
        o = body + c * 20
        t = b[o + 15]
        if (t & 0xF0) == 0xF0:
            p = t & 0xF
            if 1 <= p <= 8:                                 # Call1~8PX 중 하나가 맞을 때만 고쳐진다
                strx = (b[o + 14] & 0x80) != 0
                out.append((o + 4, 'C', strx, p))
                if patch == "all" or (patch == "strx" and strx):
                    b[o + 15] = 0x0F                        # SetDeathsX(.., 0x0F000000, mask 0xFF800000)
                    b[o + 14] &= 0x7F
        elif t == 0:
            break
    for a in range(64):
        o = body + 320 + a * 32
        t = b[o + 26]
        if (t & 0xF0) == 0xF0:
            p = t & 0xF
            if 1 <= p <= 8:
                strx = (b[o + 27] & 0x80) != 0
                out.append((o + 16, 'D', strx, p))
                if patch == "all" or (patch == "strx" and strx):
                    b[o + 26] = 0x2D                        # SetDeathsX(.., 0x2D0000, mask 0x80FF0000)
                    b[o + 27] &= 0x7F
        f = b[o + 29] >> 4                                  # 값 플래그: 0xF = EPD, 0xE = PTR
        if f == 0xF or f == 0xE:
            p = b[o + 29] & 0xF
            if 1 <= p <= 8:
                strx = (b[o + 28] & 0x80) != 0
                out.append((o + 20, 'E' if f == 0xF else 'P', strx, p))
                if patch == "all" or (patch == "strx" and strx):
                    b[o + 28] &= 0x7F                       # SetDeathsX(.., 0, mask 0xFF80)
                    b[o + 29] = 0
        if t == 0:                                          # 런타임도 표식을 본 뒤에 타입 0 으로 빠진다
            break
    return out


def _roles(b):
    """레코드 역할: hdr(skip 헤더) / data / full(액션 60+) / var(변수형) / mem(액션 없음) / code.
    mem = CArray/LArray/CreateArr 의 빈 트리거. 본문 전체가 런타임 메모리다(Arr 는 +0 부터 쓰고 인덱스는 런타임에
    604 단위로 계산된다). 2026-09-12 stack 2차 테스트에서 게임 시작 배치(RandomPlacement/TrapBuilding 의 CreateArr)
    가 이 빈 트리거 위에 겹쳐 실린 다른 트리거를 덮어써 체인이 끊겼다."""
    n = len(b) // REC
    role = [None] * n
    i = 0
    while i < n:
        o = i * REC
        prev = _u32(b, o)
        skip = prev & 0xFFFFF if prev >= 1 else 0           # 원본: Deaths(CP, AtLeast, 1) 이면 하위 20비트
        if skip:
            role[i] = "hdr"
            for j in range(i + 1, min(i + 1 + skip, n)):
                role[j] = "data"
            i += skip + 1
            continue
        body = o + 8
        nc, na = _ncna(b, body)
        if na >= 60:
            role[i] = "full"
        elif na == 0:
            role[i] = "mem"
        elif (nc <= 1 and na == 2 and b[body + 320 + 26] == 0x2D and (b[body + 320 + 32 + 28] & 2)) or \
                _varlike(b, body, nc, na):
            role[i] = "var"
        else:
            role[i] = "code"
        i += 1
    return role


def _varlike(b, body, nc, na):
    """변수형 모양: 라벨 뒤 조건 없음, 액션이 전부 SetDeaths(0x2D)이고 홀수 번째만 Disabled.
    CVariable/CVArray(2개), CWariable/CWArray(4개), CSVariable/SVArray(2N개) 가 이 모양이다 - 배열은 런타임에
    "첫 원소 + 번호*604" 로 접근하므로 흩으면 안 된다."""
    if nc > 1 or na % 2:
        return False
    for a in range(na):
        o = body + 320 + a * 32
        if b[o + 26] != 0x2D or (b[o + 28] & 2) != (2 if a % 2 else 0):
            return False
    return True


def _plan(ch, role, p0, run_fix=256, rules="safe"):
    """stack 모드에서 겹쳐 싣지 않고 원래 배치로 둘 코드 레코드를 고른다 (겹쳐 싣으면 런타임에 깨지는 것).
    ch / role: [None, 청크 1~8 의 bytearray / _roles 결과],  p0: TRIGP0.chk 원본(표식이 그대로 있는 것).
    반환: (pinned = {(p, i)}, 이유별 레코드 수)
      dead  정적 참조가 트리거의 빈 칸(종료 표시 뒤)을 읽거나 쓴다.
      run   같은 모양이 run_fix 개 이상 이어진 구간 (언롤 배열 안전망).
      step  0x970/8(302) 배수를 상수로 더하고 빼는 칸(604/1208/2416/9664 보폭으로 걷는 포인터)의 base.
      field 트리거 필드 주소(+0 이 아닌 값 참조)가 값으로 저장된다 - "첫 원소 + 번호*604" 배열 base (EXCC 헤더 등).
      base0 트리거 주소(+0)가 next 칸이 아닌 곳(변수, CP, 다른 필드)에 저장된다 - 런타임 포인터 연산의 출발점.
            next 칸에 바로 들어가는 +0 은 점프라 괜찮다. (CP 로 연속 노드를 고치며 SetNext 대상을 2416 씩 옮기는
            점프 테이블 루틴은 base 가 런타임 복사로 들어와 step 으로는 안 잡힌다 - 이 규칙이 잡는다.)
    step/field/base0 은 대상이 속한 '같은 모양 연속 구간' 통째를 고정한다 - 비트 루프는 끝 원소에서 거꾸로 걷는다.
    rules: "safe" = 위 규칙 전부 (2026-09-12 theSeed stack 3차 인게임 통과).
           "lean" = safe 에서, base0 중 '순수 점프 칸'에 저장되는 +0 PTR 을 뺀다. 순수 점프 칸 F:
                    (1) next 칸을 목적지로 하는 SetTo 액션의 값 칸이고, F 가 든 트리거는 code 이면서
                        dead/run/step/field 로 고정되지 않았다 (런타임 배열 원소가 아니다). 목적지가 런타임에
                        채워지는 액션(CtrigAsm 복귀 트램펄린)은 목적지 칸에 쓰는 액션이 모두 SetTo + 'next 칸 EPD'
                        정적 참조이고 그 칸이 노출·계산되지 않을 때만 next 로 본다.
                    (2) 누구도 F 의 주소를 값으로 들고 있지 않고 조건으로 F 를 읽지도 않는다 (값이 새지 않는다)
                    (3) F 에 쓰는 액션이 전부 SetTo 이고 모두 STRx 청크 안에 있으며, 그 액션들의 값 칸도 아무도
                        쓰지 않고 주소도 잡히지 않는다 (정적 참조나 상수만 들어온다 - 계산된 주소가 들어올 길이 없다).
                    CtrigAsm 함수 호출의 복귀 주소처럼 "칸에 넣어 두었다가 나중에 next 로 옮기는" +0 이 여기 해당한다.
                    theSeed 실측(2026-09-12): base0 참조 12,912 중 8,842 가 여기 해당, 원래 배치 코드 12,263 -> 10,311."""
    n = [0] + [len(ch[k]) // REC for k in range(1, 9)]
    cache = {}

    def ncna(p, i):
        v = cache.get((p, i))
        if v is None:
            v = cache[(p, i)] = _ncna(ch[p], i * REC + 8)
        return v

    def sig(k, i):
        b = ch[k]
        o = i * REC + 8
        nc, na = ncna(k, i)
        return (nc, na, bytes(b[o + c * 20 + 15] for c in range(nc)),
                bytes(b[o + 320 + a * 32 + 26] for a in range(na)))

    run_of = {}         # (p, i) -> (구간 시작, 길이)   같은 모양 코드 레코드가 이어진 구간
    for k in range(1, 9):
        i = 0
        while i < n[k]:
            if role[k][i] != "code":
                i += 1
                continue
            s = sig(k, i)
            j = i + 1
            while j < n[k] and role[k][j] == "code" and sig(k, j) == s:
                j += 1
            for q in range(i, j):
                run_of[(k, q)] = (i, j - i)
            i = j

    marks = []          # (kind, p, A, next 칸에 바로 저장되는가)
    refmap = {}         # (청크, 필드 오프셋) -> (p, A)   그 필드의 초기값이 참조
    setters = {}        # 칸 (p, A) -> [(p, A)]   그 칸에 값 참조를 SetTo/Add 하는 액션들
    stepped = set()     # 0x970/8 배수를 상수로 더하고 빼는 칸

    def dest_of(buf, ao):
        t = buf[ao + 26]
        if (t & 0xF0) == 0xF0 and 1 <= (t & 0xF) <= 8 and (buf[ao + 27] & 0x80):
            return (t & 0xF, _target_bytes('D', _u32(buf, ao + 16)))
        return None

    def scan(buf, body, sk):
        for fo, kind, strx, p in _scan(buf, body, None):
            if not strx:
                continue
            A = _target_bytes(kind, _u32(buf, fo))
            nxt = False
            d = None
            if kind in "EP":
                d = dest_of(buf, body + 320 + (fo - body - 320) // 32 * 32)
                nxt = d is not None and d[1] % REC == 4
            if kind != 'D':
                exposed.add((p, A))                         # 그 칸의 주소를 값으로 들고 있다(E/P) / 조건으로 읽는다(C)
            marks.append((kind, p, A, nxt, d))
            if sk:
                refmap[(sk, fo)] = (p, A)
        for a in range(64):
            ao = body + 320 + a * 32
            if buf[ao + 26] == 0:
                break
            d = dest_of(buf, ao)
            if d is None:
                continue
            f = buf[ao + 29] >> 4
            writers.setdefault(d, []).append((buf[ao + 27] & 0x7F, (f == 0xF or f == 0xE) and (buf[ao + 28] & 0x80) != 0,
                                              (sk, ao + 20) if sk else None))
            if (f == 0xF or f == 0xE) and (buf[ao + 28] & 0x80):
                setters.setdefault(d, []).append(
                    (buf[ao + 29] & 0xF, _target_bytes('E' if f == 0xF else 'P', _u32(buf, ao + 20))))
            elif (buf[ao + 27] & 0x7F) in (8, 9):            # Add / Subtract
                v = _u32(buf, ao + 20)
                if v and v % 302 == 0 and v <= REC * 4096:
                    stepped.add(d)

    writers = {}        # 칸 (p, A) -> [(modifier, 값이 정적 참조인가, 그 액션의 값 칸 (청크, 오프셋) / P0 액션이면 None)]
    exposed = set()     # 주소가 값으로 잡혔거나 조건이 읽는 칸 (p, A)
    for k in range(1, 9):
        b = ch[k]
        for i in range(n[k]):
            if role[k][i] != "data" and b[i * REC + 8 + 15] == 0xFE:
                scan(b, i * REC + 8, k)
    for q in range(len(p0) // 2400):
        if p0[q * 2400 + 15] == 0xFE:
            scan(p0, q * 2400, 0)

    pinned = set()
    why = {"dead": 0, "run": 0, "step": 0, "field": 0, "base0": 0}

    def pin_run(p, ti, r):
        st, ln = run_of[(p, ti)]
        for q in range(st, st + ln):
            if (p, q) not in pinned:
                pinned.add((p, q))
                why[r] += 1

    fields, base0 = [], []
    for kind, p, A, nxt, d in marks:
        if A < 0 or A >= len(ch[p]):
            continue
        ti, off = divmod(A, REC)
        if role[p][ti] != "code":
            continue
        if kind in "EP":
            if off == 0:
                if not nxt:
                    base0.append((p, ti, kind, d))
                continue
            fields.append((p, ti))
        nc, na = ncna(p, ti)
        if not _occupied(nc, na, off) and (p, ti) not in pinned:
            pinned.add((p, ti))
            why["dead"] += 1
    for (p, i), (st, ln) in run_of.items():
        if i == st and ln >= run_fix:
            pin_run(p, i, "run")
    for d in stepped:
        bases = list(setters.get(d, ()))
        if d in refmap:
            bases.append(refmap[d])
        for p, A in bases:
            if 0 <= A < len(ch[p]) and role[p][A // REC] == "code":
                pin_run(p, A // REC, "step")
    for p, ti in fields:
        if run_of[(p, ti)][1] >= 2:
            pin_run(p, ti, "field")
    guard = set(pinned)                                     # 런타임 배열 원소 등 - 여기 든 칸은 순수 점프 칸이 아니다

    def pure_jump(F):
        p, A = F
        if A < 0 or A >= len(ch[p]):
            return False
        R, off = divmod(A, REC)
        if role[p][R] != "code" or (p, R) in guard or off < 328 or (off - 328) % 32 != 20:
            return False
        a = (off - 328) // 32
        if a >= ncna(p, R)[1]:
            return False
        ao = R * REC + 328 + a * 32                         # F 를 값 칸으로 갖는 액션
        d = dest_of(ch[p], ao)
        if (ch[p][ao + 27] & 0x7F) != 7 or F in exposed:
            return False
        if d is None:
            # 목적지를 런타임에 채우는 액션 = CtrigAsm 복귀 트램펄린. 호출하는 쪽이 "목적지 = 자기 next,
            # 값 = 돌아올 트리거" 를 채워 두고 넘어온다. 목적지 칸에 쓰는 액션이 모두 SetTo + 'next 칸의 EPD'
            # 정적 참조이고, 그 칸이 노출되지 않고 런타임에 계산돼 채워지지도 않을 때만 next 로 본다.
            DS = (p, ao + 16)
            ws = writers.get(DS)
            if not ws or DS in exposed:
                return False
            for mod, vref, wslot in ws:
                if mod != 7 or not vref or wslot is None or wslot in writers or wslot in exposed:
                    return False
                wb, wo = ch[wslot[0]], wslot[1]
                if (wb[wo + 9] >> 4) != 0xF:                  # 값 플래그(값 칸 + 9) 가 EPD 여야 한다
                    return False
                q, T = wb[wo + 9] & 0xF, _target_bytes('E', _u32(wb, wo))
                if not (1 <= q <= 8) or not (0 <= T < len(ch[q])) or T % REC != 4:
                    return False
        elif d[1] % REC != 4:
            return False
        for mod, vref, wslot in writers.get(F, ()):
            if mod != 7 or wslot is None or wslot in writers or wslot in exposed:
                return False
        return True
    jump = {}
    for p, ti, kind, d in base0:
        if rules == "lean" and kind == 'P' and d is not None:
            if d not in jump:
                jump[d] = pure_jump(d)
            if jump[d]:
                why["jump_refs"] = why.get("jump_refs", 0) + 1
                continue
        if run_of[(p, ti)][1] >= 2:
            pin_run(p, ti, "base0")
    return pinned, why


def _target_bytes(kind, raw):
    """표식 원값 -> 대상 청크 안 바이트 오프셋. EPD 계열은 tepc 가 (오프셋>>2) - 0x58A364/4 로 적었다."""
    if kind == 'P':
        return _s32(raw)
    return _s32(raw + EPD_BIAS) * 4


def _occupied(nc, na, off):
    """겹쳐 쌓았을 때 엔진/코드가 읽고 쓰는 칸 (prev/next, 조건+종료, 액션+종료, 플래그, 마지막 dword)."""
    return (off < 8 + 20 * min(nc + 1, 16) or 328 <= off < 328 + 32 * min(na + 1, 64)
            or 2376 <= off < 2380 or 2404 <= off < 2408)
# ==== CORE END ====


# ---- 설정 (원본과 같은 Path / bat, 추가로 Mode / Report) ----
_files = ['TRIGP%d.chk' % k for k in range(9)]
batpath = ""
batname = ""
batcheck = 0
pathcheck = 0
MODE = "stack"
REPORT = ""
PIN = "safe"        # stack 모드에서 원래 배치로 둘 트리거를 고르는 규칙 묶음 (_plan 의 rules): safe / lean
for k, v in settings.items():
    kl = k.lower()
    if kl == "path":
        _files = [v + f for f in _files]
        batpath = v
        pathcheck = 1
    elif kl == "bat":
        batcheck = 1
        batname = v + batname
    elif kl == "mode":
        MODE = v.strip().lower()
    elif kl == "report":
        REPORT = v.strip()
    elif kl == "pin":
        PIN = v.strip().lower()
if MODE not in ("reloc", "stack"):
    raise Exception("STRCtrig Assembler v5.5 Stack: Mode 는 reloc 또는 stack 이어야 한다 (받은 값: %s)" % MODE)
if PIN not in ("safe", "lean"):
    raise Exception("STRCtrig Assembler v5.5 Stack: Pin 은 safe 또는 lean 이어야 한다 (받은 값: %s)" % PIN)

if batcheck == 1:
    os.system(batpath + batname + ".bat")
    LoadMap(batpath + batname + "_out.scx")

if pathcheck == 0:
    _files = ["Ctemp\\" + f for f in _files]


# ---- TRIGP0 (맵 TRIG 앞에 붙는 부분). stack 모드면 STRx 청크를 가리키는 참조를 떼어 두었다가 런타임에 채운다 ----
_p0 = bytearray(open(_files[0], 'rb').read())
_P0FIX = []     # (플레이어 0~7, PpSTART 기준 레코드 번호, 본문 기준 필드 오프셋, kind, 대상 청크 1~8, 대상 청크 안 오프셋)
if MODE == "stack":
    _state = [0] * 8    # 0 = 0xFB 표시 전, 1 = TRIG PATCH 가 도는 구간, 2 = 0xFA 뒤
    _rno = [0] * 8
    for _j in range(len(_p0) // 0x960):
        _o = _j * 0x960
        _own = -1
        for _q in range(8):
            if _p0[_o + 0x944 + _q] == 1:
                _own = _q
                break
        if _own < 0:
            continue
        _t0 = _p0[_o + 15]
        if _state[_own] == 1:
            if _t0 == 0xFA:                                 # 원본 TRIG PATCH 가 여기서 멈춘다 (이 레코드는 안 고침)
                _state[_own] = 2
                continue
            if _t0 == 0xFE:
                for _fo, _kind, _strx, _p in _scan(_p0, _o, "strx"):
                    if _strx:
                        _P0FIX.append((_own, _rno[_own], _fo - _o, _kind, _p, _target_bytes(_kind, _u32(_p0, _fo))))
                        struct.pack_into('<I', _p0, _fo, 0)   # 자리만 비워 둔다 - 런타임에 SetTo 로 채움
            _rno[_own] += 1
        elif _state[_own] == 0 and _t0 == 0xFB:
            _state[_own] = 1
            _rno[_own] = 0

_chk = GetChkTokenized()
_TRIG = _chk.getsection('TRIG')
_buf = bytearray(_p0)
_buf.extend(_TRIG)
_chk.setsection('TRIG', _buf)
print("[CopyTRIG] TRIGP0.chk : {} Loaded. ({} TRIGs Loaded)".format(_files[0], len(_buf) // 0x960))


# ---- 청크 객체 ----
def _emit(buf, obj, lo, hi):
    """[lo, hi) 구간을 쓴다. 재배치 dword 는 주소식(ConstExpr)으로, 나머지는 바이트 그대로."""
    keys = obj.keys
    d = obj.data
    i = bisect.bisect_left(keys, lo)
    pos = lo
    while i < len(keys) and keys[i] < hi:
        k = keys[i]
        if k > pos:
            buf.WriteBytes(bytes(d[pos:k]))
        buf.WriteDword(obj.rel[k])
        pos = k + 4
        i += 1
    if hi > pos:
        buf.WriteBytes(bytes(d[pos:hi]))


class _Blob(EUDObject):
    """원래 배치 그대로인 레코드 묶음 (전부 점유)."""

    def __new__(cls, *args, **kwargs):
        return super().__new__(cls)

    def __init__(self, data):
        super().__init__()
        self.data = data
        self.rel = {}
        self.keys = []

    def GetDataSize(self):
        return len(self.data)

    def WritePayload(self, buf):
        _emit(buf, self, 0, len(self.data))


class _Trig(EUDObject):
    """겹쳐 싣는 코드 트리거 (2408 바이트 중 엔진이 읽는 칸만 점유)."""

    def __new__(cls, *args, **kwargs):
        return super().__new__(cls)

    def __init__(self, data, nc, na):
        super().__init__()
        self.data = data
        self.rel = {}
        self.keys = []
        self.spans = ((0, 8 + 20 * min(nc + 1, 16)), (328, 328 + 32 * min(na + 1, 64)), (2376, 2380), (2404, 2408))

    def GetDataSize(self):
        return 2408

    def WritePayload(self, buf):
        pos = 0
        for lo, hi in self.spans:
            if lo > pos:
                buf.WriteSpace(lo - pos)
            _emit(buf, self, lo, hi)
            pos = hi


class _Anchor(EUDObject):
    """다른 객체가 주소로 가리키지 않는 객체도 페이로드에 실리게 붙잡아 둔다."""

    def __new__(cls, *args, **kwargs):
        return super().__new__(cls)

    def __init__(self, objs):
        super().__init__()
        self.objs = objs

    def GetDataSize(self):
        return 4 * max(1, len(self.objs))

    def WritePayload(self, buf):
        if not self.objs:
            buf.WriteDword(0)
        for o in self.objs:
            buf.WriteDword(o)


def _build():
    """청크를 읽어 객체와 재배치를 만든다. 반환: 런타임 코드가 쓸 정보."""
    stack = MODE == "stack"
    ch = [None] + [bytearray(open(_files[k], 'rb').read()) for k in range(1, 9)]
    n = [0] + [len(ch[k]) // REC for k in range(1, 9)]
    role = [None] + [_roles(ch[k]) for k in range(1, 9)]
    cache = {}

    def nc_na(p, ti):
        v = cache.get((p, ti))
        if v is None:
            v = cache[(p, ti)] = _ncna(ch[p], ti * REC + 8)
        return v

    # 1) 겹쳐 싣을 수 없는 코드 트리거 - 규칙은 _plan 설명 참고. 역할이 code 가 아닌 레코드(skip 데이터, 변수형,
    #    액션 60+, 빈 트리거 = 메모리 배열)는 애초에 겹쳐 싣지 않는다.
    #    이력: stack 1차 = EXCC 1700 슬롯이 흩어져 유닛이 생기는 순간 끊김 / 2차 = CreateArr 빈 트리거 위에 다른
    #    트리거가 겹쳐 게임 시작 배치에서 끊김. 둘 다 "주소 + 번호*604" 런타임 계산이 원인이었다.
    pinned = set()
    why = {}
    if stack:
        pinned, why = _plan(ch, role, bytearray(open(_files[0], 'rb').read()), rules=PIN)
        print("[STRCtrig Stack] pin rules=%s, kept in place: %d code records %s" % (PIN, len(pinned), why))

    # 2) 객체 만들기
    objs = []
    where = [None] * 9
    nstack = [0] * 9
    nblob = [0] * 9
    for k in range(1, 9):
        b = ch[k]
        if not stack:
            blob = _Blob(bytearray(b))
            objs.append(blob)
            where[k] = blob
            nblob[k] = 1
            continue
        w = [None] * n[k]
        i = 0
        while i < n[k]:
            if role[k][i] == "code" and (k, i) not in pinned:
                nc, na = nc_na(k, i)
                t = _Trig(bytearray(b[i * REC:i * REC + 2408]), nc, na)
                objs.append(t)
                w[i] = (t, 0)
                nstack[k] += 1
                i += 1
            else:
                j = i
                while j < n[k] and not (role[k][j] == "code" and (k, j) not in pinned):
                    j += 1
                blob = _Blob(bytearray(b[i * REC:j * REC]))
                objs.append(blob)
                for q in range(i, j):
                    w[q] = (blob, (q - i) * REC)
                nblob[k] += 1
                i = j
        where[k] = w

    # 3) 재배치
    referenced = set()
    bad = []

    def locate(p, A):
        if not stack:
            return where[p], A
        if A < 0 or A >= len(ch[p]):
            return None, 0
        ti, off = divmod(A, REC)
        obj, s = where[p][ti]
        if isinstance(obj, _Trig) and off >= 2408:
            return None, 0
        return obj, s + off

    def value(kind, p, A):
        obj, d = locate(p, A)
        if obj is None:
            return None
        referenced.add(id(obj))
        if kind in ("N", "P"):
            return obj + d
        return EPD(obj) + d // 4

    runtime_fix = []    # 맵 TRIG 대상 참조: (객체, 필드 오프셋, kind, 대상 플레이어 1~8)
    nsqc = None
    nreloc = 0
    for k in range(1, 9):
        b = ch[k]
        nsqc_seen = False
        for i in range(n[k]):
            if role[k][i] == "data":
                continue
            o = i * REC
            obj, s = (where[k], o) if not stack else where[k][i]
            d = obj.data
            v = value("N", k, _u32(b, o + 4))                 # (1) Connect Next
            if v is None:
                bad.append(("next", k, i))
                v = 0
            obj.rel[s + 4] = v
            nreloc += 1
            if b[o + 8 + 15] != 0xFE:
                continue
            if not nsqc_seen and _u32(b, o + 16) == 0x1FFF0 and _u32(b, o + 48) == k - 1:
                nsqc = (k, i)                                 # 원본: 청크마다 처음 것, 마지막 청크 것이 남는다
                nsqc_seen = True
            for fo, kind, strx, p in _scan(d, s + 8, "all"):  # (2) 표식 해제
                if strx:                                      # (3) STRx 대상 base
                    v = value(kind, p, _target_bytes(kind, _u32(d, fo)))
                    if v is None:
                        bad.append((kind, k, i))
                        v = 0
                    obj.rel[fo] = v
                    nreloc += 1
                else:
                    runtime_fix.append((obj, fo, kind, p))
                    referenced.add(id(obj))

    # (4) NSQC - 원본: NSQCASM = (NSQC 라벨 레코드의 EPD) + 87 - 604*7
    nsqc_val = None
    nsqc_warn = False
    if nsqc is not None:
        k, i = nsqc
        if not stack:
            nsqc_val = EPD(where[k]) + i * 604 + 87 - 604 * 7
        elif i - 7 >= 0:
            obj, s = where[k][i - 7]
            nsqc_val = EPD(obj) + (s + 0x15C) // 4
            referenced.add(id(obj))
        else:
            obj, s = where[k][i]
            nsqc_val = EPD(obj) + s // 4 + 87 - 604 * 7
            nsqc_warn = True

    p0vals = []
    for own, r, fo, kind, p, A in _P0FIX:
        v = value(kind, p, A)
        if v is None:
            bad.append(("p0" + kind, p, A))
            v = 0
        p0vals.append((own, r, fo, v))

    for o in objs:
        o.keys = sorted(o.rel)
    anchor = None
    if stack:
        anchor = _Anchor([o for o in objs if id(o) not in referenced])

    rc = {}
    for k in range(1, 9):
        for r in role[k]:
            rc[r] = rc.get(r, 0) + 1
    stat = {
        "records": sum(n[1:]), "stacked": sum(nstack), "blobs": sum(nblob), "pinned": len(pinned),
        "why": why, "roles": rc, "pin": PIN if stack else "-",
        "reloc": nreloc, "runtime_fix": len(runtime_fix), "p0fix": len(_P0FIX), "bad": bad,
        "anchor": len(anchor.objs) if anchor else 0,
        "per_chunk": [(k, n[k], nstack[k], nblob[k]) for k in range(1, 9)],
        "fixed_bytes": sum(len(o.data) for o in objs if isinstance(o, _Blob)),
        "nsqc": nsqc, "nsqc_warn": nsqc_warn,
    }
    return where, runtime_fix, nsqc_val, p0vals, anchor, stat


def onPluginStart():  # Ctrig Assembler v5.5 for Tep Made by Ninfia - 청크 싣는 부분만 바꾼 포크
    global NSQCASM
    stack = MODE == "stack"
    where, runtime_fix, nsqc_val, p0vals, anchor, stat = _build()

    # TRIG PATCH(맵 TRIG 쪽)가 STRx 대상 표식에 더하는 base. stack 모드는 그 표식을 컴파일 때 떼어 냈으므로 0.
    TRIGPchk = [0] * 9
    TRIGPchkEPD = [None] * 9
    for k in range(1, 9):
        TRIGPchkEPD[k] = EUDVariable()
        if not stack:
            TRIGPchk[k] = where[k]
            TRIGPchkEPD[k] << where[k] // 4
    if anchor is not None:
        DoActions(SetMemory(anchor, Add, 0))

    PSTART = [EUDVariable() for _ in range(8)]
    PSTARTEPD = [EUDVariable() for _ in range(8)]
    PSTARTdEPD = [EUDVariable() for _ in range(8)]

    # ---- 원본 그대로: 게임이 읽어 들인 트리거 목록에서 플레이어별 StartCtrig(0xFB) 다음 트리거 = PpSTART 찾기 ----
    CtrigLoop = EUDVariable()
    CurrentTrig_0 = EUDVariable()
    CurrentTrig_0EPD = EUDVariable()
    CurrentTrig_0Index = EUDVariable()
    ptr_0 = EUDVariable()
    ptrloopend_0 = EUDVariable()
    CurrentTrig_0EPD5 = EUDVariable()
    LoopCheck = EUDVariable()
    if EUDWhile()((CtrigLoop <= 7)):
        for s in range(1, 8):                                # Remove Error (앞쪽 빈 플레이어 건너뛰기)
            conds = [f_playerexist(q) == 0 for q in range(s)] + [f_playerexist(s) == 1, CtrigLoop == 0]
            if EUDIf()(conds):
                CtrigLoop << s
            EUDEndIf()
        CurrentTrig_0 << f_maskread_epd(EPD(0x51A280 + 0x8 + 0xC * CtrigLoop), 0xFFFFFFFF)
        if EUDWhile()((LoopCheck.Exactly(0))):              # 0st Loop -- Load TRIG Section
            DoActions(ptr_0.AddNumber(1))
            if EUDIf()((ptr_0 <= 3)):
                CurrentTrig_0 << f_maskread_epd(EPD(CurrentTrig_0 + 0x4), 0xFFFFFFFF)
                CurrentTrig_0EPD << EPD(CurrentTrig_0)
            if EUDElse()():
                DoActions([CurrentTrig_0.AddNumber(0x970), CurrentTrig_0EPD.AddNumber(0x970 // 4)])
            EUDEndIf()
            CurrentTrig_0EPD5 << CurrentTrig_0EPD + 5
            for q in range(8):
                if EUDIf()((CtrigLoop == q, DeathsX(CurrentTrig_0EPD5, Exactly, 0xFB * 16777216, 0, 0xFF000000))):
                    PSTART[q] << CurrentTrig_0 + 0x970
                    PSTARTEPD[q] << CurrentTrig_0EPD + 0x970 // 4
                    PSTARTdEPD[q] << PSTART[q] // 4          # ΔEPD 처리
                    DoActions([LoopCheck.SetNumber(1)])
                EUDEndIf()
        EUDEndWhile()
        CtrigLoop << CtrigLoop + 1
        ptr_0 << 0
        ptrloopend_0 << 0
        CurrentTrig_0Index << 0
        LoopCheck << 0
        for s in range(1, 8):
            if EUDIf()((f_playerexist(s) == 0, CtrigLoop == s)):
                CtrigLoop << s + 1
            EUDEndIf()
    EUDEndWhile()
    CtrigLoop << 0

    Count = EUDVariable()
    CurEPD = EUDVariable()
    PrevCp = EUDVariable()
    PrevCp << f_getcurpl()

    # ---- 원본 그대로: 맵 TRIG 쪽 재배치 (TRIG PATCH). TCall[대상 p][종류 m][맵 TRIG 플레이어 i] ----
    #  m: 0 조건/STRx, 4 조건/TRIG, 1 목적지/STRx, 5 목적지/TRIG, 2 값EPD/STRx, 6 값EPD/TRIG, 3 값PTR/STRx, 7 값PTR/TRIG
    TCall = [[[Forward() for _ in range(8)] for _ in range(8)] for _ in range(8)]
    TCondEND = [Forward() for _ in range(8)]
    TActEND = [Forward() for _ in range(8)]

    def base(m, p):
        if m in (0, 1, 2):
            return TRIGPchkEPD[p + 1]
        if m == 3:
            return TRIGPchk[p + 1]
        if m in (4, 5, 6):
            return PSTARTdEPD[p]
        return PSTART[p]
    DoActions([SetMemory(TCall[p][m][i] + 0x19C, SetTo, base(m, p)) for m in range(8) for p in range(8) for i in range(8)])

    def calls(m, i, cmask, cshift, restore, rmask):
        for p in range(8):
            TCall[p][m][i] << RawTrigger(
                conditions=[DeathsX(CurrentPlayer, Exactly, (p + 1) << cshift, 0, cmask)],
                actions=[SetDeathsX(CurrentPlayer, SetTo, restore, 0, rmask), SetMemory(0x6509B0, Subtract, 2),
                         SetDeaths(CurrentPlayer, Add, 0, 0), SetMemory(0x6509B0, Add, 2)])

    for i in range(0, 8):
        if EUDIf()((f_playerexist(i) > 0)):
            CurEPD << PSTARTEPD[i]
            f_setcurpl(CurEPD + 1)
            LoopCheck << 0
            if EUDWhile()((LoopCheck.Exactly(0))):
                RawTrigger(actions=[SetMemory(0x6509B0, Add, 4)])
                if EUDIf()((DeathsX(CurrentPlayer, Exactly, 0xFE000000, 0, 0xFF000000))):  # Check Label
                    RawTrigger(actions=[SetMemory(0x6509B0, Add, 5)])
                    if EUDLoopN()(15):
                        if EUDIf()((DeathsX(CurrentPlayer, Exactly, 0xF0000000, 0, 0xF0000000))):
                            if EUDIf()((DeathsX(CurrentPlayer, Exactly, 0x000000, 0, 0x800000))):
                                calls(4, i, 0x0F000000, 24, 0x0F000000, 0xFF800000)
                            if EUDElse()():
                                calls(0, i, 0x0F000000, 24, 0x0F000000, 0xFF800000)
                            EUDEndIf()
                        if EUDElseIf()((DeathsX(CurrentPlayer, Exactly, 0x00000000, 0, 0xFF000000))):
                            EUDJump(TCondEND[i])
                        EUDEndIf()
                        RawTrigger(actions=[SetMemory(0x6509B0, Add, 5)])
                    EUDEndLoopN()
                    TCondEND[i] << NextTrigger()
                    f_setcurpl(CurEPD + 88)
                    if EUDLoopN()(64):
                        if EUDIf()((DeathsX(CurrentPlayer, Exactly, 0xF00000, 0, 0xF00000))):  # EPD
                            if EUDIf()((DeathsX(CurrentPlayer, Exactly, 0x00000000, 0, 0x80000000))):
                                calls(5, i, 0x0F0000, 16, 0x2D0000, 0x80FF0000)
                            if EUDElse()():
                                calls(1, i, 0x0F0000, 16, 0x2D0000, 0x80FF0000)
                            EUDEndIf()
                        EUDEndIf()
                        RawTrigger(actions=[SetMemory(0x6509B0, Add, 1)])
                        if EUDIf()((DeathsX(CurrentPlayer, Exactly, 0xF000, 0, 0xF000))):  # Value EPD
                            if EUDIf()((DeathsX(CurrentPlayer, Exactly, 0x00, 0, 0x80))):
                                calls(6, i, 0x0F00, 8, 0x0000, 0xFF80)
                            if EUDElse()():
                                calls(2, i, 0x0F00, 8, 0x0000, 0xFF80)
                            EUDEndIf()
                        if EUDElseIf()((DeathsX(CurrentPlayer, Exactly, 0xE000, 0, 0xF000))):  # Value PTR
                            if EUDIf()((DeathsX(CurrentPlayer, Exactly, 0x00, 0, 0x80))):
                                calls(7, i, 0x0F00, 8, 0x0000, 0xFF80)
                            if EUDElse()():
                                calls(3, i, 0x0F00, 8, 0x0000, 0xFF80)
                            EUDEndIf()
                        EUDEndIf()
                        RawTrigger(actions=[SetMemory(0x6509B0, Subtract, 1)])
                        EUDJumpIf([DeathsX(CurrentPlayer, Exactly, 0x000000, 0, 0xFF0000)], TActEND[i])
                        RawTrigger(actions=[SetMemory(0x6509B0, Add, 8)])
                    EUDEndLoopN()
                    TActEND[i] << NextTrigger()
                    f_setcurpl(CurEPD + 5)
                if EUDElseIf()((DeathsX(CurrentPlayer, Exactly, 0xFA000000, 0, 0xFF000000))):
                    LoopCheck << 1
                EUDEndIf()
                RawTrigger(actions=[Count.AddNumber(1), CurEPD.AddNumber(604), SetMemory(0x6509B0, Add, 600)])
            EUDEndWhile()
        EUDEndIf()

    # ---- 원본 STRX PATCH 자리: 컴파일 때 끝낸 것을 빼고 남은 일만 ----
    if nsqc_val is not None:
        NSQCASM << nsqc_val
    if runtime_fix:                                          # 맵 TRIG 를 가리키는 참조 += PpSTART (원본 Call?PX[4~7])
        SeqCompute([(EPD(obj) + fo // 4, Add, PSTART[p - 1] if kind == "P" else PSTARTdEPD[p - 1])
                    for obj, fo, kind, p in runtime_fix])
    if p0vals:                                               # stack: 맵 TRIG 쪽이 STRx 청크를 가리키는 칸 채우기
        for own in range(8):
            fx = sorted((r * 604 + 2 + fo // 4, v) for o, r, fo, v in p0vals if o == own)
            if not fx:
                continue
            if EUDIf()((f_playerexist(own) > 0)):
                f_setcurpl(PSTARTEPD[own])
                acts = []
                cur = 0
                for tgt, v in fx:
                    acts.append(SetMemory(0x6509B0, Add, tgt - cur))
                    acts.append(SetDeaths(CurrentPlayer, SetTo, v, 0))
                    cur = tgt
                for q in range(0, len(acts), 64):
                    DoActions(acts[q:q + 64])
            EUDEndIf()

    f_setcurpl(PrevCp)
    Trigger(conditions=[Is64BitWireframe()], actions=[SetMemory(0xA03740, SetTo, 1)])

    lines = [
        "[STRCtrig Stack] mode=%s records=%d stacked=%d fixed-blobs=%d (fixed %.1f MB) pinned=%d" % (
            MODE, stat["records"], stat["stacked"], stat["blobs"], stat["fixed_bytes"] / 1048576, stat["pinned"]),
        "[STRCtrig Stack] compile-time relocations=%d, runtime: TRIG-target adds=%d, TRIGP0->STRx fills=%d, anchor=%d" % (
            stat["reloc"], stat["runtime_fix"], stat["p0fix"], stat["anchor"]),
        "[STRCtrig Stack] per chunk (P, records, stacked, blobs): %s" % stat["per_chunk"],
        "[STRCtrig Stack] pin rules=%s; roles %s; kept-in-place code records by reason %s" % (
            stat["pin"], stat["roles"], stat["why"]),
        "[STRCtrig Stack] NSQC label: %s%s" % (stat["nsqc"], "  ** stack 모드에서는 NSQC 플러그인과 호환되지 않음" if stat["nsqc_warn"] else ""),
    ]
    if stat["bad"]:
        lines.append("[STRCtrig Stack] ** unresolved relocations: %d, first %s" % (len(stat["bad"]), stat["bad"][:10]))
    for ln in lines:
        print(ln)
    if REPORT:
        with open(REPORT, "w", encoding="utf-8") as f:
            f.write("\n".join(lines) + "\n")
