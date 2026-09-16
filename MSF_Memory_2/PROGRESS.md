# MSF_Memory_2 작업 진행 상황

개발용 기록입니다. 플레이어용 변경 기록은 [CHANGELOG.md](CHANGELOG.md).

## Axiom 중간보스 기믹 (진행 중, 2026-09-16 기준)

목표: Axiom n 을 달성한 채 n번 워프 터널(유닛 189)을 부수면, 나오는 중간보스(기억의 수호자)의 도입 연출과 패턴이 바뀐다.

| n | 워프 터널 | 보스 (BPtrArr[n]) | Axiom 판 이름 | BGM | 상태 |
|---|---|---|---|---|---|
| 1 | P5 (11시) | Aldaris 87 (하템) | Infinite Divide | 13 BO1.ogg | 도입·보스 패턴 있음. **인게임 미검증** |
| 2 | P6 (1시) | 닼템 영웅 74 | Pentiment in Tenebris | 14 BO2.ogg | 보스 패턴 일부(DarkSkill 밝기·즉사기). 도입 없음 |
| 3 | P7 (7시) | 시즈탱크 5 | World Demication | 15 BO3.ogg | 없음 |
| 4 | P8 (5시) | 벌쳐 2 | Arcana Anomaly | 16 BO4.ogg | 크리스탈 오더 1줄(System.lua). 도입 없음 |

흐름: `GunData.lua` 의 `CIf_GCase(189)` → Axiom 이면 BGMType 13+n, 30번 줄 = 1 → 플레이어별 도입 블록 → 도입이 31번 줄을 켜면
공통 블록이 보스를 부르고 건작을 끝낸다(`Gun_DoSuspend`) → `BossTrig.lua` 의 Axiom 분기.

### 스위치 (0.ZI_Fix 에서 추가)

- `main.lua` 의 `AxiomBossSet` — 출시 빌드 **0**, 테스트 빌드(`Limit == 1`) 1.
- 중간보스 쪽에서 Axiom 을 볼 때는 `BossTrig.lua` 맨 위의 `AxBossOn(n)` / `AxBossOff(n)` 를 쓴다 (0 이면 Never / Always).
  Axiom **발견 판정**과 건작보스 특수 패턴(`AxiomEnable`)은 스위치와 무관하다.
- 0.ZI 는 이 스위치 없이 나가서, 이터널 이상에서 Axiom 2~4 를 달성하고 그 워프 터널을 부수면 보스가 안 나와 게임을 끝낼 수 없었다.

### 1번 Infinite Divide 도입 (`GunData.lua` 의 `CIf(FP,{GCP(4)})--divide`)

- 850ms 부터 박 간격이 반씩 줄어드는 스네어 롤(16박씩 4단) → 19,032ms 부터 매 사이클 → 20,240ms 드롭에서 보스.
- 이펙트: 3팔 × 15점 스파이럴. 박마다 회전 킥과 반경 펄스가 쌓였다 줄어든다. 조절값은 블록 맨 위 `local Div*`.
- 박마다 원 안 무작위 한 점에 카카루 4마리 십자 → 중심으로 모임 → 드롭 때 JYD.

### 남은 일

1. 테스트 빌드로 1번 인게임 확인: 스파이럴 모양·박 싱크·조절값, 보스 공격 단계에서 카카루를 P6 에 넘기는 연출이 의도대로인지.
2. 2~4번 도입·패턴 설계 — 각 곡(BO2~4)의 BPM·구간이 필요하다 (MapSource `BeatTimer`). 지금 2~4번 도입 블록은
   **임시로 31번 줄을 바로 켠다** (테스트 빌드가 막히지 않게). Tenebris 메모: "박자에 맞춰 원이 심장처럼 뛰고, 스네어에 맞춰
   일정 각도에서 저글링이 터진다".
3. 넷 다 완성되면 `AxiomBossSet` 출시값을 1 로.

## 빌드 메모

- `build.bat` = tepc → euddraft → CPLP. 64비트 파이썬이 PATH 첫 번째여야 한다(StormLib64). 빌드는 `C:\euddraft0.9.2.0\Ctemp` 를 덮어쓴다.
- 컴파일만 확인할 때는 `python tools\build.py --tepc-only`.
