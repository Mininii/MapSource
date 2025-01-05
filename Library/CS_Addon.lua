function CS_Slice(Path,Limit,SampleSize)
	LArr = {}
	for i = 2, Path[1] do
		table.insert(LArr,math.sqrt((Path[i][1]-Path[i+1][1])^2+(Path[i][2]-Path[i+1][2])^2))
	end
	
	Ret = {{0}}
	Curptr = 1
	LSum = 0
	LCnt = 0
	for i = 1, SampleSize do
		LSum = LSum + LArr[i]
		LCnt = LCnt + 1
	end
	
	for i = 1, Path[1]-1 do
		if i > 1 and i+SampleSize-1 < Path[1] then
			LSum = LSum + LArr[i+SampleSize-1]
			LCnt = LCnt + 1
		end
		
		if i > SampleSize+1 then
			LSum = LSum - LArr[i-SampleSize-1]
			LCnt = LCnt - 1
		end
		
		Lavg = LSum / LCnt
		
		table.insert(Ret[Curptr],{Path[i+1][1],Path[i+1][2]})
		Ret[Curptr][1] = Ret[Curptr][1] + 1
		
		if LArr[i] > Lavg*Limit then
			Curptr = Curptr + 1
			table.insert(Ret,{0})
		end
	end
	table.insert(Ret[Curptr],{Path[Path[1]+1][1],Path[Path[1]+1][2]})
	Ret[Curptr][1] = Ret[Curptr][1] + 1

	return Ret
end

