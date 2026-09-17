# -*- coding: utf-8 -*-
"""SNQC.py 오프라인 컴파일 시험 (eudplib 0.76.14 = C:\\euddraft0.9.2.0 에 든 판, 1.3 부터 0.81 도).

euddraft 가 플러그인을 부르는 순서를 흉내 낸다:
settings 를 넣고 모듈 실행 → onPluginStart → 매 사이클 beforeTriggerExec.
맵은 사본(C:\\Temp\\snqc)을 읽고 결과도 그 폴더에만 쓴다 - 게임 맵 폴더·빌드 도구는 안 건드린다.
트리거가 **만들어지는지**만 본다. 게임 안에서 맞게 도는지는 ../DESIGN.md "확인 목록",
보내기 → 턴 → 받기 한 바퀴는 t_snqc_emu.py (에뮬레이터).

  (eudplib 0.76.14 또는 0.81 이 깔린 파이썬, 예: C:\\Users\\whatd\\.venvs\\eud076\\Scripts\\python.exe)
  python test_snqc.py theseed   theSeed 의 [SNQC] (없으면 [MSQC]) 줄 (C:\\euddraft0.9.2.0\\theSeed.eds)
  python test_snqc.py dps       DPS_eud 의 [MSQC] 줄 (build_eud.py 처럼 SCA 줄을 빼고 SCR_DB 채널 8줄을 더함)
  python test_snqc.py theseed SNQCCreator=P8   뒤에 "이름=값" 을 주면 설정에 더한다 (1.2 의 SNQCCreator 시험)
  환경 변수 (1.3): SNQC_WORK = 작업 폴더 (기본 C:\\Temp\\snqc), SNQC_MAP / SNQC_EDS = 맵·eds 경로를 바꾼다
    (다른 빌드가 원본 맵을 열고 있을 수 있으면 사본을 준다 - Windows 는 같은 scx 를 동시에 열면 오류 32)

2026-09-17: 두 설정 모두 통과 (theSeed 7명 x 9채널, DPS 4명 x 11채널).
2026-09-17 (1.3): 0.76.14·0.81.0 모두 theSeed, theSeed + SNQCCreator=P8, DPS 통과. 0.81 에서 "EPD on EPD" 경고 0.
"""
import os
import re
import shutil
import sys
import time
import warnings

HERE = os.path.dirname(os.path.abspath(__file__))
PLUGIN = os.path.join(HERE, "..", "SNQC.py")  # MapSource/SNQC/SNQC.py
WORK = os.environ.get("SNQC_WORK", r"C:\Temp\snqc")
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
    import eudplib
    from eudplib import CompressPayload, EUDDoEvents, EUDEndInfLoop, EUDInfLoop, LoadMap, SaveMap

    src_map, eds = MAPS[which]
    src_map = os.environ.get("SNQC_MAP", src_map)
    eds = os.environ.get("SNQC_EDS", eds)
    os.makedirs(WORK, exist_ok=True)
    base = os.path.join(WORK, os.path.basename(src_map))
    shutil.copyfile(src_map, base)
    lines = read_section(eds, "SNQC") or read_section(eds, "MSQC")  # 옮긴 뒤의 eds 도 읽는다
    if which == "dps":
        lines = [l for l in lines if not any(t in l.lower() for t in SCA_TOKENS)]
        lines += ["Memory(0x%X,AtLeast,1);val, 0x%X: %d" % (0x58F508 + 4 * k, 0x58F508 + 4 * k, 21 + k)
                  for k in range(8)]
    settings = to_settings(lines)
    for extra in sys.argv[2:]:
        k, _, v = extra.partition("=")
        settings[k.strip()] = v.strip()
    print("[test] %s: %d settings" % (which, len(settings)))

    LoadMap(base)
    CompressPayload(True)
    ns = {"__name__": "SNQC", "settings": settings}
    wcatch = warnings.catch_warnings(record=True)
    wlist = wcatch.__enter__()
    warnings.simplefilter("always")
    with open(PLUGIN, encoding="utf-8") as f:
        exec(compile(f.read(), "SNQC.py", "exec"), ns)

    from eudplib.maprw.injector import mainloop

    def root():
        ns["onPluginStart"]()
        if EUDInfLoop()():
            if hasattr(mainloop, "_set_game_loop_start"):  # 0.81: euddraft 0.11 처럼 게임 루프 시작점
                mainloop._set_game_loop_start()
            ns["beforeTriggerExec"]()
            EUDDoEvents()
        EUDEndInfLoop()

    out = os.path.join(WORK, "out_%s%s.scx" % (which, "_extra" if sys.argv[2:] else ""))
    t = time.time()
    try:
        SaveMap(out, root)
    finally:
        wcatch.__exit__(None, None, None)
    nwarn = sum(1 for w in wlist if "EPD on EPD" in str(w.message))
    print("[test] %s -> %s (%d B, %.1fs), eudplib %s, 'EPD on EPD' 경고 %d"
          % (which, out, os.path.getsize(out), time.time() - t, getattr(eudplib, "__version__", "?"), nwarn))


if __name__ == "__main__":
    main()
