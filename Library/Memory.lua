-- Memory Read�� ���Ǵ� �Լ��� �Դϴ�. (PPS ����)
-- �ݵ�� �̸� 0���� �ʱ�ȭ�� �Ǿ� �־�� �մϴ�.

function dwreadX(Player, Cond, SourceAddr, DestAddr) -- Player�� Ʈ���ŷ� ���������, Source�� ���� Dest�� �����մϴ�.
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
function dwreadX_cp(Player, Cond, DestAddr) -- Player�� Ʈ���ŷ� ���������, Source�� ���� Dest�� �����մϴ�.
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
function breadX(Player, Cond, SourceAddr, DestAddr) -- Player�� Ʈ���ŷ� ���������, Source�� ���� 1����Ʈ ������ �о Dest�� �����մϴ�.
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
function breadX_cp(Player, Cond, DestAddr, n) -- Player�� Ʈ���ŷ� ���������, CurrentPlayer�� ����Ű�� �ּ��� (n+1)��° ����Ʈ�� ���� 1����Ʈ ������ �о Dest�� �����մϴ�.
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
function EPDX(Player, Cond, SourceAddr, DestAddr) -- Player�� Ʈ���ŷ� ���������, Source�� ���� EPD�� ��ȯ�ؼ� Dest�� �����մϴ�.
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

for i = 24, 2, -1 do -- 4�� ������ �ڵ�
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
function STrigger(Player, Cond, Act) -- PreserveTrigger �� ����˴ϴ�.
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