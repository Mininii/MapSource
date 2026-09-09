-- =====================================================================
-- MakeBeatTimer — BPM·박자로 "마디·박 → 시간" 을 뽑아 주는 타이밍 생성기
--
--   BGM 에 맞춰 웨이브를 뿌리는 보스(Stella-II 화이트홀 건작보스 등)는
--   스폰 시점을 ms 로 손수 적으면 곡을 갈아끼울 때 전부 다시 재야 한다.
--   곡의 BPM·박자·시작 오프셋만 주면 그 곡 전용 시간 계산기를 만들어 주므로,
--   이후로는 시점을 "몇 마디 몇 박" 으로만 적으면 된다.
--
--     local B = MakeBeatTimer(102, 4, 140)  -- 102 BPM, 4/4, 마디1 박1 = 140ms
--     B(13, 3)                --> 마디 13 박 3 의 ms
--     B.F(13, 3)              --> 같은 시점의 프레임 (ms // 0x1D)
--     B.Seq(48, 1, 0.75, 7)   --> 마디48 박1 부터 0.75박 간격 7연타의 ms 리스트
--     B.List{{60,2},{60,3},{61,2}}  --> 불규칙한 시점 묶음의 ms 리스트
--
--   인자  (BPM, 박자, 오프셋)
--     BPM     분당 4분음표 수.  템포가 바뀌는 곡은 구간 테이블 - 맨 아래 참고.
--     박자    4 = 4/4.  {6,8} 처럼 적으면 한 박이 8분음표(4분음표의 절반)가 된다.
--             nil 이면 4/4.
--     오프셋  마디1 박1 이 울리는 ms (곡 앞 무음 길이).  nil 이면 0.
--
--   반환값 T (호출 가능한 테이블)
--     T(마디, 박)             ms.  박은 1부터 세고 소수(1.5=8분음표, 1.75=점8분음표)와
--                             마디당 박 수 초과(자동 이월)를 허용한다.  T(30,5) = T(31,1).
--     T.Ms(마디, 박)          T(마디, 박) 과 같다 (다른 함수에 넘겨 쓸 때).
--     T.F(마디, 박)           프레임.  T.FrameMs(기본 0x1D) 로 나눈 몫.
--     T.Seq(마디,박,간격,횟수) 등간격 연타 → ms 리스트.  간격은 박 단위(소수 허용).
--     T.SeqF(마디,박,간격,횟수) 같은 것의 프레임 리스트.
--     T.List{{마디,박},…}     불규칙 시점 묶음 → ms 리스트.
--     T.ListF{{마디,박},…}    같은 것의 프레임 리스트.
--     T.Len(박수)             "몇 박" 이 몇 ms 인지 (지속시간·간격 계산용).
--     T.BPM / T.Beats / T.BeatMs / T.BarMs / T.Offset   첫 구간의 정보(읽기용).
--     T.FrameMs               ms→프레임 나눗수.  기본 0x1D, 필요하면 고쳐 쓴다.
--
--   템포·박자가 바뀌는 곡은 구간 테이블을 첫 인자로 준다.
--     local B = MakeBeatTimer{
--         {BPM=102, Meter=4,     Bar=1, Offset=140},  -- 마디 1~56
--         {BPM=128, Meter={6,8}, Bar=57},             -- 마디 57 부터
--     }
--     Bar    그 구간이 시작하는 마디(첫 구간은 1 이 기본, 이후는 필수·오름차순).
--     Offset 그 구간 첫 박의 절대 ms 를 못 박는다.  안 적으면 앞 구간에서 이어 계산한다.
--     박이 마디를 넘어 이월될 때는 "그 시점이 속한 구간" 의 템포로만 잰다 -
--     구간 경계를 넘겨 이월시키지 말고 다음 구간의 마디·박으로 적을 것.
-- =====================================================================
function MakeBeatTimer(BPM, Meter, Offset)
	-- ── 구간 정규화: 단일 템포도 구간 1개짜리로 취급한다 ──────────────
	local Src = BPM
	if type(Src) ~= "table" then
		Src = {{BPM = BPM, Meter = Meter, Bar = 1, Offset = Offset}}
	end
	if #Src == 0 then error("MakeBeatTimer: 구간 테이블이 비어 있습니다") end

	local Sec = {}
	for i, s in ipairs(Src) do
		if type(s.BPM) ~= "number" or s.BPM <= 0 then
			error("MakeBeatTimer: "..i.."번째 구간의 BPM 이 잘못되었습니다")
		end
		-- 박자: 4 → 4/4,  {6,8} → 6/8.  한 박 = 1/d 음표이므로 4분음표의 4/d 배.
		local n, d = 4, 4
		if type(s.Meter) == "table" then
			n, d = s.Meter[1] or 4, s.Meter[2] or 4
		elseif s.Meter ~= nil then
			n = s.Meter
		end
		if type(n) ~= "number" or n <= 0 or type(d) ~= "number" or d <= 0 then
			error("MakeBeatTimer: "..i.."번째 구간의 박자가 잘못되었습니다")
		end

		local Bar = s.Bar
		if Bar == nil then
			if i > 1 then error("MakeBeatTimer: "..i.."번째 구간에 시작 마디(Bar)가 없습니다") end
			Bar = 1
		end
		if i > 1 and Bar <= Sec[i-1].Bar then
			error("MakeBeatTimer: 구간의 시작 마디(Bar)는 오름차순이어야 합니다")
		end

		Sec[i] = {BPM = s.BPM, Beats = n, Note = d, Bar = Bar,
		          BeatMs = 60000 / s.BPM * (4 / d)}

		-- 구간 첫 박의 절대 시각.  Offset 을 적었으면 그 값, 아니면 앞 구간에서 이어 계산.
		if s.Offset ~= nil then
			Sec[i].StartMs = s.Offset
		elseif i == 1 then
			Sec[i].StartMs = 0
		else
			local p = Sec[i-1]
			Sec[i].StartMs = p.StartMs + math.floor((Bar - p.Bar) * p.Beats * p.BeatMs + 0.5)
		end
	end

	local T = {
		BPM     = Sec[1].BPM,
		Beats   = Sec[1].Beats,                    -- 마디당 박 수
		BeatMs  = Sec[1].BeatMs,                   -- 1박 길이(ms, 실수)
		BarMs   = Sec[1].Beats * Sec[1].BeatMs,    -- 1마디 길이(ms, 실수)
		Offset  = Sec[1].StartMs,
		FrameMs = 0x1D,                            -- ms → 프레임 나눗수
		Sections = Sec,
	}

	-- 마디·박 → ms.  반올림은 "구간 첫 박부터 흐른 시간" 에 한 번만 건다.
	local function At(Bar, Beat)
		Bar  = Bar  or 1
		Beat = Beat or 1
		local c = Sec[1]
		for i = 2, #Sec do
			if Sec[i].Bar <= Bar then c = Sec[i] else break end
		end
		return c.StartMs + math.floor(((Bar - c.Bar) * c.Beats + (Beat - 1)) * c.BeatMs + 0.5)
	end

	T.Ms = At
	function T.F(Bar, Beat) return At(Bar, Beat) // T.FrameMs end

	-- 등간격 연타.  Seq(48,1,0.75,7) = 마디48 박1 부터 0.75박 간격 7개.
	function T.Seq(Bar, Beat, Step, Count)
		local Ret = {}
		for i = 0, (Count or 1) - 1 do Ret[i+1] = At(Bar, Beat + i * (Step or 1)) end
		return Ret
	end
	function T.SeqF(Bar, Beat, Step, Count)
		local Ret = T.Seq(Bar, Beat, Step, Count)
		for i, v in ipairs(Ret) do Ret[i] = v // T.FrameMs end
		return Ret
	end

	-- 불규칙한 시점 묶음.  List{{60,2},{60,3},…}
	function T.List(Beats)
		local Ret = {}
		for i, v in ipairs(Beats) do Ret[i] = At(v[1], v[2]) end
		return Ret
	end
	function T.ListF(Beats)
		local Ret = T.List(Beats)
		for i, v in ipairs(Ret) do Ret[i] = v // T.FrameMs end
		return Ret
	end

	-- "몇 박" 의 길이(ms).  첫 구간 기준.
	function T.Len(Beats) return math.floor((Beats or 1) * T.BeatMs + 0.5) end

	return setmetatable(T, {__call = function(_, Bar, Beat) return At(Bar, Beat) end})
end
