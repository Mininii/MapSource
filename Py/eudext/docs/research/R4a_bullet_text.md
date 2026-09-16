# d_R4a — eudext 설계 재료: 총알·스프라이트 / CGRP / 숫자 서식 / 글자 효과 / 출력 줄

작성 2026-09-17. 코드는 고치지 않았고, 아래 API 는 **스케치**(구현 아님)다. 확인하지 못한 것은 "(추측)".

## 약어 (근거 위치)

| 약어 | 파일 |
|---|---|
| CA | `ScmDraft 2\MapSource\Library\CtrigAsm v5.5.lua` |
| GB | `ScmDraft 2\MapSource\Library\Ctrig Assembler v5.4 Guide Book.txt` |
| DPL | `ScmDraft 2\MapSource\Library\DisplayPrint.lua` |
| G8 | `ScmDraft 2\DPS_eud\eud\spec\G8_text_scrdb.md` |
| TXT | `ScmDraft 2\DPS_eud\eud\ctrig\text.py` |
| EP | `C:\Users\whatd\.venvs\eud076\Lib\site-packages\eudplib\` (0.76.14) |
| PL | `C:\euddraft0.9.2.0\plugins\` |
| M2 | `ScmDraft 2\MapSource\MSF_Memory_2\func.lua` (사용자 맵의 자체 CreateBullet) |
| GXY | `ScmDraft 2\MapSource\Py\Galaxy.py` (사용자 맵의 **eudplib** CreateBullet — 이미 돌아가는 선례) |
| RV | `ScmDraft 2\MSF_Respect_V\GunData.lua` (CDPrint 글자 효과 실사용) |

## 0. 한눈에

- **총알 생성은 전부 "유닛 하나 만들고 → 같은 트리거에서 그 유닛의 주문 칸을 고쳐 → 게임 로직이 그 유닛의 무기를 쏘게 하는" 방식이다.**
  새 유닛 포인터는 `CreateUnit` **직전에** 빈 유닛 목록 머리 `0x628438` 을 읽어 얻는다. 무기·비행 정보(dat)는 전역이라
  **같은 프레임에 같은 무기로 만든 총알은 마지막으로 쓴 속도·수명·투사방식을 함께 쓴다.**
- CGRP 는 이미지 파일이 아니라 CS_Photo.exe 가 만드는 **래스터 점 표**(헤더 16B + 칸당 dword)다. 그리는 쪽은 28장 함수로 점마다 총알을 찍는다.
- 숫자 서식: eudplib `fmtprint` 에 **서식 지정자를 끼울 공식 지점은 없다**(`_EUDFormatter.eudformat_field` 는 끝 글자 5종만 보고, 변수에 붙은 폭·채움은 버린다).
  대신 `f_dbstr_print`/`f_cpstr_print` 가 인자마다 **`arg.fmt()` 를 먼저 부르는 훅**이 있고 `LocalLocale` 이 이미 쓴다 → **래퍼 객체 방식**을 권한다.
- 글자 효과 버퍼: 둘 다 "글자당 4바이트, 0번 바이트 = 색". 3바이트 글자(한글·전각)는 같은 배치지만,
  **1·2바이트 글자는 채움 위치가 반대**(CtrigAsm iutf8 = 앞을 0x0D 로 채움, eudplib cpchar = 뒤를 0x0D 로 채움). **색 효과는 호환, 글자 비교·치환은 비호환.**
- 출력 줄: eudplib `printAt(line)` = CtrigAsm `CDPrint({line})` 의 "화면 절대 위치" 규칙과 같다. 다만 eudplib 는 줄 전체를 DisplayText 로 다시 찍고,
  CDPrint 는 **이미 떠 있는 줄의 버퍼를 글자 단위로 직접 고친다.** 13번째 줄은 두 쪽 다 CCMU(유닛 생성 실패) 트릭이다.

---

## A. 총알·스프라이트 생성 (GB 28장 7868~8157)

### A.1 공통 원리

1. 조건에 `Memory(0x628438, AtLeast, 1)` 을 붙인다 — 빈 유닛 슬롯이 있을 때만(CA:81456, 81533, 81641, 81720).
2. `f_Read(…, 0x628438, nil, V(NRet[16]))` 로 **다음에 만들어질 유닛의 EPD** 를 읽는다(CA:81462). f_Read 는 공용 서브루틴 호출이다(CA `f_Read` 본문 — `FReadCall1` 호출).
3. 한 트리거(CDoActionsX) 안에서: 이미지·dat 필드 패치 → 로케이션 좌표 설정 → `CreateUnit(1, UnitId, Location, Owner)` (CA:81464~81514).
4. 새 유닛 칸을 고친다(CA:81519~81527):
   `+0x58 orderTargetPos ← 자기 위치(+0x28 을 읽어 복사)`, `+0x21 currentDirection1 ← Angle`, `+0x4D orderID ← 135`(+0x4E/0x4F 도 0),
   `+0x110 removeTimer ← 6`.
5. 트리거 사이클이 끝난 뒤 게임 로직에서 유닛이 주문 135 를 실행하며 무기를 쏜다. 그래서 **0틱 연산 불가**(GB 8040).
   removeTimer 가 다 되면 유닛은 사라지고 총알만 남는다.

주문 번호(CUnit `orderID`, 추측: BWAPI 목록 기준): 14 AttackMove, 134 SuicideUnit, 135 SuicideLocation, 137 CastRecall, 140 Scanner. GB 는 135 를 "자폭명령"이라 부른다(GB 7972).

유닛 칸 이름은 EP `offsetmap/cunit.py`: `currentDirection1` 0x21(110행), `turnRadius` 0x22(111), `orderTargetPos` 0x58(149), `unitType` 0x64(157),
`statusFlags` 0xDC(294), `visibilityStatus` 0xE4(308), `removeTimer` 0x110(337).

### A.2 BulletInitSetting 이 고치는 dat 필드 (CA:81379~81451)

인자: `UnitId={유닛, 유닛flingy, 유닛sprite[, 1=반공중]}`, `Weapon`, `Flingy`(총알 flingy), `Sprite`, `Image`, `Script`, `Color`, 피해 관련, `Preserve`.
컴파일 시점 전역 `BulletTable[UnitId] = {Weapon, Flingy, Sprite}` 를 채운다(CA:81396) — CreateBullet 류가 이 표로 주소를 계산하므로 **먼저 불려야 한다.**

| 대상 | 주소 | 값 | 뜻(CA 주석) |
|---|---|---|---|
| units.dat | 0x6636B8+u | Weapon | 지상 무기 |
| | 0x662DB8+u | 3 | 부가 사거리 |
| | 0x664080+4u | 0x38000004 / 반공중 0x20000004 | 특수 능력(비행+무적 …, 추측: 비트 해석) |
| | 0x660FC8+u | 197 / 반공중 0 | 이동 플래그 |
| | 0x6617C8+8u, +4 | 65537, 0 | 유닛 크기 |
| | 0x6644F8+u | 유닛flingy | 비행정보 |
| | 0x6637A0+u | 2 | 소속 그룹 |
| | 0x661518+2u | 0x1CF | 에디터 어빌리티 |
| | 0x662860+4u | 1 | 생산 크기 |
| | 0x662EA0 / 0x662268 / 0x664898 +u | 2 | AI 대기 주문 |
| | 0x663320+u / 0x663A50+u | 134 / 135 | 유닛 공격 / 공격 이동 AI |
| | 0x662098+u | 1 | 우클릭 |
| flingy(유닛) | 0x6C9EF8+4f | 0 | 최대속도 → 안 움직임 |
| | 0x6C9C78+2f / 0x6C9930+4f / 0x6C9E20+f / 0x6C9858+f | 1 / 0 / 128 / 0 | 가속·정지거리·회전·이동제어 |
| | 0x6CA318+2f | 유닛sprite | |
| sprites(유닛) | 0x666160+2s | **256** | 유닛 이미지 = 벌처 이미지 |
| weapons.dat | 0x656EB0+2w / 0x657678+2w | 피해 / 추가 피해 | |
| | 0x6564E0+w | 총알 수 | |
| | 0x6571D0 / 0x657258 / 0x6566F8 +w | 업글 / 피해형식 / 폭발형 | |
| | 0x656888 / 0x6570C8 / 0x657780 +2w | 스플 안/중/밖 | |
| | 0x657888+w | 0 | 발사 회전값(launch spin) |
| | 0x656A18+4w / 0x657470+4w | 0 / 3 | 최소·최대 사거리 |
| | 0x656CA8+4w | Flingy | 무기 비행정보 |
| | 0x657910+w / 0x656C20+w | 0 / 2 | 발사 위치 X/Y |
| | 0x656990+w | 255 | 공격 가능 각도 |
| flingy(총알) | 0x6CA318+2F / 0x6C9C78+2F / 0x6C9930+4F / 0x6C9E20+F / 0x6C9858+F | Sprite / 50000 / 0 / 127 / 0 | |
| sprites(총알) | 0x666160+2S | Image | |
| images.dat | 0x669E28+i / 0x66EC48+4i | Color / Script | 화면출력 / 아이스크립트 |

eudplib 0.76.14 에는 dat 필드 이름표가 없다(`core/rawtrigger/strenc.py` 의 `Weapon`/`Flingy`/`Image` 는 번호 인코딩 형일 뿐). eudext 가 주소 상수표를 가져야 한다.

### A.3 함수별 원리

| 함수 | 만드는 유닛 | 주문·칸 패치 | dat 패치(실행 때마다) | 프레임 | 근거 |
|---|---|---|---|---|---|
| **CreateBullet** | BulletInit 한 유닛(로케이션 Y−2) | 0x58←자기 위치, 0x21←Angle(상수면 ×256), 0x4D←135, 0x110←6 | image256 iscript←**86**(0x66F048), elevation 0x663150+u←Height, 무기 투사방식 0x656670+w←**9**, 총알 flingy 최대속도←**−Speed**, 무기 RemoveAfter 0x657040+w←Time | 생성 프레임의 로직 단계에서 발사 | CA:81453~81529, GB 7952~7975 |
| **CreateBulletTarget** | 같음 | 1프레임: 0x110←12, 0x58←목표 XY, 0x4D←**14**(AttackMove), 0x22←127 → 목표 쪽으로 돌기. 2프레임: 0x58←자기 위치(+0x28), 0x4D←135(주문 칸 3바이트 0) | 1프레임: iscript86, elevation, **0x656990+UnitId←0**(CA:81623, 추측: 무기가 아닌 유닛 번호로 인덱싱 — 버그 가능). 2프레임: launch spin 0x657888+w←Angle(128 정방향), 속도, 투사방식 9, Time | **2프레임**. 호출 자리마다 `Nextptr` 변수 1개 → **호출 자리당 프레임당 1발** | CA:81531~81636, GB 7977~7997 |
| **CreateStorm** | 같음 | CreateBullet 과 같음 | 투사방식 **3**(지점 지속), 지정 이미지의 iscript←**236**·"모든 스크립트"←1(영구), Time | 1 | CA:81638~81715, GB 8002~8020 |
| **CreateSprite** | 같음 | 같음 | 투사방식 **7**(튕김), 속도. Time 없음 → **영구 스프라이트**, 395(럴커) 외엔 피해 없음 | 1 | CA:81717~81786, GB 8021~8040 |
| **ScanInitSetting** | — | — | 유닛 33(스캐너 스윕) 크기 0x6618D0/D4←0, 에디터 어빌리티 0x66155A←0x1CF | 1회 | CA:81367~81377 |
| **ScanSprite** | 유닛 33 ×Number | 없음 | RemoveScan=1 이면 생성 동안만 유닛 33 의 AI 대기 주문(0x662EC1, 0x662289)←0(Die), 뒤에 140(Scanner) 복구. 이미지는 `SetScanImage`(스프라이트 380 → 0x666458) | **0틱 가능**, 높이 4 고정 | CA:81315~81365, GB 7877~7890, 8559~8562 |
| **UnitSprite** | 임의 유닛(표시용) | Time 있으면 0x110←Time, 0xDC `\|=0x100`(RequiresDetection), 0xE4 visibilityStatus←0(드래그 방지). NRet[1]=EPD | elevation | 0틱 가능 | CA:81209~81313, GB 7891~7905 |
| **RecallSprite** | 아비터류 | 0x58←(X,Y), 0x4D←**137**(CastRecall), 0x110←3 | 없음(이미지는 `SetRecallImage` = 스프라이트 379 → 0x666456) | 0틱 불가 | CA:81159~81207, GB 7911~7926 |

사용자 맵 변형:
- M2:2154~2185 `Call_CBullet`: 유닛 204 의 elevation(0x66321C) 로 높이를 주고, **로케이션 0번 좌표에 Y+10**, 생성 뒤 `+0x64 unitType←UnitId`(항상 같은 유닛으로 만들고 종류만 바꿈),
  `+0x10/+0x18/+0x1C/+0x58 ← 위치`, `+0x21←Angle`, `+0x22←127`, `+0x4D←135`, `+0x110←30`.
- M2:2287~2317 `Call_CreateBulletXY`: `f_Atan2` + 도→256 변환표로 **1프레임에** 목표 방향을 계산, `+0xDC` 마스크 0x300104 에 0x200104(공중+RequiresDetection+NoCollide, IsNormal 해제), `+0xE4←0`, `+0x110←12`.
- M2:2320~2337 `SetBulletSpeed/SetFlingySpeed`: 최대속도 `0xFFFFFFFF−v`(≈−v−1), 가속도 `v`.
- GXY:6~35: eudplib 으로 같은 일을 한다 — `f_maskread_epd(EPD(0x628438), 0xFFFFFF)` → 로케이션 247 좌표 → `CreateUnit(1,204,"BulletLoc",P6)` → `+0x64/+0x58/+0x21/+0x4D` 쓰기.

### A.4 필요 조건과 한도

| 항목 | 내용 | 근거 |
|---|---|---|
| 언리미터 | 28장은 "권장", CGRP 는 "반드시 UnlimiterX" | GB 7870, 8314 |
| 언리미터가 여는 것 | 빈 목록을 Db 로 교체: 총알 0x64EED8/DC ×112B, 스프라이트 0x63FE30/34 ×36B(+0x10 에 10000+i), 이미지 0x57EB68/70 ×64B, 오더 0x64B2E0/E4 ×20B. `afterTriggerExec` 에서 `0x64DEBC←40`(추측: 활성 총알 수 카운터 초기화). unlimiter.py 는 8192/65536 고정, unlimiterX.py 는 `Count`/`SpCount` 설정 | PL unlimiter.py:8~47, unlimiterX.py:40~67 |
| 늘어나는 범위 | **총알의** 스프라이트/이미지/오더만 | GB 8605 |
| 선행 초기화 | 종류마다 BulletInitSetting 1회(컴파일 시점 표도 채움), ScanSprite 는 ScanInitSetting, Recall 은 SetRecallImage + 리콜 마나 0 권장. 예제는 NoAirCollisionX 도 켬 | CA:81396, GB 7925, 18031 |
| 같은 프레임 한도 | 속도·수명·투사방식·spin·이미지 색/스크립트는 **전역 dat** 이고 발사는 트리거 뒤 → **무기(종류)당 프레임당 설정 1벌**. 예제 29-6 은 색마다 `Delay` 로 프레임을 나눈다 | GB 8040, 18272~ |
| 유닛 슬롯 | 총알 1발 = 유닛 1개를 removeTimer 프레임 동안 점유(6/12/3/30). 프레임당 생성 가능 수 ≈ 빈 슬롯 ÷ removeTimer(추측 계산) | CA:81526, 81625 |
| 총알 한도 | 가득 차면 새 총알이 안 나온다("물총현상") | GB 8631 |
| 표시 한도 | 시야 안 총알 합이 약 4096 을 넘으면 투명 → 방 갈림 → 튕김. Owner 는 생성 때 시야를 가지므로 대량 생성은 **컴퓨터 플레이어 소유** | GB 8605~8610, 8636~8637 |
| 스캔 한도 | ScanSprite 500~600, 언리미터로 안 늘어남 | GB 8562, 18509 |
| UnitSprite | 유닛 850 초과 시 갱신 최소 3틱, 밑의 유닛이 밀림, 드래그 방지 시 클로킹 소리 | GB 8566~8567 |
| 흰색(화면출력 17) | 42틱 안에 다시 찍어야 함, 넘으면 튕김 | GB 8466~8467 |
| 비공유 렌더링 | Time 을 플레이어마다 다르게 해 플레이어별 총알 가능, 단 **유닛에게 피해를 주면 즉시 방갈림** | GB 8611~8614 |

### A.5 트리거 비용

- CtrigAsm CreateBullet 호출 한 자리: CIf2 + f_Read 호출 2회(각 3~5 트리거, 본문은 공용) + CDoActionsX 1개(T 액션마다 변수 삽입 보조 트리거) + CDoActions 1개 → **약 15~25개**(추측: T 액션 보조 트리거 수를 세지 않았다).
- eudplib 로 옮기면: `f_cunitepdread_epd(EPD(0x628438))` 호출(공용 본문, 마스크 0x3FFFF0 — EP `eudlib/memiof/memifgen.py:166`), 변수 목적지 `SetMemoryXEPD` 몇 개(VProc 패치), 위치 읽기 1회.
  **EUDFunc 하나로 묶으면 호출당 2~3 트리거 + 본문 1벌**(본문 추정 20~30, 추측).
- 위치 읽기(+0x28)는 생략 가능할 수 있다: 공중 유닛은 로케이션 중심에 정확히 놓인다고 보고 `orderTargetPos` 에 설정한 좌표를 바로 쓰기(추측 — CtrigAsm 은 Y−2, M2 는 Y+10 보정을 쓴다. 실측 필요).

### A.6 eudplib 부품

| 부품 | 위치 | 쓸 곳 / 주의 |
|---|---|---|
| `f_cunitepdread_epd(EPD(0x628438))` → (ptr, epd) | EP memiof | 새 유닛 포인터. `f_raise_CCMU` 가 같은 칸을 같은 방식으로 다룬다(EP stringf/cpprint.py:259~274) |
| `CUnit(epd)` 멤버 | EP offsetmap/cunit.py | 위 A.1 칸 전부 이름 있음. `set_noclip()`, `set_invincible()` 등 상태 비트 메서드(647~692) |
| `f_setloc(loc, x, y)` | EP eudlib/locf/locf.py:171 | 생성 로케이션 |
| `f_atan2_256(y, x)` | EP eudlib/mathf/atan2.py:154 | CreateBulletTarget 을 1프레임으로. **각도 기준(0=동쪽?)이 SC 방향(0=북쪽)과 다를 수 있음**(추측) — `f_lengthdir_256` 은 입력에 192 를 더해 SC 방향을 받는다(lengthdir.py:129) |
| `EUDLoopBullet()` | EP eudlib/utilf/listloop.py:225 | 활성 총알 목록 0x64DEC4 순회(`ptr>0 && ptr<=0x7FFFFFFF`, 27~47). CBullet 멤버 이름표는 **없다** |
| `EUDLoopSprite()` | 같은 파일 229 | 0x629688 부터 256 행 목록 순회. `f_dwepdread_epd` 사용이라 언리미터 스프라이트도 따라간다 |
| `CSprite` | EP offsetmap/csprite.py | **주의**: `CSprite.from_read`(→ `f_spriteepdread_epd`)는 포인터가 0x620000~0x63FFFC 안이라고 가정(memifgen.py:194~199) → **언리미터 스프라이트(Db 안)에서 틀린 값.** 상수 `from_ptr` 검사는 유닛 표 범위로 잘못 되어 있음(csprite.py:115) |
| `IsUnlimiterOn()` | EP utilf/unlimiterflag.py | 0.76.14 안에서 켜는 곳이 없다(`_turnUnlimiterOn` 호출 0곳). `EUDLoopUnit2`(listloop.py:134)와 `CUnit.is_dying`(cunit.py:695) 만 참조 |
| unlimiter / unlimiterX | PL | eds 에서 켬. eudext 는 켜졌다는 사실을 스스로 알 수 없음 → 설정 인자로 받기 |

### A.7 API 스케치 (`eudext.bullet`)

```python
class BulletKind:                          # BulletInitSetting 대체 (컴파일 시점 객체)
    def __init__(self, unit, weapon, unit_flingy, unit_sprite,
                 flingy, sprite, image, iscript, draw=0,
                 damage=0, bonus=0, upgrade=0, factor=1, dmg_type=0, explosion=0,
                 splash=(0, 0, 0), half_air=False): ...
    id: int                                # 종류 번호(런타임 표 인덱스)
    def init_actions(self) -> list: ...    # A.2 표의 SetMemory 목록. EUDOnStart/1회 구역에서 실행

