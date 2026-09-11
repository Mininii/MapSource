# -*- coding: utf-8 -*-
"""Title, credits and in-game text substitutions for the remade map.

The gameplay (1663 triggers) is the original author's work, so the original
credit line is kept and only the setting name and the terrain credit change.
"""

OLD_SETTING = "쥬림산맥"
OLD_SETTING_SP = "쥬림 산맥"
OLD_WORD = "쥬림"
NEW_SETTING = "황혼협곡"
NEW_WORD = "황혼"

OLD_TERRAIN_CREDIT = "지형 스나이퍼광"
NEW_TERRAIN_CREDIT = "지형 신규제작"
OLD_TERRAIN_BRACKET = "지형 [스나이퍼광]"
NEW_TERRAIN_BRACKET = "지형 [신규제작]"

MAP_TITLE = "마린키우기 황혼협곡 128"
MAP_DESC = ("원작: 마린키우기 쥬림산맥 2.8 (제작 픽시브)   "
            "128x128 트와일라잇 지형 신규 제작")
MAP_VERSION = "128x128 Remake v0.1"


def text_subs():
    """[(old utf-8 bytes, new utf-8 bytes)] applied to every string."""
    pairs = [
        (OLD_TERRAIN_BRACKET, NEW_TERRAIN_BRACKET),
        (OLD_TERRAIN_CREDIT, NEW_TERRAIN_CREDIT),
        (OLD_SETTING_SP, NEW_SETTING),
        (OLD_SETTING, NEW_SETTING),
        (OLD_WORD, NEW_WORD),
    ]
    return [(a.encode("utf-8"), b.encode("utf-8")) for a, b in pairs]


def text_replace():
    """{1-based STR index: utf-8 bytes} whole-string replacements."""
    return {
        1: MAP_TITLE.encode("utf-8"),
        2: MAP_DESC.encode("utf-8"),
        3: MAP_VERSION.encode("utf-8"),
    }
