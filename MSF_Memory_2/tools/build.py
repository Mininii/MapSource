"""MSF_Memory_2 원클릭 빌드 — SCMDraft 도 EUD Editor(e3s) 도 쓰지 않는다.

    build.bat 더블클릭                         (= python tools\\build.py)
    python tools\\build.py --tepc-only          1단계(tepc)만 돌린다
    python tools\\build.py --split              원본 맵을 기본 맵 + 음원 폴더로 다시 나눈 뒤 빌드한다

  입력 (MSF_UE_RE 와 같은 구성)
    MSF_Memory2_base.scx     지형·유닛·로케이션. 음원을 뺀 chk 하나짜리 (tools\\split_map.py 가 만든다)
    main.lua + *.lua         트리거. EUD Editor 가 하던 일(유닛 스탯·버튼·요구조건·tbl 글)도 여기 있다 -
                             EUDEditorDat / ButtonSets / RequireData / StatTxt .lua, 적용은 EUDEditorPort.lua
    stat_txt.tbl             tbl 편집분(EUDEditorStatTxt.lua)을 얹는 영어 원본 (스타 1.16.1)
    eds_template.eds         euddraft 설정. {{...}} 자리를 이 스크립트가 채운다
    C:\\euddraft0.9.2.0\\MSF_Memory2_BGM\\   음원. MSF_Memory2_BGMInput.py 가 euddraft 단계에서 넣는다
  단계
    0. 원본 C:\\euddraft0.9.2.0\\MSF_Memory2.scx 가 기본 맵보다 새것이면 먼저 나눈다 (split_map.py).
       그래서 지형·유닛은 SCMDraft 로 원본을 고쳐 저장만 하면 된다 (SCMDraft 에서 트리거 컴파일은 필요 없다).
    1. tepc     main.lua -> 트리거. TRIGP*.chk 는 C:\\euddraft0.9.2.0\\Ctemp.
                stat_txt 합본(MSF_Memory2_stat_txt.tbl)도 이때 EUDEditorPort.lua 의 WriteStatTxtTbl() 이 쓴다.
    2. euddraft eds_template.eds 를 채워 돌린다 (STRCtrig·APMCounter·NSQC·freeze·unlimiter·CPLP·dataDumper·음원).
                끝나면 음원이 전부 원래 이름·내용 그대로 들어갔는지 맵을 열어 확인한다.
    3. CPLP     보호판 *_out.scx 를 만든다 = 실제로 플레이할 맵.
"""
import argparse
import os
import re
import shutil
import struct
import subprocess
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import mpq  # noqa: E402
import split_map  # noqa: E402

PROJ = os.path.dirname(HERE)                       # MapSource\MSF_Memory_2
MAPSOURCE = os.path.dirname(PROJ)
DOCS = os.path.dirname(MAPSOURCE)
EUDDIR = r"C:\euddraft0.9.2.0"
EUDDRAFT = os.path.join(EUDDIR, "euddraft.exe")
CPLP = os.path.join(EUDDIR, "CustomPlibLockProtector.exe")
SRCMAP = split_map.SRC                              # SCMDraft 로 저장한 원본 (음원 포함)
BASEMAP = split_map.BASE                            # 음원을 뺀 chk 하나짜리 = tepc 입력
BGM_DIR = split_map.BGM_DIR
BGM_MODULE = os.path.join(PROJ, "MSF_Memory2_BGMInput.py")
SOUND_EXT = split_map.SOUND_EXT
EDS_TEMPLATE = os.path.join(PROJ, "eds_template.eds")
STAT_TXT_BASE = os.path.join(PROJ, "stat_txt.tbl")  # 편집분을 얹는 영어 원본
# EUDEditorPort.lua 의 WriteStatTxtTbl() 이 컴파일할 때 쓰는 합본. 그쪽 StatTxtOutFile 과 같아야 한다.
STAT_TXT_OUT = os.path.join(EUDDIR, "MSF_Memory2_stat_txt.tbl")
# EUD Editor 가 만들던 출력 이름을 그대로 쓴다.
FINAL = r"C:\Program Files (x86)\StarCraft\Maps\마린키우기_Memory2_Test.scx"
FINAL_OUT = FINAL[:-4] + "_out.scx"                 # CPLP 가 새로 쓰는 보호판 = 실제로 플레이할 맵
TEPC = os.path.join(DOCS, "theSeed", "tools", "tepc_20260905.exe")
STAT = os.path.join(DOCS, "theSeed", "stat_txt.tbl")  # tepc 의 유닛 이름표용


