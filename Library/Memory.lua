-- Memory Read에 사용되는 함수들 입니다. (PPS 제작)
-- 반드시 미리 0으로 초기화가 되어 있어야 합니다.

function dwreadX(Player, Cond, SourceAddr, DestAddr) -- Player의 트리거로 만들어지며, Source의 값을 Dest에 대입합니다.
for i = 31, 0, -1 do
        Trigger {
				players = {ParsePlayer(Player)},
                conditions = {
					Cond,
					MemoryX(SourceAddr, Exactly, 2^i, 2^i);
					},
                actions = 
				{
					SetMemory(DestAddr, Add, 2^i);
					PreserveTrigger();
				}
        }
end
end
function dwreadX_cp(Player, Cond, DestAddr) -- Player의 트리거로 만들어지며, Source의 값을 Dest에 대입합니다.
for i = 31, 0, -1 do
        Trigger {
				players = {ParsePlayer(Player)},
                conditions = {
					Cond,
					DeathsX(CurrentPlayer, Exactly, 2^i, 0, 2^i);
					},
                actions = 
				{
					SetMemory(DestAddr, Add, 2^i);
					PreserveTrigger();
				}
        }
end
end
function breadX(Player, Cond, SourceAddr, DestAddr) -- Player의 트리거로 만들어지며, Source의 값을 1바이트 단위로 읽어서 Dest에 대입합니다.
for i = 7, 0, -1 do
        Trigger {
				players = {ParsePlayer(Player)},
                conditions = {
					Cond,
					MemoryX(SourceAddr, Exactly, 2^(i+8*(SourceAddr%4)), 2^(i+8*(SourceAddr%4)));
					},
                actions =
				{
					SetMemory(DestAddr, Add, 2^i);
					PreserveTrigger();
				}
        }
end
end
function breadX_cp(Player, Cond, DestAddr, n) -- Player의 트리거로 만들어지며, CurrentPlayer가 가리키는 주소의 (n+1)번째 바이트의 값을 1바이트 단위로 읽어서 Dest에 대입합니다.
for i = 7, 0, -1 do
        Trigger {
				players = {ParsePlayer(Player)},
                conditions = {
					Cond,
					DeathsX(CurrentPlayer, Exactly, 2^(i+8*(n%4)), 0,2^(i+8*(n%4)));
					},
                actions =
				{
					SetMemory(DestAddr, Add, 2^i);
					PreserveTrigger();
				}
        }
end
end
function EPDX(Player, Cond, SourceAddr, DestAddr) -- Player의 트리거로 만들어지며, Source의 값을 EPD로 변환해서 Dest에 대입합니다.
        Trigger {
				players = {ParsePlayer(Player)},
                conditions = {
					Cond,
					Always();
					},
                actions = 
				{
					SetMemory(DestAddr, SetTo, -0x58A364 / 4);
					PreserveTrigger();
				}
        }

for i = 24, 2, -1 do -- 4로 나누는 코드
        Trigger {
				players = {ParsePlayer(Player)},
                conditions = {
					Cond,
					MemoryX(SourceAddr, Exactly, 2^i, 2^i);
					},
                actions = 
				{
					SetMemory(DestAddr, Add, 2^(i-2));
					PreserveTrigger();
				}
        }
end
end
function STrigger(Player, Cond, Act) -- PreserveTrigger 가 적용됩니다.
	Trigger {
				players = {ParsePlayer(Player)},
                conditions = {
					Cond,
					Always();
					},
                actions = 
				{
					Act,
					PreserveTrigger();
				}
        }
end