--[[ ===========================================================================
     특수(tes / Axiom) 건작보스 도형 사전계산

     GunData.lua 의 CIf_GCase(190) 특수 분기는 매 틱 Call_CA_Effect(CA_Create=0) 로
     도형 8개 점을 배율(CA_RatioXY) + 3D 회전(CA_Rotate3D) 해서 이펙트를 찍는다.
     점 하나에 f_Lengthdir 가 여섯 번, 틱마다 여덟 점이라 무겁다.

     tesPrecompute    그 틱의 회전각(11/12/13, 16/17/18번 줄)과 배율(CA_Eff_Rat2/3 + DRat2/3)을
                      tes 분기의 트리거와 "같은 순서, 같은 정수 연산" 으로 흉내 내고, 게임 안의
                      f_Lengthdir(LengthdirMode 1, 360 분할, 표값 floor(k*sin)) 과 같은 계산으로
                      점 좌표를 미리 구한다.
     tesDrawFromCache 그 표를 맵에 넣고, 매 틱 표만 읽어 찍는 트리거를 만든다.
                      GunData.lua 의 tesUseCache = 1 일 때 Call_CA_Effect 대신 불린다.

     일반 보스 사전계산(GunData.lua CaTX/CaTY)과 다른 점
       * 좌표는 중심 기준 오프셋이다. 게임에서 SHLX/SHLY(건작 중심)를 더한다.
       * Lua 의 lengthdir(ShapeData.lua)은 sin 부호가 반대라 쓰지 않는다. 게임과 같은
         부호/정수 계산을 직접 한다. 그래서 이벤트 소환(런타임 CA_Eff)과 점 위치가 맞는다.

     GunData.lua tes 분기에서 아래 값을 바꾸는 트리거를 고치면 여기도 같이 고쳐야 한다.
     각 줄 끝의 숫자는 이 파일을 만들 때의 GunData.lua 줄 번호다.
     Limit == 1 빌드에서 TestMode 를 켜면 게임 값과 표 값을 나란히 찍어 어긋남을 볼 수 있다.

     main.lua 의 폴더 로드로 읽히지만 함수 정의만 하고 트리거는 만들지 않는다.
     =========================================================================== ]]

