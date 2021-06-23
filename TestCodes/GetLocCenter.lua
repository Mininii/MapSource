function ConvertLocation(Location) -- 로케이션 인덱스 변환함수. TempLocID는 0부터 시작, Location은 1부터 시작하는 인덱스를 반환함. 문자열 입력 가능
	local TempLocID = Location
	if type(Location) == "string" then
		TempLocID = ParseLocation(Location)-1
	elseif Type(Location) == "number" then
		TempLocID = Location
		Location = Location+1
	end
	return TempLocID, Location
end
function Install_GetCLoc(TriggerPlayer,TempLoc,TempUnit) -- TempLoc = 안쓰거나 자주 바뀌는 로케이션, TempUnit = 안쓰는 유닛. Unused 가능 아마?
	local TempLocID, TempLoc = ConvertLocation(TempLoc)
	local PlayerID = TriggerPlayer
	local RetX = CreateVar()
	local RetY = CreateVar()
	local Call_GetCLoc = SetCallForward()
	SetCall(PlayerID)
	f_Read(PlayerID,0x58DC60+0x14*TempLocID,RetX,"X",0xFFFFFFFF)
	f_Read(PlayerID,0x58DC64+0x14*TempLocID,RetY,"X",0xFFFFFFFF)
	SetCallEnd()
 
	function GetLocCenter(Location,DestX,DestY)
		
		local Location2, Location = ConvertLocation(Location)

		CallTrigger(PlayerID,Call_GetCLoc,{Simple_SetLoc(TempLocID,0,0,0,0),MoveLocation(TempLoc, TempUnit, PlayerID, Location)})
		CMov(PlayerID,DestX,RetX)
		CMov(PlayerID,DestY,RetY)
	end
	function SetLocCenter(Location,DestLocation)
		local Location2, Location = ConvertLocation(Location)
		CallTrigger(PlayerID,Call_GetCLoc,{Simple_SetLoc(TempLocID,0,0,0,0),MoveLocation(TempLoc, TempUnit, PlayerID, Location)})
		
		local DestLocId, DestLocation = ConvertLocation(DestLocation)

		Simple_SetLocX(PlayerID,DestLocId,RetX,RetY,RetX,RetY)
	end
	function SetLocCenter2(Location) -- TempLoc를 Location으로 이동시키기만 함. Call이 필요없음. TempLoc만 사용해도 될 경우 이걸 써도 됨
	
		local Location2, Location = ConvertLocation(Location)
		DoActions(PlayerID,{Simple_SetLoc(TempLocID,0,0,0,0),MoveLocation(TempLoc, TempUnit, PlayerID, Location)})
	end
end