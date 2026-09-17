"""Generate a self-contained tactical preview from the built scenario manifest."""
from pathlib import Path
import json,html
P=Path(__file__).resolve().parent
m=json.loads((P/'manifest.json').read_text())
colors={'snow':'#dce9ed','dirt':'#80938e','ice':'#23516c'}
svg=['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024" role="img" aria-label="서리선 원정 전술 배치도">']
for y in range(128):
    x=0
    while x<128:
        material=m['materials'][y*128+x];end=x+1
        while end<128 and m['materials'][y*128+end]==material:end+=1
        svg.append(f'<path d="M{x*8} {y*8}h{(end-x)*8}v8H{x*8}Z" fill="{colors[material]}"/>');x=end
svg.append('<g fill="none" stroke="#f4d48c" stroke-width="3" stroke-dasharray="8 9" opacity=".75"><path d="M512 808L312 728L192 584L384 560L600 656L808 488L720 336L520 192L512 96"/></g>')
for u in m['unit_placements']:
    typ=u['type'];x=u['x']*8;y=u['y']*8
    if typ in [214,131,132,133,106]:continue
    if u['owner']==5:svg.append(f'<circle cx="{x}" cy="{y}" r="{5 if typ<106 else 9}" fill="#ae4e54" stroke="#67262b" stroke-width="1"/>')
    elif typ==122:svg.append(f'<rect x="{x-11}" y="{y-7}" width="22" height="14" rx="3" fill="#304d65"/>')
    elif typ==164:svg.append(f'<circle cx="{x}" cy="{y}" r="10" fill="#e2b565" stroke="#fff2be" stroke-width="2"/>')
    else:svg.append(f'<rect x="{x-7}" y="{y-7}" width="14" height="14" rx="2" fill="#617283"/>')
labels=[(64,12,'FINAL / 서리왕','#693647'),(65,24,'03 / 영구동토 군락','#693647'),(101,61,'02 / 동상 군락','#693647'),(24,73,'01 / 백야 군락','#693647'),(24,86,'서쪽 사냥터','#264c56'),(104,78,'동쪽 사냥터','#264c56'),(64,102,'전초기지 / 회복','#264c56'),(64,108,'동력로','#264c56')]
for x,y,label,color in labels:
    xx=x*8;yy=y*8;w=max(92,len(label)*13)
    svg.append(f'<g><circle cx="{xx}" cy="{yy}" r="13" fill="{color}" stroke="#ffffff" stroke-width="2"/><rect x="{xx-w/2}" y="{yy-39}" width="{w}" height="23" rx="5" fill="{color}"/><text x="{xx}" y="{yy-23}" fill="white" text-anchor="middle" font-family="sans-serif" font-size="13">{label}</text></g>')
svg.append('</svg>');svg=''.join(svg)
(P/'tactical-preview.svg').write_text(svg)
page='''<!doctype html><html lang="ko"><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>서리선 원정 — 128 × 128</title><style>*{box-sizing:border-box}body{margin:0;background:#101f2a;color:#e9f1f4;font:16px/1.65 system-ui,sans-serif}main{max-width:1360px;margin:auto;padding:40px}header{margin-bottom:28px}.eyebrow{color:#98bbc8;letter-spacing:.18em;font-size:12px}h1{font-size:clamp(32px,5vw,60px);margin:5px 0 8px}p{color:#b7cbd3}article{display:grid;grid-template-columns:minmax(400px,2fr) minmax(270px,1fr);gap:32px}svg{width:100%;border-radius:14px}h2{font-size:20px;color:#f4d48c;margin:25px 0 8px}table{border-collapse:collapse;width:100%;font-size:14px}td,th{text-align:left;padding:9px 5px;border-bottom:1px solid #344753}.note{font-size:13px;color:#94aeba}.tag{display:inline-block;padding:4px 11px;border:1px solid #47616c;border-radius:30px;font-size:13px;margin-right:8px}footer{border-top:1px solid #344753;margin-top:28px;padding-top:20px;font-size:13px;color:#94aeba}@media(max-width:850px){main{padding:20px}article{display:block}}</style><main><header><div class="eyebrow">FROSTLINE EXPEDITION / COOPERATIVE UMS</div><h1>서리선 원정</h1><p>빙하 너머 세 군락을 돌파하고, 서리왕의 침공을 끝내라.</p><span class="tag">128 × 128</span><span class="tag">1–5인 협동</span><span class="tag">설원 타일셋</span></header><article><section>'''+svg+'''<p class="note">설계 데이터로 그린 전술 배치도입니다. 게임 내 그래픽 캡처가 아닙니다.<br>옅은색: 설원 · 회색: 진군로 · 청색: 빙판 장애 구역 · 붉은색: 적</p></section><aside><h2>원정 순서</h2><p>남쪽 전초기지 → 서쪽 백야 군락 → 동쪽 동상 군락 → 북쪽 영구동토 군락 → 최북단 서리왕</p><h2>병력을 성장시키세요</h2><table><tr><th>보급관 신호소</th><th>비용 / 상한</th></tr><tr><td>왼쪽: 마린</td><td>250 / 12명</td></tr><tr><td>중앙 왼쪽: 의무관</td><td>200 / 3명</td></tr><tr><td>중앙 오른쪽: 정예마린</td><td>2,000 / 2명</td></tr><tr><td>오른쪽: 전원귀환</td><td>100</td></tr></table><p>전투점수 100마다 광물 35 자동 환전. 개인 공방 연구소에서 최대 30단계 강화. 군락 파괴 보상은 참가자 모두에게 지급됩니다.</p><h2>돌아올 곳을 지키세요</h2><p>전초기지에서는 체력과 의무관 에너지를 회복합니다. 전투 마린이 전멸하면 약 12게임초 후 마린 3명과 의무관으로 재정비합니다. 동력로가 파괴되면 원정은 실패합니다.</p><h2>반복되는 공세</h2><p>첫 공세는 약 60게임초 뒤, 이후 약 30게임초마다 도착합니다. 후방 방어와 군락 공격을 함께 관리하세요. 군락과 보스의 시작 체력, 공세 규모는 시작 인원에 따라 달라집니다.</p><p class="note">Fastest에서는 벽시계 기준 시간이 더 짧습니다. 실제 전투와 지형 렌더링은 리마스터 실행 검증이 필요합니다.</p></aside></article><footer>원작 참고: 마린키우기 쥬림산맥 / 픽시브 · 지형 스나이퍼광. 새 시나리오·배치·트리거: Codex. 원본 파일은 보존됩니다.</footer></main></html>'''
(P/'preview.html').write_text(page)
print(P/'preview.html')
