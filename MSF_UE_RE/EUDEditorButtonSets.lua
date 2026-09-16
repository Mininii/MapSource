--[[
	EUDEditorButtonSets.lua  -  커맨드카드(버튼셋) 정의 (2026-09-15 에 EUD Editor 3 에서 옮김, 이제 이 파일이 원본)

	적용: EUDEditorPort.lua - RegisterButtonSetData()(선언 전용 CJump 안) + ApplyButtonSetData()(맵 첫 프레임 1회).
	구조: buttonSetTable 0x5187E8, BUTTON_SET[250] (stride 12) - +0 버튼 수 / +4 BUTTON 배열 주소 / +8 0xFFFF.
	행 = {칸(1~9), 아이콘, 조건 함수, 실행 함수, 조건 값, 실행 값, 툴팁(활성), 툴팁(비활성)} - BUTTON 20바이트 그대로다.
	  - 같은 칸에 여러 줄을 두면 조건 함수가 통과하는 첫 줄이 보인다(배럭 4칸의 예약메딕 단계처럼). 줄 순서를 지킬 것.
	  - 툴팁 번호는 stat_txt.tbl 의 줄 번호다. 글은 EUDEditorStatTxt.lua 에서 바꾼다.
	  - 함수 이름은 BWAPI 의 Broodwar.map(BTNSCOND_*/BTNSACT_*) 기준. 주소는 1.16.1 값이다.
]]

BSReq = {
	Always              = 0x004282D0,
	CanBuildUnit        = 0x00428E60,
	CanBuildSubunit     = 0x00428E00,
	CanUpgrade          = 0x00429450,
	CanResearch         = 0x00429500,
	HasTech             = 0x004294E0,
	IsResearching       = 0x004288E0,
	IsUpgrading         = 0x00428900,
	IsTraining          = 0x00428530,
	IsBuildingAddon     = 0x00428920,
	CanAttack           = 0x00428F30,
	Rally               = 0x00429520,
	CanMove             = 0x00428DA0,
	CanMoveSpecialCase  = 0x00428D40,
	SCVCanMove          = 0x00428670,
	SCVCanStop          = 0x00428640,
	SCVCanAttack        = 0x00428610,
	SCVisBuilding       = 0x00428310,
	TerranBasic         = 0x00428A10,
}

BSAct = {
	Train           = 0x004234B0,
	Upgrade         = 0x00423310,
	Research        = 0x00423350,
	UseTech         = 0x00423F70,
	CancelTrain     = 0x00423490,
	CancelUpgrade   = 0x004232F0,
	CancelResearch  = 0x00423330,
	CancelAddon     = 0x004232D0,
	ChangeButtons   = 0x00459AF0,
	Move            = 0x00424440,
	Stop            = 0x004233F0,
	AttackMove      = 0x00424380,
	Patrol          = 0x00424140,
	HoldPosition    = 0x00423370,
	Stimpack        = 0x004234D0,
	RallyPoint      = 0x004244A0,
	BuildTerran     = 0x00423EB0,
}

