  /* ==================== 백업 — 내보내기 / 불러오기 ====================
     로컬 저장 전용판이라 브라우저를 벗어나면 도형이 남지 않습니다. 아티팩트
     샌드박스는 페이지가 시작하는 파일 다운로드를 막으므로, 파일 대신
     텍스트(JSON)를 복사·붙여넣기 하는 방식으로 옮깁니다. */
  var bkdlg = document.getElementById('bkdlg');
  var bkJson = document.getElementById('bk-json');
  var bkMsg = document.getElementById('bk-msg');

  function bkSetMsg(t, cls){ bkMsg.textContent = t || ''; bkMsg.className = 'msg' + (cls ? ' ' + cls : ''); }

  function exportPayload(){
    return {
      caplot: 1,
      exportedAt: new Date().toISOString(),
      shapes: custom.map(function(c){
        return { name: c.name, pts: c.pts, expr: c.expr || '', recipe: c.recipe || null, createdAt: c.createdAt || 0 };
      }),
      hidden: hiddenNames.slice()
    };
  }

  function openBackup(){
    bkJson.value = '';
    bkSetMsg('');
    document.getElementById('bk-note').textContent = custom.length
      ? '만든 도형 ' + custom.length + '개가 이 브라우저에만 있습니다. 내보내서 JSON을 보관해 두면 다른 기기·브라우저에서 그대로 되살릴 수 있습니다.'
      : '아직 만든 도형이 없습니다. 다른 곳에서 내보낸 JSON이 있다면 아래에 붙여넣고 불러오세요.';
    bkdlg.showModal();
  }

  function safeName(v, i){
    var n = String(v == null ? '' : v).replace(/[^A-Za-z0-9_]/g, '');
    if(!n) return 'Imported' + (i + 1);
    if(!/^[A-Za-z_]/.test(n)) n = 'S' + n;
    return n;
  }
  function uniqueName(base, taken){
    var n = base, i = 2;
    while(byName[n] || taken[n]){ n = base + '_' + i; i++; }
    return n;
  }

  function parsePayload(){
    var raw = bkJson.value.trim();
    if(!raw){ bkSetMsg('불러올 JSON을 붙여넣으세요.', 'err'); return null; }
    var d;
    try{ d = JSON.parse(raw); }
    catch(e){ bkSetMsg('JSON을 읽지 못했습니다 — ' + e.message, 'err'); return null; }
    var list = Array.isArray(d) ? d : (d && Array.isArray(d.shapes) ? d.shapes : null);
    if(!list){ bkSetMsg('shapes 배열을 찾지 못했습니다. 이 페이지에서 내보낸 JSON이 맞는지 확인하세요.', 'err'); return null; }
    var ok = [];
    list.forEach(function(it, i){
      var pts = (it && Array.isArray(it.pts)) ? it.pts.filter(function(pt){
        return Array.isArray(pt) && typeof pt[0] === 'number' && typeof pt[1] === 'number';
      }) : [];
      if(!pts.length) return;
      ok.push({
        name: safeName(it.name, i), pts: pts,
        expr: it.expr || '', recipe: it.recipe || null, createdAt: it.createdAt || 0
      });
    });
    if(!ok.length){ bkSetMsg('좌표가 들어 있는 도형을 하나도 찾지 못했습니다.', 'err'); return null; }
    return { shapes: ok, hidden: (d && Array.isArray(d.hidden)) ? d.hidden : null };
  }

  function applyImport(mode){
    var d = parsePayload();
    if(!d) return;
    if(mode === 'replace'){ custom = []; rebuild(); }
    var taken = Object.create(null), renamed = 0, stamp = Date.now();
    var recs = d.shapes.map(function(it, i){
      var got = uniqueName(it.name, taken);
      if(got !== it.name) renamed++;
      taken[got] = true;
      return normalizeRec('loc' + stamp + '_' + i, {
        name: got, pts: it.pts, expr: it.expr, recipe: it.recipe,
        createdAt: it.createdAt || (stamp + i)
      });
    });
    custom = custom.concat(recs);
    lsSet(LSK.shapes, custom);
    if(mode === 'replace' && d.hidden){ hiddenNames = d.hidden; lsSet(LSK.hidden, hiddenNames); }
    afterStoreChange();
    bkSetMsg('도형 ' + recs.length + '개를 불러왔습니다'
      + (renamed ? ' — 이름이 겹친 ' + renamed + '개는 뒤에 번호를 붙였습니다' : '') + '.', 'ok');
  }

  document.getElementById('btn-backup').addEventListener('click', openBackup);
  document.getElementById('bk-close').addEventListener('click', function(){ bkdlg.close(); });
  document.getElementById('bk-fill').addEventListener('click', function(){
    if(!custom.length){ bkSetMsg('내보낼 도형이 없습니다 — 아직 만든 도형이 하나도 없습니다.', 'err'); return; }
    bkJson.value = JSON.stringify(exportPayload());
    bkJson.select();
    bkSetMsg('도형 ' + custom.length + '개를 JSON으로 뽑았습니다. 복사해서 안전한 곳에 붙여넣어 두세요.', 'ok');
  });
  document.getElementById('bk-copy').addEventListener('click', function(e){
    if(!bkJson.value.trim()){ bkSetMsg('먼저 내보내기를 누르세요.', 'err'); return; }
    copyText(bkJson.value, e.currentTarget, '복사');
  });
  document.getElementById('bk-merge').addEventListener('click', function(){ applyImport('merge'); });
  document.getElementById('bk-replace').addEventListener('click', function(){
    if(!parsePayload()) return;
    ask({ title:'덮어쓰기', msg:'지금 이 브라우저에 있는 내 도형 ' + custom.length + '개를 지우고 붙여넣은 JSON으로 바꿉니다. 되돌릴 수 없습니다.',
          okText:'덮어쓰기', danger:true }).then(function(ok){
      if(ok) applyImport('replace');
    });
  });
