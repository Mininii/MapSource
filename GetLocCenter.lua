
function Install_GetCLoc(TriggerPlayer) -- 점프단락에 설치
    local PlayerID = TriggerPlayer
    local LocIDV = CreateVar()
    local RetL = CreateVar()
    local RetR = CreateVar()
    local RetU = CreateVar()
    local RetD = CreateVar()
    
    local RetX = CreateVar()
    local RetY = CreateVar()

    local LocL = CreateVar()
    local LocU = CreateVar()
    local LocR = CreateVar()
    local LocD = CreateVar()

    local Call_GetCLoc = SetCallForward()
    SetCall(PlayerID)

    CMov(PlayerID,LocL,_Mul(LocIDV,_Mov(0x14/4)),EPD(0x58DC60))
    CMov(PlayerID,LocU,_Mul(LocIDV,_Mov(0x14/4)),EPD(0x58DC64))
    CMov(PlayerID,LocR,_Mul(LocIDV,_Mov(0x14/4)),EPD(0x58DC68))
    CMov(PlayerID,LocD,_Mul(LocIDV,_Mov(0x14/4)),EPD(0x58DC6C))
    f_Read(PlayerID,LocL,RetL,"X",0xFFFFFFFF,1)
    f_Read(PlayerID,LocU,RetU,"X",0xFFFFFFFF,1)
    f_Read(PlayerID,LocR,RetR,"X",0xFFFFFFFF,1)
    f_Read(PlayerID,LocD,RetD,"X",0xFFFFFFFF,1)
    CiSub(PlayerID,RetX,RetR,RetL)
    f_iDiv(PlayerID,RetX,_Mov(2))
    CAdd(PlayerID,RetX,RetL)
    CiSub(PlayerID,RetY,RetD,RetU)
    f_iDiv(PlayerID,RetY,_Mov(2))
    CAdd(PlayerID,RetY,RetU)
    SetCallEnd()

    function GetLocCenter(Location,DestX,DestY)
        local LocId = Location
        if type(LocId) == "string" then
            LocId = ParseLocation(LocId)-1
        end
        CMov(PlayerID,LocIDV,LocId)
        CallTrigger(PlayerID,Call_GetCLoc)
        CMov(PlayerID,DestX,RetX)
        CMov(PlayerID,DestY,RetY)
    end
    function SetLocCenter(Location,DestLocation)
        local LocId = Location
        if type(LocId) == "string" then
            LocId = ParseLocation(LocId)-1
        end
        CMov(PlayerID,LocIDV,LocId)
        CallTrigger(PlayerID,Call_GetCLoc)
        
        local DestLocId = DestLocation
        if type(DestLocId) == "string" then
            DestLocId = ParseLocation(DestLocId)-1
        end
        CMov(PlayerID,0x58DC60+0x14*DestLocId,RetX)
        CMov(PlayerID,0x58DC64+0x14*DestLocId,RetY)
        CMov(PlayerID,0x58DC68+0x14*DestLocId,RetX)
        CMov(PlayerID,0x58DC6C+0x14*DestLocId,RetY)
    end
end