def bullet_setup(*kinds, loc="eudext_bullet", unit_limit_guard=True): ...
    # 전제: 로케이션 1개 예약, (권장) unlimiterX 켜짐. 종류별 weapon/flingy 번호를 EUDArray 로 둔다.

@EUDFunc
def f_bullet(kind, owner, x, y, angle256, speed, time, height=0):   # CreateBullet
    """반환: 만든 유닛 epd, 슬롯 없음/생성 실패면 0.
    주의: 같은 프레임 같은 kind 의 speed/time 은 마지막 값이 모두에 적용된다."""

@EUDFunc
def f_bullet_to(kind, owner, x, y, tx, ty, speed, time, height=0):  # CreateBulletTarget
    """f_atan2_256 로 방향을 구해 1프레임에 처리(M2 CreateBulletXY 방식). 호출 수 제한 없음."""

def f_storm(kind, owner, x, y, image, time, height=0): ...          # 투사방식 3, image iscript 236 영구 변경
def f_perma_sprite(kind, owner, x, y, angle256, speed, height=0): ... # CreateSprite, 투사방식 7
def f_scan_sprite(owner, x, y, image, n=1, die=True): ...           # 전제: scan_setup() 1회
def f_unit_sprite(owner, unit, x, y, height=0, time=None, nodrag=True) -> "epd": ...
def f_recall_sprite(owner, arbiter, x, y, image): ...               # 전제: 리콜 마나 0

