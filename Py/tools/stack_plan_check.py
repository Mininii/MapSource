#!/usr/bin/env python3
"""STRCtrig Assembler v5.5 Stack 적층 계획 점검 - 오프라인, eudplib 없이 돈다. (2026-09-12)

플러그인 파일의 CORE 구간(_roles / _plan / _scan 등)을 그대로 떼어 실행해서, tepc 출력 청크(Ctemp\\TRIGP0~8.chk)에
대해 stack 모드가 무엇을 겹쳐 싣고 무엇을 원래 배치로 둘지 계산하고, 그 계획을 독립적으로 검사한다.
  - 역할별 레코드 수와, 원래 배치로 둘 코드 레코드의 이유별 수 (이유 뜻은 플러그인 _plan 설명)
  - 겹쳐 실릴 레코드 수 / 원래 배치로 남는 레코드와 그 크기. theSeed 실측으로 scenario.chk 크기는 거의
    '원래 배치 레코드 수 x 2416 B' 만큼 움직였다 (겹쳐 실린 트리거는 서로의 빈 칸에 들어가 거의 공짜다).
  - 보폭 검사: 0x970/8(302) 배수를 상수로 더하고 빼는 포인터 칸(604/1208/2416/9664 보폭으로 트리거를 걷는 루프,
    점프 테이블)을 전부 찾아, 그 칸에 정적으로 들어가는 base 가 겹쳐 실릴 레코드에 떨어지는지 본다.
    BASE STACKED 가 0 이 아니면 그 빌드는 인게임에서 트리거 체인이 끊길 가능성이 높다 (stack 1·2차 테스트의 원인).
    base 가 런타임 복사로만 들어오는 칸은 정적으로 못 본다 - --detail 로 목록을 보고 역할(var/data)을 확인할 것.

사용:
  python stack_plan_check.py [Ctemp 폴더] [--plugin 플러그인.py] [--rules 이름,이름,...] [--detail] [--layout 파일]
    Ctemp 폴더   기본 C:\\euddraft0.9.2.0\\Ctemp  (빌드 뒤 남는 tepc 출력 그대로)
    --plugin     기본: 이 파일 기준 ..\\STRCtrig Assembler v5.5 Stack.py
    --rules      플러그인 _plan 이 rules 인자를 받으면 규칙 묶음 여러 개를 나란히 계산한다 (예: safe,lean)
    --detail     base 없는 보폭 칸, BASE STACKED 칸 목록
    --layout F   청크 배치 기록(플러그인 Layout 과 같은 형식)을 F 로 쓴다 (--rules 가 여럿이면 F_규칙.확장자)
32비트 Python 3.9 로 확인했다 (theSeed P8 청크 약 115MB, 1~2분)."""
import inspect
import os
import struct
import sys


def load_core(plugin):
    src = open(plugin, encoding="utf-8").read()
    ns = {"struct": struct}
    exec(src[src.index("# ==== CORE BEGIN"):src.index("# ==== CORE END")], ns)
    return ns