function tesPrecompute(Points, Bit)
	local P32 = 4294967296
	local function u32(v) return v % P32 end
	local function s32(v) v = v % P32 if v >= 2147483648 then return v - P32 end return v end
	local function subs(a, b) if a >= b then return a - b end return 0 end -- CSub / SubV (1 - 2 = 0)
	local function fl(v) return math.floor(v) end -- 조건 상수의 소수점은 인코더가 버린다
	local function idiv(a, b) -- CiDiv : 0 쪽으로 버림 (-10/3 = -3)
		if a >= 0 then return math.floor(a / b) end
		return -math.floor(-a / b)
	end

	-- 게임 안의 f_Lengthdir : 각도 0~359 로 접고 사분면별 표값 floor(|R|*sin) 에 부호를 붙인다.
	local SN = {}
	for l = 0, 90 do SN[l] = math.sin(math.rad(l * 90 / 90)) end
	local function ld(R, a)
		local neg = R < 0
		if neg then R = -R end
		R = R % 32768
		a = s32(a) % 360
		local cs, ss, ci, si
		if a <= 89 then cs, ss, si, ci = 1, 1, a, 90 - a
		elseif a <= 179 then cs, ss, si, ci = -1, 1, 180 - a, a - 90
		elseif a <= 269 then cs, ss, si, ci = -1, -1, a - 180, 270 - a
		else cs, ss, si, ci = 1, -1, 360 - a, a - 270 end
		local c = cs * math.floor(R * SN[ci])
		local s = ss * math.floor(R * SN[si])
		if neg then c, s = -c, -s end
		return c, s
	end
	local function rot(X, Y, XY, YZ, ZX) -- CA_Rotate3D
		local XC, XS = ld(X, XY)
		local YC, YS = ld(Y, XY)
		local X2, Y2 = XC - YS, XS + YC
		local Y3, Z = ld(Y2, YZ)
		local XC3 = ld(X2, ZX)
		local _, ZS = ld(Z, ZX)
		return XC3 - ZS, Y3
	end
	local function rat(p, R) return idiv(s32(p * R), 210600) end -- CA_RatioXY(R,210600,R,210600)

	local L8, L10, L11, L12, L13, L14, L15, L16, L17, L18 = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	local ACCR, ACCV, ACCV2 = 1, 1, P32 - 1
	local RatF, RatF2, RatFDT, RatFM, RatFM2, RatFMDT = 0, 0, 1000, 0, 0, 1000
	local DRat2, DRat3, DRat2Dt, DRat3Dt = 0, 0, 2500, 2500
	local EffFin, tesEndt = 0, 0
	local done = {}
	local function once(key, cond) -- 플래그 없는 TriggerX / flag 1 CallTriggerX : 한 번만
		if cond and not done[key] then done[key] = true return true end
		return false
	end
	local function addAng(v)
		L11 = u32(L11 + v) L16 = u32(L16 + v) L12 = u32(L12 + v)
		L13 = u32(L13 + v) L17 = u32(L17 + v) L18 = u32(L18 + v)
	end

	local tDR = {12130, 12800, 13480, 14150, 14830, 15500, 16180, 16850} -- 1592
	local tP1 = {55280, 55440, 55950, 56120, 56620, 56790, 57130, 57300, 57640, 57970, 58140, 58650, 58820,
		59320, 59490, 59830, 60000, 60250, 60500} -- 1653
	for i = 1, 19 do tP1[19 + i] = tP1[i] + 5390 end
	local tLn = {} -- 1920
	for i = 1, 16 do tLn[i] = fl(109210 + ((Bit / 2) * (i - 1))) end

	local X, Y = {}, {}
	for i = 1, 8 do X[i] = {0} Y[i] = {0} end -- [1] = 원소 0 (게임에서 안 읽힘)
	local Dbg = {{0}, {0}, {0}, {0}, {0}, {0}}
	local N, k = nil, 0
	while true do
		k = k + 1
		if k > 20000 then error("tesPrecompute: 20000틱 안에 끝나지 않는다 - 시뮬레이션이 게임과 어긋났다") end

		L10 = u32(L10 + 29) L8 = u32(L8 + 29) -- 1494
		if once("1495", true) then L10 = u32(L10 + 100000) end

		if L8 <= 8090 then -- 1538
			L11 = u32(L11 + 1) L12 = u32(L12 + 1) -- 1539 CA_3DAcc(0,1,1,0)
			L16 = u32(L16 - 1) L18 = u32(L18 - 1) -- 1540 CA_3DAcc2(0,-1,0,-1)
			if L8 >= 5390 then ACCR = u32(ACCR + 1) end -- 1544
			ACCV = math.floor(ACCR / 15) ACCV2 = u32(-ACCV) -- 1545
			L11 = u32(L11 + ACCV) L12 = u32(L12 + ACCV) L16 = u32(L16 + ACCV2) L17 = u32(L17 + ACCV2) -- 1547
		end
		if once("1566", L8 >= 8090) then ACCR = 0 end
		for j, t in ipairs(tDR) do -- 1596
			if once("1596_" .. j, L8 >= t) then
				if j % 2 == 1 then DRat2 = u32(DRat2 + 210000) else DRat3 = u32(DRat3 + 210000) end
			end
		end

		if L8 >= 17520 then -- 1607
			if L8 <= 22920 and ACCR <= 150 then ACCR = u32(ACCR + 1) end -- 1608
			if L8 >= 53930 and L8 <= 55280 and ACCR >= 30 then ACCR = subs(ACCR, 5) end -- 1609
			ACCV = math.floor(ACCR / 9) ACCV2 = u32(-ACCV) -- 1610
			L11 = u32(L11 + ACCV) L16 = u32(L16 + ACCV2) -- 1613
			if L8 >= 22920 and L8 <= 119660 then -- 1617
				L12 = u32(L12 + 1) L13 = u32(L13 + 1) L17 = u32(L17 + 1) L18 = u32(L18 + 1)
			end
			if L8 >= 135500 and ACCR >= 1 then -- 1622
				L12 = u32(L12 + 1) L13 = u32(L13 + 1) L17 = u32(L17 - 1) L18 = u32(L18 - 1)
			end
		end

		if L8 >= 55280 and L8 <= 76850 then -- 1673
			for j, t in ipairs(tP1) do -- 1691
				if once("1691_" .. j, L8 >= t) then
					if j % 2 == 1 then DRat2 = u32(DRat2 + 50000) else DRat3 = u32(DRat3 + 50000) end
				end
			end
		end

		if once("1833", L8 >= 75840) then RatF2 = 200000 end
		if RatF <= RatF2 then RatF = u32(RatF + RatFDT) end -- 1836
		if RatFM <= RatFM2 then RatFM = u32(RatFM + RatFMDT) end -- 1837
		if once("1838", L8 >= 107520) then RatFM2 = 200000 end
		if L8 >= 95730 and L8 <= 98420 and ACCR <= 150 then ACCR = u32(ACCR + 3) end -- 1879
		if L8 >= 101620 and L8 <= 103820 and ACCR >= 30 then ACCR = subs(ACCR, 3) end -- 1909
		if L8 >= 103820 and L8 <= 107520 and ACCR <= 120 then ACCR = u32(ACCR + 3) end -- 1910
		if L8 >= 107520 and L8 <= 109040 and ACCR >= 30 then ACCR = subs(ACCR, 3) end -- 1917
		if L8 >= 109210 and L8 <= fl(109210 + ((Bit / 2) * (8 - 1))) and ACCR <= 120 then ACCR = u32(ACCR + 3) end -- 1918
		if once("1924", L8 >= 109210) then DRat2Dt = 7500 DRat3Dt = 7500 end
		for j, t in ipairs(tLn) do -- 1942
			if once("1942_" .. j, L8 >= t) then
				if j % 2 == 1 then DRat2 = u32(DRat2 + 300000) else DRat3 = u32(DRat3 + 300000) end
			end
		end
		if once("1954", L8 >= 119660) then -- 1954 CIfOnce + 1956
			ACCR = 0
			L11, L12, L13, L16, L17, L18 = 0, 0, 0, 90, 0, 0
			RatF2, RatF, DRat2, DRat3 = 400000, 400000, 100000, 100000
		end
		if once("2002", L8 >= 137520 and L8 <= 163140) then RatFMDT = 5000 RatFM2 = 500000 end
		if L8 >= 135500 and L8 <= 140500 and ACCR <= 120 then ACCR = u32(ACCR + 3) end -- 2006
		if once("2012", L8 >= 156400) then RatF2 = u32(RatF2 + 60000) RatFDT = 5000 end
		if once("2041", L8 >= 157750) then RatF2 = u32(RatF2 + 150000) RatFDT = 7500 end
		if L8 >= 179320 and L8 <= 182020 and ACCR >= 10 then ACCR = subs(ACCR, 3) end -- 2068
		if L8 >= 189430 and L8 <= 191460 and ACCR <= 120 then ACCR = u32(ACCR + 3) end -- 2069
		if once("2070", L8 >= 189430 and L8 <= 191460) then RatFM2 = u32(RatFM2 + 150000) end
		if once("2073", L8 >= 163140) then ACCR = 0 RatFM = 250000 RatFM2 = 250000 end
		if once("2074", L8 >= 163480) then ACCR = 120 RatF = 50000 RatF2 = 330000 RatFDT = 20000 end
		for _, t in ipairs({163820, 164490, 165160, 173930, 174430, 175280, 175780}) do -- 2075~2083
			if once("2075_" .. t, L8 >= t) then RatF = 50000 RatFDT = 20000 end
		end
		if once("2089", L8 >= 187410) then ACCR = 0 addAng(15) end
		for _, t in ipairs({187580, 187920, 188090, 188420, 188590, 188930, 189100}) do -- 2090~2096
			if once("2090_" .. t, L8 >= t) then addAng(15) end
		end
		for _, t in ipairs({190110, 190220, 190330, 190440, 195500, 195560, 195610, 195670, 195730, 195780, 195840}) do -- 2113~2129
			if once("2113_" .. t, L8 >= t) then RatF = u32(RatF + 30000) end
		end
		if L8 >= 200220 and L8 <= 200890 and ACCR >= 10 then ACCR = subs(ACCR, 4) end -- 2137
		if once("2139", L8 >= 200220) then RatFM = u32(RatFM + 150000) DRat2Dt = 777 DRat3Dt = 777 end
		for _, t in ipairs({200890, 201570, 202240, 202920, 203590}) do -- 2140~2150
			if once("2140_" .. t, L8 >= t) then addAng(15) DRat2 = u32(DRat2 + 50000) DRat3 = u32(DRat3 + 50000) end
		end
		if L8 >= 203590 then EffFin = u32(EffFin + 2000) end -- 2163

		local Rat = L10 -- 2206
		local Rat2, Rat3 = u32(L14 + Rat), u32(L15 + Rat)
		Rat2, Rat3 = u32(Rat2 + RatF), u32(Rat3 + RatF)
		Rat2, Rat3 = u32(Rat2 - RatFM), u32(Rat3 - RatFM)
		local finish = false
		if L8 >= 203590 then -- 2213
			Rat2, Rat3 = subs(Rat2, EffFin), subs(Rat3, EffFin)
			if Rat2 == 0 and Rat3 == 0 and L8 >= 210000 then -- 2216
				ACCR = 0
				tesEndt = u32(tesEndt + 29)
				if tesEndt >= 830 then Rat2, Rat3 = u32(Rat2 + 50000), u32(Rat3 + 50000) end
				if tesEndt >= 2470 then Rat2, Rat3 = u32(Rat2 + 75000), u32(Rat3 + 75000) end
				if tesEndt >= 3930 then Rat2, Rat3 = u32(Rat2 + 100000), u32(Rat3 + 100000) end
				if tesEndt >= 6000 and once("2232", tesEndt >= 6000 + (40 * 83)) then finish = true end
			end
		end

		-- 2243~2252 : 이 틱에 그려지는 값
		local RR2, RR3 = u32(DRat2 + Rat2), u32(DRat3 + Rat3)
		for i = 1, 8 do
			local p = Points[i]
			local R, a, b, c
			if i <= 4 then R, a, b, c = s32(RR2), L11, L12, L13
			else R, a, b, c = s32(RR3), L16, L17, L18 end
			local px, py = rot(rat(p[1], R), rat(p[2], R), a, b, c)
			X[i][k + 1] = u32(px)
			Y[i][k + 1] = u32(py)
		end
		Dbg[1][k + 1] = L11 Dbg[2][k + 1] = L12 Dbg[3][k + 1] = L13
		Dbg[4][k + 1] = L16 Dbg[5][k + 1] = RR2 Dbg[6][k + 1] = RR3

		DRat2, DRat3 = subs(DRat2, DRat2Dt), subs(DRat3, DRat3Dt) -- 2258
		if finish then N = k break end
	end
	return {N = N, X = X, Y = Y, Dbg = Dbg}