class BulletFrame:                         # 선택: 프레임 안 "마지막 값" 충돌 감지(디버그 빌드)
    def set(kind, speed, time): ...        # 같은 프레임에 다른 값이면 EPS_SetDebug 경고
```

구현 메모(스케치 수준):
- 생성 성공 확인: CreateUnit 뒤 `0x628438` 값이 읽어 둔 포인터와 **달라졌는지** 비교(조건 1개). CtrigAsm 은 확인하지 않는다.
- 종류별로 함수를 복제하지 말고 `kind` 인덱스로 weapon/flingy 주소를 계산(주소 = 기준 + kind표[k]) → 본문 1벌.
- 표시용 CGRP 에서는 `f_perma_sprite` 를 루프로 부른다(B 절).

### A.8 위험·미확인

- **영구 부작용**: 벌처 이미지(256) iscript 가 86 으로 바뀜(GB 7972) → 맵의 진짜 벌처 모양이 깨진다. CreateStorm 은 지정 이미지 iscript 를 236 으로(CA:81690~81691).
  ScanInitSetting 은 진짜 스캐너 스윕 크기를 0 으로. BulletInitSetting 은 고른 유닛 번호의 units.dat 를 통째로 바꾼다.
- iscript 86·236·250·395 가 무엇인지, 음수 최대속도가 왜 필요한지 **확인 못 함**. (추측) 음수 속도로 "최대 사거리 도착" 판정을 피해 Time 동안 계속 날게 하고, launch spin 128 로 방향을 되돌린다.
- CreateBulletTarget 2프레임째 `0x20 Add Angle mask 0xFF00`(CA:81570)은 Angle<256 이면 효과가 없다(추측: 의도와 다름).
- RecallSprite 는 실제 리콜 시전이므로 목표 근처 Owner 유닛이 끌려올 수 있다(추측).
- CreateUnit 이 실패하면 읽어 둔 포인터는 빈 슬롯을 가리킨 채로 그 칸을 고친다(원본 무검사).
- `f_atan2_256` 과 SC 방향 기준 차이는 실측 필요.

---

## B. CGRP (GB 29장 8161~8642)

### B.1 데이터 형식 (GB 8321~8345)

| 위치 | 크기 | 내용 |
|---|---|---|
| +0 | 4 | 전체 점 수 |
| +4 | 4 | 가로 칸 수 X |
| +8 | 4 | 세로 칸 수 Y |
| +12 | 2+2 | 점 가로/세로 크기(px, 기본 3) |
| +16 | 4·X·Y | 칸마다 dword, **행 우선 래스터**(빈 칸 포함) |

칸 dword 비트(기준 이미지 233 뉴크닷):

| 비트 | 값 | 뜻 |
|---|---|---|
| 0 | 1 | Red (화면출력 0) |
| 1 | 2 | Green (13) |
| 2 | 4 | Blue (16) |
| 3 | 8 | White (17) — 계속 갱신 필요 |
| 4 | 16 | EMP 효과 (8), 잔상만 |
| 5 | 32 | Indigo (12), 리마스터에서 안 보임 |
| 6 | 64 | Box (15), 점 5×5px |
| 7 | 128 | Fill: 이 칸에 점을 찍는가 |
| 8~10 | (0~7)·256 | 흑색 명암 단계 (화면출력 10) |
| 11~13 | (0~7)·2048 | 적색 명암 단계 (화면출력 6, 실제 3단계까지) |
| 14~23 | ImageID·16384 | 이 점에 쓸 이미지(10비트) |
| 24~31 | Height·2^24 | 이 점의 높이 |

- 로드 후 `FArr(CGRP,0~3)` = 헤더, 4부터 데이터(GB 8537, 예제 29-8 18471~18493).
- 색 조합은 **흑색 > 적색 > 기본색 순으로 높이**를 둔다. 리마스터는 "쉐도우 스택킹 On + 실시간 조명 Off" 필요(GB 8344~8345).

### B.2 만드는 도구: CS_Photo.exe (GB 8315~8499)

- 입력 8비트 BMP + CGRP_ACT 폴더의 팔레트(.ACT). 시작 화면에서 모드 2 선택.
- 색상 모드 1: 단일색·단일높이(Mask01.ACT). 2: 단일색+흑색 음영(Mask02~08). 3: 팔레트·단일높이(Palette01~38, 인덱스 113 이상 투명). 4: 팔레트·음영을 높이로.
- 입력 항목: 파일 이름, 점 X/Y 간격, 색상 모드, 색상 코드, 흑/적 음영 단계, 점 높이(모드 2·4 는 음영 단계마다), 이미지 ID.
- **이 PC 에서 CS_Photo.exe 와 .cgrp 파일을 찾지 못했다**(`Stormcoast Fortress` 아래 검색 0건). 형식은 GB 설명만 근거.

### B.3 그리는 방법 (예제 29-4~29-10, GB 18217~18620)

- 기본: 행·열 이중 루프, 칸 읽기 → Fill(128) 또는 색 비트면 `CreateSprite(P1,P1,203,H,0,0,{"CLoc",X,Y})`. **프레임당 한 행**씩(예제 29-4 18217~18232).
- 색: images.dat 화면출력(`SetImageColor(233, 코드)`)이 전역이므로 **색마다 단계(Step)를 나누고 단계 사이 Delay 2~4 프레임**(29-6 18272~18343).
- 명암: 칸의 흑·적 단계 수만큼 같은 점을 **높이를 달리해 여러 번** 찍거나(점당 총알 여러 발), 뒤에 필터 이미지(210)를 깔고 높이차로 표현(29-5, 29-7).
- 흰색: 42틱 안에 재갱신, 또는 흰 배경(ScanSprite + 이미지 210, 스크립트 250)을 깔고 흰 점은 비움(29-6).
- 가변(움직이는) 그림 3방식(GB 8555~8567): A. CreateBullet+Time(최소 2틱 간격, 최대 약 8초) B. ScanSprite+스크립트 250(매틱 갱신, 500~600 한도, 높이 4) C. UnitSprite(매틱, 높이 조절, 850 초과 시 3틱). 예제 29-9 는 B.
- 대량(29-10): 한 그림 16곳, 43000+ 점. 시야를 모두 끈 뒤 생성, Owner = P8(컴퓨터).

### B.4 eudplib 구조 스케치

컴파일 시점(파이썬)에서 파일을 파싱해 **그릴 점만 추린 목록**으로 바꾸는 것을 권한다. 원본처럼 X·Y 전 칸을 런타임에 읽으면 빈 칸까지 매 칸 트리거를 돈다.

```python
class CGRP:                                     # eudext.cgrp — 컴파일 시점 파서
    @classmethod
    def load(cls, path) -> "CGRP": ...          # 헤더/칸 파싱
    count, w, h, dot_w, dot_h
    def cell(self, x, y) -> int: ...
    def layers(self, mode="stack") -> list["CGRPLayer"]:
        """(색 코드, 명암 단계, 이미지, 높이) 가 같은 점끼리 묶은 층 목록.
        mode="stack": 흑/적 단계만큼 높이를 올린 층을 추가(예제 29-6 방식)
        mode="height": 음영을 높이로(29-7 방식)"""

