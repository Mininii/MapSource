# -*- coding: utf-8 -*-
"""R1 사용량 조사: 맵 코드에서 CtrigAsm 기능 호출 수를 센다 (주석 제외).
출력: r1_raw.json (이름별·맵별 호출 수, 인자 예), r1_top.txt (맵별 상위 호출)
"""
import os, re, json, fnmatch, collections, pathlib

SD = r"C:\Users\whatd\Desktop\Stormcoast Fortress\ScmDraft 2"
LIB = SD + r"\MapSource\Library"
LISTS = SD + r"\MapSource\Py\CtrigAsm_vs_eudplib\lists"
TPL = r"C:\Users\whatd\Documents\MSF-Template"
OUT = os.path.dirname(os.path.abspath(__file__))


def read_text(p):
    b = open(p, 'rb').read()
    if b.startswith(b'\xef\xbb\xbf'):
        b = b[3:]
    try:
        return b.decode('utf-8')
    except UnicodeDecodeError:
        return b.decode('cp949', errors='replace')


def blank(seg):
    return re.sub(r'[^\n]', ' ', seg)


LUA_TOK = re.compile(r'--|["\']|\[=*\[')


def strip_lua(s):
    """returns (code, mask): code = comments blanked; mask = comments+string bodies blanked. same length."""
    code, mask = [], []
    i, n = 0, len(s)
    while i < n:
        m = LUA_TOK.search(s, i)
        if not m:
            code.append(s[i:]); mask.append(s[i:]); break
        j = m.start()
        code.append(s[i:j]); mask.append(s[i:j])
        t = m.group(0)
        if t == '--':
            lm = re.match(r'--\[(=*)\[', s[j:j + 64])
            if lm:
                close = ']' + lm.group(1) + ']'
                k = s.find(close, j + lm.end())
                k = n if k < 0 else k + len(close)
            else:
                k = s.find('\n', j)
                k = n if k < 0 else k
            seg = s[j:k]
            code.append(blank(seg)); mask.append(blank(seg)); i = k
        elif t in ('"', "'"):
            k = j + 1
            while k < n and s[k] != t and s[k] != '\n':
                if s[k] == '\\':
                    k += 2
                    continue
                k += 1
            if k < n and s[k] == t:
                k += 1
            seg = s[j:k]
            code.append(seg)
            mask.append(seg[0] + blank(seg[1:-1]) + seg[-1] if len(seg) >= 2 else seg)
            i = k
        else:  # long string
            eq = t[1:-1]
            close = ']' + eq + ']'
            k = s.find(close, m.end())
            k = n if k < 0 else k + len(close)
            seg = s[j:k]
            code.append(seg)
            mask.append(t + blank(seg[len(t):]))
            i = k
    c, mk = ''.join(code), ''.join(mask)
    assert len(c) == len(s) == len(mk)
    return c, mk


EPS_TOK = re.compile(r'//|/\*|["\']')


def strip_eps(s):
    code, mask = [], []
    i, n = 0, len(s)
    while i < n:
        m = EPS_TOK.search(s, i)
        if not m:
            code.append(s[i:]); mask.append(s[i:]); break
        j = m.start()
        code.append(s[i:j]); mask.append(s[i:j])
        t = m.group(0)
        if t == '//':
            k = s.find('\n', j); k = n if k < 0 else k
            seg = s[j:k]; code.append(blank(seg)); mask.append(blank(seg)); i = k
        elif t == '/*':
            k = s.find('*/', j + 2); k = n if k < 0 else k + 2
            seg = s[j:k]; code.append(blank(seg)); mask.append(blank(seg)); i = k
        else:
            k = j + 1
            while k < n and s[k] != t and s[k] != '\n':
                if s[k] == '\\':
                    k += 2; continue
                k += 1
            if k < n and s[k] == t:
                k += 1
            seg = s[j:k]
            code.append(seg)
            mask.append(seg[0] + blank(seg[1:-1]) + seg[-1] if len(seg) >= 2 else seg)
            i = k
    return ''.join(code), ''.join(mask)


# ---------------------------------------------------------------- 맵 정의
def P(*a):
    return os.path.join(*a)