--[[ 멀티 커맨드 쪽 (2026-09-15)
	배럭 8칸 "멀티 커맨드" 버튼(ChangeButtons)으로 넘어가는 두 번째 쪽. 적 유닛의 버튼셋 번호를 빌려 쓴다 -
	버튼셋은 유닛 번호로 찾지만 적(컴퓨터) 유닛의 커맨드카드는 사람에게 보이지 않으므로, 그 칸을 새 쪽으로 써도 된다
	(상점 2쪽이 적 유닛 220 = 포인트 박스 칸을 쓰는 것과 같은 방식).
	  77 = Fenix (Zealot), 적 영웅. P8 만 만들고(Gun_SpawnSet.lua, Identity.lua) 사람이나 관전 슬롯(P9~P12)에게 넘기는 곳이 없다.
	  바꿀 때도 사람이 절대 갖지 않는 번호로 할 것. 관전 슬롯에 GiveUnits 하는 유닛(DemonLanterns 의 Danimoth 등)은
	  관전자가 그 카드를 보게 되므로 피한다.
	버튼은 전부 신호 유닛을 뽑는 Train 이다(MSF_Respect_V 팩토리와 같은 방식). 뽑힌 유닛을 Player_interface.lua 가 잡는다:
	  이동 64 / 공격 66              -> 그 플레이어의 마우스 위치(로케이션 74+i, eds 의 MSQC "mouse:")로 마린에게 Order
	  정지 65 / 홀드 67 / 원격스팀 71 -> 예전 배럭 멀티 버튼 그대로 (CUnit 루프, 그 플레이어의 전체 유닛)
	한 번 쓸 때 미네랄은 EUDinit.lua 의 UnitEnableX 가 정한다: 이동·정지·공격·홀드·원격스팀은 전부 0 이고
	(2026-09-16 에 정지·홀드 1200, 원격스팀 400 을 없앴다) 같이 옮겨 온 메딕 뽑기만 250~400 이다.
	신호 유닛 5종(MultiCmdUnits)은 멀티 커맨드를 가진 플레이어에게만 열린다(Player_interface.lua, 0x57F27C).
	이동·공격은 버튼을 마우스로 누르면 마우스가 콘솔 위에 있어 목표가 엉뚱해진다 - 단축키(M/A)로 쓴다.
]]
MultiCmdButtonSetID = 77
MultiCmdUnits = {64, 65, 66, 67, 71} -- 이동, 정지, 공격, 홀드, 원격스팀

--[[ 멀티 커맨드 쪽을 열어 둔 채 우클릭(랠리 변경) = 멀티 이동 (2026-09-16)
	콘솔에 떠 있는 버튼셋 번호는 0x68C14C 에 있다 (EUD Editor 3 의 Data\Lua\TriggerEditor\Selection.lua 의
	"선택 유닛의 버튼셋 ID" 조건이 EPD(0x68C14C) 를 본다. 유닛별 값은 CUnit+0x94 - BWAPI CUnit.h).
	그런데 이것은 **클라이언트마다 다른 로컬 화면 상태**라 트리거 조건으로 바로 쓰면 디싱크다.
	그래서 eds 의 MSQC 한 줄로 공유값(데스)으로 옮긴다:
	    Memory(0x68C14C,Exactly,<쪽 번호>);val, 0x68C14C : <아래 데스 유닛>
	MSQC 는 val 로 받은 데스 칸을 **매 사이클 0 으로 지운 뒤** 보내온 값을 SetTo 한다. 그래서 위 한 줄이면
	그 쪽을 보고 있는 동안 <데스> = 쪽 번호, 아니면 0 이 된다(끄는 줄이 따로 필요 없다).
	데스 유닛 190 = Warp Gate. 이 맵이 유닛으로도, 데스 칸으로도 안 쓴다(SCR_DB 는 182~189).
	사람이 가질 일이 없는 특수 건물이라 죽어서 데스가 올라 값이 더러워질 일도 없다.
	쓰는 곳: Player_interface.lua 의 배럭 랠리 갱신 (핵 발사와 갈라진다). 값은 build_scrdb.py 가 이 파일에서 읽어
	eds 에 넣으므로 여기만 고치면 된다. ]]
MultiCmdFlagDeath = 190