class CGRPLayer:
    draw_func: int; image: int; height: int; script: int | None
    points: list[tuple[int, int]]               # 칸 좌표
    db: Db                                      # (x_px, y_px) word 쌍을 굽는다. 원점 기준 상대 px

class CGRPPainter:                              # 런타임
    def __init__(self, cg: CGRP, kind: BulletKind, owner, per_frame=64, delay=2): ...
    def start(self, ox, oy): ...                # 원점 설정, 층 0 부터
    def tick(self):
        """층마다: 첫 프레임에 SetImageColor/Script, 그 뒤 per_frame 개씩
        f_perma_sprite(kind, owner, ox+dx, oy+dy, 0, 0, height). 층 끝나면 delay 프레임 쉰다."""
    def done(self) -> Condition: ...
```

- 데이터는 `Db(bytes)`(EUDObject) 로 싣고 `f_wread_epd`/`f_dwread_epd` 또는 EPD 인덱스 조건으로 읽는다. 층별 점 수 = 컴파일 시점 상수라 루프 끝 판정이 싸다.
- 원본 파일을 그대로 쓰고 싶으면 `Db(open(path,'rb').read())` + EPD(Db)+4 부터 칸 읽기(가이드 방식). 헤더 읽기로 크기를 런타임에 알 수 있다.
- 용량: 칸 수 × 4B(원본) 대 점 수 × 4B(추린 목록). 트리거는 층 루프 1벌.

### B.5 위험

- 프레임당 찍을 수 있는 점 수 = A.4 의 유닛 슬롯 한도(CreateSprite 유닛이 6프레임 점유) × 트리거 실행 시간. 43000 점은 수십 초 로딩(GB 8634~8640).
- 표시 한도·시야 드랍(A.4). 관전자는 비공유 렌더링으로 막아야 한다(GB 8638).
- 형식은 문서만 근거 — 실제 .cgrp 로 파서 검증 필요.

---

## C. 숫자 서식

### C.1 CtrigAsm/DPL 서식 옵션 전부

| 옵션 | ItoDec (GB 3938, CA:58336) | ItoHex (GB 3954, CA:58673) | ItoDecX (GB 3979, CA:58911) | ItoHexX (GB 3995, CA:59346) | ItoX (GB 3919, CA:57661) | CA__ItoCustom / lItoCustom (GB 6748·6774, CA:50699·51398) | dp.* (DPL) |
|---|---|---|---|---|---|---|---|
| 입력 | 32비트 V | 32 | 32 | 32 | dword 안 ASCII 4바이트 | 32 V / 64 W | 32 V, 64 W(`lIToDec`) |
| 진법 | 10 | 16 | 10 | 16 | — | 2~2³², `{진법, 최대 자릿수}` | 10(`IToDec`,`IToDecX`), 16(`ItoHex`) |
| 출력 배치 | 16B 고정: `DDDD`+`[색][부호][10⁹][10⁸]`+8자리 | 12B: `DDD 색`+8자리 | 48B: `DDDD`+`[DDD 색]`+10칸×`[색 EF BC 90+d]` | 36B 고정(추측: 9칸) | 4칸 × `[색 EF BC 60+c]` | SVA1 칸(4B/글자), `IndexArr` 로 자리마다 위치 지정 | G8 1.4 (a)~(d) |
| 앞자리 0 | ZeroMode 0 `'0'` / 1 공백 0x20 / 2 0x0D(안 보임) | 같음 | 0 `０` / 1 U+3000 / 2 `DDD` | 같음 | — | `Init`: 문자열(여러 글자 가능) 또는 자리별 목록, 기본 0x0D | IToDec: 2(0x0D). IToDecX: 2. ItoHex: 0 |
| 부호 | Sign 0 부호없음 / 1 `+`·`-` / 2 `- ` 한 칸 띄움 | 없음 | 1 `＋`/`－`(EF BC 8B/8D) / 2 띄움 | 없음 | — | `Sign`={양수 문자열, 음수 문자열, 0 문자열}(배열 = signed). 문자열 하나면 unsigned + 0일 때 그 문자열 | dp.ItoDec Sign=1 은 **음수만 `-`, 양수는 D**(DPL:715~727; CA 는 `+`, CA:58434) |
| 최대 자릿수 | DigitMax 1~10: 그보다 윗자리를 0x0D 로 지움 | 1~8 | 1~10 | 1~8 | — | `Base={b,n}` | — |
| 최소 자릿수 | **DigitMin k = 아래 k−1 자리를 지움**(최소 폭이 아니다, CA:58645~58668) | 같음 | 같음 | 같음 | — | — | — |
| 대소문자 | — | Case 0 대문자(+7) / 1 소문자(+0x27) | — | 0 `Ａ` / 1 `ａ`(EF BD 81, +0xE7 & 3번째 바이트+1) | — | `DataArr` 로 자유 | 대문자 |
| 전각 | — | — | 항상 | 항상 | ASCII→전각(0x21~0x7E, `\`→`￦`) | `DataArr`/`Init` 에 전각 문자 | `fwc` 플래그 → IToDecX |
| 자릿수별 색 | Color 하나 | 하나 | **자리마다**(Color 배열, 뒤에서부터) | 자리마다 | 글자마다 | `ColorArr` 자리마다(또는 자리 안 글자마다) | 없음(D) |
| 숫자→글자 치환 | — | — | — | — | — | `DataArr`: `{n,"문자"}`, `{{a,b},{"기준",곱}}` → 한자·한글 숫자, `『0』` 등 | — |
| 구분자·단위 | — | — | — | — | — | `IndexArr` 에 틈을 두고 틀 문자열에 `,`·`억`·`만` 을 미리 씀, `ClearArr` 로 윗자리가 0이면 구분자 지움(예제 26-18, GB 16728~16790) | DPS `SetNumX`: 만/억/조… 상위 두 단위만, 18B 고정(DPS_Enhance `CallTriggers/utils/converter.lua:20~425`) |
| 반환 | 없음 | 없음 | 없음 | 없음 | 없음 | `Output` = 채워진 최고 자리 위치(왼쪽 정렬 계산용) | — |
| 역변환 | — | — | — | — | — | `CD__ScanV/W`(GB 7258~7277): 끝 글자부터 ← 방향, 10진은 `,` 무시, 16진은 공백 무시, `-` 에서 부호 바꾸고 멈춤 | — |

- **완충영역**: ItoDec/DecX 등은 출력 앞 4바이트를 0x0D 로 채워 둔다(GB 3940 "완충영역O", CA:58420 `XXXX[0]`). ItoX 는 없음.
- 원본 알고리즘(CA:58448~58608): 자리마다 `x ≥ 8·10ⁿ → x−=, 자리+=8`, 4·2·1 순 **비교-뺄셈 트리거**(10⁹ 자리는 4·2·1) = 39개, 앞자리 판정 `x ≤ 10ᵏ−1 → 채움` 9개, 부호 2개.
  16진은 `2^i·16ⁿ` 비교-뺄셈 32개 + 자리마다 `≥0xA` 이면 Case 더하기 8개.
- CA__ItoCustom 은 진법이 변수 크기라 자리 k 마다 `m=⌊log2 Base⌋`+1 개 비교-뺄셈(CA:51142 `for j = m, 0 ,-1`).

### C.2 eudplib 쪽 현황

| 필요 | eudplib 0.76.14 | 근거 |
|---|---|---|
| 부호 없는 10진 가변 길이 | `f_dbstr_adddw`, `{}` | EP stringf/eudprint.py:106~150. **`f_div(number,10)` 을 최대 10회** — `_const_div(10)` 한 번에 비교 트리거 29개(core/calcf/muldiv.py:238~251) → 숫자 하나에 수백 개 실행 |
| 16진 | `hptr`, `{:x}` — 8자리 대문자 고정 | eudprint.py:153~180, fmtprint.py:101 |
| 4B 셀 10진 | `f_cpchar_adddw` → `[색, '0'+d, 0D, 0D]` | texteffect.py:61~81 |
| 부호·채움·폭·소문자·전각·자리색·구분자 | **없음** | — |

### C.3 fmtprint 에 끼울 수 있는가 — 판단

구조(EP stringf/fmtprint.py):
- `_EUDFormatter(string.Formatter)` 가 형식 문자열을 조각 목록으로 바꾼다(18~87). 필드마다 `eudformat_field(value, spec)`(90~112):
  spec 끝 글자가 `s`→ptr2s/epd2s, `t`→epd2s, `x/X`→hptr, `c`→PColor, `n`→PName. 그 밖에는 값이 `Db/ptr2s/epd2s/hptr/EUDVariable/DBString` 이거나 상수면 **값을 그대로 돌려준다 — spec 은 버린다**(`"{:05}"` 가 변수에 붙으면 조용히 무시). 나머지는 파이썬 `format()`.
- `_format_args`(123~125)가 호출마다 `_EUDFormatter()` 를 새로 만든다. `StringBuffer` 는 `_format_args` 를 **이름으로 import**(strbuffer.py:18).
- 조각을 실제로 쓰는 `f_dbstr_print`(eudprint.py:235~)·`f_cpstr_print`(cpprint.py:215~)는 인자마다 **`arg = arg.fmt()` 를 먼저 시도**(eudprint.py:269~272, cpprint.py:223~226)한 뒤 형으로 분기하고, 모르는 형이면 오류(eudprint.py:300, cpprint.py:251).
- `fmt()` 훅의 선례: `LocalLocale`(stringf/locale.py:38~81) — `ExprProxy(EUDVariable)` 에 `fmt()` 를 달아 `epd2s(EUDFunc 결과)` 를 돌려준다. `ExprProxy` 는 `EUDVariable` 로 인식되므로 `eudformat_field` 를 통과한다.
- 예외: **`f_cpchar_print`(TextFX 경로, texteffect.py:84~115)는 `fmt()` 를 부르지 않는다** → 래퍼가 그냥 숫자로 찍힌다.

결론:
1. **새 서식 지정자(`{:05d}` 등)를 공식적으로 끼울 확장 지점은 없다.** 하려면 `fmtprint._EUDFormatter.eudformat_field` 를 몽키패치해야 한다(클래스 속성이라 패치하면 `_format_args`·StringBuffer 모두 적용됨). eudplib 판이 바뀌면 깨질 수 있어 **선택 기능(옵트인)** 으로만 둘 것.
2. **권장: 래퍼 객체 + `fmt()` 훅.** `f_sprintf(dst, "HP {}", Dec(v, width=5, fill="0"))`, `sb.printf(...)`, `f_eprintf(...)` 에서 패치 없이 동작한다.
   TextFX(`fadeIn/fadeOut`)에는 `Dec(...).fmt()` 결과(`epd2s`)를 넘기게 문서화.
3. 고정 배치가 필요한 곳(DisplayPrint 틀, TBL, 채팅 버퍼 직접 쓰기)은 서식 문자열을 거치지 말고 **`f_fmt_*_to(dst, value)` 직접 함수**를 쓴다(G8 1.9 도 `f_sprintf` 금지 — 가변 길이 + NUL).

### C.4 트리거가 적은 고정폭 10진 알고리즘

G8 1.4(a), TXT:163~202(`_itodec16`) 를 일반화한다.

1. **자리 추출(공용 본문 1벌)**: `a = |x|`(부호 모드일 때 `x ≥ 0x80000000` 이면 비트 반전+1, 1 트리거).
   자리 k=9: `a ≥ 4·10⁹, 2·10⁹, 1·10⁹` 3개, k=8..0: `8·4·2·1 × 10ᵏ` 4개씩 → **비교-뺄셈 39 트리거**(각 조건 1 + 액션 2: `a -= amt`, `자리바이트 += b<<shift`).
   자리 바이트는 dword 3개(`e1,e2,e3`)에 미리 `'0'` 을 채우고 더한다 → 결과가 바로 ASCII.
2. **유효 자릿수**: `a0 ≤ 10ᵏ−1` 판정 9 트리거로 `nd` 를 구하거나(자리 추출 **전에** 원래 값으로), 곧바로 채움 문자를 덮는다.
3. **배치(호출 옵션마다 작은 꼬리)**: 채움/부호/폭/잘라내기는 컴파일 시점 상수 → `SetMemoryX` 몇 개. 가변 길이가 필요하면 `nd` 로 쓰기 사슬 중간에 점프(`f_dbstr_adddw` 의 skipper 방식, eudprint.py:113~130).
4. 전각·셀 배치: 자리마다 dword `[색, EF, BC, 90+d]`(4번째 바이트에 d 더하기) — 셀 10개, 추출 트리거 수는 같다(TXT `_itodec48`).
5. 16진: 니블마다 `2^i·16ⁿ` 비교-뺄셈 32개 + `≥10` 보정 8개. `SetMemoryX`/`AtLeastX` 비트 판정이면 32개로 줄일 수 있다(추측).
6. 구분자(천 단위·만 단위): 틀에 구분자를 미리 굽고, `nd > 3j` 일 때만 남기는 트리거 1개씩(ClearArr 규칙).
7. 64비트: 64비트 나눗셈으로 10⁹ 덩어리 3개로 나눈 뒤 32비트 루틴 재사용(G8 1.4(d) 권고). eudplib 에 64비트 형이 없으므로 이번 범위 밖.

비용 비교(한 번 실행): 비교-뺄셈 ≈ 50 트리거 실행, `f_dbstr_adddw` ≈ 자릿수 × (29 + 호출 오버헤드). 본문은 EUDFunc 1벌이라 **호출 자리 비용은 2~3 트리거**.

### C.5 API 스케치 (`eudext.numfmt`)

```python
class Dec(ExprProxy):              # LocalLocale 과 같은 틀: EUDVariable 로 통과, fmt() 로 변환
    dont_flatten = True
    def __init__(self, value, *, width=0, fill="\r", sign=None,  # None | "-" | "+-" | ("+", "-", "0")
                 max_digits=10, cut_low=0,                        # cut_low = DigitMin-1
                 fullwidth=False, colors=None,                    # colors: 자리별 색 튜플(뒤에서부터)
                 group=None,                                      # None | (3, ",") | (4, ("만","억","조"))
                 glyphs=None,                                     # 자리값→문자 표 (CA__ItoCustom DataArr)
                 buf=None): ...                                   # 호출 자리 전용 scratch Db (기본 자동)
    def fmt(self) -> "epd2s": ...  # 여기서 트리거를 내보내고 scratch 의 epd2s 를 돌려줌

