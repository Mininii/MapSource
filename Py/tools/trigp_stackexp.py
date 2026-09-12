#!/usr/bin/env python3
"""tepc 가 낸 TRIGP*.chk (STRCtrig 노드 형식, 2416 B/트리거) 를 종류별로 분류하고,
eudplib 의 실제 할당기(object stacking) 로 "코드 트리거만 RawTrigger 로 실었을 때" 의 페이로드 크기를 잰다.

사용법 (eudplib 0.80.6 venv 에서):
  python trigp_stackexp.py <TRIGP8.chk>                 # 분류 통계만
  python trigp_stackexp.py <TRIGP8.chk> hazard          # 겹쳐 쌓기 시 비점유 슬롯을 건드리는 참조 집계
  python trigp_stackexp.py <TRIGP8.chk> baseline        # 지금처럼 Db 하나로 실었을 때 (기준선)
  python trigp_stackexp.py <TRIGP8.chk> stack code,cvar # 지정 종류만 RawTrigger 로, 나머지는 Db 블록으로
  python trigp_stackexp.py <TRIGP8.chk> audit           # 죽은 공간(종료 표시 뒤)을 참조하는 트리거 집계
  python trigp_stackexp.py <TRIGP8.chk> safe code,cvar  # stack 과 같되, 죽은 공간을 참조당하는 트리거는 Db 로 남김
종류: data_hdr/data(Skip 블록), varray_hdr/varray_elem(CVArray), cvar(단독 CVariable), full(액션 60개 이상),
      marsh(액션 전부 SetCtrig 참조), marsh_nocond(마샬링, 실조건 없음), logic(참조 액션 없음), mixed, jump(액션 0)
"code" 는 marsh,marsh_nocond,logic,mixed,jump 의 묶음 이름. 결과는 게임 검증이 아니라 크기 추정용이다.
"""
import sys, struct, time, collections

CODE_KINDS = ('marsh', 'marsh_nocond', 'logic', 'mixed', 'jump')

