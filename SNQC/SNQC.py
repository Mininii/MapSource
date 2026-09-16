#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SNQC - Sana Natori QueueCommand (euddraft 플러그인 판)

MSQC(Murakami Shiina QueueCommand, plugins/MSQC.py)를 대신하는 "로컬 입력 → 모든 PC 동기화" 플러그인.
.eds 의 [SNQC] 단락은 [MSQC] 와 같은 줄 문법을 쓴다 - 단락 이름만 바꾸면 그대로 옮겨진다.
설계·실측 근거: MapSource/SNQC/DESIGN.md. CtrigAsm(Lua) 판은 MapSource/SNQC/SNQC.lua. 작업 내역: HISTORY.md.
정본은 MapSource/SNQC/SNQC.py - euddraft 에서 쓰려면 C:/euddraft0.9.2.0/plugins/SNQC.py 로 복사한다.

무엇이 다른가
  MSQC  : 숨긴 비행 건물(QC 유닛)에 Move 를 보내 이동 목표 좌표에 싣는다.
          스타가 150프레임마다 그 Move 를 다시 시작시켜 그 사이클 값이 사라진다.
  SNQC  : 건설크기 (1,0) 으로 가린 커맨드센터(채널 건물)의 **랠리 좌표**에 싣는다 (오더 40).
          - 엔진이 랠리 칸을 스스로 바꾸지 않는다 → 주기적 소실 없음
          - 받는 쪽이 매 사이클 칸을 (0,0) 으로 되돌린다 → 같은 값을 두 번 보내도 두 번 받는다
          - 안 보이고 안 골라지는데 명령은 받는다
          (2026-09-17 SC:R 실측, DESIGN.md "실측")

.eds 설정 (전부 생략 가능)
  SNQCUnit      = 106          채널 건물 종류. 랠리를 받는 12종 중 맵에서 안 쓰는 것 (종류 전체의 units.dat 를 고친다)
                               QCUnit 도 받지만 12종이 아니면 무시하고 106 을 쓴다 (MSQC 의 QC 유닛은 보통 12종이 아니다)
  SNQCPlayer    = P11          채널 건물을 넘겨 둘 플레이어 (QCPlayer 도 받음)
  SNQCLoc       = 0            만들 때 잠깐 쓰는 로케이션 (QCLoc 도 받음). 쓰고 나면 되돌린다
  SNQC_XY       = 128, 128     첫 채널 자리 (QC_XY 도 받음). 채널마다 x 로 32, 플레이어마다 y 로 32 씩 (맵 끝이면 반대 방향)
  SNQCBuildSize = 1, 0         건설크기(픽셀) - (1,0)/(0,1)/(0,0) 이 가려진다
  SNQCMerge     = true         아직 안 나간 자기 패킷이 버퍼에 있으면 좌표만 고친다 (키 = 비트 합치기, 값 = 덮어쓰기)
  SNQCBufferLimit = 400        턴 버퍼가 이보다 길면 붙이지 않는다
  QCDebug       = true         채널 건물이 없어졌는지 34사이클마다 보고 다시 만든다 (SNQCDebug / QCSafety 도 받음)

줄 문법 (MSQC 와 같다)
  조건;조건;... = 데스유닛, 더할값           키 줄. 받은 사이클에 그 플레이어 데스값 += 더할값 (매 사이클 0 에서 시작)
  조건;val, 주소 : 데스유닛                  값 줄. 받은 사이클에 데스값 = 값 (0 ~ 출력되는 범위)
  조건;xy, 주소 : 데스유닛                   좌표 줄 (주소의 dword 가 x | y<<16)
  조건;xy, 주소X, 주소Y : 데스X, 데스Y        좌표 줄
  mouse : 로케이션                           마우스 맵 좌표 → (로케이션 + 플레이어 번호) 로 옮김, 움직였을 때만
  조건: KeyDown(k) KeyUp(k) KeyPress(k) MouseDown(b) MouseUp(b) MousePress(b) NotTyping k(= KeyDown)
        0x주소,비교,값  0x주소,마스크  그 밖의 eudplib 조건식
  결과 자리에 EUDArray 이름을 쓰면 데스값 대신 그 배열[플레이어] 에 쓴다 (MSQC 와 같음)

확인 (2026-09-17): theSeed 싱글·LAN 2인(64비트+32비트) 인게임 통과 - 150프레임 소실 없음, 디싱크 없음.
  합치기(턴이 여러 사이클인 방)·버퍼 한계는 아직 (DESIGN.md "확인 목록").