class Hex(Dec):                    # lower=False, width=8, fill="0"
    ...

# 고정 배치 직접 쓰기 (서식 문자열을 거치지 않음, NUL 안 씀)
def f_fmt_dec_to(dst_ptr, value, **opts) -> "written_len": ...
def f_fmt_dec_cells(dst_epd, value, color=None, **opts) -> "cells": ...   # 4B 셀(C.4 4번)
def f_scan_dec_cells(src_epd, n, signed=False) -> "value": ...            # CD__ScanV 대체

def enable_format_spec():          # 옵트인 몽키패치: "{:05d}", "{:+,d}", "{:08x}", "{:w}"(전각) → Dec/Hex 로 변환
    ...
```

- `Dec(...)` 는 호출 자리마다 scratch Db 를 따로 가진다. 한 print 호출 안에 두 개가 있어도 `f_dbstr_print` 가 인자 순서대로 `fmt()`→복사를 하므로 안전(eudprint.py:257~301).
  사용자가 `.fmt()` 를 미리 두 번 부르면 같은 scratch 를 공유하지 않도록 자리마다 별도 버퍼여야 한다.
- 옵션 조합마다 본문을 새로 만들지 말고 "자리 추출 본문 1벌 + 옵션별 꼬리"로 캐시(키 = 옵션 튜플).

### C.6 위험

- 몽키패치 방식은 eudplib 판 의존. `fmtprint` 의 비공개 이름(`_EUDFormatter`) 을 건드린다.
- `Dec` 가 `ExprProxy(EUDVariable)` 이면 `f_cpchar_print` 에서 숫자로 찍힌다(C.3). 테스트로 막을 것.
- CtrigAsm 의 `DigitMin` 의미(아래 자리 지우기)를 "최소 폭"으로 오해하기 쉽다 → 이름을 `cut_low` 로.
- 0x0D 채움은 보이지 않아 **왼쪽 정렬**처럼 보인다. 시각적 오른쪽 정렬은 공백/전각 공백 필요. SC:R 글꼴의 숫자 폭이 고정인지 확인 못 함(추측).

---

## D. 글자 효과 (GB 26장 CA__ 편집 함수)

### D.1 버퍼 형식 비교

| | CtrigAsm iStr cp949 | CtrigAsm iutf8 | eudplib cpchar (TextFX) |
|---|---|---|---|
| 글자당 | 4B (GB 6268) | 4B | 4B (dword 1개) |
| +0 | 색 코드 | 색 코드 | 색 코드(`color_v`) |
| 1바이트 글자 | `[C][D][D][c]` | `[C][D][D][c]` **(앞 채움)** | `[C][c][D][D]` **(뒤 채움)** |
| 2바이트 글자 | `[C][D][b1][b2]` | `[C][D][b1][b2]` | `[C][b1][b2][D]` |
| 3바이트 글자 | — | `[C][b1][b2][b3]` | `[C][b1][b2][b3]` (같음) |
| 색 없음 | C = 0x0D (앞 색 유지) | 0x0D | 기본 0x02(파이썬 전역 `color_code`, 매 TextFX 시작 때 0x02) |
| 연속 색 코드 | 마지막 것만 칸에 합침 | 같음 | 칸에 합침(`new_color_code`) |
| 기본 마스크 | 0xFFFF00FF (GB 6692) | 0xFFFFFFFF (GB 6693) | — |
| 근거 | CA `str_to_icp949` 45865 | CA `str_to_iutf8` 45778~45863 | EP texteffect.py:98~106(`char + b"\r"`), 30~52(런타임), 77(숫자); memiof/cpbyterw.py:50~72(뒤를 `\r` 로 채움) |

판정:
- **색 바이트(+0) 조작은 호환**: CA__SetColor(마스크 0xFF, GB 6676), CA__ConvertColor, TextFX `_r2l`(`SetDeathsX(CP, SetTo, color, 0, 0xFF)`, texteffect.py:284~).
- **글자 바이트 비교·치환은 비호환**: CA__SetLetter 는 마스크 0xFFFF0000(GB 6682 — cp949 배치 기준), 1바이트 ASCII 의 위치가 +3(CA) 대 +1(eudplib).
  CtrigAsm 에서 만든 `MakeiStrDataX` 상수를 eudplib 셀에 그대로 쓰면 ASCII·2바이트 글자가 틀린다.
- 둘 다 0x0D 를 "보이지 않는 글자"로 쓴다(StringBuffer.delete 도 `0x0D0D0D0D`, strbuffer.py:271~283).
- eudplib 런타임 문자열 복사(`_cpchar_addstr`)는 문자열 안 색 코드를 칸에 합치지 않고 **한 칸**으로 만든다(texteffect.py:30~52) — 컴파일 시점 문자열과 동작이 다르다.

### D.2 SVA1 구조 (CtrigAsm 편집의 바탕)

- SVA1 원소 하나 = 트리거 하나(604 EPD 간격) = **글자 1개**(GB 6397). 원소 안의 액션: 목적지 `+0x158`, 값 `+0x15C`, 마스크 `+0x148`(값에서 −5 EPD, GB 7142), 다음 원소 목적지에 더할 **Next** `+0x17C`(CA__SetNext·CA__MoveXY 가 고치는 칸, CA:48448, 48622).
- 이 사슬을 실행하면 "목적지부터 Next 간격으로" 글자들이 복사된다. `CA__InputVA` = iStr 버퍼로, `CA__InputSVA1` = 다른 SVA1 로(Next 는 604 배수).
- Next 기본 1(바로 오른쪽 칸), `Y*Line+X` 로 바꿀 수 있고 0·음수도 가능(GB 6607).

### D.3 CA__ 함수가 버퍼에 하는 일

| 함수 | 버퍼에 하는 일 | 근거 |
|---|---|---|
| `CA__InputVA(Index,SVA1,Size,Mask,Start,End,SrcDist)` | SVA1 의 글자들을 iStr[Index…] 에 복사. Start~End 밖은 버림, Mask 로 부분 복사, SrcDist 로 원본 건너뛰기 | GB 6519~6530, CA:46560 |
| `CA__InputSVA1(X)` | SVA1→SVA1 복사(무한 중첩), X 판은 대상 마스크도 복사(경로 데이터용) | GB 6531~6552, CA:47112 |
| `CA__OverWrite(SVA32,Index,Null)` | 상수 문자열(트리거당 32글자)을 iStr[Index] 에 덮어쓰기, Null=1 이면 뒤에 NUL | GB 6553~, CA:49297 |
| `CA__Input(Input,SVA1,Mask)` | SVA1 원소 하나의 값 설정 | GB 6566 |
| `CA__SetMask / SetNext` | 범위의 마스크 / Next 설정 | GB 6572~6588, CA:48179, 48425 |
| **`CA__MoveXY(SVA1,Line,Mul,Mode,Fix,PathData)`** | 원소마다 Next = `X + Line·Y` 로 바꿔 **다음 글자 복사 위치를 상하좌우로 옮김**. Fix=1 이면 절대 좌표 경로를 누적 차분으로 변환. Line 은 `\n` 포함 한 줄 길이 → **여러 줄 문자열 위에 글자를 2차원 경로로 뿌리는 효과** | GB 6594~6612, CA:48587~ |
| `CA__SetValue(SVA1,String,Mask,Index)` | SVA1 에 문자열(컴파일 시점) 굽기 | GB 6615 |
| `CA__Mov / Movcpy` | SVA1 값 → 변수/메모리(글자당 4B) | GB 6625~6640 |
| `CA__Read(X)` | iStr[i] 읽기(곱 256ⁿ) | GB 6641~6660 |
| `CA__SetMemoryX / SetColor / SetLetter` | iStr[i] 전체 / 색(0xFF) / 글자(0xFFFF0000) 쓰기 | GB 6661~6682, CA:56239, 56593, 56416 |
| `CA__Encode` | SVA1 글자 cp949↔utf8 변환(STRCtrig 필요) | GB 6683~6693, CA:52514 |
| **`CA__ConvertColor(SVA1,{A,B[,{C,Mask}]},MaskData,Start,End)`** | 범위의 각 글자: 색==A(조건 마스크) 이면 B 로(SetTo/Add/Subtract, 액션 마스크). 추가 조건 C 로 글자까지 확인 가능. **글자당 한 번만** 변환 | GB 6703~6713, 6729; CA:50156~ (CP 를 원소 값 칸에 두고 DeathsX/SetDeathsX) |
| **`CA__ConvertLetter(SVA1, data, MaskData, Start, End, utf8)`** | `{A,B}` 글자 A→B, 또는 `{{A,B},d}` 범위 A~B 에 d(또는 D−C) 더하기(대소문자·전각 변환 등). 기본 마스크 0xFFFF0000, A≤B | GB 6714~6731, CA:50356 |
| `CA__ItoName` | 플레이어 이름을 iStr 로(전각 옵션) | GB 6732~6740, CA:52258 |
| `CA__ItoCustom/lItoCustom` | C 절 | |
| `CA__GetName` / `CA__epdcpy` / `CA__epdcmp` / `TTepdcmp` | 이름 복사 / 범위 채우기 / 비교(CFlag) | GB 6784~6813 |
| `CD__InputVAX / InputMask / Resize` | 채팅 버퍼판 복사 / 줄 마스크 / 줄 맨 앞에 `0x0D0D0D0A` 넣어 **글자 크기 줄이기**(복구 0x0D0D0D0D) | GB 7228~7249, CA:53580, 54001, 54221 |
| `CD__ScanChat` | 채팅 줄 utf8 → iutf8 셀 변환(홀수 줄 2바이트 건너뛰기 옵션) | GB 7279~7295, CA:54918 |

실사용(RV:2879~2936 `HTextEff`): 매 프레임 11줄을 훑어 첫 글자가 표식(`\x0D\x0D!H` 로 찍은 줄, 또는 U+2008/U+200B 류 표식 셀 `0x8880E2`/`0x8B80E2`)인 줄을 셀로 스캔하고,
줄마다 공개 글자 수를 1씩 늘려 **타자기처럼 드러내는 효과**를 CDPrint 안에서 만든다. 숨김 줄은 첫 바이트가 0 이라는 성질을 이용한다(RV:2880 주석).

### D.4 eudplib TextFX 구조 (EP stringf/texteffect.py)

- `_textfx_print`: 태그 식별자(색 코드 6개, 126~150)를 **평문으로** 먼저 쓰고, 이어서 `f_cpchar_print` 로 셀을 쓴다. `\n` 마다 식별자를 다시 넣음.
- `TextFX_FadeIn/FadeOut`(339~, 421~): 타이머 변수로 "현재 위치"를 옮기며 `_r2l(colors)` 가 **CP 를 뒤로 한 칸씩** 옮기며 색 바이트만 쓴다. `_is_cp_less_than_start` 로 시작 전은 건드리지 않는다.
- `TextFX_Remove(tag)`(246): 11줄에서 식별자를 찾아 그 줄을 지우고 위치를 돌려준다(홀짝 줄 정렬을 따로 처리, 180~243) → `StringBuffer.tagprint/fadeIn(line=...)` 이 같은 자리에 다시 찍는다(strbuffer.py:378~).
- 셀 버퍼는 `StringBuffer` 의 STR 메모리(`sb.epd`)이고 쓰기는 `IsUserCP` 분기 안(로컬)에서만 돈다(strbuffer.py:236~249 `_cpblock`).

### D.5 API 스케치 (`eudext.textfx`) — StringBuffer 셀 위에서

```python
class Cells:                                   # sb 의 셀 영역을 가리키는 뷰
    def __init__(self, sb: StringBuffer, start=0, length=None, line_len=None): ...
    epd                                        # sb.epd + start
    def write(self, *args): ...                # f_cpchar_print(EOS=False) — Dec.fmt() 결과 허용
    def set_color(self, i, color): ...         # SetDeathsX(epd+i, 0xFF)
    def fill_color(self, start, end, color): ...
    def convert_color(self, rules, start=0, end=None, extra=None): ...
        # rules=[(from, to[, op])], 글자당 첫 일치만(CA__ConvertColor). CP 루프 + DeathsX/SetDeathsX
    def convert_letter(self, rules, start=0, end=None): ...
        # rules=[("a","z", "Ａ"-"a" 차이)] — 셀 배치(뒤 채움) 기준으로 상수 계산하는 도우미 포함
    def reveal(self, count_var, hide_color=0x0D, hide_char=True): ...
        # 타자기: count 뒤 셀을 0x0D0D0D0D 로(원본은 따로 보관) — RV HTextEff 대체
    def blit(self, dst: "Cells|chat", at, n, path=None, mask=0xFFFFFFFF, src_step=1): ...
        # CA__InputVA + CA__MoveXY: path = 컴파일 시점 (dx,dy) 목록 → Db 오프셋 표(dy*line_len+dx)
    def shrink(self, on=True): ...             # CD__Resize: 첫 셀 0x0D0D0D0A / 0x0D0D0D0D

