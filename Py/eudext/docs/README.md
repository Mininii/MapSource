# eudext 설계 자료

`..\DESIGN.md` 를 쓸 때 모은 조사 문서와 시제품이다(2026-09-17). 설계의 근거를 확인하거나 구현을 시작할 때 본다.

## research — 조사 문서

| 파일 | 내용 |
|---|---|
| `R1_usage.md` | 맵 10개(+구판)에서 CtrigAsm·사용자 헬퍼를 몇 번, 어떤 인자 모양으로 쓰는지. 우선순위 근거 |
| `R1_tables.md` | R1 의 기능 × 맵 전체 표 |
| `R2_existing.md` | DPS 이식 계층(`DPS_eud\eud\ctrig`)과 명세 G1~G9 재고: 떼어 쓸 코드(파일:줄), 비용 측정, 에뮬레이터 범위, SCR_DB 네이티브 제약 |
| `R3_eudplib_conv.md` | eudplib 0.76.14 라이브러리 작성 규약(값 타입·조건·함수·CP), epScript 번역 규칙, euddraft 경로·부트, 최신판(0.81) 대비 |
| `R4a_bullet_text.md` | 총알·스프라이트 원리, CGRP, 숫자 서식 확장 지점, 글자 셀 배치, 채팅 줄 |
| `R4b_input_shape_misc.md` | 입력 주소·MSQC 동작, CX Paint 도형 형식·lupa 적재, CAPlotIndexed, lengthdir/atan2 원본, 방장·부대 지정·관전자 채팅·ExitDrop |

## proto — 시제품과 실험

조사 문서 안의 경로는 **작업 당시 스크래치패드 기준**이다. 이 폴더로 옮기면서 이름을 아래처럼 바꿨다.
스크립트들은 스크래치패드 폴더 구조(`edtest\shared`, `tmp\` 등)를 가정하므로 **그대로는 돌지 않는다.** 구현할 때 참고용으로 읽거나 경로를 고쳐서 쓴다.

| 조사 문서에 적힌 경로 | 여기 |
|---|---|
| `edtest\shared\eudext\i64.py` | `i64_proto.py` (Int64 시제품) |
| `proto\emu.py` | `emu.py` (DPS `eud\tests\emu.py` 사본) |
| `proto\t_i64_emu.py` | `t_i64_emu.py` (Int64 400건 검사 + 트리거 수) |
| `proto\t_pitfalls.py` | `t_pitfalls.py` (0.76.14 함정 실험) |
| `proto\t_loopcond.py` | `t_loopcond.py` (부작용 조건의 루프·단락 평가) |
| `edtest\map\boot.py`, `t_load.eds`, `main.eps`, `run1.log` | `boot_proto.py`, `boot_test.eds`, `boot_test_main.eps`, `boot_test_run1.log` (euddraft 부트 실측) |
| `eps_exp\probe.py`, `probe2.py`, `probe_out.txt`, `probe2_out.txt` | `eps_probe.py`, `eps_probe2.py`, `eps_probe_out.txt`, `eps_probe2_out.txt` (epScript 조각 약 140개 번역 결과) |
| `eps_exp\bundle_report.txt` | `euddraft_bundle_report.txt` (번들 pyc 디스어셈블, 빠진 표준 모듈) |
| `lupa_cbpaint_exp.py`, `lupa_cbpaint_exp2.py`, `lupa_cbpaint_exp.log` | 같은 이름 (lupa 로 CB Paint 돌리기) |
| `math_sim.py` | 같은 이름 (lengthdir/atan2 모의 계산) |
| `measure_costs.py`, `measure_costs2.py`, `measure_storage.py` | 같은 이름 (64비트·서식 루틴 비용, 유닛별 저장 크기) |
| `r1_count.py` | 같은 이름 (맵별 사용량 세기, 약 11초) |
| — | `cell_exp.py` (Ccode = EUDLightVariable 동작 실험, DESIGN 4.3 표) |
| — | `eps_kwarg_exp.py` (epScript 호출 자리 키워드 인자 번역 실험, DESIGN 3.11) |

R1 이 말하는 `lists\a4_ctrig_funcs.txt`, `lists\a4_guide_funcs.txt` 는 `MapSource\Py\CtrigAsm_vs_eudplib\lists\` 에 있다.