def lua_str(s):
    return s.replace("\\", "\\\\")


def decode(b):
    for enc in ("utf-8", "cp949"):
        try:
            return b.decode(enc)
        except UnicodeDecodeError:
            pass
    return b.decode("utf-8", "replace")


def bgm_files():
    """MSF_Memory2_BGMInput.py 가 넣을 파일들 (같은 규칙: 폴더 바로 아래의 .ogg/.wav)."""
    if not os.path.isdir(BGM_DIR):
        return []
    return sorted(f for f in os.listdir(BGM_DIR)
                  if os.path.splitext(f)[1].lower() in SOUND_EXT and os.path.isfile(os.path.join(BGM_DIR, f)))


def ensure_base(force):
    """원본 맵이 기본 맵보다 새것이면(= SCMDraft 로 고쳐 저장했으면) 다시 나눈다."""
    if not os.path.isfile(SRCMAP):
        if force:
            raise SystemExit("원본 맵이 없어 나눌 수 없다: %s" % SRCMAP)
        return
    if force or not os.path.isfile(BASEMAP) or not bgm_files() \
            or os.path.getmtime(SRCMAP) > os.path.getmtime(BASEMAP):
        print("=== 0. 원본 맵 -> 기본 맵 + 음원 폴더 (%s)" % ("--split" if force else "원본이 더 새것"))
        split_map.split()


def preflight(tepc_only):
    need = [(BASEMAP, "기본 맵 (python tools\\split_map.py)"), (TEPC, "tepc"), (STAT, "tepc 용 stat_txt.tbl"),
            (os.path.join(PROJ, "main.lua"), "main.lua"), (STAT_TXT_BASE, "tbl 편집분을 얹을 영어 원본 stat_txt.tbl")]
    if not tepc_only:
        need += [(EUDDRAFT, "euddraft"), (CPLP, "CustomPlibLockProtector.exe"), (BGM_MODULE, "음원 플러그인"),
                 (EDS_TEMPLATE, "euddraft 설정 틀 eds_template.eds")]
    missing = ["%s 가 없다: %s" % (what, p) for p, what in need if not os.path.isfile(p)]
    if not tepc_only and not bgm_files():
        missing.append("음원 폴더가 없거나 비었다: %s (python tools\\split_map.py)" % BGM_DIR)
    return missing


def scmd_unit_names():
    """SCMDraft 식 유닛 이름('이름 (부제)') -> ID. tepc 는 stat_txt 의 첫 필드만 알아서 이 표를 끼운다
    (MSF_UE_RE/tools/build_scrdb.py 와 같다)."""
    d = open(STAT, "rb").read()
    n = struct.unpack_from("<H", d, 0)[0]
    offs = struct.unpack_from("<%dH" % n, d, 2)
    out = {}
    for i in range(228):
        parts = d[offs[i]:].split(b"\0", 2)
        if len(parts) >= 2 and parts[1] not in (b"", b"*"):
            out[(parts[0] + b" (" + parts[1] + b")").decode("latin-1")] = i
    return out


def compile_tepc(work, stage1):
    print("\n=== 1. tepc (main.lua -> %s)" % stage1)
    os.makedirs(work, exist_ok=True)
    shutil.copy2(TEPC, os.path.join(work, "tepc.exe"))    # tepc 는 제 옆에 임시 chk 를 쓴다
    shutil.copy2(BASEMAP, os.path.join(work, "in.scx"))
    names = scmd_unit_names()
    lines = ['__MapDirSetting("%s")' % lua_str(EUDDIR), "local SCMDUnit = {"]
    for k, v in sorted(names.items(), key=lambda kv: kv[1]):
        lines.append('\t["%s"] = %d,' % (k.replace("\\", "\\\\").replace('"', '\\"'), v))
    lines += ["}",
              "local NativeParseUnit = ParseUnit",
              "function ParseUnit(Unit)",
              '\tif type(Unit) == "string" and SCMDUnit[Unit] ~= nil then return SCMDUnit[Unit] end',
              "\treturn NativeParseUnit(Unit)",
              "end",
              'dofile("%s")' % lua_str(os.path.join(PROJ, "main.lua")),
              ""]
    with open(os.path.join(work, "editor.lua"), "w", encoding="utf-8", newline="") as f:
        f.write("\r\n".join(lines))
    env = dict(os.environ, MAPSOURCE_CURDIR=os.path.dirname(MAPSOURCE))
    cmd = [os.path.join(work, "tepc.exe"), "in.scx", "editor.lua", stage1, "--cflag", "1", "--stat-txt", STAT]
    started = time.time()
    r = subprocess.run(cmd, cwd=work, capture_output=True, timeout=3600, env=env)
    log = decode(r.stdout + r.stderr)
    with open(os.path.join(work, "tepc.log"), "w", encoding="utf-8") as f:
        f.write(log)
    print("  rc=%d (%.1f초, 로그 -> %s)" % (r.returncode, time.time() - started, os.path.join(work, "tepc.log")))
    print("\n".join("  | " + l for l in log.splitlines()[-15:]))
    if r.returncode == 0 and not os.path.isfile(stage1):
        print("tepc 가 rc=0 인데 %s 를 만들지 않았다" % stage1)
        return 6
    return r.returncode


