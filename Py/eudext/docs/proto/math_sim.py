import math, random
M=0xFFFFFFFF
def eud_atan2(y,x):
    # eudplib 0.76.14 f_atan2 (degrees) simulated on unsigned 32-bit
    y&=M; x&=M; s=0
    if x>=0x80000000: s+=1; x=(-x)&M
    if y>=0x80000000: s+=2; y=(-y)&M
    if y>=x: s+=4; x,y=y,x
    if x>=400:
        d=x//400+1; x//=d; y//=d
    t1=(x*x)&M
    t2=(y*((45*t1 - ((y-x)&M)*((14*x+4*y)&M))&M))&M
    t3=(x*t1)&M
    a=t2//t3 if t3 else 0xFFFFFFFF
    tbl={0:a,1:180-a,2:360-a,3:180+a,4:90-a,5:90+a,6:270+a,7:270-a}
    return tbl[s]&M
def ctrig_atan2(y,x,cycle=360):
    R=cycle//4
    q=1
    if y<0 and x<0: q=3; y=-y; x=-x
    elif y<0: q=4; y=-y
    elif x<0: q=2; x=-x
    r=(y<<16)//x if x else 0xFFFFFFFF
    th=R
    for i in range(R):
        if r <= int(0x10000*math.tan(math.radians(i*90/R))): th=i; break
    if q==2: th=2*R-th
    elif q==3: th=th+2*R
    elif q==4: th=4*R-th
    return th
def angdiff(a,b,c=360):
    d=(a-b)%c
    return min(d,c-d)
random.seed(1)
worst_e=worst_c=0; ex=cx=None
for _ in range(200000):
    x=random.randint(-32768,32767); y=random.randint(-32768,32767)
    if x==0 and y==0: continue
    true=math.degrees(math.atan2(y,x))%360
    e=eud_atan2(y,x); c=ctrig_atan2(y,x)
    de=angdiff(e,true); dc=angdiff(c,true)
    if de>worst_e: worst_e,ex=de,(x,y,e,true)
    if dc>worst_c: worst_c,cx=(dc,(x,y,c,true))
print("eudplib f_atan2 worst abs err deg: %.3f at %s"%(worst_e,ex))
print("ctrig f_Atan2(360) worst abs err deg: %.3f at %s"%(worst_c,cx))
# small vectors
for v in [(1,1),(1,2),(3,1),(0,5),(-1,0),(0,-1),(1,-1000)]:
    y,x=v
    print(v, "eud",eud_atan2(y,x),"ctrig",ctrig_atan2(y,x),"true %.2f"%(math.degrees(math.atan2(y,x))%360))
# eudplib f_lengthdir overflow / negative
def eud_ld(L,a):
    L&=M; a&=M
    if a>=360: a%=360
    if a<=89: s=0; t=a
    elif a<=179: s=1; t=180-a
    elif a<=269: s=3; t=a-180
    else: s=2; t=360-a
    cosv=math.floor(math.cos(math.radians(t))*65536+0.5); sinv=math.floor(math.sin(math.radians(t))*65536+0.5)
    x=((cosv*L)&M)//65536; y=((sinv*L)&M)//65536
    if s&1: x=(-x)&M
    if s&2: y=(-y)&M
    sx = x-2**32 if x>=2**31 else x; sy = y-2**32 if y>=2**31 else y
    return sx,sy
print("eud lengthdir(100,-90) ->", eud_ld(100,-90), " expect (0,-100)")
print("eud lengthdir(-100,0) ->", eud_ld(-100,0), " expect (-100,0)")
print("eud lengthdir(65535,0) ->", eud_ld(65535,0), " ; (65536,0) ->", eud_ld(65536,0))
print("eud lengthdir(100,45) ->", eud_ld(100,45))
