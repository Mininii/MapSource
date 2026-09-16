# -*- coding: utf-8 -*-
"""SNQC.py 오프라인 컴파일 시험 (eudplib 0.76.14 = C:\\euddraft0.9.2.0 에 든 판).

euddraft 가 플러그인을 부르는 순서를 흉내 낸다:
settings 를 넣고 모듈 실행 → onPluginStart → 매 사이클 beforeTriggerExec.
맵은 사본(C:\\Temp\\snqc)을 읽고 결과도 그 폴더에만 쓴다 - 게임 맵 폴더·빌드 도구는 안 건드린다.
트리거가 **만들어지는지**만 본다. 게임 안에서 맞게 도는지는 ../DESIGN.md "확인 목록".

  (eudplib 0.76.14 가 깔린 파이썬, 예: C:\\Users\\whatd\\.venvs\\eud076\\Scripts\\python.exe)
  python test_snqc.py theseed   theSeed 의 [SNQC] (없으면 [MSQC]) 줄 (C:\\euddraft0.9.2.0\\theSeed.eds)
  python test_snqc.py dps       DPS_eud 의 [MSQC] 줄 (build_eud.py 처럼 SCA 줄을 빼고 SCR_DB 채널 8줄을 더함)

2026-09-17: 두 설정 모두 통과 (theSeed 7명 x 9채널, DPS 4명 x 11채널).
"""
import os
import re
import shutil
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
PLUGIN = os.path.join(HERE, "..", "SNQC.py")  # MapSource/SNQC/SNQC.py
WORK = r"C:\Temp\snqc"
SCMD = r"C:\Users\whatd\Desktop\Stormcoast Fortress\ScmDraft 2"
MAPS = {
    "theseed": (r"C:\euddraft0.9.2.0\theSeed_headless.scx", r"C:\euddraft0.9.2.0\theSeed.eds"),
    "dps": (os.path.join(SCMD, "DPS_eud", "DPS_headless.scx"),
            os.path.join(SCMD, "DPS_eud", "build", "eudplibData", "EUDEditor.eds")),
}
SCA_TOKENS = ("vchatindex", "msqcspecial", "msqccondiction", "msqcistransfer", "msqcflcondition", "msqcscaidcondition")


def read_section(path, name):
    out, cur = [], None
    with open(path, "r", encoding="utf-8", errors="replace") as f:
        for ln in f.read().splitlines():
            s = ln.strip()
            if s.startswith("[") and s.endswith("]"):
                cur = s[1:-1].strip().lower()
                continue
            if cur == name.lower() and s and not s.startswith("#"):
                out.append(s)
    return out


def to_settings(lines):
    settings = {}
    for s in lines:
        m = re.match(r"^(.*?)\s*[=:]\s*(.*)$", s)
        if m:
            settings[m.group(1).strip()] = m.group(2).strip()
    return settings


def main():
    which = sys.argv[1] if len(sys.argv) > 1 else "theseed"
    from eudplib import CompressPayload, EUDDoEvents, EUDEndInfLoop, EUDInfLoop, LoadMap, SaveMap

    src_map, eds = MAPS[which]
    os.makedirs(WORK, exist_ok=True)
    base = os.path.join(WORK, os.path.basename(src_map))
    shutil.copyfile(src_map, base)
    lines = read_section(eds, "SNQC") or read_section(eds, "MSQC")  # 옮긴 뒤의 eds 도 읽는다
    if which == "dps":
        lines = [l for l in lines if not any(t in l.lower() for t in SCA_TOKENS)]
        lines += ["Memory(0x%X,AtLeast,1);val, 0x%X: %d" % (0x58F508 + 4 * k, 0x58F508 + 4 * k, 21 + k)
                  for k in range(8)]
    settings = to_settings(lines)
    print("[test] %s: %d settings" % (which, len(settings)))

    LoadMap(base)
    CompressPayload(True)
    ns = {"__name__": "SNQC", "settings": settings}
    with open(PLUGIN, encoding="utf-8") as f:
        exec(compile(f.read(), "SNQC.py", "exec"), ns)

    def root():
        ns["onPluginStart"]()
        if EUDInfLoop()():
            ns["beforeTriggerExec"]()
            EUDDoEvents()
        EUDEndInfLoop()

    out = os.path.join(WORK, "out_%s.scx" % which)
    t = time.time()
    SaveMap(out, root)
    print("[test] %s -> %s (%d B, %.1fs)" % (which, out, os.path.getsize(out), time.time() - t))


if __name__ == "__main__":
    main()