function CS_PathInPath(Path,Number,funcN,PerSegment,Clamp,Closed)
	if not (Closed == 0 or Closed == nil) then
		table.insert(Path,{Path[2][1],Path[2][2]})
		Path[1] = Path[1] + 1
	end
	
	Llist = {}
	for i = 1, Number do
		if funcN == nil then
			table.insert(Llist,(1.0*(i-1))/Number)
		else
			tmp = _G[funcN](i,Number,Path[1])
			if tmp > 1.0 or tmp < 0.0 then
				if not (Clamp == 0 or Clamp == nil) then
					tmp = tmp%1.0
					table.insert(Llist,tmp)
				end
			else
				table.insert(Llist,tmp)
			end
		end
	end
	
	Ret = {0}
	if PerSegment == 0 or PerSegment == nil then
		LArr = {}
		LStack = {0}
		for i = 1, Path[1]-1 do
			table.insert(LArr,math.sqrt((Path[i+1][1]-Path[i+2][1])^2+(Path[i+1][2]-Path[i+2][2])^2))
			table.insert(LStack,LArr[i]+LStack[i])
		end
		LTotal = LStack[#LStack]
		LRatio = {}
		for i = 1, #LStack do
			table.insert(LRatio,LStack[i]/LTotal)
		end
		
		for k, v in pairs(Llist) do
			s = 0
			for i = 1, #LRatio do
				s = i
				if v <= LRatio[i+1] then
					goto CS_PathInPathSkip1
				end
			end
			v = 1.0
			s = #LRatio-1
			::CS_PathInPathSkip1::
			v = (v - LRatio[s])/(LRatio[s+1]-LRatio[s]) 
			
			X1 = Path[s+1][1]
			Y1 = Path[s+1][2]
			X2 = Path[s+2][1]
			Y2 = Path[s+2][2]
			
			PX = (1-v)*X1 + v*X2
			PY = (1-v)*Y1 + v*Y2
			
			table.insert(Ret,{PX,PY})
			Ret[1] = Ret[1] + 1
		end
	else
		for i = 1, Path[1]-1 do
			X1 = Path[i+1][1]
			Y1 = Path[i+1][2]
			X2 = Path[i+2][1]
			Y2 = Path[i+2][2]
			for k, v in pairs(Llist) do
				PX = (1-v)*X1 + v*X2
				PY = (1-v)*Y1 + v*Y2
				table.insert(Ret,{PX,PY})
				Ret[1] = Ret[1] + 1
			end
		end
	end
	
	if not (Closed == 0 or Closed == nil) then
		table.remove(Path,#Path)
		Path[1] = Path[1] - 1
	end
	
	return Ret
end

function CS_PathInPathX(Path,Number,funcN,funcT,AreaT,StepNumber,Loop,PerSegment,Clamp,Closed)
	Tmin = AreaT[1]
	Tmax = AreaT[2]
	TStep = (1.0*(Tmax-Tmin))/StepNumber
	TCur = Tmin
	TPrev = Tmin
	TX1, TY1 = _G[funcT](Tmin)
	TArr = {}
	TStack = {{0,(TX1^2+TY1^2)}}
	for i = 1, StepNumber do
		TCur = TCur + TStep
		TX2, TY2 = _G[funcT](TCur)
		table.insert(TArr,{TPrev,math.sqrt((TX2-TX1)^2+(TY2-TY1)^2)})
		table.insert(TStack,{TPrev,TArr[i][2]+TStack[i][2]})
		TPrev = TCur
		TX1 = TX2
		TY1 = TY2
	end
	TTotal = TStack[#TStack][2]
	TRatio = {}
	for i = 1, #TStack do
		table.insert(TRatio,{TStack[i][1],TStack[i][2]/TTotal})
	end
	

	if not (Closed == 0 or Closed == nil) then
		table.insert(Path,{Path[2][1],Path[2][2]})
		Path[1] = Path[1] + 1
	end
	
	Llist = {}
	for i = 1, Number do
		if funcN == nil then
			table.insert(Llist,(1.0*(i-1))/Number)
		else
			tmp = _G[funcN](i,Number,Path[1])
			if tmp > 1.0 or tmp < 0.0 then
				if not (Clamp == 0 or Clamp == nil) then
					tmp = tmp%1.0
					table.insert(Llist,tmp)
				end
			else
				table.insert(Llist,tmp)
			end
		end
	end
	
	Ret = {0}
	if PerSegment == 0 or PerSegment == nil then
		LArr = {}
		LStack = {0}
		for i = 1, Path[1]-1 do
			table.insert(LArr,math.sqrt((Path[i+1][1]-Path[i+2][1])^2+(Path[i+1][2]-Path[i+2][2])^2))
			table.insert(LStack,LArr[i]+LStack[i])
		end
		LTotal = LStack[#LStack]
		LRatio = {}
		for i = 1, #LStack do
			table.insert(LRatio,LStack[i]/LTotal)
		end
		
		for k, v in pairs(Llist) do
			s = 0
			for i = 1, #LRatio do
				s = i
				if v <= LRatio[i+1] then
					goto CS_PathInPathSkip1
				end
			end
			v = 1.0
			s = #LRatio-1
			::CS_PathInPathSkip1::
			v = (v - LRatio[s])/(LRatio[s+1]-LRatio[s]) 
			
			t = 0
			for i = 1, #TRatio do
				t = i
				if v <= TRatio[i+1][2] then
					goto CS_PathInPathSkip2
				end
			end
			v = 1.0
			t = #TRatio-1
			::CS_PathInPathSkip2::
			vLength = v*TTotal - TStack[t][2]
			TL = TRatio[t][1]
			TR = TRatio[t+1][1]
			TCur = TRatio[t][1]
			TX1, TY1 = _G[funcT](TL)
			for i = 1, Loop do
				TMid = (TL+TR)/2.0
				TX2, TY2 = _G[funcT](TMid)
				TLength = math.sqrt((TX2-TX1)^2+(TY2-TY1)^2)
				if vLength > TLength then
					TL = TMid
					TCur = TMid
				elseif vLength < TLength then
					TR = TMid
					TCur = TMid
				else
					goto CS_PathInPathSkip3
				end
			end
			::CS_PathInPathSkip3::
			
			PX, PY = _G[funcT](TCur)				
			X1 = Path[s+1][1]
			Y1 = Path[s+1][2]
			X2 = Path[s+2][1]
			Y2 = Path[s+2][2]
			DX = X2-X1
			DY = Y2-Y1
			Length = math.sqrt((DX)^2+(DY)^2)
			
			-- Scale (funcT : (0,0) = (X1,Y1), (1,0) = (X2,Y2))
			PX = PX * Length
			PY = PY * Length
			-- Rotation
			PA = 0
			if DX>=0 and DY>=0 then
				PA = math.abs(math.atan(DY/DX))
			elseif DX<0 and DY>=0 then
				PA = math.pi - math.abs(math.atan(DY/DX))
			elseif DX<0 and DY<0 then
				PA = math.pi + math.abs(math.atan(DY/DX))
			elseif DX>=0 and DY<0 then
				PA = 2*math.pi - math.abs(math.atan(DY/DX))
			end
			NX = PX
			NY = PY
			XYCos = math.cos(PA)
			XYSin = math.sin(PA)
			PX = NX*XYCos - NY*XYSin
			PY = NX*XYSin + NY*XYCos
			-- Translation
			PX = PX + X1
			PY = PY + Y1
			table.insert(Ret,{PX,PY})
			Ret[1] = Ret[1] + 1
		end
	else
		for i = 1, Path[1]-1 do
			X1 = Path[i+1][1]
			Y1 = Path[i+1][2]
			X2 = Path[i+2][1]
			Y2 = Path[i+2][2]
			DX = X2-X1
			DY = Y2-Y1
			Length = math.sqrt((DX)^2+(DY)^2)
			for k, v in pairs(Llist) do
				t = 0
				for j = 1, #TRatio do
					t = j
					if v <= TRatio[j+1][2] then
						goto CS_PathInPathSkip4
					end
				end
				v = 1.0
				t = #TRatio-1
				::CS_PathInPathSkip4::
				vLength = v*TTotal - TStack[t][2]
				TL = TRatio[t][1]
				TR = TRatio[t+1][1]
				TCur = TRatio[t][1]
				TX1, TY1 = _G[funcT](TL)
				for j = 1, Loop do
					TMid = (TL+TR)/2.0
					TX2, TY2 = _G[funcT](TMid)
					TLength = math.sqrt((TX2-TX1)^2+(TY2-TY1)^2)
					if vLength > TLength then
						TL = TMid
						TCur = TMid
					elseif vLength < TLength then
						TR = TMid
						TCur = TMid
					else
						goto CS_PathInPathSkip5
					end
				end
				::CS_PathInPathSkip5::
				PX, PY = _G[funcT](TCur)				
				
				-- Scale (funcT : (0,0) = (X1,Y1), (1,0) = (X2,Y2))
				PX = PX * Length
				PY = PY * Length
				-- Rotation
				PA = 0
				if DX>=0 and DY>=0 then
					PA = math.abs(math.atan(DY/DX))
				elseif DX<0 and DY>=0 then
					PA = math.pi - math.abs(math.atan(DY/DX))
				elseif DX<0 and DY<0 then
					PA = math.pi + math.abs(math.atan(DY/DX))
				elseif DX>=0 and DY<0 then
					PA = 2*math.pi - math.abs(math.atan(DY/DX))
				end
				NX = PX
				NY = PY
				XYCos = math.cos(PA)
				XYSin = math.sin(PA)
				PX = NX*XYCos - NY*XYSin
				PY = NX*XYSin + NY*XYCos
				-- Translation
				PX = PX + X1
				PY = PY + Y1
				table.insert(Ret,{PX,PY})
				Ret[1] = Ret[1] + 1
			end
		end
	end
	
	if not (Closed == 0 or Closed == nil) then
		table.remove(Path,#Path)
		Path[1] = Path[1] - 1
	end
	
	return Ret
end