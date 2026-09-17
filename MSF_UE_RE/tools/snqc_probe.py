#!/usr/bin/env python3
"""SNQC 시험판 리더 - 게임 중에 이 PC 의 SNQC 채널 상태를 읽는다 (읽기 전용).

    py -3 tools\\snqc_probe.py            1초마다 표를 다시 찍는다 (Ctrl+C 로 끝)
    py -3 tools\\snqc_probe.py --once

QCInput_DebugAddr 가 켜진 빌드에서만 된다. SNQC.lua 가 매 사이클 채널마다 다음을 그 주소에 복사한다:
    EPD, 머리(01 A A 15), 보낸 수, 고친 수(합치기), 받은 수, 마지막 받은 값,
    채널 건물의 종류(+0x64) / 주인·오더(+0x4C) / 상태(+0xDC) / 랠리(+0xF8) / 좌표(+0x28) / 세대(+0xA4)
    / 이동 상태(+0x97, SNQC Lua 1.3 - 6 = UM_Hidden 이면 시야 갱신에서 빠져 있다)
SCR_DB 런처의 받은 워드 수(표지 블록 MsqcCount)도 같이 보인다.
메모리 리더는 dbg_reader.py 를 쓴다 (SCR_DB 런처와 같은 방식). PC 마다 있는 곳이 달라 아래 후보를 차례로 찾는다:
DPS_Enhance/tools/debugbridge, DPS_eud/tools/debugbridge (eudplib-port 작업 사본), theSeed/diag (같은 파일).
"""
import argparse
import os
import struct
import sys
import time

DOCS = os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
READER_DIRS = [os.path.join(DOCS, *p) for p in (("DPS_Enhance", "tools", "debugbridge"),
                                                ("DPS_eud", "tools", "debugbridge"),
                                                ("theSeed", "diag"))]
for _d in READER_DIRS:
    if os.path.isfile(os.path.join(_d, "dbg_reader.py")):
        sys.path.insert(0, _d)
        break
else:
    sys.exit("dbg_reader.py 를 못 찾았다: " + ", ".join(READER_DIRS))
import dbg_reader as R  # noqa: E402

DBG_ADDR = 0x592100
DBG_MAGIC = (0x514E5344, 0x55424544, 0x31303047, 0x7F4A7C15, 0x2545F491, 0x9E3779B9, 0x85EBCA6B, 0xC2B2AE35)
SCRDB_MAGIC = (0x53435244, 0x425F3031, 0x2F6D61CF, 0xC2B2AE3D, 0x27D4EB2F, 0x165667B1, 0x85EBCA77, 0x9E3779B1)
SCRDB_ANCHOR = 0x593800
FIRST_SCRDB_CHANNEL = 9      # QCInput.lua 줄 순서에서 SCR_DB 채널이 SNQC 몇 번째 채널부터인지 (1부터)
SLOTS = 13                   # 채널 하나의 칸 수 (SNQC.lua 의 DSlots)


def attach():
    pids = R.find_pids("StarCraft.exe")
    if not pids:
        sys.exit("StarCraft.exe 가 없다")
    proc = R.Process(pids[0])
    pat = struct.pack("<8I", *DBG_MAGIC)
    for a in proc.scan(pat, R.WRITABLE):
        return proc, a - DBG_ADDR
    sys.exit("SNQC 디버그 블록을 못 찾았다 (QCInput_DebugAddr 가 켜진 빌드인가, 게임 시작 3초 뒤인가)")


def show(proc, delta):
    def dw(eud, n):
        raw = proc.read(eud + delta, 4 * n)
        return struct.unpack("<%dI" % n, raw) if len(raw) == 4 * n else None

    h = dw(DBG_ADDR, 16)
    nch = h[14]
    body = dw(DBG_ADDR + 64, nch * SLOTS)
    lp = h[11]
    cnt = dw(SCRDB_ANCHOR + 24 * 4, 64)
    print("cycle %d  local P%d  MyValid %d  turn len %d -> %d  channels %d"
          % (h[9], lp + 1, h[10], h[12], h[13], nch))
    print(" ch  EPD     id    sent  merge  recv  lastR     type  own ord status    rally     x    y    gen  mv  scrdb")
    for c in range(nch):
        e = body[c * SLOTS:(c + 1) * SLOTS]
        alpha = (e[1] >> 8) & 0xFFFF
        ownord, pos = e[7], e[10]
        k = c + 1 - FIRST_SCRDB_CHANNEL
        scr = ("%5d" % cnt[k * 8 + lp]) if 0 <= k < 8 and cnt and lp < 8 else "     "
        print("%3d  %6d  %04X  %5d  %5d  %5d  %08X  %4d  P%-2d %3d  %08X  %08X  %4d %4d  %3d  %2d  %s"
              % (c + 1, e[0], alpha, e[2], e[3], e[4], e[5], e[6] & 0xFFFF, (ownord & 0xFF) + 1,
                 (ownord >> 8) & 0xFF, e[8], e[9], pos & 0xFFFF, pos >> 16, (e[11] >> 8) & 0xFF, e[12] >> 24, scr))


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--once", action="store_true")
    args = ap.parse_args()
    proc, delta = attach()
    while True:
        if not args.once:
            os.system("cls")
        show(proc, delta)
        if args.once:
            return
        time.sleep(1.0)


if __name__ == "__main__":
    main()