MAPS = [
    # key, root, include globs, exclude globs, group
    ('DPS', P(SD, 'DPS_eud'), ['*.lua', '*.eps', 'CallTriggers/**/*.lua', 'recover/*.lua'], [], 'main'),
    ('theSeed', P(SD, 'theSeed'), ['**/*.lua', '**/*.eps'], ['Engine/G_CB_Lib.lua'], 'main'),
    ('Stella_II', P(SD, 'Stella_II'), ['**/*.lua', '**/*.eps'], ['Engine/*'], 'main'),
    ('Respect_V', P(SD, 'MSF_Respect_V'), ['**/*.lua', '**/*.eps'], ['G_CBPlot.lua'], 'main'),
    ('Memory_2', P(SD, 'MapSource', 'MSF_Memory_2'), ['**/*.lua', '**/*.eps'], [], 'main'),
    ('Memory', P(SD, 'MapSource', 'MSF_Memory'), ['**/*.lua', '**/*.eps'], [], 'main'),
    ('GaLaXy2R', P(SD, 'MapSource', 'MSF_GaLaXy.2_R'), ['**/*.lua', '**/*.eps'], [], 'main'),
    ('UE_RE', P(SD, 'MapSource', 'MSF_UE_RE'), ['**/*.lua', '**/*.eps'], [], 'main'),
    ('Breeze', P(SD, 'MapSource', 'MSF_Breeze'), ['**/*.lua', '**/*.eps'], [], 'main'),
    ('Template', TPL, ['*.lua'], ['G_CB_Lib.lua'], 'main'),
    ('GaLaXy', P(SD, 'MapSource', 'MSF_GaLaXy'), ['**/*.lua'], [], 'old'),
    ('GaLaXyR', P(SD, 'MapSource', 'MSF_GaLaXy.R'), ['**/*.lua', '**/*.eps'], [], 'old'),
    ('GaLaXy2', P(SD, 'MapSource', 'MSF_GaLaXy.2'), ['**/*.lua', '**/*.eps'], [], 'old'),
    ('UE', P(SD, 'MapSource', 'MSF_UE'), ['**/*.lua', '**/*.eps'], [], 'old'),
    ('NTM1', P(SD, 'MapSource', 'NewTestMap1'), ['**/*.lua', '**/*.eps'], [], 'old'),
    ('NTM3', P(SD, 'MapSource', 'NewTestMap3'), ['**/*.lua', '**/*.eps'], [], 'old'),
    ('TestCode', P(SD, 'MapSource', 'TestCode'), ['**/*.lua'], ['G_CB_Lib.lua'], 'old'),
    ('MEME', P(SD, 'MSF_MEME_EUD'), ['*.lua'], [], 'old'),
    ('ref_GCB', TPL, ['G_CB_Lib.lua'], [], 'ref'),
]


def list_files(root, inc, exc):
    rootp = pathlib.Path(root)
    out = set()
    for g in inc:
        for p in rootp.glob(g):
            if not p.is_file():
                continue
            rel = p.relative_to(rootp).as_posix()
            if '.git/' in rel or rel.startswith('.git'):
                continue
            if any(fnmatch.fnmatch(rel, e) for e in exc):
                continue
            out.add(rel)
    return sorted(out)


# ---------------------------------------------------------------- 이름 목록
def defs_in(path):
    s = read_text(path)
    return set(re.findall(r'(?m)^\s*(?:local\s+)?function\s+([A-Za-z_][\w.]*)', s))


ctrig_all = set(l.strip() for l in open(P(LISTS, 'a4_ctrig_funcs.txt'), encoding='utf-8', errors='replace') if l.strip())
guide = collections.defaultdict(set)
cur = 0
for line in open(P(LISTS, 'a4_guide_funcs.txt'), encoding='utf-8', errors='replace'):
    m = re.match(r'(\d+):\s*(.*)', line)
    if not m:
        continue
    t = m.group(2)
    cm = re.search(r'『\s*(\d+)장', t)
    if cm:
        cur = int(cm.group(1)); continue
    nm = re.match(r'([A-Za-z_]\w*)\s*\(', t)
    if nm and '→' not in t:
        guide[cur].add(nm.group(1))

