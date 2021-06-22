
function Install_GetCLoc(TriggerPlayer,TempLoc,TempUnit) -- TempLoc = 안쓰거나 자주 바뀌는 로케이션, TempUnit = 안쓰는 유닛. Unused 가능 아마?
    local TempLocID = TempLoc
    if type(TempLoc) == "string" then
        TempLocID = ParseLocation(TempLoc)-1
    end
    
    local PlayerID = TriggerPlayer
    local RetX = CreateVar()
    local RetY = CreateVar()
    local Call_GetCLoc = SetCallForward()
    SetCall(PlayerID)
    f_Read(PlayerID,0x58DC60+0x14*TempLocID,RetX,"X",0xFFFFFFFF,1)
    f_Read(PlayerID,0x58DC64+0x14*TempLocID,RetY,"X",0xFFFFFFFF,1)
    SetCallEnd()

    function GetLocCenter(Location,DestX,DestY)
        CallTrigger(PlayerID,Call_GetCLoc,{Simple_SetLoc(TempLocID,0,0,0,0),MoveLocation(TempLoc, TempUnit, PlayerID, Location)})
        CMov(PlayerID,DestX,RetX)
        CMov(PlayerID,DestY,RetY)
    end
    function SetLocCenter(Location,DestLocation)
        CallTrigger(PlayerID,Call_GetCLoc,{Simple_SetLoc(TempLocID,0,0,0,0),MoveLocation(TempLoc, TempUnit, PlayerID, Location)})
        
        local DestLocId = DestLocation
        if type(DestLocId) == "string" then
            DestLocId = ParseLocation(DestLocId)-1
        end
        Simple_SetLocX(PlayerID,DestLocId,RetX,RetY,RetX,RetY)
    end
    function SetLocCenter2(Location) -- TempLoc를 Location으로 이동시키기만 함. Call이 필요없음. TempLoc만 사용해도 될 경우 이걸 써도 됨
        DoActions(PlayerID,{Simple_SetLoc(TempLocID,0,0,0,0),MoveLocation(TempLoc, TempUnit, PlayerID, Location)})
    end
end
