#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SNQC - Sana Natori QueueCommand (euddraft 플러그인 판)

MSQC(Murakami Shiina QueueCommand, plugins/MSQC.py)를 대신하는 "로컬 입력 → 모든 PC 동기화" 플러그인.
.eds 의 [SNQC] 단락은 [MSQC] 와 같은 줄 문법을 쓴다 - 단락 이름만 바꾸면 그대로 옮겨진다.
설계·실측 근거: MapSource/SNQC/DESIGN.md. CtrigAsm(Lua) 판은 MapSource/SNQC/SNQC.lua. 작업 내역: HISTORY.md, 판별 변경: CHANGELOG.md.
정본은 MapSource/SNQC/SNQC.py - euddraft 에서 쓰려면 C:/euddraft0.9.2.0/plugins/SNQC.py 로 복사한다.

무엇이 다른가
  MSQC  : 숨긴 비행 건물(QC 유닛)에 Move 를 보내 이동 목표 좌표에 싣는다.
          스타가 150프레임마다 그 Move 를 다시 시작시켜 그 사이클 값이 사라진다.
  SNQC  : 건설크기 (1,0) 으로 가린 커맨드센터(채널 건물)의 **랠리 좌표**에 싣는다 (오더 40).
          - 엔진이 랠리 칸을 스스로 바꾸지 않는다 → 주기적 소실 없음
          - 받는 쪽이 매 사이클 칸을 (0,0) 으로 되돌린다 → 같은 값을 두 번 보내도 두 번 받는다
          - 안 보이고 안 골라지는데 명령은 받는다
          (2026-09-17 SC:R 실측, DESIGN.md "실측")
          - (1.2) 시야도 밝히지 않는다: 이동 상태(+0x97)를 UM_Hidden(6) 으로 매 사이클 고정해 100프레임마다의
            시야 갱신에서 빼고, 만드는 순간은 만드는 플레이어의 공유 시야 칸(0x57F1EC)을 잠깐 0 으로 둔다
            (OpenBW 소스 근거, MSF_UE_RE 싱글 인게임 확인 - DESIGN.md "시야")

.eds 설정 (전부 생략 가능)
  SNQCUnit      = 106          채널 건물 종류. 랠리를 받는 12종 중 맵에서 안 쓰는 것 (종류 전체의 units.dat 를 고친다)
                               QCUnit 도 받지만 12종이 아니면 무시하고 106 을 쓴다 (MSQC 의 QC 유닛은 보통 12종이 아니다)
  SNQCPlayer    = P11          채널 건물을 넘겨 둘 플레이어 (QCPlayer 도 받음)
  SNQCLoc       = 0            만들 때 잠깐 쓰는 로케이션 (QCLoc 도 받음). 쓰고 나면 되돌린다
  SNQCCreator   = (없음)       (1.2) 채널 건물을 만드는 플레이어 (P1~P8, 보통 컴퓨터 슬롯). 없으면 그 채널의 사람이 만든다.
                               만든 건물은 SNQCPlayer 에게 넘기고 주인 바이트만 사람으로 바꾸므로 누가 만들어도 결과는 같다.
                               게임 내내 있는 슬롯이어야 한다 (없는 플레이어로는 못 만든다)
  SNQC_XY       = 128, 128     첫 채널 자리 (QC_XY 도 받음). 채널마다 x 로 32, 플레이어마다 y 로 32 씩 (맵 끝이면 반대 방향)
                               (1.1 의 SNQC_XY1~8 / SNQCColumns 는 1.2 에서 없앴다 - 시야를 끈 뒤로는 자리를 가릴 까닭이 없다)
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

eudplib 판 (1.3): 0.76.14 (euddraft 0.9.x, C:/euddraft0.9.2.0) 와 0.81 (euddraft 0.11) 에서 같은 트리거 뜻이 되게 쓴다.
  0.81 은 EUDArray 의 값이 주소가 아니라 EPD 다 - 배열 값에 주소 산술(`배열 + n`)을 하지 말고, EPD 는 _arr_epd() 로 얻는다.
  eudplib 의 `-` / `-=` 는 0 에서 멈추지 않는다(wrap). 크기 비교는 뺄셈 결과를 부호 있는 수로 본다 (Emit 의 합치기 판정).

