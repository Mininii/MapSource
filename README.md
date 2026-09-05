스타크래프트 맵 트리거 코드 작업물 라이브러리
=============

+ 스타크래프트 맵 제작에 사용한 라이브러리 입니다.
+ 주로 사용하는 언어는 Lua 이며 스타크래프트 맵 에디터인 SCM Draft의 TEP 2.0에 직접 복사한 후 붙여넣는 방식으로 사용합니다.
+ 가끔 euddraft의 eudplib 을 위해 Python도 사용합니다.
+ Library 폴더의 LibraryFor322.lua 를 제외한 코드는 본인 작성 코드가 아닙니다.
+ Plugins 폴더의 파일은 대부분 eudplib 의 플러그인에서 가져왔음을 알립니다.
+ 모든 Lua 파일의 인코딩은 UTF-8 로 변경, 사용 예정입니다.
+ 2025년 1월 5일 기준 일부 맵은 타 리포지토리로 분리 이동되었습니다.
+ 아직 타 리포지토리로 분리하지 않은 맵이 있을 수 있습니다.


## 경로 설정 (PC 마다 다른 Curdir)

각 맵의 `main.lua` 맨 위에는 **모든 맵에서 똑같은 부트스트랩 블록**이 있고,
그것이 `MapSource/Bootstrap.lua` 를 찾아 부른다.  PC 마다 다른 경로를 손으로
갈아 끼우던 `-- to DeskTop : Curdir=...` 주석은 더 이상 없다.

찾는 순서:

1. 환경변수 `MAPSOURCE_CURDIR`
2. 이미 정해져 있는 `Curdir` (맵 안 트리거 스크립트가 정하는 예전 방식 — 그대로 동작)
3. `%USERPROFILE%` / `$HOME` 의 `Documents`, `Desktop`, `OneDrive\Documents`
4. 작업 디렉터리와 그 위쪽 (ScmDraft2 옆에 MapSource 를 둔 PC)

**새 PC 에서 할 일**: 위 3·4 에 안 걸리는 자리에 두었다면 그 PC 의 환경변수
`MAPSOURCE_CURDIR` 에 MapSource 의 **부모** 디렉터리를 한 번 넣어 주면 된다.
소스는 한 줄도 고치지 않는다.

`MapSource/local.lua` 를 만들어 두면 부트스트랩 끝에서 실행된다 (git 에 안 올라간다).
`PyDir` 처럼 그 PC 에서만 쓰는 값을 넣는 자리다.

`Bootstrap.lua` 는 `MS_LoadDir` 도 제공한다.  Windows 는 예전과 똑같이 `dir /b`
순서를 쓰고, 리눅스 헤드리스(tepc)에서만 그 순서를 재현한다 — 로드 순서가 곧
실행 순서라, 셸의 정렬 차이를 그냥 두면 같은 소스가 OS 마다 다른 맵을 낸다.


## 타 리포지토리로 이동한 작품
+ 마린키우기 Respect V
+ 마린키우기 MEME - EUD