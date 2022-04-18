-- Artanis님의 noAirCollision.lua에 PlayerId 넣은 버젼

function NoAirCollision(PlayerID)
Trigger {
    players = {PlayerID},
    actions = {
        SetMemory(0x58D900, SetTo, 0);
        SetMemory(0x6509B0, SetTo, 0);
        PreserveTrigger();
        Comment("NoAirCollision");
    },
}
for i = 28, 2, -1 do
Trigger {
    players = {PlayerID},
    conditions = {
        Memory(0x6D5CD8, AtLeast, 2^i + 0x58A364);
    },
    actions = {
        SetMemory(0x6D5CD8, Subtract, 2^i);
        SetMemory(0x58D900, Add, 2^i);
        SetMemory(0x6509B0, Add, 2^(i-2));
        PreserveTrigger();
        Comment("NoAirCollision");
    },
}
end
for i = 28, 2, -1 do
Trigger {
    players = {PlayerID},
    conditions = {
        Memory(0x58D900, AtLeast, 2^i);
    },
    actions = {
        SetMemory(0x58D900, Subtract, 2^i);
        SetMemory(0x6D5CD8, Add, 2^i);
        PreserveTrigger();
        Comment("NoAirCollision");
    },
}
end

t = {}
for i = 1, 610 do
table.insert(t, SetDeaths(CurrentPlayer,SetTo, 0, i - 1))
end

for k = 1, 2 do
table.insert(t, SetMemory(0x6509B0, Add, 1))
for i = 1, 610 do
table.insert(t, SetDeaths(CurrentPlayer,SetTo, 0, i - 1))
end
end

for k = 1, 9 do
table.insert(t, SetMemory(0x6509B0, Add, 1))
for i = 1, 609 do
table.insert(t, SetDeaths(CurrentPlayer,SetTo, 0, i - 1))
end
end
table.insert(t, SetMemory(0x6509B0, SetTo, PlayerID))
table.insert(t, Comment("NoAirCollision"))

for n = 1, math.ceil(#t / 63) do
k = {}
for i = 63 * (n - 1) + 1, math.min(63 * n, #t) do
table.insert(k, t[i])
end
Trigger {
    players = {PlayerID},
    actions = {
        k,
        PreserveTrigger();
    }
}
end
end