cbp = defs_in(P(LIB, 'CB Paint v2.5.lua')) | defs_in(P(LIB, 'CS_Addon.lua')) | defs_in(P(LIB, 'CSMakeSpiral.lua'))
dpl = defs_in(P(LIB, 'DisplayPrint.lua'))
l322 = defs_in(P(LIB, 'LibraryFor322.lua'))
extra = defs_in(P(LIB, 'Extra.lua'))
tsd = defs_in(P(LIB, 'TStruct.lua'))
obs = defs_in(P(LIB, 'ObserverChat.lua')) | defs_in(P(LIB, 'ObserverChatAlways.lua'))
cus = defs_in(P(LIB, 'CreateUnitShape.lua')) | defs_in(P(LIB, 'CreateUnitPolygonSafe2Gun[Move].lua'))
scrdb = defs_in(P(LIB, 'SCR_DB_Core.lua'))
gcb = defs_in(P(TPL, 'G_CB_Lib.lua')) | defs_in(P(SD, 'MSF_Respect_V', 'G_CBPlot.lua')) | defs_in(P(SD, 'MapSource', 'TestCode', 'G_CB_Lib.lua'))
tplf = defs_in(P(TPL, 'func.lua'))
libnames = ctrig_all | cbp | dpl | l322 | extra | tsd | obs | cus | scrdb

# 기능 분류: (feature, sub) -> predicate/name set
W_RE = re.compile(r'War(?!p)|WArr|WAar|LArr|LDb|LMem|^f_L(?!engthdir|og2|oadCp)|^_L(?!engthdir|og2|oc)|^I64|^(f_|_)i?Cast(W)?$|64Bit|^LPush$|^LPop$|^W$|^Wi$|LCallLabel|TTLMemory|Wariable|WArray')

CAT = collections.OrderedDict()


def add(key, names):
    CAT[key] = set(names)


w_all = {n for n in ctrig_all if W_RE.search(n)} | {'Bit64_HP_SystemX', 'CreateWarArr2'}
w_decl = {n for n in w_all if re.search(r'^Create|^W$|^Wi$|^CWariable|^CWArray|^GetWArray|^LArray$|^LDb$|^WArr|^LArr|^Convert[WL]Arr|^_?LMem$|LCallLabel|^CallWariable|^f_Get(File)?WArrptr|^LPush|^LPop|^I64|64Bit$|^Not64Bit|^Is64Bit', n)}
w_arith = {n for n in w_all if re.search(r'^f_L|^_L(?!Mem$)|Cast|^_?TLMem$|^Include_64BitLibrary$', n)} - w_decl
w_cond = w_all - w_decl - w_arith - {'Bit64_HP_SystemX'}
add(('1 64bit', 'W 선언·참조'), w_decl)
add(('1 64bit', 'W 산술·읽기쓰기'), w_arith)
add(('1 64bit', 'W 조건·액션·비교'), w_cond)
add(('1 64bit', '64비트 체력'), {'Bit64_HP_SystemX'})

add(('2 숫자출력', 'ItoDec/ItoHex 류'), {'ItoDec', 'ItoHex', 'ItoDecX', 'ItoHexX', 'ItoX'})
add(('2 숫자출력', 'CA__ItoCustom 류'), {'CA__ItoCustom', 'CA__lItoCustom', 'CS__ItoCustom', 'CS__lItoCustom', 'CA__DwItoName', 'CS__DwItoName'})
add(('2 숫자출력', 'CD__Scan 류'), {n for n in ctrig_all if re.match(r'C[DS]__Scan', n)})
add(('2 숫자출력', 'DisplayPrint 틀'), (dpl - {'PName'}) | {'dp.*'})
add(('2 숫자출력', 'CAPrint/CDPrint 틀'), {'CAPrint', 'CBPrint', 'CDPrint', 'C13Print', 'CSPrint', 'CreateSV54', 'Print_13', 'CAPrintAllocCheck', 'FixText'})
add(('2 숫자출력', 'iStr 준비'), {n for n in ctrig_all if re.search(r'iStr|SVA1|SVA32|SVA54|SVAar', n)})
add(('2 숫자출력', '채팅줄 상수 출력'), {'print_utf8', 'check_utf8', 'print_utf8X', 'check_utf8X', 'Print_String', 'Print_StringX', 'check_utf8X_Add', 'iStrColorFillX', 'print_utf8_2'})
add(('2 숫자출력', 'DPS Converter(128/256비트 출력)'), {'Converter.*'})
add(('2 숫자출력', '디스플레이 줄'), {'Display', 'TTDisplay', 'DisplayX', 'TTDisplayX', 'f_Strlen', 'MakeChatOffset', 'f_ChatOffset', '_Chat'})

