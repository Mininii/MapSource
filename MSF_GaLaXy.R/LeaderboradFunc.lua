function LeaderBoardF()
    
DifLeaderBoard = {
	"\x04 - \x0EEASY \x04Mode",
	"\x04 - \x08HARD \x04Mode",
	"\x04 - \x11BURST \x04Mode"}


	local LeaderBoardT = CreateCcode()
    CIf(FP,{Switch("Switch 201",Set)})
	for i = 1, 3 do
	Trigger { -- 킬 포인트 리더보드, 집근처 유닛 오더시키기, 쉴드 회복, 저글링 히드라 어택땅
	players = {FP},
	conditions = {
		Label(0);
		CD(GMode,i),
		CDeaths(FP,AtMost,0,LeaderBoardT);
	},
	actions = {
		LeaderBoardScore(Kills, "\x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x11Points"..DifLeaderBoard[i]);
		LeaderBoardComputerPlayers(Disable);
		SetCDeaths(FP,SetTo,600,LeaderBoardT);
		ModifyUnitShields(All,"Men",Force2,"Anywhere",100);
		PreserveTrigger();
	},
}
Trigger { -- 데스 스코어 리더보드
	players = {FP},
	conditions = {
		Label(0);
		CD(GMode,i),
		CDeaths(FP,Exactly,400,LeaderBoardT);
	},
	actions = {
		LeaderBoardScore(Custom, "\x08Deaths..."..DifLeaderBoard[i]);
		LeaderBoardComputerPlayers(Disable);
		PreserveTrigger();
},
}
Trigger { -- 킬 스코어 리더보드
	players = {FP},
	conditions = {
		Label(0);
		CD(GMode,i),
		CDeaths(FP,Exactly,200,LeaderBoardT);
	},
	actions = {
		LeaderBoardKills("Any unit","\x06Kill \x0FCounts"..DifLeaderBoard[i]);
		LeaderBoardComputerPlayers(Disable);
		Order("Men",FP,21,Attack,4);
		Order(37,FP,64,Attack,4);
		Order(38,FP,64,Attack,4);
		Order(39,FP,64,Attack,4);
		Order(43,FP,64,Attack,4);
		Order(44,FP,64,Attack,4);
		Order(47,FP,64,Attack,4);
		Order(48,FP,64,Attack,4);
		Order(50,FP,64,Attack,4);
		Order(51,FP,64,Attack,4);
		Order(53,FP,64,Attack,4);
		Order(54,FP,64,Attack,4);
		Order(55,FP,64,Attack,4);
		Order(56,FP,64,Attack,4);
		PreserveTrigger();
},
}
end
CIfEnd(SetCDeaths(FP,Subtract,1,LeaderBoardT))


end