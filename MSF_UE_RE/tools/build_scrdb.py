#!/usr/bin/env python3
"""MSF_UE_RE 를 SCR_DB 판(오프라인 세이브)으로 빌드한다. SCMDraft·EUD Editor 3 없이, e3s 도 쓰지 않는다.

    build.bat                                          # 더블클릭 = 아래 첫 줄
    python MSF_UE_RE\\tools\\build_scrdb.py            # tepc -> euddraft(+음원) -> CPLP
    python MSF_UE_RE\\tools\\build_scrdb.py --tepc-only
    python MSF_UE_RE\\tools\\split_map.py              # 원본 맵 -> 기본 맵 + 음원 폴더 (맵을 고쳤을 때)

입력 (전부 이 폴더 안이다. 예전에 EUD Editor 3 가 e3s 에서 만들던 build/ 폴더는 2026-09-15 에 없앴다)
  MSF_UE_RE_base.scx      지형·유닛·로케이션. 음원을 뺀 chk 하나짜리 (split_map.py 가 만든다)
  main.lua + *.lua        트리거. EUD Editor 가 하던 dat 패치·버튼셋·요구사항·와이어프레임도 여기 있다
                          (EUDEditorPort.lua 상단 표)
  stat_txt.tbl            영어 원본. EUDEditorStatTxt.lua 의 편집분을 tepc 컴파일 중에 합쳐
                          C:\\euddraft0.9.2.0\\MSF_UE_RE_stat_txt.tbl 로 쓴다 (WriteStatTxtTbl)
  main_scrdb.eps          TE 메인 (칭호·기부 채팅). {{...}} 를 채워 TriggerEditor\\main.eps 로 싣는다
  eds_template.eds        euddraft 설정. {{...}} 자리를 이 스크립트가 채운다 (경로, 입력 동기화 단락, 음원)
  QCInput.lua             입력 동기화 방식(QCInput_Plugin)과 줄의 정본. SNQC_LUA 면 tepc 단계에서 트리거가 되고
                          eds 에는 입력 단락이 없다. SNQC_PY / MSQC 면 여기서 [SNQC] / [MSQC] 단락을 만든다
  C:\\euddraft0.9.2.0\\MSF_UE_RE_BGM\\  음원. MSF_UE_RE_BGMInput.py 가 euddraft 단계에서 넣는다
단계
  1. tepc: 기본 맵에 main.lua 를 컴파일 -> 1단계 맵(작업 폴더). 트리거 본체는 C:\\euddraft0.9.2.0\\Ctemp 의
     TRIGP*.chk 로 가고 euddraft 가 넣는다. stat_txt 합본과 SCR_DB 매니페스트도 이때 써진다.
  2. euddraft: 작업 폴더에 eds 와 TE 파일을 차려 놓고 돌린다 -> 최종 맵. 끝나면 음원이 전부 들어갔는지
     맵을 열어 바이트까지 확인한다.
  3. CPLP: 최종 맵을 보호해서 *_out.scx 를 만든다 (DPS 와 같다. eds 가 freeze: 0 이라 호환).
  끝나면 매니페스트를 런처 배포본이 모으는 곳(DPS_Enhance/tools/manifests)에도 넣는다.
"""
import argparse
import json
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