ca_fx = {'CA__MoveXY', 'CA__ConvertColor', 'CA__ConvertLetter', 'CA__Encode', 'CS__MoveXY', 'CS__ConvertColor', 'CS__ConvertLetter', 'CS__Encode'}
ca_all = {n for n in ctrig_all if re.match(r'C[ABDS]__', n)}
add(('3 글자효과', 'CA__MoveXY/Convert*/Encode'), ca_fx)
add(('3 글자효과', '그 밖의 CA__/CB__/CD__/CS__ 편집'), ca_all - ca_fx - CAT[('2 숫자출력', 'CA__ItoCustom 류')] - CAT[('2 숫자출력', 'CD__Scan 류')])

bul28 = {'CreateBullet', 'CreateBulletTarget', 'CreateStorm', 'CreateSprite', 'ScanSprite', 'UnitSprite', 'RecallSprite', 'BulletInitSetting', 'ScanInitSetting'}
add(('4 총알', '28장 총알·스프라이트'), bul28)
add(('4 총알', '사용자판 총알 함수'), {'CreateBulletXY', 'CreateBulletCond', 'CreateBulletLoc', 'SetBullet', 'CreateBulletX'})
dat28 = {n for n in guide[28] if re.match(r'T?Set(Image|Recall|Scan|Sprite|Bullet|Dimension)', n)} | {n for n in ctrig_all if re.match(r'T?T?Set(Image|RecallImage|ScanImage|SpriteImage|Bullet|Dimension)', n)}
add(('4 총알', 'dat 수정(28장)'), dat28)
add(('4 총알', 'CGRP/BMP'), {n for n in (ctrig_all | cbp) if re.match(r'CS_(PrintBMP|BMP)', n)})
add(('4 총알', '파일 삽입(29장)'), {n for n in ctrig_all if re.match(r'f_Get(File|VArr|SVArr|Void|TRIG)|^FArr$|^SaveFileArr$|^f_GetFileSize$', n)} - w_all)

add(('5 입력', 'KeyPress/MousePress'), {'KeyPress', 'MousePress', 'TTKeyPress', 'TTMousePress', 'ParseKeyName', 'ParseMouseName'})
add(('5 입력', 'IsTyping/NotTyping'), {'IsTyping', 'NotTyping'})
add(('5 입력', 'NSQC 함수'), {'NSQCSend', 'NSQCReceive', 'NSQCMov'})
add(('5 입력', '사용자 MSQC 헬퍼'), {'MSQC_KeySet', 'MSQC_KeyInput', 'MSQC_TKeyInput', 'MSQC_SetKeyInput', 'MSQC_ExportEdsTxt'})

add(('6 부호비교', 'iAtLeast 류 상수(참조)'), {'iAtLeast', 'iAtMost', 'iAbove', 'iBelow'})
add(('6 부호비교', '부호 있는 산술(참고)'), {'CiSub', 'CiDiv', 'CiMod', 'f_iMul', 'f_iDiv', 'f_iMod', '_iSub', '_iMul', '_iDiv', '_iMod', '_iDivX', '_iModX', 'CNeg', '_Neg', 'f_Abs', '_Abs', 'f_SHRead', '_SHRead', 'CiMul'})

add(('7 수학', 'f_Lengthdir'), {'f_Lengthdir', '_Lengthdir'})
add(('7 수학', 'f_Atan2'), {'f_Atan2', '_Atan2'})
add(('7 수학', 'f_Sqrt'), {'f_Sqrt', '_Sqrt'})
add(('7 수학', 'f_Log2'), {'f_Log2', '_Log2'})
add(('7 수학', 'f_Diff/f_SDiff'), {'f_Diff', 'f_SDiff'})
add(('7 수학', 'CMathFunc'), {'CMathFunc', 'CMathFunc2'})
add(('7 수학', 'Include_CtrigPlib/MatheMatics'), {'Include_CtrigPlib', 'Include_MatheMatics'})
add(('7 수학', '기타(난수범위·거듭제곱·운동)'), {'f_CRandNum', 'Include_CRandNum', 'f_Sqrd', 'Install_f_Sqrd', 'CMotion'})

