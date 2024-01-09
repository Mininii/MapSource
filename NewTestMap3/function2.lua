
function CreateVarArr2(Number,Value,PlayerID)
	local ret = {}
	local LValue = {}
	if type(Value)=="number" then
		for i = 1, Number do
			LValue[i] = Value
		end
	elseif type(Value)=="table" then
		LValue = Value
	else
		PushErrorMsg("CreateVariable_Value_InputError")
	end
	for i = 1, Number do
		CreateVarXAlloc = CreateVarXAlloc + 1
		if CreateVarXAlloc > CreateMaxVAlloc then
			PushErrorMsg("CreateVariable_IndexAllocation_Overflow")
		end
		if PlayerID == nil then
			PlayerID = AllPlayers
		end
		table.insert(CreateVarPArr,{"V2",PlayerID,nil,SetTo,LValue[i],nil})
		table.insert(ret,V(CreateVarXAlloc))
	end
	if type(PlayerID) == "number" then
		for k, v in pairs(ret) do
			v[1] = PlayerID
		end
	end
	return ret
end


function CreateWarArr2(Number,Value,PlayerID)
	local ret = {}
	local LValue = {}
	if type(Value)=="number" then
		for i = 1, Number do
			LValue[i] = Value
		end
	elseif type(Value)=="string" then
		for i = 1, Number do
			LValue[i] = Value
		end
	elseif type(Value)=="table" then
		LValue = Value
	else
		PushErrorMsg("CreateVariable_Value_InputError")
	end
	for i = 1, Number do
		CreateVarXAlloc = CreateVarXAlloc + 1
		if CreateVarXAlloc > CreateMaxVAlloc then
			PushErrorMsg("CreateVariable_IndexAllocation_Overflow")
		end
		if PlayerID == nil then
			PlayerID = AllPlayers
		end
		table.insert(CreateVarPArr,{"W2",PlayerID,nil,SetTo,LValue[i],nil})
		table.insert(ret,W(CreateVarXAlloc))
	end
	if type(PlayerID) == "number" then
		for k, v in pairs(ret) do
			v[1] = PlayerID
		end
	end
	return ret
end