def main():
    args = sys.argv[1:]

    def opt(name, default=None):
        if name in args:
            i = args.index(name)
            v = args[i + 1]
            del args[i:i + 2]
            return v
        return default
    here = os.path.dirname(os.path.abspath(__file__))
    plugin = opt("--plugin", os.path.join(here, "..", "STRCtrig Assembler v5.5 Stack.py"))
    rules = opt("--rules")
    layout = opt("--layout")
    detail = "--detail" in args
    if detail:
        args.remove("--detail")
    ct = args[0] if args else r"C:\euddraft0.9.2.0\Ctemp"

    ns = load_core(plugin)
    REC, U, TB = ns["REC"], ns["_u32"], ns["_target_bytes"]
    ch = [None] + [bytearray(open(os.path.join(ct, "TRIGP%d.chk" % k), "rb").read()) for k in range(1, 9)]
    p0 = bytearray(open(os.path.join(ct, "TRIGP0.chk"), "rb").read())
    n = [0] + [len(ch[k]) // REC for k in range(1, 9)]
    role = [None] + [ns["_roles"](ch[k]) for k in range(1, 9)]
    rc = {}
    for k in range(1, 9):
        for r in role[k]:
            rc[r] = rc.get(r, 0) + 1
    print("%s: records %d, roles %s" % (ct, sum(n), rc))

    # 보폭 칸과 그 base - 플러그인 _plan 과 따로 다시 훑는다 (검사가 계획 코드에 기대지 않게)
    def dest_of(buf, ao):
        t = buf[ao + 26]
        if (t & 0xF0) == 0xF0 and 1 <= (t & 0xF) <= 8 and (buf[ao + 27] & 0x80):
            return (t & 0xF, TB('D', U(buf, ao + 16)))
        return None
    stepped, setters, refmap = {}, {}, {}

    def scan(buf, body, sk):
        for fo, kind, strx, p in ns["_scan"](buf, body, None):
            if strx and sk:
                refmap[(sk, fo)] = (p, TB(kind, U(buf, fo)))
        for a in range(64):
            ao = body + 320 + a * 32
            if buf[ao + 26] == 0:
                break
            d = dest_of(buf, ao)
            if d is None:
                continue
            f = buf[ao + 29] >> 4
            if (f == 0xF or f == 0xE) and (buf[ao + 28] & 0x80):
                setters.setdefault(d, []).append((buf[ao + 29] & 0xF, TB('E' if f == 0xF else 'P', U(buf, ao + 20))))
            elif (buf[ao + 27] & 0x7F) in (8, 9):
                v = U(buf, ao + 20)
                if v and v % 302 == 0 and v <= REC * 4096:
                    stepped.setdefault(d, set()).add(v)
    for k in range(1, 9):
        for i in range(n[k]):
            if role[k][i] != "data" and ch[k][i * REC + 8 + 15] == 0xFE:
                scan(ch[k], i * REC + 8, k)
    for q in range(len(p0) // 2400):
        if p0[q * 2400 + 15] == 0xFE:
            scan(p0, q * 2400, 0)

    takes_rules = "rules" in inspect.signature(ns["_plan"]).parameters
    names = rules.split(",") if rules else [None]
    if rules and not takes_rules:
        print("플러그인 _plan 이 rules 인자를 받지 않는다 - 기본 규칙만 계산한다")
        names = [None]
    for name in names:
        pinned, why = ns["_plan"](ch, role, p0, rules=name) if name else ns["_plan"](ch, role, p0)
        stacked = rc.get("code", 0) - len(pinned)
        kept = sum(n) - stacked
        bad, nobase = [], []
        for slot, steps in stepped.items():
            bases = list(setters.get(slot, ()))
            if slot in refmap:
                bases.append(refmap[slot])
            if not bases:
                nobase.append((slot, steps))
            for p, A in bases:
                if 0 <= A < len(ch[p]) and role[p][A // REC] == "code" and (p, A // REC) not in pinned:
                    bad.append((slot, steps, p, A))
        print("[rules=%s] kept-in-place code records %d %s" % (name or "default", len(pinned), why))
        print("    stacked %d / records left in place %d (%.1f MB) / stepped slots %d (no static base %d)"
              " -> BASE STACKED %d" % (stacked, kept, kept * REC / 1048576.0, len(stepped), len(nobase), len(bad)))
        if detail:
            for (p, A), steps, bp, bA in bad[:30]:
                print("    BASE STACKED: slot P%d rec %d +%d steps %s -> base P%d rec %d +%d"
                      % (p, A // REC, A % REC, sorted(steps)[:4], bp, bA // REC, bA % REC))
            for (p, A), steps in nobase:
                ti = A // REC
                print("    no static base: slot P%d rec %d +%d role %s steps %s"
                      % (p, ti, A % REC, role[p][ti] if 0 <= ti < n[p] else "?", sorted(steps)[:4]))
        if layout and "_layout_text" in ns:
            root, ext = os.path.splitext(layout)
            path = layout if len(names) == 1 else "%s_%s%s" % (root, name or "default", ext)
            with open(path, "w", encoding="utf-8") as f:
                f.write(ns["_layout_text"](ch, role, pinned, name or "default"))
            print("    layout -> %s" % path)


if __name__ == "__main__":
    main()