add(('8 CXPaint', 'CSMake*'), {n for n in cbp if n.startswith('CSMake')})
add(('8 CXPaint', 'CS_* 편집'), {n for n in cbp if n.startswith('CS_')} - CAT[('4 총알', 'CGRP/BMP')])
add(('8 CXPaint', 'CSPlot/CSSave/CSLoad'), {n for n in cbp if re.match(r'CS(Plot|Save|TSave|Load)', n)})
add(('8 CXPaint', 'CAPlot/CBPlot/CXPlot/CVPlot'), {n for n in cbp if re.match(r'C[ABXV]Plot', n)})
add(('8 CXPaint', 'CA_/CB_ 실시간 편집'), {n for n in cbp if re.match(r'C[AB]_', n)} | {'CV_MoveXY'})
add(('8 CXPaint', 'CX 3D'), {n for n in cbp if re.match(r'CX(?!Plot)', n)})
add(('8 CXPaint', 'Include_CBPaint'), {'Include_CBPaint', 'Include_CBLast'})
add(('8 CXPaint', 'CreateUnitShape'), cus)
add(('8 CXPaint', 'G_CB_Lib API(사용자 라이브러리)'), gcb - {'CA_Func1', 'CB_TCopy'} | {'G_CB_SetSpawn', 'G_CB_TSetSpawn'})

add(('9 기타', '방장'), {'GetHostPlayerID', 'GetHostName', 'GetHostLength', 'ItoHost', 'HostName'})
add(('9 기타', 'HotkeyUnit'), {'HotkeyUnit', 'SetHotkeyUnit', 'THotkeyUnit', 'TSetHotkeyUnit', 'TTHotKeyUnit', '_HotKeyUnit', 'TTHotkeyUnit'})
add(('9 기타', 'ObserverChat'), obs - {'KeyPress', 'ParseKeyName', 'LocalPlayerID', 'MemoryB'})
add(('9 기타', 'ExitDrop'), {'ExitDrop'})
add(('9 기타', 'FindSD/WideScreen'), {'FindSD', 'FindSDLocal'})
add(('9 기타', '이름(플레이어 이름)'), {'GetPlayerName', 'GetPlayerLength', 'ItoName', 'PlayerName', 'isname', 'setname', 'SetUnitName', 'PName', 'CA__GetName', 'CA__ItoName'})
add(('9 기타', '로컬·관전자·사람 판정'), {'LocalPlayerID', 'TLocalPlayerID', 'isObserverPlayer', 'isNotObserverPlayer', 'PlayerCheck', 'HumanCheck', 'Enable_HumanCheck', 'Enable_PlayerCheck'})
add(('9 기타', '오류문구 숨김·유통기한·터보·밀림'), {'Enable_HideErrorMessage', 'UnixTime', 'EUDTurbo', 'NoAirCollision', 'NoAirCollisionX'})

add(('10 대체', 'TStruct'), tsd)
add(('10 대체', 'EXCC'), {n for n in (l322 | ctrig_all | tplf) if 'EXCC' in n} | {'Set_EXCC3', 'Set_EXCC3X', 'Cond_EXCC3'})
add(('10 대체', 'CunitCtrig'), {n for n in ctrig_all if n.startswith('CunitCtrig')})
add(('10 대체', 'Timer/TimerX/Stage'), {'Timer', 'TimerX', 'Stage'})
add(('10 대체', 'SCR_DB'), scrdb)
add(('10 대체', 'BGM'), {'AddBGM', 'Install_BGMSystem', 'IBGM_EPD', 'IBGM_EPDX', 'NormalTurboSet'})
add(('10 대체', 'CABoss'), {'CABoss', 'CA_SetLHP'})
add(('10 대체', 'NBag/NQueue/NStack'), {n for n in ctrig_all if re.match(r'N(Bag|Queue|Deque|Stack|Push|Pop|Append|Remove|Enqueue|Dequeue|Reset)', n)} | {'NGetThisptr', 'NGetThisidx', 'NGetLastptr', 'NGetLastidx', '_PTR'})
add(('10 대체', 'CPush/CPop'), {'CPush', 'CPop'})
add(('10 대체', 'CFunc/VFunc'), {n for n in ctrig_all if re.match(r'(Init|Call)?[CV]Func|_Func$|_VFunc$|TTV?Func$|CFuncEnd|CFuncReturn', n)})
add(('10 대체', 'SetCall/CallTrigger'), {'SetCall', 'SetCall2', 'SetCallEnd', 'SetCallEnd2', 'SetCallForward', 'CallTrigger', 'CallTriggerA', 'CallTriggerX', 'TCallTriggerX', 'CreateCallIndex', 'SetNextForward', 'SetCallErrorCheck'})
add(('10 대체', 'Overflow_HP'), {'Overflow_HP_System', 'Overflow_HP_SystemX'})

