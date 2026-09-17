import re,sys,subprocess,os
s=open('atlas.html',encoding='utf-8').read()
blocks=re.findall(r'<script>\n(.*?)\n</script>', s, re.S)
print("blocks:",len(blocks))
ok=True
for i,b in enumerate(blocks):
    fn=f'/tmp/blk{i}.js'
    open(fn,'w',encoding='utf-8').write(b)
    r=subprocess.run(['node','--check',fn],capture_output=True,text=True)
    if r.returncode!=0:
        ok=False
        print(f'--- block {i} FAILED ---')
        print(r.stderr[:3000])
    else:
        print(f'block {i} OK ({len(b.splitlines())} lines)')
sys.exit(0 if ok else 1)
