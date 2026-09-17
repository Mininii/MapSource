  /* ==================== 수식 프리셋 ====================
     "무슨 함수를 써야 하나"를 고민하지 않도록, 자리마다 쓸 만한 식을 미리 담아 둡니다.
     [이름, 식, 같이 맞춰 줄 다른 인자] — 인자는 그 생성기의 이름표로 찾습니다. */
  var PRESETS = {
    /* y = f(x) */
    fx: [['곡선', [
      ['포물선',        'x*x/64',                                    {Start:-96, StepSize:12, StepRange:12, Number:24}],
      ['세제곱',        'x*x*x/4096',                                {Start:-96, StepSize:12, StepRange:12, Number:24}],
      ['절댓값 V',      'math.abs(x)',                               {Start:-96, StepSize:12, StepRange:12, Number:20}],
      ['반원 (위)',     'math.sqrt(math.max(0, 9216 - x*x))',        {Start:-95, StepSize:12, StepRange:12, Number:20}],
      ['현수선',        '48*(math.exp(x/64) + math.exp(-x/64)) - 96',{Start:-96, StepSize:12, StepRange:12, Number:22}],
      ['쌍곡선',        '3072/x',                                    {Start:16,  StepSize:12, StepRange:12, Number:20}]]],
      ['물결', [
      ['사인파',        '40*math.sin(x/24)',                         {Start:-128, StepSize:10, StepRange:10, Number:30}],
      ['감쇠 진동',     '56*math.sin(x/16)*math.exp(-x/128)',        {Start:-64,  StepSize:10, StepRange:10, Number:30}],
      ['삼각파',        '96*math.abs(x/64 - math.floor(x/64 + 0.5)) - 24', {Start:-128, StepSize:10, StepRange:10, Number:30}],
      ['가우시안 언덕', '80*math.exp(-x*x/2048)',                    {Start:-96,  StepSize:10, StepRange:10, Number:26}],
      ['맥놀이',        '32*math.sin(x/12) + 32*math.sin(x/40)',     {Start:-128, StepSize:10, StepRange:10, Number:32}]]]],

    /* x = f(y) — 위 목록을 세로로 세운 것 */
    fy: [['곡선', [
      ['포물선',        'y*y/64',                                    {Start:-96, StepSize:12, StepRange:12, Number:24}],
      ['절댓값 V',      'math.abs(y)',                               {Start:-96, StepSize:12, StepRange:12, Number:20}],
      ['반원 (오른쪽)', 'math.sqrt(math.max(0, 9216 - y*y))',        {Start:-95, StepSize:12, StepRange:12, Number:20}],
      ['현수선',        '48*(math.exp(y/64) + math.exp(-y/64)) - 96',{Start:-96, StepSize:12, StepRange:12, Number:22}]]],
      ['물결', [
      ['사인파',        '40*math.sin(y/24)',                         {Start:-128, StepSize:10, StepRange:10, Number:30}],
      ['감쇠 진동',     '56*math.sin(y/16)*math.exp(-y/128)',        {Start:-64,  StepSize:10, StepRange:10, Number:30}],
      ['가우시안 언덕', '80*math.exp(-y*y/2048)',                    {Start:-96,  StepSize:10, StepRange:10, Number:26}]]]],

    /* r = f(a) — a 는 라디안 */
    fa: [['기본', [
      ['원',            '80',                                        {Start:0, StepSize:12, StepRange:null, Number:44}],
      ['타원',          '80*64/math.sqrt(64*64*math.cos(a)^2 + 80*80*math.sin(a)^2)', {Start:0, StepSize:10, StepRange:null, Number:48}],
      ['정오각형',      '80*math.cos(math.pi/5)/math.cos(a % (2*math.pi/5) - math.pi/5)', {Start:0, StepSize:10, StepRange:null, Number:52}],
      ['정육각형',      '80*math.cos(math.pi/6)/math.cos(a % (2*math.pi/6) - math.pi/6)', {Start:0, StepSize:10, StepRange:null, Number:52}],
      ['둥근 사각형',   '84/(math.abs(math.cos(a))^4 + math.abs(math.sin(a))^4)^0.25', {Start:0, StepSize:10, StepRange:null, Number:52}]]],
      ['꽃 · 별', [
      ['장미 3잎',      '88*math.cos(1.5*a)',                        {Start:0, StepSize:9,  StepRange:null, Number:72}],
      ['장미 4잎',      '88*math.cos(2*a)',                          {Start:0, StepSize:9,  StepRange:null, Number:72}],
      ['장미 5잎',      '88*math.cos(2.5*a)',                        {Start:0, StepSize:9,  StepRange:null, Number:80}],
      ['장미 8잎',      '88*math.cos(4*a)',                          {Start:0, StepSize:9,  StepRange:null, Number:88}],
      ['꽃잎 6장',      '64 + 28*math.cos(6*a)',                     {Start:0, StepSize:9,  StepRange:null, Number:64}],
      ['별 5각',        '72 + 32*math.cos(5*a)',                     {Start:0, StepSize:9,  StepRange:null, Number:64}],
      ['톱니 기어',     '80 + 10*math.cos(16*a)',                    {Start:0, StepSize:7,  StepRange:null, Number:88}]]],
      ['고전 곡선', [
      ['심장형',        '48*(1 - math.cos(a))',                      {Start:0, StepSize:10, StepRange:null, Number:44}],
      ['리마송',        '40 + 68*math.cos(a)',                       {Start:0, StepSize:10, StepRange:null, Number:52}],
      ['렘니스케이트',  '104*math.sqrt(math.abs(math.cos(2*a)))',    {Start:0, StepSize:9,  StepRange:null, Number:56}],
      ['아르키메데스 나선', '9*a',                                   {Start:0, StepSize:11, StepRange:null, Number:56}],
      ['로그 나선',     '7*math.exp(0.19*a)',                        {Start:0, StepSize:11, StepRange:null, Number:44}]]]],

    /* a = f(r) — 라디안을 돌려줍니다 */
    fr: [['나선', [
      ['아르키메데스',  'r/22',                                      {Start:8,  StepSize:12, StepRange:6, Number:44}],
      ['페르마',        'math.sqrt(r)/1.6',                          {Start:4,  StepSize:12, StepRange:6, Number:40}],
      ['쌍곡 나선',     '900/r',                                     {Start:24, StepSize:12, StepRange:6, Number:32}],
      ['리투스',        '9000/(r*r)',                                {Start:24, StepSize:12, StepRange:6, Number:28}],
      ['촘촘한 소용돌이','r/9',                                      {Start:8,  StepSize:10, StepRange:5, Number:56}]]]],

    /* (x(t), y(t)) */
    ft: [['닫힌 곡선', [
      ['원',            '{96*math.cos(t), 96*math.sin(t)}',          {Start:0, StepSize:12, StepRange:0.3, Number:44}],
      ['타원',          '{104*math.cos(t), 64*math.sin(t)}',         {Start:0, StepSize:11, StepRange:0.3, Number:44}],
      ['아스트로이드 (4각별)', '{96*math.cos(t)^3, 96*math.sin(t)^3}', {Start:0, StepSize:10, StepRange:0.25, Number:48}],
      ['하트',          '{64*math.sin(t)^3, -(52*math.cos(t) - 20*math.cos(2*t) - 8*math.cos(3*t) - 4*math.cos(4*t))}', {Start:0, StepSize:10, StepRange:0.25, Number:52}],
      ['하이포사이클로이드 (5각별)', '{80*math.cos(t) + 20*math.cos(4*t), 80*math.sin(t) - 20*math.sin(4*t)}', {Start:0, StepSize:10, StepRange:0.2, Number:56}],
      ['에피사이클로이드 (5잎)', '{88*math.cos(t) - 16*math.cos(6*t), 88*math.sin(t) - 16*math.sin(6*t)}', {Start:0, StepSize:10, StepRange:0.2, Number:60}]]],
      ['리사주', [
      ['1 : 2 (8자)',   '{96*math.sin(2*t), 80*math.sin(t)}',        {Start:0, StepSize:11, StepRange:0.3, Number:44}],
      ['3 : 2',         '{96*math.sin(3*t), 80*math.sin(2*t)}',      {Start:0, StepSize:10, StepRange:0.25, Number:56}],
      ['3 : 4',         '{96*math.cos(3*t), 72*math.sin(4*t)}',      {Start:0, StepSize:9,  StepRange:0.2,  Number:72}],
      ['5 : 4',         '{96*math.cos(5*t), 88*math.sin(4*t)}',      {Start:0, StepSize:9,  StepRange:0.2,  Number:80}]]],
      ['열린 곡선', [
      ['나선',          '{(8 + 4*t)*math.cos(t), (8 + 4*t)*math.sin(t)}', {Start:0, StepSize:11, StepRange:0.4, Number:52}],
      ['사이클로이드',  '{18*(t - math.sin(t)) - 96, 18*(1 - math.cos(t))}', {Start:0, StepSize:11, StepRange:0.3, Number:40}],
      ['나비',          '{28*math.sin(t)*(math.exp(math.cos(t)) - 2*math.cos(4*t)), -28*math.cos(t)*(math.exp(math.cos(t)) - 2*math.cos(4*t))}', {Start:0, StepSize:9, StepRange:0.2, Number:80}]]]],

    /* f(x,y) → {x,y} : 점을 옮기는 벡터장 */
    vxy: [['간단한 변환', [
      ['90도 회전',     '{-y, x}'],
      ['좌우 뒤집기',   '{-x, y}'],
      ['가로로 밀기',   '{x + y/2, y}'],
      ['가로만 늘리기', '{x*1.5, y}']]],
      ['휘게 하기', [
      ['물결 (가로)',   '{x + 16*math.sin(y/24), y}'],
      ['물결 (세로)',   '{x, y + 16*math.sin(x/24)}'],
      ['부풀리기',      '{x*(1 + (x*x + y*y)/60000), y*(1 + (x*x + y*y)/60000)}'],
      ['오목하게',      '{x*(1 - (x*x + y*y)/60000), y*(1 - (x*x + y*y)/60000)}'],
      ['원 반전',       '{x*9216/(x*x + y*y + 1), y*9216/(x*x + y*y + 1)}'],
      ['제곱 사상',     '{(x*x - y*y)/128, 2*x*y/128}']]]],

    /* f(r,a) → {r,a} : 극좌표 벡터장 */
    vra: [['비틀기', [
      ['소용돌이',      '{r, a + r/400}'],
      ['센 소용돌이',   '{r, a + r/120}'],
      ['각도 두 배',    '{r, a*2}'],
      ['각도 절반',     '{r, a/2}']]],
      ['반지름 손보기', [
      ['가운데로 모으기','{math.sqrt(r)*9, a}'],
      ['바깥으로 밀기', '{r*r/96, a}'],
      ['도넛',          '{r/2 + 56, a}'],
      ['물결 테두리',   '{r + 14*math.sin(6*a), a}'],
      ['꽃 테두리',     '{r*(1 + 0.3*math.cos(5*a)), a}']]]],

    /* f(x,y) : 0 이상인 곳을 남깁니다 */
    gxy: [['영역', [
      ['원 안쪽',       '16384 - x*x - y*y'],
      ['마름모 안쪽',   '128 - math.abs(x) - math.abs(y)'],
      ['둥근 사각형',   '1 - (math.abs(x)/128)^4 - (math.abs(y)/96)^4'],
      ['위쪽 반',       '-y'],
      ['대각선 위',     'y - x']]],
      ['띠 · 무늬', [
      ['사인 띠',       '40 - math.abs(y - 56*math.sin(x/32))'],
      ['가로 줄무늬',   'math.sin(y/12)'],
      ['체크무늬',      'math.sin(x/16)*math.sin(y/16)'],
      ['고리',          '4096 - math.abs(x*x + y*y - 12288)']]]],

    /* f(r,a) : 0 이상인 곳을 남깁니다 */
    gra: [['영역', [
      ['원 안쪽',       '96 - r'],
      ['도넛',          '32 - math.abs(r - 72)'],
      ['부채꼴',        'math.pi/3 - math.abs(a - math.pi/2)']]],
      ['무늬', [
      ['꽃 안쪽',       '64 + 28*math.cos(6*a) - r'],
      ['별 안쪽',       '72 + 32*math.cos(5*a) - r'],
      ['나선 띠',       '14 - math.abs(r - 9*a)'],
      ['부챗살',        'math.cos(8*a)']]]],

    /* f(i,n,c) → 0~1 : 경로 위 어디에 점을 놓을지 */
    fn: [['간격', [
      ['균등 (기본값)', '(i-1)/n'],
      ['양끝 촘촘',     '(1 - math.cos(math.pi*(i-1)/n))/2'],
      ['앞쪽 촘촘',     '((i-1)/n)^2'],
      ['뒤쪽 촘촘',     '1 - (1 - (i-1)/n)^2'],
      ['가운데 촘촘',   '(i-1)/n + 0.16*math.sin(2*math.pi*(i-1)/n)']]]]
  };

  var PK_VARS = {
    fx:'x — 가로 좌표',            fy:'y — 세로 좌표',
    fa:'a — 각도(라디안, 0=오른쪽, 시계 반대)',
    fr:'r — 원점에서의 거리',      ft:'t — 매개변수',
    vxy:'x, y — 그 점의 좌표',     vra:'r, a — 그 점의 거리와 각도(라디안)',
    gxy:'x, y — 그 점의 좌표',     gra:'r, a — 그 점의 거리와 각도(라디안)',
    fn:'i — 몇 번째 점(1부터) · n — 전체 개수 · c — 경로의 꼭짓점 수'
  };
  var PK_RET = {
    fx:'세로 좌표 하나', fy:'가로 좌표 하나', fa:'원점에서의 거리 하나',
    fr:'각도(라디안) 하나', ft:'{ 가로, 세로 } 두 값',
    vxy:'{ 새 가로, 새 세로 } 두 값', vra:'{ 새 거리, 새 각도 } 두 값',
    gxy:'숫자 하나 — 0 이상인 점만 남습니다', gra:'숫자 하나 — 0 이상인 점만 남습니다',
    fn:'0 ~ 1 사이 숫자 — 경로의 어디쯤인지'
  };

  function presetList(pk){
    var out = [];
    (PRESETS[pk] || []).forEach(function(g){
      g[1].forEach(function(p){ out.push(p); });
    });
    return out;
  }
  function presetSelectHTML(pk, cur, attr, i){
    var idx = -1, k = 0;
    (PRESETS[pk] || []).forEach(function(g){
      g[1].forEach(function(p){ if(p[1] === cur) idx = k; k++; });
    });
    var out = '<select class="exprpick" data-pk="' + i + '" data-' + attr + '="' + i + '" aria-label="수식 고르기">' +
      '<option value=""' + (idx < 0 ? ' selected' : '') + '>' + (idx < 0 ? '직접 입력' : '고르기…') + '</option>';
    k = 0;
    (PRESETS[pk] || []).forEach(function(g){
      out += '<optgroup label="' + esc(g[0]) + '">';
      g[1].forEach(function(p){
        out += '<option value="' + k + '"' + (k === idx ? ' selected' : '') + '>' + esc(p[0]) + '</option>';
        k++;
      });
      out += '</optgroup>';
    });
    return out + '</select>';
  }
  /* 프리셋이 들고 있는 다른 인자 값도 같이 맞춰 줍니다 */
  function applyPreset(spec, arr, i, pk, choice){
    var p = presetList(pk)[choice];
    if(!p) return;
    arr[i] = p[1];
    var set = p[2];
    if(!set) return;
    spec.args.forEach(function(a, j){
      var key = a.n.split(' ')[0];
      if(Object.prototype.hasOwnProperty.call(set, a.n)) arr[j] = set[a.n];
      else if(Object.prototype.hasOwnProperty.call(set, key)) arr[j] = set[key];
    });
  }

  /* ---------- 수식 도움말 ---------- */
  var fndlg = document.getElementById('fndlg');
  function openFnHelp(pk){
    document.getElementById('fn-vars').textContent = PK_VARS[pk] || '—';
    document.getElementById('fn-ret').textContent = PK_RET[pk] || '—';
    var html = (PRESETS[pk] || []).map(function(g){
      return '<h4>' + esc(g[0]) + '</h4><table class="fn-tb">' + g[1].map(function(p){
        return '<tr><th>' + esc(p[0]) + '</th><td><code>' + esc(p[1]) + '</code></td></tr>';
      }).join('') + '</table>';
    }).join('');
    document.getElementById('fn-list').innerHTML = html || '<p class="hint">이 자리에는 미리 담아 둔 식이 없습니다.</p>';
    if(!fndlg.open) fndlg.showModal();
  }
  document.getElementById('fn-close').addEventListener('click', function(){ fndlg.close(); });