# 11 관용구 (정규식, code 에서 셈)
IDIOMS = collections.OrderedDict([
    ('CP 주소 0x6509B0 직접', r'0x6509[bB]0'),
    ('SetCp/TSetCp/AddCp/TAddCp', r'(?<![\w.])T?(SetCp|AddCp)\s*\('),
    ('f_SaveCp/f_LoadCp', r'(?<![\w.])f_(Save|Load)Cp\s*\('),
    ('RotatePlayer(CP 순회 액션)', r'(?<![\w.])RotatePlayer\s*\('),
    ('CopyCpAction', r'(?<![\w.])CopyCpAction\w*\s*\('),
    ('DisplayTextX/PlayWAVX 류', r'(?<![\w.])(DisplayTextX|PlayWAVX|SetMissionObjectivesX|TransmissionX|MinimapPingX|TalkingPortraitX)\s*\('),
    ('for i=0,6/7 플레이어 반복', r'\bfor\s+\w+\s*=\s*0\s*,\s*[67]\s+do'),
    ('for i=1,7/8 반복', r'\bfor\s+\w+\s*=\s*1\s*,\s*[78]\s+do'),
    ('CreateVarArr/VArrArr 류(플레이어별 배열)', r'(?<![\w.])Create(Var|VArr|Ccode|Ncode|War|WArr|SVar|Arr)Arr\w*\s*\('),
    ('×604/×0x970/×2416 번호 산술', r'\*\s*(604|0x970|2416|0x25C)\b|\b(604|2416)\s*\*'),
    ('0x628438(다음 유닛 포인터)', r'0x628438'),
    ('0x596A18(키 배열)', r'0x596[aA]18'),
    ('0x6CDDC0/C4/C8(마우스)', r'0x6CDD[cC][048]'),
    ('0x68C144(채팅 중)', r'0x68[cC]144'),
    ('0x57EEE8/0x57EEEB(플레이어 이름칸)', r'0x57EEE[8bB]'),
    ('0x6D0F78(방장 이름)', r'0x6D0F78'),
    ('0x512684(로컬 플레이어)', r'0x512684'),
    ('Simple_SetLoc/CalcLoc', r'(?<![\w.])Simple_(SetLoc|CalcLoc)\w*\s*\('),
    ('ConvertLocation', r'(?<![\w.])ConvertLocation\s*\('),
    ('SetCtrig1X/2X/X(트리거 자기수정)', r'(?<![\w.])(T)?SetCtrig[12]?X\s*\('),
    ('TTOR/TTAND', r'(?<![\w.])(TTOR|TTAND)\s*\('),
    ('CunPack/CDoActionsX/CTriggerX', r'(?<![\w.])(CunPack|CDoActionsX|CTriggerX|CDoActions2X|CTrigger2X)\s*\('),
    ('"i>=" 등 부호 비교 문자열', r'["\']i(>=|<=|>|<)["\']'),
    ('"MSQC"/"NSQC" 이름 참조', r'[MN]SQC'),
    ('WideScreen 참조', r'WideScreen'),
    ('f_GetVoidptr', r'(?<![\w.])f_GetVoidptr\s*\('),
    ('StrDesign/StrDesignX(문자열 꾸밈)', r'(?<![\w.])StrDesignX?\d?\s*\('),
    ('TSetMemoryB/W, TMemoryB/W 류', r'(?<![\w.])T?T?(Set)?Memory[BW]X?\s*\('),
    ('f_Bread/f_Wread/f_Bwrite/f_Wwrite', r'(?<![\w.])(f_|_)[BW](read|write)X?\s*\('),
    ('Include_* 호출', r'(?<![\w.])(Include|Install)_\w+\s*\('),
])

name2cat = {}
for k, names in CAT.items():
    for nm in names:
        name2cat.setdefault(nm, k)

# ---------------------------------------------------------------- 스캔
CALL_RE = re.compile(r'(?<![\w.:])([A-Za-z_]\w*)\s*\(')
DOT_RE = re.compile(r'(?<![\w.:])([A-Za-z_]\w*)[.:]([A-Za-z_]\w*)\s*\(')
IDENT_RE = re.compile(r'(?<![\w.:])([A-Za-z_]\w*)\b')
DEF_BEFORE = re.compile(r'function\s+$')