def check_stat_txt(since):
    """WriteStatTxtTbl() 이 이번 컴파일에서 합본을 썼는지. 낡은 파일이 남아 있으면 그걸 싣게 되므로 멈춘다."""
    if not os.path.isfile(STAT_TXT_OUT) or os.path.getmtime(STAT_TXT_OUT) < since:
        raise SystemExit("이번 컴파일이 stat_txt 합본을 쓰지 않았다: %s (EUDEditorPort.lua 의 WriteStatTxtTbl)"
                         % STAT_TXT_OUT)
    d = open(STAT_TXT_OUT, "rb").read()
    n = struct.unpack_from("<H", d, 0)[0]
    print("  stat_txt 합본: %d줄, %d바이트 -> %s" % (n, len(d), STAT_TXT_OUT))


def write_eds(dst, stage1):
    """eds_template.eds 의 {{...}} 자리를 채운다."""
    with open(EDS_TEMPLATE, "r", encoding="utf-8") as f:
        text = f.read()
    fill = {
        "INPUT": stage1,
        "OUTPUT": FINAL,
        # eds 의 "키 : 값" 줄은 콜론에서 나뉘어 C:\... 를 못 쓴다 (dataDumper 가 'C' 라는 파일을 찾는다).
        # run_euddraft 가 eds 옆에 복사해 둔 이름만 쓴다 - 예전 EUD Editor eds 의 ..\temp\custom_txt.tbl 와 같은 식.
        "STAT_TXT": os.path.basename(STAT_TXT_OUT),
        # tepc 는 TRIGP*.chk 를 <맵 디렉터리>\Ctemp 에 쓰고 v5.5 어셈블러는 Path + 파일명으로 읽는다.
        # euddraft 폴더 바로 아래에는 옛 TRIGP 파일이 남아 있어 경로를 틀리면 옛 트리거를 읽는다.
        "CTEMP": EUDDIR + "\\Ctemp\\",
        "BGM_MODULE": os.path.basename(BGM_MODULE),   # eds 옆에 복사해 둔다 (.py 섹션도 eds 기준 상대 경로)
        "BGM_DIR": BGM_DIR + "\\",
    }
    for k, v in fill.items():
        text = text.replace("{{%s}}" % k, v)
    left = re.findall(r"\{\{\w+\}\}", text)
    if left:
        raise SystemExit("eds 틀에 못 채운 자리가 있다: %s" % left)
    with open(dst, "w", encoding="utf-8", newline="\r\n") as f:
        f.write(text)
    print("  eds: 입력 %s\n       출력 %s\n       stat_txt %s\n       음원 %s"
          % (stage1, FINAL, os.path.basename(STAT_TXT_OUT), BGM_DIR))


def verify_bgm(path, sounds):
    """음원이 전부 원래 이름으로, 바이트까지 같게 들어갔는지 본다. 최종 맵은 보호 플러그인 때문에
    (listfile) 이 깨져 있어 목록을 못 읽으므로 이름으로 하나씩 연다. 틀린 파일 이름 목록을 돌려준다."""
    bad = []
    with mpq.Archive(path) as a:
        for name in sounds:
            with open(os.path.join(BGM_DIR, name), "rb") as f:
                try:
                    got = a.read("staredit\\wav\\" + name)
                except OSError:
                    got = None
                if got != f.read():
                    bad.append(name)
    return bad


