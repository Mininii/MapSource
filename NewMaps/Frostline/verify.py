"""Structural checks plus execution of the actual generated CHK trigger bytecode.
This small model covers scenario logic, not StarCraft pathfinding/combat/rendering.
"""
from pathlib import Path
import struct as st, json, hashlib, collections, copy
from eudplib.bindings._rust import mpqapi
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
m=json.loads((HERE/'manifest.json').read_text())
raw=mpqapi.MPQ.open(str(ROOT/m['output'])).extract_file('staredit\\scenario.chk')
s={};pos=0
while pos<len(raw):
    assert pos+8<=len(raw)
    k,n=st.unpack_from('<4sI',raw,pos);pos+=8;assert pos+n<=len(raw)
    assert k not in s;s[k]=raw[pos:pos+n];pos+=n
assert raw==(HERE/'scenario.chk').read_bytes()
assert st.unpack('<HH',s[b'DIM '])==(128,128)
assert len(s[b'MTXM'])==32768 and s[b'MTXM']==s[b'TILE']
assert len(s[b'UNIT'])%36==0 and len(s[b'TRIG'])%2400==0
for k,n in {b'OWNR':12,b'SIDE':12,b'MRGN':5100,b'UNIx':4168,b'PUNI':5700,b'PUPx':2318,b'UPGx':794,b'PTEx':1672,b'TECx':396,b'MASK':16384}.items():assert len(s[k])==n,(k,len(s[k]))
assert hashlib.sha256((ROOT/m['source']).read_bytes()).hexdigest()==m['source_sha256']
strs=s[b'STR '];ns=st.unpack_from('<H',strs)[0]
for i in range(ns):
    off=st.unpack_from('<H',strs,2+2*i)[0];assert 2+ns*2<=off<len(strs)
    strs[off:].split(b'\0',1)[0].decode('utf-8')
locations={i+1:st.unpack_from('<4IHH',s[b'MRGN'],i*20) for i in range(255)}
for r in locations.values():
    assert 0<=r[0]<=r[2]<=4096 and 0<=r[1]<=r[3]<=4096
    assert r[4]<=ns
# Conservative tile-level reachability around every intended ice shelf.
walk={i for i,v in enumerate(m['materials']) if v!='ice'}
start=102*128+64;seen={start};todo=[start]
for i in todo:
    x,y=i%128,i//128
    for xx,yy in [(x-1,y),(x+1,y),(x,y-1),(x,y+1)]:
        j=yy*128+xx
        if 0<=xx<128 and 0<=yy<128 and j in walk and j not in seen:seen.add(j);todo.append(j)
for name,l in m['locations'].items():
    x,y=l['center'];assert int(y)*128+int(x) in seen,name
for u in m['unit_placements']:assert int(u['y'])*128+int(u['x']) in seen
for i in range(0,len(s[b'UNIT']),36):
    _,x,y,typ=st.unpack_from('<IHHH',s[b'UNIT'],i);assert x<4096 and y<4096 and typ<228
tr=[]
for i in range(0,len(s[b'TRIG']),2400):
    b=s[b'TRIG'][i:i+2400]
    cc=[st.unpack_from('<IIIHBBBBH',b,j*20) for j in range(16)]
    aa=[st.unpack_from('<IIIIIIHBBBBH',b,320+j*32) for j in range(64)]
    for a in aa:
        if a[7]==0:continue
        assert a[7]!=4,'Unexpected Wait action'
        assert a[1]<=ns
        if a[7] in [10,18,23,25,28,38,39,43,44,46,48,49,50,51]:assert 1<=a[0]<=255
        if a[7] in [39,46]:assert 1<=a[5]<=255
        if a[7]==45:assert a[4]<12 and a[6]<228,'EUD action found'
    for c in cc:
        if c[5]==15:assert c[1]<12 and c[3]<228,'EUD condition found'
    tr.append((cc,aa,b[2372:2400]))