def match_paren(mask, open_pos):
    depth = 0
    for k in range(open_pos, min(len(mask), open_pos + 20000)):
        ch = mask[k]
        if ch in '([{':
            depth += 1
        elif ch in ')]}':
            depth -= 1
            if depth == 0:
                return k
    return None


calls = collections.defaultdict(lambda: collections.Counter())     # name -> map -> n
refs = collections.defaultdict(lambda: collections.Counter())      # name -> map -> n (bare ident, not call/def)
examples = collections.defaultdict(list)                           # name -> [(map, file, line, args)]
alldefs = collections.defaultdict(set)                             # map -> defined names
top_calls = collections.defaultdict(collections.Counter)           # map -> name -> n
idiom = collections.defaultdict(collections.Counter)               # idiom -> map -> n
idiom_ex = collections.defaultdict(list)
files_used = collections.defaultdict(list)
lines_count = collections.Counter()
dot_calls = collections.defaultdict(lambda: collections.Counter())


def lineno(lstarts, pos):
    import bisect
    return bisect.bisect_right(lstarts, pos)


# 맵 파일 안에 들어 있는 라이브러리 사본(함수 몸체)은 세지 않는다.
KEEP_BODY = {'CreateBullet', 'CreateBulletXY', 'CreateBulletCond', 'CreateBulletLoc', 'SetBullet', 'Install_CBullet',
             'MSQC_KeySet', 'MSQC_KeyInput', 'MSQC_TKeyInput', 'MSQC_SetKeyInput', 'MSQC_ExportEdsTxt',
             'CreateVarArr2', 'CreateWarArr2', 'SetMemoryWX', 'Set_EXCC3', 'Set_EXCC3X', 'Cond_EXCC3', 'TestSet'}
GCB_RE = re.compile(r'^(G_CB|f_Temp|T_to_B|Create_G_CB|Include_G_CB|CB_|CBRandSort|CElseIfX_AddRepeatType|T?AutoSetV|CA_Func1)')
KW_RE = re.compile(r'(?<![\w.])(function|if|do|repeat|end|until)(?!\w)')


def is_copy_name(nm):
    if nm in KEEP_BODY:
        return False
    return nm in libnames or nm in gcb or bool(GCB_RE.match(nm))


def copy_spans(mask):
    spans = []
    for m in re.finditer(r'(?<![\w.])function\s+([A-Za-z_][\w.:]*)\s*\(', mask):
        nm = m.group(1)
        if not is_copy_name(nm):
            continue
        depth = 0
        end = len(mask)
        for k in KW_RE.finditer(mask, m.start()):
            w_ = k.group(1)
            if w_ in ('function', 'if', 'do', 'repeat'):
                depth += 1
            else:
                depth -= 1
                if depth == 0:
                    end = k.end(); break
        spans.append((m.start(), end, nm))
    # 바깥 것만 남김
    spans.sort()
    merged = []
    for s_, e_, nm in spans:
        if merged and s_ < merged[-1][1]:
            continue
        merged.append((s_, e_, nm))
    return merged


def in_spans(spans, pos):
    for s_, e_, _ in spans:
        if s_ <= pos < e_:
            return True
    return False


copy_report = collections.defaultdict(list)  # map -> [(file, name, startline, endline)]
skipped = collections.Counter()