def load(path):
    d = open(path, 'rb').read()
    return [d[i*2416:(i+1)*2416] for i in range(len(d)//2416)]

def shape(t):
    nc = sum(1 for c in range(16) if t[c*20+15] not in (0, 22))
    na = sum(1 for a in range(64) if t[320+a*32+26] != 0)
    return nc, na

def label(t):
    return struct.unpack_from('<I', t, 8)[0] if t[15] == 0xFE else None

def is_cvar(t):
    nc, na = shape(t)
    return nc == 1 and na == 2 and t[15] == 0xFE and t[320+26] == 0x2D and (t[320+32+28] & 2)

def classify(recs):
    kinds = [None]*len(recs); i = 0
    while i < len(recs):
        r = recs[i]; t = r[8:2408]
        skip = struct.unpack_from('<I', r, 0)[0] & 0xFFFFF
        if skip:
            kinds[i] = 'data_hdr'
            for j in range(i+1, min(i+1+skip, len(recs))): kinds[j] = 'data'
            i += skip + 1; continue
        nc, na = shape(t)
        if is_cvar(t): kinds[i] = 'cvar' if label(t) else 'varray_elem'
        elif na >= 60: kinds[i] = 'full'
        else:
            acts = [t[320+a*32+26] for a in range(64) if t[320+a*32+26]]
            real = [t[c*20+15] for c in range(16) if t[c*20+15] not in (0, 22, 0xFE)]
            nref = sum(1 for a in acts if a == 0xF8)
            if na == 0: kinds[i] = 'jump'
            elif nref == na: kinds[i] = 'marsh_nocond' if not real else 'marsh'
            elif nref == 0: kinds[i] = 'logic'
            else: kinds[i] = 'mixed'
        i += 1
    for i in range(len(recs)-1):
        if kinds[i] == 'cvar' and kinds[i+1] == 'varray_elem': kinds[i] = 'varray_hdr'
    return kinds

BASE = 0x58A364 // 4   # tepc 가 기록하는 상대 EPD 는 "청크가 주소 0 에 있을 때의 EPD" 라 이 값을 더하면 청크 시작 기준 dword 오프셋이 된다

def occupied(nc, na, off):
    """겹쳐 쌓았을 때 그 트리거가 실제로 점유하는 바이트 범위(노드 기준) 안에 off 가 있는가."""
    ranges = [(0, 8), (8, 8 + 20*min(nc+1, 16)), (328, 328 + 32*min(na+1, 64)), (2376, 2380), (2404, 2408)]
    return any(a <= off < b for a, b in ranges)

def hazard(recs, kinds):
    """정적 참조(조건 0xF8 player, 액션 0xF8 player, 값 EPD 플래그 0xF?) 를 전부 풀어,
    대상 필드가 겹쳐 쌓기 후 비점유가 되는 것과 종료 슬롯 이후의 type 바이트를 쓰는 것을 센다."""
    shapes = [shape(r[8:2408]) for r in recs]; N = len(recs)
    bytarget = collections.defaultdict(lambda: [0, set()]); typebeyond = []; total = 0
    for i, (r, k) in enumerate(zip(recs, kinds)):
        if k in ('data', 'data_hdr'): continue
        t = r[8:2408]; items = []
        for c in range(16):
            b = c*20; ct = t[b+15]
            if ct == 0: break
            if ct == 0xF8: items.append(('R', struct.unpack_from('<I', t, b+4)[0], 0))
        for a in range(64):
            b = 320 + a*32; at = t[b+26]
            if at == 0: break
            if at != 0xF8: continue
            items.append(('W', struct.unpack_from('<I', t, b+16)[0], struct.unpack_from('<I', t, b)[0]))
            if (t[b+29] >> 4) == 0xF: items.append(('V', struct.unpack_from('<I', t, b+20)[0], 0))
        for how, sv, mask in items:
            dw = (sv + BASE) & 0xFFFFFFFF; ti, off = dw // 604, (dw % 604) * 4
            if ti >= N: continue
            total += 1
            if kinds[ti] in ('data', 'data_hdr', 'full'): continue
            nc, na = shapes[ti]
            if not occupied(nc, na, off):
                e = bytarget[ti]; e[0] += 1; e[1].add(i)
            if how == 'W' and off >= 328 and (off-328) % 32 == 24 and (mask & 0xFF0000) and (off-328)//32 >= na:
                typebeyond.append((i, ti, off))
            if how == 'W' and 8 <= off < 328 and (off-8) % 20 == 12 and (mask & 0xFF000000) and (off-8)//20 >= nc:
                typebeyond.append((i, ti, off))
    print(f"static references: {total}, unoccupied-after-stacking: {sum(v[0] for v in bytarget.values())}, "
          f"type-byte writes past terminator: {len(typebeyond)}")
    print("triggers that must stay fixed-stride (Db) because others touch their unused slots:")
    for ti, (n, srcs) in sorted(bytarget.items(), key=lambda x: -x[1][0]):
        t = recs[ti][8:2408]
        print(f"  idx {ti:6d} kind={kinds[ti]:12s} shape={shapes[ti]} label={label(t)} refs={n} writers={len(srcs)}")
    return set(bytarget)


def dead_targets(recs, kinds):
    """P8 청크 안을 가리키는 SetCtrig 참조 중, 대상 트리거의 '점유 영역'(prev/next, 사용 조건, 조건 종료 표시,
    사용 액션, 액션 종료 표시, 플래그, 마지막 바이트) 밖을 가리키는 것의 대상 집합.
    ★ 2026-09-12 해독 버그 수정: tepc 는 EPD 계열 참조를 (청크 오프셋 >> 2) - 0x58A364/4 로 적는다. 예전 판은 저장값을
    dword 번호로 그대로 읽고 음수(= 대부분의 청크 안 참조)를 '청크 밖'으로 버려서 audit/safe 수치(문서 7.7절 두 번째)가
    무효였다. 이제 hazard() 와 같은 해독(저장값 + BASE)을 쓰고, P8 을 가리키는 표식(타입 0xF8 / 값 p=8)만 본다."""
    N = len(recs); shapes = [shape(r[8:2408]) for r in recs]
    dead = {}; term_type = 0
    def visit(rel, mask):
        nonlocal term_type
        ti, off = rel // 2416, rel % 2416
        if ti >= N: return
        nc, na = shapes[ti]; o = off - 8
        if 0 <= o < 320:
            ci = o // 20
            if ci > nc: dead[ti] = dead.get(ti, 0) + 1
            elif ci == nc and (o % 20) <= 15 < (o % 20) + 4 and (mask >> (8*(15 - o % 20))) & 0xFF: term_type += 1
        elif 320 <= o < 2368:
            ai = (o - 320) // 32
            if ai > na: dead[ti] = dead.get(ti, 0) + 1
            elif ai == na and ((o-320) % 32) <= 26 < ((o-320) % 32) + 4 and (mask >> (8*(26 - (o-320) % 32))) & 0xFF: term_type += 1
        elif o >= 2372 and o != 2399: dead[ti] = dead.get(ti, 0) + 1
    for i, r in enumerate(recs):
        if kinds[i] in ('data', 'data_hdr'): continue
        t = r[8:2408]
        for c in range(16):
            f = struct.unpack_from('<IIIHBBBBH', t, c*20)
            if f[5] == 0: break
            if f[5] == 0xF8 and (f[4] & 0x80): visit(((f[1] + BASE) & 0xFFFFFFFF) * 4, 0)
        for a in range(64):
            f = struct.unpack_from('<IIIIIIHBBBBH', t, 320+a*32)
            if f[7] == 0: break
            if f[7] == 0xF8 and (f[8] & 0x80):
                mask = f[0] if f[11] == 0x4353 else 0xFFFFFFFF
                visit(((f[4] + BASE) & 0xFFFFFFFF) * 4, mask)
            if (f[9] & 0x80) and (f[10] & 0xF) == 8 and (f[10] & 0xF0) in (0xF0, 0xE0):   # 값 참조 (p=8)
                if (f[10] & 0xF0) == 0xF0: visit(((f[5] + BASE) & 0xFFFFFFFF) * 4, 0)
                elif f[5] < 0x80000000: visit(f[5], 0)
    return dead, term_type

def strip_label(sec):
    sec = bytearray(sec)
    if sec[15] == 0xFE:
        sec[0:300] = sec[20:320]; sec[300:320] = bytes(20)
    return bytes(sec)

def main():
    path = sys.argv[1]; mode = sys.argv[2] if len(sys.argv) > 2 else 'stats'
    recs = load(path); kinds = classify(recs)
    c = collections.Counter(kinds)
    print(f"{path}: {len(recs)} triggers, {len(recs)*2416} B")
    for k, n in c.most_common(): print(f"  {k:13s} {n:6d}  {n*2416/1048576:6.1f} MiB")
    if mode == 'stats': return
    dead, term_type = dead_targets(recs, kinds)
    if mode == 'audit':
        holders = [t for t, n in dead.items() if n >= 100]
        print(f"dead-space-targeted triggers: {len(dead)} (holders>=100 hits: {len(holders)}); by kind: {dict(collections.Counter(kinds[t] for t in dead))}")
        print(f"terminator-slot writes covering the type byte (mask): {term_type}  -- value must be 0 in the type byte or the engine runs garbage")
        return
    if mode == 'hazard': hazard(recs, kinds); return
    from eudplib import RawTrigger, Db, SetDeaths, SetTo, EPD, PushTriggerScope, PopTriggerScope
    from eudplib.core.allocator.payload import CreatePayload, CompressPayload
    CompressPayload(True)
    want = set()
    for k in (sys.argv[3].split(',') if len(sys.argv) > 3 else []):
        want |= set(CODE_KINDS) if k == 'code' else {k}
    unsafe = set(dead) if mode == 'safe' else set()
    keep = hazard(recs, kinds) if mode == 'stack' else set()
    for ti in keep: kinds[ti] = 'pinned'
    t0 = time.time(); PushTriggerScope(); root = RawTrigger(); nstack = ndb = dbbytes = 0
    if mode == 'baseline':
        db = Db(b''.join(recs)); ndb, dbbytes = 1, len(recs)*2416
        RawTrigger(actions=SetDeaths(EPD(db), SetTo, 0, 0))
    else:
        refs = []; i = 0
        while i < len(recs):
            if kinds[i] in want and i not in unsafe:
                RawTrigger(trigSection=strip_label(recs[i][8:2408])); nstack += 1; i += 1
            else:
                j = i
                while j < len(recs) and (kinds[j] not in want or j in unsafe): j += 1
                db = Db(b''.join(recs[i:j])); ndb += 1; dbbytes += (j-i)*2416
                refs.append(SetDeaths(EPD(db), SetTo, 0, 0))
                if len(refs) == 60: RawTrigger(actions=refs); refs = []
                i = j
        if refs: RawTrigger(actions=refs)
    RawTrigger(); PopTriggerScope()
    size = len(CreatePayload(root).data)
    print(f"[{mode} {sorted(want)}] stacked={nstack} db_blocks={ndb} db_bytes={dbbytes} "
          f"payload={size} B ({size/1048576:.1f} MiB) ratio={size/(len(recs)*2416):.3f} {time.time()-t0:.0f}s")

if __name__ == '__main__':
    main()
