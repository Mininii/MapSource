function LeaderBoard()
	
local LeaderBoardT = CreateCcode()
Trigger { -- DPS 리더보드
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,0,LeaderBoardT);
	},
	actions = {
		
		LeaderBoardGreed(10000000);
		LeaderBoardComputerPlayers(Disable);
		SetCDeaths(FP,SetTo,1000,LeaderBoardT);
		PreserveTrigger();
},
}
Trigger { -- 레벨
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,500,LeaderBoardT);
	},
	actions = {
		LeaderBoardScore(Custom, StrDesign("\17Level").." "..VerText);
		LeaderBoardComputerPlayers(Disable);
		PreserveTrigger();
},
}
DoActionsX(FP,{SetCDeaths(FP,Subtract,1,LeaderBoardT)})

end