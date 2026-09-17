
  /* ================= v2 확장 : CB Paint v2.5 나머지 함수 이식 ================= */

  var CS_LIMIT = 200000;   /* 한 번의 생성/채우기로 만들 수 있는 점의 상한 */

  /* funcY·VectorFunc 등은 Lua에서 함수 "이름"(문자열)으로 넘어옵니다.
     여기서는 JS 함수도, 등록된 이름도 받습니다. */
  var FUNCS = Object.create(null);
  function setFunc(name, fn){ FUNCS[name] = fn; }
  function clearFuncs(){ for(var k in FUNCS) delete FUNCS[k]; }
  function resolveFunc(f, what){
    if(typeof f === 'function') return f;
    if(typeof f === 'string'){
      if(typeof FUNCS[f] === 'function') return FUNCS[f];
      err('"' + f + '" 함수가 정의되어 있지 않습니다' + (what ? ' (' + what + ')' : ''));
    }
    err((what || '함수') + ' 인자가 필요합니다');
  }
  /* Ratio : 숫자 하나 또는 {X,Y} */
  function ratioXY(Ratio){
    if(isNil(Ratio)) return [1, 1];
    if(typeof Ratio === 'number') return [Ratio, Ratio];
    return [isNil(Ratio[0]) ? 1 : Ratio[0], isNil(Ratio[1]) ? 1 : Ratio[1]];
  }
  /* 범위 : 숫자 하나(=폭) 또는 {min,max} */
  function areaSpan(area, name, zeroBase){
    if(isNil(area)) err(name + ' 범위가 필요합니다');
    if(typeof area === 'number'){
      if(zeroBase) return { D: area, lo: 0, hi: area };
      return { D: area, lo: -area / 2, hi: area / 2 };
    }
    if(isNil(area[0]) || isNil(area[1])) err(name + ' 범위는 {최소, 최대} 두 값이 모두 필요합니다');
    return { D: Math.abs(area[1] - area[0]), lo: area[0], hi: area[1] };
  }
  /* Edge(가장자리 포함) 규칙 — 원본 채우기 4종이 모두 같은 식을 씁니다 */
  function fillSteps(Edge, D, size){
    var S, P;
    if(Edge === 0){
      if(mod(D, size) === 0){ S = D / size; P = size / 2; }
      else { S = D / size + 1; P = mod(D, size) / 2; }
    } else {
      if(mod(D, size) === 0){ S = D / size + 1; P = 0; }
      else { S = D / size + 1; P = mod(D, size) / 2; }
    }
    return { S: S, P: P };
  }
  function fillGuard(a, b){
    var n = Math.floor(a) * Math.floor(b);
    if(!(n >= 0) || n > CS_LIMIT) err('채우기 결과가 ' + Math.round(n) + '점입니다 — 간격을 넓히거나 범위를 줄여주세요.');
  }
  function makeGuard(Number){
    if(!(Number >= 1)) err('Number는 1 이상이어야 합니다');
    if(Number > CS_LIMIT) err('Number가 너무 큽니다 (' + Math.round(Number) + ')');
  }

  /* ---------- 나선 (CSMakeSpiral.lua) ---------- */
  function CSMakeSpiral(Point, Magnificent, Coefficient, Radius, Angle, Number, Hollow){
    Hollow = Hollow || 0;
    makeGuard(Number);
    if(Number < Hollow) err('Number가 Hollow보다 작습니다');
    var Shape = [Number - Hollow];
    Angle = Angle - 90;
    var Main = 1, Level = 1, Remain = Number, Case = 0;
    var Temp, T1, T2, LX, LY, TA, TR;
    var pA = Magnificent, pB = Coefficient;
    if(!pA || !pB) err('나선은 Magnificent·Coefficient가 0이면 안 됩니다');
    var pX = Math.abs(pB / (pA * Math.sqrt(1 + pB * pB)));
    while(true){
      if(Remain === 0) break;
      if(Main === 1){
        if(Hollow >= 1){ Hollow -= 1; } else { Shape.push([0, 0]); Remain -= 1; }
        Main = 2; Level = 2; Temp = Point + 1;
      } else {
        while(Main > Temp){ Level += 1; Temp = ((Level - 1) * Point) + 1; Case = 0; }
        if(Hollow >= 1){ Hollow -= 1; } else {
          T1 = (Level - 1) * Radius;
          T2 = rad(Angle + (360 * Case) / Point);
          TA = (Math.log(T1 * pX) + pB * (rad(Angle) + T2)) / pB;
          TR = pA * Math.exp(pB * (TA - rad(Angle) - T2));
          LX = TR * Math.cos(TA); LY = TR * Math.sin(TA);
          Shape.push([LX, LY]); Remain -= 1;
        }
        Main += 1; Case += 1;
      }
    }
    return Shape;
  }
  function CSMakeSpiralX(Point, Magnificent, Coefficient, Radius, Angle, Number, Hollow){
    Hollow = Hollow || 0;
    makeGuard(Number);
    if(Number < Hollow) err('Number가 Hollow보다 작습니다');
    var Shape = [Number - Hollow];
    Angle = Angle - 90;
    var Main = 1, Level = 1, Remain = Number, Case = 0, HalfRad = Radius / 2;
    var Temp, T1, T2, LX, LY, TA, TR, InitRadius = Radius / 2;
    var pA = Magnificent, pB = Coefficient;
    if(!pA || !pB) err('나선은 Magnificent·Coefficient가 0이면 안 됩니다');
    var pX = Math.abs(pB / (pA * Math.sqrt(1 + pB * pB)));
    while(true){
      if(Remain === 0) break;
      if(Main === 1){ Main = 2; Level = 2; Temp = Point + 1; }
      else {
        while(Main > Temp){ Level += 1; Temp = ((Level - 1) * Point) + 1; Case = 0; }
        if(Hollow >= 1){ Hollow -= 1; } else {
          T1 = ((Level - 2) * HalfRad) + InitRadius;
          T2 = rad(Angle + (360 * Case) / Point);
          TA = (Math.log(T1 * pX) + pB * (rad(Angle) + T2)) / pB;
          TR = pA * Math.exp(pB * (TA - rad(Angle) - T2));
          LX = TR * Math.cos(TA); LY = TR * Math.sin(TA);
          Shape.push([LX, LY]); Remain -= 1;
        }
        Main += 1; Case += 1;
      }
    }
    return Shape;
  }

  /* ---------- 그래프 (등간격 이분 탐색) ---------- */
  function graphGuard(StepSize, Number){
    if(isNil(StepSize) || StepSize <= 0) err('StepSize는 0보다 커야 합니다');
    makeGuard(Number);
  }
  function CSMakeGraphX(Ratio, funcY, Start, Direction, StepSize, StepRange, Number){
    var R = ratioXY(Ratio), XR = R[0], YR = R[1];
    var f = resolveFunc(funcY, 'funcY');
    if(isNil(StepRange)) StepRange = StepSize;
    graphGuard(StepSize, Number);
    if(isNil(Direction)) Direction = 0;
    var Shape = [Number];
    var SS = StepSize * StepSize, ER = SS * 0.05;
    var NX = Start, NY = f(NX);
    Shape.push([NX * XR, NY * YR]);
    for(var i = 1; i <= Number - 1; i++){
      var dx = StepRange, sx = StepRange, CX = NX, CY = NY, Count = 0;
      while(true){
        CX = Direction === 0 ? NX + dx : NX - dx;
        CY = f(CX);
        var L = (CX - NX) * (CX - NX) + (CY - NY) * (CY - NY);
        if(Math.abs(L - SS) < ER || Count > 12) break;
        sx = sx / 2;
        dx = L >= SS ? dx - sx : dx + sx;
        Count += 1;
      }
      NX = CX; NY = CY;
      Shape.push([NX * XR, NY * YR]);
    }
    return Shape;
  }
  function CSMakeGraphY(Ratio, funcX, Start, Direction, StepSize, StepRange, Number){
    var R = ratioXY(Ratio), XR = R[0], YR = R[1];
    var f = resolveFunc(funcX, 'funcX');
    if(isNil(StepRange)) StepRange = StepSize;
    graphGuard(StepSize, Number);
    if(isNil(Direction)) Direction = 0;
    var Shape = [Number];
    var SS = StepSize * StepSize, ER = SS * 0.05;
    var NY = Start, NX = f(NY);
    Shape.push([NX * XR, NY * YR]);
    for(var i = 1; i <= Number - 1; i++){
      var dy = StepRange, sy = StepRange, CX = NX, CY = NY, Count = 0;
      while(true){
        CY = Direction === 0 ? NY + dy : NY - dy;
        CX = f(CY);
        var L = (CX - NX) * (CX - NX) + (CY - NY) * (CY - NY);
        if(Math.abs(L - SS) < ER || Count > 12) break;
        sy = sy / 2;
        dy = L >= SS ? dy - sy : dy + sy;
        Count += 1;
      }
      NX = CX; NY = CY;
      Shape.push([NX * XR, NY * YR]);
    }
    return Shape;
  }
  function CSMakeGraphA(Ratio, funcR, Start, Direction, StepSize, StepRange, Number){
    var R = ratioXY(Ratio), XR = R[0], YR = R[1];
    var f = resolveFunc(funcR, 'funcR');
    if(isNil(StepRange)) StepRange = 2 * PI;
    graphGuard(StepSize, Number);
    if(isNil(Direction)) Direction = 0;
    var Shape = [Number];
    var SS = StepSize * StepSize, ER = SS * 0.05;
    var NA = Start, NR = f(NA);
    Shape.push([NR * Math.cos(NA) * XR, NR * Math.sin(NA) * YR]);
    for(var i = 1; i <= Number - 1; i++){
      var da = StepRange, sa = StepRange, CA = NA, CR = NR, Count = 0;
      while(true){
        CA = Direction === 0 ? NA + da : NA - da;
        CR = f(CA);
        var L = CR * CR + NR * NR - 2 * CR * NR * Math.cos(Math.abs(CA - NA));
        if(Math.abs(L - SS) < ER || Count > 12) break;
        sa = sa / 2;
        da = L >= SS ? da - sa : da + sa;
        Count += 1;
      }
      NA = CA; NR = CR;
      Shape.push([NR * Math.cos(NA) * XR, NR * Math.sin(NA) * YR]);
    }
    return Shape;
  }
  function CSMakeGraphR(Ratio, funcA, Start, Direction, StepSize, StepRange, Number){
    var R = ratioXY(Ratio), XR = R[0], YR = R[1];
    var f = resolveFunc(funcA, 'funcA');
    if(isNil(StepRange)) StepRange = StepSize;
    graphGuard(StepSize, Number);
    if(isNil(Direction)) Direction = 0;
    var Shape = [Number];
    var SS = StepSize * StepSize, ER = SS * 0.05;
    var NR = Start, NA = f(NR);
    Shape.push([NR * Math.cos(NA) * XR, NR * Math.sin(NA) * YR]);
    for(var i = 1; i <= Number - 1; i++){
      var dr = StepRange, sr = StepRange, CR = NR, CA = NA, Count = 0;
      while(true){
        CR = Direction === 0 ? NR + dr : NR - dr;
        CA = f(CR);
        var L = CR * CR + NR * NR - 2 * CR * NR * Math.cos(Math.abs(CA - NA));
        if(Math.abs(L - SS) < ER || Count > 12) break;
        sr = sr / 2;
        dr = L >= SS ? dr - sr : dr + sr;
        Count += 1;
      }
      NA = CA; NR = CR;
      Shape.push([NR * Math.cos(NA) * XR, NR * Math.sin(NA) * YR]);
    }
    return Shape;
  }
  function CSMakeGraphT(Ratio, Parafunc, Start, Direction, StepSize, StepRange, Number){
    var R = ratioXY(Ratio), XR = R[0], YR = R[1];
    var f = resolveFunc(Parafunc, 'Parafunc');
    if(isNil(StepRange)) StepRange = StepSize;
    graphGuard(StepSize, Number);
    if(isNil(Direction)) Direction = 0;
    function pt(t){
      var v = f(t);
      if(!v || typeof v[0] !== 'number' || typeof v[1] !== 'number') err('Parafunc는 {x, y} 두 값을 돌려줘야 합니다');
      return v;
    }
    var Shape = [Number];
    var SS = StepSize * StepSize, ER = SS * 0.05;
    var NT = Start, P0 = pt(NT), NX = P0[0], NY = P0[1];
    Shape.push([NX * XR, NY * YR]);
    for(var i = 1; i <= Number - 1; i++){
      var dt = StepRange, st = StepRange, CT = NT, CX = NX, CY = NY, Count = 0;
      while(true){
        CT = Direction === 0 ? NT + dt : NT - dt;
        var Q = pt(CT); CX = Q[0]; CY = Q[1];
        var L = (CX - NX) * (CX - NX) + (CY - NY) * (CY - NY);
        if(Math.abs(L - SS) < ER || Count > 12) break;
        st = st / 2;
        dt = L >= SS ? dt - st : dt + st;
        Count += 1;
      }
      NT = CT;
      var Z = pt(NT); NX = Z[0]; NY = Z[1];
      Shape.push([NX * XR, NY * YR]);
    }
    return Shape;
  }

  /* ---------- 채우기 ---------- */
  function CS_FillXY(Edge, areaX, areaY, sizeX, sizeY){
    if(isNil(sizeX) || isNil(sizeY) || sizeX <= 0 || sizeY <= 0) err('sizeX·sizeY는 0보다 커야 합니다');
    if(isNil(Edge)) Edge = 1;
    var AX = areaSpan(areaX, 'areaX'), AY = areaSpan(areaY, 'areaY');
    var X = fillSteps(Edge, AX.D, sizeX), Y = fillSteps(Edge, AY.D, sizeY);
    fillGuard(X.S, Y.S);
    var R = [0], C = 0;
    var NX = X.P + AX.lo, NY = Y.P + AY.lo;
    for(var j = 1; j <= Y.S; j++){
      for(var i = 1; i <= X.S; i++){ R.push([NX, NY]); NX += sizeX; C += 1; }
      NX = X.P + AX.lo; NY += sizeY;
    }
    R[0] = C;
    return R;
  }
  function CS_FillRA(Edge, areaR, areaA, sizeR, sizeA){
    if(isNil(Edge)) Edge = 1;
    if(isNil(sizeR) || isNil(sizeA) || sizeR <= 0 || sizeA <= 0) err('sizeR·sizeA는 0보다 커야 합니다');
    var AR = areaSpan(areaR, 'areaR', true), AA;
    if(isNil(areaA)) err('areaA 범위가 필요합니다');
    if(typeof areaA === 'number') AA = { D: rad(areaA), lo: 0, hi: rad(areaA) };
    else AA = { D: rad(Math.abs(areaA[1] - areaA[0])), lo: rad(areaA[0]), hi: rad(areaA[1]) };
    var sA = rad(sizeA);
    var Rst = fillSteps(Edge, AR.D, sizeR), Ast = fillSteps(Edge, AA.D, sA);
    fillGuard(Rst.S, Ast.S);
    var Ret = [0], C = 0;
    var NR = Rst.P + AR.lo, NA = Ast.P + AA.lo;
    for(var j = 1; j <= Ast.S; j++){
      for(var i = 1; i <= Rst.S; i++){
        Ret.push([NR * Math.cos(NA), NR * Math.sin(NA)]); C += 1; NR += sizeR;
      }
      NR = Rst.P + AR.lo; NA += sA;
    }
    Ret[0] = C;
    return Ret;
  }
  function CS_FillHX(Edge, areaX, areaY, sizeX, sizeY, Direction){
    if(isNil(Edge)) Edge = 1;
    if(isNil(Direction)) Direction = 0;
    else if(Direction < 0 || Direction > 3) err('Direction은 0~3입니다');
    if(isNil(sizeX) || isNil(sizeY) || sizeX <= 0 || sizeY <= 0) err('sizeX·sizeY는 0보다 커야 합니다');
    var AX = areaSpan(areaX, 'areaX'), AY = areaSpan(areaY, 'areaY');
    var X = fillSteps(Edge, AX.D, sizeX), Y = fillSteps(Edge, AY.D, sizeY);
    fillGuard(X.S + 1, Y.S + 1);
    var R = [0], C = 0, Check = 0, NX, NY, i, j;
    var bx = X.P + AX.lo, by = Y.P + AY.lo;
    if(Direction === 0 || Direction === 1){
      NY = by;
      NX = Direction === 0 ? bx : bx - sizeX / 2;
      for(j = 1; j <= Y.S; j++){
        var wide = (Direction === 0) ? (Check === 1) : (Check === 0);
        var cnt = wide ? X.S + 1 : X.S;
        for(i = 1; i <= cnt; i++){ R.push([NX, NY]); C += 1; NX += sizeX; }
        NX = wide ? bx : bx - sizeX / 2;
        Check = Check === 0 ? 1 : 0;
        NY += sizeY;
      }
    } else {
      NX = bx;
      NY = Direction === 2 ? by : by - sizeY / 2;
      for(j = 1; j <= X.S; j++){
        var tall = (Direction === 2) ? (Check === 1) : (Check === 0);
        var cnt2 = tall ? Y.S + 1 : Y.S;
        for(i = 1; i <= cnt2; i++){ R.push([NX, NY]); C += 1; NY += sizeY; }
        NY = tall ? by : by - sizeY / 2;
        Check = Check === 0 ? 1 : 0;
        NX += sizeX;
      }
    }
    R[0] = C;
    return R;
  }
  function CS_FillRD(Edge, areaX, areaY, sizeX, sizeY, StackSizeX, StackSizeY){
    if(isNil(sizeX) || isNil(sizeY) || sizeX <= 0 || sizeY <= 0) err('sizeX·sizeY는 0보다 커야 합니다');
    if(isNil(Edge)) Edge = 1;
    var SSX = (isNil(StackSizeX) ? 0 : StackSizeX) / 2;
    var SSY = (isNil(StackSizeY) ? 0 : StackSizeY) / 2;
    var AX = areaSpan(areaX, 'areaX'), AY = areaSpan(areaY, 'areaY');
    var X = fillSteps(Edge, AX.D, sizeX), Y = fillSteps(Edge, AY.D, sizeY);
    var Total = X.S * Y.S;
    if(!(Total >= 0) || Total > 20000) err('무작위 채우기가 ' + Math.round(Total) + '점입니다 — 간격을 넓혀주세요.');
    var loX = X.P + AX.lo, hiX = AX.hi - X.P;
    var loY = Y.P + AY.lo, hiY = AY.hi - Y.P;
    if(hiX < loX || hiY < loY) err('무작위 채우기 범위가 너무 좁습니다');
    var R = [0], C = 0;
    for(var j = 1; j <= Total; j++){
      var NX = loX, NY = loY, Check = 0;
      for(var l = 1; l <= 100; l++){
        NX = rnd(loX, hiX); NY = rnd(loY, hiY);
        for(var i = 1; i <= C; i++){
          if(NX > R[i][0] - SSX && NX < R[i][0] + SSX && NY > R[i][1] - SSY && NY < R[i][1] + SSY) Check = 1;
        }
        if(Check === 0) break;
      }
      R.push([NX, NY]); C += 1;
    }
    R[0] = C;
    return R;
  }

  /* ---------- 자르기 ---------- */
  /* edgeX·edgeY : {a,b} 에서 값이 nil 이 아니면 그 경계선 위의 점도 잘라냅니다 */
  function edgeFlag(e, i){ return (!isNil(e) && !isNil(e[i])) ? 1 : 0; }
  function CS_CropXY(S, areaX, areaY, edgeX, edgeY){
    if(isNil(S)) err('도형이 필요합니다');
    var X1 = isNil(areaX) ? null : areaX[0], X2 = isNil(areaX) ? null : areaX[1];
    var Y1 = isNil(areaY) ? null : areaY[0], Y2 = isNil(areaY) ? null : areaY[1];
    var EX1 = edgeFlag(edgeX, 0), EX2 = edgeFlag(edgeX, 1);
    var EY1 = edgeFlag(edgeY, 0), EY2 = edgeFlag(edgeY, 1);
    var R = [0], C = 0;
    for(var i = 1; i <= S[0]; i++){
      var NX = S[i][0], NY = S[i][1], bad = 0;
      if(!isNil(X1)){ if(EX1 === 0 ? NX < X1 : NX <= X1) bad = 1; }
      if(!isNil(X2)){ if(EX2 === 0 ? NX > X2 : NX >= X2) bad = 1; }
      if(!isNil(Y1)){ if(EY1 === 0 ? NY < Y1 : NY <= Y1) bad = 1; }
      if(!isNil(Y2)){ if(EY2 === 0 ? NY > Y2 : NY >= Y2) bad = 1; }
      if(!bad){ R.push([NX, NY]); C += 1; }
    }
    R[0] = C;
    return R;
  }
  function CS_CropRA(S, areaR, areaA, edgeR, edgeA){
    if(isNil(S)) err('도형이 필요합니다');
    var R1 = isNil(areaR) ? null : areaR[0], R2 = isNil(areaR) ? null : areaR[1];
    var A1 = (isNil(areaA) || isNil(areaA[0])) ? null : rad(areaA[0]);
    var A2 = (isNil(areaA) || isNil(areaA[1])) ? null : rad(areaA[1]);
    var ER1 = edgeFlag(edgeR, 0), ER2 = edgeFlag(edgeR, 1);
    var EA1 = edgeFlag(edgeA, 0), EA2 = edgeFlag(edgeA, 1);
    var Ret = [0], C = 0;
    for(var i = 1; i <= S[0]; i++){
      var NX = S[i][0], NY = S[i][1];
      var PR = polarR(NX, NY), PA = polarA(NX, NY), bad = 0;
      if(!isNil(R1)){ if(ER1 === 0 ? PR < R1 : PR <= R1) bad = 1; }
      if(!isNil(R2)){ if(ER2 === 0 ? PR > R2 : PR >= R2) bad = 1; }
      if(!isNil(A1)){ if(EA1 === 0 ? PA < A1 : PA <= A1) bad = 1; }
      if(!isNil(A2)){ if(EA2 === 0 ? PA > A2 : PA >= A2) bad = 1; }
      if(!bad){ Ret.push([NX, NY]); C += 1; }
    }
    Ret[0] = C;
    return Ret;
  }

  /* 다각형 안/밖 판정 — 원본과 같은 "무작위 기울기 반직선" 방식입니다.
     0 = 밖 / 1 = 변 위 / 2 = 안 */
  function pathHits(S, Path){
    if(isNil(Path) || !Path[0]) err('기준이 될 경로(도형)가 필요합니다');
    var n = Path[0];
    if(S[0] * n > 4000000) err('경로 판정에 점이 너무 많습니다 (' + S[0] + ' × ' + n + ')');
    var Dom = [], GA = [], GB = [], i, j;
    for(i = 1; i <= n; i++){
      var p = Path[i], q = (i < n) ? Path[i + 1] : Path[1];
      Dom.push([Math.min(p[0], q[0]), Math.max(p[0], q[0]), Math.min(p[1], q[1]), Math.max(p[1], q[1])]);
      if(Dom[i - 1][0] === Dom[i - 1][1]){ GA.push('X'); GB.push(Dom[i - 1][0]); }
      else {
        var a = (q[1] - p[1]) / (q[0] - p[0]);
        GA.push(a); GB.push(p[1] - a * p[0]);
      }
    }
    var Ret = [];
    for(i = 1; i <= S[0]; i++){
      var NX = S[i][0], NY = S[i][1], onEdge = false;
      for(j = 0; j < n; j++){
        if(GA[j] === 'X'){
          if(NX === GB[j] && NY >= Dom[j][2] && NY <= Dom[j][3]){ onEdge = true; break; }
        } else {
          if(NY === NX * GA[j] + GB[j] && NX >= Dom[j][0] && NX <= Dom[j][1]){ onEdge = true; break; }
        }
      }
      if(onEdge){ Ret.push(1); continue; }
      var k = 0.00001, l = NY - k * NX, Count = 0, Check = 0;
      for(j = 0; j < n; j++){
        var guard = 0;
        while(true){
          if(Check === 1){ k = rnd(1, 99999) + rnd(1, 99999) / 100000; l = NY - k * NX; }
          if(GA[j] === k){
            if(GB[j] === l && guard++ < 32){ Check = 1; continue; }
          } else if(GA[j] === 'X'){
            var RY = k * GB[j] + l;
            if(GB[j] >= NX && RY >= Dom[j][2] && RY <= Dom[j][3]) Count += 1;
          } else {
            var RX = (GB[j] - l) / (k - GA[j]);
            if(RX >= NX && RX >= Dom[j][0] && RX <= Dom[j][1]) Count += 1;
          }
          break;
        }
      }
      Ret.push(mod(Count, 2) === 0 ? 0 : 2);
    }
    return Ret;
  }
  function CS_CropPath(S, Path, Outside){
    if(isNil(S)) err('도형이 필요합니다');
    if(isNil(Outside)) Outside = 0;
    var hit = pathHits(S, Path);
    var R = [0], C = 0;
    for(var i = 1; i <= S[0]; i++){
      var keep = Outside === 0 ? hit[i - 1] > 0 : hit[i - 1] === 0;
      if(keep){ R.push([S[i][0], S[i][1]]); C += 1; }
    }
    R[0] = C;
    return R;
  }
  /* 안(2)/변(1)/밖(0) 세기 — 편집기의 "검사"에 씁니다 */
  function CS_CountPath(S, Path){
    var hit = pathHits(S, Path), c = [0, 0, 0];
    for(var i = 0; i < hit.length; i++) c[hit[i]] += 1;
    return { out: c[0], edge: c[1], inside: c[2] };
  }

  function CS_CropGraphXY(S, Ratio, funcXY, Sign, Edge){
    var Rt = ratioXY(Ratio), XR = Rt[0], YR = Rt[1];
    var f = resolveFunc(funcXY, 'funcXY');
    if(isNil(S)) err('도형이 필요합니다');
    if(isNil(Edge)) Edge = 0;
    if(isNil(Sign)) Sign = 0;
    var R = [0], C = 0;
    for(var i = 1; i <= S[0]; i++){
      var NX = S[i][0], NY = S[i][1];
      var T = f(NX / XR, NY / YR), keep;
      if(Edge === 0) keep = (T >= 0 && Sign === 0) || (T <= 0 && Sign === 1);
      else keep = (T > 0 && Sign === 0) || (T < 0 && Sign === 1);
      if(keep){ R.push([NX, NY]); C += 1; }
    }
    R[0] = C;
    return R;
  }
  function CS_CropGraphRA(S, Ratio, funcRA, Sign, Edge){
    var XR, YR;
    if(typeof Ratio === 'number'){ XR = Ratio; YR = 1; }
    else { var Rt = ratioXY(Ratio); XR = Rt[0]; YR = Rt[1]; }
    var f = resolveFunc(funcRA, 'funcRA');
    if(isNil(S)) err('도형이 필요합니다');
    if(isNil(Edge)) Edge = 0;
    if(isNil(Sign)) Sign = 0;
    var R = [0], C = 0;
    for(var i = 1; i <= S[0]; i++){
      var NX = S[i][0], NY = S[i][1];
      var T = f(polarR(NX, NY) / XR, polarA(NX, NY) / YR), keep;
      if(Edge === 0) keep = (T >= 0 && Sign === 0) || (T <= 0 && Sign === 1);
      else keep = (T > 0 && Sign === 0) || (T < 0 && Sign === 1);
      if(keep){ R.push([NX, NY]); C += 1; }
    }
    R[0] = C;
    return R;
  }

  /* ---------- 경로 안쪽 채우기 ---------- */
  function pathBBox(Path){
    if(isNil(Path) || !Path[0]) err('기준이 될 경로(도형)가 필요합니다');
    var xn = Path[1][0], xx = Path[1][0], yn = Path[1][1], yx = Path[1][1];
    for(var i = 1; i <= Path[0]; i++){
      if(Path[i][0] > xx) xx = Path[i][0];
      if(Path[i][0] < xn) xn = Path[i][0];
      if(Path[i][1] > yx) yx = Path[i][1];
      if(Path[i][1] < yn) yn = Path[i][1];
    }
    return [xn, xx, yn, yx];
  }
  function CS_FillPathXY(Path, Edge, sizeX, sizeY, Outside){
    var b = pathBBox(Path);
    return CS_CropPath(CS_FillXY(Edge, [b[0], b[1]], [b[2], b[3]], sizeX, sizeY), Path, Outside);
  }
  function CS_FillPathHX(Path, Edge, sizeX, sizeY, Direction, Outside){
    var b = pathBBox(Path);
    return CS_CropPath(CS_FillHX(Edge, [b[0], b[1]], [b[2], b[3]], sizeX, sizeY, Direction), Path, Outside);
  }
  function CS_FillPathRD(Path, Edge, sizeX, sizeY, StackSizeX, StackSizeY, Outside){
    var b = pathBBox(Path);
    return CS_CropPath(CS_FillRD(Edge, [b[0], b[1]], [b[2], b[3]], sizeX, sizeY, StackSizeX, StackSizeY), Path, Outside);
  }
  function CS_FillPathRA(Path, Edge, sizeR, sizeA, Outside){
    if(isNil(Path) || !Path[0]) err('기준이 될 경로(도형)가 필요합니다');
    var Rmin = polarR(Path[1][0], Path[1][1]), Rmax = Rmin;
    for(var i = 1; i <= Path[0]; i++){
      var r = polarR(Path[i][0], Path[i][1]);
      if(r > Rmax) Rmax = r;
      if(r < Rmin) Rmin = r;
    }
    return CS_CropPath(CS_FillRA(Edge, [Rmin, Rmax], [0, 360], sizeR, sizeA), Path, Outside);
  }

  /* ---------- 벡터 함수 ---------- */
  function vecPair(v, name){
    if(!v || typeof v[0] !== 'number' || typeof v[1] !== 'number') err(name + '는 {a, b} 두 값을 돌려줘야 합니다');
    return v;
  }
  function CS_Vector2D(S, Ratio, VectorFunc){
    var R = ratioXY(Ratio), XR = R[0], YR = R[1];
    var f = resolveFunc(VectorFunc, 'VectorFunc');
    var Ret = [S[0]];
    for(var i = 1; i <= S[0]; i++){
      var v = vecPair(f(S[i][0] / XR, S[i][1] / YR), 'VectorFunc');
      Ret.push([v[0] * XR, v[1] * YR]);
    }
    return Ret;
  }
  function CS_Vector2DPolar(S, Ratio, VectorFunc){
    var R = ratioXY(Ratio), XR = R[0], YR = R[1];
    var f = resolveFunc(VectorFunc, 'VectorFunc');
    var Ret = [S[0]];
    for(var i = 1; i <= S[0]; i++){
      var NX = S[i][0] / XR, NY = S[i][1] / YR;
      var v = vecPair(f(polarR(NX, NY), polarA(NX, NY)), 'VectorFunc');
      Ret.push([v[0] * Math.cos(v[1]) * XR, v[0] * Math.sin(v[1]) * YR]);
    }
    return Ret;
  }

  /* ---------- 사다리꼴 왜곡 ---------- */
  function mulPair(m){
    if(typeof m === 'number') err('왜곡 배율은 {X, Y} 두 값이어야 합니다');
    if(isNil(m)) return [1, 1];
    return [isNil(m[0]) ? 1 : m[0], isNil(m[1]) ? 1 : m[1]];
  }
  function CS_Distortion(S, mulLU, mulLD, mulRU, mulRD, CenterXY){
    if(isNil(S) || !S[0]) err('도형이 필요합니다');
    var xn = S[1][0], xx = S[1][0], yn = S[1][1], yx = S[1][1], i;
    for(i = 1; i <= S[0]; i++){
      if(S[i][0] > xx) xx = S[i][0];
      if(S[i][0] < xn) xn = S[i][0];
      if(S[i][1] > yx) yx = S[i][1];
      if(S[i][1] < yn) yn = S[i][1];
    }
    if(xx === xn || yx === yn) err('왜곡은 가로·세로 폭이 모두 있는 도형에만 쓸 수 있습니다');
    var XC = (xx + xn) / 2, YC = (yx + yn) / 2;
    var dx = 0, dy = 0, useC = false;
    if(!isNil(CenterXY)){
      if(typeof CenterXY === 'number') err('CenterXY는 {X, Y}여야 합니다');
      dx = isNil(CenterXY[0]) ? 0 : CenterXY[0];
      dy = isNil(CenterXY[1]) ? 0 : CenterXY[1];
      useC = true;
    }
    var LU = mulPair(mulLU), LD = mulPair(mulLD), RU = mulPair(mulRU), RD = mulPair(mulRD);
    var XLU = LU[0], YLU = LU[1], XLD = LD[0], YLD = LD[1];
    var XRU = RU[0], YRU = RU[1], XRD = RD[0], YRD = RD[1];
    var Ret = [S[0]];
    for(i = 1; i <= S[0]; i++){
      var NX = S[i][0], NY = S[i][1];
      var ax = useC ? NX + dx : NX, ay = useC ? NY + dy : NY;
      var Y1 = (yx - YC) * YLU + YC, Y2 = (yx - YC) * YRU + YC;
      var R1Y = ((NY - yn) / (yx - yn)) * (Y1 + ((Y2 - Y1) / (xx - xn)) * (ax - xn));
      Y1 = (yn - YC) * YLD + YC; Y2 = (yn - YC) * YRD + YC;
      var R2Y = ((yx - NY) / (yx - yn)) * (Y1 + ((Y2 - Y1) / (xx - xn)) * (ax - xn));
      var X1 = (xx - XC) * XRD + XC, X2 = (xx - XC) * XRU + XC;
      var R3X = ((NX - xn) / (xx - xn)) * (X1 + ((X2 - X1) / (yx - yn)) * (ay - yn));
      X1 = (xn - XC) * XLD + XC; X2 = (xn - XC) * XLU + XC;
      var R4X = ((xx - NX) / (xx - xn)) * (X1 + ((X2 - X1) / (yx - yn)) * (ay - yn));
      Ret.push([R3X + R4X + XC, R1Y + R2Y + YC]);
    }
    return Ret;
  }

  /* ---------- 점 추가 ---------- */
  function CS_Add(S, Ratio, PathData){
    var R = ratioXY(Ratio), XR = R[0], YR = R[1];
    var rest = Array.prototype.slice.call(arguments, 2);
    var head = rest.shift(), list = [];
    if(isNil(head)) err('추가할 점이 필요합니다');
    if(typeof head[0] === 'number') list.push(head);
    else for(var i = 0; i < head.length; i++) list.push(head[i]);
    for(var k = 0; k < rest.length; k++) list.push(rest[k]);
    var Ret = [0];
    for(var j = 1; j <= S[0]; j++) Ret.push([S[j][0], S[j][1]]);
    for(var m = 0; m < list.length; m++) Ret.push([list[m][0] * XR, list[m][1] * YR]);
    Ret[0] = S[0] + list.length;
    return Ret;
  }

  /* ---------- 경로 위 등간격 점 (CS_Addon.lua) ---------- */
  function CS_PathInPath(Path, Number, funcN, PerSegment, Clamp, Closed){
    if(isNil(Path) || Path[0] < 2) err('점이 2개 이상인 경로가 필요합니다');
    makeGuard(Number);
    var P = [Path[0]];
    for(var q = 1; q <= Path[0]; q++) P.push([Path[q][0], Path[q][1]]);
    if(!(Closed === 0 || isNil(Closed))){ P.push([P[1][0], P[1][1]]); P[0] += 1; }
    var f = isNil(funcN) ? null : resolveFunc(funcN, 'funcN');
    var Llist = [], i, k;
    for(i = 1; i <= Number; i++){
      if(!f) Llist.push((i - 1) / Number);
      else {
        var t = f(i, Number, P[0]);
        if(t > 1 || t < 0){ if(!(Clamp === 0 || isNil(Clamp))) Llist.push(mod(t, 1)); }
        else Llist.push(t);
      }
    }
    var Ret = [0];
    if(PerSegment === 0 || isNil(PerSegment)){
      var LStack = [0];
      for(i = 1; i <= P[0] - 1; i++){
        var d = Math.sqrt(Math.pow(P[i + 1][0] - P[i][0], 2) + Math.pow(P[i + 1][1] - P[i][1], 2));
        LStack.push(d + LStack[i - 1]);
      }
      var LT = LStack[LStack.length - 1];
      if(!LT) err('경로 길이가 0입니다');
      var LR = LStack.map(function(v){ return v / LT; });
      for(k = 0; k < Llist.length; k++){
        var v = Llist[k], s = 0;
        for(i = 0; i < LR.length - 1; i++){ s = i; if(v <= LR[i + 1]) break; }
        var den = LR[s + 1] - LR[s];
        v = den === 0 ? 0 : (v - LR[s]) / den;
        var A = P[s + 1], B = P[s + 2];
        Ret.push([(1 - v) * A[0] + v * B[0], (1 - v) * A[1] + v * B[1]]);
        Ret[0] += 1;
      }
    } else {
      if(Number * (P[0] - 1) > CS_LIMIT) err('결과가 너무 많습니다');
      for(i = 1; i <= P[0] - 1; i++){
        var C = P[i], D = P[i + 1];
        for(k = 0; k < Llist.length; k++){
          var w = Llist[k];
          Ret.push([(1 - w) * C[0] + w * D[0], (1 - w) * C[1] + w * D[1]]);
          Ret[0] += 1;
        }
      }
    }
    return Ret;
  }

  /* ---------- 측정 ---------- */
  function CS_GetXmax(S){ return getXmax(S); }
  function CS_GetXmin(S){ return getXmin(S); }
  function CS_GetYmax(S){ return getYmax(S); }
  function CS_GetYmin(S){ return getYmin(S); }
  function CS_GetXCntr(S){ return (getXmax(S) + getXmin(S)) / 2; }
  function CS_GetYCntr(S){ return (getYmax(S) + getYmin(S)) / 2; }
  function CS_GetRadius(X, Y){ return polarR(X, Y); }
  function CS_GetAngle(X, Y){ return polarA(X, Y); }