class Sim:
    def __init__(self,humans):
        self.players=list(humans)+[5,6,7];self.dc=collections.defaultdict(int);self.ore=collections.defaultdict(int);self.score=collections.defaultdict(int)
        self.units=copy.deepcopy([u for u in m['unit_placements'] if u['type']!=214]);self.done=set();self.outcome={};self.ticks=0;self.messages=[]
    def count(self,p,u,l=0):
        def inside(v):
            if not l:return True
            x1,y1,x2,y2,*_=locations[l];return x1<=v['x']*32<=x2 and y1<=v['y']*32<=y2
        return sum(v['owner']==p and (v['type']==u or (u==230 and v['type']<106)) and inside(v) for v in self.units)
    def match(self,p,u,l=0):
        r=locations[l] if l else [0,0,4096,4096]
        return [v for v in self.units if v['owner']==p and (v['type']==u or (u==230 and v['type']<106)) and r[0]<=v['x']*32<=r[2] and r[1]<=v['y']*32<=r[3]]
    @staticmethod
    def cmp(v,c,n):return {0:v>=n,1:v<=n,10:v==n}[c]
    def condition(self,c):
        l,p,n,u,cmp,typ,r,flags,_=c
        if typ in [0,22]:return True
        if typ==2:v=self.count(p,u)
        elif typ==3:v=self.count(p,u,l)
        elif typ==4:v=self.ore[p]
        elif typ==12:v=self.ticks*2
        elif typ==15:v=self.dc[p,u]
        elif typ==21:v=self.score[p,r]
        else:raise AssertionError(('unsupported condition',typ))
        return self.cmp(v,cmp,n)
    @staticmethod
    def mod(v,m,n):return {7:n,8:v+n,9:max(0,v-n)}[m]
    def action(self,a,owner):
        l,string,wav,time,p,n,u,typ,amount,flags,padding,mask=a
        if typ==0:return
        if typ==45:self.dc[p,u]=self.mod(self.dc[p,u],amount,n)
        elif typ==26:self.ore[p]=self.mod(self.ore[p],amount,n)
        elif typ==27:self.score[p,u]=self.mod(self.score[p,u],amount,n)
        elif typ==44:
            r=locations[l]
            self.units += [dict(type=u,owner=p,x=(r[0]+r[2])/64,y=(r[1]+r[3])/64,invincible=False) for _ in range(amount)]
        elif typ==39:
            r=locations[n]
            for v in self.match(p,u,l):v['x']=(r[0]+r[2])/64;v['y']=(r[1]+r[3])/64
        elif typ in [24,25]:
            doomed=self.match(p,u,l if typ==25 else 0)
            for v in doomed:self.units.remove(v)
        elif typ==43:
            for v in self.match(p,u,l):v['invincible']=amount==4
        elif typ==49:
            for v in self.match(p,u,l):v['hp_percent']=n
        elif typ in [1,2]:self.outcome[owner]='victory' if typ==1 else 'defeat'
        elif typ==9:self.messages.append((owner,string))
        elif typ in [3,10,12,15,16,21,32,46,50,57]:pass
        else:raise AssertionError(('unsupported action',typ))
    def step(self,n=1):
        for _ in range(n):
            for p in self.players:
                for i,(cc,aa,owners) in enumerate(tr):
                    if not owners[p] or (p,i) in self.done:continue
                    if all(self.condition(c) for c in cc):
                        for a in aa:self.action(a,p)
                        if not any(a[7]==3 for a in aa):self.done.add((p,i))
            self.ticks+=1
    def remove(self,p,u):self.units=[v for v in self.units if not(v['owner']==p and v['type']==u)]
    def visit(self,p,shop):
        l=m['locations'][shop];x,y=l['center']
        for v in self.units:
            if v['owner']==p and v['type']==15:v['x']=x;v['y']=y
