#!/usr/bin/env python3
"""MSF_UE_RE 를 SCR_DB 판(오프라인 세이브)으로 빌드한다. SCMDraft·EUD Editor GUI 없이.

    py -3.10 MSF_UE_RE\\tools\\build_scrdb.py            # tepc -> euddraft
    py -3.10 MSF_UE_RE\\tools\\build_scrdb.py --regen    # e3s 에서 build/ 를 다시 만든 뒤 빌드
    py -3.10 MSF_UE_RE\\tools\\build_scrdb.py --tepc-only

단계
  0. (--regen 이거나 build/ 가 없으면) EudGen: MSF_UE_RE.e3s -> build/eudplibData
     EUD Editor 3 의 생성기를 GUI 없이 돌린다(tools/EudGenMsf.cs). SCA 를 끄고 TE 메인 파일을
     main_scrdb.eps 로 바꾼다. e3s 는 건드리지 않는다.
  1. tepc: 원본 맵(C:\\euddraft0.9.2.0\\MSF_UE_RE.scx)에 main.lua 를 컴파일 -> 1단계 맵.
     트리거 본체는 C:\\euddraft0.9.2.0\\Ctemp 의 TRIGP*.chk 로 가고 euddraft 가 넣는다.
  2. euddraft: build/eudplibData/EUDEditor.eds 를 이 빌드에 맞게 고쳐서 돌린다 -> 최종 맵.
     입출력 경로, STRCtrig 어셈블러 v5.4 -> v5.5(라이브러리가 v5.5), SCR_DB 전용 MSQC 채널 8줄.
  끝나면 매니페스트를 런처 배포본이 모으는 곳(DPS_Enhance/tools/manifests)에도 넣는다.

예전 GUI 빌드는 SCMDraft(TEP) -> CS_STRConverter -> EUD Editor 3 였다. CS_STRConverter 는
STR/STRx 문자열 구역 변환기인데, tepc 는 cflag 1 에서 STRx 로 쓰므로 필요 없는지 빌드로 확인한다.
"""
import argparse
import glob
import json
import os
import re
import shutil
import struct
import subprocess
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
MSF = os.path.dirname(HERE)
MAPSOURCE = os.path.dirname(MSF)
DOCS = os.path.dirname(MAPSOURCE)
BUILD = os.path.join(MSF, "build")
E3S = os.path.join(MSF, "MSF_UE_RE.e3s")
MAIN_EPS = os.path.join(MSF, "main_scrdb.eps")
EUD_EDITOR = r"C:\Users\USER\Desktop\EUD.Editor.3.0.19.6.0"
EUDDIR = r"C:\euddraft0.9.2.0"
EUDDRAFT = os.path.join(EUDDIR, "euddraft.exe")
# SCMDraft 로 마지막에 저장한 맵(2024-03-23). 지형·유닛·로케이션·사운드가 여기서 온다.
BASEMAP = os.path.join(EUDDIR, "MSF_UE_RE.scx")
STAGE1 = os.path.join(EUDDIR, "MSF_UE_RE_SCRDB_stage1.scx")
FINAL = r"C:\Program Files (x86)\StarCraft\Maps\마린키우기_UnLimit_ExceeD_SCR_DB.scx"
TEPC = os.path.join(DOCS, "theSeed", "tools", "tepc_20260905.exe")
STAT = os.path.join(DOCS, "theSeed", "stat_txt.tbl")
MANIFEST = r"C:\Temp\SCR_DB_manifest_MSF_UE_RE.json"
# SCR_DB MSQC 워드의 최댓값 (레이아웃 7: 토글 비트 18/19 + 꼬리표 16/17 + 페이로드 16비트 = 20비트)
SCRDB_WORD_MAX = 0xFFFFF
LAUNCHER_MANIFESTS = os.path.join(DOCS, "DPS_Enhance", "tools", "manifests")
# EUD Editor 가 GUI 빌드 때 build 폴더로 복사해 넣는 TE 라이브러리. SCA 것은 쓰지 않는다.
TE_LIB = os.path.join(EUD_EDITOR, "Data", "TriggerEditor")
SCA_LIBS = {"SCArchive", "SCATool", "SCAFastLoader", "SCAScript", "SCAScriptReturn",
            "SCALuaWrapper", "SCAWrapper"}


def lua_str(s):
    return s.replace("\\", "\\\\")