def cell_const(ch: str, color=None) -> int: ... # eudplib 배치로 셀 dword 계산 (MakeiStrDataX 대체)
def cell_const_ctrig(ch, color=None) -> int: ...# CtrigAsm iutf8 배치 (옛 데이터 호환용)
```

- 쓰기 경로는 `StringBuffer._cpblock` 과 같은 로컬 분기 안에 둔다(텍스트는 로컬 상태).
- 2차원 효과는 "여러 줄 문자열 = 줄마다 `line_len` 셀 + 줄바꿈 셀 1개"로 두면 CA__MoveXY 의 `Line`(`\n` 포함) 규칙이 그대로 맞는다(추측: `\n` 셀 `[C,0A,D,D]` 를 SC 가 줄바꿈으로 처리 — eudplib `_textfx_print` 가 식별자 뒤에 `\n` 을 평문으로 넣는 점은 확인).

### D.6 위험

- 셀 배치 차이(D.1) — 옛 CtrigAsm 상수·스캔 결과를 섞지 말 것.
- `f_cpchar_print` 의 `color_code` 가 **파이썬 전역**이라 컴파일 순서에 따라 기본 색이 달라질 수 있다(texteffect.py:98~112).
- 런타임 문자열의 색 코드가 칸 하나를 차지(D.1 마지막 줄) → 폭 계산이 컴파일 시점 문자열과 다름.
- 4바이트 UTF-8(이모지)은 두 쪽 다 처리하지 않는다.

---

## E. 출력 줄 관리

### E.1 SC 채팅 버퍼 사실

| 항목 | 값 | 근거 |
|---|---|---|
| 줄 버퍼 | `0x640B60 + 218·slot`, slot 0~10 | GB 6993~7004, G8 1.7 |
| 다음 쓸 줄 | `0x640B58`(로컬) | CA FixText 57175, EP cpprint.py:91~100 |
| 화면 위치↔slot | `slot = (row + [0x640B58]) % 11` | CA `CS__GetLine` 주석 |
| 정렬 | 218 = 4·54 + 2 → **홀수 slot 은 +2 바이트부터 dword 정렬**(CDPrint `0x640B62`, GB 7126~7139). eudplib `f_getnextchatdst` 도 `ceil(slot·54.5)` EPD(cpprint.py:103~115) — 같은 규칙 |
| 한 줄 | 셀 54개 = 53 글자 + NUL(GB 7140). 홀수 줄 첫 2바이트는 0x0D0D(GB 7149) |
| 떠 있는 줄 판정 | 첫 바이트 ≠ 0 (사라진 줄은 0, 사용자가 NUL 을 써도 꺼진 것으로 봄) | CA `Display` 49715, GB 7004 |
| 13번째 줄 | `0x641598`(= 0x640B60+218·12). 유닛 생성 실패 오류를 띄운 **뒤** 덮어써야 보임 | G8 1.7, EP cpprint.py:259~301 |

### E.2 CtrigAsm/DPL 의 세 방식

1. **DisplayPrint(+FixText)** — STRx 틀 문자열을 고쳐 `DisplayText` 로 찍는다(새 줄로 추가). FixText(1)이 `0x640B58` 을 저장, (2)가 복원 → 같은 줄 자리에 계속 찍힘(DPL, G8 1.5, CA:57175~57192).
2. **CDPrint(Line,Size,Init,…)** — `DisplayText` 없이 SVA54[21](액션 54개 트리거 21개) 를 실행해 **채팅 버퍼에 셀을 직접 쓴다**(GB 7122~7151, CA:52633~53033).
   - Line 숫자 = slot, `{Line}` = 화면 위치(CD__GetLine 변환). Size 줄(1~11).
   - 매 실행: 53셀을 Init 문자·마스크로 초기화, 54번째 NUL, 홀수 줄 앞 2바이트 옵션(CA:52810~52877).
   - 표시 대상은 `LocalPlayerID`/`0x512684` 로 걸러 **로컬에서만** 쓴다(CA:52950~52990).
   - **줄이 이미 떠 있어야 보인다** → 예제는 먼저 `DisplayText("\r\n"×11)` 로 11줄을 켠다(GB 16981 예제 26-22, 16735 예제 26-18).
   - 사용자 맵: `CDPrint(0,11,{"\x0D",0,0}, …, "HTextEff", FP)`(RV:2936, MSF_Memory_2 Operator.lua:521, MSF_UE Destr0yer.lua:651) — 초기화 마스크 0 으로 **기존 글자를 지우지 않고** 효과만 입힌다.
3. **C13Print / DisplayPrintEr / Print_13X** — `0x628438←0` 후 `CreateUnit` 실패로 오류 줄을 띄우고 복구, 그 뒤 로컬에서 `0x641598` 에 54셀(SV54 = SetMemoryX 54개 + `0x641670` word 0) 쓰기(CA:79718~79770, 79775~, G8 1.6~1.7).

### E.3 eudplib 대응

| CtrigAsm | eudplib 0.76.14 | 차이 |
|---|---|---|
| DisplayText 추가 | `StringBuffer.print/printf`, `f_println` | 같음 |
| FixText 1/2 | `FixedText` 컨텍스트(cpprint.py:77~88), `f_gettextptr`(91~100) | 한 파이썬 블록 안에서만 열고 닫음(G8 1.9) |
| 화면 위치 지정 출력 | `DisplayTextAt(line, text)`(strbuffer.py:37), `sb.printAt/printfAt`, `f_printAt`(528) — `0x640B58 += line`, 11 이상이면 −11, DisplayText, 복원(288~299) | **줄 전체를 DisplayText 로 다시 찍는다** — 표시 시간이 매번 갱신, 글자 단위 부분 갱신 불가, 한 번에 한 줄 |
| 태그 줄 재사용 | `sb.tagprint(line=…)`, `fadeIn/fadeOut(line=…)` + `TextFX_Remove` | CtrigAsm 에는 식별자 방식이 없음(RV 는 직접 구현) |
| CDPrint 직접 쓰기 | **없음**. `f_getnextchatdst` 로 slot 주소만 얻을 수 있음 | 헬퍼 필요 |
| 13번째 줄 | `f_eprintln/f_eprintf`(CP 대상, cpprint.py:325~345), `f_eprintAll`, `f_raise_CCMU(player)` | eprintln 은 **평문 가변 길이 + NUL**(셀 아님, 고정 배치 아님) |
| `f_eprintln2` | TBL 871 문자열에 씀(tblprint.py:105~130) | 오류 메시지 트리거가 따로 필요(추측) |

### E.4 헬퍼 제안 (`eudext.chat`)

```python
def chat_prime(rows=11, player=CurrentPlayer): ...
    """DisplayText("\r\n"*rows) — CDPrint 전제(줄 켜기). FixedText 로 위치 보존 옵션."""