checks=[]
def check(label,fn):fn();checks.append(label)
def run():
    for humans in [[0],[2],[4],[0,4],[1,2,3],[0,1,2,3,4]]:
        v=Sim(humans);v.step();assert v.dc[7,201]==len(humans)
        for p in humans:assert v.count(p,0)==4 and v.count(p,34)==1 and v.count(p,15)==1
        for p in set(range(5))-set(humans):assert v.count(p,0)==0 and v.ore[p]==0
        for u in v.match(5,131):assert u['hp_percent']==20+16*len(humans)
    checks.append('1~5인 초기화 및 P1 없는 방, 빈 슬롯 병력/보상 없음')
    v=Sim([0]);v.step();start=v.ore[0];v.visit(0,'마린 250 / 최대 12');v.step()
    assert v.ore[0]==start-250 and v.count(0,0)==5;v.step();assert v.count(0,0)==5
    checks.append('상점 1회 방문 1회 구매, 중복 결제 방지')
    v.ore[0]=0;v.visit(0,'정예마린 2000 / 최대 2');v.step();assert v.count(0,20)==0
    checks.append('잔액 부족 시 무료 구매/차감 없음')
    v.ore[0]=10000
    for _ in range(15):v.visit(0,'마린 250 / 최대 12');v.step()
    assert v.count(0,0)==12
    before=v.ore[0];v.visit(0,'마린 250 / 최대 12');v.step();assert v.ore[0]-before in [0,25]
    checks.append('마린 최대 12, 상한 초과 결제 없음')
    for _ in range(4):v.visit(0,'정예마린 2000 / 최대 2');v.step()
    assert v.count(0,20)==2
    checks.append('정예마린 최대 2')
    v=Sim([0]);v.step();v.remove(0,0);v.step(5);assert v.count(0,0)==0
    v.step();assert v.count(0,0)==3 and v.count(0,34)==1
    checks.append('전멸 6주기 뒤 3마린/1의무관 복구, 의무관 누적 없음')
    v=Sim([0]);v.step();v.score[0,6]=2375;v.step(5)
    assert v.score[0,6]==75 and v.score[0,7]==2300
    checks.append('자동 환전: 100점 미만 나머지 보존 / 누적 공헌 별도 집계')
    v=Sim([0,4]);v.step()
    for stage,u in enumerate([131,132,133],1):
        v.remove(5,u);v.step(2);assert v.dc[7,200]==stage+1
        if stage<3:assert not v.match(5,[131,132,133][stage])[0]['invincible']
    assert v.count(5,48)==1 and not v.outcome
    v.remove(5,48);v.step(2);assert all(v.outcome[p]=='victory' for p in [0,4])
    checks.append('군락 순차 봉인 해제 → 보스 1회 생성 → 모든 참가자 승리')
    v=Sim([0]);v.step();v.remove(7,106);v.step(2);assert v.outcome[0]=='defeat'
    checks.append('동력로 파괴 패배')
    v=Sim([0]);v.step();v.dc[7,200]=4;v.remove(7,106);v.step(2);assert v.outcome[0]=='defeat'
    checks.append('동력로·보스 동시 파괴 시 패배 우선')
    v=Sim([0,1,2,3,4]);v.step(300)
    assert v.count(6,230)<=80 and v.count(5,230)<=144
    checks.append('10분 무전투 모델: 적 생성 상한 준수')
    v=Sim([0]);v.step();v.units[0]['x']=2
    for u in v.match(0,0):u['x']=64;u['y']=40
    v.visit(0,'전원귀환 100');v.step()
    assert all(u['y']==101 for u in v.match(0,0))
    checks.append('전원귀환 위치 검증')
run()
result={'structural_validation':'PASS','trigger_bytecode_simulation':'PASS','checks':checks,'reachable_ground_tiles':len(seen),'trigger_count':len(tr),'original_preserved':True,'limitations':['StarCraft Remastered 실행/대전 테스트 미실시','타일 통행 검사는 설계 지형 기준이며 게임 CV5/VF4·실제 경로 탐색 검증은 아님','전투 밸런스, 그래픽 타일 경계, 게임 내 UI는 실기 검증 필요']}
(HERE/'validation.json').write_text(json.dumps(result,ensure_ascii=False,indent=2));print(json.dumps(result,ensure_ascii=False,indent=2))