"""
import re
from math import ceil

from eudplib import *

# fmt: off
SNQCUnit, SNQCPlayer, SNQCLoc = 106, 10, 0
SNQC_X, SNQC_Y = 128, 128
BuildW, BuildH = 1, 0
UseMerge, QCDebug = True, True
BufferLimit, CheckInterval = 400, 34
RALLY_ORDER = 40
FACTORY_UNITS = {106, 111, 113, 114, 130, 131, 132, 133, 154, 155, 160, 167}

key_lines, val_lines, deathsUnits = [], [], set()   # key_lines: (conds, ret) / val_lines: (conds, ret)

KeyArray, KeyOffset = EUDArray(8), set()
MouseArray, MouseOffset = EUDArray(1), set()

MouseButtonDict = {"L": 2, "LEFT": 2, "R": 8, "RIGHT": 8, "M": 32, "MIDDLE": 32}
KeyCodeDict = {
    'LBUTTON': 0x01, 'RBUTTON': 0x02, 'CANCEL': 0x03, 'MBUTTON': 0x04,
    'XBUTTON1': 0x05, 'XBUTTON2': 0x06, 'BACK': 0x08, 'TAB': 0x09,
    'CLEAR': 0x0C, 'ENTER': 0x0D, 'NX5': 0x0E, 'SHIFT': 0x10,
    'LCTRL': 0x11, 'LALT': 0x12, 'PAUSE': 0x13, 'CAPSLOCK': 0x14,
    'RALT': 0x15, 'JUNJA': 0x17, 'FINAL': 0x18, 'RCTRL': 0x19, 'ESC': 0x1B,
    'CONVERT': 0x1C, 'NONCONVERT': 0x1D, 'ACCEPT': 0x1E, 'MODECHANGE': 0x1F,
    'SPACE': 0x20, 'PGUP': 0x21, 'PGDN': 0x22, 'END': 0x23, 'HOME': 0x24,
    'LEFT': 0x25, 'UP': 0x26, 'RIGHT': 0x27, 'DOWN': 0x28,
    'SELECT': 0x29, 'PRINTSCREEN': 0x2A, 'EXECUTE': 0x2B, 'SNAPSHOT': 0x2C,
    'INSERT': 0x2D, 'DELETE': 0x2E, 'HELP': 0x2F,
    '0': 0x30, '1': 0x31, '2': 0x32, '3': 0x33, '4': 0x34,
    '5': 0x35, '6': 0x36, '7': 0x37, '8': 0x38, '9': 0x39,
    'A': 0x41, 'B': 0x42, 'C': 0x43, 'D': 0x44, 'E': 0x45, 'F': 0x46,
    'G': 0x47, 'H': 0x48, 'I': 0x49, 'J': 0x4A, 'K': 0x4B, 'L': 0x4C,
    'M': 0x4D, 'N': 0x4E, 'O': 0x4F, 'P': 0x50, 'Q': 0x51, 'R': 0x52,
    'S': 0x53, 'T': 0x54, 'U': 0x55, 'V': 0x56, 'W': 0x57, 'X': 0x58,
    'Y': 0x59, 'Z': 0x5A,
    'LWIN': 0x5B, 'RWIN': 0x5C, 'APPS': 0x5D, 'SLEEP': 0x5F,
    'NUMPAD0': 0x60, 'NUMPAD1': 0x61, 'NUMPAD2': 0x62, 'NUMPAD3': 0x63,
    'NUMPAD4': 0x64, 'NUMPAD5': 0x65, 'NUMPAD6': 0x66, 'NUMPAD7': 0x67,
    'NUMPAD8': 0x68, 'NUMPAD9': 0x69,
    'NUMPAD*': 0x6A, 'NUMPAD+': 0x6B, 'SEPARATOR': 0x6C, 'NUMPAD-': 0x6D,
    'NUMPAD.': 0x6E, 'NUMPAD/': 0x6F,
    'F1': 0x70, 'F2': 0x71, 'F3': 0x72, 'F4': 0x73, 'F5': 0x74,
    'F6': 0x75, 'F7': 0x76, 'F8': 0x77, 'F9': 0x78, 'F10': 0x79,
    'F11': 0x7A, 'F12': 0x7B, 'F13': 0x7C, 'F14': 0x7D, 'F15': 0x7E,
    'F16': 0x7F, 'F17': 0x80, 'F18': 0x81, 'F19': 0x82, 'F20': 0x83,
    'F21': 0x84, 'F22': 0x85, 'F23': 0x86, 'F24': 0x87,
    'NUMLOCK': 0x90, 'SCROLL': 0x91, 'OEM_FJ_JISHO': 0x92,
    'OEM_FJ_MASSHOU': 0x93, 'OEM_FJ_TOUROKU': 0x94,
    'OEM_FJ_LOYA': 0x95, 'OEM_FJ_ROYA': 0x96,
    'LSHIFT': 0xA0, 'RSHIFT': 0xA1, 'LCONTROL': 0xA2, 'RCONTROL': 0xA3,
    'LMENU': 0xA4, 'RMENU': 0xA5,
    'BROWSER_BACK': 0xA6, 'BROWSER_FORWARD': 0xA7, 'BROWSER_REFRESH': 0xA8,
    'BROWSER_STOP': 0xA9, 'BROWSER_SEARCH': 0xAA, 'BROWSER_FAVORITES': 0xAB,
    'BROWSER_HOME': 0xAC,
    'VOLUME_MUTE': 0xAD, 'VOLUME_DOWN': 0xAE, 'VOLUME_UP': 0xAF,
    'MEDIA_NEXT_TRACK': 0xB0, 'MEDIA_PLAY_PAUSE': 0xB3,
    'MEDIA_PREV_TRACK': 0xB1, 'MEDIA_STOP': 0xB2,
    'LAUNCH_MAIL': 0xB4, 'LAUNCH_MEDIA_SELECT': 0xB5, 'LAUNCH_APP1': 0xB6,
    'LAUNCH_APP2': 0xB7,
    'SEMICOLON': 0xBA, '=': 0xBB, ',': 0xBC, '-': 0xBD, '.': 0xBE, '/': 0xBF,
    '`': 0xC0, 'ABNT_C1': 0xC1, 'ABNT_C2': 0xC2,
    '[': 0xDB, '|': 0xDC, ']': 0xDD, "'": 0xDE, 'OEM_8': 0xDF,
    'OEM_AX': 0xE1, 'OEM_102': 0xE2, 'ICO_HELP': 0xE3, 'ICO_00': 0xE4,
    'PROCESSKEY': 0xE5, 'ICO_CLEAR': 0xE6, 'PACKET': 0xE7, 'OEM_RESET': 0xE9,
    'OEM_JUMP': 0xEA, 'OEM_PA1': 0xEB, 'OEM_PA2': 0xEC, 'OEM_PA3': 0xED,
    'OEM_WSCTRL': 0xEE, 'OEM_CUSEL': 0xEF,
    'OEM_ATTN': 0xF0, 'OEM_FINISH': 0xF1, 'OEM_COPY': 0xF2, 'OEM_AUTO': 0xF3,
    'OEM_ENLW': 0xF4, 'OEM_BACKTAB': 0xF5, 'ATTN': 0xF6, 'CRSEL': 0xF7,
    'EXSEL': 0xF8, 'EREOF': 0xF9, 'PLAY': 0xFA, 'ZOOM': 0xFB, 'NONAME': 0xFC,
    'PA1': 0xFD, 'OEM_CLEAR': 0xFE, '_NONE_': 0xFF
}
# fmt: on


def EncPlayer(s):
    PlayerDict = {
        "p1": 0, "p2": 1, "p3": 2, "p4": 3, "p5": 4, "p6": 5, "p7": 6, "p8": 7,
        "p9": 8, "p10": 9, "p11": 10, "p12": 11,
        "player1": 0, "player2": 1, "player3": 2, "player4": 3, "player5": 4,
        "player6": 5, "player7": 6, "player8": 7, "player9": 8, "player10": 9,
        "player11": 10, "player12": 11, "neutral": 11,
    }
    if s.strip().lower() in PlayerDict:
        return PlayerDict[s.strip().lower()]
    return int(s, 0)


# ─── 조건 (MSQC 와 같은 뜻) ──────────────────────────────────────────────────
def _keyoffset(k):
    try:
        return KeyCodeDict[k.strip().upper()]
    except KeyError:
        raise EPError("%s doesn't exist in VirtualKeyCode." % k)


def _mousebit(k):
    try:
        return MouseButtonDict[k.strip().upper()]
    except KeyError:
        raise EPError("%s is NOT a MouseButton. Use 'L', 'R' or 'M'." % k)


def KeyDown(k):
    offset = _keyoffset(k)
    KeyOffset.add(offset)
    r, n = offset % 4, 2 ** (offset % 32)
    m = 256 ** r
    return [
        MemoryX(0x596A18 + offset - r, Exactly, m, m),
        MemoryX(KeyArray + offset // 8, Exactly, 0, n),
    ]


def KeyUp(k):
    offset = _keyoffset(k)
    KeyOffset.add(offset)
    r, n = offset % 4, 2 ** (offset % 32)
    m = 256 ** r
    return [
        MemoryX(0x596A18 + offset - r, Exactly, 0, m),
        MemoryX(KeyArray + offset // 8, Exactly, n, n),
    ]


def KeyPress(k):
    offset = _keyoffset(k)
    r = offset % 4
    m = 256 ** r
    return MemoryX(0x596A18 + offset - r, Exactly, m, m)


def MouseDown(k):
    v = _mousebit(k)
    MouseOffset.add(v)
    return [MemoryX(0x6CDDC0, Exactly, v, v), MemoryX(MouseArray, Exactly, 0, v)]


def MouseUp(k):
    v = _mousebit(k)
    MouseOffset.add(v)
    return [MemoryX(0x6CDDC0, Exactly, 0, v), MemoryX(MouseArray, Exactly, v, v)]


def MousePress(k):
    v = _mousebit(k)
    return MemoryX(0x6CDDC0, Exactly, v, v)


def NotTyping():
    return Memory(0x68C144, Exactly, 0)


def KeyUpdate():
    for offset in KeyOffset:
        r, n = offset % 4, 2 ** (offset % 32)
        m = 256 ** r
        RawTrigger(
            conditions=[MemoryX(0x596A18 + offset - r, Exactly, m, m),
                        MemoryX(KeyArray + offset // 8, Exactly, 0, n)],
            actions=SetMemoryX(KeyArray + offset // 8, SetTo, n, n),
        )
        RawTrigger(
            conditions=[MemoryX(0x596A18 + offset - r, Exactly, 0, m),
                        MemoryX(KeyArray + offset // 8, Exactly, n, n)],
            actions=SetMemoryX(KeyArray + offset // 8, SetTo, 0, n),
        )


def MouseUpdate():
    for k in MouseOffset:
        RawTrigger(
            conditions=[MemoryX(0x6CDDC0, Exactly, k, k), MemoryX(MouseArray, Exactly, 0, k)],
            actions=SetMemoryX(MouseArray, SetTo, k, k),
        )
        RawTrigger(
            conditions=[MemoryX(0x6CDDC0, Exactly, 0, k), MemoryX(MouseArray, Exactly, k, k)],
            actions=SetMemoryX(MouseArray, SetTo, 0, k),
        )


def _floorlog2(n):
    return n.bit_length() - 1


# ─── 설정 읽기 ───────────────────────────────────────────────────────────────
def _encode_unit_or_int(s):
    s = s.strip()
    try:
        return EncodeUnit(s)
    except (EPError, KeyError):
        return int(s, 0)


def onInit():
    global SNQCUnit, SNQCPlayer, SNQCLoc, SNQC_X, SNQC_Y, BuildW, BuildH, UseMerge, QCDebug, BufferLimit
    global humans, W, H, KX, KY, VX, VY, key_bits
    chkt = GetChkTokenized()
    dim, ownr = chkt.getsection("DIM"), chkt.getsection("OWNR")
    dim_x, dim_y = b2i2(dim[0:2]), b2i2(dim[2:4])
    W, H = dim_x * 32, dim_y * 32
    # 키 줄: x 에 KX 비트(0 ~ 2^KX-1 ≤ W-1), y 에 KY 비트. 값 줄: x = 아래 VX 비트 + 1 (≤ 2^VX ≤ W-1), y = 위 VY 비트
    KX, KY = _floorlog2(W), _floorlog2(H)
    VX, VY = _floorlog2(W - 1), _floorlog2(H)
    key_bits = [2 ** b for b in range(KX)] + [2 ** (16 + b) for b in range(KY)]
    humans = [p for p in range(8) if ownr[p] == 6]

    for k, v in settings.items():
        kl = k.strip()
        if kl in ("SNQCUnit", "QCUnit", "QCUnitID"):
            u = _encode_unit_or_int(v)
            if u in FACTORY_UNITS:
                SNQCUnit = u
            elif kl == "SNQCUnit":
                raise EPError("SNQCUnit 은 랠리를 받는 12종이어야 한다: %s" % sorted(FACTORY_UNITS))
            else:
                print("[SNQC] QCUnit=%s 은 랠리를 못 받는 종류라 무시하고 %d 를 쓴다" % (v.strip(), SNQCUnit))
            continue
        if kl in ("SNQCLoc", "QCLoc"):
            # MSQC 와 같이 **0부터 세는** MRGN 번호 (0 = 편집기의 Location 1). 이름을 주면 그 로케이션
            try:
                SNQCLoc = int(v, 0)
            except ValueError:
                SNQCLoc = GetLocationIndex(v.strip()) - 1
            continue
        if kl in ("SNQCPlayer", "QCPlayer"):
            SNQCPlayer = EncPlayer(v)
            continue
        if kl in ("SNQC_XY", "QC_XY"):
            c = v.split(",")
            SNQC_X, SNQC_Y = int(c[0], 0), int(c[1], 0)
            continue
        if kl == "SNQCBuildSize":
            c = v.split(",")
            BuildW, BuildH = int(c[0], 0), int(c[1], 0)
            continue
        if kl == "SNQCMerge":
            UseMerge = v.strip().lower() not in ("false", "0", "off")
            continue
        if kl == "SNQCBufferLimit":
            BufferLimit = int(v, 0)
            continue
        if kl in ("QCDebug", "SNQCDebug", "QCSafety"):
            QCDebug = v.strip().lower() not in ("false", "0", "off")
            continue

        con_final, ret_final = [], None
        for cond in [c.strip() for c in k.split(";")]:
            if cond == "":
                continue
            if cond == "마우스" or cond.lower() == "mouse":
                try:
                    mouse_loc = GetLocationIndex(v.strip())
                except (EPError, KeyError):
                    mouse_loc = int(v, 0)
                ret_final = ["mouse", mouse_loc - min(humans)]
            elif cond[:8] == "KeyDown(" and cond[-1] == ")":
                con_final.append(KeyDown(cond[8:-1]))
            elif cond[:6] == "KeyUp(" and cond[-1] == ")":
                con_final.append(KeyUp(cond[6:-1]))
            elif cond[:9] == "KeyPress(" and cond[-1] == ")":
                con_final.append(KeyPress(cond[9:-1]))
            elif cond.upper() in KeyCodeDict:
                con_final.append(KeyDown(cond))
            elif cond[:10] == "MouseDown(" and cond[-1] == ")":
                con_final.append(MouseDown(cond[10:-1]))
            elif cond[:8] == "MouseUp(" and cond[-1] == ")":
                con_final.append(MouseUp(cond[8:-1]))
            elif cond[:11] == "MousePress(" and cond[-1] == ")":
                con_final.append(MousePress(cond[11:-1]))
            elif cond.lower() == "nottyping":
                con_final.append(NotTyping())
            else:
                c = [x.strip() for x in cond.split(",")]
                if c[0].lower() == "val":
                    ret_final = ["val", c[1], _ret_target(v.strip())]
                elif c[0].lower() == "xy":
                    rets = [r.strip() for r in v.split(",")]
                    if not 1 <= len(rets) <= 2 or len(c) - 1 != len(rets):
                        raise EPError("xy 줄은 주소 수와 결과 수가 같아야 한다 (1 또는 2)")
                    ret_final = ["xy"] + c[1:] + [_ret_target(r) for r in rets]
                elif re.fullmatch(r"0[xX][0-9a-fA-F]+", c[0]):
                    try:
                        ptr, mod, val = int(c[0], 0), eval(c[1]), int(c[2], 0)
                    except (IndexError, SyntaxError, NameError):
                        ptr, val = int(c[0], 0), int(c[1], 0)
                        con_final.append(MemoryX(ptr, Exactly, val, val))
                    else:
                        con_final.append(Memory(ptr, mod, val))
                else:
                    con_final.append(cond)

        if ret_final is None:
            ep_assert(len(con_final) >= 1, "키 줄에는 조건이 하나 이상 있어야 한다: %s" % k)
            rets = [r.strip() for r in v.split(",")]
            try:
                increment = int(rets[1], 0)
            except (IndexError, ValueError):
                raise EPError("키 줄의 결과는 '데스유닛, 더할값' 이어야 한다: %s" % v)
            target = _ret_target(rets[0])
            key_lines.append((con_final, ["array" if isinstance(target, str) else "deaths", target, increment]))
        else:
            if not con_final:
                con_final.append(Always())
            val_lines.append((con_final, ret_final))

    ep_assert(key_lines or val_lines, "[SNQC] 줄이 하나도 없다")
    print("[SNQC] map %dx%d, humans %s, channel unit %d, key bits/channel %d, value range 0..%d"
          % (dim_x, dim_y, [p + 1 for p in humans], SNQCUnit, len(key_bits), 2 ** (VX + VY) - 1))


def _ret_target(s):
    s = s.strip()
    try:
        u = EncodeUnit(s)
    except (EPError, KeyError):
        try:
            u = int(s, 0)
        except ValueError:
            return s  # EUDArray 이름
    deathsUnits.add(u)
    return u


onInit()

# ─── 채널 ────────────────────────────────────────────────────────────────────
channels = []  # ("key", [(conds, ret, bit)]) / ("val", conds, ret)
for i in range(0, len(key_lines), len(key_bits)):
    group = key_lines[i:i + len(key_bits)]
    channels.append(("key", [(cn, rt, key_bits[j]) for j, (cn, rt) in enumerate(group)]))
for cn, rt in val_lines:
    channels.append(("val", cn, rt))
NCh = len(channels)
print("[SNQC] %d channels x %d humans" % (NCh, len(humans)))

ChEPD = EUDArray(8 * NCh)        # 공유: 플레이어 p, 채널 c 의 채널 건물 EPD (0 = 없음)
MyHdr = EUDArray(NCh)            # 로컬: 09 01 A A (내 채널 c)
MyHdr2 = EUDArray(NCh)           # 로컬: 01 A A 15
MyPtr = EUDArray(NCh)            # 로컬: 내 채널 c 의 CUnit 포인터
PendOff, PendLen = EUDArray(NCh), EUDArray(NCh)
MyValid = EUDVariable()
LastPtr = EUDArray(1)            # 로컬: 마지막으로 붙인 채널의 포인터 (선택 빼기용)
CheckTimer = EUDVariable()
LastMX, LastMY = EUDVariable(), EUDVariable()
# 패킷: PB+3 부터 15바이트 "09 01 A A 15 x x y y 00 00 E4 00 OO 00" → PB+8 이 좌표 dword 자리
PB = Db(b"\0\0\0\x09" + b"\0\0\0\0" + b"\0\0\0\0" + b"\0\0\xE4\0" + bytes([RALLY_ORDER, 0, 0, 0]))
PB_EPD = EPD(PB)


def _xyfor(pi, c):
    step_x = 32 if SNQC_X + 32 * (NCh - 1) < W else -32
    step_y = 32 if SNQC_Y + 32 * (len(humans) - 1) < H else -32
    x, y = SNQC_X + step_x * c, SNQC_Y + step_y * pi
    ep_assert(0 <= x < W and 0 <= y < H, "[SNQC] 채널 건물 자리가 맵 밖 - SNQC_XY 를 바꿀 것")
    return x, y


def _snap(v, s):
    half = s // 2
    return (v - half) // 32 * 32 + half


@EUDFunc
def f_epd2alphaid(epd):
    epd += 43
    ret = epd // 84
    ret -= 226
    EUDReturn(ret)


# ─── ① 준비 / 채널 건물 ───────────────────────────────────────────────────────
def onPluginStart():
    u = SNQCUnit
    DoActions([
        SetMemory(0x662860 + u * 4, SetTo, BuildW + BuildH * 65536),  # 건설크기 → 가려짐
        SetMemory(0x6617C8 + u * 8, SetTo, 0x10001),                  # 유닛 크기 1,1,1,1
        SetMemory(0x6617CC + u * 8, SetTo, 0x10001),
        SetMemoryX(0x663238 + u - u % 4, SetTo, 0, 0xFF << (8 * (u % 4))),  # 시야 0
        SetMemoryX(0x662DB8 + u - u % 4, SetTo, 0, 0xFF << (8 * (u % 4))),  # 탐색 범위 0
        SetMemoryX(0x6637A0 + u - u % 4, SetTo, 0, 0xFF << (8 * (u % 4))),  # 그룹 플래그 0
        SetMemoryX(0x6646C8 + u - u % 4, SetTo, 0, 0xFF << (8 * (u % 4))),  # 서플라이 공급 0
        SetMemoryX(0x664080 + u * 4, SetTo, 0, 0x1000),                     # 자원 반환 건물 끄기
    ])
    CreateChannels()


@EUDFunc
def CreateChannels():
    loc_epd = EPD(0x58DC60) + SNQCLoc * 5
    for pi, p in enumerate(humans):
        for c in range(NCh):
            idx = p * NCh + c
            px, py = _xyfor(pi, c)
            sx, sy = _snap(px, BuildW), _snap(py, BuildH)
            if EUDIf()([MemoryEPD(EPD(ChEPD) + idx, Exactly, 0), Memory(0x628438, AtLeast, 1)]):
                if EUDIf()(f_playerexist(p)):
                    saved = [f_dwread_epd(loc_epd + i) for i in range(5)]
                    DoActions(SetMemoryXEPD(loc_epd + 4, SetTo, 0, 0xFFFF0000))   # 로케이션 고도 플래그 끄기 (MSQC 와 같다)
                    f_setloc(SNQCLoc + 1, px, py)   # f_setloc 은 1부터 센다
                    ptr, epd = f_cunitepdread_epd(EPD(0x628438))
                    DoActions(CreateUnit(1, SNQCUnit, SNQCLoc + 1, p))
                    if EUDIf()([MemoryXEPD(epd + 0x64 // 4, Exactly, SNQCUnit, 0xFFFF),
                                MemoryXEPD(epd + 0x4C // 4, Exactly, p, 0xFF)]):
                        f_setloc(SNQCLoc + 1, sx - 16, sy - 16, sx + 16, sy + 16)
                        DoActions([
                            GiveUnits(1, SNQCUnit, p, SNQCLoc + 1, SNQCPlayer),
                            SetMemoryXEPD(epd + 0x4C // 4, SetTo, p, 0xFF),                  # 소유자 바이트만 사람으로
                            SetMemoryXEPD(epd + 0xDC // 4, SetTo, 0x04200000, 0x04200000),   # 무적 + 충돌 없음
                            SetMemoryXEPD(epd + 0xA5 // 4, SetTo, 0, 0xFF00),                # 세대 0 (알파ID = 인덱스+1, MSQC 와 같다)
                            SetMemoryEPD(epd + 0xF8 // 4, SetTo, 0),                         # 랠리 칸 = 기준값
                        ])
                        ChEPD[idx] = epd
                        if EUDIf()(Memory(0x512684, Exactly, p)):
                            alpha = f_epd2alphaid(epd)
                            MyHdr[c] = alpha * 65536 + 0x0109
                            MyHdr2[c] = alpha * 256 + 0x15000001
                            MyPtr[c] = ptr
                            PendLen[c] = 0
                            MyValid << 1
                        EUDEndIf()
                    EUDEndIf()
                    for i in range(5):
                        f_dwwrite_epd(loc_epd + i, saved[i])
                EUDEndIf()
            EUDEndIf()


@EUDFunc
def CheckChannels():
    if EUDIf()(CheckTimer.AtLeast(CheckInterval)):
        CheckTimer << 0
        for p in humans:
            for c in range(NCh):
                idx = p * NCh + c
                epd = ChEPD[idx]
                if EUDIf()(epd >= 1):
                    if EUDIfNot()([MemoryXEPD(epd + 0x64 // 4, Exactly, SNQCUnit, 0xFFFF),
                                   MemoryXEPD(epd + 0x4C // 4, Exactly, p, 0xFF)]):
                        ChEPD[idx] = 0
                        if EUDIf()(Memory(0x512684, Exactly, p)):
                            MyValid << 0
                            f_setcurpl(p)   # DisplayText 는 현재 플레이어가 나일 때만 보인다
                            DoActions(DisplayText("\x13\x08[SNQC] 채널 건물이 없어져 다시 만든다"))
                        EUDEndIf()
                    EUDEndIf()
                EUDEndIf()
    if EUDElse()():
        DoActions(CheckTimer.AddNumber(1))
    EUDEndIf()


# ─── ② 보내기 (로컬) ──────────────────────────────────────────────────────────
def _parse_cond(s):
    _ns = GetEUDNamespace()
    for k, v in _ns.items():
        if (IsEUDVariable(v) or isUnproxyInstance(v, EUDLightBool)
                or isUnproxyInstance(v, EUDLightVariable) or isUnproxyInstance(v, EUDXVariable)) and k in s:
            s = re.sub(r"\b{}\b".format(k), "_ns['\\g<0>']", s)
    return s


def _condition(con):
    _ns = GetEUDNamespace()
    items = []
    for c in con:
        if type(c) is str:
            items.append(eval(_parse_cond(c)))
        else:
            items.append(c)
    if len(items) == 1:
        return items[0]
    cond = EUDSCAnd()
    for it in items:
        cond = cond(it)
    return cond()


def _source(src):
    """주소(숫자) 또는 eudplib 변수 이름 → 값 변수"""
    if isinstance(src, int):
        return f_dwread_epd(EPD(src))
    try:
        return f_dwread_epd(EPD(int(src, 0)))
    except ValueError:
        _ns = GetEUDNamespace()
        v = eval(_parse_cond(src))
        if IsEUDVariable(v):
            return v
        return f_dwread_epd(EPD(v.getValueAddr()))


def Emit(c, C, is_key, appended):
    L = f_dwread_epd(EPD(0x654AA0))
    done = EUDVariable()
    done << 0
    if UseMerge:
        # 지난번 붙인 패킷이 아직 버퍼에 있나: 길이가 그때 이상 + 그 자리에 "09 01 내 채널"
        pend = PendLen[c]
        t = EUDVariable()
        t << pend
        t -= L                      # SC 뺄셈은 0 밑으로 안 내려간다 → t == 0 이면 pend <= L
        if EUDIf()([pend >= 1, t == 0]):
            P = PendOff[c] + 0x654880
            hdr = f_dwread(P)
            if EUDIf()(f_bitxor(hdr, MyHdr[c]) == 0):
                if is_key:
                    C << f_bitor(C, f_dwread(P + 5))   # 키: 그 턴에 눌린 것을 모두 남긴다
                f_dwwrite(P + 5, C)
                done << 1
            EUDEndIf()
        EUDEndIf()
    if EUDIf()([done == 0, L <= BufferLimit]):
        f_dwwrite_epd(PB_EPD + 1, MyHdr2[c])
        f_dwwrite_epd(PB_EPD + 2, C)
        f_memcpy(0x654880 + L, PB + 3, 15)
        PendOff[c] = L
        PendLen[c] = L + 15
        f_dwwrite_epd(EPD(0x654AA0), L + 15)
        LastPtr[0] = MyPtr[c]
        appended << 1
    EUDEndIf()


def _encode_value(v):
    x = f_bitand(v, 2 ** VX - 1) + 1
    y = f_bitrshift(v, VX)
    return x + y * 65536


def _encode_point(x, y):
    xs = EUDVariable()
    xs << x
    if EUDIf()(x <= W - 2):
        xs += 1
    EUDEndIf()
    return xs + y * 65536


@EUDFunc
def SendQC():
    appended = EUDVariable()
    appended << 0
    selcount = EUDVariable()
    selcount << 0
    for i in range(12):   # 0x6284B8 = 내 화면 선택 유닛 포인터 12칸 (0 이면 끝)
        if EUDIf()([selcount.Exactly(i), Memory(0x6284B8 + 4 * i, AtLeast, 1)]):
            selcount << i + 1
        EUDEndIf()

    C = EUDVariable()
    for c, ch in enumerate(channels):
        if ch[0] == "key":
            C << 0
            for con, ret, bit in ch[1]:
                if EUDIf()(_condition(con)):
                    C += bit
                EUDEndIf()
            if EUDIf()(C >= 1):
                Emit(c, C, True, appended)
            EUDEndIf()
            continue
        con, ret = ch[1], ch[2]
        if EUDIf()(_condition(con)):
            if ret[0] == "val":
                v = _source(ret[1])
                if EUDIf()(v <= 2 ** (VX + VY) - 1):
                    C << _encode_value(v)
                    Emit(c, C, False, appended)
                EUDEndIf()
            elif ret[0] == "xy":
                if len(ret) == 3:
                    xy = _source(ret[1])
                    x, y = f_bitand(xy, 0xFFFF), f_bitrshift(xy, 16)
                else:
                    x, y = _source(ret[1]), _source(ret[2])
                if EUDIf()([x <= W - 1, y <= H - 1]):
                    C << _encode_point(x, y)
                    Emit(c, C, False, appended)
                EUDEndIf()
            elif ret[0] == "mouse":
                mx = f_dwread_epd(EPD(0x62848C)) + f_dwread_epd(EPD(0x6CDDC4))
                my = f_dwread_epd(EPD(0x6284A8)) + f_dwread_epd(EPD(0x6CDDC8))
                if EUDIfNot()([f_bitxor(mx, LastMX) == 0, f_bitxor(my, LastMY) == 0]):
                    if EUDIf()([mx <= W - 1, my <= H - 1]):
                        LastMX << mx
                        LastMY << my
                        C << _encode_point(mx, my)
                        Emit(c, C, False, appended)
                    EUDEndIf()
                EUDEndIf()
        EUDEndIf()

    # 선택 되돌리기: 새로 붙인 패킷이 있을 때만
    if EUDIf()(appended == 1):
        if EUDIf()(selcount >= 1):
            QueueGameCommand_Select(selcount, 0x6284B8)
        if EUDElse()():
            QueueGameCommand_RemoveSelect(1, LastPtr)   # 아무것도 안 고른 상태였다 → 채널을 선택에서 뺀다
        EUDEndIf()
    EUDEndIf()


# ─── ③ 받기 (공유) ────────────────────────────────────────────────────────────
def _parse_array(s):
    _ns = GetEUDNamespace()
    for k, v in _ns.items():
        if (isUnproxyInstance(v, EUDArray) or isUnproxyInstance(v, EUDVArray(8))) and k in s:
            s = re.sub(r"\b{}\b".format(k), "_ns['\\g<0>']", s)
    return s


def _write_target(p, target, value, add=False):
    if isinstance(target, int):
        DoActions(SetDeaths(p, Add if add else SetTo, value, target))
        return
    _ns = GetEUDNamespace()
    array = eval(_parse_array(target))
    if isUnproxyInstance(array, EUDArray):
        (f_dwadd_epd if add else f_dwwrite_epd)(EPD(array) + p, value)
    elif isUnproxyInstance(array, EUDVArray(8)):
        (f_dwadd_epd if add else f_dwwrite_epd)(EPD(array) + 328 // 4 + 5 + 18 * p, value)
    else:
        raise EPError("%s 는 데스유닛도 EUDArray 도 아니다" % target)


@EUDFunc
def ReceiveQC():
    for p in humans:
        # MSQC 와 같이 받는 칸을 매 사이클 비운다: 데스값 0, 키 줄 배열 0, 값·좌표 줄 배열 -1
        if deathsUnits:
            DoActions([SetDeaths(p, SetTo, 0, u) for u in sorted(deathsUnits)])
        for ch in channels:
            if ch[0] == "key":
                for _c, r, _b in ch[1]:
                    if isinstance(r[1], str):
                        _write_target(p, r[1], 0)
            else:
                r = ch[2]
                if r[0] == "val":
                    targets = r[2:]
                elif r[0] == "xy":
                    targets = r[(len(r) + 1) // 2:]
                else:
                    targets = []
                for tg in targets:
                    if isinstance(tg, str):
                        _write_target(p, tg, 0xFFFFFFFF)
        for c, ch in enumerate(channels):
            idx = p * NCh + c
            epd = ChEPD[idx]
            if EUDIf()(epd >= 1):
                rally = epd + 0xF8 // 4
                if EUDIfNot()(MemoryEPD(rally, Exactly, 0)):
                    if ch[0] == "key":
                        for con, ret, bit in ch[1]:
                            if EUDIf()(MemoryXEPD(rally, AtLeast, 1, bit)):
                                _write_target(p, ret[1], ret[2], add=True)
                            EUDEndIf()
                    else:
                        ret = ch[2]
                        R = f_dwread_epd(rally)
                        x = f_bitand(R, 0xFFFF) - 1
                        if ret[0] == "val":
                            v = x + f_bitlshift(f_bitrshift(R, 16), VX)
                            _write_target(p, ret[2], v)
                        else:
                            y = f_bitrshift(R, 16)
                            if ret[0] == "mouse":
                                f_setloc(ret[1] + p, x, y)
                            elif len(ret) == 3:
                                _write_target(p, ret[2], x + y * 65536)
                            else:
                                _write_target(p, ret[3], x)
                                _write_target(p, ret[4], y)
                    DoActions(SetMemoryEPD(rally, SetTo, 0))
                EUDEndIf()
            EUDEndIf()
    KeyUpdate()
    MouseUpdate()


def beforeTriggerExec():
    origcp = f_getcurpl()
    if QCDebug:
        CheckChannels()
    CreateChannels()
    if EUDIf()(MyValid == 1):
        SendQC()
    EUDEndIf()
    ReceiveQC()
    f_setcurpl(origcp)
