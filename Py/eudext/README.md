# eudext 는 전용 저장소로 옮겼다

새 코드용 eudplib 라이브러리 **eudext** 의 설계도·명세·코드는 2026-09-17 부터 전용 저장소에서 관리한다.

- 저장소: **GitHub `Mininii/eudext`** (비공개) — `git clone git@github.com:Mininii/eudext.git`
- 이 PC 의 작업 사본: `C:\Users\whatd\Documents\eudext`
- 라이브러리 본체와 설계도: 그 저장소의 `eudext/` (`eudext/DESIGN.md`)
- 조사·명세 문서: `eudext/docs/research/`, `eudext/docs/spec/`
- 마스크 뺄셈 인게임 시험: `eudext/docs/spec/S8_ingame/build.bat`

이 폴더에는 이 안내 파일만 남겼다. 옮기기 전의 설계 1차본은 이 저장소의 커밋 `ee46d72` 에 있다.
CtrigAsm ↔ eudplib 기능 비교(`Py/CtrigAsm_vs_eudplib/`)는 그대로 여기에 있고, 같은 사본이 eudext 저장소의 `compare/` 에도 있다.

이 폴더에는 `__init__.py` 가 없으므로 옛 eds 가 `EudextRoot` 로 `MapSource\Py` 를 가리키면 부트 플러그인이
"EudextRoot 에 eudext 패키지가 없습니다" 오류를 낸다. eds 를 새 저장소 경로로 바꾼다.
