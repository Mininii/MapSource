"""MSF_UE_RE 음원을 빌드 때 맵에 넣는 euddraft 플러그인. theSeed_BGMInput.py 와 같은 일을 한다.

음원 원본은 맵이 아니라 C:/euddraft0.9.2.0/MSF_UE_RE_BGM/ 에 있다 (tools/split_map.py 가 원본 맵에서
꺼내 둔다). 그 폴더의 .ogg/.wav 를 전부 원래 이름 'staredit\\wav\\<파일명>' 으로 출력 맵의 MPQ 에
넣는다. 트리거의 PlayWAV 문자열과 chk 의 WAV 목록이 이 이름을 가리킨다.

tools/build_scrdb.py 가 이 파일을 eds 옆에 복사하고 [MSF_UE_RE_BGMInput.py] 섹션으로 부른다.
섹션의 `Path : <폴더>` 로 음원 폴더를 바꿀 수 있다. 음원을 더하려면 폴더에 넣고 다시 빌드한다.
"""
from eudplib import *
import os

BGM_DIR = "C:/euddraft0.9.2.0/MSF_UE_RE_BGM/"
SOUND_EXT = (".ogg", ".wav")


def _bgm_dir():
    try:
        opts = {k.strip().lower(): v for k, v in settings.items()}  # euddraft 가 넣어 주는 섹션 설정
    except NameError:
        return BGM_DIR
    return opts.get("path", "").strip() or BGM_DIR


def Exec_OggFile():
    src = _bgm_dir()
    names = sorted(f for f in os.listdir(src)
                   if os.path.splitext(f)[1].lower() in SOUND_EXT and os.path.isfile(os.path.join(src, f)))
    total = 0
    for filename in names:
        with open(os.path.join(src, filename), "rb") as f:
            data = f.read()
        MPQAddFile("staredit\\wav\\" + filename, data)
        total += len(data)
    print("[MSF_UE_RE_BGMInput] %s : %d files, %.1f MB" % (src, len(names), total / 1e6))


def onPluginStart():
    Exec_OggFile()
