-- ObserverChatAlways.lua
-- ObserverChat.lua(v1.0 by Ninfia) 의 ObserverChatToAll 개조판.
--
-- 원본 ObserverChatToAll : 지정한 키를 눌러야 "전체 채팅" 모드가 켜지고, Timer 로 넘긴 EUD 변수에
--   모드 비트(0x70000000)와 딜레이 카운터(0xFF0000)를 들고 있는 상태머신이라 트리거가 3개 필요했다.
--   (모드 켜기 / 채팅 대상 강제 / 딜레이 감소)
-- 이 파일 ObserverChatToAllAlways : "관전자면 무조건 전체 채팅" 이라 상태 자체가 없다.
--   키 조건도, Timer 변수도, 딜레이도 필요 없어서 원본의 2번 트리거 하나만 남는다.
--
-- 쓰이는 주소 (원본 그대로)
--   0x512684 : 로컬 플레이어 ID. 128~131 = 관전자 슬롯 Ob1~Ob4.
--              ★ 로컬 값이라 이 조건이 붙은 트리거는 관전자 화면에서만 참이 된다.
--   0x68C144 : 채팅 입력 대상. 0 = 채팅창을 안 연 상태, 1 이상 = 다른 대상(아군 등)으로 잡힌 상태.
--              여기에 2 를 써넣으면 전체 채팅이 된다.

---@param PlayerID   트리거 소유 플레이어 (theSeed 는 FP=P8. 다른 시스템과 소유자를 맞출 것)
---@param TargetPlayer? nil = 관전자 전체(Ob1~Ob4) / "Ob1"~"Ob4" 또는 128~131 = 그 슬롯만
---@param Condition? 추가 조건 (없으면 생략)
---@param Action?    추가 액션 (없으면 생략)
function ObserverChatToAllAlways(PlayerID,TargetPlayer,Condition,Action)
	if PlayerID == nil then
		PushErrorMsg("ObserverChatToAllAlways: PlayerID(트리거 소유 플레이어)가 nil 입니다")
	end

	-- 원본의 LocalPlayerID 와 같은 조건이지만, 전역을 덮어쓰지 않도록 local 로 둔다
	-- (ObserverChat.lua 가 전역 함수를 재정의하다 PushErrorMsg 를 날려먹은 전례가 있음).
	local function ObLocalCond(Player)
		if Player == nil then
			return {Memory(0x512684,AtLeast,128),Memory(0x512684,AtMost,131)}
		end
		local ObSlot = {Ob1 = 128, Ob2 = 129, Ob3 = 130, Ob4 = 131}
		return Memory(0x512684,Exactly,ObSlot[Player] or Player)
	end

	-- nil 을 그대로 넣으면 조건/액션 배열 가운데 구멍이 나므로 빈 테이블로 바꿔둔다.
	Condition = Condition or {}
	Action = Action or {}

	Trigger {
		players = {PlayerID},
		conditions = {
			ObLocalCond(TargetPlayer);
			Memory(0x68C144,AtLeast,1);
			Condition;
		},
		actions = {
			SetMemory(0x68C144,SetTo,2);
			Action;
			PreserveTrigger();
		},
	}
end
