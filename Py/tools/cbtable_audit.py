#!/usr/bin/env python3
"""TRIGP8.chk (+ TRIGP0.chk) 진단.
 (1) G_CB 포인터 표(CB_initTCopy 의 f_GetVoidptr 4개)의 할당 크기와, 그 표를 향하는 정적 참조의 실제 착지점
 (2) 모든 데이터 블록(Skip 헤더) 에 대해, 블록 안에 쓰는 트리거가 블록 끝 너머까지 쓰는지
 (3) tepc 의 EPD 정의 EPD(x) = (x>>2) - 0x58A364/4 로 푼 '종료 표시 뒤 슬롯' 참조 (문서 7.7 재검증)
사용: python cbtable_audit.py <TRIGP8.chk> [--p0 TRIGP0.chk] [--fx 16진라벨]
TRIGP0 는 CHK TRIG 형식(2400 B/트리거), TRIGP8 은 노드 형식(2416 B = prev/next 8 + 2400 + 8)."""
import sys, struct, collections

BASE = 0x58A364 // 4      # 1452249 (tepc STRCtrig.h EPD 와 같은 상수)
REC = 2416

def load(p, stride):
    d = open(p, 'rb').read()
    return [d[i*stride:(i+1)*stride] for i in range(len(d)//stride)]

def ncna(t):
    nc = na = 0
    for c in range(16):
        if t[c*20+15] == 0: break
        nc += 1
    for a in range(64):
        if t[320+a*32+26] == 0: break
        na += 1
    return nc, na

def label(t):
    return struct.unpack_from('<I', t, 8)[0] if t[15] == 0xFE else None

def regions(recs):
    kind = ['code']*len(recs); hdrs = []; i = 0
    while i < len(recs):
        skip = struct.unpack_from('<I', recs[i], 0)[0] & 0xFFFFF
        if skip:
            kind[i] = 'hdr'; hdrs.append((i, skip))
            for j in range(i+1, min(i+1+skip, len(recs))): kind[j] = 'data'
            i += skip + 1; continue
        i += 1
    return kind, hdrs

def refs_of(t, wid, out):
    """트리거 본문 t(2400 B) 안의, P8 STRx 청크를 가리키는 정적 참조를 out 에 (wid, how, sv) 로."""
    for c in range(16):
        b = c*20; ct = t[b+15]
        if ct == 0: break
        if ct == 0xF8 and (t[b+14] & 0x80):
            out.append((wid, 'R', struct.unpack_from('<I', t, b+4)[0]))
    for a in range(64):
        b = 320 + a*32; at = t[b+26]
        if at == 0: break
        if at != 0xF8: continue
        if t[b+27] & 0x80:
            out.append((wid, 'W', struct.unpack_from('<I', t, b+16)[0]))
        if (t[b+29] >> 4) == 0xF and (t[b+28] & 0x80):
            out.append((wid, 'V', struct.unpack_from('<I', t, b+20)[0]))

def body(r):
    return r[8:2408]

def desc(recs, kind, n):
    t = body(recs[n])
    if kind[n] == 'code':
        nc, na = ncna(t); return f"code(c{nc},a{na},label={label(t)})"
    if kind[n] == 'hdr':
        return f"hdr(skip={struct.unpack_from('<I', recs[n], 0)[0] & 0xFFFFF},label={label(t)})"
    return kind[n]

def main():
    args = sys.argv[1:]
    p8 = args[0]
    p0 = args[args.index('--p0')+1] if '--p0' in args else None
    fx = int(args[args.index('--fx')+1], 16) if '--fx' in args else None

    recs = load(p8, REC); N = len(recs)
    kind, hdrs = regions(recs)
    raw = []
    for i, r in enumerate(recs):
        if kind[i] == 'code': refs_of(body(r), i, raw)
    if p0:
        for i, t in enumerate(load(p0, 2400)): refs_of(t, -(i+1), raw)   # P0 작성자는 음수 id
    rs = []
    for w, how, sv in raw:
        dw = (sv + BASE) & 0xFFFFFFFF
        node, off = dw // 604, (dw % 604) * 4
        if node < N: rs.append((w, how, node, off))
    by_node = collections.defaultdict(list)
    for w, how, node, off in rs: by_node[node].append((w, how, off))
    print(f"{p8}: {N} records, data blocks {len(hdrs)}, refs into P8 chunk {len(rs)} "
          f"(from P8 {sum(1 for r in rs if r[0] >= 0)}, from P0 {sum(1 for r in rs if r[0] < 0)})")

    # (1) CB 표: --fx 가 있으면 라벨 fx..fx+3 인 헤더(표 크기 무관)를, 없으면 code, [hdr(skip=1), data] x4, code 를 찾는다
    hdr_at = {h: n for h, n in hdrs}
    if fx is not None:
        hs = sorted((h, n) for h, n in hdrs if label(body(recs[h])) in range(fx, fx + 4))
        if hs:
            h0 = hs[0][0]; hs = [(h, n) for h, n in hs if h - h0 < 40]; last = hs[-1][0] + hs[-1][1]
            print(f"\n[CB tables] FX label=0x{fx:X}")
            for h, n in hs:
                print(f"  table hdr idx {h} label=0x{label(body(recs[h])):X} skip={n} (entries 1..{n*604-1})")
            for node in range(h0 - 1, min(last + 5, N)):
                ws = [(w, off) for w, how, off in by_node.get(node, []) if how == 'W']
                rd = [off for w, how, off in by_node.get(node, []) if how == 'R']
                s = f"  idx {node:6d} {desc(recs, kind, node):34s} writes={len(ws):4d}"
                if ws:
                    s += f" off {min(o for _, o in ws)}..{max(o for _, o in ws)}"
                    s += f" from P0={sum(1 for w, _ in ws if w < 0)} P8={sum(1 for w, _ in ws if w >= 0)}"
                if rd: s += f"  reads={len(rd)} off {min(rd)}..{max(rd)}"
                print(s)
    cands = []
    for h, n in (hdrs if fx is None else []):
        L = label(body(recs[h]))
        if L is None or (fx is not None and L != fx): continue
        ok = h > 0 and kind[h-1] == 'code' and h + 8 < N and kind[h+8] == 'code'
        for k in range(4):
            hk = h + 2*k
            ok = ok and hdr_at.get(hk) == 1 and label(body(recs[hk])) == L + k
        if ok: cands.append(h)
    for h0 in cands:
        print(f"\n[CB tables] FX label=0x{label(body(recs[h0])):X} at idx {h0}  (each table: 1 data record = entries 1..603)")
        for node in range(h0 - 1, min(h0 + 12, N)):
            ws = [(w, off) for w, how, off in by_node.get(node, []) if how == 'W']
            rd = [off for w, how, off in by_node.get(node, []) if how == 'R']
            s = f"  idx {node:6d} {desc(recs, kind, node):34s} writes={len(ws):4d}"
            if ws:
                s += f" off {min(o for _, o in ws)}..{max(o for _, o in ws)}"
                s += f" from P0={sum(1 for w, _ in ws if w < 0)} P8={sum(1 for w, _ in ws if w >= 0)}"
            if rd: s += f"  reads={len(rd)} off {min(rd)}..{max(rd)}"
            print(s)
    if fx is None and not cands: print("\n[CB tables] not found")

    # (2) 데이터 블록 경계 넘침
    print("\n[block overflow] writers that write inside a data block AND into the 3 records after it")
    nhit = 0
    for h, n in hdrs:
        end = h + n
        inside = {w for node in range(h+1, end+1) for w, how, off in by_node.get(node, []) if how == 'W'}
        if not inside: continue
        for node in range(end+1, min(end+4, N)):
            spill = [off for w, how, off in by_node.get(node, []) if how == 'W' and w in inside]
            if spill:
                nhit += 1
                if nhit <= 30:
                    print(f"  block hdr {h} (label={label(body(recs[h]))}, skip={n}) -> idx {node} {desc(recs, kind, node)}: "
                          f"{len(spill)} writes, off {min(spill)}..{max(spill)}")
    print(f"  total {nhit}")

    # (3) 종료 표시 뒤(비점유) 슬롯을 가리키는 참조 - 올바른 EPD 해독 기준
    dead = collections.Counter(); dead_p0 = collections.Counter(); shp = {}
    for w, how, node, off in rs:
        if kind[node] != 'code': continue
        if node not in shp: shp[node] = ncna(body(recs[node]))
        nc, na = shp[node]
        occ = (off < 8 or 8 <= off < 8 + 20*min(nc+1, 16) or 328 <= off < 328 + 32*min(na+1, 64)
               or 2376 <= off < 2380 or 2404 <= off < 2408)
        if not occ:
            dead[node] += 1
            if w < 0: dead_p0[node] += 1
    print(f"\n[dead-space] code triggers referenced past their terminators: {len(dead)} "
          f"(refs {sum(dead.values())}, of which from P0 {sum(dead_p0.values())}); holders>=100 refs: {sum(1 for v in dead.values() if v >= 100)}")
    for node, c in dead.most_common(12):
        print(f"  idx {node:6d} {desc(recs, kind, node):34s} refs={c} (P0 {dead_p0[node]})")

if __name__ == '__main__':
    main()
