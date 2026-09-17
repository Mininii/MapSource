"""Build an editable, standard-trigger Brood War scenario; no EUD runtime required."""
from pathlib import Path
import struct as st, random, math, json, hashlib, tempfile
from eudplib.bindings._rust import mpqapi
from eudplib.trigtrg import trigtrg as t
ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
SOURCE=ROOT/'마린키우기_쥬림산맥_2.8_공2배_리밸런싱F4.scx'
OUTPUT=ROOT/'마린키우기_서리선원정_128x128_v1.0.scx'
def sections(raw):
    out={}; p=0
    while p<len(raw):
        assert p+8<=len(raw)
        k,n=st.unpack_from('<4sI',raw,p);p+=8
        assert p+n<=len(raw),(k,n,p)
        assert k not in out,k
        out[k]=raw[p:p+n];p+=n
    return out
src=sections(mpqapi.MPQ.open(str(SOURCE)).extract_file('staredit\\scenario.chk'))
rng=random.Random(20260911)
strings=[]
def sid(s):
    if s not in strings: strings.append(s)
    return strings.index(s)+1
S={k:src[k] for k in [b'VER ',b'TYPE',b'IVE2',b'VCOD']}
S[b'VER ']=st.pack('<H',205);S[b'TYPE']=b'RAWB'
S[b'OWNR']=S[b'IOWN']=bytes([6]*5+[5]*3+[0]*4)
S[b'SIDE']=bytes([1]*5+[0,0,1,7,7,7,4])
S[b'COLR']=bytes([0,1,2,3,4,6,7,5])
S[b'ERA ']=st.pack('<H',6);S[b'DIM ']=st.pack('<HH',128,128)
name=sid('마린키우기 서리선 원정 1.0')
desc=sid('1~5인 협동 / 128x128 / Use Map Settings\n사냥·성장·군락 돌파·보스전. 전초기지를 지켜라!\n원작 참고: 쥬림산맥 (픽시브 / 지형 스나이퍼광)\n새 시나리오·지형·트리거: Codex')
S[b'SPRP']=st.pack('<HH',name,desc)
S[b'FORC']=bytes([0]*5+[1,1,2])+st.pack('<4H',sid('서리선 원정대'),sid('빙하 군단'),sid('전초기지'),sid(''))+bytes([0x0b,0x0b,0,0])
# Arctic and Jungle share their basic terrain family topology (Chkdraft sc.h).
# Reuse only original flat ground tile pairs: jungle dirt -> arctic snow.
source_tiles=st.unpack('<65536H',src[b'MTXM'])
snow_pairs=sorted({(source_tiles[y*256+x],source_tiles[y*256+x+1]) for y in range(256) for x in range(0,254,2) if source_tiles[y*256+x]//16==2 and source_tiles[y*256+x+1]//16==3})
assert snow_pairs
# A new S-shaped expedition route, with side hunting grounds and a wide southern hub.
paths=[[(64,103),(39,91),(24,73)],[(24,73),(48,70),(75,82),(101,61)],[(101,61),(90,42),(65,24)],[(65,24),(64,12)]]
def distance(x,y,a,b):
    dx=b[0]-a[0];dy=b[1]-a[1];q=max(0,min(1,((x-a[0])*dx+(y-a[1])*dy)/(dx*dx+dy*dy)))
    return math.hypot(x-a[0]-q*dx,y-a[1]-q*dy)
# Ground texture stays entirely walkable. Ice shelves are isolated decorative obstacles.
lakes=[(17,22,12,9),(38,43,9,13),(64,53,10,8),(110,24,10,12),(13,104,6,8),(111,92,7,9)]
terrain=[];materials=[]
for y in range(128):
    for x in range(0,128,2):
        cx=x+1;route=min(distance(cx,y,a,b) for line in paths for a,b in zip(line,line[1:]))
        lake=any(((cx-a)/rx)**2+((y-b)/ry)**2 < 1+0.09*math.sin(y*0.8) for a,b,rx,ry in lakes)
        hub=28<=x<=100 and 96<=y<=123
        if lake:
            variant=rng.randrange(6);pair=(96+variant,112+variant);mat='ice'
        elif route<4.5 or hub or any(math.hypot(cx-a,y-b)<10 for a,b in [(24,73),(101,61),(65,24)]):
            variant=rng.randrange(6);pair=(128+variant,144+variant);mat='dirt'
        else: pair=rng.choice(snow_pairs);mat='snow'
        terrain.extend(pair);materials.extend([mat,mat])
S[b'MTXM']=S[b'TILE']=st.pack('<16384H',*terrain)
# Rectangular tile editing is intentional; omit ISOM rather than stale isometric data.
S[b'MASK']=bytes(128*128);S[b'DD2 ']=b'';S[b'THG2']=b''
locs={};locdata=bytearray(5100)
def loc(name,x,y,w=4,h=4):
    n=len(locs)+1;rect=(int((x-w/2)*32),int((y-h/2)*32),int((x+w/2)*32),int((y+h/2)*32))
    assert all(0<=q<=4096 for q in rect)
    locs[name]={'id':n,'rect':rect,'center':(x,y)}
    st.pack_into('<4IHH',locdata,(n-1)*20,*rect,sid(name),0)
    return n
BASE=loc('전초기지 / 회복',64,102,36,13)
CORE=loc('서리선 동력로',64,108,6,5)
HOME=loc('보급관 대기',64,119,12,3)
SHOPS=[loc(n,x,114,4,4) for n,x in [('마린 250 / 최대 12',38),('의무관 200 / 최대 3',54),('정예마린 2000 / 최대 2',74),('전원귀환 100',90)]]
NESTS=[loc(n,x,y,8,8) for n,x,y in [('1. 백야 군락',24,73),('2. 동상 군락',101,61),('3. 영구동토 군락',65,24)]]
BOSS=loc('서리왕 봉인지',64,12,10,8)
HUNTS=[loc('서쪽 사냥터',24,86,12,8),loc('동쪽 사냥터',104,78,12,8)]
SPAWN=[loc(f'P{p+1} 집결지',48+p*8,101,4,4) for p in range(5)]
ANY=64
st.pack_into('<4IHH',locdata,63*20,0,0,4096,4096,sid('Anywhere'),0)
S[b'MRGN']=bytes(locdata)
units=[];unitmeta=[]
def unit(typ,p,x,y,inv=False):
    assert 1<=x<127 and 1<=y<127
    assert materials[int(y)*128+int(x)]!='ice',(typ,x,y)
    units.append(st.pack('<I6H4BI2H2I',len(units)+1,int(x*32),int(y*32),typ,0,0x10,0x0f,p,100,100,100,0,0,16 if inv else 0,0,0))
    unitmeta.append({'type':typ,'owner':p,'x':x,'y':y,'invincible':inv})
for p in range(5):
    unit(214,p,48+p*8,101)
    unit(122,p,36+p*14,122,True)
    unit(116,p,36+p*14,93,True)  # Science Facility: prerequisite for infantry upgrade levels 2+.
    # Civilians and combat units are trigger-created, so empty slots leave no troops.
unit(106,7,64,108)
for x in [44,84]:unit(124,7,x,104,True)
for x in [38,54,74,90]:unit(164,7,x,114,True)
for k,((x,y),typ) in enumerate(zip([(24,73),(101,61),(65,24)],[131,132,133])):
    unit(typ,5,x,y,k>0)
    for dx,dy in [(-5,0),(5,0),(0,-5)]:unit(146,5,x+dx,y+dy)
    for j in range(8+4*k):
        ang=j*math.tau/(8+4*k);unit([37,38,39][k],5,x+7*math.cos(ang),y+7*math.sin(ang))
for l in HUNTS:
    x,y=next(v['center'] for v in locs.values() if v['id']==l)
    for j in range(8):unit(37,5,x-4+j,y)
# Neutral outpost dressing, away from combat corridors.
for x,y in [(33,107),(95,107),(45,117),(83,117)]:unit(109,7,x,y,True)
S[b'UNIT']=b''.join(units)
# Unit availability: only triggers recruit; engineering bays still research upgrades.
S[b'PUNI']=bytes(228*12)+bytes(228)+bytes([1])*(228*12)
u=bytearray(4168);u[:228]=bytes([1])*228
stats={
0:(360,2,250,0,'원정대 마린'),20:(1800,6,2000,0,'극지 정예마린'),34:(300,2,200,0,'원정대 의무관'),15:(100,0,0,0,'보급관: 신호소로 이동하여 구매'),
106:(12000,8,0,0,'서리선 동력로 - 파괴 시 패배'),122:(1500,5,0,0,'공방 연구소 - 최대 30단계'),
37:(140,0,0,0,'눈먼 추적자'),38:(320,2,0,0,'빙하 사냥꾼'),39:(1600,5,0,0,'설원 파괴자'),
48:(24000,10,0,0,'서리왕 아르켈'),131:(6000,3,0,0,'백야 군락'),132:(11000,5,0,0,'동상 군락'),133:(18000,8,0,0,'영구동토 군락'),146:(900,2,0,0,'빙결 촉수')}
for typ,(hp,armor,ore,gas,label) in stats.items():
    u[typ]=0;st.pack_into('<I',u,228+typ*4,hp*256);u[1596+typ]=armor
    for off,val in [(1824,24),(2280,ore),(2736,gas),(3192,sid(label))]:st.pack_into('<H',u,off+typ*2,val)
for wid,damage,bonus in [(0,24,4),(1,84,8),(35,10,1),(38,24,2),(40,55,3),(41,110,5),(53,35,2)]:
    st.pack_into('<H',u,3648+wid*2,damage);st.pack_into('<H',u,3908+wid*2,bonus)
S[b'UNIx']=bytes(u)
up=bytearray(2318)
for p in range(12):
    for upgrade in [0,7]:up[p*61+upgrade]=30 if p<5 else 0
    up[p*61+16]=1;up[732+p*61+16]=1
S[b'PUPx']=bytes(up)
cost=bytearray(794);cost[:61]=bytes([1])*61
for upgrade in [0,7]:
    cost[upgrade]=0
    for off,val in [(62,100),(184,60),(306,0),(428,0),(550,48),(672,0)]:st.pack_into('<H',cost,off+upgrade*2,val)
S[b'UPGx']=bytes(cost)
tech=bytearray(1672)
# Stim and Healing unlocked; disable unrelated spell/research options.
for p in range(12):
    for techid in [0,34]:tech[p*44+techid]=1;tech[528+p*44+techid]=1
S[b'PTEx']=bytes(tech)
S[b'TECx']=bytes([1])*44+bytes(352)
S[b'UPRP']=bytes(1280);S[b'UPUS']=bytes(64);S[b'WAV ']=bytes(2048);S[b'SWNM']=bytes(1024)
trigs=[];labels=[]
def trig(label,players,conds,acts,preserve=False):
    trigs.append(t.Trigger(players,conds,acts+([t.PreserveTrigger()] if preserve else [])));labels.append(label)
def msg(text):return t.DisplayText(sid(text))
def dc(unit,cmp,n,p=7):return t.Deaths(p,cmp,n,unit)
def setdc(unit,n,p=7):return t.SetDeaths(p,t.SetTo,n,unit)
# Death counters: 200 stage, 201 live slot count, 202 wave tick, 203 camp tick,
# 204 payout tick, 205 outcome (0 active / 1 victory / 2 defeat), 206 pulse,
# 207 initialised; personal 210 respawn, 211-214 mission rewards; 215 shop latch.
active=[dc(205,t.Exactly,0)]
objective='\x07[서리선 원정]\x04\n1. 백야 → 2. 동상 → 3. 영구동토 군락 파괴\n마지막으로 북쪽 서리왕 처치. 동력로 파괴 시 패배.\n보급관을 남쪽 신호소로 이동: 마린250 / 의무관200 / 정예2000 / 귀환100\n개인 연구소에서 공방 강화(최대30). 전초기지에서 자동 회복.\n전투점수100 = 광물35 자동 환전. 10초마다 광물25.\n전멸하면 약12초 뒤 무료 재정비. 정예마린은 자동 복구되지 않습니다.'
for p in range(5):
    allies=[t.SetAllianceStatus(q,t.Ally) for q in list(range(5))+[7]]
    trig(f'init_player_{p}',[p],[],allies+[t.SetAllianceStatus(5,t.Enemy),t.SetAllianceStatus(6,t.Enemy),t.RunAIScript(b'+Vi7'),t.SetResources(p,t.SetTo,650,t.Ore),t.CreateUnit(4,0,SPAWN[p],p),t.CreateUnit(1,34,SPAWN[p],p),t.CreateUnit(1,15,HOME,p),t.SetInvincibility(t.Enable,15,p,ANY),t.SetDeaths(7,t.Add,1,201),t.SetMissionObjectives(sid(objective)),msg(objective),t.CenterView(SPAWN[p])])
for p in [5,6]:
    trig(f'init_enemy_{p}',[p],[],[t.SetAllianceStatus(q,t.Enemy) for q in list(range(5))+[7]]+[t.SetAllianceStatus(5,t.Ally),t.SetAllianceStatus(6,t.Ally)])
trig('init_controller',[7],[],[t.SetAllianceStatus(q,t.Ally) for q in range(5)]+[t.RunAIScript(f'+Vi{q}'.encode()) for q in range(5)]+[t.SetAllianceStatus(5,t.Enemy),t.SetAllianceStatus(6,t.Enemy),setdc(200,1),setdc(207,1),t.LeaderBoardScore(t.Custom,sid('원정 전투 공헌')),t.LeaderBoardComputerPlayers(t.Disable)])
# Scale objective health once according to occupied human slots (36/52/68/84/100%).
for n in range(1,6):
    trig(f'scale_{n}',[7],[dc(201,t.Exactly,n)],[t.ModifyUnitHitPoints(t.All,typ,5,ANY,20+16*n) for typ in [131,132,133]])
# Core death precedes victory, to define simultaneous destruction consistently.
trig('core_destroyed',[7],active+[t.Command(7,t.Exactly,0,106)],[setdc(205,2)])
for p in range(5):
    trig(f'defeat_{p}',[p],[dc(205,t.Exactly,2)],[msg('\x08동력로가 파괴되었습니다. 원정 실패.'),t.Defeat()])
    trig(f'victory_{p}',[p],[dc(205,t.Exactly,1)],[msg('\x07서리왕 격파! 서리선 원정을 완수했습니다.'),t.Victory()])
# Every human receives their own stage rewards, never payments to empty slots.
for k,typ in enumerate([131,132,133],1):
    acts=[setdc(200,k+1)]
    if k<3:acts += [t.SetInvincibility(t.Disable,[131,132,133][k],5,ANY)]
    else:acts += [t.CreateUnit(1,48,BOSS,5)]
    trig(f'objective_{k}',[7],active+[dc(200,t.Exactly,k),t.Command(5,t.Exactly,0,typ)],acts)
for n in range(1,6):
    trig(f'boss_scale_{n}',[7],[dc(200,t.Exactly,4),dc(201,t.Exactly,n)],[t.ModifyUnitHitPoints(t.All,48,5,ANY,20+16*n),t.Order(48,5,ANY,t.Attack,CORE)])
trig('final_boss_dead',[7],active+[dc(200,t.Exactly,4),t.Command(5,t.Exactly,0,48)],[setdc(205,1)])
for p in range(5):
    for k in range(1,4):
        trig(f'reward_{p}_{k}',[p],[dc(200,t.AtLeast,k+1)],[t.SetResources(p,t.Add,400+200*k,t.Ore),msg(f'\x07{k}군락 파괴! 광물 {400+200*k} 지급. '+('북쪽 봉인지에서 서리왕이 깨어났습니다!' if k==3 else '다음 군락의 봉인이 해제되었습니다.'))])
    # Convert all kill/razing score in chunks without losing overflow.
    for chunk in [10000,2000,500,100]:
        trig(f'convert_{p}_{chunk}',[p],active+[t.Score(p,t.KillsAndRazings,t.AtLeast,chunk)],[t.SetScore(p,t.Subtract,chunk,t.KillsAndRazings),t.SetScore(p,t.Add,chunk,t.Custom),t.SetResources(p,t.Add,chunk*35//100,t.Ore)],True)
    for score,reward,label in [(1000,300,'숙련 원정병'),(5000,700,'설원 베테랑'),(15000,1500,'서리선 수호자')]:
        trig(f'rank_{p}_{score}',[p],[t.Score(p,t.Custom,t.AtLeast,score)],[t.SetResources(p,t.Add,reward,t.Ore),msg(f'\x07{label} 달성! 보너스 광물 {reward}.')])
    trig(f'heal_{p}',[p],active,[t.ModifyUnitHitPoints(t.All,typ,p,BASE,100) for typ in [0,20,34]]+[t.ModifyUnitEnergy(t.All,34,p,BASE,100)],True)
    trig(f'pay_{p}',[p],active+[dc(204,t.Exactly,5)],[t.SetResources(p,t.Add,25,t.Ore)],True)
    noarmy=[t.Command(p,t.Exactly,0,typ) for typ in [0,20]]
    trig(f'respawn_tick_{p}',[p],active+noarmy,[t.SetDeaths(p,t.Add,1,210)],True)
    trig(f'respawn_{p}',[p],active+noarmy+[dc(210,t.AtLeast,6,p)],[t.RemoveUnit(34,p),t.CreateUnit(3,0,SPAWN[p],p),t.CreateUnit(1,34,SPAWN[p],p),setdc(210,0,p),msg('\x07재정비 완료. 전초기지에 마린 3명과 의무관이 도착했습니다.')],True)
    for typ in [0,20]:trig(f'respawn_reset_{p}_{typ}',[p],[t.Command(p,t.AtLeast,1,typ)],[setdc(210,0,p)],True)
    # Latch resets first. One civilian visit causes at most one purchase or error.
    trig(f'shop_latch_{p}',[p],[],[setdc(215,0,p)],True)
    for j,(typ,price,cap) in enumerate([(0,250,12),(34,200,3),(20,2000,2)]):
        here=[t.Bring(p,t.AtLeast,1,15,SHOPS[j]),dc(215,t.Exactly,0,p)]
        end=[t.MoveUnit(t.All,15,p,ANY,HOME),setdc(215,1,p)]
        trig(f'buy_{p}_{typ}',[p],active+here+[t.Accumulate(p,t.AtLeast,price,t.Ore),t.Command(p,t.AtMost,cap-1,typ)],[t.CreateUnit(1,typ,SPAWN[p],p),t.SetResources(p,t.Subtract,price,t.Ore),msg(f'\x07병력 충원 완료 (-{price}).')]+end,True)
        trig(f'cap_{p}_{typ}',[p],active+here+[t.Command(p,t.AtLeast,cap,typ)],[msg(f'\x06이 병종의 최대 보유 수는 {cap}입니다.')]+end,True)
        trig(f'poor_{p}_{typ}',[p],active+here+[t.Accumulate(p,t.AtMost,price-1,t.Ore)],[msg(f'\x06광물이 부족합니다. {price} 필요.')]+end,True)
    here=[t.Bring(p,t.AtLeast,1,15,SHOPS[3]),dc(215,t.Exactly,0,p)]
    end=[t.MoveUnit(t.All,15,p,ANY,HOME),setdc(215,1,p)]
    trig(f'recall_{p}',[p],active+here+[t.Accumulate(p,t.AtLeast,100,t.Ore)],[t.MoveUnit(t.All,typ,p,ANY,SPAWN[p]) for typ in [0,20,34]]+[t.SetResources(p,t.Subtract,100,t.Ore),msg('\x07전투 병력 전원 귀환.')]+end,True)
    trig(f'recall_poor_{p}',[p],active+here+[t.Accumulate(p,t.AtMost,99,t.Ore)],[msg('\x06귀환 비용: 광물 100.')]+end,True)
# Standard trigger cadence (~2 game seconds); no Wait actions or hyper-trigger conflicts.
trig('pay_reset',[7],[dc(204,t.AtLeast,5)],[setdc(204,0)],True)
for counter in [202,203,204,206]:trig(f'clock_{counter}',[7],active,[t.SetDeaths(7,t.Add,1,counter)],True)
# First raid after ~60 game seconds, then every ~30; enemy cap bounds accumulation.
for stage in range(1,5):
    spawn=NESTS[min(stage-1,2)]
    for n in range(1,6):
        acts=[t.CreateUnit(2+n+stage,37,spawn,6)]
        if stage>=2:acts += [t.CreateUnit(n+stage,38,spawn,6)]
        if stage>=3:acts += [t.CreateUnit(stage-2,39,spawn,6)]
        acts += [t.Order(230,6,ANY,t.Attack,CORE),setdc(202,0)]
        trig(f'wave_s{stage}_p{n}',[7],active+[t.ElapsedTime(t.AtLeast,60),dc(202,t.AtLeast,15),dc(200,t.Exactly,stage),dc(201,t.Exactly,n),t.Command(6,t.AtMost,60,230)],acts,True)
# Hunting reserves replenish locally, so there is always a way to recover economically.
for j,l in enumerate(HUNTS):
    trig(f'hunt_{j}',[7],active+[dc(203,t.AtLeast,15),t.Bring(5,t.AtMost,3,230,l),t.Command(5,t.AtMost,130,230)],[t.CreateUnit(5,37,l,5),t.CreateUnit(2,38,l,5)],True)
trig('hunt_reset',[7],[dc(203,t.AtLeast,15)],[setdc(203,0)],True)
trig('orders',[7],active+[dc(206,t.AtLeast,5)],[t.Order(230,6,ANY,t.Attack,CORE),setdc(206,0)],True)
S[b'TRIG']=b''.join(trigs)
# Briefing actions use their own opcode table, not gameplay action IDs.
brieftext=sid('서리선 원정 | 1~5인 협동\n\n사냥과 연구로 원정대를 성장시키고 세 군락과 서리왕을 처치하세요.\n남쪽 신호소: 마린250 / 의무관200 / 정예2000 / 귀환100\n기지에서 회복하며 동력로를 지키세요.\n\n원작 참고: 쥬림산맥 - 픽시브 / 스나이퍼광\n새 맵 제작: Codex')
S[b'MBRF']=t.Trigger(list(range(5)),[t.Condition(0,0,0,0,0,13,0,0)],[t.Action(0,brieftext,0,0,0,0,0,4,0,0),t.Action(0,brieftext,0,12000,0,0,0,3,0,0)])
encoded=[s.encode('utf-8')+b'\0' for s in strings]
off=2+2*len(encoded);offsets=[]
for s in encoded:offsets.append(off);off+=len(s)
assert off<65536
S[b'STR ']=st.pack('<H',len(encoded))+st.pack('<'+'H'*len(offsets),*offsets)+b''.join(encoded)
raw=b''.join(k+st.pack('<I',len(v))+v for k,v in S.items())
HERE.mkdir(exist_ok=True)
(HERE/'scenario.chk').write_bytes(raw)
if OUTPUT.exists():OUTPUT.unlink()
m=mpqapi.MPQ.create(str(OUTPUT));m.add_file('staredit\\scenario.chk',str(HERE/'scenario.chk'));m.compact();del m
back=mpqapi.MPQ.open(str(OUTPUT)).extract_file('staredit\\scenario.chk');assert back==raw
manifest={'output':OUTPUT.name,'source':SOURCE.name,'source_sha256':hashlib.sha256(SOURCE.read_bytes()).hexdigest(),'output_sha256':hashlib.sha256(OUTPUT.read_bytes()).hexdigest(),'dimensions':[128,128],'tileset':'Arctic','players':'1-5 cooperative','units':len(units),'triggers':len(trigs),'strings':len(strings),'locations':locs,'trigger_labels':labels,'unit_placements':unitmeta,'materials':materials,'source_terrain_pairs':snow_pairs,'source_dimensions':[256,256],'source_units':len(src[b'UNIT'])//36,'source_triggers':len(src[b'TRIG'])//2400}
(HERE/'manifest.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2))
print(json.dumps({k:manifest[k] for k in ['output','dimensions','units','triggers','strings','source_sha256']},ensure_ascii=False,indent=2))