@EUDFunc
def f_chat_slot(row) -> "slot": ...            # (row + [0x640B58]) % 11  (f_gettextptr 재사용)
@EUDFunc
def f_chat_epd(slot) -> "epd": ...             # EPD(0x640B60) + ceil(slot*54.5)  (홀수 +2 정렬)
def chat_active(slot) -> Condition: ...         # 첫 바이트 != 0 (홀수 줄은 -2 주소 + 마스크 0xFF0000)

class ChatLines:                                # CDPrint 대체 (로컬 전용 블록 안에서만 쓰기)
    def __init__(self, rows=range(11), absolute=True, players=None): ...
    def clear(self, cell=0x0D0D0D0D, mask=0xFFFFFFFF, odd_head=True): ...   # 53셀 + NUL
    def cells(self, row) -> "Cells": ...        # D.5 Cells 와 같은 인터페이스(line_len=54)
    def write(self, row, col, *args): ...       # f_cpchar_print 를 CP=epd+col 로
    def shrink(self, row, on=True): ...         # CD__Resize
    def scan(self, row, dst: "Cells", n=53) -> "count": ...  # CD__ScanChat 대체 (utf8 → 셀)

def f_line13(player, *args, cells=False): ...
    """f_raise_CCMU(player) → IsUserCP 에서 0x641598 에 쓰기.
    cells=True 면 54셀 고정 배치(C13Print), False 면 f_eprintln 과 같음."""

