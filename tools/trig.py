"""Classic StarCraft TRIG/MBRF parsing helpers."""
import struct

COND_NAMES = {0:"NoCondition",1:"CountdownTimer",2:"Command",3:"Bring",4:"Accumulate",
 5:"Kills",6:"CommandTheMost",7:"CommandsTheMostAt",8:"MostKills",9:"HighestScore",
 10:"MostResources",11:"Switch",12:"ElapsedTime",13:"IsBriefing",14:"Opponents",
 15:"Deaths",16:"CommandLeast",17:"CommandLeastAt",18:"LeastKills",19:"LowestScore",
 20:"LeastResources",21:"Score",22:"Always",23:"Never"}
ACT_NAMES = {0:"NoAction",1:"Victory",2:"Defeat",3:"PreserveTrigger",4:"Wait",5:"PauseGame",
 6:"UnpauseGame",7:"Transmission",8:"PlayWAV",9:"DisplayText",10:"CenterView",
 11:"CreateUnitWithProperties",12:"SetMissionObjectives",13:"SetSwitch",
 14:"SetCountdownTimer",15:"RunAIScript",16:"RunAIScriptAt",17:"LeaderBoardControl",
 18:"LeaderBoardControlAt",19:"LeaderBoardResources",20:"LeaderBoardKills",
 21:"LeaderBoardPoints",22:"KillUnit",23:"KillUnitAt",24:"RemoveUnit",25:"RemoveUnitAt",
 26:"SetResources",27:"SetScore",28:"MinimapPing",29:"TalkingPortrait",30:"MuteUnitSpeech",
 31:"UnmuteUnitSpeech",32:"LeaderboardComputerPlayers",33:"LeaderboardGoalControl",
 34:"LeaderboardGoalControlAt",35:"LeaderboardGoalResources",36:"LeaderboardGoalKills",
 37:"LeaderboardGoalPoints",38:"MoveLocation",39:"MoveUnit",40:"LeaderboardGreed",
 41:"SetNextScenario",42:"SetDoodadState",43:"SetInvincibility",44:"CreateUnit",
 45:"SetDeaths",46:"Order",47:"Comment",48:"GiveUnitsToPlayer",49:"ModifyUnitHitPoints",
 50:"ModifyUnitEnergy",51:"ModifyUnitShields",52:"ModifyUnitResourceAmount",
 53:"ModifyUnitHangarCount",54:"PauseTimer",55:"UnpauseTimer",56:"Draw",
 57:"SetAllianceStatus",58:"DisableDebugMode",59:"EnableDebugMode"}

class Cond:
    __slots__=("loc","player","qty","unit","cmp","ctype","flags10","flags11","mask")
    def __init__(s, b, o):
        (s.loc, s.player, s.qty, s.unit, s.cmp, s.ctype, s.flags10, s.flags11, s.mask) = \
            struct.unpack_from("<IIIHBBBBH", b, o)
    def pack(s):
        return struct.pack("<IIIHBBBBH", s.loc, s.player, s.qty, s.unit, s.cmp, s.ctype,
                           s.flags10, s.flags11, s.mask)

class Act:
    __slots__=("loc","strid","wav","time","p1","p2","unit","atype","n","flags","pad","mask")
    def __init__(s, b, o):
        (s.loc, s.strid, s.wav, s.time, s.p1, s.p2, s.unit, s.atype, s.n, s.flags,
         s.pad, s.mask) = struct.unpack_from("<IIIIIIHBBBBH", b, o)
    def pack(s):
        return struct.pack("<IIIIIIHBBBBH", s.loc, s.strid, s.wav, s.time, s.p1, s.p2,
                           s.unit, s.atype, s.n, s.flags, s.pad, s.mask)

class Trigger:
    SIZE = 2400
    def __init__(s, b, o=0):
        s.conds = [Cond(b, o+i*20) for i in range(16)]
        s.acts  = [Act(b, o+320+i*32) for i in range(64)]
        s.exec_flags, = struct.unpack_from("<I", b, o+2368)
        s.players = list(b[o+2372:o+2372+27])
        s.cur_act = b[o+2399]
    def pack(s):
        out = b"".join(c.pack() for c in s.conds) + b"".join(a.pack() for a in s.acts)
        out += struct.pack("<I", s.exec_flags) + bytes(s.players) + bytes([s.cur_act])
        assert len(out)==2400, len(out)
        return out
    def active_conds(s): return [c for c in s.conds if c.ctype]
    def active_acts(s):  return [a for a in s.acts if a.atype]

def parse_triggers(data):
    return [Trigger(data, i*2400) for i in range(len(data)//2400)]
