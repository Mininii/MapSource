"""euddraft 불러오기 실험: 공용 패키지 경로를 sys.path 에 넣는 부트 플러그인."""
import os
import sys

from eudplib import *  # noqa: F401,F403

_s = {k.strip().lower(): v.strip() for k, v in settings.items()}  # noqa: F821
print("[boot] '__file__' in globals():", "__file__" in globals())
print("[boot] __name__ =", __name__, "cwd =", os.getcwd())
print("[boot] sys.path[:4] =", sys.path[:4])
print("[boot] sys.version =", sys.version.split()[0], "frozen =", getattr(sys, "frozen", False))
SHARED = _s["shared"]
if SHARED not in sys.path:
    sys.path.insert(0, SHARED)

import eudext  # noqa: E402  (불러오는 동안에만 SHARED 가 sys.path 에 있다)
from eudext import i64  # noqa: E402,F401

# 표준 라이브러리 존재 확인 (번들에 없는 것)
for name in ("colorsys", "configparser", "tomllib", "sqlite3", "timeit", "graphlib", "fractions",
             "dataclasses", "functools", "itertools", "math", "struct", "json", "csv", "uuid"):
    try:
        __import__(name)
        ok = "OK"
    except Exception as e:  # noqa: BLE001
        ok = "없음 (%s)" % type(e).__name__
    print("[boot] import %-13s %s" % (name, ok))

try:
    import lupa  # noqa: F401
    print("[boot] lupa: OK (venv 경로 없이)")
except Exception as e:  # noqa: BLE001
    print("[boot] lupa: 없음", type(e).__name__)


def onPluginStart():
    print("[boot.onPluginStart] SHARED in sys.path:", SHARED in sys.path)
    try:
        import eudext.lazymod  # noqa: F401  패키지가 이미 올라와 있으면 __path__ 로 찾는다
        print("[boot.onPluginStart] 지연 하위 모듈 eudext.lazymod: OK")
    except Exception as e:  # noqa: BLE001
        print("[boot.onPluginStart] 지연 하위 모듈 eudext.lazymod: 실패", repr(e))
    try:
        import rootmod  # noqa: F401  SHARED 바로 밑의 비패키지 모듈
        print("[boot.onPluginStart] rootmod: OK")
    except Exception as e:  # noqa: BLE001
        print("[boot.onPluginStart] rootmod: 실패", repr(e))
    try:
        import localpy  # noqa: F401  eds 폴더의 모듈
        print("[boot.onPluginStart] localpy(eds 폴더): OK")
    except Exception as e:  # noqa: BLE001
        print("[boot.onPluginStart] localpy(eds 폴더): 실패", repr(e))