def decode(b):
    for enc in ("utf-8", "cp949"):
        try:
            return b.decode(enc)
        except UnicodeDecodeError:
            pass
    return b.decode("utf-8", "replace")


def regen():
    """e3s -> build/ (eudplibData + temp). EUD Editor 3 이 이 PC 에 있어야 한다."""
    out = os.path.join(os.environ.get("TEMP", "."), "msf_eudgen")
    shutil.rmtree(out, ignore_errors=True)
    os.makedirs(out)
    cmd = ["powershell", "-NoProfile", "-ExecutionPolicy", "Bypass", "-File",
           os.path.join(HERE, "run_eudgen.ps1"),
           "-EudDir", EUD_EDITOR, "-E3s", E3S, "-Out", out, "-MainEps", MAIN_EPS,
           "-Open", BASEMAP, "-Save", os.path.join(EUDDIR, "MSF_UE_RE_eudgen.scx")]
    print("=== 0. EudGen (e3s -> eudplibData)")
    r = subprocess.run(cmd, capture_output=True, timeout=600)
    print(decode(r.stdout + r.stderr).rstrip())
    found = glob.glob(os.path.join(out, "**", "EUDEditor.eds"), recursive=True)
    if not found:
        raise SystemExit("EudGen 이 EUDEditor.eds 를 만들지 못했다 (위 로그 참고)")
    src = os.path.dirname(os.path.dirname(found[0]))      # .../BuildData_x (eudplibData 의 부모)
    shutil.rmtree(BUILD, ignore_errors=True)
    shutil.copytree(src, BUILD, ignore=shutil.ignore_patterns("*.dll"))
    dst = os.path.join(BUILD, "eudplibData", "TriggerEditor", "TriggerEditor")
    os.makedirs(dst, exist_ok=True)
    copied = []
    for p in sorted(glob.glob(os.path.join(TE_LIB, "*"))):
        stem = os.path.splitext(os.path.basename(p))[0]
        if os.path.isfile(p) and stem not in SCA_LIBS:
            shutil.copy2(p, os.path.join(dst, os.path.basename(p)))
            copied.append(os.path.basename(p))
    print("  build/ 새로 채움 (%s). TE 라이브러리 %d개: %s" % (src, len(copied), ", ".join(copied)))
    scaflex = os.path.join(BUILD, "eudplibData", "TriggerEditor", "SCAFlexible.eps")
    if os.path.isfile(scaflex) and os.path.getsize(scaflex) == 0:
        os.remove(scaflex)                             # SCA 를 껐으니 쓰이지 않는 빈 파일


def scmd_unit_names():
    """SCMDraft 가 쓰는 유닛 이름 -> ID (부제가 붙는 것만).

    stat_txt.tbl 의 유닛 항목은 '이름\\0부제\\0분류' 다 (예: 'Edmund Duke\\0Siege Mode\\0Heroes').
    SCMDraft 는 부제가 '*' 가 아니면 '이름 (부제)' 로 만들어 이름이 겹치지 않게 한다(TEP 의
    SCMDPlugin.h: "char*[228] with non identical unit names"). 그런데 tepc 는 앞부분만 읽어서
    (headless/host/engine_data.cpp load_stat_txt) 'Edmund Duke (Siege Mode)' 를 모르고, 23번과 25번이
    둘 다 'Edmund Duke' 가 된다. 이 맵은 그런 이름을 약 1000곳에서 쓴다.
    """
    d = open(STAT, "rb").read()
    n = struct.unpack_from("<H", d, 0)[0]
    offs = struct.unpack_from("<%dH" % n, d, 2)
    out = {}
    for i in range(228):
        parts = d[offs[i]:].split(b"\0", 2)
        if len(parts) >= 2 and parts[1] not in (b"", b"*"):
            out[(parts[0] + b" (" + parts[1] + b")").decode("latin-1")] = i
    return out