MSF = os.path.dirname(HERE)
MAPSOURCE = os.path.dirname(MSF)
DOCS = os.path.dirname(MAPSOURCE)
EUDDIR = r"C:\euddraft0.9.2.0"
EUDDRAFT = os.path.join(EUDDIR, "euddraft.exe")
CPLP = os.path.join(EUDDIR, "CustomPlibLockProtector.exe")
CPLP_PLUGIN = os.path.join(EUDDIR, "plugins", "CPLP.py")
# 지형·유닛·로케이션·사운드 목록이 오는 맵. 음원을 뺀 chk 하나짜리다 (tools/split_map.py).
# 음원이 든 원본은 C:\euddraft0.9.2.0\MSF_UE_RE.scx (SCMDraft 로 마지막에 저장한 맵).
BASEMAP = os.path.join(MSF, "MSF_UE_RE_base.scx")
# 음원 폴더와 그걸 맵에 넣는 euddraft 플러그인. theSeed 의 theSeed_BGM + theSeed_BGMInput.py 와 같은 짝.
BGM_DIR = os.path.join(EUDDIR, "MSF_UE_RE_BGM")
BGM_MODULE = os.path.join(MSF, "MSF_UE_RE_BGMInput.py")
SOUND_EXT = (".ogg", ".wav")
EDS_TEMPLATE = os.path.join(MSF, "eds_template.eds")
TE_MAIN = os.path.join(MSF, "main_scrdb.eps")               # -> TriggerEditor\main.eps
QC_INPUT = os.path.join(MSF, "QCInput.lua")
QC_MODES = ("SNQC_LUA", "SNQC_PY", "MSQC")
# SNQC 플러그인 판의 정본과 euddraft 가 읽는 자리 (SNQC_PY 일 때 정본을 복사한다)
SNQC_PY_SRC = os.path.join(MAPSOURCE, "SNQC", "SNQC.py")
SNQC_PY_PLUGIN = os.path.join(EUDDIR, "plugins", "SNQC.py")
FINAL = r"C:\Program Files (x86)\StarCraft\Maps\마린키우기_UnLimit_ExceeD_SCR_DB.scx"
FINAL_OUT = FINAL[:-4] + "_out.scx"      # CPLP 가 새로 쓰는 보호판 = 실제로 플레이할 맵
# TEP3.0_Headless_Compiler 태그 tepc-2026.09.12 (cf3ef0c) 를 2026-09-17 에 WSL MinGW 로 다시 빌드한 것.
# 그 판의 VarStack 은 적층 표식이 붙은 변수에만 걸려서, 이 맵(표식 없음, [STRCtrig Assembler v5.5])은 예전
# tepc_20260905 와 같은 트리거가 나온다 (실행마다 달라지는 6개 트리거 말고는 같음을 확인). 예전 파일은 이 PC 에 없다.
TEPC = os.path.join(DOCS, "theSeed", "tools", "tepc_20260917.exe")
# tepc 가 유닛 이름을 읽는 영어 원본이자 WriteStatTxtTbl() 의 베이스
STAT = os.path.join(MSF, "stat_txt.tbl")
# WriteStatTxtTbl() 이 컴파일 중에 쓰는 합본 (EUDEditorPort.lua 의 StatTxtOutFile 과 같아야 한다)
STAT_TXT_OUT = os.path.join(EUDDIR, "MSF_UE_RE_stat_txt.tbl")
MANIFEST = r"C:\Temp\SCR_DB_manifest_MSF_UE_RE.json"
# SCR_DB MSQC 워드의 최댓값 (레이아웃 7: 토글 비트 18/19 + 꼬리표 16/17 + 페이로드 16비트 = 20비트)
SCRDB_WORD_MAX = 0xFFFFF
LAUNCHER_MANIFESTS = os.path.join(DOCS, "DPS_Enhance", "tools", "manifests")


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
    """MSF_UE_RE_BGMInput.py 가 넣을 파일들 (같은 규칙: 폴더 바로 아래의 .ogg/.wav)."""
    if not os.path.isdir(BGM_DIR):
        return []
    return sorted(f for f in os.listdir(BGM_DIR)
                  if os.path.splitext(f)[1].lower() in SOUND_EXT and os.path.isfile(os.path.join(BGM_DIR, f)))


