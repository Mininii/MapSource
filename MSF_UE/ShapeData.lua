function Install_ShapeData()
    function MakeLevelShape(Type,Points,LvMin,LvMax)
        local X = {}
        for i = LvMin, LvMax do
             if Type == "Polygon" then
                  table.insert(X,CSMakePolygon(Points,((16*9)-(16*i))+24,0,PlotSizeCalc(Points,i),0))
                  
             elseif Type == "Star" then
                  table.insert(X,CSMakeStar(Points,165-(12*(Points-2)),(36*6)-(36*i),180,PlotSizeCalc(Points*2,i),0))
             end
        end
        return X
    end
    S_3_ShT = Create_SortTable(MakeLevelShape("Star",3,1,4))
    S_4_ShT = Create_SortTable(MakeLevelShape("Star",4,1,4))
    S_5_ShT = Create_SortTable(MakeLevelShape("Star",5,1,4))
    S_6_ShT = Create_SortTable(MakeLevelShape("Star",6,1,4))
    S_7_ShT = Create_SortTable(MakeLevelShape("Star",7,1,4))
    S_8_ShT = Create_SortTable(MakeLevelShape("Star",8,1,4))
    P_3_ShT = Create_SortTable(MakeLevelShape("Polygon",3,1,8))
    P_4_ShT = Create_SortTable(MakeLevelShape("Polygon",4,1,8))
    P_5_ShT = Create_SortTable(MakeLevelShape("Polygon",5,1,8))
    P_6_ShT = Create_SortTable(MakeLevelShape("Polygon",6,1,8))
    P_7_ShT = Create_SortTable(MakeLevelShape("Polygon",7,1,8))
    P_8_ShT = Create_SortTable(MakeLevelShape("Polygon",8,1,8))
    
    
    NexBYDLine = {}
    NexBYDLine2 = {}
    NexBYDLine3 = {}
    NexBYDLine4 = {}
    for i=0, 12 do
       table.insert(NexBYDLine,CSMakeLine(1+(6*i),64+(64*i),0,2+(6*i),1))
    end
    for i = 1, 6 do
    table.insert(NexBYDLine2,CS_Merge(NexBYDLine[i*2],NexBYDLine[(i*2)+1],32,0))
    end
    table.insert(NexBYDLine3,CS_Merge(NexBYDLine2[1],NexBYDLine2[2],0,0))
    table.insert(NexBYDLine3,CS_Merge(NexBYDLine2[3],NexBYDLine2[4],0,0))
    table.insert(NexBYDLine3,CS_Merge(NexBYDLine2[5],NexBYDLine2[6],0,0))
    table.insert(NexBYDLine4,CS_Merge(NexBYDLine3[1],NexBYDLine3[2],0,0))
    table.insert(NexBYDLine4,CS_Merge(NexBYDLine3[3],NexBYDLine[1],0,0))
    NexBYDShape = CS_Merge(NexBYDLine4[1],NexBYDLine4[2],32,0)
    
end