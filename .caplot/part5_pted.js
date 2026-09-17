  /* ==================== 점 편집기 ==================== */
  var ptdlg = document.getElementById('ptdlg');
  var ptCv = document.getElementById('ptplot');
  var ptState = {
    layer: null, pts: [], sel: [], mode: 'add', flip: false,
    view: { cx: 0, cy: 0, span: 320 },
    undo: [], redo: [], drag: null
  };

  function ptGrid(){
    var v = Math.abs(Number(document.getElementById('pt-grid').value) || 0);
    return v > 0 ? v : 1;
  }
  function ptSnapOn(){ return document.getElementById('pt-snap').checked; }
  function ptSnap(v){
    if(!ptSnapOn()) return Math.round(v * 100) / 100;
    var g = ptGrid();
    return Math.round(v / g) * g;
  }
  function ptXform(){
    var W = ptCv.clientWidth, H = ptCv.clientHeight;
    var v = ptState.view;
    var s = Math.min(W, H) / v.span;
    var fl = ptState.flip ? -1 : 1;
    return {
      W: W, H: H, s: s,
      TX: function(x){ return W / 2 + (x - v.cx) * s; },
      TY: function(y){ return H / 2 + (y - v.cy) * s * fl; },
      IX: function(px){ return v.cx + (px - W / 2) / s; },
      IY: function(py){ return v.cy + (py - H / 2) / (s * fl); }
    };
  }
  function ptFit(){
    var p = ptState.pts;
    if(!p.length){ ptState.view = { cx:0, cy:0, span:320 }; return; }
    var xn = p[0][0], xx = p[0][0], yn = p[0][1], yx = p[0][1];
    p.forEach(function(q){
      if(q[0] < xn) xn = q[0];
      if(q[0] > xx) xx = q[0];
      if(q[1] < yn) yn = q[1];
      if(q[1] > yx) yx = q[1];
    });
    var span = Math.max(xx - xn, yx - yn) * 1.3;
    if(!(span > 1)) span = 320;
    ptState.view = { cx: (xn + xx) / 2, cy: (yn + yx) / 2, span: span };
  }

  function ptPush(){
    ptState.undo.push(JSON.stringify(ptState.pts));
    if(ptState.undo.length > 120) ptState.undo.shift();
    ptState.redo.length = 0;
  }
  function ptUndo(){
    if(!ptState.undo.length) return;
    ptState.redo.push(JSON.stringify(ptState.pts));
    ptState.pts = JSON.parse(ptState.undo.pop());
    ptState.sel = ptState.sel.filter(function(i){ return i < ptState.pts.length; });
    ptSync();
  }
  function ptRedo(){
    if(!ptState.redo.length) return;
    ptState.undo.push(JSON.stringify(ptState.pts));
    ptState.pts = JSON.parse(ptState.redo.pop());
    ptState.sel = ptState.sel.filter(function(i){ return i < ptState.pts.length; });
    ptSync();
  }

  function ptDraw(){
    var W = ptCv.clientWidth, H = ptCv.clientHeight;
    if(!W || !H) return;
    var dpr = Math.min(window.devicePixelRatio || 1, 2);
    ptCv.width = Math.round(W * dpr); ptCv.height = Math.round(H * dpr);
    var ctx = ptCv.getContext('2d');
    ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
    ctx.clearRect(0, 0, W, H);
    var X = ptXform(), v = ptState.view;

    /* 격자 */
    var step = ptGrid();
    while(step * X.s < 7) step *= 2;
    ctx.strokeStyle = cssVar('--grid'); ctx.lineWidth = 1;
    ctx.beginPath();
    var gx = Math.ceil((v.cx - v.span / 2) / step) * step;
    for(; gx <= v.cx + v.span / 2; gx += step){
      var px = Math.round(X.TX(gx)) + 0.5;
      ctx.moveTo(px, 0); ctx.lineTo(px, H);
    }
    var gy = Math.ceil((v.cy - v.span / 2) / step) * step;
    for(; gy <= v.cy + v.span / 2; gy += step){
      var py = Math.round(X.TY(gy)) + 0.5;
      ctx.moveTo(0, py); ctx.lineTo(W, py);
    }
    ctx.stroke();

    /* 축 */
    ctx.strokeStyle = cssVar('--axis'); ctx.lineWidth = 1.2;
    ctx.beginPath();
    var ox = Math.round(X.TX(0)) + 0.5, oy = Math.round(X.TY(0)) + 0.5;
    ctx.moveTo(ox, 0); ctx.lineTo(ox, H);
    ctx.moveTo(0, oy); ctx.lineTo(W, oy);
    ctx.stroke();
    ctx.fillStyle = cssVar('--ink-3');
    ctx.font = '500 9px "IBM Plex Mono", monospace';
    ctx.textAlign = 'left';
    ctx.fillText(ptState.flip ? '+Y ▲' : '+Y ▼', ox + 4, ptState.flip ? 11 : H - 5);

    /* 이어진 순서 */
    var col = famColor('U'), p = ptState.pts;
    if(p.length > 1){
      ctx.strokeStyle = rgba(col, 0.26); ctx.lineWidth = 1;
      ctx.beginPath();
      ctx.moveTo(X.TX(p[0][0]), X.TY(p[0][1]));
      for(var j = 1; j < p.length; j++) ctx.lineTo(X.TX(p[j][0]), X.TY(p[j][1]));
      ctx.stroke();
    }

    /* 드래그 선택 상자 */
    if(ptState.drag && ptState.drag.kind === 'band'){
      var d = ptState.drag;
      ctx.strokeStyle = cssVar('--accent'); ctx.lineWidth = 1;
      ctx.setLineDash([4, 3]);
      ctx.strokeRect(Math.min(d.x0, d.x1), Math.min(d.y0, d.y1), Math.abs(d.x1 - d.x0), Math.abs(d.y1 - d.y0));
      ctx.setLineDash([]);
    }

    /* 점 */
    var r = Math.max(2.6, Math.min(7, 40 / Math.sqrt(Math.max(1, p.length))));
    var selSet = Object.create(null);
    ptState.sel.forEach(function(i){ selSet[i] = 1; });
    for(var i = 0; i < p.length; i++){
      var cx = X.TX(p[i][0]), cy = X.TY(p[i][1]);
      var on = selSet[i];
      ctx.fillStyle = on ? cssVar('--accent') : rgba(col, 0.7);
      ctx.strokeStyle = on ? cssVar('--accent') : rgba(col, 0.95);
      ctx.lineWidth = on ? 2 : 1;
      ctx.beginPath();
      ctx.arc(cx, cy, on ? r + 1.4 : r, 0, Math.PI * 2);
      ctx.fill(); ctx.stroke();
    }
    /* 원점 십자 */
    ctx.strokeStyle = cssVar('--ink-3'); ctx.lineWidth = 1.4;
    ctx.beginPath();
    ctx.moveTo(ox - 5, oy); ctx.lineTo(ox + 5, oy);
    ctx.moveTo(ox, oy - 5); ctx.lineTo(ox, oy + 5);
    ctx.stroke();
  }

  function ptHit(px, py){
    var X = ptXform(), p = ptState.pts;
    var best = -1, bd = 13 * 13;
    for(var i = p.length - 1; i >= 0; i--){
      var dx = X.TX(p[i][0]) - px, dy = X.TY(p[i][1]) - py;
      var d = dx * dx + dy * dy;
      if(d < bd){ bd = d; best = i; }
    }
    return best;
  }

  function ptRows(){
    var selSet = Object.create(null);
    ptState.sel.forEach(function(i){ selSet[i] = 1; });
    var p = ptState.pts;
    var body = p.length > 900
      ? '<tr><td colspan="3" style="text-align:center;color:var(--ink-3)">점이 ' + fmt(p.length) + '개라 목록은 생략했습니다</td></tr>'
      : p.map(function(q, i){
          return '<tr class="' + (selSet[i] ? 'sel' : '') + '" data-pi="' + i + '"><td>' + (i + 1) + '</td><td>' +
            r2(q[0]) + '</td><td>' + r2(q[1]) + '</td></tr>';
        }).join('');
    document.getElementById('pt-list').innerHTML = body;
  }

  function ptSync(){
    document.getElementById('pt-count').textContent = fmt(ptState.pts.length) + ' pt';
    document.getElementById('pt-sel').textContent = ptState.sel.length ? ptState.sel.length + '개 선택' : '선택 없음';
    document.getElementById('pt-undo').disabled = !ptState.undo.length;
    document.getElementById('pt-redo').disabled = !ptState.redo.length;
    var err = document.getElementById('pt-err');
    if(ptState.pts.length > MAX_POINTS){
      err.hidden = false;
      err.textContent = fmt(MAX_POINTS) + '점까지만 다룹니다 — 지금 ' + fmt(ptState.pts.length) + '점입니다.';
    } else err.hidden = true;
    var bb = bboxOf(ptState.pts);
    document.getElementById('pt-meta').textContent = ptState.pts.length
      ? Math.round(bb[2] - bb[0]) + ' × ' + Math.round(bb[3] - bb[1]) + '  ·  X [' + r2(bb[0]) + ', ' + r2(bb[2]) + ']  Y [' + r2(bb[1]) + ', ' + r2(bb[3]) + ']'
      : '—';
    ptRows();
    ptDraw();
  }

  function ptSetMode(m){
    ptState.mode = m;
    document.getElementById('pt-m-add').setAttribute('aria-pressed', String(m === 'add'));
    document.getElementById('pt-m-sel').setAttribute('aria-pressed', String(m === 'sel'));
    ptCv.classList.toggle('mode-sel', m === 'sel');
    document.getElementById('pt-hint').textContent = m === 'add'
      ? '빈 곳 클릭 = 점 찍기 · 점 끌기 = 옮기기 · Alt+클릭 = 지우기 · 휠 = 확대 · 가운데 버튼 = 이동'
      : '끌어서 상자 선택 · Shift+클릭 = 더하기 · Del = 선택 삭제 · 화살표 = 격자만큼 밀기';
  }

  function openPointEditor(L, seed, title){
    ptState.layer = L || null;
    ptState.pts = (seed ? seed : (L && L.src.kind === 'points' ? L.src.pts : (L && lastShapes[L.id] ? fromCS(lastShapes[L.id]) : [])))
      .map(function(p){ return [p[0], p[1]]; });
    ptState.sel = [];
    ptState.undo = []; ptState.redo = [];
    ptState.flip = document.getElementById('pt-flip').checked;
    document.getElementById('pt-title').textContent = title || (L ? '레이어 ' + (comp.layers.indexOf(L) + 1) + ' 점 편집' : '점 편집');
    document.getElementById('pt-apply').hidden = !L;
    document.getElementById('pt-err').hidden = true;
    if(!ptdlg.open) ptdlg.showModal();
    ptSetMode('add');
    ptFit();
    requestAnimationFrame(function(){ ptFit(); ptSync(); });
  }

  ptCv.addEventListener('pointerdown', function(e){
    var rect = ptCv.getBoundingClientRect();
    var px = e.clientX - rect.left, py = e.clientY - rect.top;
    ptCv.setPointerCapture(e.pointerId);
    if(e.button === 1 || e.button === 2){
      ptState.drag = { kind:'pan', px:px, py:py, cx:ptState.view.cx, cy:ptState.view.cy };
      e.preventDefault();
      return;
    }
    var hit = ptHit(px, py);
    if(hit >= 0 && (e.altKey || e.metaKey)){
      ptPush();
      ptState.pts.splice(hit, 1);
      ptState.sel = [];
      ptSync();
      return;
    }
    if(hit >= 0){
      if(e.shiftKey){
        var k = ptState.sel.indexOf(hit);
        if(k >= 0) ptState.sel.splice(k, 1); else ptState.sel.push(hit);
        ptSync();
        return;
      }
      if(ptState.sel.indexOf(hit) < 0) ptState.sel = [hit];
      ptPush();
      var X0 = ptXform();
      ptState.drag = {
        kind:'move', px:px, py:py,
        base: ptState.sel.map(function(i){ return [i, ptState.pts[i][0], ptState.pts[i][1]]; }),
        s: X0.s, fl: ptState.flip ? -1 : 1, moved:false
      };
      ptSync();
      return;
    }
    if(ptState.mode === 'add'){
      var X = ptXform();
      ptPush();
      ptState.pts.push([ptSnap(X.IX(px)), ptSnap(X.IY(py))]);
      ptState.sel = [ptState.pts.length - 1];
      ptState.drag = {
        kind:'move', px:px, py:py,
        base: [[ptState.pts.length - 1, ptState.pts[ptState.pts.length - 1][0], ptState.pts[ptState.pts.length - 1][1]]],
        s: ptXform().s, fl: ptState.flip ? -1 : 1, moved:false
      };
      ptSync();
      return;
    }
    ptState.drag = { kind:'band', x0:px, y0:py, x1:px, y1:py, add:e.shiftKey };
    if(!e.shiftKey) ptState.sel = [];
    ptSync();
  });
  ptCv.addEventListener('pointermove', function(e){
    var d = ptState.drag;
    if(!d) return;
    var rect = ptCv.getBoundingClientRect();
    var px = e.clientX - rect.left, py = e.clientY - rect.top;
    if(d.kind === 'pan'){
      var X = ptXform();
      ptState.view.cx = d.cx - (px - d.px) / X.s;
      ptState.view.cy = d.cy - (py - d.py) / (X.s * (ptState.flip ? -1 : 1));
      ptDraw();
      return;
    }
    if(d.kind === 'move'){
      var dx = (px - d.px) / d.s, dy = (py - d.py) / (d.s * d.fl);
      if(Math.abs(px - d.px) + Math.abs(py - d.py) > 2) d.moved = true;
      d.base.forEach(function(b){
        ptState.pts[b[0]] = [ptSnap(b[1] + dx), ptSnap(b[2] + dy)];
      });
      ptSync();
      return;
    }
    if(d.kind === 'band'){
      d.x1 = px; d.y1 = py;
      var X2 = ptXform();
      var lo = [Math.min(d.x0, d.x1), Math.min(d.y0, d.y1)];
      var hi = [Math.max(d.x0, d.x1), Math.max(d.y0, d.y1)];
      var base = d.add ? ptState.sel.slice() : [];
      ptState.pts.forEach(function(q, i){
        var sx = X2.TX(q[0]), sy = X2.TY(q[1]);
        if(sx >= lo[0] && sx <= hi[0] && sy >= lo[1] && sy <= hi[1] && base.indexOf(i) < 0) base.push(i);
      });
      ptState.sel = base;
      ptSync();
    }
  });
  function ptEndDrag(){
    var d = ptState.drag;
    ptState.drag = null;
    if(d && d.kind === 'move' && !d.moved && d.base.length === 1){
      /* 제자리 클릭이면 되돌리기 기록을 남기지 않습니다 */
      var snap = JSON.stringify(ptState.pts);
      if(ptState.undo.length && ptState.undo[ptState.undo.length - 1] === snap) ptState.undo.pop();
    }
    ptSync();
  }
  ptCv.addEventListener('pointerup', ptEndDrag);
  ptCv.addEventListener('pointercancel', ptEndDrag);
  ptCv.addEventListener('contextmenu', function(e){ e.preventDefault(); });
  ptCv.addEventListener('wheel', function(e){
    e.preventDefault();
    var rect = ptCv.getBoundingClientRect();
    var px = e.clientX - rect.left, py = e.clientY - rect.top;
    var X = ptXform();
    var wx = X.IX(px), wy = X.IY(py);
    var k = e.deltaY > 0 ? 1.14 : 1 / 1.14;
    ptState.view.span = Math.max(4, Math.min(60000, ptState.view.span * k));
    var X2 = ptXform();
    ptState.view.cx += wx - X2.IX(px);
    ptState.view.cy += wy - X2.IY(py);
    ptDraw();
  }, { passive: false });

  document.getElementById('pt-list').addEventListener('click', function(e){
    var tr = e.target.closest('tr[data-pi]');
    if(!tr) return;
    var i = +tr.dataset.pi;
    if(e.shiftKey){
      var k = ptState.sel.indexOf(i);
      if(k >= 0) ptState.sel.splice(k, 1); else ptState.sel.push(i);
    } else ptState.sel = [i];
    ptSync();
  });

  document.getElementById('pt-m-add').addEventListener('click', function(){ ptSetMode('add'); });
  document.getElementById('pt-m-sel').addEventListener('click', function(){ ptSetMode('sel'); });
  document.getElementById('pt-grid').addEventListener('input', ptDraw);
  document.getElementById('pt-flip').addEventListener('change', function(){ ptState.flip = this.checked; ptDraw(); });
  document.getElementById('pt-fit').addEventListener('click', function(){ ptFit(); ptDraw(); });
  document.getElementById('pt-undo').addEventListener('click', ptUndo);
  document.getElementById('pt-redo').addEventListener('click', ptRedo);
  document.getElementById('pt-selall').addEventListener('click', function(){
    ptState.sel = ptState.pts.map(function(_, i){ return i; });
    ptSync();
  });
  document.getElementById('pt-delsel').addEventListener('click', function(){
    if(!ptState.sel.length) return;
    ptPush();
    var kill = Object.create(null);
    ptState.sel.forEach(function(i){ kill[i] = 1; });
    ptState.pts = ptState.pts.filter(function(_, i){ return !kill[i]; });
    ptState.sel = [];
    ptSync();
  });
  document.getElementById('pt-clear').addEventListener('click', function(){
    if(!ptState.pts.length) return;
    ptPush();
    ptState.pts = []; ptState.sel = [];
    ptSync();
  });
  document.getElementById('pt-center').addEventListener('click', function(){
    if(!ptState.pts.length) return;
    ptPush();
    var bb = bboxOf(ptState.pts);
    var cx = (bb[0] + bb[2]) / 2, cy = (bb[1] + bb[3]) / 2;
    ptState.pts = ptState.pts.map(function(p){ return [r2(p[0] - cx), r2(p[1] - cy)]; });
    ptFit(); ptSync();
  });
  document.getElementById('pt-snapall').addEventListener('click', function(){
    if(!ptState.pts.length) return;
    ptPush();
    var g = ptGrid();
    ptState.pts = ptState.pts.map(function(p){ return [Math.round(p[0] / g) * g, Math.round(p[1] / g) * g]; });
    ptSync();
  });
  document.getElementById('pt-close').addEventListener('click', function(){ ptdlg.close(); });
  document.getElementById('pt-apply').addEventListener('click', function(){
    var L = ptState.layer;
    if(!L) return;
    if(ptState.pts.length > MAX_POINTS) return;
    L.src = { kind:'points', pts: ptState.pts.map(function(p){ return [p[0], p[1]]; }) };
    renderComp();
    ptdlg.close();
  });
  document.getElementById('pt-saveas').addEventListener('click', function(){
    var err = document.getElementById('pt-err');
    function fail(m){ err.hidden = false; err.textContent = m; }
    if(!ptState.pts.length){ fail('점이 하나도 없습니다.'); return; }
    if(ptState.pts.length > MAX_POINTS){ fail(fmt(MAX_POINTS) + '점까지만 저장할 수 있습니다.'); return; }
    var name = document.getElementById('pt-name').value.trim();
    var e = nameError(name, null);
    if(e){ fail(e); document.getElementById('pt-name').focus(); return; }
    err.hidden = true;
    var btn = this; btn.disabled = true;
    saveShape({ name: name, pts: ptState.pts.map(function(p){ return [p[0], p[1]]; }), expr: '점 편집기' })
      .then(function(){
        btn.disabled = false; btn.textContent = '저장됨';
        document.getElementById('pt-name').value = '';
        setTimeout(function(){ btn.textContent = '새 도형으로 저장'; }, 1500);
      }, function(er){
        btn.disabled = false;
        fail('저장하지 못했습니다: ' + (er && er.message ? er.message : er));
      });
  });
  ptdlg.addEventListener('keydown', function(e){
    var tag = (e.target.tagName || '').toLowerCase();
    if(tag === 'input' || tag === 'textarea' || tag === 'select') return;
    var g = ptGrid();
    if(e.key === 'Delete' || e.key === 'Backspace'){
      e.preventDefault();
      document.getElementById('pt-delsel').click();
      return;
    }
    if((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'z'){
      e.preventDefault();
      if(e.shiftKey) ptRedo(); else ptUndo();
      return;
    }
    var dx = 0, dy = 0;
    if(e.key === 'ArrowLeft') dx = -g;
    else if(e.key === 'ArrowRight') dx = g;
    else if(e.key === 'ArrowUp') dy = -g;
    else if(e.key === 'ArrowDown') dy = g;
    else return;
    if(!ptState.sel.length) return;
    if(ptState.flip) dy = -dy;
    e.preventDefault();
    ptPush();
    ptState.sel.forEach(function(i){
      ptState.pts[i] = [r2(ptState.pts[i][0] + dx), r2(ptState.pts[i][1] + dy)];
    });
    ptSync();
  });
  ptdlg.addEventListener('close', function(){ ptState.drag = null; });
