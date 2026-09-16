--[[
	EUDEditorButtonSets.lua  -  커맨드카드(버튼셋) 정의 (2026-09-16 에 EUD Editor 3 에서 옮김, 이제 이 파일이 원본)

	적용: EUDEditorPort.lua - RegisterButtonSetData()(선언 전용 CJump 안) + ApplyButtonSetData()(맵 첫 프레임 1회).
	구조: buttonSetTable 0x5187E8, BUTTON_SET[250] (stride 12) - +0 버튼 수 / +4 BUTTON 배열 주소 / +8 0xFFFF.
	행 = {칸(1~9), 아이콘, 조건 함수, 실행 함수, 조건 값, 실행 값, 툴팁(활성), 툴팁(비활성)} - BUTTON 20바이트 그대로다.
	  - 같은 칸에 여러 줄을 두면 조건 함수가 통과하는 첫 줄이 보인다(배럭 4칸의 예약메딕 단계처럼). 줄 순서를 지킬 것.
	  - 툴팁 번호는 stat_txt.tbl 의 줄 번호다. 글은 EUDEditorStatTxt.lua 에서 바꾼다.
	  - 함수 이름은 BWAPI 의 Broodwar.map(BTNSCOND_*/BTNSACT_*) 기준. 주소는 1.16.1 값이다.
	  - System.lua 가 P5~P8 자리(관전)에서 보는 사람에게는 게임 시작 3초 뒤 모든 버튼셋을 0 으로 지운다 (예전과 같다).
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

ButtonSetDefs = {
	[0] = { -- 마린 (P1 마린, Var_init.lua 의 MarID[1])
		{1, 228, BSReq.Always,             BSAct.Move,             0,   0,  664,    0}, -- 이동 (M)
		{2, 229, BSReq.Always,             BSAct.Stop,             0,   0,  665,    0}, -- 정지 (S)
		{3, 230, BSReq.CanAttack,          BSAct.AttackMove,       0,   0,  666,    0}, -- 공격 (A)
		{4, 254, BSReq.Always,             BSAct.Patrol,           0,   0,  667,    0}, -- 순찰 (P)
		{5, 255, BSReq.Always,             BSAct.HoldPosition,     0,   0,  668,    0}, -- 위치 사수 (H)
		{7, 237, BSReq.HasTech,            BSAct.Stimpack,         0,   0,  334,  346}, -- Use Stim Packs
	},
	[1] = { -- 고스트 (P2 마린, MarID[2])
		{1, 228, BSReq.Always,             BSAct.Move,             0,   0,  664,    0}, -- 이동 (M)
		{2, 229, BSReq.Always,             BSAct.Stop,             0,   0,  665,    0}, -- 정지 (S)
		{3, 230, BSReq.CanAttack,          BSAct.AttackMove,       0,   0,  666,    0}, -- 공격 (A)
		{4, 254, BSReq.Always,             BSAct.Patrol,           0,   0,  667,    0}, -- 순찰 (P)
		{5, 255, BSReq.Always,             BSAct.HoldPosition,     0,   0,  668,    0}, -- 위치 사수 (H)
		{7, 237, BSReq.HasTech,            BSAct.Stimpack,         0,   0,  334,  346}, -- Use Stim Packs
	},
	[7] = { -- SCV
		{1, 228, BSReq.SCVCanMove,         BSAct.Move,             0,   0,  664,    0}, -- 이동 (M)
		{2, 229, BSReq.SCVCanStop,         BSAct.Stop,             0,   0,  665,    0}, -- 정지 (S)
		{3, 230, BSReq.SCVCanAttack,       BSAct.AttackMove,       0,   0,  666,    0}, -- 공격 (A)
		{4, 254, BSReq.CanMove,            BSAct.Patrol,           0,   0,  667,    0}, -- 순찰 (P)
		{5, 255, BSReq.CanMove,            BSAct.HoldPosition,     0,   0,  668,    0}, -- 위치 사수 (H)
		{7, 234, BSReq.TerranBasic,        BSAct.ChangeButtons,    0, 239,  678,    0}, -- 구조물 건설 (B)
		{8, 237, BSReq.HasTech,            BSAct.Stimpack,         0,   0,  334,  346}, -- Use Stim Packs
		{9, 236, BSReq.SCVisBuilding,      BSAct.Stop,             0,   0,  700,    0}, -- ESC - 건설 중지
	},
	[16] = { -- (유닛 16 = P3 마린, MarID[3])
		{1, 228, BSReq.Always,             BSAct.Move,             0,   0,  664,    0}, -- 이동 (M)
		{2, 229, BSReq.Always,             BSAct.Stop,             0,   0,  665,    0}, -- 정지 (S)
		{3, 230, BSReq.CanAttack,          BSAct.AttackMove,       0,   0,  666,    0}, -- 공격 (A)
		{4, 254, BSReq.Always,             BSAct.Patrol,           0,   0,  667,    0}, -- 순찰 (P)
		{5, 255, BSReq.Always,             BSAct.HoldPosition,     0,   0,  668,    0}, -- 위치 사수 (H)
		{7, 237, BSReq.HasTech,            BSAct.Stimpack,         0,   0,  334,  346}, -- Use Stim Packs
	},
	[99] = { -- (유닛 99 = P4 마린, MarID[4])
		{1, 228, BSReq.Always,             BSAct.Move,             0,   0,  664,    0}, -- 이동 (M)
		{2, 229, BSReq.Always,             BSAct.Stop,             0,   0,  665,    0}, -- 정지 (S)
		{3, 230, BSReq.CanAttack,          BSAct.AttackMove,       0,   0,  666,    0}, -- 공격 (A)
		{4, 254, BSReq.Always,             BSAct.Patrol,           0,   0,  667,    0}, -- 순찰 (P)
		{5, 255, BSReq.Always,             BSAct.HoldPosition,     0,   0,  668,    0}, -- 위치 사수 (H)
		{7, 237, BSReq.HasTech,            BSAct.Stimpack,         0,   0,  334,  346}, -- Use Stim Packs
	},
	[107] = { -- 컴샛 스테이션
		{1, 250, BSReq.HasTech,            BSAct.UseTech,          4,   4,  337, 1546}, -- s스캐너 탐색 (탐지기) (S)
		{2, 365, BSReq.CanBuildUnit,       BSAct.Train,           72,  72,  606, 1546}, -- w···【 예약메딕 사용 Ｗ 】···
		{3, 214, BSReq.Always,             BSAct.ChangeButtons,    0, 240, 1346, 1546}, -- ···【 기부센터 Ｑ 】···
		{4, 389, BSReq.CanBuildUnit,       BSAct.Train,           50,  50, 1497, 1546}, -- a···【 Color Skin 값 내리기 A 】···
		{5, 387, BSReq.CanBuildUnit,       BSAct.Train,           54,  54, 1498, 1546}, -- z···【 Color Skin 단위 변경 Z 】···
		{6, 388, BSReq.CanBuildUnit,       BSAct.Train,           53,  53, 1499, 1546}, -- d···【 Color Skin 값 올리기 D 】···
		{7, 386, BSReq.CanBuildUnit,       BSAct.Train,           22,  22,  587, 1546}, -- g···【 BGM 설정 G 】···
		{8, 383, BSReq.CanBuildUnit,       BSAct.Train,           23,  23, 1396, 1546}, -- ···【 Eternal Mode, 理論値 MODE ON 】···
		{9, 312, BSReq.CanBuildUnit,       BSAct.ChangeButtons,   60, 243, 1467, 1546}, -- ···【 배속, 강퇴기능 】···
	},
	[111] = { -- 배럭
		{1,   0, BSReq.CanBuildUnit,       BSAct.Train,            8,   8,  586, 1546}, -- m해병 훈련 (M)
		{2, 176, BSReq.CanBuildUnit,       BSAct.Train,            2,   2,  588, 1546}, -- g···【 자동환전 G 】···
		{3,   7, BSReq.CanBuildUnit,       BSAct.Train,            7,   7,  592, 1546}, -- fBuild SCV(F)
		{4,  34, BSReq.CanBuildUnit,       BSAct.Train,            9,   9, 1290, 1546}, -- c의무관 훈련 (C)
		{4,  34, BSReq.CanBuildUnit,       BSAct.Train,           34,  34, 1290, 1546}, -- c의무관 훈련 (C)
		{4,  34, BSReq.CanBuildUnit,       BSAct.Train,            5,   5, 1290, 1546}, -- c의무관 훈련 (C)
		{4,  34, BSReq.CanBuildUnit,       BSAct.Train,           10,  10, 1290, 1546}, -- c의무관 훈련 (C)
		{5, 219, BSReq.CanBuildUnit,       BSAct.Train,           19,  19,  589, 1545}, -- v···【 빛의 보호막 V 】···
		{6,  16, BSReq.CanBuildUnit,       BSAct.Train,           28,  28, 1354, 1546}, -- r···【 ＬｕｍｉＡ Ｍａｒｉｎｅ 바로 생산 (R) 】···
		{7, 237, BSReq.CanBuildUnit,       BSAct.Train,           71,  71,  334, 1546}, -- Use Stim Packs
		{8, 288, BSReq.CanUpgrade,         BSAct.Upgrade,          8,   8,  463, 1413}, -- w보병 공격력 업그레이드 (W)
		{8, 229, BSReq.CanBuildUnit,       BSAct.Train,           74,  74,  665, 1546}, -- 정지 (S)
		{8, 288, BSReq.CanUpgrade,         BSAct.Upgrade,          7,   7,  463, 1413}, -- w보병 공격력 업그레이드 (W)
		{9, 377, BSReq.CanUpgrade,         BSAct.Upgrade,          0,   0,  456, 1414}, -- a보병 방어력 업그레이드 (A)
		{9, 377, BSReq.CanUpgrade,         BSAct.Upgrade,          1,   1,  456, 1414}, -- a보병 방어력 업그레이드 (A)
		{9, 255, BSReq.CanBuildUnit,       BSAct.Train,           75,  75,  668, 1546}, -- 위치 사수 (H)
	},
	[239] = { -- SCV 건설 메뉴 (SCV 7칸 Build Structure 에서 넘어온다)
		{2, 109, BSReq.CanBuildUnit,       BSAct.BuildTerran,    109, 109,  647, 1546}, -- s보급고 건설 (S)
		{6, 124, BSReq.CanBuildUnit,       BSAct.BuildTerran,    124, 124,  651,  717}, -- t미사일 포탑 건설 (T)
		{8, 125, BSReq.CanBuildUnit,       BSAct.BuildTerran,    125, 125,  653,  718}, -- u벙커 건설 (U)
		{9, 236, BSReq.Always,             BSAct.ChangeButtons,    0, 228,  688, 1546}, -- ESC - 취소
	},
	[240] = { -- 컴샛 3칸에서 넘어오는 쪽
		{1, 309, BSReq.CanBuildUnit,       BSAct.Train,           66,  66, 1349, 1546}, -- q···【 빨강에게 기부 Ｑ 】···
		{2, 309, BSReq.CanBuildUnit,       BSAct.Train,           67,  67, 1350, 1546}, -- w···【 파랑에게 기부 W 】···
		{3, 377, BSReq.CanBuildUnit,       BSAct.Train,           70,  70, 1353, 1546}, -- z···【 기부 단위 변경 Ｚ 】···
		{4, 309, BSReq.CanBuildUnit,       BSAct.Train,           68,  68, 1351, 1546}, -- a···【 연두에게 기부 A 】···
		{5, 309, BSReq.CanBuildUnit,       BSAct.Train,           69,  69, 1352, 1546}, -- s···【 보라에게 기부 S 】···
		{6, 236, BSReq.IsTraining,         BSAct.CancelTrain,     70,  70,  693, 1546}, -- ESC - 취소
		{9, 236, BSReq.Always,             BSAct.ChangeButtons,   70, 228,  689, 1546}, -- ESC - 건설 취소
	},
	[243] = { -- 컴샛 9칸에서 넘어오는 쪽
		{1, 312, BSReq.CanBuildUnit,       BSAct.Train,           63,  63, 1343, 1546}, -- ···【  파랑 강퇴하기 】···
		{2, 312, BSReq.CanBuildUnit,       BSAct.Train,           64,  64, 1344, 1546}, -- ···【  연두 강퇴하기 】···
		{3, 312, BSReq.CanBuildUnit,       BSAct.Train,           65,  65, 1341, 1546}, -- ···【  보라 강퇴하기 】···
		{7, 389, BSReq.CanBuildUnit,       BSAct.Train,           61,  61, 1348, 1546}, -- z···【  배속 내리기 Z 】···
		{8, 388, BSReq.CanBuildUnit,       BSAct.Train,           62,  62, 1347, 1546}, -- x···【  배속 올리기 X 】···
		{9, 236, BSReq.Always,             BSAct.ChangeButtons,    0, 228,  688,    0}, -- ESC - 취소
	},
	[244] = { -- 여러 종류를 섞어 선택했을 때
		{1, 228, BSReq.CanMove,            BSAct.Move,             0,   0,  664,    0}, -- 이동 (M)
		{2, 229, BSReq.CanMoveSpecialCase, BSAct.Stop,             0,   0,  665,    0}, -- 정지 (S)
		{3, 230, BSReq.CanAttack,          BSAct.AttackMove,       0,   0,  666,    0}, -- 공격 (A)
		{4, 254, BSReq.CanMove,            BSAct.Patrol,           0,   0,  667,    0}, -- 순찰 (P)
		{5, 255, BSReq.CanMove,            BSAct.HoldPosition,     0,   0,  668,    0}, -- 위치 사수 (H)
		{7, 237, BSReq.HasTech,            BSAct.Stimpack,         0,   0,  334,  346}, -- Use Stim Packs
	},
	[245] = { -- (버튼셋 245, 244 와 같은 내용)
		{1, 228, BSReq.CanMove,            BSAct.Move,             0,   0,  664,    0}, -- 이동 (M)
		{2, 229, BSReq.CanMoveSpecialCase, BSAct.Stop,             0,   0,  665,    0}, -- 정지 (S)
		{3, 230, BSReq.CanAttack,          BSAct.AttackMove,       0,   0,  666,    0}, -- 공격 (A)
		{4, 254, BSReq.CanMove,            BSAct.Patrol,           0,   0,  667,    0}, -- 순찰 (P)
		{5, 255, BSReq.CanMove,            BSAct.HoldPosition,     0,   0,  668,    0}, -- 위치 사수 (H)
		{7, 237, BSReq.HasTech,            BSAct.Stimpack,         0,   0,  334,  346}, -- Use Stim Packs
	},
	[246] = { -- (버튼셋 246, 244 와 같은 내용)
		{1, 228, BSReq.CanMove,            BSAct.Move,             0,   0,  664,    0}, -- 이동 (M)
		{2, 229, BSReq.CanMoveSpecialCase, BSAct.Stop,             0,   0,  665,    0}, -- 정지 (S)
		{3, 230, BSReq.CanAttack,          BSAct.AttackMove,       0,   0,  666,    0}, -- 공격 (A)
		{4, 254, BSReq.CanMove,            BSAct.Patrol,           0,   0,  667,    0}, -- 순찰 (P)
		{5, 255, BSReq.CanMove,            BSAct.HoldPosition,     0,   0,  668,    0}, -- 위치 사수 (H)
		{7, 237, BSReq.HasTech,            BSAct.Stimpack,         0,   0,  334,  346}, -- Use Stim Packs
	},
	[247] = { -- (버튼셋 247, 244 와 같은 내용)
		{1, 228, BSReq.CanMove,            BSAct.Move,             0,   0,  664,    0}, -- 이동 (M)
		{2, 229, BSReq.CanMoveSpecialCase, BSAct.Stop,             0,   0,  665,    0}, -- 정지 (S)
		{3, 230, BSReq.CanAttack,          BSAct.AttackMove,       0,   0,  666,    0}, -- 공격 (A)
		{4, 254, BSReq.CanMove,            BSAct.Patrol,           0,   0,  667,    0}, -- 순찰 (P)
		{5, 255, BSReq.CanMove,            BSAct.HoldPosition,     0,   0,  668,    0}, -- 위치 사수 (H)
		{7, 237, BSReq.HasTech,            BSAct.Stimpack,         0,   0,  334,  346}, -- Use Stim Packs
	},
}
