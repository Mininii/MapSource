  /* ==================== 연산 정의 ==================== */
  var DIR    = [['0','작은→큰'],['1','큰→작은']];
  var SIDE   = [['0','기준 이상 남기기'],['1','기준 이하 남기기']];
  var PRI    = [['0','앞쪽 우선'],['1','뒤쪽 우선']];
  var EDGE   = [['1','가장자리 포함'],['0','가장자리 제외']];
  var INOUT  = [['0','안쪽 남기기'],['1','바깥쪽 남기기']];
  var SIGN   = [['0','f ≥ 0 인 곳'],['1','f ≤ 0 인 곳']];
  var STRICT = [['0','경계선 포함'],['1','경계선 제외']];
  var GDIR   = [['0','늘어나는 쪽'],['1','줄어드는 쪽']];
  var HXDIR  = [['0','가로 · 짝수줄 밀기'],['1','가로 · 홀수줄 밀기'],['2','세로 · 짝수줄 밀기'],['3','세로 · 홀수줄 밀기']];
  var YESNO  = [['0','아니오'],['1','예']];

  var OPS = {
    CS_Rotate:      {label:'회전', args:[{n:'Angle', d:45, u:'°'}]},
    CS_MoveXY:      {label:'이동 XY', args:[{n:'X', d:0},{n:'Y', d:0}]},
    CS_MoveRA:      {label:'이동 RA', args:[{n:'Radius', d:0},{n:'Angle', d:0, u:'°'}]},
    CS_MoveCenter:  {label:'중심 맞추기', args:[{n:'X', d:0},{n:'Y', d:0}]},
    CS_RatioXY:     {label:'배율 XY', args:[{n:'mulX', d:1, nil:true},{n:'mulY', d:1, nil:true}]},
    CS_RatioRA:     {label:'배율 RA', args:[{n:'mulR', d:1, nil:true},{n:'mulA', d:1, nil:true}]},
    CS_InvertXY:    {label:'반전 XY', args:[{n:'X', d:0, nil:true},{n:'Y', d:null, nil:true}]},
    CS_InvertRA:    {label:'반전 RA', args:[{n:'Radius', d:null, nil:true},{n:'Angle', d:0, nil:true, u:'°'}]},
    CS_Rotate3D:    {label:'3D 회전', args:[{n:'XY', d:0, u:'°'},{n:'YZ', d:45, u:'°'},{n:'ZX', d:0, u:'°'}]},
    CS_Distortion:  {label:'사다리꼴 왜곡', args:[
                      {n:'좌상 LU', pair:true, d:[1,1]},{n:'좌하 LD', pair:true, d:[1,1]},
                      {n:'우상 RU', pair:true, d:[1,1]},{n:'우하 RD', pair:true, d:[1,1]},
                      {n:'중심 이동', pair:true, d:null, nil:true}]},
    CS_Vector2D:      {label:'벡터 변환 XY', args:[
                      {n:'Ratio', d:1},
                      {n:'f(x,y)→{x,y}', expr:true, params:['x','y'], d:'{-y, x}'}]},
    CS_Vector2DPolar: {label:'벡터 변환 RA', args:[
                      {n:'Ratio', d:1},
                      {n:'f(r,a)→{r,a}', expr:true, params:['r','a'], d:'{r, a + r/400}'}]},
    CS_MirrorX:     {label:'거울 X', args:[{n:'X', d:0},{n:'Side', sel:SIDE},{n:'Size', d:0}]},
    CS_MirrorY:     {label:'거울 Y', args:[{n:'Y', d:0},{n:'Side', sel:SIDE},{n:'Size', d:0}]},
    CS_MirrorR:     {label:'거울 R', args:[{n:'Radius', d:128},{n:'Side', sel:SIDE},{n:'Size', d:0}]},
    CS_MirrorA:     {label:'거울 A', args:[{n:'Angle', d:0, u:'°'},{n:'Side', sel:SIDE},{n:'Size', d:0, u:'°'}]},
    CS_SymmetryX:   {label:'대칭 X', args:[{n:'Number', d:2, int:true},{n:'Xmin', d:null, nil:true},{n:'Xmax', d:null, nil:true}]},
    CS_SymmetryY:   {label:'대칭 Y', args:[{n:'Number', d:2, int:true},{n:'Ymin', d:null, nil:true},{n:'Ymax', d:null, nil:true}]},
    CS_SymmetryR:   {label:'대칭 R', args:[{n:'Number', d:2, int:true},{n:'Rmin', d:null, nil:true},{n:'Rmax', d:null, nil:true}]},
    CS_SymmetryA:   {label:'대칭 A', args:[{n:'Number', d:2, int:true},{n:'Amin', d:null, nil:true, u:'°'},{n:'Amax', d:null, nil:true, u:'°'}]},
    CS_Kaleidoscope:{label:'만화경', args:[{n:'Point', d:6, int:true},{n:'StartAngle', d:0, u:'°'},{n:'Side', sel:SIDE},{n:'Size', d:0, u:'°'}]},
    CS_CropXY:      {label:'잘라내기 XY', args:[
                      {n:'X 범위', pair:true, d:[-128,128], nil:true},
                      {n:'Y 범위', pair:true, d:[-128,128], nil:true},
                      {n:'X 경계', sel:STRICT},{n:'Y 경계', sel:STRICT}]},
    CS_CropRA:      {label:'잘라내기 RA', args:[
                      {n:'R 범위', pair:true, d:[0,128], nil:true},
                      {n:'A 범위(°)', pair:true, d:null, nil:true},
                      {n:'R 경계', sel:STRICT},{n:'A 경계', sel:STRICT}]},
    CS_CropPath:    {label:'도형으로 오려내기', args:[{n:'기준 도형', shape:true},{n:'남길 쪽', sel:INOUT}]},
    CS_CropGraphXY: {label:'식으로 오려내기 XY', args:[
                      {n:'Ratio', d:1},
                      {n:'f(x,y)', expr:true, params:['x','y'], d:'128*128 - x*x - y*y'},
                      {n:'부호', sel:SIGN},{n:'경계', sel:STRICT}]},
    CS_CropGraphRA: {label:'식으로 오려내기 RA', args:[
                      {n:'Ratio', d:1},
                      {n:'f(r,a)', expr:true, params:['r','a'], d:'96 - r'},
                      {n:'부호', sel:SIGN},{n:'경계', sel:STRICT}]},
    CS_PathInPath:  {label:'경로 위 등간격 점', args:[
                      {n:'Number', d:64, int:true},
                      {n:'f(i,n,c)', expr:true, params:['i','n','c'], d:null, nil:true},
                      {n:'변마다', sel:YESNO},{n:'벗어나면 감기', sel:YESNO},{n:'닫힌 경로', sel:YESNO, d:1}]},
    CS_Add:         {label:'점 보태기', args:[{n:'Ratio', d:1},{n:'좌표', pts:true, d:'{0,0}'}]},
    CS_RemoveStack: {label:'겹친 점 제거', args:[{n:'Size', d:8},{n:'Priority', sel:PRI}]},
    CS_SortX:       {label:'정렬 X', args:[{n:'Direction', sel:DIR}]},
    CS_SortY:       {label:'정렬 Y', args:[{n:'Direction', sel:DIR}]},
    CS_SortR:       {label:'정렬 R (반지름)', args:[{n:'Direction', sel:DIR}]},
    CS_SortA:       {label:'정렬 A (각도)', args:[{n:'Direction', sel:DIR}]},
    CS_Reverse:     {label:'순서 뒤집기', args:[]},
    CS_Shuffle:     {label:'무작위 섞기', args:[]},
    CS_Convert:     {label:'점 개수 바꾸기', args:[{n:'Number', d:32, int:true}]},
    CS_Round:       {label:'좌표 반올림', args:[{n:'Digit', d:2, int:true}]},
    CS_FixShape:    {label:'nan 좌표 0으로', args:[]}
  };
  var OP_GROUPS = [
    ['위치 · 크기', ['CS_MoveXY','CS_MoveRA','CS_MoveCenter','CS_Rotate','CS_Rotate3D','CS_RatioXY','CS_RatioRA','CS_InvertXY','CS_InvertRA','CS_Distortion','CS_Vector2D','CS_Vector2DPolar']],
    ['대칭 · 만화경', ['CS_MirrorX','CS_MirrorY','CS_MirrorR','CS_MirrorA','CS_SymmetryX','CS_SymmetryY','CS_SymmetryR','CS_SymmetryA','CS_Kaleidoscope']],
    ['오려내기', ['CS_CropXY','CS_CropRA','CS_CropPath','CS_CropGraphXY','CS_CropGraphRA']],
    ['점 늘리기 · 줄이기', ['CS_PathInPath','CS_Add','CS_Convert','CS_RemoveStack']],
    ['정리 · 순서', ['CS_SortX','CS_SortY','CS_SortR','CS_SortA','CS_Reverse','CS_Shuffle','CS_Round','CS_FixShape']]
  ];
  /* 원점(0,0)의 극좌표가 nan 이 되는 함수들 */
  var POLAR_OPS = ['CS_MoveRA','CS_RatioRA','CS_InvertRA','CS_MirrorR','CS_MirrorA','CS_SymmetryR','CS_SymmetryA',
                   'CS_Kaleidoscope','CS_SortR','CS_SortA','CS_CropRA','CS_CropGraphRA','CS_Vector2DPolar'];

  /* ==================== 생성기 정의 ==================== */
  /* lvl 이 있는 생성기는 Number·Hollow 를 CS_Level("종류", Point, 겹수) 로 적을 수 있습니다 */
  function lvArgs(numD, holD){
    return [{n:'Number', d:numD, int:true, lv:true}, {n:'Hollow', d:holD, int:true, lv:true}];
  }
  var GENS = {
    CSMakePolygon:  {label:'정다각형', lvl:'Polygon', args:[
      {n:'Point', d:6, int:true},{n:'Radius', d:32},{n:'Angle', d:0, u:'°'}].concat(lvArgs(31, 0))},
    CSMakePolygonX: {label:'정다각형 (테두리형)', lvl:'PolygonX', args:[
      {n:'Point', d:6, int:true},{n:'Radius', d:32},{n:'Angle', d:0, u:'°'}].concat(lvArgs(54, 0))},
    CSMakeCircle:   {label:'원', lvl:'Circle', args:[
      {n:'Point', d:12, int:true},{n:'Radius', d:32},{n:'Angle', d:0, u:'°'}].concat(lvArgs(61, 0))},
    CSMakeCircleX:  {label:'원 (테두리형)', lvl:'CircleX', args:[
      {n:'Point', d:12, int:true},{n:'Radius', d:32},{n:'Angle', d:0, u:'°'}].concat(lvArgs(108, 0))},
    CSMakeStar:     {label:'별', lvl:'Star', args:[
      {n:'Point', d:5, int:true},{n:'StarAngle', d:120, u:'°'},{n:'Radius', d:32},{n:'Angle', d:0, u:'°'}].concat(lvArgs(31, 0))},
    CSMakeStarX:    {label:'별 (테두리형)', lvl:'StarX', args:[
      {n:'Point', d:5, int:true},{n:'StarAngle', d:120, u:'°'},{n:'Radius', d:32},{n:'Angle', d:0, u:'°'}].concat(lvArgs(90, 0))},
    CSMakeCStar:    {label:'오목별', lvl:'CStar', args:[
      {n:'Point', d:5, int:true},{n:'StarAngle', d:120, u:'°'},{n:'Radius', d:32},{n:'Angle', d:0, u:'°'}].concat(lvArgs(31, 0))},
    CSMakeCStarX:   {label:'오목별 (테두리형)', lvl:'CStarX', args:[
      {n:'Point', d:5, int:true},{n:'StarAngle', d:120, u:'°'},{n:'Radius', d:32},{n:'Angle', d:0, u:'°'}].concat(lvArgs(90, 0))},
    CSMakeLine:     {label:'방사 직선', lvl:'Line', args:[
      {n:'Point', d:4, int:true},{n:'Radius', d:32},{n:'Angle', d:0, u:'°'}].concat(lvArgs(21, 0))},
    CSMakeLineX:    {label:'방사 직선 (테두리형)', lvl:'LineX', args:[
      {n:'Point', d:4, int:true},{n:'Radius', d:32},{n:'Angle', d:0, u:'°'}].concat(lvArgs(24, 0))},
    CSMakeSpiral:   {label:'나선', lvl:'Spiral', args:[
      {n:'Point', d:3, int:true},{n:'Magnificent', d:8},{n:'Coefficient', d:0.2},
      {n:'Radius', d:32},{n:'Angle', d:0, u:'°'}].concat(lvArgs(31, 0))},
    CSMakeSpiralX:  {label:'나선 (테두리형)', lvl:'SpiralX', args:[
      {n:'Point', d:3, int:true},{n:'Magnificent', d:8},{n:'Coefficient', d:0.2},
      {n:'Radius', d:32},{n:'Angle', d:0, u:'°'}].concat(lvArgs(36, 0))},

    CSMakeGraphX:   {label:'그래프 y = f(x)', args:[
      {n:'Ratio', d:1},{n:'f(x)', expr:true, params:['x'], d:'x*x/64'},
      {n:'Start', d:-96},{n:'방향', sel:GDIR},{n:'StepSize', d:12},{n:'StepRange', d:12, nil:true},{n:'Number', d:24, int:true}]},
    CSMakeGraphY:   {label:'그래프 x = f(y)', args:[
      {n:'Ratio', d:1},{n:'f(y)', expr:true, params:['y'], d:'y*y/64'},
      {n:'Start', d:-96},{n:'방향', sel:GDIR},{n:'StepSize', d:12},{n:'StepRange', d:12, nil:true},{n:'Number', d:24, int:true}]},
    CSMakeGraphA:   {label:'극좌표 r = f(a)', args:[
      {n:'Ratio', d:1},{n:'f(a) · a는 라디안', expr:true, params:['a'], d:'64 + 24*math.cos(5*a)'},
      {n:'Start', d:0},{n:'방향', sel:GDIR},{n:'StepSize', d:12},{n:'StepRange', d:null, nil:true},{n:'Number', d:48, int:true}]},
    CSMakeGraphR:   {label:'극좌표 a = f(r)', args:[
      {n:'Ratio', d:1},{n:'f(r) → 라디안', expr:true, params:['r'], d:'r/24'},
      {n:'Start', d:8},{n:'방향', sel:GDIR},{n:'StepSize', d:12},{n:'StepRange', d:6, nil:true},{n:'Number', d:40, int:true}]},
    CSMakeGraphT:   {label:'매개변수 (x(t), y(t))', args:[
      {n:'Ratio', d:1},{n:'f(t)→{x,y}', expr:true, params:['t'], d:'{64*math.cos(t), 40*math.sin(2*t)}'},
      {n:'Start', d:0},{n:'방향', sel:GDIR},{n:'StepSize', d:12},{n:'StepRange', d:0.4, nil:true},{n:'Number', d:48, int:true}]},

    CS_FillXY:      {label:'격자 채우기 XY', args:[
      {n:'Edge', sel:EDGE},{n:'X 범위', pair:true, d:[-96,96]},{n:'Y 범위', pair:true, d:[-96,96]},
      {n:'sizeX', d:16},{n:'sizeY', d:16}]},
    CS_FillRA:      {label:'격자 채우기 RA', args:[
      {n:'Edge', sel:EDGE},{n:'R 범위', pair:true, d:[0,96]},{n:'A 범위(°)', pair:true, d:[0,360]},
      {n:'sizeR', d:16},{n:'sizeA', d:15, u:'°'}]},
    CS_FillHX:      {label:'벌집 채우기', args:[
      {n:'Edge', sel:EDGE},{n:'X 범위', pair:true, d:[-96,96]},{n:'Y 범위', pair:true, d:[-96,96]},
      {n:'sizeX', d:16},{n:'sizeY', d:14},{n:'방향', sel:HXDIR}]},
    CS_FillRD:      {label:'무작위 채우기', args:[
      {n:'Edge', sel:EDGE},{n:'X 범위', pair:true, d:[-96,96]},{n:'Y 범위', pair:true, d:[-96,96]},
      {n:'sizeX', d:24},{n:'sizeY', d:24},{n:'겹침 X', d:8, nil:true},{n:'겹침 Y', d:8, nil:true}]},
    CSMakePath:     {label:'좌표 직접 적기', args:[{n:'좌표', pts:true, d:'{0,-32},{28,16},{-28,16}'}]}
  };
  var GEN_GROUPS = [
    ['도형', ['CSMakePolygon','CSMakePolygonX','CSMakeCircle','CSMakeCircleX','CSMakeStar','CSMakeStarX','CSMakeCStar','CSMakeCStarX','CSMakeLine','CSMakeLineX','CSMakeSpiral','CSMakeSpiralX']],
    ['그래프', ['CSMakeGraphX','CSMakeGraphY','CSMakeGraphA','CSMakeGraphR','CSMakeGraphT']],
    ['채우기', ['CS_FillXY','CS_FillRA','CS_FillHX','CS_FillRD']],
    ['직접', ['CSMakePath']]
  ];
  var POLAR_GENS = ['CS_FillRA','CSMakeGraphA','CSMakeGraphR','CSMakeSpiral','CSMakeSpiralX'];

  var JOINS = {
    overlap:  {fn:'CS_Overlap',   label:'겹치기 (그냥 이어붙임)', args:[]},
    merge:    {fn:'CS_Merge',     label:'합치기 (가까운 점 하나만)', args:[{n:'Size', d:8},{n:'Priority', sel:PRI}]},
    intersect:{fn:'CS_Intersect', label:'교집합 (겹치는 곳만)', args:[{n:'Size', d:8},{n:'Priority', sel:PRI}]},
    subtract: {fn:'CS_Subtract',  label:'차집합 (위 − 이 레이어)', args:[{n:'Size', d:8}]},
    xor:      {fn:'CS_Xor',       label:'XOR (겹치지 않는 곳만)', args:[{n:'Size', d:8}]}
  };

  function defArgs(spec){
    return spec.args.map(function(a){
      if(a.sel) return a.d === undefined ? Number(a.sel[0][0]) : Number(a.d);
      if(a.d === undefined) return 0;
      if(Array.isArray(a.d)) return a.d.slice();
      return a.d;
    });
  }