def preflight(tepc_only, qc):
    """빌드 전에 없으면 안 되는 것들. 빠진 것을 문장 목록으로 돌려준다."""
    need = [(BASEMAP, "기본 맵 (python tools\\split_map.py 로 원본에서 만든다)"),
            (TEPC, "tepc"), (STAT, "stat_txt.tbl (영어 원본)")]
    if qc["mode"] == "SNQC_LUA":
        need.append((os.path.join(MAPSOURCE, "SNQC", "SNQC.lua"), "SNQC CtrigAsm 판"))
    if not tepc_only:
        need += [(EUDDRAFT, "euddraft"), (CPLP, "CustomPlibLockProtector.exe"),
                 (CPLP_PLUGIN, "euddraft 의 [CPLP] 플러그인"), (BGM_MODULE, "음원 플러그인"),
                 (EDS_TEMPLATE, "eds 틀"), (TE_MAIN, "TE 메인 eps")]
        if qc["mode"] == "SNQC_PY":
            need.append((SNQC_PY_SRC, "SNQC 플러그인 판 정본"))
        elif qc["mode"] == "MSQC":
            need.append((os.path.join(EUDDIR, "plugins", "MSQC.py"), "euddraft 의 [MSQC] 플러그인"))
    missing = ["%s 가 없다: %s" % (what, p) for p, what in need if not os.path.isfile(p)]
    if not tepc_only and not bgm_files():
        missing.append("음원 폴더가 없거나 비었다: %s (python tools\\split_map.py)" % BGM_DIR)
    return missing


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


