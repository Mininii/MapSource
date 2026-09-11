# -*- coding: utf-8 -*-
"""Title, credits and in-game text for the remade map.

The gameplay - all 1663 triggers - is the original author's work, so the credit
line keeps 픽시브 as 원작 and names Opus5 only for this map. The source map's
intro types its credits out one character at a time, so every prefix of each
credit phrase needs its own replacement; `strings.substitute` applies them in a
single longest-match-first pass so nothing is substituted twice.
"""

MAP_TITLE = "마린키우기 황혼협곡 1.0"
MAP_DESC = ("제작 Opus5   |   픽시브가 제작한 마린키우기 쥬림산맥을 학습하여 만든 맵입니다"
            "   |   128x128 트와일라잇, 지형과 배치 전면 신규 제작")
MAP_VERSION = "황혼협곡 1.0"


def _prefixes(old, new, keep=0):
    """Replacements for every prefix of `old`, longest first, so a credit that is
    typed out character by character stays consistent through the animation.
    A prefix ending in a space keeps its space, so an unrelated phrase that just
    starts with the same word does not get glued together."""
    out = []
    for n in range(len(old), keep, -1):
        cut = int(round(len(new) * n / float(len(old))))
        piece = new[:cut]
        if old[n - 1] == " ":
            piece = piece.rstrip() + " "
        out.append((old[:n], piece))
    return out


PAIRS = []
# the in-game credit box, matched whole so its leading label changes too
PAIRS.append(("제작 - 픽시브 스나이퍼광[지형]", "만든이 - 픽시브[원작] Opus5[제작]"))
PAIRS.append(("픽시브 스나이퍼광[지형]", "픽시브[원작] Opus5[제작]"))
# bracketed form used by the difficulty banner
PAIRS.append(("지형 [스나이퍼광]", "제작 [Opus5]"))
PAIRS.append(("지형:스나이퍼광", "제작:Opus5"))
PAIRS.append(("제작:픽시브", "원작:픽시브"))
# the terrain credit becomes this map's author
PAIRS += _prefixes("지형 스나이퍼광", "제작 Opus5", keep=1)
PAIRS.append(("지형", "제작"))
# the original author moves from 제작 to 원작
PAIRS += _prefixes("제작 픽시브", "원작 픽시브", keep=2)
PAIRS.append(("제작", "원작"))
# the setting is renamed
PAIRS += [("쥬림 산맥", "황혼협곡"), ("쥬림 산", "황혼협"),
          ("쥬림산맥", "황혼협곡"), ("쥬림산", "황혼협"),
          ("쥬림 ", "황혼 "), ("쥬림", "황혼"), ("쥬", "황")]


def text_subs():
    """[(old, new)] text pairs - applied longest-match first, ignoring the colour
    codes the source map sprinkles between letters."""
    return list(PAIRS)


def text_replace():
    """{1-based STR index: utf-8 bytes} whole-string replacements."""
    return {
        1: MAP_TITLE.encode("utf-8"),
        2: MAP_DESC.encode("utf-8"),
        3: MAP_VERSION.encode("utf-8"),
    }