class PinnedText:                               # FixText 1/2 분리형
    def save(self): ...                         # f_gettextptr → 변수
    def restore(self): ...                      # VProc(v, v.SetDest(EPD(0x640B58)))
```

- 쓰기는 모두 로컬(`IsUserCP` 또는 `Memory(0x512684, Exactly, p)`) 분기 안. 공유 변수에 로컬 값을 쓰지 않는다(G8 1.6).
- `ChatLines` 가 매 프레임 53셀을 초기화하면 트리거 비용이 크다(CtrigAsm 은 고정 21 트리거 ≈ 50KB, cmp_A2 26장 표). 변경된 셀만 쓰는 모드를 기본으로.

### E.5 위험·미확인

- 줄 표시 시간이 어디에 저장되는지 확인 못 함. CDPrint 방식은 줄이 꺼지면 아무것도 안 보인다 → `chat_active` 로 확인 후 필요하면 `chat_prime`.
- DisplayText 를 쓰는 다른 코드(사용자 채팅 포함)가 slot 을 밀어낸다 → 화면 위치 기준(`absolute=True`)은 매 프레임 slot 을 다시 계산.
- 13번째 줄: 오류 문구를 띄운 **뒤에** 써야 한다(G8 1.7, 순서 반대면 덮임 — 추측이나 EP 도 같은 순서).
- CCMU 는 공유 동작(CreateUnit 실패)이라 **모든 클라이언트에서 같은 조건으로** 불러야 한다(G8 1.6).

---

## 부록: 이번에 새로 확인한 사실 (cmp_A2 보강)

- eudplib 0.76.14 에서 `IsUnlimiterOn()` 을 켜는 코드는 없다. unlimiter 플러그인도 켜지 않는다.
- `CSprite.from_read` 는 언리미터 스프라이트에서 틀린 포인터를 준다(memifgen.py:194~199 의 0x620000 가정).
- `fmt()` 훅(eudprint.py:269, cpprint.py:223)과 `LocalLocale`(locale.py:75) 이 서식 확장의 선례다.
- 사용자 맵 `Galaxy.py`(MapSource\Py) 에 이미 eudplib CreateBullet 이 있다(0x628438 선읽기 + 주문 135).
- DPL `dp.ItoDec` 의 Sign=1 은 양수에 `+` 를 쓰지 않는다(CA ItoDec 과 다름).
- CtrigAsm `DigitMin` 은 "아래 자리 지우기"다(최소 폭 아님).
