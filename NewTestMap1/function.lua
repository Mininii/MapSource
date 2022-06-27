
function Install_BackupCP(Player)
	BackupCp = CreateVar(Player)
	SaveCp_CallIndex = SetCallForward()
	SetCall(Player)
		SaveCp(Player,BackupCp)
	SetCallEnd()

	LoadCp_CallIndex = SetCallForward()
	SetCall(Player)
		LoadCp(Player,BackupCp)
		SetRecoverCp()
	SetCallEnd()

	function f_SaveCp()
		CallTrigger(Player,SaveCp_CallIndex,nil)
	end
	function f_LoadCp()
		CallTrigger(Player,LoadCp_CallIndex,nil)
	end
end
function Install_UnitCount(Player)
	count,count1,count2,count3 = CreateVars(4,FP)
	function Cast_UnitCount()
		UnitReadX(Player,AllPlayers,229,64,count)
		UnitReadX(Player,AllPlayers,17,nil,count1)
		UnitReadX(Player,AllPlayers,23,nil,count2)
		UnitReadX(Player,AllPlayers,25,nil,count3)
		CAdd(Player,count,count1)
		CAdd(Player,count,count2)
		CAdd(Player,count,count3)
	end
end


function TriggerX(Player, Conditions, Actions, Flags, Index)
	if Index == nil then
		Index = 0
	end
	if type(Conditions[1])=="table" then
		for j,k in pairs(Conditions) do
			if type(k)=="string" then
				PushErrorMsg("DoActions2X Input Error")
			end
		end
	end
	if type(Actions[1])=="table" then
		for j,k in pairs(Actions) do
			if type(k)=="string" then
				PushErrorMsg("DoActions2X Input Error")
			end
		end
	end

	Trigger {
				players = {Player},
				conditions = {
					Label(Index);
					Conditions,
				},
				actions = {
					Actions,
				},
				flag = {
					Flags,
				}
			}
end


function DoActionsX(PlayerID,Actions,Flags,Index)
	if Index == nil then
		Index = 0
	end
	if Flags == nil then
		Flags = {Preserved}
	elseif Flags == 1 then
		Flags = {}
	end
	if type(Actions[1])=="table" then
		for j,k in pairs(Actions) do
			if type(k)=="string" then
				PushErrorMsg("DoActions2X Input Error")
			end
		end
	end
	Trigger {
		players = {PlayerID},
		conditions = {
			Label(Index);
		},
		actions = {
			Actions,
		},
		flag = {
			Flags,
		},
	}
end

function DoActions2X(PlayerID,Actions,Flags)
	if type(Actions[1])=="table" then
		for j,k in pairs(Actions) do
			if type(k)=="string" then
				PushErrorMsg("DoActions2X Input Error")
			end
		end
	end
	local k = 1
	local Size = #Actions

	if Flags == nil then
		Flags = {Preserved}
	elseif Flags == 1 then
		Flags = {}
	end

	local Act = {}
	for i = 1, Size do
		if type(Actions[i][1]) == "table" and #Actions[i][1] == 10 then
			for j = 1, #Actions[i] do
				table.insert(Act,Actions[i][j])
			end
		else
			table.insert(Act,Actions[i])
		end
	end
	Size = #Act

	while k <= Size do
		if Size - k + 1 >= 64 then
			local X = {}
			for i = 0, 63 do
				table.insert(X, Act[k])
				k = k + 1
			end
			Trigger {
					players = {PlayerID},
					conditions = {
						Label(0);
					},
					actions = {
						X,
					},
					flag = {
						Flags,
					},
				}
		else
			local X = {}
			repeat
				table.insert(X, Act[k])
				k = k + 1
			until k == Size + 1
			Trigger {
					players = {PlayerID},
					conditions = {
						Label(0);
					},
					actions = {
						X,
					},
					flag = {
						Flags,
					},
				}
		end
	end
end



function LocalPlayerID(Player,Type)
	if Type == nil then
		Type = Exactly
	end
	if Player == nil then
		return {Memory(0x512684,AtLeast,0),Memory(0x512684,AtMost,7)}
	else
		if Player == "Ob1" then
			Player = 128
		elseif Player == "Ob2" then
			Player = 129
		elseif Player == "Ob3" then
			Player = 130
		elseif Player == "Ob4" then
			Player = 131
		end
		return Memory(0x512684,Type,Player)
	end
end