def run_euddraft(work, stage1, since):
    print("\n=== 2. euddraft")
    stage = os.path.join(work, "eudbuild")
    os.makedirs(stage, exist_ok=True)
    shutil.copy2(BGM_MODULE, stage)      # [MSF_Memory2_BGMInput.py] 는 eds 기준 상대 경로로 찾는다
    shutil.copy2(STAT_TXT_OUT, stage)    # [dataDumper] 도 eds 기준 상대 경로 (write_eds 주석)
    eds = os.path.join(stage, "MSF_Memory2.eds")
    write_eds(eds, stage1)
    cmd = [EUDDRAFT, eds]
    print("  " + " ".join('"%s"' % c if " " in c else c for c in cmd))
    # 오류가 나면 euddraft 가 "Press Enter" 로 멈추므로 표준입력을 막아 둔다.
    r = subprocess.run(cmd, cwd=EUDDIR, timeout=3600, stdin=subprocess.DEVNULL, capture_output=True)
    out = decode(r.stdout + r.stderr)
    with open(os.path.join(work, "euddraft.log"), "w", encoding="utf-8") as f:
        f.write(out)
    print("\n".join("  | " + l for l in out.rstrip().splitlines()[-25:]))
    print("  rc=%d (전체 로그 -> %s)" % (r.returncode, os.path.join(work, "euddraft.log")))
    if r.returncode != 0:
        return r.returncode
    if not os.path.isfile(FINAL) or os.path.getmtime(FINAL) < since:
        print("euddraft 가 %s 를 새로 만들지 않았다 (게임에서 맵을 열어 두었으면 닫고 다시)" % FINAL)
        return 4
    sounds = bgm_files()
    bad = verify_bgm(FINAL, sounds)
    if bad:
        print("오류: 음원 %d개 중 %d개가 최종 맵에 없거나 다르다: %s" % (len(sounds), len(bad), bad[:5]))
        return 7
    print("  음원 %d개가 최종 맵에 원래 이름·내용 그대로 들어감" % len(sounds))
    return 0


def run_cplp(since):
    print("\n=== 3. CPLP")
    cmd = [CPLP, FINAL]
    print("  " + " ".join('"%s"' % c if " " in c else c for c in cmd))
    for attempt in (1, 2):
        r = subprocess.run(cmd, cwd=EUDDIR, timeout=3600, stdin=subprocess.DEVNULL)
        print("  rc=%d" % r.returncode)
        if r.returncode == 0:
            break
        if attempt == 1:
            # DPS·MSF_UE_RE 빌드에서 본 것: CPLP 는 가끔 이유 없이 실패하고(rc=3, 0xC0000409)
            # 같은 입력으로 다시 돌리면 통과한다. euddraft 까지 끝난 빌드를 버리지 않게 한 번만 다시 한다.
            print("  CPLP 실패. 한 번 다시 시도한다.")
            time.sleep(1.0)
    if r.returncode != 0:
        return r.returncode
    if not os.path.isfile(FINAL_OUT) or os.path.getmtime(FINAL_OUT) < since:
        print("CPLP 가 %s 를 새로 만들지 않았다" % FINAL_OUT)
        return 5
    return 0


def main():
    ap = argparse.ArgumentParser(description="MSF_Memory_2 원클릭 빌드 (tepc -> euddraft -> CPLP)")
    ap.add_argument("--tepc-only", action="store_true", help="1단계(tepc)만 돌린다")
    ap.add_argument("--split", action="store_true", help="원본 맵을 기본 맵 + 음원 폴더로 다시 나눈 뒤 빌드")
    args = ap.parse_args()

    started = time.time()
    ensure_base(args.split)
    missing = preflight(args.tepc_only)
    if missing:
        print("빌드를 시작할 수 없다:")
        for m in missing:
            print("  - " + m)
        return 1

    work = os.path.join(os.environ.get("TEMP", "."), "msf_memory2_build")
    shutil.rmtree(work, ignore_errors=True)
    stage1 = os.path.join(work, "stage1.scx")
    rc = compile_tepc(work, stage1)
    if rc != 0:
        return rc
    check_stat_txt(started)
    if args.tepc_only:
        return 0
    rc = run_euddraft(work, stage1, started)
    if rc != 0:
        return rc
    rc = run_cplp(started)
    if rc != 0:
        return rc
    print("\n최종 산출물 (%.0f초)" % (time.time() - started))
    for p in (FINAL, FINAL_OUT):
        print("  %s (%d B)" % (p, os.path.getsize(p)))
    print("  플레이할 맵 = %s" % os.path.basename(FINAL_OUT))
    return 0


if __name__ == "__main__":
    sys.exit(main())