def compile_tepc(work, stage1):
    print("\n=== 1. tepc (main.lua -> %s)" % stage1)
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
    cmd = [os.path.join(work, "tepc.exe"), "in.scx", "editor.lua", stage1,
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


def check_stat_txt(since):
    """WriteStatTxtTbl() 이 이번 컴파일에서 합본을 썼는지. 낡은 파일이 남아 있으면 그걸 싣게 되므로 멈춘다."""
    if not os.path.isfile(STAT_TXT_OUT) or os.path.getmtime(STAT_TXT_OUT) < since:
        raise SystemExit("이번 컴파일이 stat_txt 합본을 쓰지 않았다: %s (EUDEditorPort.lua 의 WriteStatTxtTbl)"
                         % STAT_TXT_OUT)
    d = open(STAT_TXT_OUT, "rb").read()
    n = struct.unpack_from("<H", d, 0)[0]
    print("  stat_txt 합본: %d줄, %d바이트 -> %s" % (n, len(d), STAT_TXT_OUT))


def qc_input():
    """QCInput.lua 에서 입력 동기화 방식과 줄을 읽는다 (그 파일 머리 주석에 적은 모양이어야 한다)."""
    with open(QC_INPUT, "r", encoding="utf-8") as f:
        src = f.read()

    def one(name, pat, flags=re.M):
        m = re.search(r"^%s\s*=\s*%s" % (name, pat), src, flags)
        if not m:
            raise SystemExit("QCInput.lua 에서 %s 를 못 찾았다" % name)
        return m.groups() if len(m.groups()) > 1 else m.group(1)

    mode = one("QCInput_Plugin", r'"(\w+)"')
    if mode not in QC_MODES:
        raise SystemExit("QCInput_Plugin 은 %s 중 하나여야 한다: %s" % (", ".join(QC_MODES), mode))
    block = one("QCInput_Lines", r"\[\[\n?(.*?)\]\]", re.M | re.S)
    return {
        "mode": mode,
        "lines": [l.strip() for l in block.splitlines() if l.strip()],
        "chat_death": one("QCInput_ChatTitleDeath", r"(\d+)"),
        "unit": one("QCInput_ChannelUnit", r"(\d+)"),
        # P1 의 첫 채널 자리 {x, y}
        "xy": one("QCInput_ChannelXY", r"\{\s*(\d+)\s*,\s*(\d+)\s*\}"),
        # 채널 건물을 만드는 플레이어 (0부터)
        "creator": int(one("QCInput_Creator", r"(\d+)")),
    }


def fill_placeholders(text, fill, what):
    for k, v in fill.items():
        text = text.replace("{{%s}}" % k, v)
    left = re.findall(r"\{\{\w+\}\}", text)
    if left:
        raise SystemExit("%s 에 못 채운 자리가 있다: %s" % (what, left))
    return text


def install_snqc_plugin():
    """SNQC_PY: euddraft 의 plugins 폴더에 정본 SNQC.py 를 둔다 (다를 때만 복사)."""
    with open(SNQC_PY_SRC, "rb") as f:
        want = f.read()
    have = None
    if os.path.isfile(SNQC_PY_PLUGIN):
        with open(SNQC_PY_PLUGIN, "rb") as f:
            have = f.read()
    if have != want:
        shutil.copy2(SNQC_PY_SRC, SNQC_PY_PLUGIN)
        print("  SNQC 플러그인 판을 복사함: %s -> %s" % (SNQC_PY_SRC, SNQC_PY_PLUGIN))


def qc_section(doc, qc):
    """eds 의 입력 동기화 단락. SNQC_LUA 는 트리거가 tepc 단계에서 만들어지므로 비운다."""
    if qc["mode"] == "SNQC_LUA":
        return ""
    mc = multicmd_consts()
    body = fill_placeholders("\n".join(qc["lines"]), {
        "CHAT_TITLE_DEATH": qc["chat_death"],
        # 멀티 커맨드 쪽을 보고 있는지(로컬 화면 상태)를 데스값으로 옮기는 줄 (EUDEditorButtonSets.lua 주석)
        "MULTICMD_SET": mc["MultiCmdButtonSetID"],
        "MULTICMD_FLAG_DEATH": mc["MultiCmdFlagDeath"],
    }, "QCInput_Lines")
    addr, death, ch = doc["msqc_addr"], doc["msqc_death"], doc["msqc_channels"]
    # SCR_DB 채널 줄. QCInput.lua 의 QCInput_Install 이 SNQC_LUA 에서 만드는 줄과 같은 식이다
    scrdb = ["Memory(0x%X,AtLeast,1);val, 0x%X: %d" % (addr + 4 * k, addr + 4 * k, death + k) for k in range(ch)]
    if qc["mode"] == "MSQC":
        head = ["[MSQC]", "QCDebug = false"]
    else:
        # Lua 판의 Unit / Creator / XY 와 같은 값 (QCInput_Install)
        head = ["[SNQC]", "SNQCUnit = %s" % qc["unit"], "SNQCCreator = P%d" % (qc["creator"] + 1),
                "SNQC_XY = %s, %s" % qc["xy"]]
    return "\n".join(head + [body] + scrdb) + "\n"


def multicmd_consts():
    """멀티 커맨드 쪽 번호와 MSQC 플래그 데스 칸. 원본은 EUDEditorButtonSets.lua 다 (eds 와 어긋나지 않게 읽어 온다)."""
    src = open(os.path.join(MSF, "EUDEditorButtonSets.lua"), "r", encoding="utf-8").read()
    out = {}
    for name in ("MultiCmdButtonSetID", "MultiCmdFlagDeath"):
        m = re.search(r"^%s\s*=\s*(\d+)" % name, src, re.M)
        if not m:
            raise SystemExit("EUDEditorButtonSets.lua 에서 %s 를 못 찾았다 (eds 의 MSQC 줄을 채울 수 없다)" % name)
        out[name] = m.group(1)
    return out


def write_eds(dst, doc, stage1, qc):
    """eds_template.eds 의 {{...}} 자리를 채운다."""
    with open(EDS_TEMPLATE, "r", encoding="utf-8") as f:
        text = f.read()
    fill = {
        "INPUT": stage1,
        "OUTPUT": FINAL,
        # eds 의 "키 : 값" 줄은 콜론에서 나뉘어 C:\... 를 못 쓴다 (dataDumper 가 'C' 라는 파일을 찾는다).
        # stage_euddraft 가 eds 옆에 복사해 둔 이름만 쓴다 - 예전 EUD Editor eds 의 ..\temp\custom_txt.tbl 와 같은 식.
        "STAT_TXT": os.path.basename(STAT_TXT_OUT),
        # tepc 는 TRIGP*.chk 를 <맵 디렉터리>\Ctemp 에 쓰고 v5.5 어셈블러는 Path + 파일명으로 읽는다.
        # euddraft 폴더 바로 아래에는 2024년 TRIGP 파일이 남아 있어 경로를 틀리면 옛 트리거를 읽는다.
        "CTEMP": EUDDIR + "\\Ctemp\\",
        "QC_SECTION": qc_section(doc, qc),
        "BGM_MODULE": os.path.basename(BGM_MODULE),   # main 이 eds 옆에 복사해 둔다(상대 경로로 찾는다)
        "BGM_DIR": BGM_DIR + "\\",
    }
    text = fill_placeholders(text, fill, "eds 틀")
    with open(dst, "w", encoding="utf-8", newline="\r\n") as f:
        f.write(text)
    addr, death, ch = doc["msqc_addr"], doc["msqc_death"], doc["msqc_channels"]
    if qc["mode"] == "SNQC_LUA":
        what = "입력 단락 없음 (SNQC CtrigAsm 판 - SCR_DB 채널 %d개도 트리거에 있다)" % ch
    else:
        what = "[%s] 단락 + SCR_DB 채널 %d개 (0x%X~ -> 데스 %d~%d)" % (
            "MSQC" if qc["mode"] == "MSQC" else "SNQC", ch, addr, death, death + ch - 1)
    print("  eds: 입출력 경로, stat_txt 합본, %s, 음원 플러그인" % what)


def stage_euddraft(stage, doc, stage1, qc):
    """euddraft 가 읽을 폴더를 차린다: eds + TriggerEditor\\main.eps + 음원 플러그인."""
    te = os.path.join(stage, "TriggerEditor")
    os.makedirs(te)
    with open(TE_MAIN, "r", encoding="utf-8", newline="") as f:
        eps = fill_placeholders(f.read(), {"CHAT_TITLE_DEATH": qc["chat_death"]}, "main_scrdb.eps")
    with open(os.path.join(te, "main.eps"), "w", encoding="utf-8", newline="") as f:
        f.write(eps)
    shutil.copy2(BGM_MODULE, stage)        # [MSF_UE_RE_BGMInput.py] 는 eds 기준 상대 경로로 찾는다
    shutil.copy2(STAT_TXT_OUT, stage)      # [dataDumper] 도 eds 기준 상대 경로 (write_eds 주석)
    eds = os.path.join(stage, "MSF_UE_RE.eds")
    write_eds(eds, doc, stage1, qc)
    return eds


def verify_bgm(path, sounds):
    """음원이 전부 원래 이름으로, 바이트까지 같게 들어갔는지 본다. 틀린 파일 이름 목록을 돌려준다."""
    bad = []
    with mpq.Archive(path) as a:
        for name in sounds:
            with open(os.path.join(BGM_DIR, name), "rb") as f:
                if a.read("staredit\\wav\\" + name) != f.read():
                    bad.append(name)
    return bad


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
            # DPS 빌드에서 본 것: CPLP 는 가끔 이유 없이 실패하고(rc=3, 0xC0000409) 같은 입력으로
            # 다시 돌리면 통과한다. euddraft 까지 끝난 빌드를 버리지 않도록 한 번만 다시 해 본다.
            print("  CPLP 실패. 한 번 다시 시도한다.")
            time.sleep(1.0)
    if r.returncode != 0:
        return r.returncode
    if not os.path.isfile(FINAL_OUT) or os.path.getmtime(FINAL_OUT) < since:
        print("CPLP 가 %s 를 새로 만들지 않았다" % FINAL_OUT)
        return 5
    return 0


def stash_manifest(doc):
    if not os.path.isdir(LAUNCHER_MANIFESTS):
        return
    name = "%s_%08X.json" % (re.sub(r"[^A-Za-z0-9_.-]", "_", doc.get("save_key") or "map"),
                             doc["field_hash"])
    shutil.copy2(MANIFEST, os.path.join(LAUNCHER_MANIFESTS, name))
    print("매니페스트: %s" % os.path.join(LAUNCHER_MANIFESTS, name))


def main():
    global TEPC
    ap = argparse.ArgumentParser(description="MSF_UE_RE SCR_DB 판 헤드리스 빌드")
    ap.add_argument("--tepc-only", action="store_true", help="1단계(tepc)만 돌린다")
    ap.add_argument("--tepc", default=TEPC,
                    help="tepc 실행 파일 (기본: %(default)s). 그 파일이 없는 PC 에서 같은 트리거를 내는 판을 줄 때")
    args = ap.parse_args()
    TEPC = os.path.abspath(args.tepc)
    build_started = time.time()

    qc = qc_input()
    print("입력 동기화: %s (QCInput.lua)" % qc["mode"])
    missing = preflight(args.tepc_only, qc)
    if missing:
        print("빌드를 시작할 수 없다:")
        for m in missing:
            print("  - " + m)
        return 1

    work = os.path.join(os.environ.get("TEMP", "."), "msf_build")
    shutil.rmtree(work, ignore_errors=True)
    stage1 = os.path.join(work, "stage1.scx")
    rc, started = compile_tepc(work, stage1)
    if rc != 0:
        return rc
    doc = read_manifest(started)
    print("  매니페스트: 레이아웃 %s, 항목 %d개, 지문 %08X, 표지 0x%X"
          % (doc["layout_version"], len(doc["fields"]), doc["field_hash"], doc["anchor_eud"]))
    check_stat_txt(started)
    if args.tepc_only:
        return 0

    print("\n=== 2. euddraft")
    if qc["mode"] == "SNQC_PY":
        install_snqc_plugin()
    eds = stage_euddraft(os.path.join(work, "eudbuild"), doc, stage1, qc)
    cmd = [EUDDRAFT, eds]
    print("  " + " ".join('"%s"' % c if " " in c else c for c in cmd))
    # 오류가 나면 euddraft 가 "Press Enter" 로 멈추므로 표준입력을 막아 둔다.
    r = subprocess.run(cmd, cwd=EUDDIR, timeout=3600, stdin=subprocess.DEVNULL, capture_output=True)
    out = decode(r.stdout + r.stderr)
    print(out.rstrip())
    print("  rc=%d" % r.returncode)
    if r.returncode != 0:
        return r.returncode
    # val 줄로 실을 수 있는 크기는 맵 크기에 달렸다. SCR_DB 워드가 안 들어가면 맵은 만들어져도
    # 런처의 워드가 하나도 도착하지 않는다 (레이아웃 6 이 이 맵에서 그렇게 실패했다). 여기서 막는다.
    # SNQC_LUA 는 QCInput_Install 이 tepc 컴파일 중에 같은 검사를 한다 (QCInput_ValueNeed).
    if qc["mode"] != "SNQC_LUA":
        pat = (r"Sendable value range for 'val' syntax: 0 to (\d+)" if qc["mode"] == "MSQC"
               else r"\[SNQC[^\]]*\] map .*value range 0\.\.(\d+)")
        m = re.search(pat, out)
        if not m:
            print("주의: euddraft 출력에서 %s val 범위를 찾지 못했다" % qc["mode"])
        elif int(m.group(1)) < SCRDB_WORD_MAX:
            print("오류: 이 맵의 %s val 범위(0~%s)가 SCR_DB 워드(0~0x%X)보다 작다"
                  % (qc["mode"], m.group(1), SCRDB_WORD_MAX))
            return 3
        else:
            print("  %s val 범위 0~%s >= SCR_DB 워드 0~0x%X" % (qc["mode"], m.group(1), SCRDB_WORD_MAX))
    sounds = bgm_files()
    bad = verify_bgm(FINAL, sounds)
    if bad:
        print("오류: 음원 %d개 중 %d개가 최종 맵에 없거나 다르다: %s" % (len(sounds), len(bad), bad[:5]))
        return 4
    print("  음원 %d개가 최종 맵에 원래 이름·내용 그대로 들어감" % len(sounds))

    rc = run_cplp(build_started)
    if rc != 0:
        return rc
    # 맵이 끝까지 만들어졌을 때만 모은다. 중간에 실패한 빌드의 매니페스트는 쓸 맵이 없다.
    stash_manifest(doc)
    for p in (FINAL, FINAL_OUT):
        print("최종 산출물: %s (%d B)" % (p, os.path.getsize(p)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
