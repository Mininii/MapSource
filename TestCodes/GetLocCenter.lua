
function Install_GetCLoc(TriggerPlayer,TempLoc,TempUnit) -- TempLoc = �Ⱦ��ų� ���� �ٲ�� �����̼�, TempUnit = �Ⱦ��� ����. Unused ���� �Ƹ�?
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
    function SetLocCenter2(Location) -- TempLoc�� Location���� �̵���Ű�⸸ ��. Call�� �ʿ����. TempLoc�� ����ص� �� ��� �̰� �ᵵ ��
        DoActions(PlayerID,{Simple_SetLoc(TempLocID,0,0,0,0),MoveLocation(TempLoc, TempUnit, PlayerID, Location)})
    end
end
