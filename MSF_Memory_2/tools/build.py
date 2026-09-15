"""MSF_Memory_2 원클릭 빌드 — SCMDraft 도 EUD Editor(e3s) 도 쓰지 않는다.

    build.bat 더블클릭                         (= python tools\\build.py)
    python tools\\build.py --tepc-only          1단계(tepc)만 돌린다
    python tools\\build.py --split              원본 맵을 기본 맵 + 음원 폴더로 다시 나눈 뒤 빌드한다
    python tools\\build.py --refresh-data       build/ 를 EUD Editor 가 마지막으로 만든 빌드 데이터로 다시 채운다

  입력 (MSF_UE_RE 와 같은 구성)
    MSF_Memory2_base.scx     지형·유닛·로케이션. 음원을 뺀 chk 하나짜리 (tools\\split_map.py 가 만든다)
    main.lua + *.lua         트리거
    build\\                   EUD Editor 3 가 MSF_Mem_2.e3s 로 만든 빌드 데이터 복사본 (DataEditor.py,
                             ExtraDataEditor.py, RequireData, custom_txt.tbl, eds). 빌드할 때 e3s·EUD Editor 불필요
    C:\\euddraft0.9.2.0\\MSF_Memory2_BGM\\   음원. MSF_Memory2_BGMInput.py 가 euddraft 단계에서 넣는다
  단계
    0. 원본 C:\\euddraft0.9.2.0\\MSF_Memory2.scx 가 기본 맵보다 새것이면 먼저 나눈다 (split_map.py).
       그래서 지형·유닛은 SCMDraft 로 원본을 고쳐 저장만 하면 된다 (SCMDraft 에서 트리거 컴파일은 필요 없다).
    1. tepc     main.lua -> 트리거. TRIGP*.chk 는 C:\\euddraft0.9.2.0\\Ctemp.
    2. euddraft build\\ 의 eds 에서 입출력만 이번 빌드로 바꾸고 음원 플러그인을 붙여 돌린다.
                끝나면 음원이 전부 원래 이름·내용 그대로 들어갔는지 맵을 열어 확인한다.
    3. CPLP     보호판 *_out.scx 를 만든다 = 실제로 플레이할 맵.

  EUD Editor 데이터(유닛 스탯·버튼·요구조건·tbl)를 고칠 때만: EUD Editor 로 한 번 빌드한 뒤 --refresh-data.
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
BUILD = os.path.join(PROJ, "build")
EUDDIR = r"C:\euddraft0.9.2.0"
EUDDRAFT = os.path.join(EUDDIR, "euddraft.exe")
CPLP = os.path.join(EUDDIR, "CustomPlibLockProtector.exe")
SRCMAP = split_map.SRC                              # SCMDraft 로 저장한 원본 (음원 포함)
BASEMAP = split_map.BASE                            # 음원을 뺀 chk 하나짜리 = tepc 입력
BGM_DIR = split_map.BGM_DIR
BGM_MODULE = os.path.join(PROJ, "MSF_Memory2_BGMInput.py")
SOUND_EXT = split_map.SOUND_EXT
# EUD Editor 가 만들던 출력 이름을 그대로 쓴다 (e3s 의 eds 와 같다).
FINAL = r"C:\Program Files (x86)\StarCraft\Maps\마린키우기_Memory2_Test.scx"
FINAL_OUT = FINAL[:-4] + "_out.scx"                 # CPLP 가 새로 쓰는 보호판 = 실제로 플레이할 맵
TEPC = os.path.join(DOCS, "theSeed", "tools", "tepc_20260905.exe")
STAT = os.path.join(DOCS, "theSeed", "stat_txt.tbl")
# EUD Editor 3.0.12.8.1 이 MSF_Mem_2.e3s 로 빌드할 때 쓰는 임시 폴더 (--refresh-data 의 원본).
EUD_EDITOR_DATA = r"C:\Users\USER\Desktop\맵제작 자료\EUD.Editor.3.0.12.8.1\Data\temp\BuildData_MSF_Mem_2"
# 이 맵의 eds 에는 TE 메인(main.eps)이 없어 SCA 를 쓰지 않는다. EUD Editor 가 늘 복사해 두는 SCA 라이브러리는 뺀다.
SCA_LIBS = {"SCArchive", "SCATool", "SCAFastLoader", "SCAScript", "SCAScriptReturn",
            "SCALuaWrapper", "SCAWrapper", "SCAFlexible"}
SKIP_DIRS = {"__pycache__", "__epspy__", "backup"}


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
    need = [(BASEMAP, "기본 맵 (python tools\\split_map.py)"), (TEPC, "tepc"), (STAT, "stat_txt.tbl"),
            (os.path.join(PROJ, "main.lua"), "main.lua")]
    if not tepc_only:
        need += [(EUDDRAFT, "euddraft"), (CPLP, "CustomPlibLockProtector.exe"), (BGM_MODULE, "음원 플러그인"),
                 (os.path.join(BUILD, "eudplibData", "EUDEditor.eds"),
                  "build 데이터 (python tools\\build.py --refresh-data)")]
    missing = ["%s 가 없다: %s" % (what, p) for p, what in need if not os.path.isfile(p)]
    if not tepc_only and not bgm_files():
        missing.append("음원 폴더가 없거나 비었다: %s (python tools\\split_map.py)" % BGM_DIR)
    return missing


def refresh_data():
    """EUD Editor 의 임시 빌드 폴더 -> build/ (SCA 라이브러리·캐시·e3s 백업 제외)."""
    src_eds = os.path.join(EUD_EDITOR_DATA, "eudplibData", "EUDEditor.eds")
    if not os.path.isfile(src_eds):
        raise SystemExit("EUD Editor 빌드 데이터가 없다: %s\n  EUD Editor 3 로 MSF_Mem_2.e3s 를 한 번 빌드하면 생긴다."
                         % src_eds)
    tmp = BUILD + ".tmp"
    shutil.rmtree(tmp, ignore_errors=True)
    copied = []
    for sub in ("eudplibData", "temp"):
        for root, dirs, files in os.walk(os.path.join(EUD_EDITOR_DATA, sub)):
            dirs[:] = [d for d in dirs if d not in SKIP_DIRS]
            for f in files:
                if os.path.splitext(f)[0] in SCA_LIBS or f.endswith(".pyc"):
                    continue
                s = os.path.join(root, f)
                rel = os.path.relpath(s, EUD_EDITOR_DATA)
                d = os.path.join(tmp, rel)
                os.makedirs(os.path.dirname(d), exist_ok=True)
                shutil.copy2(s, d)
                copied.append(rel)
    # 뺀 SCA 라이브러리를 누가 부르면 빌드가 깨진다. 남은 파일에 이름이 보이면 멈춘다.
    pat = re.compile(r"\b(%s)\b" % "|".join(sorted(SCA_LIBS)))
    for rel in copied:
        with open(os.path.join(tmp, rel), "rb") as f:
            m = pat.search(decode(f.read()))
        if m:
            shutil.rmtree(tmp, ignore_errors=True)
            raise SystemExit("%s 가 SCA 라이브러리 %s 를 부른다 - SCA_LIBS 에서 빼고 다시 하라" % (rel, m.group(1)))
    shutil.rmtree(BUILD, ignore_errors=True)
    os.replace(tmp, BUILD)
    print("build/ 새로 채움 (%s)\n  %d개: %s" % (EUD_EDITOR_DATA, len(copied), ", ".join(sorted(copied))))


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


def write_eds(eds, stage1):
    """EUD Editor 가 만든 eds 에서 입출력만 이번 빌드로 바꾸고 음원 플러그인을 붙인다.
    STRCtrig 는 v5.5 + Ctemp 로 맞춘다."""
    with open(eds, "r", encoding="utf-8", errors="replace") as f:
        lines = f.read().splitlines()
    out, section = [], ""
    for ln in lines:
        low = ln.strip().lower()
        if low.startswith("[") and low.endswith("]"):
            section = low
            if low.startswith("[strctrig assembler v5.4]"):
                out.append("[STRCtrig Assembler v5.5]")   # CtrigAsm v5.5 가 만든 TRIGP 청크는 v5.5 가 읽는다
                continue
        if section.startswith("[strctrig assembler") and low.startswith("path"):
            out.append("Path : %s\\Ctemp\\" % EUDDIR)       # tepc 는 TRIGP*.chk 를 <맵 디렉터리>\Ctemp 에 쓴다
            continue
        if section == "[main]" and low.startswith("input:"):
            out.append("input: " + stage1)
            continue
        if section == "[main]" and low.startswith("output:"):
            out.append("output: " + FINAL)
            continue
        out.append(ln)
    while out and not out[-1].strip():
        out.pop()
    if not any(l.strip().lower() == "[cplp]" for l in out):
        out.append("[CPLP]")
    # 음원 플러그인 (run_euddraft 가 eds 옆에 복사해 둔다. euddraft 는 .py 섹션을 eds 기준 상대 경로로 찾는다)
    out += ["[%s]" % os.path.basename(BGM_MODULE), "Path : %s\\" % BGM_DIR]
    with open(eds, "w", encoding="utf-8", newline="\r\n") as f:
        f.write("\n".join(out) + "\n")
    print("  eds: 입력 %s\n       출력 %s\n       음원 %s" % (stage1, FINAL, BGM_DIR))


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
    shutil.copytree(BUILD, stage)
    eds_dir = os.path.join(stage, "eudplibData")
    shutil.copy2(BGM_MODULE, eds_dir)
    eds = os.path.join(eds_dir, "EUDEditor.eds")
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
    ap.add_argument("--refresh-data", action="store_true",
                    help="build/ 를 EUD Editor 가 마지막으로 만든 빌드 데이터로 다시 채우고 끝낸다")
    args = ap.parse_args()
    if args.refresh_data:
        refresh_data()
        return 0

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
    if rc != 0 or args.tepc_only:
        return rc
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