end

-- GunData.lua tes 분기의 CallTrigger(FP,Call_CA_Effect,{SetV(CA_Create,0)}) 자리에서 불린다.
-- tesCache 는 8번 줄과 같은 트리거에서 1씩 오르는 틱 번호다 (GunData.lua).
function tesDrawFromCache()
	-- 특수 모드 도형 = CallTrigger.lua CAPlot 의 도형 2번 (CCA_ShNm = 2). 인코더처럼 0 쪽으로 버린다.
	local S = CS_OverlapX(CSMakeCircle(4,128,0,5,1),CSMakeCircle(4,128,45,5,1))
	local function tz(v) if v >= 0 then return math.floor(v) end return -math.floor(-v) end
	local Pts = {}
	for i = 1, 8 do Pts[i] = {tz(S[i + 1][1]), tz(S[i + 1][2])} end
	local R = tesPrecompute(Pts, 674.1573*2)

	local FX, FY, FD = {}, {}, {}
	local Jump = def_sIndex()
	CJump(FP, Jump)
	for i = 1, 8 do
		FX[i] = f_GetFileArrptr(FP, R.X[i], 4, 1)
		FY[i] = f_GetFileArrptr(FP, R.Y[i], 4, 1)
	end
	if Limit == 1 then
		for i = 1, 6 do FD[i] = f_GetFileArrptr(FP, R.Dbg[i], 4, 1) end
	end
	CJumpEnd(FP, Jump)

	-- 점별 이펙트 : CallTrigger.lua CA_Eff 의 CA_Create == 0 부분과 같은 높이/색상
	local PtEff = {
		{{19,6},{20,17}},
		{{19,6},{18,13}},
		{{19,6},{19,6},{18,13}},
		{{19,6},{19,6},{18,13}},
		{{19,6},{19,6},{17,17},{18,13}},
		{{18,17},{17,13},{19,6},{19,6}},
		{{17,6},{19,17},{18,13}},
		{{19,17},{20,17},{18,13}},
	}
	CIf(FP,{CV(tesCache,R.N,AtMost)},{SetMemoryW(0x666462, SetTo, 936),SetMemory(0x66EC48+(4*936), SetTo, 131)})
	for i = 1, 8 do
		f_SHRead(FP, ArrX(FX[i],tesCache), CPosX)
		f_SHRead(FP, ArrX(FY[i],tesCache), CPosY)
		CAdd(FP,CPosX,SHLX)
		CAdd(FP,CPosY,SHLY)
		Simple_SetLocX(FP, 0, CPosX, CPosY, CPosX, CPosY)
		for _, e in ipairs(PtEff[i]) do
			TriggerX(FP,{CD(CA_EffSWArr[i],0)},{
				SetMemoryB(0x66321C, SetTo, e[1]); -- 높이
				SetMemoryB(0x669E28+936, SetTo, e[2]); -- 색상
				CreateUnitWithProperties(1,204,1,FP,{energy = 100})},{preserved})
		end
	end
	CIfEnd({SetMemory(0x66EC48+(4*936), SetTo, 409),SetMemoryB(0x669E28+936, SetTo, 9)})

	if Limit == 1 then -- 게임 값 / 표 값 비교 (XY, YZ, ZX, XY2, 배율2, 배율3)
		local TV = CreateVarArr(6,FP)
		local RR2, RR3 = CreateVar(FP), CreateVar(FP)
		CIf(FP,{CD(TestMode,1),CV(tesCache,R.N,AtMost)})
		for i = 1, 6 do f_SHRead(FP, ArrX(FD[i],tesCache), TV[i]) end
		CAdd(FP,RR2,CA_Eff_DRat2,CA_Eff_Rat2)
		CAdd(FP,RR3,CA_Eff_DRat3,CA_Eff_Rat3)
		DisplayPrint(HumanPlayers,{"tes V : ",CA_Eff_XY,", ",CA_Eff_YZ,", ",CA_Eff_ZX,", ",CA_Eff_XY2,", ",RR2,", ",RR3,
			"\nCache : ",TV[1],", ",TV[2],", ",TV[3],", ",TV[4],", ",TV[5],", ",TV[6]})
		CIfEnd()
	end
	return R.N
end