def compile_tepc(work):
    print("\n=== 1. tepc (main.lua -> %s)" % STAGE1)
    os.makedirs(work, exist_ok=True)
    shutil.copy2(TEPC, os.path.join(work, "tepc.exe"))     # tepc 는 제 옆에 임시 chk 를 쓴다
    shutil.copy2(BASEMAP, os.path.join(work, "in.scx"))
    # cflag 1(loaderscript)은 EndCtrig 이 맵 디렉터리 설정을 요구한다(MapSource/Bootstrap.lua 주석).
    # 윈도우 GUI 에서는 TEP 편집기 본문이 하던 일이다. main.lua 는 스스로 Library 와 제 폴더를 읽는다.
    # ParseUnit 앞에 SCMDraft 식 이름표를 끼운다 (scmd_unit_names 설명). 전역 ParseUnit 은 이미 있는
    # 키라 basescript 의 __newindex(소문자로 눕히기)를 거치지 않고 그대로 바뀐다. 표에 없는 이름은
    # 원래 ParseUnit 이 맵의 사용자 유닛 이름까지 포함해 그대로 처리한다.
    names = scmd_unit_names()
    lines = ['__MapDirSetting("%s")' % lua_str(EUDDIR), "local SCMDUnit = {"]
    for k, v in sorted(names.items(), key=lambda kv: kv[1]):
        lines.append('\t["%s"] = %d,' % (k.replace("\\", "\\\\").replace('"', '\\"'), v))
    lines += ["}",
              "local NativeParseUnit = ParseUnit",
              "function ParseUnit(Unit)",
              "\tif type(Unit) == \"string\" and SCMDUnit[Unit] ~= nil then return SCMDUnit[Unit] end",
              "\treturn NativeParseUnit(Unit)",
              "end",
              'dofile("%s")' % lua_str(os.path.join(MSF, "main.lua")),
              ""]
    with open(os.path.join(work, "editor.lua"), "w", encoding="utf-8", newline="") as f:
        f.write("\r\n".join(lines))
    print("  SCMDraft 식 유닛 이름 %d개를 ParseUnit 앞에 끼움" % len(names))
    cmd = [os.path.join(work, "tepc.exe"), "in.scx", "editor.lua", STAGE1,
           "--cflag", "1", "--stat-txt", STAT]
    started = time.time()
    r = subprocess.run(cmd, cwd=work, capture_output=True, timeout=3600)
    log = decode(r.stdout + r.stderr)
    with open(os.path.join(work, "tepc.log"), "w", encoding="utf-8") as f:
        f.write(log)
    lines = log.splitlines()
    print("  rc=%d (%.1f초, 로그 %d줄 -> %s)" % (r.returncode, time.time() - started, len(lines),
                                              os.path.join(work, "tepc.log")))
    print("\n".join("  | " + l for l in lines[-25:]))
    return r.returncode, started


def read_manifest(since):
    if not os.path.isfile(MANIFEST) or os.path.getmtime(MANIFEST) < since:
        raise SystemExit("이번 컴파일이 매니페스트를 쓰지 않았다: %s" % MANIFEST)
    with open(MANIFEST, "r", encoding="utf-8") as f:
        return json.load(f)


def write_eds(src, dst, doc):
    """EUD Editor 가 만든 eds 를 이 빌드에 맞게 고친다."""
    addr, death, ch = doc["msqc_addr"], doc["msqc_death"], doc["msqc_channels"]
    msqc = ["Memory(0x%X,AtLeast,1);val, 0x%X: %d" % (addr + 4 * k, addr + 4 * k, death + k)
            for k in range(ch)]
    with open(src, "r", encoding="utf-8", errors="replace") as f:
        lines = f.read().splitlines()
    out, section, injected = [], "", False
    for ln in lines:
        low = ln.strip().lower()
        if low.startswith("[") and low.endswith("]"):
            # [MSQC] 를 빠져나가기 직전에 붙인다. 원래 있던 키 바인딩·val 줄은 건드리지 않는다.
            if section == "[msqc]" and not injected:
                out.extend(msqc)
                injected = True
            section = low
            if low.startswith("[strctrig assembler v5.4]"):
                # 라이브러리(CtrigAsm v5.5)가 만드는 TRIGP 청크는 v5.5 어셈블러가 읽는다.
                out.append("[STRCtrig Assembler v5.5]")
                continue
        if section.startswith("[strctrig assembler") and low.startswith("path"):
            # tepc 는 TRIGP*.chk 를 <맵 디렉터리>\Ctemp 에 쓰고 v5.5 어셈블러는 Path + 파일명으로 읽는다
            # (DPS 의 eds 와 같다). e3s 의 Path 는 v5.4 시절 값(euddraft 폴더 바로 아래)이라, 그대로
            # 두면 그 자리에 남아 있던 2024년 TRIGP 파일을 읽거나 못 찾는다.
            out.append("Path : %s\\Ctemp\\" % EUDDIR)
            continue
        if low.startswith("input:"):
            out.append("input: " + STAGE1)
            continue
        if low.startswith("output:"):
            out.append("output: " + FINAL)
            continue
        out.append(ln)
    if section == "[msqc]" and not injected:
        out.extend(msqc)
        injected = True
    if not injected:
        raise SystemExit("eds 에 [MSQC] 섹션이 없다")
    leftovers = [l for l in out if re.search(r"scarchive|scaflexible|scatool", l, re.I)]
    if leftovers:
        raise SystemExit("eds 에 SCA 흔적이 남았다: %s" % leftovers[:3])
    with open(dst, "w", encoding="utf-8", newline="\r\n") as f:
        f.write("\n".join(out) + "\n")
    print("  eds: 입출력 경로 교체, SCR_DB MSQC 채널 %d개 (0x%X~ -> 데스 %d~%d)"
          % (ch, addr, death, death + ch - 1))