ButtonSetDefs = {
	[0] = { -- 마린
		{1, 228, BSReq.Always,             BSAct.Move,             0,   0,  664,    0}, -- Move
		{2, 229, BSReq.Always,             BSAct.Stop,             0,   0,  665,    0}, -- Stop
		{3, 230, BSReq.CanAttack,          BSAct.AttackMove,       0,   0,  666,    0}, -- Attack
		{4, 254, BSReq.Always,             BSAct.Patrol,           0,   0,  667,    0}, -- Patrol
		{5, 255, BSReq.Always,             BSAct.HoldPosition,     0,   0,  668,    0}, -- Hold Position
		{7, 237, BSReq.HasTech,            BSAct.Stimpack,         0,   0,  334,  346}, -- ★ 스팀떡상 가즈아~~ (T) ★
	},
	[1] = { -- 고스트
		{1, 228, BSReq.Always,             BSAct.Move,             0,   0,  664,    0}, -- Move
		{2, 229, BSReq.Always,             BSAct.Stop,             0,   0,  665,    0}, -- Stop
		{3, 230, BSReq.CanAttack,          BSAct.AttackMove,       0,   0,  666,    0}, -- Attack
		{4, 254, BSReq.Always,             BSAct.Patrol,           0,   0,  667,    0}, -- Patrol
		{5, 255, BSReq.Always,             BSAct.HoldPosition,     0,   0,  668,    0}, -- Hold Position
		{7, 237, BSReq.HasTech,            BSAct.Stimpack,         0,   0,  334,  346}, -- ★ 스팀떡상 가즈아~~ (T) ★
	},
	[7] = { -- SCV
		{1, 228, BSReq.SCVCanMove,         BSAct.Move,             0,   0,  664,    0}, -- Move
		{2, 229, BSReq.SCVCanStop,         BSAct.Stop,             0,   0,  665,    0}, -- Stop
		{3, 230, BSReq.SCVCanAttack,       BSAct.AttackMove,       0,   0,  666,    0}, -- Attack
		{4, 254, BSReq.SCVCanMove,         BSAct.Patrol,           0,   0,  667,    0}, -- Patrol
		{5, 255, BSReq.SCVCanStop,         BSAct.HoldPosition,     0,   0,  668,    0}, -- Hold Position
		{6, 237, BSReq.HasTech,            BSAct.Stimpack,         0,   0,  334,  346}, -- ★ 스팀떡상 가즈아~~ (T) ★
		{7, 234, BSReq.TerranBasic,        BSAct.ChangeButtons,    0, 239,  678,    0}, -- Build Structure
		{9, 236, BSReq.SCVisBuilding,      BSAct.Stop,             0,   0,  700,    0}, -- ESC - Halt Construction
	},
	[12] = { -- 배틀크루저
		{1, 228, BSReq.Always,             BSAct.Move,             0,   0,  664,    0}, -- Move
		{2, 229, BSReq.Always,             BSAct.Stop,             0,   0,  665,    0}, -- Stop
		{3, 230, BSReq.CanAttack,          BSAct.AttackMove,       0,   0,  666,    0}, -- Attack
		{4, 254, BSReq.Always,             BSAct.Patrol,           0,   0,  667,    0}, -- Patrol
		{5, 255, BSReq.Always,             BSAct.HoldPosition,     0,   0,  668,    0}, -- Hold Position
		{7, 237, BSReq.HasTech,            BSAct.Stimpack,         0,   0,  334,  346}, -- ★ 스팀떡상 가즈아~~ (T) ★
		{9, 386, BSReq.CanBuildUnit,       BSAct.Train,           22,  22, 1494, 1294}, -- ★ 스킬 ON/OFF (E) ★
	},
	[15] = { -- (유닛 15)
		{1, 228, BSReq.Always,             BSAct.Move,             0,   0,  664,    0}, -- Move
		{2, 229, BSReq.Always,             BSAct.Stop,             0,   0,  665,    0}, -- Stop
		{3, 230, BSReq.CanAttack,          BSAct.AttackMove,       0,   0,  666,    0}, -- Attack
		{4, 254, BSReq.Always,             BSAct.Patrol,           0,   0,  667,    0}, -- Patrol
		{5, 255, BSReq.Always,             BSAct.HoldPosition,     0,   0,  668,    0}, -- Hold Position
		{7, 237, BSReq.HasTech,            BSAct.Stimpack,         0,   0,  334,  346}, -- ★ 스팀떡상 가즈아~~ (T) ★
	},
	[16] = { -- (유닛 16)
		{1, 228, BSReq.Always,             BSAct.Move,             0,   0,  664,    0}, -- Move
		{2, 229, BSReq.Always,             BSAct.Stop,             0,   0,  665,    0}, -- Stop
		{3, 230, BSReq.CanAttack,          BSAct.AttackMove,       0,   0,  666,    0}, -- Attack
		{4, 254, BSReq.Always,             BSAct.Patrol,           0,   0,  667,    0}, -- Patrol
		{5, 255, BSReq.Always,             BSAct.HoldPosition,     0,   0,  668,    0}, -- Hold Position
		{7, 237, BSReq.HasTech,            BSAct.Stimpack,         0,   0,  334,  346}, -- ★ 스팀떡상 가즈아~~ (T) ★
	},
	[99] = { -- (유닛 99)
		{1, 228, BSReq.Always,             BSAct.Move,             0,   0,  664,    0}, -- Move
		{2, 229, BSReq.Always,             BSAct.Stop,             0,   0,  665,    0}, -- Stop
		{3, 230, BSReq.CanAttack,          BSAct.AttackMove,       0,   0,  666,    0}, -- Attack
		{4, 254, BSReq.Always,             BSAct.Patrol,           0,   0,  667,    0}, -- Patrol
		{5, 255, BSReq.Always,             BSAct.HoldPosition,     0,   0,  668,    0}, -- Hold Position
		{7, 237, BSReq.HasTech,            BSAct.Stimpack,         0,   0,  334,  346}, -- ★ 스팀떡상 가즈아~~ (T) ★
	},
	[100] = { -- (유닛 100)
		{1, 228, BSReq.Always,             BSAct.Move,             0,   0,  664,    0}, -- Move
		{2, 229, BSReq.Always,             BSAct.Stop,             0,   0,  665,    0}, -- Stop
		{3, 230, BSReq.CanAttack,          BSAct.AttackMove,       0,   0,  666,    0}, -- Attack
		{4, 254, BSReq.Always,             BSAct.Patrol,           0,   0,  667,    0}, -- Patrol
		{5, 255, BSReq.Always,             BSAct.HoldPosition,     0,   0,  668,    0}, -- Hold Position
		{7, 237, BSReq.HasTech,            BSAct.Stimpack,         0,   0,  334,  346}, -- ★ 스팀떡상 가즈아~~ (T) ★
	},
	[107] = { -- 컴샛 스테이션
		{1, 250, BSReq.HasTech,            BSAct.UseTech,          4,   4,  337, 1546}, -- s★ 어디숨었냐~~ (S) ★
		{2, 388, BSReq.CanBuildUnit,       BSAct.Train,           72,  72,  606, 1546}, -- h★ 예약메딕 조정 (H) ★
		{3, 386, BSReq.CanBuildUnit,       BSAct.Train,           22,  22,  587, 1546}, -- g★ BGM 조정 (G) ★
		{4, 387, BSReq.CanBuildUnit,       BSAct.Train,           29,  29, 1367, 1546}, -- r★ 영작 알림 소리 조정 (R) ★
		{5, 289, BSReq.CanUpgrade,         BSAct.Upgrade,         17,  17, 1368,  504}, -- 
		{6, 293, BSReq.CanUpgrade,         BSAct.Upgrade,         20,  20, 1371,  504}, -- 
		{8, 290, BSReq.CanUpgrade,         BSAct.Upgrade,         18,  18, 1370,  504}, -- 
		{9, 291, BSReq.CanUpgrade,         BSAct.Upgrade,         19,  19, 1372,  504}, -- 
	},
	[111] = { -- 배럭
		{1,   0, BSReq.CanBuildUnit,       BSAct.Train,           28,  28,  596,  701}, -- m★ ExceeD Marine 생산 (M) ★
		{2,   7, BSReq.CanBuildUnit,       BSAct.Train,            7,   7,  592,  701}, -- f★ 노예 SCV (F) 생산 ★
		{3,  14, BSReq.CanBuildUnit,       BSAct.Train,           41,  41, 1487, 1294}, -- z『 뉴클리어 1발 장전  (Z) 』
		{4, 365, BSReq.CanBuildUnit,       BSAct.Train,           80,  80, 1290, 1294}, -- c★ 멘탈 힐링하기 (C) ★
		{4, 365, BSReq.CanBuildUnit,       BSAct.Train,           88,  88, 1290, 1294}, -- c★ 멘탈 힐링하기 (C) ★
		{4, 365, BSReq.CanBuildUnit,       BSAct.Train,           34,  34, 1290, 1294}, -- c★ 멘탈 힐링하기 (C) ★
		{4, 365, BSReq.CanBuildUnit,       BSAct.Train,            9,   9, 1290, 1294}, -- c★ 멘탈 힐링하기 (C) ★
		{4,   4, BSReq.CanBuildUnit,       BSAct.Train,           70,  70, 1497, 1546}, -- ★ 모든 유닛에 자율공격명령 내리기 (X) ★
		{5, 219, BSReq.CanBuildUnit,       BSAct.Train,           19,  19, 1498,  701}, -- v★ 수정 보호막 사용 (V) ★
		{6, 286, BSReq.Rally,              BSAct.RallyPoint,       0,   0,  672,    0}, -- Set Rally Point
		-- 7~9칸에 있던 멀티 버튼(공격 66 / 원격스팀 71 / 정지 65 / 홀드 67)은 멀티 커맨드 쪽으로 옮겼다 (2026-09-15).
		-- 8칸 = 그 쪽으로 넘어가는 버튼. 64(이동)를 뽑을 수 있을 때 = **멀티 커맨드를 산 사람에게만** 보인다.
		-- 메딕 뽑기는 위 4칸에 그대로 있으므로, 안 산 사람이 이 쪽을 못 열어도 메딕은 배럭에서 쓴다 (2026-09-16, 제작자 지시).
		{8, 228, BSReq.CanBuildUnit,       BSAct.ChangeButtons,   64, MultiCmdButtonSetID, 1489, 0}, -- ★ 멀티 커맨드 (Q) ★
		{9, 236, BSReq.IsTraining,         BSAct.CancelTrain,      0, 254,  693,    0}, -- ESC - Cancel Last
	},
	[MultiCmdButtonSetID] = { -- 멀티 커맨드 쪽 (배럭 8칸에서 넘어온다. 선택된 유닛은 그대로 배럭이다)
		{1, 228, BSReq.CanBuildUnit,       BSAct.Train,           64,  64, 1495,    0}, -- 이동 (M): 마우스 위치로 마린 이동
		{2, 229, BSReq.CanBuildUnit,       BSAct.Train,           65,  65, 1366,    0}, -- 정지 (S): 전체 유닛
		{3, 230, BSReq.CanBuildUnit,       BSAct.Train,           66,  66, 1493, 1294}, -- 공격 (A): 마우스 위치로 마린 공격 이동
		-- 4칸 = 메딕 뽑기. 배럭 4칸과 **같은 줄을 여기에도 둔다** - 두 곳 어디서나 쓴다 (2026-09-16, 제작자 지시).
		-- 네 줄이 겹쳐 있고 지금 단계 하나만 보이는 것도 배럭과 같다. 값도 그대로 250~400 미네랄.
		{4, 365, BSReq.CanBuildUnit,       BSAct.Train,           80,  80, 1290, 1294}, -- c★ 멘탈 힐링하기 (C) ★
		{4, 365, BSReq.CanBuildUnit,       BSAct.Train,           88,  88, 1290, 1294}, -- c★ 멘탈 힐링하기 (C) ★
		{4, 365, BSReq.CanBuildUnit,       BSAct.Train,           34,  34, 1290, 1294}, -- c★ 멘탈 힐링하기 (C) ★
		{4, 365, BSReq.CanBuildUnit,       BSAct.Train,            9,   9, 1290, 1294}, -- c★ 멘탈 힐링하기 (C) ★
		{5, 255, BSReq.CanBuildUnit,       BSAct.Train,           67,  67, 1365,    0}, -- 홀드 (H): 전체 유닛
		{7, 237, BSReq.CanBuildUnit,       BSAct.Train,           71,  71, 1364,  701}, -- 원격 스팀팩 (T): 전체 유닛
		{9, 389, BSReq.Always,             BSAct.ChangeButtons,    0, 111, 1490,    0}, -- 뒤로 (Q): 배럭 본 쪽
	},
	[128] = { -- 상점 메뉴 유닛
		{1, 313, BSReq.CanBuildUnit,       BSAct.Train,           50,  50, 1477, 1294}, -- 『 스탯 초기화 (LV.1에서만 사용가능) 』
		{2, 283, BSReq.CanBuildUnit,       BSAct.Train,           49,  49, 1478, 1294}, -- 
		{3, 388, BSReq.Always,             BSAct.ChangeButtons,    0, 220, 1476, 1546}, -- 『 다음으로 (R) 』
		{4, 310, BSReq.CanBuildUnit,       BSAct.Train,           48,  48, 1479, 1294}, -- s『 쉴드 업그레이드 구입 (Cost:15) (S) 』
		{5, 323, BSReq.CanBuildUnit,       BSAct.Train,           46,  46, 1480, 1294}, -- 
		{6, 377, BSReq.CanBuildUnit,       BSAct.Train,           47,  47, 1481, 1294}, -- 
		{7, 237, BSReq.CanBuildUnit,       BSAct.Train,           42,  42, 1488, 1294}, -- 멀티 커맨드 구입 (X) - 원격스팀/멀티스탑/멀티홀드(42/43/44)를 합쳤다 (2026-09-15)
	},
	[220] = { -- 상점 2쪽 (적 유닛 220 = 포인트 박스 슬롯)
		{1, 313, BSReq.CanBuildUnit,       BSAct.Train,           50,  50, 1477, 1294}, -- 『 스탯 초기화 (LV.1에서만 사용가능) 』
		{3, 389, BSReq.Always,             BSAct.ChangeButtons,    0, 128, 1475, 1546}, -- 『 뒤로가기 (F) 』
		{4, 283, BSReq.CanBuildUnit,       BSAct.Train,           51,  51, 1474, 1294}, -- 
		{7, 177, BSReq.CanBuildUnit,       BSAct.Train,           52,  52, 1473, 1294}, -- z『 미네랄 최종 획득량 증가 구입 (+10%) (Cost:10,000) (Z) 』
	},
	[239] = { -- SCV 건설 메뉴(고급)
		{6, 124, BSReq.CanBuildUnit,       BSAct.BuildTerran,    124, 124,  651,  717}, -- tBuild Missile Turret
		{8, 125, BSReq.CanBuildUnit,       BSAct.BuildTerran,    125, 125,  653,  718}, -- uBuild Bunker
		{9, 236, BSReq.Always,             BSAct.ChangeButtons,    0, 228,  688,    0}, -- ESC - Cancel
	},
	[244] = { -- 여러 종류를 섞어 선택했을 때
		{1, 228, BSReq.CanMove,            BSAct.Move,             0,   0,  664,    0}, -- Move
		{2, 229, BSReq.CanMoveSpecialCase, BSAct.Stop,             0,   0,  665,    0}, -- Stop
		{3, 230, BSReq.CanAttack,          BSAct.AttackMove,       0,   0,  666,    0}, -- Attack
		{4, 254, BSReq.CanMove,            BSAct.Patrol,           0,   0,  667,    0}, -- Patrol
		{5, 255, BSReq.CanMove,            BSAct.HoldPosition,     0,   0,  668,    0}, -- Hold Position
		{7, 237, BSReq.HasTech,            BSAct.Stimpack,         0,   0,  334,  346}, -- ★ 스팀떡상 가즈아~~ (T) ★
	},
}
