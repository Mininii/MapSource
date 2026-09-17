  function lsWorks(){
    try{ localStorage.setItem('caplot.probe', '1'); localStorage.removeItem('caplot.probe'); return true; }
    catch(e){ return false; }
  }

  function initStore(){
    custom = (lsGet(LSK.shapes, []) || []).map(function(d){ return normalizeRec(d.id, d); });
    hiddenNames = lsGet(LSK.hidden, []) || [];
    store.ready = true;
    rebuild();
    if(!lsWorks()){
      showStorageNote('이 브라우저가 저장소를 막고 있어서(시크릿 모드 등) 만든 도형이 새로고침하면 사라집니다. 작업 전에 그때그때 백업으로 JSON을 복사해 두세요.');
    }
  }

  var storageWarn = '';
  function showStorageNote(txt){
    storageWarn = txt;
    var el = document.getElementById('storage-note');
    document.getElementById('storage-note-txt').textContent = txt;
    el.hidden = false;
  }

  function saveShape(rec){
    var body = {
      name: rec.name, pts: rec.pts, n: rec.pts.length, bbox: bboxOf(rec.pts),
      expr: rec.expr || '', recipe: rec.recipe || null,
      createdAt: Date.now()
    };
    var id = 'loc' + Date.now() + Math.floor(Math.random() * 1000);
    custom = custom.concat([normalizeRec(id, body)]);
    lsSet(LSK.shapes, custom);
    afterStoreChange();
    return Promise.resolve();
  }
  function renameShape(id, name){
    custom = custom.map(function(c){ if(c.id === id) c.name = name; return c; });
    lsSet(LSK.shapes, custom); afterStoreChange();
    return Promise.resolve();
  }
  function deleteShape(id){
    custom = custom.filter(function(c){ return c.id !== id; });
    lsSet(LSK.shapes, custom); afterStoreChange();
    return Promise.resolve();
  }
  function setHidden(list){
    hiddenNames = list;
    lsSet(LSK.hidden, list);
    afterStoreChange();
    return Promise.resolve();
  }