확인 (2026-09-17): theSeed 싱글·LAN 2인(64비트+32비트) 인게임 통과 (1.0) - 150프레임 소실 없음, 디싱크 없음.
  1.2 의 시야 끄기는 MSF_UE_RE 싱글 인게임 확인 (채널 자리 안 보임, 키·SCR_DB 정상). 멀티는 아직.
  1.3 의 두 수정(키 배열, 합치기 판정)은 에뮬레이터 시험(tests/t_snqc_emu.py, 두 판)까지. 인게임은 아직.
  합치기(턴이 여러 사이클인 방)·버퍼 한계의 인게임은 아직 (DESIGN.md "확인 목록").
"""
import re
from math import ceil

from eudplib import *

# 판 번호 - CHANGELOG.md 의 "플러그인 판" 과 맞춘다
SNQC_VERSION = "1.3"

# fmt: off
SNQCUnit, SNQCPlayer, SNQCLoc = 106, 10, 0
SNQC_X, SNQC_Y = 128, 128
SNQCCreator = None     # 1.2: 채널 건물을 만드는 플레이어 (None = 그 채널의 사람)
BuildW, BuildH = 1, 0
UseMerge, QCDebug = True, True
BufferLimit, CheckInterval = 400, 34
RALLY_ORDER = 40
UM_HIDDEN = 6          # 이동 상태 UM_Hidden (OpenBW bwenums.h). 이 상태의 유닛은 시야 갱신에서 빠진다
FACTORY_UNITS = {106, 111, 113, 114, 130, 131, 132, 133, 154, 155, 160, 167}

key_lines, val_lines, deathsUnits = [], [], set()   # key_lines: (conds, ret) / val_lines: (conds, ret)

# 로컬 눌림 기억 (1.3: EUDArray → 바이트 배열). KeyArray 는 가상 키 256개의 비트 (_keybit), MouseArray 는 버튼 비트.
# 1.2 는 EUDArray(8) 에 `KeyArray + 키 // 8` 로 주소를 만들었다. eudplib 0.76 은 EUDArray 값이 주소라 EPD 내림으로
# (키 // 32) 번째 칸이 되었지만, 0.81 은 값이 EPD 라 (키 // 8) 번째 칸 = 키 0x40 이상에서 배열 밖(다른 트리거·변수)에 썼다.
KeyArray, KeyOffset = Db(32), set()
MouseArray, MouseOffset = Db(4), set()

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
def _keybit(offset):
    """가상 키 offset 의 눌림 기억 칸 (주소, 비트) = KeyArray 의 (offset // 32) 번째 dword, (offset % 32) 번째 비트.
    주소는 늘 4의 배수로 만든다 (두 eudplib 판에서 같은 칸)."""
    return KeyArray + 4 * (offset // 32), 2 ** (offset % 32)


def _arr_epd(arr):
    """EUDArray / EUDVArray 첫 칸의 EPD (판 무관).
    eudplib 0.76 은 배열 값이 주소라 EPD() 가 필요하고, 0.81 의 EUDArray 는 값이 이미 EPD 라 EPD() 가
    "EPD on EPD value of ConstExpr is no-op" 경고만 내고 그대로 둔다. 두 판 모두 배열 객체가 EPD 를 _epd 로 들고 있다."""
    return arr._epd


def _is_varray8(v):
    """EUDVArray(8) 인스턴스인가 (MSQC 와 같이 8칸만 받는다).
    eudplib 0.76 은 EUDVArray(8) 이 크기별 **클래스**라 isinstance 로 본다.
    0.81 은 EUDVArray(8) 이 클래스가 아닌 공장 객체라 isinstance 에 넣으면 TypeError (1.2 는 배열 결과 줄이 있으면 빌드가 멈췄다) -
    인스턴스 클래스(또는 부모, PVariable 등)가 _EUDVArray 이고 크기 _size 가 8 인지로 본다."""
    kind = EUDVArray(8)
    if isinstance(kind, type):
        return isUnproxyInstance(v, kind)
    return any(c.__name__ == "_EUDVArray" for c in type(v).__mro__) and getattr(v, "_size", None) == 8


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
    r = offset % 4
    m = 256 ** r
    ka, n = _keybit(offset)
    return [
        MemoryX(0x596A18 + offset - r, Exactly, m, m),
        MemoryX(ka, Exactly, 0, n),
    ]


def KeyUp(k):
    offset = _keyoffset(k)
    KeyOffset.add(offset)
    r = offset % 4
    m = 256 ** r
    ka, n = _keybit(offset)
    return [
        MemoryX(0x596A18 + offset - r, Exactly, 0, m),
        MemoryX(ka, Exactly, n, n),
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
    for offset in sorted(KeyOffset):
        r = offset % 4
        m = 256 ** r
        ka, n = _keybit(offset)
        RawTrigger(
            conditions=[MemoryX(0x596A18 + offset - r, Exactly, m, m),
                        MemoryX(ka, Exactly, 0, n)],
            actions=SetMemoryX(ka, SetTo, n, n),
        )
        RawTrigger(
            conditions=[MemoryX(0x596A18 + offset - r, Exactly, 0, m),
                        MemoryX(ka, Exactly, n, n)],
            actions=SetMemoryX(ka, SetTo, 0, n),
        )


def MouseUpdate():
    for k in sorted(MouseOffset):
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
    global SNQCUnit, SNQCPlayer, SNQCLoc, SNQCCreator, SNQC_X, SNQC_Y, BuildW, BuildH, UseMerge, QCDebug, BufferLimit
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
        if kl == "SNQCCreator":
            SNQCCreator = EncPlayer(v)
            ep_assert(0 <= SNQCCreator < 8, "[SNQC] SNQCCreator 는 P1~P8 (트리거는 P9 이상 소유로 유닛을 못 만든다)")
            continue
        if re.fullmatch(r"SNQC_XY[1-8]|SNQCColumns", kl):
            raise EPError("[SNQC] %s 는 1.2 에서 없앴다 (플레이어별 채널 자리) - SNQC_XY 하나만 쓴다" % kl)
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
    if SNQCCreator is not None and ownr[SNQCCreator] != 5:
        print("[SNQC] 주의: SNQCCreator P%d 가 컴퓨터 슬롯이 아니다 (OWNR %d) - 게임에 없으면 채널을 못 만든다"
              % (SNQCCreator + 1, ownr[SNQCCreator]))
    print("[SNQC %s] map %dx%d, humans %s, channel unit %d, creator %s, key bits/channel %d, value range 0..%d"
          % (SNQC_VERSION, dim_x, dim_y, [p + 1 for p in humans], SNQCUnit,
             "P%d" % (SNQCCreator + 1) if SNQCCreator is not None else "owner", len(key_bits), 2 ** (VX + VY) - 1))


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
    ep_assert(0 <= x < W and 0 <= y < H, "[SNQC] 채널 건물 자리가 맵 밖 (%d, %d) - SNQC_XY 를 바꿀 것" % (x, y))
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


# 만드는 순간의 시야 (1.2): 게임은 만든 플레이어의 공유 시야(0x57F1EC + 4 * 플레이어)대로 3x3 칸을 밝힌다
# (OpenBW initialize_unit -> refresh_unit_vision). CreateUnit 동안만 그 칸을 0 으로 두어 아무에게도 안 밝힌다.
# 맵이 사람에게 컴퓨터 시야를 나눠 주는 중(Turn ON Shared Vision for Player 8)이어도 안 보인다.
# 그 뒤 100프레임마다의 시야 갱신은 이동 상태 UM_Hidden 으로 막는다 (여기와 ReceiveQC).
@EUDFunc
def CreateChannels():
    loc_epd = EPD(0x58DC60) + SNQCLoc * 5
    taken = {}
    for pi, p in enumerate(humans):
        maker = p if SNQCCreator is None else SNQCCreator
        vis_epd = EPD(0x57F1EC) + maker
        for c in range(NCh):
            idx = p * NCh + c
            px, py = _xyfor(pi, c)
            sx, sy = _snap(px, BuildW), _snap(py, BuildH)
            ep_assert(sx >= 16 and sy >= 16, "[SNQC] 채널 자리가 맵 가장자리에 너무 붙었다 (%d, %d)" % (sx, sy))
            ep_assert((sx, sy) not in taken, "[SNQC] 채널 자리가 겹친다 (%d, %d): P%d 채널 %d 와 %s"
                      % (sx, sy, p + 1, c + 1, taken.get((sx, sy))))
            taken[(sx, sy)] = "P%d 채널 %d" % (p + 1, c + 1)
            if EUDIf()([MemoryEPD(_arr_epd(ChEPD) + idx, Exactly, 0), Memory(0x628438, AtLeast, 1)]):
                if EUDIf()(f_playerexist(p)):
                    saved = [f_dwread_epd(loc_epd + i) for i in range(5)]
                    DoActions(SetMemoryXEPD(loc_epd + 4, SetTo, 0, 0xFFFF0000))   # 로케이션 고도 플래그 끄기 (MSQC 와 같다)
                    f_setloc(SNQCLoc + 1, px, py)   # f_setloc 은 1부터 센다
                    ptr, epd = f_cunitepdread_epd(EPD(0x628438))
                    vis = f_dwread_epd(vis_epd)
                    DoActions([
                        SetMemoryEPD(vis_epd, SetTo, 0),
                        CreateUnit(1, SNQCUnit, SNQCLoc + 1, maker),
                    ])
                    f_dwwrite_epd(vis_epd, vis)
                    if EUDIf()([MemoryXEPD(epd + 0x64 // 4, Exactly, SNQCUnit, 0xFFFF),
                                MemoryXEPD(epd + 0x4C // 4, Exactly, maker, 0xFF)]):
                        f_setloc(SNQCLoc + 1, sx - 16, sy - 16, sx + 16, sy + 16)
                        DoActions([
                            GiveUnits(1, SNQCUnit, maker, SNQCLoc + 1, SNQCPlayer),
                            SetMemoryXEPD(epd + 0x4C // 4, SetTo, p, 0xFF),                  # 소유자 바이트만 사람으로 (명령을 받게)
                            SetMemoryXEPD(epd + 0x94 // 4, SetTo, UM_HIDDEN << 24, 0xFF000000),  # +0x97 이동 상태 → 시야 갱신에서 빠짐
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
        # 지난번 붙인 패킷이 아직 버퍼에 있나: 길이가 그때 이상(L >= pend) + 그 자리에 "09 01 내 채널"
        # 1.3: eudplib 의 `-=` 는 0 에서 멈추지 않는다(wrap, 두 판 같음). 1.2 는 `t = pend - L; t == 0` 이라 pend == L 일 때만
        # 합쳤고, 패킷 뒤에는 늘 선택 되돌리기가 붙으므로 사실상 합치기가 한 번도 안 됐다 (턴이 여러 사이클인 방에서 앞 사이클의 키가 사라짐).
        # Lua 판(CiSub + VLe 0x7FFFFFFF)과 같게 t = L - pend 를 부호 있는 수로 본다. 둘 다 버퍼 길이(≤ 0x57F0D8 값)라 넘치지 않는다.
        pend = PendLen[c]
        t = EUDVariable()
        t << L
        t -= pend
        if EUDIf()([pend >= 1, t <= 0x7FFFFFFF]):
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
        if k in s and (isUnproxyInstance(v, EUDArray) or _is_varray8(v)):
            s = re.sub(r"\b{}\b".format(k), "_ns['\\g<0>']", s)
    return s


def _write_target(p, target, value, add=False):
    if isinstance(target, int):
        DoActions(SetDeaths(p, Add if add else SetTo, value, target))
        return
    _ns = GetEUDNamespace()
    array = eval(_parse_array(target))
    if isUnproxyInstance(array, EUDArray):
        (f_dwadd_epd if add else f_dwwrite_epd)(_arr_epd(array) + p, value)
    elif _is_varray8(array):
        # 값 칸 = 변수 트리거(72바이트)마다 +348 (두 판 같음: 0.76 `18 * i + 348 // 4`, 0.81 `87 + _epd + 18 * i`)
        (f_dwadd_epd if add else f_dwwrite_epd)(_arr_epd(array) + 348 // 4 + 18 * p, value)
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
                # 1.2: 매 사이클 이동 상태를 UM_Hidden 으로 다시 고정 (그 칸이 아직 채널 종류일 때만 - 죽은 채널 칸이
                # 다른 유닛에 다시 쓰였으면 그 유닛을 멈추게 되므로. 없어진 채널은 CheckChannels 가 지운다)
                if EUDIf()(MemoryXEPD(epd + 0x64 // 4, Exactly, SNQCUnit, 0xFFFF)):
                    DoActions(SetMemoryXEPD(epd + 0x94 // 4, SetTo, UM_HIDDEN << 24, 0xFF000000))
                EUDEndIf()
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
        # 보내는 쪽 조건의 CurrentPlayer = 이 PC 플레이어 (MSQC 와 같다). 1.0 은 이걸 안 해서 Deaths(CurrentPlayer, ...) 줄이
        # 앞 트리거가 남긴 CP 로 읽혔다 - CtrigAsm 맵은 CP 에 EPD 를 남기므로 엉뚱한 주소를 읽어 EUD 오류 (MSF_UE_RE, 1.1 에서 고침)
        f_setcurpl(f_getuserplayerid())
        SendQC()
    EUDEndIf()
    ReceiveQC()
    f_setcurpl(origcp)