def stash_manifest(doc):
    if not os.path.isdir(LAUNCHER_MANIFESTS):
        return
    name = "%s_%08X.json" % (re.sub(r"[^A-Za-z0-9_.-]", "_", doc.get("save_key") or "map"),
                             doc["field_hash"])
    shutil.copy2(MANIFEST, os.path.join(LAUNCHER_MANIFESTS, name))
    print("매니페스트: %s" % os.path.join(LAUNCHER_MANIFESTS, name))


def main():
    ap = argparse.ArgumentParser(description="MSF_UE_RE SCR_DB 판 헤드리스 빌드")
    ap.add_argument("--regen", action="store_true", help="e3s 에서 build/ 를 다시 만든다 (EUD Editor 3 필요)")
    ap.add_argument("--tepc-only", action="store_true", help="1단계(tepc)만 돌린다")
    args = ap.parse_args()

    if args.regen or not os.path.isfile(os.path.join(BUILD, "eudplibData", "EUDEditor.eds")):
        regen()

    work = os.path.join(os.environ.get("TEMP", "."), "msf_build")
    shutil.rmtree(work, ignore_errors=True)
    rc, started = compile_tepc(work)
    if rc != 0:
        return rc
    doc = read_manifest(started)
    print("  매니페스트: 레이아웃 %s, 항목 %d개, 지문 %08X, 표지 0x%X"
          % (doc["layout_version"], len(doc["fields"]), doc["field_hash"], doc["anchor_eud"]))
    if args.tepc_only:
        return 0

    print("\n=== 2. euddraft")
    stage = os.path.join(work, "eudbuild")
    shutil.copytree(BUILD, stage)
    eds = os.path.join(stage, "eudplibData", "EUDEditor.eds")
    write_eds(eds, eds, doc)
    cmd = [EUDDRAFT, eds]
    print("  " + " ".join('"%s"' % c if " " in c else c for c in cmd))
    # 오류가 나면 euddraft 가 "Press Enter" 로 멈추므로 표준입력을 막아 둔다.
    r = subprocess.run(cmd, cwd=EUDDIR, timeout=3600, stdin=subprocess.DEVNULL, capture_output=True)
    out = decode(r.stdout + r.stderr)
    print(out.rstrip())
    print("  rc=%d" % r.returncode)
    if r.returncode != 0:
        return r.returncode
    # MSQC 의 val 로 실을 수 있는 크기는 맵 크기에 달렸다. SCR_DB 워드가 안 들어가면 맵은 만들어져도
    # 런처의 워드가 하나도 도착하지 않는다 (레이아웃 6 이 이 맵에서 그렇게 실패했다). 여기서 막는다.
    m = re.search(r"Sendable value range for 'val' syntax: 0 to (\d+)", out)
    if not m:
        print("주의: euddraft 출력에서 MSQC val 범위를 찾지 못했다")
    elif int(m.group(1)) < SCRDB_WORD_MAX:
        print("오류: 이 맵의 MSQC val 범위(0~%s)가 SCR_DB 워드(0~0x%X)보다 작다" % (m.group(1), SCRDB_WORD_MAX))
        return 3
    else:
        print("  MSQC val 범위 0~%s >= SCR_DB 워드 0~0x%X" % (m.group(1), SCRDB_WORD_MAX))
    if os.path.isfile(FINAL):
        print("최종 산출물: %s (%d B)" % (FINAL, os.path.getsize(FINAL)))
    stash_manifest(doc)
    return 0


if __name__ == "__main__":
    sys.exit(main())
