#!/usr/bin/env python3
"""MSF_Memory_2 원본 맵을 "음원 없는 기본 맵" 과 "음원 폴더" 로 나눈다 (MSF_UE_RE/tools/split_map.py 와 같다).

    python MSF_Memory_2\\tools\\split_map.py
    python MSF_Memory_2\\tools\\split_map.py --src 다른\\맵.scx

  입력   C:\\euddraft0.9.2.0\\MSF_Memory2.scx        SCMDraft 로 저장한 원본 (음원 641개, 약 79MB)
  출력1  MSF_Memory_2\\MSF_Memory2_base.scx           staredit\\scenario.chk 하나만 든 맵 = tools\\build.py 의 입력
  출력2  C:\\euddraft0.9.2.0\\MSF_Memory2_BGM\\        음원. 빌드 때 MSF_Memory2_BGMInput.py 가 다시 넣는다

tools\\build.py 는 원본이 기본 맵보다 새것이면 이걸 먼저 부른다. 그래서 지형·유닛은 SCMDraft 로 원본을
고쳐 저장만 하면 된다. 음원은 원래 이름(staredit\\wav\\<파일명>) 그대로 다시 들어가므로 트리거의 PlayWAV
문자열과 chk 의 WAV 목록은 그대로 맞는다.
"""
import argparse
import os
import struct
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import mpq  # noqa: E402

HERE = os.path.dirname(os.path.abspath(__file__))
PROJ = os.path.dirname(HERE)
EUDDIR = r"C:\euddraft0.9.2.0"
SRC = os.path.join(EUDDIR, "MSF_Memory2.scx")
BASE = os.path.join(PROJ, "MSF_Memory2_base.scx")
BGM_DIR = os.path.join(EUDDIR, "MSF_Memory2_BGM")
CHK = "staredit\\scenario.chk"
WAV_PREFIX = "staredit\\wav\\"
SOUND_EXT = (".ogg", ".wav")


def chk_sections(chk):
    """이름 -> 내용. 같은 이름이 또 나오면 뒤의 것이 이긴다 (스타 엔진과 같다)."""
    out, i = {}, 0
    while i + 8 <= len(chk):
        name = chk[i:i + 4].decode("latin-1")
        size = struct.unpack_from("<i", chk, i + 4)[0]
        if size < 0:
            break
        out[name] = chk[i + 8:i + 8 + size]
        i += 8 + size
    return out


def wav_list(chk):
    """chk 의 WAV 섹션이 가리키는 문자열들 (맵이 선언한 음원 목록)."""
    sec = chk_sections(chk)
    wav = sec.get("WAV ", b"")
    strx = sec.get("STRx")
    if strx is not None:
        count = struct.unpack_from("<I", strx, 0)[0]
        offs = struct.unpack_from("<%dI" % count, strx, 4)
        table = strx
    else:
        table = sec.get("STR ", b"")
        count = struct.unpack_from("<H", table, 0)[0] if table else 0
        offs = struct.unpack_from("<%dH" % count, table, 2) if count else ()
    names = []
    for k in range(len(wav) // 4):
        sid = struct.unpack_from("<I", wav, 4 * k)[0]
        if 0 < sid <= count:
            o = offs[sid - 1]
            names.append(table[o:table.index(b"\0", o)].decode(mpq.ENC, "replace"))
    return names


def split(src=SRC, base=BASE, bgm=BGM_DIR):
    with mpq.Archive(src) as a:
        names = a.names()
        chk = a.read(CHK)
        if chk is None:
            raise SystemExit("%s 에 %s 가 없다" % (src, CHK))
        sounds, others = [], []
        for n in names:
            low = n.lower()
            if low == CHK or n.startswith("("):
                continue
            if low.startswith(WAV_PREFIX) and "\\" not in n[len(WAV_PREFIX):] \
                    and os.path.splitext(low)[1] in SOUND_EXT:
                sounds.append(n)
            else:
                others.append(n)
        if others:
            # 음원 폴더는 staredit\wav 한 층만 되살린다. 다른 경로의 파일이 있으면 조용히 잃지 말고 멈춘다.
            raise SystemExit("staredit\\wav 밖의 파일이 있다 (BGM 플러그인이 되살리지 못한다): %s" % others[:10])
        print("원본: %s (%d B)\n  (listfile) %d개 = chk 1 + 음원 %d" % (src, os.path.getsize(src), len(names), len(sounds)))

        declared = wav_list(chk)
        have = {s.lower() for s in sounds}
        missing = [w for w in declared if w.lower() not in have]
        print("  chk WAV 목록 %d개, 그중 맵에 없는 것 %d개 %s" % (len(declared), len(missing), missing[:5]))

        os.makedirs(bgm, exist_ok=True)
        wrote = same = total = 0
        kept = set()
        for n in sounds:
            data = a.read(n)
            fname = n[len(WAV_PREFIX):]
            kept.add(fname.lower())
            dst = os.path.join(bgm, fname)
            total += len(data)
            if os.path.isfile(dst) and os.path.getsize(dst) == len(data):
                with open(dst, "rb") as f:
                    if f.read() == data:
                        same += 1
                        continue
            with open(dst, "wb") as f:
                f.write(data)
            wrote += 1
    extra = sorted(f for f in os.listdir(bgm) if f.lower() not in kept)
    print("음원: %s\n  %d개 %.1fMB (새로 씀 %d, 같아서 둠 %d)" % (bgm, len(sounds), total / 1e6, wrote, same))
    if extra:
        print("  주의: 이 맵에 없는 파일이 폴더에 있다 (지우지 않음, 빌드 때 같이 들어간다): %s" % extra[:10])

    tmp = base + ".tmp"
    if os.path.exists(tmp):
        os.remove(tmp)
    with mpq.Archive(tmp, create=True) as b:
        b.write(CHK, chk)
    with mpq.Archive(tmp) as b:
        if b.read(CHK) != chk:
            raise SystemExit("기본 맵을 다시 읽었더니 chk 가 다르다: %s" % tmp)
    os.replace(tmp, base)
    print("기본 맵: %s (%d B, chk %d B)" % (base, os.path.getsize(base), len(chk)))
    return 0


def main():
    ap = argparse.ArgumentParser(description="MSF_Memory_2 맵 -> 음원 없는 기본 맵 + 음원 폴더")
    ap.add_argument("--src", default=SRC)
    ap.add_argument("--base", default=BASE)
    ap.add_argument("--bgm", default=BGM_DIR)
    args = ap.parse_args()
    return split(args.src, args.base, args.bgm)


if __name__ == "__main__":
    sys.exit(main())
