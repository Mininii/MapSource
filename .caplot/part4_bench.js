  /* ==================== 작업대 모델 ==================== */
  var comp = { layers: [], final: [] };
  var uid = 1;
  var lastShapes = {};      /* 레이어별 마지막 계산 결과 — 점으로 굽기에 씁니다 */

  function stripLayer(L){ return { src:L.src, ops:L.ops, join:L.join, joinArgs:L.joinArgs, on:L.on }; }
  function snapOf(){ return JSON.stringify({ layers: comp.layers.map(stripLayer), final: comp.final }); }

  /* ---------- 되돌리기 · 다시 실행 ---------- */
  var undoStack = [], redoStack = [], lastSnap = null;
  function noteHistory(){
    var cur = snapOf();
    if(lastSnap === null){ lastSnap = cur; return; }
    if(cur === lastSnap) return;
    undoStack.push(lastSnap);
    if(undoStack.length > 80) undoStack.shift();
    redoStack.length = 0;
    lastSnap = cur;
  }
  function applySnap(json){
    var o = JSON.parse(json);
    comp = {
      layers: (o.layers || []).map(function(L){ L.id = uid++; return L; }),
      final: o.final || []
    };
    lastSnap = json;
    renderComp(true);
  }
  function undoComp(){
    if(!undoStack.length) return;
    redoStack.push(snapOf());
    applySnap(undoStack.pop());
  }
  function redoComp(){
    if(!redoStack.length) return;
    undoStack.push(snapOf());
    applySnap(redoStack.pop());
  }

  function loadComp(){
    var saved = lsGet(LSK.comp, null);
    if(saved && Array.isArray(saved.layers)){
      comp = { layers: saved.layers, final: Array.isArray(saved.final) ? saved.final : [] };
      comp.layers.forEach(function(L){
        L.id = uid++;
        if(!L.src || !L.src.kind) L.src = { kind:'expr', code:'' };
      });
    }
    lastSnap = snapOf();
  }
  function persistComp(){
    lsSet(LSK.comp, { layers: comp.layers.map(stripLayer), final: comp.final });
  }

  function newSrc(kind, arg){
    if(kind === 'gen'){
      var fn = GENS[arg] ? arg : 'CSMakePolygon';
      return { kind:'gen', fn:fn, args:defArgs(GENS[fn]) };
    }
    if(kind === 'points') return { kind:'points', pts:[] };
    if(kind === 'expr') return { kind:'expr', code: arg || 'CSMakeCircle(12, 32, 0, CS_Level("Circle", 12, 4), 0)' };
    return { kind:'shape', name: arg };
  }
  function addLayer(src){
    comp.layers.push({
      id: uid++, src: src, ops: [],
      join: 'overlap', joinArgs: defArgs(JOINS.overlap), on: true
    });
    renderComp();
    return comp.layers[comp.layers.length - 1];
  }

  function shapeOptions(sel){
    function opts(list){
      return list.map(function(s){
        return '<option value="' + esc(s.name) + '"' + (s.name === sel ? ' selected' : '') + '>' + esc(s.name) + ' · ' + s.n + 'pt</option>';
      }).join('');
    }
    return (custom.length ? '<optgroup label="내 도형">' + opts(custom) + '</optgroup>' : '') +
      '<optgroup label="44TRIG">' + opts(BUILTIN.filter(function(s){ return s.src === '44TRIG'; })) + '</optgroup>' +
      '<optgroup label="마린키우기 4vs4">' + opts(BUILTIN.filter(function(s){ return s.src === '4v4'; })) + '</optgroup>';
  }
  function fillPicker(){
    var sel = document.getElementById('c-pick');
    var keep = sel.value;
    sel.innerHTML = shapeOptions(null);
    if(keep && byName[keep]) sel.value = keep;
  }

  function opSelectHTML(selected, id){
    var out = '<select class="opname" ' + (id ? 'id="' + id + '"' : '') + ' aria-label="연산">';
    if(!selected) out += '<option value="">＋ 연산 추가…</option>';
    OP_GROUPS.forEach(function(g){
      out += '<optgroup label="' + g[0] + '">';
      g[1].forEach(function(fn){
        out += '<option value="' + fn + '"' + (fn === selected ? ' selected' : '') + '>' + OPS[fn].label + ' · ' + fn.replace('CS_','') + '</option>';
      });
      out += '</optgroup>';
    });
    return out + '</select>';
  }
  function genSelectHTML(selected){
    var out = '<select class="genname" aria-label="생성기">';
    GEN_GROUPS.forEach(function(g){
      out += '<optgroup label="' + g[0] + '">';
      g[1].forEach(function(fn){
        out += '<option value="' + fn + '"' + (fn === selected ? ' selected' : '') + '>' + GENS[fn].label + ' · ' + fn.replace('CS_','').replace('CSMake','') + '</option>';
      });
      out += '</optgroup>';
    });
    return out + '</select>';
  }

  /* Number·Hollow 를 CS_Level 로 적었을 때의 실제 개수 */
  function lvValue(spec, vals, i){
    var v = vals[i];
    if(!(v && typeof v === 'object')) return v;
    try{ return CSLib.CS_Level(spec.lvl, Math.round(Number(vals[0])), Math.max(1, Math.round(Number(v.lv)))); }
    catch(e){ return ''; }
  }

  function argFieldsHTML(spec, vals, attr){
    attr = attr || 'ai';
    return spec.args.map(function(a, i){
      var v = vals[i];
      var head = '<span>' + esc(a.n) + (a.u ? ' ' + a.u : '') + '</span>';
      if(a.sel){
        return '<span class="arg">' + head + '<select data-' + attr + '="' + i + '">' +
          a.sel.map(function(o){ return '<option value="' + o[0] + '"' + (String(v) === o[0] ? ' selected' : '') + '>' + esc(o[1]) + '</option>'; }).join('') +
          '</select></span>';
      }
      if(a.shape){
        return '<span class="arg">' + head + '<select class="shapein" data-' + attr + '="' + i + '">' +
          '<option value="">— 고르기 —</option>' + shapeOptions(v) + '</select></span>';
      }
      if(a.expr){
        return '<span class="arg wide">' + head + '<input type="text" class="exprin" spellcheck="false" data-' + attr + '="' + i + '"' +
          ' value="' + esc(v === null || v === undefined ? '' : v) + '" placeholder="' + (a.nil ? 'nil' : '식') + '"></span>';
      }
      if(a.pts){
        return '<span class="arg wide">' + head + '<input type="text" class="ptsin" spellcheck="false" data-' + attr + '="' + i + '"' +
          ' value="' + esc(v === null || v === undefined ? '' : v) + '" placeholder="{0,0},{16,0}"></span>';
      }
      if(a.pair){
        var p0 = (v && v[0] !== null && v[0] !== undefined) ? v[0] : '';
        var p1 = (v && v[1] !== null && v[1] !== undefined) ? v[1] : '';
        return '<span class="arg pair">' + head +
          '<input type="number" step="any" data-' + attr + '="' + i + '" data-pi="0" value="' + p0 + '" placeholder="min">' +
          '<input type="number" step="any" data-' + attr + '="' + i + '" data-pi="1" value="' + p1 + '" placeholder="max"></span>';
      }
      if(a.lv){
        var isLv = v && typeof v === 'object';
        var num = isLv ? lvValue(spec, vals, i) : (v === null || v === undefined ? '' : v);
        return '<span class="arg">' + head +
          '<input type="number" step="1" data-' + attr + '="' + i + '" value="' + num + '"' + (isLv ? ' readonly' : '') + '>' +
          '<span class="lvtag" title="CS_Level 로 겹 수를 적습니다">Lv</span>' +
          '<input type="number" step="1" min="1" class="lvin" data-' + attr + '="' + i + '" data-lv="1" value="' + (isLv ? v.lv : '') + '" placeholder="—">' +
          '</span>';
      }
      return '<span class="arg">' + head +
        '<input type="number" step="any" data-' + attr + '="' + i + '" value="' + (v === null || v === undefined ? '' : v) + '"' +
        (a.nil ? ' placeholder="nil"' : '') + '></span>';
    }).join('');
  }

  /* 입력 하나를 값 배열에 반영합니다. 다시 그려야 하면 true */
  function readArgInput(t, spec, arr, idx){
    var a = spec.args[idx];
    if(!a) return false;
    if(t.dataset.lv !== undefined){
      var raw = t.value.trim();
      if(raw === '') arr[idx] = lvValue(spec, arr, idx) || 0;
      else arr[idx] = { lv: Math.max(1, Math.round(Number(raw))) };
      return true;
    }
    if(a.pair){
      var cur = Array.isArray(arr[idx]) ? arr[idx].slice() : [null, null];
      cur[+t.dataset.pi] = t.value === '' ? null : Number(t.value);
      arr[idx] = (cur[0] === null && cur[1] === null) ? null : cur;
      return false;
    }
    if(a.expr || a.pts || a.shape){ arr[idx] = t.value; return false; }
    if(a.lv){
      arr[idx] = t.value === '' ? null : Number(t.value);
      return (arr[idx] !== null) && false;
    }
    arr[idx] = t.value === '' ? null : Number(t.value);
    return false;
  }

  function opRowHTML(op, scope, idx){
    var spec = OPS[op.fn];
    if(!spec) return '';
    return '<div class="oprow" data-scope="' + scope + '" data-oi="' + idx + '">' +
      opSelectHTML(op.fn) + argFieldsHTML(spec, op.args) +
      '<span class="lactions">' +
      '<button class="icon-btn" type="button" data-act="op-up" title="위로">↑</button>' +
      '<button class="icon-btn" type="button" data-act="op-down" title="아래로">↓</button>' +
      '<button class="icon-btn" type="button" data-act="op-del" title="삭제">✕</button>' +
      '</span></div>';
  }

  function srcRowHTML(L){
    var k = L.src.kind, box;
    if(k === 'shape'){
      box = '<div class="srcbox"><select class="srcshape" aria-label="도형">' + shapeOptions(L.src.name) + '</select>' +
        '<button class="btn ghost" type="button" data-act="l-bake">점으로 굽기</button></div>';
    } else if(k === 'gen'){
      var spec = GENS[L.src.fn] || GENS.CSMakePolygon;
      box = '<div class="srcbox gen">' + genSelectHTML(L.src.fn) +
        argFieldsHTML(spec, L.src.args, 'si') +
        '<button class="btn ghost" type="button" data-act="l-bake">점으로 굽기</button></div>';
    } else if(k === 'points'){
      var n = (L.src.pts || []).length;
      box = '<div class="srcbox pts"><span class="ptsnote">직접 찍은 점 ' + n + '개</span>' +
        '<button class="btn" type="button" data-act="l-edit">점 편집</button></div>';
    } else {
      box = '<div class="srcbox"><input type="text" class="srccode" spellcheck="false" value="' + esc(L.src.code || '') +
        '" placeholder="CSMakeCircle(12, 32, 0, 61, 0)">' +
        '<button class="btn ghost" type="button" data-act="l-bake">점으로 굽기</button></div>';
    }
    return '<div class="srcrow"><span class="ctl-label">소스</span>' + box + '</div>';
  }

  var SRC_TAG = { shape:'도형', gen:'생성기', points:'직접', expr:'Lua' };
  function srcLabel(L){
    if(L.src.kind === 'shape') return L.src.name;
    if(L.src.kind === 'gen') return (GENS[L.src.fn] || {label:L.src.fn}).label;
    if(L.src.kind === 'points') return '직접 찍은 점';
    return L.src.code || '(빈 식)';
  }

  function renderComp(quiet){
    var host = document.getElementById('c-layers');
    document.getElementById('c-empty').hidden = comp.layers.length > 0;
    host.innerHTML = comp.layers.map(function(L, li){
      var jspec = JOINS[L.join];
      var joinbar = li === 0 ? '' :
        '<div class="joinbar" data-lid="' + L.id + '">' +
          '<span class="ctl-label">합치는 법</span>' +
          '<select class="join" aria-label="합치는 법">' +
            Object.keys(JOINS).map(function(k){
              return '<option value="' + k + '"' + (k === L.join ? ' selected' : '') + '>' + JOINS[k].label + '</option>';
            }).join('') +
          '</select>' +
          argFieldsHTML(jspec, L.joinArgs, 'ji') +
        '</div>';
      var txt = srcLabel(L);
      return joinbar +
        '<div class="layer' + (L.on ? '' : ' off') + '" data-lid="' + L.id + '">' +
          '<div class="layer-hd">' +
            '<span class="lidx">' + (li + 1) + '</span>' +
            '<span class="alias">' + SRC_TAG[L.src.kind] + '</span>' +
            '<span class="lsrc' + (L.src.kind === 'expr' ? ' expr' : '') + '" title="' + esc(txt) + '">' + esc(txt) + '</span>' +
            '<span class="lcount" data-role="count">—</span>' +
            '<span class="lactions">' +
              '<button class="icon-btn" type="button" data-act="l-toggle" title="' + (L.on ? '끄기' : '켜기') + '">' + (L.on ? '◉' : '○') + '</button>' +
              '<button class="icon-btn" type="button" data-act="l-copy" title="복제">⧉</button>' +
              '<button class="icon-btn" type="button" data-act="l-up" title="위로">↑</button>' +
              '<button class="icon-btn" type="button" data-act="l-down" title="아래로">↓</button>' +
              '<button class="icon-btn" type="button" data-act="l-del" title="삭제">✕</button>' +
            '</span>' +
          '</div>' +
          srcRowHTML(L) +
          '<div class="oplist">' + L.ops.map(function(op, oi){ return opRowHTML(op, 'L' + L.id, oi); }).join('') + '</div>' +
          '<div class="addop">' + opSelectHTML('', '') + '</div>' +
          '<div class="opnote" data-role="err" hidden></div>' +
        '</div>';
    }).join('');

    var fin = document.getElementById('c-final');
    fin.innerHTML = comp.final.map(function(op, oi){ return opRowHTML(op, 'F', oi); }).join('');
    document.getElementById('c-final-add').innerHTML = opSelectHTML('', '').replace(/^<select[^>]*>/, '').replace(/<\/select>$/, '');
    document.getElementById('c-final-add').value = '';

    document.getElementById('comp-badge').textContent = comp.layers.length;
    if(!quiet) noteHistory();
    document.getElementById('c-undo').disabled = !undoStack.length;
    document.getElementById('c-redo').disabled = !redoStack.length;
    persistComp();
    recompute();
  }

  /* ---------- 계산 ---------- */
  var exprCache = Object.create(null);
  function compileArg(src, params, label){
    var key = (params || []).join(',') + '|' + src;
    if(exprCache[key]) return exprCache[key];
    var fn;
    try{ fn = evalLua.compile(src, params || []); }
    catch(e){ throw new Error(label + ' 식: ' + (e && e.message ? e.message : e)); }
    if(Object.keys(exprCache).length > 300) exprCache = Object.create(null);
    exprCache[key] = fn;
    return fn;
  }
  function ptsToList(txt){
    var nums = (String(txt == null ? '' : txt).match(/-?\d+(?:\.\d+)?(?:[eE][+-]?\d+)?/g) || []).map(Number);
    if(nums.length % 2 === 1 && nums[0] === (nums.length - 1) / 2) nums = nums.slice(1);
    if(!nums.length || nums.length % 2 === 1) throw new Error('좌표는 x, y 짝으로 적어주세요');
    var out = [];
    for(var i = 0; i < nums.length; i += 2) out.push([nums[i], nums[i + 1]]);
    return out;
  }
  function argValues(spec, vals){
    return spec.args.map(function(a, i){
      var v = vals[i];
      if(a.strict) return Number(v) === 1 ? [1, 1] : null;
      if(a.shape){
        if(!v) throw new Error(a.n + ' : 기준이 될 도형을 골라주세요');
        var sh = byName[v];
        if(!sh) throw new Error('"' + v + '" 도형이 목록에 없습니다');
        return toCS(sh);
      }
      if(a.expr){
        if(v === null || v === undefined || String(v).trim() === '') return null;
        return compileArg(String(v), a.params, a.n);
      }
      if(a.pts) return ptsToList(v);
      if(a.pair){
        if(!v) return null;
        var x = (v[0] === null || v[0] === undefined || v[0] === '') ? null : Number(v[0]);
        var y = (v[1] === null || v[1] === undefined || v[1] === '') ? null : Number(v[1]);
        if(x === null && y === null) return null;
        return [x, y];
      }
      if(a.lv && v && typeof v === 'object') return lvValue(spec, vals, i);
      if(v === null || v === undefined || v === '') return null;
      return a.int ? Math.round(Number(v)) : Number(v);
    });
  }

  /* 계산을 시작하기 전에 결과 크기를 어림해서, 화면이 멈출 만한 연산은 미리 막습니다 */
  function guardOp(fn, args, n){
    var out = n;
    if(fn.indexOf('CS_Symmetry') === 0) out = n * Math.max(1, Math.floor(args[0] || 0));
    else if(fn === 'CS_Kaleidoscope') out = n * 2 * Math.max(1, Math.floor(args[0] || 0));
    else if(fn === 'CS_Convert') out = Math.max(0, Math.floor(args[0] || 0));
    else if(fn === 'CS_MirrorX' || fn === 'CS_MirrorY' || fn === 'CS_MirrorR' || fn === 'CS_MirrorA') out = n * 2;
    else if(fn === 'CS_PathInPath') out = Math.max(0, Math.floor(args[0] || 0)) * (args[2] === 1 ? n : 1);
    else if(fn === 'CS_Add') out = n + (args[1] ? args[1].length : 0);
    if(out > MAX_POINTS){
      throw new Error(OPS[fn].label + ' 결과가 ' + fmt(out) + '점이 됩니다 — ' + fmt(MAX_POINTS) + '점까지만 다룹니다.');
    }
    if(fn === 'CS_RemoveStack' && n * n > MAX_COMPARE){
      throw new Error('겹친 점 제거는 ' + fmt(n) + '점에 쓰기엔 너무 무겁습니다. 점을 줄인 뒤 다시 해보세요.');
    }
  }

  function applyOps(S, ops){
    ops.forEach(function(op){
      var spec = OPS[op.fn];
      if(!spec) throw new Error('알 수 없는 연산 ' + op.fn);
      var vals = argValues(spec, op.args);
      guardOp(op.fn, vals, S[0]);
      S = CSLib.normalize(CSLib[op.fn].apply(null, [S].concat(vals)));
      if(S[0] > MAX_POINTS) throw new Error(spec.label + ' 결과가 ' + fmt(S[0]) + '점입니다 — ' + fmt(MAX_POINTS) + '점까지만 다룹니다.');
    });
    return S;
  }

  function layerShape(L){
    var base;
    if(L.src.kind === 'shape'){
      var sh = byName[L.src.name];
      if(!sh) throw new Error('"' + L.src.name + '" 도형이 목록에 없습니다.');
      base = toCS(sh);
    } else if(L.src.kind === 'gen'){
      var spec = GENS[L.src.fn];
      if(!spec) throw new Error('알 수 없는 생성기 ' + L.src.fn);
      base = CSLib.normalize(CSLib[L.src.fn].apply(null, argValues(spec, L.src.args)));
    } else if(L.src.kind === 'points'){
      var pts = L.src.pts || [];
      if(!pts.length) throw new Error('찍은 점이 없습니다 — [점 편집]에서 점을 찍어주세요.');
      base = CSLib.normalize([pts.length].concat(pts.map(function(p){ return [p[0], p[1]]; })));
    } else {
      base = CSLib.normalize(evalLua(L.src.code));
    }
    if(base[0] > MAX_POINTS) throw new Error('소스가 ' + fmt(base[0]) + '점입니다 — ' + fmt(MAX_POINTS) + '점까지만 다룹니다.');
    return applyOps(base, L.ops);
  }

  function joinShapes(acc, S, L){
    var j = JOINS[L.join];
    if(j.fn !== 'CS_Overlap' && acc[0] * S[0] > MAX_COMPARE){
      throw new Error(j.label.split(' ')[0] + ' 연산에는 점이 너무 많습니다 (' + fmt(acc[0]) + ' × ' + fmt(S[0]) + '). 겹치기를 쓰거나 점을 줄여주세요.');
    }
    return CSLib.normalize(CSLib[j.fn].apply(null, [acc, S].concat(argValues(j, L.joinArgs))));
  }

  var result = null, resultErr = '';
  var recomputeTimer = null;
  function recompute(){
    clearTimeout(recomputeTimer);
    recomputeTimer = setTimeout(doCompute, 50);
  }

  function doCompute(){
    var acc = null; resultErr = '';
    var counts = {}, errs = {};
    lastShapes = {};
    var active = comp.layers.filter(function(L){ return L.on; });
    try{
      active.forEach(function(L){
        var S;
        try{ S = layerShape(L); }
        catch(e){ errs[L.id] = e && e.message ? e.message : String(e); throw e; }
        counts[L.id] = S[0];
        lastShapes[L.id] = S;
        acc = acc === null ? S : joinShapes(acc, S, L);
      });
      if(acc) acc = applyOps(acc, comp.final);
    }catch(e){
      resultErr = e && e.message ? e.message : String(e);
      acc = null;
    }
    result = acc;

    Array.prototype.forEach.call(document.querySelectorAll('#c-layers .layer'), function(el){
      var id = +el.dataset.lid;
      var c = el.querySelector('[data-role="count"]');
      if(c) c.textContent = counts[id] !== undefined ? counts[id] + ' pt' : '—';
      var er = el.querySelector('[data-role="err"]');
      if(er){ er.hidden = !errs[id]; er.textContent = errs[id] || ''; }
    });

    var errEl = document.getElementById('c-err');
    errEl.hidden = !resultErr;
    errEl.textContent = resultErr;

    var pts = result ? fromCS(result) : [];
    var bb = bboxOf(pts);
    document.getElementById('c-n').textContent = fmt(pts.length);
    document.getElementById('c-size').textContent = pts.length
      ? Math.round(bb[2] - bb[0]) + ' × ' + Math.round(bb[3] - bb[1]) : '—';
    document.getElementById('c-save').disabled = !pts.length;
    document.getElementById('c-copy').disabled = !pts.length;
    document.getElementById('c-lua').textContent = comp.layers.length ? luaCode(compName()) : '—';
    compShape = pts.length ? { name:'결과', pts: pts, n: pts.length, bbox: bb, fam:'U' } : null;
    drawComp();
  }

  var compShape = null;
  function drawComp(){
    var cv = document.getElementById('cplot');
    drawShape(cv, compShape, plotOpts(20, { emptyText: comp.layers.length ? '결과 없음' : '레이어를 추가하세요' }));
  }

  /* ---------- Lua 코드 ---------- */
  function luaNum(v){
    if(v === null || v === undefined || v === '') return 'nil';
    var n = Number(v);
    if(!Number.isFinite(n)) return 'nil';
    return String(Math.round(n * 1e6) / 1e6);
  }
  function luaPts(list){
    return list.map(function(p){ return '{' + luaNum(p[0]) + ',' + luaNum(p[1]) + '}'; }).join(',');
  }
  /* 식 인자는 CB Paint 규칙대로 "이름 있는 전역 함수"로 뽑아 씁니다 */
  function makeFnCtx(base){
    var defs = [], map = Object.create(null), n = 0;
    return {
      defs: defs,
      name: function(src, params){
        var ps = (params || []).join(', ');
        var key = ps + '|' + src;
        if(map[key]) return map[key];
        n += 1;
        var nm = base + '_f' + n;
        map[key] = nm;
        defs.push('function ' + nm + '(' + ps + ') return ' + src + ' end');
        return nm;
      }
    };
  }
  function luaArgList(spec, vals, ctx){
    var out = spec.args.map(function(a, i){
      var v = vals[i];
      if(a.strict) return Number(v) === 1 ? '{1,1}' : 'nil';
      if(a.sel) return (v === null || v === undefined || v === '') ? 'nil' : String(Math.round(Number(v)));
      if(a.shape) return v ? String(v) : 'nil';
      if(a.expr){
        if(v === null || v === undefined || String(v).trim() === '') return 'nil';
        return '"' + ctx.name(String(v), a.params) + '"';
      }
      if(a.pts){
        try{ return '{' + luaPts(ptsToList(v)) + '}'; }
        catch(e){ return 'nil'; }
      }
      if(a.pair){
        if(!v || (v[0] === null && v[1] === null)) return 'nil';
        return '{' + luaNum(v[0]) + ',' + luaNum(v[1]) + '}';
      }
      if(a.lv && v && typeof v === 'object'){
        return 'CS_Level("' + spec.lvl + '", ' + luaNum(vals[0]) + ', ' + Math.max(1, Math.round(v.lv)) + ')';
      }
      return luaNum(v);
    });
    while(out.length && out[out.length - 1] === 'nil') out.pop();
    return out;
  }
  function layerSrcLua(L, ctx){
    if(L.src.kind === 'shape') return L.src.name;
    if(L.src.kind === 'gen'){
      var spec = GENS[L.src.fn];
      if(!spec) return 'nil';
      return L.src.fn + '(' + luaArgList(spec, L.src.args, ctx).join(', ') + ')';
    }
    if(L.src.kind === 'points') return 'CSMakePath(' + luaPts(L.src.pts || []) + ')';
    return '(' + (L.src.code || 'nil') + ')';
  }
  function luaCode(name){
    var active = comp.layers.filter(function(L){ return L.on; });
    if(!active.length) return '-- 켜져 있는 레이어가 없습니다';
    var ctx = makeFnCtx(name);
    var lines = [], usesPolar = false;
    active.forEach(function(L, i){
      var e = layerSrcLua(L, ctx);
      if(L.src.kind === 'gen' && POLAR_GENS.indexOf(L.src.fn) >= 0) usesPolar = true;
      L.ops.forEach(function(op){
        if(POLAR_OPS.indexOf(op.fn) >= 0) usesPolar = true;
        e = op.fn + '(' + [e].concat(luaArgList(OPS[op.fn], op.args, ctx)).join(', ') + ')';
      });
      lines.push('local L' + (i + 1) + ' = ' + e);
    });
    var acc = 'L1';
    active.forEach(function(L, i){
      if(i === 0) return;
      var j = JOINS[L.join];
      acc = j.fn + '(' + [acc, 'L' + (i + 1)].concat(luaArgList(j, L.joinArgs, ctx)).join(', ') + ')';
    });
    lines.push('local R = ' + acc);
    comp.final.forEach(function(op){
      if(POLAR_OPS.indexOf(op.fn) >= 0) usesPolar = true;
      lines.push('R = ' + op.fn + '(' + ['R'].concat(luaArgList(OPS[op.fn], op.args, ctx)).join(', ') + ')');
    });
    if(usesPolar) lines.push('R = CS_FixShape(R) -- 극좌표 연산에서 원점이 nan 이 되는 것 방지');
    lines.push(name + ' = R');
    return (ctx.defs.length ? ctx.defs.join('\n') + '\n\n' : '') + lines.join('\n');
  }

  /* ---------- 작업대 이벤트 ---------- */
  function layerById(id){
    for(var i = 0; i < comp.layers.length; i++) if(comp.layers[i].id === id) return { L: comp.layers[i], i: i };
    return null;
  }
  function scopeOps(scope){
    if(scope === 'F') return comp.final;
    var f = layerById(+scope.slice(1));
    return f ? f.L.ops : null;
  }

  document.getElementById('c-kind').addEventListener('change', function(){
    document.getElementById('c-pick').hidden = this.value !== 'shape';
  });
  document.getElementById('c-add').addEventListener('click', function(){
    var kind = document.getElementById('c-kind').value;
    if(kind === 'shape'){
      var v = document.getElementById('c-pick').value;
      if(!v || !byName[v]) return;
      addLayer(newSrc('shape', v));
      return;
    }
    var L = addLayer(newSrc(kind));
    if(kind === 'points') openPointEditor(L);
  });
  document.getElementById('c-undo').addEventListener('click', undoComp);
  document.getElementById('c-redo').addEventListener('click', redoComp);
  document.getElementById('c-clear').addEventListener('click', function(){
    if(!comp.layers.length && !comp.final.length) return;
    ask({ title:'작업대 비우기', msg:'레이어와 후처리 연산을 모두 지웁니다.', okText:'비우기', danger:true })
      .then(function(ok){
        if(!ok) return;
        comp = { layers: [], final: [] };
        renderComp();
      });
  });
  function compName(){
    var v = document.getElementById('c-name').value.trim();
    return /^[A-Za-z_][A-Za-z0-9_]*$/.test(v) ? v : 'MyShape';
  }
  document.getElementById('c-name').addEventListener('input', function(){
    if(comp.layers.length) document.getElementById('c-lua').textContent = luaCode(compName());
  });
  document.getElementById('c-copy').addEventListener('click', function(){
    copyText(luaCode(compName()), this, 'Lua 복사');
  });
  document.getElementById('c-save').addEventListener('click', function(){
    if(!result) return;
    var errEl = document.getElementById('c-err');
    function fail(m){ errEl.hidden = false; errEl.textContent = m; }
    var pts = fromCS(result);
    if(pts.length > MAX_POINTS){ fail(fmt(MAX_POINTS) + '점까지만 저장할 수 있습니다.'); return; }
    var v = document.getElementById('c-name').value.trim();
    var e = nameError(v, null);
    if(e){ fail(e); document.getElementById('c-name').focus(); return; }
    errEl.hidden = true;
    var btn = this; btn.disabled = true;
    saveShape({
      name: v, pts: pts,
      expr: '작업대 합성 · 레이어 ' + comp.layers.filter(function(L){ return L.on; }).length + '개',
      recipe: { layers: comp.layers.map(stripLayer), final: comp.final }
    }).then(function(){
      btn.disabled = false; btn.textContent = '저장됨';
      document.getElementById('c-name').value = '';
      setTimeout(function(){ btn.textContent = '저장'; }, 1500);
    }, function(err){
      btn.disabled = false;
      fail('저장하지 못했습니다: ' + (err && err.message ? err.message : err));
    });
  });

  document.getElementById('c-final-add').addEventListener('change', function(e){
    var fn = e.target.value;
    if(!fn) return;
    comp.final.push({ fn: fn, args: defArgs(OPS[fn]) });
    renderComp();
  });

  document.getElementById('c-layers').addEventListener('click', function(e){
    var btn = e.target.closest('button[data-act]');
    if(!btn) return;
    var act = btn.dataset.act;
    var row = btn.closest('.oprow');
    if(row){
      var ops = scopeOps(row.dataset.scope);
      if(!ops) return;
      var oi = +row.dataset.oi;
      if(act === 'op-del') ops.splice(oi, 1);
      if(act === 'op-up' && oi > 0){ var t = ops[oi-1]; ops[oi-1] = ops[oi]; ops[oi] = t; }
      if(act === 'op-down' && oi < ops.length - 1){ var t2 = ops[oi+1]; ops[oi+1] = ops[oi]; ops[oi] = t2; }
      renderComp();
      return;
    }
    var layerEl = btn.closest('.layer');
    if(!layerEl) return;
    var f = layerById(+layerEl.dataset.lid);
    if(!f) return;
    if(act === 'l-edit'){ openPointEditor(f.L); return; }
    if(act === 'l-bake'){ bakeLayer(f.L); return; }
    if(act === 'l-copy'){
      var clone = JSON.parse(JSON.stringify(stripLayer(f.L)));
      clone.id = uid++;
      comp.layers.splice(f.i + 1, 0, clone);
    }
    if(act === 'l-del') comp.layers.splice(f.i, 1);
    if(act === 'l-toggle') f.L.on = !f.L.on;
    if(act === 'l-up' && f.i > 0){ var a = comp.layers[f.i-1]; comp.layers[f.i-1] = f.L; comp.layers[f.i] = a; }
    if(act === 'l-down' && f.i < comp.layers.length - 1){ var b = comp.layers[f.i+1]; comp.layers[f.i+1] = f.L; comp.layers[f.i] = b; }
    renderComp();
  });

  /* 계산된 레이어를 "직접 찍은 점"으로 바꿔서 손으로 고칠 수 있게 합니다 */
  function bakeLayer(L){
    var S = lastShapes[L.id];
    if(!S || !S[0]){
      document.getElementById('c-err').hidden = false;
      document.getElementById('c-err').textContent = '아직 계산된 결과가 없어 점으로 구울 수 없습니다.';
      return;
    }
    L.src = { kind:'points', pts: fromCS(S).map(function(p){ return [p[0], p[1]]; }) };
    L.ops = [];
    renderComp();
  }

  document.getElementById('c-final').addEventListener('click', function(e){
    var btn = e.target.closest('button[data-act]');
    if(!btn) return;
    var row = btn.closest('.oprow');
    if(!row) return;
    var oi = +row.dataset.oi, act = btn.dataset.act;
    if(act === 'op-del') comp.final.splice(oi, 1);
    if(act === 'op-up' && oi > 0){ var t = comp.final[oi-1]; comp.final[oi-1] = comp.final[oi]; comp.final[oi] = t; }
    if(act === 'op-down' && oi < comp.final.length - 1){ var t2 = comp.final[oi+1]; comp.final[oi+1] = comp.final[oi]; comp.final[oi] = t2; }
    renderComp();
  });

  function onCompChange(e){
    var t = e.target;
    /* 연산 추가 셀렉트 */
    if(t.classList.contains('opname') && t.closest('.addop')){
      var fn = t.value;
      if(!fn) return;
      var layerEl = t.closest('.layer');
      var ops = layerEl ? scopeOps('L' + layerEl.dataset.lid) : comp.final;
      if(ops){ ops.push({ fn: fn, args: defArgs(OPS[fn]) }); renderComp(); }
      return;
    }
    /* 연산 종류 변경 */
    if(t.classList.contains('opname')){
      var row = t.closest('.oprow');
      var list = scopeOps(row.dataset.scope);
      if(!list) return;
      list[+row.dataset.oi] = { fn: t.value, args: defArgs(OPS[t.value]) };
      renderComp();
      return;
    }
    /* 합치는 법 변경 */
    if(t.classList.contains('join')){
      var bar = t.closest('.joinbar');
      var fj = layerById(+bar.dataset.lid);
      if(!fj) return;
      fj.L.join = t.value;
      fj.L.joinArgs = defArgs(JOINS[t.value]);
      renderComp();
      return;
    }
    /* 레이어 소스 */
    var srcEl = t.closest('.srcrow');
    if(srcEl){
      var lel = t.closest('.layer');
      var fl = lel && layerById(+lel.dataset.lid);
      if(!fl) return;
      if(t.classList.contains('srcshape')){ fl.L.src.name = t.value; renderComp(); return; }
      if(t.classList.contains('srccode')){ fl.L.src.code = t.value; persistComp(); recompute(); return; }
      if(t.classList.contains('genname')){ fl.L.src = newSrc('gen', t.value); renderComp(); return; }
      if(t.dataset.si !== undefined){
        var gspec = GENS[fl.L.src.fn];
        if(!gspec) return;
        var again = readArgInput(t, gspec, fl.L.src.args, +t.dataset.si);
        if(again) renderComp();
        else { persistComp(); recompute(); }
      }
      return;
    }
    /* 연산 인자 */
    if(t.dataset.ai !== undefined){
      var r = t.closest('.oprow');
      if(!r) return;
      var ops2 = scopeOps(r.dataset.scope);
      if(!ops2) return;
      var op = ops2[+r.dataset.oi];
      var spec2 = OPS[op.fn];
      if(readArgInput(t, spec2, op.args, +t.dataset.ai)) renderComp();
      else { persistComp(); recompute(); }
      return;
    }
    if(t.dataset.ji !== undefined){
      var bar2 = t.closest('.joinbar');
      var f2 = layerById(+bar2.dataset.lid);
      if(!f2) return;
      if(readArgInput(t, JOINS[f2.L.join], f2.L.joinArgs, +t.dataset.ji)) renderComp();
      else { persistComp(); recompute(); }
    }
  }
  compView.addEventListener('change', onCompChange);
  compView.addEventListener('input', function(e){
    var t = e.target;
    if(t.dataset.ai !== undefined || t.dataset.ji !== undefined || t.dataset.si !== undefined ||
       t.classList.contains('srccode')) onCompChange(e);
  });
  document.addEventListener('keydown', function(e){
    if(!(e.ctrlKey || e.metaKey) || e.key.toLowerCase() !== 'z') return;
    if(compView.hidden) return;
    var tag = (e.target.tagName || '').toLowerCase();
    if(tag === 'input' || tag === 'textarea' || tag === 'select') return;
    if(document.querySelector('dialog[open]')) return;
    e.preventDefault();
    if(e.shiftKey) redoComp(); else undoComp();
  });