for key, root, inc, exc, grp in MAPS:
    for rel in list_files(root, inc, exc):
        path = os.path.join(root, rel)
        s = read_text(path)
        if rel.endswith('.eps'):
            code, mask = strip_eps(s)
        else:
            code, mask = strip_lua(s)
        files_used[key].append(rel)
        lines_count[key] += s.count('\n') + 1
        lstarts = [0] + [m.end() for m in re.finditer('\n', s)]
        spans = [] if rel.endswith('.eps') or grp == 'ref' else copy_spans(mask)
        for s_, e_, nm in spans:
            copy_report[key].append((rel, nm, lineno(lstarts, s_), lineno(lstarts, e_ - 1)))
        if spans:
            # 사본 몸체를 공백으로 지운다 (줄 수 유지)
            ml, cl = list(mask), list(code)
            for s_, e_, _ in spans:
                ml[s_:e_] = blank(mask[s_:e_])
                cl[s_:e_] = blank(code[s_:e_])
            mask, code = ''.join(ml), ''.join(cl)
        # defs
        for m in re.finditer(r'function\s+([A-Za-z_][\w.:]*)', mask):
            alldefs[key].add(m.group(1))
        callpos = set()
        for m in CALL_RE.finditer(mask):
            nm = m.group(1)
            before = mask[max(0, m.start() - 20):m.start()]
            if DEF_BEFORE.search(before):
                continue
            if nm in ('function', 'if', 'and', 'or', 'not', 'return', 'elseif', 'while', 'until', 'local'):
                continue
            callpos.add(m.start())
            top_calls[key][nm] += 1
            if nm in name2cat:
                calls[nm][key] += 1
                op = m.end() - 1
                cp = match_paren(mask, op)
                args = code[op + 1:cp] if cp else code[op + 1:op + 200]
                args = re.sub(r'\s+', ' ', args).strip()
                examples[nm].append((key, rel, lineno(lstarts, m.start()), args[:220]))
        for m in DOT_RE.finditer(mask):
            a, b = m.group(1), m.group(2)
            before = mask[max(0, m.start() - 20):m.start()]
            if DEF_BEFORE.search(before):
                continue
            dot_calls[a + '.' + b][key] += 1
            if a in ('dp', 'Converter', 'Math128'):
                nm = {'dp': 'dp.*', 'Converter': 'Converter.*', 'Math128': 'Math128.*'}[a]
                calls[nm][key] += 1
                op = m.end() - 1
                cp = match_paren(mask, op)
                args = code[op + 1:cp] if cp else code[op + 1:op + 200]
                args = re.sub(r'\s+', ' ', args).strip()
                examples[nm].append((key, rel, lineno(lstarts, m.start()), a + '.' + b + '(' + args[:200]))
        for m in IDENT_RE.finditer(mask):
            nm = m.group(1)
            if m.start() in callpos:
                continue
            if nm in name2cat:
                before = mask[max(0, m.start() - 20):m.start()]
                if DEF_BEFORE.search(before):
                    continue
                # 호출 아닌 참조 (함수 값 전달, 상수)
                after = mask[m.end():m.end() + 3]
                if re.match(r'\s*\(', after):
                    continue
                refs[nm][key] += 1
                if nm in ('iAtLeast', 'iAtMost', 'iAbove', 'iBelow') or len(examples[nm]) < 40:
                    ln = lineno(lstarts, m.start())
                    linetxt = s.splitlines()[ln - 1] if ln - 1 < len(s.splitlines()) else ''
                    examples[nm].append((key, rel, ln, '[ref] ' + re.sub(r'\s+', ' ', linetxt).strip()[:200]))
        for iname, pat in IDIOMS.items():
            src = code if ('문자열' in iname or '참조' in iname) else mask
            for m in re.finditer(pat, src):
                idiom[iname][key] += 1
                if len(idiom_ex[iname]) < 60:
                    ln = lineno(lstarts, m.start())
                    idiom_ex[iname].append((key, rel, ln, re.sub(r'\s+', ' ', s.splitlines()[ln - 1]).strip()[:200]))

# 맵별 재정의(라이브러리 이름과 같은 함수를 맵이 정의)
overrides = {k: sorted(v & (libnames | set(name2cat))) for k, v in alldefs.items()}

res = {
    'maps': [(k, g) for k, _, _, _, g in MAPS],
    'files': files_used,
    'lines': lines_count,
    'cats': {' | '.join(k): sorted(v) for k, v in CAT.items()},
    'calls': {n: dict(c) for n, c in calls.items()},
    'refs': {n: dict(c) for n, c in refs.items()},
    'examples': examples,
    'overrides': overrides,
    'idiom': {k: dict(v) for k, v in idiom.items()},
    'idiom_ex': idiom_ex,
    'dot_calls': {k: dict(v) for k, v in dot_calls.items() if sum(v.values()) >= 3},
    'copy_report': copy_report,
}
json.dump(res, open(os.path.join(OUT, 'r1_raw.json'), 'w', encoding='utf-8'), ensure_ascii=False, indent=0)

with open(os.path.join(OUT, 'r1_top.txt'), 'w', encoding='utf-8') as f:
    for key, *_ in MAPS:
        f.write('== %s (%d files, %d lines)\n' % (key, len(files_used[key]), lines_count[key]))
        f.write(', '.join('%s:%d' % kv for kv in top_calls[key].most_common(150)) + '\n')
print('done')
