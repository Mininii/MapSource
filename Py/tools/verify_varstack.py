#!/usr/bin/env python3
"""VarStack 검증 - 적층 전(old) / 후(new) 빌드의 Ctemp\\TRIGP0~8.chk 를 대조한다.
  1) 버퍼 헤더, 그리고 VARSTACK.txt 대로 놓인 각 변수의 '엔진이 읽는 바이트'가 옛 레코드와 같은가
  2) 모든 정적 참조(P0~P8 코드 -> STRx 청크)를 '라벨 기준 대상'으로 바꿔 두 빌드의 다중집합이 같은가
     (변수 레코드가 빠지면서 '라벨 + 0x970' 류 참조의 뜻이 바뀌면 여기서 걸린다)
사용: python verify_varstack.py <old_dir> <new_dir>   (new_dir 에 VARSTACK.txt)"""
import sys, os, struct, collections

BASE = 0x58A364 // 4
FIELDS = (0x4, 0x148, 0x158, 0x15C, 0x160, 0x164)

def load(d):
    ch = {}
    b = open(os.path.join(d, 'TRIGP0.chk'), 'rb').read()
    ch[0] = [b[i*2400:(i+1)*2400] for i in range(len(b)//2400)]
    for k in range(1, 9):
        b = open(os.path.join(d, f'TRIGP{k}.chk'), 'rb').read()
        ch[k] = [b[i*2416:(i+1)*2416] for i in range(len(b)//2416)]
    return ch

def body(k, r):
    return r if k == 0 else r[8:2408]

def label(t):
    return struct.unpack_from('<I', t, 8)[0] if t[15] == 0xFE else 0

def regions(recs):
    kind = ['code']*len(recs); i = 0
    while i < len(recs):
        skip = struct.unpack_from('<I', recs[i], 0)[0] & 0xFFFFF
        if skip:
            kind[i] = 'hdr'
            for j in range(i+1, min(i+1+skip, len(recs))): kind[j] = 'data'
            i += skip + 1; continue
        i += 1
    return kind

def refs_of(t):
    out = []
    for c in range(16):
        b = c*20; ct = t[b+15]
        if ct == 0: break
        if 0xF1 <= ct <= 0xF8 and (t[b+14] & 0x80):
            sv = struct.unpack_from('<I', t, b+4)[0]
            out.append(('R', ct & 0xF, ((sv + BASE) & 0xFFFFFFFF) * 4))
    for a in range(64):
        b = 320 + a*32; at = t[b+26]
        if at == 0: break
        if 0xF1 <= at <= 0xF8 and (t[b+27] & 0x80):
            sv = struct.unpack_from('<I', t, b+16)[0]
            out.append(('W', at & 0xF, ((sv + BASE) & 0xFFFFFFFF) * 4))
        vf, vp = t[b+29] >> 4, t[b+29] & 0xF
        if vf in (0xE, 0xF) and 1 <= vp <= 8 and (t[b+28] & 0x80):
            sv = struct.unpack_from('<I', t, b+20)[0]
            out.append(('V' if vf == 0xF else 'P', vp, ((sv + BASE) & 0xFFFFFFFF) * 4 if vf == 0xF else sv))
    return out

class Canon:
    def __init__(self, recs, vm):
        self.n = len(recs); self.vm = vm
        kinds = regions(recs); self.anchor = []; cur = (0, 0)
        for i, r in enumerate(recs):
            if kinds[i] != 'data':
                L = label(r[8:2408])
                if L: cur = (L, i)
            self.anchor.append(cur)
    def __call__(self, A, how):
        if self.vm:
            base, n, slots, end = self.vm
            if base - 2416 <= A < end:
                rel = A - base
                # 값 참조(V/P)의 +0 = 변수 노드 주소(CallLabel 점프 대상). 읽기/쓰기(R/W)의 +0 은 남의 플래그 칸이라 불가
                for off in (FIELDS + (0,) if how in ('V', 'P') else FIELDS):
                    if (rel - off) % 72 == 0 and 0 <= (rel - off) // 72 < n:
                        return ('L', slots[(rel - off) // 72], off)
                return ('BAD-IN-VBUF', rel)
        i = A // 2416
        if i >= self.n: return ('OOB', A)
        L, ai = self.anchor[i]
        return ('L', L, A - ai * 2416)

def read_vmap(path):
    raw = {}
    for line in open(path):
        f = line.split()
        if not f or f[0] == 'KEEP': continue
        if f[0] == 'BASE':
            raw[int(f[1][1:])] = [int(f[2], 16), int(f[4]), {}, int(f[6])]
        else:
            raw[int(f[0][1:])][2][int(f[2])] = int(f[1], 16)
    return {k: (b, n, s, b + nrec * 2416) for k, (b, n, s, nrec) in raw.items()}

def collect(ch, vms):
    cz = {k: Canon(ch[k], vms.get(k)) for k in range(1, 9)}
    cnt = collections.Counter(); total = 0
    for k in range(0, 9):
        recs = ch[k]; kinds = ['code'] * len(recs) if k == 0 else regions(recs)
        for i, r in enumerate(recs):
            if kinds[i] != 'code': continue
            t = body(k, r)
            if t[15] != 0xFE: continue
            for how, p, A in refs_of(t):
                cnt[(k, how, p) + cz[p](A, how)] += 1; total += 1
    return cnt, total

def main():
    od, nd = sys.argv[1], sys.argv[2]
    old, new = load(od), load(nd)
    vms = read_vmap(os.path.join(nd, 'VARSTACK.txt'))
    for k in range(0, 9):
        a, b = len(old[k]), len(new[k])
        if a != b: print(f"P{k}: {a} -> {b} records ({(b - a) * (2400 if k == 0 else 2416):+,} B)")
    bad = 0
    for k, (base, n, slots, end) in sorted(vms.items()):
        kinds = regions(old[k]); idx = {}
        for i, r in enumerate(old[k]):
            if kinds[i] == 'code':
                L = label(r[8:2408])
                if L: idx.setdefault(L, i)
        buf = b''.join(new[k]); hdr = new[k][base // 2416 - 1]
        if struct.unpack_from('<I', hdr, 0)[0] & 0xFFFFF != (end - base) // 2416 or hdr[8 + 15] != 0:
            print(f"P{k}: bad vbuf header"); bad += 1
        for j in range(n):
            L = slots[j]; node = base + 72 * j
            if L not in idx:
                print(f"P{k}: label {L:X} not a record in old build"); bad += 1; continue
            o = old[k][idx[L]]
            ea = bytearray(o[0x148:0x168]); ea[4:16] = bytes(12)
            ok = (buf[node + 0x148:node + 0x168] == bytes(ea) and buf[node + 0x948:node + 0x94C] == o[0x948:0x94C]
                  and buf[node + 0x4:node + 0x8] == bytes(4) and buf[node + 0x17] == 0 and buf[node + 0x182] == 0
                  and buf[node + 0x964:node + 0x968] == bytes(4))
            if not ok:
                bad += 1
                if bad <= 10: print(f"P{k}: var {L:X} slot {j} field mismatch")
        print(f"P{k}: {n} stacked vars checked against old records")
    co, to = collect(old, {})
    cn, tn = collect(new, vms)
    keys = set(co) | set(cn); diff = [(key, co[key], cn[key]) for key in keys if co[key] != cn[key]]
    print(f"static refs: old {to:,} / new {tn:,}, distinct targets {len(keys):,}, mismatched {len(diff)}")
    for key, a, b in sorted(diff, key=lambda x: -abs(x[1] - x[2]))[:25]:
        print("   ", key, a, '->', b)
    print("RESULT:", "PASS" if bad == 0 and not diff else "FAIL")

if __name__ == '__main__':
    main()
